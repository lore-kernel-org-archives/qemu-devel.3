Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA00EC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sREVA-0002mg-AP; Tue, 09 Jul 2024 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sREV7-0002jF-Ec; Tue, 09 Jul 2024 13:19:37 -0400
Received: from mail-sn1nam02on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::61c]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sREV5-0001yy-92; Tue, 09 Jul 2024 13:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTlO+Da0VjW7AAsxklt3HeRQUNgXygvRcbAE/W/JpgvdXolbe9JJET/znAe4iOzZ3LWJPjZgzzy36S6OmNaVM4FLaT3EmstUBHal+1aBjmA1XYyAUk2H2qy7d5em7JeDZ/2ztt/x5Qt13Ps2czXVXnz5dcCwPtabQhpSLmmoyla3idZJq/rqFp/tP3/T8TPiZPNvrbH778Pvjke8/JKokVVyQLHTOXRChd1DXrWTdEYc2ULc1cIsotYzqeyJ47GXP0ZaIaze75tv1WtybgcPIG8NJzGA/rqkc500oS669fxZ4R2m3LlLTnmBOwPxB+3fk3six72+c2Ltyl4YpTFkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBZXQAUefubBhnfLzMOOjjWGKZj1+iUT6Gpqg/a6bP4=;
 b=akRPR6Knd9WpywUECw3RbqmCL108hlyzsPyrwHc/7m5L8vx64kROmBhRi/JaVwHIZvuVajr3aUZhpq8AFuA8HYZLGghhaG/H1nAsVTdnc2uXFut+QBVPvgfVXueaf+tWdmV/uKm8i4wN5jk2sGI/7eBcHKqfyVDbRnCOWaTblBEyj6CZ6xwgpM1TtC7T53A3aKaZJ5wQ0bdZYaR5atL8JF8r3FPNN8eXRXmBofslbMt5iSLic13MzsdBG6U1SdtQJscRjeNAU97B++Qmj4EDyQBwC/j8RiOMDEj04Dl2hz+c1c31J1Q/RttDP7+GrDeK8nIj84BJfttOjIrW2jRDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBZXQAUefubBhnfLzMOOjjWGKZj1+iUT6Gpqg/a6bP4=;
 b=aVMyFwQ9Bl4TA853+NV68nOqZ8rgStBWeUOXmlSn2fwtW/WoaM6UYhFdOSStdNlymJlI8ErMd6iCBdEUa9BbnXWNjGExXeZckZ1bRbnXQxMX8Z/4o+cPEFfsFlstwh3yBfMrnKq+uBAA6QFs8i4YRW6klkqb1sEYdy+x3DP6wK9jESGuZWnxhuNO4rEEiAgLlcrpRyKbcLz2zpyNpPx5WjLJ1v2Oc8PXTTOC4g5tz48weUSlrslHH6SSjIym+bTBg4nwBxtz3Ev+iAc7hCiw1VR2296+e/i3MK/pU+71OEcBjswArlw7EeCSiznvhLFiSk/ApPqP0lCkAvaocbfF/w==
Received: from BY3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:254::32)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 17:19:27 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:254:cafe::70) by BY3PR05CA0027.outlook.office365.com
 (2603:10b6:a03:254::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 17:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.1 via Frontend Transport; Tue, 9 Jul 2024 17:19:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 10:19:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 10:19:02 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 10:19:01 -0700
Date: Tue, 9 Jul 2024 10:18:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>
CC: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <peterx@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: Re: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-machine
Message-ID: <Zo1xA9B8L3qLyGQO@Asurada-Nvidia>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <df22fcd43e201fea97da8862b61614a2986ffa5e.1719361174.git.nicolinc@nvidia.com>
 <efec2974-ce96-4cb1-a00c-30fe93c5fa7b@redhat.com>
 <Zo1sblmS9+xlWObT@Asurada-Nvidia>
 <af440fe7-faf7-43a4-9f04-9d0059ef7e90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af440fe7-faf7-43a4-9f04-9d0059ef7e90@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfcd287-79f0-47c6-ea0b-08dca03b494e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XytSNy34TOYHLv7LgVjfnCwtiqmAbyDqwwDhoq9dbl5BblUivKqyI4rMWAkv?=
 =?us-ascii?Q?HWMBnRgv51TGLSR1polDhkhCL2778cWfhAXEoDTMqyZCyYyYY2d+kyP82yS8?=
 =?us-ascii?Q?OLUigxhEA/1QK0z8PQ8s9eHSuHUc557ry3hl7ob5g0/Zchsc5sJIr31HyppI?=
 =?us-ascii?Q?8U+5U4Jm20T0u4Ph0dLl5Flq4gflFbi2cSTEj1mCzZZYDoiDdceQYLEvvD6U?=
 =?us-ascii?Q?sS1D1eKIH5StCBvHfXuk61h05sVIaddVIdAFYL3QVTzGTvGTE17+zq/bE3yn?=
 =?us-ascii?Q?J/Mip6lN5jKXt2i+C7X1XbGGU4gZzKL/iFaNghuqwTpgCeArTGva/lJaI+Hb?=
 =?us-ascii?Q?j8CgFH3v4n8RTglNrMKIt9xbecGW5Ok+UBT5oqp1okd9jy1u0Cwb1w3m+u7/?=
 =?us-ascii?Q?qCeqi/BJz4HQCbwUfbXJ8wtwfmGspCEMGRkKCgz1FKDT4FdBVOR3v5KHdYrx?=
 =?us-ascii?Q?avEXU6zU000lqkEgvGAlJU37AvF50Xp1A5xGG5w8ll/tnfK0Su5S3dqwaLk5?=
 =?us-ascii?Q?9yJXCZ6vpKN+K73qCQV5DX+YSU5UIHfD2aWMzAzHDikD0Zdki5ktOEcFRl+J?=
 =?us-ascii?Q?4mJT5D8hOp84W8bfDGRrtVX7MKuJc3Rsz3wQpdYtdpvajYIfb1t5VzG9mdJ8?=
 =?us-ascii?Q?K2Q1u8IkvBNPSuWAMOD0BnFB18cv2sZef7qZS9VhTGwYSRPDZsAo+8h/FbZg?=
 =?us-ascii?Q?iNfbMwXIfAuQc4yC7ffVRIvry39uLg80e1U5604QK9Bg6f1TtgX9fMYyuT07?=
 =?us-ascii?Q?zWbsDHgo0Pm0qSlRa6oFVAD1ct86jrpkwPIJEPeRXp/DjBqO/vPmJj9s5F1B?=
 =?us-ascii?Q?BbwwdywWmLJAaZ0gRq0em4mjk40bN9/spJ+1fnvqA3CvqMGdWlgmpQW86A4V?=
 =?us-ascii?Q?IL1qVD4fV099F699kf8MwnvgBDBaddWZqFbhmMY6BZHtSCJzSkVFtVN4uKys?=
 =?us-ascii?Q?ar/kD1fimTZtvW8lIkib2HoqDSbm7nNmbr670bLfsVHl/p/ICqpTa0qosk0y?=
 =?us-ascii?Q?6AkwX9HGbrJ9mAKUUedoAhEhZsTgBTGo7Na+9JTs+9zpflSUhEHnwEdJ5vhu?=
 =?us-ascii?Q?Jt4DR5vekKXFmlXxU6cEQFCL8gxZqyN7MkfGpmv4rlJ+BCXMIpsFsgJLFmx5?=
 =?us-ascii?Q?bi5dxPnPVoZT2ezUUMRjd+GlO1SN1lzyKBxGf5ahwrnCIGgv5MxV29uAhYx9?=
 =?us-ascii?Q?FE+5XcCsE2aTN0tI/7dnM4sK/0bkKg9iwt2LGEZgqiHKXCZbsFIWjJIKX+8d?=
 =?us-ascii?Q?HhtgkQJOtgZ4PGa1pJrMHtREe73Z+neIPLBtxV3wAUNKvP3eOdC6S127Bxjk?=
 =?us-ascii?Q?wSHtu7MjtRrvZ9IdHcTrzQH7YdLxwHnZIEQ57EeQbgN0QnbzOaj8Nkb59azf?=
 =?us-ascii?Q?SGnQrL5yTm7XXVtV+DZIXzJhRRp9aZFtR2Hac5xnUN3LVCoaHVF3flx6ZOfG?=
 =?us-ascii?Q?L3cy6ktMFYaI/2cNvG1ew/A0s4xo1Enh?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:19:27.1940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfcd287-79f0-47c6-ea0b-08dca03b494e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::61c;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Jul 09, 2024 at 07:06:50PM +0200, Eric Auger wrote:
> On 7/9/24 18:59, Nicolin Chen wrote:
> > Hi Eric,
> >
> > Thanks for the comments!
> >
> > On Tue, Jul 09, 2024 at 11:11:56AM +0200, Eric Auger wrote:
> >> On 6/26/24 02:28, Nicolin Chen wrote:
> >>> A nested SMMU must use iommufd ioctls to communicate with the host-level
> >>> SMMU instance for 2-stage translation support. Add an iommufd link to the
> >>> ARM virt-machine, allowing QEMU command to pass in an iommufd object.
> >> If I am not wrong vfio devices are allowed to use different iommufd's
> >> (although there is no real benefice). So this command line wouldn't
> >> match with that option.
> > I think Jason's remarks highlighted that FD should be one per VM:
> > https://lore.kernel.org/qemu-devel/20240503141024.GE3341011@nvidia.com/
> OK I thought this was still envisionned althought not really meaningful.
> By the way, please add Yi and Zhenzhong in cc since thre problematics
> are connected I think.

Yea.

Yi/Zhenzhong, would you please shed some light on forwarding an
iommufd handler to the intel_iommu code? IIRC, we did that at the
beginning but removed it later?

> >> Also while reading the commit msg it is not clear with the iommufd is
> >> needed in the machine whereas the vfio iommufd BE generally calls those
> >> ioctls.
> > I think I forgot to revisit it. Both intel_iommu and smmu-common
> > used to call iommufd_backend_connect() for counting, so there was
> > a need to pass in the same iommufd handler to the viommu driver.
> > For SMMU, since it is created in the virt code, we had to pass in
> > with this patch.
> >
> > That being said, it looks like intel_iommu had removed that. So,
> > likely we don't need an extra user counting for SMMU too.
> OK at least it deserves some explanation about the "why"

Yes, I agree that the commit message isn't good enough.

Thanks
Nicolin

