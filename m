Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B2AC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFO8-0004lJ-T3; Thu, 19 Jun 2025 09:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNq-0004Sd-UN
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNm-0008GX-Hq
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:50 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JAvH22013023;
 Thu, 19 Jun 2025 06:32:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6311tszg3B3Xgw32Umsi2InitNKIbeJrTmEavkjkr
 tI=; b=s7wFWXN7Thm+svKBHxws0SxtU9oXzUVvlIfucwJo1bIoZVoJwRN1xlA3g
 HCli0sIUIRDZ/csMSgNlIr3gIXg/Z4dv81lR6OEb59yXL6017czciX6T2rI11Feq
 wiXrEBwQ0nkYn+SXik+LzFElMMyBCEMBj724QYf48HwBxIBzIJJwspZ2U92mJ9rS
 t58UVIAKhqISdxot5BTT4kQ8Kt4yx35w9Gz5az3Jmhnh26PacyA2TNiO+n6FxK8m
 XTPJfFTRDGOdpilsEv/pVC+CxkBZxCH+oz/NS6xTP7Daf0AHLrctnueyhvD+71u6
 8iJOyMuIDOuVYV3BS6cIUthINcpTQ==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazon11023091.outbound.protection.outlook.com [52.101.44.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47976j3rag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgjTK9mE24alg/OHl25xfl4OREIfn+Ji6kzIPnRXB06ylgvLGCgrO0ZdQlqflbaVnejipE+A1qxw0BZYyZtvxf7PlsLgWWXmUgfVKRz3bl5t+AVfLRlO8LNNqlI0b8jT9NDvS9JppAiujGYPLyelRv0frmxiF2v9K8YADMLkgAqQsV2tNXqmqJa3KfEytv7NhdskY14l4JzWRn5FQgRhlNO7LFznc+wzhPjStWl7FjmYYyYrVz+xNXSChUBDdTi6UOZqchCE1xuNpho4Zn0J1BUH96OzinRXuzDBjMAOBAtvwkznRUGy7l2t+NYQrv0xCVZK+lzvI9/bZMp1X+bGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6311tszg3B3Xgw32Umsi2InitNKIbeJrTmEavkjkrtI=;
 b=Nyr3Mmbi01cbvE9jTvAs5vWw0HO+i/G/I8ZVWdaitrfFi46+eCcX0GqRBap6kYcuHkAy5cpT/YaMoyU0jUAIP+XnNVVx/ISqR/QmSJYJzqXaNVa+40nER+TQLJFETypzAPeHNL/m07Iks+FGGkkE0KA83sCFbHKS5En/OnDSVo66FOQkFXAtQjNXWI3boFeggmUjxb/NFKdwiGxB6pPHIbIQnQos+f2iXziPqq7sAJ9TxK23abDWr/BWp02506D5Ii6203II11jrwH8Qo0k3SMd0NiPYL+TQqFjHcvXyEDdf8S3bAJ42n5VxhvLwxknc++kJ+79Ulo2r7vGFnrVr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6311tszg3B3Xgw32Umsi2InitNKIbeJrTmEavkjkrtI=;
 b=TQPQjIMawCyqraNbA37rMPy4YV/VgF6JanLqNJe3hpOcQ4YKEHSei0bisdDMg+ofZhEO5K2IwYLOF2DXrvou7cOcnQk2Scj9O1ULiJjvtdQOL91jL4Pl2rSu/WyYzpv3W88P/OSQo9nWF0DGTdAny/ibI1owoFTv7we3X995NOVnWXf4eaVCQjjYrp1pvmlDppXMfrT+fD6imm/1uqaU6LjUnc41F1v4Zz5KEDcMeUVAd7BURRrUx/oaMa9pdYo/NufqV8nw/rQXdS+I1/qJDGeZGrH2FE/qfeU7uYGGqYcCaq23sOA02CC6H5ZXgMvLnqFYWVrMSCQjqVWi2VAPaA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:31 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <levon@movementarian.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v4 13/19] vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
Date: Thu, 19 Jun 2025 06:31:47 -0700
Message-ID: <20250619133154.264786-14-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd8a697-9efc-4f23-e367-08ddaf35bdb3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2HZ66Ku1qsiAGTxD0i4EHC3YTLxGPZnVDh/+PvzaAw+o9XqX0szk4keljwfn?=
 =?us-ascii?Q?tXvHVH4WnFQZ9nuoQS3hXuNi/YkoQDksKqnuxEkb1237laSw32ZTTpzE4pFK?=
 =?us-ascii?Q?EMtUa9R4AzqG7Knh/ZUzDSR4vgLpsutXk0M6/Z60Z/h/Obgui5fJGpXTc2Ay?=
 =?us-ascii?Q?4M08znCraYMyZdEQMDMzW46ICPHXbVcVBVsysADz4wHIxaueU7bEsH2zyJQa?=
 =?us-ascii?Q?r6EctisFBHlRQpMf6nY/1cEQ0uqEAMpM1UbYNFgx1Jgt4G/nQlsJ4SrdMBgW?=
 =?us-ascii?Q?k8r0WZw4rz3T241NyCDMP/4wIHJCxsnJ07Y7xaJ/sVP2QD02sZ7z9J21xvVE?=
 =?us-ascii?Q?FKv2G/V1Hcla39/7xgMnJq6RGHwr0Fkfwj/LPW76XEERQlABB54NUs+iIJNC?=
 =?us-ascii?Q?D0hfADsuSVjL40HLpne0RuMTiqA4QejOUnjlgsTtfre/NluhIaV8azeHvZY0?=
 =?us-ascii?Q?5BIKtiH6vHIwceh4QxWqAkIf64+ZcFOrw/Lt9Nosip2wRNYJ2pGC7fcdfMNo?=
 =?us-ascii?Q?8jTrId2w2FKvEUox39uYDCfcPYqkXOcYHhucuj9e//GeVj6r1jpDlNwq7IAq?=
 =?us-ascii?Q?AF/N4FpUxkIJosGITfwV8FFalXbhZBaBkB1pr0Wu4nkJqYnlcl9c4DS25n74?=
 =?us-ascii?Q?ix5C15Un7jp1JIQElaUIMRGw1PiiqK5h2RlPI480J3AnWlAfOajPqpwJlfG/?=
 =?us-ascii?Q?lXu99QCRD11yE78MyjrO0/DbRDmjJY4OAKOpCVWccbGgbdrlobgtJKeW9Cv9?=
 =?us-ascii?Q?zrvIVHKnAs5MvzKHQC1G8bpeQGoan9qYKvNE6ecIaQf27Ry6i+kZiOIkU6wA?=
 =?us-ascii?Q?DA+O7tC8OwQ9G88zst7/uBh1NM3U2czqEsOXFtquXeh+UjHWguy0bS2qTqsv?=
 =?us-ascii?Q?1xtL6wLGATwA3eW5/G/VSLF9rMA11mJmi37LLW8tkeFNnkwA7wdQD2JImq3x?=
 =?us-ascii?Q?g8/4+bEy2CxGwUyAFy8DafWwhVWCJG7kcm40gLNXxtOQ8I+Z7kiOIz314CKg?=
 =?us-ascii?Q?hK8r0qSgLkEVK41WNQ1zzG9lZ0Rum4FBbIXTrbWHlT2VYVxFG/bRscSDD66A?=
 =?us-ascii?Q?koqBTt5YBqNveST8RcymvD4gqlqkCrZfZtDPOJnWElWRQOUtJoA2cvFp9fSc?=
 =?us-ascii?Q?Few6R4cc9oRAWuPow0DLCbEFr2zr4TPwt9+BTzPjOqoHJDRhdI7wQB67IRuw?=
 =?us-ascii?Q?Fbmr5JV9l1nhtiPdHS3uZ9toDJNy/3Ii1SXBObrvUZoibnoSJaKtOn3LERYc?=
 =?us-ascii?Q?zXqnb0V2qM0lZzQz/qI7u5cImAoCXDw3tnn6hhLthykbKDzGkkm86+S8v1H3?=
 =?us-ascii?Q?I5B10y21FP1iyvs84HDIaQYTVLnb4o+3VUMUHUSA1T94zrNz+oFtJ5D5ArrS?=
 =?us-ascii?Q?bqi0SIZMO56xsyWaPD7KQDIpQk4tjvnxiZMgl/J97Q3ge0hQax5WlDf5Vp1o?=
 =?us-ascii?Q?Xzmm/SSdQgw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cfM4El49kJQH+Uftw5zUa1sokNu+qMORRdwJgI63IvZ0O1CpA3alRethhvP?=
 =?us-ascii?Q?diIDJ8kagzMlWnm9mDt+PYlajoVGdRdBs7nPH0Yjmk/+7KzvK/R372YKvV1o?=
 =?us-ascii?Q?mXBqblqxfJNGIKh8ZjnCMZJpoak+SmShO0GSTOEArJnFWIR/sp/pIfldL15f?=
 =?us-ascii?Q?3KwdePiIerJkqPnTGKdbP2qE50b92SOfFHJbgJgvYqWEov7gwLUMeY4lEub5?=
 =?us-ascii?Q?3kKdl5eGc44aUIxstisSjYdS2A7Wn8x9vnYJkL2EGW4n+E8lprHmuKUh5HOi?=
 =?us-ascii?Q?VJ4I+n/QZLi/Tux9VrKCC0hPKEolHwmEuWV4gKZUQ9R025o0jrU/OaPqYzw2?=
 =?us-ascii?Q?+Rd0FkwEGAVl6SbHnySE/fD8XwgX39jUBygo+5EzSplq8zZwTOOvp6cOBY4b?=
 =?us-ascii?Q?atOmLPyJARdncnKZOWLh5bceac+DvMPj+oTQ6XhwqTm3IYIqL+cur1g7eJJR?=
 =?us-ascii?Q?C6sE3Q8Nd/X/pqDFdKXUmqHnGfgCWdpZEZ0NQueSDzW4tZQ7nLXOLWH4DCp3?=
 =?us-ascii?Q?fE/IcG6vJY1320q6Htj1ROEtTfMIsFGz6yGEYvvYYnPNqDXr5q3iHmsupsvu?=
 =?us-ascii?Q?5KF+ytjbEppJ88jlYa7QlEzt6XDTtxH87XQ7k3qjtzbS8gWGhJKNvlYM7oJf?=
 =?us-ascii?Q?MouW2k4OzJHAFAzh14ZkAqemcg8YoeVH+hkrubLymgSsZKZOj8HaqXvp+DjM?=
 =?us-ascii?Q?CPWYYdDM5/CiHH5hDtHU4VEqDjKPBfluaedLveERLnBOck0YyKhJ6AlZ+Lag?=
 =?us-ascii?Q?7nqlcCiNLTlN7HDrG733PO83ugf14I2qqD3P0vKZRlLziuzhR9lvs7NaXeUn?=
 =?us-ascii?Q?h2UlWlLJPHWmk0gK58Ut7oaZpFSDHWFhpdhbybaRfc+si21f5Uzip6Yia8Q/?=
 =?us-ascii?Q?fa853UPvL4m3Hegg/dViRjI9SuHvpApdRoOh7sZdmK7NUHYGUbxZBEGTvkSJ?=
 =?us-ascii?Q?30vpO+UkdKL9mOTVqo43sWhpOXPOGjL5jmI2PsbHVr/cuxzD31XrMsgfNQ8g?=
 =?us-ascii?Q?ziDmrZqk8InqszfRPids7x26Y1MfG9YcWIAcnct49zgEM8ogGl3J7qIsqHi4?=
 =?us-ascii?Q?eowLteI/GMJ+DTGtg8j0mtbXS/fX7JV1zVr97eAzJxfycez6ozI9jz/SHPI0?=
 =?us-ascii?Q?bRe4DypJMdjPd0F5w57xtEisNgPiUwuPCq23hPKKS9x06nY9U5nXV0l2PV0z?=
 =?us-ascii?Q?UT4QD0rmFDJ2wuxcRXpN2jI/cafDam4qVIfusJY3eurw2GPpd2qE05GRZGbX?=
 =?us-ascii?Q?sCgSGJgkikTDTqc24YUm6mMi/VancrVno8TpupgVpVUX+RB+GH9Wiw5UVRSJ?=
 =?us-ascii?Q?UzrIGYGojXLUeoNep/84pFjdPz1zM/vPHjFgknhArPA2m4tapcPE/fLpL8re?=
 =?us-ascii?Q?psGv+fFX2C9KcQgJdYBG4JsJYVklx3vdqNLJlMQr0NAY4NS7XCiStukT9c/C?=
 =?us-ascii?Q?+pAXQvJ1lYgLDFKns1gmxtdq4db3fj/H6MfjXCCZNbzCBJ2vUQUNK9q8+csl?=
 =?us-ascii?Q?uQFMrSHsbyMxu3GqUr9Rs8VRXxeMBfG+N6ysv88uLpIIqSqiqNG8fYZukooB?=
 =?us-ascii?Q?V6LztHb+h+K17Jzwj2KPV7it/jbWP16Na/yeHUVv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8a697-9efc-4f23-e367-08ddaf35bdb3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:31.0910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xWYn7+CqJ7wNkxitx5y9gQBk+qTo2zn1k4trGBlA583bDieUy1GcwiXxQnW3Ox1sjS8sMGdKjnILjXGxm2/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfX6/gZbH2FUjTv
 Wty4y9DZg7M30fg3yUGHyzfZ2BJ7T6ImumjHMa36UTF3PC4uSJBa+3CibBKE4A7oA6oI12ob7TI
 2DbD1SoDfTzjUk1oMlzWup49YlWFFo0JRDTUowxy3TVqXzEKR5UKXEpifJrgbGzphvVENGnelyr
 o8LYtTGFJntwkUQ1J15rhnjfpY9GAL4TpIkaV3DGzfdtXxcIsXbl//wvAuO2fonSivIOO6w3YH+
 PWZhH3F97WnNaFLQuNDV1mJN4nw9HWA8ymBXCHhjgmV6kw43ZZW17hd+Db/uhua2c0GTK36HK+f
 OTBoK4xyOAPgVILKClIHht2UAIVL2T7sAQEzVTLgKQpQQnJUHqxO8fsBhvmQFSI3xLs0nS/+7Uy
 WpiI8oD31gJood3rFwEvc2KO3MAt1sA4VHTgT4sVc49zeE2nJuhKt56X35uPFOcNKiG1SusH
X-Authority-Analysis: v=2.4 cv=RcqQC0tv c=1 sm=1 tr=0 ts=68541179 cx=c_pps
 a=b9bpObgcEOTp51h0EtjbnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=RQZ_2NmkAAAA:8
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=1ZqixiJJ9Y4JtCwCYkQA:9
 a=46pEW5UW3zrkaSsnLxuo:22
X-Proofpoint-ORIG-GUID: noPGGX5BtC_ph3nHya6cpVFeI-3AAl2r
X-Proofpoint-GUID: noPGGX5BtC_ph3nHya6cpVFeI-3AAl2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

From: John Levon <levon@movementarian.org>

When the vfio-user container gets mapping updates, share them with the
vfio-user by sending a message; this can include the region fd, allowing
the server to directly mmap() the region as needed.

For performance, we only wait for the message responses when we're doing
with a series of updates via the listener_commit() callback.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  32 +++++++++++
 hw/vfio-user/proxy.h      |   6 +++
 hw/vfio-user/container.c  | 108 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/proxy.c      |  77 ++++++++++++++++++++++++++-
 hw/vfio-user/trace-events |   4 ++
 5 files changed, 223 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 48144b2c33..524f3d633a 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -112,6 +112,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -175,4 +200,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index e5ac558a65..a9a36e4110 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -70,6 +70,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -99,9 +100,14 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+VFIOUserFDs *vfio_user_getfds(int numfds);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index f7c285ec2d..a9cc4b197e 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -12,23 +12,125 @@
 
 #include "hw/vfio-user/container.h"
 #include "hw/vfio-user/device.h"
+#include "hw/vfio-user/trace.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
 #include "qapi/error.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = unmap_all ? VFIO_DMA_UNMAP_FLAG_ALL : 0;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL, 0);
+        return 0;
+    }
+
+    vfio_user_send_wait(container->proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+
+    g_free(msgp);
+    return 0;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    VFIOUserProxy *proxy = container->proxy;
+    int fd = memory_region_get_fd(mrp);
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking. They're later waited for in
+     * vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+        vfio_user_send_nowait(proxy, &msgp->hdr, fds, 0);
+        ret = 0;
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+        vfio_user_send_wait(proxy, &msgp->hdr, fds, 0);
+        ret = (msgp->hdr.flags & VFIO_USER_ERROR) ? -msgp->hdr.error_reply : 0;
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -220,6 +322,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_device_attach;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c6b6628505..315f5fd350 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -28,7 +28,6 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -130,7 +129,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -606,6 +605,36 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ */
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_nowait on async message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+        return;
+    }
+
+    proxy->last_nowait = msg;
+}
+
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize)
 {
@@ -644,6 +673,50 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 053f5932eb..7ef98813b3 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,3 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


