Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102F2C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y7K-0004Fz-FF; Tue, 22 Sep 2026 06:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7J-0004Fo-3k
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7H-0004WC-EH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:52 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03bhn2606145
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AdCj70mSRs64WQSdmUHcbvT0GPN6SdVUeLcCbDHF0
 BE=; b=RmoT7Yltu/28UowtgL4+OwYJ/siE6vGAtlzECrc3EwmUPtCsc6ufTypfI
 +Dg+WnJUJW0cmBo+lY0353i6p2z08Tl1xEcvdYm98Ll4G7m8CLdCJQa+Nr90TaZi
 LQ6QwEGcmsXtXAxoCO0CpbWPTgeNJUKva8T36NsxEsztjx279ZRhDtGu7UOnPABx
 H5Xr/Y5q9nmTqA4g2WyCUug+02U/M5cneYjW3UBY+wPslRsPd2sd0Fkz+8ZqzL+8
 +9LKEXA2s1gLSL6Q9EG4+nLqD+2vT4pnioWzJkmngHN6jTBz6VwuRe9zeBtsKq+s
 M1622jJ3PG0ay6xX9ugTkER2Jd8tg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021122.outbound.protection.outlook.com [52.101.57.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gspa76eby-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ7OY0tlbrSz29JBzGguWmPn/SP3CYp/Y+Q9UHpeKoi9dw1E1wU7LgRj4oze/r9oAX5HnPrmikaLgyUDrkTq+VIVvnI4VxRkLLIChkSH8Q9L6Y/PVNnZdX3IFZUcBCgBw4VMuPMxVAQVydA4JWAnv0KEpvH2VpZQmPlzM7oG1z8uOOLQ1ixqCm5AJTAOCgWYzilXdXAAkNfhHqcnu8I6V9PN31UUv/A3SfuPhLrk/CynsZu+2KLgetAoMkmMMvH5j+4VpR3momf9ERsPzFszHDR8T94eMGqQbLvRZfShLVPmCAX6F/USPKrhl9dgOAwRsD3YsAvvUEzEbYk7xqRumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdCj70mSRs64WQSdmUHcbvT0GPN6SdVUeLcCbDHF0BE=;
 b=BQw7GBru/lsIoPvDVvVJ42HkIdAlE3mLAFynWRk6BAIFug3VvjujLPpqEBJ8F1J2W0WDtJaWsubz1WebkQqh2rUrTgCxAu3+i9C5S26SOF/hHxWBIpar92x0xJFP0f6FyIlgZrx9buCAqSYurqmuRyYc0Y5h1QU/RDp+HYR7+WPJETswv/KVU/Q15ziTQWBVVoTErsPFSqFgpe87wdCtVX/DNdn1rJpY+KYSEDY1OHxjIR62FoWADlCCQHvWlWrMANZQOxjn93sn7Wct3PwLltdyBaLF7GdTb8I+ZfV6c2DAm1gVDS5Y3zxbs4iSuSGSVUZn1NGnPpfL77vO8S0tBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdCj70mSRs64WQSdmUHcbvT0GPN6SdVUeLcCbDHF0BE=;
 b=g7LrfWDRH8bwBVi/e1rNiBRT5GJAqBFXnl8WY6nF66YDs4ziR9D5hIRUcXmyFp08muc8KsqAkRk6zfIYSiQgmxp8mfD9hb80N9Ryc8vle0PKdjeJht4kdFpjfqgHmvmvMHF+x0KSDRJHZuO992Es29zkGtxiVpDhNb3hLcnXJaTzYGjVW/o1hfr1RC4SZu27l40SjV+5vzuKlmEQFeQL+tZFAq41wwjh/ngohGQv3b1/2vuDihKo/dy9lmR6U9atB5lRFvh57KvQbG3AqAWO4GibTG1cIRVfPWznjKjYEjQ10tr1Qh6mGs57jYmteakwxGJMcuUvq30tuqC158HScw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:48 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:48 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] hw/i386/pc.c: convert pcspk-audiodev object prop to a
 class prop
Date: Tue, 22 Sep 2026 11:51:34 +0100
Message-ID: <20260922105223.1607725-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 395679ba-68f6-4699-c9da-08df1897a435
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: g4gvhtNPP+M80rTzSItoC2EtboVpUDRiKe7qe4LTOKxzOKyo/3qEDv79kMzy6LNeCVShKeAvMc0pouirQWJC+nAiVGT/vhim/7myOg619evkXbKgPGorPW887/f/5MiyB8ZBb3Cq+NPbWJlmCMoHnhKSSMbWuqm+CYZHRsGCzSU+M8Ipa8qGBMJDvX3QENGJDQ8DGWTggSMAKuHf0P73epI+rEiZ7aweHGppLmr30ccZ1befmNBn9NYA8JFXGdDucldkrmJO0E0x+6u+C3SGDOec2M3z1J8+HHE5h18NG+GBr2y5EcbEIldRpKeEsg0rCSmP9FMkwowEkY03v5gn13fwyG8UHt3w4wO4MZ5iEMx562GgIL66+Gl/wC+Sw8vaVuitVkdC2C7q1KlXlu7EM0vx+20qHQh919P+wmpZpYDrwehZc0XulGyB5tW5W9FimTdmmlNvuC6s2K/90bKIEnZ7/wByP83mM3aA9CUFrRblfvKwOHCWxIY8vj9hqDZIe3pZibx6+xwFXds4KuG0WzpXmYG7b1O7M30+Ek0igbeUOZ0MQ+rvJ3EVs5vquRU9c6KFGivVYT2EDTDuX3T+KdSfXwTyR6wk5D8OsXndIJuZyAXiMNn8Gjj2k/otKJsuKDIjsFrcNC8N0RSR8dDMdZHlIACnjs3nAWG/e649zl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW04ZGtyM1J3WklKc1FBdURCKzlvSW03c2Jsd1k2NUlpck1FUzNXTjZOdmo2?=
 =?utf-8?B?M2dXSE5ZVmlleTFtTGU5OTNVTUo4OXhIdStLM1hYdjViUTlPWlc4VTRneC9G?=
 =?utf-8?B?UmVDM0Ezd2tHN3VrZ3crcU1nU1dadUdtaWpHdEI5RWE2dGdlWHdhRUl3M0dR?=
 =?utf-8?B?Q0RZbGg1SHNodHpUUGUwUnBHeEx2UnhJZnR0UXFZRVhLb3JCaHEvWUlndEdp?=
 =?utf-8?B?MnQvbnpndWY2VVFiNUhJVmQzazlSNnpNYmNxMUIybG1tdm8zRk92MjlUREtS?=
 =?utf-8?B?UHhsZDQ2N0plZnBZaXlCWG9SMElDMXRMVEsrWWhDSzFmQ0toV1JVQU1mUFFw?=
 =?utf-8?B?NGNwK1hxaVcrc0pWdXJESkxsL0lzdmtFN01YTjFyYnRNZVNTeDVkOEVHQWxv?=
 =?utf-8?B?TGFVMDBPZnhaYXd0UE9rOXVRdmVwTXV4ZVBVb3FjRWNWMmJ2UmJZZGhyd25k?=
 =?utf-8?B?akM3d3FPSzFGRmdYWkNyRnJSbFFXNmtzUytLV3VpNm5qc3dGNDZveGZweDVt?=
 =?utf-8?B?YU9PSWxGVjNoRlAwV1NXU3lKT29CRnJuVVZsRlN6MGRvOVVNaW5ObVpFQnFH?=
 =?utf-8?B?NXkwZDIvNFFRenBtQkpndHErTy9KeFNobVJNdTA1dkt6WGlUVHNrL2R5UjB6?=
 =?utf-8?B?VC84TUJsVFdRMkRlcU9vSmE1dlBmWDVkSi83VVdtOCthZ2JaUEZQaGJoMWpG?=
 =?utf-8?B?QUNzTlN2R1ZRSER0MHFiUGhKV0JWcEloSG4ya0x1VjFSM3dxQVdDakhYdFR5?=
 =?utf-8?B?c2c1bFJXZVJJZnZNdVI1VXlpM1BLVUgwampqOE5uNXBuNEw4cmRzQ2VVUU11?=
 =?utf-8?B?MzFWV0c0bUV4U2tjK3NUV2NDUCtOMUFhV2NHMy9mNUhlNDA4dENXSFdoUWpy?=
 =?utf-8?B?MmU5MkJaZDR3NGEyOUhYbzZjKzZhd3RCYVZpTmt3eGN4c2M5RmZsUjIvbUpm?=
 =?utf-8?B?eTJrK2N3Y0ZkSndWU0xXTzJVK3NJZnNERnkzS2hqSDIxREx5aGM1UFhsNVdH?=
 =?utf-8?B?MFhnVHlFSUR5T3FIaEFEaFhwVU1FV0VXMkU3U0U0bjBMY2xoTDZkaTVjL3B2?=
 =?utf-8?B?SmdLRUx3L3hYMTJkUFRYN3Q5eVVMazFod1FHVWZFMXh2SFBwbldML3NMTlls?=
 =?utf-8?B?WUtPUTV1VDVLeUlGalVjRVpLVlJweEpZQ2N6bHRELzJRdk5WRUwyRkhoTGN5?=
 =?utf-8?B?ZW1rWnRJb2hlaHpjdmtPTjRKNTRDQlJHQ204YkM4Y0FnQVl3NlRLY3N0TTRt?=
 =?utf-8?B?OWtZbkM0Z2lJOW52UVNNTnN2N2RWbFVMMjY3SXpSLzdpSlp0Rk1uK2o5d1d2?=
 =?utf-8?B?ZS83MGI0TkFpaFJrSzVzcm9mNHdhSU5STkdHRG43MmdRY3FNbExOampxYklC?=
 =?utf-8?B?YnFVbHUyNHRSc2t0Ti9HQUl4QmZrU0VXSU9nKzJaRnpXc21BUG5mdllqUzc4?=
 =?utf-8?B?OE5iVlU0aDhiK1dLRHRJc0JpSjJ0OUdoUWZUZmNqNGJCOCt0bnVMZDlNZjVr?=
 =?utf-8?B?TUJ6R3MwT0pkUXJZQkJVaS81SEl4Q1VxY3ZQdXUxbmlaaE9EVkFHVVhCZU5W?=
 =?utf-8?B?N1ZBelJMcGJjeUZIUER4QWdRN0xxZGNqaGUvOExmR3p5VmhkS2lidWd5ZXJ6?=
 =?utf-8?B?bndkaGFmdW5MbnpCSXhXVDVhbFJMTzNaRG1wb2hBTEMwVmErVWVLNjBwdW4w?=
 =?utf-8?B?eXJ2dVd5RERJblA2M1BQMlp1VkpIaUp4bGkrWm82VUFFeHk2TWduVDlUTEVz?=
 =?utf-8?B?VGZoT1lsTTNSQkJTRUEvMjdQbU1KS0ErV0I5U2FMUG5MR2tLRUcza0dYUnRr?=
 =?utf-8?B?YVVTdkRURWtLckV1N1ZRcGJxTUIyRHNLQVBTbWZpdFZ5TEhkM2pyNFFkTzlY?=
 =?utf-8?B?bHc2czNsQUliRVNqa1ZLQVBXMExmWld4Z0dIb05uWDVqZmdQQWdtL05uSzdS?=
 =?utf-8?B?bUVKUmlPRzVaZW5FRS83WXhTUHBldDlncUlINWVwbG0wUWo4WEtnZUN0VlZk?=
 =?utf-8?B?SXc5NFkrYzV3aS95RzlLTjRCRVE5aStIQlpQZEExTnVISUd2UmNSSVkwdmM4?=
 =?utf-8?B?ZS9KUko3b1ZXUnhiUnNHcnJOM1hRV2VJN25VQ0Rqam01MlMrWnp6K1psa3FG?=
 =?utf-8?B?dVFjcG5zQnlHbjJMUFJ1WUVqV0o4blF4MGZDSHJ0OTNVeGp6NzRnNlhRc3F0?=
 =?utf-8?B?NUxXaWlxMjFoVG9QQlZhNFZJdGZ0MWpudzJFdXpMck96UDVSVnFHU3dzUG5x?=
 =?utf-8?B?SmgveXRjTTlyWnRKVk96M0Vmcm9CcHBPbHdHeVZTcXV4ZUJGaXlldUtkSU9j?=
 =?utf-8?B?Yjh0b0ZKSVF1WVY3TGw1bkNWRi9QSFFrUjJ4QkVXSVVIdFhmMkFKNFFCaW5a?=
 =?utf-8?Q?aPDY+BHqAKauD/0w=3D?=
X-Exchange-RoutingPolicyChecked: T1x2t4VaFA0bTfq2K6l0fNignVgef3ubmLr1AJWEid/5UKaRcU5gvzpJWeozEWqFY23jrBRfHyM4MpFb7IqZn4V69ouEfp3A+dNxQN2ldOj7Rh/S7sB9Vw0trFLukNMwj9dmyzdB7j2ZRO3bdVm5T+k3PX+fTbY02hPuAtLa+ZxyQ1TebU98POUHihNDFRdhlBPUEUR/Qb3LbxYOWLWXCvuNC7kNdK2hdhML1Ilofb6iINIBcF4jOsDTElgCABQFqPpGqH+Hql3N5rK/DhMhiIVrFiQT1vOkFs1yK0N6LsJ69LTXATFXQiJ3i/wZErwNOmUvy0NaflLA8t2THqa2SA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395679ba-68f6-4699-c9da-08df1897a435
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:48.5099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GkksgshevF65pLSvGtW4h2oRlPfjVwJnYPKGM+vx4xWTtWfoYs+GBkyLg+9AeD5R+TR+QLIH/jE17YGlOLCojc+jVPp8Pi6751L59OcwBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Authority-Analysis: v=2.4 cv=fPWsTpae c=1 sm=1 tr=0 ts=6ab25e02 cx=c_pps
 a=1dAPbmINT/BjSfFMotB1Dg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=5lzL06hd43tFQE2-E7wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX78aYdFH6KVm5
 b6rk/r/QSjtzIC8cEJhhFJyVhUBqxXEElN5c1fmtsd6BUeyYi/7Pk0xRJcZI7HHw3rqvPOWMFaw
 UweohYZQDXK8zBLJCFMwPB7E2f+hgOo=
X-Proofpoint-GUID: WHIvMqs-dUQ0zno8Cxv9lkNzJidnfxvW
X-Proofpoint-ORIG-GUID: WHIvMqs-dUQ0zno8Cxv9lkNzJidnfxvW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX/+YwL0GdsRrS
 S6qccz3WaXZoAjbSfYaIQj7G8pY1rgDZ9+9L8avHrR+JBIUszQ9PAWAn9kUi7EXns1eGbvBPRGx
 m02VW9G+sR6wFBwgvh271TbHkC7bCAeQ9NlupUY2PpTxc6Xvw6p8pV0UEaKFSCE+ZUF+Zy3hTRH
 NjRSv5+UhTia8lg+f1yUnPkdoQH4IwRct25Z1GQibCyi0yUHjUoieNMzl/u/GJLrp99gdr2+Oxn
 ermUJjcPlyjxxpJSB6OCb3+YgnUTjJTHUxEdsdW0IAhupE1TdcI7NtMMNnf4fA2V+yU6rF0kke9
 3SMTAnFWnBgq4JRwi3dpwZmOOcKhzMcqShcf6fNAbkw69i+XjqB8cxPW4GcVi4tjqZAOTJ3QXZO
 qJ4RB/1Rx2N5TWtnAwbAvdLTBvpbEVD1th1UpNh/BqIToZ3uRuIXjBqot5xBQvtD1K8AcpdsTuX
 A2F/unYRQhfIKTz0wpQ==
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921113559.1299740-6-mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d5dc79df17..2f1603e104 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -38,6 +38,8 @@ typedef struct PCMachineState {
     DeviceState *iommu;
     BusState *idebus[MAX_IDE_BUS];
 
+    Object *alias_pcspk;
+
     /* Configuration options: */
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9006e7c29e..e2ee1bd88d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1643,8 +1643,8 @@ static void pc_machine_initfn(Object *obj)
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
-    object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
-                              OBJECT(pcms->pcspk), "audiodev");
+    object_property_set_alias(OBJECT(pcms), "pcspk-audiodev",
+                              OBJECT(pcms->pcspk));
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
@@ -1788,7 +1788,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set IGVM configuration");
 #endif
 
-
+    object_class_property_add_alias(oc, "pcspk-audiodev",
+                                    offsetof(PCMachineState, alias_pcspk),
+                                    TYPE_PC_SPEAKER,
+                                    "audiodev");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


