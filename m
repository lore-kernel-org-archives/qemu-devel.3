Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306CFECE58B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwr2-00069G-Ax; Tue, 10 Sep 2024 05:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwr0-00067a-Ql
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwqs-0004HY-Vk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:01 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8tb0E031012
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=nvKn/wDBAxD1e10wUSGS3PLbmwSD8bBz13dZQCFyI20=; b=
 C452c+3DsxTE4O2lLdSjUrwmcVbt2xoa/1cpjsjy3B75D2NGu7W2g9yXga9pqLIb
 4a3WPyuZ1Y46U3FNqj8KBNvAd8iqAmT4j1PJpXfIMAC6jkOehqNAyEOEL+kDaU3b
 REjmRDpSOL4a2lpglAjGa+7/epJE2ttb3SCN0KVsT+nn/iNcOun0vAUzj8Y+BLpg
 iw+TyL9fyvZlO3bLN5dZ0nrWBE74kYh7AAaXpNdiM1Mixo+Z6MKfty+KqulXgzqF
 HqrnQaS2LgzNumETvJcG3t/wNlPHKE1hyownfR+9NlDWmKaJECJf1PTcIZSkQ0WY
 VO7ey2DGrXPVhGhfbHxS8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb51s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A886Qw034160
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd98s0dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSXVX1Pl5+F2LKfnhI/MZ/YOK77Y/7WDxpiIZYzxO7a+a9+DfiQS1ceJqIC/B++ljACfwD1kRkViezH2WW/xJq6hDL0zMbI8IEV0YJzEgyIVoXdWsPe9cka0KzoRQMrkaOX8nOmvNXMjXtaIdZZOOCnNN3PBhe4PSZ0/fip8r0P9ocGQpoL1kWGWeqN2oHld90LzBmdnsOcGEldGTOcapmZyRkUl5W1PK5GtpbJmI68lhXUcu+VQAWzwhHyjxxjZMgvHh8fTLQzMEbiemSeqvJLFo6rT9AgVPHX/vUpMy7Sk5sgfytq0+UUiv1V935+d7s4KoJo282lTyDv8I38lDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvKn/wDBAxD1e10wUSGS3PLbmwSD8bBz13dZQCFyI20=;
 b=OBcobv4ZpZSDMs4o3JpvF7g0tOdK2ADTjNcXHsX+pQJcif5FlONAehk3QkUCvLm7aChQna8IICXjjPqoqZQ/kL8FRlhVkSQ28qoK8YUKHH3a+ACk5uJpVn5aBvU4NJIaGFo4ahfoiogYrKYZOfR3vFlfysOYM+Q1epGSECCkBi6tbM9zqiG7LQUMd2sWnXIrudOGfYOgDk2ZXm6Etsx6AIvv7s5W4lGuxmHrba59HJKz3VjPYn3F19i18OR6Ch8IkAYY/WcZ71LwAnSOZte7obLfyncqecJRokziDcWmfl2BdkXEKNlFI2cEX6my7PA8L7ZlxaqsjuEJMGhebsg5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvKn/wDBAxD1e10wUSGS3PLbmwSD8bBz13dZQCFyI20=;
 b=SqYaLN7AcxKIUG52V53iqgt4r9a1XEeTgyHbuR1NevY/3TWoN1I4Qwv+AEWcfixzxI+DL6M2/zCeX9H6wFLSzNk1uuhc3lkxXc6cms6AyAJhVnpBGrGiIYD23UOnvwRZhaip+1AJ84psm662owB/T541zv/bIyon83FsRvB/sa8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:07:52 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:07:52 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [RFC 1/6] accel/kvm: SIGBUS handler should also deal with si_addr_lsb
Date: Tue, 10 Sep 2024 09:07:42 +0000
Message-ID: <20240910090747.2741475-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910090747.2741475-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcf6905-33c7-414d-8c43-08dcd1780cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R6CbSpa39ZZTQ82PokK60i2yCbZkBpK6ZDXAzjz57G1snGwaufNyD/KyAUpM?=
 =?us-ascii?Q?e+UE742GdUdzLf85TvUMHHsBGFLhA85EnVacq513OSLZl4jvtn8r52xeBwjq?=
 =?us-ascii?Q?6aY/SSuav22sT0rYCnwyi0Q9nUYmnw11PoeYk5guh0PLnZbbdo0c5hjEHBsJ?=
 =?us-ascii?Q?9Y6VihvuJin9wlsrvqYHFM7cDCNJisLfMGLIJRwQbYRnfD7mZlf19peFKNeH?=
 =?us-ascii?Q?thx22mVnwNemMF8mC1TQ4it6F+Sde9SrRkbihvw0GZvg3972LkZUBLuB2kHy?=
 =?us-ascii?Q?Dci63nnyLuRxgfv0I0dejA95DD92TAU3C0DGk0j48G/6LV2KynBuPqceZM1X?=
 =?us-ascii?Q?PwhR+Kqa6HytldtCRrByL6uTfXkd5vcPQfzTknHQe4SrrKyQaS5MBzQhUVsZ?=
 =?us-ascii?Q?JCNs8rEcp/njbKuYSlB6RNTNnjXEnLKrf971HYACTaiWrPUfRoVJx9NPDXQB?=
 =?us-ascii?Q?cIYred6n344Onvd/2kAeqgcEMAnxpFnWYDxN5PbtXh3fXhasINToQkptJVtl?=
 =?us-ascii?Q?TR3t0V6vCdVz1fX4F5pTgx61mS6/qaD3DWMvyJydebt2fiOB8i+XYk2+ta9W?=
 =?us-ascii?Q?5Rh4eRVYklTVEiJpS3Ss+lOceH6Vju0jkI5kbQcvUHgDykzrTzhfUt1CcdyK?=
 =?us-ascii?Q?xqzqO5rSbIgroAdEgVFcXL3rnuLwCb0kOOl8QUZDNHtOJvhit7qVL9jRwb9P?=
 =?us-ascii?Q?7JFbn06JPFNMwYtEVSxig+2wGbBL+Xiez/enwxXZKkkblBZjCA55TfYvRYAc?=
 =?us-ascii?Q?b6i8w58vhLs12u/55ZP76axvaYpJUjWDfh7cvQdqSwh1BLQXULkbWNPPQFc5?=
 =?us-ascii?Q?jSvbIk2p4ohuave/oEf2pQ4OCbyHBwZePdcYF8s4TlMez84T8z58VV8Nx9M8?=
 =?us-ascii?Q?WaCSsHwWvF0ngUtRQvL/XL3mCYPQClVrzkshousfRu7vrUcpWM70B/ubz+BU?=
 =?us-ascii?Q?a4wzPVYpCVv3TYO1z6FERESesH+0JslU1nijQD9xH6F25WkdhTNi37cv6kKq?=
 =?us-ascii?Q?RU1xvWYgq/uuKwcm+qFRLBK6b775dmAS2NMTYv9pZ8vJK2DXWkGy6rBdlR1c?=
 =?us-ascii?Q?L8JDX+VXJffYUn4hDkFougZ1HlRLPmznL+uQDMmXL1Z7GiUZ50EC/f3yPr4K?=
 =?us-ascii?Q?9/H2yO2/4T2Cgqi1e1Ed8w0xzw9Fvre/0nhN5uRu92HDIxELklUh4E7AqJrN?=
 =?us-ascii?Q?JJMVFdEFtXXkbT+5oZffMfUeZsQEBH1TgRgQkTB1/FvzPiZILB0UTYtFqTyE?=
 =?us-ascii?Q?DalhF+VpzMMT1ZfUvIN1pnwyvjs8+b+J6jHKk6IXEFKb8DWXh0zwjEwUeP4K?=
 =?us-ascii?Q?hTvR6eBvAPvPOl/V0/fVBzzl8aO68/3jO7JVM59fopaolA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8FRydjQzJXd+ufc5qD8A985h1SioqZmEQ3Plyc1uVATBXVfaXMyPX59QuuP?=
 =?us-ascii?Q?To+WqildX/cYXORDjgXEu4/6NdD4tkTGwQJfglUeO8syAsRtWwZuh5t9GKxW?=
 =?us-ascii?Q?uYHUiszg2PjmmgAc6Ex+zPbCDzpzWlMbhxG/atBzEZwMPlw8u5IY2lRsMEYh?=
 =?us-ascii?Q?y0EhHpoU8q3qvncvL4jEZ7tZBOcbA78DBB2w2/M6BSRxH88WJzHhOF6ZQKBr?=
 =?us-ascii?Q?rtWMVMbncoKxAmLieaLWqthlYEKXN9ExdoS6gFixkHf1fVUx1rvqpQXBBevb?=
 =?us-ascii?Q?S/nA+0UsvTkhwyWjbLBUjw4IIHUi5nKQhmWAf3MkGfgQOrB8dgOFtqpEIDKD?=
 =?us-ascii?Q?vfV0+V2hSskUYr2HfLJkvpkdW507OvwSo+6tkXi7JsbZ6G58gj3CQ/HAjHUx?=
 =?us-ascii?Q?Ngz9oTtVvoHm6oAKjFY0waGtO13RYKxkbW4yzEM5iHRmEvpGQBLEDcF0C7yP?=
 =?us-ascii?Q?f0Ck3BEUkBvkzzbCiLXrylBalEvoe4Jn6LtPJcSCARTJPHOcobRFdiTaWhWI?=
 =?us-ascii?Q?VNmfuygjhtGHAJAKVBEEFPlS+Uye/2R7FeYzKQ/dLJ4bMGjviNormq9nKyRJ?=
 =?us-ascii?Q?Cixi83THfpqtce0BvMRiLvcPumMVikfSNR/qn4sw5gBD3kPR9MAUbezBcsbr?=
 =?us-ascii?Q?fT03gIUncqozHnGuMIlU5L28atg6WyM5Nyhl6wo85Aa/pxV+T8/owgXPt7L/?=
 =?us-ascii?Q?RMnuu0yUTXAJkOkYf436j5XT36z1xg3pn80RQvxufwloAOdqYakdN9sfFREo?=
 =?us-ascii?Q?6wnY4MGp9tL7lL36owk3P1V1n7noU+kxBTsquSaeChYHhXGkWQlyV1tRiPkX?=
 =?us-ascii?Q?5yvXeSrJsUyclD1lumYStDyMaZnfRlJZqYIYzr3wyi22QX5zMx4CQWcWtfiC?=
 =?us-ascii?Q?DV9EDiGVSZBcIiN1vRVDqF9wAA7S1X8SsoZ8UhOcHWf576LWgtg/iUFwEiWy?=
 =?us-ascii?Q?nfO9lJGTD8VnLNZP4At7x4p9l9mb46i/rla7V3vF6q6MB1rOXl2Yf9oge21c?=
 =?us-ascii?Q?DxnxCDTQY+nRB+AYKy5vfgGtpA9Jio6UsyX1Kv6FyWQufY3Mp3fMJEzHUjU7?=
 =?us-ascii?Q?1/E1CPHkyw6HomeraiV1nAO6k4prHzxQPBxCJycTLQ4NVUC4DPO+GCLyg9X9?=
 =?us-ascii?Q?uBqJ4x+YHuX+kDDGBMcQQLwXXghJYAPUqXh1RNoB62swr98lfGXm5TrJAu6m?=
 =?us-ascii?Q?D0w87r9ID9MT0CzvAoyAmW5E/aJM+vr2r+6na8s0rQ18XJIdnrTLNCAAAVvA?=
 =?us-ascii?Q?hfvlIszt6j8MkiVPQ6SREmZbpVyvJ2HAS5aQde02nRzOmUV3TUCD0Po9qDnN?=
 =?us-ascii?Q?fV1v62Qlme/BHTV80lgn0qsVtok0uiUULH3FLQbRdoQ7Z/OiOVHYsMJLsnyG?=
 =?us-ascii?Q?s6+E1D/f0ygf5YglcWE/R+OWeL8M3Akl8RWXzt+FGcry0PEgmP/xDcfekmVt?=
 =?us-ascii?Q?id+Lc5HMJJLB9zn6y9+i2i4aXq35v7bkbJYz7DDx1wzAbI11U3f/hPtUsDUg?=
 =?us-ascii?Q?ala5dZmIhfP3aLqu6GWlNtVWRP+yTBsiIq9N4fR9MLtnnPEo2Rz6ZThyUrok?=
 =?us-ascii?Q?5B6mVBK40YJhdnpGB8hGix0kDiyCkW8cwZhg67wmrcPoRpxzAZm5jJetknuW?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CHqRjKUo56GLyMS551n4q9trH5NUUtjnJJKWW5KpURzKAkH7kUgiTAKOkDim7X3CIe8iHoU0HQGdMuQZjANVIoUdKpkP/O8H4twiEacTJ/9R1kQEbNh3UtRdYFD9558VwvHTJggQfN6JHbaqYVl+n/TNF2KdHSoBiXdeK3RcMfWEgD4n+9Vt3VBZovYNOus4CUD/7+noSDXJZN6WjC3cymEbygzQG8qw6E6MHVpwrsHbjkLS8rq/KTZQvTkEqfwIIIXVO1gcWBQsrqBIuCfAco1IgFYhwUZfoD40u26Y8ll5XtPgXA88S4V+2sXWVW9/0naIPncO3ezzm+rue/jG4IK3z++wvOw/mK6CBYE8mfXXu6tQ/IbbUbVI7ZqTXUaLzAlkVsaNX9eNq3Svyvyj7id/ZFBhCPNhKXnLORt7BB7BYup1KvNd2iZI+d9lbjaclQmzI3CDWsfoyQVbSqY7g69xlGXlIhwtqvE9ve5Zpl+BfEoHHN4vYSJplZEoefcZF6eCVOAxLUVzFd4mevwXYgsT382RDrnjzdQYtMcyBQPqUpMhRHxQeATvzlNNLV2QjWVcqqIFmImPmwBBYH1jOoo5qUz0TrlKqaIVQHIQK/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcf6905-33c7-414d-8c43-08dcd1780cc9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:07:52.2326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqcM0bF43BxkR2UWgQpLZd039vDlqSxgbtIzYNWdXC7ZJINMehWmVk/eR5dItQb06zEpYcUnc/mpwAW4nrx+GPPti3EvD1ZNhXfGm64NGOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100068
X-Proofpoint-ORIG-GUID: c8xcuTEOVAU27wWlkckkBijY8atiXZn_
X-Proofpoint-GUID: c8xcuTEOVAU27wWlkckkBijY8atiXZn_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: William Roche <william.roche@oracle.com>

The SIGBUS signal siginfo reporting a HW memory error
provides a si_addr_lsb fields with an indication of the
impacted memory page size.
This information should be used to track the hwpoisoned
page sizes.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c    | 6 ++++--
 accel/stubs/kvm-stub.c | 4 ++--
 include/qemu/osdep.h   | 5 +++--
 include/sysemu/kvm.h   | 4 ++--
 system/cpus.c          | 6 ++++--
 util/oslib-posix.c     | 3 +++
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..409c5d3ce6 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2836,6 +2836,7 @@ void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
 #ifdef KVM_HAVE_MCE_INJECTION
 static __thread void *pending_sigbus_addr;
 static __thread int pending_sigbus_code;
+static __thread short pending_sigbus_addr_lsb;
 static __thread bool have_sigbus_pending;
 #endif
 
@@ -3542,7 +3543,7 @@ void kvm_init_cpu_signals(CPUState *cpu)
 }
 
 /* Called asynchronously in VCPU thread.  */
-int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
+int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr, short addr_lsb)
 {
 #ifdef KVM_HAVE_MCE_INJECTION
     if (have_sigbus_pending) {
@@ -3551,6 +3552,7 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
     have_sigbus_pending = true;
     pending_sigbus_addr = addr;
     pending_sigbus_code = code;
+    pending_sigbus_addr_lsb = addr_lsb;
     qatomic_set(&cpu->exit_request, 1);
     return 0;
 #else
@@ -3559,7 +3561,7 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 }
 
 /* Called synchronously (via signalfd) in main thread.  */
-int kvm_on_sigbus(int code, void *addr)
+int kvm_on_sigbus(int code, void *addr, short addr_lsb)
 {
 #ifdef KVM_HAVE_MCE_INJECTION
     /* Action required MCE kills the process if SIGBUS is blocked.  Because
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 8e0eb22e61..80780433d8 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -38,12 +38,12 @@ bool kvm_has_sync_mmu(void)
     return false;
 }
 
-int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
+int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr, short addr_lsb)
 {
     return 1;
 }
 
-int kvm_on_sigbus(int code, void *addr)
+int kvm_on_sigbus(int code, void *addr, short addr_lsb)
 {
     return 1;
 }
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fe7c3c5f67..838271c4b8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -585,8 +585,9 @@ struct qemu_signalfd_siginfo {
     uint64_t ssi_stime;   /* System CPU time consumed (SIGCHLD) */
     uint64_t ssi_addr;    /* Address that generated signal
                              (for hardware-generated signals) */
-    uint8_t  pad[48];     /* Pad size to 128 bytes (allow for
-                             additional fields in the future) */
+    uint16_t ssi_addr_lsb;/* Least significant bit of address (SIGBUS) */
+    uint8_t  pad[46];     /* Pad size to 128 bytes (allow for */
+                          /* additional fields in the future) */
 };
 
 int qemu_signalfd(const sigset_t *mask);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9cf14ca3d5..21262eb970 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -207,8 +207,8 @@ int kvm_has_gsi_routing(void);
 bool kvm_arm_supports_user_irq(void);
 
 
-int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
-int kvm_on_sigbus(int code, void *addr);
+int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr, short addr_lsb);
+int kvm_on_sigbus(int code, void *addr, short addr_lsb);
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff682..12e630f760 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -376,12 +376,14 @@ static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
 
     if (current_cpu) {
         /* Called asynchronously in VCPU thread.  */
-        if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code, siginfo->si_addr)) {
+        if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code,
+                               siginfo->si_addr, siginfo->si_addr_lsb)) {
             sigbus_reraise();
         }
     } else {
         /* Called synchronously (via signalfd) in main thread.  */
-        if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
+        if (kvm_on_sigbus(siginfo->si_code,
+                          siginfo->si_addr, siginfo->si_addr_lsb)) {
             sigbus_reraise();
         }
     }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 11b35e48fb..64517d1e40 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -767,6 +767,9 @@ void sigaction_invoke(struct sigaction *action,
     } else if (info->ssi_signo == SIGILL || info->ssi_signo == SIGFPE ||
                info->ssi_signo == SIGSEGV || info->ssi_signo == SIGBUS) {
         si.si_addr = (void *)(uintptr_t)info->ssi_addr;
+        if (info->ssi_signo == SIGBUS) {
+            si.si_addr_lsb = (short int)info->ssi_addr_lsb;
+        }
     } else if (info->ssi_signo == SIGCHLD) {
         si.si_pid = info->ssi_pid;
         si.si_status = info->ssi_status;
-- 
2.43.5


