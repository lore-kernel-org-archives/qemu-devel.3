Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D30C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenMk-0003KV-Pw; Wed, 01 Jul 2026 01:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wenMj-0003JE-2Z
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:20:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wenMh-0005kp-Co
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:20:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-37ff436a048so110898a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782883202; x=1783488002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7DgfKtIIuZN/S4bX6pSCHG12N0udvrO3Ki9DWUDg40=;
 b=KTC3+O8VljqxszUzq8OGv1PaebnDMr8gpoTpF+ys+ULXgmJko5zkEY58h+tqOiiS+r
 Cu7ERAhlI4TC689AtZvr3hEwDh/8VRHbN/fSadcBj+VO7b9YeIUwXN+nk1OnrCOC/Zm+
 1ZC37n3Tkl7c+1ULMzES0mb65tFr/i5V6UQsCUZMP7Uh6vakhQlmWT6w1fiClw5bnZi+
 o0IMvhg5mfWEKaaktkQlS3kjLrO0dWb/JqSohfF5QYruAl4pAO57kDrQPwVwqwpf9Ud+
 zowzc4nlhqL6Cg+vYxBaStjIN7mi/TmsOxzPP0sPPlAh34ZMjDP9qdPLJC7VrCNkdE73
 8+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782883202; x=1783488002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E7DgfKtIIuZN/S4bX6pSCHG12N0udvrO3Ki9DWUDg40=;
 b=G/E7Itpuj/lgq0iXm0guRqUqBVFOYvvdPaB5wP9n699YPvzU7QKv1UC7jBMJ3GdEGD
 j3B3KD/H2Z4KP3YVcjblsU6ulHMWun82wIGUo3MQI7KiYt9IF4LqPKgOj6HIvKpWgK3b
 Plnl02xUonyl1YTeZw2KRPxggsAcr5LSrgkRU64+Ow6sBXdR7qDJh6DgJsRcH6cMii4D
 2NEll55Ruw2A7+wMMi8Nx7iu+fVtqLpD/x2IS4Z8EuO7JxLd4AaesE39eiJIxiYe+97C
 CwQ1oWHZimp+GIECAehxHohY0B4cZtEf9M4Th0mE8YEJGHoEQfI2rlkNGPed/0xe4VmN
 61cg==
X-Gm-Message-State: AOJu0Yyfzfb+ixMy9wnDk3GSMBQbrF96tUlqjuvVIvn6GTPKVXmpJiFb
 k4qCHIMkuVnWvYQCeYZjd/LT2MgTGED8fBPuKTQQmYtLFxQKsc09SN+Pi+39Lg==
X-Gm-Gg: AfdE7ckeIESq5x/XMKMTLjKFBIgLV93vsmA7LsyNS3BhxwPXFVfeFHv6fAtqroip6ae
 aK4tCSoJWI8WbTKRbNFscGJraFm1Z1rXFBrO8G4yX37eO8wVCIAZtE6RErJOVisf6iJHBrRCbJG
 HhaNtf02+cJtA/fsAPYiW1KHQJwsqnqTVkuerqDWRKFQ7ki95QzPoW6zF4/XJcXFgRYGrC6fkG3
 8cXdd5gd3sxB8AoHih54bYJeuiZXIGk7jigB9WchRk91qjR0vf5bUShDKk7NaT/KcJ1sNhY8trd
 kDB0CNkbpGZLyZkKuI5q5ctey5nMAEt2ltP4YCTod9TTI+sQC2tQXLhGylyD7gCdMDNIiD77bqt
 ElYQfaio9JeqU++MbvuHlKQorqcTMw1hZEnd/Gcl78cQ2DTHi92uZ9COoxAoUPNPZolt6ZVOIeI
 bkw5DV89kzwVVJf+IwI/YlCYdTnVY6
X-Received: by 2002:a17:90b:224c:b0:37f:9ce1:736b with SMTP id
 98e67ed59e1d1-380aa21f261mr200576a91.33.1782883201857; 
 Tue, 30 Jun 2026 22:20:01 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095d4c263sm1098157a91.3.2026.06.30.22.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 22:20:01 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 1/2] hw/ufs: Emulate DME_GET/SET for PA layer attributes
Date: Wed,  1 Jul 2026 14:19:46 +0900
Message-ID: <e7644f123b1e1332b34d794a0254122fd3d2a31c.1782882742.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782882742.git.jeuk20.kim@samsung.com>
References: <cover.1782882742.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

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


