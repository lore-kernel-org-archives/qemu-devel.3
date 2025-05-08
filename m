Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B49C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyN-0005yL-PX; Wed, 07 May 2025 20:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyK-0005xe-Bp
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyI-0006uo-8S
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so496689b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663521; x=1747268321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjR+4cbwIjuGdu5a9Wc1yALEfQJBd/CuIo518XL/+fg=;
 b=BlGfJFgct3qOaH2iTzV9hc5xD3h59TX7KPXnuOm9pP30iyG9BkzhOx6rttSUWdYj8M
 H5SzKv0QVJqWb32l7GscU0vGcgTMtUhX++RwRFsKtsUKSVBTTncm0DEY49qPvFDNU9Fe
 SBqd9AEG7/c3vxM7HoRG+ReW8ZelALST/A+k0Kni7KnZNBCHw/jcYW2VNqVfRhSPuthG
 HeJx9BHmbsPaHF3iWfKllgvntWd5Tl6S87GWkRe2mIb9aUEhatmhm6PKnVHlGW/wLpsz
 yDVq2uFV1PxA+f2PMxAZEzCRY6SYRCGqQA3Tas8467XH2LfhAu9bZi+k5Fk4uqosQQ64
 6wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663521; x=1747268321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjR+4cbwIjuGdu5a9Wc1yALEfQJBd/CuIo518XL/+fg=;
 b=oImwbgsSo/SEuDsuj0dDTfq3yZMP3F7ThxCXbTQ/uVMa+0JjA+P+UkNj3rjOL8tq3I
 NAsZHXFTemxZcph4FY54RphwoYE7Wzi3wb6kpfk4md1yFnLQCZ4Ye07odqu3dGfEyscQ
 jGZhFJJsLPoqNFn8KK8c9f4nXKfxOvLdA6PldZoiLQxz1gJNWW4m2Y/3SY/kRshp0MTb
 36LQ9My9umV7JNnHWN/iYvldlDVtWLO8XuUM9YjUBUX3TxndhrNNFJ28u960nl/bYhQa
 9aKaHAJ3KG81gJMayf6zZZsFZnqq4dxkBooz+4cW7HBRU6HZlwe4UGZ31+uSa0ueuGYB
 DIkA==
X-Gm-Message-State: AOJu0Yw0GLr013WErx4CUZ6xrRwUQn2S9ErbIEkJpI22DH0bWL3g92yE
 NtIi9c/PWCQ7bB2kpM645/DRGX1qwOrtb9k9ACp065PmKJDrDiNUI9JJBw==
X-Gm-Gg: ASbGncu8+WVajniczEWaXhj+Skl01M+o8FOK6KgWnij1hOXxwR/oK6VeRdVA/J8zOwk
 IreIBFBJTk/NOXa0BQauzPpvbfeRYSIdcNxmR8A9X2FnJyp/4jCcxHRUVzkJI7FFwaZ3a/NRPcg
 BA0dhR5/r9ed/5xQN66INi3V3Zkzqe1zyHPE5ElQFfPhJWJOY81i1VT9FRrst4kcLLWTKPDpcGN
 Xi63CGkqpS57ZI/UdS2G7mFtfUyolSMRfipSW1SuY3vEmyCkQLbsU3BCgJQZJpQG69cl7syP/FT
 IELXd5SGYU7I/d+ASIzxZEnleFr906u2+isb/F8FYd0dk0tUxFGFa+OEatZwbA==
X-Google-Smtp-Source: AGHT+IFVW9/qE144753BxmrJrZ3KQKrB5Cd+qE4MZUI/qK0vbO/pbkjxTE2f8Un30OPgdezgLBxmoA==
X-Received: by 2002:a05:6a00:3286:b0:736:5c8e:baaa with SMTP id
 d2e1a72fcca58-7409cee610cmr7425910b3a.2.1746663520848; 
 Wed, 07 May 2025 17:18:40 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:40 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 05/10] cxl_events.h: Move definition for
 dynamic_capacity_uuid and enum for DC event types
Date: Thu,  8 May 2025 00:01:01 +0000
Message-ID: <20250508001754.122180-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 05d4c861f1..6ad48f55ce 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1982,21 +1982,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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


