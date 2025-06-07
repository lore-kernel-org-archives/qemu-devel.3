Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72F7C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNhA4-00036H-GJ; Fri, 06 Jun 2025 20:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNhA1-00034l-Jc
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9y-0006RA-St
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:45 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556N0RtA023133;
 Fri, 6 Jun 2025 17:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YgOnQTNyG83d9gdChM10EEgQ5OT4pK5TkYiCd56uW
 D8=; b=KdB26dpra3vh6vQ0lELOxY+Mhf/I4XfZHI4sEGNRxqGv40vYvwNWsbnzi
 N5hESByHjz2htXgQ8dGW0xJIuMnMwtA7pJHLZucmtp2010lwSnhHuZPy3JuKRk81
 ODPouUIrScW71x2sKOpLtDAMd9LNi4Ydfd+r7XGp+floYKk1JNfQP3jzW3KyHBg1
 VE3DTK0oLmkQs8izFfyvbJT1f2PJjzk/Zk6zd2IAZGUvHqPnDwliC1FYmXCmNILq
 U1mn5dWB52osdR/orBomHIZf1IPViB1st7uy5JxOMo0vf4GvbKX8cqimc+ITdoOk
 Qo7LV+NayYThZsgN7Z75TV/Xd2cKw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2126.outbound.protection.outlook.com [40.107.212.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqb2-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqnMQEbWhu8QEKsupshz9sh/hZXTAlGy1+yb9gkZHNeCDd4lk3ve1pWPONUi5oYJlgE9p8ts5QI+8BxMAy2vzgy9xdnFy6rz4HFUiLiK/IcdqQbNNW48biDAaXEM8mK+SA/xm1KVmJEDfLsPGfAe9IGBoQFj+C+EXytmih526xZg0Gz18J79imHpX34TQk9o++VIUALhmFlm0pprvNMaSD146E0G1K349yjR6T2ynctiWqAGyicLfm5Fz/JbLtSa+/5seApCHpTPG/YGQqLVGB+HWGBoOiHhcKndirTbLrhbQs9a/6UhvjwLptZ2hzaLoXacDecDboIOOlTW1qub7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgOnQTNyG83d9gdChM10EEgQ5OT4pK5TkYiCd56uWD8=;
 b=XfURr0dC4gmNduxoHT4HNvxt82SGChoYC+2jyDWy3LpctaUNvSgrvyIX4Cz4g3yk5mcdC4o5/Jfk33YXiRGCZaLXKX2XBCMs6sYzOgRzo/Cf3s+SbmwzqOPcrDiz0qSQNmSGekDB/h9Q0eOtO8MsHOc+mCxlRvxz7BjEAKSIlDfvXc4wMJO2FpaGhAdBksEqHBu6Au5xPnFtKeVvvx8KgX1N2f8bdMQu9wFX+Ffk5Bz2GGKtnbam55vwN3IH0a6ZZZs5bBIyVQsScCD4iZLyvkfb4bx7FlFxKFWjowDLqgXynenhkisCaU5kZifPAR5tGS5eVfYK18Jf0GIa6KN6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgOnQTNyG83d9gdChM10EEgQ5OT4pK5TkYiCd56uWD8=;
 b=h2tRO9SbixFeMjm2gtdbrf+pOBbsMWUBNX6zlVSYb2w0Y94Y/TKB65TClwMjMtn4D+JBALcWwE8EZugpG4mujUkE9970oqCIJPtFeaB8KtSrzabMxOxWslnHnZiIIgrDhgCraQ/3sfhfDQDLURvwu9uvy6ZpPy1o9f7O5UvJkoxo8Jo9XWoZuxellBlx+eGw+5mRPTYVsR/BaWIqmEZIlJhJ+/D3dVxmXAGID3WVrmH7RXGOCQOAtLFDh77cXJsdpYSTCT7KislfoIOgAFfiqoTJU/LXUgHAS/qQ5AFoxyCS3MciNv4uO1pNhYQxsKoTxLvv4yhaTesfoUzVEaf6hQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Sat, 7 Jun
 2025 00:11:29 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:28 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 21/23] vfio-user: support posted writes
Date: Fri,  6 Jun 2025 17:10:53 -0700
Message-ID: <20250607001056.335310-22-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6fc7839-6794-4f6a-36c5-08dda557d995
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QRwEIeXhfrWWuDXOQVicgvk4PxK6E05xP7IO55HEDAkKiLri1cOmn+jD+tTc?=
 =?us-ascii?Q?Jdm1QsBtG+ujEYUl98B5YGoO19gIC1R54DXR7VzAqsEfr5FSOFEAtq94Qgtt?=
 =?us-ascii?Q?vNWuApK4A1GQiyvuO31ZNQXkw3qxwC2/wg9KlHeK4FJQ3nhOvtnFuyD865Fk?=
 =?us-ascii?Q?/yWqdGagf/rI8rbpQD2UMtK2yBkOLAE83YOHWX8G6Yt81KwuhMlX+aNthZ8a?=
 =?us-ascii?Q?5tcK0tmXIBtjQSoJQNlNgl90MF/0M+hGGZ0u7tXCGzf46YbnmC9fRhxzepp5?=
 =?us-ascii?Q?KuFTa93+aGKL9pH4K5X0LUyhE3M96Wme6Spw1Q8oCQ7t6/FpbhUxEO/lBba6?=
 =?us-ascii?Q?ZeIDvfwKQYI07T1IOezVLETWfQOGKaq7MQl81By5ZzSXJ/R7bZOET0F1dpEs?=
 =?us-ascii?Q?EG6yYO1Hh8RVwX4Viy6sSgwBkZNB+0mc8LOAbglDGYKBkxzX/rVOcvbCoVLS?=
 =?us-ascii?Q?T6KIA8CdHRQZFi5ARmQqwasmLPEY4k9tuN8wlDLmfSDOP6zTjXY4hR8LpeLA?=
 =?us-ascii?Q?LiUz5DOiNWdcPSPkVH8ptl9Fu5DYbBqTBltem1WhGKKxQgO47FfmqRwVBIrh?=
 =?us-ascii?Q?YLAvVtAYBjqbv03jxAoJrAtGjQT7erRN6dSB2vxZylpWs5rdvZW57VohB4Cn?=
 =?us-ascii?Q?ufB8/Q0MPyVdc9iTbhS4ntLZFKM/405TJ1G82mNZuwwcDJMOiW9tEeFOw7rF?=
 =?us-ascii?Q?Ivtn9G/PC9HDMpMsAxTDPhQZvJLhIqbN4VwuJpr3jfhzLNf5nMSqXc0gtzz9?=
 =?us-ascii?Q?klCQW0kybP6b2y437QSqfmUfV1DxEEiYND155okNEVYahmmvjEghUUEO8DNb?=
 =?us-ascii?Q?0Vst4qiqUFBNLTyPxT/lizpcKjU1WmBt5SA0t+pL1S9XQWu8L0K5Uu/fOWT5?=
 =?us-ascii?Q?Y8F9/eg7bhDSQA5NChLJizChVdZArPhl6R4MyOH1pUB3rbbR3qvvZxg0DU4p?=
 =?us-ascii?Q?1BLp+pAT8S7wxAocxmHg8wZARa1CbswQINkXCoy7Zv1UEV/wVVSUxRzas1IT?=
 =?us-ascii?Q?MOPGxKghsvX2npjN8TlwJJ92eJMO3/XYl/WhD96svUykbpKmg8UeTIx1bich?=
 =?us-ascii?Q?LQ6Aoyex1rTA105ZPSyTR9mS+OoeRtRsb+pXP8yZWpvGj0SrBxpD1A/NTw/9?=
 =?us-ascii?Q?pk4Vvv3e/M2z4uo3TYW1KHocmHvXqn96IOndn0s+Kgz9Iqaim5zXX4B8AN1D?=
 =?us-ascii?Q?n7ctD2tHsD1ZKS6oCf7KXhimYvx3rzD3fyF11a6gejQhC/BJi1l8OvjSeLpm?=
 =?us-ascii?Q?UZ9PXxq9rfAIV2077D9+eWz3tKnbXoA1NaQ7xlXyDBiIvkw5q/JD6JUDPIMI?=
 =?us-ascii?Q?NM1bFkMPG+TWK2sVAvoQ7S8+sQmMpovZfbLS665yR4N7QFKFhNYoP0PtLUu5?=
 =?us-ascii?Q?qS1jwtwTytl51vGTjcwog04qw5Z3VN50x5UE6zWcEBEUzXWbIrubbk+sD8fu?=
 =?us-ascii?Q?F+cFIgqEfHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0gwSd1I83IXpz6yrqRsD5dCVQxr+UQ7Jh4RiELMS96AYSDuAJ5XjtbixOO+D?=
 =?us-ascii?Q?2AwLUk3IonI9MD4ZiHNmPdyB9T/dlr5l5ZH449RaM1s+aCftjfejvW9PwL1o?=
 =?us-ascii?Q?myIfU36cagUveDVt+WoQQS/LV0S/wGRqckWSUXYLuDV23Lk0AcIyZfxrSUuk?=
 =?us-ascii?Q?thkN0KQ8LjyoYwYbHrbhandHhj4mZaydsBOy0XrObsRQDCXNdUA4Hosm19Dp?=
 =?us-ascii?Q?xH23jde1BjUG6aroqyofiS009kVtUEDeVO3ty2D5Mbx+ehboFbKoB/GqCntF?=
 =?us-ascii?Q?bGAidYeEkxHRUg0UJufiO7kGOefJ7GTlzcsHhjeUBC3QQV3azbosA4Ajh6mZ?=
 =?us-ascii?Q?IWgSEDU8dj6XX84AVhY99y2UHt8y4cQF+b+MWnsei0Ajdye83xFyw1HyAHfW?=
 =?us-ascii?Q?G9OCFlQd+6wsX+mcYLQ/yIVCeNZYOUTXm2c3boExaQ/7Y8M059TOA9nrkTYm?=
 =?us-ascii?Q?1m7QN2dSsav++1th0b4X0CEhiQI6S8wbCYP2IOA5gRB9sXZczC0GrJn4KlUD?=
 =?us-ascii?Q?KMEG5/fXFLTossZ8YFxmFqLGIzcYxthjJzxvpIn2tMXkhNWjCPfsw2p00OHv?=
 =?us-ascii?Q?6Md6D+/h2cV66lVpmCwoqEPCTigwW0sDVwGGHLAhyco9p39oDjljW0YE1idJ?=
 =?us-ascii?Q?wOen2TfVq+scE/gzLriircLhM0BtQSyTxi056ulZnv6EMC9fh7yO6tW3aRi0?=
 =?us-ascii?Q?umb26if6dcmTJlLzgSFSyv8uaDHe8DO/7xqTAxuduZ5ydlaZRF9Dbp2zSMWv?=
 =?us-ascii?Q?749p3bW549eli5lLQcBjlrtIE3+HTfMQQiXIhNah3CrwlmXkHWb+TkWd9IXy?=
 =?us-ascii?Q?BCAs0eD5aGpUlH3M4of8JojkF6RL+Yx1NIAjS2eLlWGP/R8OdjNb3Cnri01T?=
 =?us-ascii?Q?QRZ7xZ2oiYbsL8VxBc3lyYiPObAZMipOcdCasqAqwkstwXgRah1JjKWaZM1V?=
 =?us-ascii?Q?N42p1WIjVd0BmKMRUyOvZb2a2c0Skwoe2GVV+Q9aPzbLk/MhGv3/Bu1bHEGB?=
 =?us-ascii?Q?+g1O41D0/2lqHZrEnCFFuvy9gVkNmVHn6BuecbQohZubqsa/vdpTn1os0Koz?=
 =?us-ascii?Q?dsCxSux+93RG/s/yod13XQ8BEYlZQAtdH0lfkYF95nW+NonZx9T4veLL4cDu?=
 =?us-ascii?Q?5esexIoyDut4s0pOJM6G+mOEWfiKt02xQ9Cg56qQbxxT8IJcaSBs/nViQ163?=
 =?us-ascii?Q?r2sIlqI+N4wa1jRKexB9uzsu7X6jjNUYxsh43KMUTZxW2VuU16kQXFJKIRuI?=
 =?us-ascii?Q?ss8BYSuf4am7CZQas/U2+hQVFYu8r88iKguFi6JifHxCohuLI7Jgz+5Q8fCf?=
 =?us-ascii?Q?RCKpk6p1x7yxwCbVJDaZqsvvCVqs5OKExmah6aNZYis09hR+gXRNdDeRBWXC?=
 =?us-ascii?Q?y7XJjpDJ3A4jyxaqQbvK9NLPt1jCh32GW/UNF+IyYElgaNSC99eBDRwyCNPZ?=
 =?us-ascii?Q?DYLUpLMZSwgOBVDmoCisVbynbU7dRRQJvXZrYRgFlbgk/h5gU4n0BcjSqeV2?=
 =?us-ascii?Q?KfLM/DUTmFlVxj94JKpjQNZJ6rbtcqi6gU83fxQEQ304w2tRHWIsC1aDVBTF?=
 =?us-ascii?Q?Z50xz5fw999e64Bdn7np0H1uI/7q60G1CpFGLV1O?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fc7839-6794-4f6a-36c5-08dda557d995
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:28.8813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1h4vt3Ioj8DnBEE9YmzBG8odgZc8yXnLP5lYSvubLPa5HJQApt1M8Tq4IkkjmVU0H/znFyMOkQDCfC/QmkQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383b3 cx=c_pps
 a=JomqzcHDjT5Ni/tnCvtrfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=hLZCMK2IaNhFlHKNMJgA:9
X-Proofpoint-GUID: dTItlo1qdEwqSdaImfYbL8Ft0ocuzmk4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX14PS/7bO9r90
 9YBZQw8norxgbw6qoeKxzxEvEkVPONGQJ1Ytyc1NE8SMDWtxuhhAQzIXK2+01wfB3Hddp9Rj7JW
 u3vFRxZG0IJ3NneBCHYlJy14Djoe2diwmclNaiGhK7t2CTQDUWkmATfWztKx7sC9X88e20J4Pyn
 NZ9l6fLitBy/O+VMJntCIMiBW7EKXi57FiMfViZdAmThl6WfTBvx6pBdPXXy9Gd4KDtn1a8jlfp
 OITY8GLQwdwwKA9IqgkfHlAIdO9Unw77ah0C3l5aDw7w2BqbayaCSIAljgzm9YiDX1AQv5CCnY0
 ifoah4EnQICGNDczZxikDswfKla9pI/IjtH4WL16NXrlSaPOPrTpJG8V1ODGevteH6/YcDhFkLm
 ei07nVZPIyAWKVjUci9ZS3NuTm/7UDNGdP15H0JVf/4fAquo1/WV7gFkeNiwxtH3cupxH3Oz
X-Proofpoint-ORIG-GUID: dTItlo1qdEwqSdaImfYbL8Ft0ocuzmk4
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

Support an asynchronous send of a vfio-user socket message (no wait for
a reply) when the write is posted. This is only safe when no regions are
mappable by the VM. Add an option to explicitly disable this as well.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h  |  5 +++++
 hw/vfio-user/device.c | 37 ++++++++++++++++++++++++++++++++++---
 hw/vfio-user/pci.c    |  6 ++++++
 hw/vfio-user/proxy.c  | 12 ++++++++++--
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index da29674fdc..22ed66c54f 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -94,6 +94,7 @@ typedef struct VFIOUserProxy {
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
+#define VFIO_PROXY_NO_POST       0x8
 
 typedef struct VFIODevice VFIODevice;
 
@@ -107,6 +108,8 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 VFIOUserFDs *vfio_user_getfds(int numfds);
 void vfio_user_putfds(VFIOUserMsg *msg);
 
+void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
 void vfio_user_wait_reqs(VFIOUserProxy *proxy);
@@ -114,6 +117,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds);
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index b37f7329a1..eb2194c0eb 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -93,10 +93,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
     memcpy(info, &msgp->argsz, info->argsz);
+
+    /*
+     * If at least one region is directly mapped into the VM, then we can no
+     * longer rely on the sequential nature of vfio-user request handling to
+     * ensure that posted writes are completed before a subsequent read. In this
+     * case, disable posted write support. This is a per-device property, not
+     * per-region.
+     */
+    if (info->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+        vfio_user_disable_posted_writes(proxy);
+    }
+
     return 0;
 }
 
-
 static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info,
                                                int *fd)
@@ -272,6 +283,12 @@ static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
     return msgp->count;
 }
 
+/*
+ * If this is a posted write, and VFIO_PROXY_NO_POST is not set, then we are OK
+ * to send the write to the socket without waiting for the server's reply:
+ * a subsequent read (of any region) will not pass the posted write, as all
+ * messages are handled sequentially.
+ */
 static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
                                             off_t off, unsigned count,
                                             void *data, bool post)
@@ -279,21 +296,35 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    int flags = 0;
     int ret;
 
     if (count > proxy->max_xfer_size) {
         return -EINVAL;
     }
 
+    if (proxy->flags & VFIO_PROXY_NO_POST) {
+        post = false;
+    }
+
+    if (post) {
+        flags |= VFIO_USER_NO_REPLY;
+    }
+
     msgp = g_malloc0(size);
-    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
     msgp->region = index;
     msgp->count = count;
     memcpy(&msgp->data, data, count);
     trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
 
-    /* Ignore post: all writes are synchronous/non-posted. */
+    /* async send will free msg after it's sent */
+    if (post) {
+        vfio_user_send_async(proxy, &msgp->hdr, NULL);
+        return count;
+    }
+
     vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
     if (msgp->hdr.flags & VFIO_USER_ERROR) {
         ret = -msgp->hdr.error_reply;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 769dd9b810..e59fa27039 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -26,6 +26,7 @@ struct VFIOUserPCIDevice {
     char *sock_name;
     bool send_queued;   /* all sends are queued */
     uint32_t wait_time; /* timeout for message replies */
+    bool no_post;       /* all region writes are sync */
 };
 
 /*
@@ -264,6 +265,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    if (udev->no_post) {
+        proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+
     /* user specified or 5 sec default */
     proxy->wait_time = udev->wait_time;
 
@@ -402,6 +407,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
+    DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 74cfaff6fa..13f2407845 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -683,8 +683,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 /*
  * async send - msg can be queued, but will be freed when sent
  */
-static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                 VFIOUserFDs *fds)
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -805,6 +805,14 @@ void vfio_user_putfds(VFIOUserMsg *msg)
     msg->fds = NULL;
 }
 
+void
+vfio_user_disable_posted_writes(VFIOUserProxy *proxy)
+{
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+         proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


