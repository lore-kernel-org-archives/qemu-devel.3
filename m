Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B14C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9a-0002xQ-AW; Fri, 06 Jun 2025 20:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9X-0002vw-Ek
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9U-0006OM-Pn
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:15 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556NqBwU023142;
 Fri, 6 Jun 2025 17:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Lfi3fqoZwgLm7PZmiEhG+WX0QYLAq3BqEjm16KRZu
 qc=; b=skYCn+eoOjZUCzaFDv1pVfNUf0yuVZaOfOvoC4NPcdV1k0b/BitqL5kum
 GzPmV+Ss1NQn+JaK1r+6yxzHPOydN34SSJiU5Bh+zPgQoWNvQQly93vnC2Yq4Ju+
 Fl8QOHqf5Rxa9d9IECFXKFkVdWu5jZGzODGLdCtHN5A9ECf/Pc+jpfy7FoJoTsLc
 37/1FAsOY1s0LL3sGu/oczUoMGNyJyRlLk1yTC/raHmM7rbFookEbZKaNdEgKm8N
 fWmltrfqXHcizOSDQmjpkmc36HVlOyU60j92gNSQ4UJ5DNjpyVxgCSWk6G9rK1hN
 Cm0hOBf4UZr5qA2aDniWsBiXIwVnA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2122.outbound.protection.outlook.com [40.107.223.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdsvwanH7XOLGiR4S9szyg70LmwiEjOrKJd2qv1n/uh3JdWoYl9EkLclDuquiUBdOMkfPj0kK3fmM+VIQTvWxsx6SzvsuZsALJfvP9uDQaMhCOUnMFrDNC0K49OeB2tiPiOY3o1Y9Sw2j8nQGmWkoRChAWquwlS91yVcomSSoevEFPgezGtGx87G0hxU0eBDePB07b/DhgeBDU7GLCGGuEhJs4UytLkexBDC78DN5sgUIrLW2X8EWNHg62k+UcKI1nbAOr9XsX9+ymB8uAOXnUOeqf6S9phT577zrHyvzsp3HqtFBROcm0U22u9wdN24giUXzcnilRRQdjxl+gA0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfi3fqoZwgLm7PZmiEhG+WX0QYLAq3BqEjm16KRZuqc=;
 b=kQ/YCI7Z48AtIxttoMit8p81nJzU9R5zYx3OeT/ij8ZfcTByi+AYgF/QBWL/VKuG/lMZc6vUwQ+dBbBiwT6+9l/D6Bu9AMXLhOj8ebFiuEqtA+3NY5JHiaqDjI3nKNvF4oaV/PwdOb8PUQEf+jTMu+ss8IqTZG67urCwsSLkU390d86VPWuch5Lg6wMxGXAYR8OnWV6XrB8XaClBsQEBFuCSS9Guu7HSZIX0iS1rHbhSdSfpOq3EkjGDjI/8pF0r/X/p9Kk5ZPysZdfDK849HEDG099lAqbyDLCO5OgJHnOXBotGQK/WrwMzkrz2ETPH4VRqY+vheG5/naBOC+bsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfi3fqoZwgLm7PZmiEhG+WX0QYLAq3BqEjm16KRZuqc=;
 b=WQBZDQXICz6OOOkUEZuv5nUo1qdl6niWctyoxpt6mg/C8Yg0A3lkJxMy41rd+N24VKpvSDR44Zk9DMXoqJBUl9O4fOxiPcYIeiQwKKmBmteZtdbCBmPCe42ObuKMMxheyhiIGFPuuRlZtSDPTSBBNqiaQEvMJHRg0Q+oHp1zZkPlqzfhvCkv43KUymoeLKGHAe46vE3Px0QJdA71zkAHN87g9DH9lKJAZsNc2R6OpwnXNR1RIZN0LK0V/I3MMIsOG7DbG7aIXXIpRqTaR9uHZoZvoeA4jSizxnp6A0D+xcrIPwqkEqF6D1PMtG80r8/UjPPiOKDlrMQgdZJhNtdrCg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:08 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:08 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 07/23] vfio-user: connect vfio proxy to remote server
Date: Fri,  6 Jun 2025 17:10:39 -0700
Message-ID: <20250607001056.335310-8-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adf2060-d392-43de-c991-08dda557cd8e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3JhQzZPN1dpTHJkSll6S0lXUURTbkdRRlhRdnlIU2tuQVBwTnRsdmphVUFR?=
 =?utf-8?B?b1I1Wm5UQXZjSThUNllNU2E5TllwZ3p3VkRlcElEVXRqMGtFcHR6MmNCQkRT?=
 =?utf-8?B?ODRyYXVaV0F1c1pqcE50TEppZE9lTS9ZV1VQK25Bd2tFSlAvbHhuR0Q0VDdM?=
 =?utf-8?B?bTcvdUNDOTFvaXArNURWL3haYjJrdE1FOGs3Rllkc0xDOGJmSzNwYUNhKzdD?=
 =?utf-8?B?M2JvMVM3T0xGSlJhSmpCWTRyWlNzSDJWUWd1VEtNbTROZGsrc2J6c1VpS2Jo?=
 =?utf-8?B?ZEwvRXVBMTR1Q0R3cDgxS1RUdmdHVndRMmNZOXNheFRnU2dIM1VQUStwSEtZ?=
 =?utf-8?B?WGRyNEJLTG1nYzIvSUpKRTVRbllDUDBmaXNVT2RwM3dBTGhjckxlcnBRcjhO?=
 =?utf-8?B?QXlBV28zV2x2cmpHVHZNWlZaam1LR0l6ZWgvUzZCK1RjWU1KZjMzOFV3WDVD?=
 =?utf-8?B?eWhUeVBxWllUYUxOVWhVSkxQOHJjTDNrMjVCNlk0MmxJVExsS2FiNDhvcDVz?=
 =?utf-8?B?NC9MN3Zlanp4UFZNN1NhUk5VLzVsRTgyYUJaejRpYmEwZTVwZnpPbHRKWDh5?=
 =?utf-8?B?bVk3ZUorNTVudjBqVUlMTE9tbzJSYmNMWXVKQ3NOWWdSL2wvZWExNnNiQWlX?=
 =?utf-8?B?ZnFKUldCVk1HSEgzcmRKRGlHQnBQTjB1dW4zYTdtZGVZaWJRYnpjTHFoQXpP?=
 =?utf-8?B?SFpUUk0zWEUzaVFmNXBDeVdKd3doTE5EUms4WjBmNTVPMWIzOEVIZVhaQ3Jw?=
 =?utf-8?B?eDVmVkk0bEQzOWtKeXp3RzhzRE04TTBkeVVJMThCVGJ2Mi9paGhUdlZJSGZS?=
 =?utf-8?B?M1owTE9IMkVSTXB3ZThqTmorRmNEYkViUEdQOG9FTXNUTWswREpUQi9QOEVB?=
 =?utf-8?B?NDVTbzZ0UzRhMGlGQ1RIK2ZiS3grVXd1Z3JyRHdaN3MrUXloY2VGK2VnZVJx?=
 =?utf-8?B?ZGd4RUNaUVdlSUNkNGpRUk0zR1dnWjNQbTdSS3RQUnJQR2dEU1J0Q1FtaXJr?=
 =?utf-8?B?RnBMTEtURVdJTjd1eUxvajdtekwrUUhPQnVtRDk4TWRhV3g5dUdudkJNcGUy?=
 =?utf-8?B?Q0hiVEc0U1ZVUURZREd1RDZxMkhYRWl1MytVQU9ML0Z0N2tVUUY4S01FNVZq?=
 =?utf-8?B?c2FMNjNUZTEwdWRxVU13V3JiRmxsOGd2MzRqWkdOVzk1NW1sWkJDZDZlbWt2?=
 =?utf-8?B?aTN4QlNoYUZYRUdlWDBseVdjdkNpeVd0ejRrRkNyTmRhRTlaY1EvL3hySDNa?=
 =?utf-8?B?bFNYNUxZT2l4aERkNnFkSW42KzRPYjk1QkpLcTBpVm5RLzRraStaWkl5V082?=
 =?utf-8?B?bmVCVlJUVkovcERicW9tek9NZDAzbE40Y2JkS0lLcUkwMlpzV3h6V0NyRkdT?=
 =?utf-8?B?WGZLNmNYTWxEV3J1eEhqYTBkbHdoMmJPclY4OWw5VWZzNGF5cXBwa3NGcDBH?=
 =?utf-8?B?RkZ1cVVaVGNrU1ZGUkhDZEN6amY1VU9POGhoZ3prdGRhVHZrMnFtM2dOM0lZ?=
 =?utf-8?B?bERuN1FJTG5iZXpJZFBEYXM5cCtVZG01dGxJcDhhTkZLM295b0xidzNNTjRT?=
 =?utf-8?B?dUcyV25UWXVMRHVwckQxOU1EN2Rvd3paS2lrZE8xay9nelFoVkhvMlRrYkZM?=
 =?utf-8?B?Uy9WbmRMLzNLaTlTSjZHUHYwMzFhRmNqaFJYU04rcVdidlA1QXptWHBrSkhi?=
 =?utf-8?B?eHpjZzlTR2ZVaWlXRGJnV3N4MDU3M2hMeEdxQVVJcHZPQXBFVUw4MFlIcVFv?=
 =?utf-8?B?MzhZQ3ArUWc4TDJkemlibEw5WXVkVExrQkNidUpyQjJZVFR2cnlyNGtSTjM3?=
 =?utf-8?B?ZGtHZWVOUUZqbzFZa0xGRE1JVFF4VEtjL2JmOHdKTzIxaE9xZyt4OXRoTWto?=
 =?utf-8?B?dFpldEZQMlVoQUZUb0ZGWithWGR4WkJyVkdhS3ZBYXd6WG9mUzRiN1d4UDI2?=
 =?utf-8?Q?mSS3YymiLYA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THArQXBoZ2QzQVRaMDNnV0RjOWliUE9mWjJicVdCU0NrT0NCb0VHK0pMUmhi?=
 =?utf-8?B?UUlweTA1WmJOMnZVWGtjT3RleTJhRk1YM2VZbFBVSEFsWHNKTFByeWxuRlpy?=
 =?utf-8?B?NDI1S0VFMTBLTGk4bkZLQ1FpSFExLzl3Q2o2TWc2dThNSGE4OENrZHZoQjhN?=
 =?utf-8?B?MUpjbXdCVThRenlZS1kxTHAybkwxY2dNcjN3aE5CVk53bVNweGMxS1d5bEJa?=
 =?utf-8?B?THhIc0pxbUtuV1NlbHMrS1YvT3BlTlp1WUZKRDRDUmNhczU1aVE1S2VGVnNw?=
 =?utf-8?B?WnU5aUo0bUFlaWZXMTJuQUozTE9oKzJtS1RlOEltS29vVmtyK0ZUOWpsUlJ5?=
 =?utf-8?B?bmJuaEtaUUpLWjJjekVPUGFDTFhiWklqN1NGN3ZsMG16OXdNTEQwM0VNMHJ4?=
 =?utf-8?B?cGo5aTMvWGM2M1pHaWlReFR0M3JRL0NLT1FqNzQ1QjZ6T3pyaW54bXNpWHE3?=
 =?utf-8?B?UjBiUkUrMEJtUVdsYk1yS3hvMXZkOXl5YVdOY2gyL3lianJuY2xFNzZpLytG?=
 =?utf-8?B?VWtQdSt0WEpMa082SzdFaEsxTHBZV1Rpc3pZQUYyNTFWLy9yaWNGZk9yNHlF?=
 =?utf-8?B?Rno3MlZ6MnBqMXVzODVXM3FWak9nWkk4SXVETEtYQ09QYmVLNjNtS0cwaEYy?=
 =?utf-8?B?MGNnNGIwdWlBamlKQjBBNDhZUk5GT1A2RGtXOEdCb0F4WEJzZEJkQjl3SnFR?=
 =?utf-8?B?NEJnejVrN2p5NUw5WERFbjZ4emZYTnV0N0JCbWVhOUFnSm5XWHMzL0paL0Nh?=
 =?utf-8?B?T1lkeWVCNkJGYzFVY0dIRTNiRHNFdVZFMXlNZ2NXYVI4Z0RKMzhQN3Vxa3Ft?=
 =?utf-8?B?Q2JzTjBGa1ZUM25nLzFQeFhnazVYblhvbDM5SWxvWGdjTjR2bFR4dHpiQWxJ?=
 =?utf-8?B?R0wwcm5MejlmaXpjQmtuZFdwbUxtSjdzN3Rxc1lXU1VhZGNSWkU2eEphaXQ2?=
 =?utf-8?B?QVZQaHY1UE1RNk4wYnNBR3RHbzJWTmNsQTA0bWQyUGJUdlhyaWl5OFNhVnFL?=
 =?utf-8?B?TjBGZ005Z1ZUc29mUnpIWEFBaStxcXJGc0lVRjRFQUp0Z3NhQUVkcXVQRnp5?=
 =?utf-8?B?d0RuaWNwaFpxT3NMQ2NkSlMzVTloVmJDcThxYnd0UFNjTTNaUitwWG1STlAx?=
 =?utf-8?B?bDErNHB0aGNKQ0FHMHIxaGRKYWNJektaaWZDT1owRW12b3U3RGhXamF1MzVQ?=
 =?utf-8?B?Z1RocElOVTN4QTYrVllrTzFuTkl0OGVQRHRTQVZqL2pKcTJIdlRUR1dXeGc0?=
 =?utf-8?B?cUljalQxanNHdDlsR2N0Y1hnVW9ZcnBJSlptZGowbk8zaXYwVG9KLzlKVVFj?=
 =?utf-8?B?MDJPR2Njd3VaVzd6ZExmS2MxRkhyVVhIaG9ORVNzdGJmU2xuOUswM3U0SFk5?=
 =?utf-8?B?bVQ1SjYxWDdSMTU3WVVEalpOb3kvVXJlV3dsNXczekllWVpVczZKckpUa2Vo?=
 =?utf-8?B?SWh0LzVYMmR6Q2VGQ29wT3Ztd3lwV0ZzdU9mMDJ4R0hNNGxUZVpEN1Q2b0JG?=
 =?utf-8?B?RUFpWGJxendLOTN4S29CZklsSE9OTzl2cFpSZWZGWW1EK2k1K1FJNisrZ3Vy?=
 =?utf-8?B?a0w1c0hSWjhSR09kQ1RnMnB5YmRuUUdkY1Rkc29MSU1TM3gvT3l4blQ5K0ov?=
 =?utf-8?B?L2dxUmI3dlVNMlk0Qm5wSFFHL3FmZVBMN3FQeEpMT1R3VklXdUlHR1ZSc3dC?=
 =?utf-8?B?QmxUSGhSclhLWFo3RmRZUDRMcGtNVi9aZE5TcHJHb0QrUVJRdG1FOUNpSHNB?=
 =?utf-8?B?b211emowWWtyUFczWlVoWTc5NnphQmIvOTByc3I3ZHB1emtkZ3BmVDI3V0k1?=
 =?utf-8?B?aXNUelZQNFZwcVR5OUZxTmFjUGZpcXc4VGVRTVJPYkluTWoza0JKUkhRamRn?=
 =?utf-8?B?Zzl4SkZuYThiN28rbkNoYnR5c2YxeTJJaE1iWWlsb1pVcGRMbjFRUWxQbks0?=
 =?utf-8?B?aEt1a2JwQVBuM1I2TmVsb2hWbWhaT0NDM0s5QVYway9BKzUwL1VrS0RzMm1a?=
 =?utf-8?B?aFdHMW9LMFhLdFZPYzNTYTBYK1JGbTdia1VmcXh2dy96d1h1WHRvRHBrcWhq?=
 =?utf-8?B?UEkyVHdQd0NzZ2o5bEpYaFlHVTFNcDAxUjd2aWdSNktkVVFQRkRTdkxFTWZk?=
 =?utf-8?Q?RFz46UGlst4x1BXVK4w4LRQ24?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf2060-d392-43de-c991-08dda557cd8e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:08.7640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNKQU9lLHhczih8+APq1XGkl0sSQG2qHSsilExV0WbHt5nh+jrkVibVfdjhbDXqEoFE9QRjGWIhQanf84HOIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=6843839e cx=c_pps
 a=E00YimykegQh2ruOzwX4zg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=vhHEnE-nI2wpHcbFAcgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dcrF1k0oejixIN6JznsyFcSZlsLdW-bX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX5zxuADkksZ2Q
 f5XSz0x5cnlei9mo8SBGH5hnlW53FoWehYiSXacgU9xdarSOmZdLxMDiYnOwJ4ydfAhcGtvD3EH
 YNg+xmAYRbMrsqc11TLSGWkoKp/IG+H9DaT76Cz7aq2r77z5FnAGypJVBguObzyeqKhCEypDZ2O
 F5/un80cdelewoxrVuRMyiwp1CkKBnQl2SKl9z+4uZosN5K4d/220TAustTDluv41oiD7Vhhgxu
 vjnbbJApH6GvoDIpVta1JFgPcx025InG+VMy/mkq9vLIhLaRVDbqfVtoDHk14tkJdjytZA5VEVU
 uXqi7F9KgT08OKNhso3jMtZDL3EIZO/uMg3Al9oyuYzb6cHIrmr9oBLEGFDicPNsnDqKrM0Y0Ra
 PkyAGav/AnMEGQXgU/PHWZvFAhA2sDmgnWhH8u0e+j03o3Iw4EOoFrk4f+ywzb036i4bmGqR
X-Proofpoint-ORIG-GUID: dcrF1k0oejixIN6JznsyFcSZlsLdW-bX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce the vfio-user "proxy": this is the client code responsible for
sending and receiving vfio-user messages across the control socket.

The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
managing the proxy; initialize the proxy during realization of the
VFIOUserPCIDevice instance.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h          |  82 +++++++++++++++++
 include/hw/vfio/vfio-device.h |   2 +
 hw/vfio-user/pci.c            |  17 ++++
 hw/vfio-user/proxy.c          | 165 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/meson.build      |   1 +
 5 files changed, 267 insertions(+)
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/proxy.c

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
new file mode 100644
index 0000000000..60fe3e0b6d
--- /dev/null
+++ b/hw/vfio-user/proxy.h
@@ -0,0 +1,82 @@
+#ifndef VFIO_USER_PROXY_H
+#define VFIO_USER_PROXY_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "io/channel.h"
+#include "io/channel-socket.h"
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
+#endif /* VFIO_USER_PROXY_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index a23ef4ea13..09f1a21bf8 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -46,6 +46,7 @@ typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -86,6 +87,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
     int *region_fds;
+    VFIOUserProxy *proxy;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 74b0c61f9b..f1a2d4374d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -14,6 +14,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
@@ -55,6 +56,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     AddressSpace *as;
+    SocketAddress addr;
+    VFIOUserProxy *proxy;
 
     /*
      * TODO: make option parser understand SocketAddress
@@ -67,6 +70,15 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
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
 
     /*
@@ -112,8 +124,13 @@ static void vfio_user_instance_init(Object *obj)
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
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
new file mode 100644
index 0000000000..ac481553ba
--- /dev/null
+++ b/hw/vfio-user/proxy.c
@@ -0,0 +1,165 @@
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio-user/proxy.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "system/iothread.h"
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
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index f1fee70c85..695b341547 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -2,6 +2,7 @@ vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
   'pci.c',
+  'proxy.c',
 ))
 
 if get_option('vfio_user_client').enabled()
-- 
2.43.0


