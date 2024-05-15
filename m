Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB40C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7G63-0005Cg-SK; Wed, 15 May 2024 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G61-0005CJ-Lg
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G5x-00077Q-IX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41ffad242c8so37712175e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785142; x=1716389942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWr5b7ogG/rKIVgZ3ajQkJPbaaMpVh+KqxIFrCgh+w4=;
 b=x1wtNjVbvhSf3e2YDLi0sAwqIHh57VwN5E8bJbAfwJgt8rapDxMKbN52PXT9wSNpVR
 THIcP706bp0kXr0o+UlM1/kIxjH5f17IDZGvcaOC9AWJzjVe6K4BeZbuR8D1dJ8fR1aI
 gbP4uVRO2lWc1b+jzAeOd2y1hjXRv0QX6iuHWFy4TOe0478VEgzsa6baX56gfugFvfqj
 Zp7nc4dyeJqQ0aT6P2EiguzRcsNaKXKoWD5AMGOTnU8emwUQL/iHLJ3AOyguQ1ZVO53L
 z6w7YqxQ1stl4riFIRyWB/KBx+M9UpzDYEOGd1ifTlUalTaDNBffOSY/IwSgaPdhQ5BH
 WYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785142; x=1716389942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWr5b7ogG/rKIVgZ3ajQkJPbaaMpVh+KqxIFrCgh+w4=;
 b=B8R2pkX4Yt3bprCc9H7IgOK3Zp8RpvACMqWpwFb5Fbu8Ltn/WGPRoweLAk4N857EQJ
 tX4lBJ90r9ZMEOnaYTEqjST7OmVAxrWw0LndsGWZEO1tdjsp75d4r1IvUjd5lBLWYC6s
 yBNheNMwoAJLGNuYvvAsTgx2n7WTTjHIzGAh90lxwlNeecvAe2DShK0jddssoaIjWb1K
 v6oElq4jUClFrQpIzzmEYm1SOsjfKllKnAHbl2Qx3a2Gu45LQZmiDEw6fll6aYvLT4pg
 0wrnqJMoBdSflrLwpccY+ti5NFD7iTpB3uOPM0/nemcLAljVzSUOicTH5JMshXAc1MTN
 Z0jA==
X-Gm-Message-State: AOJu0Yw3991rr8sSiSQsNFPszhpNmclAYRDUIq8ECNMCqpFNp4YY8eK/
 HBqJCc5y12blcNaPNNps1GE6t39eKKWFGd5jEzCTnjVxeQj5AlsXIjJuMOWceqHZ/d28DWUcy4H
 FRsE=
X-Google-Smtp-Source: AGHT+IF+c0RFw1sUJE7Mm90fZuPHnJon0rnVhi5eeoqGjVABDpkFx13xmyVfn8DhgqYZSq88zY6KLw==
X-Received: by 2002:a05:600c:4f0c:b0:420:1f0f:fe19 with SMTP id
 5b1f17b1804b1-4201f0fff56mr61846545e9.13.1715785142301; 
 Wed, 15 May 2024 07:59:02 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88111033sm272134645e9.34.2024.05.15.07.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 07:59:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/5] tcg: Introduce TCG_TARGET_HAS_tst_vec
Date: Wed, 15 May 2024 16:58:56 +0200
Message-Id: <20240515145900.252870-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515145900.252870-1-richard.henderson@linaro.org>
References: <20240515145900.252870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

Prelude to supporting TCG_COND_TST* in vector comparisons.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            | 1 +
 tcg/aarch64/tcg-target.h     | 1 +
 tcg/arm/tcg-target.h         | 1 +
 tcg/i386/tcg-target.h        | 1 +
 tcg/loongarch64/tcg-target.h | 1 +
 tcg/ppc/tcg-target.h         | 1 +
 tcg/s390x/tcg-target.h       | 1 +
 7 files changed, 7 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 2a1c080bab..21d5884741 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -155,6 +155,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 85d5746e47..138bafb9da 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -167,6 +167,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index a43875cb09..434a892e07 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,6 +150,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index a10d4e1fce..2f67a97e05 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -224,6 +224,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
 #define TCG_TARGET_HAS_cmpsel_vec       -1
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index fede627bf7..29e4860d20 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -194,6 +194,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 04a7aba4d3..e154fb14df 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -173,6 +173,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_vsx
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index ae448c3a3a..62ce9d792a 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -163,6 +163,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_minmax_vec     1
 #define TCG_TARGET_HAS_bitsel_vec     1
 #define TCG_TARGET_HAS_cmpsel_vec     0
+#define TCG_TARGET_HAS_tst_vec        0
 
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN		8
-- 
2.34.1


