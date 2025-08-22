Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EFFCA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfG-0001hG-Ru; Fri, 22 Aug 2025 08:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfE-0001gf-Nu
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfA-0000k0-VF
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7eB24668464; Fri, 22 Aug 2025 05:14:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zC2zegcy5Q3sDW2eQ4Z4NjH81g35SFGs4pMT/LwFV
 RU=; b=aPe0mPZ78f2v9nKvlw9WZyBFfS8/6W1pEL7rA6paiv4ANCtJ60ZJq3DTK
 6mHZeg4XOBLOnVZwuyL2/o5WRNIlwffA7GcxQpY6giBSy32eXwtg3wU2fhJOgDfv
 TyKmDv0Jr4eBwohQ6fnA8lx3ifEi21zHs6S1wUlRwYDpXx5BTpImXlcO6WnTbGpy
 bOoGtRdrCVsVmT5/GBxTQqj3ONbiXp0HriwH8z3VjlaZP+teSzSMTCx5HHP/phLu
 af10tRrAXuhanJ52if4WHMdCR3e6XaZS4H2mW1es6dKT1Bm1tarY5QTZBfnFehGB
 h/rSBBqA4TxKYVv1K2c3PWnPA5q2Q==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2111.outbound.protection.outlook.com [40.107.220.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye8qdwf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3Rn/J5d032LAsESFvN/C8vZZPvOMBxqOSmW0zZ6to0Raayk1tiJcC/bVTt7pPXZSiXdq03HyWpcWF42XLUJElZp3WcKr9ULFHnka5zsoZ9RvlmDKLTZl4hVNWmDiUEBm6El0JCZYqlwDOsABJ9fJWtA/jHYBdVb9Q4gaG5H4JtVdZvsiomi98MqHX2L4yRJBOCuiEzS1AWYYvSOyHwq00jIo4PfizGZLoXhkb43UqWiYJXchTQrkER5kaF43pCNix175GI2rtDrGVdqdOp76iEf4fiugODFUNgxiXRNzjF2/LIFswtpImEz4ltgTbNjpw8LNu0TeCULHnML/UD7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC2zegcy5Q3sDW2eQ4Z4NjH81g35SFGs4pMT/LwFVRU=;
 b=CBCxsYXTncw5iV6DrOViN7N7eRc7yfYV2MhQYgF4mA2XRRiC1TQqTsounN8zv+p+madH0/tX+DhwXPuzSXtk6C58BwEnNZdCUA3EWkVe6PFuR6KgTCibu1DHyQds667z7PqZb/Lzu/NoaaxXURKblSNJC+HDAdfBEUXRuY+I+gDShrujHDSWBXOhboIhasGk5D4FuAQsoumP9KhfWVhSdgHrZ8HJ2soRHyVNYf7FFD3gX88P+YmZoE4dBzW91EmcDJkFQyoQEYBorltpByRzPrYZZm24WwitowYbsRWLN0y0e+RT5FG+vronPX4ak2wSdcp7PxMg8PE6xFLCQqQtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC2zegcy5Q3sDW2eQ4Z4NjH81g35SFGs4pMT/LwFVRU=;
 b=CZu56H3ZqK67nUYjELHNNAKse7dOyZn05XE5kozy2YK/a+Y2bMMYBE2AnTP6LdKnTok/tggTSq/4drMw0Pr2bxc69pfLpQBlLUcMA3HaJUYlDa1kBkS4mVaG1sOF1qq/qDOLoB3iGGuCR7LklSMJR6VfbKb4PPS0kmlcgAEMsOPpS1CCAjVPgt6Vu6KWLxaHhhgveRNhEkDKUYsSTJTApLC6o0d/HLNBd/kesLgRz2gX1AN0k/bSeIy8erIvhR98rpj5o2RMn4y7x/xkq0RPytT3dDmBExpX7uRJyPskmQ8hDt+GVxrEteYg/5dhzvS3cZuCvxlAmDK0pLGKVG48Fw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:28 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:28 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 12/19] hw/i386/pc_piix.c: always initialise ISA IDE drives
 in pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:58 +0100
Message-ID: <20250822121342.894223-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::48) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: ba587772-75f6-422f-c139-08dde17570ef
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEhxOWk0SE4zR3g3a3hrb3k0bmpobnlIVmhRQVFoTlFEaWhNOTVQWFcrOEtX?=
 =?utf-8?B?UVpEMllQYTZ0RC9CdnJrQXNTU0xVMjFCZWtSTUFJOENnTmx5bTVQV0g4RE01?=
 =?utf-8?B?aXViVGZKNDhWeXJXU2JCRStOc2NMZUsvdlJ6VHRPSTBNeWZEbkx5a1ltUTZM?=
 =?utf-8?B?SnZUK1poczBEcUxHYm5CMGhNc2x1Z3RCdVlqRCtlQVBjSk5vY3g0eFVOY1Rk?=
 =?utf-8?B?Qm9nRVlBYmE3SGVZVTNtbkxwbXkweVY4TUhDNGVPdXVwZm9WdVZpcThXZnJH?=
 =?utf-8?B?UENyUlpGUmlnNERra0JWSTE0NXVEY2dMbGpYYkRlRmZLbDRGQzFjOVU4Z1ZT?=
 =?utf-8?B?dTFJK2QvMXV5Y3A3NS92bjAwR3F2aGY1bUl6bURmQ1J2UFoxNTUvMkVBWWxp?=
 =?utf-8?B?M1V1WGFxYUtyU3FCT3RFK2JkTitqSVB5UlJDUDVDVTRTeTU1WGlyc2ZUcTJX?=
 =?utf-8?B?NWpNZUNiVDRDSVhUWFprRHdxUmE2dFpTUldXNEYrUUcxZm1nSDZTR1gzM0tD?=
 =?utf-8?B?SStBVDlySllvNjVTa3BpaWNQM3dPeHZMWmU0QzIyU252MDM1RHpianMweWo2?=
 =?utf-8?B?N05MT0xaQ1JkQmVIVXpIZmRtclgyUlo4SkFEaTY2U0FxR3QyTkZqUVd1alZ0?=
 =?utf-8?B?QlVYUm9BODl0Nkx4Q2tod1ZwK0M5dnRqQXZvcDhiVHBLRWR1bjh5VmdIeDJm?=
 =?utf-8?B?c3h1d2NnbnRTR0J5bnZCb3J0L1l5SzVsVkd1dE1Qa1VQTVkzNzFOTTlOVlAz?=
 =?utf-8?B?dG5qREU4cDF3UVBtbWtwbmV5WDV4b09nSnRseVNtY0dUaU5OeStkWlNZcjBB?=
 =?utf-8?B?aXdxemFSR2VrSXZZTVpLNHJGdmcyYVJ5RTFaRk0wMnhYS3FtZmRyWHpKZGgz?=
 =?utf-8?B?MHZ2MkdraG5QaTlHQXNGQXZrR3FkSVYrWlRsZmxhSThrYmNLdVFVSTErSmNv?=
 =?utf-8?B?UnJtTGxnRDB1dnlSOVljRDM0UTRvM21URHBJLzVSQVF3UTRMbG04Mk8wZjRZ?=
 =?utf-8?B?dkxrbGVkSGxxVmV0TXJyNGtuM1pWQ3VBVDFrb1RsUlBmVVVxY2RFZVlTOHQ4?=
 =?utf-8?B?TnhTbzFnOGt1dDhTdE0yVmErVGNUNEJwK25RdW96NUhJL0dFcXRicEtjT0p1?=
 =?utf-8?B?N1c2R2lDbDd4TDJ5VFFJemJEaHEvVUpHSHhnak1DY2U0cFV4NWV2OVJDZm9x?=
 =?utf-8?B?SndSUWpMQTR5UjVNeG5TSDRVemIvYmV5N2xkMHhWaldHdmJUOVFmMDVGeXAr?=
 =?utf-8?B?eWs5ZWx5QTEyMnAvZHVUcGhqd3lQK2xnM3N1NWt0dG80bVc3WXJxM2xoZ0J2?=
 =?utf-8?B?b2Q0MzNwYTdkcStWbU0veVJseVZWajNDL0VmeDRmdG8rcTEwMTBLcU92RWZ1?=
 =?utf-8?B?K1VtaGV6NU1aek1nR0hrNE1OWGd4SnI4M21GejNReHFUSTdiVXJqdU9wOTVH?=
 =?utf-8?B?WmpHZThreXp3dHFoYkhXOXVuMkNTSWYzZFZDdE10SzRjOFpISHMzQWF2ZUhC?=
 =?utf-8?B?Ny9lWm9YWDhrQWo0K1loSTYwNXlhNkhJS2h3L2dQYmttTFpjZzZHQ3d0N3Fu?=
 =?utf-8?B?empoSnpjL0lweHVOcTdZaFYrc3BFR1dXZFE3amR0U09TZmlpb3ZWZDdMdC84?=
 =?utf-8?B?Qzk5ZFNNYkpock9lS0VEdnJjSkp0dk1jS0ZXWGs5MFlWc2hOZGUzM3dNWlRI?=
 =?utf-8?B?NUxPMko5azNZZUF6bkNaam83S01EelJwU1VSZFIxSkxFdFdWcU96RlVjVG5R?=
 =?utf-8?B?VmtkN045YlJFWG1xR1hwSndudUkwR0t2S1dBa1RCMEppREJTcUk0b1RjOVVa?=
 =?utf-8?B?OExFYkk4MEFEdEVISEJRS2tYems3ZlZmSyt2NGFVUnJJNWR5NWxhNjA4eVZK?=
 =?utf-8?B?TEZoVUpFcENpVCt4UnFYblUxYnd0T2dCaUFGYWZvUS9qWGR0dWRmcnpQTGsx?=
 =?utf-8?Q?gDMXQl+RKHs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVp2L1JyeEpMajlJbHpCNGt6Sy81dzVCK0xOMXRxK3ZBQTI3RGNsUXg5RGp2?=
 =?utf-8?B?aXVua2hBeENSU3NibzFBQmR6TTAvSlpuNElyZXFOVFpjeTBiTm9zcHpZcXRw?=
 =?utf-8?B?Y1RDR0NzRnlybENJUXpkUE1RL29hamtFbVJ4QXh3ZTZFMlJZdTQ5NjVyMllI?=
 =?utf-8?B?ZHYrVnFmdzg1cGtpSlRLbUxrcGVJMmUvdXNCdW9MNHoraThBZUkxL3Y3UVlj?=
 =?utf-8?B?OTlNTXBCVThEVVBMblRobVlCYXFyVTdaSS90Rk9Wb1NyZWpqam8zVitTSStI?=
 =?utf-8?B?ajBqbnAzYTMzWWFyRUcvc1hHQmgyTi9yUnlLeUtHbW1TdHJvRUpvTi9SaEJO?=
 =?utf-8?B?bitxNi94eFNJcFByeTlIamJ0T1NPREtiYjJVZlZuaEJobjNsVUlWQWszOTEr?=
 =?utf-8?B?S21rbzJQRy9sdDJHbzhXR3JoeG1pdUM1ZXRPVG53dVZIeTd0b0hUemFJVUFP?=
 =?utf-8?B?bUhCK1hPMG56ZWxNN05CRlBSSXBvdjEzYlFrQnkwN2JWU0hyTThob09XMnlu?=
 =?utf-8?B?cXV3NXdiSDBrN05WeEZ6SzVqVndwU3lPWllUWXRhMXV0NnBwNnpSQ0lCL3ZS?=
 =?utf-8?B?Mi90YlRoZW5MUVZ1ejhJM3BWMFBSZkl0TEtvM05iY2dJaW04dUlYS25nbkor?=
 =?utf-8?B?VytCSTM1VkVRWVFBT2lpK0ZuY0h5LzdPRUdrQjVNTmFkRlRuUUtzWHJXWnB2?=
 =?utf-8?B?WE1MTVZnRm92ZzNtYXQ1cTkxQm5JKzlYNEVGUFhXQ2ZzSnhjSkxsTkpPcFJk?=
 =?utf-8?B?a3kyOGkrZkZDUENYckFRVGZCdE1XWDVDbndjczNyTXFONDBjcC9pdnJJakVj?=
 =?utf-8?B?S2VwYk4xUUFwa1hvY1pXam9IN3NjZ093YUMyZlN0Qy9EQ0xGMlpERzdTR0I5?=
 =?utf-8?B?dG5Kc1gyclBTY2Q0Q2JscjJZVGpSekNwb003TXNjMldxTVZnMGF6dzgrL2k1?=
 =?utf-8?B?UWtQVzEvMnFobE1rYWxKRUM3VVBEWWdRQ01MQUc2UGdiWG5QbUN6T0VrakY2?=
 =?utf-8?B?aWJSZVllLzQ1RVFidUtGWWdIZTRLRFFOSzBScXIyenhleGVZdXR0SnlVQTJ0?=
 =?utf-8?B?T3lhTElEUlROUkt0NFpnRHl6Ykd3Y1JTZ2h5QmhCWGZycG5CajhrUFA5UW1B?=
 =?utf-8?B?NDVSVzRYWGdrTmpCYnNNOHcvUnVDdGZ6V0QwbGc3MktPTk1FZTJ6SDY0YUVp?=
 =?utf-8?B?dGFHTlJxTGMrQVdOZkZOQ3Z0WUxsbGU3MTJVMlQva0E0dm9oaDBjQ0dXTUIw?=
 =?utf-8?B?b1g4UHVFUDdqWlRsMUFtQ3pTb3BCMjVSV0FzSXN1eFJETktYMi8zLzcyUnJF?=
 =?utf-8?B?cHNWSlAybzJXOFNCWXB6eDVBN2tsekFkLzBVeFY4ME1PRy92ZGVwT2xTZGE1?=
 =?utf-8?B?eWR6SkdHSm1nZ040d01nc0FVZGc0QTdUYzdDNUowQm5rWlBaZElmd2xyWWk0?=
 =?utf-8?B?ZCswWW10cjVta3U4ZllsSk1zTk5mODlOUDRRQ2VPejBIQTBINlZQQmlaaFRJ?=
 =?utf-8?B?THdjZFpPY3czVkRLVnFhUTJRSGR3d3ZuMHcxTkhGcUVIKzd5VFNRNE5ieFBr?=
 =?utf-8?B?dHljRnhsSWNiTGJVMm90b2tnRUdYek1qRE5HcG9MZTcyU0pOYWVLN01jVHZW?=
 =?utf-8?B?bG5RTmVudWV3bVp3ZjgrT0xMYXpQM2RxbWpmNFp1MWVrUzlWRlcrMTJCcGNp?=
 =?utf-8?B?MlBwNDJ6ZWtneVBvMldBM1NMWUdGYi9xNGhDY0NpZGg3NnRtZ3F4aHdvcjJ2?=
 =?utf-8?B?L2UySXJBYXJJZVJucXA3Y0diRTZXN09sdTRlc2FTSmFMdFpUYnpLWkc5aUJu?=
 =?utf-8?B?M210ZENKMHQyVlgyZkx6RnRzOVJrMk9nTWJ3VU4yNm9mMFZFakloQXFxcm5x?=
 =?utf-8?B?NjFRZkMySUFjT0xJeVRTU2VheERnM2QzUHluMmlWdHZZdnBCWGNWUlN1YkZ2?=
 =?utf-8?B?SUFKRTZxc2xuYTNHMVB4NjZVVTE1eXVDRERpSjhDek9nTHJsY1JTTXdwVFRG?=
 =?utf-8?B?Ui9jU3lJbGd1Q0FWME0rSFg4RzVGV0dYL0hURElFU3NCRTJ6MDBjbnFpMHM2?=
 =?utf-8?B?VFhtSHZzTExvOUV1cjhuYXh4M1N4QVN2eUN0Q0FsQnZmSXUycnlRUkRQeDhQ?=
 =?utf-8?B?RU9PSUIrTmtBc0xhdWpQTEhqb1o5U0sxWUVsZllZaUhkTW0wVHRobll1OGlZ?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba587772-75f6-422f-c139-08dde17570ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:28.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1YxL0lVzEk3wgaUOCCRDOawbXP4AQWugFZZlR3YX4g8mgbTFunuH1ZwRJHIyUEh2ZpUbZCTXplNyBFDkiS6jQHmkookJQAqMqUfG46L154=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfXwJORPdy7TQA8
 VyHba0wfDbQLe+unVN6HtlhDcKsOzCnxOggo40LJ8sDTfT0tY58Ao9oME9+/b6Q/Ulhtq2UmIcE
 sXaaUXwTLp085N/cA9N9aaR5WRCb7pdwZErXYDn/yO/jJmR3zKGkyu9sZLB+Fb7XsOuFss7plU4
 nQYc+LDCY6CjB+2sX9jlJ8Uf+NjeDEsWiLROXHMDg4SBntKgAcIftlWBWw3xqQahjRgLKxHrQ8u
 8gtfW0UzagzZXQVBMkzVbZjLq4tGZiKTsPx0Jkr1iW3JDWILxiayoYTnrfbjGaQlMCeYD+Tkc+l
 R5KA5EsLyqjiBlfuVdUEZPwr1xA+wA4gxGYx4iFFD2818qiaHazRgOmxFeB2oWrA/gajrPfwKPv
 IFE63rupGrKQ58uVd6nyazlFa/DHSw==
X-Proofpoint-GUID: gV4rOK76-7EyuX-2-IwrWiSVqxkGvuF7
X-Proofpoint-ORIG-GUID: gV4rOK76-7EyuX-2-IwrWiSVqxkGvuF7
X-Authority-Analysis: v=2.4 cv=A7Y1/6WG c=1 sm=1 tr=0 ts=68a85f25 cx=c_pps
 a=EAC/UdV2w3Vk3F7KeXBmxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=qN5ve3sCTOSH2ZO3jx4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
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

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index bbd5f9d17f..924888b59d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -444,6 +444,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is no RAM split for the isapc machine
@@ -519,27 +521,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.43.0


