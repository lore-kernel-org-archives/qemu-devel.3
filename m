Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC5D20688
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 13:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR9Tu-0006fO-H8; Thu, 04 Dec 2025 08:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vR9Ts-0006eu-J9
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 08:34:48 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vR9Tq-0004Im-Eh
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 08:34:48 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9FECB808D3;
 Thu, 04 Dec 2025 16:34:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:83c::1:2e] (unknown
 [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eYlXKV0FEGk0-Vnud6CXD; Thu, 04 Dec 2025 16:34:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764855281;
 bh=FsTMsvDremFPXxKXNnxmryWSKDz+goQXarv6+CpTt1c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FEHrB+EdmQ/j3hlhil2DyZHJx9wCWXWK75s8PZKjZT3wVhnHLNRFAbwQVqfkCDRiH
 riOtYFJVkZ0n+V5PfYF81kFd+NUATyYNUzPjl/xepm9MGuPm2xoDeqZk6MH4m//Obh
 oKisY5ZDmDWVKhDyvgxMYIm7ylZTcM72loiwp8K8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b9f48b03-c1e7-4d5e-ae3c-4e5cb265c963@yandex-team.ru>
Date: Thu, 4 Dec 2025 16:34:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] chardev: .chr_open(): drop be_opened parameter
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
 <20251129134350.487839-4-vsementsov@yandex-team.ru>
 <CAMxuvaxA3FQO0PXpk8jJhP-nqeXADKPf-1orOkee9ES0_CHNKw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAMxuvaxA3FQO0PXpk8jJhP-nqeXADKPf-1orOkee9ES0_CHNKw@mail.gmail.com>
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

On 01.12.25 15:57, Marc-André Lureau wrote:
>       {
>           ChardevSpiceChannel *spicevmc = backend->u.spicevmc.data;
>     @@ -277,19 +275,17 @@ static void spice_vmc_chr_open(Chardev *chr,
>               return;
>           }
> 
>     -    *be_opened = false;
>       #if SPICE_SERVER_VERSION < 0x000e02
>           /* Spice < 0.14.2 doesn't explicitly open smartcard chardev */
>           if (strcmp(type, "smartcard") == 0) {
>     -        *be_opened = true;
>     +        chr_open(chr, type);
>     +        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>           }
>       #endi
> 
> 
> Can you add a preliminary patch to drop support for spice < 0.15 ?
> According to repology:
> debian_13: 0.15.2
> fedora_42: 0.15.1
> opensuse_leap_15_4: 0.15.0
> ubuntu_22_04: 0.15.0


Will do. Thanks for reviewing!

-- 
Best regards,
Vladimir

