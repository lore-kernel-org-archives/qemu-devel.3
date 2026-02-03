Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6892E8304F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMGG-0000ad-80; Tue, 03 Feb 2026 14:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMGE-0000aU-Ue
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:40:30 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMGD-0007Y4-1e
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:40:30 -0500
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 613Bk2lc3105297; Tue, 3 Feb 2026 19:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=58J7qv39e1vbxqLXov2MQGlHvQ0E+Iozonh16DDsWdc=; b=
 Uo+KWKNa5bJlO9Xe1RZCneoSVW8TgvmfPF/LHrPTJOOPDbRT/jkur36jJkmqv9IF
 Ti7gX56oCB72qRet1LUMnm6UjW7ZRQOqJYFF9oZZiVZZuZrsMMOa3pNqk8/QbMOE
 2Q8pGEcJAkj9dTt4fyFdGwYVbOtyh9mQJWhSCV4bqRmHq8gM6Yvb1sY0tmm/T1cN
 3T6EQhA8VWCYB4LzctDWZaSaEyfligml61pB+T11V9zIumO22+EOtd25cp5emcTV
 EWzkHUwdY+6STTOp4Ok/OF0EAcv4C9scYrG8nmwt3fbN5tkblvjiz7blhT1VFHGL
 PJaPUTGllhZuDm2TfSSqrg==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4c1b1bw27h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 19:40:26 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 613J3T1o001075; Tue, 3 Feb 2026 14:40:26 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4c1dy37k0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 14:40:26 -0500
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 11:40:25 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 3 Feb 2026 11:40:25 -0800
Received: from DM2PR0701CU001.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 3 Feb 2026 13:40:25 -0600
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by PH0PR17MB7742.namprd17.prod.outlook.com (2603:10b6:510:382::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 19:40:24 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:40:24 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v2 10/12] net/tap: fix vhostfds/vhostfd parameters API
Thread-Topic: [PATCH v2 10/12] net/tap: fix vhostfds/vhostfd parameters API
Thread-Index: AQHckWbOVVlGSPYZ9E2OMplJ53Bm07VxE0CA
Date: Tue, 3 Feb 2026 19:40:24 +0000
Message-ID: <5C6782F5-D8EF-4725-B5CF-843E4E49FC69@akamai.com>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-11-vsementsov@yandex-team.ru>
In-Reply-To: <20260129213215.1405459-11-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|PH0PR17MB7742:EE_
x-ms-office365-filtering-correlation-id: 05f9a78c-8f37-4195-2cf1-08de635c130b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bkV6LzZINnpRQ1VXNzYvT0gwekp1Z2Mvajl1aTI3K1NHTi9raWdhZDlVU216?=
 =?utf-8?B?Nlc0WDRrYk5iVkRRRlhvcnZ3VTJ4ZEVMbDlhdTQ2MWV3a0IwakdzRlhQN09k?=
 =?utf-8?B?Q0xDVnFRRGF0QUpxUW52czgvbUtBakFUTG8vZlA3OGE4dk1tQklPUUhwZnBD?=
 =?utf-8?B?NlZEbEdYQ2JnTnRJUm9HY1FhUHduaTEvRFpCMzhzTCtWU1pSTU12QU9LdTN4?=
 =?utf-8?B?Q1RTanJiTWVPdS80aG9keUZFNnp0TGQ4S0RmY3FjSi9PQ2hKSTlDMDM2QUNx?=
 =?utf-8?B?TnN0ZmoxUEpjamgwaFFxWU55YWxjeTU3R3VMdUdaTTBKamNBcTFtcVNPZll0?=
 =?utf-8?B?Q1JOdFNBd2RWMlEwQnZjemxEOXplTDUzNkJNR2ZmR0hTRkVBNDNpdlFSaERp?=
 =?utf-8?B?UnkzaWIzbjBCZWl5ZWJ0R0xqRDZCK0NTY1hjR3BBMXpiYVd2NFN6a2pzUWo0?=
 =?utf-8?B?d3JVeDV1dVNzc2puKzJ6VHRwcFhIK1Q1YnJTbEU2a0VxT1haVzFGOVBpekxh?=
 =?utf-8?B?MVQ1MzMvRVVtTFZWQkE0Q3F2Q05uUGlFMkxRUXNwaU1ZbElPVHN0R2phMU50?=
 =?utf-8?B?ek1sTGM3bHZzZUY3QUdQMythZDlFVzlhY0lWQXNtUFhibjlnK2hMRzlzUER5?=
 =?utf-8?B?OU5BelNjYytuTTNaZjlsNnNhRHN6aWNwMWdlZnh0b3VZQUFnZlErNVNqN0ZI?=
 =?utf-8?B?TWtKbTBwblJCUXRacHhZa2JTTTB0S0hKbUhQV05rcVR4ZU04TnN6OUMxZTdj?=
 =?utf-8?B?UTFOcHU3TkdxamMvaUZVd0xCTy9admNkTmRscUVoZ254emEwMzZzOUtBSVBH?=
 =?utf-8?B?Uk1sVW81SkxGaTM1cDJQZUpCZS81bGdtVThVQ25lSTg2TjRWSmc1M0M3c0NT?=
 =?utf-8?B?Y1FGTk83dVY4Z3V5NlR0R1dHQ0JDTXl3ZjhnanRmbjhNZnRVMkZOb0JVUHB0?=
 =?utf-8?B?YThTUnhlc25JSFVGa2syaUJFaHVUcDFvcmNTU0x0aURtTWlxR3ZOMTlnUEVu?=
 =?utf-8?B?ZWE1dEVFTjJwSG5GdlptMFF3eGN4NERaSmhTbFg0Qndhd2pUTHhUemUxamxu?=
 =?utf-8?B?TEYvMFRndHVGcnp5Y3pMNFlrMU44eXBzdTBRMVBTNW90K2JJcm8ycEltZExi?=
 =?utf-8?B?M3FKUkdMK0RuZmZYNFhKQTc4NjdGMUhUWnVhTUppRlozSlhYWGc1K0dYS1kz?=
 =?utf-8?B?bklrekIvc1MremJ4NzhiUkJhWTV0Z3VNSmx6STR2VGxKOWZ3VDBmZmYwanlY?=
 =?utf-8?B?VUczcEhYVFhMYnhWQlJWY0hsVnFqY1ZKOVlKUVpwMU5McGowQlZoYmpqa29w?=
 =?utf-8?B?bkxLMGpWMFBYWkNEZEZZZlltcGJhTEgxNXducVA4OGdvOUZ3a0NvenBQay8x?=
 =?utf-8?B?L21oNlZSNXRFSFAySWkrMUlySXppSUVTcFU5bkRaVXl2djBnY3FiM2Q0d2tB?=
 =?utf-8?B?YU8zMEN2QW9xdWN1VlNkU1BsUkEwTWVYZUErWElMZXptYUxYeTkyc1dZNXF1?=
 =?utf-8?B?Z3U1YnhTMk1GQlc0KzZSb3dvUTdOc3FUanBhb2xnWDBjdDJudE9jeTAvNW1s?=
 =?utf-8?B?aXh2T3owM2REWVlqSXVubFUwNmJPaFhITmhPdDVuVlpYUlVjZW9WQW4zeFdV?=
 =?utf-8?B?M1VWK0EwZVBGdStoejYzdm5OVFZTditjZVFFZUQ1T2N5UGVjNnlrejBZcDB3?=
 =?utf-8?B?NTF4aU54V3IyWVBQcVpYVWtYYzlpektBSlZjZmdnclhUaWpHZ3ZjNmtsWS9U?=
 =?utf-8?B?ejk0ZzZQaDhWU0ljUWlVQ0hOWXRUaXN5RDJkcS9hTitCcnBjanhRMFRCQTB2?=
 =?utf-8?B?eDljcVh2azVvbHJXeXNCQUxJczNTNWpxTU1tN0VZS1UwaHFQamVCRmVIaEQ5?=
 =?utf-8?B?a1k1YmV6OXgzV2tMRE9GYWN6SjJkNHN6R1BqMW8rZTg2ZjhJcnB0LzFZeVQ5?=
 =?utf-8?B?SklsOGIwZkpOOEV6SGVCY3NlZUp6Y0pYM0F3NHJRYWx2SWR0cHE1bHVKWUVu?=
 =?utf-8?B?YVV2czRFRDMrYmR6TmJDTTJFZ0ZGMGliWG91bEdERlVqdDlKbkc4WjFnbVl1?=
 =?utf-8?B?R3BaMVg4Vmt5MmQ2ZzlXcmVVSWFVSFRCU2dZZ0N3cU9HT1ZiWlJEYlBzNXlW?=
 =?utf-8?B?Y1QrOCt4QXFBWFBMUmNSRXhjZDBLN0FCRGhrZlJmanR4cjI3Yk5qaFRxMUpZ?=
 =?utf-8?Q?hZyYCZxAzsr7F/ljY6pjrvw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2F4Y0Rrejk1MUZqNEJzZ1ZFOTVTTFI3Z0tNdXdHa0ZNY25WV0dXTEtJWEV1?=
 =?utf-8?B?Z2xkbnR6WEZYaXZGTi9uZVp5ODdGRHFtVkxVdmg3VmdCREtsNVpkYllqL3Jm?=
 =?utf-8?B?S0lIbDZaT21lWHRLcDBnc3lFNU5FQ2ZnaHYyRjlpVmIrYTMyRDU2eVlweDBh?=
 =?utf-8?B?ZDJNQjJ6TzBnQzJyZnZKYm0zWXNSVW4wS2E1TGFxaGVrU3lpeTdaOFpONmJO?=
 =?utf-8?B?eVk4bDN1Rm4yVGFyK1VDSUc1VlExOFhtSHkyYmp5OUlSNDZvU3RqMEg1Tmwz?=
 =?utf-8?B?dGxqa293U0lZcTZzcjIxUlhvNE51bzAwZFF4blV2amhpcFlaNSs3YmFCU1pJ?=
 =?utf-8?B?TjQxbWMrcUdleUhpU0RNaktNcm1VenlpNUxVRUN1YjZCdUc2c3h4Q0JpT0lZ?=
 =?utf-8?B?VkFkUU93NWVxR1k0R25ESUl3YWk5cEpIdTRaUnZuWkRIWTM4S0p2WDhweVVk?=
 =?utf-8?B?YkVYQURtSGJlajlGUVZ6aG1uZ1E4dHhSMEZ5eTNkbDlqQm1DQXNVb0NrdnpH?=
 =?utf-8?B?QnlPTzBzNzMrR3dDaHA4NjhKTnJWZmRsOEtmQ3k5dnBvc3dtUXFMdEQ0WGJZ?=
 =?utf-8?B?L3NndG9zV0FHYjFkeDVidDYrZGNkNFZGWi90dHBUZ0kyZndVNnRlMDU2M1Nn?=
 =?utf-8?B?OVA4b3hSd2dESHRFaGVPdVc2SHZqL2FTZUVkd25aTEJxWnhUU29lR2JSRlNv?=
 =?utf-8?B?M3lIKzFua2ZPa0xWTFF4WDl2TU9LL2tSQnRNM2wvSThpWGVrd1ZRNmphNi9v?=
 =?utf-8?B?eGFwUVY3SWlkMnRBaVcxVExvZ0NNMXQ5QURudzJIcGZlTkE1NzBPeU5EdklQ?=
 =?utf-8?B?eGk4WkY0clVwOCsyWFJPUW9JWHRDeE5QNm5QV0FsQ3kwT2RoK2hhM1crZktS?=
 =?utf-8?B?RFhDYStPVnNxcUtLMzFiSmpqYVpWMlJicFVhTlVaak9pTkVXL0Rsa2NudzFX?=
 =?utf-8?B?Tk1VSjVwZ3cxSFRpVmg3anYvcnlyUHIvTG5GcW1KQXZEdXphYk1kUDluQTJh?=
 =?utf-8?B?OWhnc05QRTRDR1hOZ3J5dnp1Tm5KcEhWWGZ1UlFmekQ0NXk4UUYyK1hJRVlG?=
 =?utf-8?B?TEFqN20zcHBNSzRvVDZNOGdmTUZoU0daTVMxeXhzcUFzaGEweGRlc2Jhblgw?=
 =?utf-8?B?WTFnRC9qQVYxMkkzbWdmeGhhOVZmT1lpM3pSWGRuMXFCUzdEMFo5T3RIUUZY?=
 =?utf-8?B?UTVUSHNmMEh4SjFaRWdWQkFwUCtRaUp3QVg4TjBoQ2hld2hpRmp1a1kyS1Fy?=
 =?utf-8?B?blJsMHRzaGQzQW9XMDIraHA4S0ZKT2RoRE1odkJzVS80a0FqNUFuVEFPS0Qy?=
 =?utf-8?B?b1BCZ2xKV004eXZvbGJvc29LOTdDUFZEWmJMakVVT09XNHVkYjdvSVFRbW1o?=
 =?utf-8?B?QndnTjQ5ZHpIWDU4UGlqa2pWbEZ1TytrMFYwZFJlTThGbElvS0d0TThXSzJy?=
 =?utf-8?B?U2ZheTlXZmsxYklEOUJ4a2lpVmtJUTBGdFdFWlBxU1Nic1h0Umh0elFlMFJk?=
 =?utf-8?B?QW84Tkg5SU1KMzZyM2h1UUI2cmQweXpXcjNMZkRvL1paWi82dzZpTUNzQW9t?=
 =?utf-8?B?U3l6S3haT3BBbWVnSTdmZFR4QjF6Z1o2SjBWRFRwRjJZL3dGempPVkFxTWVa?=
 =?utf-8?B?RkpRSnp2UmRZR0dSbURIQ0dEREo2THRscDFFNm54OGpidHJzc3Y1ZDF0dkdp?=
 =?utf-8?B?V3czMHFLZVMzMGNwaDNwaU80TExsSE1OdnlJRVlWN1hId2c4czhaOG15ZlZ0?=
 =?utf-8?B?UnlZaHJ0SXlxLzNCZTUyOTVCUHZtNE4weTRCdFdOZE5tWWVQWUM0ZVdHOEdK?=
 =?utf-8?B?dktudWM0WmhFdDZCaFlPZ1BoZURYQWhDcGk3dmY1eUUvSmhJTEVVRzMrdlpR?=
 =?utf-8?B?MTI0bTdvaG5INUFmWEF0WTdic0diU3U2S0JRZENxQlVXcXpoR1R5UEI1bEZX?=
 =?utf-8?B?NE1qQ0l2cmQrTCtnRlEvbWM3YjY1MlV5TTk4c1I2TlVpcDFFLzFrbTVnUVhL?=
 =?utf-8?B?V1dvSkVmLzNHak51ZkZvNTBJeDVXSlZrTjhVWTg1ZEJ1cUlZMXA4Y3BHN1Za?=
 =?utf-8?B?NG9OQXEzTERsNXphNzJOS2ZDclVNRG5MRldheHRnQmtCSndETk9JLzRmdERa?=
 =?utf-8?B?N2ttdytHNG1DU1I4VVNjWEc1bXVKM3VCTDZCTEFvaklHRXZKQjFkeW1aVzVT?=
 =?utf-8?B?NlpWSkFPSVFJcmlVME45TVh3MzB6SVcwanptVTY5d09NWDdsQThQT0JyZTJj?=
 =?utf-8?B?RzAzNWFYWiszS2llcUI0ckVCMXRzcWtBY1NjYVhxYUZXWXF0SEVIN29aMU9Y?=
 =?utf-8?B?VFoxUW1waS9OdytOeWNkaS9TZU9aZmlGaGx0bTNPbDQ5RVgwNXFlbGxvMTBC?=
 =?utf-8?Q?ppZVTQGwR/vHz0vbDDu6Jc+8md9jW7GHD4TJ6v9kn2Dxs?=
x-ms-exchange-antispam-messagedata-1: TagyOaK1uY0CUQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3Z8qU4mO+PU+Ax1IE7CIe4wrugB6CP9mI6bR3ESbea8Yk2kjXSsIURIcbWtb4xLsr60zQxp30goQSVEkRyhfLatL34puAQtuktSspMa5uzORlsEVPec+oL7XbAHgIynlykSfRgGWbz/fyG4NFdi3UOCg3NESj73VElVWQLlM8Fnp+4JRwA5BeclQUmKfC0lqScpInFN2NQrFCIZ1n9+4Piom7wFmieUvBuKK7UMBjr86+pKX1hFl7aDvC/jHCPR+k5l6x+IslOkI5k2/9ZVEx43sl3gbzUzfWwicm6UTxwZtU6V6qBn+/ivLQ4pGyqkdhens5TFaKLPR5fj5RpDqg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRj6prPTA9UhokiqKDpBPWt+TwIDGgvEIDgFCTon0ao=;
 b=eizTtvEhOfgVR915mfky4mH8XJtG6g6bqH/bsplLHZj3gN6GvxWBQ1kCU3Iha4oQT1T5LLyyusRI3+wMwL93Fs/YaZwYEkFSJLdX4fjUbDm1b3TEU77g5rcAZbfEY4ye9Z8Ej+VCk8g5AFT3R/C1Hpo0YE8+u3Lqo5qyh75WI59HjTTshYvgtKvqEEeEZeSiW55dJqWsBso3la3NhkPiWAACBiRmGiN8BJ/+7OuGias9fMrp7Qbu8N1xhqlMnW9Apw2RMZXdA5Mmzm1dtwfLbHK1liye4dXcecexDrxDsh7AdlJOo33LuSwSReaa0AAmP7xdwMSMi4oWRpB4YbyIgA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRj6prPTA9UhokiqKDpBPWt+TwIDGgvEIDgFCTon0ao=;
 b=fVZjGodLP30piro+P6Mm/9YO8I1759IKXD6WSqIEa/ns0uFqm1f/RN+2bOP17bmMy+cygWZ2inXJ+YWVJAwMzHbMSyKDpDNf2MFTrOR/eU8af475ubANkkCFrRMAtRcpsygtVdhcbUFyhAvlKAT4h9s8Q3k0R8PRfKP4DCQP5nQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 05f9a78c-8f37-4195-2cf1-08de635c130b
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2026 19:40:24.0629 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: ro7OYilHKOAF+BZ+YtDlwwDz+81vMRzeKeFeTyQ0HeP7+bCo27OgrafW91j0l5nCdOrCFyHZKwG9El/1JJ6dvA==
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR17MB7742
Content-Type: text/plain; charset="utf-8"
Content-ID: <1927E0179DCE444E98D8FDB07CC2333D@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=724 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE1NiBTYWx0ZWRfX25CAl5QQbBul
 qjoPsuZCLdXtL7R9J9mVVmZLeKNGzpvK3JxnAJju4TmxuiAmCS6/RVK8Nvs0/JVfkRJ4tbZeqj8
 Vtl9fkGMZ3Z1B0JNvQ7LS7xG7ZxV3wA+I3tE/KzLbTSJQOgpkTKTyDJ8vqsbmSjXx4wTjLsGlHj
 zGzhI89mka7Fq9ORkp5YkJQEoT+0EcTMc7KnbHD+Iywadw6ao7kaLSU/ATye8hxaRgMnWqzhsiC
 LbDWH4ocrpWzJPKhk4DT3K+uBbSqML2xee1pEoiTFVDmt+tP7qlovt7J2+bDo0ssRh+HpXpZYob
 PUYdQgSQP+oCkNe7/Veog/AW4XLavvzdoRphY0EJnUIzFw+Acq0pfSu4HrUuOvVmJd8DUSJeITr
 dhsIpRC0fysiNHvnFzsWZRFxJyaClBosnlfjdpP9BJ+6HVkDjurmu7yJdGeqdHckr2TvjSsfks7
 xfkqcat+6iGaRvVg8Ag==
X-Proofpoint-ORIG-GUID: bIfe5hx31_rcMz7IYcOt2WW1PAnHnUjn
X-Proofpoint-GUID: bIfe5hx31_rcMz7IYcOt2WW1PAnHnUjn
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=69824f2a cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rONOXi1tPahMzKl-kdgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030156
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

DQo+IFRoZXJlIGlzIGEgYnVnIGluIHRoZSBpbnRlcmZhY2U6IHdlIGRvbid0IGFsbG93IHZob3N0
ZmRzIGFyZ3VtZW50DQo+IHRvZ2V0aGVyIHdpdGggcXVldWVzLiBCdXQgd2UgYWxsb3cgdmhvc3Rm
ZCwgYW5kIHRyeSB1c2UgaXQgZm9yIGFsbA0KPiBxdWV1ZXMgb2YgbXVsdGlxdWV1ZSBUQVAuDQoN
Cg0KPiBMZXQncyByZWxheCB0aGUgcmVzdHJpY3Rpb24uIFdlIGFscmVhZHkgY2hlY2sgdGhhdCBu
dW1iZXIgb2Ygdmhvc3QgZmRzDQo+IG1hdGNoIHF1ZXVlcyAob3IgbnVtYmVyIG9mIGZkcykuIFNv
LCBubyBtYXR0ZXIgZG8gdmhvc3QgZmRzIGNvbWUgZnJvbQ0KPiB2aG9zdGZkcyBvciB2aG9zdGZk
IGFyZ3VtZW50LiBMZXQncyB1c2UgY29ycmVjdCB2aG9zdCBmZHMgZm9yIG11bHRpcXVldWUNCj4g
VEFQLg0KDQoNCj4gVG8gYWNoaWV2ZSB0aGlzIHdlIG1vdmUgdmhvc3QgZmRzIHBhcnNpbmcgdG8g
c2VwYXJhdGUgZnVuY3Rpb24gYW5kIGNhbGwNCj4gaXQgZWFybGllciBpbiBuZXRfaW5pdF90YXAo
KS4gVGhlbiB3ZSBoYXZlIHZob3N0IGZkcyBhdmFpbGFibGUgKGFuZA0KPiBhbHJlYWR5IGNoZWNr
ZWQpIGZvciBhbGwgZnVydGhlciBjYXNlcy4NCg0KSSBsaWtlIHRoZSBpZGVhIGJlaGluZCB0aGlz
IGNoYW5nZSwgYnV0IGdpdmVuIHRoYXQgaXQgbW9kaWZpZXMgdGhlIEFQSSBzbGlnaHRseSwNCmNh
biB5b3UgaW5jbHVkZSBhbmQgdXBkYXRlIHRvIHRoZSBkb2N1bWVudGF0aW9uIHRoYXQgY2xhcmlm
aWVzIHdoaWNoDQpvcHRpb25zIGFyZSBhbGxvd2VkIHRvIGNvZXhpc3QgYW5kIGluIHdoYXQgY29u
dGV4dD8NCg0KVGhhbmtzLA0KICAgICAgICBCZW4NCg0K

