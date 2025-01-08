Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23242E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUe6-00073U-AA; Wed, 08 Jan 2025 06:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUda-0006Ue-KW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:15 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdY-0002Gt-0c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:14 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087vtsB007169;
 Wed, 8 Jan 2025 03:54:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sNUptdF5TeVPO9uqoVmB8M87TardAFuI0PTyY3f0n
 ko=; b=fcfUctbELob3buTPFRMyY4wc+hYXGDFByMn1o5JbMw2CINAKNmG1HdXGr
 5AnpkOpXd8dqcDoJUcjlOCaty4EbDC/KUOZqrVDuWGkUjPfyKOzoS44IfrgFhwIc
 Ory/guvNiFTlfwwqNUtT8DVBBKK1jyOkb+8pTbytNaA39WnkpGJnJOexAfLjQFsb
 rxNfDhdXOXqYRukX1w048qEh6qT5zTuaLZCo1UjCi39dQhXzmlvisTOzJPbWoGQO
 BZ+JvVtuXJ/Go39rINatBzX6Lvu2bnBS5e6oUNMnCHTQMzQ5gcJEdjE7lw/WgBS6
 5eLHT8TvZFrFhlu29iYYP/9SqLKnw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y56eryy2-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qabhhJpOzh92U9+6SR8c7f0N/f/SxafYLKbfldMVNEFJS4L7yOE1KHX0HL4z7KMoykb4AbGOti/fxK3i5LBQ2c4ZKeOIB5UEzKXr0Emxa7hz76PFLvkwZjxj8Mz9IKwEX6QfRtc9Ap9ndUkwnkMXDEvcCijfs69/hkZk3N/8xV7YMt4eeHvHE9WCxCT1x2ARjoUl+ENQO4UeC0VJIBQfsfxcUpuQp55nowfw5hEeIYWAtxAbu8DscKKgH0oQdPJdzjxjGIyeY+qOJIuv7dxGFKy+hz7npgNJRBAxejzF1mseJLPtyKpmgVoMMIznl4Q9mQYwZ7d9XB5hl7QPgPmlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNUptdF5TeVPO9uqoVmB8M87TardAFuI0PTyY3f0nko=;
 b=SlpohCGDkOK7GrEeGsHqYtUTCPQx11Ycsd3r0yLjOm6wjAEXBAZ0euL1APljED7Q+9CP441h0C+DofNlYU5WCjMbxFnDoB3JsvCsk2MuYtxDiIjxSquGXSSpngiRT0pUsKD+zLBabzUKt8vwusHI/jbYo0o71iRhGI1AW7C5aYEYRx1igoWZg9r0bRzY4WQNKRK8yXUwSIfEacuOxRUZLdKWO2t3ymyo2lLIWKWyZkRpsdWc4IasiIZb0Xz5kAUepbuiFhdqSA38Jf8rZG+FWADcNLWP6u8lWi4VkRD6l4DjfBTu84gt/+NMu7hu7SQyQ6A2kTuHDN6zU8t0u8waGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNUptdF5TeVPO9uqoVmB8M87TardAFuI0PTyY3f0nko=;
 b=QM+VdJ0E4v+AVOAnOb778mraXCHPS+t1VwNNB6CDRPqUN9Hyilzl7bK35JAV71Pmm+5XJ90Z/sGYrjZOgZc2m5dvqFpCGnTzaUhD8v13liTor8fe4UYN2lnTIN5EyL6ObHTF9fa3YrifpeNQwYezHSKvktdJzFGZTnT2zN0FyPao9+WgZl0pgaKpQx3HrKmnzPYjjHhQbI/pmIx6qDPrREI9bwkBdsEqAtyvXuSEhZVH+rfMOP5YKgp39rpayPjC5ypHtsm9ygEHc/A9tumC4/RB1V8FJctyrSaQr+9PnHTM/C+ZyK5Wz5F1sK45SSWBK++LyY90W9Dmbltk8ibj1g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:57 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 21/26] vfio-user: dma map/unmap operations
Date: Wed,  8 Jan 2025 11:50:27 +0000
Message-Id: <20250108115032.1677686-22-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: c26e2a57-72b9-4b20-1580-08dd2fdb2213
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DcM8BtIQ/5gvntMlFRpKsIa+7iR9L9RL+djhA6RwYbfH/Wep9ZKu3vnVkMB5?=
 =?us-ascii?Q?alowkqLjj9OHB+cwQ8DX1zLlM1FB1r5qcUVBI/QmQMpW38lCxBmQkz2v0iUa?=
 =?us-ascii?Q?1RIlsa8d95gzViPKkZbZtmq18AZXZHuCMW7Pii6XfvrULv0uwainlM8vVhri?=
 =?us-ascii?Q?UG8YOifaIYEFY/TngC/OmbBf3Q0DwTrQN1ocpvefclAED2agC6u6yVfl7x8M?=
 =?us-ascii?Q?vvL6c7VK3o9kZiT+twXn5FkgoPuxZ5rIQH93MLgl0/pi2/mnYV39sUflbNXm?=
 =?us-ascii?Q?sBTYOSWkIH+wojQRQHwGKVuFlwhGL3piMShFn1LD1SwQ3AbDVHPjtdtdh/v8?=
 =?us-ascii?Q?DR65gWGcHoGLddYDFbQQxDbrPkIERWkreoL0te+sExjDksl722U9Goh+LvrE?=
 =?us-ascii?Q?Zgb+W4saPiLcGiGVvJv7Va36Vka9hJ7grNvPEUyRp8CScXcEIeftspl2VIFM?=
 =?us-ascii?Q?cxsZjrzDaoF4jFoR/OLII8PFeTgHh3yOhtbhdtaaO9QJSttT7TgwHeKWELhI?=
 =?us-ascii?Q?5kgLvgReY6qRUhveoKHvSJWb5Cg1Yj5Yz+WdYUFTNrzHF419fUmGKwWJI3Nk?=
 =?us-ascii?Q?O/1KFAO6jMOrJD/dWdQO/LqZZkkq/A6ig0WkUuvBYk++YpzXIrc+JYlNF/XG?=
 =?us-ascii?Q?xWniU4M0e31WKp0Lv6SlQNDGA2H6eANj0ylBKvNbI/OMNXpO2jbO8pHp/vuJ?=
 =?us-ascii?Q?pSV1VC8amdX3E/Mqz2VINnulPQPB/hPZ7iENFsQlIMv7Kc3nbVX8oWY3GiUA?=
 =?us-ascii?Q?kVHu29cMHClvXio5+H2z+6E0vbLaDIiKPMbTPiK9r0+aykLq7Rmrjmnc/A//?=
 =?us-ascii?Q?j7WkMwl6eoSilmc2eOLyTj8uPM/oM3wocYYk+mg8nD84JG+sDuUatZhOtj/y?=
 =?us-ascii?Q?ekMnUrRCHOl1GnVsPGAB3re8wcYBzxe8/tcwjmfDBRoS/+z+nqj6uxdzRhQ6?=
 =?us-ascii?Q?Gumt5ei92Zlip8cTgPYZGnTODUtzCDcw24qvB9dc/OYG/yM8EraohKF2BImo?=
 =?us-ascii?Q?T+ryts1qcTnNcxnq+x7eGVTf9tfyGOgqZf6jc9jNG/pHRiW1nMt8YUI4HnIr?=
 =?us-ascii?Q?Dj567ZmxkkZm5zJL0XWKukoxUYJdjcdpoYHqCeZTTmosEro1dwwlB1ulF2uW?=
 =?us-ascii?Q?z8Cty2/SsU43E7eh3tCgw4y+Jk6XzzR2W/qi1UACgDlIvqLdKe89AeS8Gjg+?=
 =?us-ascii?Q?byUcSE1YYOYJFrxj+Abf+1wSvXV8ny/5dtn+8qjS1NaSbjwP0H3TQgwxGXjy?=
 =?us-ascii?Q?PgO2gVC2FMUfisY6nzdg29U4V5ZHmB2h+dmLjF3a1FxqfRkrOUXTaGqlwbpE?=
 =?us-ascii?Q?BaeQxa52LA/uMGOOD2TNTSNyGoYyxuOxi2nQuX3uS5xoFkqzfE3qSyJxnwe8?=
 =?us-ascii?Q?2yZ8Mr9cJnLKd+BifGxkTpXY2z/Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KWH5esiTqhOxsUmuNQhF/Wc6D9pDDbGSS6B+CaX5XBEOYxfQ7zXfSTwvHhb?=
 =?us-ascii?Q?x3CjfWcj5synqtuUUJ5JKVvihEMxk3shw3p97RjHhqPSyjD2vNTw8YwyNQav?=
 =?us-ascii?Q?lCJ3JCN6h10Lf3KvWZRajhEeZLRgXmhqdvWYRNmYnwUJeX7aKvtelJp2vpia?=
 =?us-ascii?Q?KV6hHMdIpHaBJ2upLVorFhb/coERulxiyQIx97SmffIQS6h2E5Sie8WOEQ4T?=
 =?us-ascii?Q?Yw2K3eEt2A3jy4s9KrazLeFvgqor7G/SAqgJbLsPGfhPL6sLfzi3YlnebwxN?=
 =?us-ascii?Q?RzwpiAz2UWA4Q0HmYdHgWITpAJ7Sz42g8gzwgbYzPVU7+Fb4WrTq0Y2i6c3O?=
 =?us-ascii?Q?2L/ijZd7HldUkw2IFHz4KIFM7E6Hqbj1x7GBU1C5RllDXti6Wb0TY3bfvvwv?=
 =?us-ascii?Q?g4/9G1qCaDpeCUUsIr/9/GHyEs8HTXsUFrumieAw9tNlzYQxaPKFlnQr7kzI?=
 =?us-ascii?Q?0vWQzlFdgQg84h6/YUZxEqgnhU9ccwrwYkJrFCHVVaqk74Yu90Ob3WygXAVp?=
 =?us-ascii?Q?B0u8Q9sCy4csi5tKHTg8Bu6DMUbxUHIt9uqB4A5rD1k+CWevsk0BXNxUKW2R?=
 =?us-ascii?Q?6q6iz/DMWi4tlc9im+bAwUjMsyGkSg0SdREH4ZbBGU/2WkYWJe+cGhxR+hos?=
 =?us-ascii?Q?TSTebHqZXwrYgSbamJedw77h1pW/6xwHKzIzAp6KgUiLZ8+aXX7wJo4yZcZ9?=
 =?us-ascii?Q?oPdzj1chxTdCR8EXGpiR+O+F/VjjkWhrnPLjYC5ebqgKz5OKvdtbt9uCT0Ip?=
 =?us-ascii?Q?xheEEweG2+pXr52rPtgmKEf6qsjR94215B98pkzWXnI9ldWv8mg1ZRrps1wL?=
 =?us-ascii?Q?dXU2AscWoIzSLfLnVKmw9rmVTeYUCBVD/QVC9ZouLVZq81DXvHYuHUMmCjVS?=
 =?us-ascii?Q?dGCPk3CBDfBAOy4QSKYmdSFz/tqtn1oObPEbWwqPsUx9Rsh8tbSdZMldfqtU?=
 =?us-ascii?Q?MIOHjQc5riWjGkog/qwomY72bilrH066eU6bFp/BMK/rpUn/D4bSVLwylhrT?=
 =?us-ascii?Q?NAtKPkzYCnQo+9hlAvxztiHJACGQQ+XjLL2/PSzIorRm2A+6QDR0joXCB2WJ?=
 =?us-ascii?Q?t+lpwPSfv7t8QUPHprePIz4gIb2Vv+XHcPktpcRTAWd3GCmhJjLVVAFWOgrR?=
 =?us-ascii?Q?nX6pYrFwIpgqs5k2Z347lar3OQ+uwKsOqvhX85OwanKlqcChkJjlIcWXuIUx?=
 =?us-ascii?Q?BluPlvVpM6O1hIXXBrCmFpvMs55XBPMNi2rplSin1boGG0xJcu749G9Raw/W?=
 =?us-ascii?Q?r3ieKYhv03pcQ4bAAyL35yumRQZepuM/AeBr/XXUGIZiNCfyy8FvNeXTgbwI?=
 =?us-ascii?Q?7KNMtAFusStE/sCl9XXwpIF6b+NOfVss9pnSSa2oqEqkSMUevlNbCZONpRvp?=
 =?us-ascii?Q?yl7cNmBuGm/q9g9o2r5lhayewUfo0Yb+rYDccppqSyFW+5HkgQGIkZ8MBlnL?=
 =?us-ascii?Q?Yka3vaH34iZ1CP6D/SJHDN1uGaJTV3Ow88mMA2qovhdKUhDAspdrXQITwjBU?=
 =?us-ascii?Q?sL4X+33BDPCsxkTN/XBRpCEZnyTXXh9mduZqCdwhnxkeeJQ+TdW1DexOd0FB?=
 =?us-ascii?Q?3lvINtV/SadGf2nSturQhu+p1S63t4GdO6GC/E/N?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26e2a57-72b9-4b20-1580-08dd2fdb2213
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:57.5093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQKosa6pI77wqlcww6S00WzbJZNUqIGMyZ3yL6mBoMZuEcYnAS8kPyqn/5kWeKjd5GCbPPwuiSqT7b2TYPm4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=A6aWP7WG c=1 sm=1 tr=0 ts=677e6758 cx=c_pps
 a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=RQZ_2NmkAAAA:8 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=RV09HK1Kih191idQr7QA:9
 a=46pEW5UW3zrkaSsnLxuo:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: nYNoub3dj6OB66HmvxMUN4ZJFDGgHpQJ
X-Proofpoint-ORIG-GUID: nYNoub3dj6OB66HmvxMUN4ZJFDGgHpQJ
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

From: John Levon <levon@movementarian.org>

Implement DMA map/unmap for the vfio-user container.

Add ability to do async operations during memory transactions.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/trace-events     |   4 ++
 hw/vfio/user-container.c | 107 ++++++++++++++++++++++++++++++++++++++-
 hw/vfio/user-protocol.h  |  32 ++++++++++++
 hw/vfio/user.c           |  89 ++++++++++++++++++++++++++++----
 hw/vfio/user.h           |  10 ++++
 5 files changed, 230 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index eceaa0c0fd..e3a7f82550 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -192,3 +192,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# user-container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
index 99839edeed..77ffec9561 100644
--- a/hw/vfio/user-container.c
+++ b/hw/vfio/user-container.c
@@ -23,18 +23,119 @@
 #include "qapi/error.h"
 #include "pci.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, int flags)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = flags;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL, 0);
+        return 0;
+    }
+
+    vfio_user_send_wait(container->proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+
+    g_free(msgp);
+    return 0;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    VFIOUserProxy *proxy = container->proxy;
+    int fd = memory_region_get_fd(mrp);
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking or dropping BQL.
+     * They're later waited for in vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+        vfio_user_send_nowait(proxy, &msgp->hdr, fds, 0);
+        ret = 0;
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+        vfio_user_send_wait(proxy, &msgp->hdr, fds, 0);
+        ret = (msgp->hdr.flags & VFIO_USER_ERROR) ? -msgp->hdr.error_reply : 0;
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -234,6 +335,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_attach_device;
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 87e43ddc72..9b569156fa 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -115,6 +115,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -178,4 +203,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 4b1549cf8e..ef644848ed 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -47,7 +47,6 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -60,10 +59,6 @@ static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                  VFIOUserFDs *fds);
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize);
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -155,7 +150,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -658,8 +653,38 @@ static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     }
 }
 
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize)
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ */
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_nowait on async message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+        return;
+    }
+
+    proxy->last_nowait = msg;
+}
+
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -696,6 +721,50 @@ static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -830,8 +899,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy);
 }
 
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags)
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags)
 {
     static uint16_t next_id;
 
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index 9039e96069..31d2c5abd9 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -75,6 +75,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -106,4 +107,13 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info);
 
+VFIOUserFDs *vfio_user_getfds(int numfds);
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize);
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize);
+
 #endif /* VFIO_USER_H */
-- 
2.34.1


