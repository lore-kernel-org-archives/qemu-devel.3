Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBEBD5B164
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpI-00033C-IG; Tue, 29 Oct 2024 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpG-00032b-BA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:42 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpE-000848-QE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191421; x=1761727421;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=43WK+abTbNMifGNpLd4Svq5BTo5rTuY6AzMRimA/3NA=;
 b=AQ9FLfIV4uASuw7fmo3qjAsAQsPv8p5PEkXXbNdxT13bGZHypF+rSTcC
 UOzEoBRk+06dbJuHrv9IFEpCXRL5wNXvdvor6leFGbyUTeOIwG7Pxgt97
 bGcquQiVZAAQ/XK6Ps9C33GXgb4AsBajWNguENhyGhH7itwNPoVE6msM4
 qn/EB4zS4kzY6LfjwGydNFvYAuSRPSZDvw/e+oTWa8aC8EYOMBqdtuAjH
 /KtXdUZKoKLUtOQUyqQS5HxNDMVwYFHhgizkftC1sF9lo4K6sTn5ABZiF
 0LovX17htJlv3YQvZTWDdO3TSdfySSQZUOgHr2X3pkvJmRfKcMpsbbjh3 w==;
X-CSE-ConnectionGUID: 6gcS49eTQTCmLMIHhKA6Mg==
X-CSE-MsgGUID: /tb8305eQJWrcO5NzpcZhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592817"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592817"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:39 -0700
X-CSE-ConnectionGUID: 0fZAUPKqRASBD1NDMbj68Q==
X-CSE-MsgGUID: 68T131g+S+eyD/L3pN12nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847208"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:38 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 10/16] i386: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:28 +0800
Message-Id: <20241029085934.2799066-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h | 4 ++--
 target/i386/cpu.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 14ee06287da3..b3477ad6a291 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -316,7 +316,7 @@ extern const size_t pc_compat_2_3_len;
     }; \
     static void pc_machine_init_##suffix(void) \
     { \
-        type_register(&pc_machine_type_##suffix); \
+        type_register_static(&pc_machine_type_##suffix); \
     } \
     type_init(pc_machine_init_##suffix)
 
@@ -344,7 +344,7 @@ extern const size_t pc_compat_2_3_len;
     static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
     { \
         MACHINE_VER_DELETION(__VA_ARGS__); \
-        type_register(&MACHINE_VER_SYM(info, namesym, __VA_ARGS__)); \
+        type_register_static(&MACHINE_VER_SYM(info, namesym, __VA_ARGS__)); \
     } \
     type_init(MACHINE_VER_SYM(register, namesym, __VA_ARGS__));
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ff1af032eaa..241bbef5d60b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6347,7 +6347,7 @@ static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
         .class_data = model,
     };
 
-    type_register(&ti);
+    type_register_static(&ti);
 }
 
 
-- 
2.34.1


