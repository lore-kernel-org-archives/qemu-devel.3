Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6A2C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOXB-0003lU-DK; Tue, 20 May 2025 11:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX9-0003jt-D2
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX6-0002lM-FT
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:35 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCUIcC006673;
 Tue, 20 May 2025 08:05:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlB
 X4=; b=pG2k1Qbak6HPqkxYbo4AGGGkhN1wQAlHINUw1++8uwdvkHoZJovNVkWaq
 r4/NutUnwlTFBrHSPDjMcAJuwP6bFT24RsH9GqpPlNT4d7Xrlb/PjaYyNnxlJrV1
 Zo3LNUJ778hn6oIB12uxe6J55SJGmRkD5bQxb1VSZtrxgcvSx83ihNH0gm1wvlqx
 YKhKdXRXkf1c3lrI/KmP0yP0zZ2vD7csORxHEy7eLmwVkRN92C0cqUQ7DKML54OX
 j4Dj+IGiAaX2UKQes8Pon6i97W5mMWbptMIg9fV8lB8ns+UxbDWBv4+7Z+Ybzecr
 FGFRDpU3k9SCCRW3vSHnZHqSXWwsQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46ppsuehk1-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6upxt8rgE7V9BHWS+UqiSdAH1DIqnpP8MVcd5VmKMb/H+DT1kebKA2Z/8sCU2K8AxqWRpgD94nA3uGCKJz98ceGtcZUoBpTLDzPHYZ7SAr2fPM6CCAFWqshnaIIBH0YtXq3q0Eba9e5SQViCp6BWtHn3RtOIlsHsK2teptQB4Tmy0pSo37ZvgMI2gjBHPnq06fVeWh/X0EEmOUIsbbjSmExXCQzTgmS9VaFKENpbxLkkOV4m3uuRwSLy93opLAPPCPyQPqM9jMdLOjRYQpMt3KW1c2NvauKnAPlch0rtZw1Tpzmf4UnceMid4Bs1VUoaEFz2jDtutCah13iaeXx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlBX4=;
 b=utCpDsAUS5fjtwJh/6D9ikh0aA7yviovUwjAMaD4evb+rMf+qfgxJn2p/lW3+ykwwSFOYYUYes4cP6yLn69BISk7bflitAgJdx7ZcmtySOmMK5qbyk3Xr2D0F7zTeEoz377nYE+uuU/vPfpVOjTVHuGcNdyQ10Uk4zLa+K6Ao3YvHjRy+q0gCqWiUgvosvg7+5icPQJMGozZAmiSxmzqXjYt90BiA71RAoqANSqaiJeqWio7VlBRF4hkfaMfsDOXJr5bG4+yYue6y0SF7Lbif72bx6dgNnGrkzaEq4E8fzqtTlUEvp+fcyturtQ50up8EOqRanA9qPqz1R7Sfc7GsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlBX4=;
 b=afH7M4l+y9pfudABHCFAVBt+Nn8LE+8BLNNUJY8yienjKk6uSPEPQEoYt55/t7oZZSf5OdP+oUQscMQ2+J0xAY3elSsR79dfWQuG0RFsB6TCch9GJNKb85dvoISzFe0c9uPJZov271RVYFt56wRxM0L/Z8/hJ6jX+Q08NUBUF4v8wfaURaZ/HadeoaLHdN1RDa+imqq7FBkToWBddB0xEmjJh0SNHphU0uTH1LvAhk70N+ZFLFDPQYORUBCYbxshiSBdBUmpCR8nq/9Do5is1v1oO0qXsKK6yq+I0Dd5nSltP6+fsBh/cqg988f8QbFVDI7pzYEAqZbWkkdoyMefAg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:25 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <levon@movementarian.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v2 24/29] vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
Date: Tue, 20 May 2025 16:04:13 +0100
Message-ID: <20250520150419.2172078-25-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 057b64a8-cccf-46db-0951-08dd97afc033
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x942UGVIlRSY70p39YGal4clujzdTXcfJZF9PpcDPo7KLuKtM54AJAq03qLD?=
 =?us-ascii?Q?Anh58ERK0KKoxGAtymPqp4l6BGSjVc0l0RNpKxl73HOMznYXNqrUp9zszvfC?=
 =?us-ascii?Q?qjOQ/qzN5iRrAyDy3bedshh58EDe1UjbbfDP6+jj/taIF4XH0Q0qoT6UH73f?=
 =?us-ascii?Q?dBNhGvPMlgfPDdlDJvzdJ80U7LQolSAR1gckPvdOMpc97soHJAmwUN6YMzoW?=
 =?us-ascii?Q?d+Qg3L1VXNQntE4OqojBs6miihOhgMvvVY7Px9dIH2vrgeEnY9StHt4hXXrw?=
 =?us-ascii?Q?ntwuiJK2rWGToWj04pvYtj5SB8q51Xq9EtI0hP8lWI9kiIj43XYUyAv5s0N2?=
 =?us-ascii?Q?fCnvhIklTRIvERbZhtnR77qCT1uxWlBi3jsgA66Xlfn6JJqqcDrXnrlDrALN?=
 =?us-ascii?Q?4He0LsxSArL1o8qj7F/3pdSBtdZMs8gbwLzKfB47BQ4KnPKeQjuAkdDmWbm3?=
 =?us-ascii?Q?muWi9DyUAPkHZ4EPbdvdmil2kFjFhZuvfUGIUSTLLSVL0+bqVbczAb8CibEk?=
 =?us-ascii?Q?DoTDTosOuuKMrdeu7LwaG69K172DPGLbiQFsHYp9W5cxrgjw0S46EfkfI4QL?=
 =?us-ascii?Q?j+ZpGsiQnMJcrHhljpcOcbfrZQQWvjDuJnvoQ9X9hI4SgkUP5N+tG+zrOWxC?=
 =?us-ascii?Q?tAvLG5G5VsQwWj0pLU7+/xS/B2ZoTWPfQcTVjEUmYTdQFNLMsoMYXleta4uV?=
 =?us-ascii?Q?+R+KLA2wlYr+TkgvPSTLDUPHH4qsecNnI5+ZSJflGl1xA9+vQpkGWbRBf2df?=
 =?us-ascii?Q?ML18lfVF7X/xxMuzdRab0IZ0lTNAPoIvjsF0x5xVZFMPLsygc5ijZIPSPmZa?=
 =?us-ascii?Q?T8uikiXKSZn5Req2b9Axfth0ajDjt9+ogK7iASDzsgEBvy0hP5QJB+U1nUZL?=
 =?us-ascii?Q?pgPQGY6IWopLatb2Y9pyDNvgpHPZehlsQ2lM5d9H26OoEpkosi7ykyZbhM9u?=
 =?us-ascii?Q?NwWmCzXFq74XhKV0qKgolAvZSUi4fngnM8nv5ndjdfrxm6JWma+T4RNd7nzR?=
 =?us-ascii?Q?VBsZCuEwKceQNkLUHvdww8+GUhCHC1e8l9/BiywkFwbAJeAC5gnZkar+/+gW?=
 =?us-ascii?Q?cZjtU0OBLeqayEDnMajE7iGUKuaOCEmBwfYX2TiVFFoL09mX9V/uydqiugqD?=
 =?us-ascii?Q?6pvG9eu04FBvHlNqf09KQZsAuVkpl9FTFL3J0BP7wz00iC1oqBxJaK2atnc3?=
 =?us-ascii?Q?7qQ+z0rx1S5kJ2ACo/gyD2zqEit9FU3LhoEIxL5Xzuq6lWpnj/cziD8MI6lD?=
 =?us-ascii?Q?JKwwjX+YtEctIoUPbf8wXXYkK6i2DQgiOpNwmE2ZEfACMsvY1iTeM1RAOUzn?=
 =?us-ascii?Q?hXWb5HuI+YTJGmsZbYLl3/60eHkEi08O7pokUVWbj39qFhcmjBXY1jPQv8Wu?=
 =?us-ascii?Q?sF6sN685t+9CckFRUCHDNCT5lXZw13fTs8jK4iGcngZ7iJ85kazftKr5Jone?=
 =?us-ascii?Q?AyZyEYeDI/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dDoArYtMPFbP1Mpbp0DnP90YH1rw4sAfLfAGTi4xRy2NmqnNmYtnBUlcV96k?=
 =?us-ascii?Q?ZqFjk3G3csLPhhSTIUBvlnrSYIpJjmBPFAvzwjsdHRLxkdXwJQ4mR6YHRkPk?=
 =?us-ascii?Q?JmVzQkQwNjron9dmIQDDxb4JOYragSskvR5j19yyAJ5Pd5p//XbTOz3K4SN4?=
 =?us-ascii?Q?wVww65ugvRjeUnxwciHR4wrc2h3GxThf1UxsCvfYOwsKhtZQqcsw/CWzjfYE?=
 =?us-ascii?Q?5FF1emxpSbBKkArRBdKueq3TrBY+iGTNeUT+d0G1rHKfPYTaYw3FNA8154In?=
 =?us-ascii?Q?cnGvnQ0GHZXGmzITqVFPoO4g7uTm0l6f7CoCRt2JrpKyYFGod1WLWV+pGhsZ?=
 =?us-ascii?Q?M1DJIcGbBFVbDJTIKWSNhc1Fj/IBeGWdPFGKco0/c/GMMT/mSdiY+FBboyqe?=
 =?us-ascii?Q?CHRe98s+TWrektErD6XIHnuh8k+2gaTs3LqV78l5SLbFqgJ5TYpk+iJBN+oQ?=
 =?us-ascii?Q?/hR0UlmFF+xjsTPVM16OEP5vg1QAKJS7PHOg24ZeOIINgkEmARTxPXXTDq4p?=
 =?us-ascii?Q?7r5yxGtV9yS/GfD+x3Tgh/GjohCUsCAPh0cCC1lx2qF7Uo42LL8CYG5GoPyX?=
 =?us-ascii?Q?V2jRcYgPbS0V7OjxY8WJxlOhMmIRUISc2Joljjf5nnbmVmMQR27EzXYWN3N4?=
 =?us-ascii?Q?wZgUMbzD4X9yTmEftcXaLf8w8/uONTAbXxBGnpC/1/RdIzvAg765Bt5uxZKy?=
 =?us-ascii?Q?6loDzNWT9ABvqNgvV6ZN+fv/jVPm8T+KhsBUWII6VJu4+gaWIBOCQrHxpnG2?=
 =?us-ascii?Q?RA3/80vlh+zTJcJVQK6OGN+/u+i0jpNN53ZlyYHyRqao2JDgmeHXUlE44U9M?=
 =?us-ascii?Q?bjT4gDxXXf/Cb8vOEZL7uVLtCkxSQUkGGPxikxvj0Md/qTZa1t9mGF8qYOm9?=
 =?us-ascii?Q?CgZ5mpZeztGuhhsQlVoIRa9RBzNfRuABqh/WJDgTfq4TfO/rMbJUMbKA1fiH?=
 =?us-ascii?Q?o5HZ5QDVPZh/mip5J62dxSoS1ubqtP9Fkjv9c5RmfIEkP+Yp80rP+g7+NaAH?=
 =?us-ascii?Q?Aub4uQ5PDT/VDUvA7yvqgc1Lnp2bMWCpHY5uFpHerahsnBvnIXMiU7pxlTsq?=
 =?us-ascii?Q?Nlpqkeko/fOWqkIiNcknVY6K3x1WWWD5iXgtpO6cD7MBZl8Y4E2FYhMujKp9?=
 =?us-ascii?Q?92O2HO3E/7eYol0g1yFZWW7ki4ZaopTgy7uxDl0KsAXsXm+PhXmOfD6eDWiE?=
 =?us-ascii?Q?TdVxpQf8b8QidHYIc8f6dj7Ky0b8Yg511Q+pR6LFO9z74kS9TlLDPfn8FYrI?=
 =?us-ascii?Q?1pOH2BH3EzfF2jm0nQk25rQAbdlFKNDJxJzn6C8wMhn/fhsvvwOiiR5Bb2DN?=
 =?us-ascii?Q?9bFKZGhI+3SQvZ1AQpNrzCZyPZJIOItrGNs6oVOwpgK84S7DVdc1ZSWwGf2B?=
 =?us-ascii?Q?x9MMA/i8ZbLyuuJM9zpaoeYuyVRnR+gC8djdEkqNJXNwD/VnZPt4cSYrWoqA?=
 =?us-ascii?Q?GuBh8z7hFmv8lgW4wZPaGLwoxbs6B/9EIK+YIInhBuJ2/i8UpT3OTNTj7Wct?=
 =?us-ascii?Q?I/6MHh+p+w/RnQsQv5gGyFUyX5lAGLMRWILwpz1a685lBqou/2TzqR9P78iR?=
 =?us-ascii?Q?LUNAllZipNOeJIyiCwiG5mimRb8stLXTY6cl/iXP?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057b64a8-cccf-46db-0951-08dd97afc033
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:25.7607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/HGIFYrcRcojpXnVNJliIFYSWqQX4AEZBE6cqj5QHA8+FhtE2CuAjoxy2K84bg9XV+wFECE3/5bE1PqMVec7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Proofpoint-ORIG-GUID: f2M9uXu0Kp9n0NLDmXydpyvVw8yC5KtC
X-Authority-Analysis: v=2.4 cv=Y9v4sgeN c=1 sm=1 tr=0 ts=682c9a37 cx=c_pps
 a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=RQZ_2NmkAAAA:8 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=QltQKaWwH6ua0DdkohUA:9 a=46pEW5UW3zrkaSsnLxuo:22
X-Proofpoint-GUID: f2M9uXu0Kp9n0NLDmXydpyvVw8yC5KtC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX4VfrjvUYl/Fi
 nAI7vO+SRCqbHHMnknPUbanCcDTo7Zp+ldHFIX74On+9lbB8rlrVzfPIFmx31JLpQNpS87tevDp
 9KQFWrmFiFqZMHFGsmxc/1tQuaxbGDVogdrxziqT7IECSAmPTfxrOOpEmLIRbf8/JnYeD7DS5YC
 7IkNK+u05uJCclqO5WE9pa92MLSPROokC9mK6ya4PdLc81r7nxBF9kItL5aYsGwftY4DA4b5ja8
 z+9h4IaTVqCLOhtav+ZF6eH97wEee61eIZcDLXQv0qv/Z3yubLMwxJaKQ69ey7M+EApJKhdZaqZ
 2ybagKhWdl50KrHdEz4ubjxFgnJML4ZLnbbeIURy3YuBmFo78uWaI4QBIGZk5j19JpvdcBuVNw4
 aK3iZRwhdb/hAmGNUXLQsDIFYIabGt4wvuxjRjFb5zRNJ6b+JyilTIU0geIBrTgRSMAgFGPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

From: John Levon <levon@movementarian.org>

When the vfio-user container gets mapping updates, share them with the
vfio-user by sending a message; this can include the region fd, allowing
the server to directly mmap() the region as needed.

For performance, we only wait for the message responses when we're doing
with a series of updates via the listener_commit() callback.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  32 ++++++++++++
 hw/vfio-user/proxy.h      |   6 +++
 hw/vfio-user/container.c  | 107 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/proxy.c      |  77 ++++++++++++++++++++++++++-
 hw/vfio-user/trace-events |   4 ++
 5 files changed, 222 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 920b9c44ec..4fa6d03b3f 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -115,6 +115,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -178,4 +203,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index e2cfaeead8..01fed3f17d 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -73,6 +73,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -102,9 +103,14 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+VFIOUserFDs *vfio_user_getfds(int numfds);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 38e9cf8d8a..5a109c591e 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -21,18 +21,119 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = unmap_all ? VFIO_DMA_UNMAP_FLAG_ALL : 0;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL, 0);
+        return 0;
+    }
+
+    vfio_user_send_wait(container->proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+
+    g_free(msgp);
+    return 0;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    VFIOUserProxy *proxy = container->proxy;
+    int fd = memory_region_get_fd(mrp);
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking. They're later waited for in
+     * vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+        vfio_user_send_nowait(proxy, &msgp->hdr, fds, 0);
+        ret = 0;
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+        vfio_user_send_wait(proxy, &msgp->hdr, fds, 0);
+        ret = (msgp->hdr.flags & VFIO_USER_ERROR) ? -msgp->hdr.error_reply : 0;
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -224,6 +325,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_device_attach;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 34df9bba7b..6d1446c38b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -31,7 +31,6 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -133,7 +132,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -609,6 +608,36 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ */
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_nowait on async message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+        return;
+    }
+
+    proxy->last_nowait = msg;
+}
+
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize)
 {
@@ -647,6 +676,50 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 053f5932eb..7ef98813b3 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,3 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


