Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F10C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPy-0007zA-2I; Mon, 29 Jan 2024 10:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPw-0007uY-9I
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPu-0007XQ-Il
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so38884725e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541561; x=1707146361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtXJej6F9O2lSIbmdUvlDD/icBrkbUZ4loB0TQu2OEE=;
 b=HiM4rDVJVvjLcYtFC5JkQE+wQzB0gXQ1yeMAQ9jgyNkK6QCqAbr8SVjas9EmOFrWll
 jJ6fvhWZG+SQazLgQ0vYpFOpgPcWKq6QplQ1rEuPi0EereawdDODq/CLcq2JAuEp2LR3
 AdwC/mux80sBrRQ6uWE2M1omtPBQbT/Koy/qKkvVjojxMYSb7tTVja6zsi+Nrb/bDPv+
 fjQJ3RZYCfp4ALGCzYHvppT51p4+OGD0VeCXdRq8IXzDLOnl01TktAazjIh5X/GaDaQc
 GShBEpBaIiX0epNcxeN0G1DfPJDxAVgQ99tmPsp+lAb6vH/j6UxmnnNiC07TQrUiexHO
 Cuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541561; x=1707146361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtXJej6F9O2lSIbmdUvlDD/icBrkbUZ4loB0TQu2OEE=;
 b=SyJzT5FrQWysYCHJs0Ook7LWdzN5Nh42MrmC2SdaLE3zft2Vwv+aI1uI5uUybZ6WG6
 sO6YdF9jN5EH+RlxdCSr/KH7GrhZOWH3shY4LzwmxWofm+2pnXGC6SbQw3n+Q+Z/2jFG
 6JnqXOlWzXL3PL7X2wk3I54BJUtJhAeyNmmtXbUMQ5K7ikSK1Gud0cDHFws1rPUHBkIG
 4pn1AasrsSedCtdMykb1s+C9x5KgHmMX+TcA1+Dy/H4HgE8zYRx8fk2QnpkiogGoB5S3
 r4C/8KrDEVpvLOvS8ZHdHKsd9bvkgiC472+meW+D/CSmwA8+ex3e1hXYTdwoCnZKhTu3
 4eCA==
X-Gm-Message-State: AOJu0YwL9e/uwbBeAYpHCUy+nf54xwlaXUbVytLcjs6AQMWJTrnhL4UN
 +DpYnzl08wznHrz5cto6qoR6cH1WWkHbvi7I7JOUMOLvKdZUKdNaOtM5mvDbUHpoNEpmX0HxSjx
 M
X-Google-Smtp-Source: AGHT+IHhB3S3VV1hvjazeP8LWYi9f2CTV84IM346E7rpBJjmC0/dCVGKR8Qt+HQkboU86HoUaSwmPw==
X-Received: by 2002:a05:600c:4708:b0:40e:f69b:a9d7 with SMTP id
 v8-20020a05600c470800b0040ef69ba9d7mr2647959wmo.10.1706541560911; 
 Mon, 29 Jan 2024 07:19:20 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c459400b0040e527602c8sm14361157wmo.9.2024.01.29.07.19.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:19:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 8/9] hw/arm/vexpress: Check for CPU types in
 machine_run_board_init()
Date: Mon, 29 Jan 2024 16:18:27 +0100
Message-ID: <20240129151828.59544-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Leverage the common code introduced in commit c9cf636d48 ("machine:
Add a valid_cpu_types property") to check for the single valid CPU
type. Remove the now unused MachineClass::default_cpu_type field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/vexpress.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f1b45245d5..1a14c1933e 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -783,22 +783,30 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
 
 static void vexpress_a9_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile Express for Cortex-A9";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
 
     vmc->daughterboard = &a9_daughterboard;
 }
 
 static void vexpress_a15_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a15"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile Express for Cortex-A15";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+    mc->valid_cpu_types = valid_cpu_types;
 
     vmc->daughterboard = &a15_daughterboard;
 
-- 
2.41.0


