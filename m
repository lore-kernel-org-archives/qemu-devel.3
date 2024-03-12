Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CB7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAWH-0003Xh-Un; Tue, 12 Mar 2024 18:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rkAWF-0003XP-SJ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:22:47 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rkAWB-0003c3-LR
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710282164; x=1741818164;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wmYhqBy0PL8LNmlmd7Y2Hna0jhAoEpGFLDyH0IjOnYc=;
 b=k7EkBJjPFqDnY3GyyFMIwEuRnhShUQQolQKHerIgvY9HdcoM5C/dC3RE
 P9ZYP02lMdhMgEm0GmFyo0AOuCcerVsfy015iIHPA1GS9oB6kc4B5aTxP
 CKeyog/8nH7zcqJHQA6ztaGnPwbpZdbOTQ7uNiaSXlFaiaT7sOQr6axPP
 2kXd3OfC0Rvv+asoYpk4ZgJKDs2hDlI+jOz7AN2MvD9nZf5f1RBan1N02
 L+OTD+U7KoNFSp7ibZYvMbwYgs049G+bEFEv6RCBUS2JwTtfRyhvPw5f0
 RO1lOsjhGcsAEPNfGsqczf2LUf3G+2GCXv95HRuOp/fptE3vHVWnErwUm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4872242"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4872242"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 15:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16184970"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2024 15:22:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 15:22:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 15:22:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 15:22:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 15:22:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuHNQYRv0QtRXshqY0YL3R8JBe8jdqaFHRNQRD+f/wKtS4PVfCJG0ZQPX08zHqj8RB1iAiJtIt6yio7RbuS+59eL/W+dyZoeG14FDpF0znZ6lSOGnrPQDv023GBnVYPralypPEmTBm+z3p32oDJhCIw+2XIjgldjFQ4G9dFG8nGnB0741MtQoOSylJnlYbfytX8eCW1SiEcVHzsdriqGhQx59YV+ZUGGEovZLqkvJZ/l8ybrq+pJUTCVjYC7CTAsEYBAoK30stacUTOnTTq5dhUR1qN4WgiD28hCyg4S+aLdUHv4OBICt9uFpHUbzUvOjtCZBtAdQZQlGp4F9ZxgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmYhqBy0PL8LNmlmd7Y2Hna0jhAoEpGFLDyH0IjOnYc=;
 b=mS63yuoHNlPNHXhACRHVc+ff7zXtZvAD/qEGHpGsoDNAOHOinz/Q+K5cr0Kzklc2VupE9BRbJJLQSmUV353h2v0EkBdg7Am2fAf+885w8wTid8A16vnAvaVUMPFktXkOex/0jk8QHmDJuCVA1fHLuRvgyYtJ8DP/l5d3UfokDx376WbZnHYMbV+NuH1vSRF1IvlyqybD4MYGYzZshBwnZSkiI9/eZ4FEpGqasCq1rpzLPUPKY80FQN8neaMNU6C1ViTc9LKchte2l9k0nhUJDh3ZtMzYcgmgDT8vmjCbMOeBji2gLDdrDUUXrFGdqv3wv+eClZi0ycofCpXaf9IY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Tue, 12 Mar
 2024 22:22:35 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 22:22:35 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] virtio-gpu: first surface update with blob scanout
 after resumed
Thread-Topic: [PATCH v2] virtio-gpu: first surface update with blob scanout
 after resumed
Thread-Index: AQHacBWW0ntgWIse5EuYSZu0LGlMXrE0Am6AgAC0oTA=
Date: Tue, 12 Mar 2024 22:22:35 +0000
Message-ID: <PH8PR11MB68795AF0A54B300B4F7ED6F6FA2B2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240306222535.3236855-1-dongwon.kim@intel.com>
 <CAJ+F1CJG3fMhon-GyRCsjtJtJ3m6OK7vtPDEix=Hwnxt=sKjjg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJG3fMhon-GyRCsjtJtJ3m6OK7vtPDEix=Hwnxt=sKjjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|MW3PR11MB4716:EE_
x-ms-office365-filtering-correlation-id: 55bf672a-e7ec-49b4-6cd0-08dc42e2eb3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1fBLLE1j2tgDrYhGcbCFKgZ5NZjYHXkajxFVg4seAgDafeTAIZyxzQiOGEQ2LqVTpYDPUZppTLU4sn8VYCnSBdv6B6juR5zIv/geJ8rhFdfEW33HSCUE00FCNqroWEJKakB51OWcYA2dsBXiCx9Ag2YulDMFmxtibj8wVz54aa+0lUgtPlsxLHbgM94zitmVvcRx9jYf34X5Bo2CsWM1NmOz0KfEfZgQ9r5EaAu7QlsHJp7dvuLbeB7ug2ijI3Tv4t9ha/skZt6E7aJBLxyN0Wj7LlkF+3l2odc3RN83xBzVqqauJWW/v4lAwg6ZjB3gxzPDBM/fAJanJn2l6PIupLPZcOYpx5lQ7Tt/TnrKqx3U+5caYaOX172azrMKRC4kV5shgOgW8awiRfeo6kr2FzQak2UBifB0YJZvRhT5XKnz08iFcfBm/+1F9UhO3fM5Cu9FTLNpmQ5pDNt/3qpGRlZUEu7A5Yglhfj+lQmHzNMueOy76AjFx0yDeandSM03Phc2CrHQRMwrJcDFFvlUUC4YEGRRv1L9+iAsAV732ptEsp2lhJMsZJULe4Wsl5TJZ7qv2sj/LqAHJvmg5FE6WTFwqd5MAQhEJbvQjxpWBvjCGZJ8zuVKKZP4zQ06L1wEKv+mU3uHcYTWDBlRPB82UrmirbQ2LItQf/TrGEo5CA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R09jOFJpRUVPSm9wSndyVk5xQVBzYVFYMHd3VG9SRit1ZFlXN0xKaUhTRGpC?=
 =?utf-8?B?OW0xNElWVUYvd1NnNVB6MW5LeTNHeWYyWTN6ODBsQlRTS0sxWVdoNS9scXFm?=
 =?utf-8?B?UkJ3L3pLVmR0WDIrSDF5Y1hQZlhHenVvQi93NlZNWlZyS1VwNlNzSEdKQ1Jp?=
 =?utf-8?B?OTFtQ0dVMGpPc3E0ZWR1bWFQellkejB2b2gxRHl5MFhtOHltQ0hlQkpYT256?=
 =?utf-8?B?REpaKzkwZVBhYmRIWmNCUXNUVG1xVVBDZ290N2Mvd1BrNGRvQThjV1NIS1Mx?=
 =?utf-8?B?djNuUEtsVER3Z0tDYmk2dmFvWXdKSVJKbWhZbzF5S2NyeUFiUTltcFo4bUdr?=
 =?utf-8?B?TkJkVW1yT2dMbXR6NGt6aTJjMHV5MEFUMXVYT2QzWC8yRWdUY21VLzFzZXdB?=
 =?utf-8?B?d0x0OEZvODB3dHRWSGtQZVR5SGYrOGZnWFJEbldpdVZPOUNHWDl2akdSWG9M?=
 =?utf-8?B?SUQ1dFJCeUJPWDZ5aTBMRTNmTkdjay9kMFdIbVY0V1A4Y0FmUjJiUkw2T1JX?=
 =?utf-8?B?K2hla3JXcnpHWmFxL3BKOTg5K3hVT2lDYlZqZW1KNThkSmdoRSs3c3pvTDJT?=
 =?utf-8?B?LzB4L0lHeXZUbjNFTkd2eEZFeFplS0tVbWswVnNRMndTU1pPYllVSUFwdklH?=
 =?utf-8?B?S2NGaGc2RGltR0hJNlVLRXJWdzNkeHU1WVh2a1Awd0dBWmt0NWg5WGhIWk5z?=
 =?utf-8?B?YldmYzdDN1ZKSGVTbE9KUHZTVXRJVU1CQTVDMDdid04yaUJjcW5KZVF4T1py?=
 =?utf-8?B?ZVBQWS8reC9Id0ZYNUpKWndoYkhKRDEzNEdqZ2MxSkVzNDFxWVdneFBDNktx?=
 =?utf-8?B?c0RjdXJNVm5pOEd3R2NNMDBLQ2p0ZU5aZEdNSC9rdWh1UjBFTldmQUNGYWE1?=
 =?utf-8?B?MzUyZkxjaHFUYzVOam5kOGczU3BDTFpUZWgrbW5ucGhGd085Q1NrYlR1NGxp?=
 =?utf-8?B?cmxQOXltM0ZpRVNPSlI2dGNUdUQ3Z3lSaERMbkd3VFYvSkRRN29DN3lZSUNP?=
 =?utf-8?B?U3VaZUk2aXRndWlvQ29BWmZ3d3FCT3dLRmducTloUlFBNlByMlBDMlRZcGVa?=
 =?utf-8?B?ckJXZ3p5RndPTndKN3pPYkt3OHVXczkzd2JJWmphWk5KVEdWOTRENXFKSmVp?=
 =?utf-8?B?c2VjVDN5dDNzdGhrckpaYU9KZXZ3NWRTRkxhdG9Rd0oyQVgvcEhwWlE3NFFD?=
 =?utf-8?B?YjJRNDZLbVJXdmkwOHJCSGIwTk95bm8yb1RUNmZXbmFNWjdIeFpESGJQTytN?=
 =?utf-8?B?SGljN1JmeWhKVy9iTW1FRkRadEhlb2hUeVlDZldGR0RxYVQ0cWYwYS9JWnFT?=
 =?utf-8?B?ODVPQ1RhaVk3SGpGVFFoaGUxbVhGL2RMbUtxZGU2T3pJZEFWNlhVd0F6UTJF?=
 =?utf-8?B?elYrU1BMSkZmSXlYbXlUY2xVUkdsOFcwZTVNb1VNVU45Wk5UaUhsL3NzTmlY?=
 =?utf-8?B?cGk4NllXbWNVOG9nVnJPbUNtUmxxTmhJd3VjcnNEYXQwTUZuRFVpa0RFM0tE?=
 =?utf-8?B?V1llYmhyZDlpT2h0ZHJZWktBa3VadldYZXVjVzBkNDZLSnlkZCs2bTB1V2JR?=
 =?utf-8?B?UUk0Y2F4WnFmNGg4N1V1TkthSmx5SW1QS0NNMzlkTEh2MzNDQkJkYTBJbGtC?=
 =?utf-8?B?L09DaUtZb21YWEpJOVBnTjFwNVdheW9ibWNKMDhISWJlNDE3V3BXdjZ1Rkcx?=
 =?utf-8?B?cXhhUmJxNWQ4dUtnS2tQVXBGQkNyNzBneklPQWl0MVAraXBQY2pNUThrU2xV?=
 =?utf-8?B?OWkrVlFoZUl6MHRwWk1ZSGNzVUZHUEdFamV5bXpiMnp4WlRRaVFIV1pxTm4y?=
 =?utf-8?B?cGlNQmZzK2hOT2pycGJ1SUwyL3BMS08wSG9TNHZUb3BBUlFxek5HbU4rMXFK?=
 =?utf-8?B?UCtRemtHK0ZVNEFUYkFUOE1RRXZCclNDZ2hUZGZOOWF6WkVuL0ZDbFZtenZT?=
 =?utf-8?B?ZmVGWHhDSjB2K3VzeG1QcjVmbU5seWNSeWlOYWJYUE9kQlJFVWNJNTlKa1o1?=
 =?utf-8?B?T205dDNYT3hkRC9tZHVUaWt5ckh3OXU2V09YMzEyNWNLRkc2S0JvK0F6ZnZ2?=
 =?utf-8?B?R3kzbnRWNlFLV3pscGR3NTBKUkdPL2hucFdpanpjSDVyNnNmMlBuYVBBZFcw?=
 =?utf-8?Q?JpYv5zq/ZHlXA3pnjTHJdD93A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bf672a-e7ec-49b4-6cd0-08dc42e2eb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 22:22:35.5789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 747B27T3mOfttPErnKEqs9fOwlbXn3XezpJzFlb+meAspxgn8Qwrza0iUwPnTHzYjTFLB8llopwvRzsullfBtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgTWFyYy1BbmRyw6ksDQoNCk9rLCBzZWVtcyBsaWtlIHlvdXIgY29tbWl0IHdvdWxkIGZpeCB0
aGUgcHJvYmxlbSBJIHdhcyB0cnlpbmcgdG8gc29sdmUuIEkgd2lsbCB0ZXN0IGl0IGFuZCBsZXQg
eW91IGtub3cgdGhlIHJlc3VsdHMuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCj4g
U2VudDogVHVlc2RheSwgTWFyY2ggMTIsIDIwMjQgNDozNSBBTQ0KPiBUbzogS2ltLCBEb25nd29u
IDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gdmlydGlvLWdwdTogZmlyc3Qgc3VyZmFjZSB1cGRhdGUg
d2l0aCBibG9iIHNjYW5vdXQgYWZ0ZXINCj4gcmVzdW1lZA0KPiANCj4gSGkNCj4gDQo+IE9uIFRo
dSwgTWFyIDcsIDIwMjQgYXQgMjoyN+KAr0FNIDxkb25nd29uLmtpbUBpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gRnJvbTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4g
Pg0KPiA+IFRoZSBndWVzdCBzdXJmYWNlIG5lZWRzIHRvIGJlIHVwZGF0ZWQgd2l0aCBhIGJsb2Ig
c2Nhbm91dCBhZnRlcg0KPiA+IHJlc3VtZWQgZnJvbSBzYXZlZCB2bSBzdGF0ZSBpZiBibG9iIGlz
IGVuYWJsZWQuDQo+ID4NCj4gPiB2MjogUmViYXNlZA0KPiA+DQo+IA0KPiBUaGlzIHBhdGNoIGNv
bmZsaWN0cyB3aXRoIHRoZSBhbHJlYWR5IHJldmlld2VkIChhbmQgYWxtb3N0IGluIHF1ZXVlKSBw
YXRjaCBmcm9tDQo+IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDI0MDIyODEyMjMyMy45NjI4
MjYtMS0NCj4gbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tLzIwMjQwMjI4MTIyMzIzLjk2Mjgy
Ni0zLQ0KPiBtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vLg0KPiANCj4gVGhlcmUgYXJlIGNo
YW5jZXMgdGhhdCBpdCBzb2x2ZXMgeW91ciBwcm9ibGVtLCBzaW5jZSBpdCBjYWxscyBpbnRvDQo+
IHZpcnRpb19ncHVfZG9fc2V0X3NjYW5vdXQoKSB3aGljaCBoYW5kbGVzIGJsb2IgcmVzb3VyY2Vz
Lg0KPiANCj4gQ291bGQgeW91IGNoZWNrPyBBbmQgaWYgaXQgZG9lc24ndCBmaXggaXQsIGNhbiB5
b3UgYXBwbHkgeW91ciBzb2x1dGlvbiBvbiB0b3Agb2YgaXQ/DQo+IA0KPiB0aGFua3MNCj4gDQo+
ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0K
PiA+IENjOiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiAgaHcvZGlzcGxheS92aXJ0aW8tZ3B1LmMgfCAyMSArKysrKysrKysrKysrKy0tLS0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvZGlzcGxheS92aXJ0aW8tZ3B1LmMgYi9ody9kaXNw
bGF5L3ZpcnRpby1ncHUuYyBpbmRleA0KPiA+IDFjMWVlMjMwYjMuLjAxYmM0Zjk1NjUgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvZGlzcGxheS92aXJ0aW8tZ3B1LmMNCj4gPiArKysgYi9ody9kaXNwbGF5
L3ZpcnRpby1ncHUuYw0KPiA+IEBAIC0xNDIyLDE2ICsxNDIyLDIzIEBAIHN0YXRpYyBpbnQgdmly
dGlvX2dwdV9wb3N0X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQNCj4gdmVyc2lvbl9pZCkNCj4gPiAg
ICAgICAgICBpZiAoIXJlcykgew0KPiA+ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4g
PiAgICAgICAgICB9DQo+ID4gLSAgICAgICAgc2Nhbm91dC0+ZHMgPSBxZW11X2NyZWF0ZV9kaXNw
bGF5c3VyZmFjZV9waXhtYW4ocmVzLT5pbWFnZSk7DQo+ID4gLSAgICAgICAgaWYgKCFzY2Fub3V0
LT5kcykgew0KPiA+IC0gICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAtICAgICAgICB9
DQo+ID4gKw0KPiA+ICsgICAgICAgIGlmIChyZXMtPmJsb2Jfc2l6ZSkgew0KPiA+ICsgICAgICAg
ICAgICBhc3NlcnQoZy0+ZG1hYnVmLnByaW1hcnlbaV0gIT0gTlVMTCk7DQo+ID4gKyAgICAgICAg
ICAgIGctPmRtYWJ1Zi5wcmltYXJ5W2ldLT5idWYuZmQgPSByZXMtPmRtYWJ1Zl9mZDsNCj4gPiAr
ICAgICAgICAgICAgZHB5X2dsX3NjYW5vdXRfZG1hYnVmKHNjYW5vdXQtPmNvbiwgJmctPmRtYWJ1
Zi5wcmltYXJ5W2ldLT5idWYpOw0KPiA+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAg
ICAgIHNjYW5vdXQtPmRzID0gcWVtdV9jcmVhdGVfZGlzcGxheXN1cmZhY2VfcGl4bWFuKHJlcy0+
aW1hZ2UpOw0KPiA+ICsgICAgICAgICAgICBpZiAoIXNjYW5vdXQtPmRzKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICAjaWZk
ZWYgV0lOMzINCj4gPiAtICAgICAgICBxZW11X2Rpc3BsYXlzdXJmYWNlX3dpbjMyX3NldF9oYW5k
bGUoc2Nhbm91dC0+ZHMsIHJlcy0+aGFuZGxlLCAwKTsNCj4gPiArICAgICAgICAgICAgcWVtdV9k
aXNwbGF5c3VyZmFjZV93aW4zMl9zZXRfaGFuZGxlKHNjYW5vdXQtPmRzLA0KPiA+ICsgcmVzLT5o
YW5kbGUsIDApOw0KPiA+ICAjZW5kaWYNCj4gPiArICAgICAgICAgICAgZHB5X2dmeF9yZXBsYWNl
X3N1cmZhY2Uoc2Nhbm91dC0+Y29uLCBzY2Fub3V0LT5kcyk7DQo+ID4gKyAgICAgICAgICAgIGRw
eV9nZnhfdXBkYXRlX2Z1bGwoc2Nhbm91dC0+Y29uKTsNCj4gPiArICAgICAgICB9DQo+ID4NCj4g
PiAtICAgICAgICBkcHlfZ2Z4X3JlcGxhY2Vfc3VyZmFjZShzY2Fub3V0LT5jb24sIHNjYW5vdXQt
PmRzKTsNCj4gPiAtICAgICAgICBkcHlfZ2Z4X3VwZGF0ZV9mdWxsKHNjYW5vdXQtPmNvbik7DQo+
ID4gICAgICAgICAgaWYgKHNjYW5vdXQtPmN1cnNvci5yZXNvdXJjZV9pZCkgew0KPiA+ICAgICAg
ICAgICAgICB1cGRhdGVfY3Vyc29yKGcsICZzY2Fub3V0LT5jdXJzb3IpOw0KPiA+ICAgICAgICAg
IH0NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJjLUFu
ZHLDqSBMdXJlYXUNCg==

