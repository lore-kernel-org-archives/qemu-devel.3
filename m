Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8801FE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHeA-0002aO-66; Mon, 30 Dec 2024 10:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHe6-0002ZD-JF
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:31 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHe4-0001kc-Oo
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:30 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3863703258fso6058590f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735572326; x=1736177126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPnjzUL72sgItT6b5Sz5QnXH2c6Pz/4KB/mKuiBnROI=;
 b=qUd0zZKBacdY1lmGuIsKM4/l0lfxqE/GHB5dE6EEkv4YFg4DedG0WWPr4P4FKUPl6G
 ZkwqjwDSP4YXTbaMFFq+F8i1II0EqTHfFGW9c5OvgNmS36RWzN/ZMv4ncVmg2YJsHdMy
 azzrkUYElnaClImEFszv08G9SRCKuVuVrGRlyta4t9S9nxo5FmaVM/E1JFBa/f5dHE6t
 g1NBC7fx8sWtanDfaG8ePqqGIAhbjplldU+K6OIzXN9kdW5aZ/oKdDkF5/xGVRzcfFVK
 qwhCuqzBBTLdhPzlYAWTUpWtV4EHUTYTL/xoI/n8Lv0csIQQvV7T7XNGiRmzTKo7/8wM
 eu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572326; x=1736177126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPnjzUL72sgItT6b5Sz5QnXH2c6Pz/4KB/mKuiBnROI=;
 b=FGHQoqPmsRKnbH4LGSX3molyV2KH9tPEa12qk4OFDs2c71dSfaUyC+FRJhvDRRFqZo
 KAbbziN+Af0Dw/NEMgXRspQL+yysu7EP8V7/7TWUqnkdrZEkxU08oQm7B6IC+N3suAjv
 tuBb9h2S5HVgeKNll3Nx/NiOZaIBEped+uRSt5EWUDosTI38sEncjDmLGIh+KC0EeSgD
 8jC17WhwBpHh0KIdsvlvntJ68KMXxQSiEFXEbk21VEH7EIHJlUcXm/TuWtvxjTpHlt8j
 Ftw/dg0w/awKj6oTWu2YUXqMOrHWc2DOJpI7rY1X2DLFdAnifFRsS/KAHOkxe1iFveMW
 t7dA==
X-Gm-Message-State: AOJu0YwWLRpqVZGzf5ePvQReo1p40S/H2JdDUwOh0RaHJvLo29Z4ZK/2
 yzbTnNoW2PKdLJ77IQwtp73E+LLQggSRIM7frkKDQHFXWJ1JwbVjg369GJHK0yB3ratTkmE6LyQ
 c
X-Gm-Gg: ASbGncvv38Om/amxFHzgPgU8bZ21ipNZnydp+4WFexoa6GILJ8ATxFRmRt7+lmkYQYC
 7ClawL1SYT8pQdlzTxgnQVKqBYSaelN+GWcVL7UpAm2IZ3aWl4xASyNYJOuL/xlxOSb5kpq/lOH
 7ZWVfzaBUJR9wtk37544Aji5M7RehVYP8+JMRtyKlpeDsXPO0Z73BWGajLPcA16zPWHfm0FLEuM
 4KtAGmROl9vaorI0Ccf0+LcfnRmd9fnApcv+23SGEiXH1l0H3zBmH073Oo41yQkG6VA6ZhvTBvE
 Att7PEPRKzQt3dRjv8LA30/2s2wXuv4=
X-Google-Smtp-Source: AGHT+IGV165AGx+em2NSOIDMA4X2sI7wuneVYzGfxTGrMoPVau29FqpcjyMTzO6uF8Zqn0uMSzWxWg==
X-Received: by 2002:a5d:6d03:0:b0:386:3213:5b80 with SMTP id
 ffacd0b85a97d-38a1a274920mr32626591f8f.24.1735572326433; 
 Mon, 30 Dec 2024 07:25:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436724169afsm308022965e9.25.2024.12.30.07.25.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:25:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/5] target/hppa: Convert hppa_cpu_init() to ResetHold
 handler
Date: Mon, 30 Dec 2024 16:25:15 +0100
Message-ID: <20241230152519.86291-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230152519.86291-1-philmd@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Helge Deller <deller@gmx.de>

hppa_cpu_initfn() is called once when a HPPA CPU instance is
initialized, but it sets fields which should be set each time
a CPU resets. Rename it as a reset handler, having it matching
the ResettablePhases::hold() signature, and register it as
ResettableClass handler.

Since on reset the CPU registers and TLB entries are expected
to be zero, add a memset() call clearing CPUHPPAState up to
the &end_reset_fields marker.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h |  5 +++++
 target/hppa/cpu.c | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 22a6510e087..c1d69c1a835 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -263,6 +263,9 @@ typedef struct CPUArchState {
     IntervalTreeRoot tlb_root;
 
     HPPATLBEntry tlb[HPPA_TLB_ENTRIES];
+
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
 } CPUHPPAState;
 
 /**
@@ -281,6 +284,7 @@ struct ArchCPU {
 /**
  * HPPACPUClass:
  * @parent_realize: The parent class' realize handler.
+ * @parent_phases: The parent class' reset phase handlers.
  *
  * An HPPA CPU model.
  */
@@ -288,6 +292,7 @@ struct HPPACPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
 };
 
 #include "exec/cpu-all.h"
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 47d01609557..d784bcdd602 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -193,13 +193,20 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     tcg_cflags_set(cs, CF_PCREL);
 }
 
-static void hppa_cpu_initfn(Object *obj)
+static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 {
+    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(obj);
     CPUState *cs = CPU(obj);
     HPPACPU *cpu = HPPA_CPU(obj);
     CPUHPPAState *env = &cpu->env;
 
+    if (scc->parent_phases.hold) {
+        scc->parent_phases.hold(obj, type);
+    }
     cs->exception_index = -1;
+
+    memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
+
     cpu_hppa_loaded_fr0(env);
     cpu_hppa_put_psw(env, PSW_W);
 }
@@ -242,10 +249,14 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
     HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     device_class_set_parent_realize(dc, hppa_cpu_realizefn,
                                     &acc->parent_realize);
 
+    resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_hold, NULL,
+                                       &acc->parent_phases);
+
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
@@ -269,7 +280,6 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(HPPACPU),
         .instance_align = __alignof(HPPACPU),
-        .instance_init = hppa_cpu_initfn,
         .abstract = false,
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
-- 
2.47.1


