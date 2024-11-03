Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8BDD11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al7-0006Xn-0z; Sun, 03 Nov 2024 08:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al5-0006Us-05; Sun, 03 Nov 2024 08:35:11 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al3-0001UZ-Au; Sun, 03 Nov 2024 08:35:10 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso469352266b.3; 
 Sun, 03 Nov 2024 05:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640907; x=1731245707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PcD3MeN7oG/a16flPfYAPmHTWpb8xl6Fwk4sXiy6/A=;
 b=eOqXZfAQMaBNU7CljxkHRXN/PR3RLnYHDoxZHOWiafsuoSW1GbIbRSWjpertEmlJ5u
 84bEvxiFycNfD8wb009bLGDqSBD+ksZ/7TzDzOiq8TpUErA8NikuNCWr9TVwoDmzZbVG
 lUTaOYFYfGMVNeWKCbPP6y7VWFflpEzLOFtRvKb7n2xhmczkkLi+1lY4CLsC+0R8CLmH
 LCHNonm7TF33JSDCEt8kmvoOt/Bae/gByUERnApsna2Y2ODA/LAoAVyXbwwH0ITFQrHa
 qC9LdQ3z5PHqzV594+l541jStxmjLSRoMwluO7Y3oWw094aKpJRvn27K9+mhKIcgg6RR
 RReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640907; x=1731245707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PcD3MeN7oG/a16flPfYAPmHTWpb8xl6Fwk4sXiy6/A=;
 b=Ov6HfdJfIt1ssVASNNJ7Hpy195kQ/sTsXgVJJhwkK6bu+64wW18UiEKMUYshVf59PL
 Eph4MBGVMywU/mVhHiCH9fuetOgsQzk/6J3ZZRPXyZeRZTMXgyitiK5BB3jN2O5V8HME
 IB90egyaZD+C+UXVWB0y+aWXi90OBuX8FAwca0MZun4ecm0PsLkIqc4oQqPRoeaenbBz
 GdKANTTT2USaGWvcStsxEf6/2dBxHQI05mWb5Vpzcxr01gRLVmbEyKIanLz0dnSBzeq4
 qZTlc1qbyPUZkQ+4phvJuW7MWggHNC8+PiWkpYM3TuODOwd6iCLPr8gt7Wj8hp8UK4BY
 e4Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvrx3pgOaf33mHNaR29naqvr4/2vefCDTiAcTdYbItgL/StiUxq8314EmQu6XRlS5qAzKTZDFIvUs=@nongnu.org,
 AJvYcCX6H2zSNsD3yLKw4FCYlDrJpmihRW65uylYNRsyNEGpDMO+zdqo0vC3Yxa3+hBxGcYC5g2hRtG1m72q@nongnu.org
X-Gm-Message-State: AOJu0YxfAYyepqcWjHrIZQD3CkQ+kw7QZoMD1JMI2oaVpta+WPQGoQLz
 RyoQq2XsBlqUVJTIul+o4FPUZWu5eEWIY8MsrsbNjvsjR3q2ko13CkzhyQ==
X-Google-Smtp-Source: AGHT+IHhEnFrAMNswLgLPjjmt4ftcJL5pxp/zi4FxJ6cPugFHYitTFt8hrglJ4Cvl3dRGVfM/ykosA==
X-Received: by 2002:a17:907:9405:b0:a9a:a3a:6c58 with SMTP id
 a640c23a62f3a-a9de5ed3e2emr2958689466b.22.1730640906800; 
 Sun, 03 Nov 2024 05:35:06 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:06 -0800 (PST)
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
Subject: [PATCH v4 18/26] hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:04 +0100
Message-ID: <20241103133412.73536-19-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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
 hw/ppc/mpc8544_guts.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index c02b34ccde..e3c51458e6 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/module.h"
 #include "qemu/log.h"
 #include "sysemu/runstate.h"
 #include "cpu.h"
@@ -141,16 +140,13 @@ static void mpc8544_guts_initfn(Object *obj)
     sysbus_init_mmio(d, &s->iomem);
 }
 
-static const TypeInfo mpc8544_guts_info = {
-    .name          = TYPE_MPC8544_GUTS,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GutsState),
-    .instance_init = mpc8544_guts_initfn,
+static const TypeInfo mpc8544_guts_types[] = {
+    {
+        .name          = TYPE_MPC8544_GUTS,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GutsState),
+        .instance_init = mpc8544_guts_initfn,
+    },
 };
 
-static void mpc8544_guts_register_types(void)
-{
-    type_register_static(&mpc8544_guts_info);
-}
-
-type_init(mpc8544_guts_register_types)
+DEFINE_TYPES(mpc8544_guts_types)
-- 
2.47.0


