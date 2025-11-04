Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEE0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIN3-000585-SJ; Tue, 04 Nov 2025 09:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGIN1-00057M-Pz; Tue, 04 Nov 2025 09:50:51 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGIN0-0003LH-7w; Tue, 04 Nov 2025 09:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzXiNUx6ZgZzl7HaBYtwxHHQoWZ7xZjs8wnTRHJuHm2nDjQ0JvFxB5o+5Wg9zU0GgAyDj82zl09rbAbdPCBXdldrtRLTQ0Csf3Aja+n73T+he2xDK9KrtXm3IjmLvKbwiQiLdqr7Dcd32NfCu3wO3k+9Y/ck6XZeft1LzRx1LnARffj6KLQVsZsVa6qCEk8la1GwaZoCeYCUqTTUCdLOwWibB3DFWPa9iZPCvSIjhpzikDkX57phw4KMuYGsfdLMTb4VSNSicKHPR53TWSIgUdx+b4Zw7cPYdktHBjCb7vqk9jMS1gzxY/CYMxnejKLIw1pyte7chzNw/oCw4eKR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVyRQ31CnmnR0mO0VoItvPFeoVQ2hOojg2jcwUcmLDI=;
 b=ortBQNBrCt0YEx7q1gOMK4O5S2+bE0/BNyV4i3hlpu6Q3MKS7hy4A8vVanzeXHzJF/vnmbiQwo6qtuO7HeFDOcRdHU8OFPWj779j+ORIGkN61vsyig3auxanCrL0ZGV6vCD5WtJC8uWCUzTzoH3IFHee7cV1W4w51yX+SZeQ9QUCEX46GAARsM61FM00CxZOEu/CPw8ehjg0EumXbN1xJRwdsrNYzWcBHe3h6pnqmEk+JZPJgvdFWnJNE0K4JxzQK8O1eivbt7HcfhtCCGPndrfDCPq89GuUov87KLYFSNIemSP5ECiscmzQeFTbPV6bVv+4f5fod1KLiswLXcfO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVyRQ31CnmnR0mO0VoItvPFeoVQ2hOojg2jcwUcmLDI=;
 b=cafl5Zn0+LrB9x5URAfYB5HPmfoop8LkwIzttKcp6Bl766G5CmsVKbKigxq9xETYL2GlFAZBgf6QWmAs8eLWdxl3oREZPZQAN9xb4+cn7kKQ5UjPWgqvmc9GmoZwKVOkhr+gAdpNbXT05ANa/asoDkTmbHmHLCgyYU4danrPgCtNC5ARGqLR1F6TeE/bbSKdSdG5I2meXRj/iwyHFH6DwR/TNJ7r2SGL/apaKkGY+g4GqQSXB2ksn9I+lS1hwEb3mtxk7C70pUITa+5N/RLG+26iCMS8Pu2idwBucUdkh8YA867kykkCzJI3vV4jlR6zA99FifdDeSq/Z6R+UrKWjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:50:43 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 14:50:43 +0000
Date: Tue, 4 Nov 2025 10:50:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
Subject: Re: [PATCH v5 28/32] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Message-ID: <20251104145041.GE1537560@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-29-skolothumtho@nvidia.com>
 <49215c9d-feb1-4f72-bfe0-799572ecfac2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49215c9d-feb1-4f72-bfe0-799572ecfac2@redhat.com>
X-ClientProxiedBy: BL1PR13CA0268.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cc00c9-c5ff-46b2-cb72-08de1bb18765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RlPtg5lhvr798ELJBUynTDh+1hmv6XBA1MNJ362nwLB6V5HAYPkYa5VI+tF2?=
 =?us-ascii?Q?PgpO5eko6RrHsaT5rY9OSolNb7yFvtCb6b6D+Lqhd2pkSnl3sgoCD67gGCOu?=
 =?us-ascii?Q?isZQCuFeRLa/5Rce05BQZrK691lxTnz203BnPb00zWYorPg5OKC8NTt9S9gu?=
 =?us-ascii?Q?D3WAHWQhhwdS1FH27lNQ1myaB0WYz0REhn6XMDJu0YUvT3fn6SEVCSbLxJIC?=
 =?us-ascii?Q?mnvJgsDWV7AINPXgQeooeb2CFD4HQ+K82p2b3bNmDSLtBZH6/J45xEDc2nMZ?=
 =?us-ascii?Q?uL45N1qkZiKEJp4ST51PI6pwtpsP0p81Hk0Zks9IIdKTCZGHSHwfNpKG3Xcr?=
 =?us-ascii?Q?DDRgEmZGCXJ93SnLbCqOYLjlgxQdI4Vhl8MyYEkOWUtC4lYNbPvxukQz6Fsi?=
 =?us-ascii?Q?4k1eziFSAi0IVXeGGt137ePp2S6a33FMYh9XvIQpAmqjRHZXKBv2qV0K6GYC?=
 =?us-ascii?Q?P4LTMgC3gFPMmJu31G0BbH0gvzsm4pVORfUhW6R8lhUNH1QiP9I20wX3bMxu?=
 =?us-ascii?Q?SLSr5DhA+2m9Bh6vQp+QyxzaH2Wc0TjYmG1FlC/fuOIXY3jATy/mjKO/UxcB?=
 =?us-ascii?Q?AYkmT4jqibmQXDxzwbld/8gGZca0vw9r3qks77hYSWafFlWpQjxKGeCHh9wh?=
 =?us-ascii?Q?i/UHTUQDl2nnU7oTAxnOEUG/fZwAT1ExRWRLIUpQ3iVUlziOvAeJxEWlD1XG?=
 =?us-ascii?Q?Vfxuspu2DTk5Y+6sTm4t1m28zsH5j2bEgxwAsGw6WQTsoEmrVLD2qg1req02?=
 =?us-ascii?Q?UgUB4rmdgZEtn9ZK6RCKVwcB491laTy5s4wUDYulwQ9/KA1lw6GhwfIDYARv?=
 =?us-ascii?Q?CN6s8DlSl7ZN2XGbsvjfwGAO4xk/2JzJZU2cPKsCp9Uc6GuZvU4gLwx5GfuD?=
 =?us-ascii?Q?VhDrTc5/EPRpnVEWwB238MuVkizp6pJu+SVcutMlW/wFvwQ02qGqYezYy4dJ?=
 =?us-ascii?Q?13757ul4Mgo9z4drQgD8+NZg95yB/h3iYqvHucdMUBP4vRD7FN5xMjuCb6fw?=
 =?us-ascii?Q?vs7ZKpqjB3hmWCeMtVUZW6T/mJfevlbBDx14TClkdnKtOYqNXwe4l5EkBXYc?=
 =?us-ascii?Q?miyHd3oauKac4Xd4wBXa/er3ewGiuc/5I3T4Q1y0YhQN7PRQW4rA1taXj5uw?=
 =?us-ascii?Q?2fZ+hResESbMivPndF0nTN5cjrP0ap1DtDsE/Bvw+Rg8zN9ayfWa4KbstjiW?=
 =?us-ascii?Q?MwwNyD2dYJGnb4tB6CaJd2YfpZ+j4NFC92KF3FMuEQdmgXCsa/cxgQ8hsAN6?=
 =?us-ascii?Q?Jtsn2EKh/3+geJsryVDjpMV3EDqYoCxv9sryoECf1GW3zGPfbyWUnGNojAau?=
 =?us-ascii?Q?zGnc4JHsdjlRV8QxrCzToAQbXI7bV2yBVW0N/kRxMvG32/pc1qMcWk+NmGAQ?=
 =?us-ascii?Q?ovtyz16MZWxpI3J53JoONPKGS593+Jnc518F4nZ+UgOaMkDt5WQctasapdkH?=
 =?us-ascii?Q?4Dc27Ov7UJoZoTC3riKiYEPmPXWZSDM/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zoKQ0BVD589uUifHBYrdT0AD4Tcfn+M6e6/YjgtrqiFi2GTXsg30LKI4j2t9?=
 =?us-ascii?Q?hQfJWSwCiQPogoi1JWxmgLHOZ/9NbxtNveI0jYvEnUR/Eo68E/IM5oo2b7vw?=
 =?us-ascii?Q?zIsVAJyH4NYTjnN3LN3/2V0SlT9SR5Z4jPNQ+IwV+IEMAYfwdQB6Y0iFVMOT?=
 =?us-ascii?Q?vRE0/PvCuwbJT66Ah39CKCo40w2OqaSjpMBquRzY4PlF9sm8Cz5u5u/40az/?=
 =?us-ascii?Q?Cq4DSJGEesFXXVSvgmHHleQWMHyp06WMjUKBD828ji+GDG7k1fPo6dk5N8le?=
 =?us-ascii?Q?omDAvLRJTNJOl+KM8ZHMBUmXoxlE34nYQu/2ey4kRNTvZPIjIERk19Vz2JhW?=
 =?us-ascii?Q?Va0o1x/pTq6dgH6u+yftM95D9NZ6kvJa9+XOcntpq/AOdRNQCovFaFiyzflH?=
 =?us-ascii?Q?sa+jDK1Yy1YaGWyjrHnDJSI840Be9oeQ8/T+gTNT/SdQrdTWU8wmkuTc0dbQ?=
 =?us-ascii?Q?cjdUTRyUDeWZW1ovqxoeVIX+YSeIilyNBzW8gp2LKK3RN9IZCPzJtO7QGnKi?=
 =?us-ascii?Q?Ye6Hb8F7MOK3k/jiw/bj321O7pUDr/Npe2G5Lny6ltuTStxmdMnotGM8Hmvz?=
 =?us-ascii?Q?AHl/4HRfRC8rADXWo1tNzoUhnCuU0I7GZfSefrC95gs9KXJrb4MFAYnaE6v+?=
 =?us-ascii?Q?ve6weOQ1k7BV3fPXgrX2hQpN6hZvgN08Q9WmULhw+KkZ9lEUeusTUCFkpTgJ?=
 =?us-ascii?Q?4KMxZsIAMNsvUJQ4vmMOw/QLCF+kYKBUlp73SQcPHwlywVzaiFL63ckGwB2t?=
 =?us-ascii?Q?Va6HPltZVktWOhFU4RGP4Hc7+1xEZ+vEVVmEP+ZCRa1OAr2XNSAz7lBnwvFU?=
 =?us-ascii?Q?tj0Uim8qpTfjB29z5/TVkj3TokNTAMNFp+4Q4PmM8U7pkLja7XtfHwFOD6gl?=
 =?us-ascii?Q?an66IxibcMbs9vkUYmk4HW3if7P69HE5JROocT2cu1eFIOO2IJ2CiMRiL40i?=
 =?us-ascii?Q?HF7bvYBF0aBsY6tZaMn8C7EwqKz3SEt++UoxkKKEgOg5F94hWASn8fWZp+Te?=
 =?us-ascii?Q?Tqwo3p2COR8wqnLluRCi5R/4+W53bFcypfaD8tShqEq4N/3wfhIRZ6rerihc?=
 =?us-ascii?Q?db2lWDsJtO3YQHHyJfUSm2LkOHwHAmHM1krKQDEZgukERNtWu+/3r3x90YDx?=
 =?us-ascii?Q?jdxyqobAbpIrA6+PaK3TyWgliycuEEqLRKtjg3QPbgmHo0828VVJy3ZE/xkT?=
 =?us-ascii?Q?SyArlK9eSlYcNZdBmo6X7kcenIqEbqIlW93Wj0+zEJVnwL+XQtrss7F1fz0v?=
 =?us-ascii?Q?mBsUk20up19UQURgSmta6JOA8wEXLDQ08aDJJdyeqd4kCL3aDKA3opqVZh55?=
 =?us-ascii?Q?DmvwxY/C3HwzXS7Cl/jfPaPxgJknZR0ypwjxL3iD2ht594RitMw1HsduUgOq?=
 =?us-ascii?Q?U6yaTDJ2chkAav6f/G5LKCvTft5CUOoq7JfiRFuQevF9K4kRv7M9L5vPvlOU?=
 =?us-ascii?Q?kZ+ySBig7lLdg44zFbGAzxNNewnlfw+ANCnqsRXu7wVyJuDIaiT7oskMntPy?=
 =?us-ascii?Q?4fi9hsIhPpA332csDvJe7BlXlTDrBucgQj5cCu8uZ3nHQyIpMYezIZf0+ahL?=
 =?us-ascii?Q?2yua+EevyYBasbbaDjE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc00c9-c5ff-46b2-cb72-08de1bb18765
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:50:42.9544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V52uksx4+E5Em+apVmheZwvS2e9pAaHkjR7Lh14kIclI9MMoFekFqFZtPFLG/Tzv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=jgg@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 03:35:42PM +0100, Eric Auger wrote:
> > +    /*
> > +     * TODO: OAS is not something Linux kernel doc says meaningful for user.
> > +     * But looks like OAS needs to be compatible for accelerator support. Please
> > +     * check.
> would remove that comment. Either it is requested or not.
> > +     */
> > +    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
> > +                FIELD_EX32(s->idr[5], IDR5, OAS)) {
> > +        error_setg(errp, "Host SMMUv3 OAS(%d) bits not compatible",
> > +                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)));
> let's be more explicit then and say
> 
> Host SMMUv3 OAS (%d bits) is less that OAS bits advertised by SMMU (%d)

It isn't OAS that is being checked here, this is now IPA. OAS is for
use by the hypervisor.

When the guest looks at the vSMMU the "OAS" it sees is the IPS
supported by the HW.

Aside from the raw HW limit, it also shouldn't exceed the configured
size of the S2 HWPT.

So the above should refer to this detail because it is a bit subtle
that OAS and IPS are often the same. See "3.4 Address sizes"

* IAS reflects the maximum usable IPA of an implementation that is
  generated by stage 1 and input to stage 2:

- This term is defined to illustrate the handling of intermediate
  addresses in this section and is not a configurable parameter.

- The maximum usable IPA size of an SMMU is defined in terms of other SMMU implementation choices,
  as:
    IAS = MAX(SMMU_IDR0.TTF[0]==1 ? 40 : 0), SMMU_IDR0.TTF[1]==1 ? OAS : 0));

- An IPA of 40 bits is required to support of AArch32 LPAE translations, and AArch64 limits the
maximum IPA size to the maximum PA size. Otherwise, when AArch32 LPAE is not implemented, the
IPA size equals OAS, the PA size, and might be smaller than 40 bits.

- The purpose of definition of the IAS term is to abstract away from these implementation variables.

Jason

