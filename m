Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AF3C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM8Dd-0006Vn-Gt; Tue, 25 Jun 2024 11:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sM8DX-0006Rd-Ga; Tue, 25 Jun 2024 11:36:24 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sM8DV-00047X-2T; Tue, 25 Jun 2024 11:36:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 13069C0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1719329774;
 bh=Nd53oMq1LYBSjWxUR8e5O2a8/5jUJSGoWrnwWvjdfpU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=dlf8pLl6rpAd2Bk9YS+vk8Xctkk0OkO+mWCWbcG4l1sofSAsHKOKBxHjJMKt3cCou
 cW931V5LdkOGXSEzZcKh/gKUUSezvQVoA0DAY8qZEJVN0T+4m/5b6xnuRD7NumEnIW
 hfLiMWzh2aUtKyEytkP5ieYdXcd6N/tz/kUuhqaaUZy5bEqNfcdPxYFoSo0RbTw7U1
 iUcHyRcFFW/WDlepNa1p2FmPppczkiCXq5sP2L2/+Kn1uuxSED8yl89rgv3PbHz2UL
 IBQE3nPMVxCUZnNuQexWN9hr1wkBO5DmOCW359H1zfTJTwaZgfYkcQtnkHSIRjn/dx
 Y4GlZPbxMxNMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1719329774;
 bh=Nd53oMq1LYBSjWxUR8e5O2a8/5jUJSGoWrnwWvjdfpU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=CT2i92FrbNH6JOJ0vU8MAs4JrZDTePZ2bgrBVv6UtnzFeMNdni/crA2P/XaUDLlKu
 /LyMIiBMmX/BzBUSxhsm7mpazM5EyVKYV93jKSJStWrVDoRPcv0ajtlZ/Wnt+NvlX4
 mcALwEoqdGtpLmYkhFKQhinIFfW/ACAoXHNIE9H/oQir1hjqOCwRsdxME0ltYYy/lg
 reqT2M0SUQFEOR8v6w3TOH8SSDj065agZOJhx8lrGAj6Fe4QAeAbm2WUoRI2uMzcCh
 H8AXlGWL4EIwSuRI/VVS6tQpC7XKXKXwPpLp15mxdcxIFAukAAvsntN4INEMVGzPsf
 S5XMTA1XJ8Ryg==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v3 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Tue, 25 Jun 2024 18:35:53 +0300
Message-ID: <20240625153555.104088-1-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

These patches add functionality for unit testing RISC-V-specific registers.
The first patch adds a Qtest backend, and the second implements a simple test.

---
v3:
   - Refactor, delete additions to libqos framework
---

Ivan Klokov (2):
  target/riscv: Add RISC-V CSR qtest support
  tests/qtest: QTest example for RISC-V CSR register

 target/riscv/cpu.c           | 14 ++++++
 target/riscv/cpu.h           |  3 ++
 target/riscv/csr.c           | 53 +++++++++++++++++++++-
 tests/qtest/libqtest.c       | 27 ++++++++++++
 tests/qtest/libqtest.h       | 14 ++++++
 tests/qtest/meson.build      |  2 +
 tests/qtest/riscv-csr-test.c | 85 ++++++++++++++++++++++++++++++++++++
 7 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1


