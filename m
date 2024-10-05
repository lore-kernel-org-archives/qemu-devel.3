Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C406CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkY-0005dl-Dm; Sat, 05 Oct 2024 15:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkM-0005Qd-E2; Sat, 05 Oct 2024 15:47:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkK-0007iH-Hk; Sat, 05 Oct 2024 15:47:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so26468425e9.3; 
 Sat, 05 Oct 2024 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157636; x=1728762436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4Dr3HPw/83bA9AUPIBC22MfX6IPsg4vrM+FUTIQ5rI=;
 b=Exw1eBrJN0+7Rr/IKH48aABy4nAJMWL/6dImiCzKiLvlTAFx2BzvvurfFt5T7900Bl
 6JZjlCSUm9v8850MEInEuF01uwGpPl7NSXU2cpx/qki/p2/x2EQ3umLdosHeUk2OSRLi
 4A1LEGz7eWT0PcCBMziqpH+BuKTsD4CyiqW0FOSu4Afs23XZCF1y6yXkBpmDKLTJ+ppZ
 IX3VpDjaYMPEMBsjOIC3r17bk4TEPEcQMid6nn5CmBuMqo9Ds5UNSifWD5w91bILLvko
 skJn5DkkaOAVorhwXjMOpIUloE2ElfpRkp6qGFkG93+8O+MqP+l/McKvf6kUx9ciFHkJ
 diYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157636; x=1728762436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4Dr3HPw/83bA9AUPIBC22MfX6IPsg4vrM+FUTIQ5rI=;
 b=RmsMGE3rP3ATCT9XxcsOZJIkf2BHDhG0a/c466GJ1sZBf1djR75uk0W72Ps8uY+0jx
 snn6kmbgaVnipUflMSojYxWxd91C+zIdB5UzDRs+dIPYEhkanjNPiECAyXAPxH7boD8u
 9g/AmHoCCW6x9CoEJCkPX3eHytRezYn+CBizDtTJBBvdoj5zZDt1pjXIrCWpzsfRphp5
 NOCxWQTcB0qyM/1sMhQp+MAOtqTLeGAj7ywl56Crn2bqZks0VlynINyJZ8sqz/38Mxg5
 Nhi0tWRhRRyd5anUGnvC/LGlB+I2mkK8Y9WuAZ3zIK+o4SXW4r7CP30W4qiPFY70XCpq
 QTvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXoK+G8HDh7idYZ2rhQlmk009N0GUyEKr6WzQ17d4uxf16JiHCued4pX1FoPPsa3hF6vYkXRaHuej3@nongnu.org,
 AJvYcCWpsEc4kB0BsExGOPkoL2x4SZpFZVg12UwXRWal3kfNYcFFbcvRZyZ8mBCcvUg+35X9+TabwOnuatg=@nongnu.org
X-Gm-Message-State: AOJu0YzIIb4ODYwbL0f640gN+J3bXiCY/e/i61B8y+5nE6qWvUYAEpFF
 fCV4Y4Pr61IQGR2shk9jfkCVvUNN9lpl1jjoaTSVeJOkFLMW6PxQWrfPWw==
X-Google-Smtp-Source: AGHT+IFcVi6kDEKnnDjOSoLT+ADqx3S6vwTaBNiNx3jh5Ly22w9hiSZWpb9yBnT2+4djhzhhsGt3Rw==
X-Received: by 2002:a05:600c:1ca5:b0:42c:cd88:d0f7 with SMTP id
 5b1f17b1804b1-42f85ab4830mr48144685e9.10.1728157636126; 
 Sat, 05 Oct 2024 12:47:16 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 16/23] hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:45:56 +0200
Message-ID: <20241005194603.23139-17-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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
2.46.2


