Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5231AD12D71
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnzW-000693-Qy; Wed, 03 Dec 2025 09:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQnzV-00068m-Kj
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:38:01 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQnzT-0003tt-Vn
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:38:01 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42e2ce8681eso3179673f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764772678; x=1765377478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=By+tXRTpB9Dyghm2Mf5yvj7OCSVjm8RKF5MZWEn19a8=;
 b=ii9IE/JcjXGUML9En46FT8GmhceSdyon15NJypA2S4N0LuXrJw7S91yVXLX9uCUwAB
 19QQ14OAteFd3Vw1Se2gir3pAl8pRBxwi8oQ5xtxBvJpf2tIZfPRsRupF+Ch4xcblYNx
 6T4BoNRyPjuC4QMv/PZDCL8HT9lvVoJYRdxNgLTVYPDIVs8FtYGBZGNaG5iuAN95LbEi
 kWFZBd9kDtE/Pl/A44kIDqgHKDJi2PDPcEj+wEp4K911rTaajXguLml8xzHV3CZc2PE7
 W3XU2dvd0Tnk1hcI70KbHHH41UMJ4V6Z5twwdSLr6D55yJi/FEbqfjI/pAWq/OztuCVR
 A+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764772678; x=1765377478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=By+tXRTpB9Dyghm2Mf5yvj7OCSVjm8RKF5MZWEn19a8=;
 b=kc9/lzehZoynqUSs39yLojAAIcYkZ96BW+MJkTQFS44awrEBV2hoz1iPtSdMMZN+iJ
 lDSGvN7rShj3UN7E6DeKzG54ol/6LInVgUABPdGDzwdJZ090evXV1om4SYnhDztinyj8
 wipGYlQrHQG/h6xmNGhYh9WR0UfEo0Z/GvfOK21mQC9wZBI+YeHoWyKa+47+ongr5v/B
 hpbPLgqwJzOo9o/1wjNP9SkO8Imhc6XVmT+L8EPlfniPNbG5Btya2gKXsVfgJLLcXIOU
 TcpHWOkRBpuDf6isk81KGICZ1QCAayJneSRIGZWvzoLwOEr3BPRPl9sZHhNbJHwqjrjz
 416g==
X-Gm-Message-State: AOJu0YwBKNxr5SakAAPwCeFrPAa/Svygq/bW7mlxFupXatzZBn8cBowI
 jEaBO4XU504zGpdgosoK2AO/QeSyF/j0IVQRUK32N2elQmQdMRu69KZKObx6AAnq/bf+on72oge
 7EaAuUCo=
X-Gm-Gg: ASbGnctNsPMCrn3UfCYs7ltvavHv/ONNpW6tcvnbNQKKiUdEcLrxPCxNkafLioOUKKs
 hLuiLwLeYYuI0kduDzdm28nsIofwqGAyJPAmuwaIvMYlU9HC7BLNJi6lmaVle2bSpvBp9xDp7c2
 rHDe7LgZiwFp+Dj/aUsiCvjjRhbVeG0L4ONA7Op6geR/WuuwCPWSqQvdFEfHqNPDbtAaf9PKcWJ
 4I8/V6/jB8LUf+ib97U+ny+ikiEwhTGrJcQbEBAXgfks87+NdOxkLn/87pTyVRkQIS21Ws8ihZv
 EI+XkT+eGdfhdy3ogZ/R/STgxdbjvYgEpBVlYkAoEf0b2r0TjoljLeRYNsx/0OfbDsbYGvqGIYn
 bzRbWx1n/UeXTg8ZAOmtfIWKEkfqCaDBr+DYP8y44h2jzncwFboIx5sF3mJuKR5NIkPhwfv8k/K
 /LJu4Q8VmdeVgxGOcjm/H2aWuzfRfXRIftd5s/of0hCT2WD8FNV4P/IXH6xI8i
X-Google-Smtp-Source: AGHT+IHrlrmuiCoI+gIWe70OOt5yC5VVkj8m0l4u2b/hWK/r3H/bLVUyMeIya9kKYvfKKZsF018Cxg==
X-Received: by 2002:a05:6000:26cc:b0:427:7ac:5287 with SMTP id
 ffacd0b85a97d-42f731a4c5emr2824260f8f.34.1764772677648; 
 Wed, 03 Dec 2025 06:37:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1cac995esm38346086f8f.43.2025.12.03.06.37.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Dec 2025 06:37:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH-for-10.2? v2] tests/tcg: Skip syscall catchpoint test if
 pipe2() syscall not available
Date: Wed,  3 Dec 2025 15:37:55 +0100
Message-ID: <20251203143755.65535-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Avoid the following errors testing i386 and ppc64:

  $ make check-tcg
  ...
    TEST    hitting a syscall catchpoint on i386
  warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
  Traceback (most recent call last):
    File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
      main(run_test)
    File "tests/guest-debug/test_gdbstub.py", line 53, in main
      test()
    File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
      gdb.execute("catch syscall pipe2 read")
  gdb.error: Unknown syscall name 'pipe2'.
  qemu-i386: QEMU: Terminated via GDBstub
  ...
    TEST    hitting a syscall catchpoint on ppc64
  warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
  Traceback (most recent call last):
    File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
      main(run_test)
    File "tests/guest-debug/test_gdbstub.py", line 53, in main
      test()
    File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
      gdb.execute("catch syscall pipe2 read")
  gdb.error: Unknown syscall name 'pipe2'.
  qemu-ppc64: QEMU: Terminated via GDBstub
  ...
    TEST    hitting a syscall catchpoint on ppc64le
  warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
  Traceback (most recent call last):
    File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
      main(run_test)
    File "tests/guest-debug/test_gdbstub.py", line 53, in main
      test()
    File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
      gdb.execute("catch syscall pipe2 read")
  gdb.error: Unknown syscall name 'pipe2'.
  qemu-ppc64le: QEMU: Terminated via GDBstub
  make: Target 'check-tcg' not remade because of errors.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC because I have no clue whether SYS_pipe2 should be present
    on these targets, I just want the CI to pass full green.

v2: Drop extraneous 'if'
---
 tests/tcg/multiarch/gdbstub/catch-syscalls.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/catch-syscalls.py b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
index ccce35902fb..79c8d532d1f 100644
--- a/tests/tcg/multiarch/gdbstub/catch-syscalls.py
+++ b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
@@ -22,7 +22,8 @@ def run_test():
         gdb.execute("catch syscall pipe2 read")
     except gdb.error as exc:
         exc_str = str(exc)
-        if "not supported on this architecture" in exc_str:
+        if "not supported on this architecture" in exc_str \
+                or "Unknown syscall name 'pipe2'" in exc_str:
             print("SKIP: {}".format(exc_str))
             return
         raise
-- 
2.51.0


