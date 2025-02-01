Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED28CC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 09:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te9bb-00012x-0q; Sat, 01 Feb 2025 04:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bV-00011s-8R
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:56 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bT-0000bB-LD
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436249df846so19297785e9.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 01:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738401350; x=1739006150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEJr+KxKG+5t/x8q8wqYlKjB+Sy8stapfLkWTHUsQNw=;
 b=cf8BDdDf/0SP9XvpiP+c5qJgNkvTn72kZHXN4IF5QDz9S2ypHpdyeNrCaCobVvRNtH
 4sJqTtQsMOkTA/lXoBz+jhE70dpD5dXZE1d8upp79Th73IXxbfd4sfBKsIpxYhutQ0V9
 jY3eSXFG6JNaqloHjFSM7LIxB3ia6ymbJFFChdKZxIYYWpcHN/EH1Rq0Z0sVaiVe5/32
 cvo1cUjR9+vBaYAOwDYlcCVtxGLxBHlM6p6AGY/FHfnpsRkDpr8Goh//Jp0d/FaMb9OY
 OWl0z+6eNgImJsn52x3OfO4w0XBwerejsgojD2wuJR3DGfkzVc4+gNCY4EpN5neLhUsQ
 hpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738401350; x=1739006150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEJr+KxKG+5t/x8q8wqYlKjB+Sy8stapfLkWTHUsQNw=;
 b=hK1epMOXcYNr1kPsXGAVVEm/AN1YWExqElGav0Npw0ISdVepWtJLD3ISbXDyiJTLbk
 5S/892HMvpfN1ORiXnWf89R79z+FwTmlu98ePQPamnXxLvjkbE0YNbH1LeAadgKCbzjb
 ARdG4XAHXZLpkcNo2vEZ+q2qodPTJKxU1fh0fMqJmx8jPAAeFb1cMqlZ/9WtpFEVaVsH
 zHXWf3AF1rtTNMCrH+aOW2pDyyR5ZHDEQcc3/Dx8OOUDrqKPHnrMnNm1ixsQ6URwsFct
 JngXROQMrzxu0lceoXehSsaX0bA4IT/RvCyJUkFOHJkdN2jHayvJ+lB5L302cY+F6rH5
 GYCA==
X-Gm-Message-State: AOJu0YwRuyqNrhNPhrmBd1AMnbPDmH8XFpPrTJlsD8leRR/MSO+2E7Yx
 MzbZ63lobxszdjCrb/cnWI7pNeEraMiBfzQAL4pNju8/VV0JfG00Kr+OOT0KQkIHpF0CbvpiIku
 cgUw=
X-Gm-Gg: ASbGncuNYUFIjxITm/4BbXtNzz5jZCAZb81H6neIZOHKnR3WQgvIn/p6TiQGDdTpRRw
 3V/Vw0q5uQV8JEJO+Vs4LBFAUZdEtMNexN1lXvoVM9sRsEa0NPpTrHQkmFkFyoj5P22njslvZbl
 fB1YyUYQp4K9Fz9kXJKgGzYqoHEc1pDGWy+Y40S6XDP8QFX1lxPMZ1mlWZQDmbwZH0TNUbAkznC
 4HIv7ayYQR5SISOKclwyj/i704BA4y25WRhQkmVYR5mOrq3Y5Me8horr+OvHeKmXLSwjKRkhCXR
 tATIT18Es1osfUEmdy51yUVQW6LfiCydzkLwIPbVbLWBCDcxMs9L9DWuZEvicVlbbw==
X-Google-Smtp-Source: AGHT+IFtxTfKjyY3QOd9aKkfkjZ+Z4/R4gXLu9zWH0ZKWK+E9myYwk8LU+odVAo6pAQqYXWwPoqyQQ==
X-Received: by 2002:a05:600c:198b:b0:434:a7f1:6545 with SMTP id
 5b1f17b1804b1-438dc429291mr112652585e9.27.1738401349784; 
 Sat, 01 Feb 2025 01:15:49 -0800 (PST)
Received: from localhost.localdomain (232.170.88.92.rev.sfr.net.
 [92.88.170.232]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc80e61sm118252725e9.34.2025.02.01.01.15.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 01 Feb 2025 01:15:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jared Mauch <jared+home@puck.nether.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] hw/arm/raspi4b: Split raspi4b_machine_class_init() in two
 (1g and 2g)
Date: Sat,  1 Feb 2025 10:15:24 +0100
Message-ID: <20250201091528.1177-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250201091528.1177-1-philmd@linaro.org>
References: <20250201091528.1177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Current raspi4b_machine_class_init() method register 2 distinct
machines, with different board revision (thus different memory
size), whether the host is 32-bit or more. Split it as 2 new
methods, one for the raspi4b with 1GB of memory (on 32-bit hosts)
and another for the raspi4b with 2GB of memory.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi4b.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 548059f6d69..4ea79ec7092 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -107,26 +107,45 @@ static void raspi4b_machine_init(MachineState *machine)
     raspi_base_machine_init(machine, &soc->parent_obj);
 }
 
-static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
+#if HOST_LONG_BITS == 32
+static void raspi4b_1g_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-#if HOST_LONG_BITS == 32
     rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
-#else
-    rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
-#endif
+
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->init = raspi4b_machine_init;
 }
+#else
+static void raspi4b_2g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+
+    rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+    mc->init = raspi4b_machine_init;
+}
+#endif
 
 static const TypeInfo raspi4_machine_types[] = {
+#if HOST_LONG_BITS == 32
     {
         .name           = MACHINE_TYPE_NAME("raspi4b"),
         .parent         = TYPE_RASPI4_MACHINE,
-        .class_init     = raspi4b_machine_class_init,
-    }, {
+        .class_init     = raspi4b_1g_machine_class_init,
+    },
+#else
+    {
+        .name           = MACHINE_TYPE_NAME("raspi4b"),
+        .parent         = TYPE_RASPI4_MACHINE,
+        .class_init     = raspi4b_2g_machine_class_init,
+    },
+#endif
+    {
         .name           = TYPE_RASPI4_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
         .instance_size  = sizeof(Raspi4bMachineState),
-- 
2.47.1


