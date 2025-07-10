Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32958C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2M-0007nk-S5; Thu, 10 Jul 2025 04:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn21-0007Z9-DT
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn1y-0003Vm-N7
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:29 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569LQdSj015992;
 Thu, 10 Jul 2025 01:53:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Itm3uTp6rIv3usi9+1o8mDIXzHDuzWVu8Kdyjrg7C
 Bo=; b=z+lj3mHnkMgpomRZIeNQmHTr0Ba7bKRaJ9pyW3R7FG/VdNSyX25B+3PVz
 ZYTaksEy2yMUg1v3sH1im3q0WObaWHhY+Ybzw1HFHvR8Zv5FwAgMRseu/0KMgOWn
 aKf+/RehP4wgv/g7WTIeFNtZHI4c94vijgHDosSgFhG55Mb/381nO640i8N2rRm1
 n91TnOr4Jot+vxNHM0mdLqRfCCOBq4BlLJT8GmfdCakQfZbn8nVJqEH+U066kGWh
 gryiv6jL1oXmFUaJjbEoBTS8TL9bFd0oP1pqM05YaDd2LarxyvTzGSUbiSmfP1tQ
 jD2hHwJaf7gkmHaM1Q9HF8OyFHYxQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2093.outbound.protection.outlook.com [40.107.223.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvn27s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIbjr2JYcwYrQE772x82UWNhOYJ0pni1sUQeti+P4wkVk5LROIDFdbXsn4cOgeIy66arsCx3oLtLw3ccqAY3KQuseIQ6V2i3vTWoM962Tb0wk1TnfEYsWCt4phiMaeujhHiw9s6/FZRy4V1Ifyray6JWIlwWr9ECk1MKT7Xb0lEy7AylvL7QynNuU07daTYr4vZ55JW9jUX9VOZOmAEdrpjJ47iNG3YpdokJX+cUyIhGz5Yk37Shz4JXluadW0dzZBb3/0O5df3PlKmxHbIofA4jMd9WDSgLt5qEwpLzJ7Z7eoTEnYZLe1DwejnGib7q5cNpDJ78sTCtgOe0cxsRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itm3uTp6rIv3usi9+1o8mDIXzHDuzWVu8Kdyjrg7CBo=;
 b=A80WN8+WBpD064sGk0xzj7G0S7XYjyfjjYjBtWkYK0O1Ni9+tvxPPJi4pSW+ppAIg3nQ0aVSYJ7Bci4cYnwf0nCnLnpSUapA1dHxfFZviY9AZNkp0r4m7PTdSSy2A7E+uRWYEKVqOHJQ/74RzMDja91LRb2Sz2Zy3TGSoK5aN+uwuEQxhAbDjHJ2z8G7PsCU3i8tnTxOZujBM1BFdikBGDXrdXoB+xJbMbwPWwjZbpBlscqw0P+MvzrRoePePn9l/eLkYMJcb1139+6hqtfm3BN9UFl0a72q5CcXWQCAuUzIXmOevbN3OZea6ReycqNfL/INSH3mCWrHeWQCJDlJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itm3uTp6rIv3usi9+1o8mDIXzHDuzWVu8Kdyjrg7CBo=;
 b=MYwj9n7KOqP+2+uq+HNVpPR4cbiyZwgwMl+njwRumKBejSkjD5fZwR36Cmu7zVn/0sJFFPW/vDABOWZ0sHGuk3UvUCihQTCoelw1WxHeu+SU4O13rEXtvpDIy+IMWV4Ni3uNj1g6hYt2Ymcl1jXu/4fsyaxjYpHeZ4ihjQ5vdwZXNJZTGaaHotcEHVmTagAQ1ODidHB6T+5WzOp/nawFSCLfFJGc92XBeTfLxexemRlU1Ad7nN7nTon1sj4+8ugWnsQRkKgq5v8ZAbUxVBMiwpRgfo+uVl0fKtV+xN1gkLu+JNrIG54nHEknOHtoOzCgZ1RCGZP170aGLGchT+VVAA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10266.namprd02.prod.outlook.com (2603:10b6:930:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:53:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:20 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 02/18] hw/i386/pc_piix.c: remove include for loader.h
Date: Thu, 10 Jul 2025 09:52:17 +0100
Message-ID: <20250710085308.420774-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3107918a-62a3-4640-1bf3-08ddbf8f386d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kEUba1xXYc4NDXTNpsZ2vZuV0aYUUQBeHry3L7+7rk/NQAds3QLw1MOxqbPU?=
 =?us-ascii?Q?27ii6CL2gtCcB+VQues5gU8eDXkUiwXVNpgMAIuL9DN75QGaX+cafSgSniwM?=
 =?us-ascii?Q?rx70AWH/ddXhUsuGLmFNSeMWviI7hbzLKHfiHeApVAOkGSbB0vQ1ECQW+ryo?=
 =?us-ascii?Q?Whe7DPKaB3XiSyjDbnoajLdfnU4XzxtpcUoKZT86ldd1LJsppDhfOkFQn/4l?=
 =?us-ascii?Q?M/N/meGftpf5mjIRpaJV939EXh1ecPTxYPcTKBJ6YMKPPWMrXqtu6FRnvMXO?=
 =?us-ascii?Q?4g7FGi6AfYoqGeHiW2/VvaiLb9zYvdYxut3mdcW/0xqAw18V1XT0x3hDvx2f?=
 =?us-ascii?Q?JXMoezhdhzIRAsvyKB3TiUIFOTFL4tK5Ueo2TEZ88iP947IveLSdI/aG2AK5?=
 =?us-ascii?Q?TXKdTvx7xitDNexgt/Bilr9Pm54ldfBHix7QDIzyic1PkJgcchBP3J1vcM5O?=
 =?us-ascii?Q?uab1qHauazNCCtaX9IqXa2Vi/ACItuUDf6dq3/xV6iNlk4cZ/rgo2iv+K3aq?=
 =?us-ascii?Q?7tD7w0U4BikaR9sYG1HnfzccZo+szAtIGre6EdWTSoUC6J/hGlOFotakKeGz?=
 =?us-ascii?Q?J7pi+tH5XwPt7oHarce9cJyuzSIvfGmdhtKneoCQyVusFDWswjjscAjpGgTL?=
 =?us-ascii?Q?4JlrHoFy6ojnKFqnyThPCqd7Hd52zE4INp+8O5n64H2iFzjN3+EZMBSQOy1r?=
 =?us-ascii?Q?9akFS7tnJF6lIrhrd1WAVP1Flc8Yt+84XEUAJ0EYE0S09f1Ti/6NhjdVvA/1?=
 =?us-ascii?Q?/KaOV8baXLVR+rSCeruu+kaGVuVVQbzsvazsYvZdDXaJo65l+XMDHSsqZby8?=
 =?us-ascii?Q?bY0Nd9gYesVZTOLW+xmV7r2z4kB553XgMxtnTsISrpgALCURXLSaRBVUaCo+?=
 =?us-ascii?Q?QLQZPAPUe/rS5ucsIyx+4jAIB+6PnyUX0/his4S7RNa9yZhe5s+gm3V8jfom?=
 =?us-ascii?Q?MzlcA/Cln9IsrDr1qICdK96Le86/081+tDNGH8xh1A3x7fDG2PEomCauAyXe?=
 =?us-ascii?Q?2ouI2HJA5obrFAILNDInp0rCLZ+IY4YCOj//0R9tnzUPhFm8byDcHzbrPlJo?=
 =?us-ascii?Q?k3XA46U+JSdCetyD1zq6E7QO1Gno/GKhKaXBOies/UFTVKubh5T+Wmb0mcYd?=
 =?us-ascii?Q?ZTyXhTGvBY+0PbnuRUpIWNFK6WkYgOjJlu9IxpylqL29b61nHJmaCIM/r9dR?=
 =?us-ascii?Q?uSPN65QXIOgK7SizUcRsyi8GlfgW0HdBuai3etTO3h7QP7QC1L6NJ4YlqG+I?=
 =?us-ascii?Q?AxPSN8hUVEVw/gf8rbtuDh8ZXYIav9njz2RNCkIFXWmQkswh4/Mwd6DvrNNK?=
 =?us-ascii?Q?XsZcM9RXzh6VLZlbXHwXXbbKArHVutWk5kdibxB8Onq2AMe2O/iIVl0ukdJy?=
 =?us-ascii?Q?Uxc2ENb7MuCLv1N8oq91vgpMHPNyUw/BB388MlX7kjO2FyFRgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rq1fRsQSOJqxMHenO0osRTKCNVjbdpTJAs+kubwNDwz0tapBLEusyRCqZfCJ?=
 =?us-ascii?Q?1UV1qkVYmCse5wxE7OBg9sa320ddCg35IBGM7gyTzqzFCLkPKtN51ES8Xh7v?=
 =?us-ascii?Q?JRU+o57tpOnIhGIga9x8i0KDd9vbzM1uj4yGXrsYl5CMrJ+7atEw6mSwL5hk?=
 =?us-ascii?Q?J7SS7GT6y4IjhRfxyVu3t3WHfAOEidU/xVodrznhVLbayh5qAl9LDSgCRA8w?=
 =?us-ascii?Q?zipqJ3ukG8aPIHygB7X1/8A4kdH+nw00zwS5J+FhUmq1wZxl3lAdaYdtN7fS?=
 =?us-ascii?Q?tcFFaefxRmaiuWqZTK3lUGjiymwGRbvn8kK8zVJlYKhP4cQMoAt1mM9thpLI?=
 =?us-ascii?Q?58pPMlZVxjRFDCi5GPa7IM6FFuODddY7C17rH9J+CMjjrm+VZTGcicSTe+qK?=
 =?us-ascii?Q?WSxjmrJ/5BL2xtVvOcwAXvQEHUX5EkkyUPo2zcTQ8eWXI5cmHzBtcjK1+snp?=
 =?us-ascii?Q?OKWWk8WZz0viDYfJTthmlvoAOrlcnMk/2q+2Z3BJQyd5/CnqtKYAZ0QxbMFu?=
 =?us-ascii?Q?qvzM8s8nEvWkzcEPrAqKh7SgQ6jCQhChJ69GGvLuXEqhd+h4pDtBBuOf/JBs?=
 =?us-ascii?Q?7HYGM/+vECllZ4PwzzFDsp+4sqGUX11mmozSx7FqNjbK77QpBNqivZ+Nq6yW?=
 =?us-ascii?Q?M3+Mz0/pDSBKHV5i+6fr5DA/Ql6r4Ya+1fR2poUGWGzD3ljL44zWZyCEeNW9?=
 =?us-ascii?Q?/dDztKzSxJe3zcIbRtHyC6Gm59GIhC1xjFZ8+iTB0lV08YkoOk34wDGzVtye?=
 =?us-ascii?Q?PX3NJeSxRku1VLgMsdJQPt7wpdxxfnmKFaXEelJOPKsdhr/B+uycPIiQ/etu?=
 =?us-ascii?Q?mMbaKUZSVaUPhof72y/zuWS9YmnShZWUIKVegnUlN3YnQFEXu8WVckV1uy1Z?=
 =?us-ascii?Q?RaYLLVjiEE8SQY1lXYMc1U3Fp/oTVgJtFru0DjFgfmiZY0MaJpOwPNFdBMbp?=
 =?us-ascii?Q?3FQWCxW/y2Kq4kufvICQT/13DenXk5CplDJzdlrAOhgDqeTLSxievyoanQ11?=
 =?us-ascii?Q?02uJ2x3nw+oVZtDw1cIbnFwvWwF4vclxCOC0U/rqynqc+R6KFIm9Jk6Ff5uU?=
 =?us-ascii?Q?9VG9eYgCw07ydM2BHwb+XAcU9wqUOlYuXHxQocLfYoMlCsgwx9W1I/s3ZTc0?=
 =?us-ascii?Q?taMF9EDZxEZtH+JPlFcH6XeTQTRiQa5UM+K7HpELvWxYeMnTRWvxmLUBbjsS?=
 =?us-ascii?Q?bJYnSgYIx50VcCXqi0/Lv3TNh7bjFQR1y/I6s68Xt3bRVK7EQ8g+JgTPFwX+?=
 =?us-ascii?Q?trIa6VHEoQwGoPlixdofWak03vPztxHfHGrVzuz1lzKqK/Mp6CqXiXDUtRDl?=
 =?us-ascii?Q?bpKWttKeW6dc5F/4WUWs8eXDbWFgq95Kpe9Rf2P/EoctM9chDPWnNGMN7Fw6?=
 =?us-ascii?Q?04QlvQjaiRirW3582X7KmTw0rGtc82van2DU+FmAzhTExGCe/CAMzcpxBXJs?=
 =?us-ascii?Q?Lk/pbpoBd+I67n3kuD61ttmIbUtmlzNpldg+BTJpgqAci4Pvmp7xe2gY8NMn?=
 =?us-ascii?Q?onJUSQegoGJdNSQoECStqMCoZ2m09+vGvcY/iNdJtzUidvacuvvPEhGzLXN+?=
 =?us-ascii?Q?MmLb/lWt+jeJWzLIoAGQ4E6+Af8GanV1bR+vh5iFb9vVHZphiBV9y+Cg3vRP?=
 =?us-ascii?Q?AU3XNqmEAF7wCVFWkk+GaQK0XrcnOp0istY6dqJ+odGBC0O1po0dsICBcmXC?=
 =?us-ascii?Q?VVSv8w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3107918a-62a3-4640-1bf3-08ddbf8f386d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:20.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkfHIKbmilcSnhrwma28HMd8QTiBw8V0VdMAXRavd3y10/fW2CcnuNNxRC0c2ZDGPcKVCEwPnWm3XiXqF8sPaPFbxBk7koc1d4YA9L62Rw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10266
X-Proofpoint-ORIG-GUID: VIunBVttXMwq-r0Jx9NtbVgavB-kjSO5
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=686f7f82 cx=c_pps
 a=XL6KAwzBRdtyn7N5rzO1KA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=2ibDuaHqQIY5G2AKcNYA:9
X-Proofpoint-GUID: VIunBVttXMwq-r0Jx9NtbVgavB-kjSO5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX4cLvhLUFSB2S
 y0xAibcrJKSKOLn1oNSubbbv+h3of+Yzgy2BgU+UOqfzJbZcfG6suevn2dQPMqbKujIExJ3RGSr
 kaijGBIh3ezbXDiyDYECDQS7sU3EQRQfNcTGk8VKf8gYsPKIX+Xa0in3ViBRpE6SR3Bc+x/SpJC
 X4N2qWNC1YAncNTPS9i2VY0j+W0Uohye5X+q6XEEh4nGjt1bX5Frfp8ivZgCiBFMhKr7YacISor
 2NSGUZJHhQAynRokO0GasuyP6ilXA7a+Id9gXuAeWEzfgEFA8vh9KizqMzjWuSpGQYudEjhFrpn
 QwDv0KEaCp0+Vr5JSckW0zShld3KmwHV8IQNhRvL1pKaOlfjnjVXdF8ZwsEE6Bn7Fpbaw39y2v/
 Mx2huaEEW93XxySNX/UzVLVT82oxJWO0E/IOPGeSYh3bGRTqyQ9I1okX7fY8oi2iZZZeX+mV
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

This header is not required since the loader functionality is handled separately
by pc_memory_init() in pc.c.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 67c52d79b2..f66eaeb910 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -28,7 +28,6 @@
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/dma/i8257.h"
-#include "hw/loader.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
-- 
2.43.0


