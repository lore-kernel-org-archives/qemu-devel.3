Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115B9C531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8yf-0003Ba-2V; Wed, 14 Aug 2024 04:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yI-0002p1-OE
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:10 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xu-0007sc-RW
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622562; x=1755158562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uep5VC7g3XliyLn1znJEV29ajVLkzpBFUeE1+TBL7QA=;
 b=WnpbLIjNdu033H9aIxt+Xah/0ElmgUSOa/cRIXKcD9VrFSNPJ0+zJWg/
 McT9s0uy/f98HppICdQg/nDxBfsS5KJEDSjpoKZg18tnPaC5SDpE+Crii
 IEt2LganZ9Jpo6Ns8DzDAaoxZEihaWHzY2eqwthyBNCpwJJfnj7q/8Gg+
 0QHuHQVmkSyeX5GQ+Bq9QTcObNnrdA5WY0zeQ1iaL4DyMEjL6VS529rs5
 DeZvG+f4EjFCvK3riN3t8nkIn0E08ux7PNOy3Q7CTcHngFC476LosdFyk
 lFFRm98xjd7b8mk96Y/qUG517NDHEoI/0CqQ5gKiG40+g9pPHAHJQbm6S g==;
X-CSE-ConnectionGUID: voy0BJzWTWiJG8XrC/PE8g==
X-CSE-MsgGUID: oB5mx0dsQD+pE2UWfqetDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584474"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584474"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:38 -0700
X-CSE-ConnectionGUID: o7p3KkbsTfO1NtbxCirgxw==
X-CSE-MsgGUID: kqlP9rAJTr688NY7cbVQBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048949"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:35 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 3/9] i386/cpu: Add support for bits in CPUID.7_2.EDX
Date: Wed, 14 Aug 2024 03:54:25 -0400
Message-Id: <20240814075431.339209-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

KVM started to report the support of bit 0-5 since commit eefe5e668209
("Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace")

Allow them to be exposed to guest in QEMU.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e60d9dd58b60..03376ccf3e75 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1148,8 +1148,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_2_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
-            NULL, "mcdt-no", NULL, NULL,
+            "psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
+            "bhi-ctrl", "mcdt-no", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.34.1


