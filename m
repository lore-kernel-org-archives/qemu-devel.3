Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06407C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpr-0000m3-5p; Fri, 21 Mar 2025 02:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoN-00082H-L5; Fri, 21 Mar 2025 02:25:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoJ-00031e-02; Fri, 21 Mar 2025 02:24:53 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso26000935ad.3; 
 Thu, 20 Mar 2025 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538289; x=1743143089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9DMWwN++nDn/z8w6/tFVpHD3yh9Owg5T27xYWy3gZI=;
 b=RmrsANBzHFtxbncn2Q9awNREieq/ZGvIp+jY+DxJY5vIz1UKcQtmA0o5wI+dcwm40I
 0UK4uGXu4CKYteEj26KX9Zo8ryC6J0mwRHHevKqEo0VFrCJ2MnkfW2G08y8R3wTHXQvz
 BA5yPAmJbkKEXxEXFEUZUIaaCOw4dKmXdq5pv7euo4lhD06KXW0AeMuZtdX0Fm6Ksf3N
 D1uUsC9hKdTLXolwaqN5YyRnRyjeU3f4L+dMUZzz3dnUZNghUD8+kI4ZWoVLpEaRWSKi
 JMJb5atm74w1f4u0s9B/Kjg5tKa0I7r5RhctBjrzSjx+lE9Y/Nj2BioUcHNCbSTLGjpE
 cc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538289; x=1743143089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9DMWwN++nDn/z8w6/tFVpHD3yh9Owg5T27xYWy3gZI=;
 b=Pem8wL455BDzVRx482n2ugseSrTTC5jVhSspH8nMUWglPGjJ0KJ0enVm1CZdbivMFe
 I1Q7IkzjhPk4a34jLtBFMmZs7YbSx+E88D+1vWYAp6bxJJXcQHff1jAuxaVPty+rmZVR
 X7UvP97W8BTmajL7f05T7jx0LRh7sLqjsdCqgDMIlQezdOYfACz/UjxW0ir1sGxKH0GZ
 4l6onHU1D5I5UYoImK7vGZvchpxQI+y1liUSKl2wAn9HzRI2+xN/8PTsopNjtgzaqnyH
 CEyJ5gttC5pfViGmNnzHyV15Y0/VtJdK2ps7v6+Clq/mMqzLHo21cC0E9x+JhpOf62VA
 GJMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6jr1tFyq7QfQukM44RphliZa5Ewqjvw6Zy7L6sLVHls74BT6eeSMNOojf4S7GwIZlemU4NJNnew==@nongnu.org
X-Gm-Message-State: AOJu0YxAumF00GOqEoZg8PS7rBzs0E8EkLoT0VLImkMeKmQ9gHofeJQ5
 +SFLFA3UOxaBf+ldGJcLTTTWbBbP4VoLuanyL7PFfuOCUkKPZ/Ejezj2Dg==
X-Gm-Gg: ASbGncsQPVc4xNyJUHeAPpiA+DFVPkwRpba11LDQNt0ED99loDeT91cP+EIniPtFZ0J
 j3npCzAK7XSi8axUU/64V1rKct/5VM+ciAKrFkDX0r09VK2bCe0NjVhf0kBG6gH2Ow/zdQDdpEX
 ceHXIuJ77du/LjseacTZSniyrhYTgf5UEUJ0qjTkXtrmBhC8hTuiktSrO+3JSaVDCVVvaPpm8HJ
 +2e3/NEd5L7l9j/JJNTdviMP8TGgYCrzj7swfV7+UQ42Fxs0zn1nPwRGTpgu6jkZ+5LIF/zm+Ud
 TTPmQl+0o0TB7mhz7U8UySQ7O+PJe/FYEsEsNtH+RJOjskImYg==
X-Google-Smtp-Source: AGHT+IGJ8nABmj58AOFOOSgxZHDCEiNecGwSBxT7AKzK+VA1UUy+uMmYYY8jRECL0l76s2/IBT8w7w==
X-Received: by 2002:a05:6a20:7347:b0:1ee:e2ac:5159 with SMTP id
 adf61e73a8af0-1fe42f53152mr3551858637.19.1742538289011; 
 Thu, 20 Mar 2025 23:24:49 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stefan Hajnoczi" <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/12] ppc/pnv: Fix system symbols in HOMER structure
 definitions
Date: Fri, 21 Mar 2025 16:24:11 +1000
Message-ID: <20250321062421.116129-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: "Stefan Hajnoczi" <stefanha@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Fixes: 70bc5c2498f46 ("ppc/pnv: Make HOMER memory a RAM region")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 201 ++++++++++++++++++++++-------------------------
 1 file changed, 96 insertions(+), 105 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index bda6b23ad3..177c5e514b 100644
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


