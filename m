Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722A606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW4S-0000QY-Po; Thu, 29 Oct 2026 15:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xMV1E-0008G0-Ub
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:38:33 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xMV1B-00014D-TU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:38:32 -0400
X-Pm-Submission-Id: 4jFtJs5WMLz1DFSl
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>,
 Rishab Pradeep <rishab@rispop.dev>
Subject: [PATCH 0/2] target/riscv: Apply pointer masking to SSPUSH/SSPOPCHK
Date: Thu, 29 Oct 2026 13:37:49 -0500
Message-ID: <20261029183751.11143-1-rishab@rispop.dev>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=57.129.93.249; envelope-from=rishab@rispop.dev;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 15:45:56 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Rishab Pradeep <rishab@rispop.dev>
From:  Rishab Pradeep via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SSPUSH and SSPOPCHK form their effective address from ssp rather than
a GPR, so they bypass get_address() and never apply the pointer-masking
ignore transformation. With pointer masking enabled, a tagged ssp
raises a store/AMO page fault, whereas Spike, Sail and Whisper mask
the access.

Patch 1 factors the address adjustment out of get_address() and
get_address_indexed() into gen_pm_adjust_addr(), with no functional
change. Patch 2 applies it to the SSPUSH/SSPOPCHK address. ssp is still
written back unmasked, and the SSPOPCHK value comparison is unchanged.

Tested with the reproducer from the issue; all four cases now match
Spike.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4758

Rishab Pradeep (2):
  target/riscv: Factor out pointer-masking address adjustment
  target/riscv: Apply pointer masking to SSPUSH/SSPOPCHK addresses

 .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  8 +++++--
 target/riscv/tcg/translate.c                  | 21 ++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.54.0 (Apple Git-157)


