Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4724FCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIIe-0007Dw-Tn; Fri, 08 May 2026 06:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIId-0007D6-Rp
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIIb-0006k2-Vs
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:15 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6489AH8B2974000; Fri, 8 May 2026 03:19:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=61mvyNQDi40pCaSs5mn4L7IU0dWLtQS5BozSEOK1O
 Ag=; b=yNwpsFI+Xlvtda7WbTwUB5he1oxKCZcWy4bnq5Xuff9+fNr0EWDk53i/c
 UUr0cUEYuyPxSrJM5Gn2e6CD8wrz7hX9UqdQO/bshFJyVg9aYoG2Qz4V60vwBW6h
 a5WSfZtS3LDXkpKbO5LRmqzVEnVBt8l6EL8OVvpNawrslYsw6zJr1+X9U75kJAmy
 Q3QzyHBF8O+jwjKRv5edngD/61jn5i5bWoQ1hfkbRT8utlMJTQcI3yky1XZQvDHO
 hgdQyX/HrDMpMaN5rw0JI8Njn+pWIhqy/rf08iaWthdR6F5Bt0kUzi+ugMwXf6je
 6P4QEvtodd2oe3YHvXGnj19uFpY0Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021079.outbound.protection.outlook.com [52.101.52.79])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e11mc9jcc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 03:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMO/r+8jM9anCPNwscZyfGvHd4PJ0EEzwEe7WXtEnQVYNuY7DbcMLXcXd9/P/9wWtqsfFSIqvudlKBUn0ggm1kghD/4t9M0serdZgGuFO7LdoyFjT6MxtqJM7ULOkvReVHKOdUnGsPV5HcrRjU2sY+5Jy9qG7vFA+ZP2rNurBdw9UlfiW9y51GASDD5U7WFegnfvW51yB4JX8vOJbntEoYdDORS6olBj2C5UTZS3UoMKv36WAtQ1Fl+7Dcb9UINtSU/LTdIA5BWNnjR4ozupi0GR+Sp3YiH3HwEK5G/ZwZQqcooEshj6M+Ft40FPum5Gci0TjB62NZaQ01PYOrq1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61mvyNQDi40pCaSs5mn4L7IU0dWLtQS5BozSEOK1OAg=;
 b=QxZ6Nyab3yri30m12SYeJN5YVunL9qkbFlt7ZPtOcFprlYuaRYoDeWpDl+xCcamsVAVt5qlTrseyLjEw/hs7FXwEVAnkloJI7Pf3a/lMpQThwyBJmoNTb24dWCV9ioJlKWJs33y133NP2Lxwuq+DNicBEJB16dQbgwxLz4tE5jgo4Ez3jdrrEQrE7U8xrJbz2EZOho3r7RbD9ToH0jN00Gc/bUitrQWINGq4LDUxtASAXuoqLvEN9G3AC2/dxoSvRbWtSLjHdttq+QR1fSHl4L9RWcJ+xF2d0d5GsW0AuJadquw5dStlCjkcUOy1oU+sbBIfTd3HykcKEKWhsqUcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61mvyNQDi40pCaSs5mn4L7IU0dWLtQS5BozSEOK1OAg=;
 b=OFoqtVDAZNxJxZNbq3szUeHUAIQO/U/jLvnxsM2wgWUSsA952KBM90SaNMBZKyFTBO0gAusn3w6ut9LH4g7RfONYOkZNRNHYbr/kR5fHUow8K4N7zRcfYt/YBcwbaiKnWFfN//7TCcpZDIISBFgg++5+OLXG67cuM9ckHsoB9QMqnxCl0hBIgnobW+QcuZT9wWIlk9m+A6b1R5a8z7CUXwVDUBqLbFZWm15eod7IAbpI82G1k+TetGc1oqnCBJyAhKMncuHkhmHarj3XCxiczYbTrS9yVHu17h4qKXIBkl8AO6TjyfjUF+GGLwlg/zsGZGfeoiHPfzJn+BickWRhcQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV3PR02MB10763.namprd02.prod.outlook.com (2603:10b6:408:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 10:19:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:19:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] hw/acpi/aml-build.c: add aml_irq() representing the
 3-byte IRQ descriptor
Date: Fri,  8 May 2026 11:17:40 +0100
Message-ID: <20260508101901.930781-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508101901.930781-1-mark.caveayland@nutanix.com>
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV3PR02MB10763:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1c5641-3200-4b05-ab6e-08deaceb3e8b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 9NgpstMVfmbsIC/a64psUnxUld3XPy/omEUotSrpMcz8a3pOI02qUNUcYvSqlaxhXXJsJUUH0AB0KwMiNpKq+NurouZ5ibBqWjZPk3yWWjabWASkDBHFsToU/ipyM7nN3ok+/cao/cySOEih3Ac45Ydq6HO2cbx8cRERXlsuBDBtwKvrBolU+s06qCMFcFxriOOGceElz7oToi9XYcOe81lyous9tnG6wDApgRROLYMZylRu5doc69xu1YVFnmmSUUVJqz+/fyknn98MbbiU/8lfPRCz/x0VZ0Ap7qkxW7rxPJQvjdaTZTSPbr48o6c6ePGlWqjCNxRjmJZjsOMC9FJ8wq81bk93zD9Sd6vlaUJu5ktjwFDKPxVzzN2VfPCThar4V+TCVnKTwyJbKgUaO5i1gaO8xs/GlW+2OZZ+xZObRUUqP4LUMdKuQrJbDMUjWwmKNkah/iR4/dbsBhejYBMANz8w9XO72pqm5INkRM5eFRgr8W8mjJXrhH29w3ykbEhk2m8VN8ktLhtI1QHHzWRvLNkDwbBCSnghCQt5rK0iHDxxHRkBTSDuWIXCLkr3xGkdI7RC//ocFDHBYiCLQJytbgnRXYrs5VRKCqPbgVUSkb7H31gZqI3ronrNXnT3rrEiQR1jTHe0mklstQ5qx5DtrRfFeiANhqka6bG2P4Qn/d3L2K56IccJGK4ln8v0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvvA9xDrPbdb3bAqw8jbj+7BuyuMpLuCCIIfTqp5V/JFKjy2PfWqC7OPuupx?=
 =?us-ascii?Q?yP+rS+hiRSGpfFaLRouyUd+L2fejx0M55WnBDfWqurZf8z6/Hxi65Eg2vOfC?=
 =?us-ascii?Q?U3cm7stRzVY866QX78j20WkpbixbzY1saR8tkABaCd0WcZYdLIzOubQDPZkQ?=
 =?us-ascii?Q?6p+7OYP/QH3uSbXxzdik5VE1F+KfgjOBQJfhBbk5e942bhk0b6rZOwkjM9tz?=
 =?us-ascii?Q?0UaI5J33vev7nHkisenCInfRRnYNhtSFVAzAKPYi2RYoHi5N41Yy8a0WoXF6?=
 =?us-ascii?Q?PGOcF1C4uljHf6At1EPMfWMj9Fw5ljorsyEmHF6o1wzS9zNw6zsGj2co3NKK?=
 =?us-ascii?Q?Km3e17Sm9RtbJX1fUdpg+TgqScEyTP6laiJGr45jDwh7dTyDWp26VL+bMR0b?=
 =?us-ascii?Q?1hu81PSoC2m5rxFG5n09s8BAwkkUhT2d2at0g+A7kJVHZUFGFI3IKX86DrU/?=
 =?us-ascii?Q?d+wFb36PoATNjrTG3oiReNmDOIlyjSAtJ74rar4P0wxLeqi6Zc95PYN+unxg?=
 =?us-ascii?Q?ivpQaKr+JHax7lxTnwcNDqv4tZ7AripGF9Z7/IyDcJvb8IRc9Ck9qF6qvCSY?=
 =?us-ascii?Q?f+85Zy6IMqWbiSdN0Gm0gEKs12M7voVQUQ3x8o73EVpZci7YJL+gcy6y4Vbr?=
 =?us-ascii?Q?vmIsWYjxcUnPqG4L4OHiTaV+TfBPxaWB0T88yRtkivVQIR3DM5IBMr4KkZl5?=
 =?us-ascii?Q?k/yAe5AKlynpcV5/Takcmh1CfVA1yUc7SfwnolQlkYCb61mFakKonTjhOuSw?=
 =?us-ascii?Q?WwSiEz25QiUoU+QwnvoBciG+IY7d6G3JIRtfmex/vYaSoRrmbPonXCZl8G3m?=
 =?us-ascii?Q?9xufTqUju4m/gzOYg6M82o0ThUq0b+ohH5zA+D4/TFWjBroPbV3jItFCk2dm?=
 =?us-ascii?Q?Xt0HK7/Xlb9SMQwQbtjwfa4pXDayesdObVIiGZqI97+u9oT2cF51l3MwTiQv?=
 =?us-ascii?Q?QAqGLn9e7EIMjdQOhrSbFdQ3ME6HJC7VZzl6jDbV4InUWKVizA4jzh/K2+6h?=
 =?us-ascii?Q?VnlehQ8TlrVDGPm302uvj95XvbG0nSO7sKCS94e6tT69LHNwvgCCHzo+1RT6?=
 =?us-ascii?Q?sjhBbC/BzsNWfxEsdL+AtXR3uN6vZcYe9d2CPIAXmxvUESfWhB8rP4Txzals?=
 =?us-ascii?Q?UoZELj00pSLdAJyk8RInZFFIrNfJSj2IGi5LgYNrReMA4+MicXbiT98Urc77?=
 =?us-ascii?Q?xTmMS6cp/ZdMbNSnm3ZUfhfKRURzPxJA1h2+NpDIo9oNvrYLsNdw4TCqvbJL?=
 =?us-ascii?Q?dm0BNfI0xDZrnCdBeUu1G+BaMayGp0dP9CNQZ22l4j4lrqFOzFU37emGBkK4?=
 =?us-ascii?Q?+iPCPc54DJCBDp/nI1KwZkBbVHSL055pf+jg0P8UuryFVwLIBSO3St8dplE9?=
 =?us-ascii?Q?APSJadysNlnyzn02REHIqD/KKCeoqMADlZC1BWtWDCvbwTFFr+nCMZDKMIfL?=
 =?us-ascii?Q?p1sKH0rFsK0axnLcNPvZLchCQTNxgUuyNM6F5NSqBBuwmHZzJcHxPKSBYp8o?=
 =?us-ascii?Q?H1b/R/8ZybFDr2pSyi2UBUU18lq/7DeZza3pVobK7HWl3NeIfi1Mykhsrsvx?=
 =?us-ascii?Q?hWq13KlFU8uIMcPZ5WkHMJtdjD8s4ycJcOj0cW3GAXKiBKBIpJ4ZAb0UlFAm?=
 =?us-ascii?Q?YnpMWYseTqwSgDxgZiB+WO/EpLijnH4vJF/BXFLa94bNC+qkaCci+CiUmhdO?=
 =?us-ascii?Q?qtylIf9yfJEZLAVax8ANxw9laMO+d8cXJbp2G9+peykfpsmNIHSHLWOYdbxr?=
 =?us-ascii?Q?moCg+UhbMg1/aut5CNLiQUI9+qB7KqA=3D?=
X-Exchange-RoutingPolicyChecked: YyiWWZJT1iLizjF3itnMx3M4189kUef9RvJKlWfYiewwDc0hp71XlB1TT7ADayPVSf36qJLn8osB7X1Isw+sLPEZkMjhf1RMHootVqBJKXTbqx5QUK5no2CvlgsCvKv1Yz3dOUtYYi/jdBC+5vmCpRhUaXs9J9qmvDamXCZXGgXvq0ZXSM2bGg5G+mj0dq2ORl2JXBKot/DKFqeZdjkPEPKnclm8jO5mfyYzgExtghlb4NDMHdPXBv/bhmyt+MhcFNObO/3UJ1XUh/Sq+VP42zmZc5+1xbetCyQFrIej3Ab+3IAhtYH95VBST20i4wrJeqi7DBVoYjBPyUH+Zem9oQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1c5641-3200-4b05-ab6e-08deaceb3e8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:19:10.2749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh8fZUd7jCf/ifvDtLyec0RWaLfPAkXuj2v2dDkFnCqjfbE6yS4Ha08At6p4J8u76uqyD1+XbTkN41UA+q1BoWMcCVLX/yFi8lkmM+rIMg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10763
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNiBTYWx0ZWRfX/6NP3Yzbu5U6
 qlkIfugOJz/wWqwJvxHEeay6dPOsSETZcGpweKYKuG0WNw+MQdbBiz1jIxe3avtWFbbe3jk1llE
 8QiwU6HG8XrTQNwZmY7q2Cx02LE3tVd4wPHYnsBOkUymt1JRhoQUVNxgKN1ktPL4Gskl7qRAXxR
 wA21vA5qhtRdoUKIKJPwp4aamXlOYZsQ9JIslcJBiifyZuN6ElNuDyAlg7dDvF8m2yrob7vHkiH
 U746gCjstnYMjxyVlakzpQB+zXgZjB2G+XnZlGE4wBBaVZYyv9N3beKUExmTj+KPEvlvi0LqHv/
 4uniMcsweM48EK4RPtrfVdHP9vpLRLWnXvBYy97ii5YtoAavv6Zby0rhhlyS42k2ioIeVll/fjk
 QXG8DUGRCstbGsf/2Qk0uv01KwIcPOncayyGbaajpuCRIaB6oehI/GxHTbw2fkKZRFfniAMrZkQ
 9FDA3/XBLfhMyoCEFBQ==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=69fdb8a0 cx=c_pps
 a=Lzux+ftsp8NJ2nFuhgYiNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=1yB3SYwDT-OpB6Fa3bIA:9
X-Proofpoint-ORIG-GUID: BprkjNPco6VtLDlgKVU_kGE2jclQGMqg
X-Proofpoint-GUID: BprkjNPco6VtLDlgKVU_kGE2jclQGMqg
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

The existing aml_interrupt() uses the Extended Interrupt Descriptor to store
the interrupt information, however newer Windows will only parse the
standard IRQ Descriptor when enumerating ISA serial ports.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build-stub.c    |  6 ++++++
 hw/acpi/aml-build.c         | 25 +++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index e70e0643b1..eaff025d26 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -343,6 +343,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
 Aml *aml_operation_region(const char *name, AmlRegionSpace rs,
                           Aml *offset, uint32_t len);
 Aml *aml_irq_no_flags(uint8_t irq);
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared);
 Aml *aml_named_field(const char *name, unsigned length);
 Aml *aml_reserved_field(unsigned length);
 Aml *aml_local(int num);
diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
index 89a8fec4af..3180c7c962 100644
--- a/hw/acpi/aml-build-stub.c
+++ b/hw/acpi/aml-build-stub.c
@@ -67,6 +67,12 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return NULL;
 }
 
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    return NULL;
+}
+
 Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
                    AmlLevelAndEdge level_and_edge,
                    AmlActiveHighAndLow high_and_low, AmlShared shared,
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 7edc8aed42..3aaf96c2a7 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1061,6 +1061,31 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return var;
 }
 
+/*
+ * ACPI 1.0b: 6.4.2.1.1 ASL Macro for IRQ Descriptor
+ *
+ * More verbose description at:
+ * ACPI 5.0: 19.5.63 IRQ (Interrupt Resource Descriptor Macro)
+ *           6.4.2.1 IRQ Descriptor
+ */
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    uint16_t irq_mask;
+    Aml *var = aml_alloc();
+    uint8_t irq_flags = level_and_edge | (high_and_low << 3) |
+                        (shared << 4);
+
+    assert(irq < 16);
+    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
+
+    irq_mask = 1U << irq;
+    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] */
+    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] */
+    build_append_byte(var->buf, irq_flags); /* IRQ flags */
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
 Aml *aml_lnot(Aml *arg)
 {
-- 
2.43.0


