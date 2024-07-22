Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C445EC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnBS-0002D4-BO; Mon, 22 Jul 2024 03:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVnBE-0001bG-C5; Mon, 22 Jul 2024 03:09:58 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVnBC-0007xR-Ac; Mon, 22 Jul 2024 03:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721632194; x=1753168194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GNcd8+e1ykeXTzuWo92JtUoMGk5rOPr76RQ3pZl93o4=;
 b=G69Nipg2hKTpIgxBLyOV1F6R8ZiHxk8VzIEv1Xs+j9ZRjI2C0HQSGuyJ
 JqW2MnhmHp59EU1UFrMZKUa+o1dHR+lh62c6tObhDtoa23oGyFmD55yRE
 fQGCSure5QfT5l5hL1xKbacI76xg0NaLa4zoejJCoLFPugFUdSoIRc0Ri
 355MpH8EM8Ohu/J73L8jq6oiZtWfrmKVlDDzkmQ3mWFR4eJUSFJRlH1Qx
 cLPCyYMjY2IlobDgVWqIpSfKbKa3d6ciSc8Sv3aUzyt5rfK6K66LJCFRn
 DU/qJV5ifSawAXojvPEez3kCfpRIbpNJZDxr08tpPZQDWWPKrpyI9DFBq Q==;
X-CSE-ConnectionGUID: 41R8ouDoRjyYY42UnUQV+Q==
X-CSE-MsgGUID: ozx66F2tRVKdhPkPn4Tt1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19332603"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="19332603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 00:09:51 -0700
X-CSE-ConnectionGUID: 8vkKIvulTCmV0KO7E0rovw==
X-CSE-MsgGUID: AOiEfMnrT56HtvkFuDF1HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="82808736"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 00:09:48 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH 1/2] vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
Date: Mon, 22 Jul 2024 15:07:12 +0800
Message-Id: <20240722070713.1342711-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

mdevs aren't "physical" devices and when asking for backing IOMMU info,
it fails the entire provisioning of the guest. Fix that by setting
vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
presence of mdevs.

Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 0c4354e3e7..391bfb72ca 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -230,6 +230,9 @@ static void vfio_ap_instance_init(Object *obj)
      */
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
                      DEVICE(vapdev), true);
+
+    /* AP device is mdev type device */
+    vbasedev->mdev = true;
 }
 
 #ifdef CONFIG_IOMMUFD
-- 
2.34.1


