Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60467CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nBu-0006QP-4Q; Sun, 28 Sep 2025 04:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nBr-0006QE-Qy
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:31 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nBk-00044H-05
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759049724; x=1790585724;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QBEUFXYHYtpWj/I3pwOjDT9zSZPzhvDVrZ4P+o54GbE=;
 b=W8gEUjWOAuHyMhI3osMt53tAd86rdgBtVPl/+cyX/yiNbJKbw0T4GdH2
 /ejcAzVwALzcu6Z7CxEEgXfyF3khEQHH3oFIxdvoU/rwKjJwJhHtC4rhA
 eS1+4SG+S1kLJPrQQ/maG0dBAX4imiTRJ2S32bqQJNeQNlLkXURL25hP2
 tfITTcQfRcc9Fb9xLh6v6DswyMUbuKfjN5xc5t+CFhx42f+zbrhJNxfDk
 GAJN+Ejvi9JHARbiUFQORMYr6AP/UPqKTHfw3YU0mzrXtiNPAqOChiZ57
 0GQ+vPommwFQGRFjqtx6AeeYshpgmiws2Qu8ErR+Jn2ieZAkLr6Onbmrf g==;
X-CSE-ConnectionGUID: SIqoWjotTDmj1SEo9PHWBQ==
X-CSE-MsgGUID: nhKSQT8NQQiQm9Ww1/aVAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65167425"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="65167425"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:17 -0700
X-CSE-ConnectionGUID: J4Nxw6bkQHGRHARt126Pug==
X-CSE-MsgGUID: uDoB4QxtTzO25XdEebZE3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="177810793"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/6] VFIO: cpr-transfer fixes
Date: Sun, 28 Sep 2025 04:54:26 -0400
Message-ID: <20250928085432.40107-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Patch5: fix a bug that impact "query-balloon" execution

Patch6: SIGSEGV if I send "query-balloon" to source qmp monitor,
I'm not quite sure if it's deserved to be fixed, as guest has been
migrated to destination, it's not a big issue for source qemu to
SIGSEGV?

Thanks
Zhenzhong

Changelog:
v2:
- minor polishment to commit log (Steve)
- keep kvm_state so "query-balloon" could work after CPR-transfer (Markus)
- add a fix which is found during "query-balloon" execution
- rebased to master

Zhenzhong Duan (6):
  vfio/container: Remap only populated parts in a section
  vfio/cpr-legacy: drop an erroneous assert
  vfio/iommufd: Set cpr.ioas_id on source side for CPR transfer
  vfio/iommufd: Restore vbasedev's reference to hwpt after CPR transfer
  accel/kvm: Fix an erroneous check on coalesced_mmio_ring
  accel/kvm: Fix SIGSEGV when execute "query-balloon" after CPR transfer

 include/hw/vfio/vfio-cpr.h |  2 +-
 accel/kvm/kvm-all.c        | 14 ++++++--------
 hw/vfio/cpr-legacy.c       | 22 +++++++++++++++-------
 hw/vfio/iommufd.c          |  8 ++++----
 hw/vfio/listener.c         |  4 ++--
 5 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.47.1


