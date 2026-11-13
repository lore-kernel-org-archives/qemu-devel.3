Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B6606A880
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWEuHaXy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xS0T5-0000NP-S5; Fri, 13 Nov 2026 18:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xS0T4-0000Lg-P2; Fri, 13 Nov 2026 18:14:02 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xS0T2-00027y-NB; Fri, 13 Nov 2026 18:14:02 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EE5061E4A;
 Fri, 13 Nov 2026 23:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223A1F000C6;
 Fri, 13 Nov 2026 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794611631;
 bh=Pmlwe+s4TLQaxHmVxRYSWgoqPKtnATRrkXhZjDKxzf4=;
 h=From:Subject:Date:To:Cc;
 b=dWEuHaXyZnyeXIkfo3el+EA1NEbCY3ZHYhQcAuBVPEkRhk2Qdap7oOIYzBW/N3i2M
 fDq8iJy96tH52d93hFlD70ZcXP+Rz9q7ge8X2xuNf1nnL+zyQfd0eHoJCMltOTzLMN
 vYuRIWq348odv/ePsN2oFZeStRSUgmpV2NvWY/7PYunYfLlrpxc9MQTxkCPGRPZ5C9
 MxgSPvtcz4vMC7Bv+z17iG7ic39VR+AxoloVTCM1qlfpHWieVANIHdGptOswBoZqo9
 4JBm9L0rqY1+y15FK7MPicKb50upxg+fPNIFtZi7AMH6qXS9rrWrlSf9xMWG6xankb
 93F1CJ6AjJAog==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v2 0/2] RISC-V: Add support for ACPI RQSC table
Date: Fri, 13 Nov 2026 15:12:38 -0800
Message-Id: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGaZ92oC/02Q22rDMBBEfyXouTLSWpbtUEr+o+RBl1Ui6kutd
 UxLyL9XtlPIy8IszNmZvTPCFJHY8XBnCZdIcRyygLcDc1czXJBHnzUDAVqAkDxFcgtPEzlusBE
 aUZjaGJYN3wlD/Nlgn+esr5HmMf1u7EWu238MvGIWyQX3LijVmBJ9XZ6+MA3YFWO6sPNjByecb
 jncvNOZNYTcjX0f5+PBBl37SgdowLHX4LmHgEoCtM97RNNI0XNnpxRzfgSoZVVCCMelWa09Epm
 n930NK4WshFZtVRdK1FppxSWn2xC7pTuNRMV0M90apMjjY/uCmd11P24r4YWxYJX0bVu2Qjsf8
 sL6/MlStuA1KilzyccfcUD8p4kBAAA=
X-Change-ID: 20260201-riscv-rqsc-ae806ee0a7aa
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Jinjie Ruan <2118537295@qq.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4910; i=fustini@kernel.org;
 h=from:subject:message-id; bh=/GDedJy7SpLFH1rKirkGTQk2ReD8X6VzlgE5FVF09Lg=;
 b=kA0DAAoW2+wsw9kosQwByyZiAGr3mZKjOlOLT1v0xen0d1/YsxkZJcRPb5OHld9O89aRzutUv
 Yh1BAAWCgAdFiEEsvBu0KRKVfWgn+i22+wsw9kosQwFAmr3mZIACgkQ2+wsw9kosQxF5gEA3QFx
 BMfmjf61yXFaWEpykJr9psjMcHsaMMKYGeLYZBQBANMq/fKFnFoqzG07/rGuY05chR64D0wwrcW
 AHtOajiAC
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the ACPI RISC-V Quality of Service Controllers (RQSC)
table [1] that describes the CBQRI controllers [2] present in a system.
A capacity controller is described by the PPTT Cache ID of the cache it
backs. A bandwidth controller is described by the SRAT proximity domain
of its NUMA node.

This series depends on:
 - "riscv: implement Ssqosid extension and CBQRI controllers" v8 [3]
 - "RISC-V: ACPI: Add PPTT support" v2 from Sunil [4]
 - "hw/acpi: Build PPTT rev 3 with cache IDs for MPAM
   cross-references" from Jinjie's MPAM series [5].
   Note: bios-tables-test fails on the riscv64 PPTT golden file
         as this patch does not update it.

Tested with the Linux series [6] at the tip of its b4/ssqosid-cbqri-rqsc
branch [7], with this configuration:

  Base addr  Spacing
  0x4820000  4KB  Cluster 0 L2 cache controller
  0x4821000  4KB  Cluster 1 L2 cache controller
  0x4828000  4KB  Memory controller 0
  0x482b000  4KB  Shared L3 cache controller

  qemu-system-riscv64 \
    -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic,smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluster,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
    -smp cpus=8,sockets=1,clusters=2,cores=4,threads=1 \
    -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
    -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
    -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04820000 \
    -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04821000 \
    -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=16,cache_level=3,mmio_base=0x0482b000 \
    -device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04828000

Changes in v2:
 - Drop the RFC prefix as RQSC v1.0 is ratified
 - Rebase on Sunil's PPTT series and Jinjie's PPTT Cache ID patch
 - Add cache_level and node properties to the CBQRI controllers
 - Use the PPTT Cache ID and the SRAT proximity domain as the resource
   IDs instead of the MMIO address
 - Only build the table when CBQRI controllers are present
 - Set the table revision to 1
 - Make RCID Count and MCID Count 2 bytes each
 - Add the Bandwidth per Block field to memory resources
 - Make RISCV_VIRT select RISCV_CBQRI
 - Link to v1: https://lore.kernel.org/qemu-devel/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/

[1] https://github.com/riscv-non-isa/riscv-rqsc/releases/tag/v1.0.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://lore.kernel.org/qemu-devel/20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org/
[4] https://lore.kernel.org/qemu-devel/20261015064957.4076464-1-sunilvl@oss.qualcomm.com/
[5] https://lore.kernel.org/qemu-devel/tencent_F9C68A515AC6C40BE2C32DB314E14CCB7106@qq.com/
[6] https://lore.kernel.org/all/20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org/
[7] https://github.com/tt-fustini/linux/tree/b4/ssqosid-cbqri-rqsc

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
Drew Fustini (2):
      hw/riscv: add cache_level and node properties to CBQRI controllers
      hw/riscv: add support for ACPI RQSC table

 hw/riscv/Kconfig           |   2 +-
 hw/riscv/cbqri_bandwidth.c |  26 ++++
 hw/riscv/cbqri_capacity.c  |  21 ++++
 hw/riscv/virt-acpi-build.c | 298 ++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/cbqri.h   |  20 +++
 5 files changed, 365 insertions(+), 2 deletions(-)
---
base-commit: bf67d56f282c1ee25b67dfda3f8ca54d2bd4648e
change-id: 20260201-riscv-rqsc-ae806ee0a7aa
prerequisite-change-id: 20251229-riscv-ssqosid-cbqri-aee2271532ff:v8
prerequisite-patch-id: 7d1487071207ac8c9750af152baec0cfa80b704f
prerequisite-patch-id: 7d852a70275071c5b5cfce579bbb442cf5b4d456
prerequisite-patch-id: 6361057143117707a309b225a6e0d6a708e6f5ff
prerequisite-patch-id: b207082f77e5882c20a061cf415055b6832eef7c
prerequisite-patch-id: 2d20f4be6cb77039cca28cb0b774524f88f964b1
prerequisite-patch-id: f3474864af8c82a4d96ac2b99de7abb80458e366
prerequisite-message-id: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
prerequisite-patch-id: 2ff76b9d66b52771c4f963d891f39a6a93fbe5b4
prerequisite-patch-id: 95682b479c131bd09f4bd68426554918e1d43075
prerequisite-patch-id: cca54a74db19c96cb4cf048393dc278d96edd905
prerequisite-patch-id: ee77339d6590704a4240b641ebfc2574f7f29ed5
prerequisite-patch-id: 2b50d0ab2b41d993906cdf0abbd2013192d6e411

Best regards,
--  
Drew Fustini <fustini@kernel.org>


