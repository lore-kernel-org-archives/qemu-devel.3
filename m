Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B833C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanc-0002YP-Bj; Thu, 15 May 2025 11:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam6-0007Fe-2B
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalz-0006RG-Fu
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:33 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FAchHr004938;
 Thu, 15 May 2025 08:45:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNav
 zo=; b=A+sUzVwCGxv1DYppAz1OkmkAAVE4iN2xfYnGp2mtXY2K88bUzCeSCEufO
 UyYegYlIzdUS04ti24ywmbKZq2CFMpukW5GMlYwUdKIDfE+7uNkaEETh4Inpey38
 CRwFrH6IP+xO8O9aG6BiqDYJjK4zZnM0gbkWZwf2z4oxDzD2MeBpXmYAxMxcznI/
 +YyRZGw+UVUeNVdlCe06KMoWMHDNAhCV36nAjk2ObjIkQTG4L7wa3GLIWN8fUDa4
 WBHNgIZrxkLma+uBHQz6x8RVwMHWXI/v1pXbKvHiGNMupH/il/6OOImsZgFb+7V4
 8EtMKhcrST3GLodBzB1UIvCyUBt4Q==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mxh32ymh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW3iVM+6NNtVfxazfWPGm64l5wS3fjBoh3Qy/HWLAxHVFMn6q3VC6z0ZgTchzGLRlzBP7CfOPQafbge0x3y4RvyhHMJDewgF0XnZeNn58U/dOPNfERBx5O4ac0jkhb0J4eUNCImph+BnELRCdN86bHHgUVh9NcvCcL4/fILdvMev3tC3G6vjSX002lIDs/wpcpSFqx7s1DpeNGIIeEf32vXwpNkRypgVmFdK9jUP9PkPN1QhX4m+N2X+5FVvwy6iBK+kKnPbdVluLx6uS/l53nVi+DfYpedtRM5GXv1SSKmpfbcRfrJ8RpaAHor6I3RTtNKEvdU6RpwXs0u/BTiwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNavzo=;
 b=C56Fl6RDNW4X6u/Ix6J1pOAVC7jNGfV4nb122szEZ1MhsRDCntAGKVlg3O8gystGg5vexo4gF1/KBIBzrsBbG+WmnNSFnzZUAbGPuSj1dQBCdaYYi7bm2SSuyw8oUf3Dxp/lvU2jvZ4IDPhm5hw8IvCvvoeRMlE9/kV0KsmIZx/kZMM+0fG9KI8yeSLGGbFmADgmDrW29XdNqrA4fqrHV9Qm0eU7e6ppFVPMD1W0BSWCfr3I5HVgUy3sQ3MMuGEwUbZ4r7D17GQx+UStNCaBRP/QmJ4D8LGsGcG247D1KTadRHCNSnxYQ5XPAdH/Hi3Xzt+gww+Dw1nv3nO7Dyt16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNavzo=;
 b=avGSreu8+Mqyn6zaCg6zVh2JtFt0YlQ3gOLRjv131WqWRCtCiW49XbLcj5w3bQf0m/DaC7aC358guhlxuTSxqhVz0LVBPMY+843q3PmvmMOZLsLwcZjePWuW20aby3ZZ0Yy5/r5QLASDPHoS23q8iHA5gEDdVRKK/i2J4slXeuNDycx+c5otdXoXLwVBkzUi4eLNsHhbxN91jQhrIzUNlamep/3Ve3FJF9wdVpricpKi9Nt9BxICwgS9r1Z5DPwGig6BcBtsUCOmeSTlbQ7pQv5A9APfFfRV21oS9fTOutMevOPAQRPkpfttiG2UjQVgOOfs4ovtcn0AMUJSmkAfVQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:45:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:04 +0000
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
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 18/27] vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
Date: Thu, 15 May 2025 16:44:03 +0100
Message-ID: <20250515154413.210315-19-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 185ab4b4-303d-4f1a-b0b4-08dd93c775c5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bs7mtDdRCEJOuNxm3SfeZpq9sOON90hjrk/cQ3w3gH5F6Ewdj4APgDa0bSi+?=
 =?us-ascii?Q?bShV8LAXSZyFiK7/I58v/ZHut+6d63QCeIatCaTdmkMycT5atYYPxNcLhplz?=
 =?us-ascii?Q?rl4kPIimCnOSufSrIf2k72lMtJSLfFu9VOuxB2vOTAO+Ja/+xfo4bwbewe5o?=
 =?us-ascii?Q?HFxHyIhSJQ6xnbPTTM5s59kSdXfwNbe2Dkw8Ek72W8OPPD8tEplnledi6Ukk?=
 =?us-ascii?Q?F4pjcErZMgzSTSg35UcQ4QNu2O1xIEjbPkjk8xgbJMm+To7ulHN1TgbL8hi2?=
 =?us-ascii?Q?Tda3u5zjofyWz6lQRL4MV+PzdmiZipcyZWr0k/vubgzt/pcm0oT7rLrJdR0t?=
 =?us-ascii?Q?IYawsFsbV4yxcn8WsFVZAdHPYuUzZbx6RedNnDk/SXGriL5CJGzu/Jhf11Gg?=
 =?us-ascii?Q?NsMNdMFSr4qzwd5B/OQtwWFtrB/UHlhSg58A7kR5F+j1sfogF8+QevYNBJ5u?=
 =?us-ascii?Q?VxPeQHQCjbZ3WOZPizg6dj1kQpflWhZCwW2otenYJxAZ7ftlkyhLHBgFYF5P?=
 =?us-ascii?Q?pu/I2fcgacc38KOeto8Zo/t3HJmYdu1IGyQiWhbiJAo7q3cQQz0kNEV1r/ow?=
 =?us-ascii?Q?BQbclyEtPCli6ufJtU4CH8JtE5R9dy+TA+GjjTroL3w2pjSn3kGVwk7Ibe8H?=
 =?us-ascii?Q?3ENZ5h+uNa6y9Q76eq1/K4axlZxLlRatdJ06D6l7LOaA+6d5+MFx0MwsmIYQ?=
 =?us-ascii?Q?XXFFY0DUzm1FcpmJ7Ua2E9EEKxUqjSLIRgMdEOsQ7K1yCEUgnKbqAci9PxgM?=
 =?us-ascii?Q?3+eQ3sgua7IQzsUluoComcuMraEDnIT1zlxT/HehGH+pWZAso3tfORKZODOI?=
 =?us-ascii?Q?IXJW1OGQOBikiwgIgn5l1/XLjlI99/Wq+Z/QfpuoyJ3AP7P31MQIeJ5Hdpm+?=
 =?us-ascii?Q?VlsnBHqhtxTvrAsaj5QBqAYQsGDymGxgNRFtaPzGRl+1S4CdNOZHW9BCeKZv?=
 =?us-ascii?Q?JHk1Sb183anjXTKu/GYSCRj6jPvhMLc7+NmYDmzddUi76fzfJcPb2rZ+T1rP?=
 =?us-ascii?Q?LCQjnwjBCD673jUueCO9KMqyuUlFvWnMvHFLPxuUQLRV+8k2+Bm9yVzmv7Hm?=
 =?us-ascii?Q?DopduQyquchhGRw7S8vW33sA4fdZd39Ue3cqkXfwlADDOpS5l0+OWKDrRRHd?=
 =?us-ascii?Q?lxHQnvvSUgX+GoOc1fiO24flr5cZu/2lw7Okbg0pix1RJI56Hm9Ba0kR22dj?=
 =?us-ascii?Q?UfxXySmwmabjH1IaJxv3usx7VlSZ+aLBNoo4SAv6ajE6EBj5PdhjpQODSMGC?=
 =?us-ascii?Q?5sZXRUPv1gRERT5vyLsCHoRmgZddHizJCr4zcdBG4UbdYE/WoPL7nufuBEka?=
 =?us-ascii?Q?IKORhw5UtZHkrd/r/oh79ehgNU4QPg8A+QSIET7GY7SnrFN3i1JnHaB5avk8?=
 =?us-ascii?Q?jNO8QfGaW1FVhnk9FgeM0SdDrHC4CzizuAQxmEBfqjUDjSL5hA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N7VHBGlRZO/hui2R/KSzMQ2ckQifc+IAYEStewVhbv/HnmTSXL8uMPuw+xyc?=
 =?us-ascii?Q?ZgbFm7J0IkMJoc1hWId1SEUuCh21Fczh14f849sxEH5nd6+J6ftXz1Wslv8L?=
 =?us-ascii?Q?fknqKcfeTRHmniYwzHMwqbhsilzOs2YP/dSFePEB5koOFx0XprSbFudOMvNM?=
 =?us-ascii?Q?O06gmrP/wc0cuIURhIJQaz9s9y1R/i/Ud7OLQz38Gs48lW4uci3VAsup43YC?=
 =?us-ascii?Q?8Nx6QkMjEJm/BT0pe4xY17DRnGH8LpbjsB1KD9Ufk4yf1h7N2q2Wx3TksHnz?=
 =?us-ascii?Q?cjTkEDIOXKPYX6JoL0CVxoV1rFHpMKLj8eiq1ny69SCvW2b3FTaGOL4QEMMn?=
 =?us-ascii?Q?4Rl55WbUpl+7d+nMnBm28SZ4LaMqz+b3LNcrBFNK1vnJbwa9h2ENVNJsfPgl?=
 =?us-ascii?Q?6ecVNsaX5L4eUdQ5/KVeGsub8nVBeEuk0ciAKYAi3XIJ0vmZm5F7AiXbYpH7?=
 =?us-ascii?Q?fH4Z7dM9gMqntPLzbUgEJ0hyE3VSz1UgqQVQvgVSyAcaHzTPqcZK+3izjggP?=
 =?us-ascii?Q?aQB8nEFA+AiRako2wfKHbouoRfSPbNL5rjwlAukVxJ3lIInRpIAINtgVr/WJ?=
 =?us-ascii?Q?XcXcR0kt4NOUADKWgu2Nhdeq6FdMmT9jUYk1zU92xshorrxPE8+jCd+fEncN?=
 =?us-ascii?Q?UKGKnJb0vV03wijuMJ5MIs1VlXh2bsbDvnBDR7CBt7U1H1iUpq+Dx4VR/9KH?=
 =?us-ascii?Q?0G6jCOwX5eyWdKTZRvP8oKf/lq0FU4s/u6dFK6IeeXz99KmQqNRg0BjLdO0l?=
 =?us-ascii?Q?1I73RMG5s3kboz5qBtKIzKtBGHXfCPGbjl665ObXCn6B3u2nCj2ScfgZBUh7?=
 =?us-ascii?Q?OB25e56XGSB/m5Px226892B831vXkd+GlAx77WubqXcaQuHwr+roai74WTNG?=
 =?us-ascii?Q?rTnuigwMyhgToON+LVXSMzLhcmrqdoH2kdtqJJ3mx2++XJkKNBGyRhfJXCpX?=
 =?us-ascii?Q?klUpDy3g4Wa21roeSqD8HGuvVnssStjRlkdytwS0X9FSaXZtmAYzb/Yd680H?=
 =?us-ascii?Q?rGJhiShS9CSptbfAjClqBdW7mgo5v/1w5wVRyH9iQlYvDghtXnnwoyoUNcM0?=
 =?us-ascii?Q?zJRr4bmmefTR1Fx0E4SZ1I/tdvrayGtO1wKJ8+n4QUK/s7KifElAvYdVkFzb?=
 =?us-ascii?Q?u5f75EBpavYA0/AqIuPn6rgRXFX/HYaTrzzB3WrbWlOryhzexzYTHUpL1gxw?=
 =?us-ascii?Q?W/2ls1ayuizSN5FjQIozDzpY3PTaxqw5Hw9RlnUFC1uX+1lMkR/sYX16DiwM?=
 =?us-ascii?Q?TI9gLY2NzS0z+S865lhxENzINPMnNwM+SCZLpDezxC1TkqI/nr13mr+u56Sh?=
 =?us-ascii?Q?638GTaEK6mBBwLieu+6BmTlJBz7z1Hg8gBAG2r1kmWLFUm8wp7p8OjKWxcOx?=
 =?us-ascii?Q?gcQYBUmK4gvHeWI/nZUJCMlnIwHRA+aoFVUGOubAg5CaHl6Nt25ymAqODFw5?=
 =?us-ascii?Q?ggbN30ZqehZeH/Lgm7a9rzonhfEOMRPQJ4pDjOpiFIVgvBBBGao4k4wh5hwi?=
 =?us-ascii?Q?7S8K6IIdMHCBufYX7id9cF9iEpUmI3T9/vlAeec68U6/m5JX4JMR0EneTWiI?=
 =?us-ascii?Q?4ZXf0WYthWTNkSAswGvZY2Q5fZZB7mnVchjyfIOW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185ab4b4-303d-4f1a-b0b4-08dd93c775c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:04.2102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/uDvQrR2PUL+qMeTIz/9YTsM86H4LOCw4scZfz2TW8qh6k5HIxOodyV2bBZgnAk8YqiMRaCeF97Kh3TcCT4CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-ORIG-GUID: ZVGVfpAnQiPi7mdxMEwRhMVc3WR1uxmB
X-Authority-Analysis: v=2.4 cv=TeWWtQQh c=1 sm=1 tr=0 ts=68260c05 cx=c_pps
 a=X0MiYUndXFlT04tAhnTHEA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=03k_OfxykpieI8sgW_IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX5T/WLPooWMd5
 K2ytPaep6wlg56mJCK5zjQ8hIjBRy2ubneKCKwzIW9x3PSnho3l4HGSSeac/HVef7gW0S3Bfu+0
 B6kHB305pcDao5vFlzw9WVwjI4ZRKRsMKwDE5fVVGaWlmeOaOXdrqclar6PwtbyOX0lzuwSpU1k
 UDFdcdBs/Dm0QaddMioZh/NftNEhjuxQS6+/D0TGCJmaoZvAsb9ipLZQWp3FDBxVoYoaCuvJaDi
 A559q5UF2qWEkg+NkCQKgsSsuQpFN3Dk0rSonzzqwvC6E1tNYzLhDoJ4M+5IcStXF3b1U6vD/eZ
 gcSEhKlLK3yqaQxhIDYn4cFMEB9nzk7ioA0C4qWpsWPB0kXmcbUrvdpN5qxVSo+wb4CFoJODOWh
 XcC0Da5rHWpJGBXz4/m661iQK/ZWEbmmgD6uPZxWuDiXCpHKjPAyNz8QroA1zrBZjGeRoLqu
X-Proofpoint-GUID: ZVGVfpAnQiPi7mdxMEwRhMVc3WR1uxmB
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

IRQ setup uses the same semantics as the traditional vfio path, but we
need to share the corresponding file descriptors with the server as
necessary.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  25 ++++++++
 hw/vfio-user/device.c     | 121 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 3 files changed, 148 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 8e6ccbe9e8..920b9c44ec 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -141,6 +141,31 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_IRQ_INFO
+ * imported from struct vfio_irq_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t count;
+} VFIOUserIRQInfo;
+
+/*
+ * VFIO_USER_DEVICE_SET_IRQS
+ * imported from struct vfio_irq_set
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t start;
+    uint32_t count;
+} VFIOUserIRQSet;
+
 /*
  * VFIO_USER_REGION_READ
  * VFIO_USER_REGION_WRITE
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index a767e4fb01..45b91d22f0 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -110,6 +110,125 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
+                                            struct vfio_irq_info *info)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    VFIOUserIRQInfo msg;
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_IRQ_INFO,
+                          sizeof(msg), 0);
+    msg.argsz = info->argsz;
+    msg.index = info->index;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_irq_info(msg.index, msg.flags, msg.count);
+
+    memcpy(info, &msg.argsz, sizeof(*info));
+    return 0;
+}
+
+static int irq_howmany(int *fdp, uint32_t cur, uint32_t max)
+{
+    int n = 0;
+
+    if (fdp[cur] != -1) {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] != -1);
+    } else {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] == -1);
+    }
+
+    return n;
+}
+
+static int vfio_user_device_io_set_irqs(VFIODevice *vbasedev,
+                                        struct vfio_irq_set *irq)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    g_autofree VFIOUserIRQSet *msgp = NULL;
+    uint32_t size, nfds, send_fds, sent_fds, max;
+
+    if (irq->argsz < sizeof(*irq)) {
+        error_printf("vfio_user_set_irqs argsz too small\n");
+        return -EINVAL;
+    }
+
+    /*
+     * Handle simple case
+     */
+    if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) == 0) {
+        size = sizeof(VFIOUserHdr) + irq->argsz;
+        msgp = g_malloc0(size);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size, 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start;
+        msgp->count = irq->count;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+
+        return 0;
+    }
+
+    /*
+     * Calculate the number of FDs to send
+     * and adjust argsz
+     */
+    nfds = (irq->argsz - sizeof(*irq)) / sizeof(int);
+    irq->argsz = sizeof(*irq);
+    msgp = g_malloc0(sizeof(*msgp));
+    /*
+     * Send in chunks if over max_send_fds
+     */
+    for (sent_fds = 0; nfds > sent_fds; sent_fds += send_fds) {
+        VFIOUserFDs *arg_fds, loop_fds;
+
+        /* must send all valid FDs or all invalid FDs in single msg */
+        max = nfds - sent_fds;
+        if (max > proxy->max_send_fds) {
+            max = proxy->max_send_fds;
+        }
+        send_fds = irq_howmany((int *)irq->data, sent_fds, max);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS,
+                              sizeof(*msgp), 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start + sent_fds;
+        msgp->count = send_fds;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        loop_fds.send_fds = send_fds;
+        loop_fds.recv_fds = 0;
+        loop_fds.fds = (int *)irq->data + sent_fds;
+        arg_fds = loop_fds.fds[0] != -1 ? &loop_fds : NULL;
+
+        vfio_user_send_wait(proxy, &msgp->hdr, arg_fds, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+    }
+
+    return 0;
+}
+
 static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
                                            off_t off, uint32_t count,
                                            void *data)
@@ -179,6 +298,8 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .get_irq_info = vfio_user_device_io_get_irq_info,
+    .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
     .region_write = vfio_user_device_io_region_write,
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 3f5aebe7ac..053f5932eb 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -9,3 +9,5 @@ vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d m
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
-- 
2.43.0


