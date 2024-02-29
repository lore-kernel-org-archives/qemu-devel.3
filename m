Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5E0C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa6I-0005BF-S5; Thu, 29 Feb 2024 01:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa5R-0004eE-Ma
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:40:10 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa5P-0004k0-3X
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188807; x=1740724807;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RufphmQEPuA7XlGyHgJtu3PHVWvGWDXbQzQBGXxFCy0=;
 b=eWP0fq+MgAHRTNRbFC9baezf1Yoh2NQIWFQEoBXsV2X5nJY4QRnY/S0z
 oQcT7TNQ0H3QGvXT04hMWzNj+hgC9NFH1pVfTkDyNcJ1Q8CKKc/9SAEDu
 Pwk0FvwVfbK0JXAmRe1oIbf3uzZ5Kcc+fCHeLJ0hVriliMvRDo7iMUguF
 WgzDaVC10REOZrRgRG42zRvP/xhAD5xo4mkkIe1+5dmR0QIpRGoge7yEc
 Kl7oizx6YM8+diNKQE/HiCXZ08gzeklChN9GwhIJL6pRU5g+h75Xu2R7Z
 b5JP8KHoYV8n38d6IvxbSHiWRjWgPJjvPVQwXkyN0KWO6tuDS8AuUrtpJ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802695"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:40:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075458"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:39:59 -0800
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
Subject: [PATCH v5 23/65] kvm: Introduce kvm_arch_pre_create_vcpu()
Date: Thu, 29 Feb 2024 01:36:44 -0500
Message-Id: <20240229063726.610065-24-xiaoyao.li@intel.com>
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

Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
work prior to create any vcpu. This is for i386 TDX because it needs
call TDX_INIT_VM before creating any vcpu.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
Changes in v3:
- pass @errp to kvm_arch_pre_create_vcpu(); (Per Daniel)
---
 accel/kvm/kvm-all.c  | 10 ++++++++++
 include/sysemu/kvm.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0c0719a0303c..a8a99d48e4ce 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -418,6 +418,11 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
 }
 
+int __attribute__ ((weak)) kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
     KVMState *s = kvm_state;
@@ -426,6 +431,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
+    ret = kvm_arch_pre_create_vcpu(cpu, errp);
+    if (ret < 0) {
+        goto err;
+    }
+
     ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
     if (ret < 0) {
         error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 8e83adfbbd19..82b547848130 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -341,6 +341,7 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
-- 
2.34.1


