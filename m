Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900F9C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 19:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1Qq-00055u-AJ; Wed, 19 Jun 2024 15:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sK1Qo-000509-RI; Wed, 19 Jun 2024 15:57:22 -0400
Received: from mail-bn7nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sK1Qm-0007Du-GB; Wed, 19 Jun 2024 15:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHxvYgISCsBlfLguRpmXJJcS++QibWjjClfkgfBxAaZ64llunrJj08CGjk49M+h3EI4R1zJ7pUWib/LJU2d4CRlRPzw1DH1jWpfNAFzniM4DT8knJrfl5adWQ+OWpR84ufV/I2acEhxwTXT6nMHVHCywhOM0Q6sETsSIXX/EpVtPihPEsh+688Yua5G/MbFxP9urWmLITxzWPw9BLTVsLr/WmDAxcznsTj262y94LezBNfMElgnuk1jInyMaHufV1lpv+egIct2q2RmhFL0d+TRZGgUcdi/K5rDsPrQJ3rh7YBtp9Z3Zsg6rIVb2Kr8OOq2wcxNBzXZjVrI2ZPDPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lghh542nPXBMgokVGj7AwLrM/eULjav1fQM95QS5X/c=;
 b=Un4Z0wzuKCTim2VcS3uyN9pivfZ2VH20mU0ttk2bUGG/aJRGZ3rLa+7Fm/ilEZa0mz1tSLYAiqtTcXma6zX/BlWnzcYvxtek8kSCVM0AkiDAoaK4PCr+eG8bp0nSG5Hx5QzWr0PbRqnUqIs8D3Kpiod/spWyuFg6IobKsqOVfSw+39UYLxRm2i6yn++JUAcuL0psErox6SmokES/pYXXEuTvS7WjRyxKKLbk9AnlH8E4jS68HCohe5alUWkEXqXObrI6XBt4DRxyrC4RyL08OSS654sA/EVRl4ws0udRkR3ox6CIEfSQ9NF1DWbDdZoFsnvnBheoRaRtyGZt1H2nVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lghh542nPXBMgokVGj7AwLrM/eULjav1fQM95QS5X/c=;
 b=NJc+jX9OKs3nReRyywItv1ulixbd/OQXObD5n0VyO8F8H5emuMYrIn/1j3i12hYJAMjjyi7G/CyBNNdQ/35HWs94v11Ea+/7SxHQ8P6VXbO8mG7joO3+25Xce3IyF083Xyx/r04UE5jzF6Alka0z+Eojebd/EF2L4eetkeGkDZTEaLU0Bs+vhWYjhkFOykEgKmw8dDehVuRdgxuMM/NVWyTorEDyzA7GkRQgop/wJUwGFhIuMBIa6hhjjxOzek2KQroFboUiKGzHL3gLM4Sta49i1SpUj5PcjHzbZdAS+uBryxxSkzyNqJeTn+OuC+83JjvePZYt4WMEJwZEXWecNg==
Received: from CH2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:610:54::16)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Wed, 19 Jun
 2024 19:57:09 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::8f) by CH2PR11CA0006.outlook.office365.com
 (2603:10b6:610:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 19:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 19:57:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 12:56:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 12:56:57 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 12:56:56 -0700
Date: Wed, 19 Jun 2024 12:56:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eauger@redhat.com>
CC: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <ZnM4B+ZeN73UFpeQ@Asurada-Nvidia>
References: <20240618211110.922809-1-nicolinc@nvidia.com>
 <aa27c94c-099b-4383-a93f-30ffdf5cfd54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa27c94c-099b-4383-a93f-30ffdf5cfd54@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: b00d753a-3fdd-47a7-520d-08dc909a00da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5LubJK3JUmgk9ufrBZxn1Y50uYIV1e5g1p9rm8y29XsGN8fBaC2PK0zlLoqh?=
 =?us-ascii?Q?NM/NsOHNZNV+piFoPKowHqglkPucSi7L5qpGnIFXVAnqH3j9hiqKS2is9rmd?=
 =?us-ascii?Q?N0YeInSxkSYL2CxfCtQRPSHHbauscX/2+ULgHiyLTD1DhkBTlKXD4uqBeaD3?=
 =?us-ascii?Q?1YGs/hebcP80/kONxNOWakEueS5mi2UHHFV4AJQzutLFF8IEGO+GqSUtyOqq?=
 =?us-ascii?Q?BtvaFLUJUjYSyzdC4TvypsHlzTzswRR1m/f9cr5VhawhmwAi/ovrkV+dltga?=
 =?us-ascii?Q?fleGU3j8+s1MYQtqiG5tv51ZJ0YhlZFNDajXpzQbf8AwhFHgrZ4VLO/eOKMI?=
 =?us-ascii?Q?1vz+QlPq4dPZSzTIzvSo7ZhTOVXocnBm5Mi590RP8zE3mjYSvG0yYcT5X1Dq?=
 =?us-ascii?Q?g3E5uWyPsZzF5hz1CPUEIWueelcUcDBd7XqcWxGI4OSbtWiU7nvkbWNtWOty?=
 =?us-ascii?Q?aoyD+1jIHykZvEMbEw2yPmQAAa3m2IU4w/uCKhJCngLUxZk5G5q9YMzAM1d1?=
 =?us-ascii?Q?FoP9MNnFQ1njfzj+xZVj+9ePWQmTbp3QMfIzj8mvkje2R/w3HYX9sJU3Scyt?=
 =?us-ascii?Q?tw6iEcT21SLIWRylo/CMNO2liFwDsOmkYNhwwoCUeT0sd4zmPUjRBXiBKrVJ?=
 =?us-ascii?Q?T1d5QjMEkmuDqHXkLhqNWxL9UBVeb5zA5/BWZj+ENrx5iv9TAVC8LMlFHmjK?=
 =?us-ascii?Q?rgO4HoTzKTQFq3+0JoUvvh3MjKwMJs7tZG3fnHm2CgGZGdieVg7smfuWY9HJ?=
 =?us-ascii?Q?156jrYrf0XvdPAHP9EjSukCx9lr5J8RnK7VL+m573D4xZjQBlOTzQx3VrD6J?=
 =?us-ascii?Q?F0NwCXfyYeSwUIccLx/vlqk689dF+pGYzoEAyhH+5yeyzYccdGfyO8l06I42?=
 =?us-ascii?Q?lskngWVRyecUjyGZadomMthIIo8+yY+ZRp6m9KiC0XrdYLhOGc2hpsexFTAF?=
 =?us-ascii?Q?rFsQr/aT9I4U+Kp2FLA2S9FcxCwOnVFCKN1jExGEYyjdl9ihQ4tMM0HIWet5?=
 =?us-ascii?Q?TcQNzx6lwoOv/CuVNV7M68SXXZ3gOzW9xtLRb9RsFGlaVe6wFxBHx4vWgNku?=
 =?us-ascii?Q?54WkUU92V7L0wOC/HoSF+o8FcB1X7Sm7RGXhc96T+8kZdBdlnGTb829kxeSx?=
 =?us-ascii?Q?x6Cx4knSc/udKaYuE9VcwKf1dMc1wAmAP7q+vHA0pZRu8wADq6mRgsnBNmpX?=
 =?us-ascii?Q?OAUm9ZcIHyLXccWsNwBQq216L6rC/l57QVO1MDFWjvY2QNMzWt2DRpZC7/Wo?=
 =?us-ascii?Q?gHsZh1/fHsjYH9ad3LE7jL3rz81kBBdvLnWNFVd3sfwejWD5od4veHTArhD9?=
 =?us-ascii?Q?MfTaGi52+R5Scqfyw7mMi4MKoO3rvr7GygR6m3DlH3bpSwShom8EVBYIqdwZ?=
 =?us-ascii?Q?lJpeaLKhHNEJDxFpHoq2x3z53T96i1vYluPDyTQ7JJNUuVy5DQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 19:57:09.2032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00d753a-3fdd-47a7-520d-08dc909a00da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
Received-SPF: softfail client-ip=2a01:111:f403:2009::62a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Jun 19, 2024 at 04:15:35PM +0200, Eric Auger wrote:
> > @@ -209,12 +209,20 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
> >  #define ROOT_COMPLEX_ENTRY_SIZE 36
> >  #define IORT_NODE_OFFSET 48
> >
> > +/*
> > + * Input Output Remapping Table (IORT) -- Table 4 ID mapping format
> > + * Conforms to "IO Remapping Table System Software on ARM Platforms",
> > + * Document number: ARM DEN 0049E.b, Feb 2021
> I would rather explain what the function does, ie append an ID mapping
> entry as desribed in Tabble 4 ID Mapping format.
> 
> Also while at it you may use a more recent revision
> There is DEN0049E_IO_Remapping_Table_E.f.pdf available

Sure. Will do a v4 with something like:

+/*
+ * Append an ID mapping entry as described in "Table 4 ID mapping format"
+ * from "IO Remapping Table System Software on ARM Platforms", Chapter 3.
+ * Document number: ARM DEN 0049E.f, Apr 2024

> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for the review!

Nicolin

