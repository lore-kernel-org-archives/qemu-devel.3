Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E293C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 20:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sehV9-0005rj-1L; Thu, 15 Aug 2024 16:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sehV5-0005rE-VJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:55:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sehV2-0005am-O8
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:55:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FJtg5K018534;
 Thu, 15 Aug 2024 20:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=U6kDxdw7bz951mxvn47RgdCtFvinopTa6eD92d8VOv8=; b=
 f3ZtGyLJo7dHoXyqUqdcAoGwSoPVF/g4LYIPKHeZQJ9yi7qtnlgxo6NldC3PEypL
 zHj5HEVlyMawc9IGQre77uINQs4UP6EyFgV7bw5F7C6+ypmJaUQGpRmOmLCqaYfn
 oGx10hbm7EhoF44LsNDrTRUoNXN0NlbK1Ligzfc5NYVHbosQcH1XjHxor0qHEl88
 Y11LQBdt5+e/CHV+eMhvhuoK8rZd2BxwZLmTvl/2qvi0KBaBGZI7xBbjh/aC0Ehp
 2Jmdc0qxEvGYGLuYRrtURGQIUFMYRzuNuH+XVM7aROwpY9BNEyYyuv+tpcFVdD/I
 h3uGHty8VBj7U84iN2evEA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy033hct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2024 20:55:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47FKJLcN003739; Thu, 15 Aug 2024 20:55:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxncm2ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2024 20:55:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNuUsrpxGkbHJBUIwAB0/XRSaBmpkiqBNQJj3yyt88tEwtxXEsqjOZwE9zBJfnA1+xlKMmXeM+mdEFvVSixCxzPweaB4nxthyulS9OryprBejQhNJnKvof/ppxXZPWQAr+A1UQutig8n7P4iO66WiDAGsWDrtOUOJO1gvAlIesgyli39nEKJb2EuSqaEPvOfHlubVd1EX3si7GiJrV8cO3knQd3WSV/MByZzdW16we/WDqbdu3ny68mH4/Ghxi7HpA2Mc/p85hJxr6wrQGedCNlW06h6xbbc+pTNl6z+xDVRDPjwoPAHAaaVWTh55Q3MvIvDLfr/VmcP6kXKCZ6ghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6kDxdw7bz951mxvn47RgdCtFvinopTa6eD92d8VOv8=;
 b=u82o17Rz+AzLy+aPOsDn2z1AxZiif2pct8W9J91gkIUkz/J7w/nPJn0sdanzJvQ3a2+lDcObyMJp0GVN0RUp8Dupd9H4gvVejabcYe/R+AfXVZInjL43o8WdLeUdbF3ocqFvTxrcgqdy9HPysIDxknt8gK0R7q12UfWqkctYy4Deow/UTeLwaxk4ZahRf7tYdaNWWxXagUkS6RVv+T24JWrpcqFHEtN5Z7V+oxTaKIOE7S12mK3AaDKtWefQ6cvIJUMvG3jjoDeVMRu8ykewHQqqwJdOkq//WRiOw2L6YIRdDJSgarjo4pqyTR7LQ5myA/92aQ9bdfHoA7UgaqaTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6kDxdw7bz951mxvn47RgdCtFvinopTa6eD92d8VOv8=;
 b=V/D72IvPGBF/HqUuCE7d0lSYNR411kp4s7/JBgAlIfs6MTo6XU17a3b/h2Dee4k0VmhRBTvPiHttywhWDFX7aolqu330ZJAlF2emyRUBHIXF4lte0pCK93ILlTEzuaY6gkq5aRJSPj19/sGcC1mPKQcCLZn27m4bCTTTUy3+nhI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6126.namprd10.prod.outlook.com (2603:10b6:8:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 20:55:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 20:55:04 +0000
Message-ID: <5f763763-1479-4585-98ce-83fcec03b4db@oracle.com>
Date: Thu, 15 Aug 2024 16:54:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
 <ZpqUGYclrONQEuc7@x1n> <571a4f84-693c-43d4-a43a-52a53a1091e1@oracle.com>
 <ZrvFXCRPczXvCu2n@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZrvFXCRPczXvCu2n@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e0e17d-cab4-49aa-19e2-08dcbd6c898d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVlyemRWT0VVVVBRelVQd05BU0RvQTBxVDNQQ3NsYktKdmlCc3JTNUtSL05m?=
 =?utf-8?B?aHY0ei9nRkxLbnluRmVBVmwwR1A1SjVKS0ozdG90NlBmZFNpU3diRWpHWGRu?=
 =?utf-8?B?RGsrTDI1L2dZNGxLZFJyTXZZRTFkUlBleVFiVmh0Y2FmSmpXaDFkTXNnTVgv?=
 =?utf-8?B?Qk9oQ0ZqUEh5ZVIzZ0dGaTFqS3BaMzA5cERvVFpyRFVoSjNuc0F4Zjk0OFJT?=
 =?utf-8?B?OHltcUlLMHJ5QW1iWE5iaW1uYWIwOVNGVEk3ajJYMWpoNWNpUDIwOXllNlVu?=
 =?utf-8?B?bFJCTnlsWnRrUUtSNmlzR21ZTWxMNHJNZjM3Z2V5T0NsdVc0SlVXQlFVakEv?=
 =?utf-8?B?R0xUQmdweFhvOVoxdmZLWUFkcW5xbHlFQmNUSndMc1BoOWhMWFduOUNSbFhD?=
 =?utf-8?B?OStpWWM1LzlJYUZHUGdUemtKMlBXcmwxRlhjR25RSmFaTlUxcTduTVB1NDU0?=
 =?utf-8?B?NjVqWDJiU1lKcTdXVTh5TFR3d3kra3J2cTZLN0xkdzM0MVdsdEp2OXBCeVFx?=
 =?utf-8?B?MWU5M2ZHQnBRaTBERkJ6NHNGK2tBWTlqdkxyMmppQW5rNW94Y1JGQzMzejJJ?=
 =?utf-8?B?d1MyVDd5amhxYTJ2aXBMcHhoZHM0VUxNU2YyOFAyZXRkUm93dzlSeWV6QnNt?=
 =?utf-8?B?ZnNzeG1tMTJGVjNMd1BobEtCWTdsc3FPOEVDZlJFYncxZVJyZld2dk5henZs?=
 =?utf-8?B?SldOUGpQdmV3ZTlScm9mampVYlBVblVkRkhJOEJSckdKL0V2dzIwYlAvei9E?=
 =?utf-8?B?L0hMMmF1eDhaRllXM2RlSFF6clMrOW5pOHRJMTBiQlhuRmFtNnR2WmpSNlhq?=
 =?utf-8?B?OFNEME5WOXZPVnFWNGc0RjVsZm9rSHE1OEluMXh6dTErRUNjMUEvb09QdUFG?=
 =?utf-8?B?ZS8zTXpMWGpLMCtiNkVPNXhEZUlCMVcyNldwNzNGdlN2YXhMY05LNW1WUDhZ?=
 =?utf-8?B?MnNOSHY4R0FweHdOVUJTWVE3Uzc0S25xNWFsR2JZcnlnY3BpbkYxOGMvS3hE?=
 =?utf-8?B?T3FXWjR1MUJKaGJnN1JpTXE3QU1kUDF4TXZ0NGxUS29rbWtuUkNBYXRuY2ZT?=
 =?utf-8?B?U2RKYVRxbzUza0JWOFJHM2FNL0pTWjk0d1F6eDY2bU5WWU1tVlVSS002YS9t?=
 =?utf-8?B?ekM1T2c2RlpDeU1KT1VNRElJWmtzczd5RU9mSWhLbHUzajhueW1tWTBJdENw?=
 =?utf-8?B?YUVBQUVscGJiTTZCenRtTVltTnJIRllnNWRyNHU1aTZsUHlIZkVsRWpVMTR1?=
 =?utf-8?B?UTZlelFyTkwvb3hRYi9rVFZxcDJ6eEZzZCt1bkFrM2RqcW01NUlodTcxY0R5?=
 =?utf-8?B?OGpqckg5WmlCd0FNd0ZSN3djamJYbUpsT0NpaXBHWC9WRUwydDFqT09Cd0g4?=
 =?utf-8?B?Unl3WVQ1clNBUS80Vk9XSmg5TzNFd0l2aTExUDVDdm5tbjhhdE1PYkhmNGVz?=
 =?utf-8?B?YjFCc1RHMmhKVkVpR0xDWWJ1UnBha0gyWDdlZU9oY1NqNGgwbFc1cXJYR2FW?=
 =?utf-8?B?aU51ZGZlSUJMTDdNZmpKRWdmdWZzU0Z2UC9YMG8xSWZ3VjY5QklHc0NGSWtJ?=
 =?utf-8?B?YkpRMC9KeS96N2NrMEw4bUVxVkJDKzR1cmlBeWhNRUFZNjF0eEdNUWk0aGpu?=
 =?utf-8?B?ay9ybHF6RU40Ymd1aWl5MGE2NEFDTC9leVVDSEEyWE1QeDFGV2p5T2dnVWpR?=
 =?utf-8?B?TjFKSVpSUUo0dSthWDNMOWh5NG5kbVdnMTFHczVZNGZTNzFOR3M5TFhCc3c5?=
 =?utf-8?B?ZEtkL0hHQ3lMQ1k0QUNIREw2T0VNbEdveG9Ea3dGQWp1T2xGcTd2YU56RFo3?=
 =?utf-8?B?ZHo0c2MvajlNM1pzWWRSUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXF0M1EwNWNQTzNaTWkxa3VsbjVhUWVodHo5bnJ2a3RYUStsOXN4MWdDRlhk?=
 =?utf-8?B?cWhZc21WZUo1OVczcWV0Yk5iUEZlZW1jaE84N1h5Sk9XVlRQbENwTlRnUW1q?=
 =?utf-8?B?aUdJWDNQdEpjVzdGUmNBUkhoQmVDOWMrSDJhc3ZpWkZ5KzJnc2xqbTFRa1VW?=
 =?utf-8?B?ZDVJRXBMckswSXNnN3RsSy80TVRTZ3d3REttSVkxakZCL2ZzdWRMSFhjREd3?=
 =?utf-8?B?dHBFVGJVQk54RnlpUlBWakI1bGRNWldBTmlIOEYrUUEzWitnOFFuaTArenRC?=
 =?utf-8?B?VFU0dTY5MVlRdlNmSGlSdS9waVhNcXFSOVNxS1ZKSm1wUUFqNHE4MEZzenZQ?=
 =?utf-8?B?dnpOZWoxUmpQc2FST3hPak1hWmRIYmxnSDdPVzhCM3pEaHR2OHFLdVdnUkh4?=
 =?utf-8?B?Ynk1MTVXVEtCOHhEUFJQaGJsNWRxemFMMGErMXVROXhVTlNFN0FtUWZFbWVr?=
 =?utf-8?B?YlFqVnlmZmQ3aFNBUnQxMjg0SWorNkJmZ01JSjFhSnNwOVY5dC9IMkFiZXY5?=
 =?utf-8?B?YjFBTExaUkJnL2VqaU5yMEk2VkpkbkV1QWlERXZyc053MVJOdHo4dURHUFVH?=
 =?utf-8?B?UGZZdzVmRVg0cHBWTC94SGoxQXk5QnVuV2p1bFQyZSt5NS9wcVNBUjA0eXp0?=
 =?utf-8?B?ZDdpYXg3QU9OL0ZKT2cvYWZGVmtodThVSm0vUWRKN3laQU5VNEtmUE9Bb0VU?=
 =?utf-8?B?Y05JNHZlQUl6TU5xV1dCTkhFK21oY0RmOTJHSTB2cVMwcHlnVENaTFVIUzFv?=
 =?utf-8?B?NVNZMDNmdnVQTkN6TFpJcTBCQU9oc2x0ZE1ScnI1VnlNdkVVYXhyb3ZBdFJs?=
 =?utf-8?B?dFQyUW9Lc2tpdGhHQ1VuL0lDS2hGMXRHQ1l5ckI0NU0ybCt4TXpnM3JtUHlt?=
 =?utf-8?B?eUtyZmRYdVhKcU9lZ3FzVS9aanJ6L2RYblpkcndLUEh5R1lsM2NjY2k2emk3?=
 =?utf-8?B?TWVOUU1xbThDUElmQi9sdzgvYkZ6Y0VRMkJxZS9FZzBveExaUGZ5RDBNTUVQ?=
 =?utf-8?B?RlRtWjBpb3k3RTFJNW05emNIbVhZTjYzYy9aTXNPbkl2V05RbitldWg2ajMy?=
 =?utf-8?B?K0JuLzk2ajFMSzhadEpkZGZWVnk5bkV4OFRLaHViZTdURTdUMUhVMGVKT2Nl?=
 =?utf-8?B?Yk9WdXpqandScENiOERxOTJTMkh1UG5QRUZ6RlJacUYrSUJhVTVOSWVVVnpD?=
 =?utf-8?B?Y2k2eHRkenZ3WjVoZTQvclgzK1BXcmFKeXhIY1NjSzIweGwwNE5BS1ZsdmNm?=
 =?utf-8?B?a3ZMRk1pYTBUR21pQnVweGFtYTdCcDV6MEVyUVJ4NmZJS2ZLODFZM2NDeW9C?=
 =?utf-8?B?bUpJQVFHY3hTYklLM1VrdUxVV3pzK0VvNG93bzNLSWJVTnRBcWZZREtIOEZp?=
 =?utf-8?B?ZVpIYW5qU0N1Sk1PRWhJbnNVcGVZR0ZBd2hRd3V1MGNaNWpzTWFSaC9rZStZ?=
 =?utf-8?B?OWlXYkFnZ3FJTEkyREY1OVVSeTFrTmpDZmxvYUc4NVlZcmxVVFZFdFZCbHRU?=
 =?utf-8?B?ZFlHL1FndTgyYUg1M1dSY3QvVUgwL2FkZllONE0yNURqTGJmMjU5QnA2dHRp?=
 =?utf-8?B?TlBsRkx6UU93MXMwRGY3dmFtWVFyNTExaGp0aDJTMW80TE5qTkpNYUVWOC9M?=
 =?utf-8?B?T3BoSzQwUnZ3N2N6eTA0V2lkbUhxV3d6V0pCejJZM01URTFGVi9STW5sNzJI?=
 =?utf-8?B?RjlrdkZlVmtqeFlYMkJHbFoyZUZIUGxvWGVZbjh3cDA3REkrRVNQYStYcUV3?=
 =?utf-8?B?Y2JMNklaS0MxNHpTODFXY293RXBlOU1ZUlFzNW96cW1uSXU3UzBkUjFaRGFG?=
 =?utf-8?B?VHdhazdlVEltRDJ4clRqSjJ2QWJtMGFUcFVtVjI1dW5TVGhJV25yL1BDYURn?=
 =?utf-8?B?dUY2aXFHZTNxa1o4R3pVeUtTdFEvL3JCdllFUUgvZU1nb2ZLN0QxcDVNMjlo?=
 =?utf-8?B?V1M1UWFzdWFySEtkRFJYMy9hbGlQRDcwOXF0ZWwxb0NZYkFXK3RQenF3c0Fo?=
 =?utf-8?B?UmFaaFJXN3ZxOCsvM3VvSjAweFF3dGhJWDE3cElGV2RZSmp0QkRveXY3bFdC?=
 =?utf-8?B?K0ZMZGNHUk5nYTkzZXo5QUdodzhtdytSQzhFdWtkbnNnNTYyVmQ5NzR1S2ZZ?=
 =?utf-8?B?U2FDZ3ZrbHVVNHhNQ2RaOWRPYWN3MjFZV3EwVzNTdTJCQksrZE5yL1orLzNF?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AqhFg3HRQL1Q7m1O5o65kI4oL1F5DtWxxdr0+IdaBSciLCaAjlTHU/dKIPFSU44GmLvDo5usJqmz0v4XbAapDtckcISz2wh85FVgb1aV7V5CCOoRSxVpmaZWyZDIpNx57D1z9P5Dwr2K9WngTlj0v9HJDtvqyfWjZC7zEEC9N6EEOQmnNTpHPR46NDPFAwRlbAozTT5+0tOHXAJJIWAklPkGiItSQ8+WdLXWMkoqkFRnibS9wVwUi4Sco7ZqVQvONX9B2MK+uKChmtglFP/eMnfyvDfAg2JtxHoUdLodq70pQhscw3GKDK6X1Mnt9Sr9b5Or9peETxvfE2tdf6F+hyqdy1mEwxTO+dCOz+R7e3zSfCGAKsx+kbLrnkeP/aGCT7mK7BnwHRLVpgr3OQSewbo6cwC4uccHQ+1DhRl9uWulio8MaeBKTBfXVV3hj/WCsDQZEHM4EypQAo85ug80fkWqQfag1Pq8zQHSprDpJM2e5pPQVkrHH1fOuQ8OnRm2qp8LOcKeCrO7IDa41fN2cqyP9fJ8H2cC0EtG98p6SS43QFW283LjY6pnIs4MW5fb0welwTWQEl94yIF9GeYQjzV4cUFJ6T8X9ZEsDpyh0DU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e0e17d-cab4-49aa-19e2-08dcbd6c898d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 20:55:04.3378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OZPTCuRS7XdLf3Slv0gdUXz8FqmHvF18lG2Tv7oJYgpw9tyCAMm+FJ9qWjJEtBOZEAf5P80xDGRpU68dbSpxnQQGtVpAJvt3+JouEpk7So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_12,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150152
X-Proofpoint-GUID: jN-fueiGuEllNwioI3UDJAySkRPbwS9s
X-Proofpoint-ORIG-GUID: jN-fueiGuEllNwioI3UDJAySkRPbwS9s
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/13/2024 4:43 PM, Peter Xu wrote:
> On Wed, Aug 07, 2024 at 05:04:26PM -0400, Steven Sistare wrote:
>> On 7/19/2024 12:28 PM, Peter Xu wrote:
>>> On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
>>>> For new cpr modes, ramblock_is_ignored will always be true, because the
>>>> memory is preserved in place rather than copied.  However, for an ignored
>>>> block, parse_ramblock currently requires that the received address of the
>>>> block must match the address of the statically initialized region on the
>>>> target.  This fails for a PCI rom block, because the memory region address
>>>> is set when the guest writes to a BAR on the source, which does not occur
>>>> on the target, causing a "Mismatched GPAs" error during cpr migration.
>>>
>>> Is this a common fix with/without cpr mode?
>>>
>>> It looks to me mr->addr (for these ROMs) should only be set in PCI config
>>> region updates as you mentioned.  But then I didn't figure out when they're
>>> updated on dest in live migration: the ramblock info was sent at the
>>> beginning of migration, so it doesn't even have PCI config space migrated;
>>> I thought the real mr->addr should be in there.
>>>
>>> I also failed to understand yet on why the mr->addr check needs to be done
>>> by ignore-shared only.  Some explanation would be greatly helpful around
>>> this area..
>>
>> The error_report does not bite for normal migration because migrate_ram_is_ignored()
>> is false for the problematic blocks, so the block->mr->addr check is not
>> performed.  However, mr->addr is never fixed up in this case, which is a
>> quiet potential bug, and this patch fixes that with the "has_addr" check.
>>
>> For cpr-exec, migrate_ram_is_ignored() is true for all blocks,
>> because we do not copy the contents over the migration stream, we preserve the
>> memory in place.  So we fall into the block->mr->addr sanity check and fail
>> with the original code.
> 
> OK I get your point now.  However this doesn't look right, instead I start
> to question why we need to send mr->addr at all..
> 
> As I said previously, AFAIU mr->addr should only be updated when there's
> some PCI config space updates so that it moves the MR around in the address
> space based on how guest drivers / BIOS (?) set things up.  Now after these
> days not looking, and just started to look at this again, I think the only
> sane place to do this update is during a post_load().
> 
> And if we start to check some of the memory_region_set_address() users,
> that's exactly what happened..
> 
>    - ich9_pm_iospace_update(), update addr for ICH9LPCPMRegs.io, where
>      ich9_pm_post_load() also invokes it.
> 
>    - pm_io_space_update(), updates PIIX4PMState.io, where
>      vmstate_acpi_post_load() also invokes it.
> 
> I stopped here just looking at the initial two users, it looks all sane to
> me that it only got updated there, because the update requires pci config
> space being migrated first.
> 
> IOW, I don't think having mismatched mr->addr is wrong at this stage.
> Instead, I don't see why we should send mr->addr at all in this case during
> as early as SETUP, and I don't see anything justifies the mr->addr needs to
> be verified in parse_ramblock() since ignore-shared introduced by Yury in
> commit fbd162e629aaf8 in 2019.
> 
> We can't drop mr->addr now when it's on-wire, but I think we should drop
> the error report and addr check, instead of this patch.

As it turns out, my test case triggers this bug because it sets x-ignore-shared,
but x-ignore-shared is not needed for cpr-exec, because migrate_ram_is_ignored
is true for all blocks when mode==cpr-exec.  So, the best fix for the GPAs bug
for me is to stop setting x-ignore-shared.  I will drop this patch.

I agree that post_load is the right place to restore mr->addr, and I don't
understand why commit fbd162e629aaf8 added the error report, but I am going
to leave it as is.

Thanks for reviewing this.

- Steve


