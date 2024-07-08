Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DB0C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 12:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnL5-0001oK-GD; Mon, 08 Jul 2024 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnKy-0001eg-Oh
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnKv-0001V2-HN
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fb4a332622so11512015ad.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720441156; x=1721045956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=B3uiOi1YWXnwg1K17j9yFJc6IQkLXMxByEocB01H6a7rxaNURm9muFPXnEJdjlpDk2
 PSh+VuNkuxX/cKhlTE2gbIp8H7lrqw1VZNzT52ji+spgoHp5cplMOBKwIi99fdTWFRzL
 fpTkhNwYtUMQcUryriL6v/tMm0zcvK1ilw3sTft11unwGdd5oNEG/stnO72z1Buope0e
 BTAVjbKvkUCHkLqRIjheSz1PxyQjsiWhgzpvzUuZP5u8XS20BFhPfgkIyChvupjbh8XM
 fnghkNLe4LCdKJVsXUR+Km4TXvsMHo5Eabb4ZC/cSCSMfcCnN+SiezA7pd4ln76stQCQ
 jInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441156; x=1721045956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=oaPxurqOJSMRveht0gUdCPYHLhVBxhTR8viLCGuCWL9iEud/7bLnOXg1uzUOFyA74T
 JXeEItySYAUHSETGT1JTAZ+zkYxWZtkaIBb2xZ3tuWn+9qTt0ksEpJM+l+h908SyCe/a
 pMN5jAz6i9kH4unTSmleuuCGRPOLbUd0Mdj1CVBTL07w2O9nSX9KTnGWwJDZyrMvLHrD
 en75IJbv4lpTgct1Fol1EFOe0BPPtziaat+EyD3kfMtphhZiZWoh+KdkgdfW6lWYnsnr
 9Azs0RYxC8+cEH/f7wX3DxJ6ZwScPBdH4gr9M4J1hZ6GU2eQP/lTMgD1fSKyI6/y8+kU
 wzqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnsPgsvQJaDJ9nyVyh+S22BIaZaTBQFUFbeUMvLRvqyzxsNGHFtFJODCUnHtHxddFY6guaXmzQt3M74Z2TrSAU248pHic=
X-Gm-Message-State: AOJu0Yz20AfXbss3Dc7ZWSgbYVzxKRKQjt5fV7FYqineeVKuKAgPuO0U
 7/YRXnskbJKtTFs5uxacM2WFufVsvsNdM63Le9HmtQ5262dInd1TSQzRBSxRRCE=
X-Google-Smtp-Source: AGHT+IG46Bls/9wpRXGHLHqho8vwDOq1wJ9eRiv3pu6g874BQyp4DKA2aal9H0g2bus2NwCkgjJo4A==
X-Received: by 2002:a17:902:db09:b0:1fb:4a21:8d44 with SMTP id
 d9443c01a7336-1fb4a2191b9mr49788625ad.12.1720441155862; 
 Mon, 08 Jul 2024 05:19:15 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.49.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb4fa258f7sm56587195ad.169.2024.07.08.05.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:19:15 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v8 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Mon,  8 Jul 2024 20:18:47 +0800
Message-Id: <20240708121854.1318876-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240708121854.1318876-1-luchangqi.123@bytedance.com>
References: <20240708121854.1318876-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x633.google.com
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

Add constants for the persistent reservation in/out protocol
in the scsi/constant module. The constants include the persistent
reservation command, type, and scope values defined in sections
6.13 and 6.14 of the SCSI Primary Commands-4 (SPC-4) specification.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/scsi/constants.h | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 9b98451912..922a314535 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -319,4 +319,56 @@
 #define IDENT_DESCR_TGT_DESCR_SIZE 32
 #define XCOPY_BLK2BLK_SEG_DESC_SIZE 28
 
+typedef enum {
+    SCSI_PR_WRITE_EXCLUSIVE                 = 0x01,
+    SCSI_PR_EXCLUSIVE_ACCESS                = 0x03,
+    SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY       = 0x05,
+    SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY      = 0x06,
+    SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS        = 0x07,
+    SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS       = 0x08,
+} SCSIPrType;
+
+typedef enum {
+    SCSI_PR_LU_SCOPE          = 0x00,
+} SCSIPrScope;
+
+typedef enum {
+    SCSI_PR_OUT_REGISTER                 = 0x0,
+    SCSI_PR_OUT_RESERVE                  = 0x1,
+    SCSI_PR_OUT_RELEASE                  = 0x2,
+    SCSI_PR_OUT_CLEAR                    = 0x3,
+    SCSI_PR_OUT_PREEMPT                  = 0x4,
+    SCSI_PR_OUT_PREEMPT_AND_ABORT        = 0x5,
+    SCSI_PR_OUT_REG_AND_IGNORE_KEY       = 0x6,
+    SCSI_PR_OUT_REG_AND_MOVE             = 0x7,
+} SCSIPrOutAction;
+
+typedef enum {
+    SCSI_PR_IN_READ_KEYS                 = 0x0,
+    SCSI_PR_IN_READ_RESERVATION          = 0x1,
+    SCSI_PR_IN_REPORT_CAPABILITIES       = 0x2,
+} SCSIPrInAction;
+
+typedef enum {
+    /* Exclusive Access All Registrants reservation type */
+    SCSI_PR_CAP_EX_AC_AR = 1 << 0,
+    /* Write Exclusive reservation type */
+    SCSI_PR_CAP_WR_EX = 1 << 9,
+    /* Exclusive Access reservation type */
+    SCSI_PR_CAP_EX_AC = 1 << 11,
+    /* Write Exclusive Registrants Only reservation type */
+    SCSI_PR_CAP_WR_EX_RO = 1 << 13,
+    /* Exclusive Access Registrants Only reservation type */
+    SCSI_PR_CAP_EX_AC_RO = 1 << 14,
+    /* Write Exclusive All Registrants reservation type */
+    SCSI_PR_CAP_WR_EX_AR = 1 << 15,
+
+    SCSI_PR_CAP_ALL = (SCSI_PR_CAP_EX_AC_AR |
+                      SCSI_PR_CAP_WR_EX |
+                      SCSI_PR_CAP_EX_AC |
+                      SCSI_PR_CAP_WR_EX_RO |
+                      SCSI_PR_CAP_EX_AC_RO |
+                      SCSI_PR_CAP_WR_EX_AR),
+} SCSIPrCap;
+
 #endif
-- 
2.20.1


