Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D9EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 12:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWEFm-0005uV-3a; Tue, 23 Jul 2024 08:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1sWEFj-0005md-Tm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 08:04:23 -0400
Received: from mail-bn1nam02on2066.outbound.protection.outlook.com
 ([40.107.212.66] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1sWEFh-00013D-Js
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 08:04:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnGwTKz4j4p2HzvSOJNCnj41FT5jBPIURCdC3xFnBnBiZTnI4tbavOkZifZuYGeH58pBQrb/ZVzbZTUqizM4X5U6GGuyPujMOYtGVuDka/gjX4lHDQ5JC+90qa4x5kl8pfXiz8Lp9TzW1LJ3QWR9wk1oY7bliTxQtyGy1JXyeokKFdwCwrg3itPh661uyBV8Xbwj3JMkAzYPuY0QPkVT+lrwREiG9dMdq+/ZaGxuwybocKA1PfmvtFJUdVaRQAjrGm+BsMl8aDQr0YZMEAJIAKvihPgjMtn6G54cyJWXnr/VpoEpdLYD89MMvSKuJ7F1xcNdvP+inn9Qah3n2/Bvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCS4Rp8rp2UrCIu0TVUuTO7Sf1stz51T+FKWXxK7FC0=;
 b=NUoQnBfQi4/6X4Nu89GQnHvaUJHPZf0DL6rS7NzeII8Zlr3xuNXMro9fzfAbV04QHnAi7stCxLCgcufQFci2yKyGkMiE1jqT8KM+C6dvtc3jmuvqUt3Q8Cg8hAyj6S/a3D4D1s8Szx8Q3vY4kyuiubHfufo+rL2hUfueND/nJpEBXCle1eqPQddNioKGbPXfHUdSZ9fpMZq1BFL9+fwxWVFZUuNk1NFs8D5CdUbdfuv+YaUOBPocoBjXMmgCfp/L6TDKeaqHwcuvQKkK0bksA0rP88ePopj4Ye4CWk8A+7V5+zPuw/f3zvKUE/Xo7oICQDrVndo2o+BO7CRBGcFbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCS4Rp8rp2UrCIu0TVUuTO7Sf1stz51T+FKWXxK7FC0=;
 b=NcNcwEOOzYLa05tNdARthWAaNQfnj2HN6Xa4s978OG7JcQwvcF7KZxax6RkB0l6hRSlSjQ3irEjsnIfvT5ZaAbhRBmXqh+MAAvoS96lX0O2xcBc23hOOXinKGhsngaVpkXT3H+RjMNkMkBk4nde8qQs12L4RWWGBkTCFSIa8RqAZcn+420ukPGosnmnPxbAJ0V4/z+U6+ziHYJ7ZrfpUP4OQOQeoNg557gSfeqnRDV0DiRbKts6ABEOMG6UCiCZ43aqPyTJaLKdVIZA5nM4XuGWJh6OFdjxSYWDvN5uLii65OJpPajJSs/9rOV5aEyuYkcYHEq5nUMXL/0DpzBecmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Tue, 23 Jul
 2024 11:59:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:59:07 +0000
Date: Tue, 23 Jul 2024 08:59:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Message-ID: <20240723115905.GL3371438@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
 <2fd72e9b-c3b1-488c-a532-546ddf3612e0@redhat.com>
 <832a6eab-1f63-411c-a827-018b12264513@oracle.com>
 <9245593d-4347-422d-8cd1-d1e694e93562@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9245593d-4347-422d-8cd1-d1e694e93562@redhat.com>
X-ClientProxiedBy: MN2PR20CA0057.namprd20.prod.outlook.com
 (2603:10b6:208:235::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cacf804-5127-48d5-eec4-08dcab0edaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W7l5A5NztZE3pgkBYtxLasCMRfR+LVD1rT+0y3uiBKhADu0TAik4BIDAfnD6?=
 =?us-ascii?Q?hR8vczrBNpPy3C/RRONV5gS8bDKl+Kg9NKOC7NDNpjeDAVR2WFbW+g5VQ8YG?=
 =?us-ascii?Q?V80cu0IXiAWZVs9FRS/U2X0g4cbW+l+j1b1emOlKClkQV9YQ524UJxbw/V5n?=
 =?us-ascii?Q?C6JxjFxi+maHMxeM+G1m1R+uCyuJ7Es9xtzokzhCX0lHNMRIXThxgWQ0Gin+?=
 =?us-ascii?Q?oQtTHb/rKYIOjY5dldQ5dDvt9D6qCPDhc2W4OVddU7Bv44PfgS+4jqWwJZFz?=
 =?us-ascii?Q?6Rqh4w6W6bisVGSnOkjsDziuVFA6ZTrrLTY3UYD7j2lTT66BGIjaexs9B+To?=
 =?us-ascii?Q?rfueyM+3bQ98ugrq1hDGEmtQsUcQNO7rWkQQV1IIJyPRoPJly6+LuTqegeWF?=
 =?us-ascii?Q?YwAiLVwW4ht6nQLsCO7Zj489xcGrU3KLKPbGRQlAISmouOS1AvjhoDDNyS/r?=
 =?us-ascii?Q?jbY9TArqk3H4VP3LVhFM8Knfm+RwAmiJiXjmOSYp5ZmkdPnYwzQtn5Pbc/3H?=
 =?us-ascii?Q?zZfPmxG1RKVOnyF27Mr7FHJcZFzY4rNlCeUWD3aAWkHvYa1edWkV6zqOueT2?=
 =?us-ascii?Q?IOF+jbaRS8MN+AC2lBZNXQD8oL5RusZq0VTRq5NAn/DOo96n03ivxXmq7HYn?=
 =?us-ascii?Q?BnBwunKfOh5nVDJd60MUpdKIGG7yVwcjg6zmf2zpxCLeCtuBq6+dMoobyepH?=
 =?us-ascii?Q?yXjaxSmScQdfcAFNM6S8vsQGA8BEnldU6y9I3PijT3ovl5TQ93GgM/e8ZkB5?=
 =?us-ascii?Q?iGcTGAKQLc21gqla3F4tZoGLZeXc8uXJ87fiUqYCuGwzZmzxKibD4arFvt7e?=
 =?us-ascii?Q?v95cisD9lJxm0e2CuEIy7z7YH8JhOpCJuF228zWLOEXFTCt0xxvZkuC/qH26?=
 =?us-ascii?Q?oRdPZ2/1ouQNA/QtUmcO3Cl0r8WucFwcVxXwDPLV5k0jVspBVfJMkuEzMHQ1?=
 =?us-ascii?Q?Cizat05ed392a921Thk/CE/wskjJ53gSrQQn6XeCR45INtBaT5zTXj8l0c6o?=
 =?us-ascii?Q?2Ftnbz3D1PBXSJdxKhpK01jr9RArWMOV8qDTHBJaDCQLIxQOkN+/XKMjSxbx?=
 =?us-ascii?Q?/RYdU7JTAOFGSPMUscubCA5ZjJUfvA3t24BEbao44nHnAV6RA6/nvRQvxcNd?=
 =?us-ascii?Q?zfmlkO7yZq2oX1YhXaFWuewx3FVw/HXUJbNHXTqvy5y/LZmyXx39vzA+5J0k?=
 =?us-ascii?Q?ycvY3JV9NN5wvTDeERFEPFgIQuKQGD0i+y/qRqgpz+IRMyMlZFlAe4naebZV?=
 =?us-ascii?Q?I/hSj0Yu4RXANSpXEb2pMnMZ2rcHowB4kby9a2G4VWfUNbLg6GBVL049mdww?=
 =?us-ascii?Q?jaLiBKpIHYzrU2+XOzO9THfmP1gwc8KDZP+GeztEm1Jk2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BxKwZxgiVVhQawefUjLp9Ca8PWXi8AOrI+4a/kB01ssKDjCXd2z/npgsXo2m?=
 =?us-ascii?Q?YnPY7vNan7Ez1JnUGQ7pJr8M2jew+8LeOuDI0AGHb0cLfWzDBfq0+skUSsra?=
 =?us-ascii?Q?F/a4ueer26Ge+ntCBfxWvMyqrHjYS7ESDjUavJKdto3OvqJakEloM0ENjlgh?=
 =?us-ascii?Q?kM6KxRFdPxzNUYuapgfCUBLfp9D/Ksffor1bjsHgxBPz5bIs+Vim7eEwIWai?=
 =?us-ascii?Q?Ir7A/iCphVCuPyyPUIyl/WGCBXrFsI2CgsLtcBRWyqQYvJPZprOComWRTukt?=
 =?us-ascii?Q?XqtPF9FsQiM8JEtoReXoiaI6OXXUqwFRZ/9tw0mRKM2TZXZGFOnmfyO49pOd?=
 =?us-ascii?Q?eS304UVdYbK8EA1WKfpGo91sxNo040iufrFmb2acjiXzfg2n0wTsEF9sANTC?=
 =?us-ascii?Q?LAMbIyV5D69MtahjhQ71CZHJQ4TQ/GNbdSB2eiO7lcROYq3nUPqf35utHpM3?=
 =?us-ascii?Q?zXkM0/q1Tq8QjZm2vOe9NC0IvIBANZUSCd8s8Ct6zNKYli6AdaZ4fjbKy3ui?=
 =?us-ascii?Q?mlRNBgbgMcVm1JCCuH8PLqAfwHrBTsaFfNZ+m/BqCc24y9nd/JnJE5sTt3PJ?=
 =?us-ascii?Q?kMqLoO30xoFAuolKjfF9L+BXv7OKyEPAgk9xyarwAZzQ3oeMNklsxXIb/Tdt?=
 =?us-ascii?Q?U+hbS0wcJLnzYUT4xRLQ1vtV81IE/EWcqa2a/IAgO1skZAsD36vOZQ9clKQQ?=
 =?us-ascii?Q?lBObGP+PANMgwLP/QLznripuVjXspI0VLrpwOXxmxDCxSOhzfOdXX8qPMiEx?=
 =?us-ascii?Q?ovWqZ2ERn8eveYTXBp66FZNetu1JhoN9/O/LuMZonsdardhD+oH1R2GTZqCx?=
 =?us-ascii?Q?6Rd3J+yXsYW0WZmluNBCCN/cADK1ae2/6FFqNETSN0CVj18FBWu6DAKyq04O?=
 =?us-ascii?Q?pVb0o8bTbrwCz3EZKfktcWKI9hKBngL1Sz9DtgO6aZVg6HZFoDWjtlYrIHkb?=
 =?us-ascii?Q?JdUXeoesUA7aJr0xIUInHK4Vk06Ih8gybiAEZkURNG1OYcNIzHpKNpKzmj4Q?=
 =?us-ascii?Q?3ObgDWKjykIz2h588Nie988nS2TtJEQ9MWRdbHm7tIPzyWSvVCv2/IhBnShR?=
 =?us-ascii?Q?rzEDL/JEvBiw7TzS1KWwDSI04v17OKeugx8LG/+7LWaCQH7Lx1J7wB/IpsgN?=
 =?us-ascii?Q?2uhonsEaepeKfQAojFjYIg1oV6cP0eqaLG88KzNZlhbrltiPAZW4tEw02+Zh?=
 =?us-ascii?Q?ivzzgRt2WlRAxd3VU+MCzCD19QCiKD4ffOdlxqHmZpPwbjjqv4aGREa1p4Qh?=
 =?us-ascii?Q?32dG+DOzzbMV6/ZsmYkgMPICnhZLT13SKQBSUAS+nKOiY0WteUCqflpjeER6?=
 =?us-ascii?Q?i+a4gOvRs3BU+p7atsBmhG6ye/oAsQ8Zct9vxEvvBDMNPUUooaFkPpfvQaus?=
 =?us-ascii?Q?W221wMtglXFPAbnkqU9xMAyL5HYQwnvroEQ/ltg1HT69uByFy76Lruqi1Qqm?=
 =?us-ascii?Q?thbldC97jhiqCxy2HTCYseHo0sUU/qJNlxuZZE0tbaWkGYPgkcz27iDpJbbM?=
 =?us-ascii?Q?vGMqGm3I6XDIu1D3HtXx8s4aU2GefEPWd0WNTHNIB+PktnANjkR7ICx5ezsl?=
 =?us-ascii?Q?M6DXqbLXlWdnlc3w+Gg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cacf804-5127-48d5-eec4-08dcab0edaec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 11:59:07.1889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvf41DvqKjdwF/bamJO+35Pyg1StYJ066/yXphpEhtSAlLyHqRU+ToJ8tYO9pvFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
Received-SPF: softfail client-ip=40.107.212.66; envelope-from=jgg@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Jul 23, 2024 at 10:09:13AM +0200, Eric Auger wrote:
> > In pratice I don't know if such HW platforms even exist where different IOMMU
> > instances present different value of dirty tracking, given that this is a IOMMU
> > feature, rather than endpoint dependent. In x86 it's homogeneous, and likely on
> > smmuv3 server too. There are indeed endpoint related features
> > which may be

> on ARM you may have several SMMU instances. I do agree that the
> likelyhood of those instances having heterogeneous dirty page
> tracking support is low but well I don't know. Maybe we should add a
> wanrning at least, later on if this case arises.

From what I understand about ARM IP there are additional system wide
complexities to implement HTTU, it requires the SMMU have CPU coherent
atomics, which means it has to use a different kind of bus.. 

Hopefully nobody does this, but still, I wouldn't assume the same
consistency as x86...

Jason

