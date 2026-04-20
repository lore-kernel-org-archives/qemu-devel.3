Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C259F588F7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErbP-0004PB-3I; Mon, 20 Apr 2026 12:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wErbJ-0004IM-Kb
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:36:01 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wErbH-0006xA-Ae
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:35:57 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KGUDsb1227784; Mon, 20 Apr 2026 17:35:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=UZESTaQ5iUP6YLhRoTnXTM9h6E/p7Ry/RLs712kAkl0=; b=
 SoZNuzSGWJ20SZmGD2GazDmg62sAXImhvUPiot1gGkETATkBbIUDgHaqAeTJTKsx
 kRpyOOl9FFYI8ezPH84ocJz8aWC1s2CKmmEF4v7ov2a5XVj8l4LpXP50ZiBJNsju
 1gjL7Cgg0VQr4U1PFLYCV+rcul+yveR1LJmk673ZxkTNxrbh1bUBZKde+g8ztguX
 XcKh+GaEa0lQEjY1o1YzBEWiVPpwkxXHcqXIwrgVmpQ+Se0E0P35fQOic2BSqHMU
 5A5e3azlbPIA9oD8bZyT523MZ9EWy+bzY0OLzS4SfUqhabq2tvxTs62yyZflOH6R
 GJX+3mWGE2xZOQfs2vOs0Q==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4dm174t4y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 17:35:51 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 63KGBedj013017; Mon, 20 Apr 2026 09:35:50 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4dm7x68r8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 09:35:49 -0700 (PDT)
Received: from usma1ex-dag4mb5.msg.corp.akamai.com (172.27.91.24) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 20 Apr 2026 09:35:49 -0700
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb5.msg.corp.akamai.com (172.27.91.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 12:35:49 -0400
Received: from BL2PR08CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft
 SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 12:35:49 -0400
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by DM4PR17MB6320.namprd17.prod.outlook.com (2603:10b6:8:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 16:35:47 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 16:35:47 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v4 00/13] net: refactoring and fixes
Thread-Topic: [PATCH v4 00/13] net: refactoring and fixes
Thread-Index: AQHctsrWNNcTJFuc6ECdXG40dHJ/XbXoTFqA///KfAA=
Date: Mon, 20 Apr 2026 16:35:47 +0000
Message-ID: <4B5C621F-E32C-420F-BCEC-DD9921D1720C@akamai.com>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
 <4515898a-2374-4bf0-b8d3-d6fcf488bb32@yandex-team.ru>
In-Reply-To: <4515898a-2374-4bf0-b8d3-d6fcf488bb32@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26021521
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|DM4PR17MB6320:EE_
x-ms-office365-filtering-correlation-id: 5aa97755-4bf2-41da-c239-08de9efae014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: sbtMhXIxY/VddT0ChBrO5xqsPQPMA3Z2i8oMlqR+zfQp2zw3jyYKveLACDO/zvKNd8Jde9VqAQzXWsl0R13JlrHrDcTnCDGTQGB1XW64tZBKrAnAC/vXv9eW7V3//+IdCuhJLqOGaja5rBMSAu5SkOgrOG1ER7i1CSbwSksHhg6nybfCEQ1SULJ3M6U6AduinySUSkA5+kcHwXbVvfczvlldaSGu6uaTgdCErb3NEEH6Kg2KtTECM+RF7ynpdgVHFyeaxVFp7AQU2w31j+gIXHcERckDEVJtdTqyfVM17kWvRXLwibtAHdRB/uBBXpCVS4r9Cy9Ajnq2L7qkEWjADBUpjkF2Dih58SYbvtaoYMsG3Xqz1n1Ka++LkV5IDg6Nr/Cs+4k9AJzsKwZ6P0DJR9KMnCzXMwUcf6NQpcrLQK2IEZX0HbrGjfY/eITktTiBKdCompSCITFAb4t4w/iBUHgaADQKyCQ1lGP/8dwKDKixfOnGzqXk3tBMaIeF/h1CvUWZU2H65MA/pfZqrKSVPyGHAiC4fppftNt4r0G5EM8MYoMlXvKoXEHahcnRIfMMUPH6sIfZAEMEWvJNKDHJOpOMe+KrFCZDfHVJGPayrMa7MnrzBjCOHI9MK8d32jLaK6cO6uAYciN7MAr5ydcSH0+ty3CKc2GhBD8VQiLFPD7uHA9v9jI1N4OwwpRh4T+GMZjRz2ZSEp//4N/o901RRXKLJ2yBLDJR082XetbSrJ7ek3IjBCELrG1tM2LevABqWZKS6mbxfvryN5enW7tX4V8hFYOngS9vmTWEs+D9gx4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0ZraXdxTk05OTNRUnliMWVSK2c2anNWWmpsNC9XZjZZY2o1Wm43eTFPVDg4?=
 =?utf-8?B?U2h4cEtUVTVvZ2svU0czdUtMbUpBQXpMbXdwRTdPbFZMNk5MdEt2QXhoaFYx?=
 =?utf-8?B?aUc0eW1BU1U2QjkyRHFuc3VwN0hJVHpWaXRNaS9GcTROdm1xODQwYnNWYWFx?=
 =?utf-8?B?Nm80d2hKMk1GZCtSWWRzQkZHMFRGVy9SVEpZaHMrdUFkODRlbzdVVkJBRmFF?=
 =?utf-8?B?VEdYT3pDbHd1TmIrbzd6VEVWeHlHQXRBcTFKQ1Zkck1tdkpLZGdMNTBJM0VX?=
 =?utf-8?B?SHlMbWFjSVVwb0ZWSDV1VHFFdm1EeDlwa2Mxa0tLV295dkh2WStXb3FrOWh4?=
 =?utf-8?B?MlpEV21jVkZMTVlqSkZFV1hMOEdIZHM1NFBFVThKdDVnUGpkbTYzbEVadXJ0?=
 =?utf-8?B?TkxOSGw2KzV6KzQxRTFsdlhGc21vdFc1TzNDYnlweC9VTyt4UmtKRUI1eU9C?=
 =?utf-8?B?RklWSHMrUG5lUytHZFFCTmRXR0JEeDJUR1Z4T21GcWZGd0NwRkpHWU1jR3lh?=
 =?utf-8?B?RmkrdjlTNE9LZTdSSGtvTFB1VEZiNWh1NHRIY3BocU9RdlMyTE45NGVPUTUy?=
 =?utf-8?B?YmpVck5Obk9Ca3k3SnNhZHFKSVRsZVhFZ3JoNUI3MlZudmREWEcwU1pOUFds?=
 =?utf-8?B?Q3VXNnkwV1prRTd6dDBHTUd6cVpOOHFrYzJyYnMyWWM5eDZCeVphUHQ0VG9p?=
 =?utf-8?B?VzNCUTk2MC9hV20xdkRhSlJRaWZ1MEpRaFJqejJOS3lFNU1BUkQ2UUV3bHFL?=
 =?utf-8?B?cHp2RTdaOTkvUEdZVVdyWVlCRytzR0U3aDNsdnBUSzh4aHBMUno4T1c0TkNX?=
 =?utf-8?B?MXZNSkw3WmFaL2JENUJLek5ma29zUTBmemc4MzN2d1MwWFovRVlmK3RBbEF0?=
 =?utf-8?B?SWRaLzBjdGRCRDV3OVlNaHB4TUN2eXNuVnE0UWx6b3M3bU5NMEQ3TXYrNnla?=
 =?utf-8?B?dE4zQStNSU1vMkxxUk5HYVFGbnZ0Y3BOSGZ2Q2x6VXIwQmlnSW9kd0pkMXh0?=
 =?utf-8?B?QjZJY2F1bEFwUnA0NnU4czJuNTJVY3JnbWZ1TDlsY3BVbEpzNHZwV1dBRnQ2?=
 =?utf-8?B?cVpHUGNTcHJHQ3U2MmNkTGsyZzUrVW1IanYyZWZra2hCMUdmc2d0endxR20x?=
 =?utf-8?B?NVo3RklUOWNLM2dleWEybnYyOEx1Q01ENENkK0RrZlk3aGRPdmk4K1VCZzJw?=
 =?utf-8?B?MXpSVDBZNkpsektwMUVqNnRlMGFCVmdFQ2FPdnlWRjM4cUNzdXZrMWk3czRW?=
 =?utf-8?B?d1E4Wlc0U0JPempkK3dxVHdTc0E1UkY3cnJqeUY0VENhL2M1dEdIclpIUm5l?=
 =?utf-8?B?a1RidVoreXVIa21LWjh3WFJkd0c0MWtFbjh4dm05dXV6dVlMNkdnZFBZLytv?=
 =?utf-8?B?ZklSWjU5NjNkdDRMdmtsS2ZpOWlhQnZ5U201VEJ6ZlZoVkdvbnpnbThFK0Mv?=
 =?utf-8?B?ODhLM1ZNTXZna2NXeW1LSEsra1dNRU42eGNpMXg0ODhoSTAwd0hhWDdqa2k3?=
 =?utf-8?B?N2VDN1EreUN3WGNIbDJxYS9mOVB2NnN5M2t3d1Vwdm1kdXpTOGIrTE9sUk1S?=
 =?utf-8?B?ekxUWUZJOFlydVVvNnV5K3RJQWlHVW1SZHhLbi92WVQzR3hBRTJUY3BiUTRZ?=
 =?utf-8?B?N3d1Z29LaXZWUUF2L044czZveGlTMDNRazNXYldYaEtEenVGWHlydVVPdmYw?=
 =?utf-8?B?Z0VmeVEyQVo3ekxZTUN6aFlrWmIydmFxMktiOXRidVRmZUtyL1hlTEtMd09N?=
 =?utf-8?B?cmVyWWpDU0Fjb2drT1JGYUZKZWw5QkdOTmJvTUlRN3NYVUdIOEZ6V25mOGxU?=
 =?utf-8?B?VHdxdkx2L0hZRDNJdm9MakRmK2tiOFJjaW9uR0NpcmRVZE1GeTI1SlE1ZjFN?=
 =?utf-8?B?azNkbDIweC96c0xsUEwyQitTSjhIS0lCU3FJdG04VHZIQ05SNHpQYThBWWFS?=
 =?utf-8?B?QVZwWXFxZXpPYXhNS1hkOW5BSVc0V1czbEt6RHhFeGIzeThscVE1T1JYR2xl?=
 =?utf-8?B?U3dCdEQ2bkV1UTNMSTE3V0Z5OUhmRVJYajV6anlSQ1llWkZWdEIzMlNxQ0Q4?=
 =?utf-8?B?Z1RNYXIwK0IvSjJKYkF2S0pURG5HRnJxTHdvQko4VzJ0ekc2c3FqR3kxNmMw?=
 =?utf-8?B?Z1U5WUVHSmtoRlFPZTd5MFhBNVNoWTYzbThSWlBEZUY3S25PM3BLMzl6U1p6?=
 =?utf-8?B?bmo1QTB0UlNHNnd5VW9JWjJzbGY5M2d2UXZNcjNWRHJVcUNiRFJsbmJJV0NY?=
 =?utf-8?B?b1VUR005Y05JOWR4VGtOTnVPZitMV1RPWXZmdzMxRlRFM2NuNkE1T1kwNEkx?=
 =?utf-8?B?bU1HUTEyckI1THdFUE1MaURvWHZPZlhrdFZyNVhOTGNTZk1UdTQyTzhSL2dn?=
 =?utf-8?Q?1SiuWkeIm2yIh7dtFXZCjHrQ5w5q2aOxiY+Wvs3Fkml6q?=
x-ms-exchange-antispam-messagedata-1: sLuy0cSGLziqTQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtLunKNSbRI9cm43k8NG6/idEknSkQBlEHWEQOjawHjjxLHVvZ3QAtF2Y4FPjwTGhorp+k5676+hZrVH9eWV6IdrioFt5W5GQyeYUpLKCBKfpRySoWg+DV7fUq4e65oCBRLw2qwyNf30YvkMkdW0LGTKoVxTraHRCsNBKjfRh/+2AnSLx4WZPNbAuY0LaBQvAKb5CX4KWunVuclZrJyriqKk5f9SyCMCf/knoEfBIiaWrCAOYTYrePAm6CIxcyLF+RPtDOr733zmu8kNxOGkvUCkXieUZ/TAjZrk5G2kkOr3N3O3ENwthYggVPQE+htB6f06ra/p63D/jthTQdPEkg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3cj0jPVSrGaFIDIYoWoL9vIEe3GiIOBQ4US/63r+a4=;
 b=ATx/wQ9nYeFOl9dtZkrP0V404Du9MIU5YE/0oPbYKj3U77lDpl9wYIs76FS6CJyA9FoVy5Qg+i5M/k8kEVs9UddHI7eNBjXo3+Ftr9EAacHL4ohgrt4TgWJxeabHqs2ZJRsPv89Y5+Wc+RTdQ+N2FLtD11Nb8iqVGd2vI3Mx/+WwjLaK61a2IrO55PTpY9uHGSTtMXauT/37W9a9lwXUyELN03bUVZ0QFFkuYS4z3iKd/XZsKXOI7XrBZjY4D82E5yZENRZQKawroo8Mgz3G/l078BgjT07WkMsvHvlRBOsP3jtKP4wkUOKlTsqNKOvzrUnqecNRNlp9LsyM9ucM4g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: WMyu2PfcvW75/UNjzUIuOzh/nDiLD3wsc1XQaYrwsVY8VvOdvVT39v2hJX00NHDODdzsph3NW3OKrMhPP7jJe+wtV5cCNhd+b+3crWfI9NSCUAhKpi5I55A04dtEmtI7fEfjG+5JuZRWHx6q/yo3fNjwUCUvjP/DKQtoTOFAK/lG2bfniCjPv5P4TEsK/ODX4hzjI18TK0xFR5VPmW2SrpOwGD6w4+PJAgvFJlG4lqf51NT4Um06/KfV3o9QECO0j6xNwfFzOKUIxOSVqidBapXL4i3YX0u2F/SIpgnD7QOaQxueq6pC+xe4YGksrgBTsFknE+Z/E8Gr+YRWkxto9Q==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5aa97755-4bf2-41da-c239-08de9efae014
x-ms-exchange-crosstenant-originalarrivaltime: 20 Apr 2026 16:35:47.1418 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: n8F+GJnAUqArxZPc5K6L0PZntssYcpD9LK7azRa1K5EpRdhwNDZ4WuFQ91/EbNcH+BN8xKRhu90bmxeXFPBE9Q==
x-ms-exchange-transport-crosstenantheadersstamped: DM4PR17MB6320
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EECA1632633B2438CC67EA8C0821CE6@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=725 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1OSBTYWx0ZWRfX+OahEL36UJx+
 BScHiUMR9rA852hTBR2pA/tDBjgcUkywlufUQphr2d7X42/geiuXRDJoURgNgqMr9OoZypbT55L
 oynxav9atIpeY6J7YR/cndqcW77kp0qWs8p8AK3hZVXJCXEM3QAsk3M9xDo4PcD++FdLtWaXpsf
 0F+rQ2eeHtLhT3keLIdfnK/YT8T+F5vhvIQggGqRVophEbpgAJROMRwBnBGR4yXB+v4I4ijvqZD
 ejuIdKXE5JtgMuQ1fRqXVmsqExDTXSnMhTu5mZUQ/tjfKkYWumpbAFJdzuxPhNsSEDHPz5c+gxp
 BfhUPvqZZ4Hn2+wXyyEF8F0jv8VhHviczQpG9UIrpQoCZ2t/luMrXR3ZO1wh7UOKD9FNyQnJMTh
 w6vkwHrG679f7kLAzWW9Wv/dQUuQo/R5S/kNpq3Y29ETSG2cj8yHG9F8doI295dC9hdODof8Km6
 yuhhgNKsIVpnI/idI+w==
X-Proofpoint-ORIG-GUID: HAWhkIfdMAmahAmoqB7EY4riSwRdKRwW
X-Proofpoint-GUID: HAWhkIfdMAmahAmoqB7EY4riSwRdKRwW
X-Authority-Analysis: v=2.4 cv=K7IS2SWI c=1 sm=1 tr=0 ts=69e655e7 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=5uIk5skAYop0meUMGpPt:22 a=6R7veym_AAAA:8 a=kblCG5kKv-rejUuypioA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604170000 definitions=main-2604200159
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
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

DQoNCu+7v09uIDQvMjAvMjYsIDExOjQ3IEFNLCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSIgPHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRleC10
ZWFtLnJ1Pj4gd3JvdGU6DQoNCj4gcGluZyA6KQ0KDQpJJ3ZlIHJlcmV2aWV3ZWQgdGhpcywgYW5k
IGl0IGxvb2tzIGdvb2QgdG8gbWUuIE15IHJldmlld2VkIGJ5IHRhZyBpcyBhbHJlYWR5IGFwcGxp
ZWQgOikNCg0KVGhhbmtzLA0KICAgICAgICBCZW4NCg0K

