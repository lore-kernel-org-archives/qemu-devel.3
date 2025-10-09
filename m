Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9743CCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6pBu-0004G1-Pe; Thu, 09 Oct 2025 07:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6pBr-0004Fc-FX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:52:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6pBl-0006Qx-Gb
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:52:11 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5997XUqJ029249; Thu, 9 Oct 2025 04:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZoXPtwqal9uIomWTrxXmTEWEZwrSNSxOO/JwDKeTm
 5U=; b=Ul1D2x2bXljRX+BFPGLgE3HkuuMuINPO+1jfeomNOClgCNi7QpM9hwTQc
 kEzg/j8zivBJ74w0ljhYMCTcN8SowkxzPnvXgr86ZBnmW5uX8DVE7kaG5hLyaLLz
 d43/bql65SNYOla6mKcudoQ0/3reiUCEjdAdCWwy6bdzOHb7GjlOC89SI/ud+JRm
 VIbHyBvrOCl2YfbVzZXDlLC1MeyAPmkvyYEH81/Lw4ZsNVcZAu+yn/TGaitbUva4
 Qn7ftha09nbSdia84sOWqs83qk8N4BNeq1byxGlCJlWdrAhNpmV8RcsD39rl8Pa3
 TooNseDxHE5rJMie+xvS0VO+2eC2g==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022103.outbound.protection.outlook.com
 [40.107.200.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1ussfc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 04:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvVEhuWsJQJHoLRuc3p3/ACR1YroDpZDhgYkgfKrsAFqdrsamQxIzl/6wfdeEEKNamHHxSa4ZGzzvXMZeIywVhVADLGr4eqasOGgx1Wr5fVZkHNThIAGZFkKczUFQeHudC+hQv63dcSos+qwIrOwGlqOBbpiCIC+1L3n1rShNo5PBdnWSTxhw/7zHfwyY/hzvmWlP3oOnRIQvO8BDnBVCt7EoHf2E2bfaakE87QCt1UAYoDKe9FxPLFP+s/vI/AApLJ25mxRp+hIDZJiG1MapA+bbpEhDCPb6qTANwpA4ClUMXMW3BeUZA654QDw1nHlEmSs0msuyRT34IWucZb9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoXPtwqal9uIomWTrxXmTEWEZwrSNSxOO/JwDKeTm5U=;
 b=Z7EtK9kELutTJLrU74Lq0PvOtbejg0u/6ZltYpzX96BQnf9CRk7xS6CQgjyth4pA9bIJftKGBCfpjKalK0hxi5OtVu++KgstgUySFLSD8TmXpoKfgTE2AVRTdfgJsevhlH32NKON+aezCfTRXv4kqmI/pCE1V+SH/p5LNAvMQ3UWh1d8Jl7CZNO3jO9EN9iZYeLhp9GnXHd0jQICRo3cjjmXVaZ5Sdnxgv8hOAx9KGFb/QSMRu7ECwrABfb+1EzECnWFlgZteWzRlyp3DGOzJXs4o5ENSZa/1X9cIufxXMmKGAcdEO3VZz0VdjJDUBXfkYdT5lagElhBx7l+zbwRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoXPtwqal9uIomWTrxXmTEWEZwrSNSxOO/JwDKeTm5U=;
 b=jQ3eER24EDepijZtI9vAzj1ouhRiv8xdhMwxsjiXORzghw2DvNA1bhk9ynyIq6isfxceqrw7TRZaM6G5Y72Us+2cp/AK1nD7lZevzZWnTPoLX40IUYuNTovYVomxM9ok1/QT4TDzWbrQNcIUfxd4C8HIj0Eqx1woLO9lXhZNQue9qppvIDHIXaxFPCo9AXuufiiL6RTmxoF8aaCkUx/B/IjeUQFOQhMLKjoUj3gyKTqYGwUjQOzDF7Rhw0dp7mIYZRDC4wNpyF6LqAvvXetgyvPQoZliRGM1Z9eHer/in7heKRZ8xnqM7ti9/z8Yv6NXdg1JKvj7FScPTM9YDbwhbA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by SJ2PR02MB10123.namprd02.prod.outlook.com (2603:10b6:a03:55e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 11:51:52 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9160.017; Thu, 9 Oct 2025
 11:51:52 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Manish Mishra
 <manish.mishra@nutanix.com>
Subject: Re: [PATCH v5 3/3] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Topic: [PATCH v5 3/3] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Index: AQHcOQWMmM6WUvnnZU6cl8ObCt65OrS5ngeAgAAVTQA=
Date: Thu, 9 Oct 2025 11:51:51 +0000
Message-ID: <16F108E5-79A7-4940-B3AB-BDB34EC4CA93@nutanix.com>
References: <20251009101420.3048487-1-tejus.gk@nutanix.com>
 <20251009101420.3048487-4-tejus.gk@nutanix.com> <aOePR-Jd5UX5DXAA@redhat.com>
In-Reply-To: <aOePR-Jd5UX5DXAA@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|SJ2PR02MB10123:EE_
x-ms-office365-filtering-correlation-id: 5d241ed3-d0b6-4156-2e2e-08de072a3c96
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z2x2ZC9RNXQ2VDJJNGhObCsxODh2ckpmSitWQ25zcHBKMjZGZFNpclYrdGx1?=
 =?utf-8?B?RHJ4TlJtQUxsYlRuNS92V2Nua0l0R1RKczl5Y2FnTGZ0ZnZzc0NjVkhpTmZR?=
 =?utf-8?B?QlFnYkp5aldhRGNBRCtuRGgyYi9CY0hXK3BjT2dvTUozRTJKWmtBS1NDSzdO?=
 =?utf-8?B?ZkhUQ3FuTDNoSUZOVTRFdGhLNTNOY0UyTnF1K0NrQWp0WlJYVEpTMmQrMjlZ?=
 =?utf-8?B?WGdHMm1IWlVSdVlLOWljZlpsLzdDdFNQWWNBQytJdGxWWUJ0SGUzbUdibjBT?=
 =?utf-8?B?ZmN1S0xMQ090dWN3V3puN1pRTXJqOW9WM3J2eklyT1VSYXJwZGp3ZlZlbVpD?=
 =?utf-8?B?TXd3ckhjNHp0Ym44c2h6SjY3NTZCL2t6cWlvTUVVYzJ2WHA4UjZkN3ErbFll?=
 =?utf-8?B?RHJia0I3T01yNVZhR3doVmg3VjlUQVhqU1ZhempCMmxEZGk3Y25IMWhhSDht?=
 =?utf-8?B?M2gvMHNoaFdQM0dkbUFHWGdxM2pHZkNTa25RbWRGZ2RZLzVHcDVkcy9KUjd5?=
 =?utf-8?B?NS8xcXR0bFdnRjVMYkF3ZjdGSVFjQ2pXZ2s5dXZOUFRjT1l6QzRQYUZLeFRI?=
 =?utf-8?B?cmZSdjRzRWNtc2lCUUVsYnRBRDVaSFZEYUVodVpFLzlaRmxpSmoxVWlVY2Nx?=
 =?utf-8?B?RVQvQXg4c0dNVEFGaCtDb0E0RXY1Ny9nNzNHU3FiOFRkK2d4WHR1MXNTN0Z1?=
 =?utf-8?B?ZDVib05pV2FDWUw5SDFtQW5haWgyYjI2ZXd4WnVjV3ZOUnRaWnpzZlJOTzN1?=
 =?utf-8?B?Mm1ISWFCM09WcHZZOWMvckV5Ly8vcWYySGZVbVcvWHRHR2RWMUlQT1dmeG5i?=
 =?utf-8?B?NkF5azFOQlpsSGxCUTcya1RkWGhvajhFeVYrcWZZWTBxTDJKQU9KVEZEek5U?=
 =?utf-8?B?YlRQdk9LUldIRzFkRys5U3UrUWw3RkVnWVNHM2I1V2ZLQmFMTWZyZWZ6ZFVl?=
 =?utf-8?B?SFNQOW5GMUVVQ0lZMTZHRlpoTFFlbi8wb1E3cGZHYllab0c4WnpoWk9GQlFI?=
 =?utf-8?B?N3p3RDNmYkJVRlpONEZodVBzSTk0WFN0UmpieG1xeXV4MU84clR6bnRxK1dS?=
 =?utf-8?B?cDF0TCt2WEo1TUtsVEJxN1BsQklsU1N5V1ZTaWErZWptSTltMnI4elEvOE5k?=
 =?utf-8?B?ZkVDRW45QU5hTkpNUnNCQTRxTlNFRjdHd2NKa0dLOVYrajFKMWJuY0h5Z1J4?=
 =?utf-8?B?VGNjdDd2Tkx2N2NKRmozSFdsbkhVUGpMK1J5V1VRcCt0S3lVRExsTGtBNkwv?=
 =?utf-8?B?NWQ4UmFTU2F6Wld0OGh4ZHZQVG1lWG51RHA3UUdmQW5lYzFuK2pkbmFkSUdE?=
 =?utf-8?B?cnFvclZZanNsMkw0eEx3N2FxRWh4SURrWnRsN1ZXK1N4dXpNWFdaRWt5empt?=
 =?utf-8?B?eEFPcHcxTHBVNFBnSm1TQS9wVVdLK2VpR09vVlYwRXVJSXZDL3dLUkF2TU4v?=
 =?utf-8?B?enpPcnErb1diRzA4dStsbTBoMG04Q01tTGZjUE9NYWV3R1paQUM3TjJibXRD?=
 =?utf-8?B?UFh5aFJENTd1MzFrbWxTZWltQUgvSzA4dVc0dUJUUVlHYjd1VjhlNHg2Q1I4?=
 =?utf-8?B?RmRzQWFGYUFWbjVObkx0N1VpMXVWWWYyQjZqVFRJam0yeHBWNUlDNTFpTUNn?=
 =?utf-8?B?WStrWjBleDNheXJ0bkt1MkFQUm5PV2lmQlZsdTJja2N0eFY0UUpSRW5Gdzl4?=
 =?utf-8?B?WUt1R3RyQU9NcGRweU84ZDNJUzhVaEticDhhRDZnNmdyRlZXSkdPcWlDd1dl?=
 =?utf-8?B?RFZ3SGlIMG02TkJlbVdoOFo1VnZ6NDZmZHZIbU5nV2N4NnFjNytTTFFCZ25j?=
 =?utf-8?B?M2ZQeit3T3dWRDlnSFk3N1NvVldoWXBaNWgybUNrTmxLank3Z3Ywdi92YUp2?=
 =?utf-8?B?cEFoQndQRTZaZHNERGFzaEhkekhzMWhxTGNtbzhaaytUVk4xelRZYWphT25U?=
 =?utf-8?B?NGhLTi94M0xGSUZJMmFGNlY3QzB2dkhaTGVSU3hrOTY5VXlFbUpDSFIrSnN1?=
 =?utf-8?B?S1BKNVlhbEV1cTdkd2QwN0g5ZnFadFBlWXRJbWl1Y3JDTU9veDFNS3VOdnRy?=
 =?utf-8?Q?oJoeQz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekE1WE9IUVN0aTFPU0E1RExIK3hTVVZ2c092NE9OQVhTWmNvcy9uUXlWbnBo?=
 =?utf-8?B?RUc4Q0lLWVEwOXR6Umxya0xwRHdTckVaRGh3T2FYa2pHY3JldGZQUytqVDZZ?=
 =?utf-8?B?dXhleTNxSEw1dk5KVGNVYUNjb0VaMG5yZ1ZNYVBOQUVKVWhXMFEzQzY1dzNC?=
 =?utf-8?B?S0UwclozNm1uVlpZREpPeGZhZUwxVUZIMVVXT05idWlnWVV4cEFmZW1kcnZ1?=
 =?utf-8?B?VC9BTzZIMStvK0x2ck9OeitOOHFHWi9IcUFveldNZlRjaGZudE1PTkF5Qmh0?=
 =?utf-8?B?bmlkbHNaaUgvdzVOYXUyNDlkaGh5d2FIOHpIY3Rodm4xckJFV0piTTdLcUQ3?=
 =?utf-8?B?TlM5bDZqZkFvQTA5WitFN2hVc3NpUTA0UXlnK2RLVHZUTWQwT2p4NS9qK2FJ?=
 =?utf-8?B?SGsxN0paTzlQbWQ0L0F2bngyTGxWbENacFVuTFRoNnlaTmpPd0J2M0pJMXlw?=
 =?utf-8?B?b2VHc3FTY3NEaG1XbjhaSlhHUVlhNFJLeTZWNFVsdExlVEZGcFNZNE40Z0FQ?=
 =?utf-8?B?ZnBIaFN3NWF2TDJmbnJSWmNlcEt6QzlFcWJiMWN2Y1pNUkZYYU1kZ2tiSzM5?=
 =?utf-8?B?UjFnNHo4R25yMkVlMmZ0U3BZVENOang0S2lmRDVoOFVKU2pWV1lhUzNPKzBk?=
 =?utf-8?B?WjNvTnhMOUQ1SUlMSGJ3dlVMK3BjdG0wNlptU0tCOTNlNktlSkpzM0lVV2s3?=
 =?utf-8?B?alFySU83SjRFN01udy90UUc2ZkswSFQ3RG9JOTZQZ2UxQUFNTHh5alV2OVYr?=
 =?utf-8?B?a1pDclF1MnlxckYyd2xRQ1B5ZWc5cnpkWEQzaitGOWpQUm9sNHVLWVpkaFdy?=
 =?utf-8?B?UWlZTmw3emVxaVdVNE1IZUJUVS9CVXl6NnMvWUgxSjAwdVFOSkNOU0lLWW1p?=
 =?utf-8?B?Mnh1VE9HRVBmUzBYeHNGbEtuYmI2emhMWmw0U2ZreGFMdGpSZ2tNanJKM2pU?=
 =?utf-8?B?Wks3VEg1d3VYM2J0OXRMZHhKRmloNllCVndDWGVSVE9oZkN2Y3hXVTBqR3lQ?=
 =?utf-8?B?ZVF5TkRQcmZVWGNiS2h0S0lRUi82anovQUJzRDNkSW95cHRHRE4yUSs4eFZ6?=
 =?utf-8?B?b3cvSmxYTnlDZGxqeWtXVllIb2tsVmkyeW5qSjdGV0ZQR3BIVXFQUm5DL09v?=
 =?utf-8?B?MU16UnJqS0NreEdkYzk2NE42OU5hU1hYYktQSEdnVVJVcE00Sm5Id1ZlaEpG?=
 =?utf-8?B?RVNNbUJWL3ZYOWJJQ0FTWEhMdVNBcFdwa3BmdXFKcWNkcXJ0STV1ZFR1eGVx?=
 =?utf-8?B?RlA4ZWRwTkFrTjhmSHpWaDNEQXA3UHUyS09pcklCc1pSR1VoeG5GVHBqdmdS?=
 =?utf-8?B?M3dMUlBlSXpla2RTK2dQUk84alBkV0lqYU93MkVvbXU0V3hFRlBuZVU2Qi9Q?=
 =?utf-8?B?dGVaZTVmaUpmZ2dIRzloYVIrRVJFd0hCOUIxRUZ0L0RyZUJFeE9XR2hDRnE2?=
 =?utf-8?B?bjNxaFdDa3NabVowZ0RtbDl2WmdoN2QzT2kvSGFOR0JqN1ZnOSs4OUNROThC?=
 =?utf-8?B?QW1zZWMxWnNaVGNlQ1AxOUJXd0hmaGxYTUN3eTN5bzhOWGNHQUlMa093UUxm?=
 =?utf-8?B?T1pzUnFrSGxCUHFvck1ReUdOK01CVzFVK0ZNMlc3K1htSmZuR3JrSTNjOU1J?=
 =?utf-8?B?ek1OSzA4Sy9DaFVkUGhHVE93ZEdaMUxVcnNoRlJSTFVlVzlxM210TlJlMURq?=
 =?utf-8?B?U3N1Y3dLRGxMbThrQkJ0Z0N1MGlvVHJaMlZBelBUOU1XeVVZZTVrWDk1NWhK?=
 =?utf-8?B?eGlNaWtQMmNyRFd6eWxxR2hLTDlhajAzWGFDUjd1Mk1RdjlTR3BZUmtRbDlE?=
 =?utf-8?B?OHN3REkrL2t4bmVQc3pNNU83MllFdVJRbkhUdC9MMEZDM0s0VjhrdWpiV3RJ?=
 =?utf-8?B?WDhiL0FjTnlXcEZ6Tkc3bVZPUXZQVnM4VmlxaE5abzlDZHpLbWNRY3Z3bEJO?=
 =?utf-8?B?Y2tmSUxFMFBSNkkxMUUxOW8xMGc5MENySUdCam1aNXdxdVFOUGhJdmp6dlVw?=
 =?utf-8?B?Tk9jZzFoSysvTlFGTGxLaE93ZmRmaEpabzdMZERtbHJ5bUM0ODBidmg3NDAy?=
 =?utf-8?B?MlFua2t1TUphNGd2NXpUNHdTZW9BUFBuVUV6MjllSDArLzV6L042c29EYUxp?=
 =?utf-8?B?QzZadjU2V3JMNHZVdVNFNVhiRHRYOVltaEk3OS9vaE1XT1A2R1F3dXhnRjE5?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FEA308BEAA0DC42805F59B2FACBB7F0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d241ed3-d0b6-4156-2e2e-08de072a3c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 11:51:51.9663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwrxxf6Hv58vddbAvOCcDmyr8dch27RsTEhR3f9kmmQq2p+67trCwQcUQexIqnAC7weCRprLrm+LLzruVVGgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10123
X-Proofpoint-GUID: dkb4GuhjDr0UaQONX9Hh8FGlzUaro72J
X-Proofpoint-ORIG-GUID: dkb4GuhjDr0UaQONX9Hh8FGlzUaro72J
X-Authority-Analysis: v=2.4 cv=A41h/qWG c=1 sm=1 tr=0 ts=68e7a1de cx=c_pps
 a=K7AEBdpZSLD1v8U6HgG+qg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=K1KtbSzvE7rnI21b5joA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA2OSBTYWx0ZWRfX8FQ20qoEeUKV
 GApDi9U7BhK+HHaEqnKJiNrE3vL1XcZxUTILARDqQF4VcR9/ZUDOZQD62rBNmmlohXfUJMxJ4h2
 kSK0aZm5pl/ZPvhkOwQhhVlzJi8yJxArxBRyUjVSdosArjBF1Fw+5UHgTNCYLdcZIL8FEkRqqU2
 8EGFxRvFaMEBz9CHd8OCT0gI85TUJq4BGk0qbMr3cMT+s0Od+7DcEeIHImcdTtzlpBq9cwyo4Lg
 mV8nwMTaFMHr1mvmgFK4b0nHGKJ1hu/51RQiK9MBKIVdCrCxhMqWYC22lt5n0/Uy9R+E78CdXYC
 9RrjhT402zfmaLyixTGftIjXYOGHhCi+MEf6o1wBWfk2q9lhpx/51mO8Szj40Izypmn6S4cEv6U
 J2HCg5h5WzhVtQZtCNN0P25m9c66cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gT24gOSBPY3QgMjAyNSwgYXQgNDowMuKAr1BNLCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxi
ZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElP
TjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gVGh1LCBPY3Qg
MDksIDIwMjUgYXQgMTA6MTQ6MThBTSArMDAwMCwgVGVqdXMgR0sgd3JvdGU6DQo+PiBGcm9tOiBN
YW5pc2ggTWlzaHJhIDxtYW5pc2gubWlzaHJhQG51dGFuaXguY29tPg0KPj4gDQo+PiBUaGUga2Vy
bmVsIGFsbG9jYXRlcyBleHRyYSBtZXRhZGF0YSBTS0JzIGluIGNhc2Ugb2YgYSB6ZXJvY29weSBz
ZW5kLA0KPj4gZXZlbnR1YWxseSB1c2VkIGZvciB6ZXJvY29weSdzIG5vdGlmaWNhdGlvbiBtZWNo
YW5pc20uIFRoaXMgbWV0YWRhdGENCj4+IG1lbW9yeSBpcyBhY2NvdW50ZWQgZm9yIGluIHRoZSBP
UFRNRU0gbGltaXQuIFRoZSBrZXJuZWwgcXVldWVzDQo+PiBjb21wbGV0aW9uIG5vdGlmaWNhdGlv
bnMgb24gdGhlIHNvY2tldCBlcnJvciBxdWV1ZSBhbmQgdGhpcyBlcnJvciBxdWV1ZQ0KPj4gaXMg
ZnJlZWQgd2hlbiB1c2Vyc3BhY2UgcmVhZHMgaXQuDQo+PiANCj4+IFVzdWFsbHksIGluIHRoZSBj
YXNlIG9mIGluLW9yZGVyIHByb2Nlc3NpbmcsIHRoZSBrZXJuZWwgd2lsbCBiYXRjaCB0aGUNCj4+
IG5vdGlmaWNhdGlvbnMgYW5kIG1lcmdlIHRoZSBtZXRhZGF0YSBpbnRvIGEgc2luZ2xlIFNLQiBh
bmQgZnJlZSB0aGUNCj4+IHJlc3QuIEFzIGEgcmVzdWx0LCBpdCBuZXZlciBleGNlZWRzIHRoZSBP
UFRNRU0gbGltaXQuIEhvd2V2ZXIsIGlmIHRoZXJlDQo+PiBpcyBhbnkgb3V0LW9mLW9yZGVyIHBy
b2Nlc3Npbmcgb3IgaW50ZXJtaXR0ZW50IHplcm9jb3B5IGZhaWx1cmVzLCB0aGlzDQo+PiBlcnJv
ciBjaGFpbiBjYW4gZ3JvdyBzaWduaWZpY2FudGx5LCBleGhhdXN0aW5nIHRoZSBPUFRNRU0gbGlt
aXQuIEFzIGENCj4+IHJlc3VsdCwgYWxsIG5ldyBzZW5kbXNnIHJlcXVlc3RzIGZhaWwgdG8gYWxs
b2NhdGUgYW55IG5ldyBTS0IsIGxlYWRpbmcNCj4+IHRvIGFuIEVOT0JVRiBlcnJvci4gRGVwZW5k
aW5nIG9uIHRoZSBhbW91bnQgb2YgZGF0YSBxdWV1ZWQgYmVmb3JlIHRoZQ0KPj4gZmx1c2ggKGku
ZS4sIGxhcmdlIGxpdmUgbWlncmF0aW9uIGl0ZXJhdGlvbnMpLCBldmVuIGxhcmdlIE9QVE1FTSBs
aW1pdHMNCj4+IGFyZSBwcm9uZSB0byBmYWlsdXJlLg0KPj4gDQo+PiBUbyB3b3JrIGFyb3VuZCB0
aGlzLCBpZiB3ZSBlbmNvdW50ZXIgYW4gRU5PQlVGIGVycm9yIHdpdGggYSB6ZXJvY29weQ0KPj4g
c2VuZG1zZywgZmx1c2ggdGhlIGVycm9yIHF1ZXVlIGFuZCByZXRyeSBvbmNlIG1vcmUuDQo+PiAN
Cj4+IENvLWF1dGhvcmVkLWJ5OiBNYW5pc2ggTWlzaHJhIDxtYW5pc2gubWlzaHJhQG51dGFuaXgu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVGVqdXMgR0sgPHRlanVzLmdrQG51dGFuaXguY29tPg0K
Pj4gLS0tDQo+PiBpbmNsdWRlL2lvL2NoYW5uZWwtc29ja2V0LmggfCAgNSArKysNCj4+IGlvL2No
YW5uZWwtc29ja2V0LmMgICAgICAgICB8IDc4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0NCj4+IG1pZ3JhdGlvbi9tdWx0aWZkLW5vY29tcC5jICB8ICAzICstDQo+PiBtaWdy
YXRpb24vbXVsdGlmZC5jICAgICAgICAgfCAgMyArLQ0KPj4gNCBmaWxlcyBjaGFuZ2VkLCA3MiBp
bnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaW8vY2hhbm5lbC1zb2NrZXQuaCBiL2luY2x1ZGUvaW8vY2hhbm5lbC1zb2NrZXQuaA0KPj4g
aW5kZXggMjYzMTlmYTk4Yi4uZmNmZDQ4OWM2YyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaW8v
Y2hhbm5lbC1zb2NrZXQuaA0KPj4gKysrIGIvaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5oDQo+
PiBAQCAtNTAsNiArNTAsMTEgQEAgc3RydWN0IFFJT0NoYW5uZWxTb2NrZXQgew0KPj4gICAgIHNz
aXplX3QgemVyb19jb3B5X3F1ZXVlZDsNCj4+ICAgICBzc2l6ZV90IHplcm9fY29weV9zZW50Ow0K
Pj4gICAgIGJvb2wgYmxvY2tpbmc7DQo+PiArICAgIC8qKg0KPj4gKyAgICAgKiBUaGlzIGZsYWcg
aW5kaWNhdGVzIHdoZXRoZXIgYW55IG5ldyBkYXRhIHdhcyBzdWNjZXNzZnVsbHkgc2VudCB3aXRo
DQo+PiArICAgICAqIHplcm9jb3B5IHNpbmNlIHRoZSBsYXN0IHFpb19jaGFubmVsX3NvY2tldF9m
bHVzaCgpIGNhbGwuDQo+PiArICAgICAqLw0KPj4gKyAgICBib29sIG5ld196ZXJvX2NvcHlfc2Vu
dF9zdWNjZXNzOw0KPj4gfTsNCj4+IA0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvaW8vY2hhbm5lbC1z
b2NrZXQuYyBiL2lvL2NoYW5uZWwtc29ja2V0LmMNCj4+IGluZGV4IDhiMzBkNWI3ZjcuLjIyZDU5
Y2QzY2YgMTAwNjQ0DQo+PiAtLS0gYS9pby9jaGFubmVsLXNvY2tldC5jDQo+PiArKysgYi9pby9j
aGFubmVsLXNvY2tldC5jDQo+PiBAQCAtMzcsNiArMzcsMTIgQEANCj4+IA0KPj4gI2RlZmluZSBT
T0NLRVRfTUFYX0ZEUyAxNg0KPj4gDQo+PiArI2lmZGVmIFFFTVVfTVNHX1pFUk9DT1BZDQo+PiAr
c3RhdGljIGludCBxaW9fY2hhbm5lbF9zb2NrZXRfZmx1c2hfaW50ZXJuYWwoUUlPQ2hhbm5lbCAq
aW9jLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgYmxvY2ssDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKTsNCj4+ICsjZW5kaWYNCj4+ICsNCj4+IFNvY2tldEFkZHJlc3MgKg0K
Pj4gcWlvX2NoYW5uZWxfc29ja2V0X2dldF9sb2NhbF9hZGRyZXNzKFFJT0NoYW5uZWxTb2NrZXQg
KmlvYywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVy
cnApDQo+PiBAQCAtNjYsNiArNzIsNyBAQCBxaW9fY2hhbm5lbF9zb2NrZXRfbmV3KHZvaWQpDQo+
PiAgICAgc2lvYy0+emVyb19jb3B5X3F1ZXVlZCA9IDA7DQo+PiAgICAgc2lvYy0+emVyb19jb3B5
X3NlbnQgPSAwOw0KPj4gICAgIHNpb2MtPmJsb2NraW5nID0gZmFsc2U7DQo+PiArICAgIHNpb2Mt
Pm5ld196ZXJvX2NvcHlfc2VudF9zdWNjZXNzID0gRkFMU0U7DQo+PiANCj4+ICAgICBpb2MgPSBR
SU9fQ0hBTk5FTChzaW9jKTsNCj4+ICAgICBxaW9fY2hhbm5lbF9zZXRfZmVhdHVyZShpb2MsIFFJ
T19DSEFOTkVMX0ZFQVRVUkVfU0hVVERPV04pOw0KPj4gQEAgLTYxOCw2ICs2MjUsOCBAQCBzdGF0
aWMgc3NpemVfdCBxaW9fY2hhbm5lbF9zb2NrZXRfd3JpdGV2KFFJT0NoYW5uZWwgKmlvYywNCj4+
ICAgICBzaXplX3QgZmRzaXplID0gc2l6ZW9mKGludCkgKiBuZmRzOw0KPj4gICAgIHN0cnVjdCBj
bXNnaGRyICpjbXNnOw0KPj4gICAgIGludCBzZmxhZ3MgPSAwOw0KPj4gKyAgICBib29sIGJsb2Nr
aW5nID0gc2lvYy0+YmxvY2tpbmc7DQo+PiArICAgIGJvb2wgemVyb2NvcHlfZmx1c2hlZF9vbmNl
ID0gZmFsc2U7DQo+PiANCj4+ICAgICBtZW1zZXQoY29udHJvbCwgMCwgQ01TR19TUEFDRShzaXpl
b2YoaW50KSAqIFNPQ0tFVF9NQVhfRkRTKSk7DQo+PiANCj4+IEBAIC02NjMsMTAgKzY3MiwyNiBA
QCBzdGF0aWMgc3NpemVfdCBxaW9fY2hhbm5lbF9zb2NrZXRfd3JpdGV2KFFJT0NoYW5uZWwgKmlv
YywNCj4+ICAgICAgICAgY2FzZSBFSU5UUjoNCj4+ICAgICAgICAgICAgIGdvdG8gcmV0cnk7DQo+
PiAgICAgICAgIGNhc2UgRU5PQlVGUzoNCj4+IC0gICAgICAgICAgICBpZiAoZmxhZ3MgJiBRSU9f
Q0hBTk5FTF9XUklURV9GTEFHX1pFUk9fQ09QWSkgew0KPj4gLSAgICAgICAgICAgICAgICBlcnJv
cl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJQcm9jZXNzIGNhbid0IGxvY2sgZW5vdWdoIG1lbW9yeSBmb3IgdXNpbmcgTVNHX1pF
Uk9DT1BZIik7DQo+PiAtICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4+ICsgICAgICAgICAg
ICBpZiAoZmxhZ3MgJiAoUUlPX0NIQU5ORUxfV1JJVEVfRkxBR19aRVJPX0NPUFkgfA0KPj4gKyAg
ICAgICAgICAgICAgICBRSU9fQ0hBTk5FTF9XUklURV9GTEFHX1pFUk9fQ09QWV9GTFVTSF9PTkNF
KSkgew0KPiANCj4gDQo+IFRoZXJlIGFyZSBvbmx5IHR3byBjYWxsZXJzIHdoZXJlIHRoaXMgcGF0
Y2ggaGFzIGFkZGVkIHVzZSBvZg0KPiBRSU9fQ0hBTk5FTF9XUklURV9GTEFHX1pFUk9fQ09QWV9G
TFVTSF9PTkNFLg0KPiANCj4gQm90aCBvZiB0aGVtIGFscmVhZHkgc2V0dCBRSU9fQ0hBTk5FTF9X
UklURV9GTEFHX1pFUk9fQ09QWSwgc28NCj4gdGhpcyBjb2RlIGJyYW5jaCB3YXMgYWxyZWFkeSBi
ZWluZyB0YWtlbg0KPiANCj4gSU9XLCB0aGlzIG5ldyBRSU9fQ0hBTk5FTF9XUklURV9GTEFHX1pF
Uk9fQ09QWV9GTFVTSF9PTkNFIGxvb2tzDQo+IHBvaW50bGVzcy4NCj4gDQoNClRoZSBpbnRlbnRp
b24gb24gYWRkaW5nIFFJT19DSEFOTkVMX1dSSVRFX0ZMQUdfWkVST19DT1BZX0ZMVVNIX09OQ0Ug
d2FzIHRvIGxldCBjYWxsZXJzIGRlY2lkZSBpZiB0aGV5IHdhbnQgUUVNVSB0byBzaWxlbnRseSBm
bHVzaCBhbmQgbm90IHRocm93IGFuIEVOT0JVRlMuDQpSaWdodCBub3cgaXQgZml0cyBmb3IgdGhl
IG1pZ3JhdGlvbiB1c2UtY2FzZSwgc2luY2UgbWlncmF0aW9uIGlzIHRoZSBvbmx5IGNhbGxlciB1
c2luZyBNU0dfWkVST0NPUFkgaW4gdGhlIGZpcnN0IHBsYWNlLCBidXQgaW4gY2FzZSBzb21lb25l
IGVsc2UgZGVjaWRlcyB0byB1c2UgTVNHX1pFUk9DT1BZLCBhbmQgd2FudHMgdGhlIHJlZ3VsYXIg
c2VtYW50aWNzIG9mIGEgd3JpdGUsIGkuZSwgZXhwZWN0aW5nIGFuIEVOT0JVRlMgb24gYSBzb2Nr
ZXQgZXJyb3IgcXVldWUgcGlsZXVwLCB0aGV5IG1heSBjaG9vc2Ugbm90IHRvIHBhc3MgdGhlIGZs
YWcsIHJhdGhlciB0aGFuIGxldHRpbmcgUUVNVSBkb2luZyBpdCB1bmNvbmRpdGlvbmFsbHkuDQoN
Ckhvd2V2ZXIsIEkgbWlnaHQgYmUgb3ZlcnRoaW5raW5nIHRoaXMsIGlmIHRoZSB1c2VjYXNlIHdo
aWNoIEkgbWVudGlvbiBhYm92ZSBkb2Vzbid0IG1ha2Ugc2Vuc2UsIEkgY2FuIGRyb3AgdGhpcyBm
bGFnLg0KDQoNCnJlZ2FyZHMsDQp0ZWp1cw0KDQo=

