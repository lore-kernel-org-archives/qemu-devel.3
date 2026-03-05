Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109C7F47CAF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyDhK-0002FK-Jk; Thu, 05 Mar 2026 13:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vyDhB-0002Eg-4a
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:45:16 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vyDh5-00026n-Uk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772736308; x=1804272308;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=D8Fi9MpZDy8DVyhRjv5dlRhA1PZQPeN/dKM2TxHUQI8=;
 b=WC0XWVqVXFv2vYwk3tdPGrLq1iCcV7DNzqEd+G96vKkTst6TL/6rqxz/
 7v8bU90w+sG8DjiFt5ZMDxxrdC5dGY3nt9oz8bXHvc1QW7FDm4Ovmz4Y1
 mWPbyqQQj55lsQfD+Pv2A1kn5uwv+FmHF5V9wRj++SiKORShVqriloQl7
 tdaPshwafMnI3j+yFftLJsfJzj+aM++Xao41Q5f8R82N8qrOSCgW07wSF
 xmeCzKhOsR9tvJ3/P+LNs7OxLSUEqSIts0c3hYS7hDqKMDOzJIWuaY5/S
 8bug1l6VaHBz+unRqSUTHH7TzD4u7uqVwIIcYyQbBf5wJluYTbEawY3i2 w==;
X-CSE-ConnectionGUID: D72lvRCBSr+3qH+3KFYxKg==
X-CSE-MsgGUID: yHs0OSFXRkqQu3GJz59bNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85182441"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="85182441"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 10:45:02 -0800
X-CSE-ConnectionGUID: wxfpycS7SD62/KhWrYTuqQ==
X-CSE-MsgGUID: uNicg4VCSoa6GKIxveaUWA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 10:45:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 10:45:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 10:45:01 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 10:44:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr4B5Z5e40GnrbRWkWT0sBU8idK41o0IpOMxP1vo128iJoIQJBjs4h+zq3KH8rfWcmXwTWSt7K/7tCyUJprofq1aTY0bx7t2v26JtvBvN0L1GMz3wnuNTilWJfjddu/WWbBLiQ//LJkedy8nnIzdUqv0q71x4f6yh77868+g3ubqH1bNAlHONv6bZOqT+Ov1ZBIiZkXQBuQeTqTdAz0TA4v7uTGHz67AE8l/FPX1+s/3AJLa7EsEW16CG1peCdVJlvj+twl2evL4f8hdud9gNxV5UfPIjgnskEGDyO49B+T99WOY+vbCbbpBUQVtW3plQhmvrK8hm4zgg8N+pMKAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8Fi9MpZDy8DVyhRjv5dlRhA1PZQPeN/dKM2TxHUQI8=;
 b=CCkDS39pSAMxDPdnKdoL1XJMMkQcfERxQc30zXXPZDLhiLYkzJ/6nyUA7hcK5CL4Z2DjjNSBE+/OnQfda3gtjzvU/AAtZhCGgpnaNxsX4jVhjtwWYaLg+/5xKy85WMnN/ku7O3OBmdC1bIz00ctIllnFTU1PUGDVuOopQEr50JNeb38bmQqUa4GoczaTe2qx1eJc1hjWDd3raLD2Ni6LTkO4+ytRDBrbhGAwZ58kHvFcyRQtxkL9cKbV0LbixwYk0TJF9KAVWs1dZC8FsnT22kQEW/MAI1z33ZikqPbFlSLd2gJsX5JHSScJe/cY9NUJzu0o6ZOHXKvVw0G4XdszjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 18:44:51 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 18:44:51 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for gtk-egl
 and gtk-gl-area
Thread-Topic: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for gtk-egl
 and gtk-gl-area
Thread-Index: AQHcqru+pkfTkzjQPEWYdRgNLoERELWdFkIAgAAGLGCAAvXCgIAANuIw
Date: Thu, 5 Mar 2026 18:44:51 +0000
Message-ID: <PH0PR11MB51123BA9B3B7F9C341D18B1CFA7DA@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260303030714.1926907-1-dongwon.kim@intel.com>
 <CAJ+F1C+ownUskL4troo57_GxJjGaZvX2sHCJoc4KjYm3rU-oQw@mail.gmail.com>
 <PH0PR11MB511248C615D6433E2ED7E7D4FA7FA@PH0PR11MB5112.namprd11.prod.outlook.com>
 <CAJ+F1C+BGW3hzLc8jnxKXxmY3-jkQ85=BSWc+sPhOZ86bzsjVQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+BGW3hzLc8jnxKXxmY3-jkQ85=BSWc+sPhOZ86bzsjVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|PH8PR11MB7023:EE_
x-ms-office365-filtering-correlation-id: 35ca542e-70e9-443f-618f-08de7ae748e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: y+iQF38ECDW8g3nqW3Y4/9u8cZNfjkYQCmhQlxzZne310hrK/EUeOFCwRSG5rijYHkQZuzwXd/WBqEJiMd3udLyDo+4AZTW3eUz+PNIWsecTrZM04UiQePScNvIDeK/KGraV6PCSqkajNrblW6dNeF8FFEoutSYBuuO5yPk5k4nnb5va67Zi/LMC40EdRZ49l657EYSBPpG4PJFfxtS71+mGKk8kfVabw0+soth500SxtfEnQbh1IIxUQO4yz3l0s53C2Erw3Zebd7NAaMyHkRXebH5NoiBG9w4lN4x5BLfJN1fScx4AVu/U6YRVNgjQEAV7ByKTtzaIG68FiD2+M7R/BMxfFtjp+BfhvTR3XRWXaxvVzZHeR/HtQnsLFVSz/qdWGJgIB8UcHP3JIcmLIeDKbEg+/AvyGo4DRzdk1tfDeST5k75sAnN45n/upNGT/DYloaUqjHi3JUtPdnZIZjI9ou4vv5TO6ZXC70+sV5B27eS2GN9GhGY8FIIAyiCTvXmDF9vsKpEIxSV84LQVWtYzlHNZzSCdLF0iu0RspHsOl9f22RnCcBcpI/CvCFhp9StU87CmsXV34HIU+yBuBf6e2l7THJJuUVURwXqoP8W0hwy5e5vW+BNM+dFVlq6dqNkTeDFDmoMapDwgU9AMwqZJNM4eJNDOC807VdY/OborsoTaOpizYNK7F8Y0gd4RCLLVp6h1fNRHbJicLWuxEL83byvpjezPgpU2VhoTkdQpxVpZ0RTG0fauKrz/9r1MiTbf9sVG661GH6b4uZmgt/tU6gfRwWvZnR8lZ8IqZAc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGtzZ3BQc0dWa1FjM1ZZc3ZqdXhtM0V5cG54MnVDVHZodTBqRDZNaXVqeE9G?=
 =?utf-8?B?T29FWndJTzhWV3p3ZXRIV29YMkF5eU56N2kzMUVOZVUxKzVGS1lLRHYzQmU2?=
 =?utf-8?B?QklmTVYxR2tJeWhxY3dWVzd1R0ZyNkJXT1lrY0hzdnd2cGM1VUtkdHBEbGh2?=
 =?utf-8?B?MkZkbFkzNEFWbFVhYWdvSFlsOWsrZHh0UWlrOHAvUTdXQkdkenpZd1hVRUx6?=
 =?utf-8?B?R3NNNkVWRXVXRHpreUl2QmY5cktGRTdaTVY1MWMycFdSTVgvcTd0ZHVEbDBS?=
 =?utf-8?B?bjIwWHZFQkR1N3JpcUh6ekVtcEhUY1ViSi9ST2JEMFlRUXVDeUt4YVAyYzAw?=
 =?utf-8?B?RnVhdEhDWHJEOXh5dDREcmhUenFaUUFCUktQOE9URWd5elNZbmthdDhMbytx?=
 =?utf-8?B?ajVvY2dqSndpVUREVlZIUWUvTXFYdFZJUTZaVTVqK3gxdEJ3cTREZytBSldM?=
 =?utf-8?B?cWxYb1pCZXBoR0F0TXlhUmd5akc4blN5WUpEZ2VXR0NTbHNBZktZQytVV1dP?=
 =?utf-8?B?RVFxMXdEWUJ4cFBESVVsOW9YWE5EaENnL093aVpoZXNsT21GZWk4S3lmYkJj?=
 =?utf-8?B?R280b2xFZ0dvTDhvVDJhMGI1ZkR4cG5pVnJuUk5zZFZUcURPYmtld2lTdmN6?=
 =?utf-8?B?VjdTOGFVb000M1d4aGptWG8zdGoyNUU4WSs0bFJvMW1ZNzdOODhsekh3N0NT?=
 =?utf-8?B?VzBMeWtZdk1ydHF4clNqT3Y4TmNCcW9XdjBTek1nazhCWUdWV0RaaVZjM1BI?=
 =?utf-8?B?dzVtbHdXU1hzL09aNkJRZUpNT0ZSTHExWmF0QWp5b0R3RW0zTW44U0U4eHVK?=
 =?utf-8?B?aVRIY0NRVG5ldmtiUTkwSFhieElFSXc2WTRGL01CZnNDdlRmN0tsSFlmRE5l?=
 =?utf-8?B?NGhlaG45SDZuVUxsbHV3bnRJdUhWQ3lDd2toanFSNnd0ME0rTm5iYWhvSGJP?=
 =?utf-8?B?SWdBY1Rpazk1VEZ0cHo5cUxab0JCci9PaEpHRWRuTlVXRGc3UDZMbDlPTnYw?=
 =?utf-8?B?UkhkV3lPVjA5ZzdweU1iOVFJRU0xeU9tMm83Z0lkNlo5WDBWaklKaHdlQ3h6?=
 =?utf-8?B?SEYwYXJLSVJDOTNodzB1ZVY5dE1mSGdITmwzSXlPQnBLSUEvZk9Ed1ZHcEt1?=
 =?utf-8?B?NmpkRnBBWnFRUjBsL243NkRlczhsRjlqbFc3ZEt0WWZGdU85NGZ1d1U2ZlEz?=
 =?utf-8?B?ZWRKb2xHeGQ1NjRGbVdaK2phWC9qdG1rSjJqWFVnRkZjU040MC9UdnROOVFV?=
 =?utf-8?B?YjZNQWFFZXNvQkJkbjdMWVB4TTllbXN6R2Z1bzZpRDNDLzNZaWFSV01sblhN?=
 =?utf-8?B?cEo1cnZLOFdZOTk0dEpic25VRzdTWE1Cd0V0cTBMNEVHUHpXdkZaNHpQbk1D?=
 =?utf-8?B?VzFyUkY0MEduNCtIOHhpZkxJbjBOZW50b3IwZEpqcHY0M1dCT3ltSmVpZDZm?=
 =?utf-8?B?UTA5bWxrMFdSUnBGVkd1bDJTZUM4QWxoNE9xbmpUQjNleE13d3ZUU0pxeFdQ?=
 =?utf-8?B?OFdUZzEyb1REdkgvVFA0S3pKQko4RU1WM0VDS3owN1NuLzdNV09RYVRFOWt6?=
 =?utf-8?B?ZUloSXBGajRhTkkvcDJueERWMXlGcGVMelk4WThidjFtRzNlaWlwWlByWlVV?=
 =?utf-8?B?clpxR05KSWovZGJHTGxabEtyOGFSblkvZ3lDMURndWxiazFhdG9LcW1QZUg3?=
 =?utf-8?B?Q3ozT0YwbytmQ1o5WTc4MlRsWGtLV1FmU2tYSmVLMXkyRzJMTHVvWWdvUVB2?=
 =?utf-8?B?UkV0V3JaK2JScjJYRHNGb3N6NE9sa2g5MFI2NFVQVWFORkpyK0F5MXg2ekxh?=
 =?utf-8?B?OTliRnFSWkZsd202TCtqaFdhUXRJOS9ta3FyRTd4NFMrY1dyZ2FGRVpSOGY2?=
 =?utf-8?B?bWlvclFkUlBSd0tYNlJtcGU4QVJsZW13dGVRUHhGQXg5VG9ocnFYRU4vbXpN?=
 =?utf-8?B?bnc5dkRQQ1Z2M3F5K3E4VlZYeVJVSHZxVkZsUC9JM20zV2hlZUZpWGlON2ZB?=
 =?utf-8?B?QXNIMU5pWVZ0Rlhabkd2QzgwNURocDFjYXBJMkUwcklxcnRiOU5XdlkxZ29F?=
 =?utf-8?B?RjAzaFV3R3JaRUNZUG1ESTl1TXRkeS9YZk5FWVQvMW92UEdxSGphRVJvRmhr?=
 =?utf-8?B?bE91VmtLOTdQVURXT0d1aXN1cVRMVkhEVDc1dmV2SUhkZFMvQm90Q0R2dWh0?=
 =?utf-8?B?cUlqOXBpRzBxTjkxa2FGb3pmb3JJVnFqVnJmd3Bnb0Y0cndkUm1sTU5UMHd1?=
 =?utf-8?B?a3J4UlVFS2Qzb3poS01MSisxSW85ZHNVT3RHUUlkZEJUUE52RERxQnVGYTI0?=
 =?utf-8?B?bGdzdldueXM4ZlhCU29PWTgwVEpyTEZSY2lNUlRGZVFwbVk0MVhGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Or4cwddz5If5KrJX1Q4Q8XW60y8d6fJSig0nkFQflaJzhwWrKqUPlOpUfmhWf7Mt5xyY7LLjZiyONMfNc053JSBR77F1BGv5XI53atisjJ4Hb5TTsA26yGnNzOGrSZ54hdtUzeat5loVP1gw46uneemAr1fpeRixg/8GmloSRDeMYl0/WrdMTKdVrC5aXp/gtj52Zfv3wVFRylHBxw9rEc/hnCTynPnQxvGbFeWOUmFeql1+x1bKp+hNjzSrXhq5iUQ6Wv2zk4nvsVudKjeM+KgQa/aGVyZrkbtTI9Vc7SVGK0u6AU+oCeU6ZqmD4B4OeHlK8H3roMoJSB6Qh/j22w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ca542e-70e9-443f-618f-08de7ae748e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 18:44:51.1933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+yobyhuUIjGzWhKIBFGYIF1p0QYf1cmyyCLfzF24mxiIzgy25RQ+s6v7tRx3+qbDIaPr5SvY8Ef8FbLfKYdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdWkvZ3RrOiBJbXBsZW1l
bnQgZHB5X2dsX2N0eF9kZXN0cm95X3RleHR1cmUgZm9yIGd0ay0NCj4gZWdsIGFuZCBndGstZ2wt
YXJlYQ0KPiANCj4gSGkNCj4gDQo+IE9uIFR1ZSwgTWFyIDMsIDIwMjYgYXQgNzo1MOKAr1BNIEtp
bSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhp
IE1hcmMtQW5kcsOpLA0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSB1aS9ndGs6IElt
cGxlbWVudCBkcHlfZ2xfY3R4X2Rlc3Ryb3lfdGV4dHVyZQ0KPiA+ID4gZm9yIGd0ay0gZWdsIGFu
ZCBndGstZ2wtYXJlYQ0KPiA+ID4NCj4gPiA+IEhpDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBNYXIg
MywgMjAyNiBhdCA0OjEz4oCvQU0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4gd3JvdGU6DQo+ID4g
PiA+DQo+ID4gPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+
ID4gPiA+DQo+ID4gPiA+IEN1cnJlbnRseSwgdGhlIHRleHR1cmUgYXNzb2NpYXRlZCB3aXRoIGEg
RGlzcGxheVN1cmZhY2UgaXMgbm90DQo+ID4gPiA+IGRlbGV0ZWQgd2hlbiB0aGUgc3VyZmFjZSBp
cyBzd2l0Y2hlZCBvciBmcmVlZCwgbGVhZGluZyB0byBhIG1lbW9yeQ0KPiA+ID4gPiBsZWFrIGlu
IHRoZSBHUFUgcHJvY2Vzcy4gVGhpcyBvY2N1cnMgYmVjYXVzZSB0aGUgR1RLIGJhY2tlbmQgbGFj
a3MNCj4gPiA+ID4gYSBtYXBwaW5nIGZvciB0aGUgJ2RweV9nbF9jdHhfZGVzdHJveV90ZXh0dXJl
JyBvcGVyYXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGUg
bmVjZXNzYXJ5IGNsZWFudXAgZnVuY3Rpb25zIGZvciBib3RoIEVHTA0KPiA+ID4gPiBhbmQgR0wg
QXJlYSBiYWNrZW5kcy4gRWFjaCBpbXBsZW1lbnRhdGlvbiBlbnN1cmVzIHRoZSBhcHByb3ByaWF0
ZQ0KPiA+ID4gPiBHTCBjb250ZXh0IGlzIG1hZGUgY3VycmVudCBiZWZvcmUgY2FsbGluZw0KPiA+
ID4gPiBzdXJmYWNlX2dsX2Rlc3Ryb3lfdGV4dHVyZSgpLCBlbnN1cmluZyB0aGF0IHRoZSB1bmRl
cmx5aW5nIEdMIHRleHR1cmUgSUQNCj4gaXMgc2FmZWx5IHJlbGVhc2VkIGJ5IHRoZSBkcml2ZXIu
DQo+ID4gPiA+DQo+ID4gPiA+IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4N
Cj4gPiA+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQu
Y29tPg0KPiA+ID4gPiBDYzogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwu
Y29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGluY2x1ZGUvdWkvZ3RrLmggfCAgNCArKysr
DQo+ID4gPiA+ICB1aS9ndGstZWdsLmMgICAgIHwgMTAgKysrKysrKysrKw0KPiA+ID4gPiAgdWkv
Z3RrLWdsLWFyZWEuYyB8ICA4ICsrKysrKysrDQo+ID4gPiA+ICB1aS9ndGsuYyAgICAgICAgIHwg
IDIgKysNCj4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91aS9ndGsuaCBiL2luY2x1ZGUvdWkvZ3Rr
LmggaW5kZXgNCj4gPiA+ID4gM2U2Y2UzY2I0OC4uZjE3NjVhZDVjYiAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvaW5jbHVkZS91aS9ndGsuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL3VpL2d0ay5oDQo+
ID4gPiA+IEBAIC0xNzAsNiArMTcwLDggQEAgdm9pZCBnZF9lZ2xfc3dpdGNoKERpc3BsYXlDaGFu
Z2VMaXN0ZW5lciAqZGNsLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIERpc3BsYXlTdXJm
YWNlICpzdXJmYWNlKTsgIFFFTVVHTENvbnRleHQNCj4gPiA+ID4gZ2RfZWdsX2NyZWF0ZV9jb250
ZXh0KERpc3BsYXlHTEN0eCAqZGdjLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUUVNVUdMUGFyYW1zICpwYXJhbXMpOw0KPiA+ID4gPiArdm9pZCBnZF9lZ2xf
ZGVzdHJveV90ZXh0dXJlKERpc3BsYXlHTEN0eCAqZGdjLA0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIERpc3BsYXlTdXJmYWNlICpzdXJmYWNlKTsNCj4gPiA+ID4gIHZvaWQg
Z2RfZWdsX3NjYW5vdXRfZGlzYWJsZShEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCk7ICB2b2lk
DQo+ID4gPiA+IGdkX2VnbF9zY2Fub3V0X3RleHR1cmUoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpk
Y2wsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYmFja2lu
Z19pZCwgQEAgLTIwNiw2ICsyMDgsOA0KPiA+ID4gPiBAQCBRRU1VR0xDb250ZXh0IGdkX2dsX2Fy
ZWFfY3JlYXRlX2NvbnRleHQoRGlzcGxheUdMQ3R4ICpkZ2MsDQo+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUUVNVUdMUGFyYW1zICpwYXJhbXMpOw0KPiA+
ID4gPiB2b2lkIGdkX2dsX2FyZWFfZGVzdHJveV9jb250ZXh0KERpc3BsYXlHTEN0eCAqZGdjLA0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VR0xDb250ZXh0IGN0
eCk7DQo+ID4gPiA+ICt2b2lkIGdkX2dsX2FyZWFfZGVzdHJveV90ZXh0dXJlKERpc3BsYXlHTEN0
eCAqZGdjLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEaXNwbGF5
U3VyZmFjZSAqc3VyZmFjZSk7DQo+ID4gPiA+ICB2b2lkIGdkX2dsX2FyZWFfc2Nhbm91dF9kbWFi
dWYoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUWVtdURtYUJ1ZiAqZG1hYnVmKTsgIHZvaWQNCj4gPiA+ID4gZ2RfZ2xf
YXJlYV9zY2Fub3V0X3RleHR1cmUoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wsIGRpZmYgLS1n
aXQNCj4gPiA+ID4gYS91aS9ndGstZWdsLmMgYi91aS9ndGstZWdsLmMgaW5kZXggYWU5MjM5OTk5
Yy4uYzFiMzJiYzQxYiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdWkvZ3RrLWVnbC5jDQo+ID4gPiA+
ICsrKyBiL3VpL2d0ay1lZ2wuYw0KPiA+ID4gPiBAQCAtMjI1LDYgKzIyNSwxNiBAQCBRRU1VR0xD
b250ZXh0DQo+ID4gPiBnZF9lZ2xfY3JlYXRlX2NvbnRleHQoRGlzcGxheUdMQ3R4ICpkZ2MsDQo+
ID4gPiA+ICAgICAgcmV0dXJuIHFlbXVfZWdsX2NyZWF0ZV9jb250ZXh0KGRnYywgcGFyYW1zKTsg
IH0NCj4gPiA+ID4NCj4gPiA+ID4gK3ZvaWQgZ2RfZWdsX2Rlc3Ryb3lfdGV4dHVyZShEaXNwbGF5
R0xDdHggKmRnYywgRGlzcGxheVN1cmZhY2UNCj4gPiA+ID4gKypzdXJmYWNlKSB7DQo+ID4gPiA+
ICsgICAgVmlydHVhbENvbnNvbGUgKnZjID0gY29udGFpbmVyX29mKGRnYywgVmlydHVhbENvbnNv
bGUsDQo+ID4gPiA+ICtnZnguZGdjKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgIGVnbE1ha2VD
dXJyZW50KHFlbXVfZWdsX2Rpc3BsYXksIHZjLT5nZnguZXN1cmZhY2UsDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgdmMtPmdmeC5lc3VyZmFjZSwgdmMtPmdmeC5lY3R4KTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgIHN1cmZhY2VfZ2xfZGVzdHJveV90ZXh0dXJlKGRnYy0+Z2xzLCBzdXJm
YWNlKTsgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICB2b2lkIGdkX2VnbF9zY2Fub3V0X2Rpc2FibGUo
RGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wpICB7DQo+ID4gPiA+ICAgICAgVmlydHVhbENvbnNv
bGUgKnZjID0gY29udGFpbmVyX29mKGRjbCwgVmlydHVhbENvbnNvbGUsDQo+ID4gPiA+IGdmeC5k
Y2wpOyBkaWZmIC0tZ2l0IGEvdWkvZ3RrLWdsLWFyZWEuYyBiL3VpL2d0ay1nbC1hcmVhLmMgaW5k
ZXgNCj4gPiA+ID4gY2Q4NjAyMmQyNi4uODRlNDFmNDIyMSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
dWkvZ3RrLWdsLWFyZWEuYw0KPiA+ID4gPiArKysgYi91aS9ndGstZ2wtYXJlYS5jDQo+ID4gPiA+
IEBAIC0yOTksNiArMjk5LDE0IEBAIHZvaWQgZ2RfZ2xfYXJlYV9kZXN0cm95X2NvbnRleHQoRGlz
cGxheUdMQ3R4DQo+ID4gPiAqZGdjLCBRRU1VR0xDb250ZXh0IGN0eCkNCj4gPiA+ID4gICAgICBn
X2NsZWFyX29iamVjdCgmY3R4KTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gK3ZvaWQg
Z2RfZ2xfYXJlYV9kZXN0cm95X3RleHR1cmUoRGlzcGxheUdMQ3R4ICpkZ2MsIERpc3BsYXlTdXJm
YWNlDQo+ID4gPiA+ICsqc3VyZmFjZSkgew0KPiA+ID4gPiArICAgIFZpcnR1YWxDb25zb2xlICp2
YyA9IGNvbnRhaW5lcl9vZihkZ2MsIFZpcnR1YWxDb25zb2xlLA0KPiA+ID4gPiArZ2Z4LmRnYyk7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICBndGtfZ2xfYXJlYV9tYWtlX2N1cnJlbnQoR1RLX0dM
X0FSRUEodmMtPmdmeC5kcmF3aW5nX2FyZWEpKTsNCj4gPiA+ID4gKyAgICBzdXJmYWNlX2dsX2Rl
c3Ryb3lfdGV4dHVyZShkZ2MtPmdscywgc3VyZmFjZSk7IH0NCj4gPiA+ID4gKw0KPiA+ID4gPiAg
dm9pZCBnZF9nbF9hcmVhX3NjYW5vdXRfdGV4dHVyZShEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRj
bCwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYmFj
a2luZ19pZCwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBi
YWNraW5nX3lfMF90b3AsIGRpZmYgLS1naXQNCj4gPiA+ID4gYS91aS9ndGsuYyBiL3VpL2d0ay5j
IGluZGV4IDllYmU3ZThkZjAuLjIxN2Y0MjUwNzUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL3VpL2d0
ay5jDQo+ID4gPiA+ICsrKyBiL3VpL2d0ay5jDQo+ID4gPiA+IEBAIC02MzYsNiArNjM2LDcgQEAg
c3RhdGljIGNvbnN0IERpc3BsYXlHTEN0eE9wcyBnbF9hcmVhX2N0eF9vcHMgPQ0KPiB7DQo+ID4g
PiA+ICAgICAgLmRweV9nbF9jdHhfaXNfY29tcGF0aWJsZV9kY2wgPSBnZF9nbF9hcmVhX2lzX2Nv
bXBhdGlibGVfZGNsLA0KPiA+ID4gPiAgICAgIC5kcHlfZ2xfY3R4X2NyZWF0ZSAgICAgICA9IGdk
X2dsX2FyZWFfY3JlYXRlX2NvbnRleHQsDQo+ID4gPiA+ICAgICAgLmRweV9nbF9jdHhfZGVzdHJv
eSAgICAgID0gZ2RfZ2xfYXJlYV9kZXN0cm95X2NvbnRleHQsDQo+ID4gPiA+ICsgICAgLmRweV9n
bF9jdHhfZGVzdHJveV90ZXh0dXJlID0gZ2RfZ2xfYXJlYV9kZXN0cm95X3RleHR1cmUsDQo+ID4g
PiA+ICAgICAgLmRweV9nbF9jdHhfbWFrZV9jdXJyZW50ID0gZ2RfZ2xfYXJlYV9tYWtlX2N1cnJl
bnQsICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiBAQCAtNjcwLDYgKzY3MSw3IEBAIHN0YXRpYyBjb25z
dCBEaXNwbGF5R0xDdHhPcHMgZWdsX2N0eF9vcHMgPSB7DQo+ID4gPiA+ICAgICAgLmRweV9nbF9j
dHhfaXNfY29tcGF0aWJsZV9kY2wgPSBnZF9lZ2xfaXNfY29tcGF0aWJsZV9kY2wsDQo+ID4gPiA+
ICAgICAgLmRweV9nbF9jdHhfY3JlYXRlICAgICAgID0gZ2RfZWdsX2NyZWF0ZV9jb250ZXh0LA0K
PiA+ID4gPiAgICAgIC5kcHlfZ2xfY3R4X2Rlc3Ryb3kgICAgICA9IHFlbXVfZWdsX2Rlc3Ryb3lf
Y29udGV4dCwNCj4gPiA+ID4gKyAgICAuZHB5X2dsX2N0eF9kZXN0cm95X3RleHR1cmUgPSBnZF9l
Z2xfZGVzdHJveV90ZXh0dXJlLA0KPiA+ID4gPiAgICAgIC5kcHlfZ2xfY3R4X21ha2VfY3VycmVu
dCA9IGdkX2VnbF9tYWtlX2N1cnJlbnQsDQo+ID4gPg0KPiA+ID4gQnV0IHRoZXJlIGlzIG5vIGRw
eV9nbF9jdHhfY3JlYXRlX3RleHR1cmUoKSwgaG93IGNhbg0KPiA+ID4gZHB5X2dsX2N0eF9kZXN0
cm95X3RleHR1cmUoKSBnZXQgY2FsbGVkPw0KPiA+DQo+ID4gVGV4dHVyZXMgYXJlIGFsc28gY3Jl
YXRlZCB2aWEgc3VyZmFjZV9nbF9jcmVhdGVfdGV4dHVyZSBpbiB0aGUgcGxhY2VzDQo+ID4gbGlr
ZSwNCj4gPg0KPiANCj4gQnV0IHN1cmZhY2VfZ2xfe2NyZWF0ZSxkZXN0cm95fV90ZXh0dXJlIGRv
ZXNuJ3QgbWFrZSB1c2Ugb2YNCj4gZHB5X2dsX2N0eF9kZXN0cm95X3RleHR1cmUuIFRoZSBsYXRl
ciBpcyBvbmx5IHVzZWQgYnkgZGJ1cyBzbyBmYXIsIHNlZQ0KPiBjb21taXQgNTg5MDg5ZmVlZSAo
InVpL2RidXM6IGZpeCB0ZXh0dXJlIHNoYXJpbmciKS4NCg0KSSB0aG91Z2h0IGFkZGluZyB0aGUg
Y2FsbCBiYWNrIHdhcyB0aGUgc2ltcGxlc3Qgd2F5IHRvIGF2b2lkIHRoZSBtZW0gbGVhaw0Kd2Ug
b2JzZXJ2ZWQgYnV0IG5vdyBJIHVuZGVyc3RhbmQgdGhpcyBhcHByb2FjaCBsb29rcyBtb3JlIGxp
a2UgYSBXQS4NCkkgd2lsbCB0YWtlIGEgbG9vayBpbnNpZGUgZ3RrLWVnbC5jIGFuZCBjaGVjayBp
ZiB0aGVyZSBpcyBiZXR0ZXIgd2F5IHRvIHByZXZlbnQNCnRoZSBjb3JuZXIgY2FzZS4gUHJvYmFi
bHkgdGhlIHJvb3QtY2F1c2UgaXMgdGhhdCB0aGUgcHJldmlvdXMgY29udGV4dCB3YXMgbm90DQpk
ZXN0cm95ZWQgcHJvcGVybHkuDQoNCj4gDQo+ID4gZ3RrLWVnbC5jDQo+ID4gc3RhdGljIHZvaWQg
Z3RrX2VnbF9zZXRfc2Nhbm91dF9tb2RlKFZpcnR1YWxDb25zb2xlICp2YywgYm9vbCBzY2Fub3V0
KQ0KPiA+IHsgIC4uLi4uDQo+ID4gICAgICAgIGVnbF9mYl9kZXN0cm95KCZ2Yy0+Z2Z4Lmd1ZXN0
X2ZiKTsNCj4gPiAgICAgICAgIGlmICh2Yy0+Z2Z4LnN1cmZhY2UpIHsNCj4gPiAgICAgICAgICAg
ICBzdXJmYWNlX2dsX2Rlc3Ryb3lfdGV4dHVyZSh2Yy0+Z2Z4LmdscywgdmMtPmdmeC5kcyk7DQo+
ID4gICAgICAgICAgICAgc3VyZmFjZV9nbF9jcmVhdGVfdGV4dHVyZSh2Yy0+Z2Z4LmdscywgdmMt
PmdmeC5kcyk7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiBzdXJmYWNlX2dsX2NyZWF0ZV90ZXh0
dXJlIGFsd2F5cyBjb21lIGFmdGVyIHN1cmZhY2VfZ2xfZGVzdHJveV90ZXh0dXJlDQo+ID4gc28g
dGhlcmUgaXMgbm8gbGVhayB3aGlsZSB0aGUgZ3Vlc3QgaXMgcnVubmluZyBidXQgdGV4dHVyZSB3
b3VsZA0KPiA+IHJlbWFpbiB1bnJlbW92ZWQgaWYgd2UgZG8gbm9uZSBpbiBkcHlfZ2xfY3R4X2Rl
c3Ryb3lfdGV4dHVyZSgpIHdoZW4NCj4gdGhlIGd1ZXN0IGlzIHJlYm9vdGluZy4NCj4gPg0KPiA+
ID4NCj4gPiA+ID4gIH07DQo+ID4gPiA+ICAjZW5kaWYNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi40
My4wDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiBNYXJj
LUFuZHLDqSBMdXJlYXUNCj4gPg0KPiA+IFRoYW5rcw0KPiANCj4gDQo+IA0KPiAtLQ0KPiBNYXJj
LUFuZHLDqSBMdXJlYXUNCg==

