Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34851C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEUu8-0007tD-MY; Mon, 12 May 2025 11:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uEUth-0007qg-K2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:16:56 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uEUta-0004bu-Sf
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:16:49 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CDUxYN004752;
 Mon, 12 May 2025 16:16:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=xJO4XK9nk
 qrtOmAA07agds2MUQZe2B4tUrS6LQ2+Sj8=; b=MJHsOhP75Prw1Xq78q7srWhhN
 Ly5kyJt7AWMO8ZpZhtK2ZQg9mjyhjVKRCEmv/71tnPPH/W4WrrWJ2kX45z+BKNlJ
 H8amUxXyA0JvmYPeYeypHL7Gm+zTdOHwjgzbxmeCd9hFhZX8GrhJt9NjIkOPP48m
 /RCA+Bno5k/dsklaYyN5qKu/RyqVxAo93bZh+KgSKvP6rsN36NA1LKJLI9f+BVR8
 bHCWbpU7wTjcBorDyab1cxyaEIbgbnXCsH9BCn6ZCfX88Z08w0pH9iTlahX4pDvg
 nwzeew5ENOmRyzN1O4gn7Xq+v+SEr6eEl94Mg7/94GN6nkLpwXJuHC4Bt/LCg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 46hup0jdsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 May 2025 16:16:38 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 54CCdSNI003625; Mon, 12 May 2025 11:16:37 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.201])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 46j24wfgqh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 May 2025 11:16:37 -0400
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 08:16:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 08:16:36 -0700
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SA1PR17MB4723.namprd17.prod.outlook.com (2603:10b6:806:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 15:16:34 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:16:34 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "beata.michalska@linaro.org"
 <beata.michalska@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>
CC: "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>
Subject: live-migration performance regression when using pmem
Thread-Topic: live-migration performance regression when using pmem
Thread-Index: AQHbw1DYBGrB/0pV9U+SV8KgfbE6+A==
Date: Mon, 12 May 2025 15:16:34 +0000
Message-ID: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SA1PR17MB4723:EE_
x-ms-office365-filtering-correlation-id: 5f2c808c-9c10-41e1-7880-08dd9167fb8d
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZTBmbW81QjZlbStxN2RqbXdCKy9uMkZyc0ZpNVl0QTgyUnhaUm5lbCtVc3or?=
 =?utf-8?B?WW11YktpKzZUbGJ4T0pzc0RPN1B0OVdzSWJRaGd0M2xDNFU0WWFWYlJBNGt6?=
 =?utf-8?B?MUdnbTdHWWJZdk9IczJwOE1Kck02TWN3UUlFalVhSC92OGhMd1RGS1N6SFk0?=
 =?utf-8?B?a01Ia2g3OWNpWHdJR3p3a3R4OTJhcTA2YVJQNy9jMUlKckx6dXJaOXA5TWhv?=
 =?utf-8?B?NmNqQlNUNkR1QmFQaXA0N1pTMmhGbEV4N09JNFdXQUpobmc1RXBRVFBmOVVY?=
 =?utf-8?B?TkpTU3VjVE5JZE9rcnFhVG83SkU4bkhvUVNKMzNYY3hSUk0xcXNHVThsKzJs?=
 =?utf-8?B?eUppT1p4bDhMbTE3OW1Vaml1dG5MamM0M00ySmR4UDBMU2pSRnlFczFaRUdk?=
 =?utf-8?B?R1RMczh0Z3RnSmJ3dVVIbHp0MUJzZFNLNmJ6bnZYSldIZ25RTEFvMGlqN1E2?=
 =?utf-8?B?cnplWnBPdTJuZ01zcHhiSzJreU4xSnE1aUtqaUVXTVpCMC95RlZZUTdUclZC?=
 =?utf-8?B?SkZHMHlUWFlSTytLblgwU3pqNEEvd1RtY2dWbFhMMUcwSXpZODBJandqUlkw?=
 =?utf-8?B?a3dzUy9XWnZrUXMvdFZqMjI4WUVkbThJN1NTQkFWVVAxenRTYVJPWFZxQi9B?=
 =?utf-8?B?N21XNkdZOGtrNUV3WkljRjRkNG1od2NiUVBkRGkyZnFyYWp4Q1RzcGFZdld5?=
 =?utf-8?B?MFI5M1NYMDVQSHYvTzNqSUsxZ01pN2dEc2hBNk5lREUrYmpyMzFDQWFYeWJI?=
 =?utf-8?B?blBsa3hKQlhpVVNMNnozMWU3eHczbVJJQkF2ODBCQzVwemhSYmkxQTRFTzJu?=
 =?utf-8?B?S0FjQmVQSlB2OVRBN2s5WkZMb0NmelhQZTE0S1JVTmU0dE9tQkxyRHdaK0xE?=
 =?utf-8?B?cFhOZS9EUDBtYjE0MFpZZEhoa05kbmltaFR2MmlFaGYvY3NSQkVuWW5LMkxZ?=
 =?utf-8?B?RFJtVlh5M0ZBcUNJRGl5S2wrOTh0K3MwZndQeTB4cWhZd2FmNHZDVjJ6NVZG?=
 =?utf-8?B?cUNWNDJNUHFMd2RMNEFnTnYraXdEeWZpVXdJZTlvZGJuM0VCYVdEcXFTRGdI?=
 =?utf-8?B?MDRRZ01mRU9oMFdMc0hXcUJzNUJ5Q2VnVFFtU2Y5YWVDY2FxbWxMTXNqbVFX?=
 =?utf-8?B?UFhKbjFtMnU0UFMxc1Q4V29BRjdoaW1OVlhueE5rSXpHcGtxV3FFdmlGeUI0?=
 =?utf-8?B?ekpiVytzOFFhNDIxdTRqNWFtRzNGaGppL2ZXeVJ1dEo1SVFIUU1hVnpCaCtG?=
 =?utf-8?B?dzYyeW9xRnlacHd6bmFweTE2VHNKMFpvZ0xPb2dkUFlyMVZzZHVsZUs2RndX?=
 =?utf-8?B?ZGNDWEJKTHhCc053dVFtY0lLcFIvd2VwdUhkSEY2Z3YyMXQvRTYrdERUeFEr?=
 =?utf-8?B?cGR6c2didXNWSHN2V1JWeWoxN0lhd0FRbDc1dzNRbm05UThSSlhDY3RtTG9I?=
 =?utf-8?B?dUt5NWFpM0tKbmdHYk9QaDR2Nkw4TitPcmhJVGViOVBXZGREU240cStSRFpU?=
 =?utf-8?B?YXVyWWtEWjVXMmhVT0tTeHZwZzdVY3hUQ21JUGMrMjE5b0RpdDRlUFhRdjhW?=
 =?utf-8?B?SURRUUtkd1NPZW5XSlRGOXk3WmpJYzE5TUphelhGSURiSVA3M0pHcGoyY3RZ?=
 =?utf-8?B?QTJFSitVWEMyQVNjY0p4VVVVY1JVM1g1UmtNdE9WUzh1d2dDdldwZTE3a3NB?=
 =?utf-8?B?dUgzZ0dpanNqeDZXZ0dOL3RzdGhvdUR3OExSRWl5dVZ2Q2MzT1ZSMms2Yndo?=
 =?utf-8?B?STZ2V1lObllTNGF4dS9WK29rZ2YyaVhRQU54amlLOUlkYk5BbWRZVnQvUElz?=
 =?utf-8?B?U3dOMUE4anMydXpTdmt6TWpkWWk3TmRENVZQT3Bpd1cxSy9tMytwMjBQczlB?=
 =?utf-8?B?bVNCYUs3SGhZTXNuKzRUZTFNdHg2bE1FN252ZUc4allHWVM5Vmc3M3NiTmlm?=
 =?utf-8?B?TFdHM0o5Y3VhNG5EaU4rR2lFMUY2T200d25xamJxYlRXL21TNXFGcGw1MXRv?=
 =?utf-8?Q?CY6H/0+rLtiKrBHkxwksgYqCugj/PM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmJZdzYrUTJrd01xYlF3ZHJURGZNV0QwTGVETUVPTTVGeXR5NGlYeUlOWUFR?=
 =?utf-8?B?TGVrRFg0anZibWgyc3d4MWozN000akxNTk9nbThUaCtZVEwyYWUrbE9KdXRp?=
 =?utf-8?B?bDJyRXd1VjNDUVUxSzQ4dFlub0wwZVBkNmdFZmJNMHlKbW1Ya2lVRGlpbHZW?=
 =?utf-8?B?NmkvT054WkRndlpBcTNKRXhrMDZvVVZ4QUliREY4V2lBOW9kRWM5UE1ZUTRO?=
 =?utf-8?B?eXFIRGtDNEl1MG1kbUxzYUhpbkh2V0l0WFBHMnNtMVlLdlRLVHEybHFROUZF?=
 =?utf-8?B?QXdURTd5UU04R09ya3JVZnl4ZDl1QzhZengvWkkvU3duWHRIbjRGM1czUWRh?=
 =?utf-8?B?QXB1SllOT2IzZTZaSW01Yk02eG9OcEMrTFRmZmNUYWNvcFYvZVlNT3F5OC9J?=
 =?utf-8?B?elpvQkZ3Uk9Baml4aWNod3pzd0tvdVZKL1FJRWNoeVZEN0NHYXdEM0wzZ0hx?=
 =?utf-8?B?TTJVaGpOSTVyWVE0a0RSU1dpcGRYdm4vZXMzTVBwQWNGSGR4RGFVWThyS05O?=
 =?utf-8?B?OW1XSkhObVY5TW5rbVpFeHAzL1BMVGRqYUNZTjUxLy90VHNyRzNRdlN1Zm9r?=
 =?utf-8?B?R2s0eXNWVWJKck5IU2JLU0xmcjNJS1NVUG1ZMmgza0ppVGZKY3I1dUZLd3Z0?=
 =?utf-8?B?NnFXbUJJdzhCR0NLclN2cmpFdHBlRUlwVHBKbGNtcFFHSlpYc0Q5V0pOZGhJ?=
 =?utf-8?B?dlBQSnVKYUx4SlRrak9BQ2N2clBZSnJ4YXk0OHA2MHphdHZVb3dta3JnUXBO?=
 =?utf-8?B?VTRBZkxZNFNjZ1kyWkFtNHVqZ0lVbmV2Y1JuM3lkdmlSamJGNC9CY2UvbmFG?=
 =?utf-8?B?cGJ0Qld5TXlaZmRVMzRQeGF3MkhaVWxhcXFGMmttNTZmeDBTYkxST3BZVUEw?=
 =?utf-8?B?YmRjNVhPTkZ4OVIzRy8xWnZGUXlDYkpENXZEY24wNlFyTVE4cGkvREtZWkkv?=
 =?utf-8?B?ZkhlUkFkdW96S2xGa1B0NkI5Z1Zjd0ZRQlBHMHFTUlVZcFZtTDQwSXc2WXdP?=
 =?utf-8?B?N3BFNVhCWWhWeFRMbllDcWVsbEt4Yy9JNCtXVVVEL1JPS3ViT3lRUkJwVDU0?=
 =?utf-8?B?ZnhrSUZPWGFDQThJN2RQaVFNWGRZMXFZd0YrUGNPNWhoTjdHdFZ3Ujc3aW51?=
 =?utf-8?B?SjZBVnhSb3h6aTlyd21JTzhuNVFjcjc1ZjdRcTk0dHBzYWpEVVh4UWpFVUJ1?=
 =?utf-8?B?STVpby94YlF6cnV2R1d6WWRHQWovcWNnUzBWbWFMMkE0ckpzWTBxb1NTbVhl?=
 =?utf-8?B?MXJPL0J6TnJsd0RnOUNlS1M4dzBUN0hEbmJ2MS9YK0NrVnhJK3FUOSs1STU1?=
 =?utf-8?B?TDArRlE2aEdPbEZWbU5GYkNYK2VPZU1jME9hVDVrU053OU41Mk1MMzVubkht?=
 =?utf-8?B?M0hBZXZBaFBzdXBhU0FnU0EzelROYmhFUmF2cUx3eDVySTFjVWdad0dnU0Zo?=
 =?utf-8?B?Ykd5VjZDNitOenJmMUZKcXBkYkYxT0ZIcFR3WHltREJTVDZHS3ZhNjJoTUZs?=
 =?utf-8?B?OUJ2bWI4VXU0NWJPR2R3NUhjK0VGK0pVWDErdHlUZk1lOUdVSWpMRG5NY0hh?=
 =?utf-8?B?aXZNUDJlM2FiWTlRSytYUTJTNHlvQ0xhSG9reVFnUFNjV3R3cVhrcG1sZEVX?=
 =?utf-8?B?WnRQYm5tc0VZNjFGR2hlTG1uZEVOUmVPenZNYm81VHprQWxLcmFxRDUzMFEx?=
 =?utf-8?B?eVVnY0Q2ZDdyZG44dEk1bXVhL245QytGS0QwK3lkbjhSdDh6eTd5TjlxYWlz?=
 =?utf-8?B?SjFMMjc4b3BnOXhlLzEyZVdrLzdnRjVWbVg1Y0JBeXVKZE5WTmV0ZWs3YVF1?=
 =?utf-8?B?WW1XOXhpamR5cnBxMU1sUHJncjBOb0FCZzVBRmxXUVRrU1ZWY2tyZ1hvL1Qx?=
 =?utf-8?B?UEFucmRGTFBYeElpcFlTUVErOVExODV6aHBld0prZE84SGIxbVdLRldjZFJa?=
 =?utf-8?B?akZuRE1qcTdYUU5xbjFOSnhFL3FhOUZLMFEyS2lmbjRHU1NWK1dRWlFGR1Nl?=
 =?utf-8?B?QTdaNjhIVDV2Sk9VMTRVYjFWbTdhMFBvWm9IRVltTUs5RGUrbzR4a1pvZ1c4?=
 =?utf-8?B?MUFDQk9NSHhmUElNR1UzbjNCODZDeHpyVTBLVDdzcVA5WU9tMGF2RnNJSTVs?=
 =?utf-8?B?Ui9kVEpsaUtoSTFKRXV1cGFzZWhaYVpqZHliTlhVSDcxRUY4MHJKMGEzNmpQ?=
 =?utf-8?Q?E/qxC5QY6VlH4g1Lyt4aQFneB/6N2HpV74L877WkiVro?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHGVKSRZHdVB4eYdUxLM0Giykftcm0NsXdM/aWa07Ms4fv84i4psVqpQxTo2Hnv7UAXm3rrwCYFaoO7BJ36HL7Muyy/6tj9aGlNgiW0Ok9yJjXJky0+y9q8nZgczNZicsZ8kSq2Mgmxq+Xkp+//XBh6N9fT2t4Dnca+QomEG+pU8V4y6gZ0jtVekQSIlMEQun6Nortds/aasw6biSyCSV/G2MOp6YP+uSlIUbFvNIb451j7bi4XoZJAXe4jXcO0hndXVx9X8iHbLE8xs8Ig2MxMlkeGDFHiJbIkYlJjsUMRqIBs2R322UWynxUc1iUHgw3/6JEMowJ4vnp7mwf05KA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhan7XpJArHRhkqiQspY6wPFUYRkO3LGXKLdWlZeLa8=;
 b=DE3ojcwnERtjaT3dLPrKEjuivTu1lvJI80MpjnLY97unBTHIZ5OJ35kCd2TYRrj5Sy5VEkQeFe9h9pzn4fSyrzv3/7HYPgNZOcZQPLK7H53LZkSYrJWxUA+ZM46bm4ZHFeE+SM1iOhPb+5r2WJYxC0VNXeI0RkQrAJB5n5hUbyEuAlzk3m2v+rjQKz5Gxv/XssYJ8k9G3I5PmbaM0Z7JB7Lb5HTsW+9ANGSjosWmUKa+1HXsKrLwOHhWrBBPpwwgnSO0XdVBoxOhH/LwxfRt0nf7y4OXwQsVfxoaLPuFTHedgmcixtO2kU6knkBquFXnBrAr1Fr2fSK7Npb6ju4k2A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhan7XpJArHRhkqiQspY6wPFUYRkO3LGXKLdWlZeLa8=;
 b=ahqe9w9nx1LeZeNgRvOBSpxeDbCJoqRUEtgdW/oroE1rFOOo0ZzR5bZ7bBWWbiixsgKVjXw4M8i/nekEY2aKup467tfy8GvMAF7S5EhlQBc+ITT+SqXULC9dlgXeOZfFRsVd+v5ds1WOBjANnbyXTQjafJ4hNeyA46NCFdGeocM=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5f2c808c-9c10-41e1-7880-08dd9167fb8d
x-ms-exchange-crosstenant-originalarrivaltime: 12 May 2025 15:16:34.4258 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: DJdUuM/24ilnfKuno5vIVRldFPuY1ZootcdEriLRmlJTQfNpi0z7JW9LuQigy6fuo68Nq/L8W6T7LHKXzbpq/w==
x-ms-exchange-transport-crosstenantheadersstamped: SA1PR17MB4723
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <A374CF498CA53E4685515B1C0CFFA52D@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120157
X-Proofpoint-ORIG-GUID: TwaMiAQzsQZhuuA6vpJ7_mMMeY6lONde
X-Authority-Analysis: v=2.4 cv=bNsWIO+Z c=1 sm=1 tr=0 ts=682210d6 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=g1y_e2JewP0A:10 a=FIPV05cCEE9PGa9HWUEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TwaMiAQzsQZhuuA6vpJ7_mMMeY6lONde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE1OSBTYWx0ZWRfXwellHEP7da/2
 is5ZxALGJWiLQlFZrqoFoHCExWu+WiyKm/lt5Ct6y86Cu01JgJYaycVNEgzW1MkAOar1Ghnk8MI
 z1vZ8PY2vkVEixpsmLtQUNCAeO19pbN+f8P+Kd32ar26Hj67kikombb3eanT+5HwTKZqbNyFjdV
 YdbkOB+wae5Ewuyt9DAGxJALcWy2NyiV5wmjRZ9dqb80stNdBKpem14fUyEaoYnh2IwDfD2uEcz
 /E4a3DLE3C5tiIqrZiyGF1cJybLaTRZzWDe3YRU6SY42I2jAMNooA/4dQub2foudE4NyvDF528y
 U9/5Wi5G5Ibv46CReNekI/DJFRZcdqbw7oKBL+a/A1NwWXCQvBVpKTUCq4iodNrr2Kg7CAA1zGS
 mEx2o5fnZUQGr8w14NgAcZ+gEmal5y7SFTW+4o6rCqQLpiV3ONl9d7HXNUsgVncxT1m6zPtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1011
 suspectscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120159
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGVsbG8sDQoNCiAgICAgICAgV2hlbiBsaXZlIG1pZ3JhdGluZyB0byBhIGRlc3RpbmF0aW9uIGhv
c3Qgd2l0aCBwbWVtIHRoZXJlIGlzIGEgdmVyeSBsb25nIGRvd250aW1lIHdoZXJlIHRoZSBndWVz
dCBpcyBwYXVzZWQuIEluIHNvbWUgY2FzZXMsIHRoaXMgY2FuIGJlIGFzIGhpZ2ggYXMgNSBtaW51
dGVzLCBjb21wYXJlZCB0byBsZXNzIHRoYW4gb25lIHNlY29uZCBpbiB0aGUgZ29vZCBjYXNlLg0K
DQoNCiAgICAgICAgUHJvZmlsaW5nIHN1Z2dlc3RzIHZlcnkgaGlnaCBhY3Rpdml0eSBpbiB0aGlz
IGNvZGUgcGF0aDoNCg0KDQpmZmZmZmZmZmEyOTU2ZGU2IGNsZWFuX2NhY2hlX3JhbmdlKzB4MjYg
KFtrZXJuZWwua2FsbHN5bXNdKQ0KZmZmZmZmZmZhMjM1OWIwZiBkYXhfd3JpdGViYWNrX21hcHBp
bmdfcmFuZ2UrMHgxZWYgKFtrZXJuZWwua2FsbHN5bXNdKQ0KZmZmZmZmZmZjMGM2MzM2ZCBleHQ0
X2RheF93cml0ZXBhZ2VzKzB4N2QgKFtrZXJuZWwua2FsbHN5bXNdKQ0KZmZmZmZmZmZhMjI0MmRh
YyBkb193cml0ZXBhZ2VzKzB4YmMgKFtrZXJuZWwua2FsbHN5bXNdKQ0KZmZmZmZmZmZhMjIzNWVh
NiBmaWxlbWFwX2ZkYXRhd3JpdGVfd2JjKzB4NjYgKFtrZXJuZWwua2FsbHN5bXNdKQ0KZmZmZmZm
ZmZhMjIzYTg5NiBfX2ZpbGVtYXBfZmRhdGF3cml0ZV9yYW5nZSsweDQ2IChba2VybmVsLmthbGxz
eW1zXSkNCmZmZmZmZmZmYTIyM2FmNzMgZmlsZV93cml0ZV9hbmRfd2FpdF9yYW5nZSsweDQzIChb
a2VybmVsLmthbGxzeW1zXSkNCmZmZmZmZmZmYzBjNTdlY2IgZXh0NF9zeW5jX2ZpbGUrMHhmYiAo
W2tlcm5lbC5rYWxsc3ltc10pDQpmZmZmZmZmZmEyMjhhMzMxIF9fZG9fc3lzX21zeW5jKzB4MWMx
IChba2VybmVsLmthbGxzeW1zXSkNCmZmZmZmZmZmYTI5OTdmZTYgZG9fc3lzY2FsbF82NCsweDU2
IChba2VybmVsLmthbGxzeW1zXSkNCmZmZmZmZmZmYTJhMDAxMjYgZW50cnlfU1lTQ0FMTF82NF9h
ZnRlcl9od2ZyYW1lKzB4NmUgKFtrZXJuZWwua2FsbHN5bXNdKQ0KMTFlYzVmIG1zeW5jKzB4NGYg
KC91c3IvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYy5zby42KQ0KNjc1YWRhIHFlbXVfcmFtX21z
eW5jKzB4OGEgKC91c3IvbG9jYWwvYWthbWFpL3FlbXUvYmluL3FlbXUtc3lzdGVtLXg4Nl82NCkN
CjY4NzNjNyB4YnpybGVfbG9hZF9jbGVhbnVwKzB4MzcgKGlubGluZWQpDQo2ODczYzcgcmFtX2xv
YWRfY2xlYW51cCsweDM3ICgvdXNyL2xvY2FsL2FrYW1haS9xZW11L2Jpbi9xZW11LXN5c3RlbS14
ODZfNjQpDQo0ZmYzNzUgcWVtdV9sb2Fkdm1fc3RhdGVfY2xlYW51cCsweDU1ICgvdXNyL2xvY2Fs
L2FrYW1haS9xZW11L2Jpbi9xZW11LXN5c3RlbS14ODZfNjQpDQo1MDBmMGIgcWVtdV9sb2Fkdm1f
c3RhdGUrMHgxNWIgKC91c3IvbG9jYWwvYWthbWFpL3FlbXUvYmluL3FlbXUtc3lzdGVtLXg4Nl82
NCkNCjRlY2Y4NSBwcm9jZXNzX2luY29taW5nX21pZ3JhdGlvbl9jbysweDk1ICgvdXNyL2xvY2Fs
L2FrYW1haS9xZW11L2Jpbi9xZW11LXN5c3RlbS14ODZfNjQpDQo4YjY0MTIgcWVtdV9jb3JvdXRp
bmVfc2VsZisweDIgKC91c3IvbG9jYWwvYWthbWFpL3FlbXUvYmluL3FlbXUtc3lzdGVtLXg4Nl82
NCkNCmZmZmZmZmZmZmZmZmZmZmYgW3Vua25vd25dIChbdW5rbm93bl0pDQoNCg0KICAgICAgICBJ
IHdhcyBhYmxlIHRvIHJlc29sdmUgdGhlIHBlcmZvcm1hbmNlIGlzc3VlIGJ5IHJlbW92aW5nIHRo
ZSBjYWxsIHRvIHFlbXVfcmFtX2Jsb2NrX3dyaXRlYmFjayBpbiByYW1fbG9hZF9jbGVhbnVwLiBU
aGlzIGNhdXNlcyB0aGUgcGVyZm9ybWFuY2UgdG8gcmV0dXJuIHRvIG5vcm1hbC4gSXQgbG9va3Mg
bGlrZSB0aGlzIGNvZGUgcGF0aCB3YXMgaW5pdGlhbGx5IGFkZGVkIHRvIGVuc3VyZSB0aGUgbWVt
b3J5IHdhcyBzeW5jaHJvbml6ZWQgaWYgdGhlIHBlcnNpc3RlbnQgbWVtb3J5IHJlZ2lvbiBpcyBi
YWNrZWQgYnkgYW4gTlZESU1NIGRldmljZS4gRG9lcyBpdCBzZXJ2ZSBhbnkgcHVycG9zZSBpZiBw
bWVtIGlzIGluc3RlYWQgYmFja2VkIGJ5IHN0YW5kYXJkIERSQU0/DQoNCg0KICAgICAgICBJJ20g
YWxzbyBjdXJpb3VzIGFib3V0IHRoZSBpbnRlbmRlZCB1c2Ugb2YgdGhpcyBjb2RlIHBhdGggaW4g
TlZESU1NIGNhc2UuIEl0IHNlZW1zIGxpa2UgaXQgd291bGQgcnVuIGludG8gYSBmZXcgaXNzdWVz
LiBUaGlzIG9uIGl0cyBvd24gc2VlbXMgaW5zdWZmaWNpZW50IHRvIHJlc3RvcmUgdGhlIFZNIHN0
YXRlIGlmIHRoZSBob3N0IGNyYXNoZXMgYWZ0ZXIgYSBsaXZlIG1pZ3JhdGlvbi4gVGhlIG1lbW9y
eSByZWdpb24gYmVpbmcgc3luY2VkIGlzIG9ubHkgdGhlIGd1ZXN0IG1lbW9yeS4gSXQgZG9lc24n
dCBzYXZlIHRoZSBkcml2ZXIgc3RhdGUgb24gdGhlIGhvc3Qgc2lkZS4gQWxzbywgb25jZSB0aGUg
bWlncmF0aW9uIGNvbXBsZXRlcywgdGhlIGd1ZXN0IGNhbiByZWRpcnR5IHRoZSBwYWdlcy4gSWYg
dGhlIGhvc3QgY3Jhc2hlcyBhZnRlciB0aGF0IHBvaW50LCB0aGUgZ3Vlc3QgbWVtb3J5IHdpbGwg
c3RpbGwgYmUgaW4gYW4gaW5jb25zaXN0ZW50IHN0YXRlIHVubGVzcyB0aGUgY3Jhc2ggaXMgZXhj
ZXB0aW9uYWxseSB3ZWxsIHRpbWVkLiBEb2VzIGFueW9uZSBoYXZlIGFueSBpbnNpZ2h0IGludG8g
d2h5IHRoaXMgc3luYyBvcGVyYXRpb24gd2FzIGludHJvZHVjZWQ/DQoNCg0KVGhhbmsgeW91LA0K
ICAgICAgICBCZW4gQ2hhbmV5DQoNCg0KDQoNCg0KDQoNCg0K

