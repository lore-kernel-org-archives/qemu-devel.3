Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74062CD1299
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNdZ-0004c6-2b; Thu, 04 Apr 2024 10:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1rsNdR-0004an-I0; Thu, 04 Apr 2024 10:00:09 -0400
Received: from mail-co1nam11on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2416::700]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1rsNdN-0006IF-Ue; Thu, 04 Apr 2024 10:00:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZgSnbxmIQOO6dbLk1w+WCXeGp0GX3MXIwa16Suz0BhSB9dNyYI9h/Ws9kazwqcS3VoABv3fhXyXmtipXx0rKiJMN6uZZjUs8/9v16dE39mrgmbJJNUy7279b8Og+d8XP+Io++ZriqWWxARGPZN3bZnudq+2JmtgtoDNAw/quLJtWkH5fI4waJoN3K3R/UyizOlRSj2vvAmDB9UAXmrkwOEx+AKYAdMb+4FS7BH1U9tPesVySosXhsc71YOjoSIMiIM5cQ5sIl0mUQ4HJ1www1lWUjlY2XTeCQStHJec2MDhkScPeymRy1ghw6DXDrqmr8rJIS3z7qPnM1IINCGfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wH3iJzTN/amQDxE3Q+q2nEdNLA6mGGFVnV2iJwsaz0=;
 b=ZfrLtR0SIBAjSNtkkhlNvxlAC4OHYDNOy2RINRk0anmxKaXDQ3EldssnxLCORmQ4ixZrCcHWrNmzXzmfnMXoXuCFNTzbP30C8hNXdCPGl+vEqJS4Kc/UYsgnzWq4NTs1+X93wKPnrrrfCazG8WKxBXqClZEF0A5vOl2p+oKhAGstru5vjOpNasNocDRsiDNhv4C6RSsatIevWeROY2EdQ53GayzznlRYTD49TK7YqxPxVPOU87ZlA8E/lvrInti/1eJOtgHm5N9ugZhZpBBQ+xgHtAAVjwzTB6mbi9AgVm/Dgom5picSrMOi7A6RXUyd2+KYIbsaRZmb5dYGly+a/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wH3iJzTN/amQDxE3Q+q2nEdNLA6mGGFVnV2iJwsaz0=;
 b=anZBdjMOMVcKWLwq/2HaAYj10HU6nagXLge7JtJzx5oCQeO+UD+FjAE4VCiM8q0st4vE6nnsWHN7U0b2iGxWUy0o6ptzwG9QOFbz5bl2vYkB2iYlCpG8Tg1lfauT2ayIgcinFzakbRc9N0HKd3lknEZEbrcZ99xjRkSJ8VePfpU=
Received: from DM8PR01MB7142.prod.exchangelabs.com (2603:10b6:8:1::11) by
 SJ0PR01MB7527.prod.exchangelabs.com (2603:10b6:a03:3da::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 13:59:53 +0000
Received: from DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1]) by DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 13:59:52 +0000
Content-Type: multipart/alternative;
 boundary="------------kBel8wbk5Cyo6NpiUIMpNbx5"
Message-ID: <565ba0ac-a070-4784-a882-2eeab9c91541@amperemail.onmicrosoft.com>
Date: Thu, 4 Apr 2024 19:29:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com,
 gankulkarni@os.amperecomputing.com
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-2-salil.mehta@huawei.com>
Content-Language: en-US
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <20240312020000.12992-2-salil.mehta@huawei.com>
X-ClientProxiedBy: CY8PR22CA0002.namprd22.prod.outlook.com
 (2603:10b6:930:45::7) To DM8PR01MB7142.prod.exchangelabs.com
 (2603:10b6:8:1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB7142:EE_|SJ0PR01MB7527:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVctIsOxNXhFKSih0h4mLoYqdyFO1DlY7tgoweoIttvEHQ320jZ/CNG+sFWKva6MjejbWVUKFyuJ4kn4nx4SfD+Nr2dr5GRI1p5uMjaonU2DH+4bPdsIUr9N5hgTgS45uANL50bFxodeo+lkPkZWOnSbDCcvRsDdx38nKGWycYfa3T0wL5cEmPAqazjMr68pTw27p1Sya4eM9pi575raVKyfye7lYVGy0e/H/gwC++LDG54np94uzmLX5eeYhsuhy+Lhyj/ve9bUbaomm2OCPOmhmzawfvcSjvVSLLw0IsaOxOwCoRbCgHDiU1gna7X41k3FIwM5DuJ+6L2SFHIMrOUe6vZfRt1smcdexEdQaKawn9rBixTB3cGw2sjtyOlP9cckF1mbw70QovJwZnvIEBNqMUD0OXeWm+pYFPC4Rw9VrAzu/nvfzbLtqDIyVfMYUPrcHOjDR26YJYDM3vAeF12E8thqwR48PtNbeG3RwP55lHWzv1r7GID6RzjhELxQjVMfl9ApL3+vfNH7PUQSjxsAM0a/6v2QaoQkDp182JTdsxcMJ6GZV29IV200ed+5YNMhvvoq5OqB5Lx4F2/wNyqbFklu3IJwysiaI6Z9PkPlKRd+0sc0VgCfEX5XMMWE9BJEXhqLwaEaA/AfziulMVPOvZmXEaLZiVkB66MiDaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB7142.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MThXTGZmbFV1Qis2TFJWTHp0WVZKdlNGaFV4YkNWVDR0bU9hSmwxQ1l5a3M2?=
 =?utf-8?B?SW5od3NHenFyRGlJYkg2cW4walhYQXpTT3pyRkV4cC96NHl1aUJBeDJScWQz?=
 =?utf-8?B?V2hqSUd4SFgzd2FNdlpJaXZ6S080SDlhK3czOHdIeDkzWGtBVi9wTTJMellF?=
 =?utf-8?B?ZldRRTE1NEhTRVNVZ1F3ODhGZnZYZWxOaUVIOTN3djdWUFdWY3lqc2dhMmhk?=
 =?utf-8?B?MERFblVsYTVmdHlYbFBPK1E1eVpSK21TUVRQOGhQWk5UWG5DcTdkckR4SkQz?=
 =?utf-8?B?VCthbTJLeDN1cGE4RTlLaVo3eVJHMndIK1lsSFJPbDFmR1pkTXJkaUt2cHoy?=
 =?utf-8?B?bFQxN2VhL3o0U1k0MDgwM0lmQkRzNExDN3U4dG1qRmpSaWFvUzQvT0l1bG5n?=
 =?utf-8?B?L0xtZlc3M25OT1F5UENZTVIxUHlmaWZvVVdncWUzTGNvRXhCeVJ5Wi81SUF2?=
 =?utf-8?B?RkwrYWxpTGRYREZZUXVyUW9Db05sRm1jbFlYNVNsZWN2L2Z4S1lPSHVDSHVw?=
 =?utf-8?B?ck5XR0RNeUFGQmk3UHQ5QkJPVzI4VGc3clpEbStzN01YZ0hOOEV6dzkrYTVo?=
 =?utf-8?B?a0ZlK2JJWHlOZnFOUmN2ZVd2R1NOZUo2ZExBVHM1eGRzNnlZVjNYdHVsVUFT?=
 =?utf-8?B?eHJpamZvbFg4SkN2ZkRmNHd0dDJnOGh1T1ZDNjNtRzFHbzlITnRwSGZEOGpT?=
 =?utf-8?B?UlhWUmR4dm5tNGwvL3dpczBxS1B6M053Rm1VTzFzdXdDU3ZEVXJ2QVQ5elY4?=
 =?utf-8?B?czJyeThtaG9pTTZ4YVJoVlh2elhtd1FGSjV6VTlWZ0tJYzFCL3lsajIrMkNX?=
 =?utf-8?B?ODhySE4yMllrOFpSQ3BuZ1k2NUE5NklXc25aVEloaHZUOWR6Kzl3QTBQeXIz?=
 =?utf-8?B?aEZMTDg2NnE2bWZUT3dJYUVSRnNGenkzb0YyUmNIYVFsT2JYZHMrTStITCtp?=
 =?utf-8?B?UE01aVdqUkl1ci82MndUaERWRTh6TEcxcTBLMG9UY2JFNFAvaFYvbE9CUFhu?=
 =?utf-8?B?Rm81RlB1c1hMamM3QnJsZlQ0QTVKenBkQzY0KzBrV2wvcGJsZVppNE1ydVl1?=
 =?utf-8?B?SjFPUmR4b2gvcmZXeWNEUkZYK3I4ajV6ZXVSWjlTMWIxWXh4ZFdIWjRPZWlj?=
 =?utf-8?B?Rmo5RHd6aFcyRHV3SGI1Q3IwczQzVXRkZC9lTW9lZWt4Z0N4bUUwUDU0dDhC?=
 =?utf-8?B?U0kyNXlod2RRdjg3RXFvQlZPVmxmNUJ2ZjQ3MXg4eTVkeG4xcFVrcmJnR0xG?=
 =?utf-8?B?MXB1UHhraisvWjJ3RFFMYWdSdjZSbG0vRzBIdFJoSEZBZmR2emFhRlU1R1VS?=
 =?utf-8?B?d3FCc00xVExsLzNLOXA3aXdNbmEzSldZeXNKM0RZQ0U2U2JNNzV2anAzcExy?=
 =?utf-8?B?T0kwb1l0L3ZXZThrRUNLZ01vVURuZGtEMU1uUUpsVUVtTGtZY0IwR0NzVTYw?=
 =?utf-8?B?dlcwcXFwR08zOGtVU0VLUlRGSTVWdUlRSW4rMVc2NzZlVGZRTHplb3VrUEll?=
 =?utf-8?B?REUyUzFvRmVaU3dCR3l0ekVTRzV2UE1aRmtNRFNvQzdBa1k5Rnp5aWhhRngx?=
 =?utf-8?B?eWFRc0RJMUQ2MGo2anFkQmJNYUpQelNVbEIwSjF0Z2swRXlZNHp0VEhGWkpE?=
 =?utf-8?B?Lyt0WCtya2g4QUZrTzFoRllVSzhlcW1xNnlhOHVLYXFIaWxOZ3Y4a250QkZo?=
 =?utf-8?B?K0g3aTVuMEpLT2M3WXM1UUhCcllWbHBlYnN3K0FwdGxCZE5pcll5RXFUYjJ3?=
 =?utf-8?B?bDd2LzUzOUcyOWpablVESnZFMGdzTnpISkNYcFVjbG0rSkZWcTltZldlR1E4?=
 =?utf-8?B?M3N4dnh6aUFkOUJVM1JRb05NejB1VHBLWnNXZk1GN1d2UFVWK2ZoOEppcDJ1?=
 =?utf-8?B?bXRReXBPNnBnQmc0d0g2LzN0SDRTWE1xWGtJaUU3MCtKcGVpTTRkRW44NGh4?=
 =?utf-8?B?R1JPVTFKVkFNOWZJRWdoSDBKZGpnQzU1T3pTVmpNUlBaNVp1cW9uV1owalpT?=
 =?utf-8?B?dlR0QTBEb0ZydFFRQ0V4Y1k4TVNrV2plY0lVL0R6dCtpMThqckZyMWQ4WXJ6?=
 =?utf-8?B?dkFPZHZjRXFLdGhHUklYWGw4ODJYSEVuSm0vSi9FcE96M2h2OVc1RjN3ODZ3?=
 =?utf-8?B?SXhWeVQ0WmJyZUJoMEVQSFd4T3J4TTVSVkVSQW1YQkVWVmlMY2M4a0IraGNE?=
 =?utf-8?Q?IWRCLIKKLrRfiMytGv1OLmE=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dea104-5673-489b-3877-08dc54af802d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB7142.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 13:59:52.7822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bCugVJd7MYucnMlcYfP2V58diAK5Xn+1t10tvPBA4gMXDosbYLyTkVSC8LKW/bYQy4O1PMPYqzk/qAUqpQh6SDtLDwt0jyxo7Wyi42x3GzHYtfI+9Me6QOqYmnBqqZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7527
Received-SPF: pass client-ip=2a01:111:f403:2416::700;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--------------kBel8wbk5Cyo6NpiUIMpNbx5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Salil,

On 12-03-2024 07:29, Salil Mehta wrote:
> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
> is spawned. This is common to all the architectures as of now.
>
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
> support vCPU removal. Therefore, its representative KVM vCPU object/context in
> Qemu is parked.
>
> Refactor architecture common logic so that some APIs could be reused by vCPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
> with trace events instead of DPRINTF. No functional change is intended here.
>
> Signed-off-by: Salil Mehta<salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan<gshan@redhat.com>
> Tested-by: Vishnu Pajjuri<vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li<lixianglai@loongson.cn>
> Tested-by: Miguel Luis<miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang<shahuang@redhat.com>
> ---
>   accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
>   accel/kvm/trace-events |  5 +++-
>   include/sysemu/kvm.h   | 16 +++++++++++
>   3 files changed, 69 insertions(+), 16 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index a8cecd040e..3bc3207bda 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -126,6 +126,7 @@ static QemuMutex kml_slots_lock;
>   #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>   
>   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>   
>   static inline void kvm_resample_fd_remove(int gsi)
>   {
> @@ -314,14 +315,53 @@ err:
>       return ret;
>   }
>   
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    struct KVMParkedVcpu *vcpu;
> +
> +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
It's good if we add kvm_fd to trace.
It will be useful to cross verify kvm_get_vcpu()'s kvm_fd with parked vcpu.
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
> +    KVMState *s = kvm_state;
> +    int kvm_fd;
> +
> +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
vcpu_id can be used instead of kvm_arch_vcpu_id(cpu).
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
> +    if (kvm_fd < 0) {
> +        /* vCPU not parked: create a new KVM vCPU */
> +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> +        if (kvm_fd < 0) {
> +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    cpu->kvm_fd = kvm_fd;
> +    cpu->kvm_state = s;
> +    cpu->vcpu_dirty = true;
> +    cpu->dirty_pages = 0;
> +    cpu->throttle_us_per_full = 0;
> +
> +    return 0;
> +}
> +
>   static int do_kvm_destroy_vcpu(CPUState *cpu)
>   {
>       KVMState *s = kvm_state;
>       long mmap_size;
> -    struct KVMParkedVcpu *vcpu = NULL;
>       int ret = 0;
>   
> -    trace_kvm_destroy_vcpu();
> +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
>       ret = kvm_arch_destroy_vcpu(cpu);
>       if (ret < 0) {
> @@ -347,10 +387,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           }
>       }
>   
> -    vcpu = g_malloc0(sizeof(*vcpu));
> -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> -    vcpu->kvm_fd = cpu->kvm_fd;
> -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +    kvm_park_vcpu(cpu);
>   err:
>       return ret;
>   }
> @@ -371,6 +408,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>           if (cpu->vcpu_id == vcpu_id) {
>               int kvm_fd;
>   
> +            trace_kvm_get_vcpu(vcpu_id);
It's good if we add kvm_fd to trace.
It will be useful to cross verify kvm_get_vcpu's kvm_fd with parked vcpu.
> +
>               QLIST_REMOVE(cpu, node);
>               kvm_fd = cpu->kvm_fd;
>               g_free(cpu);
> @@ -378,7 +417,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>           }
>       }
>   
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    return -ENOENT;
>   }
>   
>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
> @@ -389,19 +428,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   
>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
> -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    ret = kvm_create_vcpu(cpu);
>       if (ret < 0) {
> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>                            kvm_arch_vcpu_id(cpu));
>           goto err;
>       }
>   
> -    cpu->kvm_fd = ret;
> -    cpu->kvm_state = s;
> -    cpu->vcpu_dirty = true;
> -    cpu->dirty_pages = 0;
> -    cpu->throttle_us_per_full = 0;
> -
>       mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>       if (mmap_size < 0) {
>           ret = mmap_size;
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index a25902597b..5558cff0dc 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>   kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>   kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>   kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_get_vcpu(unsigned long arch_cpu_id) "id: %lu"
> +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>   kvm_irqchip_commit_routes(void) ""
>   kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>   kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
> @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>   kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
>   kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>   kvm_dirty_ring_flush(int finished) "%d"
> -kvm_destroy_vcpu(void) ""
>   kvm_failed_get_vcpu_mmap_size(void) ""
>   kvm_cpu_exec(void) ""
>   kvm_interrupt_exit_request(void) ""
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index fad9a7e8ff..2ed928aa71 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -435,6 +435,22 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
>   
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
> +
> +/**
> + * kvm_park_vcpu - Park QEMU KVM vCPU context
> + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
> + *
> + * @returns: none
> + */
> +void kvm_park_vcpu(CPUState *cpu);
> +
>   #endif /* NEED_CPU_H */
>   
>   void kvm_cpu_synchronize_state(CPUState *cpu);

Otherwise, Looks good to me.  Feel free to add
Reviewed-by: "Vishnu Pajjuri" <vishnu@os.amperecomputing.com>

_Thanks_,

-Vishnu

--------------kBel8wbk5Cyo6NpiUIMpNbx5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Salil,<br>
    </p>
    <div class="moz-cite-prefix">On 12-03-2024 07:29, Salil Mehta wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240312020000.12992-2-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
is spawned. This is common to all the architectures as of now.

Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
support vCPU removal. Therefore, its representative KVM vCPU object/context in
Qemu is parked.

Refactor architecture common logic so that some APIs could be reused by vCPU
Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
with trace events instead of DPRINTF. No functional change is intended here.

Signed-off-by: Salil Mehta <a class="moz-txt-link-rfc2396E" href="mailto:salil.mehta@huawei.com">&lt;salil.mehta@huawei.com&gt;</a>
Reviewed-by: Gavin Shan <a class="moz-txt-link-rfc2396E" href="mailto:gshan@redhat.com">&lt;gshan@redhat.com&gt;</a>
Tested-by: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a>
Reviewed-by: Jonathan Cameron <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Cameron@huawei.com">&lt;Jonathan.Cameron@huawei.com&gt;</a>
Tested-by: Xianglai Li <a class="moz-txt-link-rfc2396E" href="mailto:lixianglai@loongson.cn">&lt;lixianglai@loongson.cn&gt;</a>
Tested-by: Miguel Luis <a class="moz-txt-link-rfc2396E" href="mailto:miguel.luis@oracle.com">&lt;miguel.luis@oracle.com&gt;</a>
Reviewed-by: Shaoqin Huang <a class="moz-txt-link-rfc2396E" href="mailto:shahuang@redhat.com">&lt;shahuang@redhat.com&gt;</a>
---
 accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
 accel/kvm/trace-events |  5 +++-
 include/sysemu/kvm.h   | 16 +++++++++++
 3 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a8cecd040e..3bc3207bda 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -126,6 +126,7 @@ static QemuMutex kml_slots_lock;
 #define kvm_slots_unlock()  qemu_mutex_unlock(&amp;kml_slots_lock)
 
 static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
+static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
 
 static inline void kvm_resample_fd_remove(int gsi)
 {
@@ -314,14 +315,53 @@ err:
     return ret;
 }
 
+void kvm_park_vcpu(CPUState *cpu)
+{
+    struct KVMParkedVcpu *vcpu;
+
+    trace_kvm_park_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));</pre>
    </blockquote>
    It's good if we add kvm_fd to trace.<br>
    It will be useful to cross verify kvm_get_vcpu()'s kvm_fd with
    parked vcpu.<br>
    <blockquote type="cite" cite="mid:20240312020000.12992-2-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
+
+    vcpu = g_malloc0(sizeof(*vcpu));
+    vcpu-&gt;vcpu_id = kvm_arch_vcpu_id(cpu);
+    vcpu-&gt;kvm_fd = cpu-&gt;kvm_fd;
+    QLIST_INSERT_HEAD(&amp;kvm_state-&gt;kvm_parked_vcpus, vcpu, node);
+}
+
+int kvm_create_vcpu(CPUState *cpu)
+{
+    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
+    KVMState *s = kvm_state;
+    int kvm_fd;
+
+    trace_kvm_create_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));</pre>
    </blockquote>
    vcpu_id can be used instead of kvm_arch_vcpu_id(cpu).<br>
    <blockquote type="cite" cite="mid:20240312020000.12992-2-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
+
+    /* check if the KVM vCPU already exist but is parked */
+    kvm_fd = kvm_get_vcpu(s, vcpu_id);
+    if (kvm_fd &lt; 0) {
+        /* vCPU not parked: create a new KVM vCPU */
+        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
+        if (kvm_fd &lt; 0) {
+            error_report(&quot;KVM_CREATE_VCPU IOCTL failed for vCPU %lu&quot;, vcpu_id);
+            return kvm_fd;
+        }
+    }
+
+    cpu-&gt;kvm_fd = kvm_fd;
+    cpu-&gt;kvm_state = s;
+    cpu-&gt;vcpu_dirty = true;
+    cpu-&gt;dirty_pages = 0;
+    cpu-&gt;throttle_us_per_full = 0;
+
+    return 0;
+}
+
 static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
     long mmap_size;
-    struct KVMParkedVcpu *vcpu = NULL;
     int ret = 0;
 
-    trace_kvm_destroy_vcpu();
+    trace_kvm_destroy_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));
 
     ret = kvm_arch_destroy_vcpu(cpu);
     if (ret &lt; 0) {
@@ -347,10 +387,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         }
     }
 
-    vcpu = g_malloc0(sizeof(*vcpu));
-    vcpu-&gt;vcpu_id = kvm_arch_vcpu_id(cpu);
-    vcpu-&gt;kvm_fd = cpu-&gt;kvm_fd;
-    QLIST_INSERT_HEAD(&amp;kvm_state-&gt;kvm_parked_vcpus, vcpu, node);
+    kvm_park_vcpu(cpu);
 err:
     return ret;
 }
@@ -371,6 +408,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
         if (cpu-&gt;vcpu_id == vcpu_id) {
             int kvm_fd;
 
+            trace_kvm_get_vcpu(vcpu_id);</pre>
    </blockquote>
    It's good if we add kvm_fd to trace.<br>
    It will be useful to cross verify kvm_get_vcpu's kvm_fd with parked
    vcpu.<br>
    <blockquote type="cite" cite="mid:20240312020000.12992-2-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
+
             QLIST_REMOVE(cpu, node);
             kvm_fd = cpu-&gt;kvm_fd;
             g_free(cpu);
@@ -378,7 +417,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
         }
     }
 
-    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
+    return -ENOENT;
 }
 
 int kvm_init_vcpu(CPUState *cpu, Error **errp)
@@ -389,19 +428,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
 
     trace_kvm_init_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));
 
-    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
+    ret = kvm_create_vcpu(cpu);
     if (ret &lt; 0) {
-        error_setg_errno(errp, -ret, &quot;kvm_init_vcpu: kvm_get_vcpu failed (%lu)&quot;,
+        error_setg_errno(errp, -ret,
+                         &quot;kvm_init_vcpu: kvm_create_vcpu failed (%lu)&quot;,
                          kvm_arch_vcpu_id(cpu));
         goto err;
     }
 
-    cpu-&gt;kvm_fd = ret;
-    cpu-&gt;kvm_state = s;
-    cpu-&gt;vcpu_dirty = true;
-    cpu-&gt;dirty_pages = 0;
-    cpu-&gt;throttle_us_per_full = 0;
-
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size &lt; 0) {
         ret = mmap_size;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index a25902597b..5558cff0dc 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) &quot;dev fd %d, type 0x%x, arg %p&quot;
 kvm_failed_reg_get(uint64_t id, const char *msg) &quot;Warning: Unable to retrieve ONEREG %&quot; PRIu64 &quot; from KVM: %s&quot;
 kvm_failed_reg_set(uint64_t id, const char *msg) &quot;Warning: Unable to set ONEREG %&quot; PRIu64 &quot; to KVM: %s&quot;
 kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
+kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
+kvm_get_vcpu(unsigned long arch_cpu_id) &quot;id: %lu&quot;
+kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
+kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
 kvm_irqchip_commit_routes(void) &quot;&quot;
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) &quot;dev %s vector %d virq %d&quot;
 kvm_irqchip_update_msi_route(int virq) &quot;Updating MSI route virq=%d&quot;
@@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) &quot;%s&quot;
 kvm_dirty_ring_reap(uint64_t count, int64_t t) &quot;reaped %&quot;PRIu64&quot; pages (took %&quot;PRIi64&quot; us)&quot;
 kvm_dirty_ring_reaper_kick(const char *reason) &quot;%s&quot;
 kvm_dirty_ring_flush(int finished) &quot;%d&quot;
-kvm_destroy_vcpu(void) &quot;&quot;
 kvm_failed_get_vcpu_mmap_size(void) &quot;&quot;
 kvm_cpu_exec(void) &quot;&quot;
 kvm_interrupt_exit_request(void) &quot;&quot;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fad9a7e8ff..2ed928aa71 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -435,6 +435,22 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
                                        hwaddr *phys_addr);
 
+/**
+ * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
+ *
+ * @returns: 0 when success, errno (&lt;0) when failed.
+ */
+int kvm_create_vcpu(CPUState *cpu);
+
+/**
+ * kvm_park_vcpu - Park QEMU KVM vCPU context
+ * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
+ *
+ * @returns: none
+ */
+void kvm_park_vcpu(CPUState *cpu);
+
 #endif /* NEED_CPU_H */
 
 void kvm_cpu_synchronize_state(CPUState *cpu);</pre>
    </blockquote>
    <p>Otherwise, Looks good to me.&nbsp; Feel free to add<br>
      Reviewed-by: &quot;Vishnu Pajjuri&quot;
      <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a><br>
    </p>
    <p><u>Thanks</u>,</p>
    <p>-Vishnu<br>
    </p>
    <blockquote type="cite" cite="mid:20240312020000.12992-2-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------kBel8wbk5Cyo6NpiUIMpNbx5--

