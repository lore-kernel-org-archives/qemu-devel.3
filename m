Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBADC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27Be-0004yW-66; Thu, 03 Sep 2026 09:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27Bc-0004xY-Fb; Thu, 03 Sep 2026 09:09:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27Ba-0007cV-DP; Thu, 03 Sep 2026 09:09:00 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AL08g218510; Thu, 3 Sep 2026 06:08:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=p2yces8j/kU0/TJD56T5/zDHeCu/6dZBisPmTnKSl
 AU=; b=UwXzw+yHTWIJVYqILxI8Lt9p3GVYlSpxKRisf8fmydisjs+eYvzQKg5rz
 Kd2GToVsks6cnC7d0P3G4t5Z/aL5sy6jN4mRetnDTurDQY97uds0hFGvkCObyRRG
 2Z899uwdi7A+BlCcKLPohwRMm3IWCXMhappAnyJeMP5FKtyWZwURZ/9+zeWMWQJC
 MzH+wUsu4oeRWvZNYuwdJY57Ansky10zS4gLCk77N0282NRoRVMifaqYYdFGcgbb
 wJd/lmmX3sT3MBhVZ53et27XjlSlMX1XJirO673wYpEMRjbSMnCZ6BuNdyE7r1/T
 RBqAD4VPCGZlMVRdNitPYXR6QtgJQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023123.outbound.protection.outlook.com
 [40.107.201.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gf5eq0juq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 06:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2Dw7zAqJs5EH9opyFR1xJVU1+6v62CBkaZIjfyLeYdroV26QQ95rNpJ8SqV5aZgO7o9Lz6fxL6E3C7oxHy6z3LvVQpWMOLMCCqKHjVG7XJZavqmEJfApm/QYE3bllruwy5UX70ji3HmWey/mHTPV2v8zcLfNS/GuDVJiSQFw0aFaqri+ysCxneCbkG6rxTxsUjzWugk78y9CN9KKCZE1hPn/KG2YC/6Z3jDHjFceSSP5LUSzY1dwV+S05MAUW/LW5mtUx0m0HwQyqDRBZytfrCh2a9V5PpfceORmw7ZYcy67UR19dbn6ybNYcf/ZhAghobiqdYyhvjfoTlJOTnLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2yces8j/kU0/TJD56T5/zDHeCu/6dZBisPmTnKSlAU=;
 b=FHbJqMyy5vl1ga+GPnBQhe9ylUnRVJqE81Gg035QX5+MkqtbYhNZfukgNe2EqRitNdGxdG15vigZRub2mBeDljZgQis9I49ON7EYYoWOCpANJLKsn4ZaobuI45qkG+j9fwWt/K1q/0NSfDkzsDWDUz5+ot3R9o59/fprzmvL+X5iesfw/h2BHRtxeSA1o1nqtEfoiwZ3JPNrrz6ZuYeHR/xFZ+pp/p5ITLiz/W10e6qDMxfe8QkmTK4iSK+T/PdkcgtrzvEOw8atD6PGkdJhI1z2Fp+6+1Q1/MgTjG442drRoGn7pLNM4fdZLFKnf9V8HKOvofy6O3ADxV4xXFh1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2yces8j/kU0/TJD56T5/zDHeCu/6dZBisPmTnKSlAU=;
 b=lglsXPP1w7UdcCd+ViUt1OSxchaXoTObkUBJ5M1paEwgFNZZPITCvKBmFizQIbP7jxbUWgtcgluNJGiK4a0vCu2vo/L6JFxVa5+Jwkh7b1PUqlSawW6mZP59R3m+FOJcUKefYA5/kgh5tjCkFTGAgHpo0eQnR1Gb8KpZm6F1Xwuv30qFY+YiXZGGITGnbdDzlo2LJcF+gdxeKu9DHgBsrLPt2s1dydNS/0AzpTQpvaQhXjf7cb9NFqgfcky9p5l+8Mv6RjDs8qmFOzSy5rtWHEvsvxiyjfARxQPwZVJoT2GXkEylEb7MWfX74h+iU/pGY7nslAc9DrBzvaF/aQ6ZWw==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by PH8PR02MB11926.namprd02.prod.outlook.com (2603:10b6:510:40a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:08:49 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 13:08:49 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 6/8] vfio-user: enable DMA logging for dirty page tracking
Thread-Topic: [PATCH 6/8] vfio-user: enable DMA logging for dirty page tracking
Thread-Index: AQHdO6Vcyy5bv0tp0EqQ/oi/6h6KmQ==
Date: Thu, 3 Sep 2026 13:08:49 +0000
Message-ID: <20260903130833.1437632-7-hugo.komatsu@nutanix.com>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|PH8PR02MB11926:EE_
x-ms-office365-filtering-correlation-id: a8a8eb7c-ce7b-4a93-427d-08df09bc7eda
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|56012099006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Ua5H7Mw8i+zm/5xMMOHU99gxd0UuIzq68TfLuUbYMAA10eApqQwoSpo3Q2yIVDx+9cvkPdgTMBihP97fQK0O1I6WryOxr4Mim82xG1k6ZVn4zDzjNxr05y5W4pfdnrQs+DeD8FLFK53gU2F0EN2QEHPpoPM5/v5Qcq1F2pO18jRgFCW9r8MBwPU43tBjX02GIkoikTOnHczxN9EVeqzQvQ9E+iqF3yb36cfzWX2iofuf6tWzuAalqmjytA3JyAbOI4uETLtjDnuvy3iMg6YqkM/EISJV7sJPVn2Vu1ERAmrPIIBqAn6S87Zi8x/h4WaNq6M/lhP1Jyb/jEHtDpc5B/ipng2dZN5UDedWEln/NMg1rcTnZplqfRyjcMHRSsKG0fP97gKjL0LwWwbAuhdcDdm01Zd8zVk70YQ6fsNDW3FTJ8CO6gKQ+I7JU/sjf+DHQFLjpf1hcFLgbsIA0h7wgKqpzEC0t5CLbfQsojgvrNiNDeelsw9QvJzvQXjm1dZ8lK5H/mZCVzV8ap4KiZ0Plq2gAyvAdzuMTZmsYUNokwvs2D8ZINKzJ7SgY5DAHQ0C1Zi+XdRUk4N0j8L9ueXeih8pC2tuwk+7bQqWd/e/DdAvh/jpFPi+0iWXBonJ8utozpbRaG9xWn/nkvnUeqsGN0ND5vUJuBKFQ72Ls7iiDVjpvpChICVlp9fKhzxijZT4o7tTqmu1oNl9UBqScyCarg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(56012099006)(10067099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzZpYytlaFVpN3ZxQ3BJMFBsZEQ5ZkxZVGhsaGNIN01KZEVuRzJDdHlublNK?=
 =?utf-8?B?SHJldGRxY2JXa1MrOWt0RFpQSlZnOGJwY2paT2ZZbzBSa1FoRXR4VVJlUCtt?=
 =?utf-8?B?dFFOOG9pemdzUyswVy9Pb2plN1UwTUxxTlJHMm1FMDF5VTZwczZ2WU1JT29X?=
 =?utf-8?B?cGlYa1J0QkJDbGpNMHgzakp0ZElCZTdxNi8xazMxUkRTVTlveXlNSE5YWjVB?=
 =?utf-8?B?S0lOTXBzMVZycElVK2o0czRaMmNnTmh2NDAxVGdFU2loOXh5QnM1UXYwTVNm?=
 =?utf-8?B?N1pTTGdieGtnemswOVJrSUxZZzgrUkFXMEt3WmVqZUw5eDI0emx5QWNjZDNa?=
 =?utf-8?B?a2tXN0xLM3BUdDhEME5naGduYzRRTjhFVGcxUVliS21aaWJwemtHTEhZVlA2?=
 =?utf-8?B?ZDVrenpFa3Vhd0d1NkQzcWpXRGxrTmpvdUQ1U3hyOXFiZWo3andPVTBhZU9F?=
 =?utf-8?B?QTR4RUFtOFRPU0t2eG5RVFBsbmR3TmpzaEYxKzI5dGI4L2NzVndmQ2Znc2Rz?=
 =?utf-8?B?bVMveUZYejBhUmlmeWgyY2RMY3hxcmRVQWdwZzZmNUttSUc5Mmg1c3kxcXJi?=
 =?utf-8?B?S0JUcyszaGRyOGxTSy9KVnYrbTROL1dxWTVka003VVBaNWo4Ri9McWZ2NlJO?=
 =?utf-8?B?bFJkVHV5TEJrZjlXMnBNbFpQREpDR29mUGxnVTRBRVJNeUc0RGw2VnpKTW94?=
 =?utf-8?B?QStNTUVGWnZzb0Y3QTd2TzNMYkFVYzRzNUFkL3lFTlhxcjhZTFNZdWNub0dT?=
 =?utf-8?B?NUkvTkc1YytBN0VWTFBzMzNwaFZpTkp5NXlsTzNaNDdudVBoRDFHNGwvQlI5?=
 =?utf-8?B?Nzl0dFhSRnhmYXpsaXNvN3h5UVRJNE9kdEdlKzQ0ZmVuc3Q5N0lFbHNaK2N6?=
 =?utf-8?B?dU9oOVNqV2Ric2pDNnZPRkcvZ2gyLzNsZnRNeCtGOENzVHFXTjVDYVh6SDJB?=
 =?utf-8?B?eEpXa1NieUpzWnI5RUFLQk1nakl0a2JHYmxqTm5DdXpRanRGWEczUktOSnhX?=
 =?utf-8?B?eTZMZk8zRFFSZThSTjhjdzBBRjUyMU1RRGt5bEp1NEhOeFhjTmJQcjZVNlFE?=
 =?utf-8?B?bUROV3c5OWgvYmcxVEVtczlzMStiMVVKZnVUMC9xRng0K3o3SnY1NGJwT0ZX?=
 =?utf-8?B?ZWN3cll0VFlRTjZEV1VsT1NLbUl0ZFVjQ3pqd2U0M0hid0xKUHJWcFFnT3FI?=
 =?utf-8?B?WWdFYkdLMXFMWEU0anEwK0YyOUlsZ0EzSklLTld5bTJCRXRjQjFKaFJaS1ND?=
 =?utf-8?B?YWE0cEVVcTdFYnZkZ1FUYitUMEJ0RVpHeTgxZS9KSmVvcGFtNkczVC9wM1cx?=
 =?utf-8?B?eHVxTDEwNDBURXNrN1dDajUvUnJjdGM0Z1N1ZGhsUXJUZjNzYUlHMmtRbmZa?=
 =?utf-8?B?cjNlc2JNek9KYUtsWjlVU1dYUmVFZ3VOam56alI4QUdKL2huR0s4bWJVZTBQ?=
 =?utf-8?B?QlM5K0RVWVRSUURUTW1NNVozaVRJdTBIQ1lPQ1JIbVp4ZkJVNFBUMVQxTVI2?=
 =?utf-8?B?SXFBNy9HM0RlT3QzS0M0WW5sc1dOY2xGdTlJcVZ6ZWJZNVRFZUdVZThUNlRD?=
 =?utf-8?B?VnJkVjE3VmhIUGJKdm0yZ1hsSXBUTW0yN3E3ajljZ0lVNW5oU0FNbEtyelVG?=
 =?utf-8?B?U0hGNFlqV0d3czZrU3FkdFFRQ01VZ3hyWjdkaC9XQ3J1bEg4NEtKSW9uOGs5?=
 =?utf-8?B?QlpHNUs4ZWw2SDFkWFFRQlR2TSs3R3ZXaHBodHhiNGQvTG1vMWQzR0wxKzdr?=
 =?utf-8?B?a09OY05PTGJCMGxhenk3bTNYRWlWM3pRb2NkbERSdjJDTGZXeTJ3QUpmM1hk?=
 =?utf-8?B?L2RxbHM2anhoWFZKTS81N09PTEFDZ0ZpT0NwelpqUDl0SHdEdUtVbmZFa2Js?=
 =?utf-8?B?UElWaWk5SWtkdjZFMUZNaEpJZ2lYaHBKSFc5eXJRT21Oa3ZaanhIR1Juekhi?=
 =?utf-8?B?OTNJYUlySGs3ZDIxZytiVURMRlRaSDVEcTRFUldQbDlhSUlHd2w3MG03TUl3?=
 =?utf-8?B?c09LQm9uUUs4VGVoekNEWDhTdzZ0c2NiMW1RZldPdE8raWljY3RNVlp5cnY4?=
 =?utf-8?B?azBzdFZUQnFLTTl3TW1IeW5DWGxsVEVkMWw0U1JvN0o1eERGYzFjd25uclY2?=
 =?utf-8?B?eTdud2hwdTJVTWQ4cXU0L3RBQ2VoSDJoSVFYMFUvS0xoK1VNamtYa3JXUk96?=
 =?utf-8?B?bUF4NDdLMjJtWDV5VC9uVEE2UVBxaEJoTnUreDRxS3N3VTdBaEh1TjJ2a2Q3?=
 =?utf-8?B?WmlOblgzb01YdDlkdzRiT2dmUk9CamJnQm9zT1JEMnFvb09QM1lyekpRRmpj?=
 =?utf-8?B?THVLM1Y5S2tYeFBjOTFvaDJCandpSHM2YVRZZEgybUhiMXZ4VVJ5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NEQfv9uPvOPWFGqDs68P0RXpfxTLK6m/gc1J+qgSF3MAi6Z5It+IPiWi1ArhnYXhnpUh0syYwbdCG3sjB4fjlJ09cj5rqgyzM8tN+QhALmQKAlZmHw5q0Ur3fZ6Ml63WR/DotYboZIAdZvLYvk3h6dot//8XZu14R/LBWGcg8Lr1kswiiPveOeHpakbFtdgYWJ/6K0NUkg9npsvcZUYuiLDFURG9xaxb27aRsHmujNmw1FRE06t3gvdxY5h5wfwnEn3BXT8qD3nlJ4AzcEXRvBHLVyxY+dwJ+Sewll5xwN0SlCheSaMiDhpDsAZdEBk2MEKyvvg8gSYaHR6aLYO36Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a8eb7c-ce7b-4a93-427d-08df09bc7eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:08:49.6261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JbN7IPU50Ie5NZATWqOoxvIYwAfPWQe7XjSl4maz+cJBi73Y6tYBwUXhIi96Mp9DvSVY6rgX6KLBY5I3wWYtgIV5gbLWN3XJlVgImilLGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11926
X-Proofpoint-GUID: ZBSIoIisR_Nnt8hru4oW3qCUo2CYnNe8
X-Proofpoint-ORIG-GUID: ZBSIoIisR_Nnt8hru4oW3qCUo2CYnNe8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX+/lU6gkZoKXR
 zkMirC6NWQuSWVeQaRbZlvKF1Z9OmflDhHrTg5d04VnfkCMz/uIRdcpSouQSR+MACFfi3N0p9Io
 qns2T54OMrNkl8yRHm5IDGPTjXLf6Fg=
X-Authority-Analysis: v=2.4 cv=U6uiy+ru c=1 sm=1 tr=0 ts=6a997163 cx=c_pps
 a=MuaoZ+x0jvd2FUwkjOjmXQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=64Cc0HZtAAAA:8
 a=2bJf0PUoz3_qUPpsRd4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX08XpLB2tm5WB
 WsGPLWD/RJE/PGhQko4JJ756OUf/eesFq3J2w9J0h972w90WyqHmbH8GxAtX85Hb3LnJ91qxWVw
 O/k19k1YPe7dyEytHLYJW432Bc7V36p10RpTnaEE3lC3ILo9N69ssOxYmWTRhGau+owqFyIqI5O
 CcJwo1qELM+9VRs9gr9VyW9I03nJ//1+4JbvMUrnEkozm2Zc3wFoJXDueaNENp5FI33A55Aea6W
 R6EbcwSN4brRcwyERtTDo6DUmghVus1gGPhtpygOw8Z4c8aOyDJ05nTrBIFVNDO9ZsbMS7V1Z72
 mcN2On1pIpXD733D9YMb/6K9LTR/YAs2ne9Dqgbyfc56C7ZQ7ce0Nt+qONHq0XcAO5dyv/+Sxsl
 FI6pzR4Xcp4mFEuGhVr+axCjp8Ac6H8FzCOpY4oeW03eTisnkl/M2DqayR+MaW60tFXNzRt3Q5Z
 RnEpxpJlRV74bsOekgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Rm9yd2FyZCB0aGUgRE1BIGxvZ2dpbmcgZmVhdHVyZXMgdG8gdGhlIHNlcnZlciBzbyBRRU1VIGNh
biBwZXJmb3JtCmRldmljZSBkaXJ0eSBwYWdlIHRyYWNraW5nLiBTVEFSVC9TVE9QIGFuZCB0aGUg
ZmVhdHVyZSBwcm9iZSBtYXAgb250bwp0aGUgZXhpc3RpbmcgZGV2aWNlX2ZlYXR1cmUgbWVzc2Fn
ZSBwYXRoLgoKUkVQT1JUIG5lZWRzIGJlc3Bva2UgaGFuZGxpbmc6IHRoZSBrZXJuZWwgc3RydWN0
CnZmaW9fZGV2aWNlX2ZlYXR1cmVfZG1hX2xvZ2dpbmdfcmVwb3J0IGNhcnJpZXMgdGhlIGRpcnR5
IGJpdG1hcCBieQpwb2ludGVyLCB3aGVyZWFzIG92ZXIgdmZpby11c2VyIHRoZSBiaXRtYXAgdHJh
dmVscyBpbmxpbmUgYWZ0ZXIgdGhlCnJlcG9ydCBoZWFkZXIuIFRyYW5zbGF0ZSB0byB0aGUgd2ly
ZSBsYXlvdXQsIHNpemUgYXJnc3ogdG8gaW5jbHVkZQp0aGUgYml0bWFwLCBhbmQgY29weSB0aGUg
cmV0dXJuZWQgYml0bWFwIGJhY2sgaW50byB0aGUgY2FsbGVyIGJ1ZmZlci4KClRoZSBzZXJ2ZXIg
b25seSB0cmFja3MgZGlydHkgcGFnZXMgZm9yIHJhbmdlcyBpdCBoYXMgRE1BLW1hcHBlZC4gQQpy
YW5nZSBpdCBjYW5ub3QgdHJhbnNsYXRlIChlLmcuIGZpcm13YXJlL01NSU8gcmVnaW9ucyBuZXZl
ciBtYXBwZWQgdG8KdGhlIGRldmljZSkgY2Fubm90IGhhdmUgYmVlbiBkaXJ0aWVkIGJ5IGRldmlj
ZSBETUEsIHNvIHN1Y2ggYSByZXBvcnQKaXMgdHJlYXRlZCBhcyBjbGVhbiByYXRoZXIgdGhhbiBm
YWlsaW5nIHRoZSBtaWdyYXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBIdWdvIEtvbWF0c3UgPGh1Z28u
a29tYXRzdUBudXRhbml4LmNvbT4KLS0tCiBody92ZmlvLXVzZXIvZGV2aWNlLmMgICAgIHwgNzcg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBody92ZmlvLXVzZXIvdHJh
Y2UtZXZlbnRzIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvaHcvdmZpby11c2VyL2RldmljZS5jIGIvaHcvdmZpby11c2VyL2RldmljZS5jCmlu
ZGV4IDFhMDFlNzQ4Y2QuLjA3OGZkOGYyYTQgMTAwNjQ0Ci0tLSBhL2h3L3ZmaW8tdXNlci9kZXZp
Y2UuYworKysgYi9ody92ZmlvLXVzZXIvZGV2aWNlLmMKQEAgLTc0LDYgKzc0LDY2IEBAIHZvaWQg
dmZpb191c2VyX2RldmljZV9yZXNldChWRklPVXNlclByb3h5ICpwcm94eSkKICAgICB9CiB9CiAK
Ky8qCisgKiBGZXRjaGVzIGEgZGlydHkgcGFnZSBiaXRtYXAgZnJvbSB0aGUgc2VydmVyIGZvciB0
aGUgc3BlY2lmaWVkIERNQSBsb2dnaW5nCisgKiByYW5nZS4gT3ZlciB2ZmlvLXVzZXIsIHRoZSBi
aXRtYXAgaXMgYXBwZW5kZWQgZGlyZWN0bHkgdG8gdGhlIHdpcmUgbWVzc2FnZQorICogaW5zdGVh
ZCBvZiBiZWluZyBwYXNzZWQgYnkgcG9pbnRlci4KKyAqLworc3RhdGljIGludCB2ZmlvX3VzZXJf
ZG1hX2xvZ2dpbmdfcmVwb3J0KFZGSU9EZXZpY2UgKnZiYXNlZGV2LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlICpmZWF0
dXJlKQoreworICAgIFZGSU9Vc2VyUHJveHkgKnByb3h5ID0gdmJhc2VkZXYtPnByb3h5OworICAg
IHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlX2RtYV9sb2dnaW5nX3JlcG9ydCAqcmVwb3J0ID0K
KyAgICAgICAgKHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlX2RtYV9sb2dnaW5nX3JlcG9ydCAq
KWZlYXR1cmUtPmRhdGE7CisgICAgdWludDMyX3QgcmVwb3J0X2hkcl9zaXplID0KKyAgICAgICAg
b2Zmc2V0b2Yoc3RydWN0IHZmaW9fZGV2aWNlX2ZlYXR1cmVfZG1hX2xvZ2dpbmdfcmVwb3J0LCBi
aXRtYXApOworICAgIHZvaWQgKmJpdG1hcCA9ICh2b2lkICopKHVpbnRwdHJfdClyZXBvcnQtPmJp
dG1hcDsKKyAgICB1aW50NjRfdCBucl9wYWdlcywgYml0bWFwX3NpemU7CisgICAgdWludDMyX3Qg
d2lyZV9hcmdzeiwgbXNnX3NpemU7CisgICAgZ19hdXRvZnJlZSBWRklPVXNlckRldmljZUZlYXR1
cmUgKm1zZ3AgPSBOVUxMOworICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOworCisgICAgaWYg
KHJlcG9ydC0+cGFnZV9zaXplID09IDApIHsKKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7CisgICAg
fQorCisgICAgbnJfcGFnZXMgPSBESVZfUk9VTkRfVVAocmVwb3J0LT5sZW5ndGgsIHJlcG9ydC0+
cGFnZV9zaXplKTsKKyAgICBiaXRtYXBfc2l6ZSA9IFJPVU5EX1VQKG5yX3BhZ2VzLCA2NCkgLyA4
OworCisgICAgd2lyZV9hcmdzeiA9IHNpemVvZihzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZSkg
KyByZXBvcnRfaGRyX3NpemUgKworICAgICAgICAgICAgICAgICBiaXRtYXBfc2l6ZTsKKyAgICBt
c2dfc2l6ZSA9IHNpemVvZihWRklPVXNlckhkcikgKyB3aXJlX2FyZ3N6OworCisgICAgaWYgKG1z
Z19zaXplID4gcHJveHktPm1heF94ZmVyX3NpemUpIHsKKyAgICAgICAgZXJyb3JfcmVwb3J0KCIl
czogRE1BIGxvZ2dpbmcgcmVwb3J0IHNpemUgZXhjZWVkcyBtYXhfeGZlcl9zaXplIiwKKyAgICAg
ICAgICAgICAgICAgICAgIHZiYXNlZGV2LT5uYW1lKTsKKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7
CisgICAgfQorCisgICAgbXNncCA9IGdfbWFsbG9jMChtc2dfc2l6ZSk7CisgICAgdmZpb191c2Vy
X3JlcXVlc3RfbXNnKCZtc2dwLT5oZHIsIFZGSU9fVVNFUl9ERVZJQ0VfRkVBVFVSRSwgbXNnX3Np
emUsIDApOworICAgIG1zZ3AtPmFyZ3N6ID0gd2lyZV9hcmdzejsKKyAgICBtc2dwLT5mbGFncyA9
IGZlYXR1cmUtPmZsYWdzOworICAgIG1lbWNweShtc2dwLT5kYXRhLCByZXBvcnQsIHJlcG9ydF9o
ZHJfc2l6ZSk7CisKKyAgICBpZiAoIXZmaW9fdXNlcl9zZW5kX3dhaXQocHJveHksICZtc2dwLT5o
ZHIsIE5VTEwsIG1zZ19zaXplLCAmbG9jYWxfZXJyKSkgeworICAgICAgICBlcnJvcl9wcmVwZW5k
KCZsb2NhbF9lcnIsICIlczogIiwgX19mdW5jX18pOworICAgICAgICBlcnJvcl9yZXBvcnRfZXJy
KGxvY2FsX2Vycik7CisgICAgICAgIHJldHVybiAtRUZBVUxUOworICAgIH0KKworICAgIGlmICht
c2dwLT5oZHIuZmxhZ3MgJiBWRklPX1VTRVJfRVJST1IpIHsKKyAgICAgICAgZXJyb3JfcmVwb3J0
KCIlczogc2VydmVyIHJldHVybmVkIGVycm9yICVkIiwgX19mdW5jX18sCisgICAgICAgICAgICAg
ICAgICAgICBtc2dwLT5oZHIuZXJyb3JfcmVwbHkpOworICAgICAgICByZXR1cm4gLW1zZ3AtPmhk
ci5lcnJvcl9yZXBseTsKKyAgICB9CisKKyAgICBtZW1jcHkoYml0bWFwLCBtc2dwLT5kYXRhICsg
cmVwb3J0X2hkcl9zaXplLCBiaXRtYXBfc2l6ZSk7CisKKyAgICB0cmFjZV92ZmlvX3VzZXJfZG1h
X2xvZ2dpbmdfcmVwb3J0KGZlYXR1cmUtPmZsYWdzLCBiaXRtYXBfc2l6ZSk7CisgICAgcmV0dXJu
IDA7Cit9CisKIHN0YXRpYyBpbnQKIHZmaW9fdXNlcl9kZXZpY2VfaW9fZGV2aWNlX2ZlYXR1cmUo
VkZJT0RldmljZSAqdmJhc2VkZXYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlICpmZWF0dXJlKQpAQCAtODEsMTIgKzE0MSwyOSBA
QCB2ZmlvX3VzZXJfZGV2aWNlX2lvX2RldmljZV9mZWF0dXJlKFZGSU9EZXZpY2UgKnZiYXNlZGV2
LAogICAgIGdfYXV0b2ZyZWUgVkZJT1VzZXJEZXZpY2VGZWF0dXJlICptc2dwID0gTlVMTDsKICAg
ICBWRklPVXNlclByb3h5ICpwcm94eSA9IHZiYXNlZGV2LT5wcm94eTsKICAgICBFcnJvciAqbG9j
YWxfZXJyID0gTlVMTDsKKyAgICB1aW50MTZfdCBmZWF0ID0gZmVhdHVyZS0+ZmxhZ3MgJiBWRklP
X0RFVklDRV9GRUFUVVJFX01BU0s7CiAgICAgaW50IHNpemU7CiAKKyAgICAvKgorICAgICAqIERN
QSAoZGlydHktcGFnZSkgbG9nZ2luZyByZXBvcnQgbmVlZHMgYmVzcG9rZSBoYW5kbGluZy4gVGhl
IGtlcm5lbAorICAgICAqIHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlX2RtYV9sb2dnaW5nX3Jl
cG9ydCBjYXJyaWVzIHRoZSBkaXJ0eSBiaXRtYXAKKyAgICAgKiBieSBwb2ludGVyLCBidXQgb3Zl
ciB2ZmlvLXVzZXIgdGhlIGJpdG1hcCB0cmF2ZWxzIGlubGluZSBhZnRlciB0aGUKKyAgICAgKiBy
ZXBvcnQgaGVhZGVyLiBUcmFuc2xhdGUgdG8gdGhlIHdpcmUgbGF5b3V0LCBzaXplIGFyZ3N6IHRv
IGluY2x1ZGUgdGhlCisgICAgICogYml0bWFwLCBzZW5kLCBhbmQgY29weSB0aGUgcmV0dXJuZWQg
Yml0bWFwIGJhY2sgaW50byB0aGUgY2FsbGVyIGJ1ZmZlci4KKyAgICAgKgorICAgICAqIFNUQVJU
L1NUT1AgKGFuZCB0aGUgUFJPQkUpIGZhbGwgdGhyb3VnaCB0byB0aGUgZ2VuZXJpYyBwYXRoIGJl
bG93OiB0aGUKKyAgICAgKiBzZXJ2ZXIgb25seSByZWFkcyBwYWdlX3NpemUgKHNhbWUgb2Zmc2V0
IGluIGJvdGggbGF5b3V0cykgYW5kIGlnbm9yZXMKKyAgICAgKiB0aGUgcmFuZ2VzLgorICAgICAq
LworICAgIGlmIChmZWF0ID09IFZGSU9fREVWSUNFX0ZFQVRVUkVfRE1BX0xPR0dJTkdfUkVQT1JU
KSB7CisgICAgICAgIHJldHVybiB2ZmlvX3VzZXJfZG1hX2xvZ2dpbmdfcmVwb3J0KHZiYXNlZGV2
LCBmZWF0dXJlKTsKKyAgICB9CisKICAgICBpZiAoX19idWlsdGluX2FkZF9vdmVyZmxvdyhmZWF0
dXJlLT5hcmdzeiwgc2l6ZW9mKFZGSU9Vc2VySGRyKSwgJnNpemUpKSB7CiAgICAgICAgIGVycm9y
X3ByaW50ZigidmZpb191c2VyX2RldmljZV9pb19kZXZpY2VfZmVhdHVyZSBhcmdzeiB0b28gbGFy
Z2VcbiIpOwogICAgICAgICByZXR1cm4gLUUyQklHOwogICAgIH0KKwogICAgIGlmIChzaXplID4g
cHJveHktPm1heF94ZmVyX3NpemUpIHsKICAgICAgICAgZXJyb3JfcHJpbnRmKCJ2ZmlvX3VzZXJf
ZGV2aWNlX2lvX2RldmljZV9mZWF0dXJlIGFyZ3N6IHRvbyBsYXJnZVxuIik7CiAgICAgICAgIHJl
dHVybiAtRTJCSUc7CmRpZmYgLS1naXQgYS9ody92ZmlvLXVzZXIvdHJhY2UtZXZlbnRzIGIvaHcv
dmZpby11c2VyL3RyYWNlLWV2ZW50cwppbmRleCA1MDNlMWM4MmQ0Li4zNTM0MTk5NGM1IDEwMDY0
NAotLS0gYS9ody92ZmlvLXVzZXIvdHJhY2UtZXZlbnRzCisrKyBiL2h3L3ZmaW8tdXNlci90cmFj
ZS1ldmVudHMKQEAgLTgsNiArOCw3IEBAIHZmaW9fdXNlcl9kbWFfdW5tYXAodWludDY0X3QgaW92
YSwgdWludDY0X3Qgc2l6ZSwgdWludDMyX3QgZmxhZ3MsICBib29sIGFzeW5jX29wCiAKICMgZGV2
aWNlLmMKIHZmaW9fdXNlcl9kZXZpY2VfaW9fZGV2aWNlX2ZlYXR1cmUodWludDMyX3QgYXJnc3os
IHVpbnQzMl90IGZsYWdzKSAiIGFyZ3N6IDB4JXggZmxhZ3MgMHgleCIKK3ZmaW9fdXNlcl9kbWFf
bG9nZ2luZ19yZXBvcnQodWludDMyX3QgZmxhZ3MsIHVpbnQ2NF90IGJpdG1hcF9zaXplKSAiIGZs
YWdzIDB4JSJQUkl4MzIiIGJpdG1hcF9zaXplIDB4JSJQUkl4NjQKIHZmaW9fdXNlcl9nZXRfaW5m
byh1aW50MzJfdCBucmVnaW9ucywgdWludDMyX3QgbmlycXMpICIgI3JlZ2lvbnMgJWQgI2lycXMg
JWQiCiB2ZmlvX3VzZXJfZ2V0X2lycV9pbmZvKHVpbnQzMl90IGluZGV4LCB1aW50MzJfdCBmbGFn
cywgdWludDMyX3QgY291bnQpICIgaW5kZXggJWQgZmxhZ3MgMHgleCBjb3VudCAlZCIKIHZmaW9f
dXNlcl9zZXRfaXJxcyh1aW50MzJfdCBpbmRleCwgdWludDMyX3Qgc3RhcnQsIHVpbnQzMl90IGNv
dW50LCB1aW50MzJfdCBmbGFncykgIiBpbmRleCAlZCBzdGFydCAlZCBjb3VudCAlZCBmbGFncyAw
eCV4IgotLSAKMi4zOS4zCgo=

