Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820E2D132BF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wg0-0005sI-UR; Mon, 04 Nov 2024 07:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wfo-0005oW-Q6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:15 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wfl-0004i5-63
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730725149; x=1762261149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T/rNTqrOfdBQUrb2jJtkufIaQ7xLEXJhLbp4lYY5U7w=;
 b=RLVY8GmSZygO+z2+lYZJkHqxy6CYXi+snhIXMmbuvEbxVIDs56yApn55
 VmRUc+o+EAIDZ/pPSh3psoCHTRN10rngC+Prf+nIlFWmAQRDzh54gtupV
 ZB9mY98SUFp8SwS6GVBMQFd1Td2FxiknJH7tkW+uLMSK7Ei5hgfdo+DbX
 2P9L7D9U2oInImerO43jbO/SEo8t6nMHRHzpGXWLeZcF7OeP67XIR4iHY
 UHhRMFqkz8y76ub/Xgc7+5Ob+nvNzQ1cFl5ITWvgfIbyKwTxIxrO2U0GI
 +k6sa00bW5gdlfa8BM6ZQ6UYZvhP6ocu0OXdk6QBIHn3nITQmwhotag9v g==;
X-CSE-ConnectionGUID: +Bwp9aZZQBejBjUGa+gumw==
X-CSE-MsgGUID: MpL19zJfSFOdJTsglpQiqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41524646"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41524646"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:07 -0800
X-CSE-ConnectionGUID: VDBUHQYCRRyLVZsvCXsbjQ==
X-CSE-MsgGUID: zZSkgCnWQR+js1ncHgMycA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; d="scan'208";a="84465220"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:04 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 1/3] intel_iommu: Send IQE event when setting reserved bit in
 IQT_TAIL
Date: Mon,  4 Nov 2024 20:55:34 +0800
Message-Id: <20241104125536.1236118-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

According to VTD spec, Figure 11-22, Invalidation Queue Tail Register,
"When Descriptor Width (DW) field in Invalidation Queue Address Register
(IQA_REG) is Set (256-bit descriptors), hardware treats bit-4 as reserved
and a value of 1 in the bit will result in invalidation queue error."

Current code missed to send IQE event to guest, fix it.

Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8612d0917b..1ecfe47963 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2847,6 +2847,7 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
     if (s->iq_dw && (val & VTD_IQT_QT_256_RSV_BIT)) {
         error_report_once("%s: RSV bit is set: val=0x%"PRIx64,
                           __func__, val);
+        vtd_handle_inv_queue_error(s);
         return;
     }
     s->iq_tail = VTD_IQT_QT(s->iq_dw, val);
-- 
2.34.1


