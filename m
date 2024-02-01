Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE55C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXCh-0001vh-Ch; Thu, 01 Feb 2024 08:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXCg-0001v6-2y
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:34:06 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXCe-0007Ty-97
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:34:05 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55fcceb5f34so317752a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706794443; x=1707399243; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=io87DHhBMjJIuCrn/6iiYfrsoMeo6aQOZ9fSI+L5OJg=;
 b=kPWAHYWKO4EI70yaTPybqSh2mCcSioKnGI6jT++nr9xwMUfr2/AaYmiRa26vV7NzRn
 NG1bc6zPv3A0YflnyYej+/kp+epOMcOkQBIf0ipADh6TrH5+iNIM+rGtZK5eMl6VqRcP
 kx18bVSMH5Or3BxWPW7qh7SwlY18FqopDw1QbWzG5GFmyHcA4KfIxpteHp7sEOe+fo/1
 A9Cb3H1CRUJmxcqt9II49mJIbT+IpK+6sDMaukGNsGUyX1HZA0BS/uv31aO0jU12609J
 83wScOjkshB5JopuyaGTuO9nUtFz+3XhteO8Rj4e7cIJBVElFoJJUGy7UE3VwsRwbQiE
 /5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706794443; x=1707399243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=io87DHhBMjJIuCrn/6iiYfrsoMeo6aQOZ9fSI+L5OJg=;
 b=sQM6L+Jfs5bdLzJFkQTEZWgyV5X0sieUFLhxNluFUxUSGaFLxVhtpYo3Kh7X+Z9+EN
 TJRjQde+/v7j4wbfzJa5AtlQwZ+s0dPEgThtGRh8hrNxQIJIpxVSZ+sn/mC6yYdgbsY+
 KjYn7xBNLNg0luoWimTfLHonGtm8W+C2JrJWUlsVcexR3/ytG2V1v/+3E209DI7PJkKO
 gSC3pUmOb1xJdC+ZNH8S81oi0l+i5yceq8bHjVVLcuVG1h0zBFHeuGqY6CaF72jycnAs
 jhB7MQVsxLDGKgPPskZatzsJDgSmMga3Vb1VVwUq4rUwi0lOACCkbMPEJWcpFAJjHK5L
 b6tQ==
X-Gm-Message-State: AOJu0YxtiuECRMlIzZ9NKlyzZ0AwcOqluV+H6Q+phIZqhgp+Ej9RqJPT
 DqbZ3UEjIxdTed8OuMva+cGg1Q2vR8aYvNHHA6mZC9I2IzDZ4FnYXwKWPDD3CirKqloQFEzFRTD
 9E+BJbo8HVGqLjBlq6cao9srsBMCLaRk94njUWg==
X-Google-Smtp-Source: AGHT+IFEH2aw4DB4LH+E2j6IrvWbB/fYj6offWffTwasH1Y4pUrvWad6gmp+DEn0ewSibR/EdqNIfh94+byV7afRa5k=
X-Received: by 2002:a50:ee19:0:b0:55f:d5a0:749b with SMTP id
 g25-20020a50ee19000000b0055fd5a0749bmr261166eds.39.1706794442744; Thu, 01 Feb
 2024 05:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20240122143537.233498-1-peter.maydell@linaro.org>
In-Reply-To: <20240122143537.233498-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:33:51 +0000
Message-ID: <CAFEAcA_xH=fRR2iTr9+RgiA6n51FCakCsk60z=Mr6XmaujbebQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virt: wire up NS EL2 virtual timer IRQ
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Ping for code review, please?

thanks
-- PMM

On Mon, 22 Jan 2024 at 14:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset wires up the NS EL2 virtual timer IRQ on the virt
> board, similarly to what commit 058262e0a8b2 did for the sbsa-ref board.
>
> Version 1 was an RFC patchset, originally sent back in autumn:
> https://patchew.org/QEMU/20230919101240.2569334-1-peter.maydell@linaro.org/
> The main reason for it being an RFC is that the change, while correct,
> triggers a bug in EDK2 guest firmware that makes EDK2 assert on bootup.
> Since the RFC, we've upgraded our in-tree version of the EDK2 binaries
> to a version that has the fix for that bug, so I think the QEMU side of
> these patches is ready to go in now.
>
> To accommodate users who might still be using older EDK2 binaries,
> we only expose the IRQ in the DTB and ACPI tables for virt-9.0 and
> later machine types.
>
> If you see in the guest:
>      ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48
>
> then your options are:
>  * update your EDK2 binaries to edk2-stable202311 or newer
>  * use the 'virt-8.2' versioned machine type
>  * not use 'virtualization=on'
>
> I'll put something about this into the release notes when this
> goes into git. (There are other reasons why you probably want a
> newer EDK2 for AArch64 guests, so this is worth flagging up to our
> downstream distros who don't take our pre-built firmware binaries.)
>
> changes v1->v2:
>  * the change in DTB and ACPI tables is now tied to the machine version
>  * handle change of the ARCH_TIMER_*_IRQ values from PPI numbers to INTIDs
>  * bump the FADT header to indicate ACPI v6.3, since we might be using
>    a 6.3 feature in the GTDT
>  * the avocado tests now all pass, because we have updated our copy
>    of EDK2 in pc-bios/ to a version which has the fix for the bug
>    which would otherwise cause it to assert on bootup
>  * patch 2 commit message improved to give details of the EDK2 assert and
>    state the options for dealing with it (this will also go into the
>    QEMU release notes)
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   tests/qtest/bios-tables-test: Allow changes to virt GTDT
>   hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
>   tests/qtest/bios-tables-tests: Update virt golden reference
>
>  include/hw/arm/virt.h     |   2 ++
>  hw/arm/virt-acpi-build.c  |  20 +++++++++----
>  hw/arm/virt.c             |  60 ++++++++++++++++++++++++++++++++------
>  tests/data/acpi/virt/FACP | Bin 276 -> 276 bytes
>  tests/data/acpi/virt/GTDT | Bin 96 -> 104 bytes
>  5 files changed, 67 insertions(+), 15 deletions(-)
>

