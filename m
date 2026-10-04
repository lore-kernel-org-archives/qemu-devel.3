Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13DDCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 14:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDNY4-0006qn-IF; Sun, 04 Oct 2026 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dridiha98@gmail.com>)
 id 1xDLiN-0008Oj-Uv
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:53:16 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dridiha98@gmail.com>)
 id 1xDLiM-0001CJ-85
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:53:15 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48aff407b13so112705f8f.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791118392; x=1791723192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gpTLuih9vSizq7WAwP93e+PWfTUsnW6saVtgwecH1ZU=;
 b=X0unPi389Ac7NCUstQj0IohzfIPMMf+OdmpHU0SVAfQv+jkdl79cpIpkO4ApG+sgqC
 SleRUzl3Bau64DWlWWovt4HblAS/1hwlOlshUfyR9m79N8U7X5j+gwHnCRF9q0wPDKCT
 jm3uHUbEfEws8dFhbEUkeTBK/7g/8+DZq4WLXoj8vWvtMzN94O7j4JRqDOZAKXWymboQ
 BcHa1De1/Lcgv1IKVJojxRfZLdnmA84JkGJzeThURPUgOm6Lmhjv4tRSpV86+J76nxp1
 EHABliWWhUbHsTACWCqM0qnINKkjw3FybPNEztcz6tDgS5NkUuDPFVT3CE+tHgukuodq
 53Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791118392; x=1791723192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gpTLuih9vSizq7WAwP93e+PWfTUsnW6saVtgwecH1ZU=;
 b=CoNmPsgly30pDZLfli6KioJibd0UDotFFujukbdEf+uXhdGRDn0SlGH5RH0+Ow3AQj
 LloQraeTHz1emYenok4rsw/n71tUgIL5OJ2jIwPcuOp8RTgTFMWhEDZvOvmyiuQVsRGc
 HaZBi7tSUtdSRh8C5uC85MWI1oySX/gg7aEcO5msuQ8WDAqQSLcnG/uqoFVujqzRej/o
 MbuO1H4GKF+kxkq8qrFoZaLfTLyOyB4skeJBSR4MWXCi9edy6GvbTef4DHV6vI2Wb1N3
 nILqWGyfRZx0kKnl53HgwXCkOSh7hd7DU9BnFFNAuJwZKreEQY7ilz89KxSEDhhiXkRx
 WFdw==
X-Gm-Message-State: AFuF++kpmavJaDNRC+/uK1rHNDdiHU+XXB1qAnVETvTh+wWEMJ9Ji4Tw
 DwtLXTIH2zyOMrZgb0wzgBijwmZhqzxe5PjldY782dWhFUwiibuVO4GKOK/kXxP3
X-Gm-Gg: AYBFou1aE0zPXSjPtpVV53plNyxAkdkJ9Ss42uMPtpPR5ybkoIWyiyv8zbKftlYy6TU
 aOibYe+L7aiiGuzqngVnEKK1JCxL3Wl15xqAraCqKBmNv/qXQfFv8OsooqMFrPMjVDeyWq8GyLk
 bPUMsQGzR3wo3VssjZO8JTvX7VgvhTrRW/hxV7eI+qXcL1+e+UCPl2c2P6q66HBzDKBVKROJxu/
 CoEtrBSrf5ZTqLC8kDU/z2HbPGtmMEomXpDJ7XklXwODjDGdmN8PCW0DOQtJZncszGMQ31x2zan
 qTsXigjN1ITFkbgVQdkb4/QzeTy1ZTTJDxBblDPIawUHM4wx7NzODLqBjZLEQyvqe7rBZgdVqs+
 ms9hAoW9PcIV1bTxkmVe3IApEt902LLH0SZgGOo9mhxG+9NJbcue2fipng1G3RhfTyVZwgTPhxq
 DSXeQSSc2C5cbzElyaznWckc+havSaz5Xwjfk2HVd9YgRyJOsUrMJtwdPfTUI091I4TpfSu8Eg0
 XYLEjM3FOH/LykWJAMHpihTGpnkU2opC32XA+S4hheLu282NccuWcmRtYINEYU5ag==
X-Received: by 2002:a05:600c:601:b0:4a0:73b:a222 with SMTP id
 5b1f17b1804b1-4a02744cc57mr92082165e9.0.1791118391715; 
 Sun, 04 Oct 2026 05:53:11 -0700 (PDT)
Received: from root-hamza.home ([2a01:cb14:55d:b000:e1d6:722e:9041:a5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03048abc9sm102896975e9.0.2026.10.04.05.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:53:11 -0700 (PDT)
From: Hamza Dridi <dridiha98@gmail.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 dridiha <dridiha98@gmail.com>
Subject: [PATCH] hw/ufs: Add support for REPORT_LUNS SCSI command for Well
 Known LUNs
Date: Sun,  4 Oct 2026 14:53:05 +0200
Message-ID: <20261004125305.99878-1-dridiha98@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=dridiha98@gmail.com; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2026 10:50:43 -0400
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

From: dridiha <dridiha98@gmail.com>

According to the UFS specification, the REPORT_LUNS SCSI command can query
Well Known LUNs by setting CDB[2] to 0x01 (select Well Known LUNs) or 0x02
(select all LUNs).

Currently, the UFS emulation layer lacks handling for these CDB[2] select
report values, causing command failures when guests attempt to report Well
Known LUNs.

This patch adds support for handling CDB[2] values 0x01 and 0x02 in the
REPORT_LUNS command, returning the appropriate Well Known LUN descriptors
in the SCSI response payload.

Signed-off-by: Hamza Dridi <dridiha98@gmail.com>
---
 hw/ufs/lu.c         | 41 +++++++++++++++++++++++++++++++----------
 include/block/ufs.h |  3 +++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index bdb1650851..4d77c2da2f 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -211,33 +211,54 @@ static const struct SCSIBusInfo ufs_scsi_info = {
     .cancel = ufs_scsi_command_cancelled,
 };
 
+static bool ufs_append_lun(uint8_t *outbuf, uint32_t outbuf_len, int *len,
+                           uint8_t lun, uint8_t lun_msb)
+{
+    if (*len + 8 > outbuf_len) {
+        return false;
+    }
+
+    memset(outbuf + *len, 0, 8);
+    outbuf[*len] = lun_msb;
+    outbuf[*len + 1] = lun;
+    *len += 8;
+
+    return true;
+}
+
 static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
                                    uint32_t outbuf_len)
 {
     UfsHc *u = req->hc;
     int len = 0;
 
-    /* TODO: Support for cases where SELECT REPORT is 1 and 2 */
-    if (req->req_upiu.sc.cdb[2] != 0) {
+    uint8_t report_lun_cmd = req->req_upiu.sc.cdb[2];
+
+    if (report_lun_cmd > 2) {
         return SCSI_COMMAND_FAIL;
     }
 
     if (outbuf_len < 8) {
         return SCSI_COMMAND_FAIL;
     }
+
     memset(outbuf, 0, 8);
     len += 8;
 
-    for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
-        if (u->lus[lun]) {
-            if (len + 8 > outbuf_len) {
+    if (report_lun_cmd == 2 || report_lun_cmd == 1) {
+        ufs_append_lun(outbuf, outbuf_len, &len, u->report_wlu.lun,
+                       UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->dev_wlu.lun, UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->boot_wlu.lun, UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->rpmb_wlu.lun, UFS_WLUN_MSB);
+    }
+
+    if (report_lun_cmd == 0 || report_lun_cmd == 2) {
+        for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
+            if (u->lus[lun] &&
+                !ufs_append_lun(outbuf, outbuf_len, &len, lun, 0)) {
                 break;
             }
-
-            memset(outbuf + len, 0, 8);
-            outbuf[len] = 0;
-            outbuf[len + 1] = lun;
-            len += 8;
         }
     }
 
diff --git a/include/block/ufs.h b/include/block/ufs.h
index d19b3c65ef..9d5ec4c77f 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -818,6 +818,9 @@ typedef struct QEMU_PACKED UtpTaskReqDesc {
  */
 #define UFS_EHS_OFFSET_IN_RESPONSE 32
 
+/* Most significant byte in the Report Lun response for Well Known LU */
+#define UFS_WLUN_MSB 0xC1
+
 /* Well known logical unit id in LUN field of UPIU */
 enum {
     UFS_UPIU_REPORT_LUNS_WLUN = 0x81,
-- 
2.43.0


