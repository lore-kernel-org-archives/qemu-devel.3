Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE80C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FPe-00083U-LG; Mon, 31 Aug 2026 23:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1x1FPb-000836-8j
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:43:51 -0400
Received: from [115.124.28.217] (helo=out28-217.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1x1FPU-0003fX-Ef
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:43:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0743627|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.00209805-6.34468e-05-0.997838;
 FP=7163956215470933291|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037006180;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.j2.4mKD_1788234082; 
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.j2.4mKD_1788234082 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 01 Sep 2026 11:41:25 +0800
Message-ID: <355edd32-2854-45b2-9ea6-5b3e93ade281@open-hieco.net>
Date: Tue, 1 Sep 2026 11:41:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] target/i386: Fix Hygon vendor-specific CPU
 behavior
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260824045314.162941-1-zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.217 (deferred)
Received-SPF: pass client-ip=115.124.28.217;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-217.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

A gentle ping on this series. Any comments would be appreciated.


Thanks,
Tina

On 8/24/2026 12:53 PM, Tina Zhang wrote:
> Hygon Dhyana uses the HygonGenuine vendor string, but a number of
> guest-visible and KVM-facing interfaces follow AMD-compatible behavior.
> QEMU currently keys several of these paths only on AuthenticAMD, so Hygon
> guests can see vendor-inconsistent CPUID/MSR state or use the wrong KVM
> PMU/MCE handling paths.
> 
> This series makes those checks explicit for Hygon where appropriate.
> 
> Guest-visible CPU ABI changes are gated by the new
> x-hygon-vendor-abi-fixes property.  The property defaults to true for new
> machine types and is disabled for pc-11.1 and older, so existing machine
> types keep their previous Hygon ABI for migration compatibility.
> 
> The KVM injected-MCE and PMU path changes are not CPUID model table
> changes.  They make QEMU use the AMD-compatible runtime handling that
> Linux/KVM already uses for Hygon.
> 
> The series covers:
> 
>    * AMD CPUID[0x80000001].EDX aliases for Hygon
>    * hiding Intel cache CPUID leaves 2 and 4 for Hygon
>    * hiding IA32_ARCH_CAPABILITIES for Hygon unless old ABI requires it
>    * AMD MCE status encoding for Hygon memory-failure injection
>    * AMD PMU MSR setup/save/restore paths for Hygon
>    * disabling Intel-style MCA broadcast for Hygon injected MCEs
>    * AMD IOMMU HT GPA hole layout for Hygon on new machine types
>    * AMD legacy cache fallback for Hygon when legacy-cache=on
>    * AMD-shaped default ucode-rev value for Hygon
> 
> Changes in v3:
> 
>    * Rebased onto QEMU master at v11.1.0-453-geea8fe61b8.  Use the
>      pc_compat_11_1 infrastructure already present upstream and remove the
>      duplicate compatibility wiring from the i440fx and q35 11.0 machine
>      options.  Preserve the old Hygon ABI through pc-11.1 and update the
>      affected commit messages accordingly.  (Zhao)
>    * Split the PMU change into a no-functional-change vendor-family
>      refactoring patch followed by the Hygon-specific change.  (Zhao)
>    * Fold enforce_amd_1tb_hole and x-hygon-vendor-abi-fixes into the IOMMU
>      HT GPA hole helper and update its comment.  Use explicit pc-q35-11.2
>      and pc-q35-11.1 machine versions in the functional tests and include
>      those versions in the test names.  (Zhao)
>    * Remove the redundant vendor-specific comment from the ucode-rev
>      default path.  (Zhao)
>    * Update the hygon_vendor_abi_fixes field comment to follow the style of
>      other machine-type compatibility fields.
>    * Add Reviewed-by tags from Zhao Liu to the Hygon MCE status, MCE
>      broadcast, and ucode-rev patches.
> 
> Changes in v2:
> 
>    * Rebased onto v11.1.0-rc3.  Moved the compatibility property to
>      pc_compat_11_1 and wired it into the i440fx and q35 11.1 machine
>      options.  (Zhao)
>    * Patch 1: removed the single-use CPUID-alias helper and checked Hygon
>      directly at the call site.  Also updated the hygon_vendor_abi_fixes
>      field comment to emphasize that it is a machine-type compatibility
>      option.  (Zhao)
>    * Patch 4: removed the single-use MCE-status helper and checked Hygon
>      directly at the call site.  (Zhao)
>    * Patch 5: reworked the PMU vendor checks around a common PMU vendor-family
>      abstraction, covering host/guest compatibility, PMU initialization,
>      and PMU MSR save/restore.  (Zhao)
>    * Collected Reviewed-by tags for patches 2, 3, and 8.
> 
> Tested with:
> 
>    ninja -C build
> 
>    build/pyvenv/bin/meson test -C build --print-errorlogs \
>        qemu:qtest-x86_64/test-x86-cpuid-compat \
>        qemu:func-x86_64-mem_addr_space
> 
> Tina Zhang (10):
>    target/i386: Sync AMD CPUID aliases for Hygon
>    target/i386: Hide Intel cache CPUID leaves for Hygon
>    target/i386: Hide ARCH_CAPABILITIES for Hygon
>    target/i386/kvm: Use AMD MCE status encoding for Hygon
>    target/i386/kvm: Classify PMU vendor families
>    target/i386/kvm: Use AMD PMU MSR paths for Hygon
>    target/i386: Do not broadcast injected MCEs for Hygon
>    hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
>    target/i386: Use AMD legacy cache fallback for Hygon
>    target/i386: Use AMD ucode-rev default for Hygon
> 
>   hw/i386/pc.c                                  | 30 ++++--
>   target/i386/cpu.c                             | 68 +++++++++----
>   target/i386/cpu.h                             | 12 +++
>   target/i386/helper.c                          |  2 +-
>   target/i386/kvm/kvm.c                         | 75 +++++++++++----
>   .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++
>   tests/qtest/test-x86-cpuid-compat.c           | 95 +++++++++++++++++++
>   7 files changed, 275 insertions(+), 43 deletions(-)
> 


