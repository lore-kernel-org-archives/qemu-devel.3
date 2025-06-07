Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297EDC61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNhA7-0003Am-TH; Fri, 06 Jun 2025 20:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNhA6-00036U-0M
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNhA3-0006Ri-V7
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:49 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556EFBe0024977;
 Fri, 6 Jun 2025 17:11:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBU
 gw=; b=21TdSuFBeITNP8J32VP59eluNZObuO/zBt1Ymev3rVj+J0z5lep0qlVV/
 vVnoTSssn5jVOLyBjz+8Jk9URGdW2aWEVgGGmPhMTF1egN8oT2RWAZGxe/835l/K
 f/bDDuazTobcYbhTxFzbEuKLwW8EPBelhvmHbAknl147JCmha+SCw8nzqBDcYZ0L
 4RvX5Qi6ZAwdTDh3kvnWuTxaIDWFGLpRuaQGl+n2hPUMc5BtvEJWdQ+6nhajn2WS
 eVuOxfH5XRuKgwqWdyVbpMLMKw1JGHqgdd3KLovn8EW55Kk+r+9XayE/iZBLflp6
 t8ySHQ5SLJVv5tKUHcCqWDERzKKSg==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2099.outbound.protection.outlook.com [40.107.212.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 471g88usth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0lAdfX2soRZEGNok+98eRAEA8YThac+NaVkCDkjlLDezuFG5RFZ9x+ThrIPie4fn+cNi0fL314NVipMe2v3Ns3lVg+WUX3ywBu03ktIcIA62dClZxvo59+foEDTC5mZYUMMesRzqKBH6x7j7xP2vfyefAXWvoU2V9kptET8ys+hdvOBSfGg2ZQvMVXj/V80/K85R0fOgsw42QQxk6lqGm3oXY5kNW5uY9hQ8NlXtocHT0N/oXqfe/xInlW3BirbB3z5G7hlys2kxw4jTa1x3JnFWvjXEVp2em4v2sjXMigaEr4SKhXbLOWkrjsXSV+5CKvQw0XW9Ux3w6pNK3iJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBUgw=;
 b=WlopAGm+g9T+MOfFc7do/5d1ceTluUR6g/a261Bx/DWwtVwUERJLRr5Fiur7EwYdCoEv9+OmMeWS7veTDBgz7alSmqDSHrjm8DGvppFxRYrCwELU0scmfDCGMbK1/ZVCjtqNIU+OJxmdCDXyJQqVPlT0XyAOyCzBno8TmKrbeEqHFIlMWZYMpda3hFiQPP/UK1wqdQ3+O9Zrpowcnr0zSCPJ30KZ9VjHvUQqs9IJbmRzQnC9c9TeRLp+iTkTE74qH9RY1dUrlsrDs2tvj8b2gjHo0EiW2EqlkuUtErjOsFerIWHH1qOFghGI0dg4Fv/P/E+ICPGduOigzAl+STt1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBUgw=;
 b=F/hObrJ1a1quQpO8GzcPzrlOuYAvSQeTqsNmY4XzELRcSnKW7x3t46heD+ZGfc9sEra5og/I3+mkVzGQCVsI/FRWw3A+5VhlFDvGGgcFHWUHLCGOg6pzImmBe8s3ZYjeu+kAVwbnX4p7oZMjzFWOA2lq+mOeqAJr4mMDFgAUD8pztZKUFjo15s86oVZxAzJuSGm0ZpU/gBcpxvfmBXgYHVicmwibRTH7FRr5sn5jfwa7t7x7nYtGMQ+61GCc6Nzxw44BfNYcevaXVXeJ9mp1WBD+vJzdMyyV79yHWo09/0LIK0uyXjEubC6oO94kUAJ5FEfvOWe/UI+JMLucyeUW5w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Sat, 7 Jun
 2025 00:11:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:31 +0000
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
Subject: [PATCH v3 23/23] docs: add vfio-user documentation
Date: Fri,  6 Jun 2025 17:10:55 -0700
Message-ID: <20250607001056.335310-24-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: a550d208-a55d-4823-cee2-08dda557db28
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JNBLrWJPvmUwXttaja0d5z03BlYXsNQ+bXDRjHpP9uIH4+Z9fVqygN8EgUMW?=
 =?us-ascii?Q?zQJ/UZeIc+2I5PamQjeztiEhZxjqiO2z4VHiV/sj8V3+T2EC0285GCKSFAzJ?=
 =?us-ascii?Q?wsPmLg3p1B/RmUFUJt8nTPe4wXCELW/8eYVjm9ubPT9AoQKXpNlawrFNsgk8?=
 =?us-ascii?Q?0ZnDko2EDcdkCSuNOYrspOmFzv/JJo1x3vvcxzelS0svXOTgqVdJRbo7gg22?=
 =?us-ascii?Q?zI7FiZq37TOriuwlv+5dH6aTVjbGfGteCQy5j8nP+N3SSJVNfySCv1j7dGtD?=
 =?us-ascii?Q?w5sG+ahIVdp2anxFao2YsPhZyLQyxN930S3k0TvpKSiMFp4nbAgIEIH4Ii6Q?=
 =?us-ascii?Q?5KFjVjjS3Ktbe99CxOEzbtv7T6uiFV6fptfJB72wS2NnxXSqt1dD9caA2cK7?=
 =?us-ascii?Q?CH2812h54Plf6RfBf8d+/2iThf7k2GCrPWWUEhIq3FMRxfmMrjc+Y9Zt1FuS?=
 =?us-ascii?Q?dmZlW8cN7zrXuVJ+na69DE5ZDl/co9Jr+e6Evq7jPTCq1PEAwf61kohodVgA?=
 =?us-ascii?Q?fiVr3UbUKB3mrYCPCS5sOCwuJf4GnbDa4XTXpUpId0ChR+u68fZeXDUpyKCZ?=
 =?us-ascii?Q?4PHSgFIe4PCc2OiZQAd8BdfVSSjHHxE7l59fOixnRcB6l0CXUeWNR9xWZ7/W?=
 =?us-ascii?Q?hrRizwUx8RfFeqFxSDjG6J4ocJ2I11HAAmRHXQ68MKoea+kR3jCESjrxvlrl?=
 =?us-ascii?Q?fdmnj/y/WRlBMmtbBpXqiSneHww+n4kRbnw5sxgTmz5ScNVeO4k3pgJPh4bT?=
 =?us-ascii?Q?wTaY2n0HQfcy+2WMTqe0DtPcmncrf75EyT1CSMJzC20GLuLBS09hUdL72I8C?=
 =?us-ascii?Q?lCLvl+k1JDXfTtIhg1oY7Vzoizo7w5zm9AjDhCP1VF/vNIJHA92Du6022LoO?=
 =?us-ascii?Q?EzIc+3Qttt0GYh9QSYmamGekxajf3jjXF0r4Du/Nrk4WlUSCY5qPvsExO2hs?=
 =?us-ascii?Q?vkkYJyYbT/AcX0mdJrGea18M4gCA9IANDLInjAvbzvld8n9MZACgUIFbC4ZL?=
 =?us-ascii?Q?27uqsk2mMJs/zSPH1oIbUT9+aT2jbwrxBNEIFaPKVhHj+Kx/VApynV1tl2mS?=
 =?us-ascii?Q?L50lFamGZQKkj94PjSM1RtweWQy5tTCKSizYQrDN8iN0sfy+1M+HmD6MFSs8?=
 =?us-ascii?Q?CxT/jiNc7TnMzyscv4WPWuSbR5emtUMub/Cht2vNG2ceGyuK3JyujHjukH6J?=
 =?us-ascii?Q?SEzWYsFEcTP8DCBVYQEmDMZ8inQmlcPqlXFfbhZNnQ4jezJJ41Dn0pJquXlE?=
 =?us-ascii?Q?tipyu5FLDA4L+ZYv8yi1RYg34g4Y/pxsFzt0qEprsjTAXL/EswoDblbugz+T?=
 =?us-ascii?Q?b7hssVGvdet7kCeDqnXZQ8DnmDAxWMNEvnTA95ZHAAGVxwopp2bSjcnLVEz3?=
 =?us-ascii?Q?JQ69Nh+4xyYZDAQ8IJQzt8IxNlYvOPXSjPK+9UMa3xBq1v+5uvAfy75yn5FP?=
 =?us-ascii?Q?Hl6GkYY93hg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WGG4nTgl1ok0X1HrAB0bpssHZ/OaKvE9Mz2pfmKMvdYfyp7wqqQ4cLEz15mo?=
 =?us-ascii?Q?uoewugm0CUnaQOBnHBr6T5kM07ExZ9YDcaXqaJcvY+ef37McZcfDR/kYIn6h?=
 =?us-ascii?Q?2xNTMg52QSUfcqlTDESKMmBGq8Ln6yhPgADwc8g5wnrwa22or4zZVW8nVfOm?=
 =?us-ascii?Q?VIzRIl0NxKVaKdROD4cSNGHM86c/v2NeKZ4h3LAbDs0Q9vEV5RqwLj5vd0Z5?=
 =?us-ascii?Q?7VLUggvOdhQNBZvxGnXcFuxBLv+VDylQuP4oPghNLyQ9Iw1odiJnaTQj822Y?=
 =?us-ascii?Q?+Y2q/cLBytexFBS5AVRhcKxaQrV6D0XGB6FXs2Cy6bAdG1rALmktNxgKusPC?=
 =?us-ascii?Q?uoZxM4i7qj0Gu3bjylBc8Ww46wGrnnUC8kKWs1DqP9r0MRm2KJ9xf0QKruIl?=
 =?us-ascii?Q?JaB80PpeQS67wJdera7QrfwRiCCvqRcQ+xfJnmNxjP1F8Ym23m3qBl+/h+7a?=
 =?us-ascii?Q?K8grY6A8QMppGoxfpFZxf2gXSLYs+mS39KtsFOAYiKX3Wr2Yh/7rZJYL9pK8?=
 =?us-ascii?Q?NeDqZKN660NdqKWkxWqMi+J2XCSW3A7ooeMB+PqxIp8FHNCTchLqBOeNZ19l?=
 =?us-ascii?Q?yXHUhNYbnfblO8M4R6N9mePrf1SVX/PG8pBzuV6mP/yqz5jE0y0FpLVYqiL7?=
 =?us-ascii?Q?7hmemJ2VONkkfxS5+dj3yFpKwoN4HCE/ny8Ri6x0ZWKSPmDM5Pc0AN8nL8Ym?=
 =?us-ascii?Q?Dbm57qeK3md1terQiEQhIvCDd+AoYC12JXCyERerQGlxQnz83/qY+2mrbhFu?=
 =?us-ascii?Q?rd0iBxQGUbmPW1e+o4bhkq6c3qkJiG0nU/6ke/GTZndjplBu3T0V6gbOlEjn?=
 =?us-ascii?Q?ZD9rP7n7+R27oxOOfhPoH3DzAqNvZprifeNcccwlCv/SOf6JcQs7Vsl7k3FI?=
 =?us-ascii?Q?qlFfs2n3/7YbIG5NEfTC4vtlTLm0Uq38Tkg+sqaZmswc5UP8l2ACW+2WMy6m?=
 =?us-ascii?Q?0gyw4blUuua1UIyn2Kyi313w5v4pqC0XBhrEgP2OiNQcCdMIn2S2OZ505N7f?=
 =?us-ascii?Q?hTce2gHFbqg3O96FydEkMcSePiv3AHYc4Ugx8xDr1tWnexS+L42hV6bTcTU1?=
 =?us-ascii?Q?fqUwx8NKyBzPQYiLm2yDj0mFfAw9cu2kM74+y8e84z7dyqNEX7LCgAFuAVb4?=
 =?us-ascii?Q?ra2YxbJiPXIxb6XINLNn65HD1QHxER6Kxd7zc6mpoVOkhhBp1l5o6sHP96vN?=
 =?us-ascii?Q?3mjMJ9FoaUyvE2kCT5CQ0bQikGmDvb4QQGlCwuh/pTSpsEcE5Pi92Lg1pqYH?=
 =?us-ascii?Q?m09fbgnKPKrgu8m1dtRkthAbsDtOhuy27UXQZwsZceUorJFz2ubC1SVF9Qqi?=
 =?us-ascii?Q?+CuBc3lFEHLz1PDJCND9enMc2kbUrtQx9dtgcOjwufFcJeWbgVjZvJchXiPy?=
 =?us-ascii?Q?9A6XTbRRPb2Yp5EYYZFz9icecJfvMnHCaaGpTRgBWQ/M9XtWHtuLLNMxu/NG?=
 =?us-ascii?Q?GfZBG1akDxE37+joHP9kKnGA/2kf5XX3Ofu7gSfv+a/ehTzSWFvInJbG+lkN?=
 =?us-ascii?Q?+nw2K/ph6pqIkNZAVpWxZ5bHegzIl7GNu0uvbGWLYd6kPoXT1NTVrS7toc6k?=
 =?us-ascii?Q?uXNVY5SlwOQ1CD1LroRiM+NZ8VIEhMJkDjQ7dM+f?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a550d208-a55d-4823-cee2-08dda557db28
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:31.5880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ov7lhJ7S/j4OFgQsk7Y2Q/HtUiKo3I5DGc7gsFVa0LzfIH1EnNXE/vywxp34MaueXmiYMAo0EsEaWHgZ3/pt8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Authority-Analysis: v=2.4 cv=K5kiHzWI c=1 sm=1 tr=0 ts=684383b7 cx=c_pps
 a=XWLsCJYX8W/xo5I+dSU+/A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=LOSiUy74ef7l4vre4JwA:9
X-Proofpoint-ORIG-GUID: XMFr4WMXYlmMY1hYjim5pNWPB4_RdRmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX8lFvaUtWGXcw
 Q5NXgdhOa9creKi3r5ZzrZFsbGS6/A9OaKg9yjTxP/eEw5keBf7otslMAU9phMXGgUDinrjYqx4
 AxolqcZsJkn5rfMKWOmjGSv/JXOK+0uNJHd7+rzmn0bLaWjGLJv3HQw+jzxBRNLE6ZVe34idQrJ
 tUUw62ToCx3DnC/TrxtkrohKNcIEfBZGOl985modG62qfFoj8e2MKW0wNSTTAVM/RyEJRTO3eJ9
 c1OSpxC2yU+RmdNYT0NBXrvDjtCgv1mNKeh/d9BzxMZWB8XUOzX5G00vgOLtt7IHZ6zVLv6Y5gi
 R6yxWyilUUQazi4sDqqiuJla0dCmRqZOQpjb2czzLStB7/07UIIM/pbMW4Srrp+xhSwjynlj6bw
 rBSbcznpmNWrmIWd0cB/8mG5JIfIek5l4rD3KJ/w8jmV1Ju4lMMN4QgikT8l2KB5bh0btAR+
X-Proofpoint-GUID: XMFr4WMXYlmMY1hYjim5pNWPB4_RdRmP
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

Add some basic documentation on vfio-user usage.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/system/device-emulation.rst  |  1 +
 docs/system/devices/vfio-user.rst | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 docs/system/devices/vfio-user.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index a1b0d7997e..911381643f 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -85,6 +85,7 @@ Emulated Devices
    devices/can.rst
    devices/ccid.rst
    devices/cxl.rst
+   devices/vfio-user.rst
    devices/ivshmem.rst
    devices/ivshmem-flat.rst
    devices/keyboard.rst
diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
new file mode 100644
index 0000000000..e33e49d283
--- /dev/null
+++ b/docs/system/devices/vfio-user.rst
@@ -0,0 +1,24 @@
+=========
+vfio-user
+=========
+
+QEMU includes a ``vfio-user`` client. The ``vfio-user`` specification allows for
+implementing (PCI) devices in userspace outside of QEMU; it is similar to
+``vhost-user`` in this respect (see :doc:`vhost-user`), but can emulate arbitrary
+PCI devices, not just ``virtio``. Whereas ``vfio`` is handled by the host
+kernel, ``vfio-user``, while similar in implementation, is handled entirely in
+userspace.
+
+For example, SPDK includes a virtual PCI NVMe controller implementation; by
+setting up a ``vfio-user`` UNIX socket between QEMU and SPDK, a VM can send NVMe
+I/O to the SPDK process.
+
+Presuming a suitable ``vfio-user`` server has opened a socket at
+``/tmp/vfio-user.sock``, a device can be configured with for example:
+
+.. code-block:: console
+
+-device vfio-user-pci,socket=/tmp/vfio-user.sock,bus=pcie.0,addr=0x9
+
+See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
+information.
-- 
2.43.0


