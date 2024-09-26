Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DDECCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjCf-0002Y4-2V; Thu, 26 Sep 2024 03:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCa-0002Dq-ME
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:16 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCY-0006I1-18
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:15 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso2371855ab.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1727336772; x=1727941572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=K9Nm+AP8WJU6sC0zMhrANyw/yC7PdC2l6XiquIVcoFwm9Qjp9VM4bJ7qbVW+j4oLIO
 ExHo1VzcPWO1hQ0I9NBDYrxwJWud97EO2Kw1UQwJLAd9GUjNC6Gd8FSQQHp0ukJ0nF81
 fhhjy2iZKk1RrK2wMDM0JYoosrcYrIsvMpEjwKxFEVI28bsuSuk+ntsLhjAuNKHPUPeX
 7rU2W1pLiX0O9MOz8iNIcdkaeJKQ0NoklPhY+d6ZBTD+qnXJqfYfqzIol2DUMyOGw2IH
 DtyfEnNIQOqjyu/55mRGmRPPB7FqEZsyjaJh30q65MA8ShwOgzOQw+UAhYWvXN96WRAS
 yVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727336772; x=1727941572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=BCQHl7n0lNN69mqlkbZ5ZeSQlNHUSmJCs6IaMixHlVQL4Lhtl5VLENxOsMGxy8Movl
 wY7e/vy62Ijpa+wU+jhYu3Am7Sfn+hTOqn0H9r/8BmTJLMSCavsbD727SJX6d64vP/yb
 P5JFJAT/1g5RoogEn6zAFZS6PlbwlE1FaGYFSc8e4lGY1qMDrhBi0X3wqrSVBwaGtZ9t
 Xjkzvu4RNMrMqWFSd4YNLB9fT5v+QRtaspfKpJ/txCK6dEfgbhXcSfB9AvEqYhNb/YLA
 jVzA30INrdLD4INidwAVdnLu3vGM6ZbjobGwA5izfWOi4leQtb5PKgFM/ioy1h+nBOry
 ebAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk/q8Yt1HFnwPq5Ydd97KpGxR7ff6KOpxe9yEFbAANKRbUYr0XKR44yyHyGIlxqTSRLNlQ9sOOLTiE@nongnu.org
X-Gm-Message-State: AOJu0Yxu5T7OXbd9W5c01xmrd8Z5oOSNvTnoYVlsiaiLJOzlOpvEI9lJ
 ZNeQ15YJWNHR1aHoWYFcem6dwuonK/WUMjkNXbVR/PJcdq92RySfqtVNNLpzg1M=
X-Google-Smtp-Source: AGHT+IEpAmv06Gf0mzPGV/ORRI5V6+PZ+xJch8olRZGda6+T7LZ713G4v1kdnfcbBOFbjAeO7zJU8g==
X-Received: by 2002:a05:6e02:1a09:b0:3a0:4c4e:2e53 with SMTP id
 e9e14a558f8ab-3a26d6fa5c2mr48895805ab.5.1727336772462; 
 Thu, 26 Sep 2024 00:46:12 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6b7c31bb5sm3683357a12.16.2024.09.26.00.46.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Sep 2024 00:46:12 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v13 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Thu, 26 Sep 2024 15:45:39 +0800
Message-Id: <20240926074546.24507-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240926074546.24507-1-luchangqi.123@bytedance.com>
References: <20240926074546.24507-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-il1-x130.google.com
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


