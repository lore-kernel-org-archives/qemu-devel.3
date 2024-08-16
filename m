Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A74C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seyeD-0003T8-0s; Fri, 16 Aug 2024 11:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seyeB-0003Sb-Ff
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:13:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seye9-0007Yz-GQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:13:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GC8txg004063;
 Fri, 16 Aug 2024 15:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=wQCmyvTyBT4sM7N52byokgE7EM7y0OquwFrXEmb4CWY=; b=
 DMT8oAcQojbU9gkxMNCtIQe1LxoBQd6tvzX/vGXWNHUMDLIqTwlRvvbSDBeidJzn
 XJiOyJa8lfjENHTa9arEj7lOVNnLUIOIcFnljyfK2WkPDW+8Ptd1bFU0tNU/d1BV
 NWwDFJ8qVeDlCNtJZ3F5JqbmkhcNC66dZRL/mGlSzgeXbrhMSUbNyUhGBlo6jHoC
 QoZpPlRt+N8PW2IOhygn5C2Ar2C1vApXheX49IeZzyLV43kPbnnV8n48U35UutWq
 XodW+XHTJWOnGqZTK1OAWoLrwi8NDd//p+7bSasQ0CfAyx1iMZNs4XFA0OdH0N6M
 tJZ//LlkRxFEcQ0Z7zfhTA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtvry3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:13:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GDb0DT000610; Fri, 16 Aug 2024 15:13:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxncd7ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGDmBhylg1JhTr9HaEzF0M9HeGgkQFjFHJbrV4GlswPqbzovbtCn9HcCOWWgNAvb0ALXqP9cEnDhjNjgBIpeedvuYRm7VfYXb3lDK5wr2v+6F8HY2Xrzi5tQhckFRGjwB5QDRGLseHtR16G32sMoUMP0564drrRQ53B5Ivna8EOOg3qphsUFj+f7MZXi0G7M3kh93xhSkiSTBcwGX6wnWiW7l44N+8oJi2n3zqN/vsQ3MxQlp+13pgNusSIZ4gVXfWDgfJ9ItnGEP09qlPU5+D/RkedtcFnoUAobpsgoCPWcM7uMPjqdercHxcWKS/RrlDwvAXq8WSyuCbIzc6O/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQCmyvTyBT4sM7N52byokgE7EM7y0OquwFrXEmb4CWY=;
 b=dhi4Z4uUUNF3244bWvImyCLxgLTIEKhMwG8vv44XBkT2OAsdSgmNdblGdonc/j9huSod1oltY4ldLcVUCsNH9NOlmzCw/STjbcE0bJ8iP+xJer/ErPDSw54nN7Y3sm4KG9dAjxePP2ShMNPUgmGAmRug9hNJvRxCvtzq+UNQtnyLGDlMjXh96noghhLptLv85nmEGrzlXrF3JpqF3NYGLIgk1AXW7iwdlDtetCbuNyMT2pU+zt9emtovo32XVxmagtUOstXUeyskhpglogvvNYZ64kNcvGd6CK0a7x/iRQwhAzidXm6LqWHgVfL9pmRfG4oRIdQunK3MMCCvQ/Z4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQCmyvTyBT4sM7N52byokgE7EM7y0OquwFrXEmb4CWY=;
 b=RVYt2E+/JxsKJAirGAcBdQKJ7+sbnimO7whTZVVQEEk3TbuHX+xX1lfRrbxRuL19KlCds+AkJ7dXLRIvNA6jCm5po43OOJ4vbXoFGIx2BY0GIDwZoq6P1ApC0WU8pmmdAvMh1l9+Ka6jeel/cg6kxTljHeQTkszk+/SOPcnQ8A4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6452.namprd10.prod.outlook.com (2603:10b6:806:2a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 15:13:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 15:13:40 +0000
Message-ID: <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
Date: Fri, 16 Aug 2024 11:13:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n> <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr5lC9ryCsn9FjE2@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: fad7eb38-dda4-40b3-92aa-08dcbe0602cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUkzRjFpa3EyQ3JQWlFOaUJCVGh0RHhtUXNpZkdCZGluYUtKQmVFQ3pBbGYy?=
 =?utf-8?B?R0dpT2VFWmdpaG5MeW4vaHRuQ3A1MXRBdXRQL0QrNStYbjhwYk1pRWlZdHh0?=
 =?utf-8?B?cHBlSjhaVW5IaE5hSVpnK1pDRlFvTWowV3VMLzIrcTI0UERyVkVCVHdZQzQ0?=
 =?utf-8?B?byt3ZHYwYWp5ZDlmeVRLUDdxbXdEbUVubGU0KzBhRmxmZGNPZ1p6N3hYWmMr?=
 =?utf-8?B?cGJCczRvcUFtN2hWd1VWdVNidWo1VWxPdVd0US9ocndjSzZobndEdUZmTDNC?=
 =?utf-8?B?eG1rK05wWVN1cDJkeUFzMXJRTTUrRXdrU2RlV2syRjJhSHdIaUdsQWVSUXBk?=
 =?utf-8?B?TUZuUmhDazdNZEpoZnFlKzNtU245R3JidXFKZTFzK3BJZEYrSHI2L1lNL00y?=
 =?utf-8?B?M2t2RDlxeUNmZ2RqS0gwcjRVTjRyQytxWE5Ic3BHMTJnenNmb1BxcWVaWU12?=
 =?utf-8?B?Q1dFaE13b3BTR2hkOHlDRlVVd2REa1FVUGRxN3o4eTFFay9uRGlaTlBua0sz?=
 =?utf-8?B?aGh1Vnl5bElzSXBidmhIa3ErZEtYTERGNlZUM2pjdDVEODUrdU5HdTJYM2NW?=
 =?utf-8?B?UXRBY2t3SWNNWEE2QWVuOVhheXpFSXZYanZlajNpdzN0V3B0bmFXRkxPVnNK?=
 =?utf-8?B?WEVMb3hvSHFtMGlqd3V1dGdNalk4Ykc4Ky94QkhnQXZ1T05Fc2llTnJ4WUs0?=
 =?utf-8?B?K3MzcHMzcmNpM0xqUVJaRGYxeWsvMFN1V25WcDlDaWgxMkpJaW10MFdPQW00?=
 =?utf-8?B?TnJONUZSbjBBT1Q0VSt1ZmREcDZ2WDhYWnpNcWtBS05OTHBGNmx4U0NnZ3Ev?=
 =?utf-8?B?NTlmZllLS2VzMnhVYSt5cXlBclFHSzlKV1hmRjlQckNzUXBUM3lrQUpSd3Bn?=
 =?utf-8?B?UTB3R0R3S1dWQXl6U09SNVo4STdhdjE4UVZPUFJJSEVoWjdQZHJxZFZ2a2lq?=
 =?utf-8?B?b1R1TUNjMkRmM3NFU25BeUhibXFDUXB4ajBUd1lJdjVSTlIzWDVCeDk1RUhp?=
 =?utf-8?B?dXI1bEI3clZrMEZSaDgrTHpNeVpZcmczajhFc0dNa0h6OTkxcWVtdGtGaGQr?=
 =?utf-8?B?ckc2Y0dFU3ZjMEZNaXd5T3VzVElWckc1NzZicm9NanYwcURIQ2d3ejdXNk1i?=
 =?utf-8?B?OExjSllQUWE3VWtzN0VTSGFEaTk2Uk5TTkY4VU9qRnc2TUlBckZYOFJhMExE?=
 =?utf-8?B?dDNNTjBDRTdtYU82WXRjVDdtS29kS2cxUnlsWTBNY2N1a0FiNGVUbUJCUVUy?=
 =?utf-8?B?Mk1IT1NEcThRTHJZUnhjeHRhYXFkT3FKd2dwNGxodnJ2cDZSNTlnemI0SXhs?=
 =?utf-8?B?TjJKNE9NNFVxMVNVcjBKcTRXdEsvdEJmNkM5aklLMjA1RUIzb0FFWmVGb1A0?=
 =?utf-8?B?UzByTHY4YzdTMU5VU3RvZVlPUEFkT1R0ZTlvSVFhQmtYNktiZ21wUGduR09S?=
 =?utf-8?B?dnY0amEvTmtpcE02YjBlaVQ3djVOam4zYzBXK1FGRkt1SElZUm52ZktIcElo?=
 =?utf-8?B?ODEyd0tRWGFkaExXaFdLSUh3WXJDaUZJeTFTQ3NPTzdNeitpQnRjRWFxZWZK?=
 =?utf-8?B?WG1ZUGhzYVlJKzdKYVNvaXBHbkhtZGFXcjlLMUZVUGdJMVVWU1lib3dwRVVV?=
 =?utf-8?B?NC9laEZ5R21ha1lzTVpJc0dJV0FKWEtpMkdGR2JmSGJ6SUw3ZTViYTVvRHFM?=
 =?utf-8?B?K2FJSytpaTE3RFNIMnRYcXd3SXRVUlBYS211citxaVN3bmNZWlZLcE9HODVR?=
 =?utf-8?B?MklqSzBIQVFKck5FWnUxbUhPZEV0cXNTVkJkakNrRnhZM0pYdEVhZ1M2aXJH?=
 =?utf-8?B?dzFDUGNRQVh2VHowQVdSQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVdsOTlUWEFjR0JqdHoza1Jlb2VvemdTNFRiV0VQUVR2UWN1MTQ4RHc3dGor?=
 =?utf-8?B?SUI2WVNGMHB6blRSRnBOOERhUjJNaHIxWXF1aHZBWERod1l4TVNDQnpsekpV?=
 =?utf-8?B?QTdobnFjc1dtaWhHdGhxNXBJS2RPd1JWeWJ2aVJKRzh2dU0weXdxVVZSdERa?=
 =?utf-8?B?V0hXVkVKdDh0eG5qMGFkRWdwa205amdGeVQ5U0tpMi9nd1dvMkNNYmVKbURU?=
 =?utf-8?B?aStFeEZJREc0U3o0V3k2Sm80d0hnOG9LN2RRcjFwcHF4VmdsT21aeGV2M0dh?=
 =?utf-8?B?eXEycDByZEpvUmtua1REaGlzNXBncUFSa3N5SURNazFtMWI2a0puWVhKYkJN?=
 =?utf-8?B?YldudDZzb2FpazV3QlNSeFlXTWtWaG1lcDhjYjFlQ3NucEl3aWptcVJDYXB6?=
 =?utf-8?B?RVFqYTlDR0JRcHRDcmpieFpkUHpDcUNtZU9TVU9SenpreHpVcUp3K1BiRFV2?=
 =?utf-8?B?a2dDQ1FOMmlOeXdmWU41NVJHTTUyZTIrUXlHR0E0OEdSZkxUR0k4Rm5LK3Yr?=
 =?utf-8?B?YkxPalhCd0V1Q1FBbG9yRU81K3RzSkYyU2d0ZDVpdk9tZE5LNllsaUs0MEJZ?=
 =?utf-8?B?MUtaZ1ZPclpBenllUWRybHAvdHcrVGZjZFE5SFduKzY5a2xqSkN4SnJtVlU5?=
 =?utf-8?B?NVJPQkVOaHVhbzlQRDJhTzlBK1RBYzZ3YThGRFhhc28yZVdNWnQ3YWtucHBi?=
 =?utf-8?B?N0xWc3JYUnpMQlZGYmtOSmZqSG16N2hoNFhKZzB2aWk4WGdVa041QkZuTlJn?=
 =?utf-8?B?R21CQ0cvUlp4SEg3dlpqV1M5SnJSTkZnWkgwMGdEc2E4TDZXa0VMTHlxeVh6?=
 =?utf-8?B?bWc1dnE0TUZpV2J6cUhuN2dJWHh3Tm1zdnR6Q1VrKzhIYTlEVGNnZnVRUjB2?=
 =?utf-8?B?NTl2SW4yeDdSSDdlakQ0RFEraG5LNFlXNnpvc1lWNFFxajYxSTN6ZTJlSERW?=
 =?utf-8?B?eVhXd3UrbE9GOW9IaWF5NktQaHM5d2szSkFENXJNcDB0UjZoc2dOUWt6V2xJ?=
 =?utf-8?B?N29NT3gwQXl6RGZ0d0w3ZDk5YmFDeHZvWGNhYUhOeExLK09HaUNwU25XQkdo?=
 =?utf-8?B?Sk1VV2d4OTAxcklWYW5xRFVYUnlCaWxKZW1CY2NwQWhBd0VjL1V5VzB6c3o1?=
 =?utf-8?B?V1Jtc2s1RWk2aG5hR3pNUjNoL3pBOFFyazYyekh3dTdoZ0sveWVkelJwbjdx?=
 =?utf-8?B?UXc5VlFhektETGRscXlhRG53RTA4SUFiWXBVdjdxcXpsblJyYTUzSzIydmVZ?=
 =?utf-8?B?QlpFWTg0K3ZBUk1UTGRFQ2pmSkdmN1ZFQjc2VjhtNTU3eFZZSmVvQndoMmE1?=
 =?utf-8?B?THFTaDNFU2VJMjJQWmkzQUl5bnM5SCt4cjZOTEwvZjBYOXk0RWZYaHpmN0dZ?=
 =?utf-8?B?UkYxdkNNU2h1SHhpK0pEMU9vdThoYkIzMG5VT2Z6UHpCSUttYnFKMFRtYnBC?=
 =?utf-8?B?K2FQeDZadjV3cElQK016SGdYUWt3d0NKaDQwckJKZmhDV1RGdnpjMnA2RzM4?=
 =?utf-8?B?dzBSck9hVHFsOHpGT1Via1NCd3ZFNjFiTU5VUHM3Q1kxd1lCMHZXUWZ3QVdu?=
 =?utf-8?B?THVaUVVIb04xVHZqMW52RG5qKy9aV2NObWt2blNPeTF3eFVObzd1SHhmQS9F?=
 =?utf-8?B?dFcvekg3RmJiQU1Rd0JjZXlEdStIMUFNc1JOOUxKQ1dPUjhVN2NWckJlNEow?=
 =?utf-8?B?MTFSUmg0YlJRNjRJN1BDTjUyRXY4clhURmtrUE1XenFxaHJJclB6M29scFZ4?=
 =?utf-8?B?MUd0SzNkZVN6RG95amE4akpNNy9oRzg2OUQyVVk1U05TQ1dza0xadzg3SzZr?=
 =?utf-8?B?QkgwdTg0STZxRnRDTmNYbDFTbW9XTmpVT09hUDVoVXRDZ1lpbi9ZVzNKWVE5?=
 =?utf-8?B?cUd2MzRrK3hXRkFVS2hReHc3bmpHWFZORXc2akMzVjJJb000ZzNqbFpxcUJ3?=
 =?utf-8?B?MG42V1h2MnB2L1pha1kwdWVRb2tDaTNuWDVkWXBISkRoV0NMbGwvSHZJN3B6?=
 =?utf-8?B?dEJUM0doY2VNcVZiZE1mcWRFYVRoQ012cS8rR0w5MGo1UVB1WnExdzgyT0tL?=
 =?utf-8?B?eTM1NlNRMEZqSUVxUU9NMUxNcHhkYWQ3TkVlbTN3Z0tRTm9oMllZcVUxendr?=
 =?utf-8?B?UVpEdkhVcHlyejZmd2EreXA3eWNxWXhZSVBTS0NPbVV3VytnbXViblB0T0Zx?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 29PM/YhcA3CoE3gyVL3MWZgfFo+Ymjxj+b3ET2/9AeHJ2MUT8FQRhs4IgHw3xOiv83+4f+sRc9xNHwsMftEDwwqXCr4K7peZS/tttwt4PPxOBI0jzpHJ8DracQ0r7hgQhLZ6FZ3Blsrlaya7SfWJ1ket4z+d1lP5GultEm1LafOGln5DTAi3U/SwglYNYDdRQ7SeGi7T2/tCgpwMCjVpASWtgRME3ybSKYR5jE9VhwBduH97PLQx/wYSXjE+CyhLDgDGI/uthHiEAlt8Bm6yvZXn6SsShuRqViNFBYBoy94WqfnMJyTEPlCjYme9NVqLFbKhqqYN5+97udXwC6W3M4RF/DLYn82wwtTtUtpcc9tb+YWHeRSOB5mVfgMPpIs7CxYHXvNv3hb3+wtqXhQyR7Bf9t4zp9APkex8XeSdvjeIsPv5PDieMoLkyEIBIZWYrKbpTrXcnna8fJHaRJLnJ9i3PfWXn3GLLZLwEHGS+V7IDQ9gA7za0mjD2LYOxAOgq+QPZTQkZe6+Oo69+4eIVHbd1Ic3tDFVhG4rbXwfu99056xZzB39X77ey93vA3ZilySV3Bau6Hi6bk2G3CpOVJSWOTUvUEQ2ix/qVrPZ51M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad7eb38-dda4-40b3-92aa-08dcbe0602cf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:13:40.7472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beOqArm+bPEvzE4TxGJuGCrRXYPkc4dR+41aouSHR6caDGoN1tzcYaqX8iE33yBxulefZbo/K9tgSEj5VihV2GajZLspbdPtbShLbzvw9PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408160110
X-Proofpoint-ORIG-GUID: Z1aK9d2Fho_W8ddXW20Kv5IDJGlqV-HX
X-Proofpoint-GUID: Z1aK9d2Fho_W8ddXW20Kv5IDJGlqV-HX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/15/2024 4:28 PM, Peter Xu wrote:
> On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
>>>> The new user-visible interfaces are:
>>>>     * cpr-transfer (MigMode migration parameter)
>>>>     * cpr-uri (migration parameter)
>>>
>>> I wonder whether this parameter can be avoided already, maybe we can let
>>> cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
>>> in the same channel?
>>
>> You saw the answer in another thread, but I repeat it here for others benefit:
>>
>>    "CPR state cannot be sent over the normal migration channel, because devices
>>     and backends are created prior to reading the channel, so this mode sends
>>     CPR state over a second migration channel that is not visible to the user.
>>     New QEMU reads the second channel prior to creating devices or backends."
> 
> Today when looking again, I wonder about the other way round: can we make
> the new parameter called "-incoming-cpr", working exactly the same as
> "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
> be reused for migration incoming ports?
> 
> After all, cpr needs to happen already with unix sockets.  Having separate
> cmdline options grants user to make the other one to be non-unix, but that
> doesn't seem to buy us anything.. then it seems easier to always reuse it,
> and restrict cpr-transfer to only work with unix sockets for incoming too?

This idea also occurred to me, but I dislike the loss of flexibility for
the incoming socket type.  The exec URI in particular can do anything, and
we would be eliminating it.

I also think -incoming-cpr has equal or greater "specification complexity" than
-cpr-uri.  They both add a new option, and the former also modifies the behavior
of an existing option (disallows it and subsumes it).

- Steve

