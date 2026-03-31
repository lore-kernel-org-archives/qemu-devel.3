Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B1410F9302
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7gTL-0008Re-DI; Tue, 31 Mar 2026 17:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7d99-0004xD-Cw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:45:00 -0400
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7d97-0008BC-2A
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:44:58 -0400
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 99C911049036B;
 Wed,  1 Apr 2026 01:37:46 +0800 (CST)
Received: from xuklXiaoxin (unknown [202.120.32.222])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id D6D8437C8CA;
 Wed,  1 Apr 2026 01:37:45 +0800 (CST)
From: XU Kailiang <xukl2019@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 XU Kailiang <xukl2019@sjtu.edu.cn>
Subject: [PATCH v1 0/3] contrib/plugins: add syscall-filter local-library demos
Date: Wed,  1 Apr 2026 01:36:23 +0800
Message-ID: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232; envelope-from=xukl2019@sjtu.edu.cn;
 helo=smtp232.sjtu.edu.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 31 Mar 2026 17:18:00 -0400
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

Hi,

This series adds two contrib/plugins examples for the linux-user syscall
filter API.

The first patch adds a minimal zlib-based demo. It redirects the guest
loader's library open to a local thunk library and handles the thunk's
magic syscalls by calling the host zlib implementation directly.

The second patch adds a callback-capable qsort prototype. It shows that
the same interface can also bridge callback-style library calls back
into guest translated code, using a small thunk library plus a
ucontext-based host-side bridge.

The final patch extends both demos from the openat()-based loader path
to open() and openat2().

To keep the examples small, both demos currently target x86_64
linux-user and assume guest_base == 0 on a little-endian 64-bit host,
so guest virtual addresses are directly usable as host pointers. The
qsort prototype is built only on hosts with working ucontext support.

Once the demo library path matches, both demos intentionally assert that
opening the thunk library succeeds. These examples are meant to show the
local-library hand-off path once a known thunk library is in place, not
fallback behavior when that local library is missing or unusable.

One limitation is worth calling out explicitly: straightforward local
library hand-off is only part of the problem. Once execution needs to
leave the guest, run host code, and then re-enter guest translated code
again, for example through a host-side function pointer callback,
additional target- and ABI-specific handling is needed. The qsort
prototype shows one such bridge for x86_64 guest callbacks, but this
series does not attempt to provide a general solution for that broader
case.

Patch 1 adds the zlib compression demo.
Patch 2 adds the callback-capable qsort prototype.
Patch 3 extends both demos to open() and openat2().

Reproduction instructions are included in docs/about/emulation.rst and
in each example directory.

Thanks,
XU Kailiang

XU Kailiang (3):
  contrib/plugins: add a zlib compression filter example
  contrib/plugins: add a callback-capable qsort prototype
  contrib/plugins: handle more loader open syscalls in the syscall
    filter demos

 contrib/plugins/meson.build                   |  16 +-
 .../Makefile                                  |  19 +
 .../README.rst                                |  47 ++
 .../callback-demo.c                           |  75 +++
 .../callback-qsort.h                          |  14 +
 .../callback-thunk.S                          |  38 ++
 .../plugins/syscall_filter_callback_qsort.c   | 484 ++++++++++++++++++
 .../syscall_filter_zlib-example/Makefile      |  19 +
 .../syscall_filter_zlib-example/README.rst    |  44 ++
 .../zcompress-demo.c                          |  94 ++++
 .../zcompress-thunk.c                         |  35 ++
 .../zcompress-thunk.h                         |  16 +
 contrib/plugins/syscall_filter_zlib.c         | 319 ++++++++++++
 docs/about/emulation.rst                      |  41 ++
 14 files changed, 1260 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/Makefile
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/README.rst
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-demo.c
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-qsort.h
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-thunk.S
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort.c
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/Makefile
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/README.rst
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-demo.c
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.c
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.h
 create mode 100644 contrib/plugins/syscall_filter_zlib.c


base-commit: 512b794b1091bc4810d28e8ef28addf6344c3889
-- 
2.53.0


