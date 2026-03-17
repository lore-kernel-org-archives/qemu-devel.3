Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688EBFB5EAC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2LBg-00086B-Fg; Mon, 16 Mar 2026 23:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LBc-00085s-NY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:33:42 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LBa-00006i-Dn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:33:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773718399; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jXqTnJ1Gp/LqfuLATM9GPCg7WRHDvdrg6mPbV0oWY6Ggnnb11ffAbp0Zrwfnb5QPP8AXZVFWApwouOo6uq6QUPPRiS9aWvW8uVYgx8aCC7kp3o38QtgCrjUOxxwyfAKAXDcNEDxG4tVaFbzmGWpkNzWGJDRcMUE355e1Odxb4wg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773718399;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lwPKSeGVAukCMFvNUlq73A6uKfdBNQK0o6vQF5BNs7Q=; 
 b=Vs2hjemtPNocpwcod01XMBryH84WInW39gTAvvbfagwiU52y2QPSA8pH2p3HTxot1n3LcZS0R/wIrdszjwsRjH5IZv9OoeUK+maF8uPTg2M9z39Jr92+SxMSAHYjUuvwobg113H3Uc9OWFEvVEG0bCaflG4L7rkSq4/7rkR7OTk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773718399; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=lwPKSeGVAukCMFvNUlq73A6uKfdBNQK0o6vQF5BNs7Q=;
 b=nOzHZYH54CmYWrpU73UGmYWtQdl/zghEs5w94O3EuisTCatsx/h/RLEMRKbBY9QX
 OdW39zRUt0gvD5pDzBexFEekeOd3ZT/kVATLRMSv8V7VVv1QjHI3eImtWqaIDbGpcp6
 jps6wJpPnR8bsGa2MmLwQwTobmQx2m5cEj8t+ihE=
Received: by mx.zohomail.com with SMTPS id 1773718396643305.8906980134186;
 Mon, 16 Mar 2026 20:33:16 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 0/3] cxl: avoid KVM internal error for fixed memory windows
Date: Tue, 17 Mar 2026 11:33:00 +0800
Message-ID: <20260317033304.3185291-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CXL fixed memory windows are currently modeled as an I/O MemoryRegion.
When running under KVM, this makes the entire window look like MMIO.
If Linux onlines the window as system RAM (e.g. for a CXL Type-3
volatile memdev), normal CPU stores into the window trigger KVM
instruction emulation. Instructions like XSAVEC are not supported by
the emulator and abort the VM with a KVM internal error.

Repro:
  - Boot a guest with a CXL Type-3 volatile memdev and a fixed memory window.
  - In the guest, create a RAM region and online it as system RAM:
      cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
  - QEMU exits with a KVM internal error.

Serial output excerpt:
  KVM internal error. Suberror: 1
  extra data[0]: 0x0000000000000001
  extra data[1]: 0xc0314061c70f480f
  extra data[2]: 0x024080f610478b48
  extra data[3]: 0x0000000000000400
  extra data[4]: 0x000000010000000f
  extra data[5]: 0x00000004a0003140
  extra data[6]: 0x0000000000000000
  extra data[7]: 0x0000000000000000
  emulation failure
  RAX=0000000000000007 RBX=ffff8eace0001a40 RCX=ffff8eace0003100 RDX=0000000000000000
  RSI=0000000000000007 RDI=ffff8eace00030c0 RBP=ffffd48ac1747c08 RSP=ffffd48ac1747bc8
  R8 =0000000000000007 R9 =0000000000000007 R10=000000000000000d R11=0000000000000000
  R12=ffff8ea945b51a40 R13=ffffd48ac166c000 R14=0000000000000000 R15=0000000001200000
  RIP=ffffffffaf77a14d RFL=00000256 [---ZAP-] CPL=0 II=0 A20=1 SMM=0 HLT=0
  ES =0000 0000000000000000 00000000 00000000
  CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
  SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
  DS =0000 0000000000000000 00000000 00000000
  FS =0000 00007f997da3fec0 00000000 00000000
  GS =0000 ffff8eab0535d000 00000000 00000000
  LDT=0000 fffffe7600000000 00000000 00000000
  TR =0040 fffffe767cf8f000 00004087 00008b00 DPL=0 TSS64-busy
  GDT=     fffffe767cf8d000 0000007f
  IDT=     fffffe0000000000 00000fff
  CR0=80050033 CR2=000055fd193a6468 CR3=000000010930c000 CR4=00350ef0
  DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
  DR6=00000000ffff0ff0 DR7=0000000000000400
  EFER=0000000000001d01
  Code=0f 1f 44 00 00 48 8b 4f 10 48 8b 41 08 48 89 c2 48 c1 ea 20 <48> 0f c7 61 40 31 c0 48 8b 47 10 f6 80 40 02 00 00 c0 74 1e 48 8b 05 98 f8 e8 01 48 89 47

This series keeps the existing MMIO dispatcher, but turns the fixed
window into a container and (when the window maps linearly to a Type-3
volatile memdev) overlays a RAM alias so KVM can create a memslot for
the range. The mapping is updated when HDM decoders are
committed/uncommitted by the guest.

This patchset is based on master branch 559919ce54927d59b215a4665eda7ab6118a48aa

Local validation on this base confirmed that the issue reproduces
without the series and is fixed with the 3 patches below.

Li Chen (3):
  cxl/type3: expose vmem mapping for fixed windows
  cxl: alias fixed memory windows to RAM under KVM
  cxl: update fixed window mappings on decoder programming

 hw/cxl/cxl-component-utils.c |   2 +
 hw/cxl/cxl-host-stubs.c      |   1 +
 hw/cxl/cxl-host.c            | 189 ++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c           |  59 +++++++++++
 include/hw/cxl/cxl.h         |   5 +
 include/hw/cxl/cxl_device.h  |   3 +
 include/hw/cxl/cxl_host.h    |   1 +
 7 files changed, 258 insertions(+), 2 deletions(-)

-- 
2.52.0

