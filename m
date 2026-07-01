Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E23C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wexJr-0002a2-Dr; Wed, 01 Jul 2026 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wexJp-0002ZV-Uq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:57:45 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wexJn-0005np-GA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1782921427;
 bh=yXCUUvPgdYz7tcDJMijkLwj07Wj7W2aPdemmMHum/pU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V5JStoezch8rs4qqm/oE4v2sDE5XHQN36uS7/PQZNwKmB2SHRehXYBCfzIAu0+dxg
 7Rj1NrNIEB08MejLc/tt4jQXjWTjlSxsht0Z0LQ1BuzfvBw5V+4kDI6SuZ75SN+PUr
 u3kj5tS+OkcGNeLbgwyP+vwscePtoRN28pKD5i7q8xxT8HX+04alyRjdHAU4B1rk5J
 hcBcVQKQS5nr4kss6Hvyig808ab1I1/5sAEca3usHtUhu3iVGuXjPgVvefljYiwElF
 5RaUklxPh7yjSmv/LDearHWX6rVKsS5OQmWjLQvY0cGJxLUDbdyGoORQuyTD56MHwW
 AQBBXzlbhVf1A==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id D29462FF55B;
 Wed,  1 Jul 2026 15:57:07 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 376E2380C9A;
 Wed,  1 Jul 2026 23:57:07 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v5 2/2] docs/about/emulation: document the dlcall plugin
Date: Wed,  1 Jul 2026 23:57:05 +0800
Message-Id: <20260701155705.1737328-3-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701155705.1737328-1-functioner@sjtu.edu.cn>
References: <20260701155705.1737328-1-functioner@sjtu.edu.cn>
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

Document the dlcall plugin under Example Plugins: what it does, the trusted-
guests and guest_base == 0 constraints, how to load it, and a pointer to
Lorelei, a complete userspace implementation, for prebuilt thunks and a
runnable example.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 docs/about/emulation.rst | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3b4c365933..8877708d18 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1046,6 +1046,61 @@ Count traps
 This plugin counts the number of interrupts (asynchronous events), exceptions
 (synchronous events) and host calls (e.g. semihosting) per cpu.
 
+Dlcall
+......
+
+``contrib/plugins/dlcall.c``
+
+This plugin lets a linux-user guest call functions in the host's native shared
+libraries instead of emulating them, turning slow instruction-by-instruction
+emulation of a library into a native host call. For example, the stock zlib
+``minizip`` utility compresses several times faster, because the actual
+``deflate`` runs on the host's native libz while ``minizip`` itself stays
+emulated.
+
+The guest issues a reserved "magic" system call (4096 by default, configurable
+with ``syscall_num=N``) whose first argument selects a pass-through operation:
+dlopen/dlclose a host library, dlsym a symbol, and invoke a resolved host
+function. The plugin performs the operation on the host and consumes the
+syscall, so the real kernel never sees it.
+
+.. warning::
+
+   Trusted guests only. The guest can load arbitrary host libraries and run
+   arbitrary code in the QEMU host process. The plugin is not a sandbox and
+   provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
+   default), as guest pointers are dereferenced as host addresses with no
+   translation.
+
+The plugin is deliberately minimal and knows nothing about any particular
+library or its calling convention. Turning a real library into working thunks,
+including argument marshalling, callbacks and variadic functions, is done
+entirely in userspace, and any toolchain can implement the interface.
+`Lorelei <https://github.com/rover2024/lorelei>`_ is a complete, MIT-licensed
+implementation: it provides the guest and host runtimes and a Thunk Library
+Compiler that generates the thunks from a library's headers, with prebuilt
+thunks (zlib, lzma, ...) for x86_64, aarch64 and riscv64 hosts.
+
+Loading the plugin is all that is required from QEMU's side:
+
+.. code-block:: shell
+
+   qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
+
+See `Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk trees,
+the runtime environment they expect, and a full runnable example (for instance,
+running an unmodified ``minizip`` over the host's native libz).
+
+.. list-table:: Dlcall plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - syscall_num=N
+    - The magic syscall number the guest issues (default 4096). Must be high
+      enough not to clash with a real syscall.
+
 Other emulation features
 ------------------------
 
-- 
2.34.1


