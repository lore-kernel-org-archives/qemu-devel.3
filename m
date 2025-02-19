Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05BDC021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOO-0003J8-8l; Wed, 19 Feb 2025 09:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOL-0003I5-H1; Wed, 19 Feb 2025 09:49:37 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOJ-0007CD-Oz; Wed, 19 Feb 2025 09:49:37 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9Lst3011379;
 Wed, 19 Feb 2025 06:49:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YNuD0PXGBECTDc5z781n3QjmM1jjnUtEiN7jRkmCD
 kM=; b=uZ+QglhlngsUS9bx84qz0gEDFDJDkw/H+9GTuc1Yt3orb2e4mgxUoq0lc
 DNizl4XYcCMX3FlzmJw5rn8+id4aO0FzK1XC3gPzVEANntxjEIMtOu1VoBGELNmp
 KPZkjov/wzI+pZX/EGusk0BCLv+3yoCtLJIYBEgAANw9sVIyTnS6dcZhXTsP6A5v
 4X5LNkgfhZzK1i9iGi6tTBbmTuZAvzb9DkltuM/EmcxFDkRWejjl2XxdNiaFsmti
 R96xZLYAeYOREoH7IPoSE+P6SgpNNo9G8sm8HwJZr6lpwY6CepfwPD8o8tZrNpb/
 CkKV0gKgMAs5A44Xde2Pt7nw3Zl2w==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013058.outbound.protection.outlook.com
 [40.93.20.58])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bdhxw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXtdbFZS63kM4iNC0IypNRyAExWFuiIn/ma8T6SobtnTKJSJLUad07tyNnv67v8At1syBZoX7w/t4arE8UulUjEPvwQLUgj14+XSY3Iev3/3y0RKRQVly3nEerKPfQsSg9z5FVnFgUhpDdHyzDhqdefWmvJiyK89rRY1Xs9UoiaUBJwYUwLCOkIDP5LHFEfqZnJiA0nIeFBzkFayeGY9dK695vs4DH8gh0LTf0UP8evvun8J5kYSAqSYr4Yjrdh0wUuKwzS3pDF5sXa2mt+2aXx/VigN1kCA0nV6tkRapw/qje3wxXR9eY/cD+nqwhNWyWVkH9JizBxAwk2M27c+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNuD0PXGBECTDc5z781n3QjmM1jjnUtEiN7jRkmCDkM=;
 b=XD4hheFfsTmDIV1OmSdG+HrIc6t7Rw6RT3fmggCd56kV5Slsc+FUSdyQTYDbEuHw19M70ihQYO4lal3jvpSUiKUU0dYuP01WZbxO7quAKGmOTcCzQRMLlJtTEXaRMat/Ze6nflIpDBTRccC2C/KLuAnmCjL0TGUItU7hrZEI5F1S7kCkaSyAP9kMNsoakZrF4O23oO/XXkcJFPRTjrQniK0caNnzmNL62FjUc/xTm3nMcL6ChNSKMCs8lYPMrLyeaUocw8ykPtSl73puT8M/TQdPt8z4npIDNK/piZdjPvbaC7dxbXV76TKWTTGqMA3l8yKWhCQHzgffrCMK41hRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNuD0PXGBECTDc5z781n3QjmM1jjnUtEiN7jRkmCDkM=;
 b=kIW0zSEtizFtEHBFp0lr8dQje9QAt2In/Xdkyn2/yTVm3VAll/hsgfpBY/d9xPbSC7+F2Bt6JTxvhG2spvHxABXQH51a+P1r10cV/A6KWBgxFmzC+ynI/c5Ehufcmi42KSpG5b+HGLE0EjkY4EhbbO8zWcT7TMOei64LNQludz8OHDe2sQma/XaFVM0r94oAwc8jsa44rqPvpWsx/Kp6mnQx+YWLVrUXaMCSJPBjtAHpt7OrZWGq69U8140PINSHbk1AzgJVkapcalT3NVl4BpW/6rw4GJqgkbpP1ny5/6NK8F4IYZBaVPKyT4UVJkzbLr17Twt/mvCCxYfxFzhofQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:30 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 06/28] vfio: refactor out vfio_interrupt_setup()
Date: Wed, 19 Feb 2025 15:48:36 +0100
Message-Id: <20250219144858.266455-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d99be53-0033-48f1-d27a-08dd50f49dde
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GtqoGq291ecKt4Ocu8S/DYQY/ZbTttsaVgYjz7F5wg1tWq8/aed993+wt1fp?=
 =?us-ascii?Q?M6oA49k0ACSG/o+gOOv7m01YZdY8UU1Sk1IBxVFC6RjrfLZogUOJkZ4W528E?=
 =?us-ascii?Q?btixy+vHRNSZxH/lC5UpNs5+pL8wJzpKR7qBr6ICIR3QlUo1Sa7MfNIUrMce?=
 =?us-ascii?Q?Hvbxv6W3Fwy+rd8TyP2BE/PfRDGLyWxs+Mo/BKP/CZ3VXJaBbjWywQKMqZFt?=
 =?us-ascii?Q?BEOq7fKY2GzvlMTF3+RLUXI1oxC/3nxvONbgmGels+OgjwTQpR2YRb3KTDWW?=
 =?us-ascii?Q?l/t8NLNJm4N6siyirGEzQfa4GymAwdsl4y0pt9cLXdpNspA6IEG32bZtZme2?=
 =?us-ascii?Q?ZLc1Iw/YXaCwvEO/qHSXwJSkkaRAq2KF5zvTgBP4oPOH2Rf2FwrexKkfXwwr?=
 =?us-ascii?Q?5cFsDAJTM+5IXz8RBijpYlphkC/06cX5UAu/npVn7mXDnc38KmADsF+JT+tv?=
 =?us-ascii?Q?qITgPsaARmtP1/8YXeTjNwQvYcFg3acynx/VAqOn4AVRqOYRpHceFkSYtdtw?=
 =?us-ascii?Q?OrsQmpqf7ggnw0jF08BXf0ehckayiv0ityAY/EgUfm4jrmrTib8dH7lKCZBC?=
 =?us-ascii?Q?oW28EKn5f1kEmud+W+I6ua/KCzz8SlhMJ2USU19kxbwDEE8r6I/mqBl9GUjg?=
 =?us-ascii?Q?gPPE75El7rsbK1wva0N0RZuP/uimT4M4PVINO5b3yJrS8e4BnuGw46S5OtXn?=
 =?us-ascii?Q?SUElfsY/mV4Ht9a5hcjOqXgCDJVlIP4ppAZybFNbZDObxbDLvC9znzRjZ/cS?=
 =?us-ascii?Q?Sif7x7yEuuLLzKikIpZpmqf/Lk4jRMLBH0RAGhpcZ/oTDvSvoMthNS9TPYfp?=
 =?us-ascii?Q?eMzzTxFykQX/t7mOLroeZLmKv2UeGViVR0uJfsZz3dKTUsIQf2XQspVbj00b?=
 =?us-ascii?Q?PN/72Bu/bCwyWjXU0PSPMK9l9ncV4dZfUfP/6PPIopba7JsO9pLXiid7Uswo?=
 =?us-ascii?Q?5W+PR1sDCyQMy0vRDoO1vIfKGjjE2cbY7rmLLiHzYqvPd8aO0WOxdSfEs4QD?=
 =?us-ascii?Q?cBfoZ51qsMSyNmiRjfOD8iixA0CkK4cGp3GCnJx3LNzzdJB7JAdaDAN2WAtH?=
 =?us-ascii?Q?vXCV5YLR9fzrKYgoP7UmU5FjbgnEBpVSd7+f+Wva75FvN5tietuUJ/quTYpD?=
 =?us-ascii?Q?IzdDok3vsxgOgpHQbMAtyceECAMcz++Y+b9SaWTmWDQJb3qrE9GOQ51Bzx04?=
 =?us-ascii?Q?nwtNXPvWuQalvHK2GzonF2Xh7zOGRrLsV5hrh0TG44KxiAAsWSQXCb7MPf8n?=
 =?us-ascii?Q?FHGRsEtG5l5UNzWP/pk1Zi9AWnJQMHDr08o46a158tPkYYjmkznFReLNyBjv?=
 =?us-ascii?Q?plHAPYbcWJ3ZES1f76e4V6w4INVjfBP2T63+r7z4oLMz7u2vjrCOHn9jyJhe?=
 =?us-ascii?Q?pub9YfFg29jy5civlKaj94BFMQb8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UyjD1VW3rnMLke6eUe+ssZXfdfV+zjrIG9WD0jPnfoRr8pda18E9ing6Avjf?=
 =?us-ascii?Q?tVHVNbp8ouVEqQYfldvYmfUPXK9KfJf93L6sO5Y8fKdOYDvbInCYEAZFXWMN?=
 =?us-ascii?Q?Vfo0hvdop7I1Z0W7gQUkbjyEggTR2l544bEKfBhFE3+C1y3L2dPq/1jukXEF?=
 =?us-ascii?Q?s92GUP//iwpD58Jxn6kS8FQ+5sZNQ4qiUdICxCqiBJGcRcjwgMJFjeEwURnR?=
 =?us-ascii?Q?58NnOwFQxX2I3uN2f/Za2JXJPlauha+tNUnGDqEm2GdbiTaM1gny6yIU68yf?=
 =?us-ascii?Q?L9yUV6fBAPyoiu/9e2ON2iH/tPH2Tl5guI9kl+e+ovKUu35JCkqzr/8o4CTU?=
 =?us-ascii?Q?1X98e7KSUpL668syZ3UgR9kIoLGi3X02hiX4D02e+Zzq9jKTQshsexYarb9o?=
 =?us-ascii?Q?xLdGAY4UFtk4q5YsILt50xgdrvQJku0EIGKrpESnrZt/hJEFv/56XKP96Vf5?=
 =?us-ascii?Q?GhVo7Omeir6adQJ1DAI9GfK/ckbXJBr3mOkYPixekbDVUweG5Ea9Wbyon5Qh?=
 =?us-ascii?Q?wq8wNQioor5fDLVk8bjmee7m8RjWwlQX1LVtimuUB3LIzhJujJeitZK/zOc5?=
 =?us-ascii?Q?UFzP7HCHwT2yD1ETfABgRf6ZJux0g7+0tsH6dZGWnVEszxkvtpB4WHmj+2ar?=
 =?us-ascii?Q?YrkZL2sVrO0NvS23hqKKzO6k3kei5zpYcq+hhWIEbbmlgP9pOlvcM0qE5BCO?=
 =?us-ascii?Q?sNvC7NQGptdr3gcTy8ghesZbovbvZpeBooMwmM7EUIWBoGbqqO86X98O6JuQ?=
 =?us-ascii?Q?uZ1bwT4BvY9bJnQVcrEOqLsddIxmOq2LzU+dzWUci2BEfUphKLjGtARh45Fi?=
 =?us-ascii?Q?9z0of5O9guRdbCUbj2vr83LHxy+DBr5ReiFmQ4whdUOsmYSP/beOTkABTN/E?=
 =?us-ascii?Q?7haUb0Pkj9PLdz9LWnR0hmb9cIX5arSpPZeNse6Wlq0khOIQUy9tFOzAgeMt?=
 =?us-ascii?Q?7R9kVJdBTqqfSYvcAL/szVGqlT7GPXQmnaxqtARZMm8m6YL3c2l5YIHOewUn?=
 =?us-ascii?Q?BTqtYiODsg/hXPkmBnYe+rT+c4GwLqi/kWxCdP7/lLMsdiF6NR4z5bQLdIEB?=
 =?us-ascii?Q?UGpm1YGTNoK8aTsm3Vhr9DbbPtjBdzj5ITIdH1liIC15iX2wgnWPj9w1+a5N?=
 =?us-ascii?Q?NmbPQ0eufjLj2MJwzVoXnd4zsb2sZYxcvfa+dAaZEiwEgwe0mYFC0icSrp3b?=
 =?us-ascii?Q?W8kxI3JYmnQZf6W1Tsd9KfQ8S6u/0XSy0gm1qmF58PU7OslO1pD50Aokpupy?=
 =?us-ascii?Q?xFmIPI+kAUhfpe0VjYuNJQ+deUjTG6o5QtiKiz+TInnMSmOxnu57ygZ34n5C?=
 =?us-ascii?Q?AqqgRYbGFh0vM3qcWJaa3em1Pa1p544YjvA16sYsplaEjqe8snm1uqPwc4pZ?=
 =?us-ascii?Q?eld3pxKRjelGSUOGyUbtGWaM1NGsLdiNmBIn3mJ6vxVEmRBoxzBXznq3G48S?=
 =?us-ascii?Q?jbFjeCsKNeWU6dPJdOPtoCBiHhPVVh7pLpYhC9I2Jt6ybZHPGNzRDRTTLADI?=
 =?us-ascii?Q?JXI9VrwhMg1mFRkvIeSdC2nRjrZU/0i111ndvRDh8DMKw3xRjsbI/Cu2kSRJ?=
 =?us-ascii?Q?L6pAqn02YeTEU1mA7/bTmsjQdwMONtaCPOlpmv7B?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d99be53-0033-48f1-d27a-08dd50f49dde
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:30.8629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8se9jg8cA6yxGTzf6Qc6AxA6JZdq0m1ARKmkSQ2aizsyZswYetstgF6fiSYcT6ZUdFY9NNqr9Ff4ikrMKdmBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-ORIG-GUID: SH-KHXSU54c47Hk7u8uaT5MM1htHN_G5
X-Proofpoint-GUID: SH-KHXSU54c47Hk7u8uaT5MM1htHN_G5
X-Authority-Analysis: v=2.4 cv=Fo7//3rq c=1 sm=1 tr=0 ts=67b5ef7c cx=c_pps
 a=UiiUhvOI59TtQsb/yF5oqw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=DOYYwuSLhGa-iB6POOMA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

Refactor the interrupt setup code out of vfio_realize(), as we will
later need this for vfio-user too.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 54 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 89d900e9cf..5fb6c4c4c6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2957,6 +2957,37 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+
+    /* QEMU emulates all of MSI & MSIX */
+    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
+        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
+               MSIX_CAP_LENGTH);
+    }
+
+    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
+        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
+               vdev->msi_cap_size);
+    }
+
+    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
+        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                                  vfio_intx_mmap_enable, vdev);
+        pci_device_set_intx_routing_notifier(&vdev->pdev,
+                                             vfio_intx_routing_notifier);
+        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
+        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
+        if (!vfio_intx_enable(vdev, errp)) {
+            pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+            kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+            return false;
+        }
+    }
+    return true;
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
@@ -3157,27 +3188,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
-    /* QEMU emulates all of MSI & MSIX */
-    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
-        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
-               MSIX_CAP_LENGTH);
-    }
-
-    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
-        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
-               vdev->msi_cap_size);
-    }
-
-    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
-        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                                  vfio_intx_mmap_enable, vdev);
-        pci_device_set_intx_routing_notifier(&vdev->pdev,
-                                             vfio_intx_routing_notifier);
-        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
-        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        if (!vfio_intx_enable(vdev, errp)) {
-            goto out_deregister;
-        }
+    if (!vfio_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
     }
 
     if (vdev->display != ON_OFF_AUTO_OFF) {
-- 
2.34.1


