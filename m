Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BECDC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNvp-0005Af-72; Sun, 05 Jul 2026 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvn-0005A9-Fi
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvl-00013r-Vg
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmUOAPQVXCl4E0rudTEc0c+PXxTXF2cnu4kF7EBDh3s=;
 b=FVYBax4p8u0fXK2cE6O1J7+IJvUc5zwMG5Ar+AgrtFAJ9lK9KxcP//B7lpP6ZCjg+vGY+E
 cn6hqQLEYy/aqDf/1eZbdFekiKlsJ210iWeLmIM5vwxKKBSvK1kvOePeAOhZTg3H9+bJaN
 LSDQc0ShCoiy4MNYddL9L+ROONHDbxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-632opPjzMtWqerxiJ8hByA-1; Sun, 05 Jul 2026 10:34:47 -0400
X-MC-Unique: 632opPjzMtWqerxiJ8hByA-1
X-Mimecast-MFC-AGG-ID: 632opPjzMtWqerxiJ8hByA_1783262086
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-492714d002cso13444505e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262086; x=1783866886; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CmUOAPQVXCl4E0rudTEc0c+PXxTXF2cnu4kF7EBDh3s=;
 b=AXi88mU0wIbGG38Vho/r59XPLf0q3GAx/jq7Lj8zdqEjrPdqAWzhRjFc1ikgraS8mA
 dYeBdpofriplV3opyVsmtmazf2hX5iwEw7toV8PKfyJo8UtYlL7zMi9BAgGoHyyF8T8n
 5+tlNM/FtoQ25ElY7be1DiVqJOVswUGAqsHJJJqoqAE5HVwkN1Uew5K1PHgEom6S9E/I
 SBKwBlza8ysW2xrDxhQCfadNEnm5nxSAUXGy3cM+ODstdkcJU6s1RF1sHOYH8m8PypfX
 Z9Bl5JFeawTnwR+AQvpqaoXlcESNjAsDFGgdKNt6XxxEloRz3dIFIpMJuRFQaBlaDvXM
 b8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262086; x=1783866886;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CmUOAPQVXCl4E0rudTEc0c+PXxTXF2cnu4kF7EBDh3s=;
 b=YJc9QksC78JIeaoIvay0CnFefurh63UVeDMxse8x9tY7qm6YCE/IdYM5RH1LiIxJt6
 MyempYAADgj0HIcKrPwT2p8ZaWEXyfCTLFNrQmUFkwpnNb+Nz3nL0lnIvJMvePCwpuIB
 cEmLMcZ3McS1sOUN5QP+StQHutd3EjYg+t3Mga8V4Y9UcE0NBFp727+DDUkiCyeP65oh
 GHyBzfvW+C9CBmmgt9MZKf1mnwDyDk/r6sr108tBotDImV050uqvUlekHsPTjlL2O/+y
 yQxkuL5l/yAGvMyRkpMHn7hJ8ERD75Uft4jDjleKdZTxuxxjn2MAiC1h8dtd8NsMiDxV
 PmNg==
X-Gm-Message-State: AOJu0YxKY9vVUtKjN9QvMyjZ4Vs2HWwaYWAgInCPzwXdy5c3wAAoHBj/
 KxB/rxABNSdnqfdpJlyW96lgUhThEnGrLbizGlwXj1Tn/4tMaK7W8UieSIYeIBPK2tOUd2xczu3
 yNxwkTyPxwq5cPMT2EobELZO73Xgeq7AJjms1BUCUEX2sF+5Gnl5R96QcJbCWBLQDxpvzmPXzlR
 8MZFpyHWfincBPWdmKnILPfNdurLNx8t80vg==
X-Gm-Gg: AfdE7clSOvrbcoTJCIqtarrYD1qOVpVbHA6fa0d9PBcEZFW6DaxtmVNRkJBF8eaqXR2
 jSGW2mshvOvIjxTjijyTpHYfNkvE2XWig4R2mRrpp9UWuQl4BDxi85psMc+BGZdNa+YxDsZ+Mx2
 BhWusshkyouy9ER6lTMawilg0Kw9AD7LiS7YqtAzu0lROjpV3FPiw3tdWcZc2PumDRXhilxnV3+
 o8etwW4S2I9TMAQwnLXAVmulMJE3DQ1z9bb6+nfq6W5X1BTyl+0Noy/nUTSkTp7rYODH5mLjUZ9
 cm8qOFTXXYJezpVKJq29ZmjSY7U+vfGltx1iE5QqZ1EG5l+OZgo4GbFOtTsCTT4KQLDVCywbJ/G
 CHVarCODUkeNdafyRmUEMdfyhD5dqfnRh
X-Received: by 2002:a05:600c:a01:b0:493:bd2a:93bb with SMTP id
 5b1f17b1804b1-493d11ced23mr79054585e9.3.1783262086349; 
 Sun, 05 Jul 2026 07:34:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a01:b0:493:bd2a:93bb with SMTP id
 5b1f17b1804b1-493d11ced23mr79054135e9.3.1783262085739; 
 Sun, 05 Jul 2026 07:34:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f8csm260196235e9.11.2026.07.05.07.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:45 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/44] amd_iommu: Return int from page walk status helpers
Message-ID: <784768f7faccf02fcf904db023cd29c790b57443.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 05b7c638f4..a0835a20d7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -659,7 +659,7 @@ static uint64_t large_pte_page_size(uint64_t pte)
  *   - IOVA exceeds the address width supported by DTE[Mode]
  * In all such cases a page walk must be aborted.
  */
-static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
+static int amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
                                                  uint8_t *top_level,
                                                  IOMMUAccessFlags *dte_perms)
 {
@@ -702,7 +702,7 @@ static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
  *      page table walk. This means that the DTE has valid data, but one of the
  *      lower level entries in the Page Table could not be read.
  */
-static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
+static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
                           uint64_t *pte, hwaddr *page_size)
 {
     uint64_t pte_addr;
-- 
MST


