Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DB8C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr2z-0001aW-JF; Fri, 05 Jul 2024 18:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr2x-0001XH-OJ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr2w-0007An-9R
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so1218101f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217087; x=1720821887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4MUhhhcXCJmOjITmXxH8sb428buFk6h9v9ZsvqgcZw=;
 b=TE1Lj2ojcE+6jeUlN37BadakwUyZEMzQbA0+OxutMTqkxchQdliMUbrJY6COuaz7DR
 FH19y1V5ywk9HRHzi6x6Rwu194LCgtcVF7l+ihYyY/zBtcP0XcJsdKH5JFLE149JuRI1
 QA/q3s17Sd+qi4z4EKww65w+df2lePBcsU9zwzulwGXcwY7Z57yTN9oYb6cr7lbDcyuj
 zpn/tvEypaGvJuIDGvaH00QXVeL3n2OSFcAgRbsZkdFAzFrzpAHj+cK3tSUi+RDfOP0M
 M5mkUp78eH2WTgELEdNxloQ0ZU0Iq9oPU+uGngVK3Ztc2ZpkyNuk5IOvGSqT3mUa2x5a
 OIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217087; x=1720821887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4MUhhhcXCJmOjITmXxH8sb428buFk6h9v9ZsvqgcZw=;
 b=HfG4KVVvQugqa32EWY+GYx8Zqlewt9HuKOYYbIMuDgiGLLVP5xIBlTgKnn06rXjh4Z
 HNiFqYu4UeIHl2lxY5KGGQvmEKAHYFAhY5Po5Ukn2i4G4ahUckUe0qTo5SDRQ/PX5pCR
 Xlqx0nkBZekREMU9M94vqplOxig8yakbnaHUfag1CPyQ4JDOrgChfhKDEk543rHN+7vU
 b/xDDKaJmxWDy2qqwWrLZJFZGaxWsCEK6sHsL/9J34ed1TOFtL0Jjqtf9UQ65dLrHjmc
 eoX8PDsCEwaRQ6Sjm/WQePJ/MggWv9R9TUvmB3Jdur7SRjI0yXH/eXLnZLqZkgCihaGC
 pr1A==
X-Gm-Message-State: AOJu0YxTSv2a8fXnPx1UDsJVsw+/iHtbqvw9tE+nss48b08I4iatnHSd
 X91iZapqctyx5Ua9Oovu4y7WuMLg68ajA78FGAkvi9y9AdebqfPpLkM164EpEW85pNjTykj0Gp/
 0
X-Google-Smtp-Source: AGHT+IEIuSeFI1xd6ZepxEpDGNnELb+4Nah9BJgHQDTPz6ZZns7ePWSdueOMTaWJTACYD1R9OGUeLw==
X-Received: by 2002:a5d:5407:0:b0:360:89a3:5293 with SMTP id
 ffacd0b85a97d-3679db88a10mr4268703f8f.0.1720217087570; 
 Fri, 05 Jul 2024 15:04:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d6123sm74888065e9.12.2024.07.05.15.04.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:04:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/16] hw/sd/npcm7xx_sdhci: Use TYPE_SYSBUS_SDHCI definition
Date: Sat,  6 Jul 2024 00:04:20 +0200
Message-ID: <20240705220435.15415-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Use the macro instead of two explicit string literals.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240702140842.54242-2-philmd@linaro.org>
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


