Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1702DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMIG-0004HS-Q9; Tue, 23 Jul 2024 16:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIE-0004Fp-S7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMID-0003wT-69
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-368313809a4so137311f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767167; x=1722371967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrHcPBiJNMYY45TLfxTrdyg0kVvbbiEg2Yd8/X7ubpI=;
 b=vLYljU6KXnrrpDDMlpW/4g+AYy5/98gQ71OxWS2nmuk54PrgBezm2gdZjwHTDmQe3P
 SmXNg5ZPHRWvBs6anlEsM0PKwFK2kFcHj5mvw7MplDR3+ksQBsxl7QCfIDbkMryDYinr
 gk5fEMjBhhZYgDV01q7X/WZ4JE0C7jIUjF5Qrj18wC1unxIxI3ssafxFioGb004RzbjD
 vHgfWBuUuMw4ya2rrDrYKG605noriaUpUuFLK0e75pvYO6GJjbXK0n59r8ikOHm0ReUu
 zDjAlg5zjNmj29XTYOf0Un39jQM3QEJeKkmsMEtwfD6bCTNKOGGUY365ShFg+kuOpTBI
 Fdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767167; x=1722371967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrHcPBiJNMYY45TLfxTrdyg0kVvbbiEg2Yd8/X7ubpI=;
 b=LSZaTyTPBkWIDyOe7cvkY9gkqxZoMa9hcqeCGxKFsa7QgcRzIXVllkT0w5d2xQlG9Z
 x6gMrD0qt+QO2iDrJgkyA8HiJSqHx4sTsoNfRWSG2356ZJqNghaf3flNW/A3rd2dzggB
 1w51y2nIC0kh8hyMmOWuKAP7wuLV8+E/gs728U42S+cNtfHpckZnDMvetOACF/GxGnBG
 lBuS9OY9qeSL9ziFbtDz8sTn4ltQnbZM98nO/zoQd5UEJx8822tm0+xEK+iLYBsi/1LC
 m+XGg+5oTGDV4aO0KMAmjDlggLOQM8Ro5sM5ZMOLMhM20/E7CgQA2E2MxmAFcaaftoku
 D0ug==
X-Gm-Message-State: AOJu0YzDYntqyi3frD7ceH66g4JUbpSJt7UpWaoYTKWZ9E0lIs9ecLJ6
 rwQGVBNRN3V8zgr/kBC+37BYta9Kho2lbfs8iWSeeaM7FuR7JYwM/RdkMt4TdI2Y0URMw8Mks5Z
 kI4U=
X-Google-Smtp-Source: AGHT+IGKwhkPIdxGthdNPxuX+0AC0etCyXz6PwIb7/LLquNRD1O1VG/iY5spYqt/ymVVTuHgRXmXbg==
X-Received: by 2002:a5d:6484:0:b0:368:37aa:50b3 with SMTP id
 ffacd0b85a97d-369e3f01536mr2976124f8f.24.1721767167398; 
 Tue, 23 Jul 2024 13:39:27 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937f58dsm520255e9.18.2024.07.23.13.39.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 05/28] hw/intc/loongson_ipi: Declare QOM types using
 DEFINE_TYPES() macro
Date: Tue, 23 Jul 2024 22:38:32 +0200
Message-ID: <20240723203855.65033-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. Replace
the type_init() / type_register_static() combination.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-2-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 4013f81745e..682cec96f3f 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -365,16 +365,13 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_loongson_ipi;
 }
 
-static const TypeInfo loongson_ipi_info = {
-    .name          = TYPE_LOONGSON_IPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongsonIPI),
-    .class_init    = loongson_ipi_class_init,
+static const TypeInfo loongson_ipi_types[] = {
+    {
+        .name               = TYPE_LOONGSON_IPI,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongsonIPI),
+        .class_init         = loongson_ipi_class_init,
+    }
 };
 
-static void loongson_ipi_register_types(void)
-{
-    type_register_static(&loongson_ipi_info);
-}
-
-type_init(loongson_ipi_register_types)
+DEFINE_TYPES(loongson_ipi_types)
-- 
2.41.0


