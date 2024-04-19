Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA787C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxhy2-0007nN-EZ; Fri, 19 Apr 2024 02:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxhxu-0007mY-UH; Fri, 19 Apr 2024 02:43:19 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxhxs-0001Bi-5o; Fri, 19 Apr 2024 02:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713508996; x=1745044996;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QWsH8X043CyL5FL8ehlMa2OTGKdkZs5vyPPwCis1ErQ=;
 b=T6c8IxG9xjtFRtIFlekdUBz3dM+H6CLRs3N7CWV5tK9/shlI782r6jgm
 MB/swauybyDxxOv0Uyq20rDZxKZzzn7tFdbQbdoH27Z6MqEf3VKwggg0U
 8uhHwd7v8hGnxeNBwxp5o98ppUo4xcCxSh1FQjLE8/4/HqRRg6HdjkS5a
 w93dMFedIstawR64SCKPdBjhBnR+rSdm9lPgQ89Qoo6BFslSCZQA9QY28
 4nQbXdpR1JQMBzkUyz9XLFR6V87GeunKeRBh9fF1BB1PqQtNTu5deIqAz
 L8fk4xvpkjlU+Iuy8T4Jto9M/CSo9x/5wJtXo8AACugiOEbUyyRhm7S1H Q==;
X-CSE-ConnectionGUID: KHzZodo/R+2VM3D3e+pM3A==
X-CSE-MsgGUID: ZlQyB5+xQ76TDWmzm0Bjiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19659912"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="19659912"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 23:43:11 -0700
X-CSE-ConnectionGUID: o/If1bwiT4eeyTGuCH36ww==
X-CSE-MsgGUID: 49hMbLV0T3yT5Gr7UOA4NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="28071832"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 18 Apr 2024 23:43:09 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/6] s390x/cpu_models: Misc cleanup on returned error code and
 local @err variables
Date: Fri, 19 Apr 2024 14:57:06 +0800
Message-Id: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Hi list,

This series is the followup of Thomas' suggestion in previous
ERRP_GUARD() cleanup[1]. And based on Thomas' thoughts, I tried to clean
up as many of the other related places (in s390x/cpu_models.c).

[1]: https://lore.kernel.org/qemu-devel/6e7eff95-cfd3-46f9-9937-7597b2e4f3ee@redhat.com/

Regards,
Zhao
---
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
 target/s390x/cpu_models.h        | 10 ++++++----
 target/s390x/cpu_models_sysemu.c |  5 +----
 target/s390x/kvm/kvm.c           | 28 +++++++++++++++-------------
 4 files changed, 32 insertions(+), 36 deletions(-)

-- 
2.34.1


