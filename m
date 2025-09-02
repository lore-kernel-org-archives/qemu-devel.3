Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A6FCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnv-0002Lx-6i; Tue, 02 Sep 2025 09:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnn-0001iL-SO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnk-0004b2-T8
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:59 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3d0b6008a8bso2100950f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818711; x=1757423511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cpUvSmRcSRgE9yxLQY3R1BhVSeS7VEdo2LGu+IwX/JY=;
 b=k1uu6FpzOy+TTF6my9vqYXe0kA/gPDk4+/Dq4xtrld+PJuRO63gYZXmkQiHj3jW4GD
 TAbVjAo1e2orzQem/GBsBrpFBTgyOk2PXeQl9Tx8r2TRHtPc6s1coX7o9U7s1qmz7BzM
 OjTXtPx8IQiFAgFp3jPpg8Me4lWZTuDSSQIloY6039hGSh/Q8P7GC0bmWnGSz2/upK3G
 ak6yMtbyNeMvFgp5N/Hgg3Fvly8gCr/sZZi/wEb8qBICyW3FctBnfsAoYbEHTp//nqxL
 /VyYBOPk7I9D1H+1A++NJXFt5Q3ykL4nA3lyis56zf0MrWa5q/FQ5YFE5fepLILena5b
 ebhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818711; x=1757423511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpUvSmRcSRgE9yxLQY3R1BhVSeS7VEdo2LGu+IwX/JY=;
 b=Lv43Mg9aCNCqi8YfcGN75G9NY/DaP1wTpMEM+55N5fIoLpNSxku5F3DNdWzflbOJ7c
 OSK5zEjhSc+oF6QqVVuAunvhPktcVNBx/SmxoGZDx9HxnJEC7pmVYWo5bbEaIjBv1Ks5
 hYTYbbUu0z+qkpLFKlQ0iNN7aW8vuLx84qu9zXngYYpo+8qiDZ9PK3IPLXoiLZRuSnxI
 g9swQQJqrxHW/xpVaN3hQmdSmVw2twY6UsK7GYJgc/NoyH7k+x0q/k6xn6MGqnhi6382
 reh+Pl3f8tLH8Sb3oPj++HLuXXlMoMpeMF1BXUJ+fBR35LPv9VL7ASbqoC/MpBu1k1IF
 roRA==
X-Gm-Message-State: AOJu0YwXF8srk2FoQdBC23hy0jvNHcV/jGKj6o/6630YyL+DtL/aY4zY
 EH4wtGy7EQxhZLdvOuW+m9duV1F4iEEcwiTtLv6XHpYdfxvzgojqqfsYWneOCKgjMI7IPL/3wUs
 u9zQK
X-Gm-Gg: ASbGncuGFZxWQ7M+rGvfTLJ9aOVtG9uOZpJPQkFG8fgnKnxJZnNm91neXz3iFYuT5/M
 0ZSQZbY4OZ0Rtbo+G4BIJC7HYWoL+18nnBOj8OYiiDbqD/iCMsPcncxPXAon8p40Qj8zUAAnM/L
 gp5k24J0KOodn774HNEBOaNEKdD+39Ynoax5OCYPIxi4SpsrZIr6wly3SP2acMlbUP4+fbfmRuS
 WT1VIpvxZQAwnksZdikAJ7+ygoYerJyuq2fNxNlJCtid+YOCKiGSdxQZ0Mp8Ba483t3DydcTBBf
 bGEugExulTW56zbynP6VMg+qm8TbYvi5LcayPwUySMkkvel9mdBbePIH8WZlGy4iFA+BlmJq9/7
 wGYwu63JdWmfxk8tMjAzze201nANwt7nhLPcGT5SvzpL64YhEwKLVTkJfpGaKEhds/waGjpjJVh
 H+35ZgwJA=
X-Google-Smtp-Source: AGHT+IGtQRywtRb0g/EcSCim4s/f2fH8xbRQOIW21QrtFjZFEox15SeDSyEqliR61nrSlpxPy8VpMQ==
X-Received: by 2002:a5d:64c9:0:b0:3ce:e14a:a898 with SMTP id
 ffacd0b85a97d-3d1dddee967mr9118279f8f.14.1756818710501; 
 Tue, 02 Sep 2025 06:11:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d701622b92sm8361444f8f.58.2025.09.02.06.11.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/39] hw/irq: New qemu_init_irq_child() function
Date: Tue,  2 Sep 2025 15:09:57 +0200
Message-ID: <20250902131016.84968-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The qemu_init_irq() function initializes a TYPE_IRQ QOM object.  The
caller is therefore responsible for eventually calling
qemu_free_irq() to unref (and thus free) it.

In many places where we want to initialize an IRQ we are in
the init/realize of some other QOM object; if we have a variant
of this function that calls object_initialize_child() then the
IRQ will be automatically cleaned up when its parent object is
destroyed, and we don't need to remember to manually free it.

Implement qemu_init_irq_child(), which is to qemu_init_irq()
what object_initialize_child() is to object_initialize().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250821154053.2417090-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/irq.h | 23 ++++++++++++++++++++++-
 hw/core/irq.c    |  8 ++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/hw/irq.h b/include/hw/irq.h
index b3012237acd..291fdd67df4 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -36,11 +36,32 @@ static inline void qemu_irq_pulse(qemu_irq irq)
 
 /*
  * Init a single IRQ. The irq is assigned with a handler, an opaque data
- * and the interrupt number.
+ * and the interrupt number. The caller must free this with qemu_free_irq().
+ * If you are using this inside a device's init or realize method, then
+ * qemu_init_irq_child() is probably a better choice to avoid the need
+ * to manually clean up the IRQ.
  */
 void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
                    int n);
 
+/**
+ * qemu_init_irq_child: Initialize IRQ and make it a QOM child
+ * @parent: QOM object which owns this IRQ
+ * @propname: child property name
+ * @irq: pointer to IRQState to initialize
+ * @handler: handler function for incoming interrupts
+ * @opaque: opaque data to pass to @handler
+ * @n: interrupt number to pass to @handler
+ *
+ * Init a single IRQ and make the IRQ object a child of @parent with
+ * the child-property name @propname. The IRQ object will thus be
+ * automatically freed when @parent is destroyed.
+ */
+void qemu_init_irq_child(Object *parent, const char *propname,
+                         IRQState *irq, qemu_irq_handler handler,
+                         void *opaque, int n);
+
+
 /**
  * qemu_init_irqs: Initialize an array of IRQs.
  *
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 6dd8d47bd6e..0c768f7704e 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -49,6 +49,14 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
     init_irq_fields(irq, handler, opaque, n);
 }
 
+void qemu_init_irq_child(Object *parent, const char *propname,
+                         IRQState *irq, qemu_irq_handler handler,
+                         void *opaque, int n)
+{
+    object_initialize_child(parent, propname, irq, TYPE_IRQ);
+    init_irq_fields(irq, handler, opaque, n);
+}
+
 void qemu_init_irqs(IRQState irq[], size_t count,
                     qemu_irq_handler handler, void *opaque)
 {
-- 
2.51.0


