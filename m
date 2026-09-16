Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0D5C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nB5-0002jn-W0; Wed, 16 Sep 2026 06:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8l-0001AH-TL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8j-000324-70
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:23 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8P5He767662; Wed, 16 Sep 2026 03:45:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=X2tdt+OFRJu3/CyARXQCgURgSsSHaKXcsV/f/DeQL
 C0=; b=FJppL52EIWlx1gPC8DqzjanmQIgsEPl9hlX3JwrrSN+nZZpBuKjLN0rtZ
 v/AMwbYWOgeTcuS7NniskUEf5CjwxWtMfPxNEUPnZ+dY9F+3oXCVAPY1/hd6hvP8
 96lZPPPS4a2kTf9IKv3sPSlP5twGoerKxoPJ5JMNLadZR0fue7f78PyAnceVgEqd
 dO7vLbzynpi0aNobRDPRjQFwsAfCp0w361JiI5U393JhGS0E3Y6AtVAznRc3wdeQ
 Zn4KTYBGCACuDccgBIvV31PJ39Qg1VMVGMvaizQ2l/BEiItWjC6uRa+4yxckuHL5
 u9fgag4WPveWjZuW/l3jYgYUmSQwg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021107.outbound.protection.outlook.com [40.107.208.107])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqdhm9r5r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQO/vaaCAqSpCRa5TMHFZf3YKzFNFehxiKbdPwxjBTbLl/V/cFc+/Qx0bJwrYJyJJmiOW31ZOkwoCkXNA1+FM7TKR9FG5CbLSCH+WCKuMvJmC0QrOeTQ2MDy+dI0HOb/ij0dLYaKD4rZH7dROW5b49nY+Q7ORU8clIh8Np94OssZOJskatSnfunTvzftfynHeVLsN3WQi/IeH+Tkw7M2o/RSZyZQS7wvaJdAf1heywv9vC4fWbpNdUO6HfYLv/vABSfRgtd1kyTErSJKtRbT0Zr+vm38Rx74UA6GLqju+rw6OCtJxiKHv8GrTDkSb7rqgGO6gMkJk1l0VGoV8te3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2tdt+OFRJu3/CyARXQCgURgSsSHaKXcsV/f/DeQLC0=;
 b=cQaKTYEhGgOZ1SqIq+WdWBq6mKADQf7ao/hmCduzmj/PsJ1j0ehKOKxiEFNG7F+/EQ2zJ+/ceu796+WdMdp7dmCWzIWOV20v7zwydRTXrdqVS5BGwDkExO/5ljQMrik5AK9Fs55KqJGFMhRGuSIEZT52g9ntWWpC1H5CjgXplyz3d17aJx7yG2JQMrc1R6aM3kka7axN3H33nSUR6JoMb5JG/BbgBjVoWZxfGyCzp9yNGTk+kQidLpUn30t4/tJnySVZDY4tXPYIkz6+OGXI+wY27YF6McPT9lPCgWosCML+O+XePibmdBqvDQsmR65dHt18+zrQzHVrrXMPXcPy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2tdt+OFRJu3/CyARXQCgURgSsSHaKXcsV/f/DeQLC0=;
 b=uoFqTH1U5oXo5A1RSkyi/QlT2h2AqcKvfaXUP7k29HmoIkh47IsbUuD7wfkdh4txW7qrV1CDfiU/2fQDEZZ7zSRbmVztN1DeCK+ZDPu/TC5d75uOp8GRwqAgivEz8RbfJPsWJDLkgzKGo+ICG5+mgh0rJUp5qJwOG9J02AyEww2RnjMHCIy1iBGOnitjv6mMDcSUBT6l0J7BFPHQaxzEC7gs46BpCRVmg3og4m2hjumG3wirZZeVqUscOv4EPIkQVwxvbQznzhxpHZ077hhL0uzIND5+QGMd5ZGx72UvR3A9TSXovbmZjrRTeHBgf49zljU6Orv+OUHQYemvVjVOEg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 10/22] i8259_common.c: convert to use DEFINE_TYPES() macro
Date: Wed, 16 Sep 2026 11:43:38 +0100
Message-ID: <20260916104435.600211-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f611f48-a192-4198-e6ba-08df13df9720
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: R0FmaNe43d6KeEPyWoMoYIszH/snIJx9M/Csyg8m0MaXtyT49xiWYhxgkuwT9aWYixham5jSf7PEytPe+9Wa5Vs1zxV6ZAvvB3nJmoC8MC29D0c48zozGPtFRGcNibAxZijhcOeCe6l5mrHXVgHicFlDkT1XsveWPKl6RrpOJx6mKjOqax5kd176mDD6Z4qclcpIgylDZ5O3nV7kRTTVEbJ6fFN3CXk17RH1FLDsdYMhCOg7Ly8GdPzTOalX1i10z490u7Vz5+XvA+JTTatTBwRuvSg3n2QWJ5KAMCVbiLUCevbibZizZUKb/4uUDXtYen06UlteFR7PLW09IrudestWJZ1cMhbsEvNbAmjw2XGJUKVUeJaL7fFuExn3Npe7WLuV++bT/B/ves2zk+wpE7xBOZpzHWJVyHC61bGbFvsZ7ADMCaHJAqNpZINWuThm7v81XsI4JSRxf8RmrFUoLUq0iqx1gKo/T3kqwm93acbunD8Zkj/CN9AOAn/kJHIV/3nMPD1pwG81m97Flm9xrgUpzBlEVQq+zQO9mmYQakTxK9qUruG71k4GjBfAiW52FJCEdCT/nUQ8hUaqmF77bUEJeuTFj1UilZxrum+8TO9/gM0NvQuqr8HUs+lm5oqSnxQXalmIV6BBdgbO1EuJ8738aRHNCdGAnQOJUcAoIdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUEfJ8oa7buYc7bX+Aq4HAea77L2DFzkyMM9xzxI3SE5VDGyAq7FgTvmPRXQ?=
 =?us-ascii?Q?bIIZOZyc87Sy67BenoKoub9hIb4Y83OCQOTTh6ufVWun3Rr5c3HMeJbH3MBN?=
 =?us-ascii?Q?zckjLyekwsLki7cHN2KsiMYk4b+4ZtgSR/bNFhfeAdoWH06o7QpwfdDeVdzf?=
 =?us-ascii?Q?ppSj1UQammdXqGM0IboqC78GGHMYVYavI5vmEDB+y3tMg6k2YPU0ZbTIN28B?=
 =?us-ascii?Q?6ycqDyOoHvGzxWaIXHWOO1lJb0M/t+fRovWwLJU2e3EIRHh3ekGyU0YAhbCH?=
 =?us-ascii?Q?lFkcEpQvg5q6XwJ46KxqWcPowndNw8d7Y9QZKyZDkbMi9v2GZVxZRnikLwuI?=
 =?us-ascii?Q?BCsyBucutoL9s+8rjmIwikB6aaOlJhjrCplfX6QJAjngzIc2EwojIK7CKo2b?=
 =?us-ascii?Q?95TwKu0xr6Hf+UkR7i7TKbMS0/E3cWS7cSup5qY/wDqV25EFtiZdek2MmBOu?=
 =?us-ascii?Q?ApFfubvsS6sokmL1hvrAWeGy/VZRhseQ0ylp4V0dIDdHPhZcrTwxh2E6ndMc?=
 =?us-ascii?Q?n9UMV9lDOJfT1Tl+yQzeqFNC7CdnqDdmpR1Y+PdzpvwWRALbhcHxNCO8ZUkx?=
 =?us-ascii?Q?CPzplAakFGoUcadVLcFs+6WeEHTbIh8BtlEh6qE+AX7SMWq4n55prwXReVIw?=
 =?us-ascii?Q?sfHM57WqKqrC9Z9GCk263x0cT04lxTXyRwYGSJtL/97BG/5JSkoEpI0qPfJd?=
 =?us-ascii?Q?NRAVnjfnyam3M5yh+P35YT++z8SQVoJI0p26RrPugNyfKmLna5JRLm+f7EV5?=
 =?us-ascii?Q?lA6dk8bZDnPsMt1xdi/FSJKJy6huHEQI3FEKh4aICaXqzYe7Cv2ZGJwz9FJ1?=
 =?us-ascii?Q?U3T4tPW33/yfvAmuR/qmaUAVrkBn6GrjZOaQCR0CY8oWdYcgjgYirLMcrBAF?=
 =?us-ascii?Q?m+aTo/1ifhPHCq1yAZRJvgChLF+26TyZEgs0ZI/Lgv7RjY3kxNKoe8TufVT7?=
 =?us-ascii?Q?PN0X0k4j6mbXEUGj2BRkDeAHY+BdJE964EztRz7Ecw+qe8B0T8clXkk7kPSO?=
 =?us-ascii?Q?xi37YaUVbRtqkuPLvR/t6FuKvbF81fEWJGyqtUrKR2lXDksx2mVTnK1i6i59?=
 =?us-ascii?Q?pzrvH7zS/rBJWcQ4msYqL7URyJmU/6NkHjFgdu/CXV8R028WUIRh8DjybPIF?=
 =?us-ascii?Q?HQevVFWzLaKoSV1ULhq108+R2s/dCwf6OPXzKWFkiLuZl5tzQO+uneHQ5/DA?=
 =?us-ascii?Q?CefOPfBGtlIUc77fByGYxVXbbMSvNC1sh3GEoWyHtihe7nVPpBLRYQsFTQaa?=
 =?us-ascii?Q?fQztoNmW1vzHY4Slt6+wgVj3As5bwta+18zJRtLpiZ+jhgw4D11BMBJPUmlY?=
 =?us-ascii?Q?JapW7x6Mb4JWYgl4ENAFWZaMpDB9NE8XJobBBe6lmj6CRX5loI4SqTce1lWd?=
 =?us-ascii?Q?zUPFxaHJoN8K88b4Kp0Md+LHIMSAUrxk7JNKRrlqCkjMOD2xmFFDhxCu8uJW?=
 =?us-ascii?Q?ml21pRnUnVGmUYe+jec2Y9gFx/NDFNlE8n8Wbf//M55EqvXwNIPka9tNLBxY?=
 =?us-ascii?Q?a6lP/4F+8fshQHJhjMmUM5FTWa4v7w/bbyIo+AJCkPXswuruNFstPphM5/6m?=
 =?us-ascii?Q?LsLg6kQFICmcWTMeX/33146/Kb7gh/8moTX9q4ayRA6IyGyyJLs6tNnXlDE6?=
 =?us-ascii?Q?Y9x4Guzr/ChUHxu9LTz7Eg2THp/5GkIehVm+YyupmkyJ0Qr/e7364op/8vv1?=
 =?us-ascii?Q?uGUnBuUcuRi25Jym0kIQAqLW+wOSChml0oLizDHVU0RmVvNon1pp77PBQj66?=
 =?us-ascii?Q?5J+/UHSWYebhCUfvYOeoZoqagQT4IlE=3D?=
X-Exchange-RoutingPolicyChecked: LfgLXvB5EuUvkgLgq1kDx03FgihHEJ/2/XmuX+qaABZB02gWcNbr72HXt36B7ZMba7bnBqtx2MpKV0imENdrZfuYgPalKzpg849VTmUoASLLyJP/NnLZlwL+sLi6cZ/OuF++0tzXvp2p8GnvFL8ip4rRtA8TEljBzLqTqeqRpwNPW2Hy+yvsbsiDrdj2A8bs2WGu4F2BcS/MiL037qQi5LJ1KWzDs6XkSPyPP8Hr479hmX70/KbZKef7kRNi8qJM5QCjQzK9AWxAe2GWFApWwLldIa6RP2NMgiO0uPwjACyCHo3S0jhj3vgouC64d3tlDHx2RTFQeR+RLTADDKC43g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f611f48-a192-4198-e6ba-08df13df9720
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:14.4800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sjoA53h4b1DnOmHcSZW4k3XCzGj8Hah80RHfhBXxMunwbrLNlluxnfeFOMIQQOUP+UwoRI3dahr+2pquHFhXGJGjyinDRW5x3KUFgKVJl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-GUID: RqA5faqyttuuwWO5UZprhGJV3WeZmooD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXxLl8jwUk2/z6
 TkpY4bnv6IvMjJxZnH7OtGieAKfLW3E5050ZyJqeKrBulpP5BzO7MXPtU++4PHvVU5dT72knMXa
 WEw5HvakiOs1Q8ovbXi94ZjrPOnR91Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX7ngutfmFB9nI
 NA3vlYrG7YyVXE7uvbh83FTbLKmYmzuIplzdIPVcDT9ozd4k3l68yz7p2GsNo1nWscumXB5hH2i
 7Z2JT5ZdIMPMvN91LNmZuBeKcuOF/q5fMq7JoP1jYgrFDxfS5xIuU++jhFEchzdd+0vzvzASwdQ
 jgWe33YFZQK04AgrLi5j93ruECEiUFBbIZ4WGIiWMc49Ju57Vt3dkY6BXHh6uevLJj3tVq8Tw/I
 M6vx6dU+8WEZtF4lB2TKV7n/o6FXfBSK3WADWBcTKahbnIk0G/TnydmK3X16R/SMv/bU1hxbCM5
 DX9L0ylZVTublXe3Jyoy2Uqa3CahVr5i+J4qLPjZuT4muZ1pMGjOmF9Ae5lNbhwDg++kOWkfkGe
 02XRXsN87QgeiCu3ifl0ySUbaYi0LtG+GbtziQTDbtZrBleoNQopfXypAGm4vE4+DwA3KsNsD9m
 jKkX63SQGzPGh+Ad7pQ==
X-Authority-Analysis: v=2.4 cv=IfkSymqa c=1 sm=1 tr=0 ts=6aaa733b cx=c_pps
 a=WvTO7h1a7pp8pZEQxufCPQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=bPck6Z4TT5Um9jj7BtEA:9
X-Proofpoint-ORIG-GUID: RqA5faqyttuuwWO5UZprhGJV3WeZmooD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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
---
 hw/intc/i8259_common.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index e03bbb9a8c..ec229a0b5d 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -220,22 +220,19 @@ static void i8259_common_class_init(ObjectClass *klass, const void *data)
     ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo i8259_common_type = {
-    .name = TYPE_I8259_COMMON,
-    .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(I8259CommonState),
-    .class_size = sizeof(I8259CommonClass),
-    .class_init = i8259_common_class_init,
-    .abstract = true,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { }
+static const TypeInfo i8259_common_type_infos[] = {
+    {
+        .name = TYPE_I8259_COMMON,
+        .parent = TYPE_ISA_DEVICE,
+        .instance_size = sizeof(I8259CommonState),
+        .class_size = sizeof(I8259CommonClass),
+        .class_init = i8259_common_class_init,
+        .abstract = true,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
-static void i8259_common_register_types(void)
-{
-    type_register_static(&i8259_common_type);
-}
-
-type_init(i8259_common_register_types)
+DEFINE_TYPES(i8259_common_type_infos)
-- 
2.43.0


