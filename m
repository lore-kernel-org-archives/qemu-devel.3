Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFB5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWP-0003AC-IH; Tue, 20 May 2025 11:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWO-000394-0w
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWJ-0002Nc-SW
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:47 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K74Jhi000844;
 Tue, 20 May 2025 08:04:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1FgpavB7je2j4lSr11kMPwXjriZvMwCrXGLR8tcPi
 io=; b=1baSfdA6pABq4efp4wcNYbXSwhCMr6rZfkp9NogL2tzaLH9XlcvssoPkd
 V7h+zR1O6DrUEnrp7TnmXV13mwRvQQbQ4PD7l5EeI/GJgQvgMcAeHR2SWulLdK/B
 G9b9QDk24uGtQcAKu6JdRXiKUjaWoGvYHwpHeYSCSTd/Cez2lKFh7Gyv3lxv7EDB
 mbAZUk2LoEdvkSbt/3WiJpZzygMGR+soTiClTIggrDbqxV+TesnrS0cDi29ML0qW
 2uaOxKb3NmmVf5NNBjlXc3sjxWMGbVVkf8gfBso/NYBlxDzSBGjnjXCCmwdP/bCV
 TUTitS11G7dqznXzixy3zKg36HgEA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhebv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWbFzpf1lDyLyeCw0Pb42Z1MD8O/A6ewGK+6o2lm/ogdKP7/Mtgp7PoOGhek1wL3P3l7TKwisnXRhLJaIz77i8DC/CNBzNFHKijXc21aq33ff8en3Z2YuAkbeKtzKaak1Iadg3xQbIQBx3D52ETbJWTmC26ime9alvauO+Gq7+Tx8euDkASjO9MtTQBU9SDAblXkj62g+tMgjZ6UIrQyY+3BZJGNxQkiiZsPxEqI1El7Zs61PbwVbBDJ+HGrJl4sqnPhgQFGGcTWQDEgojoaxjQ4EcERKm71BGGRIpAPt6lVPx+oXbqVINi98nvGXZ3QKvQWSgmrKOlfT6h0ED9eAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FgpavB7je2j4lSr11kMPwXjriZvMwCrXGLR8tcPiio=;
 b=oinIMqm82DaUzb+7NmrRhKWExFXofFYOfcT2VyOgLZMIbM/s421wwiG8svRK06emiiBLPCnMl5NB0fbc54K2PgTEiJeGUVPflkOfAxP2dPlAPjF14GXrS4tNZr40zeKvhdO41uEaqJF9XJL3LB7/QjU7XjJVY1iKboLR6EYZoXd0Bb+ih5yRhE385DTNSsTE0XDqWwFd6JXH5Wo6QLIMSumVe/G6mZZYykglC4912xNtAk1bdZC5UcYzbKiyT8dcGKAXnYkqkPsmu1z9YbgUd+ljfyx3SCmV4nnZMgnVwHfrXeRAz7E+9ajXaIbhbqs+hbZrnAgTgmU9X4A3Gy51lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FgpavB7je2j4lSr11kMPwXjriZvMwCrXGLR8tcPiio=;
 b=wrQf6u/sQ8a850SKw9eVHCNsKRlhBvT/WohI2D+wufyPnApHCxdLlWgdySM1lbD+7OUCeq1S5EFKhqGmF2hkrPKplVDdw9mZWIisbGFNaW3LlFRGX3xRCTzsGa0FdUVAaQZTrfZBkvUDrt5T3lotyR7WadhY7zBuZik0jLFORMGOzUttkGb66SwW158aspmQ6nR9YWM3t5dTYdSIg1IOZWWbcsvJEhskkpGcZv+eGYMFtOPhwqmfOef1NaVJ+fJwg707p9ABsBde41KSi/MCTsjn91T8qd9t5+LLGhxzrLru/jI1X+caFssieXJiSGDtqVZgjcmnbP0tZkSk9E986A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:37 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:37 +0000
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 05/29] vfio: export PCI helpers needed for vfio-user
Date: Tue, 20 May 2025 16:03:54 +0100
Message-ID: <20250520150419.2172078-6-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 073304a1-8a6b-40ad-d598-08dd97afa343
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DOsZ9+FVfnQUwCFLk2pQWPJ7zQKrLjFbUsZpx9/zDre6fYOhzca2S1ydIfM6?=
 =?us-ascii?Q?cXPjyCjDwU520v0gy1lyfCNNKRSp67Y3MUpBk/GbAyL5dcItqjRnTo8yH9li?=
 =?us-ascii?Q?+fwPjm6LCrrXRFyngnzB6qPBprD1u/f7PjbZohf6Ly1k2e2ZA+/KEl0P8a6S?=
 =?us-ascii?Q?WZCOIwrDRbXcbnAARc7+VNhBy0k0Ywh4UEHnUQ5+0i9tDlije1y9XYwuQ1m7?=
 =?us-ascii?Q?2UFPsO0gYTbAOWjvfq6F+7oj542Q1/Nx34n79RZmn0j2wb/iQjjzzeuQYiQl?=
 =?us-ascii?Q?Y536j+3Ddcttql/wvCLp5KZA1pQwO0qVdRvC2TrZLh8+7KaGLFuLRMbCHb4v?=
 =?us-ascii?Q?Z3c/6O6pQKF1MMBgOwMOOSF5IYLlCVa8y6C3YVJT+4tRHJWYIyewB5TLFrWj?=
 =?us-ascii?Q?u+AqSA03aaBfxwStD0a6HGyk1a6dXbeqrmLvTqJpUmxD/vIIkFMynw+/hrLk?=
 =?us-ascii?Q?puulkNYEkjNXJoOcvD7cT8lhgaxtVEBRnEWPasHm3xPtEhVled/py3CSEzFf?=
 =?us-ascii?Q?n/JiFudkphkNczxnM+p6JgpURXYnQEWJr482BLSJy2BvcsKmgbMf8gu4jTeP?=
 =?us-ascii?Q?DnPAKT0RrHouyAvxo9tkZIt+UVc8vvW3SzBWQbYl1QIk112VsJDtwh0XBJBv?=
 =?us-ascii?Q?J6FbUGY0yyRUvAD7XlePyGfZFD9zZhnJOKwOzNvDiEQX75PB5AqQ236waiEY?=
 =?us-ascii?Q?2nMsrTPXWVV4vfTdMVW9y4uEwaJ391M9WfjB2d16zQ5sZ7h6vZxopu/O72gy?=
 =?us-ascii?Q?1CglTMRizgItxkbfgdkHbrUtFLTvibPJfsViX5LEDtCgGTiOoWBRyCNfnx1i?=
 =?us-ascii?Q?xUH1o9c0KEK/mPGlxt8WSF4kcQinpiHyYkk25mJl6SGe66uFa2+i9r81+VdL?=
 =?us-ascii?Q?qnrfm4NJ9H+WPdr/zPFvroqR9hm1d6flTnQPBjIpM82xEJK3ArD6rt4SMYYF?=
 =?us-ascii?Q?WbUj6zHD1U2hwxwToeeng05WCDEdzpnWjYgZTC+jyJcfVkp+XBpUNqV0FoEw?=
 =?us-ascii?Q?t4E9pj/zfnobl3YEed9+Qc22pKRTFaD30GGwxmukDijOjThK3f+IONGc8tDj?=
 =?us-ascii?Q?g7YfhaAbRx2h/n4G+ubNB6RKs6vnu1EDUhCwWVn7EPOUdKrsuT9yZDrHDvK/?=
 =?us-ascii?Q?Z2ydCo/X9UVr0B1/2oOIskC9F5fG2euOVbYBnYEwT/UhzCmMwA3wPbHtgTIs?=
 =?us-ascii?Q?S3y0iDfMOhYQmcRPz9MQNV4rcNTTfW+v0plw52fhJndxirKMs+12hU3TpyI6?=
 =?us-ascii?Q?NN8gsHun8XhLcfsG0cxn2JRQ34zHogsGNe6soguRaDq38Bb+SGcLhraQd3Pk?=
 =?us-ascii?Q?yAAT1Ct8H2C9+JA+xodYxam9jw0k5AER/0BxMdrph3aYsqDTLpqwxxK9kYsR?=
 =?us-ascii?Q?hWjzk4ZIk0woJ+X4SSVPsQeXyXmtGfXa2d3VnnxbWF/tDqTjj7cNTNN4ZUsC?=
 =?us-ascii?Q?lSrLymiNSV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2L/mCflirkIS9Ri4hGz0Qs+x8/bxKu4fptG1Cpzl76ciGyT25QFNFJ+qIBt?=
 =?us-ascii?Q?rvoVbMwKZspqOVG3Upl+9yUS20oQfFVLsCCPUHvuIT96m8GYxxFAwkQu85Ji?=
 =?us-ascii?Q?WnEevFc6z/vAcS9FP+cLflas4Qa3wixfW8ZxjrJRBXlgVO7upiutDQ/3CnT/?=
 =?us-ascii?Q?Y8Pz1fCHXJ0YvI0gKws6CT6oGCFi7uItLJJpFt51RVzjZbqUeM9N95lBGjvF?=
 =?us-ascii?Q?XX/yJia9YeD4CKOjIs6g6GP1GzNSpG0+b63Uhp13LP4nkHfSKe7+TmWW8UCR?=
 =?us-ascii?Q?vgFd8+pO9gP8In1relgbhWqZt4mIBPeBxtFjmkSY2CLLxVD0NQdB/nNGSoHY?=
 =?us-ascii?Q?2Y/MFo8hEKhsEPdTZNOuuiLTrNTqSa5Tc37vHIx0k0GWxWyBpGo/iDNqdo/L?=
 =?us-ascii?Q?KLKIA47qC/pHDx+8Cw2joQafq/z+svnH4GvwWYIhXTV36cdu2FFOfBV7PIbU?=
 =?us-ascii?Q?e8MyqhRe4QiXI+C4kj+KCP2kWERDJkZc3KfzqideqNXrZ4SYUCnkhfB1S6uU?=
 =?us-ascii?Q?q4utk+BmhfRJacwtbqxxSrc8mz9WYacHXSqbWerx4kUvzD2HQauJPTe+rjHn?=
 =?us-ascii?Q?Sn0Q00apoXpMgI9OAOH3l27CQGLSHiRqtIrhF0D/wOVX9k6suIj4pt16iQGY?=
 =?us-ascii?Q?sX+SCR0P0+yBpwjUXJHQqdDiBChplIriNMNQqkN1Pnvp/UReDl28D1JJnThM?=
 =?us-ascii?Q?Z9KtMs2qSKnsHUK4tyIdB5CWUoWIpJJ5B3ZEJTrXUdwYlXT7gB8o4GOGvgQ+?=
 =?us-ascii?Q?XfV/moP5JV+so2kQjUCEnIRTsT23zsc+6Xs+b7XK+n0aN9AHDhrqpPPwGSGn?=
 =?us-ascii?Q?GGt3cST7fmXks4php7kZ1f3LYRQxHjOVYLOj0RL1oNZ8P7eq0VUP1uuFNkhK?=
 =?us-ascii?Q?QqRl107Qm7GkL0sQgsK8uTjAbJMxEOVDMnhCxKmO+TIXeigaXMMhST9sGY7y?=
 =?us-ascii?Q?rHvU8ZA3y1oRWGEM0E65oDcSn2ikWG330fWTDWc29d14bzMO7dM2wS1132eq?=
 =?us-ascii?Q?DOeL7terOa0snrW2kvhflmrQj5FPpG5f0Dvk91WkWeIjPPjJvFBEN0pK8qx4?=
 =?us-ascii?Q?P/wZ5WiwIr72FiiLolT0PreARd8qKEZe4Bk7iu7g1ft5qFt9ik69VFp6CCVO?=
 =?us-ascii?Q?e13PxaBw5fCTBtlCRjXXOhge7RiSnbWweIWJLxSUicNVXfJRV1ON+pJ/WjnC?=
 =?us-ascii?Q?9ARyqv8G7zchTvEtWEKv4u4EvUjWkuiJulf9LHxBknQjeeuoQkqLnGYK4+D5?=
 =?us-ascii?Q?9Z156Q0dgvmWnwx5AhaxkYqwzaGm4lhPqjWkoCrmdbDvoiK4O2X5lnHkjpyx?=
 =?us-ascii?Q?atMm6oTIRRGiRECLosCvb8wpP9lghIDY85fn2XRdXlKklScGN68etWwSJriR?=
 =?us-ascii?Q?b2DHjPh1BVQ8ZUJdnne5kYcsO/bOOivrGHnkieg1nHzO2eE3yy2CKhi6Aref?=
 =?us-ascii?Q?7XGfPx2PsxqypODIQrdhBWruqL1ngF95VQSaOrCIoO/PfAjLRG05+ma8/4LX?=
 =?us-ascii?Q?MZleRZNnD4CMQJ8deDYo0or/o46W3fOP7CUyxHG9YYvbBnEgC6kfaJjZtCCp?=
 =?us-ascii?Q?S37UtBFghny+SOKGE1NluAFxCAZ8qYFZ9TX+0uP+?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073304a1-8a6b-40ad-d598-08dd97afa343
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:37.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyTGODvzqZkRO9A/j8P31FMB0c+z+I/YAP1/eQZSwMDyh35tzc2SGJ3vxB8afbRPYSeoFn6SszNAvrqkye4Rdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-GUID: pXFZx7ZH6mJ_l4Ih4ruol-fdXsmqCRF8
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a07 cx=c_pps
 a=qvBKVd3KFl3zkoLf5jvq7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=8_AniDzTzyVSuhZCgjwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX6eNhcgArcL7r
 4tvDcV80zwt/xfR07jlNkMwBAWliGolic43uGa1UdFJn6uctOmDUU7TRP9hK6bLvpFr9+jWeFjj
 a6jvo0cIINYlPWMuFtFxN1RM9Us8qWX3oiADGI/fCEncu/JFNaysDF6UBMWgsoVMp7+cNHCKLub
 d60q4gPkdWxSpiBZGvoqVPg03iRagUiGU+uaV0TaHV77UD6oYY0mWzUW/gxIS3TeY+Ohw18pLsN
 Mu3sdlDyTCQVzQqxUhjLm1QKGvYQ9YQtUOo3LrTNG7Kdt2oarwXdewvds77Cj1oKqA324YC4ItU
 cE8lvPjXcxODULJVHhc+CCh2TytQSCY2rZmROWOMioyd0gmuYjuYFRrnE9Pr/QmPIaye2gz7F+M
 zX7N2zO9l3h3CosStLbmhZrE2xfLdBD4a2GSoRUbFjDAN7vQbPTUNSw8MGFERTKSNTDGlsNf
X-Proofpoint-ORIG-GUID: pXFZx7ZH6mJ_l4Ih4ruol-fdXsmqCRF8
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

The vfio-user code will need to re-use various parts of the vfio PCI
code. Export them in hw/vfio/pci.h, and rename them to the vfio_pci_*
namespace.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h        | 14 ++++++++++++
 hw/vfio/pci.c        | 54 ++++++++++++++++++++++----------------------
 hw/vfio/trace-events |  6 ++---
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ce0fb916f..61fa385ddb 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -248,4 +248,18 @@ void vfio_display_finalize(VFIOPCIDevice *vdev);
 
 extern const VMStateDescription vfio_display_vmstate;
 
+void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
+bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+Object *vfio_pci_get_object(VFIODevice *vbasedev);
+bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_intx_eoi(VFIODevice *vbasedev);
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev);
+void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev);
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
+void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
+
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b1250d85bf..5159198bdb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -103,7 +103,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -111,7 +111,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
         return;
     }
 
-    trace_vfio_intx_eoi(vbasedev->name);
+    trace_vfio_pci_intx_eoi(vbasedev->name);
 
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
@@ -236,7 +236,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
     }
 
     /* Re-enable the interrupt in cased we missed an EOI */
-    vfio_intx_eoi(&vdev->vbasedev);
+    vfio_pci_intx_eoi(&vdev->vbasedev);
 }
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
@@ -1743,7 +1743,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-static void vfio_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
 {
     msi_uninit(&vdev->pdev);
 
@@ -1839,7 +1839,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_exit(VFIOPCIDevice *vdev)
+void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2430,7 +2430,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     g_free(config);
 }
 
-static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -2599,7 +2599,7 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
     }
 }
 
-static Object *vfio_pci_get_object(VFIODevice *vbasedev)
+Object *vfio_pci_get_object(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2655,7 +2655,7 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     }
 };
 
-static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2663,7 +2663,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
                                        errp);
 }
 
-static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = &vdev->pdev;
@@ -2706,7 +2706,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
-    .vfio_eoi = vfio_intx_eoi,
+    .vfio_eoi = vfio_pci_intx_eoi,
     .vfio_get_object = vfio_pci_get_object,
     .vfio_save_config = vfio_pci_save_config,
     .vfio_load_config = vfio_pci_load_config,
@@ -2777,7 +2777,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -2823,7 +2823,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    trace_vfio_populate_device_config(vdev->vbasedev.name,
+    trace_vfio_pci_populate_device_config(vdev->vbasedev.name,
                                       (unsigned long)reg_info->size,
                                       (unsigned long)reg_info->offset,
                                       (unsigned long)reg_info->flags);
@@ -2845,7 +2845,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
+        trace_vfio_pci_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2857,7 +2857,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -2905,7 +2905,7 @@ static void vfio_err_notifier_handler(void *opaque)
  * and continue after disabling error recovery support for the
  * device.
  */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int32_t fd;
@@ -2964,7 +2964,7 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info;
     Error *err = NULL;
@@ -3018,7 +3018,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3124,7 +3124,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -3214,7 +3214,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    if (!vfio_populate_device(vdev, errp)) {
+    if (!vfio_pci_populate_device(vdev, errp)) {
         goto error;
     }
 
@@ -3228,7 +3228,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
-    if (!vfio_add_capabilities(vdev, errp)) {
+    if (!vfio_pci_add_capabilities(vdev, errp)) {
         goto out_unset_idev;
     }
 
@@ -3244,7 +3244,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-    if (!vfio_interrupt_setup(vdev, errp)) {
+    if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_unset_idev;
     }
 
@@ -3288,8 +3288,8 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
-    vfio_register_err_notifier(vdev);
-    vfio_register_req_notifier(vdev);
+    vfio_pci_register_err_notifier(vdev);
+    vfio_pci_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
     return;
@@ -3310,8 +3310,8 @@ out_unset_idev:
         pci_device_unset_iommu_device(pdev);
     }
 out_teardown:
-    vfio_teardown_msi(vdev);
-    vfio_bars_exit(vdev);
+    vfio_pci_teardown_msi(vdev);
+    vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
 }
@@ -3338,9 +3338,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
-    vfio_teardown_msi(vdev);
+    vfio_pci_teardown_msi(vdev);
     vfio_pci_disable_rp_atomics(vdev);
-    vfio_bars_exit(vdev);
+    vfio_pci_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
     if (!vbasedev->mdev) {
         pci_device_unset_iommu_device(pdev);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e90ec9bff8..f06236f37b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -2,7 +2,7 @@
 
 # pci.c
 vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
-vfio_intx_eoi(const char *name) " (%s) EOI"
+vfio_pci_intx_eoi(const char *name) " (%s) EOI"
 vfio_intx_enable_kvm(const char *name) " (%s) KVM INTx accel enabled"
 vfio_intx_disable_kvm(const char *name) " (%s) KVM INTx accel disabled"
 vfio_intx_update(const char *name, int new_irq, int target_irq) " (%s) IRQ moved %d -> %d"
@@ -35,8 +35,8 @@ vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
 vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
 vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
-vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
-vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
+vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
+vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
-- 
2.43.0


