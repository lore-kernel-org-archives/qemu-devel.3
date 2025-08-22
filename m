Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0C5CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfk-0001tM-Ht; Fri, 22 Aug 2025 08:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfQ-0001jN-9v
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfK-0000oE-Jq
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:44 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7iUkm713901; Fri, 22 Aug 2025 05:14:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/XTu8amX6Z1vv0g2FjQXw6WroZw51LdOx6sVhj+qN
 8A=; b=1wtUpq7YtOokV7EBD1rqRdPQove96SlOaaE07Fpb33IPQRTxobOOCqNNh
 vJpCB9V3cZpuvqdEjN8Ojpw0gjrM9eCaxntcF9D5NJ4YYaBjhvqCqXp/WbJrHS4o
 0ErjfAr0+b9DV1UyAtFAJ1GoF5HkzI797R7zF50LWqIOP7ONq3LQqWl5ck0W00o1
 k/yjs9V9NCEhydE52NRfvpUNp4dJlv0kxdO76sIFAFUynPVZHgFK7m47MYkGSfEp
 Ox+/ghD8foa1A5KFpWAJ6EOZrHn7Jy2TIlonEzOb50oz8Ep7yO4s7esgpE2zhPfe
 mhQq7OdTZxc7iMmVtCGZuf6W/cWpQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye6qge9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjVM0B89XpfK3Ygj4R9rqHDh+M7F9t60RAEIkWSBzbUSzBw4eDqSuUogbUmBz7sySFfzh7uFnPqT8tVsdnBLKYnbcz4Z3hIET3AUKeNU/3MCXoEfwGSfNQW0HGhaHEgF1X5f9whJLgoXMLQlLzNiiHz1Rm9RSBdz1YRsrqy7PScW48b6oPurXTkq0iWuvEmVrR2beYJHLm+eu/ZtVDFzvYmEuaisouy9yNQQVF9k0gaKC9SCIaWSWy7CxGi42E26h/SzakX49J43nUcM6HTJLh58AcaOg3QvA44BH4tegS2H1eEyDMnK1aKit29ojOpgqGeAwWgKMuA+utGH7RI+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XTu8amX6Z1vv0g2FjQXw6WroZw51LdOx6sVhj+qN8A=;
 b=TKljXxi7KJU+wynf4BzWs5iFmCIwl/qeqjfDqsaWyuToxyap0lWg2bk1Dqh8gbPtJmov/guaQn3UXFYu1L2j3GQcyuPmzBzgpF8iPl9/1D9uGtHacXwmQtm1DcskUwKaP2/O7OT4lxV5D2gCx0Yx08OHWsqo6No+H61NAkjuKnCw5NL4VmpFwFK/a2Pe870RYGXYW/Y68zr423nuFrd+IJJBXqg/ZvlnvUJ/WseNWry7EZ4VwcR3M9Bc6nJDRcXXpvAsp2dnyJxB/lvqD8U0rHcMum8d1t64XKTfiZCq7Oq5QqJWQckkZKsGxb5pC9jqEo9YlO/ni9yneOJp2aQoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XTu8amX6Z1vv0g2FjQXw6WroZw51LdOx6sVhj+qN8A=;
 b=qvb1CVNgUs++BUV57llGKs3pVTWqD92whk7+xLj7IC56s7FcQ+iLHNKv2L+E95HRAz3oozoY4tdeBzZEt8RAM+vhgYcQPlQqlUBy73mnB7hCD3uDROeoJTdyuboc/dEECMRi4zb3oJzGdPndQfnaM1cSbuH1mJGZuhTK1QOr6ycL77KHYVDF7i+wD6e0PqyKx6QYqNpUqeCa2oXqdRfkHhU3I70mVVu7Y3gm7HmMq5pMsi6FegJv51DLKdL79UyvEhUbPZDWgo7RAgOuDdZod1hoZFr8IrctzUyRd1MEBLf28RM/iQomNt6j5w0LGedmS5caU0wjU0iZ2lgBai9/1g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 15/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
Date: Fri, 22 Aug 2025 13:12:01 +0100
Message-ID: <20250822121342.894223-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0084.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: df9ecc06-ba9c-4784-cf82-08dde1757750
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFZVbklVUUpGYTJNNk9CdElIOUdkdW5CWWhYcmdENjlDckZJYXZJUTljNDZF?=
 =?utf-8?B?QzZHVThjbGxOWXJhTVQyWTVuNmIzTzhUZnlJcWU1dVAxYWYvUmhSWjBROS9C?=
 =?utf-8?B?dkJ2dXFTVE1PM3N5N3dDaVQ0dkt3U2VRRWdGRjZtbVFHVndyTTJCWUw1bmsy?=
 =?utf-8?B?WkxmS0J4djFmSHFiL3JmTkxhSHl5WXZTS1RZYlloOGJiL243djdpcFYvWEdR?=
 =?utf-8?B?M25aUGtQUWdCcmxnVGFTdkxhZC8wMjk4bEljY3FLQk14QVRwdnZwaXlaRmZR?=
 =?utf-8?B?ZDNBOThjODFvV01KQnR4YnNxdit5Y1JNdGVxNzFlVk52RWUvY3lNNkpwa3dP?=
 =?utf-8?B?VExJTXVTWjR5eTdjamFmUGVEaFEybmMzNVFlZ3JIZm94OXRPODU4Y3pvVnlZ?=
 =?utf-8?B?NGloNFFpWmlUZWFpR0RlV3ZPT1NwNmtzTXVvWXljeElocW5rd1JucjVBaVN1?=
 =?utf-8?B?dUpoOUcraWRWSmt3dTA2aTdEYkFFWmZKK1dLbzJvVEg3K1Rqc2d1SmhxY09v?=
 =?utf-8?B?YnZRaUxIbm5UeUN6d3oxU01hWkQyN2pqbGxKeVhyUDYySzVEckFTZC85T0tH?=
 =?utf-8?B?YjBvTGRNVUNZcGtSSVpLOWxzNFBlYVNxMzFNK3BaVlBNc1RwbTM3MnVlaExH?=
 =?utf-8?B?dC9YSUQ2a0hGSnNxL29GUis0Y1FLeXR4VjhqWkxCMGxNWmlSaGJmR3l0TFNZ?=
 =?utf-8?B?cG1BWDZaZDg1SkdGUlN2RzN6M0FKOWQzY2dSRHphT3hJUE9RZXhRcWNoa0pK?=
 =?utf-8?B?cDY1ODFEWkoxYUdNZDVmd0pQbjlySXFIb3g3blFtcG1HMEJtU2VTS2YzM0dZ?=
 =?utf-8?B?Y0xHTHhDaFZwMjlDeHptaUV3UXVleUwyMUZVOTF6R216ZHNpYkZEL2JjMXhR?=
 =?utf-8?B?eGcyVmswZXVoWlBhdFlLMG44TXVDZGdZbTNJV3RTLytVY2ZPWnZPRjVDaVZT?=
 =?utf-8?B?U3dNTzBReC9SVWtFbXpJZ0xLNlJPRnVsNE5IMlZXYTA0SU5nbUJPenpQN01q?=
 =?utf-8?B?QXlCVUhxa1lGek5iUnFxb0Q3b1hNSk9LSXpCN1NjL0doNko3NUNGNllqdVdL?=
 =?utf-8?B?c281VXFnL2JuOERNVnYxRHg4dU9wUjY0cFpsTjNoUDlBNjFlS1QxcDdHaGg3?=
 =?utf-8?B?N2IvWmVWenZSS05Pb2J5VGJsVk1hWHhZckdLbUtSMEs3cVdDaU5GeDNxSkwy?=
 =?utf-8?B?TmZJUW1PQkx6TWdJSWM1elVsT2tYUXdnRzBDaHBqVWcrdk9aQlRkMEk0MTNJ?=
 =?utf-8?B?KzhVYkZsRnkvR3ZSNnBadWpscUp1MU5ZL3ZTb2xyWHpodVdyTlFnUFFpZDhT?=
 =?utf-8?B?K0hyZ0NnckkzMEwwcjduRVNkaHUrWkRnSVhOR1A4S1d5QjYzZHNSR0haOGNu?=
 =?utf-8?B?NVBwUHZGTEVPVGV0SC82akZzR0hMNXBGMVlaVklMOHAzbUF0ZFkzVktqSjlK?=
 =?utf-8?B?dlZGZ3RVV3F5LzljMFkwelh0d2NHb3I0RjFjaVVxQ3l0RjEvbC9IRzY3MllB?=
 =?utf-8?B?QU5IT09aRTFUUUliK2lFNEtiNllNREZyQXJjQU5WaE5ubjZZZ1dNeTY2M1pw?=
 =?utf-8?B?Vno3TXNNMlY2c2Vjb2lIN1VLZ1dVZVc4Rkdlb1pybWVSZ0xlZk9JL21STU9x?=
 =?utf-8?B?MU9lTUNFbGtVUnRaYjhDQVJQZExxc2RYVEp0NjE2Y05RbXZTU0xjbVYwdjRK?=
 =?utf-8?B?UDJDdlI2SUFOZVhrQmpIRU9tMTFDL04vL2Z4S1NHNVRSSW81NDFORGNyVEc3?=
 =?utf-8?B?RDdmb2lkd1JXeHJqODFkTElBcmpUVEtzWkhwV01tTDROVi9LazB6bHVFMk8w?=
 =?utf-8?B?ZDAwN2ZiRXlVVURhSE1OMW9uNHpUa1NIWkJ0K1lYeW5yTUNiL0sweng3d3ky?=
 =?utf-8?B?eEpjRitGaVAvOW12R1pmUG5WSTNpVmJUdlpUVWhsSHcwemoycE8zTzdMcjR4?=
 =?utf-8?Q?BvyGM6xxJFw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmRjYjhsTVBWU2xycEhYOTlXcVVJbk5uVFBIYzJPMkE2M2NzUVpyU2w3RVhQ?=
 =?utf-8?B?VW5vekl3dlVpZGl3MkU0YUszT094bkxWV1lMWGJMZUdxbmhGRGJ4M1lIK1pv?=
 =?utf-8?B?aXVOd0JIV0RlYk12TVp6UVlqVGhwdlBqUUJyOUFGN1JBcnRvTVJYbFZ0Qlcv?=
 =?utf-8?B?b3ZoMTJqSlVVRmVvelJHMzg1bk01V3pzU1RuaGI3WmREQmNRbFEyaXZ5N2xY?=
 =?utf-8?B?ZVNRTDFwWlNHNlg5eDR6QVJGR3dXZ3loeVkyVUdlQVJ6VkhnQWVNQTNXRm50?=
 =?utf-8?B?Q2pyRUZrQW9WUUJpeWJsTVhXa2ptQzZ5K25Rd3BPR2d1UC8wZTVsZXJ4M0Y0?=
 =?utf-8?B?UVhYRm8zU3EzVC9mS3hOd3FYY0JWbURCbE1zRHNMMURFZCtId3VJUGo1UXNR?=
 =?utf-8?B?cVIxWDNZUnBJR3Y5V0h6YW1UR3VpU2RqL3QvSnpLVUYrVnkzSisrc2NTdVha?=
 =?utf-8?B?WjBIdjlaTFdGYnRPU0lCMTl6QjExZ2ZPL095U2s0TEc4M2s4bzhsUThvelZu?=
 =?utf-8?B?ZXdaMU5DMWE0ZHBXZEdtd0ljb0ppajZ5SzVoMTR4eHB4SHpWTmdGZGs1WGtn?=
 =?utf-8?B?a3RTei9ESzdzbTNiakE5TnhqNitWT0Vpb2JVUVFxeVJSVlBiRFo0KzB5RWJx?=
 =?utf-8?B?VUJITjc3U1F0SDRkU1lIdmt6RkVYVW1Sb0o3a0FVckk4U2luVEJ6RS9NS25J?=
 =?utf-8?B?WlJ1bGcwbTk5RHZ1M0Ewbk1NNllQRW9yTVZmZzRjUWNGUDFndnRwTEhWcFBz?=
 =?utf-8?B?TlorOE90NjZkcjI1T3ZEYUs1aSt2NTJJU3RmYm9DSTdkbnhhU0lnMnUwQU1w?=
 =?utf-8?B?bU9hVGN0OVo4SGdSdjlUTFBnZm1vZG9FY0lOK3N4ZE1NeE12YkpwQkVMd0Vm?=
 =?utf-8?B?T1drM3JTK3M4VzlNUkRiNENHWGxwM2g3U3NuQ1UrMXM3RlBBZmpHeFV0SmVP?=
 =?utf-8?B?NndVZGt3a2U5QmNaZVM3R1c0UWw4NjFxSDFiMFJhZWUwVGpaN0xkSlZVNjFC?=
 =?utf-8?B?QUhud3Ftc2ZXcnd0T0VEVVJXTHM5T3VLZm0vMTYzekxSLzR3MlY3WHB5QU0x?=
 =?utf-8?B?WWo0YS80T3krUmU2VzhtYnZXWUM5ZFYyK3g2ekpRbmI2a2xYVnRmL3ppY2t4?=
 =?utf-8?B?dmI1OE10U0pSQUhzQVVXUlo2Qk5xRElpQUllMDMwcHRrTlFsZUtTZEVCbENX?=
 =?utf-8?B?VkZOUTlNSVR0MG5PSHZiZHc1ODBzeHdDMm5MOVVzd0NHLzJGSDE2c0dMZVVE?=
 =?utf-8?B?UkhSMVFFWm8zNWdkZTl5NDc1OXBIcW45WkJmaXJzaHdtays2eDJ4TXM1aEY5?=
 =?utf-8?B?ZGI4a1RDUHoxa2NUR3ZpRVFVeHZRL0hxZnpVUFJOQU9TWnBrL2FmMTVBeGZ6?=
 =?utf-8?B?MTNlUTk5eHB6UEFjbzh0c3BDWSs3TWJzWVEzb1RzTHZKM3pVckdZZWRVakVn?=
 =?utf-8?B?amo0QkdGU0tVUjNNb1lGeklneFZvWEhnMUxkcU5PRFNiZXNkM3JPTTVOUHdm?=
 =?utf-8?B?L2E5YzV3VjV6NFVpaWt6WnhWZEZTblNHOUxDVG5MZVViTVNDWENlUTlVaGpF?=
 =?utf-8?B?SWhsc1pwdlhCb05QTkZKK21tZzRreVV2UUJ4SXBVSjFNT1NUWlM1VDNKdmNq?=
 =?utf-8?B?QmEvcUNsMU00S0ptcnBHcThsYzBtbXB2dnJBTUdpWHFMQ2VoNWZBeVFDQXZu?=
 =?utf-8?B?d0xENU1ka3Y5aWlWYUpZMW9LYWd4a0JTVlNIaFlzaHNjWFpSS3VHcTg1UFha?=
 =?utf-8?B?Tm1Od3FzaTl2RG9DQ2lGWjB1TjBYdXVnVU1yQ3lWQ0Rtd3MwTzZUQkdyWDZX?=
 =?utf-8?B?R1UwQ2RXeW1RSnh6ZFJyQUJUbWdyeXlYT2h5MGdtWmFxU00xcWErc2txTWRT?=
 =?utf-8?B?MFY5STlvQU1kcC9DZ0tnT0c3QVdLaTBpWEZWVUdNUmJRbVRHcnB4QlpRK0VW?=
 =?utf-8?B?bkJVR1FIVU0zMXROeHJReEVUZTR5Zy9GVktPWjF2azljQ20xZS9oZnBFZWx1?=
 =?utf-8?B?OFdPLysyc2ZGYVc5NFcwRTk2VTA2RUhtcWFQSlFFQm5sMDlMSEt2SmFRMFhl?=
 =?utf-8?B?V1JMUk5jMUREaFcyVVp4bzNiUW8veTRYbWl6TEQ3Zk5ER1ZtWmYxNk54TXpt?=
 =?utf-8?B?UFhzRjVDc3o3L1RHQTJuQnA2VDZKYzJxTjBTUWg1NTJ2MEtBSGlsWkgyaXQ3?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9ecc06-ba9c-4784-cf82-08dde1757750
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:38.6781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+BExXFEZL4cYBNpxmbYHQdYtWwvtJyObBTIpxwjLAzO8sgHFX/fyJKdvSZ/KNfSQqfjTeecr+efvhdUhGAkHJAXZITS9lHRM8Dzbc6drj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-ORIG-GUID: HvFJqj_UOCcWN2LFQWk3IdDLUT0Fbh9u
X-Authority-Analysis: v=2.4 cv=QLwxhgLL c=1 sm=1 tr=0 ts=68a85f30 cx=c_pps
 a=X0TKh/MBF1+/LqYN1SieOw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ZtfbtUD1nkWWkvgxnEIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: HvFJqj_UOCcWN2LFQWk3IdDLUT0Fbh9u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX3c8xNhE0KDmH
 glhaIkxzDcZu8+7NZu+oigdHRfnl82mcdcN+UOKf4SUD7ucdWHW0KOB47hl+fgNbPGC4id6BPjy
 XJKaHK1AGinBFEuGJkRBuzni0/Dq5/cY3HKJsh8ugkwpEso1iFkA2s6MoVkmWICWvcj46Ss2Rof
 CeQ5ASEv849KjvxyNIynkfgG4LBBVFPGeMe/N+ZjRy3nS/Us+7jSv3HZgddy9QBpdJFZO0gbUk8
 xp4nu+g1EUED840dLYRYxEK4UkeBNd2TR32RDmgErEYGkfXLdDfe04N+k2pkscfSJlYF7uOuI5/
 WzcCGQkLh52gdAoS/lEY7LJ6PEKHM5/dChQ0+N7DLXgD7UrhV2mJQpOT2MMGTJEyRnoe0Eq6+F+
 TDa2Ibc6zM8ksf2F5l+fC9kVGti1pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
in pc_init1().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
 1 file changed, 76 insertions(+), 118 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 49bd1a41e7..a776998504 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,7 +71,7 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_IDE_ISA
+#ifdef CONFIG_ISAPC
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
 static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
 static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
@@ -125,6 +125,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
+    PCIDevice *pci_dev;
+    DeviceState *dev;
+    size_t i;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -195,38 +198,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    rom_memory = pci_memory;
+
+    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+    object_property_add_child(OBJECT(machine), "i440fx", phb);
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                OBJECT(ram_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                OBJECT(pci_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                OBJECT(system_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                OBJECT(system_io), &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                x86ms->below_4g_mem_size, &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                x86ms->above_4g_mem_size, &error_fatal);
+    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                            &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+    pci_bus_map_irqs(pcms->pcibus,
+                        xen_enabled() ? xen_pci_slot_get_pirq
+                                    : pc_pci_slot_get_pirq);
+
+    hole64_size = object_property_get_uint(phb,
+                                            PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                            &error_abort);
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
@@ -242,72 +243,51 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
+    gsi_state = pc_gsi_create(&x86ms->gsi, true);
+
+    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                machine_usb(machine), &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                x86_machine_is_acpi_enabled(x86ms),
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                &error_abort);
+    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                x86_machine_is_smm_enabled(x86ms),
+                                &error_abort);
+    dev = DEVICE(pci_dev);
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+    }
+    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
 
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        uint32_t irq;
+    if (xen_enabled()) {
+        pci_device_set_intx_routing_notifier(
+                    pci_dev, piix_intx_routing_notifier_xen);
 
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+        /*
+         * Xen supports additional interrupt routes from the PCI devices to
+         * the IOAPIC: the four pins of each PCI device on the bus are also
+         * connected to the IOAPIC directly.
+         * These additional routes can be discovered through ACPI.
+         */
+        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                        XEN_IOAPIC_NUM_PIRQS);
+    }
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                       &error_fatal);
-        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                            "rtc"));
+    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+    pci_ide_create_devs(PCI_DEVICE(dev));
+    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
@@ -321,7 +301,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, pcms->pcibus);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
@@ -329,28 +309,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
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
-    }
-#endif
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.43.0


