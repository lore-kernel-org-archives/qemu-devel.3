Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED27C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hdk-0008VO-HQ; Fri, 25 Apr 2025 07:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdh-0008R5-Ls
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdf-0000Qj-Ep
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:41 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OMDC5D002614;
 Fri, 25 Apr 2025 04:54:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DgzgyConiexY88ymzZhrnjE0h6lbEdwIy26TW7pA5
 +A=; b=LPwiNhSwok+ugWMibD/MBGA8/K5hSaamXuqaJKir/+D5q37QtLkKLyJUy
 QC0N045bex7U6JdZdSl9Z3Opg0toBFf4XOnoInqHaYwahIq8q5qJNODiw37ej/ur
 aQthMpyU+5Dz2pUWQy+Xhu5PF2e+5lYeW6p4qUJJT1iXqn0Ja2zaCqfbYT9u2K2I
 RcAyF5mClXnlGfyubFlJ9o26gMvik7eomQgcl1YbrIyai5JJy+3C/ulROo5l17m4
 c4vten3mvB8gcHtfvouY+4xcA4PMYJgUOT/GXYzdOPamRnwiDPO81DTd2bkxc5YL
 BtzBEWRQe+Sy27S1g9L0mX4/wIu0Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww7s9v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCgRbJV5QvdGpXDzmlpcrWggnh2GhEq35SixAH+IixkGszl/vqfyMHAtGyL+Z5w5BsTxIdiB5ITzfMhu46fCSNgv8VPdU+xR9NEd5Vtr/YljH1J2JlXw9boVJxy2a7h3s6OHo6iJrh5Nva4o95v42504OC/9D87Jf9qRwC9wlWIDSLknCQwmJmyoApO/MOMrguYz3Zz/5mnDLbqEX6zJskm1TFOoxJLnwYcBWx2AFomEhP07/vIOJmNBkbfPOe3eCFNDurKDU26+gFAjKDRH/xWfJXU32LiYNNobTqike8BQrCSia2iNi+fEpLidNBYFDEAGDyWDrEl/Dqp1djIZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgzgyConiexY88ymzZhrnjE0h6lbEdwIy26TW7pA5+A=;
 b=lq1/ySaXYH6hB0JEPaBjYyS0S2hWT1rVznaDYktohe6NLFhAJF+a+ljJU7Ze4fC72XWZjcJi+SagPCRH9cd5c1DSA6NZgDVXvi7UHpBs9eZjaCrzKGFinC70VPh1L0d/0XugM0h9EizMKgGyXXe6I3FE1xqib9aVgdIMakKoPnzbI8B+I6jTZgV18HxrQ/0asOg7+HgrQOEkyGq1a6WoUi6C5B9GooXM/pgl/WlAdxwIw+5uDvYEn/iKEJOysTZSGUMaj4TBFlUW2wHK3poef/z3UnlVYvdYmrASPn8b0uSi336EBFMZIGuij3JcCcslPtS0B49I/GdKIjfJsqObqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgzgyConiexY88ymzZhrnjE0h6lbEdwIy26TW7pA5+A=;
 b=KcPqSwl7iEz960IfJaL38iRsObtwdnF0iXrp+lFt9yUydFhmUbFSmhV9xAHhrLQWjgqaQfDYNLO5RItFpQKN/GB1aLkPURSrLhILoJZY9Ti5DQLf290ImfsAGeXKodFplNyk6RQmyKzob4SkDATFk6eCh8LwN0snn1zGyQTDl9YFPX3bGO57oBMEeHYhb7x6F09tMFbJEdrEVSUQ/JP2mP81JyRcj3v7nayq4XS+EM4CkWk0t2lYFKd/uNCyYLL10mwh6bW8+mZ/PRfAnW2w2aBuftjUwVsRlND8D77WnGvPMOwtGbyj6gsVHVDNcIP5OMS+06lrBtKDisjdrOKY7w==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:34 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 10/12] hw/i386/pc_piix.c: assume pcmc->pci_enabled is always
 false in pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:57 +0100
Message-ID: <20250425115401.59417-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::22) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: ad428745-9a41-431d-af81-08dd83eff28a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MFGnz7FvfsBOHj/3mKYzJhKcOmgsoE+y0Sj4TtOg9XRsysugke4YS6Oxx8NT?=
 =?us-ascii?Q?b6iJpT8GG22gK/9z/y5quA8fQzn4PcDGisUpIwR5oOMhaz7i5clfexYetlA1?=
 =?us-ascii?Q?0gtsbam8fwOhu+X9Ex+4TP7FilBEVYtblsp2ngmXkhmo22yrC5NXajIW4YW7?=
 =?us-ascii?Q?Ky3iZ599i6dBeo1Ir6ZSLwxrv1AM7Bwgb714z7uVorBTR6tftPVfQr+ehTmx?=
 =?us-ascii?Q?dUow7JwbYj1ExEj5JhH8Jc4UKNpSS9XOgzkaNz/WP9GGRqRq+F+7N5e338B2?=
 =?us-ascii?Q?+QzvomLmAPQoiM4FGJyzFIywN2FTiZtURW2rk/50Euv1jiTWn0kdUdCyHt8a?=
 =?us-ascii?Q?Jnsr6HrpvRXKyVrLwBvcFY87XJ2j/yxTb4bk8bz6IrzuYLcaBeWUGngi170r?=
 =?us-ascii?Q?zNxzCXufE/fYgMq88dvPPixrXS7R8YgdcM0TdPdlhZr+B56GrxJpiF6gurse?=
 =?us-ascii?Q?Djfc/X8kPJfbu85LZvxOGRej9dLqtXcGR9wNJwvKGLtU/e7zAFaXuMO7FlHM?=
 =?us-ascii?Q?M/BqfyF8+bC9RzILAyCcE5+S6FOqm/oIpaWjEzeFZWiBYA4zxvSanW68kdgU?=
 =?us-ascii?Q?YfzodPTc2yprtiLYm2YbaNwDy+mrEGrA/SUN9LjGRuI4Gh+2tXQGQUv3EjJ/?=
 =?us-ascii?Q?2Xrh+1Whg5XJQctWKIStsrn1+/Fvkyde6gijSOfooiS2D9Mq8VF8KkUXSEh4?=
 =?us-ascii?Q?5bhrjaFlKLFDgNBrk6HCvNvq1vdEjwumr3xSIDlJBKrVhON3bAyrSocx/Q3+?=
 =?us-ascii?Q?urWlVobKggcrTtiTTBavAqnHqO6P5Y0V1uVGVgRzSL1k++4y3MXrGMMCHoUX?=
 =?us-ascii?Q?3DUItfGKiIvlu5IJr5XAR8h0DznN+IB0lzylG/3OKpGs+V7f40dt50NDvjDx?=
 =?us-ascii?Q?bKnibB/5R/fDENYYfeAgQSErFwyt07T4qllmSoYoqsJAwZhcLPbqkdGeQxOM?=
 =?us-ascii?Q?aexKZgLRawEaNp8Ga9JXSlUWYe/VKEe6XqU2ICDhRfDgAZa/fdJJXGmb9ofD?=
 =?us-ascii?Q?XkDZqvXUHkO8k1a1RKMKK1Gq3f5gXRxAYAgDo2yNQiz02P9L3bIm/6Te5N3Y?=
 =?us-ascii?Q?of5BvXLgNFUT9vk6NV0TiDNhvEKyxyMQkneYXDCKBtvCisqcTz8Q31zZPca5?=
 =?us-ascii?Q?bQjcEqhD+zryymNd4EgboQ7/5WZGqnXbLciMh2fIWfF511Me/N8+fsmGZa0C?=
 =?us-ascii?Q?xdbC/2tIr7xNCibNDCCV/TVexXCoD9TUwDgacydWjCkD3IAI12tOcJ+MEowG?=
 =?us-ascii?Q?0+cWDdzerf4UluCVNp0g3yXhOzzge2I+ofdEwfq1jhReC2deXRUK91qYyzai?=
 =?us-ascii?Q?eGsq8X2OK1MHVX456vag/WIcMlBH4qRB11tAxLKi8AzwVsmnZ2ZmezRIm8Q1?=
 =?us-ascii?Q?ekryE9f34HY05vJrh5KV97ROKqI4aT2+37yx/hX/T6gtgj2Ye7xR7EWY7hYY?=
 =?us-ascii?Q?vHcWBFyg9Lg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P/QnzOYdbJwmgTn+p28+dx0vxR/Fbfk4VCYw+4PLAXBtZ8mfQwzjjVMdinha?=
 =?us-ascii?Q?AzCtBVRSYcNE9j/Q41NVpA/9zHB4wcULVfKnfDJMvU/f2kRhtQvCsRNUT35t?=
 =?us-ascii?Q?xaH+tXoMEhgCCgwtqFs864xM0ziAZUWsHsqHeKkBdWzdU2WiofeOdsquANeA?=
 =?us-ascii?Q?KUPImW84/TMF6pVRpPTr84frDpUR9aNIDhJgYTRXnlg7Ha+huXaXK6Y1lhrU?=
 =?us-ascii?Q?TXFsptikPvfCuSe8Z06mIgxNfsG3Bl0MeW7Wi9uaST++Do/tnG0hfViMH7Pk?=
 =?us-ascii?Q?3IQ2qT7tAcs0c5JnbBnY1LUDxuQzXpVuO1uMuvFNdzulqxxsEpwqoUy9Vvsr?=
 =?us-ascii?Q?z8nFRB5hv76VFQQiGtdkKR32JVMDmyAT+0OEqQpnXiyyKphElLqZSsXAz2jt?=
 =?us-ascii?Q?Ru8BzhUJrvsdFBlvZlZ2jjF0wYMK/cz3PYcHxOjrziIjkvXetrbdfCuwQw8v?=
 =?us-ascii?Q?Mxe71OqSMPX65Fx32Dc+jQ95YHEyceGYd2sYR4iUaMeIC0kzs3glseY1fKo+?=
 =?us-ascii?Q?gDARkzGJZEfD+9Hf2N0jOZ3KvsPMYDCQy5OBMQKivAfqfBUZgrZvUZpbXp+o?=
 =?us-ascii?Q?0gEzqOCLutiPiX5tEphaXQp6Kpp31NigQ4KmUaSB+nVtnoQxejEweM37ZYzn?=
 =?us-ascii?Q?qZ5mgpUk+jN2K13hJkI+emrZdAlmnO71MABWV/yv0bq/MPsDa60J3Q4OVxC4?=
 =?us-ascii?Q?ZfyP2EFcV3/6H9NriYTBJmA4VWOTnNSbAucX1Of/nDmT9yFATS2O4gJ+TpO8?=
 =?us-ascii?Q?dQQbxm0vgyVKRh+lCPE4uKJmeznNWzPCXVhfycpKLT7+2QkuqVRC0OZV2hO7?=
 =?us-ascii?Q?931XC38V8FQg+44Vg9LaoGp/sT5P9GDlqDMilT1JlO/tkqo6CWZs4ZhT0uzu?=
 =?us-ascii?Q?CBCunx19p9lK/gvB4Lr2ZwdGH8Lri+3FD4sJTVfgmmb9+JbAVR7Asv/jHCKd?=
 =?us-ascii?Q?INj0G4CcEiiUYzysr60ghNQySl3E/2W0bFClghsUDoKBb5eucdO64Te0vxRg?=
 =?us-ascii?Q?tqG9vqWZp1BD0FlWU3GzIs+4JBAGSdD25KRXFriD454Qzmy1pjn7BMqWBlLY?=
 =?us-ascii?Q?XFjkZJoiC63RLV3B0Drco7kVYLaToGlarLhSJaVlIHmDAEn+YBPw02TvxJBI?=
 =?us-ascii?Q?6+kuq3pkgd0vD3ddcZcWpdI6G23MrI71W1cq7Ql5wnGTh8uRu7JpCRB+I7Xh?=
 =?us-ascii?Q?3ipF9UwGzvfQa8prBy1n5CVwFNixF8hNzPu8L7QErRhZGaPenXud11jFrymV?=
 =?us-ascii?Q?VXHBsqu7W3Ntj5CF04G0BejiiUswoV1U5cnLbAxBoHuYwBVdH4AfyiAi2nWl?=
 =?us-ascii?Q?tbhme5ak+NQiOVnaXuL9Isc9IALgYLo1CJLSxJ83a9zXJdkuyhqBq/q6gFFJ?=
 =?us-ascii?Q?6lXXK/uPgdP38GYm+f2F9w7I53Dx3DfiPFdWZR3z8nJ2qGYwn7OSikKS7A9x?=
 =?us-ascii?Q?yr/Jx4fDFu9coBVYMy3+vb/p6kWxaaDNHPJv3TUoHylL42bwE88JhNAJZoz9?=
 =?us-ascii?Q?SpGfZUDwtE+fd51mjLaJqBpHeZbcgxs4OSrF5FE4nO/CDT/pQDBchoiUgLkG?=
 =?us-ascii?Q?zM5TjAcp8VvJtw6yjByyFllM+HxcblXXg+VmcDbZYXuDVb6oCAqcsch9gSMx?=
 =?us-ascii?Q?f0WtQfZJwHdIWTRtIrNzpYTnJEBBmnel5CMT0m0R5WycJyeXG/HbsxRzezFt?=
 =?us-ascii?Q?PLa5HQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad428745-9a41-431d-af81-08dd83eff28a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:34.7131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9uYOIsNyXBE/N6kF8aZItswM3MD6a30hB+0ENwKpKSjCgDSh8f0IGxYo5dUcQKkcbabqvNmyevnlAst8sTozhitFJn2yLGiqEAmkDqJLA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX7b/167ehTP5Q
 FmvL0tlat5y7nujfvpMlHdiEWAaSFKONsbUKwnFWha92u7r7pmyDyrhKKqz6QF/0hBb3TY1vs7v
 T1tGkXtjacigc3Hph4Fwri5pDNojgfCS3MLAK8a4/Yj3rhk4ONE69Cu0WXakPiCbgjUa6XgV1nP
 uYhQ2SPZ6YtbMGlKOHzr8eGjqABWTNqTaXwQSzKtjBK8l4AYUdvCgkPQ0hq4AnzySXvVjYuVbhK
 XZdyEBwUkgnQwk2727PP6o2zavKivz0ofDJc2iEor8JE+OxWgl6QUxp/SQ0JuAa/04vPKCHZyuf
 ccPtXS2gkP2og7/vlTsrsm+B7K2kq/qH09one4tl9MgGFyETyX+xqRHuguCZi5E7vju7jj+KMj7
 SatZSZDtUyqqbhkgDS8wkhWfApVgtfE5r85/Be1PPSWJ7PKTXJpwv5smXZASxEpsk+NElNxV
X-Proofpoint-ORIG-GUID: jIJeMurgMDTs4jlClW7ej0tUpHMpav3c
X-Proofpoint-GUID: jIJeMurgMDTs4jlClW7ej0tUpHMpav3c
X-Authority-Analysis: v=2.4 cv=ZvrtK87G c=1 sm=1 tr=0 ts=680b77fc cx=c_pps
 a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=Hus2Nip8kLtf5UjimwgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
set via pcmc->pci_enabled.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ac9605c45d..c12e5423d1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -457,7 +457,7 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
     isa_bus = isa_bus_new(NULL, system_memory, system_io,
                             &error_abort);
@@ -478,7 +478,7 @@ static void pc_init_isa(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-- 
2.43.0


