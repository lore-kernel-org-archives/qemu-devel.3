Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEB0CA0FE8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQen-0001Xc-DF; Fri, 22 Aug 2025 08:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQef-0001WX-H7
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQeb-0000eE-H3
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57MAgEHM2873070; Fri, 22 Aug 2025 05:13:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aRgwk4voIlw12rP9kq7VeM9BY3duphheUTbg/o6ED
 EU=; b=Hv+L7vsucv2teay6xj/4Tf9ZoSTPwppQ56JMgX5Gp3IMp49jpwTJelLc0
 JtNZM1Ddz2KCD+XgVwQ+Nf2/rsftPEjexBFsCRzSLflxZ/PEGfVBDcKfJTL3drRk
 IoQWV4g2GsLChUGAERMdOEhOlGRSKslQa0nCLE07YiXWoCLGOUSjEPo6uXxuVdZF
 rfcUEjAIalPvYrcu8WjsVzGkGTpZTelaoiEh5hCpO4mvPiai0H0Lv/Tv9NxihO3R
 GYmIT8/08Qvn0CRXqjUX3v8/2ktFzDhE/xsES20SBbWTO4vet571ZtLVZJdjkv8x
 KnowqOXrUphayDjX+oRagF10LCZ7A==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2112.outbound.protection.outlook.com [40.107.100.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48pq1g857u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq5xbU7PioePBhTdjaPSf1EVXJYn04Bjg1C+G595QDVXvIU5Fx2/A1yge11N+kKgH1yIseetJlzPgUCXsJ17wWdT1ciWi657bz1mmkRaJ3VbuSwgskR7TRSKBxXlixlhy2SJ9cusEOOG++lYH4zWg8u1jO9gp9yntlnewpI9Ufaj8Nob8J0giHg0vJD9gr12lHAOhT61M3L2aJBD9yoO264JkZP6KNaNql9aFfXwBcBOLvOvoDhLY9Nbb81Mtn8pnu22SXpcnvEC1m1LrptebX05dgo3zt04J9cgV4/qT4xTyfG1Ev5TZOqwRNKsk90Pd/S09LOkK+nDIMUX6ClgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRgwk4voIlw12rP9kq7VeM9BY3duphheUTbg/o6EDEU=;
 b=VGW3u89qwe2Zv2Bt39y+KIq0Jrr5JE9cAS5SZkbT+oyKyBckPBR2sUJlFACHgh3uvID7Eq4bOtVN2My+0LC4vytd1INt7+zRbaESnez2j0hfndMKCP4iE4aPQt0XXlbAdM4/UREwNu90VisZwvpVR0aUdc8+FFRaEskVYWLhJMmGANNeKDASHuvcTPWA6FFpUi0LhFlBPXsq7LL8S73r5i0xDAOuEgVra5Y6+EpUxghssVuul0tawQwC/EJm0afnCRi8sW50f38nmmd8FLSjC1z4EoP61AegbKPHi2g4e0a4sL4qzFPO+KJjQ7s8oqh/j9QJDhueex+6BIdKZpq9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRgwk4voIlw12rP9kq7VeM9BY3duphheUTbg/o6EDEU=;
 b=aanNaE7GInI0Nj6jispY2+Sazmnmt3EoIb1FjeCr8VNTwnUe1cfMl+caEn0lw0e8XBGwBwZ0ouMPg6cORhcpPuyPX1/Rgj3XDA3I5VuWm7+YHZ+j4BIP50pgJ9znp/VPl8vEvOegUBjk7j8/+irniCvXVNH4FfnqrTc6O6PIrXZFQCXHKeNPqZ/qJvMyBWpD2kQaVAB3ju1drpMn7NtJS/CGrNoRzk3h9mIRuJyuaVnpsv6QT+OP0G3s3yOHSiSWVIRYN8bx3gEghkxIQZUiQ+WJISPy9iHY0zs9Ex1fFNbgdS6uOeiW8e1Bm8wqul6ZcDks3h2bAt+ijQAkCbU/6g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6505.namprd02.prod.outlook.com (2603:10b6:610:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Fri, 22 Aug
 2025 12:13:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:13:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 02/19] hw/i386/pc_piix.c: remove include for loader.h
Date: Fri, 22 Aug 2025 13:11:48 +0100
Message-ID: <20250822121342.894223-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::48) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: b53c8893-2401-4bb5-1711-08dde1755c62
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2gzN2UvWjFhYVFIT2N0WmFjeUttQUZJeGpPeitkckxST045MTA4SFUrR0lM?=
 =?utf-8?B?eUtpMzArSXE1TENoWU9LbnYwcFJobkh6SlNlNXB0QjBvUHl0UldOeHFiZ2N1?=
 =?utf-8?B?RWZnQVlZSzBjbjBwNVlXcEpiN2pBZGJVZmZjVE9vTTZUNlk2akVmYlRXVXNO?=
 =?utf-8?B?Ynk2Zm1TNWNPSUlzMStuSWlpSTloSzdDT2gvdnBjYmRReUs2Z2RicWJISGd4?=
 =?utf-8?B?NThWTC9KK0dKNWVyMnRjT0swV25YSnJ2ckI5STRaYzQ0RlREM2ZldWpyTXo4?=
 =?utf-8?B?eDVzWlNwVzhGMExVa1dxeUZtU0JNOW52aTU1bXgxV2FpMWJxZnB4Y2xReHgz?=
 =?utf-8?B?VFQ2R2lCSUJ6OVJxdURkR0dTQmErbFdqZnJTU1N2TVIvelhvQ0hiUzFkSEM0?=
 =?utf-8?B?Rmo1VTFINEIyY2xJZ1hvc285OGFUS1RCRDVrS25Lc1ROSExXdDBieGZiRUdT?=
 =?utf-8?B?Smt4V09uQXkxcExid2c0bFdEM0FmUEhzWjRvNEJ2eUFMVzNleGpxcWwwT2VM?=
 =?utf-8?B?eER6UllJQ2E4QUxnVUEwUVV5NXZWQ1hwR1E2cm1FY0RlNUJCNk41NGVrY0Y0?=
 =?utf-8?B?RW5QSmpxb0dJVjZibDhyeHZ0ak5sWGRJdFI1NHhKaldxZkxVc3JCcEpNZ1VE?=
 =?utf-8?B?V0p5ZDUvWHV6dndCcFdKZjVZRGdNbXJEdlpYYmd5OTBrRzUyWnU2K2g2ekty?=
 =?utf-8?B?amFpdGRqWkh1UldMZmRubG9xR2NHUUNSOGRZK1dYOTlMZHhTMWVpUEF1UEkr?=
 =?utf-8?B?MVpFbm9Maks4cWhyVzdNbmJmMXdjbTdWdEQxM0tabVE5WWt2VVBTZjBMa2Fk?=
 =?utf-8?B?SmZDeDl0emRuK0dDMy9Id2Noek5KVmJ0VmQ3bktEY0tGQzJnSlUzTzJzOEpL?=
 =?utf-8?B?MWhNU2hTbUtibUZRTEpRWTZlRG5OeEM3ZjhpRmFpWmJoK00zM2VxU29KWkxk?=
 =?utf-8?B?SHlFMWJaMDUwd3l0eTRyM1JYRUc0MXVQM3Q3NVc4MjBJb2E5QkxOb2NHWFUv?=
 =?utf-8?B?NW5SNFFJYlhVTHFySzVVV283cS9HQ1ZxbDFES2lKdjFHcFVmOUZzVVNjNWJO?=
 =?utf-8?B?Zk9MNDQwR280Y3RNUDJJcDkrcUJkcHM5eEE1bnUyaWJEaFh2V2hIa21vdFZo?=
 =?utf-8?B?czdVcW5DTkJwUXJsS0l0Z2c3bXhuNitONnFrdlJUb1M4MjBUR3h1TkJVa0ho?=
 =?utf-8?B?SzNHUHRRSjQzQ3hheWlCVzN6SmJVbHM3RE5FZ0MrVjhKSUo3dE5HeUt0bTJ6?=
 =?utf-8?B?SWM1SEdKeWlpYi9MWFRsTUtweXB6UXlUendBbUdSYXpQcEFuYWwvL2l0eFhT?=
 =?utf-8?B?cTg1UTRMQm94QkV6QnU5QkpJMVFZdEMxblJGZDkxSStUNGgvTTFVQnR3aDBH?=
 =?utf-8?B?WUJIQytOVHl3eWtPUmtVekQyVk5SQXRrazJkc0hBOVNMT1VUSm8rY1ZIbkRt?=
 =?utf-8?B?UTdNL004ZWxjbVBKeU5lcmRZbHZSeXIvQnJUejF6Sk10elZ3VlJPR0FUYitj?=
 =?utf-8?B?SWdjVitydmw0dThsN3NnaU9HWEtWRjh4R3NRRW5XT0FZb1o3QUlwTC9tMm02?=
 =?utf-8?B?bFBuekJlRFBWalBoUDgzRDlqYlNIQW42MStkTVhId09UTTVqb3hvQTJqYTU4?=
 =?utf-8?B?ZGRNWmVaWW1aU05CdmZGS3dWMkFRVnVyR0h1QTRMR3JESFJweUhuR0MzM0s5?=
 =?utf-8?B?RzI4dTExeWZkYmZzTDB4M2RDKy9vM1pVV0M4aHdvR24ySG1Sb2ViOVlnbldT?=
 =?utf-8?B?UXpMLzIxdm1HUjZwd0dQMGhtOWpLWVQ3c1VRbCt0aGkzQUVzbldPTm5iM3dB?=
 =?utf-8?B?cE9maXNtbGZYVFdEWDNyRkVXblhLZnlQSEVaQ3I4enFiTGYyWWRtbGQzUjQ2?=
 =?utf-8?B?OWtNcmRnUGllK29naDVVVGtyeDJtYVhDZlhsTlFZRWNXUUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9QZEs1TlY2aTl4cGtaZ25IbHVqamh5SUVMMFBaaVdMR0VxaWpnZmZoMzk2?=
 =?utf-8?B?TExBTk5Mem04L0crUkdlcUNMWHRCQUtiVXFMcjVCem1JMHhYeDd4K0FrVm41?=
 =?utf-8?B?cVZrdlVJbWJCZzZib0lOdGRZYkZBWGVmS1U2L1RUQ1V5RGRSTzNHUlpUWFln?=
 =?utf-8?B?YnNIWlR4MG1vQmZTYldqVWV3TWJwTlJlbmhCaW5hekFhQjNycXd4MWFJUEkz?=
 =?utf-8?B?MmRkWG1McEpVVjRxUHpWcUg0ekhrTHppcExFcUEzUE12VTBhZDJ0bVorc3NB?=
 =?utf-8?B?ZGo3UlRyaWlGTjN6SXJOQjFUYzJuSkpFeC9wOXcyRVU4TXlNdnNvL2lnMUtT?=
 =?utf-8?B?NEZDajEzWWhZSkEzVFl1bTk4S1NlbG8vdklDR3QzalJTci9iblVPdXJENDAv?=
 =?utf-8?B?Vy9lLy80RUtjL1I0ZXo5YTU5T21JRDRZYkpIZXRFSG9PdzhNQTROS25zaVJR?=
 =?utf-8?B?N3A0cTNWKzQ3NEljUHpNTkRUaTB6akhGcG44ME1KREsxNEU0cVo1YldTUTBn?=
 =?utf-8?B?WmcydXhaY3BQbytUbWtXT1hTNE5TV3lUanZSbDd2QkFyekN5K2wyRFdsenZF?=
 =?utf-8?B?eWNkdnZZSlI0ZnVHdXRTaDdlNzJmd2sxVktuM3NRa2t6dWdDN1pSNmlINU5U?=
 =?utf-8?B?aENRUGNrN2ZFSWNpaFFDWlJrR2lPUC92ZEhobUk3eFpaUHQzS3dnZnYxUFBZ?=
 =?utf-8?B?ekFlYk1pL09VOE1sVS9qRFBLakhMc3NwVmxKaXVxNUxFbVUvOVFrK3RkdFNL?=
 =?utf-8?B?eUgyaElnelVnUVNiTitFM1lWZ25QdWUxSFN4QUwyVlhaU3Y1N0s4cm5tQm5O?=
 =?utf-8?B?V3QxSVRqa3gzWDdDMThVZVZ5SWovL0M5U1Z1NCtkamt4S3BBajdvb2JtRWwy?=
 =?utf-8?B?Z2V3QzdHUGlnd213ZEcweGUwNGJGNVBReFdPa2VQN28rYXFSczRzb09UcHJR?=
 =?utf-8?B?ZDBEL3N0RWZOOVJsQ0VjdnNHUVRHSVZSenhTYkw0Z1JnUUJ5UUpIakUvOHl5?=
 =?utf-8?B?anI3ZGxqNXRIL1dldnlKQXo1M0diQVU2ZXNmNzVVODJEemR1aVdWSzRKMW9x?=
 =?utf-8?B?UjJ5clg5elBldDlVTUhnWHJFMmxFRVRneksrWDZ0ZlRUME5WTW9aS1p3NE5C?=
 =?utf-8?B?WlY2aTJ3N0g5QnIrR2VzWk12OWlBMVM2eGRjMWVFaGoxK3JjUDZPcmc1N2dz?=
 =?utf-8?B?aXMyaUUxdStpdS91TjFFTi9QVFdJaXZEMkRDZHczQ1QvTXdSQ21veXg5SlE1?=
 =?utf-8?B?Qy9BNVJyRjFCT0hDMm4wZXFLZlh5ZkVuOEg2bDhUTFhQS3JLT1hOSk1FWHBV?=
 =?utf-8?B?RFZOM1ZWVGFsMktNSkpaQnFvMHRhRG1qdUlFQTV3WkhkbmhTY2FkTTJDQk94?=
 =?utf-8?B?am1nWUduMTdNSFUrOEM4L3JmZm44VElTVlBadk52S0FISWRoeWVZUXczNkp4?=
 =?utf-8?B?YnBXTThvcHk3SFNQOEhuN2pybnlPTzdlNFhpNjRlSkFTMnlXMmtoUTV0MjVZ?=
 =?utf-8?B?YTBhY2pHK0FCeWlrKzRJL2NkdVJORWhndlRKZlo5Zjl2c01EMnVXblRJdEx6?=
 =?utf-8?B?cDFtLzBIQXArTXFLbUp1SG9UdjY3dFRBczhhTDdUdjhnMjZ0QmdabXh6S0U0?=
 =?utf-8?B?VnF0cVVCNkxLN0c3TWtreGRYRGMvcjJVZjNVZTEwMFlOc3IwbEZNYW9yVkNp?=
 =?utf-8?B?NmRXL2toM3I3RmZIa3hsNjBSWWt3UThNMnBIcUFFbXExOXNDVE9TL3lWOTJ2?=
 =?utf-8?B?T3NaakVMSk95Qk1mSURLTGUrZ2UxRlYwTm10b1ZkRFJIbEMzMFhKK213dk9w?=
 =?utf-8?B?UDdQV1p5bGVkd1B4Y3I5aXQ0VXY2eVJKYVEwMDFxK3F1bUVxdURwVWZQdEMx?=
 =?utf-8?B?QU5SMEZualRGYTFYbzY3bjM1KzIvcExZUnVOaTVRdXc3ZHVrT2U2WE0rV1ky?=
 =?utf-8?B?bTZQUVJRcmZlZ2JWbUd4dm5Xa1V1Lzd3Q1ZYeCszNDllL3BQWmRXRjY4UFN4?=
 =?utf-8?B?cW00b2xBRGVLRHVjQ2EyU1Y0TncrRlBGTmtyZjE0alR5emFXTUs5VzNQVW5l?=
 =?utf-8?B?ODI2U2k0aXYzNFNiQWQzMzc4cE5OcTQrWkc5VTk0Vm1SdVZFdmIxNDgxNFpJ?=
 =?utf-8?B?SGlEWVRXSE5ZSkhTV2REUmlqd25yd2x4bFJjZG9UckdMalhDUzAxOWpaMGN3?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53c8893-2401-4bb5-1711-08dde1755c62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:13:53.4661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5uylB291UczW+RryGQ3qEFT2L5qbMfawcrCeFzsTR6Br25WWoPs3gRvaoUh9jxKyl9nhvvhnU4rv84C+OpJ4gDFiPA68xhe7eSdbG0UCck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6505
X-Authority-Analysis: v=2.4 cv=drqCy1g4 c=1 sm=1 tr=0 ts=68a85f03 cx=c_pps
 a=vBA6s9seywRwt/5CQUiZAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=_jvWDQGc8cL8bECqUo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 5r-meLKoUTKTvUKpxc1d1ySyaXPaVqIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfXysmYLNOh9X2x
 Olh+krFJGBtsyqqxYWqT5NosNksXBX5PBcGND+SteKxm38vRCQplRdYfT9fmdfeOfdhgHOLPwgB
 hhHDYcGOPTVihsqJzubxxZJM+ze3WOxiF+j7VSG8MM0GbgUXqH6hqI77AL6jRPehIRdAJGDVaH4
 CnVoaCyNgG1vaIAhTzAfcKY3Pl6V3CP3a7Q04KDb68TMfq+cUtU0MydUN4j4YNigQvYH51gOLhd
 4uygO6T6Xnpx6+Wb+VTtolUViVvka2jwiiUH3Q5OYcuzyE51ncvHxbB8wKlY50r1U9H8PLIz0a9
 mswmwHLtbfqHIp8STl2fyQ/l+Frcmox4cT28/nHkspySjKIMyA+UFi2sSq5HBC556VtpLx3Ne58
 xFALVOytqsYpt/nB15RjoUY3JIvGmg==
X-Proofpoint-GUID: 5r-meLKoUTKTvUKpxc1d1ySyaXPaVqIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This header is not required since the loader functionality is handled separately
by pc_memory_init() in pc.c.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5720b6b556..bc8fbe46a1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -28,7 +28,6 @@
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/dma/i8257.h"
-#include "hw/loader.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
-- 
2.43.0


