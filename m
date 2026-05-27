Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5387FCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 03:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS4q7-0007vU-0n; Tue, 26 May 2026 23:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS4q4-0007v6-Oo
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:21:48 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS4q2-0005eH-An
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779852106; x=1811388106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mPUpRUhYJp6sXdba6MqcmTXVLlLMvyd8UXzPV2xH41c=;
 b=Q3FVfBTJp/ZviBBxR25uViE8zwDdvoI0QAXEfmTOBpcEYNJy+vXF45EV
 dsp3JJW7psKB2WINnSoryuUqQuI01WnULeKFleAPfcWDPujq1ZS7niUHY
 oGFjaQgADrxVpoLEkLwXZBw5BzDSvgM+a60lxZRL+ImiMS+FQVd+oPlgt
 0o8b2Z534ahCaRxEM7zDNtmvj46bD9k/+IkTODB0xHxKB45+YJf99ZmCT
 yLM5fizyCp9DgaDl7nc/QbJhqsTTEJfcwvLjsDttsKhgmsokvViA591k8
 HBYJK6Klwg02T0PcLSfUVc1O/0SHqbyEk26CShSL3n//XXptDhfIDGnmq Q==;
X-CSE-ConnectionGUID: Ov9liykCQi2Wmx5Tj0xxsQ==
X-CSE-MsgGUID: gJqd1FZ9Sa6px+lWIueGnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91366641"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="91366641"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 20:21:42 -0700
X-CSE-ConnectionGUID: u0cci81AQpeIgOjVtpMo9g==
X-CSE-MsgGUID: CEQRlrEFSXKlCZjvJrvW/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="247056247"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 20:21:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 20:21:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 20:21:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 20:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsLpaMXOItrYxllS/hzbVDA426M32Ty/gMYbyVzTRhHJW7MItg6wljb8jeP/QCym0CPv1xN7FTq7HOxwWJ82gxM5Bwhjmp/Gfrv/DnM0RA1HNEK3BOjfziUc6zqnaXPvXjoceTbV1ks0H05Zx45toXjkr9/zorWHTWJzUAIMHkRwvIn3KmJr3qqpQ8zf9VaM3oHW+rtu5+MTB5zI8ppm+IDuPzLtz/GqnWh1z3yUqfea3A5xmIgRobFsoBVd2B+Pl32lfGYafg4Dpe3w99BPQJGGl/pmGdLH0ARHS8cTv+Kzcm8I6AFCnWyrmnCWsaPAOtGcbPGIWnBDpzROP52EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPUpRUhYJp6sXdba6MqcmTXVLlLMvyd8UXzPV2xH41c=;
 b=Aq0tT/MgsGA9FYpvfdrUFIK89xA9wNMN0yGeAjhnPYomHUtxN4jErJmhFWKftDkLGAJ8GtkYKCgBNhB+eTF6FwyTimVFYBhLr3hMdKABoBbufHpPhNbrG4FHRPezSfkJczoFNlVBGzEFUz0Ahv0Sw+suAfdcZ9vIcM3G43zS6LsxeKo09Jv+mX/3zES10VhxOlsWdnVCEEgG0/IBajAqg0fHttNEGVkaX3ibqU2lii0k2jL7emX4l/e0iVoFBebh1DYm40z39kTkX9uexMyPzerBZMzeXL2XmOG2sR79GY8Oxw/3mYsZxc8iBInBNkDMLrFJBc7irID26qbRZLHiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 03:21:35 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 03:21:35 +0000
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
Subject: RE: [PATCH 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Topic: [PATCH 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Index: AQHcvZTO5wEPsjNWAky2yi5eu1ixLbYYktoAgAkBpDA=
Date: Wed, 27 May 2026 03:21:34 +0000
Message-ID: <IA3PR11MB9136686B2E3807BD3131FB0892082@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-2-zhenzhong.duan@intel.com>
 <c95ff720-d821-40d7-a091-a909394f58a2@intel.com>
In-Reply-To: <c95ff720-d821-40d7-a091-a909394f58a2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: e0571647-5c37-4846-d1d6-08debb9f0e7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: K7umQi9qeHblqOPmx7htjv0HCyYxJYFYMTNIhDvRv50LG+rY8gCak8OX0tZmVdj2n6KznIaZgn0L2sBT9GDNtYGC7Lpw/PWMEYV207vfhPLBsjPCEK/7jq1OvspUksOMdcP20vk/3AReDqgTSFyMIZDKgPoDIRoY/DpVzluIScoFoKOUB97bNcsM4QyPJv/p95qfwO94MLgjum840DtJJbYj3NANGtKA+3Z7RhYhzZf9MjmdwkfIsWOenRQOxxpSxd0+95q83j2eOTVPksFeuKP8VLom5eq1WZSpqrdtozls4/q3nimzV3sJspCcL/XA4KepqsFbY9onfev0GfbhVD+Ih3CUmHo9lQ891648HA+nf1zfWhW2yP/zEclXUKsBKySDqr8K78VrR5YDLjrW7sDk07eFTFPIXiQeYVv+B4A6dzg1JXEuozSD+axolg1c1R3LyOCmRqOJfY00qs9QPhe664pl/gx1ty232ZGVp/zqAM9ZKMhy4wIsIcF7lYwqTEzGOIBXwHpQte9XZnwmYcjP/z8wGwbX/SK7jO7RxftbZ5A9D2LUBX8XWAtXjHbUOkoWzjc0P/LtbJv1kq9fEVeNgbPk0crk8qL0Hhil3ijz3AQcnbg2WNuEX9QEBLabkqPpsRVpDYZ/ruWSefpl6XjcxT+aAwo3iismls+iJA6wnaXHciEdbosWASlqXv8SRFQp2f9CPMyVwRC1xnmk6TAJvXiDfIm5Q13dW/xf8KCPTSzMR4Nt01dtWBii4Wui
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eml6cTNBeUc3dkVIcXJLRXhwOEdackdONnFjUll4dTdsVUY1TDhaZnBjZ0xE?=
 =?utf-8?B?MDdnV05NRXAwc0pWNU1KL3RYNTR5T2NpdzhhdU8wYXVxdFI4VDJWQjh6MEhv?=
 =?utf-8?B?anl0aytnZ1VUampFVVlpNkN3YnhtWnViWEpiTzJjSDdrSUhiZDh2T2kwMnBZ?=
 =?utf-8?B?bTFYYnpOMHpNbGF5amJPSEg3cTVLRDFSTmZJeWFXVmd1eFQ3T2ZqenpGUFRv?=
 =?utf-8?B?bW92dTNlNlNWRFMyaXpVdWhvSmFNRmZZdWhFYzdKT05ObEhBM1hrTkllRis3?=
 =?utf-8?B?ME5tK3RoeG5vRk52MDVYamFMdTg3OHR4VHYxRzVrUkE3cnBEdHVWNmc4a2pO?=
 =?utf-8?B?Mk15bGN3aDY3YlFMSnFkTGQ2VDdzSXlvTE05UkNYVnVQVkZEUE9uK0daSTdv?=
 =?utf-8?B?SnpyM3ppV3duZHRSbjhyK3EwVTY2emwvK3h1V3pNZ1JoRGxiQUZ0c1k4ekJo?=
 =?utf-8?B?b1krT25sSldZNjlJVStVdlZxTHdRd2c1VmF0dm1CYmdrM3BmRmhuYVpkeTJl?=
 =?utf-8?B?bzRzclViRjhtTzZmb1k5MFF2dEE3Y0xSWDhuS3hJZE9rREZMNVBjSWxJclBw?=
 =?utf-8?B?UVM5akZHQVFVSFhrUll2c2RXcnhHVVFEaUNvTVdiWHZBWUlPeVB4WFRsbmZz?=
 =?utf-8?B?SllxdDNIM3NVS2E0bWNOaUxOcUZ4aUFBeHNJOG9wcjVHMHZzaExqV2tMcHFF?=
 =?utf-8?B?WmhCcGN5dUZhT3VsYjRWV0JnU1dnSnIxMitiZlpjUllwZThUc0VSTC9VVEd0?=
 =?utf-8?B?ZkR0NG91K05MR29Xb2ZmOVVIN0Q5clRSSmZtSysvRVNIS2k0ckZCOGdaNDlG?=
 =?utf-8?B?WHJ5WEZtWXZVTmV0c1ovNlJFUEhabThLc2t5UDlQU0ZzUGIvNStqTTRPdG5J?=
 =?utf-8?B?YUp4WXRveUNvdFlWSVM0Z2JxSE5qSkpaUE80cDZENHBDMzRBODVsUytBWlFn?=
 =?utf-8?B?OWZMN09BeWVXMTdqZmIyeDhCdGtTVEVvUXgwS1E4OHZ4M0xtMitrMUN2cUdC?=
 =?utf-8?B?R0JFc2x6NWVlRVF5S2tVRmt0djIzUjVxN3NOajBURjd6cEVTV0tNaVhLL3hX?=
 =?utf-8?B?MWo3RzhEaE5NY2ZmMHpmaWg0bEZLYXZuVFlSTmtmR0ZJOEJnK0FrRlB0SU9W?=
 =?utf-8?B?dW1icUU5RFByZVh4djRFQ040UkcyRXJrMzJ1Q3l2TEUxR3crUGxyNlJBNUJV?=
 =?utf-8?B?WWQ1c0hXUGJPK0JTYVlqeGJNTHg1QzZkSWcxaTc0Q1R5azE4R0VLN2s3bC90?=
 =?utf-8?B?OVRhUUxUSEtoN0VYOFlHRkN1UjZkOFZYVnRmcUpVTVhRakdBUE95czYzS2Fr?=
 =?utf-8?B?aU50YlFLL0kzUnNFTEdIaXNpNERSdWFuS01VcnJVQ2ZyT1ZZQVhFQWhXSTZL?=
 =?utf-8?B?Mm5kWlVvOTA2ZG1KZ29HNS90SnMxVnhuM1F4U3JCaEh5elNOK2JnL0tvZWFx?=
 =?utf-8?B?a242bHJ6YnlkTFk1cDZSazlLZEN6M2dqZUxKMVBWZUh3d1dOWFk1WFFpR0ZX?=
 =?utf-8?B?MGJlWFFvY05IREVwV2ovUmJ0NjlHcTA0bFY1ZXAvYURqb3NVRHpHd2tvNHNR?=
 =?utf-8?B?eGxXNkQ1ekFxaU4xTXU2ZjFmSEJMOEtsMEtjU3ZvYnlYWElObzhYV0cyMjRY?=
 =?utf-8?B?MmthaG5LYUxXandMVHowRmV1UjBDdXJqcFBWTjA4VitGaWxBNFRRMVdBZmpB?=
 =?utf-8?B?dm83Y292WWFPbndPQ3E2SC9vN0JpWE96UWRvbTB4SkZONkEwSnVmN1FVclhj?=
 =?utf-8?B?Q3VXdVczdFJFRHFpbVcxbXA4NWJpN2dkN1daMGFmNzcvWnEwL3RBOStYVDFW?=
 =?utf-8?B?M1FlQWZHckl3TktlVjRxVzRvUkp2ck8rcmFJWlBQNVBTR1AxUW1SU0QwRCtP?=
 =?utf-8?B?VXJoTU5ma1lxUERKK3VqZ0hNNHNYZzBqV2R6bjdMbGFvQVZWRDlqYUdIZ0xz?=
 =?utf-8?B?MTJKeStLTVdRU0ZCU3d3K2JrVnVEdDROOWFJSVltckI2SGZvUFpYMVg1eDBP?=
 =?utf-8?B?S3Izbk5UdUlvU0lmRzFYNzRxcVEyaTFJNHd1cW9venIvRnVoVktCVjFHbHA3?=
 =?utf-8?B?blNsT2VsV2x5QWx0bU1WdE92UVMvazc5YWl1aElFc0ZqNklzbFlTcG16em5B?=
 =?utf-8?B?SUJMWXhzaXpDK0dnbmtKZjA3c3dCVktwWVNyWHJUNTNMUW1aRWpheXNkdEh0?=
 =?utf-8?B?TlRHZlkrSDdjem9MWmpCUnM4b1kxd2dCZ05zaEFWTksxY1U0bFltR2Zzb3A0?=
 =?utf-8?B?RmZyd0lLU0YvcWdGRnBqK0NvY0VtM0c3VmVYc1o5TkVHS1pIZUtNOXMyUmgy?=
 =?utf-8?B?UGNTeWRTOGpMTHZOUG45NkxBMHJLdWo4a1FxOTI3UTVwZlU1anlBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F9S7BDs5z2UCBhS/wK8kElHe5UR53xgygSnOFONSeN3bPk5JZ8kRSvWCFoC7II4NU7E3/sk699l8TjHGrA4tbm/y3vS9Fxr5fn1ay7p9vFYFW16+g+XcIcClswtpx+4ZVjIls36zPkV7iqlPxqFHNsuEP9OgQG0HrbH4hDgridUhiyePIMdfQGdD0MDJELSrqAOfODO3b1Jp9GOezdr1DIofeszU8Dq9ZcBGvNGGBB7ddibWNyxYHzPV1YxU2LwJpADAda51hRMceQf3QxXlP2rrxMrj/14YExUtITiZpRJhy7t1HfMWiLWKwTqhISh9RPlsVakjxcPxRQtPknFWjA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0571647-5c37-4846-d1d6-08debb9f0e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 03:21:35.0235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zVxcmtytb0v/uRQEEMEdA/OL3Atp6YSGCXLO+5H+sz2hAbpTayNgTG8AAkQGFPbWyBR7CmBNmS3VCQkBTUx5tz7rexnWBsn6TrWFMhY4Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS81XSBiYWNrZW5kcy9pb21tdWZk
OiBJbnRyb2R1Y2UNCj5pb21tdWZkX2JhY2tlbmRfYWxsb2NfZmF1bHRxDQo+DQo+T24gMy8yNy8y
NiAxMDo1MiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBBZGQgYSBuZXcgaGVscGVyIGZvciBJ
T01NVV9GQVVMVF9RVUVVRV9BTExPQyBpb2N0bCB0byBhbGxvY2F0ZSBhIGZhdWx0DQo+PiBoYW5k
bGluZyBvYmplY3Qgd2hpY2ggd2lsbCBiZSB1c2VkIGluIGh3cHQgYWxsb2NhdGlvbi4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCB8ICAzICsrKw0KPj4gICBi
YWNrZW5kcy9pb21tdWZkLmMgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4+ICAg
YmFja2VuZHMvdHJhY2UtZXZlbnRzICAgIHwgIDEgKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDI1
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0ZW0vaW9tbXVm
ZC5oIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBpbmRleCA0NWE5ZTg3Y2IwLi5kNGJh
ODQzNGE1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiArKysg
Yi9pbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+IEBAIC0xMDAsNiArMTAwLDkgQEAgYm9vbA0K
PmlvbW11ZmRfYmFja2VuZF9hbGxvY192ZXZlbnRxKElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMy
X3QgdmlvbW11X2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90ICpvdXRfdmV2ZW50cV9pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MzJfdCAqb3V0X3ZldmVudHFfZmQsIEVycm9yICoqZXJycCk7DQo+Pg0KPj4g
K2Jvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2ZhdWx0cShJT01NVUZEQmFja2VuZCAqYmUsIHVp
bnQzMl90DQo+KmZhdWx0X2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50MzJfdCAqZmF1bHRfZmQsIEVycm9yICoqZXJycCk7DQo+PiArDQo+PiAgIGJvb2wgaW9t
bXVmZF9iYWNrZW5kX3NldF9kaXJ0eV90cmFja2luZyhJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQz
Ml90DQo+aHdwdF9pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgc3RhcnQsIEVycm9yICoqZXJycCk7DQo+PiAgIGJvb2wgaW9tbXVmZF9iYWNrZW5k
X2dldF9kaXJ0eV9iaXRtYXAoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdA0KPmh3cHRfaWQs
DQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5j
DQo+PiBpbmRleCBhYjYxMmU0ODc0Li45NDk2Mzc3YTI1IDEwMDY0NA0KPj4gLS0tIGEvYmFja2Vu
ZHMvaW9tbXVmZC5jDQo+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IEBAIC0zMzcsNiAr
MzM3LDI3IEBAIGJvb2wNCj5pb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChJT01NVUZEQmFja2Vu
ZCAqYmUsIHVpbnQzMl90IGRldl9pZCwNCj4+ICAgICAgIHJldHVybiB0cnVlOw0KPj4gICB9DQo+
Pg0KPj4gK2Jvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2ZhdWx0cShJT01NVUZEQmFja2VuZCAq
YmUsIHVpbnQzMl90DQo+KmZhdWx0X2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MzJfdCAqZmF1bHRfZmQsIEVycm9yICoqZXJycCkNCj4NCj5ob3cgYWJvdXQg
dXNpbmcgaW50ICpmYXVsdF9mZD8gSSBrbm93IHRoZSB1YXBpIHJldHVybnMgX191MzIsIGJ1dCB3
ZQ0KPmFueWhvdyBuZWVkIHRvIGhhdmUgYSBjb252ZXJzaW9uIHRvIGludC4gSWYgc28sIHdlIG1h
eSBkbyBpdCBpbiB0aGlzDQo+aGVscGVyLg0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

