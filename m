Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E842C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvO-0002hg-A7; Fri, 24 Jan 2025 08:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJvH-00025Q-FQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:35 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJvF-00041c-DK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737726034; x=1769262034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lKKhpINOwRUM2TXEgJwHkGVj1DZ5JDaSkIZbWTMQSdU=;
 b=av+VtuL01aRtLbnuommCZUMzk3BqUyTf5rasDtHA2CF0yJJtrqapLY0Z
 mFanoizJaEO+OuuysGG7KpuIAWJ6O0bI11o3GLdegiPaMV+TA3uMMqCZd
 mvb+WA4D1EzzBzhhURBWpNiMqOZzXX410Az69zhSLBZe/JYRqQbvRvTNy
 4TrtqGHwBccy386vjeadaxztUV+vXBc3ASMGUyaRAsXELEoM/vmuzrjpZ
 lcpsuG2DlpiVjCbjbYeuJrd30oB9B8XcPtfKLncjERmV+24mVcCa2oKD1
 k9omYrt2FjpO2f7IQS7w4oXuvkGjVV7g7uChidstD3emKClKpARVuGER/ Q==;
X-CSE-ConnectionGUID: cw/PSYPgTVWij064qhMEqg==
X-CSE-MsgGUID: xmQVc5PARXKjvjIqaLAaDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246640"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246640"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:40:06 -0800
X-CSE-ConnectionGUID: sPnsZByDRfuPsoXWvSIhMg==
X-CSE-MsgGUID: oe9IJOeQTK2UOcoe9Kz6MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804485"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:40:02 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 49/52] i386/tdx: Don't treat SYSCALL as unavailable
Date: Fri, 24 Jan 2025 08:20:45 -0500
Message-Id: <20250124132048.3229049-50-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v7:
 - fix CPUID_EXT2_SYSCALL by adding it to actual;
---
 target/i386/kvm/tdx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index f6a4f3322e61..58ea6a4d3156 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -804,6 +804,19 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
             continue;
         }
 
+        /* Fixup for special cases */
+        switch (w) {
+        case FEAT_8000_0001_EDX:
+            /*
+             * Intel enumerates SYSCALL bit as 1 only when processor in 64-bit
+             * mode and before vcpu running it's not in 64-bit mode.
+             */
+            actual |= CPUID_EXT2_SYSCALL;
+            break;
+        default:
+            break;
+        }
+
         requested = env->features[w];
         unavailable = requested & ~actual;
         mark_unavailable_features(cpu, w, unavailable, unav_prefix);
-- 
2.34.1


