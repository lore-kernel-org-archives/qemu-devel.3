Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021F6C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeNR-0002eD-7F; Fri, 03 Jul 2026 09:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNI-0002Ze-QP; Fri, 03 Jul 2026 09:56:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNG-0006eH-Fn; Fri, 03 Jul 2026 09:56:12 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635utX31961896; Fri, 3 Jul 2026 06:55:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sCP1MiJLfQP7PHNUq1KfGml68u6MjcGC7P4YG4BtB
 2M=; b=BDBHk56AuayGfnhmH/d8ArdzIx5RcI98UVmpqjEmuxucmz/m1xKpkjXcP
 DmY18LjenKtcQN8s6t05nfX5qQmO5PJdCIi3wKvo7U/uQlx9H0xLq7jFUxc98Cfq
 NlzxJtzWl8jpgE4/ApkLlg2rKbAIkQNz+CMVrbgoJd2KS4B//qmqCyxP28LrTs2M
 tZ/7C7v0HTy2XwifWgwxKY4hYH7rW3ijDe7oOAjV8YvEierw+/g8YiidhaCHjIxK
 W9nil+a9a+VI3kFH59++qTKrk3MXHtsLq41iYcCUjajMhVQANrXqiwZd2Bwkdv3I
 ArH/8X+iAb+YTzmbi6u7KlBfbY+lA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020133.outbound.protection.outlook.com [52.101.61.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f57ebdr0r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgjGLRl0mSra+YMOS7koRYrKFITTujzNqNkBcaAyoS30c4IaARA/js7sR47U6PyyekdWfYYIOpJWJLvWSowZawBxjnqYMieDtvV0M9ADVi1polAcb4Q4PkVxTiFFQCMTGO729jFRIfvt+CSF+nbGPG3U5IzdB7RTw8qCcDLtHRa+3b9FiEwoKJiqDjbVLSFNRJ9umOQXYV8pHxz9c79Ukh8rWiSpn6v5jQhDaFFMRU3SSNbvpUa+Zgi5DtSUlNhnnYnZinXlw+WPBSt/hR2H9nKKNfglDBjXbKJ2It+qdmRQ3KT57hWAMzJwYjjEcgNqplXM/mNqA5J2gajOYnxjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCP1MiJLfQP7PHNUq1KfGml68u6MjcGC7P4YG4BtB2M=;
 b=gdBbvci3h7P2D0ke+7PO1c+L3czKg/3qsnXKPBtnLkJJ2O947oVzPdwjeaORO9dm5DSOScbLl/Pwl8iNlZOBOX0LWkH7Ot7bprAZEj2kH1JWuVGdS1WeWYruzLR8MkPoaOOnSymCKrUK4e9KCKrGjQmumRwcQgSqKGQ+LP7MtlB4+3ZAwAG/b91Lv+cYmSru5UYjaCSOx+D4EelGqJ5PRd1VmUeG9TFvz3RaGyu5EzwT/esww6lPfHTcEMtpRdgxEjgl21qXxzHHSAr61krp+xc/dXmIahI/oz41rlToOpg9tvi37wwcDV1Dvt98G+WqZhd6SkiM7Hs02okD3BQqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCP1MiJLfQP7PHNUq1KfGml68u6MjcGC7P4YG4BtB2M=;
 b=IUkpt2q7yDIPrAbh92xwAnnwnEHwC9U1c0hUDGA9ACs4qRsInkC7c5wO2KT0fk1cqD6L3mWcgL3D7fDhMDvDmvoe/AEBUKKy3HN4yR/xqSg9+SOqwaa6XP8K9sxGDxcI36PrW62HwRQEwatgqOnrMskF52QTgTeb7hp5ZWxZD2mLBrzP55iQ04MjEUrHhq2ks/zOEUQQE4G8Yfs+aWwOcyb3dwRmLBjYsFvNVLeNHhC1kHlIsQlJ3RiRBNNmgfPOL3f4oPjn5dZMIBt/rtAPZGLUx+wFMucNtvtHMXNyezNTdUqwDOv3PzISc7iOuTlMNELI4lTpUJ9VRiaLVONpfQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB9016.namprd02.prod.outlook.com (2603:10b6:930:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 13:55:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:40 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 07/12] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object
 props to class props
Date: Fri,  3 Jul 2026 14:53:09 +0100
Message-ID: <20260703135512.3213964-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:52c::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 59be50ee-7399-45f8-37c5-08ded90ac4b9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: FwwBzS5ZV0oHC2vxGwaXFvtD3ybRMUlDaL2cHdmAIoTfTUQUi8t8plR2g74cKTvTvO38ANC+ldRMTYXolQt/UqtKaQmHIUxMUfwkkWm0CT1umJflcth6Xqbt6x28/G/lW2pKPlil11jy87/h4RtCGKVm5Li/Wwf2AdcyvvLT7UiWJj9qnayvalYSbeYmjcsArj1R/T/EuaqDLmcY46Xmjqzmx0J35sdfrxYwTQZ06oVCtNGLnUEp24uGWZ7TpQRwBskxTCUAVtk0cB2O/H2csJC/si3UtXr64W/TSVvk3Y3UaYH+JBx2Tso9FrQN/GaMTxYKr0OpkZvqSoAFGrE7D1HhPg2qaeg5FTez3rhTn3MLNdml3TXkdoP3bVtxcfMYn7zAIaHztjFjTqArkcc2M1W9pzxuI9oaPZ+3b+g3qdRgRVdusHOnGRAYNTv83eQPW7Cy0RzpKy44YR+w7vhL2nJs5jkXoGk1EwjVf3vpeCAyTQNTmzBnYyUpUCfC0x5oHyBsm0T02DdkFqa1CNtYz/45xHQmzq/KW08Esc48iq+ThsaCrFun3OkwxPw7E8BoV+lLc8uolzu8VKSmyQg3N3VvxJCAi9hvCNzJ8ulogMaqkhwnJ+QjuNt2o/uehPViFyKulokAPS+rFIuPGH7CR/OFrPSS/s2zdkSqgYSPRxB07lirvh6yJ/ci4Czg9yxUGSCTr0sQbBcALEezh+SWKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xJg/3bRwOkSeMA0JzYo1JDHOGJMc/TQKzvfhy1aX/CENCamM4dZb7JnpIhz?=
 =?us-ascii?Q?ZVKVQZM88BQRk6Zs8tmeuWSoev9FDSaoV8EpYvIqWspNBCcBbzBDCvH9Fhul?=
 =?us-ascii?Q?FHUhFsUA01pkXiaWg//9R24p7SqgOXhb+KNvmr+hvVO0qJxkkkMkdzHS7jJW?=
 =?us-ascii?Q?TvCzN73Bp9aQ/OffozJfd9hksg86WJRSXAUDHVXnDguPyvLXOh/8nIjPGW7i?=
 =?us-ascii?Q?r+Ns4kXf0wSWopEI1RJX0MPSe0Z3mpV9RAs1CmbgHk5NW514iMSYrKv5BJGK?=
 =?us-ascii?Q?JwlqVYs+Ff4fecoN3f6iRz848NUAxjH9YQFC4LR9twaNNS1QgABf2QnamXj1?=
 =?us-ascii?Q?2VIpD7fR2r2iyu24ht/Yl5Tt4JH1srdjYaxdT8RrSf+mR0njKmXJhb7B5Vfk?=
 =?us-ascii?Q?O8PNavgMCYO/QBWe+96uk7B5+SiDJ6qylrQZ5Q+VhW/AnZjeU1k9LEQEwZ0o?=
 =?us-ascii?Q?p72u3ppkxiLog5leC8tJ9am0XaVsLNCrIEZfUs/Y7VD4jK0G/CJ5peJnbgwK?=
 =?us-ascii?Q?Y8YHQ83NWM7Wx37fmoeQYRFfsRiDkebll/Ugvqq5UvtCaZJy5e7KYXA2q/7q?=
 =?us-ascii?Q?dcL6sbwf7IsAoznFFlsxG528kYm8f2EDdnA4jupaSiYk5Y5XwmBIvZ8QA6QI?=
 =?us-ascii?Q?wn26N/B576aElemTnaEN/enID9t+j9jhR/ztFMNszozWPOhuvpjd9L0nNC/L?=
 =?us-ascii?Q?9M1WagAEOpXixveg4fUEO91xC/IE0kLsWY5SfQancZHC8jQBrJ8s2qpm626j?=
 =?us-ascii?Q?HJ0Zj6fdxPmiSVoVmWreTlthMPLq4hqZmiGyVkLZddf/KB2tWCRlFYOTEGcT?=
 =?us-ascii?Q?ZSZI3dkfRtqCFQ5dtAJ963GqEDIQhIsfjQJgOxVi0E89lmQPkJSZ3iLaznL2?=
 =?us-ascii?Q?9LEnQ7nnpdAbJHe3rMf3S07MdQZeFbFsANDJynjg5XhfOckSusRW7mEmNl2J?=
 =?us-ascii?Q?XA4Cp7OQfU33r++B1A8YoQipiPDvcGK54V7nWMhqYIt3pXTqEwvytI7LC7oH?=
 =?us-ascii?Q?66QJ4zs5OC0dLk86T7+9Jd7HPH2z/t27AclfTi65gxS3phQUeUb4M8M9v2Xk?=
 =?us-ascii?Q?mqIHCu6WpI2X4+3pvpajygUkopwLYAopCPY8TUEsuYwZ2C9D7RyOouLPuBbc?=
 =?us-ascii?Q?3wO0BrcUB5pZ3dVS0Ffcg9PQrkE+3Zoyz1/kUP5hf61QfE7NYUKwhJRn8vvH?=
 =?us-ascii?Q?Q8liXcuxE1bchKN4K9MTBJQsgk4hXiq0mbsmTE4JziXnjNA3Yl48P6vvbS82?=
 =?us-ascii?Q?o0N5+L5Gjv0A9I06mcvEJ9MNRGCkFa1jUgiWyGN3diK+2H0xUBGbRgLPVy6d?=
 =?us-ascii?Q?D7j2OVgw4vUWkoT43SDEZpiLWsUFOQVLVQBS1dHEPBg8Ku83Ytx6yWYvASS9?=
 =?us-ascii?Q?mLXISCgXNoAkmue6nEYwf/zWdOXRbzSDpV5imXSyMll9sGN0SMdpRDaOW2NL?=
 =?us-ascii?Q?E+q1fS7eIo4MugiDwZVdKYQP09mIRWI7FsFm8Mk+KAYPmifHk+Uuc473nhXT?=
 =?us-ascii?Q?4qTSuRN/U5g8D6Zg+/t37fbNV1MyZ9DLOgfzAWGD8QAaXsgbBSP/X0ieSeeO?=
 =?us-ascii?Q?UXLGKbl5BLsHb72HWBWTKSouQbVM2EPnWs3jsTU4fKpdn3js3lnXCFJkBOQ9?=
 =?us-ascii?Q?M1GeGhQdjFO8KXL8rtBUW0PstLFqq9+UCNoqgpeo9sLRpgQN9Ym75jdd/eQ6?=
 =?us-ascii?Q?TfGEenNctBxpofEY2PW3YorUOjVtJloywaRe9f0HINO2CC8jT3jBsLT2JbG0?=
 =?us-ascii?Q?M03rd9MaFXXlhA0GpgkbPATeASSuh1Y=3D?=
X-Exchange-RoutingPolicyChecked: XEnWxJrdf5m20aloEc+IGQuHfRCQEt+8WemEhutj1VBBOT3rK8YxV0DYCh4jUtBxnJD9cDPBZdnGuK28F3HcZZtIDQUOtUYedJnbWX4wtkipUhsAa23cAhb73MdqE0iGqsArU3EdiOiy0hYvUsZPv2/iOqFzIGujhZVoB10WDI3rBU2nz8XjrkTF6f0ZRzjGVpL0iA5fib9PozWXDSabkYDUoFu0su4XthCZxQJykCXeajYA9VkpOXYlGLe78sQJ1YESF8h/arLu4tJpSrlQyTT4m2jiCg/lNVGRfLBe8cNg8X72cGYozAOxFvsEnxppynQQHEngTg1uk8OR3uJQ5w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59be50ee-7399-45f8-37c5-08ded90ac4b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:40.8437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJBDGRQv9tbdNT6bQRQQkjmAg0MlTJOKinjs9Yfh7ffEKSw5VW8J4qfiIZnmLLjyFmvnFzSAZmLp4HCfs/xrxzddvjMXO0NDKSbjUMXBmoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-GUID: VcPn_8c-wknZobImuJThGqLP3204903C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXw/ID52T+BT42
 AvEgBcB91l3qx2cFCqdrmXt5AdvWh8tzfnbVQ0jdlMJGRvmMsdrZISjnxu7K3a8ovmrgb/ziIJw
 T7Xi5qNhqRMVLZlYtRO6VKAPjCmsEILWc0aFnND69Q7AmcZznOy24rQHHcMxCz+0+ItMrRf1BkI
 VCg5VhubJIGnDFbvNitecdpkryKOJ7iTVsBUSju0xzvM6N+PtMcane5Lk+NkSwbulbjnD96BYE0
 TseuOcaC04FtQFLFTP7V6Iy6pn0zo8059n3STZSIDlYBqUf49AePtmqVrUbVTPxZaaMwhuLTTks
 QkU7rlYETCKUoUvVd9VL0nIZuSVGp8H9HBMV/StHHgmaIlBOfkxNITBU/ee0K/2TKHhcc6KqAYd
 9tZFXbS5qH0AcR4MblMicCgOok0ohh+grE4hYp00nflxMCuXUvjU2S1FTxNrjkDedIqg9aytiaH
 ABt6t85518OD1DH9LTw==
X-Authority-Analysis: v=2.4 cv=HeokiCE8 c=1 sm=1 tr=0 ts=6a47bf6c cx=c_pps
 a=3l++41Tsbfu3Vy6U+n14cA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=1677IaiEuyO47b-9faYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXyMOizehZ1M8F
 iKWieiC+HHi9T3Gq4+xkUqtgu2lhs53Q09GrqhVeaTpkIxwQ3FSFEfjwoekX5Iv2m8FGFQlyyil
 kqA3adSFRqUfC5O0oo08Re0M3UPb/JA=
X-Proofpoint-ORIG-GUID: VcPn_8c-wknZobImuJThGqLP3204903C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
 hw/isa/lpc_ich9.c | 68 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8..f89fadb032 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -683,24 +683,11 @@ static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
 
-    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
-
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
     qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
                              IOAPIC_NUM_PINS);
 
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
-                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
-                                   &lpc->smi_negotiated_features,
-                                   OBJ_PROP_FLAG_READ);
-
     ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
@@ -880,6 +867,40 @@ static void build_ich9_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
     qbus_build_aml(bus, scope);
 }
 
+static void ich9_lpc_get_sci_int(Object *obj, Visitor *v,
+                                 const char *name, void *opaque,
+                                 Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+    uint8_t sci_gsi = lpc->sci_gsi;
+
+    visit_type_uint8(v, name, &sci_gsi, errp);
+}
+
+static void ich9_lpc_get_smi_negotiated_feat(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+    uint64_t smi_negotiated_features = lpc->smi_negotiated_features;
+
+    visit_type_uint64(v, name, &smi_negotiated_features, errp);
+}
+
+static void ich9_lpc_set_smi_negotiated_feat(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+    uint64_t smi_negotiated_features = lpc->smi_negotiated_features;
+
+    if (!visit_type_uint64(v, name,  &smi_negotiated_features, errp)) {
+        return;
+    }
+
+    lpc->smi_negotiated_features = smi_negotiated_features;
+}
+
 static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -888,6 +909,9 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(klass);
     AcpiDevAmlIfClass *amldevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
+    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_legacy_reset(dc, ich9_lpc_reset);
     k->realize = ich9_lpc_realize;
@@ -912,6 +936,24 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     amldevc->build_dev_aml = build_ich9_isa_aml;
+
+    object_class_property_add(klass, ACPI_PM_PROP_SCI_INT, "uint8",
+                              ich9_lpc_get_sci_int,
+                              NULL,
+                              NULL, NULL);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_property_add(klass, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
+                              "uint64",
+                              ich9_lpc_get_smi_negotiated_feat,
+                              ich9_lpc_set_smi_negotiated_feat,
+                              NULL, NULL);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


