Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0915ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbqN-0003T0-V9; Wed, 20 May 2026 03:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqL-0003SU-Fo
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:59:53 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqJ-00043j-0j
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:59:53 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso2049320a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779263989; x=1779868789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3WZnE0eDbhnSVeNXWk5c+JKL5ligHJETZ0o7+l76M8=;
 b=PN9lN0DovbdYsA301WHvHJHJ5u+RzAswH3lCPmZAqB3kKLQLEsEKvsY4qw5xhUCm33
 lYJo1YicpfRX0Y4q3nXSES1Jybu9BROKaS3XvlOU/NAXLJi/hXbtMHCwhxz5s1jDiV5J
 qWVEgTq19FtoqtoyFPY+LSmzr2wqgtu/lMFEwN4GHlai0NuL3EmD5uByczeJ35fKVrru
 GiC6RL0Z5JF8dq+dntAMZqqppt4+cagTLYT//0v4iF0DX4Tp8yEw487NgEtImZ2JS0+W
 xZD43blf7d7lvaEPVIuF2jdGu8jt7307BqNFKXLi8KoHUyv7seoWMhBxHIRkXgsfGYy4
 OH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263989; x=1779868789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n3WZnE0eDbhnSVeNXWk5c+JKL5ligHJETZ0o7+l76M8=;
 b=XHlt6KqjqPzUFdsgPwe5Z8TlWLrFKs3Ynox54nWuyfgcrS3rAmN3ZRZJOmUqZMvw/K
 AGdbs+G3WvNbyEWMF8t9KydidSKUsDm5vElAw6wJgUuX8TukOMkrOT3em2jYRXD+s4dz
 ZoTGZIWIVgCVEzZtL3fbtICNdOfh4m+E23t2LNh9/VNFdCwH7wUDgIDPLwmt0NnTt0UJ
 sKvCo/FOwF/yrwpQGGAJHjBpaylC093rvkq/bIQkq2j+oI3gS2dQe/CoA8SL6drTAk+5
 gBxlGngp3W2ogF8X8bbrUGsK4PasUv00zl1WcUT2vxEiqQ80J6Ah5rM+FWbeuCPuEYxd
 9Y/Q==
X-Gm-Message-State: AOJu0Yy+PI1fx51gmwHbNG9zR3bijuUfHpi/t6I/WiMPQdjXUpcjyNB/
 kuCsgUGqGVUxPO9mW+CPQBYdb634YkY/rDsEHuTwIb4ZvZSX3wOrTzzno7q+5A==
X-Gm-Gg: Acq92OE3dkTlzWvrD7yY9dEpMmkE4eVEe2+wo19yp7BgHekY7ecT/lR0u9rKClP785a
 uNnipTl/MidV9j/r083D2JLMh0Cw196u9JTE11SaPeXniSdeHgnJr32Xw4hzYpAIDDARX3XUstF
 NFxhlkciYMLXWeVomiQgYddYHcG8x4oc8JHrDW/dVxJlfOnU4QujyWEdzIj6ZvFVHKCbMSHGQEa
 Z42OzC0Sl+8o6fVguZGbF9nY7nBUTwGJ2dlEPF63lwPMDzdY76NSzTk/VkTAfK6jAMjLsJpL2Uy
 LcE0Oitzq69HUxoYztSUgCHKQMRLvlXaxRO68hMWDJp0zUap5X0EnCAhY/6b9+hdjYcBD3dMV7u
 5021I8fWroLRwryBnlyKGh7Pt/HtpRdl0EF/35G5D1VNKSKpRHbDYReiAYgJVmabWa5+mNPUhdm
 XRoNxmXA8KjrOyA0kucwR2DDOSmKe2xRZRdbiJh3s=
X-Received: by 2002:a17:902:c403:b0:2bd:8dbd:17e6 with SMTP id
 d9443c01a7336-2bd8dbd19c6mr229704585ad.35.1779263989250; 
 Wed, 20 May 2026 00:59:49 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05ffbesm216608435ad.27.2026.05.20.00.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:59:48 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com,
 Jaemyung Lee <ldc.jml@gmail.com>
Subject: [PULL 1/5] hw/ufs: Apply UFS 4.1 Specification
Date: Wed, 20 May 2026 16:59:27 +0900
Message-ID: <f4958cb6e9187c182d75d5524594d23b97e3d13c.1779263628.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779263628.git.jeuk20.kim@samsung.com>
References: <cover.1779263628.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x529.google.com
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

From: Jaemyung Lee <ldc.jml@gmail.com>

Apply current UFS 4.1 Specification to QEMU-UFS.

QEMU-UFS device emulates operation via UFS 4.0 Specification,
but current latest Spec. version is UFS 4.1. So extent internal
DESCRIPTOR/FLAG/ATTRIBUTE declaration to follow UFS 4.1 Spec.

It does not implement any actual functionallity, but only adds
minimum supportability for further implementation.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c        | 70 +++++++++++++++++++++++++++++++++++++++++++--
 include/block/ufs.h | 59 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 123 insertions(+), 6 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 6548f0f637..a3f2a3be18 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: https://www.jedec.org/, 4.0
+ * Reference Specs: https://www.jedec.org/, 4.1
  *
  * Usage
  * -----
@@ -29,8 +29,8 @@
 #include "trace.h"
 #include "ufs.h"
 
-/* The QEMU-UFS device follows spec version 4.0 */
-#define UFS_SPEC_VER 0x0400
+/* The QEMU-UFS device follows spec version 4.1 */
+#define UFS_SPEC_VER 0x0410
 #define UFS_MAX_NUTRS 32
 #define UFS_MAX_NUTMRS 8
 #define UFS_MCQ_QCFGPTR 2
@@ -1068,6 +1068,7 @@ static const int flag_permission[UFS_QUERY_FLAG_IDN_COUNT] = {
     [UFS_QUERY_FLAG_IDN_WB_EN] = UFS_QUERY_FLAG_READ,
     [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN] = UFS_QUERY_FLAG_READ,
     [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_UNPIN_EN] = UFS_QUERY_FLAG_READ,
 };
 
 static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
@@ -1125,10 +1126,32 @@ static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
     [UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_EXT_IID_EN] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_HOST_HINT_CACHE_SIZE] = UFS_QUERY_ATTR_READ,
     /* refresh operation is not supported */
     [UFS_QUERY_ATTR_IDN_REFRESH_STATUS] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_REFRESH_FREQ] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_REFRESH_UNIT] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_TIMESTAMP] = UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_DEVICE_LEVEL_EXCEPTION_ID] = UFS_QUERY_ATTR_READ,
+    /* host initiated defragmentation is not supported */
+    [UFS_QUERY_ATTR_IDN_DEFRAG_OP] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_HID_SIZE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_HID_PROG_RATIO] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_HID_STATE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_CURR_FIFO_WB_PARTIAL_FLUSH_MODE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_CURR_ALLOC_UNITS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_AVAIL_PERCENT] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_PINNED_WB_CUMM_WRITTEN_SIZE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS] =
+        UFS_QUERY_ATTR_READ,
 };
 
 static inline QueryRespCode ufs_attr_check_idn_valid(uint8_t idn, int op)
@@ -1262,12 +1285,50 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
         return u->attributes.wb_buffer_life_time_est;
     case UFS_QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE:
         return be32_to_cpu(u->attributes.current_wb_buffer_size);
+    case UFS_QUERY_ATTR_IDN_EXT_IID_EN:
+        return u->attributes.ext_iid_en;
+    case UFS_QUERY_ATTR_IDN_HOST_HINT_CACHE_SIZE:
+        return be16_to_cpu(u->attributes.host_hint_cache_size);
     case UFS_QUERY_ATTR_IDN_REFRESH_STATUS:
         return u->attributes.refresh_status;
     case UFS_QUERY_ATTR_IDN_REFRESH_FREQ:
         return u->attributes.refresh_freq;
     case UFS_QUERY_ATTR_IDN_REFRESH_UNIT:
         return u->attributes.refresh_unit;
+    case UFS_QUERY_ATTR_IDN_DEVICE_LEVEL_EXCEPTION_ID:
+        return be64_to_cpu(u->attributes.device_level_exception_id);
+    case UFS_QUERY_ATTR_IDN_DEFRAG_OP:
+        return u->attributes.defrag_op;
+    case UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE:
+        return be32_to_cpu(u->attributes.hid_avail_size);
+    case UFS_QUERY_ATTR_IDN_HID_SIZE:
+        return be32_to_cpu(u->attributes.hid_size);
+    case UFS_QUERY_ATTR_IDN_HID_PROG_RATIO:
+        return u->attributes.hid_prog_ratio;
+    case UFS_QUERY_ATTR_IDN_HID_STATE:
+        return u->attributes.hid_state;
+    case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT:
+        return u->attributes.wb_buffer_resize_hint;
+    case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN:
+        return u->attributes.wb_buffer_resize_en;
+    case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_STATUS:
+        return u->attributes.wb_buffer_resize_status;
+    case UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE:
+        return u->attributes.wb_buffer_partial_flush_mode;
+    case UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE:
+        return be32_to_cpu(u->attributes.max_fifo_wb_partial_flush_mode);
+    case UFS_QUERY_ATTR_IDN_CURR_FIFO_WB_PARTIAL_FLUSH_MODE:
+        return be32_to_cpu(u->attributes.curr_fifo_wb_partial_flush_mode);
+    case UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_CURR_ALLOC_UNITS:
+        return be32_to_cpu(u->attributes.pinned_wb_buffer_curr_alloc_units);
+    case UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_AVAIL_PERCENT:
+        return u->attributes.pinned_wb_buffer_avail_percent;
+    case UFS_QUERY_ATTR_IDN_PINNED_WB_CUMM_WRITTEN_SIZE:
+        return be32_to_cpu(u->attributes.pinned_wb_cumm_written_size);
+    case UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS:
+        return be32_to_cpu(u->attributes.pinned_wb_num_alloc_units);
+    case UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS:
+        return be32_to_cpu(u->attributes.non_pinned_wb_min_num_alloc_units);
     }
     return 0;
 }
@@ -1305,6 +1366,9 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
     case UFS_QUERY_ATTR_IDN_PSA_DATA_SIZE:
         u->attributes.psa_data_size = cpu_to_be32(value);
         break;
+    case UFS_QUERY_ATTR_IDN_TIMESTAMP:
+        u->attributes.timestamp = cpu_to_be64(value);
+        break;
     }
     return UFS_QUERY_RESULT_SUCCESS;
 }
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 04cb24324d..4dacfb776f 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -294,7 +294,8 @@ typedef struct QEMU_PACKED DeviceDescriptor {
     uint32_t psa_max_data_size;
     uint8_t psa_state_timeout;
     uint8_t product_revision_level;
-    uint8_t reserved[36];
+    uint8_t reserved[34];
+    uint16_t extended_wb_support;
     uint32_t extended_ufs_features_support;
     uint8_t write_booster_buffer_preserve_user_space_en;
     uint8_t write_booster_buffer_type;
@@ -342,6 +343,8 @@ typedef struct QEMU_PACKED GeometryDescriptor {
     uint8_t write_booster_buffer_cap_adj_fac;
     uint8_t supported_write_booster_buffer_user_space_reduction_types;
     uint8_t supported_write_booster_buffer_types;
+    uint8_t reserved3[17];
+    uint8_t cap_adj_fac_representation;
 } GeometryDescriptor;
 
 #define UFS_GEOMETRY_CAPACITY_SHIFT 9
@@ -437,6 +440,8 @@ typedef struct QEMU_PACKED Flags {
     uint8_t wb_buffer_flush_en;
     uint8_t wb_buffer_flush_during_hibernate;
     uint8_t reserved4[2];
+    uint8_t unpin_en;
+    uint8_t reserved5[235];
 } Flags;
 
 typedef struct Attributes {
@@ -457,6 +462,8 @@ typedef struct Attributes {
     uint16_t exception_event_status;
     uint32_t seconds_passed;
     uint16_t context_conf;
+    uint8_t obsolete;
+    uint8_t reserved2[2];
     uint8_t device_ffu_status;
     uint8_t psa_state;
     uint32_t psa_data_size;
@@ -469,10 +476,34 @@ typedef struct Attributes {
     uint8_t available_wb_buffer_size;
     uint8_t wb_buffer_life_time_est;
     uint32_t current_wb_buffer_size;
+    uint8_t reserved3[10];
+    uint8_t ext_iid_en;
+    uint16_t host_hint_cache_size;
     uint8_t refresh_status;
     uint8_t refresh_freq;
     uint8_t refresh_unit;
     uint8_t refresh_method;
+    uint64_t timestamp;
+    uint8_t reserved4[3];
+    uint64_t device_level_exception_id;
+    uint8_t defrag_op;
+    uint32_t hid_avail_size;
+    uint32_t hid_size;
+    uint8_t hid_prog_ratio;
+    uint8_t hid_state;
+    uint8_t reserved5[2];
+    uint8_t wb_buffer_resize_hint;
+    uint8_t wb_buffer_resize_en;
+    uint8_t wb_buffer_resize_status;
+    uint8_t wb_buffer_partial_flush_mode;
+    uint32_t max_fifo_wb_partial_flush_mode;
+    uint32_t curr_fifo_wb_partial_flush_mode;
+    uint32_t pinned_wb_buffer_curr_alloc_units;
+    uint8_t pinned_wb_buffer_avail_percent;
+    uint32_t pinned_wb_cumm_written_size;
+    uint32_t pinned_wb_num_alloc_units;
+    uint32_t non_pinned_wb_min_num_alloc_units;
+    uint8_t reserved6[184];
 } Attributes;
 
 #define UFS_TRANSACTION_SPECIFIC_FIELD_SIZE 20
@@ -856,6 +887,7 @@ enum flag_idn {
     UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8 = 0x10,
     UFS_QUERY_FLAG_IDN_HPB_RESET = 0x11,
     UFS_QUERY_FLAG_IDN_HPB_EN = 0x12,
+    UFS_QUERY_FLAG_IDN_UNPIN_EN = 0x13,
     UFS_QUERY_FLAG_IDN_COUNT,
 };
 
@@ -893,9 +925,29 @@ enum attr_idn {
     UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE = 0x1D,
     UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST = 0x1E,
     UFS_QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE = 0x1F,
+    UFS_QUERY_ATTR_IDN_EXT_IID_EN = 0x2A,
+    UFS_QUERY_ATTR_IDN_HOST_HINT_CACHE_SIZE = 0x2B,
     UFS_QUERY_ATTR_IDN_REFRESH_STATUS = 0x2C,
     UFS_QUERY_ATTR_IDN_REFRESH_FREQ = 0x2D,
     UFS_QUERY_ATTR_IDN_REFRESH_UNIT = 0x2E,
+    UFS_QUERY_ATTR_IDN_TIMESTAMP = 0x30,
+    UFS_QUERY_ATTR_IDN_DEVICE_LEVEL_EXCEPTION_ID = 0x34,
+    UFS_QUERY_ATTR_IDN_DEFRAG_OP = 0x35,
+    UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE = 0x36,
+    UFS_QUERY_ATTR_IDN_HID_SIZE = 0x37,
+    UFS_QUERY_ATTR_IDN_HID_PROG_RATIO = 0x38,
+    UFS_QUERY_ATTR_IDN_HID_STATE = 0x39,
+    UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT = 0x3C,
+    UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN = 0x3D,
+    UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_STATUS = 0x3E,
+    UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE = 0x3F,
+    UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE = 0x40,
+    UFS_QUERY_ATTR_IDN_CURR_FIFO_WB_PARTIAL_FLUSH_MODE = 0x41,
+    UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_CURR_ALLOC_UNITS = 0x42,
+    UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_AVAIL_PERCENT = 0x43,
+    UFS_QUERY_ATTR_IDN_PINNED_WB_CUMM_WRITTEN_SIZE = 0x44,
+    UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS = 0x45,
+    UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS = 0x46,
     UFS_QUERY_ATTR_IDN_COUNT,
 };
 
@@ -1005,6 +1057,7 @@ enum device_desc_param {
     UFS_DEVICE_DESC_PARAM_PRDCT_REV = 0x2A,
     UFS_DEVICE_DESC_PARAM_HPB_VER = 0x40,
     UFS_DEVICE_DESC_PARAM_HPB_CONTROL = 0x42,
+    UFS_DEVICE_DESC_PARAM_EXT_WB_SUP = 0x4D,
     UFS_DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP = 0x4F,
     UFS_DEVICE_DESC_PARAM_WB_PRESRV_USRSPC_EN = 0x53,
     UFS_DEVICE_DESC_PARAM_WB_TYPE = 0x54,
@@ -1208,14 +1261,14 @@ static inline void _ufs_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(UfsMcqCqIntReg) != 12);
     QEMU_BUILD_BUG_ON(sizeof(UfsMcqOpReg) != 48);
     QEMU_BUILD_BUG_ON(sizeof(DeviceDescriptor) != 89);
-    QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 87);
+    QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 105);
     QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
     QEMU_BUILD_BUG_ON(sizeof(RpmbUnitDescriptor) != 35);
     QEMU_BUILD_BUG_ON(sizeof(PowerParametersDescriptor) != 98);
     QEMU_BUILD_BUG_ON(sizeof(InterconnectDescriptor) != 6);
     QEMU_BUILD_BUG_ON(sizeof(StringDescriptor) != 254);
     QEMU_BUILD_BUG_ON(sizeof(DeviceHealthDescriptor) != 45);
-    QEMU_BUILD_BUG_ON(sizeof(Flags) != 0x13);
+    QEMU_BUILD_BUG_ON(sizeof(Flags) != 0xFF);
     QEMU_BUILD_BUG_ON(sizeof(UtpUpiuHeader) != 12);
     QEMU_BUILD_BUG_ON(sizeof(UtpUpiuQuery) != 276);
     QEMU_BUILD_BUG_ON(sizeof(UtpUpiuCmd) != 20);
-- 
2.43.0


