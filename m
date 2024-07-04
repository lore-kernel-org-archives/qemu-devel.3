Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA3BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCj0-0004pB-Vf; Wed, 03 Jul 2024 23:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCie-0004Q0-CU; Wed, 03 Jul 2024 23:01:16 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCic-00040P-Lv; Wed, 03 Jul 2024 23:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720062071; x=1751598071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5b9XogeXsVEL7ylTEoEbdPkYX3f+Rc5K1Le5/8Ng2nM=;
 b=nomEOEgVzhhSgqelCof5ZBFYwrGtEpv45unX8K2+yrjKm0j9aKXRtC0z
 1TGQ9EGaOZIaLM2YS9w0+MCm6M9OHSBwaA7jzMHKqM50PCLXhtKu5iwog
 Iz843fUQTOswiWwWGe2GsyRdsmm8IyH/7T80mWJgDdO7gFGr/yafBsVtM
 Ghr08PteMAGqeGfX2fIZGqEbY9znstc0aR3B9XL36H+PJERqt5oJEfKXJ
 PX9l2nbRvQspaB6vtZrfaJLymqeL5CnMAw5iAAiFsLuA0CMGFhAAY5CLW
 SXSeoatyb74Guwlbjj0WSQoKsPWPR8cYWC95RsCNkPgt+oUC/APpOuuWT A==;
X-CSE-ConnectionGUID: xDuFJ1n1Qnig41PcPo2uPA==
X-CSE-MsgGUID: 7cd8XPN0T7qLlFyg97a9MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39838156"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="39838156"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 20:01:08 -0700
X-CSE-ConnectionGUID: 7hVCaK83SaCzBXqUcS03NQ==
X-CSE-MsgGUID: MBIRtr8ERn++cWHf40ULow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51052471"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 03 Jul 2024 20:01:03 -0700
From: Zhao Liu <zhao1.liu@intel.com>
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
Subject: [PATCH 7/8] i386/pc: Support cache topology in -machine for PC machine
Date: Thu,  4 Jul 2024 11:16:02 +0800
Message-Id: <20240704031603.1744546-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704031603.1744546-1-zhao1.liu@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Allow user to configure l1d, l1i, l2 and l3 cache topologies for PC
machine.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC v2:
 * Used cache_supported array.
---
 hw/i386/pc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 77415064c62e..1614a3b1bf19 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1773,6 +1773,10 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
+    mc->smp_props.cache_supported[SMP_CACHE_L1D] = true;
+    mc->smp_props.cache_supported[SMP_CACHE_L1I] = true;
+    mc->smp_props.cache_supported[SMP_CACHE_L2] = true;
+    mc->smp_props.cache_supported[SMP_CACHE_L3] = true;
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
-- 
2.34.1


