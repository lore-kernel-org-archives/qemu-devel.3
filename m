Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C92C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 20:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAb6J-0002Ij-Dy; Fri, 24 May 2024 16:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb63-000260-2W; Fri, 24 May 2024 16:01:04 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb5v-00050y-BG; Fri, 24 May 2024 16:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716580851; x=1748116851;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vwKH01rzlWx9561/Am/sOOt9A88NKrbQ8rGO8mBibgg=;
 b=lGf4b18MXA1tXMmEYjm6qBZWrtW14NIALMVXSW7eL/n3WqwzG/UWScPb
 VzzHX2myQUn8Y/fXhXfU4MmnEP9KQoEeoQBuJ8RpFcKCF2MWwQK7W+Qwd
 KueeKiANdcE5fAGHK8EP0x2wSqt1kd0aBPyBlCQe+DHzoWcnhFV5TPdO6
 XPSOEkMO4gDVbIBRiMluihKNk3v7/qpEq25pPvapMMl1FsFBCN8wTUl2I
 sHS6NMdHo/CGxC74fvbMQU7E8MRhO7mEEeMAtHkTa2UsDmRJXNDCEoq6m
 79gnOTLN1/ERanl24WlJ+kOygC0rMSLc00OggWP/Hp5wOnU+cAwPh6Mhm Q==;
X-CSE-ConnectionGUID: tPiOFDYWQ8CEKWuz7m8h1Q==
X-CSE-MsgGUID: gUtLtME2Q7Wa3rtMlXL6Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="15918258"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="15918258"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:44 -0700
X-CSE-ConnectionGUID: JXLt8lESQquj1gja9uLb2Q==
X-CSE-MsgGUID: pcBJnSG3Rly2zhL9xGHkpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="39108900"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:45 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org,
 Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
Date: Fri, 24 May 2024 13:00:14 -0700
Message-Id: <20240524200017.150339-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Currently, if running "-overcommit cpu-pm=on" on hosts that don't
have MWAIT support, the MWAIT/MONITOR feature is advertised to the
guest and executing MWAIT/MONITOR on the guest triggers #UD.

V2:
- [PATCH 1]: took Thomas' suggestion for more generic fix
- [PATCH 2/3]: no changes

Zide Chen (3):
  vl: Allow multiple -overcommit commands
  target/i386: call cpu_exec_realizefn before x86_cpu_filter_features
  target/i386: Move host_cpu_enable_cpu_pm into kvm_cpu_realizefn()

 system/vl.c               |  4 ++--
 target/i386/cpu.c         | 24 ++++++++++++------------
 target/i386/host-cpu.c    | 12 ------------
 target/i386/kvm/kvm-cpu.c | 12 +++++++++---
 4 files changed, 23 insertions(+), 29 deletions(-)

-- 
2.34.1


