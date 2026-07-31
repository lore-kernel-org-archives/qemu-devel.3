Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DBEC55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQe-0008Cc-0v; Fri, 31 Jul 2026 14:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPW-0007Rz-E3
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPS-0002Ec-32
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:44 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so14417855ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524200; x=1786129000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8473XHgHaGO+CeNovRj28N7hdodUEPC+gxGGxq4IFfM=;
 b=M+YyPJKgASzvx9jB/Nw5uHSmxpb3hEWoyPgDjCgFQjcXx67RoPhLKnEi+h7VfzCiUH
 wnFsU/cIToVHMwPo24XA9yJeogq/45U2+hoqWfdCWohg/Uw4g69i1cmyKBnxF09Lknkw
 XRBSydZwSqj9qeyQn/Kyp9DpvAvL3OCOw1N8ZK8gwJxTNLCj49KH2eD9hl5Pm5tIH6//
 c6FbjzNT0faLBrWJA0Itt9L7XzVAJ4HZZ3Xs8mQmztgzlPRBSujxyHBs5PSfbvcLtbZP
 XorDUMQaofy+E0+Mspw93rHzzfRzyWR5KZyNBMJSU1zAyG4g67S1okbdRj5jYZwTI8Mb
 ZD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524200; x=1786129000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8473XHgHaGO+CeNovRj28N7hdodUEPC+gxGGxq4IFfM=;
 b=PPEAzftgi/DaLZK/o63L2bwgxMQNmsMhaZ8dKiS0pbw//4Vo4LSEWdwZKZpCsN0kUj
 IhJBmo0XGP78bb0e0Y90ctGNmOPWH3feL9I5ydMzuV3dbZaZFvpAYP3LIWMMW/bXLp2O
 /DjNPSkClyRtqIVonvjNWKHUbEhCQsjx+Af0Xo7eDuz/hxxj52aM8hfrSUQU2ay3Yg7j
 V4ngIJ94CNSZSnPS5TbIFMzClnHfoS1AEoaNn0VfTK5YyC33PzFUcFAc2FgD8qo9HO9X
 Z2VBJq1bBbp820jhXDFBhYHP2Ny1nAcbVDIB1Qwe921m1jgUhU/VGy96Wk/K39+XvSPm
 1H4w==
X-Gm-Message-State: AOJu0YxhZO6Z6U+sKK+5bH7sh136ThJ9av1uNgcR/QM2jQWGGcqF4t8P
 mQE9h9vdFRVWo5+qQctKrV2BDRrvhWiVDAZEIcF5GGG5Rk/Uy7eUcWIma3Vl8woQ0x+ZXI8GEMP
 1pO++
X-Gm-Gg: AR+sD10YHNfJ09I60+S3zxru6EVBwbPvkaLud8p+596Hrs29vukSrptm+uHDhgCVg7/
 ncXI8tXbRwj8/rfI9zNSUAapqvQljK2PDQxAe6vLFwggetTc7CrUdTkyh3jRRWP3izDn4fijiht
 BCizZ+6lJbbbU3wlMPp8Qw1sdXVOGMJyktvpFluNyF6vgVda2NCefcPVWYdkzTiX6COp5IPM9LO
 hgdWwyXl4fNwUDp2Cjk8LZm6zzQZu72ozmIE5mywER/9LNrcoQnqQ7sQbGb+pbQGsD/N8A2808W
 HkUA//bS6yhrEdoozMxU6EZJofUyC2OD5NVeS6oF1127WRBXDK0r98FgTBncyh1wv28SU3kbsG/
 zXoaO5uJRT0+Ws6St4ZRLuCGSwFAFcsa/CX3Wnb9yiIR01GkO3X3MIVA/McKTuMcDZMHn/NxzS3
 H/7K6M6JS410MmUOCzo4VDilxi/clwZ83TZ5kEEdbu1DTrbdRHGKJ+FYUVFp0jGfm9c5/nh8ZYS
 80TVqtBLjdiL5FsC6p6
X-Received: by 2002:a17:902:f647:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d051efd5a6mr11156585ad.0.1785524200486; 
 Fri, 31 Jul 2026 11:56:40 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 12/14] target/s390x: Use op_ld for LOAD REVERSED
Date: Fri, 31 Jul 2026 11:56:25 -0700
Message-ID: <20260731185628.23161-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
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

Use the MemOp parameter to op_ld to directly perform a
little-endian load, rather than a separate byte reverse
after the load.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     | 7 -------
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 61793a9e80..7c1961567d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5760,13 +5760,6 @@ static void in2_m2_16s(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_m2_16s 0
 
-static void in2_m2_16u(DisasContext *s, DisasOps *o)
-{
-    in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUW);
-}
-#define SPEC_in2_m2_16u 0
-
 static void in2_m2_32s(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 3611da1ef3..691f8222ab 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -590,9 +590,9 @@
 /* LOAD REVERSED */
     C(0xb91f, LRVR,    RRE,   Z,   0, r2_32u, new, r1_32, rev32, 0)
     C(0xb90f, LRVGR,   RRE,   Z,   0, r2_o, r1, 0, rev64, 0)
-    C(0xe31f, LRVH,    RXY_a, Z,   0, m2_16u, new, r1_16, rev16, 0)
-    C(0xe31e, LRV,     RXY_a, Z,   0, m2_32u, new, r1_32, rev32, 0)
-    C(0xe30f, LRVG,    RXY_a, Z,   0, m2_64, r1, 0, rev64, 0)
+    D(0xe31f, LRVH,    RXY_a, Z,   0, a2, new, r1_16, ld, 0, MO_LEUW)
+    D(0xe31e, LRV,     RXY_a, Z,   0, a2, new, r1_32, ld, 0, MO_LEUL)
+    D(0xe30f, LRVG,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_LEUQ)
 /* LOAD ZERO */
     F(0xb374, LZER,    RRE,   Z,   0, 0, 0, e1, zero, 0, IF_AFP1)
     F(0xb375, LZDR,    RRE,   Z,   0, 0, 0, f1, zero, 0, IF_AFP1)
-- 
2.43.0


