Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06679C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFOT-00053Q-7F; Thu, 19 Jun 2025 09:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNq-0004Sc-Us
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNm-0008Gi-NN
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:50 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JAvH26013023;
 Thu, 19 Jun 2025 06:32:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=O7D1DH71ZL0cecuRVvta2JFUkHHepebG/jc/avoOL
 hs=; b=g5d0qPF+LHlxilL751NxmH0PdGKKw3ZjT+WUDmSFctUjwJrI/NFhoUVoX
 lILZNiJz6fUuA2d6SRacyti2AvRaSnkeT+gUe/S4qMxbKeQQLeJNQ6JNIVjDccDG
 Ney2rGDG6ye+IMwCE2gu7IkJIpIm2XVsEfK301ohYEAHMC15s2RAPZTvrb99nyLr
 j6H3vglHY1b7DCP1QK/325gQjW81UIXa9BgIn0+7hcOcjhqmvYmfONiufEAdkriQ
 gnN8ntb3JQezIT1lOeQWEWXNrIOnEyVW2b3MA2aaiqssVVkbsEgt7fRt07LmtYDD
 yp+611aUyDXK/0g6L+ER+EjVkI2FQ==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazon11023091.outbound.protection.outlook.com [52.101.44.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47976j3rag-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYCA7dngeRif79uMWpMJCa7Dbh06trSjG7TUfCG73B5+2/ATVfYbFEGO2nFObOKOzgj+we6IELT6EQbuRmph/Ig9CmpyuVGk250dZmM6yID4tKiTyjMl0I1RIa56BuARMQSaPf8iVjIKGf8H4Zafzb4k3SQt+dQXyyuw6071+fqgCmh1K07kI9khzoL6sP1drVhwysFAgtuvZ4NOVrHy2Qjvxbms4+fqw5WRGbj/ih9Bk6ZqATb2XMdHe/hbDggHCPYu0Ci3pAWreNOjqTwLffE89nKroiIo0lr3wToccvHpyNGnOh0zxz5XTeo2Pbbg80WFwq6hU0V38zRGWBGk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7D1DH71ZL0cecuRVvta2JFUkHHepebG/jc/avoOLhs=;
 b=N6GRRs4zOaCpCxZi4Ehlvwc0wSaKy176CQu4ekRMh3MQ4REijBzgGUaRJUNVC7YwNf+sqmWBWZEh+L4vTtzPRBWgQ++j4CSuYOyo86uQwKWFH/qako+eCTyVmi9D+qzWnNOxYYTYoD3G6uua7fQXGcyOK6ChTqOngA8x2oVGhHR2iSV6hyYFmNNjcviL9rH+FEipAgj0NzyZvKYFoMah7EvKZe+H1CaEbsAPgZzjveI3aAqeG/KGNrVATRM/Kxfxda1mot8uykks/d6ui3V7UXVsmbMYJSlQsrEiFCCAyqXkAwAdSO+txxk0miu5PeuhBu3ahGWF/Y5moB9KNFcE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7D1DH71ZL0cecuRVvta2JFUkHHepebG/jc/avoOLhs=;
 b=lHJ2zjg5K2DM9WzFoAXNeVSMRmq1zexUNfKgHvydq8QgtnYvBjlReuklfaEB/SKGLAneCsrCXZ8mTQ/A+jaLxCtiEXp+1/WvIbRl6JRSPCxUsDkijdi+uRY4hgKnSGQOTbiZ+ledne/+W/j16r7+fvVk+gRJwAGOKoR4fcdOrMaIaxK8UlSk/8QVdWLqNrxZD4am+SAPy5HwY+thaBdGFsz0z9m1oggrZ5hcY6VyzxQZLvqgPbOB89GuZ5KxgCwXU9T2WqHy8LF+OfHLPB1RpuZwuKVdg6KYOmf/xNjgVfbt6v/4gy1HAVPGsLoX64MgSYFbPvKEakRy0bK/JhGyxw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:40 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:40 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 17/19] vfio-user: add coalesced posted writes
Date: Thu, 19 Jun 2025 06:31:51 -0700
Message-ID: <20250619133154.264786-18-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: e50cfe9b-95e8-45d5-a098-08ddaf35c339
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NdBhwUD4Q77muquk9oySbl7I9QDjz232ymE5uojwklmm//X4H/lyC5mfaueP?=
 =?us-ascii?Q?67maoP2W+2JONJwU3W1CwkeL/+7O/ACTcTlMtrWwji4KpotH+0bawJztcsj5?=
 =?us-ascii?Q?vzpNu1GP/SSnjArLzOCgVW2oQYmaB+uli5bOmk3I9HUrunmgotklMFsiTWBh?=
 =?us-ascii?Q?8eWr9Z/wiMETs+vG8e85i3Jfw1XzfmzEdDCdz3B6/9i8XkQF1CroSBEw2v14?=
 =?us-ascii?Q?AEKTECIRvX2V6GDIvc6IH4ygAYJQkFYDiJCyPA14vK/w+m6oaIlWsSfYK3bY?=
 =?us-ascii?Q?PlfRQr6v1GUu5gRNZ8clCXknVy0AyOfvig8RG9d5h/pH0pVMjMkaFrOYqtAr?=
 =?us-ascii?Q?5AIrl2gb09wxA0GlOAjrsEMEKX+b90VOyKe0vkrDMQaefHyIur2v5zNxrZwc?=
 =?us-ascii?Q?zk9tZorBmnenRBzL4PTdDLwCGXsjgfTjbVpcFnG3aoOQR5GxTLHPZ2v/g+6K?=
 =?us-ascii?Q?nhLY+/XCv32z2fHzlA9KDeZKY8uA7gyNyBaHXCkIZXiQdLfTk9YimMmgEtZo?=
 =?us-ascii?Q?bZS1oEaX4uMPjg6KKUzB+laXUzWMwXGpjt0ce2+OidD+4BeTjiIdse1UuMZT?=
 =?us-ascii?Q?e/FNZFOTAGhhbFfct7mbB28Ck+9rNjdyG6igqHlrR9bF6+IPK+RSP7jpxpfj?=
 =?us-ascii?Q?wDZtfh2HdjV24MCg/mUlFwuf/bXGt/hn09dmDkQ2QJoxpZZtGTTPKjWP+I22?=
 =?us-ascii?Q?1jutAOqcRn0gmvsUwflZPi+M0f7X8qwIRRRJdM/8c+K2K1O5Oitq8NEq9BKI?=
 =?us-ascii?Q?yqXNtupB7pWUSm9r1IgnTq57Xci1s2EOP1rRGUwJ0+S7O06WIAq/nDFO0yPt?=
 =?us-ascii?Q?yODc9rBR41oS5z12x93aBhJNlBamSozUuaPzIHe/LGbl6fzwalP+Ys+Y2bAq?=
 =?us-ascii?Q?s3UBkf0C8tdZNRdKxJLgPIEjFIXXdfA5l7E40yvCDx6rp33dghTljCXSabWl?=
 =?us-ascii?Q?8WeDzEV+vCcoCypl6XX66nCjFdsrGG4IPHkiUnicqlhGI6t5GZadpi/lTfL3?=
 =?us-ascii?Q?vgeWUfstSnyyt2FthtC+YoxzbYRue1Vm8AhS3cyiU0JfKqO71NLoks1hU6sG?=
 =?us-ascii?Q?VbA5yzZBUny6Id754S8/E8jrYi8cRm7jH/a8iBqkMFp3JoUvXaXgo5OI/urT?=
 =?us-ascii?Q?m1b50eLZv3lAvP3cJc5obgr2tGrv+0fIHuTST3I2SON9SqDhjgVu2TSCSMdL?=
 =?us-ascii?Q?M1uiWeVZJee48+3udR9IuWsy4bvPyAx6rv6E0Umezcf7v3khv7jrYwYOKG31?=
 =?us-ascii?Q?858do47qyqSCY1VFuOeCCgd8H+KZOmhCZnuCYGI9S4yGHHU96PRp7FT3QVYp?=
 =?us-ascii?Q?7QpyUlVTtOiLO9DVDUklZGAhWCPGhQy9zo+A2HbVBBNTBTQRYIDm65eVZucL?=
 =?us-ascii?Q?pbBqIHpyYRg+82qy5vdHTIC+EmTJAt4RXnxjGqdLEUPFZ61O2TKNP9e+iS2Q?=
 =?us-ascii?Q?FJakKrWy+gE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Hr8wwNbxHd/wcbd2jSSL0NTOiVhL01QK7KRVkK2wO1HLA/SDyAD4zP/v0AX?=
 =?us-ascii?Q?tTBnwYM621U6lgb4UruwwKkUb2dPtubAjz3KJtUhjrKQQHkoRYIxAtuGK6Lj?=
 =?us-ascii?Q?wPS2msPnZYW+pthZcrWVirDiWyrJqi+MEjFfWYJ2vrW9DVHv4/IiLboqVi67?=
 =?us-ascii?Q?c9UD30kChnjuzoP1F/x4Alb5o+grXQnH2QrEK03H0XQdM1lnoInhs5aSs2gi?=
 =?us-ascii?Q?ElLrIuLD7dNyYAYBexDY/UJqGLoKQ/+L7jADhWdH8vMHyF/UzN5GQr1YDV1+?=
 =?us-ascii?Q?wbOWlIV4yS3f981/jueLWGL+y/p9FNRmNAO9yRHbT1pmZWLFaaPVm1PJzyg0?=
 =?us-ascii?Q?/P+T/4JW/9x2b3M4qDTjtd9T0wj7WEMhIBUoSUch3RQB2o7p4LjVVu7rg2+4?=
 =?us-ascii?Q?Iir+6/8vjfl+dnAhD9wR8nxBiomGQJWp1tm4zNFh56/s9S7AdYhUjC/bjXuw?=
 =?us-ascii?Q?mfa5HMWSZqTERaSzQ9aDC9xmOLvpx5MZJ9pQoom7f0lw1do/P0m2QCQ+Tu//?=
 =?us-ascii?Q?xSZi9my/frKreMSHA28PHhJAQCJPJbLKV2+yN8f2bHsyJeLJ9BdhCAowUqq4?=
 =?us-ascii?Q?Fwahcl1Winxty/9t1e5QjbhRVcH2Cp4vh1+11A7JK4luofgP6CewDPxvuHje?=
 =?us-ascii?Q?cO1E7mvXiDrtlyMqJFuFQAFFfrX0b2UFrz+M8HjpOJz54SulLuDOzI+DFGFJ?=
 =?us-ascii?Q?5+mBBPqlsf0dR0iG8eFg+50ZJ9VOhmhMgQp8Dn8ZQsFzfp5kD2pZv8c9Oddl?=
 =?us-ascii?Q?cvFwoj1kfrhja7HKWOXq2Q7UsXswVL1ToNGutf00gFDtubKUmR0JzJ+DBAtf?=
 =?us-ascii?Q?OCMorn8b/qNre4l2NGz8MluVSwtcdxb5HcnkITef/CeMwSAeLpPVHWxleSQh?=
 =?us-ascii?Q?Ra2jFhC6Asp/6MRu2ScQijuRR+m3HO0FA7XAeEOXsF0Sey0bL3ylLucAsuT4?=
 =?us-ascii?Q?kfDnZScLI31tlqq2CwkQOppiKzLEXer07ssfCN+xsh2LjpPmoPBDAXdPQSvB?=
 =?us-ascii?Q?OOeXUY6SLtJIEkdEjdIeL8G+FFs7R+mhDnkC0xhkmKIN+nxARkQR3LDvDFPa?=
 =?us-ascii?Q?ru+Zuqf9kJkGgvhdO9Ur1qs1xvLTy6Ckx8EtogL6Q/t6w/XQ2npwEF90qYVM?=
 =?us-ascii?Q?JhmF1gjwMe/6qk38IQv1hWZwuqWEJVoxBBieCu6L418y6xywjx7VguSZ1F1r?=
 =?us-ascii?Q?m/G7dM7a0YjLizcqm4oBw6KWXJGAwD06LUdKLyZY0opjr/RO5WF8r72zUSiz?=
 =?us-ascii?Q?AxoO1XDHbZFUPEm/LaYYPqAS87ZdfGZdrcfKayWBqbhLl1dKDCCoCbu+kipq?=
 =?us-ascii?Q?rnUsckvd/wpEa4rd7po+qE1+1We7G2TuXBsOwmZEDvzT9efmkooVp2AOEeDn?=
 =?us-ascii?Q?eWBNXUKpaQjm1ke0c0z7LXwjhc6CKqj9V+hnFOPCCyxLdfRiJB7MYBMo7tpp?=
 =?us-ascii?Q?J0kqTVlLYA9MdxR0lMYzBU+mKegHi9NEYimI8NYgxVm5YbbB7it3w59XsoSC?=
 =?us-ascii?Q?HeACYFzu36YRjmAMvE0sH1rlsBunamldaEuhJdKjEpnG/ilFmoIv5cBWhLTX?=
 =?us-ascii?Q?410ErlHhBVYxFUkQo2U53MW8onwYN8CzGe84EIUO?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50cfe9b-95e8-45d5-a098-08ddaf35c339
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:40.3189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzVid0GEaCBAWyPIwAZeKXQqbzqN+YQD1z5tK0SmHdDv89uRkdLL81rrVfumiD8g02eaZx9HIKqNvU9amjXaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfX1I5qwmifbtna
 uMdMNN0GocgWkzr6WpTg8Mild3y83e9C0XNnDXqikcxp65UlkAJJ6Hhp/rF4Cg3o0zzFYZGKU24
 IsbsUTMxuTk+yg53LnyiqcCx3OqAs7LhtIw8smmisYw6HBQv1/bYegKSPDyh37pwXGGQwQe8ocu
 s2n6vdFKxoGTIqpxaUu5Qp+TAJ8MjfnSr9Aj5+J5Rey0ENU1DO5JuKkg2claHr+Ed0SaPEAMJ8q
 jo3hltOXgM+DwlKZ5QRhjWQ1XoIS0HY4zPRKR6S8+ZnmAPCCu/8EyLchMmHbVaa+DwpQgEloGim
 Fnf7Z6vIBeeY11whG3GeJ3djB53tI5w+unYowEdgy+0ednlR1Yfls44N5KuObfa40f1geu1YYqf
 0b81lWQOw+2Xr12Qm3igmSysTDNsitvyerdbM5TUFFCMEzK7GTBAUnJ7tSqGyER6qNTEi4V6
X-Authority-Analysis: v=2.4 cv=RcqQC0tv c=1 sm=1 tr=0 ts=6854117c cx=c_pps
 a=b9bpObgcEOTp51h0EtjbnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=pwxC0n7aooic8zlvp-IA:9
X-Proofpoint-ORIG-GUID: 5ty87x5o4K8Qe5wr9Aq52B6CkLd0sOEO
X-Proofpoint-GUID: 5ty87x5o4K8Qe5wr9Aq52B6CkLd0sOEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Add new message to send multiple writes to server in a single message.
Prevents the outgoing queue from overflowing when a long latency
operation is followed by a series of posted writes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 21 ++++++++++
 hw/vfio-user/proxy.h      | 12 ++++++
 hw/vfio-user/device.c     | 40 +++++++++++++++++++
 hw/vfio-user/proxy.c      | 84 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 5 files changed, 158 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 3e9d8e576b..3249a4a6b6 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -39,6 +39,7 @@ enum vfio_user_command {
     VFIO_USER_DMA_WRITE                 = 12,
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_REGION_WRITE_MULTI        = 15,
     VFIO_USER_MAX,
 };
 
@@ -72,6 +73,7 @@ typedef struct {
 #define VFIO_USER_CAP_PGSIZES   "pgsizes"
 #define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
 #define VFIO_USER_CAP_MIGR      "migration"
+#define VFIO_USER_CAP_MULTI     "write_multiple"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -218,4 +220,23 @@ typedef struct {
     char data[];
 } VFIOUserBitmap;
 
+/*
+ * VFIO_USER_REGION_WRITE_MULTI
+ */
+#define VFIO_USER_MULTI_DATA  8
+#define VFIO_USER_MULTI_MAX   200
+
+typedef struct {
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[VFIO_USER_MULTI_DATA];
+} VFIOUserWROne;
+
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t wr_cnt;
+    VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
+} VFIOUserWRMulti;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 28233f0d33..0486097781 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -85,6 +85,8 @@ typedef struct VFIOUserProxy {
     VFIOUserMsg *last_nowait;
     VFIOUserMsg *part_recv;
     size_t recv_left;
+    VFIOUserWRMulti *wr_multi;
+    int num_outgoing;
     enum proxy_state state;
 } VFIOUserProxy;
 
@@ -92,6 +94,11 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
+#define VFIO_PROXY_USE_MULTI     0x16
+
+/* coalescing high and low water marks for VFIOProxy num_outgoing */
+#define VFIO_USER_OUT_HIGH       1024
+#define VFIO_USER_OUT_LOW        128
 
 typedef struct VFIODevice VFIODevice;
 
@@ -119,4 +126,9 @@ void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
+void vfio_user_flush_multi(VFIOUserProxy *proxy);
+void vfio_user_create_multi(VFIOUserProxy *proxy);
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index e787fd542d..e2664760cb 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -8,6 +8,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "qemu/thread.h"
 
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
@@ -294,6 +296,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    bool can_multi;
     int flags = 0;
     int ret;
 
@@ -309,6 +312,43 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
         flags |= VFIO_USER_NO_REPLY;
     }
 
+    /* write eligible to be in a WRITE_MULTI msg ? */
+    can_multi = (proxy->flags & VFIO_PROXY_USE_MULTI) && post &&
+        count <= VFIO_USER_MULTI_DATA;
+
+    /*
+     * This should be a rare case, so first check without the lock,
+     * if we're wrong, vfio_send_queued() will flush any posted writes
+     * we missed here
+     */
+    if (proxy->wr_multi != NULL ||
+        (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi)) {
+
+        /*
+         * re-check with lock
+         *
+         * if already building a WRITE_MULTI msg,
+         *  add this one if possible else flush pending before
+         *  sending the current one
+         *
+         * else if outgoing queue is over the highwater,
+         *  start a new WRITE_MULTI message
+         */
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            if (proxy->wr_multi != NULL) {
+                if (can_multi) {
+                    vfio_user_add_multi(proxy, index, off, count, data);
+                    return count;
+                }
+                vfio_user_flush_multi(proxy);
+            } else if (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi) {
+                vfio_user_create_multi(proxy);
+                vfio_user_add_multi(proxy, index, off, count, data);
+                return count;
+            }
+        }
+    }
+
     msgp = g_malloc0(size);
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0436994647..c9bcf39f4c 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -13,12 +13,14 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
+#include "qemu/thread.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
@@ -441,6 +443,11 @@ static void vfio_user_send(void *opaque)
         }
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, NULL, NULL, proxy);
+
+        /* queue empty - send any pending multi write msgs */
+        if (proxy->wr_multi != NULL) {
+            vfio_user_flush_multi(proxy);
+        }
     }
 }
 
@@ -461,6 +468,7 @@ static int vfio_user_send_one(VFIOUserProxy *proxy)
     }
 
     QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    proxy->num_outgoing--;
     if (msg->type == VFIO_MSG_ASYNC) {
         vfio_user_recycle(proxy, msg);
     } else {
@@ -568,11 +576,18 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
     int ret;
 
+    /* older coalesced writes go first */
+    if (proxy->wr_multi != NULL &&
+        ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REQUEST)) {
+        vfio_user_flush_multi(proxy);
+    }
+
     /*
      * Unsent outgoing msgs - add to tail
      */
     if (!QTAILQ_EMPTY(&proxy->outgoing)) {
         QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        proxy->num_outgoing++;
         return 0;
     }
 
@@ -586,6 +601,7 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     }
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        proxy->num_outgoing = 1;
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, proxy->ctx,
                                        vfio_user_send, proxy);
@@ -1109,12 +1125,27 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     return caps_parse(proxy, qdict, caps_migr, errp);
 }
 
+static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QBool *qb = qobject_to(QBool, qobj);
+
+    if (qb == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MULTI);
+        return false;
+    }
+    if (qbool_get_bool(qb)) {
+        proxy->flags |= VFIO_PROXY_USE_MULTI;
+    }
+    return true;
+}
+
 static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAX_FDS, check_max_fds },
     { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
     { VFIO_USER_CAP_PGSIZES, check_pgsizes },
     { VFIO_USER_CAP_MAP_MAX, check_max_dma },
     { VFIO_USER_CAP_MIGR, check_migr },
+    { VFIO_USER_CAP_MULTI, check_multi },
     { NULL }
 };
 
@@ -1173,6 +1204,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+    qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
@@ -1225,3 +1257,55 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
     return true;
 }
+
+void vfio_user_flush_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    int ret;
+
+    proxy->wr_multi = NULL;
+
+    /* adjust size for actual # of writes */
+    wm->hdr.size -= (VFIO_USER_MULTI_MAX - wm->wr_cnt) * sizeof(VFIOUserWROne);
+
+    msg = vfio_user_getmsg(proxy, &wm->hdr, NULL);
+    msg->id = wm->hdr.id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+    trace_vfio_user_wrmulti("flush", wm->wr_cnt);
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
+void vfio_user_create_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserWRMulti *wm;
+
+    wm = g_malloc0(sizeof(*wm));
+    vfio_user_request_msg(&wm->hdr, VFIO_USER_REGION_WRITE_MULTI,
+                          sizeof(*wm), VFIO_USER_NO_REPLY);
+    proxy->wr_multi = wm;
+}
+
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data)
+{
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    VFIOUserWROne *w1 = &wm->wrs[wm->wr_cnt];
+
+    w1->offset = offset;
+    w1->region = index;
+    w1->count = count;
+    memcpy(&w1->data, data, count);
+
+    wm->wr_cnt++;
+    trace_vfio_user_wrmulti("add", wm->wr_cnt);
+    if (wm->wr_cnt == VFIO_USER_MULTI_MAX ||
+        proxy->num_outgoing < VFIO_USER_OUT_LOW) {
+        vfio_user_flush_multi(proxy);
+    }
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7ef98813b3..64fac9137f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,6 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
 
 # container.c
 vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


