Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44CBCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvWl-0002ob-Hv; Mon, 18 May 2026 06:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wOvWb-0002kX-Bz
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:48:45 -0400
Received: from mail-southcentralusazon11011069.outbound.protection.outlook.com
 ([40.93.194.69] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wOvWV-0007vQ-Kx
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYPDZnm55onHsEHMwVhoMDX8lfqCXtoNSkeTL99qp3SGasym4fvAO61HqVPrCR+Ei4PuNDKv11M/OH5mQJDehEC0yK1WC+vmOBtX2Vder+411Ev6gmFy+XuU/625G7pqtCjJ3u/OfWvq1Rxs5aBtrbM550MNeCMnLTx/ru9fCdyatsIhJX4B6DSbNKB9LcQ0hqgl9dOhQMWPARuJwPjP5lsxjUPT0wRdDF6GEosXp5dT6dKA+OCAb1HiiNGk1VEGwnmMB1Wi6Yd7N9VteKpl1tM3Xno8GsPTlr2C954/xJvwXrBOZUWBw9tv8KytrYHpt80XkTQrm8fiszONUW0M1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/HOGg1DFfvIPsqMdLqfuqXCZbA72+6217MiIrWWqRA=;
 b=h+UnrYlYvVDzTiBll+SeXBW+eGbj9SfOwnXTP0kF1fIK3+94feJhCmE5U/0TVUFhjQ4FGqm6sMZrCcl6KxaIjYhsf9kitztHNqY/zfLaXRU3E3hQfjHKBXSBofqt8KS856//z2YkumymMN+mPwlnGxZPADYUwOFVxUlWPAvQHZrjr9JHWhkbkfXHfvOeBYm7eEYPyX1XXQ5LoWS+FY3ucbDD7jH1fTzOtotMN3+yCj2XcrbYx+m3w0pJ+qNK5clAhb+ja/cZc/qlPohxR1BDvGmCk4j9PwXe21oUIp7MG5uEGkIu8DxFhFmJnA/ocJ5yDrQQpbZlvui6Oz1/2x0Big==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/HOGg1DFfvIPsqMdLqfuqXCZbA72+6217MiIrWWqRA=;
 b=fKij7lYzx5T/Dg0qAoXwdFd87zE9ke2NYZs7B+M7GtmgTefpN16nDwSTOvxkPck2FKyGtCAR6+/KTKk1IFF6qg0Xabr5SgMQy+imoLsh8qY5FL9whIvVQ8H2zBxPrKNBY2P8VFaIU404H4mXty0UZR88GUBoV2XF8OS7HFbRstw=
Received: from SA9PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:21::21)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 10:43:19 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::29) by SA9PR13CA0016.outlook.office365.com
 (2603:10b6:806:21::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 10:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 10:43:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 05:43:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 05:43:18 -0500
Received: from [10.65.99.36] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 18 May 2026 05:43:16 -0500
Message-ID: <4a3de73b-03bd-446e-8cbd-dedd5323e295@amd.com>
Date: Mon, 18 May 2026 18:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <gourry@gourry.net>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 David Hildenbrand <david@kernel.org>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
 <20260514150559.3148f9dc@imammedo>
 <d26cfb4b-d70e-415c-8747-904d94f8ccb2@amd.com>
 <20260515150453.409e0e3e@imammedo>
In-Reply-To: <20260515150453.409e0e3e@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bf5ec3-14fd-420e-1f52-08deb4ca4681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: osrVtlkyBNxRQGE7U6WiN4+P5t7ZXtJ0hqlGe50qZm9ZyDXyqO3yR0rzmxo5jZYiM0OF4K5cEMjp9ETMYxY/TUwTlLBeP5MyUiENFnkkhsDmiyXBL9gZNX9pASBypunAtyLbeKXiB/hulFk+MrOe5r2vYsM1RuRakqbifsGjUVtYfDnSDNA9KWU1+O4+mzZnO2zVRJExjbV6O7KgPZpUY/blBnWko+1zhUo2paylEhsmnx93h5pEwZg+fJ8DsbSHv972B71zGHjQOPo2GTPs10QOzfLEYHFkC4RSdZ4wLibKWpnbDNzxmKpKeTrSk2ndWdzlkWs6DsCm8aAGSMk48Zz/gFl+Y2Jhjxb7k/yTUaPdPH2PFhA3ebCanxLHhs7m5IOIZM13rF2Pi63XhbSqOmdCcfLr0n62eI+K/5lfFDrvLSzBp3+z5IXgabt7ZuK6bJc9plMiBOLtx9iWnijxwFegDY515QRiDzLYmNLdGR+jCLcKI1ceYyPUNapvP4ZMdCnx3DFsKB8x+PQ5wXQNZzQO4PGXgzHpaOhREyZ+WJ9U/L/aO1Myamso2xslOr0Yfcti4txidfNru3GlOZnlQifN5bK5yRXtCVdXMNx0wgBtLDI5qIkzYKsLABqgDNDuoCuDy+5GU0yfqyak8ZS5g6+ZPuS/NJL6shZ1O4qRjpZDGV8yvpLNhROYYEQ8MqG+64apBnAqgvBbgbDS4Zc/Ajr1LGqshZenoUR8WQQjIoI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W2pJU9MgpmTCsW/wQYikNn4ftbj53+eXOV6RFMaEF+slN1as/Uk3fYhaxWgNP6t6xdhmzNS4V7OCkHGO1f3TG3rFZTNqMt1fG7AkdJqklxLyKUrR+HTvbILWQ0vkL/2DNOBoKGjOxdw+ncyTd44w1kIqu59ut8Di9qTV7rBzjPufo/AWilhhiuL5LHj0XDb8TgDqeiFezzoSn+NVTA/tL8yDL3jKzPGg8HaLsxjo+yqpUN2tQ4bMkopYd8c0BN/e8x2PZebsqaEiENCYEyPnsLKHsQSVOxJ5zy22BgcsO7jcFQ3qigSaHQmP54+/WHQp5lbBZre/WGz8lftr8F/KpsnNA+yvEQq5dXjkEop3Cf2B3upI3u+0REP7PMiy6nq0Lqbiw63biW/MvB8dGdr7ZHyC3JRi7g1/3RZpnU4gKiff05juNVdwxRL7EBxybaCx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:43:19.1841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bf5ec3-14fd-420e-1f52-08deb4ca4681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
Received-SPF: permerror client-ip=40.93.194.69;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Igor,

Thanks again for the careful read.

On 5/15/2026 9:04 PM, Igor Mammedov wrote:
> On Fri, 15 May 2026 15:53:07 +0800
> "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote:
> 
>> On 5/14/2026 9:05 PM, Igor Mammedov wrote: 
>>
>> Hi Igor,
>>
>> Thanks for taking the time to review this -- and for the candor in
>> the bashing chapter.  Before going into the bigger picture, let me
>> re-establish one factual point that v7 didn't carry forward from
>> the v6 cover letter.
> 
> feel free to bash my review as well, I hope that we end up with
> clear picture what and why we are doing.
> 
Let me take your points in order: first the bigger-picture context
you asked for (which I'll also put in v8's commit message), then
the dax/kmem compatibility state, the prior thread on this CLI
shape, and where this could go longer-term.

> 
> bigger picture should be somewhere in commit message so later on
> a reader could understand why we are doing it at all/this way.
>   
> lets continue with questions wrt impl.
> 
Agreed, v8 will carry a condensed version of the bigger picture
in the commit message body.  Setting the architectural context
out in full here first -- the rest of the reply depends on it.

(1) The architectural context: HBM is system memory in this class
of systems

This patch targets coherent CPU+accelerator shared-address-space
systems, where the accelerator's high-bandwidth memory is no
longer a device-private framebuffer behind a PCIe BAR.  It lives
in the host physical address space -- visible to the CPU as
system memory (not as device MMIO) and shared coherently with
the accelerator over the platform fabric.  Both sides must keep
consistent views of those pages or the coherent contract breaks.

>> The use case is GPU/accelerator HBM exposed to the OS as SPM.  On
>> bare metal, the platform firmware:
>>
>>     - emits E820 type 0xEFFFFFFF (SOFT_RESERVED) for the HBM region;
>>     - emits ACPI SRAT memory affinity entries that bind HBM to a
>>       dedicated proximity domain (NUMA node);
>>     - tags the accelerator's PCI device with _PXM matching that node.
>>
>> That gives the device driver a stable lookup chain at runtime:
>>
>>       dev -> pci_dev_to_node(dev) -> SRAT walk -> HBM GPA range
> 
> it looks kind of convoluted, isn't it.
> PCI devices were supposed to be self describing/discoverable.
> Preferably without above mentioned firmware 'hooks'.
> Above example could be just early impl. issues, rather than by
> design issue.
> 
>> NUMA node here is not incidental -- it is the OS-exposed
>> intermediary ID that the device driver uses to find its own HBM.
>> This is the in-tree path used by accelerator drivers today.
> 
> I'm assuming GPU is exposed as some composite PCI/CXL device.
> and use-case is its pass-through to guest.
> 
> Perhaps we can't do anything about it now.
> But shouldn't device driver discover its own memory (HBM and what not)
> without external parties that magically gain knowledge about parts of
> device that driver supposedly driving the device has not a clue about?
> How doesn bios know about SPM when device's driver with knowledge of
> device internals knows nothing about?
>   
To be blunt about it: in this architecture, "the device alone
knows where its own memory is" doesn't apply.  The accelerator
package knows it has HBM and how much, but the GPA it's mapped to
is set by platform firmware during boot fabric training, in
coordination with the CPU host bridge and the fabric coherency
hardware.  Firmware "knows the GPA" because firmware authored
that binding, not because some external party magically learned
the device's internals; every party including the driver has to
conform to it.

That makes the OS-level requirement twofold: the memory has to be
visible in the system memory map (so the CPU side can address it)
and reserved exclusively for the accelerator's driver (so the
general allocator doesn't hand HBM pages to random workloads).
The SP marking therefore has to reach the CPU memory subsystem,
not just the driver.  EFI_MEMORY_SP / E820 SOFT_RESERVED + SRAT
memory-affinity is the mechanism that fits this: a system-level,
firmware-produced topology that the CPU memory subsystem honors
and that the accelerator's driver consumes to discover and
manage its HBM range.  Any path that emits only an ACPI namespace
node, without E820 SOFT_RESERVED, leaves the CPU memory subsystem
without that signal and the contract breaks; any path that does
also emit E820 SOFT_RESERVED restores it.

>> The "-numa node + memmap-type=spm + E820 SOFT_RESERVED" combo in
>> v7 is a direct 1:1 model of this BM topology.  The E820 retyping
>> in the patch is exactly what makes the guest-visible E820 match
>> what BM firmware emits for the same kind of region.
>>
>> On the DIMM / device-memory alternative:
> 
> wrt modeling GPU pass-through, my 1st attempt would be
> to make -device gpu-foo take everything need to compose the device
> (like in real hw) and be done with it (and PCI/CXL machinery would
> take care of mapping/exposing memory to guest).
> Why we aren't doing it?
> 
> barring that, and assuming we have to pass SPM as a separate memory
> (why and why it should be exposed in E820 and at boot time only?)
> I'd try -device foo-memory approach.
> 
So this isn't HBM-as-VRAM, the device-private framebuffer model
from discrete GPUs.  It's HBM as a system memory tier under
driver-owned allocation policy, and -numa node + memmap-type=spm
is the direct expression of that, not a workaround layered on top.

(2) v7 is naturally compatible with stock upstream Linux dax/kmem

v7 emits E820 SOFT_RESERVED via existing machine-init, into the
same fw_cfg blob the firmware and the guest kernel already
consume.  The upstream kernel already understands this signal --
dax/kmem is one such consumer in tree, picking the region up via
the IORES_DESC_SOFT_RESERVED hook in drivers/dax/hmem/device.c.
The accelerator's own driver discovers its HBM range from the
same E820 + SRAT entries via dev_to_node + SRAT walk.  Neither
side needs new code for v7.

For a memory-device-derived spm-memory device to reach the same
dax/kmem path, it would have to inject E820 SOFT_RESERVED from
its realize() -- which is new plumbing inside the device_memory
subsystem.

That also bears on two of your other points:
> And no need for messing with firmware (SeaBIOS: RamSizeOver4G
> patch) nor EDK2.

That holds only for the path where the driver doesn't go through
E820 SOFT_RESERVED at all -- but that path needs the in-tree
accelerator driver rewritten to walk ACPI namespace instead of
SRAT, plus a kernel-side patch to wire ACPI memory device
descriptors into dax/kmem.  For the e820+SRAT fallback path you
describe as Step 3, the firmware-side requirement is identical to
v7.

> figure out why device driver has to fetch memory map
> and proximity from static tables as opposed to getting it dynamically
> from _PXM -> maped-memory range. (at the time PCI devices enum runs, 
 > all ACPI
> info incl. run time one is fully accessible to in-kernel users)
> i.e. try to make driver work with runtime proximity

The current amdgpu lookup is already a runtime, PXM-keyed dynamic
lookup -- dev_to_node(pdev) evaluates _PXM on the PCI device,
then a SRAT memory-affinity walk matches by proximity_domain.
PXM is the matching key; SRAT is the storage venue.  What you're
suggesting is moving the (PXM -> range) mapping from a system-
level table to a per-device ACPI node.  Both are populated by
firmware at boot and queried by the driver at probe; the
difference is which kernel subsystem reads the result.  The
system-table choice is what keeps the CPU memory subsystem in the
loop, per (1).

(3) The current CLI shape reflects prior maintainer alignment

The memmap-type=[normal,spm,reserved] form itself came from
Gregory's suggestion on the v4 thread in January, where you also
noted that AMD hardware "such memory has 1:1 mapping" -- which
is exactly the use case this patch targets.  v6 adopted that
naming, and v7 carries Acked-by: David and Reviewed-by: Gregory.

On the firmware side, OVMF SOFT_RESERVED handling is merged
upstream (edk2 commit 4e90b65e7b); the SeaBIOS-side conversation
with Gerd and Paul is converging on a small downstream knob.

So the current shape isn't a unilateral pick -- it's the form
the review converged on, with explicit tags from David and
Gregory and consistent firmware-side adoption.

> 
> wrt my suggestion using memory-device.
> It's true that the device memory region has started as hotpluggable memory.
> But that's impl. detail, nothing fundamentally prevents us from
> describing mix of present at boot time memory devices within it in e820/SRAT.
>   
> Answer to why DIMMs aren't in e820 was for us to avoid dealing with
> linux kernel putting that memory into zone_normal instead of zone_movable.
> On real hardware, one is likely to see all present at boot dimms, in e820
> and SRAT.
> For already existing memory devices, I'd like us continue dodging e820,
> so we wouldn't break existing deployments. however for a new memory device
> we don't have such limitations.
> 
> What I'd try is:
>   1: inherit spm-memory device from memory-device
>         (all memory mapping and APCI memory device descriptors, can be made
>          to pick it along with DIMM devices)
>   2: figure out why device driver has to fetch memory map
>     and proximity from static tables as opposed to getting it dynamically
>     from _PXM -> maped-memory range. (at the time PCI devices enum runs, all ACPI
>     info incl. run time one is fully accessible to in-kernel users)
>     i.e. try to make driver work with runtime proximity
>   3. if #2 is impossible, we can try to expose SPM memory devices in e820,
>       and partition SRAT to match actual device_memory region layout.
> 
>   
(4) On the longer-term direction

An spm-memory device built on memory-device infrastructure -- one
that emits the same E820 SOFT_RESERVED + SRAT memory-affinity
entries v7 produces today -- is a reasonable direction for a
separate RFC in QEMU 11.2 / 12.x.  Such an RFC would close
exactly the gap David noted earlier, that boot memory isn't
currently modeled as a memory device on the QEMU side.

One thing that has to stay in any such direction: the SRAT
memory-affinity emission -- without it the CPU memory subsystem
loses visibility into HBM and the contract from (1) breaks.
Happy to take part in that RFC when someone kicks it off, but
it's better treated as its own work than as a gate on v7.

Best regards,
FangSheng Huang (Jerry)
> 


