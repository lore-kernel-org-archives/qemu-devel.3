Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9101CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHeT-0003ha-7S; Fri, 24 Oct 2025 09:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCHeR-0003gY-NL
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:16:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCHeN-0004MS-W5
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:16:13 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59O57fxn2479085; Fri, 24 Oct 2025 06:16:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ESVdm20KNNwPLC95EwngMah9gVCt7UjOVzVmpOUEo
 6M=; b=QrU72vfZUMfZ/2PdXc/qeF50KB74jSc7lhm3C0R8JzNfEj+FMqtdKkxJx
 E2SsIGAX8R+ICAnK0oxMFEyNycUrVzd/vdiyrVHEBXKNyLe+4UhPMC/u3D7uu7yI
 /BI6OJkwnJf2QVfJ8gvT3/9iPpkukO+eZ6hGyU5CsSWAGQnAvzVmb7fY3tPBBx+S
 W3KcEzG8F7dh5FzuJeG/lc41908gWIjE/Wbz0Ory2YU09tK5cjy9Y7YQCwbTW1+M
 8cMr+wS09noLPK36N6YjD4o84Us13zB07q5S9tKgpriuPT4zO6Wk9eSBcPN4U8iK
 X5jeKDICfJwDZgXoiMVrNWMbvdRFA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021126.outbound.protection.outlook.com [52.101.52.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a031h0tp4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 06:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nesid3ihLny2VWTbs4kTZYO/eVE2gnZon/0WlwPpUUyqhMzq/dAGLlvMerEom8TAHdHUZz/C+4WgEpmFg8ca1Ou96tI8G1wi2reRfdX97o6YPSDGsg8+ocNIFaJAyWzjB0e72Pws67/ojRI2GjC/zFtGBHbflir4IBeY4TDDY8c3Vgj322mMecEC04dG2nux2Y3W0OMlUVWLe5uGpcxGl58UTg7j4O/otYD1L3aiLXxExn82aUdIAYz3PRoaKJ1YRHU8pNcI9Vvcej620c2WwFub17RMmhqA2mBAFxcK6IAiZYaq6EwAoOpRgDxbH4ltZHeqqf/FKHuKuugkohb+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESVdm20KNNwPLC95EwngMah9gVCt7UjOVzVmpOUEo6M=;
 b=PmT/rfyVXAAnDvXI4Kjw8ITbsk1IjcCqqmEt3EIrTJfSt/Prb0dPYD5bwJjtTzmeaS6WZx0GrKiVsKom+kPvodfRczLy/77C5PnvR2uvkaKLzhL7uIItCU7lHeBEWpYgCu2/3tRSlXh0VnmusxlJiNt5iU6xrGVqXXp2XDm0gijSPhWqUj2IXQtkAJRrji5XTP7M4EZI8wf3cDIVBW4D9MBEUHkg7XMCFcMtuIzFXFT2lIa1oh8q50jgJCE9R5TeNsZyVRjBqYoYHAscmUdo/cAL4I0W4Mm8w35JyhNye0ixWLtzr8fpzQwr8JR3ycsBadM5/QSUuHudrHMe1q27gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESVdm20KNNwPLC95EwngMah9gVCt7UjOVzVmpOUEo6M=;
 b=MPDMp/Dotr/ZM4K0v5z2hUCSzjreLff7+KEYMgKs+H0hU47xqDbs8InOlo+Z+JI3GDUn4XJ1XP+Z2IREd2R/Nx4XNgDmOIhTCjT09O4wlqhcx9qARe0XJu4DujcAUiEpPz6/ZrHxDAJ3uEP7Kl1RTgQw37rAM9ik6ju5E8nwJJnkfWPbdkdfGLREQ0Y4olreavDzrqsN99HGFiSh+QQqiFOklR6hEt0+QMmNIMdKqfzy9VB7IyvagZbW/SxjpKwP1VcN8xAopPxrm7LWhgoo1Su6A3keYIge1js+/FTDnjPnhdwebiKt6pyA5fJArGrlaVXw2Elssx3P2azRP0sFVg==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by CY5PR02MB9015.namprd02.prod.outlook.com (2603:10b6:930:35::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:16:05 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:16:05 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v7 2/2] QIOChannelSocket: flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Date: Fri, 24 Oct 2025 13:15:43 +0000
Message-ID: <20251024131546.929499-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251024131546.929499-1-tejus.gk@nutanix.com>
References: <20251024131546.929499-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0121.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::10) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|CY5PR02MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f73bc44-43e4-436b-18ce-08de12ff7cd0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5QUmvBh8SvkETQANnh0QnsmxntY4au5WzrZisx3sfurrQwFscVp3qoB3bym2?=
 =?us-ascii?Q?NY5ovQyuOGEAmQwUIWD5Xqyaajuqzl+Q+ITaOZbVM9ZPF+siqo3gY4Qo0mER?=
 =?us-ascii?Q?NPrIkRNcu5DYtUJOsrYYxLbVqEHCTvCBmhGxdkwH8OU6NZZRc+bfpacKeH9+?=
 =?us-ascii?Q?Lx8dPFJSNerHMfvm5IVkVF+GvZF4tk2hi2EMbTd4cM0zELqxNhNeNSmasxjt?=
 =?us-ascii?Q?KwHhyHqFYUKwW7TIQfAmB2AYQ4qyJx8J6Sgarib4Imj6SlIAuaZFhjWwkvCC?=
 =?us-ascii?Q?J9BF7VGnjyJ88XfJ4THYfzPMoVY+49BbHW7IAACsSIf6m7beCMYOvBf0QCRz?=
 =?us-ascii?Q?/MbPDCzqxEnE/xza2JN0+W6kbJoUb4gAK3NcxE4j1sKKz5TZ6q3vVbEq+rKN?=
 =?us-ascii?Q?7EMY8f7SWfAKwvDSXPQIkkKDyXfWDKj4A+Pw6yX58HWswxfy/+yMtcTK4Bxs?=
 =?us-ascii?Q?8y4Ks5IPQwtrzx7Z2Uf0tN5+fuiU7dZMwp0Djr6aQzPCBmXj08UWp5suFym+?=
 =?us-ascii?Q?mohC8aRkzA/ACTfFbxP2qIMotx5/lxO4gj9R6LsJ3+9JiZrWnXj18Eg+CxaI?=
 =?us-ascii?Q?vzMrju9yEve/3HaQGdtb/0wE4Ifi0au5LLETm6e2d0tW1WzGbCdO+fTD3fFP?=
 =?us-ascii?Q?BLtr3//BWAfMKGCICJcIIdnk9Bx8LdbHelxT4IJc0v2pF8jKhJ8Kz0cjMq2K?=
 =?us-ascii?Q?4igjqOUgRdCd40yNBjKMjMe3RMYbwwt7Ugn4WwVqlUrkSZx0uoo0sSwfiZEk?=
 =?us-ascii?Q?tfTeP13QhwEoEASWx0lE97fOsHCI9SlmVhGQm6iun8aOiistiMmc4d1fvJCb?=
 =?us-ascii?Q?bwxdGpBYC+hd34Grs0GsjK6TYYpt7QtDD+ynY24igg0tqTAvGWKM/laVLJ9m?=
 =?us-ascii?Q?U2oBpfSUJFq5i1vWxq9FCs+wbHiWm8TpzCoqmOmFLWeRUZPstQk5op4efCWC?=
 =?us-ascii?Q?mrF/WutZOr0MvHTHGa5OS9kSUPijeFPU+9OV9cfEaZZEd+eyvk2YKhGt5CT/?=
 =?us-ascii?Q?izLGEwYmAKr49fbXNjVen4453csAztb/rcXimHGhqXqyP8FSUsQVZGMz91fW?=
 =?us-ascii?Q?Chw5Vcbxvubms+aewBd0dpQapVt/+lOIhFR2G9aByoK4KbVSUYchvtbBAlVR?=
 =?us-ascii?Q?KhUqZ531MufU/h+BGAYjcN8yRZEUNfDzE6FD3fFTIvTjDjVaatYOXuaWMBuK?=
 =?us-ascii?Q?m9zRrq7emfAKvmA0rMc/w9mcTU7sl/y0W1ve+4XcN4VpyHuB7VabfnbwPcQp?=
 =?us-ascii?Q?4WKuD4Q1/A3uLO2Jy05H5zMhFizOvYLwtemGbjXCdC1VAfupIRedcWhL7esf?=
 =?us-ascii?Q?J2dpOVkPx2h38IKr89tIhe0YVCdefwAA5HlL6PFZ/F3/CtWDDHsllv/TKvy1?=
 =?us-ascii?Q?AVSIqQ61pBSPOPXcUqdEjSDtXO7uXDyNF+G28dI38AIs5QGlS1zpm252/4AP?=
 =?us-ascii?Q?nSKzhl9YFfRWiRF5xmKgscDuCvAWD8hwii/azbOArh/tqMnUNsajRDnK4wxo?=
 =?us-ascii?Q?xBcGuheX7vntj1bCgSrtxbEt5NEwZ2KxFgTh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AzXUF5MmfnlGYOfyggHBPs4ryv5PPJGg7sMkmEvhmgXu1uyejcs/JMrrFD6G?=
 =?us-ascii?Q?VNN6wfmE10QdJc1FY147v2E4VfQm8dFL2PtlZFbsLs/ltQO7JCCyARFw/6If?=
 =?us-ascii?Q?QmIklO9pjDTUAkdOoBkn/kcBRn9A3wIltytgTFxyiUxTcJPwEccPlAoGEoOp?=
 =?us-ascii?Q?U1FB1xIoYWIhkJwDrqLP3SdEfKrXq9W2QvhXTQBS9lHJXyvKxCN0DaHbF6vH?=
 =?us-ascii?Q?ND64ppdIcRanfDmW/JGk/wDZrdZ9v1Bqybs8vNv/YCwP9z6gBbrwf2GRiqvA?=
 =?us-ascii?Q?LDJ6XQm/xV2SrsjLMFAKoBhSQUUmFFIFq583Bak1oyooG5r5JFOE7DMXkJGG?=
 =?us-ascii?Q?nPN+kirUwsLKG5vm8LW5zdGGClwBTGV5sklX84q0Ww4i5UdyCLUjqhGjbbYZ?=
 =?us-ascii?Q?RC5F1GJAExAhPtGuQUsXycnqmXXOVRYS1lifTGND40Jm3C9ErWrNe8tXuu/C?=
 =?us-ascii?Q?QKfnc7rlE9fkPaCkaZLe+IfUxwBfYJOXmTG3VFcWDcJy5hG8Kwo0aBdpls2L?=
 =?us-ascii?Q?duRlIN0pkko1OZJKVXq4Oe/rjErgvpHXyhMIESaPN3O00Qn2QigPep7EToyT?=
 =?us-ascii?Q?WBNseiFk9hNnC/PAlaZ2uq1593IL0uHWVNaTJXEHxOYg5LOlNVv9ORdLMbux?=
 =?us-ascii?Q?k59kUxbLvWwFKvpOsXj193/iWdsjGUYFgxbwOPjs1YExKKZ/OOx/+R4UBG92?=
 =?us-ascii?Q?Fxh3xThsxFlg9BugPcIKVcxKHklutT6t8V9mLWsQE8spE3cv6ZLwfG+HA6lU?=
 =?us-ascii?Q?Gxx79iuX64RrbsW/zma/rzfdNzPWeFY4Qp7GvixKJ9j4+1N2NuspelNv2xS9?=
 =?us-ascii?Q?cV1cAzqjJV1CN2tCSKfVUzvmOrOLLyfmvUDSbHPG3lAa4aXlLvD74jiFD1yn?=
 =?us-ascii?Q?nyN++ro2D/g5cwjjaYQroPhOssJruRc/Cl6kh8rwNfgxy7D/bDX7cnEJhvrv?=
 =?us-ascii?Q?0KmuiAh5dbXMmQU0UZP06qMRJn0BEB/FKjJf6rYqRhI2SaPW8SAaWWS13AGS?=
 =?us-ascii?Q?QqSn0jnElXJKxcR5kbtFJoCZWJ/FKr0Ta8ZFbDJrpEsThjMDT/5KCOdyOrQc?=
 =?us-ascii?Q?YsOeDGhHAKPxFO7gM3IigDA5Gfpd+3IL8Lwi/e+9aAoXOJOwA7VpgWbHcZQT?=
 =?us-ascii?Q?u87UyXRDgrc3ZOdGoEO3V/Zzcd1kJDn5gwo0LMcCaUpWHVlBYUBK2KnKn290?=
 =?us-ascii?Q?87xKo6FGXaTCskiZTCDajgDfhRFSJ+2X2rRdp4kNIobUjkHWxRgJjgNUzvde?=
 =?us-ascii?Q?6N4nBG9g8E3VMzm/AjiMNnQpeEtXxzbJwnvfSNf3P+g/PA93xfhnSfLZNCXh?=
 =?us-ascii?Q?I5F7ujPEup1tt9J+MPPuQ0/HicTQF94ge2hzzEWuZlgsgXNpxqrWJhoUIo2c?=
 =?us-ascii?Q?dPOtpU2mAnX5Fy21rhZ9vU2ObXtTZpYRkTEIh5CogsSfA6aNQPMBQ3wirYHV?=
 =?us-ascii?Q?fbGj1hn5LmjaVi6P9arqyQoKs7yToMGSTVQuUt8OpHuly0nRYIjmjEBgPa7d?=
 =?us-ascii?Q?yxCRGQqDObRIViZ5RanX2SNUg9MCjUkDbQ5Vv27iJR0rn5rGm6P/nikSy/Lf?=
 =?us-ascii?Q?ZtjHvqn86dzK9CkO+GweZWqzcifRPzyH+BWGUM3F1QWXc3jeMF9M30K+Lj+i?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f73bc44-43e4-436b-18ce-08de12ff7cd0
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:16:05.4823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLNAvMcxXXJAqCB8tAz9G+2TqKxrtFUmsU0dP74MwI2j5PheAsMPxoWaucBRr0ysIJjLu7lgOqgndCd7gRgAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9015
X-Authority-Analysis: v=2.4 cv=TOJIilla c=1 sm=1 tr=0 ts=68fb7c18 cx=c_pps
 a=2GFS+sGz/zNhX7meIfpAvQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=AbxLU1rV3dBqwqNtjxsA:9
X-Proofpoint-ORIG-GUID: fZVKrwY3HsmOJ0qgNNepBo4b2RMTLKMm
X-Proofpoint-GUID: fZVKrwY3HsmOJ0qgNNepBo4b2RMTLKMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDExOSBTYWx0ZWRfX2B3Lp5DoWRgw
 LO9CbathLrzRPjwGkU5EIUUpuwQ5uiia5OJRAQzQevCJ54+4ITlDYL12oPo7VP68W2mQLuejnj8
 wqgPW9v7dlz54fO3auhkFvdy0nMkndJ55uwhFV255S8VqBCQVkhky4r4LyC3/MceVsGbHsMHqMA
 9Dp5zgpFjYEkQLIu1GnBK5yQzcmj3JAat2tSqOgSdT9NXrZ5n/nU2EBWIh9JoryqUhCGUjVbXS2
 AhrF/0aTDhh65AHvk0m6WCjj3QGhdeeEjmakdNKonD/Wp1MgQIwqo+MkqaZHOkfvfVLTVa2zRYt
 U4Mf6XpXfFAtzdk4e/OlhULR4ayKsgv3G7mnX/iEXF5JHEcpgtaTrhMlKVs/I94oSOJrLbgv9g/
 ksR3A4vC78zPAvb9Iqqrf/dU2VGzwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

From: Manish Mishra <manish.mishra@nutanix.com>

The kernel allocates extra metadata SKBs in case of a zerocopy send,
eventually used for zerocopy's notification mechanism. This metadata
memory is accounted for in the OPTMEM limit. The kernel queues
completion notifications on the socket error queue and this error queue
is freed when userspace reads it.

Usually, in the case of in-order processing, the kernel will batch the
notifications and merge the metadata into a single SKB and free the
rest. As a result, it never exceeds the OPTMEM limit. However, if there
is any out-of-order processing or intermittent zerocopy failures, this
error chain can grow significantly, exhausting the OPTMEM limit. As a
result, all new sendmsg requests fail to allocate any new SKB, leading
to an ENOBUF error. Depending on the amount of data queued before the
flush (i.e., large live migration iterations), even large OPTMEM limits
are prone to failure.

To work around this, if we encounter an ENOBUF error with a zerocopy
sendmsg, flush the error queue and retry once more.

Co-authored-by: Manish Mishra <manish.mishra@nutanix.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel-socket.h |  5 +++
 io/channel-socket.c         | 80 ++++++++++++++++++++++++++++++-------
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 26319fa98b..fcfd489c6c 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -50,6 +50,11 @@ struct QIOChannelSocket {
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
     bool blocking;
+    /**
+     * This flag indicates whether any new data was successfully sent with
+     * zerocopy since the last qio_channel_socket_flush() call.
+     */
+    bool new_zero_copy_sent_success;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 8b30d5b7f7..08bcd5715d 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -37,6 +37,12 @@
 
 #define SOCKET_MAX_FDS 16
 
+#ifdef QEMU_MSG_ZEROCOPY
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp);
+#endif
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -66,6 +72,7 @@ qio_channel_socket_new(void)
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
     sioc->blocking = false;
+    sioc->new_zero_copy_sent_success = FALSE;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -618,6 +625,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     size_t fdsize = sizeof(int) * nfds;
     struct cmsghdr *cmsg;
     int sflags = 0;
+    bool blocking = sioc->blocking;
+    bool zerocopy_flushed_once = false;
 
     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
 
@@ -664,9 +673,24 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
             goto retry;
         case ENOBUFS:
             if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
-                error_setg_errno(errp, errno,
-                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
-                return -1;
+                /**
+                 * Socket error queueing may exhaust the OPTMEM limit. Try
+                 * flushing the error queue once.
+                 */
+                if (!zerocopy_flushed_once) {
+                    ret = qio_channel_socket_flush_internal(ioc, blocking,
+                                                            errp);
+                    if (ret < 0) {
+                        return -1;
+                    }
+                    zerocopy_flushed_once = TRUE;
+                    goto retry;
+                } else {
+                    error_setg_errno(errp, errno,
+                                     "Process can't lock enough memory for "
+                                     "using MSG_ZEROCOPY");
+                    return -1;
+                }
             }
             break;
         }
@@ -777,8 +801,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
 
 #ifdef QEMU_MSG_ZEROCOPY
-static int qio_channel_socket_flush(QIOChannel *ioc,
-                                    Error **errp)
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     struct msghdr msg = {};
@@ -786,7 +811,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     struct cmsghdr *cm;
     char control[CMSG_SPACE(sizeof(*serr))];
     int received;
-    int ret;
 
     if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
         return 0;
@@ -796,16 +820,25 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     msg.msg_controllen = sizeof(control);
     memset(control, 0, sizeof(control));
 
-    ret = 1;
-
     while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
         received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
         if (received < 0) {
             switch (errno) {
             case EAGAIN:
-                /* Nothing on errqueue, wait until something is available */
-                qio_channel_wait(ioc, G_IO_ERR);
-                continue;
+                if (block) {
+                    /*
+                     * Nothing on errqueue, wait until something is
+                     * available.
+                     *
+                     * Use G_IO_ERR instead of G_IO_IN since MSG_ERRQUEUE reads
+                     * are signaled via POLLERR, not POLLIN, as the kernel
+                     * sets POLLERR when zero-copy notificatons appear on the
+                     * socket error queue.
+                     */
+                    qio_channel_wait(ioc, G_IO_ERR);
+                    continue;
+                }
+                return 0;
             case EINTR:
                 continue;
             default:
@@ -843,13 +876,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
+        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
         if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
+            sioc->new_zero_copy_sent_success = TRUE;
         }
     }
 
-    return ret;
+    return 0;
+}
+
+static int qio_channel_socket_flush(QIOChannel *ioc,
+                                    Error **errp)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    int ret;
+
+    ret = qio_channel_socket_flush_internal(ioc, true, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (sioc->new_zero_copy_sent_success) {
+        sioc->new_zero_copy_sent_success = FALSE;
+        return 0;
+    }
+
+    return 1;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
-- 
2.43.7


