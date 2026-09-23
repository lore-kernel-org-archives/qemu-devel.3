Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65980C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgm-0008IZ-HN; Wed, 23 Sep 2026 16:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg9-0008AK-78
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:57 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg7-00050w-7z
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:56 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469a3490bso1212407b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195694; x=1790800494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=toBKJm1UUMfIsNta6626Tkm+3elU4o/5FcJSbCSkipM=;
 b=FaWWL57GvthkX06uuldzCPPM9q7rszqiXgqwg/LCYUTYhTLPDbKP/I4TLjdjqhoeHz
 Sd/F8oizKxEs/KRWPxywhCf/PaMeeglMZwf0/QE8QQhnLvPDuuAU1fepThP/P1MWzzyt
 SPWRZk5K6aCmMXVyQMaldQBbnbMB7TrhMmNwGWd51IBDP2SS1M/kIXbmhEZZH5Qlyy05
 5dMOIyXQ+ac3H17MVRDSieTVAz+w6+IBii/gpu+RV5Gl65U9s33fASdIuWhBwDzf0h5Q
 PN9rugKGBVbPPLtTPZW1dBCAHR6AQ2YjMx7cORrFAZlTs6OwQvk50yOq/BFN5lAbge+1
 r4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195694; x=1790800494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=toBKJm1UUMfIsNta6626Tkm+3elU4o/5FcJSbCSkipM=;
 b=gYIORzAT9qZxMODNo2n08BlnGb/lyFtJjv8kP56RE6CIGEGHAiSJlYPSU1VlzTHGZ5
 CLvvB7Oohww1Y8SMPlGm7C8WnlvsKrYkLa4hGACyY2t/3YxLmbs5QnepinwpLXmymUuA
 rWiuLy+qxlDz1XRwEfxAPH2IpSIdtLA5laQYf64sS882PQKaNhpdQYgCAIK2E30lDVoO
 l58tBVNoy05c+sulGTjKM3SPVsvRuqDZlA+BFgDCvIPHL3DLmxU933xU2G/uKO68Cqdq
 iL38S4zK9y+m9Nt72VQy69TrRDcsyJfh5J5/5ngQ9IGkwbpx4PsmGPwO+DuoqKXG8/Nb
 3Nzw==
X-Gm-Message-State: AFuF++kicfVcOChLyjNuwhNSiHiawRzhlWrqs14KvxcF3i55PDZNPtC3
 E06l/njUvsHWkDP+syTDuzUDKp69B6c2kjWSna2+L1QZKOpi7JQJlS51xjVKW4VzZODqouIzlBd
 a8/xA
X-Gm-Gg: AYBFou0xpCovk/hh6BcH7tSGcQMiHRA8QybOmcMWhReE/wnlAqi7MipvIfHBWLRcGWq
 ks+3heJbCa47XQNGVHuh2KeJ21tuPZZ+lkov9ufwepeQUj5+Bfy0jvGzl4xbThvgkxut+zEmAfy
 U+BqFLwply6eZWb4VJhxGTBYASbYAfK3gi/5iWpNenMsbTAh1gaIFQx1CFW+W/tDwsODpOBKOB3
 u9fpPkCsBkyILxJK/ihYembCXJ+LYIMYTo+iHfC5v6RH3HoSB1hy1Yb8or87GVbXLiRrwHI8U8t
 7vJvdfAg68Wnfr2lxQ2ap2pwwypVlsv4/CDcYqdAjFGhpZcv5Q0944ZzAland7Z3yJzOFgWLVAQ
 k27vS4sXRIE8vlC6Ci9aJm9rLQ7SGGxbZj25xvI82Xco0eGY89aagorXn/62NpZGEF/cmRVuCDF
 GjGqIXZVJTMIjqL/ZvAlQDVlSqO8D7CZ7FAUqgDDf5cGbMykr2e/9DYvtuv+ylpGZd1YD8KX28I
 ptwBIDLvuxnFqaHVKFjuYlG3YTK4Ac=
X-Received: by 2002:a05:6a00:27a4:b0:878:34d7:6984 with SMTP id
 d2e1a72fcca58-87ea0cbdfcfmr183011b3a.50.1790195693847; 
 Wed, 23 Sep 2026 13:34:53 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tao Cui <cuitao@kylinos.cn>,
	Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 11/16] tests/tcg/i386/system: Add regression test for
 translator_ld wraparound
Date: Wed, 23 Sep 2026 13:34:36 -0700
Message-ID: <20260923203441.31276-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

From: Tao Cui <cuitao@kylinos.cn>

Add a test case that reaches an instruction straddling the end of the 32-bit
address space (0xfffffffe).

The top page (0xfffff000) is SeaBIOS ROM, so the cross-boundary byte is
the ROM's own 0x00 (add r/m8, r8) at 0xffffffff, whose modrm is fetched
from [0x0]. A short exit stub is placed there.  The case runs on
qemu-system-i386 since the bug is 32-bit only.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Message-ID: <20260709020529.126652-3-cui.tao@linux.dev>
[rth: Simplify and convert to meson test harness]
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/i386/system/meson.build  |  4 ++++
 tests/tcg/i386/system/wraparound.S | 35 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 tests/tcg/i386/system/wraparound.S

diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index d3f73997c7f..c08563d0ab5 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -34,6 +34,10 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
   endforeach
 endforeach
 
+tests += {
+  'wraparound.S': { 'cflags': cflags, 'qemu_args': ['-m', '4G'] + qemu_def_args }
+}
+
 if 'qemu-system-i386' in emulators
   tcg_tests += {
     'i386-softmmu': {
diff --git a/tests/tcg/i386/system/wraparound.S b/tests/tcg/i386/system/wraparound.S
new file mode 100644
index 00000000000..9c77b3a8468
--- /dev/null
+++ b/tests/tcg/i386/system/wraparound.S
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Regression test for the translator_ld crash when an instruction
+ * straddles the end of the 32-bit address space (i386).
+ */
+
+        .code32
+        .section .text
+
+main:
+        /*
+         * The top page (0xfffff000) is SeaBIOS ROM and cannot be written.
+         * Its byte at 0xffffffff (0x00 = "add r/m8, r8") already crosses the
+         * page boundary into page1 at 0x0, which is exactly the case
+         * translator_ld must handle without aborting.  Reaching 0xfffffffe
+         * runs the ROM's cld, then that add; the add's modrm is fetched from
+         * [0x0], which is RAM, so build a short exit stub there:
+         *
+         *   [0x0] c0                 modrm -> "add al, al" (reg; EIP -> 1)
+         *   [0x1] c3                 ret
+         *
+         * Note: this relies on the SeaBIOS byte at 0xffffffff being 0x00
+         * (add r/m8, r8); if that ever changes, the stub below must move.
+         *
+         * Note that eax = 0 before and after the stub, so this becomes
+         * the exit code of the test.
+         */
+        xor     %eax, %eax
+        movw    $0xc3c0, (%eax)
+        movl    $0xfffffffe, %ecx
+        jmp     *%ecx
+
+        .globl  main
+        .type   main, @function
+        .size   main, . - main
-- 
2.53.0


