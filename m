Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBBFD15DB4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2uld-0006QH-FL; Mon, 21 Oct 2024 11:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t2ulZ-0006Px-1K
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:56:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t2ulV-0001BO-TW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:56:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFu74o025429;
 Mon, 21 Oct 2024 15:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=mA7PGoML/jRaRL4tpt3P5A884bPjFfNVpjSeVt0jrlo=; b=
 gD0b5p6Ud0R4ayITUj6PK+A3liHi8Cz+OVZP2jptMGBagcO3gjhsAsfcnmM9byrc
 yPZnFsAPxDS7uJgFejfGzD/ZDEmceNArZoAh7Gp7nhSatgrtLOYgansU6CK989lD
 FI8P16W06J9mbl+1/oZHGm7jJje49R9i2CXTruTneXUyLe6AkT1sbvhLBVowZw76
 LrTlE3W79tSnXlQQQmaqg2fFgrORlEa0wtZSxNDrQNp8tMUPv859gS2zQQ6qcRUj
 lNuudKS7VwkA3GBDZzc9LDgmiUaGEIrSSN7hOs2Rz6ljptm/hUh+73zNvKXtE+NS
 tW1la5q1ZM7n0XDSmzKCOg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqtt0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 15:56:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49LFEhUE011998; Mon, 21 Oct 2024 15:56:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42c3769qhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 15:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6edBuOhKsRS33q/Zo6/x9rzsdCtDoDqN/B0UkkfzLaAa1xEffUZ2VKH5gI0968pNdzvvKyNVO6NrAGbALlzSUwkhJZqTZoWWo7IDM7mzlnI6rQ52GfW/xhpwJL051mWeHG+tvg2Kaf2sj3762ej3yDDFrCT0PhBkp4jhDcyMeDCjDP71hEfYsEmjcpPvwDOe30AKn+LissLftRcJPOGUY+nE+dBS4zFyxwYZfpxwsbBYJEurNyNuubP34ns1yUKQvH7QdIuFh8++OTZEjIrvphJDUIVQTWwoyeQDGnSMNcrNVEtTWiQofjOOYOd518LSqAvy4NY8HeRuDMHcxgrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA7PGoML/jRaRL4tpt3P5A884bPjFfNVpjSeVt0jrlo=;
 b=RJxs78yGoJCVa5U+TRXUdxuWsDnET+prZuuj9CIynpFhB2MPyTenXR1boPlxrjEKXGrIbfoZlUu54ZXlm0XcBQKw11pXQSAnrBcN0jwNUpEHNUFkoHIuT5f4KxFWlIQNaWfawt4h/demd4wkGqCFLuCnvuD6yWqOeZzzALsoS/rm5Za3BuYut0qD2WbH8OMmigScjnivBIrlAwWNJowZXPmFgTiC/eS6Hr6mFaKoifaSabUCrqnbWoPBCBdeDDhqYtmBcqdg5tZY04VhHd7dUaKCTVSeYyguWup8OIVoQ6I+M4Av0B5woh9MVZnwhhRPAFn3pqoQaUuVWLTe/9mj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA7PGoML/jRaRL4tpt3P5A884bPjFfNVpjSeVt0jrlo=;
 b=eFZMVaafK+0+ZsRoXtlyOtBB9jl8pOk47b0/iuS2znCnpS9Pbw1FYcA2cTiWh1EKiCA5Lyql4gqoefGp7uOgbgTPFcJQt6pBdK1FeIRJJ+yBFUGeTNEUix/CsyOJuBDjPbdsAZrCP3r9dRy/pkibR1/4/FzdT382YhBU3tcF08A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 15:56:08 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 15:56:08 +0000
Message-ID: <cf7fd0a3-0be0-4dcd-90fc-1b35ae3f295a@oracle.com>
Date: Mon, 21 Oct 2024 11:56:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 00/14] precreate phase
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <e7a02200-b68e-4375-9689-5bd4b0e2a8a0@oracle.com> <ZxEzCrkAgf1LRJ3d@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxEzCrkAgf1LRJ3d@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bdcb31-a7df-4748-3f2d-08dcf1e8e051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am8zOWkzbFZBTnZEUU5GajhVSWV6L2ZIYjd1Q2E0WkJUZFUwajdEUjBDL01T?=
 =?utf-8?B?VGx3Q0VTOTVjcUtpQTROMUVqVnpMTVlBWkN6ZHpkUDJUZ0Mrem90RjU3bXFV?=
 =?utf-8?B?ZlNMWlZVeHRabFFRWE9OSUdsZjFkZUFCY3U0WE9ZTGpLR3JKeS91RXRlNzBq?=
 =?utf-8?B?ck9EanZYZjl4VVc3Q0N0T051bVBEY1pwTmJzQU5Jc0k0czlleXZtZkc0R2xj?=
 =?utf-8?B?dlhlcnE1V3plVGY3aDN2dE1jVXZNL01XRld6eHE0NmNVd0Q1MVpqRnlhcENM?=
 =?utf-8?B?dHpkcXRXdjJMWWwwY0hlM3E3c1puSVo2RC9Jcmo2WlE5QjFibTRic1poZDZU?=
 =?utf-8?B?K0thOWFqNHpmSTBYeEZBZFY1Y0hFLzNkQ3VlZXYrTVZobWg1aXo2Y2h4aVV0?=
 =?utf-8?B?MU10WW5PSkR6V20rRm1IaWZQaUdRNXFvNWhzRFI3bGRMRTQrYVJ1YktwWCsv?=
 =?utf-8?B?YWIyTkUrc3hnQjJHd3VuYmJFZWJISWpNcm5ScHQ0SUpONWgxRUJQNk1iZUtL?=
 =?utf-8?B?dmh6cXVRL1hIc3B2SUVXTERrU1JxRE1wY08vTy90bVF2TVVUM0NrVW0vRHdM?=
 =?utf-8?B?MW91WWxOOCtrSW01TlhnMElUU0cwT3lISDlIMHc2SHpBakk0NWhmMWo3Snhk?=
 =?utf-8?B?bU9JZWpLb3FsZEh0TE03M0I2ZmRhRkM3dmtkN09jaW4ra1UyTk1TWHRCZ3hV?=
 =?utf-8?B?SzBQWFRjWXJsTlhXOU5qYUxWRXArV1FnWDNVSnlsV0hQR1kzU1ZUWU9jbi9s?=
 =?utf-8?B?anFJWkNnWUFQVjJXa0hBdjlhaVllbUN5ak9FRXhVRXk3UTlGVmpxNnVUM0V6?=
 =?utf-8?B?endFZ01idWJPcHB2ck9YdFZ3TmRCcGZtemo4aWVGNWxpOXc1Y0UxbGphRGdD?=
 =?utf-8?B?MXlZL0ZWdG01NGNNRnEzcFR5MHNkdXYzNXloTDZicit1VkFwaG5zUVpXZEpE?=
 =?utf-8?B?ajNmYnhkYi9helVoVFBSMy8vbHpPQ2VZRXRMcDBnK3BObTJVTFdqSDVETjV1?=
 =?utf-8?B?K0J5cW9Lc1hsMmloS1BZUjduZjBzOXF6aHdtRG9VL1ljR1hPbnFRMldkcnhM?=
 =?utf-8?B?cFlZeXhFWXZxMnNhZmtlck5iSjJKSEF1RXdKOWkyVlhCcndzaStIT1pzczBy?=
 =?utf-8?B?cjZuY29yV0cxNWJDNlhzaFZuMmhmeWFTcFlUOHFHMy9OTTI3aXZ6ZUN1Z01N?=
 =?utf-8?B?RjROcjJvUGR5by9UYmJmUGt2SlE1YXhJUFBBVi9DL2NDc2FYcjBEY3lqc2Uw?=
 =?utf-8?B?TVpYb0d3My96Y1RYd1llK1c0Z3I4RDJWdUdkV051QVRJWEthY3pRU05Rcm1r?=
 =?utf-8?B?Ry9CVWpRR2Y5VGt3bzk1Mk9rNXovNWpFZTNFM2wvWlVCcjE4cHlOYTA0dGx6?=
 =?utf-8?B?Y2x0YXZFY0J2cFpKT1JrVFhaMUxrNjdhSFVNTDBlZG5ESHlhdlloSHM0Sk5n?=
 =?utf-8?B?N2JGbzA5aFc0eXJQcUZZSlpFOWhtQ1EwVmdqL0ZnVU1pc05Ka2pOSjZUVU9S?=
 =?utf-8?B?WHE5YTlaVURpL0o1ajgrYnJsMkhZM0YwNE0xeTFJWEpIVlA3Z3ZBc1dqTDZ4?=
 =?utf-8?B?K0lQbXIrNk5ML2lwV2R5SnhUTmJQWnc4ZU1CaEpFY2tNaGkrL2Z3cWZrekZn?=
 =?utf-8?B?bGxabjNUTFJidjNEYVZKOXAzbU82TU1ibk1ZYVFqcUFMZ3o4dlVRZkdHbUo1?=
 =?utf-8?B?aUY1eVpaWWdENThiTFNMZDlWL3VvTWo5UnNzN2tPeEI3RTNHc0JKVEVBT2Vl?=
 =?utf-8?Q?HH99vOJw5882nyvFXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFhNzBnbE9PSEVqTWJxY2NTZ3V4R1ZZcVVNVVdSRmpnVHkzV1Y3YTY1ZjJ0?=
 =?utf-8?B?L2sxWXBCeStTU0lMeTFiS3c4eFFWWTExRTUveTZMTjdUOHBKSGt1djhmcndp?=
 =?utf-8?B?SGFDUjZNV3dPRG8xbjBYTlordnRlU0duUmgyRjg0K2xhczR5QXNpZ09QclZ1?=
 =?utf-8?B?My83dU4yYlJHWnp6cUlNT3N2THE3b0pKR0ZhWllWYUVPVU5uZ0hzSDZwbEJv?=
 =?utf-8?B?QXE2UnltRzFVN2pudVQxSG9GVjJEOVlZQ1lWbkp3TGxiMG91RUxxb2Z5eXRH?=
 =?utf-8?B?MUcxUVRnd1VpOXpzTjdzaDkvRTNXMnV2UjZ0V2NMeGMxUExJY1gvRmJIVVFB?=
 =?utf-8?B?OG5lQWN1a1dDSnFnK3daRVdHK0d6MUJ0c2ZmWktNMEk3U0VHRHpERVlQZldi?=
 =?utf-8?B?RTl1VHdxZ3Q3cWowTitURlllUnJsSkRTeC91Q3hHMWJ0U0p2dHZxdDBsWnFR?=
 =?utf-8?B?dU93RSs5VjZqdWNDb1ZEU25kTzhsOCs2QURZT1ZrU3RjV01uZ0NrZW90dm9T?=
 =?utf-8?B?MHZrVXJEUGsraE1TZWZwKzBWbmdOeUxRQlZGZEtFb0diUWxKZjVIMHJWU1kx?=
 =?utf-8?B?VmhOQnRsRit1SXh3dHlEOE5HTTI1RUJ4WmFoN2ZtTzRpRUFaRlM1ZDFZZDVM?=
 =?utf-8?B?c05rTUNqVTVUK3dTWmJTNklVTFpzMjVLK1EwbitYZEZIYU8vT2hPNnNxNGRn?=
 =?utf-8?B?K3NRdi81T1lQOU1JQ1JQaWVZa3F2ZGprRHhhQlB3bG91YVRZazhWT3U0dUFJ?=
 =?utf-8?B?VkNacllaeEZyNmd4THp5YXV0cHBMWVhzNlpjUjBweDRhcHRjMzhmeDFaOVdT?=
 =?utf-8?B?NGZIN0h5azgvam5Gc0ZMV2UxRnlubXdxZG9ucVRGRzhUSERXUTMwcjZ2RVJM?=
 =?utf-8?B?bUFxaWMrQnRja25BV3lKUG1yV2EvWlJzY2diQllhMnd3L1FFMkJZbGZ5bXRQ?=
 =?utf-8?B?ZWlGQ1VZK1JKMi85akRCWWJxZWppd1A1M2RNVElOUW9mL3VBSFFySG9vUmIw?=
 =?utf-8?B?eDI2QzNCMkNCYTlkTkRmWE8wVWFVbDdsVGhGeGRuQW9VMjBNenNSd1AxZyt0?=
 =?utf-8?B?NHNFUEpYZEU0ZVpKTitDZWprQmZYWXYwUUJGcXV0NDZCYisxOUhxRXhPMkRy?=
 =?utf-8?B?T2wwQTRzS2EvbnpxVzZTVWNOV0dONGdZNUtCM21UOUZhL2lPUXdxWWphdmhX?=
 =?utf-8?B?VUhVc3BkMFBvalorTytQRjlhQU5rMXJiUDg0RDVLVy85MERudFRXL08wS25a?=
 =?utf-8?B?Um5BREF2dFBZWjd6Zk0vMmNZUVRUSytjaXdOL2xwaVB4Ykx3ck9VTXU3alM5?=
 =?utf-8?B?bmZJSzBvcnkvWS92d3RFVi9NME9jaVM4alBoV0JPUmxySllFZXpYVXloYkVF?=
 =?utf-8?B?ckloWU1sNDRxN2dIb1ZCR0ZJdmExdHJNSFAyZkM2MEs5SGJuZWlCRVB1NlFS?=
 =?utf-8?B?SWFwQ1grOWdGRndYMzVxQmN4VTNpRit5WGQwbEpNOE5xWjl6TWtoM1BndmVK?=
 =?utf-8?B?M1Fndk5XVm9Ta2VYK3ZkcFhXbTVoSHNJaUdtQmpTSmJXd0l4eHJzeXJkY3ZW?=
 =?utf-8?B?U0ViajN0aWRWR2F3MUQxYlZyQWd1eVY2K1VUOEpINEJNL3NncG45S08wSGN6?=
 =?utf-8?B?a1FHOWVnbFB2SWo3NHhOa1VYSnpiMDFxSDZvcm1GMXdmQU5odUlsZlVqZ05l?=
 =?utf-8?B?aWdjVWtHZnRIbTlFbnY3SlhVNmtxdFFWV3lHR1BZMTlrRm43bUQyd3RhZ3RT?=
 =?utf-8?B?d0pzWmFTOGc5TzY0cmxDVTVSeWtldW1UTjRqZkhXM0JwQTdSQ213NTJZQlpa?=
 =?utf-8?B?OU9nRUl6cEgvczRMN215ZFBaYTFTOXI4WndGL0lZTkYyWXo2SHFUeU9LcnZh?=
 =?utf-8?B?T3k1N0dyNzZ4MklUWm9pWDB5ajZoU2FkQk9DUUdlS1VVSXZMdUw4a3BMZzRv?=
 =?utf-8?B?Zlp1a3RqNytmUDE3M2d6MWRLekwzeFdjbDJDUS9HaHMxRXg4SnpVY1lFcHpG?=
 =?utf-8?B?d0VwMEhmVHpHWTlKR0NNeHBkZWUzcWt2bkxnWStTYVNvTHIyS25ibUZlSk4y?=
 =?utf-8?B?dmdXb3JaOGdLY0hTRFRWajFMcEJpZDhxMjNWa3ROd1FhOWdoVlFReDhnelh5?=
 =?utf-8?B?dEdkMjU3OGwvaVdoYTJXd0NZekRYQXd6aUd2bEp2VnBrTnQ4cXlZbk1uMW1U?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8s1GOU/PHUB+6yccUimxP5qYLsBaQmGdsA7YJlm/EHuyQ09ZUIuScg60T00UmJddgmO3P4Tq7/Fqwdw6+oOJbGMvJTIZ+MMz2JHa1r/UZRDDUUryaqyQSOVNlkn9dodquWlAg2cAKzgIuy3HyfLr4+xJcNVUYJOI42BePgijWcD74uL0P7kqKqWrewct1uype+cHBEaXyR+K16VlpA0w2dR1RbkAwUYUPFlHmZcmMuuhLahY96DWjTfpiZ8MDfKglTk8v9XcxGDOVoXJfCX3f8DW1NWBnjdnivPGrzyAX0eAJyV8d2u8Udq4CsdGdFhp7wv3vnxdgZZHlRVBzGSboCM0gGZNtyd+CVltSofygmrAT4Htr6kBht/e7bFvvOCH2tn/lHrNwE2NSm89yzygO1mLwUzMXTRkp6Q3ba0gbQcWvN9c+Rhxt2aGBfrjuKYPKrV1gQei2xelUKYU82LDIWlwouFdj7nghrtpeqNDMxDCegWyoJsUR2XkqftBMHQbDMa8xgssA69ycNXdFcoz3tVnI9qKiQLTZY96LrRE4Gvs5QG21BK/1s6hSV3L6doDhY/rLYYTNLuHZIgGIL9HZVH9JUfBLzZcGsNZE+OVQ5I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bdcb31-a7df-4748-3f2d-08dcf1e8e051
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:56:08.0305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aHHI5LEWDQaQ43O6/C/+G8uYSFt2zfS/8uUPVuvg4ht27bMSHzvyF2qjc9BdIDoo//jg/KzsdDxo8Fuuj5xd5pnq634zm8caU0m9LmZPwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_12,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210113
X-Proofpoint-GUID: ki00H7qaoldlVoo73wQDqLkPBAg0O2Bz
X-Proofpoint-ORIG-GUID: ki00H7qaoldlVoo73wQDqLkPBAg0O2Bz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/2024 11:53 AM, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 11:19:51AM -0400, Steven Sistare wrote:
>> On 10/17/2024 11:14 AM, Steve Sistare wrote:
>>> Define a new qemu initialization phase called 'precreate' which occurs
>>> before most backends or devices have been created.  The only exception
>>> is monitor and qtest devices and their associated chardevs.
>>>
>>> QEMU runs in the main loop during this phase.  Monitor connections are
>>> active and can receive migration configuration commands.  QEMU starts
>>> listening on the normal migration URI during this phase, which can come
>>> from either the QEMU command line or from a migrate_incoming command.
>>> Thus the user can issue query-migrate to get the socket-address for
>>> dynamically allocated port numbers during precreate.
>>>
>>> In this series QEMU passes through and does not linger in the precreate
>>> phase, and the user sees no change in behavior.  The cpr-transfer series
>>> will linger in the phase for an incoming CPR operation, and exit the phase
>>> when the migrate command is send to source QEMU and causes destination QEMU
>>> to read CPR state.
>>
>> Hi Peter, I rebased the cpr-transfer series on precreate.  The
>> cpr-transfer migration-test now works.  Do you want to see cpr-transfer
>> V3 now, or wait until we get feedback on precreate?  The only significant
>> change is that I deleted the HUP synchronization, and I post an async
>> listen for the incoming cpr-uri connection.
> 
> Maybe you can still send it, because I remember there're some other
> discussion that may not settled yet (e.g. how anon-memfd is applied, iirc),
> then it can be reviewed and discussed concurrently when proper with the
> precreate series.

For now I'll reply to the open email threads for cpr-transfer V2.

- Steve

