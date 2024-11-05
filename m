Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB3DD3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLM-0005CZ-KZ; Tue, 05 Nov 2024 17:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLL-00058Z-8U
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLJ-0004BP-D1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso47327535e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846888; x=1731451688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gpj/6+nLFblpRQtQ+ONP0MUNthGtqlf8yB3BXprEltE=;
 b=y+Ifq54Cqk9qUV8NJ8twH6hMv8WuFSmtsDnxUPJrKsrsOLPVenKVDd707ByXDruftD
 IXiTLWMtlVYQVMwRrvEZSw6Nnn0oYlq/27wV+ewKtuexmJyygSXWmhYwAQAcZyz+OpOY
 5GBq90eGG9y2IiEB3UeLrryDFlfHcVGqbD+2zGwUefYpgsss4Pl5ixvTSn7VndC7waNg
 2/mPVQd457Ucj2B7GsJZ4VT1Dtea+rAMU6imrpO6T5+DPUO82kYqJTm9f7CvrROdxPB5
 eA1H7xp0kU2iAFOPsfPSk4wEmCXdbhe7fNEHghnPEqcpTXJKvdayN091fgqjdwvRmpvZ
 X3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846888; x=1731451688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gpj/6+nLFblpRQtQ+ONP0MUNthGtqlf8yB3BXprEltE=;
 b=PZX5elwMe1yHM/14mv4if2dZe8RZCTb5Wls73cNALhtg+aw2s3DjS116f2a5WoIwHT
 ULcmdjov4eo5wfawostEJedu9yP1yoYQsBeCjIHmUJ9LmAeITNzoooxAsJXlNXNGLMHm
 XSBrg88kycVROlRtaD07R27W0V4KFh+fbjD8TYC0ypQy+oT7J9jFfk8Uxy6u3/Q3kqN2
 zY1FdHyjxWfThTgemFECclh4TTsO3szVvvhdWwBowa8qR31gTHelBuSLOikRtWw/huHp
 zVS+/m2WuODq9aUkTuu2jzHCtdSu/xy0tjdfapxeU+ptbmJ48/aKmZC8KFQcA93JyLg+
 EW7w==
X-Gm-Message-State: AOJu0YyIGSzBhTS/vonOtbyTemIrHOn1ynNHCoKzzGB69Ics8mYjhnDW
 KSLtZBTexzDhuu4LTUNM+L1INJ0TGxOQmcecocYgSTNRI/IDv1bb7hol/f1Z6u99AomNPz4zeoR
 0DQ/CHw==
X-Google-Smtp-Source: AGHT+IF890lMStFzywhOVntw8bC/ZOrdXcBJ43tmNhBNT2NK8cZBgLC7Dy0t/KzIy1EVPwJ5uhfaUw==
X-Received: by 2002:a05:600c:458f:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-4319ad047a7mr332037115e9.24.1730846887681; 
 Tue, 05 Nov 2024 14:48:07 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4141sm17424052f8f.28.2024.11.05.14.48.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/29] i386/cpu: Don't enumerate the "invalid" CPU topology
 level
Date: Tue,  5 Nov 2024 22:47:05 +0000
Message-ID: <20241105224727.53059-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

In the follow-up change, the CPU topology enumeration will be moved to
QAPI. And considerring "invalid" should not be exposed to QAPI as an
unsettable item, so, as a preparation for future changes, remove
"invalid" level from the current CPU topology enumeration structure
and define it by a macro instead.

Due to the removal of the enumeration of "invalid", bit 0 of
CPUX86State.avail_cpu_topo bitmap will no longer correspond to "invalid"
level, but will start at the SMT level. Therefore, to honor this change,
update the encoding rule for CPUID[0x1F].

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <20241101083331.340178-2-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/topology.h |  3 ++-
 target/i386/cpu.c          | 13 ++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index dff49fce115..48b43edc5a9 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -62,6 +62,8 @@ typedef struct X86CPUTopoInfo {
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
+#define CPU_TOPO_LEVEL_INVALID CPU_TOPO_LEVEL_MAX
+
 /*
  * CPUTopoLevel is the general i386 topology hierarchical representation,
  * ordered by increasing hierarchical relationship.
@@ -69,7 +71,6 @@ typedef struct X86CPUTopoInfo {
  * or AMD (CPUID[0x80000026]).
  */
 enum CPUTopoLevel {
-    CPU_TOPO_LEVEL_INVALID,
     CPU_TOPO_LEVEL_SMT,
     CPU_TOPO_LEVEL_CORE,
     CPU_TOPO_LEVEL_MODULE,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3baa95481fb..ca13cf66a78 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -370,20 +370,21 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
                                 uint32_t *ecx, uint32_t *edx)
 {
     X86CPU *cpu = env_archcpu(env);
-    unsigned long level, next_level;
+    unsigned long level, base_level, next_level;
     uint32_t num_threads_next_level, offset_next_level;
 
-    assert(count + 1 < CPU_TOPO_LEVEL_MAX);
+    assert(count <= CPU_TOPO_LEVEL_PACKAGE);
 
     /*
      * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
-     * The search starts from bit 1 (CPU_TOPO_LEVEL_INVALID + 1).
+     * The search starts from bit 0 (CPU_TOPO_LEVEL_SMT).
      */
-    level = CPU_TOPO_LEVEL_INVALID;
+    level = CPU_TOPO_LEVEL_SMT;
+    base_level = level;
     for (int i = 0; i <= count; i++) {
         level = find_next_bit(env->avail_cpu_topo,
                               CPU_TOPO_LEVEL_PACKAGE,
-                              level + 1);
+                              base_level);
 
         /*
          * CPUID[0x1f] doesn't explicitly encode the package level,
@@ -394,6 +395,8 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
             level = CPU_TOPO_LEVEL_INVALID;
             break;
         }
+        /* Search the next level. */
+        base_level = level + 1;
     }
 
     if (level == CPU_TOPO_LEVEL_INVALID) {
-- 
2.45.2


