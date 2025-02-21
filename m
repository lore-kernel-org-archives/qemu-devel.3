Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DC7C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 09:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlPbq-0005Xk-EO; Fri, 21 Feb 2025 04:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tlPbo-0005Wu-VS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:46:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tlPbm-0001xs-Pg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:46:12 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L7kDHu023997;
 Fri, 21 Feb 2025 01:46:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=4ZINqiI0zR2Mb
 Z/aIacYCmm/gXDW4fHqa47BnwWsBGo=; b=P+M8JfUUmowbZMsf4AEXAEUkZTOLF
 4NbRyigrl4iMgL7IwF14Sl7JH76/DVx7NjQnBs3MRvYqADJCRdVGUcc4mWkI//9r
 JOjfM4FEHBowMCJTNafm9XsDr7oY225TrQs4dQPr/KGXCoYyQ4xTWOo/zVm5MFXh
 hntvY0X7kY9ioCskCdwPzNgAeTBTOZVpL7RiEQwdG5TxbY9+qNcVHMSnnezcQBWw
 0140Fdwiu61Ol4QXHKiAXNdwAp/hebcBOWBAWdVHcK9sxfRc5xoWAFAKH8lUs39F
 8aIamdgVlm8CzmrD6VVnlCmgxPs0YFLXM/ll8kXapOJyQLNaEvGRmrA1Q==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bayj5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 01:46:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH5Ua/hZKD/UM1j8tbGbHseL567R2UaNhdlH/hwWbiuq2rwNDE3RoQbLs72GvhCEhMRMpEQdvf2B/Ydrgy5u1BhkgajiAt3heJePeMLw2wqwqC3t6I4lySiWk/9OrWnWJ4HeGdmp0sN6gR9kkyE0KFVv+O3t6epAvXl+RodbT+zY+vvNz0Rv+nTB9F6igELFw0cXep3XwOCubSFuyZ9tW6lfeG35OamAMDBbunxcpu03jRhFVDlSWJHS5L3IMu4sUzcxebM8J5fiEatiuLfV0eSa6VBcdTLUiypWlEKo/oDNnCWWojcLgBzmMAQ4xGs+MRvmIh3VM6I9Fid2sCZLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZINqiI0zR2MbZ/aIacYCmm/gXDW4fHqa47BnwWsBGo=;
 b=xIsefdTJBxxJ4dBuwzmFDdQJB/ZKoDo44PJ712/sZfCd1k2+IIXyyuojSkh4NdJFQFYdY6yhnXBeHkXCRIvbty6JAz0fs2F5910gkcsVwEyUuZt9bJS/HLDiZidYmxQ49C2UCvR8tOIL0lSVr3VTOMcjfVqApvYkLpgLVHUxM23trzIbj/ItKYMAJhWYAz7JscZgIHzVpshlBH+p3zf6l5jwGdNKXwPBe9uTClJLtPeRCkoXVCXSR6lpYVbvo7u8IRd6ul46zJrxyKtF7zT4iqGaEdC3CQNfnNjC1JSSgSNeu10W5zfMrxgo6l54TQyi8NUBOhZa+qELH1rCUMB2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZINqiI0zR2MbZ/aIacYCmm/gXDW4fHqa47BnwWsBGo=;
 b=XzvIX4tNzS3rJNEjQuKu6qygDABMs1LundPVF3PDge1a95Jdm6sP4eipEXVm+nCHfCI34KOpPELxXPNQb+OaVqhA51urO7lSOV8gtWqzTMDmAHjVhy6s27Af6Dr8XgwZ5KsJuKJFq1WdgsQmluOU6XjmQw8GvWVccbqYtUfuEVovh+hkmTZOxmeJLciOr/caMzm45rw+jqhW1Ln3/RnDwXPmIT0azneRCTn/cxebsv2Qar24NOd6VzBEfzW6kU39DWXprmgZ+U4ovSqI8wnIRqPXeMr5Qa1MvE2qi47ewLI3vZZnRHs+JyqHFRUYxAQ8SQLa3PSyoI/GUdR42Pz+KQ==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by LV8PR02MB10237.namprd02.prod.outlook.com (2603:10b6:408:203::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 09:46:03 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%7]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:46:03 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: qemu-devel@nongnu.org
Cc: leobras@redhat.com, peterx@redhat.com, berrange@redhat.com,
 Manish Mishra <manish.mishra@nutanix.com>
Subject: [PATCH] QIOChannelSocket: Flush zerocopy socket error queue on ENOBUF
 failure for sendmsg
Date: Fri, 21 Feb 2025 04:44:48 -0500
Message-ID: <20250221094448.206845-1-manish.mishra@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|LV8PR02MB10237:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaadcf6-c6c8-40e9-a8c7-08dd525c8e34
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?670/RRJ0Uj5S0ES6UYjQ4AhHwYPiffInZMtRMhRcCvjgh8i3V0rbdBU7n74c?=
 =?us-ascii?Q?BbUNqse0k00RUwoM1vNY8FjPiBBGybqWpu8tkb9t0hnHSXLu9Iq4UkBJ7yJm?=
 =?us-ascii?Q?HEmSsjzLW71w9spSUpNDnUsaCZC72Q6jwHqqqsQETOW4srYbqQhztIa9WMJg?=
 =?us-ascii?Q?e7v1lJAwM0rFT/36vmS9zZyLPproaom2l8tYntlVyHX48gjtbltu/VUdlyr8?=
 =?us-ascii?Q?ArR/aV3S0LrtGJ0sGKqatz6/4Uv+rwmcxLA3XYPrpuYHS6uLcB76gJnwkBNr?=
 =?us-ascii?Q?3t/OpFvlz5FxeUP2EBWXat6jR2OAb4N9kJQJiQLzKZlaut5NkZGSsUfrN32w?=
 =?us-ascii?Q?1XQQhYm0bUvK046ymFtqxd6b0UbX1xPo6seBlBp9a71lkwVGNEipKvizfvaI?=
 =?us-ascii?Q?UyYdTHhVWilZG3IHrWMfS2RjA5BDYHABF2vyMhtHCuTxnSI5/26n3HnXmxbX?=
 =?us-ascii?Q?2euIt8/1upNIne77T3d1RjJ6nJVuuLiqpX6MBYjS0oxDIDRyX53fH5BQsHc+?=
 =?us-ascii?Q?JZJgjI0nwJXEYsdg2LcO/OrtBTHe+9sizMVaOi+At4FrWSh7XnNV7KBSaUj/?=
 =?us-ascii?Q?jwMzW2VaRp+3BeJfHXKJrD2bVP2Yu8KfB+JvQbHPX2g/fF+Awz/O4WOehIaj?=
 =?us-ascii?Q?6DpQF4od5r8oQwuV8UO3dcGX5pKAuXuONwJN/4Na7RGmcygSt6lLHN7UxGZS?=
 =?us-ascii?Q?omIyKbsMqrH/TVb5GBMwLxjyn56pIADReYIhLlaOAwGDwhwDn6pz0PwJ7D+u?=
 =?us-ascii?Q?ZZY0mrJ01A3e03y7UOGMPzo0RZOPG6sA1Sp854LGV/yJro91wa3tVqQlgTIZ?=
 =?us-ascii?Q?hupKM0hW1SiU0bmO68p6Pse/iQ8nKmAoUrmU+aqLI0WJ+f4fjgACxV/VlLdl?=
 =?us-ascii?Q?OjuQDdtjacbH7/oqdpq0zAlGFrk3Al7K2WmHcSp0hFnTo6ULzHeDMV/Xo7ip?=
 =?us-ascii?Q?LtQ7i+ozx6sypJ87acURM6cTqv4v/31kOZPHO55/MhzQq6w135jhlhAsCkTu?=
 =?us-ascii?Q?Dt+J1rZOpMgqfW2w4R4pPnPVX+l8HCioFLA3SKlQ9/RygHHsNrwDh0D8jJLn?=
 =?us-ascii?Q?c/lKgpOvkRfoOcqxHrfivbBm/eS8BIMFYW78IRWkv1R5l4DDvHDEHChk/LB9?=
 =?us-ascii?Q?dtdy8Vcmnaf1wdL9jsO17mPeuB8xvj4/nJswPLddl+StihFlFxp6j0jTsXPR?=
 =?us-ascii?Q?LRycqN4hb5DT3IcKQywSFVv9nL8iX4W9pPjkSOJh1emKGT0ZsI6OQyG9LC0q?=
 =?us-ascii?Q?gJZciBRcqxa0txnqJR7ifnsr1EZQyZqni/+fbenGNtu0dy+iW9r3K+lwIIzV?=
 =?us-ascii?Q?oB/PgV0rPV0HiXQMmeOBosddu9Lc+Q2eL5wS+T6qZKiAjr1dC99+V3CJq4xd?=
 =?us-ascii?Q?8y5fhF3Jdrv78bv+b8oxd1iezq7HW7sx7pXy3nnzl9sg+qng2TqDRvbzi3sP?=
 =?us-ascii?Q?LQQUV9dfhKEVCZeDj221mj19mfqLIMqk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKMkWFF/BPCGU/46zwvIudv0lzvMfa8qhqWLoNr+ngT0s5QCuccTyZvIO/gR?=
 =?us-ascii?Q?D2sVCeaco2qieVg5erbWTWd4AeJLOwLnhu0mMR9xz6+CrDLxrFBcRmPWotm4?=
 =?us-ascii?Q?cSzmbk1ouaydFcs7gm8BEvFXdE+xkPWBsCfoadsCtY0U+CxV5w8XEFHamPd9?=
 =?us-ascii?Q?6xTg9hPYQfWzzbeA+khPMD92uGJVQnKpLC/9YwXuX1jVf2BvuxicA3EIECtQ?=
 =?us-ascii?Q?+WHXcoAj2TDApxFnV8LTLqp4WtELZxC6GqAWd/issnd64Zzlkzeaz5q0kdew?=
 =?us-ascii?Q?lQEzMOaMnIJmD6nQ+fA/6CQp41gUFTHDMGscuABs7Lth8VGuZlmoKfIVXNu8?=
 =?us-ascii?Q?dfOfL1cRlV3NGizvIIdMiJvIJV+ztsNj5r1+jf5OVSDmLfm4XSGy/lL/JftV?=
 =?us-ascii?Q?1pRRI05uJM9FEibTCrgispgy2ZahnkbhISSNaezMRvIyMwymIOIZ1edZSfsR?=
 =?us-ascii?Q?3HfE852XRvwCMTCriwIEIT055ICecL1A4qsOZz5J2g4whCDUDzgDS5OWy+//?=
 =?us-ascii?Q?7ZxmaKnv26PK5Zs0HnB7DicPGr3AIDdm0iP2OKQIhoxAqn2uFP8j9nudC1i/?=
 =?us-ascii?Q?qDlNcgTBpj20AGaRliZ4z+K9sbMf/euEoCdDj5RTVAvXbiTmjLyuoRHL0SM6?=
 =?us-ascii?Q?J3oAuewHsy6LZcAHkmu8jwQMXH8kOWtuuiVpD75pdVKUW59aX8CiQB+bHe0e?=
 =?us-ascii?Q?YAx+SWEgHKvE+3TJtxTIxRaLxld4dtFqBvAc8x7hE4oy/k1zTu6opfwzHI78?=
 =?us-ascii?Q?B29tPMhVaT3AcL67WhkbWXvKLtV43FqvNSLY0Gf7AkWg0AejDbrWyHt3tAJu?=
 =?us-ascii?Q?Tp2VWpbceP8RY7Ywi8t6GRDfp3TaYJw+0GSkS3xgVCz6WBumbSHn3QaaVqhP?=
 =?us-ascii?Q?XDEwFtoaDZ+gK84z/7UDyA1BQhHlDoWjWpNfrGDsmy6qtrizeL+ksmlcXzjr?=
 =?us-ascii?Q?VGCqKbRXNR04N1GYf4Ry4//4It8pKVV4lTVtPuSFNdKjoa+x2DlisdL1tH6q?=
 =?us-ascii?Q?KPnTXGWQp7y8aJqLF/p05vPoKawyO0K7lcjpFqtq+NNYZKwCTphtKcv0gvMM?=
 =?us-ascii?Q?s6WySjVZ8PiyBMSLs8PDMIYoiVCvMEnqr9B8LXfNsnEDpu0hsPfEUs5WFu9L?=
 =?us-ascii?Q?NLPHfSuiHkGwgUcp2p3GtR45m83gDqbxyHT59+IB+pxTUAWrQUM4O90UVzu/?=
 =?us-ascii?Q?ORpRr2C1VckuTsd8FBni6jkf5r3/hlvAq23jV/Kaxx/w1WtdIPmAWt3IBzZ2?=
 =?us-ascii?Q?hbmZSW02tMXcx1aUvUVlU75LX3MmHYEcvVjAOTjPz2vAE9KVopolFkaI+xXj?=
 =?us-ascii?Q?cb+4MFGHfOBzjbYTFDBQWnkXnS0/pkrowls6aRs/CxJ/a3z+nojtr3DhlSCL?=
 =?us-ascii?Q?OMh2jmJeCMz5v0jv5lhDLy9bYK0gS7Nzdjsdsi7rw4hIO1cbepfZWy/YWJi1?=
 =?us-ascii?Q?8mEp3cWMERoYtXD+j85AwIBRMGAO/ApGFr2GJ84odylwv7e8/rb3fnF0f7ly?=
 =?us-ascii?Q?Xc1BdIhJXOYv8zr607ZOzRvgKc+RRzfEw2Pcqlg8HVueEJUWewcOvu1ByIIW?=
 =?us-ascii?Q?gY7u3gNNLR5VAyWkRLaOwr2k8ZrhUJBYl6MZulUktzkt2NNYwVQfnjZGWTRk?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaadcf6-c6c8-40e9-a8c7-08dd525c8e34
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:46:03.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwXaizmKPd66Bo8UNXzQKZZAKzjqE1n8pUgIlF7eb6xAOIZUVwJvRceUD0F6FE5bqLQwvXFcRtrP1CfebsnFCu31+qNwQAoSEOH0/PMj4z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10237
X-Proofpoint-GUID: h2u_0_OWbYwlJ6jh8kD1-QUy1yhqoxos
X-Proofpoint-ORIG-GUID: h2u_0_OWbYwlJ6jh8kD1-QUy1yhqoxos
X-Authority-Analysis: v=2.4 cv=d58PyQjE c=1 sm=1 tr=0 ts=67b84b5d cx=c_pps
 a=CmjB6Nkc3E8pi8fe8piFzA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=5xcTamFqhijbIdraz6IA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

We allocate extra metadata SKBs in case of zerocopy send. This metadata memory
is accounted for in the OPTMEM limit. If there is any error with sending
zerocopy data or if zerocopy was skipped, these metadata SKBs are queued in the
socket error queue. This error queue is freed when userspace reads it.

Usually, if there are continuous failures, we merge the metadata into a single
SKB and free another one. However, if there is any out-of-order processing or
an intermittent zerocopy failures, this error chain can grow significantly,
exhausting the OPTMEM limit. As a result, all new sendmsg requests fail to
allocate any new SKB, leading to an ENOBUF error.

To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
we flush the error queue and retry once more.

Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
---
 include/io/channel-socket.h |  1 +
 io/channel-socket.c         | 52 ++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index ab15577d38..6cfc66eb5b 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    bool new_zero_copy_sent_success;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..c7f576290f 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -37,6 +37,11 @@
 
 #define SOCKET_MAX_FDS 16
 
+#ifdef QEMU_MSG_ZEROCOPY
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             Error **errp);
+#endif
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -65,6 +70,7 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->new_zero_copy_sent_success = FALSE;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     size_t fdsize = sizeof(int) * nfds;
     struct cmsghdr *cmsg;
     int sflags = 0;
+    bool zero_copy_flush_pending = TRUE;
 
     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
 
@@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
             goto retry;
         case ENOBUFS:
             if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
-                error_setg_errno(errp, errno,
-                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
-                return -1;
+                if (zero_copy_flush_pending) {
+                    ret = qio_channel_socket_flush_internal(ioc, errp);
+                    if (ret < 0) {
+                        error_setg_errno(errp, errno,
+                                         "Zerocopy flush failed");
+                        return -1;
+                    }
+                    zero_copy_flush_pending = FALSE;
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
@@ -725,8 +744,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
 
 #ifdef QEMU_MSG_ZEROCOPY
-static int qio_channel_socket_flush(QIOChannel *ioc,
-                                    Error **errp)
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     struct msghdr msg = {};
@@ -791,15 +810,34 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
+        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
         if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
+            sioc->new_zero_copy_sent_success = TRUE;
         }
     }
 
     return ret;
 }
 
+static int qio_channel_socket_flush(QIOChannel *ioc,
+                                    Error **errp)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    int ret;
+
+    ret = qio_channel_socket_flush_internal(ioc, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (sioc->new_zero_copy_sent_success) {
+        sioc->new_zero_copy_sent_success = FALSE;
+        ret = 0;
+    }
+
+    return ret;
+}
+
 #endif /* QEMU_MSG_ZEROCOPY */
 
 static int
-- 
2.43.0


