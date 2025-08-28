Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CA2CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZWX-00006D-Lg; Thu, 28 Aug 2025 06:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWJ-0008Nz-AL
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWF-0003VF-TF
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:14 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S0C71L3582273; Thu, 28 Aug 2025 03:06:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/ku
 Js=; b=LuzlWSr2ddZU171t5KTjN6AS4L38PNHBdnp4cauj1zZX+1SrS77Jj5dpx
 Jf2PSewYxgVuv//qSaBoYUgjjmkdzAsM5F929J0yp2M988zZU9gR9la5mCU+bdBl
 SQXzo/vGt3LHCe1YcA3yyLJu4BjO0krY30b61WNV5kYqLYh1f4zGZv+MrzOSj5RX
 /TD9zBq5NBP2RnOEpGAODmjj3/u8n65VVBL8iK4Vtb7KB82Pk0FQ+/wo1xDY3UPe
 2lwX9Lo7U3aX9X9yiQYu1iNB9DmkaFJRE9mqNo7ZvLJDC4lkjOTx+ixxgxw62iOO
 BZS9PmyMPXiO2k5FJee+I5XdBYlrw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2121.outbound.protection.outlook.com [40.107.94.121])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48tcc312n4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 03:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkXlEnwr7AJocILx0hVvwJ4vjUWGafkYPMBJtBwDZB523IpDjxjyTXx9DHOo6AJAR9zMIUq0lPEyAAJraWGAV9Ut/fRdvBTHSddGPIh/QYu4F0JBelq0dDIeBwxG0l2f0BsgusaTeOIBqbTWbkmp978FCSmjhuZ0V5tgY0IVTDENPJXhVnFMOWtDOK0Jn5dMj0V+CGIT3/WmZEyy4LY8BUtOyXfHwczlR1WJMNaESD2LPW2QfdZlpHGKnDCm50+aWbL23Wp4jpB60bGeFXkCz8ygsxhgbYGYFCF8V5nU4Wzd2idXLT3aPQoFw6UpP76eJz5a3EZquBEjKFlQcQMDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/kuJs=;
 b=odG82KfcW+ilfkj+zPEzJUrG0s0khAJYDgNFid/E80v7XkGCzUahqJu/lVrPMbJ6ycnyfzG+CaHFsrGmfbHljkgMm8NX3Lq/6sKKHcMkxZgKWD7tv59EmApyFKpCnBFN/U1B54sE0za4nEsslrT/AdP9ealIMO3lnjKbrlhssbXIEEwQBxR5vbI+xxgkE58Sc0xctEZW0NysvS6PQcD3Yqbbt10NO57IRLIv4SKPC1D4FUelGunYvJfWDgMXH2cHKDi2yFDSMKwvPO+GLcj7gTyF0einrRRBDPt+p8Zzb6R7NBsymo1kSF8dO+Sm6UkKM6ZD6F+kJtqxJEiWIdV+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/kuJs=;
 b=fEPSsfhxO7X898jcNR4Pj+raqNTaDHPHzdw7c4gsRJIaSNhdRzmdeCJ5bmP5AvxB0QbidiMKIEQ/2+CagHZrP7tMAa28AVRBCLxOi2vGEpxlR0EYoygRUgGKtMHp+nG/n9IxFvjU03krx78e4JROTyEeZZ1qezM2X3UngVz2kNmqlNw8RftEoNKVM/xEHUn7jMsNmGYC5CadKrXtmK/LiZvm8RguLunl6MDbsoZnVtPM3fEirQxuCUamjP2zZkd/nvhB+lPSuTvc/ZRQNeNzstUuQ87GDPkUUJxxL1vLIWp2xnOHX1TpE57flGwN7nIWiYAYccLPYf6DA13eLwbTWQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6628.namprd02.prod.outlook.com (2603:10b6:a03:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 28 Aug
 2025 10:06:03 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 10:06:03 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 2/3] tests/functional: add vm param to cmd.py helpers
Date: Thu, 28 Aug 2025 11:05:54 +0100
Message-ID: <20250828100555.1893504-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828100555.1893504-1-john.levon@nutanix.com>
References: <20250828100555.1893504-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::12) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ac3954-7da0-433d-d44b-08dde61a7ee4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/xdVv1eMvnhIR2YNKT//MC2Xf4hGcsRiLEQJpUXXa/yyKhla0sNrN4Fs3qm8?=
 =?us-ascii?Q?4Z5ODBjkGs/yCd5hm9hFGLpDPGtkmkiqCt8WljlfUuA1spssaTUtxqsiVYWl?=
 =?us-ascii?Q?fUiPDNuEcRCfuYBpUBmLCBFcEL/2rsQ42wAyO0Efi2xMW7DQju7EF+0IoDZn?=
 =?us-ascii?Q?8Tf5wPTV5xQ5Z/Nx5MaQaNNhbuAfEnnyozPRYzaTGRNQgaDuXgeGjNNg7Ov9?=
 =?us-ascii?Q?qlrBJsSohkcQ2gcyUIjMKLeLwEZgBJksWtQ5pYmDiu/ACICPMRAiMgHSnT/E?=
 =?us-ascii?Q?3VWijW/YMuDlgQ8FFMkM4VLJox9KpPLG7vTk/HuavqsEX97zjaV+BoStDSAF?=
 =?us-ascii?Q?Ife2h8tV4ZjtKoZuoKkmdk9RxowfMNW7A6ClLKL0/nwhRUk0CjaWI893UCQX?=
 =?us-ascii?Q?HSsscK9i2FB7s9wO+FCY68GOt2didKBpQIAlePDRTgWqr/PgoayFXvGesjCb?=
 =?us-ascii?Q?yAN9UYbaTlqFd6M7W/1RdAIFdJ4BuXOpsapLkWShIfSmlfiZBPb/QO9tPKlD?=
 =?us-ascii?Q?CDZHQ9KiXnLu+kNQ0+/YU36oQfZXIDLnS9Eex8PNirfFpNjSzLgYh41rgjvh?=
 =?us-ascii?Q?Ca3M+byNmBukI9FAgHSVNJRlRt4LP88J2AZ/rSItthhZqdH/6dT/Er3VgKh4?=
 =?us-ascii?Q?4TDR4maliTaxLFRhSwiMkT91WPTrRZyOQXZdgLG1QXWZuE8pedlUvC/A1LNv?=
 =?us-ascii?Q?gviTyoVsGytkuhynPUqkkNHr4HxGPC/QGAyxIakczhoAYY0HsVPeZI7r+6Fu?=
 =?us-ascii?Q?HDjfJFnlUi5qq9A7/0A6UHNFFL8wXFeLWT9iZzQmrQNWryQgWRnGVSInsH6G?=
 =?us-ascii?Q?iowzxFMPt+RXjiI7OYhE+V2Tf09cYTprHYZIZh+yLznTR0ieR+l2TFrWW0M2?=
 =?us-ascii?Q?pCqUHUKT+XNE4Tu5uGJjTKWkAVZSeKXDxWandrBCs1zS8mCTNkJDjNdKa+OY?=
 =?us-ascii?Q?6nvs6UzavrD+x4aPFbWzfOUdI1SpKiEt7AV6grIHhTNFuDji3lZChMPwou3L?=
 =?us-ascii?Q?UsnOGrV0wWLUrbG0sjHUZlRI+HdlKsY2Z/iLmcyMfiWU7wpeN+KbbTHRJefd?=
 =?us-ascii?Q?Ir7X+x7ttMfhf3WIJdPCuLAqEZkfgjZ4hxBuSa2JyK2U7sNNKARIBB1ycV9S?=
 =?us-ascii?Q?z8mig8qFiTqbwEE1AdM+VCJShMxT0gRd4GpW54uj2QZ2yf5WNy0bDBKWRBsw?=
 =?us-ascii?Q?Lokq0AF4Y1QAVXqB8i176zEynbuXRFAPn4qFIzOhB+2CJY0vi6UzjEJJJsMX?=
 =?us-ascii?Q?UKYP9CbcQ3liaKDk/IQ10B7qRQC1z8hHt6jstnWlmEcfvZes3KlmKxqyCRq7?=
 =?us-ascii?Q?m+neXws1AvDcH+Qif8KGSKgmeqNbh87h4qdUSiaT82Yc5W7APmWjOEgafTak?=
 =?us-ascii?Q?fA4Lpp/Q8B4UFSU7Q+sNSW4Vn7JQTh801HMzzVFPD/Ju9hjJG2g+palfElYo?=
 =?us-ascii?Q?PWLYOBCrZhI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3XbhqBWe4/72f1eo9oPGKxvARlfsjoJnuX3IQNZFcyZHmBY9nmL+7o3nnyex?=
 =?us-ascii?Q?/Wdj66/u6UoYmLARnq7RNqTIzDHNv+VPCAmXUCOlW22+wVtIFRPV3CrmTPdj?=
 =?us-ascii?Q?pt5/NFZsrHr2MGXWJqxms+GceR2nJXwF6g/ory/A085Qmlv18AP9vf5PQEqf?=
 =?us-ascii?Q?mpha4hqLbSynmmTFjmHTWHj4rbqIvd3V4b263rrsvf/f+l8xj56A4H8ZvtgV?=
 =?us-ascii?Q?BBZCP/Hs7kKolY5IBf0+B96HyEljS16Rev2/kuvxaBtUOayj6MhoSPmoXSkw?=
 =?us-ascii?Q?+uXqq/VJMCsNObAZhs8bc5gVpZ0i1cigF+xsWbBbbochIfp8Wt1xZS5wM/wp?=
 =?us-ascii?Q?7kTW0w4ck08ILN3fXyDcdOvIV1uHLeSapvJkspdeoIF+VUgJ2ipWZblH4Pep?=
 =?us-ascii?Q?2HyRHVlL8DqSAJo64QEagIHeiexb7tvFSvkAw+EW7UqSvNCuSGg4E07YpIfl?=
 =?us-ascii?Q?lYgH0ijDqNWDtBXcC73YQlR86ZAyxDeRZfZHOsuFVguVhx/qVesDBw1trOHP?=
 =?us-ascii?Q?0JdFSA0i+TCQYKUIEOmFF6Gik3P1iLZkIvIWjv8XZG0+X0Nd5NsO7qWoQ0zK?=
 =?us-ascii?Q?WYwp7kZxZb+8hQvnuG+IQrj1XmCY8CT/kja1MH1LQJA02V5vBnoZ7zYyu8DP?=
 =?us-ascii?Q?A9kgpnJa48DNjcz0ARzDjXuYDpXOkHZJr2rHqYIRI6Ik7lfGHJhV65hIj6Bk?=
 =?us-ascii?Q?00adJoSuaVEDkZ+3AQAkt0wQULAql2y8IE3qrU5T2+kMQexWSVAtjPSCxmFr?=
 =?us-ascii?Q?3Mk2yZIhB/u5DMH9YblQATCvAqOVmC4L5r2BtUDznTvw4AwMgeCcp0qW/SXf?=
 =?us-ascii?Q?uo2XTPqT5OjMp3gsDVFGkv8vXKK2nj2A5TXP/Z8xHOyBSXLKNRpdtmQUOmY1?=
 =?us-ascii?Q?Mjf0Wr0xroug9NUhsdlMwLOiVFdAf0fHW3DlTeBM/0XAReRScXlOanAGAlIN?=
 =?us-ascii?Q?38OLCD87yOhAT+GZ7GYc+FE6E2qmw7vw+dCkAzWHTvDQ2CWKTPYcnRAbcLCt?=
 =?us-ascii?Q?CpH2wIzC2xs3Dm2MfUKG8/czmB68b/o7qnnVeJMXM4ymbqjMJw3obtS6kejv?=
 =?us-ascii?Q?e7LsmeyycNqG38H9W/2JW0ChvxPcpAl5va6KHeSZffVem6Vx35Gao2CelP3q?=
 =?us-ascii?Q?Ky9HX+Do1rjlEFm5ntk1i3YNT5N+pIhO3tpsqM25dAnNQy67qlrFyuT6z+tM?=
 =?us-ascii?Q?lJBenNOQvGtGBuRIHDM8Hp7k9cZ80RdTmariO5pFaNk09NlJnpk6EiTnyEMj?=
 =?us-ascii?Q?NhYvzI928XuhtdZZXGrIkHGULe/FIvLyOpb5egubcyF8Ofc0x3LDawOZKUZ3?=
 =?us-ascii?Q?4IXQKw/ZGyRlvz1X/1FKk7XMPKcREGQsa1bfFZubaSOfF6c73dTHuS0M4E+5?=
 =?us-ascii?Q?CzEIeetK6d+xHnUTgtYth3OpAPKRZ9R0HZujJoygWkIc6qzwvQ+Lc2mObMe8?=
 =?us-ascii?Q?2C7n/LEn/pGqYjwCDJFiZtJGORuK4xK7yv/SZn44Qf1MGS475rlHu0mq+19J?=
 =?us-ascii?Q?gudfxhzTxQe81HyfIIbyuH7izKKKa9u5v3iqehLjJDvAWvWQQdVcQ/HR6HrF?=
 =?us-ascii?Q?X9kkdafp6NpJmi+Zhx18YtwYJc4gPL0IIq2t+zpq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac3954-7da0-433d-d44b-08dde61a7ee4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:06:03.0526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrb40ZxavYdr/zS1MGnIqrcBXN5GWcDAs+pVnMLb4+Il/SA6fOw5VQ1pnr982DAHq3774Myy26NgWm7BGAB2aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6628
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NCBTYWx0ZWRfXysDBqthGZ/eL
 iJojl3xS5KLaXlD9DOIvd4DsGvm4QBUOZmTodAE4KPyNZjXv4nsCPy9Rr5aRr5DBwLNIidmp29w
 l8rerzBU+9B7+jIbX5e27NNJW81SznFeUfhmXEJrg7L6LP91MlgLeMhNvqYA2MfLGz3sPpkle1Q
 JtLjCbNz1AMexczMJ6PXs//0nrDPwmegjGYLPJ4958GkH0o9cS6apFJG2G9+I6oRrDevPeermMJ
 zfp4pDNHAPRUK7HIAczKnzyxqmSQ75q/OCfqldc9ssKoihU7DUKgf3raiCD2F5Igj6rJWdOsTsb
 XhHTjryO+qZxjmNKMD75sS7ogIEaL3INNFPDrVoYUeBqlUkUcM3V0sHEwphxx0=
X-Authority-Analysis: v=2.4 cv=JaS8rVKV c=1 sm=1 tr=0 ts=68b02a10 cx=c_pps
 a=pkYLGSLT82isoLqesn6nFg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=XuhTMkjeje0lLBXxpz8A:9
X-Proofpoint-GUID: 9ZkEezdx7O2iz9xIvE4j8AXmxvYANzW4
X-Proofpoint-ORIG-GUID: 9ZkEezdx7O2iz9xIvE4j8AXmxvYANzW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Extend the "vm" parameter of wait_for_console_pattern() to all the other
utility functions; this allows them to be used on a VM other than
test.vm.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index c19dfc577f..8069c89730 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -144,7 +144,8 @@ def _console_interaction(test, success_message, failure_message,
 
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
-                                                interrupt_string='\r'):
+                                                interrupt_string='\r',
+                                                vm=None):
     """
     Keep sending a string to interrupt a console prompt, while logging the
     console output. Typical use case is to break a boot loader prompt, such:
@@ -164,12 +165,13 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
     return _console_interaction(test, success_message, failure_message,
-                                interrupt_string, True)
+                                interrupt_string, True, vm=vm)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -181,6 +183,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
@@ -188,7 +191,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     return _console_interaction(test, success_message, failure_message,
                                 None, vm=vm)
 
-def exec_command(test, command):
+def exec_command(test, command, vm=None):
     """
     Send a command to a console (appending CRLF characters), while logging
     the content.
@@ -196,14 +199,16 @@ def exec_command(test, command):
     :param test: a test containing a VM.
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
+    :param vm: VM to use
     :type command: str
 
     :return: The collected output (in bytes form).
     """
-    return _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r', vm=vm)
 
 def exec_command_and_wait_for_pattern(test, command,
-                                      success_message, failure_message=None):
+                                      success_message, failure_message=None,
+                                      vm=None):
     """
     Send a command to a console (appending CRLF characters), then wait
     for success_message to appear on the console, while logging the.
@@ -215,13 +220,14 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
 
     return _console_interaction(test, success_message, failure_message,
-                                command + '\r')
+                                command + '\r', vm=vm)
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


