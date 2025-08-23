Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463AECA0EFA
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 09:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upksJ-0005rl-FD; Sat, 23 Aug 2025 05:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1upksH-0005r7-J6
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 05:49:26 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1upksF-0002ob-Be
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 05:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755942563; x=1787478563;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HASuy6wOSb6ZkYHRnHmYDpLtw776pHCOM/ht1RxioX0=;
 b=Mjt578JowBPpS6l1VLAs0QmRrzQsacugueMGoUZTs0CmI+3gGIPb2VqO
 meWGF6+HKwQBoE/+SfpQAPQi0r9UZEh4jXcY9MlbSegfqq2B8uGHNMxsB
 yaL3xN59R394F3RDzFBWKEii0V+m8iTjD+K9N7bA7Zw3V299afSr4/Yg5
 CwqmCaqMgU0sMzWOzgJ158ijfU8idOcXEv7ANDF4AJG2YSNmPgxM2aMl2
 1FwUbfCqGdXGk4G9OeAPLeO66Le7YExBH8jOpaH0wgKWgU+5ypC4FBEPL
 MVWinx4XUelM2MQKN4J0BYUZvMbnQIOnCshYKfd1PWNeuAPPhVdY+9Q0K A==;
X-CSE-ConnectionGUID: qPtPnk/yR56Xk9Ntt7fQWg==
X-CSE-MsgGUID: gsQ97acwSr2Rp3Ah6tHKpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45804849"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="45804849"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2025 02:49:18 -0700
X-CSE-ConnectionGUID: vxNUc4PkSJqDTZYbdpSzTQ==
X-CSE-MsgGUID: 4rQMmBxETKCBUAibYLLZYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="169248388"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 23 Aug 2025 02:49:15 -0700
Date: Sat, 23 Aug 2025 18:11:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, mtosatti@redhat.com,
 seanjc@google.com, hpa@zytor.com, andrew.cooper3@citrix.com,
 chao.gao@intel.com
Subject: Re: [PATCH v1 1/1] target/i386: Save/restore the nested flag of an
 exception
Message-ID: <aKmTtaOlPewxllUZ@intel.com>
References: <20250723182211.1299776-1-xin@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723182211.1299776-1-xin@zytor.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 23, 2025 at 11:22:11AM -0700, Xin Li (Intel) wrote:
> Date: Wed, 23 Jul 2025 11:22:11 -0700
> From: "Xin Li (Intel)" <xin@zytor.com>
> Subject: [PATCH v1 1/1] target/i386: Save/restore the nested flag of an
>  exception
> X-Mailer: git-send-email 2.50.1
> 
> Save/restore the nested flag of an exception during VM save/restore
> and live migration to ensure a correct event stack level is chosen
> when a nested exception is injected through FRED event delivery.
> 
> The event stack level used by FRED event delivery depends on whether
> the event was a nested exception encountered during delivery of an
> earlier event, because a nested exception is "regarded" as happening
> on ring 0.  E.g., when #PF is configured to use stack level 1 in
> IA32_FRED_STKLVLS MSR:
>   - nested #PF will be delivered on the stack pointed by IA32_FRED_RSP1
>     MSR when encountered in ring 3 and ring 0.
>   - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP0
>     MSR when encountered in ring 3.
>   - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP1
>     MSR when encountered in ring 0.
> 
> As such Qemu needs to track if an event is a nested event during VM
> context save/restore and live migration.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  linux-headers/asm-x86/kvm.h |  4 +++-
>  linux-headers/linux/kvm.h   |  1 +
>  target/i386/cpu.c           |  1 +
>  target/i386/cpu.h           |  1 +
>  target/i386/kvm/kvm.c       | 35 +++++++++++++++++++++++++++++++++++
>  target/i386/kvm/kvm_i386.h  |  1 +
>  target/i386/machine.c       |  1 +
>  7 files changed, 43 insertions(+), 1 deletion(-)

> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 5f83e8850a..7e765b6833 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -54,6 +54,7 @@ typedef struct KvmCpuidInfo {
>  bool kvm_is_vm_type_supported(int type);
>  bool kvm_has_adjust_clock_stable(void);
>  bool kvm_has_exception_payload(void);
> +bool kvm_has_exception_nested_flag(void);
>  void kvm_synchronize_all_tsc(void);
>  
>  void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index dd2dac1d44..a452d2c97e 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -458,6 +458,7 @@ static const VMStateDescription vmstate_exception_info = {
>          VMSTATE_UINT8(env.exception_injected, X86CPU),
>          VMSTATE_UINT8(env.exception_has_payload, X86CPU),
>          VMSTATE_UINT64(env.exception_payload, X86CPU),
> +        VMSTATE_UINT8(env.exception_is_nested, X86CPU),

A new field needs to bump up the version of vmstate_exception_info, but
I'm afraid this will break backward-migration compatibility. So what
about adding a subsction? For example,

diff --git a/target/i386/machine.c b/target/i386/machine.c
index a452d2c97e4c..6ce3cb8af6a6 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -433,6 +433,24 @@ static bool steal_time_msr_needed(void *opaque)
     return cpu->env.steal_time_msr != 0;
 }

+static bool exception_nested_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+
+    return cpu->env.exception_is_nested;
+}
+
+static const VMStateDescription vmstate_exceprtion_nested = {
+    .name = "cpu/exception_nested",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = exception_nested_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(env.exception_is_nested, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool exception_info_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -458,8 +476,11 @@ static const VMStateDescription vmstate_exception_info = {
         VMSTATE_UINT8(env.exception_injected, X86CPU),
         VMSTATE_UINT8(env.exception_has_payload, X86CPU),
         VMSTATE_UINT64(env.exception_payload, X86CPU),
-        VMSTATE_UINT8(env.exception_is_nested, X86CPU),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_exceprtion_nested,
+        NULL,
     }
 };

---
In addition, I think it's better to update header files in a seperate
patch.

Thanks,
Zhao



