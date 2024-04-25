Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21808C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpK9-0006ne-M6; Wed, 24 Apr 2024 22:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK0-0006jx-HN; Wed, 24 Apr 2024 22:58:52 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpJy-00055w-UA; Wed, 24 Apr 2024 22:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013931; x=1745549931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PJPFCA7BY25YZOOud8GjsPozRvVnyadtZVhQM8SLIwM=;
 b=becJzPYRLgmrO7zKjSd/KCojvGG9I8uztaPlWOQFb2KLJfhFVijpFQGM
 v4fo55jMWRiMwuJisD+dcYbymqgCFDuYzswTHCy8IdxNg2F9fUhBVxING
 vvim4ojhjqDWiePuUzN6K2rgDrlIHuldI0TKeCMvgC+2TVPSUX8LmcwSz
 WV9RbRPt85nNPJUUng5o042qPBttb1iy5l9wKcBfYqk5X1fOoOG2ONBtN
 Y6jkgEN3luiME4CtzJ1RAKTa66P+d5J5XNN78LuACQm1CydZ/43FrKeV9
 0tKhv6x0ADHV8LoZbJDmsZ+UJZi9TtRsiQOlD/0QY1Q1r/DfYNr0dI+Qi w==;
X-CSE-ConnectionGUID: rItFOClmTX+RY/8CGGSSVA==
X-CSE-MsgGUID: jZDnOEcNTrORRb90f/HxLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605653"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605653"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:58:50 -0700
X-CSE-ConnectionGUID: F/aid7veQRill52Gdylhvw==
X-CSE-MsgGUID: glA8qC35Qc6/uWVLMFd3NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395684"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:47 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 3/7] target/s390x: Remove KVM stubs in cpu_models.h
Date: Thu, 25 Apr 2024 11:12:28 +0800
Message-Id: <20240425031232.1586401-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425031232.1586401-1-zhao1.liu@intel.com>
References: <20240425031232.1586401-1-zhao1.liu@intel.com>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since the calls are elided when KVM is not available,
we can remove the stubs (which are never compiled).

Inspired-by: Thomas Huth <thuth@redhat.com>>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/s390x/cpu_models.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index d7b89129891a..a89c2a15ab54 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -114,23 +114,8 @@ static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features);
 
-#ifdef CONFIG_KVM
 bool kvm_s390_cpu_models_supported(void);
 void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
 void kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
-#else
-static inline void kvm_s390_get_host_cpu_model(S390CPUModel *model,
-                                               Error **errp)
-{
-}
-static inline void kvm_s390_apply_cpu_model(const S390CPUModel *model,
-                                            Error **errp)
-{
-}
-static inline bool kvm_s390_cpu_models_supported(void)
-{
-    return false;
-}
-#endif
 
 #endif /* TARGET_S390X_CPU_MODELS_H */
-- 
2.34.1


