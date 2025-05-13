Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5E2C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 18:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEub6-0001lc-KL; Tue, 13 May 2025 14:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uEuY4-0006PQ-R2
 for qemu-devel@nongnu.org; Tue, 13 May 2025 14:40:16 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uEuY2-0001Tv-0V
 for qemu-devel@nongnu.org; Tue, 13 May 2025 14:40:16 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIUa2h011975;
 Tue, 13 May 2025 19:40:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=Q2H9d3FejM0El2KnrlWSMWNZn+Y+cDh7KV5eSwnqudo=; b=
 c2QZO4//T6hIy0S+PftzOWzieuNe7iC1UE3VQG/nIMzewkT7fDpBRErMA1N32P+S
 fi4BIFLF6ybVEACtBd8Gml5HWLVNtid4nv0xgD352whOfZ+uKn1EWasd9w0G5HUP
 6mAjv8952kb9aK50VuS0dPhDPBmJRgQQn1v9TUldvz+PDZHBNXTLXPCiAhCcozan
 9ZXDUQrq7pbZ5h3m88SckRyr8Zo18Oh2pLXm0ZT5znjIfyxrhWISJr4q7oYHJtRx
 D/Z0hMEvz1SUBtRrk/X1ehhtMjb1/KT9hskaYeKg8o4D4bSZYv1rxpVAGHsaxg5P
 5RpoI+qa4KxJQtKNlotEYA==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 46mbde82yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 19:40:07 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 54DGDfLv018827; Tue, 13 May 2025 14:40:07 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.202])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 46jkpya9cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 14:40:06 -0400
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb3.msg.corp.akamai.com (172.27.50.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 11:40:06 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 11:40:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 13:40:03 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by IA0PR17MB6419.namprd17.prod.outlook.com (2603:10b6:208:409::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 18:40:01 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:40:01 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: David Hildenbrand <david@redhat.com>, "yury-kotov@yandex-team.ru"
 <yury-kotov@yandex-team.ru>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>
CC: "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>
Subject: Re: live-migration performance regression when using pmem
Thread-Topic: live-migration performance regression when using pmem
Thread-Index: AQHbw1DYBGrB/0pV9U+SV8KgfbE6+LPQ0FMA///S2gA=
Date: Tue, 13 May 2025 18:40:01 +0000
Message-ID: <775463BD-2E61-44E3-BF7B-6469ECB56F33@akamai.com>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
 <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
In-Reply-To: <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|IA0PR17MB6419:EE_
x-ms-office365-filtering-correlation-id: ced2724a-24cb-4038-4af6-08dd924d91db
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SkgxaW9RQjdvV2hqWVF3N1hUS005eWJJeG5WQkdFWUY1QUk5UWpzUVB1dVdG?=
 =?utf-8?B?dXBoM0V0LytOcTBxSEhPdGgwbTM0U3hxdzdsOVZnQkZFRDQrcWZMOFFCU1FV?=
 =?utf-8?B?ZGJYckJkMWZocEtpU3FQaW5vZ1RZalJ1T245Y1NiUGo4VXF0OUgvRXBxelcx?=
 =?utf-8?B?TlEyNFZiVVBmR3RGTHQyanhxU0hhWU1kTmxBcERXTHF0VjdWYmxrbGtYdE10?=
 =?utf-8?B?Q1FzM2JyM2QrY1JyL2FjRDR6bU9aejFOT05KcTlLTkZxSmhMeWd0b2JId0M1?=
 =?utf-8?B?eWFCV2NKS3NQNUdBNVZzRXlRb0E0S1YxWEVjQlgrTFMxczN3VWhLdWZjN3Br?=
 =?utf-8?B?OFY2ZGtJOWJqeUx0ZS9UQjJnK0VjM3VxRVZuYnVsdGcwS0szMisxRXZsQmI2?=
 =?utf-8?B?b29CVjFlMVFFSUxkbndmb1JWYTRDcUpoTXFkQ2twUTJlUmpXZ212Q0FXazM5?=
 =?utf-8?B?RUxQN1M1RWNlSXprVTMwdDQvRVpqL25DR2VORmdQUG1OckYvNXVjRkZFclZj?=
 =?utf-8?B?T1VndzQyU3NTb2VVMklWNTFwNitsUU9yRmllQVVtcUFIb0VZWkxFWHJTM0dT?=
 =?utf-8?B?cjBEZVpHRnFvQkNUTFBweThCQUV0VFRwSDE2UHVPalVXbW1hNUF5QWhBemZm?=
 =?utf-8?B?U29kSGZYOG9OQzBVbHB4ZzArcWRic255alBLS2JkVlg3Q3hjNFNDaWZ0czMv?=
 =?utf-8?B?OUVLaTVOMXFsaG5QZjhjMFhyRXVJT2JQWW5vQjlsYlF3L2NLN3J5enNUZnhj?=
 =?utf-8?B?UWo4TmdGUGpOYU1MR2tYMWgzU3RSSXhiUy94OW5Nb2gwdnZPWUozSkFDcHFC?=
 =?utf-8?B?d1VXOGMyd0hKdXZJVkgzME9FWSt0bU14UXZSVVZQd2o2VlpoLzI4MUViRVdx?=
 =?utf-8?B?Yld6ZmRXTHFXcURPdWFRdDNYVExWbGRPa0VOUVdyR3BOTGNQeDNxYU5sNjZK?=
 =?utf-8?B?eThlNUlDQ0Z1czFEbDZFQ0RwS3JIMk82L0FuRGcvK0wrTThaNzA3UWY3UGs4?=
 =?utf-8?B?cGMvVG81R09yUnpBZlhRemFhVlNvL1dYYVJZQlpzYWQ1RFRvTG4raWtlcUla?=
 =?utf-8?B?ejFRTmRhTWxKdVpEOVBuR0tML1RIUi9SYkM4YXJDWFYyeXk2VmZETXhITHpP?=
 =?utf-8?B?NmdwQnp3ZHlPL3pOd2FIUWtlbTBvYUdlS29LMUU0aEViaGtBaWRlYWFlZlhW?=
 =?utf-8?B?ZW1kZ2Rhd0NveTkvdlFsVDNpcmpVMDJDYUZuTDFDL0JUVGw4OXNzVXBuMnNp?=
 =?utf-8?B?SjR2S1NUUVpZd3Zpb2VvV2RKSWtZemJQeDAyTEJObjhJYTRHQnNtMzFaNzhL?=
 =?utf-8?B?c3dMN3doWU1ydmdUdUM1Y1pTQVZqUW1QWWlzTWtpSU9JZ044UkYySVRkUVln?=
 =?utf-8?B?QXdJTE9Ud3kvWnFTZERGcjlDMDNySVhBVmVOMG1WalNyOHBlSDR6a3lWTWI2?=
 =?utf-8?B?OVJzZXFxS0dhRng5Rkd0VmVqeHZaQUVndUtUVy9lR25FY2xMRzY3Q2w2RFRU?=
 =?utf-8?B?WVB1K0R4anBiMTdCYS9JcWN4dHBJVXZRT3IwSTUwdm1FNWwwWHF2S2l2QWY2?=
 =?utf-8?B?eXh2UlhacldRN2pnTFFFVmVVbW5FMjQzbnN5SjRidzd1RGFiQUMrVWk0WFZi?=
 =?utf-8?B?OUp2QzVrZVR4YWJ2NUFFS2E0cEJNbnAwRXFuNnNTM1A1cjYzUUdXTWZob3M5?=
 =?utf-8?B?RTZXeTRJdndaTjcrcU1VV2ZiOGZtWFN5MXg1QVNuVFdtWlZkbFB5UFRqV0F0?=
 =?utf-8?B?dnJ6VUwxS2wvTm5QTjBmV2JLRU9SaXBNbkNMNE1naFAxNXN6cnplVWJ4L2R6?=
 =?utf-8?B?M25kSFBGcXNWT0JTWkZaUG5JUTJEVW5OS25uNXRMVVYwZHpTdGhNSmZCQTlT?=
 =?utf-8?B?aE1QRThjbURDdW5jaGNPK1NtQWg3L0pwYjc2MWk5N2ZGVk55NFNjeGp5dkhP?=
 =?utf-8?B?cjF5UThjS24zSmUvbkF3K2k2Mm5lYk91TDF4NHp1VktVWDgvYjMzWG12QmV0?=
 =?utf-8?Q?nMvp5wx0iFZW/izKx0tN/V4xPbGUXM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVBQSXk5MnBuc00zMTVwb3NnSHZBSy8wdlBGV0k2QVpvclpJMXJVVTVEdGJT?=
 =?utf-8?B?cW9PSk5rd2J3SmZDZ3pYdmtQRlhkaHJlRVVrQVhUTFc5WGV2L1lneS9tSjRs?=
 =?utf-8?B?blMzK3J1T3dxdzIxK3JqbUN0SFhFaktVeWdpK2gxUmdDYnpCdTk2dTRQMEIx?=
 =?utf-8?B?dzd4eDRCOC9jQ2I2dm5BaUJFMTBqUk1qdG9BMEFrUjdhS0pGTmNwQ3dNVjZO?=
 =?utf-8?B?S1NadUNxQ3g4dStXM2J6NE9OUEwyelJ2RFBLSy90OFhnYTIrOWxGd2JaeDQv?=
 =?utf-8?B?UUkxYldHZlI3d3g0WldXckRsMzZGYW51MUE4V2REOUF5K3h0OGxGcWd2MWsw?=
 =?utf-8?B?ZGhzY0ZpSlZBekQyV1YxOVB6dGZxRkxsZW5idjl5NDFKQ200VTh6eWxiMVRY?=
 =?utf-8?B?UHlwK09pTGorcEc1WjJXVlNzSDY4YnFSS3BvQ05IdWFEWUxhbzlKZEtzNnNX?=
 =?utf-8?B?Y0VGYlltRWlEZk1PTWs2RElnWXZCVEN2SjN2ZkF4QUI0b0UwYi9tL1l0cTVM?=
 =?utf-8?B?cWJhVlk4alZBcW1YL014RGY5NGJaZ3FLYUtSMlFFWXdZd013cUNPcWxMZnFt?=
 =?utf-8?B?bUlaNzNiQWlCbGNaUjZJSlV5WDNQYTNBZlZvYk82a2tHN2JQVU9uT0ZNSFQw?=
 =?utf-8?B?VEhqL1lpRk5laTdHazFFZDdwbG91cGlLNE9EbGxtVjNnWEJYSkpuTkNscmIz?=
 =?utf-8?B?bnYyTmhHNjFYaG9JV1FmWGM5TEVuUFBaekpsdi83UTMzWWp4MDV4MFB4NXBk?=
 =?utf-8?B?NDk1dW9ReU10L2lKMFRPWEpha3BKaVFTajFHUXhqeFNuNDBqRE40Sm91NHUx?=
 =?utf-8?B?NXM4RGpwZi82TDFHK2JyNFo4aUtPWVZYYnFEM2R5aldBdHp1eWNHdXhTMERQ?=
 =?utf-8?B?UGxDQmMrYkhFV1NZS3hwQzlveTRMbnBydDkwazJ6d1IzVFNJbFhZelc1bGRV?=
 =?utf-8?B?U2piYjhHdENPczE4aTRudDNBZCtQbHl1NzhCajQwQjZlNTIrKzQ2ejV1Wm94?=
 =?utf-8?B?RzlGVUd5VXJBRTFSN0FaOC9aclkxSkQ1RVN1cUpQWUd6M2FmSHpWTU9iaWNm?=
 =?utf-8?B?R004a2lYeFMrcmx2Tk1KQlBjMGNNb0I3TzBON3RLTFEwTFFnbzdFZ25HOFA1?=
 =?utf-8?B?aU1CYm5BOE02QVN5dVNycEZZeUVvb1YramhKcTZKaGRJdkxXM2NyVnhQdEhl?=
 =?utf-8?B?MTF5K1Q1TDRuWkFGM3dCRDFBdm9SYzBPWHlJZ3dVcVV1dkFDTVNnQ00vaEcy?=
 =?utf-8?B?c3VBTzdPWjA2Y0Vkb1hzS0FLN09jeW92WTB0bUVGcEVTUTY1S2M1WkhqTzFT?=
 =?utf-8?B?cUtZb2pYaUNyVjdvdWJVZEl1WE5IMHRIZWJSNVlWZjB4aVdldW5mM0Y2d3FQ?=
 =?utf-8?B?S2ZlZGh1dC9ja2xoTWVHS3FlcVIzYUY1QktXRXhUVExIK011cGJ4VndDOHQ5?=
 =?utf-8?B?WnRzVnh2M3k2cFRZaGc4S1I4WUtCV05iU016aTRndmhicnJjN2FpVTBRQmx3?=
 =?utf-8?B?WWlwTmxkTmNOVFg2b2thRyt3RnllMzIxSis1bm5XRGhrM0c4RllRMmFCYVBQ?=
 =?utf-8?B?VGRmTXptcGdTQTJQcDduZEZTZ2JmWnN4SHlXQ1ZvTDN2aVM0MTZLRE5JbVNu?=
 =?utf-8?B?VXdMTG9aV2FWVURhUU1FOUdORlQwZDBNRHliTGxHMlJqZy96QTEzTGYwRkJi?=
 =?utf-8?B?M2pvZVdOeFhCL0lyOGxWUkNMa25nVjZjSmIzUXlQOThqTXJXb240UjhYSnRt?=
 =?utf-8?B?b2U4b2Y5eU1EMTA0Q25mMDhuczArOWM3bmFRYmdMQnhIT2V0cHdad1d3MkhO?=
 =?utf-8?B?QkQ2cjJhVW9YblNiWHJ5YitQUGZPWHFENGc1a2pydG5zdUEzc3JZeiszQ1Ro?=
 =?utf-8?B?YkxoS3JVWE1qNlU5WWVSZ3BxWXllcmZpa1JEaFNHMTN1R3VHSEhGWFh4MnY0?=
 =?utf-8?B?VlB3Vm9TeFFYTE1aVmdyYzl1UXVWZCtPaTRnRkVWQmRIc0svMFJMbjIzeHpF?=
 =?utf-8?B?UEVxTWo3YmRZYk16VG05V21ZcnA5NHNvb0xjQjhKdGJFOE5nNnViSllmOWQ1?=
 =?utf-8?B?K0FBRG12WDBYQ3J0ZVJBbm5VVCsrS1dibWhSaG5pVFdPclBPTnE0QTlkTWRJ?=
 =?utf-8?B?ZmtJbmJXdVN5VWdVREpwZWFNVk93bitOaFJMelI4SUJhQy83SU54SThaNXYy?=
 =?utf-8?B?UGxZemxjV1M1Rm1LeW0zUGMxSDd2ckJWTlhLSGdTNGFPV1JBSWhmSmZSeUtM?=
 =?utf-8?B?V2JMSzZrakJjZGpGMitYeUVuaG9BPT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMwCKSHOKBNSXKpomsTJarVSjNukSS07YtwQtQI5TlAladiYeJA86FfgSFVI6ZXF9z/SsLNmc6PAGv9RY62V8U8HfST5jgQEnWLk3WRyCowOKx0J9NKFIqeGLi0BxvUhV6h3Ml5PX9Vy/hLGj7VLDWQejHqDRU2hM8teExdYSQ/hEYKeGVSNfXIR9t6aDmFb6tTljLlouc3EJYzH5HI+eG7cZLxLyNJh3nxBfwtp5fuL94+WzybXcrwfWZoX1pbJj7yVlrR7VRxbo52sSpMkzgYU4ariyz1jz43pbCQgVHu48kfFsLtZytD0HGQazyh16W9obPgzgs6cvhD6nYSiZA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV1DzHVlywctx8uB7vGKBFNTLvpxQil6wlU8qYDgMYI=;
 b=b+tIHHK6y7bw24D9w4NhMvCIZoPxWGILt8r7Hbg9v+L2at2/7KHaRpCXJ4WP6zKISyAMr/buWh8oLFfx0WHHj0rhpJJ2FVTJqCccqMX/0Nq/2eu3FVAPcXhGWywBG4rjk//GFvfMDUFjyyg8Y6YFuYzHDTCKmNUXsm8adinksY2K2TqqY3QrysZgCVa+/j/8U9AXqEsq6+CWw1UaVIiXaJolCFSIi73bn/OolCCDgIR7ksKDYi05iImID7Q6VA1VtNcTxWVKUsqMW+z2tKaG3V1qlp/CaBKisEyOqw9bAtKjiO4i8WKSAf+lOm6OL8P1vFsNJFlXjOQbx5td+45sjg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV1DzHVlywctx8uB7vGKBFNTLvpxQil6wlU8qYDgMYI=;
 b=A56KE/8diXRPa8GtkyavcnjYs6qQZa6e2mLCtBvtWYjno1cWILEcK0hp7DJ6NVjLZZAlNNwkRhKLd0r+TnE8Mynam/mo77nJNRqWLDBI7bUlBaMdmJH88eEepFFTR5ia4nmnvdmiTdeVqmrkbJcTDEo9yGy+R9oGtmNmo+fsuKE=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: ced2724a-24cb-4038-4af6-08dd924d91db
x-ms-exchange-crosstenant-originalarrivaltime: 13 May 2025 18:40:01.3343 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: YHeOdPW/MUnYLFPmxwktByU2O3M7qwETjwWJlkCfRCHfUq5EDASyKJiqzcRc9ivUW1dILXGcNJXXPMFJW0huuw==
x-ms-exchange-transport-crosstenantheadersstamped: IA0PR17MB6419
Content-Type: text/plain; charset="utf-8"
Content-ID: <26F331CA6406CC4BB2A3095E852F968A@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=733
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130177
X-Proofpoint-ORIG-GUID: _RutGuMDPICki-25M3pxKikZ-KQbu4-B
X-Proofpoint-GUID: _RutGuMDPICki-25M3pxKikZ-KQbu4-B
X-Authority-Analysis: v=2.4 cv=WId/XmsR c=1 sm=1 tr=0 ts=68239207 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=g1y_e2JewP0A:10 a=20KFwNOVAAAA:8 a=rBSi-sgObX7OmSnpx7EA:9
 a=QEXdDO2ut3YA:10 a=fZM5Z8gBAeIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE3OCBTYWx0ZWRfXzDt/yjh++5LG
 pS70d7nlwopBRMVejRZnFpv0KgVeonU46kmceEWZw85cJhr0pqCz1yjzSgWCU4Y+eBuobK527NO
 +L3+LsEfudsmXy8MjClEIWlTN47oQr+ABuvnON1lJfP/RT3PYkBTLKM7s2KkLZdu7cts+S8t89t
 7rNeGoP0msDPsGbX+lWXwd2WSmkWOlrr6ZGvc72Dvaf7TEaigmUN2QOlBVCtANiNB9zeTomOpa1
 R6Om1aICuvmw4OGkL5tXxQRqNuLChb44TkVdQQX7g/qakxPgFsY8aMOImCai+3lDmvcztxCY6EV
 tQPfdT3gE5CZ48q8M3lmVZEG7Ab4FVULJyUWhTO6ZNfx0wti8HH1XR6sVo4EGEgckHURD5pKLS1
 cr6HyaQMKcqp/sAYGNShSfWu+Gf6kP4SCK6o3QQ7+pPNfc7v9iWJnPwRfpjxMzc6f/cqneVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=549
 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505130178
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCu+7v09uIDUvMTMvMjUsIDE6MjEgUE0sICJEYXZpZCBIaWxkZW5icmFuZCIgPGRhdmlkQHJl
ZGhhdC5jb20gPG1haWx0bzpkYXZpZEByZWRoYXQuY29tPj4gd3JvdGU6DQoNCg0KDQo+IEFyZSB5
b3UgdXNpbmcgYSByZWFkLW9ubHkgTlZESU1NPw0KDQoNCj4gSW4gdGhhdCBjYXNlLCBJIGFzc3Vt
ZSB3ZSB3b3VsZCBuZXZlciBuZWVkIG1zeW5jLg0KDQpXZSBhcmVuJ3QgdXNpbmcgYW4gTlZESU1N
IGF0IGFsbCwgd2UgYXJlIHVzaW5nIHBtZW0gdGhhdCBpcyBiYWNrZWQgYnkgRFJBTS4NCg0KQmVu
DQoNCg==

