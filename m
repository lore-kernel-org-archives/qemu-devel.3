Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8F7CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQVc-0002ts-Nt; Mon, 27 Oct 2025 12:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQVH-0002aU-Ps
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:55:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQV5-0001Ih-GP
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:55:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso3486768f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584115; x=1762188915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mR9y4rf3YIHAZI+0OjgGmLH7QJrVR3WgUfA1D6HdoHU=;
 b=z5+mnOutNtJg+/ujXLrMK1On+sUUS60CE9wH4j0DhhyKZVZkTsCxrm2ouYZ6ESWg4r
 1IJACjL++rV5McfT6Ln1OvEf7xJ/G/4+XlbyxvAHtSujGDu9imn8YRzytDgMYDJwvbMg
 +M/KCJRXcMa5QFKIC8jXU8f0rilExITI5sahiNJ9ezioxv+fFYNj2jOb5WXy4PZlmbru
 WT+zHtw0kvq3KG1kvkFty8JuDbWVvIRMO3SwxJ2ZclUKTPkFSi5HLaGZYQaJu+RCEV6X
 5+op9qebAVsZ+20GsxpC0g1VayANxsgO+2iXw7ojqhjREKWO/33PTlIbZx4pABAY80Iu
 1LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584115; x=1762188915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mR9y4rf3YIHAZI+0OjgGmLH7QJrVR3WgUfA1D6HdoHU=;
 b=hgXvU9JPJLWMeqyCT/bBNEgral8nrwlXONM5dAZNJlEN1qOGJtDMJKFTf1vOGHK513
 w3c9P7K5PPzG6+oCSJD7jME07gCoZaCfTM0tiNrZZJ5G5BoskEzxwU+Q5rgNAWg/Jnwr
 +bSKErTp/m1wk+76PMt8oUgjn+WL6mC6X73ikbb4iH0/FiNXhWXv0LjuhxfZyaBHyCZL
 GwfbOkdAj9EWXAnZ3tj3ZqMa1NINSGfXwUUyhvYj4791FiFzYWKsEEW0uXN0RLZiMIf/
 uFead8TNtCxQcXTQThyFAWt9V/cs42z9HGJqgj6zmdVDx7+N+OBj38UxiM5DDUGpfS4P
 t8IA==
X-Gm-Message-State: AOJu0Yw4B0HE5uiwJvndXEPUk415WUoLDSp88zmQWl97zSDhWmYZJT+q
 MKWcFG2sd5CbRA8qSf28euI4L/Uy9piiMX3qTLAP9RP0e723mEz3d4zkVzrpmRudQAmoDOnzKtF
 BsxD/1zY=
X-Gm-Gg: ASbGncsrOkm5nTBRIkkyVyKTidlCpOsZsg9QrRuijOvHWaPFHdY3k5rTVMGa4J0Csiy
 L6awuEL/zBYJasz5r048StQBJwvx18PCCZv6Y81VhuToBuhE2AfoXwhnEeqLEzZqTC3K+OjWh9B
 23m/qW73wVbqZ1BE31Zo8sIZ3bJVFIIeAbu+DuyDfUcqzZ5rN7l/sYtsDzd4a8K5r2KgjMe8ON+
 k5PT30Ms2aeSOOP/95mUz7e/9uYqvAHzvpJ12KhzoTHcALztxBwe8/tdBDmOQKL4SgC8mw0DI5Y
 1eagGSQlJzaSGT8a8AaEau6MLNwtLb9TKqPkmQgJTvje1imm9FTHubGL7I5lkxQJfLPuXEqKMBH
 QTWiSDUAU0mR6SENE8iX+ZDKMhIqYBC47A2+/WqHargBmudU4Nto/Wh+j/px+JtnB9RMuWImqqV
 o4+UmNOVxTu5xY3GrqSZPvjaQcAGNag+juxA5t4yidZBOv7IhQ9A==
X-Google-Smtp-Source: AGHT+IFM7xUDFsR3fgX2TeWdOd4L9dIkJc8vRxkTGqJVqFrtU5G58V0uR6gKW3YaueJUlD+ndKJJVQ==
X-Received: by 2002:a05:6000:2303:b0:428:3f70:4b2 with SMTP id
 ffacd0b85a97d-429a7e8ccadmr344430f8f.63.1761584114818; 
 Mon, 27 Oct 2025 09:55:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9c6sm15484572f8f.36.2025.10.27.09.55.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] hw/pci-host/sabre: Remove pointless OBJECT() cast
Date: Mon, 27 Oct 2025 17:53:00 +0100
Message-ID: <20251027165304.98296-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027165304.98296-1-philmd@linaro.org>
References: <20251027165304.98296-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/sabre.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index f95e5db583a..f63d832efc0 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -429,18 +429,18 @@ static void sabre_init(Object *obj)
                              0);
 
     /* sabre_config */
-    memory_region_init_io(&s->sabre_config, OBJECT(s), &sabre_config_ops, s,
+    memory_region_init_io(&s->sabre_config, obj, &sabre_config_ops, s,
                           "sabre-config", 0x10000);
     /* at region 0 */
     sysbus_init_mmio(sbd, &s->sabre_config);
 
-    memory_region_init_io(&s->pci_config, OBJECT(s), &pci_config_ops, s,
+    memory_region_init_io(&s->pci_config, obj, &pci_config_ops, s,
                           "sabre-pci-config", 0x1000000);
     /* at region 1 */
     sysbus_init_mmio(sbd, &s->pci_config);
 
     /* pci_ioport */
-    memory_region_init(&s->pci_ioport, OBJECT(s), "sabre-pci-ioport",
+    memory_region_init(&s->pci_ioport, obj, "sabre-pci-ioport",
                        0x1000000);
 
     /* at region 2 */
-- 
2.51.0


