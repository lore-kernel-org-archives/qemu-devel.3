Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0DFC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5K-0006Om-GI; Thu, 26 Jun 2025 18:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv54-0006LJ-9N
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv51-0000tI-E3
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2363e973db1so23201615ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976903; x=1751581703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
 b=NBO7dvO9m2N8SgCq6oCaig59nFcTbCQnIGgb2WI1sSN7zP0drYklMQ1AYUWtX0/1VD
 vYugRAg7feQRr+sGwxL4oYx3wKYkmjFCyRa94gXkSgi9lQlxIIZ7e6xke+mschaROGSl
 NrANpHCcLiCQJYABWe0PWiFPTlDj8pVv+vVZ0L3XSjBpSrhemFFVUlcWsdSAvtpztVoW
 ALDiWCZDvoEPNbejoulo8zZz9B1zvPNWn+JBKN8hvsWjNBj5yEaCQ0vLI09Rg4cs4JLF
 7Wpq/7k8sMLGptqYxp9/2y4f4Fr4M/aZycxHc6dQb7KvwagJQFL+HHyQZZCbt+1050o1
 zj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976903; x=1751581703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
 b=htBNCAIv9lOFmxHnVP2N9Xb2OjnhFxAb2cXhXNVPdj3+sy9FxQT0XI15vOmp/XS6Kl
 98mTjCVJUDzbpLTKrzDDriOpWqMYX++OQ02inxXOiobqe+ONyS7GeZrvot+B3+dv71vC
 NQnDicyu8hpRY/u1Y4zwwP1imrUMs5wRem90GYRSAoDJ/Kw6VK2Xjcy+ledr6EFViVGb
 2nMo6iwxyRKuaH2bca90njlwqzh0yP+WTzeK/hw0ifAox979n9DZd9dczS1knKmirWl7
 kmSSXVaGkbZ2Vxu2huys8IWe5cp4yjaxXnX5smaZeMSeKJ1t/qSc6DMCr1fBcv4oSCn3
 yyIg==
X-Gm-Message-State: AOJu0YxKhk828wZk0G9INBAzaY064dctK5JLNwvIhAW+8y2h8TNsmgGq
 bnnUDoiVoW0W3KDgLh+tEUR5spU5m4g4LfTM/InfR0OkhtDEHdg1gg3uM6lC+Q==
X-Gm-Gg: ASbGncub5bp7/06VX1J1vi0JZhLmRfvNuNz8jM5tBqxGsHcsdOcdWHUH5u3SlmVQpw+
 NE68UyUMNQkLDYikK++LRvyNPrLpQI2edUtrLU9yBW1XkEjh8MCdiSQuozWw0Eo6gLLt9UqtTug
 /DwRyfo1NkB3ixaZ59IxXiJP0alUXnJqemdiIuq4oPAB9sDTmQn3HSvzamCS/lfJ4oW7W2jyq1X
 OwV8mufafl0ABjKLGX54NP134LPxeM+/xYOLMQJPtNg3T9RXQFSE8OgBJE3V4arYAxgYoOKbRDA
 NWLnY2JC1PEiLSdrqmEmnIFZIDDUYxkBfC2eRmq4rxlDW4Re2pKQ6Xvua+JDAhy75aFSztJ9rPL
 JYS5svmg=
X-Google-Smtp-Source: AGHT+IH3JDlsQy+VzeCP6XavKPgibPAly4QUpzv/KCtsAmiIQzL44pbquOf0jrrKRll8b2m1y7/L2g==
X-Received: by 2002:a17:903:807:b0:234:1e11:95a3 with SMTP id
 d9443c01a7336-2390a4a8832mr60381845ad.13.1750976903096; 
 Thu, 26 Jun 2025 15:28:23 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:22 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 04/10] cxl_events.h: Move definition for
 dynamic_capacity_uuid and enum for DC event types
Date: Thu, 26 Jun 2025 22:23:27 +0000
Message-ID: <20250626222743.1766404-5-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Move definition/enum to cxl_events.h for shared use in next patch

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0fccd22800..cdd60079c4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1876,21 +1876,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
-- 
2.47.2


