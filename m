Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8340AFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWE-00082K-0w; Tue, 07 Apr 2026 14:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wABTn-0003Pl-CK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wA3fz-0003Lr-KL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:28:57 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82ce09b61beso2120261b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 03:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775557734; x=1776162534; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wp610CTuY5BtVJCvmliEvcgHSUgtMv4PTZfRqvUtBfw=;
 b=fzH68N+DMFMRm88w6Lno1gRVeJlR+xsmiB4L/E7bAt+QWxJoaRgP01sKjf75W2CNYs
 lYt3v467r2UmjN/e8gYUSzcDyfI4xbcUO6nXnqVedlMON/JopuixTYh1Sr2RCf/e/TSt
 GA3Z7znpPmxI62eejSjEAZ1mTJw0H76fC9bF/a0VyR0NOMZSRDPnTVSGUBPuG1B1eDba
 lBskSFqunuB21Q25XgMcdQK7WLcOYnnqPFOMce/aSwr5EnuqAwQ/Bmlm0OLSqHTKtaul
 NthWDhj86dSPVc0LjcqVVRy6HfyamOvB3WzvfeiEB2ttpsLPAYsMevHcweJo8S7h6avU
 /KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775557734; x=1776162534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wp610CTuY5BtVJCvmliEvcgHSUgtMv4PTZfRqvUtBfw=;
 b=er2HV2TF0SuHDCyQkJ99SkevjM2iaP1KiBAJFXgXyXiyJRtdOZWsgEGFIpMJ6/pEwJ
 44v+t43QzwPtkdvtYaxqj2Ocp+AtDk0yrfO4yrGQ1CfcdQD2N7rxn1Y7EnEGLB6ooWGI
 KNdBo2jXHfHlUj8m5livNG7CEH6VQVxaEOEnkptYnYm2ulhteB/r37y2//XfkASTlL1v
 v3mr/cyVEMYFJzG6Oj7btBCHSzXLXzhZOd3Mtnl6tiK9wFWlEugwBt3C5K3ZZVwILvOU
 IYarGeInm2tAzZgUB9PQuicNRpgk6yUY8Ffk4lIzsTJ08m0rcKth0wOJsUXnGiVfhXkf
 4tNQ==
X-Gm-Message-State: AOJu0Yz6mO4F+MoK3/4wu87PHOlUe3e/1B0dHSF7cy9dpF9uvrkwkps3
 rUzAi13CjEAJzRmUYeGa2RtdTg6rf7nJWx+7rbE60S1tCFQQDVBTdlOD5AK8VqXx52Zncg==
X-Gm-Gg: AeBDieuHZlByAYt73Wo46nAFhbBkmVXTYfKhmNoFcd6uGyy7PN4+P/dStRGMGWs2agK
 AhNhC5oyRVWqDt3WIaYdzWua3dbMGxwpBQiT47iLoef9GDZ9QMYsH2HtHVrr4VJaHh5RRzOZwEP
 cqNhf3TVThzC+ZWSUBtPlcsglEMsyndM8z6VQEOhD9f4/MB6iPg9Hzhd8JRwQBA4ujkOFV7qxHV
 51VpUQBC35uTEDduZFidTdpUhmTrUlCcUULHV1Jnq7ZyXsrDaRXYOlhntDtZY8es8a8upyo0ZpZ
 0AVRShYxbuhfywR/yoQ7gqyN3Bq9cA/D+wQl6lpMBycqdy3xksS919mnP4WHGwEtbVy02Xf3NeJ
 5XmXAjfzPazklYHccY/ObDDLPl9CoEwFZCGvQR/Sxk8dsAboP4oQvuoODPPL/fhUM/tDZa1pDyJ
 8wZwwjsmbHYkm88p+L7ed3pGUsTQqvaKMRW2Onih8K
X-Received: by 2002:a05:6a00:414b:b0:823:1d05:1660 with SMTP id
 d2e1a72fcca58-82d0dbd3061mr16177101b3a.52.1775557734043; 
 Tue, 07 Apr 2026 03:28:54 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2714dsm21217324b3a.1.2026.04.07.03.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 03:28:53 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Tue, 07 Apr 2026 19:23:40 +0900
Subject: [PATCH v2 2/5] hw/ufs: Modify flag handling operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-write_booster-v2-2-dd772bb30194@samsung.com>
References: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
In-Reply-To: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775557727; l=6656;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=UwQldvutZu9HqLXksjdiAk3IKzXkRCngBaBlZ026a4E=;
 b=TCgoBU8s0BrRLtHhIgj2FI6qmMKO1/XHbaQXMC/yFQPj6tGc8e9D66B5Qj44r9A044EHf+CKP
 GXod/XFeMljAeDpN0imU9BqQz/sQcKeyhV0WNW+/BUhysw769Y2Ua7U
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ldc.jml@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Change internal flag handling operation same as attribute's

In UFS device, some flag queries directly trigger specific device
behaviour like attribute's, not only changes the internal values.
So restructure flag query processing functions same as attribute
processing, to facilitate linking detailed implementations based on
individual flag value changes.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
 hw/ufs/ufs.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 119 insertions(+), 33 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index b2b70c8b38ebecd8d49ecce288614d55efd90f2e..69f82ab462d135fe6cda479891f9d8f26d19be9a 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1021,6 +1021,122 @@ static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
     return UFS_QUERY_RESULT_SUCCESS;
 }
 
+static uint32_t ufs_read_flag_value(UfsHc *u, uint8_t idn)
+{
+    switch (idn) {
+    case UFS_QUERY_FLAG_IDN_FDEVICEINIT:
+        return u->flags.device_init;
+    case UFS_QUERY_FLAG_IDN_PERMANENT_WPE:
+        return u->flags.permanent_wp_en;
+    case UFS_QUERY_FLAG_IDN_PWR_ON_WPE:
+        return u->flags.power_on_wp_en;
+    case UFS_QUERY_FLAG_IDN_BKOPS_EN:
+        return u->flags.background_ops_en;
+    case UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE:
+        return u->flags.device_life_span_mode_en;
+    case UFS_QUERY_FLAG_IDN_PURGE_ENABLE:
+        return u->flags.purge_enable;
+    case UFS_QUERY_FLAG_IDN_REFRESH_ENABLE:
+        return u->flags.refresh_enable;
+    case UFS_QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL:
+        return u->flags.phy_resource_removal;
+    case UFS_QUERY_FLAG_IDN_BUSY_RTC:
+        return u->flags.busy_rtc;
+    case UFS_QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE:
+        return u->flags.permanently_disable_fw_update;
+    case UFS_QUERY_FLAG_IDN_WB_EN:
+        return u->flags.wb_en;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN:
+        return u->flags.wb_buffer_flush_en;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8:
+        return u->flags.wb_buffer_flush_during_hibernate;
+    case UFS_QUERY_FLAG_IDN_UNPIN_EN:
+        return u->flags.unpin_en;
+    default:
+        g_assert_not_reached();
+        return 0;
+    }
+}
+
+static QueryRespCode ufs_write_flag_value(UfsHc *u, uint8_t idn, uint8_t value)
+{
+    switch (idn) {
+    case UFS_QUERY_FLAG_IDN_FDEVICEINIT:
+        u->flags.device_init = 0;
+        break;
+    case UFS_QUERY_FLAG_IDN_PERMANENT_WPE:
+        u->flags.permanent_wp_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_PWR_ON_WPE:
+        u->flags.power_on_wp_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_BKOPS_EN:
+        u->flags.background_ops_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE:
+        u->flags.device_life_span_mode_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_PURGE_ENABLE:
+        u->flags.purge_enable = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_REFRESH_ENABLE:
+        u->flags.refresh_enable = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL:
+        u->flags.phy_resource_removal = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE:
+        u->flags.permanently_disable_fw_update = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_WB_EN:
+        u->flags.wb_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN:
+        u->flags.wb_buffer_flush_en = value;
+        break;
+    case UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8:
+        u->flags.wb_buffer_flush_during_hibernate = value;
+        break;
+    default:
+        return UFS_QUERY_RESULT_INVALID_VALUE;
+    }
+
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
+{
+    UfsHc *u = req->hc;
+    uint8_t idn = req->req_upiu.qr.idn;
+    uint8_t value;
+    QueryRespCode ret;
+
+    ret = ufs_flag_check_idn_valid(idn, op);
+    if (ret) {
+        return ret;
+    }
+
+    if (op == UFS_QUERY_FLAG_READ) {
+        value = ufs_read_flag_value(u, idn);
+        ret = UFS_QUERY_RESULT_SUCCESS;
+    } else if (op == UFS_QUERY_FLAG_SET) {
+        value = 1;
+        ret = ufs_write_flag_value(u, idn, value);
+    } else if (op == UFS_QUERY_FLAG_CLEAR) {
+        value = 0;
+        ret = ufs_write_flag_value(u, idn, value);
+    } else if (op == UFS_QUERY_FLAG_TOGGLE) {
+        value = !(ufs_read_flag_value(u, idn));
+        ret = ufs_write_flag_value(u, idn, value);
+    } else {
+        trace_ufs_err_query_invalid_opcode(op);
+        return UFS_QUERY_RESULT_INVALID_OPCODE;
+    }
+
+    req->rsp_upiu.qr.value = cpu_to_be32(value);
+    return ret;
+}
+
 static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
     /* booting is not supported */
     [UFS_QUERY_ATTR_IDN_BOOT_LU_EN] = UFS_QUERY_ATTR_READ,
@@ -1103,39 +1219,6 @@ static inline QueryRespCode ufs_attr_check_idn_valid(uint8_t idn, int op)
     return UFS_QUERY_RESULT_SUCCESS;
 }
 
-static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
-{
-    UfsHc *u = req->hc;
-    uint8_t idn = req->req_upiu.qr.idn;
-    uint32_t value;
-    QueryRespCode ret;
-
-    ret = ufs_flag_check_idn_valid(idn, op);
-    if (ret) {
-        return ret;
-    }
-
-    if (idn == UFS_QUERY_FLAG_IDN_FDEVICEINIT) {
-        value = 0;
-    } else if (op == UFS_QUERY_FLAG_READ) {
-        value = *(((uint8_t *)&u->flags) + idn);
-    } else if (op == UFS_QUERY_FLAG_SET) {
-        value = 1;
-    } else if (op == UFS_QUERY_FLAG_CLEAR) {
-        value = 0;
-    } else if (op == UFS_QUERY_FLAG_TOGGLE) {
-        value = *(((uint8_t *)&u->flags) + idn);
-        value = !value;
-    } else {
-        trace_ufs_err_query_invalid_opcode(op);
-        return UFS_QUERY_RESULT_INVALID_OPCODE;
-    }
-
-    *(((uint8_t *)&u->flags) + idn) = value;
-    req->rsp_upiu.qr.value = cpu_to_be32(value);
-    return UFS_QUERY_RESULT_SUCCESS;
-}
-
 static inline uint8_t ufs_read_device_temp(UfsHc *u)
 {
     uint8_t feat_sup = u->device_desc.ufs_features_support;
@@ -1300,6 +1383,9 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
     case UFS_QUERY_ATTR_IDN_TIMESTAMP:
         u->attributes.timestamp = cpu_to_be64(value);
         break;
+    default:
+        g_assert_not_reached();
+        return 0;
     }
     return UFS_QUERY_RESULT_SUCCESS;
 }

-- 
2.48.1


