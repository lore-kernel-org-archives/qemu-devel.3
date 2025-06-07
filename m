Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7DDC5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNhA1-00034T-Ey; Fri, 06 Jun 2025 20:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9z-000347-SI
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9w-0006Qu-Je
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:42 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556N0Rt8023133;
 Fri, 6 Jun 2025 17:11:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=H+XM4/n1ESevLcnSCydVtUso4uc22MDK1snAtVmW6
 KU=; b=t8UApXzU25K3U+f/iGiO3sr0KyVxAeH68AHpV+1NkX0enqSx7SEvY/0qE
 eX+RnTzPcvn0xpigy4A7avERpVUXZPgW/1xrUUBddWOY5Z2eLlRD/GZYUHRE2juJ
 HoQDKmSAzHnrAmnihOJfm68U16k/FD1NmGKnD3EKVC/lJ3LfqSd29c71iCkTU/gF
 nNGAxBzFOb+SzUQbDlRNbx9sS92BjmFPDYg2nLQ2c/NlJgqLffyuKO3xamMkWnaM
 A/lal5d6z/LzOH/zU1FZ4Nxese1QPzqI2AvFrPEAvExAGqu1M9FNLJlOfO74Pa2C
 RNIfFWZiFEq5sNip7Ym58+Hfeap/w==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2126.outbound.protection.outlook.com [40.107.212.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqb2-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyK9+VGvMIETB7TWPrt4LPMYnFGIM3sdTjhvatxWjOe44Y4OOJT/2zW7UP9fUbqaeP0DD960iFz+ry665jbJcOor1tFXf/s9deskFWZJ4J6vEBQt9ATItR/KayAtX7lpoNUFYkmU+3sIKWtWTIgF5lBmjzizpAdC/AWn/84m6JMU6PJPnGOw/Pt9JbdjWwSSwSii6BtI7Z77JyjZ510BU6G8Y3PJ26J+yNo4o2ZD26aoA9etDU0SsnkJHYKfBnNERYvF5TZJg0kMfJA9K/7mZ9fHbpZjPdP04vnFYLP1N5xuQ4bVb9mEvB7QU0IDYxQUxzJd6DZ+dHorb7394QupkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+XM4/n1ESevLcnSCydVtUso4uc22MDK1snAtVmW6KU=;
 b=fqLtvPFU3ysDMZQLz7lyfTwskk1vOei5sgGXZkqYVAERTF9d2yUdyGAkfBFPiaL4HumOVPDgdjRGqXVM3re6nmD0F609WhzBM5KT8pnGihwFSH/tV867ixQMi1yWgyDj75eVkvvGPamz7Asn+db0B7NRnfrARN4bSFor4AWoPzJxP6yARDV+fn0L6Dty06PjG4HXmkIewcaAHPLupMDkNSnEBvfeMjtUj8bcHyJWWbfGtcb56G+ErXL7KM6GKOKxG49+lCNhn2Ry3l0Y2PqvQVpxcmhONK6KDy43G87lM4dGrV3TUfoIxKShBmA9XBZJB+L6pQDGMZPZWHKN8IFkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+XM4/n1ESevLcnSCydVtUso4uc22MDK1snAtVmW6KU=;
 b=QpcndXHRdisuh7K36dVM9mxELGAUiNsF0/C7xBqyHWwIkU+Oh4wLE3E54UMWJUs/90oQuA01lLbjspGYS0gyy/Nt95G9PSo5OLSLkS/9Gq7EBJ19wo9K2XhZgL7XiIEYoGtAVrljic0y2rkQxW+FZwiA6xvRQ6Azp62VwfL4R6qy3xLOqnYiCp13zysJQ29Xnvz1WhAxKb4Rs0TY/3N4QCKyz45NkMWWb50TAPtTtdemakrAxP899N3QNvsX1OikZ6cCqiQjOHrybWYPwubsRPGt6SVWJJk2mcatEcwKQkZMmt6PC/9yxKemze8a4JVeompEPn+3tIBw6bUYjd/ztw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Sat, 7 Jun
 2025 00:11:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:26 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 19/23] vfio-user: implement VFIO_USER_DMA_READ/WRITE
Date: Fri,  6 Jun 2025 17:10:51 -0700
Message-ID: <20250607001056.335310-20-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: f926a1f2-69ee-450f-26b1-08dda557d818
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MQoZ73ZJrrDruM+3l76JyqiwiprCehFOCLKwI8Wqj+LYF/sIuPlaN8xIxKT8?=
 =?us-ascii?Q?U8msPO4rpwMyRqW/oczLiLMGZ96oixy3CXbI415h5bhDw7yBHgUK86jUDQDq?=
 =?us-ascii?Q?sYKUJVLX45Vg7B7T0rR+i+zG0px3ULEm07cTI5YIkT/C+OooFG9Q5Lx9O+hj?=
 =?us-ascii?Q?87GsZr6gVZG4Pw2tPhyVcDek1E7JU+M7+C2IEusTkt2j0oGsLGSFvTD7nvpE?=
 =?us-ascii?Q?GYYBqIuE6vu7SYMLEepFhgtgxJT+Sm5gW7dwFnvy9AfzuJlfOMwwITB6rv/r?=
 =?us-ascii?Q?1E0/I6VLpLEfvUv5pdQSjsxAoOOIirKY1Dg+Qux37xzTWWKEkIC2bd30LVhU?=
 =?us-ascii?Q?rUov8AUhYJ8gNVTh0F+8/eST/HAmG2peuZ+1o4v+0CU8a8f/rEnScmAxnJbz?=
 =?us-ascii?Q?7s7JY/H7uT51nf2YJyUyTy4/4DyRyZFssBZV13vHxuk7hDXLiHt351wRldfc?=
 =?us-ascii?Q?QGOsVVi7SabBV4LbLcdhdPctANDHez50ospYDTcIMNmqeW22ZE2ljS0zZnaK?=
 =?us-ascii?Q?SGW80aB2y+v9NxOY7MfCCGSfWct02U6uu7A2nYQB/KZ50DOoM6mrNlLArRp5?=
 =?us-ascii?Q?lXoCFLipbYRCRrBPQINJlREtUq0PtIXv7qrgVWRDV+mJ7XHKS6jgZUxLdPf4?=
 =?us-ascii?Q?qBxl9X+2wjQ42LasvPGGVbfcXN+QqOnbslvHy95R8Mhm6IcX7wpFG0eGz7c/?=
 =?us-ascii?Q?5CDZ6D1QoqSLMZqNQXusfKQ8UJahSnhbhYsXlkfDjYzaKA0mRRk+KdgHGp0S?=
 =?us-ascii?Q?LQziLNpjpcg81yOufb87wed2UNoIWvc6oaNItGnbU5NYlG1Ikvgz2KkTJhjK?=
 =?us-ascii?Q?qRXZNs4l655/xQ2ULAax5nDYbsL19syozKmXkc1pFCHvwAVpN0aempkobA4K?=
 =?us-ascii?Q?cfoGJfQpakKPkztpaur13dsbVp6JsCBepvPGx75uRBWtyemMWu/gseRSmO26?=
 =?us-ascii?Q?0CbOxK6MHmAvNMml7e+gnjXaWVh5eckpuJFmtHfkxVveqb3TramZPmqTbi7n?=
 =?us-ascii?Q?WmyQtovMffCqxpAAu9iW96dq5SJKJ3W57vbIiZi2UKTDmtogQnerNmXSCoP4?=
 =?us-ascii?Q?4imgnMtE637shlpJhYly5o9KlscdNd/u4zzYkJBTHuBX1OgrSmgLkJVJTNi9?=
 =?us-ascii?Q?5hcPUHE6Boc+810sJV/kOq1O5o6uLKFBPmKmxFj8sRHcjbLL2GoiOphJxi6z?=
 =?us-ascii?Q?IIT9dPkFAbeu2TxoQuuH6ZX8AKebwy5tVFXeuq/AukVsg0nc2m9ZrqTsRmMx?=
 =?us-ascii?Q?7loQDCibgz0wl0bUuGEa/toEvBNML6jcO3J8IiQrVpqxsZbrEEJQqzrI9rWX?=
 =?us-ascii?Q?hUO0nqlxexqjkI04UahQm8W5Jl+Od31toTT1IsH9qRVkpwtBi+6318TgtL2f?=
 =?us-ascii?Q?yZ9QqyUx2km50KxO1b3oABUwX/sMAG67FDoeuhaUv4wQD/4DEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/4Wyywoqk6kxSEJW/baCrP5KuEbU4H+KB791X8zCgB3lrcpsQArHa4CwKw/2?=
 =?us-ascii?Q?5WEThMTxXqnFRJEll2EqcRrRk11cUf0uDmo+Q3bf6MpEfIQqI52JB6Uev5sW?=
 =?us-ascii?Q?QreLtO12k7vfpJi3N6j6wkxf5or8Egh1+rpwSs+vaLdBmdqZDqmJXxEwJqgU?=
 =?us-ascii?Q?gpyh/Nm0k/+tJnRXEyCipI7+t+FCFgzfN5ifZs7J0WA18KvmLga5GR74tTwO?=
 =?us-ascii?Q?S7yRljIfFegLoY+nMHFD1MkNLaiX38ENr2/NTkcYH+jnuMyCcquVuf95Ddc9?=
 =?us-ascii?Q?OtOngRqKEoGVTtMYdCDbUrhkRtIYaOAuKadJyUaEfcusmYjnzkZGR7I9QKym?=
 =?us-ascii?Q?vSYdkurdh7On3NJBDhMj7GTuf8HeMeAymW1tYZJ2AYjgmiHm9VVpfjpGG7uX?=
 =?us-ascii?Q?e1XIyqyRKVUOkOStcD42BI4ZM9gQqhZlaCq8sIOEEu5h5OEaIzHNJMk4zcwE?=
 =?us-ascii?Q?ksnoBiJ8kk7sFgONi/o5WRCAc4e9MUILEwmUGXVsFgluDZR3DdlkKJy6Deam?=
 =?us-ascii?Q?qbWrwseIP+CQs2BfQD/MCfT5IZ5miTXAwmXLnWP7uaOC1mDjAGyDvUU6kn9J?=
 =?us-ascii?Q?YZTuXQx3CPT7RfdB0vnlRg+CC7qDZLFJiy+8Em9NH/2pIRv27bj/F5A3hWVz?=
 =?us-ascii?Q?sywZVNkn0V2+1laSBKiDScyj5r+sl2XBflY0oepXTL/SoVuoQBZmZwJ+9Rug?=
 =?us-ascii?Q?5PZN+UZnE657qaUy6cIx6x1RjT+kEqO71p5gViXiZallncRYgrg+13YhcSoa?=
 =?us-ascii?Q?uGdxr/tu1OM+6C1Xgz6zsvEK5mn2jWO6d1odyxV06pVFH+VgGUI4YIRPPtcp?=
 =?us-ascii?Q?dRFVqdVT0nUf58dD/snWREnprWLLlQCaVwMMxv4bHgMmrFvDFQL4Rn6vMEw6?=
 =?us-ascii?Q?n4fkrb6NBNnb+qVSA2d4gS5//em3pQvCSGURz6FrUXVJDPay7o9n1OMY97m1?=
 =?us-ascii?Q?kLMNB7yV2m6Ssj+70bfm4t6BBDiIV/kS6TK75l477DCDZwhlMl9X0xZKzmhN?=
 =?us-ascii?Q?hB4grXxAbS6AlKnTPs/irdhXI6RuqnX/VuaPBpgc6Rl/d87mzpUifE8azLsK?=
 =?us-ascii?Q?mXf04A7HQPrXqy2IrvqZPv/ty/rdWkBwidw1iioXweggDIPbX8rMj+eii5Yt?=
 =?us-ascii?Q?Pukvda3HleMoP1JadxMA9rk8Hak8i9LviHDq4dXGv3gIF/ux5OLHBm063mVj?=
 =?us-ascii?Q?lt9Pl6I7T2pJ3x2KdVxXHPx1TcyzljPWY+0Q1EOV0Ge6dvBuIx6OVIjFZM6g?=
 =?us-ascii?Q?TluQme4rj9SMl+1A5tnZhFUlvcSX9JbYQHxSRdh/2UtHQvHrDqyLRDFzj0ub?=
 =?us-ascii?Q?E/7HfhPm57lPGHg4rzr5eaL5N9UiQZfNGGMlONLAu1BKPkMyNxRoCyhrI0PB?=
 =?us-ascii?Q?HeAthUzIFed7MtZUCQCJdSgP+IBF4j+3oQQ0cbWG8LDAQLpVVhnS2jzYYD3V?=
 =?us-ascii?Q?q8BdIZEoTQDzVe97+g7D5Engk7l2l3dNh2UXzanF88YK5He2q6S53Mll/I3T?=
 =?us-ascii?Q?0zBSNFU3hHRpRLOPOQnrtw1TUjpiQhenMovg0cKjvsvG9Ru4ahNE+A8HU87d?=
 =?us-ascii?Q?wYOQc8mP+B7CBzB3exo+VE/VMHNhaNaZ5bkC4WJ9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f926a1f2-69ee-450f-26b1-08dda557d818
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:26.4248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEiHmPe5mTt80KoddCTipnd/+rhcRqnL8tcyX2ursboMjSQJLX0hgQrURiPyulW9VH7tDpNlqgWX+UC/fckfIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383b1 cx=c_pps
 a=JomqzcHDjT5Ni/tnCvtrfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=qTvU7B1ccVJYr7cy3AMA:9
X-Proofpoint-GUID: eQkxP92-Yq8lGAZvZgPkf5ut6Q9fyEbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX9nILEL4K9GMh
 1EdNSs5o6GabZdRqFXymaFFVPce87jkRupEbv80JjbTzhepQtJttJBTHk8sSE+Ai9mag15KwKYH
 K2/GkHWeR323X8S/1oGmyQAOOG9Za41KC/uK0BMvcFlYWnVe63qSbUqDsw0aQBgm7HV0RJVk89r
 vvvzqkuTmsewsSwWRVRyBmxFLV/7K/fuFkWCaYaA2tRk6qXPtO+/+wyjihcsSNO7mqbjSJrpquX
 orEAREnswUBbmogNOjWcNL6EKO9cF1dHbwDgeqfXipEWPYpGEbzqHAUQXGHyT8uScZqxYKN3W5H
 mSLo6St9BpNKCsVj22K0pyTK1uqGgkEe9YneSpFCXGgLvtndhzO4u0iSEKZR4VAqjjEzrC7qw1j
 1LPurT+ZE2rzYO2mUlH8lZIm9XO+zH+asfhpmusIr+eeGlvHgJlmDlyr/TxGlFOfqtbgQibI
X-Proofpoint-ORIG-GUID: eQkxP92-Yq8lGAZvZgPkf5ut6Q9fyEbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Unlike most other messages, this is a server->client message, for when a
server wants to do "DMA"; this is slow, so normally the server has
memory directly mapped instead.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h |  13 ++++-
 hw/vfio-user/proxy.h    |   3 ++
 hw/vfio-user/pci.c      | 111 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c    |  84 ++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 4fa6d03b3f..8f589faef4 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -203,7 +203,18 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
-/*imported from struct vfio_bitmap */
+/*
+ * VFIO_USER_DMA_READ
+ * VFIO_USER_DMA_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t count;
+    char data[];
+} VFIOUserDMARW;
+
+/* imported from struct vfio_bitmap */
 typedef struct {
     uint64_t pgsize;
     uint64_t size;
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 01fed3f17d..8f2d529846 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -104,6 +104,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 VFIOUserFDs *vfio_user_getfds(int numfds);
+void vfio_user_putfds(VFIOUserMsg *msg);
 
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
@@ -112,5 +113,7 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 2bc71b9b54..095f32604d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -11,6 +11,7 @@
 
 #include <sys/ioctl.h>
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
@@ -82,6 +83,95 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = NULL;
 }
 
+static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
+    MemTxResult r;
+    size_t size;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    if (msg->count > proxy->max_xfer_size) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    /* switch to our own message buffer */
+    size = msg->count + sizeof(VFIOUserDMARW);
+    res = g_malloc0(size);
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    r = pci_dma_read(pdev, res->offset, &res->data, res->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
+        }
+        vfio_user_send_reply(proxy, &res->hdr, size);
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_read unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
+    }
+}
+
+static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    MemTxResult r;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    /* make sure transfer count isn't larger than the message data */
+    if (msg->count > msg->hdr.size - sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
+            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
+        } else {
+            g_free(msg);
+        }
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_write unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+    }
+}
+
 /*
  * Incoming request message callback.
  *
@@ -89,7 +179,28 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
  */
 static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
 {
+    VFIOPCIDevice *vdev = opaque;
+    VFIOUserHdr *hdr = msg->hdr;
+
+    /* no incoming PCI requests pass FDs */
+    if (msg->fds != NULL) {
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, EINVAL);
+        vfio_user_putfds(msg);
+        return;
+    }
 
+    switch (hdr->command) {
+    case VFIO_USER_DMA_READ:
+        vfio_user_dma_read(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    case VFIO_USER_DMA_WRITE:
+        vfio_user_dma_write(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    default:
+        error_printf("vfio_user_pci_process_req unknown cmd %d\n",
+                     hdr->command);
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, ENOSYS);
+    }
 }
 
 /*
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 6d1446c38b..0935b72e9f 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -362,6 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy)
         *msg->hdr = hdr;
         data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
+            error_setg(&local_err, "vfio_user_recv request larger than max");
+            goto err;
+        }
         buf = g_malloc0(hdr.size);
         memcpy(buf, &hdr, sizeof(hdr));
         data = buf + sizeof(hdr);
@@ -676,6 +680,33 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * async send - msg can be queued, but will be freed when sent
+ */
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (!(hdr->flags & (VFIO_USER_NO_REPLY | VFIO_USER_REPLY))) {
+        error_printf("vfio_user_send_async on sync message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
 void vfio_user_wait_reqs(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *msg;
@@ -720,6 +751,59 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * Reply to an incoming request.
+ */
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size)
+{
+
+    if (size < sizeof(VFIOUserHdr)) {
+        error_printf("vfio_user_send_reply - size too small\n");
+        g_free(hdr);
+        return;
+    }
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->size = size;
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Send an error reply to an incoming request.
+ */
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
+{
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = error;
+    hdr->size = sizeof(*hdr);
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds = msg->fds;
+    int i;
+
+    for (i = 0; i < fds->recv_fds; i++) {
+        close(fds->fds[i]);
+    }
+    g_free(fds);
+    msg->fds = NULL;
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


