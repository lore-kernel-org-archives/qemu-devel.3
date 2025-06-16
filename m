Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A3C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 08:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR51l-0000s7-Lr; Mon, 16 Jun 2025 04:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR500-0000TD-3q
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:15:24 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR4zw-0008TF-KG
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750061721; x=1781597721;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=thUJ7bs8+M7dDnnwbn9to6mjDgDYAMSu6appndMR7Bc=;
 b=ijySLPmoRkCDarYbocUS6v5cL3djgP8E1+cG5e4YGx4dJe2VBPRVgW+y
 WfLmqN5k5eHIpVsmp8KoXmM4YvC87EkmcqQ2KVwuHeHRDMQbnj0ku7Y4k
 CIftezaJSoQyiF5N1LM9rqd4oz2fraGN+/iPHWuR8rt8pGfRFnvn9IqY3
 aYuSQ/q2I55kmJDuYy/f0g+Q7hye0nQau0Io/OULM13I0jhZzXdE6qHDr
 HIMkhh3aCub04FjhuuiYBJr8Crot9nJ17x4ZfELQ7OaMTNlstEdvId1cz
 /xRRP+yx1etejW2c86tQyaFGNPPstfnhFsWgMjgWw4HHMe0H/SDY88eQE Q==;
X-CSE-ConnectionGUID: iOiN5Y8FROqFITazOxplVg==
X-CSE-MsgGUID: NoXszDttTlSFVw4wr5KywA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62805302"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="62805302"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:15:17 -0700
X-CSE-ConnectionGUID: EdzYj5n8TIi+9HjNVcSUkw==
X-CSE-MsgGUID: Qh4Vd6t9Rx+Q04n9+izwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="179303516"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:15:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:15:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 01:15:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.52)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:15:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4jUiPaWgf4V0SwTbYgkyNk4bNs56RZqE0laP876QXZyZ3M0WEMCSB4F+iFvkWi4f7PHKBuuKyI1aYP7wXu4m85U4pTygO5Q45hnlZWWsH/4Y9oMIG0y/eeEWc/TG5URkqz1k/XVAw2PtMeQcjUR2M3Oymoq62qUQzkfUQ+jxeEFSeWBJWzD0ugOjy/SbdtYgNUieke0twH1HT4OYZqCLBIw1UujMb75Epx1T0XZ56tjDMhbph7zeAtEeF+x7IsBO6KYnYHI6ehngOeGtjr0mAWI8rIXW1ZFfWAnKxrblBOZ/y8pQX2PeU0sGiP5iLh3cjjBusG2JWxhwFlMtbNTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thUJ7bs8+M7dDnnwbn9to6mjDgDYAMSu6appndMR7Bc=;
 b=B8QYVswFOqHLSaYMHRsV955AFHXRoHE17w11JS53C/C+40WBVO3deMg+KXNdaLtdjB8L6mV1DgGeRfalfyiEhkpfq6aFmDv8hEc1TvkRvtRWxLned9GCY1DdrhKzzxRpYh4VZawdLGvVFNRMyJOMNim/TxTw/Qyo2NyX33l6BJomI73SL0IzUTXeFhktWML+7pR5ryCbLj6sLY2au8tv+C6EleoKyhMgUaJp0hZPTXFEMllyAA0xgVM3uzT2BLSA1piEr/rWebI8TV1gWB2RKDPzbnil7mf0JwZ0jbT5Ix+QQrOAANsWUlDs+3cHsESL7hYVLbQQPiyYG7kLDuSR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7530.namprd11.prod.outlook.com (2603:10b6:8:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 08:15:12 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 08:15:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAPjWAIADz6UAgACqsQCAAnMkMIAdyAkAgAAnT2A=
Date: Mon, 16 Jun 2025 08:15:11 +0000
Message-ID: <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
In-Reply-To: <aE+wCIG8KHb3u1lV@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7530:EE_
x-ms-office365-filtering-correlation-id: d1bbdeff-af4c-45d0-3a3f-08ddacadea7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p5ExDM8V1b6dRXxdqG9Y4FwwHthWNGp59djnNNj5Io2IBb67aHtjFHjgs0vM?=
 =?us-ascii?Q?EEC1+hd/FBgX88F8w2Mcq6fe9WohxIAagNL03bLqELqIw/Ag3ugHzT+GmV2b?=
 =?us-ascii?Q?XSanX5NIeoecPUVEKlj/EBdgvrMuTaEQg9KJC/FyaETbkcCajCiYzIQOT7YO?=
 =?us-ascii?Q?MeuAVHbfF7fACF/Jw/w6umCzF4i402DqXJnLPzlZF4YIHl5Nn/1LZYYFo5Pv?=
 =?us-ascii?Q?IbfOhNypquvbH5OyoWm9GUBS2KOWljXHww3EL2xJj47fe9KZgolS2ET2bvdc?=
 =?us-ascii?Q?XLcUE56zfsBV4Imnx99NNkAXL+agA7FBtD+D0kTfVNda1zcTCIqck0cDQmEN?=
 =?us-ascii?Q?APQyLuI+/5W/32e6dsVos3dg3j+UYCLfyryU5zX4xivGRjlfco8fX59jAcay?=
 =?us-ascii?Q?0pc99LLzk+WLS2l89pAWUO40xoimlS+foV5XFKby2ecixoz5lMLHNq+Kx3O8?=
 =?us-ascii?Q?M38LWrnOQfKWcZkx88Q3dec97yZ2ra3zRC6SEce4yZS4GP9zdAIaD6UnCY28?=
 =?us-ascii?Q?H4klTPZSt7weTQCTNoHl2uJDXCvTztfswlt3Yag8f+ak0Eff3cROWt9+aJ2t?=
 =?us-ascii?Q?xw4sAMVq9tUnROqxmZbWx6rC18cRCNgKSmXlX1/hJ+C6npX7/0qZSsdGnfnj?=
 =?us-ascii?Q?DiqjXHHZHqRJ1YuspAHbuWPc5HbTmvecmSaoLsDhCs6ERj6ctRj+4hytLTen?=
 =?us-ascii?Q?vfuEr0eV0LukbLpbCfo72hRPVBnK7nWWyvKjpZK2EBizWIY/rZjMRg3JNUBR?=
 =?us-ascii?Q?VfDAXP+bQcUS0HY1RqvMCLgpUCLdA/n1p4Zqr/bH5Lg3fki+UHgRIsL2vTDK?=
 =?us-ascii?Q?tGsHUIi7emc9WZPopauqwgimr9nAfByEpcivYQs41kHazcua+DKmvPhbhocV?=
 =?us-ascii?Q?qCLkBQOVmuWGxgRgwNyl0CpbBHg2IjFD6csk5XEPWjiDZJQTG4n2el4PgGdL?=
 =?us-ascii?Q?OljH5cgtoUAxZbH0uGRD6Abm8jd+isCmSbgnsuzViHI8QA8ulLaUcNoHaYQj?=
 =?us-ascii?Q?QtkVpSRMGBMvPlaNfulTletiiyc5VQ7MnZhpzFhXdj7O7DsC08XzVmclyl+W?=
 =?us-ascii?Q?MLqwJ5ndGRT0iyUNyNZQO4uWW5e7PIHo2qdsbZHaXl87bWwh7N0rFRWDOhma?=
 =?us-ascii?Q?n5wnw2wKK2XRqU4ALz/IgUGhunQSl+QAm4UzQ6k3hRHpKP8bspMeuilhRP6p?=
 =?us-ascii?Q?82xYLTYqLDR9Yz7M/LYGAt62UOk6iKLOOQ6WW2/ZnHwrq2PhROqgjt14LWww?=
 =?us-ascii?Q?QV79E0phvRDYMULkKcioyUfgF4KoTY1FA4XTkw3WkP146tgXKgceoTTLVLz0?=
 =?us-ascii?Q?QVmN4eMpdrtv6w9WR6au0wZ6bB6FrDp8BgnxM2dm2yRLr3CwlE70e/fhZppT?=
 =?us-ascii?Q?DlyNA/b+Woism7J6tETfPuoskLboj83kVAiy0Bpd9h0UqRXM3LLOLtxTDQgn?=
 =?us-ascii?Q?wDU9uMqRJYpvRPyK/eSG1xPVwQnVao200k7/t7jy1u3Ti2RURhMfQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AoM57GU+rQRYIEJLua1anURfTlZmkLi7261te8c4d8YHsDY9DobHLMZiI8xy?=
 =?us-ascii?Q?hZropUhnSVyB2PSYA7zEqJLWeMuqU0cC2gljCtyicoTN5Txqu4bxRMj9m32h?=
 =?us-ascii?Q?baa1F1y5SD9OTYhyeAaUAiL4CBrSYPSJ/lAwEx+/B94TOVbG4BOMEWuJGAEI?=
 =?us-ascii?Q?7Mf3W2vxDTUzZ/WiisIFoDXSJtVESmkq0X9SDf4v/0gPrv+MEMlIIIlMuvG/?=
 =?us-ascii?Q?rurLy0m8/RSDqj9ItA5KEdqJDYqlz2bVn/diAbcrv0MB9O3F8JCqw3mFzXGh?=
 =?us-ascii?Q?Hlrgs/h9iZFVIkyXdHNiIfb0uWZ/n4XU5xJcDnM5achxi47hj9oJtn7gUDvi?=
 =?us-ascii?Q?hjPbgIKobkZmmBrwSN8Ipu8+MDmUirbjyoNTRDRBhlvon/3pTt31n/fuBkhJ?=
 =?us-ascii?Q?9bUl+oPfulooFiYo/Xzk3aHcAsB8LfV7WvH/pBxQyB7+K/Ufdodo51URIqxZ?=
 =?us-ascii?Q?C0C5x5ib3AwTF0EQ6DnuC1cbsOiVIT9QrDI38on9f4HE4H9sOfmmm67JHcpI?=
 =?us-ascii?Q?CzFg2nHB18AZUvo8KwlYoF8S1d3qngoBvhAW/w+uIHuSyVOrGmfn111ZpqqJ?=
 =?us-ascii?Q?r2rLNgC0QWQ2/tCwIK4fduKg3sN2zj+vLWo2KC3/b1QPc79jV8xs+XQvFbI3?=
 =?us-ascii?Q?PMkNUz+LaLAK4j59LwKlbAxI9LowDqoOSJNptINPC4kJt4ueZo9V5ZizRLVM?=
 =?us-ascii?Q?CIRMycl0SKVqNj0AiUGltrseU8BTEkqeYLW3zLh9OEtxZMt9tdKA1xkUfuwD?=
 =?us-ascii?Q?d9cqgsNpBcL/UZaOV36HO/5kuj2ZYjrbEClnaE5YXG63loCtea1OSqJK1qN/?=
 =?us-ascii?Q?l75Qou6YdT73yKagqYJjH0BBvy854N8IsdLGbgYs8WT2XygmUkGOX+33Bzrg?=
 =?us-ascii?Q?EaXptPYtKDCgoBXcxHaFfQ9+uK45ka7pEVMo5WBC1rzKUoWNl+pPZKtLCzcp?=
 =?us-ascii?Q?G8Q0q9zxO9AsC1Lx3v3gdZIyf2anfoi/2e0/ov1IETGqq9QpimzeZ4keh50N?=
 =?us-ascii?Q?7QueVEbZuxMtguke05TUNMYK4l5IF/ZURs9YObArgrViFeEc884iVx2RjkEM?=
 =?us-ascii?Q?3rO4kI5cqEfqmNUU2SSHHXHwDlhMZpPtpZ2Q27oiiK6B5H7ItaXKVaVQcNno?=
 =?us-ascii?Q?0k519sJFiRyFe3finlFvF95bb9yw5elSQqZdtsmqRWJQ9+RKp09UiTwNpCjX?=
 =?us-ascii?Q?l9rrPuQNsoaw5SXQG1aNu4WaM0H5d9hFUHeRyo+8QWbEN+qrWoZwy/invAAr?=
 =?us-ascii?Q?X18H+4x/rSCasKKa7KuZI9iyrmgw23A2QWG2dE/IKz1tuVufsIU5BU5uAQjA?=
 =?us-ascii?Q?cM5k0+ThnLRuUgAmuee2uTdWHP+Et1wpREb6wsx2BT7lLEhKWic+LSWidTrV?=
 =?us-ascii?Q?BpQ0KYKMTL6CvWk6i1zbcmTUczqwGDAGWSFvK36I1/8o+NbFIT29HWpmn5Mz?=
 =?us-ascii?Q?LTnS63T73zqfvex1yG8e8gyG41QcV/60XQAemNmzFSE1na9w9h022rZ3Fpm+?=
 =?us-ascii?Q?j7PSd1RAsdZEn3oD73PUm+h4/nltnpRJGFRjeBdULDKiPoAtAsmdXl4efn7y?=
 =?us-ascii?Q?6mVta0v8h90Pa7mDKzUsdHITRJiHU4SkDZHkU4mc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bbdeff-af4c-45d0-3a3f-08ddacadea7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 08:15:11.9542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir+l7sYiXtspobzDUQQqrXRfGcK7u9vt+qLCx/6ClH4TTr+QDshH2L93g1lp9f2OETfXsSuGefDUbW1L92p2zDd0kt8a5FUiUjtd48lYcAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7530
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table=
 to
>host
>
>Sorry for a late reply.
>
>On Wed, May 28, 2025 at 07:12:25AM +0000, Duan, Zhenzhong wrote:
>> >Third, the vSMMU model, for invalidation efficiency and HW Queue
>> >support, isolates all emulated devices out of the nesting-enabled
>> >vSMMU instance, suggested by Jason. So, only passthrough devices
>> >would use the nesting-enabled vSMMU instance, meaning there is no
>> >need of IOMMU_NOTIFIER_IOTLB_EVENTS:
>>
>> I see, then you need to check if there is emulated device under nesting-=
enabled
>vSMMU and fail if there is.
>
>Shameer is working on a multi-vSMMU model in the QEMU. This gives
>each VM different instances to attach devices. And we do not plan
>to support emulated devices on an nesting enabled vSMMU instance,
>which is a bit different than the VT-d model.

I see.

>
>> >On the other hand, the VT-d model is a bit different. It's a giant
>> >vIOMMU for all devices (either passthrough or emualted). For all
>> >emulated devices, it needs IOMMU_NOTIFIER_IOTLB_EVENTS, i.e. the
>> >iommu address space returned via get_address_space().
>> >
>> >That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
>> >for passthrough devices, right?
>>
>> No, even if x-flts=3Don is configured in QEMU cmdline, that only mean vi=
rtual vtd
>> supports stage-1 translation, guest still can choose to run in legacy
>mode(stage2),
>> e.g., with kernel cmdline intel_iommu=3Don,sm_off
>>
>> So before guest run, we don't know which kind of page table either stage=
1 or
>stage2
>> for this VFIO device by guest. So we have to use iommu AS to catch stage=
2's
>MAP event
>> if guest choose stage2.
>
>IIUIC, the guest kernel cmdline can switch the mode between the
>stage1 (nesting) and stage2 (legacy/emulated VT-d), right?

Right. E.g., kexec from "intel_iommu=3Don,sm_on" to "intel_iommu=3Don,sm_of=
f",
Then first kernel will run in scalable mode and use stage1(nesting) and sec=
ond kernel will run in legacy mode and use stage2.

Zhenzhong

