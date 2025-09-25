Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26EDCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kE8-0006fN-8Y; Thu, 25 Sep 2025 07:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDG-0006RL-2q; Thu, 25 Sep 2025 07:32:38 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kD9-0008IT-Ip; Thu, 25 Sep 2025 07:32:37 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P5b8392261155; Thu, 25 Sep 2025 04:32:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=njUT7fIC1YtS6GRdedXbCvn/7/ilnUM0kRaL9zagk
 tI=; b=uhTR6tXZX5biqCHTHFM4kBRGRBmxM/4wUYV61p4Ek859ZVbO/3qaFTZAs
 ec5HsvsuVY9aXu+35VYFlI5dDZhlF5wN7BlML1Xh3adXd658tR+uNHsdFBW5c1ek
 76KniPX9sGH7AHNCjvJHRlknVLzOiCEVEWt8mHpbioabWRNg2MSvyLwQL1Ci0d2s
 h0nsSklSar/Ut6+hq2XHKSercCENITiNWYxMDat3jjqPBitw29MHnkGaWBqY48qt
 NlQCJEYR9+fl/LPl8uEBPx0PcjH7Q7AjLCAX0LV3KzJZW1xPEfWHJUI3hHzqZUN/
 NVsi84V28C8ajc79IQypjLH7bX0lg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021115.outbound.protection.outlook.com [52.101.62.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cm7ra7v5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+i0b0bHVdYcwSjztmWtdhYO2L/2i1gx4vSoVtHD4DCZ1tTC+2cFJp8MbaVbQjePHz4o+d+5uCiI+UmSQcOtavftRrs46gGfgebFhlUDGfqmtv0IslpIKvfQPBj5vC/hFitlU8eB1/Ntw7JQ5C31pia1qNYBUKYIP7SUQCRPkpKpXeeSdkDLV7oLYxHloxnODBZefr0VGurwTb6c7Wb+FQYED+mD659o8lex7aE+2ZDqSIqqz1nRSc9PBQSL1WJ2/NWl3R4eqTSBAekuFi68jN8506oRs++NusYDChRjxn8lcmvqg2fb6eLk65WBqXgdwOgmt/LsdKr6d8pxM3uOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njUT7fIC1YtS6GRdedXbCvn/7/ilnUM0kRaL9zagktI=;
 b=KcxgqphKGLz2FOhdtbPs/W1f05xN9PnaPsj/E5KFt2aSPj9nCkXvRBLsWlZFrpXh1b+IR51gOoQWlhp6kI1a9ohtAoJ2bMytiF0X1x/Sw9fs/eJSMEnnB86QMRSuxeEFdLsUcON5SlZG3SgnWF4LwYlIY3Yqmlwmlfph0ZY3Q2yOZm0zISCBA0SohdLWimDFn7+Im22rkLYXFxr1tL5BpLU5klL1DAGM2Ub18ryIm5c82ZIuXKv5bJo4ItgkKATgzB3qvlRF2zNJCwlVMVg4epPIl6D5oTfyvzVnqJI+lE2vIzFMKg6mArS+OYorGMU8wBxAsWRJCBygnXDNhMu3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njUT7fIC1YtS6GRdedXbCvn/7/ilnUM0kRaL9zagktI=;
 b=dwd2cIS+TICrbSmfMi6cHz2fOlcqxm2ZsZkpKA7qDrayvoqH8t9Fa4pKZCbkTmtnHXR+UnYFYz/4BJXdXHE8QaJA0xGf6FIIsyZ/qcQmmjSB1wvuQaGX6BAAL+QODbP2h7xFz0/McYAr+o/Otqh8ceUH8okTOZI3C/PwP3SiuvMVr7/u8B7p7J6fwmVBGB/rY7e7nVAtuGMzFjLmno3lZGGVc74ocYXTZ4WEBlpUJ8B6nvUdFFOaHjpxMH/r2YYnjT/k4Y0zHpsOnlnFjqV2qyFNTslG3qP4aWi53BQhSKAj6mIRKaX5G3PCz3j64wE3qDwSEm1XgzJ63yaFTbDbWA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 03/28] include/hw/vfio/vfio-container.h: rename file to
 vfio-container-legacy.h
Date: Thu, 25 Sep 2025 12:31:11 +0100
Message-ID: <20250925113159.1760317-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b74581f-2a08-4517-e65a-08ddfc272c0f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHo5QlpaVGwxR2VPT2FGQi9ReERDNFl4S0FsZUZPVE9aVVRUS0ttTE1XSVlu?=
 =?utf-8?B?T3puSUJKR0xWS29MVkROZnBKdEJmaGcwOUo0TWhZbjJRbmY1enNwZGR3N0pC?=
 =?utf-8?B?cHI2a3d5WGNFcWo3Rlcra1g4SGx1TlRoSVFCem53YktxYlNwcVh1SmE0SU12?=
 =?utf-8?B?Uk44Wm9USVg2UjNsYzlqY1BreFFTRzFSK0ZMWjJpRkR1RklXejZwMlo4MkUx?=
 =?utf-8?B?VTFuTkI4eVJtVWRIeVAwM2wvSjN3ekRxaTlWR0dCRUhkRy82VjhHTUVia1lx?=
 =?utf-8?B?N2xlbWhva3JOVDhnVUJkenJQY0JEcU5FdERJQ2hNdndEZVd5R29FNENnZUZG?=
 =?utf-8?B?V0ZRYVlUNkp2L0UxZUs5V29ydkVZbFBiT2ZIVWJmeHdSb081TFpSYWlzMTFY?=
 =?utf-8?B?ZUdRVFBsWklMaXltNGZteGhuODRlR0RtR0Jid1JITml4TjBDYVJPMmV5c2ov?=
 =?utf-8?B?Z0c3MWV1U2ZIeGczVHVUMEovRlF6TnRiSWNVNkJQSUZsdEpRQ3hTaktwM1da?=
 =?utf-8?B?TDVXT1E3UUVudGNhZXBjOGZCQlpiSDVCcHAvQWFFNHpiQ2dnaVZBRzlla3hG?=
 =?utf-8?B?anpzamNLK1FaeExzclRKZXl5SHp4TXluYVdDZEhSUWJUZDdWMUtyVW16eDNz?=
 =?utf-8?B?MzBVK1BpZElqN3hQQW5LbUlhNHpKUlJ6eDVLNkZXUUcyVXNYc2NmUFNsR29r?=
 =?utf-8?B?QU1PY3Q3YWIwY1FyRmM0R2EvRTZWT014UnIweE56bEVWakdLSDBzaGNlczZF?=
 =?utf-8?B?ZlFPZWxvNkZGZ2xXL2k2Q2RGelJBV0Urd05uck42OVJPazlLRWNicC9oRkJJ?=
 =?utf-8?B?c2JxY3FvU244eUdQMWNFcDNvNThPMFV2UjhNRzk0TTR6YVRJaTZYdHJ4S1BX?=
 =?utf-8?B?cVlJTnZQaUlKdkVMd1BVR2krSnBqeXNUOWNRVkVpcnllYWY0ak1zTFBpQTFn?=
 =?utf-8?B?U0hPaTAwODM0eUFZbzNiRzMrVUNwS040dWVaL2ZXWmtDSFYvOVduZEJRcUQ2?=
 =?utf-8?B?bm03Y0Z0Y3c0NlJVbHZJS04rU2pjbkJtd1UrOG5ESnhnNXZNMmxXaHBSejN3?=
 =?utf-8?B?YWw4UjlnTkJsM3h1QloyT0pzQ0t5Mk1qTm42cldCR0xCUFdhNGlzU2VuUmxt?=
 =?utf-8?B?aFdTanNGVHg1WlNmOU1vdG1CL1lSNnhkMVhOVzQ2c0ZlMVdqS0M0ZlVFZlRE?=
 =?utf-8?B?ams4VmdBSVFVd3UwZWZmWXNKNGZlSUltNkFKbUhQUGU3SmQwS3dOK0ovUld3?=
 =?utf-8?B?RHNsc2VKQjkxVzJGMHJUYlRsN0RTNDZ6aHVKakkrZ1VTQWh0YjJtY3BqeFhM?=
 =?utf-8?B?ZjQ4Nm1tQUpGbTRoYjFEcmhESUNYM0lodnYxUmFyVWtYNjNSQ1plcjA5ejBK?=
 =?utf-8?B?NENDekVya0ZQd3ZueTkrRnQ0TkR1aUtWNU1oU08yL2J5amNqNG80QlhkQWF2?=
 =?utf-8?B?cTQ0dE1YbDU0eTVRaFkyeDEwZUphUENlQnVVOVlhS1gvUlNtUzE3L2NIME1o?=
 =?utf-8?B?bVJQTDVNZkVpQ0YvV1Y2cXR5a0R0T3c2RSs0OWhCbDhERVNkdVg3OHhGZzdS?=
 =?utf-8?B?VDdCYnc5UmJvVVdxRlp2TmtJdHIydXZHTTZrT1REV1pKbjU4VzUwamxXc2Ra?=
 =?utf-8?B?OXFDZUF1Q2Z4cnRRS1o5cFI4MVFsL0E2MkgyZTBOd01BVGw0ajc3RU9uUFZW?=
 =?utf-8?B?bUEzaCt1blNPMlFjMks1QStiSjM1dHNJUEVsVVVVUFZYazF0QWlaREt5RVhv?=
 =?utf-8?B?QVdrNzJsUGJ6RVgzOEJVVXNpbVlBaDU2UXdnVkpUd2ZsUEg1TldESFozYmYr?=
 =?utf-8?B?VVg2cTRzTVRXN0Jpc2s5K0N6V203YkY0MmVOL1JENkh5MlRISytEN3U5RFE2?=
 =?utf-8?B?eFpMOE1WZkczVUlRMktBT0k1VGtLcEhOcG9XWWhNNm5pVk0wd0RXaXUzTXVU?=
 =?utf-8?B?VUx0c2hCaVRVZjBPYUlrNDY2UzVDTEZJWThLYzg0RU45bEJzNW82clkzTnJN?=
 =?utf-8?B?c2ZxdTN4Z0x3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2U4VjI0ZmRYV1VQMFVSTXZveFZEbGpYRkFEekNNZzQ1akloeVA0NDhwd0F2?=
 =?utf-8?B?RndTbmlxMTBHZkZ5Um1WZVZpQjBPLzJka09KWXFwSVhkSzBjT2VROFAwN0pB?=
 =?utf-8?B?ZURtZGdmUEc1VDZSdGN1bDVsYWYxV1R3d2hMUXFTVEdtSzZvSUVFeUoxckFJ?=
 =?utf-8?B?VHRCUGpWb0pMd3hKSlZDeW9SYzB5UGpUeUF0My8rMTNEUGxGR28yTktPWTk0?=
 =?utf-8?B?eXhPMjlQRnpNdVE5UGEyMkkzdktqekdSQitYaWxCdEtNQ09DNWNyKzJJNFY5?=
 =?utf-8?B?UWVLVDFOZTVsOVAyK0VwK3lZcEFNU3ZXcFVyNDFtd2tlQW52V0NNQjRheTdY?=
 =?utf-8?B?ejE4QnFSQk1QRkVnc0VIN0xIc2svMUZxRnpCcTlTNXg4NmlLVytjWnl5dGE3?=
 =?utf-8?B?ZDlzT1N0UzFrKyt0M1RwNW90SjRlZkV2K1dkbjdPNmxDQ0YvZ1pmNTdyM1E1?=
 =?utf-8?B?ZXZjVWZKSEl6Q2U5cHU0dG1Rd2JoV3dLK3orLzB6ak40S0J2Umc4UmFIbklu?=
 =?utf-8?B?R3ZpMFBJaWZqTno3cTRqVkFZeU9PT2VHdGFVT0J6YWdUTG8vVEI3bFc5ek5D?=
 =?utf-8?B?U3UvMWFrS2s1d2NVc0I4empBQ0x5ZmFjWCtSUlZLb3VFWnZxbmJMVmdoR29K?=
 =?utf-8?B?T2x0VDlDN242TmpKSU50RCt0MjIrVUdudGxtL2RXOUhMTXVaWlVzWVFWZll5?=
 =?utf-8?B?cUtncGZFSGRDWHJraW5FQmFpTDR5RThVUXRwbHB2azZPZm5Uc0h1U1BVaE1n?=
 =?utf-8?B?Vnpta1dEbzFVSVZhQm5kVGtxVDBvNjUvYjJiNlFNVkpkTCsvREpDbDA5MktT?=
 =?utf-8?B?R21ZV3R1RVFZU0NKWXBnamxrRWtiSkZFR3BReDZhTDROdytNYVVIWkh6RHEy?=
 =?utf-8?B?QnR3K0IwVHdNc3NGK2tyemVVQXBDTlhUR1RPcEE0UG81MTJsL1FpUG1tR2s4?=
 =?utf-8?B?c28wODM1bDRUa2JIdVQ3K3pOZnc2ZHVNWGExakoveDY3Yml3V3pFM3VUZ0Zr?=
 =?utf-8?B?OUMwdUFpU3QxL1NHdDkvQm4rbHBrQ0h1L0FQMFpZYi9jUXp3N0RpU281bzBK?=
 =?utf-8?B?SFVwMGxUQzFDTFQ5VVF2ZXpybU9oOXdma2V5bEg1S2p3aVNZRXY4S3hRT0xz?=
 =?utf-8?B?RGxhYUhHRlRub2dFWjFOYXVNZGs3L1ZDMmNaRkV4cE5IVjNaTDFkczRlQVJn?=
 =?utf-8?B?L2NWZE1iYnppNHRKRVZDaEc3dDJ6M0tib3ZTNGZ2Y0hSQTJ2ZHdpUTU4U0Fz?=
 =?utf-8?B?c3NRZTlxSWg1VWpBaGZra3NhTnZ5UGRCNG1CbEFobzVkRFRnSkpjbUdhQUh2?=
 =?utf-8?B?WUVOcVFaclNIakNlNE1JVWxtNHJhaTZQUVdWMzFqLzMxR0lvVmdpZHFHdXFt?=
 =?utf-8?B?Y0pTTTVURFlHLy9Pc1FFT1BQRjcwZHFwa2pXVU9LM3d5czFSbitpM0JiL3hH?=
 =?utf-8?B?U1gvKzBaQkh1K2ZRYTBqYUM2SXhrc2hoYUFQbmxHQUUzaCs3YzFPTTJSd2Q1?=
 =?utf-8?B?MDV6STExOWkzeDNwbUJ3TkZsWFUxUXU2RENSYlhiK2s5VWNjNTBkRHgyais2?=
 =?utf-8?B?SHU3eTJuUDg0Tk94RVpCbGQxUDMvc2x2YkxqSXZPajFOTnNuVmFVczFHTGFS?=
 =?utf-8?B?S2w1NUNDOGhBRldHRnBqNTFiUWlRaWxxajFWOGYyczc0Z3FLUldFM0RudUFW?=
 =?utf-8?B?TUJkbXNFenFDUEVLd291TGloWm1Pa00za3B2d245Um14U2VqZ3hrd2hyanY5?=
 =?utf-8?B?VmgydE9CcWMxMzM0T2p4aGRLejM3cE9WMlJUTHN5Z00yc25lZlBEK3BlOElr?=
 =?utf-8?B?Z3FTcWhiZWtoNktsQzFhQ0pNeEhPcXVoMDJhMWZUaDlxdzZ2Q3hIUSthMUpi?=
 =?utf-8?B?WmlONXdSV1A0aUFBaGFEa21QYkE0a251aUxnbDRsOHd1NitvZkhCbTNLNHFY?=
 =?utf-8?B?enN3d0xUTXFzVituRHB4RmxKdWt2WUQ2VFcvQXNTMlJzMDBFSDlFWWF6QVNF?=
 =?utf-8?B?QWFhbDdJK2RCdDFMV2QvVGlxZCtCY0d6S3Z2b3daTnYzRzBWcTdDckk3bURE?=
 =?utf-8?B?cDJRNzJOVEJGSTNHUkZoVkhxQUIyYW54T2dORXFyUG9Jak50Ymc3ZmdwdWl6?=
 =?utf-8?B?a01rUVZXRFZuTTc4Vk9rVEVUUlMwWG5vOUYyUHBMazVIdlZwdWlyS2RIZE4x?=
 =?utf-8?B?L3lNcUtHUEppUzlQYVlWUUpBZnROY3FaL3FncG95bHdaZmRvenNFRmNmQXRo?=
 =?utf-8?B?dy9ES3M2bnh6QjMrY0R3ZkowTjVRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b74581f-2a08-4517-e65a-08ddfc272c0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:13.1913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxJAvQDL5nHb9yk0fMAlNeynKc4TifftI+5zTJeaptGr/DBudGMIYhGJd3srECYD+KQNEZ4Xi6w5W0pqsO7FQBWUaxBrSqchKyQxT4K2HcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Authority-Analysis: v=2.4 cv=NeXm13D4 c=1 sm=1 tr=0 ts=68d52840 cx=c_pps
 a=BwmNPiPC3/7FK0yvdQg0BQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=txMtgCL7_LO3UPI1MXEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jz1f58XGxvleZ87wKlFtVyEHjdiHx1Gn
X-Proofpoint-ORIG-GUID: jz1f58XGxvleZ87wKlFtVyEHjdiHx1Gn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX0Fub0Fpj+xcj
 +qeCrTScYflqBQE/+X8HqbrG1QsZNWFCc2U59fwWxTXUlFN7hGRZZfhKafOJfokMQu3ZDJjI4lX
 ThxewNlQMNwRTw8svSNxxGmp9PmU5sM7z9WCplntNM54zkwtVB5RFGkOLPlA7p7t1tk9EdTmKeD
 STHadZhlQUlmL6llKg2TUEhDXImcew7NJ+MLTBnbEruGZNDtMiPfGj29ujKYV/ISirIhbNV0xLT
 o2vQeaKSPYdtOE5ogeN+2VJZf+xZfnT1mFZA5VNu6WJnGbowcqGSHCGcW+XkZt4FfUJSdW9/Ygj
 TYwN1cPLlFI5f/VE8jACTnCbk1XpqLuNaSuMSodwoSxHFrpBNn6S05bNV8pW/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

With the rename of VFIOContainer to VFIOLegacyContainer, the vfio-container.h
header file containing the struct definition is misleading. Rename it from
vfio-container.h to vfio-container-legacy.h accordingly, fixing up the name
of the include guard at the same time.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 .../hw/vfio/{vfio-container.h => vfio-container-legacy.h}   | 6 +++---
 hw/ppc/spapr_pci_vfio.c                                     | 2 +-
 hw/s390x/s390-pci-vfio.c                                    | 2 +-
 hw/vfio/container.c                                         | 2 +-
 hw/vfio/cpr-legacy.c                                        | 2 +-
 hw/vfio/spapr.c                                             | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename include/hw/vfio/{vfio-container.h => vfio-container-legacy.h} (88%)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container-legacy.h
similarity index 88%
rename from include/hw/vfio/vfio-container.h
rename to include/hw/vfio/vfio-container-legacy.h
index a84dfb0dee..ab5130d26e 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef HW_VFIO_CONTAINER_H
-#define HW_VFIO_CONTAINER_H
+#ifndef HW_VFIO_CONTAINER_LEGACY_H
+#define HW_VFIO_CONTAINER_LEGACY_H
 
 #include "hw/vfio/vfio-container-base.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -36,4 +36,4 @@ struct VFIOLegacyContainer {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
 
-#endif /* HW_VFIO_CONTAINER_H */
+#endif /* HW_VFIO_CONTAINER_LEGACY_H */
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index c8175dd8a8..a748a0bf4c 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -24,7 +24,7 @@
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "qemu/error-report.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 938a551171..7760780aff 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -20,7 +20,7 @@
 #include "hw/s390x/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-helpers.h"
 
 /*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index dc8425efb1..c0f87f774a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,7 +34,7 @@
 #include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "pci.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "vfio-helpers.h"
 #include "vfio-listener.h"
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bd3f6fc3d3..bbf7a0d35f 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -7,7 +7,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "qemu/osdep.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
 #include "migration/blocker.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 6d462aa13c..acaa9c1419 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,7 +15,7 @@
 #include "system/hostmem.h"
 #include "system/address-spaces.h"
 
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/hw.h"
 #include "system/ram_addr.h"
 #include "qemu/error-report.h"
-- 
2.43.0


