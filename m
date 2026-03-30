Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B301FF4954
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 06:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w76aS-0005ad-SR; Mon, 30 Mar 2026 02:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w76aQ-0005Zr-IL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:58:58 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w76aM-0003cs-M7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774853935; x=1806389935;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CEQz1LLSiLmq/6nQc9bgZ7RZIJzCF7JQdD8bLrfVcCA=;
 b=DatAYxuyzRrzmVFDIhuahQKK/ahbQqIRDV2mGWH1xztxlBkIV6Gip1ZC
 EHfbn4BvlmUOGbvqNKBqrjEQ6Qeqq1qZyM8UBWLpujwJ04ZcJAnhu5vQi
 9uQyWHpURHtbIY0GMl5aLNOvpSzShvP1EKdpYZQJH795INePTn2U6gbCl
 Rgp/cKNGxVZEjjlQxopd/H2YiD+PByB4hHL7AEo9ykEwOBb3XStkpIHSU
 FJyKRpmKL7iftCP64Tdk8Ltq2mUhjOuubzx1RPaAP+Tht0G8aEfxFHBSe
 Q1OBU6jC6BoQZ/gscGwqcSzpPPQkP5LKhO69pfhNWfPrORwPmXX1LnRZX A==;
X-CSE-ConnectionGUID: oHuiaHTzTf6L/S0dhgySRA==
X-CSE-MsgGUID: ajmxVuwMSHyEz8tsh3Q9Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75549347"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="75549347"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:58:37 -0700
X-CSE-ConnectionGUID: gWDVFNBYRWCap+V3pq8XUA==
X-CSE-MsgGUID: hSr/y/PYSmST7vUfc9HHjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="219324274"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:58:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:58:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 23:58:36 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N85IAgb6Ss+gD5kBQ48546pXYJG1nue8kb8p3JSz1kykJidz6isHrP3ySF7SMmLXDHqajdzBXD7hrYNM/wR8rYI3XpwO2I0RP5vtGa8otBV24ZXhtmpegOE1v8H8JGuequhsGrTWVxcC67UakpqlW7iKoX/c8ClHeDNXDIx8BIumvo2iaUNjp5wyQgXxhMdKQDb/+n2eGMRnFT38ojjRzHP5wLnWvDgGvPCBhhp3mDz1ySEcWNCetFq3Ixx6F2OCB7L6m0Kh7ggJV1EM4lUA39DIhsOKHRZzwXQkQJxESWXjR4VN9TNp5oS2q1ES1+YFjO6CNDEyYxEf6slO3RP8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEQz1LLSiLmq/6nQc9bgZ7RZIJzCF7JQdD8bLrfVcCA=;
 b=EImkc5UeIFoxubBVH8JkcAR72/KCxKBYEhOBR1E0o/bBDD7NuIz1euF/v0jirSwkEe7RWYyXloaPJiY0P8HJ1yNsblSY0B0koYqTxjBJgBSxHiPYA0wmg1COkt61Wk4pHhVLkmWNkJ1n9TeSFTuqfIheGhaMbtWYh1AnaOOcuKtBpdNwIsgJokDvYDhXLJTt0xLBwf5yqpI20SBIWKpYZn9Sfw1urZ1NEgUxprLf3InLNepo2Vvf4tTf99b7bXvibKZEr1fY5G++EfglHS4OcLaV2RgXmY3HX+CHx6YMYVzlAHbBK7cq0VqxZ9lTFJck5lXWcFB77qf0fe9JE/A+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 06:58:31 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Mon, 30 Mar 2026
 06:58:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v2 08/14] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
Thread-Topic: [PATCH v2 08/14] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
Thread-Index: AQHcvQCoC6l9yHv4F0eqZM7WHm0EQLXBywUAgATf2EA=
Date: Mon, 30 Mar 2026 06:58:30 +0000
Message-ID: <IA3PR11MB91364D7A9ABCC169946E100B9252A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-9-zhenzhong.duan@intel.com>
 <b133ead4-d871-4037-af7a-e7b534e20954@intel.com>
In-Reply-To: <b133ead4-d871-4037-af7a-e7b534e20954@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7558:EE_
x-ms-office365-filtering-correlation-id: 2d655b6b-93ba-4175-2701-08de8e29c079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003|3613699012;
x-microsoft-antispam-message-info: stXNKsUPPiLnZJAzvtkQjwiLl+EyDnL5bWVEYiJfVmuqdRhGtuZZlt4CDCaddNjCOsigPoykMtGyt9nUeERUugkitdmhjiNTVKt+80q7ZtLvkRzzImeL3TJwkpqRXAuBnOgW3gPqnGKrhz1WU1xJch4ONyXdy363amKfMrH8co7osSSEUkshtvdUmWRC6492gX0CqrlTvhKddh7pBydVAZbgcuO/HL6+vOtxGYJnKpF9U6mLuVR87XKUFt43sf0BGewhSxmnolbYgXg73OBHVweWb/PYmGbgF8R4DooxgGwjovvM9o68xKEL924WB5T/j+wGP34JnMpORh6vmvl8chOehlUQeJ8sm2fOkfvG23M6OsAqd8KeA0qo6kTke8x8xcPYu8a0/fWG8PjdXsfNBJ/vyABTPaiDbMKxV39e217yLt0k+T0mYAeneruCaLyfDIrfgzsjLNtkrcAriLOZRhFPNXJuCKtZfE8uOjaYQeJpYglc86g2lqu+6AXpW3tqbsjeu4kP9Caf86riHFxJjiDu4eT+t0WLx1ZOM9X0qmUfftzO+quCGgVn15jf1yV5OEQHQ+30jbPCr7BlGB/L5Qz/+m2wlTzr6HaVukzzLnE8imkdA6slxhPZYtf66mDDLcCL7LLk7otnhF+N7rPQkTj6oXbGfYkg9Pcl7/HxgpRaTgsCo011SVyzO0j5oK8IDeouhOR1Uno3yMTuHgOjavamzOj2qdof/r+9Tse+sXFCe2tPDhcBzQCg659Ml8tDd5ZTD3D4VQdGFU+Gh67gZ4uZvVSInZg1VXe3c8eTYByo1rwgsTZGsatRB5riVH9c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(3613699012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEFseFdKV2FuMXM5R1c4Y3NCUEFwVTJ4SGg5Q1VGcm9RY01vYmlmRVlHcVdm?=
 =?utf-8?B?SVQ3QUFvNVZOQmFNWDdDRGNpak1rQktDYityd3ZVY1NQTXdoL3hUeUdvZUk4?=
 =?utf-8?B?Q2FqN3h1dGdybmZTU2V0aWVCTEJhM1BuK21IbXFLdWxzKzFDNjU4VmxrcWFP?=
 =?utf-8?B?TjJ1VGhhUVFnZC9QSzhkRDRkU2ZUNkh5TklNZGZMblVobXg4R3l3ZzNwMmpu?=
 =?utf-8?B?RDNZMWNVREV1c01rV0s1Wlg1RlBtdVNXN1FieWd5ZlZHWGZtcnlpcVRTbVpN?=
 =?utf-8?B?cEYwR01lSUhiU3Z5bHcvSFdaTWYwTmxzNHJURVJ3T0hQMlIzRU1hc3NzaCtF?=
 =?utf-8?B?S0ZwSzlyaG9hSFRRZmJvNkNPT29HQXlVOHdVQzhvdEpaY2ZPYjA0ZDJka2JG?=
 =?utf-8?B?ZG9JcEZ5WkN1aE5CSm01U0laWHppUnZubjdkUE9KUUxQYlJNdHpmSTgrSENJ?=
 =?utf-8?B?ZHlsVVJLUytyZ2ViNkdpVUZKTGw4T1lXdWRydUVVUE54QkNhb0pVdjFNYVBz?=
 =?utf-8?B?WlJIS3BqVnFaRmxabmIwV1Nsc0lad2U1UWlkS25qYVNmT3NIaE04Qkc5NG8w?=
 =?utf-8?B?WG5kU1RIMnhwOEpWYm43ajhBUDNpMWVMSklRZWxZMW92eWpqQ1ZwT0ljYzgy?=
 =?utf-8?B?Y2dITXViSFdFa2YweENFWjBrekErMitGaGJwOVFGOWt4ZnRCR0M3UWVrelhL?=
 =?utf-8?B?OXUzbHh3UnR3RDVSYXllTGEyY0JJdjE0eVFOU2pkTXVwWXZtWmFtZHUzdkZU?=
 =?utf-8?B?WWdjSjVIZkRONkFJcUdQTnR0KzhJK3d3RjRyS3NyMWMvc1NvUzVqYmoyOTR2?=
 =?utf-8?B?RFlIUHhwbmJjN1MvVytUWE4zTkVLRytLdUV5M0RsSDIxcnpiQ1ZwOCsxdEtN?=
 =?utf-8?B?VklURENDQ25aOXFleElXNXduenN3bGRwcmE0WTZKTkp4bkNGcjFGVkJ1V1FT?=
 =?utf-8?B?c2tuQ2w0eVJKaTlxVjZsWVdoZWJIS3ZIaCtTY2pMblk0RjdObzhnRGd4NUhz?=
 =?utf-8?B?Y0E4NzlvRFgrL3dLYlYxUFlzbUhDSFp2VUNyd0ljRGRCVEVYbHZMdm9oc2RT?=
 =?utf-8?B?UXlqR3hwQkpJelk4dUoxRkh3Uml2TG04d3h3dnRycitPL08zNW1lY2NndUpx?=
 =?utf-8?B?eHJtY2xsNml1MExsbGI1cWlBellBYzVIQlFHNFIwL2JEUDJlb3ZscHFBZ3Iw?=
 =?utf-8?B?aWFwUms5c0JtR3Y1enNvUmQ0T0djaWpDTzdwY3RDeDVjR0l4SHlNSGJmeEpK?=
 =?utf-8?B?cVVJNTZVSGZrbExZKzVXWEFhOWYrSFNxQ29RZDZBbW1scVNlZFBiTU1URUdJ?=
 =?utf-8?B?VW5IRUFNTXN3Nm9INEpVa1FNaU1wYkhqZ1orU1BQS3ZQanpTQzhqaWh1bWFu?=
 =?utf-8?B?YkRzeVBJMzRLUDJVNmkyV09sQkYycXFHc3czUnFSb0xtU01zanlUK1o0N0NV?=
 =?utf-8?B?N3lOcUJSU0lINVFrb2x6MGNjejVnaUh3bXhWNkZLM3ZTckRZdDFtNDJIWHFJ?=
 =?utf-8?B?UDJ1N3RkLzVVcEQ4SXI3Nms5aWkxTTRBU3gyZzhzOTBoTnJUN2JySnJNU3pU?=
 =?utf-8?B?T1c2cEJNTEM3MUY4Tk5xUTNNSUNVQTFoZUoyMng0RTdsTnlKdWd4MnppRzFG?=
 =?utf-8?B?Rlp5TzR4a0FKK3JUZ0c5S3VKQ0ZXVVJwSlpvMWhTTnNLMmszajRCVUgvbzZp?=
 =?utf-8?B?ckN4akxIbFpUVTNHZm5RMVBnbXo1RHFBdWRERDRvaW1ycmsvU0xac25xcDhm?=
 =?utf-8?B?NktVRWdLRVB6Nis5K2hUaUsyN1dzZzYwN0laSlI1N0NNWWtBT1ZOY1VoMFFq?=
 =?utf-8?B?aDIwcWNtdXAvS1I1RjdRUTJCVzBXc3YxeXZXV1hKZ1AwbW9PWGQzYVNGcXBL?=
 =?utf-8?B?RUdEVkExT1lEZ0FWVmV5aXRacWFkVzMwaE9pR1lmKzJEQ1B5M1A0TktsVFB5?=
 =?utf-8?B?M0d4WWoxOUZVczhBNUwzcGRTQjNxUkRoaFN3UE5DMnk1eS9GL1ZsUEJ5MjBG?=
 =?utf-8?B?R1hkMlVjaEpwZXpuR29zd0ZGaXh2R3RudFJBUHFvREpHZ2sxMWhvdUxGY3Q5?=
 =?utf-8?B?SWptSDZ2QXhvOFk0K1FPZVZBYnRJK0ZVckptWUh3dU1rNnlxdW4yQkw1UUhQ?=
 =?utf-8?B?aGxmczhKZk1XeVZkd0kxalkxTEhKQ3JqOUFBVkNOc1BkeWVYTDU5YUNqbjYv?=
 =?utf-8?B?RkoyakNyUHp1c2Q1U2R5cTZJb29xdU9OdTdFcWRoaWgxRjNmZUNnelhWYzBv?=
 =?utf-8?B?UFRSQUVXODc0SjFkempiTWlTZGExR2FleXNaRUdoSnRUbStYK0FjNWoxdERn?=
 =?utf-8?B?SUhuTTdGcW5qQjhkMnBlQVdUWG8yb1hqMVNaSEJXcEM3dnBQb1hqZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dQYcOpnkxi9qiByGDkoqScahSWKMBZLOzi5dMg/j9MgvAfOxiSyhRzt16SsGoEPH5wKHNuNHzyd4aU7XNr3SmwTPZkOxEknhIKmOlGDnfLmbmsBNBZ2ktzewwx7kVrkDJCvqzmgQxfwUUfQ8XrReOdxgUpxNol+SFz1EpS0ssdPi16GxSJ/JyHq8ziobTxuRAV+agXfXfk0BKZxSehT+enU+7s7JJ0MpN587YtUxIWDctk2PY7QjJhaXaVXYpS3HR9sZZcFJOi//IVj3Tt6cGtO+zzyoIqsvCp8kUlIA70GEm0OA0OuNPKC0i7xmWcz4Ee8Ve83gB1s2yMkVoNRGzg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d655b6b-93ba-4175-2701-08de8e29c079
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 06:58:30.6937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCX7gUs/JOyQsTX7siKZ+W5h+27OTQnGUwrrUawLYC0KSas1PiHMTXuRRfzgZmFHy82ijZOAxA5lNbWRcfRBVtlDg6A+IsHw2shr2PBkjSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDgvMTRdIGludGVsX2lvbW11
X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj5wY19pbnZfZHNjIHJlcXVl
c3QNCj4NCj5PbiAzLzI2LzI2IDE3OjExLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdoZW4g
Z3Vlc3QgZGVsZXRlcyBQQVNJRCBlbnRyaWVzLCBRRU1VIHdpbGwgY2FwdHVyZSB0aGUgcGFzaWQg
Y2FjaGUNCj4+IGludmFsaWRhdGlvbiByZXF1ZXN0LCB3YWxrIHRocm91Z2ggcGFzaWRfY2FjaGVf
bGlzdCBpbiBlYWNoIHBhc3N0aHJvdWdoDQo+PiBkZXZpY2UgdG8gZmluZCBzdGFsZSBWVERBY2Nl
bFBBU0lEQ2FjaGVFbnRyeSBhbmQgZGVsZXRlIHRoZW0uDQo+DQo+PiBUaGlzIGhhcHBlbiBiZWZv
cmUgdGhlIFBBU0lEIGVudHJ5IGFkZGl0aW9uLCBiZWNhdXNlIGEgbmV3IGFkZGVkIGVudHJ5DQo+
PiBzaG91bGQgbmV2ZXIgYmUgcmVtb3ZlZC4NCj4NCj5kcm9wIGFib3ZlIGxpbmUuDQoNCk9LLg0K
DQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyB8IDc1DQo+
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgNzUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IGluZGV4IDMyZDhh
YjBlZjkuLmMxMjg1Y2UzMzEgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2Fj
Y2VsLmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gQEAgLTE2LDYg
KzE2LDI4IEBADQo+PiAgICNpbmNsdWRlICJody9wY2kvcGNpX2J1cy5oIg0KPj4gICAjaW5jbHVk
ZSAidHJhY2UuaCINCj4+DQo+PiArc3RhdGljIGlubGluZSBpbnQgdnRkX2hpb2RfZ2V0X3BlX2Zy
b21fcGFzaWQoVlREQWNjZWxQQVNJRENhY2hlRW50cnkNCj4qdnRkX3BjZSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERQQVNJREVudHJ5ICpwZSkN
Cj4+ICt7DQo+PiArICAgIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QgPSB2dGRfcGNlLT52
dGRfaGlvZDsNCj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICpzID0gdnRkX2hpb2QtPmlvbW11X3N0
YXRlOw0KPj4gKyAgICB1aW50MzJfdCBwYXNpZCA9IHZ0ZF9wY2UtPnBhc2lkOw0KPj4gKyAgICBW
VERDb250ZXh0RW50cnkgY2U7DQo+PiArICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgIGlmICgh
cy0+ZG1hcl9lbmFibGVkIHx8ICFzLT5yb290X3NjYWxhYmxlKSB7DQo+PiArICAgICAgICByZXR1
cm4gLVZURF9GUl9SVEFERFJfSU5WX1RUTTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXQg
PSB2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1c19udW0odnRkX2hpb2QtPmJ1cyks
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfaGlvZC0+ZGV2Zm4s
ICZjZSk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIHJldHVybiByZXQ7DQo+PiAr
ICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkocywgJmNl
LCBwZSwgcGFzaWQpOw0KPj4gK30NCj4+ICsNCj4+ICAgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2Nl
bChJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJT01NVURldmljZQ0KPip2dGRfaGlvZCwNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+IEBA
IC0yNTcsNiArMjc5LDUyIEBAIHZvaWQNCj52dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tl
ZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9pZCwNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9sb2NrZWQsICZwaW90bGJfaW5m
byk7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX2ludmFsaWRh
dGVfb25lKFZUREFjY2VsUEFTSURDYWNoZUVudHJ5DQo+KnZ0ZF9wY2UsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lEQ2FjaGVJbmZvICpwY19p
bmZvKQ0KPj4gK3sNCj4+ICsgICAgVlREUEFTSURFbnRyeSBwZTsNCj4+ICsgICAgdWludDE2X3Qg
ZGlkOw0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBWVERfSU5WX0RFU0NfUEFTSURDX0df
RFNJIGFuZCBWVERfSU5WX0RFU0NfUEFTSURDX0dfUEFTSURfU0kNCj5yZXF1aXJlDQo+PiArICAg
ICAqIERJRCBjaGVjay4gSWYgRElEIGRvZXNuJ3QgbWF0Y2ggdGhlIHZhbHVlIGluIGNhY2hlIG9y
IG1lbW9yeSwgdGhlbg0KPj4gKyAgICAgKiBpdCdzIG5vdCBhIHBhc2lkIGVudHJ5IHdlIHdhbnQg
dG8gaW52YWxpZGF0ZS4NCj4+ICsgICAgICovDQo+PiArICAgIHN3aXRjaCAocGNfaW5mby0+dHlw
ZSkgew0KPj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfR19QQVNJRF9TSToNCj4+ICsg
ICAgICAgIGlmIChwY19pbmZvLT5wYXNpZCAhPSB2dGRfcGNlLT5wYXNpZCkgew0KPj4gKyAgICAg
ICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgICAgIC8qIEZhbGwgdGhyb3Vn
aCAqLw0KPj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfR19EU0k6DQo+PiArICAgICAg
ICBkaWQgPSBWVERfU01fUEFTSURfRU5UUllfRElEKCZ2dGRfcGNlLT5wYXNpZF9lbnRyeSk7DQo+
PiArICAgICAgICBpZiAocGNfaW5mby0+ZGlkICE9IGRpZCkgew0KPj4gKyAgICAgICAgICAgIHJl
dHVybjsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAodnRkX2hp
b2RfZ2V0X3BlX2Zyb21fcGFzaWQodnRkX3BjZSwgJnBlKSkgew0KPj4gKyAgICAgICAgLyoNCj4+
ICsgICAgICAgICAqIE5vIHZhbGlkIHBhc2lkIGVudHJ5IGluIGd1ZXN0IG1lbW9yeS4gZS5nLiBw
YXNpZCBlbnRyeSB3YXMgbW9kaWZpZWQNCj4+ICsgICAgICAgICAqIHRvIGJlIGVpdGhlciBhbGwt
emVybyBvciBub24tcHJlc2VudC4gRWl0aGVyIGNhc2UgbWVhbnMgZXhpc3RpbmcNCj4+ICsgICAg
ICAgICAqIHBhc2lkIGNhY2hlIHNob3VsZCBiZSBpbnZhbGlkYXRlZC4NCj4+ICsgICAgICAgICAq
Lw0KPj4gKyAgICAgICAgUUxJU1RfUkVNT1ZFKHZ0ZF9wY2UsIG5leHQpOw0KPj4gKyAgICAgICAg
Z19mcmVlKHZ0ZF9wY2UpOw0KPg0KPmNvdWxkIHlvdSB3cmFwIGFib3ZlIHR3byBsaW5lcyBpbnRv
IGEgaGVscGVyIG5lYXIgdG8gdGhlDQo+dnRkX2FjY2VsX2ZpbGxfcGMoKT8gQWx0aG91Z2ggbm8g
b3RoZXIgY2FsbGVycywganVzdCBtb3JlIHJlYWRhYmxlLiA6KQ0KDQpTdXJlLCB3aWxsIGRvLg0K
DQo+DQo+PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiArLyogRGVsZXRlIGludmFsaWQgcGFzaWQg
Y2FjaGUgZW50cnkgZnJvbSBwYXNpZF9jYWNoZV9saXN0ICovDQo+DQo+YWJvdmUgY29tbWVudCBp
cyBub3QgcXVpdGUgbmVjZXNzYXJ5Lg0KDQpXaWxsIGRyb3AuDQoNCj4NCj4+ICtzdGF0aWMgdm9p
ZCB2dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZShWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9k
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lEQ2Fj
aGVJbmZvICpwY19pbmZvKQ0KPj4gK3sNCj4+ICsgICAgVlREQWNjZWxQQVNJRENhY2hlRW50cnkg
KnZ0ZF9wY2UsICpuZXh0Ow0KPj4gKw0KPj4gKyAgICBRTElTVF9GT1JFQUNIX1NBRkUodnRkX3Bj
ZSwgJnZ0ZF9oaW9kLT5wYXNpZF9jYWNoZV9saXN0LCBuZXh0LCBuZXh0KSB7DQo+PiArICAgICAg
ICB2dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZV9vbmUodnRkX3BjZSwgcGNfaW5mbyk7DQo+PiAr
ICAgIH0NCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9hY2NlbF9maWxsX3BjKFZU
REhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsIHVpbnQzMl90IHBhc2lkLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWVERQQVNJREVudHJ5ICpwZSkNCj4+ICAgew0KPj4gQEAg
LTQyMyw2ICs0OTEsMTMgQEAgdm9pZCB2dGRfcGFzaWRfY2FjaGVfc3luY19hY2NlbChJbnRlbElP
TU1VU3RhdGUNCj4qcywgVlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCkp
IHsNCj4+ICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAgICAgICAgICAgfQ0KPj4gKw0KPj4g
KyAgICAgICAgLyoNCj4+ICsgICAgICAgICAqIFBBU0lEIGVudHJ5IHJlbW92YWwgaXMgaGFuZGxl
ZCBiZWZvcmUgYWRkaXRpb24gaW50ZW50aW9uYWxseSwNCj4+ICsgICAgICAgICAqIGJlY2F1c2Ug
aXQncyB1bm5lY2Vzc2FyeSB0byBpdGVyYXRlIG9uIGFuIGVudHJ5IHRoYXQgd2lsbCBiZQ0KPj4g
KyAgICAgICAgICogcmVtb3ZlZC4NCj4+ICsgICAgICAgICAqLw0KPj4gKyAgICAgICAgdnRkX3Bh
c2lkX2NhY2hlX2ludmFsaWRhdGUodnRkX2hpb2QsIHBjX2luZm8pOw0KPg0KPnMvdnRkX3Bhc2lk
X2NhY2hlX2ludmFsaWRhdGUvdnRkX2FjY2VsX3Bhc2lkX2NhY2hlX2ludmFsaWRhdGUvDQoNCk9L
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

