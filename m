Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6678AC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASK-000893-6C; Sun, 22 Feb 2026 09:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS3-00080c-Gi
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS1-0006gh-Kv
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQ8QEe6bM9LPkh94Ea4ZBPRh4my0yC9DE08GC55pqY4=;
 b=B1ZU8hmPZs8xqiMZl84ckmTRhWotFl2vAuOIkuv27L1DLSd9wJ/I+D8b+sQ7+K4+RolcU2
 jBoss7tnNfgPqip1eCHC1RfKDPLERJuhVajCt4bXh/vi7my9ifm9gvqpCjIuiPqwAOf6h7
 LgcTtlXT4RQ3eVSaIMHo3z8aebUGevA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-1SbtHP2NMl6DyKySGF3afQ-1; Sun, 22 Feb 2026 09:28:45 -0500
X-MC-Unique: 1SbtHP2NMl6DyKySGF3afQ-1
X-Mimecast-MFC-AGG-ID: 1SbtHP2NMl6DyKySGF3afQ_1771770525
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48071615686so35594675e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770524; x=1772375324; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AQ8QEe6bM9LPkh94Ea4ZBPRh4my0yC9DE08GC55pqY4=;
 b=pOKs3GOgFYhv1N0nHcCwAuQstcuvog+olFkQYTw6w9zyKSFgqyQY8XmpMmYiBtw6hm
 yVKdBd9ipklT5a6KSwXSgJRUJ66WRu8oD5eVN/RcCPnT3j12UcQ8aZvOW7e8f2aIw8TZ
 TFjg74WmNfKxrnivXWUCrEVvjpUwp2SBDXvXtRIva/lp7iEQkw2r9oF6eIe5O+clCH4r
 RkQLMps4u1r9ULhVI0kTAm+kxlMMF9aQ4uvCFX29dW/ikgf98y55jYQnon2VdBtEJHLJ
 p6IlONzw6xuee/3Rfh9Jn9xRxFwbM743y4TOnzVq5W/Q6k3oB3v84SAeZIwk+j3SWNBR
 fzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770524; x=1772375324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQ8QEe6bM9LPkh94Ea4ZBPRh4my0yC9DE08GC55pqY4=;
 b=g4ruhyckGgNlxpZveF8psZmMxktwqqmPMpExVH3UzJnTo1RFX7TZOtIJjv7oQrjfac
 Y9p7IL0ekek0PILxlmRLOJfSHaqov4gYRPrDV4k2j0i9d1zZMlj1UHsFFOH7Rbaq+oqt
 VkHzM6w6CgPEgGb6xsE/Kh6oOf7tCUXsycmyEsppQ2ymDhfrNbLuZqwh9fee1pRoSC/W
 YLsInjlGqOPRFrxkadS3NwJ/fcGfJjQbLRUpQhb5rWyTYUlWlyTrruNE8e8BojrkN60B
 6L6Ucgm4Z5xo1VFcnRpqR7RQqCwUPnMGT2cCEuuN+TsC7jm2iAD5KLqtg5Tej/EXq1oc
 XsJQ==
X-Gm-Message-State: AOJu0YzGKCBpf9b+3IDKHxtYfhG7OYKpNnCK6ShT6snvP+lzaX60/6D9
 QsT9PeNhKVrQTo411EnqGCJP35n2qOw7knBh5FJyHyiwo2mqQ6dhv8Y/5YJF2vEZyd3Lf0eVhmS
 5Q5zHngV4/LOY8lL0HYmwkh/eP634Uz1R8U7/UZRoTBdVNFaTq17JoPNGuMqMXujf9AGAkP74QG
 W3J19Dj3A1i20rs6078AZT6ZUsGAXgiY7g9w==
X-Gm-Gg: AZuq6aJnHMfy9y+P2w01GIE7WTIS78E7dK5/rTZiY4ze2y+zc6t5tTfxvtrW+X4GAgp
 jRxdG3GNKxCLG/2RU6v+8YfbSqZOR048AHaWP4hP+/h8VwwyIovWd5/WGIDb1IBBLr2RjTL7ur5
 lL1FV1rny6UXf5vbxb4lS3i+yd9IRZBR3JDfyuTAf5VThnNlGG1D0QKOu2l+fb4YQMX65hI8bmj
 xv8z2h7b3/9e50iQcbXp9mp5BiPoY2fkePYBnITh9N6lXBVAgKbCX66KtobiVb4bm+u1KXRoWMI
 oF/6i0z0qmIEGjrzF1zSVzmzw1K2Ua1aGONszAuXHxHho+QDUNQ4+3fj6cXuIh1QdfJOjAXpQuK
 dmKqBbRwiqZqV80quIqLGZtsSJJ8D6Wq4RW1mpPq1RpBsVQ==
X-Received: by 2002:a05:600c:3f05:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-483a95aae85mr97090245e9.7.1771770524171; 
 Sun, 22 Feb 2026 06:28:44 -0800 (PST)
X-Received: by 2002:a05:600c:3f05:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-483a95aae85mr97089895e9.7.1771770523615; 
 Sun, 22 Feb 2026 06:28:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bfa1bdsm11499833f8f.3.2026.02.22.06.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:43 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 11/33] hw/cxl/events: Updates for rev3.2 memory module event
 record
Message-ID: <1fc57dd250944805a5d5f498ebf0775234be3851.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-59, memory module
event record has updated with following new fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Add updates for the above spec changes in the CXL memory module
event reporting and QMP command to inject memory module event.

Updated all references for this command to the CXL r3.2
specification.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260205112350.60681-6-Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  4 ++++
 include/hw/cxl/cxl_events.h |  7 +++++--
 qapi/cxl.json               | 30 ++++++++++++++++++++----------
 4 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index be99d20faf..acb75f8f01 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1937,6 +1937,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 }
 
+#define CXL_MMER_VALID_COMPONENT                        BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT              BIT(1)
+
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t flags, bool has_maint_op_class,
                                         uint8_t maint_op_class,
@@ -1953,11 +1956,16 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
     CXLEventMemoryModule module;
     CXLEventRecordHdr *hdr = &module.hdr;
+    uint16_t valid_flags = 0;
     CXLDeviceState *cxlds;
     CXLType3Dev *ct3d;
     uint8_t enc_log;
@@ -2000,6 +2008,18 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     stl_le_p(&module.corrected_persistent_error_count,
              corrected_persist_error_count);
 
+    if (component_id) {
+        strncpy((char *)module.component_id, component_id,
+                sizeof(module.component_id) - 1);
+        valid_flags |= CXL_MMER_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
+        }
+    }
+    module.sub_type = sub_type;
+
+    stw_le_p(&module.validity_flags, valid_flags);
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 231dda263f..98292a931c 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -78,6 +78,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index a3c5f2ec20..4a7836ad72 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -166,7 +166,7 @@ typedef struct CXLEventDram {
 
 /*
  * Memory Module Event Record
- * CXL r3.1 Section 8.2.9.2.1.3: Table 8-47
+ * CXL r3.2 Section 8.2.10.2.1.3: Table 8-59
  * All fields little endian.
  */
 typedef struct CXLEventMemoryModule {
@@ -180,7 +180,10 @@ typedef struct CXLEventMemoryModule {
     uint32_t dirty_shutdown_count;
     uint32_t corrected_volatile_error_count;
     uint32_t corrected_persistent_error_count;
-    uint8_t reserved[0x3d];
+    uint16_t validity_flags;
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_type;
+    uint8_t reserved[0x2a];
 } QEMU_PACKED CXLEventMemoryModule;
 
 /*
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 1dc8b08ca3..81d6198ba0 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -214,20 +214,20 @@
 ##
 # @CXLMemModuleEvent:
 #
-# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
+# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
-# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
+# @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
 #
-# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Health Status for bit
+# @health-status: Overall health summary bitmap.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Health Status for bit
 #     definitions.
 #
-# @media-status: Overall media health summary.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Media Status for bit
+# @media-status: Overall media health summary.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Media Status for bit
 #     definitions.
 #
-# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
+# @additional-status: See CXL r3.2 Table 8-148 Get Health Info Output
 #     Payload, Additional Status for subfield definitions.
 #
 # @life-used: Percentage (0-100) of factory expected life span.
@@ -243,6 +243,14 @@
 # @corrected-persistent-error-count: Total number of correctable
 #     errors in persistent memory
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @sub-type: Device event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLMemModuleEvent',
@@ -252,14 +260,16 @@
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
             'corrected-volatile-error-count': 'uint32',
-            'corrected-persistent-error-count': 'uint32'
+            'corrected-persistent-error-count': 'uint32',
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            'sub-type':'uint8'
             }}
 
 ##
 # @cxl-inject-memory-module-event:
 #
-# Inject an event record for a Memory Module Event (CXL r3.0
-# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
+# Inject an event record for a Memory Module Event (CXL r3.2
+# 8.2.10.2.1.3).  This event includes a copy of the Device Health info
 # at the time of the event.
 #
 # Since: 8.1
-- 
MST


