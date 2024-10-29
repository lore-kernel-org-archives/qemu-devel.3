Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1544AD3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5noT-0004ny-DO; Tue, 29 Oct 2024 11:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5noR-0004n5-IO
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:07:15 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5noP-0006yC-JC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:07:15 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb388e64b0so54956131fa.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214430; x=1730819230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EGEbjh5u6szWNHkRhl2caYH8N/sQ0kH2YYfs9KEO8fQ=;
 b=NXsdzKnh+eUboz7lhokAzmQuIqT2ixeAUjMXolw6Hn+Nx5J0ZTELyiU8zhZj4j95/7
 CXNT9Sj9M6KQdfSGdJtjQsQqg1ZSnUtvjPbGUbn4OdtlLhnSvYTfgYruKygpamyaBIOs
 LjMTykid59+w5P92Q5xZf9nT93IrjcN3oEfh38J39aOuCFb1hCGw1E6WNGhFxl5dtpjV
 Tm4ZJMKa6oIHL5W2B6X4jjWtpqSKdrV+FYSOIG9E6sMiwYMVfTpEJU58NZ4U2Zeu4SiQ
 kXzWwwB6Aqs3iGfmgECJ4uGfaVEZOz8ET4uHjxDSyvy79iudWnqpfxH2qumJw7ayhmcu
 cYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214430; x=1730819230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGEbjh5u6szWNHkRhl2caYH8N/sQ0kH2YYfs9KEO8fQ=;
 b=d7QufFfGSVyrNy4qoMnbRHjDTElF7oOY6OW7vil2PvrArNRbtiMdEl1cCHLGIGJvZ0
 zM1uCOD6joMutyU0hANOxB/YPbXdpOI99C1fTg+3s3yvfGwFjgDj9w6xTFvgUZ88bBiD
 YYrbJmdRNbXQ7OQJJsUPqVcXwMXAYLYqw09qEcgQZGSIneC/aMjoXb2zKa/LDSZ72Ub2
 r9RKl4rnjeBslhIoziPo8Wn6Axvksm1MWQhylDLfEJsKvd3mgrUX0ziyJRpQEAfYgUS6
 K0ohL3sEkCkZi/+qFKFDuLA+ZqOqp0MDeK9Iy0Id4KZnNf2JV/fw73mTSvIgh1UpVND4
 0rRg==
X-Gm-Message-State: AOJu0YxCDQV2zJvbq5QOxoODQojc7WlbaMrBJoYiXHXgJu6Hbm3Ox5eS
 /Xs6vkOo7ppH0uVyHg1ibTTibaPNpLCAL5Te4J9BM2Ppb0bLX5ilZvcb+xDvmFZnOruq04QdO56
 EvpLjcCxBXj/I0nQsl0UiLlBeKDpbOIw1sjOB1A==
X-Google-Smtp-Source: AGHT+IH/6b91sXCwJhDdGuZ3bQhF4amky2goKaaubdjfRVvajfQXO89hspHC+z5NTI04cMzSGSyJkTqOnuvAuw0ML6g=
X-Received: by 2002:a2e:a550:0:b0:2fa:d84a:bd83 with SMTP id
 38308e7fff4ca-2fd0595132cmr606131fa.24.1730214430230; Tue, 29 Oct 2024
 08:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241015135649.4189256-1-jlu@pengutronix.de>
 <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 15:06:56 +0000
Message-ID: <CAFEAcA_a4bYU=KQbKQmWtqvPF3fmtttbhgi0BB0hS1wcCV_U4w@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
To: Jan Luebbe <jlu@pengutronix.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 18 Oct 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 15 Oct 2024 at 14:57, Jan Luebbe <jlu@pengutronix.de> wrote:
> >
> > For testing eMMC-specific functionality (such as handling boot
> > partitions), it would be very useful to attach them to generic VMs such
> > as x86_64 via the sdhci-pci device:
> >  ...
> >  -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
> >  -device sdhci-pci \
> >  -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
> >  ...
> >
> > While most eMMCs are soldered to boards, they can also be connected to
> > SD controllers with just a passive adapter, such as:
> >  https://docs.radxa.com/en/accessories/emmc-to-usd
> >  https://github.com/voltlog/emmc-wfbga153-microsd
> >
> > The only change necessary to make the options above work is to avoid
> > disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
> > kernel already supports this just fine.
> >
> > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>
> Applied to target-arm.next, thanks (unless anybody would
> prefer it to go via some other route).

I'm dropping this from target-arm.next since it seems like
we have a problem with the handling of boot partitions
and how the user should provide an image for an emmc card
that has boot partitions). Since that's an emmc specific
thing, sorting that out with a minimum of breaking
compatibility with previously working setups is going to
be easier if we stay temporarily in the state of "emmc
only happens for the specific board that creates them
and the user can't arbitrarily create them on the
command line".

I expect this to just be a temporary delay while we sort
out in the other thread how emmc boot partitions should work.

thanks
-- PMM

