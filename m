Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA45C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NB1-00009P-CF; Tue, 21 May 2024 06:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NAw-00006k-N2; Tue, 21 May 2024 06:56:58 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9NAv-0008J3-3R; Tue, 21 May 2024 06:56:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2238362153;
 Tue, 21 May 2024 10:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BF0C2BD11;
 Tue, 21 May 2024 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716289014;
 bh=izDUykFEQkwQc1xzdS3N2VcVYxMhBjpLt/wly4Hm8+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ptkkf9FNqTWXHMV9wfe3iEC7Qh9Anqly8weuR4s2SCdBoHXrd7L/2lTASBxBX0Y6a
 Htvk+obeXVQC7Vq943+8Ci2oFjdFCZ0ycs1jcPZl2o/filrrMhi8pswOoGyvAI97L+
 +uTBpUyIQM8GMTUCt8JSKCSddpPJJ5jRdGzQOp1/ZicJjbWY4301MAiEZlp4YrU3fW
 7oIg+XAXK0amIU4fG7IPPrvm3ZlCV0Xwpn59ViaGDpwaoHoH1D8mvNbB9z0uu9/Dlv
 Z1IxH7d/jcsknLoeqgH29b1/waqhq73kN0FIY2GwWpcewvLhosaoi5HT6UqeJO4WBy
 ZpFaZMbaUhHMg==
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
Subject: [PATCH v2 2/3] hw/riscv/virt-acpi-build: Expose device memory in ACPI
 SRAT
Date: Tue, 21 May 2024 12:56:34 +0200
Message-Id: <20240521105635.795211-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521105635.795211-1-bjorn@kernel.org>
References: <20240521105635.795211-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=bjorn@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

Now that device memory is supported by RISC-V 'virt', expose that
region in the ACPI SRAT (System/Static Resource Affinity Table).

ACPI SRAT is used by, e.g., the virtio-mem Linux kernel driver [1].

Link: https://virtio-mem.gitlab.io/user-guide/user-guide-linux.html # [1]
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 hw/riscv/virt-acpi-build.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160f8..6dc3baa9ec86 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -610,6 +610,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
         }
     }
 
+    if (ms->device_memory) {
+        build_srat_memory(table_data, ms->device_memory->base,
+                          memory_region_size(&ms->device_memory->mr),
+                          ms->numa_state->num_nodes - 1,
+                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+    }
+
     acpi_table_end(linker, &table);
 }
 
-- 
2.40.1


