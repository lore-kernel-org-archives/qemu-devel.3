Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF7DC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklQG-0006Kn-5S; Wed, 19 Feb 2025 09:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPt-0005cf-9A; Wed, 19 Feb 2025 09:51:15 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPr-0007fe-7n; Wed, 19 Feb 2025 09:51:13 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9K12f024315;
 Wed, 19 Feb 2025 06:50:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HMJ+9iSjjqAl305TKYaYKWiCdY9JvKcSY6TVzyMbG
 Z8=; b=IPPJ4QdYTxPBuMsa5Zf8NujQbbzO+vMAQ7VRpaty7E9VoW/Hp6TifmWX/
 VShirukT71Yjb1r74XA5ikQ4fvMAvCKF59NGlHwDRSMHe1YJVK9mTGd28Z6zNt0X
 GyRQEz+7AjMhpUG7VaLrQBorTzjefOIQ8HZA/5D2nOfLllJ88bn5Da01mvOF2SO5
 GRYdT3tJd/utLFH7darmh/pQUbVxrsSiSwnuDvEJQMFfVjHl8/4VTqFcbV4leYv7
 RGje9FSeIH3o0WWaLQrIsBBo9jdUtRihWy7zTeGQt5DvsdL2ar7HMPM3CIQcMf4p
 GFSkK5+q1r7RrnXAgGiLMco+bVmOQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmQlb+roUhivB7XOw10l4GNM+Y3U1oMQbpcy674EnDx340dMEBTbqkEoY/w59wpD0TvZp4HH1UUrhLrz1fTqgrfzRHFmAg2V/mLCi6pcwb+REvARkUsjKF7qgePTK5WO2dLKu+hxbg7XHRw/AsrITCsd57KCH0VHmanYtV+RGGX454qmoV+EVwwo6wmo/xWD4+hWxbgUCkV2sa1NvXvl5Eqg4ZDCL6FlpeItSOe0Prp6gyTF+9mMZb/oQrReOmGJkjePTDwWvkoYTQ4bEHtTXCc8u5PjmZojgMgxvxFhCJX44Rtxvf0K4cZxoTWH5msuehK+vrGn1T3ZbqjAMmL/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMJ+9iSjjqAl305TKYaYKWiCdY9JvKcSY6TVzyMbGZ8=;
 b=wSDhLVLsAs9goVpflcFksftehecA+W8qkg8baVkv5iQNfQt6EMVAEoMrTeoM9hHVAFmSeu2SKH2mwy66GeiMfxk3Pl+WjzVVaC+ODGKwCHuzhclCw523RNgfvBgLamVeUMDukmzbGhyO1aO2YT/IY8amfT5W49nor8mRny5vBKMm6rToKOwOPhHnyv/XnVPVFFzS4sT/JzTi7Dad7CysouyWIAHWRhB7hzmigNITqdkke3oyQnTl6BOPgh4DLvAbxUqmfG9pM7HcysHzWwUKcN+IHbVdYNkLpnTxFre/ZuGXE6bcus7jSQX7PswX06H1vxXaj5u+LY9AnBmn7bjMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMJ+9iSjjqAl305TKYaYKWiCdY9JvKcSY6TVzyMbGZ8=;
 b=lwxyZF+1rCj/tbVolFn7V/QlEjyYXmYvXbZjsg5MBWaZ77jt8W5q4duCCBcswM8skG+Nkju+XEmIvZkKSstEjo7er0h7N3bSzghCs3hoLLJ1K2EaaheXQLvz9yTAOVZhVSsSKeSC/GCmEguamrvWf7uTidN/1PI0J07BG59Kjl2C9K6iyce8kw+24lNVrwZQbFN+GiiNyZ5xMTy+mpBqaEMwKsV/mWq3TiRK/uF90HsH4G1sPLEryigZI12DtroUuUKsS8/AHWctac1IP3bWwtuxK5NEMyCmbhKFw9kmoyCG9W4PNSu60ozgXlf9vDbRh09WadylbSont7wylO2FIA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:44 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:44 +0000
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
Subject: [PATCH v8 27/28] vfio-user: add 'x-msg-timeout' option
Date: Wed, 19 Feb 2025 15:48:57 +0100
Message-Id: <20250219144858.266455-28-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7bc0996-0102-4459-1216-08dd50f4c987
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l3FWCjzL/G7r1cqTdpFC6z5jkDS4qY7sDdpHB56zuLm8Op0xFaTSlcEwVbWF?=
 =?us-ascii?Q?vpuVTDQ0B7vmC18lIRMkHIu22AwmGB4uKHe/pwtwVFMOt/jkfOezzf+BOKlh?=
 =?us-ascii?Q?+20xDO57g7mBsdMs3W+4174dCzJNkG6ZQYMEcts9CJXQKj6FmlVIo6nZ536y?=
 =?us-ascii?Q?UXeyLPWNlVHcHjOh3mt0b7d+nznu+YskBw1nGMiOxt3KZxCxVuIOGyedSm1h?=
 =?us-ascii?Q?uFEThSV4jCXhO65az+1GvnL1/k3yDhI8guFpQS56gWz+bZs8t4Eju4LTiGwV?=
 =?us-ascii?Q?jTChb7JX52/9WEUvOeN6Ui1TyuY52iReJ3vaAy5vVXdfFa27ODOhOGue8Z5V?=
 =?us-ascii?Q?J8N/ETsjZQ65m+eW7L/iUnje6VsGKFQ9JprIcQWsH8aymi4xx7LrqWbLu7dZ?=
 =?us-ascii?Q?UpEjEBUsGCspMeD8QhKRMKOmLR4SxQolmLPh/zgO71YmFHdkpuWIfvPMrsnV?=
 =?us-ascii?Q?4V38EU2yX+kU+uwkIo/Yh/0bNOsXPdIK+96iBgCZTcIcQBqSC3coz3+uQYLE?=
 =?us-ascii?Q?RT5p7PKaiCuJ9tmQVeA3/1VLAmo+5NDV7j5IXUWQK/oZ3KCb9pW5dA2sNy+S?=
 =?us-ascii?Q?dHSYsdAYFSoCE6C+TU0UIN+CvbwgSDsYO2O6H5mRRZEfl4Cz4p5gWmzXNIaV?=
 =?us-ascii?Q?tH8Iw5bAFjJHSPz6EdY7xPsKyR7aFQOn9YHw2dwRtKhZ/J7+H1UH5Kn9I9Jr?=
 =?us-ascii?Q?j9U4DJi+2aC6H33LBy7PvYg0DdLzc6b70wEJrQqByvm1MSI/Ug8cc2Im7X6c?=
 =?us-ascii?Q?w3AUEgzw69OQ0/nVehzAjAivMdIpGlOkHU26b210qHFOwhvDfk2tcQkZ3nPI?=
 =?us-ascii?Q?eqbwPPAxVKc7l9+qkwNvNGDIYz7RsfTD49llQFes69bU5oDvxJ4GTv4Qr3SS?=
 =?us-ascii?Q?YrDf9i5llPVRpdz6aX0ug55TqTp0DadZtqKZYvE0TmPSm/1FPvNterV291O0?=
 =?us-ascii?Q?HatKdoXdUwiK0Trcco+pd9jFEUF1kIwRDOtjFu1Bi5zzNYwnAuZWym5wjheq?=
 =?us-ascii?Q?DK1rIRbfi0mInqa6RzqDMkz5vPwOuF6q98enqZ2UkxVrJ5QseLiYelXxYMaV?=
 =?us-ascii?Q?TeJbc3PZ6n/NqYSgQlBindLBdR3U/wUZ12EVMLqN75ziCrlITL17vgt+hD5d?=
 =?us-ascii?Q?916EJexe/rq21dNqM36dvEZ68zG64x513iIqzfkhStsJKghHFZ3KlIGKU58+?=
 =?us-ascii?Q?zsO4+wVRKOiEhP9H3uuj9wSM0TIIhv9cGXOwqi5odGV3Ow1M4BXvxB+JxZKd?=
 =?us-ascii?Q?N+iqXKMDiIYRevUE3l2OAhmrvIMOxLB7Wg7oO1dyQ3AmuhYO3LyBCXcfaPwo?=
 =?us-ascii?Q?PqcUGQlaLMogGH45ntOEnb212piuILYf7suSUZTSfJ/X2kS9EFa6+erNFmfM?=
 =?us-ascii?Q?JCXlTiAasvbROPR9jtdUqpXisYFi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhEV4LCUPn+00Rhu6oHqJqSLkQ2S9ykzLM6UgIU/RKPYOIfma9vTZ+9EYjiP?=
 =?us-ascii?Q?i19RJqorYbKbSRQ2SlS4TXw1mNSiHoGOScsJULR/Cw6MuvVmo2IAMkN60Apx?=
 =?us-ascii?Q?O2Xv7GXw98mQxTxKRg1CkcwEAemsqwuQ1tR/haR/G7lPZas0kyDtAS3ufjd0?=
 =?us-ascii?Q?Z06mJvzbWvT33bqaLSIlitR0swVZ1IawyJAorKbWu+2TrY/+uhEL2edEUHvb?=
 =?us-ascii?Q?lbQpunlLPn+bcXbVXU7Iq45zpeJsyrnFB7qtyow8OKp96Uh5gJ14U9yiO736?=
 =?us-ascii?Q?Q/1pHV6DlhDSrCKb9xDR4vMMwVqF4q3GiYC/DQR5BeojvJdjItCP52iFBfMz?=
 =?us-ascii?Q?UGoZaJJJSGgU5O69F613jt8zs/DSxyO+XUrVgwDhn5D7wrdWzEqlbdtl2pcw?=
 =?us-ascii?Q?W0uRdn+bbQlNqiYx6iWuRev92Wj3ETRS5TcWDeD0NO1JFQI5F37UipHlxqHJ?=
 =?us-ascii?Q?hFsXtrOh3SU+Zvt7StpmGzD2n4OX15TvJRgRyM0AXlxpktvPMaNt3EDAEurv?=
 =?us-ascii?Q?Nxw9AwtpirfFrcXN1ik0McmTGfvpIuYeYWOyyu913OQmD+vGsh3SIcI3GcG3?=
 =?us-ascii?Q?16a1sjqP9vUwX/sLE0ABx/xkteLWjoBx+96g9TC11l55TcxhbfZlTzk5Z9EF?=
 =?us-ascii?Q?4xW7ti5PJxmPEA0DmDW+gjdg6OvOOus5a6S0N2gD8LIl3LxLgjfRWNWMoQWt?=
 =?us-ascii?Q?hkSFi4455dLzfC7Q292g+HfWDZPLiNO60Ksj+RjLpn18U+Ehdedf2S2x/jsd?=
 =?us-ascii?Q?//l1HXwmQtW9KC222xE+nTlLUkMMJEARZdiSRNEtLm6RVqDEFHFpuJ75eMhL?=
 =?us-ascii?Q?l3s+M39iuMQFeKL74UPS8iZsktHPjX/JQyT8vniaLHcTnLTXmE9Xvt5PdFyL?=
 =?us-ascii?Q?/o5BRz2uaSKfWDyAFnmtUbjmQmGX0sKXcmX5gEJ98p2hp6q2rIr9CPAnFeTx?=
 =?us-ascii?Q?EpjhgDTlbZhhzvCoP/acX10fBImLX0D6i+Hyrbe9ARhgxqjYBB8LPAXakEJC?=
 =?us-ascii?Q?447LDJXtX94VUi/84paMT1ptKY5PUMuJwNkNBvJFpSwi6s2rIzkm0YBDAupf?=
 =?us-ascii?Q?b1ObUlKACKv5e6OhG78rZshHIkKzSx+ZN+Gp7Gh/ivR/qXph1g7rj4JJ30Fn?=
 =?us-ascii?Q?1VhNU31KsohyYSdNUM2Vvp2XGayb4lIG6r3+Jul4NcgE9oF9EWMk1k4wmtOv?=
 =?us-ascii?Q?H2RkEZG88uW3jhpuxkf4JFHt7cxLVQbIQqaenXCPl0pUqkx9/hqoEhNAQ5K2?=
 =?us-ascii?Q?KALqdxyuS5PLrP9x6hImfZYYx6CwnhnJh5Qeh5UqVUwijIedTttemK7VPF7b?=
 =?us-ascii?Q?nNm/4XoTWqOsDlFY3fF02IjBq3Ppov0g6nrw0f1d+NkxL4KJ0PlKnMTN8BI2?=
 =?us-ascii?Q?hIPBYCEhsMeo6UbjYc/npAwufsFW0uU8zHpuFg/gOq6SqMWhJKXfyGu/fW9i?=
 =?us-ascii?Q?rnaGjci3GZxOfJ9wnUvJYgPpJ7Ayj5K4vzwujKKTlcfKTdJYS5dsAtK0rpqk?=
 =?us-ascii?Q?XBaOlEfYztVSrV3JK2JnkXzomSyf14v12Rb8sHCzKg3GlSiSU18UVpeg47+P?=
 =?us-ascii?Q?d/fea1CdldthocNh1SIYwISV0Xd5oCgnP83bvWjq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bc0996-0102-4459-1216-08dd50f4c987
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:44.1037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2i1/IK8TKgaxrcQwxCU7H2vfw6HgfHBv7WmkiVtrvgBeYMujNwKLQ5fW+QV5fKdDZTMzUvfFWQ+qlDqj5lVsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: oinUPCP5A6FnwUVWqPVKpc9ufvnTvFWH
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5efc6 cx=c_pps
 a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Ql6ANm6PklPDYutWWPYA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: oinUPCP5A6FnwUVWqPVKpc9ufvnTvFWH
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

By default, the vfio-user subsystem will wait 5 seconds for a message
reply from the server. Add an option to allow this to be configurable.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c | 7 ++++---
 hw/vfio-user/common.h | 1 +
 hw/vfio-user/pci.c    | 4 ++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 38f8eef317..e44c8a2568 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -37,7 +37,6 @@
 #define VFIO_USER_MAX_REGIONS   100
 #define VFIO_USER_MAX_IRQS      50
 
-static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -707,7 +706,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     if (ret == 0) {
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
@@ -740,7 +740,8 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 72138220ba..9acf634ca7 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -62,6 +62,7 @@ typedef struct VFIOUserProxy {
     uint64_t max_bitmap;
     uint64_t migr_pgsize;
     int flags;
+    uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 8a05e69a46..fe096cc7a2 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -39,6 +39,7 @@ struct VFIOUserPCIDevice {
     bool no_direct_dma; /* disable shared mem for DMA */
     bool send_queued;   /* all sends are queued */
     bool no_post;       /* all regions write are sync */
+    uint32_t wait_time; /* timeout for message replies */
 };
 
 /*
@@ -274,6 +275,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (udev->no_post) {
         proxy->flags |= VFIO_PROXY_NO_POST;
     }
+    /* user specified or 5 sec default */
+    proxy->wait_time = udev->wait_time;
 
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
@@ -409,6 +412,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("no-direct-dma", VFIOUserPCIDevice, no_direct_dma, false),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
+    DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
-- 
2.34.1


