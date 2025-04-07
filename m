Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0596CC3601A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 10:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1jwy-000881-Tm; Mon, 07 Apr 2025 06:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u1jww-00087l-4u
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 06:43:30 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u1jwt-0003lN-9S
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 06:43:29 -0400
X-ASG-Debug-ID: 1744022597-1eb14e119e08610001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx2.zhaoxin.com with ESMTP id ONaZwJBZzTrNwFRq (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 07 Apr 2025 18:43:17 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 7 Apr
 2025 18:43:17 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Mon, 7 Apr 2025 18:43:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Apr
 2025 17:33:15 +0800
Message-ID: <94e8451f-1b44-4e22-8e3f-378c8490cf00@zhaoxin.com>
Date: Mon, 7 Apr 2025 17:33:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers
 during VM reset
CC: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <mtosatti@redhat.com>,
 <sandipan.das@amd.com>, <babu.moger@amd.com>, <likexu@tencent.com>,
 <like.xu.linux@gmail.com>, <zhenyuw@linux.intel.com>, <groug@kaod.org>,
 <khorenko@virtuozzo.com>, <alexander.ivanov@virtuozzo.com>,
 <den@virtuozzo.com>, <davydov-max@yandex-team.ru>, <xiaoyao.li@intel.com>,
 <dapeng1.mi@linux.intel.com>, <joe.jin@oracle.com>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>, <silviazhao@zhaoxin.com>, <yeeli@zhaoxin.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
 <8a547bf5-bdd4-4a49-883a-02b4aa0cc92c@zhaoxin.com>
 <84653627-3a20-44fd-8955-a19264bd2348@oracle.com>
 <e3a64575-ab1f-4b6f-a91d-37a862715742@zhaoxin.com>
 <a94487ab-b06d-4df4-92d8-feceeeaf5ec3@oracle.com>
 <65a6e617-8dd8-46ee-b867-931148985e79@zhaoxin.com>
 <Z/OSEw+yJkN89aDG@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <Z/OSEw+yJkN89aDG@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 4/7/2025 6:43:15 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1744022597
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2128
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.01
X-Barracuda-Spam-Status: No,
 SCORE=-2.01 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=TRACK_DBX_001
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139615
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.01 TRACK_DBX_001          Custom rule TRACK_DBX_001
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
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



On 4/7/25 4:51 PM, Zhao Liu wrote:

> 
> On Tue, Apr 01, 2025 at 11:35:49AM +0800, Ewan Hai wrote:
>> Date: Tue, 1 Apr 2025 11:35:49 +0800
>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>> Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers
>>   during VM reset
>>
>>>> [2] As mentioned in [1], QEMU always sets the vCPU's vendor to match the host's
>>>> vendor
>>>> when acceleration (KVM or HVF) is enabled. Therefore, if users want to emulate a
>>>> Zhaoxin CPU on an Intel host, the vendor must be set manually.Furthermore,
>>>> should we display a warning to users who enable both vPMU and KVM acceleration
>>>> but do not manually set the guest vendor when it differs from the host vendor?
>>>
>>> Maybe not? Sometimes I emulate AMD on Intel host, while vendor is still the
>>> default :)
>>
>> Okay, handling this situation can be rather complex, so let's keep it
>> simple. I have added a dedicated function to capture the intended behavior
>> for potential future reference.
>>
>> Anyway, Thanks for taking Zhaoxin's situation into account, regardless.
>>
> 
> Thanks for your code example!!
> 
> Zhaoxin implements perfmon v2, so I think checking the vendor might be
> overly complicated. If a check is needed, it seems more reasonable to
> check the perfmon version rather than the vendor, similar to how avx10
> version is checked in x86_cpu_filter_features().
> 
> I understand Ewan's concern is that if an Intel guest requires a higher
> perfmon version that the Zhaoxin host doesn't support, there could be
> issues (although I think this situation doesn't currently exist in KVM-QEMU,
> one reason is QEMU uses the pmu_version in 0xa queried from KVM directly,
> which means QEMU currently doesn't support custom pmu_version).

Yeah, that's exactly what I was concerned about.
Thanks for clearing that up!

perfmon_version is a great idea --- I might add it as a property to the QEMU 
vCPU template in the future, so it can adjust based on user input and host support.
Can't promise a timeline yet, but it's definitely something I'll keep in mind.

