Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB63ECF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPv-0003oA-O1; Mon, 23 Sep 2024 05:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPt-0003eG-DZ; Mon, 23 Sep 2024 05:31:37 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPr-00071q-PI; Mon, 23 Sep 2024 05:31:37 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so496305366b.2; 
 Mon, 23 Sep 2024 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083892; x=1727688692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjFxdBHFisGMgmJV+yxy4OCzd9gwLLwjEyXicrgoEOs=;
 b=LS1GK+bRTaKOMqhMIw53/20qK4hnig4f7NGKvnVxID2YkufRd/73L9UaAGu2Jm9M+Z
 YJdQguWca+64qYfiolAc2V7VqHrEONCEYp6c8vG0pLZChoC1tfX+EAHXLMbO3ZG1Fxxz
 INF3FlQMngRmHCAx/CetSWHy3arsm4THUDFSLA2u7AWgMNRJTa2JWk5JfKAE8ZINZsIF
 GfInWbplTH1AOzGroI5GzYvrlsAeKeRb7ZlDZA/IZdEFHKIec7B3I+v8KPE4iM7PyJBf
 SYCY5hR/q2b52yiueZuWSgOUSNy/M5UYuix4s3EVoAqj9ZGgNY6M55cLXbPUw7MbVoLw
 Y0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083892; x=1727688692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjFxdBHFisGMgmJV+yxy4OCzd9gwLLwjEyXicrgoEOs=;
 b=qQOgpqJxAokCQC6HLW6Ia0wVhMLUean5fJQVbpiTG+qytBpppjELy41Jtm6vDpDrhj
 q/dmdaJ96W+D/dxvef1l30F41GZ9Gm8c4Jpk1Z3Lw6z0r45d4MxHZtBoaYxDsqzo1ABM
 t0wToucXyloQRYp9VX83dz69g6oJK6hIocwbIcEjuIFQHtcCNYgR65YbfVqWLGi1eabY
 odF4eAlxD4PlXUePE/ojgkVHxvH2pgZCRZdxH+f2zhnoG/4TVtgx/kVSzxRAaaqQ2zj7
 JtPtN0o3ymjf9Sqj+64kz6wV0NgrAjgpnmrn3VSEh+wekLy8v1P2lkQUDo2X6YeSWG4S
 c1Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbkpcYtJrPV2Idh0JAkpVtvDsItd9zdWabOrMrEZM5UG8t2/UqSD4rTku9d/WUUG4LiKYugPh3WHk=@nongnu.org,
 AJvYcCVbvmr9frZz9/Of2aWFC92qCS/Eb3NKWUyZUrgX3r1kKvfF0/K7yWf7sfPIAjmrciK6bSmPB7aQu4l2@nongnu.org
X-Gm-Message-State: AOJu0YxBG63W9iEFgcI2cFBoRH1qHkkPxvOKnRJZ7B8dyZqMdWE+Krfn
 f1Axcec6QGSKo14dmavljQV7z6VFTgFaPwwTe3KcMGOdnWc4JfI43ry0Xg==
X-Google-Smtp-Source: AGHT+IHgNIv65lwph6phtyyhYNvgu3BbDU7C3wE3C8+IvpPtkEKiPaPFW+Dm3TLnNwK18hUSoHQpyg==
X-Received: by 2002:a17:907:2684:b0:a86:8917:fcd6 with SMTP id
 a640c23a62f3a-a90d512f9a6mr1064726866b.60.1727083892232; 
 Mon, 23 Sep 2024 02:31:32 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:31 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 19/23] hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:12 +0200
Message-ID: <20240923093016.66437-20-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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
2.46.1


