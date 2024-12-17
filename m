Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE33CE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTBC-0003Vi-0f; Tue, 17 Dec 2024 03:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tNTB9-0003V1-8K; Tue, 17 Dec 2024 03:43:43 -0500
Received: from out28-194.mail.aliyun.com ([115.124.28.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tNTB4-0006LT-VM; Tue, 17 Dec 2024 03:43:42 -0500
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.agA.5.m_1734424998 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 17 Dec 2024 16:43:22 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: bmeng.cn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com,
 Chao Liu <lc00631@tecorigin.com>
Subject: [PATCH v1 0/1] Fix the VSTART register was not checked correctly in
 the vext_vv_rm_2 function
Date: Tue, 17 Dec 2024 16:43:04 +0800
Message-ID: <cover.1734423785.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.194;
 envelope-from=lc00631@tecorigin.com; helo=out28-194.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi, all:

Recently, when I was writing a RISCV test, I found that when VL is set to 0, the
instruction should be nop, but when I tested it, I found that QEMU will treat
all elements as tail elements, and in the case of VTA=1, write all elements
to 1.

After troubleshooting, it was found that the vext_vx_rm_1 function was called in
the vext_vx_rm_2, and then the vext_set_elems_1s function was called to process
the tail element, but only VSTART >= vl was checked in the vext_vx_rm_1
function, which caused the tail element to still be processed even if it was
returned in advance.

So I've made the following change:

put VSTART_CHECK_EARLY_EXIT(env) at the beginning of the vext_vx_rm_2 function,
so that the VSTART register is checked correctly.

Regards,
Chao

Chao Liu (1):
  target/riscv: Fix handling of NOP for vstart >= vl in vext_vx_rm_2()

 target/riscv/vector_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.1


