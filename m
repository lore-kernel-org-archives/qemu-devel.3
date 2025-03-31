Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D3AC36017
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 05:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tz89C-0007YK-F5; Mon, 31 Mar 2025 01:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tz88o-0007XN-Nr
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 01:57:00 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tz88h-0003Yz-R1
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 01:56:56 -0400
X-ASG-Debug-ID: 1743400597-086e231f495ce10001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id 4IFvjzZrweWMK5SK (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 31 Mar 2025 13:56:37 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 31 Mar
 2025 13:56:37 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Mon, 31 Mar 2025 13:56:37 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 31 Mar
 2025 11:55:21 +0800
Message-ID: <e3a64575-ab1f-4b6f-a91d-37a862715742@zhaoxin.com>
Date: Mon, 31 Mar 2025 11:55:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>, <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers
 during VM reset
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <sandipan.das@amd.com>,
 <babu.moger@amd.com>, <likexu@tencent.com>, <like.xu.linux@gmail.com>,
 <zhenyuw@linux.intel.com>, <groug@kaod.org>, <khorenko@virtuozzo.com>,
 <alexander.ivanov@virtuozzo.com>, <den@virtuozzo.com>,
 <davydov-max@yandex-team.ru>, <xiaoyao.li@intel.com>,
 <dapeng1.mi@linux.intel.com>, <joe.jin@oracle.com>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>, <silviazhao@zhaoxin.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
 <8a547bf5-bdd4-4a49-883a-02b4aa0cc92c@zhaoxin.com>
 <84653627-3a20-44fd-8955-a19264bd2348@oracle.com>
From: ewanhai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <84653627-3a20-44fd-8955-a19264bd2348@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 3/31/2025 1:56:35 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1743400597
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5602
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.61
X-Barracuda-Spam-Status: No,
 SCORE=-1.61 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA085b, TRACK_DBX_001
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139273
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.01 TRACK_DBX_001          Custom rule TRACK_DBX_001
 0.40 BSF_SC0_SA085b         Custom Rule SA085b
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Hi Dongli,

I noticed you've sent the V3 patchset, but I believe it's more appropriate to
continue the discussion about the issues you encountered in this thread.

On 3/29/25 12:42 AM, Dongli Zhang wrote:
> The vendor and CPU are different. i.e., if we use Zhaoxin CPU without
> configuring vendor: "-cpu YongFeng,+pmu \" on Intel KVM.
>
> The CPU is Zhaoxin while vendor is still Intel.
[1] QEMU always sets the vCPU's vendor to match the host's vendor when
acceleration (KVM or HVF) is enabled(except for users set guest vendor
with -cpu xx, vendor=xx).
> The PMU selection is based on vendor, not CPU.
>
> [    0.321163] smpboot: CPU0: Intel Zhaoxin YongFeng Processor (family: 0x7,
> model: 0xb, stepping: 0x3)
> [    0.321996] Performance Events: generic architected perfmon, Intel PMU driver.
> [    0.322867] ... version:                2
> [    0.323738] ... bit width:              48
> [    0.323864] ... generic registers:      4
> [    0.324776] ... value mask:             0000ffffffffffff
> [    0.324864] ... max period:             000000007fffffff
> [    0.325864] ... fixed-purpose events:   3
> [    0.326749] ... event mask:             000000070000000f
>
> By default, IS_INTEL_CPU() still returns true even we emulate Zhaoxin on Intel KVM.

[2] As mentioned in [1], QEMU always sets the vCPU's vendor to match the host's vendor
when acceleration (KVM or HVF) is enabled. Therefore, if users want to emulate a
Zhaoxin CPU on an Intel host, the vendor must be set manually.Furthermore, should we display a warning to users who enable both vPMU and KVM acceleration but do not manually set the guest vendor when it differs from the host vendor?
> I did many efforts, and I could not use Zhaoxin's PMU on Intel hypervisor.
>
> According to arch/x86/events/zhaoxin/core.c, the Zhaoxin's PMU is working in
> limited conditions, especially only when stepping >= 0xe.
>
> switch (boot_cpu_data.x86) {
> case 0x06:
>      /*
>       * Support Zhaoxin CPU from ZXC series, exclude Nano series through FMS.
>       * Nano FMS: Family=6, Model=F, Stepping=[0-A][C-D]
>       * ZXC FMS: Family=6, Model=F, Stepping=E-F OR Family=6, Model=0x19,
> Stepping=0-3
>       */
>      if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
>              boot_cpu_data.x86_model == 0x19) {
>
>
>  From QEMU, the stepping of YongFeng is always 3.
>
> 5502         .name = "YongFeng",
> 5503         .level = 0x1F,
> 5504         .vendor = CPUID_VENDOR_ZHAOXIN1,
> 5505         .family = 7,
> 5506         .model = 11,
> 5507         .stepping = 3,
>
> Therefore, I cannot enable Zhaoxin's PMU on Intel KVM.
>
> -cpu YongFeng,vendor="CentaurHauls",+pmu \
>
> [    0.253229] smpboot: CPU0: Centaur Zhaoxin YongFeng Processor (family: 0x7,
> model: 0xb, stepping: 0x3)
> [    0.254009] Performance Events:
> [    0.254009] core: Welcome to zhaoxin pmu!
> [    0.254880] core: Version check pass!
> [    0.255567] no PMU driver, software events only.
>
>
> It doesn't work on Intel Icelake hypervisor too, even with "host".
>
> -cpu host,vendor="CentaurHauls",+pmu \
>
> [    0.268434] smpboot: CPU0: Centaur Intel(R) Xeon(R) Gold 6354 CPU @ 3.00GHz
> (family: 0x6, model: 0x6a, stepping: 0x6)
> [    0.269237] Performance Events:
> [    0.269237] core: Welcome to zhaoxin pmu!
> [    0.270112] core: Version check pass!
> [    0.270768] no PMU driver, software events only.
>
>
> The PMU never works, although cpuid returns PMU config.
>
> [root@vm ~]# cpuid -1 -l 0xa
> CPU:
>     Architecture Performance Monitoring Features (0xa):
>        version ID                               = 0x2 (2)
>        number of counters per logical processor = 0x8 (8)
>        bit width of counter                     = 0x30 (48)
>        length of EBX bit vector                 = 0x8 (8)
>        core cycle event                         = available
>        instruction retired event                = available
>        reference cycles event                   = available
>        last-level cache ref event               = available
>        last-level cache miss event              = available
>        branch inst retired event                = available
>        branch mispred retired event             = available
>        top-down slots event                     = available
> ... ...
>        number of contiguous fixed counters      = 0x3 (3)
>        bit width of fixed counters              = 0x30 (48)
>        anythread deprecation                    = true
>
>
> So far I am not able to use Zhaoxin PMU on Intel hypervisor.
>
> Since I don't have Zhaoxin environment, I am not sure about "vice versa".
>
> Unless there is more suggestion from Zhao, I may replace is_same_vendor() with
> vendor_compatible().
I'm sorry I didn't provide you with enough information about the Zhaoxin PMU.

1. I made a mistake in the Zhaoxin YongFeng vCPU model patch. The correct model
should be 0x5b, but I mistakenly set it to 0xb (11). The mistake happened because
I overlooked the extended model bits from cpuid[eax=0x1].eax and only used the
base model. I'll send a fix patch soon.

2. As you can see in zhaoxin_pmu_init() in the Linux kernel, there is no handling
for CPUs with family 0x7 and model (base + extended) 0x5b. The reason is clear:
we submitted a patch for zhaoxin_pmu_init() to support YongFeng two years ago
(https://lore.kernel.org/lkml/20230323024026.823-1-silviazhao-oc@zhaoxin.com/),
but received no response. We will keep trying to resubmit it.



