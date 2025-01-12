Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72039C02184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6K0-00047z-JH; Sun, 12 Jan 2025 17:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ju-0003wg-Mr
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:34 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jt-0006qQ-0A
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so2617385f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720431; x=1737325231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jil+o2IQDaDmjXLDPhi86OTUn7ZHj1cgkkurPDaXzxg=;
 b=k/GjommW4zSAdoxD62d4MC6jYl+JR3Wp5W6q1MvjRase5aDpE7DcViIF4W7lBLpDuG
 iSJPxuwnZKa82HZepdypTC0o6NQ4YltQpbePtyYFvi7yTFnTtn4FFSkBxj6hExwTqjte
 ZICpq4IREe86Mj+Oj4IdUJRjbLYsD8EhKNu74bgtGbQIOKTF6uex5C9YNxIGY8PY/8jV
 DAOQb2vh91ffM7oL17kHNHGhJIwlVl/G3MeOhza7nXC9jagh8kk0OaLHrEd5ycw+thmV
 GHD5f3cYYWgJD2smrJRavqzY4eU3ulafGInefcAeIdO/NAzp0ShKIBW+FWTQZYp9dcbX
 JHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720431; x=1737325231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jil+o2IQDaDmjXLDPhi86OTUn7ZHj1cgkkurPDaXzxg=;
 b=CgQXdBelGUuqn/OLUgbOg+JukMBaAZFWqiIOZF5RUJqiEB7VusYcEh2DtmOO5/vV3y
 poig84v2pzVUAvM9Y9rg9HV3C26qJlE7TqwfutlwyY40NIvaG2dtei4KXMdrcBojpyvP
 z3ctke/LY9KQDn/Du9rclaFtRim0CsurQmiNYYJzqBYRT1AcJ+kOol4y01DB7gRVYTpj
 OukD3dIM7TQd5td6On2FWgOo2cKQ8MzKkyNjeXjY0xd99ZUrQZ2fxiNbCAq9/OrvbIzp
 a273mms0Kik2S9W1gk4tYOz3Mv1ubDNNf6htJiiTgxngIp0HxnE7XV7rF3+xrlEsfm22
 aG/g==
X-Gm-Message-State: AOJu0YzaFWQi436CTENbkDTDY2ydBjRxgz1hvvLle/PBNZVt7qoe6FHI
 P5cNLWay65swp5OaBt4vqBEh5TtmBR/BzmMjOMqyz+kPUUl/C1QBeRow/nAH7QaBWaUoHiRSC2c
 thVo=
X-Gm-Gg: ASbGncuFQnTKb8v4sp0z5Z7wh3stWCu8EGr5Q+KytW84PGDH0yJeeANmZAAxZNR/y1k
 fjWdsIeyAZWQNRUjkEwLSKg6O9BW/Ok/IIs/Nwd17TGiUrq+iJ6EfjlhKKW0qLaMGPDZ/3O74US
 ws+LycfV9iczMExTFh4cdidpmPIkglffjKd+3JmVgtQugQyWEW4OFGWU8DPVgc7lrbmWGZj4ekC
 8UUA1DGk/kkAWxJaNhK2aq97iMq44Z7ZTW2pSuX5aVZlOe+twjBYdp4T+QKZEuJEJFdWK+e4JCC
 HtFzYD/CKr+29Ewgvo/fvsfC3Bb7Ubc=
X-Google-Smtp-Source: AGHT+IGaMy4xvDulvJQelEZ5nc9D0pAjMQR2n/2LbwfSbLwurOm8ZFjbIb3srXb66+BzbaFXv6cnNg==
X-Received: by 2002:a05:6000:1445:b0:385:df6d:6fc7 with SMTP id
 ffacd0b85a97d-38a8730ce5amr17874848f8f.25.1736720431179; 
 Sun, 12 Jan 2025 14:20:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8180sm10563092f8f.76.2025.01.12.14.20.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/49] target/hppa: Convert hppa_cpu_init() to ResetHold handler
Date: Sun, 12 Jan 2025 23:17:13 +0100
Message-ID: <20250112221726.30206-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
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
Message-Id: <20241231190620.24442-3-philmd@linaro.org>
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


