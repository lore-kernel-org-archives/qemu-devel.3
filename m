Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ACAC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n8Z-0000Tb-JV; Wed, 16 Sep 2026 06:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8O-0008QE-AA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8J-0002lW-UT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:44:59 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8K2Ti700459; Wed, 16 Sep 2026 03:44:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=hLA8q5A8Lzbad
 uFj9D065CiadtRTYoD6VhJ5ec0zV+Q=; b=VeyiWCR9qV1iPVk03B3H/NZbOtlLG
 Gf+wada7cDUgq1otRlFlb/tkrFWfethPq0f//suPuKp+aKpOsPapaDFqAg/EmE+i
 cBX26XYXtGcyoi7M80cwrQ1kxgrBMV0rbcfvsN4PehfcrwEXwrGgcnkFSW1NsWjB
 93p8vToIkUQHBr5XSX4/GeW1m6ddQvmOGRREoIXtWlrN1m87VHZVhh85ETVO5DfV
 AFXw/KVvo8RG9kr1GiPHQT7GqP9+/Yw4wNNpAYF+OU66L7Q5a3slr2NAD2kEMSu8
 DYthq6/5DBniSlq3nhluF+PD+NyGNARlsJrnmIVR7/tMnZGRkRhfE7zdQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020116.outbound.protection.outlook.com [52.101.46.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0ka9vd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ/J9jdNcGtBRFWO7H1IhFI1788p0e2neYO8VylFKcD0BWVXEYC64YLDAM9MnbwBuGH1DU6xIu109rQvba//MepnKdO/UjGFv+FIlh6r9l6qVTQlDKvYnj11+OvhLvto9nyArNxsZnm/nVVCVOb30JuZbt51vGjIdxgeJAVBhJKwz/v+XHwEq6kE5dIFusQnCc3JJ4w+hCVIZ1istI7E78RzQfzdlf5vlEwukZDPZ0hAo+PPGFjqOnqCEJPYr2QklvnioRh+1t9Yx8xVh2s91egPpxbrxTlJ8qFH5BZjrdbLk8XnhrsMonfmT4pz8ACEr6dpv1AFnmopKWxrhjDCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLA8q5A8LzbaduFj9D065CiadtRTYoD6VhJ5ec0zV+Q=;
 b=qiHsNw0cGyK5t+WLu3/ROwQksnqrfZnSwM0eu15NnNBFa7iK3PP4tQCVPUyXdxNCP7LYp0Icl3W1QJte0yXK7rl0PcVwyi+15hgBCUsdBHV/O2qQhget57JUn/KGFUF9KfcfW/JkdDf1+3mRJPT7FRgueYBbXPBHGx161qLOLjJl4zmsJ/5ffeAEDsg2fWI9RW++cNt8740VgTqCxVJ0/kmim6YwEChvsq/51SIhSaZ0sWxL1b2OxvjUTN7McRsTrypS3OCEEoa7h9+PSQLAYNciPb0RoKBoi3AK22TIKTsCDk56jVuoZi/GsaKhmKFV24dXYj04wR9NW91y8l5J7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLA8q5A8LzbaduFj9D065CiadtRTYoD6VhJ5ec0zV+Q=;
 b=gAEny682MRqlB4cTP6y2SfQn/Y+VdHrBGhvMbtzaAFB6rqlELxbNr2zA7GejvzrE6aLh0FMrmJUs66S+4KTk86Lm81mQE/K5djUTjW65sHHJuvRymBhKDxLQKzRAp70MqEn+YpvolieZUcq8V/Z0qbQP6OfohRoJjeLPgnDG4+DpR985bWIa6j5aLULMcQHpx6oW6FFxLpPt6R2TyfGH6wngVHQYsU9NHplDlpjXjou85iN5lifsqBv4GxKUeLn6L3kUYGNeQ5++fTJu9XLE9kOHzE9Yb1A4qWWcGmWNJyssVFcRm2Cgqpn264fu8yyMpStRGeNXtuY7z5IszReGpw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7380.namprd02.prod.outlook.com (2603:10b6:303:74::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:44:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:44:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 00/22] i8259: improve qdev PIC modelling (and misc fixes)
Date: Wed, 16 Sep 2026 11:43:28 +0100
Message-ID: <20260916104435.600211-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: a39ed88e-7905-4b64-6596-08df13df81a0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|3023799007|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: xEMUlUKS09Fi8oSGUgelTVFdxo/EBgnxR/z/TOsq9M73QEcA4ZpC6f8NLLasrHuLgSeeyJSGfRylhvnZxl4NVKYUz7fCqukoFpn7AivBjFhJZ/iv2yz8qn1v3WJr8U4GOpQoDNqris70XZONuj55lH4tyDQ06rI0Y27ySUDdNBTT0oQHtXPlw1Paqst1ARviqzRSId36+CmJJ8WWepf0oWNDax22riyGI7v3HFZsOS7fLqDz3KWF2k6cVsIKIOIaifObksZX8o861Ci6ODdwPSgZHZmOrKpSB3iscBrFM5DFLCCN5Sw7gEOaYPXAKPFPp7lwbzhBOUE2f6PLCcm9HQx6K4PjQijvSBjBNQeRtQJrU+omZTLZ+SyGDdDfKS786Eq8P7Cm93F9FJ7UNBXG7+uPWWvfgWOm6lCwESFhR0ifkwQZOJ/89or7F6N2G0WqFWCBziBV00fRb88+KbSEI+w0lZD8QLgzUF+jwQ4qsPcuQ5LO3B9tw5HBLtVDowreS6pOdEKvryzb0iK3ENz6LaPeFmqaWX3m2r36Qb8K9OfCNE2SXSpv9KAXBtBHaK4RypE9u+eLrYHBr9R8PvnYjCIPi2WrnLMYoS/uua49fV291h+XgmIbjp3PRbPOtu4pIWrYbD63Vp6JvuJqH515Q5sHhDmwiYqZgLAHHTCZXfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(3023799007)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxn6jA6Ficqii3+2Gh4dDVPr/Ri1eEfTGbMYD068absw0vWY+moBcdtUYyi/?=
 =?us-ascii?Q?IKkXlelfCHsqkej5pwCONU+io2/dHagZQ/ntfY430vISNIPHn2zrxfQ/CeOB?=
 =?us-ascii?Q?k6gdKylsPk9SfYSZ7Dr3MDwmo4bSXQQB6kIZvgLeGnF5z215uNj+ZLKN83Hu?=
 =?us-ascii?Q?X2MBZxSvyFVUdE1Ng7NXoYA2RU7SW0Starmha39ucP/93vXNlxPp4QErUG5l?=
 =?us-ascii?Q?nH8oUGUKEs/litMrdqrOYdzy0oKQVaus8cY/ULALeNsTeo6dUMS0vN74sVls?=
 =?us-ascii?Q?SU7DHOR8J2ylwxj+C2P8UBHJXJWJvj/I8EolB+OqQ23Nhlh7BZyZ7LJ4uu/a?=
 =?us-ascii?Q?baafEMxXxKEqOIFkDlGCjkfxvO18Z/pld+404xy+7fFLPJeyc2rUGDXGmf+h?=
 =?us-ascii?Q?HgcyYsZYF3RlY26hR3jTmhgrx7MOR/0EUBJl0z2fnDXdnezIelTx2zieDc4p?=
 =?us-ascii?Q?geRv3qevLsfvodREvQVOd45ni2jlv3y8ih92novyfmgqZp5rTNefKXN2GLPK?=
 =?us-ascii?Q?3Jny56AMhsLsdDKx8Z+EDIclZ854zYckCpaHdun/SR91pJPU94Ns1FsVKHiL?=
 =?us-ascii?Q?3q3bw233SJnUBiLCL+GRut1ahlsIxWnyc7F2qSrcx/xmAoUxbDg30W+aaX9r?=
 =?us-ascii?Q?JLpK00mRabS3KDypFRhtIili7AUMWqrDY2ziNea16ekKhT6g4y0PmJhTQ3mW?=
 =?us-ascii?Q?VBOjQDjhZKUIxtI8Q/x56jow25SkaQwRCavoDvsxjKk4Zr4Sg1R8JzGyWAvi?=
 =?us-ascii?Q?+jCeEoQCrmgayHfjDs0HpdmCu1p0sYsxSenJ9QtQglF5N9nSbe/Ujsx7eXYC?=
 =?us-ascii?Q?EcZpqfBf+9pkJ8dtayES9nakJxc2AiLemm8rEwzZzTfMzkl/utjWqN93Z3rH?=
 =?us-ascii?Q?gFZZpXtvf9CdGmqfBnTf1j0smQsZX3zS/KI6FgaewSVZHwyoULPT+axk0dNI?=
 =?us-ascii?Q?MUxEV5w5fJtaaiwpNGcl5jbK0HbQSqVQsTcHi5cbnEDq+w2Ru3QA7mDxbaDy?=
 =?us-ascii?Q?sdi6ij62dudvCXizSRhNXX/DDKZfYKIebSAb48faRcEo7tTNttrvS9zNqcfo?=
 =?us-ascii?Q?GXDSOvg1yGCCSmtZ/+DBahjvRV3SERqNEuUHdTyZ5Tn9OJ1bu7fi/DBR+chF?=
 =?us-ascii?Q?A6NS4Yec6NaO9lAt3nWutHgUTxPo3OWYHzzh7spfox9x1j+z7Ae+JX5O61Zz?=
 =?us-ascii?Q?4reEJ3lNd73AOGXG9YtPMniHmdAMoVRcpj9Ibpu4LdZdWXUmBAy0nWZz79Oy?=
 =?us-ascii?Q?l6t2LQYQltRZs6j/YRXhyYi0YBydgSudZJAq8z5BcUS9Zja6Zfs8IbAYeuFs?=
 =?us-ascii?Q?dry9t+2iGtBJA0UrFloknIUEz8wVt6h+uB6m3EkGrIvj3NlVkwUC04VYZu+z?=
 =?us-ascii?Q?nWm+T4/AlEr70yKAIZliaBwKY+izfYMOhfaVF6+CoJ3KtB7sXw8gcGCdDMSg?=
 =?us-ascii?Q?D2vlSn4BcNcdD6oMNyzqQVmbB96j4vCzaTYiH65MLDxNFIL0Wyf+Dj8TaZp3?=
 =?us-ascii?Q?4GF+VbTkhCnbISvsFpZ0wBPWbaREPcRqpXLIPMLYdUrNjejpiPBm2ryDZIy6?=
 =?us-ascii?Q?LwTG2tMO1siG9jMCa9mZ9BMBlC3rb9cFsELCI8enJB9JFF+5PgooWp7e8ZYO?=
 =?us-ascii?Q?7qQ1i9iJvQYw+gw4DOU7KCYJxFvfzMg1Dql80X316EnjmMpEk7lSmJmyaCd3?=
 =?us-ascii?Q?cWP/PahIIo0psUQ+mJoPiwU0cIJWpHxA+koulP44GpGe0qHiUxuHpxNYPyQ6?=
 =?us-ascii?Q?Ed9w4SoWYyTLYdVhiIi5OPTzmbXb8/s=3D?=
X-Exchange-RoutingPolicyChecked: JGYZitA6ZpN1yi+QqSMuGpKesUWLni9uFZTF/7ytQ2tQ+3nvd/vsXBLlIskIb5N1ls3m2LEJdJwzgZPljUyp96h9sT0AC34d32W8lkZ72aFNW0SMoO0iPU9s3WmVY1iqPFTR0FpQFYJTLibmvq6ePuJv+9+wA3zqJLuESJTWxB4ho/fK94cvQ6w09sw/zV4ppWntmHaaMS8K5jMfu5yna7rtYcvYxMa4BYUgPJDJ51b/ycAAk44VzUc6e35BYD7gnaV2ISUPe3mJLbIooZPNUP7XdZt/6UEJz9c9lxNDezigIJkLvp6OMihKMm8YBaczOBUdbEJTagk0TiXb/2O34g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39ed88e-7905-4b64-6596-08df13df81a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:44:38.4124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9DcCIDn4npznu9mXabTvPGNxL1Gpgf4RUmTV4zK3rxGqQtKDkqDVm/zPLLFsBFO5ud7jMfNnagaya6cxZ20fg4C1qyLvV1Tww6bT7r2fR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7380
X-Proofpoint-GUID: 1lDE_YNnNDioHLOJ3YhAgBbWtaMmOzf8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX9p82a9rleULP
 gowk172ty9k3Ph9wvDSxbyj3nL3hZqKvYKBZsrMzMYvauNqyhf/WKcRzHTPFeqTyOO6edHKv/ai
 C5JkxN1otK1umUCUj0rNNnIjRdQ22gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX+tzN5JuddDFY
 qgHcH+VKURNlC/h29Kdtn7gssh0iCzR7R9CzFIAeUQP3ymKS0D1ZTNfoMqNoWGp1D/Keu4JG1dU
 YzRHA03msSJXEAhSvPjXtP9md/yJVSw7rFsg5ypp9J0/EumZS9zIHgsVRIQ5JZ+W9upCTdhpjQl
 QPC3LjDT2jTikmgb4kBm2TY30fkUgmXS2wmGPl2BuofI1IwyGXcVDq/zwlu62lsLDvWogRFThUm
 etzp+ZIJkucglmbkoG9gqSIoCm5FjW+mYaQ9Hc5JxWzLlb7WvXQJH7Ytsq0s5rMOwnUS8sWI8O4
 xjTdb+GnT/lozRgFMvnO+kpS1ieDW9EmHr1gm1kGINF0HPCO8EU5FML9mBcc152kGbttUS0XkvP
 tvaszvC5tw4TAzW2HFcObjwt5NTMqD7BpnGj/oWoyMaLk+Sa6VGli0fxPSiDcMo73MukvtsOFSm
 OHdBczd7q7vta7DjBRQ==
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6aaa7317 cx=c_pps
 a=ouQKzlSDvkUBIcrmkWtKoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=B-xQ1axTSFxXRe3sjz8A:9
X-Proofpoint-ORIG-GUID: 1lDE_YNnNDioHLOJ3YhAgBbWtaMmOzf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This series attempts to improve the modelling of legacy x86 PICs within
QEMU. The initial aim was to have a qdev device with one output gpio, and
16 input gpios representing the legacy IRQ lines, however as I went about
trying to model this, I found a number of other inconsistencies/bugs: in
particular there seemed to be some fuzziness around the functionality that
belongs to an individual i8259 chip, and a cascaded i8259 configuration.

For the purposes of this patch an i8259 device is considered to be a single
i8259 chip whilst a PIC device is considered to be either a cascaded i8259
configuration (emulated/KVM) or standalone device (Xen) representing the set
of 16 legacy IRQs and a single output IRQ.

Due to the updated device names, there is currently one visible change in
the HMP monitor output for "info irq" where the isa-i8259 device now appears
as isa-i8259-pic and the kvm-i8259 device appears as kvm-i8259-pic (see
patch 19).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (22):
  i8259_internal.h: rename PIC_COMMON to I8259_COMMON
  i8259_internal.h: rename TYPE_I8259_COMMON to i8259-common
  i8259_internal.h: rename PICCommonState to I8259CommonState
  i8259_internal.h: rename PICCommonClass to I8259CommonClass
  i8259.c: move parent_realize from PICClass to I8259CommonClass
  kvm/i8259.c: move parent_realize from KVMPICClass to I8259CommonClass
  i8259_common.c: use i8259/i8259_common prefix for functions
  i8259.c: use i8259 prefix for functions
  kvm/i8259.c: use kvm_i8259 prefix for functions
  i8259_common.c: convert to use DEFINE_TYPES() macro
  i8259.c: convert to use DEFINE_TYPES() macro
  kvm/i8259.c: convert to use DEFINE_TYPES() macro
  i8259.c: introduce TYPE_I8259_PIC device
  i8259.c: properly cascade secondary i8259 from primary i8259
  kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
  xen-hvm.c: rename xen_interrupt_controller_init() to xen_i8259_init()
  xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
  i8259_common.c: remove unused i8259_init_chip() function
  i8259: move InterruptStatsProviderClass get_statistics() from i8259 to
    PIC
  i8259.c: switch isa_pic from I8259CommonState to I8259PICState
  i8259_common.c: remove static irq_count and irq_level variables
  i8259_common.c: add missing 0x prefixes to "info pic" output

 include/hw/intc/i8259.h         |  12 +-
 include/hw/isa/i8259_internal.h |  21 ++-
 include/hw/xen/xen.h            |   2 +-
 hw/i386/kvm/i8259.c             | 167 +++++++++++++----
 hw/i386/pc.c                    |   2 +-
 hw/i386/xen/xen-hvm.c           |  40 +++-
 hw/intc/i8259.c                 | 322 +++++++++++++++++++++-----------
 hw/intc/i8259_common.c          | 171 ++++++++---------
 stubs/xen-hw-stub.c             |   2 +-
 9 files changed, 477 insertions(+), 262 deletions(-)

-- 
2.43.0


