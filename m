Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2D1C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqwo-0006go-R8; Thu, 11 Jul 2024 06:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRqwm-0006fT-E1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:22:44 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRqwj-0007Pu-63
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720693361; x=1752229361;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v8CQVxaBO/KNEo44NPTsmJ4b8GueG6GA4RAYZb6px+E=;
 b=OUvv9mnsMFg2rSuad3IfV5SmvskV5UvYST6BSAyVryoZj3WxvygoEFIA
 iDVaigvKuX1TLY20hl55Usa7ArIPuofWVzqJRnVYrG0LwAnO355/g90/l
 WipSEnuF0ntjY7YBtuc8ngzZtjYfVQdUnmOKD2NHRQT3tGlNDRbZTqQoo
 7wQ4PO2FRImaUW74pLJrvp1vn+b0f6QzEwO/INLPbFj1BuXLJacIAtSd6
 seYAgOP96w8AkWjlMbNslDNCejzGN5ICidQnaaxWdYD1xuXeOJh32LYsS
 8gCbfs3AxnVbDeHb5vJ2COdvcyTQEsHiA8Df+tNSyR5IVgqdC//Gyzp/a g==;
X-CSE-ConnectionGUID: nbjW9PVwSd6fwpHUdtwNJA==
X-CSE-MsgGUID: 0POTIhvrSNO6hrJ5KGvfmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18010358"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; d="scan'208";a="18010358"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 03:22:37 -0700
X-CSE-ConnectionGUID: YuwMVTFfQFGqXhgU0OBKHA==
X-CSE-MsgGUID: bTnGA2AFSea3SvQSUCtlbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; d="scan'208";a="49165137"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jul 2024 03:22:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 03:22:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 03:22:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 03:22:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 03:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUkk06A3lroi4N2mU+n5qhERlkVOfAZ3nREKr8tGthtPGEOxe8L0l/Wmwep9L3alWeNoMawkCk4dw8KCQZl5E3ifC5Jixc2rkvJoLPoer/ztv+rgEf1g8PxbtoJnLQzZGD4h7iGMfPpwznhP+pNkrn29M7rMHb2vlSg6w6v89QrW0lTK6PUvAWK4J72T5oilrL84BHs3Lou66qSmOBtzzkRBUhumP4QZXkm6A6ut/FSxF8eebu/klMeQtJVsYgMd+5qXtvDd4a+bjsSufXnXmWN7x6nEdWTnkZYHYNo5hm72tRxF0vAJ/iOZZ/ps1BVZQ7uXhM9tYc/VrNKtVqpzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8CQVxaBO/KNEo44NPTsmJ4b8GueG6GA4RAYZb6px+E=;
 b=SiKo5sDKqJOLKXw6MeY0ZiP1tW+cxk4cfCN4N2kGVbj2s9slMpzg5uFzBlQYYdHem/ngBHPwHPkgEWA9JdCE3fXAXacI7JxSzv2dsIbfUfVqzVoIFr9rLNA+jZFLPIgVff9HNCw76Tw8GstGc77c6PJ4aHjpMrWWr/Caahfy39nriCasPQWWAMTQZtp5PoVLZAH9cJmG5i+1ZPm5wrhw/DizaSvVb08of2+z5Z7YacIi4/wBnc5M9MEbAsENXItbZwVZ9ADCcFbquWOqa9hGi/mp5BTmf8pkF6t9Kg/BtFiboLvX66F5d7LOdyt/0v/H18ErMJvRtX3ZKKsJ+J4Xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Thu, 11 Jul
 2024 10:22:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 10:22:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v3 00/10] hw/vfio: IOMMUFD Dirty Tracking
Thread-Topic: [PATCH v3 00/10] hw/vfio: IOMMUFD Dirty Tracking
Thread-Index: AQHa0UP5J7HEEBz/lUW9dCIoBlrvp7HxKOqAgAAOrgCAAB05kA==
Date: Thu, 11 Jul 2024 10:22:32 +0000
Message-ID: <SJ0PR11MB6744373FFC0993E12FB3A29492A52@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <bf7bbf89-2930-42d0-9a3e-edff8e6c496d@redhat.com>
 <62aa04db-35e2-45dc-af0e-aea3acc332aa@oracle.com>
In-Reply-To: <62aa04db-35e2-45dc-af0e-aea3acc332aa@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7280:EE_
x-ms-office365-filtering-correlation-id: 9ab96b16-e6bc-49dc-cfae-08dca1936068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SW5sVys1eVE5ODA4cVNtaWJidUVvYVN3YVZpdW5VWFJJNUdFVUdEN2JsYUNz?=
 =?utf-8?B?Q1FQM3VoZm5SeVFabnpXcmk3VWd3Z21FWEprMEY5elB0Z2ZSNHF5NkUyeXRD?=
 =?utf-8?B?eVRma2w0Z3EyOFZUTUNBYnd6eE14RTZNeGFuYVRXSm9ub2xuV2paRFlSLzVm?=
 =?utf-8?B?L05hOGxveDVxNXVvOWdCc20zcWFwSXFKajcyRWZYL3JUaEd1clBUZ2VUWjhl?=
 =?utf-8?B?ZytoS3Z1T3BHNlpuNlJ0K0U1cVZBMVprdThxV1lHUjhQaUJQVlcrSUhTWCtG?=
 =?utf-8?B?Z2NmL2JIZHNiMjNCM0d4YTFtV08yWTFYY3NBOWN0Uko2YVJ5K3BTV1ZLUnFV?=
 =?utf-8?B?NmN3NlRyQ3ZXNExzYTFGdjNmazYvRXR6QU80TnVlcHY3Z24xQnBjRy9UMCts?=
 =?utf-8?B?NldOUHMzcUZ2RUowZUhCSVVuRlNhT2swRHEveWNEU25TR0htNXlRZGhFaXVn?=
 =?utf-8?B?QzhGQWJkQ1BDckZMRXY0eStnVDNiSWpRNDV0R2JyajUrZm5yMzlSQUJXREsr?=
 =?utf-8?B?L01vZXpDdlI1VlIrYXNueXBDSnBzemJZbENlbWQ4YzI0amVrVzhlWnRNa3Y3?=
 =?utf-8?B?Vi9UUmdzTDdRQW8zNGRSWVRieGRHQ2xmOExKZnB6Y0xHL3RhZWlxNnVhWUpO?=
 =?utf-8?B?R2N0cnhEUURpSG9aY2d0N1RZNW5JTDFJa2pmMDdWUUZiWHJlVWtGWWxyOUJ3?=
 =?utf-8?B?RitTbnZCMWNpMGpKRGMzWmVVZUhhYm5MVVJGRTB6U28rOEU0ZEptNXFRNm5n?=
 =?utf-8?B?OUxwck1LSnVNTXpiQXhLMVYrK04rd3ZIRmNkb3ZDSUh4ZE13KzRQekROTnBp?=
 =?utf-8?B?UjF0RXB5VU9KemR0aGlqRVlnVjlYcUxuR2lFKzVza1lWaVBQQTZXa1Z2ZGY0?=
 =?utf-8?B?bHZocHhlVmRwS1MzSGxPaExHaU93Y3lsejFkVXBGa1ZHYkhqOVlnMVplekpI?=
 =?utf-8?B?T3BLcEJPYWVjL0oyaG53Uk50Y2VXWWJZNkFNcjZwcWlBNEhRNHFhWHVSRXdi?=
 =?utf-8?B?cnhDT2NucWpUbjNDcC9DcEErTDI0YTYzL2g2VytZRjF0dEoyNWE1ZDVGN2J5?=
 =?utf-8?B?WnN5OGhoYm9tSGRCVVZYZGt2dFpMYzVtWk9HVmVQdDBCRHExS3dxU1J0L3Vp?=
 =?utf-8?B?QjZRQnhiN3dYdlowK1lJY0QrNitTSndDN01CUGRsTW03WitKcXFIZHpFOExP?=
 =?utf-8?B?U3pKWFZFaVJVbVhEMDRmd3pTQjZyOS84NnRpRjZtdnpQM0tNbi82Vzk4d3ZC?=
 =?utf-8?B?YldhSWRPcDg5RmpybGFlV2xZZHRtbnNVc0dmNGVVclZNZDZhQ1p4dURZdnhM?=
 =?utf-8?B?S3JOWEdNcmQ3Z3V5VTZ1N0x5b2RBRTRFVzFQM2tPbzBSQVJtbDZva1RtTVVK?=
 =?utf-8?B?bHMwUGE2QUVzeEZ2YmRQNWIwQWdHVHVQZ2pQVE1zNVlmYXJxWkd4ZkFhdTdM?=
 =?utf-8?B?NXdBeTN1c3ViMUtFRHZ3RWVMVjZJZTFXM1FQc1lEV2lFZ2wzUTdJaUNzVzdJ?=
 =?utf-8?B?NU1MT0VGanBMSmhIWmlaWTd6YXVLV3FWdGZEQTNRSnVOTHJpbDVYc2tYcWJt?=
 =?utf-8?B?STZhYVhuUmVoYk1XZXhqVE1SeGxKSHF2Ulk0Q29lUThmSGdXdk55KzVsMEJS?=
 =?utf-8?B?RURnU1FtVGo4dGVPaXNPeWd3VUpvSmFJZzBFMWhzSVJhcWpLbFRRbW1KdlEz?=
 =?utf-8?B?MlNyYmRqZ081bG0wS0Y4YWl6QStlSHgxNExhcUVHUnBySVpiSmhjY2dSUmIz?=
 =?utf-8?B?T2pka2hlSm1rWjVGT0NOVStDSTY2Q0FEMzR3NnBVazZkUlJBRzViVkViQklj?=
 =?utf-8?Q?GRbSDyJX7Rn9NLYBiIeDyNahLjQl1rczL3m9c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUhUOGV4Z1RqOXU1c09mN1NkM3dhQThYcHdqTzhmcHRlZFd1SjhxWkVFRDV0?=
 =?utf-8?B?SmRBRDFaZkJOMWdVKzdzQWsxa3VITm8vdzR5ajQ5NW9VK2NpMVJ1dlFkTkQ3?=
 =?utf-8?B?dU5jZ2xVMEZta2F5QW9XTTgyVXpSOHhnQlVqSjVKcExnMDdnWnVqK292Sksz?=
 =?utf-8?B?dUhxMnAwVVpsclZmZ1lYS0pndC9ad3VURmtPNmNRaFBZVU5YL2ZLUVMrUzBK?=
 =?utf-8?B?ckVxOEZwaXJtZDNlVjRJbVIzRjhoOUlOekp0dGhMRHZuOFArYjhIT2VCNVNj?=
 =?utf-8?B?QklBQmR4QmFMVG1aS2swM2MxOXhTR0Z5cW5aQzVQTFpxTFcxUDc0aUdrUmll?=
 =?utf-8?B?ZTMyenNHZXI2dUF5TUgzWE4wRFFvakMxOUFqZHoxNDYwREVTRGcrN29EVnNh?=
 =?utf-8?B?SkJmclA0OEZjYU1MNnZsM29FMHk5WElBOGlvdjIxMFNWUGlnSEZ3UEh5LzRG?=
 =?utf-8?B?NTNTSUFSTk9xVm9sMkljUldSY1lqVTlKRVlXVnN3MjA4QmRlbGJKQk1majIy?=
 =?utf-8?B?R3dBdGFvT2x3ZSs5eEJFVkdKM1hrQXJzZE5zRmZsaDRUMzg0SFdEbkFMaUMw?=
 =?utf-8?B?Z1J1amZKcElNK2J0NTBVVU5TOVFhSk1yQS9vMWRVY1d5Q3FWMS9ndWpOY3I5?=
 =?utf-8?B?YUgxUDFPb2dORHNTY3p5ZTNaOHZsVFljdEtIMlNZcGNaWUtuTTJ1SUgrVHdD?=
 =?utf-8?B?bGlNMVZUUFRpWGM4ZFZJVndtaG9oUE1HcFRpMTFXb1pnMnJKdWIzU0IvYlFS?=
 =?utf-8?B?RXhZR1EwdjRSeHlwb3JnV1JjcVk1KzRLMnZha3ZyL21uWlMvd21Ra3VmanFn?=
 =?utf-8?B?L0xWeWFtVzJhRXJtVXZpYXh1ajJhK04zaHJPZWFWd0Y0L0FERTN3U2NoVXFP?=
 =?utf-8?B?OWo3dDEzQXdMNW44QWNBdjJIejUrZnFYanQreXhNM0V3TEZhaXV5d3E1b3dB?=
 =?utf-8?B?N1Z0cFY3SGs1NExDNmEyUTEvb3Nrb0tzTmVtUllCODkyQ0R6VTI1R2NNTU0y?=
 =?utf-8?B?L0J4NXIrN1gxOW5tTDBlTnovWW9CZCtTcG9DRVZIcGxHM2NiYXlIdmFhZDho?=
 =?utf-8?B?bEJoVnkvVVIwZ0RhRzEzalBzTGNXMUlzOTdQTmpiS0YrdWVac3RmNE1JL2Nq?=
 =?utf-8?B?OVpEMkY0MkpwTmVPMDJLSjR0QkE3V0FzQW9MeXpUUlZGSEhrbHQzcU5WclVq?=
 =?utf-8?B?ZzcrWW9IQU9oOHdyNGo4VFFnbXE3R1RGcmlQTkVaeE90Z0IwRlJwbGdwbVha?=
 =?utf-8?B?TVVBNGJJR2Y3cktHaFNuRDhsSUxWNTVFWXE2dW1CT0RsZnljWlVEeXdlRVls?=
 =?utf-8?B?OXdkQ0FBZ3hDazRaYjZnaVdHeVpMZXZmY1ZCYm5pMWk3OFpTeXc0SmxFUEFE?=
 =?utf-8?B?VU1OSEpRUEV1MnZZeTR3eTJzU3dzOEI4U0NXSjg3T2tGVTJ5cVZ1bEJ3cXhS?=
 =?utf-8?B?VSt1SUhYWXp1b2FhWjlvK1B4NjlmcXJuNlRERUtlOVpTWHp0bFJsbWV3YzFs?=
 =?utf-8?B?QkJUOTJaQTRtdUxrU0d1Mk9OOW5ISlpKZmRnb202eHRSODNESlA3ZjUzMHRR?=
 =?utf-8?B?OEk4NEdocDNGR1NoTk4rU2M3K1FOLzZ1YzRMa3FzcGxYQlladDhqb1BvcDNY?=
 =?utf-8?B?ZkRKS2dQbGlJdXpPam9WaXUzSksxTWZjd1ZBR1IyaTNabXJMeW5ScmkvajJt?=
 =?utf-8?B?T1VZNDhnQTFiNFd3cmFZWGszVWZFU2ZXc3FRMzcxRlY4VDdCZU56dldRMVNo?=
 =?utf-8?B?R3dXNVdTanE0ZlpBVDUycEljUk54dHJqaXRVb0ZZSFRuQkQyZHM3U1Y3UzhD?=
 =?utf-8?B?YUJTMVkwK0dKSXdJSE05V1BUa2o2Zktkbmd5ZHR1Tm5aaTJpYUdvcnBuWWs5?=
 =?utf-8?B?NE9ob29pTWRsbmRadCtpd3l6elVqNGE5RTRPRUt6VEY4a0NxQ3BkYnJRU3cx?=
 =?utf-8?B?bjJkL1dMZXNlS0tiYXBweW1Vc0ErTDdFUkxJME1CMXltY2k0a0Q4Z09TWGg1?=
 =?utf-8?B?akZKdU90VHg1ME1jWHpTczN1bmorUFhZdmtBN1JRSFlRRGx3aFY2M2V1K0VV?=
 =?utf-8?B?bVVNdzZobzNwbUN5Zi9nZGUzd20rdWVkODN1S2VxeTVLVThVby9jK2hlVjJo?=
 =?utf-8?Q?3Rk9HyAoWQbcUYInvD2V2txBE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab96b16-e6bc-49dc-cfae-08dca1936068
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 10:22:32.8906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uwm2mZ8dk5nvVHzh02flKbvoJ9jLkLlX6K/bReFJZXLnZieEthgQMIgGXCy/qdLOlL4p80J+wN1eYJD5vDz9gKHXXuviksH+P+0BmEijnYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDAwLzEwXSBo
dy92ZmlvOiBJT01NVUZEIERpcnR5IFRyYWNraW5nDQo+DQo+T24gMTEvMDcvMjAyNCAwODo0MSwg
Q8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+PiBIZWxsbyBKb2FvLA0KPj4NCj4+IE9uIDcvOC8y
NCA0OjM0IFBNLCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+Pj4gVGhpcyBzbWFsbCBzZXJpZXMgYWRk
cyBzdXBwb3J0IGZvciBJT01NVSBkaXJ0eSB0cmFja2luZyBzdXBwb3J0IHZpYSB0aGUNCj4+PiBJ
T01NVUZEIGJhY2tlbmQuIFRoZSBoYXJkd2FyZSBjYXBhYmlsaXR5IGlzIGF2YWlsYWJsZSBvbiBt
b3N0IHJlY2VudA0KPng4Ng0KPj4+IGhhcmR3YXJlLiBUaGUgc2VyaWVzIGlzIGRpdmlkZWQgb3Jn
YW5pemVkIGFzIGZvbGxvd3M6DQo+Pj4NCj4+PiAqIFBhdGNoIDE6IEZpeGVzIGEgcmVncmVzc2lv
biBpbnRvIG1kZXYgc3VwcG9ydCB3aXRoIElPTU1VRkQuIFRoaXMNCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG9uZSBpcyBpbmRlcGVuZGVudCBvZiB0aGUgc2VyaWVzIGJ1dCBoYXBwZW5lZCB0
byBjcm9zcyBpdA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2hpbGUgdGVzdGluZyBtZGV2
IHdpdGggdGhpcyBzZXJpZXMNCj4+Pg0KPj4+ICogUGF0Y2ggMjogQWRkcyBhIHN1cHBvcnQgdG8g
aW9tbXVmZF9nZXRfZGV2aWNlX2luZm8oKSBmb3IgY2FwYWJpbGl0aWVzDQo+Pj4NCj4+PiAqIFBh
dGNoZXMgMyAtIDc6IElPTU1VRkQgYmFja2VuZCBzdXBwb3J0IGZvciBkaXJ0eSB0cmFja2luZzsN
Cj4+Pg0KPj4+IEludHJvZHVjZSBhdXRvIGRvbWFpbnMgLS0gUGF0Y2ggMyBnb2VzIGludG8gbW9y
ZSBkZXRhaWwsIGJ1dCB0aGUgZ2lzdCBpcw0KPnRoYXQNCj4+PiB3ZSB3aWxsIGZpbmQgYW5kIGF0
dGFjaCBhIGRldmljZSB0byBhIGNvbXBhdGlibGUgSU9NTVUgZG9tYWluLCBvcg0KPmFsbG9jYXRl
IGEgbmV3DQo+Pj4gaGFyZHdhcmUgcGFnZXRhYmxlICpvciogcmVseSBvbiBrZXJuZWwgSU9BUyBh
dHRhY2ggKGZvciBtZGV2cykuDQo+QWZ0ZXJ3YXJkcyB0aGUNCj4+PiB3b3JrZmxvdyBpcyByZWxh
dGl2ZWx5IHNpbXBsZToNCj4+Pg0KPj4+IDEpIFByb2JlIGRldmljZSBhbmQgYWxsb3cgZGlydHkg
dHJhY2tpbmcgaW4gdGhlIEhXUFQNCj4+PiAyKSBUb2dnbGluZyBkaXJ0eSB0cmFja2luZyBvbi9v
ZmYNCj4+PiAzKSBSZWFkLWFuZC1jbGVhciBvZiBEaXJ0eSBJT1ZBcw0KPj4+DQo+Pj4gVGhlIGhl
dXJpc3RpY3Mgc2VsZWN0ZWQgZm9yICgxKSB3ZXJlIHRvIGFsd2F5cyByZXF1ZXN0IHRoZSBIV1BU
IGZvcg0KPj4+IGRpcnR5IHRyYWNraW5nIGlmIHN1cHBvcnRlZCwgb3IgcmVseSBvbiBkZXZpY2Ug
ZGlydHkgcGFnZSB0cmFja2luZy4gVGhpcw0KPj4+IGlzIGEgbGl0dGxlIHNpbXBsaXN0aWMgYW5k
IHdlIGFyZW4ndCBuZWNlc3NhcmlseSB1dGlsaXppbmcgSU9NTVUgZGlydHkNCj4+PiB0cmFja2lu
ZyBldmVuIGlmIHdlIGFzayBkdXJpbmcgaHdwdCBhbGxvY2F0aW9uLg0KPj4+DQo+Pj4gVGhlIHVu
bWFwIGNhc2UgaXMgZGVmZXJyZWQgdW50aWwgZnVydGhlciB2SU9NTVUgc3VwcG9ydCB3aXRoIG1p
Z3JhdGlvbg0KPj4+IGlzIGFkZGVkWzNdIHdoaWNoIHdpbGwgdGhlbiBpbnRyb2R1Y2UgdGhlIHVz
YWdlIG9mDQo+Pj4gSU9NTVVfSFdQVF9HRVRfRElSVFlfQklUTUFQX05PX0NMRUFSIGluIEdFVF9E
SVJUWV9CSVRNQVANCj5pb2N0bCBpbiB0aGUNCj4+PiBkbWEgdW5tYXAgYml0bWFwIGZsb3cuDQo+
Pj4NCj4+PiAqIFBhdGNoZXMgOC0xMDogRG9uJ3QgYmxvY2sgbGl2ZSBtaWdyYXRpb24gd2hlcmUg
dGhlcmUncyBubyBWRiBkaXJ0eQ0KPj4+IHRyYWNrZXIsIGNvbnNpZGVyaW5nIHRoYXQgd2UgaGF2
ZSBJT01NVSBkaXJ0eSB0cmFja2luZy4NCj4+Pg0KPj4+IENvbW1lbnRzIGFuZCBmZWVkYmFjayBh
cHByZWNpYXRlZC4NCj4+Pg0KPj4+IENoZWVycywNCj4+PiDCoMKgwqDCoCBKb2FvDQo+Pj4NCj4+
PiBQLlMuIFN1Z2dlc3QgbGludXgtbmV4dCAob3IgZnV0dXJlIHY2LjExKSBhcyBoeXBlcnZpc29y
IGtlcm5lbCBhcyB0aGVyZSdzDQo+Pj4gc29tZSBidWdzIGZpeGVkIHRoZXJlIHdpdGggcmVnYXJk
cyB0byBJT01NVSBodWdlcGFnZSBkaXJ0eSB0cmFja2luZy4NCj4+Pg0KPj4+IENoYW5nZXMgc2lu
Y2UgUkZDdjJbNF06DQo+Pj4gKiBBbHdheXMgYWxsb2NhdGUgaHdwdCB3aXRoIElPTU1VX0hXUFRf
QUxMT0NfRElSVFlfVFJBQ0tJTkcNCj5ldmVuIGlmDQo+Pj4gd2UgZW5kIHVwIG5vdCBhY3R1YWxs
eSB0b2dnbGluZyBkaXJ0eSB0cmFja2luZy4gKEF2aWhhaSkNCj4+PiAqIEZpeCBlcnJvciBoYW5k
bGluZyB3aWRlbHkgaW4gYXV0byBkb21haW5zIGxvZ2ljIGFuZCBhbGwgcGF0Y2hlcyAoQXZpaGFp
KQ0KPj4+ICogUmV1c2UgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpIGZvciBjYXBh
YmlsaXRpZXMgKFpoZW56aG9uZykNCj4+PiAqIE5ldyBwYXRjaGVzIDEgYW5kIDIgdGFraW5nIGlu
dG8gY29uc2lkZXJhdGlvbiBwcmV2aW91cyBjb21tZW50cy4NCj4+PiAqIFN0b3JlIGh3cHQ6OmZs
YWdzIHRvIGtub3cgaWYgd2UgaGF2ZSBkaXJ0eSB0cmFja2luZyAoQXZpaGFpKQ0KPj4+ICogTmV3
IHBhdGNoIDgsIHRoYXQgYWxsb3dzIHRvIHF1ZXJ5IGRpcnR5IHRyYWNraW5nIHN1cHBvcnQgYWZ0
ZXINCj4+PiBwcm92aXNpb25pbmcuIFRoaXMgaXMgYSBjbGVhbmVyIHdheSB0byBjaGVjayBJT01N
VSBkaXJ0eSB0cmFja2luZyBzdXBwb3J0DQo+Pj4gd2hlbiB2ZmlvOjptaWdyYXRpb24gaXMgaW5p
aXRhbGl6ZWQsIGFzIG9wcG9zZWQgdG8gUkZDdjIgdmlhIGRldmljZSBjYXBzLg0KPj4+IGRldmlj
ZSBjYXBzIHdheSBpcyBzdGlsbCB1c2VkIGJlY2F1c2UgYXQgdmZpbyBhdHRhY2ggd2UgYXJlbid0
IHlldCB3aXRoDQo+Pj4gYSBmdWxseSBpbml0aWFsaXplZCBtaWdyYXRpb24gc3RhdGUuDQo+Pj4g
KiBBZG9wdCBlcnJvciBwcm9wYWdhdGlvbiBpbiBxdWVyeSxzZXQgZGlydHkgdHJhY2tpbmcNCj4+
PiAqIE1pc2MgaW1wcm92ZW1lbnRzIG92ZXJhbGwgYnJvYWRseSBhbmQgQXZpaGFpDQo+Pj4gKiBE
cm9wIGh1Z2VwYWdlcyBhcyBpdCdzIGEgYml0IHVucmVsYXRlZDsgSSBjYW4gcHVyc3VlIHRoYXQg
cGF0Y2gNCj4+PiAqIHNlcGFyYXRlbHkuIFRoZSBtYWluIG1vdGl2YXRpb24gaXMgdG8gcHJvdmlk
ZSBhIHdheSB0byB0ZXN0DQo+Pj4gd2l0aG91dCBodWdlcGFnZXMgc2ltaWxhciB0byB3aGF0DQo+
dmZpb190eXBlMV9pb21tdS5kaXNhYmxlX2h1Z2VwYWdlcz0xDQo+Pj4gZG9lcy4NCj4+Pg0KPj4+
IENoYW5nZXMgc2luY2UgUkZDdjFbMl06DQo+Pj4gKiBSZW1vdmUgaW50ZWwvYW1kIGRpcnR5IHRy
YWNraW5nIGVtdWxhdGlvbiBlbmFibGluZw0KPj4+ICogUmVtb3ZlIHRoZSBkaXJ0eXJhdGUgaW1w
cm92ZW1lbnQgZm9yIFZGL0lPTU1VIGRpcnR5IHRyYWNraW5nDQo+Pj4gW1dpbGwgcHVyc3VlIHRo
ZXNlIHR3byBpbiBzZXBhcmF0ZSBzZXJpZXNdDQo+Pj4gKiBJbnRyb2R1Y2UgYXV0byBkb21haW5z
IHN1cHBvcnQNCj4+PiAqIEVuZm9yY2UgZGlydHkgdHJhY2tpbmcgZm9sbG93aW5nIHRoZSBJT01N
VUZEIFVBUEkgZm9yIHRoaXMNCj4+PiAqIEFkZCBzdXBwb3J0IGZvciB0b2dnbGluZyBodWdlcGFn
ZXMgaW4gSU9NTVVGRA0KPj4+ICogQXV0byBlbmFibGUgc3VwcG9ydCB3aGVuIFZGIHN1cHBvcnRz
IG1pZ3JhdGlvbiB0byB1c2UgSU9NTVUNCj4+PiB3aGVuIGl0IGRvZXNuJ3QgaGF2ZSBWRiBkaXJ0
eSB0cmFja2luZw0KPj4+ICogQWRkIGEgcGFyYW1ldGVyIHRvIHRvZ2dsZSBWRiBkaXJ0eSB0cmFj
a2luZw0KPj4+DQo+Pj4gWzBdDQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDI0MDIwMTA3MjgxOC4zMjc5MzAtMS0NCj56aGVuemhvbmcuZHVhbkBpbnRlbC5jb20vDQo+
Pj4gWzFdDQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDIwMTA3
MjgxOC4zMjc5MzAtMTAtDQo+emhlbnpob25nLmR1YW5AaW50ZWwuY29tLw0KPj4+IFsyXQ0KPj4+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyMjA0MjgyMTEzNTEuMzg5Ny0x
LQ0KPmpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20vDQo+Pj4gWzNdDQo+Pj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDYyMjIxNDg0NS4zOTgwLTEtDQo+am9hby5tLm1h
cnRpbnNAb3JhY2xlLmNvbS8NCj4+PiBbNF0NCj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9x
ZW11LWRldmVsLzIwMjQwMjEyMTM1NjQzLjU4NTgtMS0NCj5qb2FvLm0ubWFydGluc0BvcmFjbGUu
Y29tLw0KPj4+DQo+Pj4gSm9hbyBNYXJ0aW5zICgxMCk6DQo+Pj4gwqDCoCB2ZmlvL2lvbW11ZmQ6
IGRvbid0IGZhaWwgdG8gcmVhbGl6ZSBvbiBJT01NVV9HRVRfSFdfSU5GTyBmYWlsdXJlDQo+Pj4g
wqDCoCBiYWNrZW5kcy9pb21tdWZkOiBFeHRlbmQgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2Vf
aW5mbygpIHRvDQo+ZmV0Y2ggSFcNCj4+PiBjYXBhYmlsaXRpZXMNCj4+PiDCoMKgIHZmaW8vaW9t
bXVmZDogUmV0dXJuIGVycm5vIGluIGlvbW11ZmRfY2Rldl9hdHRhY2hfaW9hc19od3B0KCkNCj4+
PiDCoMKgIHZmaW8vaW9tbXVmZDogSW50cm9kdWNlIGF1dG8gZG9tYWluIGNyZWF0aW9uDQo+Pj4g
wqDCoCB2ZmlvL2lvbW11ZmQ6IFByb2JlIGFuZCByZXF1ZXN0IGh3cHQgZGlydHkgdHJhY2tpbmcg
Y2FwYWJpbGl0eQ0KPj4+IMKgwqAgdmZpby9pb21tdWZkOiBJbXBsZW1lbnQgVkZJT0lPTU1VQ2xh
c3M6OnNldF9kaXJ0eV90cmFja2luZw0KPnN1cHBvcnQNCj4+PiDCoMKgIHZmaW8vaW9tbXVmZDog
SW1wbGVtZW50IFZGSU9JT01NVUNsYXNzOjpxdWVyeV9kaXJ0eV9iaXRtYXANCj5zdXBwb3J0DQo+
Pj4gwqDCoCB2ZmlvL2lvbW11ZmQ6IFBhcnNlIGh3X2NhcHMgYW5kIHN0b3JlIGRpcnR5IHRyYWNr
aW5nIHN1cHBvcnQNCj4+PiDCoMKgIHZmaW8vbWlncmF0aW9uOiBEb24ndCBibG9jayBtaWdyYXRp
b24gZGV2aWNlIGRpcnR5IHRyYWNraW5nIGlzDQo+dW5zdXBwb3J0ZWQNCj4+PiDCoMKgIHZmaW8v
Y29tbW9uOiBBbGxvdyBkaXNhYmxpbmcgZGV2aWNlIGRpcnR5IHBhZ2UgdHJhY2tpbmcNCj4+Pg0K
Pj4+IMKgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5owqDCoMKgwqDCoCB8wqAgMTEgKysN
Cj4+PiDCoCBpbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIHzCoMKgIDIgKw0KPj4+
IMKgIGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiAr
LQ0KPj4+IMKgIGJhY2tlbmRzL2lvbW11ZmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA4MSArKysrKysrKysrLQ0KPj4+IMKgIGh3L3ZmaW8vY29tbW9uLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArDQo+Pj4gwqAgaHcvdmZpby9pb21t
dWZkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjE3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tDQo+Pj4gwqAgaHcvdmZpby9taWdyYXRpb24uY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA3ICstDQo+Pj4gwqAgaHcvdmZpby9wY2kuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsNCj4+PiDCoCBi
YWNrZW5kcy90cmFjZS1ldmVudHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsN
Cj4+PiDCoCA5IGZpbGVzIGNoYW5nZWQsIDMyNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMo
LSkNCj4+DQo+Pg0KPj4gSSBhbSBhIGJpdCBjb25mdXNlZCB3aXRoIGFsbCB0aGUgaW5saW5lIHBy
b3Bvc2Fscy4gV291bGQgeW91IG1pbmQNCj4+IHJlc2VuZGluZyBhIHY0IHBsZWFzZSA/DQo+Pg0K
Pg0KPlllYXAsIEknbGwgc2VuZCBpdCBvdXQgdG9kYXksIG9yIHdvcnN0IGNhc2UgdG9tb3Jyb3cg
bW9ybmluZy4NCj4NCj4+IFJlZ2FyZGluZyBteSBjb21tZW50cyBvbiBlcnJvciBoYW5kbGluZywN
Cj4+DQo+PiBUaGUgZXJyb3Igc2hvdWxkIGJlIHNldCBpbiBjYXNlIG9mIGZhaWx1cmUsIHdoaWNo
IG1lYW5zIGEgcm91dGluZQ0KPj4gY2FuIG5vdCByZXR1cm4gJ2ZhbHNlJyBvciAnLWVycm5vJyBh
bmQgbm90IHNldHRpbmcgJ0Vycm9yICoqJw0KPj4gcGFyYW1ldGVyIGF0IHRoZSBzYW1lIHRpbWUu
DQo+Pg0KPj4gSWYgdGhlIHJldHVybmVkIHZhbHVlIG5lZWRzIHRvIGJlIGludGVycHJldGVkIGlu
IHNvbWUgd2F5cywgZm9yIGENCj4+IHJldHJ5IG9yIGFueSByZWFzb24sIHRoZW4gaXQgbWFrZXMg
c2Vuc2UgdG8gdXNlIGFuIGludCwgZWxzZSBwbGVhc2UNCj4+IHVzZSBhIGJvb2wuIFRoaXMgaXMg
dG8gYXZvaWQgcmFuZG9tIG5lZ2F0aXZlIHZhbHVlcyBiZWluZyBpbnRlcnByZXRlZA0KPj4gYXMg
YW4gZXJybm8gd2hlbiB0aGV5IGFyZSBub3QuDQo+Pg0KPk9LLCBJJ2xsIHJldGFpbiB0aGUgRXJy
b3IqIGNyZWF0aW9uIGV2ZW4gd2hlbiBleHBlY3RpbmcgdG8gdGVzdCB0aGUgZXJybm8uDQo+DQo+
PiBXaXRoIFZGSU8gbWlncmF0aW9uIHN1cHBvcnQsIGxvdyBsZXZlbCBlcnJvcnMgKGZyb20gdGhl
IGFkYXB0ZXIgRlcNCj4+IHRocm91Z2ggdGhlIFZGSU8gUENJIHZhcmlhbnQgZHJpdmVyKSBub3cg
cmVhY2ggdG8gdGhlIGNvcmUgbWlncmF0aW9uDQo+PiBzdWJzeXN0ZW0uIEl0IGlzIHByZWZlcmFi
bGUgdG8gcHJvcGFnYXRlIHRoaXMgZXJyb3IsIHBvc3NpYmx5IGxpdGVyYWwsDQo+PiB0byB0aGUg
Vk1NLCBtb25pdG9yIG9yIGxpYnZpcnQuIEl0J3Mgbm90IGZ1bGx5IHN5bW1ldHJpYyB0b2RheSBi
ZWNhdXNlDQo+PiB0aGUgbG9nX2dsb2JhbF9zdG9wIGhhbmRsZXIgZm9yIGRpcnR5IHRyYWNraW5n
IGVuYWJsZW1lbnQgaXMgbm90DQo+PiBhZGRyZXNzZWQuIEFueWhvdywgYW4gZWZmb3J0IG9uIGVy
cm9yIHJlcG9ydGluZyBuZWVkcyB0byBiZSBtYWRlIGFuZA0KPj4gYW55IHVzZSBvZiBlcnJvcl9y
ZXBvcnQoKSBpbiBhIGxvdyBsZXZlbCBmdW5jdGlvbiBpcyBhIHNpZ24gZm9yDQo+PiBpbXByb3Zl
bWVudC4NCj4+DQo+R290Y2hhLiBNeSBlYXJsaWVyIGNvbW1lbnQgd2FzIG1vc3RseSB0aGF0IGl0
IHNvdW5kZWQgbGlrZSB0aGVyZSB3YXMgbm8NCj5wbGFjZQ0KPmZvciByZXR1cm5pbmcgLWVycm5v
LCBidXQgaXQgc2VlbXMgaXQncyBub3QgdGhhdCBiaW5hcnkgYW5kIHRoZSBFcnJvciogaXMgdGhl
DQo+dGhpbmcgdGhhdCByZWFsbHkgbWF0dGVycyBoZXJlLg0KPg0KPj4gSSB0aGluayBpdCB3b3Vs
ZCBoYXZlIHZhbHVlIHRvIHByb2JlIGVhcmx5IHRoZSBob3N0IElPTU1VIGRldmljZSBmb3INCj4+
IGl0cyBIVyBmZWF0dXJlcy4gSWYgdGhlIHJlc3VsdHMgd2VyZSBjYWNoZWQgaW4gdGhlIEhvc3RJ
T01NVURldmljZQ0KPj4gc3RydWN0LCBpdCB3b3VsZCB0aGVuIHJlbW92ZSB1bm5lY2Vzc2FyeSBh
bmQgcmVkdW5kYW50IGNhbGxzIHRvIHRoZQ0KPj4gaG9zdCBrZXJuZWwgYW5kIGF2b2lkIGVycm9y
IGhhbmRsaW5nIGluIGNvbXBsZXggY29kZSBwYXRocy4gSSBob3BlDQo+PiB0aGlzIGlzIGZlYXNp
YmxlLiBJIGhhdmVuJ3QgbG9va2VkIGNsb3NlbHkgdGJoLg0KPj4NCj5PSywgSSdsbCBwb3N0IGlu
IHRoaXMgc2VyaWVzIHdoYXQgSSBoYWQgaW5saW5lWzBdLCBhcyB0aGF0J3Mgd2hhdCBJIGRpZC4N
Cj4NCj5bMF0NCj5odHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzRlODVkYjA0LWZi
YWEtNGE2Yi1iMTMzLQ0KPjU5MTcwYzQ3MWUyNEBvcmFjbGUuY29tLw0KPg0KPlRoZSBnb3RjaGEg
aW4gbXkgb3BpbmlvbiBpcyB0aGF0IEkgY2FjaGUgSU9NTVVGRCBzcGVjaWZpYyBkYXRhIHJldHVy
bmVkIGJ5DQo+dGhlDQo+R0VUX0hXX0lORk8gaW9jdGwgaW5zaWRlIGEgbmV3IEhvc3RJT01NVURl
dmljZUNhcHM6OmlvbW11ZmQuIFRoZQ0KPnJlYXNvbiBiZWluZw0KPnRoYXQgdmZpb19kZXZpY2Vf
Z2V0X2F3X2JpdHMoKSBoYXMgYSBoaWRkZW4gYXNzdW1wdGlvbiB0aGF0IHRoZSBjb250YWluZXIN
Cj5pcw0KPmFscmVhZHkgcG9wdWxhdGVkIHdpdGggdGhlIGxpc3Qgb2YgYWxsb3dlZCBpb3ZhIHJh
bmdlcywgd2hpY2ggaXMgbm90IHRydWUgZm9yDQo+dGhlIGZpcnN0IGRldmljZS4gU28gcmF0aGVy
IHRoYW4gaGF2ZSBwYXJ0aWFsIHNldCBvZiBjYXBzIGluaXRpYWxpemVkLCBJDQo+ZXNzZW50aWFs
bHkgZW5kZWQgdXAgd2l0aCBmZXRjaGluZyB0aGUgcmF3IGNhcHMgYW5kIHN0b3JlIHRoZW0sIGFu
ZCBzZXJpYWxpemUNCj5jYXBzIGludG8gbmFtZWQgZmVhdHVyZXMgKGUuZy4gY2Fwczo6YXdfYml0
cykgaW4NCj5Ib3N0SU9NTVVEZXZpY2U6OnJlYWxpemUoKS4NCg0KQW5vdGhlciB3YXkgaXMgdG8g
Y2FsbCB2ZmlvX2RldmljZV9nZXRfYXdfYml0cygpIGFuZCByZXR1cm4gaXRzIHJlc3VsdCBkaXJl
Y3RseQ0KaW4gZ2V0X2NhcCgpLCB0aGVuIG5vIG5lZWQgdG8gaW5pdGlhbGl6ZSBjYXBzOjphd19i
aXRzLg0KVGhpcyB3YXkgaG9zdCBJT01NVSBkZXZpY2UgY2FuIGJlIG1vdmVkIGFoZWFkIGFzIEPD
qWRyaWMgc3VnZ2VzdGVkLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiBXZSBhcmUgcmVh
Y2hpbmcgc29mdCBmcmVlemUsIGluIH4xMCBkYXlzLiBUaGVyZSBpcyBhIGNoYW5jZSB0aGlzDQo+
PiBwcm9wb3NhbCBjb3VsZCBtYWtlIGl0IGZvciA5LjEuDQo+Pg0KPj4gVGhhbmtzLA0KPj4NCj4+
IEMuDQo+Pg0KDQo=

