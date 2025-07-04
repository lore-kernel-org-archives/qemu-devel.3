Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F9C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgvz-0002Oj-Mj; Fri, 04 Jul 2025 09:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXgvx-0002OH-HU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:58:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXgvu-0007QU-4s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:58:33 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BW1Al008915;
 Fri, 4 Jul 2025 06:58:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LCQG8c172UZOoMzXmOjPMzpX/5M2LryEVwJFRjn+S
 LI=; b=gMpgk6hddeBmcXSEGFD24HPkZOVR679nkbdmoxDZyafl826kf8ex0vyYz
 jgZ/+k4gq8TLy3IO0txz8spzy8qlns+Bb4utHVOhfv7JEMWLpa8Vbt8vsnGrG8cz
 ANY91ChVsru2YwwKebdSOS0Rm+FEHRgpD9tVGBjZ7x9iGfJl0ewRLb1LfzSFNJdF
 7FK0voFzgKhDBSrplHAc0ifZmw/4a3+bg5YwWk71HpnMuu7dK6HbaF5uGEN/mxLp
 cWknxKUDI0WewNU3Pz2MQ5aalB5qzOPVJsgZGkUXrNsEr+Xa2QUec/Kvx8c5ZpjP
 /7FApSl002zWykYq1W0/ALwzEj8sA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47mhw30eyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 06:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSw91HVzVYdZTUXc6eI6UEGlNwrGeXPIC/aYv218UQ8MJArTLEHuTqoVjd5Ndo5I6aZ+a0RS9vFvN6rT5RB91EDEopk/B2lJZVS78amrCLe5Wm6RW0gT9MRpEKY2wCSpRQDAYIHI9/TvjKj3JldoYNAeP8eIh6FHHx0fi9zj9yNaD/m0EHVOZuLcWBcU9lzlLSTmYspHV5TPFWA260SMSc8i2DlZS2hgsjU8z+uxtsHpex3qrMJekeGjCN3rz3UNHWvOvXMiqTQJIfORXNaxuGw2fgX0E4wuKx1Mdxp6WtWdCZYiwAfBE3uH2ew1wRL/vcz5WyfjcrEwGqAXsfX+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCQG8c172UZOoMzXmOjPMzpX/5M2LryEVwJFRjn+SLI=;
 b=WkEtguhCxz3ii+PKQSw4moceF+OOfe0fVo5nN0/oJXD4iE1830Y9WnYszAxmO47CJxn6EeVw0yd0osz+M87+C0/uJEk0m/1x66lvTJoi2UsZWh/IeoJ1YkZ8PYv6ve5ZbsEdMGRXylkz8q+Q9eJG36oPLP0c8+FSc5PdW8T7FbOPPgpebb3k+OZDGdfgB9i7weCUGKwat0gIxwLAssIFlIkAmGrlonnV5WQKqcpJYNsTfFxh5uN27DCVlVnHOeFY6/xMFxe8gju4h7xtX9To3gYBvYHyHw3G1gK6sJ+m2+lLPPNbQMyLr/25nTb54kKDjF6gJg5Jq7yn+50j1XMwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCQG8c172UZOoMzXmOjPMzpX/5M2LryEVwJFRjn+SLI=;
 b=c7G9jxyF3yq/EuXU0jTst2I5jk+GEbf1Rbck38HFsxskbSj9wFX+iPMACJWTMK1upE4Y1aHyI/OtFD5WOPz0yHmqJ/23ACy4AYTZSMfpSuLlbZQGOFOYMPw0oz9j3BF2wUQJ6ucMsCFVPE0pGLC6w7fRztnEcQKM9KRXWd1GPqQMZu0uq61HFA/s+6xAuyhNgHwF2uFQ2DbAj3sxzRDJUaehFPC/H2HRMGGs5S9XfSHs8XLIIONTjIVN4HerO/5jr9UmWlyNRJqRiCkYEGywcXSd4Ns3uTHvmHy271GmWOV2cf5ykbp76ekEAvYUbZdJs92X3pbdAuHfUB7BI0yJnA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7395.namprd02.prod.outlook.com (2603:10b6:303:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 13:58:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 13:58:17 +0000
Message-ID: <91b96b24-af60-4a89-91ec-d0e660a76a0a@nutanix.com>
Date: Fri, 4 Jul 2025 14:58:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] hw/i386: move isapc machine to separate isapc.c
 file
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-13-mark.caveayland@nutanix.com>
 <CDD9CE03-5254-476B-BB37-8BA19F003500@gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CDD9CE03-5254-476B-BB37-8BA19F003500@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 785612a5-ee7b-4e7e-93d4-08ddbb02d3d3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFpveG1OUXNqZjI1dE45VlR5ZHV1OWpDWVUxTnZyZUVHVkxFbkxWM2s3U0VQ?=
 =?utf-8?B?dzY4MGpLWnBLNkUwL2l1NSs3N1ljOWM2dFZBdW5Cbk5Vd0tyV0lPVmZORGli?=
 =?utf-8?B?QW11WDU1OGFzS1pLTkZoR09aclh3TVltRkFMK1NwcFpzZG1STmptOUNacysr?=
 =?utf-8?B?WExwQmM0SitlV1B0OGhKakRzTWtSbXEzWGZIUm1KQzJ2QS9EQlhEMmRvSnVM?=
 =?utf-8?B?YjY1bVRCc01tWTFpQVdBMlJrUEw4cFBIYTh6U2RWT3U0aWg2RlBYN24wQng0?=
 =?utf-8?B?SW4rYnRDNXV4V3phQjZkYUIvMWtWUC9USjV6aGlNS2R2MWQ0dUh6bHc3N1By?=
 =?utf-8?B?TG9MY3dmckEwVk9sbGNxSHBoQ0M1MFM2K1JtZlQwNXJJQ1RIWUhGWWxuR2pz?=
 =?utf-8?B?ZCtnVmVjekRVSU1JUE9MUjZ6RllVRmkvNk5pK2QzVk5jMFlSMzFERmJpbGFm?=
 =?utf-8?B?aW1jR0JWcEx4YXg4eVJlQTFTS2RuYW9TRmtCL0pLdzNBNnRTZEc0d3M4VnRY?=
 =?utf-8?B?SDZtRW1iQS9uT05QWE9abVlmYm9jREtZNkpnY0x6cnI3NWZBM1QrT2lpOVUw?=
 =?utf-8?B?N1kyOXNTM1YxMUhYKzdQSlhOdGdwWWhwZUZQb2ErN3VDdlVVTlkxQ1RDOC9o?=
 =?utf-8?B?V2ZJSkdKdEM2aTBMMjg4WWxrc1p1TkNRU2wrdjFoZmFGY0RrU2hFdVlEcVd1?=
 =?utf-8?B?TFVSNkZaazAzQllPWUtYaTdMY3pYbkpnN2JrcUdsdlFoemU3UDJuODNwVnlm?=
 =?utf-8?B?Ny9wR1pwR1BQQkdQR0xidDRDNzMwS01rRlZOZ0J3ZUZxakRhY01URmpMZnpu?=
 =?utf-8?B?ZlNuVTlibnhMa3hlU3J3WHVpWmZkMnpib0NEbUZNeWJTQzFqejM2M29rblpm?=
 =?utf-8?B?NGEwQmF3QnA1S0xEUXZQUEh4bGhYUklJMmMybGp0Q3ZzT2JZUWRoOHJnMEEv?=
 =?utf-8?B?anlTVUNSTEVyVWE5UG5VTG15YUJWcjNqendoQ1hUV3Zvb2trNVJJdDBTT2ll?=
 =?utf-8?B?TXd2WExRaHVuTzlCSHVacVZoL1ZoRUJoQ1U5OFYxMzRSdlFubmN1K1Fiamlr?=
 =?utf-8?B?NjgvOFgrd3dNOXRLSHBNb0h5dTlBNklNMzdzeGNPRXRmYlZTU1FoQWF6bDV6?=
 =?utf-8?B?TkZJekoyTGpqcCtGSGhnSXpHMGtSZ1BwRzB0a1BnbmJOcHBnUXlla1lKN0pM?=
 =?utf-8?B?aHdKeG9LNWRwK25ZRXI4dGhtR2VYdmNWOTRyNk9nNEtETHFPN0RscGh4eFhV?=
 =?utf-8?B?SGh6MGRzL2c2cDJZWjR5cFE2RitrZkV6TUM4bzJzc1ZTdHZPcjhuTDllY2xi?=
 =?utf-8?B?ZjBqczBMUEZrRENBM0UvY3RYdTQrWDhOSzhrK1d2Y1ZpakV6dkR2K20zZEVs?=
 =?utf-8?B?RUFLcWtxSW1OMVkrRkt0Nk1TNk0xQ3pCV2ZxR2RzNVhHbkJ6Tmk2NmYweDYw?=
 =?utf-8?B?bE02RklZU3hVWEZOcGFlRk1oblplaXFudDByVGhFSU1RaTlFODg2QWF5Q1Ft?=
 =?utf-8?B?THkxd0l4WlJOSUVucC9vemNyYlNUL2tZbElPTVZjbmozQXdGRDErNkNjWE1M?=
 =?utf-8?B?Rkg4WGN1N1FFVlkvMHpZb3RxWUtQVTdTMVFEeUpYL254emZjcEtNSjkxczl1?=
 =?utf-8?B?TlhDdC96QWJJSG04LzMrc3BTaWszRXJ2Z2RpcHM3WkJKTTVzQjBWT3gwd25p?=
 =?utf-8?B?QU5EV29uWGxyaEZ5aFFjbSsrOVY3VkRnTERLcTBXTzhINXNHazd4NUhxUUM1?=
 =?utf-8?B?WGxKZ0xxRzV2c1gydHk4RGNEcGlxWkc2eEdDVkRpK1hGd3FBM2NzUEpJdXpD?=
 =?utf-8?B?VHFGMjJyem5qUDloVjZkNEJGMkllYWIyNVZBdFVMOU0zSVhPcEF3NG1xZW9L?=
 =?utf-8?B?RFVtOHVuWVBGQ2padFJGaXJHQVorZWZFL1dpY2VabVNUd29FRGRtclozdnRw?=
 =?utf-8?Q?Mscrypw492w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZrblFad0M1QlR0cXQvVzFEZFJRRmtQUHdXVHlUY1lYelM0RnY0VzFzZlc3?=
 =?utf-8?B?NG9VQnFtSUp0eVpOSzhSUE5sN1I5QjJvb1ZHcm5xTW14RHhocXFHY1NySDBS?=
 =?utf-8?B?cllob0V6bVloZzh6RVozTnphdWpIdjgyWFQrakw4Um44Tm5WZ21zSlA0bDZS?=
 =?utf-8?B?NzhFa0F2MDF6azcxVWo1MC9XMFZBYURWcVd5dzQ2aDYvL2JiS3FsVnBidXdr?=
 =?utf-8?B?TGZsanN1eTRiTFNteFFKSGNaK2RPWWdnR1hBc0JvekhmNzQ5YkU4bllhaTRE?=
 =?utf-8?B?Z3YxcnMvK3JUcnhlUjM5aHRBNnZXUUZDMlNDUm51ajdIRm5oN2VuQ3RiZDZl?=
 =?utf-8?B?QzV6a3ZlQmpvNHNONzV1d0FkbUJ2S0U5dVlCT2dGRUZlSWhENllualJTWEk2?=
 =?utf-8?B?SFdEdEZiSWFsWUVXajdwNzBjUTBlNmdjUVdVSTloT1RhRnQyUFhsTUxqNUJG?=
 =?utf-8?B?RUMzWmx4Y25iSWRYNnVpUldUZUN5WStyT3g2RmJXSmFraEZKMC84R0RJZFpr?=
 =?utf-8?B?MG16TWRZanQyVWpGNGg5aHZ5NjU4dGprY2VwMzZPTW9mZmR3dUZ5UzV6eU45?=
 =?utf-8?B?MVgvUlJJaU0rMHJDWVZES2h3S09ySTVDekZCUWRQVk01Q2xNOFBhOXFLY2N3?=
 =?utf-8?B?M25UMEs0aDlmSTVTOXc4SGU1bHlxYjVCcmYwd29hSS9rOC8rNEh5YmVsTzBT?=
 =?utf-8?B?Sy9lZjZDdHFPN0JYNHBEazBLSER4L1BGZlFlL0ZwRTkvMzJ2M215aTg3bm10?=
 =?utf-8?B?aXc4QTM5RWMvOExXOUdLanhlUjV0SjFHbGhMaTI4bGhhdVlEWDkvdlY4Mmli?=
 =?utf-8?B?Vm15cVZxdlNMdTZQak13MDRhcFBiZzJ3L214NUZZODF1OHZpL2hCU2VnTis1?=
 =?utf-8?B?T05iT1grN0xWWjZuckRkWTlGaHZianlxQUwzWWtqUE4vZUw4a2drc05tTGxV?=
 =?utf-8?B?alZVNFVBYUQwY0JKV0tuQVpJT3cwdjIwZnJlNjBqMUxxc0xKWWcvSkdRWHJV?=
 =?utf-8?B?Zys4WkJMWUd2c3AyZGhybFlBVkhsalV1UE5TL2drUFBTbGdjdWtsMFVpQnhS?=
 =?utf-8?B?bTcxbytzS0g2cUYwaFdLMGVhbnBUZms5NUNNc21OUEJzK1ovMGM1bmdxRURo?=
 =?utf-8?B?bkNST3lCSUg2QjA0R3VTVzRkK1hlWjlzL284MTFWb3B4U3Bsajd5blhOdmh1?=
 =?utf-8?B?T3kyTWZ2Z1RiT2JMK3ExTHhGdnV5UUExMURLYzIydG5BUGpmMzA3MlVDdGVF?=
 =?utf-8?B?LzJDaTltVHZUQ1ZNbGh5aXJwRnNhbVAxajlKVUxEa1JpU21FS3lCMUNkUlVB?=
 =?utf-8?B?dTN0T3J5RzlPS3RtMFl3Y21pejJPVVRRNHhnVFBHVVVvRll0TU40bjBvaDRh?=
 =?utf-8?B?SFBHOUZLL2h4SHhSZmZIaEFKMmh5a1dDUmMvdG0rRUVSSUR5blArMXNKakNG?=
 =?utf-8?B?TkVMU2FXWjBUUTIvcVJFQzI4N3FVUzNEdDNWcXIyZXVaM3I4U1loQTNsSTFh?=
 =?utf-8?B?dlBKUzhzNnFtbkxqMUR6REZTd2J6Mm52RzVwVjFHNXFQZU0zYVJ3UWc3cXgw?=
 =?utf-8?B?cnFGQ0krMTduMUhpbktDSUpFV3RCQWlVYmdwNDZXWjlVS0RwWkl2Q2dYWjF6?=
 =?utf-8?B?aXFzUENhSlc0T2xxV001ejE3cjV6NTNYVGdOUXNXYkFRZ3FueUVPTzdJL3Vq?=
 =?utf-8?B?NW5UTi9XVTZwOTJPRXVxS2FHb1VmbVRUNVJwLzNoQjRwR3hybFlZWTM0cWNw?=
 =?utf-8?B?YWZwZ2c3a1l6NDllLzVkV0kzeE9hZ2xRR08ybWViMHVFRDRyRGxrL0pTNGNo?=
 =?utf-8?B?UVBNUTU5YU9PMWdLSFJ3Q3ZnNUtWckR4NWtIZGkwazV4S0UxeFV0UzI4WjBN?=
 =?utf-8?B?MmZuajg4WmR0c0Y3eUVQV2tDM3VrcjduTXptdHQ0MzhneG50Q0FLd2NrMGdV?=
 =?utf-8?B?Z1BkQmhISkwzWUhveldJN3pKWlJPTnljUjRSelBnN3RZQlR0dEVOY2JRbFBB?=
 =?utf-8?B?bFpQZllRaDM2Y202K0xlamlyZVRzR0I0WnJ2RUVWT0VXN29maThtK3ZVOFFn?=
 =?utf-8?B?Q09nMkJXWDJPQUVvckYxLzhOTDdnZ1p2MDgvai9YYW1uLzZjVkxKNUNSVHJn?=
 =?utf-8?B?eWRIYmNIMmNGY3NSUk0zTUdsVjRRaElNUDd3R2VObTdmUmsrK1RhU1lTNWRP?=
 =?utf-8?B?SUZFZkdlSG10YkRVZENpUFNCb1gveXVaMm1tdHFIT1Zza1FkdG1oU2ZCSHlR?=
 =?utf-8?B?UjErRDZzWHl3T1NlOEhGVU9qdWZBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785612a5-ee7b-4e7e-93d4-08ddbb02d3d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:58:17.5762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNKhTLUEfyifIs8VNbo0s4llsus/OZvmFg0vsm0JunCLn5sbOzy3/q4i1kZgRTYTRQ052yfeMv2OKwotH1VI3bT0+QriHKjel0bNTVUbUZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7395
X-Authority-Analysis: v=2.4 cv=ctGbk04i c=1 sm=1 tr=0 ts=6867ddfd cx=c_pps
 a=CixL6RxEtn7Qem6gLs8pAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=pdBLb1X9pviJ5iWRsJgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d7YwUvXtjFx0I2FNDBRtDeYkAWycgDOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNiBTYWx0ZWRfX4dulVb5JIj8k
 J2qLK69qWQ4dh3mU9uQr4cLqbjybjrAWuJyJejtGvHAGM2VfVMdPVUGzryvwqRjSA+Ommfo5bON
 pg9qdn1Wa/rg0w6/8nwhAG1EVL3jlYiOplNQaMyIpTgLzlvPHRbETKjpEWtoxaoIPxLdpzI9l9O
 UO4uTskOgZ3lS2IKb3ZVylzT3GLdKV5qqrPU95NxrSuVZxmOJgx1YmO91ADFGsSicq5W3mlJkjj
 CHWuN0tGqmBNpKUrUs/L44DHsGw+XELTqfTpk/1fWsO1U7xB2EcFLrCFUYzCRXROa44Ysa606kH
 ITPHYFUjIxwG0rhMzMi1itXUN2h4TzWygQZj+OY30XtMx6qWaSSbbl1x0XtttD/i7/tsqutPWHJ
 7ftC+6s9rxaWi4ZSTUrU9Auvsvk3SlqMcUa1IScmI0zcFK8HzMWLZI0nbNxcFx3vNQvoXeKJ
X-Proofpoint-GUID: d7YwUvXtjFx0I2FNDBRtDeYkAWycgDOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 23/06/2025 11:47, Bernhard Beschow wrote:

> Am 18. Juni 2025 11:27:17 UTC schrieb Mark Cave-Ayland <mark.caveayland@nutanix.com>:
>> Now that pc_init_isa() is independent of any PCI initialisation, move it into a
>> separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
>> I440FX in hw/i386/Kconfig.
>>
>> Note that as part of the move to a separate file we can see that the licence text
>> is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
>> ("VL license of the day is MIT/BSD") so we can be sure that this was the original
>> intent. As a consequence we can update the file header to use a SPDX tag as per
>> the current project contribution guidelines.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>> hw/i386/Kconfig     |   3 -
>> hw/i386/isapc.c     | 145 ++++++++++++++++++++++++++++++++++++++++++++
>> hw/i386/meson.build |   1 +
>> hw/i386/pc_piix.c   | 117 -----------------------------------
>> 4 files changed, 146 insertions(+), 120 deletions(-)
>> create mode 100644 hw/i386/isapc.c
>>
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index eb65bda6e0..a7c746fe9e 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -96,9 +96,6 @@ config ISAPC
>>      select ISA_BUS
>>      select PC
>>      select IDE_ISA
>> -    # FIXME: it is in the same file as i440fx, and does not compile
>> -    # if separated
>> -    depends on I440FX
>>
>> config Q35
>>      bool
>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>> new file mode 100644
>> index 0000000000..74ffd19307
>> --- /dev/null
>> +++ b/hw/i386/isapc.c
>> @@ -0,0 +1,145 @@
>> +/*
>> + * QEMU PC System Emulator
>> + *
>> + * Copyright (c) 2003-2004 Fabrice Bellard
>> + *
>> + * SPDX-License-Identifier: MIT
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "hw/char/parallel-isa.h"
>> +#include "hw/dma/i8257.h"
>> +#include "hw/loader.h"
>> +#include "hw/i386/pc.h"
>> +#include "hw/ide/isa.h"
>> +#include "hw/ide/ide-bus.h"
>> +#include "system/kvm.h"
>> +#include "hw/i386/kvm/clock.h"
>> +#include "hw/xen/xen-x86.h"
>> +#include "system/xen.h"
> 
> I believe that Xen can be pruned from the machine as well since it requires PCI AFAIR.
> 
> Best regards,
> Bernhard

Thanks for the suggestion! I got in touch with the Xen folks over Matrix 
to ask about this, and the feedback I received was that Xen does support 
non-PCI IO and that in theory it "should work". So I've left this in for 
now.


ATB,

Mark.


>> +#include "hw/rtc/mc146818rtc.h"
>> +#include "target/i386/cpu.h"
>> +
>> +static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
>> +static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>> +static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>> +
>> +
>> +static void pc_init_isa(MachineState *machine)
>> +{
>> +    PCMachineState *pcms = PC_MACHINE(machine);
>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> +    X86MachineState *x86ms = X86_MACHINE(machine);
>> +    MemoryRegion *system_memory = get_system_memory();
>> +    MemoryRegion *system_io = get_system_io();
>> +    ISABus *isa_bus;
>> +    GSIState *gsi_state;
>> +    MemoryRegion *ram_memory;
>> +    MemoryRegion *rom_memory = system_memory;
>> +    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>> +    uint32_t irq;
>> +    int i;
>> +
>> +    /*
>> +     * There is no RAM split for the isapc machine
>> +     */
>> +    if (xen_enabled()) {
>> +        xen_hvm_init_pc(pcms, &ram_memory);
>> +    } else {
>> +        ram_memory = machine->ram;
>> +
>> +        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>> +        x86ms->above_4g_mem_size = 0;
>> +        x86ms->below_4g_mem_size = machine->ram_size;
>> +    }
>> +
>> +    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>> +
>> +    if (kvm_enabled()) {
>> +        kvmclock_create(pcmc->kvmclock_create_always);
>> +    }
>> +
>> +    /* allocate ram and load rom/bios */
>> +    if (!xen_enabled()) {
>> +        pc_memory_init(pcms, system_memory, rom_memory, 0);
>> +    } else {
>> +        assert(machine->ram_size == x86ms->below_4g_mem_size +
>> +                                    x86ms->above_4g_mem_size);
>> +
>> +        if (machine->kernel_filename != NULL) {
>> +            /* For xen HVM direct kernel boot, load linux here */
>> +            xen_load_linux(pcms);
>> +        }
>> +    }
>> +
>> +    gsi_state = pc_gsi_create(&x86ms->gsi, false);
>> +
>> +    isa_bus = isa_bus_new(NULL, system_memory, system_io,
>> +                            &error_abort);
>> +    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>> +
>> +    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
>> +    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>> +    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>> +    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
>> +                                   &error_fatal);
>> +    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
>> +
>> +    i8257_dma_init(OBJECT(machine), isa_bus, 0);
>> +    pcms->hpet_enabled = false;
>> +
>> +    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
>> +        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        x86_register_ferr_irq(x86ms->gsi[13]);
>> +    }
>> +
>> +    pc_vga_init(isa_bus, NULL);
>> +
>> +    /* init basic PC hardware */
>> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>> +                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>> +
>> +    pc_nic_init(pcmc, isa_bus, NULL);
>> +
>> +    ide_drive_get(hd, ARRAY_SIZE(hd));
>> +    for (i = 0; i < MAX_IDE_BUS; i++) {
>> +        ISADevice *dev;
>> +        char busname[] = "ide.0";
>> +        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
>> +                           ide_irq[i],
>> +                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
>> +        /*
>> +         * The ide bus name is ide.0 for the first bus and ide.1 for the
>> +         * second one.
>> +         */
>> +        busname[4] = '0' + i;
>> +        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>> +    }
>> +}
>> +
>> +static void isapc_machine_options(MachineClass *m)
>> +{
>> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> +
>> +    m->desc = "ISA-only PC";
>> +    m->max_cpus = 1;
>> +    m->option_rom_has_mr = true;
>> +    m->rom_file_has_mr = false;
>> +    pcmc->pci_enabled = false;
>> +    pcmc->has_acpi_build = false;
>> +    pcmc->smbios_defaults = false;
>> +    pcmc->gigabyte_align = false;
>> +    pcmc->smbios_legacy_mode = true;
>> +    pcmc->has_reserved_memory = false;
>> +    m->default_nic = "ne2k_isa";
>> +    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>> +    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
>> +    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>> +}
>> +
>> +DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>> +                  isapc_machine_options);
>> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
>> index 7896f348cf..436b3ce52d 100644
>> --- a/hw/i386/meson.build
>> +++ b/hw/i386/meson.build
>> @@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
>> i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
>>                                        if_false: files('amd_iommu-stub.c'))
>> i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
>> +i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
>> i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
>> i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
>> i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index f9d7967dee..8cfb228f13 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -415,99 +415,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
>>      pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
>> }
>>
>> -#ifdef CONFIG_ISAPC
>> -static void pc_init_isa(MachineState *machine)
>> -{
>> -    PCMachineState *pcms = PC_MACHINE(machine);
>> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> -    X86MachineState *x86ms = X86_MACHINE(machine);
>> -    MemoryRegion *system_memory = get_system_memory();
>> -    MemoryRegion *system_io = get_system_io();
>> -    ISABus *isa_bus;
>> -    GSIState *gsi_state;
>> -    MemoryRegion *ram_memory;
>> -    MemoryRegion *rom_memory = system_memory;
>> -    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>> -    int i;
>> -
>> -    /*
>> -     * There is no RAM split for the isapc machine
>> -     */
>> -    if (xen_enabled()) {
>> -        xen_hvm_init_pc(pcms, &ram_memory);
>> -    } else {
>> -        ram_memory = machine->ram;
>> -
>> -        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>> -        x86ms->above_4g_mem_size = 0;
>> -        x86ms->below_4g_mem_size = machine->ram_size;
>> -    }
>> -
>> -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>> -
>> -    if (kvm_enabled()) {
>> -        kvmclock_create(pcmc->kvmclock_create_always);
>> -    }
>> -
>> -    /* allocate ram and load rom/bios */
>> -    if (!xen_enabled()) {
>> -        pc_memory_init(pcms, system_memory, rom_memory, 0);
>> -    } else {
>> -        assert(machine->ram_size == x86ms->below_4g_mem_size +
>> -                                    x86ms->above_4g_mem_size);
>> -
>> -        if (machine->kernel_filename != NULL) {
>> -            /* For xen HVM direct kernel boot, load linux here */
>> -            xen_load_linux(pcms);
>> -        }
>> -    }
>> -
>> -    gsi_state = pc_gsi_create(&x86ms->gsi, false);
>> -
>> -    isa_bus = isa_bus_new(NULL, system_memory, system_io,
>> -                            &error_abort);
>> -    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>> -
>> -    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
>> -    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>> -    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>> -
>> -    i8257_dma_init(OBJECT(machine), isa_bus, 0);
>> -    pcms->hpet_enabled = false;
>> -
>> -    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
>> -        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>> -    }
>> -
>> -    if (tcg_enabled()) {
>> -        x86_register_ferr_irq(x86ms->gsi[13]);
>> -    }
>> -
>> -    pc_vga_init(isa_bus, NULL);
>> -
>> -    /* init basic PC hardware */
>> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>> -                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>> -
>> -    pc_nic_init(pcmc, isa_bus, NULL);
>> -
>> -    ide_drive_get(hd, ARRAY_SIZE(hd));
>> -    for (i = 0; i < MAX_IDE_BUS; i++) {
>> -        ISADevice *dev;
>> -        char busname[] = "ide.0";
>> -        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
>> -                            ide_irq[i],
>> -                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
>> -        /*
>> -         * The ide bus name is ide.0 for the first bus and ide.1 for the
>> -         * second one.
>> -         */
>> -        busname[4] = '0' + i;
>> -        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>> -    }
>> -}
>> -#endif
>> -
>> #ifdef CONFIG_XEN
>> static void pc_xen_hvm_init_pci(MachineState *machine)
>> {
>> @@ -869,30 +776,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
>>
>> DEFINE_I440FX_MACHINE(2, 6);
>>
>> -#ifdef CONFIG_ISAPC
>> -static void isapc_machine_options(MachineClass *m)
>> -{
>> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> -    m->desc = "ISA-only PC";
>> -    m->max_cpus = 1;
>> -    m->option_rom_has_mr = true;
>> -    m->rom_file_has_mr = false;
>> -    pcmc->pci_enabled = false;
>> -    pcmc->has_acpi_build = false;
>> -    pcmc->smbios_defaults = false;
>> -    pcmc->gigabyte_align = false;
>> -    pcmc->smbios_legacy_mode = true;
>> -    pcmc->has_reserved_memory = false;
>> -    m->default_nic = "ne2k_isa";
>> -    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>> -    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
>> -    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>> -}
>> -
>> -DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>> -                  isapc_machine_options);
>> -#endif
>> -
>> #ifdef CONFIG_XEN
>> static void xenfv_machine_4_2_options(MachineClass *m)
>> {


