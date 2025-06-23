Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F2BC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeNx-00062e-7P; Mon, 23 Jun 2025 06:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNt-0005yN-HU; Mon, 23 Jun 2025 06:26:41 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNk-0000kV-Mw; Mon, 23 Jun 2025 06:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750674392; x=1782210392;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=q2VQBL7Mh+cxs+WNQGG/PLk4d6ldYIcloZMCG49WyTw=;
 b=Qh7FFPtMBQKREWlhla2H4eIqmUQHsQRlvuCNr84+OeMo1PCHk8S0tePH
 MCgh1+3iMVqGwn1kDCUlrJMxRI/wOoBxrwUml7OFgqfxpGEbCkdNw3Kux
 PuJzQNsd23woifSFe1JSwcPyuyq17/D8oeW/+VauXJIvWxH3yeQrnnc0H
 Ed+JuB4guIME4KqXpAfZ12FgcNhzpOxJqJd7lX6MWOc8Ru0mWX+heDtry
 FmzmbRV3t2Qtp3WGNInrCnmMv0LmLnIzkhNRl7r6EIrvvkA0dKsNFDB9+
 eQkjA1wCkIIZr17Q1d90RaGjcFj0FyOCYOkGUt0zoXxFcWDPyxChm7tmD A==;
X-CSE-ConnectionGUID: IA+dNZV0Q2i294Uo7t02Ag==
X-CSE-MsgGUID: RC3ECSnNQseXmJKHS70k/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63565446"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63565446"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:29 -0700
X-CSE-ConnectionGUID: ijBtim1+TjyvAi65ncgvsQ==
X-CSE-MsgGUID: vbLLatrDRrW14D0CnS01OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="182427932"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org (open list:Trivial patches)
Subject: [PATCH 0/4] Some trivial live update fixes
Date: Mon, 23 Jun 2025 18:22:31 +0800
Message-Id: <20250623102235.94877-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi

These are trivial VFIO live update fixes in corner cases.

1) open /dev/vfio/vfio fail trigger SIGSEGV
2) mdev hotplug trigger qemu abort
3) potential SIGSEGV when unmap-all-vaddr failed
3) potential vfio_container_post_load failure

Thanks
Zhenzhong

Zhenzhong Duan (4):
  vfio/container: Fix SIGSEGV when open container file fails
  vfio/container: fails mdev hotplug if add migration blocker failed
  vfio/container: Fix potential SIGSEGV when recover from
    unmap-all-vaddr failure
  vfio/container: Fix vfio_container_post_load()

 include/hw/vfio/vfio-cpr.h |  7 ++++---
 hw/vfio/container.c        | 12 +++++++++---
 hw/vfio/cpr-legacy.c       | 23 +++++++++--------------
 3 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.34.1


