Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DE1C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMAv-0000xn-8A; Tue, 20 Feb 2024 04:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAt-0000wc-4M; Tue, 20 Feb 2024 04:12:27 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAr-0003Tv-OB; Tue, 20 Feb 2024 04:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708420346; x=1739956346;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N8NOOJ+pARZ8UH7DHP7I4LRh9UGou9oDu+xcL8Vc/Rs=;
 b=MLqbFD6HNiMEBg3S5LjV+mg1oJBcfv3VeaZmJfwSEdLJqzRfthwZN30G
 Dj+gh1pi6N14HhBbXtOP8rsr5QIFej74vEYc8x/rsgA9ASEuH5DuCPvyD
 pBQ+ePNnqYCnUsdOibgSljBSxpwu72NXf+5Od9v0tSRO6YiEnMbOTvTl+
 1I1rQpDOJN+JMf3B312RHCTxN98EghWB+4Y5DuMlc9TqK8ZCkAfOs5hpp
 RogsxdfIlSnv/JXf3MqVmg79dgVdlL89gas437J0mPomUaBxwYdDnvh+Q
 YuTD//mqg1D77cLvWEx5tf/AiVceoRP0yStm6kb28B++KJjybqaaqfFOW w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2375033"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2375033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 01:12:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5013100"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 20 Feb 2024 01:12:17 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 7/8] i386/pc: Support cache topology in -smp for PC machine
Date: Tue, 20 Feb 2024 17:25:03 +0800
Message-Id: <20240220092504.726064-8-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/pc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 25124a077eea..76148c3337cf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1848,6 +1848,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
+    mc->smp_props.l1_separated_cache_supported = true;
+    mc->smp_props.l2_unified_cache_supported = true;
+    mc->smp_props.l3_unified_cache_supported = true;
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 
-- 
2.34.1


