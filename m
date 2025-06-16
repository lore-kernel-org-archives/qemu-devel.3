Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1494FC71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 19:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRFjl-0003xr-04; Mon, 16 Jun 2025 15:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uRFjh-0003xX-3U; Mon, 16 Jun 2025 15:43:17 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uRFjf-0003EX-0m; Mon, 16 Jun 2025 15:43:16 -0400
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 55GAOC8j009608; Mon, 16 Jun 2025 20:43:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=qkiwZwLG2
 XW6FAEqiOFMk9WWNuH9NcTbphtyEGXr1bA=; b=g5ilzt9fNPS09Lch7vWs1bXHZ
 4KbiXjr65k5sRsC35qbbCqW9JqJsQ9pgskcp43z+hZVc2XiyeoM1qoy0iRa2Bwks
 uJstA2NOtVQN2YS5UHn8FVy8ZF313qeX59zlUXb8YFBCb7DG/ty2p3bDoj/SdSJd
 3gqQsrht2Lj+JvSNgnILRRzhZi4jLGyxg4VTi+4HEuVotyxytpmAcmWArdidsJlW
 iZdBqYhKxP/sHarKxpzzsDBO9TDhRdPXD7rUpv+4DHIDKdhPsLM2S/7LBaTSrUoa
 QFkciu5EKJsSK/aeGeH+L3cU8FpkCQp45r+Fr8JIn8PPnWH1ZxsYoXH05rVBA==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60]
 (may be forged))
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 479jdw2ayj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 20:43:08 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 55GIcfnw021332; Mon, 16 Jun 2025 12:43:07 -0700
Received: from email.msg.corp.akamai.com ([172.27.50.206])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 47972ahdqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 12:43:06 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Jun 2025 12:43:06 -0700
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Jun 2025 14:43:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10 via Frontend Transport; Mon, 16 Jun 2025 12:43:05 -0700
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by BY1PR17MB6784.namprd17.prod.outlook.com (2603:10b6:a03:530::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 19:43:02 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 19:43:02 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "yury-kotov@yandex-team.ru"
 <yury-kotov@yandex-team.ru>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Glasgall, Anna" <aglasgal@akamai.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: [Patch] Don't sync volatile memory
Thread-Topic: [Patch] Don't sync volatile memory
Thread-Index: AQHb3vbfaBRDRG/7dE6gY1mmDUji3g==
Date: Mon, 16 Jun 2025 19:43:02 +0000
Message-ID: <7987BFFC-D46A-4BAB-8973-F30E6689E05F@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|BY1PR17MB6784:EE_
x-ms-office365-filtering-correlation-id: 997f0f58-d432-4d12-c325-08ddad0e01c4
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eGZIRm5Yd3BGZG5NRjhEalJMOUFWc2d2TlNkUDBZSmdxVzh3dERuNG0vUXhQ?=
 =?utf-8?B?cWdiZUtwZWdTUUp3OFpiU2JCR0VDaGNrOWdFUFpXOVR5MThuWk4yNFBIRm9t?=
 =?utf-8?B?VTNwcjNPQzFhZ20rbGwrTmEvN1FVY3JHVGRzNkVPaFlKNjdCRW8zRTRMWEt2?=
 =?utf-8?B?MUFyWUxuR0ZDQlBMUUJrQTZVUFh0UFFGcDhOSTVuU0xub2tDdlZkNzlTc2Iv?=
 =?utf-8?B?M21QcjRwem1uUGdLdmtBaGJHbHU2VEdmNDBTcnQyS3ZKZFFjbDZxc1BKQTRl?=
 =?utf-8?B?NUduN2pEcG00RUNzWWx1dG5uVnJmcExhWUVtNTdwQURMeVBPY2hWZ3hYbVhu?=
 =?utf-8?B?VEl5Umk1TGtWZEtSbFMrcVBTck1jZExLazRRZmZaczlXSDFjbk5MdDZoL1Mr?=
 =?utf-8?B?eTNXazROUlVMelBMeWlhM2d1NHkrc05DM2RSRXZVMzVOYW9hS3FMd0pXS0lr?=
 =?utf-8?B?blVKYS91a1N4UlRBNlVLY0RFclRWYzFaZUJORXNCcjhwYXZhb1cxdWxFL0hi?=
 =?utf-8?B?b3pxcHh0MVRJalU2SnJTL09NUEFmRzU0cjRZQzZ1S0ZTV0N6VTBHc0dhcjc3?=
 =?utf-8?B?SWpWdXBBNldmMkFMdyt0TkliUFNHUlJKdFd2SmJRVFRSNUdFeFhXQ2V5Mzha?=
 =?utf-8?B?Uzl0QmtZaWxuRTJMWFYwenBlTi80dS8wTVhhOWVRU3l3RjJSdlpIN0ErY0lK?=
 =?utf-8?B?R2V2MlB2THhISDF0UWhFZDJmTjBaQTVXbFhQb0xsQVN6VmMrWnJJM1RzeFkx?=
 =?utf-8?B?cm1aL0RmZnhVT1kzbDlPVlI1eTZDY0xLN0lYc25JYVNCSmFvWklhUlJOaUlv?=
 =?utf-8?B?U3BvQ0Y3TGZIMFh5U1RvTzFybHpDb3REaVJWdExGRDN2aWtpRlFqTzFCVll4?=
 =?utf-8?B?Rk9kdEVpUVFzZ0tRTXR6SlVabjdJR0dQTllTYjBGOUNxaG1oc1NiK2JMMko1?=
 =?utf-8?B?OFBVN1JvM2J1SFQ5bUVuRzZqc3NNbGZPQ2syRHQrcUIzK2dFZWFMSGdvQkJs?=
 =?utf-8?B?d1VpN1BxSUp3ekphdnlaemdzZTRieVlwSVcwOXZidG16YnluNGlLRElmdFlr?=
 =?utf-8?B?bGVteHIyUC9mR0VkSlBOa3NNRlJ5S2xPMysyajFDKzZjYkhPVXkwZ0RDaFlu?=
 =?utf-8?B?aVZ3d0p5VnZueHE5ZkpENk5Xa0pabjgyV0lpOTlUMExPZThzQ0tTVEs3SXdS?=
 =?utf-8?B?RzZzaUQrSEdpV1ZmTW9lcGY1RTNtcjN5THV6T1h6bDE3YVpaU0pUV1htL3RZ?=
 =?utf-8?B?RHNrTlhGVjc5M2diSTdCOGVIWVVWZmlGc0R5SkYvbXFhUG1QUVFSSmErTVEw?=
 =?utf-8?B?cXFIZGorbnZldGYzOHEvWVp4SnJpczArT0hlQzJKSFlSQnFyRWh0WHZtVUpz?=
 =?utf-8?B?SDlkN0tnNlhGRzFlMWR3NmFQUW9zMVQ5Ync0V09wMGdqSjZrUjlFSUJ3UDNW?=
 =?utf-8?B?bkVqVFVzNzJVS3prTjNmRVlkMHA5SE1FV3hKQTZzU0tsT0VER3JjVklhcG9q?=
 =?utf-8?B?blVJUUQyOExWbE1XYkY0T1JPUjRqc05zVjRQaUYybldlUTZwb005V3BHMXJS?=
 =?utf-8?B?YThyeFFxY21KOHRjSXc1ODM5dGxwT01uQmFpZU5rQ1BETUFVWVU1c0YrVkRz?=
 =?utf-8?B?cUY1bkNVWDB4cHVMSXNqMVJxVnZkMm9FeVdySytlVXNHdEJRRHl4R1lMYkc4?=
 =?utf-8?B?L3FIV0JpR1RmSDZtWkpOdm1qQ2NpZlFvL2d6T2l0emNGZ1FsRThueGhIcEJr?=
 =?utf-8?B?NEtjRlZlY2pwY3h3bkhsWlE5QUdaSzl3Z3lHUkN0ZmEwUzlVZ0hIZ0VudDVl?=
 =?utf-8?B?VjdMSFpnR2hOWHAwZFNpdUtnWk9rVkxsRWllOWEySUdvcll1WVdwM296UDVl?=
 =?utf-8?B?YTFGeGJMdThpRmJkRVVYRkZ3NTJlaGRBRjZiT3I2cm9wVmc5MElPaDV2ci9K?=
 =?utf-8?B?ZUFsc2J2UzllUnNWS0NsaWhVeE0weVVKdjk1dVRRdkRhVEZqdHUzbGk4NWYr?=
 =?utf-8?B?b0lMcVBEdkxBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0p2N2RPSkp4NFNlcE9VOWUwWGZSYXNWbHB2cVdzbEVDcm01Zm9JaDFudFN5?=
 =?utf-8?B?NEczMXgrQmRTcmNpM3JnckJuNHRYcVNMWDBuM3dtVzZhUHdnVGhaVmh0LzVR?=
 =?utf-8?B?L0EyMy9ibVNuenEwbWpKUFJxZHBQOHdxamoxUkI5bGVLMlpIRXVGKzN0eHRY?=
 =?utf-8?B?Ym1ralo5VXFoVC91MGpWOXpiU29IbkJ0OHJhNHorVDhlQ1ZjQmpaaHA0VWRp?=
 =?utf-8?B?S0hrN3ZOdVNERFErS2lXOHE0ZHg2SlowZ0pqMHVQTXBvWSs2NHdHN1IzNTN2?=
 =?utf-8?B?NCtOeTNpMWVYWkJ6VWhKMmdOVkJSaW9hTFY4Rnk2ZFo1YXFkMThYQTlqbVF4?=
 =?utf-8?B?RUpUZU1qZmhtUUxCV3YyNnVJcG5HTEZqcktPWTJVUkh2R1FZMWhKTGtNcUR2?=
 =?utf-8?B?cUlKSmhwUFh4TVBzNXk4cmhLL3cwL0E5TzYvU3g2NkxnRmRBd0s1YnZoSEFB?=
 =?utf-8?B?cHpEdmVlcEc4UC9MUkNaRDVqRXpUTThjZWVEWGlDR0o2MmtleDBXd3NNbHFU?=
 =?utf-8?B?cTh4bDFRdlljUjVsR01ySE5kVW1KczB6ejh4M1Q0RFpHbUVkb25LTjhKQjAw?=
 =?utf-8?B?MnhmM1FwWlE5aWRHelRzdkRoaEpMNVhOKzBFQzhoMGh5cFJ0bUZ6M3k1NEdy?=
 =?utf-8?B?SGlwVUIrRTF0dGNkUUpkMHRCakZtRGR6TVk1YXVRbVdZaDl1WE05bzZKY2xY?=
 =?utf-8?B?QzBnUG1NZU80OXY4MC93WmU4ZFdDWEUrSXRaVUtuaENrZFJHTjZyK05ibHkr?=
 =?utf-8?B?SWRVd3dzY1dyYTlZbG9ZNmUxYkFHZUhpTTBPa0tHbG94VTdjS3creVcwUGtk?=
 =?utf-8?B?dk1CTXVNMElXaU00NXVTT1hVRml2Q2d2UThtVnV2RlQrNVJiNDlYL1IzT1Jo?=
 =?utf-8?B?Z2wzQ2QwQjkrSmdLVjVXTFMvd0lHRHR2c3R0a1dyV1lIOXFEOUEzUEViWjda?=
 =?utf-8?B?a0lpV01XTVFwNU9OZDhnRFNpTzJSZnEzQVl3aG5vU2tCeTRLalJ5bzFxelVY?=
 =?utf-8?B?TVY1NTJES1BXajljWW9aenRRcE1oalJBRThmNFFSamRGRzhuWU5pWjZ6djNm?=
 =?utf-8?B?VFM1RkFhZTBFb1hSeUxseHlZb2VLeGFEWUFFbmVuRjliaWFWZVAyNE1oMDAy?=
 =?utf-8?B?UnNzK0kvcVR2TDRtd1FUeUZkMnBMdU9GRjcwcmJ6MEZJSXBmWlIyQkxJWDU4?=
 =?utf-8?B?RFJTUys5SkR3b2xoc2NlRTh1bFAvdi96M1FaT2pBQ2F2ZFgxUGpJdFJuOUpU?=
 =?utf-8?B?Vit6QVdTakF5TEw3OFpkdjgySFlRaUpiSTBrN2NVM3NGY1dqMkdyVWRBZFZV?=
 =?utf-8?B?SjJLU3F0MGtJV0tDUWNzUnMrQVdJZm92cWtHdlRsYnZ4QlZCSzIwZHdNVEJ1?=
 =?utf-8?B?ZEhTVGpZUk0vaW9MdkhFZWJtZVVQVXNRcFBJeURJSitmQ3ZaalM1MXNMcGxy?=
 =?utf-8?B?RWtidno1bi9zUzZvNnRVT2dib1llTG1lWWNVTmxERVNtUEJ5Vlhzd0tUTzJD?=
 =?utf-8?B?UkZ1Y3ZORmFvRmFDVm9MSDBsYlMrUTBuK2FlemdXOUg2YkVnMTcza0dNU3pH?=
 =?utf-8?B?cGloRFk0Mm9Icks1aXRDV09ZOTBpWHdHTktNbEhrRzl2aXNPQy9ucHl2ckNt?=
 =?utf-8?B?SHI1V3BSK3BTSUE4SEQ0THlvYzBwL1c4RGNPeEFYTHRsb3doa2pWOVgvTVBK?=
 =?utf-8?B?SEJNcGJHbm80OXJjVW14SlJoUGwrMmNUTHVMOHFKSldxVldtL0NqckJvTksx?=
 =?utf-8?B?WjRCcXRhYVBrVEZwWmc1c1l4U3MzZzR6OGFyZmVVYmNZOVBFNWNWQ2lpRml2?=
 =?utf-8?B?NEMrbkJPdUg2MWt2MThWTXo4eS9GQ0RMSnZQWTFGY2tId0o2K2s4eVB3SG02?=
 =?utf-8?B?OGQvaVFhUUlZZ1I3OFZuS1dXT3JSY01BS1RHd01wc1hCdXZ3T0RUTUR0cXhw?=
 =?utf-8?B?amsrRWoyWnRmWHlZakE1NXRrbWYrSGMvUFMrMUljaDl0andDT3hRWjhLUkZQ?=
 =?utf-8?B?U0lNMGZSOXhqOGFvNHlNNU93ZUlXVjRZcEs3eUZFM0hjY2xRdUFHN1ppREVG?=
 =?utf-8?B?MTFSOXJTVE9rZVJFVXA1c2JqNGE2cUtxaFlaNlp1UlZlUEVBRThtbTJrdUlF?=
 =?utf-8?B?NnZrYUNNNEZwTmMreGFVWXNhckRQQ1lYY3gxa2NySVliSEJsbW5rRDFtMm40?=
 =?utf-8?Q?BaIipAIEUN9pGt/doNSj/m4nQdRz7zhk1LweklCnyaeb?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/yEUrpEp0Gn/rI10aTJbvNM0WbBf8rn38Hz31y62O8duMAGgsXZvSNq48Wyoz7Fax2uFlQStX538T6rnO7K8iKqd7u+Zbmp8OV4yDRkXgEWaWyww7rW3TDOYpDS2aTgnvlyjf3rSgEcb62/Y3aRv/80EfwvTfqXWG5Pt+cpeoG3JbQIz0Lavz+iCGbzBIMQgnsj6OhLKxpLuovIRqpj0x4Noinu+doztwACDX5Qk2BO2xpoQVwuIZlzwlw3l4PAy1roYJ+1DtjPjZ6Zx477hNiGJE5OPsmX/pmwLYL2kGAUVWKuzuGy5mLd1AvNZ5f7+alS6Rqo+DrZEyM7CnPvww==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAqTNWm2aYXg6mcT5BLiHmSNrqHuEahXECEpHVvLst0=;
 b=cBkEQtZjxokiZPSz5BsI3L7T5BcW75iNb3+UWPVgleNxNt/8l2QFXwi0otAuAeNK1T+ljEhLenL/ScMGdyujH134+8KGd+guUsqapfb5CdPIjWyyczetMonsoTUaZsVZzSpc03eomB6KY1mlc/KReWolvWo0xM+qv99m4Y9FP6EtPcUgfC3aSNVTY0P+dBBZTQESGNWqFsY/RBZNUso9tro+XD9LW+Bf16rQ880RAWWuf4OyfoGT5rJhsOMhSkbvOpafxjkibkAiJDsY2q/D9DtTJ95mdLz4TvjYegxEoiEnvBm14oHTkthpqPRprnzSS2QDJpTnTjpbnNe2kkO5cg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAqTNWm2aYXg6mcT5BLiHmSNrqHuEahXECEpHVvLst0=;
 b=CIMDCo2ipOQamqUsUMESgXOo6DvFf2bdI0UKNFalymsZtYZot7m+jlbJ15in/4M9VhBhiUQlNfqefBXdjhWPjGOfkXHrl7RwSfNP6cv/jZGYH0v5G6QsTDtQTSbka5S0Fm9ksuQ6IJ4mnuGHouW6DXFPTXGw2je8ajzohhD4L3Y=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 997f0f58-d432-4d12-c325-08ddad0e01c4
x-ms-exchange-crosstenant-originalarrivaltime: 16 Jun 2025 19:43:02.7016 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: m1GPYAzueL2uilCdBHCJeI9ifC20qU/mUxHsbVFK5nNgLutOcwvRGptqs8ZlYNvDZ6SEHMpKEjOJ0Ce815y6eQ==
x-ms-exchange-transport-crosstenantheadersstamped: BY1PR17MB6784
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CE3C6C85FB8454792EE86D43D542A68@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160134
X-Proofpoint-GUID: 0D4gz4rzig3Tjq4zb2TltIwh8sbW9lxM
X-Proofpoint-ORIG-GUID: 0D4gz4rzig3Tjq4zb2TltIwh8sbW9lxM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNSBTYWx0ZWRfX5tzpv0Y3bQ0c
 rEPrkNBG1K0bxonsK/edGbvKZQ3E9QLPghMBpJU48wJmw2He6UnSCnzgpf28wdIi3qXqNFh87DZ
 Lze+f+vTLrtU0a772xs4lW6V3alz42uafGoW+iIx75PPTE/kG7EvmJESG+sv9oI16c4r7VQrXex
 SUE5zLBq86vGsaxi6f92EYgpFAa5usd9+ooWWDJ8uCXevX/ZNEx7YeovZUzUahIXgw+kWn66p36
 RvKNjlvPm2y88NagpUXUQQM1a9nsENk3PAOmMniYhX43Cqd7v+H1JQxBi8RuEzrUPlsg+aXLO8p
 ddqb+FiOA2rc7nSuKOAG24HVYfg3JZFb1IRZz//qikdQZqqONsjCQR+k6m89Tdnd7IcfO6f8gfu
 dxocEp9HXfWR+rk20zOnWnvFbZ/Ly72ytS4UDpq4Hp5kO2XTpeN3YK2kLbXDeGvFbjELPzTg
X-Authority-Analysis: v=2.4 cv=f8hIBPyM c=1 sm=1 tr=0 ts=685073cc cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=g1y_e2JewP0A:10 a=KySe0LOweYoj0slULfkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 mlxlogscore=846
 mlxscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160135
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tm90IGFsbCBwbWVtIHJlZ2lvbnMgYXJlIGJhY2tlZCBieSBub24tdm9sYXRpbGUgbWVtb3J5LiBT
eW5jaW5nIHZvbGF0aWxlDQptZW1vcnkgcHJvdmlkZXMgbm8gYmVuZWZpdCwgYnV0IGNhbiBjYXVz
ZSBwZXJmb3JtYW5jZSBpc3N1ZXMgaXMgc29tZQ0KY2FzZXMuIE9ubHkgc3luYyBtZW1vcnkgdGhh
dCBpcyBtYXJrZWQgYXMgbm9uLXZvbGF0aWxlLg0KDQpGaXhlczogYmQxMDhhNDRiYzI5IChtaWdy
YXRpb246IHJhbTogU3dpdGNoIHRvIHJhbSBibG9jayB3cml0ZWJhY2spDQoNCi0tLQ0KbWlncmF0
aW9uL3JhbS5jIHwgNCArKystDQoxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9taWdyYXRpb24vcmFtLmMgYi9taWdyYXRpb24vcmFt
LmMNCmluZGV4IGYyNWViZDk2MjAuLmUzYWI2N2FjZDQgMTAwNjQ0DQotLS0gYS9taWdyYXRpb24v
cmFtLmMNCisrKyBiL21pZ3JhdGlvbi9yYW0uYw0KQEAgLTM5MzAsNyArMzkzMCw5IEBAIHN0YXRp
YyBpbnQgcmFtX2xvYWRfY2xlYW51cCh2b2lkICpvcGFxdWUpDQogICAgIFJBTUJsb2NrICpyYjsN
Cg0KICAgICBSQU1CTE9DS19GT1JFQUNIX05PVF9JR05PUkVEKHJiKSB7DQotICAgICAgICBxZW11
X3JhbV9ibG9ja193cml0ZWJhY2socmIpOw0KKyAgICAgICAgaWYgKG1lbW9yeV9yZWdpb25faXNf
bm9udm9sYXRpbGUocmItPm1yKSkgew0KKyAgICAgICAgICAgIHFlbXVfcmFtX2Jsb2NrX3dyaXRl
YmFjayhyYik7DQorICAgICAgICB9DQogICAgIH0NCg0KICAgICB4YnpybGVfbG9hZF9jbGVhbnVw
KCk7DQotLQ0KMi40MC4xDQoNCg0KDQoNCg==

