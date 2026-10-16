Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23882CCF2C6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoH3-0003FM-Dk; Fri, 16 Oct 2026 16:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elliotjb+anduril@elliotjb.com>)
 id 1xHnQ7-0004UR-HH
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 15:16:49 -0400
Received: from out-zbxj-a71.jellyfish.systems ([198.54.127.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elliotjb+anduril@elliotjb.com>)
 id 1xHnQ4-0000EH-Pn
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 15:16:46 -0400
Received: from mail.privateemail.com (unknown [77.233.63.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.privateemail.com (Postfix) with ESMTPSA id 4j5vmy6Gxrz8sWQ;
 Fri, 16 Oct 2026 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elliotjb.com;
 s=default; t=1792178181;
 bh=IH115nEcX3wMMBl3s9JP1vCjyeMhsxpNDYtgxTe5Oyc=;
 h=From:Date:Subject:To:Cc:From;
 b=VEskACSTZ7EowKwLMzsPuFzjs3IKrc97ZDyIYrpzavVCC3/exRwHV1ZN/C43gIkyA
 dA7yDuJP4UBylnWE9H1At9pDr2HG/qgKLSKRJDiKBizonRdghWgtLo2dUQcaGzE0Jk
 Wev/Noduu6x/K8lHAgLm6SH5NjqZavCrqSFwFeg3I8i0u9Guw/h9IAePYvfl2KBCfO
 TSWiFA+N5y8ulYcCMHs1A7cVwYgOYRVtZtjN+L16e+4Op+5YzCXm+zLVwu+zTMMdVD
 pBPpNRN68RLNkdNQov3S84US4VynhKIcCMRyGWnmaDkjLm3D6ZFh/hdZ+zY4yNWPJ+
 bBaNC+AlMixrA==
From: Elliot Berman <elliotjb+anduril@elliotjb.com>
Date: Fri, 16 Oct 2026 12:15:19 -0700
Subject: [PATCH] hw/block/pflash: invalidate TBs on flash update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-pflash-update-invalidate-tbs-v1-1-3cf1ecaa76bc@elliotjb.com>
X-B4-Tracking: v=1; b=H4sIAMZ30moC/yXMQQqDMBCF4avIrBswipX2KqWLMZnoiKQhk4gg3
 t1od+/jwb+DUGQSeFc7RFpZ+OcL9KMCM6EfSbEthqZunrrWnQpuQZlUDhZTOf2KC98zDaJ629P
 LYYutcVASIZLj7c5/vn9LHmYy6WrCcZyatBk8gAAAAA==
X-Change-ID: 20261015-pflash-update-invalidate-tbs-7d7e9fa3a3cf
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 qemu-block@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Elliot Berman <elliotjb+anduril@elliotjb.com>
X-Mailer: b4 0.15.2
X-Envelope-From: elliotjb+anduril@elliotjb.com
Received-SPF: pass client-ip=198.54.127.71;
 envelope-from=elliotjb+anduril@elliotjb.com;
 helo=out-zbxj-a71.jellyfish.systems
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 16:11:26 -0400
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

When pflash_cfi01/02 are out of Read Array mode and being reprogrammed
or erased (such as a firmware update) by a guest under TCG, TBs from
when the guest was executing instructions from the pflash are never
invalidated. After re-enabling Read Array, the guest continues to
execute instructions from the stale TBs.

Call memory_region_flush_rom_device() from pflash_update() so the TBs
over the updated range are invalidated.

memory_region_flush_rom_device() asserted that the memory region was in
romd_mode (i.e. Read Array mode), but the pflash is not in romd_mode
when processing MemoryRegionOps->write() commands. Since the RAM can
change even when !romd_mode, relax the assertion so it only checks
rom_device.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Elliot Berman <elliotjb+anduril@elliotjb.com>
---
 hw/block/pflash_cfi01.c | 5 ++++-
 hw/block/pflash_cfi02.c | 3 +++
 system/physmem.c        | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 486fc6350d..66ecdb0969 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -388,12 +388,15 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
     return ret;
 }
 
-/* update flash content on disk */
+/* update flash content on disk and invalidate the guest view of RAM */
 static void pflash_update(PFlashCFI01 *pfl, int offset,
                           int size)
 {
     int offset_end;
     int ret;
+
+    memory_region_flush_rom_device(&pfl->mem, offset, size);
+
     if (pfl->blk) {
         offset_end = offset + size;
         /* widen to sector boundaries */
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 4f72c438c0..22b27366ee 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -419,6 +419,9 @@ static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
 {
     int offset_end;
     int ret;
+
+    memory_region_flush_rom_device(&pfl->orig_mem, offset, size);
+
     if (pfl->blk) {
         offset_end = offset + size;
         /* widen to sector boundaries */
diff --git a/system/physmem.c b/system/physmem.c
index db3dda563d..c532e29571 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3162,7 +3162,7 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
      * necessary.  Other memory regions should use the
      * address_space_read/write() APIs.
      */
-    assert(memory_region_is_romd(mr));
+    assert(mr->rom_device);
 
     invalidate_and_set_dirty(mr, addr, size);
 }

---
base-commit: 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269
change-id: 20261015-pflash-update-invalidate-tbs-7d7e9fa3a3cf

Best regards,
--  
Elliot Berman <elliotjb+anduril@elliotjb.com>


