Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738F2C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0fK-0006PJ-Is; Sun, 28 Jun 2026 21:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1we0fJ-0006O8-2m
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:20:01 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1we0fH-0006xJ-BB
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:20:00 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-37defb2f231so1342735a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782695998; x=1783300798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ylxywxoedFTkpMsEthG2TEK4ilDb79rVUbl9rZrdUM=;
 b=Bf0b1RNzU93/DA7USHdgG1VKMa+yP7PdsS7BIwJVDgsjtK+yAI+L13swEbwq6tNELV
 axLEJwFSwezpJY6GGNhaQBBjMPJGtbZxFjFhNwuQCzyIVAomLFHej629rc61VEoFBpXh
 KvjQ0Y2HLGkuhhGU2B8K7mQ+vpSkvJsqZ3uDcH/aId2qzAz2ijIqAYkoi5aIVjxSyz/Z
 bu6fyZmXi3JtKO5EamgfKxP/avDqso3TVAVs4ej5Q3BVUfDBP0x7oTHHM23fMdS0IZ9T
 kC6uNTdXPIL3uF445HwCC6QfYAXTKjmexftz35UjvFcBAckfqtIp7OMgo12+AQV3EQtD
 mQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782695998; x=1783300798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ylxywxoedFTkpMsEthG2TEK4ilDb79rVUbl9rZrdUM=;
 b=YZg+8kSoYbDh2t32Z59UmVmJnAJbl/wiXUfu/1WNns/0MHmExrlzG+MUjlp+qDy/F0
 S/AoM6xAjfTxZ7lytY4ciOJBj9jB3XFDjgosrBPw1ENeVEH5vFEy/19LXFj0sDQQ8vj9
 klvdfBLw4U+xB4YDV9mDPPrbw5lxYLhbhXmxD3OobCX6Kfc51OolDp9UBQThIYaCNpFU
 fYW0pH3QWts1PEgt94ALTWRF+GFGb9z05qthUN0RM6FtkfwRkdFbRZH0GN9jPb4/XFCB
 WpxDUialUO4Fmkfh5iRGGQOGxuleqbiShYbHiO2YB1DGa+147RUVtA8luqnZfl4oUpL0
 +Gbw==
X-Gm-Message-State: AOJu0YxYwwbrn6iiHG90BkIVPPm+uLORNRW1MOlOYKZi2Oke+f6IcVJJ
 PU4uK98BDeMqrkPZA2nZZJVxxLp07DCMPbMMIMORm5p9W3QMMEB9P8VB2eDWMA==
X-Gm-Gg: AfdE7ck+ek/+KfqsAxEuH9zUWKtVNJmXsUAtxIn4n4fnhY+waBIIvNi8NPD2oTbT+tz
 kocPiYMQsi+RxjLeISE8hLf6hkqLc/F4SP4uEUBTMjfEvHzMB55vOtvlGfpJNTUZWQDONAqZ17r
 l0qPRY+BvirXNtSir57FfR6Ibv9L8CvFVR+cgowHO3A6KI1ZI721X1lEZJD4xlvfTXCkttPmIDZ
 sdaytZR9dPTdePLQD/QL7dG/6YYpggDgkaIZbfC7ZyTszbP4Y0SpMXLqKz76K4bgv7FMmifR+eY
 18Evh2k2t3+ZBU/JDFd8fnKT2yszO11OYGLO0P0GPthJqRLxCHIF/Us1z5BxDNJhf4bw5so/HsW
 Avv3wX2D5M77iLn4OSxrlpmohwG21cOsWGlI2GBKadpbeZEtBV5HR3ZIpQt4AOcKYejSZYYtQ4b
 O8czNJGbwp9CbDx5id8zh0
X-Received: by 2002:a17:90b:4fc1:b0:37f:d9dc:557 with SMTP id
 98e67ed59e1d1-37fd9dc06ffmr4422591a91.16.1782695997639; 
 Sun, 28 Jun 2026 18:19:57 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e24b13458sm4614058a91.13.2026.06.28.18.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 18:19:57 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com, jaemyung.lee@samsung.com
Subject: [PATCH 1/2] hw/ufs: Emulate DME_GET/SET for PA layer attributes
Date: Mon, 29 Jun 2026 10:19:34 +0900
Message-ID: <89a53700d3dafa26b0fade96ec139ea4dc42ab5b.1782695631.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782695631.git.jeuk20.kim@samsung.com>
References: <cover.1782695631.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102f.google.com
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

After DME_LINK_STARTUP a UFSHCI host typically negotiates the link power
mode: it reads PA layer attributes (connected RX/TX data lanes, max RX
HS/PWM gears) via DME_GET and then issues DME_SET(PA_PWRMODE), waiting for
the UIC power-mode-change completion (IS.UPMS / HCS.UPMCRS). The device
only handled DME_LINK_STARTUP and DME_HIBER_{ENTER,EXIT} and returned
FAILURE for every other DME command, so a host that performs power-mode
change could never complete it.

Return canned PA attribute values (1 lane, HS-G4, FAST_MODE) on
DME_GET/PEER_GET and acknowledge DME_SET/PEER_SET. For DME_SET(PA_PWRMODE)
also raise IS.UPMS and set HCS.UPMCRS=PWR_LOCAL so the power-mode change
completes. The emulated link has no PHY, so no state is persisted.

For example, the Linux ufshcd driver reads these attributes during probe
and otherwise aborts with "invalid connected lanes value".

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 include/block/ufs.h | 12 ++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 35c2444385..ee7eba6793 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -363,8 +363,32 @@ static void ufs_process_db(UfsHc *u, uint32_t val)
     qemu_bh_schedule(u->doorbell_bh);
 }
 
+/*
+ * Return canned PA layer attribute values. The emulated link has no PHY,
+ * so these are purely declarative: a single lane in HS-Gear 4, FAST_MODE.
+ */
+static uint32_t ufs_uic_dme_get_value(uint16_t attr_id)
+{
+    switch (attr_id) {
+    case UFS_ATTR_PA_AVAILTXDATALANES:
+    case UFS_ATTR_PA_AVAILRXDATALANES:
+    case UFS_ATTR_PA_CONNECTEDTXDATALANES:
+    case UFS_ATTR_PA_CONNECTEDRXDATALANES:
+        return 1;
+    case UFS_ATTR_PA_MAXRXHSGEAR:
+    case UFS_ATTR_PA_MAXRXPWMGEAR:
+        return 4;
+    case UFS_ATTR_PA_PWRMODE:
+        return (1 << 4) | 1;
+    default:
+        return 0;
+    }
+}
+
 static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
 {
+    uint16_t attr_id;
+
     trace_ufs_process_uiccmd(val, u->reg.ucmdarg1, u->reg.ucmdarg2,
                              u->reg.ucmdarg3);
     /*
@@ -378,6 +402,22 @@ static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
         u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UTMRLRDY, 1);
         u->reg.ucmdarg2 = UFS_UIC_CMD_RESULT_SUCCESS;
         break;
+    case UFS_UIC_CMD_DME_GET:
+    case UFS_UIC_CMD_DME_PEER_GET:
+        attr_id = (u->reg.ucmdarg1 >> 16) & 0xFFFF;
+        u->reg.ucmdarg3 = ufs_uic_dme_get_value(attr_id);
+        u->reg.ucmdarg2 = UFS_UIC_CMD_RESULT_SUCCESS;
+        break;
+    case UFS_UIC_CMD_DME_SET:
+    case UFS_UIC_CMD_DME_PEER_SET:
+        attr_id = (u->reg.ucmdarg1 >> 16) & 0xFFFF;
+        u->reg.ucmdarg2 = UFS_UIC_CMD_RESULT_SUCCESS;
+        /* DME_SET(PA_PWRMODE) is a power-mode-change trigger. */
+        if (val == UFS_UIC_CMD_DME_SET && attr_id == UFS_ATTR_PA_PWRMODE) {
+            u->reg.is = FIELD_DP32(u->reg.is, IS, UPMS, 1);
+            u->reg.hcs = FIELD_DP32(u->reg.hcs, HCS, UPMCRS, UFS_PWR_LOCAL);
+        }
+        break;
     /*
      * TODO: Revisit after PM implementation
      * Power Management is not supported in current QEMU-UFS,
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 6dd91181e5..66e8f35c0e 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -628,6 +628,18 @@ enum {
 
 #define UFS_MASK_UIC_COMMAND_RESULT 0xFF
 
+/*
+ * MIPI UniPro PHY Adapter (PA) layer attribute IDs accessed via
+ * DME_GET / DME_SET / DME_PEER_{GET,SET} UIC commands.
+ */
+#define UFS_ATTR_PA_AVAILTXDATALANES 0x1520
+#define UFS_ATTR_PA_AVAILRXDATALANES 0x1540
+#define UFS_ATTR_PA_CONNECTEDTXDATALANES 0x1561
+#define UFS_ATTR_PA_PWRMODE 0x1571
+#define UFS_ATTR_PA_CONNECTEDRXDATALANES 0x1581
+#define UFS_ATTR_PA_MAXRXPWMGEAR 0x1586
+#define UFS_ATTR_PA_MAXRXHSGEAR 0x1587
+
 /*
  * Request Descriptor Definitions
  */
-- 
2.43.0


