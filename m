Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEA0ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 03:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snrkv-0001jc-DI; Mon, 09 Sep 2024 23:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1snrku-0001ix-9G
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 23:41:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1snrkq-0004rJ-UW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 23:41:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A2tWQN003846;
 Tue, 10 Sep 2024 03:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=VADFqteaG55Sy69U/NjfWcU8EtchijxPdJC5MNlq7wQ=; b=
 cQJYF53KXsx/4DTf6qRbgnI7YJ6emU7YTCcQ825oWZxiIlR29n+ecPYXJF4hX678
 QKje85+wgsy/eQlMj4mT/yljPWPF7se/OriRDgAHZCY7cE/1vOaKSdZfmgJKeNhv
 Cj9qP/Zg4yGLIoS0yIDr1kJC401LONMYWm/68VCd/RmlxchaWjl0k/GtupzcLw7c
 Fo/kVSwRne4qe86lsm7p7AoTW4AM/CC5gHEamdCpeQP2FyS5vP54zHDcDOHJ3UZt
 f2ZC3YrRXHI3SajCMAzwqX4tBX6Lttr6dauSDXWHar1d68cFntNxZwu7LU4+Bv5F
 4vzswSI0wjBNzqlvHV0F7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbum9s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 03:41:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A2X3BE033009; Tue, 10 Sep 2024 03:41:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9e9ck5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 03:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+YRXazYHUbE8lDvnl+dlXnQ0/Dh8+UC7PdDUdDXl4hjARWEc2L29aQH7RFn+e4+/PMRHjldYwV7impknaXdzR0/27fTKdjmyRQOSQ9WzgMa5rRJj+6mRx5YLoGuPjB9KTs3mH791DYNwzH+3ffNpFCvRH0oqcN1++p+Wtg8Y4A6465i+ONbyR2V30JD1OeRBt4ooD/dTQGaM3YyhUsWXDAMczksEyRca6eGbyKJhOfuMOPJwykvwrEdQ8GnFrWf4GA8T9/r5xbIXVOPc9hq0g7DTsoQg5mGFZYqNBj2Xu3ZgBjj/JjoUafNMiRJyW6Zf0fXGm9HVhqqk47D0PXB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VADFqteaG55Sy69U/NjfWcU8EtchijxPdJC5MNlq7wQ=;
 b=wJJQ4wXiZkSz39aEHj+hqb+ATObqS0Psm34/AIKUcvGB5yA1nwjstHDxUn/67Aj8/1MEt/9sS11cYd7AuHbRvabHxBcQoVNSfJrJMCDKggPrqaeiOw/hLVWr0UO5XitRxiJxg8nCmeC4F1QqXH2pdjhB+3rXkjyz6pTAEi2QKyefX1U5hz4b38iQGg9lRYGNan6z4zxfKfqkebGLSe5mF2NQnnC1kxPWAPLPrdM5WRibHHQGQaoGNuwmuEx/4/9Gdz81H7pG0YO2AxvMp3BcuYKBPe80b3bwEJ8dR32dY/7hS53SD2+/GrIkKPkWQMdC5tcmTZPNcZl2qpjVx6S2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VADFqteaG55Sy69U/NjfWcU8EtchijxPdJC5MNlq7wQ=;
 b=C9RHc9StCEI9wnsgPCRWyEVGBUrxgesyVXgn66QpSUTEwSqrrWQqLFn+TKyxNlSr5jmrZ35roNN/gGJWxaxIg17J90rNbU49bMiOKQpsrZrPQNzcD+qtw90Il9Le/6krcenZu4jCdhYpYt8vrWh36q3NixiyE7lVgqdhC3sS6tk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4208.namprd10.prod.outlook.com (2603:10b6:208:1d7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.14; Tue, 10 Sep
 2024 03:41:01 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.7962.014; Tue, 10 Sep 2024
 03:41:00 +0000
Message-ID: <1559bdcb-315e-4411-a996-89c6be430d4f@oracle.com>
Date: Mon, 9 Sep 2024 20:40:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Move net backend cleanup to NIC cleanup
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 yajunw@nvidia.com, Ani Sinha <anisinha@redhat.com>,
 dtatulea@nvidia.com, mcoqueli@redhat.com
References: <20240129132407.1474202-1-eperezma@redhat.com>
 <CACGkMEvXNSkMy=WAv-Eiy4M_7kmqJFkv7RgDwqrgry_O2eT2hA@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvXNSkMy=WAv-Eiy4M_7kmqJFkv7RgDwqrgry_O2eT2hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 134c8b2b-71dd-4f12-2c1f-08dcd14a638e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUp2RVF1eVQxdDQrZ1hpSWJqNW1CNG9oZjJpbHcvUzhwR2tuMEhYeXA2Z2Jw?=
 =?utf-8?B?MzdkSWtyMW56eThuSXdWNFE2dDVxaUw0V2oxZFNUSmFjd1NlS1VOL0RrNlFT?=
 =?utf-8?B?c25XMWtmUHpOZ2lFdS9ZR1E2WjVNa2l1aXk0eGxOOERWVk5PRVRtS2FSWjJ2?=
 =?utf-8?B?SG5JUjFBZDZBckFGc0p3S0pHSXZWWkN3M2hmUWR4R0JBYUJqaUFFeEp2S0Jw?=
 =?utf-8?B?dDNIU3ZPcDlhOEdZdHRXQnV3VWJwTHRubmdFazZNTjJQbndIOVlveEtrU1p5?=
 =?utf-8?B?SEZLSnR0TjFuZjlkMDJ2aTBuTkpwdndRM3ZIQ0FoalFiV25GQnVnR1pjalBm?=
 =?utf-8?B?RElZdW5XTEJJck9XbVQ4TmdhdlNWdG1DSWROMko1UUdVMnpYS0NVSDh6WENT?=
 =?utf-8?B?cEZnK3hudXJER3paT2pBd2s1Q29DdW5td2hpU1ZNME5LN0R5SWljMzdTUDNW?=
 =?utf-8?B?dTB0MG5nM3BZSXVwWVpYTWZ1V3A4RUd5VzRLcEpLUVl4MEZvZlFBd1ZBRjd0?=
 =?utf-8?B?TVZMdk5ybjZQZzUyV1FpOXE4ZXo4S05VYnFLdjcyK0pDWUI3dDNkS0R0eDJF?=
 =?utf-8?B?WE5mbjl4aDhYZzRmY1paYTlTeTFoaGZTYW5IZ2p3K201QWNxWitrVFR0ZjBH?=
 =?utf-8?B?LzVXMjdFWTQzNFhzemRFa2dvb3ZLQ2FhVTRMbkswL3d4ek0xam93aW9TQVJx?=
 =?utf-8?B?WnNmeEwyck5XeHg0ZVo3eXBTS2EzQ3dxaGZDQUtxY0N1WjJIcmpZNDhVczdR?=
 =?utf-8?B?ZXUvMDMwZjdPTTE0MTdJWEJOc3djL0IvcVk2ZGs3cUNBcFpwRU5YZS9KLzli?=
 =?utf-8?B?REl5QXFXM3Q5djk4UE40dVFZcVI5aGZKSXRwZzByQzh1cFRrN2xNSUxjVW5L?=
 =?utf-8?B?dVFGYjdQMnFWd0FnWDhLYmZPdG04cXBvZGgrWUQ4MHo0SHRUM3lmc3cwaEpD?=
 =?utf-8?B?RzNyRnFqOXhIRVQyZjZ1Z2FjVmsvOW9vTW1rQU0yRWl2TktrTDRHWmRCNGlE?=
 =?utf-8?B?MDJDdlJRSHpoVForWkF1eFJuSlZJalVXSjdWVnorUTJLZFVpeFg5QndPclVl?=
 =?utf-8?B?UGIzdURlVTlaZXozR0FhQmszbFp2VlhTSkI1VS96N3NKR0R2YnpPMEdIenpE?=
 =?utf-8?B?WkRVTk1kaWVzdGx0YkhxcWZGdnYvZnZHc3JXbEp6d0tFd21mMTZtK2UxMXRP?=
 =?utf-8?B?dDVjbVcyYmJhVUpqN3RCQzVTS3pVdUdCaG1JSUMwZGxPazhUSjFnZ3laM3V4?=
 =?utf-8?B?QTlTN2VJQ2NSYi9jSDlNNzZKOE8vbUFCMVZLc0hUeEJoWTl1NE0yUzFIMzRp?=
 =?utf-8?B?cWoxY0hhd0tENXloUEpyWVdnRFFWKzd2MkNNWTIxMnBzc3AvT0dNbnZuWnU1?=
 =?utf-8?B?c0NVcll1QnltdXFTMzBwK2JDZDJJYTJtM0ZlSEF1NHVlSFRlT0pmRUpFeDhM?=
 =?utf-8?B?c1NERW13L3JXcS9YeUIzSWVMK09ZbC9VVTdQTTgzY2ttUFY1NzhxbE1ldG9T?=
 =?utf-8?B?T1BRWWw4eXdUS2dDcVJWcWhWVFNMb2E3bTFQSFJtMjVJQTBsUk1SUzZJZUxV?=
 =?utf-8?B?ZmlydnpFcDZFY2lxODBucEd4VVEwMGorZEU2bUtrWVhrRTR0MXpydXd3Q0lG?=
 =?utf-8?B?U0orWVZxZE1KTWRhNEUrclplYWtpZStnNWg4R0NtbFlUUUlYNEQ0elNuTEFV?=
 =?utf-8?B?S0FRaGczeXRRR0RuNlU3Y2N2OVV5SnovYU1HK054OWhZYllVbS9MYmRicDlW?=
 =?utf-8?B?MHVxbmgwa3JjalQ3QVVxa2RUcVdacDJLZk5LTEZMMjRhbWd5N1BNZ3diMWJ0?=
 =?utf-8?B?ZlY4Q0p4ZG9KVGFQQzlnQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZ6dUZGK2JsZ01vbXVmK2EyWGQwb3BZOTM2RlpKaWlqT2p3NGMvbmczOFAv?=
 =?utf-8?B?VzR6YkxNRVN6cE5TcytlMlBIb1F3ZFNMQ1FoYUlUVmVsMkd4MkpBalE3NlI2?=
 =?utf-8?B?WE9YbVFjUUdoTXY0T21SU29LdjRWeTd3cmtsSWdFZStyNG9iREVVMmtScE1C?=
 =?utf-8?B?SUNQdVJSKzBoSjE0eFJ0c3N2NnlhZXB6S0thdC9IdmJNdWFqak91TWREb09a?=
 =?utf-8?B?N1pwT0RUSVNPMEpqYWhPQTVWMXEwdTZnZVhFV3VLTGVOWDJMSjV4NTkwcW0z?=
 =?utf-8?B?Nk1IODVPUFVwWmNyWVEraE5GWXlOOUtJemkrQ1VwZEJ4cXJ3c0lzN1NBalJ2?=
 =?utf-8?B?WXJMZDZaVzk0UlkzNVJrTHREVW83SjV3UjdMRGljZWphNFZCU0JibE8zZS9X?=
 =?utf-8?B?WmZlYVRVRmRVUWRJWXVFMm4zZUl5TGJMUTZzZEMwZ2lRTFRDVXZNU0JKNWRK?=
 =?utf-8?B?clVZOTNUZ2RCa3dESk4xWklVaWVnUHBFUFprS3JNckZHNDdSZnV3M3VwM0ZX?=
 =?utf-8?B?dVRpR3FmOTJjK2IvRGYwNHBoM2NBTHNGOGNPcE4zUGZuUWY5Mml6WFBKcHQ4?=
 =?utf-8?B?TUM2V2FUelllNEpVcEVtRXdLTFF0bGtaUHpiQU4zN1NaVDc2c29ML2ZlL3N2?=
 =?utf-8?B?MkJWb05SK255VHpCUDVMZm1Eek1ySDcrMmhEQmdta01tTXZhK3FZaGp4Y1dV?=
 =?utf-8?B?d2RVRDNuZ2NKUUxtU3JDVXVEelhOK05MRDBEeTZtNnFUSUJ2TmNvYkJtaVYz?=
 =?utf-8?B?MkZxTmxwT3hVY1c4ajlZWUVyQ2lmYUdtMXk5eVl4b29sV3FiNEVMdnkycW05?=
 =?utf-8?B?c3lFcC9selNFUWF3dWJaYjBZRVdaMU9mZWlZTTVyYnhwYjFGUnRlNGl1dkRF?=
 =?utf-8?B?T2o1RFV2T0V5SlVQbnpxSW80TEZVVWJnNzdreUR4K3ZodHE0SktqWEZ0Skxw?=
 =?utf-8?B?TXRMakxGUWs4SkF6d1N4dmJxVWVzWGd2NzJoRzlCdEE4Y0E0cStPOGlsR0Mv?=
 =?utf-8?B?Z3hsQjNZS0d3MHhYRlJVU1lwSzNBUkNQWWdLbDJIeFVid1lUM2hIektCOXg0?=
 =?utf-8?B?dkV5NllpTGE4VGdOems0SExxUVorQXZzVjVHK0JqeTRPdFJtRFVQOUFzYWxW?=
 =?utf-8?B?TjhRaEFqbURoY29ldTlrZXhReG1Cc2RIUytxZVFHN0swRUUwc0xYaXBtekFk?=
 =?utf-8?B?SG40K2pXaU9TTEg4MTNEM2hYMEFibVFUbXp2QUZqMHVqd3dXOXhmZjY1T3JO?=
 =?utf-8?B?NFIrMjRCZ3RjYks2SUxCcTY1ZzFCdHZaZ0M1b2huN1FrRjJnbjF5dVlkYlBO?=
 =?utf-8?B?TlpBdkpOQzFJOERsU002Y3dxWjJOZTE1L2w5YlhFSVJ4Rjg1ejdBMXc1dmx2?=
 =?utf-8?B?eitINExmdzNmT2VodFBubWQyYXhNd010YkhkRkJGb1h0OExFY0srTUo3U0JY?=
 =?utf-8?B?Q2p1WFF2eDhHcnR0VFdOUyszam5OQ3Y3UERBbGtKUkVUZUZyRU52SXVWdGs3?=
 =?utf-8?B?ZFZXOXNVR0RhYjE3c2pJbWh0Vmdna3FRS1N3WTZ3MXlMVzFxckFueUFXa2dq?=
 =?utf-8?B?YitWYU9SL3RyYmtaYTllRUZGejc3R0lib0pYUmY0SGoyY2ZWcEJUeEZka3c2?=
 =?utf-8?B?REVxVjN5R0xkL0NMM3hMZXhYUVdGMmZzcWhrTHVrYTBrakRIUFZuYkwrajVW?=
 =?utf-8?B?Yys5a1RpMjhLZjlIbk0zdTNNRjhQUGdlalpUSjhlWnpRMWxMY1FTVXdsRzh4?=
 =?utf-8?B?TXVHQjZpOG83Ykljc0g5Tk1uQzVTenpnejhYcGh5NzA1bVg3MGlnRmwySFlr?=
 =?utf-8?B?b3lnb0VoOE9xNG84cURYMDRxZ1ROZWZkSVp1cHBCYXVJeG5ycTlha0R1VCs0?=
 =?utf-8?B?aS8zTmpLOWVOdXl6K1QrdlZEZnY3WUtmd0RNSzJSWEtGQ3Y0YWRUbk5HRkVu?=
 =?utf-8?B?b1U4MUt5VW9nVkc0WGkyT3BKSjB5YVQ3cXUzaVRiVUVpQXlURXRCWUxxWUhl?=
 =?utf-8?B?bndJU1FBRk52TEdtV0ZxbTN1cEdQS3dJYi9YRlliZjBqS0lwNlVyUGsyK0Vn?=
 =?utf-8?B?OGRRMkxWQXlsdzNNVXNvYUllUTlNOXRQNWh4Ly9MdHBzcGQwM2hiMWljQlQz?=
 =?utf-8?Q?p3LeJp6XI1eYPkX58frPK/fEw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bfpzH5OgvTrhao3tdotmXJRxZpXRyHqLJGE1do7i8iqG7I0lcDpU7Tsg191GtkFcbUO45EKC+PvsPUuwr+r1+UpUxFy6ETNrDOcGxBlgBKGgiS597l5XkpsTTzk4eUhRQPKxBxzpOhIH9ichx2pKLp6rBveKZLXTYglhI2AEJwZN/9PX6UK3iGyNz5E0oSZCngj/Ms6XzvPMGEO79e2sx/DNNqzNo+CE1xjT3Tqp5bhHViJpu6ZwZiD105A8DBlgsTXiaggmYQL2+rrqrFT3KyV+wqV/IoOKzKVlp/lSoCTGnDEv+IN5jnkH2reAcw9fx6IGSakGAZi3ZenhTqItETE7Cf6YTDdgH1xX2TEc8Zu7PyqJq3aacFPWq4Uj2WRCDq0awh8CEj4E2xkRbDtEnod18MateSRFrJuETU9ZqwLRMtfCCVWaMq2CQsu0m4ORzinDRHI28edWWARUPzERpecsKzphUrxkWNl76qGht8WO2cSoVGNwTkjGx35W4mAisXrbfzba9NencARSLIPo7IVF5A0flXfBYk3LK9bFIbht010PVaVMZIn8qKUGst0r0pTjgQ5wJidCUoxVdRAdKWlZ6pOZZDtFzAgCv6DNBNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134c8b2b-71dd-4f12-2c1f-08dcd14a638e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:41:00.8911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucXOUbEH5bdK91/MsoxrzXu5EIDWBgbSYzgVXtauwbLLXDr3ED5sNh4aEOJc63ZwmV2/4l+9NV0I2WjkmPCqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100025
X-Proofpoint-GUID: AJNScaYF2GwkKZlAUMFyNp-U1bJQ3RQ3
X-Proofpoint-ORIG-GUID: AJNScaYF2GwkKZlAUMFyNp-U1bJQ3RQ3
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Jason,

It seems this series wasn't applied successfully, I still cannot see it 
from the latest tree. Any idea?

In any case the fix LGTM.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

Thanks,
-Siwei

On 1/31/2024 9:43 PM, Jason Wang wrote:
> On Mon, Jan 29, 2024 at 9:24 PM Eugenio Pérez <eperezma@redhat.com> wrote:
>> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
>> structures if peer nic is present") effectively delayed the backend
>> cleanup, allowing the frontend or the guest to access it resources as
>> long as the frontend NIC is still visible to the guest.
>>
>> However it does not clean up the resources until the qemu process is
>> over.  This causes an effective leak if the device is deleted with
>> device_del, as there is no way to close the vdpa device.  This makes
>> impossible to re-add that device to this or other QEMU instances until
>> the first instance of QEMU is finished.
>>
>> Move the cleanup from qemu_cleanup to the NIC deletion.
>>
>> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present")
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Reported-by: Lei Yang <leiyang@redhat.com>
>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>
>> Eugenio Pérez (2):
>>    net: parameterize the removing client from nc list
>>    net: move backend cleanup to NIC cleanup
>>
>>   net/net.c        | 30 ++++++++++++++++++++----------
>>   net/vhost-vdpa.c |  8 --------
>>   2 files changed, 20 insertions(+), 18 deletions(-)
>>
>> --
> Queued.
>
> Thanks
>


