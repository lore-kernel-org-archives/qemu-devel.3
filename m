Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29322CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEphj-0002Ah-Vf; Fri, 31 Oct 2025 10:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEphX-00029n-1Y
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:01:59 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEphK-0003nv-HE
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:01:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8E8D6807CC;
 Fri, 31 Oct 2025 17:01:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id c1hfoZ0GwiE0-raguRvrm; Fri, 31 Oct 2025 17:01:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761919299;
 bh=j6WcXX6lxijZ+9vvcMp+oH+u4s48EdpmOphBZQ3Ld58=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=POLlzMPdaAT+UqFvWcWZVmdwuVm877c9EXDx9uZHErv8eeaZRcyhqKXMfZEFZDMh9
 mK1BzdLITuLeSnsrIrJzsM8D/r04hXaX8cXJodBNxO8h9i4c4LJUqGtnw2ubxYoe9I
 yI/RgTifTCj+o3quA7hLjaF2Nj0FpgyxT7f98e8Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a550c681-f6eb-47c2-9acb-e202adb6029f@yandex-team.ru>
Date: Fri, 31 Oct 2025 17:01:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev/char-file: fix failure path
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20251014145029.949285-1-vsementsov@yandex-team.ru>
 <CAJ+F1CLis2mgWw4R+X1+5MhhuQ09OTCbWsxZgqsx9VZSP1CfNA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJ+F1CLis2mgWw4R+X1+5MhhuQ09OTCbWsxZgqsx9VZSP1CfNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.10.25 17:53, Marc-André Lureau wrote:
> On Tue, Oct 14, 2025 at 6:51 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>> 'in' will be -1 when file->in is unset. Let's not try to close
>> invalid fd.
>>
>> Reported-by: Peter Maydell<peter.maydell@linaro.org>
>> Coverity: CID 1630444
>> Fixes: 69620c091d62f "chardev: qemu_chr_open_fd(): add errp"
>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>

Hi, isn't it lost? It's still not in master.. Or did you queued already?


-- 
Best regards,
Vladimir

