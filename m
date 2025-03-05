Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A00C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWS-0005NL-6T; Tue, 04 Mar 2025 20:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUw-0003TG-NE
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:35 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUu-0007Fr-9c
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so10408015e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137870; x=1741742670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RY0hKsg/QJVynR94vVsgSjWfjxRvhr7eQQRJ6wX8nKY=;
 b=Se5v9sxm2fB+xC8zyeWd8ccDBxBKzeBSqF8eW/MWWmis0T64YmzhPAf+LTvBleRZS+
 WXhlw88rZytSja8kYkvf6NgTv8V7Il7B0BbRQYWtRITP0xj1vUUlWCX3eaurAzsWWwfJ
 JWl+ovaBHWrqgiE7BrRAH0AxKcmN+2IE/2NTJSZmib8Xl5cog/BIWnuX1N84hYn9WW8d
 zX197G/PHLr0G/nWZZKXH15K3Mtm4wnRCn4HxCStWle2sUapCnbD9bv6vilLWfNsho16
 bHgcj2N0fQ3vIjqOPGQ7lFNpga2oPOLzormisWDb3Mmdi+gKj3i6i0wuwPM5uCQR8S0a
 K7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137870; x=1741742670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RY0hKsg/QJVynR94vVsgSjWfjxRvhr7eQQRJ6wX8nKY=;
 b=XHX/d69MtbSHXierSiTeVEqA8V6LxhIzb7ZZT9UpwmsaQS+HLSeC3iM6SRN55hksG3
 DU/af6HGdgxEntJNPh3zG0jPRYkxGLc5OmWP91z5HtruzKnNoaXDxW0ePmqkCqjtuPmr
 mWcbDKh83dbRut4ZMNChvDSQPHnPOtc/aROEF4lu1SPJLOTBrxbMe1wSnGlcUzRnkR8Y
 iBkIVoN07WVuiQM8aXM4N8QE+nah/jK/5wqJN3nd0DtjXO9lP8l7SXuoAWogmgx5VyOX
 iC0Zu0faNfNlfNHu+kf7M2OTb4uS3F9kdslw5Bbw8Xe2k1M359klOZJ2s65tjDcR4O79
 AdIw==
X-Gm-Message-State: AOJu0YxvxgqlVzOmpowjHAA+HFSgsFnpq5ED2eeMnHv1L6QKO2tlGSGm
 P2anrXZogD+MpI/GOJfaSAd0CFHX3Skbxji0tKFmA6g244s7napSmAM/LG+BG9TfjVK6oXSqz25
 GigQ=
X-Gm-Gg: ASbGnctcMVVyeRMU3ZZGqXL42ATR76NbyTtGcx9x56MiUxgpL7m/BmA7PfWLP6i8ydo
 XhKBRQJyA/7h2oyXwEYeCYtbZKLt7iNJQuymF/aK9lQtoRV3kd6wrSWsHlxaXQqIrxGZYPnAGks
 r3/x1fgzLT62My4MJ65J+AwTo4CwbzTtRySCoSbcUntpDlrAbG6vYMYWk0Rn2y8LTpiQzMEa8R8
 PFnxbQIqN1VLb3ynXoH4Wvvl4hWYFLNvjGgqp3khg6Dg0oh8aAiEGa9jDWvbIhzUeI3S17K+ieZ
 YXH+ZZGY7a9kZs6B3O2pqnBk7mSNoce4K3D0zy2VK1B+PeEqT4zf+gswyaTSknt9+vRFRb281UP
 MCfl+IUNOOaAwn90NHNg=
X-Google-Smtp-Source: AGHT+IG4TPGTMCx/Fk1AvYnjkfUvZoq89/xbPfL5mXFuC9oLsoJTGArVHEE4IhXlUzCy53wyArbb1Q==
X-Received: by 2002:a5d:6da3:0:b0:391:1d5f:4c31 with SMTP id
 ffacd0b85a97d-3911f757c07mr781615f8f.23.1741137870037; 
 Tue, 04 Mar 2025 17:24:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292f0bsm2017765e9.15.2025.03.04.17.24.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keoseong Park <keosung.park@samsung.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/41] hw/ufs: Add temperature event notification support
Date: Wed,  5 Mar 2025 02:21:46 +0100
Message-ID: <20250305012157.96463-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Keoseong Park <keosung.park@samsung.com>

This patch introduces temperature event notification support to the UFS
emulation. It enables the emulated UFS device to generate
temperature-related events, including high and low temperature
notifications, in compliance with the UFS specification.

With this feature, UFS drivers can now handle temperature exception events
during testing and development within the emulated environment.
This enhances validation and debugging capabilities for thermal event
handling in UFS implementations.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Message-ID: <20250225064146epcms2p50889cb0066e2d4734f2386de325bcdf6@epcms2p5>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ufs/ufs.h        |  2 ++
 include/block/ufs.h | 13 +++++++-
 hw/ufs/ufs.c        | 78 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 4bcc41f53a0..3799d97f30d 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -146,6 +146,8 @@ typedef struct UfsHc {
     /* MCQ properties */
     UfsSq *sq[UFS_MAX_MCQ_QNUM];
     UfsCq *cq[UFS_MAX_MCQ_QNUM];
+
+    uint8_t temperature;
 } UfsHc;
 
 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 57f5ea3500c..a3ee62b027a 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -461,7 +461,7 @@ typedef struct Attributes {
     uint8_t psa_state;
     uint32_t psa_data_size;
     uint8_t ref_clk_gating_wait_time;
-    uint8_t device_case_rough_temperaure;
+    uint8_t device_case_rough_temperature;
     uint8_t device_too_high_temp_boundary;
     uint8_t device_too_low_temp_boundary;
     uint8_t throttling_status;
@@ -1073,6 +1073,11 @@ enum health_desc_param {
     UFS_HEALTH_DESC_PARAM_LIFE_TIME_EST_B = 0x4,
 };
 
+enum {
+    UFS_DEV_HIGH_TEMP_NOTIF = BIT(4),
+    UFS_DEV_LOW_TEMP_NOTIF = BIT(5),
+};
+
 /* WriteBooster buffer mode */
 enum {
     UFS_WB_BUF_MODE_LU_DEDICATED = 0x0,
@@ -1091,6 +1096,12 @@ enum ufs_lu_wp_type {
     UFS_LU_PERM_WP = 0x02,
 };
 
+/* Exception event mask values */
+enum {
+    MASK_EE_TOO_HIGH_TEMP = BIT(3),
+    MASK_EE_TOO_LOW_TEMP = BIT(4),
+};
+
 /* UTP QUERY Transaction Specific Fields OpCode */
 enum query_opcode {
     UFS_UPIU_QUERY_OPCODE_NOP = 0x0,
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1ccd6f88b69..857de6e9c2c 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -34,6 +34,11 @@
 #define UFS_MAX_NUTMRS 8
 #define UFS_MCQ_QCFGPTR 2
 
+/* Each value represents the temperature in celsius as (value - 80) */
+#define UFS_TEMPERATURE 120
+#define UFS_TOO_HIGH_TEMP_BOUNDARY 160
+#define UFS_TOO_LOW_TEMP_BOUNDARY 60
+
 static void ufs_exec_req(UfsRequest *req);
 static void ufs_clear_req(UfsRequest *req);
 
@@ -838,6 +843,42 @@ static const MemoryRegionOps ufs_mmio_ops = {
     },
 };
 
+static void ufs_update_ee_status(UfsHc *u)
+{
+    uint16_t ee_status = be16_to_cpu(u->attributes.exception_event_status);
+    uint8_t high_temp_thresh = u->attributes.device_too_high_temp_boundary;
+    uint8_t low_temp_thresh = u->attributes.device_too_low_temp_boundary;
+
+    if (u->temperature >= high_temp_thresh) {
+        ee_status |= MASK_EE_TOO_HIGH_TEMP;
+    } else {
+        ee_status &= ~MASK_EE_TOO_HIGH_TEMP;
+    }
+
+    if (u->temperature <= low_temp_thresh) {
+        ee_status |= MASK_EE_TOO_LOW_TEMP;
+    } else {
+        ee_status &= ~MASK_EE_TOO_LOW_TEMP;
+    }
+
+    u->attributes.exception_event_status = cpu_to_be16(ee_status);
+}
+
+static bool ufs_check_exception_event_alert(UfsHc *u, uint8_t trans_type)
+{
+    uint16_t ee_control = be16_to_cpu(u->attributes.exception_event_control);
+    uint16_t ee_status;
+
+    if (trans_type != UFS_UPIU_TRANSACTION_RESPONSE) {
+        return false;
+    }
+
+    ufs_update_ee_status(u);
+
+    ee_status = be16_to_cpu(u->attributes.exception_event_status);
+
+    return ee_control & ee_status;
+}
 
 void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
                            uint8_t response, uint8_t scsi_status,
@@ -848,6 +889,8 @@ void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
     req->rsp_upiu.header.flags = flags;
     req->rsp_upiu.header.response = response;
     req->rsp_upiu.header.scsi_status = scsi_status;
+    req->rsp_upiu.header.device_inf =
+        ufs_check_exception_event_alert(req->hc, trans_type);
     req->rsp_upiu.header.data_segment_length = cpu_to_be16(data_segment_length);
 }
 
@@ -1042,6 +1085,25 @@ static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
     return UFS_QUERY_RESULT_SUCCESS;
 }
 
+static inline uint8_t ufs_read_device_temp(UfsHc *u)
+{
+    uint8_t feat_sup = u->device_desc.ufs_features_support;
+    bool high_temp_sup, low_temp_sup, high_temp_en, low_temp_en;
+    uint16_t ee_control = be16_to_cpu(u->attributes.exception_event_control);
+
+    high_temp_sup = feat_sup & UFS_DEV_HIGH_TEMP_NOTIF;
+    low_temp_sup = feat_sup & UFS_DEV_LOW_TEMP_NOTIF;
+    high_temp_en = ee_control & MASK_EE_TOO_HIGH_TEMP;
+    low_temp_en = ee_control & MASK_EE_TOO_LOW_TEMP;
+
+    if ((high_temp_sup && high_temp_en) ||
+        (low_temp_sup && low_temp_en)) {
+        return u->temperature;
+    }
+
+    return 0;
+}
+
 static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
 {
     switch (idn) {
@@ -1072,6 +1134,7 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     case UFS_QUERY_ATTR_IDN_EE_CONTROL:
         return be16_to_cpu(u->attributes.exception_event_control);
     case UFS_QUERY_ATTR_IDN_EE_STATUS:
+        ufs_update_ee_status(u);
         return be16_to_cpu(u->attributes.exception_event_status);
     case UFS_QUERY_ATTR_IDN_SECONDS_PASSED:
         return be32_to_cpu(u->attributes.seconds_passed);
@@ -1086,7 +1149,8 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     case UFS_QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME:
         return u->attributes.ref_clk_gating_wait_time;
     case UFS_QUERY_ATTR_IDN_CASE_ROUGH_TEMP:
-        return u->attributes.device_case_rough_temperaure;
+        u->attributes.device_case_rough_temperature = ufs_read_device_temp(u);
+        return u->attributes.device_case_rough_temperature;
     case UFS_QUERY_ATTR_IDN_HIGH_TEMP_BOUND:
         return u->attributes.device_too_high_temp_boundary;
     case UFS_QUERY_ATTR_IDN_LOW_TEMP_BOUND:
@@ -1677,8 +1741,12 @@ static void ufs_init_hc(UfsHc *u)
     u->device_desc.ud_0_base_offset = 0x16;
     u->device_desc.ud_config_p_length = 0x1A;
     u->device_desc.device_rtt_cap = 0x02;
+    u->device_desc.ufs_features_support = UFS_DEV_HIGH_TEMP_NOTIF |
+        UFS_DEV_LOW_TEMP_NOTIF;
     u->device_desc.queue_depth = u->params.nutrs;
     u->device_desc.product_revision_level = 0x04;
+    u->device_desc.extended_ufs_features_support =
+        cpu_to_be32(UFS_DEV_HIGH_TEMP_NOTIF | UFS_DEV_LOW_TEMP_NOTIF);
 
     memset(&u->geometry_desc, 0, sizeof(GeometryDescriptor));
     u->geometry_desc.length = sizeof(GeometryDescriptor);
@@ -1702,9 +1770,17 @@ static void ufs_init_hc(UfsHc *u)
     /* configure descriptor is not supported */
     u->attributes.config_descr_lock = 0x01;
     u->attributes.max_num_of_rtt = 0x02;
+    u->attributes.device_too_high_temp_boundary = UFS_TOO_HIGH_TEMP_BOUNDARY;
+    u->attributes.device_too_low_temp_boundary = UFS_TOO_LOW_TEMP_BOUNDARY;
 
     memset(&u->flags, 0, sizeof(u->flags));
     u->flags.permanently_disable_fw_update = 1;
+
+    /*
+     * The temperature value is fixed to UFS_TEMPERATURE and does not change
+     * dynamically
+     */
+    u->temperature = UFS_TEMPERATURE;
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
-- 
2.47.1


