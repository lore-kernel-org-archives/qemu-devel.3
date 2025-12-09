Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAB3D3B7E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 02:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSnUz-0004z8-3T; Mon, 08 Dec 2025 21:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vSnUu-0004yZ-1S; Mon, 08 Dec 2025 21:30:40 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vSnUo-0001V2-Vj; Mon, 08 Dec 2025 21:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765247435; x=1796783435;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BwpR/6Y4+20c+TPzOejofFra578liDn2l6X1QqDBzOU=;
 b=UI9x5lrSumZVbJHkEgzrfcQIfYT1gg9x0KLfqvR4Y6/63sdMpOFJUSl8
 Fu+v+aETqeJ4kUJBwXWM4e5zu4jGfRV+4LNTrdqRDt7yzzrXwfbt+DDbc
 0tYByCRGbmfotjMYijGsiEHnWb8rWzKJTqogISVGwxbq4IGoRmG9vZcUO
 D+gpQl+Ik+oBsxECgbIHDXnl/zrE8LmLzcbhHVpFpigYJtLjj4z4g9Yr3
 awVtuU/1uohx7lSkjUvIMDueXwCJhwtcUFcXU9zMOvKi76XtTCuDr7S8H
 YPr0dy1Qdecrhv9Y/QGNps7M03mMiywetGFV0CkIW8RdOjDrUXBx0n2Pt w==;
X-CSE-ConnectionGUID: ipuC/YDrRZmbbdVOeda24g==
X-CSE-MsgGUID: CBVwQqnSQGecBVtcD/F8ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="77817601"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; d="scan'208";a="77817601"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 18:30:32 -0800
X-CSE-ConnectionGUID: ICK7uH3dTpWEgu0nQlEIDw==
X-CSE-MsgGUID: 8swy3ioYTYm7ca29/YgnvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; d="scan'208";a="226761085"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 18:30:32 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 18:30:30 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 18:30:30 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 18:30:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP0cSOEAJxEmYhI9/q7d7cUTcnaMI6y992pEysBwG/Vfehl3ihzLqN45VHHBMJmn5GYQ1Uifby/O73NqHN4vbXTHJsbFPuG3CtnaQRVAz7bzhgq3D+uhwRItXuBFupcb+d3pUv5jE08OFl1NxjeDzAxAHiOoM7s61LEyfRSRUGO2a/6fsyQFMLK965pwIfS9NAhThAbZKzNsiiuZWek3CUFUulQ/q1IkM7docxRvVUtkycnnympxplsq0Umx8EnrxCbAOFyVFYfsixchWFtDnc1AgEbD0idLM8rGC8mLu2x0Vufa8nCpq3ZfiyGnE3wiJB0KJGruiw/QsE81z6NenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwpR/6Y4+20c+TPzOejofFra578liDn2l6X1QqDBzOU=;
 b=dvO7b0FAZLwFVcVCpSJdSnQshak4++QOk7WEnh6wSw7fiOSqVjmJJ9U4Gm6PdGYpg8PtVVabr+3aVceq65y3UMc7F1dLI7mfZwcWCklUhT+Ix0Cy1OfKITQZ2BiyJvUsWVbpxhdaZFlr1X35SmTyi164TlrNybsFBITfIjvPBmVtkrLwImR45ELghcYjh+nF+1VkYoWXTmCAp+P0t5QN/gfz3SluZ768OtBTuIXJIfvwcEbxmEF8oMV5E4Qj/2NVLiRZn149kAndikDZEXfEpbrKZI9zZxnXKCJJCEl6j5hKThAkv9ofKU+qZ8Z4VhuQcLvLH7D5BbMb2/FtJkXLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 02:30:27 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:30:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "Nathan
 Chen" <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHcWiDbJ8FjAQNp6EKbX4GqkmMsN7UXmGbQgAAbQACAAPaYwA==
Date: Tue, 9 Dec 2025 02:30:27 +0000
Message-ID: <IA3PR11MB9136125C3DA481215DD28B6E92A3A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <IA3PR11MB91361CCD9C11FACB77057AB092A2A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB7548A9B094B7E7CEBC1D1A58ABA2A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548A9B094B7E7CEBC1D1A58ABA2A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5128:EE_
x-ms-office365-filtering-correlation-id: a78d8457-75ba-4354-8030-08de36caea07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OUVvNnFDVzF6akd5b0VRQ0FTRGMyYjVrMVNWR0k3djhJSEhleG9JdHVDdUV1?=
 =?utf-8?B?RHZEcUtucFcrdzN2OE56TzNTTWFUREZBUnpTaVEvSmF0M2NaREFCOGJSN0hO?=
 =?utf-8?B?Z1JUclFyUE11ZkZWMkJwVDRhVHlRYWNsV1NiYkx3RmxsUGo0aERXVVIwblhO?=
 =?utf-8?B?U1ZCelNZRlNJakd3Y3A2TVZOeDVVMjNObjIxaWRVWis4eENaaHhSTnNSY2hY?=
 =?utf-8?B?bTk1MzJhUTRvam91V3E4WjY3V0RSRmlmN0lCMHRSTjNzbFJLZlJoemMzRHBK?=
 =?utf-8?B?Vmh4MitsbWVyNGJiUm5veHFpdWMxWlcrTmNyN0cxNkhEcUt5U2dpZE1UN2RP?=
 =?utf-8?B?bDRlSDhGemxFLzNMNkJvT3hUSkUwdXlKeUZybCtFRE1oWWF4UVhScVZhcjlK?=
 =?utf-8?B?V0lsREppMnBUSEVFdWk3ZGt4S1hOUjBham1tZlowYllLVXlDc3RvYlhkeFpC?=
 =?utf-8?B?dFBvYktOY05RYjVucVlWcEs4cXVwQkZQK3dPNnIvQjVlMzZ6NmM4Nm9FUStp?=
 =?utf-8?B?MVF0UWsvL1RrbENNZG1UOFdCa2dQRUhMb3doZjl2bjJ0Yk93cC9hZ1pYMFN2?=
 =?utf-8?B?WlBxc3ZHb3ppU1I3elFxaFBuVld1ZDV1ZE1nNFR1RTRBRk53dDdsVkMrRTA5?=
 =?utf-8?B?UDhoUTBGcjcwNzJRL3JMbmdCUkVqOUZ5VkJueDBQdVlzUVFNRzRsTDZDSkR4?=
 =?utf-8?B?TEE5NTV2elJXT1BHenlqa0lLVHhUajA4THdUbEVzcEc2eFQySnQ2T2ZYZEM4?=
 =?utf-8?B?QlJIQmY3Uno5Qk9PMW91bFZPRVpvVzhWSXdLc3ZKRHdlN2VzZjZJZUwzL1lk?=
 =?utf-8?B?SWJnTlZRY20rQ2JQclRuWmVZaUVTU0kxNjBRZXFyTU5oRUUveFhLMzBXbjMw?=
 =?utf-8?B?MExmeHc4Z3FzTFdEV2F6Z04wTXJBQzBha05qM0dwdXliNEZ6YTg3OHVBQXNC?=
 =?utf-8?B?c2FldDl5VVlVM0hJS0xvSkxWb1hJa01sbWlKYkhDRDluc21IRUJKeFp4YUtI?=
 =?utf-8?B?bUphTEMzRDhaZ2FQUGRtbjcrUjR4K3dNcWx0YWlkSjk0dWFUb1h3U0RWRWQ1?=
 =?utf-8?B?WFltSmh2UkVoMWE5MHZIcVFrbFJkV1BzTlpPeTZ4OTAvNERzeHIwVE5xclhB?=
 =?utf-8?B?Q0pEY09KcEtLTFMvWDFSS201amdPU2hCUmlWUnlEU2paNmErQW5nTktaVEl3?=
 =?utf-8?B?dmg4N1lnMkZmTW5COVl4d0Q3eWgwdUoyRzR6WTlRSVJxeWtFbUxlVC8xR0hF?=
 =?utf-8?B?RG03QUtvZzJickN2UUVVN2hrRFg2dTYxNzFaVHlGZVBnS1FpZDYzRnNKSGx0?=
 =?utf-8?B?aGVPaUlKQStNeWYrYVowVFl3OEJHMmFKLzh1ZllQOGV0ZlBjTzV4MGpONXdq?=
 =?utf-8?B?OEJHdndWNzNOdEJvemtnOVE3ZkJhVVBPeGYxWHprUFE5VjMweFNiN3dLWWRC?=
 =?utf-8?B?U1Y0cC9MUDN2ak9zZllpRU5NazZkc2JMd2FCSEFrYThXZGg4VDhuRUJYUTlU?=
 =?utf-8?B?RjlNT2lOTjkySzRVL2xXVTFqTzJjNlJuR3g5dDZ2elhCMENjYS9HU2VCK0gr?=
 =?utf-8?B?aEg3STJnN2I1czB0K01qbWJ0Umlib200REVNZmFxVi81TXlSWW9FWXgyWGEx?=
 =?utf-8?B?d2NPQ2Y3bWtab1F4R2ZjY3VlV0hYUmU1MCtOMXdORzByYWRpbWlncU42SHJi?=
 =?utf-8?B?Y1RMUkRFYVpwbFpEaDAyeDRjUE9KNDFiVEVCaGdya3g0WFFSNVphRDRpSGor?=
 =?utf-8?B?eEpqTUNKdUNtRFUzblEwOFJxemxvdTdCZHZZd2E3QmhyU281YllqSThqd1NL?=
 =?utf-8?B?czlFcDlyK1k3dTRHdVpBYi9uOEx0NGRWUkh2UVVlRUcrYkQ1V3dwUTNGYXQ4?=
 =?utf-8?B?dDZrRE5TSFRUVGNtKytKMVg4MWs3cUIxVSttNHBSQi9yM0ZScEkrQ255bjJj?=
 =?utf-8?B?UG1tTkRiQzZ1dXlUTXY4REk3Ykk4OThoWmloRVVpb3drQUZpV1lEdFVUeGRS?=
 =?utf-8?B?clc0UmhtVVVreUdLNGpTaDFudXpCOWRsNmpEWEEzcHhSekcrQWtydzlOcTJY?=
 =?utf-8?B?YmdQSmJVd0RId2l3ZElzb3NFbVFIVVp6NHFiUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmd1YTRqYUY2bmduMldCU1JhOFVQWFhqM1V0ZC9yY2hORHE0WkdiNlMyWDVv?=
 =?utf-8?B?QlRuNmNQRmNJRUpseGYxVW5vZWFqYzc0Z0tmeWVDSEg0LytWWlQ1cCt1eWc1?=
 =?utf-8?B?bjRhaXIzcE1tK3VySDh0N1dqU0pmclBzRG5DTy80UzNSSU1ydTBxaU44RWFN?=
 =?utf-8?B?QkhDRWxMek1WZ09nMTRSMytLUHc1TjRnQWovZEtBbEg5SmZPYzhjQUlWS0NO?=
 =?utf-8?B?Qi8rWFBoTEF4ZUhHKzVGWm5MclRyclp0K2tOMlZMM1FXdk14bDY5TW1scFdy?=
 =?utf-8?B?cU1vaTdxRmFhQTZ3K0NOOTZqeTFYUmpzcVZCeCtBY0RhSnRKcmE2aU5UZ3I1?=
 =?utf-8?B?Y2R3QzJmQVJaczlvMWJJQ0xuZjNjY3AwMU00MzRmSzBpQXFFR1ZUa254bzUr?=
 =?utf-8?B?SjJucEd1SUJmWEZQelc0ZUZaZ0JsNFMzeFBFTmVybVBTOGd0Rm9yaFBqaXVy?=
 =?utf-8?B?b3g0UGVKMEdmczFYcWJPaXdjRHp0bjlEaWt0R2NPY0ppQTQxSFc5bmpOZU43?=
 =?utf-8?B?NnlBWXNlbDJZUUQzdDV0OTBoZVViNzRkN20zYzVSdWJUSWwzckExL3VxbGk4?=
 =?utf-8?B?cEV0UlE0YXVra3dJRWV1VWlHNFhuSlJmWVVFUkI0a3lmVVBtMHhWcDlPTmVM?=
 =?utf-8?B?QytucXJmVDBYb3VTR0VzNWVtclJnNmNiSFR5NlU4S0cvME51eVE3MWJyYmhS?=
 =?utf-8?B?WUxmblFTbExScXhxUVJSQVBIalltcUhWdWZJQXpmYTk1NlNIT3JNcC9EYlJP?=
 =?utf-8?B?Q0VkMWFwQWwvdXdkZ05BeC9mS3BiSEFiWkVERzNYd0VRTGNydG5CYzhJYkM1?=
 =?utf-8?B?dFF1S2g5SlpzWFR0VWsyS2k2bnBjMHJCaGpCdkFxUllkZVNZSlViNHo2Qkwz?=
 =?utf-8?B?VGs4WWxpR0wrdXlTa2FLZTdpNjNZNTZtbHVrU0grZzB6S3d2eHZ2anlSaWZn?=
 =?utf-8?B?ZGR3ZkhRU29XSW9XbzJNd0tVL1UrQll1WEhzM2hYYW04aURtemxxdTJEa2Vp?=
 =?utf-8?B?Ym9DK3JnQUlsV0hrT0ptVXpGbmZ1VG10WTMvUXVxQUdwMDNjWXg5UVVRWlpI?=
 =?utf-8?B?RDBnZkdIdFFnTDdHU1ZhNEZpbENUaDYydDE1bmFlUGkwVW1TcjdqMFFFRHk1?=
 =?utf-8?B?RWF4ODNNRit0T1N2aFRwdWdMNjdianBsVGZUUDZuRW9QaEdGdGpqMGFaWHJt?=
 =?utf-8?B?R05lTVBrUnowVGthZ0xJbzl2bDFvMkRmNCtsSXRSL29yQVdWaFJuanBoR1Q3?=
 =?utf-8?B?RjVCM3NqL1EwT2Nsb0R3a2RUV0R0WDFmMTJsU3hnU1RYbWU0UnBFU2hkR09S?=
 =?utf-8?B?Z2tPUndkdmZNVVFPVDJDb2Jpd3luNlp2SEVLdGlxMkxGTlVPMGVsNHlQSk5F?=
 =?utf-8?B?U3BNU0NuQVhlaGZVa2prVStJOGticngxN3Z6dVlxU0tROW9WaENPVnI5YTlo?=
 =?utf-8?B?UTBWd0tlWi9UdlJLOXJQb1p1TlBaRENuZ2U1Nm5MTVlvZGdmUzBRODh1d2Va?=
 =?utf-8?B?QkVZUVJSelF1SmRMczluL2RialNGWkZNV3pQZkNiZ202a0lqTFZDNE9zZ1ZG?=
 =?utf-8?B?cWRsQVQ4TUhIUW94RVpLZUVEeWxZSm5LWm9PUXNxeStxN3NnOEhLdWxGMzlV?=
 =?utf-8?B?ZVdrUXRaTmRtRXZYTG5mbk1pc0piamF5WGh2OUF4L1ExUk9mWVhaSzRhVmcx?=
 =?utf-8?B?WkhkN3NPVW1RV1B3TTIyME1RU042eFMyWmY2Wi84MThadCtaYVhwa3BLOW1E?=
 =?utf-8?B?VitscFB6L2d0M3RsZEpVOXZTR3FFcHovTExZTmRrZldKUVJmM2FSL1B2Vm54?=
 =?utf-8?B?MVJSdkNWS0p0VndIa0VzWjFOa0VZWk9kWU5OanpCajN2VHhjV3VoamlZRTV6?=
 =?utf-8?B?bWpXT3p0SlRRaHpid2JYakNaZHhYR1o2bjJzQWNKdkMzMXhXZFJGOEhERXlr?=
 =?utf-8?B?WGZVUmZ5YnZ6VUY1V1lLQUYzNWFEbFhwdkFrR2hJbXhueUxpcGRmSDdhYmMv?=
 =?utf-8?B?Q3J2ZmNEYmk3bVdTVGtZb051bTBIaHVXYitiUm0vU28zYkhEc2hqSjNqSlVY?=
 =?utf-8?B?T3Bld3diR1ZjZUt5eXNrOHppaEg4Z2hZL0diOXZxU3l6d1FVS2h6S3A5YzNj?=
 =?utf-8?Q?fm99GQTgvOx8ayh7C3Fu0Ga/Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78d8457-75ba-4354-8030-08de36caea07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 02:30:27.0259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LM9OESbANTMrRhJx1qi6avcU99Yf5i6Bp044kkQ+zNsHSu725EtJVPM9OZ3tUsZoSUDUG38uO60DWAF1JIwkIt2z8wvhjgeQU//Ytc7zvUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoYW1lZXIgS29sb3RodW0g
PHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPlN1YmplY3Q6IFJFOiBbUEFUQ0ggdjYgMDAvMzNd
IGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNlci1jcmVhdGFibGUNCj5hY2NlbGVyYXRl
ZCBTTU1VdjMNCj4NCj4NCj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9t
OiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFNlbnQ6IDA4
IERlY2VtYmVyIDIwMjUgMTA6MDgNCj4+IFRvOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10
aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+PiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25n
bnUub3JnDQo+PiBDYzogZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc7IEphc29uIEd1bnRob3JwZQ0KPj4gPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVu
IDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj5kZHV0aWxlQHJlZGhhdC5jb207DQo+PiBiZXJyYW5n
ZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hz
DQo+PiA8bW9jaHNAbnZpZGlhLmNvbT47IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBo
aXNpbGljb24uY29tOw0KPj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJv
bkBodWF3ZWkuY29tOw0KPj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IExpdSwgWWkgTCA8eWku
bC5saXVAaW50ZWwuY29tPjsgS3Jpc2huYWthbnQgSmFqdQ0KPj4gPGtqYWp1QG52aWRpYS5jb20+
DQo+PiBTdWJqZWN0OiBSRTogW1BBVENIIHY2IDAwLzMzXSBody9hcm0vdmlydDogQWRkIHN1cHBv
cnQgZm9yIHVzZXItY3JlYXRhYmxlDQo+PiBhY2NlbGVyYXRlZCBTTU1VdjMNCj4+DQo+PiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPj4N
Cj4+DQo+PiBIaSBTaGFtZWVyLA0KPj4NCj4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
Pj4gPkZyb206IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPj4g
PlN1YmplY3Q6IFtQQVRDSCB2NiAwMC8zM10gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1
c2VyLWNyZWF0YWJsZQ0KPj4gPmFjY2VsZXJhdGVkIFNNTVV2Mw0KPj4gPg0KPj4gPkhpLA0KPj4g
Pg0KPj4gPkNoYW5nZXMgZnJvbSB2NToNCj4+ID4NCj4+ID5odHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjUxMDMxMTA1MDA1LjI0NjE4LTEtDQo+PiBza29sb3RodW10aG8NCj4+
ID5AbnZpZGlhLmNvbS8NCj4+ID4NCj4+ID4gLSBBZGRyZXNzZWQgZmVlZGJhY2sgZnJvbSB2NSBh
bmQgcGlja2VkIHVwIFItYnkgdGFncy4gVGhhbmtzIHRvIGFsbCENCj4+ID4gLSBUaGUgcHJldmlv
dXNseSBzcGxpdCBvdXQgX0RTTSBmaXggbWluaS1zZXJpZXMgaXMgbm93IGFjY2VwdGVkIFswXS4N
Cj4+ID4gLSBJbXByb3ZlZCBkb2N1bWVudGF0aW9uIGFib3V0IHRoZSByYXRpb25hbGUgYmVoaW5k
IHRoZSBkZXNpZ24gY2hvaWNlDQo+b2YNCj4+ID4gICByZXR1cm5pbmcgYW4gYWRkcmVzcyBzcGFj
ZSBhbGlhc2VkIHRvIHRoZSBzeXN0ZW0gYWRkcmVzcyBzcGFjZSBmb3INCj4+ID4gICB2ZmlvLXBj
aSBlbmRwb2ludCBkZXZpY2VzIChwYXRjaCAjMTApLg0KPj4gPiAtIEFkZGVkIGVycm9yIHByb3Bh
Z2F0aW9uIHN1cHBvcnQgZm9yIHNtbXV2M19jbWRxX2NvbnN1bWUoKSAocGF0Y2gNCj4+ID4jMTMp
Lg0KPj4gPiAtIFVwZGF0ZWQgdlNURSBiYXNlZCBIV1BUIGluc3RhbGxhdGlvbiB0byBjaGVjayB0
aGUgU01NVSBlbmFibGVkIGNhc2UNCj4+ID4gICAocGF0Y2ggIzE0KS4NCj4+ID4gLSBJbnRyb2R1
Y2VkIGFuIG9wdGlvbmFsIGNhbGxiYWNrIHRvIFBDSUlPTU1VT3BzIHRvIHJldHJpZXZlIHRoZSBN
U0kNCj4+ID4gICBkb29yYmVsbCBHUEEgZGlyZWN0bHksIGFsbG93aW5nIHVzIHRvIGF2b2lkIHVu
c2FmZSBwYWdlIHRhYmxlIHdhbGtzIGZvcg0KPj4gPiAgIE1TSSB0cmFuc2xhdGlvbiBpbiBhY2Nl
bGVyYXRlZCBTTU1VdjMgY2FzZXMgKHBhdGNoICMxNikuDQo+PiA+IC0gR0JQQS1iYXNlZCB2U1RF
IHVwZGF0ZSBkZXBlbmRzIG9uIE5pY29saW4ncyBrZXJuZWwgcGF0Y2ggWzFdLg0KPj4gPiAtIFZG
SU8vSU9NTVVGRCBoYXMgZGVwZW5kZW5jeSBvbiBaaGVuemhvbmcncyBwYXRjaGVzOiA0LzUvOCBm
cm9tDQo+dGhlDQo+PiA+ICAgcGFzcy10aHJvdWdoIHN1cHBvcnQgc2VyaWVzIFsyXS4NCj4+ID4N
Cj4+ID5QQVRDSCBvcmdhbml6YXRpb246DQo+PiA+IDHigJMyNjogRW5hYmxlcyBhY2NlbGVyYXRl
ZCBTTU1VdjMgd2l0aCBmZWF0dXJlcyBiYXNlZCBvbiBkZWZhdWx0IFFFTVUNCj4+ID5TTU1VdjMs
DQo+PiA+ICAgICAgIGluY2x1ZGluZyBJT1JUIFJNUiBiYXNlZCBNU0kgc3VwcG9ydC4NCj4+ID4g
MjfigJMyOTogQWRkcyBvcHRpb25zIGZvciBzcGVjaWZ5aW5nIFJJTCwgQVRTLCBhbmQgT0FTIGZl
YXR1cmVzLg0KPj4gPiAzMOKAkzMzOiBBZGRzIFBBU0lEIHN1cHBvcnQsIGluY2x1ZGluZyBWRklP
IGNoYW5nZXMuDQo+PiA+DQo+PiA+VGVzdHM6DQo+PiA+UGVyZm9ybWVkIGJhc2ljIHNhbml0eSB0
ZXN0cyBvbiBhbiBOVklESUEgR1JBQ0UgcGxhdGZvcm0gd2l0aCBHUFUNCj4+ID5kZXZpY2UgYXNz
aWdubWVudHMuIEEgQ1VEQSB0ZXN0IGFwcGxpY2F0aW9uIHdhcyB1c2VkIHRvIHZlcmlmeSB0aGUg
U1ZBDQo+dXNlDQo+PiBjYXNlLg0KPj4gPkZ1cnRoZXIgdGVzdHMgYXJlIGFsd2F5cyB3ZWxjb21l
Lg0KPj4NCj4+IEkgc2VlIFBBU0lEIGNhcGFiaWxpdHkgaXMgZXhwb3NlZCB0byBndWVzdCBidXQg
bm8gcGFzaWQgYXR0YWNobWVudCBpbiB0aGlzDQo+PiBzZXJpZXMuDQo+PiBXYXMgdGhlIG5lc3Rl
ZCBod3B0IGF0dGFjaGVkIHRvIFNJRCBpbnN0ZWFkIG9mIHBhc2lkPw0KPg0KPkluIEFSTSB3b3Js
ZCB0aGVyZSBpcyBubyBzcGVjaWZpYyBQQVNJRCBhdHRhY2htZW50LiBBUk0gdXNlcyBhIENvbnRl
eHQNCj5EZXNjcmlwdG9yIChDRCkgdGFibGUgaW5kZXhlZCBieSBQQVNJRChzdWJzdHJlYW0gaW4g
QVJNKSB3aGljaCBpcyBvd25lZCBieQ0KPkd1ZXN0LiBIZW5jZSwgbm8gc3BlY2lmaWMgUEFTSUQg
YXR0YWNoIGhhbmRsaW5nIGlzIHJlcXVpcmVkIGluIFFFTVUuDQoNCkkganVzdCByZWFsaXplZCBh
IG5lc3RlZCBod3B0IGluIEFSTSBpcyDigJxzdGFnZTIgaHdwdCArIGd1ZXN0IENEIHRhYmxl4oCd
IHJhdGhlciB0aGFuDQrigJxzdGFnZTIgaHdwdCArIGEgZ3Vlc3QgczEgaHdwdOKAnS4gV2hlbiBj
cmVhdGluZyBuZXN0ZWQgaHdwdCwgZ3Vlc3QgUzFDb250ZXh0UHRyDQppcyBwYXNzZWQgdG8gaG9z
dCByYXRoZXIgdGhhbiBhIHN0YWdlMSBUVEIuIERvIEkgdW5kZXJzdGFuZCByaWdodD8NCg0KPg0K
PkhvdyB3YXMgcGFnZSBmYXVsdA0KPj4gaGFuZGxlZCBpbiBzdGFnZTE/DQo+DQo+SWYgeW91IG1l
YW50IFBSSSBDQVAgdGhhdCBpcyBub3Qgc3VwcG9ydGVkIHlldC4NCj4NCj5Ib3dldmVyLCBaaGFu
Z2ZlaSBpcyBtYWludGFpbmluZyBhIGJyYW5jaCB0byBhZGQgc3VwcG9ydCBmb3IgZGV2aWNlcyB0
aGF0DQo+c3VwcG9ydHMNCj5TTU1VdjMgU1RBTEwgZmVhdHVyZSBhbmQgaGFuZGxlcyBTMSBwYWdl
IGZhdWx0Lg0KPmh0dHBzOi8vZ2l0aHViLmNvbS9MaW5hcm8vcWVtdS9jb21taXRzL21hc3Rlci1z
bW11djMtYWNjZWwtdjYvDQoNClRoYW5rcyBmb3Igc2hhcmluZy4NCg0KQlJzLA0KWmhlbnpob25n
DQo=

