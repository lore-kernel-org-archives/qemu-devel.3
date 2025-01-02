Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CEFE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbg-00079m-Dt; Thu, 02 Jan 2025 13:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbB-0006xF-Ng
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:11 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb6-00057f-MS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:07 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so166191705ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841222; x=1736446022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pKmXb1m3DMp90fmFisjNG4WdmYNCL6RTfNDqnFc9oqQ=;
 b=lYxcJbA696Om4hFY5wW+pv9FZesKuVGFiK/1cgGCsdqCwYgpZh0VLRk2Hv1YoFQh4Q
 79mLzTxffV4BK+IxmOHvHRMvb21ImIMxfQKPhKH0jbBbZYi85W3ZwOLNRpvX3f5ALf3B
 voHd4qNeW8i7ZUjVKr/rrffCnaX69Im2rOfxbNfZOa42dn1jM21X2ZqBuCURAreo9Liy
 xCnsLCJcQ2e9KjQGA9FXCf8MzHV6tiwBan4jHlGJwrU3LcDJMhlqK/J0yrrpkvNohG7A
 xEY8cLX/W/A8OMd/soHz/71qdZ3DU7e8DxXxgsZVl3sHx1v0rRFZQFPr8tC71oWEtqBJ
 soog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841222; x=1736446022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKmXb1m3DMp90fmFisjNG4WdmYNCL6RTfNDqnFc9oqQ=;
 b=i0Bnhtp+H4lRE0t5yJly81YM6OplwFaLaB1iCWfz8q3J8r3Bz9LtKzo1YrwmY/R8eV
 kGns26mhE4RerYcB7wvTLGgmoaf3KA/nqjv/AC6/GO685+lwFSVrEzyz+15BPjPMcjJY
 +q5jYKbqzeS0b2h/5nSlVMu6F/TsrPrGnMN8PtLV4rWDhA/IAjrpVDX1Y4RhEkQkmHvh
 SSISUHrWs7dUb/8eU3cvb3nLhKUO9ply6A08xcQr8+WWwQsaK7X20Q9tPI0PV3F7ZQMi
 zYN990Fl/OLk/QULJFnjhahQNak0LqyJo62n7smkEpfzMHY+wFDZdiLrMqQHNhykoTF1
 eoaA==
X-Gm-Message-State: AOJu0Yxb5/yymtWHYLdxhPio/sNdN68nTsDdifEjtPSHCkyk657mXwLm
 9HMdqccXp52NnU3lsrYgiBzwaYScVL1dUiMPGZ5cwJ4rp5anfrwMjskCxHnag6eNUk98J3RcPEh
 Y
X-Gm-Gg: ASbGncvdK7jn7lG82eMHymUzK1T2P+toNREbLyVC1fHuQ7LkV07DBB/CK0qbSMJDHhu
 BobPFZdb7sbu0nW3yesbr1d+SBCpWQLrrAJVB+TlCyyaq4l+fgotjcQIWZkFvyVRx/5qq78w2aI
 BsQUa6Qt7Ku8Hh0qDlcANatZmOw4wLJNJApTB9Vds2sEKykSRCeW5HhiH7Npn3p7ABYECLsZEmV
 uur0rJZcFI1Tdp9VaKAQDnSWzk6ENqzb6sBoFHzeSl2/qpja097yTWJrdO5sA==
X-Google-Smtp-Source: AGHT+IHS1eigUPAAa/7jqEtwGnGnRf4bwa4mhWcGmg/dDEY/SUC2INOyddmuUh8MzZTYkMjdTZMqLw==
X-Received: by 2002:a05:6a00:21c6:b0:725:4915:c0f with SMTP id
 d2e1a72fcca58-72abdbd7f45mr66108305b3a.11.1735841222023; 
 Thu, 02 Jan 2025 10:07:02 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/73] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
Date: Thu,  2 Jan 2025 10:05:48 -0800
Message-ID: <20250102180654.1420056-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Rely on tcg-op-vec.c to expand the opcode if missing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 49d32fabc9..732453db6f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -596,14 +596,8 @@ static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
                           TCGv_vec m, TCGv_vec k)
 {
-    if (TCG_TARGET_HAS_bitsel_vec) {
-        tcg_gen_not_vec(vece, n, n);
-        tcg_gen_bitsel_vec(vece, d, k, n, m);
-    } else {
-        tcg_gen_andc_vec(vece, n, k, n);
-        tcg_gen_andc_vec(vece, m, m, k);
-        tcg_gen_or_vec(vece, d, n, m);
-    }
+    tcg_gen_not_vec(vece, n, n);
+    tcg_gen_bitsel_vec(vece, d, k, n, m);
 }
 
 static void gen_bsl1n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
@@ -640,14 +634,8 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 static void gen_bsl2n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
                           TCGv_vec m, TCGv_vec k)
 {
-    if (TCG_TARGET_HAS_bitsel_vec) {
-        tcg_gen_not_vec(vece, m, m);
-        tcg_gen_bitsel_vec(vece, d, k, n, m);
-    } else {
-        tcg_gen_and_vec(vece, n, n, k);
-        tcg_gen_or_vec(vece, m, m, k);
-        tcg_gen_orc_vec(vece, d, n, m);
-    }
+    tcg_gen_not_vec(vece, m, m);
+    tcg_gen_bitsel_vec(vece, d, k, n, m);
 }
 
 static void gen_bsl2n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
-- 
2.43.0


