Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92C4C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpo-00085i-9Q; Wed, 25 Jun 2025 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVph-00083v-R2
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpf-00040R-3A
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:57 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEoMMc018767;
 Wed, 25 Jun 2025 12:30:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8Sgj0ZLqfnMV1rmzsLAXyKEjHirJgruqwfW3PMUXk
 TA=; b=mpilCHA8+PIL8k+Pl6bBYt6JkxsUTkt496g9aSCNsvsuB7630laUtE7mk
 G50t9ygydvKbxc55eiHbEU9MHJV98aJv8otm5qKG4aThvHo7Yuw2qUdoKJHiYrxm
 ofRPjOmYwjmCqenRdPfyRNZ7sNxx7a6Hzelo9si6HWy75FOXWTNbUbkm67V2TmU1
 zVWNoYTD6akq3EDckrsvke13B5tioaL8/Y1OFKwDoyzF4p+AmvjZGrdRdXUWD/Mq
 rq9uIaOJQSqNItm7vkAk2DcF8k00k0yBu05k022HfbZvKu5qMCMEcx3e4y4NDOpH
 TVTJ/OyhtT/sfgnEb9Tf3WFbxzbEw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2107.outbound.protection.outlook.com [40.107.100.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0hhua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slDme3ejL3DQoWfgyYaE4bakt30/dQOOVvhGxprHUzsaYw1Q6rWs/+HBHtEoltOnn7Q7nMg71cfR7mqU93IjDEeXWYaCvFeIoSj4P+M7UopSBEuRB58IwSrOxky9caXd2neYJ3nz1KBes2VlE+kbYbQk5EBw/MoWlHXqwniVs8U8r1ORoKAzVncNqWrpfBy+8giu1NOGtCUAS3trpL7fa62lGTHOAlJxbJwdMV1RIeiva0TEUP3CvSrVuoLlQN1MRoLdOwD5cC0Ah+S5siIgIX9yPWXeMlrE8mH5a6jYWYDhVnCOdYfo/Jrid5wJlBPFRl31RDoN+HeYo074uZrKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sgj0ZLqfnMV1rmzsLAXyKEjHirJgruqwfW3PMUXkTA=;
 b=NfbdiZmDM+8tN1tApWFRtAiCgR3vXewc18ZSNuqaUd6Nbpekt9x4ol5dajgSkMNZMQ7kP0iRjx5x6PE9oy+RUfVi4Qim441N0B4Empzi7UHwhveeUFiXs/uzJ6SPgQNCNzY6X869q4MlVhUMMWhoJ2bUqdgtbt8mHSuij4c2KFX6AAoFi0fIWfK/rcmqsEdXWVYOsqOREUgfKsba6fbycF4QCfWNIULkGrfetNNBEuNdoNLWfwTXT4kbqnAnpXsUcsYJ9PfThcCjdIW61UYS8YeE+B5908KXIHZNcL/TuOTr5ieGiJsxJcI8j6SGWEJ5F2fCJ8Uqt05SUPFT+iyAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sgj0ZLqfnMV1rmzsLAXyKEjHirJgruqwfW3PMUXkTA=;
 b=D2TbManbrwChhTDjrhsy7dXJ+GzNIejR0zxDA8f5ZASDT8UJagOF2QK/rrE/NIs38DdlG6vDugmio1Vn5JpCPvKa/uRNLmbYx12J1/rm1rOen3vPjgUuddZEK37PPkewbGLEfxv1GdP721mAt8LcOrzy396C+XlVH6Snh50yFhwTpIbU2cMTUda7xd4DHBn2U9U/D2uF2QGbwwvOgZJoqC9UqfbAE88Iz1Cgq1/hjb91lFd9o2QiNxfmBHrppWsILvS9wCY83ajZfUgm42c8VSt5Vp0GFX8UDr8s3N5hjZNMm0JDagdc8kJ00ZIhhR4NXgUGHwxejYb0ldxocW0nyQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:50 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:50 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 12/19] vfio-user: implement VFIO_USER_DEVICE_RESET
Date: Wed, 25 Jun 2025 20:30:04 +0100
Message-ID: <20250625193012.2316242-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: e338a2ff-2009-48c2-2454-08ddb41ecaaf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VXcw7IqKNhL4HpxcA8vc4ZUjew7eu+QPEkD9l0oWsJvm74a9O9navVjwufP6?=
 =?us-ascii?Q?BbfFNdLgq9o+9Yoa955ud2mbm+41Sw6QlyM7Rxh9YJ5uqGDPlllmk+QfbPZV?=
 =?us-ascii?Q?egCOTzir0V4Msy5zfYhfB2R0WAq7JSzT3THDCxGFk36flur0FyJ36y3ys5FI?=
 =?us-ascii?Q?n5maPSjPuZ5D51XswA2dX4Sd9TuAnth3V15l9A6ld/yNZcFfxdy6WvpPaXte?=
 =?us-ascii?Q?MHnBTnIzuvE7m33yDBj79cfkHtweRB6w29p/l1GGhx9GBY4Q5rJ4LkPrjMge?=
 =?us-ascii?Q?FtX9w2VUBaf/YuUpHPJMaDYHlIn1jy941Yv/ZYor/CKoBxpdZ85jlUnHLdbW?=
 =?us-ascii?Q?Zt4hN0cspln0Dt3448V+M6zFjRYg/RKqPAfMoVWsO/YrcQqZFUWp0RtMwIYX?=
 =?us-ascii?Q?KSk35bLUA7SuXu8Y1odNsPytWLkmtzKAQ9KL3yrJOla/IQu30N88fOEpjyBM?=
 =?us-ascii?Q?xDhRz6QwHSn2seaZFDo9Cgbe2VEPF1t7ll0cd1ISUoZI+q/kGtkbBWMUHo4p?=
 =?us-ascii?Q?0AcJ/dx2ZSlItuEF/u0kyoTFiJvj5Y4Ch7TWSj7MXEvmg7VnEkBXSvOlvGxj?=
 =?us-ascii?Q?ayfEAVMt7b7ADE22Sg1M5kkV9AW6IvPZ003qM6VtE6oWP5I+ej4Azv4PUUHc?=
 =?us-ascii?Q?sxKuAbi9rlTuB3ALV/znQJRB8mxL859xIp/F8RtIEDlvwol/l6ZfiQE7L0Tx?=
 =?us-ascii?Q?oid8h/eh7kh1U5YIp9Ysev8vIpoF29NeX3pZkVWA3vhWzvdCSlvl4u2yh9Ym?=
 =?us-ascii?Q?F4p6htLocSML+96S+1sZeYG5+Pm1t9BaZFhVaG/cJ6CDnyzhAolG7SJhBs2B?=
 =?us-ascii?Q?1kmO4pWpGhSHvDUsNc4W8KD4HJ06bJH84OpJHFv1bXb1UsV9vx3CLx5s7Am9?=
 =?us-ascii?Q?pYVZI87PLj/gGcihzJ7eyIaK3yIEwdzS+grm7hQx3gxhNNL6Lw34XsUN+lXH?=
 =?us-ascii?Q?c2fyIlvZwWJCO2hZwxnjTV4AtO/toBaoDCildI+Q589LaD0nP8PmMDc+VX9t?=
 =?us-ascii?Q?3CJpytlo6WL7eRPNwpXH3Vjzh9IZY+IYIpmc1/Ac07OAzqK1iwTOLzkj246X?=
 =?us-ascii?Q?DoP2BHZb8YS1olVyUgeCmHdheI8g4Bv1Ke5qpZUbb5qhkbz4bfME892mVQgL?=
 =?us-ascii?Q?R6hkjnWo6ozqTcUUgljlmgBv++K7IHIItitpellgGnqbgqwLszesS4OAfFCr?=
 =?us-ascii?Q?LbtuVMTQRmabPoE84rdZy26RJbXoWeV9BhMZT7KQMWHpxcZDRj03BdByOlxR?=
 =?us-ascii?Q?YJJlcZfKPLcmNR4Irrd7g+C+ZMKNMeGUsgrWqlCWfyjfpmVeNJQ1VEdiMoe8?=
 =?us-ascii?Q?oBBMaZ4rBNJBdtWvvzwKco6lY6YnRaB3XnDIMnNXR+YYnc0Y4kS9X3Ldh11d?=
 =?us-ascii?Q?1rbkHtaprYN956dmsLSyZ5wy8lSftyAmYhiqkzbTb5n39F/UegGXm9YdEDPJ?=
 =?us-ascii?Q?Nb/PW2F4ksc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OxQHhO6UeFpd1Dlxdb+N346MSB3lqZmx1v398T9MYCff7Qcd2ZSZoN5cHYGa?=
 =?us-ascii?Q?Ot+YUAHvk/d53k1ZPoGd2bfX/GgYsRfQbVA0jCinvUmWUmk9yR1hocUe9sKH?=
 =?us-ascii?Q?UGSqcz3+CITO53SoJlNd22r5vRCNr9/eHiuHWL1KVgu0HTwuHHvPmnjdOEXW?=
 =?us-ascii?Q?y/QDauCHZ5VPLtOUx2cQJsM1/8d9Q8A3YAfRp3h5NMwu8PQkqkhZC9YA971o?=
 =?us-ascii?Q?N8UkvSKtmws/yuFgLUiDRLx3hfNLzLfYg5IbhXDH2f2SI5mI5ANJtY2Uhpg3?=
 =?us-ascii?Q?JiSuIkipVkYFFSWss/mLj1BZrT9EthZEeVCLCuZQW5K1bIc/CzDh1JvLcKv2?=
 =?us-ascii?Q?G+f8GIU6ZfEbkGxBoQ4qMS6qVa2EL/ogvB5thqyLiV5+0SZBLVigjVGYiiN7?=
 =?us-ascii?Q?9CYND933pBEMSO7xwx5VAluph0itIFy05u8KeytGLQSQD4S9r7UbkiW0jW8e?=
 =?us-ascii?Q?SNgJbSLVVXIyg377kerNRjIIVsh9wvYd0NWdMvLdHbmMTH4SCGHaUxdDBcuA?=
 =?us-ascii?Q?ojvEXkCR5UJkrMSviuCgTU+LOpHueIKQrlL8NehlvM6/NyhxzyrAarp1faIC?=
 =?us-ascii?Q?pregXd7TNycymwIhDXbwSGXVMMzVqfs+tfERrhVDZAANWDXf4jet+5rTkvzv?=
 =?us-ascii?Q?a6WB5VJvVIsxrmxCqMnd40EIDnmGSSi6wXcuOAqxf0VPltSnW7aALxpJaAvB?=
 =?us-ascii?Q?VjHLdU44g3Q2bkfcaanIYZI8hC1Iu51u9JqCBOAPWJNiCklGsAXolHedm9/r?=
 =?us-ascii?Q?VDj7/KVxwfzDJvRjf8ZVK8UCOHJjMv3M4RXCajMoaAO7R1j1Nk+UxESQiz4x?=
 =?us-ascii?Q?A1/PaqSdD9+0A8a7n93ZCtvMa/1MQuZmEa0GJbYRqZS7RRGpC6gyw48FwYbc?=
 =?us-ascii?Q?ODRzY26VykBTU0egHbPFQTFr2W3NbOdhaBGHpsEbPBxxVE2frZe5H36TG6ei?=
 =?us-ascii?Q?8NvkhgE4ZNOJJ7lpAabQoJCB/KO+LRt9xee9VqIaRKJEmOOQJaOsyP41kpRe?=
 =?us-ascii?Q?X3w32GR8pfGnoxjiWszMK1ZdimIL4IlcGVmcefImVxzeEGN6vpn1RhRFG7Du?=
 =?us-ascii?Q?DNLL5G5QvIeQuEIJeFMCt54Ge4JmZnhFKuvzO9XxkgJu51/eWjN/hq+87o84?=
 =?us-ascii?Q?jRT5s82ikIoIar8T2kzaQvVK717k3An67UJCCZijSi93GBYi4GRl4mq+Vdi1?=
 =?us-ascii?Q?6PhMvaWO29nQOV5MtyFbqRXaVbSmy2HI/qzdqGrZpDvydIabrVsYvb8Su75e?=
 =?us-ascii?Q?CY3m100jOcsyztTKKXje8DTAxak8tciFX6ax+NoxDuWpXlYy3hgFqXV1rD99?=
 =?us-ascii?Q?8csin/CbRSttCugzubn0InvapNcjT4UKUHTd89oF0zP0h8yLLGmojQsm5NTw?=
 =?us-ascii?Q?m3QjPidBRTNHhmo9pnp51RnIXqeJqPM8uYA8fnVDKAKIdy+G17yVcKH/aveX?=
 =?us-ascii?Q?WB5+9jqXCqUE+Z+tyxYjIlVFVvoMjrLn2WfYz+PqH3z4FJq/535/gRbP7svC?=
 =?us-ascii?Q?ur/o0VOP7FIQoPBdoAOcKpVWTZ1QyCzgbg8u5UCa2N7w6lVdto/ChTfubZHc?=
 =?us-ascii?Q?pQ+0Vm21oGu2UA9K+d6UXgMPzMMqzlYGLJFCp9aP?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e338a2ff-2009-48c2-2454-08ddb41ecaaf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:50.2163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVZ2eV5+6mgWSZh6Q3m1YR2V3xXjsuNAxadoAurduPeZagtehoxh4BY2C/h+xSMote3iMjUu2yJ4J89j2EBM5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX8+0Jw3C0+0Cu
 DFbV5p0K4kRN54mqrPj+n3Auo6Z2FPB9B2nxxpYjYaAO65MsifQhFYhx4FGTfJ2UGmTK1PpOXJ6
 470JRNCnsyAFpNi8NmygTE2U2KjtNGdHV+OwJvQT9j2ByiBz20AgkmS+6ihwazkWAqF5+FMWdcw
 YtkErjG2lRhHLn/b/ZaQT8o1Y5X88mxYU0eJgvRyQkw2Yq/xHG07mqtbqellRmMCi1earAMiiVc
 hzPlQ7eHYSqyPPk/LuPyoVJuSBBEp6sVh2F4CV+H4p3QX9GolyF9sdsqDSx4vqdjbJcbpcccHdI
 zPROuDJjtrGUclOLXF3Tv7eNK3VeLdNF9fVstGz3DUWjLshxfPc6QH/Q+b79yD/Rp42330gQOwr
 kxoaFkW6jxYFgsoNSt0k0pppqzaMVN5tOKli662/42KOhflbtZUFKn3GOTy76bRmahs3Guwm
X-Proofpoint-GUID: LVJuEdmVgOw5NXyaa0v4caARX5GvHdxc
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685c4e6c cx=c_pps
 a=SVzXTY2ksShwLJJ6alra1w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=70NfNXkHNs9el5T2m-kA:9
X-Proofpoint-ORIG-GUID: LVJuEdmVgOw5NXyaa0v4caARX5GvHdxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hook this call up to the legacy reset handler for vfio-user-pci.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h |  2 ++
 hw/vfio-user/device.c | 18 ++++++++++++++++++
 hw/vfio-user/pci.c    | 15 +++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index 619c0f3140..d183a3950e 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -17,6 +17,8 @@
 bool vfio_user_get_device_info(VFIOUserProxy *proxy,
                                struct vfio_device_info *info, Error **errp);
 
+void vfio_user_device_reset(VFIOUserProxy *proxy);
+
 extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
 
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index f01b3925c5..3a118e7361 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -54,6 +54,24 @@ bool vfio_user_get_device_info(VFIOUserProxy *proxy,
     return true;
 }
 
+void vfio_user_device_reset(VFIOUserProxy *proxy)
+{
+    Error *local_err = NULL;
+    VFIOUserHdr hdr;
+
+    vfio_user_request_msg(&hdr, VFIO_USER_DEVICE_RESET, sizeof(hdr), 0);
+
+    if (!vfio_user_send_wait(proxy, &hdr, NULL, 0, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return;
+    }
+
+    if (hdr.flags & VFIO_USER_ERROR) {
+        error_printf("reset reply error %d\n", hdr.error_reply);
+    }
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index c0f00f15b1..49d12763ab 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -263,6 +263,20 @@ static void vfio_user_instance_finalize(Object *obj)
     }
 }
 
+static void vfio_user_pci_reset(DeviceState *dev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    vfio_pci_pre_reset(vdev);
+
+    if (vbasedev->reset_works) {
+        vfio_user_device_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
@@ -310,6 +324,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
 
     object_class_property_add(klass, "socket", "SocketAddress", NULL,
-- 
2.43.0


