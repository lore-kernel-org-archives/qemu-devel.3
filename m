Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EEDCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8L-0000lZ-Pe; Mon, 19 Oct 2026 08:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7g-00009j-2E
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7c-00043C-WD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JBnO233621692; Mon, 19 Oct 2026 05:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3vBEVX+niLMJnfCDKjUwa0/HIy/VOW1L2EsbM7q6m
 2s=; b=JOArgwomCc2kjGy4J1JHcitI+uHxVu7XUiNCkWliXE7fkXpuzHmSRhvVE
 HByfTBIK/Plz2D6B98Wugi/RrJUZGEtSJKkVEe+g3iIDD7b6ZDYgeL/pBuQgQLnJ
 A/p5sk08+Ko+/CW/hNdnYbeqROrmE5ocqSKQUZifSXDIpcpqF+daOaJtHTufHsDs
 Ogn5kb+sV2fISZGN+UXQCzYBJSXNxBqT6Cn5Z6xLIZc8vVdf1KOOfEkkPkEPQfsh
 AAAEkjwIOOpeDsQUJp6ubTPoTgz808iYxYFf6v9+3fCCu5j0W9o7z5uyynibUYSK
 +KW/+ZkFaDh2Rm6wNn53HI3u7SUZA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021124.outbound.protection.outlook.com
 [40.93.194.124])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdjnwr1ed-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agf01a7jUf3qB0weOi972WrpYCuQig4HBqQWNp1AT6VUvuGakDzqk2WXyhk7VOFbhVy+oicgKwh6NUyJh4YIbJCLEkMJ4cvhd++mZd+x8p+4tr5w6NGTjhnkwRqHudKR5e/bDJnvt6FHfQCkRjWuvSASnK0iTXxvGlmilsbTjFuBU5Sj1nv3n6WYZAjJxyCGS1LAjhr9GYQv1w9JppInB0W3oVKtGlzBB9Yn7rsDU3G+UlMif5UPuQzCbvcBkN9k0RCx3foaYIIIP2FbCH6VnIZIBSg7MksmJrHxRkjOUS+i+DAvAZhcrwC28lWuqx4+6SBx3j1VZyDfBE/t9qaPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vBEVX+niLMJnfCDKjUwa0/HIy/VOW1L2EsbM7q6m2s=;
 b=QMwtU77merZgRFrNKCoSD6eaDOaCXePXctO49jbZF6XTEDpsMAFU1a7ZoKemMwbISmHra0Z5e/lFlDyXHzRxrBFwTKIMRWFd7kp3gpykTxdl9p6G9aQiJauLMPVMIhFDFajcM5t0MhA9rUeB4GRvSa3cp48ksrR2lyFv2TFLbPDlfHJJVyvV9Z0WS8uWRCyZs7fTonVQa4zdw9HArQwv4THhySO1S1yl81bL3jCQh9l1GMZdatO8jWIeKh7JcQj93Cdr3AxVxM92gZk4/vXP3u9eDZH9lV7Wk2J/FuMt4dUY8V+8YZcGc927i4XXihKudqN3hUUSHzwzm2MuR7BSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vBEVX+niLMJnfCDKjUwa0/HIy/VOW1L2EsbM7q6m2s=;
 b=WqqZyR+XPkeiNO7vIVQ3K0K8OFDH89mJlx0VNqrQ2kud47YHDcVC3519vN21R8lOiW89Dko7wDwId3wJSf3IjcxtSDh8AzXEpa2T3/7POCSeazO2Upbb5NMAyArGVjiaFQa/CrunHMkd2ND0eoUzPR+W+gJnH+AGDnIdcqeu22RSBnuh1oEICghKzH4TbjzOTglByXxNFWaPLTF1nD0cvVgUvt3FpqaSl4bIc3fMeevyezy+ZO8jyB0+9hUfw5nB5Bm7X24mx/z0BTX0It+Nvt89brt/EKwE35xdqpZ3w0vKoCzL3Go7eiQqXkcpasKbNisqvRJv/9Os4YudyVRYaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 05/28] i8259.c: rename PICClass to I8259Class
Date: Mon, 19 Oct 2026 13:04:37 +0100
Message-ID: <20261019120517.1448687-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0654aeab-9d91-458f-37ab-08df2dd9493a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: M4IU1zeVt9aVVaxIxDQwdUr69raRcSEVXW2AiZiYTIQIgbJkUTdIg50h+sEKm4De8wZSopjjd1mveQJEQb93xw1f94lCmjAffqqo3TjnDeB18hYKN0zSu2LnRCfT8Pcd3h3r6FRz3zI+7H/oMaBQ0Dt+HYf+beMwFWaaz5DAnHIF1L4zdji2Ml/nOaYKdgQFV6JKJUoFUuOmvVQjPvhOnrqLGp+1LegILPxA7eaHeqK+ukWmcCkbTZgQevShYW7d6IMH2xTLp9W+fciTXrDlUFnudSzEFYyafsFS+5FckOQnC0fBIGuBwAy/0kR8uEF4g2LepSX36/aS6U83E26/Vr9WD1kW9s1HUe0Qrod28Krk1ANzusHsyS4L3iBmkiXDe2u39dHP5cnzcp5VH22e/jX8aZJQYiU3LyETHy6hRmNiCphhtwcE/+9BSLrsO/LNprpnwmMKpuQYChOO3Y2B9oEJ8vZuYMkCyUi9g2BW++o0EVkZEv+Saj9xy4/rUyg4WqNX3UdoX3sxm8B3PPeuaAF6Hhs7tFO6jXnLm69RCoc47Di+teSqH/RFBN4RwDc6DfCKAaebGK1AAd0dVmi6fjo8wNTkA+BntIvr+0ASoi236q/uPWAMdI4P+Ub9jTA5pQ4DZIvuV2eb3mw+HMcf+ClvwaJDJHPodH4pL+rFszs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nuyhI64VfTzVYkMXZumy2VlOavLSN/EchtoLe3SV7/DB/39tgiXvCuDYnC5u?=
 =?us-ascii?Q?GMBBgioIISGvCYRJMhxlVFuVqet9tDZNM13s5kT8GAtWQJn53rahQpeOUqLs?=
 =?us-ascii?Q?aPaDzk9kKddNb4yOoz9cUl1SxfdrH9jkftZynUfqhyl490w6DUpL0z2Hk1Uz?=
 =?us-ascii?Q?G3xS8SSNberjMruS7G5lCeijb3xvWDalbA/aPlEHt2CwzeL/rf1v1Ll5WgHm?=
 =?us-ascii?Q?R2tDPKYgWJ3qLcK7DH0NdYAJHdP/uE+p5/0jLn6xu5GiQ2UJLRaw4xEFBvAT?=
 =?us-ascii?Q?uXyrHo8DCa+iv2FMTpydBl5sYP8OG1x94agtuI96/1MKV2Z1ZI5Gtm+Uerwo?=
 =?us-ascii?Q?okV3DDNbBT+mOt8h8EaicXS9ug1NA31ItmzNMW5nuCO9s7e+bEbkF7aCPXUv?=
 =?us-ascii?Q?8pcGJ4ryIVIBuv0h70ZKWFPS/leUjQ9ysiUn4bTMhEbGFT3FWla/uRcwo8YQ?=
 =?us-ascii?Q?kncJuLR2CyQmFJPHXMb5MC0Mmn+QNnetwvYKJqtu7lUBhYhRIejLjotj0EIc?=
 =?us-ascii?Q?g3X+MQsEEq4U5UV6xVnsuWxGlw5v9/VHuE0sqfPhZPm8nCNmIXBG/RKBISHg?=
 =?us-ascii?Q?E++jll36JxMjBDMd+bTnxZDL15QpbAVuDh0TD71fTFFJlIK2nrCB/p6pGUL+?=
 =?us-ascii?Q?j0Uea7xbxpPvYlBuVzJiqvrvBeIVt/FOjwiB/1eQI2G6pBRvv5tvNiXLTbpq?=
 =?us-ascii?Q?aJSB6quhdUZ7yWjtWG/ygY4CtvADGLuJ/q+UVyU6DQ8Wyr+ces1/aAAsDU7Q?=
 =?us-ascii?Q?FWdE8p5ZUMu0GxW9v0a4Qenamy1btlsfqz8nLcoYSw7OTTJNtBQU3F05vhVY?=
 =?us-ascii?Q?RZtOGOchla0aAi71fGbO21W46vaCxT3NMqRmUHA1Fhb0u0m3nXEzjbv6IXl8?=
 =?us-ascii?Q?mIlCn6jXqk3ZJ0yKTeqcWbIsPMh203+FnDhT+Od6O5Ba8qQiCf7usQwPUwQK?=
 =?us-ascii?Q?YDqb6Z3cpP8LX2ltcq7snTKCiXtnrN5Gnt6VJ/A+n0vBbealMzpAy6QKfGyV?=
 =?us-ascii?Q?IN7sn1In8Sx54K3ezHIVWX7WSAj9G99xhghOE0NxsAiJ9jBjIuen3YtM3ByH?=
 =?us-ascii?Q?yFNE2oJ2YBUWbBUP8p/Py9D0yGipoJqFwbKuQrpoyEkVlH55hm2Ml3bYgSb/?=
 =?us-ascii?Q?nGu993bW8L5jOsJ4drw4P2SsrWfrevWVOnzuAJaUWnf/gNBAQ2IDq4FA6usS?=
 =?us-ascii?Q?zXhCDjmPQpMnBx4CrPnAfQ5v7VCK43dsdflY7/dH6g3M1beuzgKDvWQo1DDc?=
 =?us-ascii?Q?QGdQA5j+1CjqU/1IjYSKZ3c2i0tGWbK4ql2qOf0sl5sjjw/BIzzc0Gudbm+F?=
 =?us-ascii?Q?EPaRuOjVjUZZON43/LjoNK2V1lbQsNJ/9fYJZwVCiJppL3dQ+O4nDfMQ4GpT?=
 =?us-ascii?Q?xJ8pW8wtduEdsu/5ap3XUmTxLxCzxxz+ReHbHqBYfWGrcu48LJwCrZanILkl?=
 =?us-ascii?Q?tScZ1+XCanHP/+f7c8FP6hqIArZQY01CwoApNeKwreYZPW42WhRWilemoooj?=
 =?us-ascii?Q?k2LMH9yX4RljIqTg6NEqN1Rzblz/aApS71KqYUv+l5+/EtqzUFU3+wPd4BsJ?=
 =?us-ascii?Q?a/DBWsXhscW/vFzaKi8m0dIS2c5lkMk06aV36CFHYyjuqR8oaTcSUvgWKCAx?=
 =?us-ascii?Q?b6bkuTMy+UKLBr31y/S7IrJsyPLZSjoqxYNe9r95ohMDDNbs13HznELZVSPR?=
 =?us-ascii?Q?FkofryCsoEsCZlTKeyMkNnRL7y3T1xW9JfPuZzoBPCs0UDShcswWRZ1Ia77S?=
 =?us-ascii?Q?n4bDf9f7JVs3vpfCTOvJLGrQDTOP+rA=3D?=
X-Exchange-RoutingPolicyChecked: 3nArWL+waKjRLFufGJhe8120a1yn2gFZYqyGx7ZK8JqWlbRr9DnQNWZN7KD9Fp5DsUZAcqQceKtDOXcOuhlMXMZhTlIniGX5jN6VGfPuZj9zhQhxPOWsx3VkDK9/bhCcbHlqCIcc2vh3KOB7a6rUxn+evxWb1EGTXvVY8NUg/PrhnF2lFehf5can0ne+8lddw4bbLBJ+Gzgfqz3FxH5mewMG1lZC+3Qwi1+EPYM4WF9dvZGw4GuJCSpXtwk7lEBS0/Td8VfCSeElGqx/e8/shmdHplk+kFJLkZi44vmPcwkU28indy43jLfejbzLxIgGMlRoI8aMGgaNBHGIaEDuCw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0654aeab-9d91-458f-37ab-08df2dd9493a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:37.0432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SA8oyahCJtbr6Qgjdq+gqygO1aF0K7gntqBXYiv7VsaTRZ7rwLKI56p1kpemwWIzp82NpeFxT0Q2YnMGdlESgpEtPXKe6EtdlJVaVKRxpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Authority-Analysis: v=2.4 cv=fqdJ914f c=1 sm=1 tr=0 ts=6ad60793 cx=c_pps
 a=MkKZ5qa7cfSD1TaEQpvYjA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=3XFHsOGY_CSE3CcXMRUA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: I-eyGOgIINqt70-PG3J-rudCgeYrypxu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXz9rEs8dhW/O3
 fgaWBfXSic8BdKVivaIV7htE4iQOv5+uMbIUXnurFcJzaeZ2XHlvgY+my5g/1Irgd+ylognTypH
 0NipO7/XcNrZk2tRoh98wyJZ042NDfc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX6D11mfmuVJX0
 9cPVRuPpHcq23sJbwlEavMs5GxeALeoxRtg4boHRTvn4x9WIkx2GEWUZv0T+OQk9JeXJVNHN6SA
 flJIYch9Y0BG376ADX6wyAVBLKrQ9aDwvUJ3JGyyPenfuGHSoFPW/kiiu5bq5UgBnKVmko3b+uk
 YgE+TQt2hfDZpKhMBF/hrGOlAPJNRfzRCO2pv5/DrF7En0FEm6NxO5YyeOYOyChaCBoPxD9JKG5
 F3pRSA8zJ1gj7WOv8qPzaemRi5jONhEi8LZnxU4QDRpFwpqZBnNogz7K+u7bw/77zRf37qdPjUL
 1ALNXRCKRmmgJtrnZKizWEzK+lRK7223yC+hlbCCjlUaUEuXMoTv+GdTsqHIqk3iXQahffpeOYH
 1t2Q67TdzTM12e1Xf2F3/W+M1enecfDaeM2sCIorGbuTHwzsKO0rFy/impvBI14eWbumYSNh5a1
 Az63RkMzsBP2URxq++w==
X-Proofpoint-GUID: I-eyGOgIINqt70-PG3J-rudCgeYrypxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This is in preparation for its use within a QOM type presenting a single
emulated 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 547e86c5f4..856075a754 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -35,15 +35,15 @@
 /*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
-typedef struct PICClass PICClass;
-DECLARE_CLASS_CHECKERS(PICClass, PIC,
+typedef struct I8259Class I8259Class;
+DECLARE_CLASS_CHECKERS(I8259Class, I8259,
                        TYPE_I8259)
 
 /**
- * PICClass:
+ * I8259Class:
  * @parent_realize: The parent's realizefn.
  */
-struct PICClass {
+struct I8259Class {
     I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
@@ -388,7 +388,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 static void pic_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
-    PICClass *pc = PIC_GET_CLASS(dev);
+    I8259Class *k = I8259_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
                           "pic", 2);
@@ -398,7 +398,7 @@ static void pic_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->int_out, ARRAY_SIZE(s->int_out));
     qdev_init_gpio_in(dev, pic_set_irq, 8);
 
-    pc->parent_realize(dev, errp);
+    k->parent_realize(dev, errp);
 }
 
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
@@ -435,7 +435,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 
 static void i8259_class_init(ObjectClass *klass, const void *data)
 {
-    PICClass *k = PIC_CLASS(klass);
+    I8259Class *k = I8259_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
@@ -447,7 +447,7 @@ static const TypeInfo i8259_info = {
     .instance_size = sizeof(I8259CommonState),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
-    .class_size = sizeof(PICClass),
+    .class_size = sizeof(I8259Class),
 };
 
 static void pic_register_types(void)
-- 
2.43.0


