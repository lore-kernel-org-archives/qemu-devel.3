Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73455D3E783
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8W7L-0006w5-Vo; Tue, 05 Nov 2024 21:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7K-0006vY-6q; Tue, 05 Nov 2024 21:49:58 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7I-0003Mc-GX; Tue, 05 Nov 2024 21:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730861397; x=1762397397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H7lerJmEuC7yP69gP6zV6WKJa2+lLUCqxp5WR8/LiAI=;
 b=V+9ST+T7Nel+B401LjcRsm127RuulMLJz+8CQl7MNby213cxpHyau21f
 63PqadAI8r7sK9DM3BJcMfzpMLveTHoZIZR0k56aZXrRn1jVZJOypuLQo
 QJZwd7GH8Wp5glzNLii8GzHaUwIkWX1hxFE5OFFm137Ov2fzI7UH59DMA
 wBf13Sj8P0pJebyXa1DidPjE+d3xVqi0kzq62Kq0Qqggl0U+nUD0LJBth
 ztuOBZtfIQfWEVM4rzYiwtMiSmdHrpOGn0qq1Ioh0sN0SEVsDwApFVV1n
 9WXaoq5eMulE5EP6FtnISTn4YD05jWA3X/1Xtug152aYJ1G44sRMgrsjT Q==;
X-CSE-ConnectionGUID: H7SApJszSECp6q5E8UAlLA==
X-CSE-MsgGUID: oAe0TYx3SoqCD7+TRt15hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30492202"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30492202"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:49:52 -0800
X-CSE-ConnectionGUID: rnzAlqV1T02GOnI+LsiAtQ==
X-CSE-MsgGUID: PiFYv1UARaawoXhgwXvjtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="115077975"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2024 18:49:49 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org
Subject: [PATCH v5 01/11 for v9.2?] i386/cpu: Mark avx10_version filtered when
 prefix is NULL
Date: Wed,  6 Nov 2024 11:07:18 +0800
Message-Id: <20241106030728.553238-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106030728.553238-1-zhao1.liu@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In x86_cpu_filter_features(), if host doesn't support AVX10, the
configured avx10_version should be marked as filtered regardless of
whether prefix is NULL or not.

Check prefix before warn_report() instead of checking for
have_filtered_features.

Cc: qemu-stable@nongnu.org
Fixes: commit bccfb846fd52 ("target/i386: add AVX10 feature and AVX10 version property")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v5: new commit.
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3baa95481fbc..77c1233daa13 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7711,8 +7711,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             env->avx10_version = version;
             have_filtered_features = true;
         }
-    } else if (env->avx10_version && prefix) {
-        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+    } else if (env->avx10_version) {
+        if (prefix) {
+            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        }
         have_filtered_features = true;
     }
 
-- 
2.34.1


