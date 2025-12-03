Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07493D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQiWd-0003GR-2i; Wed, 03 Dec 2025 03:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQiWb-0003G8-8A
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:47:49 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQiWZ-0003As-N5
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:47:49 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779a637712so40470995e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764751665; x=1765356465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yyd626JdZ/YYY28SKVRVVIZGCfbD1/LEXubgu34Cic4=;
 b=eszZ9DxIE6v/G6r6UuRRUqpxopHT/h1Q9Z2XXyNM+NQe4/Q2C5OytPEcc1zk6Br68B
 03UVHD1Nsj0rUrZ4nyNkqcUSwyfItFkOkekHS5VP/vhaIcsN7r5t2f38/tZg5eNjvwvd
 jLoGvo6nJgy3S1h7WLOdmycEWbdEQcAaii/txqDFIJo1hmljaR6EJqJPo+pUq9d/UR6u
 ln/MnMf/McPO9dH/cMyOcMarslMLd3U6RCfqZ4eArg9sFPlc9YaVDGQY/s0rYjoIompQ
 uJks8G80GQ+/2Vy4Ryh+mKC2ee3CXgBpqOVqk313CvanSIKuqrONyvI8mcxk14Bs5rmU
 p4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764751665; x=1765356465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyd626JdZ/YYY28SKVRVVIZGCfbD1/LEXubgu34Cic4=;
 b=JzPpv+588zMwbysuk4zKykLuWJrY2iWyrvk9M5RAipbpJlihS6ueec7iHtC55gYfjL
 1LLWUfJ4iGayjOYUZyt2Cg9N6RDw7jDCvK5JkPmf+w9zsRWddX90lyCxnqfu7kQLSjR0
 Vd9de12r+fNJw2uli49h/zTXQGeNMxZ7uoajQRqo2yBhlwITfVgCNDC97rHJtRY8A2om
 IPUSX6hb/bwJa91xd3vI8k+Xp0tsAg/lwotk2OKorYh9PQxqnUt03CPSzi5yZTB7/zyb
 7AZpV13caLpUANS1vDoG3GgvoIBsk9KFPmq8Zd3UrOSFYemOQUvCbeMVjOew52RscQ5i
 SqEg==
X-Gm-Message-State: AOJu0YwboucX+knDKbAl3gaRi7KzuulkcUJ1WtrPn898vB22ME/AWzeU
 Um73drzeyMGKaJOqJnup40hviVbFQA3yaYOrSjUQh6BahZ46pVOY0fU8pPI/ObQNc0LIaFODJvA
 a8CnhVII=
X-Gm-Gg: ASbGncuzdLeZ967XdxmyuDE4TGBhzpL5Js6XWBxI6QYN+tHvL8hx5ElAnSaX8E634BP
 GiQDF0wY2IOMuOR054YAu6R8snWhGZzqKgDrYLzUrBahEoVS4C0wEGwo7PRFuI48fdNyPGifOay
 48oL4scY62+4a6jP6MhCeiUZU9viAY888F6+EN2qoXSr44FuMJB9DlRWyjRZYKnK0RkoOHVTpoX
 u5ZEAMfmVQYtr88cWAAKjy731UQmvRr0zF8BgkpTigpYkmNwnfM+rnJ+vjhF3Xzr8vI0JRuRk7j
 5eMVMc83H+UyBP0k9SLVwel6ZQKPa2y5KMX2k0oaevSuNlTOVbcGU2Qk5yIiHO7C9TqV0qHguSz
 IZJWBWyNwbvJl/6USnWwW6yA/rorhACkhKF60sdZ772W3ukFIOR+/fiO47x8Kv+1aJ1SEetXBl8
 L3MY9Nr9yjAESvs827Poqk3WkM5uaI6x3hJWpCKf1+lbeTDvlb7e1NsmzRhiqd
X-Google-Smtp-Source: AGHT+IGMFZ4BEUUnJKkfd+74sc/ihLW+WIhc16QhWZk0mUlSnRa8M0GmMab5gsLF2Rp5aZk6ExzLig==
X-Received: by 2002:a05:600c:a49:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-4792aef4202mr13097565e9.14.1764751665551; 
 Wed, 03 Dec 2025 00:47:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca7880asm38226036f8f.31.2025.12.03.00.47.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Dec 2025 00:47:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.2?] tests/tcg: Skip syscall catchpoint test if
 pipe2() syscall not available
Date: Wed,  3 Dec 2025 09:47:43 +0100
Message-ID: <20251203084743.60753-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 tests/tcg/multiarch/gdbstub/catch-syscalls.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/catch-syscalls.py b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
index ccce35902fb..5c654b63f56 100644
--- a/tests/tcg/multiarch/gdbstub/catch-syscalls.py
+++ b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
@@ -22,7 +22,8 @@ def run_test():
         gdb.execute("catch syscall pipe2 read")
     except gdb.error as exc:
         exc_str = str(exc)
-        if "not supported on this architecture" in exc_str:
+        if "not supported on this architecture" in exc_str \
+                or if "Unknown syscall name 'pipe2'" in exc_str:
             print("SKIP: {}".format(exc_str))
             return
         raise
-- 
2.51.0


