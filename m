Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EDCCDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcm0-0004SB-Tg; Mon, 22 Jun 2026 07:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclm-0004JQ-P3; Mon, 22 Jun 2026 07:24:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbcli-0001RV-Pj; Mon, 22 Jun 2026 07:24:50 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MApoB04141291; Mon, 22 Jun 2026 04:24:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7eO9NRZpgXZJ9FKLqmE3dkSPaBlNOLafRB/+U27h9
 fM=; b=HA5uyS/ERXUSv1m25CAOrIbDVh8Z2gfLm2J1r4rkOvwV6q7zMHVEXHPCm
 4vLlReaO2SBfgtd8QPaQgKFLNcRlioT2qjnaoBPkPD433p3XB8qm7RKIEZrSQFmD
 QdBT/4ZV8I+emizUKga3/8gge3mQDlSWr6nyx/ykqXSQVfWqv2wIIhGv89aVHtHL
 gRujEK5ZdzZw6x1YNEJyiZ6iheWifOo9S/DDPAgsh4ffDglk7KDrWrhgQn4dhhXv
 YCi7MCYQ/x4m8LawYDFP0yum94w83a7MGUQlT4aq7lyi1PUl43jEbuDblSS58efv
 ZX4RETWCy/4tZFT/XGu/CVq149D5w==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewsxd3f9r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbxOvFZuS1eP8zfayAILIaKGfO/Rdc8hMSDNcXB408G9p/cwupfAW1dA3SUN887po73PghsCifAS2nG3LBFq1fbC0fRc789+1Z4NaVnABvtgLa2d84riggKvs/XnF7+ZOzW5iumEq/Fl0ZQ9Io0pl+AwxdvibJg41xhiEjxR/L6zjeBPHjxVtIZuv6UdR3DNlHuOrMDGyaqbUAwzh0+7lbK6a615Az4LwoQaO7nLFs+bheyd6EihaNfrn07barntqLkPVxK7jXPil0J2mXTwW5hCKwPj0L73ZNLiVPMLCSOwCYThyEb5/Lf9mkCvGQBbI+pgzYdMLuQrQJ4Mo4hKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eO9NRZpgXZJ9FKLqmE3dkSPaBlNOLafRB/+U27h9fM=;
 b=W8ZcvmTuAfF2Mo3UqJp22XddwmlQyWgjDvF+k57PE3MSQOmJmy8IW1kqWuy8sE6NNjTN18rYPSvxpMwB1nEQpm7vctqKor+JcfAF0CdhlbZfgaMDd6F5Y7WVagFokuVHL+/K0GB3Ts0sEMOKR9tCkQi525Vgp+G8JI88Uf6nc1A+CZgG+iYNZYRri8XRAjQ82IrmqRc3u98o7v7ji7CLf0RsDMAJh92RIujKOZXT3gx+lkKD1B+ElINuF3bLVxlD0DcdDSvekrAIrwxcb+5PuYdabHsKyzY7OqQ2WOhd/nSUOu+rvZUA7q5k9KeL5gZ8soEotEcQmKUDCFLLSsppQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eO9NRZpgXZJ9FKLqmE3dkSPaBlNOLafRB/+U27h9fM=;
 b=BQjJt8Wfzu2kczD0LCCK3KKll3JNFfLj1Vn8ug7pyuFcemhhmhxTA9BicVsr44DaalXmgSBv99pHNSlb/7GY/9GqJULSOb7jlJwrGxnpPdBsUvEmKcMXwsA3ppxaRkxsWrPW8Lor8+7nOZsyX/IJv40cIBUqcJyiLeaKY1mOmPmvyRlAFj5ufAegGTtzkYp/RMPzcJYSA/sxUDn25wPx6l9i0KOEduf2RSrgInFQseY2pegLEzGXPTIlEDAGDznrKa46XOZCfkqw1j4zPbCCEwWqEJx5PEmCCQUAedxtyYSYvdSv2xkZjFLa58PfcLAiwnMKDvamuecth4rZiDHYjg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 4/7] hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE
 to class props
Date: Mon, 22 Jun 2026 12:22:36 +0100
Message-ID: <20260622112403.928954-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622112403.928954-1-mark.caveayland@nutanix.com>
References: <20260622112403.928954-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0125.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: efaba6f3-0f15-44e9-bf61-08ded050cf04
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: e+/lZwfWg02HYojOxlfmIoUA6QV9vCttwvdYPNBUfSVNzfRM/DBnOWe4qpoROJQ1dZA0cN8PKqpH4/7XagIKTak1ol5W8wxbDKGpxi66D+oKB2QUZLhvrjQAdh9ciMsnFdTo/HGCQakNtO6iW4SQm5899F5hvper2+wtBp09NouBv1gkPBEIpONvnqDBFyyUDy0sMOvUlVGtMeSKtZqnNwQdyPMcV1/nLKaW2a3VtAvZEPcbyp/hCVoAJrLAbcu6D/IOh+co3Kr5x+FILtJ+fOFyIW3EBpJxznIC9kxqFCVZMpwMiYbmfdv8mj+POmQrZmEEfPgWWP8n2f9TWTM4Oao0vLQiAujVvUxDYSHsCPvJV3uI9MLihaPgXcso/yRvMySUAQNiu6XOP0NyLwoZSP9NYB6xVKZRFIOIGKHpFsvBnbvr2LyqpYXfHAmPXW4g+yokGTiQ4Lz/QcQJk++7OvYyJh+WdQxBtlBvD0oNU5FPZDFsQlsU6AtkXSHDwjfDomFhLanfBkekLEYAYgzlu9+LldkX3J/6+TO7xqRv/HROklC4aoJd3TFMbfzqqQ/ubGXyXlrBg42s0knwpS3Wn6CpIX+EpLSofutViE7z6AfaZyp3yKBTkInTQeTmZbvZbDXsDKMc2jY/pKzVuktnmMgf6+JusJIbHRMXhfF9xiST28bdt4CSaLfTFkz7NhXUuhRMXL+4jyPRUTU0T+jHFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBVPskE1EtCs/LfsRwxeHSOKV/t8E4iNkZ8NGAbg9qezSUrX7T9mWBc3AAyx?=
 =?us-ascii?Q?g3sQ2mLCXksPxnsi37s5brbry9pUiQna9K4C6QmbpwC8rexnHEuUbJZjJkrA?=
 =?us-ascii?Q?lV0y5+bBixfEst1FLvsKRlIIFKCAc/90vNdJjaSIABhdXSK+F9/J9d/xfRKJ?=
 =?us-ascii?Q?li2VFyoQS4JzggaPB13B12/ey+IzWLyWkJfCgnAsnEdlMZiB3jjBYijlpG/n?=
 =?us-ascii?Q?bstMYpxPLOsqugEU0oit1Pt5mrqMKG2YuxAtNGBeizSjUBB18W5RAymg6r8k?=
 =?us-ascii?Q?SNM5vnmrP5Aamx3yfkxKMzHlcRtP42dh99dMMEJKghgtlIbaQrYVubfwlcw8?=
 =?us-ascii?Q?Dhzb5C3ECMqNlT0K1nIYsofKMNTYYpScceeEwlCyJw8DHk80zTzs7NZsFi/L?=
 =?us-ascii?Q?sHsyWU3r+QWWmVaou/RMcBWz0wG4N13xdXSPPfHw1TIu4rHUFfWZRJkQdkrD?=
 =?us-ascii?Q?70gU7dy0+6z7GrUxEwVI/xPMlwhCOVLFQh1FXTe/enDm+2pWm+SsrFhbfrEJ?=
 =?us-ascii?Q?IpM4E1Fb9UIDk+UnfySUFRTb62UHIbqJGPeZzT6sGNb+bGTMIqLT+i1gtAGr?=
 =?us-ascii?Q?Ik/U70+X4E+9nVszzN6+fTFU9td+z3Ng6zQtvUN8R8Rp7XjSxMvolJQgIm0o?=
 =?us-ascii?Q?fcx4MzHea3WOUdN3UpYmjkFUs74wm5WmCTo97hZtumJuENFnlLIp3cZNsleO?=
 =?us-ascii?Q?Vdv3lpWSgk/+5eLmnKjcJYO+xWZlfkL1KV92Gd835AHE0irNfdnhbQ/eimPk?=
 =?us-ascii?Q?eN5iWjV8kywDBIIUO2avKvQsEOnHv7E5F7061fXXW4FCWcP7naHSbx3NugFU?=
 =?us-ascii?Q?V/GhAX6LV2ItQK0lTrhPwAii6/FXrgrqHeP2JOYAqS4MWt9TDpjXi4xL4S9k?=
 =?us-ascii?Q?MqHfIraHmVz7BsLBSq6ve8RY+A2JR9p8li6pVcBDI7S/M+262ysBVTIryumV?=
 =?us-ascii?Q?o6YdvwJoh3K2t8h/v48BDVw00ZINXtt026cago+VpA4lTj3/F7O5V00Fn2Rn?=
 =?us-ascii?Q?mWlEfbMqL0hk42ZGhNI7i1ZM/8ocMs0XMzO/U+Ou3h8VzbyX9FMjYdM/a9iz?=
 =?us-ascii?Q?xPsyKBiEv5eh4izwZLU0zU30LqiXQNUU3+0okqBVd8nLYluf3ZfDW0/FKOeB?=
 =?us-ascii?Q?VXtO8+mDdkayyYl4e/JjOXgrFfu9uzN1q2kTJ84H4G0WUzTm7b0Jeg+jRcNx?=
 =?us-ascii?Q?e4ELIoTM9tjPglBKnHwlUNKfW9eWPaRgBIiUws/rYaKxberkfvf0isGscAZj?=
 =?us-ascii?Q?kho3cZMRRnBOb0WcHAgUP2Xv25D1GOZ6o97H+euPOPlfR0mFSZB23Kv9/WTh?=
 =?us-ascii?Q?ysT/6H6CyNH/pL9/BRv7FboaDOoYkgPCo7oXhzTRu0iCk+0dbj7/MK54OHix?=
 =?us-ascii?Q?/S8x5h7oIzpd0R2U/CPUp0/HdS/gcwfLX9ixgzBuHwfhE19ltxJ6nWvspLxs?=
 =?us-ascii?Q?kZz0CcfY8wYKJkWUj/gIiEyGDozC4+PLn+8qCfaKZg3X9lIxbtGRNp04UwUw?=
 =?us-ascii?Q?tY7YTKHEdCmjgtRhptp+3zDjkOuVXgHJTYpSYbQyXwKNG+a+UkdQiObRXjp0?=
 =?us-ascii?Q?a3e5qDP/hCyS1tU3ok4FvdRJ+53bdlgEi0EFWD+Ix7h0KsuTw4ycQ/BpmdRH?=
 =?us-ascii?Q?Rc/DmkZxMt8GVAqdHXBJlM4ONSIac7HZ9GjQSXEp02+UKzhp2Pf+AkCs8wup?=
 =?us-ascii?Q?8CnnGt6qtBuRWcZU66VinIew0L1uDao71OiOVsgraL2jaJtXjhLQaeGzN4oz?=
 =?us-ascii?Q?zbZoRLMQ1UzrXgoJHIK2hLykhyEtLPM=3D?=
X-Exchange-RoutingPolicyChecked: NMAmkpRg7atPkbRWoYsvKI6tnb+db9bC9ZuXCZ6qKrlHGxKLkkHIgT0+YhvnbN68WbNzc6+iwT13KxJc9tMQe1RcilTGoZjKTnL93Pn21/mZNlyt/WS6LMQYK4U+CDY+WSfG1SFFs8jzvPVyRlweR9mPs+3qjAQJ1yLc+ZUt7gPuhSmjKVYcEe3DN+AbywDLfnGAa+1H9aTqlvo08Ret228ZHGoUQDR9F8gF3tfeXDWhbn1P1IjbYa3ed7bNE7EWvzDpRAAWrOlvNB7RUBsJl7m8Mpz/Bg6oYat0U1nNPwtTaug/nxvxxUa+QR87Cp4g158a1BWgB0NGDjfjrUzj0A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaba6f3-0f15-44e9-bf61-08ded050cf04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:22.4504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1zI7+bflOnrx2/7HaXEtlphozkGq5mfWRDEc/cRe/PhEI3zDwbMXah2e8Src6KGvle6GET3yTQxlLKzvpg5HJ8pwZIM9UFZV32IL6+Ix2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX0LfTk1C1vEgr
 0pkASxb1KNRlsU4PaM9D9Ah4tdZ86Ej3QujHWa9Jh0hZqe1Pwc5/7+AlYNP1KHEkfZ94+1xlhTD
 +k2c3YSwdVPdCBZ7XNm8bkiz/DUDUV3kXHeHtPy4vC4moTHSOG6h5s2Zy+Nm3J/FApUbyWQg9s7
 tXKsVBIcPxN/vXQExsIlaxEkemuxoLpBtkw+d40vOrxjfhBH67Nmro4/351+jcuKFpybyXs8LnU
 mxwVpfAEi2JQR7XP3p5BBLJCOXHvy75RKFhaH/5RetbThy2OEUNoNkiug7XVj/pDDvkS2u2qBoe
 TrfF7maHYwSIQPpRmZmQG6SQiBnE9vGJZ0SDGOxZFAHBYzD+B5h6sz6bEc86ZnhUjq0UHQwsSQ/
 76ysMeGNsn2rEKn81LinGToKML8Us19nt/TR6cZJviNg9eRKMP51w2iCQrKJnvjfeqyb/LgT3EF
 YDOqQCHY4lFtJyrgd2Q==
X-Authority-Analysis: v=2.4 cv=WYg8rUhX c=1 sm=1 tr=0 ts=6a391b67 cx=c_pps
 a=7kgNGXaSmB15KJ6u7rEBag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=WrwsNJpTap34L7CCBUEA:9
X-Proofpoint-ORIG-GUID: mU724pmACKguf9AyTGtcoByTgDTfGZOM
X-Proofpoint-GUID: mU724pmACKguf9AyTGtcoByTgDTfGZOM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfXxOZkgKRcrfoV
 CTRruHA7SaL3NGIl65+FhFOmZW7UyYvE3nykuhBGh8d56CfGfvSc3ltx+1Uj3bcsZ3UMBUyBYLG
 H+mvIIm8AKPbiORK4cehcztXkW1hghc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/acpi/ich9.h |   2 +-
 hw/acpi/ich9.c         | 153 +++++++++++++++++++++++++++++++++--------
 hw/isa/lpc_ich9.c      |   3 +-
 3 files changed, 129 insertions(+), 29 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 30990fcef5..3180e98c93 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -83,7 +83,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
+void ich9_pm_add_class_properties(ObjectClass *oc);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index ac3f452dc3..723a87e6f3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -339,6 +339,16 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
                              ACPI_MEMORY_HOTPLUG_BASE);
 }
 
+static void ich9_pm_get_io_base(Object *obj, Visitor *v,
+                                const char *name, void *opaque,
+                                Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+    uint32_t pm_io_base = lpc->pm.pm_io_base;
+
+    visit_type_uint32(v, name, &pm_io_base, errp);
+}
+
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -349,6 +359,84 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
+static void ich9_pm_get_s3_disabled(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint8_t s3_disabled = pm->disable_s3;
+
+    visit_type_uint8(v, name, &s3_disabled, errp);
+}
+
+static void ich9_pm_set_s3_disabled(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint8_t s3_disabled = pm->disable_s3;
+
+    if (!visit_type_uint8(v, name,  &s3_disabled, errp)) {
+        return;
+    }
+
+    pm->disable_s3 = s3_disabled;
+}
+
+static void ich9_pm_get_s4_disabled(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint8_t s4_disabled = pm->disable_s4;
+
+    visit_type_uint8(v, name, &s4_disabled, errp);
+}
+
+static void ich9_pm_set_s4_disabled(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint8_t s4_disabled = pm->disable_s4;
+
+    if (!visit_type_uint8(v, name,  &s4_disabled, errp)) {
+        return;
+    }
+
+    pm->disable_s4 = s4_disabled;
+}
+
+static void ich9_pm_get_s4_val(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint8_t s4_val = pm->s4_val;
+
+    visit_type_uint8(v, name, &s4_val, errp);
+}
+
+static void ich9_pm_set_s4_val(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint8_t s4_val = pm->s4_val;
+
+    if (!visit_type_uint8(v, name,  &s4_val, errp)) {
+        return;
+    }
+
+    pm->s4_val = s4_val;
+}
+
 static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -400,36 +488,47 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
     pm->enable_tco = true;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+void ich9_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ);
-    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
-                             (Object **)&pm->acpi_pci_hotplug.root,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
-                        ich9_pm_get_gpe0_blk,
-                        NULL, NULL, NULL);
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
-                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
-                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
-                             ich9_pm_get_enable_tco,
-                             ich9_pm_set_enable_tco);
-    object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
-                             ich9_pm_get_acpi_pci_hotplug,
-                             ich9_pm_set_acpi_pci_hotplug);
-    object_property_add_bool(obj, "x-keep-pci-slot-hpc",
-                             ich9_pm_get_keep_pci_slot_hpc,
-                             ich9_pm_set_keep_pci_slot_hpc);
+    object_class_property_add(oc, ACPI_PM_PROP_PM_IO_BASE, "uint32",
+                              ich9_pm_get_io_base,
+                              NULL,
+                              NULL, NULL);
+    object_class_property_add_link(oc, "bus",
+                                   TYPE_PCI_BUS,
+                                   offsetof(ICH9LPCState,
+                                            pm.acpi_pci_hotplug.root),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
+                              ich9_pm_get_gpe0_blk,
+                              NULL,
+                              NULL, NULL);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_GPE0_BLK_LEN,
+                                         &gpe0_len, OBJ_PROP_FLAG_READ);
+    object_class_property_add(oc, ACPI_PM_PROP_S3_DISABLED, "uint8",
+                              ich9_pm_get_s3_disabled,
+                              ich9_pm_set_s3_disabled,
+                              NULL, NULL);
+    object_class_property_add(oc, ACPI_PM_PROP_S4_DISABLED, "uint8",
+                              ich9_pm_get_s4_disabled,
+                              ich9_pm_set_s4_disabled,
+                              NULL, NULL);
+    object_class_property_add(oc, ACPI_PM_PROP_S4_VAL, "uint8",
+                              ich9_pm_get_s4_val,
+                              ich9_pm_set_s4_val,
+                              NULL, NULL);
+    object_class_property_add_bool(oc, ACPI_PM_PROP_TCO_ENABLED,
+                                  ich9_pm_get_enable_tco,
+                                  ich9_pm_set_enable_tco);
+    object_class_property_add_bool(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                                   ich9_pm_get_acpi_pci_hotplug,
+                                   ich9_pm_set_acpi_pci_hotplug);
+    object_class_property_add_bool(oc, "x-keep-pci-slot-hpc",
+                                   ich9_pm_get_keep_pci_slot_hpc,
+                                   ich9_pm_set_keep_pci_slot_hpc);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index c6d31a3957..13aa05b221 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
                              IOAPIC_NUM_PINS);
 
     ich9_pm_reset_properties(&lpc->pm);
-    ich9_pm_add_properties(obj, &lpc->pm);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
@@ -950,6 +949,8 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                               ich9_lpc_get_smi_negotiated_feat,
                               ich9_lpc_set_smi_negotiated_feat,
                               NULL, NULL);
+
+    ich9_pm_add_class_properties(klass);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


