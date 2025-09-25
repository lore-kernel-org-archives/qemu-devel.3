Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3E3CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFX-0000eC-Lu; Thu, 25 Sep 2025 07:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kE9-0006g1-Ah; Thu, 25 Sep 2025 07:33:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDy-0008Pv-Am; Thu, 25 Sep 2025 07:33:31 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P7dHgh3782113; Thu, 25 Sep 2025 04:33:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=erf6gvNJuQRJHeCkBRs0hkE8hMBRrqaukUwgF+aUj
 kM=; b=ebDmCu6womWxU/ETbgFbzylmFWWQxc1D1PdknwjDU5HHsSVNoK2lhxH2e
 uuJFz2LeD0W69shQbskqs4LnFMLIDD6F842wj/4bA/LrTZUttA2dKryiBj9AbnTO
 5+I4JjhaQNPNZqHucusim8aGQt1Ri0Js3r5jkG817O9shnOp4uC+TGPHXIA+9Hp1
 elOAObZJI+QcfUfV4N20qj/FV1oz8WR3QtKC4qv/WHEfCQfgwHQKyt3OTSE37J/H
 ooGkleLfWOD7yMnxP7m5PQsH6DqGwP02+t7Rh5sDy4XlT6TWelOABVwhuzsuQ8u/
 zj/MZj4ug881CxJ7JfmdzYqZS3sYA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022110.outbound.protection.outlook.com [52.101.53.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1hn0fn0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in+Q2+k1hYYoVIzIHt1sgIRl/rzSNVrjhfQUala2nW2sti5kouTw1vKnr6Ic1O2oqm1MswVXbHMfQ2a+35SVb3ffp/nprvW9HAdOiwM5SRvOX2p0Po9pCgV7BAOeFBH0SACZ5at/kw/LnP1WZCEaGMRPASBzOrVueRpkEarLM1+xbJLaLYXe72yD2mNuzoKYKNFH//tQr+VJqRQbSr+LTfk6UEkoolF4xUktf/yGX2cgYItohd7kOaKuEkW+BbT5IQMlztJ3DDtaONOGQ1G5QFssPH1tQeDMsdVgX5LoGextvcCZKLl0Lknz3UeoL74jJshrGVRfrd1viWixiFWCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erf6gvNJuQRJHeCkBRs0hkE8hMBRrqaukUwgF+aUjkM=;
 b=ZtmQZ1uvu5adnMXrvUlPVagax/uPzPsosn72fFKK40vpviAdA25MNqbkq/QkZ6srap3L9MF6ZYm8pcidlAtIybdwM7rWWekkigbrKWgLh3QUEPS7hDq9tKoGSFviLUi3oiPz89Obc0qwgRRzzBcHEljheLeaBKZO0cr8oDrXXcy7ZSCXLmjgrQuisnRvSsdd9MGo1Jdrtx1bjETsCTbxXTV7N4p/8mSPpmfBNyKa+LgWp/D+dZIT49OdKvhjd1F6S8fe0ngBqQFtZOTKkGoMRnKbiPziTxLEQEOA+z6zNWZxEJfikQGt7NsjRBjvZCg/9+gkGC5AnDYQAyQRcLqctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erf6gvNJuQRJHeCkBRs0hkE8hMBRrqaukUwgF+aUjkM=;
 b=KNIHvQEj6ZDxWbyBD81GTb5w2OZGmzHF4t8qB+CiNzHpSl+q7WLQurbSzUjn2I7CGCnxj/PeLehyAATp8zd2G+TTreUgI30pcoUnyK8zgAr+IstpFcTW8zckDRWn67wmUyZeljFDHKtB48OgMRYai7hPen9TylDwma6JDfnwrt2qbw2QaPnNuyfVEnP9kgbzhidNzCqSn20aYUVwm0R9U9hBU4GjaAX9q2PwNI9NB7Oa7SMYad1n3hHAn4Up1c2HvTwWefvwkIbQg3jvCksK14kFpYbRJLWcSCvs4Z8kT7EWUZIxKthBRt+bgXeQ4R8VNL3/7otmu3VdNHFeT3sQWg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:33:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 19/28] vfio/pci.c: rename vfio_pci_dev_properties[] to
 vfio_pci_properties[]
Date: Thu, 25 Sep 2025 12:31:27 +0100
Message-ID: <20250925113159.1760317-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb3be2e-7e76-4c53-b4a3-08ddfc274cd9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlN0bTlSWk5wMUJvUUVLemFFTXRodGlnMHJ2VkRzdFVkZ2RZdWlCdFRlVVpP?=
 =?utf-8?B?WWNHYmh5ZVpScTFybUg0TkNmejBkUjVIUUFTbFA3V1ovL2tqT1NSYWo5Z3RF?=
 =?utf-8?B?MkNpNjdNVS8yOUF0OWV5VHFtd0lJSVVRV2w2MUNjcGRmK1FVcjV2QnpOWmF3?=
 =?utf-8?B?UTNMUy9pMENPWG9MNmxJOVpHaUd6R2ZHdlpPbTNqbUJPQStjc3FXOVczUTRa?=
 =?utf-8?B?TFdRbnIrM3ZvZHhxYk4rWFBHN3JrbmI5REZNcVRYQ0VNcURWbzRuclNqUm1J?=
 =?utf-8?B?aVpFU2ZWZU84b2lKZzgzbVRQelRGMkpORGNSL0grSTluSXY2M250d3d0aVZk?=
 =?utf-8?B?cFhBbzRENkVrN3FrNW5PZklMb1RVSUE0TCtqRFlrd29sQkwzVGxqUDhMZXpS?=
 =?utf-8?B?cU9DSHV3aHlYMnkvTUdXTzIrVk1PQkR5ZTc4S01xYzdRczJ2YkZNd1lsci9O?=
 =?utf-8?B?dGhyOUlaS1VOTG9wSUkrRC8zdnpjUk50MHprQVBNMXVKdllsdWRuOEcxYkpu?=
 =?utf-8?B?a2pJOENlb0dFNHdiczFlam5Ma1A3NU9PREJWbFEyYVlXNjBqcGJHdjZISjRL?=
 =?utf-8?B?dFAybXRBdGNUb1FGa2FsVHhvLzJLd1BDLzZlZG56d3pOaTRmTDNJOWZRbXlo?=
 =?utf-8?B?T2k4TE1aUzMxbGxnbEYzc00xOS9aQVd4a1M1SXEyemF0ZHRYaWU0eHlTYkND?=
 =?utf-8?B?TVpHbWZkNjBVVWtwNkdPaFVuK3RZc3JzOFRhYVYrbDBiTkZjZ3RKdFpuckxB?=
 =?utf-8?B?cjFlZUY2dElmYjFtNHFUQnlTMk5LNVlVSlhGa2kyd0tXcGJKQVFGR1pCckg3?=
 =?utf-8?B?eGZmdWFvYThtWXJhbVpGdmRJT2pwSjlMZHNlRFYrVWlyL00vaWVPcVFXME5r?=
 =?utf-8?B?UnR0bE9YVlhTTUNDM29pbmtTMmhkN3JUb0J5am1ZV1J3ZlU2SW1MTEdNbVU5?=
 =?utf-8?B?SEc5cU1vWWVxQ3pvcHc1NWdsUllKZmp0UGxzblRjU2tlWVBjU1RSNXRQMDN0?=
 =?utf-8?B?N1N4TE1mckxOMWkxdkdqN3VDRnMxb2pSa29HZHZIYis5WGZ5MlFQRmRBRndu?=
 =?utf-8?B?TnZjdjVmMjY5N3BEdDVhZXdMOFB0a1pCVUV6SjFmb2dTbGZPbkVZc0E4RFY5?=
 =?utf-8?B?ZmtrdmRhbXI3STJCS0gwOEtlbTVmN0hubFF1Q3hTOTRxK21yTUttVTd5dWVF?=
 =?utf-8?B?d0oxSDkwOE1FZjlUR0drZjBHRjFIWEthZ0hSVVJsaGcwYXhCallDY20vMUF6?=
 =?utf-8?B?a3dqVnQzM0RYOUhwTW80KzFEVTFJV1MyVXhwM2I5azF3NUJQVTJuM3ZScGx3?=
 =?utf-8?B?ZTFhSko4eWF2NnJjbjNVRFNaM29UdjRxU2NJQjI4ZEZ3T3B5MmhERDZUYnBJ?=
 =?utf-8?B?TW1pckkvVGRUWlVKRC9DcWVXUVF3RDV6dmNqOVhZSDU1RmFadGJCRi8vVTN4?=
 =?utf-8?B?T05sN0xUL3dFRkJ6NUloazEzd1R1cXdrQkpnRFhYSTdBZUMwMitXeDJIM3Zl?=
 =?utf-8?B?Mmh2OHZDcENWNThST29MSEFYY1hERFZ4eGZscGRKUDJGem9VOFIwV21KcXBs?=
 =?utf-8?B?VlYwV0F0NmYybVE3Wmd5ZTgzT1gyeXkvL0E5RzBjOSsvU0EzV04zbE5abzZT?=
 =?utf-8?B?b0NnY2ZyeXNBdFlmbW5XUjkzYytnaXZ0c1U1QWhlUjZlOWNaVEVtOHNhNkFS?=
 =?utf-8?B?bGVxYytTZUJqY3FPbXZ3ZWFDL3JGZHJTcHhuWVhtOVZzMytaSXVCT0d3Qk5n?=
 =?utf-8?B?YW5VcVFZd1lZYkJoMFpzbDVSVmszN3FTTWR3MnJLWWI5MEtlNmxJOUFyUnhM?=
 =?utf-8?B?bklsaGtCY0NXSWFiWCtHdnVKUG50Z2JBRjhjTDNRMTRMam5kSUl3VklPMnV3?=
 =?utf-8?B?ckVvZFNFaEUvVVRVNHowcVlSeENYSTZ0dHVZOFFxbndMOU84VWp2VVlLM21C?=
 =?utf-8?B?cGtLNmxCWGJ0d0VKTFYyL1F1OGovMlBEZTJPOXBLN2VhenU5V01MM2FxUDNa?=
 =?utf-8?Q?Z7I0FoVFuAnRLTEoRyjuMPftrJbJWw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDVCMHFRZ1FYWmRtcHJYS1FSVXFnbzgwZVdSaFJGcDAwTnh4Qm1FS1JiY2Zu?=
 =?utf-8?B?U1FjOXZRT1Nod3FETmJrWkFZU3hkQ3ZsclhwdkZGTTRlM0V5eHl2OWxzM2dJ?=
 =?utf-8?B?a0Y5T29ZUERlRlFFeVhHKzgxdWxHaElXWmI1ekVTdHpwUVNWcnJTK0EvSUhH?=
 =?utf-8?B?K3ZUMXFVajFyMEsyVW1ML05jMVUyZXlSeW82THYrT2x2RG5LcmE4UkhpTEcx?=
 =?utf-8?B?Ylcvb0plUmEyUXVUUE5jNkNpWDJTdHZpa3E2c3kzR0JKWGFwR1RJVVdyTDlj?=
 =?utf-8?B?UHVWNTlTZ1R1THArd3hpNkxUSkpPUFJ6alloWTBLRGlmdkpVZGMyM2FJa2t3?=
 =?utf-8?B?RytHUHJrZG1lZGxUN3RkbzNnVkZ2Q2RXcEY5QTF4MGY5clRDVXB3bUJ1aG5L?=
 =?utf-8?B?S0lpUTRJUW1GMURUMGd1NFgyU29rUU9IV3NidGkzY0JyblZyeDRibWM0RUxl?=
 =?utf-8?B?MVFIM21WMnlMRXp5ZFNVdUZueXE5anE1ckZGUi9XQUdELzRad05Qc3JNRjcr?=
 =?utf-8?B?TWpFSVFaVXZjWE1veVlUN09TK1dNT0FiaGZWOWxQK3M0TUNOM2lDZjRhbi83?=
 =?utf-8?B?VEI1L25td1pndE1PdlNpWll0bys0OVlYYXVIcno2a3IvNEhsTUljZ1VJT1FM?=
 =?utf-8?B?azZIRjVsazR6U3RvS1hsQjRGK1RBQ1AvOFJqaStwc0w5Ui83TUJNSktQWTJk?=
 =?utf-8?B?Y0x4em54blFQa0hPTjJRQlZPMFNtTjBsd3hreGdLZ3RGelpoaVJZODA5OExy?=
 =?utf-8?B?S3JVOW9NWFQzNnNNZlBINVpWQkExWDJhc2h1eHBmQXU0ajNhYmRDZGUvRkRG?=
 =?utf-8?B?dFRUZUZmYVV3NXBWN3BNa1RPRUZzU3piWndaWmh3eWg5RmRYQi9lZWxBdTUz?=
 =?utf-8?B?ZXdGMTc1RlRCcy9mSEgyd3pGdmUzdUZZcFlNdUptQk5UZ2h1RVpua1pPY3BK?=
 =?utf-8?B?dHphczNXQ3ptLy8vcGhvY25LTW1rdXhDM3dnUW1wUDYvZk93dU9icVlVWkZv?=
 =?utf-8?B?UVFQYVRhWWpSUlRMTWxmZlN6SmNScnZsRGVEbW5lWjB0NTNxeHFZNlNBeXo5?=
 =?utf-8?B?d3ZvUFkvdlBMeVJCMTE3VW1xK1pDWkx5Y3M3azM2TmFHdWNqUk5oaFZHczBH?=
 =?utf-8?B?WVZ4Ums2eXRjYldZYlkwUnFHOHJBckxWbzlBdkM2K3VLZWJTL2lKWFZ5bnZM?=
 =?utf-8?B?UVpIeitWZ3kvSUkzekZBWkhrNldBSHRRS05BNGI2WVZ3TUJiQXRrQStvaFJl?=
 =?utf-8?B?TDJKOWZtM08wTklDZzU1Q1RYd1hoTUVHV1NGZk15bmlVR1JBcFFSbVN6TFRy?=
 =?utf-8?B?dXJpa1YybXQzT0h3bnVVc3dQQThYSEIrekcwYWxrSkRBZE9YZ0pTNVVFdFVT?=
 =?utf-8?B?N1FVOXVZN0RITGk4RVJpNTFpNk1zWi9jUkR1eXJIRUhyQjFKbEdjdVVPOHNz?=
 =?utf-8?B?ZEc0YWNLbnZncmNpR2VCSEg0ejNpMlJhTFhoMDVTRDJzRFpYTFBFdWVCRzJa?=
 =?utf-8?B?WEp0VEZZL1pDSFM5QmVGczZVZSt3RnREcnpERGlnNzY4a2V0UmljVUlXaDZ4?=
 =?utf-8?B?MjZaTU00NUZPYmtLMUEyVHRIQU9LT0xnOFBtNHJ3dzJ3dFlrVldvQjJvbHBo?=
 =?utf-8?B?dG9rYlQ1ZHdUNWZreXlxTURDVWh2a2kzNGF4c1JHWGQvZkhwc1Z1STFqNkds?=
 =?utf-8?B?WGNkUll3QXFxS09DK3dwd3poOWJmZTErUDBKSG9tYU1McWNaZEtDc0N1ck9P?=
 =?utf-8?B?UVRrVzRtMmJMaEI0VHA4MDc5cTJiWmtWTkRHT0djcS9qcWJmWStwWGhCdFJS?=
 =?utf-8?B?bzFCVTFzMWl1aDR2Snk0UnhUZERKV1pocWhWUk5zQ1p3OXpGdFNaZXQ0cTNN?=
 =?utf-8?B?QVo2TXNtZ1dKN2Jvei91YU40a0JhR0lCeWV2a0owSXIwVENTbGcvNkpXOTBk?=
 =?utf-8?B?amtwYVREeG50RU5MeHNDYlZGSDFKcnVweC84VFp6VnhwMEVOTmVDN0F6Z1lw?=
 =?utf-8?B?b2dWaGFEK1JxT3cyWnJaZFRqTHZUQU00d2NNTkZRcDlsUUxIY1VLR20ySlhX?=
 =?utf-8?B?RzkwOU9PVUJsZ1lmUXBUblliTUQ2Rkl4OERNYzZzNkxpUllQSmFtbEdiMDQ1?=
 =?utf-8?B?R1lYdm9hNXlUVDFQNWVTTms0MUZqSFY2S3lta0lBQlNYVVA1K1J2dnhSY0pw?=
 =?utf-8?B?Ulhjd2sxOUpqbzExczI3aHhqYmF3MmV0Zm0yeURLT3hXbVpHemVoaXJsMEJL?=
 =?utf-8?B?ZkJ0dWNDaDdlTDhYSUNqYWI3dXNnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb3be2e-7e76-4c53-b4a3-08ddfc274cd9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:08.0605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16g3FBVAL8xUxxWhMHGtILopwQ8pNITFZgxXnmqaYxezX5lFRkHvdc9olSveJnQ9BxueeohqzDvV+tSY01/1XrdC9DdtBjSu2qlclzyIcm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-GUID: W-qsOWf_AVpnCQSH_eGi-TXZ6lAj9Cyu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfXyVj2LsLzER5o
 qDMyV5mb+N0CMo7Ccs5Eq+mQVBlUoZ04dmrhDSOs8fv3J4Wy3nKwRzKwwqoembtDXR6cA5Mtyd/
 MaiH2OOAPW+R6Ol849yIHBKUzHKEX+DbKl03iTMaHguwPUHB/a6j/QKmpHQyLsCiQNz74S6R0y1
 Ob74BLjeAKxV2kftU5CuAkNN5RAa0rYj9kJCvdbbH50IqWksj2/VaRpsLjNhP3CYYnCeosHHq9X
 41dVscsghwonxrNi+3FpB0D3djtrMVYhMbRu85yDLArdEUQy1mamja3DwxgcIHbZUDvW4Ha9cX+
 MiPwVhqEKpqMJDMkeL0AAs2hVP0SXlO+Koy446lA7ug61q3IbueSFALmhRr1b0=
X-Proofpoint-ORIG-GUID: W-qsOWf_AVpnCQSH_eGi-TXZ6lAj9Cyu
X-Authority-Analysis: v=2.4 cv=D6FHKuRj c=1 sm=1 tr=0 ts=68d52876 cx=c_pps
 a=E5lcl6OKqxSDDTEGn4Qc9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-an67RP_g-7o1LT8KO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6c4c47825b..9c3bb3725c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3683,7 +3683,7 @@ static const TypeInfo vfio_pci_device_info = {
 
 static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
 
-static const Property vfio_pci_dev_properties[] = {
+static const Property vfio_pci_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
@@ -3769,7 +3769,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, vfio_pci_reset);
-    device_class_set_props(dc, vfio_pci_dev_properties);
+    device_class_set_props(dc, vfio_pci_properties);
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
-- 
2.43.0


