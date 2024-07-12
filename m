Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5E8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBoP-0000Ty-SF; Fri, 12 Jul 2024 04:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.dyasli@nutanix.com>)
 id 1sSBoL-00009E-AA; Fri, 12 Jul 2024 04:39:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.dyasli@nutanix.com>)
 id 1sSBoI-0000Fa-Fs; Fri, 12 Jul 2024 04:39:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C5UuDY009796;
 Fri, 12 Jul 2024 01:39:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0t0daPBVLXNj0c+5wf/XTsgw3+WLJ9Zldm1yOpw2+
 ME=; b=N/rpoK735lEKp+ZrqqOcq9Z7Fjf6higMlCTEAwhcZ4OVb9yt3Iei5qPQU
 JDvlVd4YpIAIGeyHKKc/T848DDAFv/FvPpfyo6Bf0TWuZtpxtrRvpJs1C9bZX76x
 7X8jm43YAlR5DF8h2s8M+31B4LPE3iiaHkHe9I3C278/5C2f7zbHRk0IfKmOrR6g
 yBgdkC/wvGEYPOSjp3LrpeCdwTjUQ+G8OfCXhV6Ye5Ekul2zqbtKRBKmAnvb2abB
 rIur6K9batpHtbStqEmSjGLtvZQDzeQRUo0hTkZxf8eesINJW2bIS/xXP6iegLqe
 57ck4P0nkvLP2WPIzZ4Ir4Y8kjjmA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4075exx14c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jul 2024 01:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm4lSDoq9OHhur+V2fH4KhnBxSxIJInX4RiYAEazix5wGjJMclNCMaaS1feTg5/G0AfFNQI8/biLwMmqNN7ZvqRxx/2aZK1B9t6hWIUu/mBMwYlmfPTxG3jE/NchI9+voKWfe4Chge4SdE2GoFwpsCha21/Uh4kGbolcGbseU5J5XBo/m+Gyq9HOHlH4BeVOA9abwLHa/JNUqUJgw0sZKjTtRHFmmTIzDLCP9j+oWU/N2tDQ1w0bSUkENvyY96z7vukSz5prFTU7COUqjputrLaemSeDfFtjJJd64A8zPS+JerXjMImY2CswnnFOCHQDQ/NLiIM4QD8BcNRybrxfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t0daPBVLXNj0c+5wf/XTsgw3+WLJ9Zldm1yOpw2+ME=;
 b=CnsoFdXbMWnTGm2+N30Lv4XPYtbebwU5nAXx3B/Vheq+N+zYrPSY87b7ihBpGEEaI8AUt4GK1LN41ZeV2lcuPWXlqW92VRNqnQW3oho5QKdGNGm5AAt66G2U0Xa/bKuS1kdST9udea65qZYa3H7qSRKSx9wir23pPwvOVHkwQcNap0GcRjzv+4TpFfat6H6F2APPP67WZ8fpFp2zmCkLTY3bdgBpy9EWcnrPeyekW7tkFgmROvTTLIdEuF1rKAFHUuLTYmYArVdPJMdlibcWu5j93ule1GizdDEiLtXSZLSvIjQlM53bRIPpfgocS9IFX6M48pYr0uPmR+g/wa8PUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t0daPBVLXNj0c+5wf/XTsgw3+WLJ9Zldm1yOpw2+ME=;
 b=VTI8ZCZTgBeub+wejghcFMPi4LfykEwaYV3ayt4GGc5pWykmvpgJ9AXFktCEXv/go7+Pn37bQxMDviBw/cCmqbPTz8WRUMvfao0nelVQkx0hg61a1fd2g4mxDN9OWJZ7Zcks1RJmg3EvpUR0lvYZJOznrWskz+mU6zmP+GLf5MUezdyyrtKMkjBMJKmFxXKVETAGQ3mfiRYnpDaGWdzz+7iY9TGhSSrM56MQ1z35agCiHKraFBKVzKyf6B7FwrX2N9ez7VnJqPvG/M4sxb8crpxkc773zlcUlTwmL52alk0HJuLkHiuwnTNlDfQgoyjzMAZ6LxgfZtbUltuxgdHV5w==
Received: from DS0PR02MB9101.namprd02.prod.outlook.com (2603:10b6:8:137::22)
 by SJ0PR02MB7182.namprd02.prod.outlook.com (2603:10b6:a03:297::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 08:39:18 +0000
Received: from DS0PR02MB9101.namprd02.prod.outlook.com
 ([fe80::ca92:757d:a9c6:6ca3]) by DS0PR02MB9101.namprd02.prod.outlook.com
 ([fe80::ca92:757d:a9c6:6ca3%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:39:17 +0000
Message-ID: <41b5188b-5cb3-4c4f-ab26-55e21b0b60c0@nutanix.com>
Date: Fri, 12 Jul 2024 09:39:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev: add a mutex to protect IOWatchPoll::src
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
References: <20240711095106.185377-1-sergey.dyasli@nutanix.com>
 <1cfb54b4-0b13-46ef-881c-5acb71fe56fc@redhat.com>
Content-Language: en-US
From: Sergey Dyasli <sergey.dyasli@nutanix.com>
In-Reply-To: <1cfb54b4-0b13-46ef-881c-5acb71fe56fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::10) To DS0PR02MB9101.namprd02.prod.outlook.com
 (2603:10b6:8:137::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR02MB9101:EE_|SJ0PR02MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 724a1b89-cdd5-48c0-283b-08dca24e1e1f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ymh5cDBRN29OWVFCRFhYSS81TmlSckhNbEpxbjNsM3gxN0lOT0k0MTg3c2Vl?=
 =?utf-8?B?dmVRQ0NCZE93RGFXa2VSWVRlTWw4NWZTK242elQwWFB5a203YVl5Wmtvalhz?=
 =?utf-8?B?ZHJ6eDZxY2k5U2ExS2ZFeGhEdnlVWG9pdCtaNXBhY3BPdmdxazJKMS9jQUw0?=
 =?utf-8?B?bGNzUFAvVFlpb0MzaTdVMW95QVg4SmhFRlFtY1hQb2dhQlYvclM0YVBwM3g5?=
 =?utf-8?B?Tk9tcVRmWlR0dnE5QkhwRkVpLzBzNWJTMHluOHE3ZjRhUVIvaE10ZVp2UW15?=
 =?utf-8?B?c1ZjdlZCWjFhSVdOOS9WcVZ2VGxGQk1QMXlKVC9WZFhCWThqYkErM0NUQnlp?=
 =?utf-8?B?RDZBa2daOFE1Z0IxdG50UEVhelI2dnpWR3cvbDdsZ1VDVmF5SUptYktTeGh3?=
 =?utf-8?B?MmxGOTM0ekx6RXA2SENsRmRndUlLNHRBV0JCM3J2NHppV3dGbmFVM0hlV2tr?=
 =?utf-8?B?ZzVNclJLS216SHBDZ2xOdjZpNkpveTVJN0JSL0RWM3htY1k3WnNETTg2YktC?=
 =?utf-8?B?QjBtVXgyYnRZRHJQZDl4OHN2T1ByWUJWdnFpd0xXVjNQWWh4bkdIVXh0d01R?=
 =?utf-8?B?UVM2R0ZhMUtKcmJRem4xeDJOdlhFMDZMMllkb0VMcXZEN25ndlRmM3Z6Vjdz?=
 =?utf-8?B?Wk9UeElEbXQ3SEdmRTBGZy9QcDYwZ05sYjdYSlNRQnZpTGgvR0VlMnRxdE5l?=
 =?utf-8?B?VytOZlgyUUxpN2t0Z2tPeFFYNGNNS1JUZ3JTZ1ljNnNKd2t5cUFPT0ZGazQr?=
 =?utf-8?B?Nmk2cWdoN0t0Y0s2a0l1RlQ1UlVnRVc0T2NZNnJOYTdxRU92UGQrSFZwYU53?=
 =?utf-8?B?U3E5R2RCY1VmVEVIRjVRWlJ0NHBic0d2M0RBdkpLWVRNYU5JZjA2d3k4T0Fp?=
 =?utf-8?B?SHlyRXRIY1VpZjRORUV0dVBHSzE1V1p5clpWNW5nbU54S1MvdHNOL3doS3hH?=
 =?utf-8?B?SlBhdjV4Z1UydHhUcS91bEJCOHNkbndJRHVZQVFEck9icUs3dWYvL3JMczZX?=
 =?utf-8?B?WmkzUmUwcG00djFJQ09lMEdaSUJJMTVDWWptdXA2MnloMEdjT1NMRTBaaTJn?=
 =?utf-8?B?cmlScE1zN1l3Mk8vMFBncmNUVEZWV1dYai9FZW1DaElUVlRHallQMXVyd24r?=
 =?utf-8?B?Qk9lZEh4dGNJMW9LM3Q0cksxcWF5REFMK3ZxTCs2L0JKaytTR0M1eHAraFdC?=
 =?utf-8?B?VnphZUd6Zm1IY0JtcWQvb2NZS2NDTWJrRmlrVmk4Q2pjeGgwc2E1elRxQmJn?=
 =?utf-8?B?Q2FKVUtaQXo3b2FVSHIwV3J5VmRmZVQrTmxGV010M2wrR0lRaEdkTTJhbGlF?=
 =?utf-8?B?dWlaYXl3MWZpVXFWcFJ1b1Bpa0VpY1BobHZ0dXRSMGNHNlVWRU4yUlc2NHU3?=
 =?utf-8?B?aXdmRUs5RWhXZjNGczltZ2swcGtzNFhYUEpYZ1pabDNRbm40ekxScHh1d2FN?=
 =?utf-8?B?VEVGVWdPSnVWRHd2cGVERXJHVUlmVk5UMGVKZ2l4bW1IRFk3YjE5aldLOU1n?=
 =?utf-8?B?bUREMXlWcjhOSXRvc2FObWpMNFNMeHptdHhYaHdsbndNb01FcWtBL1h6VXk5?=
 =?utf-8?B?VU1HY2hhbE5XNTVzSU9CU3ZseloreDlvaFVZazFWSk0rYy90aWJ3eVFYazdP?=
 =?utf-8?B?TGc2a0tUcVZEcFU1bHg3bVJ1cS9IZEIzeGpCTStrN3c3eDlFbEozc1VkRWI4?=
 =?utf-8?B?Z3lRSVJ4dFNsREw1d2pYYnYxWTY0ZUJWSDZVVFpJL3B4RVBjMzdKMmFnMW9C?=
 =?utf-8?B?eGhqVy8rRTlmRERBMjdLVnVoQ1IzdHN1L0M0TWFUN0ZBZ3RzajRsYXFIamJN?=
 =?utf-8?B?b3VpbnBWSmNEQWRxWmIrdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB9101.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFWTmpISFlic3ZzVTJzOFVMUnlXam1RTGVyMFNsTks3aFpzN1RFTzA1b0Vn?=
 =?utf-8?B?cHZ2eWF1YWlGY0Jib0x1TXBYdVpGbjFvQnZLMGRZMDM5MytFSlQwUUNzRkJh?=
 =?utf-8?B?VnUvd2hNZGQzZEZDa1NWak8rV2k2RjhuZjQ1aWJTWjM4MTVWSU52eFUvRHZo?=
 =?utf-8?B?a3RGQ3pySER6dGFTS2dySU5wWFAvM2UxaSsycnU3b2VYWXI1T1RKdnVzVjc3?=
 =?utf-8?B?ZklqMU1tVFpjWlV6ekcvZG9hY3pmTVE2N1l5bnVrUlFLemlLU1pqblI1RU9X?=
 =?utf-8?B?VnhURkZIWGY1dU11YkRSUnlwY2JJMG44S2lVL3YxY0l5WTZUTzdwT01laGov?=
 =?utf-8?B?WUsxUnF0UmZMbjNsNU9LempOdytiU25IN1pzRjlVVCs2VlRHd0w2ZDVqUHk5?=
 =?utf-8?B?Ym5RSTdTQXNCdzNVKzJZNkVIRVVUNmhrUWI3Rk9saVY0YW5Qa25sWUtERzEr?=
 =?utf-8?B?SFpTSlZ0ejgzYi9JSmhOSFlUQjFhNW5qdGVWb2tvUFg2UHcvNkRDbll6MzJv?=
 =?utf-8?B?dmluQVRLcTlqL1dmMlZaeVNrb2RhSzBCSkpEQWZFUVJCK2Zkc0FhQTJTT2ZQ?=
 =?utf-8?B?TjVGRFBmODhGQjcrWE1ueWNwbGoxTldHUjlVY2MyQ0dOMVNXaE5TZFZKaTA3?=
 =?utf-8?B?cHVWMkhrbzdoM1phd25JNzZmemlsTXA2WTQ2NzlhSXE2OC8yaEJ5KzFuNjlH?=
 =?utf-8?B?K0R3NVdQT2hiam9qWXNTRFo4QWo5OU1sTHJoeGQ3Q0JzWmYzY1JkT0NvTklt?=
 =?utf-8?B?elh0MTR6N3RGVmxzeHJsZm50OEtCcGJzSGVrQ3BFN0E0K254eHhrVHl0aXl6?=
 =?utf-8?B?djloNlg3U3A1V3IwUWovemJYNDNtd2FaR0YrbnJ3ZVEvem5pdGx3bzJFK3pi?=
 =?utf-8?B?bkxiNlg1QU5YalZyLzRzRmJJaHBxTURuRXZpU0daWXY3TkVOUGxpSXFYNFZW?=
 =?utf-8?B?T2RPblJ4aEdJZDhsVUszWmY5Uk9EZFZ3bTZjNkJNeVpwQnFTc1djaGdqaWx1?=
 =?utf-8?B?K3laRjI1aXA1akxQd2lEMXMzdFJ0MlgrVzJxWWQzZ2hoQkFIQ3V3bHozWXBs?=
 =?utf-8?B?eE40WVpQa2xhSytTQUFDUWs0L3ZxbGFSZ3I1eVlseG9TYlpqakN5TmdYQlpq?=
 =?utf-8?B?blRTcmxYQXV5NUF0eW5LMTU2NlVwK1ZoUHB6aS9DakNGVStERXg2Vk04UFdr?=
 =?utf-8?B?a0s1Q01PTFEveDVuZ2RPZmh3cTVNZHRtT3FZVEpuaTlOZWI2eGYvUlVhazBx?=
 =?utf-8?B?UFNCK2M4aTZWNG0xUDBiR2FWbDNzeDE1cGNubXg2WkxabzAzR0ZXNW5hRW1T?=
 =?utf-8?B?Z1pzNnNVUFJLWGkrZTV5U0hGR1N2MTkzWWh5UmduNHhYL1JIYmtZbDhLNFpx?=
 =?utf-8?B?WVh0VjBKMm5pUitsOXpFMWJJMm9PNVhUOUxEOTJwTldLNjZJK3JZaHF6RFNL?=
 =?utf-8?B?aDlYNHJFNDVjQUpJMlNwNjE2RmlXK3NJTkpvTjA5KythVTFGMVlTV09hUTdE?=
 =?utf-8?B?K3pua3BFQkJ0RmJVdGNHNGcxQ0E1enNrSCtZbWtsNGdXb05zbGJDeDdIaklX?=
 =?utf-8?B?cHJwbWNQMlpqQ1hMdDFpZ21jam5Fb0VhUUV1RVM3aXBXU0U3WXVCcmU5MDdk?=
 =?utf-8?B?U05mZWZzVS9ld3RlOTlnQUhxQ1JRUHZpbFhJS2R1Y0toNDU1TUZxK2FxelVv?=
 =?utf-8?B?Q1FuWmEzNU9wME9udEM1Uzc2U3dFZUZNQXZnV3NkZG1xdWYwY29iNnJ1TS81?=
 =?utf-8?B?Y0gxVmYxS1h6TTYwNWxiZU9FM2IxaTdvL1gxUi9CSTJkKzRjTnIxR3QrT3lG?=
 =?utf-8?B?YlhKVis1OTJIcUtSZFZyNXE2bjZJRnBYUXNabHllbS81NTFFejc4UlEyNHFt?=
 =?utf-8?B?NlFvWXRTdWZ3RDI2VWpVS3UrNUdGaGJhYWxDcXhhUHJmdlNRZTdxZVM3UVor?=
 =?utf-8?B?aE1MdGQxaUJFK21NelVyc2FUWWNWMDg4bFVCNUI3bmhKSkVQNFQrNXFXS09H?=
 =?utf-8?B?NHpJQXd0SXg5Lzh6ekhvcytSNFN2R1FpdUFITVhpRDI5R1Q0NFd6SzhzR2NT?=
 =?utf-8?B?R0VEMXpjbVJYRnR2VUt6Zi9xTnZDUXo5cjUvblp6K2RoT2paeDEwTmFKZWgy?=
 =?utf-8?B?TXovTmhzU2hLQjNvZEY3MmdmaFpkUXloa2hpZ2t5ak0xdTErM20zQjdnNWxk?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724a1b89-cdd5-48c0-283b-08dca24e1e1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9101.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:39:17.8883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MobZA30k6FRlyAkLfDve98EniJ1LfExBV6cZHQf8AO2/QWxO0TOeQAboAtAJ0R+FMqTeDLv9K0PyPpVT202Sk96QC4TwzYEkdoYKTaddnJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7182
X-Proofpoint-GUID: sRn1SRv32xgtkJ0ySf-XgD5AYc06k-Wg
X-Proofpoint-ORIG-GUID: sRn1SRv32xgtkJ0ySf-XgD5AYc06k-Wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_05,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=sergey.dyasli@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/07/2024 12:23, Paolo Bonzini wrote:
> So I think we should just revert commit 2b316774f60, which is not hard 
> to do (if it works) even if the code has since moved from qemu-char.c to 
> chardev/char-io.c.

Hi Paolo,

Thanks for the suggestion - I've tried it and it seems to work. I'll 
send out a new version of the patch shortly.

Thanks,
Sergey

