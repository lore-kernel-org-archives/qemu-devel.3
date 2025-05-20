Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6E9C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOXC-0003pG-LF; Tue, 20 May 2025 11:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXA-0003kj-Py
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX8-0002m8-T7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K74Jhq000844;
 Tue, 20 May 2025 08:05:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3nMmWr81L5jTkiobhbr8tnbtIlHsHImQiRCLOufse
 c8=; b=pqSxQK8cVlo1icL3bGl6oeARPm/0GytBaIoyqWLmWbed/Uu9BYXjLonRR
 W9YsKm4abEgVys9e2urWmWKtvPTt9atTIBUUCq+WCHiHJHAsmQSsGNmqzqEmVMiK
 UODe+m0UYYL5oCN6sOGqxUhibeX0A0Csnx46ZTsS69sGKNNw/nxqyj8411YMEUdd
 0czGYle5WqMdXlBjvodZkdKG0wmzE142FUdVCHtce01H8iClzCvp5ZTor3gScRIz
 bmOw5oyxVHIkf6RTf0qvZJnAW/mDoXYmoioKteeNgV3AUc6QOCuBY6rnJBV8Dxxz
 VDXq29C5nmB8PopKLsgG6kn/VSpkA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhec0g-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr8Gx6Hsk8ewTrpnyCG7IgsyUkSHdd03kJYVILqgA9ggpYGf+vdtTsnMZyENkxECGQNkIVBrRjtHpLNj7gk8GDHD8etjIxn2Qjn4GSK0eyB8sQWr178tYmtec1QPUG4sOI+sFECqcAJE0dbBKgIG7Z5OgiPxWiMj/d6wRZx+yuhFdljoABbTAq3otK/5lO6So9NQ+54JTFM6sqCsWaGznmdkxx4dCiewdxAniX92OyqWfR5l8FMmWHxDYu4hBq3AXkNWWNcnqJ/jhEXdc/85DmhBdklK3kMNIJemJbVXjdS+ajNl+bxazFG5RuOwcfw+c5Dz9BSEVuPey21QSrCO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nMmWr81L5jTkiobhbr8tnbtIlHsHImQiRCLOufsec8=;
 b=ccXUdXRG6pKzqiRN83/q55sK9R6aCE64yXxv/bAveRQ0Tvz1CP4VRUSCEv7mzAnDTrIIydeGPMKZHOMTnn8EOx693u0USUP3Ld1y+TxUAhEsq9LSY834i1q35t0BuDfyAJpT/AI/vLxigOG/o1KMbcwJWz3SZxg1gOy2ouQ67YsXmgsqNq2yaHxiT4jOLL0iYyqfRVOyoLCjyxLnFG5mr6IbdWC5dgiVlwWp/QxeHaNtZUd4F5SC1x1Y96sFHrlEvL0CysTBZIie8fU2P21VsD5Od3tRIFrB9ZcsbtJMVKNBF4pwuKNApLlP9jofJ0FSZEs3+UHH7GA3B7KrRIXUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nMmWr81L5jTkiobhbr8tnbtIlHsHImQiRCLOufsec8=;
 b=pfacO47QejQ27sjhyTiod+8hgk5jm6UZmjpK4aMkI5OdpTLKVsjL8sbdoD6XAm58jMuE18Rc0PtpVy27irh4/If6XQNiQylM83ATfqjv05VsXfmgQzpah5GFhPkEHmLvivM3ckU6Zu3dizvgiKEGMjD0HEWbBNPXRcnhgCX1/oVs68CaSC/kAqugKYscUc3vCzLbdAw4Z3sS2qhgPPT5nxHFuRPWDTj5nxxTHRD6M/WrGig53IDtAQPCVVbhiq5KWVmr0bD3LZh+ip/CLxL++zTyeYG0KgVVZGMKkV7nvhzT1ZlSD9M4GHItseOWmQsqi5gpoSVc1XXyLq5h0S5aDA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:31 +0000
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
Subject: [PATCH v2 26/29] vfio-user: add 'x-msg-timeout' option
Date: Tue, 20 May 2025 16:04:15 +0100
Message-ID: <20250520150419.2172078-27-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ffccbec-ea0d-4080-10de-08dd97afc342
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yFAVnB0zHR/BdhnmuHc6JFVNnV4DaxiGPzpL1L3eMWLSKKf1IDzgLkBxGV8E?=
 =?us-ascii?Q?LADXWtlgSKqyOl3PcIHvId86HguV4ZSMfhyT6UqyBjyKHpYFlnjmK+iUJtSB?=
 =?us-ascii?Q?3pOxz1ZSzFIGiD4ye/lvpKll1FWN8Fws79putHoH8qC9vfLkBIiqPCb1GBFK?=
 =?us-ascii?Q?j3JC80aKo3QhfT6VX2r505MXz7H2UGmS4WmTU3NVb9+Sypswa9ob7y44SXpJ?=
 =?us-ascii?Q?RMSZDVV/atBhnM1Ae68Ty1362NpzfBCLw+V5p+6unV6aPDxq2i7nlczfxTRo?=
 =?us-ascii?Q?SZ7ZeUxX8MiV9KyKt/roVeK+qI4VMlJnYg73+y/aZFlal2/kNQ/ia4sAzh+Y?=
 =?us-ascii?Q?mahODIg+fQ1uZiufzYLbe0OiT2WGVyUa3JeU5+a9re/U9er5LPP5Nyfh3v6T?=
 =?us-ascii?Q?vZz6GeUFnBfnkSuiVhBr5p5nRDN0MEWN6ajqVyEYJoIF3SNjHlr2Cw6X+en3?=
 =?us-ascii?Q?YVIfdTMH5pT4Uh3SI5EiaxLquDjPMUfWAjzoVyOCH21/k5vxu+IJY+ig0psK?=
 =?us-ascii?Q?ckfJyrMCrPY1uu3cMOgpI5WjkQZ+RjNntq9KhOk52pVE0PK3ficaZMOj9pTp?=
 =?us-ascii?Q?Me0bU9lMTZL8g60AYDeqnjwgqigeoCiCFE24eiJfVN5eitoaWfrUXSBW8FhW?=
 =?us-ascii?Q?nYxuENY98mQGTl6DPuTpRF41I7IFZWclPmM7DvU5QF0OrJnq+2MJ1nM6PtZ7?=
 =?us-ascii?Q?5mFxG9ntQUbwl/YJaljBSwb6XIAt1brLiwWXt7wXkbrg1tYIJescFDnTNVTL?=
 =?us-ascii?Q?2CTvl54T2u2l0GxEV+Tr+9rRPbgsnj+nOofOyJlRdHaRC94aLVytjJ7F8lON?=
 =?us-ascii?Q?CQ6JPuUjgVLPPnQouKRPpTONgjua0mQT3wkbYqLB0k8U8fzH2K1ko+DChACp?=
 =?us-ascii?Q?+fcy6s5HP1aqU7/z3hQckOZcBvrvFDPZCoGYPyNl4OD1DOlGkQBOFKZITkKw?=
 =?us-ascii?Q?J00Pn5ESSc6w6uNkKMUzEaFx4DJ/+9JDbzKd1GD5Sdbx4iBuiyjMTV41EKK4?=
 =?us-ascii?Q?HxTzmRiRIOokXDlAg26QrdODFMFBIciooSGJe2Z5Tu1FRWA4YmOaP0aBcDwL?=
 =?us-ascii?Q?BNXHyy2tR+vAEhjZ4DCsdz/5Sou8YIXPL7W8ttZjSPzgJuJFHyoYT/4YPilh?=
 =?us-ascii?Q?WOalbVT4I3nwTlrXI7wZJbUQ8NIu1rHl9dCxS9tWtBZipcLFdV8GBgNM+klj?=
 =?us-ascii?Q?zjchU6YINSUg92JHbZMCS9Bf26g8cddt0J4eh2U1vfwfCyp2dZRfrSQihNUM?=
 =?us-ascii?Q?tveZgvq8Vp9s4ndOMVMlEsJhZDqRWOLF0m/wL5YYkb+qJkCmLWh9MpYpvrIG?=
 =?us-ascii?Q?N5XPW32cOcxmsJ/hxYvwpf4Mwuvr7ns2yvk6jnGApiVgHxaE549AJy2E6yjP?=
 =?us-ascii?Q?YD95FUoe3lEJ79ypd21Ow1Xfi4v99DBc1s4XeGZtmJdYW8mo0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FrW3+lVAdUUsdsj+CM61ZmcP3C2v7SIMpH4xM35ZBMsFoQk6gCKfUX08hkHw?=
 =?us-ascii?Q?/Fvlp3KHoG74mNVDJsGXM4Kq5hzTX2KKljYIu0JzNld/KCM3iAiXkY7b8KRC?=
 =?us-ascii?Q?e9lRoM8lre0+DoX8rX2I7VDqksdF/+ejqlRQ5N80p4sMJMAyot+ZtnpFJVf1?=
 =?us-ascii?Q?FS9FRghhxLeoeyg9GgDe9UyIw2fFe1CnA6e33+/3mm8XR93raPvRjYyQn3Dh?=
 =?us-ascii?Q?WEI2TLAVq1fiirt6fld1TbTMEw29QoHWlcLbdpzKrKspryrBH27Ps+7oLY3f?=
 =?us-ascii?Q?Ch8BClG6BdZGDNU5Jt0TWYZm7HLodDISjBnk95Xb1+f4sJ3IE6qc31+BiorJ?=
 =?us-ascii?Q?NcHaCde/puBUFrdHeladOZOpcD3eqezmElFXosNKC1Ut2iCwhsFCmWwrPsdk?=
 =?us-ascii?Q?o+SK+i9vJU6KEeuC+SXdpTM9YkEFAO8E2mnFjErSUXDeLgDip/LVESCI35/4?=
 =?us-ascii?Q?C3wLpDkqRdmzFyomsDXd19mM7XF4muhG8qH6i4BafFMFB63+oGakhnJYL6gq?=
 =?us-ascii?Q?HfLm//akodgre6tWrZP4/zJd33NnViyiSU9EaCb5RSNqmtRCjM6OItvuSoVH?=
 =?us-ascii?Q?WWfmdzfUAQGmCj5LkadrasET95ntGMsJSi8o5WYAFuMVxJeMOkKEbkzdnae7?=
 =?us-ascii?Q?z5oaTwRmtWy7DnyHvMlCGqyxcGtVoZCV9h91CCDDMKdBN5aqJ/gnqDyRVO6g?=
 =?us-ascii?Q?20IyCLhLT1yFSRQul7baS6SgwSBqvJVMZzFfhj292GQqtYngiBmxrdydPm2C?=
 =?us-ascii?Q?stpuS5FveilSpUn+AO0fsP7StrzugMhYsqk9czuKAdrscOrqyKD29QR7ZdbK?=
 =?us-ascii?Q?jjijCBgFCziXl2/7+GarzbC6mMs/bWe/FXRc2NjruO2cgQbUWys5vnckGiqH?=
 =?us-ascii?Q?b3zKLNPMCgSgoW344ZGHYc6URR7ZGH8qXqvLcPR03pb6EZiHApXpVF68i9Q6?=
 =?us-ascii?Q?NyUa9WN5zxI/MBQ7UNsyDvPm35JXPeX4BuTK6KdcL8JpS3L7vNKy1r+P1Q8r?=
 =?us-ascii?Q?TvLyjuafjRTkhihV8CDVrmSTtp+9KGdlFDwZaq9ndUiKFN/4BeV1cJK9zhL9?=
 =?us-ascii?Q?54qeKMtjpf90b8eom+2xKMa9f9eK/nA5bPTVOZVsJhFjbOSgyL3OvXg/JThR?=
 =?us-ascii?Q?CVRPj9Gl7wrK0ML9Pmygu9e8tL3fjWqIaoGntQzf36xkxMCfSmk0qOfFl3bP?=
 =?us-ascii?Q?MIDn2aRUv4YMw2u0VHxN0NdLdTx4EiuNgKyUOtWLcHZS4dvNkQGz8ppUzcVi?=
 =?us-ascii?Q?AVDfCqJ2rrHb3al9cpyTy65d5mRo0BW8CaFZHT6Q0gzSaTM0WB8Eyj/J5jHV?=
 =?us-ascii?Q?GG5HnyUTw4PNuUGDxtQE6dX/Nsg2eAEKSIaDNyzEsTPQ/OWdPxiWQ7bJojEh?=
 =?us-ascii?Q?C1EPjYPfcwUOHa59/egTGL/OlzrtzoaH5q6D7eIGCLi9G0Y/aVr3nr4z5MCH?=
 =?us-ascii?Q?8Pd6cYJmaMAec9zjnr4vb/b/c8KArsZMfVnMQ9nUFyf8ZJSTzy3XhDRDhNiv?=
 =?us-ascii?Q?5LrExfOIIUeVmXyraPgUnGtUkS0QWtVQZL6U1hWvOCOYTUlk9NEz19KpA3EF?=
 =?us-ascii?Q?qIkE2pCOo3j/gE8DDxyAhKGoJN4dIUx46A+NpYzu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffccbec-ea0d-4080-10de-08dd97afc342
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:30.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/UPv8XjhS/ntHapQZ+v3gqfW5usb1m0/LT6ZkFkpYblWMeHKMfSUiW0an3GJH47bNaPmzSNuxW2kHZ1ubJGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Proofpoint-GUID: VPy4D6OAPiCxJJZn5b2hftSUk-jvD7pT
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a3c cx=c_pps
 a=WxcSnoYPg5jl6yrDmkeCeg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Ql6ANm6PklPDYutWWPYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX4v+TVh1Qzc4E
 dqZ0+clwnq0LHf4+d8Y6atERmIbvehgmfyrxppaHWd/tpkc2SQxROH6pEQAUVU013uD2suO96cO
 9C/fipUoKr9MFsQj23d043Fke0vQpUcC3o16mwPRvaFegT0AzUThlJwNe6fz5SV/dC0wP+2AcsE
 qh386epXZr3rCLFpXAYhWfnXeS7TBSMHLLze92We/NQsErVlKe59wwjWL/etHYr96ueggobd5FB
 XJc8OsO/8oXj8JDaJyCDUfxXGoTm88fdExz3h3lPU4xZ2y7Ozs6Fl2QfARb/AD37sAHLYZdQYzZ
 uLIDHdhuRL7uCTtqiz/OVHtweeNLAwJl+ZZjgHYzEl6Lfla43cZ3dECGht8pQjXRxOI8viV7BmL
 NvT0xT9/RVsfZzBbrfDy7+bQ2e4hkJpwI8dxEIdFgTErBuKJg/O+ZngC7CC5kuTvlV4y1Afg
X-Proofpoint-ORIG-GUID: VPy4D6OAPiCxJJZn5b2hftSUk-jvD7pT
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

By default, the vfio-user subsystem will wait 5 seconds for a message
reply from the server. Add an option to allow this to be configurable.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h | 1 +
 hw/vfio-user/pci.c   | 5 +++++
 hw/vfio-user/proxy.c | 7 ++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 8f2d529846..da29674fdc 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -70,6 +70,7 @@ typedef struct VFIOUserProxy {
     uint64_t max_bitmap;
     uint64_t migr_pgsize;
     int flags;
+    uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index dff6efaaac..e89400ba03 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -25,6 +25,7 @@ struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
     bool send_queued;   /* all sends are queued */
+    uint32_t wait_time; /* timeout for message replies */
 };
 
 /*
@@ -254,6 +255,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    /* user specified or 5 sec default */
+    proxy->wait_time = udev->wait_time;
+
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
     }
@@ -387,6 +391,7 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
+    DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0935b72e9f..74cfaff6fa 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -24,7 +24,6 @@
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
-static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -665,7 +664,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     if (ret == 0) {
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
@@ -725,7 +725,8 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
-- 
2.43.0


