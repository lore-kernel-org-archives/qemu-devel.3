Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A19CCA0EC6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 11:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unxgj-0008R3-9r; Mon, 18 Aug 2025 07:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxgc-0008Po-U4
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:05:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxga-0001Pm-Hw
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:05:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57I9gcKV006558; Mon, 18 Aug 2025 04:05:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8JdHU59LfI4k2zDZSoIuw806yk4XzAREI3QhG62qe
 ts=; b=dz7eZyoTVCmHkNcj09d5h7rD9Vb10RXWW6G6mJ6VDWZ3agWQQxIkXW656
 sAJg7r5rj05FuP316WiILQvF0ElV4jWXLFrvI+sHNOt7S4GVXd/cgRhu5cD06wUk
 ErfzW2vVYgcb/Dd5cg2U/tTo3IZNa9FrMrKYAZWwzxuITlVzcK8ZgEPFKLbdxy3P
 uDktH2g7ACS2eeaujtn6rCSRx7Qgo3is4a4Z0b6ptqZfqHUuaXv4sKHp0YXzNPCK
 0pkDBfFCa23VYFbudUMT4UGf52pXKWSuhhfehgTkjH39VCdv0f/Y7N9N7oRyQNuY
 UpWhd2Rg4MuHCq3bSTPZLznpMQYIA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2108.outbound.protection.outlook.com [40.107.92.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48jsh0jw3q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 04:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmrXv7ZhU1guGxtW3uWaWujnj2F+Nw6xr2tn/4wzolEUcvtXHU/kt9IWhm3AKcgKj7dgXAP6o9NiAbXqYaOwCg5em7HEtTeVFUHOUYvzcwrHG6UPFRmU7roAURh2wR4LG40YjzzW6tvN8cXYKusoAprzPRZ443+iF7gAjgWlo0T+l778hL96XKL+z80R8rJFvE5JKCsA841ty9bfhQhg5yofqwWp9D7piE5OrdQN+w1huHBxoNdCQ4dBF910XKgPbl9RB1RQN2HNFWIDJ8GO+FP/D3ew2eTEhduF8XVi7PlK13q87e1Isp3Xxk65D8X+r0NC9igH86uCTB72sRLvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JdHU59LfI4k2zDZSoIuw806yk4XzAREI3QhG62qets=;
 b=sDdSKptadLrHYrtZ3TrZ3ahHigr61QhA3eqoaK7JhQyzQVMjNbHpwkCKIh2+OxpTq0nkipBe6Wxybc7iDcq/xWnlrWb/LkXAQ4ECTki+YtR7MvhqNe+gSSBpND6K02y3E4RMKIUdqW2KsO6DUAp+RpKHI3mSVZdDUNTM2RDhzHiID4g1vDDf3kal+qiQ9EL2rDZaZfR6yxvTKZE1CdHRUSUGPdrMWC342LZwrY4rU6n+nAfVt5LFc6Q1vaZ3Z2U5/e8M6+ZrOTneE5qkBXzY/uo60XwmoQV7G00XPXAR93vaqXlrQwiv/vu40wLJnOwSUZyXIu5COFXx5o1DEdLI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JdHU59LfI4k2zDZSoIuw806yk4XzAREI3QhG62qets=;
 b=MnonNAzeAOUBvPTybpzKJxPwA7TftzqKFx7vrowacPZd1ziSMqb9XPO/3Ao7BI3/ZwuihFkAgBvOkXI1q0d6ROyA6RBSYkehCWzcbvjcbrIip4cBb4ckXV0x7gBp5wYx0AiwDPQEqpe9lAlL7jHEWy/rOEVMEeeN5sfYC9r/0C7JKxs8NUF6rGo0Xj1bPtdDtgBVBvScnzUdRlQ7M3gsaAGfLF4cUEy9dK+HpICJ2Cfj3FQqZbSPmjaYojP/CwuvBBXe8xHd9tkV5lrl7/Iz4OBorHAmmyFBDr+edwaSuAhFaBb2EzqOoECFfj0BWh/JExhq5A83GnE3dng7QFgxEg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MN2PR02MB6814.namprd02.prod.outlook.com (2603:10b6:208:199::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:05:51 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:05:51 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] tests/functional: return output from
 exec_command_and_wait_for_pattern()
Date: Mon, 18 Aug 2025 12:05:44 +0100
Message-ID: <20250818110546.2159622-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818110546.2159622-1-john.levon@nutanix.com>
References: <20250818110546.2159622-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MN2PR02MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f699a7-246c-4106-c921-08ddde47318e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GhPWPzYp3Zf2smEcmLF+TaFR2PPr8GktYgiwGlqgndDr8rEVdHj928pMyim8?=
 =?us-ascii?Q?mmPhjg1XocBATmhsG0MZ4Y6c/X6d7AMMq/RNphxJv63knVHhYZmOZtrlfyve?=
 =?us-ascii?Q?XjLPlm7AvwTVXMwuJkApQlnthrFP0mWHlcVV8/aPvVg0ByeKQ/+La6js/a2z?=
 =?us-ascii?Q?DsIvxZCn/eui0fqNqD4rI9BmPYmISson6lO74czY8+RbkwVJTKpE+7f7R0MV?=
 =?us-ascii?Q?iNJyAaDJZA9cpu+O8uZHhK+MO5vDYbSdQO0L8EByXcuH7v6QiuRpDBDXoJtF?=
 =?us-ascii?Q?Js3SO5aEvfV7oHcNU8kTpk2RDaIu90xMUFlj8XJ4X+gXZwxo53cAqCVkFAgT?=
 =?us-ascii?Q?el+5rXzNdJxF3WDZ0wUmT1qrxl5QvNFp25hPis23PdZAVtuUsKgbIwp5JSHP?=
 =?us-ascii?Q?85az+7TO4+KY3N9NyhJQibgcsF9Y/vMzukBNjeGJsNMuNrGP0Ty3Ud4793IL?=
 =?us-ascii?Q?UKb7e9OS1tUWgky6DdJuU7Dybf9gNTpQUbbHzuLKEoHzbcHGu8u6anTmhKRa?=
 =?us-ascii?Q?YI/6r2MHnqcfSs5FyawuNI7Iskf4EJNTCWBBOfzI7lsdAS041iK6w8ISlBJH?=
 =?us-ascii?Q?ujlBlELyy4A6bt7lDdqeSl3yAS3x0h1qZf8236LubmTzzrW48PIRGWc4910+?=
 =?us-ascii?Q?oireWORckU2xhmhPCXOIRgwM6MD3d/C7w1Y/QF3VoJy469SZgwx06KPsvWn0?=
 =?us-ascii?Q?v6qVn3fWBfJKlWl0LnwgB8t479TyDz/bjYgODapr6FLqOTJBiai0BIFxu91G?=
 =?us-ascii?Q?MJzNQe6Abzf1DvlfYBsnbBPUGwRl/PRxGWhbxml7KiXA03uQjohUo9aGchEh?=
 =?us-ascii?Q?IleUVTbVz0poTsbtsQV2xv5zn6zhQlWBma00bZR9NOaa0aCsSaweUlkfOBCZ?=
 =?us-ascii?Q?QhWVicBx14bG2H3zQjqYuCgiDXlM5g3IaQNm0vsLYT7lrlK0FT7MKd7utFPe?=
 =?us-ascii?Q?EUul5jkSUDTM7XjlIBf8Wlre1Ioq4k1Brtb438ObLFZIrTYNTYu5w30Ai3Zi?=
 =?us-ascii?Q?0i24ooqE4GDhwrxXbwsMMBil2IVe/BrYS4nkbbNC2lZqegJxskd3u1xNxm3p?=
 =?us-ascii?Q?OhFAProXRk+gnHWJWeIQNaPguOciv1HXT5UXnFYY99jCkr6L16vwY4eoIfpU?=
 =?us-ascii?Q?XM2pRhqmgfMWKuqswplEw1bvlrvH5fF82ofiHXmDTtqypkT6hp2Ts/Oqz1Kl?=
 =?us-ascii?Q?Kx6/yjr9RH7zx7JoPc7EAfYIWyuyKvSA5wlHqfSddiL9/viyem/gSBvDDdol?=
 =?us-ascii?Q?5OHhkE8FPV6XwWdiyiGZerfnoNwmnTH9pv0f9lX12ucqSAcRSumrzAl87trp?=
 =?us-ascii?Q?SF3ufsgMIZPNNaa41ZMFsPJU0K90EVP4QwEb6+Ca3vKLer4b9Y11s1EOxD+I?=
 =?us-ascii?Q?7H93at0Lpxq3bXMAWB53h8/YQXbx9RUo7qfD7kMY/b3CIbusjvofhFpC8dFc?=
 =?us-ascii?Q?/dBf3MGwp0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k7lCEQFVLuyzj/GfKzW/quZtyNBtTKHZMjGbd3GJrUJndKTE5nH1OPVb7kYC?=
 =?us-ascii?Q?V99S5BpaqZNj/qEA3cL3Zxg3VNm5eEmtJd+MOOcpylZaeyN7VBichcB+dMzq?=
 =?us-ascii?Q?a5yj/YPH7ZTCwIqST5GnRkWuyj6ZZj63mBDseulucBWS/+rB/6PMZBApzvJz?=
 =?us-ascii?Q?PvWIvwNFiWqKuDPOPU8g3gZ+2XnvmPvO8wahSdbmmHtApWa6CT2x2FhMSP7v?=
 =?us-ascii?Q?bppsPLqyHgkQZcpcKxVjKwSSHqB/wsQWTBFEgk2RlUuOGLXNE7aZhU+HfjOI?=
 =?us-ascii?Q?uCYiODG+JvKpRyBygf3TvIs8OMKW4EUn8HVl5Fmi67W0Jnvf5Rs/mCNi4CKv?=
 =?us-ascii?Q?At0W9I+9J1hrXnpMQMUVzEb0ewuyjrArZGz8nbXx8NZiBELezKqhDAyP9+j4?=
 =?us-ascii?Q?lI5UX8IbeVYvkKwEzj4DJ8RupcIVR4OoHZJ3rM1ayaMe95lruJDYqWIdAzr7?=
 =?us-ascii?Q?+UD4EchBVpYq+Q9ACeqnfs3iAK/eFDwxT3btb7kaYYNtgYsFyEBimMYF7l1M?=
 =?us-ascii?Q?+Pq+2l/PZcRK2QCrusFdK5PlccNx1sGgFm6GD4BVFf4vkZ20A6NmHJJW815R?=
 =?us-ascii?Q?76t9Fo9bf05JPL5yWlZ9PSRr6VOnt23MhbcMmPKqQDh9yOXyV5o4NZ0vNg4w?=
 =?us-ascii?Q?5kmsz62ZoaJZ5bXnyHz3ciJQHPqccBU7kMfEhvHGAzzWJzMVyUk6e+x7CjJO?=
 =?us-ascii?Q?iqaX/Tkxu9jleu/wtHMER/rx61Ohucfy9naKGQijuv08KlKTWSn2N3/385wB?=
 =?us-ascii?Q?q201mG0oztcXutg7gZIJhgGYVzLlk5h8bw1XywRJnafl0MRyd1S2+S/dfL9w?=
 =?us-ascii?Q?RH+40UrnYz90q3irymkW3IsitHWYXjCmR54LR1t7mqkVHeYXRRPWChIZ9AGo?=
 =?us-ascii?Q?t++UN6fFOCW3m1Z3rQX+6F2IHySEDCmT+V9luyCOld4JcBb0M8KX/beaP3R4?=
 =?us-ascii?Q?+AhIUtGYM9P5w+Wk+WEnbiCnTYlT4aS4+kwnjpGl9V1q6lYwsJA31tb2wm7e?=
 =?us-ascii?Q?eCuAjCuHtWzpIfyr5ChbTfkNU3ykPvWlvE6CKpScy023PnKLliwdnYVJYYCe?=
 =?us-ascii?Q?ekaBpBcTrrkcRDqVYpyO21fb5EOpGEmBDaJeAv5D38PWYASOK/tqsBNuOGGx?=
 =?us-ascii?Q?8rn+rFQ3emOjiwUwD/pJcfWUWPK6fBab+WnXzhvf8SfkMSUyucQUqfs2zN1g?=
 =?us-ascii?Q?ZAuWAYpCzDq7g71Tz6dWioPgr49nTlg0I2gACjcTzImHKppYyx9nC+067Hri?=
 =?us-ascii?Q?JoL9Cz/1+Q9GGMV8o5nQGuiykCq2xDOwXgHPHBi7xIGT9YQs6EThdpFYjA1/?=
 =?us-ascii?Q?bwYYeb62Z0OOY8DnjegMcHB+T8yz0ri9TQeTwOuZSRs7rFMUSfsgCNUVKHDn?=
 =?us-ascii?Q?sdddQyGHFHmHrSifOPnPxed5QrW3JVqEkHzti7ESbe1HTCp4hTbj2ZKTFBW1?=
 =?us-ascii?Q?iGur7MVYmqqaBe2Z7L0YgcTpHTHRY2mfwdmUAfNA8QBL39xSepTfkO9lWl4A?=
 =?us-ascii?Q?c7n/23wF5S+C8smM7LRWwHUIt0eGnCyaCA38nzru7gab7p7k3m0Aeaja85XT?=
 =?us-ascii?Q?zQPtVvVOI7vrQrHrBPKCsTQvnTegK7b794MDfnUB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f699a7-246c-4106-c921-08ddde47318e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:05:51.4179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PUVsTmMfhITOTog3XMTCJemOCHs1VlZdamRUS0ibbMXnVjwUWK7AmtxCjA54ntocrLR4SB6M3EGKGEiKbK2eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6814
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEwNiBTYWx0ZWRfX6zusuYB+ETff
 oB2KSvmYDXmlYpHLkGV52JSrqY+7yOhonjLIvsTGYsUbxuxZ4CsT4Hlb0yKc/0DK5D918E7HBVg
 EuOxGzUpwHzOiawgkongPMSho62E9dIZkpJjEwqASLQ4lApOz9GYP4zDNcsS3Bwx31cfi8esnG9
 3RlGiD0+e3GNDKejeYiFH+9xsHf8DCUyx15wcgR16eyz/JdgUpq2j2MSr0isBuEwWRSdx6AzPzV
 4JNrR45R4yYQ40EoIJ94x9brLS7jMzWzwgoIunP6d7Abu0c8Taa7aAWyg4qxnG0ZZ7ut9h4hJQ9
 kKCohu7zRU+pfkUOmr7/uNZTOonKnZb/DgHZ4lm1mcH3S62PrKEj8vGIInVDLo=
X-Proofpoint-ORIG-GUID: QxEMo9v29xNhNGjqcJ9NC8xTaehSmW5M
X-Proofpoint-GUID: QxEMo9v29xNhNGjqcJ9NC8xTaehSmW5M
X-Authority-Analysis: v=2.4 cv=EbnIQOmC c=1 sm=1 tr=0 ts=68a30910 cx=c_pps
 a=Se1Kd4d4o2/Q5WTQO+3bhA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=T5N1hjIC8Veio-cZMUgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tests might want to look at the whole output from a command execution,
as well as just logging it. Add support for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 38 +++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77..6355b1a683 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -45,6 +45,9 @@ def is_readable_executable_file(path):
 # If end of line is seen, with neither @success or @failure
 # return False
 #
+# In both cases, also return the contents of the line (in bytes)
+# up to that point.
+#
 # If @failure is seen, then mark @test as failed
 def _console_read_line_until_match(test, vm, success, failure):
     msg = bytes([])
@@ -76,10 +79,23 @@ def _console_read_line_until_match(test, vm, success, failure):
     except:
         console_logger.debug(msg)
 
-    return done
+    return done, msg
 
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
+    """
+    Interact with the console until either message is seen.
+
+    :param success_message: if this message appears, finish interaction
+    :param failure_message: if this message appears, test fails
+    :param send_string: a string to send to the console before trying
+                        to read a new line
+    :param keep_sending: keep sending the send string each time
+    :param vm: the VM to interact with
+
+    :return: The collected output (in bytes form).
+    """
+
     assert not keep_sending or send_string
     assert success_message or send_string
 
@@ -101,6 +117,8 @@ def _console_interaction(test, success_message, failure_message,
     if failure_message is not None:
         failure_message_b = failure_message.encode()
 
+    out = bytes([])
+
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -113,11 +131,17 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        if _console_read_line_until_match(test, vm,
-                                          success_message_b,
-                                          failure_message_b):
+        done, line = _console_read_line_until_match(test, vm,
+                                                    success_message_b,
+                                                    failure_message_b)
+
+        out += line
+
+        if done:
             break
 
+    return out
+
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
                                                 interrupt_string='\r'):
@@ -184,9 +208,13 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, command + '\r')
+
+    return _console_interaction(test, success_message, failure_message,
+                                command + '\r')
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


