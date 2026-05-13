Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142EFCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 13:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNA50-0004qt-Go; Wed, 13 May 2026 09:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wNA4z-0004ql-J3
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:56:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wNA4x-0007Gj-FT
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:56:53 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAvdR72908691; Wed, 13 May 2026 06:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SrPy7v2QPk+IGDXrf7SVDQGELYOPzQqg+/vhVFdGy
 rA=; b=YKTEUHfcucFFnDXzmdw4RjcB6KPKQJ/lmFiNgJ1En4pnORBblKQcNS1sC
 z3Kod30DmFyRE7r2YRWqqMnWACDX2PkoehkC2dVJFNXgHGzAcD38QLxRJGFfAI8R
 78bkpLKhExLmlON0c068Qche6eoxrBB159h9yPdzjNTXrdMYhYoc0o5lJL6+5LyA
 3QaLF7bsuphiui+czigOE/CJVaV/BKkW2Wnb7LsFUHSR/CGcJCle6u7xHJW4QLBk
 Jq914Nh1ZMNlE9j6fnuO5FRrVsCzBEPePjJErmwp/BYJY04pPP4IyIciaWKB6hZv
 FOH+nRT1d3Ro/lkfsN1csIk9XZICw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023133.outbound.protection.outlook.com
 [40.93.201.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e3nvc5s4u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 13 May 2026 06:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfIOhZeZA6jaTcn8vEoXguO1ortHKhWKeTEmrpWTQunmhMfckvG1quRXwZYMa5sGbcBU0KHDhluJZiKPk4060vYtGUErRGERItwopMW1ZY9PTzT6Fl4ASlNQzm2nbdcgs3eULjp6WFLnLDlkRoP3n3PG4lhwjxe3SRLr7R44AJVr88wm0cduLIfXvkZBkdb5Ic3O+gnrL9ZsIXQboyze70l2AjrIdnCaqWlJQrhJtCyHTMHSdcpsdLcr/4979wJzuKO19zGfCd9w+jChCBdYHR3yEghMsMTgnivT2ch0/RLOLiUCVODw2MQIhae7meg7x2xksO1v3ajX3/9RRDn/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrPy7v2QPk+IGDXrf7SVDQGELYOPzQqg+/vhVFdGyrA=;
 b=ojuwo8+kr3/gjBkYz5KrUOiJuSYiUMr46iS2CNH1FgwBw4ALQY1zP6Wxn1oc7ndICuDz+QCLOJr+wBzimyqhPM7pZAMppDGlOqICmbOK+0riWna0YeQnPBY1tX+YXFua6fTuURWpoFIt3tY+aIPLw807xWhehWyhdo/5a0MNd2FKSD2ryFjQdKIg063EQDeKkqhuZIfsstztXTvLZnZsecF6Zmneha6z6PBqbWi/+TuaBYDSJiatWgKa2ugsH+j3WLivv7f+x793ANp5rxIAOMZF94vLhuQibMbmTN5mq6a3ydQYsK0qN5LWctBSSjK9fTGNTr45KkGWHI5GK998eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrPy7v2QPk+IGDXrf7SVDQGELYOPzQqg+/vhVFdGyrA=;
 b=VKf3JzdcPS60PS7oq6kkBqSIv1J3+a712vFNplUuF+JYE3VGQce3MPUySc22t2S5EIYHee4yxC27FJlbFf3RvT4JQSkoaFsz33x5ZPUQntdDsc14/ntUNT492+xXUQ+lSkzuoK6zcWwdNobKehvH0IZqXUOxugOo9yNFPZwoqcpWuLuLnagB478XOEC1IsM+s1WkfYWBauLQJ8PLigEV4c6GQopgjGxLdY9w7+HP0OeBmI+qMoPnYWxhoXHHVBP+w0qoYRAim6pTzhrgM8gXBflYO8HHYfMkZIcgcGo6TJgtNmg483lzxt6Gy/JwHO1lb5gfIQ45eg/TrAsitCFHig==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by LV3PR02MB10644.namprd02.prod.outlook.com (2603:10b6:408:28a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 13:56:45 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 13:56:45 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Florian Schmidt <flosch@nutanix.com>
Subject: [RFC PATCH v2 1/2] Add HvExtCallQueryCapabilities
Date: Wed, 13 May 2026 13:56:15 +0000
Message-ID: <20260513135616.3519354-2-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513135616.3519354-1-flosch@nutanix.com>
References: <20260513135616.3519354-1-flosch@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::23) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|LV3PR02MB10644:EE_
X-MS-Office365-Filtering-Correlation-Id: f6eae396-90c0-4568-d1a0-08deb0f77848
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UrMvHVHGQhnmg+S/0OX9sMMX2giIXbI0YnUGScuOQyjARyXOgxGk7nsiCbfOWldzru69UvPVLT3p0804C9ct5mPEnTwWd7O8ZZqyY5o/C0RhGHbw7sdUj/Ow4z4Rk8mX76GVGZVEeV/s3QhfZzYx+O4rYn3YPeRR46fKt4hNYmTK35XMwElx659+L7cbVSJGH/ZqOKl3FUNBqgrWhvyH+tbCU/Wy93cheaeFHaUlkNUaIQoEF1UjZH+5Hmc+KtPcPwIepDiPXz4roJmvpBk+OVGcmStDrbzv5IBq6s1B8KrNcQE5pfv1nUujD23C/BZPRbGCwtjVpK71tuxUjiCOwqypEbvcRL+CfjIUbJm+f02J2N5eEXZvnOhDxrcZEzt1ym3BAxPabQ+8Bi2lDBlitstFELWpxAyAQoIdZlx45wdsMXmw1TPHAOTXfz9ED9P6am3NXHROGFj3wIdxUQJJU40lZMgXb6rjWLORwI9fr4+GtuYEBFEe9HGThAnDPO128fVtsP//Lzg+kpbP65QuBfWJ9Eb54HTa8NlUVS6/Ihc8sRWR9vzRxtPajlomXevgy0Fp8M6VMxbCKYAqZryV/i4ENeuYlwQScFxDiYkKZFBeX+d2Nbi5GTNXm/AZismm2ITKQbB68bh/OBmvZ2O7ZBUEzW71YDD2zf6Be+AtRhibtuag1rq12cjO38TQuRuUYYQlrnNAHTQLqpa3jpyHvRKxRUbuIDRmJVf0zxAz8minWI9TS3SK4h10fva6Z+qP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLofvZDTor1Prcj3n7nFxqWOEeXtJmNT8hvKJjuBYi6waDuyZWeJM2c/TWbu?=
 =?us-ascii?Q?mXRZk/OeOmO7lHoKE6Nqk9sScokYKjtG2JSX+hKBvRkJrwpjMFXsLRl9aBs1?=
 =?us-ascii?Q?hLcQ4Run3aM8RQeADUVaWuxkAc1UIRghyDNlP/VDd8guTOQBN1yFzYAp0b9T?=
 =?us-ascii?Q?IGLRpI0sXp0i7fD7UpIxopxDnH/kBJ10vZLjpRqzgdFO+m1Vj1wtzZlorzbR?=
 =?us-ascii?Q?1szLpyHZ51KoZe/oBsmQ9Cmk/V26WbaSN4roNyx41qWk5Z5d6HBfmeeJD0M6?=
 =?us-ascii?Q?ftXUq2MZiMK9aDopXR1MZ/MUgbVWxpiwxSZafUyPlJNMAuC1Ne5pF1xVqtSy?=
 =?us-ascii?Q?yOIWLJlhCFJG6h8j4knz2FuNydy4/960fBynkAWVo/tdgqiz8gNAxwsDHcii?=
 =?us-ascii?Q?lOI/N/KUfHcjlbiDK142ay66R3tpYgc74/RjWhNrYC3iJI39iimGH8Tp+boA?=
 =?us-ascii?Q?UVQT/alZVUURcpOvO9jOnUJYeyZEz5wuV41Z5nUVMP5YnUuSDDilOS2491Ce?=
 =?us-ascii?Q?P2EpAnL34P+SXi/CkFliWBEbXFVa7Fv8HgHsC2eTD/lQW6yjfPkzaz8NakLZ?=
 =?us-ascii?Q?fu0xDgDb4Y611FVCcLMqgxzCrGW2lEfrx+dfCiae+VZwnbasWtEgkpL1UO3B?=
 =?us-ascii?Q?OjvcHpeQUu+foDvUi8Vq1PrYpuhC25l6rjw7P/0RdUC7ZQNU6w9jRw2dZ/UQ?=
 =?us-ascii?Q?MIo51T5i9d68LW5pB1lTnvqCBR8mrN/XOE6oqH2N9BOaqyH9t52rJ1fTCdV3?=
 =?us-ascii?Q?4GSdjduO2G4xRYYL9X9niKVFDA9lUvF6faR41TFnmy5a46i6DmsR2nfyd75c?=
 =?us-ascii?Q?OVkEqOctq7MZQSkFLBtKVc/q6fzP+27VNNqsJy1e25TdAB4xuwgWoRalvT4O?=
 =?us-ascii?Q?qYjLFyU7SvnbIJBehiscjKeRP9AeEyqDJrhOMqiNQoK1p5GAXEIUfwQKytew?=
 =?us-ascii?Q?0RXavMq1LBMm7+9IvKeE1eh3GFCkjdnWja5yFGEPfQ2mvve2xQmc3XdheCxi?=
 =?us-ascii?Q?8zqlOAz1uSiiXDrYsAXNzJvnHHLOMKaxk5a4y6oYW1+II5cT7suQ8nGFROax?=
 =?us-ascii?Q?BMcNx39JSnwAb5GUqzCXzpur4Zg6/LSAcTQNsr2t6CbSYE4HXIGN2zzq7rn2?=
 =?us-ascii?Q?hAgWdyCqvHaoHEEXU7Tg3V9hwFihyPAZwMqlRTO2au/ioYfqenSHYskaCOH/?=
 =?us-ascii?Q?2qCGlU0EQBXQD/B0fO6zxxNgPLg1uGl5nsayd1nJMjxmLci34VeV1MavKaBR?=
 =?us-ascii?Q?evKi/X2lDjBd0umDyknO3Glxcww23Fh07VbyZRRTzbO0vZpcaCYvxRPLS968?=
 =?us-ascii?Q?D20x2vkoic54VVkA0tHF1v/UkechmuBNqHkkPhPaA06TIEOXxwxmfKCNowDg?=
 =?us-ascii?Q?ZCzfSwVPkS/AF0cWdYZQRFUcSsRmn90rrtgH39uJlGxjPT2KLCTJmAoQw7EF?=
 =?us-ascii?Q?5hmitKLCeRn7kQUZ7P3Jg3uSZb7fmz0WIrX877mclXl2/O1zjejkWOvfJK7j?=
 =?us-ascii?Q?Xqyt2iFqzVIjl0y9TycpnxrDEcSbi4H+/AnYpnXK5psOpBJq1p7OAVOAq8JL?=
 =?us-ascii?Q?ITnLxmPuA3puMgZvTMzIAG5IqD0Eg4w0L2+hXZi1S1KbbNODLAoAwssQk6x3?=
 =?us-ascii?Q?C/eyTXYHQrHegqsePgIl9oDybV2LIf8+FIG0FIiCCa/PlRoRuDqwDZTWTDwX?=
 =?us-ascii?Q?d4UB9bwEQ83Cf9VC7YLlvZLVNsib2IC2fk65+2qCOY5tU0JGFatSV5ZUBx8M?=
 =?us-ascii?Q?l7JRejBfYy8Vj9FAuvbaV6tbeTqo2wI=3D?=
X-Exchange-RoutingPolicyChecked: a/5zE7mxV7X1QKjJ+1/zX3zpyLOXO1iKFvGzKghOxp3lHGGdj/cIWD2ycK2PhWt2enjoutjU6dI3tQmGGJ7BzhxNWI8jNY7vcc4i8vCTklNB9zvFHomArk+9iYTnLZty+ssBz1U4+Gr1NGDn1csT00Rda+aslDIBuuG2tSVNWmoHabRsK8v8gWrzT1K13uwEwU6P8H1u6olO864g8e0SQlR29ARMW5gxt+kxuE3Wd2kKX4nNJq3lIfOQH6mGgj6+UI6Lu5zSYjS+LdzxouMJpALx6kswZ3I2Az2+1oh7kHci/oNEw+4FC+nW7fpZubRWgUy2om0j6SjAMvoLsl0tFQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6eae396-90c0-4568-d1a0-08deb0f77848
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:56:45.6095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIXelfAU34+QjvHNuA6xTxUX5gznzQvIQ0v6WT37wbZWuYT53Xh14cJIJCSBAYwaH4G615wFw1zSTY7x+JohTRvIDa+/3Ma4D/hlUJtD3jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10644
X-Proofpoint-ORIG-GUID: XO9u8Lpn42U6zAKYHfmHIzsgxroRgf12
X-Authority-Analysis: v=2.4 cv=StWgLvO0 c=1 sm=1 tr=0 ts=6a048320 cx=c_pps
 a=vRE8MZZT2q/xz/g36YwB4Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=LRr5n-MZAe6TyMRmVYYA:9
X-Proofpoint-GUID: XO9u8Lpn42U6zAKYHfmHIzsgxroRgf12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MyBTYWx0ZWRfX/L/L109Vbuwv
 J+NuvVlEaWBM9Vxxkoc8w1sLzvgkdWsJSmpCP2VrZFN8IvvuEODfkyVKi7LzHRmDsLbAkwVA+yv
 Xfz+wRNamlLzf0Fe8ZBfiE1uYoAG2U3ohG8oKN8HaQBrviVe0vPPuMNDnLGbM4a6DxUCQp5/NhO
 gh4d0jlrci3Dv4onnEFyq6+WeLYFpQVyxSpvUh38hYnY9rMzFRYcP7IT9qAxTXSTq0boAuwhAak
 YXii0Q4aaX82yxNIQ12K4z+aRLi1bD+Cd90WdH6ApFKzBBQk1KZ4FHQ42+pqDD4NvgEAAyDZ2m8
 7sibcdCRfiqHKM4s1bXowYxy+j96nW2dc9obnnl/VcFfG9oMReG/mTfdGcxMVonjzPmESNL+f+Q
 HSPrhKHVl9gONGaeqLP+W2MMaPlp+0jqq2xr19XSC+jeaY1YeAYJUVScDxTkmgNdJBFvkTokMHt
 wn6Ned63gZheu3QFRxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

On CPUID leaf 0x40000003, EBX bit 20 signals that we support
the HvExtCallQueryCapabilities hypercall. This returns a bit field which
signals which further extended hypercalls are supported (as a way to
conserve CPUID leaf bits).

We'll track such capabilities in kvm_hyperv_properties like all the
others, but they will have a ".reg" entry of 0, since they aren't
returned via CPUID and so don't have a corresponding register.

For now, we don't support any extended hypercalls, but we'll add
HvExtCallGetBootZeroedMemory in a followup patch.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 docs/system/i386/hyperv.rst      |  7 +++++++
 hw/hyperv/hyperv.c               | 28 ++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  1 +
 include/hw/hyperv/hyperv.h       |  5 +++++
 target/i386/cpu.c                |  2 ++
 target/i386/cpu.h                |  1 +
 target/i386/kvm/hyperv-proto.h   |  1 +
 target/i386/kvm/hyperv.c         |  6 ++++++
 target/i386/kvm/kvm.c            | 12 ++++++++++++
 target/i386/kvm/kvm_i386.h       |  2 ++
 10 files changed, 65 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 1c1de77feb..c5ca25067e 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -256,6 +256,13 @@ Existing enlightenments
 
   Recommended: ``hv-evmcs`` (Intel)
 
+``hv-ext-query-caps``
+  Certain "extended hypercalls" are not signaled to the guest directly via
+  CPUID bits, but use a separate hypercall that returns a bitfield to signal
+  support for them. This enables this hypercall. On its own, it does not
+  provide any useful new functionality, but it's it's required to be enabled
+  to use any extended hypercalls.
+
 Supplementary features
 ----------------------
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index a854a4927a..1764203d3c 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -703,6 +703,34 @@ int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
     return set_event_flag_handler(conn_id, notifier);
 }
 
+uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast)
+{
+    uint16_t ret;
+    uint64_t *supported = NULL;
+    hwaddr len;
+
+    if (fast) {
+        ret = HV_STATUS_INVALID_HYPERCALL_CODE;
+        goto cleanup;
+    }
+
+    len = sizeof(*supported);
+    supported = cpu_physical_memory_map(outgpa, &len, 1);
+    if (!supported || len < sizeof(*supported)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto cleanup;
+    }
+
+    *supported = sup;
+    ret = HV_STATUS_SUCCESS;
+
+cleanup:
+    if (supported) {
+        cpu_physical_memory_unmap(supported, sizeof(*supported), 1, len);
+    }
+    return ret;
+}
+
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
     EventFlagHandler *handler;
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index fffc5ce342..f1d1d2eb26 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -35,6 +35,7 @@
 #define HV_POST_DEBUG_DATA                    0x0069
 #define HV_RETRIEVE_DEBUG_DATA                0x006a
 #define HV_RESET_DEBUG_SESSION                0x006b
+#define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
 #define HV_HYPERCALL_FAST                     (1u << 16)
 
 /*
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 23091301d0..e29d60f565 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -97,6 +97,11 @@ uint16_t hyperv_hcall_retreive_dbg_data(uint64_t ingpa, uint64_t outgpa,
  */
 uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast);
 
+/*
+ * Process HVCALL_EXT_QUERY_CAPABILITIES hypercall.
+ */
+uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast);
+
 uint32_t hyperv_syndbg_send(uint64_t ingpa, uint32_t count);
 uint32_t hyperv_syndbg_recv(uint64_t ingpa, uint32_t count);
 void hyperv_syndbg_set_pending_page(uint64_t ingpa);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97c66c2226..4d77de52b4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10760,6 +10760,8 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_EXT, 0),
     DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
+    DEFINE_PROP_BIT64("hv-ext-query-caps", X86CPU, hyperv_features,
+                      HYPERV_FEAT_EXT_CALLS, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
 #ifdef CONFIG_SYNDBG
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a836efd45e..eb870fa015 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1480,6 +1480,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_XMM_INPUT           18
 #define HYPERV_FEAT_TLBFLUSH_EXT        19
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
+#define HYPERV_FEAT_EXT_CALLS           21
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index a9f056f2f3..4eb2955ac5 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -46,6 +46,7 @@
  */
 #define HV_POST_MESSAGES             (1u << 4)
 #define HV_SIGNAL_EVENTS             (1u << 5)
+#define HV_ENABLE_EXT_HYPERCALLS     (1u << 20)
 
 /*
  * HV_CPUID_FEATURES.EDX bits
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 420c76b5ff..807acaf6b1 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -17,6 +17,7 @@
 #include "hyperv.h"
 #include "hw/hyperv/hyperv.h"
 #include "hyperv-proto.h"
+#include "kvm_i386.h"
 
 int hyperv_x86_synic_add(X86CPU *cpu)
 {
@@ -117,6 +118,11 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
             exit->u.hcall.result =
                 hyperv_hcall_reset_dbg_session(out_param);
             break;
+        case HV_EXT_CALL_QUERY_CAPABILITIES:
+            exit->u.hcall.result =
+                hyperv_ext_hcall_query_caps(hv_build_ext_call_caps(CPU(cpu)),
+                                            out_param, fast);
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8..586656258d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1136,6 +1136,13 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_VAPIC)
     },
+    [HYPERV_FEAT_EXT_CALLS] = {
+        .desc = "query availability of extended hypercalls (hv-ext-query-caps)",
+        .flags = {
+            {.func = HV_CPUID_FEATURES, .reg = R_EBX,
+             .bits = HV_ENABLE_EXT_HYPERCALLS}
+        }
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
@@ -1433,6 +1440,11 @@ static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t func, int reg)
     return r;
 }
 
+uint64_t hv_build_ext_call_caps(CPUState *cs)
+{
+    return hv_build_cpuid_leaf(cs, HV_EXT_CALL_QUERY_CAPABILITIES, 0);
+}
+
 /*
  * Expand Hyper-V CPU features. In partucular, check that all the requested
  * features are supported by the host and the sanity of the configuration
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2b653442f4..8c71ad01af 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -72,6 +72,8 @@ struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
 uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg);
 uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                              uint32_t cpuid_i);
+
+uint64_t hv_build_ext_call_caps(CPUState *cs);
 #endif /* CONFIG_KVM */
 
 void kvm_smm_cpu_address_space_init(X86CPU *cpu);
-- 
2.47.3


