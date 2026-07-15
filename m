Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C60C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk0xQ-0005Aa-4H; Wed, 15 Jul 2026 10:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wk0xP-0005AN-3l
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:51:31 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wk0xN-0004eD-J1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:51:30 -0400
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 66FE2cGP1251120; Wed, 15 Jul 2026 15:51:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 apr2026.eng; bh=jFtTgYB3mp2qOhcik12ibB0fxFrioVXZsMkw1OxHQj0=; b=
 QiWQ3K6m3LNd77CKmxkPMJMfRq7wVEFSqwry+eCwD4YsOwA4YR5GILGlsR0yFp8e
 BhK7FdXJPtG+IXuTnzap65Wk88NV1I5XLzzMnzpCwOpczh80AF+WnfdH9+G0e4gm
 TzSzH3wdLN0hnH3Bivtiwo7rjReoQcARmaZ926yOlkJTDXWTgDgdY8tne0nZQjmH
 QYV0TbDYQqAJ/BjKhCOFZzSajiluTFRtf7nXNkhLNrzjfJMaFrabmRq0kkc3CMN1
 sOesC3kevFxf3+uJ5guckmp8I30ngr9CdMtVGcTB1ouc5hFWxmbEWDW+qEsOvVds
 ih9EtTHiu8Jg2zO0qaFmtg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4fbefdcdv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:51:26 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 66FEgB3f005092; Wed, 15 Jul 2026 10:51:26 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4fbh5wepvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 10:51:26 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:51:25 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 09:51:25 -0500
Received: from DM2PR0701CU001.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 09:51:25 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SJ0PR17MB4430.namprd17.prod.outlook.com (2603:10b6:a03:298::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 14:51:23 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%6]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 14:51:23 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
CC: "armbru@redhat.com" <armbru@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "mark.caveayland@nutanix.com" <mark.caveayland@nutanix.com>, Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH v19 12/15] net/tap: disable read polling for stopped VM
Thread-Topic: [PATCH v19 12/15] net/tap: disable read polling for stopped VM
Thread-Index: AQHdE6etjIv22AoihE6o2XyiKBqhRrZuaHGA
Date: Wed, 15 Jul 2026 14:51:23 +0000
Message-ID: <E62E987C-8A7C-4E76-ABC2-7816B3955B96@akamai.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-13-vsementsov@yandex-team.ru>
In-Reply-To: <20260714154246.1242856-13-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.110.26062818
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SJ0PR17MB4430:EE_
x-ms-office365-filtering-correlation-id: f38d9250-80f8-4338-9632-08dee2808a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|7416014|366016|10067099003|22082099003|18002099003|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info: 8WwYf2zk+tpKuhaxKTt3MZmKU7eTylfP2db/IzxzzZtBY4oQx0R2zWgiWzOlg/mKATEsFm9bsAUSD35/Hpse4i1Bg95LVYqZQEEzKaoeNoz5gvNye35iP96e7Z9uugcLfnCWCyEdx/jGovVoGGSSETBIv6tg1pjSHN7bA41mqMvgnV9DqQMw5HjZpG1c0k6CLBLizfz1VyKToNorFk/PRCXHgjZ26nr4xCshK2oBuptok5UGmuwdQw3s7GWI0T/khIKu+2XadqLsMD3ItLP55jQC+/g8/al2k/+zE4C7UNjzfVxSGMqtvbDxlE5qmbpHQ64aKUH82ET7F9O69NkSQBKnDPWMaJo3LfOADXq0UOM/lobwT4+SwOfF468hYGO+PpkQrRpHFPpdwSXuEjESY3I8EiBzRCu/1ZWmgb/ieuuKqTfhppkCDc+N4nalMaEK3Aee7LXGkD+t5R/2pd/oc+FcqT9Tah9a6IUipxkys/1BZf1zDO5ps8JQI388J9LuiYG3P9XVYJEXdGzRzE0/Cc5If8Jw4C5+aJfCS1b3voLRdJky1Kj+CQJTmmKKW96Nxdf0fG1nBB+Kjv8Dcf63DAPD1k7uieej45y0nGTA2fd8xArT+aTHfsnCDgodnswbUNVvM3KEIAQM2ouhThupJkzVL8ZFp7kI0pzqq9VK7VxjsMal4FERLWBTToZYVhHRAWLITTgln+z0lHSNpSoDBrZ/onrYeHmMeDm9xsdLUmY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(7416014)(366016)(10067099003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3JZN20wSkx5YmNEZFJJblFRWEhnTG5hTzcrVmg5YUpZeE1sTXRINEx6WGh4?=
 =?utf-8?B?eHozQ0MyWVdGNEhCUktXRDk0bFJXbjJMVlg5VDNNTW83YTh6VjN5VGVrSFFT?=
 =?utf-8?B?enFhTEJyVDlXSVc2d25QY3RtbmVkQ3NSZFgvK05jaXQ3QlRBRlFOb3YzNzZI?=
 =?utf-8?B?cjJDSkJMNWoyM3p2UitnZndSUm14cXFwSndCeUNBK3FHVi9IMnEvYldKNEdv?=
 =?utf-8?B?aVdjU05rUk5URFNWLzdueExYckowbHJLU2lWcnVHeHRCWm5NMlhNS29qRHR3?=
 =?utf-8?B?RG9qN1dLTmlPejBVQXNoWWM3bUV3WjFiS0RBNi9PKzFBUXl2SlhsNktsSUdE?=
 =?utf-8?B?TWtFdDBvTldJSGh5eEMxcmxKVmlCSC9qK3Y0UU5LSy8rcTFQdWVxczE3b0Rk?=
 =?utf-8?B?SjNYcUhQeEp4MUsvR2NtYTJPMldQbWE5SmFpdjRMMVVRbks0Ylp2Znh1NS9Y?=
 =?utf-8?B?RXhyOE15NHErdWZSZXFUTDNRa3lpb3lyZ3pYTnVFS3pWMXc5bzVjWEFRUk9u?=
 =?utf-8?B?azBYUzRLUjFQcW5Hcm95QjRPSTZPY3htWWdnWkJ3N2M0ZldtTnM5TGxOZ1A4?=
 =?utf-8?B?b0JpUVB4b0dEMnpmbkk5eTEwN0dtQTJ2ZVRvQWhsaldTN25La0VubWgvVTBI?=
 =?utf-8?B?bkNmOGxyY0FSUnlPZ0dOL1ByRERlc050VU5VZ0M5NUxnY3ZmWE9uaFRSOW5u?=
 =?utf-8?B?blI1dVhIbDBEZllscWlQc29BM3hPQ1RrNExVYThGNkxPMldxR25BZUJxeTI2?=
 =?utf-8?B?aCs3S1drZVpuWHo4MklWRzVmblA0ZzJtTkV1N1hickpVbjhBcTZSVVVWMVpj?=
 =?utf-8?B?ckFmdmt4OCt0WUk2dlNudU1JYitneUtROTRDMTYzK3JCd3VhcjM5QUh2RU1v?=
 =?utf-8?B?aEJMenlkRzYxY2ZlMTZmNTJkaXV1WGdualJsbk9TZzhEK1dpekdBWEtsLy9p?=
 =?utf-8?B?bXN5b1FFVjQrQjFJVDlhT2hkOUVaMTdGQWtIY3gxNEx2ZWw5ZEwrN1diWU8z?=
 =?utf-8?B?Y3Erc0kvRy9yemxkY2ZMQTd6RUVmelo0WVdLL2Flc2FMcktwNGIycEtOblJj?=
 =?utf-8?B?anpSQWUrSzZqMWhkeUpQb1pDNHdQMGtOM3FoQzFEaFJWa3Z6dkhkY2I2NGRp?=
 =?utf-8?B?U3YrNzdibExwVlRLd2NUcWE2eWNGZTc2b3NObEl6eUx0a29mU2g3ZmFuOWlr?=
 =?utf-8?B?Z0Nna3JkUUVRUnNPNXhRNXVpTUJ1QittOXRUNW51TUlSMUhPVlQrMlJObFUy?=
 =?utf-8?B?M1d4RGxibmxtS1hhd1BrMVRjZ2xjeDRYUlJaTWZLNzZnUnFRcHFKeGZzMDZj?=
 =?utf-8?B?ajNiUHpEOGJzSHFZQjExUENDT09uKzZxVGE2ejZHa1NHS3BHQ2F0TXBhRHBI?=
 =?utf-8?B?cSt2S0czWWFyYkJ6ZFo0TDgrbzcwMVBxY0lyb2Y0c1lLb0RiUWZ3dUpzZSt3?=
 =?utf-8?B?V0E0emEzSVgvdHhqNDV6STg0S1IyZURKS0xkV01xQ3pPS1huaS85V05pSXR2?=
 =?utf-8?B?bTk2U0paRDJBaGhRSTZSTWs1ZTQ2bjY4MEFTRVk1UnJpMWVXZlRETHJNNnR1?=
 =?utf-8?B?NmdxUHFLajEvWEw2U1Jubi85S3NBZUZhSW9TY1VURWNzNEQwYU9JSHVXYXR4?=
 =?utf-8?B?NU9iVG9sMkdzY0I1Rm1PUmZ2M0haMXVXeVBPS3NGZXhzSENyTVFRb3FWSmNz?=
 =?utf-8?B?ZFpkMXpFbGNUQzB1TGthVkx5dzRGV3JUQWM5Y2FxR3FmTGduaGZvcXF6M0dP?=
 =?utf-8?B?aTJ4MlhzVm9oWmoxazBFYVBwZFJNdHpUa0RBbUU0a2xWNGxRUWZqTWtLZUdh?=
 =?utf-8?B?QmxkL29wUnpJSWlaSTk0eHBxVXR2eEVlblVzT2ZZMmkwMGsyTVM3OUd0TjRL?=
 =?utf-8?B?VlRxV1BKK1YvVTR4ZWsrWkM0Mlk2REk2ekJpMDNoTGVFUWIwbzlIWGdPNDJj?=
 =?utf-8?B?K3RRa2Jyb3JzbUZQcnoycVpHblo1dXRnWHVTZDVvVlMwR1p2U1NxK0ZNK0xD?=
 =?utf-8?B?eWFFOVZubFY2VVdXbHhVdmxjZUVJcXVka0dUQW5WU08wQWNMVDkvUTVCaHU2?=
 =?utf-8?B?cll5dnR3REVaUS9oZnp6K0JhMlQwaUpzVnl2S21pMjE4Mk8vZ1djdmFmclli?=
 =?utf-8?B?WmFWSGZVYkdKbExjL0hBbXpUSmE5UVZ5Q1RPWGZXTDY5R1JyUkZHeXZkY3kz?=
 =?utf-8?B?a1ZmY0l6a1BpN0txM0dBdDN3ZFN4TFJJaFBQZjN2aTFtMWxtS1RZRG5LVXFk?=
 =?utf-8?B?MzMvSW90dTNMZ2Q4anV5WXA3aXRUakdIQVRiWFNoTDlzYWFKZXBENkNBbG55?=
 =?utf-8?B?Y3liSVZvZmxFK3BzMitCU0IyRFlSSDJ0a3Jhcm9TVFcyNDhGUUlHWWRDbktt?=
 =?utf-8?Q?KbfThrV+XrL3BV1bkseTHx8KudofMbSwYi2UP+cyb7rom?=
x-ms-exchange-antispam-messagedata-1: bqEjXqQswhV7ww==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJYCuNoYQ2S+7NohntIqngRWZomMq0/MFxqUj2PPZjsVLJAlgpUN2t1IszJUJZC+pn+zuCd5lVbnwC4H37TzPIqTLitiSNCzH/7aBj5ih9PUyFwYIfEBSFNv8Vs/lDUD0IbnGtcSaKt2/6f/E51bOp6IPiCi7HIXyZyrpjU66E/7yKg3CXMgXiw0Q5FGHqAUEXayqn9jnefGveSnNX+X+XVlOJlCtUFPeha2FKsHtzFJEQGVFe/2Mzhf/M5qNfHpBepWEQqZPRGZtfLTgSBOafU5XeMY21VUM/J5t+q4eBaxFb08TnXsjEcAhnEkGUKx9s972LUkDAtgU5kfUnT7cw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54Sti/jvll5akqL12A6Rn1o7F34q0AHJamwNqcoSZCM=;
 b=SsCmLkx4hoXWGPQ2EWFXhBa+xCJm1isUlXOf68i7P/lGHfLHq1rGPmQ9YCUJKRvVY38NWs3B8dxhb+ut5jP2qwfQrLVHjha7C+tYMdNSe9YHP9TcbWAe5UaM6c/aNRPqn1LEa3P1qPvA4Kfiodm4PA9Nep+QiZmv4ojIhP8G+g/QjVdUsxmRLhVY5muafQE3FGFoffzgSW3jB9l04S4V1ZBWRkGHR2So2ULKJxO4kLgtqnZ7ym1QxXxtrqz8tMhovgvQXW+n/92MKkLuMY+E4TRkj5WINWVZMbkfKG1slWCqmHRO7KUBR3HgMAtPMX7TB21+UuWPOOzXPckUIttkmw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: Yi3+Ruqpah3QJYyOUsEPmY3+92iSLtaT5IDwmN90zt5t117cEWOIDENlX2A05Q3SxcuzjnRniKlgJ4TGM3eIee9fg9Fam9yP/i/7KXAFyZs2PzXElVy/9c8Ri+Id8GMwHPAtzHmRlFhisBTLMizO3VDh3MVWdx9QBCKCNuX5FmePYOmpRwWbf2lKwSiUJxcViizt6LaOVqx+YuFkrFGImur3WC4pbQGkHaEdAjW8TlLEE9hxmpU0Y/kJSZUg0jJmSI1AbGiRXOdVxQTVkCuc6PsV9wVFSKyiaSBFMJGpfjhaUM7mb4V+1W3UwWalHcoCAoyBkL1UR7JvsZ8rdRAanQ==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f38d9250-80f8-4338-9632-08dee2808a24
x-ms-exchange-crosstenant-originalarrivaltime: 15 Jul 2026 14:51:23.4069 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: BprJ6MVPC377TuvB3LBsz1tJ39LgK2ybF6X7oeauMgylXmIDlzBT0wscdurd0EQyo0p7pGszWWWWPa+uXTTW2g==
x-ms-exchange-transport-crosstenantheadersstamped: SJ0PR17MB4430
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DA8E89C3EFB314EAB508C12BEBC6A81@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607150146
X-Proofpoint-ORIG-GUID: MUF9RAth_2bfYDE4HW-F4ws2L4mAcfyU
X-Authority-Analysis: v=2.4 cv=ZYQt8MVA c=1 sm=1 tr=0 ts=6a579e6e cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=8P__5Em-pwOPtXrf4HJ0:22 a=6R7veym_AAAA:8 a=Ahg7Adxr2oxqvWAHv4IA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: MUF9RAth_2bfYDE4HW-F4ws2L4mAcfyU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0OCBTYWx0ZWRfX7vjwHR4uTe2o
 Gv3s/HgLlJ7yaEKwYOU7UWcWZJKE5KBwh4SMtKzupRZ6gWSM9jNIuK5R/DB2aV7cgpom3nF3z4u
 o6H3EW8Sv6qcC+Jtl7Z1/avpHZTumB+GfkawAvlsejJYZDlgWZuG7jY3syVSp7wrmRiSQu1sk4j
 Ld/onhJ+0hptMizDbHMBXnp9Z7r6GwqpWfn7+secvRf5meneqUI3yOFlGIToCK02STVJtSbfnnc
 g65HW9bEgG+XGJHIIFzjNjXBs2+9zVsW/rIJ7TYL2Bj2erV3FSjtowlNh5+u+zfg13kHbOJVSoU
 4EuL3E+34ZiSbkcpeROZP2/9P/icuhGQJWNjQJKtvmy5FLkmQTbYxNhPuJrRsotn4ogMrx5Btzy
 9/No5bFLnlNdq9WvU8hKlkYgWkTtMZw8iydKkvCiOwn+GSFS0QFjNO7tQim7BZJU5roi7X2/KLI
 CnJAiy9UiFQO8dnAOoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0OCBTYWx0ZWRfX7FAfHIIfissv
 hFOi2Esjxy7gVmaBP1YPda8EvmOulEC13SeMdC5fuRdg8qQ3e4To/mgZvcKxitRFlvED1HGnv19
 qCh7pQPPB1GHM/Bi0Mw/idnFPjMy33o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2607150148
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQrvu79PbiA3LzE0LzI2LCAxMTo0NCBBTSwgIlZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXki
IDx2c2VtZW50c292QHlhbmRleC10ZWFtLnJ1IDxtYWlsdG86dnNlbWVudHNvdkB5YW5kZXgtdGVh
bS5ydT4+IHdyb3RlOg0KDQoNCj4gK3N0YXRpYyB2b2lkIHRhcF92bV9zdGF0ZV9jaGFuZ2Uodm9p
ZCAqb3BhcXVlLCBib29sIHJ1bm5pbmcsIFJ1blN0YXRlIHN0YXRlKQ0KPiArew0KPiArIFRBUFN0
YXRlICpzID0gb3BhcXVlOw0KPiArDQo+ICsgaWYgKHJ1bm5pbmcpIHsNCj4gKyBpZiAocy0+cmVh
ZF9wb2xsX2RldGFjaGVkKSB7DQo+ICsgdGFwX3JlYWRfcG9sbChzLCB0cnVlKTsNCj4gKyBzLT5y
ZWFkX3BvbGxfZGV0YWNoZWQgPSBmYWxzZTsNCj4gKyB9DQo+ICsgfSBlbHNlIGlmIChzdGF0ZSA9
PSBSVU5fU1RBVEVfRklOSVNIX01JR1JBVEUpIHsNCj4gKyBpZiAocy0+cmVhZF9wb2xsKSB7DQo+
ICsgcy0+cmVhZF9wb2xsX2RldGFjaGVkID0gdHJ1ZTsNCj4gKyB0YXBfcmVhZF9wb2xsKHMsIGZh
bHNlKTsNCj4gKyB9DQo+ICsgfQ0KPiArfQ0KPiArDQoNCnRhcF9yZWFkX3BvbGwgaXMgY2FsbGVk
IGluIGEgZmV3IG90aGVyIHBsYWNlcy4gSXMgaXQgbmVjZXNzYXJ5IHRvIHVwZGF0ZSByZWFkX3Bv
bGxfZGV0YWNoZWQgdGhlcmUgYXMgd2VsbD8NCg0KSSdtIG5vdCBzdXJlIHRoYXQgaXQgaXMsIEkn
bSB0cnlpbmcgdG8gd3JhcCBteSBoZWFkIGFyb3VuZCBhbnkgcG9zc2libGUgb3JkZXJpbmcgaXNz
dWVzIGFuZCBpdCBpc24ndCBvYnZpb3VzIHRvIG1lIG9uZSB3YXkgb3IgdGhlIG90aGVyLg0KDQpU
aGFua3MsDQogICAgICAgIEJlbg0KDQo=

