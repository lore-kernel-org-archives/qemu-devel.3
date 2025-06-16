Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841F6C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6qQ-00011B-6w; Mon, 16 Jun 2025 06:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uR6qO-00010n-5C
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:13:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uR6qG-0004tk-5n
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:13:35 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FLQE2Z028419;
 Mon, 16 Jun 2025 03:13:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=DfV7S1WV8AWmn
 LU5o4qReeFLcoCGvi6lhSguITKYe/o=; b=RMdu5zNHPJkZ910vVubkEcn4LjAU2
 EDvFZRhazUj9ri/qZHJobuWWgO6RI+OLTMLobo3EKCvMKpjYv6dFQZdXKrl15DQr
 zbZoJxqvF2c2W4qkpZnLgkugLozHLnxsVpH0YylfADTCjWX+IVCTWqBH76mktpF/
 8GAlAKXB/SMEX08TI6CglivJm7hf/CbcnH8Sbe0l5c/tVEw394KPVW344ececxXP
 RG2t3NcYPANyvWmgsfWv7oJkwkc9OMSwQaeCKUZP1sliFGJtK3e7BhJmw6F2HVpZ
 pTk3CQPNpUUStSyu18RfDqaxrcxQrV0pHyuRNv9J09urXsptfQgYvpQoQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2114.outbound.protection.outlook.com [40.107.236.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47985hasn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 03:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=co96TcsM60ff0vICTw81gz9DZl6SdB7+Ltog7gxn72Ar6j74Q8HQbYQHY+cxZA8/CK0iySbpv4Wq1dGBPOcdfiOKA6HoageQAC8FR1Po+XjUpcwU6pA+S5LAkpxNWiG3o3LRfkRegcYgDBwAzvSo+2F5uhkRNRcTZJVZOUzKUq8ilnR7LTr8c71B5c/A8OFdqYowHHZoG8q7hQwo89hPG+HN9+VUWpH50MRZkV6M6VN1eEiZTw2T9WNmWWIoMvYuE185NH2HDHLeohS9MSTo9jt8tSO9QjBmx99q9/gUOvyywLuJCIImis7MczigG9NR3hvp5PzbkUBj+FVA0qPv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfV7S1WV8AWmnLU5o4qReeFLcoCGvi6lhSguITKYe/o=;
 b=rHZqSzzVOCLi62LrEPjDbbpc/pla0reOj8rpFu1W5LZdybOp7FQpO5jin/P3NxCmZG7qjyF0D0w0S1jtO0joE5spgnYgMf/yrMf1Zw7IZljWBnA8t+MrE3jq3Xiac2A3Ec7dRaMaEXpyUjE6ZlgJF/gvZ8xS/iljaxefI1KP65DHPG3ZufqJ4bIAg2rRuFRdybXHXzcnCsaq5N6rt0QrWVuzyf86UaVsY8isHc9of8I3ZxaBKU0idDXfz0fKS+YDtUico+0ZWMxIx1DhYQiks1omo/RoIfz0UhOcGF2cxs78qRhPj+yp0UPHcBlZ/+ZlfcEUSylYBEYk+HZ5WxgfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfV7S1WV8AWmnLU5o4qReeFLcoCGvi6lhSguITKYe/o=;
 b=x4/J/lWLhpxfLN1vMNPw+9rkJOOtB+zAYAY0gnRIqdOS0sRDXiaG65nV8OWIpBZE4N9fM5KaxsrVwC157mXHW1qRP525VTuO0J5CsoewUmWRW6KnGFJX3kSeRIJBVGt7wBNwGd2L5OUkSKTanEUh5MGgRha4VZKzO7v9HCti8OgwOzLVlmBhv98W/2BuJe1qoO4ARBvfPtZdDIWqhiC/pxncEVrzD1tveWrih6XNy9Iyj6kCSGMkCchnvj+6U811PplhbVsL12KMIP7H7b96QsqdY5SWXZvVagxETGd8Zk0ogiKBtgemsTvXxuwjKxr8fiw4HiLQrPHYZ370K6pk3A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM4PR02MB8885.namprd02.prod.outlook.com (2603:10b6:8:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 10:13:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Mon, 16 Jun 2025
 10:13:18 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] vfio: add documentation for posted write argument
Date: Mon, 16 Jun 2025 03:13:14 -0700
Message-ID: <20250616101314.3189793-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM4PR02MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 323f5e48-61d0-403c-1d03-08ddacbe6a0a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RomEKoPx1FizL3EBsNMcdpE9M130Pkk9hb60GdQSBNvD/hV9hV8hiPGkpbq2?=
 =?us-ascii?Q?aC3oKsXAYliSJgNyurT9nxB+HGNL9qIX9sjKMRzrrxYgsm2QSY8B7/mlO8pZ?=
 =?us-ascii?Q?9FJ+zkYFONGAlzwfVgRQp/rrIHFgDVn2bcht9vx0E9tplzWL0jbVZf0bhwm0?=
 =?us-ascii?Q?Fprj8ZA5XHmAqKiKojXwoSL9GHD8gyPynSaoDvPMqwVxQGNWoswh8ymrXiaH?=
 =?us-ascii?Q?ogVVPBmCxy0M86n3iJkrHawaFfyXXahmZl3fHNGcRt6eZ9991Z7WzUdgxQXP?=
 =?us-ascii?Q?G9N7+5SAhShth0i+hpbPYVnQ6e997oMkBJSdY+NYu9yG5wXqdFJ4GovwK/DN?=
 =?us-ascii?Q?CAhdrY0gCs+kCmwGObFvPSwmB6FrPl+p1kbUYF3TytwaGQipj3/GFJVmRk73?=
 =?us-ascii?Q?BtCY2DiAc4qGUkljarbapSgZmlFO5m+mm7fSxrB95mKgRf1DQR1mnlewnTxH?=
 =?us-ascii?Q?l/6kIkxUu6QupoUdIDij6VO56ubjhtcj/Ol+4F6H3PNdsRtGAkTqPX5PtAMl?=
 =?us-ascii?Q?xz0IyuXI+fbFYgjdiaw5+75Od9tUtVims4f4JtPRi3lBjoyVUHpfS8tZzYBY?=
 =?us-ascii?Q?UdeQOgGD1Gg0WOnMcsc20RdAyDInJBqJkPJlXiPKO3W1cO3X2QyFMphCq/nv?=
 =?us-ascii?Q?C3916js5hpK43nDWtxmrPt/8P8m60Q6UzRecNc8g3McB0DTNp+JM8VHvejKF?=
 =?us-ascii?Q?aXaxROObfq1UZBxxv6Z+1j9ArxHJnr4yZmLLSBnGYDgzrKIRwowgLhb0skJ5?=
 =?us-ascii?Q?PDO2QOkkDSHd9/Bd/s2zZx6THk9nA/VFM2k0vll3A12bhPx69rpFwWho0g16?=
 =?us-ascii?Q?svsyqVa8mSyJkKTslRwiIMdqt+nyOoEgc03HctiD51jp8AZvWoWUVp3wHaLB?=
 =?us-ascii?Q?5CiPyu/3ljqR8R71Bt0NvoQWeotuIqIjEe47MDFnUHXOmO+f6n2zlh6H4sWv?=
 =?us-ascii?Q?9Yb5JIUIx4Y3oZcpsafPIfOwpmB+2QYZ5eb74Rza0QlzoG7HwmFA3jOPDKZv?=
 =?us-ascii?Q?pfsKKycUZVYUE6+rKn48VX6CqFUVdnOabvdtbMzHnG2aZgUwkuZEsLH7neFR?=
 =?us-ascii?Q?P/HdXf6nPsFatSGLK1pJ3czgbS+90N8uI/IG2grujcoK4xlJZblfIk0uxMiK?=
 =?us-ascii?Q?1JSeeeij0JxRAoibsscomxoaPZwf0W/sm8Y7L8kqC5DcTKS4IsbCy1qjbFcs?=
 =?us-ascii?Q?/J5ctQPID3j/+rZlCvf6XicLT/Nu6IjAJ/dC7qTMiW2VHSkjrMoRn2jmq7BC?=
 =?us-ascii?Q?l2ftuD/Kc1xxct+jseZyaRrpd/uTsyTV7WcaMYczt5acQDo9cU0UeSU+v5II?=
 =?us-ascii?Q?51bXMMKtKeflGV8csyg8w8r4urVvgwo0EZz8A5ml+OQpKYDFrl8TeWWycpUW?=
 =?us-ascii?Q?T2DMFfY+UBirHx9WeF1GCw8NwheBoJAC9R3kaoJz8+TezXpu0SiT/AvMRy6q?=
 =?us-ascii?Q?NrLokjzQgII=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W9u7q63UT6aOWIbtYes+XQlfVwaFe/66qsCY3pGCqlOK85Q6yyYxG81Zq5wg?=
 =?us-ascii?Q?NVuNd3qYplCOQgP0fC4ScDfDR/KARpM7PsSbw4CckT4peDo5p1uGPv1lVQ8Y?=
 =?us-ascii?Q?IT/fMM8FmsJshMqte2CZnS6TRgCfZRZwgH7aEL5rUOrGppCi8a56zNjrzevH?=
 =?us-ascii?Q?UlVu8K26ORd3yoOUsZcyII7ECZdXy8kfBrPWvQbMS+kdEf9X2CKYc9hdJRtM?=
 =?us-ascii?Q?KuVshjfhExcCYCG2dunDSIz5SaAJk5STpNC3fzUkFbtqGsKT8hVJ/b/K9GLy?=
 =?us-ascii?Q?IRAgctXImlOOsfeQfu1L+5VgMFewfF4OBXhqkV1PY8JUNVFXC/znaBw+o9Lj?=
 =?us-ascii?Q?U8h9Nksd/GURsPkrLq0TPvk7a+6gBmmFFEmujrfihKMUDEJAYyLgL4sECyOq?=
 =?us-ascii?Q?FAiBls+QiJuOOR+iU4gXFC1QJIDdnP6fLkMkntVKCSYZ5+mIr8+jFmecKTYW?=
 =?us-ascii?Q?k/zORrY+rOrEG3uC3tg41tE/R9eawtcD07sKEOu2Ysk4nDr/NwusWgFYqfqk?=
 =?us-ascii?Q?A+ttYhJjkH2L1DYCx9XuxsY9T7zGYEEVdWzAGE9EGwDRJVeLs3xYCdg8eht0?=
 =?us-ascii?Q?RCDUvSWDSj+BGaFyBm5SstwG7DLS5MYWkNONe+9cBBA0CXMQLKx291moEyfW?=
 =?us-ascii?Q?/ASAu796UuGhbyJFgpygUqIGQRp+oq6wuC/sYUtKMbRhJQwZTt0+lKuUR16z?=
 =?us-ascii?Q?VJDVe4lcRS36CVJ0XEK6vbZJ7WRqmbb7hWOthSbV1HZC1qZr/c1HW3LCOXRJ?=
 =?us-ascii?Q?El4FtJP3mSXpMvHTXUWYgNHCGgo8YGn6Dh7f5dQN5cmN3AfLbB7fwwqeGz/v?=
 =?us-ascii?Q?1IWQ3VddDHeoLLuhnBgThVDJTYqDbGufGIADfhXE0ztZp0UXw+kNREIJlr2f?=
 =?us-ascii?Q?6XoXwljVroMSLwkvl+5qIwHiv506R3tD4TxwmyEBM1dWIW2PDwgfiG9NVmMp?=
 =?us-ascii?Q?qDU4syqSnO/xBBgLH87cvB9yCJkn79buOftCfCdinhk2ZV+Hf958vC/MnTjF?=
 =?us-ascii?Q?auT2X6BFxKOB7KukUX5x19PETOJs+xjFRIBNJyDoPcc3Zl5OkETtgkZgFrTi?=
 =?us-ascii?Q?OwvDF7Jv881xE0AUgldDc7wJExIQD5qkPXfxMWGGc6ad9tegPnogRvafaD0A?=
 =?us-ascii?Q?EE+PeneCK1HdkTCf965XhV40MZ8mWIttYsx3QJDyhWtt/za890hWvOvy7//b?=
 =?us-ascii?Q?xFCYXMkmdt+Lh9dacZHq0wTGp2QwkzwrUpSOyHYAzE/vo315rAxK+0Iv+szg?=
 =?us-ascii?Q?ZuWctcCaRDkUb/uU0dDdqWxfKb2uatyB4fHNhhqHDYv5eHdpO3Whp7HSP4DZ?=
 =?us-ascii?Q?QfQcZNBueUVWwK7kvMmI6IOrsnWVePK8IsxPVIDYIdIlc5ogYvjI1/qUtMC/?=
 =?us-ascii?Q?dguMP1t14HXmRbANG2XqdVLnMnq4yqE50JJ7qQgteU5Ds0M42v1h68DzdHOk?=
 =?us-ascii?Q?w1FKgKJOzqYfKhiX2QBIvdcxmaxXDTT3O1Q036JY33FZFm9OdN/0jY22wmn3?=
 =?us-ascii?Q?YtOwfLTtQdHrU2O06HUdlAo9WGFOGE2G2PSvhVXDNZs6Umr5iKIabLWan8hq?=
 =?us-ascii?Q?huFFseVXmq1URd8UIyrE3tJX8dFgSz5bGC2y4RR0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323f5e48-61d0-403c-1d03-08ddacbe6a0a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 10:13:18.7635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d84lAMdrn+8cAPsmVGJuHBov+Lfma95Wa7wTMXNVKTtowCL68UFiaT6vdGvhRdetFXP1hmlDY5INOnn44MmXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8885
X-Authority-Analysis: v=2.4 cv=HpR2G1TS c=1 sm=1 tr=0 ts=684fee42 cx=c_pps
 a=1svfiJX8pwi04aWDAs+qXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=r4HoU7_-Y2h6OGkbW0YA:9
X-Proofpoint-ORIG-GUID: YEU6ilOdtWjK2_uKMIapSSJ9pfQxlO2i
X-Proofpoint-GUID: YEU6ilOdtWjK2_uKMIapSSJ9pfQxlO2i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NSBTYWx0ZWRfXyP+Pq17HyZZj
 6vMwKukgHfeOViWEnPVRNWxzAAhc+mUzO++0wg44xk8pntz7mNRaTSNY8mGW2+hc5SkpRx6We2m
 +d569DG3AyfeCtflkGgUQM3Ks48cJYIe6Xvh/4goRBVNP5BkR/Z4+T08FIgzDNEJX/hsi/B8YRo
 AjrSpMKlQz4+p0hlvWYuj5iNqP25XyLfy37x8d93T3sp3jtsBthHafPMNW7PUAjGnufcAhiUhgH
 S3Z1VB6qkqtmF2b8axfE+lJxdrSnkqfhdVD6kTrMip5lVpuHTa6hIvdnP/OCJPaPt4YVsKo54tw
 Xql70QEGlI8tA4COM4Q0WFXjWT5eRUnSKXKRwXLHhAs6IqWzw6HyWj8l5glUes4ln/ZTmatTZoZ
 gR3/tuiBf1TOLhTk/aTyIws31ISKJsaTGGbG+liV6KK/TR8N9m5HzqhmgxnmQYc1WTUQnVwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index d45e5a68a2..abea652be2 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -240,6 +240,7 @@ struct VFIODeviceIOOps {
      * @off: offset within the region
      * @size: size in bytes to write
      * @data: buffer to write from
+     * @post: true if this is a posted write
      *
      * Returns number of bytes write on success or -errno.
      */
-- 
2.43.0


