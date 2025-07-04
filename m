Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8F9C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh8U-00013a-H0; Fri, 04 Jul 2025 10:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh82-0000sq-UZ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh80-0004ll-Rl
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:02 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BdGvH022207;
 Fri, 4 Jul 2025 07:10:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JGpRDP3xb+T8f7LvARPgvVyW+AE4ornzzKbtZ9xNi
 Vs=; b=Kb0hKWbBMVb9heq/E8D9/9Mvs+hgam+WbGGhEld0NK80G7aO8Wpt3Mvsr
 eMFQWvn7qYdYUjwQXe1xAndNkPc0cB0suUZ4MRtxI4QIlKBnMUtda0b/VGnFNeEw
 tpfsQlcVjZI38wFwVxaK0b2jTEa+XWOfDM5eSYcJPoMnwQPhSBfJ9SLgWdOqwOkd
 AMZ3ZrSKRkVeC/6tU5R7tEvYtZVwxCE9cRnc9GWgKQFZWzpzMMnyyK0MUBX7BM+O
 KZDlj1U4KHUTxxfYgRNi8Iq6CcASFigH+8GZMiEUkmQGSzstz1yzb3VbfjhMQZSA
 GGf3oIRrwuClaVwggcf9tePLoasAQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023141.outbound.protection.outlook.com
 [40.107.201.141])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47n1x96a4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/sbSZpTEhG7Cj2MBMLEgEp+ShewvURwe/W2BbD+lrCw3zlzTZAeFExQQEp4WFvvPvbXCKe+71zTHLHUQJecspHXgVl6tT2roXtry3ZLXayVZHYiK80gs4elA7GEtQRFi483BXZ2A1BNwJl1mBVTHCTqwb2cpbQ7cLN3qbRmVmpb8kN05nDTAVcG34fy/OoKSUALP5t3W2hVc3DEZm5Z3IPKBdO5iR5DroqZGE6Q3P6sUQbJOOJzLbXRVuOTMQItFlIFjsY1P+u9KrZ0xamGLriNZBjJQNB3zTnUOAvxScEAb7I37YiFHJRLTQqzdd2Fbyv2UcCbnFtdv5xo1XZPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGpRDP3xb+T8f7LvARPgvVyW+AE4ornzzKbtZ9xNiVs=;
 b=UzdrZBIqvc0/kOo/yJSF+C4OnM24p9RLK495zkGQx/UMwX55ELWEhLuDhogNs0q8X9Cab/NdnjXDFxfGJNrXncLuy8t7DfFTbSXEANCTTSiotwZKTQjmxtDT4m1m7uiUeYNWW/qM49mVSePC7TU65MSB97PwaJ5tRB1zFGYmpIvIlXzn4S/nmfkwV31BJguRtmZfT1wXwq+7Pk5UIKcHijAdQ4cKvgoKU+MfebeJF94mu+e5FuC5JndL+OhslE2XdiOxoPsqN+/fayd4QDOPPgA3s3onf2bt76pito1NBSN5y9lg/PSzhajnGgayqQpOtyJnhnSFvLWTk2dYXeouug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGpRDP3xb+T8f7LvARPgvVyW+AE4ornzzKbtZ9xNiVs=;
 b=jipPoNAOEnt3dqqNtZfGXZEdD9eQ5ms7iVQoqo1Fry/XwCNyGO8HYdkNnwwEfu2wBxwDQV4rZLkgYSBOmLNIa5Tt1dRro/b7MQIxiIGmvb23/4yy8AfxL/tkK7hk3FzcvOq8zKUZDOb/epQfbVjr5Goszw6NT16Q88kg5kn7NyJ0rhQEQivMPfOSPru6vn4reF941Di7ZUG+M2Me/DSEUnm53gEdXwvRlwoYUaN/NTI+cCZJdNIO7jYhap6HCK4WvN5mGanhc76wpKJlF6HBWqI4d52664DeLbnyU1bqn8EOPExdFFDDtGDpy+YfUnDneu+Q/38VdbP9gaRfYxK07Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:10:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:54 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 09/14] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:36 +0100
Message-ID: <20250704141018.674268-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 281f15ca-d653-4598-9800-08ddbb04972f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LaXEVcv95SZKRHc2Oqjqc8Dyp7P6NXN5bq3G4YE9gLFMgSf6+nQ6j4F6s3Ln?=
 =?us-ascii?Q?VNSYCDTArA3b8QYtBRcaoVZKuzOuteAUXgu5r/w8r2kWm+mTX8Z/ELT16U64?=
 =?us-ascii?Q?YJyTh4F6GtpnlY2+lJmkVELgwhy4+aDts/A5v4fn82lDKokXwI8mV/03nFk8?=
 =?us-ascii?Q?T0QYWRaOyvF/Dr/06hQQH4mCBzYSQJvkjLUFZ8d/59vEcl1M2EMlRTfcyNHs?=
 =?us-ascii?Q?cD2ltp/JnEuPWYdjihvmMNDCYmyYemRINWOnxJF+vRRKISz3U5Ko8k7mUvoY?=
 =?us-ascii?Q?WeDeOHbhjx9w9+aDVonTukusxOkyRBVfhHvKM0sLNIwJFa7GX3khZnD2iK7l?=
 =?us-ascii?Q?wTjTYkBnx5NgGR0H3EdmpTxjQwGj6MiS4GiGAnlXqOuYsn4YqNeSo7uWqCve?=
 =?us-ascii?Q?1/HvBrVqbdYvK57SU5VfhakKxZRpMhOhFs14mCrydquRSPdaiZocT7dHI0PM?=
 =?us-ascii?Q?uAT1mGIYNYsXLTlWWAlrEaYElWrMYWccPCa6FJ5ri42Mdi0SUlFY7dSYEPBH?=
 =?us-ascii?Q?3e+uVlGxxMYM1LQjwGytdUGMXjgVnSy7Et7Z5Myac5XkS5DT73gEmsCZoLgO?=
 =?us-ascii?Q?9I7nyLqf6yOWD9erfCKEJS+smMMYPHaEGl/i1OAmpbWevZdO8JmMHKnviD3P?=
 =?us-ascii?Q?U54AvqBk92qvedu1ERPLHRuDB+6PSxfLnUw+VpJ/KoKxFAaZM9RfcIxvmU+G?=
 =?us-ascii?Q?6uaqHS1VglYZCmz2xkrO98uMSZA0ziC+eFYWAK9ugULhsSJwHfES33n1BTYm?=
 =?us-ascii?Q?eKtFE4N9c+6Yog65hFkd7WKeXxa23Pr6qtr8jG648QjqvGmtP83dDlul4Moh?=
 =?us-ascii?Q?CTnM6mEZLRLGDZIoM+PA0oBlK+DBRqlDnxCK7s1ETqufcoCiE3FoZMebT/Cp?=
 =?us-ascii?Q?MWPJTtwBZRxnzU08ilyvUygc3VNCede5wxlVk3dVEaYVIH4iKSAX+OV+WohU?=
 =?us-ascii?Q?rchelM6zTN4O8B+wYKSBZ88jYN+QqiulANTjwdvQi12KUKMvdcwnKieTIR54?=
 =?us-ascii?Q?3Nfny30taGyElNUlprMaMCDdLQsZzjfk4vVYN4d7sHZPzOs3gjUthnFF7zdx?=
 =?us-ascii?Q?vBujjQTelwWHIBS9G7am+HvwsAznSWhQ8RrvtfNhcjNF+p9lWkjo4fQ1C1zo?=
 =?us-ascii?Q?HMnGeIS/aKtyd8yh2F676qEGIWb3ETtgNyU1WfiPv4VIxI/bCpMHCwR/YGYi?=
 =?us-ascii?Q?DC4og7dKblPBV5rfxHp2hQJdBlnAwNVWMbkTbIIsa/EaeooXRWK89UGV7pld?=
 =?us-ascii?Q?zJwUANqAl6UGp0JawXTzcOokIVSQalgItVFrsJjniOD9qJ28JCCxJdTqdZIj?=
 =?us-ascii?Q?4JtVU8b5DAZc2vzD02tm5/ljewwnrmAx40MLgg5JIiUUolny0gt3GwMxnQRY?=
 =?us-ascii?Q?aSv7aWvXtQCJPccKdjXdWwhotwAhdQEn61YwKet8fi7v0V52WnlJS3FgpShp?=
 =?us-ascii?Q?nSkdu3LmSKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VXRToXCza6IJsxXHU3snWhfb4z5+KqGPVw+krC/hqn/2WS7EE00h/BvUEXLV?=
 =?us-ascii?Q?hW0Wj04rdjee5EdQWE/HN9lDZYDn6Aqo8cKxveMI84FaHo68fikvm5jKzUcG?=
 =?us-ascii?Q?sPzVBa9LNON5TJWteBag+IzQSCMoCccTaylmxSZEcHsDGgV3Kx+rYrNZd744?=
 =?us-ascii?Q?QPGLdheosysu2MBh4Sk3kHMlAfbK4AsXtDOfOSzTESEk2c85uZKLeDIzSAAf?=
 =?us-ascii?Q?F4EX7asMnRLXYLn9pbvTqfqjnNg/Lph1pXm34+Zi+rwBKOCR0797T9DzXFFz?=
 =?us-ascii?Q?ycTr55Jh074aonDfaIY7iN1CmoMJ/8OTvHOlyqLE6k0mmNt9SD8nUTgZ37Yd?=
 =?us-ascii?Q?8RGgaWje1yfPpM3lrVd1fa9uJRS3v8xTJwQRbRggGtb0J8xAqkt83BTWDNZE?=
 =?us-ascii?Q?/d9dIamihvPgwplGFPS44kCfnbQLRjG6P8ozMvx6TBguyMkENroxIITCmoWG?=
 =?us-ascii?Q?ueMv2UYOlqLSGMJPQdxvlqHjvIX7ttjSLSvWTe1o+jb3jevGMeTzqvP7QDc2?=
 =?us-ascii?Q?oydO6YFHdnGMzQsUxVCJZZr/Xm8W74EckIB4rVU/XJb46rkVINZrNGIC1oYF?=
 =?us-ascii?Q?YCUWlvh8igW0gn50t+vTycmBNUeK2/yVTXOUAxxs7It7wfnwJhRJlhk13S98?=
 =?us-ascii?Q?nDc6d/IyjR4msoQ80zvDmXApzpZo1tg39+kFZYVJJbmiVCy27E2tYU1PQr8R?=
 =?us-ascii?Q?Q1HeQh/UbHbVU3+RNAoVWcWVTAaraIEwisVJJi859Xgvqgi7jc545ydbr1iT?=
 =?us-ascii?Q?kRO0Ik6dASs+Z3Z1ZKLOS+LuKIOTkXzCYrYH3dQy86ST/HtbkU0Mg1flBMPR?=
 =?us-ascii?Q?OgnsqjVREngx3MKTjNd+dqr+LK0VuZMDZNNmi9ZsDcmRm29MyckUjRNGVxw5?=
 =?us-ascii?Q?/uLWRyGMdb5rnqNCqe0US/DPq1uFE+08z5IAZP4DoNKqLL17UPtsFu6Rcmxj?=
 =?us-ascii?Q?pr6Jz/TxFjTFddm/6MqI5ZecmrzrXcWJk5gUe5u3iB77maz903/uqOdUMuXn?=
 =?us-ascii?Q?lPArUg/WUyQWlfrraZpiDQjVU1N5XPzl0Ds81RfzXXKTVEhLhzjUrs69ELk4?=
 =?us-ascii?Q?cRMtUg07T8rhM0nPYgQlStHra8VcXDHpxT3YtXxJdBS+KhCL+IECgBnu7ULW?=
 =?us-ascii?Q?m9K1XV+VV/m+j//OVj2szeCNNRgYGN6EEdcIPR44PrHFKgbBUsgQ86Tmt+60?=
 =?us-ascii?Q?gF3sdfxAWR5rA++qu3nXVwFGmDEoe9BDod41+FeAcu4X6Y6Lr1tHuhiZ8+tg?=
 =?us-ascii?Q?UX7en3+ut/+inPsF/cXYewHvxWO5eMsM50Nk6ShjW5HAfnIrXoC0wVHw3nZT?=
 =?us-ascii?Q?O3OCEl5J0p/KyY5gxEhjBNyqwsjrK+XUtXwb+qsn20zxw0txn4YJjtbkFw+/?=
 =?us-ascii?Q?nY095MnD/RmYGpPnzKHVakTZrhwUDQBnFTAdfBA3xWrQgmzV5JOv+hl71rZ7?=
 =?us-ascii?Q?zeqCRLCQKFGa9CJCGnkCryC8avLXhpfKMAjKiZy6A1tF9KpMJtjbEiLXquEm?=
 =?us-ascii?Q?Og2iAukYP06lw/bZJfPp3uEYiA/nUyLdWjExZPNLk5PS49uuGNXiwBwyrdgn?=
 =?us-ascii?Q?Z6nHO8fpqan7CQhRUb0YRIiv/bdg3ObSfQUHa/51sZYrVOjmIP8n3KTVT+Zi?=
 =?us-ascii?Q?kDmAN0g6v/CDAv7v7drLpgO6t+lQcun+V45jVeT6SFc9RQNSm1AG+CgTeVBs?=
 =?us-ascii?Q?yNf4DQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281f15ca-d653-4598-9800-08ddbb04972f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:54.8190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47Ar22lq8C/NlhmeQIAc0WMX5p7Db0CL+Ym+zxf6ObyB/ZUQMXTEUxg4KAugu6FUgGiV2cFWjTOFgLIexjjcF7JuurGaNWkS5LYVxoRO8Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Proofpoint-GUID: xdq8vtHyFSvXg2DbEbw79CGaUO63atKW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX9b9/rTVBLhYV
 bjwEXDfHqh/tz9Mu+TY2NBSFYFlQWbRVeG+su3nsDdO5blgk29ClLyLbzwQw2rXDsjgi4tIyd0t
 DbzVswuVf7QIgonR9/lMR1dwVU7O2RWsg8KylSMreOtVix0oAaD7mCJHtLIc/bz4EzMY5R1td1x
 iXHuLaehK63hOE7rkGRBY3MkbomE4MMQe0KgNMYAOhmdAcXlLAkxzwOgqnXD9zrzmxGdcz/M11/
 i9g2dHIlc7SAtPteZMIQa9XBxKNsusuBPS267RRBfZ86UhvPD2jWKzwTvIdgryx9a96jwcDb7D3
 D3mAvUDfVHNFamlT1/5I5PLHAHWQP5zfcb15jihzqNquBuHWt8TC1Mf+kaPXvO3U/cOinYaBObG
 76RB9Z1T6hspXELF4vSckPCk0eAgLJjOTx3Oicr51A/KWOimtQl0eyqYbfmwzSJ0khL8K0Ue
X-Proofpoint-ORIG-GUID: xdq8vtHyFSvXg2DbEbw79CGaUO63atKW
X-Authority-Analysis: v=2.4 cv=V7190fni c=1 sm=1 tr=0 ts=6867e0f1 cx=c_pps
 a=Fw0ky2jKRwgN+c0iFCliFA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=mnHwG4yJ6Weg6gPWIr4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f07ae6da26..c3de1d830c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -466,7 +466,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.43.0


