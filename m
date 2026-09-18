Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFEAC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7U7D-0000kb-9F; Fri, 18 Sep 2026 04:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x7U7A-0000kQ-8s
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:38:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x7U77-00052O-7h
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:38:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I5vZe12066130; Fri, 18 Sep 2026 01:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AfM25IcW8TSJmJAAmqhv/WmWMOtmCZ8LgepQbtFmS
 IE=; b=0IQOJPPtdzCOl9jdB18QZyYiutjagPAqW26oGpXWlxzjByulFs5U3Mp8h
 MV2jyHqN8+WMfSPxDOQYPejMO1hrgWLpXGisy7ilQrmqEHw2M78VQIiROAFWsnOD
 x5b/UauozPUCg9SYW4JOe5WcRDc+JOkk/xbk9oe6DFHgV9PjcMtwF/ec/5D8TEBW
 jkEGdQG/CiuwJYmVQg4b8uqH7KSSPxWMMsJBSmpzhQrCVK5oZN85hdReOnRh63sb
 eXaV6uLNwJvhlsGLiFwBD8eKJrXtUOhYOEstrcN++PFoxUB9QimWGPGtrTUoCm43
 vlqiFN1utH0tZGI6enZSl03Xfd6vQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022123.outbound.protection.outlook.com [52.101.43.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gr9q3u5mn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 01:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2E58Bg3MI0ODh7xUO46UwndAw1xnroKVmOKIE9jbf9i6M1cZ+hf4JBNwpTyU8NWs+0KUopXboK8tcJ1PGBi6y7sgDLVjdV7wBCtZcc1OZYN17VOPuLlUqt8uZtr6R2Qe3p16qBaU7f0gsmW9l5ITnlkKFaP46l75c3+omykaSlzNnlzg5aGy4ZvmHsokCEFxzw+wHjT1zBYuPcKOWtlwQoHQci6kys6xs3MqEkUDx8gO0zyWLKYZareAhOC4hmVb7kPadqrBPMYgZgOTucNd8O92/HwztIWnq5b9Q+6ojgGFg1PJopAqTJKBaq49aqF64vONUJSaAKWAcZJ9k7DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfM25IcW8TSJmJAAmqhv/WmWMOtmCZ8LgepQbtFmSIE=;
 b=UQRMGG4CN3x3G0XehdMfbtGGW4MJi3f521oLsT6TIgu2ULG2ZiuB0hpLc+DNz0PsO0/rSHmulaGtflMeLtkPr+wgrVzEHT6Jt0ugkHbgmJtalOAEKi8JwVQcY58y7s7wqsIvpd3moB2HnN1UPAYfFULn0C2S8rD7Dr1c5AwHzvFplFC//rFFTgL8rp/saIF0qMyPt/MCTEeN1fS19zbOtTviiSGHcJA+XhfZXXE0B85OJ1H5Z8fW47iQkmZ+M9Dt2WrtgfTxOxQJrfCNCYKBFt63lw5lV8ndwMhegI6FjMadq4ZcxCrWVvrF+h3F1VFXCQgeJTyLLIcEyXHUJFH+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfM25IcW8TSJmJAAmqhv/WmWMOtmCZ8LgepQbtFmSIE=;
 b=BcaP0YEQVin2yqRIdjNGBhQwAeumHOnGAyNVApaxMHYTeVf+KaLulEyBcGQfXxhDKME/pOF2/5XfAWYLJOhMZ5PG+mKcL1NxaBtkmMJjA8qsqNV618Dq28sxvLge9QKdQ5C4QjfoPhpmvEHTDnRyp2Uxucu429zsfYCymUDT4Oa5/i/Hx2wsq87EkZkD2IaQAVW9lgNznIFoywPCyWU+TThlrR9CqHbgBPfpM0GQKmnNE0mD20nr+ITQWvZgx5wqb7LNig5iS3QA0J5qOXl6zUGjXqam2MwVNZuJJc6OIaT53mcSNLp77B3Gq412N0Tb+MQDPGoMOfVxbJk8Lj7w7A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA0PR02MB7322.namprd02.prod.outlook.com (2603:10b6:806:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 08:38:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 08:38:26 +0000
Message-ID: <8d9f755c-a82a-4b22-8a9c-ff75bdc23da2@nutanix.com>
Date: Fri, 18 Sep 2026 09:38:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] qom/object.c: introduce
 object_class_property_add_alias()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
 <20260902144207.2553037-3-mark.caveayland@nutanix.com>
 <CAMxuvaxoQXZz3AhM9wnRuM7hRn8LD4hMT0ONaV-vRtz5Jy0big@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAMxuvaxoQXZz3AhM9wnRuM7hRn8LD4hMT0ONaV-vRtz5Jy0big@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA0PR02MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 50803cd4-cfbd-4642-7164-08df1560353e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|56012099006|4143699003|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 5DpiQR/WOCZ8gxb8obevJ5Kv8zNfEyNK9eUXqUapat1DmW42Wfpea9JBKqat2MpQIiWk9o4Uxvu1ZY/i4Oa0ZQ4a4/wNido/EZKGv7HLU6xoh5V+Cq+ywudCgTu1GcSbEtsoAmV1r8DYR87pAPVxB0IykCwmKiyU+gMIWjeVR1A6nlZZ3fXcu5mA6otZhe8l3MnRGtrqXfpF1SA/k48rxW7VNBkq2YZTztrL6msjnomT1JEMAU8npnIdeLI2n0sB6aiKUuv57epF77kzCRioICCejz5Xr9IVdt+WFn8Pyset4KMCk/iUMgo/aWEBuz7fYSb5eEqJTHmqG+10sr2s53U6M+vMBMu9i3XXWVz3gjC3RadMCEmg23KPW+E1I46h11R7X8PgzTL5sH5P3jq//S9w4C9n1cjikrx8jgB4a+iUg/LVMf8G58jp/du1DSbTswzWbkaWBYHQVyA0q1cgcaMdk5mIUwodu63ZobShWLkJSt8FU/lTFBVRHnCSFVB8b2S5+48UAKZr3cNdNO9x0zoxBnZZt+RzQ6/jBBeuyrd1A+71D+Yi49ZBazXs27XrFQbY29lSu55LFhFK4XQ7M/sU3DkYDqy6X0btRKIzTTNgHiUeuNG3jn77XzdSQRKmatZQPoaX2uW2fA5Ib8LxVHXJAMyHjkCkDiUIzcCUuc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2x3Zzk3RitJVm84MTVVYU1zZG1jN3MvY3IxY3l1SHBFVS8wYjhmd2NyalE1?=
 =?utf-8?B?a29GaUV1NE5TdnRLZlBuM0ZYaTZqcVhQSmwyaXdrTm9ZUjdiNktsVXZVdlZ1?=
 =?utf-8?B?YS92QWhFeVY5aW9wQkVqdHJTMXUyZTFOQU1GWTFzZlZISjdqQnpKQytWU1k4?=
 =?utf-8?B?ZnZXeFJMQkpmRWJTdTJFaDZQcTBqQk52TlJCejF6RWRNV0ZLSy9UK0lZTjQw?=
 =?utf-8?B?bW5MbG1JOHpTYkpwc2huMVhTS09leGs1Y3lZRkZEemlieTY1Z3BWME1GY1NF?=
 =?utf-8?B?Zm5SaGJxQWZoTDdteGs3MUlGY21GeWZHY000RFJzVGc1OERCUkMwUFozckYr?=
 =?utf-8?B?VjVuaGpsRlo0U3R4WVpOOXhYUGlibVdvb0dsM3Z5QlNJTlliM21CMmVkaG5X?=
 =?utf-8?B?S1RvdXBIL0F1bFFsdFJ4U0ZMYVFiOStJVlVBMHF2Q2JISGVYM3AzNy8xWTI3?=
 =?utf-8?B?Z2hkSjJWMmc3WjFvSXJkdXBUVTFrUWcxc1hQRFFrNVJIT3JtNUkySEVpOG91?=
 =?utf-8?B?YXJOVUZSY3dFR3NmbElVUmtKTHJjcHpYK2U4bjV3U3J6RWlYSkF4ZHYwaVlP?=
 =?utf-8?B?N3RNQUx3YndyMmFVQWV0SkR3QWxBOUhNYWJKcUx2dUpuaE91bWFUeVBBajZt?=
 =?utf-8?B?aytrRUFNdTNVTzMxb0gxRm9xVFJlM1FpWlRWWXJBci9UdXVTdzAzNVk4RURs?=
 =?utf-8?B?U0RXQjRWdjk0TUdVcll4Y01qeFBSejRrcWpOb3ptMjR5MW1LRDNYUEQ3T2FM?=
 =?utf-8?B?VWErM1paUWJJTWt6ZEJSZUxFa04vYTFrZlZtazJ5ak93MWJJRFRVL1VEMUxQ?=
 =?utf-8?B?SVVhTTZmUVhJK2IxOHJ4TCtKQWZOUmdUU0d1Ym9DdGJWVUxCblV4MXc2RkMr?=
 =?utf-8?B?MWVrWklpeXNSL2hwakNFYmdydG5UVGdUMy9rUGt2Q3Q1Zk00SHhORUlZeXpm?=
 =?utf-8?B?eXdNOUxBLzJPcW1TYlh4cGlSQTd1WndBdzU0eTdESHdhNVp3cTgyS2ZRL0lK?=
 =?utf-8?B?eUZVZW9lQkk3eFg3czNoM2VyZEo5YUhtTExiSFhsamh3ZnVDT00wbFcvOWZH?=
 =?utf-8?B?clNlUGdGeEhFSzBMcVNnV0lRM0FMTXFBNjBkQVNPKzFkc0ZLdzVVQzNjOWFm?=
 =?utf-8?B?aktscVpscmNpYXZaYnR3K1k1WnpoYit2ajYwMXMwYlZnOE5RNnRYNjJURjVp?=
 =?utf-8?B?VEtzYWVYMnJuK2xVc3RSaWsvaXJ0NU80N0JsNzRneUpFYmRJZFRRcE8xTjNR?=
 =?utf-8?B?RHpTeURHZXpFcHhRS012UVFFTVdWLzZkZHlacExjR2pEc1hiaHNueVRRZEZL?=
 =?utf-8?B?WmxaRDFVTk43QjllSEg1MzFhc2NnNFdISXZhU0xXaGdDNWtlUE1DZm9ZbjFy?=
 =?utf-8?B?blkxa3Q1ZkFKYnJ0Yk9TK3hHc0hlMmRWbDNhQWtNeVQza3FOSXVDNFZkUEFu?=
 =?utf-8?B?bTh5NlI1bWdSY1E2SktUMHo2OWJ0SExPMjJxOWRwcDdNa3BLWkZiQzZjem1u?=
 =?utf-8?B?akpOTmRWbUdRaWc1OEVJUTZSaHlURmlZaWp1RWJjOTd2MTJ3UUE1TTM3VHYw?=
 =?utf-8?B?b3I2M1JrcDZTK2ZOQ1N2b3p2ZHFkYkFIQ0RYWWZyNm9WZHJ1eEQ5cEhkbmlq?=
 =?utf-8?B?VXFaUGNxaDBCMUFHV1FXQWpPT0NiYm41MHd2WGhMN3krc09acmt1ai9RVXRj?=
 =?utf-8?B?bkdieFk5Z245UUN1cVhpMHBMMTVhb1ZOTm9jTkJTcTNFTmVTdkVGQXdEK1hH?=
 =?utf-8?B?OTNLUWwxbTlCMFFRVWpnVG1VZis5WHlHSG8yNlpVS0tXRWN0L0xpQ2NjcXNC?=
 =?utf-8?B?ejhKbnpSbG4wV1JjNHVxeHFKMkEwY0JjMmJ0QW44TzcrZ3Z0T3Y5eHRqb0Jk?=
 =?utf-8?B?V1RUaWE5NnlYelRtYVJ1K2ZkZHJJcUF2ZWNGOWJoNWtXZEd4NFd3eS9tZzRh?=
 =?utf-8?B?NmNPUzBqVTNUMEVnSEVUcjdUSGczMzkxcVl5SmFNaU9pR3lmSThOclR3TzNh?=
 =?utf-8?B?VkNwZ25ka0FSZ1lXeXdHMkJwVWp3c2gzYUlsZVliOFRKVUg2cUlFVU0rMWlo?=
 =?utf-8?B?NWo1MDBOWGFkTXN0dE5Lc1dLWE9UbDdiM1VuVlVXM0t6NGRHZHJ4V3Jwanp2?=
 =?utf-8?B?WUZUNmttZlBLUEZHMHVtS3d5ODNTdG5aQXErS2JFMHNTWmV6UXZOQ0F5V2NJ?=
 =?utf-8?B?VFJJcDlxSm9zbFZxT3NHZlYvaFVqYTZKQnRMcEliQU5pUUxVN1lUSUlkUXZK?=
 =?utf-8?B?d2FOZ0V0djhNb0FMc1Nsc2NTZ01YRjlHOUwwWkNTKzhMTWp2OTV3cUxmM3Rm?=
 =?utf-8?B?MTdQb3dYc1ErNWdFQlkyQjdoYldTU1puM3BZRGlpcVBDZHJ3eWtlcU9WVklK?=
 =?utf-8?Q?FWDsZszNg/vJNUAo=3D?=
X-Exchange-RoutingPolicyChecked: GSD0xq3j1CwJVgQJy3avsgcGJgmZzt9epwmCuGBjpD/qNJCA6PBwcsZhQ3x1R+B2qCPAXbGo477xjYR+i+PUrmXfLn9coFAyMQxlWCAuU3c054oYPVyG75Q9ombKy7RMsZp4hLNp0o6q+wz+VqII6TkX5KsD4bnnwTChKqz1bztfiRUqDeSdiwWlIvZi7Qp9RUHA3l4VgO5OyV4gc/AEYDsIqKklF/Cp8GesytPwoBYn7hQjdc0T+qeRqb9bd7+n3Oy6Hk8HkoTNQ8T6MlB7R0nIKgFS94MKxNAz+ftlLrXTXkWetLCTlf13RcJdghQhVDylIMmlVE5mpxkrDDxF4g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50803cd4-cfbd-4642-7164-08df1560353e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:38:26.5407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEIJ3I8dZWGMbx9PDMMnhD+xTL6RcjGw8EuumwcSTQajxYExcmY5YvB/RXL12I1N9oQafkekYnEejx2wAAe+ZkLEg+AJd1ipPmiqhi8iQq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7322
X-Authority-Analysis: v=2.4 cv=foxJ914f c=1 sm=1 tr=0 ts=6aacf885 cx=c_pps
 a=0vj9JdGoO5ZFtW877mlItg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=dkVWU-N1bndSk0K0diAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LM0HWG3VLJ7UxCMwGQjQz0wmtKlsf6ws
X-Proofpoint-GUID: LM0HWG3VLJ7UxCMwGQjQz0wmtKlsf6ws
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExOCBTYWx0ZWRfX2lAOSZ4/R591
 ZLZFg1rhUfV3bWHXQdqsCxWCdScylMD0p1ibYmet/eUR2RUN9JV0wmRNqYH6YDIlYkaOb1dYnbX
 tJtC1wq+lipji/V2yjYCMci8f3jvXzk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExOCBTYWx0ZWRfX5dLiS1nOVbkd
 vCQsnQ8g8tzH7yK2QlGaACgiupOe7MMKFpRU59qlWqqx1//NC/3MbHr3GvZs960hsACuS+Vedwy
 0YIiNa65UXMRP2SJ2QiB/87hm5exuDAFiJGTx6321ZvXL/+T+bj2BM39KGhgg/a0pgKzc0eSDwc
 clsMweybqJGINMCqhnNE2ccTh+Hw+CwHF/MEI3/neN5BE3PJiSyNrs3LIlV4suV/iNR80oYigEo
 CfaSkhMSHNBZIhCpJ6Zdcb9MQ96gY5nhWtOpZjNcu7eV8TGpWEB22lpdGW0GJniad2xpodahVd6
 M3o055vyJhxAN7FkOijjn7hYaytjT7opMwBEKVwOtw6rXbzeQDFlFgp/TpjkmWxtWUVsQV0uxbr
 G1nNLmgfdo9ZnS2pAV4LvgNCOv7X/tdV57sX7ugbKnoD/QhnZl4r8RR5T8+hF6Hpp4e6GYflLqf
 szmDRUbcWmAbLC5M9LQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
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

On 17/09/2026 09:52, Marc-André Lureau wrote:

> Hi
> 
> On Wed, Sep 2, 2026 at 6:42 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> This is eventually intended to be a replacement for object_property_add_alias()
>> which uses an object property instead of a class property.
>>
>> With the advent of class properties, it is possible that QOM may attempt to
>> set or retrieve the value of an unset alias property. Update the existing
>> property_get_alias() and property_set_alias() functions to use the null visitor
>> if the alias target has not been set, and property_resolve_alias() to return
>> NULL for the same case.
>>
>> This ensures that unset class alias properties accessed e.g. via the monitor do
>> not cause QEMU to crash.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/qom/object.h |  25 +++++++++++
>>   qom/object.c         | 100 +++++++++++++++++++++++++++++++++++++------
>>   2 files changed, 113 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index e24f0a2b2d..96c76975ef 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -2263,6 +2263,11 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>>                                             const uint64_t *v,
>>                                             ObjectPropertyFlags flags);
>>
>> +typedef enum {
>> +    /* private */
>> +    OBJ_PROP_ALIAS_CLASS = 0x1,
>> +} ObjectPropertyAliasFlags;
>> +
>>   /**
>>    * object_property_add_alias:
>>    * @obj: the object to add a property to
>> @@ -2283,6 +2288,26 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>>   ObjectProperty *object_property_add_alias(Object *obj, const char *name,
>>                                  Object *target_obj, const char *target_name);
>>
>> +/**
>> + * object_class_property_add_alias:
>> + * @klass: the object class to add a property to
>> + * @name: the name of the property
>> + * @offset: the offset from the object instance where the object alias is
>> + *   stored
>> + * @target_type: QOM type we expect the alias to resolve to
>> + * @target_name: the name of the property on the forwarded object
>> + *
>> + * Add an alias for a property on an object.  This function will add a property
>> + * of the same type as the forwarded property.
>> + *
>> + * Returns: The newly added property on success, or %NULL on failure.
> 
> actually, it assert() on error and never returns NULL.

I was able to reproduce this by attempting to add a class alias property 
with the same name again, and then started to look at other related 
functions do to understand what the behaviour should be. There seems to 
be a number of existing issues here:

- object_property_try_add() returns NULL in the case a property cannot
   be created (which seems to be only when an attempt to make add a
   property that already exists). However since object_property_add()
   always passes &error_abort, then QEMU terminates immediately without
   returning the NULL.

- object_class_property_add() will currently assert() if an attempt is
   made to add a duplicate property: it is fairly trivial to update it to
   return the same error that object_property_add() does, however it is
   interesting to note that the kernel-doc states that
   error_setg(&error_abort, ...) should NOT be used. However in this case
   it appears to return a genuinely helpful message which I think is
   worth keeping.

- There are several places in qom/object.c that do not check the return
   value of object_property_add() / object_class_property_add() such as
   object_add_link_prop(), object_property_add_alias() which could
   potentially dereference a NULL pointer.

It feels like the assumption is actually that these functions will 
&error_abort rather than returning NULL as indicated by the kernel-doc. 
Any thoughts on what we should do here? Ideally we want the same 
behaviour between the object_property*() and object_class_property*() 
functions to aid the transition.
>> + */
>> +ObjectProperty *
>> +object_class_property_add_alias(ObjectClass *klass, const char *name,
>> +                                ptrdiff_t offset,
>> +                                const char *target_type,
>> +                                const char *target_name);
>> +
>>   /**
>>    * object_property_add_const_link:
>>    * @obj: the object to add a property to
>> diff --git a/qom/object.c b/qom/object.c
>> index a904f53ed6..9a05e189ea 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -34,6 +34,7 @@
>>   #include "qom/qom-qobject.h"
>>   #include "qobject/qbool.h"
>>   #include "qobject/qlist.h"
>> +#include "qobject/qnull.h"
>>   #include "qobject/qnum.h"
>>   #include "qobject/qstring.h"
>>   #include "qemu/error-report.h"
>> @@ -3039,14 +3040,22 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>>   }
>>
>>   typedef struct {
>> -    Object *target_obj;
>> +    union {
>> +        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
>> +        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
>> +    };
>>       char *target_name;
>> +    ObjectPropertyAliasFlags flags;
>>   } AliasProperty;
>>
>>   static Object **
>> -object_alias_get_targetp(Object *obj, AliasProperty *lprop)
>> +object_alias_get_targetp(Object *obj, AliasProperty *aprop)
>>   {
>> -    return &lprop->target_obj;
>> +    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
>> +        return (void *)obj + aprop->offset;
>> +    } else {
>> +        return &aprop->target_obj;
>> +    }
>>   }
>>
>>   static void property_get_alias(Object *obj, Visitor *v, const char *name,
>> @@ -3054,10 +3063,18 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
>>   {
>>       AliasProperty *prop = opaque;
>>       Object **target_obj = object_alias_get_targetp(obj, prop);
>> -    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
>>
>> -    object_property_get(*target_obj, prop->target_name, alias_v, errp);
>> -    visit_free(alias_v);
>> +    if (*target_obj) {
>> +        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
>> +
>> +        object_property_get(*target_obj, prop->target_name, alias_v, errp);
>> +        visit_free(alias_v);
>> +    } else {
>> +        QNull *null = NULL;
>> +
>> +        visit_type_null(v, NULL, &null, errp);
>> +        qnull_unref(null);
>> +    };
> 
> extra ;

Ooops, thanks.

>>   }
>>
>>   static void property_set_alias(Object *obj, Visitor *v, const char *name,
>> @@ -3065,10 +3082,18 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
>>   {
>>       AliasProperty *prop = opaque;
>>       Object **target_obj = object_alias_get_targetp(obj, prop);
>> -    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
>>
>> -    object_property_set(*target_obj, prop->target_name, alias_v, errp);
>> -    visit_free(alias_v);
>> +    if (*target_obj) {
>> +        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
>> +
>> +        object_property_set(*target_obj, prop->target_name, alias_v, errp);
>> +        visit_free(alias_v);
>> +    } else {
>> +        QNull *null = NULL;
>> +
>> +        visit_type_null(v, NULL, &null, errp);
>> +        qnull_unref(null);
> 
> Why not return an error?

I think that would make sense in the context of the discussion above.

>> +    }
>>   }
>>
>>   static Object *property_resolve_alias(Object *obj, void *opaque,
>> @@ -3077,15 +3102,21 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
>>       AliasProperty *prop = opaque;
>>       Object **target_obj = object_alias_get_targetp(obj, prop);
>>
>> -    return object_resolve_path_component(*target_obj, prop->target_name);
>> +    if (*target_obj) {
>> +        return object_resolve_path_component(*target_obj, prop->target_name);
>> +    } else {
>> +        return NULL;
>> +    }
>>   }
>>
>>   static void property_release_alias(Object *obj, const char *name, void *opaque)
>>   {
>>       AliasProperty *prop = opaque;
>>
>> -    g_free(prop->target_name);
>> -    g_free(prop);
>> +    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
>> +        g_free(prop->target_name);
>> +        g_free(prop);
>> +    }
>>   }
>>
>>   ObjectProperty *
>> @@ -3110,6 +3141,7 @@ object_property_add_alias(Object *obj, const char *name,
>>       prop = g_malloc(sizeof(*prop));
>>       prop->target_obj = target_obj;
>>       prop->target_name = g_strdup(target_name);
>> +    prop->flags = 0;
>>
>>       op = object_property_add(obj, name, prop_type,
>>                                property_get_alias,
>> @@ -3126,6 +3158,50 @@ object_property_add_alias(Object *obj, const char *name,
>>       return op;
>>   }
>>
>> +ObjectProperty *
>> +object_class_property_add_alias(ObjectClass *klass, const char *name,
>> +                                ptrdiff_t offset,
>> +                                const char *target_type,
>> +                                const char *target_name)
>> +{
>> +    AliasProperty *prop;
>> +    ObjectProperty *op;
>> +    ObjectProperty *target_prop;
>> +    ObjectClass *target_class;
>> +    g_autofree char *prop_type = NULL;
>> +
>> +    target_class = object_class_by_name(target_type);
>> +    assert(target_class);
>> +    target_prop = object_class_property_find(target_class, target_name);
>> +    assert(target_prop);
>> +
>> +    if (object_property_is_child(target_prop)) {
>> +        prop_type = g_strdup_printf("link%s",
>> +                                    target_prop->type + strlen("child"));
>> +    } else {
>> +        prop_type = g_strdup(target_prop->type);
>> +    }
>> +
>> +    prop = g_malloc(sizeof(*prop));
>> +    prop->offset = offset;
>> +    prop->target_name = g_strdup(target_name);
>> +    prop->flags = OBJ_PROP_ALIAS_CLASS;
>> +
>> +    op = object_class_property_add(klass, name, prop_type,
>> +                                   property_get_alias,
>> +                                   property_set_alias,
>> +                                   property_release_alias,
>> +                                   prop);
>> +    op->resolve = property_resolve_alias;
>> +    if (target_prop->defval) {
>> +        op->defval = qobject_ref(target_prop->defval);
>> +    }
>> +
>> +    object_class_property_set_description(klass, op->name,
>> +                                          target_prop->description);
>> +    return op;
>> +}
>> +
>>   void object_property_set_description(Object *obj, const char *name,
>>                                        const char *description)
>>   {
>> --
>> 2.43.0

ATB,

Mark.


