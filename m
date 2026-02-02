Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EEDD172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmgy-0003uE-Ut; Mon, 02 Feb 2026 00:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgu-0003tJ-Ru
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:41 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgt-0003yW-7w
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:40 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3543b9f60e3so1386555a91.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770010897; x=1770615697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orTLrOWeKTPyvS26NEmXloq5PzOs+hNT/pDvq4j4jF4=;
 b=ntoQVnkl/1Io/2tNgYW5R4evF7vsT6iSvUaVJ1AIJrsJo+qB5AxO1aaYX5Zgew0KLc
 KOzEv0EaN1fwVQB8VnzmVcnB1vnU9rngNWjsogBnQaFX7Axiwdru2rf0qoqoKVAeFmrf
 4kRqGI0+egJGkQzQmgQxnbnL7ppkJMAF05XaFZRDl5+VuvDKKqWJG+7x0dIwYzYhM1fv
 ebSX8ZOH4ZikVbhZ9PKNrLw/+p+UyVEwOyGM36hRSmJRsRLMje43z6s++1dSDhR4DfKL
 RWNlDWuRJQN6fr4Vqho4Vw9QwmDaKOWHqL7j+Wi9q+kyLioX6sPfvCdycV7/q/YHNYzj
 0VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010897; x=1770615697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=orTLrOWeKTPyvS26NEmXloq5PzOs+hNT/pDvq4j4jF4=;
 b=Ox6Uwc01yqGnKvedTzYBb+Z06Xoa/XTE/dpxTlYXbBmonZD9QLpVNKE16ZdeM62dYh
 kUcm2ItYhFV2y/g+lT5iLcbv0q8TM9Unk4uQI5QFC2Cb3J/0hCjwG3gSMnK06c3YPZFO
 0wG4oW686bQjjvsNId9Buai/nuPtB1NOb0AkZLf7nP+xJEV3Ga1yA4R9Ban2wcHT4U5V
 z6Oyz/wxXn+lH0ZHidXLkpKLv7Vczn89pEYEqaQ3ypUx5GBy/jmatTNztRTIN/+ixmDW
 +E46/efVKF92PWJ/53v5YYRLWW4OiXRRVSAv7Dw7SmccTlPm/s2s9W1D7K56i9V/iIj8
 RbtQ==
X-Gm-Message-State: AOJu0Yzr5amGuwFuUAbCynEA831U61aIX8RJtujcqgUSegill/ALApV7
 DRACo9g0mrPXzJ6w1BUHxFF0/yMDvGgtONfCD8IjiiV+P6xcuPr52ICJIrRnlQ==
X-Gm-Gg: AZuq6aIY4kHvGtyAKhgCLjgHP05RBpA36T+GdLnzUEH5nj9iKnG396IdUHpqSvVL4jB
 I6ElSo5gXLczsIIesBa65hII113P03ReRorcbR2qylznCqj0kJimRxvr9eR4EoGk7xMlj4sA6f/
 3nSogXOpboNYLZKcaykFqSz1qxB0XptkVPOdmpLxSy+43CP/6e8RqPRFddK6r0z0cBcBZE4aa8y
 gAIL1aijaompDPfCnWJQVpNSlZnvN9rGEiHPxt4oo9opf/oTHjtAhWp3lvcDpmsqdC2BptjOGTc
 klVmOPO9reECq6xXZZ1YYDDLsN0lQ+gbrcgzONIw2uPyinqk9h7HcWr9QF22xXxiVM2dyd1kU+D
 8X4sVVa0X6SZlOW2Ig0+Uis3IvN96WKSk0DOFjfbxl9FSGFbAC8uWCz6WyntPy/QlcBH3LOjhha
 7CSCE030iibJrnnA==
X-Received: by 2002:a17:90b:4a09:b0:32e:e18a:3691 with SMTP id
 98e67ed59e1d1-3543b3f34d6mr10177956a91.35.1770010897460; 
 Sun, 01 Feb 2026 21:41:37 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f610266esm17804018a91.4.2026.02.01.21.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 21:41:37 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, jeuk20.kim@samsung.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com
Subject: [PULL v2 2/4] hw/ufs: fix CQE endianness and UPIU length
Date: Mon,  2 Feb 2026 14:41:12 +0900
Message-ID: <ed621cc8e2a6dab2663ffb02e875f896f521bee2.1770010668.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770010668.git.jeuk20.kim@samsung.com>
References: <cover.1770010668.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

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
index d3f08f2ba9..9cf7eab9b0 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -449,15 +449,24 @@ static void ufs_mcq_process_cq(void *opaque)
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


