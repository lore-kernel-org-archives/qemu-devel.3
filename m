Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254CBC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyM-0005Ka-Sd; Tue, 04 Mar 2025 20:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdy7-0004wF-5h
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:44 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdy5-00006X-5f
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:42 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2feb96064e4so10321978a91.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139679; x=1741744479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6HXX61COAmfBBR7go9A4btoEcUxOWhbvQ+kPo4OZ+c=;
 b=HpbZVgmfPbm5I9euX3+apRGtB0G+q2hcorzg2lYBN2v+OPvGGYC7DfOoyLigboFA/g
 zGbJeJ4EYFgOpNbeM6yoDDYoSjB2bAzS6xs1Hb3/qgxgutcaj29515qzMkcyq4rH3GTA
 vm92qoDZEHwDT38xZRU2euP1izYyJOAnyuICp3WZW6CuzFrKy5cD3UqRukOtcW7uBXeh
 wFHlViGenqiAVp2gR8Vn6Mzh+Xe0QLPuCs2cTkv5qfuZi25szINaWOn2g04LzRGFWoUC
 K3Uyo1tUC4jCBAvSQhEWYi8W+Gp5m2L2zYcyvzmpNtPBSLXCt8f7dDzlzW1mAqm0SA1f
 yVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139679; x=1741744479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6HXX61COAmfBBR7go9A4btoEcUxOWhbvQ+kPo4OZ+c=;
 b=pyJyj8K3jMzdwQTJZwG7U166e44gZVciuiXqvesWmlZm2gYZ1ytxlmmvyw/bEjBpM/
 CLP14OoZ46qnI9Ut9HeS3+Dvx4/XDXaxEPl1Iu0Sfndt5Qw2VLjfW+TkWlzFvdhY++Wf
 CzdpaQBmJHaROSoamw7LNGtYsoiylkAOU4huvz6c3xwtzJv2jsHXLALheS79HwaRalZg
 TPu814WnjR+9EFGmS/9hhy9G+AL8Sa2/1IPjrYWLKfxEPSF4edCSC0pVq80/LNU5md8O
 6YIvUNR8Bd6yBh9M7AIgetykso7R4Zdw1Peci530UQ4VaRQpHUjaWjUriHpp5jgJEYKx
 dpGA==
X-Gm-Message-State: AOJu0YyglYfEkBeTwOD+yLDneIufeRLAs8ie8ww1SQ4j1kK9KZ0/VfIM
 pBDEto5VA8pUHdnWARGNmNNVDKERJeoOujM5/6pR0gt5kAppHB9G21yiBFmDUNA=
X-Gm-Gg: ASbGncv6QcRrE8LqZvYBSDF400EEzrzJhpzmr54+kKdDwvzsRglPC+YtgmhWn40XNY4
 9Ch/1f627w1yYKElTcYd0UrvPIm1ecTvrASLTTe4mYSfdt0pzX41vAv7+Rdb7ytsdPw2aDYmhKR
 5fzsP+nwAR9aX/qtA8tsY8/GgUr7IECZLHyWceuc3AFtmsNKh+kMLiFr7FYzuWs9tAIMLiDjWAB
 ydWeGdaI8A902A9t0e6L1AjSwYKY+ZiQiyCSdrwBEm9KVHuYvJoqIfbmFoI+A40jaucrIheiqyf
 w+wnXFpdNA5wos+XEBRQCbdt3EZ86G28OAqpCHwrbC+muT2Sb4l7QAs5CIcd0wfcOKWxE5xKXTR
 9FLIeDPJ6sHJ2JUMSOF/jSSu+jycNq1imfUQ0OnnLTf3Cpykx4W4=
X-Google-Smtp-Source: AGHT+IFjailxShMx19oQvKAPGUQuLVA5PORWb1FhlDLamvYWNpM0nJss6tZ/++a08VKg5ra6iK6HjA==
X-Received: by 2002:a17:90b:264c:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2ff4978cfd8mr2360094a91.1.1741139679313; 
 Tue, 04 Mar 2025 17:54:39 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:38 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/59] disas/riscv: Fix minor whitespace issues
Date: Wed,  5 Mar 2025 11:52:37 +1000
Message-ID: <20250305015307.1463560-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rob Bradford <rbradford@rivosinc.com>

Some extra spaces made into into the RISC-V opcode data table.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250206153410.236636-2-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


