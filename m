Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737B0E7719B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdO-0006SC-79; Wed, 08 Jan 2025 06:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdA-0006Pc-Bp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd6-0002Dt-Iu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:47 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085dSj2010866;
 Wed, 8 Jan 2025 03:53:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MkxgI9sptPzpgqeAPFASSLEQ68AGziyzHdJmBlg2R
 l8=; b=blHaHu+31nbMYSrccdf47E9E7g3GMJ+s8ip8YvZA7E0ZIkLM1NZKrWqdU
 0S/omq6d8MJ3AN5A6SqnKeL4DrB2SMDpn/eZTvqCTcxZsGL0LIjg1nwBLYoXD6pW
 o6F6mAi2/qLl6rrkzospIDuXsLyLDK/Ti74edI5DPV0ZWmMxj8PRxf57cNNbO2WP
 fhZb5ivfPqk+/d4BOHo04T79oYhpp+LcGVm590T2ofpcbg7375ZgxclRUE0MvYbA
 mlTdRF2gNoX0b08jJoOdg8xiV+M7niKx8ohgA4WU3pAnvnbd+wBN7rODsFNY3s0q
 1736BcLik9JuHM2rnJFZ87hNVLLAA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y4xmyd10-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbbuCXaadoo3DolXoytrOVCkGWI6a4Saud/15Znw26pAqhHJI7z8jAdPgkuuZTGEgZ0mPnKXZUF+4QCgFIW0T3oFiL5+hXcolLCZQsKV0Pmx4jXtIIuUncphX64EIX/SMSGlreCYDVGEnofmqesj96QV4veE3/5AeZV/iOM8y5cwe1rpKJt2wmlFsUTuWJmn1jsTTPg8ApARz9DCy88Ee44vYKfS8NeGicc6SKWyn5Ph9hWJrRQNe2TIy8GxOboGgYZ5hzSYkJZo4qESgMgFTlmvk00KS2D5xbgJ45DfHfF5hAaESYPGflNagCz6gOkgESoDGRBbXGj4SU5HhaPe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkxgI9sptPzpgqeAPFASSLEQ68AGziyzHdJmBlg2Rl8=;
 b=QmirLhN1zrUDX2O9XkQGkGqVfjwtoEYT/UhwNo19HmdM27z/IRUmSiz/Lcg7IMzVb2y5lm7fjkNsOBztVX3K3MxZTY2x3lrV6aCI/AKnbQa7numyJ/WaOgGPk5C3WLstJfUCRqNXv6MSKJEVRF2/CiXtD2h0M8eDbWrhKgaXy2BGjati1QSc9B55y/48omVCG0YSeBRISbhF9Zykg+Cdp4L7lfZqSm2TuH1hRDrTvZM5pSFFqtb3e4kfVJEw75wQMe9ANvvPVyInMt1YaetAgSNiF6/r0GPINriKG3VLdgJNippNqeSWGWbU4R3NBSq40JLqJHTrUJhp8Tn+dqK7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkxgI9sptPzpgqeAPFASSLEQ68AGziyzHdJmBlg2Rl8=;
 b=p+usGEYfUMDIqxWEJa4ni4by71FcxoRke1ZD0H4IdzsljP2ioQ+WqNsO2frfqzKsumNODyuEKRawUM+RGjnjzU6AT7TRA+kDps/0u9yO3CdlnEjy6pWWZG53rCZWkXWaz7tjCt2VTND1Fosba83yVP+E0UT3StzSBGauPQuM+5BiIENYtyvV3DDumKp8FkXvRbfAWq83TqB6g4CY9kY7xxLLSZJVKuFkgKxFrs1yD/t4KXDmhPa5o3gBNHqt6UdcKT/vvxdOBBXTdo+wuHivhDCFJhqYpzjCkm0VK53/TJarD1O90MJhtikf/wokN5rLytItPXdhJIO2dIiGhv+SPw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:40 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:40 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 08/26] vfio: add device IO ops vector
Date: Wed,  8 Jan 2025 11:50:14 +0000
Message-Id: <20250108115032.1677686-9-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 3163207d-473d-4eca-de6c-08dd2fdb17a4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0OmwfhlHB0BomrBDsWF9yhv6cncb74Wm90j2oTC2Zp3ferlq4BbnZB2GND0X?=
 =?us-ascii?Q?J5NxtHhQurrbOREDz3gEsc8ioe1f0AqyAWIFtNhw29/rXZXe4TyQimE5EMcA?=
 =?us-ascii?Q?l7CfUQMfObw/26qSnWtanUIAS4BVzZ7TNox5UpmHmBbUJCPN1CTw1/Ls3ffW?=
 =?us-ascii?Q?r4SpfEr4BsxbiZjs6A/cBRW6dLjo0Vskh48spmnJT68fupv/nXR/RWQY1KD2?=
 =?us-ascii?Q?SriBUW3md5lwhwZKP1WrvA9+3difQ5vmqSZAgEng3/oKZ+XfwVXZv5wSxGKt?=
 =?us-ascii?Q?RdRzuTG9eG7Ew/rParrFXXt0W2Pmi82p2tIszd13x34hj9t5y9LrcDVfsPyt?=
 =?us-ascii?Q?Nrw1keFSFJmju6GCLO4hTqtpRxoqRY7jsus1e5/ymZA/btdVG+xuFx89jSMh?=
 =?us-ascii?Q?PvKt6DivA7WSYg8LVhAvsaePIONJDykEaLiX7PuyVg8KT9a1er3wtp4BTee4?=
 =?us-ascii?Q?9n8YcEf5jEP9h4EToLnB+OE2BVnM6OlTpz3uDgi7YUaT1cAGjfBkIIj8850r?=
 =?us-ascii?Q?FIG+JzzkVu/Cm0amsto7a6+0ecAckzkzweOAyGvlxjUYg76DW93q3ISztSJg?=
 =?us-ascii?Q?RWeHvlI210e7BiVeXk6S9KwW56/4pMwYjx1YXz5FI+QEJnLCjMdECoq4FsPj?=
 =?us-ascii?Q?jw/VQEpix1CPKnVxcEArc6J8oOkHIMdYPkiRIJc07JeBRUzevQqvJSgQYDJg?=
 =?us-ascii?Q?8NFXTqDJb2kU+fjk1EGJIs0pe0Jyiu/5AWHOrRttYLV7iqr987FXi3au2iDL?=
 =?us-ascii?Q?LS4II9m05QelyOSvnoAW3NcUnardzfXr1QVJ3N2D7aib1sWqJuTldh3rGkl2?=
 =?us-ascii?Q?ORLjrNia10yWs+EBIE0z3C4D5NBG+OvAzpu25usV39sDUogmdpykJGgl0qcf?=
 =?us-ascii?Q?V4E8/oa7xi5vQ3iOtqa3KQFseqSm+ltzmI1ri3erGXj7Yqvd3sqT78uYNhgX?=
 =?us-ascii?Q?Jlg1h0XGxJQQ1Dd9HYaBEpyc7jMu4QdAEWBs6bLINn+3p5GECznZ2h67pOTC?=
 =?us-ascii?Q?3FSHizYz24a0vAkKTn72pGS4T7C1EACQAADiBa+LyMW618Xf+JwXfqvnjXGS?=
 =?us-ascii?Q?9hLk6UqftHryTYBuHNIqThGGaeI3/AkqqK0vy/F7cDvsAlbCHjX9Ph99jN3A?=
 =?us-ascii?Q?S1oGtRGud+HrhVgQZL/LkrT7CvCw1DuDdLVeLmgfGH3kTXrBzpz9EKKZgPCn?=
 =?us-ascii?Q?iyyQs2VTZvbadvU9GGk0BoRnmcTVDJe69OwjbAcqTi2wW5E6Poo0q40QbmJQ?=
 =?us-ascii?Q?tWOLYeNaHTaPzGoC82eS0zI39l7CvDMdGw70fToAyifGQ2JilU6TvVfBRCOS?=
 =?us-ascii?Q?J4H+0+QH7axj/V0YGnHXAjTztH15iobAbrGquwk/4Sqm2jlyKhvw23USf7HS?=
 =?us-ascii?Q?cnGh3qTzXgkwWUFUbd8L3WtPyJ0b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5U/N7y3e56t8JSB6dMlgRFsLa1c56rr3NGwF8qVd7VMOcIH8CMzby6zEVX+v?=
 =?us-ascii?Q?BSJiqA12G/IFuj1MeB1wiUezN8daSqQ/yyQ6XNbUODRb5tnoxXN0FfZm6QW0?=
 =?us-ascii?Q?emSI8sUiZHNxckRlxHPUtmgfEZaZ2jyQQH8vxuitGRYN4nUkiLgL7R7rFA9O?=
 =?us-ascii?Q?tiV9V263juhbliO2pUUsUk6+ueYYGvWg277nTv08LdS7q3nA7rRdsNu5yB+V?=
 =?us-ascii?Q?HLsNtj6RuvVwW+SrhwvKLVl63oF/i2ytvFK5kwEQCKtchC8dSbSE5kRZaOU/?=
 =?us-ascii?Q?7/qlnlpntkCuEO4sQD6QFmPHQas4Peh28lpjGARyynFo11gfWPhMAIAM8tb1?=
 =?us-ascii?Q?EWSOHb4Mro3/Bo0GjQR3VABxSiECzaUuRlLYJtM1md/JDYtl2eXnTg0BIO9g?=
 =?us-ascii?Q?5BY3sphTXf49Eq8AuU65AcUnSp52Wl+gtPPqv9SVGDYMVAjM1PGNF2pkzBkJ?=
 =?us-ascii?Q?Z6T9H/ox4ZJiBOoGqjwJ68CDD14+KtNLEBp6yk7Q3khjU8DD+EKGYuw9V0PE?=
 =?us-ascii?Q?EoWtLsBhtVDEzmN+y/Z3Rz8hQxe8OQ7BAhXCfOICIuLs5ib/1JSXlQndI1u/?=
 =?us-ascii?Q?w3dJdW2hEpfbWRKyC5AeOZZUpVZyQnW9fkpiEiRf0R4xaQtCvzlCeLOa+Lcq?=
 =?us-ascii?Q?cH+eH76iC1kOdMaOFnByHab55ex8ym+wUL8FI1dSDvFpTV4z0FOaW+NBKJsL?=
 =?us-ascii?Q?3H7Yhz44I/pIlwh0gHbyRSARYM9pf2SUeSGUMkpH6VtXU9hDvgR6lPIrKciW?=
 =?us-ascii?Q?D8vRtBTVtfb3m+374xKv9Y9thU8qGDIyJpaXTmhiIB3V1cSNP+HMOLML6qcf?=
 =?us-ascii?Q?scRyxcOor1Cmaq9Ch8o4oJ+cZSz+LZUQut8CFatNs+Q8puI1F7OQhTA+i7ii?=
 =?us-ascii?Q?6CwUMZ/I9XH4LvylYFjgOI35ZsGkt0zQyO2daTqOePqkS0oVdzNSwiFYe2/V?=
 =?us-ascii?Q?cwKwfdyzL6f1vegiF/lKrPtOtxzEF/tefCApN7+xwLaX2w///xsFwbHGqmOf?=
 =?us-ascii?Q?vF34AfYNk78kAIDoqSpMV9pvQGdqxE862qbhRFLZ5oFEe9c3n4RF0qYr7sPV?=
 =?us-ascii?Q?RJQGa4MxLwcZKAqUgGoIzmi3Kl4r5jgoE1kBwvHMffYfKUs4wWtBrU3Lf+/S?=
 =?us-ascii?Q?6bE4MDbZUOQCbuL/LxhG1L5UZay+Z+kBQItuCZf9Pf+LJO+WDV3XNf8XErQ0?=
 =?us-ascii?Q?GPYawoqRoc22oSDQM4k6eFr5I0p26xrywjUx5woAWZpo0xsYoIpQFdwLX5JH?=
 =?us-ascii?Q?3cQm9ra9PINjqsXvK6hbHKHJMedzYe+GriCN8kCUcxExV7YFxc7UXJXlRQik?=
 =?us-ascii?Q?QiGGtuBDxAwOHaLzQXX16o3flq9pTXark+mcLuORg/5emzxnBRUnfAhNDJ7/?=
 =?us-ascii?Q?Vuwl24d3XkDsaWfhs8dfMzzTlh3Za2hEHpw+b4izKADgSndRMmNfZVWlRej8?=
 =?us-ascii?Q?2XvScZmuBPDaCM86Gsgp2Rhc9oYkuHfHCsFT2JgkFHhFJ/7gGQYRzYqShYp1?=
 =?us-ascii?Q?EQE0n6oct3nLN+KsdRRquHfBWSDfTWhP5A+3027pB5jtXeSyxl3EU6HJa/cj?=
 =?us-ascii?Q?P6AXOXoGq6Tn2C7lBdR5zs0zL5N231yGNUWVv8+C?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3163207d-473d-4eca-de6c-08dd2fdb17a4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:39.9296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HKt5RtjecOC9VHtQgbVhTNDyTDJGYgB6Idg86r6mpF35FRSfKAZ1iUDPJaKFAMxbHJqLk0qgOufREjWYTcqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-GUID: 7Nbk_xoMSJLxYiY_vwcR8EjmNsK83Lx6
X-Proofpoint-ORIG-GUID: 7Nbk_xoMSJLxYiY_vwcR8EjmNsK83Lx6
X-Authority-Analysis: v=2.4 cv=aaybnQot c=1 sm=1 tr=0 ts=677e6745 cx=c_pps
 a=2scX5b6JGDBY9+deG5t9BQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=S7NjNkv4iZBI8J4Jy6QA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Used for communication with VFIO driver
(prep work for vfio-user, which will communicate over a socket)

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ap.c                  |   2 +-
 hw/vfio/ccw.c                 |   2 +-
 hw/vfio/common.c              |   7 +-
 hw/vfio/helpers.c             | 100 +++++++++++++++++++++++--
 hw/vfio/pci.c                 | 137 +++++++++++++++++++++-------------
 hw/vfio/platform.c            |   2 +-
 include/hw/vfio/vfio-common.h |  27 ++++++-
 7 files changed, 211 insertions(+), 66 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 30b08ad375..1adce1ab40 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -228,7 +228,7 @@ static void vfio_ap_instance_init(Object *obj)
      * handle ram_block_discard_disable().
      */
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
-                     DEVICE(vapdev), true);
+                     &vfio_dev_io_ioctl, DEVICE(vapdev), true);
 
     /* AP device is mdev type device */
     vbasedev->mdev = true;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 22378d50bc..8c16648819 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -682,7 +682,7 @@ static void vfio_ccw_instance_init(Object *obj)
      * ram_block_discard_disable().
      */
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_CCW, &vfio_ccw_ops,
-                     DEVICE(vcdev), true);
+                     &vfio_dev_io_ioctl, DEVICE(vcdev), true);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c0a6263678..edc1efc251 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -953,7 +953,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
             continue;
         }
 
-        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        if (vbasedev->io->device_feature(vbasedev, feature)) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
                         vbasedev->name, -errno, strerror(errno));
         }
@@ -1056,9 +1056,8 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
             continue;
         }
 
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        ret = vbasedev->io->device_feature(vbasedev, feature);
         if (ret) {
-            ret = -errno;
             error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
                              vbasedev->name);
             goto out;
@@ -1137,7 +1136,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+    if (vbasedev->io->device_feature(vbasedev, feature)) {
         return -errno;
     }
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index a8951176b8..529520c1d6 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -43,7 +43,7 @@ void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
         .count = 0,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
@@ -56,7 +56,7 @@ void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
@@ -69,7 +69,7 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
 static inline const char *action_to_str(int action)
@@ -116,6 +116,7 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     int argsz;
     const char *name;
     int32_t *pfd;
+    int ret;
 
     argsz = sizeof(*irq_set) + sizeof(*pfd);
 
@@ -128,7 +129,9 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     pfd = (int32_t *)&irq_set->data;
     *pfd = fd;
 
-    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+    ret = vbasedev->io->set_irqs(vbasedev, irq_set);
+
+    if (!ret) {
         return true;
     }
 
@@ -160,6 +163,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint32_t dword;
         uint64_t qword;
     } buf;
+    int ret;
 
     switch (size) {
     case 1:
@@ -179,7 +183,8 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+    ret = vbasedev->io->region_write(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
                      ",%d) failed: %m",
                      __func__, vbasedev->name, region->nr,
@@ -211,8 +216,10 @@ uint64_t vfio_region_read(void *opaque,
         uint64_t qword;
     } buf;
     uint64_t data = 0;
+    int ret;
 
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+    ret = vbasedev->io->region_read(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
                      __func__, vbasedev->name, region->nr,
                      addr, size);
@@ -560,6 +567,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int ret;
 
     /* create region cache */
     if (vbasedev->regions == NULL) {
@@ -578,7 +586,8 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+    ret = vbasedev->io->get_region_info(vbasedev, *info);
+    if (ret != 0) {
         g_free(*info);
         *info = NULL;
         return -errno;
@@ -688,11 +697,12 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 }
 
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
-                      DeviceState *dev, bool ram_discard)
+                      VFIODeviceIO *io, DeviceState *dev, bool ram_discard)
 {
     vbasedev->type = type;
     vbasedev->ops = ops;
     vbasedev->dev = dev;
+    vbasedev->io = io;
     vbasedev->fd = -1;
 
     vbasedev->ram_block_discard_allowed = ram_discard;
@@ -739,3 +749,77 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
 
     return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
 }
+
+/*
+ * Traditional ioctl() based io
+ */
+
+static int vfio_io_device_feature(VFIODevice *vbasedev,
+                                  struct vfio_device_feature *feature)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_get_region_info(VFIODevice *vbasedev,
+                                   struct vfio_region_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_get_irq_info(VFIODevice *vbasedev,
+                                struct vfio_irq_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_set_irqs(VFIODevice *vbasedev, struct vfio_irq_set *irqs)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_region_read(VFIODevice *vbasedev, uint8_t index, off_t off,
+                               uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->regions[index];
+    int ret;
+
+    ret = pread(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
+                                uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->regions[index];
+    int ret;
+
+    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+VFIODeviceIO vfio_dev_io_ioctl = {
+    .device_feature = vfio_io_device_feature,
+    .get_region_info = vfio_io_get_region_info,
+    .get_irq_info = vfio_io_get_irq_info,
+    .set_irqs = vfio_io_set_irqs,
+    .region_read = vfio_io_region_read,
+    .region_write = vfio_io_region_write,
+};
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bb0d26915b..c6d7ebfd9b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -45,6 +45,14 @@
 #include "migration/qemu-file.h"
 #include "system/iommufd.h"
 
+/* convenience macros for PCI config space */
+#define VDEV_CONFIG_READ(vbasedev, off, size, data) \
+    ((vbasedev)->io->region_read((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
+                                 (off), (size), (data)))
+#define VDEV_CONFIG_WRITE(vbasedev, off, size, data) \
+    ((vbasedev)->io->region_write((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
+                                  (off), (size), (data)))
+
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
 /* Protected by BQL */
@@ -379,6 +387,7 @@ static void vfio_msi_interrupt(void *opaque)
 static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_irq_set *irq_set = NULL;
+    VFIODevice *vbasedev = &vdev->vbasedev;
     int ret = 0, argsz;
     int32_t *fd;
 
@@ -394,7 +403,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
     fd = (int32_t *)&irq_set->data;
     *fd = -1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vbasedev->io->set_irqs(vbasedev, irq_set);
 
     return ret;
 }
@@ -453,7 +462,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
         fds[i] = fd;
     }
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vdev->vbasedev.io->set_irqs(&vdev->vbasedev, irq_set);
 
     g_free(irq_set);
 
@@ -879,13 +888,14 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
 
-    if (vfio_get_region_info(&vdev->vbasedev,
-                             VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
+    if (!vfio_get_region_info(vbasedev,
+                              VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
         error_report("vfio: Error getting ROM info: %m");
         return;
     }
@@ -911,18 +921,19 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
-                      size, vdev->rom_offset + off);
+        bytes = vbasedev->io->region_read(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
+                                          off, size, vdev->rom + off);
         if (bytes == 0) {
             break;
         } else if (bytes > 0) {
             off += bytes;
             size -= bytes;
         } else {
-            if (errno == EINTR || errno == EAGAIN) {
+            if (bytes == -EINTR || bytes == -EAGAIN) {
                 continue;
             }
-            error_report("vfio: Error reading device ROM: %m");
+            error_report("vfio: Error reading device ROM: %s",
+                         strerror(-bytes));
             break;
         }
     }
@@ -1010,11 +1021,10 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
-    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
     DeviceState *dev = DEVICE(vdev);
     char *name;
-    int fd = vdev->vbasedev.fd;
 
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
@@ -1031,11 +1041,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
      * Use the same size ROM BAR as the physical device.  The contents
      * will get filled in later when the guest tries to read it.
      */
-    if (pread(fd, &orig, 4, offset) != 4 ||
-        pwrite(fd, &size, 4, offset) != 4 ||
-        pread(fd, &size, 4, offset) != 4 ||
-        pwrite(fd, &orig, 4, offset) != 4) {
-        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
+    if (VDEV_CONFIG_READ(vbasedev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
+        VDEV_CONFIG_WRITE(vbasedev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        VDEV_CONFIG_READ(vbasedev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        VDEV_CONFIG_WRITE(vbasedev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
+
+        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
         return;
     }
 
@@ -1215,6 +1226,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1227,12 +1239,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
     if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
         ssize_t ret;
 
-        ret = pread(vdev->vbasedev.fd, &phys_val, len,
-                    vdev->config_offset + addr);
+        ret = VDEV_CONFIG_READ(vbasedev, addr, len, &phys_val);
         if (ret != len) {
-            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
-                         __func__, vdev->vbasedev.name, addr, len);
-            return -errno;
+            const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
+                         __func__, vbasedev->name, addr, len, err);
+            return -1;
         }
         phys_val = le32_to_cpu(phys_val);
     }
@@ -1248,15 +1261,19 @@ void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
+    int ret;
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
 
     /* Write everything to VFIO, let it filter out what we can't write */
-    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
-                != len) {
-        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
-                     __func__, vdev->vbasedev.name, addr, val, len);
+    ret = VDEV_CONFIG_WRITE(vbasedev, addr, len, &val_le);
+    if (ret != len) {
+        const char *err = ret < 0 ? strerror(-ret) : "short write";
+
+        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
+                     __func__, vbasedev->name, addr, val, len, err);
     }
 
     /* MSI/MSI-X Enabling/Disabling */
@@ -1344,9 +1361,12 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     int ret, entries;
     Error *err = NULL;
 
-    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
+    ret = VDEV_CONFIG_READ(&vdev->vbasedev, pos + PCI_CAP_FLAGS,
+                           sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        const char *errmsg = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS %s", errmsg);
         return false;
     }
     ctrl = le16_to_cpu(ctrl);
@@ -1550,34 +1570,43 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
  */
 static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
-    int ret, fd = vdev->vbasedev.fd;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
                                       .index = VFIO_PCI_MSIX_IRQ_INDEX };
     VFIOMSIXInfo *msix;
+    int ret;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         return true;
     }
 
-    if (pread(fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
+    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_FLAGS,
+                           sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX FLAGS %s", err);
         return false;
     }
 
-    if (pread(fd, &table, sizeof(table),
-              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
+    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_TABLE,
+                           sizeof(table), &table);
+    if (ret != sizeof(table)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX TABLE %s", err);
         return false;
     }
 
-    if (pread(fd, &pba, sizeof(pba),
-              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
+    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_PBA, sizeof(pba), &pba);
+    if (ret != sizeof(pba)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX PBA %s", err);
         return false;
     }
 
@@ -1592,7 +1621,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vdev->vbasedev.io->get_irq_info(&vdev->vbasedev, &irq_info);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
@@ -1736,10 +1765,12 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Determine what type of BAR this is for registration */
-    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
-                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
+    ret = VDEV_CONFIG_READ(&vdev->vbasedev, PCI_BASE_ADDRESS_0 + (4 * nr),
+                           sizeof(pci_bar), &pci_bar);
     if (ret != sizeof(pci_bar)) {
-        error_report("vfio: Failed to read BAR %d (%m)", nr);
+        const char *err =  ret < 0 ? strerror(-ret) : "short read";
+
+        error_report("vfio: Failed to read BAR %d (%s)", nr, err);
         return;
     }
 
@@ -2439,21 +2470,25 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
 void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     Error *err = NULL;
-    int nr;
+    int ret, nr;
 
     if (!vfio_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
-        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
+        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
         uint32_t val = 0;
         uint32_t len = sizeof(val);
 
-        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
-            error_report("%s(%s) reset bar %d failed: %m", __func__,
-                         vdev->vbasedev.name, nr);
+        ret = VDEV_CONFIG_WRITE(vbasedev, addr, len, &val);
+        if (ret != len) {
+            const char *errmsg = ret < 0 ? strerror(-ret) : "short write";
+
+            error_report("%s(%s) reset bar %d failed: %s", __func__,
+                         vbasedev->name, nr, errmsg);
         }
     }
 
@@ -2795,7 +2830,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
     irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
         trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
@@ -2916,8 +2951,10 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
+    if (vdev->vbasedev.io->get_irq_info(&vdev->vbasedev, &irq_info) < 0) {
+        return;
+    }
+    if (irq_info.count < 1) {
         return;
     }
 
@@ -3345,7 +3382,7 @@ static void vfio_instance_init(Object *obj)
     vdev->host.function = ~0U;
 
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_pci_ops,
-                     DEVICE(vdev), false);
+                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
 
     vdev->nv_gpudirect_clique = 0xFF;
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 1070a2113a..1194e55807 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -648,7 +648,7 @@ static void vfio_platform_instance_init(Object *obj)
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PLATFORM, &vfio_platform_ops,
-                     DEVICE(vdev), false);
+                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 59348b81aa..1104ed63e3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -116,6 +116,7 @@ typedef struct VFIOIOMMUFDContainer {
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIODeviceIO VFIODeviceIO;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -136,6 +137,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     bool migration_events;
     VFIODeviceOps *ops;
+    VFIODeviceIO *io;
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
@@ -186,6 +188,29 @@ struct VFIODeviceOps {
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
+#ifdef CONFIG_LINUX
+
+/*
+ * How devices communicate with the server.  The default option is through
+ * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
+ * process.
+ */
+struct VFIODeviceIO {
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+    int (*get_region_info)(VFIODevice *vdev,
+                           struct vfio_region_info *info);
+    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
+    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                       void *data);
+    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                        void *data);
+};
+
+extern VFIODeviceIO vfio_dev_io_ioctl;
+
+#endif /* CONFIG_LINUX */
+
 typedef struct VFIOGroup {
     int fd;
     int groupid;
@@ -316,6 +341,6 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
-                      DeviceState *dev, bool ram_discard);
+                      VFIODeviceIO *io, DeviceState *dev, bool ram_discard);
 int vfio_device_get_aw_bits(VFIODevice *vdev);
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


