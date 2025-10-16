Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80214CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Jeq-0008AR-40; Thu, 16 Oct 2025 04:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9Jeo-0008AI-1q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:48:22 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9Jej-0004jN-UB
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760604498; x=1792140498;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vdSkxvBDWV+OceMIEAf+X+GQmfWVwEFVLWdDQlk/dzM=;
 b=BPAdzm4h6x5gkTOQwdGBknm7XOAvj0dNJVl3u0W8fu+y51AylhSOTksw
 VmmsIyM19RaSfyv8TpyuZvvcik8AnBSAwAp1N0fqDY5h/k3dTF2h4mVLr
 CSaoO3SyCFwSqKJR0Fk+tHwTwlfGAhs6W+prPuT7ps5+oflbMdwVy2XQo
 lCUJMW+sW5MokeHRZW48Z43NjHXxQwSKlQVbwAT+auZwj4VLNRTfKE1Ey
 0bmigZdiFduoE4uUoZJF7TBARFQrfqy5wo6dEgWYLGObtO/CbbTx3PwqT
 Rj7dAcYweGMNAwthHEupvkAhRQOlx5tgvPdCQNhHxeOwjeNj73Yk9TBXr A==;
X-CSE-ConnectionGUID: Q6lDF1GHTpWP1YeEuKiVVA==
X-CSE-MsgGUID: YQDAnSiyTmSWZ2aRbMhXUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62830976"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="62830976"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:48:10 -0700
X-CSE-ConnectionGUID: Hp94x0AHTKuCZQOOnHZwvQ==
X-CSE-MsgGUID: UQPutSvzTp60S7lK3VzFoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="186669331"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:48:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:48:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 01:48:08 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7Ph5k32pJylx/47+aZiO/KJTKwI+WlKIHCmBGV8gVlnSjlHXTxSMHKxby9XjJgY3HWj2m1jowocFpizsGYrSz8NXb/vm+dVX3Bav4rXOQRvluIwvtBb0usK0D6qtSUVPK+CgpclxjjfCX1Frc7GfftlpaTVSyZqiXRT338SKjyII91EMuPJOBpMJRyPHXeIFjsmYk0ECWRh1ehgGB/4r0fbsDpgXeo/1OALxly1EGcaz7ssY96uAFT0KEr1W2EpQRlR3XVwu2z43ojM/Zjm+LX97VAF8ntwgipWrKue+8t1fY6YCiT8thc9f9UZ0a3i8R+12BzwBCya+u1mgUVmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdSkxvBDWV+OceMIEAf+X+GQmfWVwEFVLWdDQlk/dzM=;
 b=tQCy/hf4qDWEH2SrbXHcJu5rOmX1fnyq7SK9Gu9IA+XqUkS19ReJ/k/i3GM9w7a7zP9J0rNq7lvGE70qxs56e/bF8KXmze3wHlfrPrfQKo/9Gpb8CI/9gqCBP0LkjxFzYxOGJpv8OG1VuwEvhqv7RDga25C5/V26JHyvDDM+yfJ7H9gGqEAH/ayib2jhXeDVmcCXHm7mDoHyIkq9C3jGO123gVSLYoWnMkGFZHICz6Vtw6sA7VUfzCQE2YvImgzPRGAGHXTVGzWvxGlqVYiSrrW6XppF0UCC95mwEyPLwV4CypEaLKtwZ+i1eB+WlkBL6GjSyYrdttNZZm5WVNXd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 16 Oct
 2025 08:48:05 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 08:48:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Topic: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Index: AQHcIfvpBR8EG6fncUCmXH17xc4ayLS+gq4AgAEL66CAAK7kAIAA3gSggABNBgCAABhnoIAB4aOAgAFLPUA=
Date: Thu, 16 Oct 2025 08:48:05 +0000
Message-ID: <IA3PR11MB9136B2CF78F1473BED36E1B492E9A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
 <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
 <IA3PR11MB9136AEE8F0C3A989C964E35092E8A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9fabdf4a-a781-491a-bbd2-40e51462b8e7@intel.com>
In-Reply-To: <9fabdf4a-a781-491a-bbd2-40e51462b8e7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH0PR11MB5298:EE_
x-ms-office365-filtering-correlation-id: ecbfedd4-92c5-4c6f-8338-08de0c90b947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TEtSUmUya3BFYlBqakhPdFBuVUxDdVJBUFJCTGxqTWl4RmFoUHFiZ1dreEda?=
 =?utf-8?B?ZDZnQ3Q5MytjdjQzbks4UWZ0NTUwajF5ZHZDSmJiZE5RQ1g2Rlhxb2tsWFFJ?=
 =?utf-8?B?Tkw3RVFRaG9lcTNDdkNnZElicU91RjRubnNjQTNPRUpyazdpZ1ZxdGNqMzRu?=
 =?utf-8?B?V0wzVXVjcWZ1Ulh2V2dBSVlEcTBBMmYvRzd3ZkhYS0YyZjc0OHJzcEk2ZDVG?=
 =?utf-8?B?cGxpbVUybmdrRXV4KzZWVm5majhxVFpTRndWSGF6Y3UxTkVqMTJBMXpNYk12?=
 =?utf-8?B?YklGeldSbEpEMUdMNDlvaFBKUkY1ZFdjNmp1SzlnN2UrdVh1VGpKODNpelhj?=
 =?utf-8?B?QTBWOFQxdEpyUW5wT25NYkFlNXpvTXp0enRXMGdaYkFCclFDbUJ1NlhIZzlq?=
 =?utf-8?B?d0xGZHdUYW9lSEY4YWE2RVNMUFBDemJoQlgvODZvZU5URC9uNGx2U0FSeW9D?=
 =?utf-8?B?Y2Z3OE5uRjd0TzR1dzBiV2FibEhQNDBWK3prLzdaakU3NG8wMStBK29kWmdk?=
 =?utf-8?B?UnhmaGUrc3BJL011d2xQY0lQZ3pRNTd1YmdFSzFQSmUyK296ZE5oWnlsdW5R?=
 =?utf-8?B?KzR3Y213UmQ5YzhCN3NqQ2pzVndGS0RaRDZra3ZLNXc2OGVIUHRTN3pTSGpl?=
 =?utf-8?B?M3NKalphTmYwZ25aaFNsNUlsc3ViQzcwYkdEczFWa0dGK0U1NFdPYXA3UWZ4?=
 =?utf-8?B?cmhyak1oenk1NXhDZkZiUU1Db1IyY3BZZmcvQUs4NktxMlFLcUwvdzFpUUZH?=
 =?utf-8?B?cWc0TllrVnN4Ull0bW1sQzRvdGZNU29EOE93K21ZclJpSERDcWxUMEVXeWFL?=
 =?utf-8?B?blFXaXlxbUJCa05HMWNydEp5M1c1UzliUHBuSGNzeVpqZDB1N0lNUlpHcnZ5?=
 =?utf-8?B?YXR0NnAzbm9SeWdZaHQzVkFDYlEwNFE2NVBDRW9UWitTd1p1MDBIUGVKVjky?=
 =?utf-8?B?SkdHRGNtQktEZEVVcWVSOEJPOFJBWUplY2E3b3dyYUNTdG5QTWp0dSt4b0Z1?=
 =?utf-8?B?WnBtZkF6TVkyK21BbDNyVFJUWDlxR1MwdjNHTkI2L3lXRi9sa1QyNGFLQ292?=
 =?utf-8?B?Y1hNV0V3clR1MXEzam5UdEc4V0VhQlY3Q3FUNU5xSURnK3J2NHZqUlJhQVd5?=
 =?utf-8?B?RlBoNDFIdUh2OE9RN0RLS1dYMmQ5QVgvNU81ZjZobHlqcnp3ZXNLMi8zbEZL?=
 =?utf-8?B?SmsySm1hRmRLVXRUWXFKYmNUd2xuZHEwQ0dnYUpvRnlxN3pweFo1dmNtNU4r?=
 =?utf-8?B?cnc4NUExTCtUUHRwMkZTK0FMM3hZNGRDcU9nOTBTejAwMDJmSlVyR0dkV2Fr?=
 =?utf-8?B?eW5uR2NDYTB4UXd2aGFaVlZ1cE1rNUhoR0VJYmFZZ0JwUUpBSG1Kc2hiTmVJ?=
 =?utf-8?B?ays3c0Y2b0FQbmJBc2FPTkNVUTAzWlR5U2VGNDk4d1ppNkNhaFhLWkhoSm1S?=
 =?utf-8?B?ckl5U3hwR2FxNmJCb3BkcHBKbmxaUDExMUF2U08yM05TOTM3MFZaeGsvMG5P?=
 =?utf-8?B?bVVPUnhQTWdxd2hpYnRIbTMvNG1VSzJIaDVBNithYi9IUmpMbjVscTI5Z1Z6?=
 =?utf-8?B?cFpIRGVFQzNpYlc1eTh0c2J4cXZrZU5NMVJvNWI1c0NSbnFtcHc3TldKaEty?=
 =?utf-8?B?bWd6Vnk2ZkpEL24xV1V3ODF5NU0ybHYzNWhiaTQvcFgwZWNKWjRlS1RiSXF2?=
 =?utf-8?B?d1hYbzh6a1JGblgvTGF6SDBNN3VkeGhjOXdTZ2ZpY09XV2NpSm1hd0VUVkRn?=
 =?utf-8?B?RW5xaExpRGZDYUl6WTJBRGJQNlgrbEJOa2JVYWxqcXJTMndJK25KNDdmTUlo?=
 =?utf-8?B?cUFZL3BPcWUyNlVQaXRoQlNoMDNOWEdDM2hRMUJuV0E1eUUwODV2U2JwaU10?=
 =?utf-8?B?aFc5Nm9qWmI2UGQ3c3VZZFhUNGVMc28yQ3crUXJ4elk0ekFoQkZsSy8zdEdU?=
 =?utf-8?B?b29GV1FjeloyRG16UUVSN0Rha0JVZGNNM2UwZElQNmZlN2tYVVZMU0VoRWFz?=
 =?utf-8?B?YVVja0pDZ2ljRGxiN1dMODZkc2Vlckt2S1pnU2NQUGkzZkdHbTI3bzNCeGlr?=
 =?utf-8?Q?0iuB0m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eExCQ1YwTUpjUkhCSlJKcWwrSU4ydmMxdmY5TTdrZkhHazVrczhuQ3dVQTBU?=
 =?utf-8?B?aUZ6b09VV3pFN3psWXZlRDltdVNOYkhMbHVoNHBBRjdBOUxVd2JnMzlRd0I1?=
 =?utf-8?B?YVFwclBqS0NIdWdJZHFEMHZKYXRzUkpleDRhd2hHNVpxczU2ZlgvTUNBYjd0?=
 =?utf-8?B?bVp1a0ZBeTJJYUZ2elVQT212RXovenpYN0FSNjNZbzJKMWpSWnVMcGJRblQr?=
 =?utf-8?B?dDk3VjhQQ0hDMTFHWldWS3VsS00xNEVZMEpkTjd4TUpRVDJRbDdtVGMwWWcx?=
 =?utf-8?B?LzM1dzJZNmRRUTFpc29QM0Z3UURaMU9RUk05a3pYaVFlZVFyK2kxTUJrVlBz?=
 =?utf-8?B?U1l6RHBXNlJJQlE2VmdJcFZ0UTkvN0ozUDR6bFRZK0VJUG0wVjNqUitMdTh3?=
 =?utf-8?B?Kzc3NUZVcThTM1g1ampqaW4vK3d1Sm9tZXd5cDF0eEliRHpMbU1HRW9IS3o3?=
 =?utf-8?B?eHRvQVA4THFQVVZLRUYzQTNqVEQvUXI3dkd1WVRidWJrRlBBdHBwQ2hMNXpG?=
 =?utf-8?B?dEVMbnIxTUNTelYxY1dpVFhjb1NVcmN5Q3NRWGtVSHFaY0pmaFdBZEZFK3hF?=
 =?utf-8?B?VjRqYjdoUWQ0bFc2T1pPODhVSms2OWNLRXFoRHliM3V6QkdwUy9Qa0wzN2Rv?=
 =?utf-8?B?aE5NOExxc01XS00vUm9XMC9MOCtIaHRTOVhJZzhHOVRERmgwWXVXOEVnTjJS?=
 =?utf-8?B?QUwxbW1QMGlCYkxsWmp5RzBVUUozamdZVlNlL3gxbEkweGs3WVU1dk45U2pu?=
 =?utf-8?B?V3BuTnZTaURDSXk4THBMQ0cycUhtUGJ6VXc5N1VJS0VnbjNaUUxxZU94UHhD?=
 =?utf-8?B?SlpWUGZDVHQ0ZUFuOUJ5bTNNMkFoeTUwdlQwWVFNYlR6VTVZa1YvM0MxYkJH?=
 =?utf-8?B?YjdPNittSzJjdUNsWjg5NEIzdnlGYUQ0eEdMaFBDVElacWczdjl3bWhSYUtz?=
 =?utf-8?B?RzROZ2YxWGdqNDQ2N2F3VEV1SFRrbVppK3BQVUF1d01sRXVkV241c0lxaDQr?=
 =?utf-8?B?eldnMHhHYnhBNVJkZkNTY3BtSHcyaStLZ2tRT0s3ZzNxWTFRL0NNaHlrc3N3?=
 =?utf-8?B?a1FPcnVEZGJCMHFoZms1SGN2eVFQYlU4Zlg3S1FZVGZPdWd5dGsyTGZrZFIr?=
 =?utf-8?B?VURidWVmcW4vUWpPYnRJY0FwZjJuNFpWUTVXNDlZT3UwT2FhRWZrendUTHA2?=
 =?utf-8?B?VDN6KzJObG5CWS9LcmRGVlFkQVVWeWs5a21hQ2RHYWRBREprcS9LcFNLZ0ov?=
 =?utf-8?B?bis3cUNCbVhsZmFuYTBZTytjdHVpTlV2UlJESlBuYWo2SnJNek8vTEtTQUw1?=
 =?utf-8?B?eSsraUd1V01DelpUcEN6QnZXWXF0MzBKT1kyV1ZiVjg0bVV2OXJHa0QybDRM?=
 =?utf-8?B?NlZFL0JSSUxWZ2NHQUM4L3NMckRFa0tUYVhWa3VQM0hoM29hWGFlWmZPQnFn?=
 =?utf-8?B?c2haRmNxcGRUMFgwcjlSNmVmY2Z6NGlraTd1QUV5VEorM2VVN0NpNmJVbVBv?=
 =?utf-8?B?S090RTRYcU8ranRWbE51K082NWpabERQRlhYdTRlK25uMDYweHMzWE9jeG9C?=
 =?utf-8?B?WW0rWTB3L001SFppa0ZwTG92NWRiQkI4eVhRUDFEd3ZXaThxR1NCWncxbmlO?=
 =?utf-8?B?MVNZOWwzK0t2QjhpdzcxckZ0a2R0VHpkL1NWMzNoOEV3Q0RLV2hvRUtnMTQ3?=
 =?utf-8?B?aWRybDR0RUNya0xiVjJnNGRnQnpHTER1RlIvcFVrS3g4QUMyMnR0ekg2VHM2?=
 =?utf-8?B?bkxNU1hvOXl3a2J3TUwrVUcvMzBuWnlUOVFzeGRIOENOUitXbzNJRGJmNXM3?=
 =?utf-8?B?WTBzTXI0OEhpcGpkL3VWY0RKdGhYSy9JMTlVY3lqMUNqSkt0WEdXRXIwRzBT?=
 =?utf-8?B?TUdscFIvZ1dEZ0tacFN2SVZ3d0tlRzJHRGpsZWdSZzl3UmFQNjBoK1NOL1hw?=
 =?utf-8?B?ZnprYzRCbW1IemdzaWpGaU5JVExoMGJqWkxoV2UwLzJZcG52ZnhrL2ZvaHl1?=
 =?utf-8?B?cG5hVXJQYTVORzhUMlpuRGkwNVlPOWRrKzJTVEJvYnhyd09zQUJvZzhJZUNR?=
 =?utf-8?B?VDNEekdPMytPQWZqWHlnN3ZBQjRCWitxOWNtYWZncWRJbTZ4aXZkZ05ydTlr?=
 =?utf-8?Q?0yZ3JPJEyKdxCwYqH1RTB+f6e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbfedd4-92c5-4c6f-8338-08de0c90b947
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 08:48:05.6411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XFoqqfgPzJdenreRqXYDAfUh9fqS7X57dpdnwLNw+yYSO+d7L3/GZ6jau/bpO6txiJUwDHYFPHfbfJznlT1cqM9GiCT8eLVPRvelIYMZx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBpbnRlbF9pb21tdTogT3B0
aW1pemUgdW5tYXBfYml0bWFwIGR1cmluZw0KPm1pZ3JhdGlvbg0KPg0KPk9uIDIwMjUvMTAvMTUg
MTU6NDgsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzVdIGludGVsX2lvbW11OiBPcHRpbWl6ZSB1bm1hcF9i
aXRtYXAgZHVyaW5nDQo+Pj4gbWlncmF0aW9uDQo+Pj4NCj4+PiBPbiAyMDI1LzEwLzE0IDEwOjMx
LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+
DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gaW50ZWxfaW9tbXU6IE9wdGltaXplIHVu
bWFwX2JpdG1hcCBkdXJpbmcNCj4+Pj4+IG1pZ3JhdGlvbg0KPj4+Pj4NCj4+Pj4+IE9uIDIwMjUv
MTAvMTMgMTA6NTAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+Pj4+IEZyb206IExpdSwgWWkgTCA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gaW50
ZWxfaW9tbXU6IE9wdGltaXplIHVubWFwX2JpdG1hcA0KPmR1cmluZw0KPj4+Pj4+PiBtaWdyYXRp
b24NCj4+Pj4+Pj4NCj4+Pj4+Pj4gT24gMjAyNS85LzEwIDEwOjM3LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+Pj4+Pj4+IElmIGEgVkZJTyBkZXZpY2UgaW4gZ3Vlc3Qgc3dpdGNoZXMgZnJvbSBJ
T01NVSBkb21haW4gdG8gYmxvY2sNCj4+PiBkb21haW4sDQo+Pj4+Pj4+PiB2dGRfYWRkcmVzc19z
cGFjZV91bm1hcCgpIGlzIGNhbGxlZCB0byB1bm1hcCB3aG9sZSBhZGRyZXNzDQo+c3BhY2UuDQo+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSWYgdGhhdCBoYXBwZW5zIGR1cmluZyBtaWdyYXRpb24sIG1pZ3Jh
dGlvbiBmYWlscyB3aXRoIGxlZ2FjeSBWRklPDQo+Pj4+Pj4+PiBiYWNrZW5kIGFzIGJlbG93Og0K
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+IFN0YXR1czogZmFpbGVkICh2ZmlvX2NvbnRhaW5lcl9kbWFfdW5t
YXAoMHg1NjFiYmJkOTJkOTAsDQo+Pj4+Pj4+IDB4MTAwMDAwMDAwMDAwLCAweDEwMDAwMDAwMDAw
MCkgPSAtNyAoQXJndW1lbnQgbGlzdCB0b28gbG9uZykpDQo+Pj4+Pj4+DQo+Pj4+Pj4+IHRoaXMg
c2hvdWxkIGJlIGEgZ2lhbnQgYW5kIGJ1c3kgVk0uIHJpZ2h0PyBJcyBhIGZpeCB0YWcgbmVlZGVk
IGJ5IHRoZQ0KPj4+IHdheT8NCj4+Pj4+Pg0KPj4+Pj4+IFZNIHNpemUgaXMgdW5yZWxhdGVkLCBp
dCdzIG5vdCBhIGJ1ZywganVzdCBjdXJyZW50IGNvZGUgZG9lc24ndCB3b3JrIHdlbGwNCj4+PiB3
aXRoDQo+Pj4+PiBtaWdyYXRpb24uDQo+Pj4+Pj4NCj4+Pj4+PiBXaGVuIGRldmljZSBzd2l0Y2hl
cyBmcm9tIElPTU1VIGRvbWFpbiB0byBibG9jayBkb21haW4sIHRoZQ0KPndob2xlDQo+Pj4+PiBp
b21tdQ0KPj4+Pj4+IG1lbW9yeSByZWdpb24gaXMgZGlzYWJsZWQsIHRoaXMgdHJpZ2dlciB0aGUg
dW5tYXAgb24gdGhlIHdob2xlIGlvbW11DQo+Pj4+PiBtZW1vcnkNCj4+Pj4+PiByZWdpb24sDQo+
Pj4+Pg0KPj4+Pj4gSSBnb3QgdGhpcyBwYXJ0Lg0KPj4+Pj4NCj4+Pj4+PiBubyBtYXR0ZXIgaG93
IG1hbnkgb3IgaG93IGxhcmdlIHRoZSBtYXBwaW5ncyBhcmUgaW4gdGhlIGlvbW11IE1SLg0KPj4+
Pj4NCj4+Pj4+IGhtbW0uIEEgbW9yZSBleHBsaWNpdCBxdWVzdGlvbjogZG9lcyB0aGlzIGVycm9y
IGhhcHBlbiB3aXRoIDRHIFZNDQo+Pj4gbWVtb3J5DQo+Pj4+PiBhcyB3ZWxsPw0KPj4+Pg0KPj4+
PiBDb2luY2lkZW50bHksIEkgcmVtZW1iZXIgUUFUIHRlYW0gcmVwb3J0ZWQgdGhpcyBpc3N1ZSBq
dXN0IHdpdGggNEcgVk0NCj4+PiBtZW1vcnkuDQo+Pj4NCj4+PiBvay4gdGhpcyBtaWdodCBoYXBw
ZW4gd2l0aCBsZWdhY3kgdklPTU1VIGFzIGd1ZXN0IHRyaWdnZXJzIG1hcC91bm1hcC4NCj4+PiBJ
dCBjYW4gYmUgYSBsYXJnZSByYW5nZS4gQnV0IGl0J3Mgc3RpbGwgbm90IGNsZWFyIHRvIG1lIGhv
dyBjYW4gZ3Vlc3QNCj4+PiBtYXAgYSByYW5nZSBtb3JlIHRoYW4gNEcgaWYgVk0gb25seSBoYXMg
NEcgbWVtb3J5Lg0KPj4NCj4+IEl0IGhhcHBlbnMgd2hlbiBndWVzdCBzd2l0Y2ggZnJvbSBETUEg
ZG9tYWluIHRvIGJsb2NrIGRvbWFpbiwgYmVsb3cNCj5zZXF1ZW5jZSBpcyB0cmlnZ2VyZWQ6DQo+
Pg0KPj4gdnRkX2NvbnRleHRfZGV2aWNlX2ludmFsaWRhdGUNCj4+IAl2dGRfYWRkcmVzc19zcGFj
ZV9zeW5jDQo+PiAJCXZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwDQo+Pg0KPj4gWW91IGNhbiBzZWUg
dGhlIHdob2xlIGlvbW11IGFkZHJlc3Mgc3BhY2UgaXMgdW5tYXBwZWQsIGl0J3MgdW5yZWxhdGVk
IHRvDQo+YWN0dWFsIG1hcHBpbmcgaW4gZ3Vlc3QuDQo+DQo+Z290IGl0Lg0KPg0KPj4+DQo+Pj4+
DQo+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEJlY2F1c2UgbGVnYWN5IFZGSU8g
bGltaXRzIG1heGltdW0gYml0bWFwIHNpemUgdG8gMjU2TUIgd2hpY2gNCj4+PiBtYXBzDQo+Pj4+
PiB0bw0KPj4+Pj4+PiA4VEIgb24NCj4+Pj4+Pj4+IDRLIHBhZ2Ugc3lzdGVtLCB3aGVuIDE2VEIg
c2l6ZWQgVU5NQVAgbm90aWZpY2F0aW9uIGlzIHNlbnQsDQo+Pj4+Pj4+IHVubWFwX2JpdG1hcA0K
Pj4+Pj4+Pj4gaW9jdGwgZmFpbHMuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gVGhlcmUgaXMgbm8gc3Vj
aCBsaW1pdGF0aW9uIHdpdGggaW9tbXVmZCBiYWNrZW5kLCBidXQgaXQncyBzdGlsbCBub3QNCj4+
PiBvcHRpbWFsDQo+Pj4+Pj4+PiB0byBhbGxvY2F0ZSBsYXJnZSBiaXRtYXAuDQo+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4gT3B0aW1pemUgaXQgYnkgaXRlcmF0aW5nIG92ZXIgRE1BTWFwIGxpc3QgdG8gdW5t
YXAgZWFjaCByYW5nZSB3aXRoDQo+Pj4+PiBhY3RpdmUNCj4+Pj4+Pj4+IG1hcHBpbmcgd2hlbiBt
aWdyYXRpb24gaXMgYWN0aXZlLiBJZiBtaWdyYXRpb24gaXMgbm90IGFjdGl2ZSwNCj4+PiB1bm1h
cHBpbmcNCj4+Pj4+IHRoZQ0KPj4+Pj4+Pj4gd2hvbGUgYWRkcmVzcyBzcGFjZSBpbiBvbmUgZ28g
aXMgb3B0aW1hbC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcg
RHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+Pj4+Pj4gVGVzdGVkLWJ5OiBHaW92
YW5uaW8gQ2FiaWRkdSA8Z2lvdmFubmkuY2FiaWRkdUBpbnRlbC5jb20+DQo+Pj4+Pj4+PiAtLS0N
Cj4+Pj4+Pj4+ICAgICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNDINCj4+Pj4+Pj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+PiAgICAgIDEgZmls
ZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+
Pj4gaW5kZXggODNjNWU0NDQxMy4uNjg3NmRhZTcyNyAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+Pj4+Pj4+PiBAQCAtMzcsNiArMzcsNyBAQA0KPj4+Pj4+Pj4gICAgICAjaW5jbHVkZSAic3lz
dGVtL3N5c3RlbS5oIg0KPj4+Pj4+Pj4gICAgICAjaW5jbHVkZSAiaHcvaTM4Ni9hcGljX2ludGVy
bmFsLmgiDQo+Pj4+Pj4+PiAgICAgICNpbmNsdWRlICJrdm0va3ZtX2kzODYuaCINCj4+Pj4+Pj4+
ICsjaW5jbHVkZSAibWlncmF0aW9uL21pc2MuaCINCj4+Pj4+Pj4+ICAgICAgI2luY2x1ZGUgIm1p
Z3JhdGlvbi92bXN0YXRlLmgiDQo+Pj4+Pj4+PiAgICAgICNpbmNsdWRlICJ0cmFjZS5oIg0KPj4+
Pj4+Pj4NCj4+Pj4+Pj4+IEBAIC00NDIzLDYgKzQ0MjQsNDIgQEAgc3RhdGljIHZvaWQNCj4+Pj4+
Pj4gdnRkX2Rldl91bnNldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwg
aW50IGRldmZuKQ0KPj4+Pj4+Pj4gICAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+Pj4+
Pj4+ICAgICAgfQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICsvKg0KPj4+Pj4+Pj4gKyAqIFVubWFwcGlu
ZyBhIGxhcmdlIHJhbmdlIGluIG9uZSBnbyBpcyBub3Qgb3B0aW1hbCBkdXJpbmcNCj5taWdyYXRp
b24NCj4+Pj4+Pj4gYmVjYXVzZQ0KPj4+Pj4+Pj4gKyAqIGEgbGFyZ2UgZGlydHkgYml0bWFwIG5l
ZWRzIHRvIGJlIGFsbG9jYXRlZCB3aGlsZSB0aGVyZSBtYXkgYmUNCj5vbmx5DQo+Pj4+PiBzbWFs
bA0KPj4+Pj4+Pj4gKyAqIG1hcHBpbmdzLCBpdGVyYXRlIG92ZXIgRE1BTWFwIGxpc3QgdG8gdW5t
YXAgZWFjaCByYW5nZSB3aXRoDQo+Pj4gYWN0aXZlDQo+Pj4+Pj4+IG1hcHBpbmcuDQo+Pj4+Pj4+
PiArICovDQo+Pj4+Pj4+PiArc3RhdGljIHZvaWQNCj4+PiB2dGRfYWRkcmVzc19zcGFjZV91bm1h
cF9pbl9taWdyYXRpb24oVlREQWRkcmVzc1NwYWNlDQo+Pj4+Pj4+ICphcywNCj4+Pj4+Pj4+ICsN
Cj4+Pj4+Pj4gSU9NTVVOb3RpZmllciAqbikNCj4+Pj4+Pj4+ICt7DQo+Pj4+Pj4+PiArICAgIGNv
bnN0IERNQU1hcCAqbWFwOw0KPj4+Pj4+Pj4gKyAgICBjb25zdCBETUFNYXAgdGFyZ2V0ID0gew0K
Pj4+Pj4+Pj4gKyAgICAgICAgLmlvdmEgPSBuLT5zdGFydCwNCj4+Pj4+Pj4+ICsgICAgICAgIC5z
aXplID0gbi0+ZW5kLA0KPj4+Pj4+Pj4gKyAgICB9Ow0KPj4+Pj4+Pj4gKyAgICBJT1ZBVHJlZSAq
dHJlZSA9IGFzLT5pb3ZhX3RyZWU7DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArICAgIC8qDQo+Pj4+
Pj4+PiArICAgICAqIERNQU1hcCBpcyBjcmVhdGVkIGR1cmluZyBJT01NVSBwYWdlIHRhYmxlIHN5
bmMsIGl0J3MNCj5laXRoZXINCj4+Pj4+IDRLQg0KPj4+Pj4+PiBvciBodWdlDQo+Pj4+Pj4+PiAr
ICAgICAqIHBhZ2Ugc2l6ZSBhbmQgYWx3YXlzIGEgcG93ZXIgb2YgMiBpbiBzaXplLiBTbyB0aGUg
cmFuZ2Ugb2YNCj4+Pj4+Pj4gRE1BTWFwIGNvdWxkDQo+Pj4+Pj4+PiArICAgICAqIGJlIHVzZWQg
Zm9yIFVOTUFQIG5vdGlmaWNhdGlvbiBkaXJlY3RseS4NCj4+Pj4+Pj4+ICsgICAgICovDQo+Pj4+
Pj4+PiArICAgIHdoaWxlICgobWFwID0gaW92YV90cmVlX2ZpbmQodHJlZSwgJnRhcmdldCkpKSB7
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IGhvdyBhYm91dCBhbiBlbXB0eSBpb3ZhX3RyZWU/IElmIGd1ZXN0
IGhhcyBub3QgbWFwcGVkIGFueXRoaW5nIGZvcg0KPj4+IHRoZQ0KPj4+Pj4+PiBkZXZpY2UsIHRo
ZSB0cmVlIGlzIGVtcHR5LiBBbmQgaXQgaXMgZmluZSB0byBub3QgdW5tYXAgYW55dGluZy4gV2hp
bGUsDQo+Pj4+Pj4+IGlmIHRoZSBkZXZpY2UgaXMgYXR0YWNoZWQgdG8gYW4gaWRlbnRpZnkgZG9t
YWluLCB0aGUgaW92YV90cmVlIGlzIGVtcHR5DQo+Pj4+Pj4+IGFzIHdlbGwuIEFyZSB3ZSBzdXJl
IHRoYXQgd2UgbmVlZCBub3QgdG8gdW5tYXAgYW55dGhpbmcgaGVyZT8gSXQNCj5sb29rcw0KPj4+
Pj4+PiB0aGUgYW5zd2VyIGlzIHllcy4gQnV0IEknbSBzdXNwZWN0aW5nIHRoZSB1bm1hcCBmYWls
dXJlIHdpbGwgaGFwcGVuIGluDQo+Pj4+Pj4+IHRoZSB2ZmlvIHNpZGU/IElmIHllcywgbmVlZCB0
byBjb25zaWRlciBhIGNvbXBsZXRlIGZpeC4gOikNCj4+Pj4+Pg0KPj4+Pj4+IE5vdCBnZXQgd2hh
dCBmYWlsdXJlIHdpbGwgaGFwcGVuLCBjb3VsZCB5b3UgZWxhYm9yYXRlPw0KPj4+Pj4+IEluIGNh
c2Ugb2YgaWRlbnRpdHkgZG9tYWluLCBJT01NVSBtZW1vcnkgcmVnaW9uIGlzIGRpc2FibGVkLCBu
bw0KPmlvbW11DQo+Pj4+Pj4gbm90aWZpZXIgd2lsbCBldmVyIGJlIHRyaWdnZXJlZC4gdmZpb19s
aXN0ZW5lciBtb25pdG9ycyBtZW1vcnkgYWRkcmVzcw0KPj4+Pj4gc3BhY2UsDQo+Pj4+Pj4gaWYg
YW55IG1lbW9yeSByZWdpb24gaXMgZGlzYWJsZWQsIHZmaW9fbGlzdGVuZXIgd2lsbCBjYXRjaCBp
dCBhbmQgZG8gZGlydHkNCj4+Pj4+IHRyYWNraW5nLg0KPj4+Pj4NCj4+Pj4+IE15IHF1ZXN0aW9u
IGNvbWVzIGZyb20gdGhlIHJlYXNvbiB3aHkgRE1BIHVubWFwIGZhaWxzLiBJdCBpcyBkdWUgdG8N
Cj4+Pj4+IGEgYmlnIHJhbmdlIGlzIGdpdmVuIHRvIGtlcm5lbCB3aGlsZSBrZXJuZWwgZG9lcyBu
b3Qgc3VwcG9ydC4gU28gaWYNCj4+Pj4+IFZGSU8gZ2l2ZXMgYSBiaWcgcmFuZ2UgYXMgd2VsbCwg
aXQgc2hvdWxkIGZhaWwgYXMgd2VsbC4gQW5kIHRoaXMgaXMNCj4+Pj4+IHBvc3NpYmxlIHdoZW4g
Z3Vlc3QgKGEgVk0gd2l0aCBsYXJnZSBzaXplIG1lbW9yeSkgc3dpdGNoZXMgZnJvbQ0KPmlkZW50
aWZ5DQo+Pj4+PiBkb21haW4gdG8gYSBwYWdpbmcgZG9tYWluLiBJbiB0aGlzIGNhc2UsIHZmaW9f
bGlzdGVuZXIgd2lsbCB1bm1hcCBhbGwNCj4+Pj4+IHRoZSBzeXN0ZW0gTVJzLiBBbmQgaXQgY2Fu
IGJlIGEgYmlnIHJhbmdlIGlmIFZNIHNpemUgaXMgYmlnIGVub3VnaC4NCj4+Pj4NCj4+Pj4gR290
IHlvdSBwb2ludC4gWWVzLCBjdXJyZW50bHkgdmZpb190eXBlMSBkcml2ZXIgbGltaXRzIHVubWFw
X2JpdG1hcCB0bw0KPjhUQg0KPj4+IHNpemUuDQo+Pj4+IElmIGd1ZXN0IG1lbW9yeSBpcyBsYXJn
ZSBlbm91Z2ggYW5kIGxlYWQgdG8gYSBtZW1vcnkgcmVnaW9uIG9mIG1vcmUNCj50aGFuDQo+Pj4g
OFRCIHNpemUsDQo+Pj4+IHVubWFwX2JpdG1hcCB3aWxsIGZhaWwuIEl0J3MgYSByYXJlIGNhc2Ug
dG8gbGl2ZSBtaWdyYXRlIFZNIHdpdGggbW9yZSB0aGFuDQo+Pj4gOFRCIG1lbW9yeSwNCj4+Pj4g
aW5zdGVhZCBvZiBmaXhpbmcgaXQgaW4gcWVtdSB3aXRoIGNvbXBsZXggY2hhbmdlLCBJJ2Qgc3Vn
Z2VzdCB0byBidW1wDQo+YmVsb3cNCj4+PiBNQUNSTw0KPj4+PiB2YWx1ZSB0byBlbmxhcmdlIHRo
ZSBsaW1pdCBpbiBrZXJuZWwsIG9yIHN3aXRjaCB0byB1c2UgaW9tbXVmZCB3aGljaA0KPmRvZXNu
J3QNCj4+PiBoYXZlIHN1Y2ggbGltaXQuDQo+Pj4NCj4+PiBUaGlzIGxpbWl0IHNoYWxsIG5vdCBh
ZmZlY3QgdGhlIHVzYWdlIG9mIGRldmljZSBkaXJ0eSB0cmFja2luZy4gcmlnaHQ/DQo+Pj4gSWYg
eWVzLCBhZGQgc29tZXRoaW5nIHRvIHRlbGwgdXNlciB1c2UgaW9tbXVmZCBiYWNrZW5kIGlzIGJl
dHRlci4gZS5nDQo+Pj4gaWYgbWVtb3J5IHNpemUgaXMgYmlnZ2VyIHRoYW4gdGhlIGxpbWl0IG9m
IHZmaW8gaW9tbXUgdHlwZTEncyBkaXJ0eQ0KPj4+IGJpdG1hcCBsaW1pdCAocXVlcnkgY2FwX21p
Zy5tYXhfZGlydHlfYml0bWFwX3NpemUpLCB0aGVuIGZhaWwgdXNlciBpZg0KPj4+IHVzZXIgd2Fu
dHMgbWlncmF0aW9uIGNhcGFiaWxpdHkuDQo+Pg0KPj4gRG8geW91IG1lYW4ganVzdCBkaXJ0eSB0
cmFja2luZyBpbnN0ZWFkIG9mIG1pZ3JhdGlvbiwgbGlrZSBkaXJ0eXJhdGU/DQo+PiBJbiB0aGF0
IGNhc2UsIHRoZXJlIGlzIGVycm9yIHByaW50IGFzIGFib3ZlLCBJIHRoaW5rIHRoYXQncyBlbm91
Z2ggYXMgYSBoaW50Pw0KPg0KPml0J3Mgbm90IHJlbGF0ZWQgdG8gZGlyeXJhdGUuDQo+DQo+PiBJ
IGd1ZXNzIHlvdSBtZWFuIHRvIGFkZCBhIG1pZ3JhdGlvbiBibG9ja2VyIGlmIGxpbWl0IGlzIHJl
YWNoZWQ/IEl0J3MgaGFyZA0KPj4gYmVjYXVzZSB0aGUgbGltaXQgaXMgb25seSBoZWxwZnVsIGZv
ciBpZGVudGl0eSBkb21haW4sIERNQSBkb21haW4gaW4gZ3Vlc3QNCj4+IGRvZXNuJ3QgaGF2ZSBz
dWNoIGxpbWl0LCBhbmQgd2UgY2FuJ3Qga25vdyBndWVzdCdzIGNob2ljZSBvZiBkb21haW4gdHlw
ZQ0KPj4gb2YgZWFjaCBWRklPIGRldmljZSBhdHRhY2hlZC4NCj4NCj5JIG1lYW50IGEgYmxvY2tl
ciB0byBib290IFFFTVUgaWYgdGhlcmUgaXMgbGltaXQuIHNvbWV0aGluZyBsaWtlIGJlbG93Og0K
Pg0KPglpZiAoVk0gbWVtb3J5ID4gOFRCICYmIGxlZ2FjeV9jb250YWluZXJfYmFja2VuZCAmJg0K
Pm1pZ3JhdGlvbl9lbmFibGVkKQ0KPgkJZmFpbCB0aGUgVk0gYm9vdC4NCg0KT0ssIHdpbGwgYWRk
IGJlbG93IHRvIHZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSB3aXRoIGFuIGV4dHJhIHBhdGNoOg0K
DQogICAgaWYgKCF2YmFzZWRldi0+aW9tbXVmZCAmJiBjdXJyZW50X21hY2hpbmUtPnJhbV9zaXpl
ID4gOCAqIFRpQikgew0KICAgICAgICAvKg0KICAgICAgICAgKiBUaGUgOFRCIGNvbWVzIGZyb20g
ZGVmYXVsdCBrZXJuZWwgYW5kIFFFTVUgY29uZmlnLCBpdCBtYXkgYmUNCiAgICAgICAgICogY29u
c2VydmF0aXZlIGhlcmUgYXMgVk0gY2FuIHVzZSBsYXJnZSBwYWdlIG9yIHJ1biB3aXRoIHZJT01N
VQ0KICAgICAgICAgKiBzbyB0aGUgbGltaXRhdGlvbiBtYXkgYmUgcmVsYXhlZC4gQnV0IDhUQiBp
cyBhbHJlYWR5IHF1aXRlDQogICAgICAgICAqIGxhcmdlIGZvciBsaXZlIG1pZ3JhdGlvbi4gT25l
IGNhbiBhbHNvIHN3aXRjaCB0byB1c2UgSU9NTVVGRA0KICAgICAgICAgKiBiYWNrZW5kIGlmIHRo
ZXJlIGlzIGEgbmVlZCB0byBtaWdyYXRlIGxhcmdlIFZNLg0KICAgICAgICAgKi8NCiAgICAgICAg
ZXJyb3Jfc2V0ZygmZXJyLCAiJXM6IE1pZ3JhdGlvbiBpcyBjdXJyZW50bHkgbm90IHN1cHBvcnRl
ZCAiDQogICAgICAgICAgICAgICAgICAgIndpdGggbGFyZ2UgbWVtb3J5IFZNIHdpdGggYXBwcm94
aW1hdGVseSA4VEIgbWVtb3J5ICINCiAgICAgICAgICAgICAgICAgICAiZHVlIHRvIGxpbWl0YXRp
b24gaW4gVkZJTyB0eXBlMSBkcml2ZXIiLCB2YmFzZWRldi0+bmFtZSk7DQogICAgICAgIGdvdG8g
YWRkX2Jsb2NrZXI7DQogICAgfQ0KDQpUaGFua3MNClpoZW56aG9uZw0K

