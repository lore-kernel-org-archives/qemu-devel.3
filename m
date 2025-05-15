Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D204C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFani-0003BK-RH; Thu, 15 May 2025 11:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamC-0007pq-Pu
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam1-0006SW-7X
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:40 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8OI9n011847;
 Thu, 15 May 2025 08:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9dGMxStAEXVrqnkq/UwR1NKDWitb8XE1YlNoGCuiq
 G0=; b=ZJ0Z3YJ4q0qBcM3I4sAkGrEiyqhdvqODzvs1sa75FOpTkJdM9URHHtQfP
 sJiC0z2+l5ZyL3/3sKCH2zV5vHjQ8dxh09bK1wv+24u5FgrxRkLQH5iY75Lp/qOG
 E2XfcnoffndhpvYR4CDOMWKvfSKPHBv88XDOOlyD3k0aF9lq5q/VT8eaBSI3DU57
 cNgtTa0Ta69Ck5XAuP38WGeRQMtd9aBIT0zrgBl4I06322CmNw5vsgr0EssuIm9s
 +8vmcBpqzs2bV63r7mUbIxgloww/M5yDUasiU9kC78IWo82miZGrUaJYy0XKqIxR
 2o03J3BHeFWRx6sAix3PwTE3yY0Fw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011029.outbound.protection.outlook.com [40.93.13.29])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mxh32yn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocGisLPvo0UUIjWwDeAANL0pycWsJiyPJbajzG8qon9erc8e0eXAk/Hxm9yXA17KWIETLnfjQPHlVIQwGYGCT7ARxzd3BWm3rrn8gImT1SPmDU1PQENbzNfHFgr8kl2Je1mrWxcI+g+tpUDTcFzU0H/bdvr6yg49+9O+loR6RXM4Wznucy8Un+/C/4oXlGT4s48G0bz/+BKfwPd9JD70FVMAB4YVwMazX76/cCgOUeYylscbXABmwQXPOVTYV2BXF67V9lC7R5BfQwa85PZK+jrLUCuqBlLNSfcbtIH2RRu2Jpsr5gTs58aKywGvQMGPTJdAcfnYwJfb8W7s+G3GIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dGMxStAEXVrqnkq/UwR1NKDWitb8XE1YlNoGCuiqG0=;
 b=SsXnptLLh0ZFSjCIPSRthDf6Ja+oXxt0D90CCz/2tUQElX8dNDec4Kp1lHvTbbDCc1lx7tbX8bNBayxy3Btu47a8iLTzDgyBJWnaAzQuMWKNpWUB2FoCYlTDGplHOQpNFW+5JY8D07xyLThKQdFNdVsK3a2M3CMjtJiD3/i6XTIFy8/Z2qEFnCWigddJC+n0tNXpg+uisI5flZV6kspM8b0zfWCgftN1OyPsKaj65ZA8u0txHEEUHOeg1c51uWGLa1R+rL9BAuXqPRcXy/1HKpURQF8ar5P1D9yF7Qf4aZE44gijmahYH5lHfmqwy2Tqsi901Pg2gQ8uiLQchQpqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dGMxStAEXVrqnkq/UwR1NKDWitb8XE1YlNoGCuiqG0=;
 b=Eyu6wjV80GSVF+ZJrvqbmKq1HQZJDP48Q5XibDDteDcDcOjc4sm4zym3ft+Ed15YMS4jrMQnzy53wZ/cSeh77sPIW1JEljL4kD/lUA6fjDUbPZJoJGwipRiApGo93s1jP/FrYW/4XY14wbIENhPspF+2Xx0gwm5fVti20xinP9eZqr67uhPX1SgwWuJBHvL8VjFZ6N4qd7UdevFUPNYaP/FkgF2t7KLflA5nlSULQA1TYzDgtuNSbKtA1cX/EyPUCHnJzGQFB5c88p1qXozcpoKlLISyREIgemlxan8k3nBNbGOBDuHKZXaxRSdKj8Dtg5o0wSQEeVHh2iwL7qRqWg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:45:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:20 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 24/27] vfio-user: add 'x-msg-timeout' option
Date: Thu, 15 May 2025 16:44:09 +0100
Message-ID: <20250515154413.210315-25-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f8ee66-204c-4d41-3218-08dd93c77f3b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UncoEMnP8ts1FQR665yDaotoDkRzy/NoPDmhwgpLyxgkp9dt1wI5JRCypBlp?=
 =?us-ascii?Q?jDw4zCqMxlyRQQ/VFLlCs+UICdK0/d5wEHMAGm14cjgTi6IAr7foqAJx39B/?=
 =?us-ascii?Q?HihpYj1ziEsQphl/4z/j/qpnGzEbWQhip8+sa7H94yCAkME7Ps7op7mHQS8y?=
 =?us-ascii?Q?u70NT1BQHtkTep6nLydVWiMWhPqHFxAzL+gxj3bfrzM+A6e7FkKWYD6T4H+B?=
 =?us-ascii?Q?PWNeRTOV5vHdrEGrlEHzwd9Rfjhwz35xXd6F2wY7YyFgcFwbJh7ZB8slHvUx?=
 =?us-ascii?Q?vDD8n5JpI0vIJyeL4cif6UGvX+AYqFS/dInceYBgM0bzckM+CJAGCCjDP5ar?=
 =?us-ascii?Q?22HQBG/TGKw0sf7MbeojkDlxamFyRhLUDuVZckdA6A6+AwKE/ntppxn4517g?=
 =?us-ascii?Q?yBpPFU9WaQACrzSY6ikf5eIaQUEyrliXdN0SsbUOuNV13/0xFOmMnFYABJE/?=
 =?us-ascii?Q?VT8X39j+2ch3w8sIKsYu/ZjjyvBMJDgTUbkWB80bsuKlHV/J8RKT3coPNGJF?=
 =?us-ascii?Q?92r18wvmYCz9uMoN2EpgTzVccKFBRTrZvwiDwAgIFnT2j0G9aapIVPa2GRVy?=
 =?us-ascii?Q?mXC7QWGQtl5V1lM5lFOFCo/TN3BgPksSDX/kz+HCmCiUMZRYY4OeWoH8ZEVP?=
 =?us-ascii?Q?a8oPIOjYeYrBSLHv2dlxOpmWuVCIiwtoJXlyGGBU89PCSVoAH2pBdF4vBUa9?=
 =?us-ascii?Q?bTZgyQnP5SogEbyry8EasFQwKFKqMtmUVoc6SM98aFdNOvrakF3o9yloV4Hs?=
 =?us-ascii?Q?ssq0Ajs78O9zDm5B2WdShanS6HdaAjuT8X05URhz6hQJYId2i6LXZoPFpzaV?=
 =?us-ascii?Q?zf/vRvqyXvhLEB9aK537fUkpt79PACR18MlItV9NDPjLJaWaDdPUASqz29Pa?=
 =?us-ascii?Q?UMHfDPgp0I0rfbtfq29pwA3VbOczx+ajdV7GEiYphlc3vl0z3EXGsrCchE9b?=
 =?us-ascii?Q?aYgdm2Ha/bkdQVVh5a5A1Dpn6C/aDueLUvweIO87OEE3Bd/cYMblz8fGJY66?=
 =?us-ascii?Q?7HEOzDeum5hxM42G5fW0FSMXYP2lLdH43F488ETcq60WF/2CryZfuoKsZDHT?=
 =?us-ascii?Q?4n+eDFhmEHoMUwyI9jMsPbwUlFlfp30a7hJYhOWyk3KGtA5O4je8RQWExiHg?=
 =?us-ascii?Q?b1A+Auw41fudfCg8coQ3L7I8EJA930RxZaQaNsLWabTRVxgwtMcbgeuIOMnK?=
 =?us-ascii?Q?jpSPUFnHY/ALNwHMHAGAtuzPxvXowOVjZjEysFUJ9WxtWijDdV9qkLdoQjWs?=
 =?us-ascii?Q?8EKqJ5zeCpdrPJsLN2IbGHByT5QD+zdJyXFw5zuwCIUyo8zxCVQQjMpQSNB5?=
 =?us-ascii?Q?yRU6RofRAemRuE1xF8+rZqCD3kqyYFjb588Yo1k9PoohhhUWehAyxWwXZ+2L?=
 =?us-ascii?Q?QBOnnSkMchmbGciV3Nyl2PVFKL0wx1X38DG3kEUwWnkBHaK8pQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FyhzMW71nE/hwi/kwAeP0jciQn5W9MyVh5pdKIeNp6ErFXyFNI1hrDgiwKq?=
 =?us-ascii?Q?NpomSHcA4R9SHPPzhQfhYP4OM9WSgu+FFrmU3y+smY6EIXj7CCQB1YLd23o4?=
 =?us-ascii?Q?3YYpzBaYVkDwRs8CIJWwr0eI5Cl9E/VciVwqQLgsxG0NafDPFFWIQGB8gH7r?=
 =?us-ascii?Q?lhRyl6vYwtCGHsg5fWDgu6Md1DsG7azYxJkYHxiH0upY5x+Ewo8cGRU7UQ4B?=
 =?us-ascii?Q?1wrPhjxFjxorIlwiX4QzhnmGIpG68YKMoK/Y5VZT0yfxan+oAv5kyMh2lv5l?=
 =?us-ascii?Q?N1tLzUI4y8H5cHOm66eT8MNHaXpev+SU00QdRAnilXweD6Af0/1nc9j2kAyP?=
 =?us-ascii?Q?HNXB7h/JpFOOHp9sc0XesW+yQz6O7XdNYeOvuHV8d/Q87Ou1SRjGNzqr4pdf?=
 =?us-ascii?Q?zmiZtwie+eKvu0AHkXs4VI0Wl9AZjldsHxKqB9ak9iJrYw8EWS7sVDq8BEcT?=
 =?us-ascii?Q?L/iGsF43H7u5UA9XvoSRIbaOlNp1AOYExRP4fHougve1xvz01/Feyppvox0+?=
 =?us-ascii?Q?pnbEvpRdgPI0uDvHDBJkiQx9ps+q4mUGBmq5A7/WegIs84oy/ujR1stgHHDS?=
 =?us-ascii?Q?WwL+LLcmv6wLfxCzXWeWfV12bfXuN8RNFg8CbhoJ5GBxP9o4iSlNEJzi+KFR?=
 =?us-ascii?Q?i3taq0TmriTKmo8VzKLlci7xCQVFGxPF7cQiFCV2MhK9QIyiAnm+7GnGY5h3?=
 =?us-ascii?Q?Yjbqb3KN6hchRlqEXAEuzIAU8YqSjl8TgbD8FuskOZWbdPUqphkJbvkbzpIX?=
 =?us-ascii?Q?JtkGycO0qGLBEleUYDpBWvNeH9+VwWGsCTT1r/uzunag9uO9y/ukNMwkRqsZ?=
 =?us-ascii?Q?RpOXYTf1vXTsa21iXH85XLcNsY6wJKQ4bDYPebZFP66bLDaIhJxBgmZFozpV?=
 =?us-ascii?Q?e8IbamWbcbhG3xevl1RAhbGhzHVS5wIrL02g9EoS8VMKeDCS3wHtAIpBUaAg?=
 =?us-ascii?Q?6louDoOcqDcP0sHMpz9OZUM8KoyCE7QpIjJkRj5OzFuaM/o3JuYQ1nv/fQ6m?=
 =?us-ascii?Q?j4C6IayFJQcEj0iTFHgg8CsKARKw9Xa2SIwI9IiURuS3txZ9Xlhu4ADWP4Qc?=
 =?us-ascii?Q?1B01Sb+jyJ2MKlKHCud8kBvIjkJu7ZcxcansOA9w9RffW2MiNqz1ngn2cLwV?=
 =?us-ascii?Q?SwILDZ/LJU5+RNeaPVoMmhj9XB5YJE7q9t02LB+/K4n1fYoEJuoVb7NutN7+?=
 =?us-ascii?Q?2+YWM43AUDHqsEO01krE9a58BUjYWfbJNaCpfKBkKjrtUMVxzaLL5acKvkLe?=
 =?us-ascii?Q?R9WczkBZzh8eJrFvWygWnsURmjiomFRSgyQqQ6flkRMg+0QS0qJpF9GyDaLF?=
 =?us-ascii?Q?gi3GEynU3AZV59+8w9ufrGvVqlc3jAptAU+QqKWZAHm2kRVaL0+zcSwh/gFn?=
 =?us-ascii?Q?WTl4ionjAos2zl+TlDoMx8+u61zFpJlSDlZu2RWv6OleXEdp6trsQMIBR9y1?=
 =?us-ascii?Q?8eFcb6qrVZUtH1/FTjmL/JJLXXuyYGG5wCx3t7pXPtIA7KPrsQrUjxp9krAk?=
 =?us-ascii?Q?jgwcWOXRdic/IDkKlc3i3jolazm622Z2Qv+gKtBYqOHPk5jRXMyL59YQaA2Z?=
 =?us-ascii?Q?bA5TYAZhe9zRxh/fiY8qVT8ZamZSOnN6+6cCWjJN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f8ee66-204c-4d41-3218-08dd93c77f3b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:20.0206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdhGKWqV7X9XqclmA3tguIs1pJ9EUH/pHb9Fe43aALMn5ZpmTRn8n3xGXCP+R5ByR7Xfpq7QDRVti6MH8D8NVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-ORIG-GUID: ze8bdAUKGu7w-52LMiHmecj5_r4iZrX4
X-Authority-Analysis: v=2.4 cv=TeWWtQQh c=1 sm=1 tr=0 ts=68260c13 cx=c_pps
 a=SA2dW19TPv9rE6CiBNbh3A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Ql6ANm6PklPDYutWWPYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfXxurMqFSSX6et
 GD2eH5CjWU1lA3vRIXmF+tbWSCk8L9fl6ht2v7Qawedxg197xakR6w38WP7oQSKw9GZ3BbCj3ra
 yZ6snsXR/CCcJPg3Nyg7H+OgZy0J4oVpJ49kuEHbdVl2sgGCT0ZnOx2V1ErxJdz8KX+dyEZIGql
 7hd/tlw1T25U5suNypJhIB66HiZ5OZ44skuddxd2ZyCxRSjSU5vElBPWdelxkRl+lDpZnNQDQcA
 ROYLYWKjJVYIJ9SrFQj+rX6KLOXUsvcrEUa/6ooeW0PyGPdU8TXNVWTr8C9W6ORM1Cpyj6Ner2F
 YTG7avr15Yzj6m68GqvL0y4pur7tS4hAkr01xftAPgS2rBnGeBPcCdqdU1k/pYbYRZs13S3o5Mf
 YQf8VzgERFmBB/ag+VQmIOO+HXVP+ifZZaP3+LsbJWqHqdoligVr+ZD7UyaJGcB1+rAbOBsU
X-Proofpoint-GUID: ze8bdAUKGu7w-52LMiHmecj5_r4iZrX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
index a55a0a0972..3df92acb82 100644
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


