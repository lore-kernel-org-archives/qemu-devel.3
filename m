Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620A0C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdKx-00011h-LG; Fri, 07 Mar 2025 14:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tqdKp-0000Sm-2S
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:26:20 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tqdKn-0001pZ-GR
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:26:14 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab771575040so626355566b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741375571; x=1741980371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OasSmFJgx+gzJhTzshXEaLCXWevDCGuyO2xFbVT+ncA=;
 b=CmcdM0B87DiO43DrvCqkx26PUB4UROgqOBce8661M0hoSK6TABpFlcKNBEC6u0Nhpl
 9guFptGP94htqQxElA2sHXfv1bL33+IR972e6Zf+twb4bwJfYlx33CmEq+V0fHGvNbU4
 Yydy3RDxIpOmyQuJ4KsNI8nf4ECQ5AzsLU0s+SmDplRa8FrjTJNw383KNmdRT5py1D0E
 4UAkmyw9TkKTTp/2Uy2j2Ph4oAeBywUY3yWvzi6t8Qa9sZEIspstV7J9hEjfVRIbBx7C
 EMx3yFpkD2iuO7dLkOcmTE0d+YAjKCCEDsPR/uce5iHnZq79JK2Vj2jkJ6ZHzbkEOp4P
 cJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375571; x=1741980371;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OasSmFJgx+gzJhTzshXEaLCXWevDCGuyO2xFbVT+ncA=;
 b=CHDvlTU0xRCavrFGWyLZrs6feY+pVdT1ZUM0az6tbmNmv2B18slOVITfu1+JyEFqIq
 jjw5I6P1zduaAr4fwHKpGSQw/EEwB0+hmb3irPeFldVs3VMFXXBiss5Id3KLhCoPrQkt
 lBXCMz2EUNxUYsVUJm2tNxSUdXEFLYYANVbDBGUPYzRYAD6FSv+Bym8vHfjwDryRRy1S
 NwOXvbxxfF+yM+fDbYyDvU+DOml+OCedf6Cq8h0D8n7h+MMp5v6sXJjpH/ZGtbaywjqV
 WFbQJOfL0MpcI9/3nees4qwI+z3EtenmT98twotpef12lJy42s0P+ZEW3j+Y1rPpY0be
 gpjQ==
X-Gm-Message-State: AOJu0YzoDw6wPRPrJdoiZGQkNUuN7U6P2+AC8c5SUuAy7AOZhbUWtKae
 bQ/tl5jQ2sYRx8ar/xzXWi5kkyRqoR7NZx6lmqby69NMlKohKmJWwyhPTA==
X-Gm-Gg: ASbGncshDmNAcOKKZ+c5jivx57kKSj7yUCo1pdOJ++KThAdRQcldmEFxhwSsvXqXHS6
 MgFrFmLP81lHM1xqD1Ygn8YheawaFQC7lkkDS0BH6sULT66s9Hc4rtTCl/NZDVGy2ojcrLW/HNJ
 2HikTPk+vakULUY5fUyi4r5b/ZfZYfINDMp9PGHkxcpH0zc5GAIXP817FDijVxFOv6Ocwhl09lX
 DgEzeaAlG5g09xzzqOCMQclHq0rC33Fa9kysSXd8713khnDSRkJTqlVbNsl9uBZGOOO9+x4/BtC
 hxO236ItR3khLGipGpCRMehgcDm7AlFDfTYtvezeKCsU1S1FSzXXJqYvgee6V9h2Af3J07MpSAM
 Ra+7sPBA9r+F9o/seDPX0mhK9D2pMVCzyQgbSC9ZT6rJcL3kjTY0w
X-Google-Smtp-Source: AGHT+IHEfjOFdNKKHZ5f53CNZ8WvJ0gMXVm5zAAwNU/KmmxGwr6snwrFo5D3/ip5rDv8W7wtsd/VBA==
X-Received: by 2002:a17:907:1908:b0:ac1:edc5:d73b with SMTP id
 a640c23a62f3a-ac26ca59335mr71873366b.8.1741375570885; 
 Fri, 07 Mar 2025 11:26:10 -0800 (PST)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-25f3-2600-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:25f3:2600:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23988b634sm319966466b.149.2025.03.07.11.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:26:10 -0800 (PST)
Date: Fri, 07 Mar 2025 19:26:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Davidson Francis <davidsondfgl@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: davidsondfgl@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_target/i386=3A_Improve_16?=
 =?US-ASCII?Q?-bit/real_mode_debug_support_in_GDB?=
In-Reply-To: <20241221054549.21883-1-davidsondfgl@gmail.com>
References: <20241219013535.GB4298@darkstar>
 <20241221054549.21883-1-davidsondfgl@gmail.com>
Message-ID: <68941EA1-F752-4C9E-B4E8-0CDCF48D0EAF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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



Am 21=2E Dezember 2024 05:45:49 UTC schrieb Davidson Francis <davidsondfgl=
@gmail=2Ecom>:
>Debugging 16-bit/real mode code in QEMU+GDB is challenging due to
>incorrect architecture detection and segmented memory addressing issues=
=2E
>
>This patch improves the debugging experience by reporting i8086
>architecture to GDB when in real mode and converting segmented addresses
>(CS:EIP, SS:ESP) to their physical equivalents when reporting to GDB=2E
>This enables proper instruction disassembly and stack inspection without
>complex workarounds=2E
>
>Note: Mode switches after GDB attachment still require manual
>architecture change, as GDB RSP does not support runtime architecture
>switches=2E
>
>Signed-off-by: Davidson Francis <davidsondfgl@gmail=2Ecom>
>---
> target/i386/cpu=2Ec     |  8 +++++++-
> target/i386/gdbstub=2Ec | 15 +++++++++++++--
> 2 files changed, 20 insertions(+), 3 deletions(-)

Ping

I don't feel confident reviewing this patch=2E Paolo? Zhao?

Best regards,
Bernhard

>
>diff --git a/target/i386/cpu=2Ec b/target/i386/cpu=2Ec
>index 5253399459=2E=2E65bdc48cc0 100644
>--- a/target/i386/cpu=2Ec
>+++ b/target/i386/cpu=2Ec
>@@ -6404,7 +6404,13 @@ static const gchar *x86_gdb_arch_name(CPUState *cs=
)
> #ifdef TARGET_X86_64
>     return "i386:x86-64";
> #else
>-    return "i386";
>+    X86CPU *cpu =3D X86_CPU(cs);
>+    CPUX86State *env =3D &cpu->env;
>+    if (env->cr[0] & 1) {
>+        return "i386";
>+    } else {
>+        return "i8086";
>+    }
> #endif
> }
>=20
>diff --git a/target/i386/gdbstub=2Ec b/target/i386/gdbstub=2Ec
>index 04c49e802d=2E=2Ed600aee953 100644
>--- a/target/i386/gdbstub=2Ec
>+++ b/target/i386/gdbstub=2Ec
>@@ -136,7 +136,13 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>                 return gdb_get_regl(mem_buf, 0);
>             }
>         } else {
>-            return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
>+            if (n !=3D R_ESP || (env->cr[0] & 1)) {
>+                return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
>+            } else {
>+                return gdb_get_reg32(mem_buf,
>+                                     (env->segs[R_SS]=2Eselector << 4) +
>+                                      env->regs[gpr_map32[n]]);
>+            }
>         }
>     } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>         int st_index =3D n - IDX_FP_REGS;
>@@ -155,7 +161,12 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>     } else {
>         switch (n) {
>         case IDX_IP_REG:
>-            return gdb_get_reg(env, mem_buf, env->eip);
>+            if (TARGET_LONG_BITS !=3D 32 || (env->cr[0] & 1)) {
>+                return gdb_get_reg(env, mem_buf, env->eip);
>+            } else {
>+                return gdb_get_reg(env, mem_buf,
>+                                   (env->segs[R_CS]=2Eselector << 4) + e=
nv->eip);
>+            }
>         case IDX_FLAGS_REG:
>             return gdb_get_reg32(mem_buf, env->eflags);
>=20

