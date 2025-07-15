Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A660C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgzv-0005eI-Rp; Tue, 15 Jul 2025 10:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgRM-0002b8-QV; Tue, 15 Jul 2025 10:15:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgRF-0001mn-I8; Tue, 15 Jul 2025 10:15:28 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDeZJU027829;
 Tue, 15 Jul 2025 07:15:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=mkLJZ3RyVslsTJ4
 CyN7yS6VeqYKR8mDLMidZKrhq1/k=; b=ewdi1xtKkBDqBCqcwrihz9fVvOkUeFD
 XHYCH4I/g+S1yjj2m1zbOBj3w31W42K6UxS0wUwVR+555XQD3jzFURXs9RW2A07A
 MOD94SILfwhPI3wAzbKuGpIMRA7KisvJVbOkBOkPwlnVT3Y/n7OVfCyIuT/+uLxC
 z4+Uy8hfaYEj+YHJSsUh9oFVOqnQLc4B6cUAEx78DKOgQC6OPl28gCKjJkxuMMiZ
 0k0nCC7Bc0JpgT1rsn0AtA4uIUwjwannUWsvP76uOIUN285vx+IhQYLOyQkPBf+M
 pTKDiEP9ePFUkW1zBYNqnZQApKuivi1hVHS+61bJM5+ltRrI8JcH/Xw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020114.outbound.protection.outlook.com [52.101.61.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47um1v6huw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 07:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N88Iv1wQ8T37BZ0buIalbw772eW6Nkmtt65ksKl8hir/1l4+zFZuHrJav0w4YiY8sxkq9Cu8B8Rw/cw1cEWqbA3ezmujUBOMycpKj6MLDwVMUT8gt32rolMG7RuAub80ignGxLrhIApMc+Rh3IWsHVpjqBHU+RC5uId4sz3bYaZpz9LuxGqyBF3jol5qkniTb5pWUrgze23zG+kj9NbkI0UBjfFECjC3AhLzSsxUbjgi8dmS5BmkjFPxn4cjlWrEIv1iFQo/JHDiBiSndHW1P8qLovecb1DeqgbgI0FVdYpgqKMmfYFp4zNHdhBgL15F8oQCVeCSjwGk+cxYa7elHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkLJZ3RyVslsTJ4CyN7yS6VeqYKR8mDLMidZKrhq1/k=;
 b=rGeaEDBTvXPxxOPemq9Nf1bCBbI1bHemPoJDGoCikakLyV0unQvYbsLeF0CNShG1+qAHBCcaGciGPW0a7majnBH/1ZMX2z9nDtjbxg9OfS+kEtXxA25LnN8m4rPa/W5yA456rEdg4TLU50DR/vrRYg6Zfp3sLPh4Tg/BB51FIJY3V89QvRgxnB7bH2WOQBnGN3BJtsWxrtw14cPReBmHtvtogyxWYkV+vhAjbI0S053rnXS5CsI44vFh+4EDsA/ZrBfM+VfNCtv50MJg3iAvlELrFErkucTbYwMn8esUU4TCsD7LNLEfHCnv0NoMvYlJWCXZ/hKxf4GJn+mdLmnVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkLJZ3RyVslsTJ4CyN7yS6VeqYKR8mDLMidZKrhq1/k=;
 b=sC5u+JOQlK0ws//CRH/7naK1TwvS8ZaCTIStrgGTFerck+z+/9ZWIcWyJdFr7Tp4in+80h2MUknU+dJPQ3GdfN8a/HRlsTUeOleoV3TB+KteqzevZKNC35utQDv6N41q/GU9RFjinI2q0mbhbViqZdwt7hq/o6G0z+I/WDKKht3N26P+H/zVQhnLZCFiWUV7gROkCETYVp+UML3tzp3xvccI1l91BrUsYPGYz0sDpraAvhwBE4EmGQb90f8CRWXpSX8GYX0Zk/wxBL1y89Gwgj/tFyb2eSJ/psaLPwVkzfMlhyLOysYgNKaZCCb8AVthvUwbicMESjeInW5hmcx4IQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10760.namprd02.prod.outlook.com (2603:10b6:8:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 14:15:11 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:15:11 +0000
Date: Tue, 15 Jul 2025 16:15:05 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 11/22] vfio-user/pci.c: update VFIOUserPCIDevice
 declaration
Message-ID: <aHZiaUP2yhx2khP8@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-12-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715093110.107317-12-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b6cd3d-387a-4018-dff8-08ddc3aa02c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mhE9PKWhzJ2YDjYYkCfvcsjM/5VHBP07/eZKw16WPsAZse6SXwGuOdzEeGau?=
 =?us-ascii?Q?zx4MWsaCYoZibB2EYFMDyUNvxrfrxZmYxnum0Y4dRdtOBTj1kfA2ojYqrCx5?=
 =?us-ascii?Q?CFF+L4UXmfCkq142yoMuU78yrB4OIjg45XEp4txyiamHql8BlpSz7iCDJEE6?=
 =?us-ascii?Q?UluiAae0sq0nOv2qnMsa+OvYKWHwxFYcDZusDCdyJomqPODbzP0+waWllIKV?=
 =?us-ascii?Q?cocUVh0a2cjQDAWVy6oW+4SyhtUxcS0DRJqLPIVZBxiuSlYWgK4cKel42MoQ?=
 =?us-ascii?Q?z83FJ8fIS5sS8c3lhAXVSFaR3U6VvYcRLfzaOK7ePgYnjpfu6Q9gtEfKjxGJ?=
 =?us-ascii?Q?qeiIugLT/snGc5LNHWV9nY7QOJdRbr6btevfIoTaeLG0Qdv+nqAemheVUH2L?=
 =?us-ascii?Q?iqdcrCOb5YR65STnqIMcjMwcoGxsCoKLmwWMLvvW6xV3b3yJRGEXIBb3i7Z4?=
 =?us-ascii?Q?K9EycyhRXzhKFeB7uMUlKi7iUfhYmGkCpfN+K5y0v/5JEF2CSP7XCWxv4NsL?=
 =?us-ascii?Q?oyReNqfgLt7z3MBeHOF1olpHl5U39Q7fkGBi/QlQoSqmDcb9uJ/gCDTYud6/?=
 =?us-ascii?Q?iRHn5MCf4GIfEkk7AGUcLZJLfNWFac/RTMV2yn0mu1NO6SleYSjzuDlwjrqx?=
 =?us-ascii?Q?biECHOAr9+xTSK9NZcWt1MsjSprG2kX7TB1j/F8MzsS1yIxRFOp1V2dmk0B/?=
 =?us-ascii?Q?arus1bWArk7cLDPe0QgD9ya7jewJBH9d+Jk6z4KwIcQNyNJPDp2HfKI08RQu?=
 =?us-ascii?Q?r8/6a8DqgXMYOd5ulqb/iPhMKsm4ECI0uqcYg4BXuVLmXKxoq5oR7bPrjI8J?=
 =?us-ascii?Q?OmH3zxxw30NZm7/IKSx8jFl8x4xjD/O1/dg9veIX71KEvYZvBjs0uBjIt5hG?=
 =?us-ascii?Q?sx26DWYFQ0x9Ck4WqP4iAVESTP/miscr80QsUel9pzYtH0hlCt8OwT+UkPOf?=
 =?us-ascii?Q?E2zTQR5M9C3falBDVrc5p239+U6ntSSMJIHsrMH77I1G5DplS1dCpxk4Z8/F?=
 =?us-ascii?Q?t3k3pKal4ym0pJxgZ7bfJQ6cfL68jufaz/bSKZw2IdXdc88WN6pAGrwbKPsX?=
 =?us-ascii?Q?jIjkyIH5TAgj0FiJLAjduX9PxwsjQucSw+e6otjZoldzr7VAmh1yBusny/oI?=
 =?us-ascii?Q?srwN27nOTO4vy5vh1uMr5bn2RxxxP+yaW5nLCf/LH9ONtHk6yHHL/2U1ZDbE?=
 =?us-ascii?Q?SPrORgzU1JBrzpzuqOAK3XKUSGVru+t/1g321Ajo5SeBl1/AuUimKrDBE+sa?=
 =?us-ascii?Q?ygI9Lw5nHSKF0nSVX+irY8KCxSwID8yDRSrzkiJ/e1JwOmOvaiO5TgjB/jKn?=
 =?us-ascii?Q?km2EbG0JxQmXtWkNL89cZPpjjA5nOMNiKPdJSm6azR80PO/EZSouJJIBCfcE?=
 =?us-ascii?Q?X6ggWXZ6KDOF0Jvepz3ICRWLIxlfKlLQb/CHZWT4wt5mJf3a3hkZdFRVwwT5?=
 =?us-ascii?Q?Rb+clSENnQI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Me1KvVz2EeVB1IlT/Z2aUjgQRnQ5059YfWryp3dJk7FJv76qwY4TGv1uHsCE?=
 =?us-ascii?Q?eIoElkvMWXdcwc+jYYVi0JYOj2LHwhLvf6dyCC8KoJvWPA5i6mfSk8pmsJGr?=
 =?us-ascii?Q?2QWbAauppdm1v/z4Ectd+YiM6xATK/eY6HRXuSKIPspF7j4zeiWOyq4llYM+?=
 =?us-ascii?Q?Enb6Qvf1kbGcf3+pqdj68eiABWHyndtNT6SEovXMBAm+/y886GFCnST6elT4?=
 =?us-ascii?Q?TvC6EjVgsuxti+/EHuE7FYmJfDDghINMNvU029C3KYlaEJGy1wjYmXFSvWRX?=
 =?us-ascii?Q?E/J7+MAJWDJ7exdluIQIjfgD/P0ii8m+hHnmhQfQgtU6dA3ecY42PoAwPcQ6?=
 =?us-ascii?Q?LNh4AQte1fiUhok3jdpbKbNVUDGrt+9urmvUtEfcD5t1o7z+H/vrTSc0B1Hx?=
 =?us-ascii?Q?U3TCJZ80RNps39K7bR8nRY9ojdewSx1UsrFCrLc6wf6cXL93Tb9n286VKmei?=
 =?us-ascii?Q?g1krUgqHtZJ4RYx7Oj6eRl3MBvyY8FxjyDPsDvFor3T/1AxkJ9HmKYSQQJq9?=
 =?us-ascii?Q?9/GRGr5zf06ZnXVtgdbzcFhPjfBIx0Kx/jge0pc/zf5scI9WiwaKv9VtJ9aR?=
 =?us-ascii?Q?Kh7k5qikn7RQkOKRUKMzxhsxJIhqxnlzHXXor7sqLaAaboR6oRYhGo/fScxV?=
 =?us-ascii?Q?op3MxVbvGoR1diLNFMHM8ue289jhaCll3TlPnKDloL9QXi08Dq+1SHvV4gIK?=
 =?us-ascii?Q?dSVfhPrzL/5rHvFKUqpJsr0mdNGHFodCnb/UDLtoShwwNqXgVP7pGPLpB/ut?=
 =?us-ascii?Q?BOmCFD1FJRPFnIJwEWSdf1pAfxHr3/xb/EhlM8J8uyqIw7pp+qQkL1LqbwiM?=
 =?us-ascii?Q?lqZrKHpS7qE8BfRD1pTK0mxtZBTKyvxnles27rstl/nyHZ3mvYrKgBZtyF6k?=
 =?us-ascii?Q?+qagKAyqn9gQFW2530KpOvKHShnsrzzbXsN/tYSsvIsqwAIuy3p/sEVggMJJ?=
 =?us-ascii?Q?uDda7P5C51QxgTEW0eJkfYcvxoo1K220v4LQmCqtX44jWKWJNvVbUPImjBww?=
 =?us-ascii?Q?RICu6rw+m8vC43JuQfSXzGF15FQfCJuWlAId1cIAn/Tsc8lmioz5+OCWiPCI?=
 =?us-ascii?Q?Gnxvgmm+SlIBOf1rsD1awQ3Np5qpPknzrEPQXDzOB2ZnKsXvUav72TsXFp69?=
 =?us-ascii?Q?pkq6ua7NKSyPsExEUKRQOyfN34UJa+GwOOUKDxgzcJOa+6BVN9FidptlOU1p?=
 =?us-ascii?Q?DSBJMO4KhKMLIKLwjRHIy/eVhDt/oHq1LRdoRYhGzcqbMri76CPdgWGi6Ngl?=
 =?us-ascii?Q?aXUqY2bMn4wbL90yaMpe9TqXSXyt+KyBBUFM7NxWLd9ecnCWlThAlLcfF1ib?=
 =?us-ascii?Q?t858vOPGysLJvS/774TJr1WEdxsUE9KJmNss+xuCIvDH8HNUfMeMuQer/jeL?=
 =?us-ascii?Q?q/S9b06dxueRg+/gfn6pHJrquEL2bMgr/4Aen9iNKUQHgUxfRKYKsMoQjGnx?=
 =?us-ascii?Q?N+MNQETubmtlcGomMVupIFnKU38RRZ/2zVH372za41OKCU0KhgYH6EP2ZcA4?=
 =?us-ascii?Q?vF6Wsoby94TZ5VzEBdi4Te5iwr2APrvuGds4Ht0UvUaUFjlQwe0SjMkEYjj1?=
 =?us-ascii?Q?Him96yjjoIvWk71jerxm4/WhxQW/3DkdqvQl1e6H3iBxKnqYr8SWRTmdLriu?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b6cd3d-387a-4018-dff8-08ddc3aa02c1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:15:11.6019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2GXyNiLYJiqwOry7y1fLWk0/xQ5LDOZKNJfrUtx/Is6saorcFfT8QFFAIuIZR1gfz8e6w+eTaBHvXVmiugjFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10760
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMCBTYWx0ZWRfX2x2aPanTZsQ3
 IJSaiC37kUq5nwd1g1+etxLn3aNelPt67QjlBFu+WFbqYemnrcwvp1gn+LSRE7+FbBwh/XWQAMr
 mxZ7FRVytB8tu5AjgLQpVpAeFoRrD/4xlPnH5h9kD8nY0V0SuTg5kejGSziNcgypAz47/6Hpdow
 ors5qpDs9ma8KyDEzt4LNZyD/HAPqDS6P0gKb+Zl7oh2QImBptRS2g8cdi5LCxV5xJAKbfUdUnt
 KPAOxlj8TUqYV16IhxsdejLHeOSbg1IflDBphXwY1yLHmSTi3aPmDd3jRuJMBqWuLVZmJeY/84U
 olZ/uVEk7EsHwkzTcnoyQlcgCdq2Qzcq427xINXS70lHuqwJdPhUiDkwmlSOTGX7jlzI4mJmHk2
 /4NtNFQkLGxFwIqWF53DqH4KgiMLFg2nG5pln6Z0XA1L0s/b/grHPsGLqYf0T2zaWmjygzAC
X-Authority-Analysis: v=2.4 cv=Y5L4sgeN c=1 sm=1 tr=0 ts=68766271 cx=c_pps
 a=cOg1uqDXM20bBY9WInewpQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=c_lB1a7J-0q12jGV87IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: cI-aWxdflO5wJSJxQPiSaH5HJm3AkRxF
X-Proofpoint-ORIG-GUID: cI-aWxdflO5wJSJxQPiSaH5HJm3AkRxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:25:51AM +0100, Mark Cave-Ayland wrote:

> Update the VFIOUserPCIDevice declaration so that it is closer to our coding
> guidelines: add a blank line after the parent object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index be71c77729..da6fe51809 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
>  
>  struct VFIOUserPCIDevice {
>      VFIOPCIDevice device;
> +
>      SocketAddress *socket;
>      bool send_queued;   /* all sends are queued */
>      uint32_t wait_time; /* timeout for message replies */

Reviewed-by: John Levon <john.levon@nutanix.com>


