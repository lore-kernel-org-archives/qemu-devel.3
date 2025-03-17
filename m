Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB2C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBSI-0000gr-IB; Mon, 17 Mar 2025 10:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSA-0000ah-9Q
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBS6-00019c-SE
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso14434815e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221705; x=1742826505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r0RXj7jkfyGIIHIemiTV2rQyBmqYdyg7U5RYGOz4wfM=;
 b=vDkoqEt/T2wTWpoXTANMb6bjfhy58J359d77mdBu+FBWtyEL2fFPaZpRgMsFmm/utb
 K+fhs5tNyoauwQCusBdPxcbCUHD4ZO9flqIE/MrxT6dNuyjFsIbRFeiNa6M60i2lPKj9
 ekYFbDTradsmf6gvQ7ddIb5xX7VpEYVIq0lsGuKfeYEbaPtNMwMMWNYdtOqSthneiagn
 jYcVEvSMXqx8H78p8XjfymokivxfTqwBBdBekGld/QXRyLe+i7MNvUG2FWP15U09z4PS
 kjXDhfv+AEdLApTsqvvwvHfMU49QHokMRODEk/0MbnSSXtVgk5OAVB2yq3oEM+mJPlp4
 zwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221705; x=1742826505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0RXj7jkfyGIIHIemiTV2rQyBmqYdyg7U5RYGOz4wfM=;
 b=sQYW8vVDdQtog+PYvqmsVZ+KenGsYD9XUBzuAhc1QhoAlgET7TyCvfakUIkhypsQ3u
 SL60QFpRixCVdxcyYhi5cDB4ovRSDHYHDOyr+fWV53ZI/dGP1ahnEM7jDpJ3RB4bvv72
 EpPB8ukZgo79D3ott0gZWoozYvc4kJGV4NvCSBpBG9zhja8qIkqxD4+K26M/gURMdChE
 oF8rijtjyelqX1a4M3Ciq2BJxe+t+50V1eu+6s/49TgvxsD7ONzazUdwg1aSma6leZqM
 Qn42rneRHhWriRoVSr7JUgqy/eg+qehhTeccj+F+fQ0QkJHEOgo6b6ibwdJ+EJKEYKti
 rDog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgM7eANvzjvEmF8Q+F5IrMFk3/1HnLyteyKCvuC0h9mZ1gtlpIZtkkd9fcFbQwgnM4zumpZaRxhwVK@nongnu.org
X-Gm-Message-State: AOJu0Ywq1oyk46D4TFej2jhVbInGxP6peDgCkJYsESKRHyMlg4KzuO6u
 tgxfl7flvlie4ajL81vnj1NsWdre+LvXG0sPw+cAQDI/M6SVwmefqdhoQQDiYIA=
X-Gm-Gg: ASbGncup8oPVrXaDi8fP+N6nL7FHLDsYM5/40UVQsXpE7IVgK14g22eqrF6OzQMf0j0
 vF7A7mf6jFS7v1cjonA9cBjiT11F8AA2pK6l8Y/cTUsMdjtg+t5y06CfAUMmA5OefhWLJJGF7AL
 FX0IhC9cLGmwIxIRQzguQQp/BEVlxeVAEw4wvMOvYoRWWq192LqktzaKqtp8V0qB0RAxUe14MpI
 p/HWetbCbt4UTm+gdy/M6r/hk0ig/V0Bs6ss7D3SyXHJTkGMt7eVe34CxdYPVw1y/nDl2EjVmOl
 iMWWAkRyivEtEQtjVU31/QsCQdN8J3jZDlu3EXUxCidbEpv4hKsKaidnIqzFug==
X-Google-Smtp-Source: AGHT+IHFSEsW1sFp2DzSYMzCONdn1uXheMf21KtNFzkhb9ByC2UWNy6DFOF/4DSRcXlqamGqs/bIXQ==
X-Received: by 2002:a05:600c:3146:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43d1ecb33b0mr126240395e9.12.1742221705039; 
 Mon, 17 Mar 2025 07:28:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 4/9] target/arm: Handle gdb_core_xml_file in
 TYPE_ARM_CPU
Date: Mon, 17 Mar 2025 14:28:14 +0000
Message-ID: <20250317142819.900029-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Instead of having the TYPE_AARCH64_CPU subclass set
CPUClass:gdb_core_xml_file to a different value from that that
TYPE_ARM_CPU uses, implement the gdb_get_core_xml_file method in the
TYPE_ARM_CPU class to return either the AArch64 or AArch32 XML file
name.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c         | 16 +++++++++++++++-
 target/arm/cpu64.c       |  1 -
 target/arm/tcg/cpu-v7m.c |  1 -
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d69403fda90..75d5df4879b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2656,6 +2656,20 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
     return "arm";
 }
 
+static const char *arm_gdb_get_core_xml_file(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    if (arm_gdbstub_is_aarch64(cpu)) {
+        return "aarch64-core.xml";
+    }
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return "arm-m-profile.xml";
+    }
+    return "arm-core.xml";
+}
+
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -2721,6 +2735,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_arch_name = arm_gdb_arch_name;
+    cc->gdb_get_core_xml_file = arm_gdb_get_core_xml_file;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = arm_disas_set_info;
 
@@ -2743,7 +2758,6 @@ static void cpu_register_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(acc);
 
     acc->info = data;
-    cc->gdb_core_xml_file = "arm-core.xml";
     if (acc->info->deprecation_note) {
         cc->deprecation_note = acc->info->deprecation_note;
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 020b32f21e9..3094df366ec 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -819,7 +819,6 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
-    cc->gdb_core_xml_file = "aarch64-core.xml";
 
     object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
                                    aarch64_cpu_set_aarch64);
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c4dd3092726..8acaf860b68 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -261,7 +261,6 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
 
     acc->info = data;
     cc->tcg_ops = &arm_v7m_tcg_ops;
-    cc->gdb_core_xml_file = "arm-m-profile.xml";
 }
 
 static const ARMCPUInfo arm_v7m_cpus[] = {
-- 
2.43.0


