Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58213CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGx66-0007b3-Bk; Wed, 14 Oct 2026 07:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGx65-0007aV-8K
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:24:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGx63-0005g0-IG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:24:37 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E7wOr93014631; Wed, 14 Oct 2026 04:24:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5Y42nFX1SuoOHfoLk9XCJ3MgIlx+bFXAwAy9V4CsU
 ow=; b=lqhwuCkK6/Vzv9Y57U+pnEB09yphxefHBQGnBnG2UYU5ZO/Z2BPAspADP
 EU1jeE8c+feeuYFPU8Tf+FZ52B7FTgWUyO8wGwxYsQGVq0NfRj0ypPZ6j3zkQJev
 opcQz7rr28B5b+vzkiZ4oop2vD0yyu9DSHh3mL0E8F2GzsJe4porCIksdf69lZrf
 ABYTpZ1800J7RCnCMvT9p0QYL4zz7+mGQjaSLsVLve2HnrQkIRPpIot30DqdcbiT
 chp3eU1ZTb9n4gaPUZrJRRm2SZ9FJ1r8Ja7mBh1FYLZjtYh39dNCyOdVGnDFhfIi
 yJc/YIxq+iwH5IE3WhX22mUcrax3w==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020143.outbound.protection.outlook.com [52.101.46.143])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9pvvtrww-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 04:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCnQJtU4oJx/P6P5towLLsFKmKBSCv0qErSwC+FmP54QmB+m6L37KUJJ1zEwipnRrhDh5epxPPJ1dxQM7bs/Knw5mwJqmPpQjC2xhctd2ZHjqgQrCrCpWezMK/K0mrpAdAzUDbOLIorrrq7Vf/GwfGG2N0zWvRHC91c4auaEHYHaIxzPOSNj11h5yGhG21+hpRnU8ccPulHt4MdCG/ZK/ey6mMs7bx/oINEQBX0gOnkPQgQTuqCtXtAofn5KefG8/CXXusU3XDHicS6qaT6R8wfOMdjGSXhzgYnyVrU+7vuRcOho2/F0YdOjt7WmD85w2P6t0xK/rPO5vz+kVAdCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y42nFX1SuoOHfoLk9XCJ3MgIlx+bFXAwAy9V4CsUow=;
 b=qLRB5O2r9K7k/bn/4rk5JUozlVHaBZ7BwY29Nx0Tl8zQqdogjE0mG4kxJ33SS49o6290H9A6ergXv/4WWyBRaDlTE/LuziB+j0e56WYfw4nCUCNf6hWwa0PHIplrFqIGPtVymOh5/qvFguYmGQwaF5Uuqkth6MRGwMwo8XwmoFuX8jULMZIGD6Gdmfdt6lhmcTwD6CYr0f4uydjxfq+ZOueZQHzNi6OSKi1qljBZ7+XObHj1JQcX0u0+AMd/g8uDA1dx3AHvWJbbL5GVTrPmqG4eNTJDq1mmp9ltXe9ScCP8+FwqRya69JFzZSyI7aVCU3p15+gNwNDJXqRiuNRp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y42nFX1SuoOHfoLk9XCJ3MgIlx+bFXAwAy9V4CsUow=;
 b=XBN1le++cY/jyeNoToMQM5GYc9jMUTg0tOqrEQMCjDTH4e0Ir120VWqYq3LA97DaunKlT+Sqhg6GDKupujSclEmwp2TBGeT+zsYh6SCnZ71Nz1YwFe9DMpkEZqlhTEfAdCdT0G/XaWNvZr7FBbSSuZkZoetFIYiLLGJV8FKtMdILnFxxD1/Er/Fj13UAmkWADphrgG+TPNf0rAvRSjsgJjivFl645a2+lIaAdnmu4JNGU2aMD2LvDPcNYZPzPVIL0GlnwwN6mGCSAqfZ84y/BMGlkzcSJkebbMHQmVvL54Zbe0du6SWFVw4ihgPjfdJMDVyd0Vjs39K3ZQmkVKS9Sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA2PR02MB7595.namprd02.prod.outlook.com (2603:10b6:806:146::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 11:24:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 11:24:27 +0000
Message-ID: <dfb75bf5-600a-4d0f-865a-de4d9829ea64@nutanix.com>
Date: Wed, 14 Oct 2026 12:24:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] i8259_common.c: remove static irq_count and
 irq_level variables
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-22-mark.caveayland@nutanix.com>
 <CAFEAcA9vm7004bytZqYwXCNj_+VNy1RzKMqG3TDnJkswpNhLUg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA9vm7004bytZqYwXCNj_+VNy1RzKMqG3TDnJkswpNhLUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA2PR02MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd87a39-f822-43d3-166b-08df29e5b4f8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: uaHJyyUXSUfZlFH7aNbf2LjuExN6gAtXrsj2CP9xkNUlwtCyPKkTxUftkj9d4rc5Y4qQXK4pFqawet/ibsN+kEOMJARw2OFThjHeq3Wkhxmn3KEhkV9t2iIFHQpNhXdAKGAQoDh5dPSM8ev9bHOWoHeDdXzShatU3KF9LaYPH8MwpWaDVYf7E/eUFbjYZ8/8Z9BX+oCp3JiuqYEP+7SMZeo3udo61UbyzjAatrObMLELFT4ickHeJyO8z+Rt9WC7gFezJjTZyuxAmv1ViKf08bfMBDU7JIW6yrCBo2xTJ8PMobnQwkqU5qxTk5rYyCqiK2u2kZdZA96lvc2SRDlzwT39cE5PbK4K8Vx66eadVHbehtq+kdnEgawFHCydoRuzovLQ7RRmh9Is79b3hTfHO2FpBXPx6+f25rJNG7XcdehiwZJp6PyFnU2hjhGGH3oO+Iii/AZufx75TlSbZzYzHcAGc/iyY1yuEFyUGt+5V7vbM3qrF/qO8B7A8bFjejWa5jcyXQCFFJSsrWmcoTj6/Q+Fw3D9tX31Dnqo2p69BSE5ni4+DVERw3QUxXGQJWkMDAXR6z08UtadctS9jN/4lenO6w5bU6KCGOj7ERAkQp9ovvmtmnjj+f+niJdtBrJt/ix2BFAy3JqHyeslweUjeR8EXxT1KMahcw/n8aXKNMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNQZmxYTDlic0JKL1NFVE5WWW1NbERNQXk0MGlRMnpRN1ppcE1pMzgydVBi?=
 =?utf-8?B?cVBXcWxNY2RrcDhTUlM0bkVvMVhWdTJ5WXhkVFNGaklDcnRJeGo5VHh6bER0?=
 =?utf-8?B?U2czN0NyWmMvMmtWTmUrU0NpNFJxUThEM0N4bi8zT1hGVFJ0aGRmR3Nia3E4?=
 =?utf-8?B?bThtcFl1TzJlcWV5eGx5UU1UUlpyaFhncXBZTnBjSDV0bWNWUTZ1dEN5OXI0?=
 =?utf-8?B?N1dQejBQRDNyZklnSjNidzBDZTBYKzZYY3g4L1lSdEk2MDdHa0FyR0JEdnB0?=
 =?utf-8?B?MHVwb3BoMllqYVRKc2NQRjFmeFJWMCszeXRKTnpTbThaZ2VIbEtmMTUvMy8r?=
 =?utf-8?B?M3dQU3daNzVWaU1ZQ3pEeVAxd0NYVjFlamxxR3VCNjBQVGlpMmkzdEsrRUJJ?=
 =?utf-8?B?VThCRUhIcEJORVdJMldaMWZuQlNXTEs2VFAwc1dnMjlORG9HR3YxaXMwbTNS?=
 =?utf-8?B?akI5RVlwZkRwUDBqSURRM3VzMVVpeC84ZGs2TVNXNEFQcHU4Rk9CRkdhNld4?=
 =?utf-8?B?SDUyTnNjdTlhdmk4TzJWSGhCeXlNZjlWSms3TzBNSWZPZ0Y2RHVNZkRQL21Q?=
 =?utf-8?B?YjFiN3lZWXFBMWplVGwzcW9KK2Ird0FpelQybUp0b1gvOEY2WnBjZGdPQnVF?=
 =?utf-8?B?RzB1QmpCYlpzYnBxMGpFMVVnNXl6NWdCd1RvQTY5emp1TGpPVndTQzlwTHRh?=
 =?utf-8?B?cXFvOERaMTc2M2lqSDR1VDNWTEkwT1B6VTAvZm1tVlQwMzB2cVA2QzJBSGJp?=
 =?utf-8?B?RGRCRnJUelVkWXp1cEZtaEFIZ3JvSk5HOXRKcFlaQmkzUnMvTDRxanQwWW1G?=
 =?utf-8?B?b2tXcHc1TXdCaTlTVCtVejBFL0d6YksvWmFNZHhxbVI1S1FhZEFyWjZWTkJP?=
 =?utf-8?B?aXdCSWo4MmxHcU4xVnkwb3FSdkc2WDRlcExhTXZ0MmVGSUtZcWczZGtIMFlz?=
 =?utf-8?B?UkF6NjhSTzR2UldzSlpQdVV5Q1JVZFlOQ3RScjJTdkIzWXRIVllBd21NK2JJ?=
 =?utf-8?B?ZENBcGFvbG9Fa3dKVDBLMnk4ZTZzT2libGkxdytaa1ptUTVuajF6RXJya1RH?=
 =?utf-8?B?djBDMWgrdGNldExqNGFrZFFTUStwRGErbU1xc3JDQ0svVW5XeFR0eFFGTm8y?=
 =?utf-8?B?YThyUjl2V2NYSDZEdk9rd2xMaFNuOHRlMUZxaE1wem4ybTFpbzVNVW1jcDRM?=
 =?utf-8?B?Zk5BOE1IZHlFRThROFNRVUlrbWVOMW1CR3JUcFhmeXRWSkFhYzFCcHpSeFJT?=
 =?utf-8?B?MXVhQzUyYzdhZVJwQUNDcFFPbHNHbHhLdDhYSVdMZTlSNzBrcEVyOW9oOGRF?=
 =?utf-8?B?c2JkQ09nZnBDeSt3dXdOK0t4NWJLMzlWVDlZZGNNV1ZUZ3pQWnUvRHlrOHpJ?=
 =?utf-8?B?VEoyZHl4ZC91ZmU4RmtzaHlmbzdPL216WU5YSm1TSDN5Um1Rc1ZpNktlMUdZ?=
 =?utf-8?B?UmFJdXRhNUxsL0JGckVDekw1RUJITHFoU0tiMGJBSUNzeFRLVnRYT1lRSU95?=
 =?utf-8?B?bHlRNzgzKyt1TG9vekxxK2x5MkxVVTYzVXpPOUg2MndhRE44Zlg1dlk2MEMr?=
 =?utf-8?B?TldKVkRHczhDQ1NMQ3NReHl5alhIYnZVRkwrUkc1cHdjd1FjUVQvb041MTho?=
 =?utf-8?B?ZTlWZXluZ1Z5MWYwNzV0WXM5bk9vVjdUVFlBQnNNbmZWOWFYdWxYRk5NV05h?=
 =?utf-8?B?a09YU2xvTDJsUTNCVkJyQWFCVEhhRkhpbkFBR1J3cVBUV2ZDSWttNzdhamdH?=
 =?utf-8?B?c3JnT3dYamk4Q0JkWTFFTm1ZS0pPc2VCdWZTVDFmWWQ5SVREQ09neVdEUm1l?=
 =?utf-8?B?Vjd3M1A5cGIySjMxeFQxdUlsLytGeXh3aHkxK3BseHBBL1pwK09ZNllyakxZ?=
 =?utf-8?B?anluSDN5Z0xOdExvTzZmWkd6RUFZYzdBVXpHUzUvWVkvL25tV2V3NmZmNTV3?=
 =?utf-8?B?TUk2WDd5cGlrMWNLUm1oWUsxN2EvU1AxRGpIaE9TVDNtaHd2Ujlrejhaa3Nu?=
 =?utf-8?B?ZDI1YldqRHVrL0MyT09kYU9EdzZFek5xRnpDejU5L2NrUUhiT2FjeTJ2TzNJ?=
 =?utf-8?B?ZUhUcFBlSEpSRGplWkFuLy96TkIyeXpmc2puNzZPMTVsZ2E3a1VEa3hnVXRv?=
 =?utf-8?B?a0VWRlozYm9saWlqT1FCSjJIR1JJUlgwSENyalVSbkdVQ3FHQ0JTc3p6Vzc3?=
 =?utf-8?B?MWlDUEFuSGhzMjFjbnI5c1oxSUZzVm8rVzZsRERpcnhLQnFZK0VqQVFQNDdU?=
 =?utf-8?B?cmErYlNpdUFzS3BtUUZSWmRYZmlrSkFWM0hlSDl2TXMvSWhGQkU3US8vTWsx?=
 =?utf-8?B?Y0VnNzRGK3RNRzZxQ1g3OEFEbTAwNEJ3eTJLZWNHRDJrQysreHV4dlhSV1px?=
 =?utf-8?Q?Si87uoJaOpcPSv2E=3D?=
X-Exchange-RoutingPolicyChecked: yPWX5CL9CYlPg2jIIJoEQmSIkPg0EQTeLPep03EZ2rQNO2eXxbrXYmQR87lKJ0KTHIctEixBdW1h7N1wWE7V2nXUfjra8QU0xBz5sMZ5EDZ4lTmQ8nyOGvDVYKIZQTimYBuGOqWYKm1YH0CTYbsIE/fKCr2BrvhQY3t8Ch675nLGc5lGWZHB0Sah/5FVNJE8a0Nex2GUrbiYb8yZIY33FFefMmObvAR7gAnD/YRlt29iCKWzh2HFSd2NaHqNCLZnvqkfNwlySVRd+RtTitXnw9PFX5cEeUO7JOfsW2fZjs4Hk/iw8viuBPvVgi9gHhQJL2cUTfaWth9GesqxVS4+Rg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd87a39-f822-43d3-166b-08df29e5b4f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:24:27.2679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyi9viHEsH5h8QkvCq1evxOPmMVLaqkwXu6qn4UsrNKB+N0y83WSC/nQWfhg9l7hZQhRfv2Ff8tVhDUwpo7FaIK9SC2yQOBAwm3WRYsO7LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7595
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfX8nFt4J/MhYLs
 YD9l8Gm+qdV466ZG33U6LTNLI+9ozj7Txs7443tL2ZwjWo6ezcKuzOL4fvajkUkp//PW4p1L4Ee
 kmGLnCR0OZ7s8RhiDJe4joVpUaQxcaY=
X-Authority-Analysis: v=2.4 cv=dfgVTnXe c=1 sm=1 tr=0 ts=6acf666d cx=c_pps
 a=XSy6xVanZX0hR9uvxkBJyg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=YTpg2wbwm77mjifCQ_kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Qoz3gkV64PytRdUnL2AFpZViDOtsa9C1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfXyMcvyY9JuAwB
 FcmojvORGZpXLDjPN1kHG61ENMKb4fIYEUrj5YCSXGkYUy8oKeLgo6rNeDofSGUPXcErhUcQf5h
 UsHFXwvkMgHTyxIgtLro4clcv7C8Q07DLTv/ZnlrcZuchRTOLGghvGbcscFyVNyFesvph6jYFO3
 lFM2p9CnPx9fGMQCUKFRnxglSPgYZ5AKZUNm9GeHMuC1toENKuvaCgTZuHcgzc8Pxe2pHi/FIuC
 J9NV30dBltlyuRMy2N3wHIGgTx9IpR3TvjyK2cvQqCb4JWuIv2dGgVP4yB8NkgE9DywmUkmsMfI
 4sLq7jR9QAgZs2h/sDJAQv3ggtveZh5m5xxXbcgDfsYjzCLAYinD2dJjtipHBSsL9M2Uvn1emHm
 +cDTpIRt+Cx9hWYX9uZiPOwduYZb4fFmRWBAPO6jZvwjz7TE9JKEzsUw1iEbchGxzsKFYgvKkBi
 mw7ObwTHdH+NdZp1F4w==
X-Proofpoint-GUID: Qoz3gkV64PytRdUnL2AFpZViDOtsa9C1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 13/10/2026 17:29, Peter Maydell wrote:

> On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> Adjust the parameters to i8259_stat_update_irq() to allow passing in pointers
>> to the irq_count and irq_level arrays, and then move the arrays into the
>> corresponding i8259 PIC and KVM PIC devices.
>>
>> Doing this allows the statistics capture logic in i8259_set_irq() that handles
>> incoming cascading interrupts to be removed.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
>> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
>> index 421c9279cd..ca661afc02 100644
>> --- a/hw/i386/kvm/i8259.c
>> +++ b/hw/i386/kvm/i8259.c
>> @@ -30,6 +30,9 @@ struct KVMI8259PICState {
>>
>>       ISABus *isabus;
>>       I8259CommonState i8259[2];
>> +
>> +    int irq_level[ISA_NUM_IRQS];
>> +    uint64_t irq_count[ISA_NUM_IRQS];
>>   };
> 
> 
>> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
>> index 3f10777036..ac43995ce4 100644
>> --- a/hw/intc/i8259.c
>> +++ b/hw/intc/i8259.c
>> @@ -49,14 +49,16 @@ struct I8259PICState {
>>       ISABus *isabus;
>>       IRQState i8259_primary_out_irq;
>>       I8259CommonState i8259[2];
>> +
>> +    int irq_level[ISA_NUM_IRQS];
>> +    uint64_t irq_count[ISA_NUM_IRQS];
>> +#ifdef DEBUG_IRQ_LATENCY
>> +    int64_t irq_time[ISA_NUM_IRQS];
>> +#endif
>>   };
> 
> Would it make sense for these two types to have a common base
> class (where the stats stuff could then live)? AIUI they're
> both intending to provide the same interface ("pair of i8259
> devices cascaded together in the way that x86 does it").
I did consider this in development since it would avoid the duplication 
here (and potentially in both realize() methods), but wasn't sure the 
extra complexity of the object hierarchy was worth it.

However since you've also raised the idea, I'll have a look at this and 
add it to v2 if it looks good.


ATB,

Mark.


