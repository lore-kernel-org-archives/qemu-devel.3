Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9949CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfk-0001u1-Ix; Fri, 22 Aug 2025 08:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfX-0001kQ-8v
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfQ-0000pO-2s
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:54 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7LJFn667851; Fri, 22 Aug 2025 05:14:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=w7GnCI21r7uxu2sKvURTGrcYYdCL4Fz43w2UDIWpO
 TQ=; b=JI1fHgioK1c8TdUaOakCpS+EjbrofChUPuwJ842c1TbbwwGe/0X8XS52y
 M+jWMjwF/NnJq2WJok2D4Q9+4zj6tmMOIl41jmS4YhsNvsxhL83xhpqqTKyDHvVT
 NOWXOGz+pF8uPPCNy65haiR02IhFNRlHDuKXSSsdXsIv+QIIhpZIM1TRobC/1hB8
 xXuTpQrR/veXK2b5qRyiR5zZcEfFPgi3skg5htlEVZV1lTGkzh7oCAeNbdcSCF3r
 Euu7rq0yiFR0IPs0UqfY5eG0rbe/IrJQxlqNoK8VCaZLqR91wj0ViFks7opg8ilv
 MpS7+bcPfUqh0+XcLUY3Qbe373zbg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye8qef9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJX1hnW0Rs8eJfOf0Ky1FFpnbCjRFdOwWSfSitH9BWnwpGJyYryB/F5763+GaJt9cAF9LIdKBC+UdjIGnPZoxL1G8SBJrgGncdBQp72hBH0F+itY1mXtecuMCy0oth4z5zKcCHbMEhvNyPKvxFAdWFHO+Z7/8nk6F/YderwntaR8Xaf6IC7Xpuyvy1/sFPgy72Ju88hynohyy1hdj5blrf4xVB1D4VjtP/397Ryx2pPGCsVMpw/OP3xPput0WmW0X/VXUsq8/EsCFOkqlXIHEGISVV4P4BdZZ/JMYwYC5J8Kk/Hy4xGkNzqc0gxLTVixCiyBALZw97DrumnmmWeYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7GnCI21r7uxu2sKvURTGrcYYdCL4Fz43w2UDIWpOTQ=;
 b=hQ/sQyPOyCT4R9ZF9OYFkVNpYwxWzPSooWwKyJz9OyoMncFyowJOooVd9K28OAP2brm9qZ0wq6gwFhXHo2nvBlRELI1Zk0PIQGdg9P+9yPEFV9SN5acWkPPJvX/NVS5e4+da9LqwLzBaYQS0vR0L+N+widA9B8CGiZLb+RDcfCricuE/QZdBm8q/a20wFuD9MyFMNqDOR78Oh0IBke0BH9T9XDk2vnEANhsVlk3h3tNoaeoe2swrF7S4eDNwc5P97pZmVt96ExQz9Q85mJCkHpDw0RDlgpIc6IgXBSGwpzMEaE8ZyWELZdp80araNpjqnbfetvlcmmZYKk3XRxw4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7GnCI21r7uxu2sKvURTGrcYYdCL4Fz43w2UDIWpOTQ=;
 b=qiavpgTFFVJrhVeV1nyvUzbosWbFT56pLrbR2/dxrR3Gyfs7U5YPiPGiM+jooJ0CBGUh7ndfGF/TI4Qk2bcnzu26NZfmCvTYm5wTu0XLLW/D4VIp79MWIRU6M+3lm2kXXwYA0Y0EVB5YocDaxVQyTDZmRT1Eim75Oji5aVW7hsbn2pEBuZdbw9BWbTJ/dQcHRVMH31zCFstYwsIhq7bgVrqvl8Ad6jZ2t2UavR9eSQQFUaqfzBe+5D9v7FNGykxvjz1Nbeo99ncsqV1prztA0yHM7OVSGojPTF9A5PY2dghE5v1W5RXoxcALuwopu2H2gcrzoI4PtZHuGfcX/zCRDA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:42 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 16/19] hw/i386: move isapc machine to separate isapc.c file
Date: Fri, 22 Aug 2025 13:12:02 +0100
Message-ID: <20250822121342.894223-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0022.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: bcff1270-0a46-42ae-5874-08dde1757958
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?svNGzYADkq8/93LqCt6wKjyAhd108CyN7PAp+ycr8/uAwt4rJszRfsbeAl6P?=
 =?us-ascii?Q?LrGdDUJMFYgkcGunqCnQFYB8TBDCLu9QfednZYc4FBxh83C0KbcaR9JNiYv4?=
 =?us-ascii?Q?QFEHaFQ81rjduyzoycJ7BUXyID/+10zhnisqRCC+FnrMpSwqwYKU1s9ESrVK?=
 =?us-ascii?Q?T+Yemyp649D62koCwM2MtQ77csUwIkV+IWZqQnnSFQaW0icPwwSSwUr/lzI/?=
 =?us-ascii?Q?XOgdf4m0dUX9aQpAzZ4v46DdGYBIs6wA3UoivJEvybCv5S/ejEoEdlIY6edb?=
 =?us-ascii?Q?RVAyiAy3SfoZiGdhYbad0T3h2ShXXVRQfxSQ1EUvgX8TM5utPe1eR3v9P0j9?=
 =?us-ascii?Q?NDeoWziXT7Gl5+D8WHktCnzXr97xy8yCSfQ+5U6ew+Z61LvxTbRY0qJfjfZF?=
 =?us-ascii?Q?gdJxVNsUq4Q4y1cwyXfZ6P9XPgW7DPQT/xK8Cv0h0fms3tsPz/I5JcYW5WET?=
 =?us-ascii?Q?Kq1qH3JsPvubqZboXbTMcAqM3XTMSH1nnG1sBWq55Zz4L/tLRNRFqNLeBYql?=
 =?us-ascii?Q?QH0EB6Z6zqW92TxOLncggJyMppfUbf8hNQ9o2sukn7OCiinWv9jAOUaj2P/K?=
 =?us-ascii?Q?92HCsLy6f/AcpNTGqUiHOeidZQ4y+HQ7/t+q9JbymDOq1d9goARIdlMBboS4?=
 =?us-ascii?Q?UuEavNUla3R12zC8uajBLkmkZ0uniu9c/Xmx/G2UKqRwTl8xShKgAqk/8jPS?=
 =?us-ascii?Q?8x6QXfD8rvyrK0q0v7XlKtGiCA0826/r9Yj9e2bu9QwsApJ9FXwAw1WEBmnH?=
 =?us-ascii?Q?XVkt+09nFqObLbLAZIqpyPDk5ZqUHp6bYw1nX+ZdI5eaap3s6JkGJUGlQQns?=
 =?us-ascii?Q?vmbTCNMpRLQattz3wN5IiOWsfo84tRVBrtzPDHnw5wDk3KTm94nXtXCN2Ygi?=
 =?us-ascii?Q?aMPwL4QMJQm3cYOQ98ZSOBrwYNpAKfdsKqv7J7t4N2GovxmrTNSSq8emU/fT?=
 =?us-ascii?Q?SMtIBMPhjRXJlJCRfHxQdqxlag5Y3td5jqaVmHV8DiOHDZ8yKMwdrj6GWVMl?=
 =?us-ascii?Q?R3k2SADqff7NV/UsMnFXFY8PRBgxNn9JQxhBgaqq+PIHNcvPXLssaCkc1V/x?=
 =?us-ascii?Q?UvZaAUUMF1lt6pZ65Ann5WMvL+xkhRL3241/wuHAH2dJX4K0Ig1ByIr8kYK5?=
 =?us-ascii?Q?ZzLp9PzudEtMt1OO/INTO2puvP+RkiHdbTzy+mnKvcp1z5stgV3UVrWitcuM?=
 =?us-ascii?Q?SLOaW//vvptqljippw8ejTyCK8+qfvNRcxAUCi7mlWBjbdG7cJ9ANi0D+d7y?=
 =?us-ascii?Q?4NnWxpqZIdAM1u8EnTzUP+RsatraFiWneZa/Tr2obOLKJrP2A6cqQqyFwPL1?=
 =?us-ascii?Q?8B5qy+/iN/78Ijx8/nS8i5wDhtuSFN49qnOKf1mnMDHWzFDwgkxl9V/QZgix?=
 =?us-ascii?Q?PdcXRbPJTbc4yDt9WWk6rjWQPw+VfV9PRknaYVr90VDejv1VRcTjm8BIUMsZ?=
 =?us-ascii?Q?cGipFDRR188=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c5nYZ7SmL09Low3CI5mIyiLHxzU+FNwzX26rosZDnfK1Uv0EuP1QEkdRhU8K?=
 =?us-ascii?Q?cArd5K7Y6NEpGWe+OefeTus8G1Cz956hUPny1r3vFVYz1C3oi60xnQ3R+xnc?=
 =?us-ascii?Q?y1SipnLF3dPpPqlLLl73OeWP+mo924PJWsG4R3cHrNwWyj6WEwTVahFYT8ip?=
 =?us-ascii?Q?d7Hpk45stljWoJwNVuAWBqj4dLlSc/gasc0mpFnGYpdF6QJCRWsgArYTlwFn?=
 =?us-ascii?Q?nyi2cXqDz5P7EjQAgvHkqG+Li0c40oZm5BJtahsyA1oTVsVa2D+oTm1YIrjL?=
 =?us-ascii?Q?Q45DJ/6+n48oJHWnkNA2LQtEChQ0nRwjp876/0dfTtBkGI6C8ay3s4VpPMzJ?=
 =?us-ascii?Q?asonImC7q9AnQkl+rfZMyj9cK8bXowuBGqYdK6Rq0yT2EEuhe1epwJkwWvGM?=
 =?us-ascii?Q?f/n3qOKSfvdkNPVxlx9L66QH6oNQkt7mfRPn50LfYRuL2y2/UXiJX4LI3FOi?=
 =?us-ascii?Q?A3gWHzBzPIR9Zspa/PTmj3TutvQB0FrIFBnoogcQ46uqMlFAi+hb6wV6KXI8?=
 =?us-ascii?Q?2gNAWCn2fTTt6N3QlW0thfIPlYjQ7E0xI2fcfuiM4oCLpHBfmXaKaTvl2n1+?=
 =?us-ascii?Q?TRHfGMZkjs1RkwXkOb+LOhVP1mAaSSM0llLpgZhthQCH+V5tv6whyGFwmGuS?=
 =?us-ascii?Q?3jChTV6NeQkSzAO2qO87KY+PvtPlIsquwoaqugajptY9v9SXjMbhJvBU1p4K?=
 =?us-ascii?Q?ToVTYnOAn0k6Vkjk71oF1L5eFGT1wV7k4Lv6vRJkKMJHnaJ5amImNB+juXcF?=
 =?us-ascii?Q?YNoU9aMYs6ZiCtJYjWfj0uJ4ETgUP5+KU6rW6CTF9ftl6ZPEJA2axwL8X83V?=
 =?us-ascii?Q?PkXae0KoWCVtRVW9gf1qU/JarbZgYqv1TujGaAEDaxo6XzUicwb9wAT03G/S?=
 =?us-ascii?Q?Rt2uK7V8FGAMvpT5MH3ukcMv6R6uZJ1V8VvQOQyM4TAQXzLwp8ya1WLenm2s?=
 =?us-ascii?Q?2fFgXA4cyltbRjQ5isLzOOZr4Tl3Eq/BbwWOLoVVAfRfA01RYuJoZbuPFTKZ?=
 =?us-ascii?Q?3Aj+TXvkwaO+LjV5QnU4Ec9Qcqh6MU/YUMErYCnVMw3qIdi1eESkfVImOgIZ?=
 =?us-ascii?Q?Tn7rYoVfekvO8DOI9YWnWcnuoMn1dPdTZ6Cai80s1dk06CTeG+7LEmmJ6MFm?=
 =?us-ascii?Q?mMDVgiztjmJsxmTib84yRyTcvbzdSH6t+k+5LjS3QdttE/ZBLNYdv1eO23GY?=
 =?us-ascii?Q?F3/C4+j6frtXkBeiOanYNMmwey2hveeYJCutS84Ubw7xYfm9oNQSTY9RgCyX?=
 =?us-ascii?Q?1Piu1A8fsgNBKGszO3lMWT2eZbvFoLuLjECNYGaYW3HtP5mUHGBilgKiVZSm?=
 =?us-ascii?Q?9KoUt/SQboebX54nKo5TZjINNBxHJIJLy/ZiAuK4pxqgpWpL32B5krsoV9dX?=
 =?us-ascii?Q?6eNxmZodfRDHXyiel9vV2pwtpmxrgbYh44a4IASVIQHVpfXYyHCUxeSJr4FL?=
 =?us-ascii?Q?yOpY9ruHqoGs3Ktb+ysRYg9LprWWWuorm51TzxU2CZwBdElQz5BpostiCw6J?=
 =?us-ascii?Q?5Va4ubT1aJWPvd7gvG1zzHvIgB2n/sM7lKCqi6XKb211t8pSj/bOnFW05/ko?=
 =?us-ascii?Q?IltU69IlfxEfPSt3AaIf+0SHu6YjuAoiTwWZJXd8JHF98zq90d5F7e5XhPRC?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcff1270-0a46-42ae-5874-08dde1757958
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:42.0506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dkwdWFvGvClngPeRXKNmSnse5VoXMFd+AgUQvtEkVfSD76+KOBE1Aylf71xPgCrNpEzNINJZRzYyzYjinHUu41mGFM1d3SidkSejVYXecQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Authority-Analysis: v=2.4 cv=TdPPdRQh c=1 sm=1 tr=0 ts=68a85f33 cx=c_pps
 a=ysIXdlsiLQEa0wkRuds0Og==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=pGLkceISAAAA:8 a=Pbl5c31VFoorxvNN0s8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfXyE20+6PsomS6
 msyocGKIoULgb42XBEDsAyksqIucyB+/zR1il/nMlzLw4nmKUQOfd2BRrreiDSpy6c2FwOREL8q
 RDP0A6oQ9+pXhXn1Htxi53oXctP8JRv1jyWxCIH+ju0uUuOwfHKlW9RmhgWD5hzomHA0pvM6tW7
 BCLp7QGyPQ+yxZiKMq51SDa0COiquTttquvdB7aiWpudWb79ZS2zt3HxFKa5w0De8GLYmqLNINy
 Mqk26+aTGEsFcdy9beEcvhhrr53Lhn3q3/ptb0oSnUp7LSLwxo3U+xIbp8zCKgX6szNHACI9ZM5
 LcAeRjEbErCBapblQlEuFYP8pi3DtgGT0dtPS4YWfzonmJFrXCBsESE4tTfr3Qqvu4S6n+uH0fy
 RBQ9QSmfHtFMXQtu30TcT+LmS5mHVQ==
X-Proofpoint-GUID: y7TAMWipR2CO936cVuhuqBItf2J_x0if
X-Proofpoint-ORIG-GUID: y7TAMWipR2CO936cVuhuqBItf2J_x0if
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

Now that pc_init_isa() is independent of any PCI initialisation, move it into a
separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
I440FX in hw/i386/Kconfig.

Note that as part of the move to a separate file we can see that the licence text
is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
("VL license of the day is MIT/BSD") so we can be sure that this was the original
intent. As a consequence we can update the file header to use a SPDX tag as per
the current project contribution guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 171 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 149 --------------------------------------
 4 files changed, 172 insertions(+), 152 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 3a0e2b8ebb..6a0ab54bea 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -96,9 +96,6 @@ config ISAPC
     select ISA_BUS
     select PC
     select IDE_ISA
-    # FIXME: it is in the same file as i440fx, and does not compile
-    # if separated
-    depends on I440FX
 
 config Q35
     bool
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
new file mode 100644
index 0000000000..62acdada3e
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,171 @@
+/*
+ * QEMU PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/i386/pc.h"
+#include "hw/ide/isa.h"
+#include "hw/ide/ide-bus.h"
+#include "system/kvm.h"
+#include "hw/i386/kvm/clock.h"
+#include "hw/xen/xen-x86.h"
+#include "system/xen.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/cpu.h"
+
+static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
+static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
+static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+
+
+static void pc_init_isa(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    ISABus *isa_bus;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    uint32_t irq;
+    int i;
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 4 * GiB;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
+    }
+
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                   &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, NULL);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                           ide_irq[i],
+                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+    }
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    pcmc->pci_enabled = false;
+    pcmc->has_acpi_build = false;
+    pcmc->smbios_defaults = false;
+    pcmc->gigabyte_align = false;
+    pcmc->smbios_legacy_mode = true;
+    pcmc->has_reserved_memory = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options);
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 7896f348cf..436b3ce52d 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a776998504..05713662e4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,12 +71,6 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_ISAPC
-static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
-static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
-static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
-#endif
-
 static GlobalProperty pc_piix_compat_defaults[] = {
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
     { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
@@ -390,112 +384,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    ISABus *isa_bus;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 4 * GiB;
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
-
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
-    }
-
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
-
-    if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
-    }
-
-    /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
-
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
-
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                            &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-
-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
-    pcms->hpet_enabled = false;
-
-    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-    }
-
-    if (tcg_enabled()) {
-        x86_register_ferr_irq(x86ms->gsi[13]);
-    }
-
-    pc_vga_init(isa_bus, NULL);
-
-    /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
-
-    pc_nic_init(pcmc, isa_bus, NULL);
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++) {
-        ISADevice *dev;
-        char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                            ide_irq[i],
-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-        /*
-         * The ide bus name is ide.0 for the first bus and ide.1 for the
-         * second one.
-         */
-        busname[4] = '0' + i;
-        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-    }
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init(MachineState *machine)
 {
@@ -854,43 +742,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        NULL
-    };
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
-    pcmc->has_acpi_build = false;
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
-    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
-- 
2.43.0


