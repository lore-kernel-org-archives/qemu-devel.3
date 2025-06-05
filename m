Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB558C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 05:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN2yb-0006mN-MD; Thu, 05 Jun 2025 01:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uN2yZ-0006m7-KY
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:17:15 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uN2yV-0003Te-L2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749100631; x=1780636631;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EywEhYywENsL/0oOwzwk0XTM1Ltuf1mDkraQPOhIDNs=;
 b=O6HW/ZlKWTtTdjGZUx0UCMsbP2uz5a8bB4LUITiR072V5kSCoTISrHAM
 KaMbwFvLK3sdqNpmzLDebJcpVR2WK+GgB/IVidX0huVQbBrXvyOWclLQH
 ai9b2r9b5OsgoX4GddR0TpDgSG6uelTppUC1+laetSOJ0HWtz8Ndtj0EU
 xJm6PJFH4dV2GFMZzLVF6DG9BKdXt/uJpXeIpRgfBF7tLOYnYtf3COA03
 2iOlp4mXcBVNUCp33T7msIzIiDxg2EYW+VL56Sy5seN6jFFzkWke66EhT
 NS9MxFoY5LCuua8EljOPi7DXhRmQ7zQ3FQCq/mzO6cqAbvw+xawxEqNBM Q==;
X-CSE-ConnectionGUID: uDfwhfyPRbKJsF3kJ7lJwA==
X-CSE-MsgGUID: gTtMAnPhSMOcp7UmFJ6afw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62559178"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="62559178"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 22:17:07 -0700
X-CSE-ConnectionGUID: wGF9jOPFQs6VfKLMF4Qihw==
X-CSE-MsgGUID: XYr95UduS8uL3T5ZYhmwMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145356476"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 22:17:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 22:17:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 22:17:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 22:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQPB54T8l5ZLULRpUfv6jpr2yjJOtZNqR0TDsxtlxRO9fizLbyypZZx1NYfaUvuDM3hMYPA78kHdo1fgsizcpmiRXQNEtUixWLOlYnuMQYBvJpeFKj/VM7EG2kD42vtmyxeLYgYfI5DqxLIJ6k1XDreslU+BYnDgb1wPuPIzB/Vv1qJrxK6dJweRNl9uzEYPmz6mfiAxLiBVwu7mSio3jDIgynCAT35iRdGYsKYeac+REOnXS9j657/GSEKeH2nxbixBErnkgpANO6s3wdgAK3UVNqloC6r744dDSn/He8F9EemGU7LwYsXZojGjlOeFyxS42CGpJOGITLs2q3LgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EywEhYywENsL/0oOwzwk0XTM1Ltuf1mDkraQPOhIDNs=;
 b=mibOx3yhm4RaqOqjB6Cw/rCBmCPdOQnF7P6BicTIwfpaG1WgoW+kEdcR8BXqYWVlzELcih2S7pNtYFTSYowRD+SrGox9QBgv90ydv/tfeF5y/IH3etByY3hv9DRFjozCZ9z5NiEQWRo5c3OLbxltOk4Kp6ooFf33yVJCnD6yR/s41rvDHpntBA/SR0NneBYkZLcyaui6K5G+Ips5FhXlkAmF+HiOTpzAHM33kDrhTA8F1EftafmejOjlsMZK0YYxlHNFXkQBUevi5g7DHry+9OQ0fzOnSqeCivki9FYV72QI/gPr4K84KbWdsoU0zuUUJJfMWtNm89bl8pzycp8HfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 05:16:50 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 05:16:50 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Michael Scherle
 <michael.scherle@rz.uni-freiburg.de>, "Kim, Dongwon" <dongwon.kim@intel.com>, 
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v5 0/7] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Topic: [PATCH v5 0/7] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Index: AQHb0Fi8QdQO0eCJcUehRebYIm+GqLPyoloAgAE8eoA=
Date: Thu, 5 Jun 2025 05:16:50 +0000
Message-ID: <IA0PR11MB7185D9AF2B80F79B3499DDAEF86FA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <CAJ+F1CKWKEg+80PVcmytOEDzrrvCv7FjvPsHooHQrE3eiHqy1Q@mail.gmail.com>
In-Reply-To: <CAJ+F1CKWKEg+80PVcmytOEDzrrvCv7FjvPsHooHQrE3eiHqy1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DM4PR11MB6382:EE_
x-ms-office365-filtering-correlation-id: 839863fe-3397-4b33-0da9-08dda3f02d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eG4ybFMrME1Wb1hzQjlPcUNqU051bGpTZ0dlZHFMNzdaazk1eXpLeWxVMnky?=
 =?utf-8?B?eGJzSDd5Zm1VZmRyZUZCWDBmczFvWnMwYVY0dmN0Znh0SnIzaXhLTkFOSlg3?=
 =?utf-8?B?MTd0UTNMMzZYaW5hQm5nRHpnbU84Ry9HSzJsa05ZcFdZMzRsWkhRRU9oRXd4?=
 =?utf-8?B?dkx1Sm1OQU5jZVJSTGgzMnd3ZW1nUkVvQklRN1JuZEVOT3Y1RXVRUkxBVHVO?=
 =?utf-8?B?YktjbjBmUkhud0V0UjRvcUtBTXNJOFM4SW81NFFNUlJURWs4NUZxV1ZrUWdw?=
 =?utf-8?B?UEJUdlZoMndHR0I3UVRtTUh4Z1Qremt2enhTQ0Z4QTJ4OTM3TFlqQ3pmM0I4?=
 =?utf-8?B?NUVVaXBXTkcxekc0Qlg5N0w1enBKdmlMVFFFRlBiSGVnY3FUMHFTZjBnekVt?=
 =?utf-8?B?ckFPMHhLRFYwNmtaUkpONVQwTVViNTI3d3M5Vng1dlBkMXJiTTFTWE84aUxZ?=
 =?utf-8?B?Snd3WVpBUjFQMXNkaU9IWEt1TVVVcGZ4aWZjQUl2TjN2N0xIYXI2dWxBNlc4?=
 =?utf-8?B?dFNrM3licStXWjU5ZjIyZ0tieXMvSjhRQVJBUDVQaHNHNkVyczkvL3hlRHpi?=
 =?utf-8?B?TVZxbXU5SGVlaFk3c3kwMWF0eVZWVWU3VjlUZVU2dDFvSFpxc0FtblBKNy9z?=
 =?utf-8?B?NzhDMmlEaXFoa0ZXL1BBaDcrcnF2ZSthNkhpbm8rbTdpVkFmcW5idlRSbDNT?=
 =?utf-8?B?dk8xSDk4UEFBcFRWZWlUOG95bk1wbnJmd1JnVUJMREhERkh5MFo0T2hDNk5i?=
 =?utf-8?B?Y1E5dTE3WTNNd2lWTnIxM1VIRXUyWmhBUkFxeE56WnVvdG9udVJyTnVtQ0k2?=
 =?utf-8?B?RSs5am9lY2ZJY0Z1YlQwZlVaR1dIUEttOWRsVzlNZ21ZSExrTU0zN3RCYVB2?=
 =?utf-8?B?Y2pHVjR4a1hQeTdVaDBlc1RETllmRUoybGoxdVJjR0lYVTNIdjNFN3RCeTh0?=
 =?utf-8?B?ZHU4M2dqWWtLamZzNFFzZ1A5SG5rYXNjQWZQV21GQ0lPV1I2TTFqUHQyR3lM?=
 =?utf-8?B?bVIzR09JTVpvdmlHTmROZUY1eVNaSENXUStzYkFWZXFpTFovNU9HM2pjMGlk?=
 =?utf-8?B?K0tUYm1NZXh0Vlk1eVFFNC9RLzBDcEs3ZlJlNCtPbzRXUThaUXc0cE5kaGRa?=
 =?utf-8?B?MWJ4YnRTWGQyL0ZKY2dEbkJsS2w2Qk1pbnZ2VGxERmdwNzFTN2M4cFR6KzAx?=
 =?utf-8?B?QnpybFBYNFo4SWdvVXEzWjhTb01WazNmaE9LVjZ4eUhRUjE1ciswRkhyZVVO?=
 =?utf-8?B?YkNobnBhL1hiaWo2M3BheE8xK093VlBEa1BWMTl3anpjUzJ2c2krNTd3ZWVr?=
 =?utf-8?B?VTZBRkQrckNWSVFvM0NrOUwrWkdwNzVsY3Y0WElyRzBERzI1SE51cnFYM0Rp?=
 =?utf-8?B?SHl2SlM5bGxSdG5JTDQxenlxeEs3MEpreGw3bHZIVXBrSTNLSDI5OVUzY0JU?=
 =?utf-8?B?VU5RZ3dkM3MveExLU1A5OE1TZjVHdjdUMTNpTVlxd1JyWGhHSGQzN0U4RG9h?=
 =?utf-8?B?SWlraDJqZWpsWkRYRW9NMkFKSjNoeFZuK3AvZ09nemRrd3NwZzRwSWQ1SlJh?=
 =?utf-8?B?SWgwZm9KRElOeVVFMTJJc2VnUUwxeEFNdnNhL1VXelB4TjYyMXdSNlVQYnZD?=
 =?utf-8?B?Z1F3OTVuQUFYWllxSjBtQzVkZVQ2Nis5UUpOdDl1cjJwN095WS9yZytkY2xT?=
 =?utf-8?B?cnZlclg5ZFp4dGY5Q1BBbUVQVkZzMEZRRkZVSEZsbmJSRFYzb3pyZ3FCMUIr?=
 =?utf-8?B?Z3BXbkoxTlhPWVRrVkhVWWw0aUVRT2tJNkZtNmpDdEFxTW53bjJaWGlzbW5F?=
 =?utf-8?B?OUdMb3E2ckhZOER3cGlPcSsrMjBIN0Y4a2pMcHVIS3Qyci8zZGdFM3JOc09u?=
 =?utf-8?B?QzdmZzl4QWNMSjk0Y2RjRkxtN2swUS9SUEZxR1l6RTdEWGF4bDZEdnI0NUhK?=
 =?utf-8?Q?L731ya4g0r8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjljaXdTNjVUY2E3Kzhsdnh3cUJGVlNZNWRtZ1p6QmpnZGdpSEx0REhXSU9T?=
 =?utf-8?B?NWNudVg1enhLTkk0WDNZUkFRZWtxNUFxN01pSFducGF4UjhoRlVUa0ZSckFu?=
 =?utf-8?B?dFNCUVFIY1dwQnFLMjcrVHNvc2V6VEUxdE9jQW1sWk1UWmQ1V2xyRGF3cVhS?=
 =?utf-8?B?THJCZkRta3EyZUxEVUp1Qnc1T1RHUyswUEwzMDcrMlJXMjdGVDlPUUh5aTRl?=
 =?utf-8?B?cWZPdFRVbHRHb0Z2ZncyRmVHT3ZLMEpBcU56ektIRzFtRTMxbWdOb3FDbUNj?=
 =?utf-8?B?SXMxUHdmVSs5QXJvTVZsSkpIdE91cjkxdU1EZ3FzUGI4UHAvUWFMS1hIUmdl?=
 =?utf-8?B?UmhFUUIzWnlOMVhDaXFhWHF4cElUOWMxTklEcHI2Ly9nRTB6ZWkzNmVrR1VJ?=
 =?utf-8?B?UTZCaTNDelA5WHV6emtwSHVmcHlpbGFyN1FXY2g1SUtFNWl1L2N4UG51YlRJ?=
 =?utf-8?B?bE0veW00Tis5S2t3QkdxaVR2YXE2YVBzYzJIVjFZeGRPVklBT0VOWStuOW53?=
 =?utf-8?B?MXgzdjE1U2FJYVNYVnpVTDN1ZHRHenJlb2hqU1NLby92MEc2L2pyRGtvbGxI?=
 =?utf-8?B?U0t5ait1eFR6aW1MMzhMY1ROYWVDd3RZcEpKRnp3anRsUE9mR0huM3FWejZq?=
 =?utf-8?B?QUFPQ3ZqRkxxMnlYZkhUc0Y3ZmdoUEJHWTR4L1VDMHVyZ2pySDZ3VlFBelZt?=
 =?utf-8?B?S1VjdElzYzBsUlBxM0dhaTQ4dmZ4dFJ5VDZZQWtSVUdpaXdMbkpYMHdyN3l1?=
 =?utf-8?B?L0tHR2Y0bnJRejg2ZklsWXBLWnY1NEdQQnBBTnE4WjNDY01CbGxnSHJndVp2?=
 =?utf-8?B?V1pzWFRHTTF6V1BPQUxSck8zL0pZMXBzQVFpY1M2L1hhQk5nZnBCNGlsd3h6?=
 =?utf-8?B?QUlmVlkvRGI5bExLcG1KalYxUmtQbEc4U0QvdjdXOEV1TVVlLy9pU0ZOQ3A0?=
 =?utf-8?B?WVpPbDFOTm9HNnpVbmJERDJ0elBpRG1oVitwdlRKT2QvREFsazZOMWFyWGR0?=
 =?utf-8?B?QVhXZjhJSkFXdVlQOC83c1VKb1dIR2dya3hCVGtSQ2JRclRtQXN1Y21Sd0d4?=
 =?utf-8?B?UmQ2SXpUV3VXT0IrYWpKZGxxL2o5Z2cwT0s0SU5mS0xkU1hOdWRvWE1BREhO?=
 =?utf-8?B?bEZuVXhTamNRYldvQVVZZ0ppSDM5WTJhYVlTOUZFdVZoSUxBMkdjRHRXU2hv?=
 =?utf-8?B?aEVmK0tEZjBMeFhmc0xBOXRLK054K040WFpqNHA1Q0k3UWFRYjg2dU9mOUJT?=
 =?utf-8?B?NHpZUmxHMHhLTVRyU1hDNmxMUG1aaExuNFlCZDV3bU9BQ0RWSk9BUnAvTHRT?=
 =?utf-8?B?eGFpYTh2bjcxdFFsWDZLeWdjQ1J2R3FocGthdVltdXFBVEo2MlkrVHlOUFVN?=
 =?utf-8?B?aU1nOWNndlFhSUZVc1VJTCttdVJpbmNlYVBMTnl3dFVESjgwNVRKR2hSYUFG?=
 =?utf-8?B?ZkxCQzZvS0hMMlh2RXNmZHdMMzNmemFNRlVHclE0cnZsTmt4azJCYkE4ai9F?=
 =?utf-8?B?S2xDNTRaaVh2aHRac3MzQWZTbitBeC9mNTByTElCYUNwS3M3Yi9XdlVDbGtH?=
 =?utf-8?B?cGRlZ0RtU3A4Rm0wRW9wSEN2bzJHUmMxWnhIV1E2L1FuTENXcWlBMFo4djI1?=
 =?utf-8?B?dS82VWtMeUpGNmlOZ1VnQWU2dkkxNlJmODlBMnJ2U3pVaEZMVlFGSUd0WjJT?=
 =?utf-8?B?bHJmbDUreTRlcDRLVEJ6QTk5ekx5NHFQQVVTbE54VTNVdzRseXJ0M0ExMEFY?=
 =?utf-8?B?UTVYK1FjNUZiTzFBVmpoR2doUzk2aUR4MVYxZVpkUVBGTnJRcFJoc2JCSVFV?=
 =?utf-8?B?YktTM0U5ZUVzMGFISkhWS0hNS1VlRk5scm55c2xnZTNqRUVxWURnTm0zUU1G?=
 =?utf-8?B?ZGlqc2pVcWRDMXN3WFltem1jVGNGMjVpakc4NVp4REVxTlpZQXNzVXozY1BZ?=
 =?utf-8?B?Nm0weDJXVnMxK2Y0blFxVUZwVTNOdVBQdEVlU1RBM1pHYmYvTjBRN2tmUzdR?=
 =?utf-8?B?MnhrckZkZlRXaVNMVm9Sc29FV01hMmRUOUVDRG9IWldvYTZ3NXpUU0xaOU9Z?=
 =?utf-8?B?VGdKRUZCYzFnT1kvM1VGTGozQm5uTktkQTJkT1c1T284SjZnUkk1SzdKemp1?=
 =?utf-8?Q?LgNN/Xtcx00Tq/tP4LIFrYbwH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839863fe-3397-4b33-0da9-08dda3f02d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 05:16:50.1102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woWPlCS+EdOojcDG8o7IRrCpKIqpmq2pQ/a7wIvpw11OGk8XF/BeFXt8KkL1ehhSn9jJcqMEZu3NhMgmeyH9SLs4dBVaQw+TDrm2EQgWlkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzddIHVpL3NwaWNl
OiBFbmFibGUgZ2w9b24gb3B0aW9uIGZvciBub24tbG9jYWwgb3INCj4gcmVtb3RlIGNsaWVudHMN
Cj4gDQo+ID4NCj4gPiBUbyBhZGRyZXNzIHRoZSBsaW1pdGF0aW9uIHRoYXQgdGhpcyBvcHRpb24g
aXMgaW5jb21wYXRpYmxlIHdpdGgNCj4gPiByZW1vdGUgY2xpZW50cywgdGhpcyBwYXRjaCBzZXJp
ZXMgYWRkcyBhbiBvcHRpb24gdG8gc2VsZWN0IGENCj4gPiBwcmVmZXJyZWQgY29kZWMgYW5kIGFs
c28gZW5hYmxlIGdsPW9uIG9wdGlvbiBmb3IgY2xpZW50cyB0aGF0DQo+ID4gYXJlIGNvbm5lY3Rl
ZCB2aWEgdGhlIG5ldHdvcmsuIEluIG90aGVyIHdvcmRzLCB3aXRoIHRoaXMgb3B0aW9uDQo+ID4g
ZW5hYmxlZCAoYW5kIHRoZSBiZWxvdyBsaW5rZWQgU3BpY2Ugc2VyaWVzIG1lcmdlZCksIGl0IHdv
dWxkIGJlDQo+ID4gcG9zc2libGUgdG8gaGF2ZSBRZW11IHNoYXJlIGEgZG1hYnVmIGZkIHdpdGgg
U3BpY2UsIHdoaWNoIHdvdWxkDQo+ID4gdGhlbiBmb3J3YXJkIGl0IHRvIGEgaGFyZHdhcmUgb3Ig
c29mdHdhcmUgYmFzZWQgZW5jb2RlciBhbmQNCj4gPiBldmVudHVhbGx5IHNlbmQgdGhlIGRhdGEg
YXNzb2NpYXRlZCB3aXRoIHRoZSBmZCB0byBhIGNsaWVudCB0aGF0DQo+ID4gY291bGQgYmUgbG9j
YXRlZCBvbiBhIGRpZmZlcmVudCBtYWNoaW5lLg0KPiA+DQo+ID4gRXNzZW50aWFsbHksIHRoaXMg
cGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGEgaGFyZHdhcmUgYWNjZWxlcmF0ZWQsDQo+ID4gb3BlbnNv
dXJjZSBWREkgb3B0aW9uIGZvciB1c2VycyB1c2luZyBRZW11IGFuZCBTcGljZSBieSBsZXZlcmFn
aW5nDQo+ID4gdGhlIGlHUFUvZEdQVSBvbiB0aGUgaG9zdCBtYWNoaW5lIHRvIGVuY29kZSB0aGUg
R3Vlc3QgRkIgdmlhIHRoZQ0KPiA+IEdzdHJlYW1lciBmcmFtZXdvcmsuDQo+ID4NCj4gDQo+IEkg
dGVzdGVkIHRoZSBzZXJpZXMgb24gZmVkb3JhIHdpdGggaW50ZWwtbWVkaWEtZHJpdmVyIGluc3Rh
bGxlZCBmcm9tIHJwbWZ1c2lvbi4NCj4gDQo+IFdpdGhvdXQgZXhwbGljaXQgdmlkZW8tY29kZWNz
IGFyZ3VtZW50IEkgZ2V0Og0KPiBxZW11LXN5c3RlbS14ODZfNjQ6IHdhcm5pbmc6IFNwaWNlOg0K
PiAuLi9zZXJ2ZXIvZGNjLXNlbmQuY3BwOjE3ODA6cmVkX21hcnNoYWxsX2dsX2RyYXdfc3RyZWFt
OiBObyB2aWRlbw0KPiBlbmNvZGVyIGF2YWlsYWJsZSBmb3IgdGhpcyBzdHJlYW0NCj4gcWVtdS1z
eXN0ZW0teDg2XzY0OiB3YXJuaW5nOiBzcGljZTogbm8gZ2wtZHJhdy1kb25lIHdpdGhpbiBvbmUg
c2Vjb25kDQo+IA0KPiBJZiBJIHNwZWNpZnkgdmlkZW8tY29kZWNzPWdzdHJlYW1lcjpoMjY0LCB0
aGVuIGl0IHNlZW1zIHRvIHdvcmsgZmluZS4NCj4gDQo+IEkgd2lzaCBhbGwgb2YgdGhpcyB3b3Vs
ZCBiZSBiZXR0ZXIgZG9jdW1lbnRlZCBvciBtb3JlIGV4cGxpY2l0LCBhcw0KRG8geW91IHRoaW5r
IGl0IG1ha2VzIHNlbnNlIHRvIHVzZSAiZ3N0cmVhbWVyOmgyNjQiIGFzIGRlZmF1bHQgaWYgdGhl
IHVzZXINCmNob3NlIC1zcGljZSBnbD1vbiBidXQgZGlkIG5vdCBzcGVjaWZ5IGFueSB2aWRlby1j
b2RlY3MgZXhwbGljaXRseT8NCg0KPiBlYWNoIHN0ZXAgdG9vayBtZSBhIHdoaWxlIHRvIGZpZ3Vy
ZSBvdXQgKHdoeSBpdCBkaWRuJ3QgcGljayBhDQo+IGNvbXBhdGlibGUgZW5jb2Rlciwgd2hhdCB3
YXMgdGhlIGFyZ3VtZW50IGZvciB2aWRlby1jb2RlY3MsIHdoeSBnc3QNCj4gZGlkbid0IHN1cHBv
cnQgaDI2NGVuYywgd2hlcmUgdG8gZmluZCB0aGUgZW5jb2RlciwgLi4uKS4gSSBhbSBub3QgZXZl
bg0KPiBzdXJlIEkgYW0gZG9pbmcgYWxsIHRoaXMgIGNvcnJlY3RseS4gTWF5YmUgdGhlcmUgc2hv
dWxkIGJlIHNvbWUNCj4gZG9jcy9pbnRlcm9wL3NwaWNlLnJzdCB0byBkb2N1bWVudCBxZW11IC1z
cGljZSBhbmQgdmlkZW8tY29kZWNzDQo+IHVzYWdlcz8gKGFuZCBtb3ZlIGRvY3Mvc3BpY2UtcG9y
dC1mcWRuLnR4dCBjb250ZW50IHRoZXJlIHRvbykNClRoZSBjb2RlY3MgbmVnb3RpYXRpb24gYmV0
d2VlbiBRZW11IGFuZCBTcGljZSBjYW4gZGVmaW5pdGVseSBiZSBpbXByb3ZlZA0KYXMgd2UgdGVz
dC9hZGQgbmV3ZXIgY29kZWNzIHN1Y2ggYXMgQVYxLCBldGMuIEFzIGZhciBhcyBkb2N1bWVudGF0
aW9uDQppcyBjb25jZXJuZWQsIEknZCBsaWtlIHRvIGRvIGl0IGluIGEgZm9sbG93IHVwIHNlcmll
cyBpZiBpdCBpcyBvayB3aXRoIHlvdSBzaW5jZQ0KaXQgbWlnaHQgZGVsYXkgdGhpcyBzZXJpZXMg
Z2l2ZW4gdGhhdCBpdCB3b3VsZCBwcm9iYWJseSByZXF1aXJlIGZldyBtb3JlDQpyZXZpc2lvbnMv
dmVyc2lvbnMgdG8gZ2V0IGl0IHJpZ2h0Lg0KDQo+IA0KPiBJIHN1cHBvc2UgdGhlIGlzc3VlIHdp
dGggYmV0dGVyIGRlZmF1bHQgZm9yIHZpZGVvLWNvZGVjcyBpcyBvbg0KPiBzcGljZS1zZXJ2ZXIg
c2lkZSwgc28gZm9yIHRoaXMgc2VyaWVzOg0KPiBSZXZpZXdlZC1ieTogTWFyYy1BbmRyw6kgTHVy
ZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQpUaGFuayB5b3Ugc28gbXVjaCENCg0K
VGhhbmtzLA0KVml2ZWsNCg0KPiANCj4gDQo+ID4gdjQgIC0+IHY1IChzdWdnZXN0aW9ucyBmcm9t
IE1hcmMtQW5kcsOpKToNCj4gPiAtIEZpeCB0aGUgZXJyb3JzIChtb3N0bHkgODAgY2hhcnMgbGlt
aXQgdmlvbGF0aW9ucykgaWRlbnRpZmllZCBieQ0KPiA+ICAgc2NyaXB0cy9jaGVja3BhdGNoLnBs
DQo+ID4gLSBSZW5hbWUgdGhlIGdsb2JhbHMgdG8gaGF2ZSBhIHNwaWNlXyBwcmVmaXggZm9yIGNv
bnNpc3RlbmN5DQo+ID4gLSBSZW5hbWUgTUFYX1JFRlJFU0hfUkFURSB0byBERUZBVUxUX01BWF9S
RUZSRVNIX1JBVEUNCj4gPiAtIEFkZGVkIGNvbW1lbnRzIHRvIGV4cGxhaW4gaG93L3doZW4gdGhl
IGdsX2RyYXcgcmVxdWVzdCBpcyBzdWJtaXR0ZWQNCj4gPiAgIHRvIHNwaWNlIHNlcnZlciBpbiB0
aGUgcmVtb3RlIGNsaWVudHMgY2FzZQ0KPiA+IC0gRml4IHRoZSBtZW1fb2JqIGxlYWsgdGhhdCB3
b3VsZCBvY2N1ciB3aGVuIHRoZSBhc3NvY2lhdGVkIHRleHR1cmUNCj4gPiAgIGlzIGRlc3Ryb3ll
ZCBvciB3aGVuIGFuIGVycm9yIGlzIGVuY291bnRlcmVkIHdoaWxlIGNyZWF0aW5nIGENCj4gPiAg
IHRleHR1cmUgZnJvbSBhbiBmZCAoRG1pdHJ5IGFuZCBNaWNoYWVsKQ0KPiA+IC0gTWVyZ2VkIE1p
Y2hhZWwncyBwYXRjaCB0byBmaXggdGhlIG1lbV9vYmogbGVhayBpbnRvIHRoaXMgc2VyaWVzIGFu
ZA0KPiA+ICAgYWRkZWQgaGlzIENvLWRldmVsb3BlZC1ieSB0YWcgdG8gdGhlIHJlbGV2YW50IHBh
dGNoZXMNCj4gPg0KPiA+IHYzIC0+IHY0IChzdWdnZXN0aW9ucyBmcm9tIE1hcmMtQW5kcsOpKToN
Cj4gPiAtIEFkZCBhIG5ldyBwYXJhbWV0ZXIgdG8gbWFrZSBtYXhfcmVmcmVzaF9yYXRlIGNvbmZp
Z3VyYWJsZQ0KPiA+IC0gSGF2ZSBzdXJmYWNlX2dsX2NyZWF0ZV90ZXh0dXJlX2Zyb21fZmQoKSBy
ZXR1cm4gYm9vbCBhZnRlciBjaGVja2luZw0KPiA+ICAgZm9yIGVycm9ycw0KPiA+IC0gUmVtb3Zl
IHRoZSBjaGVjayBmb3IgUElYTUFOX3I1ZzZiNSgpIGluIHNwaWNlX2dsX3JlcGxhY2VfZmRfdGV4
dHVyZSgpDQo+ID4gLSBSZXBvcnQgZXJyb3JzIGluIHNwaWNlX2dsX3JlcGxhY2VfZmRfdGV4dHVy
ZSgpIHdoZW4gc29tZXRpbmcgZmFpbHMNCj4gPiAtIFVzZSBnbEdldEVycm9yKCkgY29ycmVjdGx5
IGJ5IGFkZGluZyBhbiBhZGRpdGlvbmFsIChkdW1teSkgY2FsbA0KPiA+ICAgYmVmb3JlIGNoZWNr
aW5nIGZvciBhY3R1YWwgZXJyb3JzIChEbWl0cnkpDQo+ID4gLSBBZGQgYSBuZXcgcGF0Y2ggdG8g
Y2hlY2sgZmQgdmFsdWVzIGluIGVnbF9kbWFidWZfZXhwb3J0X3RleHR1cmUoKQ0KPiA+IC0gUmVi
YXNlIG9uIFFlbXUgbWFzdGVyDQo+ID4NCj4gPiB2MiAtPiB2MzoNCj4gPiAtIENoZWNrIGZvciBl
cnJvcnMgYWZ0ZXIgaW52b2tpbmcgZ2xJbXBvcnRNZW1vcnlGZEVYVCgpIHVzaW5nDQo+ID4gICBn
bEdldEVycm9yKCkgYW5kIHJlcG9ydCB0aGUgZXJyb3IgdG8gdXNlciAoRG1pdHJ5KQ0KPiA+DQo+
ID4gdjEgLT4gdjI6DQo+ID4gLSBSZXBsYWNlIHRoZSBvcHRpb24gbmFtZSBwcmVmZXJyZWQtY29k
ZWMgd2l0aCB2aWRlby1jb2RlY3MgKE1hcmMtQW5kcsOpKQ0KPiA+IC0gQWRkIGEgd2FybmluZyB3
aGVuIGFuIGZkIGNhbm5vdCBiZSBjcmVhdGVkIGZyb20gdGV4dHVyZSAoTWFyYy1BbmRyw6kpDQo+
ID4gLSBBZGQgYSBuZXcgcGF0Y2ggdG8gYmxpdCB0aGUgc2Nhbm91dCB0ZXh0dXJlIGludG8gYSBs
aW5lYXIgb25lIHRvDQo+ID4gICBtYWtlIGl0IHdvcmsgd2l0aCB2aXJnbA0KPiA+IC0gUmViYXNl
ZCBhbmQgdGVzdGVkIGFnYWluc3QgdGhlIGxhdGVzdCBTcGljZSBtYXN0ZXINCj4gPg0KPiA+IFRl
c3RlZCB3aXRoIHRoZSBmb2xsb3dpbmcgUWVtdSBwYXJhbWV0ZXJzOg0KPiA+IC1kZXZpY2Ugdmly
dGlvLXZnYSxtYXhfb3V0cHV0cz0xLHhyZXM9MTkyMCx5cmVzPTEwODAsYmxvYj10cnVlDQo+ID4g
LXNwaWNlIHBvcnQ9MzAwMSxnbD1vbixkaXNhYmxlLXRpY2tldGluZz1vbix2aWRlby1jb2RlY3M9
Z3N0cmVhbWVyOmgyNjQNCj4gPg0KPiA+IGFuZCByZW1vdGUtdmlld2VyIC0tc3BpY2UtZGVidWcg
c3BpY2U6Ly94LngueC54OjMwMDEgb24gdGhlIGNsaWVudCBzaWRlLg0KPiA+DQo+ID4gQXNzb2Np
YXRlZCBTcGljZSBzZXJ2ZXIgTVIgKG1lcmdlZCk6DQo+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRl
c2t0b3Aub3JnL3NwaWNlL3NwaWNlLy0vbWVyZ2VfcmVxdWVzdHMvMjI5DQo+ID4NCj4gPiAtLS0N
Cj4gPiBDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+DQo+ID4gQ2M6IE1hcmMt
QW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+IENjOiBEbWl0
cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPg0KPiA+IENjOiBGcmVk
aWFubyBaaWdsaW8gPGZyZWRkeTc3QGdtYWlsLmNvbT4NCj4gPiBDYzogTWljaGFlbCBTY2hlcmxl
IDxtaWNoYWVsLnNjaGVybGVAcnoudW5pLWZyZWlidXJnLmRlPg0KPiA+IENjOiBEb25nd29uIEtp
bSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+IENjOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVu
bmVlQGxpbmFyby5vcmc+DQo+ID4NCj4gPiBWaXZlayBLYXNpcmVkZHkgKDcpOg0KPiA+ICAgdWkv
ZWdsLWhlbHBlcnM6IEVycm9yIGNoZWNrIHRoZSBmZHMgaW4gZWdsX2RtYWJ1Zl9leHBvcnRfdGV4
dHVyZSgpDQo+ID4gICB1aS9zcGljZTogQWRkIGFuIG9wdGlvbiBmb3IgdXNlcnMgdG8gcHJvdmlk
ZSBhIHByZWZlcnJlZCBjb2RlYw0KPiA+ICAgdWkvc3BpY2U6IEVuYWJsZSBnbD1vbiBvcHRpb24g
Zm9yIG5vbi1sb2NhbCBvciByZW1vdGUgY2xpZW50cw0KPiA+ICAgdWkvc3BpY2U6IEFkZCBhbiBv
cHRpb24gdG8gc3VibWl0IGdsX2RyYXcgcmVxdWVzdHMgYXQgZml4ZWQgcmF0ZQ0KPiA+ICAgdWkv
Y29uc29sZS1nbDogQWRkIGEgaGVscGVyIHRvIGNyZWF0ZSBhIHRleHR1cmUgd2l0aCBsaW5lYXIg
bWVtb3J5DQo+ID4gICAgIGxheW91dA0KPiA+ICAgdWkvc3BpY2U6IENyZWF0ZSBhIG5ldyB0ZXh0
dXJlIHdpdGggbGluZWFyIGxheW91dCB3aGVuIGdsPW9uIGlzDQo+ID4gICAgIGVuYWJsZWQNCj4g
PiAgIHVpL3NwaWNlOiBCbGl0IHRoZSBzY2Fub3V0IHRleHR1cmUgaWYgaXRzIG1lbW9yeSBsYXlv
dXQgaXMgbm90IGxpbmVhcg0KPiA+DQo+ID4gIGluY2x1ZGUvdWkvY29uc29sZS5oICAgICAgIHwg
ICAzICsNCj4gPiAgaW5jbHVkZS91aS9zcGljZS1kaXNwbGF5LmggfCAgIDUgKw0KPiA+ICBpbmNs
dWRlL3VpL3N1cmZhY2UuaCAgICAgICB8ICAgMSArDQo+ID4gIHFlbXUtb3B0aW9ucy5oeCAgICAg
ICAgICAgIHwgIDEwICsrDQo+ID4gIHVpL2NvbnNvbGUtZ2wuYyAgICAgICAgICAgIHwgIDU0ICsr
KysrKysrKw0KPiA+ICB1aS9lZ2wtaGVscGVycy5jICAgICAgICAgICB8ICAgNiArDQo+ID4gIHVp
L3NwaWNlLWNvcmUuYyAgICAgICAgICAgIHwgIDI4ICsrKysrDQo+ID4gIHVpL3NwaWNlLWRpc3Bs
YXkuYyAgICAgICAgIHwgMjI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0N
Cj4gPiAgOCBmaWxlcyBjaGFuZ2VkLCAzMTcgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDkuMA0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJj
LUFuZHLDqSBMdXJlYXUNCg==

