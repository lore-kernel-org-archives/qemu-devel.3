Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762D9CCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm84-0000Ey-7m; Mon, 19 Oct 2026 08:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7Z-00008y-Ge
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7W-00042f-CR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:40 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Osum3282318; Mon, 19 Oct 2026 05:05:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NIlAnp4VAldnLceUySYWQNWAeTWWwprg269Vv5DQ4
 Tg=; b=sc+iuC6pB/C/7jDT451pALus5UcTgkRzwDkOKoglJjHB1+MpdMJu5TOLJ
 YikPoLcGXYYQCd3fTSvfsdgka84cL63sQKUYuvVvBYcr3p0+Bz8Q886qpHG3zwy5
 MM3D1exEbo5bh9aeV3vJTCUkop/68dHvDziWx3ToHuPlLrlZsH915feS+bS1cX3Y
 KHTrVHEsivPL0sqVkPh0GXZI5QAuECSJ0wCuwf2oJEOtKyWzSXTpHE/IkLgmxqPb
 8b5QNXtrwdpT/w4KADHH/tTq/SdsijTsraFaEukq7ie0wh5FzKYEnZMJeB+wbx3f
 sJk0Ok3B/7zGjsW0GL4ASxEC6slcg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020102.outbound.protection.outlook.com [52.101.46.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc74ekjd6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr4JwQ/jYvxAKvszzjM7CrPE+wkuD8pNDbhOxj7wUAtqX+4cnKJoPdMXnlyiDsZKIkWI6dMu287gp4HX9LdKlTrx78cQl4cnPFKaQhd6eTe6nEHFjW1Sipu7DM5PPK25dCH35fHz6O3f8oklsHMuXqsogpmQDWzje1EehtKNBcCz30fNkdrG/PdYBvZJRVSZULnmVY6yoih6AgkqgHZvlqtKfKe1P8IIvqHcztBZZPsjjxTILzs0fTvdYt7j9WfSobRgGvLDeU+t/2+rkLHdBanwRBLvmeCBBSqFur6mmqwM1+jCVv1zWe2i8pqEXE4n6jIqK2VyLipmM30038a/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIlAnp4VAldnLceUySYWQNWAeTWWwprg269Vv5DQ4Tg=;
 b=WiKO9oWUjdQQq+CVkdensOWzjsAP/pwoPOxs+E/nfuC3RkYNpxxLEYThJrPQjMKtMdWimJJf4f/IIO7ERGwY6ELVPlK2XoyaWpNE0rAK+vQPKZnzw1vo/FdnqLjz/4A28EEbOPbrhYh1oinBPhpH4nvI2S3qRrX3qhOEVnR/yvrclgHXAWUKyOlvybuzED8aI5tlOU3Ga6CMsfEsMHmJIE8LqHyg7Db5Fu5UYU21frtVQLFUDShr+bvt5gEwY/ubt4TvxWoELp7lVpjYjyMZlFgcQDvb08QOnU0J6/OXOcKDJDby+gEWwuu/p5Yzo0ajawVS28Kp+CY16/I8m2uhZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIlAnp4VAldnLceUySYWQNWAeTWWwprg269Vv5DQ4Tg=;
 b=Upilcb1EB+cdeUXhNY2GngqT9nMiHYKNC3k8MEj0VDzs5SVp5QqGVzNNPhd5fARRCZip7tQJYegcwf6JxBcJ6YwqB3Gn7L/1Ji2/lirx8Q9DdGnChlT5/RnhlKlBc13zXZeyy8SNrV7fA40k/1ANZHyzKEqgmPdczbIsA8RjLI2QqA1gWbXxowuwiz0O51jF0iWrEqg4xexZi4Nma8pVX0v55/4h5rF9OF1yTj/mt57jdtfpBx4RAct+ZK4GXLvXsCq0CEJZ7p04gWNSzXXKztRbw49G6xtfUcJeNk4CuyjprRZrqYmLjbfrtNmibeW/OfL1hBrhpV8ur9QyjIwE9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 03/28] i8259_internal.h: rename PICCommonState to
 I8259CommonState
Date: Mon, 19 Oct 2026 13:04:35 +0100
Message-ID: <20261019120517.1448687-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6324bd82-7eb6-412c-ea14-08df2dd94553
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|3023799007|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: UgvTmgx15E28aPFlP+tpYTSYDX6QoHXnzqiGe8SIpIlAgWo32SEY1X4gEYfWgph917ovTB20v70g13v5E4KFVpb9uDDMJc2AlZuOU+c89VIUGKNpaZEFksc4brDMVyRnPko/YfTI/3XaxfYD4yRpUMCQxQeLWf2RLyksh0+5EWWrHahjfDgLLKnpM0kz8siaAMYLhFB9hyerfBOphjRBtW61nCvDo5/HmrJ61y2FiUqbGVH1JyN3ePQABLWeZLBaEkvtcQU3gKk9YT5qGSsg/OudnGKaa63VV3mL0bb9FgeFwhbJtckkE/Zd2LUbq3aJG+AHht/Bot3CFVcwf/ASpa2vYJBkAEafeAWmvmPOp022ePGjg8QGJyt7pQpk/o6y/sEPjxOoUIwTOslz6XreQMDTJJNXiB9KW1W2D/We9Ejm3FLF9RQGHb8e+eTQckBNAP8sgp+KrKUgpuW7WVPvMqLiNBvMjdATiDHJoP2dtmHf3oLb0ODyWlv6mmA+K2ZCypAfnpIVifhihDYycljJJJqk9Z4BSbutV2wH9FsSmzxSQishQL87iGdtB9/hFyg4LIfkSaH1PfJjIKcom6h4KrF+ubQ7b83z16Wj1fuu8JDDdNH+eVSCQto9XP+mf+yLXKtteNOvjGf46RaiKZhL6zS1cm6mZYlJlk3sY4WNTNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhGFkpbsAzjUVxzek1KSRGBiRLFmF6PTpyttsgddMNwULbSgdzoFXqcczYsz?=
 =?us-ascii?Q?auGz41intpATjqkrYgSdxbi6Cy+RGXHFA0JHypYQ8uFCXVkiP/yU0Iz28hlF?=
 =?us-ascii?Q?Ad9t/DX0XoB4ba4IuOzuPYi51AO01wN4qvmKpgHYZuUPAvzXpBGseUb1yC9H?=
 =?us-ascii?Q?lseTuk15/rMYt+M7t8rNYtcoDaBn2Xk3YJd0S4nKr0IsPZe12ijZYSudSSh0?=
 =?us-ascii?Q?gau63DQ7yaKCjx0z8r6qWmO3vaxX89nOaMN/RrbAZR+IVMQJsnkIwFiDMTyy?=
 =?us-ascii?Q?P6b2Rin35Lvq7DvwfhxDroRE6EZGmAgyC5pmZLljpG0K4394AGymeQbBFX+r?=
 =?us-ascii?Q?HC1a6pbCbYFd3mAP0pNxymQtZNR0kvv60zoHmWUYOghiSD86G7H7Vxp1NkG6?=
 =?us-ascii?Q?ZSPCjIDTFJELuMlqQUAmwRmQ6qiiA9sOWASQhyAEfdYOb8lMJr57eTMqd27m?=
 =?us-ascii?Q?owEEjN9otuQk0FbJNYmivfjqM12fxovUvBGuAgDGl9bP2T0jg4suamQSJZQb?=
 =?us-ascii?Q?9A+nMMigGTffWkNrh9lTzZuCsm7Ux3WmAdLZ1ZiPEOi19BiMKpY8vBHG6SOf?=
 =?us-ascii?Q?bgqWNUVZXkqU60I7cyw96jc7F9xNT/RAck3NRFDyD/pchl4HxPmEFCslWm0s?=
 =?us-ascii?Q?OLfNy0XpZKNOkHYPORkJy+Xje7VbimiMOGDqi1ZgSndQJqBt7qc/B9qDQMdc?=
 =?us-ascii?Q?hTDfAvWXBbgXjFWb5nlREY+g2neS3k3OjUUGW41h4t4sADuHHoiQrGcLaeWb?=
 =?us-ascii?Q?PnP4EoW35rbqNEtaiT8ciNeMFCCojWxwR3hrzx/fQKBeB1jLhYqKjkACnC1O?=
 =?us-ascii?Q?17jbXVqdTvZQMhxc66SClS36Oo5+MMlwqLZySqzH1w27/lSTEJFoL/6fB3ZO?=
 =?us-ascii?Q?EWubbYOwOqXcmWbv7oBdyCP0dTqTs23/d47Ou4yaV1Q79L7tAEoEl1Qs3a7q?=
 =?us-ascii?Q?+femLFTMTseMoz68i5AqZlX/vGju9gVR8yEIV9KGdxVTU602iFRXyrZcXtCc?=
 =?us-ascii?Q?sTemJtBkGR2sEzWgH9ucDTjF3xNUX+Mn5EBZMjYJxBfMBeXkUhCjzQiuocr8?=
 =?us-ascii?Q?C/Yx2yPk6d21GugweV+HYClmmdmsAVjJs14aKFSnJE1LuBcA3gx84z4rCrpY?=
 =?us-ascii?Q?d4H5Q5vV4TIvKHGEeVM3/yXrlQ29A+yavy/KkY8eEq3V0Rq6FpIYEsM0W4Xc?=
 =?us-ascii?Q?IT5FkybPebYp8XsUnRvIfq7UR56LaoDkM3aZKzMPm7fRQsLGYdqBw2CKABut?=
 =?us-ascii?Q?+8IpqIPsIFivHutrCc0OoKLllUNGuRAytcQPYF/Eyv5kJDCM6nU++OAmi7zX?=
 =?us-ascii?Q?dun6wmM1uTJALYb6dxKtT2IqKF+/Kq7ruRYr0SYE/azoRiXeGV2yLMXWOU3n?=
 =?us-ascii?Q?Q37wJYNtgbNbgqEf2C/+TWPJJlR5debiET7Nbl+m8xWXSpBjjl+18NoSo/R+?=
 =?us-ascii?Q?X5cioYxta5uKU9+Ydexnrj8ANt9I62nqKrq7MQ11hJW9E65SylevRAVQrCAQ?=
 =?us-ascii?Q?kQ0X3/G/bQr4l2/ZrI3fr0/wTRKCtZqEM3omGh92nt9dKsk62MI5B4r6OcoL?=
 =?us-ascii?Q?clbeytv24juBGWwv7NtTJXfiUkxzGa82YRLgvAp5zIe8Xcw1GknU5AgC+/Zc?=
 =?us-ascii?Q?ZKKyu9IZTWTuqMKKT95d0EiHOkd99b/T821Vm2fTgW2xYmAuPle9XU1+XUuE?=
 =?us-ascii?Q?4dFi8QcJ/DuDyg5jfpkJpZK6JhJnQkWV0nmqEf1Yue7ccyPEGzOE64ehUrnH?=
 =?us-ascii?Q?pa4f1ZaTXm3m4jHxM5Pa9LoP7YDQZyc=3D?=
X-Exchange-RoutingPolicyChecked: uy5lYTDnWbKe22cVJh+MHTWYp2lnAQayfxQzYE0k3MC0f6e99zSQD/tTAvernbHgBZcQOQcT23lf4+Dl3LCqCLlH1H4ytqwvTOPjPxrMERVet1qQ0OXunvlFI6PD9l0VY136yJRaXASDCB1OaoZeJvAzCcxnRbWOAtGsd6Sekw0vIPAfS2yLLpr7XohFodAq+EeIcZnZn2i3GF0fuHzwH1Zr3GLAoINB2mnC/d/XWfuR8mlYKkE3tKRxL8+1nDaSZXW46iqiaRNHciadESaFQoCVVt3EWckqJXjhpSHjYT8hbXFnGlG7JWfbZRyXdkFG1NcizsbGwZbgju79hUcmrQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6324bd82-7eb6-412c-ea14-08df2dd94553
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:30.6875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mK8eW1p31gHNCvfGMIyd4K2H6H4UdOAkmJy7zuKRBNECS1n1Fqps9Ic61APT9W+5HvKuCI0TyfsWDc+WiwIRkuR1bck3D3DKmpLNGUF+QTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-ORIG-GUID: -cUoww93KufRABq24H3E5qvNIraHL5h6
X-Authority-Analysis: v=2.4 cv=HYGB3SE8 c=1 sm=1 tr=0 ts=6ad6078c cx=c_pps
 a=6N00tFO2at9SeXRP/8dOoQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=01ND9n3NiX1-kDoXiQMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -cUoww93KufRABq24H3E5qvNIraHL5h6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX+jy0iXX47LIm
 O8PKVOEB9NTePJR9ZDP/JggIH+HkbwDVjzCbyuRx5vdyE+PZjUuwrdCZijHpAEZf3PQg35lcSho
 8aWBbcnIn4pfBplU/qcu3DGAFvDimxs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX6L2O7Km3w2ED
 bIweuQmEFMfUzbrqYXHnjLcZU6jFrHsIqc5PYgdfI3DrBsduy7G8wUazZjGGaJaUrdEPIVOZ0mJ
 o66xS9Yph5NNHxy86r88KKuKIzx7N/1qxm6h038zKpy0Jb8bmeijUXcXOYvqx7uX2KsuOLTxrwP
 y3NoHW3B/i6KSdCEpTBrgMdThtBkXSjKtkIpHAkWqB18pAfeypZB8Febbx676hNJKjoseHk6uED
 PThmGBTAGYNUcBJj5KjqssBfGMzIBXZgs8AAzkDPH34SIINK4bZ0f2bmmWviEmNFXttAY1AHih3
 w+86FJcW7nw6PSMCcURjiQUtMHIDtHnP6DXMdViZc+jagc6RkyA5S/kzju/HMg+kijer1r+IQSy
 qTX8m35aA+WQbWHnzXs7qwsshDYamiWWL+xxBdTUOUnp7eqfq+2roZPtZzbh3Af6k7r7hPFt3Oq
 RDlR2MmStbrYGS7hVdg==
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h         |  8 ++---
 include/hw/isa/i8259_internal.h | 10 +++---
 hw/i386/kvm/i8259.c             | 10 +++---
 hw/intc/i8259.c                 | 34 +++++++++----------
 hw/intc/i8259_common.c          | 58 ++++++++++++++++-----------------
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1f2420231f..1921a30371 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,9 +3,9 @@
 
 /* i8259.c */
 
-typedef struct PICCommonState PICCommonState;
+typedef struct I8259CommonState I8259CommonState;
 
-extern PICCommonState *isa_pic;
+extern I8259CommonState *isa_pic;
 
 /*
  * i8259_init()
@@ -16,7 +16,7 @@ extern PICCommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(PICCommonState *s);
-int pic_read_irq(PICCommonState *s);
+int pic_get_output(I8259CommonState *s);
+int pic_read_irq(I8259CommonState *s);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 289d08b7d7..7a2f9addaf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -32,16 +32,16 @@
 
 
 #define TYPE_I8259_COMMON "i8259-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
+OBJECT_DECLARE_TYPE(I8259CommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
 
-    void (*pre_save)(PICCommonState *s);
-    void (*post_load)(PICCommonState *s);
+    void (*pre_save)(I8259CommonState *s);
+    void (*post_load)(I8259CommonState *s);
 };
 
-struct PICCommonState {
+struct I8259CommonState {
     ISADevice parent_obj;
 
     uint8_t last_irr; /* edge detection */
@@ -70,7 +70,7 @@ struct PICCommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(PICCommonState *s);
+void pic_reset_common(I8259CommonState *s);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void pic_stat_update_irq(int irq, int level);
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 14029783e5..f10643a120 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -34,7 +34,7 @@ struct KVMPICClass {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(PICCommonState *s)
+static void kvm_pic_get(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -67,7 +67,7 @@ static void kvm_pic_get(PICCommonState *s)
     s->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(PICCommonState *s)
+static void kvm_pic_put(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -154,7 +154,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
     .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
 };
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 52e24d333e..45db87a2ad 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -52,12 +52,12 @@ struct PICClass {
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-PICCommonState *isa_pic;
-static PICCommonState *slave_pic;
+I8259CommonState *isa_pic;
+static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
-static int get_priority(PICCommonState *s, int mask)
+static int get_priority(I8259CommonState *s, int mask)
 {
     int priority;
 
@@ -72,7 +72,7 @@ static int get_priority(PICCommonState *s, int mask)
 }
 
 /* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(PICCommonState *s)
+static int pic_get_irq(I8259CommonState *s)
 {
     int mask, cur_priority, priority;
 
@@ -101,7 +101,7 @@ static int pic_get_irq(PICCommonState *s)
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(PICCommonState *s)
+static void pic_update_irq(I8259CommonState *s)
 {
     int irq;
 
@@ -117,7 +117,7 @@ static void pic_update_irq(PICCommonState *s)
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
 static void pic_set_irq(void *opaque, int irq, int level)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int mask = 1 << irq;
     int irq_index = s->master ? irq : irq + 8;
 
@@ -154,7 +154,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(PICCommonState *s, int irq)
+static void pic_intack(I8259CommonState *s, int irq)
 {
     if (s->auto_eoi) {
         if (s->rotate_on_auto_eoi) {
@@ -170,7 +170,7 @@ static void pic_intack(PICCommonState *s, int irq)
     pic_update_irq(s);
 }
 
-int pic_read_irq(PICCommonState *s)
+int pic_read_irq(I8259CommonState *s)
 {
     int irq, intno;
 
@@ -210,7 +210,7 @@ int pic_read_irq(PICCommonState *s)
     return intno;
 }
 
-static void pic_init_reset(PICCommonState *s)
+static void pic_init_reset(I8259CommonState *s)
 {
     pic_reset_common(s);
     pic_update_irq(s);
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -228,7 +228,7 @@ static void pic_reset(DeviceState *dev)
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
@@ -321,7 +321,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int ret;
 
     if (s->poll) {
@@ -348,7 +348,7 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(PICCommonState *s)
+int pic_get_output(I8259CommonState *s)
 {
     return (pic_get_irq(s) >= 0);
 }
@@ -356,14 +356,14 @@ int pic_get_output(PICCommonState *s)
 static void elcr_ioport_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     s->elcr = val & s->elcr_mask;
 }
 
 static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     return s->elcr;
 }
 
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -444,7 +444,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index e2f997e161..17040bdb1e 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(PICCommonState *s)
+void pic_reset_common(I8259CommonState *s)
 {
     s->last_irr = 0;
     s->irr &= s->elcr;
@@ -55,7 +55,7 @@ void pic_reset_common(PICCommonState *s)
 
 static int pic_dispatch_pre_save(void *opaque)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
@@ -67,7 +67,7 @@ static int pic_dispatch_pre_save(void *opaque)
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = I8259_COMMON(opaque);
+    I8259CommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -157,7 +157,7 @@ static const VMStateDescription vmstate_pic_ltim = {
     .minimum_version_id = 1,
     .needed = ltim_state_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(ltim, PICCommonState),
+        VMSTATE_UINT8(ltim, I8259CommonState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -169,22 +169,22 @@ static const VMStateDescription vmstate_pic_common = {
     .pre_save = pic_dispatch_pre_save,
     .post_load = pic_dispatch_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(last_irr, PICCommonState),
-        VMSTATE_UINT8(irr, PICCommonState),
-        VMSTATE_UINT8(imr, PICCommonState),
-        VMSTATE_UINT8(isr, PICCommonState),
-        VMSTATE_UINT8(priority_add, PICCommonState),
-        VMSTATE_UINT8(irq_base, PICCommonState),
-        VMSTATE_UINT8(read_reg_select, PICCommonState),
-        VMSTATE_UINT8(poll, PICCommonState),
-        VMSTATE_UINT8(special_mask, PICCommonState),
-        VMSTATE_UINT8(init_state, PICCommonState),
-        VMSTATE_UINT8(auto_eoi, PICCommonState),
-        VMSTATE_UINT8(rotate_on_auto_eoi, PICCommonState),
-        VMSTATE_UINT8(special_fully_nested_mode, PICCommonState),
-        VMSTATE_UINT8(init4, PICCommonState),
-        VMSTATE_UINT8(single_mode, PICCommonState),
-        VMSTATE_UINT8(elcr, PICCommonState),
+        VMSTATE_UINT8(last_irr, I8259CommonState),
+        VMSTATE_UINT8(irr, I8259CommonState),
+        VMSTATE_UINT8(imr, I8259CommonState),
+        VMSTATE_UINT8(isr, I8259CommonState),
+        VMSTATE_UINT8(priority_add, I8259CommonState),
+        VMSTATE_UINT8(irq_base, I8259CommonState),
+        VMSTATE_UINT8(read_reg_select, I8259CommonState),
+        VMSTATE_UINT8(poll, I8259CommonState),
+        VMSTATE_UINT8(special_mask, I8259CommonState),
+        VMSTATE_UINT8(init_state, I8259CommonState),
+        VMSTATE_UINT8(auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(rotate_on_auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(special_fully_nested_mode, I8259CommonState),
+        VMSTATE_UINT8(init4, I8259CommonState),
+        VMSTATE_UINT8(single_mode, I8259CommonState),
+        VMSTATE_UINT8(elcr, I8259CommonState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -194,10 +194,10 @@ static const VMStateDescription vmstate_pic_common = {
 };
 
 static const Property pic_properties_common[] = {
-    DEFINE_PROP_UINT32("iobase", PICCommonState, iobase,  -1),
-    DEFINE_PROP_UINT32("elcr_addr", PICCommonState, elcr_addr,  -1),
-    DEFINE_PROP_UINT8("elcr_mask", PICCommonState, elcr_mask,  -1),
-    DEFINE_PROP_BIT("master", PICCommonState, master,  0, false),
+    DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
+    DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
+    DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
+    DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
 static void pic_common_class_init(ObjectClass *klass, const void *data)
@@ -222,7 +222,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo pic_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(PICCommonClass),
     .class_init = pic_common_class_init,
     .abstract = true,
-- 
2.43.0


