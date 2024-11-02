Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA75E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E14-0003Ix-2O; Sat, 02 Nov 2024 09:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0w-0003Cc-VT; Sat, 02 Nov 2024 09:18:03 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0v-000226-Db; Sat, 02 Nov 2024 09:18:02 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cb6704ff6bso3692481a12.3; 
 Sat, 02 Nov 2024 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553478; x=1731158278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMacwjv/1tKmK7lCv+ouUwchF1w/lla9CPW970fanmM=;
 b=cnBX5jFiMlhYxMkorxY2T92m/Up9BmsdU2HbeCVbTA56rKxux3r/HPsMX/Adt8fDTs
 tCqNR2mnOBnnQ1H1cgdbG67YXdEiETOF8G0nE4GXuIlAP8AxxatGcCYn/03jgeaABj6L
 dOQC3xuk7n1MT/xMBu2Z7DDLSlklY6nJrzMYlfXmgpAQkdfEYHiPnC+fe9xYpbPuEtUT
 hBronKnFV7w3xnJQg9Ghme0on/O++liWyfYjimI0ZGxDNxi6l42LqwtGkJNDp6RrQvjL
 iNtlQtNv3YNsyoFfGJ/OSt/gDeXM/HMk21PYHZ9W1iamurp5aP3VPOCemX5jt3kp/ref
 481g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553478; x=1731158278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMacwjv/1tKmK7lCv+ouUwchF1w/lla9CPW970fanmM=;
 b=C3fYL2/OVM0WwkjTWp7q9z2oIxAAhwYF7bzbmNe/6gvpg4s+KTvVSbiTAAPbbPsBVh
 KnHLrevoHbNKPRv7YTQ+k/51wvClOJxohgSox/uVN52qMaNFzWupbgR7IW0t7A6Ntz06
 LbKO0fTit8Gn6Aea6+xAMH4Wx2e011IE/o+wApX59fulm3oPLQc3pInKy69xM19yGrik
 Ms747qUnFOmdE8/MP8+jvb6FBCA872+fkb/OcllOfTbDB+VYb/uUszmd/phnovvDqdZL
 4qkrVx8aTdRHXd2nnVxaFqB4/vgYay5kUZatHFAHQR7JaJTpoYZ9hoKbOqZKghBS/aqQ
 l8cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH3BmpGxpvSuDWeq0dexOZvCgGhqUmfgk8Xk90Th92G2eNEv3WQ1ta/HJDMLmd3HzzIeo0cRNQV6Q=@nongnu.org,
 AJvYcCVDNnBtdKZnfHBnDoA13+2ayvqgxSFaAezP587/wTa1EYmdnIoyesQygcdoD8sflokwW9QBMd3SpKH+@nongnu.org
X-Gm-Message-State: AOJu0YxBUGX1ubt8z2rHiDudFjZNdttnW4MLXgovLPTdNzW9F3TaA2Du
 Q/Ijp0k86+5Rcjh9J7J9fcIcWUPu1CKbvfj7qzGd9aLvO4/GuxgVSl0YnA==
X-Google-Smtp-Source: AGHT+IHmzBK2nHNbkuuv3TBwHol7fRMYRf6oiJXrXY1RJZroGDeb3A+rQl1bIiKjTU9hg84bo3RpFg==
X-Received: by 2002:a17:906:db08:b0:a9a:1165:1bb with SMTP id
 a640c23a62f3a-a9e658c1759mr685727666b.65.1730553477526; 
 Sat, 02 Nov 2024 06:17:57 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:56 -0700 (PDT)
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
Subject: [PATCH v3 21/26] hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:10 +0100
Message-ID: <20241102131715.548849-22-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/block/pflash_cfi01.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 7b6ec64442..cf11dada29 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -47,7 +47,6 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "qemu/option.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
@@ -947,20 +946,16 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-
-static const TypeInfo pflash_cfi01_info = {
-    .name           = TYPE_PFLASH_CFI01,
-    .parent         = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(PFlashCFI01),
-    .class_init     = pflash_cfi01_class_init,
+static const TypeInfo types[] = {
+    {
+        .name           = TYPE_PFLASH_CFI01,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(PFlashCFI01),
+        .class_init     = pflash_cfi01_class_init,
+    },
 };
 
-static void pflash_cfi01_register_types(void)
-{
-    type_register_static(&pflash_cfi01_info);
-}
-
-type_init(pflash_cfi01_register_types)
+DEFINE_TYPES(types)
 
 PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    const char *name,
-- 
2.47.0


