Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07D1C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVu-0001Dg-Fu; Wed, 19 Aug 2026 09:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVs-0001BA-DH; Wed, 19 Aug 2026 09:39:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVq-0000o3-Lz; Wed, 19 Aug 2026 09:39:28 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCoeSa144596; Wed, 19 Aug 2026 06:39:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=XsfX9HMem+XN0yIJxO4fAMcS7X5ayxJW4uIqdPean
 9s=; b=VJqT9Bduy8Lg8hdyYgF+8B6G4pkHloOtXqQne2bKEvumS1S8zUa44MtVf
 lZXhZZxftNzZ8pBIzRpLrOBXWNSH3yhl5rP7lDL+VzUjCRs6aF5VlI0pvns20xHD
 0450GEkxrVS763xCag1F2Sok0vS6sp3FpihPDMNDyUhLK5hknNaZ9SAAJrXb1CM6
 fQp3kJNbU67WpQvzQ60VYu/VFVFBLVeJSYVQT0BapkUtpe9E3oY2aj6ROILTkRR6
 eUkAYEBPjr4YdpZtS5b3UBn+myc0uBdXuySv5PkrfCObDXgUSke5BRvhIAk/j9d9
 8JsuNWubc1GCzrghpbYmrVmoZ3YfQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020080.outbound.protection.outlook.com [52.101.201.80])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4uw5jqxj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmvhRKKzEDbC/0bos8JNYMN6//JFVdhYc0Db5eGCDAHFi/phXFLdAJz1kudYalfbF40kGoY38xc/iXLmmspmlEheHEyCeRkad7XXOW9aQO149oVPwpg4QheODC2WGScrFnNzYjrrXntx4kFDwMksfjP1fP4LpYIdLJjyCJ0crVbXUb0baq66naiu+t/EDq3qb8rlnMjSq3ZLEHbUiDF1t+0rkDkbYs2bvF17gElKHJhkzSj2LL4K5a1EELfZG9bNMBFUEaYxrEIKXuiFEcOQUuCAfhdl8XCXEE4tqWrcGu20YqoGZgyJ/Y52EwPOIw/RRmZdu/9/Q8VWvTONyVQLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsfX9HMem+XN0yIJxO4fAMcS7X5ayxJW4uIqdPean9s=;
 b=buC9Ef2/CjWubXzoYzqrOZj1lbZOnhIWuRxcBLki3f9gJ8ySi4B8EY+II23ymX74t6QR7eZsmDNHq3QRGS1xOjfgbWsMyxD2xUGU5SwzNaGjC5iDzFaYzdWLygg4UsboXOnCUYbJ5U5pxQgTHfthk7CBYkrNtRLAULIeFPYmr0/Sw4JnfsUovj3mZp3HWn0u/qoawC5n9q+DrIppicL1f6fnl7XYHL2JGvkV/upmawo0jS604aIOcwZ2IGpU/UCdsauIQeaBgpbW7r/wpr2P901ymptGbad0Bdng87xx5zskIecB8GrVoJU3R7AYgntGkg+shS48xX59oaz3toWn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsfX9HMem+XN0yIJxO4fAMcS7X5ayxJW4uIqdPean9s=;
 b=c7fahplfGtjkK8T7YMorl0ECMcyB9m6LK1HlXcg6io75WlX7g3EeG2yTYVNGOSjeXtlvmVBud6YsATnmMrrLij3NumiYo3wZGSLxtAO6OL3uUNjGdL5WFVaefJ0McxWbhjMGuOOJ4husXZv6qAlGa1rtB4ad/2tG8WCIchnWWu8vlUt+HfqgnjN1rvbwnnEBgK3vBraEDUHr8dYUt0w6qSkxuHuTO92WPeNPAuVJLjodbpgn4ZskqYGp3APHbv5kYrRdKueaUVqNy/oInI6azq57zWGzNsi9rFPvw6oyZEI76V5sPhU0z4wTvJGtj8zvA6ASxpDr2cCJt0iAfg3AVg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB10159.namprd02.prod.outlook.com (2603:10b6:510:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:39:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:39:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 15/15] hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to
 a class prop
Date: Wed, 19 Aug 2026 14:35:54 +0100
Message-ID: <20260819133816.3497033-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:130::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB10159:EE_
X-MS-Office365-Filtering-Correlation-Id: 0112a372-6fff-4947-d1dd-08defdf741df
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PsLOy1wX1AQx2ROqQJvTHMnKcnd01GNHVKhVPf7+j0dwEA8fES/6MGtb29oDoeZQYmpDKVOPi25BhL0tpIKi+y5SmM2hHDL6UKjL2Xqr5dKzx6DLqOKr+yeOw+MAkJmh1Php+2C7/T1LXHADT4SZ9mzF4QFVBMXTPoyLIsU5+4EALbBEq4S09hKzPaxiOF6HtikpM6RZ7F+HRbGql7QP1iicKG+eAmN3c70ae2gOe2bsJ7tmquK3rjs3jendSAf7AkwvZCFJ6se2kEGgWkb4Obckj9gZZArl1ZV6WxGcAw5LzmOdmSjX/SjXYqxFGGZQosidrAktfgVhIOoei5CoHENuVg9yk/Ena8KjK0g34FLA3rgqZsqEqK9/7o0nEzF5LgPOnmPqAh3EUE03BOwgCy7wwKAFMUGV91qiOxZlhMaAmYMIWORvtoV1WgIsvSot7yRunAgYK9EQbK9HFVHigSNmgUfkIMZQ0nRqi3E2cUW0XmGa82fmfrf/tZwyItjZvje0ky09F5V5VxbTnJuu50NVUJMpVUxVZzBz4W2KJbLCWOk5GM3FqsRgHV8wcRXJadvybmdmH0hxPKO05DW/QBPIW8219AtwPYQu6DgKlJiwmAaoaDeGHmVgyneXkzpZLoaU7H9TaA8QLtVpzLgDp0drHUYqhAJbjb0QEJzOZcxU8mg/PAR7WdsfCLwKuyUfgG1QJ5gRBa11HphKjj3BcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SWtUMkT01R38ntUM40LZqIpAXKLDbIObyfeo5SCSQk513JW9QalbLcUFrzVy?=
 =?us-ascii?Q?QJWlGcOO7HMn8+KvLqdfOhLfN7GAk5ylXIu24M9V0JTetzyQIie1Ir+JKnKo?=
 =?us-ascii?Q?8B/CZJb9lb1hJdpO8EII4XM3Q4/vCRv3o1geM/fuDkioUkDlftM2ORAC25kE?=
 =?us-ascii?Q?y6aEyi/0Auf1uy6a6CgDz7fV12e68ct70V/xyvg8hpop2+rzKdtnPe/4j/td?=
 =?us-ascii?Q?XJp3IExVYCGI5dr/H3BOyr6lZ16WLW/P6Rtlr/Uyfyl5FkY1ty1QS87rleyv?=
 =?us-ascii?Q?GPa5bLlcYeJuWI/9U6ssD6LALPrrbSSdLTHsy/s8ZqInNe13TeUrnu0rDqwq?=
 =?us-ascii?Q?hsMlbhA7NwCtYMBF2zgv6YfdYh2atLDEWncVIAfQgCXyVg8XnyppsECw1882?=
 =?us-ascii?Q?OFUcuzXwcUYEtmPK78+YVM8DaPCWyLEu1mDusElizJrhoq902j7+z8br6G1Y?=
 =?us-ascii?Q?ciJd+IvyCHt6WtCx8Jb8PwnSXJ5xowNC1sgKEYoA1y+wYokMbjgyzMhv98py?=
 =?us-ascii?Q?PnThwz0Ue0PkSd63RRMC4S5cS3N17cOZxVGv6PmX6+cfN/82YdTmdA+5CqkX?=
 =?us-ascii?Q?vrMeAn3IPgasiy9plyawTVfai8TJj0nOWGlf5gPlDGwl0xHsjVivn2guddiE?=
 =?us-ascii?Q?rLt9bPQCrAONIyzdLqAFHGD1C2/lcgfCmxUXVL6NfZ4MNHCnMPwqskfne4q2?=
 =?us-ascii?Q?qBBX+lkm0l54fUOwi6SsMn6TsUU/oGxxwDD961/1qyNY+EZt/4LEmWDB3RLj?=
 =?us-ascii?Q?xwNmregiyLKyIGi1YHyMh+r5yv5/gdpJNK4lkBy2661yFEEwIvlwBZo7JRTP?=
 =?us-ascii?Q?w8lnBRiII+xJE/PsnizCfQO9pokmtdyekijIZmmtcXvYr3CbugrIsmvRBvBU?=
 =?us-ascii?Q?jH55jLkrFMSx9A6aPLMG05n95ICWX/s82bLLeZGk3l884AfCGBwQl2EVkYRJ?=
 =?us-ascii?Q?m1uqyliYlDNb7RSbcBvht6FrqaN6A8T/56Z76aDBjR6roW4k2j8J61bfO57x?=
 =?us-ascii?Q?VRTAQq36lH9lodJzx234DrCMUMTSKCVg+0T+kNR5J/+EnKXaVwTwBhNrHZfs?=
 =?us-ascii?Q?+0U3xcMNoiSWA/tutyGNf1yDRPGKHXwrUL2fk1H+dVO+5h01VcaTJjR0rYKg?=
 =?us-ascii?Q?ipM+5oQUW/OLSi++CFWdghsoYgZISh6LBf/JALxU2VRmeLpLu5azsyv1K+3f?=
 =?us-ascii?Q?goJsMPbE7fhVQf1hTTqOWY/+Obn8dSKeGkfJLujjxNAYAwkWT2Z9kioNtuM3?=
 =?us-ascii?Q?37Cf/J0ESGrjbAhrEAp9KfYEIhHpyON5EgOv0/+79cJavBK+LiB449NhUow6?=
 =?us-ascii?Q?eovtITtkQ6nNCTRRUoQlQBTeSUSvgzw4GI6mjuvCpVVlJDz9BDnl8xh9Nc2K?=
 =?us-ascii?Q?hG0tmH6cQC7GBWjJeGJNK4ZtziXJ9F2ddlQybi99pxTn6ooIgrt5QBcoLpl4?=
 =?us-ascii?Q?ltRSr/ji1HbCVosiMK3n97dbaAkc/m9R4G69N9qM+mr3UAaRBPEOLdrYaTt+?=
 =?us-ascii?Q?xdkP1ZGb+794arHJ72OFB06LkQR47ES4Vo3TbMX5V/CcgGopDZiz5vZcFciB?=
 =?us-ascii?Q?au1zuZVutsUNkW46OpomrK3GkHrTO+vTzW/p4Wva3hG3MhG922gDh0rYkHi3?=
 =?us-ascii?Q?5qJ40mpYIzuXNWB0u1Lx1n9sHj1FnJnZRoHQ7YlF51ztD6Al8dRC9q54FqGN?=
 =?us-ascii?Q?MTVa6CKt8yyWWM+o8aUD2YpRQfc1EQMeCUVjeRwDdUy/gUxZUF/pVv62kJF9?=
 =?us-ascii?Q?sslz03f3QIPKCnZDd8IUp09j7DgErSc=3D?=
X-Exchange-RoutingPolicyChecked: kyDcE/c4oOs8ittoBRX9N7gy8qvNshcyuPAciQ+zyHo/LhWfCbvZRVTcDuYoSp9k5UkdWZcwdtRV1A+yrJ0wBmtI0dsp0ycrjPDAY8oYQ3QeF2gP/nbPCAT3qIUYWl7oswqPPO//2eHdQuucu5LCVx+0zGMUstx2ZTj9mF3kVjCHFu+GqA+Ccj+KV5oKMqawXw9NjQkHOdGIu6DEE01gIUBHkzRrI+855c6sea7a+yr3XaoRXwrZmnNAY8KmbtS0l+g96BeMtqyNVNGKBuP1SU0DaT6TncVH5r8qq/6uqgEUYoe8Za6om8p6cmVoS0bwzvt9GElw54ZqC5VTsEDmrA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0112a372-6fff-4947-d1dd-08defdf741df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:39:13.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj3Hr0LPVnkdCc+9QzvmYEwtQgkxi6SqvpoGGtYrFi/ef8kZ9tD+00T5s19nN33ZAnESDBX5ZZWafwBTxA7EcnFxBjCOhmNaKydSw8Xgi9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10159
X-Authority-Analysis: v=2.4 cv=INwyzAvG c=1 sm=1 tr=0 ts=6a85b203 cx=c_pps
 a=i2sOhMwyfBi0WFXSdCfb/A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=i3SjWmbloiJ2BglgP1YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXyfeqxMdqe2Qc
 78bdfkQbxdS29GnvojkmaCEqWd8zwA/ZdD7fAedDtaeorDnlaAZPHy714Ix5JEwf5wVqjmh7YQO
 /uDYf+imkqQ0LJK/+7NBmFPPaMorQyM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX8GVdp16RrUb1
 HRw5rq9fDpiGNGy9rJdsOJ9AGOu6Z78VjFGgjvxm8vNPh7OfXcEGSDRWm4sfxYSsETlJ+ajzxPx
 RtSZbtCR5s011/Gwqb87lRvSsxx4BVTxVA2tHtMKCuFhQQIsbrKYVvlx1CRtipiXvbQeDvWmLBv
 iKJxgesA851WLOHzbwzvhNAZm3yE1/4GH2a10ckMeOIeRt4gkDXNyLmokawZFogrZ1sOA/z/8tI
 M9eYPOpAiSil6hQkOsXyQmpRAcXD8QcVSljijVjS/fwlumFFPgT4sevgBmYY3d6fjVy4BzovjCX
 4DZ+XJa4SOz0oiSxfsayxFrS9VuanHfMbIQgH/nbkbq9S/c4At7aoC3FVdN9AfH8/Pg7sVPquyO
 9i9XtO5K7TZUNmEIKVCRziXi6C8mlAIbbAlhTn/6UJGkz+ziqnLfKefO3aWHn0AbrPLGnvLQGY9
 I39khCHCVHJjq54N6Rg==
X-Proofpoint-ORIG-GUID: EYQ4mUwa82k9UiB-WYrJwq41pLfP7WwP
X-Proofpoint-GUID: EYQ4mUwa82k9UiB-WYrJwq41pLfP7WwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

ACPI_PM_PROP_PM_IO_BASE can be converted to use object_class_property_add_uint32_ptr().
Remove the now unused piix4_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/piix4.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6462ba970c..52bd61667f 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -405,12 +405,6 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
-static void piix4_pm_add_properties(PIIX4PMState *s)
-{
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                   &s->io_base, OBJ_PROP_FLAG_READ);
-}
-
 static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
@@ -439,6 +433,10 @@ static void piix4_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_SCI_INT,
                                                 &sci_int,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc,
+                                         ACPI_PM_PROP_PM_IO_BASE,
+                                         offsetof(PIIX4PMState, io_base),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -494,8 +492,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-
-    piix4_pm_add_properties(s);
 }
 
 static void piix4_pm_init(Object *obj)
-- 
2.43.0


