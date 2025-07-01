Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C728C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcD9-0002iF-IH; Tue, 01 Jul 2025 10:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCs-0002N7-9c
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCj-00074n-4E
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so35407445e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381001; x=1751985801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EjicFj3mKLXmtsZdVU/gL847hxXqbjFGE9VNE1eVX8=;
 b=dlHuoFPnyKRzJUIeohGLMgmIfPgualPyg96OCUCIL5K8pMEaU0giGVa/qreC3vaBHh
 +lv8a7jEZgHd80g5l3Sf/82YFJnusW+aBIwCsHCr4gSOH0ZB8eKf/9nzOzlMhGIKkZI0
 uIX4YBaCkExOAflPl7weU1o0xKAFHcXtQX8eyezvijjZWPm/MuHzE4uJbETX5aMTPCp+
 /S4C+Ll98fDjrOThGnb8y13wmcZMdnZqpa1ihBktRtW/TFggTlgvs/PWI8fu3QZCdsHr
 O4RlXD1pyHWfJluv5ZlSJ89ijRiIMnRfA10aHI790oth5TAz7RtCwAGmuNz5BY22iHoy
 P8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381001; x=1751985801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EjicFj3mKLXmtsZdVU/gL847hxXqbjFGE9VNE1eVX8=;
 b=OMGqEWQxJGDvG0L+LOnXF1y3bVq+bSFgUxzcEgaufvMaDrJfNis/FYgGNNgGwl/A9T
 ImW6onDr1fsdbIxwO2uYFQzcMmWnCzpMgcyTgOqwqE+52RUTupmiM45Lxs+X9zwk2a8u
 dS0fukwg15jGueawovPpf28rFVfvuzIYJoFOxDtLaPc/m+CzancnOMAHKR2qi5VcYHu3
 I1kZa6QxcdjiIrPhVRV7zH39tpBL6V6UI3g8w5+RHRCeYcgdUSLvCP5GEXO1zHc5+afx
 qYKUjRvhT5eH9EPvYWfk5MPbdUG9txMgk9g07ez5yMxZN/47h+pHadEQmWdHRupG20XG
 Mgiw==
X-Gm-Message-State: AOJu0Yx1G2Avc/Xe+0f99oZ7O5NJoeB2o3ymgl4kU0HgKRC4ACP2ysoq
 sovluojR2GPOCyC1/vCWdvWoAq/QkU4Lnxyr/sLcDxbkEgpbsH/LqKCyxtsV/GmSvGjcfHuibyx
 wqSeK
X-Gm-Gg: ASbGncvNWi+3dDl5q4Cz0LiWgdnGaxSWCuof/hX9hd3AG/HS3dhA7xwbKnUFyE+n/H2
 eqWB+x3gsYYCGIoNnRrXdyPXQF7TOp3CVTABfR4sS+dAJQdtx2ytuH16fu8QDd+rTzrF5vfmTSj
 fBnUMedAMwgjBWuTJNi198iAE4GgYHNQHwAqbELq2SusdsLzmjgl1/rj8ldMhLwfga/GzsCg38V
 Die7mLlEvT1aOVT6448IQtfihX4lTxhRlpQaOTms8iEx6pryj1kWzaxfQ7k3zt0oyFt3dP7BrBj
 unoHrHyZaq2gAZN+TZyvQlmIpds9qwMmoLnSWkA0pz2+Y22aTw8iCyVRhwe6xiNmnqfHl602JJ2
 dtVhfg//nMBT5FxKPGITAZXUQTNK+sdsyUDE0
X-Google-Smtp-Source: AGHT+IGPIFdIVCv7ShCYVOQDWmMRtChceLu/PhYtFQfmgEcq3I/IkPBcOouEFqbhP8YSKnDp3Sg5lw==
X-Received: by 2002:a05:600c:a46:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-4539726acc1mr148594725e9.3.1751381001440; 
 Tue, 01 Jul 2025 07:43:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a57c2sm167703985e9.12.2025.07.01.07.43.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 34/68] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Tue,  1 Jul 2025 16:39:42 +0200
Message-ID: <20250701144017.43487-35-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

No need for accel-specific @dirty field when we have
a generic one in CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index eaae175aa5d..f521c36dc53 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -30,7 +30,6 @@ struct AccelCPUState {
     struct nvmm_vcpu vcpu;
     uint8_t tpr;
     bool stop;
-    bool dirty;
 
     /* Window-exiting for INTs/NMIs. */
     bool int_window_exit;
@@ -508,7 +507,7 @@ nvmm_io_callback(struct nvmm_io *io)
     }
 
     /* Needed, otherwise infinite loop. */
-    current_cpu->accel->dirty = false;
+    current_cpu->vcpu_dirty = false;
 }
 
 static void
@@ -517,7 +516,7 @@ nvmm_mem_callback(struct nvmm_mem *mem)
     cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
-    current_cpu->accel->dirty = false;
+    current_cpu->vcpu_dirty = false;
 }
 
 static struct nvmm_assist_callbacks nvmm_callbacks = {
@@ -727,9 +726,9 @@ nvmm_vcpu_loop(CPUState *cpu)
      * Inner VCPU loop.
      */
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             nvmm_set_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         if (qcpu->stop) {
@@ -827,32 +826,32 @@ static void
 do_nvmm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_get_registers(cpu);
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void
 do_nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 void nvmm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_nvmm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    qcpu->dirty = true;
+    qcpu->vcpu_dirty = true;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.49.0


