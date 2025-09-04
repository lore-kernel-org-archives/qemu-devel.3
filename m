Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06842CA101F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu59d-0005Lq-0J; Thu, 04 Sep 2025 04:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu55J-0006kA-PE
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:49 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54h-0004G4-17
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:42 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61e8fdfd9b4so1639226a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973524; x=1757578324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLxFb3NYbTS9f/pm1eUqTOiDM/5DBuFeeS5GZ+vjJzw=;
 b=ip+lrQZDNSFNY4DI7P4Y3AQgARPPBv4N05IrOFKAAaxL4csVrkMOykOJ9MKFM/kAKS
 iLWItl/58o+eTJgBRfXa8n2x74YYPz/WMDl5uGp56VbeZPzUjodQHKKVWePZfjDBbDb/
 K8Cf+eLR3eief69E17hnxioUDfwisFFfeablYXK7wARiOvZrjo5fJ0/WDIoRgTfUMTsN
 9KWayY29cfjj0RLDw2ypbj2tILsvKKmLqI9qRPqDZlodkoJ0O2DTrHTU/C0Q+DoqTVCW
 HLVXiYXNbqD8tNyoKGW5Y4DBSlKNJAsKd0eNCnMV10orGSyp4myU99UQVsewCuoMLwU4
 xzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973524; x=1757578324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLxFb3NYbTS9f/pm1eUqTOiDM/5DBuFeeS5GZ+vjJzw=;
 b=V2iI3ksNpginYqF3uMSxLxGIems3WnNwebCpCahuVa7WEcOIyZ07ukccqNeo5mjZ+U
 0CGQqSESOTmzCXIuLMzdT5wZpHPyHr/DCqRSvbwWxZpc1YJwnT3uMACDUWUjViR5fif6
 Pnw1TPLSUs6e1CyiYMFBA5BuWLwPlvoNr0Yhq/qfvTAI/vqpw0b2zUX/TSwIIsHYnFJE
 DJl/Y9mTLFv21DjznOODmaVgfrjZOac1Cnu0meyTedzX/gl0mRu4LF0D+6AYdvHwocGh
 m5vJyBMCukqrXkc+mRMiI7RVbSQYXxLcj1w6Pz9W47kNgRS7chJSZDpkok+dQwDUYrpE
 MKaQ==
X-Gm-Message-State: AOJu0YzOsR+egzdGRGuFXZoy498VxOMaxQbd1jJNPoJbNGyBLOvZO/PP
 6DM1f4dttY4nu7LOuVZ/WNGkfyfnHP+DHFCLvmOqUqLJBWpKb7Qowm1lxQc8IE2hQAu2OMN5d9+
 ZUkQefs3V+A==
X-Gm-Gg: ASbGnctDhCAcPQzzp11dThr2JDCXh9grBdDHommuSNyVFEYRVOSDF7IYKMoOLBRFMzU
 HvvWc5eyrMoBmxw1vJU2DQACOTdBaMeGMl7IJsF/KNHZxb0s5zqJmi9iKvuINHuTvDsRkgfooOq
 ofFZxpJeI+FX4qGnM6zv0lJ1tEM4nFCSGaeckEHerpiwLMemJaRJl43Z4FDv110afFAeq8GioxD
 Zi4CmxNcrNYehVyYFyOPVd2FJwfG8U9lhk1F97+LpcvdN2yDmSOjFXUEvR76Nkpevl2t1FJc6Lj
 RF0ZQLB5ufRxHx6iqx1pUol7duJZH/S351VmYzFYUyM/2kw3PJPMkxEzLcLL7VIp/KZV6CWRgt/
 JZ3T/E5ZxE8nYE5+0y9tcGbI=
X-Google-Smtp-Source: AGHT+IGCIzSs++vG4Q/r44POEQofytYBuUaIuGpsL8NKxkWgprP60aqkJ1SOMVPil+NtFGgd+q+1ug==
X-Received: by 2002:a05:6402:2356:b0:61c:e287:7ad3 with SMTP id
 4fb4d7f45d1cf-61d22dfbd0emr19350555a12.6.1756973524107; 
 Thu, 04 Sep 2025 01:12:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc216304sm12809226a12.19.2025.09.04.01.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE271603EE;
 Thu, 04 Sep 2025 09:11:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 058/281] linux-user: Move get_elf_hwcap to mips/elfload.c
Date: Thu,  4 Sep 2025 09:07:32 +0100
Message-ID: <20250904081128.1942269-59-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Change the return type to abi_ulong, and pass in the cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            |  2 +-
 linux-user/mips/target_elf.h   |  2 ++
 linux-user/mips64/target_elf.h |  2 ++
 linux-user/elfload.c           | 52 +---------------------------------
 linux-user/mips/elfload.c      | 50 ++++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 92b6d41145e..04457737dd4 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -103,7 +103,7 @@ const char *get_elf_cpu_model(uint32_t eflags);
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
     || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index febf710c7ae..877f8347d70 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 02e6d14840a..c0347e5cb6e 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 574b37a22c1..dc3f502277a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -834,57 +834,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-/* See arch/mips/include/uapi/asm/hwcap.h.  */
-enum {
-    HWCAP_MIPS_R6           = (1 << 0),
-    HWCAP_MIPS_MSA          = (1 << 1),
-    HWCAP_MIPS_CRC32        = (1 << 2),
-    HWCAP_MIPS_MIPS16       = (1 << 3),
-    HWCAP_MIPS_MDMX         = (1 << 4),
-    HWCAP_MIPS_MIPS3D       = (1 << 5),
-    HWCAP_MIPS_SMARTMIPS    = (1 << 6),
-    HWCAP_MIPS_DSP          = (1 << 7),
-    HWCAP_MIPS_DSP2         = (1 << 8),
-    HWCAP_MIPS_DSP3         = (1 << 9),
-    HWCAP_MIPS_MIPS16E2     = (1 << 10),
-    HWCAP_LOONGSON_MMI      = (1 << 11),
-    HWCAP_LOONGSON_EXT      = (1 << 12),
-    HWCAP_LOONGSON_EXT2     = (1 << 13),
-    HWCAP_LOONGSON_CPUCFG   = (1 << 14),
-};
-
-#define ELF_HWCAP get_elf_hwcap()
-
-#define GET_FEATURE_INSN(_flag, _hwcap) \
-    do { if (cpu->env.insn_flags & (_flag)) { hwcaps |= _hwcap; } } while (0)
-
-#define GET_FEATURE_REG_SET(_reg, _mask, _hwcap) \
-    do { if (cpu->env._reg & (_mask)) { hwcaps |= _hwcap; } } while (0)
-
-#define GET_FEATURE_REG_EQU(_reg, _start, _length, _val, _hwcap) \
-    do { \
-        if (extract32(cpu->env._reg, (_start), (_length)) == (_val)) { \
-            hwcaps |= _hwcap; \
-        } \
-    } while (0)
-
-static uint32_t get_elf_hwcap(void)
-{
-    MIPSCPU *cpu = MIPS_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
-
-    GET_FEATURE_REG_EQU(CP0_Config0, CP0C0_AR, CP0C0_AR_LENGTH,
-                        2, HWCAP_MIPS_R6);
-    GET_FEATURE_REG_SET(CP0_Config3, 1 << CP0C3_MSAP, HWCAP_MIPS_MSA);
-    GET_FEATURE_INSN(ASE_LMMI, HWCAP_LOONGSON_MMI);
-    GET_FEATURE_INSN(ASE_LEXT, HWCAP_LOONGSON_EXT);
-
-    return hwcaps;
-}
-
-#undef GET_FEATURE_REG_EQU
-#undef GET_FEATURE_REG_SET
-#undef GET_FEATURE_INSN
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #endif /* TARGET_MIPS */
 
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 04e3b767401..739f71c21b1 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -42,3 +42,53 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "24Kf";
 #endif
 }
+
+/* See arch/mips/include/uapi/asm/hwcap.h.  */
+enum {
+    HWCAP_MIPS_R6           = (1 << 0),
+    HWCAP_MIPS_MSA          = (1 << 1),
+    HWCAP_MIPS_CRC32        = (1 << 2),
+    HWCAP_MIPS_MIPS16       = (1 << 3),
+    HWCAP_MIPS_MDMX         = (1 << 4),
+    HWCAP_MIPS_MIPS3D       = (1 << 5),
+    HWCAP_MIPS_SMARTMIPS    = (1 << 6),
+    HWCAP_MIPS_DSP          = (1 << 7),
+    HWCAP_MIPS_DSP2         = (1 << 8),
+    HWCAP_MIPS_DSP3         = (1 << 9),
+    HWCAP_MIPS_MIPS16E2     = (1 << 10),
+    HWCAP_LOONGSON_MMI      = (1 << 11),
+    HWCAP_LOONGSON_EXT      = (1 << 12),
+    HWCAP_LOONGSON_EXT2     = (1 << 13),
+    HWCAP_LOONGSON_CPUCFG   = (1 << 14),
+};
+
+#define GET_FEATURE_INSN(_flag, _hwcap) \
+    do { if (cpu->env.insn_flags & (_flag)) { hwcaps |= _hwcap; } } while (0)
+
+#define GET_FEATURE_REG_SET(_reg, _mask, _hwcap) \
+    do { if (cpu->env._reg & (_mask)) { hwcaps |= _hwcap; } } while (0)
+
+#define GET_FEATURE_REG_EQU(_reg, _start, _length, _val, _hwcap) \
+    do { \
+        if (extract32(cpu->env._reg, (_start), (_length)) == (_val)) { \
+            hwcaps |= _hwcap; \
+        } \
+    } while (0)
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+    abi_ulong hwcaps = 0;
+
+    GET_FEATURE_REG_EQU(CP0_Config0, CP0C0_AR, CP0C0_AR_LENGTH,
+                        2, HWCAP_MIPS_R6);
+    GET_FEATURE_REG_SET(CP0_Config3, 1 << CP0C3_MSAP, HWCAP_MIPS_MSA);
+    GET_FEATURE_INSN(ASE_LMMI, HWCAP_LOONGSON_MMI);
+    GET_FEATURE_INSN(ASE_LEXT, HWCAP_LOONGSON_EXT);
+
+    return hwcaps;
+}
+
+#undef GET_FEATURE_REG_EQU
+#undef GET_FEATURE_REG_SET
+#undef GET_FEATURE_INSN
-- 
2.47.2


