Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B32CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfU-0001jy-BH; Fri, 22 Aug 2025 08:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfK-0001ht-3s
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfH-0000mV-UF
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:41 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7Ln8I667767; Fri, 22 Aug 2025 05:14:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CGmhTVBvt85m8HvBjKXZAGnavsORO1zMKAvKw9f5i
 JM=; b=s6yxkbrV9JJIgzHMxhpxZxKs6E5r1HqFg5a5KbwB/IvdSHGVzKWKzexMj
 0uSRM31k2Z/g0NYfdVErLEnj7+8HGHgvHMyp0labf9LumMnXJYS7oSdG0XETZEIt
 l9JELZl27a3iIrTNFuHB2m7v4KsnDJu96RDu3V45q+e1z8h/+mfEZQ4vCdvPt7hd
 6fSN0RqE/P+S1gj3xZBS9g79io0GIawx6qDeeqOzokFb6xJ6xrtIBEuBTSWvVJJI
 aNfW/CyfWDfYGLNJSXAJbSkmcXdFcVaJ+sR/1GbtVk0IeGUblHHVUVBfThX9eBK1
 ZK1Z2zGM3SraWSFsjH/60GprrF+GQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye8qef4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ3STedCBVFPX1FB597l0VnqE7pcOERdv+RmJpp7Hx6PFsT+rMXHCNiniamyQk1nGYuwEGYLulvxkVDvBMOutnjt5o1zVA4pa0vYbo6wMfbSkyC8yz/z++DVrEYMUhBgIGnYOfdC3AXtRLmLbjgCT9Aw7ByGkTZbk9B/8KFqje+DR0gzhLvvOJ4mziLcRJIcjxXqwNy8RqANM1bTk0Yro45qslxnabrJ24UBpEJcmNnsMaxuD4Ts9HgNGdmjuox5L6LBMFOTuWdtC/z6eS+dgOFSpXuwDn2Y5PxeiJ/PC17i3FL+AqPrZ3AisGSDJD2fGbmyYl2BGh5XhhRL/w0w9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGmhTVBvt85m8HvBjKXZAGnavsORO1zMKAvKw9f5iJM=;
 b=DkFdcjqWa66e0WcT4YXXrCycXlw0zOu6P2yqdMb03JpSS9+Au4JQRqLj/ULBfAK26Np1QGAsDOhfbGqe/Jqgt+o0KmegCgZRCIhjHQIPH6jSzvC4YcA4HdC+3Piipcu9PNPp57C4jXB2K+H+y3Tjq1BaYZskMrsPpJk/9YBMdeCSD+C7i6lG4ztLnq/yi+0yiFDo3t/GevgzaAnpqVOANTQvxNX23cAsuO0WozN6t5w6scn4kXE0E08YX/mcfhTEkes+98JV/U7IVoccmr7JXx8PeSrDytwLSaOdSVeSa3kUNEo0oYgLUsriU2x2tPE0o1ACclmkmdXgEFUSmSt/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGmhTVBvt85m8HvBjKXZAGnavsORO1zMKAvKw9f5iJM=;
 b=IMTez+Su7TqX3czDlbEan627mAMQXyOLzMMyjZxFNACD23VXu8y3S1U0jQLUGVvFeuHaelUZO0w1xY93SQpA/5rAO+uuxZ4w9XnYbcB95fwwr7lt5XLW8LJr5vj4gmoN+yc9RzKfJjlShZrquAdH2vwDPe/g5Z4gm/rmHSoHOdsmDZw6JWDV9N2t7fhA2eNjZ/pg0hRtbIA4aEARutGlQjNRgecWxooShng9FG4EcikNkjpCoZKmtLxVtvCiVjkK58B85l4Lqctj/8mMHeTGfyKHkf4awzMlhTEGkgG9U8Fx5H3JfK24hTl++eKyxwGCEq4r2vciDhDkptFoXV2JoA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 14/19] hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in
 pc_init_isa()
Date: Fri, 22 Aug 2025 13:12:00 +0100
Message-ID: <20250822121342.894223-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0080.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 201f1be0-5711-44af-0825-08dde175754d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTVzcWhacmhGVzk0d2ZHOTNhU3VhL0F3SFF3UE16R2NVdGZhZzJNVUNVelFj?=
 =?utf-8?B?MFR1NGxWdTUvU2FMQTVuaHkwM25BeXFJTldZZVJkZzdpUjRpell1QTJIbXp2?=
 =?utf-8?B?V2NzSmhuemVMYjgzbHpFK0hBMzQvWFNwWjBldG12T1ZFdWNOb1B4N1lVU0Ix?=
 =?utf-8?B?MXJHMWtJMmpXd0xXODEvdnRzT2x4OENEWEpoclB4N1FBMVhpT29XZ1dKTlNj?=
 =?utf-8?B?ekZZVUZPUklIWXQ1NGMrUkpVdllXd21uNW5iOE1LRGY5aE9kQjI4UFY2MjJv?=
 =?utf-8?B?WGw3blF1dmttR3BrSEFhNXNxQmluVFdtZzc1WEtCYkFxS012WGpkL25kN1dz?=
 =?utf-8?B?aGZyOHRJK3BobUhwM1A5ZDdxRGpNOEcxMTZZV1VEUDNDU3IzS2pYQkhlOEo2?=
 =?utf-8?B?TTJuSjBjYk9RWmZZWFEwcC9uQzVwOUt4OFVYR3pNZ2p1cXRlRkV2TEVERU11?=
 =?utf-8?B?ZzA0UTNyWENUdlhnSjdWSy9aSXZXbDBudUZZZjJPSm9SL0QzRVF3dmRaMmh5?=
 =?utf-8?B?dmJmT1lQR2hHTWdxdVRqSnhRSnBqMWtLZnZLYmFIUjdMM0JaVXp2cHJ2U3NE?=
 =?utf-8?B?eEthdGRqVldZUU5pSG0vS1U4aDJwbEhpWlkxeWp0L29jV0dWMkgyVmc1RzhO?=
 =?utf-8?B?U0UwZUdYajQ0Q0h2bmJHVkxnYVlONWo4dWRnQ3hBWVpERXdQNnJubG4yODBk?=
 =?utf-8?B?UEQ2bkNBRkxUZWJEYkE5czFhVVR3eVlUZG14a3pWVHlBSkFCYWFvcFZYOTdV?=
 =?utf-8?B?cHRPdkZBTC9NWEI4VjRuUlZkRnhmRDBjdkdtZ1JXT0R3QURaRTUvMWpGUWJu?=
 =?utf-8?B?MldOK0Y4c096eG9FRVhKdFJnbXNFQWVEZUVuckNoNUpCN09oNlJoNmZvYlFQ?=
 =?utf-8?B?dUJyQjgwa0huSDAxSFRGdllRaXU4MHd5NkhCVEdBV1htUGlYdFh0cTdSYnpD?=
 =?utf-8?B?bnNHb3grQXVxQ05ReE9tcnBFSUhRTndlS01nZEVGd2tNcGlSa2pTMXRSNXkw?=
 =?utf-8?B?VmlBSnFEdXUvV3VmRGVYUFVjOU1mdDhaSkVjUDZRQ2NaWFJsY1E4R1FwTXpk?=
 =?utf-8?B?aXNsSUwwTy81QUFCZW5SSHBtNitkbzdTM2RLS2xVdWdOU015bnhra2dnR2F5?=
 =?utf-8?B?YTVENmY3K2lsd2xPM2hpZkN3b3J2TC95SDZHRkFEOVFmYklDSU5LWVdlM0N4?=
 =?utf-8?B?b1k5MjZEeDJXZ0pIdUFhVExNY2FkZmwrR1pDOFJvR291YngybmUyRUlHNldy?=
 =?utf-8?B?VmxjS2ZJZnpvM0srYUNoMmdyd3hYc2NScDd5WCttZm12ZmxXRkhpQVNDMjdR?=
 =?utf-8?B?aUozd3FQdkFPT0Y4MXFUNG9sVHAraWd5SnYyOTNzbnpwcWE3N0VQZXQ4MDFC?=
 =?utf-8?B?K3lKcElqNDRZMW9KZDhDMVVsM0dPNjkxWXR0cG9RSHBNOTEvb2VvTHhlYTlP?=
 =?utf-8?B?cmd4Q2s3N0hYZlEvN2lYMkJuZGY0L01PcnB5bWh1K3VYREN1S2tEOXdZWWVr?=
 =?utf-8?B?L0RhZUJNYTROeVljQ0RmK3JNWTJwRzJ1VzJieGE3SzlmSGtoTjdjclMxSkZZ?=
 =?utf-8?B?SG5kTmFGVGU3ZVhrN2hNdXlldExDVzFLZ01UNXZKSW5Mbi96S3RhNHVCK29X?=
 =?utf-8?B?S3QvdTJwQ1JYM2NwaVd2dVIzbDFpaU1VKy9zZktVeE5HZlF3RWQ4amRrYi9N?=
 =?utf-8?B?Rko2N2trV3ZPR3pFRjg2T3A3ZnpCT050NGszREFZa0dFRms5SmlJeGNGMk10?=
 =?utf-8?B?Z3ovT2xpdEF3RmRYVXdIeVdsM0ZiSnU0WndkK2J2UkNrZTFhZGI5QzZzTk9a?=
 =?utf-8?B?K25qc0Y0WU82aVkwL3FVTGJjdE1OVVdCOTdRRjgrT3lIY2NNRVZjdHhYSVJM?=
 =?utf-8?B?L3VXSnVkcXZ4dHdvRVF3RmN4bjFmUm1YQjRsK0cwN2kyY2dwWlRLSW5aTXdi?=
 =?utf-8?Q?2UlnqcL+bc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5Ba2hldFBxOUJIMEFwR25DcWk2cXcvdXc5N3ZtREJWRWl3a2lGQjNodGho?=
 =?utf-8?B?S2JneFltQnYrekpTcVNVSTcwTi9kTXNRWU90MjlDd3pvZUFINU5JZy94ZEt3?=
 =?utf-8?B?ZzM1NzRjVGprOG5pL01DTFdIejFHK0lMVmkwbVl3RWZ6anZ0d2Y1ZmJIVnBR?=
 =?utf-8?B?am9CYmRTUGhWL2N0OVVySGI2bkJRcVVURVRha3pNem1IYkowZFExb2hMVHBM?=
 =?utf-8?B?TnQ2TTJWN3ZFRVNKZGVFcU9OMjdlM3NUNGJBUTlZMVZwR0pzUmV2UlFsKzlD?=
 =?utf-8?B?ZTNKRFVWVWdBQ3U3ZC9Yd0l1eVNRNmUxU1FkYUhvR0xmSjE2YnRFYjZnNGhR?=
 =?utf-8?B?eTRtZlZjNGl0KzRaOUd2UG5teHpjcldBa3BKb1BVMTVJbURVeEJybGYwT3BQ?=
 =?utf-8?B?S3R4UTJOQ0ZyWnYxa2haMVBjT2VOOExTYm9zb2JHVWZyMFVsaEJ3amtBMkxQ?=
 =?utf-8?B?WUZUU1hZd09UUmpzeGhjMEV3b1VOTklmMmtXTysyTTdlN21kcUI1dnhKa0tv?=
 =?utf-8?B?MEYvT1YyREtLSnpjNDdHa0dmd3E0OU5JN1FUTFdycHhJTWpJVzF3eUlmY0tE?=
 =?utf-8?B?U3lTdFJQNXlUWmdXL3ZHZEVRT1RLeEgyWVVXbFozcDdBVHgzWXZDekNkbG9q?=
 =?utf-8?B?cERCTHpXblNuMkF0dThsbUNZQWVLRXdaMS92dHFrdmxHMVZBekUxN3JkWXhV?=
 =?utf-8?B?MG1zL09VUG00MEVEUS8yVllWUThUTzhMWDd1VXZKbzVxa09vc3hMUmN3c1l2?=
 =?utf-8?B?VGRnaG0xYUlBa3hLbG1pSktVZnVacWlqY2psMVFHWVVYekdLRUxtZ1ZjSVZ0?=
 =?utf-8?B?K1Q4SzJkdm1OcW8yQnRaM0RKMWtyQVd1bzgrYjNENFRpMWtuZnQ4aURKOGIw?=
 =?utf-8?B?blZiQUkvRGNGa0Z0SzBKYitLMExXZStKdXJpdWkvZXJ2LzF2aHNiSEQvbXJ5?=
 =?utf-8?B?MnpXeElCWm9NRFdGK1JPNnZSQVdzVkZPUnBmTjRteksxRFZBN3ZZT1FKY21u?=
 =?utf-8?B?S0EwbG8vaWFXRHZHZTJZYXRzM0orb3FaYUdCeHVkWHBCa01UZlNWSHRrT0ln?=
 =?utf-8?B?WjIrSWpNaXhiUFRwMzdZNEFseldyc2xhRzlpMkpyNERwMEY3QUlaNjNBemJU?=
 =?utf-8?B?ZFpOY0RHcTJ2MEFDSzE0OVJ6b3RXYXVTdGZ0azBpbTYvNk50VTZCa2VJMitp?=
 =?utf-8?B?cTA3ZzVtVUlKbkxFc2VRcERTMGk0UUNWWjFDdWM3YjNIaVY0L3QrbjhHUlgr?=
 =?utf-8?B?WjlQcWxkVFFjQU9vMkdXTzZ6VGQycyt0dFd0QzZQWUdiVk00MTJ6NDVnMFI0?=
 =?utf-8?B?Tm5IT2VLT3N6ZUtIUUF0WUZDNWZobXhOMG43UDJ2UDZ1WmxqeWVrWTlvb0hq?=
 =?utf-8?B?TnNObUNUTXJucldEK0FZMjZvS0NNNVZsZTdQc2hvWWFib1JueFRUam9wNnhK?=
 =?utf-8?B?UHZUckVlN1h2ZjdiSEZkcnpJajduaGU4aU9VZGF1NnQ4VmljUzJGeCtIbjlV?=
 =?utf-8?B?ODZIWGMzVFpBNG1MbzFTZGNaYUI1eUdsQW1lbmd4VTk4Y3NVc3lDSXRXZDJh?=
 =?utf-8?B?WTd5WVg0YTNsTTkyYk5zTmM2ZkV2d0FYdWp1WkwrRExvVEwwdU9DVHY4My9D?=
 =?utf-8?B?UUJpU1h4cWNBa09uWVdGVGtHMm5POWd4bWE5M2VXaUQvb3l0Y0dHMTNUTW5V?=
 =?utf-8?B?U3BqVE4vbnVnQmQzZXUwZTJTMG1HN1FUbWNqNmlHTS9tVmhuQTROZGVwN0tF?=
 =?utf-8?B?MWllejJqN2l1OVNNa3lyeXFQSE1rV25zQk5jTXk5S0dVWDBlWlhqRVVVQ3gv?=
 =?utf-8?B?NktEejZTV3ZwVkRPRThhMDdrR2paSTJsaEJmb3NtTG1KSUUvS1d0M1hRVm9N?=
 =?utf-8?B?SEE1T0M3N1dhc2RXdnZCeVh1bUIxNldhamVVNmdKM2w5Y1BKODFESFlmelN3?=
 =?utf-8?B?MCtPdStJN2J3ZDRld1RFNmZtWXh0ZHV0a3VPbVdoOHQvRTIvNFVvZVZzMFhB?=
 =?utf-8?B?S0I4aUU2MS9oRmJqRjI3S1hwUzZsWHhNQW5aam4vNXp3Y2ZsOEhuRXRuT0FR?=
 =?utf-8?B?QTU3Zlp1L0E0Tm80Nm9qSG43UVl4eExhQXQ2dkNENVprS2wzYTRhMytsYUhq?=
 =?utf-8?B?U3FCVmgrTEQ2ZGxrWURQVTRVSWN3bThqV1ZQZDh3cnloOWFCN0ZkYWlPRERC?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f1be0-5711-44af-0825-08dde175754d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:35.4450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CodMlGIz7cw6GJrnw393A05JvY9GTHt/JmU3Rl2XvCC1rhALgv23oOFQVN2l4U0GvVN4Na1XlElrC6A0+QTB7aE7gD0T2vdUYMA0MC2bbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Authority-Analysis: v=2.4 cv=TdPPdRQh c=1 sm=1 tr=0 ts=68a85f2c cx=c_pps
 a=TjEtcBNk5QtzPaPmdoRRgA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m4-MuDShih0a2sssyXkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfXwK5AnnYvy1cO
 q7VhrONdZfQ44lghAzRp0gycrZEi1x7gS18AMpXb4dwizDwe7Bq90I5xB0ZcdJ0/jXhVq3uhOAS
 0K1NOZl3y9qKx3QB+Sm27QTDWLqwnXxBdkSG8G/W8I69dbBEKUq9gIspZy3c02NuGXCPu2LCkwg
 O2BmoAOEgjhbZnpjHYOtJhwe+89HotP0dK421eu6JF7Bl8/xYG+abej0BOZM3JNndRZyEVeSdY6
 nckjycjWlnxyqID5fHNPwnO0sQCzOXJ/bF/nOuh9JjZTbvHSeei9onzMFOtUZpvDy8lX+lKA5Zx
 bsdwpeZAF7yXNSPvPv1SwlmNQ5tyJ+fhgKuXBStfUeZSfiErksjL/mvyUqQwXkTkQ8gdgkiXLvH
 lN56dPdxEeqUpnPzCvYLHJE3s0sgLw==
X-Proofpoint-GUID: e5ePnsBLqlsTWomYY28Sr79owSTDm8Qa
X-Proofpoint-ORIG-GUID: e5ePnsBLqlsTWomYY28Sr79owSTDm8Qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
of pc_nic_init() to NULL.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e8603b585a..49bd1a41e7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -519,7 +519,7 @@ static void pc_init_isa(MachineState *machine)
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, NULL);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     for (i = 0; i < MAX_IDE_BUS; i++) {
-- 
2.43.0


