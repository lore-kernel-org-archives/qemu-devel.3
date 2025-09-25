Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E2BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFE-0008LN-QK; Thu, 25 Sep 2025 07:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDs-0006aP-HD; Thu, 25 Sep 2025 07:33:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDe-0008Nc-D1; Thu, 25 Sep 2025 07:33:15 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P85WCD109131; Thu, 25 Sep 2025 04:32:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=O2Q3SHtoePJua5XGkB7e7glEAYa44CCFYEpZfmsN1
 Gg=; b=j95TxurYJyj0i+FG4w5+yXO3VOH733GjIltaRHWO5M9Z0eEBeaL3XGo/z
 m+wddGeLonaHonR0UFJ02o0shZ6IFEp/W2CrEuLlFawJFRiZ626JXDw1LN6f+bl0
 bSKF4Nv+ViLzW4KxpmlSBD+8+w/DGTktYhNXfjvFIhrVyY+RnHN286srmBWhIygA
 K45ox2KRY7lmJ4eOnZZrlsrwirr/XDSkrANccsFnCw9KvjRSg0iQJmByGfHZiGQY
 0bAq7hp/+0WAQAXn/oEkzFQ2QNUMA0wH/EopmCmdwM0qN6sLVbTsTIgNlyat1aC2
 GikPjXZiQwJIuc7EgPm6aHQALctaQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021073.outbound.protection.outlook.com [40.107.208.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1x08e0e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyNNnHzzedpqwyHiKpqKCaYqByeIghPu638axe6z1jsRCpAF47ueX7awHUJ9orArF5z+ajlZ/j5IuLPy5ePVPQVIQtiW9u55l54o9d7h6VWLTCkOvV3UTKal0W4DvgFdJcIvK0Oik8GdzaQ6YW3SYNkxAnGGvgK2Hpmtn9hkOuRZgTwzwZWHdM+t/B+P8nlmTzOoMDqe94hCOW5562W9I6o8husVUzHWtMqhNjST+zA63LeTSSUpQmzi0AlTl6IeX+YwKhq6zmo/uC0RRVrL4Z3Wx8AUCGfJop6yI1P5SJ0tkfu2iIusLpo8me6OlishSV/fucdkhJU5oLu2KsswmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2Q3SHtoePJua5XGkB7e7glEAYa44CCFYEpZfmsN1Gg=;
 b=YpE+BeMcMutwt6MjTfND96iqCIglhxCYJK8PEqGSdNoPCWMUx+fE0o3PH4OaZi3wwsXj6aM5/E8oJcBTV10lGos+1G29LQhLP4DG+f5oNRDW2Hw9YeHSYCvuTBXXsnpNO6vVgCz+v6CIqNw9FdSjjRyAFyE+zuQoW8SNqi/xLHzGTMZoQPYsvB5rAz9AxCc//ipGINwdsJ0MxtBlAK0p3ltwlPvGUk6fB2aogZ65cF11FT+CvqjkMVh9o2Iqu14i64xTr/+Mr0CBHRywdpl4o5zJjbEbyvPShrN5GEjuWiAttiIhtYW3S4JwBVWTF2WjY4RRFbIKpPOjgGxtLrRs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2Q3SHtoePJua5XGkB7e7glEAYa44CCFYEpZfmsN1Gg=;
 b=bbPsMzePEQnETZLJvJPcnGj5JL0HhI3/VGy3iibyJsvthys7B31pb7KklOTl0zREmRENrwtje1hlDVdKcfp6rpEu1usmdAxVmOknxPKbuw2lBevtpWKVBaYBtFeBBqiaULY4WorRIoqY5dEqUwQxAIduLcw1i/Hs5+Wfq3FVrwopH1tAHespxpgsgP9C/76per3x9hP/N0/idSa/qnFk4kKU2MtvhIB6fH9X8C64/cATT99R3MBpUNH7NNHlpnozlySaEssYSH4Gi4ZNFYXTLf2VuOUm3mZzqtvntFaHccEFBGTAlF00yJceH/+Yx/vFErT/lBeUDouZ3JRw4tLQqg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:32:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 14/28] vfio/pci.c: rename vfio_pci_dev_class_init() to
 vfio_pci_class_init()
Date: Thu, 25 Sep 2025 12:31:22 +0100
Message-ID: <20250925113159.1760317-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0407.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6b5253-eb67-47e5-0394-08ddfc274389
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGNjYTJtNTMzMFo0dG15MFI2YVRWSWwxZ1JyNFZNc1drR3BwVnhRbWNLekE0?=
 =?utf-8?B?Y3hrWnNmTDg2b0lDSnpJWjVWYVB4dTZ3ellHYTI2K2o5K2c0V1hTVkJ3d0Ry?=
 =?utf-8?B?S2M5K3BkdVczTGU4cnI5MzlUY1U2a1diWE1QcGJwRFByQVV2azRXTWJKbU45?=
 =?utf-8?B?cVcvQ05YUFBpTTMrelZMNjlmRjM3TVBGazROSStqR2VJNTF2Yy9LRWt3cXZn?=
 =?utf-8?B?TzJQWE9RN3dhTUNmWmpJS2VRZnYzYTdDZFpHVldOSUVQUjJueWxmT0I2TmRH?=
 =?utf-8?B?cHJOZGQ2NWp3UENhWHdXOGJiUEF1TkJIOEhOV0E5ZmJYNzNBdHd3WWdPekVG?=
 =?utf-8?B?a2RYSlB4QkZSd3Zza1VVSjFsOCs1UkdpUmZ1WmxXTHhoQkxWVHcxLzFlejhj?=
 =?utf-8?B?Y0dtbi9aQmpwWXM3aTRvQklVcENiRXhYK0Y5NWxFazc5enlVSE1EcWlaSlls?=
 =?utf-8?B?YnF4QzljZytaMDA3YUtsM0VQNWtJOEpFZW9wRFpndE5aQXNYNmRmVVNjWGo2?=
 =?utf-8?B?UkZJUVZ6QUZnMEl3aXg0ZjhMR2Y5M0pTZkZzS09Ma2NwYXB0ZmdyeHN3ZTdV?=
 =?utf-8?B?eDhaYzRkcjJ3OGxBakpjTURrWmxSZG5NWnlnYzF3T1MzM3IrV0ZqcTFKblBp?=
 =?utf-8?B?N1cyM2lOalNEcktUVlVqaEUrMnBIajFZakRLVncxcEYwa3M5ZS8rVmNiSXVZ?=
 =?utf-8?B?QjMzZ2VFOHNCVzd6dEppK3FGcVJyNElRbGs5ZkZMUFA1RmhqNnl5TTdRb3Mv?=
 =?utf-8?B?RW9GTTZEUkdYZnZLbGFMVmJzYkhMNjFKRzRrUDkrQzQ5dmZoOTFnTnUzZCsr?=
 =?utf-8?B?dEJpWXNHNzJ3d3dRdFdTNXBWVk90aHhyVmhpWTZTcllLYy9JZks0M0lKVmNL?=
 =?utf-8?B?Y1JCcVg1a0JPdFVFYWtGL0diRUljVFJ4SXIwTis4OFd3TEVhZHNvcGxPbW9L?=
 =?utf-8?B?b0wwUkZTeWM0R0QzN1pBMkM2VXVBSHJhNmlPYUtmdEUycGlGYXdkQm11R3N1?=
 =?utf-8?B?cTduUTR5TkZ5Y1FpbW1JVkl0aW9ZWEd3d3pIRmJTMUg4OWFZUlFiOE53dE54?=
 =?utf-8?B?dDJCajk1WHJSblBFMmx3Yi9MaDhHV1RYUW9wend5VFRZdjcvVUp5aGRnTGts?=
 =?utf-8?B?d2RyM0dHRHFKcmNXeDExald4MzZRdS9LOXI5b0VqOW9vOUh2cXF5UkFQVmhl?=
 =?utf-8?B?Y25CRjMrL2lNRUNSQ05mSDRBbERvVDgxQkV4ZndlMGNEdFN5ZDBKQW1EYTVU?=
 =?utf-8?B?ZVVLYzJPSXdpekN5M2hUUklxQmhXdVlPa3ZnbXY2VWtxd0tBaXgvWTd2OHpY?=
 =?utf-8?B?SFlsOGZkWVVNS2NVVXRoNWtwTC9Ba2d1aFRmYkdxeHV4STZxWFlzWFZwM3Fj?=
 =?utf-8?B?elp0U3hsOVNjTjc3ZjdrTmd4cGNLUXFkb1dQdFlieTRMVjNwQndMNTRiVkUy?=
 =?utf-8?B?eU9PcWp1ckFtYTU1bllHa25PTCtjZDdkeWJzMXhwbllQcEM3bFZ2ZHRESDU2?=
 =?utf-8?B?eFU1TXZBbHRtMzc5ZU5xYU5Dd21tVDNLYXliVFFGY0RKZFlQVmpCa2pIak5P?=
 =?utf-8?B?OGVPU3BFVlN2YXVmWVFjampINFI1dGpvWEhraEg5cld4MFVDaC82K0JGdjdX?=
 =?utf-8?B?YVV4Sy9CMUtNdjJYeUo1R3N0MVpUb1M3Q0ZZNXd6Ynd0RTNSY0hiOE9hRHli?=
 =?utf-8?B?UHNEWkgxNFh6bC9MNUFySWRHTFBTMDE3QjFrMWVNU1Yvb1YyQnVGeE1Vb2RX?=
 =?utf-8?B?UFFlSURFb1k3RFBWeGQzdXRjdGJYaUVNWVh1R2IwYTZrRVVrNm1wSkZVdnFL?=
 =?utf-8?B?TithRlhURDlRYW9yOWVpTm91dHJYTVBOWC82eXhhckY4RFFmWEUrWHc2WGRs?=
 =?utf-8?B?M1A3Yk1LZVRRM0xPcTFZR0k2TWhuL1doN240T0NTTnRGTS9naU9MMU0vMTYy?=
 =?utf-8?B?QktubytOWnBpN0pieDhUSjdkL0VQNmhJbGNnNE5BN290bTVtaEZHUGRHNUVI?=
 =?utf-8?Q?tblAH8N9/zHu3UtLPdPhlhPiJYLJb0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNmZ2hjdjkvNmVlOC9xN2o5blpQV0FUVmxFcW5yVERXajBNODdIZ2RON1Vp?=
 =?utf-8?B?NXBxaUJHSnphQ2ZHSkpYUkN3cVpQS0dQcWJkR3RZbEtXaVlOUURKckNQZ1V5?=
 =?utf-8?B?NTFoRzlQSXdmamx2NkxHOE5hLy8zQTcyOVNsN09ER1FWc3R5ekJTbjBCN0pz?=
 =?utf-8?B?KzZlZ3BDcTVrS1VpdmIyVzRESUJLQXpJS0pyanZLTTdGYjdmOFhpQndUTVNP?=
 =?utf-8?B?bkRxRDVOZGgzbThOeFZDWnFDREJOamRUejNCRnV6dld1TUxLMmlYamxNSTBr?=
 =?utf-8?B?NEM1WDFHWEVBbkY1YTBFNllrWW5wM3VmRzlrTEU1OXFkUHQvWU9jVTF1ZXBt?=
 =?utf-8?B?WmptTW8yR1Z0YmxGRzJHUEpnQzNXVldJVlZDVGtsYTBkTDJyd2JreWxKKzFq?=
 =?utf-8?B?UVZwMUd0L2l1TjhJVG92Y2JteFcvdlZjeDBsd0hTSUhQYm5qR01ieUJCNms4?=
 =?utf-8?B?Znk3L2loM3pjTGltREhtWFB3RitlV2Y2ZVExcUUyY0xaQytuRmhqeUdlY1RB?=
 =?utf-8?B?ZzJTanpMbVY1bDBqTTJtNmN1VjRra201NmFuVkZOTUNaaE9CaUx2TkpSNURk?=
 =?utf-8?B?TXQxT2dncDNCSkVFWjNHL05xWG1zNlM5SmpTUW1mc1FodGdDb0hEZ3BIbmRS?=
 =?utf-8?B?UVJMQ3ZsYmMxVUVveFl3NEZKTGNBVU1KdFJsWWluUEw2LzJuSDRBYXYzdzZU?=
 =?utf-8?B?Ylk0U2puQ2xveXB2WUhLY3czZDluRE0weTExTkVnVEtCeERkR3Ntcjl2WFY4?=
 =?utf-8?B?Sld0MWJkeEVKR3c5M1lxRm5pZ20vVkVNcm9nOG56N2JJN1hxK2wycDJoK251?=
 =?utf-8?B?SmpRaUtQUENhQlFiOWJ1QkJrcUFjeHdUOGgzWkg2aldoRVJzdTlWc2M5djNr?=
 =?utf-8?B?SzZORG0yUWdhZUxMS3ZRQU1ucU9jWjN0Vk5xbzFXOUtsRXpNRXhOQ3FUY2k2?=
 =?utf-8?B?T3pWK0s1Nm90eEtscnFhVW8xY1ZnejNwLzl2QzlHWFZSRmZiOEZQcm40bDRU?=
 =?utf-8?B?WTErYWZEUXIxWnhQbnlINXNtNFpERGFuUllybUdZNll2a0pwQU9KMXZaUk1a?=
 =?utf-8?B?aFhqd1dLS2pHL052ZjRtN2k4YjZJeGhPOUM0TWJtVUw1bWJDOFprczJXK0xE?=
 =?utf-8?B?eXU0RlNGVUdkZ0xqZkRPQ3FMVTkyRXhqMVZOY0crODZ3alJOcFVmKytSMFZM?=
 =?utf-8?B?K1k0WGVENmg4Q3RqdTZWQ3p6d0kyZUVZV1Z6dlRlRnVVZ01jQVUwd1VrWXZn?=
 =?utf-8?B?ZnB3aWxld3B0aExKcGdmcjNmc1E0UGFtUXhXWHM4dzRweDY3MGdlOWJJUTJI?=
 =?utf-8?B?UUFSTlZkR2U3bHV0NnJROXAwVndHTVV1cHNIb0xyZHI4dGYyRUlLYy9CVmdP?=
 =?utf-8?B?TVNiajIvVVdZK2FZU0d1cTFzWXBrbHV3NkRPQUhjYzVVSkM4LzhzVENMMlZX?=
 =?utf-8?B?OEllRlUzakUyQThSMGI3OUUvYzl4RlZOZGI2Qy9pRVpWVlp2NW41ZjVPMDQv?=
 =?utf-8?B?S2dVVmcyTGNBYlh5L0k0aTkzcXJ2Vys0SmVqRUxVSzlFY1B1d3dUZVltWnhR?=
 =?utf-8?B?SmNDVmxDYlVTQU9kRXlMVFB0SzZUdi9idmxPcmgyWklaNjN1RXQzSDZIS0ZI?=
 =?utf-8?B?NzMrODRXaWVOcWxvbTE3M29MRlJycXJSVzJNbktlSzJRTUlhUmtiVjM2L1k5?=
 =?utf-8?B?TTh2NW5rdWtiZHRmZ3Z3THN6Yk45WHAzQ2xTR0k1QnBkWHlPZmE3elZEb0JQ?=
 =?utf-8?B?UVpMMFdmTjViTktTYW9pbUJ6cEhvMUFBZXZCaTBRSHdBZ0lSeEl5KzlSbEtV?=
 =?utf-8?B?V3dwYVRTZ3BMMmwydDYwV01wSVFQSUo1R1pJVkMyRVZyWkNPbFV4U3k0cHlF?=
 =?utf-8?B?aGg3bDJaMm9MQWdrcTJWaC8yRDM4TkE3NS9QRXFqczNPRHNmYzFNaTh4Z2pP?=
 =?utf-8?B?Y05ZSzNyajBHTE1rUDVjaWhiWXBlK1kvUjhacnBqa2w1UkpSczV4MTJaZDZN?=
 =?utf-8?B?aE9mbkp2RnNRaHo4SFhReEllSDFoQ3RNQ2dYWWtCYnhqTkFZaVl0TTVBYTlu?=
 =?utf-8?B?MkVOL3R4cnprZDBDbGlsWWdaMTdzQUZRYTR2TlNTSEVoWU1rOEl1clljMGpS?=
 =?utf-8?B?dDlzOEh1U1VGd0w2TDQvc1FyY2xzZldjSG1Qd0VGSWdGRTZtc25aZmZyV0FH?=
 =?utf-8?B?bDVabFIyWjFEZ0hqeng5em5QTHNBM2l2VG8raDJnZlU4V3p4U0xzTklQT0lE?=
 =?utf-8?B?NmVXVmh0R1FKdWFJaTEvbis3cmtRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6b5253-eb67-47e5-0394-08ddfc274389
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:52.4444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AegdD2VukuvmVrp28+kPQOyPNpIXPITJX3saNpgBjcx5lPwopG0/lxKlAoVeJ2OJO+GpBemP26dmaYbeEr1gafDbIrYxBEmXvsAQ8q/acUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX8tntGQ4mr5fz
 wG5QGsfR9Sg0AugW9flAfdUlMCQBQAFw2XduAtxs6vk1QJPrx/XASNkR93pJrLzV5GamBYmK7k6
 IaiBIxmNx8f11X3LEQa7g7IFHIZ+5lzFB6CCjQaL8NtPyJT9TkBmqz702+UNbnwP25tZmlsaPaV
 TD8eQZM8gn1xLY/pkKNTfT/FCEsDuxd9+2ESsXRMWo1SAgAY1geU/p4VsqcqIw4FLOH1GcKmXaK
 GYkW1NGxtCH8q894ohVQrZIa8+ZnelFT0Aw9BNr6LBKlMBQlxQTRdvsgIlPf40J+J2EmF5CDQvf
 DTHa6y+sxKrcK++NiZAuHp/HasME9OQCRqk3Z+ybncRhbbFo1EvPO2HRgOleco=
X-Proofpoint-GUID: rQx8Hohk3echkEozHOOqNYMQh7ow5IKs
X-Proofpoint-ORIG-GUID: rQx8Hohk3echkEozHOOqNYMQh7ow5IKs
X-Authority-Analysis: v=2.4 cv=XvH6OUF9 c=1 sm=1 tr=0 ts=68d52865 cx=c_pps
 a=f2HnxUUJxMzVcYZpCdj5LQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=udP_5BOVWkZL6ct6w7QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This changes the function prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 90458bc3cc..1fd087de3c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3763,7 +3763,7 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
-static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
+static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
@@ -3915,7 +3915,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
-    .class_init = vfio_pci_dev_class_init,
+    .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
 };
-- 
2.43.0


