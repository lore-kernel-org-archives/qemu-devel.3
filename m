Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48660D1CA3B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DEE-0001ZT-QO; Tue, 05 Nov 2024 01:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDJ-0007yX-LL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:55 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDG-0001vd-LK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788731; x=1762324731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IFyldM/wkLLjkzgvXirqmq3JCBeSDG+HIbY0Aejj2GY=;
 b=jY5Xol2L2k9Yl/rytxWsgRZPJMHRIXRyWdaDkRFfDvIFukH2usdmTy5j
 xo1NPXyvdodpUe6MiJMplqBJUaORso2qx1ELZmbGQMillglOD8PHeIgt+
 SyC/njbY+tIx7go2Xk0hlYOFLajCE84e4dd1rqv4LqEH0h1ihwKkvPPac
 jAlJO/7AXEYXSUdRnbKZYcmzxOWqihzaf3Icqp0gAPDjCaDZF/VKBRBW1
 f9Iz9zwEuHyE0fkq/PEpcXS5sO0tS38csgqQOOomoy9MBYv+DeloNwkb+
 C2L6OA93U2vHTDlUrNg7mNx8xw846NZYx62wkr4e4PnUC7/00mVAfiphM w==;
X-CSE-ConnectionGUID: vLbXF8/ASZWx0BbpdUDSXQ==
X-CSE-MsgGUID: OYsubaVMT2WkfyZmkPCg+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689680"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:38:40 -0800
X-CSE-ConnectionGUID: iuT24egDTnOHJU8nk9k9hQ==
X-CSE-MsgGUID: 35Pm2IzXRcuowvndLGKt2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989208"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:38:36 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 32/60] i386/tdx: implement tdx_cpu_instance_init()
Date: Tue,  5 Nov 2024 01:23:40 -0500
Message-Id: <20241105062408.3533704-33-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, pmu is not supported for TDX by KVM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
chanegs in v6:
 - new patch;
---
 target/i386/kvm/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 394f1d75dc0d..61fb1f184149 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -384,6 +384,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_TDX_VM;
 }
 
+static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
+{
+    object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -727,4 +732,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
 
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
+    x86_klass->cpu_instance_init = tdx_cpu_instance_init;
 }
-- 
2.34.1


