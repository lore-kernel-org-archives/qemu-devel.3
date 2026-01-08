Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E533D14899
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 03:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdgOP-0005VB-Tv; Wed, 07 Jan 2026 22:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdgNn-00054d-Vl; Wed, 07 Jan 2026 22:08:20 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdgNm-0005Om-4Y; Wed, 07 Jan 2026 22:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767841699; x=1799377699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bViFc5gPbLLdovLuGgpm8Gleys7YArcVZOQcG9JoFFs=;
 b=SL2SlEOS60ZeSNhC/CHMoIZDwnwd36DbgZ5zvbha1LY9nCFQlbYaWML8
 33mJYnmZ+19iOxyHtIaAwx5y7s3LgCqCDHD1/MbE32rY/ypcEJsUY8NMG
 1QuLPIYp7t210KqefReRNAV9JT8DsJaCGOQ7gi7yZMugb+jse+DwmgzuI
 ahp/f2bw/gFVmwI/RmgV7z0jvu9SJway/8EcNNqT27+dpxTjpdT3SqnVZ
 re+71dtqDsYiNcmV29DwRSdLUXsOqny5uX3RubeUvr5SNChEhnYHKJ55P
 3c/jYgwv36K0ANxAb9AMmnD+aa9UVsDEZcupwGnRRBHt6Q8MO2vqZpxWK w==;
X-CSE-ConnectionGUID: YK5TJXYCS06WxmXfCM98LQ==
X-CSE-MsgGUID: I5vruoR4S+62TQIrdKGuTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="91877398"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; d="scan'208";a="91877398"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 19:08:16 -0800
X-CSE-ConnectionGUID: X5XOSFyWTH+WzpY7szud8w==
X-CSE-MsgGUID: BPvuIPPmRlOxQNQ51FXsYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; d="scan'208";a="202211086"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 07 Jan 2026 19:08:06 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 17/27] hw/intc/apic: Remove
 APICCommonState::legacy_instance_id field
Date: Thu,  8 Jan 2026 11:30:41 +0800
Message-Id: <20260108033051.777361-18-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108033051.777361-1-zhao1.liu@intel.com>
References: <20260108033051.777361-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The APICCommonState::legacy_instance_id boolean was only set
in the pc_compat_2_6[] array, via the 'legacy-instance-id=on'
property. We removed all machines using that array, lets remove
that property, simplifying apic_common_realize().

Because instance_id is initialized as initial_apic_id, we can
not register vmstate_apic_common directly via dc->vmsd.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/intc/apic_common.c           | 5 -----
 include/hw/i386/apic_internal.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 4e9e30899457..bf4abc21d7bb 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -276,9 +276,6 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
         info->enable_tpr_reporting(s, true);
     }
 
-    if (s->legacy_instance_id) {
-        instance_id = VMSTATE_INSTANCE_ID_ANY;
-    }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
                                    s, -1, 0, NULL);
 
@@ -395,8 +392,6 @@ static const Property apic_properties_common[] = {
     DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
     DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control, VAPIC_ENABLE_BIT,
                     true),
-    DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
-                     false),
 };
 
 static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 4a62fdceb4ea..0cb06bbc76c9 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -187,7 +187,6 @@ struct APICCommonState {
     uint32_t vapic_control;
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
-    bool legacy_instance_id;
     uint32_t extended_log_dest;
 };
 
-- 
2.34.1


