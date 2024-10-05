Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E55CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAke-0005tq-EL; Sat, 05 Oct 2024 15:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkP-0005TU-Ad; Sat, 05 Oct 2024 15:47:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkM-0007j7-JE; Sat, 05 Oct 2024 15:47:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso27396115e9.2; 
 Sat, 05 Oct 2024 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157640; x=1728762440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKFL05mVsE9TRhWdfuyf1kRZkYUXZq0RfSCcqjBQa4k=;
 b=nebnATghl1DTPw7S5oyQn+yEwESsLre/my9AtJvBRFzFP58us4aie4yH02OvQWto8v
 vil7LIZEhfqy7o9kA4bsUoYnNkrXUbyl4hkSFjCzDHgw+hEO75Xa52Mm02bejWw0oYj3
 syh/DmZ3cah84ZNJMOtPQcNpVeVjzrQ1abfroJq1IOWQ0QVPqbsEn99664YaEJv0nA2D
 O08gBAMVxmGNMjX0lCdHSzoTVGIi8PVsHjnPe7vv1AVX5SgMO3GuJt5Jf/Ex22CGu9+N
 AjwGKugC4Sl9eGVWazeNkMYEZtzmINT46if6iUzJ8YJlrebAbE/M6NlDPsFI0QCjjoMg
 t/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157640; x=1728762440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKFL05mVsE9TRhWdfuyf1kRZkYUXZq0RfSCcqjBQa4k=;
 b=n9gBTE2B9Id7AMFrCqH/VhZpuICUcGNRSs/raQOVtVyauOXwLstNeJzHi633lzil2m
 Nbjy658RXyfLqHd9GK6dnC+aka/joAlbm7VhW/MzQ049n54ZnjLL0rX1fgmrNz8/Z2NL
 RYJWxDoTuLhK8AmTr9Ogc3UAZeAG0gUJOflq+Q4R2Qr/c5speTJNB/Rq1ujB3t+BRm3M
 195Ti7m3M6UV+JEs6Y5mvu4oloTPXHt5hay7m/rZYKRC3ql9q5ihR+eiEMlBtox56Hrk
 w7rKqKNO6j4oRTzEkPgRt/kn9A0hgicp4WTvs7ZkYav7HzrAZ64+ZXRuCxfCYPsBW0rP
 LMqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVVTo0+XBsIEvRF3GsmCf/7MvFTEPL4S2FkEJa/RVH8xrr7hcqMpjqJUJO3kgorx2dZBR/nmKTcQM=@nongnu.org,
 AJvYcCVMZIvEfISBA/pM8Z9kOUMPHcWuugziPxvzgpUpQ8xQwz+Y0/eTljeVr7To3jVk+EkfCGO4oSjWo0kH@nongnu.org
X-Gm-Message-State: AOJu0Yw3mqG7ZxGH4pWE2WgsyKvnihSYTrCRGtVKi8LJpWvhjRhFltRE
 syjZYEA8U+PPPZcC52c+sjFWp/D8UiS+SRh7rRmlJQZori3LwJweH/5qVA==
X-Google-Smtp-Source: AGHT+IHsgaMAY7vSWtHDEY69fl6DIDRDyFARZGHhJSUs6+iDEydrOPhJRASlVxOX/dJeSQnu3KjKGg==
X-Received: by 2002:a05:600c:6c11:b0:42f:7c9e:1f96 with SMTP id
 5b1f17b1804b1-42f85b64a22mr51595905e9.1.1728157640104; 
 Sat, 05 Oct 2024 12:47:20 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:19 -0700 (PDT)
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
Subject: [PATCH v2 19/23] hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:45:59 +0200
Message-ID: <20241005194603.23139-20-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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
2.46.2


