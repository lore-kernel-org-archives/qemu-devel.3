Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F65C54E65
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWQ-0003AS-RC; Tue, 20 May 2025 11:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWP-0003AE-NN
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWN-0002OI-N9
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:49 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KChh78010177;
 Tue, 20 May 2025 08:04:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=z2VXFeduDIUIMUtFpLP9ErTdTd4WNkw5pDScHzJjS
 mw=; b=N3ZT/3RGtVHa6C8uWEUB0x/cPlU2lh5NdQ387pnETJ68yMV5VliuEwawh
 GUGMirSHEOaRx7QFclbFAOZxaDxzg2JAxnDmWPKxFABerME8soo+oRL7SHKnlmNM
 yYwJ6RYUlXibptT7YpleSHPgs055y+nx/TPlGpyeA46losvLckbUHmHg9Pp9dSNt
 vHO9x7/4/voxGoTcnP7LKt1KGWtDo/NtIXzpXE1kCCwXOl6A/tB4oeXcA7WQachl
 sc4Cm4SHSosUE6G7Jc+RvnbXV1RZJN3HvHNh8NzIAQ4yKmhapDZRBL3URBe4QZmM
 xK4W5bufPJDUnPJGAYm7YtEMzE5gQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhebvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Chj7iGiO3q+N5LIqguAqCHwsAlwejYlT3BROdrIelJlP5176QXfoMsdFf7P3IXTv1dCs7+ocTNoSrQCGfVyQj8RIMAD03m++X1aSsGJQb2aqXSsYIgaCxx7JhlMDj6aLzUVsLaLA/OGt4OFbviOr9u3QPzYcCo/dJlUpTL62yjJXIwNzKyIhY1pnynYLldXL/2+bpBw5tN3mKac1tV1BZgH2Io0zSsoM0Oj0CKL1d3lCB4DSkPEjm9SKnRyxMVVv0r/3ZnLp5Vwyjss2Illmyb7wu+43/WczItMdk6tv5hbOvboGDS0GJxS87Eisrpo8mqiLCr2HfwapoS3o380+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2VXFeduDIUIMUtFpLP9ErTdTd4WNkw5pDScHzJjSmw=;
 b=zKsalpHWoYhp+MHSNzbbFpi1o1YMld2kf0oA9qCjemwUgxO1o5jqhoZVsEmYiUalkQBmko8Y0yIk5AnEyVzV+JugC9TI88DXOASwL5VE1j9eH+QblVVGWvr8qcbMk7pWzgnfJzMG6qCWDB+vrY4S8xLbAT9k/DcFLyDz6bB78Ynsr0uSlipl1tgnD8fK/FV57vEjNvBLTNX3X3NHoOzgNMp3hDycqNVi6dm5c2zhmsAP3ODa+GNBYsmCzvHz5o3emdukIHW9OIpRVoaa6WsXPWJRFbXEWYRIRtal16JsuqV8/qpqL121195gTFfT1LKbPSvkVyYz+lpMU85w9WLRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2VXFeduDIUIMUtFpLP9ErTdTd4WNkw5pDScHzJjSmw=;
 b=lsuhdR7NBnCoa/cQ/WR6Q9OxC7EnIT3E34hYDoBJEQkPuqkInthgIH8VGqGhs/RXvvaQx1R2icF/tLe2H+XpSQf5wV9RfTUIM/AJc4TlNKnDfXtinH7Wt+wMsrcwifhJ8t4MbBoXsLeYjojdNlz4sHqRdXl5PF9YX9/jL5KcDJS6kr4ie6wkFsPwo7brZymYuRzxTKG9ffC8m8ab2ajVpv/6Krbwnq3+0sUsgH+TDUi76DVncXiPi9/Ex8jpUrtZ6xSGqZpxUYclctukEnsRQWSf5C9BUvIzegAA/E7/asaNMRESHcZgd7//VXUiXMQ9bDjf2KfaW5hJ8vrIdBh1TA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:42 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 07/29] vfio: add per-region fd support
Date: Tue, 20 May 2025 16:03:56 +0100
Message-ID: <20250520150419.2172078-8-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7b472b-b5ea-4c5f-4cab-08dd97afa636
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBC0mIamrdYDMT69SDIUw79mn29643EXja4UV+TUil/1dK9XgCI1u7BESzvr?=
 =?us-ascii?Q?vM4JukfPFdiKNE1VvVDl9/Nw3lxBPidyvyV5mijVCGTmuuSn/Rpfbig1w4QC?=
 =?us-ascii?Q?/NfwSe9h/ckBxQZ4bslk6v9nnT8lRHlJ/WxwAmDgPVI+D0dNNiDuPyktF3NG?=
 =?us-ascii?Q?QYw94Nue6infu1uE1XdZyW+qyn/Ao0pHSzFvx9QQjH+ZseIGQaOZzuG4zRWP?=
 =?us-ascii?Q?N8J8VOru1bKSaEmO9oKQcmNSLlShPwgw+ANTxV2MNekCFVmtflDCWvJLYu1N?=
 =?us-ascii?Q?/NK9PZBkpXgua+uTawo0rK8QCbEfNI8qlEVhIXHd1cZG2sGo0x9ib8E+oAnA?=
 =?us-ascii?Q?P1+SJ6PUI9PPptHX4eNlrcS/jdAot4pvIeXzHGuit7CPaKd6qT9V57D9xlSb?=
 =?us-ascii?Q?jdPbmQd143afNZuetcgkDwIupFPYxNVxo5Tt2GWooe3dFC4iiPwkY/C6j+hj?=
 =?us-ascii?Q?0zUzt/jssK6N/LQVsMRAEfOjduT6A/6vxE+dxTWxd0edIsHN4homa9RIRxr9?=
 =?us-ascii?Q?9iz7Omvc/oxMdkYE/lsjuKpoKc7Lu/VIVCiICxNeQ8L6Ojqjp5tYzYVmKyRY?=
 =?us-ascii?Q?4MyP+2Yqgrsy1ZJuFCIFn0nlwh8u4DfQAtK59JjCZHfg2dKkMulKNxpOeYuP?=
 =?us-ascii?Q?zsxeCMmvx7qNvTMnkESe+y8B2BzrW+hS4XOFVMEWCICBnl/kdzPZOxSgT6AG?=
 =?us-ascii?Q?gVmeX7LMQt6Mmx/K8u7Q4mggytSio1IxadseRdCxQXEkmAMenaEIfv7SBxSf?=
 =?us-ascii?Q?y3F7x1TWfbNcLGqhypMFRnSnessOYnwmjH+LxXqlqMlxWMF16KaHLzHz0moq?=
 =?us-ascii?Q?vI6JExmqunkYeWzCaYzcVQDJ7Ysq/NGJtPVmtyKZowxW2fw8CmFElm1L3Qe5?=
 =?us-ascii?Q?fsvlelyOOmSJEhRt/GgQrFl7ko7xWhljpmz+l3NPxjaNVTSoMXlAUlRD72+4?=
 =?us-ascii?Q?/OkdPBav1fSxv+wupNpNAn19ICb+1d1fejmLeHbfQcDIY1iRQCuiofhmXakQ?=
 =?us-ascii?Q?JnL5WvpjUi5uz4vGtHtqPsZIVHvdZTllj8NmiPVJ6v5i9V/t78ZLZK/+rCuF?=
 =?us-ascii?Q?ER9IPRZNSDLjfwdI5faWd9IPCbQy/gIRNtf+VeZpiRQVPzt8TK3XUzxneK8T?=
 =?us-ascii?Q?zd/0YNKsrG9R73kCmhYKwLT1DqgdP45ZKERrrMWplFFor421WsaqdgPuLLaE?=
 =?us-ascii?Q?tbTTVGpKXJFbXWse6ZI3w2OQoru0nIBaW/Y5XLle63wSeKtT7BU4rq69dwvV?=
 =?us-ascii?Q?R/Kdc2O1/VaFefowFG1u/ZS3O9FeKHYNG8JWgLjx/G8c9lF3k4aocIavdgTh?=
 =?us-ascii?Q?a1CUTl3aEI1sAf2e4cXfjOsFnA0CauzmZZKrZU1fRFg6wpjhQmbUzkY4wQQA?=
 =?us-ascii?Q?Be9KVnAop1x8cbOzjmVDJ7CP/qfBmb9eeaFyLPFnFV3ybj0o7/1RgKa4Qjkm?=
 =?us-ascii?Q?bJ3B95Vxy6k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Ukrj6/OiDb4+h4fjQkKicZtqaRYecBrsy0nzDv+6k0HOeKFAY3M+4WrgsFa?=
 =?us-ascii?Q?SHcH6NQDYCeDIjWtXXqzQzfn7Nncd5uuXXdr9iTn9pwxq1v/aU3a6Kl7koT6?=
 =?us-ascii?Q?Qqd4YSM6SB8WdmMvauDXqMALM/7vMBFPol20w+bu0JkVadZz1Pjp6HhSQ4u6?=
 =?us-ascii?Q?7O5GTQKTxYc3LsXlPxyzGgJqE6qQ6rTwtofkr9lO1+QoBqvqYIdlkh/av9nz?=
 =?us-ascii?Q?h04b48QifTeEqne/OXh/eL1kQvrCnNZHZWjqORoLSv8UEP8KaXQN52EoJ5Jo?=
 =?us-ascii?Q?W+N7jhqu3sHlnO4YdXjgl2nZPUQlvUOXh65MmUXih5jG0y0j5Nwuf09VCcER?=
 =?us-ascii?Q?32dSGF5ylJJ/bZOr9/1WvGZ3/sB87mQBBdlehraXJw+ARJwsNlLdy4VrFAUa?=
 =?us-ascii?Q?TSH+uYPy+tcKjVFi3/1bxeHzZX++qt/JmlXmF8xkzhuY3bdyr8WlowPbX0hC?=
 =?us-ascii?Q?G7VbgW79mhfgeJISdRa5CfAJvlobf1UyAVwrqB3NM0Vq7s1pJmg4hq26kevz?=
 =?us-ascii?Q?d9PMfNKAa+WBFyPHY97kZOGkPQJQtW9NtwuIJgn3QAbYmKrcQCpWnvo7o+aY?=
 =?us-ascii?Q?+JzXdvPgUkgezU49eTBc8vy2SKG1d+38ErNVg03IoIoHsRSC+dFm1Rvbnna/?=
 =?us-ascii?Q?vtczWpenMYP0+WLDrIDBUAcXiCmQ2DUnzjHySrr8VdGuNZ2XeecE5wqCTPkO?=
 =?us-ascii?Q?U1G/cBKhHF+NEqY7CMVZ1oOu3V3PhOduZB09PrEIZoFX1cgsQliQM1hUxtPP?=
 =?us-ascii?Q?Mb1seiq4PNCMYc0iv4i38ULSDDiOXm3UZtK/C4WmxNikyt50svqovlYJLwSO?=
 =?us-ascii?Q?YoAYEZ0o+7uyNzPDDpSrZiToQ9YTjfCOpOQPvpQ9oa8rkm/oFgKhAe/JQaTa?=
 =?us-ascii?Q?0KclUsMnNsU4bqB16Cf/qB+I61Mkflh2KEHQnAcAnYylF2Dom9JgYJ61KZ5t?=
 =?us-ascii?Q?8NWq7BwaVTRscfoEEggTcYmwLbWPQAv2pI5MJYlbx+niOVdo0cnHxifs+C2C?=
 =?us-ascii?Q?VPE5Ba6ErF65bD+2XTv6VQxC5tLQZ69xonaNIfMb6hlSzaNb2MUPiLm5AZ0m?=
 =?us-ascii?Q?hxSWOVPDgLxUnJXw98i91DmwMlrYa+cLsEAyDWTWPliLgATIUtRT68so0O7Z?=
 =?us-ascii?Q?K1dOf/F9Qtb4AvEXLHYVJjkfiYQNTMq/BG6HCg8lbyt4tTXAGacFK/ZooKHp?=
 =?us-ascii?Q?7y14AnlO03h46lsm3kG20gB8/LZwLdNl4dnq+j0aQSCPRp27CxSuL80U28o2?=
 =?us-ascii?Q?jTyC37t71Yhb48tnApakoUk4H8n9OmZ2YJUMACstkEbZqKAbq6bzP5FUWHHI?=
 =?us-ascii?Q?YcXEMTz+6m+IrX0ADQf4yqXg1kUVlA8gvmxjjBoIcAGR96oLjYuBqgJDHnLy?=
 =?us-ascii?Q?U2NK1yTlqid5pEsPEf4xJ1/xtTowKTqAJ0kQYUUGJEyxTO3gTXOe6oCr3tIq?=
 =?us-ascii?Q?mPJxh4JqsrW8AMuJQObNLN9bbL6/GME9Gk9ZF7vGeCt0DKOzYDFL7opSAFbY?=
 =?us-ascii?Q?Llh77xAXwCOkkJxNxkjdoTfIJ6ENojWpxVNQiEXcUSuRE9qCYK/U7NCI4/PS?=
 =?us-ascii?Q?cVARWn8Not8uN2cu51apOUB0B1jGZj81LNji15pj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7b472b-b5ea-4c5f-4cab-08dd97afa636
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:42.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCoUCp1RMIU7dJvDVmoUr+XAc200FkxQnsi4A5EvfkSmoqgogsDtJpkc3eBgSu6zFAqtAYKH4bRwhzXTDzWFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-GUID: 4KtuEGgrz2MilnuCBvw9gW0tPa7kmB5k
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a0c cx=c_pps
 a=e6lK8rWizvdfspXvJDLByw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=5dvBy8a1CCwUYuo3VioA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX1dqT8W9UQMWF
 YJXgj7Z5d2z9O64dr8Pw8RCoxltM4UQVGNzh5IxUHXTzkpg+4MSSuEzzhyz1jByNUEViFYT05oL
 MmdZ/I8tjlgcXOS68GjRAbc7zqfoYvjm+VDiBBnKVLv1onCGxcApzP0OtIc6N37GDZ5wmbALYTq
 jFME//M5j+8EMV2tI41ZIBt/cuSNaTabk8B7LwZRZYUJQb2IOyPjwvYFa41OshuO0lTGxJ+sV1I
 9o4rk/+v35tVYskBXyQlZEtCiP5wNcr46XqXQnm8wi0cvtbw5WfrnGa6s0MZpNRzuwSTr0+32sc
 GOErOs2a0cCXH+j8SE0XwwVJXp+8mY2KwzbucJTDeZEZ3e5N76SG+ryquwSD6Pq2RqVnz9JUNuo
 MKBUil93yYpC0Xr4W+vQAekmedyQz0SCKzGna1fs/Lw2ERYsQ20vkOUytQZQn1uGXuEZubxM
X-Proofpoint-ORIG-GUID: 4KtuEGgrz2MilnuCBvw9gW0tPa7kmB5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

For vfio-user, each region has its own fd rather than sharing
vbasedev's. Add the necessary plumbing to support this. For vfio
backends with a shared fd, initialize region->fd to the shared one.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  7 +++++--
 include/hw/vfio/vfio-region.h |  1 +
 hw/vfio/device.c              | 28 ++++++++++++++++++++++++++--
 hw/vfio/region.c              |  7 ++++++-
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 923f9cd116..5cb817fd6a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -66,6 +66,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
+    bool use_region_fds;
     VFIODeviceOps *ops;
     VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
@@ -84,6 +85,7 @@ typedef struct VFIODevice {
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
+    int *region_fds;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
     /**
      * @get_region_info
      *
-     * Fill in @info with information on the region given by @info->index.
+     * Fill in @info (and optionally @fd) with information on the region given
+     * by @info->index.
      */
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info);
+                           struct vfio_region_info *info, int *fd);
 
     /**
      * @get_irq_info
diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
index cbffb26962..80e83b23fd 100644
--- a/include/hw/vfio/vfio-region.h
+++ b/include/hw/vfio/vfio-region.h
@@ -29,6 +29,7 @@ typedef struct VFIORegion {
     uint32_t nr_mmaps;
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
+    int fd; /* fd to mmap() region */
 } VFIORegion;
 
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d0068086ae..41db403992 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -226,6 +226,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int fd = -1;
     int ret;
 
     /* check cache */
@@ -240,7 +241,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
@@ -251,11 +252,19 @@ retry:
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
 
+        if (fd != -1) {
+            close(fd);
+            fd = -1;
+        }
+
         goto retry;
     }
 
     /* fill cache */
     vbasedev->reginfo[index] = *info;
+    if (vbasedev->region_fds != NULL) {
+        vbasedev->region_fds[index] = fd;
+    }
 
     return 0;
 }
@@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
     vbasedev->io_ops = &vfio_device_io_ops_ioctl;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
+    vbasedev->use_region_fds = false;
 
     vbasedev->ram_block_discard_allowed = ram_discard;
 }
@@ -470,6 +480,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
                                vbasedev->num_regions);
+    if (vbasedev->use_region_fds) {
+        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
+    }
 }
 
 void vfio_device_unprepare(VFIODevice *vbasedev)
@@ -478,9 +491,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 
     for (i = 0; i < vbasedev->num_regions; i++) {
         g_free(vbasedev->reginfo[i]);
+        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
+            close(vbasedev->region_fds[i]);
+        }
+
     }
     g_free(vbasedev->reginfo);
     vbasedev->reginfo = NULL;
+    if (vbasedev->region_fds != NULL) {
+        g_free(vbasedev->region_fds);
+        vbasedev->region_fds = NULL;
+    }
 
     QLIST_REMOVE(vbasedev, container_next);
     QLIST_REMOVE(vbasedev, global_next);
@@ -502,10 +523,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
-                                          struct vfio_region_info *info)
+                                          struct vfio_region_info *info,
+                                          int *fd)
 {
     int ret;
 
+    *fd = -1;
+
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 34752c3f65..3c93da91d8 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -200,6 +200,11 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    if (vbasedev->region_fds != NULL) {
+        region->fd = vbasedev->region_fds[index];
+    } else {
+        region->fd = vbasedev->fd;
+    }
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
@@ -278,7 +283,7 @@ int vfio_region_mmap(VFIORegion *region)
 
         region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED,
-                                     region->vbasedev->fd,
+                                     region->fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
-- 
2.43.0


