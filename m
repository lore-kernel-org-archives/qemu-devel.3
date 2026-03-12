Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC861106ACF0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0oUc-0004S1-Iv; Thu, 12 Mar 2026 18:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1w0nyB-0007fw-3r
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:53:27 -0400
Received: from mail-westus3azon11012010.outbound.protection.outlook.com
 ([40.107.209.10] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1w0ny5-0003VD-RJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:53:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URcHVROojwuSlyglQSSxDNz31cO+or4COyBi3TeV/HfWrPyZ10D3IjNjZoOpb4Y1QtQKjrQ1BhJF8TFyhLNe1PHO/Kx2+KhpaGp5NzvS/N8oCuB0PNMCbB3pYu9ZRdOlmm4hmnw7X3E0i3ERSawi7tEDYCCTiNRlmpp+1udE+W7xfKID5fb8ugoAfJxh1UsLMpnt4xdSST2CtxRzBn4jx38YZVamFYjfXHwVGz9USN8TJkc1EdjDO7Zvo6gkGtWrLImiYWFTOZg04jVo1hQcq22YtnUgnKMLkW5CwOR/T35w8tANlHJu0Q7t1eSRG4c7PI8djrZyfPw6QCPgXFTfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULfRo/lFx9EYCPAAO+YjYVsWbqjeBoaC3L0R5vDLNJw=;
 b=PJbrnozmtKAUUoQdP5Yo4fa0wRy2bbeXUhuFDfy06GG9D2lEySiERc+a69F/KMyt8IiNfQGTQcIkp6WgokLgZlOZYeI5f0uuelFRracBX6dZQ7FSm/5qYBRa0XiazoPD9DUdJUk9GYZxuaeTn1HNVs/WcAOai0HKvXwnL6MKK1KEpQT61zHLhoTB6vbKHq39SU3BlncJsDqp7ZK6R+TbCvmaP60acPNO1BaZ5NqAi9h1T3AWjvNfmwX/TzQ/Xn2agrVQsOvuQYKq+Pk0m1Y9b8u5ExmMm9B6y87BiMI6f06BvUe4A18Zp7galGO3syOJVK8K6S9Z9DKVsWRde6vC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULfRo/lFx9EYCPAAO+YjYVsWbqjeBoaC3L0R5vDLNJw=;
 b=0QuP/vOJHLVdpZw5zvncwa4H64LuAaWNe4A8r23NJ/l7uiwhfEdw4DIDNPzzYyPI1n0Om6Ep2sGSzFjSnLwKsGYy8y2A9aMHdkWOD2hyOWB3HBnoXFrJziIf0EId/ure+bpwsaa17CMzN6hgL7umsqSZ2vKRCBey0gvItz/rDsg=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:48:12 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::86) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Thu,
 12 Mar 2026 21:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 21:48:11 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 16:48:11 -0500
Message-ID: <df63fdf0-05ea-4de0-8009-c52703e4b052@amd.com>
Date: Thu, 12 Mar 2026 16:48:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/18] memory: Factor out common ram region initialization
To: Peter Xu <peterx@redhat.com>, <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Michael Roth
 <michael.roth@amd.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
 <20260309204007.1709441-9-peterx@redhat.com>
From: Kim Phillips <kim.phillips@amd.com>
Content-Language: en-US
In-Reply-To: <20260309204007.1709441-9-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 7252d9d5-a2a7-4637-8e9f-08de80810eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: cevEWsythAKcBDQQ2R6vNfPtGbBejcFkDD0AvorzWzbGmuMF12MSkL5kcz6SKS/NMGYC+oZYjJ+HpHjVJTk2/gIA/PWnILLGmsGW0+iWj1QpJhqV9BJONrI39Mw1d/wysAH7MQAweYuhFRq8uo96prKGam+6zio9yBmfy4NRjjdAhlAG4mkQA6P3LLIHaxX5CUz+Sros7O+Ikh3GCxQTuVpLek58UnlXjnqsmsVdS/vASvkTdJfd94hT1IVKHAJNhGwzFXWJGI4SvbEwbC9VOBI1s0rS3pxDtZlo4Thfn6iBxPs2ehvinI6kvfVHAvBVz6RTp9eVRXLkURCwk00IHlzPCVeS6wQokSAoUgjguzdkqSikvP+q4l7tnTGt0to35a5EmizJCetGrPsE2Fd86aljF67XugbHg8+9qn1Z8hw/C/yPlD3VbEqY41Pm1lGEraMBOBTRgbraViM1nNnknWmvXDIIyzKgnwNAhFn5wG5yPu8FtcNzelHPfGoxcIyl8ZwmGyhxL0AAfqWZE1yacNFEmbMStlSQ3BXBrZNQULlgFxWdwV+9v+nu2PIrutAtkQV/ll7CzoXNMKxirV2cNWworv0l7aekqFPMDVMsC0Gcj9AIUw2ClXKVGCl4XDewrzQR+WcXUX36d+RoPGdLokIQu610prMUeRb4aZPljLZlBVkeOJA/3I4Jpdo+SiSZ9bs/5NS5Bm5xQemC1bCErf2QCbnlgJgyPCADdmWZmLeMOcp4hr3Zi/9/YfAY5Up54oIfv0SLx8clFKP9nTaUfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JonS1TSG2PCL15lnaqZbERzN4Z3Yd+1exRWTPwsMtfjt37wsljbIhLt+pDYREy3VCrB1B/LQMLcil/9hK7tHafQ+Au2BcYqJ6/ODqwLmmL6uNfp0XSy2XEtfDkx8modpXJkySFt86wkNV5OrcHg143011C42A7oRrNORlshfRE28VQ/aorNsLRAX+6s75rccs0vH4daPJdI3zOfJijqhyK3mMP80LRfr8K4PiWXb8QrusBRfTPHnDEBZxo8vvny5rSFKQMT6HIacPOOnLmpDPNTzagNTxTgerXZctIttVnm8l8ba3DFAa57A3dbNXz+fIVvpqkgqIgI+kNQ1Bd1EraRnWIVmEyHU1GXTQDoAmPlmAXQkArZNkDAe8WXsYSd2GA8r+L+WD0slbnrMYTy1Wa9tTvhvaVDO3v/lvznNVXuBQ8QX31iVkoJdOXYPGieE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:48:11.8348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7252d9d5-a2a7-4637-8e9f-08de80810eba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
Received-SPF: permerror client-ip=40.107.209.10;
 envelope-from=kim.phillips@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Mar 2026 18:26:55 -0400
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

On 3/9/26 3:39 PM, Peter Xu wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> Introduce internal helper function to remove duplicated code from
> different memory_region_init_*ram functions. Remove local err and
> error_propagate and pass errp and check return value instead.
> Also shorten some function prototypes while at it.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Link: https://lore.kernel.org/r/d6db01c283149b46023ffeb9c5b368c67f6acc8d.1772924151.git.balaton@eik.bme.hu
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Hi, I bisected master (fff352b9b6) to this patch as the first bad commit 
that results in this very early qemu error:

ERROR:../system/memory.c:2042:memory_region_set_ram_discard_manager: 
assertion failed: (memory_region_is_ram(mr))

It's pointing to this line of code:

int memory_region_set_ram_discard_manager(MemoryRegion *mr,
                                           RamDiscardManager *rdm)
{
     g_assert(memory_region_is_ram(mr));   <<<<<

Qemu then bails out. The command line is:

sudo /usr/bin/qemu-system-x86_64 -enable-kvm \
  -drive 
file=/home/amd/ubuntu-22.04-server-cloudimg-amd64-kim.qcow2,if=none,id=disk0,format=qcow2 
\
  -device virtio-scsi-pci,id=scsi0,disable-legacy=on,iommu_platform=true \
  -device scsi-hd,drive=disk0 \
  -cpu EPYC-v4 \
  -bios /home/amd/OVMF.fd \
  -machine memory-encryption=sev0,vmport=off \
  -object memory-backend-memfd,id=ram1,size=8G,share=true,prealloc=false \
  -machine memory-backend=ram1  \
  -object 
sev-snp-guest,id=sev0,policy=0xb0000,cbitpos=51,reduced-phys-bits=1 \
  -monitor unix:qemu-monitor-socket,server,nowait \
  -smp 2 -m 8G -nographic -s \
  --kernel /home/amd/git/linux/arch/x86/boot/bzImage \
  --append "verbose debug console=ttyS0,115200n8 
earlyprintk=ttyS0,115200 log_level=8 keep_bootcon root=/dev/sda1" \
  --initrd /boot/initrd.img \
  -no-reboot

The host (& guest) kernel version is a vanilla v6.19, with an Ubuntu 
based config.

Let me know if there's something you'd like me to test on my AMD EPYC 
system.
AFAICT, it fails on all Zens that support SEV-SNP (Zen3+).

Thanks,

Kim

>   system/memory.c | 167 ++++++++++++++++++------------------------------
>   1 file changed, 61 insertions(+), 106 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 9a12224555..2cda814bd6 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1568,39 +1568,39 @@ static void memory_region_set_ops(MemoryRegion *mr,
>       mr->terminates = true;
>   }
>   
> -void memory_region_init_io(MemoryRegion *mr,
> -                           Object *owner,
> -                           const MemoryRegionOps *ops,
> -                           void *opaque,
> -                           const char *name,
> -                           uint64_t size)
> +void memory_region_init_io(MemoryRegion *mr, Object *owner,
> +                           const MemoryRegionOps *ops, void *opaque,
> +                           const char *name, uint64_t size)
>   {
>       memory_region_init(mr, owner, name, size);
>       memory_region_set_ops(mr, ops, opaque);
>   }
>   
> -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
> -                                            Object *owner,
> -                                            const char *name,
> -                                            uint64_t size,
> -                                            uint32_t ram_flags,
> -                                            Error **errp)
> +static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
>   {
> -    Error *err = NULL;
> -    memory_region_init(mr, owner, name, size);
>       mr->ram = true;
>       mr->terminates = true;
>       mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
> -    if (err) {
> +    mr->ram_block = rb;
> +    if (!rb) {
>           mr->size = int128_zero();
>           object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
>           return false;
>       }
>       return true;
>   }
>   
> +bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
> +                                            const char *name, uint64_t size,
> +                                            uint32_t ram_flags, Error **errp)
> +{
> +    RAMBlock *rb;
> +
> +    memory_region_init(mr, owner, name, size);
> +    rb = qemu_ram_alloc(size, ram_flags, mr, errp);
> +    return memory_region_set_ram_block(mr, rb);
> +}
> +
>   bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                          Object *owner,
>                                          const char *name,
> @@ -1611,116 +1611,74 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                                          void *host),
>                                          Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb;
> +
>       memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
> -                                              mr, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> -    }
> -    return true;
> +    rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
> +    return memory_region_set_ram_block(mr, rb);
>   }
>   
>   #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
> -bool memory_region_init_ram_from_file(MemoryRegion *mr,
> -                                      Object *owner,
> -                                      const char *name,
> -                                      uint64_t size,
> -                                      uint64_t align,
> -                                      uint32_t ram_flags,
> -                                      const char *path,
> -                                      ram_addr_t offset,
> +bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
> +                                      const char *name, uint64_t size,
> +                                      uint64_t align, uint32_t ram_flags,
> +                                      const char *path, ram_addr_t offset,
>                                         Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb;
> +
>       memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
>       mr->readonly = !!(ram_flags & RAM_READONLY);
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
>       mr->align = align;
> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
> -                                             offset, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> -    }
> -    return true;
> +    rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, errp);
> +    return memory_region_set_ram_block(mr, rb);
>   }
>   
> -bool memory_region_init_ram_from_fd(MemoryRegion *mr,
> -                                    Object *owner,
> -                                    const char *name,
> -                                    uint64_t size,
> -                                    uint32_t ram_flags,
> -                                    int fd,
> -                                    ram_addr_t offset,
> -                                    Error **errp)
> +bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
> +                                    const char *name, uint64_t size,
> +                                    uint32_t ram_flags, int fd,
> +                                    ram_addr_t offset, Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb;
> +
>       memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
>       mr->readonly = !!(ram_flags & RAM_READONLY);
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
> -                                           offset, false, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> -    }
> -    return true;
> +    rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
> +                                false, errp);
> +    return memory_region_set_ram_block(mr, rb);
>   }
>   #endif
>   
> -void memory_region_init_ram_ptr(MemoryRegion *mr,
> -                                Object *owner,
> -                                const char *name,
> -                                uint64_t size,
> +void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
> +                                const char *name, uint64_t size,
>                                   void *ptr)
>   {
> -    memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
> +    RAMBlock *rb;
>   
> +    memory_region_init(mr, owner, name, size);
>       /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
>       assert(ptr != NULL);
> -    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +    memory_region_set_ram_block(mr, rb);
>   }
>   
> -void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> -                                       Object *owner,
> -                                       const char *name,
> -                                       uint64_t size,
> +void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
> +                                       const char *name, uint64_t size,
>                                          void *ptr)
>   {
> +    RAMBlock *rb;
> +
>       memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
> -    mr->ram = true;
>       mr->ram_device = true;
> -    mr->destructor = memory_region_destructor_ram;
> -
>       /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
>       assert(ptr != NULL);
> -    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +    memory_region_set_ram_block(mr, rb);
>   }
>   
> -void memory_region_init_alias(MemoryRegion *mr,
> -                              Object *owner,
> -                              const char *name,
> -                              MemoryRegion *orig,
> -                              hwaddr offset,
> -                              uint64_t size)
> +void memory_region_init_alias(MemoryRegion *mr, Object *owner,
> +                              const char *name, MemoryRegion *orig,
> +                              hwaddr offset, uint64_t size)
>   {
>       memory_region_init(mr, owner, name, size);
>       mr->alias = orig;
> @@ -3732,21 +3690,18 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
>                                      const char *name, uint64_t size,
>                                      Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb;
>   
>       assert(ops);
>       memory_region_init_io(mr, owner, ops, opaque, name, size);
> -    mr->rom_device = true;
> -    mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> +    rb = qemu_ram_alloc(size, 0, mr, errp);
> +    if (memory_region_set_ram_block(mr, rb)) {
> +        mr->ram = false;
> +        mr->rom_device = true;
> +        memory_region_register_ram(mr, owner);
> +        return true;
>       }
> -    memory_region_register_ram(mr, owner);
> -    return true;
> +    return false;
>   }
>   
>   /*


