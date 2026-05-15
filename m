Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20546CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu97-0003qI-16; Fri, 15 May 2026 11:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7r-000395-CZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7p-0006aA-NA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:55 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64F9aSiA1809953; Fri, 15 May 2026 08:06:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=A1qqlE1AeT9I2sRlnoLj+fymnelso/AdV6mj6Q//y
 lk=; b=WaVsHNfbgN0k+FCu7NVhgGGqfF41+R1diz7EhriNBKNoiBIOmHnf7+zIi
 C1dJ3ezlo/7M7oMdDzuzyKiYRKwOw+4q+5+R9nlHSPWUoBTh+PGeNgiDkfxCmJN7
 DBBIXvKrvKjGwCuWwRR54QfeN8k+qNaxK/SVQkqrfOLk16hGo6QBGMA4sJEv1UvM
 beQNCDzBGILwG6ZOGmDasieMyNCg9woCScIi2DVZgpIWVA97Tq/X4yHL+umwrkEG
 UEVCeyvV25jRKD/Fb4tOTaSN9QxAVhvXfe9Uh4hDELrznK1jCPm0nomQkI33M3HD
 ze3Z3AoG8qaruMdff4+5Gf4zafyFA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022125.outbound.protection.outlook.com [52.101.48.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e5m20aaqs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 15 May 2026 08:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bicQIaFMODx42NB7rRQAllaS5DUP5mURSDYrD9NWT+2JL2Gi36r9nTd72ll6OafZahnNuB1N/fgCXdqwSKqQjkpvLIfLgEvT0MvWVUHpVldnLgooc/bvYCu/NjZRKGI809VLeZF6x1ldEOQs7IRno7sjUTQ1dapRgYf9Ckjf+/g4OGXVuvWGcuWS/MTbiAMZmYTQ9z1SaACwqmSC1koiFmljes3KY+bWWLrpdpCGvvvGdkpMCxeK3VynLEeDRJJ/GI6jY7DBCqmjGIhppSrk74IwjWrLwaIww1MkWoqOrh49LPQJ9RlUFQ86M7dieNGWFrbNwaFc0JNSjmqVI6LpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1qqlE1AeT9I2sRlnoLj+fymnelso/AdV6mj6Q//ylk=;
 b=N2pvznZ36wvXP9tgRP0X2FAxFP9tjSl6S5jv9AxKdc3LW7TerC8f52VOQGM5e48iiXePl9ZeNHHt+WTSFou/gspmRCKDOgxtVvz8xcOtOJutMiePDlF+dLLda3hNTg5JuKGalhtt+OhQdXnw6AN6J+fI2KC+HnaJG1JvAeo/qahlB1KdnJmLFuQ9koBgbiIr5VCkU7t/dnN/pxpCSP8TfdMVRfrOCWJLmzbhNW8LDyAPKI4M1CjWM32gcfNnAtuy5oYzhhcoia+LImO7C2vZndFjZxw8R9Y5lx46Qgk1EJHPBjXLpYc8Wkg/vfPBuc3rpkG1wGoRKjjQEPxfhv1pwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1qqlE1AeT9I2sRlnoLj+fymnelso/AdV6mj6Q//ylk=;
 b=ad0ffB7j8r4HgAhHqL3mJlYGL1TkQ91xYj3FxMQAX/VpiY2I5tXXy2pAzsb2ewOwxQZE4vhRtSvEf5JaoS9pw/jdqzi7aF6Gj1UgKzlMzC4mkLVlETkjCjK1LNh9tn+OYiJpDeg8MQih+1TKgrpyS8btNJcAAecJ76qY76wu3rEm92Tw0VfQ5nX6seXPZxpeC5J7N8Kv/u0NsREigMEWl7csLYWiRfVu1/DjQbSQN/Qddc9eQuN8HGYrj4EdPv3+9PHD4+GhyMqF3Mohs0Ghh4+tjBuLCxi2D7FwqSiuUwnf0WPDVCnepBDnXlHZPTTkfU9RCbw39Va69kJisAuMLQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH8PR02MB10886.namprd02.prod.outlook.com (2603:10b6:610:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 15:06:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:06:50 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 3/4] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
Date: Fri, 15 May 2026 16:05:46 +0100
Message-ID: <20260515150634.2637533-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
References: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:930:8::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH8PR02MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: c31b3e6c-0456-43d7-fdf0-08deb293972d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: orZO+VjJb8ZvYeXr/JvUMqchavPTxrnG/uwaGsnS8ZdyM+tWlmOYA1bfq8ijpWKR1RrCjelO2+C9Bm95X+JNevRtIIIxooA8Extt5KfAjSVBAmSBVpT8z7Nz0Ha7300usdSfKffWwOVIGd0JR2iJYDW5Xh5KoxYpGV1JTQJZINQaF1aifCAlAQM+1rnlTZCQZBQ3Kw3Pm50oMa4NxqcFqoKnkUTYOh9NqNZA8uyCJUNwv2i8jxilA5a3wgXB6/D3K1ncixIN/5QfSgweXuGghgDwjKOqqaIewy/QL4D2rXaOmCrZPoY6qH/0tMrgQN9fh30Org+0Qe5cMWkpB8k9sYJLdcRu0fedw5VDrqph55fXA/pYCFQ/+q/DFQzim1P5Nd3L4cBwffPIFr3WqUuAzYaUfJxvIGGLIcgu8orGOEgBuBq5U01EAGiKmC5Nd3NPSsCjD6PFjlRQqrs6hodJWYKbLP6R4Fmnr39lt8x5IMelElo3ButBiRO7Sldolw/YoLxXv4ZyaYYMUXzHtx+KrH07EBB+3Gx2WtcSVNwr1EWWZEju+pTWQeicVraHqj1H6tH7XUwiL5phzHWwcepEPQwRs0wl0K62Qcv8JOgqo1gP+ajKue6Y7fcOC0+FyriFuj93CZimsZIHrAbAJ9wXvJOe+wBFs7gqDxc2JStrF/hu8mWprVzDQBtQbBraAX7n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wyy/KUTOxoh4t7xasUXPrfxdO6Si3nB7ruPkSB1y1xAsqJM+WXkEK9bSX3+l?=
 =?us-ascii?Q?D9cUaQbEqWhJN4s5BvAK5/vtI3eSYFHG9TaBMh9evRFtZuytmQanIQzmIMhg?=
 =?us-ascii?Q?k34kqNxYY0ect/M3tbfgydiqeVwY7EAbJCzBOAKb6nMfR8HjWtsALD6X2014?=
 =?us-ascii?Q?7GcYjA3jjZyIKoNXegA2kxu4gGumSidQHLnj7/mmxh3PJHNWU/cGa6c/vSJE?=
 =?us-ascii?Q?d+3RLCxC7c1B/+mkk2w1EWds9BDikJsueWp6zsdPUYK7N1A7Zf4P6AVcjhTJ?=
 =?us-ascii?Q?3Pe6VKYMUbQV6vEYyjoa/RtwL1A4y7irDsdqNwEdLQodbUT6R1aGj7BT9asZ?=
 =?us-ascii?Q?yM8GBWvH/NQjOQ1/e58bgdSSzcZIoeA0Aj8nCcb66D4aLk2eWu/842nqySD6?=
 =?us-ascii?Q?EcOdtnV5K233RhztGSRTWEWV3jksS1a/G6o+eoGaTYDcjL1+OIFLiN40QNnj?=
 =?us-ascii?Q?S6XArEh4Xh1Q+qGI4QSlOJvVl5B+DyMuLYyouS+zUz3g1B8/X+vQsUylEyI2?=
 =?us-ascii?Q?k02SxZcQWYjUM/Th5PpfuFH8LrcD0lvvpdolpWl7a9lLOgE8sjZ6mqipx+z4?=
 =?us-ascii?Q?JxJdKcXag3El4GZkBlhXnVS5QK1Ww6hFoF1V5QnO2HNaIl7dey8RgKN7kJAV?=
 =?us-ascii?Q?lEzsq/RSQkQ//KotKDxCGuopTqPf74y9+ZNCLEpO1v679BJSMkTaQeD0sWhp?=
 =?us-ascii?Q?hDQ2osmgvLnyNogCcLFfY65xaVySXC40KAI+d7v0PDPzOQT+Jt9ckQ5gzLsZ?=
 =?us-ascii?Q?Gbg/ADHti/psaJ8xw0m29NkQdCEsCVK8MSqyi1xTDGGn7m+EMhjCle/dWkMZ?=
 =?us-ascii?Q?MtQKWprxqDx9D4KnBteugoh6YQgkhL7e9q+ZrBAdQ2wHwmc3+6Cg92GL6bmC?=
 =?us-ascii?Q?KaTHmDwCiV4loycGvUwBWEiELzx72Ia/FHQdTwjLTV+liZUAlZPLeAdilsXR?=
 =?us-ascii?Q?tSRcKP+abzUmIsOBmJq6LI6GQQTjz2N5DVFQlHQShXvLheok4+cdMauq5cns?=
 =?us-ascii?Q?yAN6GbCc0Nl+KlY66Ji5tXdv7gKZRfvGL/EL5rRzpYJnhw1wEuAzBmcmcBY9?=
 =?us-ascii?Q?/So6m2nXeS3lG7z1znOL8VY6OlvUlcsLr0f7kV5ouKpsaYttEzEDnhk0hjfn?=
 =?us-ascii?Q?OlQlPTD+jYNAjo+ou6h7HTb4G8WoJKGUECTOsbOcdOQT6cgdCciSpSoPZg1J?=
 =?us-ascii?Q?ago1KvcnBGk3XiEcfB9klM6UCJkOkRREVAwBF6pg4wWmgc1O3xQkA46/SXyw?=
 =?us-ascii?Q?D2cBaRr7snduTfgsND7DdeHNT1vQY6yNZtIodtpHMaC1bMIbkytees9raMV3?=
 =?us-ascii?Q?WFnLThRaj+UQhLNG5GHXaGnbnYLER07y+vJQ88uVL3TlX5wHdYXJCygAFyJj?=
 =?us-ascii?Q?6fzEEEl3BrR1DFZNAEoQu+G/O3h/2pmWzUEQwpMrevdW/1F/7FF3yiMH8TJz?=
 =?us-ascii?Q?LlGvA0l2K+T6W5SJzPHFUe8KRcR1DGSl4grC36fAnPpolFfj2gD4bz3KofMV?=
 =?us-ascii?Q?x8H8lAeINinUq90aVOToAngECZx15tAvWtT9ruuMqoXih0r0YdmKnrBy2FTU?=
 =?us-ascii?Q?psBBCg4trM83yKucYwuuiZdmowvEO97e1rR3NUK4TKD2nEL0weS3P5VQabSZ?=
 =?us-ascii?Q?X2AwMBgrTWX/ewLIU5i0236Pu5/WIdaWJ4fc6tJu7S3xGp/RhF4hUvtI+qTo?=
 =?us-ascii?Q?G3fx03kKsk0Fm6d1Nb0yctmRcwxJi16u1dG7Ilbi6htvBwcKXrZwtgxVqUi9?=
 =?us-ascii?Q?Yb2szZgEpTr3PmtnT/PPscwlCdxd9KY=3D?=
X-Exchange-RoutingPolicyChecked: cao8P7sw6yIGRUSlPcMB7j/Nfi5rE2t0lcSWm4vC4CrU0Mj8YHQxLLxUThHVJOVKgaQrgEB5jrUVI1QockwxatDHzRGhGgieVu+Ys14YTlloWArhk6FcJA4mTPuC808VPl42ppK2DgQ0fECXfccVR2cuDXISeV24TVzB/0nLml9mdSV/HpWC2ji4OKYF7Kax0c3QMX0K3EPkXixkuJ+tMMSN/LucXjO+0rsbKk8uQaKM4so6L2PRc+cKZB+ux+RIeYjSthepgNv//XmiY36018RGYD2gXKCMVtx1+Brgy5rOL+1dT/F+eq/FQKrvrEtLTOI/W0q3pl0SpXaPn5n9xw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31b3e6c-0456-43d7-fdf0-08deb293972d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:06:50.0909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrzTNltsyNeWePMKorRGLqqueP8UbGDOQu+cQd4oJsQtHvAK9UHu9T4QR5McoWqPv8MQxjMNnUcAE3Zb5Gtc+E7ObCJhb1X3iIXoZluqS9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10886
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1NCBTYWx0ZWRfX3CBYkSwlm8+R
 qThuZa795P+pEVOCJbDlAfICI/oS/0NVmhXkH/HwzMAv0ATkGsgDiO3BBcNFCREv2O+uHOy7NmX
 vDZMtVyyYFIaIr1RNftxkLEnyJzYD4fY5UYsdUx0tByHKUOLuZ7havGSypvotCLa+X4/WEYMqHP
 HV/8dNjseJ6PF081ynIIqiVzU3f27UXFwexOJgypF0Vhq/iyB+S5Cf1TEv8RdIXEjnCIx8m/8j/
 txhgXtA/RW3xM22rYoOqbgxPDywOu2P+J7LGlCusZqlYh7qfiryHGu2Wl2t5Q7c+2+WfYGM0ClO
 OzdiXL/lZ6u33/frTDPsBI32gtsoPfiQwS0fqe7dTQJ7M7bXkJiRSP/7ehJpd1d0tJikWWrveha
 bgLGv0Wmqd13/OFnZJfMaNgNeEl0QXZqKR7vtZ89ERZ2ez+G5Wg/NPROLFgRqc2jBDEVDSDKW9J
 6jQI58/pHAzhxeaEtNg==
X-Proofpoint-GUID: 3k-p-THI7KKnRFUNUfqushibdQZSy3QT
X-Proofpoint-ORIG-GUID: 3k-p-THI7KKnRFUNUfqushibdQZSy3QT
X-Authority-Analysis: v=2.4 cv=Ed34hvmC c=1 sm=1 tr=0 ts=6a07368c cx=c_pps
 a=qTO11YbfUBYfkhAk4rXMnw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=AQmCU37ErW6wu8Cs348A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-15_01,2025-10-01_01
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

From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
3.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
Descriptor indicating that the ISA serial IRQ is low true, level sensitive and
shareable. This enables all 4 legacy serial ports to be used in Windows without
conflict.

Note that it was agreed during the list discussion that this change does not
require a compatibility property since it is not part of the default machine
configuration and was already broken.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/char/serial-isa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a4be0492c5..eaa4e843c0 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
-    aml_append(crs, aml_irq_no_flags(isa->isairq));
+    aml_append(crs, aml_irq(isa->isairq, AML_LEVEL, AML_ACTIVE_LOW,
+                            AML_SHARED));
 
     dev = aml_device("COM%d", isa->index + 1);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
-- 
2.43.0


