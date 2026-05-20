Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8339CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoNP-0005Uw-P4; Wed, 20 May 2026 17:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wPoNO-0005Ui-5a
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:22:50 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wPoNL-0004UC-OF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779312168; x=1810848168;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IhQfNhdF5WFXEF8wRr6Kyb53Ua2b3vodafrPFE7TmHo=;
 b=bhGbHpPGub4G2XROc3v/6uTGr2ey1/6IV3G/FWA4M2Bv/q93YkL/HjJz
 xCcwRxoM/V5XfgnapzKrkcJFhDLQ5fM51X1Ta4gNeQ42dPVM1Y5jabYRO
 P3cy5lqiPw9cuIBpBpmc0BawkyjTxtmJIS5TiXCkDFe4Gui5WaU934DYR
 2rDBCHTkJSn+czVuvzXnooftyFqxMwwhDY273BMeC3GNPNMfUzi4jjiVs
 JYZOV+d87TOB3BvI4I+Dsdx1GZJkA9Jb5VVHPzNPRQ/MmQDJ2bAYn9A/j
 Ducm89UDMQi4GIX5qmQ8CeJbbaUvm+suBoZBiAc3PnYzzV1l7UUL/XyP/ g==;
X-CSE-ConnectionGUID: tr9as0BKQRmjdOsnzVZkVg==
X-CSE-MsgGUID: vouzMr0RQjaMxeG3rSN1CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90801918"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="90801918"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 14:22:44 -0700
X-CSE-ConnectionGUID: 1DL5wXhgReKG6/qJAi7A7Q==
X-CSE-MsgGUID: NoyiG6PGQcSR4GJ3IwC7ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="237311546"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 14:22:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 14:22:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 14:22:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 14:22:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii+TvHyBlIzwnBaKYvsqDcWSsVRQdApFOzt+FQGNjSE1vTAbNnc6iIyaReu5cm+JAAC/XFuhDPyRHFQf4Zv4/LmgGr0DxmJ2Ymq/ItDgjJDr5SCS5xntZQEXyJ/BCD9bhcjiS8fYSZqIKBFJHg4apDeg7xmsrE9EA9YsNK7Mvw3X4j1pw51HXuy7SGrmhrOLfCpdOY1arn6avwDYPsGumQH73WhHSuK+ssI+6O8viqwtu8XgQO4CYoiHehzgXJ4LRXrz27lEzEtQzrppsbORJmIzxbB4rvNtFf0Z9bLYhNknw/sLvhuHh3JvUJ6Sb9EPC3CF2W1My24PnAZcJOz8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhQfNhdF5WFXEF8wRr6Kyb53Ua2b3vodafrPFE7TmHo=;
 b=ocdTKGWWIifsyw9KUAzV+DNSQnbJWlfPkIrVPMFZ6Ux80JtQCLg7GPO0+2A2P/WXaMOuEMfjOE6U3Di9rFIXtlQ3DWo2qIX9xc6L02rcZIV+suBtrBI1v/W+52aO5NynXUK1u8nzpcY2EswDkft6WxYx87qt+Y3F7l1Eq/+K0oalAIZAJ2GQGyy1tw/Rcm3z3aPqx1zizbUxu/cqW8vSNW7mm5BhCb8vIlTQgGGdAr7WTOGQEQ3Bnxh4o2pDn76nE+wRcJzwBM6CKmc8L3EoqwM68wwaHXhZwy8hMvqxgPuWw2k2FQFFh39gFltjJlN6lq3zfptCHsX/WwLOODlZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by DS4PPFBF67129C1.namprd11.prod.outlook.com (2603:10b6:f:fc02::49)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 21:22:41 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 21:22:41 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/gtk: Fix focus loss on re-attachment with single VC
Thread-Topic: [PATCH] ui/gtk: Fix focus loss on re-attachment with single VC
Thread-Index: AQHc5/BbQ01hMA+W/U+mx5STThX5erYWiIiAgADjd8A=
Date: Wed, 20 May 2026 21:22:41 +0000
Message-ID: <PH0PR11MB511244BEBF483FC7ADFF2EDCFA012@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260520002645.1910740-1-dongwon.kim@intel.com>
 <CAJ+F1CKt2Xf5KK2tCSa7Dew1iyYn5mrdM3Qh2aj5C6hi79DoNQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CKt2Xf5KK2tCSa7Dew1iyYn5mrdM3Qh2aj5C6hi79DoNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|DS4PPFBF67129C1:EE_
x-ms-office365-filtering-correlation-id: d43479cd-0d81-4874-7602-08deb6b5ece0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|3023799007|22082099003|18002099003|56012099003|38070700021|11063799006|4143699003|5023799004;
x-microsoft-antispam-message-info: QUC+F3jSIXjG2mW5D5YCAqnKFH7Mg5TSYLOmcKBGfo2U03/eMclbDgnFQqkXC+cjbkmb3lErVGFHbPic6rxP13zoRfl+NT+Lv6KirS5eprnYmEkqbT4baY5DhvAqB7cIZQuQOhJCCLgswQrDwjBL98u7yVdYnWsodL5/hKp1X77wB/vRtE2hkbkhFCQGewwH61OSWbynx5Xm1KDyZgif+kT88lleZk1Vcs8gmJiNqw5CcWgaormgC+ErYQArGUw9FXPyL9SA71Q51npaFZw1Tb5NJZKeXpnv8GU9Kz88mmAzimThx3zFRusbmSKtmlBRXFnrKX8wp6sp+5SDiUGOwv8eaMuqq0NrKZliHJcQ8LlaZHyvZ5Nzm0q1kWMd3UjqMObv16vff794IoqBtZiDShbTMWEpJibr6vpQiqgfZQzWcs8ewEN4FuSEGgrSny/EhA+KJsW50Hye7M/isAvBzM6+bcfOt1itG6uVk7QnZApX9NHFRMuOvDHALEh48UM96NRo/dL0lWIfWjH2eYkJG6/k29J4eTDNwzWiYAEVk5GJ6CqEfe2F1Iz/FvNOgu8/y2hte6rz84VIdB7kbM1eS6yRZhwOlic7vtN15BkuxgkwSE/KWX0CrlSUUbi1sAw6qvZGwLluRH+mjgfE9SNvI7MDGfAzqXSWQv/qCqliRIVyuTGmJ1pjyUxuyiNEgD/dqxhx2ginTrzeADMMV6UV9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(3023799007)(22082099003)(18002099003)(56012099003)(38070700021)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGx5Ym1JcXVBbWZpcmk4M3dhWVRqcHBVR0hFNGxQTHZNbU0yWXdHeVRxWUhH?=
 =?utf-8?B?TGRRaHowVi9Cdnp1VFplZUlBWXZkMkdVbTZWaVF6U256elJ6TGtNUFFVZTlj?=
 =?utf-8?B?MWlOTkEzNndRYWZhL29ub08yQWZpNnd0WStNWm54VENGM0F0VkhndmdhZG1L?=
 =?utf-8?B?YUVicXhnN2FBK3JKTG1hQWZjSm8xeTJTVUpuUkY3UllXTlI5VFBoRncwc1k1?=
 =?utf-8?B?Z2ZQNmtGbStiUTJFZUcyY3NkM01xK1VlMUViNkl4a2tON2NETCtRbDZzWGtq?=
 =?utf-8?B?NitTSWgvSTBDOUpmd3FnMER4RW05OERJcWpaaUJMSnhNY3JNWGJSMU92cTZF?=
 =?utf-8?B?UjFQdWVCR3RsdGtLRFIwcU1Cb0Y0NnR0R05nVVJkUTFORDEzR2hiZzdHajk3?=
 =?utf-8?B?Z3JtNnlPUmp5MjdiZkJkcDVxSDlVMDFscTVDbXlEUzhFZHRWbkRKdUwwL2Y0?=
 =?utf-8?B?ZW0wVHJzUlpsTFFwZkdPdmRmRHdXUEZTZndFTFdJc3RMa0t3OXlVcTdsNnlX?=
 =?utf-8?B?UCtzVElLUGxPNnk2K09hMno4bEJSRGpJejNKN1F2Q1NTR1hEd2dzNjd2U0lC?=
 =?utf-8?B?MUpFUnRGdk5SL0s0MktqQUlJUVhob2pyM1NhRHlSUm5EQ2VWVUhucXhoSklV?=
 =?utf-8?B?cTJHWU9YbWNhRHNTMitQN3RZTktBZkM5dzFPRnZ1TkUvZGtQMkJuT2k4V1Z0?=
 =?utf-8?B?V210c1VubUZ6aE81UUpoZVArZ0N5YVZHbERLK1kwa2ZpdnZkSFZmMGd5UStD?=
 =?utf-8?B?bVNtellMNTg1MkVLNlNjL0txdGpadlRvemgySVpPTDBWd29nb2JhWU56bUlG?=
 =?utf-8?B?S1VuS2YwWFRBVDh0R3J6azN0SWtiMEJETFp6S3BOaTRoMXYyc0Q3b2JwaWtP?=
 =?utf-8?B?d3dXNjlMbHEvQUEwMnJHS3FBYlNKeFFucWZraHJiaDdndEtJVTJidmFDS0pt?=
 =?utf-8?B?TmxKbXU5RG16M0l0TnlkeWoyVXJFYTkxVXR0QzJMdnJGY3BvVlNuZWVOL3By?=
 =?utf-8?B?dVYxQmgvZ20rQXpKMnlUd0pmVG15TDQxWEUrWEZiSVRPdkN0VXg2aEZNZFp6?=
 =?utf-8?B?YzJHL1A3QzhDdG5nMnNkRTZ4SFc2LzlCR0FzOFhnWWQ4aDk2bW91MURGVktE?=
 =?utf-8?B?TXNxWUJEWW4zSDlSMnRWSFJ5YXZhZ0VqV1ZBZk9EY2ppdFJIN1BlQjZnc1hK?=
 =?utf-8?B?MFNvL0hCZ2o5cWErekFjbTZabGczUVgrNzkyWEltY0VLSnVuR3VFTVB0ckRz?=
 =?utf-8?B?M1BkVHViOE1iVlI3SVhiZERqT1UrU0tZNWl6Q3g5czZ6R0FZU1k2V1l2THNk?=
 =?utf-8?B?WTZmK1A4L0xQalFYZmc4emx6QklZaEh3R3RDdjJ5QWsyTTBuUnFjZ2dMZlQx?=
 =?utf-8?B?OE52bGNvY1pTTzhPZDZIazFGRTFpdm5uckxnbjNvbi9oejhXbjl1dWxIbjd1?=
 =?utf-8?B?bFljYkxYOStNZUJuSGdBMXZSSTJFeFRRMVhUUldJOTY3b1BReFkrZDlETDBS?=
 =?utf-8?B?cHN0SEJkZzZMeTFRVG9MbmVGVjl2a2JTdXVqSU43VG45RUpDK1EvNk9OWjBR?=
 =?utf-8?B?R1U5MmphdGhHWDRIZGZvdE9TRWJtVW5DTm9Kc0ZKeTNLc3dCNFJmNEw5SXRs?=
 =?utf-8?B?UkhNYUwxZFN1MlcrUGFuYm9rcTVnQ0Q2bCtiaUJtazMxbU9kRnJpQ2Z0cTNC?=
 =?utf-8?B?dWk4eG1oeENJVWEra01CNEcyVFB2WDRaM25iOTVNWjBKd2pCU3JKQ25SQ2ho?=
 =?utf-8?B?cWVEU29xQktMZVNxM0RLb2hkQ2t3b3NUcFVsVG1xVHBqbUJDNkpoalhpNnpk?=
 =?utf-8?B?SWhuQmJ2Ny9TamNuK3pKdk4zVzdKU0RmaERWV2Q1RTNHQkxyOXhIMFo3eFVx?=
 =?utf-8?B?S3FhREtIcTB3MWxQZHR5Z1lNSW5KZzkxVEUvMTBwT00wYStucUI0MnQxQW9I?=
 =?utf-8?B?RXl4T3RRZjVjemNRVWlFOGduTmNTZ3lPeCtGeDFOQ05aSGdScmVVbG15aEt2?=
 =?utf-8?B?QjR2eGE1TWZ0eUVoMXpXbXVwRTVxUU56Wmcxb08ycmpzUWVSYUpVVWU5c3hu?=
 =?utf-8?B?ZFEzQUFuTWJkS0VMMHdCMk5IZ0lOdjhKQ2hIZmlZZWF0aW0wbGRlakFEdkE5?=
 =?utf-8?B?L05kcnNMajRBaUlQUnBoR1Z5eFFBaGpmc2tYd05TaC9DWllMaGt2b3JuVExx?=
 =?utf-8?B?NWZYZXlzWGkwZXdyb00vanlNblJWc1drbnpQUGRJRGpHQXRGcE5NdzBCME1V?=
 =?utf-8?B?U2tWRVhtUjB4WGFLck9oUmlybFlDVEh4RmZoZ2pCMHZVU2M4ZkFPeENPSmdD?=
 =?utf-8?B?VGFUNVB3SGpEd3dPd1lOanNVbG9jZENjOGlhaVRYSXZYbTRVeWV4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v34b1aAsYJJCRKUUHai/rZmH8OQ7/wRaAOcaYwN81oPzIMomSkdDmCmr2b9UQDsLk5mAJw1ILWqyZHTgak7oodWiqEecYsN0KNnFqnliCH+Nm3Rxf5odY6LyGM7ijLuCnQ+hoNEkvex1pjLmTJ0qNGylKXb9VWCIbSdN4Lfa9BKBIWYGQpAHvIXTHbxM3anUA34OTEoNK+0ApOcClFyOaqVs1gMhIadOVsbE20Mp+xhJFftJCTwMP2/D+NhCmFlWaXqcvMC/m0ajD2zgMLBWnasFUGRiXth/2I48/SNX93SodFEdYWLlhHg7QdJPux0Z9hEnymnBM9VwA4KVo+dH8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43479cd-0d81-4874-7602-08deb6b5ece0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 21:22:41.2121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvEPAguLiFH2FkHfaxs9jjx2aL2W8Q493+eEkD4jB9QOzoOf1GuSWmHDPq/qe8hSF4b33PmfCIBTXDtFgPJTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBF67129C1
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdWkvZ3RrOiBGaXggZm9j
dXMgbG9zcyBvbiByZS1hdHRhY2htZW50IHdpdGggc2luZ2xlIFZDDQo+IA0KPiBIaQ0KPiANCj4g
T24gV2VkLCBNYXkgMjAsIDIwMjYgYXQgNDozM+KAr0FNIDxkb25nd29uLmtpbUBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNv
bT4NCj4gPg0KPiA+IFdoZW4gUUVNVSBpcyBsYXVuY2hlZCB3aXRoIGEgc2luZ2xlIHZpcnR1YWwg
Y29uc29sZSAoZS5nLiwgdXNpbmcNCj4gPiAtLW5vZGVmYXVsdHMpLCBkZXRhY2hpbmcgYW5kIHRo
ZW4gY2xvc2luZyB0aGUgZGV0YWNoZWQgd2luZG93IGxlYXZlcw0KPiA+IHRoZSBtYWluIHdpbmRv
dydzIG5vdGVib29rIHdpdGhvdXQgYW4gYWN0aXZlIGZvY3VzIHRhcmdldCB3aGljaCBtYWtlcw0K
PiA+IGtleWJvYXJkIHVuZnVuY3Rpb25hbCBvbiByZS1hdHRhY2hlZCBWQy4NCj4gPg0KPiA+IEZp
eCB0aGlzIGJ5IGV4cGxpY2l0bHkgY2FsbGluZyBndGtfd2lkZ2V0X2dyYWJfZm9jdXMgb24gdGhl
IGFjdGl2ZQ0KPiA+IFZDJ3MgZm9jdXMgd2lkZ2V0IGR1cmluZyB0aGUgd2luZG93IGNsb3NlIGhh
bmRsZXIuDQo+ID4NCj4gPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1
QHJlZGhhdC5jb20+DQo+ID4gQ2M6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4gPiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICB1aS9ndGsuYyB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3VpL2d0ay5jIGIvdWkvZ3Rr
LmMNCj4gPiBpbmRleCAyYzYxYjYwMWY3Li44ZWIxYTgwMzc3IDEwMDY0NA0KPiA+IC0tLSBhL3Vp
L2d0ay5jDQo+ID4gKysrIGIvdWkvZ3RrLmMNCj4gPiBAQCAtMTQ3NSw2ICsxNDc1LDExIEBAIHN0
YXRpYyBnYm9vbGVhbg0KPiBnZF90YWJfd2luZG93X2Nsb3NlKEd0a1dpZGdldCAqd2lkZ2V0LCBH
ZGtFdmVudCAqZXZlbnQsDQo+ID4gICAgICAgICAgdmMtPmdmeC5lY3R4ID0gTlVMTDsNCj4gPiAg
ICAgIH0NCj4gPiAgI2VuZGlmDQo+ID4gKw0KPiA+ICsgICAgaWYgKHZjID09IGdkX3ZjX2ZpbmRf
YnlfbWVudShzKSkgew0KPiA+ICsgICAgICAgIGd0a193aWRnZXRfZ3JhYl9mb2N1cyh2Yy0+Zm9j
dXMpOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gDQo+IExvb2tzIG9rIHRvIG1lLiBCdXQgY291bGQg
eW91IHNoYXJlIHlvdXIgdGVzdCBjYXNlPyBsYXVuY2hpbmcgcWVtdSB3aXRoIGp1c3QNCj4gLW5v
ZGVmYXVsdHMgZG9lc24ndCBoZWxwIHJlcHJvZHVjZSB5b3VyIGlzc3VlIDopDQoNCkhtbSwgLW5v
ZGVmYXVsdHMgc2hvdWxkIGJlIG9ubHkgdGhpbmcgbmVlZGVkLiBUaGUgcG9pbnQgaXMgdG8gaGF2
ZSBqdXN0IG9uZSBWQyBjcmVhdGVkLg0KUGxlYXNlIHRha2UgYSBsb29rIGF0IHRoZSB2aWRlbyBz
aGFyZWQgaGVyZToNCmh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMU82SzlHU1dIRlJG
YXhhVExjSktOX2pZT1B2T1FQcjd0L3ZpZXc/dXNwPXNoYXJpbmcNCg0KVGhlIFFFTVUgdXNlZCBp
biB0aGlzIGRlbW8gaXMgeWVzdGVyZGF5J3MgbWFzdGVyLg0KDQpjb21taXQgZTg5MDQ5YjNiYTVm
MWYwNDY4YmMwZDI5NDE3MzM0NTU5NzUxNGExYiAob3JpZ2luL3N0YWdpbmcsIG9yaWdpbi9tYXN0
ZXIsIG9yaWdpbi9IRUFEKQ0KTWVyZ2U6IDk5MmNhMTVkZTcgOGI2NjNmN2QwZA0KQXV0aG9yOiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQpEYXRlOiAgIFR1ZSBNYXkgMTkg
MTU6MjM6MTAgMjAyNiAtMDQwMA0KDQogICAgTWVyZ2UgdGFnICdmb3ItdXBzdHJlYW0nIG9mIGh0
dHBzOi8vcmVwby5vci5jei9xZW11L2tldmluIGludG8gc3RhZ2luZw0KDQpBbmQgdGhpcyBpcyB0
aGUgUUVNVSBsYXVuY2hpbmcgY29tbWFuZCBsaW5lLg0KDQpxZW11LXN5c3RlbS14ODZfNjQgLW5v
ZGVmYXVsdHMgLW1hY2hpbmUgcTM1IC1tIDIwNDggLWVuYWJsZS1rdm0gLWNwdSBob3N0IC1zbXAg
Y29yZXM9NCx0aHJlYWRzPTIsc29ja2V0cz0xIC1kcml2ZSBmaWxlPS4uL09WTUYuZmQsZm9ybWF0
PXJhdyxpZj1wZmxhc2ggLWRyaXZlIGZvcm1hdD1yYXcsaWY9cGZsYXNoLGlmPXZpcnRpbyxmaWxl
PS9ob21lL3VzZXIvbW50L3VidW50dS10ZXN0L3VidW50dS1kZXNrdG9wLTI0LjA0LTMwMi1jdXN0
b20uaW1nLGNhY2hlPW5vbmUgLWRldmljZSBwY2llLXJvb3QtcG9ydCxpZD1yb290X3BvcnQxLGJ1
cz1wY2llLjAgLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwMDA6MDA6MDIuMSAtZGV2aWNlIGUxMDAw
LG5ldGRldj1uZXQwLG1hYz1ERTpBRDpCRTpFRjpCRjpGQSAtbmV0ZGV2IHVzZXIsaWQ9bmV0MCxo
b3N0ZndkPXRjcDo6MTExMS06MjIgLWRldmljZSB2aXJ0aW8tdmdhLG1heF9vdXRwdXRzPTEsYmxv
Yj10cnVlLGJ1cz1yb290X3BvcnQxLHgtcGNpZS1wbS1uby1zb2Z0LXJlc2V0PXRydWUgLWRpc3Bs
YXkgZ3RrLGdsPW9uLGZ1bGwtc2NyZWVuPW9mZiAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLW1lbWZk
LGh1Z2V0bGI9b2ZmLGlkPW1lbTEsc2l6ZT0yMDQ4TSAtbWFjaGluZSBtZW1vcnktYmFja2VuZD1t
ZW0xDQoNCkkgYW0gdXNpbmcgVWJ1bnR1IDI0LjA0TFRTIGZvciBib3RoIGhvc3QgYW5kIGd1ZXN0
Lg0KDQo+IA0KPiAoZndpdywgSSBoYXZlIGEgYnVuY2ggb2YgcGF0Y2hlcyBwZW5kaW5nIHRvIGZp
eC9pbXByb3ZlIGR5bmFtaWMgY29uc29sZQ0KPiBoYW5kbGluZywgSSB3aWxsIHRyeSB0byBzZW5k
IHRoZW0gbGF0ZXIgdGhpcyB3ZWVrKQ0KDQpTb3VuZHMgZ29vZCEhIFRoYW5rcw0KRFcNCg0KPiAN
Cj4gdGhhbmtzDQo+IA0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUNCg==

