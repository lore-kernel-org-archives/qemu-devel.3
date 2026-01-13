Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4F6D2D107
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfev9-0005p3-CL; Tue, 13 Jan 2026 08:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfev7-0005oa-6z
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:58:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfev5-0000tA-MY
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:58:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so3948706f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312726; x=1768917526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WhGDknja7CQejJLDSeyhPCpGEnEpfpz6CPziZT1+0s=;
 b=G3oEKHsMXQ7EAon4j9KcSD5VFxyhAacv0O32Zp2khKT3DAMbzugQ+dnYugML31t0X3
 uF5eORrj16xXQPvgCWHDQCsjqPmrJk5evhnnF5WQA6VGvfoRexmLAgi/sH22F+tFkHS7
 ypKtHqi6OhjWYgkDivzNhKNRqLIp25kH+sr+G3Id6IgDbpdv7ZHHYMwH56HvsU4W4utG
 GYajoYN/dyloQ1EivwGxF/oe44UsaTUW1Q7yKCShzflnFwgnS5FnBS1akVy8+Evvm4t/
 0SGh4tBayxV/nSfqd+qlmuFjvNDARty16pyvsiyq0f19E9W1tHTNG/iy+ML0v1a9YOue
 zIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312726; x=1768917526;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6WhGDknja7CQejJLDSeyhPCpGEnEpfpz6CPziZT1+0s=;
 b=jzFpsHFsTrUafb5yEfdQQXNn9wFr5pghGJoE0jLAx+Q/S3JwvvxH7UVP2zleUCnV9w
 Arlw/NvsNSXdseWeWPqHXtj8/9vub71TjuRrlIiablL7s5YsFejdZfW+mzA3cKKOBrzj
 sJ+Bv4uwCnz5ic68X1pKYesEnpRdL4YCbJwVuCFcy73G/4kQyvjO9h/iHcoONro7nBBv
 73DZxVvCXMpgv+a8IIi3ZHB3cnxqBKA0/0yjMdiciDDUG/6Z4qNz4HgU+FIKWZ0J/uHs
 Z0/VNpj29FHIdGDTepoGyJKnW0jxxZcEBHmFZOtPSJzjxQKxedKbfvC+cL6F0NUiCcYL
 3plQ==
X-Gm-Message-State: AOJu0YzmFOH92s0xSzugO7BZBjYwuRXjYmvNIM3aVJhhbNE2MeX9b8cx
 snN12FknQLyNC8i9GMafsL3qDoBoA486qYQbMLtIJiN13b6ZlqJgeqPsLrPbWw==
X-Gm-Gg: AY/fxX6YLSm4/aa0q7psadAOLyVF5b/I+pjsIpgJd3mfuWhI+f/v5Irqk/Dz1n83K5T
 SVMTv0zYgmN95qsVqapjRzswI0tzm9DVGiGjCbFBAhUc1zUAvK/RWgMhnDO1iqPijPmhTEoL1Yw
 UbcT++qEsaYNHnL6YSHRiJsnbJVpmbxfVEVgeRXp/Dl9dyU8TaQYLKw6/mE4K505gt9N55xEVP0
 8eG9XRmrHUeSVx21K9Z1E7j+OvddyYrcXp7gqBl/mKD9NhJctVDDmBCACSsE1t8X0s2lvk1476b
 C3pKiv6xa2UFvshCRrVvBf6aYdkCcwrnMXOtTiRBIU4FFksM4hzx8e1eJjGhGi6I89iBjJKKt1k
 pOv5phmBIge72DJQh9MVB91uMbFI2DDMPI/xR7+QkvusJAFzmsMgtSrFbBMzm+raglxgv7wLXTd
 UXPf/CIlgBBc4+M/yUzaiKSgfyc9Lok136KRZdbhI4+VAfeG1Z2QQaBflslSykUR/dYMlb8ajB
X-Google-Smtp-Source: AGHT+IHz3/MZq5IE1wUR5QXf+2IHt/MHhR2WlMb82Jjaiy4vcro767CKSZ9wAVL85Hpc2XOy6zo8xg==
X-Received: by 2002:a5d:5d13:0:b0:430:f58d:40d7 with SMTP id
 ffacd0b85a97d-432c374f477mr29322767f8f.13.1768312725842; 
 Tue, 13 Jan 2026 05:58:45 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-002-242-220-137.2.242.pool.telefonica.de. [2.242.220.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dadcfsm43551328f8f.3.2026.01.13.05.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 05:58:45 -0800 (PST)
Date: Tue, 13 Jan 2026 13:58:44 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
CC: kvm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_11/32=5D_kvm/i386=3A_reload?=
 =?US-ASCII?Q?_firmware_for_confidential_guest_reset?=
In-Reply-To: <20260112132259.76855-12-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-12-anisinha@redhat.com>
Message-ID: <1840E5EB-CFD2-478E-B6CB-242B46FD5166@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
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



Am 12=2E Januar 2026 13:22:24 UTC schrieb Ani Sinha <anisinha@redhat=2Ecom=
>:
>When IGVM is not being used by the confidential guest, the guest firmware=
 has
>to be reloaded explictly again into memory=2E This is because, the memory=
 into
>which the firmware was loaded before reset was encrypted and is thus lost
>upon reset=2E When IGVM is used, it is expected that the IGVM will contai=
n the
>guest firmware and the execution of the IGVM directives will set up the g=
uest
>firmware memory=2E
>
>Signed-off-by: Ani Sinha <anisinha@redhat=2Ecom>
>---
> target/i386/kvm/kvm=2Ec | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/target/i386/kvm/kvm=2Ec b/target/i386/kvm/kvm=2Ec
>index 4fedc621b8=2E=2E46c4f9487b 100644
>--- a/target/i386/kvm/kvm=2Ec
>+++ b/target/i386/kvm/kvm=2Ec
>@@ -51,6 +51,8 @@
> #include "qemu/config-file=2Eh"
> #include "qemu/error-report=2Eh"
> #include "qemu/memalign=2Eh"
>+#include "qemu/datadir=2Eh"
>+#include "hw/core/loader=2Eh"
> #include "hw/i386/x86=2Eh"
> #include "hw/i386/kvm/xen_evtchn=2Eh"
> #include "hw/i386/pc=2Eh"
>@@ -3267,6 +3269,22 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
>=20
> static int xen_init_wrapper(MachineState *ms, KVMState *s);
>=20
>+static void reload_bios_rom(X86MachineState *x86ms)
>+{
>+    int bios_size;
>+    const char *bios_name;
>+    char *filename;
>+
>+    bios_name =3D MACHINE(x86ms)->firmware ?: "bios=2Ebin";
>+    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>+
>+    bios_size =3D get_bios_size(x86ms, bios_name, filename);
>+
>+    void *ptr =3D memory_region_get_ram_ptr(&x86ms->bios);
>+    load_image_size(filename, ptr, bios_size);
>+    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
>+}

All code in this function is already present in x86-common=2Ec=2E Can we m=
ove this function there (possibly renaming it to x86_bios_rom_reload()) and=
 export it? This way, we could avoid code duplication and we didn't need to=
 export additional functions like in the previous patch=2E

Best regards,
Bernhard

>+
> int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
> {
>     Error *local_err =3D NULL;
>@@ -3285,6 +3303,16 @@ int kvm_arch_vmfd_change_ops(MachineState *ms, KVM=
State *s)
>             error_report_err(local_err);
>             return ret;
>         }
>+        if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
>+            X86MachineState *x86ms =3D X86_MACHINE(ms);
>+            /*
>+             * If an IGVM file is specified then the firmware must be pr=
ovided
>+             * in the IGVM file=2E
>+             */
>+            if (!x86ms->igvm) {
>+                reload_bios_rom(x86ms);
>+            }
>+        }
>     }
>=20
>     ret =3D kvm_vm_enable_exception_payload(s);

