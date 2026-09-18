Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF09EC982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 01:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7NTu-00070y-8W; Thu, 17 Sep 2026 21:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x7NTs-00070W-Dg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:33:36 -0400
Received: from mgamail.intel.com ([192.198.163.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x7NTp-0007Oz-8I
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789695213; x=1821231213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zIw1fOGptFnba/eOswszS0uW9HpwlTDsx9SiMC+/n40=;
 b=j0NkZC6wEWGxyuJDLRnlZzU4hR1HC2dV1Qh8Got5X96vyzXxqZUBGBxs
 ZVfKohnMKcOAmeacx70DlGwrsR9J+KUfkuLR4QsJ2KnEW1UTvXQSLJcWi
 Ai5ibxv+VXbhM6KiVwFAFnQD0w1p/S+Gdng4/MYqHZSLqPd+sFiGXjEFe
 VYWaAWVfaFwbGVWq5T8N3DIFfUOtm4FRYKW1DhoZhINbCwEhtsJJaczgW
 tQ6EBfHsOhQiUSsTUSZcfZiwDBn6euWMRmirIx1fCPga9ZrpjuxsxJN6q
 QgC+Fx3WxzRSkjTPFDd6Lz58c1+cK1uTrWvhkBZCq+ra67lrneFcqmpdS A==;
X-CSE-ConnectionGUID: 55ddIeBrSUWAgFeNwA2flA==
X-CSE-MsgGUID: 3h6CLRv4TMK0Oi9ux6wdsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="682496"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="682496"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 18:33:00 -0700
X-CSE-ConnectionGUID: WA6aFVmST6CIuf6cr7xc6g==
X-CSE-MsgGUID: D5Yn9dN0TI6BdkK174otnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="299216044"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 18:33:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 18:32:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 18:32:59 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 18:32:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtvWkOcKLgrpopm220K70Jh9s05qflO62ugooa6JJwhTD0X2so4O0h68E8u1H7s43DST2YNIWnolG/Q0F/r2ZrYyjV+EXov2ntaYhPX1rtjlHy0MLgXTZPobyBVfux5+LWCc4B7RMYhPG9JwcU7wjEzYcW0RWu1WxWuVZAqFbr9y9/eeL1819MtHw+oFLH8AjpugFDGFxSpxxMGe9wq5l/86H2AcTdfGri7A5DU33ENtU4kwizq5i/hEywI3V3N9WlDfF8xLVtTdwgbnyDeWumOX4dhCdsJ5XFs/W8Ktbd1Lubl0FuRw6wzGPYO/Qy9KnS9X8ZwFS1HOmU0dM2d6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIw1fOGptFnba/eOswszS0uW9HpwlTDsx9SiMC+/n40=;
 b=TcMoy7UAVgZb31sO1wcLLOu3oBvYguWNNL6iOp24NQJFDb1PostygZvqAi5qU4r+CYbCSoI/fiQ7GIlJMHVP/rYQMyDxLpjiEqElc5XsQkVeA/SRYWx/6t2T+taBR9/X0do7mKJr0IhQAC9h+o2s2+OrOoJwOVocU1IpSzive4d/8sH1SP20Y8njYNgt4ekw0hVGvK/lbhBf0x2NP4ITwjL4yHvX0wRiNCsLiR6NeV3khlkNiTla63S6AXfjrdg1/GoY3uq6wkpHNhSH99n7JBzpjsvaGnnGqBz5XDjuVvDUqA0kw1sJE+hgsM8UKejSANuEBvjClGBy7QY0bPb6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by CY5PR11MB6437.namprd11.prod.outlook.com (2603:10b6:930:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 01:32:55 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 01:32:55 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/gtk: Enable fullscreen and zoom hotkeys for detached
 windows
Thread-Topic: [PATCH] ui/gtk: Enable fullscreen and zoom hotkeys for detached
 windows
Thread-Index: AQHdRUTKwHRDkoeWEEGl72sdhAqVMLbScSsAgAEcgoA=
Date: Fri, 18 Sep 2026 01:32:55 +0000
Message-ID: <PH0PR11MB51122610E8229D2DA60AAE0AFA872@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260805092017.21028-1-dongwon.kim@intel.com>
 <CAJ+F1CJb0uN6912RBvhe5H=epKnShmCVGDVRw8_mJWs-ActKVw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJb0uN6912RBvhe5H=epKnShmCVGDVRw8_mJWs-ActKVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|CY5PR11MB6437:EE_
x-ms-office365-filtering-correlation-id: cddb32d3-a167-454a-d51b-08df1524c370
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: iGdTtseoJt+oeG53bFuIeXGQUZa7Z4WznX3V7Nvv7GtafpBqG2jxpoPbM0WtM26Rb+UgaV3NFdMZEstQOihHyukydPvTiWIiEi9Zw7/aBdtLZ5jmwaprIajsMW1G6UHI/zy8ATQHTXIFmK22zRnQYbFlX+mkKdlTfgcTL7chBI5ZSSDPmdLw2h6131xmBYKtC4NVcMjfnU9aHi1yGIWBaYDZJA+UNgV18G2YiL7IcQakQ/yPIyS4A76iV19GJA4tGR5wy6eMH2TWkiKLZ5EKGKfF/Pyiy5xoAWGYYwku8iG+nIrsapU5vND1mWEU0CSoHGNmf2DB20LYtDFvmeb2XqQi414AXVmB3tp2VZVqrs01S1Uv/CaWVjFP9DnQDIwGOtp8oaUTN/f5+3AH3+GK04/1eHO2TZPdnGoDjphDyViN+fdu0ijZMI2xW5ULCIuJ5c3MAwmgFDvqWBbqql4xzd7CiEgVv15iFAZfZtxT2UMByN/egZBzI4nYhYzozsWdkIOL2wkZSvwyepxetnyLgX5RRRtGi468kTadNK/qnoSDmntlBeliDKN8uELhJpnpzKHeeKOFJHQO7VnedJPs8mnyj1A5kqtm/oHJs59AvcEggpyeOEGXE67LwVAQkPyo1SOgJqxPGKylV6xe6PR2HNzsgwgWi0Qt/wpGUZQYWjlyZuc9dDC1aL4QqYEMqnoRJcbpVexeXOxYHOQIMq0cNh+oFUwtbxInm3OjAuDvoIQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3VKaVYwc21UTjRTWTZBNVRPZEJlUkZQZHExSjFKV1ZZS2xTSEZLMUJIUkgz?=
 =?utf-8?B?amJ4OFozeExDWnBRbkl1NVZ4STNLdnJCZERLRVdmUU9CbG93MjhJdzNZMWtq?=
 =?utf-8?B?blRXTC9oSWF5TW1zTGlVRGd2N2VSM1d2OWVmL0YwelpNSE9oaGp1TTFyV2dr?=
 =?utf-8?B?aWF2aFNVSjg2eEpBcm5DTk5RVGYxdnMvTGZJZFhhekJ0ZU8wNkwyalFBNEMy?=
 =?utf-8?B?MW1vTWI1SDdtZ1p0U1F1N3ZoV3FneWVKcU9aVFJUMFdCU2N1WWxwck1YWXAz?=
 =?utf-8?B?YUpzYTRtbDdDZGE2SUpBTkJ1ZE9rZ2J0YmJCMFE0WjVXbDRJTzRLbUdyRkJi?=
 =?utf-8?B?Y29RWlBSL2d1K1FtNStPdUlodVcwMGV5MzkxNWNkSnc0R0NUcERpS0ZZLzdY?=
 =?utf-8?B?elhiOGpPbGU0dHpQL2QyTlEzTGZrSVlac1daZE14aEpPeGJKbjFpZXJKb0Np?=
 =?utf-8?B?VWRIeFkwMk80VzZZVy96bXhUdkM4b2piZnlIRTRoK1p6blpmSE9yS21TZS9D?=
 =?utf-8?B?dnNpYkpDQzk1czIwcXZ6U2dOblJSTWw3WXBpTSszK1pNamlBTHdpb1VsaFg2?=
 =?utf-8?B?NGd3WFRDYi9iTWYxcHk5Rk5XTm40T3U3RXhEamVNZUplUzI2T28xMWpoeUdD?=
 =?utf-8?B?OW1haW9ZTlZFa0lEckhFdGYvK0hzNXZ0akdpWHNpUlZMTjJLRnEzdFFHV0x6?=
 =?utf-8?B?K21DYlJ2OWJVanVKeDZqUzQ4aG5pZmVZNU0xeFR0NHQ4a0ZCK25EbVRUNUFL?=
 =?utf-8?B?czVCYzdBNERYK3Q4czFhY0xsWnVaOGYwMVN1RHVOeDdRdjAwcTVwTzNwQ2w1?=
 =?utf-8?B?Q1gxOVRLZTV2YjlZUVZFbGdaalhJdUI0Z3ZEVmNuMStvMkZya3dsYzNHVE5Y?=
 =?utf-8?B?TXkxZnVZUEdPTnN4WmhqL09mUUtVVzl6T0tFWFFPdUFtbWRCK0hmZEZ4c1hv?=
 =?utf-8?B?TitEQXdJdnAzK1RraTFpRUUxL0k3V0VONVJJSmQyREJzK3kzVHgrd3dKbHZV?=
 =?utf-8?B?N0VHU0JCdFdjeG9ZRUk5SnBmSkhoR1dweklRUXV2czRMVzByMjRmdTFQWlpt?=
 =?utf-8?B?bGNHdFlVMWdpNkRSbmpuQUl1NnJTdnVlZXN5akREQS9qbnNodWtobXZXL0NQ?=
 =?utf-8?B?ems1djYvOGtsaHZVcmVXcVVvb2V0eGY1Smc5WkVKSngyTm1RRXhPNlBMVUlM?=
 =?utf-8?B?Y3d3eTZ3R3h1TVFaaWswcGRYZHFkWGlmWEIwVk5tOWpDZEE4cUtTc2VpZnNi?=
 =?utf-8?B?WXZMQU94dXE3ZFNTRWVLTVN0TGhYUUQwb0lQb2xNajdTSUxOaVpKNXNXS0Zj?=
 =?utf-8?B?ZXVneStCczZQTHRiNUc2dFZMYXpvSWxzb2ttQjU5WW9zYUE2TWJmZmR1eXRl?=
 =?utf-8?B?cVoxa2FldTBJOE5QMGkzN2hTYmZxNFg2TkhTREFVUEZYeEZUMTM0QlpQaDlo?=
 =?utf-8?B?RklObVpwQ3k4ZmJGcTRNQ29PK09EdUtKWE5GS2d0Z3RndjZ1dDJUekV2VEJx?=
 =?utf-8?B?MVBKbHBmU0U4ZmlOSGo5U0piUEcrZDdhRmRmcnkweWlmNnJmL0lmUUZpL2I3?=
 =?utf-8?B?Ym1KYm5BWWR3d1F0a09jaXNFWXV2UkVnUy9QMFcrKzlpc0RhOUorWjRmQytQ?=
 =?utf-8?B?MFUxT01yK0VyMmtNZmU5OFZsdldsVVNOVHVsM0NjN29rVTkvUE1adGoxVlRP?=
 =?utf-8?B?RERIZE84V096bDdiaTFnbm83WkZHY2tjRUxhMjlLZlozK0RNbitpOFBxUTYr?=
 =?utf-8?B?dWlEREYxb2xSWkxpeXR3dGE5aXd3OGd5eUJ1UUJveE93NktjR0hVTVEzNE9S?=
 =?utf-8?B?TTN4aXJGNzhYd2h0cnZPUjM1Y2hKOXpSV1pVbWhBMlJvb1BCUFB3QzY0eDlV?=
 =?utf-8?B?ZGFBTmNVVG9Bd3JXWXE1VFRJWU9tYldKdkdBNlFvd0d4RzJBbGhOOXhHYko4?=
 =?utf-8?B?a0E1TmF1YkZEV2hwUWRyZzlLWkRxbWZHUU00RlNrN3piaVNjSlBWUVNHOEQy?=
 =?utf-8?B?QWVSNmMraEltbXJzWFlCT1QyNkhVMnZTTnQwL3pvczFvSW8yOWI5bTdYMEFm?=
 =?utf-8?B?NkcvYUdCUlpEVHVQb0VtWXRKNnJSYzVSVGxzd2VoYTF6SitEV2wyd2d5bVFW?=
 =?utf-8?B?YzNVd0dyRHorOHBKWEEvaTBQWitWb1FhM3ZSeUxLU29NV0xDYlp0cEtpdmNm?=
 =?utf-8?B?OU5zUWFPZlV3QTYvaHpJNDU2MUR2V3dMSnRtTWtzWUpFMk5JVHl3aUpTWG9L?=
 =?utf-8?B?T3BoZDFEV0diQ0pYR3V4UXJTWnNWRDZ2NmVtaHlzSDVmSW9VYUdZUXI0eERj?=
 =?utf-8?Q?mVNZOjs2jCFIM6PrXL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tYVXmf5T/m/ZClQ9EWH1O2+1FccHpzsPPFhh0fSsAVRS4hGiqb7OeA+d0G5kjSIntPsVSxpGanjhaHbxWiE9pN5Ja+BtwcgbWn3AqzEAXSsyIaXxKz0uZqOVeNKkKvMCVL9iv7KBDRPj70sdezDxX9yUuFE+vTLBVysG4YbAV08734M++Mm3gZjXCRL/ZGLl45QLMiGUdf+Ct/dlv1RAxI8UVQT6QL2Q3J/ke/5Uv9Tzf3b/xPQfGQ6jWUDv7ZPC3FM8uV7Vp81qwLMPmyXtL/dVZcZufxC7DpdHazw/CZxHJITMH30SH6JzBvnWtKNWqUkFEmlYw62Zz8p/FmrJsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddb32d3-a167-454a-d51b-08df1524c370
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 01:32:55.1222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1upRQT25LiWU8WJRLoLzt89pH9t6TT+9z5d3hDEXYyvNi40xwxQMIc5OA5+y4LMjWI7ml4iZs3CYffJZuBDEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6437
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.4; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdWkvZ3RrOiBFbmFibGUg
ZnVsbHNjcmVlbiBhbmQgem9vbSBob3RrZXlzIGZvciBkZXRhY2hlZA0KPiB3aW5kb3dzDQo+IA0K
PiBIaQ0KPiANCj4gT24gVHVlLCBTZXAgMTUsIDIwMjYgYXQgMTE6MDLigK9QTSA8ZG9uZ3dvbi5r
aW1AaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29u
LmtpbUBpbnRlbC5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHksIHRoZSBmdWxsc2NyZWVuIHRvZ2ds
ZSBob3RrZXkgKEN0cmwrQWx0K2YgYnkgZGVmYXVsdCkgYW5kDQo+ID4gem9vbSBob3RrZXlzIChD
dHJsK0FsdCsrLCBDdHJsK0FsdCstLCBDdHJsK0FsdCswKSBvbmx5IGZ1bmN0aW9uIGZvcg0KPiA+
IHRoZSBtYWluIFFFTVUgd2luZG93LiBXaGVuIGEgVkMgaXMgZGV0YWNoZWQgKHVudGFiaWZpZWQp
LCBpdCBsb3NlcyB0aGVzZQ0KPiBjYXBhYmlsaXRpZXMuDQo+ID4NCj4gPiBJbXBsZW1lbnQgdG9n
Z2xlIGhlbHBlcnMsIGdkX3dpbl9mdWxsX3NjcmVlbiBhbmQgem9vbSBoZWxwZXJzDQo+ID4gKGdk
X3dpbl96b29tX2luLCBnZF93aW5fem9vbV9vdXQsIGdkX3dpbl96b29tX2ZpeGVkKSBhbmQgY29u
bmVjdA0KPiB0aGVtDQo+ID4gdG8gdGhlIGRldGFjaGVkIHdpbmRvdydzIGFjY2VsZXJhdG9yIGdy
b3VwIGluIGdkX21lbnVfdW50YWJpZnkuDQo+ID4NCj4gPiBBbHNvIHJlbW92ZSBhIGxlZnRvdmVy
IGRlYnVnIGZwcmludGYgaW4gZ2Rfd2luX2dyYWIuDQo+ID4NCj4gPiBDYzogTWFyYy1BbmRyw6kg
THVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdWkvZ3Rr
LmMgfCAxMDINCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3VpL2d0ay5jIGIvdWkvZ3RrLmMNCj4g
PiBpbmRleCBhNzIzYzgyMTVkLi42MzJlMzAyZWQ3IDEwMDY0NA0KPiA+IC0tLSBhL3VpL2d0ay5j
DQo+ID4gKysrIGIvdWkvZ3RrLmMNCj4gPiBAQCAtMTU0Nyw3ICsxNTQ3LDYgQEAgc3RhdGljIGdi
b29sZWFuIGdkX3dpbl9ncmFiKHZvaWQgKm9wYXF1ZSkgIHsNCj4gPiAgICAgIFZpcnR1YWxDb25z
b2xlICp2YyA9IG9wYXF1ZTsNCj4gPg0KPiA+IC0gICAgZnByaW50ZihzdGRlcnIsICIlczogJXNc
biIsIF9fZnVuY19fLCB2Yy0+bGFiZWwpOw0KPiA+ICAgICAgaWYgKHZjLT5zLT5wdHJfb3duZXIp
IHsNCj4gPiAgICAgICAgICBnZF91bmdyYWJfcG9pbnRlcih2Yy0+cyk7DQo+ID4gICAgICB9IGVs
c2Ugew0KPiA+IEBAIC0xNTU2LDYgKzE1NTUsODYgQEAgc3RhdGljIGdib29sZWFuIGdkX3dpbl9n
cmFiKHZvaWQgKm9wYXF1ZSkNCj4gPiAgICAgIHJldHVybiBUUlVFOw0KPiA+ICB9DQo+ID4NCj4g
PiArc3RhdGljIGdib29sZWFuIGdkX3dpbl9mdWxsX3NjcmVlbih2b2lkICpvcGFxdWUpIHsNCj4g
PiArICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IG9wYXF1ZTsNCj4gPiArICAgIEdka1dpbmRvdyAq
d2luZG93Ow0KPiA+ICsgICAgR2RrV2luZG93U3RhdGUgc3RhdGU7DQo+ID4gKw0KPiA+ICsgICAg
aWYgKCF2Yy0+d2luZG93IHx8ICFndGtfd2lkZ2V0X2dldF9yZWFsaXplZCh2Yy0+d2luZG93KSkg
ew0KPiA+ICsgICAgICAgIHJldHVybiBUUlVFOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAg
IHdpbmRvdyA9IGd0a193aWRnZXRfZ2V0X3dpbmRvdyh2Yy0+d2luZG93KTsNCj4gPiArICAgIGlm
ICghd2luZG93KSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIFRSVUU7DQo+ID4gKyAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgc3RhdGUgPSBnZGtfd2luZG93X2dldF9zdGF0ZSh3aW5kb3cpOw0KPiA+ICsN
Cj4gPiArICAgIGlmIChzdGF0ZSAmIEdES19XSU5ET1dfU1RBVEVfRlVMTFNDUkVFTikgew0KPiA+
ICsgICAgICAgIGd0a193aW5kb3dfdW5mdWxsc2NyZWVuKEdUS19XSU5ET1codmMtPndpbmRvdykp
Ow0KPiA+ICsNCj4gPiArICAgICAgICBpZiAodmMtPnR5cGUgPT0gR0RfVkNfR0ZYKSB7DQo+ID4g
KyAgICAgICAgICAgIHZjLT5nZnguc2NhbGVfeCA9IHZjLT5nZngucHJlZmVycmVkX3NjYWxlOw0K
PiA+ICsgICAgICAgICAgICB2Yy0+Z2Z4LnNjYWxlX3kgPSB2Yy0+Z2Z4LnByZWZlcnJlZF9zY2Fs
ZTsNCj4gPiArICAgICAgICAgICAgZ2RfdXBkYXRlX3dpbmRvd3NpemUodmMpOw0KPiA+ICsgICAg
ICAgIH0NCj4gPiArICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgaWYgKHZjLT50eXBlID09IEdE
X1ZDX0dGWCkgew0KPiA+ICsgICAgICAgICAgICBndGtfd2lkZ2V0X3NldF9zaXplX3JlcXVlc3Qo
dmMtPmdmeC5kcmF3aW5nX2FyZWEsIC0xLCAtMSk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAg
ICAgIGd0a193aW5kb3dfZnVsbHNjcmVlbihHVEtfV0lORE9XKHZjLT53aW5kb3cpKTsNCj4gPiAr
ICAgIH0NCj4gPiArDQo+ID4gKyAgICBnZF91cGRhdGVfY3Vyc29yKHZjKTsNCj4gPiArICAgIHJl
dHVybiBUUlVFOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgZ2Jvb2xlYW4gZ2Rfd2luX3pv
b21faW4odm9pZCAqb3BhcXVlKSB7DQo+ID4gKyAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBvcGFx
dWU7DQo+ID4gKyAgICBHdGtEaXNwbGF5U3RhdGUgKnMgPSB2Yy0+czsNCj4gPiArDQo+ID4gKyAg
ICBndGtfY2hlY2tfbWVudV9pdGVtX3NldF9hY3RpdmUoR1RLX0NIRUNLX01FTlVfSVRFTShzLQ0K
PiA+em9vbV9maXRfaXRlbSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRkFMU0UpOw0KPiA+ICsNCj4gPiArICAgIHZjLT5nZnguc2NhbGVfeCArPSBWQ19TQ0FMRV9T
VEVQOw0KPiA+ICsgICAgdmMtPmdmeC5zY2FsZV95ICs9IFZDX1NDQUxFX1NURVA7DQo+ID4gKw0K
PiA+ICsgICAgZ2RfdXBkYXRlX3dpbmRvd3NpemUodmMpOw0KPiA+ICsgICAgcmV0dXJuIFRSVUU7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBnYm9vbGVhbiBnZF93aW5fem9vbV9vdXQodm9p
ZCAqb3BhcXVlKSB7DQo+ID4gKyAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBvcGFxdWU7DQo+ID4g
KyAgICBHdGtEaXNwbGF5U3RhdGUgKnMgPSB2Yy0+czsNCj4gPiArDQo+ID4gKyAgICBndGtfY2hl
Y2tfbWVudV9pdGVtX3NldF9hY3RpdmUoR1RLX0NIRUNLX01FTlVfSVRFTShzLQ0KPiA+em9vbV9m
aXRfaXRlbSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRkFMU0Up
Ow0KPiA+ICsNCj4gPiArICAgIHZjLT5nZnguc2NhbGVfeCAtPSBWQ19TQ0FMRV9TVEVQOw0KPiA+
ICsgICAgdmMtPmdmeC5zY2FsZV95IC09IFZDX1NDQUxFX1NURVA7DQo+ID4gKw0KPiA+ICsgICAg
dmMtPmdmeC5zY2FsZV94ID0gTUFYKHZjLT5nZnguc2NhbGVfeCwgVkNfU0NBTEVfTUlOKTsNCj4g
PiArICAgIHZjLT5nZnguc2NhbGVfeSA9IE1BWCh2Yy0+Z2Z4LnNjYWxlX3ksIFZDX1NDQUxFX01J
Tik7DQo+ID4gKw0KPiA+ICsgICAgZ2RfdXBkYXRlX3dpbmRvd3NpemUodmMpOw0KPiA+ICsgICAg
cmV0dXJuIFRSVUU7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBnYm9vbGVhbiBnZF93aW5f
em9vbV9maXhlZCh2b2lkICpvcGFxdWUpIHsNCj4gPiArICAgIFZpcnR1YWxDb25zb2xlICp2YyA9
IG9wYXF1ZTsNCj4gPiArDQo+ID4gKyAgICB2Yy0+Z2Z4LnNjYWxlX3ggPSB2Yy0+Z2Z4LnByZWZl
cnJlZF9zY2FsZTsNCj4gPiArICAgIHZjLT5nZnguc2NhbGVfeSA9IHZjLT5nZngucHJlZmVycmVk
X3NjYWxlOw0KPiA+ICsNCj4gPiArICAgIGdkX3VwZGF0ZV93aW5kb3dzaXplKHZjKTsNCj4gPiAr
ICAgIHJldHVybiBUUlVFOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gVGhpcyBkdXBsaWNhdGVzIGV4
aXN0aW5nIGNvZGUuIENhbiB5b3UgcmVmYWN0b3IgaXQgc28gd2UgYXZvaWQgbG9naWMNCj4gZHVw
bGljYXRpb24/DQoNClllcywgd2UgY2FuIGRvIHRoYXQuIEkgd2lsbCBmaXggaXQgaW4gdjIuDQoN
Cj4gDQo+IGJ0dywgaXQgd291bGQgbWFrZSBzZW5zZSB0byBzZW5kIGEgcGF0Y2ggc2VyaWVzIG5v
dyB0aGF0IHlvdSBoYXZlIDIgdWkvZ3RrDQo+IHBhdGNoZXMgYW5kIG1vcmUgdG8gY29tZS4NCg0K
SSBkbyBoYXZlIGEgY291cGxlIG9mIG90aGVyIHBhdGNoZXMgdGhhdCBJIGFtIHdvcmtpbmcgb24g
aW4gZ3RrLXVpIGJ1dCBpdCB3b3VsZCB0YWtlDQptb3JlIHRpbWUgdG8gZmluYWxpemUgdGhvc2Uu
IENhbiB3ZSBjb21wbGV0ZSB0aGVzZSB0d28gcGF0Y2hlcyBmaXJzdD8gSSB3aWxsIHN1Ym1pdA0K
YSBzZXJpZXMgZnJvbSBuZXh0IHRpbWUuIA0KDQo+IA0KPiB0aGFua3MNCj4gDQo+ID4gIHN0YXRp
YyB2b2lkIGdkX21lbnVfdW50YWJpZnkoR3RrTWVudUl0ZW0gKml0ZW0sIHZvaWQgKm9wYXF1ZSkg
IHsNCj4gPiAgICAgIEd0a0Rpc3BsYXlTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiBAQCAtMTU5MCw5
ICsxNjY5LDI0IEBAIHN0YXRpYyB2b2lkIGdkX21lbnVfdW50YWJpZnkoR3RrTWVudUl0ZW0NCj4g
Kml0ZW0sIHZvaWQgKm9wYXF1ZSkNCj4gPiAgICAgICAgICAgICAgR3RrQWNjZWxHcm91cCAqYWcg
PSBndGtfYWNjZWxfZ3JvdXBfbmV3KCk7DQo+ID4gICAgICAgICAgICAgIGd0a193aW5kb3dfYWRk
X2FjY2VsX2dyb3VwKEdUS19XSU5ET1codmMtPndpbmRvdyksIGFnKTsNCj4gPg0KPiA+IC0gICAg
ICAgICAgICBHQ2xvc3VyZSAqY2IgPSBnX2NjbG9zdXJlX25ld19zd2FwKEdfQ0FMTEJBQ0soZ2Rf
d2luX2dyYWIpLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZjLCBOVUxMKTsNCj4gPiAtICAgICAgICAgICAgZ3RrX2FjY2VsX2dyb3VwX2Nvbm5l
Y3QoYWcsIEdES19LRVlfZywgSE9US0VZX01PRElGSUVSUywgMCwNCj4gY2IpOw0KPiA+ICsgICAg
ICAgICAgICBndGtfYWNjZWxfZ3JvdXBfY29ubmVjdChhZywgR0RLX0tFWV9nLCBIT1RLRVlfTU9E
SUZJRVJTLCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGdfY2Nsb3N1cmVfbmV3X3N3YXAo
R19DQUxMQkFDSyhnZF93aW5fZ3JhYiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2YywgTlVMTCkpOw0KPiA+ICsgICAgICAgICAgICBndGtfYWNjZWxfZ3Jv
dXBfY29ubmVjdChhZywgR0RLX0tFWV9mLCBIT1RLRVlfTU9ESUZJRVJTLCAwLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgIGdfY2Nsb3N1cmVfbmV3X3N3YXAoR19DQUxMQkFDSyhnZF93aW5fZnVs
bF9zY3JlZW4pLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmMsIE5VTEwpKTsNCj4gPiArICAgICAgICAgICAgZ3RrX2FjY2VsX2dyb3VwX2Nvbm5lY3QoYWcs
IEdES19LRVlfcGx1cywgSE9US0VZX01PRElGSUVSUywNCj4gMCwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICBnX2NjbG9zdXJlX25ld19zd2FwKEdfQ0FMTEJBQ0soZ2Rfd2luX3pvb21faW4pLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmMsIE5VTEwpKTsN
Cj4gPiArICAgICAgICAgICAgZ3RrX2FjY2VsX2dyb3VwX2Nvbm5lY3QoYWcsIEdES19LRVlfZXF1
YWwsIEhPVEtFWV9NT0RJRklFUlMsDQo+IDAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgZ19j
Y2xvc3VyZV9uZXdfc3dhcChHX0NBTExCQUNLKGdkX3dpbl96b29tX2luKSwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZjLCBOVUxMKSk7DQo+ID4gKyAgICAg
ICAgICAgIGd0a19hY2NlbF9ncm91cF9jb25uZWN0KGFnLCBHREtfS0VZX21pbnVzLA0KPiBIT1RL
RVlfTU9ESUZJRVJTLCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGdfY2Nsb3N1cmVfbmV3
X3N3YXAoR19DQUxMQkFDSyhnZF93aW5fem9vbV9vdXQpLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdmMsIE5VTEwpKTsNCj4gPiArICAgICAgICAgICAgZ3Rr
X2FjY2VsX2dyb3VwX2Nvbm5lY3QoYWcsIEdES19LRVlfMCwgSE9US0VZX01PRElGSUVSUywgMCwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICBnX2NjbG9zdXJlX25ld19zd2FwKEdfQ0FMTEJBQ0so
Z2Rfd2luX3pvb21fZml4ZWQpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmMsIE5VTEwpKTsNCj4gPiAgICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgICBn
ZF9yZWJ1aWxkX3ZjX21lbnUocyk7DQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0KPiA+DQo+IA0K
PiANCj4gLS0NCj4gTWFyYy1BbmRyw6kgTHVyZWF1DQo=

