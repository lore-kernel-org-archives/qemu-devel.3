Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CBEEA812C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppV7-0001A6-BO; Tue, 10 Feb 2026 10:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vppUz-00015c-RC
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:17:58 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vppUx-0007el-MY
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770736672; x=1771341472; i=deller@gmx.de;
 bh=S2tm7jCSKYX8b7xo0wdoEx593nJ0m2Y/T9ShnuNWfa4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Wq934wi895IuOCeRdq/q7x+7ClJCipiuvl4jkvkKAQV23JwrDgGPPZvtJGd7X/72
 d50EKkwydAvBKUWAj42CUKuPE9IYtGx15i7PFQ1TmUXTC78kRQ9EJZIA4GzGMhvj+
 V1zyTDmcE6J2OMNkHjvRF3iW1u42vkxzy4+qCEFx3xaz6saqqJHxCJyYsm09aJhzd
 aRug6VWRq8M1TBqnWQWyrsaZp7QMBWqRd5bEtkllghroKXPCqSnrGzLF4CGNOsyfZ
 D6gEw6RW5RYPAChv3tFMvIg3s6xViTqalIU+6KnZv5LYPBGezkLjYgd75tMZ1EruJ
 SQ8c+QfirnwAwIdZOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.36]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1w1h41088j-005dYm; Tue, 10
 Feb 2026 16:17:52 +0100
Message-ID: <a9bc4177-5b73-47e2-ab74-ef6b64fefdcd@gmx.de>
Date: Tue, 10 Feb 2026 16:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix TIOCGSID ioctl
To: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <mvmtsvp9cpk.fsf@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <mvmtsvp9cpk.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2/XRs4wvQXn1G5keRss59NQBeMbc51i9tDT/5y5xctBcCVyvhEq
 j2Sn6LNimXqM1FL9z1+g2Z+cmMtMzrzNvzvKvHCHrknsOkF9eFCzBZr/bP4B8a8rf4PYeLz
 ++oARq9hq47qKfnxWqwBCbomeOphqMFXE/4RC1qQFTByi3MzETMGYQCKM1o6Ects59oKSIF
 o0vYj4TQcntkADfjhzLuw==
UI-OutboundReport: notjunk:1;M01:P0:2+mKHXqG/Lw=;A0N0KKnwat3uOblzWLmqUcTxEj+
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/10/26 10:20, Andreas Schwab wrote:
> TIOCGSID is IOC_R, not IOC_W.
>=20
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   linux-user/ioctls.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 6ecfe6306e..5b7d00e92f 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -26,7 +26,7 @@
>        IOCTL(TIOCSCTTY, 0, TYPE_INT)
>        IOCTL(TIOCGPGRP, IOC_R, MK_PTR(TYPE_INT))
>        IOCTL(TIOCSPGRP, IOC_W, MK_PTR(TYPE_INT))
> -     IOCTL(TIOCGSID, IOC_W, MK_PTR(TYPE_INT))
> +     IOCTL(TIOCGSID, IOC_R, MK_PTR(TYPE_INT))
>        IOCTL(TIOCOUTQ, IOC_R, MK_PTR(TYPE_INT))
>        IOCTL(TIOCSTI, IOC_W, MK_PTR(TYPE_INT))
>        IOCTL(TIOCMGET, IOC_R, MK_PTR(TYPE_INT))


