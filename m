Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2082DC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNd-0004Et-Re; Thu, 19 Jun 2025 09:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNc-0004E8-CK
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNY-0008Dh-26
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:35 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8A05w013187;
 Thu, 19 Jun 2025 06:32:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vg7/nd9o+jHifUuxhL0cBIPbJzHOAyd4RzxP+M50t
 z4=; b=bNwDovPzWKZzLboPv9iwhW5AoqJuM4H2v67oPNHhGB2rbVXTTGqc2pEQb
 Re7EAjTn4WlQ+tu9XCTaWH4/EcJwczvjJ1Zd5TFht/q1gerStXfwVDiSheGTMItW
 +v1YelykUgoBvJTHK3guNGr+8ZN34eQoMvg+T4obUEbK0r5sgHaJCogs7Ps95YCq
 oononmLMWBZH7xjF1aSzEHFbDmvfGLORi5gj8jvO+MYlqO+HbPXR2ZKTjZ3wsBhv
 gqBhfn6IbVkrJ8IY1sPHGsTjgRdhmgFSwJIGmfqcirubK4MKkscg6iaVawpqNWXn
 tOSZT4SK5h81GmVtKvQ6roEsMbU+A==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwq7-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/ju+IIBpNqtuUhqKhCccS37QEycbYYHZHiIBCqukqFDVO4GnR4ZDmf/5+GKTKlKC/Drbz4739sNPybDgDBh3cpR6fYDdP3BZZ1VE5qmyXbqxFlwz1DBlGCQT7023eA5EZmd/69gPLLouKt+nuVxziOVrtQtytVSRgQEpP8fOfipaXn6bKt5ZqoMq19ysXwSmapW2eDpDwYrErrS5yGGiXxWQ26aTj7fTqacOgowWOhfxNYi1gBbj9s3rJ7otabGG5LqB0hjGWbQqSZ6RgUvOwn/5ajNA5kKgvpL17bdVbtWGFexO9cJdwtaYK+0fzez+dr7pGf5wWMlFMBkrzHKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg7/nd9o+jHifUuxhL0cBIPbJzHOAyd4RzxP+M50tz4=;
 b=RPgMLU2G2Xb+fvO7h56s0XRmVKnCrhTNB/31WK2ZaGe/i9OxSPsYwScDKkAeHqaYSVE+QNSjm0KF6R+LnKykaljkk+4And5CsJ+0pg7+Da53u6B4yXYSUkOSz2EnM7e3MAyd//M4MB49tYQKhvM3TD+S1jfolec3ju+nY1LAOz23GjRmc/o01o7PxlWzjbaEh0Ku0Gkv4YD6ONngN+2VZFc+N2/c741njj2KII3i5Wu6EM9Q1b7b95Eq3ASNCVTOHvNW53Q7VVhvLamnahyynenTaOETltnsqao85ZIouNQ/qnDW0RyLBaBcQ6oJQjOJAW4CmGNpcmJ1sIzW56cmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg7/nd9o+jHifUuxhL0cBIPbJzHOAyd4RzxP+M50tz4=;
 b=XsriCabbni5B+kdIA9RXG1HpLGi4prcd98hb9giY3vECmbrbz6yupeDip+vsl6oCRS3mrKCNNq2SC/8MAjj/fFGDLZwl+A6iu4wp8A73hbeYvz1MKqKP63ceLY3BxYfsjxudtwHXV7Pj58ejN634NBf/4dm83IbQsrFejQpv2JP8i5cAFE6TEs1Y/U94LAzbaS/X4hbGHIYhzhwPGSPqxU2g+51fH4boz8wCq1WSkj6lRlC9XrGNR+b8m3lxD8DunGYKubNRuPDI27Waamx3VV3gKqF7XaBysRkrzPzsuyfgOADgiR6lkgeQVcqF1RH1A/pk7O9Tf/4u9hDHKHT0vg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:17 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:16 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 07/19] vfio-user: implement VFIO_USER_REGION_READ/WRITE
Date: Thu, 19 Jun 2025 06:31:41 -0700
Message-ID: <20250619133154.264786-8-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: b109b47f-7746-45f4-f53f-08ddaf35b54e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?00t3UYdXEqpPOC486DlmTQ698ZvWapb/EOmwt2fzh/p0u9/O/+EbwpuT4x4y?=
 =?us-ascii?Q?3/cBHxTQN503rspl8Gyd4ZKTtqM52jFfgeR6koZqIcjKXoT5VpMWDzHLqduT?=
 =?us-ascii?Q?pTjUDHHqCxtQ6/oydBphncXHLmA+NlUPbKSB8q30gjuuKP934TjKkriiQRVO?=
 =?us-ascii?Q?b6qqVg7D2Oh0eMBOodN5szHP6FvypX4dI8FrppAdb+Zq2WMPUVlRb7hArSXN?=
 =?us-ascii?Q?3KLEvGW+TC+0Gr7BOv6E+7IKACrPXOvkhyjZRA5Y58d7zg/cjRZEM5/6UbA9?=
 =?us-ascii?Q?nFz2XVw+bQi5GjjE8TIX3bRyQFOHbAdM3AmnMxWmQai6oIYx+wHbB4w5n0Vn?=
 =?us-ascii?Q?7Jw2Rp7BT7MG5MtUlMG+E0vbcwSosv7WpupZ6x+pF/hngj0eAbOjQNHXIT1o?=
 =?us-ascii?Q?PU1YII3qlj13Xr/KutMWzc9bsAOBpbYM0AFkDZEC5A+ss/AmOxbo3RwPAFAc?=
 =?us-ascii?Q?CGvhRqpjYS7p43vGsrrRAsm84vGcKNjTOsxApLnZZZgErakINKovh1884g6F?=
 =?us-ascii?Q?Pb6j0bFj2CrSxrtOh0j5OZN3IQsgRqSPA54LtygUDK/u5gCbodO4bSbtTCrZ?=
 =?us-ascii?Q?YbS/SnTNL1xSJut9x3fU4gQZwR2/h6buC1G1pm8iyjCqXitGBHcoZFrvmzH/?=
 =?us-ascii?Q?8d7HIMA6FU1N0V6pXGnFy3PpERKdImQJOHazvicGCje8k3ydZKITOHJWhthZ?=
 =?us-ascii?Q?xrbgSOrZZQng+oGxPT1Tv0H14VJSCTUnNN3lW6m8D5yfzuinD+Hu0mE8BtA3?=
 =?us-ascii?Q?2BqhpKEvUopAk23cRSAg2p/yFXL2+PI8bwJMEqdnmFpoEnmM7SLzor0bxhYj?=
 =?us-ascii?Q?6txfdcZv1cRq75rzv+3n1TIEw6Wyf1+NP2yv4bzcOXS7z6TOfc93Gxa9QcNe?=
 =?us-ascii?Q?eRnrG9Aeemg3FFyO7LA2xQ60DKt6C1+DetRCwyYW/x6EVSnz1rrgDllyrz+m?=
 =?us-ascii?Q?w9LWaUBFaqAphs4UIw+02AiSfKOMTJavfaHDzETefeiJbKSbJwdkUkJ4AybS?=
 =?us-ascii?Q?4PRrm+X3G25N4SYg9Fv4+Gpjtk/u6aM01i3g8DZfB6ugNVH3Rv2cCxX01HZn?=
 =?us-ascii?Q?FHevp9IJge3ovRhYNR5mkZq4dKE1bcs6P6RZoZexxLcSlw2RnhEapjhFVnLe?=
 =?us-ascii?Q?Vt0w3LzLr9SAvbtPItOaBal7OMzjr5zex6fqR0rkmuDmCSHDwQa+ih+xmjRT?=
 =?us-ascii?Q?6qfWAjOG5nEgBuIj+WHrGeFlEa2BqGNX/zxqM+l0Y2YY8O3ZAkGlGYgnoB8/?=
 =?us-ascii?Q?NzsyoKwwGE/T/a6oo6HUR0o3JV3FK7RwZ9BieLe9otUeYEQMtiqQlTZ+U7qg?=
 =?us-ascii?Q?Wxu3ZhGhDSR9novpFAgF/PmF97AtVDz2Km0h/iUZr4NDZGV9CflVlaIg9OEE?=
 =?us-ascii?Q?xbY2PoUVoNxDoVDcPqXtYy/5WNUFSwaWRIDgzWjmVIabr3nmwoMUePzPmVP+?=
 =?us-ascii?Q?j7gbutXDfmo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Qi7rcqwXtXXvG1L8DvQTHhJvf98zDV3JyA9g2bXe3QwJ3kwuhlsLqthofk/?=
 =?us-ascii?Q?E5kGOUdsdQHsAr2Lyyf9YICbm3q0OOtq7GSCfAVZ7OaDO+3MfP4s2Du3MCrR?=
 =?us-ascii?Q?1jiYJ9L6mXN4aDNDfYUfu10Bd4s4RTfJztHu7l/sKD6VwJe9I3eAG9Y2d68Z?=
 =?us-ascii?Q?YkCYUbG0Ka3e7xMPTJjwuuZO65LwCI2jYY0rQ8TT4Mp7BaRzOnaiu67e28oC?=
 =?us-ascii?Q?+VD4Jhn+VwPDQ6qMATplaBbdmkDUii0rYJ9Bty8pyY6eCkQF7H79BqsCJiqh?=
 =?us-ascii?Q?I6hkls9J4hWLrydhmUmCRoUQRE/y0wSEBOKJm8Lmb8wK2oO0WDTaZOAMFywl?=
 =?us-ascii?Q?pAgs6pBRsWxv9xtVLG7FfWDcqg8pHEbvxx7AfGARVSq5cyR2v5x2TnQmTBpZ?=
 =?us-ascii?Q?PLKGq92nVO+8okhe9/49EXnHFPdO1vT4b7mQHUY+AMPkKcoyCh6p2lrAdlKK?=
 =?us-ascii?Q?ZovBVgKuJbMGpPrwCmHqkj4lk6TXYNkX11UnSCLY4eJ7gCcq7b/yTjh7CQIg?=
 =?us-ascii?Q?bv2623ZVG+y7GboJXFYQxMm3amEcas3+TBkIpfi4sQcnwqO8mLK9SX/0yYVN?=
 =?us-ascii?Q?clUhmJ6SXVevGl6pvF4CtsnygAjeP6FWkBjc77+q96Kaj/z5j683cKt1H5zD?=
 =?us-ascii?Q?e64Qy8nSnYy3LdIYaNGpVXPIzeEfU0Yl2Hmu+R1mVPnJQv+rqVdAW5d4/fjg?=
 =?us-ascii?Q?/MJl1RC0AnDD+0uXBQhkzyqDfhtMlt/Q9Kue7CKX7b9a/xzMGrzoscwl58to?=
 =?us-ascii?Q?i8a7Rw462xKSbPBrh99Q2G4lAli0Vcgb9Zv3Oqfkezu2dk5gTMQZyrIFZhGj?=
 =?us-ascii?Q?OSjkvHoxbDDzMczCiDzrCYFOLrH/C5g/w5XvlPX5Qf1GR75MJoERZuvJ27rD?=
 =?us-ascii?Q?uc0/4k2vE0uyVBq/rqghAWPXAuoc6oynwnpo1WOZuYVs6opWtEJMYFRw4ZJ4?=
 =?us-ascii?Q?HVmkSdfmE/1kqlOM4BMc1XpTF3pQUJxbKrvjCWFnm/a/P+CtBShrOK+zFtzZ?=
 =?us-ascii?Q?Pe2QitGMYNy1zWGTCkkI/cZ811b+6SIbltaoIWMxbMBHotvwkft79lMjQWTU?=
 =?us-ascii?Q?cD07wW0LutU/NWnLB/fp9HFD2DOK/W72P6oIgJWmyH9GIenN1ilFRpd0+jc/?=
 =?us-ascii?Q?Zmxzo0NeZPiB4Nwm1bD7teDF16jkb1IdSZfsunUMcTeBp1L/dFg91CM3fs2q?=
 =?us-ascii?Q?rWjaYIoNDVGTeUTff43TvTs6PbkN8C/5RnUAFjyvaYEKr0n6hJP2lW/sfrK+?=
 =?us-ascii?Q?euGMvqnISUBEp/W19zqkQaMD3x/UVG6QHOfFPtB1yLJnwuLyj6/3x3a8iibO?=
 =?us-ascii?Q?qzpza9CFqIEHQMWkh9kOs83lenzifuzNbTQrPlVquLukdS6jQ37tmgBUnRGa?=
 =?us-ascii?Q?s/HtB7TGDucg2rSz0JBoOTimH3gZuKRJO+ZDCZQPPOjB0V1gIf7LFtLveZ8n?=
 =?us-ascii?Q?KVqJROdnWk5P/t5GjG1xF7NvTEbQV/reRccu8j5Gi83oMotIQf0u7TqwAHbA?=
 =?us-ascii?Q?miDM+4rmnibqWRzRIGxievz7HgBiPFbl1M/PTOy9pt2s07HuBoAP0+MUKSuw?=
 =?us-ascii?Q?xavmpm5Rz6s4dfwMrr8rZEUS1Y1B+5G2KDgTbZSu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b109b47f-7746-45f4-f53f-08ddaf35b54e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:16.9198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z2KIDJ2G4w1Viex+Uv8lBBPmkpQANpCc+FgUJJJD/jRvbazflSw25gHIYWeYQfufy06Ql8Jonyvh8kDv3HTWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX00AZ/pV1NXVQ
 uzZKfncRchrY/Kx6u9oNTsjYOg4GB2wF0WVjNM20s96GZac/XSIcBriOQvQPo3Ai2wWVYvwvNuu
 8+rpSpzfJqYxmq7ID+y5/htuuAWRAiKobaGl+SdGlGEzEVsl0Xb2SV7vZRPbObUXnteOlJaRMhc
 rsLL+guuh96Myu1VjLyxpLYxGmZrKQxLSkmP8XSxXfOFt6p2dPggDLz6iFIe2/5xkdsw7FPXhtC
 iUKaP87Roh99ikvgKoFkiGid/6aqQM4TWMVPzlLPTlMX2W8U6oP3f0MCW31kq15jlbERiNm3tmO
 cK+SQcCGpnGVmw7Hz8lx0kNu7iVVSWT8qy79KnxNvI7xc9ZJrs9OV9fwh+RCnUBHrLhtrWDnob/
 st+Dj3fG9BCX3W/TLFPvijBv9IBeC7Vk+lrr5cr7ZECpkJNAPhQzMMi1HvaiV2G26+K3m/pn
X-Proofpoint-ORIG-GUID: NkRo6uPjlvgbl1aakIwRRk9TAoE1jyUe
X-Proofpoint-GUID: NkRo6uPjlvgbl1aakIwRRk9TAoE1jyUe
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116c cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=lEmlVuBv_BsZ2DPd9E8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 12 +++++++
 hw/vfio-user/device.c     | 67 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 3 files changed, 80 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index db88f5fcb1..0cd32ad71a 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -138,4 +138,16 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_REGION_READ
+ * VFIO_USER_REGION_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[];
+} VFIOUserRegionRW;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 3d39b9b98b..8ec5aba632 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -108,9 +108,76 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                           off_t off, uint32_t count,
+                                           void *data)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_READ, sizeof(*msgp), 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    } else if (msgp->count > count) {
+        return -E2BIG;
+    } else {
+        memcpy(data, &msgp->data, msgp->count);
+    }
+
+    return msgp->count;
+}
+
+static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                            off_t off, unsigned count,
+                                            void *data, bool post)
+{
+    VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+    int ret;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    memcpy(&msgp->data, data, count);
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    /* Ignore post: all writes are synchronous/non-posted. */
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        ret = -msgp->hdr.error_reply;
+    } else {
+        ret = count;
+    }
+
+    g_free(msgp);
+    return ret;
+}
+
 /*
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .region_read = vfio_user_device_io_region_read,
+    .region_write = vfio_user_device_io_region_write,
+
 };
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 1860430301..3f5aebe7ac 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -8,3 +8,4 @@ vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-- 
2.43.0


