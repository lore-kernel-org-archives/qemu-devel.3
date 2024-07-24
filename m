Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754BAC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 13:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWcOj-00007u-Jk; Wed, 24 Jul 2024 09:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWcOc-00005V-BD
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 09:51:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWcOX-0003AP-AH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 09:51:09 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ODnbGX002448;
 Wed, 24 Jul 2024 06:51:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MFun+ervnHOst7C/MIkiC8l0VOcWGk5JIfsDdFWRh
 1A=; b=W4rRSycjfVFSAqDa/QXAqzx4W+O6uqdFybcVPmjYfJ5RmguUT55j1AdGw
 wXeLtdvdIotHyPH3O0YW4GIvyEnhwYZXvmfyboDokWP5e8SGC+yPg+HZcotvMcfe
 B/Fpnh03oynulV3AtGXBiVO9hkjRPckHQv33IfzCehAmGo6Z3KHJvEGQV17uWbJl
 jpTueuLw5rTmAz3OqGNzW912EGhAYXITlvuMc85QIEv5Bg9zQoO96oGVPewxJBll
 xEgakNzwlfbmL2Q3fHy+9vNtj5sQz6wt4N0Kia4k+vljEVqxrWdEx95O/FK89VQn
 Z156wMVpnzv+HpkJwsQJ5O9DSzJLA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010006.outbound.protection.outlook.com
 [40.93.20.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40gas6rbsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 06:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EztiNVJKfwACwhvOU+Bq+YsXH79bL73GFqnRKUqQ6FHi2wxGDZegqm/4dtpxhp51RdXyuawDfnQeRXfVerDZvsG+XsLhQzSLDLtdNdFdWaOvvM1/nGqmNzZeYWVGLJmP412lEFRjmQMYSePWWCdYNaMogljx6WvzhXYmF94P9UvSe9sCNY+1qC+SPmCwMr9KzVVvHx6LFeXxih5q3cerb6RLg56mTj4G1X5KFQyeZ0ikwSQzyvY1/h4Ew3ad5WW6VDjvbWwOAM9vCEWyAXk7NyOJL35hJgjn+V8WlLlv/weUUtsuz1cYuglPOX17kVpKmQ+qOgxr+FRsPKsVM3GK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFun+ervnHOst7C/MIkiC8l0VOcWGk5JIfsDdFWRh1A=;
 b=GQyJBxC1WeXKKiEsLxJpTeWCyHjc0LDoJ4vFwEvbcjCtkyzDRyda1FInHhv9t5CkKKCCZeqDovkGOBQUXvV4PJlVXrJe0Wt/Q7jQOletYLCn+V/3qevsZgjuKgPw+YLnFIP5xEDOYwMXYf68vPBoT4cRaNM7JXmieYDNWHiBIao5VbCNn1dryKCvGYzpHkF+6soniz1COpr6fn+cnGfOXyzTeWjqHok9F3VZhZHpCt6cusIOaCOzUQFM9srbAaWaOgpusf4S7ZtGtPQB1CQIz463pT2Nk10gWGu5Z5bKNxK9Gj3HdV/hmeRGL1xj7QFHj4LPkLBF2EufGIFHf3FEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFun+ervnHOst7C/MIkiC8l0VOcWGk5JIfsDdFWRh1A=;
 b=Ds5sVDgM/SPbP81TseQ7e1EcxMKZ7I67BY5e5ZVG7kyzMARcTvHI33xdIEJ6c/wqonfQfqAq53Nt3VL7IZomAO/tVkmGCBM8Y7ZxZ0QMjAurOz4EMLiTFwR8wZb63wGGsxU3adDvdofwetgWKoBn/sclUALZcnQErMK7km07PU17cV7BvOJakWAyXpAm/3hYuyn07qxJZTFkoqGtp9VIGTqCIGIJmi+m/HS7gl6lA1FYhbORH+jWonB+DPNk3/66xuUpZhzc4XoJBJydC0kC+FDmCqt85HGEu3uKQO0U0/icWGzDoCIWvjOjVYrGK5T+81RZyGQCFjX2mqd3nRjIYQ==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SA0PR02MB7483.namprd02.prod.outlook.com (2603:10b6:806:ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 13:50:59 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 13:50:59 +0000
Message-ID: <c53e5134-4a4d-4510-9c88-2fef112a4837@nutanix.com>
Date: Wed, 24 Jul 2024 19:20:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: Igor Mammedov <imammedo@redhat.com>, John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, bob.ball@nutanix.com, prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com> <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|SA0PR02MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eee29f3-0502-46fe-3203-08dcabe7a5c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmpTcHdFd3FIRTdFNEI5d0ljWmZrRjNhR3ZpV2I5dk5KQk9Lczg3ZC9BVXZi?=
 =?utf-8?B?K3RhWlowbWNIRHVqaUJjbnlsd0F3UnhrZHZzQkRHb282UGY1UDZlc2ZEb2NP?=
 =?utf-8?B?cEpiVmRtWklsdTMyOCtlNldwczBZYURaMzZLRERBQm5Hdk9iT1NMbEZuUlBQ?=
 =?utf-8?B?NndOdnZUcFNHOXlXaStSaVlTRXRpcWF1M1M4YmMzeFc0djREU2FIOUcwQVJk?=
 =?utf-8?B?eDMrdGltSU8zWFk4aEJLSlJ1OUR1QmQ5c2F0VjAzTTF2d01JSUdSbTFJVUJ4?=
 =?utf-8?B?K2JNQ0RlelVnZG1HbitKMC9qUFZweStCbUNWdkVjMkJzOHhIQ3plSnRSY3hU?=
 =?utf-8?B?THNGWGEwTXcwZFEzcnNraWliRjAreklMNE9mbloxZUh4U0s5eWJNMnNZL2Nv?=
 =?utf-8?B?MzdIeko2VjJFR051VHg0M2RiNEpsSEhwcDVlQlF5RGxabkFXK21SaXJoNVlr?=
 =?utf-8?B?NWFSaU9WUzhrMnFSWFRjdXhDQ1E4K1lmNmJrNTV2dmpIcHlaY3dMbmgwQUlO?=
 =?utf-8?B?SUdZMEFaa2N1eXhrL2JzODJBbGdpVnFxOFhLckpKL0lzM2FkMk1sNzg3dlRr?=
 =?utf-8?B?ZjViOHUvNDRrOXBONE5wOFE3L0VwQ0FDNFBEV29xMnZtRzF3VEFNZXRCMVZo?=
 =?utf-8?B?ZUVVc3cydnI3bWpCbjhuNXhEcGtmZnN0N0hSYU42WVlPRnBUenBEZWxxY2Nt?=
 =?utf-8?B?THArTDkrUDVEWldYNHQvQ3RmakNYaHBTRm5iWTB2VzhtdnJGd2RpVkk0Y3hT?=
 =?utf-8?B?K2lyV3dEdnk0NG5DR29qUktOWXNteCs3WS9VWHp4NFI4SmxvU003SHNxZkN5?=
 =?utf-8?B?ZmtiWkdjV2xtMG1pdE1ZQ1NYOUtsSDVWZXFldVRMNmlGS2tKbHRuWTBYbDgv?=
 =?utf-8?B?Q2kyL1RuQllrblI3NDU4MGxpNjJlSWZIeTdVVklVVW9JL0VidUpZYzNSMUpq?=
 =?utf-8?B?a3pGODVieXVoSjFwbXRnWnFaQmlITnR5TEcwMHBCbXdIVjRxakJ2L2tYcjBJ?=
 =?utf-8?B?R0NVSkhGcW1rdk1uOFcvOG9yRFpTYm1LeXdhc2VyUzd1QUR2YzhXWUhXbVhV?=
 =?utf-8?B?U3lDMVMwOEF0LzJxRFQ1T0FDN2szU3dPWldnalY1UkRZbWZManFXdm9zMGd6?=
 =?utf-8?B?SDNxS1dJYVJnbmRReUthaVZvR0VQeGdTaENibEJSYWNyb0p5c3RRUlVsY1ZS?=
 =?utf-8?B?UmlGenBPeW0zNWhsSDdkRGdsTS9EVzdmQk1NQnRDSUZ4R3BMeXJSWk0yaTd5?=
 =?utf-8?B?N21KM3B2a1drc0tneGgzU0pQQ3czcGFnOE9EUlBGb3pZK0tyeUFBTWRzcnox?=
 =?utf-8?B?TzMyVkRFZkM5NGdkd09iRnZFUWUrVW5ld2c0Qi9xOENWM2dUbFhCcmN4MEZ3?=
 =?utf-8?B?cTkrTDhaTFdwbmE5aHE3SWhIckovNDJyckd5R3Q2cVIwNmZxdkljU3llSUtN?=
 =?utf-8?B?dnpKbE9wa05aWVpwVFAwcHFuUWxYa3JlTXNuRnlIYTQzUThsVU5ub1FFNXZK?=
 =?utf-8?B?TVE4YzM5MjlHeVZTb0RFRFNBRzhXRGtxQXZVeFd3MHJyeDJmVHFlL3Y3dHI0?=
 =?utf-8?B?c042VHRVWXlLVlp5NXFxUTc3TWN1SjRYQ2JvczVFYmxQZ0h2dFVpR3ZVVS95?=
 =?utf-8?B?MEx2bkFFcmUwV2xnZmpUcXpNTnRRNlBiQkc0eXZqKzJiMytmdUw0aXhIVUEw?=
 =?utf-8?B?ZzkrKzEzN0lFdS9tNkJHdmpDdUtkUlkzU0QvVzRLWG5yWHdjQkUzSElxMjdr?=
 =?utf-8?B?eDh1L0lqNlhjODNDQkEzRG0rRy9MRlFUcVpmL2Y4VDR3KzZGSVRKNDJjOHE2?=
 =?utf-8?B?Q3FUUDlMa0FWbEZ3QVhOQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpJZzVRSFZncDJmUzZPeUNSSVMvdWxJa1lnd0dNVllmQTB3aWVwQTNsYVAv?=
 =?utf-8?B?ZzhTZUNBdWZBTkQ5M2N2ZDFwK05FZ3R4Y21wWk8xa3REUkhKbjNEZk5qS0tR?=
 =?utf-8?B?NU5FZWxrQVB3OHFzVXJyMWNzM1BUL3hoc2M1NkUrSTlndEsxMDg5U0FydkI4?=
 =?utf-8?B?Tm1LNXR0b0lxU0lWWURhdUVpNUhCd0cwMHNoa0svM3dwRU9FY2dCcVowZjJj?=
 =?utf-8?B?ejVGa0NId25WSSsramlyMStvQ21hd0pCYUdrRGUzcHdzRFkrcnl1UXRzYjJ1?=
 =?utf-8?B?YjJBQlRIYUtXMUdEVldCN3dUbk9nOWFyRU5QK05hdFZ2ZFRCRmpnak5COHcw?=
 =?utf-8?B?V0lqSG1Dck80cWQ2VzJzaFMyR0dDeXVjT3ZqWkd6SFlrZGQzaFJOOTNVeEFz?=
 =?utf-8?B?a085eVh3dmdibnI3eDZyRFZhbWpXbVEraGRVbCttell3dVRtRzhBWUI4WkZ6?=
 =?utf-8?B?NnFkbnB4REdQQmZTcmFDVWRzQVJlUVV1TUh2Nnp1ZkovbFR0QjBOMzZWTDNx?=
 =?utf-8?B?ZE9OckE3MTA0SzEvTm5jS3dyZkhpWHd1WnRWTTA5SS84VlRmZ3RINTI5Tzgw?=
 =?utf-8?B?cElxU3dkTnRBYVNSb3ZXY3NrbnVuc2tDaDRCVmVIcWVtb1pFb2RETElrSENC?=
 =?utf-8?B?cmxiNk9YbWhFNnhkRmJGcUxUamRqVjNGU1BGZzNObGhjc2pSZkpCNVkzTkVC?=
 =?utf-8?B?TjdSTUkrcFc1RmZGVjR6aWowQmNxOWxkWEt4bU94d1lVb0NrdU4reXJpbTV6?=
 =?utf-8?B?WW1aWi9MZ25MdTN6Q2pCOC9uMytyc1VtTk56V0o4NjEvcmkwd3p5bEFQdXZH?=
 =?utf-8?B?dUJ0MnRPZlZhMk1RbmdXOUZ3Vnl0OFJrK01BNzJPeVAvUk1XRlV3eFZwNm1X?=
 =?utf-8?B?S3liWXN6MFlEMUlLaStBd2RIWGJKdVB4czNPSzhjdkFwVC9HL25zQ2ZzanZL?=
 =?utf-8?B?TUxaanhlSzlSU2hrTmZUSGc4akxNNXRyOGd5bTZVQUNCN0xqNFBRL0lSRWFo?=
 =?utf-8?B?OUxhTm9DcVVVN2R6Yy81cEI1bjUvNDUza0UvMDdaMTMrV2c5dmpYT0lQNjRK?=
 =?utf-8?B?VWZ4SVNIOHd1Vmh5VWpWejBvai8vNEZoSHRsMnROazcvZ0hzL1VJbXFwbkxw?=
 =?utf-8?B?eC9xaWFCUlY0TE9DMUVSSko3UUl4Z3praDlTL1JPM3BqdjhlOGs2K1V2dnZi?=
 =?utf-8?B?QndMZllmRGdzWUphMGVmbjZWcm5rQ3lEVUp0NzhYMDB2MGtqZTF1TGNTOW1O?=
 =?utf-8?B?Wm5BR08wamlpN2ROSDFHWldVYWtFOERFWEdqSUgrZFA5Z2l3SW8xMlBVdnhV?=
 =?utf-8?B?TDFBNE80bVV1NkJ3b1NCeVRPbUthRERRaTN4SGVpbjMycWlBL2pER2JSdDd6?=
 =?utf-8?B?UGFKbU9nQnVyN2Z5enVrQXplOU1XVlBqWFJBdUgzMXRnSERteHFGeG1pYzJq?=
 =?utf-8?B?U1FXVDgzcjd3SGoxT0k5TXNZNkM0R2J6N3N5eE1LTDdhZGZ6TWtLMDh6Y1JV?=
 =?utf-8?B?eEFGTExFN2ppZm4zbnZnTS93TmZ2SXgrZnl4cm9PWE9NbTZxQXdPa3Z3MDFr?=
 =?utf-8?B?K2pneDcrZmdMMkpIcFdUSS96ai9DOEtjVm01cURCZjlBcHpSK1d3SGptU1k0?=
 =?utf-8?B?OG82ak9McmQwMTlJQ25VbmpFKy90L3BDMVFMUzE0dmV2cytrSEtqYTk4c2RD?=
 =?utf-8?B?YXM3YndrWWtnUlhNMG9Fd1BiTklpdDBtQm5BZ2pjNzJjMDZwZlFiZzRML0dI?=
 =?utf-8?B?UHErK2Y3MWNsamxmeCs5SmNuam1xM0Y5MzdMZ2IvL2lIUnpaamdHNElVV1Zv?=
 =?utf-8?B?OVNXdDlITnlIRFVsMXlOQ3FNK1l4S2FNOTNEVk1JSEYzOTBPMmRxRklRWGtS?=
 =?utf-8?B?UlFlN2VXYnAzY04wODhkTFo0ZDFFa0hqbWNmOW9jS2tWY0FPTXBmZ003Z1dU?=
 =?utf-8?B?b0RGbG9FYjN5cFBtcVcvMVdlcjBJaWlFVG83UVhveUdCR0plQldKOWN3eHpE?=
 =?utf-8?B?aWt4NndZdGRjVnkvOHFKd0ExMDdWSFR0V0w0WkRIRW5qd1FiWjFjT1BmOUFK?=
 =?utf-8?B?NkpuYm1WSmQrWUdMUFAwbzgxZGp5TTI3KzQ0Q09iMi9ndno4aCsvdmtRM0pE?=
 =?utf-8?B?TE1vRmtHYUlqOUNXc1kwenA1ajNRS1BlZGd5Q2h0U0c3MGlIekFKOTdDek90?=
 =?utf-8?B?YVZFVGtBMzRsZDhjZ3N2M2xhc1FBM0VJVXFTK2VBMmhnVmlkcVFkWEsvUHM0?=
 =?utf-8?B?SEF0Vm03aXpNOHl0cHo2Qzd3VDBBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eee29f3-0502-46fe-3203-08dcabe7a5c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 13:50:58.9440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APCxXCZCmrEx4KqHbNLOnbjT5cHrL/D5GqOsSbGqNf7MfbWVb49DFPf+O9t7cMApYo1wiGCK5HzXs3du7f4DaMdFa/Fin11tuCAu48WV5pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7483
X-Proofpoint-GUID: ieeU-dxCC6SkYZROX-YUKuFiXAKHkZBL
X-Proofpoint-ORIG-GUID: ieeU-dxCC6SkYZROX-YUKuFiXAKHkZBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_12,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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


On 24/07/24 6:24 pm, Igor Mammedov wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Wed, 24 Jul 2024 12:13:28 +0100
> John Levon <john.levon@nutanix.com> wrote:
>
>> On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
>>
>>>>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
>>>>> to 0xb by default and workaround windows issue.>
>>>>> This change adds a
>>>>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
>>>>> case extended CPU topology is not configured and behave as before otherwise.
>>>> repeating question
>>>> why we need to use extra property instead of just adding 0x1f leaf for CPU models
>>>> that supposed to have it?
>>> As i mentioned in earlier response. "Windows expects it only when we have
>>> set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
>>> it should not be all zeros. SapphireRapids CPU definition raised cpuid level
>>> to 0x20, so we starting seeing it with SapphireRapids."
>>>
>>> Windows does not expect 0x1f to be present for any CPU model. But if it is
>>> exposed to the guest, it expects non-zero values.
>> I think Igor is suggesting:
>>
>>   - leave x86_cpu_expand_features() alone completely
> yep, drop that if possible
This was suggested by Zhao, probably could related to TDX work 
mentioned? As i did not see any harm, i did not mind changing it.
>
>   
>>   - change the 0x1f handling to always report topology i.e. never report all
>>     zeroes
> Do this but only for CPU models that have this leaf per spec,
> to avoid live migration issues create a new version of CPU model,
> so it would apply only for new version. This way older versions
> and migration won't be affected.

Yes, I can do that too. But i beleive it may not be a CPU model related 
property or bug. What if someone uses older CPU model but explicitily 
passes some extra flags to include 0x1f?

>
>> Yes, that would mean that if something requests 0x1f leaf even though the max
>> leaf is lower, they'd get data back, but it's not clear why that'd be an issue?
>>
>> regards
>> john
>>

Thanks

Manish Mishra


