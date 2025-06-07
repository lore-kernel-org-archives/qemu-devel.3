Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF21C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9V-0002ud-AJ; Fri, 06 Jun 2025 20:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9T-0002uF-NN
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9P-0006NJ-7J
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:11 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556K9XAe027707;
 Fri, 6 Jun 2025 17:11:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bIjg7jCKjTH3HvYY7WwsaSn1m5QpED/N/yYQXRQ3s
 Zg=; b=Kvx6NN4O3o5Qwc+SGQ67N2UtIPyEJ22bQIkf3FcOn7d9eARRVaUCanvpa
 UnwHVKsgUivX3mgeHG7K4kdS2Y3weLpFk9i85wSkxaYsvYMN5pz7+e0Tc7P/xuRt
 knkgzjfdkUC1hhIz9vvpK3QFezQegJ/5wCeMiV2Xwl2MaJdvIhyhws7Qq0z8M2x4
 XCX3g5ZaDnlCCK1iJ9BPdxKlGAAEvto9QmJMnG4Dv/6nH258a7M2EnILhPYFoO7V
 8uaptgYh+UXHZ2yV796QRT/J9VlC74U0skxEGOqsJdIWD9X6NLeUCyUsP/Z9jINf
 nB1bOmXuAiU/sqKvZ9nPu8xB4na5A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 471g813xsu-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a50JJDZz+fes5JaK9KGmU+F7muIJAgcjhUHuRxrIr4nq7Ez0Annqx4aJ/f3eALgadEby90jq+Z2Ke75od+9/vmmKn/E8vIIfvGuBVrFO3oVzBxpm66mSxmEkDHBJvBz1gT///KOrWQv6uoeEHP/6TQ43NPpYlSsjmstp9YdhAxJuzDcXizwBiPZlUwKMHz9Th911DUVfOXNbV8ZKk9x0XGEOL+o0I4wBtg/QFBAA/3DOoMInW02SJO3W8LQrVs1eeZ0ZoVYRB9/DX57eu8YnYiA/Uo/bBQzoWdFVQ11DhEUhH+DPPnm7S0yNb5+VHoKP/B+lZ7vRCxX6Ny9nl9EPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIjg7jCKjTH3HvYY7WwsaSn1m5QpED/N/yYQXRQ3sZg=;
 b=NfDWixZwuhWGTEIqbeV/m4L4K03YCjvY8Uve/KRPS8uoqtUH5ry6VtJf4JpKHWZH7ckgFdN2KRgt+xU9XOl4LvOkjkUZ++b9oA6RGhacSEMEI55ZaONxfcG0+CqwQ0fl7zhsTImZTL/B8wR4QRAhZRwMH7+0WeY46gN0VgAS9sVTsGIUMZbTj+HeGfuOHI70Mump09y34bmab0M0TrRloy8wvfwiHA9QxCWiI2SZLSuSEi3xakY8B/brbGFI0Wej1v7ItNwHaKC2GuWNhjb7EIUVt/BGhv3/sKawG5fTokFR+2U0YEIjYqryMZOTea+mXBTgbW9WJqf+S+Pgd9VzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIjg7jCKjTH3HvYY7WwsaSn1m5QpED/N/yYQXRQ3sZg=;
 b=sLLFtRtgPuOynbYde8ymyFdNIZqS/mVF9uLeQUyoeC+LtH2mjLLiWZVmE2YrFCNzmhwHwLcDrKiR8Hr6GKqQfD4oUocsPpKUVD/aRoiaw3cej/xDBpcHijAIzNc+Zb2fcF0zgDnGFz6AGYWOxCqqbyAkJvVQ2mQ2CHktNt6ft4UE1sx6YRH/3/Eu59a/VOGi/qKTNE3l8HfTaN6drdkS1G0ay4MexBzUYAHFkeiHRgFBTOi8ISwVhHC8mAdNBa3UDA7dJ2/lJdIyjADd6I/ScjtK0GnYoJkwFtYzmltsL3ClvWmlbb99Phtj+JRvSslHmUulK/LMLjHo4XpMakcf+Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:02 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 02/23] vfio: enable per-IRQ MSI-X masking
Date: Fri,  6 Jun 2025 17:10:34 -0700
Message-ID: <20250607001056.335310-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ae518e-ea50-4cce-654a-08dda557c97e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uH7bqYMyQwha99wtNzH1nJvDxW3YID0PepHoh4c/E5eMLXf0IgcexkAcscoZ?=
 =?us-ascii?Q?s4AEtc7K0wGdhB6hYO+D1ER5zblZLbpvSbXfASNfQJfjCQ42zLWqU7mTzQIE?=
 =?us-ascii?Q?8txsvJJMpoceg08g6iugye7//zm+yFV2+OZ6RGQyr1K439eGs1nYLECeyK+9?=
 =?us-ascii?Q?RU0Rufh8K92cacdEMPQVAkblycN8TEl69uv66ex1FkeHutFuhbAS76lurPfy?=
 =?us-ascii?Q?S1zBM4enyk7X/qIOO+iiYV9hCNpC8w/nExYkCHfvcm5AMXgyDAYJaWJlWKfZ?=
 =?us-ascii?Q?zH6va/kSAeYNbiG6ARN7bHpTufi7Kg6MaKwMcc7FHeNaomw5/41KJCjuJMEB?=
 =?us-ascii?Q?ijLiuNT6aZHUQGq//EMxVPzzpRcxw5SKIi6WCQzg8X+msbR3Zd1qBOyNVzAw?=
 =?us-ascii?Q?H8H7HMS3G0YdsOWGI2oeCNJvIGKsHmSYiz4SerIhas7TtrAaep2J4Y+RPqYs?=
 =?us-ascii?Q?cu0T1Q+jiPEHGFIatHWlP3mGUAGjXUXUOYNFYCKogSA+3NCL0k5rqcRJn5cL?=
 =?us-ascii?Q?TE2ME6t11Fcwm6e0edvMCXTs1u70ePQs5nTr06uWOYJe7nhRMzfRONAuJr+V?=
 =?us-ascii?Q?zjS2ryiMJOzKhShHXxiS7x3BAHmva87UMH+T894EHuAPW2U67grKOv6ZNXxv?=
 =?us-ascii?Q?H5w6Qbo9L8BmIYOFNkXl0zi6YAl6SaMvRZNKsS3DdWcOAimrVZgfvKxabqX7?=
 =?us-ascii?Q?L1crj+6CdNCQWJ2D7bQgMqCc/y01nT8gTKYCanGMsoZn/htLQA/H79fyrY+9?=
 =?us-ascii?Q?9T/9CVhJfFAHHJR4Gsa+Xz2w8EpzWanN9ZTxgYZ45H/eMqvIWH3f5W2urfVW?=
 =?us-ascii?Q?4fYnH5MCbi9ScTq3AiVMmaoJ5tKwExBy80AZjjMniV8PKEg3tuN5ceXUIiqZ?=
 =?us-ascii?Q?9qtuU+Y4T8m8BNe5C9w/GFit6hroTtVpUZCqsE+56BjDOBe18dqDwSObVL+B?=
 =?us-ascii?Q?yrtsGgECjKdbj3v9QbG/aDE3wg8qna7r7DECR4mS5meLM494lMfgOS3rKA1L?=
 =?us-ascii?Q?ipyZCUTWOHQ+iAz/8xFxRYtHIuutCb5VF34FybWgEyiSYBiFauk+6ul4YKsR?=
 =?us-ascii?Q?22GpcFy04FibBr0qn9pTkaAIBNCaxUdZDvAdMEAGCdVjOG6jwLMJRuyBA+o8?=
 =?us-ascii?Q?uRmBn+qVJMGbC4s9/wsQrW+Yhui/EX0MpQ7M2wdQhqQcxliK9guoiaEGVb7L?=
 =?us-ascii?Q?AGKutYi9laA777bLN7MPBU2EwxyMOrW9UBueulS881pm4Dl1dj5doNuRdawH?=
 =?us-ascii?Q?IRw3bZ0IDqp4GI2+ed4WXbR1KPyhGFVEEzgowxJTqjduBiDnLTlmBVdoGQWq?=
 =?us-ascii?Q?cWkTGppHGqgtlALEMfGkXeZ+PGEOwXhYW0XiTxmUodrgZJwGaoXPOTNyg0LE?=
 =?us-ascii?Q?KQqptVIbW4vxEYQIro/TTR7pRx6CSbCRNWvCaa4ph4tNSN7xV3q5ujWJIWJt?=
 =?us-ascii?Q?j/JyPzu37MU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F7didSPEFBLWof24Y2h0Rzrmw3CuTAGEhJUvlU42p0KIT8nzljR+twquQrVT?=
 =?us-ascii?Q?9VDuqV04IzPE4rp3CSpogSLE4vOWpuDB9gjGCW6C0l0XEO8+DSfdp4n0Mm40?=
 =?us-ascii?Q?MyxBfpRwHhpEklPhbWZYbpTarAd9jjc0ST2xGHoiF/hVCIBXmWWbIV5V7gzE?=
 =?us-ascii?Q?VC4fUOQn/R4XkdcsclRoyN6RK4L7N5MqOEDkpjVzJfsfAWLwXc91sSdxFBqE?=
 =?us-ascii?Q?pEbpkG43iM857Lxt/CeuluTbv5N9fzOgQ1MWe0AOAMGXOx17hTKmktyOLIzh?=
 =?us-ascii?Q?ou3TQeroIKBAwBs7za7IvcL8L+SDwXrICV6/LwP34GjwyCZtKMyWOyonPdji?=
 =?us-ascii?Q?Yk8sZX15qg6+FQBBxgpZBlJ0dnEC2V2BXnxiZbLSmNtmulRKM4nGe/Pm0N4m?=
 =?us-ascii?Q?y1wI2ktA9MjhE488ko8OBQTl1kxMKDHA2EkrLZNXjRp/JFKtgJ0ltR+Edydy?=
 =?us-ascii?Q?+iFwovWY2I/jOXrOMbFS7n4HYJFWyqvFaGoWDz620qodiVxRNLA34dep5hWI?=
 =?us-ascii?Q?SRlMl9L/9osLlw/4RKku6YOkZp/nZdDy22KPWCnQJigXT620TDLGXtEDqrZD?=
 =?us-ascii?Q?SAGT5C8Rig5zrU17fbR3Iay7/ZM8k1uHNWMeQa+WC9IjwbGJtHkAxOj4tY8f?=
 =?us-ascii?Q?31qQDfPE+nYFMX93IVKEElMpCxrFwn2CoblvrREreSR3WBYPyMBzwQ3rGU8U?=
 =?us-ascii?Q?cN3L88O719zY1S1eOo/3EQG8AXFDeG/CySnMtwViXkmXGkxBJ6SvCNNTb6cw?=
 =?us-ascii?Q?ogp7aJAMGJOjAkPbPkYs5LGa66QBLuywZ72eyisDJnqjw1iHjiMWx+lrobrq?=
 =?us-ascii?Q?2ivBuxTJFcRK4tEVUp8t2tuyL65G1OcUtSejN7rjgkBJlNWicE9AIDOsTHJ7?=
 =?us-ascii?Q?c6CFgYwll+LLYdd4xNS5uWuVRKYnh1eSc6iDZbRhEGbw0ekxs6XWBjQzBoce?=
 =?us-ascii?Q?4duR/qd8tfa9v0ShcT+7YHR9y1lDegw/HMbVoHe4nPD9rg0lz/un7UkMQyF/?=
 =?us-ascii?Q?F3GTSzYh3b443Fgo9HTPaQ+PXqLovbhuOMEcikamLjBdAWnUQP6s0ngbLEYK?=
 =?us-ascii?Q?YABClSwxE68EeB4gseoFbysvi/82QvM1oF+AcKcIsnvrxkSnelROE1gVzfkE?=
 =?us-ascii?Q?F0h1u+qiJrno052PCnXnzlSPe1LlWM1Y72yttAeQu6ifzvuI2Bc4zNPNM9qO?=
 =?us-ascii?Q?J7xWhqfDrwCagMuNUaBLZjBXH9cEcxHmDb4IQlOA56ISp6m0yez01G+VQF2i?=
 =?us-ascii?Q?ad0v9BXNhFwl4sc7/IKm5nz5If1SVgaLdSnnCUjujS3fV6XvXFL8X3K/S5/Z?=
 =?us-ascii?Q?gC+A3/CFJEc7I0+NV5mRnTvkgDtL8OpfPH2lnIFm9Ss1/SSi/+i7y73+bGhH?=
 =?us-ascii?Q?TA2MsrNFF1BQums1wKbwgX+YuGrxgTKPaQt4AHWqST7sZ3dFIsJVFujTsZu3?=
 =?us-ascii?Q?ic+JDx2jMP5udTpFNQH+MT7ck4m4vFYH4QOvWjJzw5EaOPj5SxsUrgdKr1DF?=
 =?us-ascii?Q?ROmoIMuUXjrPeMtf9nDBGQc/92Tz91EWWBO5k8lm63+tJkfw4ygbdNjc5nXm?=
 =?us-ascii?Q?/NgpnyMx/ReVxbiOGZy/KxDRMriemAIB+A0Op40z?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ae518e-ea50-4cce-654a-08dda557c97e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:01.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH+W/GSB85esu0K2kPwpY216FMloaJVvxd0ck2m7VjcyCZx5WmN+sv8+xCuhAOzNbfouaZGbES1j8txAHYNotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX5Dem2Uctk+e+
 d5PAve2yMgjyr8bhDdNNUoy+LalqWhbtmAb0uvo6gajZ4CNS+FTgWFtPkLUM2QmDVdLAZxBSyR8
 ug4sSXlS/RI/wpgV1m5xsF5TZ9gqAeksmh8W/95zHoyNCK1iXy9Y0bRr6PhtfGles0oeXmzK5Nh
 MQ1F9rabx/82HVXw19VcDXFtELRk8RLgvmJbYTGM+9lM6reB0zRLMMYUr7NK6D+4K02Fj/zwQPr
 TSCPVmaevvuJHCAUjz4PED2fcATW/NJs4ruGVWXAdSsfqOE2RY/GX0RlkqMlYytpzi4Vf0Y7XOj
 AGfUZ+bEVmG3kSzbNQ5sO0Bf4pvKzRbgBQsaLfTIbUN4b7WXbDRqupr+v9pVXa3oZcIbopNef0i
 TdS2ZGziqnNyF42eH72LNY6kMe2TA8em23yWErZr+fK3Qdf8pLVEbFPadA2LRaXCeRWcqRvN
X-Authority-Analysis: v=2.4 cv=SY33duRu c=1 sm=1 tr=0 ts=68438397 cx=c_pps
 a=PuycMPbAwArgayjkkQxHog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=_brLm_9mC3lTafiPIV8A:9
X-Proofpoint-ORIG-GUID: g8w3Lm7NdVTuso9bIhvH2UlxF-Xm2_Ov
X-Proofpoint-GUID: g8w3Lm7NdVTuso9bIhvH2UlxF-Xm2_Ov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
this in ->can_mask_msix, and use it to individually mask MSI-X
interrupts as needed.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h                 |  1 +
 include/hw/vfio/vfio-device.h |  2 ++
 hw/vfio/device.c              | 26 ++++++++++++++++++++
 hw/vfio/pci.c                 | 46 ++++++++++++++++++++++++++++++-----
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d4c6b2e7b7..e3a7d7bdca 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -191,6 +191,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool can_mask_msix;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8bcb3c19f6..923f9cd116 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -133,7 +133,9 @@ struct VFIODeviceOps {
     (ret < 0 ? strerror(-ret) : "short write")
 
 void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
+void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq);
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
+void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq);
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
 bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex,
                                    int action, int fd, Error **errp);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9fba2c7272..d0068086ae 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -85,6 +85,19 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
     vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
+}
+
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
@@ -98,6 +111,19 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
     vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
+}
+
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a49405660a..714d37e227 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -535,6 +535,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
+    bool new_vec = false;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
@@ -575,6 +576,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector);
             }
+            new_vec = true;
         }
     }
 
@@ -584,6 +586,9 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      * in use, so we shutdown and incrementally increase them as needed.
      * nr_vectors represents the total number of vectors allocated.
      *
+     * Otherwise, unmask the vector if the vector is already setup (and we can
+     * do so) or send the fd if not.
+     *
      * When dynamic allocation is supported, let the host only allocate
      * and enable a vector when it is in use in guest. nr_vectors represents
      * the upper bound of vectors being enabled (but not all of the ranges
@@ -594,13 +599,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     }
 
     if (!vdev->defer_kvm_irq_routing) {
-        if (vdev->msix->noresize && resizing) {
-            vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
-            ret = vfio_enable_vectors(vdev, true);
-            if (ret) {
-                error_report("vfio: failed to enable vectors, %s",
-                             strerror(-ret));
+        if (resizing) {
+            if (vdev->msix->noresize) {
+                vfio_device_irq_disable(&vdev->vbasedev,
+                                        VFIO_PCI_MSIX_IRQ_INDEX);
+                ret = vfio_enable_vectors(vdev, true);
+                if (ret) {
+                    error_report("vfio: failed to enable vectors, %d", ret);
+                }
+            } else {
+                set_irq_signalling(&vdev->vbasedev, vector, nr);
             }
+        } else if (vdev->can_mask_msix && !new_vec) {
+            vfio_device_irq_unmask_single(&vdev->vbasedev,
+                                          VFIO_PCI_MSIX_IRQ_INDEX, nr);
         } else {
             set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
@@ -630,6 +642,13 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
 
+    /* just mask vector if peer supports it */
+    if (vdev->can_mask_msix) {
+        vfio_device_irq_mask_single(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                    nr);
+        return;
+    }
+
     /*
      * There are still old guests that mask and unmask vectors on every
      * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
@@ -702,6 +721,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
             error_report("vfio: failed to enable vectors, %s",
                          strerror(-ret));
         }
+    } else if (vdev->can_mask_msix) {
+        /*
+         * If we can use single irq masking, send an invalid fd on vector 0
+         * to enable MSI-X without any vectors enabled.
+         */
+        vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                      0, VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
     } else {
         /*
          * Some communication channels between VF & PF or PF & fw rely on the
@@ -2842,6 +2868,14 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
+    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   &irq_info);
+    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
+        vdev->can_mask_msix = true;
+    } else {
+        vdev->can_mask_msix = false;
+    }
+
     ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-- 
2.43.0


