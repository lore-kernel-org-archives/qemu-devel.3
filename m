Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F768D13590
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Fqi-0006E0-Kj; Sun, 27 Oct 2024 22:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5Fqh-0006Dm-1r
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:51:19 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqR-0003WL-C7
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730083863; x=1761619863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XtpX2GHXwFhj3VWx8YvGq8lBGqq25COB6qA38BPWld4=;
 b=nsMshaUJsqtzw4vK5hxUncXh+hEIRJlTBPI/wzng/wT8eyTtkAnpMCN2
 OAsQY1xlWyeAxZ0QTXQSUNRyBSiJK397Q1tLt81UTN+gNxFBo+HbpIrQw
 8xIto7lY+jMN5954ev46EXdAk/dNUaLS4WisDNLYrExuVsQBbfz3DNUZb
 z+7j6Vg9kADfTb6Jq3Z5BMe+ICs5whAfWmm15Byxp0Ztal6cZpDOVwrnP
 VJB+wnvKh7pJcu/q/YpqYrGLuyYsGsB+jQELzuaNLAsK54YX+5e25mC4/
 y4wYNDoiljXWQUFYWt/RlT1GYm3OWJZve+Azd5nqKHSasXddR2b2KZn96 Q==;
X-CSE-ConnectionGUID: jI5cEMZxQx2eIWOqs1C0ZQ==
X-CSE-MsgGUID: hZEcEtktQMKOKmrgDNXPUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249475"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="40249475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 19:51:03 -0700
X-CSE-ConnectionGUID: zeRy5jCsRgiTRHy98DzptQ==
X-CSE-MsgGUID: 4DhdYU6YRJGIUeJ75BpXWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="81420953"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2024 19:51:01 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 5/6] target/i386: Add support for AVX10 in CPUID enumeration
Date: Mon, 28 Oct 2024 10:45:11 +0800
Message-Id: <20241028024512.156724-6-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028024512.156724-1-tao1.su@linux.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Intel AVX10 represents the first major new vector ISA since the
introduction of Intel AVX512, which will establish a common, converged
vector instruction set across all Intel architectures.

AVX10 enable bit is enumerated via CPUID.(EAX=7,ECX=1):EDX[bit 19]. Add
the CPUID definition for AVX10 enable bit, AVX10 will be enabled
automatically when using '-cpu host' and KVM advertises AVX10 to
userspace.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9666dbf29c..adde98fd26 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1133,7 +1133,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
             "amx-complex", NULL, "avx-vnni-int16", NULL,
             NULL, NULL, "prefetchiti", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "avx10",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.34.1


