Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B51E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdp-0006ZJ-N6; Wed, 08 Jan 2025 06:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdS-0006TC-VE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:07 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdN-0002Gg-FB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:05 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085doxf029507;
 Wed, 8 Jan 2025 03:54:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=yEQ+2mZvRFUSxRFvKhMU6t4jWNStRpwNrcDO0tY+M
 3A=; b=R3b1Y4ImIs6RaqA7BxNmOtA0Boc+kP2zp5qVp7TIJUGCMcCCG37550QD4
 S5iLJTelGeq6qN8fsJrvlXWv1HP/6ulQJ8jWc/LhxNCo9CrZ2NcdUVgwqscVkrMT
 v0uUubNa68AT43S64PPPXJ5rLRXn4A+jpySfDi024UR/pBiGyYgwApEhdjIN8Xo6
 N9PVKliTBn3sA0Tx+5jyyD0cTJx9cs+1gS5LuLOgLAdZJzNDjI+Z44I0FvHIJLQA
 LeHuB8DYWu2rWoWHuIuZ2oYcLcRbOD0LtLLVEb3eQEfghuYVhKCD9EEAKWtQ2YQ+
 h3htmpAKUT7Bbf7HlN+C65AkXjJXg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y26xqhax-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDQFD4vDFV9aTYoh7nV95SoFCz3jvnxXHJoKdDqTsYW/bgwYtKR3RXyW5RKp2KtU4WjeHgmfym7Ox1bniANTsifvv4+BOT/rCt/qpJEvYpLu6lnHuc3EytxUXqXRZPFfNT+PY43qmhfDDsCi33o5iTeq8nnuJ87eToBsz8jGENOJCf7GxXjoG0fTKjtpi5C8mLNUaBxbJRULUK6b943FD1vDncL5waQC9EJHG2AzUjN6m+sknPxOkhBq2jv77zlLHbsyYuwx4lEC0MmR4eqHBmRtEAvPjvhKNoPvI42ATff7H4Neh3lDonzLZwRA9anjRNbzfDWKZp9FlEGHsfdGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEQ+2mZvRFUSxRFvKhMU6t4jWNStRpwNrcDO0tY+M3A=;
 b=nQt07Jyzj3jb+dq71OrbeMuJ3zYV1QnrJFc656nEG9Kn2AWffbvmbbA80B7fCdk614HMg+gXei4Ln3N9dqJ8LJLia9uXWICM4MZjeU585pr7W4Nw84qfCGFj7HCLVtV69I2UVldUjSRK56fKZ/PsgXDvUAwBs90F4QyI0SPQLLAnrH34sQ3PenIFOgP1XdqpLUqlJoZXz/WKKF3SNwR2fGF+BHPGp3raTjw8B5Zmm9HLukAVODs66W/zWZUtoD3lfiUvMu5qhlfRZG5XlTUP+AByJ8m61g+nletoh/0fh7PoaIsCHM8pH844Zc8AbwIBOWKFG3eMlnKiDjaUv6Ivxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEQ+2mZvRFUSxRFvKhMU6t4jWNStRpwNrcDO0tY+M3A=;
 b=ILLszTr5+7jbaX+GYoroDQ3zha9jf9lXvIcXlMpjzlFu8x2anBhh84NoqiQLPp8hQ/Zc1rq56GEHxhMwkkvtoHZqMe4WNJf7XKAj579Yjdhe0pO11r988efFjEgxqWzDfMjvLcCRjWmHQaFR/hkrwx+Cg6HSuKRtkYCnQbBg/DWfDf1lE0yxFtd0VtOKqWcgnfcyRbG78FH1aQJ5Wjfc6b1kQWsUmvrjDuiF2pDdKM4GXynjuAqAJcHMsjNIt2uAIyVM781QOEu1qkU7PgEp69N+mVwj7VHNm/lrAmO6N0/B4Fd+FuJrl4qGqcb/qx7jNzuzrpaP2hDZ26PvM/tYCQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:53 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:53 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 18/26] vfio-user: get and set IRQs
Date: Wed,  8 Jan 2025 11:50:24 +0000
Message-Id: <20250108115032.1677686-19-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14677b4a-63fe-4e63-1991-08dd2fdb1fae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DPe3EYG6tiX5pmKTgLg4Yxpdw2VfDevf3ACBLQZMsCX1YFhKoR0hLNbTw8KH?=
 =?us-ascii?Q?GwxNsu/K1E11nQwQz2M4ryQTekKwxWlV+W7t9kyR43C4xIF7kOp5kTRmeXPz?=
 =?us-ascii?Q?wYWaVVD6ncZbQxqcuXUfCT2eFg0BUS06afr97cBxt5yC73s8DvzvukHpzM+r?=
 =?us-ascii?Q?pG1LVGV6CH4rAiWY/h8HhpaYwmwBHTGjDgnxqJ5EPCFuvh8bBF4pP2cCsFZR?=
 =?us-ascii?Q?0tvU5uHBcwVmVqnlZU+lx4OdQ30dmPcu5VJHpRUEMnJwXZj7KnVWadxlXv5r?=
 =?us-ascii?Q?eB2yemUJ7EgGXM/AMCYghD39S/8HlK/4CzWu5oqWEh9NYKUSW0q2/fZBGg4/?=
 =?us-ascii?Q?2l2I+LHB4aeUM635QrYdXU1fIkGSJKFDRoUu7Abkvro7hswHsZsZQchgT9i6?=
 =?us-ascii?Q?z8tClx3ntfDwF8Ok6YcdH/cHhYRSHANmpqu0bDgb5u7obuysRv5BEyq1lv8i?=
 =?us-ascii?Q?baOEJko6o3fCQuU4iuhYCy1zdD1GOSyikaBUw8emEVniIgAvWm3tPJbip3LK?=
 =?us-ascii?Q?0MdFDohrIe0oaRUb09ow08WgPL7H21EYIIMpF4IbvqTwmq3bk/Ov7SUTVzpE?=
 =?us-ascii?Q?o1MQzF3JE83TLeUpLsI+t90U1XcI+jWb1vyj5EZvM43uh4p0tncIZOo/cNUx?=
 =?us-ascii?Q?ZskC2HSQQ1sVckb+jnkNxJ8s7WjhzTLVFZEt94ni+Od+6o4MeOCHs84WenSy?=
 =?us-ascii?Q?XpVOTZw93sFvpkYSfg/EbdCeZDDUEEazWTu1KElrKmS6y6kz46BwIO04RqGL?=
 =?us-ascii?Q?JVMZQqp7zuKVPu3FQQqJ0HEY7qpUl3L1N3LbIRYCrb2YNFMySxqqCOq6rbom?=
 =?us-ascii?Q?1/fT37+e0q0LL0tTeuG5oCZVECRUn6UgLLzdTWThTkyZXpv/YthOab3XJk9z?=
 =?us-ascii?Q?uR16HSQA0FlUy872h48YA3kA+fyKjYsXgmvS4c47S+zOtwRXg+jPz23XTBUj?=
 =?us-ascii?Q?6Naa0DRZofIpDFXEpa88si/h6j60V1Laf1ngBhes1gfwQapwIVLRfmn7ZBAA?=
 =?us-ascii?Q?C9BbxioR7vPW2p1DEBr/EYudHxHm8Fy4YphCAzgsHT0xGt4L1zV6LOfjUrx/?=
 =?us-ascii?Q?ahbcD2b48TX5Hw1YhOJwgBb+FW1OMExUxiPu/ctagj5GatkyI1XtOXZhvyNd?=
 =?us-ascii?Q?IicgZs0zktkjTSd/kTW9TWwiKpPUaH4g37eN0utLiXpiQ1bfnwvvaw/jLlEO?=
 =?us-ascii?Q?WT2mX7IbPK1dAySvRwWRReNmTw8dhdbyuR3qd9PyfeEQn/auqDrySjN3DUch?=
 =?us-ascii?Q?QizgGYbrOkxeLyjnn9sWMj+qL9qqdGPv9yMcrGS2+QRD2T/E82gpchj5zleL?=
 =?us-ascii?Q?dgNjQoNQyIaG4nclClbIePK+djXIRF1HOD65emKKS3euhIUi8jjiH1+R8VDH?=
 =?us-ascii?Q?23wRLnR+QMPAsoxMxiArZiVAPIC1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQNtgk5Hfl+I/yuT9sukzJtNN3qS4uQciAslSe08ClthBtTg7qtOxlMDU9E+?=
 =?us-ascii?Q?vgS4wcTbt1mB49N3HQoCFGAZVz2MZ1bRFJe9QydzpNr1UAGIwM7IyH/XGj8S?=
 =?us-ascii?Q?He2yOd7ZErlumtTtS36pTRM5nU9RT4pvyYn5pg2FCRIqJpyCYtHC5gZPIWU3?=
 =?us-ascii?Q?OEe5h1hxdHwVkJF/qcR9QxKCznzeShOn8RE2FToDSxaS1Hct9oCqiBMhrNHt?=
 =?us-ascii?Q?I6Pp4K7zBlZLQbbbSj3VQtH9ADwl7pzih3KunmnHbKqLMQhNJ7v1xO+w4rC3?=
 =?us-ascii?Q?zol0jcM3gZD+mnnr3w2t98JqzwqN6Mf+qfG9jzKnp7eS+WE+nXI0nIysxGWI?=
 =?us-ascii?Q?dwPA3tQ2hQ/XrPwBPhz4TmoMUFs9c3WKFBrMRXjo1EZGvem8bJhH57i6HoiZ?=
 =?us-ascii?Q?HJhV6nBVCnNYN7Ygu1KJTp1kHzo6jBVprdSygfCrbBnV+x/Tl1C8yAwGuKm7?=
 =?us-ascii?Q?cS2zb+SIf8Xn2L7pPWmj0rInvg7rcbs8dvUpeMieiuFI6/i88XsHZO0dJDjd?=
 =?us-ascii?Q?gNwsOanTJD8MYuEgPqv6S6KIuQGjm5TXehA2/DR2wTX8Ew6CbPJe3TSscJVh?=
 =?us-ascii?Q?Gvl/bNwSSaFopJbnf2DnrEyXbNmcEwd1sKUJQn50U0r+Lll2d7HeA+4F5UEK?=
 =?us-ascii?Q?PCH4iqajB2rryWO/a2tN4pEJiQfIHFnw0I2WPgYGAMgK8HPD/3gBc5Feq+gZ?=
 =?us-ascii?Q?VTrsOX5G1mKGjZytdxgTEPyA7qggFOeZoJNTe3UT3eXuzRbGRw2+boYwn5iv?=
 =?us-ascii?Q?lknNyZ3d87z1IITWLncQLL3CGqBZTExBNyXl07n85qefxUm5dSUnp1SNC/Mn?=
 =?us-ascii?Q?M9pLO+OQO4J2mZkqWpZSsHAM68N8TgjPuLxPVqR0j/EvZ6UJ5yEOFxReVCBF?=
 =?us-ascii?Q?U3LNNMmWgIn7ixi6nt/83q17VLsYLeFyal7ztdxrlIuNTOa5jcNIKqgj15ho?=
 =?us-ascii?Q?AY+5O/CZ3y70bo9zwKQSg+kK9NZ6fXOA1fX2ZgwpODJtKNVqXhraq3S60FQ9?=
 =?us-ascii?Q?loOYKqhLl3uFHNA3DR8qlwpSzOX9htGCJdV0yDG7SiaeQL0uHRWdzkRVUZ1W?=
 =?us-ascii?Q?pU0KmwJotr72Zzpz6Lebj1XwMc7lI+gFdmIZnK+HBMBOg6vXJnvYT3CI2cwV?=
 =?us-ascii?Q?ui4MaF6lJDc9kninThDBrqaZt23ht+P6djlM0nFBO1UWRHCHG+sxmMYzldBa?=
 =?us-ascii?Q?p7QzihWJmdd+KNHNNLcY+tlzD8TwRnDkFULfFJd1Zf+flAH+ioSaOohvTfSo?=
 =?us-ascii?Q?fnp4IM/XU0QRw5e3ibcXPMa9ey8+l344TBfybbQsqXWAmFAcov1ab9QneWtt?=
 =?us-ascii?Q?G19wFWlUFanwin0H2HqvuFmrWwAXzt3IQ9PX/4HobV3K0MdUziPMOzM4wsp5?=
 =?us-ascii?Q?wdS+85VQ63nQovGdHu7p/NqsQvNGKGNmIHZrXnuoiprf3aH8ZJuSBD2Nbb10?=
 =?us-ascii?Q?h424wKt9hG9U0BguQinvsF+gEIHsLyzTE+EnGNScwG5wx3zsFgUWGsirf10n?=
 =?us-ascii?Q?irfIbCz2oi2J7ULU7ovD7p7ge+oQ5zaiT9Up0QbV2L4BEgEpip4wpLbbHbFC?=
 =?us-ascii?Q?wzn4EnZ855RT5GU7bEid6FQ7JlkuAZm2dwTtlyrZ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14677b4a-63fe-4e63-1991-08dd2fdb1fae
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:53.3818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzggMoS0VMv9tEL+8NMwp0S6E51QnRBWcjdTC3Mzk8vZlBIK4BvuTpxM2CvxJ7zaLahEAAYeibJ5JNtz4VF6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=Z/cWHGRA c=1 sm=1 tr=0 ts=677e6757 cx=c_pps
 a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=eeJ3FIb8qCAeb1asaDIA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: oIYaQVakPDNn9rHFjawt0zOvippVLi1y
X-Proofpoint-ORIG-GUID: oIYaQVakPDNn9rHFjawt0zOvippVLi1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c           |   3 +-
 hw/vfio/trace-events    |   2 +
 hw/vfio/user-protocol.h |  25 +++++++
 hw/vfio/user.c          | 140 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index cd7bff2b4c..57ed6f5363 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -772,7 +772,8 @@ retry:
     ret = vfio_enable_vectors(vdev, false);
     if (ret) {
         if (ret < 0) {
-            error_report("vfio: Error: Failed to setup MSI fds: %m");
+            error_report("vfio: Error: Failed to setup MSI fds: %s",
+                         strerror(-ret));
         } else {
             error_report("vfio: Error: Failed to enable %d "
                          "MSI vectors, retry with %d", vdev->nr_vectors, ret);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index da8af45ee9..eceaa0c0fd 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -190,3 +190,5 @@ vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d m
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 6987435e96..48dd475ab3 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -139,6 +139,31 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_IRQ_INFO
+ * imported from struct vfio_irq_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t count;
+} VFIOUserIRQInfo;
+
+/*
+ * VFIO_USER_DEVICE_SET_IRQS
+ * imported from struct vfio_irq_set
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t start;
+    uint32_t count;
+} VFIOUserIRQSet;
+
 /*
  * VFIO_USER_REGION_READ
  * VFIO_USER_REGION_WRITE
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 118314b363..be2fba522d 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -1179,6 +1179,122 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     return 0;
 }
 
+static int vfio_user_get_irq_info(VFIOUserProxy *proxy,
+                                  struct vfio_irq_info *info)
+{
+    VFIOUserIRQInfo msg;
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_IRQ_INFO,
+                          sizeof(msg), 0);
+    msg.argsz = info->argsz;
+    msg.index = info->index;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_irq_info(msg.index, msg.flags, msg.count);
+
+    memcpy(info, &msg.argsz, sizeof(*info));
+    return 0;
+}
+
+static int irq_howmany(int *fdp, uint32_t cur, uint32_t max)
+{
+    int n = 0;
+
+    if (fdp[cur] != -1) {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] != -1);
+    } else {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] == -1);
+    }
+
+    return n;
+}
+
+static int vfio_user_set_irqs(VFIOUserProxy *proxy, struct vfio_irq_set *irq)
+{
+    g_autofree VFIOUserIRQSet *msgp = NULL;
+    uint32_t size, nfds, send_fds, sent_fds, max;
+
+    if (irq->argsz < sizeof(*irq)) {
+        error_printf("vfio_user_set_irqs argsz too small\n");
+        return -EINVAL;
+    }
+
+    /*
+     * Handle simple case
+     */
+    if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) == 0) {
+        size = sizeof(VFIOUserHdr) + irq->argsz;
+        msgp = g_malloc0(size);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size, 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start;
+        msgp->count = irq->count;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+
+        return 0;
+    }
+
+    /*
+     * Calculate the number of FDs to send
+     * and adjust argsz
+     */
+    nfds = (irq->argsz - sizeof(*irq)) / sizeof(int);
+    irq->argsz = sizeof(*irq);
+    msgp = g_malloc0(sizeof(*msgp));
+    /*
+     * Send in chunks if over max_send_fds
+     */
+    for (sent_fds = 0; nfds > sent_fds; sent_fds += send_fds) {
+        VFIOUserFDs *arg_fds, loop_fds;
+
+        /* must send all valid FDs or all invalid FDs in single msg */
+        max = nfds - sent_fds;
+        if (max > proxy->max_send_fds) {
+            max = proxy->max_send_fds;
+        }
+        send_fds = irq_howmany((int *)irq->data, sent_fds, max);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS,
+                              sizeof(*msgp), 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start + sent_fds;
+        msgp->count = send_fds;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        loop_fds.send_fds = send_fds;
+        loop_fds.recv_fds = 0;
+        loop_fds.fds = (int *)irq->data + sent_fds;
+        arg_fds = loop_fds.fds[0] != -1 ? &loop_fds : NULL;
+
+        vfio_user_send_wait(proxy, &msgp->hdr, arg_fds, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+    }
+
+    return 0;
+}
+
 static int vfio_user_region_read(VFIOUserProxy *proxy, uint8_t index,
                                  off_t offset, uint32_t count, void *data)
 {
@@ -1275,6 +1391,28 @@ static int vfio_user_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_io_get_irq_info(VFIODevice *vbasedev,
+                                     struct vfio_irq_info *irq)
+{
+    int ret;
+
+    ret = vfio_user_get_irq_info(vbasedev->proxy, irq);
+    if (ret) {
+        return ret;
+    }
+
+    if (irq->index > vbasedev->num_irqs) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int vfio_user_io_set_irqs(VFIODevice *vbasedev,
+                                 struct vfio_irq_set *irqs)
+{
+    return vfio_user_set_irqs(vbasedev->proxy, irqs);
+}
+
 static int vfio_user_io_region_read(VFIODevice *vbasedev, uint8_t index,
                                     off_t off, uint32_t size, void *data)
 {
@@ -1291,6 +1429,8 @@ static int vfio_user_io_region_write(VFIODevice *vbasedev, uint8_t index,
 
 VFIODeviceIO vfio_dev_io_sock = {
     .get_region_info = vfio_user_io_get_region_info,
+    .get_irq_info = vfio_user_io_get_irq_info,
+    .set_irqs = vfio_user_io_set_irqs,
     .region_read = vfio_user_io_region_read,
     .region_write = vfio_user_io_region_write,
 };
-- 
2.34.1


