Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A822BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78rC-00051k-0I; Wed, 15 May 2024 03:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qf-0004cx-5b
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:50 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qc-0000oi-7j
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757286; x=1747293286;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dWr4H79CgiiRUd9/Jx/CWh2pAcI+XqlvGTj2UdsuRB0=;
 b=BZ71dmMsQvctiKwvmPZeL1c/CDa97JfIzmAhuoFQSJ8se44+5LZE6+/T
 Fisa3lut7PhdrhPvxyY9UGkgE5k8hYuQvLtEy/mBInDNWsWbAbcw3c5Oc
 WvmNs/a2EaMt+y6qUATSvrd6V7ImdNmdgn/AJJI1sGialV0KlQnscrHe4
 RRGo/k1Qn+6bxOJfGZkHmbf4ymhC7MeTNpEv3/9uJBwfEl/oIpU5utksW
 OyVH2JSlndwsOKOxncGaPho/CHTVju2RelMgT4OnukDCHkGFbWcSEvk0M
 fN4763LaQzfoN/+RYj42SIJix6is4tRiI4uKnyKQekSbEpoT4Sezd1otv w==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581807"
X-MGA-submission: =?us-ascii?q?MDGn6mwBC2ycBNdvkY/TwQHw0wt7Rakep+UVer?=
 =?us-ascii?q?riQgVJbYztiV0vWeFTg/NUeOLgQ4fuY+PHxz8R66PxJf11QMzPPtlkD3?=
 =?us-ascii?q?cNfhAMHic9IoU7QXIzwPvsF8HymVFVQ+tvaQ5mdpqPo+gk1UHqabDsga?=
 =?us-ascii?q?8pMWoP2hFUiNKLubWh7Ii03w=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+gEuWTyiQueU5lKtnm9IUVdZEt/AybpgWcCrEXgkvwvDAYQ/Ov3XT414CWv4QJlf8mslhJ9CfkWLF00hvW02VS9VglWJvwX4+rzWrmG6VnpylzKgtUVyDSHoRDJ08oOI9o2AVWlRSgo8ixL1EsJdvWRdR79YkC6gMPN2w6S7QkvdJstbWlLFl+EpA/EPSkGTdgv1rSzyKiDBxTtStK4NVwal/4zNVdtIAjosY7C6nB/OZjrYNLiCvSpnBRNusGfVSR/ic7Jo2Ata2bqGS8Yw9inb2CKZXYqWj59wiKYLFsfnWxDVPVHCmh8bJGAvnYDCKjU1LcGpNd6zSCDiskhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWr4H79CgiiRUd9/Jx/CWh2pAcI+XqlvGTj2UdsuRB0=;
 b=IaqxDmG7lbqUTRQexrDgBQh4FUXHKUSZzxvECZY67H0T9cnVbNB7+JXIWsUG9jxGrUjjffhZv3ALNkUmKY/K1j4YN1QQAlXh5DMKgWIsf9J7uWCRDi1A02RAgt6o/AFvf1yexjTsbl6RSmcRnbw3II6JPSjEcwfJtY+Sfozr04dlhA4+PaLPS/4arPGyrqmgmNTjrIGZ0Hn2Bl8sVSi/c2++izMuc4JkkLGePi5KZl5NmeCqQ9d9MJkZdNJ7nUlvBPsN8qvXYpOm7ANvc08C1E4X/YiFLwD2okZlthKi4M03HsMIvGb/xsRFiYgCyhnT3qsK0IMliKI4DvbLKZrN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 19/25] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v2 19/25] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHappeA+UYfPo/Y9EKbS/loYd4PWg==
Date: Wed, 15 May 2024 07:14:18 +0000
Message-ID: <20240515071057.33990-20-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: 228aee1e-6642-4cd7-55a9-08dc74aea311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MHZvYy9YbU5MQWVNWmhjY3R2VlRIV2F1cndYOUF5a2k0OVFoUCttUlQxT0Nq?=
 =?utf-8?B?ZTlSWWFtTVZsYXZrcStJVVFGK3VMRXJtWWhrNG16QzBNQzFHQktrYjFlL3lD?=
 =?utf-8?B?a2hoM09xWjNEV0tHQXVTY3ZuVlBKS3lXY25ienZVaFUxRTFCZHE2ZjFiY0N3?=
 =?utf-8?B?dEtEOGRSbnJiTmRPVTZVb0o4eUpjb3NzY04yanM1SnNZZG9tdnFxV05NeFBw?=
 =?utf-8?B?bkdvWGhyMWJaQzVkY2VDU1d0cFBFV083eUxUQ3IyTWxuejBIYjFMUldXTm9K?=
 =?utf-8?B?TXBGSnowOFVVUnRQcE1jZEZrWGVzVDRXWTQwb0ZTWXozencyZFJya2NsMHpB?=
 =?utf-8?B?Y0lFQ2RLcXNoU2RMU0pSOXE2V3pNMUhjRDNkODJYemVhaU1TSkxFUXU5WVRW?=
 =?utf-8?B?TkFnQXZOVTRuVGN1RHE1RksyMFQxbVVRTHpvaVp6aDNGK0w1K2JjZzV1RnpJ?=
 =?utf-8?B?TG5IOERKdUZFZEJyeTBpbE52T3V0K241OUVXb1VkVTV1RDFzc3Q1Z1hlMm9S?=
 =?utf-8?B?U0NjLytVNzkrKzc5UWUwM3Zyd2g5UnhyRk5Lbk5tUmU4WHloeTd3S0h4VHBU?=
 =?utf-8?B?bVJweGl1MithcTdNTjJMdW9vVStnVXRsRzVvYmk0Rnk5TEZvcE1XemNRalkv?=
 =?utf-8?B?dVlPY2FFWGxxd3BzNVhGSHR1WFB4Y0VmMjNDSmlYKzBSS2dKUXNUcjBzMEdE?=
 =?utf-8?B?bGhDQmp0SWxtdjVnczlOdUZNSDYzL01CNHVOWG5WV1dqUE04UVdQUzBwUjdY?=
 =?utf-8?B?d1RkNjJtNUxjU2xLK3Nqd3JxcGwvdmxqbVNCbVRmNWhMQk9vdnA4cnNYNm01?=
 =?utf-8?B?WWxYUkNhU1dLN2VlM3JKcVc0NU45enlWRm12SnpOVHdyTGRGUXRsd0xKSDZu?=
 =?utf-8?B?RlI2WUh2d0l3emtUSEhlSzEwNEUwdFl0SlVwM0E1VkpFaHFaUklDN1Bvd0V0?=
 =?utf-8?B?QktxZGorY3IrY3lISzVMWlFIUG4wM0xxelFwSDYvZmxncEJGZmowYll5UmQ3?=
 =?utf-8?B?dlpmQllESE9MLzN5aklDalhuYmw3SEhvb0puYVNlRFF1dldra1M2WEE0RFcw?=
 =?utf-8?B?YXZuekd4UTN2YmM0S0JiL3NNT1l6UUpkcStDbENnbVhuSnhxQU1TaS9xSFFo?=
 =?utf-8?B?UzhkUHlyMmlna0U1RXcyNHNLUXdETlRjN0dHSEtQamFqaWZMaCtZTjIrQ0Ja?=
 =?utf-8?B?OGtmMHJKTFB5T0VqREk3VHpSdThtaWovNXVEQWE4SzZBRmRSNjB0dFlwb1B6?=
 =?utf-8?B?SW9kQUo4UHlNT3dmcEtUb2hOVjlOYlF0VnVuaFdSS1BncHVSR2VBRzNGVXlj?=
 =?utf-8?B?dU91L2JqNzdvUGFTYkh6MlArSFJ4ZXk2SFB2OS9ZdTh4ektwU3dpVHk2YzZh?=
 =?utf-8?B?Y1lNYVp4b2xmMkFON0hpY0RyT0hRM2VPd0dqdzNKZ0F5THJmYTlTRkUxQXRP?=
 =?utf-8?B?YmMwZWNUSURPQW85OUMxUmtaV1g4WTFIVUJoWnhBRXptTmdlZFpzV0VmRHhj?=
 =?utf-8?B?L0JsaFNIUWdlZTM1UUcxNkEwV1Y3UUNVRjl1MXNyL3cxSk90TUdBTXhZdzQw?=
 =?utf-8?B?OXArWnNWMU5SdFhsWERwbTNoamhzbGNJMzVqQlBxdmF2cjd5MWhHai9oenZK?=
 =?utf-8?B?MkpHWlBHR1U3enVDeld3NHV5b0R6aGtGai90eENqVEw1bkFETXBxSXlGUzc1?=
 =?utf-8?B?Y0I2K0tDc0l5YlZpajNFRXV5NlFzK1g3NUtmM0NjbmVFSmZmdWtuM05XSWEw?=
 =?utf-8?B?N3pOQmhHbW02NUt6N2dWaFowM0pmb05PVllSWlZ1UlRVY1Q5ZURGQkl1ZUNH?=
 =?utf-8?B?elBmam9PTkF6NWFKWml6dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGsyUGdxS252U2Y0SzdZZjdBMkRRMVJQN0FscGlGcFc3eVBBY2dwdkUySDZ6?=
 =?utf-8?B?bU5nMEVNbktLYmJQUmZqU01RNzFXNUVjcWRJLzRUMysyUjQ2MHl3aitTZ1Rk?=
 =?utf-8?B?Z1Q5dGIxNVdFQWlmNlpiUFRIYUZsMXAwNU1tc3dkQVZTVFRNZGd3QzZZbk9T?=
 =?utf-8?B?dzZBaWJWZE9ZbjI1WTNjMjVGSGRwVW5RclVrYWdrcFRHU0pYczkwdmRhN0Z1?=
 =?utf-8?B?MllydHlYWkJvTlMvUXZ5RXNlbXdMVk5QM1N1WEg2WmNlQ3BMQldFajFnWHIy?=
 =?utf-8?B?VHNmYjQ3aXFYUEpjdVVMeTQ1UWt0YUowU085QS85S1puK2lmWXJwYkVoMS9s?=
 =?utf-8?B?alpDVTVhL2xjTVVaRi8rdDFtU3V6elpXRmFWc2p3b3YzaTA1Y0pjZ3NwQXdG?=
 =?utf-8?B?NXE4cHlEQjdDb09JdVluOUtVSXRmMDhkcU5VM1NNcHdleXdzQm5Jc1NudG1t?=
 =?utf-8?B?QU9uaHNuMjJJTCs0Z0t0eEVjS1hac05uSGxJUVZja1ZhaFRidFZrdDVJTXFs?=
 =?utf-8?B?MVBuOGtVNXZqT2p4U2xCSmc4b0lJcUxPRDU0dXdWUVE5ZVJzUHBCSTVWN3NY?=
 =?utf-8?B?V2Y1RmF2emVsYTFzUW9wZzR0SDdlQVZCN2t2MzNMNFNSMkVTakdDeldJRElU?=
 =?utf-8?B?cklzZnd2VjZ5QlQ2SVdhdk05ZDdvL3NzL0t4UU0wRFRTMTJXN0VmUncwQW5l?=
 =?utf-8?B?L01DL0lFblNRK01uMTQ0UitFemJGSll0aDVTR054SFI3dEdFZERtUVU1R0Fq?=
 =?utf-8?B?TVBiT1VSZGo3MEJNYzd6a2FIc1VmN2U0eDVISDBMSEpFazFFaEhFbnU1VUZV?=
 =?utf-8?B?czM1aTVCOEU3dWdScHBqck1jQ1c4Ykd6cWlhV01jT1F4bDYzdmlmQ2R0RWN5?=
 =?utf-8?B?WGdrc1JqUGMrYjVqUjdBaHJld3l0Zk1GT1hBMXMrYzdDSlFEakJJZkpwQkJt?=
 =?utf-8?B?V1U0dUhpYjZhbEJsSEhJTHhRK0NiRjZ1anJHOXlBb2hqNWxrQ2tvTGc0Yk5N?=
 =?utf-8?B?QU82a3Z4T1dkUFpNbFBlUEhKanNsczFubWZpQzVVakQwbjJuSGdFMlNsRGFJ?=
 =?utf-8?B?WGZvYjI0UnhwSmVQbjNHZWZ3R1dxUk5PWW5wTythMkdCdDJOM0pxdXEvZ1Np?=
 =?utf-8?B?MDZTMHR3QlpqYzhtbTA0U2VhQm9nU1BqY3BiSHZML2NZdFp0aFRmT0plekdm?=
 =?utf-8?B?ME5lR3RoNHR4aXN2ZVJNcWk3d1lCQ2NjeHliUlNiYWVjYkI5aHR6Mm4yTjNy?=
 =?utf-8?B?QytQcjBJUGphU1hTeDhZZTVoeXp5S2dueDAwaExCTzU1bjdBL0RycXcxUDFO?=
 =?utf-8?B?L1F0dnhzWDErbXJXNllyYkZBYzNodFRXdzJyTlV5b1paVDJjZVJHelRnMkdU?=
 =?utf-8?B?RU83VzFhQjhMZjA5eGlGM09zNE8zMWpRa01xd3llU2M0eG5kOXMzaHkxanF3?=
 =?utf-8?B?QXlveXhsSkd5MjV0RTV5RE5NY2RWT1pja0pKTmpxZ05hdCsvY25xSlZmQkNU?=
 =?utf-8?B?bzB1MFREeG5pT1BpMmhtRkFmbmN3OGZ6UmRyQThSRTFpN2tOVFN3WFd0bW1i?=
 =?utf-8?B?YmxYbmg2VzY0WkFMVm9HTktVZDZzRkd3V1NMTVJoQXdEaXRDVEdacUQrSWF6?=
 =?utf-8?B?OS9xYUVqSUg3enhlZ3Iyc2luMlBjOUNGS1dSckUxVVY2eEJEQmgySXhCbHc4?=
 =?utf-8?B?Zy9NTkVOOHhIdExuVnVBcFUrWFFYWmNuMVZpYi8wVUJrQStMWFAyRlB5N2Z5?=
 =?utf-8?B?dkg3RnYxUEwzV1piZVdjYTZHWGdjTVZLRXdORjlRL2FXN3FLQ2pmSVR1M0dM?=
 =?utf-8?B?VmFnU3JUTUtkK3Bsb3dSdmU2VTluNVA3bFlHdk1Kd3RXdy9zLys3NlB4NnRr?=
 =?utf-8?B?TVJ4Slc2UWZjZGNTdUFKNUpWcDdaZk5BZSswaDJGUndseW15OHZwUDBuYXNI?=
 =?utf-8?B?Z1FXZFZRVE1qaE9jWjFWZVpXeG5CWk54dy83dTR3U2xoVVI3QU1nOGx5RXlD?=
 =?utf-8?B?amcxZFZUZFFkZnZsK3d5cnRneStHZWV0VnBjUWIzV3VFajZCemdvSUY5VDhW?=
 =?utf-8?B?UmRFamRTb0ltaVR0MXpDN3B6eTMrWlhXSzlrc1hneHpHVkk1QTkwWWltdHF1?=
 =?utf-8?B?RWNyWTlHSXFVNVoxbEdITDNmOTVibjcyempzZUFaTlEyZTFpMHpEMGlxMldj?=
 =?utf-8?Q?RoDjeHkYszW+P6CXTaXu4GQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <027E7FF302A2014587DD9B7E3574336A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228aee1e-6642-4cd7-55a9-08dc74aea311
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:18.6201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqfHC1RYqpbUUd26gedr4tQu2NA6boQ0phVdWRLyszkjIy6u4ZkeWU8tLPIhHxFexnbzTEWXjO0gZ42aHVA8nLCzzl1ljkRxZBb2eEIUHyiZSsED3Q29harotXQxNRgK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

VGhpcyB3aWxsIGJlIHVzZWZ1bCBmb3IgZGV2aWNlcyB0aGF0IHN1cHBvcnQgQVRTDQoNClNpZ25l
ZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5oIHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvbWVtb3J5
LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCmluZGV4IDJjMGU5NjRjMDcuLjE5OGI3MWU5YWYg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCisrKyBiL2luY2x1ZGUvZXhlYy9t
ZW1vcnkuaA0KQEAgLTE0NSw2ICsxNDUsNyBAQCBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7DQogICAg
IGh3YWRkciAgICAgICAgICAgdHJhbnNsYXRlZF9hZGRyOw0KICAgICBod2FkZHIgICAgICAgICAg
IGFkZHJfbWFzazsgIC8qIDB4ZmZmID0gNGsgdHJhbnNsYXRpb24gKi8NCiAgICAgSU9NTVVBY2Nl
c3NGbGFncyBwZXJtOw0KKyAgICB1aW50MzJfdCAgICAgICAgIHBhc2lkOw0KIH07DQogDQogLyoN
Ci0tIA0KMi40NC4wDQo=

