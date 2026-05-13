Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D354CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzOU-0005NJ-1O; Tue, 12 May 2026 22:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wMzOS-0005NA-2i
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:32:16 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wMzOP-00081I-OV
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778639534; x=1810175534;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Anthvg32Oeb/OnNcZc2l13R4vokgQfv9XkH01e9uKkc=;
 b=FRoMHEHojRLtfWwAw0sAMSEMKKpJ4cK78Pbgl5w03geKbadCdXybnjPM
 Wq9tz6p6R3RVQG+CechxYhpkR8AQUYis2csp/XwzRopReaUNTaotIExDy
 aDfmY72y0nCuFXeG2Pecd6PmH498Fy+QFA1HXcK81RaQqkRE6g7nwb/Li
 0rrXxg8ItSkIoc01ThovZ50FILECSp4CWl2h+8vdLQGJpZuGRN1uhzwCT
 AOKogf0/oMiw2NBtmCjNAiEy1D8zvRNvRpktzY7lC86lRtwYPHyrK0a/u
 3IvFBhAyALf/dSlEcL2t+gSmea3MqUR/Y84X0iBWy0DdlNny1Ri2Reh0k w==;
X-CSE-ConnectionGUID: 9GDBdKauTM+RvWCzSW5QyA==
X-CSE-MsgGUID: AWtnZTNdSkaIaPOhh/teFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79542151"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="79542151"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 19:32:09 -0700
X-CSE-ConnectionGUID: 3gB7RPKVT46HZXsj7cm5Ew==
X-CSE-MsgGUID: jzlB8xPgTMyso+AvdH4CTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="238194562"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 19:32:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 19:32:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 19:32:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 19:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYfJcIQDAlGC4oPycVt51mAxQiGlkufDhyMSmvGBkRKNtBCtZRi4GZwYu7mfnJ1sa9PA2f0Z9D3SyF10Wx1Ui5ExyP9ad3NpSpgcC6nS0uzknCYmuA61WQlxBX1BU9bb2lq80bFMujSBq9ShZ0IVi92iUSFtuxNhRhjeA3L7lNrk1Z/qMXOdBIf8YF6ffuf1P66a2ea+4FRkSvpkKegUR9GTfESv6cZ+Q9Wfy10HGWap4dqdKpzlUMRwAI+J0N6zkmbCjHBs/KCYk/gUeRUjPQnImo0VCOHjR4Eqwz1zXG2Glv0K5aA3QWRMA9fsAHBpsx2b3SKa86pJbXEZD7gdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anthvg32Oeb/OnNcZc2l13R4vokgQfv9XkH01e9uKkc=;
 b=Y1acF1eq1ncUtYF9odKpCOMwEpLDeid4y/2oeXtZwFpheTzyJWj9QoHOp3F/lFa07HRESH+bDs/mpTwnuSoGCBeoPwVZrJB8JJx9q/Ef1JzamNQFxR9DX+FwYCSRsMIB9cwSHaY0/EOD8wJ5nsuvfQUPSrx2lNE4T3NPZe/cBjWxKa4wd25RA9+VnSxjju5leALiy5puOySTqsIDBXuD5HU12XFProFi5AAJnk9645vwP8xlwEWjcy3MJaWZEdxgvjfxAWoh+vtSAXAxsyHXpQozXlKDOqIDUmHmnzeQvOEB+zT7SwwiVutEKd2M5svp1SjhPD+zjC0juHJynIc/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 02:32:00 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 02:32:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>, 
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 0/2] Update properties naming for 'x-scalable-mode' and
 'x-flts'
Thread-Topic: [PATCH v2 0/2] Update properties naming for 'x-scalable-mode'
 and 'x-flts'
Thread-Index: AQHcsTjAWMb5Wwo6Ekeg5YxhGCfbBLYLnYyg
Date: Wed, 13 May 2026 02:32:00 +0000
Message-ID: <IA3PR11MB91364B85D3940A668D740CB992062@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260311092320.212849-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260311092320.212849-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB8527:EE_
x-ms-office365-filtering-correlation-id: efbec30d-f8eb-40f6-801f-08deb097cfb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|11063799003|22082099003|18002099003;
x-microsoft-antispam-message-info: zsfaKyKTL5BPzZrYyzm1xWg0DM5vogtlGyWqmDQ1LD5yGmSgbxd/jF6/5RIOW82yUzV5jaSIFYob9bU0KkNlJGDWyQqvUvaSy5EFOy6KY3eNl274iO3VI/eqjDI7HbvthOwAIFvl8uPgsL4U4Wn04iBfQbP4M/4Plz3gDzH8ZptRzDlMPxcdsjfrphfmg8Tsluajwvs16DRoNCGV3xXJrL6AH5DrfrkiOy3wM9iG9a+U2oJjP1cg//9C7Scp+xW3ncIMYwjUVeLytpJxnbvEV81BNbDLrFnrgmArrq8cPBR+TxUySUIXv2tpyyiMHMGR2pqKFI3a9o7QX2AzDsFEeGHvmHHZJcEUE8ZxcgKiUZ2cjGZT39hqGKJu7St0nOZOVKsKk4GUs509HtkNpUfXBswhSy080YHIyIV4qw6AEpLNHrP1Qy5UXcFrsACHZOl82zZ3slAdWZrGSON1phPwu6KeiykDz3r1qkHM3XaEZirvzI6qkzs8mAuHbIkjeyJWkls/UhOB+ZXu856mzVmjngribo6fI8dho3s/gluk1JREh1mqo8r41pXlmO0ru8ZsxaWzrs6EK/53us8UvlR1vgyluNR6mf5OAij4+q9NmVQ8WfKoQr6dp+H+oWNuEFxi/BMqXZLOmyC9TP5A4m9aWI45PzgecOvXKWxah1T4Zkhd50PO82uoJMQOAa4vTHSepZAyxxynpnAgI32BgTOmzPPa4y5txiEc+P1m2245kBsqKpLi6G1ru+CNJZD2wtEX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3hwR0dVNzB3WWZ3RWF2Z2xPV1F2ZEJlTEtHbm5qS1Rra0FQV0JXaXBtbEZ3?=
 =?utf-8?B?dC95YkUrcGxBcTJoUE9naVNXbDVXNUlNN3VGbjdQOGJnbmVsclZ2YVZXaVdE?=
 =?utf-8?B?NGp5cC9Ud09sMHF1Znk2clhPcGlOa1djUmxlaDlIRzh6VG0vL0pXV2hzYkFH?=
 =?utf-8?B?cW1NM0MyOUdta3hzSjQ2TkJYNmVneXpQSmhQbGlmbXlCelc4SEdHd3Z2Zmh2?=
 =?utf-8?B?RG9Wc1UwTmtVVDZKZFFoeldlc1BpbDlLL2lHcDlBQ29rdHhzeDc2NW8yUTAy?=
 =?utf-8?B?OTRGWVNVU0xqNEEzZUh1bzc3TjB6TFNBODVBaEZFYXNJb1dGNVc5aUE1NkM5?=
 =?utf-8?B?QURXZWczVWd3NW8xdXhMOUtDWGNlN0xubjNZZTRQVlVpc2drRUFEZ1VXWFVT?=
 =?utf-8?B?bFVvdzNhdm5sbW84UkY3dXQ1eCtvbjMyUDA0enh2TDVpWTVUZ1FielJzOEt0?=
 =?utf-8?B?TnZhL1BDTU1YZlJVUVY5N1pLM1daK1l3ZkdqazAwa01wbm1GUDFCTytiWEd3?=
 =?utf-8?B?M3B0T2xwOTZmcjVncUtLQWFxMGxHazI2NVNvSmJtVkVBSkdUWWVac3RnNmtT?=
 =?utf-8?B?SkNoYzNzUTNsa0tLWFZqcGtUbDBtR2dKeGo5VUFyNlY4N0pYSmd2QXA5a2tU?=
 =?utf-8?B?SFBTOFVEVWNBalJwK1BlMGFleDZGTy9LdVNCWHl0SWEyU0ZKVFF4RVVkeFhX?=
 =?utf-8?B?Y3RXd0JVdmdXV0l5aXAwNXczTnRFMGtOL0VHS29kd3RKUlBLeXNtcHhqU3Ra?=
 =?utf-8?B?VHNpci8rRE41YUZ5RFFSMFZ0SHNTSGV3Zko5YWRQb3k1WTlzYWdtQkNkM0Zl?=
 =?utf-8?B?RjNZUzBpTVl1c0JMeU1XUFFDSTlrcWZ1Sld5dFFSMnl5aHFxMlBSTXZ3bUlj?=
 =?utf-8?B?cjd0MklITE5hUlhya1pXWHBHM1J3MTZ2V1NKMUMzOFphNmtWOU9renBFUUg1?=
 =?utf-8?B?VFpUdVFwZExweStkOEFvZ1lmM2tKbGRFK0lLS1NQb201bmw1RE4xR2xkeU16?=
 =?utf-8?B?R3VkR0VBc2J3Vm5pMy85K2tRVHZiZ21mM2hoa3hjWktGVHpSeHdVYUovdk03?=
 =?utf-8?B?eUw4MEU3Y25YUWpkMytpTk9EaUFiTXoxd3licGx3ZjlGMHo3bHhZRFZPUmNT?=
 =?utf-8?B?ZXplNFFCUjdrUFEvQnpPN2NsVW1iMmY5a3lkT3B3VDNUNVg0SDl2Z3RLRGl1?=
 =?utf-8?B?d09XcU8zL2tkcWtwSGFpcHZycENSZGdhQW9iSXlZMWVmcTV4RDZIWHZRT253?=
 =?utf-8?B?T3BTZlM2bEM2Z2tzK0Z3VzcrZEd5aWdZLy9KK0dWdTRxUHZRQXlxZVVvd1NK?=
 =?utf-8?B?YUxXQ0c5Z0doTDN4QjIxb1JYQ2d2V25CK2V1VU45Y3AyeXdYVjdZUEtueUNL?=
 =?utf-8?B?by82ckN6V3pvTmJFZDA2b0tVMkpycGg5eGJkNk1XOXFiaS9iQkhVeEpmSkNx?=
 =?utf-8?B?bkZEb3M1aGNwS01ZeEVCY2lzWkJvTkhaZkpxS1ptejNlY1pJS0FKeWJsY2RF?=
 =?utf-8?B?ZnhSaloydzJmeGRmZHFOYVp4MUVubk1ETnBwYU0vZmJKUVNXU1Brb0ZncVk2?=
 =?utf-8?B?cHpMb1dLOEh4cUVjSTRYTURrdFJhbE1uRzV4QU1tclBObnVSakdzWFJpRVpy?=
 =?utf-8?B?NjM0cVNiRWFhRWg2OGcrYUM4VHNjdVhBVGE5SFRjRnI4dHY2NzRKNjFJbnNL?=
 =?utf-8?B?c2lma3FmVGgzS2JieFpaYzNMMGpGMXR4UWVNOGZtUG1SbklnMWRNaE1pTFNR?=
 =?utf-8?B?MDFvNDVLaEk2bGxuMXVNR1pmSUsxQWFxNFRlOHJsWk4reDZVRitaNWZDc1gx?=
 =?utf-8?B?K3MwVnE2YllyVWRHN3l2WHMweWpYZXBhY1JFeU12eEl0ckdyeU41cUs4WG1w?=
 =?utf-8?B?a3VPZ0hRV3QrSDFmYnN2SkhPanBLV0hoNWFMLzREanBuMzlRUEpBdDcvcnJs?=
 =?utf-8?B?WjJocTZNdXVhUnpTZDlrMlFURk1FZncxeXFiMWJGaGlxVWxFQXFRYWVLT05x?=
 =?utf-8?B?U25yVTI3b05qUUpteGh6NWd4dU13dDlzTGpMcEFxREVFQ3BzQ3Q3L0FsZHFG?=
 =?utf-8?B?ZzVrKzhOU3hDWVBKcW5LVUp4WEVwYmhVUmpzRU9pOWZ5QmdWbURrVjgxTyt5?=
 =?utf-8?B?NGpvKzNvMFpSL01YZ1JYa05rbGVhdEFRRUhjMExHMVcrV2RwR3Nnd1c1QkVo?=
 =?utf-8?B?K2EwOHdwdUVCY0RVSU9OdS9yRnN3TVZPVjcrbHpiQVB3NUdQQTEwMVRYMHAv?=
 =?utf-8?B?VFdtZERVM29vRWtEVTVHUkxZRVd5Vy8xa0hSbUlLTG1xSFQ0clpkUTJSVW5C?=
 =?utf-8?B?OFVlTFMrb3puNWVOUHJyQ1ltQ1VmUldmYjRjSWQrUnhMenhoV2x4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XhhB2iyqDf6t17+A0MF/ADWJneQkmp8x7ouvAW8cKkSgs4qsKXT31ysqN/KveFZ+u/YTE9cSUZtXpO2huRt/btFzXT7/DIH0GGU265HVvPN7uaEL6M8WAuHNIggSQq0JMfLAe77yHAYjyGCgYJALfruIm4snOGho5fRzY6yGMnja2gVSViKkPZycICDUSjDVcGpszW7yDbwTDpj1KBmPpLtD7au3kOdOQgVUX/UgW0TuDSMZ4d51IRWHfU06jdnYUwjXvSI5i8wuXMDC6QXBi5jzHkZtq54Cp24/+CUOMM2a8gOn0uFrzjrP/8fQMnA/+K5KKy9x9akUwE6vOKkkGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbec30d-f8eb-40f6-801f-08deb097cfb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 02:32:00.4545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgLVy2quCVp9196+LiqSD2gkSNMe8egLYBPHjIb40EcRMfzJheSXZAc+HyrJ+8vBnDjczUhUJUa9OlrMxmmWqWXvZVIIYva7fAdRARAYzx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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

SGkgQWxsLA0KDQpLaW5kbHkgcGluZ/CfmIoNClRoaXMgc2VyaWVzIG5lZWRzIGEgcmViYXNlIGFz
IHRoZXJlIGFyZSBjb25mbGljdHMgd2l0aCBuZXdlc3QgY29kZS4NCkFueSBjb21tZW50cyBvciBv
YmplY3Rpb25zIGJlZm9yZSBJIGRvIHRoYXQ/DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4tLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCB2MiAwLzJdIFVwZGF0ZSBwcm9wZXJ0
aWVzIG5hbWluZyBmb3IgJ3gtc2NhbGFibGUtbW9kZScgYW5kICd4LQ0KPmZsdHMnDQo+DQo+SGks
DQo+DQo+VGhpcyBzZXJpZXMgZHJvcHBlZCAneC0nIHByZWZpeCBmb3IgcHJvcGVydGllcyAneC1z
Y2FsYWJsZS1tb2RlJyBhbmQgJ3gtZmx0cycsDQo+YnkgdGhpcyBjaGFuY2UgYWxzbyByZW5hbWVk
ICdmbHRzJyB0byAnZnN0cycgdG8gYWxpZ24gd2l0aCBuZXdlciBzcGVjLg0KPg0KPkFmdGVyIHRo
YXQsIHdlIGNhbiBhZGQgc2NhbGFibGUgbW9kZSBhbmQgZmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24g
c3VwcG9ydCB0bw0KPmxpYnZpcnQuDQo+DQo+VGhhbmtzDQo+Wmhlbnpob25nDQo+DQo+Wmhlbnpo
b25nIER1YW4gKDIpOg0KPiAgaW50ZWxfaW9tbXU6IFJlbW92ZSAneC0nIHByZWZpeCBmcm9tICd4
LXNjYWxhYmxlLW1vZGUnIGFuZCAneC1mbHRzJw0KPiAgICBwcm9wZXJ0aWVzDQo+ICBpbnRlbF9p
b21tdTogQ2hhbmdlICdmbHRzJyBwcm9wZXJ0eSBuYW1pbmcgdG8gJ2ZzdHMnDQo+DQo+IGRvY3Mv
ZGV2ZWwvdmZpby1pb21tdWZkLnJzdCAgICB8IDEwICsrKysrLS0tLS0NCj4gaHcvaTM4Ni9pbnRl
bF9pb21tdS5jICAgICAgICAgIHwgMTIgKysrKysrLS0tLS0tDQo+IGh3L2kzODYvaW50ZWxfaW9t
bXVfYWNjZWwuYyAgICB8ICA2ICsrKy0tLQ0KPiB0ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0
LmMgfCAgMiArLQ0KPiA0IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQ0KPg0KPi0tDQo+Mi40Ny4zDQoNCg==

