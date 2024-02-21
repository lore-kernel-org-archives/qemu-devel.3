Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E90C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcobu-0004eP-8E; Wed, 21 Feb 2024 10:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcoZB-00083k-Vu
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:31:26 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcjy0-0005jn-SO
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 05:36:46 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5643eccad0bso5635054a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 02:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708511803; x=1709116603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o24wv8lV9on2u1UYDjvUk0mzdYoqAn9lCRieFI1C+9c=;
 b=KaCgfuoGZMBDSqp8PZfo5Ay6UMyDLAR59DRUuXxSWng9jleyER8v1w+n+LE1pSalj6
 dJNSvBVebi+MC2Vdba7cjxxkAQXvmGsXJlUnyRabPbNFov2k8anLR5hEuU8f0jC5zC6P
 rxSfmtF7NTk9KUzsOQPsrJlugqpjVOOwMeuYGQcibIcNcqS+eGyH+dlWi5A2Y8M+YMik
 zRfsNZxXxSdgzhRU3Wx3jCMazp21nlELwc/Et/zu4IeqcgyayiUDs9ECOA2g6ywDkGTo
 wHvyoDya6U0RT4K8I53CVgc46PVIHTudSf97VdV4aIGOy31uN8+RCFsgOy8XOK883hqK
 Mq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708511803; x=1709116603;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o24wv8lV9on2u1UYDjvUk0mzdYoqAn9lCRieFI1C+9c=;
 b=EJYTN4JSX0nA6CYQUmrB2Evwz4Mo4IrRMSFCewGBHYq9okuuda2IEfFoPz52x1SuZO
 t2e27lBW4xatvl0xo7Ocg58pTNPmggiapZZ+6N65sLw4nNdMop4cnNq4G0DWWqa8ZTHV
 bpTnhnwbvhRng54L73BX2OQDDtwW7iazKslJgxjRGseitTIvpYV8jlFh/qT42d/180vL
 On1oAvQil6VxipL/7VZJBmwR4OgHDOKwwSn2H6fMdjuYI/9VoW5uAjkM4S2UFmPurIfL
 2oyxfZ0DA+VB1ztdJ//uZogdpbCn86S4WhnbWJDMyxnp/p4rJFtrHFwgjlRrAtMV/u9I
 Nrcw==
X-Gm-Message-State: AOJu0YyvKK3r3NijqKw1aGB7b9cncveVyydl8j/BCQXFHzPyIG+6u5a7
 9b4z4hxbLzESComopSIF2aUEkI2m6ZvYkTVbpYmi4kRvYicOpD8Qq2WQzY2h
X-Google-Smtp-Source: AGHT+IGkKFjdUCIz4qTU6QmZLYEaxC4h/n0M7s0+Ov7dyjgMDF5/aPQ9b+LGQiRvcpzZQ9xEH5BMrQ==
X-Received: by 2002:a17:906:1312:b0:a3e:9e4d:dafb with SMTP id
 w18-20020a170906131200b00a3e9e4ddafbmr5107643ejb.29.1708511803072; 
 Wed, 21 Feb 2024 02:36:43 -0800 (PST)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 vb7-20020a170907d04700b00a3d6737afe2sm4822757ejc.138.2024.02.21.02.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 02:36:42 -0800 (PST)
Date: Wed, 21 Feb 2024 09:47:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vl, pc: turn -no-fd-bootchk into a machine property
In-Reply-To: <CABgObfb+BK4s0VtwQUDkdzvwhTwRAXim-pJ-Lg1nWvbhuOm55w@mail.gmail.com>
References: <20240220155352.416710-1-pbonzini@redhat.com>
 <8FECF57F-7897-4AF8-9AC1-46A927C0FEC0@gmail.com>
 <CABgObfb+BK4s0VtwQUDkdzvwhTwRAXim-pJ-Lg1nWvbhuOm55w@mail.gmail.com>
Message-ID: <1A0875D0-5135-4F16-A252-BC9EBA9C567B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 21=2E Februar 2024 09:04:21 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>On Tue, Feb 20, 2024 at 11:43=E2=80=AFPM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>>
>>
>>
>> Am 20=2E Februar 2024 15:53:52 UTC schrieb Paolo Bonzini <pbonzini@redh=
at=2Ecom>:
>> >Add a fd-bootchk property to PC machine types, so that -no-fd-bootchk
>> >returns an error if the machine does not support booting from floppies
>> >and checking for boot signatures therein=2E
>> >
>> >Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> >Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>> >---
>> > include/hw/i386/pc=2Eh |  2 +-
>> > hw/i386/pc=2Ec         | 30 +++++++++++++++++++++++++-----
>> > system/globals=2Ec     |  1 -
>> > system/vl=2Ec          |  2 +-
>> > qemu-options=2Ehx      |  2 +-
>> > 5 files changed, 28 insertions(+), 9 deletions(-)
>> >
>> >diff --git a/include/hw/i386/pc=2Eh b/include/hw/i386/pc=2Eh
>> >index 02a0deedd3c=2E=2Ee5382a02e7a 100644
>> >--- a/include/hw/i386/pc=2Eh
>> >+++ b/include/hw/i386/pc=2Eh
>> >@@ -50,6 +50,7 @@ typedef struct PCMachineState {
>> >     bool hpet_enabled;
>> >     bool i8042_enabled;
>> >     bool default_bus_bypass_iommu;
>> >+    bool fd_bootchk;
>> >     uint64_t max_fw_size;
>> >
>> >     /* ACPI Memory hotplug IO base address */
>> >@@ -147,7 +148,6 @@ OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass=
, PC_MACHINE)
>> > GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>> >
>> > /* pc=2Ec */
>> >-extern int fd_bootchk;
>> >
>> > void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>> >
>> >diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>> >index 28194014f82=2E=2E31f4bb25a3e 100644
>> >--- a/hw/i386/pc=2Ec
>> >+++ b/hw/i386/pc=2Ec
>> >@@ -399,8 +399,8 @@ static int boot_device2nibble(char boot_device)
>> >     return 0;
>> > }
>> >
>> >-static void set_boot_dev(MC146818RtcState *s, const char *boot_device=
,
>> >-                         Error **errp)
>> >+static void set_boot_dev(PCMachineState *pcms, MC146818RtcState *s,
>> >+                         const char *boot_device, Error **errp)
>> > {
>> > #define PC_MAX_BOOT_DEVICES 3
>> >     int nbds, bds[3] =3D { 0, };
>> >@@ -420,12 +420,14 @@ static void set_boot_dev(MC146818RtcState *s, co=
nst char *boot_device,
>> >         }
>> >     }
>> >     mc146818rtc_set_cmos_data(s, 0x3d, (bds[1] << 4) | bds[0]);
>> >-    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | (fd_bootchk ? =
0x0 : 0x1));
>> >+    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | !pcms->fd_boot=
chk);
>> > }
>> >
>> > static void pc_boot_set(void *opaque, const char *boot_device, Error =
**errp)
>> > {
>> >-    set_boot_dev(opaque, boot_device, errp);
>> >+    PCMachineState *pcms =3D PC_MACHINE(current_machine);
>> >+
>> >+    set_boot_dev(pcms, opaque, boot_device, errp);
>> > }
>> >
>> > static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevic=
e *floppy)
>> >@@ -617,6 +619,9 @@ void pc_cmos_init(PCMachineState *pcms,
>> >     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
>> >     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
>> >
>> >+    object_property_add_bool(obj, "fd-bootchk", pc_machine_get_fd_boo=
tchk,
>> >+                             pc_machine_set_fd_bootchk);
>>
>> Isn't it possible to turn this into a class property or add the propert=
y in pc_machine_initfn()? Aggregating properties in one place seems more co=
mprehensible to me=2E
>
>Sure, I placed it in pc_cmos_init because rtc_state is already created he=
re=2E

Great! I'll rebase my PC initialization series on top of Peter's reset cle=
anup series which probably results in folding cmos initialization into pc=
=2Ec=2E

Best regards,
Bernhard

>
>Paolo
>

