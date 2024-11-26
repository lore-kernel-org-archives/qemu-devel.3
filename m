Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0A5D3B7CA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 09:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFrnE-0008VP-5u; Tue, 26 Nov 2024 04:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tFrnB-0008VD-VG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 04:23:34 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tFrnA-00015n-0b
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 04:23:33 -0500
Message-ID: <7ae4fdf4-43e0-46e5-a2c3-1377468397a9@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1732613006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5miLtF7v8rk69mDHoZ2uK60wtc37yTWYy5PGKlJTdFA=;
 b=wyxnm/dQiuavz5ko6C69qJS4TkNWZZdLWfwxs79U7NcbrXxx6+1R8epXgV2c7622ZxOknQ
 3J1VxL59hF0uG81aHhoT6hH51cYZfLmRZUxCpCXysv/oqPhgSuuP370HTLsceF0NOyQbzS
 S9Zshwejt6qRJb6VYfbVJIfLWXiQFos=
Date: Tue, 26 Nov 2024 12:23:26 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] hw/timer: fix int underflow
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peter.maydell@linaro.org
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20241106104041.624806-2-frolov@swemel.ru>
 <39d99130-0d3f-4254-86dd-20151e57ec68@linaro.org>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <39d99130-0d3f-4254-86dd-20151e57ec68@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Phil.

On 26.11.2024 11:39, Philippe Mathieu-Daudé wrote:
> Hi Dmitry,
>
> On 6/11/24 11:40, Dmitry Frolov wrote:
>> Both timeout and return value of imx_gpt_update_count() are unsigned.
>> Thus "limit" can not be negative, but obviously it was implied.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>> ---
>>   hw/timer/imx_gpt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
>> index 23b3d79bdb..06e4837fed 100644
>> --- a/hw/timer/imx_gpt.c
>> +++ b/hw/timer/imx_gpt.c
>> @@ -238,7 +238,7 @@ static void 
>> imx_gpt_compute_next_timeout(IMXGPTState *s, bool event)
>>       }
>>         /* the new range to count down from */
>> -    limit = timeout - imx_gpt_update_count(s);
>> +    limit = (long long)timeout - imx_gpt_update_count(s);
>
> You posted similar automatic change in at least 3 different
> code areas.
The patches, I've sent, are not "automatic".
The problems were found by static analyzer in different code
areas, maintained by different people. These problems were
reviewed and fixed by me manually.
> Each time different maintainers made similar
> comments. At this point you should be able to auto-review
> this patch and respin a proper follow up IMHO. Reviewers and
> maintainers time is scarce.
Sorry, if do something wrong.
What is the proper workflow in this case from your point of view?

> Regards,
>
> Phil.

Regards,
Dmitry.
>

