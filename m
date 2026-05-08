Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ACCCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLI7n-0002xI-K2; Fri, 08 May 2026 06:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLI7g-0002wx-Hm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:07:57 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLI7e-0003Wa-2w
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778234875; x=1809770875;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FZvYUqdE+3vW1oKLEJXxlqfPWoGikETmeFM5xe8zK4c=;
 b=NpTkNJtyogmgRliumtzH2U5MEMu+5Yj339ax1lUN5CoqN5OyJm3UsZpN
 SJum21AlXW6DPVJRjpOGU0Kjz5BGgH0xY1+bYTSwZTofbh37uYE2HapeQ
 vIN32wVZjw2nG5On+QO8koRiV5C8BAQ8/P1+O10JTEwMxPOwh5XK6Gec9
 16D2tsBbsVLm7xIpy9fcRCC5gJ9ER+uHF166pBN4QQD/tt6DjN/JqpK5Q
 ZKq8Nt/rs0S8axiD9uZAs1Fhz4LsT1yp6osDoI+yHxVXIKfxjSIrDXfLw
 k5BiiU7R/6+JffHQL8qz6Ay8YwVhy3kIO/17ZlCiIwPRtTskZRhaJCEw5 g==;
X-CSE-ConnectionGUID: Av3OHoslSdOoNXXeOr+ggQ==
X-CSE-MsgGUID: j4Wwl130RH2X0MetkjOoxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90663721"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="90663721"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 03:07:44 -0700
X-CSE-ConnectionGUID: yJk/Eo+5T1iqZdP8wuE0qw==
X-CSE-MsgGUID: xoQOTLzITri2XtiyxlMtyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="240721694"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 03:07:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 03:07:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 03:07:42 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 03:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGyfkuKp3AhXj8mMxhmuyEOOefOdEB4oyiLNlfibkMO3RGcR/AdrEokIrAy7jGLA8T+D0P2AYPqDoH5nEf6KnXzs/VJz5bKjEofGkxG2KYyAosohgabAV43GKk2qVPQO5jTf9eKEUelrfGhh6ieYNA5K8cV3hUMhg3yNueRbQJTcXa0/58x1B3PxvoWgirtXtIMVKr2Ml4WXEWnPydndOW6UFvt0yV5EWHNY1K7Cfny0THXcENdjVBgZC6LXhgvbgpnnqE+qrYIa/hTii9/pM43BxiXUKajDPXd9m78lXiuof6Lc6xLBK09u7DSfLEOeii6Ha6gI5v/EaDHSpkXTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZvYUqdE+3vW1oKLEJXxlqfPWoGikETmeFM5xe8zK4c=;
 b=fzRqU9RNJ2uea6F8QH+okPFgcEiYeKN2H2u2yvTs3QTYDN99TclKPkvV5KirOfFjoU+cf4V2WmhQyqcWiQ49n1Bz/vqWMShPwvV9rc803JtxlkM3pIJAGQd1HrMXySRCTAyN1Ide6F2WRxOB9IpbZezU594vpsN3UPP5d/ia9zXESog7/MzuWfAWo5s47yUe6DHq31oUVAPxdEv90yrN6NMzC40YLDY2tEelR1FBK7rHic7LMV8KL8yWYFwSuYDn0KkxljxbCYeomKC/m9wtETr2R3wDNEsOP8Lzd6xm4WOpL5eM4v3QHjhptZAxy1WeaMI1oJDJ/WHnNf9CLSFIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LVXPR11MB9754.namprd11.prod.outlook.com (2603:10b6:408:386::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 10:07:40 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 10:07:39 +0000
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
Subject: RE: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHc2HD8BanUNHqXVU60FS6iP2zM9rYD6xsAgAAIpKA=
Date: Fri, 8 May 2026 10:07:39 +0000
Message-ID: <IA3PR11MB913649C77D24514A63EDA48D923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-9-zhenzhong.duan@intel.com>
 <3bb34821-5de5-42a8-9a1f-d0dba55d1689@intel.com>
In-Reply-To: <3bb34821-5de5-42a8-9a1f-d0dba55d1689@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LVXPR11MB9754:EE_
x-ms-office365-filtering-correlation-id: e3c42beb-4682-4b15-5a8d-08deace9a32f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|10070799003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: VavjrR3VcQwR8pY3TOI2KyX5mV+tQsQgjEXIuyQnbfV7vxHZIY6z2CmuRe08cn1hUeg74OiRTGKHU6t13rSE8frA4qrOlOWA6qeVrZrv+aJ7FWP0aqR/FbHrIqNYPMqDApfiAazXcuLaLC8XImAmDWV1yTdsgSaazrFIB3gp6CSxpDXpHySKxLojRpNyQwVFblvwAW+jgembDP4W+VJPV5WUaZ2pIKnw0szsJzAFTaa8o536TDjZwm3AjOLIz6aVYOG3RhsI+GUzMBUjQMIJCGhVctUVsd2ThKXK0SmEt+fMXpoKHLmz1b07+YTvI+2tlPjG1+duc2Y0rs21yXonsH7loUxHXiarlU0q8jSQuwABVuDe9y5C0Y5kqq6vzQg9hluxMH4BGfG2b3gw3oKr3I9eaL2BhQW0SDainEr3CgkRC61p6ggtv+cQ4b7Nr77gzIEt86oUF83xVCA3bv/BthiFoovo8xwouUo5FqeGW8vHCQqMVYSkpH+OT6rFDXDG4tTKlmxYNAlM8ONCy+5XIzcfzazf40GxDNC3Hh/g72wiUTqsiHVTmoLFbiggfnVX0Q9K6yU6azTOSBAsOZ7/vWy/Fx3OWWOMgomGe8V/TDDQQke9i77fCvOaEuAE+KVD8v77p42bi78Na+MKygFDcD/sKKa54iulTQtXOW49C1PHwBrOUsEor85mIfgKC7sQTmTdjPV1FU5XPLLtOhGWa+V1E6EH6btpuFvbrQ7YKIPoiGja+DLX7rUY7qiLwBUU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09GWDVLN3JjVXp4U1luNDhVTFVkcXp3bUh2VC82TzllUDFkTG9VSFArQU1O?=
 =?utf-8?B?OElFUW4xb1V1U1d2MlNhKzdSbmxVY1RHN1hDZzl1WlRXS281Y1FYV0NEK3VB?=
 =?utf-8?B?K2syU2pYMTFDWDdTdzl5VUR3aEhnOVllTWtwMU9XdUt0R2x1Z1FaK2QwQzk3?=
 =?utf-8?B?WFM0Vld4OTh0WG0ya2NYMWxnZTg2VGRSVzg1bTRKdjRRaWVwMnRJeVVSSzk4?=
 =?utf-8?B?ZmxBTCtrRmMwNi9TWm9mMEJVcjVRamtPbG9pR2RzbnVmaWZsdjJKV2dwYngw?=
 =?utf-8?B?ckwxRXJCVlBPc2hRMmtlQ2dFR3pxNGtKd0RyNmwzS3hDRXJVUkQyZkZ1Sk5H?=
 =?utf-8?B?andRc0N5Qit3QWU0aisrc2JMQld1enFvemViTkN4SElKejV3N3dtRDJUd0d1?=
 =?utf-8?B?Q3FVREZkZTBQNXorL1J2OFpic0d4MmJQZlVTTkxtN3dHUHliRjAxdld6MUpY?=
 =?utf-8?B?TzY4RStLd2lxczEwRERpTEVxRE4yT3RwZHpzZ2wzWG5Fb09xNC92aXFEK01B?=
 =?utf-8?B?VE1CQmhXajdHYjhjYWsxQUpodGNaMVhVWjExd0Q1ajM1MVpHNm05aGY1emxK?=
 =?utf-8?B?MmZWMjc5RklKY2QrazB6SE11Y0ppUVBmZ0Z5b2s3ay9NSDNPaUtmWVMwTHFE?=
 =?utf-8?B?OXdLL3lDSjBTbVBtUjV5ODJiRUpkR1BXM3U2cDRNRU11ZGI5Zi9MaEk3dHFO?=
 =?utf-8?B?dk9CSWcvWFl0YXEvNHAvdWVuU0dCbFBZbDZzRGVucHV3ZFBIY0U0U1BpRVRJ?=
 =?utf-8?B?M2NsekpGQ0Y0ajhkbHV5bnFvbjEvNU93WWp2SGJLQjNPVHpMZEFMRWNUeDVp?=
 =?utf-8?B?MWRrbkFYSWRGNy9RUjNsZFlQd2ozeW5USjdVUmZKTXZ3NUZhNE54U0ViRFVt?=
 =?utf-8?B?dDVMVU1vK0lNQTFVTktyelE4anRjd1NEUFhtcUxQeHI5bjZXV293VE1aUzJs?=
 =?utf-8?B?ZjRXcTdlSHoxUUhzdXNBb1JsKzdtS2xWSnlsZzlKd0d1ZVVxU0xLVzRvQUJP?=
 =?utf-8?B?L0NORi9vUWlwMjZUSGdSY3BBby9rTXNNYnFIekFVQTZYL0ZCdmU4dE5vL2ZK?=
 =?utf-8?B?WkJGZUFoYi9sS1pxaGhFa3BGdEdZQUJuMi84US9hazlWM0h6VENHRkdsVTlv?=
 =?utf-8?B?eHVTY3Bkb3FRKzRndjkydnliZFJheGp6SWpVWXhOL0doelBBQXlFY1hQTDFy?=
 =?utf-8?B?Y1phcXZhMUZvYW1keHJMUGR1K0R4OTBSMHl1Tk5EUUQwdHp1bVBMQWtiYU9s?=
 =?utf-8?B?UEY1d1YvRU9SbkZDVE5FbWluRldtRHhkS3pwa04wYUQxYVlVYkpVSzBaMEpF?=
 =?utf-8?B?S24zd2ljQVBWQldILzNVZWxyc0YvVUV5V250K21ReVVSbk5QUC8zRGJIelVO?=
 =?utf-8?B?Z3laK3ljTEloczgrekFYNzVTSkxWTEpFdXpUWlc4cWJwL1pGQ01Dc0pCVHFF?=
 =?utf-8?B?M1dxdzlneWphSGlaV25maGVYemhlMkNPZXdVRDRBV0VXTlNvNzlCUkh2Rk1s?=
 =?utf-8?B?dENzQ0RMajV2NjRYOEJsSndFN3dhMzJMaGQrdzdoYWt1TTZ5UGhWZVlNUjdm?=
 =?utf-8?B?STN4UlVNOVEwZjVmRlk2bmpORkZWQ2U3V1poWGljZkxDSUo1clloemNhNG8y?=
 =?utf-8?B?SnNEZmlSSHAvWDhKRHIxME5GQXlWNTlqeEREakw5cEZWV2tzU0xyck9qME56?=
 =?utf-8?B?WFRhcEptaHEycENyb0dEU2JqN0dCajBnR0JSaUdRSmhhR1c2RHkyU1daRUcy?=
 =?utf-8?B?Sm5BK2ZUbVJwQ1hwTnh4TUZWeERhTG42eVlYdmlTaWxYYUEwTnBJSklBNTdD?=
 =?utf-8?B?a3JtcDl1c1JtYnRFNlhvY1Y0emJmMTVzY1dscDVtWXJUOFd3OWdHVXRQSUhM?=
 =?utf-8?B?bUFVdnZuSE55dnNTL1RJTE4xUzhSVVo0SmNjNkQ2dEo2b05pQ1FtbGdTaTU4?=
 =?utf-8?B?Nk85U0w0ekM1eGgySHNQcElUeElkVlJ3b28vd29lR2lzZUdIejdIenREQklW?=
 =?utf-8?B?TzBPckVWd0xBN2s2Z0lsWWppUElJOUVQVHFaT3poMmRCVVd3UG1zbzhTWXRD?=
 =?utf-8?B?MnRhc0NyTVplZ1F4K2YvcVNPODVXU0Y5c1FsYXdGWGJPTm00ZDlaSDJFNWk0?=
 =?utf-8?B?ODRwcjhrVFVTQWZxdnhrV1FqeG5sVE1QOE9TbjNjbUVHTWFEanluZkJqTnBT?=
 =?utf-8?B?dXJ6Q2lKV0kzTWVoVnJPYy9ETjhDU2dFeHN5bWNGZUgvRFM3eDJwUEVRbUNW?=
 =?utf-8?B?TkZ4UkZXR0c1TTArMmJXL1pZcC8yTnFJUGd2TFpSdllwMk1yazFOVnIyMUZQ?=
 =?utf-8?B?RkltSWxhaGZmNmx2YVN4ZTIxVnFQS2ZLTEVtUVc5QVR3MjRGUDhtVXVTQ2xi?=
 =?utf-8?Q?4tabPyc2FG6xY1LF9gcLQq39/LXM+IGwwXhvdH1tKgTRy?=
x-ms-exchange-antispam-messagedata-1: WLq84dcoiNh2sg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HYcLQcWmU8/brvaRdaBm0vxH4c5SSvSTxSE3ew3yQCnjkhjZoiFR71wq8gooemZU03aO51NcHcMHYzQGaR6x/DpE4cnAQLwiwNMg4a+idjgma37CRt0uZcFLyxqx7Kqbnx74rpxtwuzQgFnehIIMf8aVzokgLnsiFWWNiY6ayb7XjYaUBS37hKNm4S+8E/6xYevlGUA4878raRkKsZcfWZFH4dYDQ8H4tYP8jKSQ0zEMFgqixp72B8VPz2EDl0UAmNa0L7M/oKFCbBvJjNURfq5CI7tVRHHB504AB0vYvDu4GKtT3H8l4W2qmJ5bAKpzvJyy3xKXK1LqprYzFPB+bw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c42beb-4682-4b15-5a8d-08deace9a32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 10:07:39.8100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5uNjLPd4Rqi4IKFjlvtBB1KVV9W9ge+Qfo3Y17HcOMCdUoQgB9/VzpBfYqIQfRWJqh9ag08KFZHRtMl/5RwPiPfrtLedFsX593kt9z1Xwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9754
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDgvMTVdIGludGVsX2lvbW11
OiBVc2UgSU9NTVVfTk9fUEFTSUQgYW5kIGRlbGV0ZQ0KPlBBU0lEXzANCj4NCj5PbiA0LzMwLzI2
IDE1OjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEluIHByZXZpb3VzIHBhdGNoIHdlIGlu
dHJvZHVjZWQgYSBnbG9iYWwgbWFjcm8gSU9NTVVfTk9fUEFTSUQoMCkgZm9yDQo+PiBSZXF1ZXN0
cy13aXRob3V0LVBBU0lELCB0aGlzIG1ha2VzIHRoZSBsb2NhbCBtYWNybyBQQVNJRF8wIHJlZHVu
ZGFudC4NCj4NCj5JdCdzIGEgYml0IGNvbmZ1c2luZyAiZm9yIFJlcXVlc3RzLXdpdGhvdXQtUEFT
REkiLCBhIG5hdHVyYWwgcXVlc3Rpb24gaXMNCj53aGF0IGlzIHRoZSBkaWZmZXJlbmNlIHdpdGgg
UENJX05PX1BBU0lELiBJIHRoaW5rICJmb3IgdGhlIFJJRA0KPmF0dGFjaG1lbnQuIiBpcyBvay4g
QWxzbywgbWFyayBubyBmdW5jdGlvbmFsIGNoYW5nZSBpcyBleHBlY3RlZC4NCg0KT0ssIHdpbGwg
ZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

