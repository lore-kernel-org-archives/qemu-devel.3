Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EF4E8785A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnLnq-0002Ew-66; Tue, 03 Feb 2026 14:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnLnn-0002EL-V5
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:11:07 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnLnk-0003xq-Pi
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:11:07 -0500
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 613Hqkn64122458; Tue, 3 Feb 2026 19:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=//VXYvdpC3/lVugWe1Xb1+VyLIVpuyZVdSHsfSJCDqg=; b=
 i2xJ836Qq/FC7INJw9dr6mFT4WvSoQjiRFqiXabh8yIwBcM6g5PdkOk+cztp4cy+
 8JrsRU9IrkPZz15pTdgqDkReBhvZI7j7o6HsoKM4eCcKyyFC46dt5avn2XabQuX5
 GWLSqXL1tT4CGCdhf2+/Gvw0NuqbX+NzUBRdKz2Mjofep+c9KN3y9Uam0+rijpGP
 dWjBjpIEyz3OQdF02DPGszrJP4AuhHQOn41TzdKzhbigGC7azSNI5M+ck9wCbZBa
 87wupTiAlObxEyrubeFqGIeXWpvVDk7ueRzmJRqHcn3HnzP2iaSsU4WZCVL+Kczo
 g+NoVnC7RKE73QSqt7v0qg==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4c1b1bvunn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 19:11:01 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 613ItHtd001008; Tue, 3 Feb 2026 14:11:00 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4c1dy37ea1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 14:11:00 -0500
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 11:10:59 -0800
Received: from DM5PR08CU004.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 3 Feb 2026 11:10:59 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by LV3PR17MB7168.namprd17.prod.outlook.com (2603:10b6:408:197::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Tue, 3 Feb
 2026 19:10:52 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:10:52 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>, Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH v2 01/12] net/af-xdp: fix type overflow
Thread-Topic: [PATCH v2 01/12] net/af-xdp: fix type overflow
Thread-Index: AQHckWbHveaYtIEw2UqC/eBUKtwEnLVxCwCA
Date: Tue, 3 Feb 2026 19:10:52 +0000
Message-ID: <E43BA2A0-02D1-416A-BE1A-0942D337ACC3@akamai.com>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-2-vsementsov@yandex-team.ru>
In-Reply-To: <20260129213215.1405459-2-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|LV3PR17MB7168:EE_
x-ms-office365-filtering-correlation-id: 82fe0c8c-4932-44e3-aa77-08de6357f300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MG9FaWd0czZyNHNFajB5dzRLQmxrZDBRanVSMUx3eW5yMWV5Vkk3OG9pNlZR?=
 =?utf-8?B?N1dnNGlHMnoxQ2JFR01WQXZibFB6UXF5OGJuL0dKMHdIS291b2VmZ1RrblBX?=
 =?utf-8?B?dUFPbUhwM1YyNGdiT1Bqb2dlY1lQYzFPSDAxZmRrL1lqNVhWSHZTRldCc3pE?=
 =?utf-8?B?cUxXdlRvaHI5YzNZbDVDbFZMOHo5c0ZLYytFNC9BWmwra1JZS0prVzh3b3lE?=
 =?utf-8?B?N3ZaWmRjRjlJcHRpczViV1c3NzlHZEJxZGtOZDR3K05CQWt1MC9IdTJnNlB3?=
 =?utf-8?B?MVQ3TlRRODRrZGQ5cDVnRTVEczNueUpTMnNyeTdldEZrMEx1SCs2aGEwNUpO?=
 =?utf-8?B?WVNNb1YrOThHQmlOZXBTRUNJUS90WXVQelJmREpkTHIzeWxQZHo1TnBIUTh4?=
 =?utf-8?B?dmJhOGcxb1p3L2V3ZVBiQU1oT0krVlBkMEhQOTd1YmpQUCtjWWswR0ZKT0xZ?=
 =?utf-8?B?TTU0RGpvYTAvTHpWU3Z5QjN3dlA3VHd2cE1IdHdjc3dkemszQVArcEpZZ0Va?=
 =?utf-8?B?M1R6ekhOVXVSeDNtOE51M1ZCVXpvL3R6dUZXYXdHbE5UOVpWTU1Ja3IxVWg4?=
 =?utf-8?B?SnpQYWxDSlVvYS9ISlRZL0NrZUFaaXVYbnNjVHIzWVlCVTVORzFqQjdIRnY1?=
 =?utf-8?B?L01HRG5KS3hScFl6cTVLbDlVZlVvZUZIVGc5ejZWNmlQc2U2RE16Ny82V0Zl?=
 =?utf-8?B?Q2kxU2RFTkZsWitsQ3lZZDU3WEkySDhzYkJMdmZvNHZGcGdSZ0x1OWNDcW5C?=
 =?utf-8?B?cTRIbVFUSWovTjhBeWxjWU9EN1l6SVJrNVUwaE0yUlcrWDVPYW1HZDNjSFZ5?=
 =?utf-8?B?S0NSRTVhNVlQek9WN1ZGRHg0YnBLZXd1S2hQQTNFY1p5cTNqN3JyVE5kbmNo?=
 =?utf-8?B?S3RLbmVXNjJ0WFdVaVI3aHJwaHduN2tQZWt5TG1UZGhXQmlhYlAyelUySitk?=
 =?utf-8?B?TEhyY1Y3TmdwSktGK0tIZDhYSUhlS3psT2I3WG92bUZPc1BnaXVzOElkYkdU?=
 =?utf-8?B?cnZlLy9GQkN3SG5PUER4cVVvYndrRTRpU0M3NXJZRnpDSWlWN0QweVhTcVpY?=
 =?utf-8?B?S3V3Mng0Yk9icURXMWd1bXE1MitWOXlrSDMyNEYxemRXaHZNeXhkK0h4cGZw?=
 =?utf-8?B?S1ljbytXYmRvMFFmbEFxdUJ3V2lzZTVHYkJoQ3gwWHhodFVlMnNkL3dRRnZK?=
 =?utf-8?B?TGkzU0pMZmZqZTNUZVJNb0p2OUpyVFNEdEJRa05OY2wvdWFTS1NyRS9TdjlC?=
 =?utf-8?B?aEgyZWl3eVU2ekdxUTlpRXUwQmtsVXl0aG1obHduNVZUenRUK1Y0dzlITHJG?=
 =?utf-8?B?UFdJSFMxNXRPa1UwVDIrVlNYeVJyemhRdXQ2dEkxN0w1d0crYkFTQUNtclFT?=
 =?utf-8?B?a3pzdTIrYnFTNStHWDg2aVVYU3NYRU14ZjRBNXJpNTFvVFFJYnhPWTNUZEZz?=
 =?utf-8?B?S0g1cUR4bVNta0I4eEJjZERIM1U4MW1ITlRLMk00eXJaSXJOdkdpWkpYVU9Y?=
 =?utf-8?B?VXB6RnV5VzB4THhBa09MVFhnMlE2M2dCOUdnbnhjRnJaMGVuOFpaWDhPcVdw?=
 =?utf-8?B?L1AzamJtWG02QWg5QVo5ZG16TlMxQ0VNVlRaTkhnZG5IRXl0bStVcnZlejd5?=
 =?utf-8?B?WGNGVyt2Zm1OSnNRZlNUdTNjdW5mL05GSEYzQkhmNDJpdW1IcDRtMFFibEJv?=
 =?utf-8?B?R0tzNnkwSVhSQzZVbUd4ZjBJczNWZUgrY3pvNkpuSGNUbk1XTHhiSFNWOVBG?=
 =?utf-8?B?ellXczNoek5Nd3lZR1dTUnJEWHJ0NnEzTGNkNE1tcUxTcENNOVRMODhWS3pG?=
 =?utf-8?B?aDY4Ry9OOTRQbWpRQkhjMnNyTVVTUEZxK08waExrKzFueUw0MW5BWFI0WVlo?=
 =?utf-8?B?Y0pibkN6VnkrdFZUWWppWEY0K1lOd0FybTZCQkNsc2RSaHliQmp6djd5bjNS?=
 =?utf-8?B?OTk5QnZmS2cvdHpjTDRUT0FRc0trbDI2cXJqcXF2MENVSDJTajROY25uK3JL?=
 =?utf-8?B?aTJ0WWVFcnRHUU01ODFWRHF5a2RNM3VoR3Y4MS9QbTlQWEFSd2E1TGFBdGVx?=
 =?utf-8?B?OFRaSjVtM0FpcjRqc3BkSDNoMXpaSmcybFF1WFhURm9HRWpzUVI3ZGEydzk0?=
 =?utf-8?B?WWxUZkU4VWVMVHQ2OWxLbzdDbW9Gekx2aFBxbDFYWjZBREZFUFFZblN4Y1hY?=
 =?utf-8?Q?o6vyMWFqp6GKkv0WM+OPnnM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blZjRVNHRTVqdktXekc5N1ZuN205K2NaUWtwT1hvVXNGejB4Vk9maXpaVFpW?=
 =?utf-8?B?ZXRGdlJhUmpTYmhEWW5ScE9NVzBoSUh4VTNMc1hEZE9oZitlQURoWllKL01N?=
 =?utf-8?B?TWxWcW1hSVpmQ1o5NjIycEFIQ3ZpaWJxbkVTY0lnQWwrVGsrZFJ3VXRKZVZM?=
 =?utf-8?B?QTVERy9OTkU3dTJMb1BFL1o0MnhMTnhtemNtLzF2RGJNVXpsVFg5c3Fsc3dR?=
 =?utf-8?B?QmVaaEcrOFRtRGF2RHlFcTFPeS8wRS94d1FtY2pkbHU3MUZOMUgzTUNtZ2pi?=
 =?utf-8?B?Y0VCOXBnbTZ0RFBCWXNqTFBreHhrWmowL0Y5OSswZnI4R1FjVi9BOWU4U1d0?=
 =?utf-8?B?dkhJRGpFcXdadXBQRGk1aEpOeWQ2NmZjRGRvMXAvV2RJbWNGanFsbzZQdEhU?=
 =?utf-8?B?Q1RuNDhDQlEwYjNubnd6dHNRRVRxclJPQjZoMGJkWHcrSG9NWHdiS0Q0MDcx?=
 =?utf-8?B?SVhESkxkc29tL1BER3g1U0VBVzFhQW1HbHdSM1RVNFZoU1VGWmcvY29NVEY1?=
 =?utf-8?B?OFhFZFk2ZWFRMkp0SUh2ejBtNlJ3QzJId0wwZ0FtSVRocjhNUmNYSWV4WDZa?=
 =?utf-8?B?ekUwQTV1WnhVa0FGdXlQbFRuOVRzNnU5TGVmN2lLWWhIK0VjMU1BbFlOWWlU?=
 =?utf-8?B?cXRXTkV6OEIwZ0k2aENtQUI4OWRzS3VQMVh0YzBXVzNPVG5HQWlIMkJDMnFF?=
 =?utf-8?B?TmRMZDZEeTF5bUhFb3I5aE5OU1V5SmV4ckVQb1RjVXRVcGZXUENXRWV3eEJB?=
 =?utf-8?B?SWs2UDJCN044K1JFSjlNVEU0OGxFK3V2ODJrUjVZbWJ2ZHk3eXR0aVZOVFRQ?=
 =?utf-8?B?VEFkZE5vU2xsdnltUDI0eHlhNWNUSzZMaHcxWTl3SzZWcGxld3VzbEZBV2Ri?=
 =?utf-8?B?UnhyZW50QUVnUE9tT2JXYy9IL0l4UERUYW5KdTJxdkVtdkdlN0NQdEZRSUVk?=
 =?utf-8?B?U1dBSUg3d0ZUV0hsSDZVdXNZMGcxemJZbmpuTFVGVXhNZS95MzMyejIzZmpL?=
 =?utf-8?B?UFZpVU1sUkxINE5RVnh3RndROEwrM2FiQ3VuaXdFVTQwZFJyL0xabHZBSnNa?=
 =?utf-8?B?TEtpdlVkVVZUYitqRGcwQjNnVEZUOEhtTzBWMHUxMWdRUVpFVnp2bXhXc1M0?=
 =?utf-8?B?TDJZZ2wyYlBWdTlMNlR2NTYveDlOWXBWSml0MTJoMmh6UFI1ME1adDRpV0VI?=
 =?utf-8?B?Snoza2tZdExFbnhtVjJrWk8rbjFCZEVLRFZEVmdyeHYya05VTnFGZEhXWk9T?=
 =?utf-8?B?T3FvNXNtNHF6aG9XUm1oUmtteUhKL0hUK3ZmbFJtR1lSUHpxSzNwRElvbFpk?=
 =?utf-8?B?eHdidWR3QkV0SldDUHlJVWRsK3FBSjBxay8wNHdSeTRxMnhDMlpOUEswQTNU?=
 =?utf-8?B?aXIva0JtUXhHOGZUS3VTaXc5T3hyVVZqUU1HN3VneDhjVEdnRzgvVURuOThv?=
 =?utf-8?B?eHQvSExDOFZjMDFPT2dwVVRiRjZrY1hURnEwckNqcHBvV1d0UmhmbGp4T3hW?=
 =?utf-8?B?dTJKMHE0a2YrdjNMV1pYcWJYVFJYZEE1VkcxSHJncGVOMlhFSWhKTXRnaHJs?=
 =?utf-8?B?SkJRU1dhZ2hPWW9iUFMvRi9QampLVjNDdnZGaGY4L3NYQVhtclNYRGs1RlJm?=
 =?utf-8?B?M3JnbjhudmNzd2RYQmg2Q2JQWFJQQ1lML3NCUndOWFVvQzkvMmc1RmQvSkFI?=
 =?utf-8?B?ckZYTm1BOUJCdy9jWFRVWkFYS3V6Zk5CN0dkSVo5MUdRR1dLM0RTM3FVNWl2?=
 =?utf-8?B?OEhEa3hvSkR5T3dTQnM3dlVhV3ZKSjk4Nk50TGcwTEloYmU4VEoxWmx4eUNN?=
 =?utf-8?B?cTBsYnlmWWVRYjRzU2hPTFlsOFJodFBIcFFJWSsrckhqSlZ6clhrNUVGdDhP?=
 =?utf-8?B?K3NUbHlydjNZRkYyd0xBbXdLYjVxVXIrbXZuU0RkRTRyR01xODEwSWRLZ0lu?=
 =?utf-8?B?Rk55NWZIWHptU0ZKYk44K0ZHUkFUMklRU2VrczIwSGljSGl1c1VmWS9RdkJZ?=
 =?utf-8?B?Yk9qb1RBYUxwYkJURjJIRjQ4RFQ4cENlL2g0WUYzT1ZzREJIWFN4RzFRK09z?=
 =?utf-8?B?Y3ZQRnhoblJ1bWl3L3BFSEdtcVZ6SEtTM2dCQ2c5Vngra09DdU0xem9MbTdW?=
 =?utf-8?B?R09ETGU2QW5oZmk0RDRRdGNRVG5SZ3o1UGRqN1B6NUVJSUU3b3lkd0RPMENP?=
 =?utf-8?B?NkVaZ3JmK1JBWXBmd1BaZHY3MmpVV3VEY1hNQnFUalVlY0RVWlhSYy9RZkJm?=
 =?utf-8?B?aFAzU2JVRzk5TmtHeFY5MlNuVCsybzY2NHFEZWxvNHRFMzdadW53aEhlTnMx?=
 =?utf-8?B?S2dETkdabFFuS2F0aXlyUEIrNHJUemYyUHBtaHlDM1FqRXFDMXlQenA0N3RY?=
 =?utf-8?Q?lwqDUY9aBcLUrDbkZl4pnXypUWG/jnKONUL+Jvuvjzc0J?=
x-ms-exchange-antispam-messagedata-1: 4mPPcpjoKLEGYw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm1kKVTGKQw8Lybd4n8+vg7APCingrPs2df2Pvj7q4vXgHBfF0wKXbnFsyxGaGFTOHfty8oSXKOZPtFo3UnIEIe6nVQFQSyQM678LYEdLhjO5/rRlBAfhpmBL7YGeZDkeAVSYFM9LdGfIWGizb3A/Btu+bLp8q4WTTyEUqZvb8Vm1cc4wniJ8fDSuLZS6pvtyc5nAptcaLWxV80II3MhSoDzJmvK0Lzp+s6VdjbbUoo1n7cIJ3J5NXQj76f6DSmOK286IdK2nEeaTqhkNEyVD+/d3aGVTnLWPaeP9ORcM2CAuCDtoAsHPpye9GeoPhxwqleACXyTPJSrGZU1/KApHw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob/znskiRTh1gi8rYjbYxIwPmtdsPcDaWqKfgDwiu9w=;
 b=CMrvzzPFqHNEjVTajcSIHxrE+yozVY/qw1sZuEtONgE/wpCulZC7nxKHqAM2Jbzpvhgry8FXzOp3+XAoo61UzQxzfYPQi79HM7WEUFvN3BH+0ry/8tz98+zHidV2QpE87FKreqrRSpQudPp92j+enZfPf7vggBBuNckJwmz5A8a1QhnVdKH27d0WHCltzlVRmtZ2DgVMmR4WH1DVj+IrFXCarulOeHb/aHl8rP2SeX0iqWtpkS1EwWHBjzXZF8CbHnlemeXIgOlZJr39sqEfJUOWpmSAIkRHZVzXzRxb81Dhj8H5kMHL68liGkH5aD7pR/u+SL/3Wen6EfUXckOm9g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob/znskiRTh1gi8rYjbYxIwPmtdsPcDaWqKfgDwiu9w=;
 b=jUIVU0Bsh59+8BbTSl/ahCC11R8FSMQCWvJGCjhPOaEwpV6wE0D39YgCj4FtZPc02AJ32S1AIVwwpiV1/GKU9FsL49K3CyNnTDakBfmLpV2JU5vu+5dy8T6DK+FC7yCid3UInlSGB40tOeQjiBdiWSxe3KJlaVeqd5qGJpTX0NY=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 82fe0c8c-4932-44e3-aa77-08de6357f300
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2026 19:10:52.3136 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: YvqMzBXQ2aQ7w8yyU4mXE5iJvAzQRT8TLsV1b2mF1jvhJ0FPlA/eP1+KVzzJaLZGdbsZDt3/vAbHD1ZyiyGHHA==
x-ms-exchange-transport-crosstenantheadersstamped: LV3PR17MB7168
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC0BFA27DBD9D64C94131BF7383E77F9@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=916 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE1MyBTYWx0ZWRfX2FzWyeuAmoKh
 Z/wwgAWVdRasbi4n8kWsadZFEbZi+YbSyGm/Ru4ArhGUxyfcQPlnlbj71I1GaWXIzV4seVPqBIB
 I+xt9Uq/+HKB+dXlc8P6KFePcrTZ+5Z6HXEU+Xe2QoQXPOgoD50TAQRBLFHSHkUY43MUDTgfsL+
 At/RdMXUt7QGPxoS/dT3ykvvD4w7BgJ++QtdL7vBFnC+qiQA6+XJLZlKbh/0prLGohzmi88cXEV
 F3RMUfPFvvpgOXsGKSe8ve4YZ7qskakYw2rbRHXnV5HkZixpevOJRcLhk4nP8dyuLX/VPWCZ1x5
 1fKzcYp5SLBDRJ0oxj7EIszKdF51JGeF1EdwSUXnp/stHNFfHFdTpkLtXKmEAn+u1ou2J16PszQ
 5jBtlOeWVbW47I297AlzMpLIv4xqWtP0cNLk4nsT7wqU+QbCUfUih+nGEP1GvW7RopCHw5L2gu8
 POU/AZPaqtI2L6fShyQ==
X-Proofpoint-ORIG-GUID: dlbnvMX5CCMs0qGZNJ7z2aeFCSQ44oEE
X-Proofpoint-GUID: dlbnvMX5CCMs0qGZNJ7z2aeFCSQ44oEE
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=69824845 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fZTur9hHhXE8tlUO9oMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030153
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

DQo+IEluIGZvci1sb29wIGluIG5ldF9pbml0X2FmX3hkcCwgd2UgZG8gbmMtPnF1ZXVlX2luZGV4
ID0gaSwNCj4gd2hlcmUgaXMgaXMgaW50NjRfdCBmb3IgMCB0byBxdWV1ZXMtMSwgYW5kIG5jLT5x
dWV1ZV9pbmRleCBpcw0KPiB1bnNpZ25lZCBpbnQuDQoNCg0KPiBBbHNvIGluIHBhcnNlX3NvY2tl
dF9mZHMsIGdfc3Rydl9sZW5ndGgoKSByZXR1cm5zIGd1aW50IHdoaWNoDQo+IGlzIGVxdWl2YWxl
bnQgdG8gdW5zaWduZWQgaW50Lg0KDQoNCj4gTGV0J3Mgc2ltcGx5IHVzZSB1bnNpZ25lZCBpbnQg
dHlwZSBmb3IgcXVldWVzLCBhbmQgdXBkYXRlDQo+IHRoZSBjaGVjayBhcHByb3ByaWF0ZWx5Lg0K
DQoNCkkgaGF2ZSBzb21lIGNvbmNlcm5zIGFib3V0IHRoaXMgcGF0Y2ggcXVldWVzIGlzIGdlbmVy
YWxseSBzaWduZWQsDQpzbyBuZWdhdGl2ZSB2YWx1ZXMgY2FuIGJlIHVzZWQgZm9yIGVycm9yIGhh
bmRsaW5nLiBXZSBzaG91bGQNCnByb2JhYmx5IGJlIGNvbnNpc3RlbnQgd2l0aCB0aGlzLg0KDQoN
Cj4gLSBxdWV1ZXMgPSBvcHRzLT5oYXNfcXVldWVzID8gb3B0cy0+cXVldWVzIDogMTsNCj4gLSBp
ZiAocXVldWVzIDwgMSkgew0KPiArIGlmIChvcHRzLT5oYXNfcXVldWVzICYmIChvcHRzLT5xdWV1
ZXMgPCAwIHx8IG9wdHMtPnF1ZXVlcyA+IFVJTlRfTUFYKSkgew0KPiBlcnJvcl9zZXRnKGVycnAs
ICJpbnZhbGlkIG51bWJlciBvZiBxdWV1ZXMgKCUiIFBSSWk2NCAiKSBmb3IgJyVzJyIsDQo+IC0g
cXVldWVzLCBvcHRzLT5pZm5hbWUpOw0KPiArIG9wdHMtPnF1ZXVlcywgb3B0cy0+aWZuYW1lKTsN
Cj4gcmV0dXJuIC0xOw0KPiB9DQoNClBlcmhhcHMgdGhlIGNvbmRpdGlvbiBoZXJlIHNob3VsZCBi
ZSBvcHRzLT5xdWV1ZXMgPiBNQVhfVEFQX1FVRVVFUw0KaW5zdGVhZCBvZiBVSU5UX01BWA0KDQpU
aGFua3MsDQogICAgICAgIEJlbg0KDQo=

