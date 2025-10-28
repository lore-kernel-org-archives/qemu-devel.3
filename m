Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F1CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkIv-0001u2-2l; Tue, 28 Oct 2025 10:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDkIo-0001sw-U6; Tue, 28 Oct 2025 10:03:59 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDkIh-0008Ia-Ip; Tue, 28 Oct 2025 10:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSl13OMRMLl1/A0oisnktJ16PWpySt10u2XdCtatFfNGzE0hosDji4kbHrK0Hr0MH9n4PfibUQimv12QW8+QFZZ6aoS1O8uAFGsYqqjhkOJIzSUdeda9aKlrmoJtSfPKUWQQJntEznMDVsDslAvp0VlV+54k/+PrZNYapHSuO3P7F9dwF3JS++GdFFYpo5MierrtEaG4ppbEJzod/K+p48EEGhnnwDl1/8WY4W6lL0X+vHqG6QHijPZ8+KEDH/hrEBo+XtCLPJSd+xJ+U6p0ZOM9+q4jxlRWEMug/Jwg6K62hYZQFzJR7oVgKHErLRh6rexsS4mfdSOQn4ZC8t/ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egkCz8or5JvaN/Y8AM4rtQ9zR7viPDqHLcrqunl3qrY=;
 b=Z7TDxBk2rb2nhYGc7YZD0Y2yrjwioFA8wX+K1D9TNOKHjHWwYCwa01HhsUpuBMAUDrs/N/Jw0i+vEuoOinbgtPEajEOK6ioAfU8Qe6gCr6xxZK1K4jhW1PVUIQKk4al088hQiKKtPFSzVvzIEDX0fN8ot1yYZlln/WdAmrgjKdii1jbn4KUtvuHzE5uAQeJmIuy8DjG7LodxVNPF7h4SFEPBJ7ZcFurAeJOzLjo8axl9uelRgFLgITlu+MSZcx41WQyQoIysa5VmWc3/cvAF4m4bPztOdDVxmpmWRSuKjYiZR0tFkh2qMVfzZIgPcZZGmvMKdiJudFy2CWpyyvt7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egkCz8or5JvaN/Y8AM4rtQ9zR7viPDqHLcrqunl3qrY=;
 b=EJVtF04+U4MbpdtgDLB0CL/wYMDiTiLDnrepWZ2tm5nLP32NjY5YuoGt8BdMMIG75CNA4vuQFYRpN4JM6KIVSMiCgKNAThLBh1BCTOEv86+/Gk20cJhi9cDYDDOKR1JNoJgONl7Qt7lguqjYghF5FY+XLcyCZed2BzdiERMrs4tas8N1Tv69Bbs7YnULW/ewBbUe7KWh3SYQpa0bH3aJOfIJ0wDoOJXd2zH4rhlWRii3747qLgF/5GVE/h/kJ2ogh78DrqP2h2TL8G/LNrnwJn5O4Qk0a/orTofRuQHR2f5OHCOKF9UPAZofiiEqkk5tn28IIuNzEgc0ZYjJbz7ngQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:03:41 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:03:41 +0000
Date: Tue, 28 Oct 2025 11:03:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com, shameerkolothum@gmail.com
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Message-ID: <20251028140340.GI1018328@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia>
 <20251028121625.GF1018328@nvidia.com>
 <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
 <20251028134148.GH1018328@nvidia.com>
 <15e0d683-e524-44ed-b253-c6221585d9bd@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e0d683-e524-44ed-b253-c6221585d9bd@redhat.com>
X-ClientProxiedBy: BLAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:36e::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9c8fc6-3921-4f54-ca08-08de162accab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EWekpd2vy1HXG4c0PhgW+7yUxKXVfDyXdQRtEjIrY+SFJ2MPIyGel24VFGlI?=
 =?us-ascii?Q?eFCD5/dfwsbMKGBUQR+yqV7keuvTmacIRt6GhmDdxhXywBdxgcH3Rw2coXIM?=
 =?us-ascii?Q?zxdlBwqRQbi5t5L+809mYIvgLUYauZ51tsQqvYHGwPBxi3XyOM/AdbBCCGnZ?=
 =?us-ascii?Q?ViSQ38nLun9iRfG2yLy8XZ1rjmTl+JgxVwYRO0mWx/XG6b86Bt08RPWSkvQt?=
 =?us-ascii?Q?dDbpEyTE2z7yuMrCY54T29rWj7t53n8HxmbgMLjRHKpXckrhLrP0NGmi/oZN?=
 =?us-ascii?Q?ohtkgB2K/Su4y6V3NqedmYeLDfKLIBGm39FVmDOUDFnzS3+aKNsBL3P2FaXo?=
 =?us-ascii?Q?KtkChUZnzKkX2fUTym5hFyg47upiWzcTNjneEUSBmVIB3TylgpEtGcS2adyI?=
 =?us-ascii?Q?ScTEQ+rCVqjLUuRIydvOlS202VR3JspMxNdEck0CMuEUVwPET/CAYjuQ6LJH?=
 =?us-ascii?Q?HwThTfcUtojJjNMkq6oy0WXfufGVvbBIvuxph3wxF5xUqo5VTYMczxDO9av+?=
 =?us-ascii?Q?p9V0ZZwtRK23BJZ5maj71VHW+QBhlF5SKDe2z5iMeG4lk+y+iAil6ch4g/lc?=
 =?us-ascii?Q?0ziOEghTyocEQPyx2M4mPYlK5WRwTabcfAAjqi6ARxzm0RgTaJlfKCnJ2U90?=
 =?us-ascii?Q?R+kQc8m+zXdIX3CdhvvWh5K61mmr6W+zaCmIiXh/NzjvA+xbehvF1sQE+6Yq?=
 =?us-ascii?Q?UAK1kxaONmkqDhesFeopt5hKgGr/VTCKQdzEAy2ZupNUU9Sv2oyT10TEjZ1e?=
 =?us-ascii?Q?OVIvkQ44FtWpiin1miqSQFchYi2K9n5DtjyPuiAI5y/ytK+zUP+9gbDNYErD?=
 =?us-ascii?Q?ytXH5IOI8t0Az0pVEbOLUCFJst08V3v/M5SIuPVO/dW1wMcYx0pvm09WSLeI?=
 =?us-ascii?Q?rWmeSdwV95VqZOW2IEXp6beUZpd75wVmu5rng13W/baWlIMaSlSu1zICbWFa?=
 =?us-ascii?Q?4owrCHT18FqakRrtQU+rPAecZ/bmVRIpQ6WZfUkWLU0VtRVQlOAM837feKW+?=
 =?us-ascii?Q?cf5QQt2H2I/qgOiqChntgxWZrI1mBeNyCunCGZywFRHQIDKNyK6QdHArn/SQ?=
 =?us-ascii?Q?BYggfnVq5+yeUEL9bpH+h9UblaqAX+ysI4zCawcxXEr5uHngOhcXnP5A3ZxG?=
 =?us-ascii?Q?UfCzL/K1Rch2eYAH3XAgVyNNjwOssug4s1B3JBEYTF1sOYx245wUoshi5Waw?=
 =?us-ascii?Q?9GU5zurrWP0DHF82lOyqYyvxVt1Lo6pFBRnsuyrE6436TZv8aYzBA5ywtFXX?=
 =?us-ascii?Q?FEbdM0JhzNkBbqTP9V5UZr1zqooD8njqiAEhAQkRRxbYXUDPP0Ky1/9bOiBC?=
 =?us-ascii?Q?Mh9WnN5KD4RTbwwZKyRqmk6L14eKhEHAqPi27MGCX/KAyBZ03ZA6bbtB4e22?=
 =?us-ascii?Q?jXnPn9KpuG3UPH45K9wOWsj6gDuEV71krD1/8knTm9xLuKEDALlkCpo+O/h2?=
 =?us-ascii?Q?Bfk2hjOWlR7Bem34kDYBLiicTnv+BB2EoCaT3J6p60lmvll+VeN5ww=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nOXZS9CxNFxtgdCysXUKa5HAkHoFEpCHt6GscGDK2XSLgGppTwcyPAzFQ8/k?=
 =?us-ascii?Q?jZHOiEp6UyuL5XkN9hh1KG+8IjFtSZmMxTf01DiFXdhgztzc+5ddiqyHRaKa?=
 =?us-ascii?Q?rPs8KfaOXj8oeg4Q+zkLHaTxWPDuoOZjHvQZsurv1ttLpYJZhlzHywrQ5Kv4?=
 =?us-ascii?Q?fOXz6BhamUopFyR7AEQrzjRAJq/lEn9LSNU8lEiaDChrK80nxt5Wz5rTeC9N?=
 =?us-ascii?Q?f5gSrK0+mcN348D8eoZgLHVsLm1MfXsvUJBVM/xs2t5jgg82QItHf4TVZ59y?=
 =?us-ascii?Q?Q5/1A3SC267v4XZI46LGNstu19HQkitm18gjdRrq1uuM4LpjfEhoYU8Eik+h?=
 =?us-ascii?Q?MQ8cVhIFsYpVSRw/hYidoF3BM/W5cvAIRCisf7Zvxei5W013Stq7b+5SvT2d?=
 =?us-ascii?Q?MzbM0T3OpeCE8D5vSLSRk4x4RFH2+2JWEIs3lHdPuBYY8UnwUoGWWqvjnatQ?=
 =?us-ascii?Q?ih7DJ2bKCteswUmTnvYPpIG5rcMFtC5AEZBgV9GJ53o+hl7pHID884z3boxQ?=
 =?us-ascii?Q?iFEwbts7BXTLar2+RPnj+c3Ll5bCxK1ZTeNrMKu/8E0DLRfN3YpXmwbKEWfz?=
 =?us-ascii?Q?Lc8EnqBCVSyZe3nx3rXzGQ4hVjCaFzLdDdvDMkheqhctifaxAFhE3+c1uCY+?=
 =?us-ascii?Q?2VanLHPDQZ+6QVnZBaweuygYHULopwDvcdldYRaTfQUtFeNy9ErW2yhoTkJ3?=
 =?us-ascii?Q?21QPLNlJcva7mSSeTQSdqwIPBbmvKf880tV0uYsuxlXeFVflhCN8cyk6P4SG?=
 =?us-ascii?Q?ffBJ6pLhPQzR6tgPSLld15uksxPRnwFzCdjE761KThbqrDKrkiM45+vWGo4r?=
 =?us-ascii?Q?nPQ/YuH8tyXq0cYpapQmPoI7j06qLvcXjzqU0s54Ek/E1dXfTQWa1f+4MhiU?=
 =?us-ascii?Q?2uyGfLyaeThRzX6gO6kQ39AUx1b38XKiEudY+iNp83lPnDeeQv1OlDSz2mPU?=
 =?us-ascii?Q?V90+CuzXR6ltpRc9aRIebxLWuTSsBLCBHQ+HzMIx0xKDfbsm8VBP7P3v/zWR?=
 =?us-ascii?Q?egAvT/HakMjiAPcb3ucarV3NJW5xSUtRowyOabI3vg3zBxdn7nOI7uu7HPgm?=
 =?us-ascii?Q?nKkpkwqfEN60zOBU/L7wYEZKlCXsAt7weSbE/ueZP4k/dhDu77NGnTyAIL9O?=
 =?us-ascii?Q?MitiSLRfBET5g68ng1VfL6EWquCofiBwgkr8lSO0A8s7f1pyVV2vGOE20RzF?=
 =?us-ascii?Q?bDieXPJluZtowSevo7+w16harOnPffDxaOnwfEZg7/R+NeZGV4TekKVGsXQv?=
 =?us-ascii?Q?MtVZ6O0sOpWXHiLZraXsHK6IGFDhsSTXcuK3dNV2m5hrRB6Fk1FAeheCK7q4?=
 =?us-ascii?Q?hyz9z2Nao2RGyKicH0sPuXkBWpSr2C9OQz28QhB0N4IDwi1TCG3tnWk8jYo6?=
 =?us-ascii?Q?U6z84ZS9lg4nL2I0SMNxJ8Uun4jCv9IO71yn86Zbf6VLgfg4Y5Ej8ZvBQDXi?=
 =?us-ascii?Q?SUt2NBQi0sCh90oPzqtVLftxn17A54Gdq53Z4gehT4S3peQIwBa82lIs0kIk?=
 =?us-ascii?Q?XPUVoGFjwyaUJRcONQQVbMOPm/2vVEE7AH+T38+8ASAvHPireWBDY/FNJ5YJ?=
 =?us-ascii?Q?kzk0eMl4BsCNO5VeH9s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9c8fc6-3921-4f54-ca08-08de162accab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:03:41.7705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmX1UjcLMb0AhDLmKiM9YkUkEOb8NRPnA2Ez1U5QJXuRcCHzQJUzVBCS4tpqnsfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=jgg@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 28, 2025 at 02:51:29PM +0100, Eric Auger wrote:
> 
> 
> On 10/28/25 2:41 PM, Jason Gunthorpe wrote:
> > On Tue, Oct 28, 2025 at 02:21:32PM +0100, Eric Auger wrote:
> >>
> >> On 10/28/25 1:16 PM, Jason Gunthorpe wrote:
> >>> On Mon, Oct 27, 2025 at 10:53:10AM -0700, Nicolin Chen wrote:
> >>>
> >>>> Hmm, that sounds a legit reason, though adding the ATS support to
> >>>> the emulated SMMUv3 isn't seemingly a small effort...
> >>> What is "emulated ATS" anyhow?
> >> I guess it means implementing ATS translation requests and capability to
> >> send ATS invalidations. something like:
> >>
> >> https://lore.kernel.org/all/20250628180226.133285-1-clement.mathieu--drif@eviden.com/
> > Why would you even want this? The cover letter didn't explain what the
> > point was.
> 
> well I am just concerned about exposing ATS support to emulated EPs
> while we actually do not support it.

Sure, that shouldn't be done. There is ACPI/DT tables indicating if the
each device supports ATS and qemu should not be marking the emulated
EPs as ATS capable in the first place..

However, there is no big work with showing EPs as ATS capable. They
don't implement an ATC and there is no concept of "translated address"
inside qemu so the only requirement to make it "work" is to just NOP
the ATC invalidation SMMU commands for those EPs.

> > qemu emulating two levels of IOTLB caching in software, with a
> > software page table walk?? Why??
> About the actual use case for ATS emulation you'd rather ask the
> contributor, early SW development, IP development?

I guess, I assume some OOT driver is trying to model their ATC with
more accuracy. Maybe to bolt qemu onto a chip emulator.

Jason

