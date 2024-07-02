Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6B9C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCF-0006P9-5R; Tue, 02 Jul 2024 10:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeBr-0005QC-07
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:04 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeBj-0008G7-Nb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36743a79dceso3070463f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929334; x=1720534134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKQMcV9LKaA6zhhnGkX4WVr3MTh1gxn1oQ7jR99yzBA=;
 b=kWG11Kj/eIWq6GJRDSrARgMtsPrmErcJIscuQlk6M7CZbb3we9YQ/ohgVEgoXbCJ16
 8RLSNxIzsvLCRBSSRrIrwkpzIVGIxpvW4AWI3x9RE8pj+0LroHmomUxpVIjO9kwgBC6N
 0BgmICic4Avjw7hgrGVvEDlubtsXLLgoohiPusf8qV8Ss7b9+UpOuxWNo5OE91PV8AwP
 5kKYdhkmONWCTkCfVwRo3+UjjPldiJHGhVk45ppYWG91etfdeCQDDGLftFvBq6yJ8nsV
 r+oc4H9jFCADH5EsOnpFP+eVy1DiUPs3WiN36duzaMp7mNblLxEUCYmfK17FpgyHyzLi
 H0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929334; x=1720534134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKQMcV9LKaA6zhhnGkX4WVr3MTh1gxn1oQ7jR99yzBA=;
 b=Fz5k7ldeLpH2GdlC9UbBY4QaNYVnUrdSNY26IQKGi/V8+QR7oH32UoTtF5iQQw1itD
 tPe2X+EFtFI8yL7ziTKjtDjtrzl6fKwBYsleuZuPS9zfqyWFi4AhUOkNYjqpDbSVwgAW
 7wNKtPfvAI1IguSlgyNY1QddKCit+DUpaDgfaz+V6IT5NZu/Og64h5fLiqoeFvjOjP65
 a8vZCnPxGsX6nRLm8L66s+Cnvd1xwojannvjJF7aLs4sCXH6osESVYxcejnIjgExd7gQ
 saDvK+1WlamD0hI8Sr/Y+0j+5yFmb8c5++HCyAuOkMUOx2eN7wsS4psA5r5fojABWGZn
 FntQ==
X-Gm-Message-State: AOJu0Yzm9SI5b835KLoYufTD907mVnS0nQ3Vf701tv6wZ3w3G15xotv9
 CAU714z/7lctn7xT98WzBuxG8rjft51CnU6jkmwF39ES4H03/YIZOL4R6LwkmsB5VbvDzJFz/PD
 o
X-Google-Smtp-Source: AGHT+IGBgvIuN7AYOsu5c5vTjjvI6HHngXc6OltS1FUcKAX0ZScRb7Z2yM9feOBhWX+6s8kGWNCJKQ==
X-Received: by 2002:a5d:4282:0:b0:367:89b0:f584 with SMTP id
 ffacd0b85a97d-36789b0f6demr1274520f8f.11.1719929333915; 
 Tue, 02 Jul 2024 07:08:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8cd8sm13305323f8f.27.2024.07.02.07.08.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 07:08:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Thomas Huth <thuth@redhat.com>,
 Shengtan Mao <stmao@google.com>, Chris Rauer <crauer@google.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Laurent Vivier <lvivier@redhat.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 1/4] hw/sd/npcm7xx_sdhci: Use TYPE_SYSBUS_SDHCI definition
Date: Tue,  2 Jul 2024 16:08:39 +0200
Message-ID: <20240702140842.54242-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702140842.54242-1-philmd@linaro.org>
References: <20240702140842.54242-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use the macro instead of two explicit string literals.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/npcm7xx_sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/npcm7xx_sdhci.c b/hw/sd/npcm7xx_sdhci.c
index e93dab8dbd..fb51821e11 100644
--- a/hw/sd/npcm7xx_sdhci.c
+++ b/hw/sd/npcm7xx_sdhci.c
@@ -16,6 +16,7 @@
 
 #include "qemu/osdep.h"
 
+#include "hw/sd/sdhci.h"
 #include "hw/sd/npcm7xx_sdhci.h"
 #include "migration/vmstate.h"
 #include "sdhci-internal.h"
@@ -162,7 +163,7 @@ static void npcm7xx_sdhci_instance_init(Object *obj)
 {
     NPCM7xxSDHCIState *s = NPCM7XX_SDHCI(obj);
 
-    object_initialize_child(OBJECT(s), "generic-sdhci", &s->sdhci,
+    object_initialize_child(OBJECT(s), TYPE_SYSBUS_SDHCI, &s->sdhci,
                             TYPE_SYSBUS_SDHCI);
 }
 
-- 
2.41.0


