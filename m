Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A06C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFam4-0006vp-BG; Thu, 15 May 2025 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalR-0006BS-83
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalI-0006CR-NF
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:52 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8GHeZ021276;
 Thu, 15 May 2025 08:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=npqxWyJMo2rtaXRZ0jYvnVrrUmWBxwfW5iGHoqj/i
 zI=; b=uVtuOCnVrmktGyo3jLQKq5dcM68t/0oqOsTdtB9X+OI265rxJR34nBMnI
 5tZkel/6Shovckp4OpCKMC2HVLjT00YtLkZFnhejGVWUPXIpimHMAPWS55rqHBTO
 F+akpKtyisn8BGhJP+qgAxPk6boQNP7/FBfBm9jBLoU/kUDcXfEbi+A7LRNo+gxo
 S7ulu6wsBKGvPhWRNCIRPqVNFh6Gh3etbjQtAqYk9D8eIwSufns9BXaz+ZN7Bevz
 +tq5AFewDTkjgwRDiTYBN0KpIz/VWEeX0PKIyWfmSnT3OnfOCwCB00xRZAwTijDW
 KF7r5Pk2j5os/Kd49KHZQCjUo5wHw==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbctngvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3/yBF24Flm3g2e3k02Z2pTqgGycAhtgr2YylPmoFwbr5n8FqTrqCIuNpWUtfiFpj1fHRoBrULtRPtwQxjDskx/0eVcw6aBwI2UdES+noslPB15VAgKkYfpxI5pb615Zs9DXrA8wn1xZs0AmoteHyU2gOjccPC3fe6fXK+wmlNCADGLM9NexR66DBo7J6KereZzlAU1JQr8Fu1ZI5qbw1XcD4u/H0/Z6NboYDKuc7i5RlR+eUO8JNqAtF5nQYUVJlNIOJ3ivMFpxKA3CxzeJ0/aDpS70p0owY+PU7JigD4wv2HbLTObjc90Cl6eo7njVk+LoFAppirHF7Ms8xGQlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npqxWyJMo2rtaXRZ0jYvnVrrUmWBxwfW5iGHoqj/izI=;
 b=lyf3Ec4Z9w3+3DxyqYjLzwRxb6o9EUpbsZKXXqnuFjC10xoxV2RP1rCW7txR+M60lxvVChXNuN1PYDXppL0nVqPBvyOID9BP9SJ2zKAIeRSlgKtHhXCf1gs+HwHaAomODcetZwk2KeEWkYheueeqTeLuZ4n4Blmzl55ywZ0kt8322ZjuFu6p0KLFYhImam+zk7WOC19ttWOdK9xl3MW+UmG6yZS2EBKiv8vl3DuEcTOG3Vh7hn91nxgihbQ6Hm06rIH5JdhAZbbCybBo3Z5buTZJKlDVmV16X6QpvPcjtfr0W5MWry92LMO2UKvd4ihmXlPXCbuFkHpGIqlyRIfyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npqxWyJMo2rtaXRZ0jYvnVrrUmWBxwfW5iGHoqj/izI=;
 b=GudyUDWzndc5Wg9KOr399TjLRSnM/x9wuajasKhronYv7nJEdfx5Nu+uAjq3fIshJ083hPINhyuSBYZec33PI4OQsalVNeij9c79KlD0uIqDH5h1oBpf2lPFQXUeR0d4jgVo3iQ+n3/o98q2yzXh1i2U7aM+O7ZDBtwHUtLXxJCd3HlChdq7+u7DO8jNUFJKe+71GHK3Z1ZL/hG9K9AqYg+Zjb8w8woVWiOdcfNH4E/5cg7M2KA4pKQ8V1RIiBGt5RFYwg/mgWfi2VkgdluxaoXjlQ9wHktz9hlmcD1V6ugxO8etSjpWrMpkhU6oB+LGeRs/ZPkmLoQ/dLrOf3tXHg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:31 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 05/27] vfio: refactor out IRQ signalling setup
Date: Thu, 15 May 2025 16:43:50 +0100
Message-ID: <20250515154413.210315-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea78c17-fd5c-4af0-ab51-08dd93c76248
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rb20YSNB7KYQnXVfIUYoFabYiEeEjLkYu0orHpUVFwFohi2xGu/nDv/jCB7Y?=
 =?us-ascii?Q?3pOelBgzCvksOkhERnaicJPUi+UDZhrwxZ1rXGUALWytuN2XyflMdjl7Vdjv?=
 =?us-ascii?Q?eExdxj4e6JDHvp8vFe/38Mn5EtqvL7+CmrDEiaJhs7FOnyXbfLdf67f6nYwc?=
 =?us-ascii?Q?ERgRoAb6DVWKSyUnqvB2RfRaJ16WdNuKGlTb8EmMjxUjtpdqDcuyMC3IImvW?=
 =?us-ascii?Q?Ue+XXuTOgqRqpCPCBc6GPqco6x8zLI8kv1opybl/YKR4n56igqSAESq8W64k?=
 =?us-ascii?Q?vDQff++IDmUQ2Xyypfbml8WmvgMclurDnRrxyJUzOoTEs4FBVPnVLPAy0lN8?=
 =?us-ascii?Q?RnrpouJCEu7aTy58HXo7qR9HFrHaXxJ6oEIVR/vrSO9oauOlJtQahwEYtY0u?=
 =?us-ascii?Q?uVR0vEOtzA8LbFjhfIZfHdW/3CR6oH0PjIoMvITH947cwe5jka9tmQeMhZsZ?=
 =?us-ascii?Q?kHWg1mL4BKbM6/+nPG3mXZL6OHkXdsre7cIS3LkYxplwoIWcyRHH/NgOtNEv?=
 =?us-ascii?Q?FbNLcWMoUDZiTFM8RQ5vHlG+SNRJ6EL9qMCjjyzNX0mCBUTYuBQjk6l+lcT/?=
 =?us-ascii?Q?MKKnHGolMqyIZi2Yf/sFZT41BhJpCaETVKsShIATrFhNcnvEg4eG8Lu84z1e?=
 =?us-ascii?Q?nNijmwPAECMPSjG6bO+GG9+ukJ/ymxdfxmpxTvcbV/aHslNVo5lTVqS1g0bQ?=
 =?us-ascii?Q?ouo/L7G++wgaKOcWfQ97VB0NllONo9IOCX943FCVOu5mCSlsEQ847IjRyJ9l?=
 =?us-ascii?Q?3tTtiVMVak5JvcLaHCxXSKfyrPckf6g93uagMPFo0bPG9a7N/d/2Q2dojil6?=
 =?us-ascii?Q?3jwMGkTFLd9LyrR806+243D8FUPDgaHHAqA+6N1TWbK2dKclyvD1EEjlVXit?=
 =?us-ascii?Q?2F/BLFOQTl12K2uZvulpaWH1hnXRrMHnPjmHaFKaPbBhufpgGEwxMe9aYr5a?=
 =?us-ascii?Q?9sdSS85QVIuwZfzCRWxTz45/XvxsddviSm7Ypclk43SzdE0et6dXUDlSgnfB?=
 =?us-ascii?Q?qTdBgVltUcPCJ1Z8ZfNc+k+06V9B9WvsCukl5Vi0P6J+T6YF5H6/G+ZhsRWP?=
 =?us-ascii?Q?H64igZS7iQLbeMWLhanRIEMogIhHXyBPYoLrg2kOotB/dAS7bCp4YcjJwbp+?=
 =?us-ascii?Q?bnlO9aKaEB8czrtorKpRmV+6co355dPAXD8FyLMBUUyoML5zU6K/mw5IZcZh?=
 =?us-ascii?Q?/i0qk/KM6TQ3D39zo+gUexNpyPk6Amlx0L+alWewl13h5da6wC1Y0zU1NAOO?=
 =?us-ascii?Q?00jF7tdgqLYMk8KGaL+C5n5XGNBmpNr9YmmWydGP27AQXdQ4prhiL/pjTCVp?=
 =?us-ascii?Q?EeP08q09xMNlNkDxALV0OeAXFVvGtCpuNRfV+wvyohhtLCQFW7rwVOL7hVbS?=
 =?us-ascii?Q?Wdt8PltVJO4EY/Uca+wSYlJxoWIqMMkHpmeAy/xX+T5+2CogxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTxxvlHj0vCKR+ou/b0wIeEVMizO2r7XB9vDGaHJuve5dRryTLhDTYVtAc97?=
 =?us-ascii?Q?j1MTLoS1oL++9qSLZ3c5eBkAblY7HGByPoGs2dxYMXVop3UHAqH8fDKLzU9w?=
 =?us-ascii?Q?sB8M3H8fcFl9PddBWBQm2l3MMloc0apYwSvIvTymA7OLBvgtFsz4EVKxwlnf?=
 =?us-ascii?Q?x7hCcIDUNsEDgOUfV5RAsyMZOvFExOlg+Xs8L1YWI0+JlIjEiutZNe7a/4fM?=
 =?us-ascii?Q?lQuAoc9S1+HzFXLLZaXGyNDKxhXQy9vTYSn7BhOJ7/Zr8grN63f6m3s9F8n0?=
 =?us-ascii?Q?YdzTw0kTV/uWrBa6EZNqNMaho8Ksj69/bYcU1bFlRxuoVCqJbp0KSrOreo0r?=
 =?us-ascii?Q?7cv5jX3qJjAYh/ehSYftjKykF1QtbtuZ5bdkbaOHvEAAL2azHi3s6bGrNLau?=
 =?us-ascii?Q?ibyWdnyLxBe2eBYANfFkWQSmigmQ6p/DmCjUSMEiMk+SUsqcdfTGI2DbHUxc?=
 =?us-ascii?Q?OtwmtG89tnK7q0kqkSMaq4wZ9zz+j+UqbDVvWgJ2kJG7WeczD/MgUo6FHnuo?=
 =?us-ascii?Q?T53L5lubJfEVUdlwSR4ePVGNTMjZwrVw7ohBaY4UKzfWhP9aX6N6QCkNzDom?=
 =?us-ascii?Q?qpCIdGOkWv2xdagsoft19o0fi/J1ttKGz7lAsXUzqQ1QaPgRxoclZaofGnDh?=
 =?us-ascii?Q?ElqFUxvdgZ2esqDp2rn/N1LykV3NFtLapctju0c5ZHuPcJ/IJ0H4QYDlv1YE?=
 =?us-ascii?Q?PP5Tq81XRwefeATUCUBeFvP/RcEg9Hw3GvKJcG4OurXQTIuF3tsh/EuZai4/?=
 =?us-ascii?Q?EpJ5lYLQsoLiZbHCjBB+SxZlXMyAeFcUPVJIw30K8xI+CTWRT12eVds6feiH?=
 =?us-ascii?Q?UOjOLLs9+nXkwkTmsNZgSPeeJCCHLRgF17xqEM5VbRpd+ZJoDAHzyfrkOB3U?=
 =?us-ascii?Q?mkUfkq+YxL7Z3OCVszuaqPS6wZCbOM0t2rcCnAAFA8Yu2mwM1gkq+wdLx5FB?=
 =?us-ascii?Q?hISFIpsDuxUfmmB0/v1Tn1SjPATC4Dd7PGMwTkIOPEpz3Uk54qnGt32KqDOU?=
 =?us-ascii?Q?/van27b0XSDGC24NN/er2oyzZEZi9pBMTpxviugTL/PbbyrhfRiE0h1s7D31?=
 =?us-ascii?Q?8RA1tlDdoUI+ZJDs70Gslle3TT6CSHVgUFUI6sskczDQYu9qEHX7FKW/dlIG?=
 =?us-ascii?Q?lHcCytFYmfOrrjTfH7oOpPXQKEQM9NFm7vxUORDABgq3dnAOU1WAh9JHqc8j?=
 =?us-ascii?Q?yk7UMWGNNs3bGitPv8A9PZC96ccCNYMv7HVFXUIBk14h6obOwgujath3IGZR?=
 =?us-ascii?Q?i1slu21hKm312IT8K2/AIA3YyzZhWX8TSeWKiWBLOpziejQEw70MRFnQfsBb?=
 =?us-ascii?Q?ifhD+egRe0nTqdFfTmKHSLfdzm5depRE5cXvHuwOi+JK7KHB1f6jY9dmmKoM?=
 =?us-ascii?Q?urwMESwuY0OJb+wNyHMdFsyAZn/bNXPrjvMG6c9G2YH1QGV4iXk7NZxCAzCC?=
 =?us-ascii?Q?PQvNYQPmTz4BY8b0HkZwK3EJyJuyo/lMlx8zSNH0xzP3tFaJC+O+QMOrjISA?=
 =?us-ascii?Q?nZWPbOXTtAm0N4aGQWJQ5Pv5DCpLEsrv2YWRZ31Xj3ErztF4wvB+qpkNeLA4?=
 =?us-ascii?Q?ZWvyvrLQxulne7zfjt1ijEmmQBn98Xk+sAVxf3a6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea78c17-fd5c-4af0-ab51-08dd93c76248
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:31.5015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRQj2yL39D3PCjoe6VGW2zYz3+8kox+5fRCFYJET3NWmvzHQsUE995ywEvnwnZ3Qkz5AXf/8bV89cDMStXlrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=euLfzppX c=1 sm=1 tr=0 ts=68260be8 cx=c_pps
 a=OVSnam+0waiSP26xbJD4Ig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=Cuy1blySaGDMMkobshQA:9
X-Proofpoint-ORIG-GUID: 9w-vwXJb0tWOUuRCoMPIITCdLtBr9f-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX7QWNY2y6869q
 Oh3BMO+ZBCRUNdsKQtv0eB0qB7twmRr5JpCizpSzVKuIn/jNUoFX7TtqqNqFw0KmeIt9oKiZ1dn
 BUTFkXn4yuIY5zPypIgdL4uIt3/ifag8sgVRJ8j/RYld/ftVxjrLC4mvV2HEYap30aeOncDXZgY
 DV+Vk62aOr31YVZTtA2KKSkUAT5GERzZtDg4XBHHDSevG5n7goak4Qb5/+W5z+IXttyjfoM09j2
 pMVat+2k68nQAwfJ9Nsak7BhviKGVjU5h8po7PDFLy/isBjCGXMkeNQAlZQ0gN0t85Z3OLtcPsJ
 yDh9N3XZL0ysp2vufcJkqoaK+fo+LGQQILsBhCeWAxLwaIbXyX88nbaaCs3wlJA7qb329xuR0yM
 1uSDEKXYYOCjHjOXSdc8bjoR6OQO1LPK+ltLQ9FpsZsvXdzTiVccu+EI4kAPpEJJ03PdbWYR
X-Proofpoint-GUID: 9w-vwXJb0tWOUuRCoMPIITCdLtBr9f-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

This makes for a slightly more readable vfio_msix_vector_do_use()
implementation, and we will rely on this shortly.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7912c17dd2..9dd0bd4068 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -511,6 +511,25 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
+static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
+                               unsigned int nr)
+{
+    Error *err = NULL;
+    int32_t fd;
+
+    if (vector->virq >= 0) {
+        fd = event_notifier_get_fd(&vector->kvm_interrupt);
+    } else {
+        fd = event_notifier_get_fd(&vector->interrupt);
+    }
+
+    if (!vfio_device_irq_set_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER,
+                                       fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+    }
+}
+
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
@@ -583,21 +602,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                              strerror(-ret));
             }
         } else {
-            Error *err = NULL;
-            int32_t fd;
-
-            if (vector->virq >= 0) {
-                fd = event_notifier_get_fd(&vector->kvm_interrupt);
-            } else {
-                fd = event_notifier_get_fd(&vector->interrupt);
-            }
-
-            if (!vfio_device_irq_set_signaling(&vdev->vbasedev,
-                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                                        &err)) {
-                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-            }
+            set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
     }
 
-- 
2.43.0


