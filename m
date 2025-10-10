Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD2CCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 03:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7458-0008PN-B2; Thu, 09 Oct 2025 23:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v7454-0008KW-Dh
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:46:10 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v7450-0006Si-5D
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760067966; x=1791603966;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9p4FPLwoHh5f6ebCWpC7G8RA/oZexnxBVQxc0ByVGe4=;
 b=hv+4sNBgprQUUsonN/5IzGAjSuAXJ8U94HgCk1wbIWfgZ0QeAMW55pna
 073lIqrMt0eUihpQ03HfVVDouZ6KmDFBR+46s2GZDy+pRQ0rRhbEXf5sm
 TznA1G4lCGIAb/Tl/1JmrGbauu1IuyD644xFBCy+kEtlBgHvvh0L5sHKg
 y9QK2h3OG2PRTPJ253rsfAxjLjKP2Kxs6ZxuO3F9AQjCvmcZ51D8bO+xT
 fIVrG+NamGUA7nvvkEWTFJeXi2bYW9j2mdR1lSqaWZNdHYx3UkPuuVfVi
 19M+9NLHPt87I+/mdfOlOywJdjn3jvsHcRD4LoFnVS5IinD6MBlCsSzIQ Q==;
X-CSE-ConnectionGUID: p6eiPwRbSTOGA/HMSHcZXA==
X-CSE-MsgGUID: 9C1Yt68MRYKHWL+4c3eXaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79729631"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="79729631"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 20:46:01 -0700
X-CSE-ConnectionGUID: 5p8ieKI/SNOpOMtb5d1fRg==
X-CSE-MsgGUID: VB9NpxguSYCvOUwMhNKgRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="185998828"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 20:46:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 20:46:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 20:46:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 20:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJFoFxRIX6IJQLcxr4+WcfKwDbprEnBdZWKeOD9eLn1r6SZ8Z3N2hp1n/QdxBE6x0EnMCGSuYiXlGXS/8SrVx34gEGG7CBewNhtSF5d4Vjq8y3XPcb/k+iG91Eb7jyHNZooeYCZMocZiCpTEMNZtk6RDjY2ayDnp0Y/y0I+CbJ7tFpImUpTyoYSFMNIv8d5OFzUpUNSkquY+pQZGNexCWYknd3gnkAXBAUZA8VGygmI8OlMKUAtsE34YP0x0CgmPlS6yAbtWm2aZDHu+TstLEN68xsdsxAanUbhi6mUNjwNLW6xEUbY08OBBc6nCe+pgptmebf3VBYh633O8jQ+IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y8cg4a0Df8ww36HyAVELlNN6vDQNYwjn95ewpsvRsI=;
 b=wit8iMIDBF74C3o/ffMwQf2Glzm+rmc/oEm3f1dLhTTXOarRB+7raVlGI20iNQl3jdkCkPKrRHCjpg/makIQ9NTPuL3HvR8c88KRiKGsTRf7gMnPks0g7NSfnaaWmnd2wNkk7cUnMSekPL4cpU/nLFMWbhRozQCTsXoHkF3Vv4oVDK+Kz8O/FqfWc4XuN12/IFbjP8X0GiIZFa2J6LwnPVOfRN1r4WYNnWijo5Ktn+cZzMKfVlxb14YB0myw7GJVt0vG27mpCQk5IjjnMi2o1iOTalCzeH8fCf9WfO40idltt7bM2dAkxzJ6msz9PUuPnC8Lnu5fyWSUd1dmWksJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:45:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 10 Oct 2025
 03:45:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>
Subject: RE: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Topic: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Index: AQHcMFWngtFRdKHVOkWcXMje/gJxi7SqMJYAgADkn4CAAJxjAIAHrvKAgAaL8oCAAAJpAIAAA4oAgADYbeA=
Date: Fri, 10 Oct 2025 03:45:58 +0000
Message-ID: <IA3PR11MB913611BAECA2B389A9BDF92492EFA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
 <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ab688cce-283d-4541-b7ca-be651085979e@oracle.com>
 <aOfEiogVQiAhBqMG@redhat.com>
 <2ac44a27-d4f2-4191-a9c3-513af25925b0@oracle.com>
In-Reply-To: <2ac44a27-d4f2-4191-a9c3-513af25925b0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7304:EE_
x-ms-office365-filtering-correlation-id: ca2aece1-eca3-4a2a-d87d-08de07af8605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FbQISSgeISyIXWQuI2PQottU+6KFUqRjjsBhOWnnzxMP5B8A7BPaNYpf7X?=
 =?iso-8859-1?Q?yo5p7u7OGKtiSr/KxqzQN9ZCMlWUShWdTp4q+QLZGsGEOfpb+ZelKFSARq?=
 =?iso-8859-1?Q?jE0ZmdArnycg/u+jaEA6sAjWlEi8LR69ijw8wtvjcLuwmw8rnnajwfXpUS?=
 =?iso-8859-1?Q?O1rAtLwQx1AOchC8vEy0xZHkKHXiGbW8jYWgmhChyct4TuRsWahy87n+7u?=
 =?iso-8859-1?Q?GFy0MFZaxObKG7wLObUXC15xUD/mtJ8CvDg5Tud9tmiIlVAG6qMi4nP3jJ?=
 =?iso-8859-1?Q?E5sfv75iEingU8kDDBrsJ0leliEKF1shjC6i6WWEJP1noZ/gMXm0cQGk3e?=
 =?iso-8859-1?Q?ccU+RQ3/S8kIwki/urGms6TEAUQrPCtHdKc+bbEi2mWalndWnHjBVTHK4H?=
 =?iso-8859-1?Q?nm7XnKIVqBMcHl9TTynJ26j8kOXfKujqugAeg0CqX39exW0Pn84cf2Yrr0?=
 =?iso-8859-1?Q?WqOxyqHUy+s8/xplBUn+kJKRYIwNl0fDm9y3+7azOB91/2mCr7oHFF0lzR?=
 =?iso-8859-1?Q?mXVGjivnPh+pTAs2s1QqKaSb4ewtHIrFY+9ge9W5xBuOQyTMvMr3QTrup1?=
 =?iso-8859-1?Q?O4vUkGj6nIXk9GVwERqfNBg5zwe5OaV2LQ2ekofHKpO5FYPNHJpVVeEZbd?=
 =?iso-8859-1?Q?K3Wtm7K+7EMXurILhDTGpGS/85GyO6nn/0gXW7k7MDmiSwtIhQOCTc4H6x?=
 =?iso-8859-1?Q?VcSSP9gJ2kfz3t2si+ak+PmMzSieuXLR7wszpd3CpniroeCd37MuCwIpRf?=
 =?iso-8859-1?Q?U4LxCvnaGhwcG4O/xtXag1N35rokz+WE0yERe94VphSPrkLCBVh5/yQEG+?=
 =?iso-8859-1?Q?N/BN8EZrr7xacTopET5BoYa5NMAZMyzQm/2QlfUkNoW+UyAWzdY6UaEyeR?=
 =?iso-8859-1?Q?MvIdOjh+po6Fp4hteRwaeJP4kLbicpyJIftXFbUupqgLgBXTy5rZvJtypu?=
 =?iso-8859-1?Q?rHa/K6wZsofnsObyfqTppIrZllxqEEQNPni9b+sA4OhGhVnAiaYt5IYCVa?=
 =?iso-8859-1?Q?Bt/AseoKIbk+BQbrpJmTrLohHJAc1S6CVKAV4g9+WNDVmM6b3MuMpGPIPt?=
 =?iso-8859-1?Q?iev9CkpyaCGUs4+LNpoPqVCh/CSWSgt2HsofURnxOTjS9l1SlHr7YQNeEW?=
 =?iso-8859-1?Q?8Ffya8RUZtwmaDA5XaePZ44vdZ+U0cSUx12RUgUWXWl9IqWKyhr3CUuYVG?=
 =?iso-8859-1?Q?vdwsSq0n1VMGGxLMkUr3YBSU+4Py+FubtlJg3WAw8NvV28PDOuTXt4hcOT?=
 =?iso-8859-1?Q?Ampc8JRwQ5i4SIzN4zHI9/XvHDh6FZu4urJ7P9E0/JWCIhlB1WSyScyksc?=
 =?iso-8859-1?Q?Y7eWDJc/Ry4fUSqQVJ1rgH7C2LdPnMgPc0S1l7NNJqzDzSEJDo4kPq774K?=
 =?iso-8859-1?Q?EF9r+bNjP6oo+obSJ8OR0Xbj0FWoAd+eczcFHNlDoG0sa5RG+7mssGrJ1q?=
 =?iso-8859-1?Q?hMafzB6x8OS3tLu2Zr2aCt1XGsScbyc+DNvLLeawJGwlM3M0MTUf+dnfPs?=
 =?iso-8859-1?Q?XPiIYC1NIpepeYp+ZzHqmp6znNe5qrTLXmYveklMF5dT+XWWIuuajxfVYw?=
 =?iso-8859-1?Q?WxYcq7/xU+r6/ReIeKSkGYx3TNdg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3KMfdUE91vhauNABhsBqJMlFown4CgRRWuVJEr105HLC60X1amIbZSUx16?=
 =?iso-8859-1?Q?TU0/fw8toIhKkhfHOhPwMuHug/EB1G4AwZVMiInJU1oJlGTGi1kN8XGpgW?=
 =?iso-8859-1?Q?MBFLNU5kCL5VlPPAx/Oc/UMBdgf3lZu5euuQgi68npwq2CdvXelKvfS47/?=
 =?iso-8859-1?Q?t4ONgaLU9L+TjJQZWdYfvdPvu+cPyu+J+ADCSBIl4G81shiDSurfFVFuKO?=
 =?iso-8859-1?Q?WkfVTgOPsr0rBxP4ymSvbXZZPuHQhVKVemf6nHb7wnobmeK8hhjvYuXOf3?=
 =?iso-8859-1?Q?4SI2TsOaIsIVTf+i2Jo33Kbvy8b5liy4v03l6uN5LhZ87rkrCX2gUzCYQV?=
 =?iso-8859-1?Q?4Wz79JZCee+zHR8YAxviKx141d9UKiI9IiaG9IZGU80xhFw3kGp1S88VFw?=
 =?iso-8859-1?Q?I9fOtHIFtomvYa3fdRgtW3LiapCfbiLQqWazC8bXsmT8SyCmHhXBAt1gpC?=
 =?iso-8859-1?Q?Ev54cSFQSgsCEyabdeNk0xmOBtQ7u0fOuHt78FDP1UV8VavXpst4qExYfA?=
 =?iso-8859-1?Q?AWwQeAE81DOEpR2DapTZLIOR2PqhNw655ifmg5OcpNrmM1R3QzGAKAeuDv?=
 =?iso-8859-1?Q?hRlScjJsNmVVB+pH8cB6a1FdO6PQkxPFJkmom3lqxZNjbKM//Lo9oWBIrj?=
 =?iso-8859-1?Q?4AgQM2lIlsFvXOjZVLTwFrBumInrxFefmVuupYzHPRWloclgTfX9m//iPu?=
 =?iso-8859-1?Q?tS+mIQURhSOFv9Uiq2SKrKcNZrpPtSGM9unySDO7LIUpn5h7qyWfvgu2zC?=
 =?iso-8859-1?Q?m6QLEWPNmNezdanUs2CySrRDru8ptbPhcIgUt1Dz1+2geN75Gn4OkFGmAo?=
 =?iso-8859-1?Q?rXxRqs0K4g4azaFFAg4adCLnvk0igkHzP+pWvPuwuIpfdJcdv6+bWKbEYo?=
 =?iso-8859-1?Q?AwMXhJ2CupX/k3Ll6S2XrpssdrIONA2syPd76nmRAAOjTsJWjYi7zSL34w?=
 =?iso-8859-1?Q?dCxWQsAH7h2rXqDj4mu4RSjWgqzP/3a9Vjqv/EWYzd7K12m8wlDBfz5Lji?=
 =?iso-8859-1?Q?WyzPZZbAD0+pOQnVuTeVT/kGKf45vzv/XVEPRWXE286kMXOThN+XucPowo?=
 =?iso-8859-1?Q?g8rh26QPaYG8DxCk64bupHF2qFraek/PtoKo9mmjyInMO+EebmePZ8lanR?=
 =?iso-8859-1?Q?qq1+wD3xqAKxWECrezXF4hKFur52JKU+IUCtJpMkqBlSEbomGcPvrJluXv?=
 =?iso-8859-1?Q?OV7x3ildfvH5PocF4WqAPU5radwsGyISpXJsy8K945ir1DVHEJIJ5NltfP?=
 =?iso-8859-1?Q?OGNR8Q5jqOEgVuaMFj+pQMJCe5f4c2nOg4sjhsdJks7tQNjE5cHnPKTDvt?=
 =?iso-8859-1?Q?ONCM80IBwwWFFvJs1uq/yrZphjpPCbYhXFF66kU3pPUsWt19KVsw9o9bXv?=
 =?iso-8859-1?Q?tquuk/edoIkhqZEvopy+0zkQiSY4cx6KQnNJytZmytPhe82dBk0yj9vSoN?=
 =?iso-8859-1?Q?7BiyqSwBlkSIsJhIzwc1jZfhyroOlUuKtmAhgImtOnAT3VpJgmsA64BN1Z?=
 =?iso-8859-1?Q?de60lxLrP577PU1zr54xXlgpNKF4N0XndBRE8Y1QoKKmcZ2OiOR0imW/N7?=
 =?iso-8859-1?Q?tcP75MGIm7QD8OOUtXIFyFfhtudwWZf1rk6RjK5sqIqEC9XEexpeyGFefE?=
 =?iso-8859-1?Q?xKR3cXjtQ7uO1jCcyO06f0NsZUipli6/bV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2aece1-eca3-4a2a-d87d-08de07af8605
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 03:45:58.2288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Th34fr+kGZBie/Nr8oHL82bRVpIcDxc7XwMPw/dbjoDhNBYG/UjqvrefNAfG5LXwYgLjSkUJXfkO52kpWd8kPJEc1ZH7x6nIAB6QK01c9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>"query-balloon" after CPR transfer
>
>On 10/9/2025 10:19 AM, Daniel P. Berrang=E9 wrote:
>> On Thu, Oct 09, 2025 at 10:11:17AM -0400, Steven Sistare wrote:
>>> On 10/8/2025 6:22 AM, Duan, Zhenzhong wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>>>>> "query-balloon" after CPR transfer
>>>>>
>>>>> On 9/30/2025 2:00 AM, Duan, Zhenzhong wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>>>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>>>>>>> "query-balloon" after CPR transfer
>>>>>>>
>>>>>>> On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
>>>>>>>> After CPR transfer, source QEMU closes kvm fd and sets kvm_state
>to
>>>>>>> NULL,
>>>>>>>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
>>>>> pointer
>>>>>>>> reference.
>>>>>>>>
>>>>>>>> We don't need to NULL kvm_state as all states in kvm_state aren't
>>>>> released
>>>>>>>> actually. Just closing kvm fd is enough so we could still query st=
ates
>>>>>>>> through "query_*" qmp command.
>>>>>>>
>>>>>>> IMO this does not make sense.  Much of the state in kvm_state was
>>>>> derived
>>>>>> >from ioctl's on the descriptors, and closing them invalidates it.
>Asking
>>>>>>> historical questions about what used to be makes no sense.
>>>>>>
>>>>>> You also have your valid point.
>>>>>>
>>>>>>>
>>>>>>> Clearing kvm_state and setting kvm_allowed=3Dfalse would be a safer
>fix.
>>>>>
>>>>> Setting kvm_allowed=3Dfalse causes kvm_enabled() to return false whic=
h
>should
>>>>> prevent kvm_state from being dereferenced anywhere:
>>>>>
>>>>>       #define kvm_enabled()           (kvm_allowed)
>>>>>
>>>>>     Eg for the balloon:
>>>>>
>>>>>       static bool have_balloon(Error **errp)
>>>>>       {
>>>>>           if (kvm_enabled() && !kvm_has_sync_mmu()) {
>>>>
>>>> OK, will do, clearing kvm_allowed is a good idea.
>>>>
>>>> Currently there are two qmp commands "query-balloon" and
>"query-cpu-definitions"
>>>> causing SIGSEGV after CPR-transfer, clearing kvm_allowed helps for bot=
h.
>>>> But clearing both kvm_allowed and kvm_state cause SIGSEGV on
>"query-cpu-definitions".
>>>>
>>>> I'll send a patch to clearing only kvm_allowed if you are fine with it=
.
>>>
>>> I still don't love the idea.  kvm_state is no longer valid.
>>>
>>> It sounds like "query-cpu-definitions" is missing a check for kvm_enabl=
ed().
>>
>> This patch  / bug feels like it is side-stepping a general conceptual
>> question.  After cpr-transfer is complete what QMP commands are still
>> valid to call in general ? This thread mentions two which have caused
>> bugs, but beyond that it feels like a large subset of QMP comamnds
>> are conceptually invalid to use.
>
>Agreed. I don't see why these commands should be issued to the dead
>instance.

Uh, yes, that's why I hesitate if it's deserved to fix it.

>How about migration status, quit, and nothing else?
>Half serious.

We only have issues with "query-balloon" and "query-cpu-definitions", all o=
ther "query-*" qmp commands work fine.

{"execute": "query-migrate"}
{"timestamp": {"seconds": 1760067694, "microseconds": 815419}, "event": "ST=
OP"}
{"return": {"status": "completed", "setup-time": 3, "downtime": 14, "total-=
time": 67, "ram": {"total": 0, "postcopy-requests": 0, "dirty-sync-count": =
2, "multifd-bytes": 0, "pages-per-second": 0, "downtime-bytes": 0, "page-si=
ze": 4096, "remaining": 0, "postcopy-bytes": 0, "mbps": 58.152999999999999,=
 "transferred": 465224, "dirty-sync-missed-zero-copy": 0, "precopy-bytes": =
0, "duplicate": 0, "dirty-pages-rate": 0, "normal-bytes": 0, "normal": 0}}}

{"execute": "quit"}
{"timestamp": {"seconds": 1760067734, "microseconds": 599830}, "event": "SH=
UTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
{"return": {}}
Connection closed by foreign host.Connection closed by foreign host.

Thanks
Zhenzhong

