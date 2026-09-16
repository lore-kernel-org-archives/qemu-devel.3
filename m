Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC7BC982D1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6zQR-00063p-Oj; Wed, 16 Sep 2026 19:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zQJ-00062m-SP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:52:21 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zQ4-0006bL-Ue
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:52:06 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso233589a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789602723; x=1790207523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m8E/wyVeNfRdDfLa7dYg+pi94E3VOm5je38wI3uaR/I=;
 b=beHdINKuH49283AD2wzgA8L8R5a0ZtcSoB9ySQIsG9GsVqicoS8G2eKFMbVvhsdVYn
 3f5qlTknzFKVWKqjRmxeYREqMVJxszZkEztQXy5Qmp6AKwNnWpDkSboD2aWHbk8P5U1l
 phPgRlT7ZowdN6rKgk0aqXTOgo4V5mNbB+o8IYF9UKJnjCuJlRBLkuoLNliklqH1xHb/
 lfdEpodVrLHs8yBm4ZNJd+xzS3nQoLNPIU9fgp/rQN1vH5zA/xDkhT1uTToaBxUHYeiM
 8wXtTsjYGw72P6S1S7vmGHSEUUJkwY69FQRUd3q2pRLnbCwmiP+wDk/6mqreMmcXQV9B
 YiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789602723; x=1790207523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m8E/wyVeNfRdDfLa7dYg+pi94E3VOm5je38wI3uaR/I=;
 b=yGaiA2Fq2+M7nXtfOTYvOlrWoD2IkF41oGWk61L57FY7z3SGxTDtWG23ZB3sLbziTa
 cSgb+S+NdlaRNFHoumCt7SFexPk31VS29ADR3r73tV3zV/VtTy73wotk374iQPgTDQoY
 Her5zyh2nEcwCFwCMrTzlhoC6TdlZyqzlg+goEQGKwoDUIDaEQoI5pTHJqd5anmoF9im
 whVceQzDAGKwexDo59VRw1B2l8ViFK3d+Z9Zxy0yXKt8cV2Fxaj5iGX1VQa21e1WAhPI
 cn0g3DLECkNVFB675rJaA2KeBjlYwNogKPhoLbwZUqORFXu0/VM9XrkqLzcmQhJIWoym
 Rjjw==
X-Gm-Message-State: AFuF++nahryD0aKlo73IW+pJ8F/FYGxZR4vQOP5di41QLvRhqwziqw8Z
 gaotyJxWlWBCU13X+I8Kn+AWmYbXjwXoy+N066G6dsSKupqvIFlRG+VlkGFkhBeL9ovvFZxeJsO
 vG/b7ilQ=
X-Gm-Gg: AYBFou3Hzex5A4cRAFPdBQD+XLkRdqN5G2L5/nKwqDpcoD+f0uWpvv91IwCixrUnraS
 rSOe20QRmQ1++2RX+u5NjewPHmpFcVfbjayzZwZ3t/pRf2LTODYKsCFkVvK38oM2h7YJS8XO+s1
 O66mZ00kLbbFOl2igZOkKzJHZidGbMK/6HY7oOiz7bth3c72fShn7vBXPyQcFbA76+wpQqDGN3f
 4GHHewfyAv0bC6i03X4TxKbNUS2o9yZ5YX6IxZ/XqZeXv2Epbu2GSdGk2nswT5U3IlO66MA7bmP
 5R+qcluQhLjgG+3bw2bONXxrDeAI8b+dXWUA2rG42r62LcyBTTBnXDb7hbVjqo2oN9N2shuMnEl
 XLIo5TCuOdMIWzYj85mZdTRnFsFtODlXejS7U03LaHMeQhl8KFlwhJATApu+2h6Y1JI5u/bAjxT
 zNdp7spWJUtYQxLZ+YBbhXAEEehsb+REFffXvT9bOHVlV67TIlNYSagiWtWy/7eVR7e8bq6vSiJ
 0wZGsgRd8EhOyjELQ==
X-Received: by 2002:a17:90a:d646:b0:39e:3554:4d0c with SMTP id
 98e67ed59e1d1-39e35545ae5mr6624370a91.2.1789602723405; 
 Wed, 16 Sep 2026 16:52:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb05e604sm9240454eec.12.2026.09.16.16.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 16:52:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 2/2] tests/tcg/i386/system: Add regression test for
 translator_ld wraparound
Date: Wed, 16 Sep 2026 13:51:58 -1000
Message-ID: <20260916235158.294901-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916235158.294901-1-richard.henderson@linaro.org>
References: <20260916235158.294901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


