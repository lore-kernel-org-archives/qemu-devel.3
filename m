Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A363CFB424
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 02:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxdw8-0002JB-Uy; Sun, 06 Oct 2024 22:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxdw5-0002Iu-SD; Sun, 06 Oct 2024 22:57:26 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxdw2-0002eK-AL; Sun, 06 Oct 2024 22:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728269825; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=Ou2D+h0i34/RhLqGbAPNsMxg05xuxLlGPqmjh+6R5j8=;
 b=RoPEJzok7/iWmOXGQ/embCKLJwPmcIs/qVyj65ChIySMshwTp8QDB4eXczV1bC9EOoQ8zdJGV0LfSyJ1yeru84mgCrbmEw5faQyoBFkz31Nx361JWsAGg7wvfXEN6wAm0twoHi0fHmOgD64q+Zx0ajvD4shadpcSLJvg70dM7yw=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLJXVG_1728269823) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 10:57:04 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v5 00/12] tcg/riscv: Add support for vector
Date: Mon,  7 Oct 2024 10:56:48 +0800
Message-Id: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

This patch set introduces support for the RISC-V vector extension
in TCG backend for RISC-V targets.

v5:
  1. Improve the signature of co-authors

  2. Add probe for fractional LMUL setting.

  3. Fix bug of INDEX_op_rotlv_vec.

  4. Modify the author's alias swung0x48 to his real name Huang Shiyuan
and add signed-off tag.

  5. Add vtype initialization in tcg_out_call_int() and prepare_host_addr().

v4:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-09/msg00284.html

v3:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-09/msg00060.html

v2:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00679.html

v1:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00205.html

Huang Shiyuan (1):
  tcg/riscv: Add basic support for vector

TANG Tiancheng (11):
  util: Add RISC-V vector extension probe in cpuinfo
  tcg/riscv: Add vset{i}vli and ld/st vec ops
  tcg/riscv: Implement vector mov/dup{m/i}
  tcg/riscv: Add support for basic vector opcodes
  tcg/riscv: Implement vector cmp/cmpsel ops
  tcg/riscv: Implement vector neg ops
  tcg/riscv: Implement vector sat/mul ops
  tcg/riscv: Implement vector min/max ops
  tcg/riscv: Implement vector shi/s/v ops
  tcg/riscv: Implement vector roti/v/x ops
  tcg/riscv: Enable native vector support for TCG host

 host/include/riscv/host/cpuinfo.h |    2 +
 include/tcg/tcg.h                 |    7 +
 tcg/riscv/tcg-target-con-set.h    |    7 +
 tcg/riscv/tcg-target-con-str.h    |    3 +
 tcg/riscv/tcg-target.c.inc        | 1016 ++++++++++++++++++++++++++---
 tcg/riscv/tcg-target.h            |   80 ++-
 tcg/riscv/tcg-target.opc.h        |   12 +
 util/cpuinfo-riscv.c              |   24 +-
 8 files changed, 1031 insertions(+), 120 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

-- 
2.43.0


