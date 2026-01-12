Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E7CC9EC68
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDL-0001yg-Mc; Mon, 12 Jan 2026 05:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFD4-0001Rs-F2
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFD2-0001kw-Qn
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so22597095e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213898; x=1768818698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgCkB/cCjci88novh5LUA6gxo5hF4mBrKIWSSmV2nEQ=;
 b=xi+frKiL5qoFeSlNzhb8px0ARu7nSgzHKr37solLyVAH3+/CKp+KxJ2M8T6gwISjPh
 5FnmRNvv4xRC+EaGfQ7p2ErDP2i/645PhVAKo9K/okA0gnhucM7morHDN/KyxWm0mwQX
 JnOjplLgF89gyEg0jlidgP7qSXwUVUMmtJAFhiE23o9qGqxFvxVMuk9kLThKysJjGCaD
 TaWqnTrlvWeqCavp+vM9Kb97QutArlzaiOOeKd/q1gxgzKTGMkQNCyF8XKw3Wf/9zfjz
 g0LVdqfpzpjNVS07ki13stwGsSx0+/2D0xxV+9hzO+kQ3TeolqandhPA0jXMl7EnsZWd
 ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213898; x=1768818698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TgCkB/cCjci88novh5LUA6gxo5hF4mBrKIWSSmV2nEQ=;
 b=OyUyuSr8EGHEJ6v2zpfYw7m+xlaUfNMKoIzqVC2Vj+8mFU/nuJeSn6uCAjxPCE3XTB
 ELgTp5y34G1mml7WlFfUBLMqyUSzMyPbk2IrNyub+9RzDZchr8MG94G4N8MfvJNVRtoE
 Bvi294VH24kTgrMJXm25ITcGoZSJvUkh5QiAXQtxxT/PL8NN9ggZ0jpHC/AJvHogQ4+B
 XWrMJSJWDsj/87+fmpOi4Yq9vKC5V1S59Rz/3/pEdgLsmqQE9nQVTaJVU4BZy4e2LIJs
 Um8OF2A+wG1CSPImu0qWl5X/hyogBwxTyVtEzz0BB4bDRxX/IjDQGNRi4pFPXP1/NnrT
 sD6g==
X-Gm-Message-State: AOJu0YwZ4sO8Qfb6NZrP1gVHj+tMd/7c/d/bwspJs/pC/2H5KTZuvydy
 I4i0RKAZFrwER/2h8f+b2ilj2sAx6dUjiSjJrRLgNy2bKeoW2zVAa4fhT2+HILQtV6/k9DQ/FM1
 KUQTBpwQ=
X-Gm-Gg: AY/fxX40W7vhXq+nyNJBSa4zRKH4SHV7kuwtpVk9UH2uF78EQ9qR0r2yNq0JIbQBnUk
 XvJ5nldMTeRbaaHgfrI4cdDVKR0tb+F/zS9QHlki65d5DzfTba/6+QFcaVVZ4TR/U5Rt4sp0ILT
 bTzbBPCxf5Hu/BuTDuZBGGNThWl/KVxebs2Q3FJE/t/fHYtxAznah8d50axs9FoRnB+V1eT6qz4
 l3wFU6DINDL/95C9Jj1mNgDhwVtMm2A7QnPB0nRC2XSHqIT+6LJPWTmR5mq2UHZDC9k5+3BUj+r
 eZ1dcYaRW2PGm3VDdW8cpsAsAMKekOmHQtgRXOSmp8EeGO1TJpV9clNVR4nIPkgacG2AQr4fTge
 V0PNQzAOszCmrS+E24WWhCgoGheKw7yvvSylFXto/FJ/TEpNznTyGwZuNg9Re0krs+diRg/hy4C
 4LutBhNHMxpy1Ea8J6hviXAeCboQvonrNuBVXoCPlur42fZBxDiglchb29Hb34tbWi5XTELD0=
X-Google-Smtp-Source: AGHT+IF8maqCDS62Rc3D1MaSXWcC9wINio3H+5HILmC7bsCDhFLwRisLg/IrkiWfxxWNlfja6ugfgA==
X-Received: by 2002:a05:600c:198a:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47d8484a113mr219245415e9.5.1768213898184; 
 Mon, 12 Jan 2026 02:31:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f418538sm347901565e9.5.2026.01.12.02.31.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:31:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 09/19] accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
Date: Mon, 12 Jan 2026 11:30:23 +0100
Message-ID: <20260112103034.65310-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These are now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/hvf_int.h  | 13 -------------
 accel/hvf/hvf-accel-ops.c | 14 --------------
 2 files changed, 27 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index ee7ab689f45..d842d4b2b99 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -24,15 +24,6 @@ typedef hv_vcpu_t hvf_vcpuid;
 typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
-typedef struct hvf_slot {
-    uint64_t start;
-    uint64_t size;
-    uint8_t *mem;
-    int slot_id;
-    uint32_t flags;
-    MemoryRegion *region;
-} hvf_slot;
-
 typedef struct hvf_vcpu_caps {
     uint64_t vmx_cap_pinbased;
     uint64_t vmx_cap_procbased;
@@ -45,9 +36,6 @@ typedef struct hvf_vcpu_caps {
 struct HVFState {
     AccelState parent_obj;
 
-    hvf_slot slots[32];
-    int num_slots;
-
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
@@ -70,7 +58,6 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index e4c62522e10..d931412975c 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -64,20 +64,6 @@ HVFState *hvf_state;
 
 /* Memory slots */
 
-hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
-{
-    hvf_slot *slot;
-    int x;
-    for (x = 0; x < hvf_state->num_slots; ++x) {
-        slot = &hvf_state->slots[x];
-        if (slot->size && start < (slot->start + slot->size) &&
-            (start + size) > slot->start) {
-            return slot;
-        }
-    }
-    return NULL;
-}
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-- 
2.52.0


