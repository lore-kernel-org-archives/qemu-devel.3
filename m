Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C180C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HdL-0008Ka-DH; Fri, 25 Apr 2025 07:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdI-0008K2-UQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdG-0000Nl-4C
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:16 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PBcALd013017;
 Fri, 25 Apr 2025 04:54:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=X4LWASqR64OkO
 tF1g3mLxYS+Eh/HA6HQNImZ/gSeDWo=; b=WnpBuf98cyH0x+JpATSRrNVKHtKxy
 AQVWJSSAEL1ge1Z1S5BlrEdsejZfJ5Gxd9QjXhlRLzP0IynDxxWPYTB6HzLxMihh
 jpHNZsr3RLKU/dZrYXST3RT3Wr8bT9eh+nioqZoxMcSuEA2xNkyyeBrGfRU83JBa
 H21ZJaf8RJp1eZC5aMlrjIOKdY6lBbef9Re+TiBUJiMkwjPrlihpusOyKloJjVVj
 HzCMgrjGIkn7vkYNKevDHT2mV4sT4V4mETDV+OFO83yJWwZ/1ZLqonwvC0eawChr
 3U0JlKr6EEssdnv4FSXiX8Zzb9LBsrQUTngQ8hoIlnSC+5nDcia8PDtUA==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011026.outbound.protection.outlook.com [40.93.6.26])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww21b8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkpydpgoIYiQzvhmPBlMVBcsCgy8N/fRDdLgGb3HKEvQlxn8i6qHokLJ32xbdzbM7i0lj59HBUVTLHrVcbNKDqJ1uZM4SFj+vaMNk2rZhYv98/ao+3jyHZECu5+uORd31M6YBlp7Y2BeJlgubl744A3IonYChICvxRt8OC5EOx5EnNOFmqx+Hq+1T7ieP1XORpabBm7KmggYlvVORK8dspHARgYGlC2NDkZhKyIVAjrBQkEyZk9R+vEIKGYz7gLf7qTqCuUa/IO7Qr3ehzdwY5btsZ1slShKUAziD+gRho3K9mnS2PIKqiRdv6Q1V86rnGgUFlusQvs60PacjVxiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4LWASqR64OkOtF1g3mLxYS+Eh/HA6HQNImZ/gSeDWo=;
 b=SpN+AdsbxyUVc+vnfkMpUm7CBDmsdGXSZmcmnpoiVhqiPibIKy+V8ab67jHcxtoC8GmEkuRvbRbEZmc50iDjG4WUlVAg/+W0C7BC4Xi6nd+y+8QBwvx252VJiMsh6vWNDGRXA/nrkNiOTYqlWJ2MqY03ivmrHz1JxGIx38eumdU4pzyoXrMvgfhX6wnlXNaerOAnCFc4t1tRqG4DaxwbsjTGDPJ9/CWWnOaD+AIavxtMkl4EpJB5c1bubJntpWIJs3JTnykuPqDlGXvzj/vidWncLJVeqXF0bfgnlsQl9Vuo9caWZSA5O3kApvaR16B/+8gODhW7HsPMKLj3SNuZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4LWASqR64OkOtF1g3mLxYS+Eh/HA6HQNImZ/gSeDWo=;
 b=pMepvL3Klt31e6avdR3e92adL3aVbCbseI/YOjhsNZ0OuL2zfwtcfCRelLWeqZJsmsjDQ77u9Zt+cyj3jiRfgUPMBJVfCjURgXp+cFQufV6Af8CbuIXvd0BB01yWBjucK/lvKWdW12ze3TsHFJEM3knaY+f9U/GmuUfQIgMlLxMpnnVnhVhNq2Cg4aZZ4pOnTd7dKqDJwZfzActfeqxEjdT/Jk6nx2wbjVazIjnOj9wgODsZr3QdRAOaQhDXFaqZ9gQ5fJJ+QMkMm6oRmp0kXHWd/X14c3Lhd1YyHh1oc/66reROWBXHBWaSzwtBiZEnj4Qyaqyg2L1cJ49oDmg2/Q==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:04 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 00/12] hw/i386: separate isapc out from pc_piix
Date: Fri, 25 Apr 2025 12:37:47 +0100
Message-ID: <20250425115401.59417-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0136.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::41) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: c357d8ff-4665-4a58-77cf-08dd83efdffd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xDqM19C6aIE+M6vTOgGV258tHr4CMte3ZEZrcDgOZDbklPA4UMXQBYFuUSQ4?=
 =?us-ascii?Q?qjaZnGxS1LU4uqmee5ts8g/NH18bT5LzqjAJJvozXO32t6lKOXEC6ZoIB3Tc?=
 =?us-ascii?Q?ygrCOku1Z4qWfSD6XDSFqpypzVqyFMqACwzOWz+DAzLkbLHJLrWIkZCJGcGT?=
 =?us-ascii?Q?9NXtQCKASgv4HcYMOpUVmKoPIfveGKKmg1h0sQ8T9mCH0/yCR3J5q0/HnEvT?=
 =?us-ascii?Q?G23wFekbWue72A3sJ7TRU1FX/Q18Xfb4g51/0Xay5ODmq0tEbZzZvOa6GkXD?=
 =?us-ascii?Q?irLYW7AlB4q0kQNNZzKhyZsALPXj8NZF+b4OQT0HdJvo0g57vG9Is1Kst5eP?=
 =?us-ascii?Q?Q7DP9wwHPslzy779L/IFxhcD2BrLEALz7Bk05lmjVrsFcr2D5KdZhQQdQ3fX?=
 =?us-ascii?Q?UzUzonUoW7O9fvewK12qlsamu6GSGRMKBTUT8bQrK6izASB0UzmmKDM+3P/H?=
 =?us-ascii?Q?GJgxH96kR4O9PbKObo4eqq4u66/DTw8R9+Y0hjWQoYOU7bSeQRyIax2zTkb6?=
 =?us-ascii?Q?z/11Up7cPByR0VIGRIokGHE5BdFCB5SH11+OE062p+VZZ39TKQAj7+2RV+JF?=
 =?us-ascii?Q?9HWdv/a96YSKv+2kYbunwLFQ3zrOcZm+Jzgc4XHKiYPiRmhOCQ6XDM/sdZ5N?=
 =?us-ascii?Q?F1XPe6ux/dvfBgvZ3F7YrfWocdzoX0Ryimohbhl9TpxDZ/QXcNBEAUpU1VQt?=
 =?us-ascii?Q?TzksfDgKZ+wTnisswMRcM3b6BpcYMJh8HU/jSL/cDllcp//342L74XRnHk2a?=
 =?us-ascii?Q?c+tH91xZanrw1sL9DLSNVnFRN96D8UmRWwGxeiqeMZAKO4r2SQ/jw2N1/nR7?=
 =?us-ascii?Q?GM6BSoAeXQTD6ACCPSHC9gWM4KF8Vpu3Rh1XoNBV6/61yxuEGYuWH2xBesAs?=
 =?us-ascii?Q?24TDqAj/3TAzPoEyIYHFHutloMSZRnTGHcZg4mYkEYc2eQbj34JdgOew4uM6?=
 =?us-ascii?Q?6JdGp0HECHW8XJTydGV6Kvaf2K33sLrw57cJlnzhALBOHXVpMG9iG6d/PZ1P?=
 =?us-ascii?Q?jrWiYf25Pcj1RjzZp0XI8/zOlTYZyCyWqxqcZm7k2/UNRK7Sy507jRZCEXPj?=
 =?us-ascii?Q?Pc3kt4Upr8tiBMt/27b4Ss3E55FXEI2yoaCv+8xwkh0D026EhS9xZ2c1msiM?=
 =?us-ascii?Q?CBn/Qoeip2HNMXVkhf//LtXialsUsDkxc/2W7FMRJfSC5A3LAl2f0NAg48IN?=
 =?us-ascii?Q?WD0PIMOjXaq0Y1LwtSM9DWiVH7xLRgdSQZB1f2Gz35JxYVEh6txKLYhn0Jsw?=
 =?us-ascii?Q?/zV9IhpLaAi+Moe7OZB723wbUuvTniS54IY4yFf4e7qRbOIze07Dot9HbYiY?=
 =?us-ascii?Q?BS/IokQmIrQutAwl5iGvXOniJJ8cRm0kgdK2CPiIl+QP8GoiNzboMh91mLfn?=
 =?us-ascii?Q?PFqBVBygILYOqhVhnwdZkZywu0hAkQXL1COPdI6VkwqZiElYKuY43CTaWGNQ?=
 =?us-ascii?Q?kKrP40ySjA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zJLA2AmCOE9+sHgR54ME7YYWcD7uPGe1/ruaJSjolCoLVPHegGamYqjQ3CZ6?=
 =?us-ascii?Q?24VGkTdURhRJIdNz/f/XXo22HCwVczg8okW657sFzrwGnjVq/WG6uLZcR+SU?=
 =?us-ascii?Q?82Qv9XTZKKtYE6HTlA8oKNDsqc+R9ZuQ2d4cH3YTp59aoC2kiQ4qT+s3D9JP?=
 =?us-ascii?Q?phXgQmZxTzSTns3EYHBGdMnk7tbDQkSjDLnqu5aCE0QozUbw1E9jTvXYtkOa?=
 =?us-ascii?Q?V0dJEqh2trJBJzultHI8JzbXiuvnp+DHpvuICbErZr/vZH3RI04skqVZEO3B?=
 =?us-ascii?Q?COj32t9GIb8lX11zlkvxUXs/2ZDIFuPG4E+Nt7SvdhWwjYHFjHZ0UrQE0jq+?=
 =?us-ascii?Q?hX30hL7Rm7dEkB4lCGZ7AMAxoOyq/hPL/M0rhC9sBQ9Z7g4qYxW0wdVmUdNB?=
 =?us-ascii?Q?/i0BOz4hREw7dXlf31AFYVAG/PWaX7GbAUnNwsQHBmm3yz6PONK15x+Srz+K?=
 =?us-ascii?Q?uKKnbQScEWPv+FiRYj0Oqepvsd8j4yFs+Pa+0s91kea1aM1ZshlABFaUPBRV?=
 =?us-ascii?Q?MdRsWIvLyNZgBwSZSz3AWZBV6nM7RI8HVSZ+R4dGrbNrqmIEpwImEfdcUvD3?=
 =?us-ascii?Q?b8JFvVTJhxcN6G8hYqsGW4mSY+AJjC3opccko8BJ/Xd0xHT/TS+GWntIuKwI?=
 =?us-ascii?Q?VgE9SWbrtEOLA2/dPPCbuPqGUVEH/PhLpJwOKA6l4ECslZ6TBLQZDWoKgHC8?=
 =?us-ascii?Q?TbvGVlCu6NGBPxehpNtlbX8xigg1rARCUjbB7XIGUQvBODmN64WrrNzf64S2?=
 =?us-ascii?Q?GkDqUEmDv/XmF5jXr/gfc4epaDSEdoCw6c74K+QD4eK8rig0X6SmQ+d+nXj2?=
 =?us-ascii?Q?abI+cNs1Yt91jKGoKOfsFfibU2M1qT02tucan3anB/oIIxdkePn26vXpemxF?=
 =?us-ascii?Q?OEkdDTzL5+LzFZ39H/XYoiS8QjEER9juYDv26woi+fvEjroSRusOda0qhhRH?=
 =?us-ascii?Q?hRXqzbAVeGQewuohp4FgqVLOzSvUFpORtfeyYqHv19hzilPjN0giWhV1gQjX?=
 =?us-ascii?Q?B1wrvpCU0smn7huPnJh2sFCszE2mLtbItYWJkGm3ZuksV+F0RkpSaozKFsE/?=
 =?us-ascii?Q?39QDqq0jpvJu0CWFX8v8RuvsZyFGzjJTz+Ta/bCaR5fLQaTHwW6rTdZEuSSp?=
 =?us-ascii?Q?p9uIOg+B49RZewW5YAYQjzekyhzAmZzxlQKL4dAcZmmHYoCIW3OGDc1PEWGE?=
 =?us-ascii?Q?BIEqgite4xt1gV5tqmMjg+1Lv7baxIWpphKrmljJ5GvNgtX1g8qCiAPqswdB?=
 =?us-ascii?Q?nNW2ZR+58G0ATseC+OcbmD9I/7NMyDPFu66mhBwVJiX/53A5vXu/0Ocjasfz?=
 =?us-ascii?Q?18F5fktW79F9zO6wDWp5zw2aEFXWIOCSBXtDaOGvM1ovVN1QJDHO6gs0GZ+p?=
 =?us-ascii?Q?hjzVH+YwjMs+uR/ERbLiwrAaaFiMJTieqC0sWDcMjCjdVhnsEfCKLArazMEL?=
 =?us-ascii?Q?E8S+N4PwNCpft2zLGzMGu9FtpA07rgzXlv4NoX30m9v3B5KAsfhYCoQqh2Wt?=
 =?us-ascii?Q?jbC5Oin3MDG25nQ76idrMaqynZrQN64mz9O2HuIcAo23Z9x44Dnx3h9gOKdF?=
 =?us-ascii?Q?fDROBpfp7BGWuvmclmFo2qmOrJwuRI/iCDXxAxc4SUAK7V1piRXenVTGYy/F?=
 =?us-ascii?Q?9KW3q/Nwj55nO9W9p/oRUSbFRXqskh8Sj7AJuHS8j0FYLU7+fxkAe1Vi4qkl?=
 =?us-ascii?Q?wHxWbQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c357d8ff-4665-4a58-77cf-08dd83efdffd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:03.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzgNe/VR8kNbTxqxyUsinNe72mP0oCrYHz0WZTmzEfQoPUAnpO44Ab/oJaN/hmjbH1whzkg25sachoQvpgCNq7XQrXn7hPLYknSk3iIjSGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Authority-Analysis: v=2.4 cv=BevY0qt2 c=1 sm=1 tr=0 ts=680b77de cx=c_pps
 a=n6yBKV75teYx4ZnYo0pt6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8 a=HgjrFz65ADS2BQVEIScA:9
 a=Y4I1g1QRc_YA:10
X-Proofpoint-GUID: Fau91caPdl0V0W-RttbKpC30a7bYM4UM
X-Proofpoint-ORIG-GUID: Fau91caPdl0V0W-RttbKpC30a7bYM4UM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfXxSEl1dMPPci2
 VDX/TDfEnzoWsATruYS5Lgg69sk0zJ2fJkagYe53EaC2Mn+p2Rtzk9u9kKIkQnHqJWtSfhkKK0D
 wolaPLLnlVlH6TN++az3X1q96ys41ddOKlpoBTyx1LQFlw5rMyo45S05LBH6vdgArz+ivVwFspe
 Q2IjyXEnAj1JSflKNGsS5CZacKFglMtW8zbgquEJO78ZoJFnKx+zN1y7ZJ7lyCOWr1uv8rt2mSy
 UhFApkV4ZsnctOD5AeFAiupHhZDLbphSvNZXhhSoECrASikQ3/KlpI1Gkp9NbzpLd3Flgei/JQM
 EQAUB5W/Q1KhplpDBFHEBoNP46dJxVvjZazJ5gkP66jKKzP29G0GFXKzEKA02fZc9ARBS71z9iO
 NbzblD4Y731gOc6GqUkhPCGj9FbGSqFAHQUzTfZhlrhY/SQVNNL0QPJCbXNYZSV9mcb+FYp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

For various historical reasons the initialisation of the isapc machine is closely
intertwined with the initialisation of the pc machine, which is preventing some
future improvements to the pc machine initialisation logic.

Since the consensus [1] was that the isapc is still useful for testing and running
older OSs, this series splits the isapc machine and its main initialisation
routine pc_init_isa() into a separate isapc.c file to reduce the maintenance
burden on pc machine developers.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg06137.html


Mark Cave-Ayland (12):
  hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
  hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation
    from pc_init_isa()
  hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from
    pc_init_isa()
  hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
  hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
  hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from
    pc_init_isa()
  hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always false in
    pc_init_isa()
  hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in pc_init_isa()
  hw/i386: move isapc machine to separate isapc.c file

 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 156 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   |  31 ---------
 4 files changed, 157 insertions(+), 34 deletions(-)
 create mode 100644 hw/i386/isapc.c

-- 
2.43.0


