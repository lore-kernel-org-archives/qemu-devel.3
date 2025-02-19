Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC90DC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOA-0003Fa-7d; Wed, 19 Feb 2025 09:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklO6-0003F0-Lz; Wed, 19 Feb 2025 09:49:22 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklO3-00078V-D6; Wed, 19 Feb 2025 09:49:22 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBCgBV022471;
 Wed, 19 Feb 2025 06:49:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=8uo5R/cIGBks/
 bqwpAt1FDuJ/kJj6ns8wnHjWMG7PjQ=; b=pNjfxvFvq5cqTo+45hepDLdNw+DpX
 27biX0ZsaXzDYNur0YS131ScMjgMVFw4yfeNPTSbgIZ28Ok2B8+mfY2L8p8yRRei
 eRScAEp6/3+KBvCpSpMqVZ2QqH+Cejy3O9SjZlWfTraY0roAIx595+87bse0iwLh
 DwF2afeO/lDdD6eH+2f3VrHB2kH4R7KIkrGJoudkyK/NmweM1/zWzurYu7SUwJVW
 dmSeIWhFTrRRQrY01ia3kaU3Qfeyw/jkv+i+Qv1t8IABw7MHOoMQFiDgcnPAhXbz
 9inSQKlOak3RAS4FMPv3mE0szwFhHnDQN9lo5eJdN6thD0YKXYHhGL1Ew==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4b9hy2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJLCL+SuyfefrFJ9IHqtne88brBYBmLEabBpnjNUA9hcHRdCY+jqhzyqlKe0y8I8yP7CgirYKq18YpOw0X6S2g1iyfP9jcyt1W/6nYdr1SUNh0KahQww1neKLOK+BW3QQj3FcdVA5B6vz9DBKG//SB56xwXYud0GkNJLObgN9ozZydqSiRLwHZZCj4jebh4NyNNRXujDYw11jTuD/+F2ie02OmFMe4k/GlsJWGq7/vOdQJClnP1iNQBW3Dk/iSt7ocgIZFwhgOkWDKCH2Bxezfg5f4cPK1LnGKkNYvdYH4U9vNrRkF5tK2T5ACVhlGM4X31vT8pL3ad8sc29gvKFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uo5R/cIGBks/bqwpAt1FDuJ/kJj6ns8wnHjWMG7PjQ=;
 b=S/dHyC2uaBtM7pab+l7FZMZEmYW9E9uadLKhcXvo5JLrwoyvaSW0LTjvgsp7Ui3a7W+1zBBzGGxfeOy7UAgeYpA4RaP2igx6ZuVbjwNVAd0Obi/RvsyCCt9kpZM//gPbdESm9AR6h3XgLcNDNqVsm5lS+rBrZ8U0k/kkWbR0F9BpxPG9Ig+KR7e6PXcabe53ZJwcN/NKaa8zp/eSQU1MrdshYb+1KAIUfAIIV79660is9xVcDFm9EnZ1AsMqlR64gWEv2I25rT6UUkZNBRhDKXftS2Oy//gfjXDax6uKK57hGLTVa++F85EAJTmZF4kLC78mJTX4Qi483t1jDXK85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uo5R/cIGBks/bqwpAt1FDuJ/kJj6ns8wnHjWMG7PjQ=;
 b=q1FKeJOfkQccPV9c1F4IdcNdLHBCCmk7NXAJ0yeD3RGMr4DACyn5pcvy5I0JUv/DAtYS7EmAcoqXn4WK4cRFuSsHs2xaI2WNhga/y21JAEkBtSOpiRsUUthvE+tksDFRLihqxwArCG6M2Os1OGslV1NN/awrclqVGDMNNH4vDgi6zrGIJkK/FSkvvxLsM0mmWZiuXiXOzh1crPNEEgFoofYfwTXhKZVE3YRdBZzTXvBcd0NnFvqRu/MuBM78a0CwiksPyYq4zdOmgtcK1LP3SnimGgb5dY9vkdAvFa87kPbw6X4UyKjOnZt1XOIc9YJnONVSFeyD/GEp7JXs16fQpw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:11 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 00/28] vfio-user client
Date: Wed, 19 Feb 2025 15:48:30 +0100
Message-Id: <20250219144858.266455-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b251dae-6a7f-45e8-ddfa-08dd50f4924a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xxam5TENSYxJOBc2sNSzD/AXlLT6NfPFZciYGwA0phFdj626vMIEGfXCBq16?=
 =?us-ascii?Q?fkmYqllwfartPSK9BZ/thykhm1l295cCNCIxhLdyygO/zm8Z0LJAYWKcu73/?=
 =?us-ascii?Q?FEJzIHG3aNsFCHimvqn+kZmKrfAZEnSKKhbks5jxmvCwyp2ne78LXHMDymnj?=
 =?us-ascii?Q?PEcvOQBDNtwAJ26bItUGf4uGt4Y7QN3DY7dftp0cPaqpac4ojb7LFIxFk2N6?=
 =?us-ascii?Q?Ks1ge3+hGambSN1SXac8prAnd3WIe3FV0csVzz3mYZCfL1XIvHEH8us5QOH9?=
 =?us-ascii?Q?jNce4IYOam88uNzYZGVuCIMfDTLswHVtOgdgACbq0vsT/MeF29iRfLopbE5q?=
 =?us-ascii?Q?Lz9V2l6KIsycU1+NST3gWRu7CH5FKu4F7Ef2IcR0/2Nerh6dBxfDGe3iDBV/?=
 =?us-ascii?Q?4dk8EXWwNyi2wMKfAwCjFXUdvWH+uhChFnQBny+/23tM5EjI7jGExIWAF+Oo?=
 =?us-ascii?Q?gm143ltKsyKzC4Qqde2Px23tgLkZ6GnXMpgR8UT+34WvAh7SKWDZw7Gyd81Z?=
 =?us-ascii?Q?tDK0CAVzoDwe/42iErfDfWd6/8GhirVGr83OhB45kaw0HMKQcXbZPSw94bdH?=
 =?us-ascii?Q?qNhi0NIAp0VDDya5z4byy+k9lx/DfHfyu4RHSzz95NTrXDV8kbP8EU4qpi83?=
 =?us-ascii?Q?REYa3WfY+4Q0Gkw5/YWBOSE4+3YMS5Xs817WbtNCWe9dDk6urEQryAn37y+w?=
 =?us-ascii?Q?V6+TXcIDGZWL1rxmk/C7fhD81RUNqb5jgr99uj/KFVVBlVtB425G1fuXLkkh?=
 =?us-ascii?Q?ipTUfP9b3W2b0a3LG8RU6DP5DouxOxMHliXiobwcRiGwSzM2oFlG40zHbBrJ?=
 =?us-ascii?Q?3MRDGl1uTf8g7f2WJTdvG6bN2V8nkfKUTHeXkNGbNJB6w759cXtPKWjNbwZJ?=
 =?us-ascii?Q?UgOKzX0PcpV+9CQZjCf4eznIcsOYT5sxBhqYGm2kqkyOnm7LvtolxRHNMUTK?=
 =?us-ascii?Q?Sz1F/MJ/E2crBEXYLZiA5NK3x1llwxhecp//ZjbOFKulMdBxnsYcq07aejzo?=
 =?us-ascii?Q?SdzaRNrx2a5YkNj1vyQ5PPWUy8vUgMEzW/FRvq5shdyinHNV4B7/j4/Fl6Xq?=
 =?us-ascii?Q?N5Z0Wo/qog1IScLwUKJKulLigmBT9UNJw/U0Aucq7oD3UkloyRFtJ7rbUecV?=
 =?us-ascii?Q?lRCGSNIBq6fwJTj4Q+1fAHLfryBdm4eqh6JIaUpC4BX83q3+9CKNWx2ltLL7?=
 =?us-ascii?Q?kR6PYgHipLJ0SqT+8F75vpPC3/5yn/r4Vc7kpqNdOCycAw9KwYjXskxlOp9r?=
 =?us-ascii?Q?38BoQMcqUNbKT7xXaYnXtE2TZye08EIV8rHmqb/0pccJpSmiValCWTp03Juv?=
 =?us-ascii?Q?u/MbwYkc7zhvN5fvlPL4ddQjfBGHLP8l3ChPPXdTfOmflsbXQDMXD/V3Oqtz?=
 =?us-ascii?Q?HtrlabvRdLkmKlhTqfwqNCdPuBD7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kopV4Lj7UJJoIQ/ddTezZvSm8P7uq+iOgreqJ8BFerjJb4XhREIJYysHK4cH?=
 =?us-ascii?Q?XZngFKu7KiMkVPrUhiDd9z2ynBlnXmfRCHdnUCu5qfvHNkhTtuhcXD3L8PpP?=
 =?us-ascii?Q?XgnWauN9Rhr8slYwzcgg/jhcddmwhATf7NUbysthQgxwFK6JChv9vGVAjfAC?=
 =?us-ascii?Q?0LVN8GU46vBg6KfXzvoWuWwhoOmmMZQEZopjjRoVNFbS7TycbvYOMQobHxWz?=
 =?us-ascii?Q?Bji64ZvkgCOvpfZgsMzJw6yFRFhIpGzZmx+56svpvkALrE/knVjs0v8pnvfZ?=
 =?us-ascii?Q?bVLbCVtmJFGUIrdphGVyUzhfMmBSwCcb0tD7nw4VwCU8Vq7fvZ61SFP1b7oo?=
 =?us-ascii?Q?IHXg0c1R3kWmoHdSEafOejrDBkOBiZl8aGIflYxvEyob2eAgGALMiTMpAcTO?=
 =?us-ascii?Q?dc1w4ZpePyvAPiqFxCKXqIqLSjHrYMnhF+rrNumAP/z8JFXJGmwq8Brzxavz?=
 =?us-ascii?Q?T45pfZg5Yl9d/Zkf7K2pfHnkMYct0BC4hVTRLEYMrYmoy6HBwDi8OAEAnlv9?=
 =?us-ascii?Q?XCFqAgcJlI/p33WCydFqVJofCmomF5AUAW38EC0zfZnR+iJvw02l3NDnxrYg?=
 =?us-ascii?Q?vZg2bWACBLWyV1gOGz+bAougHWMSTuBONS9JW/n+JAWuDuS02vJtZhbwVEZd?=
 =?us-ascii?Q?YxOtNGRlc8B9zcXY3Oj+85Ra1v3A7uaA1Y2jPZ4okFC9jG+IOiDeafJuEHRg?=
 =?us-ascii?Q?PT+39R34U40eR9Gk7TnxUAeHSPP3rR6RMoWI422hXS2zwc4KSLhxFJijNJEl?=
 =?us-ascii?Q?eXqLsmpGlfQ1VY6bVfc6H/F2x5F4/XrcsdR2tPK7P4ZSQjrCTHCvcQkPl881?=
 =?us-ascii?Q?GmC3arNrtdxNZYDifBea4ZdNjqN3PJvArDJ8iB9kYZ6EFmpRypxJ6/Dv01JH?=
 =?us-ascii?Q?kGAIoyifHhSwum0bPLLNg8vhEaFJRgGtyDpB7kgjQQrNbqVpO9uB8ZmS6zqa?=
 =?us-ascii?Q?GbnC4ipZ8UUkHNEyH3lVsOCWWwc8/TR3DcvOdu/8oo7KodtjK/lBXoVUlYLo?=
 =?us-ascii?Q?NiBQ3+FFJb9j9zrHFGwAmXsuudyuoMfnP02gtFF+Kxwdf0LgbiUirTjjSbKe?=
 =?us-ascii?Q?JKM+JkRWcpq2Y/SuRXUl7x4wUrT9un0NBwdG9fb87uAeYdtKe8ZiEyDylcPM?=
 =?us-ascii?Q?mpd1NcVq225I3KWZ9xD9x8DHnHH29Tn9c38JT3UG8Fbu57jCyxo7SDqCqCvB?=
 =?us-ascii?Q?NzBwA/WHcGQUQigEEiGtvmWK6QzlCEg3wYX5VruHeHlu87QAFjxM38SQELc0?=
 =?us-ascii?Q?s/n00iw+BIvFaa4Xm4JgRhT981DtepMUAJ52RFNvAE3D2WjfiitOmnXyh3b0?=
 =?us-ascii?Q?tQEcll98ZMhfNoPiTZeH6IDAg+g/ZYWjw/Vs9AO0gQXJNDQhbe/Z3oYvOjiU?=
 =?us-ascii?Q?S7BT92wmjdVZ9/ljRXlD/ly57G/dQYSiOkvRGGRCp6jK/kPY35FT9w2ldPIm?=
 =?us-ascii?Q?hTDFVmt4OWZGF1WRFqPfy4nlROv8p+HYLH88OwK9lfBZOoobfVWOtgSn6BV4?=
 =?us-ascii?Q?LxHx54E3YZ0GzEiqJfCoq+G0AI9Wa7ycjZLtkTmPeEoFS/CwHeAMVjiE5aTc?=
 =?us-ascii?Q?B2EiI6ebpNh8iYl/+0Wfu2oXSZtd+gsOpHNzU1Jj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b251dae-6a7f-45e8-ddfa-08dd50f4924a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:11.4590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUntguRwHvZ+2jmpok8YgOcUDqDvP87ObwAlhEoddtlQN5sDeRlAPlFfD+iVbBV9iK6BfneKqVSigE0JF1VO8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: nsjlv1n3je9Xaa3GLw4RTP-uedycwqkH
X-Proofpoint-ORIG-GUID: nsjlv1n3je9Xaa3GLw4RTP-uedycwqkH
X-Authority-Analysis: v=2.4 cv=HMQ5Fptv c=1 sm=1 tr=0 ts=67b5ef6a cx=c_pps
 a=WlqDjRht0D+wB3AL0MAriA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=f2j18demHnmxuC2oiisA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

This is the 8th revision of the vfio-user client implementation. The vfio-user
protocol allows for implementing (PCI) devices in another userspace process;
SPDK is one example, which includes a virtual NVMe implementation.

The vfio-user framework consists of 3 parts:
 1) The VFIO user protocol specification.
 2) A client - the VFIO device in QEMU that encapsulates VFIO messages
    and sends them to the server.
 3) A server - a remote process that emulates a device.

This patchset implements parts 1 and 2.

It has been tested against libvfio-user test servers as well as SPDK.

Thanks for previous reviews & comments.

Changes since v7:

 - split up pci patches for easier reviewing
 - fixed lots of device ops error handling
 - vfio-user code now in hw/vfio-user
 - improved commit messages
 - various other small cleanups

Jagannathan Raman (20):
  vfio/container: pass MemoryRegion to DMA operations
  vfio: add region cache
  vfio: split out VFIOKernelPCIDevice
  vfio: add device IO ops vector
  vfio-user: add vfio-user class and container
  vfio-user: connect vfio proxy to remote server
  vfio-user: implement message receive infrastructure
  vfio-user: implement message send infrastructure
  vfio-user: implement VFIO_USER_DEVICE_GET_INFO
  vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
  vfio-user: implement VFIO_USER_REGION_READ/WRITE
  vfio-user: set up PCI in vfio_user_pci_realize()
  vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
  vfio-user: forward MSI-X PBA BAR accesses to server
  vfio-user: set up container access to the proxy
  vfio-user: implement VFIO_USER_DEVICE_RESET
  vfio-user: implement VFIO_USER_DMA_READ/WRITE
  vfio-user: add 'no-direct-dma' option
  vfio-user: add 'x-msg-timeout' option
  vfio-user: add coalesced posted writes

John Levon (7):
  vfio/container: pass listener_begin/commit callbacks
  vfio/container: support VFIO_DMA_UNMAP_FLAG_ALL
  vfio: add vfio_attach_device_by_iommu_type()
  vfio: add vfio_prepare_device()
  vfio: refactor out vfio_interrupt_setup()
  vfio: refactor out vfio_pci_config_setup()
  vfio-user: implement VFIO_USER_DMA_MAP/UNMAP

Thanos Makatos (1):
  vfio-user: introduce vfio-user protocol specification

 MAINTAINERS                           |   10 +-
 docs/devel/index-internals.rst        |    1 +
 docs/devel/vfio-user.rst              | 1522 ++++++++++++++++++++++
 hw/meson.build                        |    1 +
 hw/vfio-user/common.c                 | 1702 +++++++++++++++++++++++++
 hw/vfio-user/common.h                 |  123 ++
 hw/vfio-user/container.c              |  358 ++++++
 hw/vfio-user/container.h              |   24 +
 hw/vfio-user/meson.build              |   10 +
 hw/vfio-user/pci.c                    |  443 +++++++
 hw/vfio-user/protocol.h               |  243 ++++
 hw/vfio-user/trace-events             |   18 +
 hw/vfio-user/trace.h                  |    1 +
 hw/vfio/ap.c                          |    4 +-
 hw/vfio/ccw.c                         |    9 +-
 hw/vfio/common.c                      |  137 +-
 hw/vfio/container-base.c              |    8 +-
 hw/vfio/container.c                   |   78 +-
 hw/vfio/helpers.c                     |  185 ++-
 hw/vfio/igd.c                         |    8 +-
 hw/vfio/iommufd.c                     |   31 +-
 hw/vfio/pci.c                         |  591 +++++----
 hw/vfio/pci.h                         |   34 +-
 hw/vfio/platform.c                    |    4 +-
 hw/virtio/vhost-vdpa.c                |    2 +-
 include/exec/memory.h                 |    4 +-
 include/hw/vfio/vfio-common.h         |   45 +-
 include/hw/vfio/vfio-container-base.h |   11 +-
 meson.build                           |    1 +
 meson_options.txt                     |    2 +
 scripts/meson-buildoptions.sh         |    4 +
 system/memory.c                       |    7 +-
 32 files changed, 5281 insertions(+), 340 deletions(-)
 create mode 100644 docs/devel/vfio-user.rst
 create mode 100644 hw/vfio-user/common.c
 create mode 100644 hw/vfio-user/common.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/meson.build
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace-events
 create mode 100644 hw/vfio-user/trace.h

-- 
2.34.1


