Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5993AC7EE3A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 08:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjak2-00063b-BA; Thu, 29 Aug 2024 04:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjak0-000613-Dp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:52 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjajx-0000Bl-Ew
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:52 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d3da94f059so294608a91.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724920968; x=1725525768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=MS23l1PTN2U9D6x/mEKT45kwkLRZxPD6GNHnUqS6lhdZ4dHZHixlJhvGOnl87GUZEN
 Pc3NevA3YVHAkg5EV7bHuKpHEbU10Npdtmaph+qy8mnIN3K5PEplBVkpBCQC4/Y0171f
 2R71iEDoVkaKwnKDxlkvwOtm2MfDM7auUdhjPgZvSOFb9r7XPkWqNMMt23R/8nsLGAGE
 2aksEEqohXK5En9Gmt1PzCXx909Le+VORv1DSqVkljJgA62ic7zb/8/kvwa5NEYMhq8W
 Ve1VZm9P99vIauiHOWE4UX04WhOooZaHlIFAoN1z5ieudzIyzc6GbPAlF1qW0nQrfg6s
 qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724920968; x=1725525768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=P/PenA0PBbofWnNBK6GC1D7n/nOn+r3E9A9JBjphjCxlKlziWEuWu3/AdXkR84tbc9
 Zk2Wu+KQnwShtXKiPG7XFgJNkbE4zDBOGyD3McOzoKfR49pxcbii/ZEaIAvoTK3moq28
 leV8iYQZ5McSZuHyYExWKYLctxSSzqobgcPp6j+aWgV8qsatguxCEaqbSs5Qyemgm60B
 ezUXDEH7qAaqB7zTrzMiVwzFrXJiku3988UmDZDxqT+/hRhqJ48pWM97FtPNh80xCfow
 EJmYYSX3w3KK4WlF7kneV0e+R3xd7POJGEac865UR8Ts3by3W6fhnNkxwayFFSinioA9
 hG9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTpvFLIAamapfbxOYrqvFjKtiH7dMMqsUr8wjTmWqbj9I7oM07pRu6vExOEuKxodMGg9jTx2EFl7PY@nongnu.org
X-Gm-Message-State: AOJu0YzkcdosPFOdEymzW4lw3BqOP8DM5e3mqvwB1Jzs8obZyzl/8vn1
 QIwKHKZ9RYUIbZmcnJ7yEPFfmRn16Lam514mB9zWodN1OvioFf2PW6Pf22ZYyxpFQBY4/XcCDVc
 q
X-Google-Smtp-Source: AGHT+IFp5X09+4k7P/wVbY1Fq6vN6Aw6Qdaaeeho14llkQJcASFXQsaQq7/aTzNOTlf0+NZUXzdpvg==
X-Received: by 2002:a17:90a:fb94:b0:2cd:3e75:4e51 with SMTP id
 98e67ed59e1d1-2d8564bb8d5mr2110422a91.39.1724920968150; 
 Thu, 29 Aug 2024 01:42:48 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3897sm3431856a91.49.2024.08.29.01.42.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Aug 2024 01:42:47 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v10 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Thu, 29 Aug 2024 16:42:07 +0800
Message-Id: <20240829084214.50548-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240829084214.50548-1-luchangqi.123@bytedance.com>
References: <20240829084214.50548-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


