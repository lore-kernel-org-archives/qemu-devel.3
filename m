Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B504CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHZp-0007JZ-3u; Fri, 08 May 2026 05:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHZl-0007JG-1O
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:32:54 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHZj-0002BX-6s
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778232771; x=1809768771;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J7EVdt6x2O6blgldDtl7A5Z0FbVnrZosKBYIx566HfA=;
 b=brsEhqYQxJveeAeGO80gMjGL0lwJGRP643DVcYy9P1p6XYC3OFwEnh4n
 FioEEjrRpo5YaVVyp7Mk02s+k4u65U9DNanjphbCW8lsJXZaGUHX/0Tbx
 zl0O69qdvN38hxrVoGFIGyRs5rO53WlWG3YkS2A5KPBfS4BBPVZz2V32b
 L4rAX4yBZ93PG+VhLMwSRPrIMNnk8gSgjl7vK8cTUKvZ8lvbJ5NPcMRZk
 u/uoZPiW4MBQDlCMoH27VKQJ82MyCQvOyKjeGRbcJQT+R0f9rDJGcwF+M
 Fw66UI/w1MRflIhYC8POqGbfjO/zyogp4Z0mJFreWQ8TrXlIuALVUOq70 g==;
X-CSE-ConnectionGUID: SGkgK5PYQy2ayUsH78MpnA==
X-CSE-MsgGUID: GAWjQ6WdS9OQQa3HeQx5lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="81763424"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="81763424"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:32:49 -0700
X-CSE-ConnectionGUID: USis8f/TSYybOmatrNl1Pw==
X-CSE-MsgGUID: vH+/ljn+QFOkqXqY8H+3ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="233664234"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:32:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:32:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:32:47 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMomF9sqJglfeTYTmPv0A+bbHNEegrN9v4GsaRmDEkLFYzM/6cppmbsvYmwidnCqjWlpInyorORQ7AwwAW0SJJswMKv9D4J81807dRlHLBM8qipFN5G3vjD5hKPiDMrcCD0JlIhAZhaiWKKDxvdoBTePI0/+wbSHe27d81f4zC7wC34GF+bH/hsrs4bUotRP8OeMBzUp0N6QIbQ3oBKnRnp0IQOvdjGq3x1Uf5C/ZZcpEeJhquxUVWrTdmlthV/Th4zAKJXRICjvehzzWhXnP5BLUoLGxInfsAci17ijpFLe8FOR5+goOAjwLLlfa7JQnQsST2pgtrRO/lyZ8qlebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAFmStyxmob8cE3qmevszjmAwGBm3hZ3dT5Ze+5zV3A=;
 b=AJqp/XfY6v6T9XGuWY7XTV5Jz0ZAD/BV6sVMn1q2uI8gMLg0K+JOJtQUEM5M8Ae8/EeUscILEAJuNosutmFOzzsQdR7TZ18LefHFz0DxUSaKu0V0k8r01zx4nl7L41xHhY5P3aoHjrTYoBZJxYEaHdIbCwcQRk71nv+VCEQ8bP08RfK++Yt5/jMTQqURb6gzTGx5iuvreyJyw/wCm6CPwKXNKasGm7pGWn6arFs82MNuatfM3uoCO+yKecO77ndfL3ati1ZeApkxlarsy/2vOs308wS70oPH6PJ9vI6L9Urpbr918lsjkHLdu407OdxBQAyAiMZRQT0NCj+DW3gJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 09:32:43 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 09:32:43 +0000
Message-ID: <867b3d31-c1f0-44e2-89f4-fa5f46963829@intel.com>
Date: Fri, 8 May 2026 17:40:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-9-zhenzhong.duan@intel.com>
 <66b8667d439df5f17a760870eaa7ddd56cea786f.camel@bull.com>
 <IA3PR11MB9136A83356C363CE12E16E07923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136A83356C363CE12E16E07923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 69776779-9295-48e3-e7d7-08deace4c177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XL5ghCdVWWAcqkAZBVsf80fm8EZQBlflClLXeTTk/aj/V+Etavoh5PHNLKwQ1pkqX3KovrYZGzPQew7XJL12uP/kiNg5oMviRQ1WggBQm03mtks8m/Cet2ntvQqIowCTfv7GizgUoEKBObQRAXseGjJ136hZo+CjqacVW79mYZlcgFF0z1Mc9ECu8U0YCKuOY/Ztu8Bv5gfLoJvIvMgcuenT92i1lfpnnbZHOhLSnPtZUqQv8ve7kf+WRRuwnb66lDjVbndg3dWXN5MzeJ1aF4m5xrQKkXezHU4yfpdGkZRosOVdg1jmq+c320tN8PjHesx6Yve/liF4BY4GtvF0JBYoTBKX+uHWdidbpsLPd5WjXwqyHwezYWeYZHg3B4j/8qV0EAXA+FKsdzhog5YgynVdc+PQA0RijA9nahI4GiUpB3RK7JrrXkYfFDd/dtZTTIebnfIKTwdJdeEVauFN4l9EtZsb5B2oR2mYmToeu+P3yTMQVJvJjpKM6HTH+vWjZO8nK/fK8OqkCmy+bvehiKxqOJdXJmXWZQ777YDNeVDVuMbKuP7Bx6+xnX9kXZZD3XJGuDujWt+ofN065eHdGFL2dymSVQ9lgBm7LKgb+UmjlBWFyzcjHgJCjccs6TyUbQy7fvfv8j81FtSFSDHUfawDDT6XKC8YBIKd9zRi2y0otLFqtMfQYQlB4vnqY8qD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFY1Uk1uejhKTzdJZWQ1RWNMTmt6a2x3TEJmSVEwMzBwTkNtZ2s1TFE1cndn?=
 =?utf-8?B?UkVXQkV3VmttSklaZGN4WG1pOFRoUnMvQ1JPcGZjWWxJVlhaU0twR0hIRFZu?=
 =?utf-8?B?MEhOeUJZc1o1N1dqNC95MmkxbmppU0RGdFpmaFJvWXhiVEY1MHd1UFBLQmtL?=
 =?utf-8?B?UzQxZTUwbWpud0gxNGRqV1c4SVZWQ3JncWVpd0tFdGZoMHUzWS9XQjZrNy80?=
 =?utf-8?B?NGFsNUhpYm0rVlVpdXhkVVZLR2JMY3hhUzE0aGZyeDZjSjkvT21jSUNkUUoy?=
 =?utf-8?B?bDVzSVJaZjRlODFtemYwVjZFTTVQakxvekFjajloNGhGck4zeVdGUC9LWWVn?=
 =?utf-8?B?clpWa0tFamlrS3VuV1ovcW5neFJDeFNGNjBBTTN6czRXYmN4a3Iya2Q3ZjdY?=
 =?utf-8?B?cks0KzFsN0JPbW9GUEluVW81S2krV01sQ3V3em9ZWS9xSGNQMitldHhyaDRF?=
 =?utf-8?B?VHBiK3FrMm90UGc0eU1CT1VHUnZrTTFVRG85cHRxc2E1SzNjSXNjbmtJKzhy?=
 =?utf-8?B?UVJoWi9FQ1RaL1plemNUQjRyY0hqWGNwRThNVTFHRjR2SW80Nm5hajJPUHlu?=
 =?utf-8?B?ckRwVFRxa2F6QjFxVkhzS1ZrWmdYb0NhNy84NkIxeWsveTJtQysrMnBjcEMx?=
 =?utf-8?B?bVl4N1lOaFNTKzNsWDI0M2JwMXdyRGJ3MDBLQjJDaEp3cE5lL2pOYnpTaXU1?=
 =?utf-8?B?ZGQ0ZmN0WkEwZzk4bXlYdlNTK2k4dXRTZUpaYlRzSjZQUmlRTkJNeHJTNFBE?=
 =?utf-8?B?NnBESTB2bFF0UHNXdWhQN0krZEh2eHNsR09Ma2JOVWVZeUU4UG9Wck5HTWRv?=
 =?utf-8?B?Mms0cXZGZ09OaXh1RXZKT0dtaWpBWHJrRGlKU1FLZnQ4SWREeXhSS3pWUEdq?=
 =?utf-8?B?NmdkY0J1T0FoOGs0cHlSQUJTYmc1ckNkNjEzYjFzOXlseEQ0TGYrNkR0MlBz?=
 =?utf-8?B?WVVTN0pYZ3BmR1ZVZjNNaWtsUXZjOGwxVnVlWEUyQ2hIYlVXc0MyTDJELzJL?=
 =?utf-8?B?b0d0cStaeHhHcytrVXFJNXlwWUp1VUlRNERNSE5aK0FHWTNQV2Z0ZHY2WWhY?=
 =?utf-8?B?Zi9DL3ZpcHU4Vys1ZVBWbVRHMHN4Sk56NG0wTER2M2gzdWtLb01UZFEzUjQy?=
 =?utf-8?B?b2p0ZUlhU2lpRUFVL05Ja0JXdUZmRkR5bFJPaU15VmVITjB5YmU1Tlhma0FL?=
 =?utf-8?B?U3dMTHI4L0VHalowaGV6M2ZRLzVidEVBMGlzZjV0QUpCWkx0dnc5SlMzSVg4?=
 =?utf-8?B?UWRVR05xMGE2S2ZhSngwMEo2ZWRtMVdabUo2cnNzZFNqOTZGZXpJMWgvNGQw?=
 =?utf-8?B?SHU1cHVRMDQ5NVdWOWxNMGZlWGdyQ2E1VDM2N1hON2xNYldJeDRMN1FxZjAy?=
 =?utf-8?B?RVlXUU16U2hBeWNzWkdHdGRycjJCQXFkNDJ1TXcrWGRUTjJNbXFycWp4ZHlx?=
 =?utf-8?B?c0swZ1hqZzR4UldjQzJINHFIMkQzS3BBQXJ1UGhrRlI4dW5hSzVUelJUaDlT?=
 =?utf-8?B?ZUZvTnp4S1FxYWxiTkhoOGhHU29uMk16ODkzWFdkOFh6RkxmSHcvNWpianlt?=
 =?utf-8?B?b2xjMTM1SEhCV2Z2M2s3WEkrK2U3V1BJVTh4VzIyTHYzajZldzJZUnppeWlh?=
 =?utf-8?B?R3l0aUdsNVJQRUdmb3FHSEpxcXFkb3NseXNMYmpTUE5kTXB2S3ptakdkY3lC?=
 =?utf-8?B?NmhCYVhwcFRsQk96bTlSUGd0UHdIa3A3VUFyWWR1c21sUHdUN0RsaGRwN29P?=
 =?utf-8?B?eGducDNCckxyYTNiY002cjRSRjk2UW5IU0ViNGsxbDZCTGg4UTJreS80R3Az?=
 =?utf-8?B?dzVMb3R6NFhtVHpFbzlUeTJ3R3d2Ly8xbGZBb0pXWWlHbUkxTXpHWEFUUXpZ?=
 =?utf-8?B?eGszNlNyTmVtYkc3b2ZwYVU2bWZWYms5TkZWeE5zT1lrRUl4bkhQSlhOYytL?=
 =?utf-8?B?bnordytzemdEU25xQ2pUZ1VKaHdrbVkzV05qL3l6WjZmeXVxT09GbUJJUmZn?=
 =?utf-8?B?MHRDQ0hBL3pQZXpaUkNTczRNSWduNWJyRDBOc0cxYnM3NkIxS2JpdnY2REVW?=
 =?utf-8?B?NVdjSXJtTHQ1WmZuYlNyUVN2dVN1VVpSMnQrUXoyWFdjcyswN1BlbS9HQXZY?=
 =?utf-8?B?eDJsNXFBY0kwMk1GWWxDZm13S0p6b0ZTdUxqTjdSWm5lczNRRkRIZ1RtWkFk?=
 =?utf-8?B?V1ZPeVZiMUthcjIxTmF5OGQ2eHg3ZUJRN3c4NUJwVWJLeEF1U3ZjVnN6Mmln?=
 =?utf-8?B?U3FYc0pSQjhnakx4ZlNGU1FyVjBUSEltalArNk5VMXBnTkUxMVY3T0dlUVNW?=
 =?utf-8?B?M3hMVDhxQUsvbkl6azRPQ09hdmZVMlpCR2d4bWw3YzFpUytCK3h5QT09?=
X-Exchange-RoutingPolicyChecked: QqYQAZSoGO5wQB8gv4eDC6wv142LDVDpHMZWpfs48HzCDDSsCYrwiRfcC0V3cIprsJseSGmwIkQi1zF8sg4d/UHCe2BmvGeAlX+izbAXPz9dpiDS6J8N8+OMtoMWa2uAsm4iD/p/LNoNrYX32hZYz72s1ERXWmJgYJTZUMc8NFv9959uYc0hsfTLLUxaW/qSaBK+PRjixbqylfieDTRTeluNAwy1M/yNUjx385/ePiCaaQbwOazQOGU/tqNk0eIQBu0HsTwZ0Hw4bVMA15L532V6AZbt8vXnZXHsAttJjjiEMXOX1BnfpchGu9fyBDdKktzdPlkfH0wdTghdhN+24w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69776779-9295-48e3-e7d7-08deace4c177
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:32:43.5223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ0erDs2YsR4qitfwIbkrafHQ5x5uyTVniMaz+ORbCMxoQGJTgYmfJlugmw6akvrKNShcQJuOjtBI7BKzFqF/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5/8/26 17:25, Duan, Zhenzhong wrote:
> Hi Clement,
> 
> https://github.com/yiliu1765/qemu/commit/9f71129bd215cdb5c416e3c7abb7c282fdb7c006 should be able to address your concern about below two code pieces.
> 
> Basic test passed, the whole branch https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_pasid.v5.wip/

this is good. The conversion is really confusing. Remember to add 
comment in the place of converting vtd_pasid back to pci_pasid. I
think this change may touch the following patches of this series,
so, I may stop reviewing here and wait for your new version. :)

Regards,
Yi Liu

