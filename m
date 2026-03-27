Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BF910ED662
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Dw-0002PI-Ef; Fri, 27 Mar 2026 07:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Ca-0007iq-29
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CX-0000Hw-Qo
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1507145f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610283; x=1775215083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDzfZGwv6v+8VJK0QWkKKZpbO/PDYJBzFKBjYptKlhY=;
 b=jBJfJM+cdsS+djCG/pTKKCu+KlCme/vky/2zMcZGqCqHt3fBKW8+yidO9bow/GAQim
 TfAiV3I9edLOcWuPMAIuA+0Lt3driiIl65FYmP/UkXbgEm655zndeqhKc8P0B+o6Iiok
 W+cs1kCJFEX34m1S9dLAijIBfQYKap4qZOUcoyt/rVzfpQtk1cYOrM5Yn/H2ONjXX0ci
 gVDqpf0SlS5ILVzhBiwVh0r6qwAlhlH8pzQVGQmFjrkbxghFX0TrhpsiVbgw6OOTZRGI
 yx8aAetRHH23+4uH9zaQotolM6obuNnyAmY6d1WfQvfBYXBrljVEJl2q16nAusqZP6dn
 8OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610283; x=1775215083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EDzfZGwv6v+8VJK0QWkKKZpbO/PDYJBzFKBjYptKlhY=;
 b=Nx41ZXt8z5DCkQzbgSnESfzk2EFL69AOZ1U8dS0OQz0i2SwpcMuwvvmrAvzF4wPwmR
 zEPRJlYe2GxaaEwhEp8D41e6FrFA/UdzrwJszRqt0PQptwdzqLnkwhN5+Anvp7D0E3TM
 Lr99dheqSVmbgY2mNQb4/XCmeF9Kl66V74VShXAUOBAEmTiqajysI62+7oCmeZrzTFsI
 45VL8L6A/gV2vSlk+0JWSpLx/ZWy5C6q16N8hbcKjRKaQiXp84/78KpKDTwN6/eu0nbQ
 vISqqM1yFknN1arz5LgSLknOMDkerxtZ+mmxnsPIVCetm+cth6Ie4+//DGbFZZKWbNuy
 Wrgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFyUsIT36QXp4ByUk7GPJWxp5iLS8qWCF5fqfUzk1l8M4D60JiydfbbD8zbjm3r+DVd9txjUw8utAB@nongnu.org
X-Gm-Message-State: AOJu0YxhaI9ODMdtP4OxcDt/GYKtNX0hcPFS5CfKTe39fSASADFZn7XA
 ULnUtNpxS1ge7cXW92UvA7JfS2iiPqepOgOTzwkfHIAnT3QXywo/g30BY2WEX0LeZmg=
X-Gm-Gg: ATEYQzzDZCjxhcUhAmSBu+ymbb0MGjafZB0Z/Vz58o6W8RAH8Q/Y1apqw4yFoGA7+V4
 DV1/koFCnLzPI5tcEGWjMI5elttTiEnz776W0fX6ZlLRGfuK9Y+fn8gf9l82Xjvr/I25+dh3YOo
 wwCFQwz4NrpW8oQ9VHQN9n4ZgBtPPpp8Evyv7a4sQNldF2S1eoLhFdxBl7R2Z9e/WBqdTDnSUEH
 L9CVWq8thLjl1fykDSgD96bN8BHjQJCeldNbjSx46CMLVglhu5YEz5Pi7KFJgmIoJwTBD4GFxII
 Wh28orhwBkTVxevc6/IveGYDT9MGvZH1jO1mYur9D6cSRxwCx0k0zfLIGiecrPkeV1uACwOLzOw
 ofC+upQrvIsH6X2xa3x683wwEtTjk+NUpzq+xBhRYoxyRlO+Z911eCZHbAsI5PP7+8Fz2gsL20S
 npXIZYNA+swfMbMNXDbNzSdPcryALqItNMhlGimN4bVn0WDtkA+fHV6mnqp3CsKV9BBnUMLqUi8
 jFkvOU46Why38l3q2YEnnr1Ffq0d60=
X-Received: by 2002:a5d:5f96:0:b0:439:d769:ec56 with SMTP id
 ffacd0b85a97d-43b9e76a760mr3065581f8f.0.1774610282995; 
 Fri, 27 Mar 2026 04:18:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:18:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 64/65] hw/arm/virt: Enable GICv5 CPU interface when using
 GICv5
Date: Fri, 27 Mar 2026 11:16:59 +0000
Message-ID: <20260327111700.795099-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

If we are using the GICv5 in the virt board, we need to set the
has_gcie property on the CPU objects to tell them to implement the
cpu interface part of GICv5.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 15d833ad8f..0aff58bc3c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2675,6 +2675,14 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
 
+        if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            if (!object_property_find(cpuobj, "has_gcie")) {
+                error_report("Using GICv5 but guest CPU does not support it");
+                exit(1);
+            }
+            object_property_set_bool(cpuobj, "has_gcie", true, NULL);
+        }
+
         if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
-- 
2.43.0


