Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CDAC02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3tf-0002Zr-Fb; Thu, 06 Feb 2025 10:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1tg3tS-0002Sr-5N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:34:18 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1tg3tO-0001Ff-UF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:34:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38daf14018eso796600f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738856053; x=1739460853;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLa9j9BRIMQd3YANNi07ZIrVb3mXVRrpXwVepk0Wa18=;
 b=N9EBwGZOD4evHAgfC4aE0CngHrv63tPSt0zz5gxbVgw78x6riR88Zs/Js7/xOi3nbi
 vwP8HXIPY5cTOVZxOm7D9QpZj92TNLQuKBgsTkVSTlOYeQhvj8FhmWXZJ6QyiUJEKVvp
 9/RkdZBI8qEEKbp41GPNReXZX8zgb3sZlRis5EwGhOM5pD9N6Y2SAUAxE6Do6Rvs34to
 lp6C/Mmuo2n45eYPgNtsdmVKjTcfKmLpmiNt6yzwCs6QIRJutdUS/SwTS/eHGlYkg9DS
 5A/RW+HDU+dItFq1y4RnigLC2hAs6Wtoo5b2uoBWhSQtz6MmjS2NSXJWfIHBc74Hc35o
 o2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738856053; x=1739460853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLa9j9BRIMQd3YANNi07ZIrVb3mXVRrpXwVepk0Wa18=;
 b=fMjinH7bwXR/eNkAMX5WthiNgQPnYao7MfSOzOTzkq2mdOYUjhD2FqcUdOQSbrsROK
 TRobbGGIC4RGxz1d6f0COT6i3iaTkos7ON13aTlfG/g3oo1sEzrTz2zL9t6Cx4DloT0y
 GsyfIC0bxIjBBTug2d3JJdVyEYSzfjHckjNTbuM8ETcf7/VLMEihj20gQiLSTox/GsBn
 NtBRez4OxxhlgUEfZ5SmHGi4qI6d1+OAoewedZN3XHY4/9PFKjVP4bSHHHSO9hjJMHgk
 v6f4Ih4zjlqJ1IlyhCIST4MZoSDoT9pY9pldS1GtB4n1P+6RQRUzIgY7JXL/E9IgNoFm
 FIOA==
X-Gm-Message-State: AOJu0YwMO67lyd9DrIekz+GK7dLFCrTMkfBdAvJkFLNIpBYMDorEUHwx
 9bJWUzfZsWvJBLKkcSwy3ROvPfGc9tUWnVK9fROYwbLUPzYP/Lp9y3BRM8fUepgV85dBN35mlmd
 Y
X-Gm-Gg: ASbGncvn4Ras8j+eaWq9KjrAi3likfj8UNHuxIej46vW9Hb9SLbhkNHNqP/UE63xJsX
 jpp8rrSkAQTXkxkWOp6jnuMhfajvEWBY/QZxCSWPDZEuiM5ZeaipoodSJl7GwBrfXDnpm0PAAXt
 6561r8p9Dhz5l0qQxu8K6SYpBUtjvRjOKiijvnOnIZpxOn/EdyYHHz3mkk2XqZagQRJtY6hqjwg
 Bv2Xs0pk++6qOziHRT8diFl3o+qETIG2kycB9Xt99Hyvm3pwQN/FIO6ePoX8BtNLQkskcd6657Y
 WkhhN3PSwIh1yKG111rptNzHmoVIjU/kOfArWuvE2sf+ND4jLy6lTKvkk0IOSIBaetM=
X-Google-Smtp-Source: AGHT+IGaH4XvtHjiWnSV1VeXVxRH5mlsweNfU3GeF1BF5UHi5pYiqkPi/6r1xql6iMBU6JjtutmMtQ==
X-Received: by 2002:a5d:6d8e:0:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38db48b42c0mr5010299f8f.1.1738856052983; 
 Thu, 06 Feb 2025 07:34:12 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc45c26f2sm850516f8f.51.2025.02.06.07.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 07:34:12 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 1/2] disas/riscv: Fix minor whitespace issues
Date: Thu,  6 Feb 2025 15:34:09 +0000
Message-ID: <20250206153410.236636-2-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206153410.236636-1-rbradford@rivosinc.com>
References: <20250206153410.236636-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some extra spaces made into into the RISC-V opcode data table.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 disas/riscv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 4075ed6bfe..305dd40ac4 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1662,7 +1662,7 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0, 0, 0 },
     { "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0, 0, 0 },
     { "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0, 0, 0 },
-    { "aes64ks1i", rv_codec_k_rnum,  rv_fmt_rd_rs1_rnum, NULL, 0, 0, 0 },
+    { "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum, NULL, 0, 0, 0 },
     { "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "aes64im", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
     { "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
@@ -2214,11 +2214,11 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
-    { "c.mop.1",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
-    { "c.mop.3",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
-    { "c.mop.5",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
-    { "c.mop.7",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
-    { "c.mop.9",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.1", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.3", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.5", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.7", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.9", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
-- 
2.48.1


