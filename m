Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F7BC61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9z-00033t-9w; Fri, 06 Jun 2025 20:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9x-00033T-1c
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9v-0006Qo-Fw
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:40 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556N0Rt6023133;
 Fri, 6 Jun 2025 17:11:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bBSUnVU/HbOuDO4pgq6VsgTv/BA1EDII25SIHoHEf
 gE=; b=jfsCnA34hmHgT1vgpqA2kWu/LgrsvOlB0/7HUMJDpZ69glUPvHAOnu08M
 Tb8NAwLc3pGj9mQ+0GDgeSzgO7A1aQJtltTQtV+Go4xRGDIbE+Dsmt4UVkK//jTb
 zTIDeaK7go+SD+JNTvvjH3ooC6TwzDylK54GlBI92HKvj7W3f26Cbf2za7hjeJQD
 FjNXkmzmSnuXiwG6P2mXCXFDfEEdaEpzO3yxJPsD+9nFaggB+e/iI8vJZVMNsiOe
 YBB1YBfqwREVczaQ4yA8dXKMindt2v1+cbeVP6BmlRZgs8LMwKxtXOPx8lLcQjId
 CKXM9dGckoovBICv5e9CklfrYrPVw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2126.outbound.protection.outlook.com [40.107.212.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi1UGm+7hZ0z/IdrBynhxqWQk5Ef+fxWA7IeeLqgqapPkVmnxqrx5YkXCAFUK3JXbKVd5JyHP+iVFRYzDyFmcK2MR6Rh+Fd+oOUCjUdShKqhN4jqDXrRLdXNNEcQYRF0D+5IzVCi+pTvjcEegbUe6hafPZzHIzs6UxxVve177XcD9K1eVr3I8deDvhNsAMzfJLQnWhJe+qbMnYRpJGMeNutr/Wmtl/gUpDRSq7lFdfi+Q05+EgVvkXtN7oAbbm323WTb+gnaG4yGBAGk2ZWrG7rEpxjKIHJppQqwSBb9odJcneoKSNoJCM+f0EBCOfvfDxSKCcEESGjhIHpO6Ly7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBSUnVU/HbOuDO4pgq6VsgTv/BA1EDII25SIHoHEfgE=;
 b=Ta2C9Ty/t1YFi19z78kFVnMTGaPKZKCOSm0jILWXuQYOPVxyiO98olejSP04dCMaRv+UzOomg2tdv4E98hiOoZ0CWqEDAaELfKUrRLEPyftKqBMuHNznCAWl2wvOw/KoHYUkFD6ujLbKqnzENxJfeYaVOtROLcKjPOQSiHKMGo8fvVD5EpvDDecqk+vxiRnX9Xnj/3jav/Q0B1k6TGIzlaPJ39C7nsX4FcxyH/CQ0IByWjb3lAUdj7r6cUlKCAFKy7nLaAtfpm6oy3Nsd59BETiJGA7Ez9VjUrup+W/W17mKJtfFjrzcpX2iHgZFKNeP0Yxfl7gVTKVihjNm+p5WuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBSUnVU/HbOuDO4pgq6VsgTv/BA1EDII25SIHoHEfgE=;
 b=ZyhRUeKmObNWPthx4gDR5cEUBeRzBj09YwQ9ivf0pK3rnLKN681TvnQoueqd9ajsMuLE6B0iyMausqA1Kb5nnAHb+68hlU53sD3mjonGvg+79g56oFtRSePQU6uBRaocilRMDvhmY2DSfJKZhCnma/dghuFlxYNC7QN6RxV78gnT/l5vxtxLhxqE9qfdX0kcwzcn7eXTdOZlPpDqJ0mZdeYuLNqOB/J4zHqzAOLWQ47f4hIKxqAIzLYyE5mQp8VOjZ1ECAj5bWon5f1KstVOs+YwgTIJ8wp7DPv2q6jK5LZs+QzJTta7IdS7afMLyFfrTi9cHqtkQ6Q+e92M5TfVcQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Sat, 7 Jun
 2025 00:11:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:23 +0000
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
Subject: [PATCH v3 17/23] vfio-user: implement VFIO_USER_DEVICE_RESET
Date: Fri,  6 Jun 2025 17:10:49 -0700
Message-ID: <20250607001056.335310-18-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6478179-2999-44c6-ffac-08dda557d62c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dxwHbjU9sqYFZLdj6yCZtu9u1RJoQJqIB/Rk0T8Clyooxo519Zu6f1WIb8UU?=
 =?us-ascii?Q?EU9557UwEs+WlhV7m3FuXOaIRNSLU6evxFmBoorT7NwEn0gxkePg84+DXMKo?=
 =?us-ascii?Q?hgfGEBIpsk9GiqRVn+Vpsj4CSceFbRK9Xq7xkeZxj+OQAS1SteguU1dMnUT0?=
 =?us-ascii?Q?X3C+SarayksAYt8d7IrVOleOKAueCT0mos5QZlPygao1XivSMir4ckLdXzxJ?=
 =?us-ascii?Q?32CAIooQqBwxsNtxebHrwzeBQCxzbXOLPLRc+SW6sVdXylLZvvuwmto8xkjM?=
 =?us-ascii?Q?TyUt3OARQ18IyMAdhnm6XRDG6zPxf1d+5MCWX7hN7UDY5ETK5QQRDP9lmhZF?=
 =?us-ascii?Q?8QuFyrZ4A4vwFbXrnrtkcMQ1zNabclSKrqkaTydnjETVw0b4shemTesYK2bg?=
 =?us-ascii?Q?zbXCS2NZzf9uyClxio3RXv299+Xf4DdjRRaHG2R/nB7X+jzoI3NtKBV5sq1z?=
 =?us-ascii?Q?ah7atqxudenLnx5vV50qixPH82OQ1yEXN5AK2h/5d+DBrCKsYys10U9MVCNj?=
 =?us-ascii?Q?7BJG0DlrNIgjJzl4CIaZT3HnYI+8ZAXT7OhTLxcnQIar7z6bLkdvn8IYfF7K?=
 =?us-ascii?Q?xU1msAQkLt8s9lyjDArp8RaG4e7akP6gsqn+EGIogqmdErgH51f2sG9UjfA0?=
 =?us-ascii?Q?Kahe7cr3nRc3EXapkUK11MHLiMWV6wtf1T32ntg/rnNyol/o7259G/Q8xTqf?=
 =?us-ascii?Q?2ci5oDveOVuElBvR/BYHfZdlBockAiVNQy77oT4hKXariVsQUqgswJkZ2rn2?=
 =?us-ascii?Q?82NYfDVoWEz7dVxc65OQHe7TLBq0AyuYSSuNKkC+4Q3NSHyA6gz+vTPHfKYG?=
 =?us-ascii?Q?Swx/1cZhSY07lhAJU6XepFvKBtv5IdrKJqnY8HDNm1tX8RobfmAcd8h4Q5Si?=
 =?us-ascii?Q?tQRSGTty+EqYKa0/SkIKCAELfxWKh4MmckL9P+tHSZdWRoh37R+LL0d+sRrL?=
 =?us-ascii?Q?oSuKYP0hiHxZg+15TjtvAxH9/LVm3stAuMnbbaYXms/qb1kV7hUlarPkoJqE?=
 =?us-ascii?Q?l8+aSr/Hyed4+TB5rnVE3M6GZMktKjY4dBo7IGvWNtD9Hiv79ILRKRpquULb?=
 =?us-ascii?Q?mCk7WDucdaGkpmRH1mw32cIg6QDypP2nUm+tu5sqa7MSlKfEw0Bc5M8tQ/Wb?=
 =?us-ascii?Q?VLhXt8JA4r6C3+09enIst22/m4zq9JN2LBWUrnWWCBYI+VpycbBEuCNN2clS?=
 =?us-ascii?Q?e2MMk1aZvBu/wolIchNFQ93Nsj+sri67Dd65ECbw8qc2KCMz7F6y2d9yI45e?=
 =?us-ascii?Q?6ykAvcUoLErc2AOEEyF6LJo8Uag0mSz1P5GnS73zYkBhhRjB+zWGcJi7YSgR?=
 =?us-ascii?Q?gLlQnqZGRtZOjptPlyMzY5GSaDUYtmTJfoXe+bJBBSnFNnxVlBlSPggm2vm+?=
 =?us-ascii?Q?iqO31rycvEOZc1lAx2DWkYn/KbF7ykA03TsFV2HpP4AtXYIw9bBrHr08wWFg?=
 =?us-ascii?Q?TIh6urX/ZIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltaVVVt1AK1j9bbgoZ+4NMZa2ndJvwqyvhOKThd0K3rKuk2R4Xc/0aP6jcpc?=
 =?us-ascii?Q?8QEluwiX1Z/YTvP1HboCI++b8JApm0R8n9KwBXGkPnQMtIcTpm4b8/KhxH9D?=
 =?us-ascii?Q?2uuk1B6OELclY4Ep4LYwRUjGqYHci8MP9J9lLqKkMm7wxIZp17vxAzRtd0/Y?=
 =?us-ascii?Q?t+90x8t5Adkzygtwt2cw/PT6acy8s6SjT13t5DHValyf5J6h8kDjaiGSwc2y?=
 =?us-ascii?Q?JguPCAgyp3CXVahmqFRJoN2a1lSSLbbrPO3w6/3feVNAzDFpLU4Qjp9Bcxae?=
 =?us-ascii?Q?MaiVTIaJ+6p1YK5yssLncDvoQLavvmDNRoC+xCnHTcCDRSkW1SJLmiUNEQ/x?=
 =?us-ascii?Q?uhq5KSBCWxXZWpyxL4oMWx+MqZy5xoWQCwnD+LcgXp7CbtN3z6IUvJ/RNUE7?=
 =?us-ascii?Q?VopNtRHbYuXEs/GTMfVrqN+AcyVO8ez4BrkjK+DgZ9EtjKB/qQGSn99ikxG1?=
 =?us-ascii?Q?cL7aMFlfPR76aiGm4YlG/fIx1DtplszsWNHsp2AskVmk09+SzFyfD/npCUHO?=
 =?us-ascii?Q?k4O+EwxOCrlQP9CNOBTbplW3qaeWQrX7kOAlrDVfhG5GfLA065EA+quljGZi?=
 =?us-ascii?Q?sM432jqVq7G7/AmYzeOwiZZkjXzdgWZ6h8DkPFKjxWdR7SAs7fmaJe7tHiX4?=
 =?us-ascii?Q?Kf5b16XYMrNz1P3y8Wr85U9euAo9jwZqUu47Rf0tsYp7SVyNfm0QjoSzSJj0?=
 =?us-ascii?Q?7pc32mm1WoAVuPCGYS77+H+Rv+9+cqf7yTQgzRSzxPA9AOYgwbriirIiaXDl?=
 =?us-ascii?Q?hhIj3RMJ//9JZ0C8o6EXWCZYaYcbtbBUJ2DJFaRdwQPYkszfF+SMp+fYXVJV?=
 =?us-ascii?Q?zBpe5flzPQxcAHjPKOIhinaH1W0TXqtXXCbGsRsyBsVu7iwTccHETqOcP2LR?=
 =?us-ascii?Q?6f4Zz8ohhxCc7zEp0toUEACFgQ2QX9ztMbzMGkIC61E4Zv+zUbXHQ6ofK/3T?=
 =?us-ascii?Q?OvLZqRld1jybvXY+K8Dprsfjxr77hgNuhsZ8/1rkcPSZtYT5d9OKo4eyBgZm?=
 =?us-ascii?Q?jh59NE35Kl2tfqjngvWYNPe9G3tDAQAvQsP4eATe+/bNlGF23zcj7SN9Of3P?=
 =?us-ascii?Q?1mshBgtmVaKxo81n+7GTa8vIQSBzRP1iJTQb+1E3NiblxMPk/QFxKvb6OCNk?=
 =?us-ascii?Q?faGeZNzRoC3CdkBfWIscSOw48qChF5hfhauwkUFhv3zdO3r7O5dJaSC4HRKT?=
 =?us-ascii?Q?tvDTMiM+RNCaqkxYVvRlAKodBr6ErEW1c4f7CsGSp9mSNyg9bY+IyW/ftwwj?=
 =?us-ascii?Q?4yxXyiTKJ85rmODQiM6lMR6ZAZ9r2SgAwweTSV4bZDoFb+kdKYnuFO6cX1dX?=
 =?us-ascii?Q?3d78XSUmx/0kCvet5fMslTSWTY5/vWUW3XTQaCKSnKrTqQq+mR/QtJObazDR?=
 =?us-ascii?Q?2uhVQ1aj8LwjHF2sI9q1ZPgqteacfPu11K5UlA2nP/kIeVIlB8wWFFn4UPzZ?=
 =?us-ascii?Q?XtXR3xx/TdfxLhjCgV0CbR18+3CO0v9ZVUEGjfYwUbkYw7Dzlx1vdOVHzGgn?=
 =?us-ascii?Q?NKDqHQWYQM001nVPUguw2LJ9PvnB2ya58UQUFHt8E9RBfo39FBTueN0A/KTD?=
 =?us-ascii?Q?yJZR1PeiaDQq7kzwfYEmg5KqaTANokmCV8aQMwIp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6478179-2999-44c6-ffac-08dda557d62c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:23.2114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eh7JFakykTM0hvXnZSXnvrk1qzJvo3n37spGs3c1wpQAqDIpnu9AWfOKRQem7KDJ+BS5gqZuDYuaFArvQ0MHiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383af cx=c_pps
 a=JomqzcHDjT5Ni/tnCvtrfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=70NfNXkHNs9el5T2m-kA:9
X-Proofpoint-GUID: nb6y1REpUdZnXUpk4NPxc7WqiLHqy8Y4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX8vVK0EQwrll0
 Vi88pAK1TcYhN3IgUABM45sJO+kTprYxAwkxeimxgJpUzYmkMSJOowZJkyqh7sR7YjNUlzeYBVu
 zZ9vIfeHDUy6nTKCHAiLNu55QL0rQ8dqoeWEje4pRuF++5l7vzqO+vzdDUELVl/PG70nE1LTw6R
 HRPMKntlF3N8a4BzTS4tY6afDf6PRtbUmIv6nKQFd8Jcl0Wnqw60Ov4BW08mqi71Q3jSvbZGwQA
 SQaqvbkGWD4oCEaXQ4cNCpwXGel40YuAwSkXmX+58/27rEAxAH2K4LvoC05jlQ10SwyfOfzvzos
 0Q5Cu8CoNrMfOthk6+AX1I8RVS4xmnOiu4COJNi+hwkAiOpMCLO5gLKWNbg973qfu5Gk6XcUzsW
 6Olksr4gG1kGD99lBQeOXrvgSs4rb9AyCZAU+wL+vn+AUlIvbUhEnKnuxn8O5hHFpKYG74sR
X-Proofpoint-ORIG-GUID: nb6y1REpUdZnXUpk4NPxc7WqiLHqy8Y4
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

Hook this call up to the legacy reset handler for vfio-user-pci.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h |  2 ++
 hw/vfio-user/device.c | 12 ++++++++++++
 hw/vfio-user/pci.c    | 15 +++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index a5a2aa9ba6..25cd4c8a00 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -20,6 +20,8 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+void vfio_user_device_reset(VFIOUserProxy *proxy);
+
 extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
 
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 45b91d22f0..b37f7329a1 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -49,6 +49,18 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
     return 0;
 }
 
+void vfio_user_device_reset(VFIOUserProxy *proxy)
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
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e055d5ffec..2bc71b9b54 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -261,6 +261,20 @@ static void vfio_user_instance_finalize(Object *obj)
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
+        vfio_user_device_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
@@ -279,6 +293,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
     dc->desc = "VFIO over socket PCI device assignment";
     pdc->realize = vfio_user_pci_realize;
-- 
2.43.0


