Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3BAD58CDC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ZkO-0007lt-9u; Mon, 23 Mar 2026 03:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w4ZkM-0007lk-Dz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:30:46 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w4ZkJ-0001t0-DI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774251042; x=1805787042;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CJYoW5lR9itNE7n4HqjNEIa5gLcn/B0QS2eFcfZipdI=;
 b=BOmZyTN8CDWAxXFGNS3SfDxSdIKhe+z8v3Z84RTx0DGYfUm6WgYREAG4
 bdkFMFwXksJWnE53KQq82aj+O+/80w8bu+bObgKRICueT2r9HVkasqWB6
 qcB2oXiLsElUuGe/maV/igPm0rp59RJ6K/mFdruf/Cjq9+ZqcPlyGaxDd
 fyuf1N4lkepE2OcYHx9A5JstaxdO+VKLeiJcUGbsWnC6/OlgLuAVSreZK
 K/kl8TjP7TFSNK4osTgZNA40tHTlfSeGFYXnxZ/zcxpuzRTlqpdmrvS7U
 6niDSOJ3t3cDhcEaEN6OF53omL+zZ6G9X/5p35MDIaWjSqpg48d/ZANBy w==;
X-CSE-ConnectionGUID: KWyYNY0tT5mzOUfhD2m4AA==
X-CSE-MsgGUID: 25HxvjagRz6ez0x53jxxKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="78840254"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="78840254"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:30:39 -0700
X-CSE-ConnectionGUID: vBhdXL+TQX+JWVls59fsyg==
X-CSE-MsgGUID: efm8MrDmR2+DFPv8Ar/1Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="228022283"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:30:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:30:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 00:30:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:30:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMCa4CrxvSe4ZaS/oheiLK3RrWOgG+/Z+f5HTea02NKRY5Mt+zYPdpbmyunYiQkdnnUnwcVT8q8yp0kSE5KeF6uNSlri1PAVnVmRaWIhIhnSLBdKyuUKJdmv05XGe1ctSyK/MlrMTmhJOh+IMvvZfXs1HVm2mlN9mIimZgGQscTMlh0JoG15jIf61Eu2xXtUBGtSTLYVenu/oOsYkHsauAEtjH9zCHorWeDtawYErnI/J0k/1gXIQHdIpuDYTsudpUumu5hXiHEgM4mfkwskRROXJAfQtcYyJrUWvC9dkcUKP4u0IVDlYC0DbY5bhRnKIZwI0AclmQJC5P0u2HkUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJvUtdY0Rju3PJpnNPuB8Ow4b8PGz+RRARLTptDweZU=;
 b=OdK5r3c4hOwLDmmBhsk3uYNzrQN8Ghr4uTWW1gP3zuaSsxAQ/TYLaxLVku4bQGS/HLugPS1v/SRukfryKzVDmdL/Aji30JuVhnodw538WuQNPIBLHvHJjg8UuEocFlZvdctAw0Ci1E/kqHCGR5CMaO8bBWAxwhzJDdPxYQsydiBXU6MYJiCKqTQk5tUqg32Or57H2imirj+EtuK41f7KNtrpbeTv6Tl/fJJLc8iHdS0YM/v4jGU/pU7gvKj0Hb3aCDkaRDr0C0hs8qXZm2jgeCLIKaoCoCgXpY/J9RIC3En/bGcq94+hVfHHKtqZaNggrE7TP+oRHyT4/UNlvXcz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 23 Mar
 2026 07:30:34 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 07:30:33 +0000
Message-ID: <35778e4a-5491-4e25-bbb9-0534af488e9c@intel.com>
Date: Mon, 23 Mar 2026 15:38:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-8-zhenzhong.duan@intel.com>
 <52063ae4-eb23-4139-9385-43422463e278@intel.com>
 <IA3PR11MB91362B7ED15479ADDE95E3A4924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91362B7ED15479ADDE95E3A4924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0009.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::8)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 89997ecf-6e5f-49cb-398f-08de88ae119f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|366016|376014|56012099003|18002099003|22082099003|3613699012;
X-Microsoft-Antispam-Message-Info: dmrwQ7ZakcYt16qcR4IRoH/nPYUFAg85X8726GcmbNT8gWE9H9mUVlKHq6vggHHzAUpu7LCv4uSsjQ66rk+j/dDzYFRRDM9lSvlUI3Px0OmC3Hl71tJ9+lyJtNBPZFfg9q9tqZhEl9d4ASdEIW3A8UJxuq2EgGM8rBKBOqwl1YNjXL0myS6/LgnJ2Kogof5ll9Dtq1z5TarrcxFiiIaZ9AodlYdSskgxZoxDShQdTAdpLnL0FYs2dfbtT4YUUm8BlwUlkU0C80eMBwZfwz0LA9rwM04AY9fN0jvVc/LR6QGjcfF5T6Jigz0BkZqg/cSA/etH7UWn3+CV2Y6qWvaf+fZwaqLhl6+LEp4ki5N08/ZxrcVYfK2iWt3lz/N0+phxl4Op2y45B5qMKY2nExAmxmeHd2Ek++2FoMxIS5PyDDHnQXB6YCZK3vRBGqzESgu5HPqGRzYl9/rPP9zNh9LnmMRAqq0fdUtVLqAwRjjfGEsa9+ucznsY0c3G5x7ILtFj/PGl4m0LOA1jfWWc79y7F/aAns8nZHNLC20NMRtOeHPt8Z5ptbRnmpStj8dm6ofu5/TCRdwY68zn63AScvSFa6pBl/9FojZqRUWPgas5a1s4/mesB4Z9Dc6LzxyGYNIh62lETlwbuGE1R1BaGuJaaj1hlWYl5ID+lLFf1XiF6YzepGaV4cqcGqGahLNd4kUutTKUjRflsj/VqIvnZ+/NGs+LXetB9rtIj2ymJ+mZ6HrgId+uxtF6GbBf/Av6Rw8dQK4dg7Q8iYoUa+QLUvZO/WSAUyqdB4dYz5WH9E7VPVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(366016)(376014)(56012099003)(18002099003)(22082099003)(3613699012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWNYZ25oNGNTUFhSRkY5TVRuSm1MNVp5Q3ZiNVZhbUlSK1R3UXpmWTRrcFhH?=
 =?utf-8?B?T3h3czBDbnh1RS9peWhybmR5cnc4cGVObys2dFFtR2FWVDM1clZFNHNKZFZ0?=
 =?utf-8?B?by9YbEltb2dDUFgyZ3J1cy9NZW0rcGJwLzFQdHlCT1VtVUxaM2l3aGxPeWNY?=
 =?utf-8?B?dUlMUHB0S2pOMWdsZnc1dXRxYXdiWHFkK1NWRi8yb1R6Q2UvK09jYVF0ZFEr?=
 =?utf-8?B?NGdsZlphV2xkNGpOZm9OQVBSNkUwa0diRXZRWmJDMWp2d0JZcGMvWHRScXc0?=
 =?utf-8?B?REg4YU0rQ1VBYmduZ2s0ZWI4VzZqREhqUDJ2M3pBN1JxRnJ6ZmVxRzExNEpy?=
 =?utf-8?B?Y1JlT2dZck1HdzgydXI3OU9rYmFUTXNzT1A2R2c5R0pxenhENWp5bklvNjI2?=
 =?utf-8?B?RFhIckU5Umw4WFlqaUFCeVFlVHBldnRmbEFPcDlCbWM4VTFmSC9MSWlPekx2?=
 =?utf-8?B?R0VZWnE3b2xvNXZ3TUphSlNWc1pKMlM3SzIxWWZTc2tpQVpNUGx6Qk85aVFj?=
 =?utf-8?B?WmFZU2xkL2dRbTNaWVF1NzZXS3QxQ09PWGRGV1h3OEdXRDJDckd6YmoweDBB?=
 =?utf-8?B?ZzgxQmlaTkxOLzJhVElTRmtSbE0xc2xRM1F1Sll6R3dHeTFaeEkvcDhuNG4v?=
 =?utf-8?B?UGtOWWk1eHAxQnZqbmNsYURBZUt1cTQxVHhvN0wyMmt6ZmRISldxeVFUeDM2?=
 =?utf-8?B?RmlVc3p3VkZ1MVZyVVBEUm1TTWFvUEhkRVRMbURMTkVOMlZLZ1RwVldKeXMx?=
 =?utf-8?B?d2gyUHk2eXRib2NyM3lsSFMwSU9nOVNxNW9DL3pBQ0VQTERxNHFoeTZocW5r?=
 =?utf-8?B?TzN6SzR6b2VycG5wWFJRMFZJNFk1M0pRTm9kMG1tRDMvOHpORHNhaWJIanpy?=
 =?utf-8?B?cEt5ZGtaZURTcXNETE4vTDBla1JZZE44Z1VqRUhQUGVvWnJIcFRaSkZicU1E?=
 =?utf-8?B?NWNQZ3BlaDNadzlCbUpnaC9sYmNUTnVKM1pGVWN2Ty94QnBIdFJZNXhmSmMr?=
 =?utf-8?B?YjVRRnJvQ25HVTJmK0tZL0Y1Y2h3RTdEK3pXTEpSeXorRXJQNnNFMjlDdEcz?=
 =?utf-8?B?VURndDZOcGRaa1I4VmNwU3JlWnFXaTJGU0dwbDhoMVJ3WjdtbmhhZThIZWJz?=
 =?utf-8?B?aGhSVnJRYkU5VWdpOGQ3R1ZQWVp3UmpFVVQxcUZIU3JjRWQyYm9NV1VOaTlX?=
 =?utf-8?B?aXhFaXNoVVR0SlA4dXVocFU4TUdyNFV5eUNwajFSblBJRFFkK0wvQWpNeFNZ?=
 =?utf-8?B?QjJaaVRCN0lKanNmNWNSMms2ZzRsYXk5UXdGZXZ3YU81aEgwQ0dQSlppWXZ2?=
 =?utf-8?B?L3ZBSDR0a3U0SjV6Z3g0QVZERXVqMVVqTzhLZ3JUUGQrU3E0eUF4ODEvMEVY?=
 =?utf-8?B?eWVsbHNBTEViQXpxTzhJblUwNEE0bG1mU2cvOW5rekNKd1g5U2RpVW03RkIz?=
 =?utf-8?B?NzNiL1c0T0dsR1JHYjczWmFaWEhUSldLWGhpY2xsWGp3ZlpyK0RDQk1XSm5Q?=
 =?utf-8?B?QXVqWUFMZ1ZzQTZ3OTB3cHlRT1k5UmFiNWU5OFNnMHEyM21VRnBZT091ZE0z?=
 =?utf-8?B?SkFYTEVnUUpSdHpENmdjSWFYam5TZ056NFIrRWY1dUNlSjFNUDlzbnJWc3dk?=
 =?utf-8?B?WnNoRWdZSzlRUlFVN2JuL3Q3aXVZVnVEMkhKUnBHM3lqRTM3ZkFkSTQxWDhX?=
 =?utf-8?B?Tm40Q0k5ajlTZThENE5ORTVERGpKa2xUS2NCTzVIYyt1S1NWWi9QMW1xOHBT?=
 =?utf-8?B?dUtuZEJYQTI0SUhTZWxuNkZ0TEFLZlA5VEhMcDBnSXplU3VLaGxBSk0rUEhP?=
 =?utf-8?B?UTJ0RmVjbE9zRk0rajRzU0JlUmorZDhLbDBNSC9NdDVJdG1NdlJPS1N3czlD?=
 =?utf-8?B?NWlKWXRLMHVwZ3BTU0RHNzZNekNzQTgyVFFXU2hadGl4RmNROElwSldveXhi?=
 =?utf-8?B?WFEyQWZLOGJ5bGpaTXgxYVJocEwrVVNHV1piU3FaZlVWdk5JdjFyUVZDdXVQ?=
 =?utf-8?B?ZmV0bW8wSUNZZzZxU2RGM1NsbWt1aXhXd3Eycy9CRXc3cUQ2VklrSW54blRH?=
 =?utf-8?B?Q0xpOUJscFV1UjVZNC9RQ05Ta0pkQ3A5eDBtaVpKYnZ6cnJCelZ3TG94S1NY?=
 =?utf-8?B?eEJkeWgzUHZUR3c1SDFKVS9jcHN5YlI3OThzbXpnQzlGMGxrTVZvRnlidW9m?=
 =?utf-8?B?TWxCWFh5VEFDWTRkTmxkdnpWeURMbk54SlZwY0M0V0RkSndCTVo1OXEzQlV4?=
 =?utf-8?B?dzZnak11cUZWWDVIdUVNWDkwbHFxY2x2VmJBT2hab21vQklvOXdQVm9jMWRT?=
 =?utf-8?B?UVdHcHkxZzQybnMwaTI4NjFQOHlSelloL0tzcFNJM1FURkFlOXd4dz09?=
X-Exchange-RoutingPolicyChecked: i9L+V+FBQg60EAHDcVAbb6y+7IR5oyZxdFLjSehgc7rfwKtmi8pP0dTaDdqrmpqvAVWlAvNmy425zzUKu/nl/JDwRAH+S/YZuCqkS9Dojx97yU4pImJbmQKrsmZPAwxgqzUt07em2LpYpxwz9Eu3adLhpxxhUPLs+62oUwAUyl5IHSEL1004KmcCJ4hfYWT5wOhXyC9CiYxzeCuTSSvxq3SM8UdVtm0Z7WR4L5W/GfZeysp9D+i5Y8mSsHe1Rv2fajOGaTOXUaa0KC7WlJB6A27rtNEOqCqKJ1cbi2kP3BkSMWDWSoO1fwKHB04bEmQLGo35g8r80P7zq5Wn6yx5vA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89997ecf-6e5f-49cb-398f-08de88ae119f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:30:33.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1zNql+CL0+eFB5ZRQfeyHCZy7cu5mDBlSI2NIXMKeAXNVY5xstFYwID8SCgsTR7fIviTAburzqXEYmJBFnsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/23/26 13:50, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
>> pc_inv_dsc request
>>
>> On 3/6/26 11:44, Zhenzhong Duan wrote:
>>> Structure VTDAddressSpace includes some elements suitable for emulated
>>> device and passthrough device without PASID, e.g., address space,
>>> different memory regions, etc, it is also protected by vtd iommu lock,
>>> all these are useless and become a burden for passthrough device with
>>> PASID.
>>>
>>> When there are lots of PASIDs used in one device, the AS and MRs are
>>> all registered to memory core and impact the whole system performance.
>>>
>>> So instead of using VTDAddressSpace to cache pasid entry for each pasid
>>> of a passthrough device, we define a light weight structure
>>> VTDACCELPASIDCacheEntry with only necessary elements for each pasid. We
>>> will use this struct as a parameter to conduct binding/unbinding to
>>> nested hwpt and to record the current binded nested hwpt. It's also
>>
>> s/binded/bound/
> 
> OK.
> 
>>
>>> designed to support PASID_0.
>>>
>>> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
>>> (pasid cache invalidation) request, walk through each pasid in each
>>> passthrough device for valid pasid entries, create a new
>>> VTDACCELPASIDCacheEntry if not existing yet.
>>
>> I think some tweak is preferred w.r.t. this and the next patch.
>>
>> In this patch you only need to handle the PASID entry addition. Hence
>> you assume no existing VTDACCELPASIDCacheEntry yet.
> 
> [...]
> 
>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_accel.h    |  13 +++
>>>    hw/i386/intel_iommu_internal.h |   8 ++
>>>    hw/i386/intel_iommu.c          |   3 +
>>>    hw/i386/intel_iommu_accel.c    | 170 +++++++++++++++++++++++++++++++++
>>>    4 files changed, 194 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
>>> index e5f0b077b4..a77fd06fe0 100644
>>> --- a/hw/i386/intel_iommu_accel.h
>>> +++ b/hw/i386/intel_iommu_accel.h
>>> @@ -12,6 +12,13 @@
>>>    #define HW_I386_INTEL_IOMMU_ACCEL_H
>>>    #include CONFIG_DEVICES
>>>
>>> +typedef struct VTDACCELPASIDCacheEntry {
>>> +    VTDHostIOMMUDevice *vtd_hiod;
>>> +    VTDPASIDEntry pe;
>>> +    uint32_t pasid;
>>> +    QLIST_ENTRY(VTDACCELPASIDCacheEntry) next;
>>> +} VTDACCELPASIDCacheEntry;
>>
>> btw. s/VTDACCELPASIDCacheEntry/VTDAccelPASIDCacheEntry/ looks better. :)
> 
> Sure.
> 
>>> +
>>>    #ifdef CONFIG_VTD_ACCEL
>>>    bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice
>> *vtd_hiod,
>>>                              Error **errp);
>>> @@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace
>> *vtd_as, Error **errp);
>>>    void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t
>> domain_id,
>>>                                          uint32_t pasid, hwaddr addr,
>>>                                          uint64_t npages, bool ih);
>>> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo
>> *pc_info);
>>>    void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>>>    #else
>>>    static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>>> @@ -49,6 +57,11 @@ static inline void
>> vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>>>    {
>>>    }
>>>
>>> +static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
>>> +                                              VTDPASIDCacheInfo *pc_info)
>>> +{
>>> +}
>>> +
>>>    static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>>>    {
>>>    }
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index c7e107fe87..ede4db6d2d 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -616,6 +616,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>>>
>>>    #define PASID_0                             0
>>> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
>> ~VTD_HAW_MASK(aw))
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>>>    #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
>>> @@ -646,6 +647,7 @@ typedef struct VTDPIOTLBInvInfo {
>>>    #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
>>>    #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) &
>> VTD_PASID_DIR_BITS_MASK)
>>>    #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
>>> +#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
>>>    #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>>>    #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) &
>> VTD_PASID_TABLE_BITS_MASK)
>>>    #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable
>> */
>>> @@ -711,6 +713,7 @@ typedef struct VTDHostIOMMUDevice {
>>>        PCIBus *bus;
>>>        uint8_t devfn;
>>>        HostIOMMUDevice *hiod;
>>> +    QLIST_HEAD(, VTDACCELPASIDCacheEntry) pasid_cache_list;
>>>    } VTDHostIOMMUDevice;
>>>
>>>    /*
>>> @@ -768,6 +771,11 @@ static inline int
>> vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
>>>        return memcmp(p1, p2, sizeof(*p1));
>>>    }
>>>
>>> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
>>> +{
>>> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
>>> +}
>>> +
>>>    int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
>>>                                      VTDPASIDDirEntry *pdire);
>>>    int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 744b5967b2..984adc639a 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3202,6 +3202,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState
>> *s, VTDPASIDCacheInfo *pc_info)
>>>        g_hash_table_foreach(s->vtd_address_spaces,
>> vtd_pasid_cache_sync_locked,
>>>                             pc_info);
>>>        vtd_iommu_unlock(s);
>>> +
>>> +    vtd_pasid_cache_sync_accel(s, pc_info);
>>>    }
>>>
>>>    static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
>>> @@ -4760,6 +4762,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus,
>> void *opaque, int devfn,
>>>        vtd_hiod->devfn = (uint8_t)devfn;
>>>        vtd_hiod->iommu_state = s;
>>>        vtd_hiod->hiod = hiod;
>>> +    QLIST_INIT(&vtd_hiod->pasid_cache_list);
>>>
>>>        if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>>>            g_free(vtd_hiod);
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> index c2757f3bcd..0acf3ae77f 100644
>>> --- a/hw/i386/intel_iommu_accel.c
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -257,6 +257,176 @@ void
>> vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>>>                             vtd_flush_host_piotlb_locked, &piotlb_info);
>>>    }
>>>
>>> +static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>>> +                            VTDPASIDEntry *pe)
>>> +{
>>
>> then you can name this as vtd_accel_fill_pc(). And I think you would
>> have vtd_accel_update_pc() and vtd_accel_delete_pc() in the next patch.
> 
> Yes, in current implementation this patch handles pasid entry addition and update,
> next patch handles removal.
> What's the benefit if we move pasid entry update into next patch?

If no redundant flush, for a newly created pasid entry, you need not to
loop the pasid cache entry list. But, it's possible to have such guest. :)

>>
>>> +    VTDACCELPASIDCacheEntry *vtd_pce;
>>> +
>>> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
>>> +        if (vtd_pce->pasid == pasid) {
>>> +            if (vtd_pasid_entry_compare(pe, &vtd_pce->pe)) {
>>> +                vtd_pce->pe = *pe;
>>> +            }
>>> +            return;
>>> +        }
>>> +    }
>>
>> hence this loop can be avoided.
> 
> Hm, I think guest may send redundant pv_inv_dsc, so we need this loop
> to bypass existing pasid entry to avoid adding duplicate pasid entry.
> Let me know if I misunderstand what you mean.

Although I have an idea to handle it. But it relies on some kind of flag
returned by the removal/update processing path to tell no need to re-
create pasid cache entry in the vtd_replay_pasid_bind_for_dev() path. I
don't think we need to make things so complicated. So let's follow the
current splitting. But I think you still can name this helper as
vtd_accel_fill_pc(). "find" sometimes means return something back.

