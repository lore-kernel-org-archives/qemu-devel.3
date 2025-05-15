Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD63DC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFam4-0006yF-BM; Thu, 15 May 2025 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalI-00062c-SG
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFal7-0006Bh-HX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:43 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F9pAtJ006566;
 Thu, 15 May 2025 08:44:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sJWhCq6bCtaHFBNDEcT5XhZrDmbqdEHKdCDmnsLfe
 GU=; b=cQwfHwTH1OsX4wbz0W/JFBhup35IaPR6evzCN1wOiwxD7wkK3iWypD2PP
 0ycrX7x2QsGdedMJBEVMK0lXLfdT3CJbUQ3EC7sSEAQxHSgiBULcu95OR4DEtM3F
 ke6av2OT0AfrUNISFjKHoRWZUUGQ/mZyyOviGIPFND8qMuxh3WSGd/rB+IsZdrGS
 9rHSXB2C2PyvP33KT8CV/bi2QVp/0Z4583nORhoD+LPl8rkrcJs9UFpT7EI0BIsd
 EHEepXd0t3fQ13qoP8SFxeIYTaudiYciyYL9L0pK95f3QZgbLO/lgVmPtOtFBBI+
 SXLbF3hC8zgOchtARHNxwdBLJhUpg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcwwdxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkYFeVBxq3jAmcW1sgI9IyTwDEPw3uE1rGx1rcOJsf/R+YVLR26bDI1fFkWzw74M60dtgKWnxpPms999RqVc4H74f6AMtZrq1QwbfofGsuxIAfLGXk0ziVfzANaoMgpXCpuzx+SRQ+5jPZ8im0t/oJ8oCpf7BcH/naqbRMck3cSuq+c7CLsucVzEmc8yp4IkHY7gNys5G2zhMCMa2enra7Tdumxy+OG7sa6cUfHaV2Haf9+NJbX9/c81jG3QrNfP6ji5GK02IHW8BgGcQ0Bc/SyRq2n9aMIFwpTy59wWvX5KVI5ipUB+xrvZgMEOS8ZOYnfzSB5XHpsdGit0ESip2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJWhCq6bCtaHFBNDEcT5XhZrDmbqdEHKdCDmnsLfeGU=;
 b=mqQ0Y6r2kVPHLcqS/Gxyge5Tjdpb0eTIa2d62D98eSrrU2Am+MX8rsjdiKbOz8m/l3c2ZMDxfV8S+7ahFp9E282v43V5tSjExGz9OUF52Sr9d4uCogsyou3qtjrmzqdVNudIlNjLw97iRWEahE1cJQjmjTwjgaFwcgED+4akOageIlY7YtHahkpeRfa92/Lbz7yRKLM1bcMaOPXRjyQyg8nifVbi3xFrW+pYpzhlWnve+AS4OK6Zws/fVrdnF5VNdI1XwwMkn2HQoo+CX0JCqe5m+L+yc4hE8Q3LhhAAFlp5WY/Rb4EoR+Amz5yPynw425j0fAMu3dpkizfDpuFRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJWhCq6bCtaHFBNDEcT5XhZrDmbqdEHKdCDmnsLfeGU=;
 b=IBF3Xr45kaewsfEieJ6tZOHRFBahOIMLPwJFzPULKnd9MGBrA5voN497OqP04E1Ry/tSzZxGC087CNEvB+NUP3U+RTOjPI3V9494+yXJmykVdQVciUSq5gNI07PGC4jARQAL6n3y2bwEBUMI0Y44pH1zFgg9wIhEE1xtFPLLjJZAMn24Sk2SBIJBMsB0hXkL9S91r02N5y74J3nBgPZDaEHXQa0oh56jfkmjhMGNKWahOOUWSvm/cTmSzHL/ebxlvV/wfexgkChCaIyr33ahr0HrbRfGZkpFegTRiroMEVdu4rjgVbS29t8pptlusiMqv+eY/Njc/pZFX5h1F8R8NA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:29 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:29 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 04/27] vfio: move config space read into
 vfio_pci_config_setup()
Date: Thu, 15 May 2025 16:43:49 +0100
Message-ID: <20250515154413.210315-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 436bd3e0-88a0-4d21-262d-08dd93c760fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3U/zY2Pk578RzKIm08kzvRdHuPYIc7AkSnhmqSeho3i1DFHS7e/FGFHafynH?=
 =?us-ascii?Q?SxanEBTmuPh57f3y01dkAgXnTKPr20fiHNFW54ancaDds1YxMuV+e4t7D4S8?=
 =?us-ascii?Q?GzYsfODRngWqpz/6CJmSVmKhZ8NBzywmJHM/TbuUJx4rfyB9C6uB2RqYsmtP?=
 =?us-ascii?Q?LkCy9/TNyyO7WfORwPrUpV++vSqDLYmDuvB35kQ9h/k3d/IY6c0nth4HxGnU?=
 =?us-ascii?Q?Mw/0TzHUNRmGKeO6iu96WKxHKyGULSuBQV1zIaNn2Pm8RhCB45bRLYLsO4iU?=
 =?us-ascii?Q?6IbmFfsTGb9RNps5o7XMyEgTjE/MFJr+AQJyWd5BlxSAfuoaksKhAMUvOh9R?=
 =?us-ascii?Q?0N8w0zrOY6uyjJjqXp1UdYYGGcZVarBiWQDy885bD3W7S/Okg8Net3S0xCNT?=
 =?us-ascii?Q?tDUB/pVnd9GSa0bQfuALNUARmOIsLmR0zg3i4/mmy3HFf2xIG+Q+KO9bCf3x?=
 =?us-ascii?Q?l5fxh+CtqTzicZPqOZ0Fn7vALxKTLQjo5awRuS8q5iEgJlQDjmiXFSVJMY46?=
 =?us-ascii?Q?7At0yaBCk94DElVPvkvfgdCqzpS5JixsClGRv2ENrr1x+4vwkJupKuNb4Dp8?=
 =?us-ascii?Q?khrckS63tGVUiD3chZ2Q06u53ZSNtkqiTfYNQkpnaLk2s+APFBl674ABcrXI?=
 =?us-ascii?Q?koIiLAuVgum1SSD4K28vRHkdYqlbAapRQHrHvs6/E1LxisaeUZptDMDomQQv?=
 =?us-ascii?Q?wZRG4A94PDBNJu9J6r0POGhBIL7zWIMQ9m+OHVjvFQSjCKcv6JBa54K5Wh7r?=
 =?us-ascii?Q?wFaerMTqf5N/g075aO7eAUiUG/2cZ1jimj9bGmm5whqrTgFlPdeZtyh6Knnh?=
 =?us-ascii?Q?9uCoP+XsKSL4zOkRH1qdspS7vrYHOPCOKgCov22r92Qs4j0fAheTxqDfKVX3?=
 =?us-ascii?Q?yx6HONwyGRhdzy0ZeoPM8gpObSVdd5bZSoa7mOhWy/v9cCsxp8zM29HcjoSV?=
 =?us-ascii?Q?urKoYamRAzmFhTA1cHgZ9f4aco8soaZCJ7EPIhDzUpJ19mN2w6CjKCmkGrGO?=
 =?us-ascii?Q?pjJN3kCNO3rDzrwCHWXZz0pJqI9hU/lu144DjVwxXHtZxgoLM2z4tyuS5c80?=
 =?us-ascii?Q?OfCvHR1ImcqQMZW4j74VANZXGDRg8+WtUEqpF8SJhDWeI0fl6BaK8C9MiRC4?=
 =?us-ascii?Q?/dscRsakjStHyRzZUuwTllL4RLeh1fT/0KJSW934A7cHe776Newt6a5SGtib?=
 =?us-ascii?Q?YMSTktPhTe5RcUliujQQiKGZ6eCXgiidyebhTwzwRxktbHKSUWcuqVNQNwXq?=
 =?us-ascii?Q?t7d/rJqUacY9naaMeUdOrww3EPc8nDj+dBAszH5wPM8blegw/tr2qpqlg+z6?=
 =?us-ascii?Q?ukV58WJ8uljcpXJOiEJ6f34XqEk8zk3yI3uD2SjPqFWtEcX+oMvNTY/7oyHU?=
 =?us-ascii?Q?FK977WqT96O848BdwSATE0qoiJ1cHaEOnuGucgMf0fshHeHFV1K5yYa3K8zd?=
 =?us-ascii?Q?862bFMhxQwE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORf8hDkPVmPszVmkFlQqliLF0wvOJ4c75TN1u2Cropnz1VOX6KkGeA799WQj?=
 =?us-ascii?Q?KBtAB39QPTMpK69eHwACYfepfwWpaemVr8ts9zr8AiT3eFtVTn2Fxqr72Tbx?=
 =?us-ascii?Q?gp97ORmClzd+jZGWB2G5zGh9tylUt3D0Qyc4+r7k6gW5JYZwIIbLZ7U1QU2X?=
 =?us-ascii?Q?0TSa6Vy5pE16SSySXhZfRCBzfzpEnGFbpSjxX4NPZ5vwjRtU2OzQ/5DyhOoL?=
 =?us-ascii?Q?a7CuopIxGnfqvNXfZLmeXwwu9U+gxSygjloMJZ6yOehwLH+KFBP9DuiXZSsg?=
 =?us-ascii?Q?1LiX6tN9EzpsLnQfac/2xSMdiboZJHHNpEKSjM3YS7pqYixk3Bho7Uahhy+E?=
 =?us-ascii?Q?dYHubgairo1SaPjopwvxucZ7AVVQqDHkhq/bzzI5kICckSul1dxiNL6G5OH4?=
 =?us-ascii?Q?CfufAA9C8MlHyC4dfNIPqFF5cx28HGhurX+pk5CQpUTMiKrZuZFOch08j4aM?=
 =?us-ascii?Q?9ncEhnpg+I/+O5eWoibRldtb67dgnfCmPq7eFC/oLjbbf8psQL0+D4SCg3or?=
 =?us-ascii?Q?jQzvU9C0cSeHED5FdyL3Pp7IebeCoS2pPExnIZ1VmBVwB1u6xjl+kwqg+ns8?=
 =?us-ascii?Q?l27k6hKEy8o8SJdQes/8w2KoYUgR0J3mQuWoJnXLYqy+6jKs19QbgYPhPcFu?=
 =?us-ascii?Q?1PI257Zxwh36iwMwwR4NKdUXM55wMfJZcESmlrEKB1/Y6yMFZ6/JlNGknxtx?=
 =?us-ascii?Q?PNXou2wH7sPVXO+LRsxpRWsYDv7B71Ip9JCSBymAuWSqtA/H1E2N+HlB+R6e?=
 =?us-ascii?Q?LKL2PCP9oG5Cu5S8/ROE0DEysKI1xyjjz+CLr2Nibl0gb+UUBTHv6+15NJFW?=
 =?us-ascii?Q?tWFyfXx7HGML74UbXzfLpwD7xY9lDvUWyZ+mX0JHTRsoUjibOmTqGp69zUIv?=
 =?us-ascii?Q?35GQcAvS9KMda+h7FdMEf+eTRHcywlRAaxGam2unOfIuTtoJFnIN4jYKykA4?=
 =?us-ascii?Q?j7epPaKtxlHAKu5z2btFtyXW8bQmlhgS1VF0BcclxWL9onf0B34h8iyP8NuB?=
 =?us-ascii?Q?YdOT3tmGr2Qrr761F/3r4i4JGISDPTJIhBOH+dyVyAPawyJiY/u3rem/kH72?=
 =?us-ascii?Q?I2tUiguCIbwDQeXjd92+KDrUKadXi1qwQfgzklh9038k8oIZhSHd96bdNne5?=
 =?us-ascii?Q?U/vQ8LeZvhm3DOL5/mtuB3Zvnuu6qALRw0vRAIq6iZRCMvpXdqZuLPGekAHx?=
 =?us-ascii?Q?9Oe9fV4xL8/eQFFv4zZxVh+usiWIH/ARXrwrvTfOF1vhG0amiq7xZkRkodov?=
 =?us-ascii?Q?q8ZxLfphQpOrJKMB4jq8yksR42+8QjHR17TeivVnYz1SmQcS29U95Pg7Ty7s?=
 =?us-ascii?Q?IZo5Y+iWXVmypPIWG5BwZiVE91N05FzIWetFfgtV+jszhXDemdB58kdw522s?=
 =?us-ascii?Q?qhSSOsZS4XdO+NGEEmwINg1INGbwFXPblIAQ4+Ab65bnSPwE0E4tEFYEqt8V?=
 =?us-ascii?Q?5Ppgq2DOvr3deOboLY2oTMn751AQM0TSyev7yK4TWzFbxB5dyUXSH5ID4bXU?=
 =?us-ascii?Q?zMb+Uh//EdA1s8CT4C/d3IpgLvSOHCseKrs+Fsd0A+QhJodyan3yMlgZ8MCk?=
 =?us-ascii?Q?wF9T4XvlB0RgR9lqNpKEfAZGGtm5MhPu7VLX3MES?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436bd3e0-88a0-4d21-262d-08dd93c760fc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:29.2763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7PobCagSNb12AvtucazT4FrwQJ6HhrL5leV7L6MbQqw0sy0r9j/p6nV3kFp7u5BCZCsHw85sy4LeWwN74CuAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-GUID: 2NeEDT3-LYHU6R7LjDrWpooa38L4YQLf
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=68260bdf cx=c_pps
 a=uYdjBAypVXkA+ZVpDPXefQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=FCJwmHiiXP3F3EZgyVoA:9
X-Proofpoint-ORIG-GUID: 2NeEDT3-LYHU6R7LjDrWpooa38L4YQLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfXwORxSX/0f59e
 qy5hy0X+/ZwW/EWQZ3r2+98b+3ucpHypciNdaRpXgB8buFFoVE4TUD2aqt829/Vf5ARBEZ5fMlA
 MyuCHn7HNJkpgcCBzcol0LzlG+cW0aINtQCHiY472SWAF8/oUnKLP1xkT6TTZcPpjKypZ/W5Aoo
 crcLr4ETmSigdP7MojUmqSKVkRZkdkS8EZoj8H6ZDwH0KRzVmgtINYgty+k1swA9n7Ybp5/xIcl
 Mmgu2P+ZSmiyIQ7aJc2lh8nl/GBXxWbQZQb6L/XofebgTls/g/ZFVIzlEJU3Ik0Srf1vN84x8Wt
 YHc5JFflM84VtT/fIQfCHuxl0VZ9MWVpmwxEMh7r1wWbNiBJkNqhvrXVW0qMWkTPn8Baq2mXSGo
 zmnpyfeKjO4YSuTS5p4CS5KcSRCvbN5qmD7yWu+CRcANywa3rl6dlwaW/73Et2VwgUj4LNjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Small cleanup that reduces duplicate code for vfio-user.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d96b55f80c..7912c17dd2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3017,6 +3017,19 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
+    uint32_t config_space_size;
+    int ret;
+
+    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+
+    /* Get a copy of config space */
+    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
+                                     vdev->pdev.config);
+    if (ret < (int)config_space_size) {
+        ret = ret < 0 ? -ret : EFAULT;
+        error_setg_errno(errp, ret, "failed to read device config space");
+        return false;
+    }
 
     /* vfio emulates a lot for us, but some bits need extra love */
     vdev->emulated_config_bits = g_malloc0(vdev->config_size);
@@ -3143,10 +3156,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    int i, ret;
+    int i;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
-    uint32_t config_space_size;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3201,17 +3213,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
-
-    /* Get a copy of config space */
-    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
-                                     vdev->pdev.config);
-    if (ret < (int)config_space_size) {
-        ret = ret < 0 ? -ret : EFAULT;
-        error_setg_errno(errp, ret, "failed to read device config space");
-        goto error;
-    }
-
     if (!vfio_pci_config_setup(vdev, errp)) {
         goto error;
     }
-- 
2.43.0


