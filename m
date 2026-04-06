Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDFEF46C54
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lyV-00078V-UJ; Mon, 06 Apr 2026 11:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w9lyT-000783-W8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:34:50 -0400
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w9lyQ-0008Bg-6M
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:34:48 -0400
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id B7EC3100825FC;
 Mon,  6 Apr 2026 23:34:31 +0800 (CST)
Received: from xuklXiaoxin (unknown [202.120.32.222])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 0381537C8CA;
 Mon,  6 Apr 2026 23:34:30 +0800 (CST)
From: XU Kailiang <xukl2019@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 XU Kailiang <xukl2019@sjtu.edu.cn>
Subject: [PATCH v2 0/1] contrib/plugins: add syscall-filter passthrough zlib
 demo
Date: Mon,  6 Apr 2026 23:32:51 +0800
Message-ID: <20260406153331.8846-1-xukl2019@sjtu.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
References: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232; envelope-from=xukl2019@sjtu.edu.cn;
 helo=smtp232.sjtu.edu.cn
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

This v2 simplifies the earlier series into one minimal, runnable example for
the linux-user syscall filter API.

It adds:

- one plugin: contrib/plugins/passthrough.c
- one matching in-tree example: contrib/plugins/passthrough-examples/ (zlib)

The plugin handles a small passthrough protocol over a magic syscall
(load HTL module, resolve HTL symbol, invoke HTL entry). The zlib guest thunk
library (GTL) uses this protocol to forward selected zlib calls to host-side
HTL/native zlib.

Compared to v1 [1], this version narrows scope:

- drop the callback/qsort prototype
- drop extra demo variants
- keep only a single plugin + single matching example that is easy to build
  and reproduce

Build/repro documentation is provided in:

- docs/about/emulation.rst
- contrib/plugins/passthrough-examples/README.rst

Thanks,
XU Kailiang

[1]: https://lore.kernel.org/qemu-devel/20260331173656.35305-1-xukl2019@sjtu.edu.cn/T/#t

---

XU Kailiang (1):
  contrib/plugins: add syscall-filter passthrough zlib demo

 contrib/plugins/meson.build                   |  11 ++
 contrib/plugins/passthrough-examples/Makefile |  23 +++
 .../plugins/passthrough-examples/README.rst   |  60 +++++++
 .../plugins/passthrough-examples/meson.build  |  19 ++
 .../passthrough-examples/passthrough-gtl.c    |  41 +++++
 .../passthrough-examples/passthrough-gtl.h    |  17 ++
 .../plugins/passthrough-examples/zlib-demo.c  |  90 ++++++++++
 .../plugins/passthrough-examples/zlib-gtl.c   |  72 ++++++++
 .../plugins/passthrough-examples/zlib-htl.c   |  37 ++++
 contrib/plugins/passthrough-protocol.h        |  14 ++
 contrib/plugins/passthrough.c                 | 162 ++++++++++++++++++
 docs/about/emulation.rst                      |  33 ++++
 12 files changed, 579 insertions(+)
 create mode 100644 contrib/plugins/passthrough-examples/Makefile
 create mode 100644 contrib/plugins/passthrough-examples/README.rst
 create mode 100644 contrib/plugins/passthrough-examples/meson.build
 create mode 100644 contrib/plugins/passthrough-examples/passthrough-gtl.c
 create mode 100644 contrib/plugins/passthrough-examples/passthrough-gtl.h
 create mode 100644 contrib/plugins/passthrough-examples/zlib-demo.c
 create mode 100644 contrib/plugins/passthrough-examples/zlib-gtl.c
 create mode 100644 contrib/plugins/passthrough-examples/zlib-htl.c
 create mode 100644 contrib/plugins/passthrough-protocol.h
 create mode 100644 contrib/plugins/passthrough.c


base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
-- 
2.53.0


