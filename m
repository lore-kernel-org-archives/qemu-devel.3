Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E0EEB591
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 11:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sohrY-0006Fb-UQ; Thu, 12 Sep 2024 07:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrX-0006AI-FA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:19:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrV-00082k-TA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:19:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so738951b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726139984; x=1726744784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=Q2ubT/6a0iE8PFQCcDoSo6fBb11ebKd4u3L/rhXZq6Rxf1fGJ2HxoHogAy2Srs8+w7
 GBP+HQ5at2Xzb0Kr6t/lS5+K5qdH1um9ra9f4L580RPgb2NvC9JsVo+2DQf/KKV2y9hO
 fEntO+Be8gtuJ0TC/NZi7RnhA6WGrqzXS4YOWHdUA5ebX07vNuVH4xWDvWFFaewMdmbD
 4ePMVLW/y1TepNDjyHysBPqW0O1NWtXJcSgMlsV5Vx55P0pz7xgF8atPUP2yj7ady42r
 H0EpBE3haWf/mgu40ZVkYzJqmsIeXpwpoztnVHDX1DgQ7uP6xtq0czI5rB8fboHf05oL
 psEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726139984; x=1726744784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=vH/UfDSRJtX1h+lvkmmhhLTkhO+mBHcSD5vtR3TolQu1QjKTEKxF0pku7nGC9ygmb+
 Wb86yjZO4cKlh9a/6kGaaDFNH1vr26WAvMxR7QeJipXaV0UUptfAKp/HW88y1+stk/3v
 jbw45VtJ3CmAFftL0Yr+8PvzcFJXOFFzja8Mt9U7TcIvscowoIF61y7agZ4u2hkpfEj/
 Gho0DUEKTkPJM0w5K/cqnTxnIXmZVUMAuiFE4xXosvvA3nW2w6OGfV7Q/dlc09zpQQPo
 VZHB6TkISnLcv+kPOe1PSUye94ehaiF1qcRy3AtV7kdfzODyjJFek1UVOc/ynea/Rz5B
 yg7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW2C5GDIO2ZKxhfFz1GgIyhmogSbsPqRqUeuc4WO0dddmJFTi73vZCIQlJe+IhgM5SrfIwcPTcwEQ6@nongnu.org
X-Gm-Message-State: AOJu0YzmFj0NV7cBJ1jC9FjMTZM8eOH52eSfGslNSetd8lGgP2Oja+wk
 BkJe1n5b8wljbpeqB9TGZ3BiO5gCo2zpQ5ux0wSyXFMuaBS8GwSm/xz50+MSbOs=
X-Google-Smtp-Source: AGHT+IESK4YkdFPoiQG/hhm4kfuayC+UDCmVdGLrB7IRJtt5wxPkb3p1KyZRzQwkpnpcu5Nw1ohMhQ==
X-Received: by 2002:a05:6a21:9d91:b0:1c6:fbf3:a0ef with SMTP id
 adf61e73a8af0-1cf764c11e3mr3575480637.44.1726139984574; 
 Thu, 12 Sep 2024 04:19:44 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090afadasm4552072b3a.177.2024.09.12.04.19.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Sep 2024 04:19:44 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v12 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Thu, 12 Sep 2024 19:19:10 +0800
Message-Id: <20240912111917.81477-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240912111917.81477-1-luchangqi.123@bytedance.com>
References: <20240912111917.81477-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x432.google.com
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


