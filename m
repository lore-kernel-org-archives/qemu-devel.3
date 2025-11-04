Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E12FCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 20:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGNiS-0002M3-GV; Tue, 04 Nov 2025 15:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vGNiP-0002Lo-2v
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 15:33:17 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vGNiM-0006ZS-1L
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 15:33:16 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4GbJ133855741; Tue, 4 Nov 2025 12:33:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PxUENfl1kkbYvNpSEsmQGRrUXAbRI9KlphoRer4Qv
 78=; b=RGBcBiiienf3UnMjAqTtPgalojL6aJ2cT8eTaaTub/n4L13qWTt9JO9wO
 GLre3wPJH4vdgSMSVv9DRxOAn7g0R0KVyyqnp9YA+X88nk/Uq5whY4sGTqA/57xD
 D1Kh9L/nVfrI4XjLzwJoaFHA1JLrpuST/nxQstoErmH2FF31nc6q+J+xkKltye7M
 cF2sSsQ7j5wS+Umihi+FW2pJ0C5vCAIOXia+tGyJ9wQoTnpqbG1G1r6RCJc1ZmD5
 UKbbS/GXA1Sgqg7FgktfFnnuA1RUCSAEREzShWZ8zpBOkhaq8gwNe5uQle6C8cb0
 BZb4kv3bVrQ3T8tIKNf1uhs9eRhZQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021118.outbound.protection.outlook.com [52.101.52.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a7n5srhgc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Nov 2025 12:33:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZXz294J5LridGao7Ua3DI6oSwrF2yQUa28ldSJKl/TxwKzlXeH7Ml5jJ5n7yTCVcqRMMgXRuz2NSDwVSgJFfWTmegsmKtt8exuQIU2LHWFYdgxX0DLlGxdkIfC6e+bJYSsd8tJwoOfksM/npUkIKgsgBon3ODkM9tVFD0jk9ffxD9Z7c4gU81tWYnPAYrnIPEQz1sCCYvJmEENQJhafELvp9a1QgFPIOT+6ysVvsFmmxFzXX3KqeUncuAFVyDQEENiLjruFk0vxjTdmLievR2OnxAcgzvVZf2qrh3CSIlyeYugnXoexbnvluYgs4gjgJpQd8UeVLSm0xBXZMR8QiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxUENfl1kkbYvNpSEsmQGRrUXAbRI9KlphoRer4Qv78=;
 b=alVwYXm3lCJkQB0flgpe9icNZvr1mI2oQ3bG3vYqmD7gkM1CYNyTWRe7oQCuogNEcGK2BO7RK/9Rc9+MWGlG1+V8JvgLw7ClkxchaZWCzYwDtla0KkhlKHkzOL8QJ3cCsHCI706Fypx4TPgcLyvEuXb22rwUIfYUhCqQgY8JhRcanHz0Gnu8iuJrxha8xOsfHXgs/ZUjxLSREDZID351i+oNAg43+u/uAx4EUVyLt+O3fNeZxLnOPm2bfT7ovbYZsiHOweRBV4Ux2SbQ7Ij6Au25HL20YJTnSpbIgFG+4Tv649+BqyOapZdYMHE4iZ52psjslHa8IWazNbrj54Tfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxUENfl1kkbYvNpSEsmQGRrUXAbRI9KlphoRer4Qv78=;
 b=PDqcc6jBAYd8CTF7502878bJIlEJkqMZq0L+cp1klcstCwIo+r7K+YytifGN2b0MIa+1N07Ql5m2cK2FY2QBLi/DLbs2DWCrGJU0FVAcTXfX2xCK1aCLLZJ8he7DHWWi+hTJisCDKLOkOupEJgmu+3cAhU2SmuyBvbr5mse0EohqP6pQE2e1x2dW1PokmWoTbsYPugYXd7vRen7rlyVQFj/bdwtVZop1C67RweNRbfx8yBDcnh8fo7S2Es3f6VwTTjdDtNmU+vfdX/qDCOA0fZFoJSYbWBEdOPXys6+XJRBrdh3t+gP4sPUDdn1nou5CGsxlnYiC7I/fahxuy8nXOw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA1PR02MB8368.namprd02.prod.outlook.com
 (2603:10b6:806:1f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 20:33:06 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 20:33:06 +0000
From: Jon Kohler <jon@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "ankur.a.arora@oracle.com"
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH] util/oslib-posix: increase memprealloc thread count to 32
Thread-Topic: [PATCH] util/oslib-posix: increase memprealloc thread count to 32
Thread-Index: AQHcTO4G/V+qXBvm4Uy+K4zBTpaW/LThc90AgAGGrYA=
Date: Tue, 4 Nov 2025 20:33:05 +0000
Message-ID: <545E78A6-6013-45E1-9C3B-7D027FF12E00@nutanix.com>
References: <20251103185750.1394036-1-jon@nutanix.com>
 <aQka0DTrVsJrfU5z@redhat.com>
In-Reply-To: <aQka0DTrVsJrfU5z@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SA1PR02MB8368:EE_
x-ms-office365-filtering-correlation-id: ec7c2349-8ba8-439e-8235-08de1be15c16
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?S2x3QWdWWFhSS2VCNEZ2cFpQNzFFa2lBTVRPaUJRNU5YTWl1TDI3S082QkVr?=
 =?utf-8?B?TnpQODBsUjRtR2Y1YTkxVkU3SFprVzd4b2xUOUZHMTYyaWUvWm50QjNXUStE?=
 =?utf-8?B?UlpiL0dqd1c1TFBieCtKQWdYVUdEUEpOVWxydjVDcUN0V3JXUHU3OTErZG92?=
 =?utf-8?B?OTlMdlZPMzUyVGRDTHhCNmN6ZmczU2RQRXdJVjlCQnJ5QTN0a0pmaHFDeDR2?=
 =?utf-8?B?WUVvZGdLS1o4TEdSS1kzOTM1VjFTVFhMNWJqWFBGNVpIckxOMG1ldWhMK3ht?=
 =?utf-8?B?am13eTFqdCsxNCs2S0RyMTQ1QTdlWlV5Rm1qZEdNcGRvMEZTNzFOSlhHYkxH?=
 =?utf-8?B?ZjY0MlhENW5zMGl0cTNzS2tiUHFHNzB2M1dZMGN1NmZiYjFJWmhYYXFESVJL?=
 =?utf-8?B?SHVOWG13bit6RWp5d0NxRjcrVHJJYXBwb1VBQ1RrNS8yTmx4L1NoU3N2OFF2?=
 =?utf-8?B?UW1ka3c4SGtGNS9tUm0rUmNJd0NIZEcvWENnaS91M0xadGNzam0yazQ3UXhE?=
 =?utf-8?B?amh2NHJtRHlGT0pBZUhDMlY5TUUyVk1UbmJ6MzVvUmZFKzB5bmNxM2RvamNz?=
 =?utf-8?B?aWdzdm9KK2NaeXg4YXZ5SjRkd3V4eWlyUnYwNjUxQTJDRTZadHdrUE02NzV0?=
 =?utf-8?B?cmN0SVg1UEJQTm1Qbm16U1I4Y1NRTEpQWFR3Z1JhTFBhRE90ckhrMURvNlRt?=
 =?utf-8?B?V2c3WGhQUmFKM0Z0V0ttUUwwMG43ZjlVWm03NDg5L28yOTVMSnd1dURxTTlW?=
 =?utf-8?B?Q3dtUWFKazZkNUhkdlBjeDFKVlJKMHpVWGMrUzYzN3cwcEZ0RitjS0d4TkVP?=
 =?utf-8?B?di9rb09yblVyL2dJZ2ozOVFNc1pOR0EwU3k1c2ZaKzY2Ri83Zm9BalVKTk42?=
 =?utf-8?B?aUh5MjZiSGcvTDk2c2hKZmNPWGN0cjVLT3N0Y050SlhTSWpRSlZ2TnorNUZZ?=
 =?utf-8?B?VE0yd2ErTWcvQ1VKRER5aFJFM091ckEvaVkzRWJlci9XdnB6VDlYTmd1N2hP?=
 =?utf-8?B?TmcwTWVWZm1wejdKYjJ5NTE0amlaV0k4UnpFRXdWeDdwNXdJZHdXZCtIaHVF?=
 =?utf-8?B?ZlZnNTI5S2RpaFVBTndzQnVodFN2RUZFSlphTGVjbEdJTE1FQVcvejJNcDBF?=
 =?utf-8?B?V2NRTXlUdzdocmJMYk1SYUlxL3hJeFJ6bGhzaW96OGtWWis3MDdpVzhIN2J0?=
 =?utf-8?B?dTJreXM1Zm9sMFdab0pxOTFGQ3l4cENRMloydVQxTlRKR3ROdFFLbXZJT0xM?=
 =?utf-8?B?bzUxMTBUaDE0bmgvMnFrUThSRjRGNWNwZm0yVU91NmlDQm9ZRjRjYUU5ZlRz?=
 =?utf-8?B?YStDeTYwclJuVHJVV044MXZ4dVErVC9tNmJTSVJGdnkxWE9pZktneTRENldK?=
 =?utf-8?B?cStvUjlQYWJ5U3lVZC92eGRQaVZzT280RU5IM1VJUW5rdW1LbkRVbnVSRVh2?=
 =?utf-8?B?R0N4dEdLR0U4VmFENWFWY3lYNndELzJ0Tm1vSmlIZllPUVQzS09nejBkOGdH?=
 =?utf-8?B?SXdCRUtjRitaN29NTmsyMnpZaERGWXN6T1dzSjNtQzA2ZUErdW1qK3dJVStL?=
 =?utf-8?B?dDlBWVlGSFFsK3F1eU5BTHc3RVdRZ3ZVSXdZOGdqZWpoaE1RTFNvVG1HUmN0?=
 =?utf-8?B?SjFwMHhkdlNBK00xVXBCWTI2ZkdHVUVqWms0eHhuQVZ6ZERvbktXTktzQVZV?=
 =?utf-8?B?WFRET0lVOTErbEFDZmMvRzZSbkpKeVBiQ3BoeGRCcFk1c0NSNjJmbEFsdjAx?=
 =?utf-8?B?TThacktwVkhoeXh4YytyajZzOE44VW5WTmtwYWFZdzlyVEdvWStqL2VDd2Ji?=
 =?utf-8?B?SVMzbG91aUNybEhMYkNHRklaUG1XSVZjVm01RURpeDVLcTc2dFMreEpWeWNC?=
 =?utf-8?B?TVBlQm9tc2tCdXltc0wrVU5KdmFPSEFVVXU5TDZaVWs4dHdUNjRLb3ZvbDR0?=
 =?utf-8?B?a0hPSTVFMStFcmdZWlZ4VGZFYWRuZ09jWStzZjJ2TDR6bXV2TVJObHNQY200?=
 =?utf-8?B?WFVzeTZWOGZHbTZPWkxGTk1sLzJoYXhtamxlbzlybW1jNXc1K2RaTHFadUZT?=
 =?utf-8?Q?Ym9lKe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVJtZ1dqV0xHU1JETXhTMUw3dENrWjBOUm5rd2NlVGxJQW45MUFObDVGR29F?=
 =?utf-8?B?TUEvYjBjeUg4YXJjazlEbGNXZXJsbHhzMlVnMEtCT0x6UnVMUHo0SHRLUEdq?=
 =?utf-8?B?WFlHRWZqSHJTRVlnMWg0V3RONElVL1ZtVmc5YVpMVXAwM2l6djFoci9XWk5H?=
 =?utf-8?B?YmNET0pMYW9kVFBFMmpISkcrOHlyVmlIdE9TWVFLRVJrMWc3OFNmYjBXWUgz?=
 =?utf-8?B?WDVMYUVOY3JlYnF4ajVqOFpzbk03Z2pNcWpsRUdyQUgzclpZNERybUFJOUtD?=
 =?utf-8?B?OVJiMXlsckRkVkI0OG9YMGsxS2hVZ3NWeDFTWFlnV1E5SUtVVXFWNCtCMzZW?=
 =?utf-8?B?dmV0aEg3Y0F1Y2syUDRrZHhKOE90Mk9tNlBOQjlzenFneEZHOVNTay9ER0Nl?=
 =?utf-8?B?bXl5WVlieDVQV2xPeGRIVEo1UjU4aWtpVDJYL2J6T2V4M0pGaEltZFgwS3JI?=
 =?utf-8?B?M2tCblg4L21MVTZpV0VtNXF2RFdkVXZqRTg5bnQxMGtmM0Q1WmgvU1ppcElD?=
 =?utf-8?B?Q2JYK29xaUo3ajJOSGRCQ2U3Kzk4c24yb2JETzFZM2ZSVmdXelkySVFxTkV5?=
 =?utf-8?B?VzBUZ3JLRytXY2tpQ3VDS1pveEhUYThKa2xCaFczVnQ0Q2pkaGIwYVBCNG5V?=
 =?utf-8?B?ZklZTEJnNXpsa2dpV2gydWQ0Y3BTM1VLdVlEY0JhUHdRWVdybUtlWnFvSmZ1?=
 =?utf-8?B?K0dpK1llZHhlL2N4V1BVWmhoZVIzQTF3ZnpkZkJsRHNzQ1Z4ZmVra0s5eHNp?=
 =?utf-8?B?N0FHejdDdlNEYUdXanNvYW9iSkZFNWVHU2hVME4yUjYvdDlUQzNxR0FkZmZz?=
 =?utf-8?B?RmduclJqdHp3Rkh4MitOekk3dURDbk9IT015V0daVXJqa2x6YnIvZEIrVWRk?=
 =?utf-8?B?VnlpVjhhTlp0Mmp2Ukt4LzVwS3JwWEZhRFdCSHlveVhRYkkxaGQ1UmswMFpD?=
 =?utf-8?B?Ri81K1BPU3p5WURPd1dNNFhseThBZVRkeVNEcGM1UEk4SktNS0JJd1o1NUg5?=
 =?utf-8?B?aksyUGd2SDNNdVF0dEc3Q0Mya0E2OFBhYUhtRStWTmIwZjN5SW1IOXp4bytD?=
 =?utf-8?B?YlArRFV1NDJVN3V3QWNYU2IrOU9HeVZwdFdCc2l0dVU3bUhkc2NjTHFtTDJE?=
 =?utf-8?B?bnB6ZW5jMjRXSEE4UzR1Nk42N3JNYTcyU3U5c0p4Wk9abE1ZY3BRNFJERDI2?=
 =?utf-8?B?ZE1VVlpRSHV3WFBuVkx1dVJZS2FxQXdRRzkwRmduVVQ2TS9WUGRmc2I2R2lM?=
 =?utf-8?B?UkhMZzVobmVPU0FEdWp4SVBQYkJmUmNyQzJkclp4ZFZJZmRiMFlhcHFzek14?=
 =?utf-8?B?aXlLS21Pb0oyM0hsV3dyT0p0Q1lad0hRdEI5SGNlZS9Sblg3OXhxZUZzNEdL?=
 =?utf-8?B?bzFTc3RkYWozWE96by9DOVNKYU5ReDdoVmVJKzQyYjdHVXhJbGpVQUNEcmVK?=
 =?utf-8?B?WWJ3ZC93NUVFZE8rNjZUWk9PL1llSG5EYW5rV1dxNDF5NkRaSWlmZ0xjWWp0?=
 =?utf-8?B?cXZzVC9sRkg1WGp1R2h4Ky9MVjlZQTdXTzlScFFDUEh1cGJpbGlPWGlHWTha?=
 =?utf-8?B?Skp3ZzQ2SEZSdTFDNE5SeDRFbi9IM0FEaVZLUklMQ1FIdEVjTmdhTEhiSkJ1?=
 =?utf-8?B?Rll5Sk9hKy9UcFBnWjU2VDVOMjg2elhuWTZuS0tvdXh5S2dKb1o3RnFUMEFt?=
 =?utf-8?B?VVZxWktFUHEraXp4RXZGaWZRQmRSbHc2UE5xcHRyQjYrQm9LNGUzZU4zOGlO?=
 =?utf-8?B?a2FDWjg3R0I5OE1EcDk5dURUdk1sbkJWbk4raGthSmJIT2VFaGk5NkVac2c3?=
 =?utf-8?B?RGduZmVEZWM0SFdBR2VsdjNKNlUvRnlES1VyK3ZCVUIramxOeE1rblBDV2o4?=
 =?utf-8?B?bGozVTVGK2pjZjlhb09YK1NIUmtqQURBQmtXU1ZrdkQ5UWtNTzRQQmptWXZO?=
 =?utf-8?B?cHpkRVM3eFAvWmN2eEZ6elpTcjlYVTBGNWE3azFLTHZ4VlNRcGVvcnBKRDBH?=
 =?utf-8?B?bEJ4S0l3dmhoQlZEczNveFZ1SWJmZ29PY0JGSzJWK0E1ZnlyZm14MVFFUjlv?=
 =?utf-8?B?MCtMa21NdnRRQXpDdkVialI4TTVybFhxL0lDcWxac1grQmYvNldpaEZLYklK?=
 =?utf-8?B?RjgwVWppVWZBbDhVejRVL3F0bmVHNnA0eWlZVVlhKzZhNTlSTjYxK2JXcmdT?=
 =?utf-8?B?R1U4NnNaUmVPaUg5NHB2R3drd0VMVGlqSnB2NHhoY0pmNG13ckdaYVQ1TmRl?=
 =?utf-8?B?aE54Vnl1czZKNnBMWjBwLzFFMG9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C302358A59174246AE2C24DCEDFE7DB6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c2349-8ba8-439e-8235-08de1be15c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 20:33:05.9178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2IhFK8eXobq6OPYjricjImjmZfthINULs6unKBmMmFoyQbpqCCYPGU3bkTJrNJ9dd2idK81O5Z5O3CHE8cCqsD5f+YD7PMS9H22gCuw/Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8368
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE3MiBTYWx0ZWRfX9EaG7Ygj84tG
 Bb6VsSq115ZANoFSkxIq5eYO2c9oTLxtWzvEyZUy55PAEMDaVh/tPcxbojIxc6uwwmZgTKNlIeC
 Zn5CTui0NKE8X7UvBmQoitUZw9rf4Z4mnjgzDTykDZkeuBhmbM6ca6lvNK5c7mll4gK2xcw7jRY
 Id7G8k1zd8tUv3Bx+lGaiZbOwp0DOWGTQpTvDOdK5C6lLca5kfhaMlvMXFFakQc2Y/ESyEp466X
 Q2eS1dIVU+A2D2mKHQwdCw9levvke/Z+BW+j30PljBguyzROM3J7CHGWDgTPDnNr0cqhq1Ga1yl
 p+Mr3N+Rv70FByqSPhgbUsSlH/qsSiQ47bQyg7GkBu3lKktm+IBuKKEWNiqYgOHTl75q8R9QibO
 bG8UP28pHnHFYiuGavLR7OTTyHYTyw==
X-Authority-Analysis: v=2.4 cv=E57AZKdl c=1 sm=1 tr=0 ts=690a6305 cx=c_pps
 a=GSMvsngYcio1OY3xt1HY6A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=-X4oLmRFHOi7QKFyuCcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2K8qVj8DvaAMnAebdiyTAAkqbWIPG-su
X-Proofpoint-ORIG-GUID: 2K8qVj8DvaAMnAebdiyTAAkqbWIPG-su
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gT24gTm92IDMsIDIwMjUsIGF0IDQ6MTTigK9QTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIE5vdiAwMywgMjAyNSBh
dCAxMTo1Nzo1MEFNIC0wNzAwLCBKb24gS29obGVyIHdyb3RlOg0KPj4gSW5jcmVhc2UgTUFYX01F
TV9QUkVBTExPQ19USFJFQURfQ09VTlQgZnJvbSAxNiB0byAzMi4gVGhpcyB3YXMgbGFzdA0KPj4g
dG91Y2hlZCBpbiAyMDE3IFsxXSBhbmQsIHNpbmNlIHRoZW4sIHBoeXNpY2FsIG1hY2hpbmUgc2l6
ZXMgYW5kIFZNcw0KPj4gdGhlcmVpbiBoYXZlIGNvbnRpbnVlIHRvIGdldCBldmVuIGJpZ2dlciwg
Ym90aCBvbiBhdmVyYWdlIGFuZCBvbiB0aGUNCj4+IGV4dHJlbWVzLg0KPj4gDQo+PiBGb3IgdmVy
eSBsYXJnZSBWTXMsIHVzaW5nIDE2IHRocmVhZHMgdG8gcHJlYWxsb2NhdGUgbWVtb3J5IGNhbiBi
ZSBhDQo+PiBub24tdHJpdmlhbCBib3R0bGVuZWNrIGR1cmluZyBWTSBzdGFydC11cCBhbmQgbWln
cmF0aW9uLiBJbmNyZWFzaW5nDQo+PiB0aGlzIGxpbWl0IHRvIDMyIHRocmVhZHMgcmVkdWNlcyB0
aGUgdGltZSB0YWtlbiBmb3IgdGhlc2Ugb3BlcmF0aW9ucy4NCj4+IA0KPj4gVGVzdCByZXN1bHRz
IGZyb20gcXVhZCBzb2NrZXQgSW50ZWwgODQ5MEggKDR4IDYwIGNvcmVzKSBzaG93IGEgZmFpcmx5
DQo+PiBsaW5lYXIgZ2FpbiBvZiA1MCUgd2l0aCB0aGUgMnggdGhyZWFkIGNvdW50IGluY3JlYXNl
Lg0KPj4gDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+IElkbGUgR3Vlc3Qgdy8gMk0gSHVnZVBhZ2VzICAgfCBTdGFydC11cCB0aW1lDQo+PiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IDI0MCB2Q1BVLCA3
LjVUQiAoMTYgdGhyZWFkcykgfCAybTQxLjk1NXMNCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gMjQwIHZDUFUsIDcuNVRCICgzMiB0aHJlYWRzKSB8
IDFtMTkuNDA0cw0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IA0KPiBJZiB3ZSdyZSBjb25maWd1cmluZyBhIGd1ZXN0IHdpdGggMjQwIHZDUFVzLCB0
aGVuIHRoaXMgaW1wbGllcyB0aGUgYWRtaW4NCj4gaXMgZXhwZWN0aW5nIHRoYXQgdGhlIGd1ZXN0
IHdpbGwgY29uc3VtZSB1cHRvIDI0MCBob3N0IENQVXMgd29ydGggb2YNCj4gY29tcHV0ZSB0aW1l
Lg0KPiANCj4gV2hhdCBpcyB0aGUgcHVycG9zZSBvZiBsaW1pdGluZyB0aGUgbnVtYmVyIG9mIHBy
ZWFsbG9jIHRocmVhZHMgdG8gYQ0KPiB2YWx1ZSB0aGF0IGlzIGFuIG9yZGVyIG9mIG1hZ25pdHVk
ZSBsZXNzIHRoYW4gdGhlIG51bWJlciBvZiB2Q1BVcyB0aGUNCj4gZ3Vlc3QgaGFzIGJlZW4gZ2l2
ZW4gPw0KDQpEYW5pZWwgLSB0aGFua3MgZm9yIHRoZSBxdWljayByZXZpZXcgYW5kIHRob3VnaHRz
IGhlcmUuDQoNCkkgbG9va2VkIGJhY2sgdGhyb3VnaCB0aGUgb3JpZ2luYWwgY29tbWl0cyB0aGF0
IGxlZCB1cCB0byB0aGUgY3VycmVudCAxNg0KdGhyZWFkIG1heCwgYW5kIGl0IHdhc27igJl0IGlt
bWVkaWF0ZWx5IGNsZWFyIHRvIG1lIHdoeSB3ZSBjbGFtcGVkIGl0IGF0DQoxNi4gUGVyaGFwcyB0
aGVyZSB3YXMgc29tZSBvdGhlciBjb250ZW50aW9uIGF0IHRoZSB0aW1lLg0KDQo+IEhhdmUgeW91
IG1lYXN1cmVkIHdoYXQgc3RhcnR1cCB0aW1lIHdvdWxkIGxvb2sgbGlrZSB3aXRoIDI0MCBwcmVh
bGxvYw0KPiB0aHJlYWRzID8gRG8gd2UgaGl0IHNvbWUgc2NhbGluZyBsaW1pdCBiZWZvcmUgdGhh
dCBwb2ludCBtYWtpbmcgbW9yZQ0KPiBwcmVhbGxvYyB0aHJlYWRzIGNvdW50ZXItcHJvZHVjdGl2
ZSA/DQoNCkkgaGF2ZSwgYW5kIGl0IGlzbuKAmXQgd2lsZGx5IGJldHRlciwgaXQgY29tZXMgZG93
biB0byBhYm91dCA1MC1pc2ggc2Vjb25kcywNCmFzIHlvdSBzdGFydCBydW5uaW5nIGludG8gcHJh
Y3RpY2FsIGxpbWl0YXRpb25zIG9uIHRoZSBzcGVlZCBvZiBtZW1vcnksIGFzDQp3ZWxsIGFzIGNv
bnRleHQgc3dpdGNoaW5nIGlmIHlvdeKAmXJlIGRvaW5nIG90aGVyIHRoaW5ncyBvbiB0aGUgaG9z
dCBhdCB0aGUNCnNhbWUgdGltZS4NCg0KSW4gcGxheWluZyBhcm91bmQgd2l0aCBzb21lIG90aGVy
IHZhbHVlcywgaGVyZeKAmXMgaG93IHRoZXkgc2hha2Ugb3V0Og0KMzIgdGhyZWFkczogMW0xOXMN
CjQ4IHRocmVhZHM6IDFtNHMNCjY0IHRocmVhZHM6IDU5cw0K4oCmDQoyNDAgdGhyZWFkczogNTBz
DQoNClRoaXMgYWxzbyBsb29rcyBtdWNoIGxlc3MgZXhjaXRpbmcgd2hlbiB0aGUgYW1vdW50IG9m
IG1lbW9yeSBpcw0Kc21hbGxlci4gRm9yIHNtYWxsZXIgbWVtb3J5IHNpemVzIChJ4oCZbSB0ZXN0
aW5nIHdpdGggNy41VEIpLCBhbnl0aGluZw0Kc21hbGxlciB0aGFuIHRoYXQgZ2V0cyBsZXNzIGFu
ZCBsZXNzIGZ1biBmcm9tIGEgc3BlZWR1cCBwZXJzcGVjdGl2ZS4NCg0KUHV0dGluZyB0aGF0IGFs
bCB0b2dldGhlciwgMzIgc2VlbWVkIGxpa2UgYSBzYW5lIG51bWJlciB3aXRoIGEgc29saWQNCnNw
ZWVkdXAgb24gZmFpcmx5IG1vZGVybiBoYXJkd2FyZS4NCg0KRm9yIHBvc3Rlcml0eSwgSSBhbSB0
ZXN0aW5nIHdpdGgga2VybmVsIDYuMTIgTFRTLCBidXQgY291bGQgYWxzbyB0cnkNCm5ld2VyIGtl
cm5lbHMgaWYgeW91IHdlcmUgY3VyaW91cy4NCg0KTW9zdCBvZiB0aGUgdGltZSBpcyBzcGVudCBp
biBjbGVhcl9wYWdlc19lcm1zIGFuZCBvdXRzaWRlIG9mIGFuDQpleHBlcmltZW50YWwgc2VyaWVz
IG9uIExLTUwgWzFdLCB0aGVyZSByZWFsbHkgaXNu4oCZdCBhbnkgaW1wcm92ZW1lbnRzDQpvbiB0
aGlzIHN0YXRlIG9mIHRoZSBhcnQuDQoNCkZvciBwb3N0ZXJpdHksIGFsc28gYWRkaW5nIEFua3Vy
IGludG8gdGhlIG1peCBhcyB0aGUgYXV0aG9yIG9mIHRoYXQNCnNlcmllcywgYXMgdGhpcyBpcyBz
b21ldGhpbmcgdGhleeKAmXZlIGJlZW4gbG9va2luZyBhdCBmb3IgYSB3aGlsZSBJDQpiZWxpZXZl
Lg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1tL2Nv
dmVyLzIwMjUxMDI3MjAyMTA5LjY3ODAyMi0xLWFua3VyLmEuYXJvcmFAb3JhY2xlLmNvbS8NCg0K
PiBJIGd1ZXNzIHRoZXJlIGNvdWxkIGJlIGRpZmZlcmVudCBpbXBhY3QgZm9yIGhvdGFkZCB2cyBj
b2xkIGFkZC4gV2l0aA0KPiBjb2xkIHN0YXJ0dXAgdGhlIHZDUFUgdGhyZWFkcyBhcmUgbm90IHll
dCBjb25zdW1pbmcgQ1BVIHRpbWUsIHNvIHdlDQo+IGNhbiByZWFzb25hYmx5IGNvbnN1bWUgdGhh
dCByZXNvdXJjZSBmb3IgcHJlYWxsb2MsIHdoZXJlIGFzIGZvcg0KPiBob3QtYWRkIGFueSBwcmVh
bGxvYyBpcyBvbiB0b3Agb2Ygd2hhdCB2Q1BVcyBhcmUgYWxyZWFkeSBjb25zdW1pbmcuDQoNCg0K

