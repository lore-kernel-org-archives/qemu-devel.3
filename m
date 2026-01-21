Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE79C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVxW-0006vh-IZ; Wed, 21 Jan 2026 06:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viVxT-0006Zv-7F
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:01:08 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viVxQ-0008K1-U8
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:01:06 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60LAPGdW1013980; Wed, 21 Jan 2026 03:01:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=uwJDPBkLHvZdX
 KuYt4RRj/GmVkZR2GS0GjZT/lK5t7Q=; b=Rk9lFzyAsFu3zU7vvb/R14J75l/3+
 lv+9E+YikGd9xfxrxj3QzTHsewHe/bUjfqwZUKne98LUMA8FPY1+cZs/BKnXvCL/
 J7r5qaIzedSa6xvcFGQvoK5af+nIIC61WWvX5MhbeOAioTDwyKhK3yW1Lgq7kun5
 HDEfWuH3jz4lBOt+PtFUTGnSn3nxsZ4dIF2WYbpE++r9y5Hekk+9EVSQXDjU4nSM
 /tg9ePE/MLfSUUnglUm98Xg3Px2lWdkbBXUbqN/Gok5DlQNvaRdWpA40TbknBRU5
 6KcibFhAVTR+ZQA0XHSj7ztGI9i8wPjcp2xMNizU9JX1YCIW9npjl53IA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020131.outbound.protection.outlook.com
 [52.101.193.131])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4btddgadj6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 03:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjvzhqcY/3RG/o9FJHwljhfAu7EiwqVSko+9XzplvbXTRQ9eeHcWOVaaiM8N0BOvElWj6Op//5FJHZLGy5gRgt8VoFeoS+J8Lheo0O/a/dIwtqwJrSO84wtwvG0PfelMZ/OPgA75S2AxK7L0BTbUnvWKvbYzNe+omjLE/NZCvQFqhgXm6Pa1tA2pZpxvQw/dBGRuSYaEEfiKWBl1oG20ephSdMQD/2eC3UCuRJauo1zaIPMPRfIjDNb57q0O95OCVnvImc7XpUyJxmy8SgfOn/i1UKdEcmIJw791tSBRXZhv+wXgtUFr5g4NzjWo4pRSUDi/A9Yf0GJBWusTBkNg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwJDPBkLHvZdXKuYt4RRj/GmVkZR2GS0GjZT/lK5t7Q=;
 b=sBCSbWbhYO/tau9o9UoVJiL9mblr4KlXEon4rOxxIQZ2JTITgOEH5G2JWaNX+VFFoj6xuEW+Oa+MKCicWXIDlUc4xLdoeqADFRckEVL+AAtpiDGTqJIazrPmWNqva/+Y2RLExJujbYvRnWoR0VYbOaW1oCYoaNaxpf+HvuDaPnKZPzp6uWuTZxOs+BwxCPwwQyVA8F7Gsv6vH0sjPtN92pzpz1l0RLcVHByMj67iTDmElauNjc01QFaOG3pB8tq3UdSH3hdpcOOwKxvWP/X9PlyEb/97BaYTDayUa7S4QBQnfTKsFShlAV4Bq0Pw8yrrDY7XonK6sXjRS+nZAmCEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwJDPBkLHvZdXKuYt4RRj/GmVkZR2GS0GjZT/lK5t7Q=;
 b=jwLol5ccGBP/OriKwcUf/vX+PvwYFgpDECs8G1pN9HMNQxNaPlYS6KX6h63jw+MulMdzHgHLu9ykKALBlIa0gYyzL+QzCwl3bkV20or9FDyvrUmokpKNlchDkLPvIIYe9/wD90GhZtSgxRKBfwtM+PrXcuU5RodNyWPaofHnCvFGx7WpraZ3xRSvS+ZGl6sJGU/a/1DoTIU1Mg+N08fxCPeB0jT0igb+obFhtH5vBo9Tf/2MFb7IWtTIgfu3VeMQsAT10/HDMJoUK4MxjigAk9/eTbj/Bs/6HIB63CTii7x2m+rYflOSiKfkEfo5uV2Up1+sN3fXthG14FemXvefFA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9939.namprd02.prod.outlook.com (2603:10b6:610:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:00:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:00:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: clg@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] vfio-user: trivial VFIOProxy flags fix 
Date: Wed, 21 Jan 2026 10:59:44 +0000
Message-ID: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0418.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d40b77e-6087-412f-bb82-08de58dc5b48
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zio3iTO57zHkGhb0xPyxz7eqH/ywQWbZkYtK31TocgPfmMMfCkKxRVSHj3hm?=
 =?us-ascii?Q?9KKCruiZfKIMa3fpobtGTYfk/kNZFGIYI2Pmzv7FSxaDXQwhNT7RIRTLemy7?=
 =?us-ascii?Q?1d7Xuunr6tGlF08wAKsXXEulkFcIdH1Hf1Ug+aphr4kmZMXHyjP1XKP+0u09?=
 =?us-ascii?Q?qx3GcVjKZQG7FAgqOo+s7nXiyEBwQ2GetiCY+wCFWrV7SdoZDeikDIKzNbPD?=
 =?us-ascii?Q?UvCF6Zc95cDJ/yZ95BemKYlfkYkg95hbq8tRApJptzxARENOL+JbQZXM63U2?=
 =?us-ascii?Q?+GJclS0gxqS+ei2vZRyVule6yIq7+RdPxFo/Ydt2TlIC6oAotdUOGnI/seUI?=
 =?us-ascii?Q?nkGOs5th8kfDFwVTnrIq33BnUy4xcCNYfo0JCDpIg9BoqZbFSMAz1kIXSLEU?=
 =?us-ascii?Q?jHO/jfcAItVCcm5bbuu61YyyvCRCy67UPHKw6TdefStUfuAffOpi/3nQCyGm?=
 =?us-ascii?Q?Av2ybdcloZ2Ddi2WZ/LcswCEJ3cfoIZAwFDBNQ1kg9fczjrqqZBrvdtlTuYm?=
 =?us-ascii?Q?ej31Yaxg8y7wgq8AcvQlJvl14Bo7u0NI3WKmeE/75RKJrvQxN3kycyo9O0H1?=
 =?us-ascii?Q?N0pNQ6RQN3BsTkwdBgBnQA+JfDISNH6+LnH/IDA5Ep6rM61VaQ4M6NHNftkP?=
 =?us-ascii?Q?GPJ9TtkJGpp/lNeeMMK//3u8aTVPnFa+osvvRgF5nmNnbNyTkK4QZM7UDQkB?=
 =?us-ascii?Q?wsMlFFTnv0OpDa0r8Klp7afa2J86orBCZMBRSuVu+YOdN3uBR7FAX+fQg3zf?=
 =?us-ascii?Q?a6RwfKYTNG7K2wnGAu4tMWTACyzS/olgGNj6q1AOfYQozk0XmdY/YnDhFBN5?=
 =?us-ascii?Q?yPsuINgocLbFVABz300eF7aEXklkzlamVdG20GfE9vwcuiGePwpzq4DXiluZ?=
 =?us-ascii?Q?l3DPrSNPCt6ArqQK+t267sjxPzjouu4UL4FXEgmIWmewkffDhGp4TwivL6QD?=
 =?us-ascii?Q?spyU+yu+09jKbSJFY/wJwyItwnqBUJ1xyksqhaw1H8F/ZfxH4IKFmFXDbUDV?=
 =?us-ascii?Q?FY9Aqsg2/0eWbT35tJ35sBs8xqRmEMZdnVm8MauFlp5EUdcVd6reBy07ZRrM?=
 =?us-ascii?Q?MuZIH/akM+A1aB5H2OBonpftuXzg8COOVTdfvtc5H5YcY6kvekTCbj+OSCOn?=
 =?us-ascii?Q?JjRGZ/RhI+siN2/AjqmxBerMyDUJLhT6I6WsOqQPd0lnc3v0DzHHF4OkheUa?=
 =?us-ascii?Q?mA/xn85aANXRnqCrHsLZCcvzeYJtySXuRPlNlzZQNkglVRBCKU37XQX9rVTc?=
 =?us-ascii?Q?DepLgSSrQgYkgN528CNK8WMW8Ks52PMZCJrfEfmJ3umepv+QS4DPZxom47xV?=
 =?us-ascii?Q?B75d5lbyCwJk7uUjxLHoKtQQWRny2kDz97fQkLZiSzklKaJJ0q2b+3rCQ8G2?=
 =?us-ascii?Q?W0wcJnndmYXtIGicUT8DVOV8Ym+WXbfJ/R9tQFNxV4hWpVpkzkNOGVD6ZC+f?=
 =?us-ascii?Q?LHgPRi0P8QhW6fEP0YtSMHbCT9Q1wLPJLitJxXc9Z1X2c1m8giWz+flZv9A8?=
 =?us-ascii?Q?6lqMujwdD3/xQ8g4eaJS/qLtKq9A1kYX95EUcYq3ia0AsYeEHySuTYktU12T?=
 =?us-ascii?Q?WCN1/mNY0XXR6Ux2Gv8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pu1srNwS2Y+aO+H4whvfV5uA2f7eGgEI9nMsNLqOUPc65WL8UOBb4uXL0BYg?=
 =?us-ascii?Q?gfL3Q2LMprPC+eTDcdLDOZZjjdMnXyElQwGkOI4kVldnWqImeMxVabSkaYlN?=
 =?us-ascii?Q?xkGWpx7FH7EI1bMgP1DGJO2hfINsartnDDYRbkMVJuyWVbUO8A7ROgwozxdP?=
 =?us-ascii?Q?7px9aGhRifFE84q486LJILJcroXC0IbMRoOcRAXzM47iCgLAZkJA7GKwiW6Y?=
 =?us-ascii?Q?1xQPmL+mUuZrv52mBsccMPPGfOgFErM7oVbwTGuThjTjyRJX6dzQc8BiqOcr?=
 =?us-ascii?Q?p+NfcZ8WkWg0HtFTch8DCpnj/NRj4FRM8XkdYjLH2MNvZS8EkU5+44yX4wlq?=
 =?us-ascii?Q?5G5J97COy96Di4xXTt2NQ0KZeA3HXnvCyTy7G2xXHD6yYqCQAUsSdljffVSP?=
 =?us-ascii?Q?RTq00dz4bZaYWdU9kOzptHaWkCwDfoNfIoBTb7xHueA933Bn43dB12ZXpzRp?=
 =?us-ascii?Q?6wjK2XNPK8VpdHVvJv7jnh6sA9S2fZ5ar4kYMWbkthTGxtjYhjhKSUps+yiQ?=
 =?us-ascii?Q?jfBQWIJ1kEZOuEsDh9m0FsCJLMSMPm61fcU+IhuDQRvjc+nvafzQi3nGE98T?=
 =?us-ascii?Q?heAY0JjeitiP2kZJc6eTQF4md9NI+YM1B2n0Y3UaqMi6Bl7xmO9hGfoS4ory?=
 =?us-ascii?Q?J04bQmMR261r+AFPGYrWDXKiErkxbVHAD+Ed3ECu1RmhEBIrGtltl2T06bJk?=
 =?us-ascii?Q?46n0F4S11bZNhUsxmaM2gSrzEEGXKckPij+Tg5NqPVnGm315dmOAkL3hSfZ4?=
 =?us-ascii?Q?gryKXIcAx0d+8s7uDdT4fs7KO0KPOWh3c+fFSXOvvlwqcn5dRx6yw+y+hcg5?=
 =?us-ascii?Q?PsnSJcBga4Q1idhQ2vM0VxQuYhUEw8oNOFP9C/E1zaskxTmlANAV0wB67T8c?=
 =?us-ascii?Q?bVcW9uBtGQEb9KEcE4cWd/60kJGPC0b8+aKJZlLyUkO/gSt1y4YkbpsYPvkA?=
 =?us-ascii?Q?2S7FZTIqHLDCLF/ErWrcvHYQC/CoxOUvpfLllqyIulU2x5h/icd8l12oSaFS?=
 =?us-ascii?Q?6PL6QuE2B/6pmNDN5h+Kxu3lgVQkKxfFBbB97V9XTqPaxK/v05aLqb914lKH?=
 =?us-ascii?Q?vyJtpCJbPljYX7UdowsG1gXDIP0N43DuyOHjKdcwDXBMPbN+AtW/lHInbSq4?=
 =?us-ascii?Q?Q7GbkfaivDQD2XjvXqqSh5bO/oyB/uzCQD75bzXLUvXbHSVDsK6P+uUMnv14?=
 =?us-ascii?Q?8tmgFR2j4qthYRYn3CS9O4NBzD8WYiRjCKR088vmO2S5n24mB5h1uSyuoK7D?=
 =?us-ascii?Q?G/4ybnwGFgzwHBnPXtQ+MXsX+zLc17u8Hi9cqwfMLhympqRhiRNdbJAtx4il?=
 =?us-ascii?Q?Z4kCk+VCWEWmR1pyBaOfOEL7BCxVNoiXXiwteMRd6jO897PSQ68fcTGOBnP+?=
 =?us-ascii?Q?twAKwb8KwGtjTdPaPruSaDvZ4MwY/Xmw2WpMvGo4stfSZ6P4kI7ZS4mxuZY+?=
 =?us-ascii?Q?r0/cF0VPnmZ6Sm9ysZkPWzYOVIJBco/euDZxlLLCwyAxuD5cIPenbaPuZdEE?=
 =?us-ascii?Q?qehfQdd9Txn1COa5lTo0hlPW3EOn+G4nqrH8Y1mM25ZHPaOIp+dcJTaIk07O?=
 =?us-ascii?Q?DSvyF+IUAZvefLcu8RV5AsiFShKJ3zJDhgBQ0qImWpsrH4d3P90Dug26D8wp?=
 =?us-ascii?Q?eLhrjKviw6eWtLAWXmmf64y5vMZT3EGJJWlyG7cMT5lgRnKuSLb+NZJt4XUM?=
 =?us-ascii?Q?K6sXHTlY2sOxuMaOPaG0OHHrUUa4ylDGDMxv72PT2n3vhNMNVqAerDu3liEH?=
 =?us-ascii?Q?xG9AYMkE1R3y+aqOKfwJsPiM8D6QPgw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d40b77e-6087-412f-bb82-08de58dc5b48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:00:58.2125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkIZ0+ssjW8klrL7SgCZdOZT1jVK4kavwrhL2lV5LbHzK4Q53Xs4L4Z/YyN04HhUBF8bswXky4rRnicyG+TfdMUtG65FdUqKmMycy0XSsoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9939
X-Proofpoint-GUID: gJs-jApqjKZ4NeWy5TG4L4TWAPj7JOeP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5MiBTYWx0ZWRfX+pDrD6zU6Ec1
 Y4gwBX5f3r9P9sT4Hc2vyZwpLPwUm0ip4iVIk2JK7aVJeV+eE4M8IImPRfgpsKEeHGdldVVyayP
 CwDP8vGQFrujzv3tn24LHpZ6va9cs9Cawd+cMIfJuBPuTigHzgSrROT8K2rcHZA09cSD89di4lL
 Sz7yTSakeBOiKz/S4p1ki0K3DG5frgq78BFSAUDc2hx9KX/9VAU621ouBAVlj6J15oVxGMbX+XV
 5ZEBhnkrXFfa7U58jxAMOEJl/W9pXN7L+0Mbbq7lKpDp2pgxEwOAHTQeA9pjqFM3JjRUZzLpaF4
 ayvLt2nE2YEC5TCIk4kjOTX0uES/45lsyXsnj0EoLMn4+Plh0wCM3x9xBqowc9HKAw1gaGEau3b
 AYuJqQDXsrtSZoMZsztFixbIx18OZODmQuA3pKWvm0S3BfTnVj8uC2tNFYS9QY6gNkNaACKeJA+
 PhpXPJyQaU/7vk0OUbA==
X-Authority-Analysis: v=2.4 cv=K7Yv3iWI c=1 sm=1 tr=0 ts=6970b1ec cx=c_pps
 a=fJr/hEtSlrU4iGGAQVkyRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=C5VM5Z-0FkL5M2lzUDgA:9
X-Proofpoint-ORIG-GUID: gJs-jApqjKZ4NeWy5TG4L4TWAPj7JOeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This series contains a couple of trivial fixes for the VFIOProxy flags
found whilst rebasing some internal patches.

The first patch in the series fixes the incorrect value of the
VFIO_PROXY_USE_MULTI constant, whilst the second patch updates the
constants to use the BIT() macro (also removing a gap in the bit
numbering) to help prevent similar errors from occurring in future.

Note that the VFIOProxy flags are internal to QEMU and not included in
the migration stream so there are no visible effects from the bit
renumbering.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Mark Cave-Ayland (2):
  vfio-user: fix VFIO_PROXY_USE_MULTI constant value
  vfio-user: update VFIOProxy flag constants to use the BIT() macro

 hw/vfio-user/proxy.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


