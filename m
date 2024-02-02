Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EB8C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmT1-0002SI-JP; Fri, 02 Feb 2024 00:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSz-0002Bh-4s
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:57 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSx-00026o-Jf
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:56 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bd72353d9fso1332417b6e.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853114; x=1707457914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVBvMUdV2y5YTBfcwLaxMR/FCDaPatuMxQEr9twVZ58=;
 b=dX3VzSusWEkCgUa/O/PzpYWdkRaLI7czUC2/HhPhVGHSV8aLGnce1mAFmQoxD+Hdsg
 eUanpu92U4M4YupjtLuvGwLipSCG+olri0b1XFbVMKnJqYqDpW/R3tlT9324dwuW8pWW
 CXDrBmptVVQ5VzJxMx2OvcmWdVfUlFLcT5y/8uAztPZha7A1SiZrM/DyTgbTEQohavEE
 ssh7DptjkO6EwrEIATXY9TKeVySckThhMgbDsejyuDX9EHR7wBc2d562xNLSvUwQbPRd
 sbnWKnT/TB7gm0I/LyWv/T+JRXyQoles1DRpmhUNa+sBlHxzhjlVaH32qT8OHV6UIj56
 7ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853114; x=1707457914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVBvMUdV2y5YTBfcwLaxMR/FCDaPatuMxQEr9twVZ58=;
 b=hK+t6QpbXe7QmdQjFeVNFR5gHEUyjxOkZYQpKEYJodAfvgpPe2TH1J1HGoSHKSVN+s
 R0e7afqLKZW+HBszPZKlVCEi9EEH4mf54sTJ9z/4MJo9n2gksGiBg3IWphV25wORjWF0
 kYBKGA4Vs9fgTD8gEdJa2aQtqmk/GT2gjnYCEfH/DCevImlfepRH8PEt5AykqTh4o+NL
 cCKJGpBItw+87pBAcjFP1FaT66OdA0Cqxk/UBpv85kTBXOUEB73uYEG9JT7JCL+KhE+M
 0vj3Ougshj5yED46mSHg6sSOkd28u2hWjFmwg78CtgNW+xmKic0jj3JJMAr0T7ETtnMd
 iUAA==
X-Gm-Message-State: AOJu0YwSz9Y4FhfkfVP3NnV2AndguOHSD2ULJC7dY0v1K3HkAdV4IdVO
 Wq7tb4vZyg1HdIGOZYZ/vXFKl8Xfcux0bKa9wnQVsihc42+tx+YG3TvHeqoFvHKQd+5w62mdHzl
 +NL4=
X-Google-Smtp-Source: AGHT+IH+3EqlMUXcqpwAHRpFFo7sCd1J0Ih23UbXmfaLoh0ZS7v3BZp0r2MlwQMzOjyoDPbQgxcK/g==
X-Received: by 2002:a05:6808:1889:b0:3bf:bcba:6d57 with SMTP id
 bi9-20020a056808188900b003bfbcba6d57mr1673498oib.41.1706853114422; 
 Thu, 01 Feb 2024 21:51:54 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 34/57] tests/tcg: Fix the /proc/self/mem probing in the
 PROT_NONE gdbstub test
Date: Fri,  2 Feb 2024 15:50:13 +1000
Message-Id: <20240202055036.684176-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The `if not probe_proc_self_mem` check never passes, because
probe_proc_self_mem is a function object, which is a truthy value.
Add parentheses in order to perform a function call.

Fixes: dc84d50a7f9b ("tests/tcg: Add the PROT_NONE gdbstub test")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240131220245.235993-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/gdbstub/prot-none.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index e829d3ebc5..7e264589cb 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -20,7 +20,7 @@ def probe_proc_self_mem():
 
 def run_test():
     """Run through the tests one by one"""
-    if not probe_proc_self_mem:
+    if not probe_proc_self_mem():
         print("SKIP: /proc/self/mem is not usable")
         exit(0)
     gdb.Breakpoint("break_here")
-- 
2.34.1


