Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4903C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 21:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgF5-0002lE-2W; Tue, 18 Jun 2024 17:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJgF3-0002kh-7N; Tue, 18 Jun 2024 17:19:49 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJgEz-0002uU-Rr; Tue, 18 Jun 2024 17:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkBgynY10BzvnngZECorMsFDwVPTSFs14y2nZUuP8cikiUXz0HbFERXz/uG77G0LVWjmGsLy+JLOiW0woOJZXdtA8iB7koeX8+2iIepv0a+NQE/nISGslzNi96SPf6n701jkkfZfTLjGW7F+irPjf1EkhiiUV9dXZzjQMTTBfqGWFgPNqbgi5wZ2V2AEHzkrG3bjTYaixIB3WTZoZHVzTOUi61NmN9k4mPr+jpb3j6pUHFt2BDUVlJiFltp9D9skRHB7/6Vwo75f4pJ0nI3FdczBw77ACPzCHKoezGu9CRY/weUFaQg+3OK5qBF1Ro30LhRNDyThWTr42bqoDFKXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTk1Emny564o5Ma5FxHfnoRVRs9hvLiZ7MCKOgG/4DI=;
 b=OM7jzA8WcU98BViOYZFIE4KSfAKf7cAAWWguysFPDl9cGGjUlrVIDrn4f6pGu9ZbFwq+AmxIp83bBVxezrAruobBDBF0JmmNSuAUwkbrtzSsudU0XDY/C3pdBDuM/kzqrotemwH7K8FwrWN22fzgHU1P+lkN2t07svWhcBUhj0Md5iT4pBd3yGHl9vLqKqiOV6ZTgmIRT319IRfDZAkbi75dXFj/ecKywKk/cgGTcKdB+6ch9x0DWHvYhs2I2Ffoey6iv/5ANb2QecifzzzM4Ot/+W/FznOr9wBrsmK/RgHoVjli7Bimvza7qs1dlgfl1IJjEsf01oAWyqKq1SvLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTk1Emny564o5Ma5FxHfnoRVRs9hvLiZ7MCKOgG/4DI=;
 b=c7BTqj+eeNajY9/RAIwjL9fxeNDuyEoKwNcGpGgSs29Emg2803dfIyixCw6g8Hh0t1HSFgxlD7eu2v2c9NhoiAkf8LxIoFeCeTz9xigEn75v8yof2H1pshjleRSOXkZmlj3HKhYKyrwpRe+RsynrvTkph87b87fnsedQGB4BlVxSqYYN+iIZrDLYoCUmTsDumBGkCEPWS98DaJLoJgcdQlXlQaqxEyMpriR2vm8h+JVGMXaxJh2IXZMO8L3+GnwPnFgBfvOLOPLljv/dxGkim7/Mgvp5tsmk7CdR0R51aOgIbmOl88M42F5DyjWbYDdoVr+JNy76RjvPl2+S/CPvkg==
Received: from CH0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:610:75::13)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:19:37 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::28) by CH0PR04CA0098.outlook.office365.com
 (2603:10b6:610:75::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 21:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 21:19:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:19:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:19:27 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Jun 2024 14:19:26 -0700
Date: Tue, 18 Jun 2024 14:19:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <ZnH53Qaqp5+Xo1jo@Asurada-Nvidia>
References: <20240618211110.922809-1-nicolinc@nvidia.com>
 <20240618171311-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618171311-mutt-send-email-mst@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 298586bf-462e-479f-5bbf-08dc8fdc5bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GiJygxPwqmsF2J+ekJZcE7IsXJxoWGuEOTERv50bsbkW8WsGydZxf5jY8nZd?=
 =?us-ascii?Q?GfkXsiryd6+fDDxKedorCtpNwwNKBlUBGgyCvF6VcAt4QLRT1Fl0nMRwyXa3?=
 =?us-ascii?Q?L4JM+PTIftVqo5QmFY8JQwU699ztZ8G6ov+wcrZxbPcc+RnJA8BvNQqjX4IQ?=
 =?us-ascii?Q?wEHXFXU5fpzmL09WtuS4KElqK7q4Y4Bo3dL4dES74WSb+GZG/nWypNU/jlFb?=
 =?us-ascii?Q?3e7XZOPZvnKfE4Uso/2VVgr0Oe+DWZlYcdahZ+qwcayq4XpN+PUSgU457UcT?=
 =?us-ascii?Q?Mhjn2CYv1XZP8sW4EFnOg/nSaQJOd11Kp9tV7NRRds7aVheymBWByxye0TFb?=
 =?us-ascii?Q?jM9zByvoAIFhtH2hdnk/plYnG6Cd0CRSTPV1teY7EjzaswuHDMRZftqBfNPO?=
 =?us-ascii?Q?E2uTR1L+TyZI+JUkFbhu6HzboF1eZVnuE3ZEDaRgidLt3Be9MsfnkXVOY77P?=
 =?us-ascii?Q?Ap7Tz1DQUKUy+SC6ZWUvvp+U4RctK2b/xgTdok+6x3Q4tQh7Yw6vYW7FOmBM?=
 =?us-ascii?Q?GwhLrBC+V97cN0ZElDaVdTZe46cIlC6xYOU1PJUAFWY0eRQcJkFeFRfkaOPo?=
 =?us-ascii?Q?Z1xG9Wj8ajZTt4A3H0Ckv1Vx/7ldIgdJ/I3MJ6Fv2TyL2YU3AT5D1upgQN5d?=
 =?us-ascii?Q?bUD6AnZkx8dwCRccVfeD3VlU2V3TnJ+zCiCD6GlZgkJyyUDub51P/w08TNl+?=
 =?us-ascii?Q?mgBZwPa+l24gWI+R5kpDzT8Ymdvs63x89MNFjrVA81k4WfhPl/6rxRE1I0TI?=
 =?us-ascii?Q?sGcr9W1KAgZidv6jsHAAa+gpZU1r8VM6wNytcz1YDTHgzp2L3A+jc1zE2i+D?=
 =?us-ascii?Q?wmiawW1xzX9w/OMbK284MEcU+CrgKs8Zu9bC6tZgFQ1uUcu38cSs+shIEqXC?=
 =?us-ascii?Q?mrxl8KTRBJua+npBUkWkN2MyOf+hI/aPgWD0afTCMutxMvAK914U40WCwOVP?=
 =?us-ascii?Q?CGriHfrOgd9wATNr6GLltKMpTRW9UnZSucqmLmKU3+hkr7QxxhF+CGbkZ+uf?=
 =?us-ascii?Q?jgp/NxrgrT1unmiv5PAh2UBrUFZdTAk/3Nup+XyPReC/6xe3bQ3UdL6Rf+Tw?=
 =?us-ascii?Q?WcO+zV5Dii4UqQ43qdDKB3UvhxV48sr+Z+Xu+3asWk/aFf/uF+FvRPO1aGw3?=
 =?us-ascii?Q?EXMM+t2ynhAHuOgPTKkPX5cWU1VqcE89rJe4L95q/pgTfLFEZ0MnT456iseM?=
 =?us-ascii?Q?z/DEdtDB3t+4yD8IHI+x1XEQX93PF24o93ZowAg14hYnYBNl3d41hyoQ1MK7?=
 =?us-ascii?Q?CuoqxpWnq01jgVUasJan4SOLmT1xTqoN23cLXzkvRZ+l2yOxP4rghqm0Zb/V?=
 =?us-ascii?Q?Q6GA4MWB2/SkfxpabB/x0Gq4YWtwmL9NTwsiMhwk4FaR4RmAQNA21VaargAi?=
 =?us-ascii?Q?gFanahjVfjlGT5iuSDNmz8ixPTzKvWQYJQ80cK7VrHy0shD65Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:19:37.4542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298586bf-462e-479f-5bbf-08dc8fdc5bd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
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

On Tue, Jun 18, 2024 at 05:14:32PM -0400, Michael S. Tsirkin wrote:
> > @@ -306,8 +314,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >          }
> >
> >          /* Append the last RC -> ITS ID mapping */
> > -        if (next_range.input_base < 0xFFFF) {
> > -            next_range.id_count = 0xFFFF - next_range.input_base;
> > +        if (next_range.input_base < 0x10000) {
> > +            next_range.id_count = 0x10000 - next_range.input_base;
> >              g_array_append_val(its_idmaps, next_range);
> >          }
> 
> A change of logic here - I think the new one is right and old
> one was wrong, actually. Right?

Sorry, I don't quite follow that question...

Doesn't a patch correct an old wrong one to a new right one?

Thanks
Nicolin

