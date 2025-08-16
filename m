Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335A9CA0EE6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Aug 2025 00:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un5FH-0006oy-Uh; Fri, 15 Aug 2025 20:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un5FC-0006nf-Mh; Fri, 15 Aug 2025 20:58:02 -0400
Received: from mail-m16.yeah.net ([1.95.21.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un5F8-0002SL-4e; Fri, 15 Aug 2025 20:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kb
 JqO6sPW/43RF3ipAVfXqa5qyhJ6z31rr4IRID3RFA=; b=I7EoAoBoF671y5ApZY
 w3VcQmq3vX9ME9O48sR13KPLX3xKaJPh+kbN53mMwCT2dUCw7ko9Tc/KqIDklVTY
 RROIxYnl7H/5IdCQPX+llGa4Y/b7GagP27UTPI3ErjBDxagIb5Rn3TWCsjSMurq4
 u+2ryg8p3OFn/Xr2ZBj5ph2rY=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3VMlX159oJLK7Ag--.12739S2;
 Sat, 16 Aug 2025 08:56:57 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: paolo.savini@embecosm.com, ebiggers@kernel.org, dbarboza@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v3 0/2] [RISCV/RVV] Generate strided vector loads/stores with
 tcg nodes.
Date: Sat, 16 Aug 2025 08:56:41 +0800
Message-ID: <cover.1755305184.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.48.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgD3VMlX159oJLK7Ag--.12739S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1fZw1kur4DXw43Gw18uFg_yoWfKFX_Kr
 ykXFykCF4rWa4rCFW8CF4xXryqkrWSkryayF4UtrZ3WrWkW3Z8Can5Kr1kAFy8uF4fJFn3
 ArZ3A3yfZF9FyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1CzuJUUUUU==
X-Originating-IP: [114.88.98.193]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEgSrKGif1uIBCQAAse
Received-SPF: pass client-ip=1.95.21.16; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi Paolo, Eric, Daniel,

patch v3 changes:
- Fix the get_log2 cunftion:
  https://lore.kernel.org/qemu-riscv/cover.1755287531.git.chao.liu@yeah.net/T/#t
- Add test for vlsseg8e32 instruction.
- Rebase on top of the latest master.

patch v2 changes:
- Split the TCG node emulation of the complex strided load/store operation into
  two separate functions to simplify the implementation:
  https://lore.kernel.org/qemu-riscv/20250312155547.289642-1-paolo.savini@embecosm.com/


Best regards,

Chao

Chao Liu (2):
  Generate strided vector loads/stores with tcg nodes.
  tests/tcg/riscv64: Add test for vlsseg8e32 instruction

 target/riscv/insn_trans/trans_rvv.c.inc   | 326 ++++++++++++++++++----
 tests/tcg/riscv64/Makefile.softmmu-target |   8 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 107 +++++++
 3 files changed, 389 insertions(+), 52 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

-- 
2.50.1


