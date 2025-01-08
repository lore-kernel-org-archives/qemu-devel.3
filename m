Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A27E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdzC-0003BA-Ck; Wed, 08 Jan 2025 16:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdz9-0002tx-UF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:53:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdz8-00048U-66
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:53:07 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso3253955e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373184; x=1736977984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I14qnECo8+uzGdRsFMt/ZzhPLYXzTCANqtsyIeVHtfw=;
 b=ABvtw/P1nInhsWYbtdRi3dP6WLqS80T+u6y5+tqMYZUZZQj6DJeJm8ZR69ksuoivK/
 zm+QfslDsIx/BAqJy7gBiu9t0nNxlsC3+6h9PBuYtd/b+enNY+dVcbedaq7XB9kOYIBz
 8bDxZ7SAo8Ujzz5TGnExIjjJ8u2PpJlFPuGXwZ1Red8evIN+HkRFR4rkVhD96t7XhFYX
 EjLb0fTOM3O6ivAwQ7oLPwFyJDG4uxnBLDcVODNMitwZB4kMVQVmTgq8SMRLdhzGScgu
 S7/uLxjuBofqfFCs/gijo0XDgbWgpodbhuTSBn9ZhWVyEcc76dh30jj42gXq9pa+lTNo
 8D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373184; x=1736977984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I14qnECo8+uzGdRsFMt/ZzhPLYXzTCANqtsyIeVHtfw=;
 b=RvaxjGN/2E1T9sMF9aWPG5kiaWayCypEe2gEu0wURG6FsZL3acxOkgkGVZirX6hbgT
 YIPg5x2fFi8aa7X+me8jmxU8qtmmnCpx3DSxOFcBF9HiXQNvl/YHY1pe/nUvb7NKVFOg
 hZRsn5fY/w3YN9cjNz9DFzCtZxkYRAsH9YtoDEaF1sllRPhzGmvoo635Eg5IEQxtU+P3
 k9XMPdLSCgTq10fNiOOpDLr4YvPe5YJxBQNEtQ/pm8+/sj5yoJJp2pCqFP/69eB29AHT
 RpW6LnaTEw2XpEyq/l2s3KH/jINzJo3hPXRR/e0G/wlVCabJKeiweCjYmsGG3R6sm2v8
 mj6A==
X-Gm-Message-State: AOJu0YxhcpAnrlU3QdtFfQGkz/7HgIWmoMOuEQpBPGfe9JbF5XS8T//D
 Pq9GCB6o0/IZbItDp746pU4LpCPEML23Lq9zFz5IweOabLnWwUzbbQ0aSaAzz3SjoH//JoYWSnr
 St3U=
X-Gm-Gg: ASbGncuxWLP3LOZ93aWXN9fxBO+nhlU0CC3aUCL70sitd7vsRpeTmTE04pj9DOqjXTf
 zYwasLyy07Xz0m/EmRRquSiK/bzmDrDWZgO+VPRugpJ4zR3rbNhk9cJACWKsv8uEdEecI6h/8WO
 pw94WO1qloWKL8LFybdGU6k3+GbfqIri1JO5igYH6ncQklXYR6A2oaYlg6SslTY3X98VMBDAjTM
 15WVHDfaJnYdLSkUUYYN581tZlU5XoDQWEl2awrSUa6Wr//BGONQ1AWoEVeDlNavnlY8qSUwC6S
 nv/y6TyThKqS1iqxZ7ERPfULRUKybwo=
X-Google-Smtp-Source: AGHT+IEoBup3//IwsRx97KA2WhWp0yLt7cW22+Ww/8gYUR1ULZuZhqdA/v4V3DfcV2O/CNgTCJVX/w==
X-Received: by 2002:a05:6000:1f81:b0:385:fb56:5596 with SMTP id
 ffacd0b85a97d-38a872de1e4mr3468651f8f.19.1736373184314; 
 Wed, 08 Jan 2025 13:53:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e320329sm32127f8f.0.2025.01.08.13.53.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:53:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/14] tcg: Only include 'tcg-has.h' when necessary
Date: Wed,  8 Jan 2025 22:51:55 +0100
Message-ID: <20250108215156.8731-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

TCG_TARGET_HAS_* definitions don't need to be exposed
by "tcg/tcg.h". Only include 'tcg-has.h' when necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg.h | 2 --
 tcg/optimize.c    | 1 +
 tcg/tcg-common.c  | 1 +
 tcg/tcg-op-gvec.c | 1 +
 tcg/tcg-op-ldst.c | 2 +-
 tcg/tcg-op-vec.c  | 1 +
 tcg/tcg-op.c      | 2 +-
 tcg/tcg.c         | 1 +
 tcg/tci.c         | 1 +
 9 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 3897c2d6b28..4406fc6be01 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -64,8 +64,6 @@ typedef uint64_t TCGRegSet;
 #error unsupported
 #endif
 
-#include "tcg/tcg-has.h"
-
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
 #include "tcg/tcg-opc.h"
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6823569ee2b..c363c5c04be 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -28,6 +28,7 @@
 #include "qemu/interval-tree.h"
 #include "tcg/tcg-op-common.h"
 #include "tcg-internal.h"
+#include "tcg-has.h"
 
 #define CASE_OP_32_64(x)                        \
         glue(glue(case INDEX_op_, x), _i32):    \
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 35e7616ae95..fadc33c3d1b 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
+#include "tcg-has.h"
 
 TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 97e4df221a4..d32a4f146dc 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec-common.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "tcg-has.h"
 
 #define MAX_UNROLL  4
 
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 0d8fe3b4f5d..ec3ef4dcb4d 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -30,7 +30,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
-
+#include "tcg-has.h"
 
 static void check_max_alignment(unsigned a_bits)
 {
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 364cd089df3..893d68e7d80 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-op-common.h"
 #include "tcg/tcg-mo.h"
 #include "tcg-internal.h"
+#include "tcg-has.h"
 
 /*
  * Vector optional opcode tracking.
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 872fb22ef8d..ab5ccd8dcb6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -29,7 +29,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
-
+#include "tcg-has.h"
 
 /*
  * Encourage the compiler to tail-call to a function, rather than inlining.
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 505e43c1289..3576299a1c7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -56,6 +56,7 @@
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
 #include "tcg/perf.h"
+#include "tcg-has.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/guest-base.h"
 #endif
diff --git a/tcg/tci.c b/tcg/tci.c
index 3eb95e20b65..39a68db287f 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -22,6 +22,7 @@
 #include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
 #include "disas/dis-asm.h"
+#include "tcg-has.h"
 #include <ffi.h>
 
 
-- 
2.47.1


