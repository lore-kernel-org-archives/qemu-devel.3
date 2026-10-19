Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC8CCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8A-0000Ue-CE; Mon, 19 Oct 2026 08:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7z-0000EU-Gw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7v-00045G-Gk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:05 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JBoEoY3623171; Mon, 19 Oct 2026 05:05:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=586g2KVctB5YEq0NErTXbjRn7y95bj1e9Czd5pSiT
 qI=; b=NOMDaUj6TNLUKWzrBHrZ3QtrS8NfNyD0AxnIzQL4N/FjFDAQ6vULHz1Kl
 woat3qo2ijrtTGo+H+RwbTwVDVZwsqPNCPXtMreN6BI3Msz74Nq225aMuVSsoYul
 xvRL21XvDE6xjLF2JuFW1utDIVDxOPfqvodXKxklMUsr+xl/qJnKGIi9Im7js2B6
 1RaHlt50DxT5Fhu+0TgVW6YkngiwmpGRrrbFVLB3k79wIzHAMvHnCUfq8BoDnSs/
 QJOYCaAuXpih4zLn/o4RT3KwWXl8a/DLWW1RO7RsMsdFEvLDWIxj+SZVKHd6DnAx
 IufHstwWyzTyNEpM+MOJPDSs1iJFQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021128.outbound.protection.outlook.com
 [40.93.194.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdjnwr1ew-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQqle6RULmRduOI6m908aDq0fEvcTiodHI1k84N3GTPPQSFbrRdtKSOOp1Sn5cV3Tz0vpe7NNaBptjpl+2y62URmivKdCAYzQIp+D12WA/3ESdYpSMJjzf0ygFxzoncnXoLguaJauxri1nKBZ81yzGlQyqmzYmfsWEBGEfhPGSWeHMBabEFCWaw+HJf5zbL3DTM1USylnDd4J8KW02QNBGoNgT1yTcA1AJWPVS5OvDRea4tkPUCeag58dqwuh5ENMyfCFDM9qPnF3O0L5rEHpyhq59RS4CnIbOD50hmCO4IwL2bf6HLJbJfhZ/ZZtXvAuSiYaDNNWrQApcKFnDhJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=586g2KVctB5YEq0NErTXbjRn7y95bj1e9Czd5pSiTqI=;
 b=oWYNQVQp2T7W+edA73GRwOCDDeZQ7VnqcBhlLPvyE3Cr+bARK7bQBFUjZ3fNyyVhptCCVc6MRrQLIRZIxnABx+aA+NI4JRFchOmmXxop4Mdx0VVm8bTBPDwoT0EWjBRqJEoZOfRXfa1oQgJX1F5Nwd8YTs/o1kdrax4FVvjBomOIH0PMAE5iy104P7K1LtPWeQFYf1Ftu2ZYxozCWJyjqJSs1hFnUodTeqKsqJUrZrslDvqT5rJFlGOj5v0jpRLNExKD0BlfPgfISSbCoskVlTF4EI0BStVkdPSZzJ/aA6e6fL8NNSNuCouk7GN5f2bLysyruZSZzMcDf6T/VgFb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=586g2KVctB5YEq0NErTXbjRn7y95bj1e9Czd5pSiTqI=;
 b=gG0EI3tT05zUWAtdCoQjGSuBInnZzuB0EjBhlW34zjNNsLQO0CaOic3mSypW6cT9GokQp60OWJTj8iNhV0SsP/OZzOZgLYSC/n9FVjvLvzRzX+mFibAdo5IqSo3ZHPgh9oKFWndoKUKBYuhA/83DtBxp3FFCYB7scQ46z9ZWMla7RO1GDY6MNNoRES/XKgBz5xl9l3k/5xPD6BeDvgZE40Ohibb/1dCbBUgxHaY9zqaXn0o1PvHaMNxEY3/R2YT996ksQNichzqpTPs4/3IBDUpn/a/9HMcGCVXdoiDX/rHAOHMgU6Dg7ARjorbKg1y6Lm3EMllJLEHVSJ7W6Ak8wQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:55 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 11/28] i8259_common.c: always use cs for I8259CommonState
 variables
Date: Mon, 19 Oct 2026 13:04:43 +0100
Message-ID: <20261019120517.1448687-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: da3e6171-b6c2-4e4d-1791-08df2dd95451
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: vyhJ06LyuMU2h1J69pioaYcj3GTBlZj6qKwU8RjpbgZolQb5IcpDlpHSnae4+zVYuqhzaHFycKpgMCXitMfd+VloJ3kHQCujvjkvpIjxZ8FCYFpgFFyoYZotU6YuLy9ATsF6VE250UqeLVs1hzerBQtLWsqY1iOShplVRzyVzCra2OyOGpWCWySTQCF60GURGWQgfoNsp3esGuXvmHqbmSNhjdL5vg4VRh5bU4fFUh8xFOfDAcnY3VI7AZ9XdcUKPqdi7wCrfnx6IT2z5gbyVScDOwOC9wddRM99U8zIcsmAMXn5+EsSeVF6WFsP6XMpUjoAv+23W24YThKW1oX12SbNVrT/+FNpf4oaJd9GzYP5W2H+aOL9dQezy86PDhaOg4JN2S7MmehCVgKqorkSP92tDvao4+LsVkpJSsJzupyXDmBVxfHDzUxZCBbGYRnPLQauLRqGuSj3l6dixToTjv+or0NyXgcntimIzZfY145zZxRTb+DR1hVy0fblnDF1cxMcZPOprYio6jh90WitsMNuaE4CzALYIMz/j8L64z5ef2ItHyGcbvdYNa5nDjtYkeU1rXl8+jrLRa0FGFoLWKbpuI2GhH/m/alHxxSohsMQHnfRW9acPrp0w+E+/Nx+F2JHb63TVJNjuobylQxoxz06ksPiFWIWKrr4TYKVSEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCTbcFQjEKd1re6ZANX+WhFneIMN91BtKIfEqY+lGL7J+Yaco+xLefDAUQvl?=
 =?us-ascii?Q?8YDf7Rlgg/4F+7XFpoa1gu3rSmBHoRkcVvPaSURmoiofqLzNduuRyUHlVz8m?=
 =?us-ascii?Q?MF35NJ8SarU76HX8FmrTwBmIvL9fiDupKZHcQRUWywewkTnBQ8UDvLqTPjW7?=
 =?us-ascii?Q?pSUVIWQ41f+kInC8kuq2XmeBlcMwsqKuu3W5MXMIRQo+myNQN8Ro7JPVijsS?=
 =?us-ascii?Q?e1mT4r6IjQlMpra6LzQ6y+OnveMxG6xSatBY3rvGgHTnzPUw8pC1eqfI2Hk1?=
 =?us-ascii?Q?2VA26KiUpU74+aiDraDBMnWWIXJktYYO88UCW+AVzhgoNzWVt1zJieiFFvKb?=
 =?us-ascii?Q?4CzFYNVwM52iUhiSsPGjUxfOD+OoNEsXrbeK3/WVg+/74CgCtPuULmx/0lsj?=
 =?us-ascii?Q?MPfzEWHnMdIBPCBF8iUxeX2d4trDXf7FDRDQ/1FX7f7qpYEfBv3w0IcpDQfz?=
 =?us-ascii?Q?NSKpggJk/V2z65MGdEpDEdcUeJ7aFdvIGFyrSxzMiBpRaUeF279hBSvGZ0wZ?=
 =?us-ascii?Q?p5CymlD5KdWmmBd0L0GofSW4c/VArIaqSMaDyci6yqm3fkktXMBX4N4RfoU8?=
 =?us-ascii?Q?IYdTyc0EZBV9dcMryp9rbbJKNfHvw5bzHXSDDIP2iAJ0KmuvH45CF/fiOk1W?=
 =?us-ascii?Q?OqXBLG0LnVdweJ9rl0B4+m91L34VK54UFBSn8vsHL3rzFFD2VI8O6SUrvPR9?=
 =?us-ascii?Q?OQqX6aQlScJvs5FcuSl6yQNW9UA9d5Znn5I3dpJVURdyTWH8Krsxv9wGM8nE?=
 =?us-ascii?Q?M+8WhrJxsdJfxi/i0TfVUW6vIhQdXgHQDpZuIvFu9KiqbpGvkuSW9x2NuppJ?=
 =?us-ascii?Q?IkJUN55RHCfUhJr6TMaMLs/1bROsNWrxtuXBlH94vBcGP0RnD99Q2pHe8DQo?=
 =?us-ascii?Q?9+JTdRczm/+wfNg8F0yofP9mCZOZ9qRizFrB0nbngsfT+zYIIafHv3gspir0?=
 =?us-ascii?Q?54xJ7HHJiGtEVdrUhqZhtHlbAxR4bodsNx+dtbwkK4yL08BDlE4YHkTwkfJX?=
 =?us-ascii?Q?2D4LBtycCkBVaTXbqKI5XEiykvCQ4ebtcnDdvyT9Ulscni5IxEhFZu+TTG3T?=
 =?us-ascii?Q?R2Fr5GplRdb0QBdXPdlQV13SZuvB5ME05ueTSCNMLrTvo0e2fRldWk0pEkOt?=
 =?us-ascii?Q?asxWlDUH1Gd9DIgJaJ98sNzLWpNTjsLTFMUyJ3h3ngZsVT/v9EhRxkcM4jWy?=
 =?us-ascii?Q?kQqH/1F469eeQjkdawxwMlwiK1ySz+LtRyK66Cu1ec1SLTFsGLgiUuTUT9O/?=
 =?us-ascii?Q?wE/m3CWvEkwZkSWGIjx0G+PzYcR4gGvcm67mI0HZjlEAr4Sw1/VS6n4BvGbd?=
 =?us-ascii?Q?URfqsxxzoOFO6X7eHVHVu0sPYu6YNfVzQRHZhR2duCK7N8qDOnnvdetmjfQB?=
 =?us-ascii?Q?kjQBHA+6p8sGX7ZWwVSvb9/eosraXc43xyrvyShYwH/oqrobfDGKK+ncI61v?=
 =?us-ascii?Q?ML1C2j2pR6MZA1FmrjPAoNyiQ0WUz/iWHu7soCabie26SrwlhtJQX49gHBXx?=
 =?us-ascii?Q?sqaM7C4CruBn3I1CMvNwU/XAndZnuEJgX5Qcbt80WU/ewLohwU7KASob0tsk?=
 =?us-ascii?Q?KHitdCByAlrkbMwhiNww+u/UswkfKgCY7vDeVAHwkol7eqyERqZA3UX0eCBB?=
 =?us-ascii?Q?oUj7V45sqXBqzXGcajAs2/Oj//C3YEMzmIsOvezA6wBQcA6Hn4JkjuKjlm+E?=
 =?us-ascii?Q?lpFhcKyl13c7oy2S2jAlyCvFz3Laab50ZNcz8fiuBT0Yt+HFUbu6/W505ASt?=
 =?us-ascii?Q?asMynXsi2MSJ8LGNqZLc1wqsMheV9HM=3D?=
X-Exchange-RoutingPolicyChecked: ecR+Xe8z7k7GZgSVenhkaEm+SHBLAkkSpjdzYXb6cwDwY7eFTOb27tZWdvJeHV0RUVs6YAKAxaRKxGm9mvR55py/sM4l5Y8HK8JbqojaJXLTOkPBSJPrJeLYK2nKbp+oq1D4gOgRPYQvEDGO1SLLwG3isdQ1ekxIJiBK6y7EV5aUz0GIyPdJkdD4Dcmi8KZX0w9AxzjCy5XVTRbPvUk61OdC6w1LJCcK9xvZ71HqNj6vZgEQrKAdhZ1Z99lDnNTh+nX6PyYVicVagvaaiI0c2eGYck8NMLopdhCXEZrXZdbluW5Y6dLcsNZ0m46FH6mSRxBd02lQp4H9R8OaQFu/hw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3e6171-b6c2-4e4d-1791-08df2dd95451
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:55.7998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh6hg9ajYdZ1YiNI6E+jLevNSfE7BaCupWx7QJZSnQUF/5Trx8pOyh/iEkWuqyneo5RRGH0KGGDJOKwsiA4DZD9WA8ODY27d8Pxq+ctsNIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Authority-Analysis: v=2.4 cv=fqdJ914f c=1 sm=1 tr=0 ts=6ad607a5 cx=c_pps
 a=iGETFsOoOHXRiUW2e12q2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m1qT39pvC01PgN2II3AA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3i-IRsSosv4PP0ezz4u0Pj3nFyUwpS4u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX1AwHeSDEXV1/
 6XWOqLR8P/x3cRi3OeQ+K/CfSg34kQGYoMCzwLnOpwaU5qUPKTn+xYyL5N+Z51axm6KXX1KlM3/
 Py3XBx9QHB778KgH5wtPednuNRCq9c0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXzkwIo+gzsAmM
 bHeCTgBVSFqP+Msu5St9eBFgGtzB7Qa9UZIw1c/5A0YNhuuLqUDzfHFomdP29N1EY3vR3HHOtlw
 aJg8RScDokAbQqpKoyAvbuwO15ew+k9XV8b762pweWJgdjtL7trJlmv0F/F6mXAkJNsmF+V7Uvr
 558yKQX6YAzuCcnrM6gGMtjTQtLyHleX0XTNZTSx/usPgki1LCXj5146x2aLq9GjWFCNrKjhoU1
 kc0vWXEw8DakNFur3Xy9FlZy90v9o1s+++6uGz9Xhda+RAPMXMG3v1usJWq62euOe/Cw7m5OO6k
 BmzRVM8NkopwXc9NYCtje2VyltC9meQqhTsTaKgYs0O23pjyrXkcjtCWoLyVwAVatG8ViFusKHM
 WtQDstjVPww7fpRHBJR+rWyPBHbtJi+pmrWkVEbfpY5WcQ8ZQ+sEM8OJqW5gh1Bj2zTge31rOQq
 rrG3ls3VxAyjnzLccAA==
X-Proofpoint-GUID: 3i-IRsSosv4PP0ezz4u0Pj3nFyUwpS4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The use of consistent variable names makes it much easier to follow which
fields are being accessed from I8259CommonState.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  6 +--
 hw/intc/i8259_common.c          | 74 ++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index e039d6f067..71fdd74266 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -37,8 +37,8 @@ OBJECT_DECLARE_TYPE(I8259CommonState, I8259CommonClass, I8259_COMMON)
 struct I8259CommonClass {
     DeviceClass parent_class;
 
-    void (*pre_save)(I8259CommonState *s);
-    void (*post_load)(I8259CommonState *s);
+    void (*pre_save)(I8259CommonState *cs);
+    void (*post_load)(I8259CommonState *cs);
 };
 
 struct I8259CommonState {
@@ -70,7 +70,7 @@ struct I8259CommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(I8259CommonState *s);
+void pic_reset_common(I8259CommonState *cs);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void pic_stat_update_irq(int irq, int level);
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index ac8dc7cf00..705a28ecbf 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,33 +33,33 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(I8259CommonState *s)
+void pic_reset_common(I8259CommonState *cs)
 {
-    s->last_irr = 0;
-    s->irr &= s->elcr;
-    s->imr = 0;
-    s->isr = 0;
-    s->priority_add = 0;
-    s->irq_base = 0;
-    s->read_reg_select = 0;
-    s->poll = 0;
-    s->special_mask = 0;
-    s->init_state = 0;
-    s->auto_eoi = 0;
-    s->rotate_on_auto_eoi = 0;
-    s->special_fully_nested_mode = 0;
-    s->init4 = 0;
-    s->single_mode = 0;
+    cs->last_irr = 0;
+    cs->irr &= cs->elcr;
+    cs->imr = 0;
+    cs->isr = 0;
+    cs->priority_add = 0;
+    cs->irq_base = 0;
+    cs->read_reg_select = 0;
+    cs->poll = 0;
+    cs->special_mask = 0;
+    cs->init_state = 0;
+    cs->auto_eoi = 0;
+    cs->rotate_on_auto_eoi = 0;
+    cs->special_fully_nested_mode = 0;
+    cs->init4 = 0;
+    cs->single_mode = 0;
     /* Note: ELCR and LTIM are not reset */
 }
 
 static int pic_dispatch_pre_save(void *opaque)
 {
-    I8259CommonState *s = opaque;
-    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonState *cs = opaque;
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
 
     if (info->pre_save) {
-        info->pre_save(s);
+        info->pre_save(cs);
     }
 
     return 0;
@@ -67,26 +67,26 @@ static int pic_dispatch_pre_save(void *opaque)
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
-    I8259CommonState *s = opaque;
-    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonState *cs = opaque;
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
 
     if (info->post_load) {
-        info->post_load(s);
+        info->post_load(cs);
     }
     return 0;
 }
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
-    isa_register_ioport(isa, &s->base_io, s->iobase);
-    if (s->elcr_addr != -1) {
-        isa_register_ioport(isa, &s->elcr_io, s->elcr_addr);
+    isa_register_ioport(isa, &cs->base_io, cs->iobase);
+    if (cs->elcr_addr != -1) {
+        isa_register_ioport(isa, &cs->elcr_io, cs->elcr_addr);
     }
 
-    qdev_set_legacy_instance_id(dev, s->iobase, 1);
+    qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
@@ -118,9 +118,9 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    I8259CommonState *s = I8259_COMMON(obj);
+    I8259CommonState *cs = I8259_COMMON(obj);
 
-    if (s->master) {
+    if (cs->master) {
         *irq_counts = irq_count;
         *nb_irqs = ARRAY_SIZE(irq_count);
     } else {
@@ -133,22 +133,22 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    I8259CommonState *s = I8259_COMMON(obj);
+    I8259CommonState *cs = I8259_COMMON(obj);
 
-    pic_dispatch_pre_save(s);
+    pic_dispatch_pre_save(cs);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                            "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
-                           s->master ? 0 : 1, s->irr, s->imr, s->isr,
-                           s->priority_add,
-                           s->irq_base, s->read_reg_select, s->elcr,
-                           s->special_fully_nested_mode);
+                           cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
+                           cs->priority_add,
+                           cs->irq_base, cs->read_reg_select, cs->elcr,
+                           cs->special_fully_nested_mode);
 }
 
 static bool ltim_state_needed(void *opaque)
 {
-    I8259CommonState *s = I8259_COMMON(opaque);
+    I8259CommonState *cs = I8259_COMMON(opaque);
 
-    return !!s->ltim;
+    return !!cs->ltim;
 }
 
 static const VMStateDescription vmstate_pic_ltim = {
-- 
2.43.0


