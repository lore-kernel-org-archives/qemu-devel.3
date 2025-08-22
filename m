Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2833ECA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upT89-0003eT-SY; Fri, 22 Aug 2025 10:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upT87-0003d0-7u; Fri, 22 Aug 2025 10:52:35 -0400
Received: from mail-dm6nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upT7z-0003oJ-My; Fri, 22 Aug 2025 10:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nmo8XZGHOdLWRVJU6Huk9SNDkts0XnqE1yW4A+EQvd9rmwJ5WB8DpFhyHzuiCBANhcuUhAu3vFmPAVhOU43vt8L+kKSo8jnxJqKkJ7nlaEUnEl1AGOxHOwq1W2aJU954UXSRutznBboraWuaWa5gaqmCSwnG++85C7I3XkiW2HUh8ICCjzaopfC7hMArQ20wioV/+CkPepyno/774U/kF7xEaQOR5arYmWTOGaUJrSJLqnkVVMUNVzR6S/iKNSup/SwN+OqWYGqfXTZ+zKxznjP/WDjvvCVYC8fL3sXtEppiPoTUTtbkI9qNuNEcNWu24Ole5Gf76/QK3jR+pSxMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6TpbYX0ArutJqQl8nDABdDxwnHm+Q+8DRINzG6XRQ8=;
 b=fkZpPYYrl1XK5Bewc7UiUCmVogz6Hk/2yU2HpV5SboMPTwCwd0G+kOmaC1ppYpbPWI8GwT7nRIO8lS0AhH6GAHhrutWbXVQLGffTcOcUrtgWqpt9syTBDUf4G48tIjw7YICLQEfs2YN1JrMHM9t2puj5ozRkFxWJyPtgA55q8Ljj3Vx0j++/g4bYQTXLqYCCo3eaeWuyKF8uNWjuC7wTNDEBpPi7XYEKnsbnpQb0a1lgS5X8i3FL/d3hlrnvBqzrvBfLkbUEQtmUGfjrNHfjb7QP5ctcuQ1UR7GBBZx9n+0kWjIG0h9+hcDRej9IBAC8HFmvuGhPh2LQgORE6Dcp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6TpbYX0ArutJqQl8nDABdDxwnHm+Q+8DRINzG6XRQ8=;
 b=vjOpvPQoolHdFRMEr3H+UsJ3XdxpraVwVFdxQ2P5WhYuHeyhZtS+h4Yt02TpBagHRQ1w0QVMwAYnT/AzODH8EI/ZA1y/kOWh+XtZmrWHDF5reaGVMvXPOHgg2iB5uByAY57xcghTRZeoZA74Eli4KCiBqvbzL3v4wZIGKCs+Hsw=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 14:52:14 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::58) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 14:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 14:52:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 09:52:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 09:52:12 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Aug 2025 09:52:10 -0500
Date: Fri, 22 Aug 2025 16:52:08 +0200
From: Luc Michel <luc.michel@amd.com>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v3 00/47] AMD Versal Gen 2 support
Message-ID: <aKiEGO6VdEea3Wwt@XFR-LUMICHEL-L2.amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
 <aKcs16vxzC93K1Ad@zapote>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aKcs16vxzC93K1Ad@zapote>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 0655fe70-9470-4d5d-9f94-08dde18b7b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?feMUnFuX87xHNj3NBH+n5jeP6ERpyiCL8I+TwRtIXrKI7IdmTtJ6GbLpXC8h?=
 =?us-ascii?Q?MhXqB2mBj+CCqvijk5PjyvSFVoOgMkb3DVFGl96DQ/SxbBqEDWkvuFZg0/Ax?=
 =?us-ascii?Q?TpRSZB7np4hz1UQg5Bu6sGZIhw2V4vyFz3aoc1S2QtTNYdKTCnGuxyeT2vAO?=
 =?us-ascii?Q?Aq1a+5FH4MYVP6MTp+fHuigM18GoJUcdvI4HekX68pjyZOypB+GNvupLqaj5?=
 =?us-ascii?Q?hqITAzA+ibuem1MVPIYtcJeUsM2JLbl6uVq6LuaEFOPAUTWNtyEBH8LmznJa?=
 =?us-ascii?Q?0bjthQOuXa2p741SZd72DJnY6eCNHiZhQ95doW+vbbUw58MHg01++svxCsAy?=
 =?us-ascii?Q?MqEyFBdJ44i8HQJOD9KMKKmce39y9sp2kRA2ScAzEv/821ABbp1ouQExuUeV?=
 =?us-ascii?Q?Uv809SYaRInK8dQe574BKqg9FetWzBvoQxNt5w/66HdTB22YXppz8cp/ttpE?=
 =?us-ascii?Q?6uPvhhyLI/JAtNnirf+pJ7CDlqegLF1tUOS7THS3qazmQoXIXqtDxfvN59Q7?=
 =?us-ascii?Q?El98NXg+z3yuXewJe7Ngddog49cpXk+zuDzHCfLe6cwhfCYT5yU2v59k0Gjb?=
 =?us-ascii?Q?s6X+TJffSP9y+ekcHLHRUmftieamvDrMcvgX8BQWh5SacBO7Fs67b5QZA+z5?=
 =?us-ascii?Q?zd5qy+c5mGX3HFTjy4pgvznjJofRH/FT6esQG1AoBz046k6C10jxlBTgqlHE?=
 =?us-ascii?Q?cVFLQFS9Ee2JHTfA1dPsSYkbbzUhWMPC8m9MNc1wtvOQhLTMu8wTkpeGIa9+?=
 =?us-ascii?Q?EumjB3FxlIOMYDx3TKW9QnwaT0mgsM2xGaHtIFBQ8Gga21pQfsxMQCTGlvXv?=
 =?us-ascii?Q?T0qC5qVNHYSQ/UCHuZ1A9TdrSRQ8kJ0/uTCREFC+VwyKs+HR6Bhkah8brYXa?=
 =?us-ascii?Q?0oT4WMqt7SFjqltfDmU1VjdytQsT9xuxdwCjlPsEeJNFSxI0Dq6ff7fDj7RW?=
 =?us-ascii?Q?qQ6QdJ66gC722Ddr/x6Iq3yfAK/U7Tu5iTkjoqcJ5Wv/KVjneElagqndIZzw?=
 =?us-ascii?Q?qSs8Q4f28cEV/kfO+mM5LnA16uHLpVbUdlgVVfRGOD+Pje7KVSwEUD0dVDBJ?=
 =?us-ascii?Q?MbfG9bbVaBoolI+uz+OOAQWf/4Q0WDbmvWUr6kLvjEKqEfeiF8ub6TSOsu6p?=
 =?us-ascii?Q?AtTF5ewle/DxhKIBjC/tyB2xDUgiNnvbbQd41cfex6mWd8E0t2wKYKTWgyvG?=
 =?us-ascii?Q?6QMbGRv8VCp+uH7MiJiljDpjWb2BYKEQbeEe/Q36HpEshkTtT/xa52SPrHvh?=
 =?us-ascii?Q?WQQHQlOy2gBYEG38Ew+voXYY7iJLtZ7YWMMhq9C8tt0cwQaxICvTzJ8Yz3uq?=
 =?us-ascii?Q?5zIh6p3PeEd8EIhJewRSzmNHoeGJgCIiImmPZl+FCmHVm24kgcX4l4sKudWN?=
 =?us-ascii?Q?A0YQvdp9fhLvk/soqR5dllfOH+U0aGUhy2GVTMpJuGaARn1SB+0tPeSExmAM?=
 =?us-ascii?Q?6tj7FNUtqJkJc/YU0Do/cLXC0/qyNjoWcte9jidOprI1ZCJJ9loipJ+Uk262?=
 =?us-ascii?Q?OZzotChFEdjJyL4d1iHDe8S5nhtzxxU4G4ys?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:52:14.0394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0655fe70-9470-4d5d-9f94-08dde18b7b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
Received-SPF: permerror client-ip=2a01:111:f403:2413::61e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16:27 Thu 21 Aug     , Edgar E. Iglesias wrote:
> On Thu, Aug 21, 2025 at 03:02:59PM +0200, Luc Michel wrote:
> > v3:
> >   - Dropped qemu_get_cpu() usage in the machine code. Added an getter on
> >     the SoC interface to retrieve the boot CPU instead. [Phil]
> >   - Cleaned the mp_affinity logic. Drop the mask attribute and assume
> >     it's always 0xff (the Affx fields in MPIDR are 8 bits long). Use the
> >     ARM_AFFx_SHIFT constant instead of hardcoded values in .mp_affinity
> >     description. [Phil]
> >   - Avocado test renaming in patch 41 instead of 47. [Phil]
> >   - Documentation tweak. [Phil]
> > 
> > v2:
> >   - Addressed formatting/typo issues [Francisco]
> >   - Patch 23: GICv3 first-cpu-idx: addressed the KVM case by bailing
> >     out if not 0 at realize. I chose this path as I don't have a clear
> >     view of what it means to implement that for KVM. It seems to make
> >     sense anyway as this property is meant to be used for modeling of
> >     non-SMP systems. [Peter]
> >   - Patch 39: added a comment to clarify cortex-a78ae != cortex-a78 [Peter]
> > 
> > Hello,
> > 
> > This series brings support for the AMD Versal Gen 2 (versal2) SoC in
> > QEMU. This SoC is the next iteration of the existing Versal SoC.
> > 
> > It is organized as follows:
> >   - The first and biggest part of the series performs refactoring of the
> >     existing versal SoC implementation. This consists in:
> >        - splitting existing device types into base/concrete classes,
> >        - moving from an in-place to dynamic device creation approach in
> >          the SoC code for flexibility,
> >        - describing the SoC using a new structure called VersalMap,
> >        - moving the DTB creation logic in the SoC code itself alongside
> >          device creation.
> >     Patches are split such that each device is individually converted to
> >     use this new approach. Behaviour changes are minimal and are
> >     emphasised in the commit messages. This gets the SoC code ready for
> >     versal2 addition and leverage the fact that Versal family SoCs are
> >     quite similar in term of architecture.
> > 
> >   - versal2 SoC support is then added by adding the corresponding
> >     VersalMap description. This allows to reuse the existing code
> >     without duplication and almost no special case.
> > 
> >   - The amd-versal2-virt machine is finally added, following the same
> >     idea as amd-versal-virt. The documentation and tests are updated
> >     accordingly.
> > 
> > Note that the xlnx-versal-virt machine is renamed amd-versal-virt to
> > follow current branding guidelines and stay coherent with the new
> > amd-versal2-virt machine. The xlnx-versal-virt name is kept as an alias
> > to amd-versal-virt for command line backward compatibility.
> 
> 
> Hi Luc,
> 
> I run with this command-line:
> qemu-system-aarch64 -M xlnx-versal-virt -m 2g  -serial stdio -display none -net nic,model=cadence_gem,netdev=n0 -netdev user,id=n0 -kernel Image -device virtio-blk-device,drive=d0 -drive format=qcow2,if=none,file=rootfs.qcow2,id=d0 -append "root=/dev/vda1 console=ttyAMA0"
> 
> Before these patches, ethernet comes up fine but with this series
> applied, ethernet stops working. The kernel finds device and the
> driver comes up but it looks like it can't receive packets:
> 
> eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:57
>           inet6 addr: fe80::5054:ff:fe12:3457/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> -->       RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 B)  TX bytes:4988 (4.8 KiB)
>           Interrupt:17
> 

It seems that eth0 and eth1 have been swapped, because of the FDT node
ordering.

This is the issue of the non-predictable naming scheme, used by default
by the kernel. I tried fixing it using aliases properties as I did for
the UARTs. Unfortunately whether this works or not is driver dependent,
and it does not work for the Cadence GEM driver.

So my only option is to create the nodes in the same order as before, to
stay backward-compatible. I'll introduce a small hack to do so in v4.

Please note though that the FDT node order brings no guarantee of any
kind regarding the device probing order in the kernel.

Thanks

Luc

