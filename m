Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ECAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Kud-00048G-L7; Mon, 29 Apr 2024 02:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Kub-00041H-R8
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:54 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KuZ-0007m1-UI
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373692; x=1745909692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gm72Rm7U+L4TuGdas02Vu02WgQJhPS7LPsoHu+oxD8c=;
 b=JqUuYu/ihuE9xNU7eytCa9guQ7h2X/lvQrTPt6KbcgBbdIIcSCptQ/3P
 P4ZTvVU2lJR9zVLNAGoqTiByhO/9AiCA8ePUJ7oXfRwyVILHHcHnotFkR
 PdmOj5AIDZ4GgFgaGLieTTeO3yItEMI6XbA0sAhyOO6MQ8ZCP3Rpmg1LH
 igf6Ruf80tRA//cMYTp3eHPFlb+6GXvRqijgYGHW7CHK5V60+rOxNQi6f
 amWJcoAb0I9VVip3DSWDbVPGbZNBer+yts+SpT8FEmoL9yZIO7qSWtLql
 5NMfMIDnlMhGqcM5d5FR/pxn3+cp06TNpwt3CJ1Ln0DjSRce2Kqq0JiwI Q==;
X-CSE-ConnectionGUID: adCeXD2dSpeIc6HsWzE0mQ==
X-CSE-MsgGUID: X2aovDqdQymN+C8ibRGUjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560783"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560783"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:39 -0700
X-CSE-ConnectionGUID: PAnLSJJpTJ6l9PC17znIDQ==
X-CSE-MsgGUID: l1mwrFcHTt6AdgWSuJFz/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488472"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Date: Mon, 29 Apr 2024 14:50:46 +0800
Message-Id: <20240429065046.3688701-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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

If check fails, host device (either VFIO or VDPA device) is not
compatible with current vIOMMU config and should not be passed to
guest.

Only aw_bits is checked for now, we don't care other capabilities
before scalable modern mode is introduced.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4f84e2e801..4a295c41cc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3819,6 +3819,26 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
+                          Error **errp)
+{
+    HostIOMMUDevice *hiod = vtd_hdev->dev;
+    int ret;
+
+    /* Common checks */
+    ret = host_iommu_device_check_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS,
+                                      errp);
+    if (ret < 0) {
+        return ret;
+    }
+    if (s->aw_bits > ret) {
+        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                     HostIOMMUDevice *hiod, Error **errp)
 {
@@ -3829,6 +3849,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         .devfn = devfn,
     };
     struct vtd_as_key *new_key;
+    int ret;
 
     assert(hiod);
 
@@ -3848,6 +3869,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hdev->iommu_state = s;
     vtd_hdev->dev = hiod;
 
+    ret = vtd_check_hdev(s, vtd_hdev, errp);
+    if (ret) {
+        g_free(vtd_hdev);
+        vtd_iommu_unlock(s);
+        return ret;
+    }
+
     new_key = g_malloc(sizeof(*new_key));
     new_key->bus = bus;
     new_key->devfn = devfn;
-- 
2.34.1


