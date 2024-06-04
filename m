Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF773C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEHdq-0000O5-U3; Mon, 03 Jun 2024 20:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEHdp-0000Nd-4b; Mon, 03 Jun 2024 20:03:05 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEHdm-0000ML-BE; Mon, 03 Jun 2024 20:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717459383; x=1748995383;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CDIwazBcnoNSFEIUu8eac9IpZ5RTnOrM+XM5Zya8Mpk=;
 b=kh3fUQVe8QNkFZxFxGWoI15mNdytIXDRSqzOzXlF7IvaeFEeF1KeZjJp
 4AWbidFfDRYuDNa6CriD5Rv9fbt2tQe5ty68RPtA7wb2kcyEBSY70/aOI
 ijEl54VtNDx8QWXRAOMtcIypLZvAVaCok5GExbLpnLTlFlqzJotVpJ5FP
 1Cu1TXLl1N15zou2tzfSQcSA6ZTnOsPyxDi5d0YMiVz8LFeKXN6RQ1IFb
 HhvuzZHF6hoSAiU/KwWNiiHJUb7rHJjoAr2g6qLQFipvp+b3VwWA+RtQ2
 jo4nX+eICY4uFxGp3Ay6hzwhWtiZ5YAqGV+yCy3BjmUOS7LzQHTlKSeEh w==;
X-CSE-ConnectionGUID: y0lqGsjbRIut6+gqzpYHMA==
X-CSE-MsgGUID: sxTtOAfzRTekeTL2llqeag==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13924784"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="13924784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 17:02:59 -0700
X-CSE-ConnectionGUID: S31btywrTvCVeoLSqItpHw==
X-CSE-MsgGUID: jF/CWeecSeKQgQ90Hze5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="74529671"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 17:02:59 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org, seanjc@google.com,
 zhao1.liu@intel.com, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 0/2] improve -overcommit cpu-pm=on|off
Date: Mon,  3 Jun 2024 17:02:20 -0700
Message-Id: <20240604000222.75065-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Typically #UD takes priority over VM-Exit interception checks and
KVM doesn't emulate MONITOR/MWAIT. This causes the guest fail to
boot.

V2:
- [PATCH 1]: took Thomas' suggestion for more generic fix
- [PATCH 2/3]: no changes

V3:
- dropped [PATCH 1/3]. Took the simpler approach not to re-order
  cpu_exec_realizefn() call.
- changed patch title in [PATCH V3 1/2]
- don't set CPUID_EXT_MONITOR in kvm_cpu_realizefn() 

Zide Chen (2):
  vl: Allow multiple -overcommit commands
  target/i386: Advertise MWAIT iff host supports

 system/vl.c               |  4 ++--
 target/i386/host-cpu.c    | 12 ------------
 target/i386/kvm/kvm-cpu.c | 11 +++++++++--
 3 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.34.1


