Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE26C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPQ-0004dC-K6; Wed, 19 Feb 2025 09:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPK-0004Eg-4P; Wed, 19 Feb 2025 09:50:38 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPI-0007cb-0O; Wed, 19 Feb 2025 09:50:37 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JDJ7w4008185;
 Wed, 19 Feb 2025 06:50:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wTeY5bgrk9IMtnV4kh7v6+m+mRcJTI0QQQetnoJiv
 f8=; b=17mOsGtqVZNRlfngUkMSlydM7Rlc1PFncLpP8K47++KM0T2oJwJWQhmhU
 56OBiJNaqAL9SrZNDKqDYM+WfggjC0A8KpWsNc5wbiRodWOB6rQQd90bEIX16AJr
 SCJVTTJLM4dqXQ5VxtaSPDOoZEt6cGZ31AyZiFsWRTJsmMhpMOlX//ARuAu0rYdi
 yVXwOR3P+cMLbRhhA0us9cdxN9Jk1J0vYfmVzGWCahw6x332S2f3EXqKZRXT1zOF
 ThFgOH77HdPXAca5UTtVaqvh6hwntBQjWbBxo/zJtpu4dLMyPbftZjT0ifY5I9h6
 9VRm2AW/4Qf6bN6z0tABYsqrOUTQQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44wg2wg7a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrsiLuEURDtlfX+4cAIQM72+WmKORFM/H30LzUZ3dHEv10tiVaBz014+/1iHWD83EesrHJizvr1C1g4xv9tD4SzAkSuVvEs7CIVk3Lb5zBFsRAY7JlbWqjJrbyHJKL6S5MzhsR+wRUlypT+EsxjQql+Zwk7R8nu9VqcBNc3s7U0ovXEvjWlSH/FAPVQ5iqI2Dh7e8O1je7dzeROMLbV9MwqONbKB5PXtIZSczM7TQX5MfjR445gpijhAce9VXJ4TPb4So8ARxWgBkdYeLFmetXqoVsusxyry5K7YKeHG86DATc2X24qcH24Cym0DXMJqUvrBDyR4W/dzIQrAh/O1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTeY5bgrk9IMtnV4kh7v6+m+mRcJTI0QQQetnoJivf8=;
 b=EGzXt0iFGghtNol08R3TnVHCML+9ZddG35jgV9wI3jl8xvhwN0T0e1omUOQhkYjX2VHynLhJJGi9X12KmIDieWIYmE3pVNcuFt/1mExbW6MPKtAZMD98Ffqg1kGOiRgRYFpxZ0FPAbLsr4LaW9RVYQrTIO6E+N1GEJCphO9qAj7OVpdgOTFT38VIMcQkCQakbkv6RAxVyLjYR6JZsHMJA87Kcvao4LQlNidkSEG4ePYXprLQqvLR0cEZiGdVfS/PZYBgyzR09Lfp5tTmXQN36BZou2Yl3HGlrUkZzNB8e4bcZOfElyJaTXfC+BcaGzwaEk3QNa3UpAnIv3e7Z/B8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTeY5bgrk9IMtnV4kh7v6+m+mRcJTI0QQQetnoJivf8=;
 b=lGRlDmK02YMv2ogMc1fG3qR7RK7/+XGyqG5+VszMXs1/H1imWiUsZMEo+Jx5J3veru1EK9kkgUOIersd69w5RE6P9sZv+owOXCteWx0o+MFYJ0oB6hN9YfWJDgNG704OUfcSn+WAOOJVJS7lVHBK3XXX/UExZXL9gJwC1WcaPdkb6tgsRCQmDoBzwlfhGKIx8CpHbWDRvVfRSjGnyjzNyTt2viCoaF+364D1xkOh9C6Di0rfi49ChZDAGK5xsN6WBB+iLBR7wRLuNOLq5rW2NSk8FLSco0kUQ05hX0/UB9fQJvnHHXtx5eUmTyvRiuaotB21PT1dBMRwBODrOCWTuA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:29 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:29 +0000
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 23/28] vfio-user: implement VFIO_USER_DEVICE_RESET
Date: Wed, 19 Feb 2025 15:48:53 +0100
Message-Id: <20250219144858.266455-24-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c62de3-9d84-4009-ea96-08dd50f4c103
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eAiI+gd078B9fUNXBwo0bi+lBaq0VxAW/yB/dHuu4VL6jmXxvpC+ckMNCIES?=
 =?us-ascii?Q?ORB0pGg8EM30/Xnahp9qYO5VwMsdgzqKjakWaug7LJt1dv8IgxCSkxN45lsw?=
 =?us-ascii?Q?vvWDhMQG3+EUtw9IEHIe5C4g3+uKA5ns+ExwrSMU/KR/MNHQ5xXEG4lCsqGC?=
 =?us-ascii?Q?flvrDHMI6ByKd1jRTCY2XyqqSZUUdubIMYit138+d12w/aQIbn3259GDLbk5?=
 =?us-ascii?Q?CADSC8bojDXzrEmI/a/GsI5ixDLpj2Yc6Uss2bLMS0o/jkgvJ0VHTvV72Mc0?=
 =?us-ascii?Q?MzDaVbZ4TZ2g8xcmWY7kNNfmnSyai/RgPa0jN65pIjVAd1AMNJutSoZ/eVOY?=
 =?us-ascii?Q?vUJvVcqTBu6tqB2q04x4Zy3wA9bPBLL4+6+fpUJBaxLZ2lzWuuGFofyONAyx?=
 =?us-ascii?Q?xzztaYlVqmI3tINiUzWx147t/vv3Ud1oCN3Id4tkV/CqlpGjfg2cF/fGyPvH?=
 =?us-ascii?Q?v6beDJ7GYYkNdquO78coeV/2DDaP2QRpFHMcZSTVWyCLju7LQcTBKFTCFIGt?=
 =?us-ascii?Q?XvWceXtTB9NhluAydizXx1fNaf3C4KIQqI9P0Yzb84xQdYJAYiKPWHgZwAyM?=
 =?us-ascii?Q?xzcHz5XEEGtJw300Yykf28+bq/RldS6fKuIKE16YyGEL6FV1nITR7qT7WQoY?=
 =?us-ascii?Q?xJxY3nWKsT2jtgQ+/NlzdUhh0uNDE4D5bd6tJWNlcP29y1bqSnnnlkWSmi+d?=
 =?us-ascii?Q?ttYauDBI7U/eIKP+o9VGj35MsrTwgcYaLz+CMWir/Pbs/ciFRoA2EXwo/j2V?=
 =?us-ascii?Q?Kd7rCDN7CUXxUDMs4u5HNr3YcEKVEADu27CaLUP+4FhYKqys2Uv2Vrh1na4d?=
 =?us-ascii?Q?haB1H1aisfiVL6ohHG3HEYLdGU8Mw1NJ/AzJH9V+iXORtSYM2z2y1EMo6qAv?=
 =?us-ascii?Q?GFjT9/7gLzksjd9ZiuQdeFSfZa9QyKmcjXLut+PN/MdRSOrDXv/QJ6DDaoWC?=
 =?us-ascii?Q?Py/sJG0cLz8mj5+PY6vY0Pc9sT9b1AGoQniW3rg+4TIw/IKuR33OU9xwPBRx?=
 =?us-ascii?Q?BAaOgDj18wiask9x3BbHb7WZRg/pvkncHdISWrLf/tTMvXIp3jZNdXHZNTNI?=
 =?us-ascii?Q?7TdYXS1txa3J6Xgp41jGt7IFM//B1lnJJ94wsYVKTygZvttQEdDdOOZcHLYw?=
 =?us-ascii?Q?WFU4EWgPqx78di5yG4MeRO+7h8DklVyM1UPxoAuk10OpuBDFYeyTDzBhXmQT?=
 =?us-ascii?Q?UuUxu2v+yBjkPEqx/SYVDrMSPfnY1gIJhWVXmWYzZVzLlvX3XpA+Vg/Aynos?=
 =?us-ascii?Q?rBir80lbxSoy8FI5PnPbvRHbHzSXPpaxDCnFyJd+1SYftkAaFV6TBCR9WLoB?=
 =?us-ascii?Q?z+mG1cAt2xBn6bY/8cXsQbgdYdOSs8z26kt1I54YP3nxjv+ncK1wQe3u6w6Y?=
 =?us-ascii?Q?xSLAuWLNk+VVKjcONoeQl9WRZGyB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KA6q58ysfyjAguOVIpp/2FdYe9kzhVXivSes9N6TvPcrjuJaOalBIrjbELSt?=
 =?us-ascii?Q?Iuz/JN6ZdQpmgHNmZgz2RdzeyoSqmJ9ylyuKI9AJc+KZ6VgufhGqIlKX97tG?=
 =?us-ascii?Q?6PO6XkKzHahAQfJ7GGFZZWdKQPgheKDSrg0clJGWTezDv/r1BECMSx+JAKa0?=
 =?us-ascii?Q?Poio84xtttbhdRDVQMQ5Oja84XORjTAMosW22X5dIENvKNzvUwBklMQKeZ8u?=
 =?us-ascii?Q?8mZpvBFra9tNwg8MsYcYf/ruZdZ5YvdB7wrs6n6m34vi4uBsxTxKmWMhKb3M?=
 =?us-ascii?Q?O6GZumr2o8kpYZ9mgwRTtaBm7P4caRyq1qS6kJdidr8iyxQGnfFBwYm13hNd?=
 =?us-ascii?Q?X+Vq66dlOxsLsOjWUsQgxptpacUMIvET37+vvr34fO5TDK6Nq8WORv+uAi1Z?=
 =?us-ascii?Q?OqqDweNhKL83lCnel2zQC3wx4Lw+XWT4WOcqCRlqstlDW7mZqmsUFYkzdhE5?=
 =?us-ascii?Q?RJTyl+5kk4txvMvZD9UP20vwDHlTvl0RWTebu6zLhKJEoq/VSNa5bIbdhlDR?=
 =?us-ascii?Q?6GQu1dtzwEfijZYGC8+WHCXLBx1Zkba9bMf8wdPPa2szMFa0n8ULXGH3D4q3?=
 =?us-ascii?Q?nBjcRGrNRHUWDpfZtE3tpB8PWJfU7faHh1sk0NiF20eUEdXs4gQaIZT+K8FJ?=
 =?us-ascii?Q?60IkpXhd3cLBWqVwywPyn3bc9irMMxJUeNGAHedOm9sCOwNr/IMYxh43EpuV?=
 =?us-ascii?Q?8GkRxFsV7XAEKlaX5E2l9/vSR0GoBRHmrmIoCRQJ9YAjnjW7/u7Ze5ukPAOO?=
 =?us-ascii?Q?rv5OxxPVTOvGcEHxGJAeIHtea2UishhcuUGqNX6pdsEBhvjk8POjcHiAjntF?=
 =?us-ascii?Q?z9okwirTGkvzLma4w4eLTEPNDMwWUQJt4ZtZM8O8lUkJ7oZMwewpXirMJ3Q4?=
 =?us-ascii?Q?q3M+nuk5x9y5lU6fm85Tm7UFy5NzFnDoNgBz8TgFt1yUK+ieg7oU2417VM4M?=
 =?us-ascii?Q?lR329w9jJXdbxXcGherh2gHl2jlMOoxjVJeaIoqQww7SMz9KjUBAWp2TbTin?=
 =?us-ascii?Q?9WPuUHUFjRuu+n18corev+IQxupB66P0SbZ1vt/cO38Afe1NHafSWjpZtoU0?=
 =?us-ascii?Q?37O5ffXzWrmoTPclpAEQskW6ZhhwEZzHmSnpeDw2R/CaGGAkZhFv9t/MOYjw?=
 =?us-ascii?Q?MQ5eZMmgW1yBaxO3fdl5e4YC0KWThGvX73B9A4p8vtQQ4YOaPH/0rnG5tzhX?=
 =?us-ascii?Q?jlAXmZPIesfaLk8VyF9x0ORvOlZrakX5cYf9NZY668TlNUskzHEFojh4jdJE?=
 =?us-ascii?Q?yw4WdK5UXDhsTovrcbc4Y0Iuc0srAgXUjGHK91FGt5BFdQ+s+c61AvZUtRP8?=
 =?us-ascii?Q?RASbtOkavmhdMAVL/v5ar0x5lg4tF5Sp4MH5wskobxCS14ekgOFgIQQHwAH9?=
 =?us-ascii?Q?VQkh0YfvtaKulhBO3tbhQr/HgavnYIFN/OV+0u2+M5tWUNIEkbU3WFRIO3lA?=
 =?us-ascii?Q?bTao02SXczvjlqb0SRJmJaN/1Bbui4xO4v6crg+J+Dv1jHP3k7e80BLdR5FA?=
 =?us-ascii?Q?zybqXDWKoSIs3NN8k6AT1L/kA2TDXcjNZHAGdg3jxpjPscohuA6eHDeyzbYK?=
 =?us-ascii?Q?dlgqqagckJB83IbC9cOcuMwpsLFTsjlYHDdvVYg2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c62de3-9d84-4009-ea96-08dd50f4c103
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:29.8490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHTWmbjtLU55wkpEmIFTjg2BhKOUgDDUPFP90UXhWgnZqLlz33rHmjxNIa71yVbkYh3FDtcDBp2iqGWyLDTSDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: yyyPqQluq5NhqP5i5CTWhPLr--P9N8dc
X-Authority-Analysis: v=2.4 cv=Ps5pbxM3 c=1 sm=1 tr=0 ts=67b5efb7 cx=c_pps
 a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Vo7S2oCIfNTITXvqP7UA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: yyyPqQluq5NhqP5i5CTWhPLr--P9N8dc
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

From: Jagannathan Raman <jag.raman@oracle.com>

Hook this call up to the legacy reset handler for vfio-user-pci.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c | 12 ++++++++++++
 hw/vfio-user/common.h |  1 +
 hw/vfio-user/pci.c    | 15 +++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 182ef5ab8f..160a1f0536 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -1362,6 +1362,18 @@ static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
     return ret;
 }
 
+void vfio_user_reset(VFIOUserProxy *proxy)
+{
+    VFIOUserHdr msg;
+
+    vfio_user_request_msg(&msg, VFIO_USER_DEVICE_RESET, sizeof(msg), 0);
+
+    vfio_user_send_wait(proxy, &msg, NULL, 0);
+    if (msg.flags & VFIO_USER_ERROR) {
+        error_printf("reset reply error %d\n", msg.error_reply);
+    }
+}
+
 
 /*
  * Socket-based io_ops
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 31b11ed614..c09637dd48 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -95,6 +95,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info);
+void vfio_user_reset(VFIOUserProxy *proxy);
 
 extern VFIODeviceIO vfio_dev_io_sock;
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index cf1e642399..d520b7592b 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -276,6 +276,20 @@ static void vfio_user_instance_finalize(Object *obj)
     }
 }
 
+static void vfio_user_pci_reset(DeviceState *dev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    vfio_pci_pre_reset(vdev);
+
+    if (vbasedev->reset_works) {
+        vfio_user_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
@@ -287,6 +301,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
     dc->desc = "VFIO over socket PCI device assignment";
     pdc->realize = vfio_user_pci_realize;
-- 
2.34.1


