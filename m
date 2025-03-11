Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FD3C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Zd-00081e-60; Tue, 11 Mar 2025 11:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1ts1ZZ-000816-U8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:31:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1ts1ZW-0000UK-Px
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:31:13 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BAAJht024109;
 Tue, 11 Mar 2025 08:31:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Eo0YOORFZsDnMle8/WG6LVpZQSIvlecDOWEdJvg8k
 rs=; b=adDzoErGRkiYdsc6pGybQ0dy8gH1Me998wFB1LP8il094vejCbYA1y7/s
 EOoXhJEke9s0vL4TJTE9q+kdtOeHdZw0WzQ9pcB3dwJfXpqBVu4SlG8EUDrhu5+j
 m5JSfLI6rLkfB+SkJpt7L6c/PqauLvpkAHanpi7wEfgr/RpaDwVI81DFGZCSv8KF
 aEixvF95XkGDSvZDZwknkvLQ7HN5GjjCLJaRQcobj92iBDDv3dyG7V8yr90kj6pJ
 6umJsmfdQZcD4jViD7VeGhatPfsep3n9+TfxQisRCovMj/6wRJf472GIckjDD1d0
 fVY9BhHnz2ydLmFCAnMGxDoUnZAGA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 458k3x782h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 08:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIDjDrubpoE+0BfdhrSviNf0MRHE7gnz0aejugvDXICwAgbBq354KhHHro6SNotceHgDMhUO44zojET5vNEqaC3H0tdhyTJuII4PxXFKblOPtKEZrYNis8VL89mOjIZJ2nUrr6C46gsw50EGHIHKoAqZlAXcFQ+iAhgSPSQyb2vlKPye0Nsuhmeu+A4mBWrJLmFCTPoumSUbOE1uxxB0SE/szWmeweKxHKwdfz0EHQni3SVeg577jLkzUo0Ib+NvTBcIDfLdYtv041BR7LUUT12MhyjA7ediQBVb9WndKa+Hy37+9pODS2EgqAY7Q2csxpVbXxLhbAXOcWSH1oninA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo0YOORFZsDnMle8/WG6LVpZQSIvlecDOWEdJvg8krs=;
 b=KR1z+z6KxFZ9bGKRArDkWMvskAvpBDBU+AEtyxS9kZjuwkGqYkPlquiiRALBa0xvza1+oOXmD124YXPrWqbmsZHX1bsi/unw7kNT3M57qM2U/umaTqkJBqc3zoGHdsG4ANVxf/Kq9RzNFOeWpAjJ+0c0KBZk7H8JsQL9vC0mOTPLkGmibQm/9Voe5GZPeSoTMMOb8loH737MMYeWrAoU0k6ztcjVV8I68bfVS/Sf+fAa5tTjmEfoyjPpyJUgjsA3NIA3TQGC9fkal3yoDTp7rdFjT+7VcpKjWdXKeH9poV/cgviAwXMc7Ndpdz1jxeERiinCVqM3wQUKK3feYMKSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo0YOORFZsDnMle8/WG6LVpZQSIvlecDOWEdJvg8krs=;
 b=SB4nyQYQPQKV6DfDLS6QK5QZ/UUFG1Xo+0HfVcOjP21UZrc+VA7YlWBmzVJyQJPfjSZkFbAeyPIA39e6GUrR8S+qJANZFzRfmZ5am9uWufe2VU+QMivm6AsTRVEv1YhrupHUBAERAVT1bfI9NnNNfzSOTtObBXbgHcwE3FrXhBtwIFD1vy24TCqBgY+qO0bATLHcRlXW7MYHiHl/BXHfpzKHop5luqZuM4FEbBc/RZSFHO7tFiZuhgPBOxRiV1WGLfdr0x/yByHEyB1oZdossDOO09IVPQ9Xp47KIUuKy5mc1ynPzChJV6gO6jNESxGhMi4hrDmVrumnLQWOTQLKow==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SJ0PR02MB7293.namprd02.prod.outlook.com (2603:10b6:a03:29f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:31:03 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%6]) with mapi id 15.20.8489.028; Tue, 11 Mar 2025
 15:31:03 +0000
Message-ID: <57bef357-526f-4381-a86d-e89d59adc1a0@nutanix.com>
Date: Tue, 11 Mar 2025 21:00:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, leobras@redhat.com, farosas@suse.de
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
 <Z89FjreYuRjEeX1f@x1.local>
 <a384ffc3-34c5-441e-9fdc-b82cf4238b22@nutanix.com>
 <Z9BVOn7x8N_f_qud@x1.local>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Z9BVOn7x8N_f_qud@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::17) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|SJ0PR02MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: fdca09ba-7881-4d81-34a6-08dd60b1bb78
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|52116014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0FMYkVHT0dZYnVNVDJYQmpNcG4zM0dKUjFLOFQ5L2FpSXo1ci85SE9tNjYz?=
 =?utf-8?B?Wk9pdTNxZlVPS015N1BCTlk4cDAvbUJqdDBIN2RTaXhIc1FueVpQRHR5amdy?=
 =?utf-8?B?UWhhZ21ZaVBLZ1Urb213UlR1aDd4ZHcxZ0xGZTNRZmxJQStXN3ZKdXNvVlZW?=
 =?utf-8?B?cTlKaUI0dHRMRk9RVDJFZG5nNlloTm5IT1dnR21QTkthckcxMWFBTVRiR29E?=
 =?utf-8?B?T1NLc1Y4YUNDVUIzd0hESE1GOFh1c01JZkpDcDQzWHV4endwTEt6UDBFQTlE?=
 =?utf-8?B?Skk3bC9hYWVIeDNVQ0I2WkJhS1dhTU1aTHVURk9Jb001ZVZMeUM1Z1JObmky?=
 =?utf-8?B?NktJTzFLQU8raElBMmMvSUxscnNNUEcrRVcyS200RG5xTkV3OGg1SXB4UjlV?=
 =?utf-8?B?UXFTbWg5V2pLN1F4UEFBeitWT0lUeXF0TzVyNjJnTHA2OHAzVHh0WG5rTkp5?=
 =?utf-8?B?VGZsdm5SUTl2Vzc0NFJxbUFGWEhXa3oxaTQxU2xON1ZtMGZuRVpEUmdIQnNF?=
 =?utf-8?B?QmYrOTdlQlVjdmZnVlhxdlpnNkU5ZWh6bzRTSHJxdHU3SWV3UWJMclo5QUtX?=
 =?utf-8?B?aFl1VmJ4cElxNVlCTzJoNlJQSzZubnFMQ1dDVi92dng2YUF2cWt0S0w5TWpy?=
 =?utf-8?B?ZzdwN1JNNWo3Z0g0UzhCMGdPcWkrRmdScW9XOE81UFlOdFo5SnBVc1N5c3hn?=
 =?utf-8?B?OGxWdjdpZ1BYckFuNm8wbll5TXNhR2FZdEhWcWp2MDZpM1NOVkpVeUUwaytw?=
 =?utf-8?B?UVpkczNpVkhhaU5TUVNwaitlamxBd1hqTGtzTEZnVG0vTjlINlZFRjZRZUpw?=
 =?utf-8?B?WVpsSFFlZWxYS1lJcFpRY2hHVzhBelQrYXUwc28vVHdhOVZlSXFBOVdKcms0?=
 =?utf-8?B?WnpIOVpNeUR0MVpzc3A1a2M2UGJKOE9JYUJERExSOFRiZkxyY1BUQXFRRUVZ?=
 =?utf-8?B?bWozR0tHRldSK2lCMmEwT1E1cDFGaFlSNC9WMk1RaWhJdVc1VTVEUTBKc0E4?=
 =?utf-8?B?U3dhTkhRSzJUUWJ1ZndGRzZnaEtRYldjelZxUEs0L2Jnc3UwZmRXYUd2V0Mv?=
 =?utf-8?B?aEwvajFhbUt2V3luU29qdDB1M2NTTEFXanY2bG1GTVFNbFpuNnNObzcwamg2?=
 =?utf-8?B?Q09zTEZ4RFJoRytyb0ZwYmlLeVd4ZHZlSUU0Z1l2ZzdydUdmeTErOFRVbFMw?=
 =?utf-8?B?UzFEdmZxd0kxZ0dxdXNhZGJUWkY3UjF2UzllVXpNQXRRZXVaM2MwMWlJSHJw?=
 =?utf-8?B?NUloMTJOcTF3NUMyQnZWOVQ3Qyt0S3FiaHhnU3hSS1dhYlo0YTl1WTN6d2dC?=
 =?utf-8?B?enprOHZWS2FoZWU3ZDhpN2NIczFMWFd6UVRXRjFUcktNNy9rRnAwdjA5Rk9K?=
 =?utf-8?B?aCtvT0hxQjArRmU3VDZkcVR6WnZJajl1bGhSTnJVZHBSWU1ZbUFYSmFFZXdN?=
 =?utf-8?B?M2VRajZkV0dDRWNMZ3BUVUNOMWpxd0hLQmkrLzJubFdsK2k3V0luZHNFTG5p?=
 =?utf-8?B?aFZuNW5OYzM2WG50SHJ4TWxOMXJNWm9UZmorVldPYzlLbjFYQVlzZkZ5NWxy?=
 =?utf-8?B?MDdZT1VuOWc3L3hERTQ2RUJib2lTN243VXJNSDRPNGZpWGZySFVsMGhDOFJZ?=
 =?utf-8?B?NUFwMmJnZktXcmdFNTNwTDNOdkFaU1lmRzNZa2dHUHVMelZZZzUxWGFEZERM?=
 =?utf-8?B?QnNtNzNyZW9kc3p0NFJrS3BKdSs0NDdwYmtiTG03ZTgydHhDV2VsaWRtNWdm?=
 =?utf-8?B?R2pTRjRiQTNhWllyVytTelNiQ1N4aTYwU3V0UTdKdHF4TVdTRmpjY3MxYTJV?=
 =?utf-8?B?eDVxYU1lWFNJcDRJWjJyTDc0dkxxNTVaZXZlNStLL252M3JQVkRLMExra3p1?=
 =?utf-8?Q?JfhbriYPBkrrf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(52116014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmdhN2pxd0x4RDdPc0RCUXlvY294WmZ3ZVRWb2xHdm5zdUVrSnI4ZEpUSWRE?=
 =?utf-8?B?ZjJhWFA2aGNLNDgvVTkxVFFrdk84Q1FvVTNwRHgzaUkxRWkva0Z3b1R6OThi?=
 =?utf-8?B?ZFQydm8zMkdoLzdQbzR0QXNjTUozVE41MnYrajhhV2FhdXJoNXFuZGUxcms1?=
 =?utf-8?B?azNpY2l4QXVQMDh1ODEvaUI1THdFc2hyZGhWWjd3K0tYUU4ra1ZkMkZNa2pk?=
 =?utf-8?B?VjJ5WXI5OVgybnRKNkgvZC9rUlZ6L0k2WGZFNWU4VFh0SDdMVjNaUStDNW1R?=
 =?utf-8?B?Ujh2SWlsSDVvVXNTRXBBYlNnOWlpb1dVNnVJR0laUTBVd3VSRzA1RnE1d0hz?=
 =?utf-8?B?RnF6bXBKS0VxRW52cmpSN3VYZCtOcnpsNkUrUmZibU5FMm8yQTQvVk9kVUhM?=
 =?utf-8?B?amJkNElxWEcwdnJLZStpaldSNHZJTUtjM3hWV2l2aHFkVG9lZ0VCeWkvd3BM?=
 =?utf-8?B?NnEyMFI1elAwUnZNZ2FEUStsUnRaL1lraGMwZnFNWDNzdi8zeC9xVzNCb0Yy?=
 =?utf-8?B?d1NtSzA3Q0RBYmVhbGszMEF3bTM4TUI4TDNvcUkvYkZKQTNoMTNYb25abkJt?=
 =?utf-8?B?VWh2MExEalZ5UU1seVFNT0w0VlUySmhsS3o1T1pLN0RGelcybjRDeVhtWjVr?=
 =?utf-8?B?NEI5MmEzcVllc0xtY1J0Vm41MG84MUxQMEZaK3d5Vi95aTVoTXVjSGw4TFIr?=
 =?utf-8?B?eVB6UVRHeWlEbHh4YWhKdjJjNjBPZXFvVmcxcDZnS3ZXQUR4em1hUUFzc1ZT?=
 =?utf-8?B?S2dxemZvMXVKM0c3S0RxKy91OWJId2FHcStxZ3VlZVM1Y1VWZzd4bGFRZWtH?=
 =?utf-8?B?S3gvOXJrYUpVeDljMU8vVE1Pc2FDRVNuSmNNU3VldGxjVTNId1NxTkJNckZp?=
 =?utf-8?B?L2h3TVExNHR3UWx0OHhiZDV1NmlaeCtxTVRnNXdHMnZlNW5razNlZGFqcXhT?=
 =?utf-8?B?QitGUzVwam44SWFMYzc4MXphQjB4Zi9razRuQUtaaXIwakhyYnV6RGR4Z2Rr?=
 =?utf-8?B?Z3RVTTllUXFlWFZkaFlaWHMyVys3WGtWOHpBWitrNHRsWkFPZDVsR3JHNEFn?=
 =?utf-8?B?Y1p4ZWpCdmQzcUhZTmlHM043THVxUzZLaWRRSnpnd1ROVHVGZGVGYXpCVkVo?=
 =?utf-8?B?M2RCQkRoS0ZmdVZIRmNtWWF4dlhoYlRTMGkwdFlVaWJsV3FubndySnk3bzls?=
 =?utf-8?B?NnBFM2ZsVTlQZXhvQ295UTJCQUNQKzE0WmRSRjBnWmI2ak5zYzB1SkNLM3Q0?=
 =?utf-8?B?N3JFYzlkSHhqbFAvcXdZS2JaTFA2ZVRralFJT2JuUmZmaTlTa3V2QTB1NzVD?=
 =?utf-8?B?SkVlTHU5bzhUcFVZUFdvY3ZzVlRZNmp6Z3JQdWdaREh2NUsvMC9WQVBCS2VE?=
 =?utf-8?B?UUJBSmFwY0NXdyt4Mk9PSjRrbTk5cjZGS04vWnNDbVJ2SWsrTWlkcW8zdlcy?=
 =?utf-8?B?RkpvTUZ5RnZ3SHE4d2tJZ3ZxMS9HckY4YUlDVlBXcnpnYUN6dVFvanZwd05X?=
 =?utf-8?B?dWxEa0cva1BvYXdiR1o4VjNSWGZ4Zk53TVFzaVphSkl5bU9IUWc2aU1lUkdv?=
 =?utf-8?B?NVRtdE1rS3ZuOVVvMjFrRGREUTBzYWtkY0RvNGVBN01ibXBXK0NSanUzOWpY?=
 =?utf-8?B?c3BKV3lLeFFHWERRZFVzSXhwSGxtRUF4aE1WWFVnT203Vk1KUE8yRGd3VExT?=
 =?utf-8?B?M0Y4ZGhMVlQxb056UWY1Z0kvdlVlUGRidlNaOG5BT3duQnl3dFZ2Vk4yNFN5?=
 =?utf-8?B?cTRvZHhQd0xjbWlvSTFRcjNXaDB6RVZLSGZXYlp1OStSMitTOXhkUElUVFZU?=
 =?utf-8?B?ZHp5bGNKeS8vUzBSRDExeENjcVRESmFnUVZNMHVFOGh4UFlONlBvMlUxZCtT?=
 =?utf-8?B?US96UVhXeGJFZE5pRzIzQXkvM3BBcmp5RHo2SHp6Vk5KaGxKdURwMnZLR1hk?=
 =?utf-8?B?bHJwbTYrRHgxVHN6S0dtTWYveENpa1BUcEl6NlZaeVovWHgveDZQUHpDR01q?=
 =?utf-8?B?ZkE4TFRYRW9vcXZwaUh5Zm9KS0ZUaWNCOXVTY1pGbUFPOVBOOUNFNi9XM2xD?=
 =?utf-8?B?R1ArdUNuOXZmUGxyWXpaZWp4eVNKcVhBSDNJLytCTHpHVERMUE00VWt2L1hk?=
 =?utf-8?B?Vm84aGZSVUtnNVpSQy9rT0pZQVhPOW40N3hORlJ2SCtYQm5Hd2VTalFER0Yy?=
 =?utf-8?B?ZEZCMHY2VldpWHQ2cjlRWXBQL3g5OVVCQjNaTEdRRW1IbDhCUDFqN0lJYkxW?=
 =?utf-8?B?UnE4cC9nWEI5ZHZobittakpJMEZ3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdca09ba-7881-4d81-34a6-08dd60b1bb78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:31:03.1133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+alMbBaqcP7/lIGW7Z+WyHHS087jWENhleaUvTfaVcgjf8OBwDPLVIMLXKJxhhgLdkasuseHTO8vJqkgFpb2u6H11hFeXdwo37jjdyxUNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7293
X-Authority-Analysis: v=2.4 cv=et4lzppX c=1 sm=1 tr=0 ts=67d05739 cx=c_pps
 a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=6R6eCzjIGqViKLwZSAAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QoNMLsgqZoEws192JbcI_dQ6ZaOoWiR1
X-Proofpoint-GUID: QoNMLsgqZoEws192JbcI_dQ6ZaOoWiR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sure

Thanks

Manish Mishra

On 11/03/25 8:52 pm, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Tue, Mar 11, 2025 at 04:15:38AM +0530, Manish wrote:
>> Thanks Peter, Daniel
>>
>> Are there any code pointers where something similar is done? I can follow
>> that.
> Sorry to make you feel like we can simplify the code, it's my fault.  Dan
> has a point that at least for now it's part of ABI, so we must need to
> maintain the stats.
>
> Then if we must do that, we don't need to consider deprecation in your
> patch.  It'll be simpler for you.
>
> Thanks,
>

