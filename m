Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB86D6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2c-00009s-C5; Thu, 02 Apr 2026 17:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2R-0008UC-Cp
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:19 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2P-0007B2-5F
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:18 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so1886492a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167035; x=1775771835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLJlPZb4J5z4IvDnwriqBPXyQNO+ITQ2oYN4FJS7gQA=;
 b=hof/Qxwtl643jA228xoUw7Y/NCHknBchTrkKyQ4j5+oY7tZx+2XjBtXywQ0idBPPW7
 7PWURKxJuz6tA/ZOx4TD4bYBUGZZQ6YNjUElt8nzNXkntHjb7jOHRvnba2HBQAIFBBrD
 Pb9OWuGr5DdVsFfe5jk2KRl9Cmju8roF6tRzrGJ4ze1KlPzDgx9qe9XTJ2lL6m2I6aqz
 CxD35M3jxOLia3tVBEfr3OzjqNrFbMRUhU9pILJY6htlHyLwNTBmulvCsbmUXa7mX3gv
 AmBCaHEcuxMRhSY697psAmNvRxcwPwA58czx/FH41043egO4B+eqkcu5lzLDZB3ybLIV
 ySAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167035; x=1775771835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WLJlPZb4J5z4IvDnwriqBPXyQNO+ITQ2oYN4FJS7gQA=;
 b=sfOuEev9jRDWMfzlL8og5vFBpmOcbBDD22SXWH3uvxLquzfxGaKSfnKtmN7BjHX1af
 f9mbocUIy+JVdo07FbuPjl/ojIsQf5BApQQUpKD9BG4UchOl744Qfx3BTrsa1OeCL/Pg
 BUJWC8y2FS21tekB22y/ZGlomEjIfWCuEp9K/BYwTdLbgVMuSVtzKGUjXrfguQNujNOa
 lJD0nDzFyyz+M5MNOcMJslmaJmH8r2nsAkfP842n5LtEC1WeaklASuYxyDUFYH/hNyw+
 9gShY8AtfZdi7B8rGKGHPxddh59rHhYWZtfqZFIUVZ8CxcIz84m6C8Vwf+bka0JU381V
 vBKQ==
X-Gm-Message-State: AOJu0YxdKgEzA6gN9jcdMH/P1KNKeGPW1nDng8Hd+YxIblrZe2K6Qw7G
 O3Ex8UuqFNMUiBixsVxY9gDRvJwgaB1VfF0zn3lncq2DfrLxirFkM/h3kJw4drTg
X-Gm-Gg: ATEYQzy//8eVe4eQbHK5i+IccB+OlCwJM3aTIWvqi0Z8CIATWeIwjuaAyIrcgoHsfhH
 gHabnZhMX2y2ahEIjAz61Xg24nfyrm36Im4vgOE0CnS/p7eQ5qSyk+mUIekf547SuAdT9PO5bkl
 rjbGKZz36NDXyEkeM6WoDyygfC6rDUxrZwg9WgQWQvjJaYJtfFd6jEl2iTaT9WZ8E2+5T0jEQXR
 fp3dC7zr2kOqEWzbcwXdBDYYG27CYyJD2X1Ml2K5UXZl5qZZfYn8w+rVcXV8boLyJcUSn61DGKV
 FBVXWfrsXACITkYPuH5HSrnccYFQz7jqt/yNyefHpD0KGcazK14kbUK7af/fmEo73Xs3idrcd3R
 ZOkSw6W0mV9mcpBPXSEOO61rVKfUKUfozZxyZcbDE2DE3rBme4ZSKf4e0qQSg5e5CGznrsF1BMD
 Q0hq6QKrBOL3iojk2LXWuBpSIS/N5Y8a+NT+nEXKr2i/MFMx/nyMpRAZ6GV19219ALCWszcA==
X-Received: by 2002:a17:907:e107:b0:b93:56a4:d6bc with SMTP id
 a640c23a62f3a-b9c6798d3a2mr16784266b.49.1775167035121; 
 Thu, 02 Apr 2026 14:57:15 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:14 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 18/33] hw/core/fdt_generic_util: realize cpu clusters
Date: Thu,  2 Apr 2026 23:56:03 +0200
Message-ID: <20260402215629.745866-19-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Realize cpu clusters at the end of fdt machine creation
process, as they need to be created after cpu's nodes
are realized.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index b0e26e11bc..f3a47cbafe 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -151,6 +151,16 @@ static void fdt_init_all_irqs(FDTMachineInfo *fdti)
     }
 }
 
+static void fdt_init_cpu_clusters(FDTMachineInfo *fdti)
+{
+    FDTCPUCluster *cl = fdti->clusters;
+
+    while (cl) {
+        qdev_realize(DEVICE(cl->cpu_cluster), NULL, &error_fatal);
+        cl = cl->next;
+    }
+}
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     FDTMachineInfo *fdti = fdt_init_new_fdti(fdt);
@@ -164,6 +174,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
     while (qemu_co_enter_next(fdti->cq, NULL)) {
         ;
     }
+    fdt_init_cpu_clusters(fdti);
     fdt_init_all_irqs(fdti);
     memory_region_transaction_commit();
 
-- 
2.43.0


