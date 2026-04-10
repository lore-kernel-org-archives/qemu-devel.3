Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9852E99056
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB7gC-0004dc-BR; Fri, 10 Apr 2026 04:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7gB-0004d1-4M
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7g9-0003I8-9F
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:30 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639LxbrV3391897; Fri, 10 Apr 2026 01:57:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DJgBrU89x0Xj39oqDstylv5nGc845iu1BsAVm6rOE
 9s=; b=nDzybLqNHcqY1DPcEpXwzZ0AFD0ADQr7NJaiZDsOE83Exu1/zKtq3mGQD
 hSaYbK/sfYEFlBe/f6wp90ZShT5GoGlRo+chvC3NhNaeWySdK4fGjvIbMox+3yu+
 TSvy1CwO7iOWHV66WSibuZJPk2GMljWJZW89E6/P4cH6oYEQTbffDCNxGqt8BWOG
 kVlqCUYR0CXosK15i4qAH8kg3NWCwlrK9K3FL93f4U2cYtVwislG0ONd5Qhjq82e
 OJUG711sLaUyfd+XF97OoUqEGFse5i9Q8LKUe8KtQDgpyodWHMbxzSDzN83gFs+o
 A4AW4EU2iZkeWrQH9jexZBpg1mmuQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021140.outbound.protection.outlook.com [40.107.208.140])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4deav1abrt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 01:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYBbFlwbZZuyLWPpmoi5V3leCANtVUVvY35ChOLzVH2SHvBmfcJM5ebmD4ZGfcfUbyD1yf+i957DAByDnK3fnLHhzl8UVmaS43ZigY0900E+hbL7GqRgpaSdkcova1lK0KE3jMihAYVvOuSS6BX8n+BsnpiBFt0p8/yUsRUWzIfpJOtyTCZBUja7yNgTM05w425I0Gt6bGZo5wBlvIeMMe0y7F7TfRbhdXjm/j4iQLDebMwQfS1EXVfIZN/nQM5DXjNNMd7FpBvua6Ls4Gy7CN2FzkTr/LtzXdJ66yCAzsLM3Wy0D/Wpon22qdtn30Q0cNBPJ/K+D6cwbkA4OAgvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJgBrU89x0Xj39oqDstylv5nGc845iu1BsAVm6rOE9s=;
 b=GnRH49zBxM9noyydVpShh1vrIRmy4PApuKeELsK3AQZ6I6BEZKFJjnmcp9MEu9uHHf1+NGa2gGIoGsd5UYDnT17vKkyR7jMl78620jcch9fb8ZHkDc7mY2mceBQmNGIrVC3WXp2g/l4HKwAjqxtYspdNuFKIIb3ZMC1N9rvx8dg7/gztlNKWRObUJVy8wH2tF2HSvVZgd0RvMk+q6GOWAJ3jHQJUoomNFnaEvsdq58GckFzfiTs/B14PhjijQf18TCbvXg6To80pQwGMfba60lCTGekewgJeA/Ay/x6B0GZoOqDpwsTSf3qG4ZxOTgWvt0brqZGci1R63mUU4J1XJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJgBrU89x0Xj39oqDstylv5nGc845iu1BsAVm6rOE9s=;
 b=RCWvZOJXfi+LBktX7nZdEP0QfkMjS0LpfrKDA8D/4iL5qJrQ3KbrNPCdEO5BCn5FApOzmclD+H0woiWMidkQOcNZ5OXDlykyMRZ+HHFwlYubuDy2RoxdCBUAt68BA5+Vv7YV0pXm3sMjlQQ1W/Gy6VHyPTK2bj8mg3FLEjHcjkzRQff4ed+mcMZgVOpx5zvItIOsr3bfA4p98vqJhXK5okuFQggV4fa6BdpBM06+UwVwiHjl0EORHOkTzeNfNu0Az3t7bQ9ZxZmAvlkNwhGBrWdGQlvlTbRjRpBNEaDJTHi2k6dI9jMhjD4N6HfkI6bP04sGmcyudvI5uDZVrn47VQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA1PR02MB9256.namprd02.prod.outlook.com (2603:10b6:208:424::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 08:57:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Fri, 10 Apr 2026
 08:57:24 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, Patrick Mooney <patrick@matx.com>
Subject: [PATCH v2 3/3] vfio-user: fix DMA write reply
Date: Fri, 10 Apr 2026 09:57:16 +0100
Message-ID: <20260410085716.877185-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410085716.877185-1-john.levon@nutanix.com>
References: <20260410085716.877185-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0404.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::32) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA1PR02MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe85a07-11e3-4bfe-c48f-08de96df2ee4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: umhr7RL1JHnzJ97f8eHv5Uslxki7YXYNL6LfgPQxETNBnyaCl0VkedGJvPXtNwwssgaCjVnEUqXaRDZURUDEp1wKqRZ31pr19Bi2TQva2jLVsRAfSxC51AjyxrBETUJPjHGqOo785jRrHdlCW9Sst9K4RNTpUTjQ9US8821V6r4e8Ex6L2+pP0E+fPPr/vp0rmgQvAp/UvWhrbasQ8aT4kSN2vlkYxMjXgfOnFwip0GIpwYQyMuQpcv5uVxU4kqANQgNeMOzq7sT9atzT04+m2ZL88HBU8mIPFJkianrU5NBT0ez2o4AuNl2JFZRh6DpeN/d9JTZWOZvYkcZia2NThgOvj8GSTITG0skJhP6fmEbBdYhH4xvZHjfyrtYQe9VlXYHBiMfwrMTVq+HBk7VCFdl0P8RtfPEJR0wuNp9kp8J7hNzzOZkkHPno0EBSHC9cmlDkokVQZbnZXgJH88jeA8BN/d8Czfp5hXDCrFxPpZdG+Dn4I2SrWf95CQl+vfeH1hbiZSUVIKHEDlsmwHwmnA7xVYmOyz/pvflyqNTquutXUgFSLfAPxoZEuRGu2tLGeb/2f5C6k1nodvEOU/jb0Dazz+pHMGIg1EBRWj0S1TRmdPdbwzSlOPe0KCrULIPUczUlrof37j+hiWrx138TCl0CzEkKU3nDXK2kZA0Dgbp5IoDds6B1qK2U3INOo9bOOtGrchHW2yDxz1VL9T0ubp9VHDUHDrQ1WLmhHZZlMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48IPUjI7sK1zdp3RgoKboa9t8Mt7h7mBDhwCrrMOE7gdgudROF5wMrF7DbhA?=
 =?us-ascii?Q?tOkFv4g/jbkt3QAwnWopa9w8VLW+NgLA49rinHweKeEcm4OVfrxvQUpaNarY?=
 =?us-ascii?Q?yUvBKrxaBCyuKlnXq8JuqKKhk9Miv1fhJlcYO+vRXiCavXonvpzTM00nhVzw?=
 =?us-ascii?Q?qO3z5oBN8F8bzxLM4P/myDt5DQG2V/PUq6IB6CWtuVweTSmqaktEisnxZkL1?=
 =?us-ascii?Q?pf2T97DgZtNHT1ypdI4VeSRNKVBVO0pjgzO/7p+tb282ACd/LcK6bB3661qu?=
 =?us-ascii?Q?sMYftBxR5FYsQaveDZvyWA4Ti0P6ULvwjitxp2N1HkmzUPp02bzW7Al6Kg+n?=
 =?us-ascii?Q?o5ws2RQ13WmG2zjXusKCNOZYuP6ovso01HUH47TU7E6qV34J+UEp8wqJHBPS?=
 =?us-ascii?Q?2Yyp0OmLJWjoMtZv9AozE48kjyOYPrEYrRyYTmu00bVeBh0KcD1SCceakkcD?=
 =?us-ascii?Q?H+0xSJRoJ/R9Jn/lEw09iT+n2wdCdrbyaQolUoWUWWrReIdXIwLPsge4CWW+?=
 =?us-ascii?Q?oqrvNgR+LP1p7zQwpM9/5MB+Bojyko+UNXiVAkHwdVTMGwzzCJkLn5UsetlC?=
 =?us-ascii?Q?Gvfkh1RGoFqubFHyrrSd4PTDWHjzjap5jIjDtinhBGiCptP69vp2xFubCikF?=
 =?us-ascii?Q?trQTA02OZp2pUA6Hwy35LOyrkS3WZwxp0OksFtratOTKgGTQSsZEsJj+J+Ta?=
 =?us-ascii?Q?L6LUAGI89UaxsJxxuGmH/AuumT+UXy8uoieIoeD7la+UStIO0SOGwGB1L6dP?=
 =?us-ascii?Q?0+OMbu53/U1/qkHNe9S4EQItc/79W55dfq2NTVeAFZUnZS0009sJSbo3etFn?=
 =?us-ascii?Q?2mfP0d81T5vXgwK9yM/NizjLbXVTlmwSPhY786a9XeU0sEraYXR0Rm5QVDik?=
 =?us-ascii?Q?+iF2u75OH6UfTk3Za+jRsm0uyikf7MNz+cWyDT3t8l9P80/Sw5xGUCfQcj+2?=
 =?us-ascii?Q?hinB3knXpbAc2H2qDo4YzULVKuybQUW4rV5qYT9HNrsDxVFQ+7ROcd1fseeC?=
 =?us-ascii?Q?Wl6SsJWvqKRE4xJfTkuCmW+/3MwJj3kcAWyKZMKD6zhXWJDfQjyB8Bw7Oqq4?=
 =?us-ascii?Q?1TA4IvOA5zaYveGm53nQr6MJzhezDRzYz4QpkbiJpEH0NMvg89y0tQQkPOkP?=
 =?us-ascii?Q?MwsMCyNp3Ih7h19rkXaVJmyrglGE0i5NvwSz3XvY8CIRb7Lxiky5/cfZXdbT?=
 =?us-ascii?Q?Qt1hNzxI6SxyM425kothfOEcGTHPTHnaoUE+34asuZevUPXGlvaoDlfG3bAS?=
 =?us-ascii?Q?jWu9qMV42lR2Q3DPQL+ItY9CUQieHs7WvTrmkRu3+RSzsII+7N3eW4H107JM?=
 =?us-ascii?Q?UwHq1SwnVOaNfggcmpTq48pb0E6jmJAeMG6+pEY03bHtvdaq2Y46r7mKI5rx?=
 =?us-ascii?Q?UjEvewBioPx3C7/GpA6104xK0Rp4GpjbsSujzijoomg1cWzqOeZH9Wkun9F5?=
 =?us-ascii?Q?KBXXyq1ZcRWf/Tee6Q2YalEjz0pdiO20zABGXjDB4yDOG/HEiJFZKou4v1QK?=
 =?us-ascii?Q?UXhx4CpyjN15uF6htP56PfVLMtH2Oppu03Inb93EV0SI6Qvce3HrbK2Q9PKM?=
 =?us-ascii?Q?w9Yo4BhDn1m7y4CGOpk+Ei+NsVhfWyziLqPaBCiPuKkwCn4Jlh7gOu9SRXUF?=
 =?us-ascii?Q?TTG3sIn6ihOJ0DD8DSMPfoeY4KtJxTkzvifSI9+oWMoRgOwHWUA9C9LnDd6v?=
 =?us-ascii?Q?vRmat83BR7hVjO3lBZ687gp6ckVyVzWsfRJoucNsfDxKz53BZbik8yS71Obj?=
 =?us-ascii?Q?o2DeekjY3g=3D=3D?=
X-Exchange-RoutingPolicyChecked: OK8BHfTm2tv8UPFm13W88BYG0IHSBXTEWh8Yw+snIbw3dufRTP0drmAOUsg6BR8xqS0yYNUw3BONSfeRupM4JecHLuC1YVqAYDkMdWRudwqbMgklKYUGeUppbPR0957PzhEWusZybH2AiBOc4WjnC/8TFOWkh3WRypTCrOeVhvTMCpgKcm4RAE+bDDVCLjA9ZGrQGtzY3uApDZIuBo6s41xvMRLrnbo4ZcmqzLI1R8oPNJNHvj32WmwgXfRcTAxeHPDfBzXBdWsebyx/8xEzxxzrIAWhGxCHNdfMudF4zi2nOIBE9xMGEoqoc0ZOBFr7Wf9UmU+D9nNzSmOng1/E4g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe85a07-11e3-4bfe-c48f-08de96df2ee4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:57:24.3469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwdqPLBU3AKAjix1u9pNbvZwM39Jn4iC6r2AIyy4R8+xzMUdpfuY4rqSgBqhVnJXc7UMclTVvCxou+Z4TNISzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9256
X-Authority-Analysis: v=2.4 cv=MalcfZ/f c=1 sm=1 tr=0 ts=69d8bb75 cx=c_pps
 a=oqYjYovRwutaw0NExYmD7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=puMWUmrUAAAA:8 a=64Cc0HZtAAAA:8 a=w6TJzBNOSodSHIE7IQgA:9
 a=oJ1xzHRvupUJs7EIRaQM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MiBTYWx0ZWRfXwqfqmvXiJg+t
 so+O0hvdEhmlKs+z/VMWiNu7rSjxlPheXctDXwiB3sI3ttndjx0ZqaIIXW2v34ktwGCTTyaA3H5
 osxklM0D+JIswq4lalUnPqz0I1lYf16A/jPpZaNEbS9IF8GMsvOIbb8CN2QbPtv/a0Pu67dWFHU
 RkDZ8X6UTHQePPhEfc4AOinPs8LIJKc5kkRDDaDEECGyidDE+jlqm9VFx2PnSbHNEiUJ/2gagLI
 ykOk0dlwiw698qa2TPzhx1YS7Kd8W4fgMEbhxeUGdlt9YSEaBQWKu22mc5hPU/I3yIzjXbBLKv7
 elqw+d5t7qkoM/FhHPESCLRCeNxWI3LwkAeR/o3+Lg4GElk0l2dc3FEJjzvNOAQuDbrWS24/t5x
 7Hst4hLogdnEbA/FKG8yo1OGATsc5skkpawWBsLJoYxlJV7unERR+7tqeYHJz1RqhFMRFCAKjSY
 nnrqV3986lRglLETZAg==
X-Proofpoint-ORIG-GUID: Vn5qky0CPNZ5jW-4ghAv9CyeHSZAbq3o
X-Proofpoint-GUID: Vn5qky0CPNZ5jW-4ghAv9CyeHSZAbq3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The protocol specifies that DMA write replies should include
address+count, but the client code was only doing so for read. Fix that
up.

In addition, add a protocol clarification over how short writes may be
reported in that reply. QEMU never reports a short write via the
count field.

Reported-by: Patrick Mooney <patrick@matx.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/interop/vfio-user.rst |  6 ++++++
 hw/vfio-user/pci.c         | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index d4766487ea..12deb25102 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -1429,6 +1429,9 @@ Reply
 * *count* is the size of the data transferred.
 * *data* is the data read.
 
+Note that whether short reads return an error or just set count appropriately is
+a client-side choice; servers should be prepared to handle both cases.
+
 ``VFIO_USER_DMA_WRITE``
 -----------------------
 
@@ -1469,6 +1472,9 @@ Reply
 * *address* is the client DMA memory address being accessed.
 * *count* is the size of the data transferred.
 
+Note that whether short writes return an error or just set count appropriately
+is a client-side choice; servers should be prepared to handle both cases.
+
 ``VFIO_USER_DEVICE_RESET``
 --------------------------
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 64b8b3cb8c..facc79727a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -109,6 +109,10 @@ static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
     r = pci_dma_read(pdev, res->offset, &res->data, res->count);
 
+    /*
+     * pci_dma_read() doesn't support reporting short reads via the reply's
+     * count parameter; in this case, we'll reply with an error instead.
+     */
     switch (r) {
     case MEMTX_OK:
         if (res->hdr.flags & VFIO_USER_NO_REPLY) {
@@ -136,6 +140,7 @@ static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
     MemTxResult r;
 
     if (msg->hdr.size < sizeof(*msg)) {
@@ -150,26 +155,35 @@ static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
     r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
 
+    res = g_malloc0(sizeof(*res));
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    /*
+     * pci_dma_write() doesn't support reporting short writes via the reply's
+     * count parameter; in this case, we'll reply with an error instead.
+     */
     switch (r) {
     case MEMTX_OK:
-        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
-            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
-        } else {
-            g_free(msg);
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
         }
+
+        vfio_user_send_reply(proxy, &res->hdr, sizeof(*res));
         break;
     case MEMTX_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
         break;
     case MEMTX_DECODE_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
         break;
     case MEMTX_ACCESS_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
         break;
     default:
         error_printf("vfio_user_dma_write unknown error %d\n", r);
-        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
     }
 }
 
-- 
2.43.0


