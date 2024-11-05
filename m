Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C149D1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DHK-0006hy-T9; Tue, 05 Nov 2024 01:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DFs-0003vI-8P
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:41:32 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DFG-0001vj-Pq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788855; x=1762324855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=prNelkC3OOqKiNVm+vMpEf1u/DtP+lyJhK2V/YRgjzw=;
 b=Ak1d0aKZXlTgypm4kR0Opy8p+rbc1xZ7r6JUobhQTQzc77u4WSRRv2RB
 d+ZW455y32Vqjzi/cNsFzZRM3UeJgJlu6Y7KrMnigj/Ufc4EVc4huI0EE
 y04F8cnq/kHTyo2N1tRTpNGf4A5E6r/HpUizpxUKXTvi3pbTzBwBK8YTu
 ivqItQ0LCR8a+8Twl/LFfV12Q7nIuIk3h3Gj/JqPhbXiPjucfa5G7Gve5
 HU2p2Y8I5KiqvV5VY+j8RV02nCSUxf+NzBS5dxOG61fDTg4rkvVzwlij5
 eBBQEru03KePVmjk+0rSwzAH60rcot079iBSDCXNIqffjIPSaO0jxYNvU g==;
X-CSE-ConnectionGUID: DPFZyhcfQ0CrxUNlTqPJeg==
X-CSE-MsgGUID: X164P7OXTJ6R+YSw8iQTQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689973"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689973"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:39 -0800
X-CSE-ConnectionGUID: WC4TK0djRPSDZtiizpWwBg==
X-CSE-MsgGUID: +YDffLFqRz2Vf56nozSFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83990158"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:35 -0800
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
Subject: [PATCH v6 60/60] docs: Add TDX documentation
Date: Tue,  5 Nov 2024 01:24:08 -0500
Message-Id: <20241105062408.3533704-61-xiaoyao.li@intel.com>
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

Add docs/system/i386/tdx.rst for TDX support, and add tdx in
confidential-guest-support.rst

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - Add more information of "Feature configuration"
 - Mark TD Attestation as future work because KVM now drops the support
   of it.

Changes in v5:
 - Add TD attestation section and update the QEMU parameter;

Changes since v1:
 - Add prerequisite of private gmem;
 - update example command to launch TD;

Changes since RFC v4:
 - add the restriction that kernel-irqchip must be split
---
 docs/system/confidential-guest-support.rst |   1 +
 docs/system/i386/tdx.rst                   | 155 +++++++++++++++++++++
 docs/system/target-i386.rst                |   1 +
 3 files changed, 157 insertions(+)
 create mode 100644 docs/system/i386/tdx.rst

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 0c490dbda2b7..66129fbab64c 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -38,6 +38,7 @@ Supported mechanisms
 Currently supported confidential guest mechanisms are:
 
 * AMD Secure Encrypted Virtualization (SEV) (see :doc:`i386/amd-memory-encryption`)
+* Intel Trust Domain Extension (TDX) (see :doc:`i386/tdx`)
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
 
diff --git a/docs/system/i386/tdx.rst b/docs/system/i386/tdx.rst
new file mode 100644
index 000000000000..60106b29bf72
--- /dev/null
+++ b/docs/system/i386/tdx.rst
@@ -0,0 +1,155 @@
+Intel Trusted Domain eXtension (TDX)
+====================================
+
+Intel Trusted Domain eXtensions (TDX) refers to an Intel technology that extends
+Virtual Machine Extensions (VMX) and Multi-Key Total Memory Encryption (MKTME)
+with a new kind of virtual machine guest called a Trust Domain (TD). A TD runs
+in a CPU mode that is designed to protect the confidentiality of its memory
+contents and its CPU state from any other software, including the hosting
+Virtual Machine Monitor (VMM), unless explicitly shared by the TD itself.
+
+Prerequisites
+-------------
+
+To run TD, the physical machine needs to have TDX module loaded and initialized
+while KVM hypervisor has TDX support and has TDX enabled. If those requirements
+are met, the ``KVM_CAP_VM_TYPES`` will report the support of ``KVM_X86_TDX_VM``.
+
+Trust Domain Virtual Firmware (TDVF)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Trust Domain Virtual Firmware (TDVF) is required to provide TD services to boot
+TD Guest OS. TDVF needs to be copied to guest private memory and measured before
+the TD boots.
+
+KVM vcpu ioctl ``KVM_TDX_INIT_MEM_REGION`` can be used to populates the TDVF
+content into its private memory.
+
+Since TDX doesn't support readonly memslot, TDVF cannot be mapped as pflash
+device and it actually works as RAM. "-bios" option is chosen to load TDVF.
+
+OVMF is the opensource firmware that implements the TDVF support. Thus the
+command line to specify and load TDVF is ``-bios OVMF.fd``
+
+Feature Configuration
+---------------------
+
+Unlike non-TDX VM, the CPU features (enumerated by CPU or MSR) of a TD is not
+under full control of VMM. VMM can only configure part of features of a TD on
+``KVM_TDX_INIT_VM`` command of VM scope ``MEMORY_ENCRYPT_OP`` ioctl.
+
+The configurable features have three types:
+
+- Attributes:
+  - PKS (bit 30) controls whether Supervisor Protection Keys is exposed to TD,
+  which determines related CPUID bit and CR4 bit;
+  - PERFMON (bit 63) controls whether PMU is exposed to TD.
+
+- XSAVE related features (XFAM):
+  XFAM is a 64b mask, which has the same format as XCR0 or IA32_XSS MSR. It
+  determines the set of extended features available for use by the guest TD.
+
+- CPUID features:
+  Only some bits of some CPUID leaves are directly configurable by VMM.
+
+What features can be configured is reported via TDX capabilities.
+
+TDX capabilities
+~~~~~~~~~~~~~~~~
+
+The VM scope ``MEMORY_ENCRYPT_OP`` ioctl provides command ``KVM_TDX_CAPABILITIES``
+to get the TDX capabilities from KVM. It returns a data structure of
+``struct kvm_tdx_capabilities``, which tells the supported configuration of
+attributes, XFAM and CPUIDs.
+
+TD attributes
+~~~~~~~~~~~~~
+
+QEMU supports configuring raw 64-bit TD attributes directly via "attributes"
+property of "tdx-guest" object. Note, it's users' responsibility to provide a
+valid value because some bits may not supported by current QEMU or KVM yet.
+
+QEMU also supports the configuration of individual attribute bits that are
+supported by it, via propertyies of "tdx-guest" object.
+E.g., "sept-ve-disable" (bit 63).
+
+MSR based features
+~~~~~~~~~~~~~~~~
+
+Current KVM doesn't support MSR based feature (e.g., MSR_IA32_ARCH_CAPABILITIES)
+configuration for TDX, and it's a future work to enable it in QEMU when KVM adds
+support of it.
+
+Feature check
+~~~~~~~~~~~~~
+
+QEMU checks if the final (CPU) features, determined by given cpu model and
+explicit feature adjustment of "+featureA/-featureB", can be supported or not.
+It can produce feature not supported warnning like
+
+  "warning: host doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]"
+
+It will also procude warning like
+
+  "warning: TDX forcibly sets the feature: CPUID.80000007H:EDX.invtsc [bit 8]"
+
+if the fixed-1 feature is requested to be disabled explicitly. This is newly
+added to QEMU for TDX because TDX has fixed-1 features that are enfored enabled
+by TDX module and VMM cannot disable them.
+
+Launching a TD (TDX VM)
+-----------------------
+
+To launch a TDX guest, below are new added and required:
+
+.. parsed-literal::
+
+    |qemu_system_x86| \\
+        -object tdx-guest,id=tdx0 \\
+        -machine ...,kernel-irqchip=split,confidential-guest-support=tdx0 \\
+        -bios OVMF.fd \\
+
+restrictions
+------------
+
+ - kernel-irqchip must be split;
+
+ - No readonly support for private memory;
+
+ - No SMM support: SMM support requires manipulating the guset register states
+   which is not allowed;
+
+Debugging
+---------
+
+Bit 0 of TD attributes, is DEBUG bit, which decides if the TD runs in off-TD
+debug mode. When in off-TD debug mode, TD's VCPU state and private memory are
+accessible via given SEAMCALLs. This requires KVM to expose APIs to invoke those
+SEAMCALLs and resonponding QEMU change.
+
+It's targeted as future work.
+
+TD attestation
+--------------
+
+In TD guest, the attestation process is used to verify the TDX guest
+trustworthiness to other entities before provisioning secrets to the guest.
+
+TD attestation is initiated first by calling TDG.MR.REPORT inside TD to get the
+REPORT. Then the REPORT data needs to be converted into a remotely verifiable
+Quote by SGX Quoting Enclave (QE).
+
+It's a future work in QEMU to add support of TD attestation since it lacks
+support in current KVM.
+
+Live Migration
+--------------
+
+Future work.
+
+References
+----------
+
+- `TDX Homepage <https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html>`__
+
+- `SGX QE <https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master/QuoteGeneration>`__
diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
index ab7af1a75d6e..43b09c79d6be 100644
--- a/docs/system/target-i386.rst
+++ b/docs/system/target-i386.rst
@@ -31,6 +31,7 @@ Architectural features
    i386/kvm-pv
    i386/sgx
    i386/amd-memory-encryption
+   i386/tdx
 
 OS requirements
 ~~~~~~~~~~~~~~~
-- 
2.34.1


