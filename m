Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B90C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 03:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpK5-0006lV-BJ; Wed, 24 Apr 2024 22:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpJv-0006jD-G9; Wed, 24 Apr 2024 22:58:48 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpJs-00055R-C6; Wed, 24 Apr 2024 22:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013925; x=1745549925;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7J6j1W1IhVWNL7+kuIfTRdx2+iVsTcCgIjqKBY+tP1k=;
 b=QdueZi1QeBJNnSxbdX09f87wVIelU1jTIxiE5VT8w5/WPFDTRTDc54mE
 ibtf3hGkemjVaoMD/oF0F8ntqC1MUj28JtHrCgEYe5WewJNyS6vLtwseq
 eP+0/tObXvxsrfPd46C1CL/GFRguOqbicT0GEJYTASNNB5mh3O1zeF1U9
 7cPJrXUWNQDTigak2n4XtTPG3jg/p5xY55jgXHeW2Gwfq1Ka2BOnfnjZB
 a6bQRbiU9b9TUv/Mzb4cx4AUaYkgGZ+7fw9U48esnPSXoRNYst887GSil
 0I1u/Xgi6qA+9YUxB41dhB7DixPLLAwRvO9GARtwsslLsC5m51BVkFACM A==;
X-CSE-ConnectionGUID: GoWSizr8Q3C2yaq/DsUhAw==
X-CSE-MsgGUID: cKHLs7ozRDKtdXJnooVkyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605631"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605631"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:58:41 -0700
X-CSE-ConnectionGUID: 5/fa4p7eSbyHxzlLluAmhA==
X-CSE-MsgGUID: eplvB4n6SVWkCmjfUoMdtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395644"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:38 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/7] s390x/cpu_models: Misc cleanup on returned error code
 and local @err variables
Date: Thu, 25 Apr 2024 11:12:25 +0800
Message-Id: <20240425031232.1586401-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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

Hi list,

This series is the followup of Thomas' suggestion in previous
ERRP_GUARD() cleanup[1]. And based on Thomas' thoughts, I tried to clean
up as many of the other related places (in s390x/cpu_models.c).

[1]: https://lore.kernel.org/qemu-devel/6e7eff95-cfd3-46f9-9937-7597b2e4f3ee@redhat.com/

Regards,
Zhao
---
v1: https://lore.kernel.org/qemu-devel/20240419065712.1225038-1-zhao1.liu@linux.intel.com/
Changes since v1:
 * Picked Phili's stubs cleanup and rebased on it.
 * Fixed typos.

---
Philippe Mathieu-Daudé (1):
  target/s390x: Remove KVM stubs in cpu_models.h

Zhao Liu (6):
  target/s390x/cpu_model: Make check_compatibility() return boolean
  target/s390x/cpu_model: Drop local @err in s390_realize_cpu_model()
  target/s390x/cpu_models: Make kvm_s390_get_host_cpu_model() return
    boolean
  target/s390x/cpu_models: Drop local @err in get_max_cpu_model()
  target/s390x/cpu_models: Make kvm_s390_apply_cpu_model() return
    boolean
  target/s390x/cpu_models_sysemu: Drop local @err in apply_cpu_model()

 target/s390x/cpu_models.c        | 25 ++++++++++---------------
 target/s390x/cpu_models.h        | 19 ++-----------------
 target/s390x/cpu_models_sysemu.c |  5 +----
 target/s390x/kvm/kvm.c           | 28 +++++++++++++++-------------
 4 files changed, 28 insertions(+), 49 deletions(-)

-- 
2.34.1


