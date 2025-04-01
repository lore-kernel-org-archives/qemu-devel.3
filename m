Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B5CC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbv9-0001SP-Nt; Tue, 01 Apr 2025 09:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtm-0000PT-T7
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:35 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtj-0006ZP-Uu
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515004; x=1775051004;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SDnDEZ+HemTXUXZSKbpixVjsM4Gefo8sgbEfX5qG/N0=;
 b=gAnNtXae9bll6JPzoujvfXcpRJWqnHQQSKrMZBTXN32smDkBFj4Vacbb
 f3mgFa/NBtlikNey81dVl6ntTVwHf5MVffHSq7hANCY5kGDo+JjKlntlQ
 5ShQm9y2Kli7Aogde4zSJ80ippP5kiqC9RTkVMn1XwZxgVDdRICmKQFy8
 nrvr59PumU+BP+A0jZEmu6s6n+pWNl2QA788nyaaENH7rWOHvlNe4WGNI
 OS1QN6wxIqbUguM+GpsuplIgKpzsK42fbCXOxT7SC2QzCsyKTrFaG7imu
 CP/KCqm9QYDlj1KZkThUgnsx9Z8EIum0WJa2h4aIarSovEi9eQAnRmX4X g==;
X-CSE-ConnectionGUID: AC0a8speSM6CNVT/ABshcA==
X-CSE-MsgGUID: eeb92/dDT+KNULV0vfMe9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433435"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433435"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:33 -0700
X-CSE-ConnectionGUID: wFXhjZwiTBa/hM3OoZqZZw==
X-CSE-MsgGUID: T32O+k1vQHqU1eaUlNSZgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640107"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:30 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 32/55] i386/tdx: implement tdx_cpu_instance_init()
Date: Tue,  1 Apr 2025 09:01:42 -0400
Message-Id: <20250401130205.2198253-33-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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
index 282cdbd775c5..49e748af3949 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -400,6 +400,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
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
@@ -781,4 +786,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
 
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
+    x86_klass->cpu_instance_init = tdx_cpu_instance_init;
 }
-- 
2.34.1


