Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594F5C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NAw-00006n-R0; Tue, 21 May 2024 06:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NAs-00005f-0N; Tue, 21 May 2024 06:56:54 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NAp-0008HB-Tr; Tue, 21 May 2024 06:56:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 584A3CE0EB3;
 Tue, 21 May 2024 10:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F280FC2BD11;
 Tue, 21 May 2024 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716289006;
 bh=jFEHP/HxdJg8dKiz/gnORoLhiB3ctRE0wdtr+FFr+Sw=;
 h=From:To:Cc:Subject:Date:From;
 b=pA5R+AT0OwbnFuvtJ1prwQvflBYM4PZAwAC0kKqgE8FnCHgm9u3rqKQXCUy7emloC
 i50rhXBfwV/OPyHKkunxBLvcYFSm+717JPNtd0WS1tTRQMDkolsrEP/aGL1nJw+yv/
 kSBSnXJdNGx4mpyJHeG0feAAJ5MpzGOj7ppXTNOVhfshPozxJJQwROdpYyWRumK8Yx
 ebdyUe/rIM9qZ/M+1MHgnTWo3Qb44CHWP3IHeii+PJuGFdC0NRXocka11rYPgd42CB
 IeUtjRtx53+xjjqb2FAk2k5vrxNgQkgrmuEcffpWNB4lKBQG7wCNpS3COTrV1+DKjF
 AFCVHVMWLMwAw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Atish Patra <atishp@atishpatra.org>, Atish Patra <atishp@rivosinc.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
Subject: [PATCH v2 0/3] RISC-V virt MHP support
Date: Tue, 21 May 2024 12:56:32 +0200
Message-Id: <20240521105635.795211-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=bjorn@kernel.org;
 helo=sin.source.kernel.org
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

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V "virt" machine is currently missing memory hotplugging
support (MHP). This series adds the missing virtio-md, and PC-DIMM
support.

I've include both the ACPI MHP/GED/PC-DIMM, and virtio-md in the same
series. The two patches (virtio-md) are probably less controversial,
and can be pulled separately from the last patch.

The first patch includes MHP that works with DT. The second patch is
basic device memory ACPI SRAT plumbing.

The third patch includes ACPI GED, and ACPI MHP/PC-DIMM support.


Changelog

v1->v2:
 * Cap the maximum number of supported ram slots (Daniel)
 * Split the ACPI parts out from virtio-md patch (Daniel)
 * Allow for max 1G PC-DIMM alignment per ram slot (Daniel)
 * Add missing defined(__riscv__) for virtio-mem code
 * Include PC-DIMM MHP supportin the series
 * Misc code structure changes

Cheers,
Björn


Björn Töpel (3):
  hw/riscv/virt: Add memory hotplugging and virtio-md-pci support
  hw/riscv/virt-acpi-build: Expose device memory in ACPI SRAT
  hw/riscv/virt: Add ACPI GED and PC-DIMM MHP support

 hw/riscv/Kconfig           |   5 +
 hw/riscv/virt-acpi-build.c |  23 +++++
 hw/riscv/virt.c            | 183 ++++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-mem.c     |   5 +-
 include/hw/riscv/virt.h    |   6 +-
 5 files changed, 218 insertions(+), 4 deletions(-)


base-commit: 01782d6b294f95bcde334386f0aaac593cd28c0d
-- 
2.40.1


