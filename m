Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD4FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXb-0008IQ-RH; Thu, 28 Aug 2025 07:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXa-0008Hw-BA
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXY-0005Da-Cz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:38 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S6cu3N2960418; Thu, 28 Aug 2025 04:11:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1k2zklC0fAbTyvFiKp+v5RWKIyMFPDpsdEsSBa9s/
 aE=; b=mGDmQXGUTNsGvEmHuiCEa6FAZrDFIW40e7BPjtA2Wy9NuLC1KS4xp6TAg
 nFbbPP+Msk4D7m3NR9QxDKw6FsI+nZmMKk/Uz1QzXW8r6DBHuMq37lMJyPycqNqe
 cQhsDTn3y5Bihj423y3BBd7vUrd7AU3YiqVOTzc/dpxfhB+/9gie85+ZHx6g5jAl
 lPx7oZjC62yMbK0t6+fvi2igOfQwWnmWBxGZDp0GJYhJNF3+3l2Tw27IdI60Qp5Z
 grSUJhZVmxGRQnJVCKzKnLO9STsOlXpCBdzaeNa7Md4H9jLeaxx0vyLMupqzAmY4
 TxyuhLmOgWxZZ3QEebGqU+EBzI2NA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020097.outbound.protection.outlook.com
 [52.101.193.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48t7xvhnp5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHn/CpLgtSpCRNGBbioyhWwU+FfU9c+whZWfiBv+nNIt5drMv4bVN8N9tfyLvQGa8hDuK1SI7L+CMie3w1jU0UDmV/mdNhNl+L7y6adJpB612NGLlhjlZ7HTMdrq/1lG4ah6AOy/t8wuvNk4GJvFu11Evvjdc0HD4Su0WrctwozzptC8NAhcER9hjLFIeJkWO2KZNwci4Dekdfa0gX+Y79LHT9FXZ5Tf9tKptXgeFavrpUAQZKHO7sdi0QRdWeFPKqvs2Vec+VDYnpOZT8E95cXtVdPwXvfc5AXh+rCd8EZuYEGBHIq9qPUS60Ls9rpC6iq6Cq1kGMf/K+CkoMTeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k2zklC0fAbTyvFiKp+v5RWKIyMFPDpsdEsSBa9s/aE=;
 b=q1v9NfUhHrZqSxEequo2kUe/dTKJKR8dyC5cvtjEn2r0BZFefV/0/aKp/vXDqoS2f9ZUMff7x6BL/g8UMKb2Ukq8iaqwWSDpSs9WRV4AQB1ETTrL2desCo0jCS5AZMWFC8MKibu0kn/jxeNrnkuNoysu+fZclvKJRJVHeZKzLlExdoEZGBmypRDUiShZpYCSgJG4aRlJc2OHkdwxBfHpPzeZqaaX/w4C7fVK0FqY61Sp1z59ezvTROp4+3CP8pC6KAnCU9+LTTOEtlOnIwCpaOpG6Psy74UjnYKlV9JVMX4GGRFi+IwEj7r75lZorCYdVZX0/KWpWe/2LAlwmt3L0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k2zklC0fAbTyvFiKp+v5RWKIyMFPDpsdEsSBa9s/aE=;
 b=smM1KuDQb7uTLQ3ADSlQlbZ1v82kTUbLQjew1YejUhiN9eTEtK+k25If+g/xWRrvkbM0jTX4mvKh9FTucFoFLpYGQ4xgBNvCzc0cd1rIAtV9ikvnYM7OYegJrOqivD509WjarljBwAPgW2MVibOwSHgelKlmUDeEvYH0udSe71pVQAPSXNLRasI35/HVdy0r22av0tZkI/dYwqALmriTEtL2+80csZGcZprfbuQuLU5Lsy8eqpwTjmU6TpwM3a5+bH7/Riq5xMOSaS6mml9Watm4JlyC8b0yJ68UADAKXmYkRes+6c0f+lpQpQu6KziO5sJStOno9frLL1VX9EyPJQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 09/19] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:52 +0100
Message-ID: <20250828111057.468712-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 519e683e-caea-4442-228a-08dde623a428
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wxb8UC1Ew2OTyzJKOTYYTjZoq2i0smMrwxKHBlUjykXXPr/B/rLC9+FcsBAE?=
 =?us-ascii?Q?fs27VFSxUXTAPvKyKPVSps0lJiBnZ2te5tGCrvj9Kt4nbkGmGsaHb7b9JDO2?=
 =?us-ascii?Q?DL4hjPMN8qQd5UV16GZn8ZU02/z9uEr3+Ys5fb4hHlnEVF5fe8Zza5xV5oIb?=
 =?us-ascii?Q?g/v1DU04zyLICZC/qjypaFhHoWiWmrk9s7B6q1a9DJAYjYtU4AlCNGrY7TqH?=
 =?us-ascii?Q?vUcuIA0H9NIx53JAYAOWA8XbqLvD1DfpSX7eZEnCmFkE9fsOIVgUA/NiY/J/?=
 =?us-ascii?Q?itJUYomJhpZW8XpmXUwMSP9lhuaolOMCP37htgBmJmaM2ojkF98KXzDNivQx?=
 =?us-ascii?Q?ByG8TSqeydOoz2P9Owj9QKUhKXQ9SA47v3qWgi0fvQNvHLqVxNI4mfENX4JG?=
 =?us-ascii?Q?6CD+kv6A7fncok+P9P1voWZHSUdavA1D/8DXQj22RMlFjXCypvVveyl2d5Ib?=
 =?us-ascii?Q?2E6wdBJm9WYgUIVODs+rVyKAGw0WHqwzr1vU9lkAlZgl278CI+2GOAQVlwxS?=
 =?us-ascii?Q?TfSZeDovCJqHSCy2lkxqAEQCqY4QbckJv6B0JWluUyPocdet95M7vCGa1Jat?=
 =?us-ascii?Q?YQHBmonhV/GaDjS+jLGhUFmXnlgG+rXdSw4eTlDVKB3ho2SSl1dIqSFj1YlR?=
 =?us-ascii?Q?IAr08vruGQ21ngoS2Zr8LeZ7YIdL5kMZUc1Dz+wx06ySZhH4zSUAAvUNV8Hg?=
 =?us-ascii?Q?zGDvOzPSz2m2c4FOqOW5mHpTLQRM+gWHGbSxFzIWR2UtIPaIpfW8DjBKpK4S?=
 =?us-ascii?Q?PcdCu7JOg7dTip+mNhAirWf7ejOtKzKHXkPSTzxw+IsZgOKLvv1vM9Fxb7YO?=
 =?us-ascii?Q?ICjIktYUrWBO4HNyZaa/RQ2sExfFMi2xzuL0rluvkuHEhHj2zINIjBj9+g6L?=
 =?us-ascii?Q?i3W76BZjhsoS/sRsQT5IB9RNYzZlVbmN+vIH/eax3We3YXzj11D4kNSEtDNu?=
 =?us-ascii?Q?HGT8AH11pEqkE8tNZIkwtkkLALYfThE/2D0Rh59ySZbq4+6Xxsbb4ugHzlHy?=
 =?us-ascii?Q?maBt2LbNhqwWF/05wkbkm3emWXSUGrPcuSYga96OYp4/moWM7wgbwaK8g0lS?=
 =?us-ascii?Q?dyDV/WKisCq70Wae5s9LlIgLnXtG5gwFGpHqsxr1CwrCTXFonWGCpZ+7y+V1?=
 =?us-ascii?Q?KUfqs+AJUd72WzwW2+LBSevFjLUFWot5OiZ6JvQmdfQ0zDldBXb3hmBhk5+q?=
 =?us-ascii?Q?U9hyUus9Uh0/PtqgTD0KVVAc2IwqhPlfg40b2HdLu7HW6H/TiSbiZooOac4F?=
 =?us-ascii?Q?jFLn9X2jJtlALUzw4GsgI6GOI2E/tTy1VNfKRGIL3lRYrfPXoefmg+D2ioFq?=
 =?us-ascii?Q?nxCmJMccB6jCbh5kRVoiOrUDYZQcT5Eb65XA5KA/wnLyG+BhR32iDDPBdDBI?=
 =?us-ascii?Q?OjSupNln/Vq2sEZq3UK5t9YC/3QbW5EpgbixVQq/LVXhV4iMLqSck4G6We9W?=
 =?us-ascii?Q?/qitguC0eOM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gVVwysDDOm9110eSNmOV04zunI9h1kESOMXpRAfnRT/BAV3eIex8HaF/PdSI?=
 =?us-ascii?Q?FJM5UvpKIcLZp5qWRy9aUS8Vzkfsp+2h4sMxD22kJ0+Kha+TiAsYvyS6mIg/?=
 =?us-ascii?Q?GVPp2o2sAZPBl8LMBtoA5joLnUWaf8ux6RKh88fFTCJyyOlhR5mBKKpXwZso?=
 =?us-ascii?Q?Tb0h5ll+mqCqZBJD1thSN3n27sBGwS8HB+us9prRCNLMJm1FDtq0YLKguD2c?=
 =?us-ascii?Q?oK7UVn06NH1LaIF8NK6wa1/Iq3i1YgZQHtHBTjCeJRDD2rlI9tvrLDictw+i?=
 =?us-ascii?Q?Bfvb67CG9+PnGPrtFWuYue5haje+J6x0qhX71YkmOQGAN0waB4o0YgFlZdB1?=
 =?us-ascii?Q?bHa5Q9JDaNcF7vVSX3bIyYxCh+epOfuQORuWUkGFIX6Q8uV7+BL4dIMKj4ns?=
 =?us-ascii?Q?qrAaGGwg6JpYi2jKkokgTZht91s0RggN+Aj32YZ4cVJ3vfDhDiNj+1bwI90h?=
 =?us-ascii?Q?3t7fP6oellHWRXvLBVrZN0gmvIXdQ5HSwnvlatx9uWItQEdMcd/JyO40w6Yp?=
 =?us-ascii?Q?P2c1lrBC2LQtAjI14V+tuIa8Z5yhcoI1aUt5oEJt1WWDSLrM33yj78xdolTl?=
 =?us-ascii?Q?s61500hSQkKCd5Y2yMqSTWctC2Cw07AWLHM2+8Q9+QLwj/Ad1mygJm6dULiD?=
 =?us-ascii?Q?h0Mm2aLEcN5Bcq3J3ypifOM5M44afInXBP3YvLoGCCPbxNlPsx6JSaXP0BCI?=
 =?us-ascii?Q?QhbeZgw/w5p/yq3CpgLimJOybCYmXnlOrhxmZchVyC/SMPUdnMGB3dyyOo6G?=
 =?us-ascii?Q?elxJr0w5uNiZrhTXYmzc4yKaQyzgfQMgiGXiqJNWlGEqGzKZnC33yDtbZck/?=
 =?us-ascii?Q?xlRGmTa60AAesTTqE2cpM1Mt42DJhRoa4mKIIt+5G4xwxDTy210AYA69SSl7?=
 =?us-ascii?Q?ecPWEW9shGnTLEvzY4qPFtXERPhEte8z193342QK4dqIjAIn+MusKYUuEAkk?=
 =?us-ascii?Q?oYgmngqCJ7hIQxc99oRKgmdUVxunRCAQhRKzkva09NyskWWI0Az8n7fKQlz2?=
 =?us-ascii?Q?in0o27PaTpvCoBki1eSJ8h7mBSOX0/QAygTmSt6uISiWSo+WzPQhnO34V12m?=
 =?us-ascii?Q?mx1FYwNvFuGjTZWwh+N3QupzqFTANHInoEWYsikcNo2b71W4hAz8W4JROv8H?=
 =?us-ascii?Q?VSl12KkxaMDY6HizlowTtrkuwNKG12WCNFLJeKnr+TgzR6BrQDai5L6+ExwP?=
 =?us-ascii?Q?6Cdo4m1U3ICMtYpNMtWmyoIABtDFVamdMEGutXuPhaN87PK0nu2bsdO//8Oh?=
 =?us-ascii?Q?i9Q6wDemF7Rx0TsbvVxK37qQvIB/qkf7BWVLilJtrq8ZX+c+rTODk2llp0YQ?=
 =?us-ascii?Q?1ZJlu1AzebOAQYd9ppJUL8ZTJYghy+7ghFRlCTtZGjkR71sZ872gy0cnmTe+?=
 =?us-ascii?Q?pTDhr/jTEb4PsevFe93tvdLRskUE0XSwvOMYnSIzAMe8+7tddsvQz6qm2D83?=
 =?us-ascii?Q?dcxdN5rW1uU3cUSMxhqC8A59lAmt+GiffDoBrAB/tj790iGUojh79TGQ1Afn?=
 =?us-ascii?Q?xewUPZ4LcbjVzUAw/LwP83QdfY4CT+zUEgYVuIMYHBmyM/X/Ylq+XJH6Cz7U?=
 =?us-ascii?Q?zf3eVru7YiZ53C5ooiFsQICZPJhKVHsj4ByZgYGc6JPRPlYAk53kcc7O6o0x?=
 =?us-ascii?Q?R2eRikXNDACoBjWxfo2bsoO+l5QkzUhjHzRWh5tiCGcR96oT6v4Tljt62sBk?=
 =?us-ascii?Q?nbYDkw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e683e-caea-4442-228a-08dde623a428
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:30.9589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM+9C9jvmiuvE54elYmTK1b5VJroj3oi2tk/kidHJSAovA0EEVe2YmSOoubBH8ABlTnmPAmHrVHEa+gsvQqzOmyKN+ua4IfCdT4ZVb2tLnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfXzL0/BXEx4IUy
 6rUZy4GsVbulR6ZNBrIVVu5LbU3K7/kdBwuw0LFZFcz9hi4WjBWkP3jAAwJPOCUdUb1XWVRqfWn
 qU1uGg2Vp6NFvRqZxm5XzH4oNn8/YdzJbSO44Dj6ZlZEP4Im8QkrrifXN0jNMEOj9IyyIm4+vmf
 +y7D/Plf0JV2f5HqLTT3aysBu6IdsV5jY62fFGvERCB8OzLf0eWVzpl9Ob/yRfuSvMdEnxZ82wZ
 Lu/3rDFkrJgfqHnxQmPCRnQEZ/WtxFiN54rRT6V3b+3KeZsu/63U2RQsxk9gIfxqVUkddY4rs+D
 AjWrZMbxdx4y0oGOlChnSaFCLPr6qyvUT90Xqo1HHdErEnuvFSLnaE8WlsPJ/Q=
X-Proofpoint-GUID: mshAr5fnN2rM5mrHvcg6-OQzRJsxv979
X-Authority-Analysis: v=2.4 cv=Coq/cm4D c=1 sm=1 tr=0 ts=68b03965 cx=c_pps
 a=WuGjf4t6T1Q5vm5Y5Z/RWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=QyXUC8HyAAAA:8 a=rnFr0Qxienu5vtaJ29UA:9
X-Proofpoint-ORIG-GUID: mshAr5fnN2rM5mrHvcg6-OQzRJsxv979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 57b02da5a8..9a2eee8ab0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -541,7 +541,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled()) {
-- 
2.43.0


