Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB751125851
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MOA-00025d-4p; Wed, 11 Mar 2026 12:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MO5-000249-CT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MNx-0004Cf-Rb
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:17 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BFn8IR1315593; Wed, 11 Mar 2026 09:26:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=iHXYiymWMNjKr
 skyHI5sMyiqaY4A9nQ4vSAFdTz15fU=; b=yY9joaugloXrGw217ldEB4NPS4GLo
 dvcag3wMRYYIC+ESAo59yuW1i3mUIFcVLlqZndKS4ayOuTCyCCF/Ept2oMTyowA5
 wHzQ6vwiNw1KHrAOefcd/8silQEXMkrm/DCoDyjRMCZdrdwGN5UfUd2QcSSRZ4Q3
 isctDSzJKkns+72uevMr5SLQhhj8Wa/CqcIDrBpEb3gJVK/YAnEr77yd/ygrlvKM
 zkXVjU9ZGd4O8ilG7rkyxg5ZKyOgaUGs/kNnbAEOoD7GWRAARtcZxJAycyGSAwkX
 q6eJuXrZpu6zInm/xK//laFkJNs5D++kOipyzHQexzfswwyNjP2f92GEA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022108.outbound.protection.outlook.com
 [40.107.200.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ctu562dsu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 09:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvfeEOmLDv7acpEw02t32C4fVyxFXdOnWHa7H0hHUeptw0vWiKoDzX3EF8JjqHT7TPrnjNwsVjn4NzkTazV0VPI5MpVcImzK0HPsVxwUa59BAImMI33hCeV9n6SY1PN8wz6ULdMaV917cLb9s3/HHPMuGnlSmGDjn7SmrqXrB7wBQs5lZ+NLJB/glqwtuzpGPL7nO7zD1gwiUt3lyR2XWrKTi8Omxv6eOZ2YFiUoertub4HD6vy+QgDvFgoKFOEIbJoy/K1YaHtuqkobNjp93g3atEWe2Oiy6O3Zi+/E4Wo1A9l9b6q9GOI3siqlVCfoYUj/9HXo3AhN4hrtQqcmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHXYiymWMNjKrskyHI5sMyiqaY4A9nQ4vSAFdTz15fU=;
 b=M9zOc2g0QaGIjBX5jDklwf4gEVTsMYTqrWE5PXR6g8dizSVYZQbgAf0QJgTgcfODrWlISwn6zZn/KbKHZ5+B/Iv96FDqIG7Rgr0Fv5DOISAJeZFglcINEmaHN6QFikjoRwEBGkOGpLNZUCRvgk/HDl3NZJehYSybhvc/UfCjrLwdFHklnsrm5udH11uen35ZYGbQqrMD9zTQvXk1+q/SJlidmbaVbiF+iyI4P0RmfAinjY85Na9+Fk2T9O6QnYCxkfa6iMmO+OX0E8lIbAYwTevx541x3+vJUwmHK4fLCTAJA0UukOpzvtUvWQwbDeQcFt/OehPH0/DrTY/pvZ9SpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHXYiymWMNjKrskyHI5sMyiqaY4A9nQ4vSAFdTz15fU=;
 b=MYnKW8qfmQ3DmduZJnJc3NapUnzvyZXoTmvxG4FdtWr8ltvKAI5Ryv575D6p3yPTxLep/gipt8G5F7joYSrfTKELTq9TU6vM5fBtVseNAeA4LAjGRonoqneuoeG88gFJEiCViVBRY71MlJAlRa1lxyOoILq3Nl4AIyyRq8HvIYRRAq5xufpCDEclkdLqWHvlJSqAw6vXLvAw+sNgLsdHvBgjIq3J1oHxzOGX4RC4kq9r4XeUHh2MEpIpUSXOuogj6lngwh/HUni5SJ3/1KUVgXF/ugl5KNOTVHjZ+JmITVYH2f8tZekYY4iQt6IOwgTuoa/mvhVohRSlQ6plr92o/g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:26:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:26:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] isa-serial: acpi: declare shared IRQs for COM1/3 and
 COM2/4
Date: Wed, 11 Mar 2026 16:24:25 +0000
Message-ID: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV0PR02MB11111:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d79c95-d475-4827-0351-08de7f8ae6b5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wSTqHz9e50BqULIBxQLRIfBl2XAay5C3fSOXJjAtmuynZ4SPRQ8QoV/uWpGhYfpMFcOzRv6jATv1AwgIWC4LlNLYC6qPotn7u1BopwQBLdNkkNmOBDw1ibMBvaD4ERB1Qb9lShH14jigMI0/V3GlTNFE8q2C8UnvEophBISsgIpK62esCBN0ExUflKz7dcgxw+9XN0fFU56eTgcvklxvdRpJOsYjHwE5lPR5sdy+yJJSc/yiLRmCt1FlEXvppr0NJLU7dhYRCkriQ8jCebmtwIYU9MXPne8UATLkFoRjMZ4+U90JTYvmc7rdhcYxuMJJVLlo6L/cztXdCQZ1NDtlMHX6yyKQEjLbQupI5lG/LpA57q+R0utT61H3znRsJPYZUKl+A0BbxH7VPCc84CLRZ0oJQK43nhhaNcBHaIjJBv6bQ1HhBSWlfFV6RgYPmOQsVoTbGptZIhV/OtQGdz0M++LshMxGOZvTNV/GL5DEbrGML21a2ziu6om/fmES8JUo8b03AYoYU6fKnn5/4ArUGy4PmW1G/j8OW93ZiWMcQTkUwQGJtNMjbCa6XinkNxv4MWoG+nmJMkOIorJmrdlY41zPoZ7uCDWcrAunLtq8bBmlh1iifGcjDMENmTkdpwD06Xod+FGN47UVLDmMlRWe3agwqmyYgI54NKfvpw3+0pmlQhhUFaqvnHFlh8SCzQD/sOYjoIl3yYMaCxNZFps01iu5QJp8GNtLV2J5wXOTVgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y53+w+9ubOKm/JqtYCCNcg2RlJ4OeI40Ib+w/1ID51UfIhfE99g2yNgGu/8o?=
 =?us-ascii?Q?L2X221CKV1jKTn9x5BV+1M4MkkSt9Bk8mdAc7tHkt8A5Q7iDSuKcadjSq0VC?=
 =?us-ascii?Q?2wnRkpoFzbJCmMY+EsRzBqCj+a/a3z3tLh5oHdgLmy+khef7oEyqVSj50Gdr?=
 =?us-ascii?Q?K4//qBFXGUk+QHfQSKwExWSGexFfyDKMicV1krb2QXbBtqzsKndtw195p3UT?=
 =?us-ascii?Q?TBOxoJ/73wIcFb1An02Ket32+GUaloRqQGbWIKaic5dxptTjcXYNpUTqAUYV?=
 =?us-ascii?Q?8zU35eBT5GwzHxbwmWjFE8kJ6GZWQJlErH7CrHZ8ENk/aBs5K1f+JfelH2yW?=
 =?us-ascii?Q?NQhdpEICaPGlI8E6JPIhJdpATWs/Hz+JvPEAeCKPprJew/+IJFwJkTwIPYi2?=
 =?us-ascii?Q?1U0bpEecqQ19meC3dbIsmD6FxBv0Nrs4CCp5NEYvR2lcvpRCgfi8hJMmahK5?=
 =?us-ascii?Q?vlS9H+M01rITgCiYTHqzcNMZUyD88+gxebrUADEHQreRZddtqrOuHGu+5unG?=
 =?us-ascii?Q?39r7477c+CejOe62GXHw1ufJH0spdiPnkLhRCJ/g4JWtifYCI20iQ20M6qsG?=
 =?us-ascii?Q?ikVedGMiSdF7gDVOQmESNc0XqJjJgzRIoUl9DoG2501Gt7E1R54k7OV0qriy?=
 =?us-ascii?Q?Qcr0NUMVKMpHagS1cbUfFHdSa2M3NysS4QMC8ssdtrSZLHh6Ffc6icKVXtUF?=
 =?us-ascii?Q?Lc1LzfbO412xJszJ99h1fnR6qdWodj2NSK0/bU60+RV6VI7dmD75oeyOM3Pf?=
 =?us-ascii?Q?0jKXg2Ylk9dXxMTWPH5twwvT3V3qZoZpg7pReE9X3Hm1iCAf5TMThorJGo1d?=
 =?us-ascii?Q?MZON65uKmZh6ph/fhjdTHyKMFVRnI6Iykx3zRKstEpMyXHbDEuSmTrNnGL9Q?=
 =?us-ascii?Q?4egiz8/afsQ5DG1YphxyboCbAvZUr+kEFw84nxqrhDhfRzBjQ/nkH2m56pAp?=
 =?us-ascii?Q?2SQAVRft/oAHa2gbvamDSwv5+3r/Jngr79WkptD5rRThA4wonXcNqS5mhzcZ?=
 =?us-ascii?Q?onOycJdjR965+9V08vaXrmslX49bhfbgNW2JYCMSwkIu6gldUQD+CeeJR4a4?=
 =?us-ascii?Q?JXdIhDebHjkgY/3WONhi5e15WsMZbDTEre6YUztgCAvfEBOsujFsYbSqj322?=
 =?us-ascii?Q?qNzKPxg5CXL/ywfRpUjAepWvwRYvbp6xzV7+93ArQb4bJ4jdCezAso/TwbSK?=
 =?us-ascii?Q?VQSpFTtMlICXM3lC4JQRXnAaofcIZf3OISblePqbltMN0PYEUkRXlStyTc5y?=
 =?us-ascii?Q?X7DxIzXGbnW+8RlBNBrwr7SUpxWg6/dcdoWn3/zeF8xjTgtYLx6GEZILrVOk?=
 =?us-ascii?Q?PEIcdG5jiMCZeAazo+QtcfxStwHdS+H3fmkQIRTgOVm760+wuxGiZ0/YddxF?=
 =?us-ascii?Q?RE3fIyLuCKfB6ko/l4TeUYNEZqsQOv9KCTINOufa1katSLIGrRlH09vf9Pd2?=
 =?us-ascii?Q?Qquv4dIGgqZEzqsHzX8J4sCwbLtiA0nJ1Pewt6P3ng/y1LTBbtXVGwS2a4D5?=
 =?us-ascii?Q?0P/aQS0O+fKARl1PM8B1WeuUnZva8UhQ2n7536jSGMz1FpsGEaZjwBzVfcr3?=
 =?us-ascii?Q?3yHHde7x+2GKbAWkoDdT3MSKFWbGjQkCmRAvNa/maHw0anYGpktws10MTkF/?=
 =?us-ascii?Q?+oX35TtyRhpXLWBw+Imwf/uhorQd4i9tBxqmCPPfqCmifV/ooqBl8kANsEFr?=
 =?us-ascii?Q?zr0g4JSakJjpYT16azcmP4u731xBWPNQbfffM0dHC8c1AeEo+c7kJaV3ovAk?=
 =?us-ascii?Q?p5RHyiHypkOoPFn0cZ9lF/NhRg99Qcc=3D?=
X-Exchange-RoutingPolicyChecked: SJbQlHFj4tPq+YMGjf6uLQNwqmfyyf7OZAuF9RQFR+JAtqQTLc5ZfN2DwMt5aviw/dQHti1EhmtyUVCKomwhZ91Mk6vn254A3Sw2BwTX4Ve77RS92xxDiPf/gEIm27b2IfcWgsEuZHbxuGQl6XVQwgD35IvQWPLX8Tsw+/K/W5mxe66bR62bCTgKS2ybbDZdKx7E/H518sHVNxjxeu8jZCz9Iek6ONX99ojfK+D+pk3DDNaZ/jYBhquz6ldCB+qRmrD//YTrQBvXhKfFw0r6AL+Xs547ssUXC4yHpEWIdGk5ZWe6sGUIrL+ZYmYcZUpUjiuSl3qzLmWtAvbCDkrpqQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d79c95-d475-4827-0351-08de7f8ae6b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:26:08.6804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2s/K974qv3bZbd4tQb1wYaG7h4kuo7VNHqIcpx//fvcsQTg9dtbFJTKSkhm7csFbuddK2+jkncSoK29ETYpByhRiCe71QjlzLZzR8JIgZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzOSBTYWx0ZWRfX4ngLIZd5lPQ4
 kMOlwzQHpRGVjQAWInb8CxrGYsu9hkdBjsa5RXX1n+RQ82Y6xFkShpvSI7CCHORvFqEiu/5ewFv
 6ZMc1LYRyGAwnQfnZJyEBH1Osm/w7cO3QIs0meQsh1EhCIqwVxMay/ouof68rhzEAVJx4fHGAQR
 GzdWvx0Jp7j5Ch5nApjamfgeZppDUO0aa9198VJwS5oifNPqjQITdbOOLJcq6lAvp6blecqiFL7
 Lao/6T+z7UHVjHgf3Y8GFqKfE8sJ1RORg/vtgYSrQ84OESc9D8iprbb9NvxH90nWNfZ1TQAgikT
 9NJ2d3vqqTpOYBdQvSRk5YJ87NTf81AvF0zl1Xmf7mBG2c/CPzJ5G/A/gA/FYeK87YOm8F70UDV
 hcRLhsIBfMOrsQSLz2mbmuSaSd7K11TEuEpyAh4Wngkkd7qZBOR+Hx+lFO4mBCZiiAZRP9mc0pW
 TJ4ju4BftZOxg+wKo9g==
X-Proofpoint-GUID: oi5pGkcjEIXNarABlen9I9m4K-oAYgh0
X-Proofpoint-ORIG-GUID: oi5pGkcjEIXNarABlen9I9m4K-oAYgh0
X-Authority-Analysis: v=2.4 cv=OLkqHCaB c=1 sm=1 tr=0 ts=69b197a2 cx=c_pps
 a=s/l6Ps6BKnbfTvrvnp3tLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=uA7iVV4f9_HlATIxyLUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
ISA serial IRQ is low true, edge sensitive and shareable. This enables all 4
legacy serial ports to be used in Windows without conflict.

Tested on Windows 8.1 and Windows 11 with 4 instances of -serial on the command
line and copying data simultaneously across serial ports COM1/3 and COM2/4.
Note that with this series applied, if extra ISA serial ports are added to an
existing VM then it is necessary to go to Device Manager, select "Add legacy
hardware" from the "Action" menu, and then reboot the VM for the serial ports
to be detected correctly without Device Manager indicating a conflict.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

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


