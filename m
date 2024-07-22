Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D70CC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 05:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVlV4-00053S-3E; Mon, 22 Jul 2024 01:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlV1-0004ux-VJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:22:15 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlUz-0005kU-SI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721625734; x=1753161734;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U5bLk1fkBcfs/p6M8kurbuwQDuUED1rrixdQ+zff5ws=;
 b=M4opP/usc3tF5oNoSiB001hByxFQsf0V7aUacLA6w9+R3p/qT5vLjKYo
 ifBl4yWbmja3aniUBgv4SkURzRrwOYNpbH/vXKS30N9+pjYCIpQFyXn0o
 Dg0pdfr7yaGBiaeyGoJETWCsy+oxv92UBWx8nHVMnFKHCOb6SARvYcwQW
 VO/PGG0LYxhJBimK7wmSGBF+0YxDN8pii1Xw80i99msCzZMsnin2ZY3qK
 Ao/VWzfuBfDgVwH53hcB55bZ4gO0fpdl6d1LMrSnQMtG+CSGeMyWy/aTE
 bpD59HbrcX76sAkaDIeuyQ1kQiXXR751YOQpvHgNO8SvjuKM9IZ/UOgcZ g==;
X-CSE-ConnectionGUID: vW/E/GvXSlegiVsk1/dlOw==
X-CSE-MsgGUID: UpBxL60rTMKtv6qYm9JNMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19358274"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="19358274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 22:22:12 -0700
X-CSE-ConnectionGUID: zkudKfJzTq+F/+QUAd4Iew==
X-CSE-MsgGUID: c/N5k5qzQD6Edn7WQTU1GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="56603624"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 22:22:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 22:22:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 22:22:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 22:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKr8aoGadBDmCi0w4KIORjf5Hbjzr7ysVlqC+dtV/ckO7CF/T832qiOy0MTVWnRxewPu/ePv1uhvar8arFOVzSURO9wr7U6pj+boAS6/JueoxirJhQXgJaU6KY9ZE6SmztjuXIORo1lt+aG5g+YGm1YaY6o7arxE0Ps8zuSkkqoqdUi6b2hp9k17lj5lgVJAICyqwK+Mz2y6l8G9/vvNvwhGn4degTHHswXAPhiwOEWR6jArwsZotSkG60u5LKO5meA2NzQoFfDPo9fJ0KhBV4dx8jGT9A2diQj9T7IiYe+hqUw9FltZ3cvDaPxUg+bDRUKk8WsesmjQTDHPGDantQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5bLk1fkBcfs/p6M8kurbuwQDuUED1rrixdQ+zff5ws=;
 b=e2ngV4smNkQJ/VtCY+MRkdVjgQ6UTQuJfrx6u+M9YQ00d8pHGLyRrRZ4BlScHN6YzyYydL7A/WaCb8MGW+g3mvv6NXVru0R90hZrTMZ7n/dqLh/reEutflBC4uNFeNFjJ+o/EZ8tCd4leo2yqMXoKvfEBSvPhveLlowHmvnd9oRvrszE+vHh3/zh0tUcK450uxiIycOrg0bWLwQwH9a1Cp4NSygt0VITARA7Fe/FyyODfiQ5MCHK4t5jfG0uxAKgE7F4SjJp6t22OFU6dBZOmzei2UC57cMGbr+JizWRQDq/35jWzzUFOyv8hYlP4BVbyR/yRFJhnEOT9ml7euaC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 05:22:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 05:22:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v5 06/13] vfio/{iommufd,container}: Remove caps::aw_bits
Thread-Topic: [PATCH v5 06/13] vfio/{iommufd,container}: Remove caps::aw_bits
Thread-Index: AQHa2dS7Fp1HjhqdO06UX6xS/3uiLLICOU3Q
Date: Mon, 22 Jul 2024 05:22:09 +0000
Message-ID: <SJ0PR11MB67448715600DF6E75BF9315292A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-7-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-7-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB7527:EE_
x-ms-office365-filtering-correlation-id: 64e3727f-5d85-4192-3c37-08dcaa0e3c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZCs1b2RGb2JwdllsaWtjQndGOURPRkZlQldiaEdYMkZCZFNNYmZmNTdLYVNi?=
 =?utf-8?B?QndMWWNiRW9UMU53WkIzOU54OU94SDA1TTg3am5jT2U0eE9aWlA0T3JybkxQ?=
 =?utf-8?B?cjBUd1VsOS9JUy9rUTcxaGJSSE9sb2NJQ1R3WEExUlhhYjFCRUlHSmhVMlBZ?=
 =?utf-8?B?V1NJNEVOY0RwME80ZVl4dDRwd0JHKzdmdTBEZFNNTFJJL1I3RytrUXRNYlpQ?=
 =?utf-8?B?ZGdFYWkrL0x3c3AzRldNL2dzQ3ZveUpZb1lDMGU4aG9nZ2FnMEJaMS80MUJH?=
 =?utf-8?B?TXZSd1ZUUzBhUzhOajl0eEgzbnlGaXZaWUV5ak9DS2FWa3ZaVXRMU0xPdWMr?=
 =?utf-8?B?RmRpb3IzQVkrRU9QN0t2YWxEMWdKd3RldTREZndHRGFkNWtFN2wwMms1Y1dl?=
 =?utf-8?B?R1BkTkdYZ3oxaDhLTjkwemdwVWxaWUIrbC9xTUx4SU1oUXo1cXp5Z0lMM1Ez?=
 =?utf-8?B?bUdsT1lmQm1jZ2hWV0N6YTFYTDRPNjNnVG9RbUxZc094SGtNQmQxNVFMT3hx?=
 =?utf-8?B?RWVVdGVjVERKNGswWTFWMDRIcW90YmxZS0xPejJnTUw2MXZXMlBRVW1oUGc4?=
 =?utf-8?B?NGpZNlJNWTFYTGFVa3A3WjBWaStVZVZNMkdSNEZGT0tQNVNIOUhycjFrTVVI?=
 =?utf-8?B?QW1PcnY4MEkvUkd6dCtnNWUwbXU1TXB4d0c4WnFVMkptRGgxanpJV0grZk9Y?=
 =?utf-8?B?VklRZytXOTBrR0hSczByRE8xbEsybmFUN3EvdFdwK0JGNlNqaFFmL3lwdDRp?=
 =?utf-8?B?dlBUb21aWUhMTm5LTFducDRnRG4yUERrSHdkZkpxZzUrTWllNjE5STFuNi9u?=
 =?utf-8?B?Z0FmdHlyMUN2VFhrN2wrVlBxanYxcG9ORWdYVDdZMVdkODVwNkZTektudmZL?=
 =?utf-8?B?YkFma21YRXYrQ1dtMnk5cGZvcWpCNmJMZ1RZMEVBYmR2a0Q4SDJOZEhHUU90?=
 =?utf-8?B?b05FdDdNZXF3R3JncTNwMys4ZDRERGh0b0hJNXN0cy9xaDhjUk1pTm1nU3dX?=
 =?utf-8?B?eDNuaFRWN01sbFdReFg1cDZiZm5SM1dFVllqOVZmaFh6K0VINllTKzJNb3hw?=
 =?utf-8?B?bnJkdU04Y3hFY0pIVVlMaDBtc0pUZzBuWlMxSEJ3dUtiRldQMlk0L1h0ejJi?=
 =?utf-8?B?Q3FnRGttay9wenNSTW1UbUFGaEd5K3BaLzdHQ1A1aUhxSWNENjBhZnVPb2Fn?=
 =?utf-8?B?Z2dzeHFvaXVWNXN6MHpSZnc3ZDJNeHhMeWFOZ3VIZ093cWk2cnQ1SzJyWTlJ?=
 =?utf-8?B?V0R6ZCtrTWNqa00wejY5SEpmT0c2UDkzMVR3YXI5My9FVzlGSXFGajBDZGxl?=
 =?utf-8?B?dEhhS0I4WFM3cGQ4dFdIdWFjcjVLbUg1a0RRaE90QUVFZmtpZkJYVEY2Y0pR?=
 =?utf-8?B?YWgveHpiUjBpN09hZGd6V0tzSkdMSnJHSkp2ZGlodXZOWWNCZ2RhdlRFdko3?=
 =?utf-8?B?bWVxT0dCU1ZBcXMyRzB3MW1TWnNPbm5YWndndUo4bnhPU2xTcXR4MmJ5S29G?=
 =?utf-8?B?cnJNOGp5cEo3V2VaKzhuUnJROUlrcUtjTU85ME8zbTZjZThkTFo5TllFemNS?=
 =?utf-8?B?aXZQRmxQUmxzODltb3pTdGN1UEZicy9UdzZTT2NlcjUvcHg5blkzbE1ReHVE?=
 =?utf-8?B?L1EvRFlLQ05za3ExR3dBOUJNZ3dqVURRUC9XejlESTRVYml6S3V2VndjNnUz?=
 =?utf-8?B?U1E2VGhLSENmMlJMZnZhVGJnclRodUZkV0RRbVhBNmt3Wlh3RWZEK1R3Q1dO?=
 =?utf-8?B?SmFtb1k2ZkpTeEFhcHlMOG5jcFVqeEt1VWZtMjA3VlhzUFVkaVdHV1hLT2ZR?=
 =?utf-8?B?cWpUclJOYSttdStkaFFjK1puajJld3ZOQUFhUjkxeGxIbjBkRFVBSnhrbXM0?=
 =?utf-8?B?VnQwd1JtSFlSNmZjUG9qbGdrQVY3YWxoZHVDbXJKcnlObVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlpaK2tjSE1YQ2t0anhURUpZM1N5ell4R1RMUW1VdWRUc25UQlZqQ0QwWmhh?=
 =?utf-8?B?cEEvUURGTzNqNDZqa0UxWXYzeXZiL1NTckpvbnNqUDVqTlE2eXF6eFRpNURF?=
 =?utf-8?B?OUVzcnJVUG43eHlYUkpwM3hWSTZUMG1DRWdFeitXWVc4amN2WFpzdzBVRC9E?=
 =?utf-8?B?WGNJTlBQb25PVnp0dys3Qmw0ZURLRElwM29GbVU2ZlpzL0pFVk9iNUJXYzNh?=
 =?utf-8?B?SHN3cGsyWXQxZTMwNExjL1Y1ajN5U2czMkRaWnJtbm9GZGZOUHpQaTFHL2c3?=
 =?utf-8?B?b29rT29vbkswT1JDT056b1ZmZVFGdFRsN3VsSUhxejFpM0xWV2JlNmgyT2RF?=
 =?utf-8?B?VjV5cVZ6ZzhjNUh3aFZnMFZxK2w4c3pvVGF3QllWNlZPZHRqM3lxS2xyNG9y?=
 =?utf-8?B?RkJWNUxzZ1JmUEU5UkJKUE9la2w4b0tCQjlUclg1Mm51Vnk0TUxsTkZ1V21Q?=
 =?utf-8?B?MTRxelZJS3JLQlNEdHdYanJnRnhmT0RydFRvYUhnK0Y5WGVmeHd1cjdVbGdI?=
 =?utf-8?B?c3Z2QUIxblNxZlQ0Z0lMNHEycTA3eHN6MlpudzVMMnVBQ2g5WDdTck9IN09h?=
 =?utf-8?B?S0graWVGdnRYOXRqcFVQbDU1ZHhBUTNDd05NeFVibm9ET3ZmZ21NanFGVmQ0?=
 =?utf-8?B?WG1PY0QvU2tGL01NVzNsZy85eGdYa2h1U1NTSEdDeTQ2cUpTaVhrSmVXc0tV?=
 =?utf-8?B?YmF2ZnZtZml4YXhILzNZcWM0Z0o3NFN5SmdWZUQ0VENxT2ttQlZJZTROeE12?=
 =?utf-8?B?UzVBdEVjTmN4YWdpb3F0VnozdStPbFBhRnRaS2ZteHNQSjdNWUtlY3lwOTZ3?=
 =?utf-8?B?WGtUVEwyd0tYOC9VWExmSUJTdklsY1lGY0ZtL285alNjcEhQWnFsdzZjZWo1?=
 =?utf-8?B?VUFZNWtEYjM5V0dGTHZVbUh3WE5FdFlESkFUaXlJRnpHTGI1QzBicUVzYnhp?=
 =?utf-8?B?dDRiS2xXY0F1cFNjWHBxVTI4eGNiUHE0Y3Y1WXBzVVVIWVJwNlJlWHRTa2FK?=
 =?utf-8?B?SURoVVVwTzVnQmJVWjh4K2IrUTJOaVUvWXpBdmNMc1JwNlZzOWdBTEI2S2ZG?=
 =?utf-8?B?WStVSm1IczVmckNQQTZzTUN5S3JzUVpmMExuOTdSdmNuRjU0azYxL0xIM0Iv?=
 =?utf-8?B?WGNMc3pFakRhSVo2enl5S1Y1RnV2ZCs2NFFKWm5RMVFrWHRxUE00MDhxbTk1?=
 =?utf-8?B?MEZBMi9pWllzSFB2b2J1TkM0Q3VvdTY1RzQzSUVFQ3BaQW5QbnJFcitXMGdn?=
 =?utf-8?B?RjY2UDQ3aGtpc2l3R0JnVVdBVldxejY4a2VlL0xWMXFNMmoyR0RrL3VtN1Fy?=
 =?utf-8?B?RGM1VWc2OGdsbU56ay95Ni84YThtajFSYm1WeHZDZEYrZHcvUlo1b2N3czFU?=
 =?utf-8?B?c094VENwbWs2eEs4RHZLaXVDYnFLYzZjVnd5b1lsVjNqb2IyODY3YXBoREdU?=
 =?utf-8?B?dnJhbWpaNy8zRHI4Yk91UWRiS2Mvb2x0S1Fjb2RXLzAyak55M2ZWOVVIaUpF?=
 =?utf-8?B?UDdLM0dKRlVaemdYYmlya0VJRElEZ3dlQnNkbHNBY2hDQzVoaFVXWDhxSFM0?=
 =?utf-8?B?SURwbm53cVQrSGI0QXR2K2ZIb0pOOUZ0VmtMejdMaUNTSng5OGhDdFpJb1ZJ?=
 =?utf-8?B?dG5Hc2dISjBIZWxXY2pIZTRETldGOTZDSEpmYW9FUTdMVTVNdU5PWFQ0T0Z5?=
 =?utf-8?B?OWpOeEg1VFlrRFB6dlllck1WYTFJWmIxWW9tMnFTd1FMZ2lwbFlMcHpEcWRO?=
 =?utf-8?B?OHNRL2RVQ1FpSm5hQUhhYmNqYVJ0U0crR3VRVW15Y0dzcHNwQmxteld6ekZm?=
 =?utf-8?B?THhPTG5CMDc2elZHUCtTYjdtYVh0ck9vcUFndHdQUkdvVDJieG5zOVU0N04v?=
 =?utf-8?B?NGp1S0I0M0VFWHREVFMwT3lDblBScTVGS1lvQnJleXlVVytJekU4Q3FvS05L?=
 =?utf-8?B?TXdjVXJtVHN3N01SbGdCNUc1ZVhJUUF5WGJTSnk0ZTRUWllpRW5xQVlyaklx?=
 =?utf-8?B?TVJsbjlmR0ZuT0VIcVh2VDhoaDJPaUlvZUJDWThnZi96ZTUvMkVvc1AvUnBY?=
 =?utf-8?B?SzJ4Mjl5RnBxREI4MktCWXg2a3JXdzFFbmxZd3hkcU1oczhGK0JyQzJOa3pE?=
 =?utf-8?Q?JYwPimkpwMs2K6b1kCDgPVEiO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e3727f-5d85-4192-3c37-08dcaa0e3c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 05:22:09.2990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwbsrzXJcepf5MCCO58/vxlZY+AuQQsbzbbxKFRdQoScEXc9ij+DWNS2o6U7P7zKUTgs/xEozpQK5DmwPnDS7NjhASQbCB94vZMjXqseWwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7527
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjUgMDYvMTNdIHZmaW8v
e2lvbW11ZmQsY29udGFpbmVyfTogUmVtb3ZlIGNhcHM6OmF3X2JpdHMNCj4NCj5SZW1vdmUgY2Fw
czo6YXdfYml0cyB3aGljaCByZXF1aXJlcyB0aGUgYmNvbnRhaW5lcjo6aW92YV9yYW5nZXMgYmVp
bmcNCj5pbml0aWFsaXplZCBhZnRlciBkZXZpY2UgaXMgYWN0dWFsbHkgYXR0YWNoZWQuIEluc3Rl
YWQgZGVmZXIgdGhhdCB0bw0KPi5nZXRfY2FwKCkgYW5kIGNhbGwgdmZpb19kZXZpY2VfZ2V0X2F3
X2JpdHMoKSBkaXJlY3RseS4NCj4NCj5UaGlzIGlzIGluIHByZXBhcmF0aW9uIGZvciBIb3N0SU9N
TVVEZXZpY2U6OnJlYWxpemUoKSBiZWluZyBjYWxsZWQgZWFybHkNCj5kdXJpbmcgYXR0YWNoX2Rl
dmljZSgpLg0KPg0KPlN1Z2dlc3RlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5z
QG9yYWNsZS5jb20+DQo+UmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbQ0KPi0tLQ0KPiBpbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIHwgMyAtLS0N
Cj4gYmFja2VuZHMvaW9tbXVmZC5jICAgICAgICAgICAgICAgICB8IDMgKystDQo+IGh3L3ZmaW8v
Y29udGFpbmVyLmMgICAgICAgICAgICAgICAgfCA1ICstLS0tDQo+IGh3L3ZmaW8vaW9tbXVmZC5j
ICAgICAgICAgICAgICAgICAgfCAxIC0NCj4gNCBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzZW11L2hvc3Rf
aW9tbXVfZGV2aWNlLmgNCj5iL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj5p
bmRleCBlZTZjODEzYzhiMjIuLmNkZWVjY2VjNzY3MSAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL3N5
c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+KysrIGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21t
dV9kZXZpY2UuaA0KPkBAIC0xOSwxMiArMTksOSBAQA0KPiAgKiBzdHJ1Y3QgSG9zdElPTU1VRGV2
aWNlQ2FwcyAtIERlZmluZSBob3N0IElPTU1VIGRldmljZSBjYXBhYmlsaXRpZXMuDQo+ICAqDQo+
ICAqIEB0eXBlOiBob3N0IHBsYXRmb3JtIElPTU1VIHR5cGUuDQo+LSAqDQo+LSAqIEBhd19iaXRz
OiBob3N0IElPTU1VIGFkZHJlc3Mgd2lkdGguIDB4ZmYgaWYgbm8gbGltaXRhdGlvbi4NCj4gICov
DQo+IHR5cGVkZWYgc3RydWN0IEhvc3RJT01NVURldmljZUNhcHMgew0KPiAgICAgdWludDMyX3Qg
dHlwZTsNCj4tICAgIHVpbnQ4X3QgYXdfYml0czsNCj4gfSBIb3N0SU9NTVVEZXZpY2VDYXBzOw0K
Pg0KPiAjZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UgImhvc3QtaW9tbXUtZGV2aWNlIg0K
PmRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj5p
bmRleCBhOTRkM2I5MGMwNWMuLjU4MDMyZTU4OGY0OSAxMDA2NDQNCj4tLS0gYS9iYWNrZW5kcy9p
b21tdWZkLmMNCj4rKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj5AQCAtMTgsNiArMTgsNyBAQA0K
PiAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4gI2luY2x1ZGUgIm1vbml0b3IvbW9u
aXRvci5oIg0KPiAjaW5jbHVkZSAidHJhY2UuaCINCj4rI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1j
b21tb24uaCINCj4gI2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0KPiAjaW5jbHVkZSA8bGludXgvaW9t
bXVmZC5oPg0KPg0KPkBAIC0yNzAsNyArMjcxLDcgQEAgc3RhdGljIGludA0KPmhpb2RfaW9tbXVm
ZF9nZXRfY2FwKEhvc3RJT01NVURldmljZSAqaGlvZCwgaW50IGNhcCwgRXJyb3IgKiplcnJwKQ0K
PiAgICAgY2FzZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfSU9NTVVfVFlQRToNCj4gICAgICAgICBy
ZXR1cm4gY2Fwcy0+dHlwZTsNCj4gICAgIGNhc2UgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJ
VFM6DQo+LSAgICAgICAgcmV0dXJuIGNhcHMtPmF3X2JpdHM7DQo+KyAgICAgICAgcmV0dXJuIHZm
aW9fZGV2aWNlX2dldF9hd19iaXRzKGhpb2QtPmFnZW50KTsNCg0KSSBqdXN0IHJlYWxpemVkIHRo
ZXJlIGlzIGFuIG9wZW4gaGVyZS4gaGlvZC0+YWdlbnQgaXMgbm90IG5lY2Vzc2FyaWx5IFZGSU8g
ZGV2aWNlLCBjYW4gYmUgVkRQQSBkZXZpY2UuDQpNYXkgbmVlZCBhIGJpdCBtb3JlIHdvcmsgb24g
dGhpcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPiAgICAgZGVmYXVsdDoNCj4gICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICIlczogdW5zdXBwb3J0ZWQgY2FwYWJpbGl0eSAleCIsIGhpb2QtPm5h
bWUsIGNhcCk7DQo+ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ZGlmZiAtLWdpdCBhL2h3L3Zm
aW8vY29udGFpbmVyLmMgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+aW5kZXggODhlZGU5MTNkNmY3
Li5jMjdmNDQ4YmEyNmUgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jb250YWluZXIuYw0KPisrKyBi
L2h3L3ZmaW8vY29udGFpbmVyLmMNCj5AQCAtMTE0NCw3ICsxMTQ0LDYgQEAgc3RhdGljIGJvb2wN
Cj5oaW9kX2xlZ2FjeV92ZmlvX3JlYWxpemUoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB2b2lkICpv
cGFxdWUsDQo+ICAgICBWRklPRGV2aWNlICp2ZGV2ID0gb3BhcXVlOw0KPg0KPiAgICAgaGlvZC0+
bmFtZSA9IGdfc3RyZHVwKHZkZXYtPm5hbWUpOw0KPi0gICAgaGlvZC0+Y2Fwcy5hd19iaXRzID0g
dmZpb19kZXZpY2VfZ2V0X2F3X2JpdHModmRldik7DQo+ICAgICBoaW9kLT5hZ2VudCA9IG9wYXF1
ZTsNCj4NCj4gICAgIHJldHVybiB0cnVlOw0KPkBAIC0xMTUzLDExICsxMTUyLDkgQEAgc3RhdGlj
IGJvb2wNCj5oaW9kX2xlZ2FjeV92ZmlvX3JlYWxpemUoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB2
b2lkICpvcGFxdWUsDQo+IHN0YXRpYyBpbnQgaGlvZF9sZWdhY3lfdmZpb19nZXRfY2FwKEhvc3RJ
T01NVURldmljZSAqaGlvZCwgaW50IGNhcCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiB7DQo+LSAgICBIb3N0SU9NTVVEZXZpY2VDYXBzICpj
YXBzID0gJmhpb2QtPmNhcHM7DQo+LQ0KPiAgICAgc3dpdGNoIChjYXApIHsNCj4gICAgIGNhc2Ug
SE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJVFM6DQo+LSAgICAgICAgcmV0dXJuIGNhcHMtPmF3
X2JpdHM7DQo+KyAgICAgICAgcmV0dXJuIHZmaW9fZGV2aWNlX2dldF9hd19iaXRzKGhpb2QtPmFn
ZW50KTsNCj4gICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJXM6IHVu
c3VwcG9ydGVkIGNhcGFiaWxpdHkgJXgiLCBoaW9kLT5uYW1lLCBjYXApOw0KPiAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8v
aW9tbXVmZC5jDQo+aW5kZXggNTQ1ZjRhNDA0MTI1Li4wMjg1MzNiYzM5YjkgMTAwNjQ0DQo+LS0t
IGEvaHcvdmZpby9pb21tdWZkLmMNCj4rKysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPkBAIC03MjQs
NyArNzI0LDYgQEAgc3RhdGljIGJvb2wNCj5oaW9kX2lvbW11ZmRfdmZpb19yZWFsaXplKEhvc3RJ
T01NVURldmljZSAqaGlvZCwgdm9pZCAqb3BhcXVlLA0KPg0KPiAgICAgaGlvZC0+bmFtZSA9IGdf
c3RyZHVwKHZkZXYtPm5hbWUpOw0KPiAgICAgY2Fwcy0+dHlwZSA9IHR5cGU7DQo+LSAgICBjYXBz
LT5hd19iaXRzID0gdmZpb19kZXZpY2VfZ2V0X2F3X2JpdHModmRldik7DQo+DQo+ICAgICByZXR1
cm4gdHJ1ZTsNCj4gfQ0KPi0tDQo+Mi4xNy4yDQoNCg==

