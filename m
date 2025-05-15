Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A8C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanL-000175-Gz; Thu, 15 May 2025 11:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamF-00082P-Ht
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalz-0006RN-AE
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:43 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7p8s5009723;
 Thu, 15 May 2025 08:45:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOy
 n4=; b=NlGyOucS73oL6DVyHsdnO9kxonOphUfFnmeEg0ljoEnygeOr892renGmR
 oXjrH5eitha70AFGwvW9jlGVf8TEgArmOcuB8V5PQGzXc9vQc5OfC7fYvAux7mhF
 ykt1wAjyUTwOm0RNew3e1dQ10y8t4lWkq5D26ijYeoAsDROEjOzDjlYZmsxKEkk9
 y2QuApAJAoSkKAbixsn57F/ivv+ZW7mtrPidu6n6YSJRtBbUuYeewNbLhl+9qtI3
 hW90brgC6M2XvRk1bGbTbRQuQ5TRQ/d+AQpTlw6JgwHMAjgGQeqg7SCbbX9R5Lv7
 pEPqQcxdI1JO3gM7pIx7b7yXQkgKQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcwwdyw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEIPsTI9ZYuDuOT/06YxAeANq4+2Mtay3aB+fzxY9uYMaXRWIpHH9HDl/j4SYG2reJMAkCWxQFtbNtBkjXUk1+DNc2mJIqhKC6iYL1FXEo3t3L0bPteGFvm6UXVe+8E7obgzBWAKzDTfIoQD0L9oNidXt44pYSJPK7FjrRm/Ouj1s/lyZoI77MTaych6LpCQJovAExS6ot+AXlE1uG1yK2gJiY0NnRgi6zWHvYQ9xJQrbtAXBSHK7KshXWpVrvVQ+bYb+WBQiaOK+65uQuJgdJbeKfXSSDdXBAJ9fyYh0T17xBSfzubalRDr0DFSRYMz8/5xxOA4KeWnqSSy5NjiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOyn4=;
 b=qpBYWmBQYaLmDBCvXP/FCt/qbbJMtjUWrH9BTw5gwmrVrDGnN+rfEYukvEz1+jGNGTHxkyq5bwUR3arNpg021/MSs9hx25LovG9xFce0KjMqiPH0d8I69aPIIP5O1M6riutdRt9UQ6qGxOOf113ohsbUZi8uShCK7nQRfw1pa9gp+dAox7vFnFcFMO0oU4qMcXnV0PTe/tn5HTBkGXKA1ONcACxyItNThD997jI11f6AwcBhQRivOJ2LKY+XZdpjkTUDVKmkf8d9WaqP1Cpz73KbpHCmifvx4Wlxu8CJaIWnEVZPGjLvgwgHJQ1PwC407OVrfmRNX4gWC0Iu1zJXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOyn4=;
 b=T2WOEqLuNey61msYahZtJMlO2+eC2lt9raGKel+zxbvqH/Jdx6A1dmVsp40bYlLEjbfPlokLnnorZFiuHN6rWKIy7XAEK4ZRDq/7o9awxywXLbm7DJ6R//xYywmbcgHyzpvkHSo4tHj5HE0wOdc/6rIhkhNvJKz1X1x/hV5tytEVP9lDGe9QuoXeJbwKU/CQdVOR3wWRpKJilt/KXRlJbJbnkhd/4JJqI0EYVQG6ZLi2EGjSZlihDzgEDPBsHt6iOaqtjpH0QQnkqVxSgmBHJ7L2F5G/XyXnRZB+C7InL7D/DX9uai6WZE7UKb5c1aAJm/MV6DYJB9J6Tu1aWTjQvg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:45:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:09 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 20/27] vfio-user: set up container access to the proxy
Date: Thu, 15 May 2025 16:44:05 +0100
Message-ID: <20250515154413.210315-21-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 0689cd97-5975-4d87-216a-08dd93c77913
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gvdlKTHVZOY3I2n894AMZqjEiPqfEJ0htx8l+RzHC2ZN5Ky/YD9TUi7n8/mu?=
 =?us-ascii?Q?pz3fIwcCXndfmPEH/Gct0/zLhe84ZhKK7XgbsQvOLKJrRruLqoNQpINpdAc1?=
 =?us-ascii?Q?5AvSDMGfu8fXAu7zCMjTI8cb33B7LgF49eVkOFDp43YFPBTuOV6KbaJHAW7Q?=
 =?us-ascii?Q?TrE+2rG6IJdrJ9qXtPsBNX2Ffs3iJ7oCjDJC4BGbMnHQ32AnyYa6t2XkbJ0x?=
 =?us-ascii?Q?opt9R7lBB8jQtepJMvDGDl6GQmjS7F5wIBWyKjjbPuBI1Dp4i0CVes/NgDFI?=
 =?us-ascii?Q?xa6aYGlc3wqf4PEWQoh1mEl5yuHS+noW2vx/Uyzzht3o7uKItrDm2Yo7GQW0?=
 =?us-ascii?Q?03TEYmWSdkLwipo9G1mJQQ5qvf/e7iMMKWhJ7jmR0+avpdiZiVimGbRqv/Lg?=
 =?us-ascii?Q?mmxNt6FG6VKWvGvTxoZ9+7vLo1Y8h4XxL4yOheupY4gUe0UBAn3qSICKMKyu?=
 =?us-ascii?Q?JExJQAurcKPUG95Klur0T1D/lozYa6vkkWKDq96mF8lwgpMWpl3+4IaT0OL0?=
 =?us-ascii?Q?rxqvMUmvjRupg9P2at4pXWgMMitu14s5h+dP0oEBccJHNel1ZG4TiNdVJp8N?=
 =?us-ascii?Q?rIWjqfx9o65p61ji0Z/2Whdq4YoZf2mDxsVjoRnajRTY+VxdDQ/r1oFKqOat?=
 =?us-ascii?Q?6YXefY1bslOSh7Z2jOhsrTlwaIrldUXZH5lAFRiRzO7o4ZZQxOm8Mft3gvhm?=
 =?us-ascii?Q?a3RIQW6PEs8qEy2K+qhGcyngyxd3eK4ij28c09u3oVTnbwJbR2k3cz76YtvA?=
 =?us-ascii?Q?B/VqfRhNaFnMQwRKzmsGBKYgJjnpGGxdPjFy0sYSs8LKP8/hD7bKdLybqacd?=
 =?us-ascii?Q?xChNWN6mJ2gTYcqwdD60zrv0pDJTxECkk2MefUd7R+t8KnHgOUegxVgB1PuH?=
 =?us-ascii?Q?m8zxcAKfXAbscaTNFRH3PVV18nNXsDKfSW49H+8mgWR3vhg3EXmMQBjylaBN?=
 =?us-ascii?Q?nkSE0+RfnTJ41QiwmDCqBZgyDLKSgJsT2araVy7yRfk54KhGcPT7x6/aESPi?=
 =?us-ascii?Q?uWEP/bI4/NF4G2ujrd3S/8AQW10UGOaYU8LcHLDXdf/2t//xH7yr4BRN68AK?=
 =?us-ascii?Q?a5qdPKRyLl2DRg5zciWRiffb/ikE6ZPWAz9cSnU0Ni+E0Gx4L+ysLjSSy+6s?=
 =?us-ascii?Q?WFPTYcPm6AXlBPtRF1oD0AWQ9vdgUqxNASltVJSR0Gaf7CvvtEOpo1UI14vU?=
 =?us-ascii?Q?YYs3RzgfSFGEu6FFspU0NJvHjxXAZij1fXHoRYeAWVbnEQ3tjfKb4yC618e4?=
 =?us-ascii?Q?PIGp2IXZ2MO2+73IqVMpUrJ25kGBHLCNbIu8jQ40rDdsjKCzn6VRjQ1ENv4f?=
 =?us-ascii?Q?FrDdlqAJLzqFjKVtOaXcphEh7Kav0hNDdjr9WFuVtG3h9SuexDgYD1Z11/fE?=
 =?us-ascii?Q?YI5HIO+Y7yCEy1lKyOzV5sSKgsBwMdT9BXfMNzKD1RXycf5NnvRSEhQY5ott?=
 =?us-ascii?Q?fQ3Prk5hluA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ua77jbLPFmGAJs41wvXgGiFYDp6hN5dpMaXJ4MT7KaQqXnNmclRpXv41o5Lm?=
 =?us-ascii?Q?9eTfrbJkdFoslHafHqfllKrI0GYJ2O/gQEEhOaz3vibRERJ1hRLcWKNE/W46?=
 =?us-ascii?Q?rRinUd0wnb9KI6gV5Mhs87ZhUQoWRs7ZgXh1sG17az3pxGg3+tFsHUHD1U/f?=
 =?us-ascii?Q?H6erU5hFHj5mRUxjIiKQJJIIz5maHflNGalGPEQRkg7l4tHf84EQMFGL8gID?=
 =?us-ascii?Q?jWuBJBd+ciK1rsk2xt74vcsbhVI0poB7SnSQIYt1LRutihKnkG9gB5Rtywh0?=
 =?us-ascii?Q?1fWjWJe2gWvLg2MRJMGu+Aq5van3NZzg4XkVw4pDYIcxLCHsYIdfXQXEiT2L?=
 =?us-ascii?Q?PgfZJT+lUS4VWEB4HvR9g1XkOPfh4gwxswtkVbYZ0VRa9XQkZTx2XGyqqnqi?=
 =?us-ascii?Q?vTuIm5dy4L2G05JyGo17YGyFAasxmsga7PUtwp8dk8FdkFNYMXqg5cxRGs0S?=
 =?us-ascii?Q?3OMcWzOxJgnEFf3R6Ofyp3r0gRgCIEMM8clw/NeXzdB0Mx7WOLZI8t3Dx2jy?=
 =?us-ascii?Q?ewlCWz4cNyTK+MAKM6rsChbu6Xf3VOclnnAuYzK6ihvt6Cv1qDW9b02mg+C7?=
 =?us-ascii?Q?OTUjKrSRjXGB1kEpIsSNtJ9IsxNp4/iUs/TixXSBlkqVuBoL33AIOUaF3309?=
 =?us-ascii?Q?2DnV9eKGWBYd0JWj8PAj8e5K8PyrcMpofJuG+4wyVVVgIl2pMYo5CRBImFvj?=
 =?us-ascii?Q?reMlHG/D8KZXYWC+mPmFfMXuB9HSGNNd8pGNAnYzA81zSGp1j4o9bWJ76iBu?=
 =?us-ascii?Q?P+FTSVNvnwS4ngIdUySE1dlPmlhogbNalumvs4DGqs+BNN339okZZSMSPwLt?=
 =?us-ascii?Q?8fuUJK1NuYgESd8GoDak9sgVV2RQK2ZTA1NBA8rTeTqHSn7snNLUsZ1GFcjy?=
 =?us-ascii?Q?H4W3q+gCc6XXoR787A8Ib7q2Y5FVoAmu/2EiVP0ZpwzOsSP/O7li33q+Kv2Y?=
 =?us-ascii?Q?5xObJw+zcP3uVRf6eITeTG3ADTGfxze2abrITlwBVNPKcyS3UD6uocgaQQ/Z?=
 =?us-ascii?Q?1/WZHBLw6MIiWgtT5jXPXamMfdRAnDQEIYdYvcu2kx3Ug7xY3YvAtMquQJ3O?=
 =?us-ascii?Q?6z1wUJx/4o5PqueMdAje5Ckbew7dEZygoR+CKxneLl02z8iI0vh6NbalAcR7?=
 =?us-ascii?Q?MFkNxqjIgt7zjjHrWYhLfzZ0cHaC6gNz9ReLOuVtx/A3r70mMJGPUN2dIo0I?=
 =?us-ascii?Q?DTKmc5NYLUjDaHPpeRWxcGdlE86yceuEFHY5gnMRtnME4e5VujgMayEUOBBd?=
 =?us-ascii?Q?jKJWz+2IXwASnH5Xe+XOHmf1eESLzYd7zhPBCLjLUwpaO0iAYYmpahfXynen?=
 =?us-ascii?Q?3JjXZ2IfKnBDszSuJ3LR5wgx53yhzmgFcXoSwx5+AdEWGdv8R2oI5JdEi8QB?=
 =?us-ascii?Q?T3nPRDLc7HS2XVqVdQb/idHc07Hv+yGmhIjFmPq5QMtboPXTuj5lmjVe6DEb?=
 =?us-ascii?Q?WYqWCr1fX66InEIgGpcTA6NEqqY+Og0VWES7Epno5CUqn4TKzdEjGBdMCuV0?=
 =?us-ascii?Q?ofctBABxyUDVKBB3VWTjrwi/ezd7112SUwGaoq/iZoTW6vCw4bqgg8UGQ7CV?=
 =?us-ascii?Q?7QRstXvWwbnDzeRr76vY3Z1EI0D8iL6Hd7lUPsf3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0689cd97-5975-4d87-216a-08dd93c77913
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:09.6886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Jl/dRu1WYvGAPZ9KbME1rLGVqn7CQdDcwvOtGzPxygSGfAiJBhB1kn91CV7+XGl//XuagWnG0WimelKQzX/6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-GUID: zbJq7kCxITLW43RRuleNrS2AiVLdOXiH
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=68260c07 cx=c_pps
 a=CbxOEkXH4sIw/lcH++vrDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=eNiANMbe5KInMaSQXcgA:9
X-Proofpoint-ORIG-GUID: zbJq7kCxITLW43RRuleNrS2AiVLdOXiH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX4FHGV9HWuOtV
 yvGYuERQn0voAkjPdVHWpli51FOZxAmpOpX9u3jZiDigKwVDoNPspKqaJudiZ3ld7a0WZppKeTv
 0PoPMK2/WxZkGLDU3lUp4E92G59Rovbei/SXXi0fWp9tlzkwtR3Y+9r2GLMRfsahcNzwPA6QdeL
 LDiP0LutLoZfzOAOviEUbQMG3KIQOYuGwyPR2nXNzZ9+8F4fec4rWk8J0CqM7ixtiK267sUvAN+
 mU3vAWnbxPBmO6Se7exAoJxnl4tqbCvL8RVNaB/jIEc1QABm538cNDF0ZiW3hiwWMUl4D/0N3PF
 n9bUdcsRg3GXtyqyoWaOwIWWFg1B4+tPi262o4tLT2aB/73Z/j0G9fQqRfB3fTk6dQrz/f7KM76
 7jjteFHmLuK+X8NSZf27YwEOc2SOx9kvippM9GR9+SCoj2R6BHUYSDDSAWa2N4WlXvlZouiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

The user container will shortly need access to the underlying vfio-user
proxy; set this up.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.h |  2 ++
 hw/vfio-user/container.c | 43 +++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 3cd3303e68..59e14cf5b3 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -14,10 +14,12 @@
 #include <stdbool.h>
 
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 6f0eb86a75..38e9cf8d8a 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -53,15 +53,28 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
-static VFIOUserContainer *vfio_user_create_container(Error **errp)
+static VFIOUserContainer *vfio_user_create_container(VFIODevice *vbasedev,
+                                                     Error **errp)
 {
     VFIOUserContainer *container;
 
     container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    container->proxy = vbasedev->proxy;
     return container;
 }
 
@@ -69,16 +82,18 @@ static VFIOUserContainer *vfio_user_create_container(Error **errp)
  * Try to mirror vfio_container_connect() as much as possible.
  */
 static VFIOUserContainer *
-vfio_user_container_connect(AddressSpace *as, Error **errp)
+vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
+    int ret;
 
     space = vfio_address_space_get(as);
 
-    container = vfio_user_create_container(errp);
+    container = vfio_user_create_container(vbasedev, errp);
     if (!container) {
         goto put_space_exit;
     }
@@ -89,11 +104,17 @@ vfio_user_container_connect(AddressSpace *as, Error **errp)
         goto free_container_exit;
     }
 
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     vfio_address_space_insert(space, bcontainer);
@@ -112,6 +133,9 @@ listener_release_exit:
         vioc->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -128,14 +152,15 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     vfio_listener_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
@@ -169,7 +194,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_user_container_connect(as, errp);
+    container = vfio_user_container_connect(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
-- 
2.43.0


