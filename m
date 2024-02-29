Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3D0C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa8X-0001Hw-OS; Thu, 29 Feb 2024 01:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa8U-0001DC-Fs
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:43:18 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa8O-0004qw-DA
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188992; x=1740724992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r0WVqY73FtUvDu2Uo/0GVK8pnEP8ED2vVJ/XQpG4oto=;
 b=BCgGk0Rk1q5e47i1yMEpT3ftyznPhSGApmNeNVeMdjSDb7P8E2lQRRrH
 lZmP+A0rZoWpY4shQd5iTqPF0lU2PkROJS5g50UkVpa4KmlsDhIk2TpvH
 GZ4wP3sYMseAOmAPW7hpIdOuROW1XcsS0sKbksm4LPi6h8jHHFHWUnnmG
 MuCxD7U0KWIn/3Svm8N2+p1Pq6lMbwk01g1VCfLMgQ34HY9wAeCzU5Rbc
 DGxLOafVB0G+2XZV4NeVrCL+agF4sgZaljR0YZ359TbB7Vu5YE/aNwcTw
 r9Vv124WD0Tk+G1WNT1RiSzGaoUFefTON9lM1MzxSHyuuMFEb9kOe4NDC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3803128"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3803128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8076151"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:43:04 -0800
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
Subject: [PATCH v5 51/65] i386/tdx: Handle TDG.VP.VMCALL<REPORT_FATAL_ERROR>
Date: Thu, 29 Feb 2024 01:37:12 -0500
Message-Id: <20240229063726.610065-52-xiaoyao.li@intel.com>
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

TD guest can use TDG.VP.VMCALL<REPORT_FATAL_ERROR> to request termination
with error message encoded in GPRs.

Parse and print the error message, and terminate the TD guest in the
handler.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 39 +++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 88d245577594..6cd72a26b970 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1092,6 +1092,43 @@ static int tdx_handle_get_quote(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
     return 0;
 }
 
+static int tdx_handle_report_fatal_error(X86CPU *cpu,
+                                         struct kvm_tdx_vmcall *vmcall)
+{
+    uint64_t error_code = vmcall->in_r12;
+    char *message = NULL;
+
+    if (error_code & 0xffff) {
+        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: "
+                     "0x%lx\n", error_code);
+        return -1;
+    }
+
+    /* it has optional message */
+    if (vmcall->in_r14) {
+        uint64_t * tmp;
+
+#define GUEST_PANIC_INFO_TDX_MESSAGE_MAX        64
+        message = g_malloc0(GUEST_PANIC_INFO_TDX_MESSAGE_MAX + 1);
+
+        tmp = (uint64_t *)message;
+        /* The order is defined in TDX GHCI spec */
+        *(tmp++) = cpu_to_le64(vmcall->in_r14);
+        *(tmp++) = cpu_to_le64(vmcall->in_r15);
+        *(tmp++) = cpu_to_le64(vmcall->in_rbx);
+        *(tmp++) = cpu_to_le64(vmcall->in_rdi);
+        *(tmp++) = cpu_to_le64(vmcall->in_rsi);
+        *(tmp++) = cpu_to_le64(vmcall->in_r8);
+        *(tmp++) = cpu_to_le64(vmcall->in_r9);
+        *(tmp++) = cpu_to_le64(vmcall->in_rdx);
+        message[GUEST_PANIC_INFO_TDX_MESSAGE_MAX] = '\0';
+        assert((char *)tmp == message + GUEST_PANIC_INFO_TDX_MESSAGE_MAX);
+    }
+
+    error_report("TD guest reports fatal error. %s\n", message ? : "");
+    return -1;
+}
+
 static int tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
                                                    struct kvm_tdx_vmcall *vmcall)
 {
@@ -1126,6 +1163,8 @@ static int tdx_handle_vmcall(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
         return tdx_handle_map_gpa(cpu, vmcall);
     case TDG_VP_VMCALL_GET_QUOTE:
         return tdx_handle_get_quote(cpu, vmcall);
+    case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
+        return  tdx_handle_report_fatal_error(cpu, vmcall);
     case TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
         return tdx_handle_setup_event_notify_interrupt(cpu, vmcall);
     default:
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index b6b8742e79f7..86b1f80d6f49 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -20,6 +20,7 @@ typedef struct TdxGuestClass {
 
 #define TDG_VP_VMCALL_MAP_GPA                           0x10001ULL
 #define TDG_VP_VMCALL_GET_QUOTE                         0x10002ULL
+#define TDG_VP_VMCALL_REPORT_FATAL_ERROR                0x10003ULL
 #define TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT      0x10004ULL
 
 #define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
-- 
2.34.1


