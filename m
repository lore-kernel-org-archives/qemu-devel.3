Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5C2C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2ei-0001yn-W5; Wed, 02 Jul 2025 14:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eY-0001bN-Q3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eR-0002hn-0X
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453608ed113so49570495e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482663; x=1752087463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFAqYWkOt5rZ34pscE5bkNOMRRS/BXy8okDEtUQzC0Y=;
 b=Mv5uFbuS61OAoYae13+zaox4tc41NdJIYe3jYGoxaSYt+GvOvN4vcb9RY3V4FnIjT0
 sz4kQ5XdswUTNwk1PeBsW6a9YcG6/aUJUaRKHRZ2riuUXyXHV40tVv5Bt+ejVRTvyV57
 v/YHzo255Ur+WbKiX0kzqfaTfHA+CKwzenBvC1PzObHXxmE41gicID/ZhohsBpNcpwmA
 TCEewx7EBrDaklSI7sqKN79rKMkX5rhV6fYQkslVJINqACDwiT2abDJBx5diJpd9jkao
 84HkBN7CiyYfIUh9ue09mJYj1RPAfVgqo13MQ1z88Go+d6wnIk3AIOMvq4Frsx8G0oqp
 KEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482663; x=1752087463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFAqYWkOt5rZ34pscE5bkNOMRRS/BXy8okDEtUQzC0Y=;
 b=vNMuZplxwoHHBsBslHGaaJ+ZJ0bnt6ynvdcf/B0brPr3pr6gdPF12IGhAj4zAU2IX9
 /q8le2okHS6TTPHN9qo6sT23QeqeDapjoeD7fvgts5wT/5RB0PWUp7nZtZA7JqMVYtoL
 Pv/Q6WPK9271sD93pATE/mRDjzG3NV4AooqXefGkmrHst+DoPx3KZjOsqD439mza1/h0
 POKH91eqIU0aCz1IpK+BePLg8p0L33ay/7I387wOiiApoINfFa2rpNnnPkhaD7U8aSV1
 4D5PdadYll7aYepv6lrs5lKQE7behF+OJwwt/6P6QHphB99vgVWiCc9OQAfVvaG5XuyL
 v8RA==
X-Gm-Message-State: AOJu0YzTaX9DwG4CQCDm92fNG150t1s67VoTODZ7eCULxws1QtFx29/l
 7/7jIgU75hrZ/lcjW1euxobgXH2iFvaT/dieD302m4lszXZ2HZicPOtt32ZhUjMG83wsC0dmTOt
 Ul/X9
X-Gm-Gg: ASbGncssOhODSRjeoRe5sMtcVuEbRf01J81Cfcca1hG+04MSTC1Q1crXjL/1Jy3dn8u
 PgkfTHxN8QJf8vUoMgfuKFCA/yD1/50r5c+BOdFrhOFLS2Ljdn0w23jdTDCiV2j2k2PiHUBetDs
 A9wQYuK6fBKZDDWs5uBWO/iHa/aCob7Gm6GmeTMMAsblg9IbbNDYesHsOXuir0wut9zPN/qbfqF
 d/lSsXIQPuuN3ERCDzyHFBgYob9XudwrWl3zmjZ2r1oLS4tPQmxc1YDPW77FN6FLWNaB0Zni3KG
 Yl0y/+XZADCIglqamxuf+12pUftVUjJzyuELRJaa5QnUgVOritwvZTyoolrtvWdMQws/HeJiuTu
 bBT+/6Fw1WTaxbmPxnniA+QX8/vvF1aULgIBJ
X-Google-Smtp-Source: AGHT+IFkdP4s9jQ8IVaF1iX6gg89NMNDKtvY3rOa1XCjIg0vCzlsxH5ZvWz8V9D3AWRVSzIQ5Hkkrw==
X-Received: by 2002:a05:600c:8208:b0:453:b44:eb69 with SMTP id
 5b1f17b1804b1-454a9c7bb55mr8852515e9.13.1751482663513; 
 Wed, 02 Jul 2025 11:57:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52ca4sm16839718f8f.58.2025.07.02.11.57.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v4 34/65] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Wed,  2 Jul 2025 20:52:56 +0200
Message-ID: <20250702185332.43650-35-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


