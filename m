Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E714EC4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlMGV-0007Y8-IH; Sun, 19 Jul 2026 03:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMGT-0007Xh-7i
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:45 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMGR-00055B-2T
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1784447283;
 bh=C6oeDMfOTIgbx58ypYUNM4jUAg3K2SgDysWy+jhYObU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cch0Aq4y7jG5NfZ5KCCqyQO7baBoHAqHKgp3tQL47ftemifHDzbVbxcO3tW5Alr8E
 JIQ1GGrWGlJUMc1KfVMdfevbaIHllZv+kpz2z00odXrssCb9S7Lw/f3h5s4cbt1jmp
 T//h1PtCgZ+7Oz5sxLAaSzhEQ8x11YPYzn1rAmqd3oxO38vSwU5RmG4P4G7itvWSpW
 QwmC5jxGtzSR5y2cAyDWrf3ritjYpTsq4zWqK7S/MktWH56FAqopFhtIr1vHI8YU7h
 OQG0SR8oIWlYrCoXZpE1gVu31Rev6YoL7yQ3IBk9+rgMSAo+zOWrD6iJprOGusyJsv
 we3lKx1zkEmyw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id B3EF22FF40B;
 Sun, 19 Jul 2026 07:48:03 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 223AD380C9A;
 Sun, 19 Jul 2026 15:47:33 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH 2/3] tests/tcg: correct why the magic syscall number is safe
 here
Date: Sun, 19 Jul 2026 15:47:29 +0800
Message-Id: <20260719074730.1520517-3-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
References: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
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

The comment said 4096 was picked because no ISA in Linux uses it. The same
comment already notes that mips 32 bits numbers from 4000, which makes 4096 its
getpriority.

What actually keeps this test safe is the filter, which matches on the first
argument as well, so a real syscall carrying this number is left alone. Say
that instead.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 tests/tcg/multiarch/test-plugin-syscall-filter.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
index 951e338a7c..089fb2a110 100644
--- a/tests/tcg/multiarch/test-plugin-syscall-filter.c
+++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
@@ -23,9 +23,12 @@ int main(int argc, char *argv[])
      * "linux-user/arm/cpu_loop.c:cpu_loop".
      * As well, some arch expect a minimum, like 4000 for mips 32 bits.
      *
-     * Therefore, we pick 4096 because, as of now, no ISA in Linux uses this
-     * number. This is just a test case; replace this number as needed in the
-     * future.
+     * Therefore, we pick 4096, which sits between those bounds. It is not
+     * unused everywhere though: mips 32 bits numbers from 4000, so 4096 is its
+     * getpriority. This test is unaffected because the filter also requires
+     * the first argument to be 0x66CCFF, so a real syscall carrying this
+     * number falls through untouched. This is just a test case, so replace
+     * this number as needed in the future.
      *
      * The corresponding syscall filter is implemented in
      * "tests/tcg/plugins/syscall.c".
-- 
2.34.1


