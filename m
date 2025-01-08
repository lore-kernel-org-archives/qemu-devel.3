Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6286E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdM-0006S5-8y; Wed, 08 Jan 2025 06:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdH-0006RE-FM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdB-0002Ew-Ds
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:53 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087vts7007169;
 Wed, 8 Jan 2025 03:53:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=e2pH8ec9fPJ/yQmaQBOhWEct2hE2OKTew5a0CgjBL
 gk=; b=C9CEPmplPdtT/CYBrXJRxZs/zSrB7pSGkEit71eUd2Wf8APww7KkOPeQX
 Ncr/hp565aFmP3suXeGEL2Ojqb1gVES4w1XH66Zffj75hiwyB438xcObSrAs6JZ+
 yqVHr9jJo/UHVBToWbXYeEUlN5L5FYMu/ol6cLsdbKGs5b3G8RUlUHpuT/MU2VlK
 o5KOgYc1P7hJQNg+bHkz9fNkZmAH+1JT0oPzDM5aQoAHlzGuHFq3+SMCnmHaSijm
 coCEJsepVNJa858mJv9MHMhrSD2JyMmrlxb3/HaCJ35UQShyJZcmO9fSVN7FR0X/
 DztL9PyE8Jo+G43s5gvq+dTNt/8Wg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y56eryxp-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3J9EV4ZwmCxb9jQQ/uVs8eM9MSZJ/MIv0QrV9bSW9/eoaBOxchNxKSY9n5NymvlLW80av+7Us4tMbYlQ4u50wv21ooyXkoChhestxtbU+kN9aOtemqBhMQcbnNRyQJ2wckezhdEm1rWWZQg7ST1jT444CqGNIHBSNskLleDs8wY2RuB7gRtARiMzDnmgrbq1Kq9dZtSnN4ZnPRbXUXAJ/al7rHffnXgQhnzShvyojAHKUotdr3D0zUETEZWPQqUfD5o5wAjnBxQb8pHXd5zS0tWBDZNvgz/YOVR6Xv2hl3u5loShyHijP5juokI8IxyxmwVSn7FcwOu2ayNULkhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2pH8ec9fPJ/yQmaQBOhWEct2hE2OKTew5a0CgjBLgk=;
 b=yiMOlUQGzqJ9w6Bcz4Z7My9wxLcnYx6RF+y+pPWHA9dmI92zzsjg7bRXgr4e208dWRqqXvTs3ZnA/UK4UrDUX7BawvfLoo+FskVmvXC18zJ84x9YsfHWDxHLeUPhLa063wkq7GKHrc9DVxOKKnusJnBhqUZcQUnZZqS+fSxP0tKzl92waUyA0zISFRI3hbpREy5y88sZ4CnoAgQVZB6PXzM8gb8beMEKPsApAohY6C8/fuOSwW08A6iW48HvGKLro4HF9UJBmPK8uwf4e1tlS4LjPl6RNuZ57j5d2JeClr/dSLmHi6sVAuT5Os/F5zGTqPzRHyB44eAcvbTR0Y5vqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2pH8ec9fPJ/yQmaQBOhWEct2hE2OKTew5a0CgjBLgk=;
 b=lQemC1YamFuAY/b/2GERcmuRtJaGNE5Uq61IAHoYtESvRl66qncRFGAZ1tshjqMMuK6dqUPn4kx3Ys+TTUY8AdYN4ir2jaRGLtXk2yr4etCU/QbcSHsPw2v/WqJobxkFds02IbDejXWNy9fcPzElW+hBJ+WPWBL1fYqHqw/JBMQBxwLfOjXLHB5FXBNHVKDh+wggY6jk7GdPfSYr//8Dn9M1hL99S6yUjqd1jfZpAwSfiydDMYUMRNjB0YVGjprHqvLZTvcT3yXLGwKQkzsq/mIlIn/EKKB6lzaJaIJetQcbRaIBr8dii2fbn3mGFRaU0onvhrnjzez4nF/zU5K2nQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:43 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 11/26] vfio-user: connect vfio proxy to remote server
Date: Wed,  8 Jan 2025 11:50:17 +0000
Message-Id: <20250108115032.1677686-12-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb719b7-4503-4865-e9c8-08dd2fdb1a03
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0x4V0NoaGQ5eWRqa1lGMis4V2RHQVNLODZ2cDNpa2h0NVkwbndnQWhLY2da?=
 =?utf-8?B?Q3BXcEdEaUFReTJKUmp6ZUhRR3M2UFhUcjdzbTJYRmNDcGFsMGhtelU1SC9T?=
 =?utf-8?B?S1QzRXczK2oyRVlTTWNwNVk1VlZUOE1TTXVKcTlUc1hNa3d3aytYdlhUc3Rp?=
 =?utf-8?B?TVNwUGZHMEQvZnpDdDhmQ2NvcjB0TGNYcDJhalVnZDdXRFBMMGR6Wm5VcXlD?=
 =?utf-8?B?ZnFteVY2eHkzMHNOc2FZWHp2Ynl1WXhZQTVKWkVaMUk3UFFVVHVhejBlMEt5?=
 =?utf-8?B?OGhad2Y2VjBaYWtSTE5leFJDcXVyOU9sVGM0SEVkbzVBRUtscUxDcTNCYzdP?=
 =?utf-8?B?emxFL0sxRWUyY2xYR1ZydGI1bExOeCs4d0ZpZjFKa1VqVFI0d3ZPUzBRb05B?=
 =?utf-8?B?ZG9OZys2blNrMTBEa3FCcTYwRldqNEp1YXNoMmh1U05ONDAvVmFqOFNiZXEx?=
 =?utf-8?B?eVkyNGY5M1l4S0dsTnVMMnRKMTVnM3lrempsa0J3a0JhSkhOcWgzK1JhYVJR?=
 =?utf-8?B?TFQweldyNnRBZFEwZmRpNDRCMkxxSG40NFZOSWRlNmJlYjNSYWhVVDVCVndX?=
 =?utf-8?B?bHNBU3VkSXcxNk1NNmpycVYyM0EyZko4OG5ZQ0FxSHFxWFc3UzF5b0YrMlJn?=
 =?utf-8?B?dEpHVk13dnVMQndRV2t5R0RqY3piMHpJVzc3alN6c1JqalNMaHVSbkpVR2lM?=
 =?utf-8?B?UVZpMEtiKytpeFdVWjVaNy9XV2h1NWUwRzcvUVJSY0puYUpNamVMeHhtc2VM?=
 =?utf-8?B?QU9qYS9sTVVLZyttKzRxY0JZWFJVSnNYSTY3N3kxWVd6V0dqUzgwU1BOdlho?=
 =?utf-8?B?UUw2TkxNQXNOeWxOallRUW9BdGJqd2lhTDU4Sno4em5kNDZ1Z0xDbTVBZkt4?=
 =?utf-8?B?SGgxVlBwYW5TVXdmZEVPRzREOXNPT3dINUtDMTlkTXZWamg5Y1AvMWpMc1Bj?=
 =?utf-8?B?a01iVlp0ZldwSnNHQkxSVUphclZueDZLSTk0KzUyQVh2Nms0RmFubzY1T3da?=
 =?utf-8?B?QkJ5OXl6YTFId1RnNHRVa1Nqcy9NWDdnNkZWb2NRaW1QWEdBZnVqWkcydGpH?=
 =?utf-8?B?b1Y1Q0VWdlJTMlRQWTlMaVZyL0xSdTFtY2FpaURWL3dBVkYvVllidFBKUWRj?=
 =?utf-8?B?bGc5MjE3ZlVCeHBWeEczVVFqbjEzRHhEMnJsRUpOOTh2TmxOMmYxNUJNclFF?=
 =?utf-8?B?NHFhZmk3dUhDaEpJOG1XREhjQjNSTVVabE5xRzFyMTRVMVUvRDIvRHUwbkRL?=
 =?utf-8?B?UTlDNWRrNzh5ZHBFazBRK0s4NW92YnF1b1JsVE1mTGxLbDlkcUV6S0NJL0xS?=
 =?utf-8?B?OW9ldTNmaFRIMllNTUFlQU5TeE9oTU5zazh3T1lYN1NJL1hnc09HM1QrMnU1?=
 =?utf-8?B?VkZEYlVsOGNuZlpBeWxQUHBqY05pZ0hEQklkeGlybllieG5FNi82WllPZnRS?=
 =?utf-8?B?UEZqOGVSTmI2cHFlZVZEVXdPUys2VnB2Ym83S2Q5bEMyN1JBNHpaek93SE42?=
 =?utf-8?B?UXhpSFJqS2NLc3M1d08rRm5zUWlhTGZYZUFIRFM0Q1NLSENkdkVsak1pNVo3?=
 =?utf-8?B?TnVMZnhBQlNTT1ZUSExXRlBHYkhKczBnY3QrTnBTVjdTalFNM3hyTFQvVmNR?=
 =?utf-8?B?S3o3WXRPZnZsbmhSQ3JWNzRiN0N1cExrc0haTmc4UW0yV1oxb0dkVjd4b1Nq?=
 =?utf-8?B?NVQyZ255OFFPd2JRSVZydnBYekZGS0VOTHRlZUhIS0praG5lWUFQamJpL2R0?=
 =?utf-8?B?cmo3L2xrMk9rT3VJcysrUGw1dDBVQzgwVzd0VDFJMGZKL2Excmo5Y1QvTEhH?=
 =?utf-8?B?aEhWNzk1RVc4eXpnWmtNTi9WYk5oOVN2WklVdVBBS1FrbzhtTUZPK0hhREZ3?=
 =?utf-8?Q?ixISVpkKCpt3w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xtbmxPZDZ3MmZETHRlNnpZbEJWV2xzTDBuK1pabjhvb2tEcnNMLzVrdk56?=
 =?utf-8?B?M3NkNWdPc1ZtTHJOdCt6SndnOUpuR2hoNy9tTlFkbUkxQ3JoRkM3YmxOZkdu?=
 =?utf-8?B?MFRITGVkTTJVVkRVdUZuT3hCUmJubE1FTlVrZ014V3dmdDhtK3RhNFBJUENY?=
 =?utf-8?B?KzRGV05EMEEvUGdGMVhJbjZMQU43ZWdKVlBZa3BvbURDTmJ0elJUZHBYNXIx?=
 =?utf-8?B?QWR2c2cxMnhuc1drRStFNmQ4YklKRENiUkVKeE9iV3JTSllMODBTMWJicFVr?=
 =?utf-8?B?bytyVitabFpzMnI5OU04akZpUi93Mi9MeE56aHkzU2N2NGtFdEtyOHpkWWVr?=
 =?utf-8?B?T1lmY1ZZaldUL29RTVRNdDJEYmx4VTJwU21OMkwwSHNqUnBrQ1E1TjVjSmIw?=
 =?utf-8?B?WEdtQVd3R1QwVWVjOHAyYlZrTElVazJXamlGZ3Rvb2hSeFNOc2Z2ajM3b1Fm?=
 =?utf-8?B?ZFMxWmphc2Vlb0ZiQ0Z1bWNOU0JxYXlKOXZiSE9idzdHcll3ZGw3VkNnc085?=
 =?utf-8?B?cFRyS1pLNVRaeUlRVlhDV0hHQXlNUGk5VEJCbUoxemFyaStLQ2l4UnpSZXc5?=
 =?utf-8?B?WTlzYVFJeVpXWW5hZ0lpK3U5aHcrSnpSWFErN2FMMjl1M21XUEYzS3hkeXh0?=
 =?utf-8?B?STIwQU83cmp5RUdSOW92bEZ4QjZHa1lEbGQvMlNuZEFqV0ZjSXB3blJGUlpv?=
 =?utf-8?B?UUY3VS94UjZxT0lWdlRCNm5xRkZCS0tDOG53M1BnY3dIQmRuVjR0cXlhZ3ZM?=
 =?utf-8?B?VXNsM21NMkxPMXlYYWpPWG9URGppdTNWbTVjWjBBbzZGeWFUeGtBQkhSVWZa?=
 =?utf-8?B?UnlKdzV4TE1uaHVLL0Jsdm5WQW5HWVBoZEZPbVNOblFQdENKL1NVT00vVUo4?=
 =?utf-8?B?S2ZYVWhtc21DMC91Yyt5UWVmWmpQYzVyY2ZlWVhod1N3VlFoSWQyVXFXRTNs?=
 =?utf-8?B?V04zdVh1alFGZmMrdkRLcU4zM0kycXBJekVDNktLdnQ5RFpwWE14bW5rR0do?=
 =?utf-8?B?Uld4RUtzaitjVlU0N1ZNSXZldXB1TEZkV1FYR1dBSFVqZWRtalRrcCtoVTlD?=
 =?utf-8?B?NE1IamEvZjhWV1FkQmJtOTVtWjFwMDlDRjJrVE4zS0lHUHloR3VKUWpreW9k?=
 =?utf-8?B?aXpMa3ppeWZHSlBPMC81aUs4eTJLa1JscVlEVit3eHJTcTcxVTBQTGw1YVF3?=
 =?utf-8?B?Y1JORzF3ZGt5M2F3UEFSUHZBMTNMeVZhdEtEb2JWNEF5eXJEeXRiOWQ5dWFV?=
 =?utf-8?B?RUYwWFZGZHhiWFhaVFEyaUNrNWZDM0xnMERCRCtUVnA5dUFuM2xseUh4aGpj?=
 =?utf-8?B?Ynp1UVU5OVd6eWkxa2VYbjJQTzhnQ0o3MHRWRlcrWFBPMHlNY3ZpZS80MDBI?=
 =?utf-8?B?ckduZmJHUWhFT00rZFhXWUczR0Zrak1CZDEydUYzT1VhQ2NJV3ByLzVHYkNx?=
 =?utf-8?B?MFhEMDJWMFNUQ2w2V0I1N2s1TXFKM1pxSmZNZGVTUnNuRVJ2ZGlYeWlQMUtG?=
 =?utf-8?B?VEdlRzlCRGtIU3ZXVU9sT1FPNXNNTzFDZ3k2azJNc1pTVWlUYndudlF0Ny9q?=
 =?utf-8?B?dDhBcmF6Rzg0eWxRZDdtTVlzenErVExVb3dIUDJUWGh0dTIrN1FTWW1lVDd0?=
 =?utf-8?B?bTNwbUlWOHByS0RZTzZBTVBPMnlqMnNZTWZaa0ZySW9JdTh0Y2pNcEVaOWxJ?=
 =?utf-8?B?VC83aEg4S3dEdjJNRTNranM2bDFBd1ZYZ0UrcExBb2VVZlZLSkltYUxEVGtr?=
 =?utf-8?B?d2EwNHd3dmRpbFA0M09ENVRSS1J1U2V6OGVoWlBDVE9HUDNUTXgxcHplei9X?=
 =?utf-8?B?N0pGWUp3bFdEN0xPRmcvekl1cXgza3M5Yno3ZE9vV3VvM09HTHhzbVBJeTlj?=
 =?utf-8?B?UXpRNGVXV0x5Vlk5U09OZnBkem5qekYrbEVuNDF2a3BPTmJCZEs1YlY4aEdH?=
 =?utf-8?B?YmZ5NS90Rm5idyszZE1IWmZBRER5QUk4Y0NscmxzaGFiVlUxSjl3a1lpRnEr?=
 =?utf-8?B?UjE5N1orV0pwVmt0QUh4Yld2ZVQxdDZCS1dSUFhIU096QmRXZ0JLTG5YQWtF?=
 =?utf-8?B?RyswTVhjRnh2bnBzYk5kMFdVL1NnTm9OdC9SRTlNTU54b1NkMFRManhtZ3Bu?=
 =?utf-8?Q?nDvjnH9p367r3v6R4hwY5H4s5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb719b7-4503-4865-e9c8-08dd2fdb1a03
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:43.8832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUE/CwdwABaM0P2HrxmnKpv1t4bKfkYCWgl0HBmUulrbW5UZedS9I9aE2RlGbpb9PNXQehpgnJLsJtoIwpvHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Authority-Analysis: v=2.4 cv=A6aWP7WG c=1 sm=1 tr=0 ts=677e674c cx=c_pps
 a=MHkl0I0wjNeC5ak5fNlPUA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=vhHEnE-nI2wpHcbFAcgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: A276CHxlHgv9nT6e407yzMQKnP_ikcKU
X-Proofpoint-ORIG-GUID: A276CHxlHgv9nT6e407yzMQKnP_ikcKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jagannathan Raman <jag.raman@oracle.com>

add user.c & user.h files for vfio-user code
add proxy struct to handle comms with remote server

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                   |   1 +
 hw/vfio/meson.build           |   2 +-
 hw/vfio/user-pci.c            |  17 ++++
 hw/vfio/user.c                | 171 ++++++++++++++++++++++++++++++++++
 hw/vfio/user.h                |  78 ++++++++++++++++
 include/hw/vfio/vfio-common.h |   2 +
 6 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/user.c
 create mode 100644 hw/vfio/user.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b0f9b54500..153825b463 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4141,6 +4141,7 @@ S: Supported
 F: docs/devel/vfio-user.rst
 F: hw/vfio/user-container.c
 F: hw/vfio/user-pci.c
+F: hw/vfio/user.*
 F: subprojects/libvfio-user
 
 EBPF:
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index f897c5b81a..32ad5ca6b7 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -18,7 +18,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 ))
 
 if get_option('vfio_user_client').enabled()
-  vfio_ss.add(files('user-container.c', 'user-pci.c'))
+  vfio_ss.add(files('user.c', 'user-container.c', 'user-pci.c'))
 endif
 
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index a06115cd55..7610b47163 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -18,6 +18,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/vfio/user.h"
 #include "migration/vmstate.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
@@ -63,6 +64,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     AddressSpace *as;
+    SocketAddress addr;
+    VFIOUserProxy *proxy;
 
     /*
      * TODO: make option parser understand SocketAddress
@@ -75,6 +78,15 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    memset(&addr, 0, sizeof(addr));
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = udev->sock_name;
+    proxy = vfio_user_connect_dev(&addr, errp);
+    if (!proxy) {
+        return;
+    }
+    vbasedev->proxy = proxy;
+
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
     vbasedev->ops = &vfio_user_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
@@ -123,8 +135,13 @@ static void vfio_user_instance_init(Object *obj)
 static void vfio_user_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_put_device(vdev);
+
+    if (vbasedev->proxy != NULL) {
+        vfio_user_disconnect(vbasedev->proxy);
+    }
 }
 
 static const Property vfio_user_pci_dev_properties[] = {
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
new file mode 100644
index 0000000000..1c79fb1cb9
--- /dev/null
+++ b/hw/vfio/user.c
@@ -0,0 +1,171 @@
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu/lockable.h"
+#include "hw/hw.h"
+#include "hw/vfio/vfio-common.h"
+#include "qemu/sockets.h"
+#include "io/channel.h"
+#include "io/channel-socket.h"
+#include "io/channel-util.h"
+#include "system/iothread.h"
+#include "user.h"
+
+static IOThread *vfio_user_iothread;
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy);
+
+
+/*
+ * Functions called by main, CPU, or iothread threads
+ */
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy)
+{
+    qio_channel_shutdown(proxy->ioc, QIO_CHANNEL_SHUTDOWN_READ, NULL);
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx, NULL,
+                                   proxy->ctx, NULL, NULL);
+}
+
+/*
+ * Functions only called by iothread
+ */
+
+static void vfio_user_cb(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    proxy->state = VFIO_PROXY_CLOSED;
+    qemu_cond_signal(&proxy->close_cv);
+}
+
+
+/*
+ * Functions called by main or CPU threads
+ */
+
+static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
+    QLIST_HEAD_INITIALIZER(vfio_user_sockets);
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+{
+    VFIOUserProxy *proxy;
+    QIOChannelSocket *sioc;
+    QIOChannel *ioc;
+    char *sockname;
+
+    if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "vfio_user_connect - bad address family");
+        return NULL;
+    }
+    sockname = addr->u.q_unix.path;
+
+    sioc = qio_channel_socket_new();
+    ioc = QIO_CHANNEL(sioc);
+    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+        object_unref(OBJECT(ioc));
+        return NULL;
+    }
+    qio_channel_set_blocking(ioc, false, NULL);
+
+    proxy = g_malloc0(sizeof(VFIOUserProxy));
+    proxy->sockname = g_strdup_printf("unix:%s", sockname);
+    proxy->ioc = ioc;
+    proxy->flags = VFIO_PROXY_CLIENT;
+    proxy->state = VFIO_PROXY_CONNECTED;
+
+    qemu_mutex_init(&proxy->lock);
+    qemu_cond_init(&proxy->close_cv);
+
+    if (vfio_user_iothread == NULL) {
+        vfio_user_iothread = iothread_create("VFIO user", errp);
+    }
+
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+
+    QTAILQ_INIT(&proxy->outgoing);
+    QTAILQ_INIT(&proxy->incoming);
+    QTAILQ_INIT(&proxy->free);
+    QTAILQ_INIT(&proxy->pending);
+    QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
+
+    return proxy;
+}
+
+void vfio_user_disconnect(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *r1, *r2;
+
+    qemu_mutex_lock(&proxy->lock);
+
+    /* our side is quitting */
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        vfio_user_shutdown(proxy);
+        if (!QTAILQ_EMPTY(&proxy->pending)) {
+            error_printf("vfio_user_disconnect: outstanding requests\n");
+        }
+    }
+    object_unref(OBJECT(proxy->ioc));
+    proxy->ioc = NULL;
+
+    proxy->state = VFIO_PROXY_CLOSING;
+    QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->outgoing, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->incoming, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->incoming, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->pending, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->pending, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->free, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->free, r1, next);
+        g_free(r1);
+    }
+
+    /*
+     * Make sure the iothread isn't blocking anywhere
+     * with a ref to this proxy by waiting for a BH
+     * handler to run after the proxy fd handlers were
+     * deleted above.
+     */
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
+    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+
+    /* we now hold the only ref to proxy */
+    qemu_mutex_unlock(&proxy->lock);
+    qemu_cond_destroy(&proxy->close_cv);
+    qemu_mutex_destroy(&proxy->lock);
+
+    QLIST_REMOVE(proxy, next);
+    if (QLIST_EMPTY(&vfio_user_sockets)) {
+        iothread_destroy(vfio_user_iothread);
+        vfio_user_iothread = NULL;
+    }
+
+    g_free(proxy->sockname);
+    g_free(proxy);
+}
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
new file mode 100644
index 0000000000..ac7d15dfa8
--- /dev/null
+++ b/hw/vfio/user.h
@@ -0,0 +1,78 @@
+#ifndef VFIO_USER_H
+#define VFIO_USER_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+typedef struct {
+    int send_fds;
+    int recv_fds;
+    int *fds;
+} VFIOUserFDs;
+
+enum msg_type {
+    VFIO_MSG_NONE,
+    VFIO_MSG_ASYNC,
+    VFIO_MSG_WAIT,
+    VFIO_MSG_NOWAIT,
+    VFIO_MSG_REQ,
+};
+
+typedef struct VFIOUserMsg {
+    QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserFDs *fds;
+    uint32_t rsize;
+    uint32_t id;
+    QemuCond cv;
+    bool complete;
+    enum msg_type type;
+} VFIOUserMsg;
+
+
+enum proxy_state {
+    VFIO_PROXY_CONNECTED = 1,
+    VFIO_PROXY_ERROR = 2,
+    VFIO_PROXY_CLOSING = 3,
+    VFIO_PROXY_CLOSED = 4,
+};
+
+typedef QTAILQ_HEAD(VFIOUserMsgQ, VFIOUserMsg) VFIOUserMsgQ;
+
+typedef struct VFIOUserProxy {
+    QLIST_ENTRY(VFIOUserProxy) next;
+    char *sockname;
+    struct QIOChannel *ioc;
+    void (*request)(void *opaque, VFIOUserMsg *msg);
+    void *req_arg;
+    int flags;
+    QemuCond close_cv;
+    AioContext *ctx;
+    QEMUBH *req_bh;
+
+    /*
+     * above only changed when BQL is held
+     * below are protected by per-proxy lock
+     */
+    QemuMutex lock;
+    VFIOUserMsgQ free;
+    VFIOUserMsgQ pending;
+    VFIOUserMsgQ incoming;
+    VFIOUserMsgQ outgoing;
+    VFIOUserMsg *last_nowait;
+    enum proxy_state state;
+} VFIOUserProxy;
+
+/* VFIOProxy flags */
+#define VFIO_PROXY_CLIENT        0x1
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+void vfio_user_disconnect(VFIOUserProxy *proxy);
+
+#endif /* VFIO_USER_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 50afa944ae..afc67a3a77 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -79,6 +79,7 @@ typedef struct VFIOMigration {
 } VFIOMigration;
 
 struct VFIOGroup;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 /* MMU container sub-class for legacy vfio implementation. */
 typedef struct VFIOContainer {
@@ -162,6 +163,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    VFIOUserProxy *proxy;
     struct vfio_region_info **regions;
 } VFIODevice;
 
-- 
2.34.1


