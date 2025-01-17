Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA676C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5O-00045k-RZ; Fri, 17 Jan 2025 13:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5M-0003zM-Dv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:48 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5K-00008I-Ex
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:47 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso3447418a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138525; x=1737743325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYyOJoot88xHZloHmjY61PRyBo7semJlAInfhJboRyE=;
 b=Yz5bCsCQiOI4JuZbVivRwEgh1D/mBYNz14RQWt1iULNC72Wnr0SSAD2/CUKTWKTWNa
 X2VeJiy6fnLTRdevfPb9cpSlMPmUYrVW2eN7HOPhRCty72c5ioNtbsIyqyqnQGh1rMU0
 oMMGdtJaLjXI9Upt3pQnIdj+VyrN1+8nCIjr06iajdDjY60/HU+lgF70uWm+4NvUzAn0
 X6oMbsarYMy/IDHBYkABxJlG1rDarhYF5cQEcunWJw7TnExS8HdOu9W7d/Hoc6suobWF
 0c8ywuYF18XoDx9u87G6p9L0AbVw2kfwIBLmGZkShR7F2K5OaRBErPgOdIc462rI6+6E
 u+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138525; x=1737743325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYyOJoot88xHZloHmjY61PRyBo7semJlAInfhJboRyE=;
 b=ibxfd54vT0j+vWPJHn8TLTWg2wLjPYjxfUDY3/GEbip6tt1OrXHRcpf6z+oq5R2u/a
 z4BZap3GXJyt65YGpGmYh88LEfxJbrWqnvFS7FXVWCeStytgnAkrwXVFTWAhzGOswd9Z
 a7urF8Qpo+Cyo0FR9fzurDmpHke1h9yB3k8rgQ+Co5Q0JXvRIjPsNxE2zDkIEBK71wzk
 //F7q3A4FbzuMUbTNntthEVged1ik3wx0rYax3IafRVxSjgWbecXuw4iJ2QRKugiJtX1
 hs7yZOqw+WK6YBicNAk8IYLyEHTu0yvAdwzWu8U1yJJgLpbRa9fgdO9dLOIv7qlHVZhs
 7yIw==
X-Gm-Message-State: AOJu0YzTKEvvxuCJQ9ZavhzNqYq8B/XNeIcWZantLrIaIfrJ9Dzfe5zO
 Hh6jqzSXrYzZY1JtYbB6w+zb9BfnkJskFND+c04csMLwiDZGpsEdVWzjFeKklc9uU4TAAFID/O4
 c
X-Gm-Gg: ASbGnctMFzTAZ6kI8qieVYwwlVXtuVqqelrTxVtAe0vZp6ee0ig8YpfkxXev5/VCfJO
 6VqARQkl2ZNgYEbUaDWF+021To6Q3XHEYKJwKt9S24QwB1p4uinK35Akli9UanXNpPIv+ksFE3b
 cY5hty8wzr8m4ptiGONxiAyvIC+sk5lbUCzS0VQbWX39tRhP6OSz8K943iaF45vWLlljmNdt0kN
 J7vxUde4v6x7+ihHMDkEAGGAUGaqUCSe+USJA6pATxrWLCkaBe8Kzhd0gHyXCIWM+M0OhYrCVHH
 q28A0bDqeswZxfE=
X-Google-Smtp-Source: AGHT+IEb3HMVHWwcQeXJF2ZpWHCb7sPhGBLIpOQ+y0OWQhzYAaLE8Dsz+whlvSVvIe3Wy9TlRtGShA==
X-Received: by 2002:a17:90b:2c84:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-2f782d8c84fmr5019508a91.35.1737138525042; 
 Fri, 17 Jan 2025 10:28:45 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/68] tcg: Remove TCG_OPF_64BIT
Date: Fri, 17 Jan 2025 10:24:31 -0800
Message-ID: <20250117182456.2077110-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

This flag is no longer used.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h | 22 +++++++++++-----------
 include/tcg/tcg.h     |  2 --
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 724e7a9de8..eb17a21f21 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -37,9 +37,9 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
 #define IMPL(X) (__builtin_constant_p(X) && (X) <= 0 ? TCG_OPF_NOT_PRESENT : 0)
 #if TCG_TARGET_REG_BITS == 32
-# define IMPL64  TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT
+# define IMPL64  TCG_OPF_NOT_PRESENT
 #else
-# define IMPL64  TCG_OPF_64BIT
+# define IMPL64  0
 #endif
 
 DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
@@ -110,7 +110,7 @@ DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz_i32))
 DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
 DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
 
-DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
+DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
 DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond_i64))
 DEF(movcond_i64, 1, 4, 1, IMPL64)
@@ -206,18 +206,18 @@ DEF(qemu_ld_a32_i32, 1, 1, 1,
 DEF(qemu_st_a32_i32, 0, 1 + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_ld_a32_i64, DATA64_ARGS, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a32_i64, 0, DATA64_ARGS + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 DEF(qemu_ld_a64_i32, 1, DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a64_i32, 0, 1 + DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_ld_a64_i64, DATA64_ARGS, DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a64_i64, 0, DATA64_ARGS + DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Only used by i386 to cope with stupid register constraints. */
 DEF(qemu_st8_a32_i32, 0, 1 + 1, 1,
@@ -229,16 +229,16 @@ DEF(qemu_st8_a64_i32, 0, 1 + DATA64_ARGS, 1,
 
 /* Only for 64-bit hosts at the moment. */
 DEF(qemu_ld_a32_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 DEF(qemu_ld_a64_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 DEF(qemu_st_a32_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 DEF(qemu_st_a64_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 
 /* Host vector support.  */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a4630e44bc..e7ddf979f6 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -699,8 +699,6 @@ enum {
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
     TCG_OPF_SIDE_EFFECTS = 0x08,
-    /* Instruction operands are 64-bits (otherwise 32-bits).  */
-    TCG_OPF_64BIT        = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
-- 
2.43.0


