Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F10CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu97-0003ta-BQ; Fri, 15 May 2026 11:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7i-00034o-2h
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7f-0006V3-7y
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:45 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64F9tGJN060220; Fri, 15 May 2026 08:06:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=RDJO2QynW/62U
 dpnV4Z00FkMvaMM+rFxU3IHwyTXApI=; b=Uf7P3UDsDDsk/dBnO6q+iRv9qWt3z
 s9XYTMnoBgkWWQWSNl8grOkQtAyUpkh54Y+yMSTmy14DSK0NWTj8/miXJgzYb5Be
 +NL/aSd8pG0RzN0J7SavfwcPk0CpNviSucSsBsxybj+Z6EwsjL6iCGmNzopqzdNp
 E7eb4khqgCpsy8kYuM30J/8KwSmnUIzUhoB+TWb6qYkAPnNeQ+OhzS1Zj+jJEFSG
 ivF3klhCGKt6WIoqeuaHYmvNUWbzorY9xJvS1ia2gIe1XMWxkC4pdFTwE2bw7xFc
 twpbQ0pn9KeZBlznJ6/GDpcKcSGuLskj52VTdjPPveEDc/a8+Q/acSjsw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023103.outbound.protection.outlook.com
 [40.93.196.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e5m22aa1k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 15 May 2026 08:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbXRVlseh0Yy+qBhJ6yV/Pfph61bLitr75zJnenc4gW59bveXTpoNZDBwBQCGj7pV/TwlLXkB29my6noYtHzD1Zaq7/JYGPthddNvGyD/VrBUc+LBhmBn3Npo3MW8465q4XFNyO6rpfEjlGqrbh2Rxf77Sdy5fvs0utunb6YkBtJupvfX4NmsZmuPQSGhU7+IPj+GAAK6UK8maomWwtnhV4yjAR+lmqQgA3nNqFRno9WJEpkGP4oCdZrL1qThFb+/0rSj2I9audhzWX3TxdR/t2wodx57RZDgsUm6D/FK7fM865hiuKUs8Y1LJxTjmu2wkK9GczCewBQBQvhg/UosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDJO2QynW/62UdpnV4Z00FkMvaMM+rFxU3IHwyTXApI=;
 b=a8Wq2/2EhvdrfgDRnIdnerTZoWSuMAEHgDl/66KMW3KV6rrp7pZeI17qy6FG/p80qlEvp6UmCtKMZKTPFOEdSxrZ/OIVBB1IFJGHw2eoEaABJEVBJYpJ67QgWnEIRvHyPzic+0iwDrEGfSKDiuxTJQu12lvsThcugX1vvpdNfmnMrCuGsp173CVdYhlVZtO/VQm6voNfE9ziEKKZLCGemg4vW8kzfcm7aCaAkvn88OMjZhINi0wD5B+8vT7TQXogZC/X9jkHkAf3m4y7qPr5buGKbh7Dn0GX3sWEuLH/k+huxdheC/Rn6U4K0pO+oXAYGftWEMihjWDwTHArove/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDJO2QynW/62UdpnV4Z00FkMvaMM+rFxU3IHwyTXApI=;
 b=sF4MAMTPNzxXOjFvan5tL91E53Dc7yLyDmUVG4i0iMJDedlhM2e5vs08ewYgN/sX9G/4u6Y1o44zxAWn0cRHMBOm1ONY/pbkkbHWzpmuDUC9oZHkWcDiTBwX908XvbAt9iqg7WtGNIA+DRPYVDYK/jdQ6c3RHCehCMKrJjqA3FZ4guRtLkLjTn09KyrZvncS8CauxkNzqAjGEJF6vV3U6vBKw6LbqOf6FFZRqpOvDtst4PwcperAkv3SalEBwRe5hbUPXTi/xwWn6yjEXXk/fxi4zr3oiMINnXedTRv8F0Gdg5Gqyg/kYII353mAOg+sfg5DNzgQ52kIXvZN08kWEg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6517.namprd02.prod.outlook.com (2603:10b6:a03:1dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 15:06:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:06:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] isa-serial: acpi: declare shared IRQs for COM1/3 and
 COM2/4
Date: Fri, 15 May 2026 16:05:43 +0100
Message-ID: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:930:4f::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad87bf1-9551-4617-e5f8-08deb2939018
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: EwTG+QnJPTaX8FKIumvu1rNVdRcTYNmjB8KU/7uv+4BlWhDIiDx2MeW3PjJYQDswBItbEnoPSQ9fdFDFXEzj+Y8goNEBAIIC62VDt4xjxWC7BijQBn4BOa2un4UkXltrpeSPQZ+X6EHBpI3q2V3hZHzPpGA47xHDX1MIxSvcm81Jf8Wm7x3OhKDaXFKuE0Qq3Qwdk90Sar/HwYojTP3LBH3yMFC+A2YcyBWoakbTLS2OxAk1/1zs+35zFkJUdB0DXy18XO3qb+lQOSO4OVPUbV7PCwnVm3TPTCXgKI45D+5mCMy389My+0dsFBCbH3AAUxfygIzglpFT3xKaly8O/JSvj9YwWhMtFCIZOiJtfZGDHuOVial/2046fMjwC7LJGWcd1X/4F00tdGNlwT0KSS+WYdT1tj8KWum6xtEOb2KkjfOzOd767xFHlYzlCzhhKOPU1R1fx3VBKJrhl6MX7WyF2wodGmMejdjY3mj1VbQ88dXyMbIx8BQPj+iNiQ8xZh/XWXUuVsAVB8egiaUGPT4NSbvJ8XGBz2So7GTt0bSsImgw0ljzfdh+AEfCmECqznA1Yue15PEaYZbt/0de1M0dgXHVvup+yIGdRmNfQBhE5nC5qP2fBGAQ8foSw9N2gEd8j7cEzQ5/PwB7dQwdEbf0wFUwBxjR01nahS53MEHMKN5v7dgVhS9tSKGParKB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sl6Sd8sjYWj5kATkx9DU9/e+xZ0oo/TrHGv1oV7Y1qQVjP1nsnDxyioB0WdS?=
 =?us-ascii?Q?oJM+LSxHLfFqe08hFCes+JqALLsuZKe8pJ5+pfiWftd4R5iqPYpF88ueTt6g?=
 =?us-ascii?Q?OV6zjQc35X1Jtmn7RdSNuXWBJQD7oTe1Gz+4K2aE3lpETR4LoaJzTiEbpYlo?=
 =?us-ascii?Q?U0qnRxbTdvD/ZVDmgCsdl9dWVX2263GapqfvKHL0M+YCyLdlAeomumXfSJq9?=
 =?us-ascii?Q?VLvcMujtceu5CB67QUg7XHwktP13AaGEnGormAYcAH8hOSqzw3Ku20kncIFv?=
 =?us-ascii?Q?BEd6q8hyQWZYGzX4dKX+lUdJLDjwEhy2ONBGOxX9FxxvY1sjK8cGfdG4gcht?=
 =?us-ascii?Q?GyB5hvUnhzcV4W/NR+d1rxppjVdqjYHb3pww8hxKJNHbuqcafnXhgiB1znMe?=
 =?us-ascii?Q?jk3iwd3dKQ97sbJ41pkHhnhhRuskr+3H6Ac9wu8ITuTW5hs8RRY6m0xRlTBj?=
 =?us-ascii?Q?yc3sV+/LWnMztw07/etWg6xEXfSvaq0yWTxvupenBD7E6LQwJyYFDMOkLEy4?=
 =?us-ascii?Q?EDL4Ow042JK8jOEBwEApo7tkan3fKG4QWDOvzPGZICS70lqEsSVU/XPOfICO?=
 =?us-ascii?Q?B+sA+cxs+5mKvGOYuDBzebv2AFr0CzbknxCJY9bs/5IclCZfU0MeBvhjjTa9?=
 =?us-ascii?Q?9BpXdxKw+HeYZXnAHEA9fmcP2lHbBScOywZ77Vv67yvhrADO2TfylGXSLiSX?=
 =?us-ascii?Q?wwNGVcZB0avqAF8H8k2CPbZEG0tp0aqruhanstNLZ6hnG+vJ0F5YsfCHHLZE?=
 =?us-ascii?Q?4nv/R8awl956nM7jcKYtMfqhkwofZGVNl4oBwqhr8uUAJTHXbbi+zwEH34MN?=
 =?us-ascii?Q?xZurMJgv4W2QU4syVv6KH4kLVhs4ZKirpalF25FIb6M34jxin95P82pzMQrS?=
 =?us-ascii?Q?n8oq3kqMqk2u055iaG/h49ULsLbsrm1eFp9FoMH3aw1yfJ1esPRVKVcgpaEQ?=
 =?us-ascii?Q?n2kAIdZytMnH9l37ZDzgtWbdRcdhJxF1d8SfyhuRj5In0a9wDFYj+eE6OMPu?=
 =?us-ascii?Q?S/nHOrpUQxObq2ERNl7LmPtT5CaQS94m6Hx3cwoozQ/3MAIOWM9gfPlT2/wq?=
 =?us-ascii?Q?5lsh1Z+vIoeK2ce8qvhKr+icUxDrh7x45iTMEf3vEzGF4i8l05HG3RniA3k4?=
 =?us-ascii?Q?jmuN7BMvceU/v9xvakARvMnG05cASkML1r07w5CL96BYc/mJ5w4T0rzUGX4c?=
 =?us-ascii?Q?XgN9nrjtZi0L7yaMYSyOLQiWrl+/LYOwfeEmkhAu6VJZl6MOkTFciCQDIM8y?=
 =?us-ascii?Q?tRv6rkpeeH6FyqTbjOry+j8HuK73gnGYCa2JRZQbZRF8SjbyjmfeSOh9ldpe?=
 =?us-ascii?Q?ckV4LQGVgtjJAIzrmb+KHkZn+U/UweW9STLQX80Nin7iImpRl6WMNmlW5BW8?=
 =?us-ascii?Q?43orDm0WmtkEabV/zkgVihj7Oajml0Vt8ePtldsWy1QpRngltirPrlDkCI2Z?=
 =?us-ascii?Q?Ho8b/b+WN6JRKVDrN2lxWkkFbG5e9DD4Y29aJcVIO3bKEuYzsUmSbSaXyqbu?=
 =?us-ascii?Q?AkyeYr3b2rX76HTi5uEiv0APJM5XM1+HKCRHd0JO40SG8bDvm/E83XlSd1Sg?=
 =?us-ascii?Q?kva2Dh9a+YwGTXkPtvOcHG0f+i717IAHuXzTLqvW4Iunsggm7hy4XvoxvD/R?=
 =?us-ascii?Q?T+m0506CnDzQkzDMojnTpNnHe5w9mm98JvNPhW5jj3JOW3Jc++HSS3Ip5sjW?=
 =?us-ascii?Q?1ay4WQPJss7ZRmXNRJfEoXYN6UkgITfpiPrWOgFvr6xN0QbexU8iPbKbVP0Y?=
 =?us-ascii?Q?s+ldsz0tTXuQ5ysTRuxJbtADymKBYXM=3D?=
X-Exchange-RoutingPolicyChecked: JlA1a1eqjKExuwsLNSW+sT/sfHF9UyTIJ07dWoqWqWCIsa+tvToT4yMGpg40tPbT3de2FLNOZFkeeRsi0otDfaS5HotWF2zOCWhyYKFHTvYyisdPxZIMbMBhfUSc4m0aD23eLk+ftk4g/pot8F588ojZAvTHSAZTuhjsrd/p4zmKTSO6YS2XAhY0wbCo2Fq94xajOlMjTQID+uPvHmAI04+UXwjA+1jQo5riBusjH8HDB71CuMOGJIUPab2l2qy4W+dpDSiEhnxB0URiNbKOOCzd304kEQWfO9j3t8o7tRdD6Zzz/yIHf8fkKE7JDMNxykJjPpjLf64Wsh9/rsid9Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad87bf1-9551-4617-e5f8-08deb2939018
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:06:38.3526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCJlrxfp3/1+nc5IJrDG3AL2kLWcDMkqF0OEdQrs2g7meX9PHfM5URr+VgGPikww8R+IoDNBhoZyJB9bwxJGwjXKqYOHvoLX3cNRFKIeZEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6517
X-Authority-Analysis: v=2.4 cv=Eff4hvmC c=1 sm=1 tr=0 ts=6a073680 cx=c_pps
 a=wzqVpK3G+266qiwA4JElng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=dIqIAbhPDsXyzGsJtssA:9
X-Proofpoint-ORIG-GUID: i6c_pGYn1SLQb-Cf4Lb6xRVE64nmUseQ
X-Proofpoint-GUID: i6c_pGYn1SLQb-Cf4Lb6xRVE64nmUseQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1NCBTYWx0ZWRfX7dVG2c/3BI/K
 mtxGLQSWa3Blu1COV1eN7KwhX4MDDe01qrjsJKBW9gO7oQqHEHijtfRgPeJh9iOx/kIFY3ZMG+P
 s04zTjHWujGXNNbJmX80g1N2x7vO5+txbmY3BVrWyb+zm+93NTZoZnVcQL/0Kl+5zhJFWOvyBaq
 3wCGHVMQY8YkfTSlKI0H0uX4+yoEF6+K/E/DELknSd7uYX5dctALIAQQBy4nnqDPiv55sFgSi+T
 oWM+U64wIeYSsN5QeB1w0FFAcb2LVd/GybTHfO4Dy9X25SfHi/y6UswKj3Hukyv8y96TyRf2gtC
 /dYZTNPJD9DcYnGW67F6H0KV1MlSTpFU6s53jKludPT4QxurrTIw09CpOMcLR+unhkU9OwnEJHH
 64ME+tChI/QweUwdten18S5JjWtw4WGE60X4D9ktE9VgxxNhstORG7A/dz4eI2M7cJuQG7ydQtK
 6861nt/5Mrm2dKiEI4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
ISA serial IRQ is low true, level sensitive and shareable. This enables all 4
legacy serial ports to be used in Windows without conflict.

Tested on Windows 8.1 and Windows 11 with 4 instances of -serial on the command
line and copying data simultaneously across serial ports COM1/3 and COM2/4:

  ./build/qemu-system-x86_64 \
    -accel kvm \
    -M q35,hpet=off \
    -m 4G \
    -cpu host \
    -drive file=win81.iso,format=raw,if=ide,bus=2,unit=0,media=cdrom \
    -drive file=win81.qcow2,format=qcow2,if=ide,bus=0,unit=0 \
    -device VGA \
    -serial tcp::4001,server=on,wait=off \
    -serial tcp::4002,server=on,wait=off \
    -serial tcp::4003,server=on,wait=off \
    -serial tcp::4004,server=on,wait=off

Note that with this series applied, if extra ISA serial ports are added to an
existing VM then it is necessary to go to Device Manager, select "Add legacy
hardware" from the "Action" menu, and then reboot the VM for the serial ports
to be detected correctly without Device Manager indicating a conflict.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

v4
- Rebase onto master
- Redefine IRQ as Active-Low-Level-Triggered as otherwise Windows 8.1 will detect the
  serial ports but mark them as having a resource conflict. Retested again on both
  Windows 8.1 and Windows 11
- Add R-b and A-b tags from Ani and Igor

v3
- Rebase onto master
- Define IRQ as Active-High-Edge-Triggered (as seen by the PIC) to ensure compliance
  with the ACPI specification section 6.4.2.1.

v2
- Remove _PRS changes (including AML build changes that are no longer required)
  and compatibility property as suggested by Igor


Mark Cave-Ayland (4):
  hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ
    descriptor
  tests/acpi: allow DSDT acpi table changes
  hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
  tests: data: update x86 ACPI tables

 include/hw/acpi/aml-build.h                   |   2 ++
 hw/acpi/aml-build-stub.c                      |   6 ++++
 hw/acpi/aml-build.c                           |  27 ++++++++++++++++++
 hw/char/serial-isa.c                          |   3 +-
 tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
 tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
 51 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0


