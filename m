Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89142E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdb-0006Ul-IZ; Wed, 08 Jan 2025 06:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdS-0006TD-VX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:07 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdN-0002Gl-MB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:06 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087vtsA007169;
 Wed, 8 Jan 2025 03:54:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gkODlHe2hn9pUwEKcizqU9/W8lqBZqXJEw5lYnJEJ
 xg=; b=B4gWtTEAJ3VwUQ8hhjEr+4JJdZsb01XR+BC9c/PS/wx1KcXZMn8YBvC57
 niplVuooKAXOS491sUkqc/qOYTFdztwbsJzUgw6urVt7uFtvy+pYdf7IYXmqZHHD
 OS/nVnUA2LPOQXbvJtdI9M/5J9n+23apU1YUhk5aUNYAZZxJM5qI7u9lcGls+ZtW
 BGls8hqMvTKuaQvMFErTiYEAvNdwYWu0adITvqNTBQ7ouSfYQwkQGWq4FM/Mv+dO
 naYuJv+a/6QSjGJFSTDa7l/OcbxvcHsoWeJ1TPNGB9q4bInaGXu/oSpGAmX1Y+D0
 zDj/dpTv3tgijAdeFsmRYwtnvx6kA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y56eryy2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5bXrQMuRmkHYeP232E5JaanMS0MuhwGY4IfwGTvDRmYJOB9sslJwWdnBIC6XlOYXBovNXIUvXFoRQpLccRGpXDUM5gfMSln0aqntIeyrVfGdSIgmoTQRESZgkM2w79MQhpIrNPcz7p+bhJMGKRI4lxoW3+rLPLox44ntBMLrcWIi5zpxoPgHaMJAsftF41fj7LrrXMF32IAMYspanTsSKLCGVFf8wqvebd3Rs0dmNC7YKAi71a7o5C3Cs/iCF/A6vnrUdYipUnmocjs8foIyS1IQMldM2PwhoQGaU95SQqbiZ9pdbiynjaert+t1jtsM27v+RncbHdIivmSQ7291g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkODlHe2hn9pUwEKcizqU9/W8lqBZqXJEw5lYnJEJxg=;
 b=c7cln6UtuZyRxtPeSCKTpgpjWSLeCzgQXWi8Iboq/oEsfDc91HrAOepDs47mZMSkz5WnCovAiJisNAE56AjEZTnGN0VjUy9ODVlakeX2oEhwknez77d8tdV3Mv9Bt7HaId+a7tHefNAWTEMsCdyWmxJsvy+0LymDTccliQIt6MMl8R59kz7+39B+8eu47txOAyri1+3biMlxLG8EYixlh4Vd6AIIKDWcgg5BUdC0sqCinhdZ8yXLPFORf19g7etSfH2F2i82JLaZ4EdGfBDGCu/Su7KQN+a/o/0su/yFnGFHjDBPJTdATc7yD1DBak/HBLX0pCbk3bvyk5+2/E7Nhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkODlHe2hn9pUwEKcizqU9/W8lqBZqXJEw5lYnJEJxg=;
 b=Fzeo7T0dcmxmlVKq583Dtz7tGNja8802VtjyNZUCqar6QonyvJF78ctcvsFfryhxv9C4e+V1KUIhlpelrWIj/XIgTuqlCCZ+yWXlCU6y3BbUYz9sFZfDIW7k+Wp5czBEfa3FO4HbXxsdLznFsQtybyu75+K8kgI6XxsCu1HIPdj8OqEG+p+b/1wwMrsPtxHWgDQnhc4EBkkbaRgwjpS4jjBt9xs7Udd9b1KB1MXtR/EQzfdXNmGCyJHesMlzbsTEPkC6kE9V/M3tvqx2CYFWRFyJ5DoMkQhsTXyFrLRiCh9aJ+V/161YZOH37ojygEKY5mkOmnHqz1PwCJ9cw6ZORw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:54 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:54 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 19/26] vfio-user: forward msix BAR accesses to server
Date: Wed,  8 Jan 2025 11:50:25 +0000
Message-Id: <20250108115032.1677686-20-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b741c72-9f75-40be-3a2b-08dd2fdb2072
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?opAdS76sU0ewS90lZtcCrED9iG4Rri04Fn4iaJuUrDFDf8ESa1n9VgKtKx+K?=
 =?us-ascii?Q?0yhZUBAi3S83DLMWLAGH8Cx+F2LwT+f4WoDrNRVIPOQS22N6i0CoDynx3afz?=
 =?us-ascii?Q?E0t501SbePhzeWKtf3HDv/oN/95vTbf3fX1VKukuk1s3ynA3DZxxVQP3JiqP?=
 =?us-ascii?Q?QhNh/5p6dakHER7lEDJovIoaiVY4y2zfRirYXwyxjUFpvs0i5XcFDI+Wn1kk?=
 =?us-ascii?Q?ml6B5DkIlKKwkIxAOArs6c1k5lJt60KFr23onF4JApbj5OTEHkUPUZEF7s9D?=
 =?us-ascii?Q?xinpHPLZuaTr8XkDNXC7sfxWoCd51ECEQwv/hldclLG9QM+FH3w1QX/snULS?=
 =?us-ascii?Q?4vjGA0ufDxctI3aX+ac3XCPspnEJAFxQDkKMm2z/qha1ckCJ4IVL7Mg9LZuU?=
 =?us-ascii?Q?5A3Y889KTZ0dWjRbTkMZ3tuZZBQQtlAYN4sLdlGLJvShfEPZbJn4+QwikMnZ?=
 =?us-ascii?Q?Nk2wf2PDWV0WaddjnTeM0SU77uxIpDdDfNAKLzG4TkjAzcOwPhc7/ffnG9aG?=
 =?us-ascii?Q?vIS/n2DfoqwWGaF6bln+7fNxdLxtbqb1Hyx74C9JFHH72KjWV9HtH1FK6e/p?=
 =?us-ascii?Q?KvPvpcEkZgaWnsB99n02B0yNi1xn6TXS+hWQAYTsl6cvc75aCTSmSqBV/AMQ?=
 =?us-ascii?Q?55ap3kmyeWxgXU0qzBaxN3gHOX7eOeS6mau3C4877zXrcfGGta0iy4TYJttg?=
 =?us-ascii?Q?iYW7fsZuHfMG3+qc1NEm2ZmRMfumiX39cadXVJZwOuKfOOb75tlPsa/RIia6?=
 =?us-ascii?Q?AI+6dQcVfBtGUg7OfJmBBlsyqKLTmLX/kCM5k0zsALzWy66AnkznEIWNj0kA?=
 =?us-ascii?Q?vMdiRhgmNuNwB1yUkySJDpVaIbbogbB/IQCiisKu1nIDZD8W26Sn+8WURJDM?=
 =?us-ascii?Q?/CdVdLj5rlAkZzrjPFgMic3yXvqMpw2yYtHv4DPyDsDec45t5mEqVGLjlQSO?=
 =?us-ascii?Q?myuxyPMBXZCblCiuXZNE/fGggFbS3NoKVMskw3fmFapRssmD2tUNveCjTGdx?=
 =?us-ascii?Q?66xy0Xhbti9B3LKFLiNYa/3+KnGSR3rcHhrPNSdy+1iLEMUqopOd1vKhswwr?=
 =?us-ascii?Q?GJuAuxk8xYJIQ0sUtk3TGVa/2wmrG88LldLUTiA4GC1w6lLX0bE2APfqYsVH?=
 =?us-ascii?Q?5cHYM7LsIfYyR08v+WJxZLJ+T77zj6CRcqyKwvBsGBus2BCGxnapY7G5YRPP?=
 =?us-ascii?Q?4Ai3zs8+ojV/OkjJvvpwiB0uv6IICUyCaTfd29/HWX1/YbWSx4ZpCpxn2HB5?=
 =?us-ascii?Q?VdJX+qrg/ByOpGw6elaUglZKJuh2JBmgODAxYxs11Lw9tR84U2XCHzPv2oDp?=
 =?us-ascii?Q?ceWrKAwZ4pJlnevKOHia/7Ft6cHUKpdRKNxj3XxVkDq6uBu1ni2l7voNzzpD?=
 =?us-ascii?Q?odulpeEwsV1jkbCm+3F2KUq3c3z/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqXIof3keHjCtjCgB08Hd4NWMSHR7Rva4wr/EB6dNGydmeMh5Q0oNaaRhw/p?=
 =?us-ascii?Q?HFoLkRzZ0BtEHOtcwHxo8Zw4wMGZXdGwFA7sepqptz2iIUMNDkgqaeMtXkTW?=
 =?us-ascii?Q?h5ZoAN8sorM4BRJT5L6x7pgJy5YbjLpiDmyHazZ9WY8IZGu8JEfJltFeuiwN?=
 =?us-ascii?Q?9FIqYeH1k8qXIbdBAQjoj0oNrpKqlBN5mtzd6R1I+7vOyvUW8f3nJDnITFHh?=
 =?us-ascii?Q?QtDSt2LDEGKeSU9rTwNuucm185yN5ysx35WTmFtSN9+G6tTRycIQFdYaFdrc?=
 =?us-ascii?Q?6S31oaCxr8qA71C9mMfqFPajuBSXLPjgA15cHzppwSJv7P7eTJ6FxlGCyJTs?=
 =?us-ascii?Q?EdIsWNSJRcxRbjjwzUjr1VmO0NfRl0eZz6PjUVN6g4is4KPBOiFoRlbMt9uX?=
 =?us-ascii?Q?cxO8iQ36QZ1EDr2H8mIXj7f/4UKgpUQ6Ce8tbL4Zm2+Zm2jOnB04q+NJ3UQM?=
 =?us-ascii?Q?GtQVzTUfw9f7rtK2oQ0FnAznm3Ga7ReAHYwm4PTCUdqyLRCCpYvoPPMmk2KU?=
 =?us-ascii?Q?wsVITayq+CWhrIby6Bx5LFyzG38AxdCvFyB6zwIeWy3CiRt9OSCC0HdmLCy5?=
 =?us-ascii?Q?GbLLu5wNeMqaQA+1/v3R253hRxEr7wSIKhORclyJ1GwNv9Sz0+Lun7e/ycGV?=
 =?us-ascii?Q?0SGuCBGKtRRMzXivZeOjo/u/sS4rnJ16CTtDLoHqhieyzr1EWAyjJQ1ylRzs?=
 =?us-ascii?Q?8+YW206Cl58J2/qxiV2AIvFEku4lHh1JXHn7onG9Xn4Rd/PIBsP2mhoSoAJ6?=
 =?us-ascii?Q?J5HAQfOGKqpTW5E1fJqAS2D0kmkw6zqD5wF6Xp0IxVn4jW/5BqAmKF8vDCqR?=
 =?us-ascii?Q?XxdQUjy+Dyw5UUvsb+YblbZah/RSKZ87VIhb8Ie8Mf7kmij6VC1Yx9tlYmol?=
 =?us-ascii?Q?FylpOUBjv2wKbUEOaSQh4NXd02fSmnr0BwUbLwgG23SErKqFCi1qnxsOT3cy?=
 =?us-ascii?Q?wjAkT0NpkTUOK4f2KfgGT8hpoWpMSuFu4EpvyP7bqOqNzXQz5qdrdDeumREV?=
 =?us-ascii?Q?xPI6v28wDIOjNs7/asefe6X5bh1P88h6h8KkdykOqLfMMbe3pqV1IFJUWaCR?=
 =?us-ascii?Q?w7MWWNR6QgqMTk3jgVPFK9F7rFHQcWUdPKIyodHP0QiIOGE7MV9cRk3wTwoW?=
 =?us-ascii?Q?JTM7Ap5omVwHbrxkVaQU2blQ78+Y1bSrx3Hd4iTnErTYqxIufa9WfSqxd4Ds?=
 =?us-ascii?Q?J0Lsh2FUB+BuBZ+GKPp2CZXng+/Mt36n3EVAm8DaGFCR5Nxny/lMWDBCKpRi?=
 =?us-ascii?Q?EGG/PEf47GN/Eme9pLxNu0iEaxLDczGq1lPNyBMeyB2ijoKlGZ3xTvJW/T/C?=
 =?us-ascii?Q?49uqCy5YbLd3lkOl7DfPgZimOZtizAPzWuXExhkOFMukJ6J8jzKg8XGTaWUC?=
 =?us-ascii?Q?lCh/k1iGs+2BG7YMrVB3rK+oZtBSHnnQt8wgk02DCJ8K2h+lCkA9sbS4vS3T?=
 =?us-ascii?Q?9GiNOw8nfc80SSv8IcJIH+fT/0rzdPxpV9KSX/RMGHzBYEKclbFkVVnWbS3q?=
 =?us-ascii?Q?KvPxL/+gWcJqXgfLKIdQFjrsraCWk9hbZ4Mcs4cKqpqwJ4MeIq4CdWAh1PWX?=
 =?us-ascii?Q?tiQBzKNxU+PVJf+7Eq1MeaYnpeHLWl1rTcG/C1sY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b741c72-9f75-40be-3a2b-08dd2fdb2072
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:54.7663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kKWu1sTofuzsxqVH22/W6G+6ZGQHpvkwBjnlpOP8slJpIfYznnfccffMFyIljnLc77rY2vvdkFHYy08PA1Jow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=A6aWP7WG c=1 sm=1 tr=0 ts=677e6758 cx=c_pps
 a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=NfzBEOeHTuBK66BqFZUA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: IVFg3U0L3C9TL2actLAz1vM7fqeQ7dzh
X-Proofpoint-ORIG-GUID: IVFg3U0L3C9TL2actLAz1vM7fqeQ7dzh
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

From: Jagannathan Raman <jag.raman@oracle.com>

Server holds device current device pending state
Use irq masking commands in socket case

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/helpers.c             | 26 +++++++++++
 hw/vfio/pci.c                 | 86 +++++++++++++++++++++++++----------
 hw/vfio/pci.h                 |  2 +
 hw/vfio/user-pci.c            | 63 +++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  2 +
 5 files changed, 156 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index ea3dbfa96d..623634a614 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -72,6 +72,32 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
     vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_mask_single_irq(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
+}
+
+void vfio_unmask_single_irq(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
+}
+
 static inline const char *action_to_str(int action)
 {
     switch (action) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 57ed6f5363..fdb6d033f1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -520,11 +520,30 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
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
+    if (!vfio_set_irq_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+    }
+}
+
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
+    bool new_vec = false;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
@@ -539,6 +558,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             error_report("vfio: Error: event_notifier_init failed");
         }
         vector->use = true;
+        new_vec = true;
         msix_vector_use(pdev, nr);
     }
 
@@ -565,6 +585,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector);
             }
+            new_vec = true;
         }
     }
 
@@ -574,38 +595,35 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      * in use, so we shutdown and incrementally increase them as needed.
      * nr_vectors represents the total number of vectors allocated.
      *
+     * Otherwise, unmask the vector if the vector is already setup (and we can
+     * do so) or send the fd if not.
+     *
      * When dynamic allocation is supported, let the host only allocate
      * and enable a vector when it is in use in guest. nr_vectors represents
      * the upper bound of vectors being enabled (but not all of the ranges
      * is allocated or enabled).
      */
+
     if (resizing) {
         vdev->nr_vectors = nr + 1;
     }
 
     if (!vdev->defer_kvm_irq_routing) {
-        if (vdev->msix->noresize && resizing) {
-            vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
-            ret = vfio_enable_vectors(vdev, true);
-            if (ret) {
-                error_report("vfio: failed to enable vectors, %d", ret);
-            }
-        } else {
-            Error *err = NULL;
-            int32_t fd;
-
-            if (vector->virq >= 0) {
-                fd = event_notifier_get_fd(&vector->kvm_interrupt);
+        if (resizing) {
+            if (vdev->msix->noresize) {
+                vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
+                ret = vfio_enable_vectors(vdev, true);
+                if (ret) {
+                    error_report("vfio: failed to enable vectors, %d", ret);
+                }
             } else {
-                fd = event_notifier_get_fd(&vector->interrupt);
-            }
-
-            if (!vfio_set_irq_signaling(&vdev->vbasedev,
-                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                                        &err)) {
-                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+                set_irq_signalling(&vdev->vbasedev, vector, nr);
             }
+        } else if (vdev->can_mask_msix && !new_vec) {
+            vfio_unmask_single_irq(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   nr);
+        } else {
+            set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
     }
 
@@ -633,6 +651,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
 
+    /* just mask vector if peer supports it */
+    if (vdev->can_mask_msix) {
+        vfio_mask_single_irq(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr);
+        return;
+    }
+
     /*
      * There are still old guests that mask and unmask vectors on every
      * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
@@ -704,7 +728,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
         if (ret) {
             error_report("vfio: failed to enable vectors, %d", ret);
         }
-    } else {
+    } else if (!vdev->can_mask_msix) {
         /*
          * Some communication channels between VF & PF or PF & fw rely on the
          * physical state of the device and expect that enabling MSI-X from the
@@ -721,6 +745,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
         if (ret) {
             error_report("vfio: failed to enable MSI-X, %d", ret);
         }
+    } else {
+        /*
+         * If we can use irq masking, send an invalid fd on vector 0
+         * to enable MSI-X without any vectors enabled.
+         */
+        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
     }
 
     trace_vfio_msix_enable(vdev->vbasedev.name);
@@ -2771,7 +2802,7 @@ bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+    struct vfio_irq_info irq_info;
     int i, ret = -1;
 
     /* Sanity check device */
@@ -2832,8 +2863,17 @@ bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
+    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
+    irq_info.argsz = sizeof(irq_info);
+    ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
+    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
+        vdev->can_mask_msix = true;
+    } else {
+        vdev->can_mask_msix = false;
+    }
 
+    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
+    irq_info.argsz = sizeof(irq_info);
     ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5fe6eb282c..6f024936ea 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -114,6 +114,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
@@ -183,6 +184,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool can_mask_msix;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 5758e1e234..53d230fdd3 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -43,6 +43,62 @@ struct VFIOUserPCIDevice {
     bool no_post;       /* all regions write are sync */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these acceses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -157,6 +213,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_add_capabilities(vdev, errp)) {
         goto out_teardown;
     }
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
 
     if (!vfio_interrupt_setup(vdev, errp)) {
         goto out_teardown;
@@ -209,6 +268,10 @@ static void vfio_user_instance_finalize(Object *obj)
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3a2e3afaaf..593e304ee0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -275,6 +275,8 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
+void vfio_unmask_single_irq(VFIODevice *vbasedev, int index, int irq);
+void vfio_mask_single_irq(VFIODevice *vbasedev, int index, int irq);
 bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                             int action, int fd, Error **errp);
 void vfio_region_write(void *opaque, hwaddr addr,
-- 
2.34.1


