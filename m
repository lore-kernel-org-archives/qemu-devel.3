Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00786D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al4-0006TW-AH; Sun, 03 Nov 2024 08:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al2-0006QV-Aj; Sun, 03 Nov 2024 08:35:08 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al0-0001To-Ld; Sun, 03 Nov 2024 08:35:08 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso588614366b.1; 
 Sun, 03 Nov 2024 05:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640904; x=1731245704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXSWlQsS4wnwDh//bO88rrwGjYCS2NZpoLPVmLCuaSY=;
 b=lQNXVNwjSZETQXgWfD6/AQ6BkKF6UfMnNwqFiSYy9KAfnMa1y6pL7n5F7VPb4W936/
 +9nTRDBAbL1CQXsrI/CrdnVoc40us/o4hXcedKPJThvn8kK7vz0kjxVG+r5ZifpTHL5a
 aFgWrAuBGorjT/e+u1M07ejonOfJ1eblwbGjTc13fL1cdXXAaT7dow6/3fd5syQjtOVl
 n2SrlaeDtIHrUUjE4b6/Udd58k8hucEUf87/jm+VI82hypDgko/hDZhoanmHKIp3Vo13
 94ByVwTp+pQ49t67YglWS6iLnwj+j3wp0mdFbL6jTDF5AEPS5b/wvAhmJwW7l49lNWEa
 rIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640904; x=1731245704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXSWlQsS4wnwDh//bO88rrwGjYCS2NZpoLPVmLCuaSY=;
 b=CBnHPh2QkI5KxLgR3N4OK/k0/0Hly0qFYfvHlyyVFGLErhCNg9iy4YGEy1ET/2bq5+
 TpOWyNnL4Q4jj8MxJI2S5u+/iOSIx/5VewN0IEyJF6Poer2bfwNapE2oWhId6IgxwBTb
 6ghgWsnw4E6YhTOi8OPC7lA3RKsIBWrm2fqePHdEMBAZPUeIuL5takpKhryZWIlZGGqr
 rDYVFd1qqGjaZc1jPXEEwhtfXmhKohK3VSkyzBlSPx/1PecmY9hBiN3C8mH/dM0Pxryx
 jwBIjtmmqw/njFTL9Nkko/Eecg9UrNVWv2ooByOxNorJTn60un68n1DPUxg90oigBT23
 uSsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkRY11kQhCOVk/M7IXT4qdmypRfAP7gCG2Yhm5CUD0aFt2x+lfN0FrYYj9p4KQWHl3hth6kl2Ik1qd@nongnu.org,
 AJvYcCWzYI2kgQHHUdxWkAcF7YfDNbDkIjf+83+INXGA/rs1n4iqHNeUeRfN1GwduUdGbyQDmuilizymoy0=@nongnu.org
X-Gm-Message-State: AOJu0YyxEjl+ytIWxI/VNtyobFdZqJmx744sOCgFQZ5OoaIWmRUNJAf4
 Pdb07KEVlKSWL8Pz7vql1RoNSH5vThFqvGtT3ZzlSk5KORUXyjwifYJnaA==
X-Google-Smtp-Source: AGHT+IEgdICE+E1VWTYNLUdtxfjCc9msz+ItmZKTCilM9azyMl8KI2OsQlG2ahUGyZWhSRn8WJ3XXw==
X-Received: by 2002:a17:907:d18:b0:a99:f8a2:cd8f with SMTP id
 a640c23a62f3a-a9e3a7f434fmr1634973266b.64.1730640903872; 
 Sun, 03 Nov 2024 05:35:03 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:03 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 16/26] hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:02 +0100
Message-ID: <20241103133412.73536-17-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/fsl_etsec/etsec.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 3fdd16ef2e..d8076e7be4 100644
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
+static const TypeInfo etsec_types[] = {
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
+DEFINE_TYPES(etsec_types)
-- 
2.47.0


