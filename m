Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D74EE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOPD-0001kn-8z; Wed, 11 Sep 2024 10:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOPA-0001XB-7z; Wed, 11 Sep 2024 10:33:12 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOP5-0004SX-QA; Wed, 11 Sep 2024 10:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726065179; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=R6HZ568hbDiTy9EJqsVh9GUGulpYFKVG6yBon3qsaYU=;
 b=HOhY/Ob6Ogz+EJN3XU3+KqLfMQEshb2OclIpZ3q5xgI1Yur2gfL0rX7n5KB7VL8VlH48S+pWZq6/VTgrJHdm2toWHNP2zhsPbDHkLaSqYAnzw0zZpRiVucQSW2pEMbOZD4LIqCBebk4a0wp0RB9FgT9xuuJg60QTkKVRzLctOko=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEoCzFW_1726061251) by smtp.aliyun-inc.com;
 Wed, 11 Sep 2024 21:27:32 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v4 00/12] tcg/riscv: Add support for vector
Date: Wed, 11 Sep 2024 21:26:18 +0800
Message-Id: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

v4:
  1. Move the implementation of roti/s/v_vec from tcg_expand_vec_op to
tcg_out_vec_op, not just shi_vec.

  2. Put shi and shs/v in the same patch.

  3. Put load/store and vset in the same patch.

  4. Change riscv_vlenb to riscv_lg2_vlenb and simplify the probe.

  5. Provide stubs for the required functions and merge the functions'
usage and definitions into one patch.

  6. Replace riscv_host_vtype with riscv_cur_vsew and riscv_cur_type,
and improve the setting of vtype.

  7. Call separate functions(tcg_out_vec_ldst and tcg_out_ldst)
in tcg_out_ld and tcg_out_st.

  8. Optimize dupi_vec for cases where arg = 0 and arg = -1.

  9. Use tcg_out_cmpsel instead of the switch statement.

  10. Ensure that every single patch can compile.

  11. Remove "tcg/op-gvec: Fix iteration step in 32-bit operation" as
it has been incorporated into "tcg: Improve support for cmpsel_vec"
(https://lists.gnu.org/archive/html/qemu-devel/2024-09/msg01281.html).
This patch set depends on that patch set.

v3:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-09/msg00060.html

v2:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00679.html

v1:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00205.html

Swung0x48 (1):
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

 host/include/riscv/host/cpuinfo.h |   2 +
 include/tcg/tcg.h                 |   7 +
 tcg/riscv/tcg-target-con-set.h    |   7 +
 tcg/riscv/tcg-target-con-str.h    |   3 +
 tcg/riscv/tcg-target.c.inc        | 950 +++++++++++++++++++++++++++---
 tcg/riscv/tcg-target.h            |  80 +--
 tcg/riscv/tcg-target.opc.h        |  12 +
 util/cpuinfo-riscv.c              |  24 +-
 8 files changed, 966 insertions(+), 119 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

-- 
2.43.0


