Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B59BD715D6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 08:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjZOf-00023q-53; Sat, 24 Jan 2026 03:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOd-00022I-I8
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:31 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOc-0002Tk-8d
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 265BB43FA2;
 Sat, 24 Jan 2026 08:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B90C116D0;
 Sat, 24 Jan 2026 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769244809;
 bh=Jf62z9nlMLpALlcWZJZDbVgTeJxR/J8Rcqx9XgcCPa0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WpAsM1uOWX6nttushE3OiRM97m9Sl2tYRjsCvc2iIyz0TDYo9LlWBzdhWDvjkBzZp
 0AmXhrk3J8d4jovB7b+SKQBOOhlbywdudBdwPj3vqZ6mT6K+RCDOf2i26zWJcgCwTR
 goYOLerd25T4Q8Y3BAgJb91NTRCYpvDQd6PwcYaF+XZHz8T9cLoOUdAS1jjm51x40E
 OnLKtUdId02uM8WsyviVUMP/wyq6CA8Skyni+MDw33WX1YJjHHCSMxzPGuDmLaxcoV
 v/jDh1mt/Y+v55p97FFzzEYSQNkGkZA1Sa291q0+ZI/rFFX7ye90SAWbcSai82v2Ww
 tZG0+yDepekAQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 10/11] linux-user: strace: Fix 5th argument of futex syscall
Date: Sat, 24 Jan 2026 09:53:05 +0100
Message-ID: <20260124085306.3996-11-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124085306.3996-1-deller@kernel.org>
References: <20260124085306.3996-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The 5th argument isn't printed, but instead the 4th argument is shown twice.
Fix this, and print the FUTEX_BITSET_MATCH_ANY string constant instead of -1
if the op is FUTEX_WAIT_BITSET or FUTEX_WAKE_BITSET.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/strace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 18bc6c800c..ca67cfd09d 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4150,7 +4150,12 @@ print_futex(CPUArchState *cpu_env, const struct syscallname *name,
             break;
     }
     print_pointer(arg4, 0);
-    print_raw_param("%d", arg4, 1);
+    if ((op == FUTEX_WAIT_BITSET || (op == FUTEX_WAKE_BITSET)) &&
+        (arg5 == FUTEX_BITSET_MATCH_ANY)) {
+        qemu_log("FUTEX_BITSET_MATCH_ANY");
+    } else {
+        print_raw_param("%#x", arg5, 1);
+    }
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.52.0


