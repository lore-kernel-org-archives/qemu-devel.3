Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B151C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc49-0005xR-Jc; Tue, 15 Jul 2025 05:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubc32-0003yH-5I
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:34:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubc2t-00063w-Vu
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:34:01 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8voQF014064;
 Tue, 15 Jul 2025 02:33:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=uml/T+Gkbl3CegO
 D99HjWJHW1piU9yP7YAEfhieBfCU=; b=YzuPUKZDrnmLDAZz83ZXUaMhLMHAVA6
 G9X4dgnM4q32/AeHB96k041Q+7WanKynGmW+gEn18VmmkjRZo7hcZQqZVgvx8xOn
 LZlNS1LDNKh+CGw3wIafDn2uh4++jFgPv+TXYJVKG8RQd8SyW3xpD97RH5L60YR7
 c4rQ0Es715Xjinij0vjeazJAoYchmih2MgppV6Pc5nICXfMOGJKF3utan2VN1YGm
 qLZMyYWEPAapLPm/fFSv4gyRNOE1au2ziQ86aptDsNpaBxiryGG7LHkF1z7jkwZc
 bQZHayxO22HxSI+aUwVFGz2GEsA+oc9lLsY9gb1XJxRS7mxlnM0Tn3w==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2127.outbound.protection.outlook.com [40.107.96.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47vscfbpma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esU+QbtV7kpdDQRG1Npvfvf15Mk5EiIQ5MBxkDvX15+jK2TXHj3MvOIYBHdt+Tp8uhwDQwYrt2qTB7JEyJ/hzZnc2z+X+a2y6ZS2W6wlyVNKaNHON0o5OO0EUXUDht0y1simjeF/ocv7UrIuF95+fk2k9MNhm8PghHUfV5uVWWvz4n6yhLF+Z4qULfvgM1y8dZBPKgLt6x8gC/N6NN2EPIuPV/05qx0BTchN20pIdhUwpOqtxdkTFmu6G9eaEzh8B1ORRfFe7QcRZNreFJfcyGr2uOaAPSgvHwzifer9RYZq3AQGS7F09wBoca9vp/RXiRUoS44VW8SrlOmnM/nDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uml/T+Gkbl3CegOD99HjWJHW1piU9yP7YAEfhieBfCU=;
 b=lZBjcJlCOsrNRcHm2YxUUdg84X/KFnf8+awhoO/U34fy7yMvAOml6H/3c12Ju5Ov2Oi7a/9OJinxGoWLnyAQ8w4Vay7zR5c8Bp36qi9za7TmW/XV2VzNf974wEn7ljLP6qLeNTJ5kGIL0DGwb+eBRLVvJnaWcdyjLgF1FvMKnxknsTKOZ9ZlTR2WcSm77vbEVOVgsSAzZsKw0kFDuir/BysAWAzS+OIsBeCqcaY0BDGL5qII/zroU9blGa65gz2USi1WBPY9NLXTs6nAac7AOwefE5Hto0sj8oqzGRL13INzKcJv6z8fguvj3uR+8dD0Vbw1X4o/seDFTNbiUFJkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uml/T+Gkbl3CegOD99HjWJHW1piU9yP7YAEfhieBfCU=;
 b=TihIQd1AqgWX+cXMzG4G8TDSToqGtPiOHAty4savhN9jOAufVsaKjEv8WZLTFzjRdMTwIOFyW9+ebRu0CmvXm/YM8FC+RVybYUeNDcavfWtOWXzrvv+C6+Xc87Suye+M9jK+4tAhBydhlobvv/1QwDjnzNQeb9NeCoPYBizQlS0xcQafqsfOvEjr/BYkrQtNVXFFc98B4KVdbn+KeJxKKU/e8lmcqrOXL7tZrldcgUIGza/qRcjwSfgk1hn8biDMuJWvH5vpwxYvoqyVKhkuAfGaLbIO/qJhdJ6CjqYnj+YGC0qseqZmlVPZMVXsddMtaaUpYcdyFatXI9Zksq6PHw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV5PR02MB10876.namprd02.prod.outlook.com (2603:10b6:408:2fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:33:49 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:33:48 +0000
Date: Tue, 15 Jul 2025 11:33:43 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 3/4] hw/vfio-user: wait for proxy close correctly
Message-ID: <aHYgd9pF2V5tYylq@lent>
References: <20250715055246.422834-1-john.levon@nutanix.com>
 <20250715055246.422834-4-john.levon@nutanix.com>
 <4e4d3102-050e-44c1-ab41-aa1da2d7f6d4@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4d3102-050e-44c1-ab41-aa1da2d7f6d4@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: MN2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:23a::24) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV5PR02MB10876:EE_
X-MS-Office365-Filtering-Correlation-Id: 5037ae2a-e0a4-4460-2025-08ddc382b3ac
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sgTJeH2KwZdIxjph0UfqW5U4TjDj8qmQuch2FORasSiGfYhP3gATinYl4kXV?=
 =?us-ascii?Q?5sdbeRb43gFjPCov7Oa8jLgpBRKZFMmtee5m8SQfXCFuYOMmpEP7b8TCfuFV?=
 =?us-ascii?Q?P9qd6Wy/uCOLHeGcvvC+CEIEnzKHd24K9K2w4X+7bWkx7n4B7trDPeUNJWeF?=
 =?us-ascii?Q?Az3XOuPi2BnxV8Af+DUeEorEeLIYFXtK+Sw+RYPuPRbI+5B8kG1HoNrPEMMk?=
 =?us-ascii?Q?Htbe5z74yRlQpZTqzEDbEME0WdBLcfflYhXIy37/X3ZK66pKPQh9LTRksEzb?=
 =?us-ascii?Q?14WtpPP/uwZPgBelcAmw6PmJmrhGch8Bfs6kp+UN80ATH0pB8xJH8honwDGV?=
 =?us-ascii?Q?Te7B9CLibYP6wY/eioocbKHofHZce7EmNs4Zn10oUvhAAl23Ns439Me21dQU?=
 =?us-ascii?Q?FLF5NqtBChsFjHWWftqxEQ+AS5iAnWnYj9bJtEXb5C4KG5wOBwMn/UlgYExV?=
 =?us-ascii?Q?z8mG90NrFEN/ICvnjiUe6FQQruAeN10QBiaduD9GzIudEs2TNcmro9KyTqJJ?=
 =?us-ascii?Q?jhjEf7s2mQf/7sAqX+BXKIdUCusfWnjdmmJO3zY9Sff/kuHfq9vvhz9EQ0CI?=
 =?us-ascii?Q?LZ54rXAYWoYQIBNDkEjy3nc/4cagSqIOGMDRExBG3/VdXbC1KA9Nl+fhR6Si?=
 =?us-ascii?Q?jglBwWCp+1rsA40bVzQYJcfYzVgQgx8tmQUtWHfL3LAOQPmNB42U3Rp/mOVR?=
 =?us-ascii?Q?J9fQ+neRgVFh7FEYrR4JNtkjlf3PCy5kWDU4uB0lvcNk1WiM19Nw62kquH7v?=
 =?us-ascii?Q?5ZzOryGbqZuQEhK5Yj60q7i2jYMdMEgWjqbZBX4ru05kP++S/NuplWFGUvKv?=
 =?us-ascii?Q?dMDx9Ih2emfQlf+hQQT2AtqO+1gE21j6k7FA+rtJf3gJZ6FBweqzNzFFitkp?=
 =?us-ascii?Q?ZZZrXGJZ51YYbPlGE7HKX74RlBxB+ti28zVPWvWtzbax0tpZCgmiVJ9nuYeI?=
 =?us-ascii?Q?tDYoooZmUV7tGjig/UkNZPhDwcW0Gel4NXXX0N5pMCJ9NJFu0st48OPBkThl?=
 =?us-ascii?Q?JQ+tZgnMZUqbtgGs7mzsF3xVZ2AkD2Qhs4IzW3uVNiabbaB8I1NrrNPzr11Q?=
 =?us-ascii?Q?OnwTPNMSCjdsFSl+ivWLSfSlWhA/ZKfnGaHGA0ep7U+9Ri5sLX+RBSc254CE?=
 =?us-ascii?Q?oEJWJa76MD+qado/Kg6KbuSun+LSAOsX0+qnZVZa2PJEHPdhCZNCvHSbiLdG?=
 =?us-ascii?Q?j8a1lIwyz3cpWNhGgaptKJrqmyWbHagXlmIvGCTdkVWQUUPTax7Sj9uB026J?=
 =?us-ascii?Q?mYxr4KnNZ6KDsatc64kAMSCcGBQyoFKu49blh3jzZ3Ptf5yaazvWwWlVl+tn?=
 =?us-ascii?Q?SjnGHcRALc3tOEV5ETSxtx9mhWylpxJAWCQC0KfKK4ipgc9UpkdexLSQ6xBh?=
 =?us-ascii?Q?rByu7ao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjqkmz5kJ+pCgVaVdI2bNQVsaNL3uMrPzlqsDcTSLuRY35kRzJLJ2chne882?=
 =?us-ascii?Q?QRLJKLhCLyDD1MqOrU8Aovc3ik9cdY+2ZIUo1co+wH80wpiO9RFRAcKoIMtT?=
 =?us-ascii?Q?iLbOS8IRQ6w9JslRfnUCUS9f3UCqryAaw1pMo9TuTpwZsHR5AZ/l38Lw6Tym?=
 =?us-ascii?Q?xW0ConK4cFaBBMzfkAPgh/2o+DextiMpv+dubIm8MmVH8x9mcD2F70e5dc9k?=
 =?us-ascii?Q?1Tg6GF3M6/gKJ1T6UsxqAOqHHRjyaGmDxwI+qmpJeYVqdMMzGaWqIig1DSIy?=
 =?us-ascii?Q?ugFX9EebEWVz9i2bXvd8YvcIZlLkd2PdkCMxNcvpSYi6rnrHulmSZDcwYTf3?=
 =?us-ascii?Q?uyWxA1Fc/UWgAG+RFXGO4RuUj55nJtHuwYJ9ptutPLwSvbygq05LlPPPdsAj?=
 =?us-ascii?Q?rG+pv+/ARJBU5Q7MtN/gD8YNOZafe7vIZZppo9KtG2D9Wkl/8GcyW/T5BUer?=
 =?us-ascii?Q?ZdAnNyOePT1iiCTSseA/As3ibZB9oWmwTGJ4Ggy15FsJ6o/ZvL7UZyPFpSte?=
 =?us-ascii?Q?dQTRA9zWTQhKdFD9CcTHf6iUNvB5KOFrxME/PMCGBFkpSq3+rYrre1siU0Ky?=
 =?us-ascii?Q?aYKrvU8HKiCgeU3UyAPILNLBRqJwK1+rpeKYZtOcL9vHxKk3aZ/LC+7R3xFB?=
 =?us-ascii?Q?IjH5MabBw5KjJHUUKe+xxzQKWpr6K0qGhLP7DJwCM4B0enoT+9osQ5ytHgFh?=
 =?us-ascii?Q?5EIgGQnm9mZW+Ueehk0Kyz0dplfPuHk3YlXRqEzdLRsP+8Mke1nM0PIGF+P0?=
 =?us-ascii?Q?vuFZR+VmZfZ6He3taPDeEkIMzuWmHWoM6fEag7Xpk7FTyd0mUnkXYSpFdQyM?=
 =?us-ascii?Q?JwaguHYe2q9CcOJ7Axh+Jh9jZ5hAb3m5dpNMg1j6ZFb0gfFgBxkbMCYtaMz7?=
 =?us-ascii?Q?ZHjo+7YkW9UNGUX6XTa0O8U80FTqYy3Igib79kZH/6HoAO53O2K3O+WWktRk?=
 =?us-ascii?Q?TTQZNjcaJAq6TM4HKiigAjgCfqJxfhZQeGExw8HNCRWZp8d106icthARfpki?=
 =?us-ascii?Q?ydDhDd84lYm6L6+ftaQVsFIarhUP3cg//+Ia2nbFk5zXmEPs9U0ZHQvKMluh?=
 =?us-ascii?Q?XqrYTqxQ1QlmkqMcMvPfbRU0tM+RZ0Io6cqhmrwRqNzhD7GMQjBtGZIoZsjq?=
 =?us-ascii?Q?LENlts9SsNkSwkAfLIFa1g4Q868nJVZP0F3q8guUa/l8dtxKTCXpREJuVuRn?=
 =?us-ascii?Q?IZWvYWLuVPTDfUwEcAx95upQ17xqpxQykzfFJfzVHFu9g55UZ4lS1LypKliB?=
 =?us-ascii?Q?kRsSVBpK52fchxsq0t+8SNFZ2zBtSIJ4KTccTaztUoIBR5T+Z87YKbGCTolk?=
 =?us-ascii?Q?vSor4E/qG0CKRiJ7ctVSrfLsdA+1AhvhMw3jLvq+gKQjp0OIAhcTwGshlcuI?=
 =?us-ascii?Q?2MAJmDU8FnJrd9cDpZMMV/RcghNXSuT4KtV4eXFhz1EtwhN9i9eYr0XdY8XA?=
 =?us-ascii?Q?Hwhbf/WOuZxX15vVwhWDGpIOOEmB5tU7kR2EWwWT2zGMBEXgw21SpCh+Hwtg?=
 =?us-ascii?Q?0nOeWAE8CxsjPxcBZb/Xgn8CzoPqe9+sHG1/NdCTaGVjcmRufiCLs1edHwmA?=
 =?us-ascii?Q?aIftFar/Xe0mfpm4u8xa3PPHgWxmBDMuYRXrBZY/2Swz/kU971aYuNbPuWzo?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5037ae2a-e0a4-4460-2025-08ddc382b3ac
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:33:48.5747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU36hR6IZev/F0Y0asqS0mAzbcEd5svlZsXKvqUkFrGB5+tCQDIx0jjIq1X6SOyT7jJMNCq+yysQtZAdeBiLIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR02MB10876
X-Proofpoint-GUID: l7fV42gla25KD2XuqY--7D8KZjU8JM9D
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68762080 cx=c_pps
 a=cfTQZr9e85FycZGeDvQcbg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=4GZQBZnOYuF1tyenBkAA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX0A0CQG6MKYPU
 s8hNc0RcQhL7N7wjhDx6oM34WEDPLJdZ29NmyYGhZR/krdtRznNY2lrctSilR1o6UvkBkzSE5QD
 hSkgzJ1zbN9OFsRcrkzi5ZYNPl7i9g2PLx4jD+E29KibAFajdUJqEgr52M2I8jCxW5X1dWSkXvM
 yL3yrxt8N1YzVhA/QlR0cmIvkhyOg6OeQqdbmwOB/jnIOzIuCSz8hn8CPXzMFawj6E1psYVD9vM
 7tFTSb5p57oNCJzpYIdmX542d3CNRZ/sptsaKgF4PVPj/qBmQIF8SFQcx/6WeIgwZdV59w7UPR8
 8Doh1EFxLNoTBa8TlDhJAKzDob8bl8s1sdELDbuhgd4rEybf+5bG1m3m/v0Ve+yjiDj6g48SAKt
 h9Moqiy5xf8N8vD2QSDcTt/ixNrwSNO9nJICIatDGA6RCRA5ygFbnql/J+KyZqzThCJ5yGsm
X-Proofpoint-ORIG-GUID: l7fV42gla25KD2XuqY--7D8KZjU8JM9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 15, 2025 at 10:01:59AM +0100, Mark Cave-Ayland wrote:

> On 15/07/2025 06:52, John Levon wrote:
> 
> > Coverity reported:
> > 
> > CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)
> > 
> > A wait is performed without a loop. If there is a spurious wakeup, the
> > condition may not be satisfied.
> > 
> > Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.
> > 
> > Resolves: Coverity CID 1611806
> > Fixes: 0b3d881a ("vfio-user: implement message receive infrastructure")
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> 
> Is this definitely the right patch? The v2 posted at
> https://patchew.org/QEMU/20250711124500.1611628-1-john.levon@nutanix.com/
> contains the updated commit message mentioning the rename of the callback,
> whereas this one doesn't?

Yep, sorry, picked the wrong commit message (but same commit contents).

Should I resend?

regards
john

