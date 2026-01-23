Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4F0D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInV-00076t-Qq; Fri, 23 Jan 2026 10:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInG-000711-CZ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:50 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInE-000327-NG
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so17095175e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180987; x=1769785787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JToHbgugDjxEqzfYF8RbKzovJI7DlyaCfgxEoUD7oT0=;
 b=utkMeuLB/Os4AR0jr0raOFdqMEuEJNc/guPhcB4f+B4kzzJunZ7WY1IViFTbABYvqc
 8f3WMkcVVz8chPcV832MZkl4JPeEovNxuZ6CTM88n7EMbyYbN6iWMafh+XFfhbKVzjl1
 51896a8sUD1OdsKuZGQGBg8rcL9aDJGsz/WzhtI18h2/XC/BRKsc67nIeAk2vBLKoKZE
 DHr9lRyfR1Rqe+Qp8+M/BEqxbiqK2fPQFvkCfAzyzu7chfmXipr5FBTpFYko8ryj/huE
 0Hg/lcWRtPne1Wgzyzk+kHIRS/QA97EzwBzwMdIVC4XodAiA48WNZWrZ4F6qms0kvJIR
 NDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180987; x=1769785787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JToHbgugDjxEqzfYF8RbKzovJI7DlyaCfgxEoUD7oT0=;
 b=XJVbmEI90i5JlJOfKE0Eag1RngMDXwUs3IwUkvaQJXE6c9UAb4IB3NG8Gidxmcy6iR
 F2s/Qu8r5yq9z/Xh+0+5NOC1Gj92dXzGgB08Tz/51ceBIsBf2b70cQjGBtZJjjDiHbMr
 EI6wVnQd5uOsKhCpt4cLSHQAc+U6ZAaRXwOwavx0UyDsC+UCAix3TE1C6ymY9MwWfuEc
 3MpEJ2cmVld6Yeuf3ggWdjhPP9DKmaDv9fSobPE7CdZE6f1jwwGj1tezCQU/9oAZ3O8T
 YG2CGrGDbJE1NQFfmQaV+zja2Wv9U43kBv9FzFa8YByPq1FfFH27I/Qu52Foggo8YdjW
 mqVQ==
X-Gm-Message-State: AOJu0YwRdgyk5YGTPzdT4hbfqWjFsnrS82rBB5mfhaQy2deVKF4E0yqA
 ntjNaArpJge7nF0pVSqzfGeNJdfND4UBelVfvTU5S+1CGBiaYeFnrQqXuaW4iOOP3vXZwGKpxCV
 dI9N2UIo=
X-Gm-Gg: AZuq6aKjApocstzRB9EZtqPwQ+Wr61d5PxqKIkIHt1AX23Jl51iP8ueOMO4N6+xJb+d
 5OeuzeQi3yEX3dN3tuzgBNhJ+dL1tfAAWjBCUSdS4NkIcf5OHe9GjVRLZID8FnOlx0WTFJaYnF/
 0m1Y/CCP0ViMseKWw3SpcpwLbo/jqOwsRZdkhMDS0z8eXoN8SpPzmouLOnuzKuLs2JvuEJPnbgN
 MrC3J3G8fBP7n4RNqRxJtmRzvJs3QBUmF0+dKnUC5c26Z/sTEXaMbHv/gfqf6HFwlo1YRRSbpyS
 i2eZlQcNfzLc0aevNTlEXOpiLTZYHwGJgsnMZCvWKeGGAWwD6+LFcHUjpJSeApf78RN7ZYplIuV
 NyYkLgR9SZ0RTllznX1A4X66SSkz6GeaRhTBuWFhX1ht6VtvRnvJuufOoz4egLJvc9GT9B9hY9b
 FOvcRxMywMn4ajsggTCPsD7fIkgB8xAoB1MwL9SKY4wNxsPT+k3jKUbA68Yvnhn18=
X-Received: by 2002:a05:600c:1f84:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4804c9cac70mr61882825e9.35.1769180987038; 
 Fri, 23 Jan 2026 07:09:47 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/22] scripts/clean-includes: Allow directories on command line
Date: Fri, 23 Jan 2026 15:09:23 +0000
Message-ID: <20260123150941.1877768-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Currently clean-includes supports two ways of specifying files to check:
 * --all to run on everything
 * specific files
There's no way to say "check everything in target/arm".

Add support for handling directory names, by always running
the arguments through git ls-files.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260116124005.925382-2-peter.maydell@linaro.org
---
 scripts/clean-includes | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 25dbf16c02..07c0fd44e4 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -14,7 +14,7 @@
 # the top-level directory.
 
 # Usage:
-#   clean-includes [--git subjectprefix] [--check-dup-head] file ...
+#   clean-includes [--git subjectprefix] [--check-dup-head] file-or-dir ...
 # or
 #   clean-includes [--git subjectprefix] [--check-dup-head] --all
 #
@@ -28,7 +28,8 @@
 #
 # Using --all will cause clean-includes to run on the whole source
 # tree (excluding certain directories which are known not to need
-# handling).
+# handling). This is equivalent to passing '.' as the directory to
+# scan.
 
 # This script requires Coccinelle to be installed.
 
@@ -86,11 +87,14 @@ if [ $# -eq 0 ]; then
     exit 1
 fi
 
+# --all means "scan everything starting from the current directory"
 if [ "$1" = "--all" ]; then
-    # We assume there are no files in the tree with spaces in their name
-    set -- $(git ls-files '*.[ch]' | grep -E -v "$XDIRREGEX")
+    set -- '.'
 fi
 
+# We assume there are no files in the tree with spaces in their name
+set -- $(git ls-files "$@" | grep '\.[ch]$' | grep -E -v "$XDIRREGEX")
+
 # Annoyingly coccinelle won't read a scriptfile unless its
 # name ends '.cocci', so write it out to a tempfile with the
 # right kind of name.
-- 
2.47.3


