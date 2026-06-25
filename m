Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90E9CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wci32-0004xn-C4; Thu, 25 Jun 2026 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wci31-0004xB-C8; Thu, 25 Jun 2026 07:15:07 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wci2z-0004PE-4J; Thu, 25 Jun 2026 07:15:07 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3casT4140274; Thu, 25 Jun 2026 04:14:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VBQ1dy9UjQcM6ulya/8r2G3STuv5651OXdwpje+NM
 5Y=; b=CGT4Za+jC37en1Qx790z2xhjO61lXLixnbZdM4WvObnyWaEebr4Ggeu5M
 DsU5y3v/vtaKQ+eui/XCrCxDOxKqZETXhRc7MeA18RaTh4l92V6JVb4b6nKRtTzK
 UYRpkGSyiPjdu4GK/xCbKA3PGlLdvrcezQZkETobaYiyA0goinQnRi78prxlAwQZ
 CH3BI4aAVt77Aiku6A+Z4ejw5FsYBnTcNB0QQKrcxsKhKuMrBt8OECwC1Y5Cu9kl
 RkKwzo82rjNrkTxBiNSrCG12rcUFiCFZoYU7steNxXyGlkHGDreL86V16JwxyP8J
 rJLptm9bo8jk30WUi6LwBcgmhqshQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021120.outbound.protection.outlook.com [40.107.208.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f00eymk13-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 04:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgHWhUqW1w9ivW4kJH/Q84JUarP3MIYggyQVGLPQQSIKKJVbKgXN1qmX23l62I2cP4wjdliI4Ht708mgN/mp/WpaR6CLKDk2ianVso+hmsP0gYo6NKbyBmWU88fS95LIxW43mH4IcUEQwfekrwF11S2lpTflMMWLlpoycqQA9z5hRHkbKzk+lYm4ytSJdY2VSjWEHhihaJDzoIU+pCFpNSl88yvMTC5W7ncR/K5V2RhHcqSUg/tDSbxOzPRqAaWycUCR9Wbcs17/AoVr0AZoCx81mxfLWQ7RnCYljzXBIQD7t0K3s/TkCn+iBxJNRVVVLPj27AiI2pVMQJhlh+S4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBQ1dy9UjQcM6ulya/8r2G3STuv5651OXdwpje+NM5Y=;
 b=L3YTlC0SDhb0D9eSELBvyOXQq0hVPOZMUDE4hXUe6Zu/O02deKL/2AlOEYpSdm5/kdVnBJjiE9vyinPJG1F68rbRZE4RphkvlKIF7vrO/ADaHgFWHrxUqmPG2wsV0Ao9of69FR/x0A+SJ9ZUdV26d6WFmW5KRo+0CzmlKllrVeFRwAE8IeAQqX175q4m00ZAvf6dJvFJnoe9VV3EKc+MCD/4cyaTla62b6PeS02cny+1/Ow2WpfDZQQW/MjGcGsPTVzJqR0UM2+m9iL1GLd5y+9rc5SxilGggPRi2kcnhhlgd5+HecxS5dRJ3itnzyX16vNlEbfin1KBEfK0tcSfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBQ1dy9UjQcM6ulya/8r2G3STuv5651OXdwpje+NM5Y=;
 b=gQD3ydhatiyQEZRzL0w7tEt7GISfWVy9wJYOh+NW42jgb4e3I4xnSVd2ZTlee1O7BdU/sJONbqxAidTKNoHhdox2gTYwU3XK23QQzSd4PgWgxMZ56TlDA5I5XpfYd1b65TBunBYXS2N2tqDNBD+lhzhM1uvR6cGDj0oJ0D1vUJCUz3j4ZR+g6y11/EgaRQmn/DbXDHmEFt8cRDdyI+A5x6WK1VOAY9J9zgAAQ1OsFmy6rL76qMQg9rvAUuFIHDLiV2RHalEoMTgNtfuwIEd3ygDn7k1GvCc03FKgNmEPULWUR3VtUkFn86lefXXJLAVVnpiolVQ3wkiBT6+LdSvgjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7869.namprd02.prod.outlook.com (2603:10b6:408:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 11:14:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 11:14:55 +0000
Message-ID: <74971589-650d-44cf-bf85-3c0a91a84d8f@nutanix.com>
Date: Thu, 25 Jun 2026 12:14:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object
 props to class props
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: alistair@alistair23.me, peter.maydell@linaro.org, kfting@nuvoton.com,
 wuhaotsh@google.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260624153322.1470576-1-mark.caveayland@nutanix.com>
 <20260624153322.1470576-3-mark.caveayland@nutanix.com>
 <ajwOCBoTqZWJ2lqD@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <ajwOCBoTqZWJ2lqD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:930:cc::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 017c0aa1-1888-41bf-d3f4-08ded2aafc8b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: mpewJTuua8eR2Ewt5uHjtt8lrI/WUs6a1eLV+k+Zgc77XdJ2nRePDOgw9aAlyHrv0AtpWnslEF9xz4gXZRGZsLOdWtE48ZYDix5ZbFi569w1VxjUJzrH7b55dUZyKw5WlKq9keehcnNwUBx30CacuUx37NxNYYmtPS3ly9MbePaIIrlMuPuN1/bxrQqamsgMJbYctiyA2k4NHGraLhDeH+Syu+25IT0YiUkpOnhceVLqNtpquE0sN8dqxHoVkFi1YckHNZr1Mt9LfOyr+svTkZ+XO8wi+MVxI0f4UW5givPaIekf/OfPYJ62DcjaVHaOQ5GQlX44UrxyZHQiE4ZAmNUXjErlVKw2uo9un6aDRdD/AJI69Pjru3H0Glit292UXPdniLBavx+chQOaO0c5IIn6rfCdjIHno9R+i1I16ayW9YSQeaYusbQdPUcyhK6Rs03djzu8qxHv+DrSUOQMogPUpuDkRAFQH8o3QsJqZS+5FWZDDfl8VjqSjdTxt16c0rbwxb6oFqZaEgEwkt9kMp11jPYNOh1YcNazFUGxQit6oy6be+8uSDkmhATiIDVXiMwoGxPmx148Y4Cc70WOF/0LHcMKTOqO0Fb1JC/evUEY2U5D8yMfFpo54IP4XZT6WWUT1eTNSu55EU2eeOW5ybQELDvsAAktOJBYSAHqckQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZCU0drWS81bjdtOHJaRnpERDJmYmNUd3hYdE85aUpFWjBKZ1FkYWtLa2FU?=
 =?utf-8?B?a0dwMkNoTHFyY2NVdTdCTVpvQjlJYS9JcEZwVE56Z1hMNHh5VDhpOUhlQk5r?=
 =?utf-8?B?d1MweTBhNTJGSGdzRm1GVW9lS0YwUlBXdnFzL3FGMmF3MkJxTmpMMWRraWQr?=
 =?utf-8?B?R0tMbDE1QzFmUjU2WWxIOVVRZVU1bENJZVFZanpvWVd5dW42ZVFmS3JTc3JB?=
 =?utf-8?B?TzA0ZWVKQ3VPZktiTEUra293M09kUTY3UmszNGYydVFPN2tYNjQvd3lNVnhz?=
 =?utf-8?B?cmMzRUM2c1djNWdNNHk5SVZ3aTJmT3VyM2xCNFZOL3dNb2k2RUFYVmgrdDRz?=
 =?utf-8?B?dVJpQ2xvc0UwaFh1TEFrV1g0QXZsVXFhQ3VpUld3WlJ2dEp2Y3FEN0dEb2JW?=
 =?utf-8?B?M2NvUEQycC9BdklmVERjdzRkb3R2bis5T3FCMDFROW5xcHVhMmJUbm9HVUln?=
 =?utf-8?B?eEJmUGxLNUpFMVRMemYvZFEzM3pCQWlXajh0aDJDRXovbjJYaC9CWWxZSUEw?=
 =?utf-8?B?QmNvLzFOZTlGVzJPWWRaR2JBcWMvTEcweEJQU2xUSkFQU3BQUlMwQ2dnOWJ5?=
 =?utf-8?B?QjJWWXMrdER6VU12VE5CZzlnTzQ4OHJtR2NteitFbk5NYndFTTk3cXg0TGJV?=
 =?utf-8?B?c3UzVVZhM3NlUjdkcG82U25CQmVKbFY0R0grUjY0Q0JvK2drNzJqMTJxZkF5?=
 =?utf-8?B?ZEQ5amxPRmdUSFo0TDlzOUhLT2IrYlM1TU9QeEkxVTY4RXNycTRGZ3FBemdZ?=
 =?utf-8?B?OEJkbGtOTXdORzBMUXNhNlN5NnFyRHBxUG1MdERYTS9UZzUrY2NqaHN4eWxR?=
 =?utf-8?B?VkFSdDcyZWVBdCtiV0RUa05pdUNDWG9EcDJJVXNoOGxmOWdwbGRRbG5jYlZv?=
 =?utf-8?B?ZEQ5MHJuN1RlS243L3lXRkxMcGUreEY5N0VNY0h2Mm44NldmRjFjSnVLQ01u?=
 =?utf-8?B?VE5OWGx2ajl2SGVsRkxKVjZ6RlB6Y0NpYWUyT0t6bmd1N0JXUTY1c1BYMVBX?=
 =?utf-8?B?dmNhM3Z4RjRiQTJEZzNNdE5lekJ2YmlKT0QyMGtaVnhnYjZYZjRLNnVLbXR6?=
 =?utf-8?B?OFRxK2dUZG80L2oramVmM2lMRHFQZFF5YS94bVRPUm00M1M3VUU2eFFDOWE5?=
 =?utf-8?B?REpxMmN3WTZ5Z2FsTnJObnhlTjV5VmhxRm5NOXBFT3A2YWhDZUpxTFcwYldK?=
 =?utf-8?B?Smk5Z2ZrY3IvOGpzMENERUZZNE5Pelc3Z0tpMThvbTMxU2VGekFxTUJDRVk3?=
 =?utf-8?B?c3BmUlpSZ1MzdmlGVXQxRlVKLzhlZVlFQVpOeC8wd2NYU09nNjQxZmd6TmlQ?=
 =?utf-8?B?YzgyY2tkUkIwdlM1LzE1eUsvNUtwMWlpMXQ5WXF2UUhsWGY0NXJrTDhlcGVo?=
 =?utf-8?B?WDhDSkNJcUd4UzJCTWxrN3hmUHdjYnlvSzJyb3g5YTErNXhCMGVpWklONFA3?=
 =?utf-8?B?R1ZNU1FRS0F0Q2d4dVJVeUJjaHA3b3BFbjZPUFl6VzMwcjRxVzdPNVcxSGJh?=
 =?utf-8?B?eWRIZi9jc0pVS2pxUXpGYS8rWndlQ2M0bkFmQVUwTXRiSnBKRUJYbG9HaXIy?=
 =?utf-8?B?R2lpRzE4c2gvd2RqS3pYUjBJcWNlK1ExQnRSdEljUUIyZDNPTHhGZ2Zyc2xR?=
 =?utf-8?B?V05Ub1FDQzdPOFpSaEwrOFJwMDBqMUlvS080RFBxSHY0YlkzYzNuQUhlbWgv?=
 =?utf-8?B?bEpjb3dwR2VQVGs5ZmFMdnphR1VGYk43NVE0dzNFSmlwM3lNVGxmWXoxVWFQ?=
 =?utf-8?B?aE9LVHlFUjE0cEIxVnJOb0tUYVhsVCtZRUZnR1NDWEJJNzZWSXNVMlZlVmhr?=
 =?utf-8?B?K2VaV2ZOVGlXb1BhRDJJZW52bnR5bzg5ZWlGYnc2UUpjbm5YazdBMXFHSXE5?=
 =?utf-8?B?ZTRLZHlsWGcrZU80eXJQSWhYaWtoVVM0c29CWEpCWWg1OWw4Nm9xaFhQejha?=
 =?utf-8?B?dFE5MU9lY2IzSUY3bGZYaUJBd2J1TE1OUVlqSWFZaDlmMzA2SmV3RlB2VmpF?=
 =?utf-8?B?UkVWUkZySnhhUng5RHlWT3IrWHI3SlFia2txaU91azhiK1JIMFF5UnI1cGNi?=
 =?utf-8?B?MWtyTkovWGxpRjh5VVNFemM5cTVsZFRoTVZtOEkxZFFrWEdOWHhWcjcxNHpI?=
 =?utf-8?B?TVZZMUVRa3FsL1g0UzhoK01tVm1DbGkzL3Rub3JOVHZtQjhmN1E2RDdFOEVJ?=
 =?utf-8?B?VjU1VXRCZU1GRXhTSndVT1NxdDBnWUZVL01ncGFENkxnYURDZDBLRFhOMEVQ?=
 =?utf-8?B?STdwVEpnZC96eFRUOEhWWmJsbDlXREkxMFA0ZXExd3paQ09HMUJLZ1A3OGtm?=
 =?utf-8?B?WnRMWE1SQUZ0TE1EVzlRTjJ1QW85QzFmL3Z6M1JTK3BTM2R6VlAzZ3NCR3lm?=
 =?utf-8?Q?vc3LXNFfS8UmVn0Y=3D?=
X-Exchange-RoutingPolicyChecked: gWPwf5sCDCSLuf24oOgJ63vDKQqiSyiEzEeV2RxQaOP2KTgtff8p9cZr++HWC011z5fCE7fLC43/h01m3Ghiasvhfyv+zykpTk3pesqgvvJUEkMsy3ZOezJsnyJV1rILUDyi2WvzyGcGYsUIbf61ajW7s+0T/IStMucTe3UhOW2wpgWn6rJWwwu6dAH9E1RBDXOoM3E5NnWSdZIPoA0vI4HIxXI6w+O6GDSG1AMp4yhbHGxHSCPfpGIl+VQtLCa8fwwza9C4ewBayzWGCevt9TU/Z/EShiTSjc9Ws+Ktg8Zgp2+Ka0fef/doUBg4mQDNlMlJ/Eskcrhiw5fSik7geg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017c0aa1-1888-41bf-d3f4-08ded2aafc8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:14:55.7525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEY+RZMwbFd1zD/EBhjGFz/DfE079nbqSOiQ24iP/Ze+HgKll+x+3/7laWE+bRUK88tWBdr/TqhQS9NOCJTEkoPQaf2ZbhFQRFqFb53MSOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7869
X-Proofpoint-ORIG-GUID: BY8srtyKSVfh-zJrUABYg2EIrX6cahfs
X-Authority-Analysis: v=2.4 cv=Ivsutr/g c=1 sm=1 tr=0 ts=6a3d0db1 cx=c_pps
 a=eQAqIyCScLYb0ahyOVIXtg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=-tyCr0CO5YqHRCaK12QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BY8srtyKSVfh-zJrUABYg2EIrX6cahfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5NiBTYWx0ZWRfXy+Ww+KeYxCCf
 gGTb403fqHYvtd7BiwwxEMbK7eNykq9ubGJRY/kcB+iFNkDS8HKOOX1EcFofCOSVbRIBzlqhl71
 Ym+fXhNd9z+iR5ZOhubcDIwOzTezq8MvYPbAl9a+e0gOH0R47bIysAL8M4tHf6A/Aj8RW0/vBT9
 m3LKrlztNgv8z2r4TbdPUSeLtwO/Q2MH4RqaMCX3IsR6bGOBjKV9BYVCEYYBTFiDJfFRxNHX7f7
 QyXKVy8j7L5vGCTN/cnoPRYaR0FzKQyCK0tZplxmN8IuVlu+jPilunGljguPKkQkEU8ka7ON+bP
 sso7cATzRQ9a2hFnfeaxXcZnoMN+GpUqc004HDY8FeMcWUGS2jOM3UbMUNwA9yhxEOrD501Dv0B
 J1tBJRKeLtiZ/0UjXobFAPQ3lH8CuH+Q3kmb/NvcuYMCMXEDMs4dHRH496j+aMCmUHOBYVvsQCi
 6pk8L5AllwokxC/bGxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5NiBTYWx0ZWRfX8O1X7o/dmpmq
 8e80uuXK0DMx2OrRQcwmcQpmv5dBsb0fb1EGu0o4K8MzYrOuvuDAjh+VDiBVKwEsKGLIOZnACCb
 /n31Yfk+IzeBSGL8Lx6ShBIaGyKagl8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 24/06/2026 18:04, Daniel P. Berrangé wrote:

> On Wed, Jun 24, 2026 at 04:32:30PM +0100, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/adc/npcm7xx_adc.c | 75 +++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 68 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
>> index 3584c27c75..accaaf2620 100644
>> --- a/hw/adc/npcm7xx_adc.c
>> +++ b/hw/adc/npcm7xx_adc.c
>> @@ -20,6 +20,8 @@
>>   #include "hw/core/qdev-properties.h"
>>   #include "hw/core/registerfields.h"
>>   #include "migration/vmstate.h"
>> +#include "qapi/error.h"
>> +#include "qapi/visitor.h"
>>   #include "qemu/log.h"
>>   #include "qemu/module.h"
>>   #include "qemu/timer.h"
>> @@ -229,7 +231,6 @@ static void npcm7xx_adc_init(Object *obj)
>>   {
>>       NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> -    int i;
>>   
>>       sysbus_init_irq(sbd, &s->irq);
>>   
>> @@ -240,15 +241,63 @@ static void npcm7xx_adc_init(Object *obj)
>>       sysbus_init_mmio(sbd, &s->iomem);
>>       s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
>>   
>> -    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
>> -        object_property_add_uint32_ptr(obj, "adci[*]",
>> -                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
>> -    }
>> -    object_property_add_uint32_ptr(obj, "vref",
>> -            &s->vref, OBJ_PROP_FLAG_WRITE);
>>       npcm7xx_adc_calibrate(s);
>>   }
>>   
>> +static void npcm7xx_adc_get_input(Object *obj, Visitor *v,
>> +                                  const char *name, void *opaque,
>> +                                  Error **errp)
>> +{
>> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>> +    uint32_t idx, val;
>> +    int res;
>> +
>> +    res = sscanf(name, "adci[%u]", &idx);
>> +    if (res == EOF || res != 1) {
>> +        error_setg(errp, "unable to parse index from %s", name);
>> +        return;
>> +    }
>> +
>> +    val = s->adci[idx];
>> +    visit_type_uint32(v, name, &val, errp);
>> +}
>> +
>> +static void npcm7xx_adc_set_input(Object *obj, Visitor *v,
>> +                                  const char *name, void *opaque,
>> +                                  Error **errp)
>> +{
>> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>> +    uint32_t idx, val;
>> +    int res;
>> +
>> +    res = sscanf(name, "adci[%u]", &idx);
>> +    if (res == EOF || res != 1) {
>> +        error_setg(errp, "unable to parse index from %s", name);
>> +        return;
>> +    }
>> +
>> +    val = s->adci[idx];
>> +    if (!visit_type_uint32(v, name, &val, errp)) {
>> +        return;
>> +    }
>> +
>> +    s->adci[idx] = val;
>> +}
>> +
>> +static void npcm7xx_adc_set_vref(Object *obj, Visitor *v,
>> +                                 const char *name, void *opaque,
>> +                                 Error **errp)
>> +{
>> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>> +    uint32_t vref = s->vref;
>> +
>> +    if (!visit_type_uint32(v, name, &vref, errp)) {
>> +        return;
>> +    }
>> +
>> +    s->vref = vref;
>> +}
>> +
>>   static const VMStateDescription vmstate_npcm7xx_adc = {
>>       .name = "npcm7xx-adc",
>>       .version_id = 0,
>> @@ -275,6 +324,7 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
>>   {
>>       ResettableClass *rc = RESETTABLE_CLASS(klass);
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> +    int i;
>>   
>>       dc->desc = "NPCM7xx ADC Module";
>>       dc->vmsd = &vmstate_npcm7xx_adc;
>> @@ -282,6 +332,17 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
>>       rc->phases.hold = npcm7xx_adc_hold_reset;
>>   
>>       device_class_set_props(dc, npcm7xx_timer_properties);
>> +
>> +    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
>> +        object_class_property_add(klass, "adci[*]", "uint32",
>> +                                  npcm7xx_adc_get_input,
>> +                                  npcm7xx_adc_set_input,
>> +                                  NULL, NULL);
>> +    }
> 
> IMHO the logic around "[*]" expansion is mostly useful for child
> properties where you don't know ahead of time how many relationships
> might already exist.
> 
> In this case though, we know exactly how many props we want and we
> know we want to start from 0.
> 
> How about we do this explicitly:
> 
>     g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);
>     object_class_property_add(klass, adciprop, "uint32",
>                               npcm7xx_adc_get_input,
>                               npcm7xx_adc_set_input,
>                               NULL, NULL);
> 
> which avoids the O(N^2) performance of handling '[*]' and
> thus makes the prior patch redundant.
> 
> I kind of wish we didn't have '[' in the property name but
> we're probably stuck with that for back compat.

That's fine with me: I'll drop the object.c change for now and see how 
far I get.

I've just send a v2 with this change.

>> +    object_class_property_add(klass, "vref", "uint32",
>> +                              NULL,
>> +                              npcm7xx_adc_set_vref,
>> +                              NULL, NULL);
>>   }
>>   
>>   static const TypeInfo npcm7xx_adc_info = {
>> -- 
>> 2.43.0


ATB,

Mark.


