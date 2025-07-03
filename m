Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65108C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHhx-00026M-BJ; Thu, 03 Jul 2025 07:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfa-0006hp-4X
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHep-0003OP-LO
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-454ac069223so2984485e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540350; x=1752145150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFAqYWkOt5rZ34pscE5bkNOMRRS/BXy8okDEtUQzC0Y=;
 b=ti5O0mblpcTQezz3ssqxMGhrVO5Wav+21sU3paCnpMD9t9ZuyJIgP+V4oIy73txHUK
 38XBMJOhJPkzhVrFqBQUi2ajSS51vtv1FFmECW46wkR5fCOIINPMs4xn4b0XdILllh6k
 itoW3Eqx1C3KIZ0Jau5MtLdrA6roMpAKXQFiRObVtPdE3dJt03UOuwAaW7kg0zis+NBr
 kVvx4LZYAVDNHpXtctEnhJrMSqLGcAMC2nD50LMM3Jkt7DzkwwzfIn8xcHW6f2cuqb4j
 IvWtQ44q0UWtZQLx/RxKaDMZCOTXm0todwhl0iSN1+WxzqxwALq4Vt/7Ptd3WHFiGa7u
 /h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540350; x=1752145150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFAqYWkOt5rZ34pscE5bkNOMRRS/BXy8okDEtUQzC0Y=;
 b=iQDHLU+rEWerwSAI86suE4Xs2Nuq8nyMTH3Mu+T6XStlN5my7JzTXb3PM4vlMlFSml
 BeevV82G1cbl10TQeo+Vc4kXpqOv91Awzj+zUI1vObhdQf7jMzeJ+DSRlvNm1HdsniF0
 57Qa9FvnWXcvnZT2QL8AF6UCg88wfoPtW0PHZiSUBD7Io5QwgYM2TTIRbsTFRjtb3GOj
 t9DqrlrLvNafo6Np7Nc2z3cHpPYxZic21p8R6d7PYekfhO9sxPYgf8HzFg+ag5pxwCVZ
 jWi5lyl74UkfRReigiNohW5OE0FBthGuF2kHkXKvs9V/jO3OFcVmAFFfm44rYVTboWzR
 MWcQ==
X-Gm-Message-State: AOJu0Yxo7QMkjvKBP9Xk3fdXrTUcgpZEivEGwSIcxd0KrrarCh5aPIHC
 BnI3QyQ3g7XdxD/juunwaTdUE1sH5wYCd2V4psWlhCTWjGciuw0CE50AkRkKNb5kumuP4IGFMKe
 7XYSeRdE=
X-Gm-Gg: ASbGncuGEXLghZ8y16yddoXr7Sm4lrcrMdk40NzZ1LfKWtd9EydbqYJE0g2WgkG2bO4
 iKsW5Aje+k9FjeOFPSFM5rXt1RvLRQ1vZ46nq92jblWRckbkEHShSowGcvTwHtL2fqICEOyNnHq
 HiqS/BEzQ0dRINcCl71LHEp+uEd1FUyoEf/ZsVlWOgdtS8VyviGuNyfCeMHPvMouikWS9ece5Jk
 QanAwBcYJ0bJbR86tdu5lpgV0zXSfX6H99jkJaL++tiHBbd4rs0e3vQ3ji+e/ciExVR5qtUBicb
 oAyTigbdm9Lww44/EyL4TTHP9KqEbXqt0kyf/S6nFDqpjZAwrkBD3q7uzDZRjL+AGkfqnA+GOwT
 qwUL4pFA/Z3780k0Sc/58qQ==
X-Google-Smtp-Source: AGHT+IEpLtcQemMkcwNXCmGS2HYXOrXVSmrpZfH3haYqqpBfUcpznPUG0hMZrhqDiS/8G+BDKrWdvQ==
X-Received: by 2002:a05:6000:4026:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b34281c3efmr1987415f8f.6.1751540349695; 
 Thu, 03 Jul 2025 03:59:09 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52bb3sm18654339f8f.56.2025.07.03.03.59.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v5 39/69] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 12:55:05 +0200
Message-ID: <20250703105540.67664-40-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


