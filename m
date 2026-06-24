Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27067CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcIAA-0008KG-6L; Wed, 24 Jun 2026 03:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wcIA6-0008Jq-7g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:36:42 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wcIA2-0007x8-MO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782286598; x=1813822598;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GqNgb1QVxd4GTfka29RXbMylHgUxTavl4SZHnbhy+wE=;
 b=cw0s/54pAujvP5sG0ripo06bC83kxKhjJaCQB3kwojUf9sMB/1BRoGsS
 JmlsQIhqdC9F/FJI4DbVGSoe0bdtGukXVWHRVGN+tp4T8K5YIOUD2CJWm
 luai+3Fe2J27XvZeSwiWYBguEc3H1vjMwkwIzfYPVo029VcSwxTI7lWHd
 f+IF7iWYz5V9NnK/mrpM7RXNULfUAOD17ITPehkxgsvHZ5s4eIy46eYau
 Zls3rvKF7v/xruBiB5+BBk23Jn+vKyu041QKwIyNJYi58jKuDsGJGM+tD
 9cMCogu41l7H42nMS9xqkAckspA+jD9YmlNFtvZklCV0ogso7LvY9HiiH g==;
X-CSE-ConnectionGUID: BoeIa9jNTU6rdn9h1V7BPg==
X-CSE-MsgGUID: APz6jgwrTfmXmOyDzkX+JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82912898"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="82912898"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 00:36:34 -0700
X-CSE-ConnectionGUID: Vg4vm9qCREuZEw0t/clXeg==
X-CSE-MsgGUID: pGt8aZWyT6CoK/654rXMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="249867493"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 00:36:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 00:36:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 00:36:33 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 00:36:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIBiEszo24XXwyJVKqGhKzgokoKvAJclzgdaT8Mai3X9gduASKfcHv97vMWQ4jMsf18o8NfW5LzYlJoeuvUhD/VL9qe4eY3OOUkLn8iDd5pK0C8CFYXIevLneI3R164O/57LAw9WxVLKpkhKhfF515Prgu4WCNHjofo8hpne/YdJt/Lwbqq0j1khTl04eWTpLtTWZPZW6YyOnlnuex5HCCMfQHKsIy9iQYaIcFi57IyNHzSOR69m/BAcizdmrxI4vKSKwAuSYD4kE+vpp7viJyDeeDB4lJTAgv9m+xiDHzR2k7/dZNPO5wywqgQUwtz0JTN3RUnPvuSDEshFT9sMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqNgb1QVxd4GTfka29RXbMylHgUxTavl4SZHnbhy+wE=;
 b=Oe2BLVTRzDaUrNyqDiohZBHdRZ2WSLmrdrPCHV8AxRLE/kOc/MxRNI2qUdYD/9vrIngHoB8C076th6cKZLj58kVnJ+8XCSZ867yTNp3nLMM9I+LjMUYyLI/lh6VsvHwf/NPfmeYToD5M8Mk5XcX5fgw0AwSwNfm/GgraQIDPagtTwnMrlO62go0Lh1NdVWlHu3Y4Qk1p6sBO9qkmvmwgFM+cl93wn+Bau1mu8vDfFLeIvdhldfrg2VaQzcDRkXICmuiPKqyaDvl/0VJKHBVosM+NjRV5d8E3WTFqCCDIaVrVXfmYYVYMXYYIIYfdgDoEcSAvu/eHv5tj4DPIsu+dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 07:36:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0113.015; Wed, 24 Jun 2026
 07:36:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v2 3/5] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Topic: [PATCH v2 3/5] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Index: AQHc/tV1RCGaubxvNkiq6XmaZ7Ef9LZFY5oAgAf1pXA=
Date: Wed, 24 Jun 2026 07:36:21 +0000
Message-ID: <IA3PR11MB9136CA9966D567726745C5C292ED2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260618034844.618011-1-zhenzhong.duan@intel.com>
 <20260618034844.618011-4-zhenzhong.duan@intel.com>
 <93dce53f1cc1b1c282d9c57044c1f81ccf9f6954.camel@bull.com>
In-Reply-To: <93dce53f1cc1b1c282d9c57044c1f81ccf9f6954.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB8345:EE_
x-ms-office365-filtering-correlation-id: e2e3d851-d3df-44eb-1024-08ded1c34950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|56012099006|4143699003|11063799006|38070700021|22082099003;
x-microsoft-antispam-message-info: pj67/tnMjtd3ADzfAc6jiQVOjQHrEmtm7Ych0EcOb9EhXearxjb6NyY5Jkk/FsRCQIUgBndnKYi/WSY6QYfw5PMP7JzUusJ9bw+kpeWXbze8PtJRBsJLFi+wBpikaa7DVGEco1aiv7snSckRfAb9QsPaJURCGaoG8wbu1QnFApOUZdzyw9vLJpcmhQEF/GqI0OyM79vDV7qDg7WYXmKqaTB2Ji4sMsaVzBJBmYV9+LdDdNobG6RDKGBmc2PHLrO1nQIIbWRG8xfWH0MGRSfstZgd4N2if0N2nPGS5ZrHeN6xSZH8go6edw9mubqsxvMPK1yqObbTqkd3EwQM5X5BoadJ+tInHX+67EyVPyOz0b9XhgXDpDXI6/uN7/R0LpWBs/3JlW6f4dfI/XFCSAxzGei/EwRDofelFN8aPNVWmRzM6QxbaJC+irHXlRhiitSeLzWSZ9c2upN0QEQ8Q4bzXyWxIU22llAo0/sZJ0y9zotR/fkvC7b/m6dVhHZx3H0K03vdtHMKClzf3Tw4MIeW+XIfDwCREu6+4+3rP6rbwrxX1rDbT6etADnrtDmReTbkcfGO55ksEWESP4AXaJVMYY4oSB+/QewpqnQGVGkdjlAA8ZNuaFZ2CoFGV+rYdhKpoS8yKulpgekFx8/w3E2QwV+ZV/cUuH1hSMVYGLbgjsRk/xH9CK6R5fPUVX/JbJyzoa76dpMN7wb7MQ9keI5KwjnmZk1NlHo/X9CDQH4MsT4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(56012099006)(4143699003)(11063799006)(38070700021)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OExOVXVXY2xIQ1NsdUtSUHZRYlkyUGRSWWovMmxENjc1RzMxaXFIeUtGM25z?=
 =?utf-8?B?QWE5SWhLNzlVWmNQZ1hVdTZKRjVqZUNVdDBOZjllbkE4L2N1MUx1Y2xoZzE2?=
 =?utf-8?B?RjNtdjN2dEFhNldYWjBNOXVSL1czTzVJeFhTRUk2bEVLNmZhNXVNbER4MkVZ?=
 =?utf-8?B?ZTVXdlgwTHlVd2QweVVDODM2YVA3cTZwdE52ekp5VEV6TTFNREt6L2dOTjN0?=
 =?utf-8?B?RVo4UHBqUy9QUytIYkZDbEw4TGdsdlB2RjhIaWYzcXFDKzdxdzAwc3VPbG9v?=
 =?utf-8?B?SWtRSnE2bTBJUmNzbFNaVU1jc05aTW4vVGM2YWRjd0RDVU1UblppYXpERDlZ?=
 =?utf-8?B?SitOaGhVWlhwVTV4ZGhhTGZyMVhkY3MvVkJlUjhCV0xwS25zdWh4UWlJQndG?=
 =?utf-8?B?YXduT3hrenNvdm0xNWc1blFUd1FBZFphRVF1cmtqU1RNdklzbzg2SGlMU25O?=
 =?utf-8?B?dll5ZkJXaVdsaVRYZC8vZU12a2lESW9NcjJ2MDNzN2VKL2RPdVJpVTlOd3cw?=
 =?utf-8?B?RXg0bkpUR1QyTlVIMTgzWHhUUmZEdFZvazNqTy9Pa05Wc2N0L2JYREFDNHRO?=
 =?utf-8?B?dUNBbk96TXN4Yno0SmFlV1ZGQURzL2VFTUQxSi9zWDd2ZHRDMmZya2dLNTdG?=
 =?utf-8?B?b2xVc09EV1pYSUo4dXdIUUR2eDRnVGs1OE84dEJTazBwaWRxU1U5VEpCM1lM?=
 =?utf-8?B?U3ByUGtjTzNNUHZ6UE93YWtRa3NCR0ErdDhoNS9XYVN3UkxYYm83c09CcGxh?=
 =?utf-8?B?cUh1clkyTXB5cDRrUkY0ajk4VTVDVGFWUE9COC8zQ281dHN0ci9tVjBQQmRr?=
 =?utf-8?B?cE44bnVPU2oyWUVhL1RmbzdBL01QTTh4T0QzMEJkMHd5MVphZWpOdmJkM283?=
 =?utf-8?B?Q25UWXVCMCtRWHY5aThFbC8veGI0amIxL0VOQjBIWDJlQisxTG1xQzRwclN0?=
 =?utf-8?B?TUg3cVFKcy96cEhxVG1RR1dIYmtyYmNvZm9yWTh1eEJjTW0xTDFTNS9uWVRJ?=
 =?utf-8?B?Wjk4eE9RaUMvZjU0akNjMlIydkwvNFFoSG9SRVlNTE9DZlVyWlZub2xQeEla?=
 =?utf-8?B?RVJRMHhUbnFFYk9FWlVXOEdTTmpFOSt5NEkrcWJDRmNXRGdJVnpsenRpM0xk?=
 =?utf-8?B?NTZzRisyU2ZoRXcvYlFlZ2tkNFdTV2xJMVp0WGRTWXlKTkQ1QzJzMmJYcVNw?=
 =?utf-8?B?S1g4dU5pWitJdk1yMitqUjFhK1VBSEh3aVJTVXFvVzF5TTYrUTRwZnh6YzR5?=
 =?utf-8?B?MnhRTGFWNGZXNFV4RGwzOExpMm15VkVQaWg5UlJZWEI0ejg3ZzZHWXZJQTZ1?=
 =?utf-8?B?MzFTdHQwTm9yL29JV2pNOEk4NzlEMWVlM3AwUDd0cjRYUnl0cS81OUxOVldN?=
 =?utf-8?B?N2ozT0RPbUloL1JvTjVzcldyRGZwMlZXTGZYcHBSeFdoSk5XRTRLcjA3aEQ0?=
 =?utf-8?B?UHNZWGZhaVg2WFNvWHVKY2pzV011REsyaXhxeWpRVVVZVmV2eWdpZHhvMVov?=
 =?utf-8?B?Z1JNQ0RmZVkwTWlkMUJKY2czazRHckQxa1dDRjJiRWJVdzlNaU54WHVNc1FW?=
 =?utf-8?B?TzZ3K1R0NTVGeUZUaTRpS2lSSjR0dnBKWnFnUEQ0SnpNbGhjYjRPc0plQzBh?=
 =?utf-8?B?U1ZPSEo1azFkNWtxZWxSSEN3U0hyeDFueE96VlR4bmk1UU53MTdHRFFmN25I?=
 =?utf-8?B?dThmZWJ0TjBobGNYNlVwMVd0Rkw2T0xtY2RBVk1kTnNQenRaai84anNJeGg0?=
 =?utf-8?B?K2FmNENjRFVCNlBNKzh0LzM4YnlKelBMbkZuVjE2SS9tMnpVM0NycFphcHBi?=
 =?utf-8?B?UW9PQ0xyRTMvZnhITmU0d0RFdnQyTkJ5ZEZ1V0VlYTcrdGs3WjFOWGNqdWRr?=
 =?utf-8?B?VENVZVYvQjZXOU9MMWtBelF0eVpVY1RJRitRSzBQeEJjblhpNk5HT0JHK0xB?=
 =?utf-8?B?Nm1POFlsU3d2N0NwRGdjUzU1b0tRUGFsRjJsRnc4RUJ2cjA5VEtjSWhnL3hu?=
 =?utf-8?B?VERIZWJVdXprYzZUZDRjSTlYR0JVL2pMenVENFJVNmNFOHl3VHp6YkFPaE15?=
 =?utf-8?B?UmpTLzBUSnZHNE1sS1NVTmNDcGtFc3lvNXkzb2w2dzdETGpUYmdiRFNFdjBY?=
 =?utf-8?B?ZXVuZWxWSEQzTHRoTzlhMS9aRDVEOERNdTRIbVZyZHFzbXRsZWovSndSN2lG?=
 =?utf-8?B?V296VGUxSjRUMW5VRkxEUDNhazlENWpjQXJGQjRYWnJnTVVrUlZOVzl5cVl5?=
 =?utf-8?B?c2F4L0JOc1RvcWhZUHpIVHMrdlp4ajcwVjByamt4d0ZYa0YyL2hrb3BVSWN3?=
 =?utf-8?B?dmFTVmloL1pud2dpRW1BTld1eWJRS2Q0bDhlY2FaYVp1Y3pUYVNWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kDxMKHFnWwX6HE35aC11Wr6ISLZQxBTz3aKbTxg8OcGIFBWCsGz57yn/KJ2DHz0oQ/EB2ScT3M0Ia9f6PfAIY3AZyUmVIgUiflu+hYw0Gynsat/uBZCAWjP97vWjC8vTuw5bvA9JvcyEcXeNoPmvb1w8D+1P+DMltIOkbyv/aNZMCCPY028khFm6ef4Kmfcahh4Kc052BxUe74BbzrNnXISkIahRNdGdRZ2bEwCXbBN+Oap9VIA9qW2oQmABflPnxtDkvfQvj79bQBQo8xxVhVc9ZveV3ZwtbDpqgtxAUO0qLoxq5iwYeo3DBuR3Ktr94VncjboDgXtp6TBHenw6PA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e3d851-d3df-44eb-1024-08ded1c34950
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 07:36:21.1730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9YR2OoKAP+96PLk2rH1NK93eIEYNQZvYp2bO+IyOdZ3awwHlJYgoQgwEgDyod3VtBtpiSS6VkYVD1Q/YieKzHpF1N84bsCv/aylH7kpU+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2zDqW1l
bnQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMy81XSBpbnRlbF9pb21tdV9hY2NlbDogQWRkIFBSUSBpbmplY3Rp
b24gZm9yIHBhc3N0aHJvdWdoDQo+ZGV2aWNlDQo+DQo+DQo+T24gV2VkLCAyMDI2LTA2LTE3IGF0
IDIzOjQ4IC0wNDAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRo
aXMgZW1haWwNCj5jb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+PiBXaGVuIHRoZSBndWVzdCBlbmFibGVzIHRoZSBQUlEg
aW4gdklPTU1VLCBhbGxvY2F0ZSBhIEZBVUxUUSBvYmplY3Qgc28gdGhhdA0KPj4gaG9zdC1zaWRl
IHJlY292ZXJhYmxlIGZhdWx0IGV2ZW50cyBjYW4gYmUgcmVjZWl2ZWQgYW5kIHByb3BhZ2F0ZWQg
YmFjayB0bw0KPj4gdGhlIGd1ZXN0Lg0KPj4NCj4+IEluc3RhbGwgYW4gZXZlbnQgaGFuZGxlciBv
biB0aGUgRkFVTFRRIGZkIHRvIHJlYWQgYW5kIHByb3BhZ2F0ZSBob3N0DQo+PiBnZW5lcmF0ZWQg
cmVjb3ZlcmFibGUgZmF1bHQgZXZlbnRzIHRvIHRoZSBndWVzdC4NCj4+DQo+PiBUaGUgaGFuZGxl
ciBydW5zIGluIFFFTVUncyBtYWluIGxvb3AsIHVzaW5nIGEgbm9uLWJsb2NraW5nIGZkIHJlZ2lz
dGVyZWQNCj4+IHZpYSBxZW11X3NldF9mZF9oYW5kbGVyKCkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogWmhlbnpob25nIER1YW4NCj48W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbSk+DQo+PiBUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8NCj48W3h1
ZG9uZy5oYW9AaW50ZWwuY29tXShtYWlsdG86eHVkb25nLmhhb0BpbnRlbC5jb20pPg0KPj4gLS0t
DQo+PiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaCB8wqDCoCAyICsNCj4+IMKgaHcvaTM4
Ni9pbnRlbF9pb21tdV9hY2NlbC5jIHwgMTYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+LQ0KPj4gwqBody9pMzg2L3RyYWNlLWV2ZW50c8KgwqDCoMKgwqDCoMKgIHzCoMKg
IDEgKw0KPj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE1OCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9o
dy9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+IGluZGV4IDRhOTAwM2M5MmQuLmQ4NjFmMGY2
NDggMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaA0KPj4gQEAgLTE3LDYgKzE3LDggQEAgdHlwZWRl
ZiBzdHJ1Y3QgVlREQWNjZWxQQVNJRENhY2hlRW50cnkgew0KPj4gwqDCoMKgwqAgVlREUEFTSURF
bnRyeSBwYXNpZF9lbnRyeTsNCj4+IMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkOw0KPj4gwqDCoMKg
wqAgdWludDMyX3QgZnNfaHdwdF9pZDsNCj4+ICvCoMKgwqAgdWludDMyX3QgZmF1bHRfaWQ7DQo+
PiArwqDCoMKgIGludCBmYXVsdF9mZDsNCj4+IMKgwqDCoMKgIFFMSVNUX0VOVFJZKFZUREFjY2Vs
UEFTSURDYWNoZUVudHJ5KSBuZXh0Ow0KPj4gwqB9IFZUREFjY2VsUEFTSURDYWNoZUVudHJ5Ow0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9pMzg2
L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IGluZGV4IGQyZjQxZjE4ZjEuLmZlMDlkZTA3ZTIgMTAw
NjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gQEAgLTksNiArOSw3IEBADQo+PiDCoCAqLw0KPj4N
Cj4+IMKgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9lcnJvci1y
ZXBvcnQuaCINCj4+IMKgI2luY2x1ZGUgInN5c3RlbS9pb21tdWZkLmgiDQo+PiDCoCNpbmNsdWRl
ICJpbnRlbF9pb21tdV9pbnRlcm5hbC5oIg0KPj4gwqAjaW5jbHVkZSAiaW50ZWxfaW9tbXVfYWNj
ZWwuaCINCj4+IEBAIC0xNiw2ICsxNyw4IEBADQo+PiDCoCNpbmNsdWRlICJody9wY2kvcGNpX2J1
cy5oIg0KPj4gwqAjaW5jbHVkZSAidHJhY2UuaCINCj4+DQo+PiArc3RhdGljIFBDSUlPTU1VT3Bz
ICphY2NlbF9vcHM7DQo+PiArDQo+PiDCoGJvb2wgdnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJ
T01NVVN0YXRlICpzLCBWVERIb3N0SU9NTVVEZXZpY2UNCj4qdnRkX2hpb2QsDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVycm9yICoqZXJy
cCkNCj4+IMKgew0KPj4gQEAgLTc3LDE0ICs4MCwxNDggQEAgVlRESG9zdElPTU1VRGV2aWNlDQo+
KnZ0ZF9maW5kX2hpb2RfaW9tbXVmZChWVERBZGRyZXNzU3BhY2UgKmFzKQ0KPj4gwqDCoMKgwqAg
cmV0dXJuIE5VTEw7DQo+PiDCoH0NCj4+DQo+PiAtc3RhdGljIGJvb2wgdnRkX2NyZWF0ZV9mc19o
d3B0KFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURFBBU0lERW50cnkg
KnBlLCB1aW50MzJfdCAqZnNfaHdwdF9pZCwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRXJyb3IgKiplcnJwKQ0KPj4gK3N0
YXRpYyB2b2lkIHZ0ZF9wcnFfcmVwb3J0X2ZhdWx0KFZUREFjY2VsUEFTSURDYWNoZUVudHJ5ICp2
dGRfcGNlLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11X2h3cHRfcGdmYXVsdCAqZmF1bHQsIGlu
dCBjbnQpDQo+PiArew0KPj4gK8KgwqDCoCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kID0g
dnRkX3BjZS0+dnRkX2hpb2Q7DQo+PiArDQo+PiArwqDCoMKgIGZvciAoOyBjbnQtLTsgZmF1bHQr
Kykgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGJvb2wgbGFzdF9wYWdlID0gZmF1bHQtPmZsYWdzICYg
SU9NTVVfUEdGQVVMVF9GTEFHU19MQVNUX1BBR0U7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAg
YWNjZWxfb3BzLT5wcmlfcmVxdWVzdF9wYWdlKHZ0ZF9oaW9kLT5idXMsIHZ0ZF9oaW9kLT5pb21t
dV9zdGF0ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9oaW9kLT5kZXZmbiwgdnRkX3BjZS0+cGFz
aWQsDQo+DQo+VGhlIHByaSBmdW5jdGlvbiBleHBlY3RzIHBhc2lkIHRvIGJlIGEgUENJIHdvcmxk
IHBhc2lkIChjb21wYXRpYmxlIHdpdGgNCj5QQ0lfTk9fUEFTSUQpLg0KPklzbid0IHRoZXJlIGEg
cmlzayB0byBwYXNzIElPTU1VX05PX1BBU0lEIGhlcmU/DQoNCkdvdCBjYXRjaGluZywgbmVlZHMg
YSBjb252ZXJzaW9uIGhlcmUsIHdpbGwgZG8uDQoNCj4NCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdWx0
LT5wZXJtICYgSU9NTVVfUEdGQVVMVF9QRVJNX1BSSVYsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYXVs
dC0+cGVybSAmIElPTU1VX1BHRkFVTFRfUEVSTV9FWEVDLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmF1
bHQtPmFkZHIsIGxhc3RfcGFnZSwgZmF1bHQtPmdycGlkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmF1
bHQtPnBlcm0gJiBJT01NVV9QR0ZBVUxUX1BFUk1fUkVBRCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZh
dWx0LT5wZXJtICYgSU9NTVVfUEdGQVVMVF9QRVJNX1dSSVRFKTsNCj4NCj5XaHkgbm90IGV4cG9z
aW5nIHZ0ZF9wcmlfcmVxdWVzdF9wYWdlIGluc3RlYWQgb2Yga2VlcGluZyBhIHBvaW50ZXIgdG8g
dGhlIHJhdw0KPm9wcz8NCj5KdXN0IGFza2luZywgSSdtIG5vdCBzdXJlIHRoaXMgaXMgYSBwcm9i
bGVtIGJ1dCBJIHdvdWxkIGxpa2UgdG8gdW5kZXJzdGFuZCB0aGUNCj5yZWFzb25pbmcgdGhhdCBs
ZWQgIHRvIHRoaXMgY2hvaWNlLg0KDQpHb29kIGlkZWEsIEkgZG9uJ3Qgc2VlIGEgcHJvYmxlbSwg
d2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

