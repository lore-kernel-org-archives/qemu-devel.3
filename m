Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76865C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa5C-0004H7-6C; Thu, 29 Feb 2024 01:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa4u-0003qb-2R
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:39:39 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa4r-0004LA-OD
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188773; x=1740724773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xcjX8S6Or4RgbxyPFn2A1+rsnCrOWOXt1edq7jIgm+g=;
 b=hm9QYH5jCRiO3e2222PBL3ZUdsAtdMSXzuoMqOWwKgeCv/FHDvoi4ikg
 k0GpMw5H/N6TR+ZhH3nazE0ERCTiGACYEjiSFtbNOrZ8hQ+gXV6YEx5SW
 2psrk59rTnYMqJJiy21tdKOKAb3iZ4qcBNFHKFSh4VmpcrZC5QSBPIL4f
 6XQN2RWZJMIkdlSY/uSyb+usMPDKxkh/sLLiZvN2ldEpcmeR2lY1sLKc/
 xtR0R8ZOFD2LkEK6UeyeE8f2dGenMazCE2zh9KDhN4vbytLgQVhfdWA//
 8zL/SO59CMwNW3mGo7j+Bd2wyNjgQPJ9Dx0vnKG3nuqU3v3z5QYmJ82NR A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802650"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802650"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075212"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:39:26 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 18/65] i386/tdx: Make Intel-PT unsupported for TD guest
Date: Thu, 29 Feb 2024 01:36:39 -0500
Message-Id: <20240229063726.610065-19-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Due to the fact that Intel-PT virtualization support has been broken in
QEMU since Sapphire Rapids generation[1], below warning is triggered when
luanching TD guest:

  warning: host doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]

Before Intel-pt is fixed in QEMU, just make Intel-PT unsupported for TD
guest, to avoid the confusing warning.

[1] https://lore.kernel.org/qemu-devel/20230531084311.3807277-1-xiaoyao.li@intel.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v4:
 - newly added patch;
---
 target/i386/kvm/tdx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 85d96140b450..239170142e4f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -292,6 +292,11 @@ void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
     if (function == 1 && reg == R_ECX && !enable_cpu_pm) {
         *ret &= ~CPUID_EXT_MONITOR;
     }
+
+    /* QEMU Intel-pt support is broken, don't advertise Intel-PT */
+    if (function == 7 && reg == R_EBX) {
+        *ret &= ~CPUID_7_0_EBX_INTEL_PT;
+    }
 }
 
 enum tdx_ioctl_level{
-- 
2.34.1


