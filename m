Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C35CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7PU-0006md-4i; Thu, 21 Aug 2025 11:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PR-0006la-0F
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:41:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PP-0006xr-6u
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:41:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd237so8956735e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755790857; x=1756395657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDq4cF/t2UQHmVrYwS+n4qlrWTrQBtReMxtNz8ju/jo=;
 b=zAEAnySr4lLK7EjPDXWbTAOrjMFf0CZCi1cDO1INU4gWlM4O6zHlth/LTlChEdTw6W
 4/tKoEpbpl66g7l+VIT8cgY65DskfZWBUh2HelQRt+gRsLPqgkSU61e51jVx6SD73/yq
 PMYjhsGG//c0UFFckLEQ0rOnW4WTIAi6WJa9ZlkCSwCpWpPc1ayIKLIHVohul2Tp33Z5
 fAnwW2la/il2uwIfX9nQ/AHAWngJBdt1z0NKhfp76SwTJcz32kKMn1x8iSgOdGHU/WtS
 7Xy+vcD4t3F7186HO+xKIdGyGPiQmdOg1v4qXOci0vAw+xs391Ln3EN3zJTkJ5XiDrMk
 de6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755790857; x=1756395657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDq4cF/t2UQHmVrYwS+n4qlrWTrQBtReMxtNz8ju/jo=;
 b=oiJCvwQhNk+gEXPHU120MAsxdcy3MK1uliPKiUaEyihYmPqAHPsMsfM44XnA3UUBwh
 9EfE68sRBA3cYHz/mvgtbW6czH7dVEJy3Lr0oKAUHT+7JZaFRhKjPlqMnQaA8sSCYt2g
 KA2AqMAsiPlHvOcNXlDvfJAZxGuF1RER70svn/z5gMY9EMXDhXQZusRLg+/aEJ/Q0GiV
 FAsexkLqtTM20IHya0Fcm9mDAJbshym4eVrU2laaEJncg3mViwhxlEk9Wq/gXUR6Un/C
 xXS6+3XazC9gxyGVYj1E8UZc1WF6unFiinMKNx/ajuuHhG8qO5Gz7RDQCsowp2Inle1p
 fZPQ==
X-Gm-Message-State: AOJu0YylnIeTrFygOKdk1oEMTWa1eI6Fe4CM5LVu5GtfRIZVlAFZreBM
 PdfN3PlnXwA45hoL62GzNMev5mXGpBoyeGll+UIMoiBFXP4fIdgI8YeidhD97w3O2AD3no5Zpdq
 9gI0D
X-Gm-Gg: ASbGncv4pmvWH4L/tjJgl5Fa5OLjPQuAVC9EWQ5skyeZCyt3A67j750J0D/1MpyGkoc
 /3c+7z4+o+iqvpXk6l9QAa3mRAs3lFkWMXFkPXmThXoArhx8i+20YmS6brqEd7ZbV8EPpGJjoaP
 G7OnLojI3YULlubaKMbnr1D9Jo3jOd78ddEfgdkTvk1iSB++E/xTpgEl50xc7GlOED7IsUwpSUU
 8LigY65B3O0+E+zGWTMxDtalIOvZO9oj4x95w2ME4o0uhdmzV9VVjkUtKrh6TMmc6WcMrElZ15e
 Z9SKoMu3t1XOdunyPEP7qj+AAhiEnSqinvM7BkSMVNPpWSulR7sm5+l51k04k85ks1/twC4oRDF
 W4qBr2M8U7ghpiJK8vzrPkdAseRow
X-Google-Smtp-Source: AGHT+IE+hApSgzsQ721FrzNOUM7n1YwKF4L5nJkf787ZuXHBDWmRgCwNs/ysw8BwVR0b3gsOfuh3eA==
X-Received: by 2002:a05:600c:358b:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-45b4e9e6929mr23386775e9.19.1755790857470; 
 Thu, 21 Aug 2025 08:40:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50e0a479sm1443285e9.21.2025.08.21.08.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:40:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/irq: New qemu_init_irq_child() function
Date: Thu, 21 Aug 2025 16:40:51 +0100
Message-ID: <20250821154053.2417090-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821154053.2417090-1-peter.maydell@linaro.org>
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
2.43.0


