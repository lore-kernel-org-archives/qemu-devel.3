Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCF2CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bgq-0004iv-0T; Tue, 14 Oct 2025 05:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v8bgf-0004gE-DL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:22 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v8bgY-0005VW-6g
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760435474; x=1791971474;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=weod3uK6J1teM+AKHJSkLEuApgcHvCRVe7cb3QMnafw=;
 b=KfXezSgJz6lw6kfYF6BfJ+4CHn8INGs0EBO15Tf7oUHX36qLsetFkwbY
 vnaYiw427uq+5387ENB+G0S3XS7g/cJiKCNqZhnBg461YWI5efCfh8UO2
 Y9tdUK/cafdpOuAHAMt1tKZxQ9HSiFJDor6PbbhbHlySqKbmXuE0CTh4H
 xfHJnsS5vxmET/4e/Zb1bChw9LIUp94/gsnXYFiJrL8n2jM9xIiO08jIq
 gXVxmlAZyG1Onq65Onw58i5CDaaqtMQyr6E+dCb2Uv45om2ABVd4X8tHr
 jwjqMWmvi0crSstbJ/E0zcLWh+BR6qtJQceKc2EKOhwgOwyVmQzGA3UP6 A==;
X-CSE-ConnectionGUID: xgMpVDqVR1Krtu8jDFSmIg==
X-CSE-MsgGUID: OwXmtjQiQZ22Qv8itWgqDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61627802"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61627802"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 02:51:08 -0700
X-CSE-ConnectionGUID: UWDSwN3nTXeVLkDseVT42A==
X-CSE-MsgGUID: IBuWPIYzRqStx/8nbdDBvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181068409"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa010.jf.intel.com with ESMTP; 14 Oct 2025 02:51:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/2] x86/cpu: initialize SMM cpu address space for hotplugged
 cpus
Date: Tue, 14 Oct 2025 17:42:13 +0800
Message-ID: <20251014094216.164306-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

(Sorry for being late to post the fixing patch, due to Chinese National
holiday.)

Patch 1 fixes the issue reported by Peter that hotplugged cpu doesn't get
SMM cpu addresspace initialized.

Patch 2 "fixes" the part that was missed when the original patch got
merged.

Xiaoyao Li (2):
  i386/kvm/cpu: Init SMM cpu address space for hotplugged CPUs
  target/i386: Use X86ASIdx_MEM in kvm_init()

 accel/kvm/kvm-all.c        |  2 +-
 hw/i386/x86-common.c       | 11 +++++++++++
 target/i386/kvm/kvm.c      |  6 ++++++
 target/i386/kvm/kvm_i386.h |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.43.0


