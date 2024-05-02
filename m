Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AB8C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNs-000432-FW; Thu, 02 May 2024 11:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNj-0003vv-Bh
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:30:00 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNh-0005ys-6J
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663797; x=1746199797;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HqPBv4MByZu0WvDVOh1KhT9RsB1lIMuoLhy+mBu7tCY=;
 b=jSdHWi3m3X4vLq3ucmyZag02HT0STfwBAGiEerPfNavJQJLk/+ivmcUV
 lAG7EaoUB0N16wBuuQ9dcXsevNoP3ghYOXrs2EkNoNRoYYQIh5uP76LZJ
 8Yab/6lY+/QSWmzXw/anLEPPxy8vgVkIZsjr6/OmhdoHPgUg9MUmqW0YR
 eDG7Firj32aQnxylYrMKbRF7bcnHW237h4+JnV5vM+u7Uw3rdOFnBk9cQ
 0z43mqJQ5Dqy/iBW38F3OME8K3MxMTbaFMQfUdRBAD7ME7vBEgYNoI27F
 reZrfoXJXMxEXF4KlsDC1Xb1LE8KXkDAicI3Tm6ulSevgOez5hpWMPQQX A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785885"
X-MGA-submission: =?us-ascii?q?MDH8ClsssreG0UR25H0CWpte79oVApOYudlbCZ?=
 =?us-ascii?q?O/y9Opi4QbVi968rzfgXcR7CfWQ+aAG4CUsbzNorls9nt/BW1Nb9O0wF?=
 =?us-ascii?q?RKsG6ckqPn4nNjB+uksuB09ZkWOrkLQogoGVt1KDNKbcKicXbTsS5ng9?=
 =?us-ascii?q?wsUDU9/+rye2fWZLefiZyMxA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+IE+9TNGsoCYK5+KLDNYFbzIzHmwHitcf5yJsF430NgOhbIDikvYf2An6NAfaLReKfOSRFOVk/kVWbNxXHOKoFv2Rhre6kkgVxhuE+V4kA9og6xwhssnQhapsT9EOpU2gHXBUrBD/lN5sMZVYBLn/b53JhN/NUuYaGepKwVRnnmP5S2YQ+Kj/rue2uXFPz1wdcQUzzRAfmqqqN0/eCgbUISl4yea2GNYaUTuCttSimheq89+3UVCPYkbiq7QrqQZtaVEtBgxoVXaHYa2ZUo8vhsiC0/5Ji5jt2X01UKWXk2dkXugfdlr5ZbtjgWDZsh+hZR2rceKN9PuHUATwptPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqPBv4MByZu0WvDVOh1KhT9RsB1lIMuoLhy+mBu7tCY=;
 b=I6zmWww2imCwV/APp2H2NcggPdb/57BUwcrdKSojwai5AthCjU51AQedNZ1+1ZLXAiTEf/2Fy6oAuJLDfpl9qdk5Q7Lc7zHnF7Yy6n/uJeBIZiXTQwgQiNt8TaE4iPKQnxAU8VvhzgsDqlhMg85jeznFvvHck197COIVOnYoT35GbO0nacALVV9zTawpNNIBApUi96GedL98/vNc2Iwzdkr4GxXf6CSKygrezfkfm6sYpBQ87D7RhsTpQ+ncznNSWA8+3Ekx+sBzKhMxN7PiuNUehhtnZ2dY7pRv/OoYTpeya0T/0uwruUtWVh0ahCE7y/8fGNZ6kP3pH20wc/OaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 11/24] intel_iommu: add an internal API to find an
 address space with PASID
Thread-Topic: [PATCH ats_vtd v1 11/24] intel_iommu: add an internal API to
 find an address space with PASID
Thread-Index: AQHanKV/Ps259jorIE2wmk52NNnsNQ==
Date: Thu, 2 May 2024 15:29:19 +0000
Message-ID: <20240502152810.187492-12-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: 8bdee101-becf-4a08-388d-08dc6abca285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RVV0L3BaTDVseEp5a0htcHlQbnNpYUp4VFd4QVp3azdGOTJpbVJKaEFVL1dP?=
 =?utf-8?B?SVdsZURyWGtqNnZER3RKYmZzQXdEUysyK0E3cDNWU3hQVm5Fd2ZBcHR3VG5L?=
 =?utf-8?B?eXV2Vk1aVWVTRFBna1JGb2pXN1hiY1R2NHlXVU1LOGdLSy93WlAwSUhnSmxV?=
 =?utf-8?B?dHFBWUs0YStubm5mSEhjNnJUMEExdEZYQXB6ODNwZEM3TW5GazB6T3UrcWgz?=
 =?utf-8?B?WURHT2xzOWNUSU1SUTBvV3hINTN5RVkzb2l2R25zWjdMdnpQNk1kdEpRekxy?=
 =?utf-8?B?cXZPdi9KT2dZVWw4S0l3ZUk5VEFFVzdqTmhLMU8yUnUxOHpndjRKTlpzdytF?=
 =?utf-8?B?NTNzSlRQVjVhbEUzQi9wTHJiZlcrOVpZRm1LN1pid1FpdGJrUTVMaDh4NVZv?=
 =?utf-8?B?VC9GRXJsQ0tPTWwvN1BUU0R6NUF6T3NtM3lkYXpxWkxMYi9SL1o4aWQrYWFW?=
 =?utf-8?B?S3o2VlRNcUVzNTR6c1lnVXU5V1FLZHowZVRiN1Q0eVRxWEF5S25rSk56cEph?=
 =?utf-8?B?MzRMaTFjVXFybzF3Rit2a3pITUpEaXBsNXo5MHZUR3V2YUJHdnRTY3NDK3Nq?=
 =?utf-8?B?U1VJb2F1L1Z0WEdkY1pEWW0vTkUrK2FkdmdqZVNaTkNTVTVsVW00MUFZc2JH?=
 =?utf-8?B?a3Vaek0xUDUyWGlKL3RGeWI2blIyU3NxVS9PZlRpNWxPZ1ZDVEhJd2RVR29P?=
 =?utf-8?B?cTc3NS9aNUxDZklYeDcwV1R0TVliSm5mUGthbCtBZlJhWEdzT1lxVDZuUGFp?=
 =?utf-8?B?U2xzNHJkeGg5bmtFNER4ZjRWcUdBQVJQYlB0ZmdBT0JLOW1XM1RKY3Jxdzlm?=
 =?utf-8?B?L1l2eEFhZTlpSE9JRlAwcFdKQW1LcUdiNlBYMEpoUytpWm5UVEFrbTRDQTVL?=
 =?utf-8?B?cFlUTlBkdkViR1h1czg0K1BGZWRGejdXcHpiNVE1bCswaEovVU0vaTNnN0Jy?=
 =?utf-8?B?dEtQMlQ5STJxcFFlRDFEc05CcURGTUk5MnhlN3VqUU5qdDVXeGpERFJXQXhX?=
 =?utf-8?B?Q3hjNFpQbFVjRVNnZkd3RVFMRk4zaVhZZVIySThzQXdyWW9EYU5uVVRHOU8x?=
 =?utf-8?B?WEZKVnRlUzN4Q25BUjR0VFFjN2NkbTNwcmxtWlplRFgzSGREZGprbGg0YzdJ?=
 =?utf-8?B?UHBsSUVxVFQ4N1lUcHF2N2R6eGpWb09Ld2ExMmpiRjkyaWVLNzMxOU1GeFlW?=
 =?utf-8?B?SjZTMnd3bzVjRUxhSk10a3NEbGFJNTl2MVNJMmswdkt0RTI5SXdYaGhpNGRC?=
 =?utf-8?B?a1R5b0U0aWd6RVppV1BzZ3p0RHg0bzI5SHFHNXBUbDRmWjdCbi9vU05NdHlp?=
 =?utf-8?B?Rk13d0NwYWlTaDdnSjdqRXU4OWRCVXR1Y2Y1d0ZCM3l5akNka2p3Z3lzNGsz?=
 =?utf-8?B?aWVza1ZqemtmSDZKb3RUT28yL1lDbm15dFFWMVlHSzlHQUdJUXFxK1ZCekhl?=
 =?utf-8?B?MlVDWTlhWlFlWEhHbXQ2b2VlTDIxaHJwK29leE9ldHBjc2hrZlFrUTc5am0w?=
 =?utf-8?B?YndkUXpHQTNocXJCK0Y2elVqb1JOdnV6QkNLSytjRUQ5cW1pQWVtVTQ1TFRm?=
 =?utf-8?B?U28vcE1wUVVHR1ZGSDF1aDljL1NuZ1dFY3B0c3phR3VxdGRFNFVWNktVSjFq?=
 =?utf-8?B?bEl4SXd6eEZnbFlmVnEweVpzT0ZUVXFSKzlyUTJIb2swZW1XSk5KalpCS0ps?=
 =?utf-8?B?M081T29XbzArSGFJNGpXYjJCd2hFVGx4YkE2Y1IxM0xRVENwUUluUUpYeS8z?=
 =?utf-8?B?cmE3aWs0WHFWa1FwR1U4V0hKM1JVVklCZnphWkg2S05UcTh4L2xXRU96amVa?=
 =?utf-8?B?VXhTQVppN1FLZ2t1aEo2QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHk2dHJNSjkvakdZMXFpWlFXOUFLL3ROVW9GSmVEYTNWTTVJc2p0a3pwNjdu?=
 =?utf-8?B?ZGdJSUtsTXI2cmxNcFkzeUxRS2VKQVB0ak4xdXdMYXJNcWhDeElURE84V2xs?=
 =?utf-8?B?bTkraTNEb0t6SStrZ1ErdUkyTWdvSFZ4VHJrNEZLVVRlbU52UEtmalFTK0hV?=
 =?utf-8?B?Q0c3eWpmZklQVmo0UlN4S0RxNVU1UHF5M0VyVjFVK2pHSnNhejdQZk1LRS9m?=
 =?utf-8?B?UWhhZUhRNkZEemtneEV5dk5tQlk2VWJ6c1JjR1VoV1JTVmhSSFd4Sk54N3B5?=
 =?utf-8?B?M2RrQ3o4aGdETFRqREdLZHdLUHdQeHY3R0lqNHhwdDB6a1ZQWTB0M1RGOG4z?=
 =?utf-8?B?TmM3L3Q1M0xiem0yYjRNNmRiTmdBZkp0WmZabVJRdmlEMjNwQWQrUlBYRytU?=
 =?utf-8?B?QmQwcFlnZ05lTVh4OGZDR216SHpuY0FKb2J4aDdJUWFUZlBublBua3lnSUNN?=
 =?utf-8?B?eEJlaEZoZUNsSjlsZUVaZ2RnRDlPUmt0R1hCejZESzV1UVlTUHo3RHVWejJZ?=
 =?utf-8?B?NDRUcG13VmZOclFJOXJjRzBoektkMmppNncrTmxsOGdVV1pyVDIwczhqUUFw?=
 =?utf-8?B?Z1F4eW0wU1hVY0VQRHduZG9BVE1IWnFaZjRldjNkVGVxYTFlTkNVc090YlZL?=
 =?utf-8?B?WHdTdlEycHY1cnJ1ak9YTmUraStLdGJPWmlOcnM4OWxYek5zYjB0Z3lJajRQ?=
 =?utf-8?B?MXpmS082MTZsTXA3WEFUUmsrQmU4TTJHejJZeTU2NENENEpUYjVBUSs1TTVL?=
 =?utf-8?B?RjZKS0V0NWZ6Ymk3OGw0SXVRMlBqaG05d2kyTUJsalZPRlRrcUw0SC9CV0tw?=
 =?utf-8?B?NmNnWE50M3BwYmsyYklycGM0QzRaa3V2akV5VlB4TzZ0OHhkRUdnMXRBRmVo?=
 =?utf-8?B?QnNJK3QzTmttajBUR29CTVA3RWlSTUx4UTlMblBsclM5QjhGYW5zdXpXc21Q?=
 =?utf-8?B?Qm9jWXJ5ckExaGE1QzhVZWJCaS9DalFzM0VoYkFNd2FyeXpLYnMzZWFqSkVy?=
 =?utf-8?B?Z2tsaDNGZG5jTjFCeGRaKzhEQTBWRkN2bW14ODdTS2tRY1h4dExydTJObzlO?=
 =?utf-8?B?ejlHZVdDSEdTd1JnVVVtZDB5Mm55dVVhaU9uaGVwaDlpUm1GL1RYWm4vd2x3?=
 =?utf-8?B?dmUyMUNISk9VaUVpNXNwd0htYk1MNkc5dUdGckpwaGt1MVF6Ni92UzJjSHI5?=
 =?utf-8?B?VjdkMjU1bzVZL3g3dXJ4QXFRME9iOTZncmNuNXRhTmVHYXJ6UHVLM21yV3kw?=
 =?utf-8?B?dGhxZUpkVjJtR1pKS0NxV3lTd05hNnFmLzljQUlrUHhJYVRucGsvaEVWSjBW?=
 =?utf-8?B?cFJZdDQ5MjliS0ZPVXBPTmdXM1lIUGg5Q0xoZXNjcHVjeEs1QTlWNUtUNVdG?=
 =?utf-8?B?VmpMMXJFNm13ajJveXJNeE42aURkUXhjVXNwSEFJS0NaTno2dXNrNzA3MGRJ?=
 =?utf-8?B?ZTU4NkRPbmg1WVhFa0NSREpidHhOODdTTFdZTlZnTXVKbVkxMzhiYk4rTUVk?=
 =?utf-8?B?cTVtWjJVMUd4cFFyNnc2VlptN3ZNUk5oWTRIUlZYZjlzTmo2NElyalFOMThG?=
 =?utf-8?B?OXZ6UGhwVHRlVE9PakVCdkc1RGJMVHFRUFZhQXVaMEErc1NweW9wVjJvbGs1?=
 =?utf-8?B?RnNYVzFpK0Rrc0tPVTdZYXZxVFRic1prZ21VdHUvSlprWHVpcUYwcWVaWStC?=
 =?utf-8?B?UDVMTXo3NWlObGxZdnBFQnhQK1VBc2ZQcURrcVYrZ2k3c2k3Vm9WblgvODhT?=
 =?utf-8?B?YzhFTW5nbDdZQ1ZmdkY5Umg2eVVvMWJOY2xxK1BYZTU0Z1FjWXRtV3JSaWZh?=
 =?utf-8?B?NXpGamlCTXVmSWtGSlJzNEZTOWJsb3NCM25Ja2VhSkRwZ2o3Q1Y1bUNlT1oy?=
 =?utf-8?B?VEpMcU1scllrMmZ5cnc1ZmNPWEIrS2hpdmRZeTdpWHgzQWYzR0Y2MWR3eHR6?=
 =?utf-8?B?RlFxMHFpRjlpQmVvU1lNYU1Hbk9oM2w5UkZGdlVvNG9NWERYR3ZLQnl0MkZO?=
 =?utf-8?B?OHJxYVF0MG1RK0hKd29UcXZWZktKYjZiRlRlcGZzQ01QRG03Y2pVU08ySy9u?=
 =?utf-8?B?dlNXNkQwZTkyYUV2RW40UjRFa2d3TDJqdW9KdTdHTWlmK2swRUUwdjUzZy9D?=
 =?utf-8?B?cmMrYUJxTXQ5Z1ZIa05ZTUY2c1JsRnkzYmUwY0xSY3o1dEZvdXFObjc0enha?=
 =?utf-8?Q?cgeyISxk0Bi8bri+0VDZuCE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CDCFE5E0FFC314BB30D213F84C6F7B2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdee101-becf-4a08-388d-08dc6abca285
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:19.2063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JnPc2ibXG8cOiI2nG5jVrIYTWZE+CIKUuP7vW3uczk94QmJ4GlRIQqJl1PtT712f06lZ/cepAHyOdY1tDPoigcMz896+JdiRqQudj++1zCMKmqat3uYE3BIr4DHvI38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

VGhpcyB3aWxsIGJlIHVzZWQgdG8gaW1wbGVtZW50IHRoZSBkZXZpY2UgSU9UTEIgaW52YWxpZGF0
aW9uDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0
aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMzkg
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCA5OGM0YTcwZmUw
Li5mZTk3OTMwNzc0IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC02NSw2ICs2NSwxMSBAQCBzdHJ1Y3QgdnRkX2FzX2tl
eSB7DQogICAgIHVpbnQzMl90IHBhc2lkOw0KIH07DQogDQorc3RydWN0IHZ0ZF9hc19yYXdfa2V5
IHsNCisgICAgdWludDE2X3Qgc2lkOw0KKyAgICB1aW50MzJfdCBwYXNpZDsNCit9Ow0KKw0KIHN0
cnVjdCB2dGRfaW90bGJfa2V5IHsNCiAgICAgdWludDY0X3QgZ2ZuOw0KICAgICB1aW50MzJfdCBw
YXNpZDsNCkBAIC0xOTMxLDI5ICsxOTM2LDMzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfaXNf
aW50ZXJydXB0X2FkZHIoaHdhZGRyIGFkZHIpDQogICAgIHJldHVybiBWVERfSU5URVJSVVBUX0FE
RFJfRklSU1QgPD0gYWRkciAmJiBhZGRyIDw9IFZURF9JTlRFUlJVUFRfQUREUl9MQVNUOw0KIH0N
CiANCi1zdGF0aWMgZ2Jvb2xlYW4gdnRkX2ZpbmRfYXNfYnlfc2lkKGdwb2ludGVyIGtleSwgZ3Bv
aW50ZXIgdmFsdWUsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRl
ciB1c2VyX2RhdGEpDQorc3RhdGljIGdib29sZWFuIHZ0ZF9maW5kX2FzX2J5X3NpZF9hbmRfcGFz
aWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQogew0KICAgICBzdHJ1
Y3QgdnRkX2FzX2tleSAqYXNfa2V5ID0gKHN0cnVjdCB2dGRfYXNfa2V5ICopa2V5Ow0KLSAgICB1
aW50MTZfdCB0YXJnZXRfc2lkID0gKih1aW50MTZfdCAqKXVzZXJfZGF0YTsNCisgICAgc3RydWN0
IHZ0ZF9hc19yYXdfa2V5IHRhcmdldCA9ICooc3RydWN0IHZ0ZF9hc19yYXdfa2V5ICopdXNlcl9k
YXRhOw0KICAgICB1aW50MTZfdCBzaWQgPSBQQ0lfQlVJTERfQkRGKHBjaV9idXNfbnVtKGFzX2tl
eS0+YnVzKSwgYXNfa2V5LT5kZXZmbik7DQotICAgIHJldHVybiBzaWQgPT0gdGFyZ2V0X3NpZDsN
CisNCisgICAgcmV0dXJuIChhc19rZXktPnBhc2lkID09IHRhcmdldC5wYXNpZCkgJiYNCisgICAg
ICAgICAgIChzaWQgPT0gdGFyZ2V0LnNpZCk7DQogfQ0KIA0KLXN0YXRpYyBWVERBZGRyZXNzU3Bh
Y2UgKnZ0ZF9nZXRfYXNfYnlfc2lkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3Qgc2lkKQ0K
K3N0YXRpYyBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9nZXRfYXNfYnlfc2lkX2FuZF9wYXNpZChJbnRl
bElPTU1VU3RhdGUgKnMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQxNl90IHNpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQogew0KLSAgICB1aW50OF90
IGJ1c19udW0gPSBQQ0lfQlVTX05VTShzaWQpOw0KLSAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9h
cyA9IHMtPnZ0ZF9hc19jYWNoZVtidXNfbnVtXTsNCi0NCi0gICAgaWYgKHZ0ZF9hcyAmJg0KLSAg
ICAgICAgKHNpZCA9PSBQQ0lfQlVJTERfQkRGKHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwgdnRk
X2FzLT5kZXZmbikpKSB7DQotICAgICAgICByZXR1cm4gdnRkX2FzOw0KLSAgICB9DQorICAgIHN0
cnVjdCB2dGRfYXNfcmF3X2tleSBrZXkgPSB7DQorICAgICAgICAuc2lkID0gc2lkLA0KKyAgICAg
ICAgLnBhc2lkID0gcGFzaWQNCisgICAgfTsNCiANCi0gICAgdnRkX2FzID0gZ19oYXNoX3RhYmxl
X2ZpbmQocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLCB2dGRfZmluZF9hc19ieV9zaWQsICZzaWQpOw0K
LSAgICBzLT52dGRfYXNfY2FjaGVbYnVzX251bV0gPSB2dGRfYXM7DQorICAgIHJldHVybiBnX2hh
c2hfdGFibGVfZmluZChzLT52dGRfYWRkcmVzc19zcGFjZXMsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2dGRfZmluZF9hc19ieV9zaWRfYW5kX3Bhc2lkLCAma2V5KTsNCit9DQogDQot
ICAgIHJldHVybiB2dGRfYXM7DQorc3RhdGljIFZUREFkZHJlc3NTcGFjZSAqdnRkX2dldF9hc19i
eV9zaWQoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBzaWQpDQorew0KKyAgICByZXR1cm4g
dnRkX2dldF9hc19ieV9zaWRfYW5kX3Bhc2lkKHMsIHNpZCwgUENJX05PX1BBU0lEKTsNCiB9DQog
DQogc3RhdGljIHZvaWQgdnRkX3B0X2VuYWJsZV9mYXN0X3BhdGgoSW50ZWxJT01NVVN0YXRlICpz
LCB1aW50MTZfdCBzb3VyY2VfaWQpDQotLSANCjIuNDQuMA0K

