Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50297CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qr-0005yu-UJ; Tue, 07 Oct 2025 10:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QY-0005pT-1A
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QG-0002IA-Hd
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso51601835e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846327; x=1760451127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ziGJUQupY63rU8TMMMSnY4UYmwRsfHPmPg1J/VFbM4k=;
 b=Q4x+RBgwuzucuWwRjx4ufTMlUk0p0nsHDnCAQDVqkQPtRrvBd2At2qS5qfLIEvz/zr
 vlpfX0MWbUi6Of6MVGxif7hKbQELkbWh5ZU2bpO5IdYalQJ0GPZJZ62zb6OszWLtrIPZ
 AoT8saI7Rzy7ojNIyHGBwM8Eg518oUcQ5SbByK7XbDLCG5W6FwTJXDOA7gHOHrcAjPTN
 xBOwrzWGBQqqlupXWTCI6Of9gYSQlwyYQTg4hvv2k7shNFq8wRCBmZAZvtAejOcBr9KG
 DxWJXGTqcVqlN5nrPs8VY1udoMO/5PSHHVy7NA/L/5Idv5FwpwlWKWwlEXQoQBSY0XbX
 dgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846327; x=1760451127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziGJUQupY63rU8TMMMSnY4UYmwRsfHPmPg1J/VFbM4k=;
 b=KV6ZfOjftFn3YG9icsJt80Gzm9M7JpHm9zqdHUAixqG+QySNq6e2PZITWuWDepyZ1M
 yMrJnZTOWAdDKno5nnFMYA9AWNDGRril3fSKWWjq4wprqING/89vnRYBNjkVHz3nQIf+
 NYw/b7caJyuWztpwcy+lk2Y+5LmRx2YV4+lXWe+8lnQ6m5H8PIbdXmRGzGuU/q2Sl0kT
 Zym8IqBGe98JRFmUqmmlGdkgctZ+iKiIMbZMiQ+iORpf9LKVKnJclL1P2SyNvSaj84vi
 zGQybWW//ilE0Nx0jzUHiO6aC/nqFnsYTY06rQ2MdQ+6hMe23EUncZLP78JqLUr+gEKU
 jCRw==
X-Gm-Message-State: AOJu0Yy30E1GxDnh0z2zI4UTvTnfTKI6AXKmkyUUnAtxqNtf4Thrr/w+
 /OM9GM3ZFmap/1oL1JnVqaXg4/DdRjfb+lnC/QnVX9TGCUGxJklUXzn0fljZKP9RaKUYc+STdkw
 UbzgD
X-Gm-Gg: ASbGncuERIjQINkRHlCkyiKY/GFAOE+VEs28nST09/L3EYDzMxDg46M2mIlLCcOVYxX
 lLrOLUcW5iY0i6y+uqN97ceT7evGRQPi4RjC1zf9P4+RYsPPyn9wIu7pv3PhdBVe98b+bLPDlHb
 NaH7GQMT7Sj3V9ZtFJWH3GIsJ2ZmPa8MZUb5XskdYPjzooj8p59uIsRW9qRks9TkhGEfBf1/9y3
 xeYsH84rAqT/ID/uB/ucb+VD5ZGVYqIdRQ0HnZrXEKV7SMwsO46RlkF6zJr07CnF2RFlEtCQMBC
 KXqa62/PCOPKgwfsIlsmbHDuUFPI6temCpOoo85mKjo8k5yId913fbKwQP8JCAwITOICeVDvQFV
 vSPqf9P5CwPhUEKC7X7O5+WymtFjyvpqNhTftymk52UPLe5ak0zckz+n3
X-Google-Smtp-Source: AGHT+IFHWrUDATjrE2Ij+Gl+D2Kp4RYlfVcHNLtzH8kAWBqHSdezwZTrKQD/AXjgcya+/oqeGsbtqQ==
X-Received: by 2002:a05:600c:8b41:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-46e71102767mr99148965e9.13.1759846327001; 
 Tue, 07 Oct 2025 07:12:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/62] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Date: Tue,  7 Oct 2025 15:10:59 +0100
Message-ID: <20251007141123.3239867-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Luc Michel <luc.michel@amd.com>

Add the target field in the IRQ descriptor. This allows to target an IRQ
to another IRQ controller than the GIC(s). Other supported targets are
the PMC PPU1 CPU interrupt controller and the EAM (Error management)
device. Those two devices are currently not implemented so IRQs
targeting those will be left unconnected. This is in preparation for
versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-39-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3d960ed2636..64744401182 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -52,14 +52,26 @@
 
 /*
  * IRQ descriptor to catch the following cases:
+ *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
  *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
  */
 FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, TARGET, 16, 2)
 FIELD(VERSAL_IRQ, ORED, 18, 1)
 FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 
+typedef enum VersalIrqTarget {
+    IRQ_TARGET_GIC,
+    IRQ_TARGET_PPU1,
+    IRQ_TARGET_EAM,
+} VersalIrqTarget;
+
+#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
+#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
 #define OR_IRQ(irq, or_idx) \
     (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+#define PPU1_OR_IRQ(irq, or_idx) \
+    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
 
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
@@ -414,6 +426,13 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
 static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
                                           qemu_irq target_irq)
 {
+    static const char *TARGET_STR[] = {
+        [IRQ_TARGET_GIC] = "gic",
+        [IRQ_TARGET_PPU1] = "ppu1",
+        [IRQ_TARGET_EAM] = "eam",
+    };
+
+    VersalIrqTarget target;
     Object *container = versal_get_child(s, "irq-or-gates");
     DeviceState *dev;
     g_autofree char *name;
@@ -421,8 +440,9 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
 
     idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
     or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
 
-    name = g_strdup_printf("irq[%d]", idx);
+    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
     dev = DEVICE(object_resolve_path_at(container, name));
 
     if (dev == NULL) {
@@ -438,12 +458,29 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
+    VersalIrqTarget target;
     qemu_irq irq;
     bool ored;
 
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = versal_get_gic_irq(s, irq_idx);
+    switch (target) {
+    case IRQ_TARGET_EAM:
+        /* EAM not implemented */
+        return NULL;
+
+    case IRQ_TARGET_PPU1:
+        /* PPU1 CPU not implemented */
+        return NULL;
+
+    case IRQ_TARGET_GIC:
+        irq = versal_get_gic_irq(s, irq_idx);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
-- 
2.43.0


