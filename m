Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E206BC83F18
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn28-0007gH-LR; Thu, 10 Jul 2025 04:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn1z-0007Vz-Tl
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn1s-0003VM-WF
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:27 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8XjUd005898;
 Thu, 10 Jul 2025 01:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pPuDxY4QWTE7Efc+/14RO1CaZk+qNTAYIF/jv+iHM
 rI=; b=k3h64MT/wfeFIYvJYWJmFyYB+cBK+67fYLXCLpwXDx2x+iZ1thc+VAu00
 JPlaYkmSJUBzAEhFw24joRhulDbu4pxMebUOfF8LQQDHKhXYYvWh27t4briafyP9
 kAVInzQULz1tGyNWA5p3rfzLZNGgjzv8j5poObzMQHdVXzp4+v5b8sdw8aklrDb9
 Yb8PsmzTT2eJ2hLwe6Dw2ihQ9ryRT3PdlQ8nRtjKJ+826/mTKABqk04OrhhyW/7c
 xX9bcwbPazGC2mllx5P63jKm6yiA09sjTgGNWP1Dg8Mt2DcQp3drL54BmxI2XN1e
 iXjZu1vvyzOImHbb2jyfHE19qST1w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2094.outbound.protection.outlook.com [40.107.223.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47ta49g1fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKpYYv4K8LD6L1FyWvek6SVCiwpFwzcssPTnJyKq6jppih7b2Brj7Q1zXmQ2O2Tdd2VDClsYPvN518dOQtVlhnI2E0iDmVlt3crCeA6Q5fbnU5WWllfGyo079rn+ZcNng03bbXqcCMmVaBvhTtmgvephxJ4bAsrivDz+h0Wm3wVPMRXIT7BlH5avxNyIIomPjtqq6+npSF5UxmpnpLmw9wokgsmK28HD1pV6dN92jbXbAVc63L3Uw7S6DTC38/f4Gyrlz90T+Y+rnrs7ElDUMlWRrcqfJEtVzxrBwz/vKVUDbsL+Hi3YWenEHdOByxCFeBnaNvdVf+fsF803BfY/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPuDxY4QWTE7Efc+/14RO1CaZk+qNTAYIF/jv+iHMrI=;
 b=SpNUWHTRVLj7vGBbrlJyd3GdALHhkonkpdJlFBKmP+zXHSb4PaeeG+YgPDWiK4ZQlZAkl8pXyS4Q0sVqd7GSut8mQyA8p1yE0QVXC0x8WHV1ETnA8e5F3zLopT+VXW0mG586g7NcqTmM3LAXvLrbvJ0cq32u3+sDiFHw/AB7wWAak6z6xyYITHUZJKlMhbtLdItGiSqBCYfjdEkV+qqNf/nyhVsdw8T0jZCIvQMI1AUbUV/NmJhTPZXwM1ntRX9bWliDagMw4EViiCjy63cCLnmEqcFM/voIWDYS3D0vE6un9DPcwDaVSOz/P1vYLSyES5ViHxTN3i5MEKcaaTKyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPuDxY4QWTE7Efc+/14RO1CaZk+qNTAYIF/jv+iHMrI=;
 b=cTmecLjA4YNdBzoApoyDkiJCG9QWJ4v0WObOqFGFIkeSsbPI/R/IQn0wZDi9qUV/P1tWId4rVHMpGHKcdaYN5RKk1JoLHQGzfZbDSplM+zcIsS4NuazLiba/QDn8qN37J/Ad1N7/ONYwIiU4l1tR4LlEr+Bk/rDl6PI5BxRiQGMCCsF2Fkkij4Psz3O3BYH4qVoAodF1E1SW8WCJsJgPUnXFJ3nWwUd2QYSNhGAgN8pWDl89OeSJF/2ewvnw2Hh5p4VMHKDROQNEziXsnVoCoH+51O7oCR8r7KbYpEQbxZpcJqELUERxK8tC8eEmHmf5lE28nlDFKmwluY02/twkmw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10266.namprd02.prod.outlook.com (2603:10b6:930:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:53:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 01/18] hw/i386/pc_piix.c: restrict isapc machine to 32-bit
 CPUs
Date: Thu, 10 Jul 2025 09:52:16 +0100
Message-ID: <20250710085308.420774-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:205:1::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: a18d7d61-6961-488b-3ca2-08ddbf8f35bc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0AhwuzJSJFOO7I3CHW3yr7J6QmesNsb+S4Pi3Eh4wSOKHM3+NFqp7sQXP248?=
 =?us-ascii?Q?c4R7ywRTjZH3wtrT1/oH1cC01KL2N8IyXPM+PzvyKn5t4cp+jspxBkm/WfYT?=
 =?us-ascii?Q?bpdGvHjIIL9lfvsJjTeUNwDtMGkq0CCbw7pYJs9APc6hO6j9w13XibNR09Xo?=
 =?us-ascii?Q?rPXtJlhC7cQEtwWsDYJQbGNrN2uWZ2MNx7kNtfvmutChGns5DRUgvzuW1/71?=
 =?us-ascii?Q?pEAYmp1avxJ48qi/DTb8lFTrQ30buJ5rYmE1EXwT2Y3V6EhnG1G9Jj/1IMyn?=
 =?us-ascii?Q?T3vcTGmNhDg9Jh4zu4FglSndL8BOtVmIPuv78oyMrkgAbQhBkHw5IGGQGoZv?=
 =?us-ascii?Q?C53RRE+oNfAmxorFqrQBS0ZoI4hHe9lxiU0YKq942zki6GJ0BW8+GKxnhkyy?=
 =?us-ascii?Q?jKpGtswFyxvY8vF7LIwnAdkrejYfxTJBFrJVV68XSpQ9mmyVDwvd35BsNgRD?=
 =?us-ascii?Q?mr0rTIfXbZMJHZiWDU5FZR2ERWc18jSrhHbbzaCZAdTu3lSL0qLyqZJ+8nto?=
 =?us-ascii?Q?i/7lsfe3fHA5kruuUmYzal3KZ94VaM6nS6z7pVnXKVra+HILbUIMMvaqJ/kV?=
 =?us-ascii?Q?NaqPZt6tzXYifE1oiz6LANCrJUTQ8iZzw3YeX13rRg7YlTUEb/ULul9GrTFS?=
 =?us-ascii?Q?7WYdOp/ofVS0g9goDLjKXeYtuXl0ICpUB82SS/HwusJ1DyWenfSXaLXdDG0J?=
 =?us-ascii?Q?nltyE2ld1qDSoPijaR2Ps0jAa4pkvZDElO+OH5oO9LohGu/0TsitY4jzFGvx?=
 =?us-ascii?Q?wo/GnJdRa2H8tdVc5Q1/NnwHH8ipZo2MFfszS/QtRDdVjiBNhPyi7XkbpMuW?=
 =?us-ascii?Q?VdMaIB1t84N4tz+EYff1Rp2wb0PcEKrjOYRi+F3H3zRn0c3f+Q5Mvqk5Afey?=
 =?us-ascii?Q?J3kLWG816ivfaUP5299YCeLUXS2tqHsd08wkajrz1aHkZwbCpduO9+WSSdgf?=
 =?us-ascii?Q?3UfBosvwwBsLnDR3sq284jo8GJh2r8lzCne9lQ4bS2ynZ/y1Rggah715iFNj?=
 =?us-ascii?Q?ptwpuarVWY0i+s+nvSLhSmbRsgAicVZBlH69hHVVVIaQKEyrIWJSUKbmYWs5?=
 =?us-ascii?Q?+/r0fkqapuk8TwVBpuCdIOXmK0HbhGkAf1k0i0AV5S433QjLK5yrjlIVP88l?=
 =?us-ascii?Q?Dwr8K9UbXbi3Hjsov4boyXSd029yAT1oA5Z7dSeWqHQ4PFww/nOhW4bBGSex?=
 =?us-ascii?Q?fC/hG9gEH4FLHuEW/sfqGqwXDKCcIOJsuIfkxFBm6+LxzI6fbjlYML94cJxw?=
 =?us-ascii?Q?nTY8bKUqp9EcDGAhjNL+938ctqI5iajqWkEgAI7s6pm3KXHoGKddOYf5XzjZ?=
 =?us-ascii?Q?WmAd3fUo8qPvbQSxb9bXFyk16w9Q7II96V9RzptaMwJm2y42sBOFjE67OPri?=
 =?us-ascii?Q?gfBYtiN/EN7kIxjyZTG8J6sXWIMKxI1ir9V8PKG6SqcfrKR7OFbn4MCbzqIR?=
 =?us-ascii?Q?ClWUtiwmO2E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ca2pIF3mOrlShnuBVTOtSv+ZjfmiszaTSHARybCU4l15xLfSX1p27YSiAKYh?=
 =?us-ascii?Q?0t9T/fkZfuQ4EBfznrgPIhpWlaXx0BGYa+e1IBZCjMxu0T5GEXlU4CIz/4lE?=
 =?us-ascii?Q?Pk3SXZ4h1K7zd3Szg1VaJAYdegH0AA62vgl48R7olsjoBWpyCZcA5jAj/xBb?=
 =?us-ascii?Q?bnQeMTBtDpHvLhq+G45os/RzovgNN6rcBLpaLz3XRbN6saNzGKIn9eCSIIYe?=
 =?us-ascii?Q?ng+EKkUbTNeJQeNVtjCzFHsWdAx5GWC59FOgtZyiLio3AV5OmyEambQtbRtp?=
 =?us-ascii?Q?zLL2HOAMmYgaDZ8NyP7XLg9nQPcvWscMK2Gb9vMdl24cDPMsPnJNWqIPUfdY?=
 =?us-ascii?Q?dkcsZRrSkb04ZLj3CA7xv2dh4CO4HIXGZg2gMWUsVeCn2rRz+GwWN/F93jJl?=
 =?us-ascii?Q?3jBD2apVrXO+nWwOPWnGdxgbvCAft9Dxe7c+eNe7jLFkwCmIMFPZaZPtQRHU?=
 =?us-ascii?Q?IdpUlORjuLfRqAcg9fgoeuARcpWBPXoZIkxTeT1zHxXZPmYNkt+q76msjqMZ?=
 =?us-ascii?Q?N8UwFRoS+ynlpqx5gHKmmutT5EY+gmeE2UrHtvBk4GcNg6/XBoTIukSyRUWs?=
 =?us-ascii?Q?NiYNtu9o+PeP/6d7omfgHUPokGXNFSxCAx9ZM/m0wudJYaV9wg7C8Sms0UO0?=
 =?us-ascii?Q?ffges6lrsl6DEoTHAazjGinHUXqJNKOgzxgE5/FY9u0eHJzWusmfZ3ddst2r?=
 =?us-ascii?Q?vTDUxKkyXUTWv5Fm9xJkrBVmuEDOv/f75SE57O+bKb7v7HXvdnXSa7+KQdoM?=
 =?us-ascii?Q?gpUBJ4jmrnyy1SPiRZAauxkUWf2VJBdnohZmqavHjIyrvHJb96i4NqN4su28?=
 =?us-ascii?Q?EZ2z2pu6Hx4cC8PkTrrQER69hfl+cjOMBpmqiY3gzQDDrdA6wrZJi4UCpJOQ?=
 =?us-ascii?Q?A8Usyifrw/rad8tQBmobv28xcMUAkFCxFYhQn0ALtce+4Z2ZF+JHjLSUEC6p?=
 =?us-ascii?Q?LvUU79wZPuCHV6r+/jrDN8KEwkbHaHgyarwXRRyrNhDBpPnTfm00WmIaP8g4?=
 =?us-ascii?Q?1HoouetiVkcPscs3rGN1rCcyl4dxmpBXROdJQl6HgymXn6sht0JUmgUzi5jp?=
 =?us-ascii?Q?Ja51+otBZRlM5cVwcAP9DVNTqV8scO4DMJwwMwx7K/Bf3TyaZIrRT5gV6uvn?=
 =?us-ascii?Q?05KKrJy0TaNt8piauN+4U/ZK/zJE3c7MtmhAZ7Q9WidTS8JuJhbTr43xCwv0?=
 =?us-ascii?Q?cvd7FMMbIdtkbm2GGMOLiK5G2g5MamJfu/GJAD/G0qnyCseJ1T5SlG4qU/FT?=
 =?us-ascii?Q?9zwPFoMQWVoYUJ5Lx+sMV89XXCOuvZgR6AyppqTyq1x+vTJ0Y+YL+ocRmtgT?=
 =?us-ascii?Q?uQKgCBvs2w1OvKP5nH/D5V6Y0KHXQd9RQMdRH45BvVSCKzD4LH+4nexzefXN?=
 =?us-ascii?Q?b3MVyxVfOPNsbGE4ar9VALF6Em5aUklPItwmgfNtHdW2bg0C4MhLE4JwJNvw?=
 =?us-ascii?Q?z6KpJX4lmUF9v7KtJ6b85RV5oF1ghb/xpVr/h3XNT4mIo7Aqu8iUYV6Ac7kA?=
 =?us-ascii?Q?3eBXfBkfuhm+2HHngJGKrGeiPXS+e3paL9oHFMFOfudw/X5psyFYky07oiq4?=
 =?us-ascii?Q?RmvFaEU/WzEPEBNRbBiCceBZiEC/+KzXrkSOng5iSELrEIjwdxi4iPLmm5++?=
 =?us-ascii?Q?a3/4CrqWM1Hr6rw6TB+o6HU9+50i6UzHLkBbm6qVsMidSe61AxTUrDm4aqNs?=
 =?us-ascii?Q?KS5sGQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18d7d61-6961-488b-3ca2-08ddbf8f35bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:16.0127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOllk7B0y+c9/V3LK57gM0jt3pck0x9m18dal98vEamT7irZnKOf51cpautfih8NNxAhp6LSSiiegn4IEORqHlJaXDdZq21FgZxeLqTM1xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10266
X-Proofpoint-ORIG-GUID: R1npdgCz1LyRA8poogC6mVUcHzH4u0FT
X-Proofpoint-GUID: R1npdgCz1LyRA8poogC6mVUcHzH4u0FT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfXwuad7lWMI/5u
 S3X3IrVYQ+ZcvkmDuWJ471URjosq0Ty7aPTbwRwTluK/AIlLWaxgd23MWXQO39up8HB5KL4kll8
 YFwitJU7rECZb+KTo76hTTHNehbWfVBJAprOb8rVzs/PDa6+Nk1YXA0LuGOE15htWtncTTQy/QK
 F2PK5Y5bs48lKy+yfWtFSyr5BTfPfrmgyVsP6zzdkT9d5u1RX8ncWyTWyftHVZdSSm9DoMMwSKt
 XkGzayMNP3qNhtHvg67eXzFQXdB2tJ4bOVtCmSicsPD8Bh5elTly9A+AQuUdofC962BSaGRx0Ua
 JZJhdalFCk/s9VQD4cXtGAtPyVmyWzza23h5ustwPs80skR9S1YEDPXB7kwqmpdqAM9GzG5UO8k
 W0ZzGmZeJEmUt4elWXfnm6VLAPmxF/jSFfBNJhyjH9P+kPCKTjf+E3gskIVZ4+5VMbJySozq
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=686f7f7d cx=c_pps
 a=fxbcSSzt6U1YglO7xsTYVg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=nuetpX4ixqIVgyrW5aIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
possible to specify any CPU via -cpu on the command line, it makes no
sense to allow modern 64-bit CPUs to be used.

Restrict the isapc machine to the available 32-bit CPUs, taking care to
handle the case where if a user inadvertently uses -cpu max then the "best"
32-bit CPU is used (in this case the pentium3).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ea7572e783..67c52d79b2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -418,6 +418,18 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
@@ -786,7 +798,19 @@ DEFINE_I440FX_MACHINE(2, 6);
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
@@ -799,6 +823,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.43.0


