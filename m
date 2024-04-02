Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F7BCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 22:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrmcg-0006Ed-7q; Tue, 02 Apr 2024 18:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1rrmce-0006DY-HF; Tue, 02 Apr 2024 18:28:52 -0400
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2408::600]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1rrmcZ-00073P-7u; Tue, 02 Apr 2024 18:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l29ADSdPD3R95LMsL17MjJzaW2e7tkVcQ9MU8kg7YDcdNkrwIk8yUgA0uwowJthSqPXU3IOmrqNaOgyWnNNGiBgbEbgTyqP16RgC6RQ/FJ/MeP1Bz07Bf1GIyj21Zo4Dw0kcTSH3YnJh+wtL3Td12w/ZGGl8otzcHaCIfBYNpqWX3cHtgW9VvvDv4Ttv2qEKu8udN0aEzBfrTAmrG+JeNOkhXwyFJirs7U2kc0P7+zVajI2WDDQX8URCFNTilNyrn1tKdn6gsKqJY2oztb06Odqb/Parli0Qa9bHoUvZ3KIOVZKPmSoyp3iV7DTBDXcpS+gnhbnRSU/fRvS45D0xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gyl49u0yWFc0G97vQdyP4pyTSrP7vlqokTAN3w1h3BM=;
 b=lU8AjzSlCLfd3qdMNLklnRXRNwPGsYD5HCHW3hGXQMInAH9U92CP5pDsCt9V3fQGhrHwrZU79IFvnyrTlAKAQFeRvvmsNqJf6cJRBNzxZG7gAPGm9+nHtLiqYaub6U/XS1dFPO3ZJ59BCOIDseCfF5CUjMjzIT86jcJzeocafLlteaJpMYbztUy5seBxSM6Am4azZpB3ZMUk0cJyGeMex1b1zVR8QGcfGRFgrMdp5gNpXx4GZRR08W5cimheyHHyeb7O/XBKxi8WZaA1W4HVIy9f18aa7EXmeBUgGQccnnVDCxfjRBdQfTWmxQcm6V0w5hmtuyppNv4QV4gYDNOxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gyl49u0yWFc0G97vQdyP4pyTSrP7vlqokTAN3w1h3BM=;
 b=QtNnMX4NUefwClUkjxSdZf+GrAQnqcrXQ4cFvydIkk5FVbO+6k/bRMK+gSgFKew4ZsJOK+8xPryUKUNL6ZPHJeUWKqFDtvLmi4bUbm0SPYEl6NH9ZTHPPVy4JKQ7SCiCKlwmknKABeu/rNCt0geornfqu8Gv1TiyOrnvtwpr8jK3zzE1hMTijMvKi7fa6PO8JqXTrR0vrZ/k7OgLNNooTPiwb7vCDfwUURsZbSwwz5m+A+4wnIDKqYmZD49LXszxETIl0Ue6htnrWKgEMVVdmtybnAfDMKRWERsoxguP4sReQ+B9RZlxya4Yb+wT/p0LNZyM1ObAKskZbTkhq8CdCg==
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:28:34 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::e6) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 22:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 22:28:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 15:28:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 15:28:14 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 15:28:14 -0700
Date: Tue, 2 Apr 2024 15:28:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <jean-philippe@linaro.org>, <alex.bennee@linaro.org>, <maz@kernel.org>,
 <julien@xen.org>
Subject: Re: [RFC PATCH 00/12] SMMUv3 nested translation support
Message-ID: <ZgyGfMz7IktmwtP/@Asurada-Nvidia>
References: <20240325101442.1306300-1-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 152fc020-b6d1-4bff-70d7-08dc53643b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1KktmxSP+zyUAxJ5zaF6nA/EwGWYOd3BPojjqiTp7OxCZ9nAIQlNcmogsAXRO0IACX1L/Atk1+fo3nM9ImtUyKqpEj6zcLeQVuAtF9BfoHnFmUwe7VJpxoPe7NeHk+R0uAXA99JI0t4FRsAzzoHMQOAgK/TnmNV8TOo2jSjlQk2BqU22sc+s0WmSc6AMU+qvHYW5X32WTn34H4Dox89eMvUi30TaKdL0oO6a33pVtnxwOI++7Hm4TXgvhN8/kXile7DHw3ivwMTzI2z5X7idNfi2ANgyz55uSypNV8A72uMazK/ffT6Nwc8TQ6whhO/JCHMEGtbGjb8YpTX3E6ORRUsf6WytTjZoME7gDW9/dt4I7/75X7JLlnwW21U2oY8MfcRFkRHtt8IGIYyWBdxkEMg7HewfyB6MO3eJBJ37In16VehPQxSoEYUYlvPWjguGzIexubeFxoorJZ7MbGPOxWfZ7FHjUvMlvq5e9dwX+emVsTFp/8hG1/YzBvjNXd9GcFWb6ma4b+YnApNFCGCiim9zGevOQPrY2N1ju6urfh6H7NTFmIsHX3VIv2Mt9d3EzW/pqnSXnEC9Kl3Kw2iRg1tCpm+uWKGV5hEFS+fF7VtD8G6oaiH0VNc8sh5b4dPirA1nYv9zPMk/q5Wx8lDefTIXLtNp7CGQJ86TJ+Y7FIzbkmiR65h+t2bk5KeT3nKO5EbyOhGXjjT6kGZZ4PnBWlfsVulTXFQwO9ykHrP6tW/edX6+UNgVzgnGAhNE+tB
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:28:33.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 152fc020-b6d1-4bff-70d7-08dc53643b7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
Received-SPF: softfail client-ip=2a01:111:f403:2408::600;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Hi Mostafa,

On Mon, Mar 25, 2024 at 10:13:56AM +0000, Mostafa Saleh wrote:
> 
> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> but not nested instances.
> This patch series adds support for nested translation in SMMUv3,
> this is controlled by property “arm-smmuv3.stage=nested”, and
> advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)

IIUIC, with this series, vSMMU will support a virtualized 2-stage
translation in a guest VM, right? I wonder how it would interact
with the ongoing 2-stage nesting support with host and guest. Or
is it supposed to be just a total orthogonal feature without any
interaction with the host system?

Thanks
Nicolin

> Main changes(architecture):
> ============================
> 1) CDs are considered IPA and translated with stage-2.
> 2) TTBx and tables for stage-1 are considered IPA and translated
>    with stage-2.
> 3) Translate the IPA address with stage-2.
> 
> TLBs:
> ======
> TLBs are the most tricky part.
> 
> 1) General design
>    Unified(Combined) design is used, where a new tag is added "stage"
>    which has 2 valid values:
>    - STAGE_1: Meaning this entry translates VA to PADDR, it can be
>      cached from fully nested configuration or from stage-1 only.
>      It doesn't support separate cached entries (VA to IPA).
> 
>    - STAGE_2: Meaning this translates IPA to PADDR, cached from
>      stage-2  only configuration.
> 
>    TLBs are also modified to cache 2 permissions, a new permission added
>    "parent_perm."
> 
>    For non-nested configuration, perm == parent_perm and nothing
>    changes. This is used to know which stage to use in case there is
>    a permission fault from a TLB entry.
> 
> 2) Caching in TLB
>    Stage-1 and stage-2 are inserted in the TLB as is.
>    For nested translation, both entries are combined into one TLB
>    entry. Everything is used from stage-1, except:
>    - transatled_addr from stage-2.
>    - parent_perm is from stage-2.
>    - addr_mask: is the minimum of both.
> 
> 3) TLB Lookup
>    For stage-1 and nested translations, it look for STAGE_1 entries.
>    For stage-2 it look for STAGE_2 TLB entries.
> 
> 4) TLB invalidation
>    - Stage-1 commands (CMD_TLBI_NH_VAA, SMMU_CMD_TLBI_NH_VA,
>      SMMU_CMD_TLBI_NH_ALL): Invalidate TLBs tagged with SMMU_STAGE_1.
>    - Stage-2 commands (CMD_TLBI_S2_IPA): Invalidate TLBs tagged with
>      SMMU_STAGE_2.
>    - All (SMMU_CMD_TLBI_S12_VMALL): Will invalidate both, this is
>      communicated to the TLB as SMMU_NESTED which is (SMMU_STAGE_1 |
>      SMMU_STAGE_2) which uses it as a mask.
> 
>    As far as I understand, this is compliant with the ARM
>    architecture, based on:
>    - ARM ARM DDI 0487J.a: RLGSCG, RTVTYQ, RGNJPZ
>    - ARM IHI 0070F.b: 16.2 Caching
> 
>    An alternative approach would be to instantiate 2 TLBs, one per
>    each stage. I haven’t investigated that.
> 
> Others
> =======
> - Advertise SMMUv3.2-S2FWB, it is NOP for QEMU as it doesn’t support
>   attributes.
> 
> - OAS: A typical setup with nesting is to share CPU stage-2 with the
>   SMMU, and according to the user manual, SMMU OAS must match the
>   system physical address.
> 
>   This was discussed before in
>   https://lore.kernel.org/all/20230226220650.1480786-11-smostafa@google.com/
>   The implementation here, follows the discussion, where migration is
>   added and oas is set up from the board (virt). However, the OAS is
>   chosen based on the CPU PARANGE as there is no fixed one.
> 
> - For nested configuration, IOVA notifier only notifies for stage-1
>   invalidations (as far as I understand this is the intended
>   behaviour as it notifies for IOVA)
> 
> - Stop ignoring VMID for stage-1 if stage-2 is also supported.
> 
> 
> Future improvements:
> =====================
> 1) One small improvement, that I don’t think it’s worth the extra
>    complexity, is in case of Stage-1 TLB miss for nested translation,
>    we can do stage-1 walk and lookup for stage-2 TLBs, instead of
>    doing the full walk.
> 
> 2) Patch 0006 (hw/arm/smmuv3: Translate CD and TT using stage-2 table)
>    introduces a macro to use functions that rely on cfg for stage-2,
>    I don’t like it. However, I didn’t find a simple way around it,
>    either we change many functions to have a separate stage argument,
>    or add another arg in config, which is probably more code.
> 
> Testing
> ========
> 1) IOMMUFD + VFIO
>    Kernel: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia.com/
>    VMM: https://qemu-devel.nongnu.narkive.com/o815DqpI/rfc-v5-0-8-arm-smmuv3-emulation-support
> 
>    By assigning “virtio-net-pci,netdev=net0,disable-legacy=on,iommu_platform=on,ats=on”,
>    to a guest VM (on top of QEMU guest) with VIFO and IOMMUFD.
> 
> 2) Work in progress prototype I am hacking on for nesting on KVM
>    (this is nowhere near complete, and misses many stuff but it
>    doesn't require VMs/VFIO) also with virtio-net-pci and git
>    cloning a bunch of stuff and also observing traces.
>    https://android-kvm.googlesource.com/linux/+log/refs/heads/smostafa/android15-6.6-smmu-nesting-wip
> 
> hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved
> 
> 
> Mostafa Saleh (12):
>   hw/arm/smmu: Use enum for SMMU stage
>   hw/arm/smmu: Split smmuv3_translate()
>   hw/arm/smmu: Add stage to TLB
>   hw/arm/smmu: Support nesting in commands
>   hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
>   hw/arm/smmuv3: Translate CD and TT using stage-2 table
>   hw/arm/smmu-common: Support nested translation
>   hw/arm/smmuv3: Support and advertise nesting
>   hw/arm/smmuv3: Advertise S2FWB
>   hw/arm/smmu: Refactor SMMU OAS
>   hw/arm/smmuv3: Add property for OAS
>   hw/arm/virt: Set SMMU OAS based on CPU PARANGE
> 
>  hw/arm/smmu-common.c         | 256 ++++++++++++++++++----
>  hw/arm/smmu-internal.h       |   2 +
>  hw/arm/smmuv3-internal.h     |  17 +-
>  hw/arm/smmuv3.c              | 405 ++++++++++++++++++++++-------------
>  hw/arm/trace-events          |  14 +-
>  hw/arm/virt.c                |  14 +-
>  include/hw/arm/smmu-common.h |  46 +++-
>  include/hw/arm/smmuv3.h      |   1 +
>  target/arm/cpu.h             |   2 +
>  target/arm/cpu64.c           |   5 +
>  10 files changed, 533 insertions(+), 229 deletions(-)
> 
> --
> 2.44.0.396.g6e790dbe36-goog
> 

