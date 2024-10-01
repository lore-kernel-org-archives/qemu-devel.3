Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23607CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuJ-0005Iy-RH; Tue, 01 Oct 2024 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuI-0005I8-G8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuG-00060X-VH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so47240145e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800763; x=1728405563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DD9Jh8+RmgvZlCMgMoDzKAAVACdceEVcyQEeEUMmaT4=;
 b=MvsrVk8sjNuov87V/95rCAWH9rBRa9tGy4Gya7Kc8BVXaM1hlGHykWwEEbY1EgS3QE
 OYdODpZi/d2g/jDyqS1TF61Xty3jMKS7jH+zdOXXyTulY6LDer6+3ONfzM6QlXE3iDAW
 TLjnBmAhIFhup3t/b7p8NW7XIbjfwLv754z01Jp1OgzCJA5DObfV9Tzbc//CCAJAOK/Q
 qjx+8PR9ld515vCY2oVhvKIyJo5GpkMnbeuktnQ1c6iXQulugqrU5axywSRQsoU5Hhfv
 QdDQzHFGGuA4FYmCN3ziY6797obguuexixtTT2ybsObLGS7rOUZz2scdAgQIzlMCQEZu
 CWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800763; x=1728405563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DD9Jh8+RmgvZlCMgMoDzKAAVACdceEVcyQEeEUMmaT4=;
 b=h4RPuhHB4TJAkVpVCwGU3eXN3OKsd0/EDoeKt2+0JE8+DeChD/0MTCXcPl0/zH1yJF
 nATbUBCBUzuVKN5YwqoXta68z/Dhlg4QEqi8V9NLzNJzE2SSx2NNueY7eMEOs9ydz0x2
 ITthbx1t8TF0MZtoMGpVNBvlLoSvjzenK1qkbgMkYSWMMbau9K4zi6zv+fWgV22aJWEI
 0K3+gc5wZeQTUSJvwYUq/xxhdN7L+Sr0s0XXXjSCwVZrPIk3Mmoqm2LxZbXbtKO83axF
 /bVKdNvLEdJnTDLXe2w2fEG4NAYSd1MD5UNb/XMZzdgHwtfPHfVneqcEcILMfyxLNB6b
 5x4g==
X-Gm-Message-State: AOJu0YzkelfcP44ey74kzE0TgptKfwnRnyT5Iht5tkvlyjP7aWUKfsHI
 v7Kr7ee0kkYe+i8ZxrsXfpzOmoi7zBv0y3jYiMb1wv7763wnKonG0IhdUQuEC24xALvyHJrxi9C
 Q
X-Google-Smtp-Source: AGHT+IFKKtPHlneEhOtxU3tkTsIcC2jyr8ssTHo9L3sFDcrHXTpFmELT3TeFolfoI3WjF3lW0QemSA==
X-Received: by 2002:a05:600c:310c:b0:42b:af1c:66e with SMTP id
 5b1f17b1804b1-42f777b6d0bmr871705e9.9.1727800763235; 
 Tue, 01 Oct 2024 09:39:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/54] hw: fix memory leak in IRQState allocation
Date: Tue,  1 Oct 2024 17:38:30 +0100
Message-Id: <20241001163918.1275441-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

At e72a7f65c1 (hw: Move declaration of IRQState to header and add init
function, 2024-06-29), we've changed qemu_allocate_irq() to use a
combination of g_new() + object_initialize() instead of
IRQ(object_new()). The latter sets obj->free, so that that the memory is
properly cleaned when the object is finalized, but the former doesn't.

Fixes: e72a7f65c1 (hw: Move declaration of IRQState to header and add init function)
Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Brian Cain <bcain@quicinc.com>
Message-id: 1723deb603afec3fa69a75970cef9aac62d57d62.1726674185.git.quic_mathbern@quicinc.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/irq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index db95ffc18f8..7d5b0038c12 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -34,13 +34,19 @@ void qemu_set_irq(qemu_irq irq, int level)
     irq->handler(irq->opaque, irq->n, level);
 }
 
+static void init_irq_fields(IRQState *irq, qemu_irq_handler handler,
+                            void *opaque, int n)
+{
+    irq->handler = handler;
+    irq->opaque = opaque;
+    irq->n = n;
+}
+
 void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
                    int n)
 {
     object_initialize(irq, sizeof(*irq), TYPE_IRQ);
-    irq->handler = handler;
-    irq->opaque = opaque;
-    irq->n = n;
+    init_irq_fields(irq, handler, opaque, n);
 }
 
 qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
@@ -66,11 +72,8 @@ qemu_irq *qemu_allocate_irqs(qemu_irq_handler handler, void *opaque, int n)
 
 qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n)
 {
-    IRQState *irq;
-
-    irq = g_new(IRQState, 1);
-    qemu_init_irq(irq, handler, opaque, n);
-
+    IRQState *irq = IRQ(object_new(TYPE_IRQ));
+    init_irq_fields(irq, handler, opaque, n);
     return irq;
 }
 
-- 
2.34.1


