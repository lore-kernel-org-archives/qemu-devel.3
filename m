Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7932ECAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 19:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyxRt-0007Cq-CQ; Wed, 17 Sep 2025 15:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uyxRr-0007Bw-I4; Wed, 17 Sep 2025 15:04:11 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uyxRq-0000VT-01; Wed, 17 Sep 2025 15:04:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zca+1AJYLKY+QadoNbFTSnewOed9mSZsF0QquMTnvD/Q99C92FdZqKewc9TIAfEI0uIv2uRszh4CS6/Bt0hRQ6/6q5CSlevWqUw9lf1vtsUhy+D77OIatHN8aUZwUQsg9bWaV0NOmONlPUdEpm/GWh+M3dQI1s3EhyqCiuJXlAH6+61MuNOOuvUhIXzyGDTj0ZHjxUsQ9KLsPE4682QKjJ6+o0/mtemS9ZrXs3RhKEHjBxKxKCj0bxIraHbTyqTa83c7jApuulqqghNuHnGhFJZLywtfcIP8FbCdFX7CVWud/AauOEdIOkIk0qLof3MSJ1zHKa0v6lexFw7i9pfHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTUN8Cv7I0UkXtesMlXwS/aykqwLpT0q/D9IQ6mrvA0=;
 b=WYiaxFk0RMdOkYUfE3JivnvkkAVhZzLjjFobsohaOh7Q/vZWNOiEOBDfi1JqEiUwDad81CKM/8Gt3YwwYC+hPeYKsYOfaUCbAuw6E+nGByvDLWY/06BLyhJAYDcThb9SdSDUJXGr3JwSponnymiyDF60jx9WJeW3Zvn7gG64QLDoXpvPg6bZlt/kNKxwOUe0O0JzODPsOK2ikO2A6yjHPEcWmpZka8V/Tl5OCdVss/GcEjip64IkRQrbCkIs2ct6ikBpgJcHqNjTOi7hO57Dn/b/PlBn+sdPEhDkO7DE6CwLtpd4Wdh57CfZmAoyuwqvlT1wTJ7YhhJvidXeJSUSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTUN8Cv7I0UkXtesMlXwS/aykqwLpT0q/D9IQ6mrvA0=;
 b=SgHcSu3chvjyCcPPBd5xRz9l8NiIJDzI6bZw9GlFM8hw6/OUVSyVTVjz3AVDZbP6qUohA2BQht1LY+FdvSWzOJ+lfNbj3vh/4PdBPJGY+D4s2WqDy2cGOwBwaBimKnLS4V/xCdeSAIZWEaawdsJzuUBUrbQzIu00asyfRUW1IsJug7dfCgaMOMbhY4yBW35VHUamfZa5YmG9W+cHb9QwCU177rC06ogRJnHA/7NU8//qzQzPsaHBl/Q2+kRdbLDW/iseso1EVXDeJlV0m2JLOv1jtgj8RXN58ZROQfGP2EwI+QJu5tUX2Rj7fHQBz0QfbQTAth8ujbjIK/8UcuPr8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 19:04:03 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:04:03 +0000
Date: Wed, 17 Sep 2025 16:04:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <shameerkolothum@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <20250917190401.GD1391379@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
 <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
 <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::30) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b40476-d7d6-460f-1076-08ddf61cf746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JWrt2XM9BHR0M7/nu4HTIaOm6+shYwQxgdeNje3yP73OmzB7yQjWo+R7uT1M?=
 =?us-ascii?Q?FtOHADN/4epTtTnpcQH4U9jmQvFqAG/jjkmMJ2c7fwF88oDDbmRwYiC2lRTX?=
 =?us-ascii?Q?SbK2+gGXyfo5/ZxDryhlNUcDcbgmW0pc7sp14J4XGxpkBX3NVq1bKag1etOh?=
 =?us-ascii?Q?8QWQunhHwI3bEtduE+b4h+BAYX8tfjI6Eh9JCMB+hOLSYEQMZ4nPOO9MFV86?=
 =?us-ascii?Q?G/e55/9IqxpAyU34IJjrxcJJZm0ZekZrjcoBfRSN03Ir10wfyRzFSaJ8McJh?=
 =?us-ascii?Q?kW7JranjoKPaTqXPGRNbvAutV7PAcPBebIKAeqCPQTskZvKY2O+64vTxt+/W?=
 =?us-ascii?Q?PMclEbKeCva4bfIw15FplleEOhoS+7iB6/Wne+ZNAgIytm7Qp6UwOOezD3Hw?=
 =?us-ascii?Q?rfgblBR3hNLxxenFrDO461h4gZqrgAMJO8mzimpqHcjjETHjawNfOx/9g+lf?=
 =?us-ascii?Q?43f0MjS+yCIZ8Ag/8pGCj/PTZpBsxzjwgGvNnDUbn3omTo7kiddkPKn9IZVg?=
 =?us-ascii?Q?O4neXSpOJAbEarAoYGUlZOMTrDi0CTd9LBdrDDMOr2lQ7Lc/aakbhZvBpXSY?=
 =?us-ascii?Q?WysgzZ/2LDQ2HskolIquGBs5mT6whtdOWf68li/msTzrLOh19dmQz6UipYjO?=
 =?us-ascii?Q?SG5kM/81ANtosnk81JA3H5d0baOOnCu89dSAzxE1W0hAxjEpr2TDwjQswLHn?=
 =?us-ascii?Q?avchyZspvYnah62Y4Av306OXAHGwvIMWAI/rkMfERJUf3csMVvMpYZmXx29M?=
 =?us-ascii?Q?++UyHQXTlVSODk2wjTRMUB572vC3VrdPMsPX4XZzbrQDNKcMXVAD/ICshhfz?=
 =?us-ascii?Q?D4oF3iQGKOzoHD5F+ngUQs3qmHxmLWiiKj8+aFfT+tUyju+DIlhTEC1idzuL?=
 =?us-ascii?Q?Ww36XpT+s33JzSACiJRnJ6rKHGyq97H15mlEaXq0U5B6ergiV5LDAGhlp5wk?=
 =?us-ascii?Q?CdC1AkRks05osz4bjg9qzmxJ98QezyEDEt9GXfAHCpCISuP3ky35s8BvQOcC?=
 =?us-ascii?Q?HV5/o/hYFafC4dhxQJlCPZQMoElzueAwioOoCc88NXbApgzrgZpzw0a2kP5a?=
 =?us-ascii?Q?Ov355/tvgpTO4j8MYcn8S5W/mBX5sYY7QHXDklskYP216Q3MieZe2BBjs3fM?=
 =?us-ascii?Q?5ayw7ywXRtwF91RAqtjbGgX7/qPYZij9tocyiPNJvfUrjQEBoJ6u3Xxii/Do?=
 =?us-ascii?Q?/dLbUKa3mHPzf8PnsRG3xmSaYFLL0uQeQtQu6/PPcmbVi5+5lFXPzF9ambJc?=
 =?us-ascii?Q?HB8Xx/cNyCsGFIwWN9lOc9RAtPaZ7BkZ4GKMZ4gO4V+4VVs5zD7bMjmBs2jV?=
 =?us-ascii?Q?RF+gnMcXQtvTsFAcGuSpWI0ermg3GIaIZYODnO22asofkTOQpgvdBUHLoiz5?=
 =?us-ascii?Q?+yvJA9C2bs0f1FWFhl2AUUOCbVzcE/BK81sYmnfbyn+2zvkWppENRmcdBIxw?=
 =?us-ascii?Q?7HEVQwwbQmU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3jjciLxDDhfES4BtYfU4D8/VCUwzoaGuZ+Sl2a8fgALglmN1KUoRZQmOpw/?=
 =?us-ascii?Q?wZPQHm3DTyH9IwSuuE6UxrRmf7apuxij1+WMTuvKoqs70B9YZbKReIHwZ3zG?=
 =?us-ascii?Q?LAmcYdVrUCBacAymbENmxnAlUnNpz7F6MwLdwFUO80uSvzoOcupZl+IS8/5c?=
 =?us-ascii?Q?aQjO79RnUW4XSm5PbffGI9dcRnbwmtk62OZvg+JsyRL8ZqfcGm+VD8WgnxTd?=
 =?us-ascii?Q?IDquZfCfdC+Jg5uy76P/qI4NAy3ulzpowO6dAZKS4MQwsRFQzQq97jUmtLJz?=
 =?us-ascii?Q?g6t82tzy609pnBqr4eKstUYnTdITHZVNGVvLuc1t1VAIaajO8DwKPLQmGaar?=
 =?us-ascii?Q?Zw15yTFG4vZpdXNuge2EVzMbl3qfUC34dp5DEgeLgsNgfjdN+ytobcZC0njH?=
 =?us-ascii?Q?7DRVM5ex6lX1axhIWlSjEccvOlvMYsiTj/d//WBepK5HJauhT78a8PScqM59?=
 =?us-ascii?Q?4lDNr2YnUcBt6DPUp9MWOcLlMF0q77AjMgwQjqinIznyEOf70j95jMZGx/oa?=
 =?us-ascii?Q?cwjFE6AeN0knrj25tuajK+/DbpX3crTnZfwiV6KiSc1URUWcgjax9jtOo+u5?=
 =?us-ascii?Q?0NgJE3iQxi8HuC7QY7BIqwylv9aJefSphIn8GtuhE8IdaJO272vwzqOw+GLZ?=
 =?us-ascii?Q?9ULYe3VajKy7yiiL8kIL7SKj9zPPz0dyrtztYcoIray9E6EZ02pmjc7FDA41?=
 =?us-ascii?Q?KVIt7MW9RlE8Z6I43Zo/UJmixBztmS9wVeyL6j+Pa77g/0dtPkCTq7YD/XH/?=
 =?us-ascii?Q?+jha8Aib80LW74Sg/mxRXd8tI7eA81WUzRBvbDjT1cvSwRL/Z1tYy7WARLqb?=
 =?us-ascii?Q?vlUlg5gyOy3YESHUwtYPwQj7H0fVkht90LdTucIGpiDDYyyUged7sc2wO4l9?=
 =?us-ascii?Q?US0CWUAuYDDrHqMjGUyQmkI7qnn8j8jEEbwjCLsjJBy2iEQKs8GcIx5KMS8F?=
 =?us-ascii?Q?lDT+1YvbRuP+cGlV8x2WzCVgMDuMN8rnUyaW85OAEIbn7GJ8t5fx5jTEzjJD?=
 =?us-ascii?Q?gPA+YVpXiFzbbDhTtbcKIGFBeWy0V0bVRpt/L7x2Epnocv/nUvw+vo7K1Z/U?=
 =?us-ascii?Q?Fe67jZpkt5L16uBsGAvjN3bFmdfRD2iq7G2u94hVgMd9VzBcej+at3PnN/jw?=
 =?us-ascii?Q?VnXmx16D6BHwafXklBQnQSD0i4HoqeTJc3GYtEefnjn+QdE5IVMuXiGIz0ZG?=
 =?us-ascii?Q?V2Cm3TY8dcTK988oYtgkKNnxpxDclWcY1z7CmF8K4T/Xl7YbyQQ4iXHwNfJU?=
 =?us-ascii?Q?Ft+/rfrZEuZZ8+64SZ96Gli0H9YuczaWUULEXunDTR40fa+g3PGiphX18PNz?=
 =?us-ascii?Q?nDccDVi4c3pNzca0JlUHUbkrau1QdwQdByvXU2gmdr0JDD/nP5WL+344h1G+?=
 =?us-ascii?Q?H2EvNec4ZtTBw6rEsDx1cmUcWl1VFOvghSQAQNzZJdX9Qh1GD/2Dog1VvfIq?=
 =?us-ascii?Q?3Y0rjz7md3qC8dSUc9mIj6feyQfvvXL0SEO7OQtDavO7UMLjZtVImcApaRD7?=
 =?us-ascii?Q?2sTS02rlFmgz3ofzQYGIjFpx3YYdWYiQmB7F1DDzbWu7AB5Wr4S/Z5rMjxq6?=
 =?us-ascii?Q?GfhhUepVDi48xHIS/j8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b40476-d7d6-460f-1076-08ddf61cf746
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:04:02.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcAFJHuJedarBl39vvhPHT4Cftbh8qQ2tjFzMoF9MDe5SgsLVKN33dZpG0FbBdfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=jgg@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 06:52:31PM +0000, Shameer Kolothum wrote:
> > All vSMMU instances could share the same ioas_id. That is why I
> > put in the SMMUBaseClass as it's shared structure across vSMMUs.
> 
> Ah..you mean it is basically per VM then. Got it.

Yes, this is quite important, each ioas charges memory for what it
pins, so every needless duplicate wrongly inflates the accounting.

We also are working to have the kernel share S2 page tables across
instances which requires a single ioas.

Jason

