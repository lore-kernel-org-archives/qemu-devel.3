Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBBFCDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbclz-0004RL-Pv; Mon, 22 Jun 2026 07:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclj-0004J1-Mi; Mon, 22 Jun 2026 07:24:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclP-0001RB-4Z; Mon, 22 Jun 2026 07:24:44 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAoYHt023037; Mon, 22 Jun 2026 04:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dR3+N2aw9U9kf+VthbZifqsWgG2Xp8bM7rKKEjNgm
 3c=; b=UPHl0mv0zA6C/s/4buT0V8W1y7seoQ12vea3uh991MYTIyU95Mr0vlb4/
 6QQMLgl7YV1NnCYKpn+UYMDu199GbBV+ZNJrDAjQndnLUwPfv7v1nwjMJTLlB/ZS
 V/OstkYGwH5Zg563SI0NPZV0j14U0XJHCRq/+McYWUat2C40878v4xSWKC1TWtqh
 RvTQatrdUG5paxNTIwZyCy8rN03roPNFv21pUHytFSyH8fG2pYxCVXPWGtwHcz+c
 BoXfZEqi5E+Flb1iMoSzkiKSGzG0OFqWdDZ7gdkAql3AV5gJeCAyFi17ab6zfna9
 x8upVeQAqyx0/srdLIWXcy4FwvH3g==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021112.outbound.protection.outlook.com [52.101.52.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewrd8ujb7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHOvJRCAxrogCGgk6DtItS45XZ5j+bMnA6GwxMyI6wiR43nDWwEsCeHyMAvAFzot9d+JZyx2KW9oAhyVgiJpzCMx7xMz80uE+0I1POJZLTLiY2rHt+i9wU1c7yyIqVodUtHi2AOTHIiZoFKE4qn18udf8FITk+m2LD4WW08QL3e+Q1dirV7xU9wBk4bgJyFy/DVDbXjJUUV2nrHl1EAs9MJAN1nU2+kVA/Mj3Um+8mxjdNpg9s8zcJFQ8cr4gsVgBxGCSrgJG47IHiLy2iSomGXP6XC8UhJOJslUKk+6hdt/WCmB2mW/hetRLMDHAymdnV1Yp6OVIt9EPW4/7dGV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR3+N2aw9U9kf+VthbZifqsWgG2Xp8bM7rKKEjNgm3c=;
 b=qevNYJI0tCbkjQfxz+RArcWY4at/7Q9smVSXfxOeYqxXdAZ7mmAt6lSXxnvoYoClH+QfRyOeUHKL2jeYflSYf45zXtjgsTi9OPHAjqTL96jV3MCx6CByjF4h1Zmqv7VgjplFORLxNq9DIZ5cO9CyaIEpWLsgdkXaezNN+/OGBLThtgc75EocZEc7THmK6fQPJ+4zkar1YBKO+aC6b8pJD578a02MUiiXSF6MzuekgoQgge2LUn1JFTq4WlrDLzXOZzfkueccjmmfEHrtD9ajalm/p6HGSnHd9+LhTKDgtY0Cww/jDGDFACIj0dtZFFv+xeNuHT23zK34Q4oOV+jAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR3+N2aw9U9kf+VthbZifqsWgG2Xp8bM7rKKEjNgm3c=;
 b=cWpyan/xEC9n8h00rgkEIhhhy6b1EnNBe9yr7wzL2CeVK7TQD8CDWYye/anSv2OG8KudkUaTEXyBvVaPcfF4Tfzvzo4F87kEyiUF6bdINIvWqNuKG0ikLrW0GWT2WQKM9XcVWZQqPZQRJjZHtivGNUcIXyGbvcwoqdidhSAFKjPpGc7mX9BS/c00c/eVCkgtRkAkEETYmRDLZJgfr7prPsDJB+R6iXoYk4/opNm2wjigiyAAEmBlQMQSFJ5e/wB57wLetuHH8ByRszH9A3fssa5+gYy3+R3kiHFmxLCzAacxlINN4Vph4FULZW1By1ap9Ic5Fi0eqAdZTCA0bLn3Sg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 1/7] hw/acpi/ich9.c: move initial property values into
 ich9_reset_properties()
Date: Mon, 22 Jun 2026 12:22:33 +0100
Message-ID: <20260622112403.928954-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622112403.928954-1-mark.caveayland@nutanix.com>
References: <20260622112403.928954-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fa342e-f881-4c49-2892-08ded050c81a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: vVoZ+xUacH7gEjEgFTXXlYbn/8y4bHjJrImj5p1XuRVFlOBnPERRPry2nHG8yHX341Q+kxsh4eTT+Cjs1sbEtHQ8MIARXtXS2MvvgpcrmgEYGrJwKCaUH8PZLJ9LAknbmo/5/C6ycwGlHh+q2frNR6HGwvDm1UzmgseJEAWMZpwu1e/ayU42hsX7bb3qGsR0VX0uTrW5VSnFjGal4Xx44n0qHTK6YS0f+YAFbuNuWly5JJi3m9PJohkEwz9oATy7ADGl3PuuedBydwZSTxt5ykoNNmqTM1OO4L3OoJ6pQKfbQMQhJwLBzoMZw0bjXCq+/njK8jrOFyWd9DmoTP1cgQl9QdNWV10c5PXG/VJUtuMkPlwzDDztobTqCN/TwB0iI9PHJgnUdclOIe4lCwxUd880t2/H32s2MD0Eg5lE86073yNaksNzUWhU3NlP4nbLQTqeJWkoAdTf3UpZtuyRDs7BNLsChYIGfLH17J1r7KQcANmUHD3FG9TNgXQLfsaE7l/Brb3YhHuh4xM8Y18XLGk+2xlAtBMUqdWYUDVpidJVCjj2XCe2KQpI/byRJvVVido0gZfhrMufaEsQRZw/60AgoWhO25M1v3AlGw3G/Vg+D9FZ4mfD9nDW8Wto/2Iv1hm0EKSMi45YKjqFo9lbnnpq0fALS4rN+W7SModNR54zcuIV5AC0mD6FObIjvuJyDdyLGIneVElEpwuUXo4AQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w4MZvQuTNoRO4J2PtqUectbC19HUBAflXtZ+lw6VwIjVAOuFUi83yqHVQs56?=
 =?us-ascii?Q?vkv/bq6fE7llpy6zWTzXjGH4RzbAJR02osNdE2iv391YQEKg9Pew5Cu1rfgW?=
 =?us-ascii?Q?baWTrQdsxfX86H8Pmu+3DK58fGNTzrAhjUN4Ldd8Yq0+5A4+OUqlrboALcx3?=
 =?us-ascii?Q?tocz9c80ffVW/TwIgvZ1FtcBZQngVFFfyeBE2DAgW2RRaiIBfueNlY6bQYE1?=
 =?us-ascii?Q?lYK7ikvHbz7WBXpMF82Lq4O7MakODjyeQjVAQkNPQsYTL4WTJ7sbaAUKPV3p?=
 =?us-ascii?Q?oYtPQI/Pk1dDbhppHrodIsjwP18Y+VPOAqrJOaeUy8VN1IL6hnOPJAQtFY26?=
 =?us-ascii?Q?G2bgDtA6iYV9YXaBguktXdxHkoJYJMrzbhcuFBCfj+eO8VG8ZNopI24ymyy0?=
 =?us-ascii?Q?8Rx7eM8D8QCt5/nKPp6ptlwBug9/69QGWZGbjjEuHx8aTxqT6am6h94viQTT?=
 =?us-ascii?Q?Mous0bq6qVBn8DiFxT6M/QDv/GpTkn/wVxXLNrfzsvaHxq0cztuoA+ZAnLAQ?=
 =?us-ascii?Q?qIhG2gn6NiHdEhnwhPw//7zDcQ9nZuyweQd+GMCrfiAvmhvfMPO/MBWjEx9S?=
 =?us-ascii?Q?Vu2c3UTDlx1KME2H9kkz5M59zHEDZG1S6mgmhRwOiyXKIxTUvqhOzVdMb8Ry?=
 =?us-ascii?Q?6pARHfAqEV2hodNZQzZo245iPCV+v0gYW8B/ugb9pGdArKBGtf5Tqbo4OqEJ?=
 =?us-ascii?Q?ZnbZF5Evf+CDCGK+RItEewjy2HyDJKZRik7xIfDsDdM5HpXj65/uYq8j8vOS?=
 =?us-ascii?Q?ShKK6kHRtoA2Ux9YsXaUMWRkS8AFgwzcmYjlaYLMoEAeTVccKtfzekbZKyxr?=
 =?us-ascii?Q?HGdlAGQoRwxcXwl/1CB35ubOurDbtzKp2VHktWa32kolgq3r+whJ1i7t/wec?=
 =?us-ascii?Q?E5T1szRFay8uwFZLRoxnYF9wLeJpUT1T9w6jsFWkdtxbXb727kML7l5nAE3t?=
 =?us-ascii?Q?OOXzQemCbopS3uQi+S52NtVLr4oU9LS3HuwRmkAEuTzBaNt3kMzArxf7lPXK?=
 =?us-ascii?Q?F8fqSezR/jFY4uVwaWNQV4SzDmDpyMyrbJioVsFde7CyBR95JBJlPvmZufSZ?=
 =?us-ascii?Q?y+PJlKD55P8C4Yr/tODGfuWo26/uelHvrCXgJW0ZCmCaK/IBIc9xZ1j51V2y?=
 =?us-ascii?Q?8bmk5tQF3ueUCkukcjJeZz6Jlkumbw4qe/urupID2DsO7hOujgxGhuU54tSp?=
 =?us-ascii?Q?fn5ckuEh2wRpahLod3fjz6U/qvjjre8GINDA1rUOj+ycDpVAs0jkZR/Wp+p6?=
 =?us-ascii?Q?4ry+aX3oYiHGLBxxwzRjbLlgdnHY9uSsIGAPja21RkZ5NjSwaOBuosY1hKxc?=
 =?us-ascii?Q?sZh5oNvVtpQk9SYwbFKpJFSJ9F/7qmIVIdv1WLN1nQOHZB3WMdF6GioW2ioc?=
 =?us-ascii?Q?lcqdBpfR1e0HXDK1SFvG4gFKxWAufaW7mUsuXlGoJmJVylKeIfeaA7KT2H72?=
 =?us-ascii?Q?Tmm06BiWYex3bZRA1Uw4w0Yj/AigytM1X7HGxi7JbumS40OPDKXlRtNpIrPe?=
 =?us-ascii?Q?EPUrQius2FQN3le3AXPEMaqX3sNUSy8pN3A3VMgteDZhi/pPtTfe90cAVuUM?=
 =?us-ascii?Q?+W+grzYO2sbTq+1COsLbpMP8zDXlqPcB5u2fCMSf+sNgoDKipo6LU6s6Odev?=
 =?us-ascii?Q?ilUHgI++XFw50VHIG1zwKJA0JuFa0V7ictd/zXE33xXGSqfo2RjNIisN+PxR?=
 =?us-ascii?Q?nJu7xLuydQVLspjkR6ThD6xMY0oIk46j+lCWks6i8aJY5OYHRrrtafbcucPA?=
 =?us-ascii?Q?dWbdrDg+qHw08ywnsAdiX9buV1/rM/Q=3D?=
X-Exchange-RoutingPolicyChecked: KQLyRQGr7Qcd+hDAtuRXHxZfDBKrG6iWouZNH2yUxnNdGFcXvz4yh1dENWTPR6NEmE5KxtI4TU/cEVP2t6QLn5UfLNdL6MUf/PWmT6WWagMyWlnCbq/h9flpjAGpXC0/XrWwBjDZL2pXykisfUmherwkeaWuOaEPStbGbp/l1Kc6sa/ct8WoW6R+a1FVX8AWZ6HVzBUFNTMahdY5te+zWCr6+/I6TAkTIgkXh6fJXEMcpMvbFQ45fnSf+UYkB3tY++af+0JibhsLv7IhZlhP8BC61ROu8sfbBH9YTkTfSR4+70qbx4DCt5OXJQZ1fa99Croi/oa8mOlV1b0zhUNkOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fa342e-f881-4c49-2892-08ded050c81a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:10.9877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlGlVJUrwqYOjBWjc/LhyrkwLKoMVvLUGaF1atxqd+g55asMHXlxjokwf5+0SQjhz06cxsgw8fiWX/Ck98TD7x12DkKn2NLP6KAzQp7ybqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX91IjRNaE5rhe
 s5yI53mURXLUPy2+7Ug7/7KLyD8R6ctSCNDgSGEPn7eABho/UgtxzBI9UqTeBHuzwj51NQKrR1A
 GfcmVvZ7wU5UawQuni0cyc4JEdyVstg=
X-Proofpoint-GUID: y_z0hbCVQW_YUIe8pjk5lpxaAFRg8sP-
X-Authority-Analysis: v=2.4 cv=X+Ni7mTe c=1 sm=1 tr=0 ts=6a391b5c cx=c_pps
 a=mSR/hpqHDdeL9wXJcf1Q7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=cyJIeLrgMFebCcwQBtwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX9uqlIzug/I5l
 dK2hMfR+JqfKXCEt3dl6jjlTU0+q3yaEyFb6EqlBLJ4w10btnZORfK6PtC9LZ41hEqROY8UaQZn
 9t8Jc/F6oPxxEzADk+y3r0lTOptSaQc5IYOaAFN6sDcP0RAEIiWnHrXYOVzuryFkmdzF1S4xEZD
 OoDmYTlivCMQnCoT2QCuk2T8mUwEOuwd103aoEqEYQh4T10UAq8Poz4dwWZajpMIqYkn5RffEjF
 GGh3ISwX6Xzr/Bj/PRQ7yXBuZA4h8ODhgbcfRfwQW9qbRacIuKFWdNGRIdVbimwQa8wNWBgL5QQ
 IhazGLmXGxMNcIWtvxdL5gKVnnjMo7JyDRYFx1IvWV8qH4v3gIFD8A9K67/5G3c2C21km8Mgyvg
 f/1WtrN9xowbf9synz4eAdExWpu4A/yZ5d72SheKi0XcXwamm+ZmC4U0Ntv07Mu/LnQwNNJKKeP
 nNobqrOlRqdm2nDHZMQ==
X-Proofpoint-ORIG-GUID: y_z0hbCVQW_YUIe8pjk5lpxaAFRg8sP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/acpi/ich9.h | 2 ++
 hw/acpi/ich9.c         | 8 ++++++--
 hw/isa/lpc_ich9.c      | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 019f0915c1..30990fcef5 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -81,6 +81,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq);
 void ich9_pm_iospace_update(ICH9LPCPMRegs *pm, uint32_t pm_io_base);
 extern const VMStateDescription vmstate_ich9_pm;
 
+void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
+
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5c7dfb2c69..5e8f8a7eaf 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -388,9 +388,8 @@ static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
     s->pm.keep_pci_slot_hpc = value;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
     pm->disable_s3 = 0;
     pm->disable_s4 = 0;
@@ -398,6 +397,11 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     pm->acpi_pci_hotplug.use_acpi_hotplug_bridge = true;
     pm->keep_pci_slot_hpc = true;
     pm->enable_tco = true;
+}
+
+void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+{
+    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 9cec18a378..edf9783ec8 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -701,6 +701,7 @@ static void ich9_lpc_initfn(Object *obj)
                                    &lpc->smi_negotiated_features,
                                    OBJ_PROP_FLAG_READ);
 
+    ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
 
-- 
2.43.0


