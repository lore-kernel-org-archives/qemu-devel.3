Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A64BC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 18:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIWuZ-00071O-Ri; Fri, 23 May 2025 14:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIWuX-00070o-DM; Fri, 23 May 2025 14:14:25 -0400
Received: from mail-westeuropeazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c201::7] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uIWuU-0001rW-RY; Fri, 23 May 2025 14:14:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJpbZRBew8ShJ7fBKMr3mvktNlLzmhnEF7SC7mlkPCgJkbPnT6gNK9tC69lEQLpFpba6sE+qF9dCsTvRCStDoYXzpIVVAMFsFxlOfJd4Vvs7F77HBE7KgZjZwRXvpwvT+MMh4FjBfZmD9++fZi4+lE3pHw3qPvrhs2PeiaqWyRu30750IiHGMP4pDnGCK0XnY+9jOz6tBRQ4azHu8b4p3ivGkeZc+jMVy2G/oK36UYRB32vVzW9wU9jNFMjhGDBl9BGJ8qPOriJYAMx5HV3JOIEUhQ3tkBzfpHtPeBG4gZ01gepOs4MYTcVQDr61TO7ETMjPXRxI7E3TtbFfsr8ojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8BiRwwW71JX92KArF8HpMSh0vICe7DrtfaxTVwV2uQ=;
 b=JwZhUkZggKHCEM/q6TBJzBeE8o5WP1E+Dgs79P22tP/I7COdZrF7THbUxNWtSW+oa5bIplrgVNv2YGBZJUatScm820cCWABF66XK3wU/XK4L6HZPjVTImEaRz3aX7ms7J3a6UEIPAdiYm2TeOxEcxIlUq1/oLhk5J4g6uQgknK5uJoe+v9F4aQvVyFlGAE33zmSm5shUz6phrediYEQr0Ey8McAuAZ1MICBw0+7f1eoYK2F4rbmJ/KSc8o5aQh0W35vGyCHrJ5Pw9zp9r7stAv3pXDCDLnySLCcXDKT2MoejbP8lmhFXo0MtfLnWqjSsdzPhcBJOHjjzckY0KiJmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8BiRwwW71JX92KArF8HpMSh0vICe7DrtfaxTVwV2uQ=;
 b=Tbx+Fv7qPB/nr1E/KOVi6Cf/I05VYbTRRTYyThXQPq95BZZRJ96imfvbJ2YuxF13w2C4fh4G0iaEhYkxuzRQhQDN0qBl5J/yBbTm8Q3Sq6dp0d9bsIclCSLvw9kmz6NfukJPF8qyDhEEBVjdXiv1uL+UTQ8d/R3l8d/kJXOsMOzNbh7uoZ9KzpWa5FtO9UB+g1TWDf2xUArqKXEd5aXPHUE+nKQc0Cz87H9j1l37esnJptgmrEeETRBHcaKYHur5E+a+No58GhBPWD7eTJ4Z/HkQ9jgT+kKFKg1OV7H5auShrubXNd0mHZuyv1wpuhjWeM8wyDDGYH1AAagxVUj2DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB7850.eurprd08.prod.outlook.com
 (2603:10a6:150:5d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 18:14:14 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8746.035; Fri, 23 May 2025
 18:14:14 +0000
Message-ID: <4fdff680-5e77-40f2-812b-70697ad8ae64@virtuozzo.com>
Date: Fri, 23 May 2025 21:12:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/24] block/snapshot: move drain outside of
 read-locked bdrv_snapshot_delete()
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 hreitz@redhat.com, stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-4-f.ebner@proxmox.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20250520103012.424311-4-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 9220f043-41b1-4b78-1b88-08dd9a259ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFlvOTVqSE5ST2wxZHF3WGUrdUE4LzAxemtwVGFLUEpMQ041Znp3dnBwNFhT?=
 =?utf-8?B?b0NaRkM2NHRJTjNpZ2tZZVQvOVkvVU9KTzZtVjNGc0Y2c3VpTjhKNWI1NFVq?=
 =?utf-8?B?eG1maGZZRjhuU21OSGZUQ0pITVREazhoN0prVlBWMU5zV2ZnaUNGUldybHFH?=
 =?utf-8?B?akJPQW9IeVFVZkRPelZPWFJwT0FES0p4ZzljcnEwSmIxeHRzNDVsMHBtV1Ja?=
 =?utf-8?B?dGRyRGhRVWhVMXY2b2ljTDh5MVZMVlljL0F6aEJzRUVhZ2dYSURnQnJ4ajM2?=
 =?utf-8?B?czdSYVpZZWsrdmU1aVVWb09EMW16NFJaQ0ZVbGdneGY4M0JxVlppT2JjN2dw?=
 =?utf-8?B?cis4VlIvTzdITERwWjNhdkljZHQ5VmFBaGQ0dFlOdmxlTjAxWjRvZFUrWlJS?=
 =?utf-8?B?RU5MbE51ZURCdllOQkRCZWFhZEZMMWJsTDNycEZzWjhOVHNIYmVCV2RyZkxK?=
 =?utf-8?B?NWgrc3l2UkpwSHlDL2IweXh2REV4NmdMQ0pmTHgzcUlPSFNpUFYwYndqUDFJ?=
 =?utf-8?B?amphQnVwWDNGRFpTL1hKWGlFclF3SEE3alBBZUxQek1YRC84ejM4L0psT3FC?=
 =?utf-8?B?ZytVMnVYZ2ZIa0E5WGR4NXZiZmprbzBTV1JQQVQrQmxDR0tZT2t1a0hCaU9J?=
 =?utf-8?B?cUhKQkswaUl1bFZQbG5iTDBMNmt2YVUwV2Rkek92ZVcwVXJtczd5QVlVbnRQ?=
 =?utf-8?B?ZG1rbStwak9jcjhVeCt6ckdqUWF2QXB0N0E4dzZqV0tiSzV3WlhVV010cllO?=
 =?utf-8?B?YjZVVkV2dGxOTWJUd2NTQWM3aW8xZlo1T0IrQVM5QmllMGQ4TGhOMDBiWDlQ?=
 =?utf-8?B?NkdvMGZsSU1xeWg5dHRjeWJPak9HSDhYQ3BnV3kwV1ZFUHRRcytEbThxTXhv?=
 =?utf-8?B?cnRLYU9LNXRGRE1DL0d5akg3VXd2MENBWTBMMXZEREdDK04wczNRWExCTTZy?=
 =?utf-8?B?VHFnVElCeGgwKzBkQlZaUDBZYlRiTXNETy92MUswRlNhRFZyeTR1dUJZNDhB?=
 =?utf-8?B?VWJxUW5qMGZFS2V5QXRQUGhaNmxTazNVbThkZVpHUlpKN2orUWxHV0ZaU0U5?=
 =?utf-8?B?ZTd3UXRnUDhCd1dKbUNHY1pzanlIdS9KNlFoeUtsZThtcnM0R3hDV0UxdXZ1?=
 =?utf-8?B?UUxWU0JpcVAxYXpOeGhwZEhyYU5PSkpLT0w4czNpamM5SjVGZmxUMTNRVlA0?=
 =?utf-8?B?NDQ0VUowblRWVzVUS2lSTTdINm1ISVFvdFZ1eEwxQmpyTFZGdjZ3MjM0YU1Q?=
 =?utf-8?B?Y3ovRHlNTThjUk5GODkxQnJRUGxoTG1zdlFoMUdyc1pBeTJjNDY4dFZCTFh5?=
 =?utf-8?B?S2ppdFVLRW9OdHlkcGZQdnJJMVdEM2MwYWxCcjhMQ2dWck5JNTZ4VEx5Tk1v?=
 =?utf-8?B?YTExcGV4dU5xK3M5UkhmYmkrYm80U25pUmFtek11OHNaL1hkS2dGNVVjeUxn?=
 =?utf-8?B?NFdCKy80eXVqdm5nbFB0TDZnRTVEWnlxQ0FxRjZqdlQwb3RObnhKZUQ5bEow?=
 =?utf-8?B?ejNRdDFUVmJoV2VNbVZNaUkrcEhCS1AvZzZOZ29Oa3RmbS9sVVltdVlmRmNm?=
 =?utf-8?B?aDFDbTdRRXAwekFxWUlJanBtaS9qZFl2VG1tbnN4Ky9sZTF2cXZaalRQYXlO?=
 =?utf-8?B?R2RNTkZJOFRGTm50NndlWEhzSzZqQU5GS29sRUlwK2NLRTVYK01oRUtERnVZ?=
 =?utf-8?B?eWNUbEhObHJlQTBsR0MxWmQvM3YvelJEREZFVjlFNEEvZGRHSjFKYis5YkUx?=
 =?utf-8?B?QjFOTEE2QnFoMDZVaXRmamZ6dmNQY0tQRlpyVWFsQ0J1aWlDVU9XZ3BqOXFz?=
 =?utf-8?B?bGZxZjhHZVYzYnZRSjJ3L0ExNlVJcW1Ubm5BeXk5TFh6RWJLaU5KazhseTNZ?=
 =?utf-8?B?N1A0OFVyMTB6M3MrVTJZNjYrK2dWVTBQcFNwUGxEQ2ZFL0VkUkwzazBZZHVD?=
 =?utf-8?Q?dwlIqEZZmu8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RuOCtOWnE2cTU5QzNCUU1EeWhvdzY4Ujl3NlpsMTdVbkpXVzBFUzBXL2o1?=
 =?utf-8?B?WFJ6VTUwdTBQc2hMenNIK2xtblZzT09SYUhoQ3F6WkJCeVVlL3U3ZEM2T1dX?=
 =?utf-8?B?amFKczNuR2l3a0NJUmlJd0RqcG00QnoydUZ6dk1venN1QTlIYTlQbTBkR0FQ?=
 =?utf-8?B?YTZrdFNTWFBYNTlBTG5IV1pyRTNjQjc5N2xUTEkybDJQMWZMVWFNQXJrTnkv?=
 =?utf-8?B?S3dObWE2MnREc2ZmTTcrR21LRlFZc3NQV3IzOTlNbU0rd2JJUlN6WGNKdENW?=
 =?utf-8?B?a05RY2YxQitVM21MWS96aUJxeC9Db3dMRzVpV29SMTFlSnMzTGNETXMvTzhC?=
 =?utf-8?B?NmJzM3NBNk9qWWpuY0NRSDlsNS9wQXp0aU5xZXBBUDJYRC9kb2g0cEZsd0wy?=
 =?utf-8?B?RjJnaHRXanViUzlCWHFJOWs1dmd6a0M4YWRMTkgxa1VhZ1lETXBreENkWG9x?=
 =?utf-8?B?R0hXN0NCVzdXSXN1L1dkZGREWW84Z1pMNXBFNmNQL21NTEp3elh5dlVFdWZa?=
 =?utf-8?B?SU80NzJERjVyUkFTTXE2ZDZTUzByaUJkaGJNRStPaWtQQkx3d1lLcDIxS3JM?=
 =?utf-8?B?ZTVMVlEyeGVlTXBwSjNPU2tNYkJrbW1qMTJHSGZxTnBPR2UzcnFqUjFTVjJB?=
 =?utf-8?B?eGlKM25zQVh1K1R4cXdWVk5pUDdQYjRabmNVcGU5NFZZTVRFeFVTeDJIMUZD?=
 =?utf-8?B?VlJOM2tzY0NrOTFDTFRlcFhuZE5EdzJ0Vml0TnU2elIxcWFXWmVyNXVvZXFx?=
 =?utf-8?B?Ni8xaEdNVE44aDNHWTgwSHAxcmE4c2pxUmI4THh0NzVaSVp0Y0FLZmxNTmJj?=
 =?utf-8?B?WGJQR1FZNjRqTUFCc0FHaC9vUG0zQnBzaVNrZVRyZFlRQUw1OU5rME9JMlFz?=
 =?utf-8?B?aVFkKzd6T2RzVHU2Z0RIT3VVVlNaaXAwY1lLZWJaYXRmL2VENkN2ZzlpcnQr?=
 =?utf-8?B?bEhYU1kwemNPOGFHMFpkS3VSQUxDd2RTSEtzbDRpWGxjbWkvMU1mZkxDSDFL?=
 =?utf-8?B?R0tkTEhxandzM2hveUx3My9leW51Q0gwWnIwcEltaHJjZlg5dXlFZzNtYWcv?=
 =?utf-8?B?SWNGL282Q1pkNm1GRXRrY09hcFpyak91Tjk4dDBEUnFDK2M4NWdZdkJRcWhF?=
 =?utf-8?B?YXV3WU9FSjlsVElSU0Z2YW1ybzNtalQwQ1ZveStZaXV6dFcrTUFjTDZuTU8x?=
 =?utf-8?B?WkRGRmRUMkY2aUk3Mm83V3hJcmZQMFV4RjZqVkxqL2ZFTkwyc3JFbEdrSVIv?=
 =?utf-8?B?VHlNTkxyZk5ra3VUellza213L0ZKVC85d0dMNmdTV0l1aVhnRWhBMlh5NVQ1?=
 =?utf-8?B?TzNKMmhZeGxFSWFQRURHMU1CVW9LUmJSN3lCS1VhZlRMVUVqcitPWlBrLysw?=
 =?utf-8?B?ZVFiaXRVVUY4NTkyYkNvU0dXd3pXbkxORTJWT3Q0cEZBRkFDK3hkL2tqVEMr?=
 =?utf-8?B?WVhiRk81S1BDdHZuY01GaStHS0tIaHBoUk16U2ZIcUxpekphTGdaalBwaitN?=
 =?utf-8?B?MUZPL2dvKzBUS2xlM2krZ2d0Z2UweU9iQ1JaYkQreHBPWGhPc2lsd1hERit6?=
 =?utf-8?B?R1g3ai9WbWM1QmtXbUExRUd2NkNscm9FenRhbW1kOFM0YnA3bjdkc0xScUhw?=
 =?utf-8?B?OExtMWNIcy8rVkRwc0FMWFRtc2NXSWxscDR0RWlZVUQ3V1N5bjV2RTI4SjFT?=
 =?utf-8?B?dE1BNFFXS2xERlVUVElqMk5DeXV1eVBlZE9iVDNtV09XZk5YaDhwMmNlcVZV?=
 =?utf-8?B?OFlsSVBDMUtZUUFUcnExSWVoVUtUTUVmb1ZXVWs0TUwvRW9OMmt6RGVrRytL?=
 =?utf-8?B?YS85c0lKTFF6aGNKUEttWGRObzlaOU5mbU9Yc25BckJrSmUwWWFPV2JIVG9B?=
 =?utf-8?B?cmgrZUUyelY1Y2Jlb1dWeHp6cVZVbXlFQSt4VVE2NmJ4WDVPVTliUko5YXQ5?=
 =?utf-8?B?eld5VmlnZnFCU3RQWmpPNXhXYU9kbkhPRVdmTklLZ2ovRjBJdHdxZmxPKzJt?=
 =?utf-8?B?OEloc09LaitrV0hSNUZNbHltaEJqbWxoRE1FbE5TbXJnVUwvS3VMbXlJa1Ay?=
 =?utf-8?B?YVI4ejBYTThXMnkyeUg5ZXA0bEJxSVVLeGJCZkpVSkxWMzhqejhpTjF5QWda?=
 =?utf-8?B?ODdTVkVjWWZpWjhtaU14TThtQ1VWdklpeEdXREVnbGxidTdOYXJjbWtRcCta?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9220f043-41b1-4b78-1b88-08dd9a259ffb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 18:14:14.6764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfAKSI/hvQGlPEzzMTrN9ggMLFZq25R/GNyZcMGaK+q0bHj5MO/BIdhtELnt9GJmWWs4KqjcTM3oFatYdMM0dhVV49UphYg4+UmzQW30BlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7850
Received-SPF: pass client-ip=2a01:111:f403:c201::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 5/20/25 1:29 PM, Fiona Ebner wrote:
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> More granular draining is not trivially possible, because
> bdrv_snapshot_delete() can recursively call itself.
> 
> The return value of bdrv_all_delete_snapshot() changes from -1 to
> -errno propagated from failed sub-calls. This is fine for the existing
> callers of bdrv_all_delete_snapshot().
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Use 'must be drained' instead of 'needs to be drained'.
> * Use goto for cleanup/error handling in bdrv_all_delete_snapshot().
> * Don't use atomics to access bs->quiesce_counter.
> 
>  block/snapshot.c | 26 +++++++++++++++-----------
>  blockdev.c       | 25 +++++++++++++++++--------
>  qemu-img.c       |  2 ++
>  3 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/block/snapshot.c b/block/snapshot.c
> index 22567f1fb9..9f300a78bd 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -327,7 +327,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>  
>  /**
>   * Delete an internal snapshot by @snapshot_id and @name.
> - * @bs: block device used in the operation
> + * @bs: block device used in the operation, must be drained
>   * @snapshot_id: unique snapshot ID, or NULL
>   * @name: snapshot name, or NULL
>   * @errp: location to store error
> @@ -358,6 +358,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
>  
>      GLOBAL_STATE_CODE();
>  
> +    assert(bs->quiesce_counter > 0);
> +
>      if (!drv) {
>          error_setg(errp, "Device '%s' has no medium",
>                     bdrv_get_device_name(bs));
> @@ -368,9 +370,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
>          return -EINVAL;
>      }
>  
> -    /* drain all pending i/o before deleting snapshot */
> -    bdrv_drained_begin(bs);
> -
>      if (drv->bdrv_snapshot_delete) {
>          ret = drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
>      } else if (fallback_bs) {
> @@ -382,7 +381,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
>          ret = -ENOTSUP;
>      }
>  
> -    bdrv_drained_end(bs);
>      return ret;
>  }
>  
> @@ -571,19 +569,22 @@ int bdrv_all_delete_snapshot(const char *name,
>      ERRP_GUARD();
>      g_autoptr(GList) bdrvs = NULL;
>      GList *iterbdrvs;
> +    int ret = 0;
>  
>      GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
> -    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
> -        return -1;
> +    bdrv_drain_all_begin();
> +    bdrv_graph_rdlock_main_loop();
> +
> +    ret = bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp);
> +    if (ret < 0) {
> +        goto out;
>      }
>  
>      iterbdrvs = bdrvs;
>      while (iterbdrvs) {
>          BlockDriverState *bs = iterbdrvs->data;
>          QEMUSnapshotInfo sn1, *snapshot = &sn1;
> -        int ret = 0;
>  
>          if ((devices || bdrv_all_snapshots_includes_bs(bs)) &&
>              bdrv_snapshot_find(bs, snapshot, name) >= 0)
> @@ -594,13 +595,16 @@ int bdrv_all_delete_snapshot(const char *name,
>          if (ret < 0) {
>              error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
>                            name, bdrv_get_device_or_node_name(bs));
> -            return -1;
> +            goto out;
>          }
>  
>          iterbdrvs = iterbdrvs->next;
>      }
>  
> -    return 0;
> +out:
> +    bdrv_graph_rdunlock_main_loop();
> +    bdrv_drain_all_end();
> +    return ret;
>  }
>  
>  
> diff --git a/blockdev.c b/blockdev.c
> index 21443b4514..3982f9776b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1132,39 +1132,41 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
>      int ret;
>  
>      GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> +
> +    bdrv_drain_all_begin();
> +    bdrv_graph_rdlock_main_loop();
>  
>      bs = qmp_get_root_bs(device, errp);
>      if (!bs) {
> -        return NULL;
> +        goto error;
>      }
>  
>      if (!id && !name) {
>          error_setg(errp, "Name or id must be provided");
> -        return NULL;
> +        goto error;
>      }
>  
>      if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_INTERNAL_SNAPSHOT_DELETE, errp)) {
> -        return NULL;
> +        goto error;
>      }
>  
>      ret = bdrv_snapshot_find_by_id_and_name(bs, id, name, &sn, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return NULL;
> +        goto error;
>      }
>      if (!ret) {
>          error_setg(errp,
>                     "Snapshot with id '%s' and name '%s' does not exist on "
>                     "device '%s'",
>                     STR_OR_NULL(id), STR_OR_NULL(name), device);
> -        return NULL;
> +        goto error;
>      }
>  
>      bdrv_snapshot_delete(bs, id, name, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return NULL;
> +        goto error;
>      }
>  
>      info = g_new0(SnapshotInfo, 1);
> @@ -1180,6 +1182,9 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
>          info->has_icount = true;
>      }
>  
> +error:
> +    bdrv_graph_rdunlock_main_loop();
> +    bdrv_drain_all_end();
>      return info;
>  }
>  
> @@ -1295,12 +1300,14 @@ static void internal_snapshot_abort(void *opaque)
>      Error *local_error = NULL;
>  
>      GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
>      if (!state->created) {
>          return;
>      }
>  
> +    bdrv_drain_all_begin();
> +    bdrv_graph_rdlock_main_loop();
> +
>      if (bdrv_snapshot_delete(bs, sn->id_str, sn->name, &local_error) < 0) {
>          error_reportf_err(local_error,
>                            "Failed to delete snapshot with id '%s' and "
> @@ -1308,6 +1315,8 @@ static void internal_snapshot_abort(void *opaque)
>                            sn->id_str, sn->name,
>                            bdrv_get_device_name(bs));
>      }
> +    bdrv_graph_rdunlock_main_loop();
> +    bdrv_drain_all_end();
>  }
>

Okay, I've got a very simple and naive question to ask.  We've got this
pattern recurring throughout the series:

> GLOBAL_STATE_CODE();
> bdrv_drain_all_begin();
> bdrv_graph_rdlock_main_loop();
> 
> ...
> 
> bdrv_graph_rdunlock_main_loop();
> bdrv_drain_all_end();

bdrv_graph_rdlock_main_loop() doesn't actually take any locks, it
asserts that we're running in the main thread and not in a coroutine.
bdrv_graph_rdunlock_main_loop() does the same.
GRAPH_RDLOCK_GUARD_MAINLOOP() does both those calls, in the beginning of
a function and when leaving its scope, so essentially it also just does
assert(qemu_in_main_thread() && !qemu_in_coroutine()).

Therefore:

1. Is there any real benefit from using those
{rdlock/rdunlock}_main_loop() constructions, or they're here due to
historical reasons only?
2. Would it hurt if we only leave GRAPH_RDLOCK_GUARD_MAINLOOP() in all
such occurrences?  At least when it's obvious we can't get out of the
main thread.  That would simply deliver us from performing same checks
several times, similar to what's done in commit 22/24 ("block/io: remove
duplicate GLOBAL_STATE_CODE() in bdrv_do_drained_end()").

>  static void internal_snapshot_clean(void *opaque)
> diff --git a/qemu-img.c b/qemu-img.c
> index 76ac5d3028..e81b0fbb6c 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3505,6 +3505,7 @@ static int img_snapshot(int argc, char **argv)
>          break;
>  
>      case SNAPSHOT_DELETE:
> +        bdrv_drain_all_begin();
>          bdrv_graph_rdlock_main_loop();
>          ret = bdrv_snapshot_find(bs, &sn, snapshot_name);
>          if (ret < 0) {
> @@ -3520,6 +3521,7 @@ static int img_snapshot(int argc, char **argv)
>              }
>          }
>          bdrv_graph_rdunlock_main_loop();
> +        bdrv_drain_all_end();
>          break;
>      }
>  


