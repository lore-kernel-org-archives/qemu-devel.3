Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D914CAC5B3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oTJ-000264-Qi; Thu, 25 Sep 2025 12:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1oTH-00024r-JP
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:05:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1oT7-00005q-0o
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:05:27 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P85VPp109125; Thu, 25 Sep 2025 09:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GVJ0BCvGbCrZUczsoXPWZtL1gABR/SMGh+iPKSdkB
 0w=; b=KLEXrYhn2kjeIV9nfeoyrJJFyGRD/MkdYftZco9HJor1SC3jlwWkMaZ0D
 V52pgw7GR8mVozPd1YpAwgNLwkixS79X39QQujkLHXPMfzFtUl+pzNU4UC0Iv98X
 TgSsW+sgsASG653y5E7yNsXh5mMfolEet/qHOwV8jjdKyXVKu1rvqV8KgJZPiRFi
 hpokWWM9T2yNKPCEfVaOzIyS+3bNMiz+QvaJD2hO0nh3dPfXtxxrsHhIUj2noXpI
 FwN1wq5TwGebnKxlAuiVF5v0tctaib4uOjzejrB/Pt2bkdBVFaaovsMySkZkwvtA
 10Z4YfQBukWU0efVqgf/fFXPyFwkg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022103.outbound.protection.outlook.com
 [40.93.195.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1x094b6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 09:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izYY+BBn0iwRypZrgkAIDlsT81w8eJsv21tukZe8s+tlTGrlPj9TmRwVpNtEKcJmxmQoPCL6+JcHCd3BxWN35h7zh/crk4pFD3MdxVq9b5psICNMAaHaW1qrqtVDvDeI8v+TQe8IHmzh1m4W+D4rEUhVbJ7fR3S28mAOoGHk47Z9Nu6MnpJjfSQ91zADmhFWtVumfI9qj1Tr7ug0mQxa775kKZKQUaMOfCPaYZwq9rvbtw3/9Jzeaji7IfmeKfq+Ak0t9JfTm1S9pQS6SUq2JQMCP4hTFqaWeRKe2tdJZzhN0FdrCtBDCE/7emJD3ZjpCLK3BjbSn+sqTc7tQrA8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVJ0BCvGbCrZUczsoXPWZtL1gABR/SMGh+iPKSdkB0w=;
 b=C17KLS9mx5KRc0BNxRmYc7Watja1BZCLiKdjELExcbB517Ky5QM11Cz13XPFmdOFfjbWBzUAxEclCBnkRqBDOgavSYcAgg3Tq0/yir1p4EAtp9smbqui2b/eTBBmhWLvEjjje+9rbA/se2ki6cJoXFehMPzGFZDiBOj8NFVvDdXxYW9wz2dzsLfKJdw2uJVQ05fF8pfkY0UXu472F5OSzaFKPZH1CNtdU00h7yLfe3FzdjcIy5w9aV4ijNRJyVw/GlajXAJGDt6hDHC0NGuigR6r2E2AmkE/0I2jZmVESWYWLPnc484/wSEJSNJFDShJMKOmDWahSDYRaVcDS0MbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVJ0BCvGbCrZUczsoXPWZtL1gABR/SMGh+iPKSdkB0w=;
 b=MGbuxw3X562VHo2arreIj/3HP4kGxZdPuEfUdVYLNJxGOVS2x3mOF6IuBK/vRcw4rMK8OZtcuDKk9Gmtw9Z7Mt7Cnu3AtPSZcO9plqQczVKsIUSVJNRcvXn7k64c60IBL1Z4COEhe5r9Ry/GhVQDjDi1UdPpd17GFuf5EU6/Hp7bMKJ+wC/D6SZi1AZ3u7xeoLkrR81DdkD5N68Aew6BIFSdotCgvoN66bCnad07/Zcb+BkJzPIzuA7M39Fb27+5UnAVa4u/CY4V5TJnCWNLZuoqpYTsZ1yoZqCiavE3WPNtj5I8XUIfVZt7EmJosGjS1/cqt4eAfZJz/VCGzGv2PQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB7884.namprd02.prod.outlook.com (2603:10b6:610:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 16:05:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 16:05:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com,
 jdenemar@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] docs/about/deprecated.rst: document new restrictions
 for isapc CPU models
Date: Thu, 25 Sep 2025 17:03:20 +0100
Message-ID: <20250925160453.2025885-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 072685ae-c998-4388-ab69-08ddfc4d49b6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aIEWCzmShLri7+K1rnI0bVCjZjcHZgmQr7XAcLGZbOGlEk10XRUh0cmS4l1I?=
 =?us-ascii?Q?2d9ctSpGOnR5ISrj97TqEQ26DSRAYHMe2U1N3gy4+HwWK5Hxp+o2XwZayvd1?=
 =?us-ascii?Q?9tQRKY4qTG0/qzVvagzPHNdPwGOJpSly+C37tYgo9sQaTTNbj2/muXC1spQu?=
 =?us-ascii?Q?NhBAF3Dx3kjA54asd/cEEFXtwKe1+jmZYwHoRzWHsqr625Qrj5xV3Jlmhl77?=
 =?us-ascii?Q?e5WmDOaYmalGyITxRu3Vna658qLL976l/afwzagqh1o9ehsI9vAHMWtTWDfV?=
 =?us-ascii?Q?xAz70ZEGQ+Jn1nPQTewJra5tEPOxFRIHHAtEyOiEW5txMkojdaeJ3vLMV3AB?=
 =?us-ascii?Q?mE4y1kqOsKE/QjXHef/Yh8qmU1n9aN3+UlgOLe+e4G56w/8yUb+ueCBl3xNk?=
 =?us-ascii?Q?6mQRsBfQQjgGUbgfJnte06Z26ZJbGqP33jI/QMubrjKY8laPqW5sQXQMEaf8?=
 =?us-ascii?Q?o+i2Adq0NqTaEcmASk5TH6qcfztlAvA8EeUGsuWED1CqVkVFfQuo8mgAbl3p?=
 =?us-ascii?Q?bs1RP7xWCendwCH3oOBkEUyfswltby23PYXbSHE0SiY+TQiV5IjSpyInPeX2?=
 =?us-ascii?Q?OkVaDEx2z6VRswrw3mWVXg2gSkRrRcrYwLM4nxd+s7tXOri3U5YMab1NBia0?=
 =?us-ascii?Q?BvmuvNwDJmfN2831UOF5uHUijRUP65EuieS+nYiRcbgdO5VT5v6lQ/FcfNQ9?=
 =?us-ascii?Q?O7Xsw2Xw+KHzHYFYp/FNws5ntljIm6SzFESA1ZwewdMLZuRSMA6/7+7pEkNe?=
 =?us-ascii?Q?e8xSQbqR+RIaRRYBp2KIAKKekxs7KLL0NBit1HRq1zGlNxiCbghEdFfOPf0f?=
 =?us-ascii?Q?cCwikFENLWRsUsBctlYjuFAhkT8cCbVl7hPP1ugkPpk1VoexoxbiL02HA+6A?=
 =?us-ascii?Q?aKzPYpMRioS36ptCHYbM59ULfisCs6KuGuCdvhKZx/BT+Iu/jpr7Z40Sxiod?=
 =?us-ascii?Q?U9mxxeBMut7bjpyzSipHbwdUnDCzUoVRDPzrt89VLxVhGqJZ+7YrWUUYGaAV?=
 =?us-ascii?Q?CPam7xlVBARwo6hGnTJ7JrZJjnpMARlX28mTm6LxDyiN92inc6Rkq5zcLGiH?=
 =?us-ascii?Q?51s8+q4cj2tg4P2jNSuMpZ8v4AhEiwUYQvLBDXQRDtST4WOrFpcnUpaOYH7v?=
 =?us-ascii?Q?ctFl1CbSvdmBZuPtNgDYcSrNquVOjRFlGibeLjmgVynGmd/CpYG4xVUojPCE?=
 =?us-ascii?Q?KWHP8Nc9pRArS0CcLiBCmmw3F90GjIwmxRfCTyM2hZvk7d/8vAf+kofL8whQ?=
 =?us-ascii?Q?kGbCnXZiezIbx+b9KEesyAQZ6FQ8w4i9aOy7f/nSd52m+vuPO1faE2/dHbth?=
 =?us-ascii?Q?VEeLaDU+Bn3pVZpl54Ut2AvvrLYwshfwRhu1z98TUC55Y+OFKQfftiFd2PNI?=
 =?us-ascii?Q?5Z3VQI09Zp+FkK71argn+2yeKKL32xGpFWLGS04/1yM9kkcVW1DhmZxAakRW?=
 =?us-ascii?Q?iZlFVCwhv8bo63ztoXSU1FmveBHQCRazv2jqwfqQPJSrEVqVYck6sP/aUEey?=
 =?us-ascii?Q?ncCbrv8jQd+l0/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXkXoFPlHYx67eG57n3mHSErcH6IMtEHB1RGgW26kYZW8B9c32MhFhClJ7fA?=
 =?us-ascii?Q?N0IXOlrw91D6dlXXefc08PgHy3dCcOkcm7kRkRm7Y/Z0MLYEJRyEzdz8XFYm?=
 =?us-ascii?Q?qWvHoAZh9WGpYjteXDHhZY/qhM6tsIj31lxDaoSJ0MQJ+VYJ2DQaq5NftKGU?=
 =?us-ascii?Q?1NDZdS3CCZwsmLGaIjXjCOA4pVeUm+igst/qVUUaptEsf58OmweAJc/cOk/U?=
 =?us-ascii?Q?0v0RkzQUEeFRsq0hgkDQKAXAxEo9wpFPdDec94/UDLuHrxF2b+Iowr2X6WsO?=
 =?us-ascii?Q?IXC7LUu1SYIQ15N7lMvy9Hxxx6ZV5I36znQUwDEDRr1lhoxn6ljQyT4IU8+F?=
 =?us-ascii?Q?L2aC2ZjDG29NuebUGQavCT2p7C6uHze+eLkZkoCTPu+d+Axw2TNQn81gy/YS?=
 =?us-ascii?Q?vrsyAGrWVzBQe9LZ1XAC7YnpaDsLqLuh2enA6ORucqV9aeFBiHK3rK0MahjV?=
 =?us-ascii?Q?LFwtTw9vG35kCPKxrjafseDhPv2SCEKXMMSvmYJysT+2rIAKG0UWPwzsSwF5?=
 =?us-ascii?Q?rbknOsZz8aH9Ge2PkZN+zYnd7t2JUXf+LexFDGe75QxsOsrmSO29mIm+31ls?=
 =?us-ascii?Q?8fn0WeV1STrR1ASvqlK250WBEwrANJRM+alfyOjJmleXQWFjnYfOz440Lblg?=
 =?us-ascii?Q?Z+26hIxYc7ZJgYudU1RylYh0aJK0bQ20gR5XSyJxtl1/aqPRrDrtCaO4rZ7u?=
 =?us-ascii?Q?5h6QlYbvuAq2yHF49oy1uqRF4c7+LRkhp7uGbwsHrEqRcXQyRk3pJiwOlvQs?=
 =?us-ascii?Q?EdioL8fyTtnQn3yLLsHWZa5GDzqbDzi0kfeEAKcan+cBoggJDNUehkYsBm7e?=
 =?us-ascii?Q?Lxu4vod7dK36iHs3bxHmPMI81NzhUVJfwXFTgbBjNyza3ti5lJ8rgTtEhd29?=
 =?us-ascii?Q?BTjenpWB8R6IUXSfe2x2YJSrEFzpousVHDtoRLypN77n69V3KXK3cFnZib+g?=
 =?us-ascii?Q?5km5eD7RgZ7GqkJ3vzx/6tQMbdieYQx2AA2lHyquezixdnOx9v2Zus/BAJf8?=
 =?us-ascii?Q?cahqEq4vzhEdAmeEc0LWO5s4zvrVSIzWYCS+t5lrzicFC+UkhsU1+VMsmzAM?=
 =?us-ascii?Q?PlAweJBYqgNlV9zXzA7Q59TVIzvxXXZxvfHoZwWaDunv/4z7JQSoFGtdDtlY?=
 =?us-ascii?Q?mtEz/ofZp/tv3yV7Fvl42cqKxtAAvDi8JY0Ds8hYOyYG5cgY3oH4Qp/ZqrcB?=
 =?us-ascii?Q?E82kC8EgrClFn8Xhu7fdA2Kv8MQpgNO5BfYO6vDU4P61gEpj7Qbp+ojrdal+?=
 =?us-ascii?Q?cM2mGxapu9YvhJBZHpCGyKE0pFTqA+D+JticbPe01/KBA/YXNwbBj7X2IwXc?=
 =?us-ascii?Q?UZy46RdCfFvSDfdjjYytrbQrhFMdtHjaL7HttZFeUu/jPTR8eRiZPZnRUhow?=
 =?us-ascii?Q?to0c7/R6BCKaRQs8n39jMLDUdMRA9p74IVnUqr0DYFIvrD03x1YbZOlL2A/2?=
 =?us-ascii?Q?tbx5Ov3Zbqt3r//EdwupwOIVW7QziRuYNkRya7pRLvFK9qwbsS0AKWTbZmyw?=
 =?us-ascii?Q?QH8z4E5wQ7BhHHLyv5Fh64rx8Fzi1x4zf+cvfPqp9rnzlTdH4hVWhybewaXh?=
 =?us-ascii?Q?NwxV9hPH0ihTjtw5JxRaFoihA3CXc/D6HxGz0aicW12bXM54NFRUadliW6af?=
 =?us-ascii?Q?bLGUX/jLNhOvBwCUu/p9AYIdD6LaDfq9U5MvL+eO3yULguewG8gbWmMQAq2A?=
 =?us-ascii?Q?Ttu83A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072685ae-c998-4388-ab69-08ddfc4d49b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:05:03.6971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCc6ivdRDsrwjs6UK9O0i7qeKDgKERZ1zLzCGyh9EMsWddG2kx+v1hjsyOk629hUqjNaBr2hQGnAYB6hvu48Cw0qhArlQYfgXwj7phkKR+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7884
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE1MCBTYWx0ZWRfXxLvxowSzG/5F
 z9otA7/ec1dTALAC/1TJjMdHa4b9VexquEjGN8N+O8jeVv8jzQeYCBLN3jBtCkgLJDe7sDJD8Ro
 yFrUnSuaxtqgGcxrpZI+32spiIhOHMziHN4LXvXOHlyGswAvkgkhRsOHm20J6McNZnVs9UNSJZt
 uiSTuD5TtOb0kxoDyHDlQ8LpFtQ7j4FGRoLIEK7qOQWy+gy/t+ZJsxrLPUCZ07yAzkpDs0WD22h
 nTVQwduxWcALQ/a9WQ2kNILFI8QE/9pd3eMZ+xuTG76SyaJnEAgKQi0NtfO0ZKX/UsTNU3hmLrx
 6I7OhV8Sl985M9Bc1GdTK5tmc9U+JfjEO86LD+403rcl2VSolnFp5/yOQVeE28=
X-Proofpoint-GUID: rPho_k66sPOihsnS8xFjsaHsmQDxjcYS
X-Proofpoint-ORIG-GUID: rPho_k66sPOihsnS8xFjsaHsmQDxjcYS
X-Authority-Analysis: v=2.4 cv=XvH6OUF9 c=1 sm=1 tr=0 ts=68d56833 cx=c_pps
 a=dTL/NSpv458ZJk1fBD1pSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=ia8uXnsvh47bGLi_t3MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add a new paragraph in the "Backwards compatibility" section documenting that
the isapc machine is now restricted to 32-bit x86 CPUs, and -cpu host and
-cpu max are no longer supported.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index aa300bbd50..4c7000650d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -514,6 +514,19 @@ available firmwares that are using the current (wrong) name.  The
 property is kept as is in 9.1, together with "riscv,delegation", to
 give more time for firmware developers to change their code.
 
+x86 "isapc" board restricted to 32-bit x86 CPUs (since 10.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The "isapc" board represents a historical x86 ISA PC and is intended for
+older 32-bit x86 CPU models, defaulting to a 486 CPU model.  Previously it
+was possible (but non-sensical) to specify a more modern x86 CPU, including
+``-cpu host`` or ``-cpu max`` even if the features were incompatible with many
+of the intended guest OSs.
+
+Now the "isapc" board contains an explicit list of supported 32-bit x86 CPU
+models. If the user requests an unsupported CPU model then an error message is
+returned indicating the available CPU models.
+
 Migration
 ---------
 
-- 
2.43.0


