Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFD0C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 21:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgkK-0005aK-EP; Tue, 18 Jun 2024 17:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJgkJ-0005a7-Dc; Tue, 18 Jun 2024 17:52:07 -0400
Received: from mail-bn8nam11on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2414::608]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJgkH-0008WB-FN; Tue, 18 Jun 2024 17:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdrzUB9roF5m01wWdmEUx7CAGrjaju1Om8O+EqXzR6eyrCRnTnEh1mDKJNrN/useN/scxGIo4fdFtacRPG98W4p+nkcQWt/oRnbUzM+oG4RhWqaR5IGmQvGMg/I3DrfyTnsOzPWe2CDOsyxaRr8+jWLd79uc3gjqqKAm3lU814J/spnJOdPCEuBpfvaLoEFt1ZU8HHy+7JYj8+rwpoUV1x5RZG6qGmAM532kNySywY9v6fUp/D+lneYSqiHwyYuYeCB4wNZgsKNMldFLzw1clePXKQ4YPni8d34hLQxvX0w3pqSkdIIAfGJpU/7PAYBGLYuIps5H1SQky26sb8EzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/0SDm36BAvTMjEdHLB/E3MHLlDQWrhAjEMP0skpbbY=;
 b=GJ3O+7Zt+UF1eydmhhE4xklrbp4fk23bKSbjNjKrtwRKXozvWOfG+/EWmHsXAaVKzBy052AK17LtDeVAY7nwZgslYW/uun9YxaWkgIE2qmqw36/tt/OdxpKqxB2Cq0PtEJdoF9yLpr+/MG+MbfipJ4kWhheenFEq8+/xl/a8hSSM+J0DxgGf/nZ83QNT58hZww+33y8M7FczIdVVNNtPlkpuM4FJ3iUdKMAYMl1gIAr7gP8/1Vdv+w+mky6QJCt9cmDlU7UatXTW2hhyJ8xt7THGLjpWqz7tLf1IGCUj7JMez88NB8FAbXD70tIax9J3anRsEWjT9hO0wGgseUaPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/0SDm36BAvTMjEdHLB/E3MHLlDQWrhAjEMP0skpbbY=;
 b=ckCNoPB6ktfP37jZJDhtAiZ++9nLo1CsBboNg62CurSL8uKCV8z9EgOIoPYF0jxlssLYO5N2iUb02wyk22V8DHnXLGIyKMH8F9FExgXsVLw7NS18LOHjrvb+wNU7vDdS+YXUXryeDtJIoxfu8ZomgrxPyMr0TedR6+s2iAzqA+gJ8EZ4ematv759GfTUlCvG+vSwaTfaNqETYHl2jbcxtL6l2vauwCkK3sr5DVamTWo/kNSG2dWcXdYkYfpNaC7Ngp7kR+H+ByoYIMJGB+0VOb9NSkehaYHFSQP0FBTsim4Wz3wqWosghiXbGEGJ1pVR1noKv6lMIoCFLF9C5CH35g==
Received: from CH2PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:52::27)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Tue, 18 Jun
 2024 21:52:00 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::47) by CH2PR04CA0017.outlook.office365.com
 (2603:10b6:610:52::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 21:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 18 Jun 2024 21:51:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:51:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:51:43 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Jun 2024 14:51:43 -0700
Date: Tue, 18 Jun 2024 14:51:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <ZnIBbeITxG4ZRVVm@Asurada-Nvidia>
References: <20240618211110.922809-1-nicolinc@nvidia.com>
 <20240618171311-mutt-send-email-mst@kernel.org>
 <ZnH53Qaqp5+Xo1jo@Asurada-Nvidia>
 <20240618173233-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618173233-mutt-send-email-mst@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: db4cce3b-76cf-48fd-b4d3-08dc8fe0e1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dyvYtXd4G7Yy6x70qW4zKrkLpKyw6pGDnaCd8ntaz4IIK2NpyF0APn1Kw13b?=
 =?us-ascii?Q?EofC7v2cVHoDUkCgsPvoNAeiEqPczgz1KiPQ8cCXtqccX3f6kxdAXs6vfaYM?=
 =?us-ascii?Q?CZ1IceTUD2thLVF3dZtjDS70QQrc3JH/AtOvw8PDgqMyhYfdVW1eCITqKKIS?=
 =?us-ascii?Q?l/ugaknD7AA3dqmYqh1ouJiHv6iyfKUEN8wheLx/LcniZP1cDbLnLTdw5XF3?=
 =?us-ascii?Q?HwzgsLHkFBUL391CKsqBPq2iHaZiDp5+LQKkBes/DfXDGWtcnf0hPc/zPyZd?=
 =?us-ascii?Q?YwvNUsWQQl9XIeVRYm7gHcPurulQXua02YzFCzjvJlm0N/b3PefHhm3/hpTC?=
 =?us-ascii?Q?hXMo7IONuL/Dm3zeFYUHZa5UNTrmVMUXf2cAvRVS7og+dwmxQOkwFznJaIUp?=
 =?us-ascii?Q?czpgKKoTt8XojALEotBtEvLhnT5JauTgbGosRnq3qRhKkwrR9Y9qtEB7jLTu?=
 =?us-ascii?Q?ve5+YttV1/xEwRAQPKMVAH9JWCZDKC2LhpITuZkF6vz//7VHaBUyedl++zZ2?=
 =?us-ascii?Q?J7kO8o88mrtnVMOG5/BkZsIVdSW2wkDS0NRjA6XsxhsqO6EXg6lc1p/atevh?=
 =?us-ascii?Q?8buSg5A4cFAjcyKWAy9yIMEn6an1NgFcrXGS230U29P3Uj04vHu5DfDpoQOh?=
 =?us-ascii?Q?LYkPTwpDQPpZFc1Kkpdc3k4WtMTMHaom1EnyUhB0O/VUHJYzEZPbfqn31DNu?=
 =?us-ascii?Q?RX1ch47X+Z1j3qjNaXKAccZ8+tW3NubyxfHTD5nJi2Ap7AbG429fYTDLVH54?=
 =?us-ascii?Q?gJMa0Uw9BulpopIfQ7ePSj8UZhzcmOg7E6wjhFtdKBJElJfD9NLAekd3pTDx?=
 =?us-ascii?Q?3JIau7KyBW/FTs0NHGcKmm6MsvG5HzCXBEhQf5mHjMwZa6YLG6BQI1NHEFiG?=
 =?us-ascii?Q?orHFnuhRQMjKTKJxDjYTcdyfEAJITiHsbrp41JNOZZjJDPfeoPzunAIyx9MF?=
 =?us-ascii?Q?kNs7UIynFJe6O1/aGn05fJFagvAzFTOsWTUILRXR3AOcyLxMuYdEEGj43kq8?=
 =?us-ascii?Q?DfqexpXPD3xvfxU9ZuJ1D2oE+t5d2IpGb07Q9DxKMDoB9mA2bMiO6JdJLFJL?=
 =?us-ascii?Q?Bng+vezRzbD7fi2RAHx2yCL+b8UVxU/4tEBHNNfT2Z7Q9/7T825luM94AgVA?=
 =?us-ascii?Q?dbMwa5JRuHdc+2ufO8cBFQU1uWzuTpSq9VhyxqiE1J3vPp1yYUdQPAdtxWxF?=
 =?us-ascii?Q?vD83tbQG9UGO4RSb8jW0BW7cgp8KiJlYpl/N72eJIUk3VVyVN81HGa0jJ+Si?=
 =?us-ascii?Q?g8NOFOHRNQ0SIkKvVLk3/Ch5w/JQCpnVvJ2ILLv5mA8hvUUN753c4OEZYTQB?=
 =?us-ascii?Q?tSH1/HVTVG8Wq7esvfrw3sYl4VuzfoqLcvXUKNZnULPJzRz0Oh7OzXZCka/p?=
 =?us-ascii?Q?zazTb+aAECfiFRYGwl99gMbVoCbRNDLRtXhdaLVIJgACxTkUhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:51:59.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4cce3b-76cf-48fd-b4d3-08dc8fe0e1a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
Received-SPF: softfail client-ip=2a01:111:f403:2414::608;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Tue, Jun 18, 2024 at 05:34:21PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 18, 2024 at 02:19:25PM -0700, Nicolin Chen wrote:
> > On Tue, Jun 18, 2024 at 05:14:32PM -0400, Michael S. Tsirkin wrote:
> > > > @@ -306,8 +314,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > > >          }
> > > >
> > > >          /* Append the last RC -> ITS ID mapping */
> > > > -        if (next_range.input_base < 0xFFFF) {
> > > > -            next_range.id_count = 0xFFFF - next_range.input_base;
> > > > +        if (next_range.input_base < 0x10000) {
> > > > +            next_range.id_count = 0x10000 - next_range.input_base;
> > > >              g_array_append_val(its_idmaps, next_range);
> > > >          }
> > >
> > > A change of logic here - I think the new one is right and old
> > > one was wrong, actually. Right?
> >
> > Sorry, I don't quite follow that question...
> >
> > Doesn't a patch correct an old wrong one to a new right one?
> >
> > Thanks
> > Nicolin
> 
> 
> So if base is 0xFFFF what should happen? I think previously we
> skipped an entry and that is wrong. So that's another latent
> bug this patch fixes then?
> Worth documenting in the commit log too.

I had noticed that -- yes, ideally it should have been "<= 0xFFFF".
Yet, practically input_base can never be 0xFFFF as it's calculated:

hw/arm/virt-acpi-build.c:245:                .input_base = min_bus << 8,
hw/arm/virt-acpi-build.c:305:            next_range.input_base = idmap->input_base + idmap->id_count;

The first one always sets input_base to 0xXX00 (min_bus = 0xXX).
The second one, as we know for id_count, must be 0xZZ00 too since
input_base from the first place must be 0xXX00 and 0xYY00
hw/arm/virt-acpi-build.c:301:                next_range.id_count = idmap->input_base - next_range.input_base;

So, it's a case that could never be triggered? Probably not worth
highlighting IMOH...

Thanks
Nicolin

