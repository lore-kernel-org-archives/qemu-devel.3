Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22069CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kF1-0007ZP-Ne; Thu, 25 Sep 2025 07:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDa-0006X1-Ve; Thu, 25 Sep 2025 07:33:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDO-0008Km-R2; Thu, 25 Sep 2025 07:32:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P5jSgx2261157; Thu, 25 Sep 2025 04:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9Rmgt4jhDSLQuvx38Y6YnFH4U60QhZrlg7PHo9q10
 H0=; b=XJdR0cBwB7m7UArlo//JumadPtl4RpCULFaXQQuR5mXcQa1S1rXV0oNBk
 eksg5Akkd8w7pbQMvyNwuhFCIwDHZVcvu1XfjlodnCd2DkElJc5iHwTFi2nqTuEF
 W/u+ubcYhpcTszNMnWcgTHbEBhtEo+QfmoGNxZ13aHKeP2IDpojhvOX/HZk2u1iK
 8NG4xnjOCXUcgSN7ToeaTJrrQzsA+3HVzhDV7v8Fkz7olTjEyaxBBHl5JZgL25mL
 2+P29v8SlZu1Rdwe+oWhK35iQc1LrQKTCQ2FUynP6hJO7/+G6G7cdak/zb20BlHS
 z3FhdTepA7bjdq8f47afQM68u6GyA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021142.outbound.protection.outlook.com [52.101.62.142])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cm7ra7vn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YemwRWAxyC3vUI1eeJh10Y5/qd08wQ+6EiYU2ByLvoDQ3S1lhSMiFxVEib4MCMKNfkbi2ufM/6v7i1fLvRVBrY8KTGTAdGG1ZFRV2mUOZT5wtVTHauP0q8i4o51lrFqnJh/9LZFFw3YpAQEijeFaK085GpYfFe9KJGhyBTcDYGS2EqVURrXVjtU2WfsLdEdcqly+2t56eecfbOTFmeciWx/BQVeni9x8Qead11d68G9EBtB9kZv+gCxhR5VY3BfFsBAz+vUx3id7oQtcvv4tAyQMxXfkiHEgFa1O0fEp657qqzW9ZcT2nwdLJhpxr6SyKeSIBEs19t8XFRLNfYNHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rmgt4jhDSLQuvx38Y6YnFH4U60QhZrlg7PHo9q10H0=;
 b=vVjGFslLSdBJUXL3z/xrJ+MNuZb+XOrx3baNFzHKHHCIJvJXReTu+XMWZvTbhJFuY0P98L/MygeX/24SoMciz+IohFNpiNtTdqcPJ+qzf32J2O59R7GgNMwbwYWvrazTn5bW/4zKZYTfGad7CZ8/i+JDCegDcAzjnJ3wfGDTMJhs3KWK9YIpWMKOuOmKyyPTyoQ+FekgXCf5eabkWyIAbxJx5/fYVFFm6X/5Ho5BZllZgX91+dhSFwA6DlR3vCYPrQAun9ZlL+GsACkq96O8pdqe9GrOCjO3vfwxYUyEsGOjcd0f7V2g02273LzOWg+b/iZPETWrF5skBBY0yiaGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Rmgt4jhDSLQuvx38Y6YnFH4U60QhZrlg7PHo9q10H0=;
 b=iTqzhPja3Lmu3W+5sPy3FlNHEbLOSMwDAP7KzLAkoYqUg2nCJ5SdMxxoUvjcRaOT7cpElGg/2+O94Tdwjd6U3G0e0lNXmq45qNcjP15NwrdMtsD17bNi1YXWEESDVTMf7C8vb1pnEPQuyZRUr8VrjGKY6nGg66bwWZDpkkZOhFHO0iuMmbhaB0KXpdwIdTohtwBOpw90qC+Oyz/r682BMnmrKmENHnjmzxVavssmIlZhESAdrheX8PFcUpLI9nspJR46QUwZdXH94Czh1t0q8HOvYjfjO6k92AS463Na5urK0e6cMrnSiGt+pdmIagOH+XT3vGgfoTVe/iOg+gz/jA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:33 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:33 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 09/28] vfio/vfio-iommufd.h: rename VFIOContainer bcontainer
 field to parent_obj
Date: Thu, 25 Sep 2025 12:31:17 +0100
Message-ID: <20250925113159.1760317-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 1460ec27-cafd-4411-39b1-08ddfc273811
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFh5dlJZU25EY2FBU2xMaENLanFWV1Q2VlcvaE0rSCtrMUFnK05icStkM2hx?=
 =?utf-8?B?dUQ3ODdRdUJydUFoUmswSE1YdWJ5RkJNTGNkZDRlOXp6Q2tHOTYyeXNWbzhz?=
 =?utf-8?B?WjhIcVh5am9oNGlqMXBwMSthNUFPNU5vNUY4cGMxT0p6dnhhN3pzT2lsNklu?=
 =?utf-8?B?bkY3cFlpMVBCVkNRQ3p6NnVIQWNmZytpVDVZbnRKdkF4SDBnTUlDajlkeWR2?=
 =?utf-8?B?ajlJMm5KWDhWWGUxeUwrQnBSYTZQeWl6cGw0bkZtSkNZanpzeUhYRUUrZWNN?=
 =?utf-8?B?TW1oVzNvSFQvdUgvVlhCdzlpSFlIV05tZEN5ZmNQaEpNcDYxMU1NeDFyWFZD?=
 =?utf-8?B?OWhaREZtaW4rZW1tQmdIUVdheHZ5OThHR1NlaTRzSjRReHVIYXRJcTZQWm5Q?=
 =?utf-8?B?MVI3ZVd6ODBxYW1rbjRvSUF2R1B1NHNZQ3gwZUdDRFpZQXk4WCtuZEpCT1h2?=
 =?utf-8?B?QmZsUE1rMmc0cWFaMUY2OUNTbHZLazJNZlNTOGRyazZEN3daTWg1cUlBd0tm?=
 =?utf-8?B?d0YxTlNCRVhDSWVHMTRkT2VUbHpOVWh3czFoZzF3UE4rbGxnbS8xRlNSbW9i?=
 =?utf-8?B?VEQ5cDIxcDVabjdWYVVPS3lZbjNkQnF2VUVRenlDVVlZWW5NT3B5MTRqU3FF?=
 =?utf-8?B?dm1lTW9WekNDS0JwRm5Wa2lWTmQ0MmZSNHFSVVdPM3IrSGhibVN5ek9xWito?=
 =?utf-8?B?M2x4cHVVdkJ5ajRXK1RLRGgwUFBLUlg0bWdTNnFJRVVkT04vV2R3Wkg3aGdO?=
 =?utf-8?B?YjlPNHJnd2V1b2pDbVJ1TGNPNGEzdVRkMmxXdStDc1RrMTkyZE5kYnFDdzhl?=
 =?utf-8?B?UjJHL0IreXZTVGFLM2NtUVA5aDR3cTlZbklJQmsxdDkvbFVKcnpsd0ZDdHZV?=
 =?utf-8?B?ZFBBR1pCb1pndVdDc3VkWXlsUkxVU0JIeElHYWhOWGxFVmxIUFhpV3B4Y0JE?=
 =?utf-8?B?eDBsY3BybDhRVWZmVml5Y21KL2ZwZzN1a1JmU3JpdlRheUZyYlZmSisxNXRN?=
 =?utf-8?B?VmJ1UFlLRzlqNGRJSklIcnBxMFB1QW5mSkdBRlRzeklqSm5oRDZIcGFrdXpj?=
 =?utf-8?B?YjVVUWRLUVRLU3dQWUozb2FCOG5EMHNyVzVIajUzRTdWMTZKV05RSG5nUndm?=
 =?utf-8?B?RUg0bXBaQU1uR21pcnMwQ0VscGNlV0pQTk1obVp6NVlhNTJTN1lkejd1QXNU?=
 =?utf-8?B?d2lhSGdobEhJc2duSmNhTDRocFpDeHphTHJrcEQydGVpVlJwaVpwMDlHYWhG?=
 =?utf-8?B?NnB1SExvbC9QRDdvV25XZ25oYW0vMlpCQ04yd0dVK0dRUktSeXFMNlVqRW1a?=
 =?utf-8?B?TlN4WklabXdoTE8vUlJhSzFldFpZZk9TT2JwZExZZkVFQ2hzK05rSU0wWlhT?=
 =?utf-8?B?NE95UmV6MDBucUoxYzU0ZmdkUkFPU29tV0krR2JOWmlMSGVLdU1KalB5eVYz?=
 =?utf-8?B?OUxRME1ndGdTSEZpZXJ5bmZpRldCVWNhYllRWXN6WFZpbXpUbHR0Y0pHQVg2?=
 =?utf-8?B?YkpQWnZGV2lWUmRBOVJmVXJnYktmUUxaMWRjSWxEMHBZaE9jOTFxWTlpNyts?=
 =?utf-8?B?SlVVU2JMOHJkVEs5RmxSVndGWmRwVlJCOS9sN3JNdlpzWUtKdXJJSktxSi83?=
 =?utf-8?B?ZmZjRGVMbHBlNXJDZVFSS1FGSHh6dmdVS1BPZHZpdUpkekE4MlFaTXRhK3Ux?=
 =?utf-8?B?RzZJMVpiRmNJZ2lITTBCRnBoZ3l6YVZxMU8yRXBiZWtjMnk0QUl1US9FT1Zl?=
 =?utf-8?B?MjIzZmZpMmdmdnhjaVd3QVNVdFBjM2lsSG45RzlrZGgrNGNtSUdjWFc3QjJW?=
 =?utf-8?B?WTJqVTJJZGpEVVNzdVNEMnRhTkJzbXBOT0lFenRweXByOE45a3VvR2FjZnBw?=
 =?utf-8?B?TGZZMm5Ec1I3OVpLbFJjWWhWREwrN0pMR0tGdVlzL1AxUDczTEF2TnEyeHlJ?=
 =?utf-8?B?MkVIYllaUHNxUHZMSk14ckNZY2pOOU5nUUFNWmpLQjVoSkR5K2hJeXdkN1dm?=
 =?utf-8?B?b0ltclp2T2ZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJiRC91aFIrSVVRNGdIMndvNFlkNTNlZWpoaVhkbHpxUW84ZlRsTmlXUmVK?=
 =?utf-8?B?SENzRmxLTUVHWFNGQTVRdVM0Y0tVaUh2TFdoUlNPbjNrQVcvd2tVdGVXNzB1?=
 =?utf-8?B?TlR3cWlBRHN0NS8yWFBVSWRzUHI3UlJTYjJoZURIZExBU1lwaHQ1V0g1YmQr?=
 =?utf-8?B?T2dJY1dDbUFGV0ZrYTdJOTk3SHp4V1lSSUE2cy9mMFRNdFhyYXpuSkluUllr?=
 =?utf-8?B?aEhEekUwNXRwTWJibjlCMi9UTk1FeWs2MGdTRUVtY3RGSlZrLzNWdk5DMnkr?=
 =?utf-8?B?ZnE3YnFYWFFBb3U1SWFTSW0vdmZBazd6OU55cTB2aXFjL0VQRGxNeVltaXl1?=
 =?utf-8?B?Y3lqWngyOEtPYitOZ2o4YWpRS05xdEZwemM4bTZOZEZmZTYvdjZSejlmcUl0?=
 =?utf-8?B?emx4Ky9pQTFFYW1SYTBhMFBGZTYrVnhKOUs0bGRjTjVHcldMR3BUMXZ4MXor?=
 =?utf-8?B?OTJIZ0g3Q1dpSXpuWDVFVXRQUjE5eUhOZEhCUGlhL3ZxVEdzOHlIQThYN3Bw?=
 =?utf-8?B?ajVWZHZKMlYzR0NOOXNpdUlVUFZnc05oQlY3VkttcjRiN3htY1FKbjZ6UE9N?=
 =?utf-8?B?dDQyM1QvN3VkZU5MdGwwZmJFNTZDeXJIZDVYMis4OEdGRldTNWltRjJFOHA2?=
 =?utf-8?B?NmpQWjZiMEF3ZnlkMHZlL0E0V3U3Tlpnbnc1U25nVU9HUE9UWXNuRUhHR0VI?=
 =?utf-8?B?SGJxclUvZ05naTg2Z2s1QkFpck9pTWh6RXBBL0IwL0dMYitJOVk3b09CTm5E?=
 =?utf-8?B?Z0d4ZTNmN2VhK3UzTkxnTk1qSTY4S2ZKa2VoK2IzWUZrWFFqa2l5NDJYV1lZ?=
 =?utf-8?B?T1RUODY4eXQvWGh2S1dlNGdKc1FwWTRCb0xuUDEwN3M4OGg1N2NhTytyMzZD?=
 =?utf-8?B?V2FzK1JYOTJ0aU84TjhrY01USzZ1czVBODM2MUNReU9KY0tiMVU3c25HS0R3?=
 =?utf-8?B?NEZIUnAxMEJxQnlSQk1aR1hPcDBVcGtnbUpVOWk5TzIyNytveHFacVhXY3VY?=
 =?utf-8?B?MTF0NEhJbVRrN0lDKzBVVGswbjJnaXJuaVg1QW4vNmFsZzdBNHExQjRuMjR1?=
 =?utf-8?B?ckw4Q2VVa1NMWENEalJOOHlybUtUdlhJZlNnYlNiVHRsUVo2MnBxUjB3bGh2?=
 =?utf-8?B?L2d6M25XeGlkdm1sckxTZFFZSGh4RlRnU0p6RG5ZWjlEZ2syd1hCdFRkYUNN?=
 =?utf-8?B?cWk1T1RXbnhDSWJxaU5TMlJCR213QUtldnVvWEZCMTAzTGo3aXNyaGNCQWhJ?=
 =?utf-8?B?dVBSR05xeDY1UU1pRmVpb2gwZDJ1UVNqM0tiRW8rb2NFOVo2SnAzMkk2c3d6?=
 =?utf-8?B?MXVrS1Y5ZFdaYTFoWFR0M0FYcEZkV3NrMzhhUWVBeGtWbmxQV1VZSHVMbWtZ?=
 =?utf-8?B?WkVFeGVuWjE1UnQvblFqWkZRcXQzRlJZc2ZuV2p0QmhSd0p1VElmSm9ITmsx?=
 =?utf-8?B?b0RKcFVLeGpXREZIYzZiank0dFNPRlc1L3FVZkpPbG1RWUllcnBnYXpEdFZv?=
 =?utf-8?B?MXhiZnRJUkhjUmtDNXNHM2Z3VVV3elN2T2hDU0NGUnRwRnF6bWdrYVh4WUZq?=
 =?utf-8?B?TWZLWXBDa2dCMjZsbVR6ZFFpdGV1cEh1MERGMjJoKzAxYnFabUYzTVlVM3l6?=
 =?utf-8?B?Y2ZaVXdtdHYwRHVoL1dmMlVlSEtsOXMzSG01aVc3OHhLNzBuS2FZcnZwekZz?=
 =?utf-8?B?WmcvU3VTZ2x4eExuZFc0eUdSd0RQbE9MSHYxOG0wZmNCamUrSVF6cEh3VzMw?=
 =?utf-8?B?ZWFlMW5Eb203bWFnZW9RSWJJQm1FMi8vYzk4dnJZRVRJUjI1VnpodWFucUVO?=
 =?utf-8?B?WmRvK1lNdWtzRmtMb3UyMWtLQzgxMXdUSi9lYnd0NEo1UDE1SzhLWlZtNHlD?=
 =?utf-8?B?SUUzdjdmVzliZFpyYkFiOXZWWFRxUE9lK1hqOHF3Q3NXT0puRHVYMEYyOWlZ?=
 =?utf-8?B?aElHOGxrblFoQ2NkR012MVArcHNRL0RXeDRFTGNYSTlHbHdSNWpRTWFLZ0x3?=
 =?utf-8?B?eXQ0UnRoQlFSMGxIVGVqQ2hwdDB4V0c3QVhWSzhIanBwRG9CUHV6OXByTXhT?=
 =?utf-8?B?MnBEMThjcFNwbWtENG01ZmVrM21GRlRkdXF3YWJLK1dic1g5QXpnYXJPZ2dQ?=
 =?utf-8?B?c29kZWc4TDRYVDIrREVGcExJU2Nkekx4Y29NeE9obWVpMGZZYkZ0VTRMVVhX?=
 =?utf-8?B?b0RGc0dlZFJWWkxpRFJLSStMaWhUWS9hUTczQnhCRWc3Z0cwRWJXY3VDNzJD?=
 =?utf-8?B?bXArSFpuUHBHeEFFUnE1ZFhyQUJ3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1460ec27-cafd-4411-39b1-08ddfc273811
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:33.2103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+Pk7M0czbpyvjCCdqVgSgrUtg86BjAW4eY/YmsZA1e38QtlqnzxZj/r0y66BiioPhCARZWPN+eNsGHcMAeqfC4dmlte2zytBfKT68gcRPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Authority-Analysis: v=2.4 cv=NeXm13D4 c=1 sm=1 tr=0 ts=68d52852 cx=c_pps
 a=A3wBdPz/itNY2Bh/0u/a6g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=8L7MK6Kl4ER3plC8pQ0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rRQZitTpiaUfniflB1Bdl_CqshIEl1PY
X-Proofpoint-ORIG-GUID: rRQZitTpiaUfniflB1Bdl_CqshIEl1PY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX+9aWI0Q0Gv33
 2dQYIC/zSAWf+4haFiPtEIwslnfNdtbgDYjKPrDljWWKv5rZDHluK0THwnrGDayqr68HF6+N/dR
 gYjmkMig3GSw2XXxA/8IlDA7Lo/yiL1jaXkNUmEPhEMWNmCclVS6qfdJI/301xS/q2YsW4NQz7H
 OD1lU2OUj1J9JTQ/P5Jm6ZY0tmZlt3+ir/06gtJ7bJx4IUoS1mfjlnD5rsxFkiL6K7xfWtIFEm9
 JpLvI1qQ+4RXRsMRc5a0k6YeV3QvT3+Gf3KK3okTB++f74WTjVx3UpiILUi4NJ7GeHkegSd2m+8
 Ytm+lcS6tylqh8IK1Ayf8xRiOAPZfTNz5lxuUnVQvb3OigMKzHly9RJIlk24dE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Now that nothing accesses the bcontainer field directly, rename bcontainer to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-iommufd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 13f412aad7..6b28e1ff7b 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -22,12 +22,13 @@ typedef struct VFIOIOASHwpt {
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
-typedef struct VFIOIOMMUFDContainer {
-    VFIOContainer bcontainer;
+struct VFIOIOMMUFDContainer {
+    VFIOContainer parent_obj;
+
     IOMMUFDBackend *be;
     uint32_t ioas_id;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
-} VFIOIOMMUFDContainer;
+};
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
-- 
2.43.0


