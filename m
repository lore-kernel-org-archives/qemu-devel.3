Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19F8C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq37-0002BP-1K; Fri, 14 Aug 2026 07:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1wuq31-000299-Na
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:26:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1wuq2y-0005y8-WC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:26:03 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAbsSO4082956; Fri, 14 Aug 2026 04:25:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=0BVZ140R7VA0kXD
 wUbtW2Ts+o4efE7tV7qsT03Spo/c=; b=Wv+7snFzipGjdvUFvMiCsHEhEVG0lXo
 uAzy8ygoBqrpelKj1G6s61+UkHDULNSmRXkTy699Rugu/EEf3uvRxAqbmonmzhAE
 IkJyYOX/gxa3zW/MGnnfJRMrJlXSnrEJ/zApATGeERUNFk1pzJkW9txJS8wrQpkS
 hr0g2+OcAxG+CgJGNFIgrU46IWMPusUfCqJLBC5FwSP8JEfC1boYX8BIPO0cUgPK
 71TpshiRnzWFGI5bJL7e9o99rVHWxjVDkmv7fJu8CFDEN6X+I5HcAAyQHUNT8eL1
 fVwKCKyz3Nff+jbv/vanKEOjWMYSFl4ftnGjSuXzGkM90TH8vTmzSNQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020143.outbound.protection.outlook.com [52.101.56.143])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1nye1e3p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLuuRSneVqpg9m/cwqAKJfknCi254UndPtPm1h3rYPuCTAI1oMRPZXV+1LAZN8BIpGblDr2T0pc9apmye94VovR7oU5To6tQ0y75d91kSSh+9hgLda5Vc9oOVNGtXD1ERHi7QIOlmy+yKzTWEKaD/Ye92m1aY2sKvJ2FE1GavJbCv2HizmNjw1+qpQW2oS6T5N+6A7XZLac0+V2gShcGERWiJaNr3j0U6gXkfP9ni7Po3zHL7tmee+ESHj1gGaBh/Zte3TvmRSjDiwTnnpyETBATVdj3KruZ/GKm6HigGZQ4epBEUCWOExTOFxJ8WwHlFvz2pRedV3maDHhQ8sYzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BVZ140R7VA0kXDwUbtW2Ts+o4efE7tV7qsT03Spo/c=;
 b=SZ1FMP4SEH+zbuEMbwE6e+DkqUfSoi5WJfDfUkNFVO8vUQQJCx7wew8HFhaEWYoEikmu2KpI5MLwaYAjkcOIEGO56mIfIUPviAuyWpEdFR1rTMgt8gmp07c/fCoXehNtUxvSaTQXUBXh6CMaFPNpQ95BdufFtmgGjRhzugNmgM1wky+6dIS3IqGgRDRF+Ol0D1LNdpDFvDQAXhxuJOvdN+0irzSBVXYS6fK3lHoh6Sngwr6cLC9zqeUOORDTa/YmPpPCnNvESVZbS+a32GARREgm4c1AwSTS9Vvy5nTdhKyEyLbCsBAmE05zQHAGniaRW4tsDHQrbssUop2Pl1nTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BVZ140R7VA0kXDwUbtW2Ts+o4efE7tV7qsT03Spo/c=;
 b=bOuPVDYHqdGfqHcnTt30nqGEV1DdkODBjKPJ1pkYnj+aQ9AZoCJfNhWASJe9j/tJRJhtEclHniSmXF2nQhOr0Mh8hxP3bUM8aiAW2cnSe/JtYFQvRUiBjQGUZlK52b0fXbKRG1G8asc13wr4Ct9pxqyho6yvzXT/u6F/rGjKsUKCOksRHjsX7K7PUznkXMkKNQ2ZQNIoJZHGdW+rpXw3Q28Yne5KvfDX+Iutiss1AA3OSou9WSaYVTmZM21a7+/aymfzMgLHmmj/CmdnvzITNc3CakwckSaJbpgOMnqD2Zg6ficaKw/PW+yxHV3uRM/Gk4MtsOfqJDHijDyLPMjE6w==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by CO6PR02MB7762.namprd02.prod.outlook.com (2603:10b6:303:b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:25:54 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:25:54 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>, John Levon
 <john.levon@nutanix.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] vfio-user: reject failover during init
Thread-Topic: [PATCH] vfio-user: reject failover during init
Thread-Index: AQHdKwZq3QjQg49MDUmMavF3ugimobadFkGQgABSiRs=
Date: Fri, 14 Aug 2026 11:25:54 +0000
Message-ID: <DM6PR02MB6172F3449E452FEA752C930985DA2@DM6PR02MB6172.namprd02.prod.outlook.com>
References: <20260813092959.76-1-hugo.komatsu@nutanix.com>
 <IA0PR02MB9462D1D113274A2FC18BF6188BDA2@IA0PR02MB9462.namprd02.prod.outlook.com>
In-Reply-To: <IA0PR02MB9462D1D113274A2FC18BF6188BDA2@IA0PR02MB9462.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|CO6PR02MB7762:EE_
x-ms-office365-filtering-correlation-id: dd6bde69-f553-47ab-554d-08def9f6cdc1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|56012099006|10067099003|4143699003|22082099003|8096899003|18002099003;
x-microsoft-antispam-message-info: 8LLYEe4bDOI0ZWAOVTxjAucACXReeE1fDN6eoPHDmEMzgB+xl5DeF5GLwASbPB0CA50KgCpLJyW4/qmePdiUcoe87rEahwDJz1fuYDRA5z7Uay/H9dvYgJnv4pfwVULIlRR51D+zvhZ8eyPGtmBd9TrT8pbAxrtKocCNe4HM7IPGtY96o1Xwp4TC4oOjLHN2UJoXByexUpSFGurNCFBbnQzCXEUYh6T84rGKFzMabwQy5zmy0cbhmLz86iSCz/2IMDxcSQBcZFJQFdZfSo19AVxQn/whqz1SkAZgw96cISZekMWhjg3AqODrMfVNI9c5WRatJL3+KYhIB2lAIBO6PTcL8lfFBTqZGhxy7GN1/0acl7Rm+d3WKLFNBUcQNWgLmic6Z41UL6dqHKfAY7Et3VwlBnIs8b0m7xLwy7f0Lkw0MLj4YQNW4efALatr8DDo5L19uH3oxuZcRr2mAlU7Jyn7G1DB2fvKWhtZpo7x2C14U7gzp3m/aBNu9kHIuU3CSZuNObzvSyM0uklDZ6SazB1gNwYGBN1mw5gVFnpbu2VZ7/lrGnPziULCW4B5ORtd0ffTaeqeDmSWw4N6KmwHvfBueA+JguhriUg+SyF03bILhtLzDEF1TN2PuCZeUlzY573I8a75ixnHznUbDIXKoRgYByn/bY9eYD4D8a/MbIhmomKBDaH8yJ6V7S198e9Hg3WdJhiILK1cdvYIJlGLLA/7rthDBGBI06rUIkr9jmw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(8096899003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vw75i4M09lKgQOe9mIqR317nJVuPitIU+4ojmsa/mgGfzeg8VRX0O28/pI?=
 =?iso-8859-1?Q?ExQrv5284x19HbPj0vYEx50eWdYvlQIcByq8T/PnSbBZu/YkSNepq0CuQk?=
 =?iso-8859-1?Q?6M8JCDoNe9fcTQE/U52SIpqFRrr/Jpx3FMmxbWljA0xcn4JLsfKHa4CgcB?=
 =?iso-8859-1?Q?DG5yZZSqd5e6qN+6Am3/vNKvPIaAh7NkNplzY9YIXLG4IrH0eY9nBHnLYy?=
 =?iso-8859-1?Q?8CmQvubGnFLBVBOUWZ5sVkQpq+xfH+rBQgGTS8m/qLlmW41ju2CJi1c0FY?=
 =?iso-8859-1?Q?TbXFiFhlfWZPJaGxFqfr7Gy0b2vZptUqmIQRjGlL0wqpynCP5vjCDBCK+O?=
 =?iso-8859-1?Q?A2HsS9sqESuqPaiBlCgSEYq35pkp58w0iJsifGrC5t/ykOD+na96c6XCo7?=
 =?iso-8859-1?Q?FUmwSwxxi8SmEXIoJFTc5qHgcN0dBZ/3JYaDj8epS+4rCJlo7i5nsK7Q9N?=
 =?iso-8859-1?Q?fV7Z2kPs19Qm77/OkztwBgZ94DSQ1TrC5YOa0OTpY4PdZNjS1JqdOMmDdY?=
 =?iso-8859-1?Q?wH0vFuYaLzK0mvMDx8MuX3DnMr8RYKUWZ5nhYnWZ3ecjQWU6fZsekBCylK?=
 =?iso-8859-1?Q?cNldJXSppERdJVryFUIzyWNrBXl5n1ZpujeKaAaxKEmUzHsQxhCuCWBqEQ?=
 =?iso-8859-1?Q?1pFPG0Vcvb57Nm2Hm4JBr+4Z9BWLVARyx8odmese2F/YZhP+nyxoX+zAe1?=
 =?iso-8859-1?Q?TBUjOVh2+K3Wrm/wQ+iuDLjeQCfWRwF5UAiEibtY0Wgn9gN5Hm3a5rtZ+I?=
 =?iso-8859-1?Q?e9oBQQJhgOxZihNZyjcjoGATvs7GbgOQfFbYlsYv5e2FD1cPvioTVVG89U?=
 =?iso-8859-1?Q?e6Q1yIUTUoocOJ56upthO1SraMkvLFe/zec5di/SwMbkmr31+IQRPMTzla?=
 =?iso-8859-1?Q?5YfJnS3PoSKGWhVk37EnOR6N+uUVqQ4ovb5B4gRKI0DJaJjgoJGSbzuMHb?=
 =?iso-8859-1?Q?uVbJn1rhdR835mqOkL0vUyVKav2dOqh5qnD78Rj4R4M9JYLFWTwODvK/rA?=
 =?iso-8859-1?Q?hWUO4Tq4tdeATwaWBRJE3yk4gtCVTrrg5AW6K/3nabOjV1oO3RS0mH6hn0?=
 =?iso-8859-1?Q?SWdPwfmSb5C46TVV0wEvsL5qXhlQwIu8VoGGp3hDYv2VHCPoMw+SK51cCT?=
 =?iso-8859-1?Q?lSDx1d8bU7MknnHnb5UpoUSQJjYaBQU6Z5JvlL+cEZUSic3zbh5RtLAkc6?=
 =?iso-8859-1?Q?HZZKW5Es4sJa7GAcIv4zIMUIUE2+qQsI/z0x6vfMW/g6vJg5j3nSj88WC5?=
 =?iso-8859-1?Q?ENZJh9MRkqYR+8DLiAtC/9MmmK53BSXouskgjfbuATGSbq57qKnC/EYm0P?=
 =?iso-8859-1?Q?p+1YGxaLXXcLqr5xhDfAOJgoXo98yvTp0UcSnhQc6QDBkq/QRTfoOkBaYu?=
 =?iso-8859-1?Q?JFgY39QxUFpSDxFoZA7Twty+s/15TFJJm0yEhLRa6FjX2s4fmUUbaOXh1m?=
 =?iso-8859-1?Q?ETgrVUyqacwsfRtFMccJ+fzgylv0RJwWhVxEzLznuABY75ZmZQ6Tml0wik?=
 =?iso-8859-1?Q?+bSQkUNy/fa1w3E5mEzw7rxkqzOO0HcQPbIpj04pSO16+jdDCWenhMKCz6?=
 =?iso-8859-1?Q?Wfro2BdjH7JeDBmDInmgjx434hMwrMN9uFV0gD2Kuvd67chfDj0WaPcj/K?=
 =?iso-8859-1?Q?7Q6Vf8h8ADqYe978/3yheTDxMg+1tvbGWWMJ02T5utSEzOakwGpsBhLC0J?=
 =?iso-8859-1?Q?MCmAwuch5bO11kk+iQRwRzdpOLLK6guZEVPECbN6llewmowQZu/a8qpx70?=
 =?iso-8859-1?Q?KJoKf2LCW4uIRe+m5labStW52EIEU9h2lEqYejtdl1le00GK+bfVPg6CVd?=
 =?iso-8859-1?Q?p47+DSpwuw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR02MB6172F3449E452FEA752C930985DA2DM6PR02MB6172namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a/lZmzeTUeGOWoUZ/y5ShXXKx9iAKwwsc420Hw6vIbSC6HtDW6DDIpgDFKZzeEo6Skf8qgu4YCKzb66jTOuYZCSDX5+1N9jKS6gJXAT/ETvntvXCcCejwl/32JLrCfAEc/QLUuFSlmHeAC6zIpY6ARlzs03ZKfyvXxJWrOa9owUWQ2SR4N5WtvbrPOTmM1a/oLzh3D62f35cNzEU/1/8xfEHex4FwOH8gfssfBiIKsJLs5gwVVF6NcgC2M4E8ArjAqsCq5gjJi8Y3CZ5Hgfj8ObookytCJ55S5D5/bF4jAPCTVv0V9VDBHBO2en8wIzPcPbIXhdNtrMee+xEZWZN+g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6bde69-f553-47ab-554d-08def9f6cdc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 11:25:54.2155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq1Upk+Ot9tZfYdMIlBuXnhipL2Z21VRitVojBzNa6zc07JXQAIGEWyYM0xaY3vXtdxbfWJN/BcHZw5rUifkEK+h4uCDEZHzbbomWyWzIBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7762
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NiBTYWx0ZWRfX90UGQv1Exbze
 9fXp60w8yeoSJAtVgnSOUe9zLtac9oOJjBfGoYTRkh92wv92Ml+v6VneSiL4Phwky0nOOM4ZzCn
 24HgquawoJHzru7PYlo/XJ/PHWX0EASunT6llqDRoDlOfCUMyd5mITVwha9GJU9iwsjnBwSSwI1
 Tc/NJUufdE3PkVUdl8PtJqJQck0bVUYq2JOuI6njbgobfEfhuyjj6F4cPdOLC5PyPYeTtxiz1DS
 Lj/0MzEqUajnF65ZKEfU62bL8GQ/6uMB86D7351EbePMFd3Uv36DiAcHubFKPzlRWZef6s3DCvT
 DzfJddrHs7a/11nEoe4hFR48H31V3COZlUblItllVG3elYoDcu1IXZGcfVGnH7mH1w2aWqOWw3i
 9VntnqDSTPc+FbDhMFCROM+Ennp/YwyL+o2oqnfiEbFoO5QWQhTUljdgk3j7Or+b6oLHD8c7ZuN
 qlYIVVLRSuLHohJJAcw==
X-Authority-Analysis: v=2.4 cv=Rr/16imK c=1 sm=1 tr=0 ts=6a7efb44 cx=c_pps
 a=9wgRWqjVWX0WYWV/j6UgmQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22
 a=VUi8bpU7OL1Oj2-RSIOF:22 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8
 a=uqWhNtoaQTk3GqIFXJIA:9 a=wPNLvfGTeEIA:10 a=-nUuIw_CUlTfXVXV:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Vd41WsfcveQRMutKHzE4YsO9E-NPQRQM
X-Proofpoint-ORIG-GUID: Vd41WsfcveQRMutKHzE4YsO9E-NPQRQM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NiBTYWx0ZWRfX9pIWd6lQXjE/
 svsLzp3qLQgvexWFqflBZPDR2QANYpGyg7C43sma6cEZY+sZ9Xx9aL/bcEd0K4Q5t5ZeNkBWkyg
 esj5jL6Ur1bL8EQ3m+J9utjRlGfWknU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

--_000_DM6PR02MB6172F3449E452FEA752C930985DA2DM6PR02MB6172namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks Thanos and I actually fired off a v2 to the list yesterday that drop=
s the Change-Id per John's feedback.
________________________________
From: Thanos Makatos <thanos.makatos@nutanix.com>
Sent: Friday, August 14, 2026 7:29 AM
To: Hugo Komatsu <hugo.komatsu@nutanix.com>; John Levon <john.levon@nutanix=
.com>; C=E9dric Le Goater <clg@redhat.com>; qemu-devel@nongnu.org <qemu-dev=
el@nongnu.org>
Subject: RE: [PATCH] vfio-user: reject failover during init

> -----Original Message-----
> From: Hugo Komatsu <hugo.komatsu@nutanix.com>
> Sent: 13 August 2026 12:31
> To: John Levon <john.levon@nutanix.com>; Thanos Makatos
> <thanos.makatos@nutanix.com>; C=E9dric Le Goater <clg@redhat.com>;
> qemu-devel@nongnu.org
> Cc: Hugo Komatsu <hugo.komatsu@nutanix.com>
> Subject: [PATCH] vfio-user: reject failover during init
>
> Virtio-net failover is a networking feature that relies on a primary
> and standby device pair. This is not currently supported for vfio-user.
> Refuse initialization if this property is set.
>
> Change-Id: I80989ddb08a1cd3eba84bcf9b0edc26cb4a65669
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>
> ---
>  hw/vfio-user/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index ecc59a9642..34fa2f22b3 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -251,6 +251,11 @@ static void vfio_user_pci_realize(PCIDevice *pdev,
> Error **errp)
>          return;
>      }
>
> +    if (pdev->failover_pair_id) {
> +        error_setg(errp, "vfio-user: failover is not supported");
> +        return;
> +    }
> +
>      sock_name =3D udev->socket->u.q_unix.path;
>
>      vbasedev->name =3D g_strdup_printf("vfio-user:%s", sock_name);
> --
> 2.39.3

LGTM except the ChangeId John mentioned.

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>

--_000_DM6PR02MB6172F3449E452FEA752C930985DA2DM6PR02MB6172namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks Thanos and I actually fired off a v2 to the list yesterday that drop=
s the Change-Id per John's feedback.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thanos Makatos &lt;th=
anos.makatos@nutanix.com&gt;<br>
<b>Sent:</b> Friday, August 14, 2026 7:29 AM<br>
<b>To:</b> Hugo Komatsu &lt;hugo.komatsu@nutanix.com&gt;; John Levon &lt;jo=
hn.levon@nutanix.com&gt;; C=E9dric Le Goater &lt;clg@redhat.com&gt;; qemu-d=
evel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> RE: [PATCH] vfio-user: reject failover during init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: Hugo Komatsu &lt;hugo.komatsu@nutanix.com&gt;<br>
&gt; Sent: 13 August 2026 12:31<br>
&gt; To: John Levon &lt;john.levon@nutanix.com&gt;; Thanos Makatos<br>
&gt; &lt;thanos.makatos@nutanix.com&gt;; C=E9dric Le Goater &lt;clg@redhat.=
com&gt;;<br>
&gt; qemu-devel@nongnu.org<br>
&gt; Cc: Hugo Komatsu &lt;hugo.komatsu@nutanix.com&gt;<br>
&gt; Subject: [PATCH] vfio-user: reject failover during init<br>
&gt; <br>
&gt; Virtio-net failover is a networking feature that relies on a primary<b=
r>
&gt; and standby device pair. This is not currently supported for vfio-user=
.<br>
&gt; Refuse initialization if this property is set.<br>
&gt; <br>
&gt; Change-Id: I80989ddb08a1cd3eba84bcf9b0edc26cb4a65669<br>
&gt; Signed-off-by: Hugo Komatsu &lt;hugo.komatsu@nutanix.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; hw/vfio-user/pci.c | 5 +++++<br>
&gt;&nbsp; 1 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c<br>
&gt; index ecc59a9642..34fa2f22b3 100644<br>
&gt; --- a/hw/vfio-user/pci.c<br>
&gt; +++ b/hw/vfio-user/pci.c<br>
&gt; @@ -251,6 +251,11 @@ static void vfio_user_pci_realize(PCIDevice *pdev=
,<br>
&gt; Error **errp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp; if (pdev-&gt;failover_pair_id) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;vfi=
o-user: failover is not supported&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sock_name =3D udev-&gt;socket-&gt;u.q_un=
ix.path;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbasedev-&gt;name =3D g_strdup_printf(&q=
uot;vfio-user:%s&quot;, sock_name);<br>
&gt; --<br>
&gt; 2.39.3<br>
<br>
LGTM except the ChangeId John mentioned.<br>
<br>
Reviewed-by: Thanos Makatos &lt;thanos.makatos@nutanix.com&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR02MB6172F3449E452FEA752C930985DA2DM6PR02MB6172namp_--

