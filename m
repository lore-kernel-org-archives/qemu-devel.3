Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D8DCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ghk-0007J0-Aj; Tue, 14 Oct 2025 11:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8ghg-0007Gj-50; Tue, 14 Oct 2025 11:12:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8ghc-0005nF-Di; Tue, 14 Oct 2025 11:12:43 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59EF3oPD2865304; Tue, 14 Oct 2025 08:12:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DTmb86fJdNP3i7EWRQRA9HiHXPOcoIwjjDphC0Uxj
 Wo=; b=WYhrmYZ4cUxAZJSuXBGIpJAXXbOhF8LJmelWoEzIicl2XuTTvUbo6vGbU
 c47Cb2lNtmtCt24z9cCSNee7G1/RoQJQ9DAx58VZBOWSavBjvn3fMv2W+Icqlc3P
 SW3//IaoeeMDeqKlW2wuUvK/kolvpV3RcsQvKYexHpVIBZjI8aFdt+YcE4UlZzmW
 jBEJZ3ZZZ9Q68sVaceUTZmtu6i2xB3JmQCHBlB6HKV+vgxVXwJkjluFzGcUs4+6h
 WVyHwrWqPENKCLemeg4jM5IrZCpRqlrppyUld0sZb6aMnW1HHuD5kngXpTP9uq+g
 60UDrS3u235BuGYXhIUSv3qDZJ4FA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022098.outbound.protection.outlook.com
 [40.107.200.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49s6b8tfjq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 08:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac9gwNfLdNlOBcehwGOvlOwuXEsTPAapS36b1wHb/fU9X9/D3ftlwom0n30Dcs3EiQPMwoYXX/Qld+dP7O9MFquoK9oBGU9Y+LEK+Z0yO3qA8yowRnbWJtTo/LgPO4ayJwlXFKhdGjAmobxkqQfgJumGBInrR+wdpQu9ZIZP7vkwmgvuHiddNK5ae9EW/cY6s8SuF4IJ+ygv92/oansJAO+EuKjhywOBsQ9L8L8kf0Km9KN3mxwD4eQ76rGerv3rgDOWssMoDZUIs1kwOM6t7o4J9wbxSqF62Cp/kHHrPkhPWTFWgsQMvgxXZWGqd0u8Mag2CcQGcMH3M/BAoJjZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTmb86fJdNP3i7EWRQRA9HiHXPOcoIwjjDphC0UxjWo=;
 b=mTPGOR+XE1Jmrb/kTGBBQtHyOMl4vbbZ7AiZ82bI/RJnqjxYIuXxGui8FMvrrLcW/y4OGKJWZIntmywWYOhnwUnYcOjTeGvb108R1T4khxyHHv4FlpMssIdTqAA5hEHfjhmRM50lDK7QI51357w/j9PqmPT4G+1O0J3IUuO9tbWtfYtYjNKgviqQNw7lev7pBWEH8rbABjaFyDm7qsINbBwaj421vEt/I3yIxo5KqYUmnZyX3e9hvQs59ctD1StKIxZQKb2RtUyAaHjN4Jt/ZJ6LMduyEYxolMtI3cQzHppsf66sxM2sk9WsLtkyC5L6V+St7wbMHj+vr6ik7NM2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTmb86fJdNP3i7EWRQRA9HiHXPOcoIwjjDphC0UxjWo=;
 b=zDQ7DhPPXzUlqoKNBb8BnWM4GyHm92Et8RSkz+bevPS2IX7GeywviQrkHg48m/JM2HL7TpPZBR9boaSzvMKzqeeCCVxuNy1Dug5p/mZoDIxfrY2iAo7mQiwYAX5zPXEXqg5Z+qKuOrwWPdsYQ3AHpJZ5ZR/lq2E8JBZPNEFxj1EybYeKqJUBlQd4oEb2I4Pq+qLA3UwKV2Lutxj25QXjIAnytc7ZjQpMUJ7be4vGYou5+6D7lzwAMFChBKz40vB0V036EBvV25rjsX4d9McBdozDLhFTzJRIPFxBamQQnPJKBZtPWvlFAkoGS3Fuk2PwKbzI29DyXA8WeLGcwZ6p5Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7371.namprd02.prod.outlook.com (2603:10b6:806:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 14 Oct
 2025 15:12:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 15:12:33 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 1/2] vfio: rename field to "num_initial_regions"
Date: Tue, 14 Oct 2025 17:12:26 +0200
Message-ID: <20251014151227.2298892-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014151227.2298892-1-john.levon@nutanix.com>
References: <20251014151227.2298892-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0197.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a72fe5-02f6-46a0-1ff8-08de0b34199a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j91A5Rmw3In1/xRACEPTivoeIUahNcuP7hJxDJZUVYGKLySk25ZZwBmiyMXC?=
 =?us-ascii?Q?wTHW3x1yCE76H7vu1Nm9szKSS7+TQmTjQOwjH9kKfLWbFcj/Sd8gcW3Zixne?=
 =?us-ascii?Q?6C1/G2WTTKSKtjsI1YWWqd4IsFsc70bQeEUw7Q+/Nf8xMZVUzr9b0YkSKlgz?=
 =?us-ascii?Q?feeG/BjS6V/Iiq5KcYtd6/kU1uE0rkhMyFPQd9zhII3MGjWZuA/6DuIm76M5?=
 =?us-ascii?Q?QY4P7O0KCLQbZhlIp2hAKxauBFmACU7eajMTjxHxzw2T4p2k/UyalsR9uG3I?=
 =?us-ascii?Q?Da5krff0QY9DqwHVe7POVuAR+BUPKx+U1uTxA+rPPhe/JCWNnNV5HrVw6Isu?=
 =?us-ascii?Q?8m6eDuNW5+Dm4HdhEhWARuE5KvGkOrtScSoFItMB12Tw0SQGbGYdLiJluzia?=
 =?us-ascii?Q?WWqqVA5hFexP8Z3pEIqtGFt2Cq+qeMshpRGpprO2xMlKbT5avQ0tBjWQA80k?=
 =?us-ascii?Q?0W5anUou3mD5QxMy9B+7TCudZGeJBbQoks+YQVQLm0bi0TKSl/nDqNgQ3gJ9?=
 =?us-ascii?Q?VqIZtW7KtFv+tKtf4TTvFEs03s94gTLqF8CRis+YjVbBKByBBq/UrCwen1OU?=
 =?us-ascii?Q?F4n0LmMIkD2rT6IKUKi7qmHnHK0dhmy7Z8BYZ2oJplVQ9s1BuLCEQ4s3oGrI?=
 =?us-ascii?Q?be+/EhP/AXYDFphx4j3nGQpidx8KEc6q16J0s9+MgsJz2BYQfoGbLEE9iTva?=
 =?us-ascii?Q?hr1XhIOklNUSYPUIT6+PRlaRolvxqnv7iN1k/k3Ww2OqesKHy8q/lwh+Ip03?=
 =?us-ascii?Q?SfDCCK+CDHpmZiUx2sjN9eEm8W770QlPFnrnlqdpEgGXxoTyb6B/SWEQtgPz?=
 =?us-ascii?Q?Ikj2cwN0HxmtDmJBTHQdw7wVE0POXQMI+OLh87BZUCjLlbq8zY08LJ3FHHir?=
 =?us-ascii?Q?Jb0770KCTskrKs0MMDswlHZVzHpANbG9gdgSPJq0pDXuYiMAlV960rLKqkkI?=
 =?us-ascii?Q?aKrD3fwqHuN91pEURj9nMKhvfVWp38JifSzqappoYnpaLe2wn5gKLOzs3XjP?=
 =?us-ascii?Q?MbTcGhfcCfjcVixdrwn1EtzVf6Yyi7UwtejIbuRey4Ua4wV1dBjDDmoNhzCJ?=
 =?us-ascii?Q?xAXX8n2u8Ij8pzYibs+GirCWBDIWe1hSzx3DLLLW2MoBMR2Vcmnzf4qBH+2t?=
 =?us-ascii?Q?nb+RtbrNwqaf1uurPdGJAYUPus8+CyvifDZ6qLd8+mILfNg/e5MLsLeE2tF8?=
 =?us-ascii?Q?4DYYeOAxfOU/pPC/GVZCfTT4fDOJrtIruMbN0GYE6JPfwSQzvvb/51vF+KlI?=
 =?us-ascii?Q?cdbe1xxNIyU+37FtBUNY60LxaKrgCSKn2auwZAx9c0ypXYl87I3skYPiq3oH?=
 =?us-ascii?Q?4aPvgwDYozDNIfU7A9rsBKjvWXdTPqnQRM+RToUzsIH5r8xs1vucfniinsww?=
 =?us-ascii?Q?7ElpejeQYUN99NhVEUpGHfcHTzyJrpKCpRLrzILuNR3nnYOX2lalGn4f9HHc?=
 =?us-ascii?Q?xEPt8irzjQP3wXqJ3vO2OzaAyYFk94AR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RO2CyGE1IQHICTHHQ1kHPdWcm2eoVB8oKC5bmFo7OSh6Ix0apthmybeI0UOG?=
 =?us-ascii?Q?svOCAIWp+762LKa41DCu7DEgwBLzn/dAUuovAWnpMIR/09BH8uu4bZyNO26l?=
 =?us-ascii?Q?ZeiK3FIMYn3BfkQuHAQ2+7fCEodHBls5/ViBPGBjhkYyOeqlhFStetzRmGtt?=
 =?us-ascii?Q?jGEa1qVSLnci+rJhKToFvQbly4ueZStN6BP9J/Znw5ThaCCAYbNtToW+Mapb?=
 =?us-ascii?Q?Tu7CAT6JgqZd1T84DrC/R9cp6CrmugM7Xvtz+JEOspFiyakL0MKzcLCSEONF?=
 =?us-ascii?Q?HXquvK8jJcSw0oKE5KVdNhIh4bEdtCTDtXir+p1Nq1itbt0SR/3yoM/Fm2Ok?=
 =?us-ascii?Q?mUyy5Id212o648ETNGqwL2XqWGjyiIosDRnVDDbk+G42x2PLkmEJTegdcvr7?=
 =?us-ascii?Q?CFQmp5UKoP0XuCP5C6WOF/MfO1Xyb+hw7SFXuKd5k0Be3mcVHvtUjJWcXru4?=
 =?us-ascii?Q?4fm4GxqbwisStd14ARW+Hkeys3MZyuMlAwblNP2Xnb0HSJJdOZfaQiraZsJd?=
 =?us-ascii?Q?qI9nxYxmsPukMmnYXZ/muQ6SczCjz2m6GTr4Z+jOspMzI6XmNjotUEEnrNgt?=
 =?us-ascii?Q?q0HOjYxxqVlaD02pM7Wwk7Hw4CJg4tMd+qbPsCv3nso10PjoYxtOx3RhhSs3?=
 =?us-ascii?Q?y8ZtUbso0u/QMwEs2af9gqK8OSIDFb59Jcv9mycBbELOPy21psHkLoBSPu8e?=
 =?us-ascii?Q?0978Oj+3Yl51hPddAKVmWb5KQD7+e+fDvrNcIWnboL1nSABNO1rLJ9ZqnRqO?=
 =?us-ascii?Q?EGjIQEwbgKl3WSHhmr9+n+xhyTf8wNkCCoFpsT0dxDiTJDYZ03u76TmLVuLW?=
 =?us-ascii?Q?bgXSE9wx1wmEfc8q2icy3RwpEKBRRftLmJvPdrIPfV6oPv/TfgZo5giXuuFy?=
 =?us-ascii?Q?eMwFbHtHZTovU50f9HLd/mtNXHc+58XUL0coVPXVNXbdKLXSzFVxtWMdfIZp?=
 =?us-ascii?Q?PRXQAJVLbGJnFlr0fsaMAveYi1UUQHmBxXGmCP39ockZvbRfM6BV8wFxvjyW?=
 =?us-ascii?Q?SETLvH3pni0fwkzWWOAB0zJEJiCFbxXRSeSeTcIH/5kgW6cctSYuHm88AQiJ?=
 =?us-ascii?Q?9la1BH8n1QEaX3BigUDDDAacewc0LsOEEHHjFXU5xNBS8XkXrORYpu7gCIVf?=
 =?us-ascii?Q?Fmke33M/dsh9TT8VZz3fe2x+zFEYenMPObBvl1r7Elt1pMfNgaNek85yOrtN?=
 =?us-ascii?Q?ONEZtOx8bXpxiCORFGYnNKRD22drTYnTYnkJYUAm6jKPE1MVCxd7y2sR9yF7?=
 =?us-ascii?Q?u9+RSZCG2lZYLTrRb88luYn0gZAU0wfe1k24KbJ2XbCOOYDUao2O3oPEvvzs?=
 =?us-ascii?Q?ynphqjSGOP6ZHNbtPm5bhCHRm8O/OFQ/TwR7mofqMXt62BmOjnEmS6W+T1Oa?=
 =?us-ascii?Q?mqiZ7t9Q3yCsGU6RREFHX24SH3TkOPEzgYBLrPW5C14S4F0kfVhZMUajM2eu?=
 =?us-ascii?Q?wlBHoP7U+Ov7bdpzQ0/hSt8ZE3BBEznclZg9XNeVTJIlcOyN2OHfycFBSiWf?=
 =?us-ascii?Q?LxSWMIgobVvaS6M0gXVCvw+oqKDR6o4OO5YuJw8V2zVqt3kjeLbsqQY8O1U1?=
 =?us-ascii?Q?L6vE6veo6KZLX+wenvgznpqtrZQt1ozi6uu2dKza?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a72fe5-02f6-46a0-1ff8-08de0b34199a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:12:33.0893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vLv0SULleZBDmgAjM8qaxONxHPE35DhHK3sMTQ5hhlWEv/UA/vhKOOdCKVp0siO9KrxEJ+93EqHLzJ4syNCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7371
X-Proofpoint-ORIG-GUID: OCiUyLo5pLY5IOXKZkZpsTv0HVQveOWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNSBTYWx0ZWRfX/ttD94azpjBi
 rgmE00o5xKFjHDWXjAxQDbGGtAJFAweL5tJLFAGDylnuJAPqOkqk1x9k9HbS1l9HgZcjzNCpnFa
 Fd3cOpPQ9vcg5WiYYWr51nyWjO+L0H8rVV/oVjH3+0i7pYMGM4/I1UuRkx7PxXBiWkDAokdfX87
 7DO5ZBagDsC+P3FeZrUva5RCXGu/Ulp8yFAN22lk5PA/aqZz1ag7H6c8SM9BlH7Q9Htf3xsrvoy
 bE53yRV/Teu7nyHcHHeTv/b/PhR4ejrpjsh7WnQjlX2vQzglVT7KwlmS7FOJa8s+XVDAhkMf6ir
 Hlnv+TR2z7L3h6uOFaf0Uc3ekNj2Fhxe2hEKJ5E4fdwsPU8UBrOeERxXRkG6uSmNTgIeoc0SedI
 XzJuXbE5cW6B05q2CYxFMq0ojFhAOQ==
X-Proofpoint-GUID: OCiUyLo5pLY5IOXKZkZpsTv0HVQveOWw
X-Authority-Analysis: v=2.4 cv=IIUPywvG c=1 sm=1 tr=0 ts=68ee6863 cx=c_pps
 a=Z0C3GUl4QImALGAV7svfNQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=Jerqy2VJNwsSh_cFDY8A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We set VFIODevice::num_regions at initialization time, and do not
otherwise refresh it. As it is valid in theory for a VFIO device to
later increase the number of supported regions, rename the field to
"num_initial_regions" to better reflect its semantics.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  2 +-
 hw/vfio-user/device.c         |  2 +-
 hw/vfio/ccw.c                 |  4 ++--
 hw/vfio/device.c              | 12 ++++++------
 hw/vfio/iommufd.c             |  3 ++-
 hw/vfio/pci.c                 |  4 ++--
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 7e9aed6d3c..0fe6c60ba2 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -74,7 +74,7 @@ typedef struct VFIODevice {
     VFIODeviceOps *ops;
     VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
-    unsigned int num_regions;
+    unsigned int num_initial_regions;
     unsigned int flags;
     VFIOMigration *migration;
     Error *migration_blocker;
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 0609a7dc25..64ef35b320 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -134,7 +134,7 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     VFIOUserFDs fds = { 0, 1, fd};
     int ret;
 
-    if (info->index > vbasedev->num_regions) {
+    if (info->index > vbasedev->num_initial_regions) {
         return -EINVAL;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9560b8d851..4d9588e7aa 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -484,9 +484,9 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
      * We always expect at least the I/O region to be present. We also
      * may have a variable number of regions governed by capabilities.
      */
-    if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
+    if (vdev->num_initial_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "vfio: too few regions (%u), expected at least %u",
-                   vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
+                   vdev->num_initial_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
         return false;
     }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 64f8750389..52079f4cf5 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -257,7 +257,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 {
     int i;
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         struct vfio_info_cap_header *hdr;
         struct vfio_region_info_cap_type *cap_type;
 
@@ -466,7 +466,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
     int i;
 
     vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
+    vbasedev->num_initial_regions = info->num_regions;
     vbasedev->flags = info->flags;
     vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
 
@@ -476,10 +476,10 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
-                               vbasedev->num_regions);
+                               vbasedev->num_initial_regions);
     if (vbasedev->use_region_fds) {
-        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
-        for (i = 0; i < vbasedev->num_regions; i++) {
+        vbasedev->region_fds = g_new0(int, vbasedev->num_initial_regions);
+        for (i = 0; i < vbasedev->num_initial_regions; i++) {
             vbasedev->region_fds[i] = -1;
         }
     }
@@ -489,7 +489,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 {
     int i;
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         g_free(vbasedev->reginfo[i]);
         if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
             close(vbasedev->region_fds[i]);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 68470d552e..10fc065d20 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -663,7 +663,8 @@ found_container:
     vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
-                                   vbasedev->num_regions, vbasedev->flags);
+                                   vbasedev->num_initial_regions,
+                                   vbasedev->flags);
     return true;
 
 err_listener_register:
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 06b06afc2b..8b8bc5a421 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2975,9 +2975,9 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
+    if (vbasedev->num_initial_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "unexpected number of io regions %u",
-                   vbasedev->num_regions);
+                   vbasedev->num_initial_regions);
         return false;
     }
 
-- 
2.43.0


