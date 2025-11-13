Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57513CD4F28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 06:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJRGX-0002qh-If; Thu, 13 Nov 2025 01:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJRGV-0002pH-Av
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 01:57:07 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJRGS-000513-N5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 01:57:07 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 18A20807CA;
 Thu, 13 Nov 2025 09:57:00 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:833::1:4] (unknown [2a02:6bf:8080:833::1:4])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xuJCIC0FKuQ0-kukqUh5S; Thu, 13 Nov 2025 09:56:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763017019;
 bh=0tU6adlJm0bz/I+UD7a+Pc+pMrcgEearvNiPFl8eZ4k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g2ktCPKIbz3pMeeJGql4d+ihCnTRLHlptjXMPNCv0MUY8w/uMlIlRpfV8IrstGEHY
 UYtlFGK7attwx3n444rqnaq0UGrEOY8fjlkmV9pet5BMSAZvk8KaiI5PUzbsN982Vl
 kYZCwZNv8PdmJmNgoD2dekJ8XLd2V8ldvTbRaNiI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ae749c22-96d0-48f1-9b45-5eeba4c74540@yandex-team.ru>
Date: Thu, 13 Nov 2025 09:56:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev/char-file: fix failure path
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20251014145029.949285-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251014145029.949285-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

ping

On 14.10.25 17:50, Vladimir Sementsov-Ogievskiy wrote:
> 'in' will be -1 when file->in is unset. Let's not try to close
> invalid fd.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Coverity: CID 1630444
> Fixes: 69620c091d62f "chardev: qemu_chr_open_fd(): add errp"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> I was going to send it inside v3 of "chardev: postpone connect", but it
> seems the discussion may continue there, so, decided to send this small
> fix in separate.
> 
>   chardev/char-file.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 89e9cb849c..1f7adf592f 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -94,7 +94,9 @@ static void qmp_chardev_open_file(Chardev *chr,
>   
>       if (!qemu_chr_open_fd(chr, in, out, errp)) {
>           qemu_close(out);
> -        qemu_close(in);
> +        if (in >= 0) {
> +            qemu_close(in);
> +        }
>           return;
>       }
>   #endif


-- 
Best regards,
Vladimir

