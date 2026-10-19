Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03968CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm93-00029Z-Kl; Mon, 19 Oct 2026 08:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8x-00020H-BY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:07:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8u-0004I7-Q1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:07:07 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OqJN1634761; Mon, 19 Oct 2026 05:06:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4jl31NceyHhCzS5Gylgxsc0CneyACA8P9yuxjR+0T
 aU=; b=X3a+lbaaOHqOsdDMRq2cdo83uMJim+QbWNZVvxd2lQPbFTMLFbTKz/G6e
 Ado9rW9fi6+V4KCZ6tFdM4pTf5xcaUg9R6RPJ78ZWjyCa5GqNfZgmMGcyKsBDrLv
 6QcuOdlkTAjE42Fqc03MZqnNpki+13EknYewMIh5FEmftgb+C/J3kh3OsRgHMgiL
 E/2aicUahqOrh9u/ULdv1sKfyAY7/WjvPdgjWQx9PmIVyOpk2HmqTH7jq8VW/mED
 3+BKdnDafqhooKrF3B0/rRtW9edGaNmFdTj/34btG2swwH/RETwchmtnKcCygav+
 aFY4BlPqS7tMbTZGt7ccUzKAWYJmg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020079.outbound.protection.outlook.com
 [52.101.193.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8bckgd5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebi9EbwD5RpopBlMHgVJyyYG1vknUwzNMqLwldAl4n+bVe5Ycs97syLENPULFdpBd3fY5lgHWOQ2CSdp3MhktsSdjA0RiJRcKVUooAarknrKg1nKoUuTboglbpsEh5uB8yN4zJyEFHT2C4AALSeag0KKe8i29yzrFGFCjOEYJpzc0o2pjSuCR2/zkvailEgApi0KH60YSPlrSKh3La0V1a+MUDfkDgUEQK0I72ixkxBaZbqYS++CkC0yxgicI9e5gyIMjHvDxBpbn/9Cazoee565Qs05wLsi9B5pEX1HrCkJpyKtpA3t+5lus4/rwh7CzMN+wwlNBRWVtRU7tcp+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jl31NceyHhCzS5Gylgxsc0CneyACA8P9yuxjR+0TaU=;
 b=CuqUl0qnj5yaQTYC4oMOW4ulZij/5ehNe5YBjGw9T2G+bQ6juggY4IaOBIr6hN/awyzCVkkxMHKdehWQwUFeLFscJkkPYh7fgptk61jUE3EIK2yMjrwIbHlB5U7ZPfJ4ErqsfyqA3Nr/rtWcolrB8roH5UwrWV+9ixU9kmea8GwxWfxmb/bxCuQWTXH/tzV8BTWsiGimJHpUCmi0W14QArSuSeKBVH80voEsHmM8bpRFmwvKI5eJqJ/S3zEgRFqoeo9jMVBTflVvwfdA7qPSHW8rD+h0+5CtG06Mo/Wkb6Qh6aTx321YZBNs0Ih8C/7LJ6XMDWBJxkvCLJVtqrn+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jl31NceyHhCzS5Gylgxsc0CneyACA8P9yuxjR+0TaU=;
 b=U5U92foy9ZqgM7uFe3qPyL8Z0Tx4DLVNsx9FXb23LHYGfBEkcSQgkQSjoOlwEa1cQyCBjkc8VUchob+8fCI0H7+/YiImFahAhRcE3xxoBxF6rWtFPdr9dJxplgXOMapq2wbrArebtWbE8wqPU+3u7oc8dIIGdvhaxpDXSbPrB2uqSATtRKzOkV+cwXAgwcHov1o8DABh3STBt2qX1gjE4VyEqtmQ6EHGatvmghXPUWt0WN3a6ZBe4leClUa2mmUZClaIlwGDroxLWKqYA/kTHx0jRVG1t8qP/bCexvbs97/gtOXlrNc8XNLRDWmHCM6GL1O7x36bh0YZXMNllOiU2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:48 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:48 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 27/28] i8259_common.c: remove static irq_count and
 irq_level variables
Date: Mon, 19 Oct 2026 13:04:59 +0100
Message-ID: <20261019120517.1448687-28-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3858fc-8323-4d1a-b15a-08df2dd97383
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 8/W8vhzQR662qw3wj4MwSTY6gejtZ+jOHJsEwyKUHYcL1C9IK0I5XWjTH/R8r285gzbvK2LEazUZZcKzmz1NxchJorqxThQJHY7IEqnTzNco4+1p+T/aDvnJtDqJA0nLW1gKZwNXCK+pO+8DpEWCbKOmJ1Lq4Nsbv52Jz5qX1KxzEtvpSxVUZFgxjT2AkOGngP5De5Q1sj06C3vHD/9l6DOxrI7aM8eUyPzj6Bt0+vGQmiOfz0GpaTBdLDWwPXze9AQlrvpwrhFmuloH/bbiCTStlfc5oPUjcjOIttRhSEHkczrdtco6N74VVoufxqmxZN+baaAzMT4/8PU9vJ+BOGq6583DP9mX0HoHVI0M+JHMhac9rt6AgtoFnfYT+asTc+XzVM0MNP4OGnihJJoSAee+4LRwruQbu7ay641rb+X0+fyi50Eg4jEo5MqDz+1BI7ilhlSb76+Ah6IURcy0YHp/jDoQVODpUlAM4Wju4nhPllD9/sRTMR8h6Q+hfdVlokt5gn0XZerhrS2uJ8hZQ8JqA2zpsDnNwwESB7Oo2ABRWLeeJfd6VlusnEtH/xymv8D0P9UealLpvCqX9G2lHe8OmvSD4NytkyPO7iwTaaw0kh8PNQKC9hC5WYI3DuSBQcbBCb065eqAebniqhJv0z8bIHSTaXagY+xVTzXLiyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2kKcxjp2qYOp3appwYVzTx11dyyAG6e054id0xxVc1Lux+q4Ieegyf+vJhnx?=
 =?us-ascii?Q?k650k2kU8V6wNXwDHb1Ahryq246+fE0TP8t+Ou1ktE9q9e9oQu9pEuxxbCnG?=
 =?us-ascii?Q?kI3IQw8CEQKe9k7WEq2OMQlkKaN+mwuVSGBN99HR8XOsEeujPL0CwPKqVaHs?=
 =?us-ascii?Q?izkwOiyv97YhxKJwIHysXrVbhTFByC4w6asUVO2T6OvJXeMBgYiHnlHuVfl7?=
 =?us-ascii?Q?Db9SyyHMH8IfeOweefBKTROhyU4MHxiEF/qgoj7U+OJ3T6qgLEexbbACsp8N?=
 =?us-ascii?Q?ukdrnhQU+AgVzmYwq7dj9d7WcCqDZvbjlJJajwFwOV2cJkJ+JWTiaOp+QoJe?=
 =?us-ascii?Q?T3IaKv/UjmRth33Ol1c7XrsVVlKDkAdUompcBO07oME7W1o5V/S/5071RSEh?=
 =?us-ascii?Q?1YdbwnTdaueEbWPCdvOcWH/Ht0xSbuK8s6MXIL70wswZX0gLLs3RU5WwK6LZ?=
 =?us-ascii?Q?deE1CYBhR//sGsy4voawE6u21HJNFk/Ud9DHDI9JcMkjxnlnMgVbbp2Obr+l?=
 =?us-ascii?Q?hK5fVY59oz4RCNJE4JCPTZQgCYnKg1WEbNQUH/LOMtNrFjn1Kz6y5rzBeqTg?=
 =?us-ascii?Q?FdhW6GUvzAonvlX+J9IglnXtbxYldXE0MbO2d0feRcdu7+IUbhwrYEEJH5Sj?=
 =?us-ascii?Q?WXIw19+yRqtVZAJYS0tWXqHx/u6Ja+tHVv3N9OTpSivVkZOyLAgn6wKfJ4OI?=
 =?us-ascii?Q?8vwhsqM1skxYuzn6FFxQCEIpcDyQrNwbwMa8K7swPR8TcnG/d9w5xYma/x19?=
 =?us-ascii?Q?MEKWqBA/k9ciGuIvUJna67+OF7+k2WBWBiDxwZWJdd4BdznZuvhTkxozkYsj?=
 =?us-ascii?Q?BemDFijgk5ekfuzPW81LAotDyKRV/GwME8kXc7cDjHZd8yLPDrcOZv+AVKPs?=
 =?us-ascii?Q?6BEntKin6tdJKScAIfxA4SEodhL7hESxucyLzL4q8G4Ss5OGD83ZTpl/QUzK?=
 =?us-ascii?Q?YF0wycPdpYQQj0HsAPh6sz8XkjcqWebsWxwQRHy/loLlMLGE4uybjOaMmgYP?=
 =?us-ascii?Q?3wgTdSN6qwB4psOrYbceuGSruchO7WMvhqowjXbRjq7aFbg8fIdZLW71DDzS?=
 =?us-ascii?Q?7Cp6eNv9rWsoV1Er29o7lAE640/H7+ibX2Gx8+EkrxsuTxxvV4Hq29K7xg9z?=
 =?us-ascii?Q?GHPF7vvYlr3H3EwBIfAQfLspRXZsZVEr8lzQVKPOkwZHW7y/9j7kQoZjglg6?=
 =?us-ascii?Q?51HxJ1gNUPOj0JqSyV0RAHcFg8o73cnwkyeozjzUURrz+VHh0Qo4UQ32SNOc?=
 =?us-ascii?Q?afzOX+oDzbxlLokKRFvC+fc/7abbsl5uL2LDeQeWqS3M8Vf32dXNBFNKvRAO?=
 =?us-ascii?Q?mhMAhfBXNRXFl3qO9KwtNDtpze8ykQma+9p+GU47Hr0a8YUAbdmtJeeM/ImB?=
 =?us-ascii?Q?HKkErHKM9/2siX7Cb6sa3Xuen342sD9ni0tzEDH7Zgz4xnZdklOyxdlMoDqd?=
 =?us-ascii?Q?SUf5t6pgM11c0caureFKBLQ3hJd5d/ekmppD1GKmcpKmDl03o62Km+13oT0U?=
 =?us-ascii?Q?jqYQvoEdTqfHk4+2t5hZNxNEd1WyUmKXoRAA2ZgtqzJn4fFnN8bGRymoiHwK?=
 =?us-ascii?Q?rZyKOnWMNuCs8p78PoGZrNxufxTNqEFTlRS6jRnadAeKh7YlfCCOUVI7xlwZ?=
 =?us-ascii?Q?g58RogVTF8/oEFeGRqN3vYFK4z4WZwNOAc06ptW1Wh0tZXFZwXRb+mEP2tA3?=
 =?us-ascii?Q?To0JK8W0KoNFYF1XyXYfKqf4i/X6DpUmGlpSX8XgIccimZRmzLusMYVFOnOg?=
 =?us-ascii?Q?1dVcrDZ8PnWW6nRgpHHtGEQkW0zD+yg=3D?=
X-Exchange-RoutingPolicyChecked: wB7qyxuyeVgT84a9gsn/SwFSfqhgg71ue9Df/EZD0Ua7GK8yd0JsulEDq7k5J82I7ChKxRvgcAFiV2mijJ8TfXlQOxT+2brxZQk3tHzD5OM0/8LqQiU2pyHd7dmcJc5JB7yQ6CpSodfaab12qiiJkDbEO0mgudEGr0ONpHjl8AybnUcT95IHdBMMupdTkcLwcWYO1WKwzCyZBTBfG1CSNbD1u6knzcPwvX3yGdRt0f+q36yEH6PutKH1ofCX5bHAHD6+gk0BOg4fRCdNxnFYkzkLalT3ra0MUFMvGYlNOapV3WRYenpFUD6yto1gQ4NUfmbyCwC7AdxIQwf/OKbYuw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3858fc-8323-4d1a-b15a-08df2dd97383
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:48.1183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUYUc5VSmhyHELOkDXTFaggCo/mm+E55VzyRK5auerniXZYxB94MafNtGwoM1dM8ZXTqDP7NLtZg+R0ElJGAewo5j+/0DRGqP+0NbmDG0Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXy+W//cV7XCfs
 KEJRWeojHqfdzKrv/ksdYuOXmdSVe3Qe8hhHHz5AibWVGugeAqcqkGc8rSN9z+u+td8D6+xSsAV
 tw+5jwlkhophCU7qPLlAhovjGWrWcs4=
X-Proofpoint-GUID: NkeXy2_I8x0v5qhZFd0Ja9RMaoOLZpTB
X-Authority-Analysis: v=2.4 cv=V8joQuni c=1 sm=1 tr=0 ts=6ad607d9 cx=c_pps
 a=eu25Gv8CuaBvrl3+j+Cigg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m9Rx451XjQ6kX_1OFlEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NkeXy2_I8x0v5qhZFd0Ja9RMaoOLZpTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXyuBDJXKJkBUZ
 tnexKbRFnkxBmrdLZf04t2TlwTjrj34LFU91IF9mj0gzbjyK4O7Q2SUFhqN0wYsCs//PQWvCh97
 /EfVTjiNrJG6x6baameeq+OYuBojHkJXwwpMrs0456NgtxfBoh1UzHpGDuA/HT3PPuXY6M0/PWW
 5k8h69P9YZ5Dkoj56iYbxydVaSTJD1x9dAimK3f+92Om2t28FV1Qith9UEw+NBfZB45RYGJ2vD5
 9lOl71ab1mYNpBMdrQVpCS6HTH5AhNEDhrteOmNFR39NFRI53p675UfDRoQnuxCZtDPZ5cexlaW
 rkFIX2sqP6KjViwAjn+erxseom3lg2rlNSJ1avHsiebM0wGzEtQBZX8gtq9ovjpyh92e4hKN2RS
 z5DUKqf77e8oQ5Xy7SrW1e3C7vDFE5zNJbt1oNM1Ugf7hczAhAhqBaqPkGLYIqGdNK0GhCJwe1A
 dltEQlxYOinIKZXArMA==
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

Adjust the parameters to i8259_stat_update_irq() to allow passing in pointers
to the irq_count and irq_level arrays, and then move the arrays into the
corresponding i8259 PIC and KVM PIC devices.

Doing this allows the statistics capture logic in i8259_set_irq() that handles
incoming cascading interrupts to be removed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h         |  3 ---
 include/hw/isa/i8259_internal.h |  3 ++-
 hw/i386/kvm/i8259.c             | 20 +++++++++++++++--
 hw/intc/i8259.c                 | 40 ++++++++++++++++++++++-----------
 hw/intc/i8259_common.c          | 21 +++++------------
 5 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 4922f88d5b..42d6f992ac 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -20,9 +20,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259PICState *s);
 int pic_read_irq(I8259PICState *s);
-bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
-                              uint64_t **irq_counts,
-                              unsigned int *nb_irqs);
 void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 2807409eff..e0002843a1 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -70,6 +70,7 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *cs);
-void i8259_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(uint64_t *irq_levels, int *irq_counts,
+                           int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 8cea5fb12b..bf5ae334b9 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -45,6 +45,9 @@ struct KVMI8259PICState {
 
     ISABus *isabus;
     KVMI8259State i8259[2];
+
+    int irq_level[ISA_NUM_IRQS];
+    uint64_t irq_count[ISA_NUM_IRQS];
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
@@ -117,6 +120,18 @@ static void kvm_i8259_put(I8259CommonState *cs)
     }
 }
 
+static bool kvm_i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                                         uint64_t **irq_counts,
+                                         unsigned int *nb_irqs)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(obj);
+
+    *irq_counts = s->irq_count;
+    *nb_irqs = ARRAY_SIZE(s->irq_count);
+
+    return true;
+}
+
 static void kvm_i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
@@ -129,9 +144,10 @@ static void kvm_i8259_reset(DeviceState *dev)
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
+    KVMI8259PICState *s = opaque;
     int delivered;
 
-    i8259_stat_update_irq(irq, level);
+    i8259_stat_update_irq(s->irq_count, s->irq_level, irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
@@ -227,7 +243,7 @@ static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
-    ic->get_statistics = i8259_pic_get_statistics;
+    ic->get_statistics = kvm_i8259_pic_get_statistics;
     ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index b59e26cbc6..79b5e603bc 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -64,14 +64,16 @@ struct I8259PICState {
     ISABus *isabus;
     IRQState i8259_primary_out_irq;
     I8259State i8259[2];
+
+    int irq_level[ISA_NUM_IRQS];
+    uint64_t irq_count[ISA_NUM_IRQS];
+#ifdef DEBUG_IRQ_LATENCY
+    int64_t irq_time[ISA_NUM_IRQS];
+#endif
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
 
-
-#ifdef DEBUG_IRQ_LATENCY
-static int64_t irq_time[16];
-#endif
 I8259PICState *isa_pic;
 
 /* return the highest priority found in mask (highest = smallest
@@ -138,16 +140,8 @@ static void i8259_set_irq(void *opaque, int irq, int level)
 {
     I8259CommonState *cs = opaque;
     int mask = 1 << irq;
-    int irq_index = cs->master ? irq : irq + 8;
 
     trace_i8259_set_irq(cs->master, irq, level);
-    i8259_stat_update_irq(irq_index, level);
-
-#ifdef DEBUG_IRQ_LATENCY
-    if (level) {
-        irq_time[irq_index] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-#endif
 
     if (cs->ltim || (cs->elcr & mask)) {
         /* level triggered */
@@ -224,7 +218,7 @@ int pic_read_irq(I8259PICState *s)
     printf("IRQ%d latency=%0.3fus\n",
            irq,
            (double)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
-                    irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
+                    s->irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
 #endif
 
     trace_pic_interrupt(irq, intno);
@@ -456,10 +450,30 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 }
 
 
+static bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                                     uint64_t **irq_counts,
+                                     unsigned int *nb_irqs)
+{
+    I8259PICState *s = I8259_PIC(obj);
+
+    *irq_counts = s->irq_count;
+    *nb_irqs = ARRAY_SIZE(s->irq_count);
+
+    return true;
+}
+
 static void i8259_pic_set_irq(void *opaque, int n, int level)
 {
     I8259PICState *s = opaque;
 
+    i8259_stat_update_irq(s->irq_count, s->irq_level, n, level);
+
+#ifdef DEBUG_IRQ_LATENCY
+    if (level) {
+        s->irq_time[n] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+#endif
+
     qemu_set_irq(s->pass_irqs[n], level);
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 684290fb2d..3bafd81ea7 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -30,8 +30,6 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
-static int irq_level[16];
-static uint64_t irq_count[16];
 
 void i8259_common_reset(I8259CommonState *cs)
 {
@@ -89,26 +87,17 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
-void i8259_stat_update_irq(int irq, int level)
+void i8259_stat_update_irq(uint64_t *irq_counts, int *irq_levels,
+                           int irq, int level)
 {
-    if (level != irq_level[irq]) {
-        irq_level[irq] = level;
+    if (level != irq_levels[irq]) {
+        irq_levels[irq] = level;
         if (level == 1) {
-            irq_count[irq]++;
+            irq_counts[irq]++;
         }
     }
 }
 
-bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
-                              uint64_t **irq_counts,
-                              unsigned int *nb_irqs)
-{
-    *irq_counts = irq_count;
-    *nb_irqs = ARRAY_SIZE(irq_count);
-
-    return true;
-}
-
 void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     /* No information for i8259-based PICs */
-- 
2.43.0


