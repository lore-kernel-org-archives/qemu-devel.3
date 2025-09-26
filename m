Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EB2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1y8U-0003AS-95; Thu, 25 Sep 2025 22:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y8O-00039y-JG
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:32 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y85-0005Re-Je
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758853454; x=1790389454;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=shimNTJiD0zfQUGTEruDhEEFx5MFcB+vxKGhb676tJw=;
 b=BC6LTjUYtzvd6U5TTzkh5PqyvEad909Jm/eZwIcCpcVA8Qf+hmKbOO0W
 iZeNfyjEfKls9bw2ovKA6cQ6vRrJN0rWNmj2Mg8kvod7dB57E9AAgWOyw
 BTYXdp2ONXKjpaUZ/YupvScCXoDGjkYBA5JLkpcnZPRJ6jjTlwBpNF5mq
 xv2q5O4TZ0u4myYg8umyq7aWM+E185xjG5FbFxPoRJEwUzR9MYJaH/QcT
 W5zZOt93KZ1VK8B/M/YjwFQRY8jAu15buQ/E1+WfDe5Rd9ppEGhvlA2IG
 b8mECGfCx1XJZv/SQVV0EL9neQDf8heBmXiyAraooZjqTTWcAVq2O86OS w==;
X-CSE-ConnectionGUID: 3nFOO1eLRya/RJ7RyTQPjw==
X-CSE-MsgGUID: sWqd4DMVSoO2anNXU2J46Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61234080"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="61234080"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:01 -0700
X-CSE-ConnectionGUID: Z7y8S+jFRlGGDEHGgDgVMQ==
X-CSE-MsgGUID: 5I5/tSSGTty0kVLoFwgZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="176613434"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:23:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/5] VFIO: cpr-transfer fixes
Date: Thu, 25 Sep 2025 22:23:43 -0400
Message-ID: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

Patch1: fixed an error restore path when virtio-mem is configured.
Patch2: fixed assert failure on error restore path, this issue happens
no matter if virtio-mem is configured.
Some trick is played to trigger the error path,
see https://github.com/yiliu1765/qemu/commit/494d19e7f7242dbc47d7f236937cde0c396a4a7c

Patch3-4: issue only happens with two or more VFIO devices, no issue
if only one VFIO device.

Patch5: SIGSEGV if I send "query-balloon" to source qmp monitor,
I'm not quite sure if it's deserved to be fixed, as guest has been
migrated to destination, it's not a big issue for source qemu to
SIGSEGV?

Thanks
Zhenzhong


Zhenzhong Duan (5):
  vfio/container: Remap only populated parts in a section
  vfio/cpr-legacy: drop an erroneous assert
  vfio/iommufd: Save cpr.ioas_id on source side for CPR transfer
  vfio/iommufd: Restore vbasedev's reference to hwpt after CPR transfer
  accel/kvm: Fix SIGSEGV when execute "query-balloon" after CPR transfer

 include/hw/vfio/vfio-cpr.h |  2 +-
 accel/kvm/kvm-all.c        |  2 +-
 hw/vfio/cpr-legacy.c       | 22 +++++++++++++++-------
 hw/vfio/iommufd.c          |  8 ++++----
 hw/vfio/listener.c         |  4 ++--
 5 files changed, 23 insertions(+), 15 deletions(-)

-- 
2.47.1


