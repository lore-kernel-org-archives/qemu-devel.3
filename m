Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9E8CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpLN-0003Iy-2n; Wed, 17 Jun 2026 08:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wZpLL-0003Ie-Qg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:26:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wZpLI-0003xr-Lj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:26:06 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8W94C1910355; Wed, 17 Jun 2026 05:25:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=jf2XL6yxrdlGLjg
 R0qZMnyP3oBVxMtr9dNXAxJvpRC0=; b=L8X2X3qSh8N6e24qy2sH+Hljb/uO9Cl
 LarnB/hvQhoi5w7I4tdwlv0o7o4Ll22CihV05mUIWvbB4SMrQNftdb0ESGT/oEeW
 Je7pH8RhAO1BPfv4FHak0UKz+jl9+95qeItsr3TN9UrPSPbwtTWYu9LDkR69lC7O
 PSLpBnqnxBWxYNN4x3iL3eOfqute1YuHCiFANylUJs1QdMXx74G8030u3B4MUTo2
 VmFtFxRLVRQbGlDAQR2RjqZVoDC3NAD5GbADhFWdhIpiTLKch/w1H5Qn/otn6WQs
 lMkhWoCkznRKJIhY4C2IYuRCGt2PpbovDaUx+zyY7gLpRBJgI/PvdQQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020137.outbound.protection.outlook.com [52.101.61.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4eueg1sqm9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 05:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag2zcKfIVIxi0eVp/tMODhf6XxMRza9I+YkHdXjsyYb+PNr/xCALjULpHF4hISl5/p4KJaaF8T0onNnZw8V28ATvlRW6pHQh8eQnLo3cLIEjjDi4MCa98al8kPV+XXR3hUjqR2bGG9/TniIc+KX8KtaKNWxSgdehCHQNtRHATvuDxE6i/L38N0Iqe8j1fgdpb366gQOV2itOxfFNwXTrpNbBxAvhToNjXUSjjH5N011MZRhpcv43M4737DrtI65ImFVjyB+/iSN8sHqx4Z8FcRUiG0l8PUY0BWTwLXoeHxINrfRY3FrDNkKSit+TXkFXmWYiG1BGtB/3/4h1SpA/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf2XL6yxrdlGLjgR0qZMnyP3oBVxMtr9dNXAxJvpRC0=;
 b=QDBe5+VcbNwGqu3gunlDxLrl/dOiL+L2XFktjpWNeBm3gjfJrhXO8wmAFktdAsnSNRjlX62Fz6AYMOg0EIcZUEH76onD2yJuktUddIoZAvyV5JJE5HRS77/rqUnA/2Lnz7o4swOhuuWrbYbNWFAv4wdXe+vrk6OIpQL+DKKbkpHKaxJftbsEaBkUmG8LXO0IvPIEgbko1Zq9xjXklud485W07jIqMI3mcWU1c26lSE8Ffdncxl2SyP6VXPDh3P3r7UHv9QBITVaNhnr7M7wlFFbMcHlkC1WnJy39sB264ZqzwprKVzzgCHi5VHwjW9nbe7eZuiKJE95+7TTpPSspxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf2XL6yxrdlGLjgR0qZMnyP3oBVxMtr9dNXAxJvpRC0=;
 b=pCWEKrSR6YMP/MFKZmBxBpKJfbKi3DKVh0HLQtQQYwrzVOJCavViIfgp0l8iqI6hxvp0Vz0sBa9hef3O9vUnivyWW2kF2SJq2fn0lHKYUEH8uNFxg1tBqFdCR7NDAN68aFsgneE+CNtsU+ffn/a9V5eUKq5MRpCF9LDFSxUk+EQevIFRHIBor3/DsrtELdm3076akFU4dEyzGZ2HI24a+Wa9i881kW8dlaEieMv2xaWyEeFfb2KS7JDKuqlru4utzp85tCojI8xdgLPK8AnPNv85Rdz7dX1DdMG5ozAD5jvAUCgO8PWXfrKXE2ii9e8Pm4RpBhUooUUidmxASZGMfw==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by LV0PR02MB11158.namprd02.prod.outlook.com (2603:10b6:408:337::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 12:25:49 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 12:25:49 +0000
Date: Wed, 17 Jun 2026 13:25:42 +0100
From: John Levon <john.levon@nutanix.com>
To: zhaoguohan@kylinos.cn
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio-user: validate VERSION replies
Message-ID: <ajKSRiC9yYhWeMJI@lent>
References: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0459.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::14) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|LV0PR02MB11158:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d489a3-f49e-4999-14a4-08decc6b9046
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X5ACaj9LpgfN4+/8iHvEgZu6eSdRSVwc83iFA/MYehKuFc9ffJmZRiuzEtmT2C/UslU31HpBSwhU7fsBK0gSxIBbPXkS8EVdJL+MWqO2MJ4/zabBObeNxMnOK4yT/3hgi+svIlLhYcQqp4CSlw5kEeQOfuXcVH9xR6JnRQmUNuipSj7ruSbk9O0ZhMA2ZeFQ/SIkFRPjfFWa9VFq4ORmSgIDNHodLuSxKxge/cELqZKjoPS5TUNiWHXmNw8l5BEFokg3JufzQVX+kovzd3nAQRdZgfDEw4JiuUD+zTK6Y3hS64IZojM1vCR/1Q8v0zKGjhyzX1WOszJYK2Tod91fo+tYfg1phWf92/2etT0rmRJcCmp3dxEdZ/bk+7h4aZEutgoHDhZ7HlL9MndGujnkdRqqmLK9FHaI8p5YNMX/1FqKl1BbAkmMHvmnNmslIPUsJ4NsifHaanhcSbiLW9az8wd3JcTAoJt26YoU7YeH+6V0PivV0XyOD8DqeoDNWMDNC4rk+uqkTCtfg7aLcsGYh/X/URZsOsudBAOnkXe+VIFSbrqzNURIhYhjoDs8NM2AwlHy1aXrdQgwK3iRzFIGdOqVnBqF2VJh5gewTdSUEV8KkkQJkDkR78V2Ch9rKpvEJfHYfOYQbjc+lEKQ2UeMeSPbhIEELcHQ3nS4S5Vx1Zf9ItUBAXq/QYSNJ8ITdmrp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2PqDYTJXCOjtk215ZXd4VYJ0DIQ2znWkeHROthH8IDzlLXhhCzBxS8SBwW/j?=
 =?us-ascii?Q?3n2q8p5UuoMBI5+oUYPb9SDg+Xa80fbQX/x2yLJfl3GvEIXp4clgtmrw412p?=
 =?us-ascii?Q?tqjPed4q04CUl7iTSCA2Lp5CELNgbT++ICWDtqFgEF7oB4TUMp9w7Yw3CFo7?=
 =?us-ascii?Q?fBLlG3Mq+kZcxlXEdJHr+YMZVbkKUiIgmZPmknct54PS+L18ETZD2MXw6nWZ?=
 =?us-ascii?Q?oqZTKP40gXDQafTrDBynQTboTRoaxysFh2orGdBsN2uK7RqiEzjJl9Vdqnm6?=
 =?us-ascii?Q?jagylC659hwc0b24235/zYMmJ7QUsdurKcDhjkm+jIlsItsEgCftGIippeHS?=
 =?us-ascii?Q?nP5napA/kwy2hnnltwMCVfyrkiYXO1JDl5vZ2CTqu4V6+hjea5felxombQol?=
 =?us-ascii?Q?6ZOr0zXtNIqxDLgWU5aYhDCZBLQAbH6Em3P17a6iWi0452j16dCfZXaA/LUb?=
 =?us-ascii?Q?f4ip3ZKKRg+zCf/p+VZjZTENVzwd+x+t16Xu22LnpF7kHGwxt/DuzILIJVwr?=
 =?us-ascii?Q?W8bPy3yRQAbeFaZUXTsStAmme1Zas/yydSwIFJg2RoiS+z6HmZHenmEdS3/g?=
 =?us-ascii?Q?nmXRjt+UAMMaJc5GHXrtNj1w11ykveMR931GO6b7Cn4OOM2KBrf1sR+y55MQ?=
 =?us-ascii?Q?/Y/FzhMVNvWAjP7iUChjdHQTymm47Kl5CXPVd2NtudwqKveQrSDCtPzabRhF?=
 =?us-ascii?Q?hzVkovgvElGuATR2uonZIXZHtsu7EdBc/kiTCTr0xZEplPw8j48uWmECyily?=
 =?us-ascii?Q?8Inx73RaxDG8r2mFR0tRKv3FUGMWY8geOneUDJAZAD+LodFgsJIrSlfrOj94?=
 =?us-ascii?Q?bKWGmX6RhLoVYL1Z1XrKzdAhOFBU/pUz9Xi8TYUCfDd4J+0HEhsQz1b7q20d?=
 =?us-ascii?Q?N3iRbDB86bNZ+98PufaNgUTcgIZsmeFNTk3kGPCOXfNFhC3z+6budNQy1oCN?=
 =?us-ascii?Q?PlFGPJNeUKHdhZf9fDHBX+GUY1mlov7M6IwxnR4BdbPm2vdq87dqKbUcAmf8?=
 =?us-ascii?Q?v6CCR7HeNSFC2yNPQHpflAVsOBWWFxj8b+w4CP0W59bpzplHtAJPBLsK5ccv?=
 =?us-ascii?Q?cyFzs2r2VKmU/O1p6zxPmTbZysOqHpKR0JIZlv+I0+OrfNQo0hmF+0DUWmmT?=
 =?us-ascii?Q?pjxC+XYCsLX5c3l13D6VCFj30X0mLoqeFw0jlUEQXWZIyLHb9Qng+aUaYEyV?=
 =?us-ascii?Q?thXkCYYQV3DrBr9XPq84OVM++JgWf5ZwwjjgzlQn7UoBFBXKBz7T1/utNIkd?=
 =?us-ascii?Q?LQc4mIlSSub6Bqfjibmq/FRW6ODK0aKL4wBXjKeSNZmgBYjqGH8nD82e/m6J?=
 =?us-ascii?Q?yLeJ1yUAg22eT2Z/0LHTD5tPkWyq375vKgkrytrt+WXaSmi0yvNl9i5Alx5S?=
 =?us-ascii?Q?JN3xIkI6BbQ3tTp50G0Scp7jmB2XfZ7T2iGiAtPG1r/6lPFjv3FgTK8U9Wdk?=
 =?us-ascii?Q?68d9r6H/Yhgcdnh1wsHRfomiNlzVSusOGjld1xWRX9hSspHaOnD00FNX9Dzf?=
 =?us-ascii?Q?eSFmSsuY9/ctVzcJtExKDdXe3Hq8F80CuKQgaGMtRC5CGhq3yxTp37U8gh8c?=
 =?us-ascii?Q?mPNX2tlMkiCSJsoQUQNrEhvy2RNMoU2A4/IKSojAAXwjKKhX5TudlOzk9jWa?=
 =?us-ascii?Q?UY9gGRe0IFSEnNdQXMpjn9rkqQxEnA8NTELEcDOMITTANOLR2jUHX0tuM/Ar?=
 =?us-ascii?Q?O/iTzWdbKOfM6e9kZfQyYS/pw4kp2Q2P4ntFU1MvlUU9tnOnksEas0h3qzrY?=
 =?us-ascii?Q?dNTvu57n2w=3D=3D?=
X-Exchange-RoutingPolicyChecked: s7VvTWIjYqPABIXFf+ApAFIl4ZaB42e7VfV0sT8kEE/TuXq074ZeCRS+G34YAGStoLtXwZTZH4R28Bxm+pS/rQfa8SNYgfVoB6dIaOVZdIEsg6DJRymD3XyUv7sxZUoBojm1JsvSHaqro3+gPqcbmh5iDS2KxhUzTgb89OwOgkZrSAENw1POAGNVFtVDyvm9nB5/UTSdZHF3Bpll4DcJQ9PpEOWEq/IBX7ovf4INi5wCndtndHPRIHOzP+JNvL6iVhPRy7npU1tFh7cpJjZEAmwo/rZJ9jICFNCsAeTN2JsNnjagaVMI6xk25/neB9CivLsdPPfnQV4FO9h8l6VB2g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d489a3-f49e-4999-14a4-08decc6b9046
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 12:25:49.0840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgK+f8bFoVp7qstZHo36HK587QSWfVp42eG7gH3MnEiqQ0EwIPkI1R9Qr1U1SNa3l5vO+VvbF7DhuwtoLe+QeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11158
X-Proofpoint-GUID: MdX4oqRp_amFluXKszWdrMirj-y6dvwa
X-Proofpoint-ORIG-GUID: MdX4oqRp_amFluXKszWdrMirj-y6dvwa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExNyBTYWx0ZWRfX+resyNWYdQTz
 HCQ+jlGfgAr+c8ceUkMhjEy4IRMZ06r4rxY4PczCaa2OzQIF/E5oAqoptJj/9nFw00AYLfqyNQ/
 oxYhyUkyb25vUejECwewQFaNpLY2Z7V+HgGqap7NhmAelWkBtblqLw5Q0qUnQDufUW0YYtTEeWE
 jFBkmmj0QzfVVqbgVmRJwvy/8+aH+vtZ6g/71nzOV9GWKENXRwNMnpggo4l1i/xx0T7rELlOFxP
 79kM8NbfRoVH+Hu8OuFDJ5UVZZwvvnvkRoiBwdqfWOtvP5ieo4ygc/uf5Wy1t+Bnou9V0AQNjPZ
 PcdMvA0LVz2HHnF5ijppZS7IPVaM5llG1nsYZ11v68cvjvzjffLx6ekGFpIFfFF8o1N8Vq7JqvP
 KbYF03qBYdyzu1C1zLDM8Hh6pxH6LbVvXzmdXVzlczscVXdOiqnpYjIQayZ+yTdWSrT++WY9LJK
 7iOJUHdojXZ27qTST1g==
X-Authority-Analysis: v=2.4 cv=c+Wbhx9l c=1 sm=1 tr=0 ts=6a32924f cx=c_pps
 a=IXfcYWxja++gTjxmAJNAjQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=5_zllTcJo4vDqqucfrQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExNyBTYWx0ZWRfX96YYNzxUUWE9
 MCgmY0lW/5VUxd5ijAIi1Amql/a42KpHop5vN3vBxY2731v6tuNVQdDPjh7hmAhR3Q6011Y4XIH
 miQ21MRuOBletdUcWAoNZf50umXS+xY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, Jun 03, 2026 at 02:21:38PM +0800, zhaoguohan@kylinos.cn wrote:

> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> The vfio-user protocol makes the VERSION payload optional, so a
> reply may legally stop after the major and minor fields.
> 
> vfio_user_validate_version() currently assumes a capabilities string is
> always present and NUL-terminated. When the server replies without
> version data, QEMU ends up reusing the request-side capabilities buffer
> and the terminating-NUL check underflows. Replies shorter than the fixed
> VERSION header are also accessed before they are validated.
> 
> Reject replies shorter than the fixed VERSION header and only parse
> capabilities when the reply actually carries version data.
> 
> Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Thanks!

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

