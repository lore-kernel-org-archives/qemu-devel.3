Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5490CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 06:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmodk-0002EM-5S; Tue, 25 Feb 2025 01:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tmodf-0002DU-19
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:41:56 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tmodc-0002Zy-D5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:41:54 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250225064148epoutp04cf4244455eba1b5d135cf76b5421ce78~nYFcdUGtu2902029020epoutp04U
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:41:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250225064148epoutp04cf4244455eba1b5d135cf76b5421ce78~nYFcdUGtu2902029020epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1740465708;
 bh=uPT0C8Q6U3lJgbT5wi9yUSDivm2GoI2zMRgcx9nQJlA=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=IsQp6NlZNFoP7xSrumAFwhv0dS/r5mOxkBJdoiSOS4tRd+z7v+xthny92/YI0OxLT
 iwwrTeM+RrTqcTo+zWzfXgFTE7ewdtfX0RdlAyohG0iBkUtz5uVxcZiVnvxZMe6hLt
 bhRHho/UT/EmacDD4ma5N48Qujl4nlneLOU33jXE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20250225064147epcas2p41f77d46090196dc4228b6c0604c3257a~nYFcJIYTc1344013440epcas2p4d;
 Tue, 25 Feb 2025 06:41:47 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Z27LM18zKz4x9Q2; Tue, 25 Feb
 2025 06:41:47 +0000 (GMT)
X-AuditID: b6c32a46-484397000000564e-7a-67bd662ae606
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 E1.91.22094.A266DB76; Tue, 25 Feb 2025 15:41:46 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/2] hw/ufs: Add temperature event notification support
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Keoseong Park <keosung.park@samsung.com>, Jinyoung
 Choi <j-young.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250225064146epcms2p50889cb0066e2d4734f2386de325bcdf6@epcms2p5>
Date: Tue, 25 Feb 2025 15:41:46 +0900
X-CMS-MailID: 20250225064146epcms2p50889cb0066e2d4734f2386de325bcdf6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmma522t50g4kRFi8PaVq8frGc2eLB
 3X5Gi97+rWwW97deY7Q4fvIdo8WSi6kWnxqkLPZv+8dqMetdO5vF8d4dLA7cHk+ubWbyeL/v
 KptH35ZVjB6bT1cHsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
 Krn4BOi6ZeYAXaSkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvX
 y0stsTI0MDAyBSpMyM7Ye8y44J1NRc/uC2wNjBMMuxg5OSQETCT+Lb3P2sXIxSEksINR4vjf
 VuYuRg4OXgFBib87hEFMYQF3ie2tEiDlQgJKEl0LtzKD2MICBhLrpu8Bs9kE9CSm/L7DCDJG
 ROAHo0TTzjtMIA6zwB5GiQmdRxghlvFKzGh/ygJhS0tsX74VLM4p4Cfxd3YTVFxD4seyXmYI
 W1Ti5uq37DD2+2PzoeaISLTeOwtVIyjx4OduRpBDJQQkJd5fVYQI10u0vj/FDnKDhMAERonG
 Y3+g5uhLXOvYCLaLV8BXorFxH5jNIqAqsfHHd1aIGheJ67/ugsWZBeQltr+dAw4TZgFNifW7
 9CFWKUscuQVVwSfRcfgvO8yHDRt/Y2XvmPeECcJWk3i0YAvrBEblWYiAnoVk1yyEXQsYmVcx
 iqUWFOempxYbFRjBozY5P3cTIzhparntYJzy9oPeIUYmDsZDjBIczEoivJyZe9KFeFMSK6tS
 i/Lji0pzUosPMZoCfTmRWUo0OR+YtvNK4g1NLA1MzMwMzY1MDcyVxHmrd7SkCwmkJ5akZqem
 FqQWwfQxcXBKNTCtnqer7+Raf30L2//oNDPj7nkyyRNO6j6JEGSvvVheLlEReWJFdYXhI+4n
 Rd+z4r+9/fRHPUrt772aGCWDdP7tB9J/nhG5PvXNpHufPm3fXREzwfTa4nKzupZg/z27viWu
 5vH92RWepHJQrL+xYqHTvi4PxTS/DxL7H/Sv9BW/fof73/bGDTPtWqQuuzAX8nBHMSm3Lf9y
 xGLFJqMz57PbbpW3SK1bvGD2lGtzm1JTV+os4Nkz6TL3eYZVliL7q0S65aJFTdcvnOIe7N7G
 42XzMvus7Zsozalbli0zOREayL7i7qsf76sybFx4bnfOt2lK2JrP88Lcv6zof2VT4E2v5aYe
 Ws58XzrqLhgGMCixFGckGmoxFxUnAgDG/DJrIwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8
References: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
 <CGME20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p5>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=keosung.park@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: keosung.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch introduces temperature event notification support to the UFS
emulation. It enables the emulated UFS device to generate
temperature-related events, including high and low temperature
notifications, in compliance with the UFS specification.

With this feature, UFS drivers can now handle temperature exception events
during testing and development within the emulated environment.
This enhances validation and debugging capabilities for thermal event
handling in UFS implementations.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 hw/ufs/ufs.c        | 78 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |  2 ++
 include/block/ufs.h | 13 +++++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1ccd6f88b6..857de6e9c2 100644
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
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 4bcc41f53a..3799d97f30 100644
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
index 57f5ea3500..a3ee62b027 100644
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
-- 
2.25.1


