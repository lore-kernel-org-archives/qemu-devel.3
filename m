Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075FBC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOXF-0003sg-6N; Tue, 20 May 2025 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXB-0003l9-71
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX8-0002lt-SH
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K74Jhp000844;
 Tue, 20 May 2025 08:05:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=u9jJUSmXNJCCQeN/pGfq7Gl8NDX6hwBr2YbxQJ01n
 jU=; b=KM6A8nVDFCGLDT3kIDJQb9Cf3gUfxC9XPeG2FIeD4+j+oDRD2rDIy7Cn9
 0N5DGXtMiSuVPZBz0yuMPpWRm7nhid3CiHHWeFfUVMLxzsHwdEQwC35g15tn2m1g
 3ct8cxOkeSyv+P/SgeWKUVfFSt3MLDZIl387iF6/hFOYU8NunrzssBllWiSqXU3a
 JlcmexVS2wrng5gy0hVU9VNjR2KdtnFI5BpYcDkMZdPyKf+MHBMcekMGuvhZT/GP
 aYs1fpLIXmGwuO5jD+Vzua4q8jFZEyRN4NHjhV2v18/p/gdeCFWI24iF+bWeBGzZ
 hD5VdQDbG79g5Wmm38Ay+SKxva9Zg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhec0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfjoX2vD89WLgkCERZUqP731UrV3aKbNomGyO+2Hnag8tvYvCdXBkiE3jOkTGh5t+mUNZdqWQoOxFYu4pYLCKr2Bot7XVmOwYDYmHPuaZywnrskXyGobxSyciihXdNg+5FSOuqrZTLa2/MEmmfstbnscd5ZJt1p/KN1NJasC8NT8JrO8bgrblnM/dt+3/rop2EMCdEZUipKTC+S27mOZuN7ABV3XJVHU1RPT6T6bUBdmGNowegLYRFN8nv9e4dtegNstU0jP+V67B4DfUBn88WUfha3Osnm0XC84uJTWIukxiDuACy/FD3mtvzaogIky6DrKrmPn06R/KQwmB12LaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9jJUSmXNJCCQeN/pGfq7Gl8NDX6hwBr2YbxQJ01njU=;
 b=q7lurkawzrsbO8h16uZ83OC9pWGV/osrJUUxQio0GPCHb9ybddBQGro4fEcONal5d9IQ4qYDTCW1pjKE7G/2lSIs89wd7pgKnS/Sc3vd6i9QJH0iNROlSrINJ7mY4VgX//lq0/Yq6HxhKyKO0pr63KTSSFzKjlKK3AJe4KxCMWVf/QnIXdNhHcb1Y4zBF2pe1HWeGRMyRVjnS/a4uXMf3TaDsTA7GECkWnfAbqGm8q8yX/Il25C16KLjKyDP8FNaxWO5wnMK/YN6jxSvzZewtfshPuCA/aPJCq9K7vq69gf4GkW1RVJb92v92LGyPY0zVS8IqrFox/O7cP0z5ufAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9jJUSmXNJCCQeN/pGfq7Gl8NDX6hwBr2YbxQJ01njU=;
 b=J/7DPtOCZM3w5y14jrmaqhFw2837uTvGMfe7YrczbMMTlLkAeHpXI5J9vmqry6d/ZBl65Um+Rq02aWm/VITTLIqU/O/fPJzSenFYKetGdc3H4EspLNvZhXynCGEhHHC6naSR4HgsJ5oho21cmtrRmQ3ZIFcSPTlGJsdg+M2c/SqMqjbj7ZFYAu0ozaYMTCq3qhzEVzq6uqn5/NPU+uqzs5mt1y1DNS/K5vmGwSIsc7UYZ7JnHYBvtaWlNerjTv5sltgjbT2lP2IVHv549t0ZYUSNs0smCSx4vlPSwna2KyZjULh1O0ZYm1RY4qsTkNt47/lOQKS2Rj49kE64hzIMlQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:28 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:28 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 25/29] vfio-user: implement VFIO_USER_DMA_READ/WRITE
Date: Tue, 20 May 2025 16:04:14 +0100
Message-ID: <20250520150419.2172078-26-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: cc899166-b703-4667-46c6-08dd97afc1b8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?56WSe6YyoLjzwdY02AtgLwI9RVgVZTIIcATK5RyJILygiymsJGi6xyYDPW4p?=
 =?us-ascii?Q?tm2HZYUpZMWHfX2qTUGpDoDCS1eSOeOchBYstgxypIpGR01Rk4m7+c44wGg7?=
 =?us-ascii?Q?9rF7eD70+LfhAM6td69MsHDbo3znOdnVG3XScQaOZfWiyXlsA7S+92/54wPc?=
 =?us-ascii?Q?5AYFC/mIr9j8W6tBLVqVkq5pcSx3V9lKwNRx6X22gIa2W8EYAXYTFqiC67W0?=
 =?us-ascii?Q?O6IqTE/rusP8yE4ZqQMEUcxTjpN6vhvhkZAEggD1xrYy9PAM/qFL9TwnEEE/?=
 =?us-ascii?Q?lGFYHzhz1l/oCmQHq8l9jiwmkSxOB0DWSBNF2fFCqCXY/q56cd+lCd6bX6YN?=
 =?us-ascii?Q?UShOp90wUTdskpuds8lk3+hCFCaY2KjDWoeGHz6QFtcgzJMpfyEoatwEl64r?=
 =?us-ascii?Q?UuuekAfyYcQknJkvqOhFDcs0Ad9GB508LVdveoUudoNL1wNVUUJLkmIsGEct?=
 =?us-ascii?Q?OE3f0XuLZvNVfKUNvcmDSGPdeah/xvBOSF/d4jz9RkvDITJNEx+lyIKcobwa?=
 =?us-ascii?Q?CWKlIXWLY66tuDQG7zvAoos07aM6GYHW4g4ploJtEOKAPwfJzOcGN7/GXMyG?=
 =?us-ascii?Q?ZUTMt/ynzlv7t0KnY3Bc0GOZvPvd7PNLc+syvAP4i0BfF4m1KqSJkIGBfY5W?=
 =?us-ascii?Q?RnFqtR2LqnlbYSvw9QH40mYEFeVukkZtPx33nAq/RyAue5LAdaTHDdB/jyiM?=
 =?us-ascii?Q?mJMkn3ipBuP57yxhzH1PEWXgTeRMN2C1rdlFU0YgNieBqbHfiD5uUbWXn7EF?=
 =?us-ascii?Q?f5caOf56Gw8wAvwZ2tOq8+vlPVckWvmee7unU1nosxfLC5oWxBkt0HK8hRJi?=
 =?us-ascii?Q?xlQ/dSGE8b498bzQk1DGsrhz07z/8A1d5OmGDEi/a99iZ3vZwN6GIs2KLM4G?=
 =?us-ascii?Q?lIhZBP4uM5XwuIFrYWqdJYMVGa88Dp/P70fuvtQYkvRtRB+Sna0zsrbAA4Gg?=
 =?us-ascii?Q?AIvhA+bUaECr7+d4c4HY0iwGxc0vklRitOcQUrjBqJJXpe34LK1abZ99YVA7?=
 =?us-ascii?Q?Mqa9p+jvTcdMYAF+D48oOCgJI5EfgvrGbfMNJzt9YLqLLnebWOTx/HUzBJ2T?=
 =?us-ascii?Q?fKAQVTIBQMatAvn51eUZWNrOXeJiawg6IGOGSTdlto03xwD4ZNR+FANCVthr?=
 =?us-ascii?Q?kkxFmOrnWpLqP/vhHq9KrCUwLo9kFfpNK48fPluzKXKsBskk4QmgSetqFB1C?=
 =?us-ascii?Q?GZzn3X6zd3AomBU6/C5g9lnCOu0Ag0vsZH6YJt7k3zFgSRq/l3g3X5nKs30q?=
 =?us-ascii?Q?1v6/smMrbT8lYb3DAy9zc4z5MLgZGE7rvU7/UymHyto+vBH4vluKHSPqP5Za?=
 =?us-ascii?Q?T3UGrriq+O2T1sB44PXuEo1RQnnGUOZOCuUGiVshg8vhrBMD0r4yXTr8GhLd?=
 =?us-ascii?Q?8ay4MKVgC1csqmeIN6XqKjzXaPwnnnKSucMG/4Uu3rFydODtJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlgyFQVU1A4m3czpdsNsHiG3A0dZER1lJgB1xLekEe8BnQYdBxfSs4MZpICK?=
 =?us-ascii?Q?KmEPnn0pvoBYguGeZ/dH22aej35cAYbdie0yZmarAn/Es88V+JbR10baNyS4?=
 =?us-ascii?Q?OJRmuMAHCDtJkECUbaXLW2FkcfM3sW059vVgEuI/udbO7IkqFXqCVu57azsI?=
 =?us-ascii?Q?T+dgLYlUIAEnWYH64iA1LFz5bP6OaRHAKDmqpSjNROkv29+Qfe+qDNbEKm0G?=
 =?us-ascii?Q?72MDtkCXoXtaW4x0I/VO5IIcF8186L1j+pe4wak8W/TIHU6eObKRi5qjEAWD?=
 =?us-ascii?Q?Ku9kC/pPjWw+0T7GOkBf/dxQG7ZeW3Mc7seaS6+2bcLwZhIrD4xjlXu1TIlG?=
 =?us-ascii?Q?pXUuTzQbE3Rmwjlei6T7R9wsQLk22Qn996wQ2Q+U/33zaZ8bVRbbFCen1ic4?=
 =?us-ascii?Q?NbT2GF1MZvQQ1HHY6vnlKp2mXQY6JlkyABOlpudPM1l/m6a1e13/IgeUZLrr?=
 =?us-ascii?Q?KmZV1FRlJgEMcAUDbRb7zBHeeCvGYGjbGUkUYv1tbngYaJ0Heo19+JjvUWOT?=
 =?us-ascii?Q?50tez88rv8v6NCfjPLoiMLjt7wyp4FADrUM12jS/wgUVEjHUBwRUGcyFFzUO?=
 =?us-ascii?Q?nnQREp5ez8wC/mhJOd1I4vu/nNJw9q9l1VIB4gyI7PBLA0PjuKAwH5ycdMuv?=
 =?us-ascii?Q?/Y+fISOHGFXWjcezeOF17ySvev+ik7mMozkklPpzgGtv/+3V1iOgtOihxfrl?=
 =?us-ascii?Q?TRH42jRx/9+m1caP4UvQKW/Oy9f0BcyQF+5nBYJEq9qeRdTH+VdtSqi3t79H?=
 =?us-ascii?Q?H4fRqTQeC9IIrb0YjzgOnPQiqPPBnoGCIh8BWzpqoCifkDUx5zAvA9pzJO+J?=
 =?us-ascii?Q?IKNtbdlWL/OPcNiz3tKDIhGzNEgL6cLktSchZa3FB0jUMn4ceQZ0hOF7Q42O?=
 =?us-ascii?Q?i8wT6BtJ6OirlqMtsdqcrqz4aOPtIKTJKAILAOjSRWHH5WAnK9V+EcoI88u3?=
 =?us-ascii?Q?YVJm0o0YQFZtIQ0gUwGNLOrG12I8rsFz0AyFlAusbXbgjXqaqPpVwUc3mu/3?=
 =?us-ascii?Q?B0CjuYK2ZYPp9eueeHfUK5bIDbYt33rI1lR7UnqnMyW0d1MO/q73Qxp0DIZI?=
 =?us-ascii?Q?0t3J7hdDYML01rd4y+YjNbvrRp0u+Ml+7XB0AVucyseaDDHmlTSqCaOj6teY?=
 =?us-ascii?Q?k2lTMygkImO90x3CpZeQleSP82priPoMHuxxRnLMs3rOAwa6UTrwo09Mpsxy?=
 =?us-ascii?Q?lL64TK5lLQACznkjRTKkQQkPrcHCT+M32ezJ2+SbLIN2RvJDApohGK7CSGrQ?=
 =?us-ascii?Q?MH9StxDmONGLYxPGxPVrrgE9EcjjYxGEa57is6M/wfFwBt9fZG/PUFbi+8BL?=
 =?us-ascii?Q?s+hlACwGnLGbREyIcbUNejF3ykdr2qYisREP58iTr63JhsjDf7T2AMR+QuuC?=
 =?us-ascii?Q?vRjynP791Eb4hoT3f58yO7Y5Q6Tcfl3prBW4RuiwXqCWLnoNb8ZVkMue/r3R?=
 =?us-ascii?Q?o/EcphcQAyAXrWc11FBaYaYwqekhG/R5qUOtau7wD9AteCnBvb81I4b7ea1q?=
 =?us-ascii?Q?MCgCcPQBc2lcWmRGbdlaNFEd1L7mjRtBn/aoE8o5UeiO5zvVsH/kBOMRAdnl?=
 =?us-ascii?Q?UKrfq7QNIjwf3x1CHX+xvifAGqJ8+xKpX+WPl6Yw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc899166-b703-4667-46c6-08dd97afc1b8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:28.3119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu3W248VZ1Q9rVjY/8TrEZztK1vx81GwRWWHoDnhTCXAng7p06SS6BTXyxMYUpbyC4hvE7ZY+vGmQ8XpM0mhJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Proofpoint-GUID: rgflKR5Sjdqdfbyia0_bRqJrZW5uh5k9
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a3b cx=c_pps
 a=WxcSnoYPg5jl6yrDmkeCeg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=qTvU7B1ccVJYr7cy3AMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX1XNG2AZOAHRW
 ktARYNw41C1tMvo1fKJWAHX0tbv5Jsu7Ymfo8UGt0gzcc4OQO4eoicjW+6DjZE0m6Aae6G/KSSi
 ME+n2wrXyBRuES56U7oj4UPotoiDU6PK6jZ/Mn/LuNRvoG/n+2vLfznZiUWU02/Komas2oQ3TpS
 G+WOwGYOhnQ+d6Ernza0pPSigi3yVVBS2TnKTb/K3W1KR591XpdgErjNpGPQQFVblB6sqfOraiH
 5UsTUqu80IXQ0Ou8KZUj7OhSBQ1R3pZjVQvPj9R3GNKQ3fhsZmSSRWiV1i7Hpu0BtuTTz6plish
 t5zFFpQ5QgGx6d5uq5mWrmzawoQp+ZfyoYn+Ua5K+aduZtynvHaH8SVNEqzw2OV/Eyec5/O2evF
 Fl4GcKLiKSdZQCoMB/DyVpG/dWGCDTGbopawzq4ROu4l514FUntbxvHt3j0EyjZiZyxwPIcB
X-Proofpoint-ORIG-GUID: rgflKR5Sjdqdfbyia0_bRqJrZW5uh5k9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Unlike most other messages, this is a server->client message, for when a
server wants to do "DMA"; this is slow, so normally the server has
memory directly mapped instead.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h |  13 ++++-
 hw/vfio-user/proxy.h    |   3 ++
 hw/vfio-user/pci.c      | 111 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c    |  84 ++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 4fa6d03b3f..8f589faef4 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -203,7 +203,18 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
-/*imported from struct vfio_bitmap */
+/*
+ * VFIO_USER_DMA_READ
+ * VFIO_USER_DMA_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t count;
+    char data[];
+} VFIOUserDMARW;
+
+/* imported from struct vfio_bitmap */
 typedef struct {
     uint64_t pgsize;
     uint64_t size;
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 01fed3f17d..8f2d529846 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -104,6 +104,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 VFIOUserFDs *vfio_user_getfds(int numfds);
+void vfio_user_putfds(VFIOUserMsg *msg);
 
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
@@ -112,5 +113,7 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 2c3edb7378..dff6efaaac 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -11,6 +11,7 @@
 
 #include <sys/ioctl.h>
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
@@ -82,6 +83,95 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = NULL;
 }
 
+static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
+    MemTxResult r;
+    size_t size;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    if (msg->count > proxy->max_xfer_size) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    /* switch to our own message buffer */
+    size = msg->count + sizeof(VFIOUserDMARW);
+    res = g_malloc0(size);
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    r = pci_dma_read(pdev, res->offset, &res->data, res->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
+        }
+        vfio_user_send_reply(proxy, &res->hdr, size);
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_read unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
+    }
+}
+
+static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    MemTxResult r;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    /* make sure transfer count isn't larger than the message data */
+    if (msg->count > msg->hdr.size - sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
+            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
+        } else {
+            g_free(msg);
+        }
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_write unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+    }
+}
+
 /*
  * Incoming request message callback.
  *
@@ -89,7 +179,28 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
  */
 static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
 {
+    VFIOPCIDevice *vdev = opaque;
+    VFIOUserHdr *hdr = msg->hdr;
+
+    /* no incoming PCI requests pass FDs */
+    if (msg->fds != NULL) {
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, EINVAL);
+        vfio_user_putfds(msg);
+        return;
+    }
 
+    switch (hdr->command) {
+    case VFIO_USER_DMA_READ:
+        vfio_user_dma_read(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    case VFIO_USER_DMA_WRITE:
+        vfio_user_dma_write(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    default:
+        error_printf("vfio_user_pci_process_req unknown cmd %d\n",
+                     hdr->command);
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, ENOSYS);
+    }
 }
 
 /*
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 6d1446c38b..0935b72e9f 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -362,6 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy)
         *msg->hdr = hdr;
         data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
+            error_setg(&local_err, "vfio_user_recv request larger than max");
+            goto err;
+        }
         buf = g_malloc0(hdr.size);
         memcpy(buf, &hdr, sizeof(hdr));
         data = buf + sizeof(hdr);
@@ -676,6 +680,33 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * async send - msg can be queued, but will be freed when sent
+ */
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (!(hdr->flags & (VFIO_USER_NO_REPLY | VFIO_USER_REPLY))) {
+        error_printf("vfio_user_send_async on sync message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
 void vfio_user_wait_reqs(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *msg;
@@ -720,6 +751,59 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * Reply to an incoming request.
+ */
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size)
+{
+
+    if (size < sizeof(VFIOUserHdr)) {
+        error_printf("vfio_user_send_reply - size too small\n");
+        g_free(hdr);
+        return;
+    }
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->size = size;
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Send an error reply to an incoming request.
+ */
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
+{
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = error;
+    hdr->size = sizeof(*hdr);
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds = msg->fds;
+    int i;
+
+    for (i = 0; i < fds->recv_fds; i++) {
+        close(fds->fds[i]);
+    }
+    g_free(fds);
+    msg->fds = NULL;
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


