Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4909BC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVi-00011B-1u; Wed, 19 Aug 2026 09:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVf-0000zz-Ke; Wed, 19 Aug 2026 09:39:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVd-0000m9-TA; Wed, 19 Aug 2026 09:39:15 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCokE4144996; Wed, 19 Aug 2026 06:39:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GHxpoOD4evGUQ7vveQNt6TBrtckglV222wJ1TaQEC
 Hk=; b=yWZOcqudYW9wf+CzlhGt8LmHkZL6y8eSLgTUgC/ocDqMu7fe8dKP8bWnF
 sYJVfxy9SZIqsLn23g/EMvBGKKUQP27aM07g36/8UOdFgckjAmFrV8sNrM9/S0dQ
 35pMOhIoUyUyQeIoppOEhegJuT0ntW9QLp7MluPDgIzN6G3v0W7WHLTbEKyTZ2WM
 XxMxv9CWHL0YCYTu8IXqad9OsDLKph8sT7GgGSkXbKGADwhj/u0G46zlj29CGfBr
 Cq9JFSbQpgYnQ/ybQmDse+ma+/TAvl8tYVIVcjGDNh3/E4tVb64Mpva/gNIRvqzc
 n04PWtfxAZsS73bstcCJ8PPlc3l4Q==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020118.outbound.protection.outlook.com [52.101.85.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4uw5jqwt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm4xJDokOb3W+o1ROln8ZmUfp4nW/qZJHBdDVpZqE5pNyrfB2Uy9vFWQ+P8p1gCkX49I+kD0bdvWUM6BOoLig9bsuu3MUtghzIInt1E7slzr8JB+qgq6LI0IyY1K0C9q6He8xWUXlBxiW4cRdfrT6K8T4FGkN9Tppyrq8OpML8+3ZS9jsHzjUsCvo67W4EYtahik6QJyHDBhbKz6h82S4G5wEZ/RnxD4rZWq4RCN8yOqDKiJXYEdXhbyIaupuMvOgebbr8t2jF7ZWX1oWAMWNtcIjaeL8miQG2YCjYfkvKu/YvE8VnpwEnPRHQ3I41ajm7PD9W0EdeRaRbmNxCocxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHxpoOD4evGUQ7vveQNt6TBrtckglV222wJ1TaQECHk=;
 b=wfIpCVF45j1lvdAnsm5hlcx1dckkYnCzTpsAade55NbOoJwhLcE3TjaWfNmoJ1jloe49wX3omgb+BtuVTwWFneS3YlqZRQqgpboXbxkVLOPiJe9EjdUAvgNEWzZITj8Mkp/YcXkD1Aqa1lkqZYFWnIt2oI4ixXE3GrhjTom3MJmmugpMPuAR6AYoZRw9mwP+eMTYCGiYCTNWy3T3xEGcVENm/F+ViaAg1b0VI8GolRdbII4ebPeVb0Z8yE7kUGg5M/g9aecKE3lq7ukmETq5qLg/FT/HLM0YUP+9d0Hbj7QCKnNNFs+IvGoS5k9dVXH3wpScQiApfs85NMkdK2xtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHxpoOD4evGUQ7vveQNt6TBrtckglV222wJ1TaQECHk=;
 b=gA/QyaNg+GOLteSyQEY0cICmNr+sj7vzZw3N7Kko5a2y93V8pbCrrf1wSFfv/Kin8fEVKHko6Q78vRmEH/L3AR1ceE8JTB4dleRRm3Qo+z+n8srgbIDujqkJOvjabDmoJaOn8zLkqmjs25etpo1u0VHfzq64PSB11GS7ab6nadZ2KIYEX84E0rPk0R/c3CRuxqeLDlbrhEic9oJgxrwT/cVkqjXqbDhjedZB9AL5X3eZGGuSKdrI66b8Y2KUIZTtkQkR0TwG+cIA2G8Ice7t4++mBu4o07ruyMoEi03XA70e6gZP2HR1X4jxLl1hzaKwCBz0PLSSo3X6+KkfUQCeZg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:39:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:39:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 11/15] qom/object.c: add
 object_class_property_add_uint16_ptr()
Date: Wed, 19 Aug 2026 14:35:50 +0100
Message-ID: <20260819133816.3497033-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2b5486-b5b5-4838-4151-08defdf739b8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lc2rPpw2C/mTjm+iMnqiFk69cn61YNztlUtV+bfHQg7eA+lKyPrI7KoXPoOnASlT43Xa/zyN5kezY/1E1s6Pb8LOY6tfNZcfpMDt3kdITNezlLwirdqftjTIjpCBxlhObaLTQqrexr2zQsNSG3bUK1GdspkijHTJ1tobWl1bpaTCUiTVvs0m6RV2PxhZl/lKIVXoBpHvWPgc1EBSJAyWbircWnWBZ1dO4N4kEfINTQLpf1IOFdCZNtrsgsXKPPp1qBj/9FPFIfQwwigv2CAWkn965WrZFGQQUflfAiLi03XQP0FrryMnt91yRbSM0JTJrHMVkT4z9EEkXKFoSLzAugy+JVtxU3PF01353uHLGfOdIQ0B1YtWxdmRrXN0mbVDdKaBrvu7EEtqY7IajBQeQxz+hd07TbZ7uVRaZB2JIzhMdVplhK7i5UqfZ6exU+8pnj0dxNNr88GAzEIzSZbQHVZp8Femx+X76jyiltUEnyASBK+/6c2BCWr7Va1NxRCBWtYMZ2zqJaDvNGt/EVo9PthJ0gbrKtYdnVNldTCPk9wxbWGmAtygHYX5E71Cl7A45W8kkSgyABrLEtD3wMG7SQol994sBc+3GOlHRZN4yqcQ5sTGY3D7k3XI1IgOULyk8iPTETphw3BTRmSh0R675B+X5Xdh1tOJh+FyZ2UijCcKqsvVb9YMebHjaZibbpBr5UKA2qMHlPRX6FmdlKBmIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s473mwo+AReAbCihb3eR8fXkm4DjWf0G+CEW5M8haAbLKinfsLQPY7zAsCfu?=
 =?us-ascii?Q?FxXUze/56/xREsHKY84o2whRv1H2nu22Cg6Qr0/F/I2xEVp0Dm56S19u4vrK?=
 =?us-ascii?Q?Te7bc6LFx8QjmZF2gYTVkfScZjWomrZWMgWu1xVU0NEkzQd2+5rnm56q+mmh?=
 =?us-ascii?Q?v5do8aUQl7RhJtc0sUSE/8LJtPZu3RAYT/bFhWxexAQuCZS5gHwYUzAE3gNW?=
 =?us-ascii?Q?zkHl3kSohk+yedftrJf8uNCBlumZOp/mAtZuwzPf5ROFH515uM0V66eYkpci?=
 =?us-ascii?Q?/BbWkuMUhVPso45wht32AuPwO0xU/1xE3Rh5zy3OW6ep/S1jl3/Q8VPJwnv+?=
 =?us-ascii?Q?HSj90K9qNEEUz2BVyVRwaF/8Kxh1vjwVxt5wBbWt8FvalXG+Ac0UMaSpTn5e?=
 =?us-ascii?Q?789la+6jZeGtyxtxPSEiUCUeJmsi2ZLZ0yw1WUNWl+ZZDL7UipS0mFChlnap?=
 =?us-ascii?Q?74aYg+YzF9YxK13brWMAqkomb1IEgixl7FFdobQ0lnbqcczJvtJNaq8Il41a?=
 =?us-ascii?Q?FTRFp1q3lBFY/5f2IwicyUQ+poHWgB0o0Fo/AbQ/4iOoTjbSEhiB2jyunA3i?=
 =?us-ascii?Q?wC0nNlEVbcRgK+dqNcQ6XzkXhtG82r6f7eVg1jjfAmNDTdh34fzVHEanLX9R?=
 =?us-ascii?Q?4W9TGCDcQJyErWv5Wd6yGRzYP9JTkZEreYP4SaM3CAZJhekD66N7z9PlYSv9?=
 =?us-ascii?Q?Tf4LOm+cs/7KLywMyw3DY4t6+sV+oQq5i4Iqc0XFCiNsDGp4HBzB5Bqk17en?=
 =?us-ascii?Q?U9XIXmHjU2qTI8s4r50Dq2FHAPnajEjM0Yg3X5R3PORiTIwCKaZe9R/VPf0x?=
 =?us-ascii?Q?jcV/02GAKcqkyrX4YA6/tqIQnIWxnGp5G10S9M2wexCt/I1Ie5W6bGNRXgU7?=
 =?us-ascii?Q?Wz1cQlH5gdhi1EiH9OqMch0gKmSmWbYx31121bpfa74/GCG6YVGKCTCfvAKJ?=
 =?us-ascii?Q?t3v0jvXGPxYS2AGQG8Lp0GR1zOp5fwvm7FvKVutlcvlAIQFs9oQNJd99QKTj?=
 =?us-ascii?Q?l9kJMtrTgjYF9o7FsiD7gdhdPWQjdD+m+UgnCdlY6UjqADqNrTYNniKGA/28?=
 =?us-ascii?Q?BGjzH5gqDwi3XVCJyeglp5trdDV1Uxhi18sAX/PCIuBAMEvK3E6wj/N0zagV?=
 =?us-ascii?Q?zsSIdj6QuO0+Rft0SS23Bre2zm6VpxdIUCgyAXINvGcRlL4S2aq61boQ8kbi?=
 =?us-ascii?Q?/NFrXX4wZFbYneZyfVsJmr2SksojOar87v9OIKIqbeNTA5ii/BdsmfO8aY56?=
 =?us-ascii?Q?Uy8EEA2tobSY7aXkbrzIZSmq1b+ykiebzbhgEpkZ6DVYNI0CD4Sh+hHsri2a?=
 =?us-ascii?Q?3XfYE9KFz9IdFPD3gILXmjy1cemYl7oDr8S4i5Br8JJwBAEqx8K/B8aQ54jf?=
 =?us-ascii?Q?LTkVt874RKPLXVu2CcJ8viJ1HocuHZnfcyCZAn5KGp3Dm1ocMd4ysNvCjeAh?=
 =?us-ascii?Q?YhW78PaatiO9C9BF4Evce7Qv9TBYjai808cINMNeDWodXyoXqoUqaKNfBHBV?=
 =?us-ascii?Q?Fc2J8OMWKqRDBiREqQwJdv7lyFgaBjt5wDinyE9OLlqT6Fg+l7AX2R5C+MSp?=
 =?us-ascii?Q?HqtJ+0uMAkLq0BrabuyAX+118obiD35CZCzW0iN47Xaq41l0FwVIiFA/VS2S?=
 =?us-ascii?Q?Q181yTLsA0wZd4c4nVq8ICeL0pn0js2qmXEO0KPTlc9kxrrFEBdYRocmKr8g?=
 =?us-ascii?Q?hqFe/7nX0uNdpB9BoEPIcC9Z+S6dE1RCQXplH+105MUnnnc1RgOIVTdJ57zn?=
 =?us-ascii?Q?/Vpx5c9O4Xb5U8Ba85trrXOZUHrGxKU=3D?=
X-Exchange-RoutingPolicyChecked: M1vjzQQ0nqhtwzhFT0+1Ki1ua01DNppGd8mJaqJRMY2aUXBYNQVnNk19rpGHL5nhQJfdcA8qKLsdELq00oNhZxQ651V/91tz5BY1HSz5Jx0G4QVQ1qn6WyzLAO1G1Ja4ZT1iDuvngVYrgvnoJQp/aCOII9mfgusBDHN9uRySJN0J6e1m7fQuBb+RKM4oRLzmHlutZIBxCnEpKcv324MiXRzoPhe/UVvaXDU2dGZWjjnBweWWsxST9wCeILzq0F96VSugLcDy1D3kWRBz/EvcDoJeoZn/ivNdCFBnvvv3+nNzV+2o9S0Sg7OohYymzzO9uBH9OpHw3qrTO+l2Ov5jbA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2b5486-b5b5-4838-4151-08defdf739b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:39:00.2334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKlsjWjda3vAcvWH/xWxcRkHGQ2M2dcg8yoZzXSqdYkKrDa8naTPD7U5cytrc0Ogkzg9lJtfDlTHRX7QGXivSjt6oaX6EOyO2FbT/xZFHr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Authority-Analysis: v=2.4 cv=INwyzAvG c=1 sm=1 tr=0 ts=6a85b1f5 cx=c_pps
 a=tRctzTdEjZ2HbaTfnGx4Mw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX9pXouBmMH4uj
 Hyca06f6X3dOl3z5nx1HogpljVWuJjg0rwQZVwFx7CR9NIq0WKH5X4kAA5uBihbYM0XATPVJnfq
 C2Nh9EGRNkqmzfP+1Zs2k2/wFYPRcGg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXxw6tLkj/BkAB
 Bt1nuwraSdEimk/QKv2BnOmE+0dikSZn/Txr/f3OzA6Nfg//VQk3i1xLtVEJKrvJ5puIhHPYhd4
 mzKSMdGCxK5a35vgWgZQjiID2pNm7xx5C30yTkuwe7rpYU7ggS2cNO6AHqZ+z4eOvcZNdnDrdJa
 1zyMmdrm0U+NY2GPTgmhm8I5I0VrI9wk3cT29CDkvZOgCsVr35V+wDZZDkIOZKWfwDxcOhPYOpn
 AWaicOa9S94xs0eMHFOgKBBKR8JSS+dGXPp+7N8DVazZcD+JeB7ra/wEkIDpQ2nRB6YPW/6XEEC
 y68twaFRsCuLIcnsXQT3TGZgiUKtJ7TZADgsgbAi1uanQvmAPXN3AzYk3uzyxNQy6MEmRrcLERg
 b0VB0EmK0bgGp+jMn3GSGPWLn2Qh6l+gNynYuraGEpJ9YQOyWGbOmPoR3tiiqHeXHF/nAqkklAt
 sgrHIzGc8rmM3V7bFtg==
X-Proofpoint-ORIG-GUID: _IC5RsbIE-xBoEERQwaa8IcNMEThhTOw
X-Proofpoint-GUID: _IC5RsbIE-xBoEERQwaa8IcNMEThhTOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This adds a class property that references a uint16_t within the object instance
and is intended to be a replacement for object_property_add_uint16_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index b469740782..dce1c5ebc8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2108,6 +2108,24 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint16_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint8 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint16_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index b82f10376a..ca426b87b9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint16)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
@@ -2873,6 +2874,26 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint16_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint16",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


