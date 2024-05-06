Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB407C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xHH-0005Je-1u; Mon, 06 May 2024 08:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1s3xH7-0005EO-VQ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:16:59 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1s3xH3-0006tD-Mw
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imqeize+YkEsROjdOpp4Qr28qZCj1G2ZVQ5ULMANNq7d14dLNWWO9GUhTO7LJMDjMnaaVTh/A7Fk5zQQSshnyfsf6cl388rGi/ZceriCoxujP5N2tD2t61mu21Iv4+/zxKO1tsOqCjyozrbw7xXSNEYxy2vvLRGKffPq/tHHv8MaNqKr7FY5OmtwrMc1AIxVmKtAYd8rC3lDFW7+QK5ZA1eQtS5sEYPpcZBXyXpNEc2jshCavjC6X1m1ninPkHViXZfG2yLV+VbexgiwLT6V1RLswWme4+Mxh8frcqmD4NHJzsB+Yh5a/mOunq6AW4Gj7vyW4H66dBDRh92zF0Y7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DnXuexr0LePGfk7OD7FEW5M8laEtUULs/4mYS/qURo=;
 b=MBsaC26KY7+G/e+Qanmzq40i4QFmux9XBoiQNsopa2vNhL8XC9J+L8mLx0densxt0Gr2h1IwBxOHSFDRJSjY4Mm1VpqBzNvWXZnqaLiY6FBJGAckW1QiAwpXQg5S2MSbYw7lM4vyz0WGXDPEjzyqr11bIsmS1mnMv/FFSPLfX99DRhmgL9S28LN+7Z28wMVP5PagElSxpf/5q//7CmbjvV4LmY2LV0OaqUmnxgbc72IeQn6QaeJQvHRenPd88XGcI+M+7pJd2EZ7GtSEjI+pyj2PXFgoQr6HVBjiDolEJMN51EksQ/qU89FQNEO+HRXaUuKY9dPALMSHsfNZoN3ZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DnXuexr0LePGfk7OD7FEW5M8laEtUULs/4mYS/qURo=;
 b=gxtJta8CmY1IcXVCFxvioLxLoamkifRv2Rcd+PWyAOAz6B5vrunmbcem8RjUGKhYpk8FoBsNqpp6j8J50FGcETzMtEPGPXLGBPnGJRaMLOZX9lbjPAZD4LisFziNmCI0ddWLexSBv/cOCDAxiT+HdFoeJg3/zIoFfcb6mMlNXrTaqgnd9BNYzb1oxyEqQncDmdHITZcoC4GMvdktillxbOn/bbDBskNAmdyKkIfbxusHwtfb7KkFOMko7oPEaVEkw6P1sZJ91tm5J3bIN0zFnCGkW1wPr93RxtYqO6viLQcSOqfYSFgzFoYzytFIFruwlTwTT0PZcBYW071SW6KbVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Mon, 6 May
 2024 12:05:42 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 12:05:42 +0000
Date: Mon, 6 May 2024 09:05:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Message-ID: <20240506120541.GG3341011@nvidia.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
 <SJ0PR11MB6744A435E58FC69DF37AA148921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744A435E58FC69DF37AA148921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-ClientProxiedBy: SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: a68c02ae-70a4-47b3-7649-08dc6dc4da69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6FH8MTsUz7Lt4A+4wSRbVpgxi9mrNqEAYwVqG6Px9cn533lQYvDhJjx+diHP?=
 =?us-ascii?Q?tF8g1OgZ25zfgMpD1Cjn8EKamJtllGa6dHUlp7ARO3Xm+tYYdG4bUiv93QqY?=
 =?us-ascii?Q?QnI4p0dhXEtTj8XokztLR14Hrrq1ROoBkHoGNwZGZMfbuk3rsPkj7EoC+k4i?=
 =?us-ascii?Q?CHD0XxSw18hoKvzMXjdvr/qquJn3By0ypfx/6iUpr6zTmnJvzEQUFOMLWaq5?=
 =?us-ascii?Q?o3EoB5MjWD2PRWhOxjpBe3kA8cWiZh5i5vIkjVZN5km12Wmji6T156b09XjV?=
 =?us-ascii?Q?qi24D+3sk9u6YTyWWgst/OEdwf/SO4vp3WK+dZkU8I0n78yh9+NI8rpFv310?=
 =?us-ascii?Q?jmazAvXoxyWyPm//dhnzxxuZkPmph2UmGwUOlrdMsqxhxGKkICyRA5nlnk2r?=
 =?us-ascii?Q?v5t+ysDSQgMVTlgmiByAt96WgAk3iFqr419FyNUE5rUxsvOa/SGQYVWA4OMC?=
 =?us-ascii?Q?apwO1zzW842do2ogh6kSN+/pI0Yin/+YvklCgcvMx9dZX9SKHQwGBoK5tKrM?=
 =?us-ascii?Q?VXHLDjJhiOM5LZekSZsanbT9Qscy6f9N7x9rSuM69PM4THZ/0D/6ui4JCAeO?=
 =?us-ascii?Q?yI4cevwBFTcoITqDqQvRp0Httrw1W9XsqTkvXvFD+yVUXsGHgRAhP+a3ygYl?=
 =?us-ascii?Q?sTkqarkIgSIRwLTxsSbNXcTG8MBBBqykkeLKnipQLmE5wa64f3uOT85BMOsu?=
 =?us-ascii?Q?mMUB/M1ZviAMHQT5qcYEUkat4zxySarCaMFzkz/8ulHL9BZRFTrmk9WnAo5n?=
 =?us-ascii?Q?ppIJPAdlUQMHOZSJstBBp62o4Fy+c+JL0NwNrtOReg0jzgh8HD4yII4ynMBm?=
 =?us-ascii?Q?Vu7iVJC3v7oQQkkEuPWKcqA/L1+1dlQ68zAA29h6Z2qyKZUI/IFDBujWFqgy?=
 =?us-ascii?Q?5z0NtqffWys1lGTw+PHgi68tUWKJxpbBIzzb2l5cqM71ArQjeZBeHJOKikX/?=
 =?us-ascii?Q?zqewVM4cOiQlO7osuSY0ojan6tuRoI16qUAm2VpVfFL+UVmBph9wArDVKv1W?=
 =?us-ascii?Q?FPcV1MOXXPz7ph2Vo1Ahauqi7qj2rhgJxZdv0Omk2vpo3YsfwhrfVdxmX5lm?=
 =?us-ascii?Q?QXSPJULxkYttgODwbGDeKYTZggW2ZooJ3TPp5im9CfI7y5RIHOef0huVu1bt?=
 =?us-ascii?Q?17AZ4O5Atu33b0Bg0j9cd/Wgn9F1s6X75o8tLpTwjLNuPjaB4C3kXA3qF0l+?=
 =?us-ascii?Q?Mifv0ZXL5NvyI35V3ms4wmdTFqQMUm3Ec/Ciiqp/LEB/fGIoI4MkuDf6wbkI?=
 =?us-ascii?Q?MAsuoKL4CbGckV6+Jry0VuralkEXxOhtr5pQ7NYZMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vB/p1Ky4tyfHbp18LXpycV/13aZzd9cvrc+FC1XmzF6B4mzmmKLzvG5mQMeA?=
 =?us-ascii?Q?y8OvyKekoctH/Oa0N4usy6et0zo3Canp8duQgT/1ElbTcd5kL+Ia6CSD/tLt?=
 =?us-ascii?Q?FsMjKWAJI40BmBkXZvqLV1LdThXDzZn7CLM8KeHT2vjAhULEbzV0OXNx/y5W?=
 =?us-ascii?Q?dIwfTxNKRcDtVr0CaWnFFv13esyGYhb84k5E831DwrVx1xr+j8a3uFMoScjx?=
 =?us-ascii?Q?z66INj/5jco8a4xAnNykAlqM8iJkG/7pgq6gbRDQQUmisWC9wGCqdJGOh1i/?=
 =?us-ascii?Q?w/vQDGjuOXeJzCEsCH5FICIxpFLDg1XANDZ2D/V9wFF+Yu0rc7fPl+3MFa2C?=
 =?us-ascii?Q?tcA0SZrv7DgbamP4W22f706tOcre+9eS3JZfnRTcU86jXTDtRoT/7fa4Gqq2?=
 =?us-ascii?Q?7O0FnUuGOdZG6yrBh/vFVM1isb+WkhwPAOEudg/rTlE7cWVTuHzj+HROlwaz?=
 =?us-ascii?Q?9tuBa65QRqP99kiwZ+QrUGrcCtsZa2eJzP+O68KYB9LsmrpoXil5DF+vMLlR?=
 =?us-ascii?Q?ym4cUuRspOyZryVjonvqZVXPC1jErJ1n+56gqwItSJemIoxHk/H6ciHTzfGb?=
 =?us-ascii?Q?oihK+Rfg9LmusAeazsfSK2nN/tGXM/v5kqD6HycJeUgeDoecm/WwKu0ZjUuo?=
 =?us-ascii?Q?b3IWCPzc/i9yEEBXgm5eH6WKpTPMmcUwapQGlxZyT3B9cqvZOTuLrXC0+6R8?=
 =?us-ascii?Q?LPg4CZgfbW/1Mgwb8agpAbtAN7DblAR3XlhEUWhwQNJpNvWHuj5cEii6IO3Y?=
 =?us-ascii?Q?/ME1Wy4a+9PaElqKE2dxjBJSj04c8sMetiM9NF5YILh6ZMnOKFjhFpWKAZgL?=
 =?us-ascii?Q?XNqiSsM4Yxy3jEvN7+Ij/ncRGv7jGfGnWMj0OJSTN9o/rfhvZLzGWozyZZMf?=
 =?us-ascii?Q?L7vwTc5KwUjUFjdchgWnSrbAAcawEvkBBaSUvXF6iezeIjYaGo6amOeecoRl?=
 =?us-ascii?Q?4GHe+9s89a06Ff6k3wDPZHCD4C10+pj3mYqRvCa7KHSs1alvNuiSathTCpQm?=
 =?us-ascii?Q?VAc755MNSWpT8YwZcbjfvkl+jnzRn/PFYPMSpybJX834i1PZAXzzaztaHBiQ?=
 =?us-ascii?Q?eBgZHoqFx1MUiXHKjO9GMVWwC8Opy7rCfsIP0KZvGoBncV54mEZAOfpwRMX/?=
 =?us-ascii?Q?L7U+6hxZyC+6Vu6oj4OtIL3QYPljbemWmGmMpTE1GtH/kZQtPpMP4UOyn9pP?=
 =?us-ascii?Q?G1CTlEtKUB0LqJAmPI8R/LFQ2au/PrRfuVd57RquYceIrBQiOgb1dWdgVq6s?=
 =?us-ascii?Q?VrmzKWhZLiK/6moqYP3HcYEDhOWO7n0erxn6wTcvfItRbzt4mLud4RgHaT2j?=
 =?us-ascii?Q?Ujt4w+tMAhFO60dZ4RGtFA7PjsztbyW6rjW75uIYS62o668hSCvxsvXsiiNG?=
 =?us-ascii?Q?KAieL9Cex3WnC64NPxHoYLkKe88dUyrEnzdXrFkEfeF57qGp55yPEzu/sh7R?=
 =?us-ascii?Q?uXGM90a7uyAw5fCD2AlGVFOzWbHPw7asj5gXYE5NCNVFLoZiTfRGRuyq+RCt?=
 =?us-ascii?Q?HJdRDR51Cddwp2wA+ai5Nm7Sata7xPsYJH2NhhwtMWR/1WpOHdqGYGBGQEir?=
 =?us-ascii?Q?Do6XGSeEYRnwZQceeLs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68c02ae-70a4-47b3-7649-08dc6dc4da69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 12:05:42.6429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1MrfDPWyHnad+axgCIVzf8/KyiWmgB2OJQID/cCHrBfZE1GLmT7sTvzSzFavku4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
Received-SPF: softfail client-ip=2a01:111:f403:2414::601;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Mon, May 06, 2024 at 02:30:47AM +0000, Duan, Zhenzhong wrote:

> I'm not clear how useful multiple iommufd instances support are.
> One possible benefit is for security? It may bring a slightly fine-grained
> isolation in kernel.

No. I don't think there is any usecase, it is only harmful.

Jason

