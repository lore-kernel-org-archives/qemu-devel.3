Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F064D2595A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 07:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkdkB-0006T3-SZ; Tue, 27 Jan 2026 02:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vkdk8-0006Q3-2X
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 02:44:09 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vkdk6-0001SQ-Hn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 02:44:07 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c551edc745eso2090639a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 23:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769499841; x=1770104641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mWnDD5SJ+mK/oOvrr/hkXv8rhYdC10I/M+F85M/QDUs=;
 b=UlaugwucOS218tGyvQE3poKbXGBbtIfb/CcxkMMVjmqs9kELhXOW8jR7mADrl/zWBO
 cFel8r5UZ2s3zTEW318pX9nDjtnGhZ9w63gMvCsObz40tyq2wWNNvx/ocjkwo1jT7EXf
 dG7PquGc07NlyboqNCSPjVZDUYAbGEFv+CalXuczgZncwE5+AFK6m/JILHWA3ah6XBLd
 IfTk7qFfp+rJnJnaFpkHpTgRLvPVSBqCtr645mUcJ1yOUiO7HFyuPYvBwHLT4mmtKXMb
 01yDqheRtaYw6jMIto5ms+BNyZVC7fQOwWWR0l39qj0CS2c5pRX/cXPrIO454FbBckQR
 SWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769499841; x=1770104641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWnDD5SJ+mK/oOvrr/hkXv8rhYdC10I/M+F85M/QDUs=;
 b=I60f0ELSz5xiTRbMAJz1E2q1jlFd/Hl4wgPtcLEGtpoyjuq3FXykVuYg1ZGcpgtngt
 FP4c037Gqqt+OjiV2XBL7IMDDPBwkwoOFMsQpgTHemMs0xRppDT48OzfFK5PegNtE5d0
 QD4Cc1DCI8Al23+9V4A7puD0eFmwRsA40WOz4XZibmL/m2p9p2GsFP3/3kwBXgtI3IQ5
 e7keBnphbgtuw6voXPOmDfNPpKmrY7wax3TxYH9bgb6bxfadrnvo9OhePfgHbcjTkGjP
 cvNKCWmWB5bOYyei4kCFTaGWweG8EiUKiDAE4Ofs+9PDwNUcQ2qzgkAwXYOVusfYxQUF
 piWQ==
X-Gm-Message-State: AOJu0Yyu2W7HzhbTu+Pi2PfMap3GPhk6Z6g3aIvpLtwd0MjCgow8Hlnz
 hdNlYJpmgN1/h0mqCgWassb9zGX+G7PLtexEiVqqxbeDccugNTJzPnknk04J9A==
X-Gm-Gg: AZuq6aJeN2uTSEPu6yQpeS2oOEDbCaRo9UXIJqsf/dbSKVyxMngNp5e1CC42PTj06lW
 yIhRgLYzYUNe/MQYiZ8g7O5xF0GcQFjGpzZNXEk7KrcnqrJZ5L869eBNdFn8mM/5aEnSBTBMOXa
 645ISxgNZqT3ypqsdCxfUHGdr3r7TjsrLM/uDknSvsQUGqm48k1suxltYDjLBuWRU+yjaw+1Xgk
 B97Dw4vOSlO3fk9Mqrjj9S9qVSgmZN8US6MJanwlIamjmEvkefjrAwQk6y1fvh5Y608QThqP4xj
 Z3WjKSb+NuqhHLMpAgNtsFur+ceqvdsJTyowEICYNfqYJkr35dWdHfMV9ZKUXCJvwIsfm/tO78S
 Q0b9/9w86Y6nFKIeFmLBoUeUvPMCQB+2HpHI6tsdtIIvmT74Hl6GskQQhilDRQOE1WD1AhDs7ol
 HRMojFVLNdZm8hcoa6g+WLRLDUO5Y=
X-Received: by 2002:a17:90b:35c4:b0:341:8ad7:5f7a with SMTP id
 98e67ed59e1d1-353fed74b59mr936893a91.18.1769499841470; 
 Mon, 26 Jan 2026 23:44:01 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6206386sm1602337a91.15.2026.01.26.23.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 23:44:01 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com
Subject: [PATCH] hw/ufs: fix CQE endianness and UPIU length
Date: Tue, 27 Jan 2026 16:43:41 +0900
Message-ID: <e646881c28fb496502fecd37a6da8e976f91931b.1769499684.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x529.google.com
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

Round-trip UTRD fields through cpu_to_le/ le_to_cpu when building MCQ CQEs to
keep BE hosts correct. Also avoid double BE conversion of response
data_segment_length and document the LE round-trip.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c         |  3 +--
 hw/ufs/ufs.c        | 27 ++++++++++++++++++---------
 include/block/ufs.h |  2 +-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 2d8ffd72c5..3f3c9589ce 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -53,8 +53,7 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
         response = UFS_COMMAND_RESULT_FAIL;
     }
 
-    data_segment_length =
-        cpu_to_be16(sense_len + sizeof(req->rsp_upiu.sr.sense_data_len));
+    data_segment_length = sense_len + sizeof(req->rsp_upiu.sr.sense_data_len);
     ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_RESPONSE, flags, response,
                           status, data_segment_length);
 }
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index cab42ae7b6..043c35e68f 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -448,15 +448,24 @@ static void ufs_mcq_process_cq(void *opaque)
     {
         ufs_dma_write_rsp_upiu(req);
 
-        req->cqe.utp_addr =
-            ((uint64_t)req->utrd.command_desc_base_addr_hi << 32ULL) |
-            req->utrd.command_desc_base_addr_lo;
-        req->cqe.utp_addr |= req->sq->sqid;
-        req->cqe.resp_len = req->utrd.response_upiu_length;
-        req->cqe.resp_off = req->utrd.response_upiu_offset;
-        req->cqe.prdt_len = req->utrd.prd_table_length;
-        req->cqe.prdt_off = req->utrd.prd_table_offset;
-        req->cqe.status = req->utrd.header.dword_2 & 0xf;
+        /* UTRD/CQE are LE; round-trip through host to keep BE correct. */
+        uint64_t ucdba =
+            ((uint64_t)le32_to_cpu(req->utrd.command_desc_base_addr_hi)
+             << 32ULL) |
+            le32_to_cpu(req->utrd.command_desc_base_addr_lo);
+        uint16_t resp_len = le16_to_cpu(req->utrd.response_upiu_length);
+        uint16_t resp_off = le16_to_cpu(req->utrd.response_upiu_offset);
+        uint16_t prdt_len = le16_to_cpu(req->utrd.prd_table_length);
+        uint16_t prdt_off = le16_to_cpu(req->utrd.prd_table_offset);
+        uint8_t status = le32_to_cpu(req->utrd.header.dword_2) & UFS_MASK_OCS;
+
+        ucdba |= req->sq->sqid;
+        req->cqe.utp_addr = cpu_to_le64(ucdba);
+        req->cqe.resp_len = cpu_to_le16(resp_len);
+        req->cqe.resp_off = cpu_to_le16(resp_off);
+        req->cqe.prdt_len = cpu_to_le16(prdt_len);
+        req->cqe.prdt_off = cpu_to_le16(prdt_off);
+        req->cqe.status = status;
         req->cqe.error = 0;
 
         ret = ufs_addr_write(u, cq->addr + tail, &req->cqe, sizeof(req->cqe));
diff --git a/include/block/ufs.h b/include/block/ufs.h
index ede4aff08e..04cb24324d 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -645,7 +645,7 @@ enum UtpOcsCodes {
 };
 
 enum {
-    UFS_MASK_OCS = 0x0F,
+    UFS_MASK_OCS = 0xFF,
 };
 
 /*
-- 
2.43.0


