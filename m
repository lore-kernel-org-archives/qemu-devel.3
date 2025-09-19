Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01B7CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWpb-0003bD-Pu; Fri, 19 Sep 2025 04:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWpW-0003aG-Bz; Fri, 19 Sep 2025 04:50:58 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWpQ-0006vV-VC; Fri, 19 Sep 2025 04:50:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKs//pSWMLSf4rS+Zmph6cBdjZGFsNGAyWqqYsEXPQQqVBnDdVAVGaIhIeAmT20CCaxtQYGIj/xJWkUHqNwTQQboGdcc1qp42WHFhchojYRPV0ZiF27nRdto+ajtJXoWGqtBuIq9CMx3XaNQZGhkmneRwbVFJ2wSGnba0K34I3pd2p43lbegavIC6IX+6gOqnhnWE875i0NGcctadra5GofOtBh8322ECM9j6Pnfq5w5Nm+LbTmqmR/Qcc9GZ2s0Lby49vYNap5m282R3CoIpBXaQg7T13rA+kzA5okm0hOWGkivAOlcq5muHCn0jAQcvjNJs8CgQednntowaP989w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWzDsGBAxn+zBSPVnqSSodHrGeuCaR18rcQ0MkFZaDM=;
 b=G9/8h6BfkqzzkC6X2PWmkIG1tQsZAyzBCze31+YTcIcbW+eToOXd4OjJcy4S6ANYz0vKgyKdyyO1d+sMjc2hlixgwnICP3nALcWC2zCeZoBAz/MhX8V4aFa04sC+Vgrmc0ob60CoE8cHkrQ47rzZLOl5vBjgGF5Qz0eNSV4O78hzOZ9Ov0RsriZxNLhM2eOetXX9Fmlw0sbmCilK69pHJP3e5m8Z8ZjAhPKQrwtMO/HsKJVgagu0qBUtlzG8SDFcYGtSPJ3QHN18qi4q0lM0aClynByiCvfQjxDqcjA+Mi4wiAkWWtPTV+MH4zzjtzzWL7/m+lHC0DEPZ2tBlZsNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWzDsGBAxn+zBSPVnqSSodHrGeuCaR18rcQ0MkFZaDM=;
 b=0kuS+73KOxq1LqUgQfeuCCWgDCQqymbxLSYce3HC1INXDsFRxoon7G+GEnbcj6zetb9AxEj7oCAfPdU3PTP2wpB7zprpnG4zBXKWd9DZdsxsQ3T8GSMveKYQ/4AYOe97k4g2Hp93RkC9kep5pb7JHjQijxlHgwpl27azDQ0c7Rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:50:41 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 08:50:41 +0000
Date: Fri, 19 Sep 2025 10:50:35 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 2/7] hw/core/register: add the REGISTER_ARRAY type
Message-ID: <aM0ZW5JAcOT5U1vr@xse-figlesia-l2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-3-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-3-luc.michel@amd.com>
X-ClientProxiedBy: FR4P281CA0383.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::6) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ace84e2-85d9-4b6c-18fe-08ddf7599cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0lhZmRYRmdXd2xNM0UvSGl6NjZROU5NOHBWUTBzQ0Q3cjRnaG9mQ1dRRHB4?=
 =?utf-8?B?bHExaU9VWjA3TDlyTWJTeEhPVFdvV3dsOXpCbkNWb0ZXOU5LUC81NURQdjhS?=
 =?utf-8?B?Y1R1aGFrbnBlblRFNlFpQ1RWYlBVVXBCT3VxT3krR2RXMk9XK3JaZ0RCd29D?=
 =?utf-8?B?Ylo0R1JsZ2xvWmNqOHRoRE5FN1hZNzBKVnpmUVo3d3d3dG8rN3F6NVFRVWxC?=
 =?utf-8?B?Vk5Cb24xMkYyblA4WlUvWkRadFN3VzZFZmQ2anpRQks5WmZ2SUt0L0hKY0hp?=
 =?utf-8?B?WHVVdWtEd1M3aXo1KzRjc29HdWxlKzBvR1NNeUdoMnY5Wlc1bDExWkFSMnBy?=
 =?utf-8?B?RS9wNVFpb3BKTDBNNTMvWUptUXhvd2czamQzWUdoL25HY00xS1lZYnRVVGhv?=
 =?utf-8?B?Qk4rSExUeUVaTDlKZDFwcjdIZVhaTE1YcGtVb29XV1J0WTJzU0FwOGJmaUVx?=
 =?utf-8?B?UnQ0VXVlL25RUWZvVFFpY1doT2V2aGluODRGeHdrU1BQdi9xRXQrc2t1a1VU?=
 =?utf-8?B?aWVwL0Y5UG9WdWR2cUYwK2RIakdVQzdaREc0ZlpOT1VPRm95NytNWXFUb2lK?=
 =?utf-8?B?b0xneEpBc0xlNXdYOFBGUkJQRE1KMDBrTXdsU2g1cVJYNjhhdWl5THFjaXBz?=
 =?utf-8?B?MUphamlpNXA0RXpUeUtKVzFJWWFiMVBUdDUwSnpGSHY2S2cyaHNsL0dlS1BE?=
 =?utf-8?B?MTdqQmpSYUZnN3RDdHcrUFFhalhVVnYyY2UwWHVIWlYrdlVFYTVmNUVTdTRn?=
 =?utf-8?B?K3RBaVNtV3Ywa1hpL09FQ2V4TDVZZmNnYTlhTk1tZjZuK3BKcXFOd3FpcDBU?=
 =?utf-8?B?SnBvMVBpQUlhZW5wSE0rM3lTdE5JZUxyemo5MXNyZUtDeGZxYXgxR2phUHBL?=
 =?utf-8?B?ZlZLcTdhbldiY3I4VG01NERqYTVhRXQ0ZUhqOUR4RmxPOFVZdFYvQ0w1cHR4?=
 =?utf-8?B?SDRPWUxvUHI4clN4WFdmcHZydjJXbnpTejhFRGtaSVMrZUsxNVpaUVpyaEJh?=
 =?utf-8?B?dXRNdFBUSE9zSlpnckticW9ySFM5SlRIdXVZQzR3ZEZzaDl3UnBET2VYaDkx?=
 =?utf-8?B?cnFqb0ptek1jWUo4elpoVmFjZktLWmJRTE1XWDlWZXlXajd4RTQ2d1RveXlQ?=
 =?utf-8?B?bXd5UWdTTmU5TXVtRWszcVJQNzBUWXBqS1hpaThWOGhpbjNSL0wzWDJFemdC?=
 =?utf-8?B?VDNkVXpYTEwrWkFyUG5ZTVVDYUZvaEpib1hiNCsrbmIzNVIxS0JkV2d0S2VY?=
 =?utf-8?B?R1lHaTBBZ0Jja3lyaTVvUTBLSU1ybmtnQ1V4V3VqS3lkOWdwcU9rWHJoQzdU?=
 =?utf-8?B?WXdMYnB3OEdYRjd6M3BTMUdPNXBZb1djZ0toZW1ob05qbFpvenZUdmtFOHFM?=
 =?utf-8?B?R0x3WmJDek9NZE0wNVpCVkdaaDZNSzZTR0g2S2hJbHFudzY4dU1EcXVac2cx?=
 =?utf-8?B?emUwMi9SNk5lUlVqSEFJdnk0UmQraHJWVnV1dXNnTWRJY3FQV3hnMG91cGt6?=
 =?utf-8?B?aURqRnE4WDRTTWpQQVZuVjlSN2ladVk1L2ZZVXlCZ2hUaUVrNi9ydDFNdmlB?=
 =?utf-8?B?TG1sYTZ4MlpXZFprNXBGcUxKVi85RC9QZFdBQXQyZFAvdlRQNnZVUWhkOGw2?=
 =?utf-8?B?K0NnMTFEbUNodEtMdUVLMnNvZEkwZndBYmRZd3llMFMvR1ZXK1p1bFF4eHBq?=
 =?utf-8?B?WFAyZ3hybmdrRGhaQWV5VjhwbUZTZVZiS29qVWF3VTJtbU94UTRCZzRjMzY1?=
 =?utf-8?B?OWFwdUN1d0ljMFBJVU9vbVczRE8zd3ZwWmJmZ0pEUFQzWmZHZUtBVmxUZkp5?=
 =?utf-8?B?RDMzMU5NWFpaVGFlRStaRURnY0tuajBSYlcyY3djUjh4SDA0NGIvUFIxM3gx?=
 =?utf-8?B?QWJONkZsNC91UGVmUmRwTHAyeXh5UzI1bkFLMUtUbGtKaGhqQlJJc1Q2bHFL?=
 =?utf-8?Q?zlB/d2P3z3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NqWDdlV2s5WDZCUERnYXJJT0dsOE91QVVZRmQ1bTJQNjJqL0RXZE9DbDh4?=
 =?utf-8?B?eGY3R1VTb0d3WlkrQzJJaW1KUkRmUm9tU0lHNkYydkplVFFXK2VUNEZNeWdi?=
 =?utf-8?B?VHNIdStqajJhMGJrL1VjN0p2Z3NZWGl4NTJBZCsvdzFhVEhQRnFMQUFvbWVY?=
 =?utf-8?B?MEszUGU3cDlKYnBLOTFpTVlUbVRFdU9yT3d2QVIraWh0WEpmcnVQZDZGdHVE?=
 =?utf-8?B?bHBzT1VSK3VxRHQyMXZDMGUyZVBVUFpzWmwwQUQ5WXoxTzNwZ0NaajRyUUxV?=
 =?utf-8?B?Tm0zQ3I4aGY3TGd4RVBYeUFqSXkyTmFGWmIrQmc0Y3orY05QRXdnbWIvYU0x?=
 =?utf-8?B?WUVySDBXWnBwMzllSEJ1UjZSa1JQZHNrYStzMkxVNjJKaWFtVm1jSjN6anky?=
 =?utf-8?B?Uk9tL3NFMDNPczcrQlVMRHE1Q2RXeVQrL3lwbWxObDlaRk5BRnFCOFdFT2dH?=
 =?utf-8?B?RVRiZTAvakVGL25jTmhBaCt1aVpnenpGQ1hob3JwRWZraWtjb1lBaFVoclk0?=
 =?utf-8?B?N2tFdVhwMmo0QkFNVWdvd29tekoxYjFFb1U2Tmc4VXNFa213MlBjVXV5NzlC?=
 =?utf-8?B?dGptaGdmRGZHUGcyaGxGYjRMNHlGa24yeXcyLzlNV0RhbUpxbk02SncyTHVs?=
 =?utf-8?B?WjdXeVpId2NmTjN0bVp5OGd5VU1DcFVvSEhyY1hpbUJoRldMQ0RnMWNHZWdm?=
 =?utf-8?B?SXN4MlpkcThxWUQ3bjZySmtvM3dUbjFjdmlsSEpEWnppZjEwTlRRQlJnbWtQ?=
 =?utf-8?B?N1VKZ2tXdjVYMVFmM0Y5ZWZVQzVsZUREK3NUUXNWM1E1YTRnTzN4T0hydVRh?=
 =?utf-8?B?Ylc5eHJGNVNUMXI5T1h3dTdhWDJwWjRUM2ZEYzEyTnl3OTh4Q1BPRkkvVHlC?=
 =?utf-8?B?UHRON3NMMkJKbnhubkV3YXAzLzArUGFpZGRncEtlcWtoUGRzOWVyMnNQZVFY?=
 =?utf-8?B?OE56NGQyaEg2UWd3cFdLZnNsWG1GdTR2NndGN0VhZWYrblhKZENqUTNJK0Vh?=
 =?utf-8?B?ZDZRbStIZG1aT3RqS2RXTjlsUG0zNHMvU253UWg1RHpIOHFzcXV2N0s5YXZZ?=
 =?utf-8?B?MVhKUWo5cnlrOTBEaEcyS1gyUjdRSE5Jc08rdjVXblFkTFRtZ2NNUEJUN1Fa?=
 =?utf-8?B?VU9rOVVNVmNoUm1KbmEwbm5JVHhhZVF1RkZIRkZ3b2U0NWhFajllNnVpaHRy?=
 =?utf-8?B?SGdlb2wzNXMxak8vRmhCeTJWamJmcHR5d1g3L0tPYTdIMWxWT1BCa08zSGZm?=
 =?utf-8?B?ekxzZFJ3Q1N5ak9weC83ellqcms5OWR6Z2FxWnFWTVhGaXIxYXMyK1JvM091?=
 =?utf-8?B?TnBhai9XQVNFTVVucFpvR0x1UDNFR0xabzZySTM4R2dvTm10T1V6R29tS1lS?=
 =?utf-8?B?Z0hyYXc0QitUaUFWNWhsQ3lZQ2pPYytGRHBQQmlIMWJGQ01Xck5RUnB4VTJG?=
 =?utf-8?B?WHZ1VkhmRGRCYXAzTzdtNnpDcnJVYUpSam1scnV3Z2RBQ20rcXJkVnYxUjhF?=
 =?utf-8?B?U2QzSnJHWVh6VnR5dUxOUXIvUG1FTU9veGlpbTQ1T3lucTA0aC9USmVtTk1s?=
 =?utf-8?B?bEtZWUE3WlU4dDIzZnMwdTdVRVJhN0dDZnRFUnZVWGNoVzE5aGgrZjQ4RFUz?=
 =?utf-8?B?blpPcGJPQlNpMDI3MVJPUmFmQWp3YjNLMUJ1d0R6OWRMVUR6dlkvdnZCTWs0?=
 =?utf-8?B?M0dwZ2pVdUdVdkRGLzlHbDNKb1V4TTRXcHNaM2k5NWhUUVlsNlA3YjBYeFAw?=
 =?utf-8?B?YWQ4ZFVoZGdDUVBPWTExdlowK2IyMmUzS25aYThtWnBOS0lRdFdYSEhEb1cr?=
 =?utf-8?B?NmZZcXNNcHFDSDFKRGJtZFpFdjQ0a0FzdVdxVkxRSkt1U1NjT0lqMW1aRS8y?=
 =?utf-8?B?VHJKYm5UdlNGVTZQdkE2Y3pNN21vRWswczMvcWtwYWp2SnIyb0t1Y3BQWVM4?=
 =?utf-8?B?WHg2QUF4WjgwcGhWZmk5K1Y1Q3EzcU9BWEFJL0NzT05yaHNoOVdDWE1GYXBC?=
 =?utf-8?B?S3lPU0JxRkI2TmYxNVR0UzJOMnBpL1h5QWgwTkxaZTIzY2JzaWdsU0Z3eFNK?=
 =?utf-8?B?YmgraTVwQmIrZmpYbExQeXc1L2pFdmFISlNObncvK0NjQ2JyR2VKZXdGcVlz?=
 =?utf-8?Q?frfWmrlJWkwfV3f+MwJ36VNYK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ace84e2-85d9-4b6c-18fe-08ddf7599cb6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:50:41.2352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaJl9S2hITHGwP4AbloSqONXXuJPD5dLRjCCNbLAu3kNGlyvUsQlKSzfZLRpk0e7INFqE+KasLyIhC3gsAqI4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=francisco.iglesias@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 01:44:43PM +0200, Luc Michel wrote:
> Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
> RegisterInfoArray struct. When `register_init_block' is called, it creates
> a REGISTER_ARRAY object and parents it to the calling device. This way
> it gets finalized when the device is.
> 
> The finalize function of the REGISTER_ARRAY type performs the necessary
> cleaning that used to be done by `register_finalize_block'. The latter
> is left empty and will be removed when all the register API users have
> been refactored.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  include/hw/register.h |  4 ++++
>  hw/core/register.c    | 24 +++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/register.h b/include/hw/register.h
> index 4d13ea183c7..65c82600e06 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -81,10 +81,12 @@ struct RegisterInfo {
>      const RegisterAccessInfo *access;
>  
>      void *opaque;
>  };
>  
> +#define TYPE_REGISTER_ARRAY "qemu-register-array"
> +OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
>  
>  /**
>   * This structure is used to group all of the individual registers which are
>   * modeled using the RegisterInfo structure.
>   *
> @@ -94,10 +96,12 @@ struct RegisterInfo {
>   *
>   * @mem: optional Memory region for the register
>   */
>  
>  struct RegisterInfoArray {
> +    Object parent_obj;
> +
>      MemoryRegion mem;
>  
>      int num_elements;
>      RegisterInfo **r;
>  
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 57dde29710c..4d1cce02a55 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -243,14 +243,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>                                                bool debug_enabled,
>                                                uint64_t memory_size,
>                                                size_t data_size_bits)
>  {
>      const char *device_prefix = object_get_typename(OBJECT(owner));
> -    RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
> +    Object *obj;
> +    RegisterInfoArray *r_array;
>      int data_size = data_size_bits >> 3;
>      int i;
>  
> +    obj = object_new(TYPE_REGISTER_ARRAY);
> +    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
> +    object_unref(obj);
> +
> +    r_array = REGISTER_ARRAY(obj);
>      r_array->r = g_new0(RegisterInfo *, num);
>      r_array->num_elements = num;
>      r_array->debug = debug_enabled;
>      r_array->prefix = device_prefix;
>  
> @@ -307,18 +313,30 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
>  {
>      return register_init_block(owner, rae, num, ri, (void *)
>                                 data, ops, debug_enabled, memory_size, 64);
>  }
>  
> -void register_finalize_block(RegisterInfoArray *r_array)
> +static void register_array_finalize(Object *obj)
>  {
> +    RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
> +
>      object_unparent(OBJECT(&r_array->mem));
>      g_free(r_array->r);
> -    g_free(r_array);
>  }
>  
> +void register_finalize_block(RegisterInfoArray *r_array)
> +{
> +}
> +
> +static const TypeInfo register_array_info = {
> +    .name  = TYPE_REGISTER_ARRAY,
> +    .parent = TYPE_OBJECT,
> +    .instance_size = sizeof(RegisterInfoArray),
> +    .instance_finalize = register_array_finalize,
> +};
>  
>  static void register_register_types(void)
>  {
> +    type_register_static(&register_array_info);
>  }
>  
>  type_init(register_register_types)
> -- 
> 2.50.1
> 

