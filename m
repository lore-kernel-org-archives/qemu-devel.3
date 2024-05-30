Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2355C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeqS-000798-G2; Thu, 30 May 2024 08:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqR-00078N-Dv
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:23 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqB-0006Bm-DU
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717071907; x=1748607907;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tCBCyA3QC3xUDKpKmhu7uFqyaQRiN7sbA9LPX/ickcQ=;
 b=jGZtNmrpk2W7yawblOYzWUa7xq32pT8JyLK7sHOj+jeeXhd04gAk79Gn
 J9vIJ5vFcoXQGJYRMcqHFOufkx4Y+TTyub37qCyblOwRtCy/k6A+Vvief
 EqBBV1aMBum5wt2AsP8Scok9XHiQNNf9xdGnB5bBHACJudcsfiTL2mwui
 m+LiyVDWml3NyuwU1H2d8oinbyo0EQCY77NMO1HsK0v5faWrcop2EWGiP
 ZAnpymuoka3hV/+0GpzuxZMwN7+MS2p3iLJ37eUmj/qkG3jL0HpEuzM10
 KosgzzbsCSwvNUlQQeNpUaBrslP1V19WO360W7rgjMDceWHYt6aVDfvvM A==;
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; d="scan'208";a="13581113"
X-MGA-submission: =?us-ascii?q?MDEmsCtzrkQ3an1DIC4XTmJRGd2v9fmMbMkrAm?=
 =?us-ascii?q?u7zCjTwJvzQOFKqKw0Wa6croVj5nujNjkqSpzkKRvD93hvknunVtas7+?=
 =?us-ascii?q?zhSyJMr5GVs4Kzk4C/lUYVMu+fDA8UzIn3LSiM1g8mqjPh8EF76z2AaA?=
 =?us-ascii?q?z81o+hfLyFZIUHVnZC9wvcTw=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 14:25:01 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX5Lbg5jQavsx0vGtIwvNSvbLY09T5ec0oezCG5qGhdGPWfEAuDx7hhT6KHhT1zTdPt9yZzgywhmVbmXm6kmc7vax3fvUCQjC6akoPiPRebwOjqC+E50kUbFBxVqtso/lp/38llnPYirNYxhMHdLYGHnoLWifl3E15P1ho8KnEDQDLFZyf3j1N993+IG2LFZ8Tizc0ekOY569uAiVBRsPt8syzOa//0nuROCCqbaTUVLEWugob54xtl3ufROu6A/X7Jlqn/ZDfTbB7xxRp/Byh6xqdBijMhqOWQO1olZem7ig5D8ybaivqmgCQQ9o0rHlbCTPLM+jOmpPsCptGMmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCBCyA3QC3xUDKpKmhu7uFqyaQRiN7sbA9LPX/ickcQ=;
 b=MKouLe79O9V83CjdxMRQpaG0zIgkko8wYsFtP9pjdtl0EkrcdWFp1rj6Vy/8dgy8S7/hm85rnpt98kdRRQcw5ZOlhOiQBucshA5CJTzaY0sNDeNIYCVDRhjq6yapOX/20WfZDQcPKf0ncwCNGWB0GfX4IwQ3WyQkCWH3AhOR2AhYACPhpP5Tq80Spn0TDr6JAgVfOpcFPr5a1/YxIFk52FdXX2VFjefJ5nC/asP3XPwzXyFDS1dmVt+as3JgSk+N3uAF4YmWAOFJS2WkBiIvp2TYdvsC1+nL4A2qVwzdQAFAj8zWuLE75/n5HBggvujGpkOUeqoA9t5KwizTBE4W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8069.eurprd07.prod.outlook.com (2603:10a6:20b:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 12:25:00 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 12:25:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 2/8] pcie: helper functions to check to check if PRI is
 enabled
Thread-Topic: [PATCH v1 2/8] pcie: helper functions to check to check if PRI
 is enabled
Thread-Index: AQHasoxkPVm+Hva2J0qbK0L/RbRYyg==
Date: Thu, 30 May 2024 12:25:00 +0000
Message-ID: <20240530122439.42888-3-clement.mathieu--drif@eviden.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8069:EE_
x-ms-office365-filtering-correlation-id: f6d05f19-6b2e-4424-14bf-08dc80a386cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T293ZUJGV0V2cURCOWcxSnZkNWxvR2RyQ0E3LzFZRklxeVNEeW5RWFRzWk5J?=
 =?utf-8?B?dlFPY2RjRGhDSUZEUGdXaE9mTHNpNFNrMnBUNUNoL01OVUd3cFMvSTA0NWpZ?=
 =?utf-8?B?c21oRU5SZ1VobnBkZmtGMFBaeityenhrVUQvZGxCZ0xOVE9GWkNQaGJOZkNm?=
 =?utf-8?B?amJRdDgxOEd3SnFNM29xKzFUempvclluckovY0h5aWlsR2dGanlHOXdZSnV5?=
 =?utf-8?B?YzhOYm1aQ2FhUS9PQVAyb3VFRkZxOGE2dW55cUhKY2syWUorYnBydHh5dEkz?=
 =?utf-8?B?Z1MxMUtWL1ZEK2hmZ1U1bU5kcEhWL3BXMnFGYmZvR2Y2ZVpvVXVlUWpFeWRi?=
 =?utf-8?B?Z0RCb24zb01kV0M0SW1UWEhYcjFiZ3lyMGdLRnBqNXhXUjlRcFRsOThaVVVx?=
 =?utf-8?B?cmZvRDN6ZGpJOHpWWlNqbHV3OGxvaWw3Z0VpSjF5VzJKTGwrTzY0UVkyY0Jx?=
 =?utf-8?B?OUJKa0F3RGk3UERGY2t1dlJPOEt4bjNQWmdISDJtVk1RL1JTMml4SlppWlB4?=
 =?utf-8?B?TkhvVWF5UXlPTUl0YlVSSmMyQm12OGpRcDgwRDlGQVR2V1RTdjZka2dHSStO?=
 =?utf-8?B?cytFR1J3NXVOSlVDazZWNGdFZVpYZS9VTjFzZU9EM3NJcTNMWHpoM3ZOSjJJ?=
 =?utf-8?B?SEZveEU5UlRmZndmOENPY1dSUHpkam1nZ1BzeENDcmU1RFFuUUE0OG4yM1NG?=
 =?utf-8?B?U3JxOUFPd2VCeHc5NTBCWmUrRTI5NEk3UkJrRTlwQkIrQ3RhQndsWEFZQXVp?=
 =?utf-8?B?SURmL3gxR0hOaEtIeHZBZEMzOU9vSitlaGVIWmNENy9DSEoxVEV6WVJMWEVH?=
 =?utf-8?B?cjB3Z1ZXY21ZTnl1aGI3OWVEREV5YjdRcFZRN2R2Vk0wUWVIVEpvMDBBNzlW?=
 =?utf-8?B?SEE2aGJEZnBmc2JCZHhuK0RZaE8yZmF5TWFMQ0F6RTNNV1Rnc3pUY05sOVht?=
 =?utf-8?B?a1ltRHRxQjVpM2x0NXYvb2JkR0t3VENaRm1BY1QxSkJtUXhLTW9xc2pWRWpG?=
 =?utf-8?B?NU9YYXQrKzVIeGZEMUlwTHU5eElLdUJvRTMwc3cxT0RaZ1BvUHQzUTlzUkdt?=
 =?utf-8?B?eHdSaGpYQmQycnNpQ0MyeUZXQ1RNcTlETlliem8ydjFJbysySEZqN3UveEEr?=
 =?utf-8?B?NEpjMnFxNldNUkJGVWdVNjMvWFh2T3MwdUc0RlMxVXlMUW52VFpQeFpSYit5?=
 =?utf-8?B?dVZqeityM2JremIwM2hoRDRsYlFWSFBEbzdhbUYvSXVvQWhPM09za1ZnWGNa?=
 =?utf-8?B?YlUwM3g1d05XWGRRVUJwM3VvU2pLR1VzNU1qNWFtc2M5eWM5M05BWnVxdXha?=
 =?utf-8?B?S1hmakxwNEdNclJkRzliL05uWU5WMXgrOE93RFQybVFzNVNzSGZMVE51ZHJ1?=
 =?utf-8?B?R2NDTG9Ga1hkNVk1azRwMmNBVE92T0Y3YVg4WGxZcTFDUFNhWW9vc1R2MlpJ?=
 =?utf-8?B?WGpCOSs4TlpzMHErQlpHRjUvWWVnMGRTWmpndlRTamxXMjNCb0dYS2lYWVMy?=
 =?utf-8?B?N0dSTlI3cVUyNC9GY2FiWUxyc1htUG5SSnlUektreU1WVnorZjM0QWhQRXpt?=
 =?utf-8?B?cm9NTS9RVWcxOFRhb1YyY21jOWQ2akZ3Q241Y0RXbGEwUFFMNHRCaTdHelRZ?=
 =?utf-8?B?Y1lvZEVXajNXc0dZRUZPdXd4MThINzJacmdocjB0RS9sdVpHcGxnRUtHVG84?=
 =?utf-8?B?WEtjL2d2RkN3bzFnQmlNTlBmVGcveVVJS2JUblQyN0ZUNGx1c1ZpZEVrZXZM?=
 =?utf-8?B?dzFWeVVYSUxLVlpUa0VscUtOVDJHQWxDeGt6eGZqMjYrS1JZS3A2azBkaFFj?=
 =?utf-8?B?U3JoMjJRU0t5eFFGTnU3UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWVWMXVxN1dlbnNubW9LbTVJQWR6bU5tdEU1RTBsZ3VtODJNZis2OHdrbzhN?=
 =?utf-8?B?RHVwbVZWSWRuVUYveUk5RnhyZUVnNEQvdGhlSWpDNzJNY3J4UUsyYWhGVDdD?=
 =?utf-8?B?Tm43QUt6eFdpYTFmU3RNUnAwb2s0b0dNc1VySW10OHZrVndUbUdGcjFXR084?=
 =?utf-8?B?aklBdlFxeGNncVVLVG9OQnE3aERsRENINTVneWt4Nm10QS9sTVZSZ0FtV2Vv?=
 =?utf-8?B?ZkJEZ3VVWm9nL2Evc3NaMXVYU3dVbVQxckYxTWFQcE01b29zK1RiSDBEeisr?=
 =?utf-8?B?c2xpYnVmMmNYTjk2KzN6SkEvMGpuUkhqNGVWaG5JaDRkZEhmR2ZURWdBZWll?=
 =?utf-8?B?cWE5K0xHYlJYejR4RXB4Znp1dnNqb0xsbEhndVJCVXZVb2UrREdJOVVBakZX?=
 =?utf-8?B?Wk1RcG1tbUVsNzh6c0ZCeVdtQjhZUlhVWEN0WExNekR4OVZEQnpETmxTYUN1?=
 =?utf-8?B?OTZMbUN3VVh2Wk5SUzFZUjQ1b2w4WWJMMWJ2Yk9XRFIyU3Y5SnNkRmtxalFi?=
 =?utf-8?B?SnZNS2pXRGorbmVLd0w3K0NRRmhRN2RKSkNyVmFlaWJOeWUyejNycDJ2VkxJ?=
 =?utf-8?B?ekZmajVLYTYzMUFNNGd2MnNsWEpldW9mL1J5Q3hKZFIyNXdLL0RnVFdnU0Z3?=
 =?utf-8?B?V1N6VnVCRk9wdnlkQzNPRmFvUFFUcVF6SERCWnZySEpESXc5aEZpT25BcFIv?=
 =?utf-8?B?ZlphL2ZFS0MvTzVYS2dQR1NTZW9KRjF5bjUxdWhJT1B3YUJOSS82dmRtRUEr?=
 =?utf-8?B?eUJzSkZGazF5b3J4NUlGWElzUUV1MVpXcDgyMkJsZnlvSUxWYzJJNFdocGgw?=
 =?utf-8?B?N0JnMGNWT3JXZjZtT0NsY1VJNk53dUIrY1V1bEpUWTJYWmZ4UFptMFhwQW5Z?=
 =?utf-8?B?aVVpbk5FdXRvd2ZYcDN1eUxJNk5NYk9CNEx3blBoQkc0WDQwdnB4TDQ3TFUv?=
 =?utf-8?B?aVhoUmM1TU9WYUFHd0ExcWkrbTFJUE9vd3pHR0p5NVNmRmN2Q0FyV3FYVDJs?=
 =?utf-8?B?YWpleXNROG9aUWxjR04wN2NrUURhTlZuMWxUTTg0dFV2YmVjU2prYVZIc1ZZ?=
 =?utf-8?B?ZCs4bWQrUVhOWUY5b0kzY1Z0ZXdoQWhxRHpFVVc2Zlp4ZWYzYmJYVll5WTIv?=
 =?utf-8?B?N283QWJNQlA0WWJHNERCbVN5aXlHUXhUYTkyMnh3U0pYV0RkS21HdmFHcDFq?=
 =?utf-8?B?eERxbE8wTjVIanYyS3lTK2hKaE5UcnZNZnMzQU93YURFYlB1cm45RFVjZk1K?=
 =?utf-8?B?Sm5vNVhCNEV2azJkNDRERjR6Sk00VTBZeFZmYUoyWEJoV09QRWxCVWRHZWxF?=
 =?utf-8?B?WnY5TDdWRVU5aXVpeThzY2dHTW45US9VOGRUWmN1TXhOcE5ZWUpRcTJMZWhS?=
 =?utf-8?B?dWFDampTcXQ0eW9ZUGl4bFk3elBubGVJQ0g5L051REE1RU5JNEdpT1JhTWts?=
 =?utf-8?B?WSswckpOck8vUEhuaWFvc3VCMlB1Z0NRRVFpUW03Tmc2YWNTRnE2bitnbkZI?=
 =?utf-8?B?anFya0RqWlhnNXVNVmQvaEFJcTlYbXpOc3crNXZFODloa2pkS29hbGljaUpI?=
 =?utf-8?B?Q3luVEZKbVNOa1VWU0g4a2NXZ1NEcmFEdHBSQkx0N0hiaXRGRjFZNnA3NUQv?=
 =?utf-8?B?M2JXdTB3R1lRRHF3NFdqRUFTQ2RpdG85ZjY3TStsSG5wanFlT0ZMaGwxcWlF?=
 =?utf-8?B?dzJSLythVXduYnJjTmNqUzUydE4yZkJCWlJ4cDJ3d1dpQjBVaU5JV1FOMkIy?=
 =?utf-8?B?eklWQUo4MlRpTzdiSXNMMnNJbERmQ0RyZ042Y0hzRnRQbEphVksxWlhTZmw2?=
 =?utf-8?B?UDQ5a0dmRkNpdkVLemhYVzFqa3Y3TkJYLzFPSTNOZFhlSTRXd3JWQW5qbTVs?=
 =?utf-8?B?aFFzZVRucDBIWlBKWEJkVVM0K095UFBIQWNuQ0dPbzBvbncxcmREdUVjK3Qr?=
 =?utf-8?B?OElaNTRjczRJeXRockRPNWQ2d3JvY3FGa2tRd0VUWGtLbTZnbFptcVVYazkx?=
 =?utf-8?B?RjlFSnQzRVFxeTBuekg5MzZrbHg3UVkyNHduSms2cHpzRjUxb0x2NkFYL0U1?=
 =?utf-8?B?OFdacHRxYTYwcGtUUVpkbUFOOHQwbGNjTHM4dmdiYXRlK3BQbnVLdjJxWnhn?=
 =?utf-8?B?Y21SRk9BeUdwaTZwb2crTis2RHc3Mmh4SVpHUkp2M3llelJvVEFFM01LOS9x?=
 =?utf-8?Q?ARsy4yjgpAQr83qfl5liVNI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35438FC9CF2B344E9BD802F41DF4AC96@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d05f19-6b2e-4424-14bf-08dc80a386cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 12:25:00.9136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNhv5rNTny6DvUouGbTvPczPnbH964czV+yfGLwMqtb8t9xEeilxM/hqUcrK/fgGgrzXb87lH3MWvj/GJarOGywzYj4Y/6FqFa1zctqCLX7D2ry0JcsLp9HbQEC4VX4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8069
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

cHJpX2VuYWJsZWQgY2FuIGJlIHVzZWQgdG8gY2hlY2sgd2hldGhlciB0aGUgY2FwYWJpbGl0eSBp
cyBwcmVzZW50IGFuZA0KZW5hYmxlZCBvbiBhIFBDSWUgZGV2aWNlDQoNClNpZ25lZC1vZmYtYnk6
IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29t
Pg0KLS0tDQogaHcvcGNpL3BjaWUuYyAgICAgICAgIHwgOSArKysrKysrKysNCiBpbmNsdWRlL2h3
L3BjaS9wY2llLmggfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCAwNTNiY2E2
OTQ5Li4zZmI2NTg4YzMxIDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNp
L3BjaWUuYw0KQEAgLTEyMjcsNiArMTIyNywxNSBAQCB2b2lkIHBjaWVfcHJpX2luaXQoUENJRGV2
aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDMyX3Qgb3V0c3RhbmRpbmdfcHJfY2FwLA0K
ICAgICBkZXYtPmV4cC5wcmlfY2FwID0gb2Zmc2V0Ow0KIH0NCiANCitib29sIHBjaWVfcHJpX2Vu
YWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpDQorew0KKyAgICBpZiAoIXBjaV9pc19leHByZXNz
KGRldikgfHwgIWRldi0+ZXhwLnByaV9jYXApIHsNCisgICAgICAgIHJldHVybiBmYWxzZTsNCisg
ICAgfQ0KKyAgICByZXR1cm4gKHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBy
aV9jYXAgKyBQQ0lfUFJJX0NUUkwpICYNCisgICAgICAgICAgICAgICAgUENJX1BSSV9DVFJMX0VO
QUJMRSkgIT0gMDsNCit9DQorDQogYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29uc3QgUENJRGV2
aWNlICpkZXYpDQogew0KICAgICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhw
LnBhc2lkX2NhcCkgew0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaCBiL2luY2x1
ZGUvaHcvcGNpL3BjaWUuaA0KaW5kZXggMTk4ZDZkYTgxNy4uYjk3NmZkNzM5YSAxMDA2NDQNCi0t
LSBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQpA
QCAtMTU4LDYgKzE1OCw3IEBAIHZvaWQgcGNpZV9wYXNpZF9pbml0KFBDSURldmljZSAqZGV2LCB1
aW50MTZfdCBvZmZzZXQsIHVpbnQ4X3QgcGFzaWRfd2lkdGgsDQogdm9pZCBwY2llX3ByaV9pbml0
KFBDSURldmljZSAqZGV2LCB1aW50MTZfdCBvZmZzZXQsIHVpbnQzMl90IG91dHN0YW5kaW5nX3By
X2NhcCwNCiAgICAgICAgICAgICAgICAgICAgYm9vbCBwcmdfcmVzcG9uc2VfcGFzaWRfcmVxKTsN
CiANCitib29sIHBjaWVfcHJpX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpOw0KIGJvb2wg
cGNpZV9wYXNpZF9lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2KTsNCiBib29sIHBjaWVfYXRz
X2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpOw0KICNlbmRpZiAvKiBRRU1VX1BDSUVfSCAq
Lw0KLS0gDQoyLjQ1LjENCg==

