Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kPMez9VB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8k-0008G8-AS; Fri, 27 Nov 2026 01:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6k-0004v8-2z; Fri, 27 Nov 2026 01:06:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6f-00028Z-LF; Fri, 27 Nov 2026 01:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759047; bh=wxygx5Uun+tGO1UOrCYG6Nw6XNw6TQ6vc0TQ68IFOpI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kPMez9VB+DAUAqTY1q7qfZkLZf2FzJvfg7a5/OSn2WhkhwgSganSnvJnYrFvmBiHj
 e+QXTLOQK4etQJNLo/DQybsqjQjEBSxXnSZ0RldG295CgsMp0QaqC0w4yGvW/RfXCL
 eRoXx/pci5jgQ2QTcf2dnDJBKy9DvbWKYaYMtxP462qIXOEet1Vlm4Mip5A3FT6Ubm
 f3Iwk8d10H2gN+XHRaBR/qKHvtgXL+kI0gii8bTESk9weuz5PmluMH7J4hOelnIThQ
 1z//+jIZkpTnJAtGsWXJ6pOISN6KdRvRuQ4c31aVvv3wG1vQVYQoarwpuZFMRSQVLR
 /tEOkj21/73FQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DE6991EA35B;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DC110469986;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D5D9ECF304; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj kodilkar <sarunkod@amd.com>, Michael S. Tsirkin <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 105/152] hw/i386/amd_iommu: Mask address when
 calculating large PTE page size
Date: Fri, 27 Nov 2026 08:54:03 +0300
Message-ID: <20261127055709.39630-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The amd_iommu handling of the "large PTE page size" (where Next Level
bits are 0b111) case is not correct.  We calculate the page size
using the address in the descriptor (as per table 14 of the spec),
but we don't explicitly pick out the Page Address field, instead
passing the whole PTE word to cto64().  This means that a PTE which
incorrectly sets all the reserved high bits can cause cto64() to
return 63 or 64, and we will try to shift by an out of range amount,
which is undefined behaviour.

Mask the PTE with AMDVI_DEV_PT_ROOT_MASK to get the page address
(matching how we do it to get the address for the next page table
level in NEXT_PTE_ADDR).

Cc: qemu-stable@nongnu.org
Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table format")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Sairaj kodilkar <sarunkod@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20261105105816.3012283-1-peter.maydell@linaro.org
(cherry picked from commit c3af4e0af1d7c6cd10a7c824096f73009c8250a4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 687691ec1cc..c06ccaf9254 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -212,7 +212,8 @@
 /*
  * Take a PTE value with mode=0x07 and return the page size it encodes.
  */
-#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
+#define PTE_LARGE_PAGE_SIZE(pte) \
+    (1ULL << (1 + cto64((((pte) & AMDVI_DEV_PT_ROOT_MASK) | 0xfffULL))))
 
 /* Return number of PTEs to use for a given page size (expected power of 2) */
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
-- 
2.47.3


