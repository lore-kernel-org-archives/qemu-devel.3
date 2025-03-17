Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA8FC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2xU-0006jD-1n; Mon, 17 Mar 2025 01:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xS-0006ig-19; Mon, 17 Mar 2025 01:24:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xQ-0007op-2T; Mon, 17 Mar 2025 01:24:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2239c066347so77731905ad.2; 
 Sun, 16 Mar 2025 22:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742189050; x=1742793850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHPO8QJN6uV1YuZzM8KiBcANdL4KZSwmj3dkmnjbsok=;
 b=X+E/B1FOCDIqh+WF/yB6QRwMvWOt/+VTw33w0hnlkWbsuCAsEYn+oimUyTlcUU7Vwx
 0DSOmLFUO4DmS4o6OlpGlIa7XJSVghsAX5U0KXq6HMsCRr6ypJZoyqmvFI+TsArFyTyH
 GYAAk+cYtOsb25+w07xlJaLUKNiM3CqI2v21jPmU0SN9IkdYeUCFK4zI3sgn5nxR3NoT
 1m1JwfyIoQXQp4poh4/iOFWcU+cxxuBhrC1V9+w+KP2HrG4hBImoAHzKthFQa8RXGRHb
 ywvAVIw5yfRB7e2a/BPRPNviITAWL363UPAprhO4Q94PNqHiRP/KW5djBDIAxVhDyQrz
 HyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742189050; x=1742793850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHPO8QJN6uV1YuZzM8KiBcANdL4KZSwmj3dkmnjbsok=;
 b=lSDyOImRR7r5jtrX+h0EWHi3RjDCUOvVp7f4dB54z8In8slE2vJBZebHJY0yeTjEA3
 6P8CMxpBUekPP/c4wNSvSwz828mq+uATs2AEG1pIUogto2oKCVPpEMaLVkVtoCtlXgQz
 L3LrreOPT2ZnVI+3enq0eLckAS8ezh7meetcKUxQaGgtAGQkUCmoKMJjED+7KcRQR77o
 hW+kxRPP0cB1aKKPxh7Zn5IWPQZqukjWEPUlf1+074aB8hNAe3Li4ewTu+SIfTNYwkuI
 N7G6JRMvBFBK+NhWIiCvTaXpKuXCR/secQFwnVE4PE42eDA0el9DGIsWEvNSZVPUCqwr
 f4Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsdyvpc0FoAr1CjBU/lAhmZBwRkrORDsUoJf0ItqqAxtProouzXwYA2PTt/cjIJwPtc/6auYL/gA==@nongnu.org
X-Gm-Message-State: AOJu0Yyb7D9GgIHPCW6QZ8L9/ujQjvNaW7RalA+qmPRshhtsbZYFJ6TB
 34ZNyMOJsUnbd2JqahCpUuWdIxw2uYCzF1O35TiU5uRYrhUBbB1REhxkwg==
X-Gm-Gg: ASbGncuSHCElxCtEdcMfwwwZWlN1IVB6QjcUzbXXDAYjJG5kMXDlJg5m9AZjTy4nWR+
 CmBtTSd2za7MFu8/rmvSFRZIuCGOIzxbZHbVB5Kkv49MzDtR0VIGem23Ac16UUFt+yQKjEmvjRL
 kX7VGxDcFjQ/bGUhQsBEXhRaTFy5a9GAmJOw5GXBq0bf3xHadU8qgrVa+vmkHDw3ePlYUaipXzp
 t3SGb+XYBZLq4tN5L4YM4GFnKVBu9zT8+ihsBxmSDELdKJwGEZ20i1/lCjthkHqN9w5rDgDdopX
 +sd/1DkY7/YPZFrB5anNiztVkgvL11zvzHlJK1GSd9X6qNcrgQ==
X-Google-Smtp-Source: AGHT+IFX0vYJLxJhOzWGShIZU9ko5C/MWk9RcE/Q6dsEO0bnuGrTCvH6v2ML8WM3Cvw8Zi44xX8kZQ==
X-Received: by 2002:a05:6a20:2d08:b0:1f5:8714:8147 with SMTP id
 adf61e73a8af0-1f5c11c3c61mr16592957637.23.1742189050123; 
 Sun, 16 Mar 2025 22:24:10 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm6879495b3a.148.2025.03.16.22.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:24:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stefan Hajnoczi" <stefanha@gmail.com>
Subject: [PATCH 6/6] ppc/pnv: Fix system symbols in HOMER structure definitions
Date: Mon, 17 Mar 2025 15:23:38 +1000
Message-ID: <20250317052339.1108322-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317052339.1108322-1-npiggin@gmail.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

These definitions were taken from skiboot firmware. I naively thought it
would be nicer to keep the code similar by using the preprocessor, but
it was pointed out that system headers might still use those symbols and
cause something unexpected. Also just nicer to keep the QEMU tree clean.

Cc: Thomas Huth <thuth@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: "Stefan Hajnoczi" <stefanha@gmail.com>
Fixes: 70bc5c2498f46 ("ppc/pnv: Make HOMER memory a RAM region")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 201 ++++++++++++++++++++++-------------------------
 1 file changed, 96 insertions(+), 105 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index bda6b23ad3c..177c5e514b7 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -364,7 +364,12 @@ static void pnv_occ_register_types(void)
 
 type_init(pnv_occ_register_types);
 
-/* From skiboot/hw/occ.c with tab to space conversion */
+/*
+ * From skiboot/hw/occ.c with following changes:
+ * - tab to space conversion
+ * - Type conversions u8->uint8_t s8->int8_t __be16->uint16_t etc
+ * - __packed -> QEMU_PACKED
+ */
 /* OCC Communication Area for PStates */
 
 #define OPAL_DYNAMIC_DATA_OFFSET        0x0B80
@@ -384,20 +389,6 @@ type_init(pnv_occ_register_types);
 #define FREQ_MAX_IN_DOMAIN              0
 #define FREQ_MOST_RECENTLY_SET          1
 
-#define u8 uint8_t
-#define s8 int8_t
-#define u16 uint16_t
-#define s16 int16_t
-#define u32 uint32_t
-#define s32 int32_t
-#define u64 uint64_t
-#define s64 int64_t
-#define __be16 uint16_t
-#define __be32 uint32_t
-#ifndef __packed
-#define __packed QEMU_PACKED
-#endif /* !__packed */
-
 /**
  * OCC-OPAL Shared Memory Region
  *
@@ -434,69 +425,69 @@ type_init(pnv_occ_register_types);
  * @spare/reserved/pad:         Unused data
  */
 struct occ_pstate_table {
-    u8 valid;
-    u8 version;
-    union __packed {
-        struct __packed { /* Version 0x01 and 0x02 */
-            u8 throttle;
-            s8 pstate_min;
-            s8 pstate_nom;
-            s8 pstate_turbo;
-            s8 pstate_ultra_turbo;
-            u8 spare;
-            u64 reserved;
-            struct __packed {
-                s8 id;
-                u8 flags;
-                u8 vdd;
-                u8 vcs;
-                __be32 freq_khz;
+    uint8_t valid;
+    uint8_t version;
+    union QEMU_PACKED {
+        struct QEMU_PACKED { /* Version 0x01 and 0x02 */
+            uint8_t throttle;
+            int8_t pstate_min;
+            int8_t pstate_nom;
+            int8_t pstate_turbo;
+            int8_t pstate_ultra_turbo;
+            uint8_t spare;
+            uint64_t reserved;
+            struct QEMU_PACKED {
+                int8_t id;
+                uint8_t flags;
+                uint8_t vdd;
+                uint8_t vcs;
+                uint32_t freq_khz;
             } pstates[MAX_PSTATES];
-            s8 core_max[MAX_P8_CORES];
-            u8 pad[100];
+            int8_t core_max[MAX_P8_CORES];
+            uint8_t pad[100];
         } v2;
-        struct __packed { /* Version 0x90 */
-            u8 occ_role;
-            u8 pstate_min;
-            u8 pstate_nom;
-            u8 pstate_turbo;
-            u8 pstate_ultra_turbo;
-            u8 spare;
-            u64 reserved1;
-            u64 reserved2;
-            struct __packed {
-                u8 id;
-                u8 flags;
-                u16 reserved;
-                __be32 freq_khz;
+        struct QEMU_PACKED { /* Version 0x90 */
+            uint8_t occ_role;
+            uint8_t pstate_min;
+            uint8_t pstate_nom;
+            uint8_t pstate_turbo;
+            uint8_t pstate_ultra_turbo;
+            uint8_t spare;
+            uint64_t reserved1;
+            uint64_t reserved2;
+            struct QEMU_PACKED {
+                uint8_t id;
+                uint8_t flags;
+                uint16_t reserved;
+                uint32_t freq_khz;
             } pstates[MAX_PSTATES];
-            u8 core_max[MAX_P9_CORES];
-            u8 pad[56];
+            uint8_t core_max[MAX_P9_CORES];
+            uint8_t pad[56];
         } v9;
-        struct __packed { /* Version 0xA0 */
-            u8 occ_role;
-            u8 pstate_min;
-            u8 pstate_fixed_freq;
-            u8 pstate_base;
-            u8 pstate_ultra_turbo;
-            u8 pstate_fmax;
-            u8 minor;
-            u8 pstate_bottom_throttle;
-            u8 spare;
-            u8 spare1;
-            u32 reserved_32;
-            u64 reserved_64;
-            struct __packed {
-                u8 id;
-                u8 valid;
-                u16 reserved;
-                __be32 freq_khz;
+        struct QEMU_PACKED { /* Version 0xA0 */
+            uint8_t occ_role;
+            uint8_t pstate_min;
+            uint8_t pstate_fixed_freq;
+            uint8_t pstate_base;
+            uint8_t pstate_ultra_turbo;
+            uint8_t pstate_fmax;
+            uint8_t minor;
+            uint8_t pstate_bottom_throttle;
+            uint8_t spare;
+            uint8_t spare1;
+            uint32_t reserved_32;
+            uint64_t reserved_64;
+            struct QEMU_PACKED {
+                uint8_t id;
+                uint8_t valid;
+                uint16_t reserved;
+                uint32_t freq_khz;
             } pstates[MAX_PSTATES];
-            u8 core_max[MAX_P10_CORES];
-            u8 pad[48];
+            uint8_t core_max[MAX_P10_CORES];
+            uint8_t pad[48];
         } v10;
     };
-} __packed;
+} QEMU_PACKED;
 
 /**
  * OPAL-OCC Command Response Interface
@@ -531,13 +522,13 @@ struct occ_pstate_table {
  * @spare:                      Unused byte
  */
 struct opal_command_buffer {
-    u8 flag;
-    u8 request_id;
-    u8 cmd;
-    u8 spare;
-    __be16 data_size;
-    u8 data[MAX_OPAL_CMD_DATA_LENGTH];
-} __packed;
+    uint8_t flag;
+    uint8_t request_id;
+    uint8_t cmd;
+    uint8_t spare;
+    uint16_t data_size;
+    uint8_t data[MAX_OPAL_CMD_DATA_LENGTH];
+} QEMU_PACKED;
 
 /**
  * OPAL-OCC Response Buffer
@@ -571,13 +562,13 @@ struct opal_command_buffer {
  * @data:                       Response specific data
  */
 struct occ_response_buffer {
-    u8 flag;
-    u8 request_id;
-    u8 cmd;
-    u8 status;
-    __be16 data_size;
-    u8 data[MAX_OCC_RSP_DATA_LENGTH];
-} __packed;
+    uint8_t flag;
+    uint8_t request_id;
+    uint8_t cmd;
+    uint8_t status;
+    uint16_t data_size;
+    uint8_t data[MAX_OCC_RSP_DATA_LENGTH];
+} QEMU_PACKED;
 
 /**
  * OCC-OPAL Shared Memory Interface Dynamic Data Vx90
@@ -608,31 +599,31 @@ struct occ_response_buffer {
  * @rsp:                        OCC Response Buffer
  */
 struct occ_dynamic_data {
-    u8 occ_state;
-    u8 major_version;
-    u8 minor_version;
-    u8 gpus_present;
-    union __packed {
-        struct __packed { /* Version 0x90 */
-            u8 spare1;
+    uint8_t occ_state;
+    uint8_t major_version;
+    uint8_t minor_version;
+    uint8_t gpus_present;
+    union QEMU_PACKED {
+        struct QEMU_PACKED { /* Version 0x90 */
+            uint8_t spare1;
         } v9;
-        struct __packed { /* Version 0xA0 */
-            u8 wof_enabled;
+        struct QEMU_PACKED { /* Version 0xA0 */
+            uint8_t wof_enabled;
         } v10;
     };
-    u8 cpu_throttle;
-    u8 mem_throttle;
-    u8 quick_pwr_drop;
-    u8 pwr_shifting_ratio;
-    u8 pwr_cap_type;
-    __be16 hard_min_pwr_cap;
-    __be16 max_pwr_cap;
-    __be16 cur_pwr_cap;
-    __be16 soft_min_pwr_cap;
-    u8 pad[110];
+    uint8_t cpu_throttle;
+    uint8_t mem_throttle;
+    uint8_t quick_pwr_drop;
+    uint8_t pwr_shifting_ratio;
+    uint8_t pwr_cap_type;
+    uint16_t hard_min_pwr_cap;
+    uint16_t max_pwr_cap;
+    uint16_t cur_pwr_cap;
+    uint16_t soft_min_pwr_cap;
+    uint8_t pad[110];
     struct opal_command_buffer cmd;
     struct occ_response_buffer rsp;
-} __packed;
+} QEMU_PACKED;
 
 enum occ_response_status {
     OCC_RSP_SUCCESS                 = 0x00,
-- 
2.47.1


