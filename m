Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C903FC25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 17:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s977Q-0002B6-BT; Mon, 20 May 2024 13:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s977L-0002Ab-7e
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:48:12 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s977I-0003k1-KK
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716227289; x=1747763289;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oHECevG9hOKny1QcCOBdhgDmorB+pvRQOOKuXeCBtfs=;
 b=dBAPLSowomZ5D8kNik30S86rDjlqjRqUgODqHmDCa42gGGYc5r/eIyHp
 LHQUxdgpGw+qCfmB1UDnPVRXMf7sMOdxjZqBfIjn0IKQ4H26fa2fhOrV7
 YF7aoBienx+f2L0WrtxCyLOtDUlpABhtGNFfgjOikXm+xJ69freKK6c1p
 cebkAau/25RJLS10E0c7P1ffk+7dWUOGR40UN1kuT7db4EvUo65OrrcQc
 j+f8K3pvD+5OyQJcBbr346GZkCHS1ETxzIj/Io3wA8555gsEq0iO2bvQs
 w46R7zzqAmh5CgARAEw2dq3KQyRpBnDcnxL4g2RlijnU6QPD+jglbp8Oq g==;
X-CSE-ConnectionGUID: 5gvKhVPQSiGmJrQYZ8BI8w==
X-CSE-MsgGUID: cT8+y6pkRiW2+IsmjFgBkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12222080"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; d="scan'208";a="12222080"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 10:47:54 -0700
X-CSE-ConnectionGUID: /XRrm/iUQiybwxK9kSpcDQ==
X-CSE-MsgGUID: GyAt6q4KTXGQGBaGUpwzvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; d="scan'208";a="32746620"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 10:47:54 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, Zide Chen <zide.chen@intel.com>
Subject: [PATCH 0/3] improve -overcommit cpu-pm=on|off
Date: Mon, 20 May 2024 10:47:30 -0700
Message-Id: <20240520174733.32979-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Currently, if running "-overcommit cpu-pm=on" on hosts that don't
have MWAIT support, the MWAIT/MONITOR feature is advertised to the
guest and executing MWAIT/MONITOR on the guest triggers #UD.

Zide Chen (3):
  vl: Allow multiple -overcommit commands
  target/i386: call cpu_exec_realizefn before x86_cpu_filter_features
  target/i386: Move host_cpu_enable_cpu_pm into kvm_cpu_realizefn()

 system/vl.c               |  8 ++++++--
 target/i386/cpu.c         | 24 ++++++++++++------------
 target/i386/host-cpu.c    | 12 ------------
 target/i386/kvm/kvm-cpu.c | 12 +++++++++---
 4 files changed, 27 insertions(+), 29 deletions(-)

-- 
2.34.1


