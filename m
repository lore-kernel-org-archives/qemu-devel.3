Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76966C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw1P-0008Gz-Mb; Fri, 16 Feb 2024 06:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1N-0008AD-GH
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:45 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1L-00017G-Qq
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:45 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so24396151fa.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081481; x=1708686281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDE/2ozeILt8icMDCEMhs9DK4Gx3Yb4arama1t6dDAI=;
 b=zRnddEaPVtVB3ljS8L4qwXg3FSFcOSNQNEZmwKN+dQ3hu6DVbC5oYtHoQ7atunkP+F
 sCmlXBhPEQPVjb4C2C+w/cGV8tO1aABftXwSMnQM0F3h7ky9mts1rzkmT6yRkepX2G1B
 jmHzrYz1ZREiP+ondn179HOmhdU+5xcPoZmxEUopslBQLVF1fdwbBQCy5Udtl6vLkfZx
 v3KOZq+F2/sni8rmSkKlGtfhb+l0fVyH2CmFNWDbUR9hH7G78+GxDbIf6tyP1T2A13rA
 d6DfZ1J3Z6l+/hjzZ1YG77ymj5pdx2XEE1O8t20ph21h1/x/LcELMWx+lnnJ6HiV29bo
 qLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081481; x=1708686281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDE/2ozeILt8icMDCEMhs9DK4Gx3Yb4arama1t6dDAI=;
 b=vVbn84gZ+ZiJ1CMVHKQKWnlZ9MdLrZHK4vqGg+nuo9hJ1T1PeQMxaB35M8QDajovd7
 4RghIaTff6HMS2VGD4deqpcLtIdJpvUxVGRK7NwYX60aXZBPvt8pTCAw9lwVc1SLCtw/
 kJNW2/FUKTRxhpQT0KH8hLdJeBsCCNvMMVRAqsfaR40CiOvFGbDLz4nTANbsXkmIzHB+
 8V2L9i3pLdUd3gdyvo2cSzeHRIyRxoww0ORcCJZldIG2cZSkmUGcPp8LyKA/DUTzfmtE
 3Z3xL2Z6LJw2vbMoMN1f+uePnw1DU3xjC6BbNbkz+AanQoDkNDAfz8n5kTyA9YmzDghn
 eWrw==
X-Gm-Message-State: AOJu0Yzmh4i490FQJp/R6D3XeHGDDUjHmUzizrd7wsogDiwVG52exuGZ
 qU1uLnVxtcEIf0Cxuujadl69tR45ki8cvDmQLZ7lfSpZjjztFY2Bwb+isN1MQUHdYz7mJMeigbt
 2
X-Google-Smtp-Source: AGHT+IFZNkHzLFZsRRmZmy29Ui82mj7wZIEzSZ0XA/O/0xcGEFo6EopzBMSekmatFRBZBkq2tUbraA==
X-Received: by 2002:a2e:8950:0:b0:2d1:26f0:8167 with SMTP id
 b16-20020a2e8950000000b002d126f08167mr3170282ljk.35.1708081481655; 
 Fri, 16 Feb 2024 03:04:41 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a7bcc92000000b00411a0477755sm1963807wma.9.2024.02.16.03.04.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:04:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH 13/21] hw/pci-host/raven: Embedded OrIRQ in PRePPCIState
Date: Fri, 16 Feb 2024 12:03:04 +0100
Message-ID: <20240216110313.17039-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since we know the size of the OrIRQ object, we can initialize
it directly in place with object_initialize_child(). Doing so
we also set the QOM parent <-> child relationship.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c7a0a2878a..9e47caebc5 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -60,7 +60,7 @@ DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
 struct PRePPCIState {
     PCIHostState parent_obj;
 
-    OrIRQState *or_irq;
+    OrIRQState or_irq;
     qemu_irq pci_irqs[PCI_NUM_PINS];
     PCIBus pci_bus;
     AddressSpace pci_io_as;
@@ -249,14 +249,14 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     } else {
         /* According to PReP specification section 6.1.6 "System Interrupt
          * Assignments", all PCI interrupts are routed via IRQ 15 */
-        s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
-        object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
+        object_initialize_child(OBJECT(dev), "or-irq", &s->or_irq, TYPE_OR_IRQ);
+        object_property_set_int(OBJECT(&s->or_irq), "num-lines", PCI_NUM_PINS,
                                 &error_fatal);
-        qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
-        sysbus_init_irq(dev, &s->or_irq->out_irq);
+        qdev_realize(DEVICE(&s->or_irq), NULL, &error_fatal);
+        sysbus_init_irq(dev, &s->or_irq.out_irq);
 
         for (i = 0; i < PCI_NUM_PINS; i++) {
-            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
+            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(&s->or_irq), i);
         }
     }
 
-- 
2.41.0


