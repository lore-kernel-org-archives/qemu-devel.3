Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A63CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIIn-0007JP-Cr; Fri, 08 May 2026 06:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIIl-0007GO-7P
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:23 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIIj-0006kr-Hk
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:22 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6488m2Sw747656; Fri, 8 May 2026 03:19:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dqIbW4ATAI85L1MTqVRarKsWyYhPF90kVKAHre9Go
 7c=; b=2XdtY1DnMMUHqSWy/xD9PYtM4UjzISmGmhCCloN6DROLgC/Wa82anGDUC
 Cy68lU/2qaCTHG4gHxOTQhgGHjtSGfasdn23ANJuNaVCPhaESRqPMylRN0XZa5hu
 dJfr1fph9jOtkN/5aMz7OWEPvnwhKdUqAdPt6+nOD/UkV5KPbtJRi8Nk41KpK687
 kjHgP8D2/fd0ikWooMZxBvRL+XIzXQXQdtC6zlvIWHV+4e6xGtvXZMSXCzfqNeHD
 hfVngjUJcfV7tWVkSsmiDM4QzvApKBjZ6hhdJ4sgTqHj8ZeTkEprfr1JggEeAnwo
 3i5Ub2fG4JbPPpC2TZMLxEuD6MOCg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023093.outbound.protection.outlook.com
 [40.93.201.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e1cmyg5t9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 03:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwVSLSADDcMOw7j7zdgUW8C/zDpQ9ulufV8/XJlNLZXgcBqG6PUlFU94EZ3dkPE8eGDgfEPX8cmyNvxvv5dsx9K2kwSkGywrUMR83ZHdUFUoNQnPv04CTh/kUe/aFNktLs7pTrwCtlq2HV6h/y5uEDDRNDMVYq+VGe8wHTOeokz7dtViK7RnkEazWUsxidtLfYLchuDCPndBn7LdTx46dzCyWhMmz2Jec3gZJYcU1PdnAZcbGhSEkZ14dLMc2hbGQgTlVZ13/G09i3UpyxX0ZGVoPmNhI/XCJHLUBwPFHBoiO7cycEzqiAT8baW/OD7Jy8y5B47E7l/gKeb6v82DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqIbW4ATAI85L1MTqVRarKsWyYhPF90kVKAHre9Go7c=;
 b=Y/B1fU/YzTjRDyPrxuyJ/0xI/FrSiAd0qzYwSPwNM6iw6UHQxGgGJxNE9CG1DcNgz3RkjmjjDQwQZ/qhROWoFL/kMcWSLxEZr2e//EUOic+tJYxPYw2eInLBoKt1jtI72lKeF2Qqoo3i0nW5YlXOPESu/+gSHMec6h5ZzA00D7IB2PXru09WylTEh+kxb5hsXEEK5dItQs9zpETLROY72JYCCuiqWerl1/7Dx2M8/TWYr2MoliNC5NNgfzF+86LePN2cfNevrEMc2ttTGl7Ry9eoK2SPX69ARVPwq3UqmC+ASASXmHx78s000l1jg2tUKltbS8iobrEcfWAhdk8zDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqIbW4ATAI85L1MTqVRarKsWyYhPF90kVKAHre9Go7c=;
 b=R5DC+JMbse43Zg4ThOF0B9VxciSbDNEO+dtDreidQlrdRxOxOFtVAf4FqNk6ExV4bY97wY4SsYc0PUHbbXAt6dMpfTiZhAwpLQ4MuKrcoDHmPgFTj7GQRz7eh5yU5WMEFQofq8OvDS+kPq0XLkb7tp7o3MjoNPqzVY9fP15C6YPyrqcppjdjIhJv+UK53Xq4hYTTJhFzZV1/e3xXVjBV4JGKzLQeuLPPnrTBX1GwtKcFwvahgHtBuCkPb1Qs1z75ZypfKjmicSPtsC81/iizwyB/nVqIugMSxgGSCW8yzvi4I5QfwBzv87qY8T26j9lwBhLBOSt9Qqe9cWF7NvtAPw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8624.namprd02.prod.outlook.com (2603:10b6:806:1ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 10:19:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:19:18 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
Date: Fri,  8 May 2026 11:17:42 +0100
Message-ID: <20260508101901.930781-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508101901.930781-1-mark.caveayland@nutanix.com>
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8624:EE_
X-MS-Office365-Filtering-Correlation-Id: edb0dd75-6d11-4b6b-c185-08deaceb4332
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: LbgXWRSj84HxjdeOqTzZkeHjGPeO79StUFMgu9gYI80/MqgFSZIhVC95sPFu0lj1u+BnBA2ax+MZtarxY2jEueQwxeej2UI8T5pRza4FEt80Zg4ZobRyZAU/WQselCK+FlPcaK5gixyYWieWkkxfuOGS3j9RmwVGQE1bqyVYMFXvtrfjM0i/XUGn36z6CQckJe1W5+m52z7SI4YuSplLacOcO+Jj6wPpHHJzCdqdLlZZ4bWstO0Lngna36B5CmxzME456jQrzRYVErjD4F5rfgSr32XQkq2sMK5AfjpZk2zpl7F42QxsNtXBD4276mFvUI9H7LvkNpWLlgBZJeAS1WPmxySbWdMGcU40Pwqbv5y9brnBdj+IKv7tyRxI/xphRhBoLRG0Kx+MDm+ySGLzPriukWol6drC1WdhRv22R2SAUtUHun95J1G4xIWuKMQvIifr0EFhMEQTOSKEPekxLhkBMvC1kRdx9HU3eu2ERogZ5SlEOm+B2J+KDau2a5GzWZGU1TVWkP8Omqs79N7G8qpzNazZUbbnsT/mMBsEmEchQDVCveMfxGXRRVMxUgaeHAx/SUPFzOUOlVqW8Pwx9n+v1hwfVw8V9cbwsok01VCcgP3uk1Ij5N2Ll5Z5suzdr/Q8K2woxF/iFDez6bD9Ulye7qhB2CuaedX7FbcWwgbfciQ/dVhcHR50fu2tYpav
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gG6o3/b3kbZgl9xpml9UJZZTe5Gh94iKDfsyB1VM+kXcxQ4TZ8u+IZCjX8nB?=
 =?us-ascii?Q?rqlpOrfThXWKDakuFKHy8LoMMBGYp7VmIXOwT9CrQNJaZLcc40dVTRnwqWbY?=
 =?us-ascii?Q?UR2XhLG10wwkQBtibqKom/+uNZE8/rlXKk6DA5cCjqyhJqMPBvKNjenpMvgm?=
 =?us-ascii?Q?4wtCnhYIj9tcxWEAQLb/6IiC0F0omOic2shPzAeflIN0yM53+nqrfcVDRvsm?=
 =?us-ascii?Q?bKVwv9g21X3lOX9DaqWiwY8JQyHLsGtvFfGmziLEPP7ld5Fw4MnSi8yuVzeD?=
 =?us-ascii?Q?msTAblYDNBiiKefWmPRnIq3IxNoyMhpPSS6fkUIErUa57VRxJLhW62XVJ/c0?=
 =?us-ascii?Q?X+5SnEAizAFFMepaKyl0J1L2Sno7PSXz6v3AXQLxdg8Q0CxZB0TP2AzSbFxm?=
 =?us-ascii?Q?/gOwil2mpZuvMQTxlkM/A78tSyf9c0w0ho/dRaANiIXr0yoaqfYpKd9tfIQz?=
 =?us-ascii?Q?ObiFuwpBDAnb98YJxDU+cwoKhy2dxNUtZUawT+exyhY7Dpu/IfHy9B5AMwa0?=
 =?us-ascii?Q?4tEvzP4B4vEMC4rqH3r4RwEN/tbW5+CgjHqUTOrEFP8Kke6isL33jDRpf9Vr?=
 =?us-ascii?Q?y0328GlUqt+RBtQ81Z4z9VkqUf1JXEzX9dU/u2pS5Gu5pF8rdG8QmD2s0XBI?=
 =?us-ascii?Q?Yfsh5ajyrZqwF2LkrT9Ek0Iq70EJ6DBGAXV3udGcTvJdenxVDpZij7pSKb91?=
 =?us-ascii?Q?SmOqX1fm4UO21r2dRmj5los7/d6KaNtfaPdAO2IeKKgmb0Z3+/HZtH3hMX6I?=
 =?us-ascii?Q?YvmlhICwLcyEeRRHGi6qcV/yZCveMPJf2Aolivs7ClSRTR2bMtBiGmKMMyo2?=
 =?us-ascii?Q?sRw6n5cI8uoRViRqHG62La3mTXjxqEgSLD5puqTlQbP6JKKZ/6jYRvZ1bSa+?=
 =?us-ascii?Q?JIxPPOXBwe4NM+M1cqdj/CjkiAdcovMi/neg6Ilqdtva0yYI5f8D2Pz3sqwd?=
 =?us-ascii?Q?ddl3Q3KQ1p/xsO91g4VeJJTG6yYXVO2PpJiJq9cxApB6KKsssZQzFuWX9DpY?=
 =?us-ascii?Q?9rt2pnxN/FIZvKdEfxQbv2lRBlu0YIVfnDqpkmpRseqH/iacnuF2oobAyVbG?=
 =?us-ascii?Q?ZkXYN/E2z5z46LwiGIio40ffe9+xFwnBmOVHOTrMWceCPucRSbJWwHCknj/g?=
 =?us-ascii?Q?ac0PKd/DGZaMzWtYuMUIc6vH12jEMC7wOo/SW9gk6kM0v0N14khmu2cApjRr?=
 =?us-ascii?Q?8eOuLwPxOPxo9bcpbPbbwiZNJ+QqWgOSpC/FFjp83aspExwxyCh5F6UHMiVw?=
 =?us-ascii?Q?Cug6ezsTkNXaiEe95HbTd8/o0Qa3JCDMYYtOHZQ/NM9LpUUJT+dflAK0iEXL?=
 =?us-ascii?Q?wKQrpXU5s0Z7XGT2cXAzXa3X/rBftg0VozmZvNYHLiePyeyoQc9cCsZCiZBM?=
 =?us-ascii?Q?qgxMR1hSF92sNk2nkl04dwvigzMOPTe7w/Yf64o3B/z9ZQn2Nre6YITtwpw7?=
 =?us-ascii?Q?RUVRZvKXnSJHTiRj+Hfj7657JjLWaiK3IL2sOHmBiA6WQaG/ixQ3pTvBvJ05?=
 =?us-ascii?Q?pabhSusdjzAo9RltHM1XSzI9XT4uzMq8P0mXNc9PyYRioNQ3r+TERGTcN4DH?=
 =?us-ascii?Q?F76GzbBHLvhnDGssoAEpsZou4Mn6DVlrG56t13nlTT0RS1WMqF38rAh+qZJ6?=
 =?us-ascii?Q?o7q2P1H8Jg/IDCirGDMLdSCH6ffe91qQ5/KtDs6ik0nzjJzY9B4uJyI4syOl?=
 =?us-ascii?Q?tIUsPKJzuIxGFD2uBlC6dYxJuAzB4XWURcds9qIE3GtmRhVCU2ZT0jWQOCnk?=
 =?us-ascii?Q?K5pzYK+KRMrGl3xsKlcU7gZahgUqToo=3D?=
X-Exchange-RoutingPolicyChecked: e0/1UZA7qwPBTpBnYy1DS2zW91QGOYQ4RRCgG+EzPfTLhp97Tlipl/qMe7+xQKB+9q5mJPjfVaKGwVvEySbPCV3Bj8kPjHJ/qMLoNZgVbIJGBUsBHyqpE8WCL4u0e7/ArCF/RxuqXpGIKJlqb8CcjU6WZbN6buOH1tsyx2Dja137dJsfhXaeBxfV/dJvJHR87XlibMKeAXRXusd2NVMS8WZUi2I3NaFy9Osnw5eDxsmtFdUn11cbGXFa2BzOhRj88kWZMguSUfXR3NlozrC6JvOHwvfbKMKypoi7t1rN5ERfUnTCvCVRgSejKMkksihZTCNhB1pIbS8qAA9Y+cCbUQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb0dd75-6d11-4b6b-c185-08deaceb4332
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:19:18.0857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBT9OixrSMEPUvjNid9L6pnDiHnO9wiuBfCFKXOMHWmartOGZZbwZK6t4cPlnG0sNQ0Ip54rTch4n3ef85yoTLMbWgdugcjk61bC97GZVtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8624
X-Proofpoint-GUID: udHNLMi7guNiyMoj-TRONDDuuC7LKZtg
X-Proofpoint-ORIG-GUID: udHNLMi7guNiyMoj-TRONDDuuC7LKZtg
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=69fdb8a8 cx=c_pps
 a=c61ECyqdR3yyy0DXXr4X4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=EDHFfd-9LZ-yJo2TyggA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNiBTYWx0ZWRfX+FijppxNnH1I
 CH/wI2shOjyovBpuiYbByV8EaKkNVgZFa1LJYXNBfxXGpsUT8mbk8l92V1nb4oFV05qFBa+53S3
 +zKDIERTqJO2BW24MS/FWg6QuGECRvNwW9MqZQRuyVUFBeiUTXmzV5akkpIkIxYTNU7VKt9F6CN
 GA5FCnnAYvqOamUsXaJ6CVH+IYr0MYcXzbszhcjHTXyaL08i2+ZmWBAYJ6Pt1EgUdlE3LFelkFv
 RRE+qrTTJpMhInDXhqvd7Ji+838MvX8vnqVANSa1J5nnnElzhlEsYxS+il7LL/Y3mvrqgwQmprt
 gITF3zrNLfkQJQixZt8fTHIAQ68EMUi4Kc+50qeXJK73z1wJMUQWDkDKBt8Q96TupsgDNyiq4TZ
 AvVAgBgkE3ABPqzqkVHHKmiyIwZgEOGtjZKCbVX8SKqnSfdpQOKxn1hHNIOj3WJkUj9EwPjBVap
 B7Zh08mqWUMZYTXLkag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
3.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
Descriptor indicating that the ISA serial IRQ is high true, edge sensitive and
shareable. This enables all 4 legacy serial ports to be used in Windows without
conflict.

Note that it was agreed during the list discussion that this change does not
require a compatibility property since it is not part of the default machine
configuration and was already broken.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/char/serial-isa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a4be0492c5..59df726871 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
-    aml_append(crs, aml_irq_no_flags(isa->isairq));
+    aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_HIGH,
+                            AML_SHARED));
 
     dev = aml_device("COM%d", isa->index + 1);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
-- 
2.43.0


