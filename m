Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E314DC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 23:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcZFi-0003oK-Iz; Tue, 20 Feb 2024 18:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcZFg-0003nK-JL
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 18:10:16 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcZFb-0002QZ-NR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 18:10:16 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5648d92919dso53880a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 15:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708470608; x=1709075408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8UcYpOUiQ0/DmlCXatWDpjMbWBRzbWwPcpErFxT4RI=;
 b=c/Sjy2sPOhKRqwxsCLDRP5MTSwpH1eHigOqBYSiBiop0GfRdB/NVVjVwB2heuEM56g
 g3GZu9njXUJDUqebosMIem2OY7xy4uJRq4CIJL15BVKqVy2ZYZKEMbpgRffoR1OHA4bn
 grqIyXo+3eg2Gyyj+sfVTOUw8Pe/kGn3eFXyksJi8SKkl293iY1iR9xxYNBepbSmgUb0
 a1VouafXK3cC6uI06tSKG4YI2gsuGlm0j3qTVKIssdKS47igRaucPG6eY6xRZV4fcGZU
 Z7lH9HhJHO/8BMJNnc9ztvjPiiXLSozAJZVt0BVDJ3ykZ1bNcUyJDR2Bb/ttjhS0Rsm2
 6Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708470608; x=1709075408;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8UcYpOUiQ0/DmlCXatWDpjMbWBRzbWwPcpErFxT4RI=;
 b=vD7V1DyQl3suk6RId0gaKMjj/goHrTeVDVaaQQaGjoV4LwDpDNNVXKqu/IPPt8kdOP
 OmC5FLmGeBbMDVfwFi/+maANIlJd16ayqaaxgWDccMYDFS0zlR3IIXW1kGfHNsY9DcGC
 oP/TBnH14DT6KxncuG1yiaK+2RKEl7EkGnxEzxLBAZnnxxYVUyREUO7M0h6ztENxXfqx
 wyTwfBVpzo3g3/WoFNKx7heKje6Qt7bGqSCinRHxr8ZoZBwUB4ivdxaI8NDGKnaIMnk3
 MVkPTs+TBnZ9GjRGHmsnMFRwBrLq90z5gtftqyyS13+aeb5vM6eowNEWstwjuiwACBOu
 6pXQ==
X-Gm-Message-State: AOJu0Yzed895JXZO2jrk8FAqEXvGN7zId5DvkF1taOFrDBj7qb6FVVQt
 cf7bqEnFEweqq/x20urghH3UfW3MonEZToJp3KkcJF1+Qi9AwDPpZ+w93Det
X-Google-Smtp-Source: AGHT+IE87FLj1dpM0aoW6VhbMphTh2s62LIkE9SOqy1BpMe59EMVAeh0WFsNaHa1jQvixXQPRkvbDg==
X-Received: by 2002:a05:6402:34f:b0:564:66d3:530f with SMTP id
 r15-20020a056402034f00b0056466d3530fmr4898989edw.28.1708470608073; 
 Tue, 20 Feb 2024 15:10:08 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-092-079.89.14.pool.telefonica.de.
 [89.14.92.79]) by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b00563f8233ba8sm4076733edb.7.2024.02.20.15.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 15:10:07 -0800 (PST)
Date: Tue, 20 Feb 2024 23:10:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_02/10=5D_hw/i386/pc=3A_Do_pc=5Fc?=
 =?US-ASCII?Q?mos=5Finit=5Flate=28=29_from_pc=5Fmachine=5Fdone=28=29?=
In-Reply-To: <20240220160622.114437-3-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-3-peter.maydell@linaro.org>
Message-ID: <5BB60433-8117-4AEA-ABDC-973B6305BC4C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



Am 20=2E Februar 2024 16:06:14 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>In the i386 PC machine, we want to run the pc_cmos_init_late()
>function only once the IDE and floppy drive devices have been set up=2E
>We currently do this using qemu_register_reset(), and then have the
>function call qemu_unregister_reset() on itself, so it runs exactly
>once=2E
>
>This was an expedient way to do it back in 2010 when we first added
>this (in commit c0897e0cb94e8), but now we have a more obvious point
>to do "machine initialization that has to happen after generic device
>init": the machine-init-done hook=2E
>
>Do the pc_cmos_init_late() work from our existing PC machine init
>done hook function, so we can drop the use of qemu_register_reset()
>and qemu_unregister_reset()=2E
>
>Because the pointers to the devices we need (the IDE buses and the
>RTC) are now all in the machine state, we don't need the
>pc_cmos_init_late_arg struct and can just pass the PCMachineState
>pointer=2E
>
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>---
> hw/i386/pc=2Ec | 39 ++++++++++++++++-----------------------
> 1 file changed, 16 insertions(+), 23 deletions(-)
>
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index 8b0f54e284c=2E=2E4c3cfe9fc35 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -465,11 +465,6 @@ static void pc_cmos_init_floppy(MC146818RtcState *rt=
c_state, ISADevice *floppy)
>     mc146818rtc_set_cmos_data(rtc_state, REG_EQUIPMENT_BYTE, val);
> }
>=20
>-typedef struct pc_cmos_init_late_arg {
>-    MC146818RtcState *rtc_state;
>-    BusState *idebus[2];
>-} pc_cmos_init_late_arg;
>-
> typedef struct check_fdc_state {
>     ISADevice *floppy;
>     bool multiple;
>@@ -530,23 +525,25 @@ static ISADevice *pc_find_fdc0(void)
>     return state=2Efloppy;
> }
>=20
>-static void pc_cmos_init_late(void *opaque)
>+static void pc_cmos_init_late(PCMachineState *pcms)
> {
>-    pc_cmos_init_late_arg *arg =3D opaque;
>-    MC146818RtcState *s =3D arg->rtc_state;
>+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>+    MC146818RtcState *s =3D MC146818_RTC(x86ms->rtc);
>     int16_t cylinders;
>     int8_t heads, sectors;
>     int val;
>     int i, trans;
>=20
>     val =3D 0;
>-    if (arg->idebus[0] && ide_get_geometry(arg->idebus[0], 0,
>-                                           &cylinders, &heads, &sectors)=
 >=3D 0) {
>+    if (pcms->idebus[0] &&
>+        ide_get_geometry(pcms->idebus[0], 0,
>+                         &cylinders, &heads, &sectors) >=3D 0) {
>         cmos_init_hd(s, 0x19, 0x1b, cylinders, heads, sectors);
>         val |=3D 0xf0;
>     }
>-    if (arg->idebus[0] && ide_get_geometry(arg->idebus[0], 1,
>-                                           &cylinders, &heads, &sectors)=
 >=3D 0) {
>+    if (pcms->idebus[0] &&
>+        ide_get_geometry(pcms->idebus[0], 1,
>+                         &cylinders, &heads, &sectors) >=3D 0) {
>         cmos_init_hd(s, 0x1a, 0x24, cylinders, heads, sectors);
>         val |=3D 0x0f;
>     }
>@@ -558,10 +555,11 @@ static void pc_cmos_init_late(void *opaque)
>            geometry=2E  It is always such that: 1 <=3D sects <=3D 63, 1
>            <=3D heads <=3D 16, 1 <=3D cylinders <=3D 16383=2E The BIOS
>            geometry can be different if a translation is done=2E */
>-        if (arg->idebus[i / 2] &&
>-            ide_get_geometry(arg->idebus[i / 2], i % 2,
>+        BusState *idebus =3D pcms->idebus[i / 2];
>+        if (idebus &&
>+            ide_get_geometry(idebus, i % 2,
>                              &cylinders, &heads, &sectors) >=3D 0) {
>-            trans =3D ide_get_bios_chs_trans(arg->idebus[i / 2], i % 2) =
- 1;
>+            trans =3D ide_get_bios_chs_trans(idebus, i % 2) - 1;
>             assert((trans & ~3) =3D=3D 0);
>             val |=3D trans << (i * 2);
>         }
>@@ -569,15 +567,12 @@ static void pc_cmos_init_late(void *opaque)
>     mc146818rtc_set_cmos_data(s, 0x39, val);
>=20
>     pc_cmos_init_floppy(s, pc_find_fdc0());
>-
>-    qemu_unregister_reset(pc_cmos_init_late, opaque);
> }
>=20
> void pc_cmos_init(PCMachineState *pcms,
>                   ISADevice *rtc)
> {
>     int val;
>-    static pc_cmos_init_late_arg arg;
>     X86MachineState *x86ms =3D X86_MACHINE(pcms);
>     MC146818RtcState *s =3D MC146818_RTC(rtc);
>=20
>@@ -631,11 +626,7 @@ void pc_cmos_init(PCMachineState *pcms,
>     val |=3D 0x04; /* PS/2 mouse installed */
>     mc146818rtc_set_cmos_data(s, REG_EQUIPMENT_BYTE, val);
>=20
>-    /* hard drives and FDC */
>-    arg=2Ertc_state =3D s;
>-    arg=2Eidebus[0] =3D pcms->idebus[0];
>-    arg=2Eidebus[1] =3D pcms->idebus[1];
>-    qemu_register_reset(pc_cmos_init_late, &arg);
>+    /* hard drives and FDC are handled by pc_cmos_init_late() */
> }
>=20
> static void handle_a20_line_change(void *opaque, int irq, int level)
>@@ -703,6 +694,8 @@ void pc_machine_done(Notifier *notifier, void *data)
>         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
>         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpu=
s);
>     }
>+
>+    pc_cmos_init_late(pcms);

Nice=2E With https://patchew=2Eorg/QEMU/20240208220349=2E4948-1-shentey@gm=
ail=2Ecom/20240208220349=2E4948-9-shentey@gmail=2Ecom/ on top it might be p=
ossible to merge pc_cmos_init_late() and pc_cmos_init(), thus freeing pc_pi=
ix and pc_q35 entirely from having to deal with it=2E

Best regards,
Bernhard

> }
>=20
> void pc_guest_info_init(PCMachineState *pcms)

