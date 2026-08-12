Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D8CC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAV4-0000aq-9i; Wed, 12 Aug 2026 11:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuATC-00050A-Ax; Wed, 12 Aug 2026 11:02:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuATA-0002an-A8; Wed, 12 Aug 2026 11:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546234; bh=C/dBOeeZBTvL9Qn1pJGoM991227DvcD9ksYkY6WhHAA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l+2qyrAAQzu0oqo2ebtsCNtxoD+4PGlQIkXkl8YxZxZ+HghYYGcupKaiK+b4TCPAe
 zk7SEF5UBCLWwqs1q9iSV1TFnM5ZTxCT7+c37QqxLMcqhZpBn/P+nNPLrbKDJ1fzTL
 DCgcQ6i/C10JOi1HAlOoknrw5XdlgDTNyYiryDjF3Zo4seU9NV069l4CUc4iRZ8Euf
 ITodUOAU6rO6OEdH6pstNmI/wDx51HySo+Q1C6KzdUYuFFlPFHdFsHeTD+oEeqdd1e
 jqOfjSJWM+ULkA4ITcWn8WwqHNaJYmXVK3UfFQkOYgP4Oy9Vj92FKf1/90xtUwAz96
 Z2hQVk6sHapyg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 126F51CA677;
 Wed, 12 Aug 2026 17:50:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D445409DBC;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CCC092FA49; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 115/120] amd_iommu: Return int from page walk status
 helpers
Date: Wed, 12 Aug 2026 17:49:38 +0300
Message-ID: <20260812144955.649205-115-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

fetch_pte() returns a status code 0 on success, and (small) negative values
on failure. The PTE value itself is returned via an output parameter.
amdvi_get_top_pt_level_and_perms() follows the same return convention.

Both functions currently return uint64_t, which means any negative error
values are returned as unsigned and then converted back to int by the
callers. This does not cause any issues in the current implementation, but
Coverity flags the type mismatch and potential overflow.

Make both helpers return int, so the type matches what the return variable
is (0 on success, small negative value on failure), and also the type used
by all callers to store their return values.

No functional changes are intended.

Fixes: a1c97c395729 ("amd_iommu: Sync shadow page tables on page invalidation")
Fixes: 786550e2d38a ("amd_iommu: Follow root pointer before page walk and use 1-based levels")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630220806.1758748-3-alejandro.j.jimenez@oracle.com>
(cherry picked from commit 784768f7faccf02fcf904db023cd29c790b57443)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 99b05b2ab67..9f01a8a2cda 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -662,7 +662,7 @@ static uint64_t large_pte_page_size(uint64_t pte)
  *   - IOVA exceeds the address width supported by DTE[Mode]
  * In all such cases a page walk must be aborted.
  */
-static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
+static int amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
                                                  uint8_t *top_level,
                                                  IOMMUAccessFlags *dte_perms)
 {
@@ -705,7 +705,7 @@ static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
  *      page table walk. This means that the DTE has valid data, but one of the
  *      lower level entries in the Page Table could not be read.
  */
-static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
+static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
                           uint64_t *pte, hwaddr *page_size)
 {
     uint64_t pte_addr;
-- 
2.47.3


