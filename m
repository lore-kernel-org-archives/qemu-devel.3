Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81221C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn37-0001gz-3I; Thu, 10 Jul 2025 04:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn35-0001cz-At
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn32-0003e3-SE
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:34 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569MJAsn028318;
 Thu, 10 Jul 2025 01:54:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ng9n9bUgxAGCYCeQjGtwS5tMu0TJ3H20zPfyrn3zf
 fk=; b=GtAwx2tHRQMmQA7d1Zy4Boy8UbggrVEJMoSviMUKoL4U4v7XdWplRzHYQ
 KILRk95NY2CJQXa2IuFsXA+rACmS9J9WtDn4EU0qfP1gDPlnIAy/iWk1UblIAgXc
 3Twh7WJoRtrPNbla6Kcc6qrQynNxmAAgtjdrFfhlm/2C5ulwm/F+tia6iX01iJ4t
 sEHoD6te+aQncgeOXNFtJzDAUk2U8AEMDAbZKJbMQXCV88ayNYt7uwKromVR/V8G
 aIPOHibVf72FGRonzWGbtdU03vZRaqKejkWU9whOkt67ZLVZqLCPDCEwTS9zeHRF
 mkGBinhIeIwPS5UTAWBaLntr3ZWxQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020082.outbound.protection.outlook.com
 [40.93.198.82])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3m150my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT+JdYXkVbyciYPUTqSQxSdaG5J/gSrKuk2b49cYDuKBpUVPYmkEp0uI1mVgz5tQXAM7RYUMSEy0Ub8SwVisLASXi0PaQkMXfun8R1NG45VSrXUb24bL0iDJsM3cFPm6m8G/T9INB57jUYOTXI2phYUop7bYB+8mkrPp3MVz7FZw/ho1ytxCS5SzG6SpUlonZXG5FXfbn8sCGs20U0Et5eih3Kmh65kImNF+YRwZjO20Yxb9Xvqzy5SasjZfEleLSpgg1lyZIBG9gevsFzHjuHodJaiEvsVlnNd3+QAJzYnwswaHeiWVwf3w9TM+gCQQ64gMWDK33Etq6uzqZbABjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng9n9bUgxAGCYCeQjGtwS5tMu0TJ3H20zPfyrn3zffk=;
 b=d3Dtiev4xJtfw0+VNDuzxRlmsr11YRy9FBt4T5j3Aaj4ugEauAXLXbZCeHHygGipE/zrMSVdgYa1LMrhQgoL6NHPkexx4dMfTIph3kKm815ey+Lm3U+3/p3xRCLkIOuF1+3Ia69fRivqsjt6BdvJdBiGUvfw33OcsBgMXY1nlItwxYxDho0tL4HC/7E9Q2UVjCy4Oz+KV3f8AYPWIJ3Fss5hqeD/+luPSU4VD2ITr+SvNvjFOd1Rlu4xnix89SxgrCC8K3vlNVA/xR4m/DnNALfUr4iyzp0gTCRYJG0MYP3cERT3nUFklZ8rPc63NB16biLpOkNWUWx0rgD3hePdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng9n9bUgxAGCYCeQjGtwS5tMu0TJ3H20zPfyrn3zffk=;
 b=GMpHKjkOkl8yQcyz7TuMpPYPf2ZzLDavgIRpNwHuLFb1QiByHtF4UjziYmLYwLWzFBbRXceFGoiQe/EE9qdxVmChR+zXgre3JZGUiK7KK3c3KRLfh3mAe0sW2sbH08M+moM4V1CgJXVvRLaA+g+c3LcadswWAX6IgA7ITFbpIjvti99OGzY52YGlgBN9k+aq/+MRr1P22lXNVdtANVje/q8NyLT4kxEZOVGcsxw2sm7hDOvnBbe7dZDAoDEQIhVRwMiBlDOMvJiwzCn1z1chZsWZa8sRRskjW+F4WG4ev1c0of2qt9fBvcmV+52W4etJD5W5Sv4/w8YFFEXaXvOC3Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:54:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:54:15 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 18/18] hw/i386/isapc.c: replace rom_memory with
 system_memory
Date: Thu, 10 Jul 2025 09:52:33 +0100
Message-ID: <20250710085308.420774-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e96ef16-a08c-4f2d-452e-08ddbf8f595a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z7BAHggeU/uL2rvfI2EW/SYrPgDltz4W5mmC2MMYdmOmzuxeBxdulTHS1plf?=
 =?us-ascii?Q?zkLKKMUN/gjNYfuxGuEt0YssEQt89CkAxl35Jzg9Hijsq2aIwOiosPse9y8m?=
 =?us-ascii?Q?S9yTy/lfo/ma9OuZjFxqepqRjTWxkwYz+WyUBXVYkon6TOrzsM/UhTi7Wt32?=
 =?us-ascii?Q?lSJDQs2mo90YsQaOvy8fAbzZpmy9f910DoQViuQ4ppeBQblkuiJMKh1Cd5tI?=
 =?us-ascii?Q?gp0Yyb8q9tgxLCDCyCHbMnZMcGkX/uMNf5eeiHRsomsKhalPy+L6I8u1hz+R?=
 =?us-ascii?Q?N0nS4PxlYKMMIsN+phEOWqKyRGRiUOtOWceDKr9lKxkDjoIbJj9aAlFKrQhn?=
 =?us-ascii?Q?WeQ1ukazh0+JAd8h+lq1yiAO+WghWO4lZwXbb8F3Ex6Xan4VHm/Ngx1bwU83?=
 =?us-ascii?Q?8V7usWoFhpXfXEww6lqLoSiMMvfaS9mrObkthMX2956xjRqOSZZgtx2H6AJv?=
 =?us-ascii?Q?nosqaXZnqS/Qmn+/MauTEDQxhcr6FeqAaSBnTe/jGytgTZ6tmSygUnqxBnem?=
 =?us-ascii?Q?WNn7rTdLcyve7lXe2UQshtPLG0pT1/Gjc9eNndcoN6WqdNi8DKsiLj38D5Il?=
 =?us-ascii?Q?DOGWWS7NKfuY6XTlbOCLyTStA3oGx7cu+7rUqtuLbXfeXUjP4E8wVgSFnpWG?=
 =?us-ascii?Q?7rFEuDyaTQrawQpTj6K3bWdvSxM94Fg0/D0ew37+HAjmGIp6Qbxfjdkqsyn7?=
 =?us-ascii?Q?h2UVH7sjRptwAYkW44Rbk61UxNjvqlXzmpy/ZZB81P2a6iK3a0aZjyMVrLzy?=
 =?us-ascii?Q?K2XIRt+bkhWW/rndKpawzL2TemSeyA//pD5XNCxLIWd+OIuk8Jd4qtAL//m9?=
 =?us-ascii?Q?egGPdt3ZWzh4ThdNpR7NqIgD2PLuwbAP+Bfd0HoZvlM7UgBF8vNtDdp+FfDl?=
 =?us-ascii?Q?jxDed9uVB6ASk1pIy45eA/N7dbnTlacy23JYVMPLHbM6wMogk6M+bYjendrd?=
 =?us-ascii?Q?23hdWTSMT5N+7OzIzg1YePmaVdcOR9GW0nNaRDIAHJ0B6VJjb5c4lWAYf3w5?=
 =?us-ascii?Q?L3AbKxRjqNc1R8HGXdHqYbo88e/1qQ4lbbBT/UmXmdb2j7nodQfrh+voHhYG?=
 =?us-ascii?Q?OpjF+yPsMoD5ze2SIBuHHPv6nYkYBDkRDuoodV7VeuOd5KXNs+0Aps/ya9v9?=
 =?us-ascii?Q?rQ8tRDWUygNn5OoH9DhXw4d2wrDr6UKTxYn58FjaK/vk0Gtvlz5TCBibisE0?=
 =?us-ascii?Q?QJQgKGoKoTE3i5tnTE+EfqPP3EwRUKLNNmf/qWBLBQYOeIS3Pq68A8GyLkKA?=
 =?us-ascii?Q?qJ11/vMbHIjyb+gTJhxqkU4zy8v7FNTQ5t9YddaxsM5zJfUV6fB54QNkzgiy?=
 =?us-ascii?Q?1kqmMVmBjPv9Nr/pDMiuIWhiZtCDB4MQFMd2pSxKQww+TF/Kl9Omt6EPGlGn?=
 =?us-ascii?Q?xBYnEXdwf5f1M46vP4x01DwszmUaw7z1KubppG0Z7iGtnEYK++P48tIu9K9y?=
 =?us-ascii?Q?3/BiW8XmrJU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3G69uPOm2PUwwdDOxyo/AOdVecitNPseP8qJVbPntBeZChVITZAUcRhVTUn?=
 =?us-ascii?Q?SCGr3/d/PlDaO8KEpj8USQ3aL4meMvevDKu8mN4IuJTe5gIXxTeocgkGLz7J?=
 =?us-ascii?Q?hqNtgILObMOoFtuRMNgfkLSL/yYwnSI8Jc1ErCV9jFiWpFTI88U9uK391ULY?=
 =?us-ascii?Q?5Dil3Gp7x24XBE+nbO+s0USnQm70EKVuoZiG6l8F+CFa0vCtRXalvFB0ZCq7?=
 =?us-ascii?Q?vPPL66vZEZwl3LZgXCgs7M+Dho6lz+GEjMeK571ltTfowE59GgGEDFiy8JJp?=
 =?us-ascii?Q?QGgcZ9fWqpI0DYokXJNvk5A+8DofMSKOgg/jxANBa6HQuSXCqydit+1ads/k?=
 =?us-ascii?Q?AQRwChfqA+wDGn/57yfY5ckatvGEDaIQQU3PdtZBaCnY0a3WIdb9PBL+vvFx?=
 =?us-ascii?Q?pM55R85sVk0/EZUjoRXunmwbBGkAE0Ay7OlwKNmOzuAok/F2X2vqfesSr2Zt?=
 =?us-ascii?Q?//n6wtb/aDK8yfF0jW/dWRz25h3ny71VZcKvwSYJSo/bpwWROL+KB8Fd3lnX?=
 =?us-ascii?Q?7ajs/vBdZaG/5OocoaLptZA24vFmVFls0xDwYj9906d9CuiaX2pfh5Ir+Yqk?=
 =?us-ascii?Q?sQaaEsK7ojeJQ61jXgyKKYTCP4VKPtW03Phm8YQxLfaNWptaLUFRERESG2Bq?=
 =?us-ascii?Q?pBvcfwWNgA+iMC9YEivuETRq+bzXinHuPk5abEsYeXF1Cp7FtZg6rg6kQMDU?=
 =?us-ascii?Q?g0x+DCzHd1kYmV5GPZESZ/AqHIEHDG/4aJMY2DaePWP7tVq4IFV+LSFRB1ua?=
 =?us-ascii?Q?YlOgdUjjklYzkwRfK47tSuJIao8YWpD39X9Dm9/55hLca6lIEdf7+O9v3u6H?=
 =?us-ascii?Q?+OoGuYZKKoLheVTM+en2O4A6XA3X7Klzj9O7otEAnNdYX3t5rgC3EW/AIQtn?=
 =?us-ascii?Q?IkTAiHi6V/RbRTmO55wIgXnONuKgWA5QMOwFCMrXa0PJvQJ9xJyKyz9o+SGW?=
 =?us-ascii?Q?0VPnXop7KuVleqPbpt5fh+wewdGMf8i9JoSv5XykdcJbK3elrFTGtHUyjVTy?=
 =?us-ascii?Q?ZlWhpv7PE2dzrXhlUaDyShMp167pQcKt0gOX5rqNzPzoYczBxKx8eXH7U8zI?=
 =?us-ascii?Q?NZYURmyn63Z3UGIfjkO8/YxG6LYlKgIElSer9am3qTUe7k01xN8KnmDtr8AI?=
 =?us-ascii?Q?YA9rtZlB+13uWXkMdYCYeORKHeKJGV54619FmgcNJVm+gY9uVGXouGDr9XgI?=
 =?us-ascii?Q?DjEYTT899B8JjwOd4YBACMVOpB4HZvZppyHKtsrwB2GI19fm9/QZ1ZsE/ER0?=
 =?us-ascii?Q?sFBNb9AdwXt1s+Yh3Ncge3bz9dJPDWSM5xt835rdgg1EtFgNxVb70DhMJPTR?=
 =?us-ascii?Q?0QxmFgRTyRdVHw+iSmn4jBff45N0+/wBGP5N5S1W3X4ciYqVAOiGw4irCzj+?=
 =?us-ascii?Q?gYGy6mHCHYcYwVsJyS57Qwvf2DTo+ahOBs2fjPUaDcgWfww2QdpGRbzpcPAn?=
 =?us-ascii?Q?RIC++wtPjgWjb5UVdoXKd6HrSHAGQZfQML/PSNP5o5oDEjlKuY3eZ75ca49g?=
 =?us-ascii?Q?YabrwYRdub9oDAsHf4Kkrynf6FRtrBke7jI585AVEC/+PTqAXuSOA1+rIlub?=
 =?us-ascii?Q?ASkqMx7qA4CFTeP5omFNmpjBMl68vNEdMqb3/TpuPZnl2RdBzj0xTDKNM9ab?=
 =?us-ascii?Q?0qzuakjWmbTww1AHSlXwFddSZA44Dg5RDAGNrSPzPAtixmNgg8vccy0YQWFB?=
 =?us-ascii?Q?BbuBQw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e96ef16-a08c-4f2d-452e-08ddbf8f595a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:54:15.7652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeN6nLY3he4B23yfHr7dNJy6hiDVvOXcWAWjLNJ6MFL7Kjcwxapy9yk1zGktuOuUSTVyp7shTCF0rPa0JSNdPQzKydp/lQRj8a3J/zXtQAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Authority-Analysis: v=2.4 cv=Nffm13D4 c=1 sm=1 tr=0 ts=686f7fb9 cx=c_pps
 a=lntwMuBcOMWYP1oWCx7eiA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=BKspdhvg69VpFdegezIA:9
X-Proofpoint-GUID: FokeU87Sn81zMQZ1hI7p9yYk5ldgB9Kx
X-Proofpoint-ORIG-GUID: FokeU87Sn81zMQZ1hI7p9yYk5ldgB9Kx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX101060RRKk/+
 998AaMEapOFoPzMRIzs0HipW7daWEmiGWe8t2uLVOxeYg0G1dUbcJSlqx6tlp/Sryr3ZZNl+zaZ
 w2iZfidsSRRYVsfVnvH7A0yagCCBxAifcIfjRckUbGv/SAPtEP5WZfTwAqmJlxo5+ldkL5fE7zC
 tZ2h3HVS93LEh+0OhFE0ZxQaaFvfe9vddSw5iVmCn4qCenmLFwSxMyBIFQ0eVITd886mhwZdR14
 qcK1EbZJe0YAEav7L8g6jCV5cmx0y5q8Cq3Qd40sC4W5DeX+M3eFnEOIOPoWY5Qq/vU6cymWuuE
 7QqfGDfM6iYNSqr9rmJoEfzojPZFko55qvhbW1LZdZu9I920Bu0ULT1CYDZEAZYHnTlpOrUVMYi
 51qKxbiQQaoMFMdIGQjXj9oX8MSJSpTSJO0d7ClBteMzLpvFhd5PrwBqnbDw5+cCf2gohI3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Now that we can guarantee the isapc machine will never have a PCI bus, any
instances of rom_memory can be replaced by system_memory and rom_memory
removed completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/isapc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index bb22083821..27c075b5f3 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -35,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
     ISABus *isa_bus;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     uint32_t irq;
     int i;
@@ -73,7 +72,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
+        pc_memory_init(pcms, system_memory, system_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


