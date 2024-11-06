Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9721D44D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gXi-00073l-Ud; Wed, 06 Nov 2024 08:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8gXb-0006zs-IS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:57:48 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8gXZ-0000tS-8l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730901466; x=1762437466;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zwAC45OJhmnmO548e21DRwBu5ZsdXTpXh46ezboPAA0=;
 b=WGnAtiKB9WjTcdNOZ7J3Nuq1wHCQ4lr6FixZYJnLi3x/NqR7MGFidc8K
 DayyAOYc8jV/Sv638UgprN42uZVJbKhsxMrAkY0o9nrhGckMjxTB41aj0
 zp5Aov7wYKRyZVoD2nhDz1LhcTH5t0XMF30d6tixxfxEflN57BAP5cpNu
 Zys08seJ9nOmBDWK7Q1lMJjUK87jJL52KyN/h72RQMaBHmhryU5q4dYNj
 QZuI6x1aLQCHEmJL9AdGmLxxDSmaFfHEx+DQfr5YkN8DOuqHZUF2uXwb6
 cnO4PEjqe22HLMI3YzGMApCpkqGcHPLGbkAqTWufAyQ/eE7ac6dLuanam g==;
X-CSE-ConnectionGUID: FBfBtSV6T5S72SAj5EUrjg==
X-CSE-MsgGUID: Gf5163wSQWiN7fpV3gebXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30812702"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; d="scan'208";a="30812702"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 05:57:41 -0800
X-CSE-ConnectionGUID: 9/wVuzWVSm+bO4Sl9QL7Gw==
X-CSE-MsgGUID: o/0fKsyyQkKtzT+HyjzVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; d="scan'208";a="84680014"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 05:57:35 -0800
Message-ID: <35233d1f-eb6c-4882-abd6-884c1f559e12@intel.com>
Date: Wed, 6 Nov 2024 21:57:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 45/60] i386/tdx: Don't get/put guest state for TDX VMs
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-46-xiaoyao.li@intel.com>
 <8cd78103-5f49-4cbd-814d-a03a82a59231@redhat.com>
 <e5d02d7f-a989-4484-b0c1-3d7ac804ec73@intel.com>
 <a90e29a6-0e07-46a3-8dfc-658e02af9856@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <a90e29a6-0e07-46a3-8dfc-658e02af9856@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
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

On 11/5/2024 10:23 PM, Paolo Bonzini wrote:
> On 11/5/24 12:25, Xiaoyao Li wrote:
>> On 11/5/2024 5:55 PM, Paolo Bonzini wrote:
>>> On 11/5/24 07:23, Xiaoyao Li wrote:
>>>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>>>
>>>> Don't get/put state of TDX VMs since accessing/mutating guest state of
>>>> production TDs is not supported.
>>>>
>>>> Note, it will be allowed for a debug TD. Corresponding support will be
>>>> introduced when debug TD support is implemented in the future.
>>>>
>>>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>>
>>> This should be unnecessary now that QEMU has 
>>> kvm_mark_guest_state_protected().
>>
>> Reverting this patch, we get:
>>
>> tdx: tdx: error: failed to set MSR 0x174 to 0x0
>> tdx: ../../../go/src/tdx/tdx-qemu/target/i386/kvm/kvm.c:3859: 
>> kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
>> error: failed to set MSR 0x174 to 0x0
>> tdx: ../../../go/src/tdx/tdx-qemu/target/i386/kvm/kvm.c:3859: 
>> kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> Difficult to "debug" without even a backtrace, but you might be calling 
> kvm_mark_guest_state_protected() too late.  For SNP, the entry values of 
> the registers are customizable, for TDX they're not.  So for TDX I think 
> it should be called even before realize completes, whereas SNP only 
> calls it on the first transition to RUNNING.

TDX calls kvm_mark_guest_state_protected() very early in
   kvm_arch_init() -> tdx_kvm_init()

I find the call site. It's caused by kvm_arch_put_register() called in 
kvm_cpu_exec() because cpu->vcpu_dirty is set to true in kvm_create_vcpu().

Maybe we can do something like below?

8<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -457,7 +457,9 @@ int kvm_create_vcpu(CPUState *cpu)

      cpu->kvm_fd = kvm_fd;
      cpu->kvm_state = s;
-    cpu->vcpu_dirty = true;
+    if (!s->guest_state_protected) {
+        cpu->vcpu_dirty = true;
+    }
      cpu->dirty_pages = 0;
      cpu->throttle_us_per_full = 0;

> Paolo
> 


