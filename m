Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A34BD2F000
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 12:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiOE-0004TW-DG; Tue, 27 Jan 2026 07:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vkiNv-000476-Sb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:41:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vkiNt-0006aO-Hq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:41:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806b43beb6so3321735e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769517686; x=1770122486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0wsgJ0S8Rq4fN684ezxknHW7PGcBrKvSaZKZiLYkHk=;
 b=KpP1dLH2MJ7ng5rUtDmDN2LrMhf9l5tZpoxX1h0ZHkaUHo1Jp8MSJsQTYcyxaR+cNn
 IdWPM6yxAjGp3QeFECYfDJDeT9B2mUUJ4Zuu6JYhY2gBvsaJcHnzgUMIXP26OH1OVon4
 zLSeesYMWOf6jn12jxw1lJ3X6CTHs4tcWsPsyr1yl62VLKixarjkeyBQ0CZWzY6gXgHt
 GDOls/1xTP0ORhjC6JdUcssKPJ5R4M9eSppRi55pIZ24etEXDThp+BCtMyysGVPHIuCA
 SNGnH0O30wYHXBI74xBcz25SJIrZ4dlwkHFTTDzUjPm3hdYU9mi1uF3ivc5B4SVeicEx
 4ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769517686; x=1770122486;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a0wsgJ0S8Rq4fN684ezxknHW7PGcBrKvSaZKZiLYkHk=;
 b=lVvacdtUcikrm/cXyxF5JMq7dOg4+Qxa2gLrSSZqbdZK2X8q1fflEkWZwBigT0PjOd
 vAs6oe0+EtSt1/nklTOE4HKkwi9BkYbVXv9d11j/khSWqtaHh0p7ggMcW+Ds78CE0QkY
 67dRMozS5wTRLk+fA4z5zvAKRI7q8HjL4uMvpSCnoyeKy37lPWG0cR8vgjt7FUowTXHp
 7V5gjzbCnLqyH+mfWFlN1K0NYfzjxItXddmeZ/y4YgmGeuy3X7C69hplciUOpjX6f/M4
 L8Jy++SVbhaJ8fOGUyZcAEff+gjKw2ajFsBJosMb07pNFi3H8wDGotQ6Hea3c4oEaZTC
 IJjA==
X-Gm-Message-State: AOJu0Ywz+hGfib2iuYvRSxA6HAODhZFhyntzI46T3YewgiVSE6F+tSdV
 bJBpIDyits7DUT0vb2fq4V4IKiYW+D2TmEsgtoRb+5upDW0ajpP0468vaUnUaQ==
X-Gm-Gg: AZuq6aK8wAJskQUhYX8eXnA6sVjs0TOEcjAbIlIRPNmCRf6XP95qTD6wXcwUmVxgRxR
 hLPE/duhkXmVhFMqmTahW3AB1ha4lKULjuLMsHwYB4ulVp+onA1JOnKkf4o8u4BqaW/6mMqzWsZ
 nS++O0eQXuSYF4Syw9aFfjSBmm6vWSllmM/C0fiytrk1Ls8Bl4KwEdGHjUX+nE/+x5yZOo6gIIN
 TRQiBrz7Ti2PMA8NsjF2xJOhMxKXwXOYxqhn8jQJCCQMPtuRg/0dLf3yOjBHO/S8Bq/4yentDv5
 3CZ7eHshmPNR9ApvULs9quXXUdgTCfMVPuJ0yvmtOYPQYg+/DRpAxLSmayP0G9+J23yA86qOkDy
 Kt+hsjFsbmBxte0PMoB2MifNkjs670EY88Kr9k/H0EuyfquhJieEHxx8CF63AbYChfVodyMr5tv
 vY3G4sKasMKncL2Mb0Gg==
X-Received: by 2002:a05:600c:820c:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-48069c0e172mr19905765e9.2.1769517685331; 
 Tue, 27 Jan 2026 04:41:25 -0800 (PST)
Received: from ehlo.thunderbird.net ([90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e715d3sm37865079f8f.28.2026.01.27.04.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 04:41:24 -0800 (PST)
Date: Tue, 27 Jan 2026 11:26:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: kraxel@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_11/33=5D_hw/i386=3A_refactor_x86=5Fbios?=
 =?US-ASCII?Q?=5From=5Finit_for_reuse_in_confidential_guest_reset?=
In-Reply-To: <20260127051612.219475-12-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-12-anisinha@redhat.com>
Message-ID: <355D352F-B711-42C6-8D0B-6D884723FF0A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 27=2E Januar 2026 05:15:39 UTC schrieb Ani Sinha <anisinha@redhat=2Ecom=
>:
>For confidential guests, bios image must be reinitialized upon reset=2E T=
his
>is because bios memory is encrypted and hence once the old confidential
>kvm context is destroyed, it cannot be decrypted=2E It needs to be reinit=
ilized=2E
>In order to do that, this change refactors x86_bios_rom_init() code so th=
at
>parts of it can be called during confidential guest reset=2E
>
>Signed-off-by: Ani Sinha <anisinha@redhat=2Ecom>
>---
> hw/i386/x86-common=2Ec  | 51 ++++++++++++++++++++++++++++++++-----------
> include/hw/i386/x86=2Eh |  1 -
> 2 files changed, 38 insertions(+), 14 deletions(-)
>
>diff --git a/hw/i386/x86-common=2Ec b/hw/i386/x86-common=2Ec
>index c1c9224039=2E=2E4469b4e152 100644
>--- a/hw/i386/x86-common=2Ec
>+++ b/hw/i386/x86-common=2Ec
>@@ -1024,17 +1024,11 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, Me=
moryRegion *isa_memory,
>     memory_region_set_readonly(isa_bios, read_only);
> }
>=20
>-void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmw=
are,
>-                       MemoryRegion *rom_memory, bool isapc_ram_fw)
>+static int get_bios_size(X86MachineState *x86ms,
>+                         const char *bios_name, char *filename)
> {
>-    const char *bios_name;
>-    char *filename;
>     int bios_size;
>-    ssize_t ret;
>=20
>-    /* BIOS load */
>-    bios_name =3D MACHINE(x86ms)->firmware ?: default_firmware;
>-    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>     if (filename) {
>         bios_size =3D get_image_size(filename, NULL);
>     } else {
>@@ -1044,6 +1038,21 @@ void x86_bios_rom_init(X86MachineState *x86ms, con=
st char *default_firmware,
>         (bios_size % 65536) !=3D 0) {
>         goto bios_error;
>     }
>+
>+    return bios_size;
>+
>+ bios_error:
>+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
>+    exit(1);
>+}
>+
>+static void load_bios_from_file(X86MachineState *x86ms, const char *bios=
_name,
>+                                char *filename, int bios_size,
>+                                bool isapc_ram_fw)
>+{
>+    ssize_t ret;
>+
>+    /* BIOS load */
>     if (machine_require_guest_memfd(MACHINE(x86ms))) {
>         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc=2Ebio=
s",
>                                            bios_size, &error_fatal);
>@@ -1072,7 +1081,26 @@ void x86_bios_rom_init(X86MachineState *x86ms, con=
st char *default_firmware,
>             goto bios_error;
>         }
>     }
>-    g_free(filename);
>+
>+    return;
>+
>+ bios_error:
>+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
>+    exit(1);
>+}
>+
>+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmw=
are,
>+                       MemoryRegion *rom_memory, bool isapc_ram_fw)
>+{
>+    int bios_size;
>+    const char *bios_name;
>+    char *filename;
>+
>+    bios_name =3D MACHINE(x86ms)->firmware ?: default_firmware;
>+    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>+
>+    bios_size =3D get_bios_size(x86ms, bios_name, filename);
>+    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram=
_fw);
>=20
>     if (!machine_require_guest_memfd(MACHINE(x86ms))) {
>         /* map the last 128KB of the BIOS in ISA space */
>@@ -1084,9 +1112,6 @@ void x86_bios_rom_init(X86MachineState *x86ms, cons=
t char *default_firmware,
>     memory_region_add_subregion(rom_memory,
>                                 (uint32_t)(-bios_size),
>                                 &x86ms->bios);
>+    g_free(filename);

Doesn't the error path leak filename? Using g_autofree would prevent that=
=2E Even if the error path exits immediately today it may represent a laten=
t bug for tomorrow (e=2Eg=2E when porting to error API)=2E

>     return;
>-
>-bios_error:
>-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
>-    exit(1);
> }
>diff --git a/include/hw/i386/x86=2Eh b/include/hw/i386/x86=2Eh
>index 0dffba95f9=2E=2Ebfdf97640d 100644
>--- a/include/hw/i386/x86=2Eh
>+++ b/include/hw/i386/x86=2Eh
>@@ -122,7 +122,6 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplu=
g_dev,
>                                DeviceState *dev, Error **errp);
> void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
>                        DeviceState *dev, Error **errp);
>-

This file contains whitespace changes only and breaks logic grouping of fu=
nctions=2E I'd drop this change=2E

Best regards,
Bernhard

> void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
>                        MemoryRegion *bios, bool read_only);
> void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmw=
are,

