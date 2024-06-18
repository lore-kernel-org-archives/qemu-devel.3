Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F204C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 19:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJe8V-0003de-R1; Tue, 18 Jun 2024 15:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJe8T-0003dM-Hb; Tue, 18 Jun 2024 15:04:53 -0400
Received: from mail-mw2nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62a]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJe8M-0004NL-6f; Tue, 18 Jun 2024 15:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEtT/diPpSwA0yToi48eCGL5TOlUlALF3ZssxdOnegQL1WQy1bNU5ZI0f/ZZXY6Y8Hsr2NpuNbh3vTY7SrxPqPbOOBY6Payyjs2IP4sTBUs91RY5O1SSS7fIC7AaAYjvn3MiRovMyuM5IGtcUcI7SJBuzLZbYWrcc+/bE/5+QDWPGxnQgQKoddJQJRNNLAxgcjyMj8W1nfrpS5OncoKvpTx91/NdZ2vMOuWKAMFh2vTJcXqfWEOHgA0dJVLQW+TUBVpbI9m3v5zI5IYJKxUJUUEBKQ8vUCSmB9e0clfUgu95Uwsj5nB4NiOiL0EM+BWXUC0fnBOOP6whzabC5/G+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJnvSWn8IDdk2oIjantc5Vgvks125RorlSu32YZapgw=;
 b=h2m0BAJYOP44nS4/wvqXq2kXne4jQJklbUDDgkC7iZiGBMzcazTmFUQ8geWbohI5uV5pm44nezE0hz5nuVWI78OJ7TDGH2irqgrEgvQbGI/kC9rgId7RsDDxoNo5+YetRqEvJMakkYXIrZzUp0cSmri6zkGhYyHB8PmjCewnnt+T1usn83KvGF40FNt9CKSScxj64m+PLEQgEP9nZ8pNIMhCVU4BWsw5Azp9t/sLGCVVXNdndlEYk3TOop/pnqMBXGdjezi81pxdPOj29WSGB0znPczlyp8PW3KtJzSXcVkiUwQfg5syo1xFnG0NKAEwYNbU45FxT9qq8xlkTk2ADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJnvSWn8IDdk2oIjantc5Vgvks125RorlSu32YZapgw=;
 b=syulKXzLuy30VeuH52+TxKm2Pg/7P25ygqSwUnz5Aha72+Bh8VFmiT1jW7SsNDmnEFPuGAYgTpFDSf+Jrf6d012ZD45mRXmbOaxvEIHGCyXkgwNcYrkBZyzAhZp4KBufhTmYHUfgZnf++Doix3n/9DbgF9Dj7ci0yoUuIXmhDswq8/TE9gDV8C6g8ETnwRT58/Ksj3VbEJ7owX++VXYZCoZkOSD9CW6Hp8AWwdmEYIrmYDx/LQofjgpxNRkQVq7fBnGxeY3xdai5GsHe6r+L37o1urVg16ksA4mNQYFA0Q8CrlwbTBw9uSLgrAK9txmMS8aEfOgkMCaA0vqz7pODag==
Received: from BN8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:ac::29)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:04:36 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::e6) by BN8PR07CA0016.outlook.office365.com
 (2603:10b6:408:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 19:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 19:04:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 12:04:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 12:04:22 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Jun 2024 12:04:21 -0700
Date: Tue, 18 Jun 2024 12:04:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] hw/arm/virt-acpi-build: Fix IORT id_count
Message-ID: <ZnHaNMNlFjhn5Jjb@Asurada-Nvidia>
References: <20240617223945.906996-1-nicolinc@nvidia.com>
 <20240618054729-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618054729-mutt-send-email-mst@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e71c3f-b752-4364-1190-08dc8fc97f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LB1lBrtX4Os9+/JFENIWkTwdXM2eRZHOH+v9KUGyiCJldwmQEEAbK3r90fiX?=
 =?us-ascii?Q?gTKez/1RBi2mhdgympjRb1LlXL45Ivws/YZerEG5QDCLNabnOmquczmwpl/X?=
 =?us-ascii?Q?72/8KPiTHADnB6OxEK1CGjL6ceEUfvt5dY+AKR8EYH2CdxlQDHuu/UkzoBbY?=
 =?us-ascii?Q?tBF+64nfyaKgtLW39tUpIC0VIuSwUzWSoR4OgKOTHvMsUoTo6hwD1oWiXovI?=
 =?us-ascii?Q?X4ROnyDsryHWPXCd8JTZDx3Wy6kDXb8wWiNgtH5gAEYwn9Yrq0ismqNBF9I0?=
 =?us-ascii?Q?fY9ibNrUZDJjmTIWgFXurp7PXkkjvZRSA+tA0PoZbKa2xP1lUy6D2DMdc63e?=
 =?us-ascii?Q?Sknpmr3fhixSUTK8lG/bhMsqe7xe9/yamDTFE5uTwQhS9VtOZulfUTNG3v7s?=
 =?us-ascii?Q?/wZGZ70Ig/Re1ej7/jln3ntQyVN9JF009tq7EgSSWQv5t9T4SwKlU+YvD3/X?=
 =?us-ascii?Q?AZQOHT4CXceKcUs9cUBzb0MQAw5MFiqeixpi+bTJXZ2Gvl7cTUQgZxR0utNu?=
 =?us-ascii?Q?zBP4ZQ4eeqBND8TSBT8SV2IWpQCmTAkt9Hq/4GELUlo7jgUVd048063xAI4L?=
 =?us-ascii?Q?DIzL7XXncB9tLHTg/58c55lDn5G3ANZfDGSE2wWL0euKA2pBE0H0eP1k8esS?=
 =?us-ascii?Q?5iHGHsSSjMcD7fJMORSAa5kFbvyhW+QQc4wGzKAVZHyr7jRl0PecKrlZIMPC?=
 =?us-ascii?Q?vlkiFZZd7RKIL7AW/M88KnX4pIQ2y/mfheRtfaae8xNzs7V6ts4wbDlHDm/T?=
 =?us-ascii?Q?T3d3RfN66IHDIK6JoU2GFqQjAlsA9XTNCq6lThQeKFnLVp+wXLyg2wqth7JZ?=
 =?us-ascii?Q?D+cDjVYiqHE/jCKhm5DNdjfGwlg+KH8uBz4j6uM1L9aenyOL3qz2hHcLRLK3?=
 =?us-ascii?Q?Z8LYBUxPgQluIBsb5KeDZdsIyakwMxe4nqjE7JN8vMkuCsBl68+9JeW+VVTr?=
 =?us-ascii?Q?UMXQAv39Uck2T09QhAaND2EynwPWBbj0UOQmji/hB/vVb6PkfGqXPz0nHeYw?=
 =?us-ascii?Q?3VHrk3fDcfxnlbDGewanKXGagibzeI4HS7R9/+k817cQhJ1OuHx6QJU/C/1c?=
 =?us-ascii?Q?v1X+xcMI6A3eXdV5m5hUuYSCjEPs3tCUa8fq5GW/y2B9vJAFeyhBifAM/5XT?=
 =?us-ascii?Q?CISeXqkR9z4PxbY4Rym0VIT4KPGU5fYgibJocju23LGEMg4tvFGHuK0pGfl9?=
 =?us-ascii?Q?ANiV6If/gr0YUPiXdbJ5owntYhu0hadGkG+zM+KiDKyRSqBKtMoP4/Eov4TQ?=
 =?us-ascii?Q?E5P3k0j26dIb9McMRX3XmBoUYTlBQj/wCeNQ9YUiMAywZhe9YFz4bTnfuceu?=
 =?us-ascii?Q?i3GrB00H4/XJwNPjxnx/X5GAbiml1ESfOj7Xx748GZraq9GVyH227v6n4jGB?=
 =?us-ascii?Q?osumk1bUDlIZfKaf37JE4W2h8j+cSrt3v/boSkfEGOecK42K/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:04:36.4455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e71c3f-b752-4364-1190-08dc8fc97f47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
Received-SPF: softfail client-ip=2a01:111:f403:2412::62a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 18, 2024 at 05:49:58AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 17, 2024 at 03:39:45PM -0700, Nicolin Chen wrote:
> > The IORT doc defines "Number of IDs" ("id_count" in the virt-acpi-build)
> > to be "the number of IDs in the range minus one". Otherwise, Linux kernel
> > reports "conflicting mapping for input ID" FW_BUG at the overlapped ID.
> >
> > Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> > Changelog
> > v2:
> >  * Moved "-1" to the same line of id_count calculation
> >  * Added "+1" to the next_range.input_base calculation
> > v1:
> >  https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/
> >
> >  hw/arm/virt-acpi-build.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index c3ccfef026..631f2c6d04 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -243,7 +243,8 @@ iort_host_bridges(Object *obj, void *opaque)
> >
> >              AcpiIortIdMapping idmap = {
> >                  .input_base = min_bus << 8,
> > -                .id_count = (max_bus - min_bus + 1) << 8,
> > +                /* id_count is the number of IDs in the range minus one */
> > +                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
> >              };
> >              g_array_append_val(idmap_blob, idmap);
> >          }
> > @@ -298,11 +299,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> >
> >              if (next_range.input_base < idmap->input_base) {
> > -                next_range.id_count = idmap->input_base - next_range.input_base;
> > +                /* id_count is the number of IDs in the range minus one */
> > +                next_range.id_count = idmap->input_base -
> > +                                      next_range.input_base - 1;
> >                  g_array_append_val(its_idmaps, next_range);
> 
> 
> What about other places where id_count is set?

There are only three places where id_count could be set:
hw/arm/virt-acpi-build.c:296:                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
hw/arm/virt-acpi-build.c:422:                next_range.id_count = idmap->input_base -
hw/arm/virt-acpi-build.c:435:            next_range.id_count = 0xFFFF - next_range.input_base;

This patch fixes two, while the last one is correct using 0xFFFF.

> >              }
> >
> > -            next_range.input_base = idmap->input_base + idmap->id_count;
> > +            next_range.input_base = idmap->input_base + idmap->id_count + 1;
> >          }
> >
> 
> Given this was different previously, did you actually test with multiple ranges?

Tested by creating 5 buses: input_base increases by 0x400 while
id_count=0x2ff (0x300 - 1). ITS results look correct to me:
--------------build_iort: smmu_idmaps
DEBUG: build_iort_id_mapping: input_base=0xec00, id_count=0x2ff, out_ref=0x48, flags=0
DEBUG: build_iort_id_mapping: input_base=0xf000, id_count=0x2ff, out_ref=0xa0, flags=0
DEBUG: build_iort_id_mapping: input_base=0xf400, id_count=0x2ff, out_ref=0xf8, flags=0
DEBUG: build_iort_id_mapping: input_base=0xf800, id_count=0x2ff, out_ref=0x150, flags=0
DEBUG: build_iort_id_mapping: input_base=0xfc00, id_count=0x2ff, out_ref=0x1a8, flags=0
--------------build_iort: its_idmaps
DEBUG: build_iort_id_mapping: input_base=0x0, id_count=0xebff, out_ref=0x30, flags=0
DEBUG: build_iort_id_mapping: input_base=0xef00, id_count=0xff, out_ref=0x30, flags=0
DEBUG: build_iort_id_mapping: input_base=0xf300, id_count=0xff, out_ref=0x30, flags=0
DEBUG: build_iort_id_mapping: input_base=0xf700, id_count=0xff, out_ref=0x30, flags=0
DEBUG: build_iort_id_mapping: input_base=0xfb00, id_count=0xff, out_ref=0x30, flags=0
DEBUG: build_iort_id_mapping: input_base=0xff00, id_count=0xff, out_ref=0x30, flags=0

Thanks
Nicolin

