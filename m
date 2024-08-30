Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9624CA0EE5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjuwY-0007GD-Pf; Fri, 30 Aug 2024 02:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuwV-0007Dc-7a; Fri, 30 Aug 2024 02:17:07 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuwQ-0004ZE-Ul; Fri, 30 Aug 2024 02:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724998611; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=mYuTLJdFio/HXGO94c2tKvgbfF3jyO1uVVtnZDyNLdU=;
 b=p5R4U9oYjduqDGUQ7ZN3TGe2B5qjTN+NPxG3jUECstZ9A+rwZHKWqZNCwFiEM4pOzaD05YTHp0qYZr2KqDtx4qtcdV95VqFmDsOxn2/gQ206iA5dMiio3r8cNOnsjSXh2bSksftiNI03wrXO49xsJ0jo7oY2R0+fGTlOojm+uUE=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDvaqxi_1724998609) by smtp.aliyun-inc.com;
 Fri, 30 Aug 2024 14:16:50 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 00/14] tcg/riscv: Add support for vector
Date: Fri, 30 Aug 2024 14:15:53 +0800
Message-Id: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

v2:
  1. Remove [PATCH v1 03/15] and use a simpler approach with fixed
  constraints at initialization in the backend instead of modifying
  register allocation constraints in tcg.c. See details in 2.

  2. Change the available vector registers, and the constraint registers
  which are defined in "tcg-target-con-str.h", to the minimum for all
  vector instructions; for TCG_TYPE_V256 (vlen=64, lmul=4, omitting v0),
  max 7 registers, and TCG_TYPE_V128/64 also use only 7.

  3. Remove all inline markers; let the compiler decide.

  4. Merge thread variables to use only prev_vtype.

  5. Increase use of whole load/store instructions when bit width ≥ vlen.

  6. Add vmv<nr>r.v to move registers when bit width ≥ vlen.

  7. Configure vtype with separate operation length (vl) and element
  width (SEW); IRs not changing SEW should inherit SEW from the previous IR
  (e.g., load/store/move/dup/dupm, and/or/xor/not). Place set_vec_config
  in the switch.

  8. Change vlen detection to include element width.

  9. Use neg instead of sub in cmp_vec expand.

  10. Complete all expansions in cmp_vec's expand function, not in
  tcg_out_vec_op.

  11. Move some asserts into tcg_out_opc_*.

  12. Remove the check for riscv_vlen >= 64 when enabling vector support. 

  13. Move not_vec to patch 7.

  14. Change OPC_VRSUB_VX to OPC_VRSUB_VI

  15. Move the vsetvli out of the SIGILL probe.

  16. Move the initialization of the riscv_vlen to the cpuinfo_init.

v1:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00205.html

Swung0x48 (1):
  tcg/riscv: Add basic support for vector

TANG Tiancheng (13):
  tcg/op-gvec: Fix iteration step in 32-bit operation
  util: Add RISC-V vector extension probe in cpuinfo
  tcg/riscv: Add riscv vset{i}vli support
  tcg/riscv: Implement vector load/store
  tcg/riscv: Implement vector mov/dup{m/i}
  tcg/riscv: Add support for basic vector opcodes
  tcg/riscv: Implement vector cmp ops
  tcg/riscv: Implement vector neg ops
  tcg/riscv: Implement vector sat/mul ops
  tcg/riscv: Implement vector min/max ops
  tcg/riscv: Implement vector shs/v ops
  tcg/riscv: Implement vector roti/v/x shi ops
  tcg/riscv: Enable native vector support for TCG host

 host/include/riscv/host/cpuinfo.h |   2 +
 tcg/riscv/tcg-target-con-set.h    |   9 +
 tcg/riscv/tcg-target-con-str.h    |   2 +
 tcg/riscv/tcg-target.c.inc        | 961 ++++++++++++++++++++++++++++--
 tcg/riscv/tcg-target.h            |  80 ++-
 tcg/riscv/tcg-target.opc.h        |  20 +
 tcg/tcg-op-gvec.c                 |   2 +-
 util/cpuinfo-riscv.c              |  26 +-
 8 files changed, 1032 insertions(+), 70 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

-- 
2.43.0


