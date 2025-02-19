Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E60BC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPG-00040H-4l; Wed, 19 Feb 2025 09:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPB-0003lr-Va; Wed, 19 Feb 2025 09:50:30 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklP9-0007Zs-CN; Wed, 19 Feb 2025 09:50:29 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBEuNl022547;
 Wed, 19 Feb 2025 06:50:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DwxnAX2BHGq2NTNcQXfmH8RKvi9Q6E9jAgmxXCPtR
 xs=; b=YBz6f+H3C+vvYKrMyVbD2d6fYY2Ca/9RKr2TyeGLxyQNQDCCGskkeycM2
 XolIeYunxIYuNDKdLwDaLzqlPJukqkhRNiZAHmJAAxjjCtZY2DM4CTzhXyNmWuyQ
 0LwKHlPu4qyL04Vn6wYB1kFynnNPR3fvcLyjDcL9jnbSwhGqmIkkY/b/6BJZ94qN
 TP5XXtPX7f1qydvufRqofdmqEhFEIrHgkro9P0dxufBe8E69YbblWbt8lakLPYE4
 xqA9bLW9HSQcSIGyAuQxmQMccpEhDBXNRkpjsUnRU6h947l7M8SW5ynuhbsTAI8q
 FG/Ict6B6r8aGv6Y6lo4MWYkEpgYQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4b9hy5d-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPVt2CbDqgIyDKG9klxPwkilkQlBNSskjN8uxH/WektBwssaXmz0gMwcpAou9QzMaN3ZLJERykrWq5prh2wPje6ruDWhqPVIimwhVubK/Tx8AyDZ2J1u4NYc/OVxjm+A/VdvEtckR3elNEbnOXq5a/tgfTI2jgDOCOYqqncXDLf0RkDg3kNQf8bzPQUpSHDuoc6DMzLTTrc2hWpQaBVTz/EvO/SpcLsZsZmZDCPp8uEgFnzmdOXO7SGk3C4beMKRvdFmE4Bv7YEaLR/jQgfG2dwBCr5828d/J5edeVfGqnWN9QU8EOXPIQRPLpHrKD65tUEH8vQq5YixfsWJOXd4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwxnAX2BHGq2NTNcQXfmH8RKvi9Q6E9jAgmxXCPtRxs=;
 b=DIJSC7C2yN4ZnsP9mT1WSJf6p4pjqIqXZpptvC0PuX2KAwspxAIXNhvuDBrNajn4lSVw1RPr7iNkt2A36VCtrv3yRTz/0uH3VXovz0OQxbJBUqEFswKhZJLh3dANDnLbfivQIYrymZBdJGA1VhbzQDQfyZWFbMhkOK15AUk6CrhD+HLIoL93xZNh5c7Gb//lRsv6P13mS6FPVTUZxvBaCDZEzS9n56atmm7PjAjy/VRf5qetX7qbvK4KIiiSImgoak2lwjKEz+XIriHVZL/xGKuB3DHyt207QxAGtvg8equUYO4uWDlNbYX+9VoUeGhy4UcMFGsvnFQv4NBmoAbYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwxnAX2BHGq2NTNcQXfmH8RKvi9Q6E9jAgmxXCPtRxs=;
 b=dpQJqtGB8PrjUso/ikcJfknDLQXkLqmFstLEF5suWLDhIh0rSM96gkGoWw4uRXqmr4CeuRp1PzGdHfFdQh/iLnpRX8b7VudysAXEz0RzeAdOHz5DPzfFIuqrH/rnEFo6lervjwkCd9BBQG/lUDrTMQE3JaN9HTNqyBPApYVg3da3GDjapTykGmBmGNOp3ZNZIzLxE/QXnP75tZF/snrBJueBVnGiCB5xalH7J5HqDPntc4ViQZzmf7e015Tnn4sa+dKEG8eXetWI7ZhRsFXZnm3cjRB1c8z2MK/Dl8WR6YYuNKJDYVRxGkqgMloYP/MZ64MpV8IvxCdQbfA6xqLRVA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:16 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:16 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 19/28] vfio-user: set up PCI in vfio_user_pci_realize()
Date: Wed, 19 Feb 2025 15:48:49 +0100
Message-Id: <20250219144858.266455-20-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: a455c394-657c-425e-b89a-08dd50f4b8d7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uhp1EJtN673+6NoNTGUDrccCa6F8d3TfGW3kZPRjLJa2p/SFq2+2x/AwAFCn?=
 =?us-ascii?Q?tRuhbw4bInO6SBKL694W+ukTeTV8ozcO6wOQ7LptHz3LsneY0nD1Bjs6NF2h?=
 =?us-ascii?Q?zWdNDGl3gIa39S6GXCoovQ0z7Xyz1tcbIFTZLrUfXybK0Omnxed1KZQNhz+U?=
 =?us-ascii?Q?nlgffQhLZwpeD0rvk0d6ldWgobh50imonP7y/1iqb4pXcAyTaE+AryG3IURj?=
 =?us-ascii?Q?RDe7cfEeMxKDYpaY8LxIY11DghcAdWZjFm24YjYKeLK645J6Q3xI+x6XPLXY?=
 =?us-ascii?Q?Kg+CU2nKHzZTKXiRUUuwOCkRkFK9248be6EGawEw/uLzGngXbXv9BA/8eMSK?=
 =?us-ascii?Q?RDsGkaX4JGeJmEBDP9QJ17BxqQMYP9E2T3K9L5lRtqox/98DkiAz9QrTb7Ci?=
 =?us-ascii?Q?+UY1xEYE80nOSwpITAUxB1b+v1DM96RKNcmq/+M2Jfw+3eWPZMK0LZ2uhZ5S?=
 =?us-ascii?Q?7Dipj0kG+gioY+CFa36K3NFlUa0rgjOGyhUpyc2ezNpIoCWaShkHPV411c7+?=
 =?us-ascii?Q?8e65WoR+T7i5/UufD2Rc+sic89Sr6NA0f62asKlbXi2NlxPuqbPLiJWwAVDD?=
 =?us-ascii?Q?THGiLnmjuxRhyE7GTYtW4Dv7Ye3S1JTXY6mMN7z1bnlGQiPtYtUfS3E1Ybqg?=
 =?us-ascii?Q?ndMIKScRyg9LhoSEcmTFoxN/5QYMLqL7KewtNLyolXk8ndPANWzicRPMCwJE?=
 =?us-ascii?Q?te4j+QIDay21yGgL5/tIKjWYZqXWm2wGi5RSUpmX2gJcSRsgLfiyQ6y/Ozm+?=
 =?us-ascii?Q?L0PBnWnvYETYCKzqOsbjr4u/6OjevkS0hGxksohqTXdG7t8f/fRYrwOaE5t/?=
 =?us-ascii?Q?sM4bnlCjPJ+H99956JfZ/gGPIGqwPZKYH/qA7H3l9G3QaDQNeNKoz+rbav8q?=
 =?us-ascii?Q?5hf/pOPGkbokFbVjjzmKfFRcslXejATjeQmapLM8ik+ZbmDQlUOPGKTz/2mZ?=
 =?us-ascii?Q?yQDKdc9QssjSIi69q1LBncelE31HUBe4aJnMEJPfLswuA0hbayagdAZWunrp?=
 =?us-ascii?Q?2HRQjDQfu1qFUmGR+cuoarFzAKg7v4LHudlR89KeLHnT5wSM75hWYc8BwzzL?=
 =?us-ascii?Q?+F9URbSnJypee3CV5zlmmitxqsQg6m4Zv0MqvLUeOwJEvq7MTFd+OVrdjROJ?=
 =?us-ascii?Q?STsKPg02A5g5M1mYima+1Dyhkq+W1pA/5QeF7g1z1frLj5FXBNgAhx6EUndr?=
 =?us-ascii?Q?hYyVbp2PZt16TEJytZnqZMWnA+4MXzCtUfKvKi5wfTGHmjTNKd+HJuvrGI4h?=
 =?us-ascii?Q?NoXsPAhSGS2L9K1FsDTFbuWScZipnFGZ+hLa1LcI2u0yT8JlrytGQkYgt6+9?=
 =?us-ascii?Q?FmceStSmSOFUMpuaupDUM97Ac6Xl9cEQ2QcMMe1mG76E02UbzzgE1WpJB0SK?=
 =?us-ascii?Q?avIRWsSzB0oNlPfWrOE7S4jQ37bc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ASAHOudkRrs5cCx96vMd9hEK8RUatIqNqYmUXC4oZNhu8ZwXubDKXG63GY6M?=
 =?us-ascii?Q?TMIuaSkHNu8397KdyI6heva1iUhNPW52Dv0GSgiSqEFKKrwvyqf+T35Q+6R3?=
 =?us-ascii?Q?Pe1CRdCg000UjMDh2lSRuL8kTbak7Gb6GwLuhehgfR/RtoZgaup0eztywTrd?=
 =?us-ascii?Q?UKizGkJHI4a5wemWPlcRbg9oqPJ1jvJ4JQ+gf+pHYE4ae29OxuQHco+BJd7p?=
 =?us-ascii?Q?VB5jkIp2x5iFxlEGK/rnv3S8896BbIxHujudek8MrWjT6hXf/Hyo/ESBR6r7?=
 =?us-ascii?Q?inltyVqbknBf8wgQTRDrMa0/8f+cFqXVazMuEIwA7wLGrfAE/NkttDBqjaui?=
 =?us-ascii?Q?y3UFsFVp6vjNPo34IyOtzaOOsp0RGQNpJpGS4ez6zJ9fe1PcocGRDYS/VjSN?=
 =?us-ascii?Q?JDgzOZsWifpyxOI8DS5dn5AtoX/BhvqaHukOjO2EBHiVLNv++pFxxZ4Jim8y?=
 =?us-ascii?Q?rEe35EIfPOU9rmW5MDdYzNhBHNi652QqJHvA/q3+ObbxfcKMYrv1afp+aUaW?=
 =?us-ascii?Q?/q9a1ArIphP5W1hYAKyvf1uwlFZaMiboW22RuQjpJLVKZd/VWyMZjql2xqjG?=
 =?us-ascii?Q?1nDlMSsxiMEzhxEGcIX4qrQNXrfc8nhEoNT0YWOI54evm6Q6kJg0UGV6DVaN?=
 =?us-ascii?Q?U+wDNqR6yjsRRY8tSXcs0IAGz1J9p7cEFQ3xB9x1GM+0J97aZRVFlkgGT+hI?=
 =?us-ascii?Q?Lj3aGm4/TdZE/LHbul/xhnhLElnGKCIEsBMXcTNl9m2r9uLkMONOmo58rnV4?=
 =?us-ascii?Q?0aLMQtZpTPKZGdpm5K2wIvQ/x5cC/eok8b8zfxfu35FXI6iR7fFHYsuC4YQJ?=
 =?us-ascii?Q?sP2R2jFXOL2MqZob1WFpMLPzrUkQ/4mVs4joyreLo7eJ/Ad/eGgsW3MRpRBS?=
 =?us-ascii?Q?OW1g0+pHzb/djd85p5QRXSJuqDq1z4Rk5A1BPtxpU5UAwb2BZ5EqMlFiGn2t?=
 =?us-ascii?Q?40I7MBGDkXJEChh+Yi/hWuy/G4N0TwfgQQPhwH8v6KRuqdsK4C/hY++4iwSe?=
 =?us-ascii?Q?hhoRyjID2fZJJeKAgMPlNpTmrsXr7w+Fc/m7cQo0Zw/anGMygAYjRTebtmTD?=
 =?us-ascii?Q?zVFTkEb+89YLAJZ3d+9Yuu2vWKCZJWCQ+BzrICdBgj8hzMnvzm31wCnBzCFX?=
 =?us-ascii?Q?tU9d3loVhZiGLe39yr6qbSban3aAw0C7z65fEunDWiMG+/EC6gj8PXhv4z3/?=
 =?us-ascii?Q?LAjKooA8b7PCslRytkjEy+0y1IY9ebQfv1A90KUkySRBt0+T8Y3d11+A3cDc?=
 =?us-ascii?Q?cUeWRqKnQRgVjEqd8+ZktixDQ5GMIJRBF6By9S5vb13DL9OFrPEllyhtbQ61?=
 =?us-ascii?Q?ll6SDoF6OqgBK7l5iS4yuuzMkOeGbe2Aa4dGL/rTB1yrph81Gk0JLz9mplTq?=
 =?us-ascii?Q?Iz+BDfA1g/64eKalNO5SmQ23Pv2zFs3WjlEyTk3aCu6gp9LiNforKJj2lmC5?=
 =?us-ascii?Q?aX1FmXWEEEUbMKSeU9IFx+5h7+F9UE5F8nTx3IRyxbDc8fGJe1rtSQ5igniu?=
 =?us-ascii?Q?1J6h/2A3R/sY0CYgMmG26m7g9HVgNFhKOAKbKc9OTBtTUkyEZMYSMAyQumiG?=
 =?us-ascii?Q?Y1ilEITbl0L23KVezWwGqb1HPDamH36gjZUUK6/L?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a455c394-657c-425e-b89a-08dd50f4b8d7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:16.2058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x19yrGT8+NC/kd2hNMIDC/CtkHMoaBRiExsABRpi8hctlHLqJCebcoDI2FfhKDamlKVsAXteTbvc6vs7RVuGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: 0gRgtM4zmho0VErEccK5RnA-Mw88o_MZ
X-Proofpoint-ORIG-GUID: 0gRgtM4zmho0VErEccK5RnA-Mw88o_MZ
X-Authority-Analysis: v=2.4 cv=HMQ5Fptv c=1 sm=1 tr=0 ts=67b5efaf cx=c_pps
 a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=3F7eiexbnXk0NDyZYdgA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Re-use PCI setup functions from hw/vfio/pci.c to realize the vfio-user
PCI device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/pci.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c      | 18 +++++++++---------
 hw/vfio/pci.h      |  9 +++++++++
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 26d2960985..b8c1cc34c2 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -75,6 +75,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     AddressSpace *as;
     SocketAddress addr;
     VFIOUserProxy *proxy;
+    int ret;
 
     /*
      * TODO: make option parser understand SocketAddress
@@ -127,8 +128,45 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    /* Get a copy of config space */
+    ret = vbasedev->io->region_read(vbasedev, VFIO_PCI_CONFIG_REGION_INDEX, 0,
+                               MIN(pci_config_size(pdev), vdev->config_size),
+                               pdev->config);
+    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
+        error_setg_errno(errp, -ret, "failed to read device config space");
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
+    if (!vfio_add_capabilities(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    if (!vfio_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    vfio_register_err_notifier(vdev);
+    vfio_register_req_notifier(vdev);
+
     return;
 
+out_teardown:
+    vfio_teardown_msi(vdev);
+    vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
@@ -164,6 +202,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    vfio_bars_finalize(vdev);
+    g_free(vdev->emulated_config_bits);
+    g_free(vdev->rom);
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 168e331607..f85215417d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1730,7 +1730,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-static void vfio_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_teardown_msi(VFIOPCIDevice *vdev)
 {
     msi_uninit(&vdev->pdev);
 
@@ -1831,7 +1831,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_exit(VFIOPCIDevice *vdev)
+void vfio_bars_exit(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -1851,7 +1851,7 @@ static void vfio_bars_exit(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_finalize(VFIOPCIDevice *vdev)
+void vfio_bars_finalize(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2419,7 +2419,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     return;
 }
 
-static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -2768,7 +2768,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -2886,7 +2886,7 @@ static void vfio_err_notifier_handler(void *opaque)
  * and continue after disabling error recovery support for the
  * device.
  */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
+void vfio_register_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int32_t fd;
@@ -2945,7 +2945,7 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
+void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
                                       .index = VFIO_PCI_REQ_IRQ_INDEX };
@@ -3001,7 +3001,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3094,7 +3094,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c0f030f4db..7e126822f9 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,15 @@ Object *vfio_pci_get_object(VFIODevice *vbasedev);
 int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
 int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
 void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp);
+void vfio_teardown_msi(VFIOPCIDevice *vdev);
+void vfio_bars_exit(VFIOPCIDevice *vdev);
+void vfio_bars_finalize(VFIOPCIDevice *vdev);
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+void vfio_register_err_notifier(VFIOPCIDevice *vdev);
+void vfio_register_req_notifier(VFIOPCIDevice *vdev);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_instance_init(Object *obj);
 
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
-- 
2.34.1


