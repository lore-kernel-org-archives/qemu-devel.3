Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EC4C7EE33
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 09:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUitn-0001zW-Om; Thu, 26 Jun 2025 05:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUitj-0001z0-OJ
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:27:59 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUitg-0003o7-48
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750930077; x=1782466077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c1QcER+UbGEATDBxXBqY63Mp3YmC20Liw+iikTVP4Kc=;
 b=RuXedgMl+7H24RiYXxXbtry4M9w8eon7nhnh77OPHXxsb0VZNmjzQphS
 w050x5pMCMbn1IRSTO6b4b0g8W0obWsZgsnfOiFvzy7+Vpx+CjSZCFAeP
 3qsYgyIVfg/3VK61ZDvcpC6LI+aRJu+z9nAS8h5qRlB4YUh+mP+J2SH9m
 aYtUgheeZrDTI9zjboDFj+Xj8W3/QV1pNbPe9Ig8Om0d6oCY2iAZzQ0vv
 QiMDkNutSDadtBrGklzOtwVDp8dymybAn1Io9coTABnApDUh9z2vRZAj/
 5N5ww0cYwgefV1Oncqx3px2ypZ5E7jsCAYeCzrfnLSFwi5RhEvrEipn3a g==;
X-CSE-ConnectionGUID: wQmtT7L3QVmzkC5Q7ffasg==
X-CSE-MsgGUID: lkw2CFpxRfGhbzb1LRU7rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64280242"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="64280242"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:27:52 -0700
X-CSE-ConnectionGUID: MSgv2dAJQhSYfJq5ZLwAGQ==
X-CSE-MsgGUID: TVLDA5kRRXyhgVjOxZxCcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="151979720"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:27:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:27:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 02:27:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo6QblBMUvmSoTyqkg26yGdV2MvWgUzTHnHdhkqXK650BPpxwOj+Ry4om3F71j2cI8mN8p7TxGmQEdeiZvc5w/YAvPhjXT9/J6fND6iAkPxdo6whFFoeWo2O9eFjvIICNwdB6wk25G4/AlQmOnF5zaDe7CdMVc3nTGuG7Gr9sZyVx7ielcC/QhvIjNEPcAU1IhowBESrcMXVzqY4wVvM6cmdrG+UWFh1Jsmg3bMORJHT/XRVn2WL+Dveauoa35eorFyZ6neCTg7NZEvpZe05OQXoB+qYkNLv35oDqBkQlaRxcCGwm815SpP/EKr15w3Kztij+deOnWWt2ECU+XVX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1QcER+UbGEATDBxXBqY63Mp3YmC20Liw+iikTVP4Kc=;
 b=jGhE0woCHRb7SwO/F/wptmS+wLdFR/g/6Fc6X6oyrYhOnHv32pCtnY27+BLHURFdjPCYzBCun7IhA+qaYeG1kDo6qaV0tmr1ApMAARRZBca/leA3z+BmHqtCNPLP0yh2VxnSx1j9T0KTluwT5SobODFcMiswhETJNNTp9X6FCl8BIXhcan6AbGZfonAbEZbdbWozB71mrja80frHqzh8z0KjEF8Wqtirmr/41o0n+G+5l7+6neJA5uUktdEOBTtotyRqApGzDAmdt4WTK4loReBEzdJIROcOYB1zjmsWnxipdnaMcPOi62PUqtCtW+M8Xat6Ta8p4+Ho61l1lvNwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV8PR11MB8680.namprd11.prod.outlook.com (2603:10b6:408:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 26 Jun
 2025 09:27:47 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 09:27:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 15/19] intel_iommu: Replay pasid binds after context
 cache invalidation
Thread-Topic: [PATCH v2 15/19] intel_iommu: Replay pasid binds after context
 cache invalidation
Thread-Index: AQHb4bQ8e7DGwGUZpk+LwjHhTpVb27QQwREAgARySSA=
Date: Thu, 26 Jun 2025 09:27:47 +0000
Message-ID: <IA3PR11MB9136657FB506FD63A0425EAB927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-16-zhenzhong.duan@intel.com>
 <b3a4374d-36c9-41ab-b7d6-4678ba9e9fd0@redhat.com>
In-Reply-To: <b3a4374d-36c9-41ab-b7d6-4678ba9e9fd0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV8PR11MB8680:EE_
x-ms-office365-filtering-correlation-id: f4907217-8837-4ed1-4ed7-08ddb493b6dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aVdidXg2STBRSWZIUW9LTnZuOGpZSUIvZnIyZ21WN3cvZVkxa3R6YmtWYjVn?=
 =?utf-8?B?dVR1VDlVT1l1QW0rMnFCaFdhZ1NhSmdrTjYvTDZVc1BISTdmSC9KaU4xTE1w?=
 =?utf-8?B?Wm5kN1k2UEhIdUpCa1YvMElNZGlydWZIcG83LytDd2dJcktxYzlqWlRiY25J?=
 =?utf-8?B?YVFBV1lmSlplSEFqQjVnTWdhOTFVMkM0dkswZkNCQms1c24vWCtuaFdpa1dn?=
 =?utf-8?B?R3hvS0FXVTlYK3ZBWEt2MXRYKzRTTlpucnBLWElpSzBWdHZtemdNWjh1c0Zl?=
 =?utf-8?B?Y3BPcmZmUS9jZUJiNXRuUHZkSzhRZDc2YWVKbVl3UG9LWU5iS0QrOTlvZ1hI?=
 =?utf-8?B?cVE3VG1sSkYrQkJWMGd1YjhRcEJLZzQ5L0dQVGs1R01aVEZTSjBHbk5FSW5M?=
 =?utf-8?B?RmZTaWJQSEgzM0RvaFRJako4aUtYS2RYckRXOTBvZ0JhZmxEcWlQVkRKT0lu?=
 =?utf-8?B?SDhXSVlkU2xYR1ZFb3JkL1pyQVhIS3JCYzQ2TkNoVjdqOE5Bd3VCQmp4bzU4?=
 =?utf-8?B?RlRnZ2VXYW1QcWl5ZnlVVURweW9HWTVXSHdEM3RSZTNtY0wya0VSWGREVzVr?=
 =?utf-8?B?RWpvSHJhZXZiWmxmZ0w4T2JtOFljRUEzQUlQSFo2RDJKY3lHcnJBa1JxTlF5?=
 =?utf-8?B?ZnlhbC9mNlk3TERENVM4RmxCUGRScy9SblFBUkR4eWVyYmVYK3RuQVlZaEds?=
 =?utf-8?B?dG10cytoZHBuYjFFT2FjN1RxcHc5aXJza3RwWUE3d1lkNjRkMG0zOWZEZ3FO?=
 =?utf-8?B?Y21jOHV4aGFoMTI4YjJUWDdyeFBQdmZTbk9WR00vVm44R1lKVnYwUCtpNmRk?=
 =?utf-8?B?eWMxNVJYZ1N2UVBtbERvNzFENXRYbTJaSkpFWForbTA0SThodG1XRVdzQlBE?=
 =?utf-8?B?dDhRdnVBWlpsL3YwbmpKSk8wMk1vRzBWaFZPdTJTWmFVVnBvOVRwNEZ4cE1o?=
 =?utf-8?B?NUhzQTNXU2xsUy95RURxRUlzOUZuQmFVcS91cGVsa2ZFSmhUdlhPeDdLNUF6?=
 =?utf-8?B?ZjNkQ3lkY2VNcFlJWWlNdU5wa3hRS2pIK3g5eFc5OGtjdTFJQkRhSEswZWts?=
 =?utf-8?B?T2xLR1RrcXhmY29LMFFMVUdNTGI1dE5WL2JTYkc2M09JUUpzajl4allVbDdG?=
 =?utf-8?B?MWgzOTVSOVFLbCt1UkJSWG9ydEZ5K1FWQ1hwcFNpRTlzUEVEMG9udjdwRllv?=
 =?utf-8?B?bDJ0YW5JSlF5K0FDTFNCdnloc0RsTTBtcmh3NDdsWk5JMk9UWmFoWHZnQTZU?=
 =?utf-8?B?N0FNWHN1TVhSRTN2eVdxTDVESDVoOXVPdEhTOWsraEdEMnNUSEtkWXdNUGdq?=
 =?utf-8?B?M3lXa0F3WnFRNTEvUmRySEx3RDF6TWlyc0RRaTU5S3FKZTJTWGIwQ1M2eFha?=
 =?utf-8?B?b2F3SW0zOGRlUGZMdUs1Y0ZjZkp6WEN2dEMzK2p0UnNTU0hqZ1l0blVDVk1N?=
 =?utf-8?B?R0ZYMC81NEkvQ2V5U2NUZHY1UmttamJ4bjZhcEkrSnZKWGduVnE3WStiSDE1?=
 =?utf-8?B?T1dFRFNZTUhXLzQ4ckRPekNDK1BBMEZqUnhoblRvelptT0o1UjZycVdsaUMy?=
 =?utf-8?B?VTA0Yks1bmVMbmZLSkNZaEd1U0ZjYnJENlh2eGNuSnRyVHB1NU54aStKZUl1?=
 =?utf-8?B?d2JVeVE0bjlKUVZrVjh5RmtzNWVsNGU2QjBXR3hFTnYwb1E3YXVBeE9lN25m?=
 =?utf-8?B?Q1IzWTZqN2k5YWZmUmV2WkpHNWtjbUVJMU5qTVRpR1RPNkpqL05aVmdQOU5o?=
 =?utf-8?B?cXRTMnhudmdRVlYyRzJFd2wxVDljczJsTTB3TXVhd1JaTCs3U2JyN0ZlY1c4?=
 =?utf-8?B?NDRCaXdNb3o5bWxPZExSV0I0RllGamlZWTExN1ZVNWV5bGNGcFhlSDBLZGZB?=
 =?utf-8?B?YjFsM1c4YVFleFNMTWpBWEptY2NneEpWUmcrdW1NS2dqWiszcllIRUJlRmls?=
 =?utf-8?B?S0I2aGtHZ3pzM21JMUJTR0R4VzhVdGJVRFNWN1ZlRHMrU3UvZkFUdHpodWkw?=
 =?utf-8?Q?QM2sbbqCpw0Utg/TS1GgIj3Bc6IVE8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REhXT0hwUDRIYTlqUERBVit5aUd1SGdaKzBrc3g1UU1yYk1CRzZSZVVWd0dh?=
 =?utf-8?B?WjhJemY2RXVLc0grTVNkNnJYNnRSbUorVWFReGx6d3FybmpQa1lLTmNKNTVQ?=
 =?utf-8?B?QVhGVzQycUdvN2xyRk4zY1A4S3NRM1ZOM2tSR3lvQXFKcDVTSVh1VHhGQits?=
 =?utf-8?B?S0tqb3QweThVVFM3dlVtMVVCT0NpM3ZWTHd4akVocExXZ1lla2JoelMrS3NC?=
 =?utf-8?B?S3FJV1BrenpWUkROL0VHUmRZNXRJRmxBQkVUN3V3VUF0dTRnU2Vod2VaNysz?=
 =?utf-8?B?a0RBeTFZRkFTUE12V2RjdHc2bEJTYlFFdEUrVmxPUXo2Rlg2U0thK0oyVmhJ?=
 =?utf-8?B?MWNvT29ucVhNMTR5aU1oNlgxbkhGbVdobzBrWHBYUk9SaTNxbWdqbGhMeEhw?=
 =?utf-8?B?Z25mN25xY0lpRTk4b3JOS3ltWnFBbndIUDcvZmg1bnl5dmRHSUQ0S0ZoWERQ?=
 =?utf-8?B?L3RBbGc5NEtuV2RYeVJ4OEx2UDBueVh2NVBwNnR2WnZLcEgzMUpscy9GanFL?=
 =?utf-8?B?TXZJY0RXTUxCMFliQk1zNGZLVzJxN2c4RlFJQ1VFVENLei9oNVhKY0tDS0oz?=
 =?utf-8?B?NXpvWkczdWZpS1N3OExQUERCdEUrTnExT082NENRamNobzlvWjZ0UEI1V2xG?=
 =?utf-8?B?dnZSc0ovcmJiWTlGc3dEc21KZ3NCN0pXU3JZc0tvVHFEUW5qKzdnb0t3S1By?=
 =?utf-8?B?eElMY25TeEZYM1FxdFB1MC9yNmJqMlh2RlB3NkdGQ2g4THlxQUpDY2I3dDU2?=
 =?utf-8?B?UnRFUmd5eXArTmdsc2JsbW9hMDY2SzEzYW5zcTV1bkF6TzNQQVhxbUNMTFIv?=
 =?utf-8?B?WDkwRWorMGUyay9sZXRCRGpHUGFKOGRVRWhhT1k1a1QxR1kvOTFyWmNTR1pY?=
 =?utf-8?B?V0dIRFJOa3B1bG9FKzhZL1lvSkw3Mi9yakk4Y053dUhybGxaa01raVZoK2ZC?=
 =?utf-8?B?ZHZGc3lxUlV2d0lGRUxkWWdyVC9KbDBraDlSQ3psVGhFTUJjQ3hxZjlJVVdx?=
 =?utf-8?B?b2pVZi9SdzVKYmVLMVozWGNTZkdueVl5eHZFWC9BOTJTUGhVdDlQcUVJdWlW?=
 =?utf-8?B?Y0ViT1pTTHN2K1pVKzNpWDVZQzZYOVNiZ3dEQW9KcE1SNHA5MzR1enZlRVdP?=
 =?utf-8?B?V0FrZXRuWFZLUXZWYjM3cmFrMjhGMFlXQ1hoZWg1Q1k2NHRnV0RuMDNSazV4?=
 =?utf-8?B?Zk5teDNoT2lZZTUwZHhSa3ovaDlVVGNKTFlqaDFZUWF5ZHF2TTM0MElkcEd6?=
 =?utf-8?B?eVh3cUZ1ZjlvRE94M1pQSTdRVzhWUWtiM3VueWNtdm9YTzM0V3Q3dFF4SlZW?=
 =?utf-8?B?Unp5OU9zR2xkV2tBR3pkT0xWalU2V25taE14VWJkbFRxTXJQOGtNWW94cFZt?=
 =?utf-8?B?aVV6V1I3aXl3RzQ3dHVXNHRjWnUxMjQycmRsOTFiaGVkT3NHOUhYWUFwaEpo?=
 =?utf-8?B?MnFpV1VKYis1QllEZkNrek9KK3FmYnhYL1RxV0xCaUNlNllzWmtmYXBhWkZw?=
 =?utf-8?B?NFFtVEV3bVc4M0trYlI5MUdheTloUlhFd2ozd3AzUTdjRXpscmFQa1VacCtT?=
 =?utf-8?B?Wm8xeWFQT2hXNTBGTmdtQjRhNklJWk1nRXBaNnV0NjRldUJCQ3VCTklXa21Q?=
 =?utf-8?B?b0k1b21tVyt6WUU3aXFwcXBwWjFwLzBVaGJ2YlcvZWpDODZJek1lVEtBUWJ6?=
 =?utf-8?B?RnYwZlN0NnJUaWtEWjB6T2JJMTN5SmtRdnV2Z09SaFA2cnMyUSthYTFLbUEy?=
 =?utf-8?B?dExHU1d2OFJjVlpTR2xtOEU5VkVQd0Z1OXFURkt1blFPQUp2enZKcHpCWWpv?=
 =?utf-8?B?bDh2cWwxL0JETGI1bmNmMHpRNTNTQ3FjMVJxM2J1TEVXUmx5V21pYUJuL3lI?=
 =?utf-8?B?MTY5RDZ2V0lpZk1LcG5aZ05BRTI2dG9xUVVubUhoWGN0L1VWMVNiWEhUT0Qy?=
 =?utf-8?B?aEpwK2V2M1Z2UlRvd25UMXBzNVU1TG51YmlNc1l6QXlPanhHeDRvTVVlVGxJ?=
 =?utf-8?B?OUhXZGZ5amRMYWsxYzFWUHdaa1hWOU05cFArUUhNS2tMMHRkMHVPa1hSNndK?=
 =?utf-8?B?V2JSTk9pNVZPU0k2TnJ3bXZPTGRRcVowZGpONWhzcG9SRk0waGxIZk9qQlVn?=
 =?utf-8?Q?fxo4cGRTu/viHUK/H8ojxuZKv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4907217-8837-4ed1-4ed7-08ddb493b6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 09:27:47.7462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sm66R4StIE6nJG6Lq/tDd2LJINrJO7s/tCtl/M7DcBaMtIpAIUH0S/3VOq8OzJoyk755y+JBO+7ytCbIjWIq/62CcM8YydaBKhhv3SJ/7oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8680
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDE1LzE5XSBpbnRlbF9p
b21tdTogUmVwbGF5IHBhc2lkIGJpbmRzIGFmdGVyIGNvbnRleHQNCj5jYWNoZSBpbnZhbGlkYXRp
b24NCj4NCj4NCj4NCj5PbiA2LzIwLzI1IDk6MTggQU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0KPj4gVGhpcyByZXBsYXlz
IGd1ZXN0IHBhc2lkIGF0dGFjaG1lbnRzIGFmdGVyIGNvbnRleHQgY2FjaGUgaW52YWxpZGF0aW9u
Lg0KPj4gVGhpcyBpcyBhIGJlaGF2aW9yIHRvIGVuc3VyZSBzYWZldHkuIEFjdHVhbGx5LCBwcm9n
cmFtbWVyIHNob3VsZCBpc3N1ZQ0KPj4gcGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uIHdpdGggcHJv
cGVyIGdyYW51bGFyaXR5IGFmdGVyIGlzc3VpbmcgYSBjb250ZXh0DQo+PiBjYWNoZSBpbnZhbGlk
YXRpb24uDQo+c28gaXMgaXQgbWFuZGF0ZWQgdG8gZG8gdGhlIGludmFsaWRhdGlvbiB0d2ljZT8N
Cg0KWWVzLCBiZWNhdXNlIHdlIGRvbid0IGhhdmUgYSB3YXkgdG8ga25vdyBpZiBwYXNpZCBjYWNo
ZSBpbnZhbGlkYXRpb24gZm9sbG93aW5nDQpjb250ZXh0IGNhY2hlIGludmFsaWRhdGlvbiBpcyBk
dXBsaWNhdGUgb25lIGZyb20gZ3Vlc3QuDQoNCkl0IGRlcGVuZHMgb24gaWYgd2Ugd2FudCB0byBz
dXBwb3J0IGEgZ3Vlc3Qgd2l0aCBzdWNoIGZsYXcsIGlmIG5vIG5lZWQgdG8gc3VwcG9ydCwNCndl
IGNhbiBkcm9wIHRoaXMgcGF0Y2guDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGlu
dXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaCB8ICAxICsNCj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA1MQ0KPisr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICBody9pMzg2L3RyYWNlLWV2ZW50
cyAgICAgICAgICAgfCAgMSArDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj5iL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXgg
OTJhNTMzZGI1NC4uYjNlNGFhMjNmMSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
PiBAQCAtNTc1LDYgKzU3NSw3IEBAIHR5cGVkZWYgZW51bSBWVERQQ0ludlR5cGUgew0KPj4gICAg
ICBWVERfUEFTSURfQ0FDSEVfRk9SQ0VfUkVTRVQgPSAwLA0KPj4gICAgICAvKiBwYXNpZCBjYWNo
ZSBpbnZhbGlkYXRpb24gcmVseSBvbiBndWVzdCBQQVNJRCBlbnRyeSAqLw0KPj4gICAgICBWVERf
UEFTSURfQ0FDSEVfR0xPQkFMX0lOViwgLyogcGFzaWQgY2FjaGUgZ2xvYmFsIGludmFsaWRhdGlv
bg0KPiovDQo+PiArICAgIFZURF9QQVNJRF9DQUNIRV9ERVZTSSwgICAgICAvKiBwYXNpZCBjYWNo
ZSBkZXZpY2Ugc2VsZWN0aXZlDQo+aW52YWxpZGF0aW9uICovDQo+PiAgICAgIFZURF9QQVNJRF9D
QUNIRV9ET01TSSwgICAgICAvKiBwYXNpZCBjYWNoZSBkb21haW4gc2VsZWN0aXZlDQo+aW52YWxp
ZGF0aW9uICovDQo+PiAgICAgIFZURF9QQVNJRF9DQUNIRV9QQVNJRFNJLCAgICAvKiBwYXNpZCBj
YWNoZSBwYXNpZCBzZWxlY3RpdmUNCj5pbnZhbGlkYXRpb24gKi8NCj4+ICB9IFZURFBDSW52VHlw
ZTsNCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+IGluZGV4IDFjOTRhMDAzM2MuLjYyMWIwN2FhMDIgMTAwNjQ0DQo+PiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gQEAgLTkyLDYgKzkyLDEwIEBAIHN0YXRpYyB2b2lkDQo+dnRkX2FkZHJlc3Nfc3BhY2VfcmVm
cmVzaF9hbGwoSW50ZWxJT01NVVN0YXRlICpzKTsNCj4+ICBzdGF0aWMgdm9pZCB2dGRfYWRkcmVz
c19zcGFjZV91bm1hcChWVERBZGRyZXNzU3BhY2UgKmFzLA0KPklPTU1VTm90aWZpZXIgKm4pOw0K
Pj4NCj4+ICBzdGF0aWMgdm9pZCB2dGRfcGFzaWRfY2FjaGVfcmVzZXRfbG9ja2VkKEludGVsSU9N
TVVTdGF0ZSAqcyk7DQo+PiArc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmMoSW50ZWxJ
T01NVVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBB
U0lEQ2FjaGVJbmZvICpwY19pbmZvKTsNCj4+ICtzdGF0aWMgdm9pZCB2dGRfcGFzaWRfY2FjaGVf
ZGV2c2koSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBQQ0lCdXMgKmJ1cywgdWludDE2X3QgZGV2Zm4pOw0KPj4NCj4+ICBzdGF0aWMgdm9p
ZCB2dGRfcGFuaWNfcmVxdWlyZV9jYWNoaW5nX21vZGUodm9pZCkNCj4+ICB7DQo+PiBAQCAtMjQz
Nyw2ICsyNDQxLDggQEAgc3RhdGljIHZvaWQNCj52dGRfaW9tbXVfcmVwbGF5X2FsbChJbnRlbElP
TU1VU3RhdGUgKnMpDQo+Pg0KPj4gIHN0YXRpYyB2b2lkIHZ0ZF9jb250ZXh0X2dsb2JhbF9pbnZh
bGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcykNCj4+ICB7DQo+PiArICAgIFZURFBBU0lEQ2FjaGVJ
bmZvIHBjX2luZm8gPSB7IC5lcnJvcl9oYXBwZW5lZCA9IGZhbHNlLCB9Ow0KPj4gKw0KPj4gICAg
ICB0cmFjZV92dGRfaW52X2Rlc2NfY2NfZ2xvYmFsKCk7DQo+PiAgICAgIC8qIFByb3RlY3RzIGNv
bnRleHQgY2FjaGUgKi8NCj4+ICAgICAgdnRkX2lvbW11X2xvY2socyk7DQo+PiBAQCAtMjQ1NCw2
ICsyNDYwLDkgQEAgc3RhdGljIHZvaWQNCj52dGRfY29udGV4dF9nbG9iYWxfaW52YWxpZGF0ZShJ
bnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgICAqIFZULWQgZW11bGF0aW9uIGNvZGVzLg0KPj4g
ICAgICAgKi8NCj4+ICAgICAgdnRkX2lvbW11X3JlcGxheV9hbGwocyk7DQo+PiArDQo+PiArICAg
IHBjX2luZm8udHlwZSA9IFZURF9QQVNJRF9DQUNIRV9HTE9CQUxfSU5WOw0KPj4gKyAgICB2dGRf
cGFzaWRfY2FjaGVfc3luYyhzLCAmcGNfaW5mbyk7DQo+PiAgfQ0KPj4NCj4+ICAjaWZkZWYgQ09O
RklHX0lPTU1VRkQNCj4+IEBAIC0yNjk2LDYgKzI3MDUsMjEgQEAgc3RhdGljIHZvaWQNCj52dGRf
Y29udGV4dF9kZXZpY2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAgICAg
ICAgICAgICogaGFwcGVuZWQuDQo+PiAgICAgICAgICAgICAgICovDQo+PiAgICAgICAgICAgICAg
dnRkX2FkZHJlc3Nfc3BhY2Vfc3luYyh2dGRfYXMpOw0KPj4gKyAgICAgICAgICAgIC8qDQo+PiAr
ICAgICAgICAgICAgICogUGVyIHNwZWMsIGNvbnRleHQgZmx1c2ggc2hvdWxkIGFsc28gZm9sbG93
ZWQgd2l0aCBQQVNJRA0KPmJlIGZvbGxvd2VkDQo+PiArICAgICAgICAgICAgICogY2FjaGUgYW5k
IGlvdGxiIGZsdXNoLiBSZWdhcmRzIHRvIGEgZGV2aWNlIHNlbGVjdGl2ZQ0KPnJlZ2FyZGluZyB0
bz8NCj4+ICsgICAgICAgICAgICAgKiBjb250ZXh0IGNhY2hlIGludmFsaWRhdGlvbjoNCj4+ICsg
ICAgICAgICAgICAgKiBpZiAoZW1hdWx0ZWRfZGV2aWNlKQ0KPmVtdWxhdGVkDQoNCldpbGwgZml4
IGFib3ZlIHRocmVlLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

