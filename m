Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85882C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRg-0003kI-4P; Tue, 25 Aug 2026 09:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRX-0003gl-Ie; Tue, 25 Aug 2026 09:44:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRV-0002Ue-M0; Tue, 25 Aug 2026 09:43:58 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PAw6au1865711; Tue, 25 Aug 2026 06:43:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=777Bgr1M0tiHSoNDvpEYSxkLji5Zdo8gpmZ2B4h0I
 6U=; b=Jcjop/o8Vl8YZp/qwAEzj7uiwTOz/qioZwnMY5bmo1Q1P9B4qK2UJ6SF+
 5qOs69MImFVjngX6B17w7WojKkBK7Z0JPA0yatwbROyBfLqpv4bPl9lGe+u24b8m
 SVKztv3JAbTdOl5g4Fd0PNSmqOOXMnYFnZwao+NJrlqNxOvkkR99CF8DDECfVDCK
 FZ8o5Uzf5r6nLtAbc3PgUuNEEsfGzwnZvKyasUm57e2vTGp52CrXKzPZFGpMWoOP
 npZqk3tNyiG+vF1W2PMkAAfmsiNGYWjEWb/CSsmyeUl6PFP5kuOq5B5tWCeAb1/m
 3N+lmohvOOtl8qy0UI8/vynusNnbg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022093.outbound.protection.outlook.com [52.101.43.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy1tgex-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiEvrdueGcmB9ypyor2S9Fw9nQC/G1NuhM/fKP1681dDIVjZNKCPHmoWNeKh5mEp/D2t/6/xqc4N7a/Mrev1fsVBhWggGhm50KMpEJ3d/Xy3QwbBaEWyjS6Is1RVdW7FzpWZ1vziY5YO5skPmqpH++AK0LZTh5FH545BQk8bzUIm5nYnuvDqTqnu5HyoH/h3Tno10R7KrlKIK6ezDofx6MHO4Kx6zm4D1aENX10eYauwAJFIOAFsv+Ni/UbdvixSnXo8GxQba7ew/WqkwqAJa8MsFKZNwfN1wC6VhjK4htv5Ngzn0vimX04rINha9XvgdWUofq4YCPtTKsuLZIsfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=777Bgr1M0tiHSoNDvpEYSxkLji5Zdo8gpmZ2B4h0I6U=;
 b=DZgZvHqsqDPDm4h91oa2mSRz2rOf/7X+A4oStOFIrLGSd9C/c6WBZ7qkGH/uAchnuuuT3Z2Nw+MlLr3L7i/vKkWay9RVF1Zm4vA2evoM1v1PeO7kEUnjxeCSDYzHI4ALDjhANnZD4ZXvKdtZIMPsU5EJKKhSUOhbg0hFOd2ZQf5ePJjGbW4aiE2DK1auVc4ZREoIoCL0Wa+OVveVU5Ot0sZTaRcztPPGGVC5rsNd6vAAB9I9RXUQVck+e7+ETQAQ0BcqZQgrGADmmgvp/rViTAIj4sYWqTJhp6mVx0RcIw6tyf4Ff3PyLG4p6qWM61PI0292bPXmD/kdjUbF9goEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=777Bgr1M0tiHSoNDvpEYSxkLji5Zdo8gpmZ2B4h0I6U=;
 b=muzcrRS4+vQ4Pedb2meQJQHscsCtTxDmHaLTdyhXo9Yr1FZakUr9w6BphukIP/EnnHDGh8grgSS7z74+JkCZe+wmUDu/E6Cf41r1VJEO+3hroVkJm3pU3LZF5Z12iEjeyyM8ljhiVUf32t449SXXwGgrOc0ajs5riAxwtq2u4hzyr08nB5+Qi1gAZZmvVjtnVvB3/hC5lVSUQVGZamee/BEvKJPlzG3UvewpMbiXSFSbvdtbgkhgfaapp2DDZ0BEwa7qU7tGNt7ONAEhOsXiKdLelQ5VJz8QvUSOEbZBPgrqjUXRhZBloJI00MVkoEahUO9zA6ySFIoJXOSzxCaOWQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 07/16] hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque
 for ACPI_PM_PROP_GPE0_BLK prop
Date: Tue, 25 Aug 2026 14:41:28 +0100
Message-ID: <20260825134320.1039012-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d3ccc7-1256-46a2-81cd-08df02aee1ac
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: A5+LRteg0L0G41ny6eMT4RGU7qv+kNbLfD63MP7WFE3BPkVkoZpk6zS2AAdkysfWUUz+/QaRCr1nhdsv54/J8ylMm4bVyAOW1uNVHe3gEb+XqHfDdX13P4zmKFGUVxftipREjMAF3FcHTE1oork31LXte/R17cVzd0uxRcbpDlu18dY/6ADuAVpTQMsCAU0VaBUaLEcqZBMkiskXVI/A2F/qI7Ek9pZ4Z1hl+zDzM4z8KeHfN2YTF/kkaTKfIwSwW/uniHCVXegR90hCR7G4FNSisW7cseHDsd3qUeOU715CmzpNHxuFrzzXYc+Akaj0RiFzJqOsrBqMZXV1D7zPWObV3s/tHHH3eX1vwMT1VWciiKuxPlL0BiTglWakBaskubsSjHN1iFZ7fOrR/K+imDBGsQdrTLx3YDU3544TKx7yiwNtd2HVDZabNWeZAi597eYnSe7As9Yy2pQds4QMpbTzNR3UoG8V6qW/tTHjLqEkpeMoOUGUu5TvHUwTByOK1yygoVF+K4BywwVXcVLWCbTn+ZT5pVVMBGAEfOGTzqwCgU+2uBn9ptX2OQnNsjJBsc4EyvcfAIXgtyq9so3EUcNBwpBfWQxXhI/gBhSXC99v4eh2D3PzHOyQSk0fhEfg/i0VaFqCad2MLukjr/BPzf6DZvvSJCpytW2RqsJysUOtWbkkdBDaVm0zMYvexaeG8TZjsCL5aL6h4XgX+XrTXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukc5bGFBbVJ6NktNL2Rjd0RIek5iOHFUTGszRHV1RWpDNytzdncxTmRnRThU?=
 =?utf-8?B?OFV0cDFzRW8vUEZKQjhTaWUzZWZFUTE0M2R5TG0zcTd0eUdTVU5EcWp2cTkr?=
 =?utf-8?B?dndnOEJ4UmgrNG9RREF1SnkwUkIybktEWmY2a0dtV1hqcHZLUzJXbEczSHdL?=
 =?utf-8?B?N3JkSlZZSHozWmQ0ZlV1UFVXVngxYno5NVUweVVQbDR3UDJ1YXBwaXpkUGx5?=
 =?utf-8?B?djRJcmNwaVdLMlR2Q0dNVHV1Y2MvOS9ld0kvbTFEbEJuOFRZYVZPaCtRb3lx?=
 =?utf-8?B?TVo1WXo1dEpRTmhXMm1Sc0xMbkdmaHVQZnRjMlQ4a2NpZEFydStIN1Y3M1B2?=
 =?utf-8?B?b0w3RHU2UmpqRnZxRERBbDV3ZU9VYnVuVzkza2o3dkxBUTFnQnVWZ1pqOEwz?=
 =?utf-8?B?RkF3QXE4eUd0YktHejBkcExUUndWVnVWSlN1RU92RW9XNzhzdUVyVUxwTXM4?=
 =?utf-8?B?L3k3bGtRV2pieHNSZkVKdlpoSW5zak8ycGlHQ2xLVXJiUEM4VFNmUkJ2R3FK?=
 =?utf-8?B?OUVVL1BkeTUrQmY4ZldsMmtpd1lMaE1jYTRxZmVUZ3IydDczckhGTnlkQmJB?=
 =?utf-8?B?UDFKazFweTkxSTR5bmVBdUJNb3plMkhjRW1JdGllWmdoTFg3aDVTMmRZenpm?=
 =?utf-8?B?ajB2VnZkQlVoTGxVeUhXQk9pOVdCOXQwMjFGeGQ3NWluM1l1Yk0ycm9kT3pU?=
 =?utf-8?B?NmQxZkE2NkpnOTF0L28wUDdhcjFvMjBNcEh3bElaMGROUWh0cVh3NFh4L0J2?=
 =?utf-8?B?cHI1WWtkQlA2RzIxcThhbmZYdzRUbVNLejhITnFvVFFqSUlGMnBCM2kvTERS?=
 =?utf-8?B?a1JUeFJ4TnhReG1peGlGVDdiTnhNMFFXb2ZzaDFlUTJxaU1sYStNYWJpWlNQ?=
 =?utf-8?B?emNvL2M3MnNORzZFajlVcWlHVHRNT3p6ODNyS1dSZ1lZZHMrblhSQmVHVGtI?=
 =?utf-8?B?UHJ4MzQxZ0NLMTEvM0M0UjdLOUt5TjA4V2F6T040N3dZdVVZVk5JVWc0Q29q?=
 =?utf-8?B?N3llUEtjTEVYeDZCcmh1VnY3bXJ6dlJhMjlJajZuZFh2ZjNrRlJ5aGR0enVt?=
 =?utf-8?B?SHY2eTI2Ukh5K3JmR1N5eElhR1lubU1sbGxPMVRlTjI2ckRNd1ZuTGdWL1ha?=
 =?utf-8?B?UW4zUlkwK2x1N1pKTCszYUh6c0NPVzZZYW4yMURkODB0Z210Rk9LUlhhTXV1?=
 =?utf-8?B?U2RvYnBGV3k5d01CRE9aaDdaWVZvdzZQM0lNWDJQSUtSc2Y5aVQ3NFdxVGtT?=
 =?utf-8?B?ZS9ibWo3dEErV05LUUpTL0NtaEh2c05sSDk0Q1FIelErL3JXZDlwTEpxeFgv?=
 =?utf-8?B?cHhENzJURzNzdHNiTmVHZ002YXpzWUZGOVF5KzMvRXlNR1h3RHRvM0szVmVT?=
 =?utf-8?B?Ui9uNk40WjhNQmhINFVaT2NhcDdaakZwS2puWWk3eFRRc2IwdS9YS1pEMCtI?=
 =?utf-8?B?YkkwNkVwRXU5Z3pTUGRSZVJZaEpUMTBlOGpyRkVTRVI1MVZoN2hpZmhSMjlx?=
 =?utf-8?B?T3R2clN4Z3RyTHZPWkNrY1djQmtkUCtTNWVQbysvSER1QkpPUDk1KzBxaXJX?=
 =?utf-8?B?c3FmaXNvV0QraUxBYTlKS1d5TWozSDdCdVVSWGpPY2hnSzkra3piMnNwaWZU?=
 =?utf-8?B?YVpNVnMwWk92bVJZdThvQWZxdHFPWVR5ZFNmUUZtUklvb3ZwckYzMkdVVnda?=
 =?utf-8?B?Zk5MR0o0ZUZFNjIzRWtIU0xZY01VaG5EdjM2S0hyQXlXRWpoY280eGVTV3VM?=
 =?utf-8?B?eFRzcVBPcG43VFdqMHlaeXM1VElicTV0MVhORFNWaFNZSDM1UUxTS281cUJz?=
 =?utf-8?B?aDRtbEFOWEs0VHk2bkFrVy9Lem9vVHRRd0ROMHdIelZVSUNxaW1NT21Ydk9i?=
 =?utf-8?B?aHJQWEJLS2sra3VHSkZpaXpqc3ZidzkyQjBmSWlIdVJJSnBiaXIwTzdhNHNz?=
 =?utf-8?B?WVRGRDhBZ3JkajJ6WnBBWHBHYnRMQ00rcTVQWUV1cEVtaXF1WlZna0hjNllm?=
 =?utf-8?B?d2h6b0U5VEdndk83cUZmS2VxUERaNElHdzE2TVZWYUlYNGhzYnFxNFRvNUNh?=
 =?utf-8?B?aGNnSDBhTjM2NEVUaFQ4ZXNSd3U5Q2JJQjR3OVdGTmRIUExNcGlhMGg0K21X?=
 =?utf-8?B?K1ZuSHlqSXV3cVVUaFBaQTdFQ2RoaVdTeEJUVUNWZG1ELzNad3VlWDlMUVp6?=
 =?utf-8?B?NGs2Z1J4M0dTZko3Lyt4dXRHNGp2TUdBaHFZN1NLSnpBQ3FtaHNUbjhpaVdh?=
 =?utf-8?B?QWNFY09iUGxNTEpMTEpWTlQ1UkRmOEsrU3VWYUtRNG9qOG9yQUVucTRnQ25l?=
 =?utf-8?B?NWFJMTN3ZWsxRlpLUXFhcld2VWlWS0FtKzVtaWk3Z0M2VXFxcm8wR1U2dTdW?=
 =?utf-8?Q?NomUZ53MBKm0Bkis=3D?=
X-Exchange-RoutingPolicyChecked: JVVlZgxp589MbBproZ9Z9YsNpYmAx7QM5l7Bz3fA6Cbfis9+BemECwRrCqlLMAkXAN7K02dV/C1uzwYaLUs3i7Ub8uQlxz07sFqczDV2Ln+LPV8ONjbybTSYTjVN+jhdll6qT/Wx/TRFA5iWPALJvL0LuTLyolgzz7R/kpSFDjmsNDGh5Zlc+2OOtDl2tkyjiPZEChiuamC8makv3JvWbjq0JxJdTqqKzuFrvr3zS75os26dA3/5l4aLqesca2UmTYKtnQxQqhk8FcgWnGpir9ggmtABBJYibye7L5tQ98H6PuB+UTmlUOOBDv5wkMwRojomTsPMiQNxFj/lNA0UXA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d3ccc7-1256-46a2-81cd-08df02aee1ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:44.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucvOAUthZgG0uPlcnWTrbnffQmStad5eyO2qWKQ/bnGB3xmagLty3hmFBJTRQEODkpmBqrmvNSyLBGeL5cIDGMy52Z/IkOpRc9qdMuGuRJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Authority-Analysis: v=2.4 cv=La0MLDfi c=1 sm=1 tr=0 ts=6a8d9c13 cx=c_pps
 a=+CKpLqsC5QamL8vULJ+FWg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: a_0-aVb_fBq-vcHtyZx4ZumQnp98Bl3p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXxsLI3kv2VEJg
 300knrfleC1AiR+ZoXZcY9SUoqIAo19cLOpanrELjiWPjeRBDUMJuwz7N5uzK4+fr5bJGiTdpjZ
 NvcIGJgnSy+tSQ2kuVjsQfaw0x/nzRk=
X-Proofpoint-GUID: a_0-aVb_fBq-vcHtyZx4ZumQnp98Bl3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX8kPKEORw6Ko3
 FZKs1qAln36dWWbHqYzErzMHsZXNRNg5/Sfk/JnPbF2NbFmV0HUWRNcOgfaFGMRD0P2d39MLjnA
 uQH41L6D8X4E/qiLSV/OAUkAcz+onD5QH2TnwMWEo9yfP2cyN5MTqVbAPq+bXsStMQA9RVO8RMc
 dl8qg1iJYEueu8CNfT5gKBTC86yhP0O4FCpu2CaUtXQZ5WOziVSr8ZhiwmIuGWJGjs2Q8s9320u
 TXu5gWa8cyHH1hZ2tl5zDinrw30JadA5TxNIFgNn1flN3T0FyIlW1LEp3srcZkGph2jSHEGBjYE
 GGpFhcDNs38zZ2SK9ZsWxpqBbNlLX26qOR3gGh7Wp3VJ+/Nm0jQkJvT5kk1U2DevaKZkMrX/oAY
 HQGqc+3BOiIVFGsKHCcqUsGvDVVu/WwMn9h0W0Ml1BpJCgIeHPAqd658RYQlkRXUVITkCy5mDl2
 2mBI8SntTxezj50T8FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

In order to convert to a class property, the ICH9LPCPMRegs instance must be
resolved by the getter/setter instead of being passed directly as an opaque.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/acpi/ich9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5e8f8a7eaf..ac3f452dc3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -342,7 +342,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    ICH9LPCPMRegs *pm = opaque;
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
     uint32_t value = pm->pm_io_base + ICH9_PMIO_GPE0_STS;
 
     visit_type_uint32(v, name, &value, errp);
@@ -411,7 +412,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              OBJ_PROP_LINK_STRONG);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
-                        NULL, NULL, pm);
+                        NULL, NULL, NULL);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-- 
2.43.0


