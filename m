Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57625C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIg-000845-EQ; Wed, 30 Apr 2025 15:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIY-0007ux-Ce; Wed, 30 Apr 2025 15:40:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIV-0006Dy-PF; Wed, 30 Apr 2025 15:40:49 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHenkL030287;
 Wed, 30 Apr 2025 12:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4V3KAhpFN9rZ4BExTvd+54vQcmDN9WL4MkpPPpLJG
 P8=; b=QtqlJq+eP8g335NSS4uIJLNxahw0EVyDvlGFcDfw5wXGUiB8bAKgWJ0N3
 6py20TKTvFm8SIy3IxrykTRWEMuSiMSEdSOfaTLynV5GstrIV/fVyosS/T/SikbA
 f6FFSd3WzQrpbxDgehv5Rh2cJiVt+cLw/GRESJYs3xkg4p6fiyGCY/Jc/8rHYdGh
 QakqMvn7fLcpV3YJyLC5G+HRVccIqhzCaRJSp/UflTPaYRKc9aTIVAfq3tGLR6II
 gFilXkctmD4HbAeWgxY8+Z3CTPQ+BAOo+YxKx3orHPXHk4Kaf5sx5Wf8oqoZH/Vj
 YjzbG+xUzk9+jLdKdyaVwTdr2IPCw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010005.outbound.protection.outlook.com [40.93.1.5])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468utu9tqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6daMNgrdtwvfyDanO0E1xGR5NJIZ60KLcZYBfIebyppxjUTY9fmLKziaJWdCA89fW7W6qK/MZEoyWKIYVfJyVbfpwOOl61LSitncpz2ze7mQgKZtBAe++rYyVUASFz2RVG0DhzzcTVx9xvpqgPjl+bPk8EV/u5f2Th7d3YKwArupakGtqu2fdM57/XwC4igbSKe3kxmzLzZwceBtR/RcuDIbs//td7Mr8GPu2V4dKvSc2R2IlqRbUbMaHKyRQghVdQf25oukhmx59mKfYlyN8ACnv8GTblIJHGZxKv7sZZvLpzL7IaSIEkqx0OEV1gfTdaClpAaO0VON65bCOBn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V3KAhpFN9rZ4BExTvd+54vQcmDN9WL4MkpPPpLJGP8=;
 b=Ojmx5MoEJmLHOdXXeV4J3z3v0kEoZTb41P4kCHgk8Y/ZjWo9Hr/42+otYgoRG4YcNz6MTz3SqrhmLbQSCeTD71f1IER8dNP/4l3//bZQEMbem0AMgJoxp8qefYi4LA/GEB+INbyGVLuBqclc/22xqbVBrKnMfWMDPPi5LAkClbCZvjHU860IY4ZzNiCHIuz/ZxaRc0kKplyt0QY4Nu5qkg8ajjDcqs2coNyLJ+gNbWMuhPAZgnU5rsqd/wx8Q2+KuzrFdoonWmrm59t4kuenjsVEEyXnD9IU9XfROU/HReJD9UV7rKdSsI+w881rb7eFZSrkSyV53Xg/bmgK07FV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V3KAhpFN9rZ4BExTvd+54vQcmDN9WL4MkpPPpLJGP8=;
 b=b3fl5xZlxiDPr9b/kVr6jkfWhb6Zdb+MWdN/YMptlgYVMWgJuyIh3M8W5bL/Ti+4XgVgmZ2xbg4YNKxPhaJ4X9CpMTU2z5DCTvLqM8vs4yKMYtIBi7pbQ7EChQn8ZmebotjYPnoEbzXaghzdJ5IL9A3kcTQNCB1XDI47KKvMJxnbm/8UFdhgBSitlBGX28r0RHEwWcFSxMvssYkgWSbVh5iDOD43HxLhuHCZYDLIZkH4Luz0X4rUkF7iT545lZi2Ppxszvrv0t9lLKLSssD6slo1ftHEdKxsUmFzHVK5zp1UIr8lw6jZdnxDTuJiDyhCsA66TmGWxrhMkfvdb57XYQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:41 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:41 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 10/15] vfio: add device IO ops vector
Date: Wed, 30 Apr 2025 20:39:58 +0100
Message-ID: <20250430194003.2793823-11-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: b43f50b4-e86c-490c-ddca-08dd881ee433
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jSPjp0Fq2uGTlPCQ+2QjibF2/vcpCIMzS4FQ1lcHhqYsdiDEDqVlGUnfYw2Y?=
 =?us-ascii?Q?Wz2ow0juH/7iiXGQzobvZm/jU8jrVhP2sMz0d7e1LiDdmWHzfuYksQyu70Pj?=
 =?us-ascii?Q?NMxnFpA+l0WfNsc7NvsFgqKajTUCZTuxnQyQAT08ffy7RMPCzQYE17mpa+Ul?=
 =?us-ascii?Q?/JfoqO8lLOwLjNKUI3ckwQJAxDO8erWrsFrMUnLV/aBjtuBVlf/x2kGMabKq?=
 =?us-ascii?Q?pjwTpl1S5icib/cYbBK7F0eBBIwPkcQlZfrHK27OB2S8Mzy8oKox2fbtEP4G?=
 =?us-ascii?Q?5rJUStjwnzJxJKvE/Nt728M6CTyu/w8Hzy19BnteWCpCkhcHhpIxW3kqTrIo?=
 =?us-ascii?Q?CahKiccvfWijvL7Gzi6RiJX9XtHZxXeg1a+adYixV9/Jox4NyZmxkRcskfOh?=
 =?us-ascii?Q?pjUX3hj2Q162Kvtwq+Shxg/+HSxoZpJYSrcJYzGutU/LT6/KHl/2B9zf99NV?=
 =?us-ascii?Q?VWUFUOT5qI6Uz1BIVXhVVa9EE8TV5CxNRXkdQ0hNM9tVMTy79394rTyWCL6N?=
 =?us-ascii?Q?FDEGYvc4QcZ3wYwESNWhdRK1Q1KlZzf5FLdIcgK9FdFJSXNxPb/L6bpK7Gvv?=
 =?us-ascii?Q?V+TBS6NsjrlJi63HnX+DpbSdt14r+1KRT621dsLrxQb5l5AXUir634lpv+bf?=
 =?us-ascii?Q?qZaejX4/JEZoxzhmIUJSpG3piDScHvmmCxinUK/NcRN6sH+77R4bcnBacZ7v?=
 =?us-ascii?Q?nuQyO12WcBa5mL++WqWnOdjMwO7VA/Efv7RdJcHhvGTq9M6v9nJv05hdzHXX?=
 =?us-ascii?Q?0Pz9BkJA7zrglG8BDitCC4/H5F6JHM+IOcCyspbDp3B42YPwlWUQwkhOZDlQ?=
 =?us-ascii?Q?QE1TWvol49q7UptSvtkgzCJENroVMAqFtzNLmFrPEF76341VtFaspJc2bPNW?=
 =?us-ascii?Q?f0ii845S26o3JKU/v+Q5j0BKeUKvezCykIRKkeXOWrB3T7erU0R074bN3YaY?=
 =?us-ascii?Q?F7Y8bVFMRfcX5T8E19mwYpoEBfNWvVMxtWOc4f/Pilk6kCTS0DA0OZQ9LZ0y?=
 =?us-ascii?Q?ngzOZQIQIaDi0/lDSBI2l8IgWtwipUWncIWP850vyanrvCu+akkUYnBh+Hvw?=
 =?us-ascii?Q?/F5xgY4duixRGv9N8tQPW+01tC7XqY8VANCSg2lob29K97r3skBz6/AOHvcv?=
 =?us-ascii?Q?JaEtKxrtppIFm/QB2Yy/+HrNT73CawA0UNSlamv8VpG6bRdsuDtHebfj/GrC?=
 =?us-ascii?Q?HWcEbD/mLXJv9lKMtthwGjD2kRa9fiZ0fJaf+yCY8hsHGzrDaUuMKBXmJyG9?=
 =?us-ascii?Q?gjZtPqxIBXhM997S1Xc2+cmFxOV8D/zG2E0VN5hsVOUzQaDnP69kZEDGB+R9?=
 =?us-ascii?Q?/aqSJ8NsfDt6PipvUD+p8+yGjgIsBVjKDcOEYsmKUguAiT4t3Nv5UIi+5fos?=
 =?us-ascii?Q?Qj4s/pIbCnV/uLLTB2ivTg2d6pY0p9A10SIEE9/WI/JHRlm4Nlod4b95r3Sl?=
 =?us-ascii?Q?Dyg5RivCX8A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83dFGMQVGOXU54A2Zf2HsnRL5xCc3kq7J+hIJPz2XhKZqeJHtDwoVNoBokWB?=
 =?us-ascii?Q?V5EvL4xmaAqj5SLSihwhjpjpkRQ76gg+chnRLCU7MBR+L8wrak7wovw5bVAR?=
 =?us-ascii?Q?GQsXC9O+dngd3+Z0UKJdhe3BIizsOr2f/HrsMg9V/ah1gSVlhiMRDqQ/0qKe?=
 =?us-ascii?Q?G5ze5T1+l+dUAOdTD8sU0r2KihLhoal83LjIs4Y8QfyfJ7fVyWqFF+Hq54pz?=
 =?us-ascii?Q?fUQ9/g1ZkAUwsV1dP2h3aMwULMNiWp7a9d13ZAbMMQM4RsjsQHLB6AJe1AQv?=
 =?us-ascii?Q?C6mZS7EIIvpfREb7yMjypBe29SGgerDAiemblOBc5PA/Ws9FInnARQVBBqCE?=
 =?us-ascii?Q?WgIak8HxL7CFGG0cY/Q+6qCNGItpfxZmW0sVSOv26/zaC7wrm9SXQsePPGL4?=
 =?us-ascii?Q?UvQk+I3Y+yaAgYFWeepIzbgEvSAgwjgnmfkG6XYO9cGgpbMP6mI/NdK8XgQA?=
 =?us-ascii?Q?lonHx1AaUgR5pHJd21RSGVX2//1kR7Y8sT7h6BbKwAUjuT0CIDtrNzo+CyTh?=
 =?us-ascii?Q?SV4B+5/QZqa/Mu4knFuqZWDXWgNgiPMj1V22+aTTZ4q2ybzSRYtDM2C4KaS1?=
 =?us-ascii?Q?+PRXl9uYI7/xKGEUVZezLZxMbbwVa95jyjg6KhL45QJlKWr8qubuNp8Gp2sJ?=
 =?us-ascii?Q?PmtGNm9XSNjVUql7qkKLxg7RQDFwrwBwz2O3vxX/e1tc1sirDVL+B+PCafa5?=
 =?us-ascii?Q?hKItFCFOXcG6eaKpQkM7OTZu5z0qWXwz2W6VdwN+AzBcRTDSpQ2CGLH34whQ?=
 =?us-ascii?Q?uo9e//CexjwDagy/FHBhk4Nr/bKyYTkjaHN8QcciDS4Z+N15I4vULf2CnAlp?=
 =?us-ascii?Q?bJVF3g1UmAxtqNBeFyv0KjIYYgNTHqwY23VxmmZGV6DPKH/+sDi27JLaHmsb?=
 =?us-ascii?Q?+/YKuXwPQUxs4VG/Jv5oZ0Dwf8RdPVuY8z/hLdSLq8fys+1qknAVK9wnFWBM?=
 =?us-ascii?Q?mOdUiEI6VHicC70KNEsq2bwGra30p7l+zluou48OUPN86O9LcnC5dKJZf46S?=
 =?us-ascii?Q?QxXAHCpSMcfsJDIynMx9pJSk06Q+bDdtft4Lh5N75tv8S7Ozrjf0g9sIVvv/?=
 =?us-ascii?Q?i0+waJg5DM5q409BpR5fIXi/DOzR4zcaJ4N9QXkJckCaMd2zlsEHig171qXw?=
 =?us-ascii?Q?qDsKskoj53N2L/mdTtGLz7jF3kdhqWgZG4t4VzbLJZOnurKF8UZ/8JAfm37f?=
 =?us-ascii?Q?GqTODULt/e80p6dpUoIdvUmR22L7o/oYReHh+nTxCO2TJnB+JLQXgJ4H7UqP?=
 =?us-ascii?Q?7+ssDZjmlH3j/vbWJ+jjWYwNzAVemdyHJojklx8iY/OO47R4uiOsjj0nOn6h?=
 =?us-ascii?Q?Y55SjbJq7CDoI22FvcFArO+OwWtRo1pJlUpOm5nLVKjHhXSDmWMbIkQOlstI?=
 =?us-ascii?Q?+dRszAaT6OoXIEFFKb/DHN+99vJ+rURsxYYkkArEIB9I4RVpXLp+hzuDxueK?=
 =?us-ascii?Q?iiRRA1XE5RxgyD2+YDXkPCm/Orl6ak9HEWuoVcZEAavGKczesiJLH9iXBJpL?=
 =?us-ascii?Q?YBHLoeO427Y/vCsH2woHjMQzhyv0FaK9C7FpzsAF6uAudyviu3o8HgpfXO/G?=
 =?us-ascii?Q?MJK3diUh/3eASIeDD8El0VvN09HfwQZX0NQOVcw4?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43f50b4-e86c-490c-ddca-08dd881ee433
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:41.8535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfXEQvBxrBlTKR97W0dv3S8gD+X4Sze90Dt6JKqOssf2fHC5GDTh0X3HJFFSjE+VSpXJjiOneOmkHcg73Xnrqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-GUID: SVKBpiBLzURdfkkCPGFBrDd3YK_Lu1-V
X-Authority-Analysis: v=2.4 cv=GcIXnRXL c=1 sm=1 tr=0 ts=68127cbb cx=c_pps
 a=94i1PXq8WVRBNmfdvHlv4w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=EI333REZRzQfoknhNBQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX/+7TryW4gDMc
 pShr5THXjk+O6vvDk1C3FeHgoEAXNwrLgF/4zz0k7uDnbST3q+Vmai7nT61bzWdf+SY4qDEMYgK
 RTF5QKnzAEdYf+UJvJFY7jVutrNWtYGbRzdpOeQN+7PNxzKeHYxOK1b9jdX2yQlyiooLSbSkAbf
 AzEhxDSIe8k1giQMX7lPj0to6OWOeRfFWlaCziWiJ6MjnL86UH5VIvBy+fFj5E00lfSoABQ2D+6
 VwXPh/RBxmzJhPbtohIvyDm0mh/mm3WDiO3fecydTEa/X5jZBm6OouCpalhSMqMz/pxmXxqvGVq
 ND44/UZ0NuhK1H0Tuj1A+tGc656LNqDRBSLpsmn4m6AT38e8AXyO0szZh5WU15oCyPYfJQR2tSC
 48jBpVt7pTETxd+nQe0x1jJw0qNhjp4wUDOlNVQ+5ElFBPvZ9tC9pT9H2yyYkoMUlT9dLrup
X-Proofpoint-ORIG-GUID: SVKBpiBLzURdfkkCPGFBrDd3YK_Lu1-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

For vfio-user, device operations such as IRQ handling and region
read/writes are implemented in userspace over the control socket, not
ioctl() to the vfio kernel driver; add an ops vector to generalize this,
and implement vfio_device_io_ops_ioctl for interacting with the kernel
vfio driver.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container-base.c      |  6 +--
 hw/vfio/device.c              | 77 ++++++++++++++++++++++++++++++-----
 hw/vfio/listener.c            | 13 +++---
 hw/vfio/pci.c                 | 10 ++---
 include/hw/vfio/vfio-device.h | 38 +++++++++++++++++
 5 files changed, 117 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 3ff473a45c..1c6ca94b60 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -198,11 +198,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        return -errno;
-    }
-
-    return 0;
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
 }
 
 static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 5d837092cb..468fb50eac 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -82,7 +82,7 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
         .count = 0,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
@@ -95,7 +95,7 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
@@ -108,7 +108,7 @@ void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 static inline const char *action_to_str(int action)
@@ -155,6 +155,7 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     int argsz;
     const char *name;
     int32_t *pfd;
+    int ret;
 
     argsz = sizeof(*irq_set) + sizeof(*pfd);
 
@@ -167,7 +168,9 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     pfd = (int32_t *)&irq_set->data;
     *pfd = fd;
 
-    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+    ret = vbasedev->io_ops->set_irqs(vbasedev, irq_set);
+
+    if (!ret) {
         return true;
     }
 
@@ -188,22 +191,19 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                              struct vfio_irq_info *info)
 {
-    int ret;
-
     memset(info, 0, sizeof(*info));
 
     info->argsz = sizeof(*info);
     info->index = index;
 
-    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
-
-    return ret < 0 ? -errno : ret;
+    return vbasedev->io_ops->get_irq_info(vbasedev, info);
 }
 
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int ret;
 
     *info = g_malloc0(argsz);
 
@@ -211,10 +211,11 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    if (ret != 0) {
         g_free(*info);
         *info = NULL;
-        return -errno;
+        return ret;
     }
 
     if ((*info)->argsz > argsz) {
@@ -320,11 +321,14 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
     vbasedev->fd = fd;
 }
 
+static VFIODeviceIOOps vfio_device_io_ops_ioctl;
+
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard)
 {
     vbasedev->type = type;
     vbasedev->ops = ops;
+    vbasedev->io_ops = &vfio_device_io_ops_ioctl;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
 
@@ -442,3 +446,54 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, global_next);
     vbasedev->bcontainer = NULL;
 }
+
+/*
+ * Traditional ioctl() based io
+ */
+
+static int vfio_device_io_device_feature(VFIODevice *vbasedev,
+                                         struct vfio_device_feature *feature)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
+                                          struct vfio_region_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_irq_info(VFIODevice *vbasedev,
+                                       struct vfio_irq_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
+                                   struct vfio_irq_set *irqs)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
+    .device_feature = vfio_device_io_device_feature,
+    .get_region_info = vfio_device_io_get_region_info,
+    .get_irq_info = vfio_device_io_get_irq_info,
+    .set_irqs = vfio_device_io_set_irqs,
+};
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index e7ade7d62e..2b93ca55b6 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -794,13 +794,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        int ret;
+
         if (!vbasedev->dirty_tracking) {
             continue;
         }
 
-        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+
+        if (ret != 0) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
-                        vbasedev->name, -errno, strerror(errno));
+                        vbasedev->name, -ret, strerror(-ret));
         }
         vbasedev->dirty_tracking = false;
     }
@@ -901,10 +905,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
             continue;
         }
 
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
         if (ret) {
-            ret = -errno;
-            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
+            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
             goto out;
         }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8455010d62..bbf95215cc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -381,7 +381,7 @@ static void vfio_msi_interrupt(void *opaque)
 static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_irq_set *irq_set = NULL;
-    int ret = 0, argsz;
+    int argsz;
     int32_t *fd;
 
     argsz = sizeof(*irq_set) + sizeof(*fd);
@@ -396,9 +396,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
     fd = (int32_t *)&irq_set->data;
     *fd = -1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-
-    return ret < 0 ? -errno : ret;
+    return vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 }
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
@@ -455,11 +453,11 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
         fds[i] = fd;
     }
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 
     g_free(irq_set);
 
-    return ret < 0 ? -errno : ret;
+    return ret;
 }
 
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 5b833868c9..e89ed02c0e 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,6 +41,7 @@ enum {
 };
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIODeviceIOOps VFIODeviceIOOps;
 typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
@@ -66,6 +67,7 @@ typedef struct VFIODevice {
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
     VFIODeviceOps *ops;
+    VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
@@ -141,6 +143,42 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
+/*
+ * How devices communicate with the server.  The default option is through
+ * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
+ * process.
+ */
+struct VFIODeviceIOOps {
+    /**
+     * @device_feature
+     *
+     * Fill in feature info for the given device.
+     */
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+
+    /**
+     * @get_region_info
+     *
+     * Fill in @info with information on the region given by @info->index.
+     */
+    int (*get_region_info)(VFIODevice *vdev,
+                           struct vfio_region_info *info);
+
+    /**
+     * @get_irq_info
+     *
+     * Fill in @irq with information on the IRQ given by @info->index.
+     */
+    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
+
+    /**
+     * @set_irqs
+     *
+     * Configure IRQs as defined by @irqs.
+     */
+    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+};
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
-- 
2.43.0


