Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8231ACA101F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5Cd-0003JT-Hb; Thu, 04 Sep 2025 04:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5BG-0001Nm-Pk
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:18:56 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5B3-0008Et-15
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:18:54 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6188b5b113eso1224557a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973918; x=1757578718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTwVN2pdB6APtd4vJTidA71Ye17u96MfvC5vKsLhS50=;
 b=p1ae7NMzRSWnpR4jVCWgQ3pev7i0v6m9jCE7rPMi8lVC0+tCsL3MG33Z/Yg8MQ+a/X
 lJeUD+ekFS9ayuxSIp98rC6iYP5XDdnRy8M61+tNqbKM08ElbmzLZdR4TiQhQQw7ZC9i
 MVuHp2KQ7LFd/SOwqYbfsMLxDfvGFL2zXUQQAA32hScVJZz678Dx9cW5Mzh6HisbWZzT
 wQJn/EvajGpO5M1f5AQZO6fEJpSQKBE4DAvGSPoweM6MF1JuuVZxpx/IxBbbgl1O/a8d
 peRzpvZChswNHdfwVBqVbgMwsezZgsve9ydxEuisSSIhN5BqaSQUbV6Iry2K0DHugEtz
 WBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973918; x=1757578718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTwVN2pdB6APtd4vJTidA71Ye17u96MfvC5vKsLhS50=;
 b=QfieYO08ZcYt9U8TJfT93tlhwswBrXlZ78QJZL2gPBBtZ8aGWvYJPDAT9tuEo1MYCB
 TIaYakDwOn5jQ16QRGlcTnNKVl+tgnzuitKEmX5/QD6HdkMkf+39pgdNtPmUB9oDlmi2
 DDLeRA7eR+a1bGn+QtffRNfMkV98gNohbsoupYan60aRDKEBmsO8ANQs6yYLDf50T6ZY
 wDgDvnvLU9xyUqj3Jks85p6i0LA+a4LFnck8jvmu/KkxyWnsoTY2Y2/Kc3igxyNbp5hV
 v+5c/mre2LTcKA13SC5Oth4CCZiVNaXcqbfcEKsHq6F56QtZ1mIsOjqy28ZRPKeW06Ky
 MgQg==
X-Gm-Message-State: AOJu0YyLWs2p1lFshfbHTzGnhes2ft06clvQseFFo3SM5AtOB3BiOrxs
 srFQKKjNDFtPzYnkJCoE0CAGt/Q9huGfu6dy4j9V8e9VjdzF6GmqXml+416ScOZ9UruM68RfBwn
 YkxIZBGCGyQ==
X-Gm-Gg: ASbGncv4TfAUFc7F/l+m9qHmtz3/AgSA0OK7OWJpXe+e/iczonz/Sya9q92em8KGGzQ
 pF3wrPhVW2M2dLwYDixxvxVzYyoo/RsivSLokUVrGy0BrCwVF0J8tz4UyXf1MThwXCD64c3lpyf
 I2VCHamunWOTNWiXGDUKc83VWFKnx9T2ZOG6n41v3Msz4LLotKqU2D8/Dv3UKaMYXzNqqWTQlet
 REZ8HN/zf7uzXJLtZVC6PIZjiD5nqeOAebN9+MPjFqa46+uUoG3KAUrlf7RYIB9dOmkBaqLuymf
 NV6uhSoMVHX4QEMdTgLr7l8H8NoOde4w4VgrcDUcbuYBWRkNB6gOFSfxsHZQ5MCxmcf/tTJ6WXO
 QRNcOAVR0fYiQeCWMSzlvguswbvVlFJz5kQ==
X-Google-Smtp-Source: AGHT+IF1g0xPlQZwXvixbktzxWp7pylp9yJpF3ozVocEpxZl4vhVy/vLrP8CDNUZO12I//3cD7pawA==
X-Received: by 2002:a17:907:7e86:b0:afe:ad18:8662 with SMTP id
 a640c23a62f3a-b01d8c74c8emr1897318666b.23.1756973918422; 
 Thu, 04 Sep 2025 01:18:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff12a6b404sm1396323866b.88.2025.09.04.01.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:18:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CC61601C5;
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
Subject: [PATCH v2 055/281] linux-user: Move get_elf_hwcap to sparc/elfload.c
Date: Thu,  4 Sep 2025 09:07:29 +0100
Message-ID: <20250904081128.1942269-56-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
 linux-user/loader.h           |  3 ++-
 linux-user/sparc/target_elf.h |  2 ++
 linux-user/elfload.c          | 30 +-----------------------------
 linux-user/sparc/elfload.c    | 27 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 151a06f5db5..2c8414e0e53 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -101,7 +101,8 @@ extern unsigned long guest_stack_size;
 /* Note that Elf32 and Elf64 use uint32_t for e_flags. */
 const char *get_elf_cpu_model(uint32_t eflags);
 
-#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM)
+#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
+    || defined(TARGET_SPARC)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 7e46748d261..b7544db0a1c 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 149d1313c0a..16709865f78 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -565,35 +565,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#include "elf.h"
-
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    /* There are not many sparc32 hwcap bits -- we have all of them. */
-    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
-                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
-
-#ifdef TARGET_SPARC64
-    CPUSPARCState *env = cpu_env(thread_cpu);
-    uint32_t features = env->def.features;
-
-    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
-    /* 32x32 multiply and divide are efficient. */
-    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
-    /* We don't have an internal feature bit for this. */
-    r |= HWCAP_SPARC_POPC;
-    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
-    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
-    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
-    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
-    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
-    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
-#endif
-
-    return r;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 243e6f9b66a..32ca1b05b1a 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -13,3 +14,29 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "Fujitsu MB86904";
 #endif
 }
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    /* There are not many sparc32 hwcap bits -- we have all of them. */
+    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
+                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
+
+#ifdef TARGET_SPARC64
+    CPUSPARCState *env = cpu_env(cs);
+    uint32_t features = env->def.features;
+
+    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
+    /* 32x32 multiply and divide are efficient. */
+    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
+    /* We don't have an internal feature bit for this. */
+    r |= HWCAP_SPARC_POPC;
+    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
+    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
+    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
+    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
+    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
+#endif
+
+    return r;
+}
-- 
2.47.2


