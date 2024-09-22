Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF518CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 13:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssMNI-0000IQ-Jk; Sun, 22 Sep 2024 09:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssMNG-0000HF-55
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 09:11:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssMNE-0001jK-32
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 09:11:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-205659dc63aso28649945ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727010693; x=1727615493; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tWqV25C49dJOPjYj76Xzm9pdqKQQLbrFzDNW/6QsPsc=;
 b=Sts0J3p3BIGWiliV0UarRgfnDi9iydBoQ7gkyUMECzlTee/G8BGTzy1uCWDmjUJCyA
 roMkf5MYNK2V4SndMm+5hH2TMf2Eryfblscl5kZ2HAcGxvb83dBMMBfI5d1D5ZC5SsK0
 OB1zYRbipoxggnZhaCC9odmItn7BYSykVoCBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727010693; x=1727615493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tWqV25C49dJOPjYj76Xzm9pdqKQQLbrFzDNW/6QsPsc=;
 b=uUFTSFogAaKndFQvxkPijQTXnS5sd9gIHtS6AzQwvncBXrqFU2cJ2tG++92MEFLgQ0
 HUMGvP4kJGs7mylKeEHRnG3wmpT4FgPIB6miwPLg/aVehqjp7wqO37kO7693FMh5baOy
 XsajlZfbY7EF181nHhhocxQmUiMuGCTE3c2dHRBPKdSUX/hLJDOl1uTnToU8hosvQwHk
 CdITcEENm0YXg7OJXGaXK1yUxyIWtX5nYpcdyJzYUqvWteYjQdrfj4FSaeQIQ6Z55QgG
 1OqttifDUmfaGGZX8r71px8qX6T5ZADz2rxkeK2uyEQ4GGthdGXGkKXi+due05cRI0Y4
 fbSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaS1IZRsummOQ56TvTJtuJ28ske32taeqgnsjus6gu6Ax2WpRa76BuBDzczRy/iTUayI++uEFcFiR4@nongnu.org
X-Gm-Message-State: AOJu0YxWKJ5237cd9jtR1LnfIAEixHhKfluzc4C3lLvK+P2tATC7t4Yh
 IA6WVQjjoFSQvRDj9cIrvP71L+eCAWVHzrS9l1bW3e0rs5ZrbT3qFqYXYZu6v5VssBJmVExoDss
 =
X-Google-Smtp-Source: AGHT+IHwXvy4QLpVsXTc4br/IE9Oy20keEJFki6zwLRdennxm8hnrHWQRrwtUY4GEAErK7/ThOZEbQ==
X-Received: by 2002:a17:902:ec85:b0:205:968b:31cf with SMTP id
 d9443c01a7336-208d9835ae5mr131398375ad.33.1727010692952; 
 Sun, 22 Sep 2024 06:11:32 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com.
 [209.85.210.181]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2079460138fsm120154085ad.77.2024.09.22.06.11.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Sep 2024 06:11:32 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7198cb6bb02so2497319b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 06:11:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUWppP7yrrrF9GHmzCVKAzVXOu93T8epxKbp3zKP4fVdo+fH4hq5+F9rEd7afmEyQH5HUdJgTFML2/1@nongnu.org
X-Received: by 2002:a17:90a:7806:b0:2d3:d398:3c1e with SMTP id
 98e67ed59e1d1-2dd80e54adfmr10572700a91.36.1727010689387; Sun, 22 Sep 2024
 06:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240814115736.1580337-1-ribalda@chromium.org>
 <20240821164553.63007e25@imammedo.users.ipa.redhat.com>
 <eb11c984-ebe4-4a09-9d71-1e9db7fe7e6f@ilande.co.uk>
In-Reply-To: <eb11c984-ebe4-4a09-9d71-1e9db7fe7e6f@ilande.co.uk>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 22 Sep 2024 15:11:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCudmC99v+zVch3+7xQ0cVR=qR6U6tF3t5YtiQNO-i9x=w@mail.gmail.com>
Message-ID: <CANiDSCudmC99v+zVch3+7xQ0cVR=qR6U6tF3t5YtiQNO-i9x=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] hw/i386/acpi: Pre-compute the _PRT table
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 qemu-devel@nongnu.org, righi.andrea@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ribalda@chromium.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.129,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Mark



On Sun, 22 Sept 2024 at 13:57, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 21/08/2024 15:45, Igor Mammedov wrote:
>
> > On Wed, 14 Aug 2024 11:56:08 +0000
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> >> Today for x86 the _PRT() table is computed in runtime.
> >> Under some configurations, computing the _PRT table can take more than
> >> 30 seconds and the ACPI timeout is violated.
> >>
> >> This patchset modifies _PRT() to return a pre-computed table.
> >
> > To be sure we are not breaking anything boot tested it with
> > rhel6.7/9.0, winxp, ws2022
>
> Hi Ricardo/Igor,
>
> Unfortunately it seems that this series (and in particular commit 99cb2c6c7b
> ("hw/i386/acpi-build: Return a pre-computed _PRT table") breaks my WinXP ISO boot
> test case using the dc390/am53C974 SCSI device.
>
> Current master hangs when booting WinXP from a dc390 SCSI CD just after loading the
> kernel device drivers and displaying "Setup is starting Windows" instead of
> proceeding to the "Welcome to Setup" screen.
>
> Note that there is a separate timeout issue caused by a bug in SeaBIOS which is fixed
> in the SeaBIOS repository as commit 2424e4c0 ("esp-scsi: indicate acceptance of
> MESSAGE IN phase data"). As the QEMU SeaBIOS binaries haven't yet been updated to
> contain this fix, I've uploaded a pre-built bios.bin to
> https://www.ilande.co.uk/tmp/qemu/bios.bin to help reproduce the issue.
>
> Once the above file is downloaded the issue can be reproduced with the command line
> below:
>
> ./qemu-system-x86_64 \
>    -m 1G \
>    -device dc390,id=scsi0 \
>    -device scsi-cd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=6,lun=0 \
>    -drive file=winxp.iso,if=none,id=drive0 \
>    -vga cirrus \
>    -boot d \
>    -trace 'esp*' \
>    -bios bios.bin
>
> With the ESP tracing enabled it is possible to see that WinXP appears to get stuck in
> a loop trying to send a SCSI command followed by a "Bus Reset". Reverting 99cb2c6c7b
> allows the WinXP ISO to boot to the "Welcome to Setup" screen as before.
>
>
> ATB,
>
> Mark.

Thanks for the detailed report, and sorry for breaking your testcase.

I managed to reproduce locally.

Could you check if this patch fixes your issue and the rest of your testcases?
If so, I will prepare a proper patchset.

Thanks!

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4967aa7459..e7db51afba 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -741,7 +741,7 @@ static Aml *build_prt(bool is_pci0_prt)
     int pin;

     method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    rt_pkg = aml_varpackage(nroutes);
+    rt_pkg = aml_package(nroutes);

     for (pin = 0; pin < nroutes; pin++) {
         Aml *pkg = aml_package(4);



>
> >> Changelog v3->v4 Thanks Richard:
> >> - Make link_name struct static
> >>
> >> Changelog v3->v4 Thanks Igor:
> >> - Add missing files to tests/qtest/bios-tables-test-allowed-diff.h
> >>
> >> Changelog v2->v3 Thanks Michael:
> >> - Code style
> >> - Add cover letter
> >>
> >> Ricardo Ribalda (3):
> >>    tests/acpi: pc: allow DSDT acpi table changes
> >>    hw/i386/acpi-build: Return a pre-computed _PRT table
> >>    tests/acpi: pc: update golden masters for DSDT
> >>
> >>   hw/i386/acpi-build.c                 | 120 +++++----------------------
> >>   tests/data/acpi/x86/pc/DSDT          | Bin 6830 -> 8527 bytes
> >>   tests/data/acpi/x86/pc/DSDT.acpierst | Bin 6741 -> 8438 bytes
> >>   tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 8155 -> 9852 bytes
> >>   tests/data/acpi/x86/pc/DSDT.bridge   | Bin 13701 -> 15398 bytes
> >>   tests/data/acpi/x86/pc/DSDT.cphp     | Bin 7294 -> 8991 bytes
> >>   tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 8484 -> 10181 bytes
> >>   tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 6781 -> 8478 bytes
> >>   tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 3337 -> 5034 bytes
> >>   tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 6902 -> 8599 bytes
> >>   tests/data/acpi/x86/pc/DSDT.memhp    | Bin 8189 -> 9886 bytes
> >>   tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 6688 -> 8385 bytes
> >>   tests/data/acpi/x86/pc/DSDT.numamem  | Bin 6836 -> 8533 bytes
> >>   tests/data/acpi/x86/pc/DSDT.roothp   | Bin 10623 -> 12320 bytes
> >>   tests/data/acpi/x86/q35/DSDT.cxl     | Bin 9714 -> 13148 bytes
> >>   tests/data/acpi/x86/q35/DSDT.viot    | Bin 9464 -> 14615 bytes
> >>   16 files changed, 22 insertions(+), 98 deletions(-)
>


-- 
Ricardo Ribalda

