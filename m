Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0524BC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 03:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUznA-0002gS-Dl; Thu, 26 Jun 2025 23:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUzn7-0002fo-Ob
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:18 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUzn5-0007Kq-KW
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750995016; x=1782531016;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MMHEypOCGay//pIEw6oqN4EZyX4dUB6L7V+HG7w/k+s=;
 b=dncznUtTdN81pBbJUw8yUCzGpt43JNpV5ShJIN0xGJlHpLplr+Qz8AwO
 zTLX1ixxaMeWdsegHvGeip+vI2jTrcs1EBJ+57kjlKmNaBGNSTMIAJMvL
 VqQAl+K7ia2mgklr9GK53TqJWAsSbP5vjLQdDRw8uo+7X1owqfHeLygvY
 arkX7uUZCn5qVXQqI6MBy3Dd09hmpXn+pdXf5qPRb+/QnYr4V4jGy4AT7
 zkJJKSkNPfpJmb5SSE2mkOvjkpqJxqM2zy+7AqndQldiVuVZi1AIzrOqf
 UI64vgQhxCRY10oHNIX5eSG4QI2P8yU5+jpwJq9Vx37nOkGxSoSKfpGiz w==;
X-CSE-ConnectionGUID: fR/pPhqYQIOg5QxRywT53w==
X-CSE-MsgGUID: XikkrPWwSCWOBkvgKTpmPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53247132"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="53247132"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 20:30:13 -0700
X-CSE-ConnectionGUID: tnIYW8epRsSgzQue2Qrw7w==
X-CSE-MsgGUID: OMSLsCMVSbWwTmVnGZPGjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="157084613"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Jun 2025 20:30:11 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/4] i386/cpu: Clean Up Reserved CPUID Leaves for Intel
Date: Fri, 27 Jun 2025 11:51:25 +0800
Message-Id: <20250627035129.2755537-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
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

Hi,

Since the previsor unified cache model series has already introduced a
new compat property "x-vendor-cpuid-only-v2", it's a chance to once
again consolidate more vendor-specific CPUIDs.

I also checked the CPUID leaves currently supported by Intel & AMD and
found that since the previous "x-vendor-cpuid-only," AMD has already
cleaned up the Intel-specific CPUIDs quite well.

As for Intel, the only cleanup needed is for the "extended function
CPUID" leaves (0x80000000~0x80000008). That's what this series does.

This series is based on:

<20250626083105.2581859-1-zhao1.liu@intel.com>

Or you can find the code at:

https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v2.6-rebase-06-23-2025

Thanks and Best Regards,
Zhao
---
Zhao Liu (4):
  i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as reserved for
    Intel
  i386/cpu: Mark CPUID 0x80000007[EBX] as reserved for Intel
  i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as reserved for Intel
  i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()

 target/i386/cpu.c | 83 ++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 34 deletions(-)

-- 
2.34.1


