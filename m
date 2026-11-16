Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DD606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=am0Sjsnq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3B9-0006Mh-K6; Mon, 16 Nov 2026 15:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3B7-0006Lz-23; Mon, 16 Nov 2026 15:19:49 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3B5-0005YX-H1; Mon, 16 Nov 2026 15:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=oIv7bdEGr9l69fh83QJi8rWGRi0ofJTvgVDawUQIPuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=am0SjsnqA2bOsto+RQ6GN44ip3LUQuvVnniIhe6YrO+ljxAQktqmmsBBoj1FBw5OK
 81VCMNFDESoAlCKZEfuQ2C7e7WahwQ8MwYt7DFQm+x0O0kdoiVKYNum51Eb+i7HpOV
 HZYbLZtDZsEOuH92aD0ev0IHOqPNp3a22v6exBYTvzQIHwdTm2lbyvUQkeKkHMolKK
 vn24SxDsPUkPD2JmekOpW0tUsJVdc3+LXnXs7HN+Jc75SaA0etr2hR1HgScexQG4GW
 2h6ILqZWesG1+pMWx2d2JcvrlbI9591m74BL6v9SpVaJgYy7VNHJQaUnOlP3YCfK78
 vELGhCLSf0xHg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7178C1E713C;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6CFC845FB72;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4F4DEB8DDA; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 06/59] hw/riscv/riscv-iommu: fix entry leak with
 ioatc-limit=0
Date: Mon, 16 Nov 2026 23:18:10 +0300
Message-ID: <20261116201922.534306-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

riscv_iommu_translate() allocates an IOATC entry before passing it to
riscv_iommu_iot_update(). The update helper normally transfers ownership
to the hash table.

When ioatc-limit is zero, however, the helper returns without inserting or
freeing the entry. Every cacheable non-identity translation therefore leaks
one RISCVIOMMUEntry.

Avoid this by disabling caching at the caller when ioatc-limit is zero,
so riscv_iommu_translate() does not allocate an IOATC entry in the first
place. This avoids special-casing entry freeing in riscv_iommu_iot_update()
and keeps the ownership semantics simpler.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Fixes: 9d085a1c3cb2 ("hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)")
Cc: qemu-stable@nongnu.org
Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261005111523.277550-1-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 9c20897e50f44837e53896fe504a63a6dd696c34)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 715e5d760b4..02caa8cf2f8 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2854,7 +2854,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb,
+                                     as->iommu->iot_limit > 0)) {
         /* Translation disabled or fault reported. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-- 
2.47.3


