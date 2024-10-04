Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24B8CFA74C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 08:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swdqr-0001Z7-VA; Fri, 04 Oct 2024 04:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1swdqn-0001Yk-E5
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 04:39:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1swdql-0006Ph-EQ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 04:39:48 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4946T73H012418;
 Fri, 4 Oct 2024 01:39:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=8+Ul24fiup7Pv
 /Tij5W2Dkss4GS6O6M105PjJ5dbzs0=; b=aZt4q5IIt4WSFAdWiddCdbQhVWR0M
 pzcKn6cL9sQT1iYxHlSuYjik2/bokEus9B0BjBV0J37N2ECs/RuttTPriyR5TFDS
 cqmms0uvm8drbXN3gMZsK1lmTy23CQcgEaUvba4tPKbPUQlSV5fQrQNUDKclXQBe
 jHWaH2z5ZB+tnAtT3ZlkoSMUjCEOkEzu0tKbrKx2KEsYKnSzOBhG5dlUNBGbu9bE
 /1W1XO1MunvL0xGLNVU3rTWktpc6yEtfzDrog38FSHdOX/9B70VNUlDAJbNN5gUm
 iYGwQ0RFlYtHPeqhu2uFqEA45z/YrY8CoaLuKCoqVYmVn75iwqZDL1gUQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42205csp96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Oct 2024 01:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCdhc8YuwDeUfe8AUz2xSaYmcBjFDRdnK8M5PN5cy541BNXt28NP07gb82AqpMcK5MF3WLtO2iNTYrPZh7PyG092RnVbCsqMHpFklaT0OhIuLCvY0ZJYKFFrX8AbbOlXUeJRpUvAxhq6XdlJ8m5jm7SChYWMrhcrtIoB845azq+xHmv03G3moffv6dwcCSc4OfqLSk8HObZvb7xZ+B0jnftJXZ22MAR6F0RpdE2YHp4ANI40V8MbTqULA9Qn4EU965/kiPAHyo8+MBQb4dPPh65L7P6KrI30gJairzuBz7Qlaoycxy59DcZcwF/ZJ4w9hwWEWxBu/KxuYuYrk3iyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+Ul24fiup7Pv/Tij5W2Dkss4GS6O6M105PjJ5dbzs0=;
 b=qmusT0TJ3Z7MSIyf0QPTri/MmotbhPKBIi3dPM1iKFRZqGIA8PF5GGblOL0U+HXjt52yxfy3BL/SlNOXrFNJ4e80ftH37I90jE0xmvbJNZSVic9Z5KOucnCiaAaVVcHKr2AbXhRVZGrae1ojaBloiZp6cXl3lqggjhbHyq6OQP5Nt26sCN6N6xc7hDU0CjZp7Ske9yLWydnnx2ArthFSLcJ7A2WzDXiDjuc20dfVJsD1F15Xd/mcjvWUJ+Sdz2rlWvlpCvgHVbO+G4OlDLwwXWKjElg6p8cqVXo6uakUHdT/JHBTW0kGgwDB2Ss5Zs7id8G+kdCEJJPPhMVEYF1shA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+Ul24fiup7Pv/Tij5W2Dkss4GS6O6M105PjJ5dbzs0=;
 b=zCfFULUdSggdL0DW8nGs8Y8xQno3tgfKE0upfco0n68A3fg5vNoGThv8iji8B6Wti2SNzERuO5MVovDGJFalDiBbLAtj1nEu0aNSg6iTP5jqvFpbPqjSMqMmotemNPsDUgTWMawSVB3LtozvuH9Oo9iHifkI8BT4Na5K1T2sIZjQCAy/WKkH3/yaR02w69noRaE7ldFnDMZI8ImGWUGzwuGYOxzoo6WEQmtcoeh3w065JcimpJHrxXTi9cO+008v9hldFzDsMd83kcLM5Ue69hmQ3aUFZsgXonZwOdKy8Sii82+fQjqyDFoYYa9r6E5v2QqFZFmP0SwikUlGJeQyaA==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 CYYPR02MB9801.namprd02.prod.outlook.com (2603:10b6:930:bb::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 08:39:42 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 08:39:42 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Simon Rowe <simon.rowe@nutanix.com>
Subject: [PATCH] vga: relax restriction on display width
Date: Fri,  4 Oct 2024 08:39:37 +0000
Message-Id: <20241004083937.73595-1-simon.rowe@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To DM8PR02MB8121.namprd02.prod.outlook.com
 (2603:10b6:8:1a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR02MB8121:EE_|CYYPR02MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb93368-357d-4f17-15a3-08dce4501780
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dw0vtCWwVdwWnz47xgnbJbF3LHe4vZlSsG8WVLebLnzzD2DWoVSG+GKkwwx+?=
 =?us-ascii?Q?nGcJ/nCxUQTdp74HaiSFaiw+SUAe0dVpijA7xyZh7J8PkOJgTppy4Qnrnuay?=
 =?us-ascii?Q?EpzveARS+pLWgGROsobACaR4W1uRl1vtvZpdyiyGfnZtbx61B+ZBi7nQvs65?=
 =?us-ascii?Q?poarNcXimh/8wUpMZbhBCfwUski/+9s5XZavvYZ8BWMMBaDtNpzD/Sorq1Dy?=
 =?us-ascii?Q?F9JChX3yz2yUSLxuxQBu0tRGl91r2u0tnvOiQrGx7P3X5dxOzBCts9Y69fCn?=
 =?us-ascii?Q?+af8cG4EBOl171ubPaH0LuAIPFNcX9uXkyFVAAQqhhwiA2r6K91cLuJqHGMx?=
 =?us-ascii?Q?lrWdvLr3omc0/hdY2yjYxeIaYeAgSjFwsxEXpeIbjRSbXhNUb3dER1V8uXMt?=
 =?us-ascii?Q?fBuy2srTP/jGyQ5GWRL5r+u1LNI4k4NSGhRvlK99p3g+z7E5qk4+2PD/N16O?=
 =?us-ascii?Q?AUXFFEYzkAyRzl/bFlGo6rtnQnqb0XGMWh4JTnKDEjGwz41kBOrbgE7e6E+P?=
 =?us-ascii?Q?PcH9P7AvKebkedk7IEeT2/WIiokwWRdjACqWr1GTpGnozRCVwu+oHS8mwH1Y?=
 =?us-ascii?Q?/ft9xBCoimQsclPzWOVWR0PBds1Dqxo8gZiB3t49DRX9XQPura/FEgvVMGpn?=
 =?us-ascii?Q?sjuWvDAN2IXJYqHCt83OPyHohPi2YH64Uywu1wcaL14JNjqi0oDbzgQH64y+?=
 =?us-ascii?Q?qHHkjt+O7xOo2vRiM2mhckjSxGvabXEBE9x0fWpcItT6lmA3QjbC6Ob6UNN0?=
 =?us-ascii?Q?whQS8eKdoC0yFVKAonzcGR3Or9iPWMxak5h1CO8LfpPOd8Mqw6YpYfl0PiMt?=
 =?us-ascii?Q?lTRedFKJRjzdgylddfxZOCYIJ506yllBrJeMsZrslCwDfl9iRLvT+TIsGmnY?=
 =?us-ascii?Q?9Jcf/muktEWNR4WJpId5dzBhmxNKDtq98B7CxGPE5q+Zd++/2skOFf+jM8qR?=
 =?us-ascii?Q?L21Pvz5XdpalKFBAIJxKxNaraBNiju1dS9SMUPB0mxeqahTHJdYr/z/hRVpH?=
 =?us-ascii?Q?jjQ8s1x27kLZSCweUSiYPPwuamS6CknND57o/w6SS8f5mZYqBBcr9aHOrRSv?=
 =?us-ascii?Q?NcvPj1BDzKj/czzIOUhZwLRBvFWasJ96MV3kUBRKvTslPCla1FOec3VbTaW9?=
 =?us-ascii?Q?GGwM0Z1NLHLnc1cG5bUZhOkaI21rkAppqOcwM0RmXj1bWuKcc/PED0z4LB/l?=
 =?us-ascii?Q?RCcvFgFq9gjv0Wd43oiKcHawC1/L2an9X3COvRfssj7Q95xtg9z+WFg9ib8u?=
 =?us-ascii?Q?V2NsLlH4ucH8S2GrT05hwZUyKxYUVUnUn2QRW4x6JmkY85mdtqlP6tJqlIMf?=
 =?us-ascii?Q?1WLHgzlmRyeqa5jcXD5DUYz0X5VQ/Q6jtAd8BT2cz3rGuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGO0ar7V5Wg+tiLdqjuIh8i2w9gljVtsAty2595nlFxY6fn+/jkTDqqz/vi+?=
 =?us-ascii?Q?g3fYbo6sSky2tAu/yLUN7VeI0FNHGsv7SuLkccy2iEY55jkq2Kfw9zwrH8pd?=
 =?us-ascii?Q?PyqypdHPoE7xs25sTvGLqXUOw43oWy8kJC8oC4jHVmB+iA8m/KnnyVrvHiqJ?=
 =?us-ascii?Q?uWC8JkMsnc9s/u0xp9aE+BV871zBgSRJXOCYzgZrGv6+74RJ8e0t3bxo/dyo?=
 =?us-ascii?Q?8gq6+f/oZI5ygMoZ/Me/KAnNK8u2erQxhVfaNZbSNz2w3zuC3DMCMRxf8vHx?=
 =?us-ascii?Q?EvhNy2sKqAdaxeA5TOqq3KlKHVrDK1ixj77La7Ga7HselVOfBP0+QKj8Swbs?=
 =?us-ascii?Q?1USmVm+YYFqm1jW1L/ri4+X5wzsyxgmrAQM/F5AoJeNKAGYd2effmo6KEnns?=
 =?us-ascii?Q?HAMPomKF0TaDojtHEDjYqTm2qORgaCAV8ZiEk82RlkB8QtuEIXhGSOJ5Kozr?=
 =?us-ascii?Q?NrIsn7T3LJQVIFSYaNzFUB0n3np3GkKcZjNly+lhozklIFo9RaNUREWzcdDr?=
 =?us-ascii?Q?PO5qetbKqn0eWNW2ojv40X1azcOOxxwQ+7lCD/YGmh6EIxr+5J5/xVoQL5h9?=
 =?us-ascii?Q?QUyW/qkwrKCkZgUZX36pdi/CSg27YVxu0WJPQez7Vr4Px8Bc4zbA7c50l5Gp?=
 =?us-ascii?Q?9efwLOxswQCmBJyRpGY+H98kUdUBFF+6DepFgg7Ze17uvrQxyurrmuCgZuU/?=
 =?us-ascii?Q?03vqGcRdTRzM+/O2CoUrQXLUWEr2p+S0lZH5y4wYaEwJINdzKapd5aCQskcJ?=
 =?us-ascii?Q?kk3jUDOmdoRm1LqJQwz2FUgcpySuMcfIKoy26qT/enCWCFUY4AceGV0TMmE+?=
 =?us-ascii?Q?hArcJRkf7f9+4i6Qq8C8D5ru6HBgIgojO07m9HHFkX381EYNIlNUZWLkuVJY?=
 =?us-ascii?Q?wb5lWrm+lvtV+oiPR7gG42fLRMKSNORyA2s27FFD0Fz5NdcBIYYb7vsHHBy1?=
 =?us-ascii?Q?FsBoP5lplMMFhc1zcnZB3duWWz/WuUsztpZrb8XhMEe8vxKOE9ZjURxbFJya?=
 =?us-ascii?Q?hSh3By22F+WO7Xvnyl36T0Tb1PO+RZYfovAtFn7UiZa+mqymXTvb2JUwBeWU?=
 =?us-ascii?Q?VyH/qE6fI/8n31Dhch6jPrGEDugfDYBBOUneMIm+CSEeUizpixRgOp2PWNRe?=
 =?us-ascii?Q?3kNduY2rDjWgniQm2yfuylisveY9jF+7PJ7nfR7BtzsRQuw0lyrH38mCQGN7?=
 =?us-ascii?Q?GKYEY0m3B1St46kGvOCQ1ijv6bby0Yl2l9RNiNToGRlhEtcU17erzk23uLbO?=
 =?us-ascii?Q?v7ud+gN+HXICvjpQnNWJuWZ+X5QI2pUfk9Ou3FeFW6rwB4IEFC4kaOnZm0lL?=
 =?us-ascii?Q?ZL28/OvThKqd3OKjrtpl4yhf5jmpxFL7Vn/JVM1TXeE1eQkdKq1PMAIPoKTf?=
 =?us-ascii?Q?xvHPuAeVu18m27BjsLE4qiEQUpw271GMP2z1gbjt6O7RDtnu80cfwf4ls3CO?=
 =?us-ascii?Q?gQWEYTllZnz3svXUkdHsfikOYmVv/M/Yennz6o2H8o1mk/w1fnAGvc7ps2J8?=
 =?us-ascii?Q?UqjRqihb2Kk4UaVJ9m/PZO4e0lZ/e5V+gdwXgMyKIJUZ/KqYF9KtoiHMOLF/?=
 =?us-ascii?Q?hctpR5Wof1n3rNetjG6nj3+TZF9OLSeD//OHq1AdT4GzycqjPSgf9Y1mYCl+?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb93368-357d-4f17-15a3-08dce4501780
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 08:39:42.4728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/j7m2TBoHNhj4kJKwPij2v5MXu7N7ciP1iArB83CG4PrnuMLiSVL3Bh7Gj0buv9Rlmg4umJ+jBNGAhixln1dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9801
X-Proofpoint-ORIG-GUID: S-1L8UQmuHIzeIxtPPtPtMwj0x2XS9nT
X-Authority-Analysis: v=2.4 cv=cJuysUeN c=1 sm=1 tr=0 ts=66ffa9d0 cx=c_pps
 a=nskeBUqQUen4dZUz4TdP1w==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=_6F_Gvem9JLtgjso58YA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: S-1L8UQmuHIzeIxtPPtPtMwj0x2XS9nT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=simon.rowe@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

When validating the parameters of VBE ioport writes the X co-ordinate
is silently rounded down to a multiple of 8. For valid resolutions
(such as 1366x768) which are not divisible by 8 this causes
miscalculations because the display surface has shorter lines than
expected. For example, a VNC client receives updates with a
"staircase" effect.

Reduce the rounding to a multiple of two.

Signed-off-by: Simon Rowe <simon.rowe@nutanix.com>
---
 hw/display/vga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 892fedc8dc..ea659e2812 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -581,14 +581,14 @@ static void vbe_fixup_regs(VGACommonState *s)
     }
 
     /* check width */
-    r[VBE_DISPI_INDEX_XRES] &= ~7u;
+    r[VBE_DISPI_INDEX_XRES] &= ~1u;
     if (r[VBE_DISPI_INDEX_XRES] == 0) {
         r[VBE_DISPI_INDEX_XRES] = 8;
     }
     if (r[VBE_DISPI_INDEX_XRES] > VBE_DISPI_MAX_XRES) {
         r[VBE_DISPI_INDEX_XRES] = VBE_DISPI_MAX_XRES;
     }
-    r[VBE_DISPI_INDEX_VIRT_WIDTH] &= ~7u;
+    r[VBE_DISPI_INDEX_VIRT_WIDTH] &= ~1u;
     if (r[VBE_DISPI_INDEX_VIRT_WIDTH] > VBE_DISPI_MAX_XRES) {
         r[VBE_DISPI_INDEX_VIRT_WIDTH] = VBE_DISPI_MAX_XRES;
     }
-- 
2.22.3


