Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94450C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1z-00045t-8q; Fri, 17 Jan 2025 13:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1t-0003zj-Kk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:13 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1m-0007q2-Tv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:13 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2161eb95317so48432145ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138305; x=1737743105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0der1AXY8+NAd6sj2IOYm3ClOdoj63Ilu/FNwjNpMg=;
 b=FeA4ZQVXZkshDpMPF3xyaZ2T62DgP4/ZoXJapUubd/vh9uFyMvuCzePmgmUxp3nb2A
 UoENTtogLC8IAhZrDyvbRQ4bca24e2wjwnjIJoj5lS0zct108oPa8UjxuB1YvkbO1ond
 hiky3DqkNn5DV1iMhntPVkkpCanmODAyFUuuZWVeksBIHoFOJQuTq4SATae+dYUUGlo7
 ZfKvfUyuWwgh0HNI+ljf1qmYVZvoFFCT8TNffDeiYKiV0ETAVuohzXrc6TNHXUFzMebs
 g2sztMDrZyX3axW9KzxDZlEPHZgS1+tdyD15OINyYmsmVEDPaW0S74+F6y5Xfi1jrIH0
 nv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138305; x=1737743105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0der1AXY8+NAd6sj2IOYm3ClOdoj63Ilu/FNwjNpMg=;
 b=EbnfACmZlDxY7YdxU27x4aQ2OmQj4E6ZUvcLIzrS/em1djHVJiHblrGiZiCQhz2y9R
 utyxMKBdclskQWLDRZNqAKa6CHAQg821JNTnVjM48IMNW5tavE2EjC2VEUne3VMP3r+6
 hKBD88KCTW4OG7pL8dhUmLPUc5F5P7s6bmyQ1/r/fQUYFkSgfm0A8O76QIE46SWapuV6
 e9eiTOzfnGhlNnZCrNFEA5PwevmOPndNmxNTLlH+ICcH/KZQufo93QvfCQPkgrGH73rz
 FmmVdWmDmP/WxubSOlNSfckIMiGi1pWzzWpyjO2MlkOl8b0oGt84JzdQMjg4E4XaOQhm
 +ivg==
X-Gm-Message-State: AOJu0YxOIXtR5MVAUjMYSttTSSODMdS1DrLX7vr9u0OujIAtbA/gzLuf
 Et31hvIi/apcF8IJ2gL1PRVu7WCiBHTNBGtroC67rALy6DRjhKhUh0m0HwXb7zGYYz7dy1DcX83
 T
X-Gm-Gg: ASbGncurqjvBn85j6hLUcEDhqSvV7FZ2/7jFPbw+aG4iNd8qcGIZt+ZactNg68oRE00
 cVPh2ZprecIYzVJL2QU9wLNrA4+wOLqE9L0x9ewAEitFfj1F+8134IDs4Hw3eW3z06e0r0/9CNz
 pfP6XUSxZ8WBQLSAwZlDV41mR/n0RjlZVMPXw2SAW7+f7iKy/P23IwVw28n2AmSwLmKdzNb7Bw6
 MU5kh71x2ENreHtXKX8S7QwfyJr8XPm1B0E1c1b0/RpxHDzv+ihPCHOn3XF07EfST0vSwMe60Kj
 1TK5LGYUYvsf864=
X-Google-Smtp-Source: AGHT+IGd5Bl1u93jLB8qzUt4CsS0YtAkxC/2LNiTa/ymXtC0e8TkFkaQqo8Bl9U4iYPOgrsd4z0/vQ==
X-Received: by 2002:a17:902:c94d:b0:216:55a1:369 with SMTP id
 d9443c01a7336-21c3540179amr58148805ad.18.1737138305473; 
 Fri, 17 Jan 2025 10:25:05 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/68] tcg: Add tcg_op_deposit_valid
Date: Fri, 17 Jan 2025 10:23:59 -0800
Message-ID: <20250117182456.2077110-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  6 ++++++
 tcg/tcg.c         | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index ac0a080b15..63f7eb3adf 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -840,6 +840,12 @@ typedef struct TCGTargetOpDef {
  * on which we are currently executing.
  */
 bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags);
+/*
+ * tcg_op_deposit_valid:
+ * Query if a deposit into (ofs, len) is supported for @type by
+ * the host on which we are currently executing.
+ */
+bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len);
 
 void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
 void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 43293ca255..6b318873ca 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2238,6 +2238,27 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     }
 }
 
+bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    tcg_debug_assert(len > 0);
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(ofs < 32);
+        tcg_debug_assert(len <= 32);
+        tcg_debug_assert(ofs + len <= 32);
+        return TCG_TARGET_HAS_deposit_i32 &&
+               TCG_TARGET_deposit_i32_valid(ofs, len);
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ofs < 64);
+        tcg_debug_assert(len <= 64);
+        tcg_debug_assert(ofs + len <= 64);
+        return TCG_TARGET_HAS_deposit_i64 &&
+               TCG_TARGET_deposit_i64_valid(ofs, len);
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
 
 static void tcg_gen_callN(void *func, TCGHelperInfo *info,
-- 
2.43.0


