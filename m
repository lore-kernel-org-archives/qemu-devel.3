Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06A2C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBgL-00058W-2G; Fri, 12 Apr 2024 03:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBgI-00058B-VW; Fri, 12 Apr 2024 03:50:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBgD-0001oO-UO; Fri, 12 Apr 2024 03:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712908231; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=vxUo2nmvOWUv6Z6G4IdxVKdLu32j+OWL1akdN/FKH8k=;
 b=URTwriJR4sIUQNwZ+yV2Ltm0CHC6rIqKuAw3CSjxBsjkHMG1TRsT4DtHFv9rJfI04KXBF/GJpO8tCrr2SxJGx2OCgb7W2Mcc7PBRmfPzcLo7O/2A6YD/fz4fq0LMAh5cHx+I8euOy8Hisk8NCiViRc9woz2hFdtW3mnRRwGPc9Y=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NaySc_1712908228; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NaySc_1712908228) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:50:29 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 06/65] target/riscv: Implement insns decode rules for
 XTheadVector
Date: Fri, 12 Apr 2024 15:36:36 +0800
Message-ID: <20240412073735.76413-7-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

In this patch, we implement the XTheadVector instructions decode rules
in xtheadvector.decode. In order to avoid compile failure, we add
trans_ functions in trans_xtheadvector.c.inc as placeholders.
Also, we add decode_xtheadvector in decoder_table to support dynamic
building of deocders. There is no performance impact on standard decoding
because the decode_xtheadvector will not be added to decode function array
when ext_xtheadvector is false.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 384 +++++++++++++++++
 target/riscv/meson.build                      |   1 +
 target/riscv/translate.c                      |   3 +
 target/riscv/xtheadvector.decode              | 390 ++++++++++++++++++
 4 files changed, 778 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xtheadvector.c.inc
 create mode 100644 target/riscv/xtheadvector.decode

diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
new file mode 100644
index 0000000000..2dd77d74ab
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -0,0 +1,384 @@
+/*
+ * RISC-V translation routines for the XTheadVector Extension.
+ *
+ * Copyright (c) 2024 Alibaba Group. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "internals.h"
+
+static bool require_xtheadvector(DisasContext *s)
+{
+    return s->cfg_ptr->ext_xtheadvector &&
+           s->mstatus_vs != EXT_STATUS_DISABLED;
+}
+
+#define TH_TRANS_STUB(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
+{                                                          \
+    return require_xtheadvector(s);                        \
+}
+
+TH_TRANS_STUB(th_vsetvli)
+TH_TRANS_STUB(th_vsetvl)
+TH_TRANS_STUB(th_vlb_v)
+TH_TRANS_STUB(th_vlh_v)
+TH_TRANS_STUB(th_vlw_v)
+TH_TRANS_STUB(th_vle_v)
+TH_TRANS_STUB(th_vlbu_v)
+TH_TRANS_STUB(th_vlhu_v)
+TH_TRANS_STUB(th_vlwu_v)
+TH_TRANS_STUB(th_vlbff_v)
+TH_TRANS_STUB(th_vlhff_v)
+TH_TRANS_STUB(th_vlwff_v)
+TH_TRANS_STUB(th_vleff_v)
+TH_TRANS_STUB(th_vlbuff_v)
+TH_TRANS_STUB(th_vlhuff_v)
+TH_TRANS_STUB(th_vlwuff_v)
+TH_TRANS_STUB(th_vsb_v)
+TH_TRANS_STUB(th_vsh_v)
+TH_TRANS_STUB(th_vsw_v)
+TH_TRANS_STUB(th_vse_v)
+TH_TRANS_STUB(th_vlsb_v)
+TH_TRANS_STUB(th_vlsh_v)
+TH_TRANS_STUB(th_vlsw_v)
+TH_TRANS_STUB(th_vlse_v)
+TH_TRANS_STUB(th_vlsbu_v)
+TH_TRANS_STUB(th_vlshu_v)
+TH_TRANS_STUB(th_vlswu_v)
+TH_TRANS_STUB(th_vssb_v)
+TH_TRANS_STUB(th_vssh_v)
+TH_TRANS_STUB(th_vssw_v)
+TH_TRANS_STUB(th_vsse_v)
+TH_TRANS_STUB(th_vlxb_v)
+TH_TRANS_STUB(th_vlxh_v)
+TH_TRANS_STUB(th_vlxw_v)
+TH_TRANS_STUB(th_vlxe_v)
+TH_TRANS_STUB(th_vlxbu_v)
+TH_TRANS_STUB(th_vlxhu_v)
+TH_TRANS_STUB(th_vlxwu_v)
+TH_TRANS_STUB(th_vsxb_v)
+TH_TRANS_STUB(th_vsxh_v)
+TH_TRANS_STUB(th_vsxw_v)
+TH_TRANS_STUB(th_vsxe_v)
+TH_TRANS_STUB(th_vamoswapw_v)
+TH_TRANS_STUB(th_vamoaddw_v)
+TH_TRANS_STUB(th_vamoxorw_v)
+TH_TRANS_STUB(th_vamoandw_v)
+TH_TRANS_STUB(th_vamoorw_v)
+TH_TRANS_STUB(th_vamominw_v)
+TH_TRANS_STUB(th_vamomaxw_v)
+TH_TRANS_STUB(th_vamominuw_v)
+TH_TRANS_STUB(th_vamomaxuw_v)
+TH_TRANS_STUB(th_vamoswapd_v)
+TH_TRANS_STUB(th_vamoaddd_v)
+TH_TRANS_STUB(th_vamoxord_v)
+TH_TRANS_STUB(th_vamoandd_v)
+TH_TRANS_STUB(th_vamoord_v)
+TH_TRANS_STUB(th_vamomind_v)
+TH_TRANS_STUB(th_vamomaxd_v)
+TH_TRANS_STUB(th_vamominud_v)
+TH_TRANS_STUB(th_vamomaxud_v)
+TH_TRANS_STUB(th_vadd_vv)
+TH_TRANS_STUB(th_vadd_vx)
+TH_TRANS_STUB(th_vadd_vi)
+TH_TRANS_STUB(th_vsub_vv)
+TH_TRANS_STUB(th_vsub_vx)
+TH_TRANS_STUB(th_vrsub_vx)
+TH_TRANS_STUB(th_vrsub_vi)
+TH_TRANS_STUB(th_vwaddu_vv)
+TH_TRANS_STUB(th_vwaddu_vx)
+TH_TRANS_STUB(th_vwadd_vv)
+TH_TRANS_STUB(th_vwadd_vx)
+TH_TRANS_STUB(th_vwsubu_vv)
+TH_TRANS_STUB(th_vwsubu_vx)
+TH_TRANS_STUB(th_vwsub_vv)
+TH_TRANS_STUB(th_vwsub_vx)
+TH_TRANS_STUB(th_vwaddu_wv)
+TH_TRANS_STUB(th_vwaddu_wx)
+TH_TRANS_STUB(th_vwadd_wv)
+TH_TRANS_STUB(th_vwadd_wx)
+TH_TRANS_STUB(th_vwsubu_wv)
+TH_TRANS_STUB(th_vwsubu_wx)
+TH_TRANS_STUB(th_vwsub_wv)
+TH_TRANS_STUB(th_vwsub_wx)
+TH_TRANS_STUB(th_vadc_vvm)
+TH_TRANS_STUB(th_vadc_vxm)
+TH_TRANS_STUB(th_vadc_vim)
+TH_TRANS_STUB(th_vmadc_vvm)
+TH_TRANS_STUB(th_vmadc_vxm)
+TH_TRANS_STUB(th_vmadc_vim)
+TH_TRANS_STUB(th_vsbc_vvm)
+TH_TRANS_STUB(th_vsbc_vxm)
+TH_TRANS_STUB(th_vmsbc_vvm)
+TH_TRANS_STUB(th_vmsbc_vxm)
+TH_TRANS_STUB(th_vand_vv)
+TH_TRANS_STUB(th_vand_vx)
+TH_TRANS_STUB(th_vand_vi)
+TH_TRANS_STUB(th_vor_vv)
+TH_TRANS_STUB(th_vor_vx)
+TH_TRANS_STUB(th_vor_vi)
+TH_TRANS_STUB(th_vxor_vv)
+TH_TRANS_STUB(th_vxor_vx)
+TH_TRANS_STUB(th_vxor_vi)
+TH_TRANS_STUB(th_vsll_vv)
+TH_TRANS_STUB(th_vsll_vx)
+TH_TRANS_STUB(th_vsll_vi)
+TH_TRANS_STUB(th_vsrl_vv)
+TH_TRANS_STUB(th_vsrl_vx)
+TH_TRANS_STUB(th_vsrl_vi)
+TH_TRANS_STUB(th_vsra_vv)
+TH_TRANS_STUB(th_vsra_vx)
+TH_TRANS_STUB(th_vsra_vi)
+TH_TRANS_STUB(th_vnsrl_vv)
+TH_TRANS_STUB(th_vnsrl_vx)
+TH_TRANS_STUB(th_vnsrl_vi)
+TH_TRANS_STUB(th_vnsra_vv)
+TH_TRANS_STUB(th_vnsra_vx)
+TH_TRANS_STUB(th_vnsra_vi)
+TH_TRANS_STUB(th_vmseq_vv)
+TH_TRANS_STUB(th_vmseq_vx)
+TH_TRANS_STUB(th_vmseq_vi)
+TH_TRANS_STUB(th_vmsne_vv)
+TH_TRANS_STUB(th_vmsne_vx)
+TH_TRANS_STUB(th_vmsne_vi)
+TH_TRANS_STUB(th_vmsltu_vv)
+TH_TRANS_STUB(th_vmsltu_vx)
+TH_TRANS_STUB(th_vmslt_vv)
+TH_TRANS_STUB(th_vmslt_vx)
+TH_TRANS_STUB(th_vmsleu_vv)
+TH_TRANS_STUB(th_vmsleu_vx)
+TH_TRANS_STUB(th_vmsleu_vi)
+TH_TRANS_STUB(th_vmsle_vv)
+TH_TRANS_STUB(th_vmsle_vx)
+TH_TRANS_STUB(th_vmsle_vi)
+TH_TRANS_STUB(th_vmsgtu_vx)
+TH_TRANS_STUB(th_vmsgtu_vi)
+TH_TRANS_STUB(th_vmsgt_vx)
+TH_TRANS_STUB(th_vmsgt_vi)
+TH_TRANS_STUB(th_vminu_vv)
+TH_TRANS_STUB(th_vminu_vx)
+TH_TRANS_STUB(th_vmin_vv)
+TH_TRANS_STUB(th_vmin_vx)
+TH_TRANS_STUB(th_vmaxu_vv)
+TH_TRANS_STUB(th_vmaxu_vx)
+TH_TRANS_STUB(th_vmax_vv)
+TH_TRANS_STUB(th_vmax_vx)
+TH_TRANS_STUB(th_vmul_vv)
+TH_TRANS_STUB(th_vmul_vx)
+TH_TRANS_STUB(th_vmulh_vv)
+TH_TRANS_STUB(th_vmulh_vx)
+TH_TRANS_STUB(th_vmulhu_vv)
+TH_TRANS_STUB(th_vmulhu_vx)
+TH_TRANS_STUB(th_vmulhsu_vv)
+TH_TRANS_STUB(th_vmulhsu_vx)
+TH_TRANS_STUB(th_vdivu_vv)
+TH_TRANS_STUB(th_vdivu_vx)
+TH_TRANS_STUB(th_vdiv_vv)
+TH_TRANS_STUB(th_vdiv_vx)
+TH_TRANS_STUB(th_vremu_vv)
+TH_TRANS_STUB(th_vremu_vx)
+TH_TRANS_STUB(th_vrem_vv)
+TH_TRANS_STUB(th_vrem_vx)
+TH_TRANS_STUB(th_vwmulu_vv)
+TH_TRANS_STUB(th_vwmulu_vx)
+TH_TRANS_STUB(th_vwmulsu_vv)
+TH_TRANS_STUB(th_vwmulsu_vx)
+TH_TRANS_STUB(th_vwmul_vv)
+TH_TRANS_STUB(th_vwmul_vx)
+TH_TRANS_STUB(th_vmacc_vv)
+TH_TRANS_STUB(th_vmacc_vx)
+TH_TRANS_STUB(th_vnmsac_vv)
+TH_TRANS_STUB(th_vnmsac_vx)
+TH_TRANS_STUB(th_vmadd_vv)
+TH_TRANS_STUB(th_vmadd_vx)
+TH_TRANS_STUB(th_vnmsub_vv)
+TH_TRANS_STUB(th_vnmsub_vx)
+TH_TRANS_STUB(th_vwmaccu_vv)
+TH_TRANS_STUB(th_vwmaccu_vx)
+TH_TRANS_STUB(th_vwmacc_vv)
+TH_TRANS_STUB(th_vwmacc_vx)
+TH_TRANS_STUB(th_vwmaccsu_vv)
+TH_TRANS_STUB(th_vwmaccsu_vx)
+TH_TRANS_STUB(th_vwmaccus_vx)
+TH_TRANS_STUB(th_vmv_v_v)
+TH_TRANS_STUB(th_vmv_v_x)
+TH_TRANS_STUB(th_vmv_v_i)
+TH_TRANS_STUB(th_vmerge_vvm)
+TH_TRANS_STUB(th_vmerge_vxm)
+TH_TRANS_STUB(th_vmerge_vim)
+TH_TRANS_STUB(th_vsaddu_vv)
+TH_TRANS_STUB(th_vsaddu_vx)
+TH_TRANS_STUB(th_vsaddu_vi)
+TH_TRANS_STUB(th_vsadd_vv)
+TH_TRANS_STUB(th_vsadd_vx)
+TH_TRANS_STUB(th_vsadd_vi)
+TH_TRANS_STUB(th_vssubu_vv)
+TH_TRANS_STUB(th_vssubu_vx)
+TH_TRANS_STUB(th_vssub_vv)
+TH_TRANS_STUB(th_vssub_vx)
+TH_TRANS_STUB(th_vaadd_vv)
+TH_TRANS_STUB(th_vaadd_vx)
+TH_TRANS_STUB(th_vaadd_vi)
+TH_TRANS_STUB(th_vasub_vv)
+TH_TRANS_STUB(th_vasub_vx)
+TH_TRANS_STUB(th_vsmul_vv)
+TH_TRANS_STUB(th_vsmul_vx)
+TH_TRANS_STUB(th_vwsmaccu_vv)
+TH_TRANS_STUB(th_vwsmaccu_vx)
+TH_TRANS_STUB(th_vwsmacc_vv)
+TH_TRANS_STUB(th_vwsmacc_vx)
+TH_TRANS_STUB(th_vwsmaccsu_vv)
+TH_TRANS_STUB(th_vwsmaccsu_vx)
+TH_TRANS_STUB(th_vwsmaccus_vx)
+TH_TRANS_STUB(th_vssrl_vv)
+TH_TRANS_STUB(th_vssrl_vx)
+TH_TRANS_STUB(th_vssrl_vi)
+TH_TRANS_STUB(th_vssra_vv)
+TH_TRANS_STUB(th_vssra_vx)
+TH_TRANS_STUB(th_vssra_vi)
+TH_TRANS_STUB(th_vnclipu_vv)
+TH_TRANS_STUB(th_vnclipu_vx)
+TH_TRANS_STUB(th_vnclipu_vi)
+TH_TRANS_STUB(th_vnclip_vv)
+TH_TRANS_STUB(th_vnclip_vx)
+TH_TRANS_STUB(th_vnclip_vi)
+TH_TRANS_STUB(th_vfadd_vv)
+TH_TRANS_STUB(th_vfadd_vf)
+TH_TRANS_STUB(th_vfsub_vv)
+TH_TRANS_STUB(th_vfsub_vf)
+TH_TRANS_STUB(th_vfrsub_vf)
+TH_TRANS_STUB(th_vfwadd_vv)
+TH_TRANS_STUB(th_vfwadd_vf)
+TH_TRANS_STUB(th_vfwadd_wv)
+TH_TRANS_STUB(th_vfwadd_wf)
+TH_TRANS_STUB(th_vfwsub_vv)
+TH_TRANS_STUB(th_vfwsub_vf)
+TH_TRANS_STUB(th_vfwsub_wv)
+TH_TRANS_STUB(th_vfwsub_wf)
+TH_TRANS_STUB(th_vfmul_vv)
+TH_TRANS_STUB(th_vfmul_vf)
+TH_TRANS_STUB(th_vfdiv_vv)
+TH_TRANS_STUB(th_vfdiv_vf)
+TH_TRANS_STUB(th_vfrdiv_vf)
+TH_TRANS_STUB(th_vfwmul_vv)
+TH_TRANS_STUB(th_vfwmul_vf)
+TH_TRANS_STUB(th_vfmacc_vv)
+TH_TRANS_STUB(th_vfnmacc_vv)
+TH_TRANS_STUB(th_vfnmacc_vf)
+TH_TRANS_STUB(th_vfmacc_vf)
+TH_TRANS_STUB(th_vfmsac_vv)
+TH_TRANS_STUB(th_vfmsac_vf)
+TH_TRANS_STUB(th_vfnmsac_vv)
+TH_TRANS_STUB(th_vfnmsac_vf)
+TH_TRANS_STUB(th_vfmadd_vv)
+TH_TRANS_STUB(th_vfmadd_vf)
+TH_TRANS_STUB(th_vfnmadd_vv)
+TH_TRANS_STUB(th_vfnmadd_vf)
+TH_TRANS_STUB(th_vfmsub_vv)
+TH_TRANS_STUB(th_vfmsub_vf)
+TH_TRANS_STUB(th_vfnmsub_vv)
+TH_TRANS_STUB(th_vfnmsub_vf)
+TH_TRANS_STUB(th_vfwmacc_vv)
+TH_TRANS_STUB(th_vfwmacc_vf)
+TH_TRANS_STUB(th_vfwnmacc_vv)
+TH_TRANS_STUB(th_vfwnmacc_vf)
+TH_TRANS_STUB(th_vfwmsac_vv)
+TH_TRANS_STUB(th_vfwmsac_vf)
+TH_TRANS_STUB(th_vfwnmsac_vv)
+TH_TRANS_STUB(th_vfwnmsac_vf)
+TH_TRANS_STUB(th_vfsqrt_v)
+TH_TRANS_STUB(th_vfmin_vv)
+TH_TRANS_STUB(th_vfmin_vf)
+TH_TRANS_STUB(th_vfmax_vv)
+TH_TRANS_STUB(th_vfmax_vf)
+TH_TRANS_STUB(th_vfsgnj_vv)
+TH_TRANS_STUB(th_vfsgnj_vf)
+TH_TRANS_STUB(th_vfsgnjn_vv)
+TH_TRANS_STUB(th_vfsgnjn_vf)
+TH_TRANS_STUB(th_vfsgnjx_vv)
+TH_TRANS_STUB(th_vfsgnjx_vf)
+TH_TRANS_STUB(th_vmfeq_vv)
+TH_TRANS_STUB(th_vmfeq_vf)
+TH_TRANS_STUB(th_vmfne_vv)
+TH_TRANS_STUB(th_vmfne_vf)
+TH_TRANS_STUB(th_vmflt_vv)
+TH_TRANS_STUB(th_vmflt_vf)
+TH_TRANS_STUB(th_vmfle_vv)
+TH_TRANS_STUB(th_vmfle_vf)
+TH_TRANS_STUB(th_vmfgt_vf)
+TH_TRANS_STUB(th_vmfge_vf)
+TH_TRANS_STUB(th_vmford_vv)
+TH_TRANS_STUB(th_vmford_vf)
+TH_TRANS_STUB(th_vfclass_v)
+TH_TRANS_STUB(th_vfmerge_vfm)
+TH_TRANS_STUB(th_vfmv_v_f)
+TH_TRANS_STUB(th_vfcvt_xu_f_v)
+TH_TRANS_STUB(th_vfcvt_x_f_v)
+TH_TRANS_STUB(th_vfcvt_f_xu_v)
+TH_TRANS_STUB(th_vfcvt_f_x_v)
+TH_TRANS_STUB(th_vfwcvt_xu_f_v)
+TH_TRANS_STUB(th_vfwcvt_x_f_v)
+TH_TRANS_STUB(th_vfwcvt_f_xu_v)
+TH_TRANS_STUB(th_vfwcvt_f_x_v)
+TH_TRANS_STUB(th_vfwcvt_f_f_v)
+TH_TRANS_STUB(th_vfncvt_xu_f_v)
+TH_TRANS_STUB(th_vfncvt_x_f_v)
+TH_TRANS_STUB(th_vfncvt_f_xu_v)
+TH_TRANS_STUB(th_vfncvt_f_x_v)
+TH_TRANS_STUB(th_vfncvt_f_f_v)
+TH_TRANS_STUB(th_vredsum_vs)
+TH_TRANS_STUB(th_vredand_vs)
+TH_TRANS_STUB(th_vredor_vs)
+TH_TRANS_STUB(th_vredxor_vs)
+TH_TRANS_STUB(th_vredminu_vs)
+TH_TRANS_STUB(th_vredmin_vs)
+TH_TRANS_STUB(th_vredmaxu_vs)
+TH_TRANS_STUB(th_vredmax_vs)
+TH_TRANS_STUB(th_vwredsumu_vs)
+TH_TRANS_STUB(th_vwredsum_vs)
+TH_TRANS_STUB(th_vfredsum_vs)
+TH_TRANS_STUB(th_vfredmin_vs)
+TH_TRANS_STUB(th_vfredmax_vs)
+TH_TRANS_STUB(th_vfwredsum_vs)
+TH_TRANS_STUB(th_vmand_mm)
+TH_TRANS_STUB(th_vmnand_mm)
+TH_TRANS_STUB(th_vmandnot_mm)
+TH_TRANS_STUB(th_vmxor_mm)
+TH_TRANS_STUB(th_vmor_mm)
+TH_TRANS_STUB(th_vmnor_mm)
+TH_TRANS_STUB(th_vmornot_mm)
+TH_TRANS_STUB(th_vmxnor_mm)
+TH_TRANS_STUB(th_vmpopc_m)
+TH_TRANS_STUB(th_vmfirst_m)
+TH_TRANS_STUB(th_vmsbf_m)
+TH_TRANS_STUB(th_vmsif_m)
+TH_TRANS_STUB(th_vmsof_m)
+TH_TRANS_STUB(th_viota_m)
+TH_TRANS_STUB(th_vid_v)
+TH_TRANS_STUB(th_vext_x_v)
+TH_TRANS_STUB(th_vmv_s_x)
+TH_TRANS_STUB(th_vfmv_f_s)
+TH_TRANS_STUB(th_vfmv_s_f)
+TH_TRANS_STUB(th_vslideup_vx)
+TH_TRANS_STUB(th_vslideup_vi)
+TH_TRANS_STUB(th_vslide1up_vx)
+TH_TRANS_STUB(th_vslidedown_vx)
+TH_TRANS_STUB(th_vslidedown_vi)
+TH_TRANS_STUB(th_vslide1down_vx)
+TH_TRANS_STUB(th_vrgather_vv)
+TH_TRANS_STUB(th_vrgather_vx)
+TH_TRANS_STUB(th_vrgather_vi)
+TH_TRANS_STUB(th_vcompress_vm)
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index b01a6cfb23..1207ba84ed 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -3,6 +3,7 @@ gen = [
   decodetree.process('insn16.decode', extra_args: ['--static-decode=decode_insn16', '--insnwidth=16']),
   decodetree.process('insn32.decode', extra_args: '--static-decode=decode_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
+  decodetree.process('xtheadvector.decode', extra_args: '--static-decode=decode_xtheadvector'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
 ]
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a22fdb59df..ddc6dcb45f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1113,6 +1113,8 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
+#include "decode-xtheadvector.c.inc"
+#include "insn_trans/trans_xtheadvector.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
@@ -1131,6 +1133,7 @@ static inline int insn_len(uint16_t first_word)
 }
 
 const RISCVDecoder decoder_table[] = {
+    { has_xtheadvector_p, decode_xtheadvector },
     { always_true_p, decode_insn32 },
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
diff --git a/target/riscv/xtheadvector.decode b/target/riscv/xtheadvector.decode
new file mode 100644
index 0000000000..47cbf9e24a
--- /dev/null
+++ b/target/riscv/xtheadvector.decode
@@ -0,0 +1,390 @@
+%nf     29:3                     !function=ex_plus_1
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+#
+#
+&r         !extern rd rs1 rs2
+&rmrr      !extern vm rd rs1 rs2
+&rmr       !extern vm rd rs2
+&r2nfvm    !extern vm rd rs1 nf
+&rnfvm     !extern vm rd rs1 rs2 nf
+&rwdvm     vm wd rd rs1 rs2
+#
+@r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
+@r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
+@r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
+@r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
+@r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
+@r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
+@r_vm_0  ...... . ..... ..... ... ..... .......    &rmrr vm=0 %rs2 %rs1 %rd
+@r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
+@r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
+@r2rd    .......   ..... ..... ... ..... ....... %rs2 %rd
+@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
+#
+# *** RV32V Extension ***
+
+th_vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
+th_vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
+
+# *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
+th_vlb_v      ... 100 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+th_vlh_v      ... 100 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+th_vlw_v      ... 100 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+th_vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
+th_vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+th_vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+th_vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+th_vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+th_vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+th_vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+th_vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
+th_vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+th_vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+th_vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+th_vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+th_vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
+th_vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
+th_vse_v      ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
+
+th_vlsb_v     ... 110 . ..... ..... 000 ..... 0000111 @r_nfvm
+th_vlsh_v     ... 110 . ..... ..... 101 ..... 0000111 @r_nfvm
+th_vlsw_v     ... 110 . ..... ..... 110 ..... 0000111 @r_nfvm
+th_vlse_v     ... 010 . ..... ..... 111 ..... 0000111 @r_nfvm
+th_vlsbu_v    ... 010 . ..... ..... 000 ..... 0000111 @r_nfvm
+th_vlshu_v    ... 010 . ..... ..... 101 ..... 0000111 @r_nfvm
+th_vlswu_v    ... 010 . ..... ..... 110 ..... 0000111 @r_nfvm
+th_vssb_v     ... 010 . ..... ..... 000 ..... 0100111 @r_nfvm
+th_vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
+th_vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
+th_vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
+
+th_vlxb_v     ... 111 . ..... ..... 000 ..... 0000111 @r_nfvm
+th_vlxh_v     ... 111 . ..... ..... 101 ..... 0000111 @r_nfvm
+th_vlxw_v     ... 111 . ..... ..... 110 ..... 0000111 @r_nfvm
+th_vlxe_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
+th_vlxbu_v    ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
+th_vlxhu_v    ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
+th_vlxwu_v    ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
+# Vector ordered-indexed and unordered-indexed store insns.
+th_vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm
+th_vsxh_v     ... -11 . ..... ..... 101 ..... 0100111 @r_nfvm
+th_vsxw_v     ... -11 . ..... ..... 110 ..... 0100111 @r_nfvm
+th_vsxe_v     ... -11 . ..... ..... 111 ..... 0100111 @r_nfvm
+
+#*** Vector AMO operations are encoded under the standard AMO major opcode ***
+th_vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamoaddw_v      00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamoxorw_v      00100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamoandw_v      01100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamoorw_v       01000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamominw_v      10000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamomaxw_v      10100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamominuw_v     11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+th_vamoswapd_v     00001 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamoaddd_v      00000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamoxord_v      00100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamoandd_v      01100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamoord_v       01000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamomind_v      10000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamomaxd_v      10100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamominud_v     11000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+th_vamomaxud_v     11100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+
+# *** new major opcode OP-V ***
+th_vadd_vv         000000 . ..... ..... 000 ..... 1010111 @r_vm
+th_vadd_vx         000000 . ..... ..... 100 ..... 1010111 @r_vm
+th_vadd_vi         000000 . ..... ..... 011 ..... 1010111 @r_vm
+th_vsub_vv         000010 . ..... ..... 000 ..... 1010111 @r_vm
+th_vsub_vx         000010 . ..... ..... 100 ..... 1010111 @r_vm
+th_vrsub_vx        000011 . ..... ..... 100 ..... 1010111 @r_vm
+th_vrsub_vi        000011 . ..... ..... 011 ..... 1010111 @r_vm
+th_vwaddu_vv       110000 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwaddu_vx       110000 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwadd_vv        110001 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwadd_vx        110001 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwsubu_vv       110010 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwsubu_vx       110010 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwsub_vv        110011 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwsub_vx        110011 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwaddu_wv       110100 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwaddu_wx       110100 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwadd_wv        110101 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwadd_wx        110101 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
+th_vadc_vvm        010000 1 ..... ..... 000 ..... 1010111 @r_vm_1
+th_vadc_vxm        010000 1 ..... ..... 100 ..... 1010111 @r_vm_1
+th_vadc_vim        010000 1 ..... ..... 011 ..... 1010111 @r_vm_1
+th_vmadc_vvm       010001 1 ..... ..... 000 ..... 1010111 @r_vm_1
+th_vmadc_vxm       010001 1 ..... ..... 100 ..... 1010111 @r_vm_1
+th_vmadc_vim       010001 1 ..... ..... 011 ..... 1010111 @r_vm_1
+th_vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r_vm_1
+th_vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r_vm_1
+th_vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r_vm_1
+th_vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r_vm_1
+th_vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
+th_vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
+th_vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
+th_vor_vv          001010 . ..... ..... 000 ..... 1010111 @r_vm
+th_vor_vx          001010 . ..... ..... 100 ..... 1010111 @r_vm
+th_vor_vi          001010 . ..... ..... 011 ..... 1010111 @r_vm
+th_vxor_vv         001011 . ..... ..... 000 ..... 1010111 @r_vm
+th_vxor_vx         001011 . ..... ..... 100 ..... 1010111 @r_vm
+th_vxor_vi         001011 . ..... ..... 011 ..... 1010111 @r_vm
+th_vsll_vv         100101 . ..... ..... 000 ..... 1010111 @r_vm
+th_vsll_vx         100101 . ..... ..... 100 ..... 1010111 @r_vm
+th_vsll_vi         100101 . ..... ..... 011 ..... 1010111 @r_vm
+th_vsrl_vv         101000 . ..... ..... 000 ..... 1010111 @r_vm
+th_vsrl_vx         101000 . ..... ..... 100 ..... 1010111 @r_vm
+th_vsrl_vi         101000 . ..... ..... 011 ..... 1010111 @r_vm
+th_vsra_vv         101001 . ..... ..... 000 ..... 1010111 @r_vm
+th_vsra_vx         101001 . ..... ..... 100 ..... 1010111 @r_vm
+th_vsra_vi         101001 . ..... ..... 011 ..... 1010111 @r_vm
+th_vnsrl_vv        101100 . ..... ..... 000 ..... 1010111 @r_vm
+th_vnsrl_vx        101100 . ..... ..... 100 ..... 1010111 @r_vm
+th_vnsrl_vi        101100 . ..... ..... 011 ..... 1010111 @r_vm
+th_vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
+th_vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
+th_vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
+th_vmseq_vv        011000 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmseq_vx        011000 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmseq_vi        011000 . ..... ..... 011 ..... 1010111 @r_vm
+th_vmsne_vv        011001 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmsne_vx        011001 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmsne_vi        011001 . ..... ..... 011 ..... 1010111 @r_vm
+th_vmsltu_vv       011010 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmsltu_vx       011010 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmslt_vv        011011 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmslt_vx        011011 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmsleu_vv       011100 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmsleu_vx       011100 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmsleu_vi       011100 . ..... ..... 011 ..... 1010111 @r_vm
+th_vmsle_vv        011101 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmsle_vx        011101 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmsle_vi        011101 . ..... ..... 011 ..... 1010111 @r_vm
+th_vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmsgtu_vi       011110 . ..... ..... 011 ..... 1010111 @r_vm
+th_vmsgt_vx        011111 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmsgt_vi        011111 . ..... ..... 011 ..... 1010111 @r_vm
+th_vminu_vv        000100 . ..... ..... 000 ..... 1010111 @r_vm
+th_vminu_vx        000100 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmin_vv         000101 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmin_vx         000101 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmaxu_vv        000110 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
+th_vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
+th_vmul_vv         100101 . ..... ..... 010 ..... 1010111 @r_vm
+th_vmul_vx         100101 . ..... ..... 110 ..... 1010111 @r_vm
+th_vmulh_vv        100111 . ..... ..... 010 ..... 1010111 @r_vm
+th_vmulh_vx        100111 . ..... ..... 110 ..... 1010111 @r_vm
+th_vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
+th_vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
+th_vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
+th_vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
+th_vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
+th_vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
+th_vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
+th_vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
+th_vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
+th_vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
+th_vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
+th_vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwmulu_vv       111000 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwmulu_vx       111000 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
+th_vmacc_vv        101101 . ..... ..... 010 ..... 1010111 @r_vm
+th_vmacc_vx        101101 . ..... ..... 110 ..... 1010111 @r_vm
+th_vnmsac_vv       101111 . ..... ..... 010 ..... 1010111 @r_vm
+th_vnmsac_vx       101111 . ..... ..... 110 ..... 1010111 @r_vm
+th_vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
+th_vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
+th_vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
+th_vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
+th_vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+th_vmv_v_v         010111 1 00000 ..... 000 ..... 1010111 @r2
+th_vmv_v_x         010111 1 00000 ..... 100 ..... 1010111 @r2
+th_vmv_v_i         010111 1 00000 ..... 011 ..... 1010111 @r2
+th_vmerge_vvm      010111 0 ..... ..... 000 ..... 1010111 @r_vm_0
+th_vmerge_vxm      010111 0 ..... ..... 100 ..... 1010111 @r_vm_0
+th_vmerge_vim      010111 0 ..... ..... 011 ..... 1010111 @r_vm_0
+th_vsaddu_vv       100000 . ..... ..... 000 ..... 1010111 @r_vm
+th_vsaddu_vx       100000 . ..... ..... 100 ..... 1010111 @r_vm
+th_vsaddu_vi       100000 . ..... ..... 011 ..... 1010111 @r_vm
+th_vsadd_vv        100001 . ..... ..... 000 ..... 1010111 @r_vm
+th_vsadd_vx        100001 . ..... ..... 100 ..... 1010111 @r_vm
+th_vsadd_vi        100001 . ..... ..... 011 ..... 1010111 @r_vm
+th_vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
+th_vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
+th_vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
+th_vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
+th_vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
+th_vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
+th_vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
+th_vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
+th_vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
+th_vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
+th_vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
+th_vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
+th_vwsmaccu_vx     111100 . ..... ..... 100 ..... 1010111 @r_vm
+th_vwsmacc_vv      111101 . ..... ..... 000 ..... 1010111 @r_vm
+th_vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
+th_vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
+th_vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
+th_vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
+th_vssrl_vv        101010 . ..... ..... 000 ..... 1010111 @r_vm
+th_vssrl_vx        101010 . ..... ..... 100 ..... 1010111 @r_vm
+th_vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
+th_vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
+th_vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
+th_vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
+th_vnclipu_vv      101110 . ..... ..... 000 ..... 1010111 @r_vm
+th_vnclipu_vx      101110 . ..... ..... 100 ..... 1010111 @r_vm
+th_vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
+th_vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
+th_vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
+th_vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
+th_vfadd_vv        000000 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwadd_vv       110000 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwadd_vf       110000 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwadd_wv       110100 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwadd_wf       110100 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfmul_vv        100100 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfmacc_vv       101100 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfnmacc_vv      101101 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfnmacc_vf      101101 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfmacc_vf       101100 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfmsac_vv       101110 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfmsac_vf       101110 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfnmsac_vv      101111 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfnmsac_vf      101111 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfmadd_vv       101000 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfmadd_vf       101000 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfnmadd_vv      101001 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfnmadd_vf      101001 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwmacc_vv      111100 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwmacc_vf      111100 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwnmacc_vv     111101 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwnmacc_vf     111101 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
+th_vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfsgnj_vv       001000 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfsgnj_vf       001000 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
+th_vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
+th_vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
+th_vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
+th_vmfne_vf        011100 . ..... ..... 101 ..... 1010111 @r_vm
+th_vmflt_vv        011011 . ..... ..... 001 ..... 1010111 @r_vm
+th_vmflt_vf        011011 . ..... ..... 101 ..... 1010111 @r_vm
+th_vmfle_vv        011001 . ..... ..... 001 ..... 1010111 @r_vm
+th_vmfle_vf        011001 . ..... ..... 101 ..... 1010111 @r_vm
+th_vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
+th_vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
+th_vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
+th_vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
+th_vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
+th_vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
+th_vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
+th_vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
+th_vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
+th_vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
+th_vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
+th_vfwcvt_xu_f_v   100010 . ..... 01000 001 ..... 1010111 @r2_vm
+th_vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
+th_vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
+th_vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
+th_vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
+th_vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
+th_vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
+th_vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
+th_vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
+th_vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
+th_vredsum_vs      000000 . ..... ..... 010 ..... 1010111 @r_vm
+th_vredand_vs      000001 . ..... ..... 010 ..... 1010111 @r_vm
+th_vredor_vs       000010 . ..... ..... 010 ..... 1010111 @r_vm
+th_vredxor_vs      000011 . ..... ..... 010 ..... 1010111 @r_vm
+th_vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
+th_vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
+th_vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
+th_vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
+th_vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
+th_vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
+# Vector ordered and unordered reduction sum
+th_vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
+th_vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
+# Vector widening ordered and unordered float reduction sum
+th_vfwredsum_vs    1100-1 . ..... ..... 001 ..... 1010111 @r_vm
+th_vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
+th_vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
+th_vmandnot_mm     011000 - ..... ..... 010 ..... 1010111 @r
+th_vmxor_mm        011011 - ..... ..... 010 ..... 1010111 @r
+th_vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
+th_vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
+th_vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
+th_vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
+th_vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
+th_vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
+th_vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
+th_vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
+th_vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
+th_viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+th_vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+th_vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
+th_vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
+th_vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
+th_vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
+th_vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
+th_vslideup_vi     001110 . ..... ..... 011 ..... 1010111 @r_vm
+th_vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
+th_vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
+th_vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
+th_vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
+th_vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
+th_vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
+th_vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
+th_vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
-- 
2.44.0


