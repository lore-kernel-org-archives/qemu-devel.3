Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA62E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdm-0006XL-LK; Wed, 08 Jan 2025 06:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdR-0006Sm-Gs
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdN-0002Gc-Bc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:04 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087vts9007169;
 Wed, 8 Jan 2025 03:53:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bq9Ga+C5PtMdkv9K7OvuJn1mYkXvQGzg9T60bFEaG
 Ps=; b=Y9mK9JGD0XQVVWLeq69K4J3uTdzU5ZqCHtAPK4nL4Ttg/4zMIwXTAIZ3W
 mJvoHxowfbRwlwCKiGA/BUb0H5e6i6M6MU42z7tpkd99ZRQj2i/Vh6eFvcbmyj/4
 VHg4qZPMDjoi7pMASbHhZTrm8WI/DGI8ax+Ep0w9QSgzOtfRzZUfrlN2KWW3Teu/
 ihZ2QzpkSEC2iCxwl2fLTFlq5YEs+8+imH41sfTqmgHZkIY8WdgWdnrt5EilG7vo
 xe0a2F9e+1Gk6J0aUgt6d8WQFX1W4CDfTecjvZYY59Ukt40DFKZn/+LPxIUPRuR0
 bdBRxS99xrUZ+HKbQeNGkKjMZg7BA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y56eryy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux1B9EckNp3NDIikcAfJCx0y37SvVX+6p9HlFR98H8J4usfZPACrihNN/N3amhjUCSQUYh9uuscU5Bo8ZuqA5PYXbnIBxBkAqlIsWEMRDPlLofeO/I0avJFcCVoWkBdLThflHiqx/jUvDVaJMcAD9hQYA5fFdyB50kfqIvWYcaEAh9lzjO0mLTC2zKrnGQ/tPOW9Re1/nmmqKBJnqeDABtXnKcZyZYoQmx4/dM2RLqesWr8m6S7EfJ0qXNI3TGQugz+WnnhCKl1N7bhCudDDwN1s7zYk+DNasQ0sgKFQeL6BU7+7fVBeKXmmlLIxWZvFdz6AvY5MeGeJozIJZbrkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq9Ga+C5PtMdkv9K7OvuJn1mYkXvQGzg9T60bFEaGPs=;
 b=RwdBGsaxxRSuVOkhEHVr8jEiUEPVY+gPV1htVN73DRDhlCworALq9vlcf2WdVA1AymXlNBRThCTdNoCd/ay5cSWGKkzrCV72bLYurxHo/Bh5dEYnl/4+ZY76VlPGgc7dxZ47UgVwt6fuTQpe8c60E0V8Rn4l/rHPMoznScsTrMGOtSZZ2cnNcP3xgwY48sjKgFXlrg8DjQxR1LNKPeW/s83fNnP5aogk/outdyUnCPMsk2S35GkLY0eViin/qI7GiX3J/blhhFOCkbVcdMfXcxGDQfH5UWoChAk4ztXRcBrypH6mxandHDHJZvslCUI02/7/1s7rC4jiwn1uvxEvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq9Ga+C5PtMdkv9K7OvuJn1mYkXvQGzg9T60bFEaGPs=;
 b=Ud+e59Ka/O36QRk9mdpmZgieEAs6NHbB14P1drLC7DOmuZ/my98+iLnYSXhMuDCtvUjT59JtYHr1ofzbHsbtFhXwXNwAL0DmKkUDt6CF+sTkmUtIiMmncQuz00+Gn/g6IYxkA+5FTmgywZy9FY3PORNmfMUmzaNYeBUu8WUURa6A3QG3OLbAcJA+Gz8SmujZYmoKIDYjTJCwE3OADxnPjUZu9fc+WOgiRdTqlSsfdawj1ktUtY2aPFqFz2uYfaJpVArzNKrcuD6bul6nGKcExYNvtbLgnJ9AC2kP441a/C5MbNdJMJ2KYMfYvzHwMJ0Gkw+hiF+20+iEiEi8PrCtsQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:52 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:52 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 17/26] vfio-user: pci_user_realize PCI setup
Date: Wed,  8 Jan 2025 11:50:23 +0000
Message-Id: <20250108115032.1677686-18-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: ab74846f-c99b-45c1-866b-08dd2fdb1eda
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VBcpAB6/U7FWJ7VH4F3Hzv9L0bYBFWnAwbZ5/1wKGF0PJvuUEFA9DKR42IN5?=
 =?us-ascii?Q?7BWPdkXq8q+8iOrgno/A7Y4/RfPazKq6IgHW5Ti5uexmeU6RfnCRaGAGYNFe?=
 =?us-ascii?Q?QIdxXT3ExYCImWgvM1JZ3R3zK39Ki8QZbToRHQlEcJsL4pyQH7aRxsFVC5+O?=
 =?us-ascii?Q?vkbxtMOlMll2IY00ZJLsm8pAXrG3cbj8b1vfJgI1GhMU4kuv8bJ4ZiBBMm0M?=
 =?us-ascii?Q?nS6x+h6qEwIDwKIUr78f86bModyv0cwlu2k0SUY2Kmt75j1sd4sblc44Pkgb?=
 =?us-ascii?Q?MNgzcdv+Wtaf+ioNUb2dFjHkuMOX90pVAltm5Y5uGM6cy2dYgbVCwbSryUHH?=
 =?us-ascii?Q?oqS3LCpCn+lib9Su0VNq7QXgDreuz2P5mNs93afpU0xE9a6CYOT67qvHUIF8?=
 =?us-ascii?Q?0VKXZiVGFFGTVmU8zfVpUVq6rcu1g57umy24B6lIo/XYBhNou0f7eFMXZ4uZ?=
 =?us-ascii?Q?r0YqZiRygxGY9IojG0MIb8VpYS71jti6clGvxGnpx6wCDbWEU06X/tcVa+FF?=
 =?us-ascii?Q?sapDjcvmMQ69z77oCJCsYSwCDORpB/CpA6KQwvKptWJAIpHLqp29DvIxw2HA?=
 =?us-ascii?Q?W9bTk77XBPuGCAtR1FlrBcZQCR2JR/CsHtRcFaMRd8Xg2BapThYV58Pe9wpE?=
 =?us-ascii?Q?BFCo/bl0dkYaUXxwoG20SoLh5nBsrZFXXQHySa6Pic2sKlZqsPtz/KNZTad2?=
 =?us-ascii?Q?m2I84TOIT4jY0vZzKATYM5/lqd5dh7sJ8v7AyRSYOzleuWWgmBZyvZkqhCJ2?=
 =?us-ascii?Q?kNg9GQ0SH4M8Ixa8yf/fdRRgVrZrqccNnKHRmdyzk8I1N4QODRupzWIO5Qyv?=
 =?us-ascii?Q?2sl2+xfYGvZRjlFjyRroF3un3/MmBhKvhjg+W8B6gqe7A6qY03N98mjD+zYJ?=
 =?us-ascii?Q?FvS2EgVyMOecX6N1VCGvA+3DSwAZoqLuNK1X7+aQyvYxzZCus5z9McyMlTDM?=
 =?us-ascii?Q?mli6zKOg4sZ33yRq2AIm6ccVNdnJlYJqYaeItZEYujJp9DcEePm2pXm6QYyX?=
 =?us-ascii?Q?9IouLnQXaiP90FFLr88LGHkQCVMh+tvbyD0ZwZ2vZb1UCyfxGTaiNG9kfYOG?=
 =?us-ascii?Q?SpZkMsZ5MQrSoEg8ZEW3jJ4KSVb/oCO+3tC1f/r4EZO1DerR5sulqUELbdQd?=
 =?us-ascii?Q?3m8uQT+D6Xfz3dHeUw3wJt0YpEmSucxIcN8PvI30JRYgFdmdbVoUQMAMJGfM?=
 =?us-ascii?Q?9JiTmXUQPdyQGliOYhYDlLj1HTtXA8DJyQ4kPjxPXN88fhy10O8+QFTF7UM5?=
 =?us-ascii?Q?kLq4Rl/NZLaX0aXipAwneIJVXUP2eWGLPbRzbJjLsivYqPxifuYDMn7csez9?=
 =?us-ascii?Q?YNlDeX84iYA9wmeXlYAXnDKCIwxsLigbEuJJNJbpKIh3t8spz6TPVyB99w82?=
 =?us-ascii?Q?lecky7bDmJ3pzgDLQpXL4FjIDAWm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rtb+IcOXHLDtE0mMBsgidY7Z6iV8Js1KNlaC6hDANhZWc8YxaMTYKn1YTzhy?=
 =?us-ascii?Q?SWJ8gNJ0AIK4jhOtZ9kg9RT6Bn0W93hgI/sioiOxsOIcWsfbFEAG0I9uB1/4?=
 =?us-ascii?Q?cJYmw2XK6q6AvVvWqp9Mfy5cUeUvn8pPUyXjSup/4hPEgxZ2BGKatT1UvAH1?=
 =?us-ascii?Q?eRweFcP3XeWCvy/pXB5ipyBtsHLM4EHalOnS90NW7K9FjunCte+/Qzmj6XKj?=
 =?us-ascii?Q?ZzquEHCa1KbVvApZQhL+zWZMYgIbtXYmV6o+zmUglP+r3TlU78k2yv38QXMz?=
 =?us-ascii?Q?mPUFvFox78T7J7DDkFZLcFQxn9UVWD+Ol1nv/tkYCfYsWl4XkeqKHoE7tA4s?=
 =?us-ascii?Q?gp6GGpowsXd3P3yfH07Re8QwqkcNP5/MQ0TvsA6fJrTSBHSt0JFQUkDikGEP?=
 =?us-ascii?Q?DmT9ZQkOzTjyTYmxLeFclo76xuYDg/84rV5NDX7jsccLW0J6fRZ+qUU9SD03?=
 =?us-ascii?Q?2tBpw9CGhMetJPEjGqVt5KUv72axklhcWZAvZv1/Yoe86JSzEoTr3Z7OFkR0?=
 =?us-ascii?Q?CyR22QM9xTbXjyhz3xlE+P2zr6K6gTB0VcVaZImg46hcdmnVFjxohcaj7gfO?=
 =?us-ascii?Q?14qOP4MI0CK3BHofJgvFLJMxYGt5oDofMCqkg2pswC4qjcxyxBcManK1LK5c?=
 =?us-ascii?Q?tOlsgVRrXMjPRaI08/ZN5kcPXTc2fN/fcPCHjnw4WaPCjK3O4DaDeqM6hJDf?=
 =?us-ascii?Q?pm9Vg5DC0mB/oimIj0F9MLQZZVpOrX8j2H3MKSf8kiDHEzT4DV5Q6Iz5t/Al?=
 =?us-ascii?Q?gb2ftXHz6bA5xMEnzlc6pMIbXlxildzV7IVAdz/jLssp/HGwgBylTTz02ppx?=
 =?us-ascii?Q?YEKSYloHUvJ92lNEd1tj19cA94j70JKijablC6r6vl00KLqakrrRfTwTl/WE?=
 =?us-ascii?Q?eRZ0RRGrdJrjV10+1hvX0yY+i1/KxYUE1IcKqt5TTQToDCX+JG6SZQf1HzfZ?=
 =?us-ascii?Q?neRXaouigRfT086wWdl8Cyb7ewXhoulNeqJUWQyWjS+na1nUD4ebYgUidAni?=
 =?us-ascii?Q?J3IrjvdrLcGAvFvhsRuoI/SC5YQaEPiJvbmPssOra+0P8NTKWS3WZjCcBaGW?=
 =?us-ascii?Q?MGr2iTxdpSiQFoYLZRzX6CIkyd2F6BDc1kQFFETzy19KE0OkmUMmFsGBsK/S?=
 =?us-ascii?Q?uJFS+srYZhiEQ2WT339AYWw2rAtJYrlp8scp52/LNHY77kk7ReaG3QG/nJxQ?=
 =?us-ascii?Q?roKefK2O6yeDf4vhRDNB0ywk4FRcmObgAUCmgl2uVfkmdJvxvr/slPfXupCA?=
 =?us-ascii?Q?jQw1YZSLFc3lzsAzsJLjM5Vk21FBtCS57wtMt0/PTLLmGc0/kgFFZiF5tNg4?=
 =?us-ascii?Q?FSoKqJfDOE+oTIhknboyw1v6AY/gR5q4/jk2R29fSQoubGwinBgkZ3MuX5Jy?=
 =?us-ascii?Q?VYYOpcEmupq9dlTmjecKF8ILI5yxlG35zZFtN4AxcZ0Gg9Qq4VT14e5SxGkm?=
 =?us-ascii?Q?G2bLxomh9uBgwlqnmg+1TrOxNlFzIOrW/Nyx2EDNDon9oSZMdVzSSz4hooco?=
 =?us-ascii?Q?DWwbM/9pAM+GMATtjz/YpHQGYJkJyHRaLF4ya+aMyfDQY1oVawWnXqi6mt+z?=
 =?us-ascii?Q?lN2yesnj3T4YHERBZSQ0Jjhf1Db/E9vN+cKSYEBv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab74846f-c99b-45c1-866b-08dd2fdb1eda
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:52.1128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN51PScSZVBt0DfwCNswsQ5AT3mg8AknxVTh4wyvyO+7tm9iDLlLde3ZXarYL8ksWBsLLuEs0fzMTjz+pQd4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=A6aWP7WG c=1 sm=1 tr=0 ts=677e6757 cx=c_pps
 a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=TQvnsvYg8OETrsMx9EMA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: ngiEvAIY_y1bc97OHON-atSu31GCAfwT
X-Proofpoint-ORIG-GUID: ngiEvAIY_y1bc97OHON-atSu31GCAfwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

PCI BARs read from remote device
PCI config reads/writes sent to remote server

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c      | 243 ++++++++++++++++++++++++++-------------------
 hw/vfio/pci.h      |  10 ++
 hw/vfio/user-pci.c |  42 ++++++++
 3 files changed, 191 insertions(+), 104 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 90cf29325f..cd7bff2b4c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1728,7 +1728,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-static void vfio_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_teardown_msi(VFIOPCIDevice *vdev)
 {
     msi_uninit(&vdev->pdev);
 
@@ -1829,7 +1829,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_exit(VFIOPCIDevice *vdev)
+void vfio_bars_exit(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -1849,7 +1849,7 @@ static void vfio_bars_exit(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_finalize(VFIOPCIDevice *vdev)
+void vfio_bars_finalize(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2417,7 +2417,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     return;
 }
 
-static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -2766,7 +2766,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -2884,7 +2884,7 @@ static void vfio_err_notifier_handler(void *opaque)
  * and continue after disabling error recovery support for the
  * device.
  */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
+void vfio_register_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int32_t fd;
@@ -2943,7 +2943,7 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
+void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
                                       .index = VFIO_PCI_REQ_IRQ_INDEX };
@@ -2998,79 +2998,10 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-static void vfio_realize(PCIDevice *pdev, Error **errp)
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
-    ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
-    int i, ret;
-    char uuid[UUID_STR_LEN];
-    g_autofree char *name = NULL;
-
-    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
-        if (!(~vdev->host.domain || ~vdev->host.bus ||
-              ~vdev->host.slot || ~vdev->host.function)) {
-            error_setg(errp, "No provided host device");
-            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
-#ifdef CONFIG_IOMMUFD
-                              "or -device vfio-pci,fd=DEVICE_FD "
-#endif
-                              "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
-            return;
-        }
-        vbasedev->sysfsdev =
-            g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%01x",
-                            vdev->host.domain, vdev->host.bus,
-                            vdev->host.slot, vdev->host.function);
-    }
-
-    if (!vfio_device_get_name(vbasedev, errp)) {
-        return;
-    }
-
-    /*
-     * Mediated devices *might* operate compatibly with discarding of RAM, but
-     * we cannot know for certain, it depends on whether the mdev vendor driver
-     * stays in sync with the active working set of the guest driver.  Prevent
-     * the x-balloon-allowed option unless this is minimally an mdev device.
-     */
-    vbasedev->mdev = vfio_device_is_mdev(vbasedev);
-
-    trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
-
-    if (vbasedev->ram_block_discard_allowed && !vbasedev->mdev) {
-        error_setg(errp, "x-balloon-allowed only potentially compatible "
-                   "with mdev devices");
-        goto error;
-    }
-
-    if (!qemu_uuid_is_null(&vdev->vf_token)) {
-        qemu_uuid_unparse(&vdev->vf_token, uuid);
-        name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
-    } else {
-        name = g_strdup(vbasedev->name);
-    }
-
-    vbasedev->use_regfds = false;
-
-    if (!vfio_attach_device(name, vbasedev,
-                            pci_device_iommu_address_space(pdev), errp)) {
-        goto error;
-    }
-
-    if (!vfio_populate_device(vdev, errp)) {
-        goto error;
-    }
-
-    /* Get a copy of config space */
-    ret = pread(vbasedev->fd, vdev->pdev.config,
-                MIN(pci_config_size(&vdev->pdev), vdev->config_size),
-                vdev->config_offset);
-    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
-        ret = ret < 0 ? -errno : -EFAULT;
-        error_setg_errno(errp, -ret, "failed to read device config space");
-        goto error;
-    }
 
     /* vfio emulates a lot for us, but some bits need extra love */
     vdev->emulated_config_bits = g_malloc0(vdev->config_size);
@@ -3088,10 +3019,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->vendor_id != PCI_ANY_ID) {
         if (vdev->vendor_id >= 0xffff) {
             error_setg(errp, "invalid PCI vendor ID provided");
-            goto error;
+            return false;
         }
         vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
-        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
+        trace_vfio_pci_emulated_vendor_id(vdev->vbasedev.name, vdev->vendor_id);
     } else {
         vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
     }
@@ -3099,7 +3030,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->device_id != PCI_ANY_ID) {
         if (vdev->device_id > 0xffff) {
             error_setg(errp, "invalid PCI device ID provided");
-            goto error;
+            return false;
         }
         vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
         trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
@@ -3110,7 +3041,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->sub_vendor_id != PCI_ANY_ID) {
         if (vdev->sub_vendor_id > 0xffff) {
             error_setg(errp, "invalid PCI subsystem vendor ID provided");
-            goto error;
+            return false;
         }
         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
                                vdev->sub_vendor_id, ~0);
@@ -3121,7 +3052,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->sub_device_id != PCI_ANY_ID) {
         if (vdev->sub_device_id > 0xffff) {
             error_setg(errp, "invalid PCI subsystem device ID provided");
-            goto error;
+            return false;
         }
         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
         trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
@@ -3152,11 +3083,129 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_bars_prepare(vdev);
 
     if (!vfio_msix_early_setup(vdev, errp)) {
-        goto error;
+        return false;
     }
 
     vfio_bars_register(vdev);
 
+    return true;
+}
+
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+
+    /* QEMU emulates all of MSI & MSIX */
+    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
+        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
+               MSIX_CAP_LENGTH);
+    }
+
+    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
+        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
+               vdev->msi_cap_size);
+    }
+
+    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
+        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                                  vfio_intx_mmap_enable, vdev);
+        pci_device_set_intx_routing_notifier(&vdev->pdev,
+                                             vfio_intx_routing_notifier);
+        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
+        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
+        if (!vfio_intx_enable(vdev, errp)) {
+            pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+            kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+            return false;
+        }
+    }
+    return true;
+}
+
+static void vfio_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    int i, ret;
+    char uuid[UUID_STR_LEN];
+    g_autofree char *name = NULL;
+
+    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
+        if (!(~vdev->host.domain || ~vdev->host.bus ||
+              ~vdev->host.slot || ~vdev->host.function)) {
+            error_setg(errp, "No provided host device");
+            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
+#ifdef CONFIG_IOMMUFD
+                              "or -device vfio-pci,fd=DEVICE_FD "
+#endif
+                              "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
+            return;
+        }
+        vbasedev->sysfsdev =
+            g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%01x",
+                            vdev->host.domain, vdev->host.bus,
+                            vdev->host.slot, vdev->host.function);
+    }
+
+    if (!vfio_device_get_name(vbasedev, errp)) {
+        return;
+    }
+
+    /*
+     * Mediated devices *might* operate compatibly with discarding of RAM, but
+     * we cannot know for certain, it depends on whether the mdev vendor driver
+     * stays in sync with the active working set of the guest driver.  Prevent
+     * the x-balloon-allowed option unless this is minimally an mdev device.
+     */
+    vbasedev->mdev = vfio_device_is_mdev(vbasedev);
+
+    trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
+
+    if (vbasedev->ram_block_discard_allowed && !vbasedev->mdev) {
+        error_setg(errp, "x-balloon-allowed only potentially compatible "
+                   "with mdev devices");
+        goto error;
+    }
+
+    if (!qemu_uuid_is_null(&vdev->vf_token)) {
+        qemu_uuid_unparse(&vdev->vf_token, uuid);
+        name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
+    } else {
+        name = g_strdup(vbasedev->name);
+    }
+
+    vbasedev->use_regfds = false;
+
+    if (!vfio_attach_device(name, vbasedev,
+                            pci_device_iommu_address_space(pdev), errp)) {
+        goto error;
+    }
+
+    if (!vfio_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    /* Get a copy of config space */
+    ret = pread(vbasedev->fd, vdev->pdev.config,
+                MIN(pci_config_size(&vdev->pdev), vdev->config_size),
+                vdev->config_offset);
+    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
+        ret = ret < 0 ? -errno : -EFAULT;
+        error_setg_errno(errp, -ret, "failed to read device config space");
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
     if (!vbasedev->mdev &&
         !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set iommu_device: ");
@@ -3200,28 +3249,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
-    /* QEMU emulates all of MSI & MSIX */
-    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
-        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
-               MSIX_CAP_LENGTH);
-    }
-
-    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
-        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
-               vdev->msi_cap_size);
+    if (!vfio_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
     }
 
-    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
-        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                                  vfio_intx_mmap_enable, vdev);
-        pci_device_set_intx_routing_notifier(&vdev->pdev,
-                                             vfio_intx_routing_notifier);
-        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
-        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        if (!vfio_intx_enable(vdev, errp)) {
-            goto out_deregister;
-        }
-    }
+    /*
+     * vfio_interrupt_setup will have setup INTx's KVM routing
+     * so errors after it succeeds must use out_deregister
+     */
 
     if (vdev->display != ON_OFF_AUTO_OFF) {
         if (!vfio_display_probe(vdev, errp)) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c0f030f4db..5fe6eb282c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,16 @@ Object *vfio_pci_get_object(VFIODevice *vbasedev);
 int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
 int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
 void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp);
+void vfio_teardown_msi(VFIOPCIDevice *vdev);
+void vfio_bars_exit(VFIOPCIDevice *vdev);
+void vfio_bars_finalize(VFIOPCIDevice *vdev);
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+void vfio_put_device(VFIOPCIDevice *vdev);
+void vfio_register_err_notifier(VFIOPCIDevice *vdev);
+void vfio_register_req_notifier(VFIOPCIDevice *vdev);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_instance_init(Object *obj);
 
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index aa5146db0a..5758e1e234 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -78,6 +78,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     AddressSpace *as;
     SocketAddress addr;
     VFIOUserProxy *proxy;
+    int ret;
 
     /*
      * TODO: make option parser understand SocketAddress
@@ -130,8 +131,45 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    /* Get a copy of config space */
+    ret = vbasedev->io->region_read(vbasedev, VFIO_PCI_CONFIG_REGION_INDEX, 0,
+                               MIN(pci_config_size(pdev), vdev->config_size),
+                               pdev->config);
+    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
+        error_setg_errno(errp, -ret, "failed to read device config space");
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
+    if (!vfio_add_capabilities(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    if (!vfio_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    vfio_register_err_notifier(vdev);
+    vfio_register_req_notifier(vdev);
+
     return;
 
+out_teardown:
+    vfio_teardown_msi(vdev);
+    vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
@@ -167,6 +205,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    vfio_bars_finalize(vdev);
+    g_free(vdev->emulated_config_bits);
+    g_free(vdev->rom);
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
-- 
2.34.1


