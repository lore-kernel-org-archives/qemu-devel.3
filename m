Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68CBC4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlMGf-0007by-FK; Sun, 19 Jul 2026 03:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMGe-0007bY-C5
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:56 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMGc-00055Y-5D
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1784447283;
 bh=JpFxR/oOZtHQHbbjTkCGwxcezSCE6pTwm7ivEjov8/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fMe/P1Aj9XoxcSCl61l1bgyO9sM3ImSB/VB3tqL0XdvhtjTVQ/U1oHyCIJRYs0S5i
 2/+0L8Fg0Xj5sMl3y7NoDReKIMola3wlRzEuVFUtiqaWnDaYvzaguKeRXeVVqZiJEG
 6NisjjXOUArNVEa2vq58WwN1vhiYJE5hGuvqWvxMLNpFdGLVHooD9EeNwu1MjaTowq
 x1GYnieRqJIcQEl4IpAcMEjFVPRnb2ONPWQlxGJ053Npi2W3S4DWbytfUIuw6i2bRn
 h9amrVZbO3Db0oMrtOxgPBL9vM5Flq1OBSY6Ac6oURjBtskyhpgiNJflyYUElFeK3V
 8sl7M7E8097Rw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id D3E232FF40C;
 Sun, 19 Jul 2026 07:48:03 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 45EB7380C9B;
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
Subject: [PATCH 3/3] docs/about/emulation: sharpen the dlcall boundary and its
 guest requirements
Date: Sun, 19 Jul 2026 15:47:30 +0800
Message-Id: <20260719074730.1520517-4-functioner@sjtu.edu.cn>
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

Record the same data model requirement as the plugin: guest_base == 0 is
necessary but not sufficient.

Describe the magic syscall number the way the plugin now does. It has to be a
number the guest ABI does not use and does not reject before the plugin sees
it, rather than merely a high one, so show syscall_num= being used as well.

A library is not turned into thunks, it is left alone and the thunks are
produced for it, so say that instead. Argument marshalling, callbacks and
variadic functions are also what the plugin does not do, and listing them in
its description blurs the boundary it draws. Move them to Lorelei, where they
are pointed at as a reference.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 docs/about/emulation.rst | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index b861501e85..c58149086c 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1072,14 +1072,13 @@ syscall, so the real kernel never sees it.
    Trusted guests only. The guest can load arbitrary host libraries and run
    arbitrary code in the QEMU host process. The plugin is not a sandbox and
    provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
-   default), as guest pointers are dereferenced as host addresses with no
-   translation.
+   default) and a guest whose pointer width and endianness match the host's, as
+   guest pointers are dereferenced as host addresses with no translation.
 
 The plugin intentionally keeps the QEMU side lightweight and knows nothing
-about any particular library or its calling convention. Turning a real library
-into working thunks, including argument marshalling, callbacks and variadic
-functions, is done entirely in userspace, and any toolchain can implement the
-interface.
+about any particular library or its calling convention. Producing the thunks
+for a real library is done entirely in userspace, and any toolchain can
+implement the interface.
 
 Loading the plugin is all that is required from QEMU's side:
 
@@ -1087,11 +1086,21 @@ Loading the plugin is all that is required from QEMU's side:
 
    qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
 
+If the default number does not suit the guest ABI, pick another one, and build
+the userspace side to issue the same one:
+
+.. code-block:: shell
+
+   qemu-x86_64 -plugin contrib/plugins/libdlcall.so,syscall_num=8192 \
+       <guest-program> ...
+
 `Lorelei <https://github.com/rover2024/lorelei>`_ is one end-to-end userspace
 implementation of this: it provides the guest and host runtimes and an
 automated toolchain that generates the thunks from a library's headers, so guest
-library calls run on the host's native libraries. It supports an x86_64 guest
-running on an x86_64, aarch64 or riscv64 host.
+library calls run on the host's native libraries. How it handles the parts the
+plugin leaves out, including argument marshalling, callbacks and variadic
+functions, can serve as a reference. It supports an x86_64 guest running on an
+x86_64, aarch64 or riscv64 host.
 
 A minimal end-to-end example uses a one-function library, ``libhello.so``, built
 two ways: the guest build tags its output ``(from the guest)`` and the host
@@ -1201,8 +1210,10 @@ which prints::
   * - Option
     - Description
   * - syscall_num=N
-    - The magic syscall number the guest issues (default 4096). Must be high
-      enough not to clash with a real syscall.
+    - The magic syscall number the guest issues (default 4096). It must be a
+      number the guest ABI does not use for a real syscall, and does not
+      reject before the plugin sees it, which bounds the choice from both
+      sides.
 
 Other emulation features
 ------------------------
-- 
2.34.1


