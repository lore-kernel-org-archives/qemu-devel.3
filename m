Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE791CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVQEF-00071D-LF; Fri, 05 Jun 2026 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wVQED-0006zC-OT; Fri, 05 Jun 2026 04:48:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wVQEC-0004M9-3M; Fri, 05 Jun 2026 04:48:33 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6556OdLW854749; Fri, 5 Jun 2026 01:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oC29DSXxja7+3YRMlCXqMeAH0MWszWIkfiQcbJrtY
 5I=; b=YxUxYS6zZMkeAz5X1B93bkSBbGtcNdbRBwAlmZKR8jcKsJq0boMPZ+7/f
 hG1SmraMy2eyj1mbY/lFXKlepaMq9cAWQF71T0DbYNDrueSvbG0MHlgtqwsohVJ4
 G0OghwpI0J9szxZlZrSxadjULdU2V3Np4yLQS1lRrUcCej2NtQ9CmwHADnQ0koYK
 vhnuAlO5DHkIl1KKpS4jWlsntBQTnQ34rdv/L6mNNsXTisO60Umw2t2AauomWOqC
 YKSg+Twce3ynYGQy3gtQV6utkVB5yPydqU0m2wA/42wvo+JbLb6fXZfQZxdPNCKI
 rELh/oIuNPQQ5mHGrZ+8cMh1t/TFw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021094.outbound.protection.outlook.com [40.107.208.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ejupdmnv4-13
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 01:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdI825SyvkMvezLhqfVxgF84fkQ9qP5Sy/j3BVZHSUSohdPNekyh4IhUSuErxYEz9a2426kpCRlirHJ2F8ITKMZFpjFY4pTsy3zqp3O07aLgvFkgvUitWzmFrzzhAc/fUFaioWXYZ1JI5qNr4Dyf7t8t7mDL/M1M5Ci7DcyoQDx7FVkhwE343Zvzm1Zmw1dT/YNo43X7Il381Riu9el8bg/4tvhhG7r/H9yTEkFkB1OPNLcCcx7VtQ+YjVPfILQ0N21gfFMVJm+wrxv/MzkJC7U9p1dtuqIswEWMztA5/3LEB5jbH5NRcA9SFukdJrgYpaHLftVnF4l+s+kC/9yRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC29DSXxja7+3YRMlCXqMeAH0MWszWIkfiQcbJrtY5I=;
 b=f49tp9j5bKEbrxo7FJftVhDZ/9XWRygEPTHs551Ovi0tUotOLFW+999PIw0jRz8PW5Zdej4SOt9qnSCdZkcDQBjhnX//MufJHqch2YcyrQshhRYGZjMg1ct4NdQ+sY0O6kFsPlVpU5eBe56srRwfJ9ZjlR0MphXqLuTfedwpPwHFuCRIGuSyox009eU2RquD6/wizHXVjk4ZuNnT7WLX7ghPwtgCK6vslouhQzQ2DLe1IiVQ1ZXibdu8s+S842wA+DhG7Tnx3eLsSDpB3+Q9V1yk9Y3xPmYNEa2CWI/A/A52Q1cvwXGAlCKHu3s5hwA/UQCk/QtcR3KvADpbjiXm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC29DSXxja7+3YRMlCXqMeAH0MWszWIkfiQcbJrtY5I=;
 b=yjsH7/c84Ut/rpxG1SlPtz/ALpah/uB4xNgQKXUnnorKsMKj/FeVkzP+bd8HikAJiskYXQz/BHAaaXOquxVf3WQO9CkMjj43IxQxchoyqg1qzoMOce6TGtfSdK3+RT2z9DZfTQi5WwC4H837/PyBnXyQ0KG3sHt0FQbZ0JNbWLVrUp3pYltXsFLWwoBksNK1ZonrMgs56WEEjWK5jbvkBQ9RDv4KNgXg9f+kDd9bUtU9nH/xo+BECOiBrnOCN1i/cklFyL2mYiAz8Bm4GyUrwigQb2fuIl/5tFeyuM6bdd8BVYCPjhBjCZDH8mMYQpcdlU+Sz1lN+37V7odszEWfhg==
Received: from PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17)
 by CO6PR02MB7812.namprd02.prod.outlook.com (2603:10b6:303:a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 08:43:14 +0000
Received: from PH0PR02MB7557.namprd02.prod.outlook.com
 ([fe80::4917:bc05:4373:6bef]) by PH0PR02MB7557.namprd02.prod.outlook.com
 ([fe80::4917:bc05:4373:6bef%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:43:14 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 Eric Auger <eric.auger@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Sebastian Ott <sebott@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jinqian Yang <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Khushit Shah <khushit.shah@nutanix.com>
Subject: [RFC PATCH v2 15/29] target/arm/kvm: handle DCZID_EL0 specially
Date: Fri,  5 Jun 2026 08:33:44 +0000
Message-ID: <20260605083358.1320563-16-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605083358.1320563-1-khushit.shah@nutanix.com>
References: <20260605083358.1320563-1-khushit.shah@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:510:324::18) To PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7557:EE_|CO6PR02MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2529dc18-9e6d-4aa0-29c3-08dec2de7b79
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z8S1y7DlpvKTMmJ5X1pWSVYXzTo8q0cAEqnDz7zI7hWH/d7HUBuwUXrB+yptrnAM8YfdZP38i/ZKx6utTdTJDXAjEg0/FIM+eE25j5qn1jS4MDYYhEVHlQJNMpswy75PAfHTVnDHFzMOM5u5hv+NlBZvl/CodasUcdCZt7n5/A6LExZM11eWAcQUOitjcHZhL+GE41DI9EmVXj8gOwE38PDlajFXAOcIqATtUvfklvRSzCtN259ra6Fk8kA3YGivGeXxVF9c26p6pZpwEfMSHrcl1Ygb4ew0xzYf65QzRKn9BdxK9awWi0Hi5+PFoARV/CoY8UAALCFrL1EGsHsbS1WjV/oq3rtBAKfGAcmZnOJubsKOosZtG7Hhv9DxlDUh0Kt8IworPc7gCA8b5+F3zc06Cg8IFZSbmap9qxtQtK8A8nzp7LQ8KvSA4h40A5FeipQ0ikpvt6Tsugq8BpD0If1+tFsJ99tEhHn5DUHmtbTPo4mLi0GDPvQK/oEa2R/xxy7ipQjxMDLT/XFARlh0UnIzDLjFLXZtAQajxylMbvZJhfPyVUOS13/Qv4ZB73job8gb2nF4iSe3INEh5NRXl2byY5/FjhHwcONrSeok1o7BnXdxra5qIXMzOzfjZsZF+FJhbAk/WLBXx+nnEVRviJODaAzs1F79ta0mI1GHmwvoZNP/Ouqga7GXOlCXKOF3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7557.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnqtGQOKNtvQ8oK4J1tdTiihI5UOfT8f0LMRmhfvkMo7n/irow5IEd4n+uW7?=
 =?us-ascii?Q?sCY8KNw5b1S/Tv94J8aC7zcL+UGFtGgjKmYuyfes2dJOMOFEm3u7S1sYNbwl?=
 =?us-ascii?Q?wL6TZV/AQDf8Px+mH9rq5laRq5bd/W9UwTcoCifUgMHcFWXmln3ALfinBj1Q?=
 =?us-ascii?Q?tLxhhYnAIwTXt+P3gIX8lGiGiJG2uokH9cR7maUV27N5YjroeZjbNM5E/k/3?=
 =?us-ascii?Q?yp61OD9FP2i16DRjPn2ahtr3A63/8vMJo5pSPIkv/Ocys2RkdKv5gASSTOhz?=
 =?us-ascii?Q?mqGL9tzl5eadeG3h9FZZ0Q38iEQAv++UTVh85gD+H1z/IbL1Pw/ynL2pW9os?=
 =?us-ascii?Q?nm3dQmgjJMh7j1nWnrTuZM+oS8AFoltkkSu/jaqoh/mawA6iHmx7xVAz8xDz?=
 =?us-ascii?Q?oHBAA9QkkglcKDkBD9U/fD694in6Gof/JQQrqYVNfy2SUGtmiVCZerNpEy/H?=
 =?us-ascii?Q?tN+xirSik+ixXnQUWvdgrJqvWo1hl1oK/dijDCuGbkxqf29d8ZgZSO8gSwAy?=
 =?us-ascii?Q?9SOzq8VWC0cYYTPj2G/sREUd+KqUvPPeG6/z1oF+GlfodLBcQO/W4+CsRdOi?=
 =?us-ascii?Q?quunsVsWw+J/hMKLp02ACMEWTwCL2jnX5O6tJpx19IxREtLik6V1a8OvVo1r?=
 =?us-ascii?Q?rauemuHfY0aF7daq1wW3MvSX2wnGe3DtfAuTVLbHZ3YI32ZgdL/atGyrTnM9?=
 =?us-ascii?Q?QgDUN+2OAJR/tvH6tb4LSK1+zqHWAHApZPQhfIoUYdWTuTA7uaDUh764ONEx?=
 =?us-ascii?Q?nxSYW70oCckSBj/I/iiebTlSnULYGMPuu9V6D3DjdO55VneTsRXJClos7br1?=
 =?us-ascii?Q?kUpSdJJErUqY8AcoPpUrNc3FQecMt0Rzo3BqdkZYQgfZ2Xxo2bPmLA8Sz5yz?=
 =?us-ascii?Q?f8SVz9Qmwu1AGNQKPRRrzwbESYNfWWAeHMGe3wf5RrKAzZUpmh4XH2fTbDcl?=
 =?us-ascii?Q?offwc6w5CnDUuv3NGuo57iiW2GvPuM5U7wRJBr/NL/L14llbQt5X3hSn/GQ0?=
 =?us-ascii?Q?H+cpmFkWh9jlB7oSjdVWHOJZa8WBDFiqU3UwX2rq+490A5WD6lqsN7hKqt4Y?=
 =?us-ascii?Q?wHdOM1qKkinZh643qTo8yssUN9NC0V+4IFmoSdcHENWGrVblAZ0v9ctLaq0t?=
 =?us-ascii?Q?RAgVfPI0ZxJoAJtPfd0VvyFm3wF2hOEXs/uuogRh5HtV8ibm+DGqVRX6C2P2?=
 =?us-ascii?Q?XOiP7ZxRjq3pkyeJpfIbuUTsFNpCKFpNTS86yEecN6M9Fno1xIjJMaSacN6N?=
 =?us-ascii?Q?5wZ54zglrUVQ8pFX29yJoyRFohlpaRs1oxPZ1Z8LaogLZihy/i0s0iVjYxgW?=
 =?us-ascii?Q?LNtk+4ltRWuJgnh9eKmDg/Ob56mK8KZjekh7EoXXq/LL5tinoZBiXXIVK/+r?=
 =?us-ascii?Q?3pI72Te8h4qmpnn3oE656LITPlNBG0Ci3plrjUhu0iY7GQF44vwzbaL/+V6C?=
 =?us-ascii?Q?H2b6Bq01lQkdcSRXziaR9oLM0wSCvegnDolgRsbvZWWL+MaxxjWFQVILAzn5?=
 =?us-ascii?Q?EHFEXutrak4mM+0pwGj3mujaY+JiHpuuD88sR88I6/OuAoxJswYrphygmh9I?=
 =?us-ascii?Q?tKjbWlqNymypu+khObipytDI56Azgkc+uRYs4IH3WxYsQuJTDo+vTgVpAKPi?=
 =?us-ascii?Q?yL3wj5I7Ti5/8kjaPCoJUOxlN+KRaUSUB5ew19gawprSW3w5fuijj/tFC1k+?=
 =?us-ascii?Q?8JXfID2m2o2x6SF1d/3dwZcOB3/XqRfYO7aQqH6zH8Uxf8DiLOHKJVppjT1r?=
 =?us-ascii?Q?3MQYHxSAZ1QmenfMJjPp3gVREYr5Zzo=3D?=
X-Exchange-RoutingPolicyChecked: J22SrjKZwszNeghgC0cmeykMko0bIMXDV/kfAK2mXFVVHtisNuBdRcY881YOMqH8m7bHXNIfkx+/BvgOhRPM/H71AgsZCs2D3b4pM9qmD4M+kK6qcHQRHyZG12J+RetQOz/UKbXCMP2iKFIydArUpsdGPyFkxb1qXYsCr/2iGGxBmMiZ/Lj3ragYG1GN+tYqLYGGyUp54onCYyLvKV45KOxNxOtRAr1UxLOeSAMIAxqtW/zfCbfs1D/C63XT6aLKIBMRzG/3GOLruc7HJbupPCD/am57N7AQrclnqX9T7IKdvbTMqhALBLCbbjAbvH9yKLXVtur+kAtcdPjNRGNFkQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2529dc18-9e6d-4aa0-29c3-08dec2de7b79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7557.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:43:14.4906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCvbvHFac2KpjRICs84UeFrdDObql+DezhegCnU9wx2PDqmJ8tS1kiPxqnE9WlVWMMm8sNNGUZN8+B1zwJ2yZkLahozPZzTZ94cg7WaP1Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7812
X-Proofpoint-ORIG-GUID: tpKRwOaUesNjFYYoXCN0CY9H4lXrLe0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA4MyBTYWx0ZWRfX4Ih8jsf4r/kn
 wl3PueC4JUKOOzdJpICn4b87BmbuiSY77wHZ0Y9kHi4UXv8pQ5GY6AtvETSMlXXHf8CBTZDFPTe
 phOBbLJR8YX69w06STsIlK3SqfbxhIZCBr/DLdtBsmD56PHjer+lfnMqsKM8+LVBFfzH75h0xiR
 FQmP9YG2bojf4rmQ1n4XdS1JKGDHd/E9QF3yyy1kAHoQr+evkfj3j83fz4/UbW0lnxPOD9yRJGJ
 AmLihYkwFvQ3UwOslKz8GI9uPyICXR6GSitsngJQj55iB2kTa0xjruUsDXE03ZCOdx/XJ8RgwhW
 j6FRmjDU5wlYhBkwNoqIga7VHIR8VSSkwe216jO7AV6WL2WYiNcREwRv29v5fimdLxk0RLJoiVh
 DZsMWZ7YgRFL5fTI7YCmlr5gpXO5Lk/21IFizqy6xbEfEyQdkVjCC/83pn4hmAhR8eumTiUCDtM
 U7eBqkNNu6g7UOtdn2g==
X-Proofpoint-GUID: tpKRwOaUesNjFYYoXCN0CY9H4lXrLe0E
X-Authority-Analysis: v=2.4 cv=dYmwG3Xe c=1 sm=1 tr=0 ts=6a228c26 cx=c_pps
 a=Dy1/g0x6RHl9kMZQX3cATQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=3X8xa_ANkg3eZRcqrlcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=khushit.shah@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

DCZID_EL0 is not trapped by KVM and guest reads raw host values.
Read the host value directly and populate it in  ahcf->isar.idreg.

Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
 target/arm/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 46d5532061..a12fa7571f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -245,6 +245,18 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     uint64_t *reg;
     int ret;
 
+    /*
+     * DCZID_EL0 is not in KVM's sys_reg_descs[], so
+     * KVM_GET_ONE_REG will fail. Read it directly from
+     * hardware since KVM doesn't trap guest reads of it.
+     */
+    if (index == DCZID_EL0_IDX) {
+        uint64_t val;
+        asm volatile("mrs %0, DCZID_EL0" : "=r" (val));
+        ahcf->isar.idregs[index] = val;
+        return 0;
+    }
+
     reg = &ahcf->isar.idregs[index];
     ret = read_sys_reg64(fd, reg,
                          idregs_sysreg_to_kvm_reg(id_register_sysreg[index]));
-- 
2.52.0


