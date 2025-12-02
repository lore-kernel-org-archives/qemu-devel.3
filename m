Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DD4D11704
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSuk-0003Kz-GC; Tue, 02 Dec 2025 11:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSuZ-0002U9-A8; Tue, 02 Dec 2025 11:07:31 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSuW-0008Cu-9J; Tue, 02 Dec 2025 11:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764691648; x=1796227648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9MQ564lwxpG6Oxxv/mdUg6vGcM3PGFMBsD8Z/3CykmQ=;
 b=Sdnfag9+2FtZzOIvZCv05HBtLvJLAWHTUjmDEOZ4X74FqCvtFUPV8DZv
 O/NetMTYBbrcQedbZbJOtyBL4QJJLlCGu/Rk1yrlAUrzXItIDRmCQlnN3
 PIKmbwuP50WzBcYSSyKIQTeILy2Jl7eOTJLmsTjhYWxrpkBYFHtW99+Fb
 7JIKKrOWrTgzvU7StPsw7wrRX4iO+PjAN2WpqEBKzAPtN7NSlpy6F5epn
 9nKGuw7qUp6/6gThe0LVs5jLangBxhXw08FxnkBfYkblj/cZFegBP7OVK
 Zv5IFA7GG71czxGjpmaMpLot0XQxOcM1hHmaucq6E3O4aAiM4Dsrddd1v g==;
X-CSE-ConnectionGUID: WbSg2f2cQPeq6J1NPVyd0w==
X-CSE-MsgGUID: UD1e4xMOSTe8uGXUZW/8FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92142926"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="92142926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:07:26 -0800
X-CSE-ConnectionGUID: BZzKIC5GRUewhmRb2+GGNg==
X-CSE-MsgGUID: +DrUXJVsTFOXx4l0ZMbwfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="199537860"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 08:07:17 -0800
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
Subject: [PATCH v5 22/28] hw/i386/pc: Remove pc_compat_2_7[] array
Date: Wed,  3 Dec 2025 00:28:29 +0800
Message-Id: <20251202162835.3227894-23-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202162835.3227894-1-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The pc_compat_2_7[] array was only used by the pc-q35-2.7
and pc-i440fx-2.7 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/pc.c         | 10 ----------
 include/hw/i386/pc.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 85d12f8d0389..b88030bf50d0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -253,16 +253,6 @@ GlobalProperty pc_compat_2_8[] = {
 };
 const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
 
-GlobalProperty pc_compat_2_7[] = {
-    { TYPE_X86_CPU, "l3-cache", "off" },
-    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
-    { "isa-pcspk", "migrate", "off" },
-};
-const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f8f317aee197..accd08cb666b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -292,9 +292,6 @@ extern const size_t pc_compat_2_9_len;
 extern GlobalProperty pc_compat_2_8[];
 extern const size_t pc_compat_2_8_len;
 
-extern GlobalProperty pc_compat_2_7[];
-extern const size_t pc_compat_2_7_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
-- 
2.34.1


