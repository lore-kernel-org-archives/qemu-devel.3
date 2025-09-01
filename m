Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3085CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBHC-0001HY-HB; Mon, 01 Sep 2025 16:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1utBGy-0001Cy-NY
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:37:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1utBGw-0001j6-Pa
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:37:04 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 581FS6911682134; Mon, 1 Sep 2025 13:36:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=n9ZI5SLzvs8VSsvfsoVaUf0yrbCIhGgayrKk1V8bu
 1U=; b=JWrAh7I3LjXbd+9rC5Qmn5zQ6vgt6B1D1z9TgCjZtQvAjtZHOlLIV2Wly
 IOUySDExDFYC8mPT769FbfJZh2oDzArEwB5iDulxDP9NGb3EzYEy5w7uuwaoL3lU
 b0DZ+2KJ2GvY70uq9FxHKJ8rzJeeuVRZf+7GPg4V9QzOdQZfSMW4YcTG7KgcOTa3
 DzPFBos9q/xnJRoUHbcYo3rxvrpfyRBk2uEB/KJ7kahT8eq3vVZzCTBU8AddEr0T
 eDgjaFfLywSlHrEm4w/8QSsRnDzOBP43fn31JGJwUWt80qHZH6gf9iA2LqP771ep
 j3rzX9X6SGcE6soDnaNNbFhWdTzHA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48uydgv12j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 13:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlrrbnmAfZqzp1j5eJ8Yc+2JiqYc0IftFEja4h+HByotumPNHOW3RToZxrTiKaK+K2/98oSsaNTB0sL26gU8278yXeHjOGdDQniCybfbva5fD6CKSqyWcDjJdXDUS5tJveEnfj42SU+c96SAvc4VzcRTtpVok3VGNI4sdJkttLflx0avOZoQe8AWQBE3u/9375stO+SmMpIPgT2Vsccjjx4yFbErpYQhgqigFdicLXGGsGYgxFJgPUUr9DzcHnDGHayCKCmiDcdlOTkGZ4/yA65bQFVOQe78qS57DG17JM0ZyG1eEnQ68y9hkEyyYE0AD3IcAABvjwiluB5weuYivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9ZI5SLzvs8VSsvfsoVaUf0yrbCIhGgayrKk1V8bu1U=;
 b=cbOUnN3DLNzQfD1ajhLvf/KOepFsNQs2T8mDDJbWT4NxO2vIkk6WUza4DjyvR3i1+MO3Gw79xtsQQtCVIbVlvGr0zON58wLYirdUCR9aRoAhfePni+9hIJE8vaa76/WL+ePPcQ0WwhI9eohXbvUJM3lxjv5p2hrL4br5mvpKdBdYPYkUtN0o2ZEJlEN6/lgF4itviRpQWq+AYvXzhgO8NkQWs08a95m/IrVY+oJmLR++bLka8qsQyCIQ2AHnnHyjX3mxyZw2eTdZUBvIsI4fmPHXhiwvyzeDc0tVcgsBjzJXZ6ROeDAfWZRBTM5irGnKzUcDyAeFgnhqYd/RB1ut3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9ZI5SLzvs8VSsvfsoVaUf0yrbCIhGgayrKk1V8bu1U=;
 b=D+fGJq8km33fet67m2lxNYoRxqakGEzCoWp1FUw/1jVM7svXq84Wl4WjrN8YL+CYlJBdcn69yWCqb5bfDcEUADdliBiJwIGxxi6eBlaxjFXHlxJ+qRSqVS0BNTUWqgun7HIqFhgx94HmnZpBTnAWx6a4Fdz6CwyL/cE9od3hI1djhpGfHG7SNVAixVE5DK5ZCSlaITkXvcp0brlVtxp/l7dWUL1K5DQ8VSZNPImq3yn0kW/F9NClTXrV+eLKD3AZOAqPhFQpMISHthGcGXaxreynJkzDqCEyBqcEI5nhkrEuLTl37ZVM+bpBSef8mseozdFVp/5uUOBZVWlsIdrUFw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8298.namprd02.prod.outlook.com (2603:10b6:208:345::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 1 Sep
 2025 20:36:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.027; Mon, 1 Sep 2025
 20:36:57 +0000
Message-ID: <e77371d3-2301-4195-8e8a-37e9456435d0@nutanix.com>
Date: Mon, 1 Sep 2025 21:36:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/pc_piix.c: remove unnecessary if() from
 pc_init1()
To: Markus Armbruster <armbru@redhat.com>
Cc: philmd@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250901140422.1136949-1-mark.caveayland@nutanix.com>
 <87y0qytcxz.fsf@pond.sub.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <87y0qytcxz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c5cff1-0e9b-4845-cc21-08dde9974b70
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHVNMXBubjZRMUdiUlV2WSswM1NwWVk5U0NKdjZTOTd2WXd0NUFzbmYrZGtx?=
 =?utf-8?B?cnNKT1NOeVNMellRMU8rdVhpd05ORWtHUHFIb3ZVa3F4MTJKVDhkU0c0dkdw?=
 =?utf-8?B?N3lXSU41dEJLWDlkdmVqck0zYVowMktEN2NWMGRGb0xVclErd0doKzVEdHY1?=
 =?utf-8?B?MERpMThhSit2RzU1UnF4NVBwSkpxV0JqcGVqYTZocTQ4Nmo0ZW96Z3I1aC9y?=
 =?utf-8?B?Ym5lMklqbVBTZ3I1cENIeGdiaUkyQlBnR3haRkhtRjhvcEQ2Yk05RDV0NHEw?=
 =?utf-8?B?bGZ0UkRaMm5Mdi9sUXkvZktOOTFnZmEwVklXMUN1RWZhazdQRk1mNnZJZ2ti?=
 =?utf-8?B?Q1p5aFN6ajl0WCsrTVE4TldBZmdaeW4vU1RnQzR4cXNNTDNjY0lRaUg2Zm1R?=
 =?utf-8?B?Z2hvSEhmSGFpcUI2YUI5RXdzSFppM3E2NUFMcEkrK0t3TWV5MjlCM3E5bUNh?=
 =?utf-8?B?MWg2U1NybXhDV0xTRktXUlEyaFRLZ3JkTGlFVG4rL29VYW5MUm0xcmhFZ1hR?=
 =?utf-8?B?aW4wRkg3b2xKdUgwS09ENUhOejZ6Uk1NUUtWdFBOcUpRaTFSSW5NVk84V1J6?=
 =?utf-8?B?cGR4QUtpemRWVGRuMUlPbk5GMVpWeVRhMGlac2d6OGhmNEtSWVV1d0hLL1ZR?=
 =?utf-8?B?ZEdSYjQyWGtlamVwRmNtNXRNWXVmcTJyYlNUejlZMWZRTHlVZFA4Y0tWSDVC?=
 =?utf-8?B?bmVzSjAvYkRoS1NUVlhHMEhRb1pYN2NlMElJVm9IUlByNU8yM24wODVHWnpI?=
 =?utf-8?B?ZVVRSTVHenl6ZElsODdleWpsRXZuMUdnaGhCNFZoU3pleW9iR2NIeElZNUE1?=
 =?utf-8?B?bzhzdkt4V2FlSWZWZ0grWkhodkNobHFRNkMxcFJnbzV2cDBYaWFNRW4zLzh1?=
 =?utf-8?B?UzBDYTVaYzk0NUMzYk5hZ0JmWEM1VWs1ZlIvT2Q1MWtDUFFMVXRQK0p1Q0R1?=
 =?utf-8?B?N3lkN0lLdG0xUjFob21SSG4wUXJaRkUyVnRCSXBNaUNua25zWjVIYlFweFpH?=
 =?utf-8?B?VDZCVVN2UERINmx3T0orOEhmS3k5ZExHN051MzRuNFlrMEw2RWNRWmdJNEJs?=
 =?utf-8?B?VTV0ZW1YQmtFRHA4M2NwcE4rMTUzdEpXcDhQVWtPSHJkNWhmVmlRYVpxSjdP?=
 =?utf-8?B?SkpNM1gvK2xUQVpyU01WOTBmQ0VNNnJuZzU1Z0hNM1dwMGo2OWN6cUpqbDAw?=
 =?utf-8?B?eGZnWmxMdGFGYzgwVThJUEtITERSbU1pOW5ld2NuSWI1MHp0MER1a2JrMGp0?=
 =?utf-8?B?SlBDSEx6Ymw0MVBLVzhnVk9qelgySTJZclR0bndaS0YrUUw2aWxxWE44Qi9j?=
 =?utf-8?B?NVZnUTFKZmxEVUpoZk5ubUt0ZjYwN2VzeDh3cTFNRkVTNEcwOUttS3QyUHZy?=
 =?utf-8?B?bWllZTNieUR4Vi9TTmJqOTYzUm15dHcwbno4RUx4OFYzblhDcVZGSnBnWHpj?=
 =?utf-8?B?MUVZUE01QWFQRENBZmxHQmpkQ3Z6MXNuR29WTkpsbDJnSHdSWHBOVzVKZGFQ?=
 =?utf-8?B?ZUNqNUs5VnJLZDFwSC9nY2RscWZ4bDdZbTBVYjFtazdsRkhOc1czS2Qwcmk4?=
 =?utf-8?B?WHBFbzUyT2lLeHlxejhwZ2RFRVRCeVZqMlQ4aWl4akwxelFGak9Ed3ozMmVB?=
 =?utf-8?B?TFVSb3k4K2F1NUM3NjhNTUVqV2pkTHNEWjVIV1lWdzdBVytnNndMM3Baa3Jw?=
 =?utf-8?B?ZWFLVEd5ZXBNZWNzZE9IUnZmVWJaRUhNaVpDM1c4dllwWFNJQldZRjlqcXIv?=
 =?utf-8?B?Q09hL2c3azN5eTEvc2FiRE15SzVqYXdwOWMxWVZ5dUdwR0VsVThoS3FzYUto?=
 =?utf-8?B?cnE1cVZRVHh6c1VyWWxxcDNBRnUyaGxCZCtKOWZNQVRzWjQ1aFZ2NWI0eGQ2?=
 =?utf-8?B?OHpWSi9PajJNOXA5ZFpDYWFkRlo3WEYvWHVjTWU4WjMyYXpMVjJHMngzRWNB?=
 =?utf-8?Q?Iau3Yyse20c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBoNm9uMTNwM2x4KzUxVnF4UzJ6K2c2SDUzMUwraXJFK29XTVlQNFRxcFhV?=
 =?utf-8?B?SUJSNFhOR1RkeldCaEQ5b3NMUFZuWVdQUks1cHJkYy9sT0R6MEdjTW5rUlZK?=
 =?utf-8?B?RWxxSVQ2SExHbWNkcXNIWGFSdG40QmNOeW85QWx3VThRSm5DZ1NDcUwrNXl6?=
 =?utf-8?B?dW5VMEd6T1VPdWJqNW15ZmYxZDRGdmhCUzlpaTFKaDJOYStNMWhrTmtEaHpN?=
 =?utf-8?B?Z3pEcU1TbldFMXhOY0ZlS0M4djdnUzduQTVJQlFhbWVIY0hYdnZzeTd0WlF4?=
 =?utf-8?B?UXc3UG56TnlheloxU2hLemxFMG9DYUJobmE4cGdib0doVmsyV1lVT0NOVG4y?=
 =?utf-8?B?c2M2SzBNZFFuZXNxQ1J3bkRRTi9uSXQ5ZFI1YjJkWnpxZm9iTnlFODFUQkFI?=
 =?utf-8?B?RmNWcE9DSXNkakNsSHNHL2hQYkZpWG1UcUNNZVFWVDJKQnQvUW5zWUFaRkIv?=
 =?utf-8?B?RDVZaW1aNU8rOXNxdFRpOS9vMG8yNU9aVGtidFBuMkNIV0hOdnJXUWN0SlVR?=
 =?utf-8?B?WUR6WEtoblg1VEc5a2x4akVqMTY3cllSaFUxbTlsWmtIK25FMmh0STA4RVlw?=
 =?utf-8?B?WjEyRlBZbkVWL3ZKbnBSMUkrWE1OZWpXWWVRcm1TRFlDb3JuSS83Z2N0M0tr?=
 =?utf-8?B?a2ZoQVhrNnlXKzRyeHVHTVJpZnV2Y0FuRHBZaXlGTEpZYXh6ZU4xc3RVR1M2?=
 =?utf-8?B?TXgySlJmWHN4Y3hka0VuMVdMYzU5M2VFUjFEbXZBb2hyU01wV01jakk0REFG?=
 =?utf-8?B?dTRFLzFIT2t0MXRXMVU1S3UyU2htK2lMcUdWT1RKOUVDSHdjSXJDc2tweFUw?=
 =?utf-8?B?RkdHc3Q2cXE5VDhRN09YVHMweERERCtuUXpGalpDQ21BeUdlMXIzMWhWci9H?=
 =?utf-8?B?MEVjL2xhTmozWW9ONVB0Zk5JR0NEU3A5a0JXQXdBYmgxNE5pUEw4UnV2ejZS?=
 =?utf-8?B?ODFrVFdmVFJvVjlnMkphZFgrbHpUQmZpUnFXMWJMOXExTllqV1FUcHpZMXU3?=
 =?utf-8?B?UTFRTGVXZ2xPZ1htdFNKaVIrRHdYZ2UrSVNmeFYrR1VJajJ4c09nSmVubWEz?=
 =?utf-8?B?REU1d3BLQWFhaG1ENTFwQ1FwdSt4NGpjWjlhSlFuUGx6T2crcEw0M3R4TnlU?=
 =?utf-8?B?RkQ3YzIyM1IyaGMzdzNLcHdMYmNMbW9jZE03SG5zenhFbEhCMXJzUGNFR0t4?=
 =?utf-8?B?UjNsYS9DZTJHOFdzQW5HN09IS2NyQ3NxQnVkVStaellzc2F4TVh3eXh2YURs?=
 =?utf-8?B?aGpaKzRlb3NlMzVvZGU3cXRVWFh4M3pXbXVUeHQwZzkwSHdTTmJMWEtzZkE1?=
 =?utf-8?B?QUIvTDRpUUU2TjJNU2tSQ0lnQU16eHAwRlFMOHdwZXBrZFQyWFd4RmxKVnhR?=
 =?utf-8?B?SUhVYXR0ak5FMUVvMHRKVmRrbmZkUWNKejNRRko2WFVJSHBCRnVQN1M1RVVJ?=
 =?utf-8?B?M3ZnU1hWWDFXcFpaMjRlMnN0ZElDNGFvbUNtUlIralJSQmxmV05NdGplZVh5?=
 =?utf-8?B?MGpXMlI3YXBlOE5Pcm5RK1J0U1ZEYm1xOVV6elBMWllyVEFrRkd0Nld4YnpN?=
 =?utf-8?B?ZHBUNXlvSmxhV3NHaVFWZCt3Z3ZodjUydkJSb1NwdXZid2JtalBFNUVmTDh4?=
 =?utf-8?B?VlpnaGNNM2lYRDM2eVh4eW1RV2pYaHZoSlB5NG1nVDF4ZE9ndzUrZ3JYalNK?=
 =?utf-8?B?LzF0djRlc1EyNmdEb1Q3eXMvMUF0SmVXaVhhZVRZWmhMWkx2dWlUMDg2cTVQ?=
 =?utf-8?B?RTN6RGlyWFR1clE4WCtjeWZsSnVyN1dUb2ZJN1V4eS9POFBJZ2UvVTRtaDFj?=
 =?utf-8?B?dGs5VFJrczgwZ21UQkVNMUV0cTV6UkNRaGdOYnZMZXVvYXFEWG1wTHM3cG12?=
 =?utf-8?B?eWdxbFJuTWcwY3RoMGZnYWhpYkp3bVlUWUx0U2FtNU5PRDhJcVJ1ZUUzV3Fs?=
 =?utf-8?B?YmpQU3RRbEhySENwMnovcmE5UDZxbFlxREtpSHhGelRwWGZkS01rR0ZJR25L?=
 =?utf-8?B?djFyNUtVZDN5Zm82cENFVXh5Ym1wd3VmK291ZE05OW0vT2t4ekd5a1gvd1hR?=
 =?utf-8?B?WTVRNEJ2N1hhSGgrY2dtN2dRU1pDcGwyYmNGTCs5Tks5Qm03WjZSWnV4V1VH?=
 =?utf-8?B?V0FlaTlaRGdNcHZJWmJubllPNWlubHRHTCtaSUkxUkUzeFllZzA3eXFZU1Mw?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c5cff1-0e9b-4845-cc21-08dde9974b70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 20:36:57.3648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IK52g0LE5oe3VF9uDVM0+yAokp/cv+Ljt2QT/ON/3Cg/y+BcZzH1uZdnLH2utNvuyplmZMpiKizFWRVLZlg3t9Mr7Nlok+9297D5gcO18k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8298
X-Proofpoint-GUID: 9l8our8HqeSg4jH664_Xx5Qi2amtQSmh
X-Authority-Analysis: v=2.4 cv=GqFC+l1C c=1 sm=1 tr=0 ts=68b603eb cx=c_pps
 a=Ft05trlkDaS5pCTE1vB2kw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=-OzNHC5s5LtupwqFWvoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9l8our8HqeSg4jH664_Xx5Qi2amtQSmh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDIxNCBTYWx0ZWRfX2e9a63YTFMHc
 C1XpT4Uh1KF+NMQOaHE5sEAuuFdCnJOI1YoHvK589QppCwZz7Peb5LoKguKEI2yUqBsQknHDk00
 z06MEmPIHU5Gi84ZdRDa0nfI7weMLr4Z+y/E7gbRyzxQcFGib6PJRcIStGgoC0zli3cpPxLiinM
 tdcCWNYF8lwW+zbyzmRUq/mlXHqaY0VLG6VKbmzOwo09pNnC7mccos53pVGARjK6xTuOxo4/TIT
 wFpNvdmTf+z4oijmwentPsAGAVbrPqMmDE9OcJ477DBw4DyBdgUo+p3okIMeOSJc/ABrvS6fQl6
 0/AQ9si5iYsDTWkWmL1OUlsqzojYg+S4rFSfD2r2tA4O1xYKQwUbawR5tOMpRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_08,2025-08-28_01,2025-03-28_01
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

On 01/09/2025 16:22, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
> 
>> Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
>> (phb) object is now always set in pc_init1().
>>
>> Since phb is now guaranteed not to be NULL, Coverity reports that the if()
>> statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
>> (CID 1620557), along with the phb NULL initialiser.
> 
> We commonly use the more formal tag
> 
>    Coverity: CID 1620557
> 
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks Markus, I've just posted a v3 with this added.


ATB,

Mark.


