Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45DBCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIId-0007DB-WD; Fri, 08 May 2026 06:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIIc-0007Br-Jm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIIZ-0006jb-AB
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:14 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6488mG1U748044; Fri, 8 May 2026 03:19:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=eUivgcYuNjL0q
 g4ugJpWxzdxaTQVwCBZ9e5uLj2o5FQ=; b=FNUTN4AySVhiUGjKuinAhS+IIxPH1
 RPNOUgoFoGde7uEVRMTgYWqjKwMNCG/x/xkfgysN04s8ooepBIjObqHANdA6qpju
 aDuil2hi/0n4LLoeDgkoiQ83X3Uzbib98IFWDpEyge35aPAtW46hWO256WdvLRsa
 3R6KmC4WSRCRkwjLA/+Em0GUCxOEPLgSR4BUfC/wIUt3Rt39Cysjl3gf+3FwZcSr
 QH6Fbkr4WLDTW0xcoZQYsHjEIwuaFdvCHUSsrN2R0ylFnN+BdvaSB8iDfbQ95nM+
 y2Qa9k5ckhXKIHONrALTtzYpbrLtNmylLrJRRserg8XDEBmDIImGFps+A==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020075.outbound.protection.outlook.com [52.101.61.75])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e1cmyg5sp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 03:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqLHx6OVyp92hGpR0bzkuDeKT87hrdz8wD1wzklNgO5xW21N1qhaLhgGubYBm6l8v8r9IMHpkN4XmPUNaymj/AbGBh7gkrtaezblwokM8gITJaWCGJBqNIuYbVIVT1ZT+UAaknvBeorJPQbQHG47zIAZVh1kv6Y/IJ/a3y3zYPnOAYDfNVqnionqZVW2DRlm0TAptARWJkUWxGNH74qnSvO2VQFS29BozgtTXGQBoMiLVOs0Sx6Vu8Sg1dY6Fv7nZnCnfR+0sJ3u/wwV1ogbO/WZmJXfsoa3mo0CIOLYRUnox1/0C2T/Jkz+c5h1QE6jPpH264GgC8NNI3wggEuWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUivgcYuNjL0qg4ugJpWxzdxaTQVwCBZ9e5uLj2o5FQ=;
 b=NW37RKmKnSI4XS/QPNkBmakLbDp0MoJYRqejAYPmYoOUaITunZvwsmYWlDOuPz9JsUp0TiTBVUF6g+WWFqH7av2X0Hcfl6ZLOMJ0nTtH9jMuUEz1ZIEU5A5cPF/YUPAhMcDVxSmjy0vwod5zz1RqGeytllVAJp6+0UNQxgD7TBysGIsvbu1eHhXLU3mErmECx9j92eXmOy8oFZrg6t+/3aUq158ZSp6rm11DDBz8+yey+mCwKBNDMnwALfKIFCeGStxLp/DNysTwqQo3nw8b/+nUbGFqQV8HGOCJJXts4bhYqb/aBWa/VhsmDx979JyTyl91h3K5qjQbQIvEEvGdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUivgcYuNjL0qg4ugJpWxzdxaTQVwCBZ9e5uLj2o5FQ=;
 b=H3lRryUQlbAXCvTAVdd5rYWVdZyCEzLvimiNRkk/3spbZ27oL8+b6XNSadPsWa9p2qRnkejP+cE9sCkx+ELTAzQ5Mc1MPUQX0R/ax0ECpPBZ8EVTlUx2IKcWexINMpNS4KaYrYrQtnFtfZmqAI9AQCDUCBg9eCYqd7FnCbCiuFIh6VsfXdGMeVEVNeu6kGj2Dqn4dSXFZUQgaFFqcINCyy8CeiUUZUCdGI2/I2hufyr+KJGkpBRm995BHRMdXGdpPBt4Cx6xG/eYH2KFt9PGZxowFucLdrLTgOYgK6Fya9KZ6uZFK7gfuuZN9Av94vRezLptL9HAOt9nBicgflLC1g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV3PR02MB10763.namprd02.prod.outlook.com (2603:10b6:408:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 10:19:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:19:05 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] isa-serial: acpi: declare shared IRQs for COM1/3 and
 COM2/4
Date: Fri,  8 May 2026 11:17:39 +0100
Message-ID: <20260508101901.930781-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV3PR02MB10763:EE_
X-MS-Office365-Filtering-Correlation-Id: 3714a37a-bf87-4eed-2f2b-08deaceb3b70
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: UOj02Fhx7cMqv78qBrslNl6APhTzznPHv+juysof/QO7x7L7DzBRIAs8txW2KCHMIq8sQaQbquZWR+KGE3m6vdVzG2FUz7AJNvBaalTzZF2268Tm3uLoHX9nV5vU8/M8YZ3TIlpbqxG9Su8iRvwisfsbSFvcnmHln66V5/umzRnLsO/ndi/anmfKIA1uGEIV+X+ihK9V0qIAO9clY3yKr+/NLqO4Gwvl7IAk1bfor2S/zLJqqCguBzpRZR1K4wrAncpjLRnbSxiz1MBGw5f0bEbK2aVxh80rJb6iFNdz8MAk17LOM54LYPNsKLZnMDCYUflpMgWBkGloFIio1Zj4VfPELqOQNUgjoie9neVvBt7NYX9xFg1Y/Z/bOuXkDgBaUBKN+JdXVVs0aiXk2LE5rP1VTmaP4xNdekVHrPi3eF9qm8QM7W++8LOS3bYm2wI1SPozSkLGElRhp+ea44obmDWvUQixguKCdh3DB1ERK3N40A2vu159AFKADU2EZ4rtD1pRcYB8+agtAEC03mCIHAAJJMQRCv2UhEQKMXzaccCmQo/JPryZ7UOo84GlCFfIHKQILpwfur6GHnnhhUVxMy3xPkWzSmvI8mioI8xSY3e6CBqssh2E59C1I4PwAmFUQXOEB1AUamUYwX/gpFOygs6JzTAfP9qTNIaIPw/GiUi+RV70fCmRljir6haoMPCv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F3Ed/lDRad8atF5WKkBqdwng4iANDmUHsj5EU41Kqmpvw0nDB/+a0cPDsQZS?=
 =?us-ascii?Q?hdWZk3yZSQapwZcRQqgdg9c9S4r+yNKNwNaafA4LnAiQrm6e7IYBmtCU3UnC?=
 =?us-ascii?Q?lVZD7xUxc97lvtzGzCCr8/udLKf5YaHtFXjbTQATJ+VZYIOHTU+ARM6oYYRx?=
 =?us-ascii?Q?W4guBhgOquT6CYUBfSttkHxBcuLZRmybiGWCSyLiJRhZDk5qVnMky6GK+pca?=
 =?us-ascii?Q?rKU7GfCkFKtsefOV/bVyq50vlnuuoxZEk5jc+zVwQPpK7oQqRVgSUowbmULt?=
 =?us-ascii?Q?4GA9rENkfexjRWdaOH53OjorA/qDamhl+S8vSpl+r+LABEeIgK4vYVNQS9li?=
 =?us-ascii?Q?zjPGXiRhjz8yQFYDH6FHBICwCf31rrWH8u3b6LqZ6gm5olqdKSgRlFupsCDu?=
 =?us-ascii?Q?8H3SQMIIasWkACwnlOVg/RKQOv/Jh086Vx/3Tz/j0wGt8RLTEcVhzP9bR0DC?=
 =?us-ascii?Q?MLfxsyBo6Vo4XZlluw5IuoVcLy02DJIoccyBkZ8oAJROY5o0nehKueo87SAV?=
 =?us-ascii?Q?4Oi61r6CFj0yl26H7xzq0GPl18VjBlH7iAe9JVQtmGmnb7uysfeChrWj+lSo?=
 =?us-ascii?Q?tSUaPIieJtMNUYDAJ41WpR9kaG5OSkkYwwHuXIJ0T+sK0Iyht3wMBe2G00gw?=
 =?us-ascii?Q?mHV8pKdNtz3aWjO9Jq4aFdHVL8aBq9eLYBD4Yf6/Tf0vjaBOxCNmUzKaAOM8?=
 =?us-ascii?Q?Uz+PInUlNcZuokDHOlQNzr8VO6mPfnEmplvyNzmSu6JxhmadzU+8X9HeFqpm?=
 =?us-ascii?Q?0fmWcbl0JTdlIdMua4rHFdDAX/WuqFOM3Odi12StLTaiCbHNkRfu9JKI+NE5?=
 =?us-ascii?Q?22EIdGhvXnWQ6/mnmHL9jX4em6YOoLIWnJNJvXs1Z9fu5j0YAZ/MZm9+20Pd?=
 =?us-ascii?Q?7PE3G/1JT4xG2CTgVnzdaKWQ2G5Gfm66b4oYX7LnEOwZMZfbv/ZloAfzufjU?=
 =?us-ascii?Q?QdDjuPzNfV9gDYJ2AQp6TgL0+NfmPK2u9R/qBx3VlRIX2bevaKYFCa3GDhnf?=
 =?us-ascii?Q?0T95AkfdWJ2YNaINyb5bkRVqEUfembzoCk0W01SeUZJOvAMEo0vR9VMZVori?=
 =?us-ascii?Q?WQB+Vi6Giy1Z0wuuRzE5UBhRgxPCQEZlI0ndXYxirjPaxLdijWzybNZww06h?=
 =?us-ascii?Q?vwVsnIeMdO54B10NgPzNymx6WZtCKH/W/CeyO49oAa+ERwrDCTkjNSP30KtG?=
 =?us-ascii?Q?RMN/ZjkmVTuCkntM9o1EU6I2pK8V948LpA35DTFcy/PVXtKa7u9hv7aQx1dq?=
 =?us-ascii?Q?lBk+yTHjAa2NM2WIbAHv2Wkkg/Nb3Vqrt94pJqcYMrosXTxntIaBmvJu/LqK?=
 =?us-ascii?Q?ZhXwI+ngkfr2U+YKD6OTLMyQyTFDzOEUgDleOKKwJ6vgvxcGOfUi+EDS31lH?=
 =?us-ascii?Q?9V4MVKNGXLWMUuQf8PgtxiYG0LpOMR5ezuHkBr/+GGvq3qO22A/j0lkXFKfn?=
 =?us-ascii?Q?l7NRPn1z2rZaCOtQWTVj98y0rq/vBL7X7TYolWX7uxeXhZIN+kWlrLxVe08I?=
 =?us-ascii?Q?oTZSDltibje+2oFUs33bXnxr/pgGjsYJvBW3TcA6gUGCk//rP4Sh0zWcvYpX?=
 =?us-ascii?Q?dVSIqGtEj+WHQ7/+1fAqbLmuB2PMngXCebgJCr7mcAchanK/2pnk/UFEfWL8?=
 =?us-ascii?Q?l7Wy6XG8dyCKiaKi34S170oeEQzA/OIuE158ObGxe78y5osiJWbP9Sh29+Gq?=
 =?us-ascii?Q?XpyHmGR4Rq4H9A/DxvtHZTsq5W9l8/OylimC2Z6qx5RmxIKIBuNWy275xBB3?=
 =?us-ascii?Q?qtVW84nLW5zLpP2M4/3qw3yD/emlHvE=3D?=
X-Exchange-RoutingPolicyChecked: YaZ6hdUPToGjyY1+maHHatEt/5QOvyP0QIqcZhZNH3D6araHBIMLlDUsj7lfffQrHzxoIHmia4UVBcbPDLh8sY64FJ5ZGpVwdB4A4BuWlSKQBQTJMLYVg37PigI6fhKBhrJAtbv80hGqszlJA/xnTTz2M1qhzY+jfMcvWWOkyWY1B5qFnPVxIxDBRXRj3vnNCU9/C3fSI2PGZudTOajz9/Nw/kVPDHj4ozgGsJ0mBroA2Op0gGuGd2lra870RaQUlYdnB3e6Yh9MSxGp27v5Z9pO7lClfeoGBTF1BRtlRUocibXQ20mM1FAfjO791e72wFU70NsQFcqmHaB4h/POWw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3714a37a-bf87-4eed-2f2b-08deaceb3b70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:19:05.1742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q+ZN6hOTfDdVbJOGKeIKbkNl0ca7Gn+5Wopz9AzjgOlK7JYdK9kpyHNLS0ihR1Pcw+rlxbI2B4EkEKn2I2SO1lTUwafAqGIaKPd3M1hnNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10763
X-Proofpoint-GUID: 8ej11w2OktJIJdFepNj7f7JxmslrlIFl
X-Proofpoint-ORIG-GUID: 8ej11w2OktJIJdFepNj7f7JxmslrlIFl
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=69fdb89b cx=c_pps
 a=lGbZo3fvpWwFrLh1Calggg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=nyaK98WtzmMGFejWVRAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNiBTYWx0ZWRfX/l+lYApdqSAK
 BnBmcz56577kZMOtvZBatPAvksAdNksQfQS6J79w6u4MKAr3OuraJzb0QEb0oTDQVOFscUOj2qS
 JhH0UBh7eysX03eaiuDPouPm5UoP4yDRzofspEH8Z2Yi/e/FN5F+HptgxAYvkur8zKc3vEMklmo
 UiW+hGL/BfDWaH91rCGP8s81rTzB8QNivHrQIv2KAW4Iv0oedRBZqbbOC+EYNXXeDrKUJhf0cvm
 UmPcInRNDZQtBmJsqdiMxTeAGRLLDIufigao3rowHev64ix2Lm4RYPZbeOt3J0OaNDajG160jB0
 EXX63/j0AtcEQDy6gX1TcI21OlfrHGQ74hW7y6WDCTyTOfZ3KxIvi4pnaGgH8EA9tsDosYZqz3+
 jpq3KxVe9ooZz8vpTnoqpMagcg6vSgjdxZ7O0bpfI3u+4Jo9AMinlvAuzqGSQ5yoCwyQkaFRyHU
 ncuaN/iHXxyCERGdcnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
3.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
ISA serial IRQ is high true, edge sensitive and shareable. This enables all 4
legacy serial ports to be used in Windows without conflict.

Tested on Windows 8.1 and Windows 11 with 4 instances of -serial on the command
line and copying data simultaneously across serial ports COM1/3 and COM2/4:

  ./build/qemu-system-x86_64 \
    -accel kvm \
    -M q35,hpet=off \
    -m 4G \
    -cpu host \
    -drive file=win81.iso,format=raw,if=ide,bus=2,unit=0,media=cdrom \
    -drive file=win81.qcow2,format=qcow2,if=ide,bus=0,unit=0 \
    -device VGA \
    -serial tcp::4001,server=on,wait=off \
    -serial tcp::4002,server=on,wait=off \
    -serial tcp::4003,server=on,wait=off \
    -serial tcp::4004,server=on,wait=off

Note that with this series applied, if extra ISA serial ports are added to an
existing VM then it is necessary to go to Device Manager, select "Add legacy
hardware" from the "Action" menu, and then reboot the VM for the serial ports
to be detected correctly without Device Manager indicating a conflict.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

v3
- Rebase onto master
- Define IRQ as Active-High-Edge-Triggered (as seen by the PIC) to ensure compliance
  with the ACPI specification section 6.4.2.1.

v2
- Remove _PRS changes (including AML build changes that are no longer required)
  and compatibility property as suggested by Igor


Mark Cave-Ayland (4):
  hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ
    descriptor
  tests/acpi: allow DSDT acpi table changes
  hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
  tests: data: update x86 ACPI tables

 include/hw/acpi/aml-build.h                   |   2 ++
 hw/acpi/aml-build-stub.c                      |   6 +++++
 hw/acpi/aml-build.c                           |  25 ++++++++++++++++++
 hw/char/serial-isa.c                          |   3 ++-
 tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
 tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
 51 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.43.0


