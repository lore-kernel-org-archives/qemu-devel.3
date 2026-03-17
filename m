Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2859FEDA1C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aUG-000618-Cu; Tue, 17 Mar 2026 15:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1w2aU5-0005st-7k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:53:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1w2aU2-000742-Qw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:53:44 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HH9Elj1688081; Tue, 17 Mar 2026 12:53:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BXZ9KBNUyOctD6qf5Q5LppfprlFwWwQgyPD3iJPR0
 YM=; b=hizEiXeqMI1yxhS1TV856WxPRKdj0bENR15qnuhPXGJnIrIHGkX510uqt
 NdAfwcfkBOfhFFeW7PkOpluZxDXOg11Z8UQbw85k3eNSuIpOz/gQZl34AL+NvAYC
 gtSSQAC2/4TpP+4EK2PV5rk7iPjSYloJns/DxZT1inntFvzKM0ZPfNiGLkzb8USZ
 Zgxr5RJaAXwutKNlfMi86R8/KcIToW9aJJG+MOeQ4b7mgOms9BQqMPFNJahVF4m6
 IgN6bfp0OGq6HQ022ZDy0CA06e1s7aRg7EJupHmbX44E0IHW9r03pI6G0Ie+oS6I
 b1tpznffwnrjnfJza1mJz5PJIsf+g==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023100.outbound.protection.outlook.com
 [40.93.201.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cyb3wgd8a-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 12:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO7RVZ6Tw4+MtI3RJdc1j1o54h9VuKob7L80xGQ9uOH7vzAA274nnm26HR0i1h9QYi3xHZeI22+dL8fs3JXw71H2qsfofxLFXH/VKIkgKUe1zonBpfPuuNFt7mT1awzsZWlvdEjsrw9TwRYcV6A6IWeAnLTOjk1ZFaWQ8RdQdP+t+LrbjmW63vjsB/6vJ8hDOLPwDDSazV6ouFyE0FRUklurmJXkxLgEkzlfQs6XD5z6qvNUPc/bq74f3gQ3ETl8hsdletkrZo27RYgcoCg9XuicdNCloZK1BKKu4OCVH1pIc+PnInPDwUZkK68CLmgG1j2DFr9ziV4sR08w72BqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXZ9KBNUyOctD6qf5Q5LppfprlFwWwQgyPD3iJPR0YM=;
 b=bojF+TBG8/1OyqRjP9FHF6e3zoP8KSxFucutwBGOv1Lbs7Bnl8wSgsm97MRzk/lYKB0b3TBmGDLmBFKvFgLHtqfTbUR3Kczh/HSyAyhzwx5Mj1jzH1gQRALuII8zErTXCAB+xoyxOq4jeIc+YUwJl7esF5qQ8/692zF+eASQU8TgPehsTMiOIvrV6l3MuhTJvdBV+c5RVVGpEzsP0DUk6QyfAicTcCw/rOgzRB755mMBqjNUlcfZ9XRG2FS1M7h4U8sCyXu43sg/8j382C5lB67lo2X9ELS/BWzW8Bnqt/Ynxzb91z9hp3iTeU64SAL3W8yPjHiHoPIKNANErnfxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXZ9KBNUyOctD6qf5Q5LppfprlFwWwQgyPD3iJPR0YM=;
 b=xj4d/SBgQsp8jyLmGhpZHO9W2SRqRPB9m2qmn4tbqeiau0JdjHYDVCFcE7b6DE1MzzFZpA5qBWOCJdaR4/9ksYyxI2flJp+F0fubMqRiT0wfcxoHyVd4ViO+GkB6oG+PZRO5ykIJD4qWCJ0OdSNnyM0gRUsnW/sprGs6xtaNH3ofZBpMjuI7/NXie4M9Kxwt67gyfSQw6EocMm74SXLW+gR6p8Qtr2iV+nm9c5MJniUzLI6T8cF3SzX5YtI4H8AC/udu7nJumHNyObJoiHyBvCIavw8O7IbGMzfF/RjX24lQWV1OZ0Mqey3mYKs3hyKU8QnWLMr3zC2BmdkcoGmeyg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM3PR02MB10293.namprd02.prod.outlook.com (2603:10b6:8:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 19:53:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 19:53:33 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 2/2] vfio: quieten dma-buf warning
Date: Tue, 17 Mar 2026 19:53:23 +0000
Message-ID: <20260317195323.776669-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317195323.776669-1-john.levon@nutanix.com>
References: <20260317195323.776669-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0631.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM3PR02MB10293:EE_
X-MS-Office365-Filtering-Correlation-Id: a5222145-f431-46a5-9c9b-08de845edee3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Qa8wqUnoob9fFJhELzPsrqT/hcji7Tvy6Rtrq49m4MXA3rPijSoIkEuwzc7Ou+BDPvgM6JJHsgvGf/Zx4r1xTkzvxl/0biAwT0GODiYTOjNgkXCjNWRqZivn88jzOCKDMx6/hguyZrBTlKcF02PxtLg/rh41U/9yuxPLu5t0C9qBczRbwDb7xMCJu0ZxxupUOq509vSkngiUVoqeM1Q8chsu97MymGcIBEGz+VQY1xdx4p/OajB2RytvPiUHh/vCBnrRX9ptIh8wN06es7wXG9TaPV+No+vDJei4WsbUndStwUUnwaDo7bdRTrCLnaDuCxDCQWznp77roBn78A/aawP4USYwOHCmDDVjyYPGedmckSqKqO6GMUglJMTRGXGI2aicCB+U0yrXBP725JEZs6FE/DAHfnrBy0kgr7ztKSKmy/+y5ukc/3NzBTwL2h7ytHOFNeu0PnJGvSPjlJXPwgI/KIWxBZegpqtV50kBiixAg7arDUxrUktFweTYj/QOSRCIfrqy0gHoO+r4lfxCrGOd7S59+CsBHjGplGuxWjIuqGQO24JHj3QCAha2uxTYU/pOA0NO+OJFcsjYX6/fuUqAeGul2DWR+J8RDxg2F3g3Ll1d6CVV6XM2NV22FeD799q6TXAMQ+PSLUEStcxr2iQI6cgQqMFzRCavfekBQhGhwctyFOTwcjqhXSSEsQ1EMj87JxxMoc/VaS6uClMat5fUT8Ig5+viQsIqP8cs+n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gedREOs6eMQ5CtOPwXgKu0cgHxDURlSrVtKbxwp9sXqf47OkzWBerC/lYmhf?=
 =?us-ascii?Q?o8IHMmWd439mv+Ug+6o8hVA4v0jcIEdG0PIStQB6MVIgTz1hkGSRnEHilIpi?=
 =?us-ascii?Q?3jaFslaCiEzg5iYJole0nYTjupm9Eyc78xzNIKfq/E9ZK5QWffvlbRNDCrSp?=
 =?us-ascii?Q?zm9t7viW8rTn7YjeEp8sBXJMs1NPFhedRHhxDUZyMC49lKd891aqkihdfAAE?=
 =?us-ascii?Q?F8L/zPZjmdVX829QHW5OrRomOCgwC6mdfZDxXErHT6xLQTzX3yl6ToImHpLc?=
 =?us-ascii?Q?/L7ONwpU3iUITNTcOj4cQNP97qEw07siNBjXQjKSfw1L+vKvVQVPTSrMr74v?=
 =?us-ascii?Q?7gWxyDySwGQdsQTFFz9E9AFMvuyY6a3DtPEhbkY9UxK8pYIF4LiebdzKJKv/?=
 =?us-ascii?Q?91BFLFGJJiRaOj9DMNo1h3tkBgxChATf6656e60KpCSzzBbayYZ4vvLlY1Ah?=
 =?us-ascii?Q?buJ3sGX549aA7098qbL1FcCKE8NlJ9kSkrX61DJKVWz9PMdnPwQGqZPZEIPS?=
 =?us-ascii?Q?BrTu7QFO1tB9LZRc6+Q7FK5X+VQhbMmWYo01Q4if5GSpgG8bJLzuNO/i6nRW?=
 =?us-ascii?Q?lviuoY8uLfpyB+8ri3yEhOTSsk7x2L+9bzKkAA4PTFw7E/IPcyY4a2ZTcni5?=
 =?us-ascii?Q?RCpN56Y68orqrN9d3r8bZ3YL4sPwzY1rEU8M9D3CjnGkkobUEZgRNmkithbJ?=
 =?us-ascii?Q?/LV1Qedu2PnXg8rn5IG48LmIW0v/HsdCQmT+0OIQHhUf/lRShAEtULXxKqGO?=
 =?us-ascii?Q?4Q9R/2AHGDj7XTWJ4A8mPeslLWrpiDihTnRJatwbQeJYTmNzy34vVOoKsBOX?=
 =?us-ascii?Q?K3gPeaDFtx/RLx6qRxyyckQ8AGtZVWvM5R+p723S6zmRl/iitAJWOSLD2usC?=
 =?us-ascii?Q?RODqGqBE7+7A0cb+rGfoRrT1K1RRJntuqzvhcthgCtObpXZkmLKZgrchVydy?=
 =?us-ascii?Q?8hC/VlnK4sYGHC0+BaKSkIdBv38ns2j2f243FCst/kjefTsR3LF4UKP4itUw?=
 =?us-ascii?Q?aVBinVNCPmadNw1z/aeAGzj/gAajtjABewTlrRD9hYwf9NDUTLakjp6RTLZl?=
 =?us-ascii?Q?p/BVQ3E2+F/DlRq0uAr+AZODHbdwQXINzjUP5u3xM3l0vfosGhWN8G91P6Vj?=
 =?us-ascii?Q?n7375WU5vHGT1l3/VxjKudkqZ6KbDgynZAXe6s8ZH+sEjaAD8rG+wF3qNFTE?=
 =?us-ascii?Q?ePcXnaayGeS0c5c0qkY415OuunuY5hF9jE7vG8Ca65THD8Fs0lMspP16OmZq?=
 =?us-ascii?Q?FfMfDZtnvpgjLcQHklpB3Hgu0/h4HaNLf4NF2In5jxClGNgelt/4u5KpYboP?=
 =?us-ascii?Q?ah9s7O4AiwX0RC00mFOLAqKOijA3ETln5j8DaznsA5ayKD66wE7EQG6hAtdz?=
 =?us-ascii?Q?fBdqzWlBTKliD3syaSb2qVTpj9AC5IFUbhrhcVsDJHtK5MJDLjJ4dPxduBuE?=
 =?us-ascii?Q?ZWmQql417/bllie1mecmsGBIBcZC6smL4y90AWnztTixU2rsDa1iKuBeL1tO?=
 =?us-ascii?Q?zTz3u89HIZIEy3QxxX2kGAV0dwDGtwQX/lziqVufG94gJhzwXNNTch4x87Ex?=
 =?us-ascii?Q?F3C7JPcNy7WYVB+LsMmSHC6baakpqFVQlGZ5FtjZc9tYyQIChyI/m5w9WROL?=
 =?us-ascii?Q?fWkZbP2dNNdPz4S8PuUyt/kvkfHJGScwrr0v2pXW2+SiMcNGNaFLw9n4hJFv?=
 =?us-ascii?Q?lT3tuufwIb9v9ztczLRhylEDVzMN2NZCyKnvHdA0YFrvvR3sZ2M0PZM/3LcM?=
 =?us-ascii?Q?CW/As4t5oQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: OlCSZ8g04M2UY4V2+jyY/cRcVwx02aB/40WjT+3F0npj3/F8SAQyIIwzX9r3Fzifc04f6FTB3IQoNPhegE6sb2KsVVe+SJ8l1/X3eyZ2zAEBJPVhyWi9xtZbpLObsqX+J62skfEK6I6GMGbhvoElhQvGHO4RnVkviyYGjYgy0oDhH1ybD5Xvzaj0Q3K39bB2dIwk2Ma3Vz/kJuFQC4eHWPEl++rwT/JTM23gxummx/dDUMEtJP18LmGg8tRU0RKRdKclIi7yvBb7eeUygAfJ/rxL5cPsGq+rXKm0yXyjHui/+chnMRU57PhIBgIZ0BbzhnXXuJ6SKepJU/0ECD3HLw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5222145-f431-46a5-9c9b-08de845edee3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:53:33.6708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22kC4nWgMLfwkHmii300nYU+OKfp/qK8U4I41eoNdj1B7eZ0qc1MxmqR0o7EEDE11lgI5eQsCYkNsFZwt4bCUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10293
X-Authority-Analysis: v=2.4 cv=Wv4m8Nfv c=1 sm=1 tr=0 ts=69b9b144 cx=c_pps
 a=RZStT+UEo2YVQxgsfJfMbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=ZvC3KvmxUiARhCqauZMA:9
X-Proofpoint-ORIG-GUID: HeG3n1d828_GvFYkb0lfs-136-PUZ3YI
X-Proofpoint-GUID: HeG3n1d828_GvFYkb0lfs-136-PUZ3YI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NSBTYWx0ZWRfXyBaFZP4VWnh3
 i9Bu3VeBnbU7NIuFC8Peq7COlWyeRt1iaBApkZuvN6qM5Px+gEW5veMJF6q9T69rf5TA//yp3FA
 XA8Ds1qHLMKIKvEVX/KA+UchWtfxm5RaBqtIQvoQmEHjOVbaPIRM/UeEpZ+Mytp9qDYLuUd2n0x
 39oyOe1CDHFcNPDKhSATPB8XIo2Ho6qlWx1oreZokuwudp4CVMnkm7U2t8m4MM7xcjQE7/uXCpq
 HJHB9bOmo0iuItp+axEW+UXhw6zeopHUE1i4Vh1gyPc62yfs4EEIrh3PeIaMHFCSc8gVG6/X7PT
 4V4IWI9igtMzra3tya9lr3GaxdkCj85j+MhGyXB4l4/M7oNTy342lqzhkp8gKGM0qniAyipxl+u
 T7atUGHhnkgcUTfcNSs8PkbE+PB/w7fuIOSKsC0rLuT3PMIhl6g9+eDrm6g96G/qPGVvuNZG0K1
 THHLvOUtcanOmKOnbXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Don't report this error every time, as it is specific to the kernel vfio
implementation; we shouldn't warn about things that always happen, such
as when this is backed by vfio-user.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/region.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 47fdc2df34..1d442f3f48 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -316,8 +316,6 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
     ret = vfio_device_get_feature(vbasedev, feature);
     if (ret < 0) {
         if (ret == -ENOTTY) {
-            warn_report_once("VFIO dma-buf not supported in kernel: "
-                             "PCI BAR IOMMU mappings may fail");
             return true;
         }
         /* P2P DMA or exposing device memory use cases are not supported. */
-- 
2.43.0


