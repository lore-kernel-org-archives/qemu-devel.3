Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E0DFEFB4F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyBE-0000ue-67; Fri, 27 Feb 2026 08:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyBA-0000sj-Ju
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyB7-0004Uv-Ih
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:52 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RBGx4D2070845; Fri, 27 Feb 2026 05:46:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QsgXhvj0LcR2O1WqfF9Wwq4ik6DrsqEFXy1//mhfJ
 H0=; b=JWCtJZaTAXk7NivQg7hhWWjlo4V3Yb/W4hxBi/ps5RhNfFWvZp4T/S4bF
 h8CWpPJXipDNYsEEtl64wUsn8QjCgiEw0C7kmOtCDVCaO+pgTYd16runYp+t3W3o
 SsvHFeGsESCxZ0XIcT3VkmfKDZ4+FMFxGb9x9bxMHRImEDVLitUItIl8YDX+36xM
 9lgR71oI7nezPzN4rxK+bMgf6lRtqbFO5qdA3uRdWNXzGZQ2Bye8ntpBru2gxNpT
 bVw6y3BhV3oNcuVKpSBgJGSBhhtWXtUlUVczlEwBzSHqJzEZkdpcuNLLf+8XTJs3
 KJlxYW88VRQL3JTjICIAJKdhEBagA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022119.outbound.protection.outlook.com [52.101.43.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ck0frsfxf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 05:46:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IphTAC9bTVhw8AtHaB/I4yIdkdLfzwrXQSCrjVF58/6QXavbJlewN3uDoNrw1mpoFZW1nPHlVUmtDuAo/hWSgeW4/D4poss55RcginFh1phXiRba+J6x+lnQZuAseUG1BSTTIazNoR9BMvO4IZhe7F+UDZbg3uHpZ0+QqAnYvyiZfTQ2OZXpiFFvqW8v1Ekst4a7E8GXGTOoB3sJCJoGDY7wvVB+gSlRoKD9aTWYzEBkxyroIAMQhTbJEEF4XR6P1I6wtNn30M8jxsPazJY+kNZFYtBbzEhWtqOvUygZhSsrBB6WHJ0DTJJIW/KtcsTIIivPNSFlH40owwg/qoi6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsgXhvj0LcR2O1WqfF9Wwq4ik6DrsqEFXy1//mhfJH0=;
 b=iJlOKPVopKKM0E1nn9ExvUnPiAC/wMY/mZhiN+j4KsJmQre/N3f0AY/zeQGbf7Z76725+ZcBqpZt/W0X6L33CFVjd13QQjE+wzb+gSZ9A2CW0rFtHK9iKfto8CS521vvyD/CGfLeDHKJ0zWpm0vX32c6XnFzXQeFwtVS5xpJeX3T+jL2ESLFFAsDl2eZPmO3Rys5w2q1oiU0YGku4Luu/xlC22y6p13q3I4B2Bje5yn8hHbmn1EsqFlWjyYLV0rckQXZB04ftUuBvvY5R3fLk0fl+KqgggP8tekxWjxX5n+n+lYLJncP1AUVpEwCqTWcXBZeGW9WlRHkYIgTWqCW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsgXhvj0LcR2O1WqfF9Wwq4ik6DrsqEFXy1//mhfJH0=;
 b=mo6EuaLFGqfAiHfghORF9rq4GzVY9GEcYpfYle66e4VyG96msUA7c0w9csBKJOWLIsbycXMAT8l8ptpw6G7JA7wwDGEeMXsWdLFOgmn5cUxn7RXwbbxFV8juXMcgkD20OJu9VC8k2Xmads1h4CFcfxJo4EPk1ThEYyxSIeBYTlaGTIhZNJXvHWMER37sc72HtczLnVEwoFeSoFoO9dFNlIy1WPrdzSss8irOzObl3vUOETZR6teKLxonJdMI7xV9sLrn3GTUj+69t1xWtE+1nGC2nbkKX+bE7DiEmuTL8j0JvesNlocVg3z1t7S9TbIGYSDdkIo1l8CaD2IuNJlUTQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11277.namprd02.prod.outlook.com (2603:10b6:408:354::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:46:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:46:39 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 5/5] tests: data: update x86 ACPI tables
Date: Fri, 27 Feb 2026 13:44:59 +0000
Message-ID: <20260227134611.1229390-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:610:e5::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11277:EE_
X-MS-Office365-Filtering-Correlation-Id: ea339f72-72e7-4d85-8412-08de7606a1ae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: sXEy6rz2tppqwoeQDLAeys37WmkTZYXV+ndVkms86SLai7desV2SOnGJvHlVsLlBv9l7FcL8zQ58jf5nY37NYj1udJ/fGgCNDE0KugwI3uFtjuoI17Z4UTwExqhQ5sbGLbEE7cgw2giq7LiVW8ILWuYGaJm3d99lDDmqijjRh5xNjU+2z0ewLqJpAmE8aJSsc8tqvLvq3gFIB10U1GTjyBoPHoCyOZJUFaU65p6pSYNpuz7IxdDA5imiOZ0M2eUeoCjdgcx3JhdBnnBzfMoTigiTe60iKHCqfhYThNd2cmauaE9SlQ56ygezxZR20jGO282mRqevoWzLZYy6KEJehkj2M/88SrwZrR0EVk2LzZZMEvB57ppvurblUPkvEDZ4BXtkR/N533GBgeI8NMf5ocJHjfFw/XzXQTwY9jSECgD4cuIF+5MSSUIyODmibaWiTYjcU3qbBPhpKYUqhNMwV4o9Z6+PkzCEqxeZfSD1jcoBp4PqpoOgL+liSWX6Ig6V9ZabRs1n+5mWuGPsbZd9ilaNlKrs4UgrzLkyzLu1aGmy2WgPUT+VxcqwAt9L3r9j+qzF/rLrnF/x1cbrs5S832ccrwErRngbBZO484aq+cqgbZWe+gjZxN0gEZRAzvBEWOpogwHTxjqXlEpLa35gz219eCgrDkyDnNNNT1jc9xkDsuq+GxSD/ZhKgaBsIP6rvEn3JB6d+Ec8dKzhIy80qpzKaZ/tELSL3hbvkGIwvFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RuHdfEQUTTugtXVhvR8LRdK9G/OArmldgYqdux4iBw/EJ/2T34TkiS+NOUlY?=
 =?us-ascii?Q?I4LDw8d26tuD1R5owYfBzWj4IlDOLyCJYqwPJTsS+IoUi73/49Qo5ijUkhCV?=
 =?us-ascii?Q?lYqjBE5YAVZ+1gcfbrtsMUjNVpWsEaC3NwXTsKVJdL9QVUsbzXQghFNQjyBr?=
 =?us-ascii?Q?j1jFzhSywgoEmCDpaopcAaqkMaxl4VsyAQfu85JYoKp5dGQSQLj6Iz7kntmi?=
 =?us-ascii?Q?owHIyqjW7xOix/hU6MB+BBoik5oZYY/tndvCm+9XqY3kXBIpW8GIodJeJHBQ?=
 =?us-ascii?Q?/v7x7Ru5ME8woNoZNAS0wpzSR8Awki99y4Mi1e6FymwY7cMldjsXQ5jzCxK5?=
 =?us-ascii?Q?jqGX+IneC/Yq7tEF56UhwqEwu8ZVfJmnFeVvQ7CiCw6ufEE18oPCVfKmZWz6?=
 =?us-ascii?Q?8IeODghiUoRXzHIenxRfOO3QfAY9VeAUJuzxa2ULOGefI1FcXhRQWqHeJNdb?=
 =?us-ascii?Q?XR6AeoMcFtVJius3TGtmi9ZdS6TmO1cIiIUQqWhjupBNTjFbti7ZwRy+Wr6j?=
 =?us-ascii?Q?dt046cQCYTIrNQBhGvYBY17TOy0r3mhmaJlLnPxQvpkuh49bLM6q3nkFgAQA?=
 =?us-ascii?Q?3QRWPB0qml9JYGUg0f7gzD//PVE6Tk8Do7VaBH/NHwzf75ptdSN0xxA8d/fa?=
 =?us-ascii?Q?Jh06odrsspZZw2RY9TfrXSE1snNaNwc5fwgB/rD7SNOhEZ7uqJWzWmOrpMDu?=
 =?us-ascii?Q?0fn2YppGahzuiSeSWjcI9l/IFnr8Ygba0Xp35wtH7IPvrXipKbm+xT0auCpZ?=
 =?us-ascii?Q?XaovyUnBAdHv0MTZ/yGrkFjbaInA7xJnudGFMDQUA1PBn6kC1fGTH8kVNphw?=
 =?us-ascii?Q?huK+w728SDhzr+3CshnYW/N6LfzxIxyl2d1dNWUO6R8rasMlIOOY0FpkYAei?=
 =?us-ascii?Q?Og7au/t8znUPK+Eq50Z2j3q+y4LFgqb42YsLR8NW7RQ+VoORm9o2O8x+F/J6?=
 =?us-ascii?Q?EJxaG28t2EuVncyDJ99p2EbzCKK9g5zjHCX7B119ajgts3Wro+i5BTQSe8YW?=
 =?us-ascii?Q?BIc5r8TtpmaIkSBYfgCJ8ae/QSZZ9gFUvHS0AhAum1KNFF7Xeinq2Q/puTY5?=
 =?us-ascii?Q?nxJ5epVGuj+uAOAISujkN8esk9vIkF4Qdx51iE2OYoDlmtJNiJM5samDG7rh?=
 =?us-ascii?Q?dL0bIhEsdlqMlGv+VszXhfzq5iL89XvUSwtWgHgH5Ixi/xAR7UX3Pu/uu8FM?=
 =?us-ascii?Q?pX1qeank5KLXZJyGRS8MjbPgfIr2id4JR2iPN/YQv2c23DQ9jdfhM2+uqwXn?=
 =?us-ascii?Q?GpPH/Ep/F3n25FfjRn6cm1RbTADY2MsMLPbmA7fnE+4r4doaZom2F6cZKeQ5?=
 =?us-ascii?Q?k+WDM+O7T596BW6xHP5Oyt6keZnOkYNQP6Se/VpH7F6f5Ie4WgsnyRjLK63v?=
 =?us-ascii?Q?1ZT/X8CAR3dJBgyHCYlH+H2ieGLWYNGnY368FFBYZsCbI2hACrNL/oLYnnLq?=
 =?us-ascii?Q?FTLA7mLt28tvogU02bRnFUkJ644FLiSQHiw0oOss50zDzw7iqvQbHHJgst8v?=
 =?us-ascii?Q?wQjh/spXzPDvjPmigy2U2St8zx/IwNBl7J/gcdo7Zad5x9R2iBnqYsVYfDgS?=
 =?us-ascii?Q?StbCM5+/uro0vNDf/4sxUX8pNA7GBAj/HWQGb5pObylJAPPKRpPgJCb8hqXj?=
 =?us-ascii?Q?GPntsPRDTglddAyBEBcNsqnmBKI7I6N2qqJ1xqOTkpz8YULexaavVsx6s4kY?=
 =?us-ascii?Q?DjQuGxb7EbUMsXUvDDruwYWZkTAbkj/9bBiSEQiCXFEl/aZZP8HIRp3e649v?=
 =?us-ascii?Q?2JHxtgharp0AoaB9GHqNwNfWXdiFO4c=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea339f72-72e7-4d85-8412-08de7606a1ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:46:39.2415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED1ktsy/6r4/mBpi08Ezcgw0Evy0Pbi8xv1gs7u11yMHwKbcpu1uPhw7Xzmb5+ooUmypm4DOoQSh663QLU1h6G8DVWx/t1G7vHKuQ5rDpnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11277
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMiBTYWx0ZWRfX1G6YPgay5UFF
 vrgGnuT8pBS7aqsv7hZ/feoWuMnQpyogZv+2Kt5Yp4P3e1tZGq/y+7fx4IwOG5S8ealQwrVCPMk
 Es2RrS27svTSbLr59wnFBKkPqasQHbG4uGbPOsUq4Beni60Y+95fS4zmdcT+KIt3uRtp66mkDKa
 5nssqoYhwNlnShwvKklBeFb10mrzQ5rrxlq1sqU0LBZn1A42nWxiPma1f3FZwKGphh66D9vD+YB
 f/8pKaFANV+3RyEfl1thYcVnc2vpceYhodwWM2RM6YFJR9hvUnciBxKKa3DZ2zLrr8IuwYTS3iZ
 zoxCBUhW89c9MxTO7gPlZh61xTXgz/hnjuS2nvTEPHv550yc6RVEUWVYSbWOuSb1vSRteasniaL
 j7A0TgwIsqjF1TR32FEr/1PEAdZyVR6+rDD02r4y47MnkWhs5uic65Zzvx7l+w650QUdnA+PoDS
 nLISgSWhjYZdDB1CmWw==
X-Proofpoint-ORIG-GUID: eEkcc1gHeHAHXZaHQKiMct1Qq9EB5VoH
X-Proofpoint-GUID: eEkcc1gHeHAHXZaHQKiMct1Qq9EB5VoH
X-Authority-Analysis: v=2.4 cv=K9Qv3iWI c=1 sm=1 tr=0 ts=69a1a047 cx=c_pps
 a=ONh++nyoOH37ENyuzPCuVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=63R55MxTaJgPCwsbe4UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update the x86 ACPI tables to reflect the IRQ descriptor changes for ISA serial
ports:

                 Device (COM1)
                 {
                     Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                     Name (_UID, One)  // _UID: Unique ID
                     Name (_STA, 0x0F)  // _STA: Status
                     Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                     {
                         IO (Decode16,
                             0x03F8,             // Range Minimum
                             0x03F8,             // Range Maximum
                             0x00,               // Alignment
                             0x08,               // Length
                             )
-                        IRQNoFlags ()
+                        IRQ (Edge, ActiveLow, Shared, )
                             {4}
                     })
+                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+                    {
+                        StartDependentFn (0x00, 0x00)
+                        {
+                            IO (Decode16,
+                                0x03F8,             // Range Minimum
+                                0x03F8,             // Range Maximum
+                                0x00,               // Alignment
+                                0x08,               // Length
+                                )
+                            IRQ (Edge, ActiveLow, Shared, )
+                                {4}
+                        }
+                        EndDependentFn ()
+                    })
                 }

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  47 ------------------
 tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 393 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 393 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 3013 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 432 bytes
 tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 442 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8626 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8537 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9951 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15497 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9090 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10280 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8577 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5115 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8698 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9985 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8484 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8632 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12419 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8455 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8472 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9780 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12665 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8734 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8501 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12068 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 13013 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33870 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8919 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13246 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10109 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8530 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8543 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8472 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9814 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9585 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13308 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8317 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8313 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8461 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8556 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 13013 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33870 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9061 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9087 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18689 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14712 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35818 bytes
 48 files changed, 47 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index cef44135bc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,48 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.noacpihp",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.xapic",
-"tests/data/acpi/x86/microvm/DSDT",
-"tests/data/acpi/x86/microvm/DSDT.usb",
-"tests/data/acpi/x86/microvm/DSDT.rtc",
-"tests/data/acpi/x86/microvm/DSDT.ioapic2",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
diff --git a/tests/data/acpi/x86/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
index f477668f2ee80241e47b340ad4a30f5480df2049..00de0ad89cd77d5316a0d483233256d51cb6113e 100644
GIT binary patch
delta 75
zcmaFM)XB`{66_Mv$;iOKw0a_!G?TOFM0GPJKbDDcikgC4eC~`tn13)ca3~8fNLDg%
V#0LZg3yN?F8ZsbDSWN7F004}M5kLR{

delta 47
zcmeBVe#^w=66_L^%gDgMBsh^vn#o;wqPiKQ(ZqN~J^?OXcg7#gKbRRflmr+iu6zIh
D{Fn<t

diff --git a/tests/data/acpi/x86/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
index e5924a49962e0cff4228bcfc77ebcf48cb4a2219..1a8511fff04b2aa7a7d603e0c44c9eec96deeb1a 100644
GIT binary patch
delta 75
zcmaFM)XB`{66_Mv$;iOKlsb`1n#oyoqPiKAAIrozMNL62K6l0+%s-eJIFtn#Br6#>
V;sb($1x2_74H=LnEGG6o004X25c&WB

delta 47
zcmeBVe#^w=66_L^%gDgMbb2C}G?TmVM0GPpqlxi~d;(m&?u<W}e=sv}C<!o3T=@V1
D6rl_I

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index b646a05551c1ed902413a462442346ce246f8675..4e74e11087671b5e9a683d100e0289d758aeaa9a 100644
GIT binary patch
delta 76
zcmZ1}epH;xCD<k8C^rKGQ}aYFX(s<26V=U_{8%Q&DQXIG@wqepVE)0(z@aR_AX&-4
W5g!l~EGWVyXvlypVX?7Sh8qCXyAhQD

delta 48
zcmX>qzEYgaCD<ioB{u^D(~pT<(oD|VC#st<8cmE><P+fHb!Ys+{DYZ+LrH*P<4PHB
E07x1PmH+?%

diff --git a/tests/data/acpi/x86/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
index e375473b5f033d374dd2a64a9f814fd16c3e262f..a5ac3ded5fd05301beeeca5962457eba121879b3 100644
GIT binary patch
delta 76
zcmbQjyn&g^CD<io10w?iQ{_Z1X(li6iRxxdek>E?6g368_}m$PF#lj?;7}G|kgR0j
Whz|$~78KzUG-N=Qu-Mqk&IkaF)euzx

delta 48
zcmdnMJcXIdCD<io3L^sp)BTBD(oBA$6V=TajV8t`@(FP9x-<S@{=v+^p(MbtaV0w=
E03e17RsaA1

diff --git a/tests/data/acpi/x86/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
index d63fd84620a2689120b32262f964e6a098d71632..d6d5767a328da92135c8b3b29fd21741c043c088 100644
GIT binary patch
delta 76
zcmbQoyo;I3CD<io7b61$)9#5}(o8NA6V=U_{8%Q&DQXIG@wqepVE)0(z@aR_AX&-4
W5g!l~EGWVyXvlypVX?7SkP!f-K@hqC

delta 48
zcmdnRJdc^nCD<io9wP$-lj1}!X(kV`iRxyIMib)|`2@Il-5Gx{|6pd|P!eF+xKfZ2
E01N&Ky8r+H

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 6ea2d36d138daffb59a8636759078500adc58f24..6ae57a6612442d3125fcc9564a311f9570ce8cdb 100644
GIT binary patch
delta 110
zcmbQ{yvdo%CD<iolOh8HW7|fq?LzXdFJj_@o#F+2p9eU58bmj72OAi~bHqEk1TjQ6
zImvE*AQa8W<i|4EMnq9lkc-cq@dxt{W(E#r0S3uR29EfEpkP4}E<r;EWC@GS*&^D!
E0NXtrTmS$7

delta 82
zcmdnwJk6QQCD<ionj!-O<M)kR+lAykpT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
ma+BWtKq#7#(P*-*h$5c=7q2_x59S}t3>-=V44d0Uw0Qw09T!~y

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index d8c173aa613f51b1c76ea7b9dee19e899cba240d..4702f2bd9024b057b4f664d9a6a661c0fb1b90bb 100644
GIT binary patch
delta 110
zcmdn%bkm8;CD<h-Qjvjy@!UqP?LzWCk7DA3o#F*t9tAji8bmj72OAi~bHqEk1TjQ6
zImvE*AQa8W<i|4EMnq9lkc-cq@dxt{W(E#r0S3uR29EfEpkP4}E<r;EWC@GS*&>&C
E0PwUOFaQ7m

delta 82
zcmccVwAYEtCD<jzR*`{$(S9S>b|HC(hcWTNPVoXB4+5M$4WgU4gAEMgIpQ5%f*7Kk
m+@v=@5Q=7GG@5KHqR1z}#p}-agZT$D1Ba3T!{&C8OFRJb1s5>@

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index ba363d6af76af728b7c88bbaf47f7e0ea3dcb41f..3b5fe4b3500884ba70b37575bd3d8523c9055f11 100644
GIT binary patch
delta 110
zcmX@?d*7GKCD<k8z8V7qqw_|tC*tz1FJj_@o#F+2p9eU58bmj72OAi~bHqEk1TjQ6
zImvG3m563!@?)8tDXFL_$i?T*_=EWeGXsaR0E1*D14n#7P_Uo~m!Kg7vV_Iv8Isz(
E0P@2ef&c&j

delta 82
zcmccbd)SxDCD<k8uo?pc<CcwFPsHUtpT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
ma+BW7D-q4eXf!!XQjt%9i`Sj;2lEeR1`Z_whRs_fwRr(QB^QGL

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index b68302363cb24181988d6e3dceb04a0946838d5e..9410b0b379e62f38fd85120efdb50eada6f20685 100644
GIT binary patch
delta 111
zcmaD`(OJpm66_MvX~V$4xOgMib|J;iex{iCV5fM2hJL01XHSFZChlMZgLsa3N0%Um
z=q4xG&5wkl8JYZ8CfkW9Y6^1kxikJ?{=v+^p)9~4S;@c=9}pBQD8eOZ$bc+iu{c*m
F0{{nT9JT-e

delta 83
zcmeCId|Scg66_L^Ys0|6$hwhhyO3gUFH=l>uv5H1OD|J^v!_9H6L+wIK|Dviqe~D&
nbd#I(=0`%&jEqK;?L`#%1h{zJ8GkVUU}oS@5@1-|DWU-Y1Kk$4

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 20688edf2da41146ece4faa4141517408a42870c..7f33f7b8a6b1c8ace8773374b0a7a2628a25f0ca 100644
GIT binary patch
delta 110
zcmaFn*5uCR66_Mvq|Cs;_;VvyyNJB&i<tOer+5M1=K;>12GLF2!3GBL9Py4WK@8DN
zPO_Ufh(t3o`LRsq5mVF@<l=K@{K5Q#nSn!DfI+g7fg?U3C|FR0OVE%3S;AtowU{<9
E0N`pI5C8xG

delta 82
zcmZp2f9A&J66_L^rp&;=n6;6sT}0mVSxkJeQ@nuVvjAsLgXkviU;~4Aj(A6xAcp8B
mH|fnAM4}lPjVAMoDe?($@wzkqVE)0(z@a3-usK{zn->7-R~8Wf

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 8d4be05d2c71ca8de6d732d3e48e0e323143160c..7e753e5189c98fbbf29a0bb00ea0eb275fddfc37 100644
GIT binary patch
delta 124
zcmeAPSP{VG66_M9p~1kwxNIYrt|XW1i<tOer+5M1=aU^Jg_)dWH-||^Gy3?kIQ#n=
za>RRhy6`w&U}fZp5A}2blEER4T>KpI&OyO~f?Ry=j6axvFf(u{3ouAlGH}EP0EI=k
Q1PvLGB`h{Sl+xw}0M4Wx-v9sr

delta 67
zcmZ1x&=bJr66_Mfqrt$yD87+PSCY%~SxkJeQ@nuVv&oK<!c1<`o5Lid85xZxZ<bP=
XJYR~H^9S<}W(E!=0fx<grL=hgbSe^?

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 2b5b885b862a2fe8bc4a24446400dccf685dab85..5c19ea87c93288525db3be0660debb3a86580a67 100644
GIT binary patch
delta 110
zcmaFr)acCR66_MvsK~&;xN9TVb|HC}r!n!tPVoXhPXe4h4WgU4gAEMgIpQ5%f*7Kk
zoMbmY5Q=7G@?)87BciA&$i?T*_=EWeGXsaR0E1*D14n#7P_Uo~m!Kg7vV_IvY>{6)
E0OvFvLI3~&

delta 82
zcmZp4e(J>K66_L^s>r~=sJ)SEyO6xc<Cyqhr+5K}#{tfs2GLF2!3GBL9Py4WK@8DN
mZql0{2t_k88cntpQREZg;&o^I!Tf`nfkR1vVRO64FCGBuXBR^N

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index cc6f26a3f8fe85f34a8acb5432bab3cf4d3ab1f6..00e04ed0c0e4ee094fd3f541c7aa0987fc573e03 100644
GIT binary patch
delta 110
zcmcbw{#%{PCD<k8w=e?(<Ijy;Jc9DBdNJ|APVoZ1x&h9f2GLF2!3GBL9Py4WK@8DN
zPO_U#1)~|6{8%PW6jIa_<l=K@{K5Q#nSn!DfI+g7fg?U3C|FR0OVE%3S;AuT0U>!t
E0CcDuCIA2c

delta 110
zcmeyZeqWu-CD<k8zAys=W7bA49zl6eotXGwr+5KJod9P~gXkviU;~4Aj(A6xAcp8B
zH|fo$g3*iyM$Z1eh8*!8o-RC&7g!lN;zK=MfMjrpBNsnMymL^npa2)IJL3=LAIuCK
NN&*a<?+D2=0sv468*u;t

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 052a84e294eee4ecef9a36341493f841caf887a5..9c86a694d6b1a990415676943972820b51be49f0 100644
GIT binary patch
delta 110
zcmccT{L7ikCD<k8mm&iLBhyB%?LzXtZ(`zuo#F*t-vl^&8bmj72OAi~bHqEk1TjQ6
zc`0swAhei~$&Y1ni-@A8AQzuI;}7N^%nTgL0t}Ls3>@(RLBWC|T!MxS$PyNtH;ZWV
F0stt59i0FG

delta 82
zcmV-Y0ImP}L*7FQL{mgm-XQ=00duhmw-O&g>s((`LSGO`>QF;TFk6BPQ!p@J2wy=&
oQUF_mP9L-25~BeDGLwZAAr24<4Mzd^1NZ{~2qF*wv(FSO4Oi+Io&W#<

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 7efc12a46cb87c0684b7d880b2cc94d302744e03..4088448de942d92da3e7ce6e1afe1240e025efd7 100644
GIT binary patch
delta 110
zcmaFr+vvyT66_MfsLsH^7`c&)O+w!FMNE9KQ@nuh^8ja0gXkviU;~4Aj(A6xAcp8B
zC)v&V648uIek_x_B^5OVx%k`}e=z@GX5dg3V34e2;D`?h3KkUM5;SB$may2oOH!K`
E07=Fh2><{9

delta 82
zcmZqld+N*O66_N4RE>dw@$^P6HVJvpXEE`?PVoYc&jOr14WgU4gAEMgIpQ5%f*7Kk
m+@v?_OGGm=8cptzROA!j;&o^I!Tf`nfkR1vVe>UfZC(HiJQoT8

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 7eedfcd64ebd0193744864b4f6cbead35c7c3ab2..20bb27753446e9c344d798955cc1d708f9a399bd 100644
GIT binary patch
delta 110
zcmeBhTH?gz66_M9qR7C&=)aLmQ%K(RMNE9KQ@nuh^8ja0gXkviU;~4Aj(A6xAcp8B
zC)v$GLeY#&ek_yM2`g#}a`Cw{{$T#W%)p^6z#v)4z!4u16f7vhC1}WiEMc+vuCO*Q
E07dB=KL7v#

delta 82
zcmZ4D)ZxVC66_Mfp~%3%cwi%!rjWenvzYi`r+5L!X93Qh2GLF2!3GBL9Py4WK@8DN
mZql2BgrXT4jV7-bR^$`l;&o^I!Tf`nfkR1vVe?O6ZC(Jpvlc)A

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 910b4952a0757025cfed1c60416d16054e70846f..c42cffe4153e486bf25112210d378d6e937f1125 100644
GIT binary patch
delta 124
zcmbQ^yu+ExCD<iohav+5qtHgKy+T~BFJj_@o#F+2pHIFhB+TR_yZM<=G^39ni?hG4
zAxFH2rwfnc1y)9m_)t$5AQ>Fu$i>eQ?;I2?D9FX<&iI4*2QveQvH*i*B?Cu%08m(j
QOVE%3S;As-p@=pw0A~6g{{R30

delta 67
zcmV-J0KEUWL!3hjL{mgmoFM=J0fVs$y%GvZ=3HM>LSGO;=9AG969PsXv*r?80Rb|T
ZLlhyCFBAm{_yhO@00<%w0JDu0D-G1A6VCtu

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index 45d3dbe1b69143a956b4f829913ca47f07134741..b1c55ec9849025ae03b2257df66861302922e87b 100644
GIT binary patch
delta 112
zcmaE!(45HS66_MvY{0<4D72AlyO3h<1;&{8V5fM2mJ5sl&YlL*P29l-2Jsy6jxIqA
z(M?XWn;!{9Gcx(HOtuqI)D-06b7%a){DYZ+Ls@`9vXX%#J|HMqP=rg+kO5i3Vsoy@
GFKGb#lpS0E

delta 84
zcmZope4fDN66_L^Zot66*u0TzyO3hzdB&LdV5fM2j&qCw&YlL*P29l-2Jsy6jxIqA
o(M@jBn;!{9Gcp=Ywii+46X4=?XZ*qZgPDOtNq}K<r^qj9073Q`T>t<8

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index 377e880175f6f11101548c0c64da61b5aee00bd9..71f6650fda935bf42b2331f16a953a6a0097baf7 100644
GIT binary patch
delta 94
zcmaFu*zUyT66_MfuE@Z^n6!~gUY^TQHYPsUDPF)+X0oxoJ(HW*<P!P!OnxkrQxp_6
o1-ba#8GkVUU}oS@7GRL9WZ;Mo2nrSy;Sw}tK$ftWJXs+E06ljV^Z)<=

delta 66
zcmZp7dhN*N66_N4T7iLq@#sb_d3i2Z>6rLnr+5KhsmaFj_Do(PlS|~^Ga5}!RZ!#;
W;No>>{K5Q#nSnz|fMN1_g$Mw7ZxQtX

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..6fe24b49fb447f7f4fbaf693976089fa1bfbf019 100644
GIT binary patch
delta 94
zcmez4IKzp{CD<iILXm-ik!d5BygZkaTugkhQ@nte>||s4046uF$*uD5nfzELmntY~
o3UcweGyY)y!OXy+EWjXH$-ogG5ELvZ!X;?PfGlA#d5J;<06oPP4*&oF

delta 66
zcmbQ?^v99QCD<k8j{*Y&W9mjOd3i23nV9%sr+5KB>B+|O0Zd*ZlUwEAGa5}UQ&8j+
W;No>>{K5Q#nSnz|fMN0hg$Mw6wh|Bk

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index f1b8483d8da21dd57f3e5e7a1e4eb787df2c38ac..59d9547d7533dc49d11fe363fa3a7596ae6c7a46 100644
GIT binary patch
delta 94
zcmbQ?v&DzYCD<jzM2&%gQGO$rj|!KgY)pKxQ@ntu%;W?WdnPxr$qQB9Gx@Pho~Wv*
oDagg=&iI4*2QveQvH*i*B?Cu%Kv1xt2$!HC1G0q0<O8Y^0AjKh%m4rY

delta 94
zcmdnuGsB0=CD<iILXClev2i1pj|!KobWD7(Q@nt$)Z_#ednPZD$qQB98yGqJ`x<h@
xdw9C=I9_07<cJUTbODmVA&y-99P!RU!GZ!@yzY!Yn13)ca3~2dOunNU0RWT_7z6+S

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index a7731403f460a235bf705770a1547dafeee069ab..a6e26f3c0b8265a31343791d3fbbcefb0f5fb8d4 100644
GIT binary patch
delta 95
zcmcbc^fQUeCD<jT(vX3H@yJH5b-G->#xe21PVoY+#+wi6u4ZI%6Pui`|DMT@WpccM
qqNX4hpF86Z<{!)q9LfR=l9db`@c}`>f+Adkh78CO7L)r7&I15hi5d|A

delta 67
zcmV-J0KEVCV%=g2L{mgmT`>Rv0X4A-t}O~dGF)F%LSGO`F|)!gs{sN^6q9c+?*THC
ZU@##L5DE=P0r&&>0{{pj5CD^^Fwev;6cPXc

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index cb4995de7e33cd9f2d134ec96651d217873d6944..f678a3a6a66b3d2bb27939ba34cd5fde7f6045c1 100644
GIT binary patch
delta 94
zcmZp2ndidg66_Kpr^LX(cyl9{nF5!iY)pKxQ@ntu%w#VGdnPxr$=wR?nfzELS1T%N
o3UcweGyY)y!OXy+EWjXH$-ogG5ELvZ!X;?PfGlA#d6i-W0A*Yjt^fc4

delta 66
zcmbQ|(&WPB66_Mfq{P6$XuXlkOo7W)Iwn5YDPF)=YO<GtJ(HKn<Zgxcj7F1d6czad
WxOm+ee=z@GX5df~V3>SNF#-T1wh*rX

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 92c8fdb6cbb8ae8bdf5ede9679eea92486eaf372..60876d83a3ecf01b9aa568a151fe6208a9f387b3 100644
GIT binary patch
delta 123
zcmbQ~wAG2rCD<jzRFQ#!(Rm}6ygZk`d`x_>Q@nt?{A6Q!dnOmj%_Z`(j6QxW&i=lJ
z9Pu8WE<BDGSQ$CuLp@!9WN?Th7e7b5b5O9LAQzuI;}7N^%nTgL0t}Ls3>@(RKw%Ls
OK|=;)35&@G6(RueZ5!DD

delta 66
zcmdn$G}DR8CD<iIQjvjyamz+7d3i2pxtRE1r+5Kx*~!N8_Dmk)n@i+n85xZxPgYQz
WT(7{&`GfffGXsZ`0K??F3K0N4auHzw

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index 957b3ad90c787616eac212865bce0a19a5ac1e6e..8675a79e865082cc64b281500133e31c7cc733cf 100644
GIT binary patch
delta 95
zcmeB(TN20R66_M9qR+s<n7@%rUY^VSdrW+=Q@nuxx6Q`#PkEW##3oDWzGw1dnari9
ps42+B=g#<p`3Exthq3^JWF-Sfd_YjJpa_?sAp^36#bisp^8n!!7)1a8

delta 67
zcmZ1y*Ad6%66_Mfq0hj;_+TTKygZlp*O>TVr+5M9ubYkKpYk$!iA<K#ea~n#nOjeh
XPk@Wpo$&|r4`v1qB>{%Xp?c>5sk9SD

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..640fce6f24f3939f9f39fa18df3ed19621149a6f 100644
GIT binary patch
delta 122
zcmdm)dNq~HCD<k8su2SN<L!-HZw<H{Wn<!lo#F*NWhOHk+B3O{O?EPT@8ief?C)#H
z5%1yY!sB>>m60Pp)YAn>28TFu@pHsG2L%fXa`Cw{{$T#W%)p^6z#v)4z!4t+6c*tU
OG-N=Qu$Y`^6afG!R34ZB

delta 65
zcmcbbx-*r_CD<iorx61KqwPknw+39U(lPPDPVoZ1Qj-}C?U}qpCOa9vXEd5@Y@|3@
V-iVd+2lEeR1`Z_whRL-?5dew#5`+K%

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index f460be2bf74ae512db8f24418b42e8cf2a56202d..f826dedf41f442df14860a0995cd9337e656327e 100644
GIT binary patch
delta 96
zcmdng!E~;JiOVI}CB(0Vfq_wHBUf4zm!oV<e6UlzfTzslswR6TH?hgPo8B||u}ogw
qtf(o-#pllWgZT$D1BbEzgJdNGM|?m~u%HN+pdkaYgvI1r%@F`Y_ZnFM

delta 68
zcmX@t!L+G^iOVI}CB&$Ofq}7aBUf4zm#cJ4e6UlzfUnf#swR6TFOkW+o8B`TO<vQi
Y$S1(X>(2Ot`3Exthmrup<ZsOp0N^wgS^xk5

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 7c87d41d03fcfd2b5b82f2581f16de6bc0bb10bf..f1cf0eb7a7575dc8e525fec3e3409ebbc68eed04 100644
GIT binary patch
delta 94
zcmdn(dfk=FCD<k8x)K8e<F$=k?-jTlWn<!lo#F*NWhOH#+B3O{O?FXy&*aB4*+fZE
oQ;>_#o$&|r4`v1qWdR1sN(PSjfS_PO5iUVP24o3~$;nC)0MyzSc>n+a

delta 66
zcmccay4#h@CD<iow-N&bqs2z9_X=FD(lPPDPVoZ1Qj?h#?U}qpCc7xUXEd5@s-(y#
Wz{Ts%_=EWeGXsZ`0K?>Zr3e6Z5)pa;

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index da86b25f51b550ab20771111cb0a2bc49e713186..4163929b38f60749a3f3a81b0ff4fc79c9f99d91 100644
GIT binary patch
delta 94
zcmZ3KzAv52CD<iopD_ai<MfSOTMW6J<zwQ5o#F+&<tCpnOk{Eso2+g0p2?48vb3?H
orXUxeJL3=LAIuCK$^s0Ml?)v50YSlnB3y!o49F4|lf8^10P_+U0RR91

delta 66
zcmdm&z9^l`CD<iokud`U<Ijy;TMW6}Wn<!lo#F-jWhS36Ol0yBnXGN}p3!KsjIko0
W02i-2;}7N^%nTe#0t}PWj3WTIf)fG&

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index a2d812e5a23a3ce7739789246b342e703f8c96c0..65a581e0935f4bf0bc737c9967d409d72d684010 100644
GIT binary patch
delta 94
zcmaFp_t%fhCD<jTR-J)?v3VocR8=lV*_ilXr+5KRnaL|v?U~%fCcjdB&*aB4`IefZ
orXUxeJL3=LAIuCK$^s0Ml?)v50YSlnB3y!o49F4|lR4ER02R3yg8%>k

delta 66
zcmV-I0KNbHPT@`pL{mgmVJ83p0p+m@l_d&A8(d#gLSGO~8k4CdKLSb=lj<e!0Wy=@
YCLs<G3JpgA_yhO@00<%w0FxyrSi~q3ga7~l

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 43ac1bd693d1b3f67d2a9e89ccaf8a56656df22d..301bf6b20ff6fa561a4bd3456ee00b7052834631 100644
GIT binary patch
delta 95
zcmdnybjgX!CD<h-NRfeov3(<#ygZkWVoZFnQ@ntS;$&ladnQNe%_Z_yj7)wklh-RK
pY6^1kxikJ?{=v+^p)9~4S;@c=9}pBQD8eOZ$bc+iG5MZC1ORDF7K{J@

delta 67
zcmccQw9SdjCD<jzOp$?s@yA9kd3i1eg_!tYr+5Jm`N_ue_Drsln@i-a7#WQwZ%|O=
X6X4=?XZ*qZgPDOtNq}MUFNFvIWy%qa

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index 1b998820d46e522b3129e42a867ed691c1f83e8f..81fec3eda54f8aab5e9df55ac86c9c0496547e96 100644
GIT binary patch
delta 94
zcmX@?bl-`~CD<h-UXg);k$oeVygZkuQcQfXQ@ntq(qv<KdnPxr$tCjdnfzELrzj|D
o3UcweGyY)y!OXy+EWjXH$-ogG5ELvZ!X;?PfGlA#d9uO=08<whg#Z8m

delta 66
zcmccbbl8c@CD<jzS&@N(F>@oAygZk$LQH(HQ@nty!enE4dnPZD$tCjd8I2~VDk$;^
WaPhh`{$T#W%)p@}z%Y5e!Uh0P)e(jO

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..6fe24b49fb447f7f4fbaf693976089fa1bfbf019 100644
GIT binary patch
delta 94
zcmez4IKzp{CD<iILXm-ik!d5BygZkaTugkhQ@nte>||s4046uF$*uD5nfzELmntY~
o3UcweGyY)y!OXy+EWjXH$-ogG5ELvZ!X;?PfGlA#d5J;<06oPP4*&oF

delta 66
zcmbQ?^v99QCD<k8j{*Y&W9mjOd3i23nV9%sr+5KB>B+|O0Zd*ZlUwEAGa5}UQ&8j+
W;No>>{K5Q#nSnz|fMN0hg$Mw6wh|Bk

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 7346125d23fb3174c0ce678a2cdf2fdc77c4a9fa..d951a2266be9137c7432351d261a5f5288d32b6b 100644
GIT binary patch
delta 94
zcmdnxbIpg#CD<h-OpSqo(QG4Eo(h+vY)pKxQ@ntu%;Y8&dnPxr$%j?mGx@Ph-mI#q
oDagg=&iI4*2QveQvH*i*B?Cu%Kv1xt2$!HC1G0q0<VUIz0Itv%^8f$<

delta 65
zcmV-H0KWg$Ou9@8L{mgmIwk-B0hqB0ZX^mt8(d#gLSGO~8k2$~KLSb=lfxwM0Wy=c
XB_WfbB?Sri1NZ{~2qF*wll~=GhGi4o

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index 15a291dbfb62e6ceb0249e02eb25b319744e351f..70b5a223ebb1370f6a5328afb83b443dd63eebab 100644
GIT binary patch
delta 94
zcmccW_0fyVCD<jTP?dp!@%u)u3S}-QxtRE1r+5J`*~vZ10ZeXUlkX|NXYym2d`?AC
oQ;>_#o$&|r4`v1qWdR1sN(PSjfS_PO5iUVP24o3~$$wQM02>S$bpQYW

delta 66
zcmez9b=8Z@CD<h-RF#2&F>)hUg)*0$OiX;RQ@ntm^yD7p046Vy$@i4sGa5}kucF8&
Wz{Ts%_=EWeGXsZ`0K;TS)d&ERQxbOo

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 889a9040d950dd08980408d57f1037a5fc20c961..2987980a2caa9129f1747277352f33403e4852ad 100644
GIT binary patch
delta 125
zcmaEm{wJNwCD<k8k1+!SW9CLKd3o-BUB;OBV5fM2Hr>r8@;-u0Zeo+04Bq?ru{itt
z8gj&Yc)IX7USMV9h!6F20g}NXj$Hg4@y<cPf`VLp?u<W}e=sv}C<`!1Rx)tJ2LOdd
RxC9LukR>cOFEq4g0sw*^A5{PV

delta 68
zcmey9{ve&pCD<k8fiVLE<E@Qc^77oxI*c*#!A|i4UD}&X<b4F0yhJ898N6pSnp|wC
YI62;smGcMl4`v1qB>{%bdkyWG0Q+bZzW@LL

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 780616774f97a2d7305faf9e9a9d12afeb0e2fa2..dfb62b7823740c606bab9215bcad03707b42b72e 100644
GIT binary patch
delta 95
zcmaFp@YjLMCD<jTR)K+m(QG4Ei7c1DeoTC@Q@nt?{^kzZTt+50vB}@%-ZS~JOnxq}
ps42+B=g#<p`3Exthq3^JWF-Sfd_YjJpa_?sAp^36#bhxBZvY5u7)Ag9

delta 67
zcmezC@X&$FCD<h-QGtPhars8B5?L;1y_oo5r+5Kx-OU}cxr|I+B9p(%y=OF<{6b!l
XPk@Wpo$&|r4`v1qB>{%XMhe~ly=xOk

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index 0f862ab2938e0e11aa8335630fad389095b37edd..8546756638fd47768527253defa9a7a8ee941436 100644
GIT binary patch
delta 94
zcmccX@Y8|ICD<jTQh|YiQD-C9L^&=;*_ilXr+5KRnaNA#?3vueCO?yV&*aB4`I@|<
orXUxeJL3=LAIuCK$^s0Ml?)v50YSlnB3y!o49F4|lUWra0N-5~#sB~S

delta 66
zcmezAaMyv$CD<h-R)K+mv2P>SL^&>3>6rLnr+5KhsmV*_?3uhoCO?yV&uBFHy1XKv
W02i-2;}7N^%nTe#0t}NC6(RtkND{{Y

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index df8edc05b69ecd1331973b16e534b44616b50f58..0485e0bb61ca2ada9b55f3687db890a9b19b06d7 100644
GIT binary patch
delta 94
zcmez9*z3gQ66_MftH{8>_--SYsyvsYY)pKxQ@ntu%w$V>dnPxr$yM_2nfzELXDKLZ
o3UcweGyY)y!OXy+EWjXH$-ogG5ELvZ!X;?PfGlA#d8R@H0Ciy&umAu6

delta 66
zcmeBm`sm2z66_N4QGtPhF>oW7syvsgbWD7(Q@nt$)MQI}dnPZD$yM_28I2}qD=6{_
WaPhh`{$T#W%)p@}z%Y5MLIeP5cM-7w

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index da3ce12787c28e555b6ba5eacb26275bdd4587f1..e94f3edb5d4126943fdc904804385ae16e6357c8 100644
GIT binary patch
delta 95
zcmccM^u~$HCD<h-N0EVnk!>TFygZkia!h=%Q@ntm(qv<KdnRw0%_Z_7j7)wklTRur
pY6^1kxikJ?{=v+^p)9~4S;@c=9}pBQD8eOZ$bc+iG5Lo=1ORJt7P$Zb

delta 67
zcmaFkbis+sCD<h-K#_rgv3w(!ygZkeVoZFnQ@nta;$&ladnSLW%_Z_7jEqK;Pbnz!
X32^bcGyY)y!OXy+B)~9PL@@#YV{j0=

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..640fce6f24f3939f9f39fa18df3ed19621149a6f 100644
GIT binary patch
delta 122
zcmdm)dNq~HCD<k8su2SN<L!-HZw<H{Wn<!lo#F*NWhOHk+B3O{O?EPT@8ief?C)#H
z5%1yY!sB>>m60Pp)YAn>28TFu@pHsG2L%fXa`Cw{{$T#W%)p^6z#v)4z!4t+6c*tU
OG-N=Qu$Y`^6afG!R34ZB

delta 65
zcmcbbx-*r_CD<iorx61KqwPknw+39U(lPPDPVoZ1Qj-}C?U}qpCOa9vXEd5@Y@|3@
V-iVd+2lEeR1`Z_whRL-?5dew#5`+K%

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index f460be2bf74ae512db8f24418b42e8cf2a56202d..f826dedf41f442df14860a0995cd9337e656327e 100644
GIT binary patch
delta 96
zcmdng!E~;JiOVI}CB(0Vfq_wHBUf4zm!oV<e6UlzfTzslswR6TH?hgPo8B||u}ogw
qtf(o-#pllWgZT$D1BbEzgJdNGM|?m~u%HN+pdkaYgvI1r%@F`Y_ZnFM

delta 68
zcmX@t!L+G^iOVI}CB&$Ofq}7aBUf4zm#cJ4e6UlzfUnf#swR6TFOkW+o8B`TO<vQi
Y$S1(X>(2Ot`3Exthmrup<ZsOp0N^wgS^xk5

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index 67ebd7c158759221b801ecb67d8562d92fa219d5..39e7953ebf133590b027ebcca825aa8e9db7059a 100644
GIT binary patch
delta 106
zcmX@<_SB8bCD<h-RhfZ-aq>nkZFw$dr<nL)r+5Kx$I15c_Dmkun;YaEnFah<oc(<b
zIpRG$U3eTXurf}5FE6I%&iI4*2QveQvH*i*B?Cu%Kv1xt2$!HC1G0q0<c~@b0PBDo
A2mk;8

delta 66
zcmaFrcG8W@CD<jzQ<;H*@#{t|ZFw$thnV<ar+5K>`^on5_DnvOn;YaEnHh~HA68PF
Wyk3cw^9S<}W(E!=0fx!E$`JsM>JpCt

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index c6b58472157d575e2625557d1346586be06b927c..fc6029618e322bea49d25e0ab558743adc64244b 100644
GIT binary patch
delta 95
zcmaFt_TP=mCD<jTUYUV`(QYG`wmg@wb4+}&Q@nty^JIH@dnPB_%?<L=%uIePlkX@g
pY6^1kxikJ?{=v+^p)9~4S;@c=9}pBQD8eOZ$bc+iF_~LA0sy#(7UKW_

delta 67
zcmezG_SlWfCD<h-S($->as5UvZFw$7r<nL)r+5KR$I15c_DpWpn;Yb#nHh~H-&IoN
X6X4=?XZ*qZgPDOtNq}Lpx^e^nl<^Vd

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index 17a64adb2055ad3168754ca121bf29851d2ee496..404d08434f0eb361dd1750de5f73d806790d03a4 100644
GIT binary patch
delta 96
zcmaDlk+E?SBbQ6CO9-PU0|Vptja-uMT#m9a@xe~<0-iFHb=~cm+{7m5xxZ)fW0@T1
qp{Oay#pllWgZT$D1BbEzgJdNGM|?m~u%HN+pdkaYgvI1uj|c$KFBj_o

delta 68
zcmZpi#Q1a~BbQ6COUP3X1_s8cja-uMT&~hF@xe~<0=`m{b=~cmyhJAFxxZ&LnjG(;
Y$S1(X>(2Ot`3Exthmrup<dq%~0HvA|>;M1&

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 6eb30e8f4b2c54e4789c649475adff356c8c58a4..343e360d15b34033e87b3a40045062070c2e7b92 100644
GIT binary patch
delta 94
zcmcap^rMK&CD<jT!jgf3QEelak2#mCVoZFnQ@nt$!sG<=W+peW$xqGSGx@PhzG|VU
oDagg=&iI4*2QveQvH*i*B?Cu%Kv1xt2$!HC1G0q0WERT^01m(yegFUf

delta 66
zcmexSbf<{RCD<h-#*%@7ar#CsA9F5G`Iz`%r+5KJ`N;|9%}ib*lb@QuXEd68%|ek+
WfQ#3i@dxt{W(E!=0fxy6mJtBJ1rvV&

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index 111bb041dc0d114351add07c040dde61643d157a..91b62897533b7d77ad807c1d659e59bc30bd3785 100644
GIT binary patch
delta 96
zcmX>%o$1wdCN7s?mylQ83=E7K8@ZUexEy6;;)9*y1w3UYi*?yExrt2<?|RSV$1>Ty
qTTxSxi_e|$2lEeR1`cHb2FXeWj`)C}U_lWsK|=;)35&^P-4OskC>eqP

delta 68
zcmaDgo$1_kCN7s?mymPa3=E828@ZUexLl=U;)9*y1$?C@i*?yEd5KI8?|RQ@G})tD
Ykxzh&*PZbP^ABbQ4kZDG$&<Px0O)-bg8%>k

-- 
2.43.0


