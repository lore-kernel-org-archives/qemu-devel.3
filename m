Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974D9D3E77C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SNc-0001Vs-HV; Tue, 05 Nov 2024 17:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMu-000154-R8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:50 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMs-0004Sp-Me
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:48 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso1513495e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846984; x=1731451784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3NX0+cSAzGYRrfL4oLem/VlulSkEhLXyoePR+dn9LQ=;
 b=iCSFID4kc0TpR5ePsB+O6Qk6RoNauEWfnYaLYjqiO6s64u/YDYqJQIT7/F+cQa4URO
 KLl+wu1Ylkgx+YveDAsl0dj+fgEM/nyxdcxeO0FXzFh1XywYLoDnFAsXMYLbTKznWqyN
 sTFN7uc3pspl+fje0z6cL4dVK7S+dO316hJETgwYbuMrr5sVwq/wp5mBcfdNdjceZ1il
 ukdTVrE/vy6QkUtbqD14ESdBqBpck8ABDkbEWlZp/6RotWQx9DnCmp9cSm6BbMJKC8vV
 8XXCLmWCOK2WMxN5/ZQSpr/3kHOPfx6k5TPoDgvJB0VIHZU5oD6kOnTYdnyRGDXKX+rw
 hMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846984; x=1731451784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3NX0+cSAzGYRrfL4oLem/VlulSkEhLXyoePR+dn9LQ=;
 b=NNblvdSIsscIyN/e9ww67FSGAoRTGLJzxHhgagKapazykwgPAd0O0UssuzbEXJoMST
 2vOW3JtYuDJWMxUvao+8fEnU+ZYRgCUgnpysl+Gbydv4q/3ckqga0RFIWxymuAuKbcSS
 DuF+1qmAq5/1woRXnn7xoZhitrQzhQOt3x+o0sOcRo6/nQqwHPSFYdTXT0K7z1wTBY3l
 U58FmYmBEaK1qWyiV2QHEAiYD0RYf9jHxLjmcMRGF8cXGz/fs9BfkcuUrePoZOxdSEbn
 HSwQ5hT+2nsoqCM3FOBEZ76ZFKL3R3+vhqEZIAonTX2mpCcmZOg8DpJiDoEM/f9Fc1BX
 /oGg==
X-Gm-Message-State: AOJu0YxNpZ4hx9g1vqSGsvIkij3RBlYN0yo1U9AJkmRYUX5aThnQrarX
 cFmV9WMjJfk464BxsrN71Pa6jjJs5IxanSYPMUzVIsW3yIRxwtp711KFLTqcYJqf7abAGJFEJEq
 n2pwyIQ==
X-Google-Smtp-Source: AGHT+IGdpEbm7TpMArpemwMROqUAziy3iEBBEVtr6QW8X6RH2WK/5bTQJjlsNVPGoA6HLjlTtQqHnA==
X-Received: by 2002:a05:600c:1f17:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-432a9aaa8d5mr3137565e9.10.1730846984188; 
 Tue, 05 Nov 2024 14:49:44 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7365sm17187368f8f.54.2024.11.05.14.49.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/29] hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:23 +0000
Message-ID: <20241105224727.53059-26-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-22-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 7b6ec644426..21a81b44f03 100644
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
+static const TypeInfo pflash_cfi01_types[] = {
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
+DEFINE_TYPES(pflash_cfi01_types)
 
 PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    const char *name,
-- 
2.45.2


