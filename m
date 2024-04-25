Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FD0C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwtw-0001c3-FK; Thu, 25 Apr 2024 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtB-00009T-2S
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwss-0000DG-7b
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41adf3580dbso5031725e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043000; x=1714647800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvunkSj/8Waxads7PhZ8ZQlWRsJ6KI6vMAUvxRYx65M=;
 b=gL9a3tea7yE6jcdX6zkmxwDmR6RkxmQKGR0W8cbgks1HpM55Kl2q+Fh5rDjzchqYhY
 ibf6gTSzByxXyHNx3UMizX1IL+oJfoPpgfewwNEdFKYZRg6DDQgrJ/yQlBA/QOFsOT30
 mPK+d1+VuHN3r3++vGimHOahyjN386AlBBbee1h9kn3SpQcpFESm/DIQ2CK8kNho5nJp
 24zHp3k6m2azSmBCFVEiiXKCNsLNVXUwhFGki3EhncgbEJir3NyRHAhCd1U1V8o6lkEQ
 70rEdMd1hXHJQieDioZs0cKc08yQlROsxMFvwpfcpDfkKuMuvWWevUqvtOohZZGXyXHp
 nHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043000; x=1714647800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvunkSj/8Waxads7PhZ8ZQlWRsJ6KI6vMAUvxRYx65M=;
 b=QQdsw8uMFram+rWtSsd2xHY5tLXOhcqonDaDahwOrbol0Fu/T443cS02g/JjsiSRp5
 QuhS7O1Oge2Qz4lCt522wPKJyfjH/aYqQFT9CXRICqdWt8DLxSkuYrLVzWeQQcz0iF/L
 oVIxNqhR09y3sNl+5YfJ/Vk76//YGz+M1sYXOoiJ1KH8fugmWdKdz6w9lmEDwjMaZJun
 awx7dIeVVV5LfqW4PqrlkyxYzhN783ujna2MswwdJECS59yl2Ml0mXdF5T6C1kuxCQuh
 3bNDP00rk9ioyZxBHbeN+sgPh9hG9ta4CqxxiMi9/QyTNPv0hCM4i+dd9RwcL1Sqbxwm
 KgUw==
X-Gm-Message-State: AOJu0YwAulEvWGbCiWP690K3rXoUrr8+FB2n+U2Ze48OcsWoZKTFaL3Y
 IcPgQvJ43tcs1f7cxtDAC6ZfNgnvbb+KFDqdwo9qirDyufiMNnd2d6QQ1AWyOA8NdESGJ2eLS41
 J
X-Google-Smtp-Source: AGHT+IEmrIxHIZTR3N3C87Loh/LBNBpgekND21HRCbgm42Ea4SiO726knsE1orKhBPiOc+Dh2IhLkQ==
X-Received: by 2002:a05:600c:3554:b0:415:ff48:59fc with SMTP id
 i20-20020a05600c355400b00415ff4859fcmr2033033wmq.8.1714043000386; 
 Thu, 25 Apr 2024 04:03:20 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 k41-20020a05600c1ca900b00417e8be070csm27334682wms.9.2024.04.25.04.03.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:03:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 14/22] hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return boolean
Date: Thu, 25 Apr 2024 13:01:47 +0200
Message-ID: <20240425110157.20328-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

With returned boolean, there's no need to dereference @errp to check
failure case.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <20240418100433.1085447-4-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cxl/cxl_component.h | 2 +-
 hw/cxl/cxl-cdat.c              | 6 +++---
 hw/mem/cxl_type3.c             | 3 +--
 hw/pci-bridge/cxl_upstream.c   | 3 +--
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 5012fab6f7..945ee6ffd0 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -273,7 +273,7 @@ hwaddr cxl_decode_ig(int ig);
 CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
 bool cxl_get_hb_passthrough(PCIHostState *hb);
 
-void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
+bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
 void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
 void cxl_doe_cdat_update(CXLComponentState *cxl_cstate, Error **errp);
 
diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index e7bc1380bf..959a55518e 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -189,14 +189,14 @@ static bool ct3_load_cdat(CDATObject *cdat, Error **errp)
     return true;
 }
 
-void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
+bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
 {
     CDATObject *cdat = &cxl_cstate->cdat;
 
     if (cdat->filename) {
-        ct3_load_cdat(cdat, errp);
+        return ct3_load_cdat(cdat, errp);
     } else {
-        ct3_build_cdat(cdat, errp);
+        return ct3_build_cdat(cdat, errp);
     }
 }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b0a7e9f11b..3e42490b6c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -705,8 +705,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
-    cxl_doe_cdat_init(cxl_cstate, errp);
-    if (*errp) {
+    if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
         goto err_free_special_ops;
     }
 
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 783fa6adac..e51221a5f3 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -338,8 +338,7 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     cxl_cstate->cdat.build_cdat_table = build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = free_default_cdat_table;
     cxl_cstate->cdat.private = d;
-    cxl_doe_cdat_init(cxl_cstate, errp);
-    if (*errp) {
+    if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
         goto err_cap;
     }
 
-- 
2.41.0


