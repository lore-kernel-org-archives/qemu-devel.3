Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F27ECF6491
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 02:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sujvm-00076j-Bo; Sat, 28 Sep 2024 22:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sujvk-00073G-Jc
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:45:04 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sujvh-0006qy-Km
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727577902; x=1759113902;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HUAhbWI3Ji85Cfghca/x/tfMSLB2uQQJCrOnu1VtPiE=;
 b=l5cHTBDMOCeZ0BCixj35siTb3bSmrqqCsyeNPwXsL+I3nQAIsa3a8Kkj
 THolvkfsHCC3e/vnChs69Jk/GOERjalEdVa5vEKgh1q9CAUIdS9Ymgixh
 Up/NI6pOmODGD1OYnTrv87ayW97Jk1ILbj7Ul1zF8MFmsju+RSoXgOx1u
 2c4zYPXTb8v595p+FanaDfo+gOIoEvrm3qDn5kfamC3kR55r7kfvB5BZ0
 CK4+4mWEqsFDVx0mg+rb2E0tDYUsAdlazK9fqMG9Tlbi6uXdZTtKqoIgR
 sS0MJ36Yy8iQVUh9LvgFyCVpu62qe9opzu/RL0/VFkuoqPJfl02ncrIYJ Q==;
X-CSE-ConnectionGUID: cXUCJ5UASJ+7/wA49rqTJQ==
X-CSE-MsgGUID: edHwOXaZRbWQnoNuUq58Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26494704"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="26494704"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2024 19:44:58 -0700
X-CSE-ConnectionGUID: nucpH9xaQfy3ulNlB6xpDg==
X-CSE-MsgGUID: 7iot1HTSQw+2kPfI5/bSOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="77448871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Sep 2024 19:44:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 28 Sep 2024 19:44:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 28 Sep 2024 19:44:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 28 Sep 2024 19:44:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 28 Sep 2024 19:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGrabk2JoS4QBiLlivYYOXJNlW6lKo/bAolj57N+rwHCc6bjV2zmflZoFSJHk2eyLCIoGUjQ4kfwIsD/UNIQV4bvydxJv+tqHhBMTW7yR0YIxoMIiCxTPYMjwqoZfLlbfRsuHGr6qjBtw1E7fGjTsRHPeTFynoZJOyE5Pyb33HcBMskqSEhLOK+2+0VNxkq1lZnjZGVnw9uYFyNEUB6gcbL6IOnQQ71zxKP2j6Nd8XQN8VxnS5W/BQOO8vMJNgmHwajnQu4eyHo0tDAE9cnXvawRviuJmJMS/6llOpqc00SwMdtiwR1tLQCJUQlRDnTnK/1zLtM3hm3R4fYUB17ZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUAhbWI3Ji85Cfghca/x/tfMSLB2uQQJCrOnu1VtPiE=;
 b=tfhaAjbCuoNspWobP+QxYqsci36OqIGhzO/NNVp3pEjn2kxOiGw+/W+0ezgiOpX5hkq6yhRYAvGplnzM7qNyi4SFrIRiZkXSnmggvF/7MNC3THkuNkr00jFszChWF+8Ay6PMcGThkN6X9cZy7/CzXLG4WWcUunlVQLmYyYuaHsc8OQd3bxvS//NEnAL3BFAKVfv/ddWGdAmP+pH5c2SqpsK57lzi/af1IQ7LfMiOwi9UBODd70rhskO7D/k9r4VER6BfYYYJSyIKKoxU+FWLdOI1Irthu2QVT4vN4o4iNpKKusUupeE4w/HSSIQlLHWX0/F+lZ7kometmVqe9zlBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 02:44:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 02:44:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
Thread-Topic: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be
 string option to expose scalable modern mode
Thread-Index: AQHbBAtHdaavab9yLEu2iYSTDuFy1rJrHayAgAAd3fCAAuMJgIAABkmg
Date: Sun, 29 Sep 2024 02:44:54 +0000
Message-ID: <SJ0PR11MB6744F7B57D686541929B02C492752@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-16-zhenzhong.duan@intel.com>
 <CACGkMEutsgWhp0mrCG6A3QA1NXnMj8RFDHMKPq3eBv3WxaQ=Vg@mail.gmail.com>
 <SJ0PR11MB6744EE9C94E4BD7FC7275455926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEvM1XHr-9Fyts5SZdwkhVh4rf=J-MjD5ZBPUcKqJ1s0dA@mail.gmail.com>
In-Reply-To: <CACGkMEvM1XHr-9Fyts5SZdwkhVh4rf=J-MjD5ZBPUcKqJ1s0dA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 10b5b9f7-fcb2-449b-a452-08dce030b321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0JDZkVENTZCSXdFOXZheUR1aS9mS2tEQnI4dGxQV0o1S1RtUjZrNExBblZo?=
 =?utf-8?B?ekFoRml5V09wV2hHZlk2K2ZibFA2WlJ4SitjL3JqcVF3TGk4VkFGVGJhdUxX?=
 =?utf-8?B?ODlzbFNMdVdQZVU4WE0rVzZRbmlSQXdXa28yMDNmbFVMb1RQUEFmL21KUU5s?=
 =?utf-8?B?Z0d3ZDRWZDRjaE9wNmFlUGJoYlN1aFMxS0gzelVFUmN0a1FoSHFNNXIvS2l1?=
 =?utf-8?B?Tit1eU82WExFRFhOYjh6WThZK2N2blgyYldTSlpVZ0d1UUZXbXdGeENXaytI?=
 =?utf-8?B?M3FkajdMSFlPaFdsTXlrUmhHcmhGZHhQbS85SXNHdzV1d0hXMEdSa2lvWjQr?=
 =?utf-8?B?NkpVMEd3eHRGaWF3dWsyUzZISHpGQWxkcE9EREpmaVNyUnZ0Rm1pWXlKS1ls?=
 =?utf-8?B?eVJWa3BkVlRDNmNmdzZaa1R4dzFXdTNFRUZtT3ZldE9vME80MmdiejUrZHh4?=
 =?utf-8?B?cGRENTZ5VXYya3ljTjBIZ2ZEQ056TjVZeE4rRUllMDF2ZmIwWU9VWEZ5S2tE?=
 =?utf-8?B?NXVSUGx6ZzJIOHA5L2d5VUNrYXRETDhKc2E4dzluN2hqVkRpQVhnN0Uyam5a?=
 =?utf-8?B?MFhmcHd3QVJMVkhjR0NwVXpiV1NjRU1KN0xqQitxUk5UQTB6QUp1bW1EejRy?=
 =?utf-8?B?eENuSjNEanV0YU5XRnl4L1FPOHZ6dXB5RHJ1VVp2V2xMWDNQMWg5YjVyUUpY?=
 =?utf-8?B?Zm03aUNHTXl0ZXBHcUZaT2FhaHlDMWFwN1pnZG5KSWovQUEyMlJYYjFrWDhQ?=
 =?utf-8?B?OG8wWTlPWnVJQkE2cnl2cXNtcjZnR24rbmx0Z2o3Y3pFc2trMXk1alBKRVlF?=
 =?utf-8?B?YnRYN3JtNmMvSFRwak5HVGRSYUJETGpmYk1hL201TDlzVVBIejNiL1c1bjkr?=
 =?utf-8?B?c1BHb2srQlJxNk5pYmlKMmhhZ0cybTJGbnBCZGM1YlVSTlZRL0plN25xQVlU?=
 =?utf-8?B?SU1KYUNyUi9PSGpockdCUEZjT09xRWpvSHhsenppRkZBeW1FZTFKWVpMU0pP?=
 =?utf-8?B?R3BpUTlSODZDM2gxUWZSS2JXbFZKNGpwdmVaVTZGWGh6S2NOY1puNzg3NEtW?=
 =?utf-8?B?MXluKzhBZ1FLdksyRjNobnpraVRhZEg0d25FM2RMY2JPczRFRzdpM1ZTVHJO?=
 =?utf-8?B?bm92Y24xMUU3TlphWURvUEJnODVIVzdwZEJaVGdPL2ZEeDliTHRyVU82ak56?=
 =?utf-8?B?V3FBUXkwd2ZpUjNIMUNwOXZkQTV0Ym03M1pZUEthOWE5SmpMSXV1M3RlWkU3?=
 =?utf-8?B?US9wWTBYeHdxSGRLRDd0ci8rOGdNeEMxRjdhK0gvVFJKRjlTUmc0NU10cmQr?=
 =?utf-8?B?b3JIOUhtNjlFV3lPTlU1RnFMb2FqMUlsL1VWdHFkTzdFb2pLS0c3a1JZajhq?=
 =?utf-8?B?RFh6cGxFQXFmZzR0RTQ1czJFaXhMNDRnN2hNUDBsY01JN2VJcjJZV3lHZWNi?=
 =?utf-8?B?cW5ySUljZWVIaDR2dWQ0dllZSXpVQkh4aVpIdENmMUlOcWpqTVZwdi9hNStn?=
 =?utf-8?B?UHdadVByRVFnSU5JTjBpcklxWUhJQVhraVJkdjZXTk1BdnRyVExGNkZKbDNp?=
 =?utf-8?B?VVJwTFJjTWlnMkpEZmdPQndVWHNBMSsrTEY1eVIxNUt5WSs3c1pXTFFYeGNw?=
 =?utf-8?B?bGI3TnU2dy9wVlVHd1hCSkQ5S1dCazU3T214S3FlN0ROaUZJWTY4U3B6Vysx?=
 =?utf-8?B?NTBxSVg2Z29lVTloVHNIeVMzSy9vb1N6WVBkRVNGNDQ3enVmck1RNGlBbEtC?=
 =?utf-8?B?NkVVMWpGNmkycTVUZVE5TDd0YnRmcXZLMHEydXFRMkxQRU42MlU5TFdMd1F1?=
 =?utf-8?B?VFRCU1FDZFoxU0xLRE9XQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anE2SmppZ1RhZjJOK0JaNWpuZHZQcjhLRWxMRVAyRjNWUXF3QnZUUHBTcDI3?=
 =?utf-8?B?L1ZWVWp4M1BoN1c1VEdIUEVwYThLeEYrZmpHRXJjNG4yMWJMNTkvd3BncjBw?=
 =?utf-8?B?YktBOHhKWGxUTThvTFJ2MTF5OGc3YXE1Y1k2RFQ2RXNxRFoyQmNSb1g3SHls?=
 =?utf-8?B?d3M2QWN2eDNMb2ZhMWtZMEFJbnRPMFZ6aXU3VzgyU2IwSlExWkM5ZmFuR1k4?=
 =?utf-8?B?ZEFZaG1iR1hTb3JPUzE3MldkZ2tITU83T2VkakNZSEZpRDhPczhHd25WVjA1?=
 =?utf-8?B?U29JRHlJYllPZkxtZGYwNXRUdVl0WVRvN3JvU0NHcDNZUTQ5RlZNeTJmaDVP?=
 =?utf-8?B?bExBN0cwbGtZampNRERqdFAyNmRURzlJbmlKQXFUSzZ4b25CcXEzMHZ5NlVF?=
 =?utf-8?B?dm5xSVV0blpLMGJWd0dGY1BtUmRSMmhValZDVDJJcDN0NFZyUjQzV01wN01p?=
 =?utf-8?B?eHRXck1kWVNaMDJ4bUxGdHlFVzA5K3VGMnFSN0NCYnpYL0VKdUM5YzYzQVBs?=
 =?utf-8?B?NTM2Y2ZzTFdJeGVPNGk2YlBzdzltZ1ZZTFhwT2t3T1EybXR0MUFyWi9Vc1pw?=
 =?utf-8?B?QUVVM0d6bWg1allzTjV1OFU5K2pNM3E1VExmNmVkTU1PbUtmeFRHUm42ZTdN?=
 =?utf-8?B?U1JmODdsZFUxMUxHeEQwdjlYQWd2MHM2bmU2Sy9LQnRudU41RHJVN1U0MGh2?=
 =?utf-8?B?U1dBdmFObjRhWElPTjVFYURvNzFvaWFFWFhaVlgwOVhaYmc1UWFuS1YvZHJR?=
 =?utf-8?B?cUx3ZXlQaERYdG5LZEJmRGZlajJVbnBYcXRvcGYva1o0UmJ6eXRsUjczb3dw?=
 =?utf-8?B?QmZwVWdBNkRIOUJuSzR4eHBaVG4wZHNDQWR1cWswZEpNWmk3dUl0aTJxK3hx?=
 =?utf-8?B?bDNGMytEVmhNTFZpTUdtQ3JwUnhMVGlPN01wZTNiN3pKM3d6TEh1RkJMcTM4?=
 =?utf-8?B?cUZPb3ZvcDUrSXl4eFdJTVlJMzgzdm42YXhYV0Q4eUFxTFdZVS9DeXlaVGxt?=
 =?utf-8?B?QURmeUswdkNDcjlRdEprT01oL3VjSWNCQ2xNTkhYaCt6R0lmWlE4M0JISkgv?=
 =?utf-8?B?Vk1pcUZrWUkreWpxS0xlRnFPZ1NFLzFnbEo1OVEzMGFmNEh2TkpZdWo1QTZU?=
 =?utf-8?B?NFV0c1k2OHNGa0F3S0laNUVUYStmR3p1enJLSkF6aDBUa0dWcjB4T1dqVXhl?=
 =?utf-8?B?Z2NPbkdlMUpaK0JYSHYyejBaRTFZVUhHR0RpQk5aU3V1Q1dUVmVncWF4eXVN?=
 =?utf-8?B?UU54M1J2OW8xZnM3L2xFQzFOZk44WkJyVm0yY2c5L0xoMzdIUlV2V2dYR2p2?=
 =?utf-8?B?S25Hc0d4Z1pUdy9lTDVCa2lMd2dtMnlWRGxmWGcvdVUxMzROZGRDZTRHamRW?=
 =?utf-8?B?a3JXZUx2R1NLNXpnaTlLN2o0RzNRbHJLL05wemRrSERYS29hcW1MZ1F2UVBY?=
 =?utf-8?B?azZxM21DTE45a2dqaVVuT3pyMitmY29RK0ZkYkYxRExpalZPbnhqd3o0VXlU?=
 =?utf-8?B?aXFYa3VNOW5MSis2NXJnV0dzbzArZTl5Q1JsWVBkSzAvb3hwaS91VEhlVlJh?=
 =?utf-8?B?TExOUWtCV3psbGcxKzE4bWxhM2xKRkdNT2MybjJtR1BHWS9TRFh0VklkZlFt?=
 =?utf-8?B?eGxndzBYV1pXOHFOOEs3Y0hZaVI0RFB6b3RtVkQ0UUpsc05FMzcrNjZKY2ts?=
 =?utf-8?B?ZEoySk9wWUhnVXozc0ZCQW93a1o0WmVDRWtRUTNuc1hETldnNTNLOUx2OUtH?=
 =?utf-8?B?NXFRQ2VmN3F6ZjAxdTVUL1hLQ2VucnViTW56RUt0VjAvTXAxNTFxeG9aZldr?=
 =?utf-8?B?RzBibWRBalgvdFA5TWlneFBPT3M0Tm1qYWZHWVN2ekxsUXhBbmVCbUMzckpi?=
 =?utf-8?B?bHJpcWVVNXBRdE12UllXdDl4aUVwcTdZSVhzaFp5akZNZVc1SWRUanhBME8z?=
 =?utf-8?B?TE4yb21YcGU3dkZrRnRYK0hBRElJRmNKSGVIeFRGdnpWemxkeEE0UTVrSVNy?=
 =?utf-8?B?Snd1aDJrM0NDWVlqcEFwOGdrQjRtdWlncjc1ZXN3MmRjYjVvTmRWa3FtNDVj?=
 =?utf-8?B?TlJRdFRoQmpUUkh2M0VOem14Y3l2MUVObW0rQ2JBVHdncjN2MnQ2dXhPUGhG?=
 =?utf-8?Q?29GJeqU0gCTA+v7o4mpydvQF6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b5b9f7-fcb2-449b-a452-08dce030b321
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 02:44:54.8110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T20xnZZppct5jzp7mpNRxi0kYEN/t8AxyXK/3tBi2gymmxEo2TYcsOvd3MfbrJQEJ7c7NOApUDjKTvm4nTIRKBnQ4fjd4RGwT4le12b/z4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxNS8xN10gaW50ZWxfaW9t
bXU6IE1vZGlmeSB4LXNjYWxhYmxlLW1vZGUgdG8gYmUNCj5zdHJpbmcgb3B0aW9uIHRvIGV4cG9z
ZSBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPg0KPk9uIEZyaSwgU2VwIDI3LCAyMDI0IGF0IDI6Mzni
gK9QTSBEdWFuLCBaaGVuemhvbmcNCj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToN
Cj4+DQo+Pg0KPj4NCj4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPkZyb206IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+PiA+U3ViamVjdDogUmU6IFtQQVRDSCB2
MyAxNS8xN10gaW50ZWxfaW9tbXU6IE1vZGlmeSB4LXNjYWxhYmxlLW1vZGUgdG8NCj5iZQ0KPj4g
PnN0cmluZyBvcHRpb24gdG8gZXhwb3NlIHNjYWxhYmxlIG1vZGVybiBtb2RlDQo+PiA+DQo+PiA+
T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMToyN+KAr1BNIFpoZW56aG9uZyBEdWFuDQo+PiA+PHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gRnJvbTogWWkgTGl1
IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiA+Pg0KPj4gPj4gSW50ZWwgVlQtZCAzLjAgaW50cm9k
dWNlcyBzY2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFzIGEgYnVuY2ggb2YNCj5jYXBhYmlsaXRpZXMN
Cj4+ID4+IHJlbGF0ZWQgdG8gc2NhbGFibGUgbW9kZSB0cmFuc2xhdGlvbiwgdGh1cyB0aGVyZSBh
cmUgbXVsdGlwbGUNCj5jb21iaW5hdGlvbnMuDQo+PiA+PiBXaGlsZSB0aGlzIHZJT01NVSBpbXBs
ZW1lbnRhdGlvbiB3YW50cyB0byBzaW1wbGlmeSBpdCBmb3IgdXNlciBieQ0KPj4gPnByb3ZpZGlu
Zw0KPj4gPj4gdHlwaWNhbCBjb21iaW5hdGlvbnMuIFVzZXIgY291bGQgY29uZmlnIGl0IGJ5ICJ4
LXNjYWxhYmxlLW1vZGUiIG9wdGlvbi4NCj5UaGUNCj4+ID4+IHVzYWdlIGlzIGFzIGJlbG93Og0K
Pj4gPj4NCj4+ID4+ICItZGV2aWNlIGludGVsLWlvbW11LHgtc2NhbGFibGUtbW9kZT1bImxlZ2Fj
eSJ8Im1vZGVybiJ8Im9mZiJdIg0KPj4gPj4NCj4+ID4+ICAtICJsZWdhY3kiOiBnaXZlcyBzdXBw
b3J0IGZvciBzdGFnZS0yIHBhZ2UgdGFibGUNCj4+ID4+ICAtICJtb2Rlcm4iOiBnaXZlcyBzdXBw
b3J0IGZvciBzdGFnZS0xIHBhZ2UgdGFibGUNCj4+ID4+ICAtICJvZmYiOiBubyBzY2FsYWJsZSBt
b2RlIHN1cHBvcnQNCj4+ID4+ICAtIGFueSBvdGhlciBzdHJpbmcsIHdpbGwgdGhyb3cgZXJyb3IN
Cj4+ID4NCj4+ID5UaG9zZSB3ZSBoYWQgIngiIHByZWZpeCBidXQgSSB3b25kZXIgaWYgdGhpcyBp
cyB0aGUgYmVzdCBvcHRpb24gZm9yDQo+PiA+ZW5hYmxpbmcgc2NhbGFibGUtbW9kZXJuIG1vZGUg
c2luY2UgdGhlICJvbiIgaXMgaWxsZWdhbCBhZnRlciB0aGlzDQo+PiA+Y2hhbmdlLg0KPj4NCj4+
IFllcywgSSB3YXMgdGhpbmtpbmcgIngiIG1lYW5zIG5vdCBzdGFibGUgdXNlciBpbnRlcmZhY2Ug
eWV0Lg0KPj4gQnV0IEkgZG8gYWdyZWUgd2l0aCB5b3UgaXQncyBiZXR0ZXIgdG8ga2VlcCBzdGFi
bGUgdXNlciBpbnRlcmZhY2Ugd2hlbmV2ZXINCj5wb3NzaWJsZS4NCj4+DQo+PiA+DQo+PiA+TWF5
YmUgaXQncyBiZXR0ZXIgdG8ganVzdCBoYXZlIGFuICJ4LWZscyIuIE9yIGlmIHdlIGNvbnNpZGVy
aW5nIHRoZQ0KPj4gPnNjYWxhYmxlIG1vZGUgaXMga2luZCBvZiBjb21wbGV0ZSwgaXQncyB0aW1l
IHRvIGdldCByaWQgb2YgIngiIHByZWZpeC4NCj4+DQo+PiBBaCwgSSB0aG91Z2h0IHRoaXMgaXMg
YSBxdWVzdGlvbiBvbmx5IG1haW50YWluZXJzIGFuZCByZXZpZXdlcnMgY2FuIGRlY2lkZQ0KPmlm
IGl0J3MgY29tcGxldGUuDQo+PiBJZiBubyB2b2ljZSBvbiB0aGF0LCBJJ2QgbGlrZSB0byBhZGQg
IngtZmxzIiBhcyB5b3Ugc3VnZ2VzdGVkIGFuZCBrZWVwIHgtDQo+c2NhbGFibGUtbW9kZSB1bmNo
YW5nZWQuDQo+DQo+QSBxdWVzdGlvbiBoZXJlOg0KPg0KPkFyZSB0aGVyZSBhbnkgb3RoZXIgbWFq
b3IgZmVhdHVyZXMgdGhhdCBhcmUgc3RpbGwgbGFja2luZyBmb3Igc2NhbGFibGUNCj5tb2RlPyBJ
ZiBub3QsIG1heWJlIHdlIGNhbiBnZXQgcmlkIG9mIHRoZSAieCIgcHJlZml4Pw0KDQpXZSBkb24n
dCBzdXBwb3J0IHN0YWdlLTEgYW5kIHN0YWdlLTIgY29leGlzdCBlbXVsYXRpb24gYW5kIG5lc3Rl
ZCB0cmFuc2xhdGlvbiBlbXVsYXRpb24gdGhyb3VnaCBzdGFnZS0xIGFuZCBzdGFnZS0yIHlldC4N
Cg0KQ3VycmVudGx5IHdlIG9ubHkgc3VwcG9ydCBlaXRoZXIgc3RhZ2UtMSBvciBzdGFnZS0yIGlu
IHNjYWxhYmxlIG1vZGUsIG9uZSByZWFzb24gaXMgc3VwcG9ydGluZyBzdGFnZTEgaXMgZW5vdWdo
IGZvciBjdXJyZW50IHVzYWdlLA0KdGhlIG90aGVyIHJlYXNvbiBpcyB0byBzaW1wbGlmeSB0aGUg
bmVzdGluZyBzZXJpZXMgaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhl
bnpob25nL2lvbW11ZmRfbmVzdGluZ19yZmN2MiBmb3IgcmV2aWV3Lg0KDQpUaGFua3MNClpoZW56
aG9uZw0K

