Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A096CCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjCf-0002au-Oz; Thu, 26 Sep 2024 03:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCe-0002VT-GZ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:20 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCc-0006Ic-QU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:20 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e0438e81aaso468314b6e.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1727336777; x=1727941577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUQGygF7ax3lHkGrG99vLN6/xen2jiCuqCocfv+MI40=;
 b=T2IAEscdbIYIiJgfBxFkydr0ifnCv775ZeTCoh2aVyBgckyA+V7+OnA8oWi8Puu7EB
 I7lPAliXEDwiNNoBnpOkH3nrt9VE4niBFThvNIWiRcevrzgmK6h3vs6306R3hug7jRml
 TywXVtNlmVvGmIXuSkw4izdfAxRbGdMjMhGywJmiQ2SdC4rIAiojY9zVKjhNwlXT5FwO
 ImHoBZ4Yah9rH0a7tWySHLKr9L6Rh/NiHwauVDB9mWRnmh2Hnq+vc7iRWveR9lJeBlO0
 N5G03HBCREUUhhirWr1wEDinRj40G2INrK94zlGPjly0cOaTPWH/AfgIJffopL4njd+N
 iMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727336777; x=1727941577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUQGygF7ax3lHkGrG99vLN6/xen2jiCuqCocfv+MI40=;
 b=ZvcTcvT0mdgfd7OutfwrHSntLw4FKlUaoAjlNNDYRJESTnwSzImmdnR9H2AZzl91WM
 aCr6stJaW7ug1ms/2KFL2JaQNXuXIM36FI2n7YaW0bAjMa4M3twP24zcaCwxOh+u/qiR
 Ji1XMPvtXlzpDloNq0Jh7pDiUoxm9emohEv6yF9XYpelnqbrNtwQ+mP9wdm/GIZDVkK1
 Z6xWzWuRMOB84zmOiS2pXAVfCWIpIq8oSXzCBkYqyRtgV8gOIyB6CoMPUkSHrVn5Kvry
 4Sm94h6xj3iWF2TcGiSaiodLQA2Ba2FvjZsd8AFDW2aj5mhhFjhKsskvxXyDuR+JaTYr
 NDoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0LV2QKipQ2jVKsaUp5jYcnS2bMiF+s9dZxsrpiJFSKZy/fdkRjS5bRVfaY5PlhD9ILm9w2BxGxGTX@nongnu.org
X-Gm-Message-State: AOJu0Yxh+LrbD/y2fh6j4LO6IhM+1ZTaguOen1C/F5flz6+zcmzGApjb
 1zCmNTlQxxz5ha4ZPyOvQXhyLOU4xbjdfgaDExrGsDUQZ8viSVbOjyVQ/QCRrzg=
X-Google-Smtp-Source: AGHT+IGf69u5raL3iBKrb9MzGNmA+bZM+y4vR87jUxHw/D8svMvXS7iJG2BZj3TB2ZRMdf+rrXhOZQ==
X-Received: by 2002:a05:6808:1a13:b0:3e0:4674:79c7 with SMTP id
 5614622812f47-3e29b80f8d9mr4888085b6e.39.1727336777378; 
 Thu, 26 Sep 2024 00:46:17 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6b7c31bb5sm3683357a12.16.2024.09.26.00.46.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Sep 2024 00:46:16 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v13 04/10] scsi/util: add helper functions for persistent
 reservation types conversion
Date: Thu, 26 Sep 2024 15:45:40 +0800
Message-Id: <20240926074546.24507-5-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240926074546.24507-1-luchangqi.123@bytedance.com>
References: <20240926074546.24507-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This commit introduces two helper functions
that facilitate the conversion between the
persistent reservation types used in the SCSI
protocol and those used in the block layer.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/scsi/utils.h |  8 +++++
 scsi/utils.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d5c8efa16e..89a0b082fb 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -1,6 +1,8 @@
 #ifndef SCSI_UTILS_H
 #define SCSI_UTILS_H
 
+#include "block/block-common.h"
+#include "scsi/constants.h"
 #ifdef CONFIG_LINUX
 #include <scsi/sg.h>
 #endif
@@ -135,6 +137,12 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf);
 uint32_t scsi_cdb_xfer(uint8_t *buf);
 int scsi_cdb_length(uint8_t *buf);
 
+BlockPrType scsi_pr_type_to_block(SCSIPrType type);
+SCSIPrType block_pr_type_to_scsi(BlockPrType type);
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap);
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap);
+
 /* Linux SG_IO interface.  */
 #ifdef CONFIG_LINUX
 #define SG_ERR_DRIVER_TIMEOUT  0x06
diff --git a/scsi/utils.c b/scsi/utils.c
index 357b036671..0dfdeb499d 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -658,3 +658,84 @@ int scsi_sense_from_host_status(uint8_t host_status,
     }
     return GOOD;
 }
+
+BlockPrType scsi_pr_type_to_block(SCSIPrType type)
+{
+    switch (type) {
+    case SCSI_PR_WRITE_EXCLUSIVE:
+        return BLK_PR_WRITE_EXCLUSIVE;
+    case SCSI_PR_EXCLUSIVE_ACCESS:
+        return BLK_PR_EXCLUSIVE_ACCESS;
+    case SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return BLK_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+SCSIPrType block_pr_type_to_scsi(BlockPrType type)
+{
+    switch (type) {
+    case BLK_PR_WRITE_EXCLUSIVE:
+        return SCSI_PR_WRITE_EXCLUSIVE;
+    case BLK_PR_EXCLUSIVE_ACCESS:
+        return SCSI_PR_EXCLUSIVE_ACCESS;
+    case BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case BLK_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap)
+{
+    uint8_t res = 0;
+
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX) ?
+           BLK_PR_CAP_WR_EX : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC) ?
+           BLK_PR_CAP_EX_AC : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_RO) ?
+           BLK_PR_CAP_WR_EX_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_RO) ?
+           BLK_PR_CAP_EX_AC_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_AR) ?
+           BLK_PR_CAP_WR_EX_AR : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_AR) ?
+           BLK_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
+
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap)
+{
+    uint16_t res = 0;
+
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX) ?
+              SCSI_PR_CAP_WR_EX : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC) ?
+              SCSI_PR_CAP_EX_AC : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_RO) ?
+              SCSI_PR_CAP_WR_EX_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_RO) ?
+              SCSI_PR_CAP_EX_AC_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_AR) ?
+              SCSI_PR_CAP_WR_EX_AR : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_AR) ?
+              SCSI_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
-- 
2.20.1


