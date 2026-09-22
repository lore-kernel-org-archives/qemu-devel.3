Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F483C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y7D-0004En-0a; Tue, 22 Sep 2026 06:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7C-0004Ed-A1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7A-0004Vf-3s
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:45 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03ktm2448352
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=F9NJcWcnhNT/lvFu8Uwxvr3fgcKDEBEWr6jDmw4lz
 t8=; b=zpQ4RFpTZIPTya3AXrhqNQOd5Yx6sJ/7jX/svuy90W5JceW44O1WnALoD
 hwG142DpGOp41QlaVlhzlj58KbggdGDhVWJ8Zjzfj3m42Zh/VkOBhKNr5Pf6y5lV
 xV+WuwCY86laX/BkJ/b9pfTCl0AqZ5VaseQZhzkCdSn+pPLGpu+WUlX5XeRygbs/
 rvg80/nvo9JAAEqKHtZP5c/lvJoSXVFAiacA8psjNaAlYGRLHKZ+CmAnu2Mn7FOI
 N0I23W9011c0KmXTHZXIGPidxG1CBtfjd8I7KV2S/Kin2xzVagXVSXBbC7iCBl9f
 UnoyeU//IPIcKZQMot3t3SKVZ68xQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021126.outbound.protection.outlook.com [52.101.57.126])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gu8cwj5t8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykn86unaTjIvDxqckSlQBcpg8eOVG98jGRopHK/xsoAUlkzFjDHlvOwWs4sSFNmpazWj1/432NOzFqHb71Db//7WE2o9Z8VJX35Xn5A4ffudLM0XMP120oHMJcUCoJoGBMy23zYVQUCjWazWF6GwTvH1m0tcTLcTEgrRxK3RmCdaT9YELSuLNYw8em8Pb+QFhskqUF6phiVkpyGKDNvYoo9ddWlObS/8isglJWDEl09GfzZXrlIlgGulMJaMnK0pHQnX/zWvC/0h5PCrlwaK6sz/vWELq5eYY+2v29lvP5zHIhhLVapxblxO2e7QAgZrWuVG4nQekuMlORMZ+ED+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9NJcWcnhNT/lvFu8Uwxvr3fgcKDEBEWr6jDmw4lzt8=;
 b=vIN21STBy6YIF64dvGTXm7dX8Gx1NNFha8qO8dW7sKL3yObV8GHNqsUHfsATDfiYQK5CqVZeDSPvqM+reDQQ46uM8aCUERq6HE/x7n3tlRGZJsFsYWHTnCe1XR0yfc+p/ZZ694uTuJqS4W1lNGwXvf8shHfnz4yVeqgzFu69vAjiVCqSTQaD0P+e/unCVX/DWUbM0XN6Im8J5XewRPlJXvnL7U1hyxu6FG0A45BPVwBZwWkwdhherOOtqXcp6J1y4OI5QW3fpyscKhJmPGA1fEWtl38pMfy30gmLf/VKOF8SmhSwmzbF+v1pPtSAhthwXQA93motLXpzRMTjfVPGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9NJcWcnhNT/lvFu8Uwxvr3fgcKDEBEWr6jDmw4lzt8=;
 b=h691DplvwPXfGzkAhGCXuJZslaq2Mq+DI52r59Nk79zfvL6kIvEfWJw8p2zVW1B23Q9ylEdNVjTab4G/ylAdEXMnKwfpGR3VaicJTJ9cOk1dT3V8V2KquwHPbGH/Se4jAUEisGD1XpwsuNK2HhmPBHuvBx7/Qr4SwzJz5Mcil/ZJ8zY/GU5Z0BnUwuo+8fdfJR6/BoeAayLVa1Q94L4PkSotf2RWK/VZqfri8ZjKxw2Nx8+y9w5RUFjnIUhkJXTQuGiHVpTMKoRQkyXcLx3MWOvGpEVe5ruGvo/V7ap1WKcp2AbA5gN2K80D6llq7KHDuNa9vmPNaHshUa5tdAWmOw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] qom/object.c: introduce object_class_property_add_alias()
Date: Tue, 22 Sep 2026 11:51:32 +0100
Message-ID: <20260922105223.1607725-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d112df1-7add-46b9-6725-08df18979fbf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I3urE4F3tw5ZNioewETG24kJ3eyvtIOqx/qn7Cu54wwWi5mfZCJH4IEXKdoyDAMTcgrmrbF2sgDkYLn1hy+clEG/KJAKx7gSUDYVpSBvFYDrS24p7mNWBDUMeF1XMm3FFN6W/Nd9CqsArSOxQU+KuDIhqfguCobap/tzrMD9bn/V/G8nn7d62UvYZ1yBwl62vGrSj+BBRmleNdvHqIl5vNMKCZTNK0ERTIx3XQg+CleBmXdx4xOjFKSFZ3kLaScXtgg/i9RsPGKvOmTq9QGwG+Hf1j6zCScFqDZOeY39j5QezPiHiiM8nm8Vyy8rl2o3/spk/zCZEXZSFb63EGRphPn5NiTC1fkhfcPGOXnGcY0QusCfobXH4Y254Tfd3i+BmhWcIaVhCDxi7CGVtrUj2jRSwt7EkaOgoRVS8fKHmbva7EkVbx60W47uRghUOsiRqtrcUqe5b034y2QsgrD1M4zcgoxesoVdWUZ0gg4OyP1v1bwA01XO0tnQg9F1jr8XsL/7tti/QVGwJmsdi+ZjoS2PPZrEVqbtC4U3jPFSOvhbgotXq1+dZPwxXzFshwTQx3/57fupAl7XjpBRXuDqBw6+8vKAvBf36JY0byPB61LqgWos3C0vIG3dfogpy5TSjSIHEOr67iHE2bAEUgBneGGyIdFvcVKuXhGRYGRf2PU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnBwa2NVdnNQYjUwM3BlbEpoUlgyZklRbXRiSFNJbExvOHhGbDVRdjRFWnpM?=
 =?utf-8?B?Wng2YkNhbTJ4eVlrc1Qrc3FzbmRTMjRvODZDdUJpN1pGa2VnQ242b2ZFM3oz?=
 =?utf-8?B?aVFyL25NakJTZkhjUUV2K3c4bjFIU00yRWpRQXVOaHFILzNVNUluRXdVKzB5?=
 =?utf-8?B?TERZaXdBNTgwT3lyakF5UVc2cXkzcGVuaDdCK0RqeFU3VVMrL3FHOHBBNlBw?=
 =?utf-8?B?TlZTWnphMG80MG5lMW5acStFeW1YYWV0Nm1uZmJvMi9Fam4ydlhhckZLZjcy?=
 =?utf-8?B?VWhidVNnbGVGYTFLNm1TVlhhS3pUb2wzWFY4NFVPcWFjVXNDc2l0bVZLKzQ4?=
 =?utf-8?B?QTA3clVlbmp3MVpSSFo1Q0JwUUZMVHhjKzNKNjBrVkd0QmRLSDFUSmg4UENM?=
 =?utf-8?B?aEJ5c2wvanN2NHYzQ2xzMnlOQStvREVnTEhiRDkyc0RyZ0RDTnByVmc4Tk1R?=
 =?utf-8?B?RTQrQzdrK0dXQWpBNlRzajFWT01wWDVWUUZJUU9HdU1xZXU4L0N0WHlFUGRv?=
 =?utf-8?B?b21oVHRCdXZjM0hrNEJ0Q3JKeTEwU1J4eFdVNEkrRHFMSmY2N1BHOUNMN2ZW?=
 =?utf-8?B?c05Gd1p5Vm4zZEtDUTNKa080RldVczVta3ZKQXZ0ZDB1WXlUNUxZTjBLQzFu?=
 =?utf-8?B?d3d4U3Y3ZXNUWlZSZlpKZG83VTF4VVNpMWtyZFhHbG1YZW1zMUdNUEF2U3BS?=
 =?utf-8?B?L2E0ZExIbjJCSktHcmErYlJZTFpvS0FtTUxuL0ZhRnRKUTE0L2U5MVFqaFRR?=
 =?utf-8?B?Ry83dC9ZdFo4UmpPdzJQczhvQVJ0UHpXaTVoN2R3bWxmSXpCL0lyMnVyckFn?=
 =?utf-8?B?WDRNSWdOdTRxTldlYXhpK0cyZVIvSlpzZ1ZMdUlWSXBDTEphRVBjMm5aQzhH?=
 =?utf-8?B?T0htU1ZSNjFlN2NrQ3J2enJRZTZ6WHFUTDZ1eHYrc1ZyN3lCV1FVYUFCKzRF?=
 =?utf-8?B?MHBxV2RDNE5TQS9VdGhZNE5qa2o5SUVRaWxnbStvVElNUWxrVWxlWWFzSnhU?=
 =?utf-8?B?VGtsV3ZTb0MvWUUrUnlQS1dKMzArV0lhc2dmdzNFamdwbHphSEd1WVhLVHZw?=
 =?utf-8?B?WDl2VXhnRnI4Tk9DRU05QldlWTIwV1VvbmNGRjBoOFlHMG9OK0tVMTdOSU1W?=
 =?utf-8?B?ZUtnMEhRNUpHck1VeHZabVBlU01mZ0xGZmZKYTFVd3dHRXpjYkNjZzNNbjlF?=
 =?utf-8?B?WjMrN2JGM0FSUGhWZWRnQy9VUVZmOG5kc0YzMk80M0xjbGUzeUxtaHhMV1JS?=
 =?utf-8?B?TFNtdWdJV09YNlVDaHY5VHM3WG9rblVkSDR3MWhHNFhWYVQ3TmNWUC9hM2x2?=
 =?utf-8?B?MDkxVk5EQVZzU0ZTcnQ3b3h0dUMrK3NkRzUyeGJybnJ2V1dSZmdrOWtCRnJi?=
 =?utf-8?B?b0ZZT0dPNUFuNyt1ZkdQQ1dQZUFZZVpQbjcvMVkxc0dOa0ZraWd1ZFVsYkpz?=
 =?utf-8?B?ekdzR0JIdlhMSUNjWXBPWUZQSVBaVEcxSFlsSFNVK25CeThIcVJkNGZ4aGx4?=
 =?utf-8?B?Ti9kbURjVTh4OHIrbm9lRFVIQm1ocVFLQWhnZHJCdGRSR1lmNVcxOGxxS1hL?=
 =?utf-8?B?TGRWZUZoZDdiZWRUY0VVYWtNNXhYL3lBcHlKdzJ6YTBJYnZuOW0vakFiZFlG?=
 =?utf-8?B?ZlBMUEJPLy81ZEx1S2dZNU9Xajk5THhwS0kxcGN4TDhFOUd1aWsybFV6T1E3?=
 =?utf-8?B?T0JPc2s1WDcvK3Z3Yll6UjNuSC8waExjWkI5QW1nbkhhbUxPemlhV0xNc2JH?=
 =?utf-8?B?dFI5bzNLQVU4ZU0zK1dXMWdjbWdWRkxCem1jazNFNklZU001cU5wZzhlL2JY?=
 =?utf-8?B?SlYyNFZaSGhnU2x5WEM0aUVtSStZUzdTaUhjWUhMeHdqUDRWQk56blRDWkEz?=
 =?utf-8?B?UVVJd1A2SkRCaTEySUV6Z1dSZUQ1T2tUcXI4YUpIQ3pVdERkUWZwa2YrSTcv?=
 =?utf-8?B?SVlwNHdJQlR3aDYydDdCVURXOXMyVmpzL2RxQUExQTBHelhLSjdzbU1LR3ly?=
 =?utf-8?B?ZUlsSmJZQjJxNENBWTl3RDdUQlhZR3dhYURrMlRyT1VxZTBITnZsNXRzdk5V?=
 =?utf-8?B?RUlsMCs2cjFDK2NZaHhqUVVVSlNFYzlDNGNEcjdFd0hVd0pWc2ZkUU9qdXFK?=
 =?utf-8?B?Zi92dU5UZGdwZHUzV2NZcHZWYndReEVJMm5nQXFYdEhpNE1vWG84L2c1QXVO?=
 =?utf-8?B?cEdlQnl5eXJYUFlSU0w3U0RQb1Y2Qkh3bys0T2E4VWd3R3lMUjJ4VzVaY0NT?=
 =?utf-8?B?VERRS25oWi9nQkJ2cTdpZFg4bEtXRHBqZ25BVkV2R1grbThIWlRYRER1Mm9s?=
 =?utf-8?B?K2tUWkRyS3hkYU1PUEphUTI5VERSdlo2UEtDU0hrdzUrdDhlOE85dE9VYVlV?=
 =?utf-8?Q?eA1W/PMi7+HaGpaY=3D?=
X-Exchange-RoutingPolicyChecked: sT1ocE1TU7XPoKon94mML540s1AdkbeWmGRNqbI24RH5G0iSAYFETgimbWX06EhwkUshQe6WH16c1mpUt21OCTLE4o+UuOv10iqHcNLnD8zdCKyfk+pHvbH9k57OJDx/W7zOqEP1yqeCKv0//jjsTEIq+3w1zYj07iRHJ4D2+ZRVFSYfa+8wFWGaWjWZUN2j5URz44AnB0qMg/gBxJFQTNSkrN9bgGlL+cKDH19t/+0XTboXsA+P8TvabN6EyNddwKAeiamfTNkm4w6OBafbTg6bREfM85JvcwSw7jwiuRRriAHS5TmnhgAzssDKDghxqrUmzaVFaIknh0ez5iQkjA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d112df1-7add-46b9-6725-08df18979fbf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:41.1319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNRB7nJXFpwyWzDj/6jwWoZWdzwYkdocXOwYG6Uojp9+AXEAVgcVLbxRfRhA5jlGDWuFUzLmmaKiZQFjrYHHnOy9MzKcpe8VwUQhR8DsDEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX5PERyc0PcH1p
 Gh93Drg9PAbxXifxDiwAhbf6rrKmCoU5cgBRFl+L3vRJiCoCzgf3QoW/OAm3gx7ABl77K50VWIt
 9jnOHH9fOGe6DiBr+Yd2PoNz3soLjdMX+sCysqm7O4z+vctJD7+t/mj0rscCk4FK0LEXRVNMGsM
 KsVPpZBtk2YGP3D+7CEpflHWdyCepM8yjKOX1h8Tk7MUu2oX/Io032u/PqpoGMT+eNeqHUOu8FF
 BkqNmrJR6aInh76aGnGj2s3N8V9865qHb1rFt3vyJFQHOpqqfycguMqtSfL9Lvd2nhfBsrMD63i
 mOYfE1qlSKl7dIK2twe+8pCozswAJUZPsM4AJjN6jFucXZwI75YudqEvTK8x9Fl8hEQ3REWBhA6
 gxnkHw/a8OsrwOzjHDxpcsJD/a8g3K289R6f+LTKRrSlOHrnOpIVnm/2ohSQnJSOqo/RqMrgYl4
 GdtljdAgJcM/e17D5DA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfXw3son9i1u5rs
 jLTisHBk/NOYi2KsYjWbyG40X32f2BKo1QNxQsn0cHhfI1tIm2GFrgzZm3wf0NZuIuOa726TdB8
 xygUXQAmA/YvFdCIwArCjSqtZrtazMA=
X-Proofpoint-GUID: eu6TgNv7bSQiEt1DOS9vsuop3v2iDvkR
X-Authority-Analysis: v=2.4 cv=c9I+0h9l c=1 sm=1 tr=0 ts=6ab25dfa cx=c_pps
 a=XKZdELU3BU0400fiC4IFSg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=5qpsIK_AQi6EPHI5KBEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eu6TgNv7bSQiEt1DOS9vsuop3v2iDvkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is eventually intended to be a replacement for object_property_add_alias()
which uses an object property instead of a class property.

With the advent of class properties, it is possible that QOM may attempt to
set or retrieve the value of an unset alias property. Update the existing
property_get_alias() function to use the null visitor if the alias target has
not been set, property_set_alias() to return an error, and
property_resolve_alias() to return NULL for the same case.

This ensures that unset class alias properties accessed e.g. via the monitor do
not cause QEMU to crash.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260921113559.1299740-4-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 25 ++++++++++++
 qom/object.c         | 97 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 3285218664..73d72619b8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2279,6 +2279,11 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
 
+typedef enum {
+    /* private */
+    OBJ_PROP_ALIAS_CLASS = 0x1,
+} ObjectPropertyAliasFlags;
+
 /**
  * object_property_add_alias:
  * @obj: the object to add a property to
@@ -2299,6 +2304,26 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 ObjectProperty *object_property_add_alias(Object *obj, const char *name,
                                Object *target_obj, const char *target_name);
 
+/**
+ * object_class_property_add_alias:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the object alias is
+ *   stored
+ * @target_type: QOM type we expect the alias to resolve to
+ * @target_name: the name of the property on the forwarded object
+ *
+ * Add an alias for a property on an object.  This function will add a property
+ * of the same type as the forwarded property.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index eb5f74fc74..e4e8dc6886 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -35,6 +35,7 @@
 #include "qom/qom-qobject.h"
 #include "qobject/qbool.h"
 #include "qobject/qlist.h"
+#include "qobject/qnull.h"
 #include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qemu/error-report.h"
@@ -3052,14 +3053,22 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 }
 
 typedef struct {
-    Object *target_obj;
+    union {
+        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
+        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
+    };
     char *target_name;
+    ObjectPropertyAliasFlags flags;
 } AliasProperty;
 
 static Object **
-object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+object_alias_get_targetp(Object *obj, AliasProperty *aprop)
 {
-    return &lprop->target_obj;
+    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
+        return (void *)obj + aprop->offset;
+    } else {
+        return &aprop->target_obj;
+    }
 }
 
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
@@ -3067,10 +3076,18 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_get(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    }
 }
 
 static void property_set_alias(Object *obj, Visitor *v, const char *name,
@@ -3078,10 +3095,15 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_set(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        error_setg(errp, "unable to resolve alias property target");
+    }
 }
 
 static Object *property_resolve_alias(Object *obj, void *opaque,
@@ -3090,15 +3112,21 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(*target_obj, prop->target_name);
+    if (*target_obj) {
+        return object_resolve_path_component(*target_obj, prop->target_name);
+    } else {
+        return NULL;
+    }
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
 {
     AliasProperty *prop = opaque;
 
-    g_free(prop->target_name);
-    g_free(prop);
+    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
+        g_free(prop->target_name);
+        g_free(prop);
+    }
 }
 
 ObjectProperty *
@@ -3123,6 +3151,7 @@ object_property_add_alias(Object *obj, const char *name,
     prop = g_malloc(sizeof(*prop));
     prop->target_obj = target_obj;
     prop->target_name = g_strdup(target_name);
+    prop->flags = 0;
 
     op = object_property_add(obj, name, prop_type,
                              property_get_alias,
@@ -3139,6 +3168,50 @@ object_property_add_alias(Object *obj, const char *name,
     return op;
 }
 
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name)
+{
+    AliasProperty *prop;
+    ObjectProperty *op;
+    ObjectProperty *target_prop;
+    ObjectClass *target_class;
+    g_autofree char *prop_type = NULL;
+
+    target_class = object_class_by_name(target_type);
+    assert(target_class);
+    target_prop = object_class_property_find(target_class, target_name);
+    assert(target_prop);
+
+    if (object_property_is_child(target_prop)) {
+        prop_type = g_strdup_printf("link%s",
+                                    target_prop->type + strlen("child"));
+    } else {
+        prop_type = g_strdup(target_prop->type);
+    }
+
+    prop = g_malloc(sizeof(*prop));
+    prop->offset = offset;
+    prop->target_name = g_strdup(target_name);
+    prop->flags = OBJ_PROP_ALIAS_CLASS;
+
+    op = object_class_property_add(klass, name, prop_type,
+                                   property_get_alias,
+                                   property_set_alias,
+                                   property_release_alias,
+                                   prop);
+    op->resolve = property_resolve_alias;
+    if (target_prop->defval) {
+        op->defval = qobject_ref(target_prop->defval);
+    }
+
+    object_class_property_set_description(klass, op->name,
+                                          target_prop->description);
+    return op;
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


