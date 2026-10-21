Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DF606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vmexit.de header.i=@vmexit.de header.a=rsa-sha256 header.s=mail header.b=JUx0jFWf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJUBm-00074f-58; Wed, 21 Oct 2026 07:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJUBg-00073b-2s; Wed, 21 Oct 2026 07:08:52 -0400
Received: from vmexit.de ([159.195.53.62] helo=gizmo.vmexit.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJUBe-0007cL-5E; Wed, 21 Oct 2026 07:08:51 -0400
From: Ralf Ramsauer <ralf@vmexit.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmexit.de; s=mail;
 t=1792580924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cSTFoJVpKgHR1iRzy5JfRqmFSXJbw6pkp1kXAoKjj7k=;
 b=JUx0jFWf19LuQ+04lZesBHRx36+QoCMU/tOgoL1DM1Ds26Is3+ULGdoK8Zol3g7onDBYPR
 eoliDOvc/p79LtaNJpgBQL8LOLG+NAi3f9NFBgb8454p8DzWxcXU+TB6uZ/m5FFcqQEbZh
 X0IyqEdKJiq3fIda1jbGTOfaivQi6UU=
To: qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Ralf Ramsauer <ralf@vmexit.de>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: [PATCH v2 0/4] hw/riscv: describe only the PLIC contexts that exist
Date: Wed, 21 Oct 2026 13:08:33 +0200
Message-ID: <20261021110838.3097959-1-ralf@vmexit.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=159.195.53.62; envelope-from=ralf@vmexit.de;
 helo=gizmo.vmexit.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A PLIC context is addressed by its position in the 'interrupts-extended'
property, so the device tree and the device have to agree on which harts
contribute a context and in which order.  On the virt machine they do
not: the device is built from riscv_plic_hart_config_string(), which
gives a hart a supervisor context only if it has supervisor mode, while
the device tree lists a machine and a supervisor context for every hart,
unconditionally.  Boot with

    -cpu rv64,h=false,s=false,u=false -smp 4

and the PLIC implements four contexts while the device tree advertises
eight.  A guest that takes its context number from the property then gets
it wrong for every hart but the first.  This is what an M-mode kernel on
virt runs into.  sifive_u hardcodes the fu540 topology instead and has
the same latent problem, reachable with -cpu since the board restricts
neither the CPU type nor its extensions.

1 to 3 are the fix, 4 is cleanup and can be dropped, the rest does not
depend on it.

Tested by comparing the PLIC's 'interrupts-extended' against the
hart-config string of the PLIC device over 14 configurations of both
boards: 7 disagree before the series, all agree after, and the device
tree is unchanged wherever the default CPU is used.  The KVM paths could
not be exercised, for lack of hardware.

v1: https://lore.kernel.org/qemu-devel/20260927231838.236616-1-ralf@vmexit.de/

Ralf Ramsauer (4):
  target/riscv: add riscv_cpu_has_supervisor_mode()
  hw/riscv/virt: only describe PLIC contexts that exist
  hw/riscv/sifive_u: derive PLIC contexts from the harts
  hw/riscv: share the PLIC interrupt cells between boards

 hw/riscv/fdt-common.c         | 20 ++++++++++++++++++++
 hw/riscv/sifive_u.c           | 17 ++++++-----------
 hw/riscv/virt.c               | 26 ++++++++------------------
 include/hw/riscv/fdt-common.h |  3 +++
 target/riscv/cpu.c            | 14 ++++++++++++++
 target/riscv/cpu.h            |  1 +
 6 files changed, 52 insertions(+), 29 deletions(-)


base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1
-- 
2.54.0


