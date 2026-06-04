Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86B1CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVDWN-0000ev-Cq; Thu, 04 Jun 2026 15:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wVDWM-0000eh-4m
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:14:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wVDWK-0006bv-F1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:14:25 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654GnOdA3303052; Thu, 4 Jun 2026 12:14:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=IvawtNhwXj2eB/F
 Odthf6YNITVv0Bi7o3obs2L0HbYc=; b=ORZNDtdFfZOAiUWgIs4jvOccdMTkN0i
 3RSdr+WkIzn3bMl3+GiZkoFzV9ZY6/0T3x4Di5Fdguacle8oAKLuozDb7a/vTNZE
 6Zod8xXKrKytdZevhsKKl2Z85TE2JfGtZ2thgWVg0pkkLgi/YEJ47/mvx7tIrUIQ
 EunDzXJ6aNWBUHCxWdgSu+s8MosORnUFYWPdi/PA6siGu1Sy1fOYF83ZkL5qTBoJ
 yNfvfPq3JhIX+YlGETpWZTmRIDdSD5HOBqvGzyBYu3FmZ5qYk/A2FuKrNwUTUIFX
 cidQeXOjAnzXqpFGZ/E6qWkmjeId1YuhjgUTbS4C4PUBbYVsbml/ToA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023119.outbound.protection.outlook.com
 [40.93.196.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ejupdjv2r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 12:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn4jMduDNbq6zgcTN6AeCzPE3M0sCid+kHER2cbmtUV8Sce9jco7MYdcuqtp8zKz0IcimGyrO/EE8nVZ1x6kydQ5HfOgi+k/6/b8ZmWCE1i1rSrDRIyhzZr3wdjOR/RTLVAfHIWYLwWCu4m7eqfte948Eam3xUy7R4nEKVbY2eMOgOOxTxhIyeHIACiH7x66sIBIvsV+ONiSc6Fve+vtUlFzlrYAmgy+kzof4GRD2I1/cQdXhsNOY8Jc5OaFHaG713XFeCgk/emukU4bOPvA8t2Lm1Oz3JZMAK5R+HjIXl/CpECnG8eDiP1lQdvnAtEa7SzHbmlQG+ttQdmddbahDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvawtNhwXj2eB/FOdthf6YNITVv0Bi7o3obs2L0HbYc=;
 b=Wxma+FrrgcQ4+NodJrFVmzUGlo/m2QERm25eo87l5BlEEC6985ZdoNvcHY9nQ+PcUgYeZcdx0xwoxceD2qbKPw819pLaTKi0+pj2J84lDip65ciO+96pbrlkArGTWTGlkVdhi4bRpJV0Rfzv6vTctscRpo+sJeS6fKQ1cqQT9+WFVmWHyBukOTkCQjHjDxA+AVX4Wnrq8YgYIrIXe4JzcS0sOB2vsFLUGqTeAUDFLDLCg5vDs3iQGzc4JI557PS6O0ItTKXlgQwaUGmJ+qWljGvJ1wiWCY5xo5JZfQ30FwPWhHC3kwowZj7t2QkLFac4Omp9LBTStSMsV1pYJG922Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvawtNhwXj2eB/FOdthf6YNITVv0Bi7o3obs2L0HbYc=;
 b=m4pM/ke5r1HJvsIHJvHEM3Bwus/XGlWU55F7h8Tj0/aQii5Wzy71l0GZDGEru7L6RGWZJ9ORQUG021V6vmDzd097T9yeeBjYydQvDiWFNMyq+AP2uJGmpSZudqhm3yw4eaRBd6mpxzifx+SnW3vhZSaMzxCGth1xXvOntW9MZ30m4OnilV+m8taunKxsCfM/81GdtuRUp+/p+bwdhp2TSFWHTlOxOkeUuXYhDhw9M0jPcuIjtqDEcRYN3wwcJB8nDfBgtwyBAn3WN6AcFlStFvKgr/AD8TNmsoFaPHJ4stXBQKYaUpXeC0T7RpsqPFjdmu5E/Yh1xNfYVIbqNSeQrw==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by DM6PR02MB6683.namprd02.prod.outlook.com (2603:10b6:5:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 19:14:15 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 19:14:15 +0000
Date: Thu, 4 Jun 2026 20:13:58 +0100
From: John Levon <john.levon@nutanix.com>
To: Mattias Nissler <mnissler@meta.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: Update vfio-user spec to describe DMA access mode
 bits
Message-ID: <aiHOOt_5sJU6xWPa@lent>
References: <20260602133829.305842-1-mnissler@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602133829.305842-1-mnissler@meta.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::13) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|DM6PR02MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0a81ae-b335-4f21-4373-08dec26d77a1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006; 
X-Microsoft-Antispam-Message-Info: 1Ua+pIPKfSa/F2E7oXWDGUetE2lYG83C9qDGmpbZJ5WjcSCZfmSS+xYj5flk9VwNo1AR4cf8N2CABE7XDgUX0fNITT0+IqSIea7PKfWibNBqpzwEBdjMTzixM8vA/BmImU6K8qezb696xDXPaAs+Vu3IxGi7ArcK0BErLhcR7z2aGjx+NdPGlRIsT5gpX2VahF1P8lFmV7ucTyJnAQU/ds5PA07MXgqd1HublZ3IaAkaXrlghg0/FkUhzF8GKQQ5otPYLvUf/pJnSeExdeYrlLnRqbHLJUZVPB1fvNqAbo3HnergI3w6SlFrW04u3ucIr1KQ7NTRWTnIxb7wpIDgpe5B9EcaLHqrFF6I/kF1tlLkVeuwaAdEl8lU90V6UKyd8XANiUFiRYc8Zu7a3Y9fDD8pAFMCQibbljxhX3M8a9odrnvqOhd7PJH44uTDplmk3UEKEV/ijTaKopgfHN7Bn0ZpWWfKtJELsshjTaUU8onaBX+WMOdepWYIfPmAblnhaST8pnxTI3+ihOQPkAvq/ocQWXXRlC/BrIqRWNxTEhss8tmF2EwjNdFQH+ieKEzx1EnaZI457vaMACKwiKStDajT3AMN2ujmBnjoe+qa9aEaBW6oz72emo6iAzu8YX9oqmycbKDt4OpHA3mDQST+OaIK43a8ixnrNek+qY6XHn71LZuoBTln/mVAVwtlMate
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/uC2eQG8UFutuoCd2D6q4LWGksr2Jn8Klm25Hqo66Lsx9dLox7hXiqQ+MtVF?=
 =?us-ascii?Q?8ERnlPjFZPaCNvbBO9d3wpnxYezVu5IB0NLOswQYtr6MmV4aXgcOZjZpJaHX?=
 =?us-ascii?Q?ut52BmdRkLF+WnmA1un51ACH65tWVWfifAdbfqmVRXGtMJnWFy7qLfQasooG?=
 =?us-ascii?Q?rQyoI7Kco8crRRU0Za+dEQQvIrTIgdoKK5zubJOvUcH9HQhm0/JcI1gO3LnN?=
 =?us-ascii?Q?S35B9aiU+i0VBWiwJfKPj8H4FVB3h6G2E8AypXDFPmS2GRGU1aUN0dVk8IfW?=
 =?us-ascii?Q?ESeemORMdP/yVz5gJF7DLcNRSUsHZzsUNl1E2aeBJGkcRUn4oAD45yWlkZdS?=
 =?us-ascii?Q?JQ274IRBlgJn2ztQ+yVHmH525e0AdODFLmfAfbo0k5PQ2X0k4aW1QGECkaRc?=
 =?us-ascii?Q?GkkU7AY02Wa8x7gnV/Rfapn6SnMuokP4MpGBqFc5D2ZxZ2Nw2W+TJOJgCCLw?=
 =?us-ascii?Q?GTAtSU1bKwaGKUxZkcVoVvyJYihQCubdPfycCq/q3YZEIogb4g7I3uTlETnE?=
 =?us-ascii?Q?z7BUbfpcgf4BN+yN0hkwvXEstLqpQ+hiPu0snrFDbqAQkr8KjEv79kwku1uc?=
 =?us-ascii?Q?0Pr7jWnYL8a02rs5xoMGcPC3NHr5GtmIzoh8vXQDHxC/QkRrBZAWI+T6wiLb?=
 =?us-ascii?Q?qQTqXAtt9leU6xx7FDQUG3q71SqQQ8CMeKGqul6+j8OW9gbNdoojhOj9TIrE?=
 =?us-ascii?Q?spEmWIW7K5jA3nTTFEDHrZJEsY25Z5Vo3xJEzwRYX/o/5pHZbRZ3RKLPmrse?=
 =?us-ascii?Q?0a7pb5zREd4kb6bg26MDoUWrAyXJc9OAKoAFMrTtbnOOSGibnORzHG6/qt/f?=
 =?us-ascii?Q?HFDOQirK7EfFPQSl33UTXCrdRZim1W/ksxIBFxs94G3S1L8MM7MKnUg1VZ+R?=
 =?us-ascii?Q?e32Sg9QnNwabOcGcbkVRU0iRshicm9Avs59el+7xuW85ZAC5Mn0e0wLmBOBU?=
 =?us-ascii?Q?dnJJFY8DlFqgsQbI8V2B3+Y0M0bx7xNr5yZjukAkK1URDOJeF5C5XM5/892C?=
 =?us-ascii?Q?J4OGwIbMJA5NjxqqcqyHMxA9xLvgkCTqzs3euvdjEy/vEvDCDfklKTP3veJl?=
 =?us-ascii?Q?uGn8EXvQrcWzbGfilaxg1dOSjymgP3ZStwWFEL1z1QPA8S7qaI1c5jokTW74?=
 =?us-ascii?Q?xx09jCoJvxA+QYUsuA6N8wsKgC88YKn/DL7e6pqYIWk3CgCuGrncnlw4gbF9?=
 =?us-ascii?Q?t6IQ2JegP1GCrJkqsk2037JEFJsIxpmSGewc1mL1w6m2BDuv7KxaMeFNpUHZ?=
 =?us-ascii?Q?LUd2zW8gBRdB4/9f0pNWMuYF+2ARc0BRslxMxoRspMFV5USwiZu/N0Npt8iK?=
 =?us-ascii?Q?/HGb0pII4fLUXxv5tSINPtvSFTx08P2Xy9LFzMwOl8c7myTSwPnIRDBXbn8+?=
 =?us-ascii?Q?8SmviZ+tRtGTjsecm0UMkUcog0Rj9ZJ4nhSzxkcS6O30X/f0iY885qBE436e?=
 =?us-ascii?Q?wpHdBTSSsive/oU450CXPQrkvgSDXwvGXwAm3sdFp+sYE/ZmoTgH5JQY9QpK?=
 =?us-ascii?Q?Onki3NAS7jChstTv4FCUeRQQ2sPlaJrQcdqQy2tr3llC1AC3BPNurBEA8GUG?=
 =?us-ascii?Q?s1fs25NZT6EQ10D2Unh3qd9amQxiu4PmQJOji0lYJItwUEjZmyZdR5auhRBI?=
 =?us-ascii?Q?jpZDjpywCX210ywIQOVDEOg8zUWlG6rhTNvk/iBqKtMIO8QCxcBvk77uBWYe?=
 =?us-ascii?Q?Zd6g94fNslpDL640ZBej1e7SzLg7e/exwqU0kfcjD1DNzby0gFMg9+I17ggQ?=
 =?us-ascii?Q?wQJpb1G5LQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: dat3R2/2coehfsSWsutXT5+4ps5aQ9mfGDo+qzbG993i6ABu0VZiICOxKZyikmXYd9VIklx1ieb7r/CAT4NoAQ6vJZf/BVLe63J+9VIffYrMTOS23jyOATk9pyxHe0Ql0gGByDPWXyCKlA4Fodz4cFavi0itmS+kR5YJtMPbkJuUg6ydNockMw8/UafpQH94Y6zeF8xDyaqx+DGuGCItzSXT7eH1KSXZrr1lsKXe/qYdNgYV4fb5+76beWk+KQvdwL333CV0HijtHNLyvqlau6qVD9x7SJBkFOu765VPrRcfYH76SEM76SN8odKbCXznlVkP7YXuY9+DrwmqaUtXOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0a81ae-b335-4f21-4373-08dec26d77a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:14:15.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IL3L3fp2/I/2wrjqf9+QGD8bpgE2GUBUvL3XGQ2MIAMl4qNl2j82Yo/YZxfyvQaHOTsdr3KLadwUoSYcP+rrqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6683
X-Proofpoint-ORIG-GUID: c638Z3gDuz4WPQuf0uh_vcXJXOeM85gN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE4OCBTYWx0ZWRfX6UxDpFN1x6eo
 2B7c6gCIWQTXOsBbmk52gPg3aOHQPXhZ/Mi8itBXSjfGYOnyVZEsJldLWAqOsukYGQW8Y8BJ4ml
 z8yCZDXkMxa1Jr0jA4n/ZgfUIS8uzXxLD91a1/YQRb3kzdx2hjLczUThuiLU3pvgU/p5H5iXE8h
 c2vOnx81IE9FvTqRhSRmeZC3GUsVses80eVyDYDRaHF8Qthz/863Xl8jd/p3aEsGJLgMppL0haP
 fDrGjgMKrnnduWGFDE8z1inXeuj8ecz4YQcNIUOlb+DrR7Nmt1PH/LAGOfd8qfkvEEqgC6WCoRs
 a4KczJU4yA6NzKCPdG5Mgz9DOBufRGgBlSxNdnolxdiI/rJ5enE94dip7q2TT9TwKl30Yu5N8N6
 iboz+WG2MqwxaejKoK45Y1B1Cxf6xyQbbTBzhuSBrN1UASQImlIrVBx66W5wWckusWTc2loJBCb
 oCrVW57v3UlnoHpJeIA==
X-Proofpoint-GUID: c638Z3gDuz4WPQuf0uh_vcXJXOeM85gN
X-Authority-Analysis: v=2.4 cv=dYmwG3Xe c=1 sm=1 tr=0 ts=6a21ce8b cx=c_pps
 a=SNRzDqNuYCMO/bT9QdJRMw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=VabnemYjAAAA:8 a=64Cc0HZtAAAA:8 a=cQTdl1Cu9VSXZJl24pwA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_SUBJ_META1=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 02, 2026 at 06:38:29AM -0700, Mattias Nissler wrote:

> This makes the intended access mode explicit when registering DMA
> regions with the server. A new "file I/O" access mode is defined, which
> can be used if the file descriptor provided by the client doesn't
> support `mmap()`.
> 
> Signed-off-by: Mattias Nissler <mnissler@meta.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

