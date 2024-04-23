Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA43C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHtj-00077e-Ar; Tue, 23 Apr 2024 11:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1rzHtd-0006Ua-0W
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:17:25 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1rzHta-0001Uo-3F
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713885442; x=1745421442;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AT5GdVXS/zOFQmqDdptuJvrmzKZACplWz/PS5XLbGLo=;
 b=ndXGppHm5RNrFb9uwP/FgPqcuOubCcjXIHh9pc/8IJbd2yAwU0o8FEPq
 +LesAXaJ/CCy0zkdZO+03UovPkC+nYpeMkCwF7ddIvqx+6jnIK6m0q19a
 9kOMmFFvwO8ZgRbfwHq6Alrrn3OE/+uLSrc7OWuZXboUjo/rEZL/9s+KJ
 2b4FmhOfz18sE9/o7cVgORu6BjjiW1etnFG2iuSrV/Kpdx5Zxwc0DQ/PF
 SSoaTsPPNJA6dhXCQzKgKKzUKmAvoqlKLwxmI2/oAoYGHXx2e8RDojxE6
 UWd1nXH1xrN+2FQQnfYxBk8tCOHym0rEUgWyavpIg4KMXN30je/XvNdoP w==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; d="scan'208";a="11081479"
X-MGA-submission: =?us-ascii?q?MDH/9ZOxMrsRP+D+/lPtDmVh7RHnZNiGJ1yeYl?=
 =?us-ascii?q?Zq8y5wfKTb/neVKnyyN3Yk9OkvG47WeeJ3xK6naySd5Fvgc/+Qa/3v4O?=
 =?us-ascii?q?n0sCSnUE1bKKgT+EuOkAyECLlgZSgz6fj+g+0P+tnRO3sUy1Q74Nfavt?=
 =?us-ascii?q?C3fCI+X4gEJe1Nqm8LjKH9VQ=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 17:17:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJtWBWDxnZXF4M1hGCqVXjmh8xiq3rMmIYQZGo3ZvHXewAqmA6ZeVe07/klcAA5y/KxmO1MQjHR9flPCu/CvCY1xYdZDb3zd8yuqZqGvLVfTWU/PaORB/wT8BaSJNpECyihCOLPmcIgi2bT4lv7FUFx8axlmUsOc8tGgs2UuxjPIEUA2xESn7rRgJfjo6RZ32MrGzO8OCSGUbU4uI3EKz3y1he8A/EV5cwwiCpSFJ2beJtbTRumeE8fKJHp1Y2ZAWtAFzrZYAkyn0iNNQfXNUxJZAsT3+YE9PEWVnl5tfI8w8P4q2DgpRBmlQ9QO5kSeEQrbYFm9Lnua9eDmXngYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT5GdVXS/zOFQmqDdptuJvrmzKZACplWz/PS5XLbGLo=;
 b=eOaB2YIK8L/YioKf5d2/OpY8D6NKrlXtxfYRQgcRpl+MT+rPIN6DTZe5k0NdYg1Suihkenpn90/TDqAe38+tQR5UQ49FNijEFs3KkDayB7FPA+qWTCEqQlpRMH9Su4bihdZsl2RoFqAQ7cxS1OjRyXqAlhUNR635uy5ta+X5eAPJI8JO4NaL3WpjPWyEkNhulXqiJDv8GOpHYzV0kbYAtuQeP3mxDybEDaPRx3Or+w51a3t8J/3jOLD231r6+7MgKX5WpArrC+r/w9qWLT4zeYU/f66XaL4HXAUy9Ysgg+AvdU7l9MKHwpFFBEkD2f35zeLdub3MGpJkRh/oE7W0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB6954.eurprd07.prod.outlook.com (2603:10a6:102:76::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:17:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:17:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH intel_iommu 3/7] intel_iommu: make types match
Thread-Topic: [PATCH intel_iommu 3/7] intel_iommu: make types match
Thread-Index: AQHalM0i32KNWd9K4kWnjKS4kUptSrF0hHEAgADJsYCAADYlAIAAdL4A
Date: Tue, 23 Apr 2024 15:17:17 +0000
Message-ID: <fcb5d89d-09df-4abb-9b37-b570c08c6345@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <20240422155236.129179-4-clement.mathieu--drif@eviden.com>
 <5acf21ec-216b-4d11-a7c1-ecf9a8ddf76f@linaro.org>
 <2537c79d-60d8-4504-a612-ad5a75e1bd20@eviden.com>
 <dca95e8b-7d5d-4ab7-9e5d-ad0d9269818f@linaro.org>
In-Reply-To: <dca95e8b-7d5d-4ab7-9e5d-ad0d9269818f@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB6954:EE_
x-ms-office365-filtering-correlation-id: b4390a68-48a2-444e-434b-08dc63a876d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?TktYTTlGUG50eFd5WE5vL3RaSUI5ZGJaakgvQm11Q3lYa3QzYWlJRXliOFRQ?=
 =?utf-8?B?YnAzZHQyempyUW5uS0xJZFRmd2ZNRVBPREljTzI5ZWJ3STBqaFE0dlF1ZEtI?=
 =?utf-8?B?cHlSWWorSU9UcEFhZHFjdGFzZG1ncnlEYVk5aFVkS1psWWhOWHdvMzVaMHRu?=
 =?utf-8?B?MkVRSlc4eThmNXZ5WW15SUpwUVJwRFNWcVhucWpId25jV1NReDVwL3ExZzF1?=
 =?utf-8?B?ZG9yUExRWlVMWk1jeDhGVmVFK3FoNkFCWnA3RVlLOGpjQzZUc0laZ0ZYaU4y?=
 =?utf-8?B?M0VZbEZOZG1sTHplYXVDK2dHT292ODdmQ2w0dTIwME84STJmcXc5WE9OYmZN?=
 =?utf-8?B?aXFvdnhPZEo4ZWY0NXBIZ0Q2SXVyVWxKb3U3Q1BWWjBGQURMeU1IVExtWVdN?=
 =?utf-8?B?SkNYTWpoYmFQbGFRYmNpQVJtcWFncUQ5RDhnTklSZiswT1JsRDloTXMvZUF2?=
 =?utf-8?B?R1BmTWUzN0tWMjFmc0xWWUhkWHc3YzNQQ3YyMXNTa1RqVkgzZEJnWXF4ZzF5?=
 =?utf-8?B?Q2FTdllIVE85VWJaTksxU0ZpVExPSW96ajk4OE84VlE3dWM3eC9wQ3V6dFo2?=
 =?utf-8?B?WGk1VHcxalg1UEtJSS9RUlFpb3NDSm5MMWJjaW12NTEwQ2ovVlltMFFkWFp1?=
 =?utf-8?B?ek9kR3ZhSHN0UDROWE1ZTHlpVjhIaGRSQzRLWmZXTG53R0ZnNklMSWdVR24r?=
 =?utf-8?B?aFV0aWd2MVRBVVBmdVM5dWJPd0hXZlpReklERWhrOWxEQlFKWW16VjE5OUw3?=
 =?utf-8?B?ZlRtam1ySk52NjM0RHNhZ2NSYytKZnJoS05vejJGdXhFOUg5OHR0RHFjSnpm?=
 =?utf-8?B?Uk1CTjhMelZjQURBYXF0WG9GT01xYzJId2k0cGEyTWc2WFBpaFc4V3BOK1Bt?=
 =?utf-8?B?dWlQaDd6VWh2WGpvcUNCVnpOcmRvN2lwS2lvemRzQkRQMnlPUzBPWG91Qlkx?=
 =?utf-8?B?VHZ4OWJlakF6dG1MU1ZaTTVnR3B5RG92MzdFRXBKMGpzMGpheG9qTlY4MXY4?=
 =?utf-8?B?QVp4U21XdUJSNEhuNDAxWFNlc3A1eEtSRW5BeEdsai83N1NBeFVFd2RzRmps?=
 =?utf-8?B?ekNVKzZmVFFBQTFZTkFSWDhta3JPUC9YeUtkVjFVYzNubHljVVZXS04rVEF0?=
 =?utf-8?B?cGpsbEE4VURsVU03Q1pPcmhibkQ5RDVqSEkwN2dzZ0hMejhjOTJ5Uysyamc3?=
 =?utf-8?B?RHlZdjU1OUpEM3hzc29yUlUxQ041R2NuU3Vxai9kdW43Z2tod3BqQjdVZEhN?=
 =?utf-8?B?eHdZdFNLYVlWUVpta0tuVDRzWUc2VmNzNjlha1U5eC9mK0ZNdDhrSkNaK1do?=
 =?utf-8?B?ektubDJEMlZ1MWdUY1p3Q2ZOaHU5ZDh3MHY4dVFiV094bUkxSncvdFVHdnpi?=
 =?utf-8?B?TmRSU2JjaFdCQy9KTjNSWUhFbG12ZVNTSmd4NG0xVlpJTE84QzdmV3E5N3g5?=
 =?utf-8?B?eUxNVmJ2Z1hKU1N1S2NaVk9TMXpkY2hKS3Bya3dKQ0xIbUxYcTdoNEoxd2dQ?=
 =?utf-8?B?RDdTc2p2U1JhcGEzWGgwM0pBbVZ5MlpVcHhrSWxTaG9IRXpvdy90clRTd1N0?=
 =?utf-8?B?NU1LbFU4MDUwTFNCQ3czdmgwVlZJT0NMK202VktIcEEwZWM1cHpKMjZpc1la?=
 =?utf-8?B?QVpPODR0eE1UMmJGS2ZEZld3QUJlWU5EZlI5OUdjbVlEMDRCM0x2K1BXQnFp?=
 =?utf-8?B?WUpiMFR1OWUrcHJNaHUwZFlRNGR5VEp4ZHRHaE9vTThyK2hjZWpEaWlod0Fh?=
 =?utf-8?B?Y3VJU0pnTUxkNUl3VkJ4a3dwZ1VBalQ0czJXcm4wRTVMMkhpMWp2UUgrYXkz?=
 =?utf-8?B?cnc1cHROR0pnMitGbWR1QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTdNZHFWSVFRQW02KzBNYXpKMTBVa0NBM3phV20vTkJnelJKdkJTajdQb3Nq?=
 =?utf-8?B?cS9ybHBMZGpjVERlSGRmSi9kRFBsTHU1QWFXYVdKRFlwOTdQeTFVTU1mdnFa?=
 =?utf-8?B?ZitUTjFaV25FdEczcGZ3UEx1TGpmTWh1Ym8wNnJWU0EwL3B6Y2FBVzBFUlBa?=
 =?utf-8?B?YVZuTk04VkJYQjlmaGQ0QVZSNkZGUWZYbGVhbHVyb2dWWVhMTUV0aHJxcUVa?=
 =?utf-8?B?Rk1xbzNUZGJCalVRQ0U0MTJMRXIrQmZPTHIzbXN0ZU4yMFJtRnpRU3JsTjdx?=
 =?utf-8?B?YUpJUkViWmRhTUJwaXcxQlJ3bURGckliWTVOMmFqMkJZU3JPRGY4bkU5MTNP?=
 =?utf-8?B?dStjUW5aQ1JET1NpK3hMejdPZExISDdGMndUSWFaazU1SXJvbE1qQnJ4M3A3?=
 =?utf-8?B?dVFWaHlXMWpJOEhDRVU4VHZINjJJRFlaby9jMHFCQmhGUkVwUWphZGJHUGVB?=
 =?utf-8?B?S0JSaFQyT3l2MUoxZ0lTRk1ucXlqa0pEcUxTYnBrR01DT25xRDVCamlVL3M2?=
 =?utf-8?B?ZlJYZmJqdDNvdENvQ1J6c3V2dTZjWE9SeGM0OG9XUVJ6QkRhWlVkWUJvTnpv?=
 =?utf-8?B?Y21LeThzMytvdVgwUUpNS1haTTlRNSs3NHNzT3NLeXIrakNWUVQ3V0FsYVRP?=
 =?utf-8?B?L3VFOVFtendwUWJYQ0lmbTBKRnROVHJpV09WcjZiSXd2VndWazl2QkF6elJB?=
 =?utf-8?B?ZzdOR1hYM3RDUFBERG1kbVkybzN5N2UyWkRYNnRNSXpqUUV3L0Z3U2dJMUdu?=
 =?utf-8?B?TTdERkM2VmFLRHQyR2NJSi9JR01rREFpT0lFWlgzdjkxVDQzYzFwTXVKV3E1?=
 =?utf-8?B?c3dWRnp0bWVzSTdYUEdLMUZXNVVSQUxJVjQwU09NR05lOFQ3NEVqMnByUm1u?=
 =?utf-8?B?R3VXQkRqQmEzSGQ2Nk1ZdVNLSWllemN2OUkxTUxnOW9oQVc5WjFKbElIQlNN?=
 =?utf-8?B?WWNpdGxhSEdQVE9RTC80UnJIOGJqMSs3bmgydUhadVVxVnh1dDRtUi96RGc1?=
 =?utf-8?B?eDF1RDBhM0Z0OUlYZkVBeElQN3NTZGN6L0F0OW4ySk9uSHYzRVQ1ZFFKTWF2?=
 =?utf-8?B?NG1YRUZGYzMyZG8xOVd0TFEvRnVyWGo5dmFJcXArczhlUllzOFBnZ3hCUEp6?=
 =?utf-8?B?QkdzakVKbzNPamwyejdsdkl2ZEs2RTRpSjFPQklDZEYwTFNXTUxrd0lsTmdP?=
 =?utf-8?B?LzR5SDhTL2VmQS9aeDlDRjNhT2d1ZHVEelF6TGhuVjEyTU1DdWIvYmVHSDV6?=
 =?utf-8?B?M2s5ZUNXYlo5MUorRUw0aXBNRjdvOHkydTBKZXN5WXJScW1yN3FmRWZzN3Yr?=
 =?utf-8?B?QVh1Y2Y3TkpZNEZFZTRWbzdmL2o5dURTaDRmd09PUFRlbXdEblZWTDJhbVJ3?=
 =?utf-8?B?SUpIMEEvVm05ZmQvZ3BtbjM1eEVNamNaY1pBYWVXVmEyM1ZGOGdBN1piNExZ?=
 =?utf-8?B?TGFreVUyYjdLUkRoaHRBWGxBUmFJTVo4T05RMzVrbG1TdVAvb3M0L0w0WkR0?=
 =?utf-8?B?Q0NWakVWZkhMTVlhZS9UZ3A4c2J6RmRId0N1Q2JUSXZyMzN2VnFDeHJEMDFj?=
 =?utf-8?B?bmxNRCt4VkZmdE9ORitNVTdCZFQzalVEV0UwamZ6Z01lWk9XRW4waWJsMHdC?=
 =?utf-8?B?YWNQTGwxeEM1WkFISW5WUHV6UXpJd0J4eDM4YVg4aFBhRmY3bzAvN1hIK211?=
 =?utf-8?B?Y3VWSWNSbjBsYXBuak5nY3Q2RktUUkVkdWhLQWtBamk4UWt1Rm1lUjhDUlow?=
 =?utf-8?B?MzJscVE1NTVSUHBLMkpKZ1FhdFUyY3hHQTJoMm1KZmh2dUlMNm1PL0VCVU1u?=
 =?utf-8?B?dGN0b1VmOWtRL3dqRm1TcGs2SldKRG9kNHpQQjZUbjFLNjNNUG1DclN4aytv?=
 =?utf-8?B?TkJkcUk2emVKYUg2YWFzVGhFSEIzOERLdTltdkpaV1VsQkdaNEhlYUJaM25m?=
 =?utf-8?B?SWhINEpvRS9zYm1Eb3Fna2VucllUNTBJaTV1aEFOKytRcER3b0JHUkpNY0ha?=
 =?utf-8?B?ZEdVSWJydzRBb1UwY0g2aEZCc0VjVXlhdzVwYXFQTkJzV0I4S2JaUDNWc0k2?=
 =?utf-8?B?R0s3RlY0TFpaNktTaCtnM2FLYU5tNExpbkhzUU92N0oxQUR1UjFEaTF1SUZ1?=
 =?utf-8?B?ak5meUdXbVhYV25RQkd4RFJlLzRId2hJUHdHdnc0TjdVazhzTjZCYkZoaUxu?=
 =?utf-8?Q?OcRYWZKYPd8lkbjFZDadT0c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45C8F8ADA937084E82A7EE7F6378F8F5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4390a68-48a2-444e-434b-08dc63a876d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 15:17:17.8624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/RDziuLRT1eR9km4UR49ZaAu8pMK6ks+wmVDC+26cqznYOoEJdDNLS7/dd5+uurzUTb5tHiemOFG7S7FJEN9va5NsKQH3eqoDZzNI9hh+2mZlMTjLlA/HAklEUl6ZJr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6954
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

DQpPbiAyMy8wNC8yMDI0IDEwOjE5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4N
Cj4gT24gMjMvNC8yNCAwNzowNSwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4NCj4+
IE9uIDIyLzA0LzIwMjQgMTk6MDMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+
IE9uIDIyLzQvMjQgMTc6NTIsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+Pj4gVGhl
ICdsZXZlbCcgZmllbGQgaW4gdnRkX2lvdGxiX2tleSBpcyBhbiB1aW50OF90Lg0KPj4+PiBXZSBk
b24ndCBuZWVkIHRvIHN0b3JlIGxldmVsIGFzIGFuIGludCBpbiB2dGRfbG9va3VwX2lvdGxiDQo+
Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgDQo+Pj4+IDxj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IMKgwqAgaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIHwgMiArLQ0KPj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IGluZGV4IDZmMTM2
NGIzZmQuLmJhNTQ1NTkwYjEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gQEAgLTMzMyw3ICszMzMs
NyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeQ0KPj4+PiAqdnRkX2xvb2t1cF9pb3RsYihJbnRlbElP
TU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCj4+Pj4gwqDCoCB7DQo+Pj4+IMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgdnRkX2lvdGxiX2tleSBrZXk7DQo+Pj4+IMKgwqDCoMKgwqDCoCBWVERJ
T1RMQkVudHJ5ICplbnRyeTsNCj4+Pj4gLcKgwqDCoCBpbnQgbGV2ZWw7DQo+Pj4+ICvCoMKgwqAg
dWludDhfdCBsZXZlbDsNCj4+Pg0KPj4+IE9yIHNpbXBseSAndW5zaWduZWQnIHVwIHRvIHZ0ZF9z
bHB0X2xldmVsX3NoaWZ0KCk/DQo+PiB2dGRfaW90bGJfa2V5LmxldmVsIGlzIGFuIHVpbnQ4X3Qs
IGp1c3QgYXZvaWRpbmcgYSB3YXJuaW5nIGhlcmUNCj4NCj4gV2hhdCB3YXJuaW5nPw0KQSBsaW50
ZXIgd2FybmluZywgYnV0IGl0J3Mgbm90IGEgYmlnIGRlYWwgaW4gb3VyIGNhc2UgYmVjYXVzZSB3
ZSBrbm93IA0KdGhlIHZhbHVlIGlzIGxvd2VyIHRoYW4gNQ==

