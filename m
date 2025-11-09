Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B16CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDZ1-0007fO-No; Sun, 09 Nov 2025 17:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYz-0007eM-EV
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:09 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYy-0005uB-2I
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:09 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 351D440C18;
 Sun,  9 Nov 2025 22:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06202C4CEF8;
 Sun,  9 Nov 2025 22:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762726027;
 bh=wYG7seUsKS5MQCHJuhkK5pMSkbpMKLwU9uw450sk38c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OOricwARyFaxtHOHf6WkDqy+sWiPRuMBYpRN0HsTJ1i6Y9MuVBG+ftJhUC7bkq0Gd
 n6PUrr7Og4IBKppeSOb9J9nrSS9jNv7ik0SCOaBaEI6g3Gpj57nEYke1GcVBESvsyi
 qTnWguQwFM9WE09UaNPBRjOms/pCIgeQJ6V5GxgZDfGhfG1JedwwejZCVYNvxn4N2j
 psk25HIfvOqhYvmVwT8l2ztVxuuL1VD+T5oFAfl0IMziJ15moMgy1mE/1FatEBwKSX
 yn3cYU8cDBmUf5z7ILUcL/sGbDyOkNinqfUgo5FeF1qN4Z9PUXVcL+cif0Co6JC1+v
 k8knZFCg783Jg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 6/7] ncr710: Use address space of device instead of global
 address space
Date: Sun,  9 Nov 2025 23:06:53 +0100
Message-ID: <20251109220654.46718-7-deller@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109220654.46718-1-deller@kernel.org>
References: <20251109220654.46718-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ba064c6ecf..47a6983491 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -550,7 +550,7 @@ static inline uint8_t ncr710_scsi_fifo_dequeue(NCR710_SCSI_FIFO *fifo,
 static inline uint32_t ncr710_read_dword(NCR710State *s, uint32_t addr)
 {
     uint32_t buf;
-    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+    address_space_read(s->as, addr, MEMTXATTRS_UNSPECIFIED,
                        (uint8_t *)&buf, 4);
     /*
      * The NCR710 datasheet saying "operates internally in LE mode"
@@ -565,7 +565,7 @@ static inline uint32_t ncr710_read_dword(NCR710State *s, uint32_t addr)
 static inline void ncr710_dma_read(NCR710State *s, uint32_t addr,
                                    void *buf, uint32_t len)
 {
-    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+    address_space_read(s->as, addr, MEMTXATTRS_UNSPECIFIED,
                        buf, len);
     NCR710_DPRINTF("Read %d bytes from %08x: ", len, addr);
     for (int i = 0; i < len && i < 16; i++) {
@@ -577,7 +577,7 @@ static inline void ncr710_dma_read(NCR710State *s, uint32_t addr,
 static inline void ncr710_dma_write(NCR710State *s, uint32_t addr,
                                     const void *buf, uint32_t len)
 {
-    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+    address_space_write(s->as, addr, MEMTXATTRS_UNSPECIFIED,
                         buf, len);
     NCR710_DPRINTF("Wrote %d bytes to %08x\n", len, addr);
 }
-- 
2.51.1


