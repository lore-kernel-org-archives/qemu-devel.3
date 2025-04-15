Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5B3C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lzL-00009R-4s; Tue, 15 Apr 2025 15:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyL-0005SB-Qv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:30 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyD-0000wJ-9l
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:27 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso5577535a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745360; x=1745350160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sof/uzW5h2Ec1uqsF0LsdHyWvNflLyyFXYvZsx9e2cg=;
 b=TqzLSJ5qCswwmnqpPzFVgmftx3sgGOKJKB2Oeq+zXsYJ143uDBjct8MJPlnBsVSM1G
 WiEmUyRxX8arehg4mnMRfal7D1lRobOjgGOM1W40ZexBPIGMIsgWOfS06VFgQxTlFjkE
 hC2PzvAgjDc2wzVTnAN04XyxlypEfOGRHxk/nC7B+6PqrTEvtusGOaOz2J3KIoIQww+N
 Y62A+muJeyQdL/mhmESMV+SYE9WoFmDG5oFcJ9DafLTDJIh9oc7YZdwAHL/DFnlLaTql
 DvQ/rNEq1f4b3DWPHPLAyK2TWTmir1aPrVdmEEAZx+Ht65mrtQdIZG9cbuK8huVIIl5R
 hceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745360; x=1745350160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sof/uzW5h2Ec1uqsF0LsdHyWvNflLyyFXYvZsx9e2cg=;
 b=E2NcVzdo21qe/H9SpET/dp2whpWZaK+jF+sunBK0DQ/P3bmNYzmW2t1V7smj7rwHql
 pdVT6NIIS2M5UFHD7OBdHmNNmxeVBOv+6IksJtHK1HKmhkWZWpF/YtI5uWTu5OTTLShS
 ZG/YQaj8+ruXXFwcIDLdVc5joptqPiSp/IWLOfRGrkSWbE2JweMebvMsYYt2ZWzz5pdS
 /Wu3kzQmS0QqeZDrjU9ppoQbdoAWMd/Z0H+hBjCWcc790khG6UZCfzD8zQm6yyBLcHL9
 F8PEmaZxLsL2nY+ESUNQaP0KLvR1I/Lg2pQcJ/OUOqOPQburtpe4slQr6y3Dhu3AITui
 KNWw==
X-Gm-Message-State: AOJu0YxeNZPTsBA+EGbhA7SnVQmCT49Avn/ZZeOzxY2wS8opSqhFg8bp
 m8AXy/khyABlMYD7bq+HA+C1tO9xGj5YXwMIDmUVsI/ntQcdm4aYwUA8Ij5gO6xfWnbYfM9fSn/
 u
X-Gm-Gg: ASbGncsOs680ruHsFT7b4fn/Wy/8nqj/F81PKzqNtmGBpcA7edh5OXAyiWBU0gCnN+K
 IeCQDdInoLsB8l6BmbhcDAOzmBoltiSubdNTGJ+MMsaz49nJxSjhJr8Y8LqOXQFJQf7PLog0Q6A
 usuBKh5aD5QP9TpU7BmNK81nrK3W5tgvsnCItpJdplBiqMMW+Cqwd90WSma6bhnzkbWZUmJ8quV
 oP+AQHV/j7HWU+lxtX23+kTOaCRW+fzbYeXhFuoRaGJF2L+F+K4JEpDBi7X8ce2CpRFhuBIz6B8
 bH6K1ftrOgxXWxb1FaneFveJRQcxZp9Tf5sD+wisjmxFUnU/aFD8oiu0HhfTQskIko2kAE1Nhwt
 K2P2Nsfy8ag==
X-Google-Smtp-Source: AGHT+IE6sEobAT4rILSh+hOLnr5ib3Rw4OezB6Zw/pb7XljXvaznzaZR682GaDs4Edvdhj62Y/T08Q==
X-Received: by 2002:a17:90b:28ce:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-3085ed76ffcmr801426a91.0.1744745359667; 
 Tue, 15 Apr 2025 12:29:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 074/163] tcg/tci: Support negsetcond
Date: Tue, 15 Apr 2025 12:23:45 -0700
Message-ID: <20250415192515.232910-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h |  4 ++--
 tcg/tci/tcg-target.c.inc | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 2402889bec..7787347e05 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,7 +10,7 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -19,7 +19,7 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 563529e055..2eb323b5c5 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,6 +79,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, r, r);
@@ -966,6 +968,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                           args[3], args[4], args[5]);
         break;
 
+    case INDEX_op_negsetcond_i32:
+        tcg_out_op_rrrc(s, INDEX_op_setcond_i32,
+                        args[0], args[1], args[2], args[3]);
+        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
+        break;
+    case INDEX_op_negsetcond_i64:
+        tcg_out_op_rrrc(s, INDEX_op_setcond_i64,
+                        args[0], args[1], args[2], args[3]);
+        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
+        break;
+
     CASE_32_64(ld8u)
     CASE_32_64(ld8s)
     CASE_32_64(ld16u)
-- 
2.43.0


