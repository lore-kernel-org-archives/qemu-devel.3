Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B77C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzai-0004Um-MY; Wed, 16 Jul 2025 06:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubzRk-0002JB-Hc; Wed, 16 Jul 2025 06:33:08 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubzRi-00067G-H8; Wed, 16 Jul 2025 06:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752661986; x=1784197986;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rkusqY8E1nnh0XgWTuIIs1eghLfZXh3c8TYPUjX6FeU=;
 b=O35Qqm6aImRpZ1LYx3PcPFuFjYsehvsvmVvrM7Ni+BGz/BbZKV4JbdT1
 6hBH5J7vcp/Jg/DLFqnPnCZKsRjiHOZdsYZWC4d1Uos32NNok2FCOAkx7
 bBv9ayOH1uEZro09ncKWHJt4eJq9OsLX9aqEpIjdSXf2Fb4UfbNwLjUaE
 MZSSdcBQy8uk3npJHkjiILTXkfSKxpPXTvppUtJDCE3CD2iZXyS7AS0Kw
 d7DxjnzCR2SH7ZPkzkiiXBeepppkdRAemhiHeXWfVMpwSavt1Kb+JrN3v
 kD3kLSHd5PSuRk5bee4UfIYkkvdfV46nXlgJti9c7QmLMpOxpl2BJdmzh w==;
X-CSE-ConnectionGUID: X5w8y4ksSmOcFqKRs8OYOQ==
X-CSE-MsgGUID: vkgclA6DQqqUUykY+r+HtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65472387"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="65472387"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:33:03 -0700
X-CSE-ConnectionGUID: 0ZPx+JYiSUWWeb2UBzDKvg==
X-CSE-MsgGUID: FKErkWpqRm+Jdc7F7Czfew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="158021023"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:33:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:33:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 03:33:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT6n57PDpTO0EB35AchsAlBhZj3h17bO3m0QMn47bomG9kL4LtZ283j/1P9roBG1wsRDCy+5LcbtdurQefvso8ssR2I90i8zpbVe+UWHxzwGZMd68yQNTz0b1MG04gasYFdUTIZ73PfwaB9fuipJKusECvgeG+KxvQrYAuGRh2QMQJG1BRWkxEJIfXDRXsnAHVc1ObZVM8ZimUMSy58wB8DS5Hh4Di1zkC4nNgbac8Qxrgc4Fg3edyrf5R28STzEgTrMZzd4bf3e1xlEo+ohcPGXA5nSRyPCYUpVZcmDy2MUd/KX7yiLwJvArHfU5UJRnc4Pcwva7eKt2eM05s8FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU8Tu1fnWuh8ljLjowCvWJ9WhFu0UWugbN5PQ42lmsU=;
 b=xcopyxcluPktXp+3rzUeElsftgpLA2d5IZt8CUcXpdbTMI+pt4RYzjjexjToCgb4pXBQuZ7EF/qJB7czIC/qqoDkEf76MnFN1u3Nkji5DwCV9uR10a9+s5agz02syazUo/8T+5BzB8Z4gMq3rgXsSe+VESzMZ1YQwVJjSDdySaqcegzpjASM3oHwj9yFBUU93ifR8lHh3r6PduaZQAyXXyIFm+5K59N6xxYOSgkTbP+tyV6KOxAoe67F8tJBtZKSN0jQB/SDh56EHPe51ql8e931BdEg1pyy/xYqIPvx6zjS3BzccClP65HRkswELg6470A+cuJNap8FZF0cJcnqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 10:32:22 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 16 Jul 2025
 10:32:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHb9Nia/FYvy/Va1kO7Qt3Wn+Al1LQy3OPggACdxwCAAMPz8IAAQTsAgAAFemA=
Date: Wed, 16 Jul 2025 10:32:22 +0000
Message-ID: <IA3PR11MB91362923E44404F370F3EF559256A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <798f739303f74fbca49a09a623a0a118@huawei.com>
In-Reply-To: <798f739303f74fbca49a09a623a0a118@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB4966:EE_
x-ms-office365-filtering-correlation-id: 9b0397c0-2199-4d65-8361-08ddc4540cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nu2PNcHSIMHTgLa9DgDZHJTwOXt2SalzlP/FiuHEzXoB4/YjGg1588iyZkCm?=
 =?us-ascii?Q?SSkQnr8oF23sEXy6OUO1aGHl6mT57UdbfCc0V2eq3EC86FfywsWOhLEZlGXw?=
 =?us-ascii?Q?e4BdBNM8epxqFtCKodanslWBbIiCcRY1R09S6SNI8QHSPFrFEVywkzllZhkp?=
 =?us-ascii?Q?o1lbbZ+UQ9Om7LEL3zo7w+YOe06/hQPg6D9oHrxK2JXnZylBrq5CGWyeoQKi?=
 =?us-ascii?Q?WndAJSCbBIa+Vqq+xsx6DL5Oy10BnSiJGEsFhIeqEL9hnYRM8FbFEw6BgD/a?=
 =?us-ascii?Q?DdjmlePTZzH8YX/MSFuD27HdOPjB7f6k6VRhT6aMEcfRdL86xPN56VqScXBN?=
 =?us-ascii?Q?jZUNc36Cu/lS+QwRwlf5Rp9AhxQH0WvqV9Qedq19iNReojsyH304wirGUTtu?=
 =?us-ascii?Q?rKOHeOEvyiNz+YZUQfxW8f5mhkkfIWNd8hdbDf9ug8umEeC6Owf9KRQeYjoy?=
 =?us-ascii?Q?/aAmGLDBzgCDT2JP+Ut+DnKslaefEoAxfucQ3LDgoNIB9Lh5VHlpmhK39BaG?=
 =?us-ascii?Q?lNXuvc13+uiTNCOnqPKdTvL0IwvO0GhijAZSF1kRhTH/SfZiDSy0VGbyVykj?=
 =?us-ascii?Q?2ASMbh3FE4l7rQLNCsZBUSXIW+7oDBP7oQUmE26XqdahuUpdQL0O/c8vXWkj?=
 =?us-ascii?Q?ROv6Bb7rq5OMvVWnpe8lzXG/sFEcIynVhCMVTVQb+oQYnARs6wcmymmEttQY?=
 =?us-ascii?Q?flyWvbLtoHtsuGRzo7OHK8K6GXnWNdt3YUU5206kkqoaxZK6ZJm/rFX6mE9m?=
 =?us-ascii?Q?5YyisCIFXeu5X/RbFzr0QgAhr3xyOYpybnI5i/fEHBJyvJ2toZsUVxqCdH+F?=
 =?us-ascii?Q?rGYMwCS+4a/+ZsVGt/vhGZS0O8/yaIpSZ3uCPzQh3MoQROPYyBp2k8/mNT09?=
 =?us-ascii?Q?8JC+H5UWIlYMg8xB8PTQBhJdvZNanObDSrKW6nS+vvfqy+mb9S8zQT6g0wL/?=
 =?us-ascii?Q?m9W6Eav5/30xQsTSN4qM69s1IlrzDPiB6vEhStJvGPKyh8CUkak7wp+wNSXR?=
 =?us-ascii?Q?OszWvISlT0IclwUf8qD1qiyeq1C+E0uMgty81d2ID7OL4+a6mG3ch86yE0rz?=
 =?us-ascii?Q?NEKL75Po6KcCDaGyOvCiRZc9olKADHiARiNC6+mzjsF+7MFbca8dQUbGeED/?=
 =?us-ascii?Q?v+uVJ+ECtRDk6UNJvYB+misb08svNfc1insimseBClmHBwZtgKNX6S+c49X3?=
 =?us-ascii?Q?XI5iHnbMEYDu3dng988tLE8cwKECLo2aFi5nIAfVIHshqoH9rtWS+MuqDoDI?=
 =?us-ascii?Q?CC7qeomO1+4mfqH8SaL4oA2fK13k7Tmlf3jVo+e1bhrtV4J/Gda++Xipr41b?=
 =?us-ascii?Q?4BF4ey92tCz/QhZJ8E4iTjepW5/7TGdG8kqqUfAacdmmWOx1ZCfxRxEumbg3?=
 =?us-ascii?Q?EEAbq+0RctFmuP5M0lZZHwkpA1d+qVfkrKCtbwFfXeHO9fSwLklg+bKKNiyE?=
 =?us-ascii?Q?7TIcyw+AS4F7ghpuy8rBzDlzamJyxVQySEHvNSLrVcRUGFhFyKswH0o8YA02?=
 =?us-ascii?Q?zGS2g8V296cr7T8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xWK5c2K5m0cQncycgRwa49jpoyDdB+rt0HgDaXo7k9NG8l1wVUVIvhqiZzxH?=
 =?us-ascii?Q?TgD0m9gqlORm8Ek1hzc7kderzZOqy8plk/g0cLzX0a/ix/89g0l7ot9iDcp6?=
 =?us-ascii?Q?YMJAwSrcc/mi2mxztMKw1wL2VrBM+HZZwNKMHpfOkwKeeiJnOBizNoCY5dYg?=
 =?us-ascii?Q?LnlXMZlzcYNwlvczbF9oZhUetQ8x1lFD/yTvXmLNRViTN8O4TkuxP7pTLa9S?=
 =?us-ascii?Q?J9Lys6FDCDE5ajN6InANJTHE9IEv2lTOK3F+SZCgIP8FXQn4CWTl/VcwZj6a?=
 =?us-ascii?Q?eiEwDdgpzyUdkzNL7dSMaOMweCtFQy43jdBMU0vUmV17mejGFXXaxQdH70kG?=
 =?us-ascii?Q?r8qA3JjYhlT1m41rVnu93r4EF+pTZwCgYlSEwUOeUpQdFyvSsaurRO+kTRkS?=
 =?us-ascii?Q?IqwV84JQdJw5yLdey3QlcpXy9XzqVVqtmrq58GAO6iOnH/S0vjuVrb67ZePC?=
 =?us-ascii?Q?QgyzStkKjSwMnti1VTmvP9HBTAyZjoCQBShXW0a3Ty2tHkDuMdY6ZBqCb4u/?=
 =?us-ascii?Q?OzLIh0Fo17NtjZD/u76T6oZxmLXosCR+drBHsbe0xMR0nI+p8zfYL68HSm3D?=
 =?us-ascii?Q?0VaX2BP6MmZ4LQjMCDPCfKvcphYNH7d5o1VHXe3muIE1GV6vibn3cVhI/DKq?=
 =?us-ascii?Q?N8+VYcqLztGzNVV1T9FGZY4a1nU0W+kAb+EqHAj7/5RZkKWG7iWdfRFkhoWS?=
 =?us-ascii?Q?8L94uYKyHEOuOyMjO34CwOWHlipuTGtokVcdruzI3j5k9KieHrI7RRxZ2eLG?=
 =?us-ascii?Q?7WMepuGh2rTYnr2+c2J4wjt6ds9ZtpBHVVDkF1/5zQ3yBSOOJC8iaC8O/HPx?=
 =?us-ascii?Q?BVMVfUVpiVYWik/HQe6BinYtdkbIw5VKGUBkGYfsCmeElI0UwMSA+TGhLKGk?=
 =?us-ascii?Q?heUPdTjSU3BTPxbxBtvkPN0IutvoFQw7ZF3UarOdSrBDeBzGz52vaUoyvNA7?=
 =?us-ascii?Q?Npw15mlMbKJYkTbq23ym/onH6+IcZOoD1JE80zDLFmUoAxvUVsq/8lvNC1eY?=
 =?us-ascii?Q?f0/u7w5+ojvatM806m9xN4vN9CzV7uBzJRex3plXWQYmvAIpGSxLNEOFsaLG?=
 =?us-ascii?Q?mkuU0t2yWRfzZKczHiEkNyL5Joj3c+Ul1GmHZCwCxjLnHtrfxWmbiM88SwMu?=
 =?us-ascii?Q?Co47aaU9cgivfu+RCFyP/uhogphO56l7mmLUkGVRrhqON+kdeVviih1QMpJg?=
 =?us-ascii?Q?28EGOJjreeDSwMAGvd/BLbbbjgQaYpH5HzOA29pm4gWtRTVnVmggq+zlCs5f?=
 =?us-ascii?Q?maCPE6pFdL+JgmnCcmmr0tM6hYJaHh/jQlrDbvepTG5BtImjuNLRu/bl1auI?=
 =?us-ascii?Q?DmWT4ycf2+Zr/kQ3Q9SVj03zOfrOQ08eG21J77RShO/Kj/qzDVfWxNF+2hgf?=
 =?us-ascii?Q?mVsSubj9ERIbZvov3zF8oUNMDnxcSZRFImCbXXfR0af4XhwLCRVfI5nE14YN?=
 =?us-ascii?Q?6SYpHzE3thjVACwHxk9bXk3dW2jjwLtj/kOfEZ2CfZWQbYHkNWRSXQH68MmL?=
 =?us-ascii?Q?vUf96L31GQcxz7OiPQ7X3f8G15WEHCyICANBH6n62JLKQhpqBoav0zTqxbBb?=
 =?us-ascii?Q?IG6dr9ViU65VRGz0449C7rnkqZ4COVKJVpf2585H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0397c0-2199-4d65-8361-08ddc4540cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 10:32:22.8063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6Xh78hgTICbgM3t+8zBDyGtbdYqu2z3LBnrgVz95t7wt9JSbXaikafZofY5/DFrXeC8QWM0MnzMuDT9b7wWSDOkqgxSeQCjAUKn8/52BhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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



>-----Original Message-----
>From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
>accelerated SMMUv3 to vfio-pci endpoints with iommufd
>
>
>
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: Wednesday, July 16, 2025 7:26 AM
>> To: Nicolin Chen <nicolinc@nvidia.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; eric.auger@redhat.com;
>> peter.maydell@linaro.org; jgg@nvidia.com; ddutile@redhat.com;
>> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org; shameerkolothum@gmail.com
>> Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
>> accelerated SMMUv3 to vfio-pci endpoints with iommufd
>>
>
>...
>
>> >> >+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool
>> >*vfio_pci)
>> >> >+{
>> >> >+
>> >> >+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
>> >> >+        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
>> >> >+        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {
>> >> >+        return true;
>> >> >+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI)
>&&
>> >> >+        object_property_find(OBJECT(pdev), "iommufd"))) {
>> >>
>> >> Will this always return true?
>> >
>> >It won't if a vfio-pci device doesn't have the "iommufd" property?
>>
>> IIUC, iommufd property is always there, just value not filled for legacy
>> container case.
>> What about checking VFIOPCIDevice.vbasedev.iommufd?
>
>That's right. The property is always there. But instead of accessing
>VFIOPCIDevice
>in SMMUv3 code, I think we can use object_property_get_link(obj, "iommufd"=
,
>&error_abort)
>instead?

Yes, looks better.

