Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6AAC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDw-0007Jw-0G; Mon, 18 Mar 2024 11:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDb-0006Ik-22
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:11 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDO-0007vt-MI
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:06 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c19aaedfdaso2504750b6e.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776873; x=1711381673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM8ZZscE7pj+Z7J5S93rTnFI05PsMASFwHURBr43Ioo=;
 b=bpDlp/bZBp0Tfm/xZuDiczd7K6oJVOlD9Kjly6WDlhkXKVh1So9W3BbInms0dBZf/i
 T/gi7GdLY8dseNDUpw1Ao1Cf9LKGko0qlU0T1OYkcYwy8mPhxYieaKxs+MPDglqDJp+G
 yCZoa+nzBQlL1Jiw4mDbV27LogQuTbbXQx/5z7T94u6ejt1HF0azVznxtpW4oyGXQ7IZ
 BD/vd38V5w7WqF2+agT8Z15+PkHKae7IYLW8SdQLzR6eexmU2YepymcM9exw7qlLDI/r
 i78Nt1yxj88+C/8oFFvRayjJmoQYA8Cr+iaLYrJ/BsR4OaTMh275OuDNiLNTCZlnA7kE
 q5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776873; x=1711381673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM8ZZscE7pj+Z7J5S93rTnFI05PsMASFwHURBr43Ioo=;
 b=WrKptC4grDvGke+pvDQastaCMGDEENHHIJUTSFo7d80DEXzvOT076q0Bqsk8g/9bTb
 E0uy4qBd5F6bHldkLPLOhNZwelkPFF48hsBzqsfdtczIoEeTF9nxmNwKLQUCzw9TQp1R
 pZRsFUK9P2pleV72wmglII1ajqk8egWkIa09jeUmlcIbkPanB16JDwqBGbDrLSzY9P9p
 dig7jfgePHKN0QDr0Q1A3IlTd2Faz0vSoCbVkxM5+sBUDZTZPPpRKX3YFvFQPSG5oYbd
 jmZFVAf4KQlawnxl3LYWfaMa40RQzWDr/Qjr/Endsjc4GYZ60upBzR0O0Euf5SMNzz1i
 r03w==
X-Gm-Message-State: AOJu0YwGnK8NEOCxAqm2hijpuwHhUWCVxqCB+1QUvw8GJo9XShmYfZjk
 ZbjtZWAwSHaUPsQW1fS8c4c8FVthBu4NV8Wn3BT8/51B7l6sYr7jloAt6tAMPrI=
X-Google-Smtp-Source: AGHT+IGNWbQ5CgUyVBADOil/kaYYIUqEDHiRHBkIi+PmLFi1eMsQsvxYJ4h3aj1WR7mRDRauLECeUA==
X-Received: by 2002:a05:6358:291e:b0:17e:8416:53c2 with SMTP id
 y30-20020a056358291e00b0017e841653c2mr13806795rwb.1.1710776873278; 
 Mon, 18 Mar 2024 08:47:53 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 14/24] tests/avocado: reverse_debugging.py mark aarch64 and
 pseries as not flaky
Date: Tue, 19 Mar 2024 01:46:11 +1000
Message-ID: <20240318154621.2361161-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These seem to be quite solid, including on several gitlab CI runs.
Enabling them should help catch breakage in future.

And update the powernv comment -- gitlab isn't the problem, there are
known gaps in implementation.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 92855a02a5..8fe76ff921 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -223,9 +223,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -248,14 +245,10 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     REG_PC = 0x40
 
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
         :avocado: tags=machine:pseries
-        :avocado: tags=flaky
         """
         # SLOF branches back to its entry point, which causes this test
         # to take the 'hit a breakpoint again' path. That's not a problem,
@@ -264,7 +257,7 @@ def test_ppc64_pseries(self):
         self.reverse_debugging()
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/1992
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'powernv migration support is incomplete so rr debugging is flaky')
 
     def test_ppc64_powernv(self):
         """
-- 
2.42.0


