Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8BFC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVox-0000dQ-8v; Wed, 22 Jul 2026 08:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wmVou-0000cp-CC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:13:04 -0400
Received: from [115.124.28.97] (helo=out28-97.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wmVop-0005CL-TE
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:13:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07438458|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00192932-6.01843e-05-0.998011;
 FP=7181970613962591499|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033032053168;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.iS5c.XV_1784722236; 
Received: from 192.168.124.3(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iS5c.XV_1784722236 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 22 Jul 2026 20:10:37 +0800
Message-ID: <ed76e6e5-27c8-42c0-b9ef-0275f2fe4221@open-hieco.net>
Date: Wed, 22 Jul 2026 20:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] target/i386: Fix Hygon vendor-specific CPU behavior
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@hygon.cn>, Yongwei Xu <xuyongwei@hygon.cn>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
Content-Language: en-US
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.97 (deferred)
Received-SPF: pass client-ip=115.124.28.97;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-97.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

Just a gentle ping on this series.

This series fixes several Hygon Dhyana vendor-specific CPU behavior gaps 
where QEMU currently keys AMD-compatible paths only on AuthenticAMD.

The guest-visible changes are gated by x-hygon-vendor-abi-fixes and kept 
off for pc-11.0 and older machine types.  The KVM runtime changes do not 
change guest CPU model ABI.

Any comments would be appreciated.

Thanks,
Tina

On 7/6/2026 1:55 PM, zhang_wei@open-hieco.net wrote:
> From: Tina Zhang <zhang_wei@hygon.cn>
> 
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
> machine types and is disabled for pc-11.0 and older, so existing machine
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
> Tests were added for the Dhyana CPUID/ucode compatibility behavior and
> for the Hygon HT GPA hole memory-layout case.
> 
> Tested with:
> 
>    ninja -C build
> 
>    build/pyvenv/bin/meson test -C build --print-errorlogs \
>        qemu:qtest-i386/test-x86-cpuid-compat \
>        qemu:qtest-x86_64/test-x86-cpuid-compat \
>        qemu:func-x86_64-mem_addr_space
> 
> Tina Zhang (9):
>    target/i386: Sync AMD CPUID aliases for Hygon
>    target/i386: Hide Intel cache CPUID leaves for Hygon
>    target/i386: Hide ARCH_CAPABILITIES for Hygon
>    target/i386/kvm: Use AMD MCE status encoding for Hygon
>    target/i386/kvm: Use AMD PMU MSR paths for Hygon
>    target/i386: Do not broadcast injected MCEs for Hygon
>    hw/i386: Apply AMD IOMMU HT GPA hole to Hygon
>    target/i386: Use AMD legacy cache fallback for Hygon
>    target/i386: Use AMD ucode-rev default for Hygon
> 
>   hw/i386/pc.c                                  | 22 +++--
>   target/i386/cpu.c                             | 86 +++++++++++++----
>   target/i386/cpu.h                             | 12 +++
>   target/i386/helper.c                          |  6 +-
>   target/i386/kvm/kvm.c                         | 36 +++++--
>   .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++
>   tests/qtest/test-x86-cpuid-compat.c           | 95 +++++++++++++++++++
>   7 files changed, 263 insertions(+), 30 deletions(-)
> 


