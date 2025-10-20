Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF94CCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlwd-0002nT-3b; Mon, 20 Oct 2025 05:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vAlwX-0002lb-74
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:12:42 -0400
Received: from mail-westus2azon11010007.outbound.protection.outlook.com
 ([52.101.46.7] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vAlwU-0005CM-M2
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:12:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+gD181qPd7/AyvpvSIhcYI11Hh2zIDh4pYGCxDczDYPq9rZXNp2GbX9djZEwMpSKuan3XlcnIMirM++iJaBSP8zgk29H+sTkNM+EI9spYD3Usl0XNHUhZr+q8ypU4zSRwDP1HhFvGJ8SwjfUYydl+RaxQeUOsYlUAzKE0k+gHwcq7LD6rViOwN1RpfCsrlnDarUA5ElQiaPkHQE+3ZkoELlU1NccV7sgB+dP0aFNhD43yCF9Jg1U771xKUT5OAHfWRU4Q+JyXSixlqH+YxChURK+esOKGQJl1vrJWpVdnNPwOXwS7it+F1clHM+lUWUn7whCcASr8EKsa6FAqupsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOZ+nixHazb4HnavPJeXgOtMK07jsp2imIRg0VdfqLA=;
 b=U4+J7deS+v2dw/Pfz3EMJkUOTbbotCd5m4w5CVMhoZa6UbFwop51SkuIPoB+RovYXYnZ5C6O8LcNRL7G4XKp1rhOQtOjgBTNpIiklNJxOhlEdz0kjnD8FSlvsqNOgh31xb3tZYiYyLz5AgY9rZ0iV/ARFIA9t4HPwSQ36ov+Qxnq9jN/QZWarD2LFmCLe7OSz1xTYjDLbLqlLpuxXY6uizVsyxNB2yeCD26vgBbc99D72GvLUWbDpaKPGpSVasjr0/adgNMkdYP3UCXXpExjvjkRDa/6JYsHcoASVZmI9z77wATWSESj19jj+7EZUQu7l7DKgIvdEdUT/UA5Wzi/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOZ+nixHazb4HnavPJeXgOtMK07jsp2imIRg0VdfqLA=;
 b=zTMdpxm1XWbECTw3xsPGRtSAuAPv4yN2VmXau/QqCr9kCkWyXykxjqNcvdcVndlLbUPUgaj8z2VmU5DENYVLcXxM0MqN57Cy+7jmkBolc+H1RWeX1KvQWYm/3DWtOQmtHq6IRoiWo8pNEW6deyHIV4bMZjoZDdpXfgE2mfj8od8=
Received: from BN8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:408:c0::32)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 09:07:27 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::9d) by BN8PR15CA0019.outlook.office365.com
 (2603:10b6:408:c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 09:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 09:07:26 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 02:07:24 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <FangSheng.Huang@amd.com>
Subject: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
Date: Mon, 20 Oct 2025 17:07:00 +0800
Message-ID: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: fa541d35-24d7-47dd-f8c8-08de0fb8171d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SurfEjDME3ndmItM4fpO+5z5oabI5HonRz2L6nQO6yW52hTshcazrttf0PwF?=
 =?us-ascii?Q?ajLXD9WLNfFMZqeWs4hri8D0vEG3nO/nUwOPiZVcY/rEycunPb+2ZMjeNScb?=
 =?us-ascii?Q?x8AMsAo83QP695WZh9WuZAoFMM6U3+TTgnVUwyR+6EuwZhzOGl6Zen7900bQ?=
 =?us-ascii?Q?144A9YVyc69fs/Io69ZhIBZYX5hMWUpYROfKYNVTiPsQAmk7epCwf+T5yTMx?=
 =?us-ascii?Q?9b0RH3tmIKMFjToi/K91lVNNZPmt3sW8QY5dNbt5YQKxIqWQSBi/A71VL4SY?=
 =?us-ascii?Q?VJxrFWNv5NG3lcV6yxAPmvE9PV+d5+WaIzkeJA6KmKhv3at8NMPGb3oOAaHY?=
 =?us-ascii?Q?PKiBhbtA0jzFB3y3blb/fC5VPfbSFMHyHDcstW1WdSqJDg4d/WRt02gr/7OY?=
 =?us-ascii?Q?OuzrV9CrO0dyY4rFKvsD4fX78DD9tz8qPNQVWKmrVDPCWaUuV02HSPZ53ueC?=
 =?us-ascii?Q?YTynHiru3QSdzx1bEJqexzL1dXM/wfGZXh8NBzSGRU2Mci5wHDgN7oSbn8uL?=
 =?us-ascii?Q?ZVKFDgGSpYjm4ft9Zt9724xcInsas7cQ33iJiRgxOQSOsAuYkcEwPdu9lDMs?=
 =?us-ascii?Q?61sQq/Wd+LXfmr3mEenBhrbEbDczbdYt9PqBaEC1MGHdWPcRDiCV9ampaCa2?=
 =?us-ascii?Q?JZu+u0HTVL7TycGkkGdMVxyOEb5bUAhCYk9N1+1cu8PEGCZ7ovktEFAM7rMr?=
 =?us-ascii?Q?AxyvN5cUu6CKC8vhCUihKVkEwgH0f058lHBrf6vXK9XvW/y5BWRHiigal24d?=
 =?us-ascii?Q?H407XY/BouelNUV8yeeHmKH1TwS99Dp5lsYc2oqJOz+HCyjs4TsCYu6SXr8c?=
 =?us-ascii?Q?HdwO7m0bJSbGqu0nhZRmoNrYsr6/rb3RsMfoyTKzLIBxB5izK7T1NWUAc+wS?=
 =?us-ascii?Q?ANEUd17VuYTo7JUKyQ2B7ZZ6JYbY/V55nN1PvgkCglsQEcE7jE6W+rclhZv1?=
 =?us-ascii?Q?algI4Ja31FhMvcBNPkzfdagn6CaxNgrzmzJYkm/PZ/bsBvgndvdkHoesxuXn?=
 =?us-ascii?Q?68Wvlhn8zGZ1qPhh4uK42SogIjM7hLKrbToEQpaFyNb1fKlKJ9sZPrzknIwe?=
 =?us-ascii?Q?0Zb4XOiRvZqgNsSwztt9G4k0dBcdQb+tYOMQ01ksJX+dgz5O6A2d1HIOTkv4?=
 =?us-ascii?Q?XAPlYg+ZVH7GwLvZGfup55KRecyZWiQrUDtHbyoq7ds/tp2ZD67xoO0vxIbe?=
 =?us-ascii?Q?ONPuA7f9NIsDlWkeQUQMnK3kr4qgf9rHAud+pv9iIpd1K90kqPogIudqoZao?=
 =?us-ascii?Q?0nIJZ/5lC0ql24fJBztZg4FsaGNR8d5rDDE5X3eX7os2MU6vUeJNf4t4Lkfs?=
 =?us-ascii?Q?AinWirlI1mh7Zj4hynEJ6Ah51jeeb6dNPaRRbvhGxYxe2tEOy6Aq0On9mnn0?=
 =?us-ascii?Q?QXtWcDTh9dIBKd/Ve/ncPrYrEjkE/+8H0LR9PEohkj9tvhiLcJdlMdKs+771?=
 =?us-ascii?Q?5vxtKh5jRwYnkwIAROa1i0nyAWko3skRdPBXgCyeve5dnSeI1vjzNi7FN4og?=
 =?us-ascii?Q?dBGVIQEaq0I7Jar1qZk8UfeY666qbjgKhZOtVEJh5liiuZCG1RLNg0ed0ABG?=
 =?us-ascii?Q?t5xUezzX0wkTBNFo372ShoZC4vQW7kI21MSnbClD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 09:07:26.8990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa541d35-24d7-47dd-f8c8-08de0fb8171d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
Received-SPF: permerror client-ip=52.101.46.7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi David and Igor,

I apologize for the delayed response. Thank you very much for your thoughtful
questions and feedback on the SPM patch series.

Before addressing your questions, I'd like to briefly mention what the new
QEMU patch series additionally resolves:

1. **Corrected SPM terminology**: Fixed the description error from the previous
   version. The correct acronym is "Specific Purpose Memory" (not "special
   purpose memory" as previously stated).

2. **Fixed overlapping E820 entries**: Updated the implementation to properly
   handle overlapping E820 RAM entries before adding E820_SOFT_RESERVED
   regions. 

   The previous implementation created overlapping E820 entries by first adding
   a large E820_RAM entry covering the entire above-4GB memory range, then
   adding E820_SOFT_RESERVED entries for SPM regions that overlapped with the
   RAM entry. This violated the E820 specification and caused OVMF/UEFI
   firmware to receive conflicting memory type information for the same
   physical addresses.

   The new implementation processes SPM regions first to identify reserved
   areas, then adds RAM entries around the SPM regions, generating a clean,
   non-overlapping E820 map.

Now, regarding your questions:

========================================================================
Why SPM Must Be Boot Memory
========================================================================

SPM cannot be implemented as hotplug memory (DIMM/NVDIMM) because:

The primary goal of SPM is to ensure that memory is managed by guest
device drivers, not the guest OS. This requires boot-time discovery
for three key reasons:

1. SPM regions must appear in the E820 memory map as `E820_SOFT_RESERVED`
   during firmware initialization, before the OS starts.

2. Hotplug memory is integrated into kernel memory management, making
   it unavailable for device-specific use.

========================================================================
Detailed Use Case
========================================================================

**Background**
Unified Address Space for CPU and GPU:

Modern heterogeneous computing architectures implement a coherent and
unified address space shared between CPUs and GPUs. Unlike traditional
discrete GPU designs with dedicated frame buffer, these accelerators
connect CPU and GPU through high-speed interconnects (e.g., XGMI):

- **HBM (High Bandwidth Memory)**: Physically attached to each GPU,
  reported to the OS as driver-managed system memory

- **XGMI (eXternal Global Memory Interconnect, aka. Infinity Fabric)**:
  Maintains data coherence between CPU and GPU, enabling direct CPU
  access to GPU HBM without data copying

In this architecture, GPU HBM is reported as system memory to the OS,
but it needs to be managed exclusively by the GPU driver rather than
the general OS memory allocator. This driver-managed memory provides
optimal performance for GPU workloads while enabling coherent CPU-GPU
data sharing through the XGMI. This is where SPM (Specific Purpose
Memory) becomes essential.

**Virtualization Scenario**

In virtualization, hypervisor need to expose this memory topology to
guest VMs while maintaining the same driver-managed vs OS-managed
distinction.

In this example, `0000:c1:02.0` is a GPU Virtual Function (VF) device
that requires dedicated memory allocation. The host driver obtains VF
HBM information and creates a user space device for each VF (for
example `/dev/vf_hbm_0000.c1.02.0`) providing an mmap() interface that
allows QEMU to allocate memory from the VF's HBM. By using SPM, this
memory is reserved exclusively for the GPU driver rather than being
available for general OS allocation.

**QEMU Configuration**:
```
-object memory-backend-ram,size=8G,id=m0 \
-numa node,nodeid=0,memdev=m0 \
-object memory-backend-file,size=8G,id=m1,mem-path=/dev/vf_hbm_0000.c1.02.0,prealloc=on,align=16M \
-numa node,nodeid=1,memdev=m1,spm=on \
-device vfio-pci,host=0000:c1:02.0,bus=pcie.0
```

**BIOS-e820**

BIOS provided physical RAM map in which 0x280000000-0x47fffffff as
soft reserved:

```
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000280000000-0x000000047fffffff] soft reserved
```

**Guest OS**

Guest OS sees 8GB (0x280000000-0x47fffffff) as "soft reserved" memory
that only the GPU driver can use, preventing conflicts with general OS
memory allocation:

```
100000000-27fffffff : System RAM
  1b7a00000-1b8ffffff : Kernel code
  1b9000000-1b9825fff : Kernel rodata
  1b9a00000-1b9e775bf : Kernel data
  1ba397000-1ba7fffff : Kernel bss
280000000-47fffffff : Soft Reserved
  280000000-47fffffff : dax0.0
    280000000-47fffffff : System RAM (kmem)
```

========================================================================

I hope this addresses your concerns. Please let me know if you need any
further clarification or have additional questions.

Best regards,
Jerry Huang


