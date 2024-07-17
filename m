Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E9AC3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTufa-0005Xf-Kt; Tue, 16 Jul 2024 22:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTuf9-0005Uw-Qt
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:45:08 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTuf2-0006yN-P2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721184297; x=1752720297;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=54yN3ae3lMEpKYOwELZ3DCccXMBGiKaWluZ+q1Q7fao=;
 b=mgB0sEBHtv4INmqc5Ns/3G3kYI52MEtk2OjnBqJi3zwR5JA/I1cy/ta1
 wS6Lrni4w9pU1yuZAGdF4Qzfaa0nofxl6NgSxUJN9V+NRfY56P0qTjZf3
 jK4wJX3vcufyCOPTb5wIZN0/OZvQQHIccp8iXkjBRFtFR1odofU9en5KZ
 I0vGrkhVoLr/ZUGBt6FoXWxRIQ4npffh+FDXiY1fGRGEp5B1sWJQFOjXQ
 JvjSNrV2zoOMU/RKtA+4hSmbDAo5pVzP/JGSew+/MIvk6WdVz6c3psXzb
 hzGmnYVQvhhr4qs+uykW39Te4HF4GcyLvm3cFLYxX+o7nHx16CqYkAgDB Q==;
X-CSE-ConnectionGUID: eF1Lu7yKTNqc+9RekZL6Kw==
X-CSE-MsgGUID: BfUi61yWT92/PWp1KZBwuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29816527"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="29816527"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 19:44:54 -0700
X-CSE-ConnectionGUID: jYhQZdsnT4qCKHwy62vs7g==
X-CSE-MsgGUID: DX3LnU8wRTK1d8cbbSLJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="50289499"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 16 Jul 2024 19:44:52 -0700
Date: Wed, 17 Jul 2024 11:00:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.orgi,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] target/i386: do not crash if microvm guest uses SGX
 CPUID leaves
Message-ID: <Zpcz0cFjW8extm9T@intel.com>
References: <20240716165530.288096-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716165530.288096-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

Hi Paolo,

On Tue, Jul 16, 2024 at 06:55:30PM +0200, Paolo Bonzini wrote:
> Date: Tue, 16 Jul 2024 18:55:30 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: do not crash if microvm guest uses SGX CPUID
>  leaves
> X-Mailer: git-send-email 2.45.2
> 
> sgx_epc_get_section assumes a PC platform is in use:
> 
> bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
> {
>     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> 
> However, sgx_epc_get_section is called by CPUID regardless of whether
> SGX state has been initialized or which platform is in use.  Check
> whether the machine has the right QOM class and if not behave as if
> there are no EPC sections.
> 
> Fixes: 1dec2e1f19f ("i386: Update SGX CPUID info according to hardware/KVM/user input", 2021-09-30)
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2142
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/sgx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
> index de76397bcfb..25b2055d653 100644
> --- a/hw/i386/sgx.c
> +++ b/hw/i386/sgx.c
> @@ -266,10 +266,12 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
>  
>  bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
>  {
> -    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> +    PCMachineState *pcms =
> +        (PCMachineState *)object_dynamic_cast(qdev_get_machine(),
> +                                              TYPE_PC_MACHINE);
>      SGXEPCDevice *epc;
>  
> -    if (pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
> +    if (!pcms || pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
>          return true;
>      }
>  

The above change is necessary...

...but it only avoids encoding sub-leafs CPUID.0x12.{0x2..N}, while
subleafs CPUID.0x12.{0x0,0x1} still have valid SGX information.

According to the error message in qmp_query_sgx(), sgx is only supported
on PC machines. So how about simply taking it a step further and masking
out the entire 0x12 leaf for microvm as well?

for example:

diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 16b1dfd90bb5..38ff75e9f377 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -32,6 +32,11 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
 }

+bool check_sgx_support(void)
+{
+    return false;
+}
+
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
     return true;
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index de76397bcfb3..dcf178b1e755 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -264,6 +264,14 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
                    size);
 }

+bool check_sgx_support(void)
+{
+    if(!object_dynamic_cast(qdev_get_machine(), TYPE_X86_MACHINE)) {
+        return false;
+    }
+    return true;
+}
+
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
diff --git a/include/hw/i386/sgx-epc.h b/include/hw/i386/sgx-epc.h
index 3e00efd870c9..41d55da47999 100644
--- a/include/hw/i386/sgx-epc.h
+++ b/include/hw/i386/sgx-epc.h
@@ -58,6 +58,7 @@ typedef struct SGXEPCState {
     int nr_sections;
 } SGXEPCState;

+bool check_sgx_support(void);
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size);
 void sgx_epc_build_srat(GArray *table_data);

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c05765eeafc8..f0b464f7ea79 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6702,7 +6702,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x12:
 #ifndef CONFIG_USER_ONLY
         if (!kvm_enabled() ||
-            !(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX)) {
+            !(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) ||
+            !check_sgx_support()) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }





