Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E7CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkW-0005b5-AD; Sat, 05 Oct 2024 15:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkR-0005Xe-C3; Sat, 05 Oct 2024 15:47:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkP-0007k5-RQ; Sat, 05 Oct 2024 15:47:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42f56ad2afaso41163205e9.1; 
 Sat, 05 Oct 2024 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157643; x=1728762443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cl3/ACOFe6sZ551UWvYmqWR5h6YnAmWXApza4E1vkv4=;
 b=SePOd9rNYXOeJBFprIZXA3ApD0X1yz/INPt/u57hsFVg90gxDojKjsmbkQ2PhadkaE
 YN1Bspm2IemDLpri88SpkVnm5vEbdGpMFfXzdaShgnbgz+ObR/ZcMYvlhtjWucArfcHZ
 mDIyQODEx6dY+qBXY5C4UPiv/CUgObzc+ildUNPq+DPtwAF7YWg5Edh/I5WHZpTl1yf8
 8CXcOMjv5rbwbhH97np7jl1LGmU5AzDgTr748MLfM8Cigs5uTqmByiIh+/lH7E5kRf4A
 iD1oG51QgrkQDS05OFwHx10uHwNQygkRaHQyrbV0THd6nyWGOI8pcrvItHQq5/a5XQsJ
 T0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157643; x=1728762443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cl3/ACOFe6sZ551UWvYmqWR5h6YnAmWXApza4E1vkv4=;
 b=HJd8TG/sFNHM8dMBP/7ZTc9j+A8P5XPzNncBm2rQJrnMJOKD90Qn+EeEoEyJVwwPVF
 ZOcMJKkuRsV4rqDftu66TPZcAYQJOzhIZuWzj8sXzHrlAZgJsXFwHz3tALwNRZPGvGeE
 4aJibMQ/HfKcbA4iRBEpGkpUQEfUh20sNzrOaSk7a1R2aao8gtdhmb06f9jVRu1+lahX
 CGC+I/wmoXkvh4W3C29omBg3vL3yz4S/1q2KrTj0PPb4UwNs1xH4ki4TW93mmW3575wV
 v8fxprB9hmNOvBLTQaMBsXwwK+maIvhdedEhw9puA5jRk535XEHQYnUSO24FDM4rFC+R
 i55A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWOxFwbMiYtSmimmy1c9/WmLSX40Y8AwVHfsNZJGVRuzybuv6MqHceWQXQsLs7AAhoHuAnu3ytGsIG@nongnu.org,
 AJvYcCX1g6YMdlgOaV6G235xx7gwFBRdbO2tyCcs8C64tAlzzJ3PlP8t0ii7SVOCdN4Eq1jcrfJ5pa14u+E=@nongnu.org
X-Gm-Message-State: AOJu0YzhsAwVqlzGQyDVEg/U8GNs+unmC37QgZ2cUC3jBtxYtUm5IDKF
 bkQKtU/GkqBaXxPmO1AY0NyJ56WfqibtM7kc5DEE/LUOBAvQVvmzmQNrRw==
X-Google-Smtp-Source: AGHT+IGZ67Jr/eSNElQpJKULOfk8K3CCWn8qnoAvzNqTAsK2SvigepyhfbgKtyPCAZOHIw3NwV3FHg==
X-Received: by 2002:a05:600c:4fd6:b0:42c:aeaa:6b0d with SMTP id
 5b1f17b1804b1-42f85aa957fmr77854055e9.9.1728157643206; 
 Sat, 05 Oct 2024 12:47:23 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:22 -0700 (PDT)
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
Subject: [PATCH v2 21/23] hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:46:01 +0200
Message-ID: <20241005194603.23139-22-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/ds1338.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index a5fe221418..6de13caf99 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -14,7 +14,6 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 #include "sysemu/rtc.h"
 
@@ -227,16 +226,13 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_ds1338;
 }
 
-static const TypeInfo ds1338_info = {
-    .name          = TYPE_DS1338,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(DS1338State),
-    .class_init    = ds1338_class_init,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_DS1338,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(DS1338State),
+        .class_init    = ds1338_class_init,
+    },
 };
 
-static void ds1338_register_types(void)
-{
-    type_register_static(&ds1338_info);
-}
-
-type_init(ds1338_register_types)
+DEFINE_TYPES(types)
-- 
2.46.2


