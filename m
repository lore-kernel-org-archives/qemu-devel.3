Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B621CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArNg-00067I-T3; Mon, 20 Oct 2025 11:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1vAqlg-0004Y5-7C
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:21:50 -0400
Received: from out-171.mta1.migadu.com ([2001:41d0:203:375::ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1vAqlc-0000Fg-Se
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:21:47 -0400
Message-ID: <56d70072-67ee-471a-9b9a-c3257886d668@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760970097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnyTmlzZMiQoNOOywrB+NgZblDfw4hjBofPd+Kb6fVY=;
 b=LcXwnZ5SKHqEQwKTvwmp8rlKm8EdEVY5EoHYT2M91y2wOTXqdqMSh+oWCjHjNbdRkoDjue
 d3/ETl4DRhmy7BxdC6c2W9q0XfZh9bGSjvcop6oXqjsGN7KThSvvDvlTtiih+SVxX8+hXA
 qBKsz/FGufohjxKFDf28kAnSCZGoaWw=
Date: Mon, 20 Oct 2025 10:21:29 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] semihosting: Check for overflow in FLEN on 32-bit
 systems
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-4-sean.anderson@linux.dev>
 <4d1a679a-f1c2-487b-bddb-eaf7dd56fd0e@canonical.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <4d1a679a-f1c2-487b-bddb-eaf7dd56fd0e@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ab;
 envelope-from=sean.anderson@linux.dev; helo=out-171.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Oct 2025 11:00:44 -0400
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

On 10/18/25 03:21, Heinrich Schuchardt wrote:
> On 10/17/25 23:35, Sean Anderson wrote:
>> When semihosting 32-bit systems, the return value of FLEN will be stored
>> in a 32-bit integer. To prevent wraparound, return -1 and set EOVERFLOW.
>> This matches the behavior of stat(2). Static files don't need to be
>> checked, since are always small.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>   semihosting/arm-compat-semi.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
>> index c5a07cb947..57453ca6be 100644
>> --- a/semihosting/arm-compat-semi.c
>> +++ b/semihosting/arm-compat-semi.c
>> @@ -305,8 +305,19 @@ static uint64_t common_semi_flen_buf(CPUState *cs)
>>       return sp - 64;
>>   }
>>   +static void common_semi_flen_cb(CPUState *cs, uint64_t ret, int err)
>> +{
>> +    CPUArchState *env = cpu_env(cs);
>> +
>> +    if (!err && !is_64bit_semihosting(env) && ret > INT32_MAX) {
> 
> 
> The issue with the current implementation is that files with file sizes over 4 GiB will be reported as file size < 4 -GiB on 32bit systems. Thanks for addressing this.
> 
> But unfortunately with your change you are additionally dropping support for file sizes 2 GiB to 4 GiB on 32bit devices. This should be avoided.
> 
> The semihosting specification specifies that the value returned in r0 should be -1 if an error occurs. So on 32 bit systems 0xffffffff should be returned.
> 
> As file sizes cannot be negative there is not reason to assume that the value in r0 has to be interpreted by semihosting clients as signed.
> 
> Please, change your commit to check against 0xffffffff.
> 
> It might make sense to contact ARM to make their specification clearer.

stat(2) will return -1/EOVERFLOW on 32-bit hosts for files over 2 GiB. I believe we should be consistent.

--Sean

