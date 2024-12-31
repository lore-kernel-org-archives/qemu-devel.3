Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B512AE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShZe-0004I6-0S; Tue, 31 Dec 2024 14:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZc-0004Hy-51
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:36 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZa-00083S-Li
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:35 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so6410090f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735671992; x=1736276792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPnjzUL72sgItT6b5Sz5QnXH2c6Pz/4KB/mKuiBnROI=;
 b=vCTk8W1mwrNuq3Mfj67N/sMSrfmhOwHT8y2qJ+Yb71mIsLcB0kt81UMRyMg0IbXmP7
 OAXNpMGMWRzN8dN4ndOZk367RMdcnhaJFQmI9fHwEy50K5VtdXIgTLBZjZ8UNasAuSbc
 SpzvFrFdCdPs90ddqJYiQPSSuR0stzfVUSyr1k0oBay4zZAjNnahLESO917lPm6zH51a
 xStqCG+29x6Vh+Y5DrjzU1VEu4P8WlgOrgitS0blgOVB/d/MKEy6ZGNF/6lgYz1mJcnp
 Vsyz4ZPrgvGJZhlTtUV8hkSui2XlIGfSt2RdHcfdNKpnA5kdsFUAXJ3YAslmHcdKIRBO
 VnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735671992; x=1736276792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPnjzUL72sgItT6b5Sz5QnXH2c6Pz/4KB/mKuiBnROI=;
 b=oLWo+gjPBVXXx+a/AuTbc24Eg9dZK3KtH+muRxprg5DB/N1hQQQfges8NJKALeFjMq
 8yccUgxoGyJjYSw0PVOF29/W/8NnadqUEb6IVSdjklPsnMGpZ9Wyzcz8QFT/GFZQJoW0
 zy1LWRCb3tU4fVdfYiOR8maZjrG8/6u3n7u7dmVxcjU6UZNVCVvLvGSmHzx84In/xwZq
 W196U4pt5uC/3HLQPIkArGqiDUA7PO3UG54TobOVz14ACuR8sVVdc2DDEElDo4MKL3lQ
 zoKNolL+T6lvPQlKVJwrWJL4OdWW1875XdeUtHdWZpqWVSquhOd9NYDiYHDwhqSYoc3z
 +hDw==
X-Gm-Message-State: AOJu0YwVuu8TWjnaTfyLC9Sub7Kndhrgig7CJKv4k4BJxquUrPBKeEVw
 Uf8mnDXll/yVCpwpXhJBudUaIZOK9lvxOM8fgXhf2VpFoNAalZQkJxIBoJYJ1BkTROTqo2gI1LY
 ziZQ=
X-Gm-Gg: ASbGncupTvC3Yw3n37Wo9D09W1TPnLEsXJC321jOxpK00TeNlO2OplQofKxo85uHgvZ
 DwAz8q8dkCmqVtR49XA7quchESgto4JtTXRI5U5SpyDJJzbt81NDsaRvK+9l6NFl36BkxPdXTt5
 Bvt2YMfyya6Q9PXi/KQyDFFgs5oSLRQ0JmMyuvzaco62IfwCmOMccbdv4dvwwhkshGRbF4jIIzx
 q8pYMsQ0FRgUNwpNVYOUSUbj6PtpuJQbGx5Rsv5gw1w/hbGak7tmDYBZTu+5uqn6UQ+nUV7V0jf
 mzHlLj9A4qQvCtP+IowgFtAL6qY62dY=
X-Google-Smtp-Source: AGHT+IGwC6Y4XguVKkslsd1B5A1dSsN166LHpmC76L+VqO3R2P2NCmUZqlRGThOA0bOfFuVJKkB5Yg==
X-Received: by 2002:a5d:59ae:0:b0:385:f64e:f177 with SMTP id
 ffacd0b85a97d-38a22a11925mr32527923f8f.11.1735671992627; 
 Tue, 31 Dec 2024 11:06:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c848a47sm33074712f8f.62.2024.12.31.11.06.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 11:06:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 2/6] target/hppa: Convert hppa_cpu_init() to ResetHold
 handler
Date: Tue, 31 Dec 2024 20:06:16 +0100
Message-ID: <20241231190620.24442-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231190620.24442-1-philmd@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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


