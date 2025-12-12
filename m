Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8BFD49230
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 14:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU3xT-0003gB-0w; Fri, 12 Dec 2025 09:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vU3xQ-0003fX-Ca
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:17:20 -0500
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vU3xO-0007Nn-5Y
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:17:20 -0500
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id D23F7129734BC;
 Fri, 12 Dec 2025 22:16:49 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id EB8CB37C91E;
 Fri, 12 Dec 2025 22:16:48 +0800 (CST)
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
Subject: [PATCH v2 0/2] linux-user: add a syscall-filter plugin API
Date: Fri, 12 Dec 2025 22:15:39 +0800
Message-Id: <20251212141541.1792111-1-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp232.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We have resolved the merge conflict of the PATCH v1 [1], rebased on
the latest (9c23f2a7b0b45277693a14074b1aaa827eecdb92).

PATCH v2:
  1. Rebased on newest version of master

PATCH v1:
  1. Format the code

RFC v2:
  1. Simplify the syscall filter mechanism and remove fork-cpu
  2. Add QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER enum

RFC v1:
  1. Add syscall filter registry
  2. Add fork-cpu interface to re-enter cpu_loop when handling syscalls

[1] https://lore.kernel.org/qemu-devel/20251110133442.579086-1-functioner@sjtu.edu.cn/

Ziyang Zhang (2):
  linux-user: add a plugin API to filter syscalls
  tcg tests: add a test to verify the syscall filter plugin API

 include/qemu/plugin-event.h                   |  1 +
 include/qemu/plugin.h                         | 31 +++++++++++-----
 include/qemu/qemu-plugin.h                    | 24 +++++++++++++
 include/user/syscall-trace.h                  | 17 +++++++++
 linux-user/syscall.c                          |  7 ++--
 plugins/api.c                                 |  7 ++++
 plugins/core.c                                | 36 +++++++++++++++++++
 tests/tcg/multiarch/Makefile.target           |  4 ++-
 .../multiarch/test-plugin-syscall-filter.c    | 20 +++++++++++
 tests/tcg/plugins/syscall.c                   | 15 ++++++++
 10 files changed, 150 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c

-- 
2.34.1


