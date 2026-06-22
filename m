Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337CDCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcSb-0008HL-8i; Mon, 22 Jun 2026 07:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbcSY-0008Gl-Ik
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:04:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbcSW-0003tC-6g
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:04:58 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAp1jE4151192; Mon, 22 Jun 2026 04:04:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=cDM8gguHn9PrETAnJtGRq69r0EtiS+5i3WweH20uN
 RE=; b=b4YlaZFykJUZ6o6oLrLrVFDBUiOLb1BLD5inDAXAb58Pz2aw2jL28W3tV
 mE3Dedhx9767DEhZzAX3nzOkB6I9AR0cjAw4tXyfyCmQUV8HH/hvREbfnlq9bn4h
 BRhLQAgPAq1BeDsrFgEk8z1DNYNTkk074xHnLg9MTrRPZyqCWjhv2Inb/6gj1Eu2
 e8wKlOWnecH9bnJpp9n5c0GqqC5zazSYoSi8H7+SFvGcYu938k3dFDoLOiKk1iy+
 O3lRhbL/rd1OWBLUnildTnquvqQQCoAbASaIcmRJkw1UlBeEiy7Yl20Vxjfy1JgX
 1VZS9qyMuc7rF02Y31nI+PmhxwdJA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021119.outbound.protection.outlook.com [52.101.57.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewtdukck4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnX0/gXQLdqMqEcbK94V1KMwzuAfDiAZSoavOYwBxW4aJbEVU5eq6QMM162tLjYhyebw38+DtBsrYB4XZ2phatb01Mma4q7MhvNXPuO1JSw2f8M5kI9TOVfJRRtS2Q+Zgs+J6mUxbeGHGVUpQ7cvSXKMZUksqgmtkhIkZmeG3vdLt1mXFTx7fzaoqfTxX7ZOh4/rbbnuLrZH7r4V+pYgCFVgBxiIVA298s5ukhWf+ii4r4eTCN+4BNNdIkMuvlB7iARyTS5fqRXkgH2n6jlbjYM5pHuYm4SHMgPDzmpMhrgzE8O4JEo37GDrpO0PYbtKm8Z9WeGREAoIZEypAHJ34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDM8gguHn9PrETAnJtGRq69r0EtiS+5i3WweH20uNRE=;
 b=Gfqepq4i1sC1KXL2l95U3qCv39x717e/ZB5B+0dy1wAwZBolWbLXCkX4NsgQWkDZhKSRGZ5TzbI2PNln3bj3Y9OIisn+/TftlE//C9xqxwYnMsOTaP7hglh76QFv3dCWf59YIAaYBZe8dnOBL21bBqizMRFmWtjcSrcIpp5ldB5Mw80YGtH7MAbssVtgrymjKAyDNNYJB1Jc2fA9AylfIebR5Oy0GwpullHILWseP5kE7iU9yHGeuNE0EcRPg6QPA0nP+x+JXJRWngLgCRHvz1VY2qeMUzXPqZ2ASS9OEr5aVyc2abxVndSWsPTbdBzSwnW5TdzdKxiGl5O3P3o8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDM8gguHn9PrETAnJtGRq69r0EtiS+5i3WweH20uNRE=;
 b=dmc740KgOmReHAXi/W99nb0SWI7Vze7r9yiuMuVdIoI7YdvcnDWr6wgvg5ojNf5VCylMlgMkFGzn/QVMim5GoC+V76MgRxZ8RfSj/RYUs4693Rd4DO4LKbgMYWo7Rh+QRNUTNEsMuGl21aSn+Tyb0RdSfYeWP6nXnrdxJkkU9Fnlh0l2y3gPm09KHqGh9ZiUZ9xgT54Sfzc58fnO/LnJhubbgGHplTBnRaRsh18FTVoxwjc+wxd2qwyEcCjBCuq9qjDicDq6QDtyd2So25LuK1bTi6obYhL+iD+SaQ30mqWFCOLlrzai8+NRm6wgdNZ929eOE1raAyEZvWzGknGDVw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SAWPR02MB11414.namprd02.prod.outlook.com (2603:10b6:806:4c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 11:04:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:04:49 +0000
Message-ID: <4bdaa322-60ff-4d08-b714-85d48ea131b2@nutanix.com>
Date: Mon, 22 Jun 2026 12:04:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] isa-serial: acpi: declare shared IRQs for COM1/3
 and COM2/4
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
Content-Language: en-US
In-Reply-To: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:930:1b::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SAWPR02MB11414:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ebd93c-0ccf-4126-9434-08ded04e13e5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: zFEffeJHitgU0uIHWknB7i6tmNVK0l2UgigxuDSz9q2Ihoxe9F3QnaS7jeOHLTVEIVAQeX/pqwB9l+birniC9lWTII66sZ1oT9nwbUMrD9gusrZTuap54OdCcVYLDK6iH3+E9US+LeL1i3LW86y1c29ikJFZcA+4sSrcijkXNaX6wKgY7RGQPEChu4jIfD3leEjBG8IWk0SwrRvbYuw4smeAXek/mjQxS9nsDpMx+XHNns2JwQhvOaNUY+YI8HnMzJiB5MlaABxkZvY0g5PMbtPdHCaXzWjotybrzzLVFUIkhsCUiBMU/hZdto/uJi7+h1y2J/DocmAsK2zGMSUYk+OFVL0V4+JGA2qki286FDQbwCTLKNxngv8gqvHRS39MgIqgf08zDTbOSKewsXCHgaADErLEQCsl7zgXP8g3UJSwmcjrFNw+M/V/K5fjLaLU831+Y3nx5LUTUqPMYhPC+T7BcYHKBgaJASxpuDn3egjYt14dkI4rqVKwgsIEa9FRYOKrMRkPRp0vuMluBUT8k4XHZPgpuu7h03hUpUBPUGvXrSih3oZgB98bUIBqhsYFUN0T8+1a99rea39Dek5VSPQIp1Yl3erzEztT8VxF0I/IyUEhBLUjGcpMyzIPhdBkymUCYUkjbnUrVe3XLFe94vI+9h3amxOGi41wn7Di7Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1WTE9QOHUyalNYbFY4bDlDeE1HUFU1dHdNVkVpU3l6UGt1VW8vamhJaTNG?=
 =?utf-8?B?WE9BRDVCM3J1OEQ3ekhRT1FuU0cvYzRRcGxqV3VWNFNEc3YvY21EL0tBV3hH?=
 =?utf-8?B?UGJLTU1VTEUxT1pkQzZBN3VYc2V2aHV1NE1DQ01hazJrOXI5VWxHRjRIR1Bu?=
 =?utf-8?B?bmJXd3RIaTlNeWpMbXpheEltWDBtUmhVVk5oQzZnT29FNVB2NnAwWldrK25k?=
 =?utf-8?B?NkprZlJlb3VNUmhqM2I3QXgvdkIvWjhmanpheW9VSHUzVGhXeGtCODFFNVht?=
 =?utf-8?B?STZpSHVtM3JkcXdXTW4rd1dnYnJNYWVXQ0o0M2hjY3dtdGJmMmNVN2EzcmpB?=
 =?utf-8?B?bjd6QS9Vb2NkSWlOejVjSitIT2gxazlMVEZNSDhVQk16WHdxQW5XR3BKQ3lX?=
 =?utf-8?B?OG9wZzBqYnh1SnRucnNTNDdoR3ZWN01NZ3JWcTJDV3FYc29aUDdYeUtZc0k1?=
 =?utf-8?B?WG5yK2JsSEk2UVdpWWtzRjJBUStwczJXdDhlZEJjQ1V1WTFnOFVVMlB5ekVS?=
 =?utf-8?B?NU4xZnJKOE15M3FsNGdZVnJZZlB1SEY0YThYeFRHMHJad3JsWStpb05lSFRo?=
 =?utf-8?B?bW5aNzdxTTBkK3ZMZ081aTNTaFNJVHZ1NUUxSlBTZ3BENUJHakZUUUUrUzlQ?=
 =?utf-8?B?ajJQODR3VFdFMHhHQWYzSnpZbnM2bktGRVhFQnBEd1hFa292WGREV01MdjJm?=
 =?utf-8?B?amJyYUZDak1JZ0tWa1ByT0VTelBoRHNjOFhFSXVZT2ZMYm1BdE5Sa0F2M3Rn?=
 =?utf-8?B?R241b1pOUFpiOUJBenJaOVRqcXQwenNyNjk5Q0ZLT21JQkhNampxS05lQnZB?=
 =?utf-8?B?UWUxbjAwWlh3eCtDVzlSczdmSTdSVklnejl6M3ZFVlZkUkhOdE1za0gxZXlG?=
 =?utf-8?B?bFBzNE5kNUtHMFlRM29lcnNyUHYxQkI0eVNuU1d2TVVmejVQVldOd3RVUEhU?=
 =?utf-8?B?SXR2VDgyMUl6SFVPVUtCUGljZit4ZksxcExodHJ2YUVRaUlCSUtqYkFNRzFK?=
 =?utf-8?B?WkJzeGxsaU1LcWVtdnQ3MzJpbVBDUTNxUEN0bk9kZ1U0T0FVamRaTlUyY1Ax?=
 =?utf-8?B?RXE1ZDFqSFNIQXQrZXpISG93OExxRGtzVlBWcGNnVE5TMGc2LzJ2RU1CL2Mv?=
 =?utf-8?B?MTh0RDRVZytnQ1dLNVp0ak5hWW8yV1J5ZElkRGRkbkF5ZThiL2xBb29Camt6?=
 =?utf-8?B?MzdyZTVhbmlEck9KYjZTYkk1TmRINmpKNk9WYmxLZXhhTjZCUVpvZmZpUk5a?=
 =?utf-8?B?ZmpmZmpzc00zb2xPWWFvRkdlV3lMRC9XcGkrQVFsTkVjOWlJTTNQQVdVNFBF?=
 =?utf-8?B?S0JIV29HU3RjdXRUeWRmbVNuSXg5WHIrcXRKL2NoUFQzZUgxSUx4K1FkWWoz?=
 =?utf-8?B?eTZjM1FiS0RQV3YzTEZ3T3N3Zy9OOGVnTUhJRzhYeDBKL2ZMNUhrSXdxT3Jr?=
 =?utf-8?B?YUkvR0VrOWd1OGpTMitNbzlEMFVPdUxRMnBnbVpYTitDQ2FLUi9UQXRwWVBn?=
 =?utf-8?B?UzNDQXlVOGdMeml5NHJIM0xFVlNCQ25HUm1wL3NNRThxbnBjTlRWVzc4Y0JP?=
 =?utf-8?B?THFxaHJyUFR4WEtmZjFBZ2czUGNrMDRtNHVvMWlzK1ozeWZsdzNxcnNjWENN?=
 =?utf-8?B?S3BDUzNrWWxReXdyZy9ZdzRqYkRqMjBMdFdGWXFCaDRHTk1zYUNmNGx3WHc4?=
 =?utf-8?B?MUpNVEQwNlM0Z2VGeWxkaDZ0Z3MyY0s0UGpRVXR6U1JLNHFRZFZGbXppUlMr?=
 =?utf-8?B?ejJYNnpESTg1Z3lTb2w0VGZMNWRTbVVkaVNqKzd2TGQ2MnNzYXYzVEh2THVh?=
 =?utf-8?B?bSsycm1lM0NmOVN4NndGMnRSbG5QNFhEa3lWUVhkU2RmbWFUbTBMU3VLbFpo?=
 =?utf-8?B?ZUNzYzNrcHZzVUJMSmNVdmtITWUxRjRNK2R3WDNGRXhuRUxRVmhmcnF3eU5J?=
 =?utf-8?B?OTQ1dHlhTVEzcHBnL09FTld2RzZjVENVSFNmczZsM2hLYUZpZWMyMWpOWDRv?=
 =?utf-8?B?UlpjUVVHZW1TSEI5akRhOEZVTlpiMS9yZEo0bGZKVm44dC83aC8xcDhheVlO?=
 =?utf-8?B?RTBpZWlaVFFzbG9tSmlqUEw3alpweXZnQUhONG4xTCtRc3BzMFU2OG9xS3NO?=
 =?utf-8?B?cHlRVEpOSFVIUlFrRi9NRDYzS3dJai85dUVkQ253a1dTazNpZXNwdEhhL04x?=
 =?utf-8?B?N2kzeG5Qb1c2NG9HSFFWR2RXRE5DNFpLTVgxZFdtdkR0cXJVZ1BPRktNbitD?=
 =?utf-8?B?NUdyVi9WaktudUE3ZWphWVB2RlVxeHZEY0lPU1RSbUZ0bHYzSVk2TkNDckNJ?=
 =?utf-8?B?UHlTSlZ4OGZKcFY4YjZ5OVh0b1lSOHhTUG16NitMVkdXUHRESHR2L2Fkd1Rl?=
 =?utf-8?Q?gOeev6iZf3J4f8oU=3D?=
X-Exchange-RoutingPolicyChecked: JcRTq7YysH3fYsFRA/94QcVYqj3VLktuYI9D7LFoBmBOaidBJv8ROvdq10d/TUuA/n7uNJfp6LLZbifRLsMNSaGOjz+E69qkxy5QYglX4RQb64X9WmburXGhslJ61RYJCnWrgCtU6jBDgkLOutN+lDLdE2B7tc2gnkWqGoluzLtOI1fxjqBsDAk/5wjrA3+73VZj+84r8MAJx9Zu4isIs+vhNN35ziErIU2g/2jhuFtFHFJzeemuTdIM0m0uOHGrp8RuA2wW53bNw1Ci2vLmO5db2R0lSJU1sRf6WJ7m6GMlq3uBOK1y0UT2TzImIMcaVzDNWpjuh1kXodOAYwT8Kw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ebd93c-0ccf-4126-9434-08ded04e13e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:04:49.7835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QI6QCZYxyYXVnwV1bfjv7lWKOtLHYcX9FMp3043t3DtiHFofdUVywEyptWGSmMEVC5e9jRlgEou1KZ6tvZ9XoacSuQ570u4cwb137hIB2ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB11414
X-Proofpoint-GUID: SPiXi25l8tQQSAwXLIdqJuqw7XNlQXob
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEwOSBTYWx0ZWRfX5Lt60dsR3/n8
 rakdDMewG3jy0hG/33BAzqeIViGTRTyrDirIxNEiXj0nEG3cR4FK9USYYwNaysLBxfvDgkFbebc
 PPltZR00k6eHfvwwtv+6YxB2PdEgt3w=
X-Proofpoint-ORIG-GUID: SPiXi25l8tQQSAwXLIdqJuqw7XNlQXob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEwOSBTYWx0ZWRfXwKZJE2V3wfmf
 WZ17CG75vT3UTQ0lt9Cc3ge84/vXY9gUb5Qr5/L4pnVgcieU+vbei3v9csKV+iu8yxFNOTHt1Jh
 z7yPEAyn8FxprEyhJDt1ArY4yNivgC4sRJuCCL1HDEMdtkxymOZ8Q7K1jjzxRNQVevqySZjsYcV
 vZNJp3NKrexD7AbKmSk2vc/932fUqoW2UNIMl7WkytEV49RzbqYsYQ86gNDSlWUvI/jU0/mlQdp
 del7A2CVor951Y855Y6Vl0+TIf/E0KT6wdEIyP6rxHfzbTXJryul0c+WvbFR/g60StDBFdGjnxw
 kh+gKA0xmeDl0nNixVmoh/g43tTzF/AcLG6s73y1CBas05CuZjrflZM4UOiIKOfGCTCObaxpcX6
 N/va4Fn2aws34zMPhULUPsjRuyTTUh67BgQB0YS487KnsyO//DGyc5A02zHkrkogO59EenxN3Bo
 icyt50E3C9kV3EqNKVA==
X-Authority-Analysis: v=2.4 cv=VpITxe2n c=1 sm=1 tr=0 ts=6a3916d3 cx=c_pps
 a=iRxRSAF+HohKiaZghI2QEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=z5FNgv0FQh-jA6iuoq4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 15/05/2026 16:05, Mark Cave-Ayland wrote:

> From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
> 3.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
> Descriptor is used then the interrupt is considered to be high true, edge
> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
> an IRQ then if more than 2 serial ports are added, Windows indicates a
> conflict in Device Manager and these combinations cannot be used together.
> 
> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
> ISA serial IRQ is low true, level sensitive and shareable. This enables all 4
> legacy serial ports to be used in Windows without conflict.
> 
> Tested on Windows 8.1 and Windows 11 with 4 instances of -serial on the command
> line and copying data simultaneously across serial ports COM1/3 and COM2/4:
> 
>    ./build/qemu-system-x86_64 \
>      -accel kvm \
>      -M q35,hpet=off \
>      -m 4G \
>      -cpu host \
>      -drive file=win81.iso,format=raw,if=ide,bus=2,unit=0,media=cdrom \
>      -drive file=win81.qcow2,format=qcow2,if=ide,bus=0,unit=0 \
>      -device VGA \
>      -serial tcp::4001,server=on,wait=off \
>      -serial tcp::4002,server=on,wait=off \
>      -serial tcp::4003,server=on,wait=off \
>      -serial tcp::4004,server=on,wait=off
> 
> Note that with this series applied, if extra ISA serial ports are added to an
> existing VM then it is necessary to go to Device Manager, select "Add legacy
> hardware" from the "Action" menu, and then reboot the VM for the serial ports
> to be detected correctly without Device Manager indicating a conflict.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> v4
> - Rebase onto master
> - Redefine IRQ as Active-Low-Level-Triggered as otherwise Windows 8.1 will detect the
>    serial ports but mark them as having a resource conflict. Retested again on both
>    Windows 8.1 and Windows 11
> - Add R-b and A-b tags from Ani and Igor
> 
> v3
> - Rebase onto master
> - Define IRQ as Active-High-Edge-Triggered (as seen by the PIC) to ensure compliance
>    with the ACPI specification section 6.4.2.1.
> 
> v2
> - Remove _PRS changes (including AML build changes that are no longer required)
>    and compatibility property as suggested by Igor
> 
> 
> Mark Cave-Ayland (4):
>    hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ
>      descriptor
>    tests/acpi: allow DSDT acpi table changes
>    hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
>    tests: data: update x86 ACPI tables
> 
>   include/hw/acpi/aml-build.h                   |   2 ++
>   hw/acpi/aml-build-stub.c                      |   6 ++++
>   hw/acpi/aml-build.c                           |  27 ++++++++++++++++++
>   hw/char/serial-isa.c                          |   3 +-
>   tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
>   tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
>   tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
>   tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
>   tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
>   tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
>   tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
>   tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
>   tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
>   tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
>   tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
>   tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
>   tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
>   tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
>   tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
>   tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
>   tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
>   tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
>   tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
>   tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
>   tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
>   .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
>   .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
>   tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
>   tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
>   tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
>   tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
>   tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
>   tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
>   tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
>   tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
>   tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
>   tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
>   tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
>   tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
>   tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
>   tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
>   tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
>   tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
>   tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
>   tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
>   tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
>   tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
>   tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
>   tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
>   tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
>   tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
>   51 files changed, 37 insertions(+), 1 deletion(-)

Ping? Is there anything else required for this patch before it can be 
merged?


ATB,

Mark.


