Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B665DE677FD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E18-0003Pu-EY; Sat, 02 Nov 2024 09:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0q-0003A5-Aa; Sat, 02 Nov 2024 09:17:56 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0o-00020G-O8; Sat, 02 Nov 2024 09:17:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3807dd08cfcso2276488f8f.1; 
 Sat, 02 Nov 2024 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553471; x=1731158271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyBZgo+H9vb+N+fytpA0S3Ymlld/fAbgfJZrmoRBkU8=;
 b=cnad/3dErhlR1nya1UDUF9+LWHssO6eBtJVOdIC1GAWqKKkkojCyHJHQvhYS3vsAco
 JO4MnJ+iYRgFTIl+RpVscVHWsSxnJWBwyf50t3pAk34fLuj67PR+wIAfpgxjoMmIRJGd
 OwtWyo3ij3A5cFD7TlP3joYPTMac12lQ3qhfYlejOl1UErudb+byNkyLV/ByuqQoTrWg
 XKy46Of8eNXFVAhuT0Dx4V8hm/YB+E9CiWt6GIOXKRKzJBQxp85LHzdxWO0l46HkWVFu
 Oxgr8OfLoqas/2Gs0ykx6fAe1VdFK00SbPXQHD4vPGPjVHFyjWtFoSFLaP6XJNYru09P
 TMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553471; x=1731158271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyBZgo+H9vb+N+fytpA0S3Ymlld/fAbgfJZrmoRBkU8=;
 b=S7LJED5OWjFEN4mER8V3F24OJGd9/q2evvxEYBLYMnizqL87q0IANmrAvfgsVn4ml5
 ieqJqO6dO6p3VneSzVIL1RkFJyHKCQgpI21c1JxmNCwOUxWbnfG9LMvXYc+sF+mcQhtc
 UNmca0UH/orq0mKhQD37JrDjut07YP36c9aziYEXACm8jR8dpMXZzfh4ekgJTQC9H8Gm
 IXVX/GpO/+E/PDtsTpDh3dB2grIhQH2Z2WZ3c5Lttp1LZ3hGFzcM1ZvcykepC93e5vIP
 wJcmC9YNi+AJOwqnOu0uyk3LXpjZsWEb3dPVTwqUJPoBZ2XifdkUDXsxDs1k4OHvDb/t
 m78Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwPnhQmpRxgx6GdbfoBWGQrKeu1I9MkkJzo23Mjnph5N9VcWArdpCBOFync6AhQE8eaH8kKj4tqkDH@nongnu.org,
 AJvYcCXKrHJUNRXEXBQqJ2G8jMk8ledIha7hD2y7RtEZ8lZ2bN4McNJyyC9Q/HBU7ezQ7seLrPJBnIvFiuk=@nongnu.org
X-Gm-Message-State: AOJu0Yw2+Qgf4EHhFMTvl3dkGRZFlQ9BWLttwWCkLMu6xAvf7gP6CZFX
 AT+aV7UjlkIGTGHZKH5gBymP4F81Bpjn18aFovLeXl/mzRFqILhvJYmE6g==
X-Google-Smtp-Source: AGHT+IFmo85UhsYj7yM/t9jVFu3LpfoBltx4O9rUXGdXmiiFp+UENhvv8OH+qjBlv8JKsxZ9VkUkAw==
X-Received: by 2002:a5d:6d0f:0:b0:37d:9565:4db2 with SMTP id
 ffacd0b85a97d-381c7a469cemr7604057f8f.6.1730553471197; 
 Sat, 02 Nov 2024 06:17:51 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:50 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 16/26] hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:05 +0100
Message-ID: <20241102131715.548849-17-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/fsl_etsec/etsec.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 3fdd16ef2e..9bd886b996 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -36,7 +36,6 @@
 #include "registers.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 
 /* #define HEX_DUMP */
 /* #define DEBUG_REGISTER */
@@ -431,17 +430,14 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
 }
 
-static const TypeInfo etsec_info = {
-    .name                  = TYPE_ETSEC_COMMON,
-    .parent                = TYPE_SYS_BUS_DEVICE,
-    .instance_size         = sizeof(eTSEC),
-    .class_init            = etsec_class_init,
-    .instance_init         = etsec_instance_init,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_ETSEC_COMMON,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(eTSEC),
+        .class_init    = etsec_class_init,
+        .instance_init = etsec_instance_init,
+    },
 };
 
-static void etsec_register_types(void)
-{
-    type_register_static(&etsec_info);
-}
-
-type_init(etsec_register_types)
+DEFINE_TYPES(types)
-- 
2.47.0


