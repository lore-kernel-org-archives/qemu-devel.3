Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F260C3DA7E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsoX-0006YH-MS; Thu, 25 Jul 2024 03:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoW-0006SB-68
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:23:00 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoU-0001Gw-9I
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721892178; x=1753428178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l2lUqV9g3yKHM7XwJAQ7khV4fRpn4ow3j+tpeoa6IUU=;
 b=XZrE2H/SNdPxMJfUCTfc8gelxc/PsTeOYup/iIzD0YxTOD/vfIqctBmT
 2QI5W56ZBfQL1BqwklZbczWy75LSvGp/1GhO9MuWpSbE4LcjFX+s7fuy8
 hgWjBunbxzHwI9jBe4ta6/IRDPiZQct5FhKi6QiJj0TPAQxN5mWVwerij
 VOGcp/OzPM//tUY1oGWsiIA90yN2xl+CovH/dH2xBQy2BYlzAaICCORdo
 rREbw/K3s7UNVv6BXubzdd0BH0IoXZXKJFLsLgW3LvvjB8oiyoSVi2GTS
 1jqSrZne/XmRsqO0bThLeR/nrSuejMEBlE8oiZUE/HgJ04cIzK2oEQdg1 w==;
X-CSE-ConnectionGUID: Y9NJQ+prTaq0AwpWDy3YNw==
X-CSE-MsgGUID: xmGgQH2rT2yXA/3Z31vQOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30754005"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="30754005"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:57 -0700
X-CSE-ConnectionGUID: 3L+kWF1eQP2UnHrtemDUQA==
X-CSE-MsgGUID: aE4D7ZLoSU6JV3CkwMoB0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="52858196"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:54 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Edgecombe Rick P <rick.p.edgecombe@intel.com>,
 Wang Wei W <wei.w.wang@intel.com>, Peng Chao P <chao.p.peng@intel.com>,
 Gao Chao <chao.gao@intel.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [RFC PATCH 5/6] guest-memfd: Default to discarded (private) in
 guest_memfd_manager
Date: Thu, 25 Jul 2024 03:21:14 -0400
Message-ID: <20240725072118.358923-6-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240725072118.358923-1-chenyi.qiang@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

guest_memfd was initially set to shared until the commit bd3bcf6962
("kvm/memory: Make memory type private by default if it has guest memfd
backend"). To align with this change, the default state in
guest_memfd_manager is set to discarded.

One concern raised by this commit is the handling of the virtual BIOS.
The virtual BIOS loads its image into the shared memory of guest_memfd.
However, during the region_commit() stage, the memory attribute is
set to private while its shared memory remains valid. This mismatch
persists until the shared content is copied to the private region.
Fortunately, this interval only exits during setup stage and currently,
only the guest_memfd_manager is concerned with the state of the
guest_memfd at that stage. For simplicity, the default bitmap in
guest_memfd_manager is set to discarded (private). This is feasible
because the shared content of the virtual BIOS will eventually be
discarded and there are no requests to DMA access to this shared part
during this period.

Additionally, setting the default to private can also reduce the
overhead of mapping shared pages into IOMMU by VFIO at the bootup stage.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 system/guest-memfd-manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/guest-memfd-manager.c b/system/guest-memfd-manager.c
index deb43db90b..ad1a46bac4 100644
--- a/system/guest-memfd-manager.c
+++ b/system/guest-memfd-manager.c
@@ -393,6 +393,7 @@ static void guest_memfd_manager_realize(Object *obj, MemoryRegion *mr,
     gmm->mr = mr;
     gmm->discard_bitmap_size = bitmap_size;
     gmm->discard_bitmap = bitmap_new(bitmap_size);
+    bitmap_fill(gmm->discard_bitmap, bitmap_size);
 }
 
 static void guest_memfd_manager_init(Object *obj)
-- 
2.43.5


