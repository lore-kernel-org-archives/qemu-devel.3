Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68306C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1m-00079Y-9U; Thu, 15 Feb 2024 13:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1i-0006pZ-Cx
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1e-0001tC-Gm
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412345cca4eso1641045e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019992; x=1708624792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrDWAyGRgS7V1HXGadIwipz2b43fHU+C3C1ocsMbGSU=;
 b=eSLdhUi4QXO3Q4APHbiB67wLcgis0wcTKvILLJ6Aw1XL43jad83bipoBhnWZaakNxK
 InhpHO0sXjpyZIAMIPcNbX3dQxzitCiveCWYq/96L1aHH3N/rwkUbvwEavL13a8P+Y5q
 bxBDw4Tvw05plZ0t+vfnPbx7lm1XfWS+qFxYBLy4ARdO1Q8yRLtE3ZaVJwTSX8156sk9
 AHXJjXWkashzsb5nsjSVvCqdxjsqA0ePxiD5hXORPJZjGoDoMlT2G371BoRzI3jbAbaX
 GpkPeNRvAM5LGvIC9x+FPCbskY+pxFmuzEwHzkt4rZiiyGK411jXS5lmei5Bp4tal3Hp
 +RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019992; x=1708624792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrDWAyGRgS7V1HXGadIwipz2b43fHU+C3C1ocsMbGSU=;
 b=r6M+HJSUDcKxlvpAreGwXyssoEvhsMAqlpJLAS5H5pcFMYAPc1CczkP585ddc6gWdV
 sR0l0p2DpnQjTbn0QvVvJKq51kOec3VWUQ6lUHKif2CRP4NKJ7ytW3a/nbrWElsYEI5M
 ZT0BaZ8vVaf+gt6eJ7r/LzPm0/+i8UUBL09EJZzW4M3FUqxiH02V5q9RoBFINix7Trf5
 YGZAQuGvC3McFDF97kDjh5B5rGzp+5vUeQmKnpGAn3DANtTatfWFYvZPOxc2UjfIObm7
 4u9NNNMppLd5jubVlXtn7IzlhYUgDJQNT+fnsIWBROvj7j7ceSSliod0NJhx7yRHYD6Y
 NqYw==
X-Gm-Message-State: AOJu0Yw0RMAU2cFx3eLEu/PFY1L8vS+2eNu5vI4iyzwex2LZ7wSz/uQG
 KgU3tQR+fGh+WuSqTib9BD9HGL8uet5Vz8Rw5X0rJ+Yso5A2QPCZ+Pf20zC7BG2G5/i6Cs3yLCn
 B3BA=
X-Google-Smtp-Source: AGHT+IEge+7N7R5Dv+aWhleCePe/xXWie3Ax8OjFhYHUQVNaLC46zf2vna8295JbBHhsrvOyp0WM+A==
X-Received: by 2002:a05:600c:91a:b0:40e:f46d:ad35 with SMTP id
 m26-20020a05600c091a00b0040ef46dad35mr2161791wmp.36.1708019992628; 
 Thu, 15 Feb 2024 09:59:52 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a7bc7cb000000b00411b7c91470sm5630301wmk.12.2024.02.15.09.59.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/56] hw/isa: specify instance_size in isa_superio_type_info
Date: Thu, 15 Feb 2024 18:57:12 +0100
Message-ID: <20240215175752.82828-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Right now all subclasses of TYPE_ISA_SUPERIO have to specify an instance_size,
because the ISASuperIODevice struct adds fields to ISADevice but the type does
not include the increased instance size.  Failure to do so results in an access
past the bounds of struct ISADevice as soon as isa_superio_realize is called.
Fix this by specifying the instance_size already in the superclass.

Fixes: 4c3119a6e3 ("hw/isa/superio: Factor out the parallel code from pc87312.c")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240213155005.109954-6-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/isa-superio.c       | 2 +-
 hw/isa/smc37c669-superio.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 7dbfc374da..d85f22db1a 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -185,6 +185,7 @@ static const TypeInfo isa_superio_type_info = {
     .abstract = true,
     .class_size = sizeof(ISASuperIOClass),
     .class_init = isa_superio_class_init,
+    .instance_size = sizeof(ISASuperIODevice),
 };
 
 /* SMS FDC37M817 Super I/O */
@@ -201,7 +202,6 @@ static void fdc37m81x_class_init(ObjectClass *klass, void *data)
 static const TypeInfo fdc37m81x_type_info = {
     .name          = TYPE_FDC37M81X_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
     .class_init    = fdc37m81x_class_init,
 };
 
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 18287741cb..9e59dc1603 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -103,7 +103,6 @@ static void smc37c669_class_init(ObjectClass *klass, void *data)
 static const TypeInfo smc37c669_type_info = {
     .name          = TYPE_SMC37C669_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
     .class_size    = sizeof(ISASuperIOClass),
     .class_init    = smc37c669_class_init,
 };
-- 
2.41.0


