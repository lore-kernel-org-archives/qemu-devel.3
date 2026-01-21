Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4121FC44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVxZ-0007PG-Si; Wed, 21 Jan 2026 06:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viVxW-000729-OB
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:01:10 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viVxV-0008Ku-29
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:01:10 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L4Wjcf1232099; Wed, 21 Jan 2026 03:01:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=28gt7SWA0600U0Mt3nwsP6s+B9D72gkcyq4ryHop3
 Z4=; b=DsOF1FVSJtvSh3u+opLu8KFi+kgldMUrLqu8XxKTIXWXNH/cc+6naEHoa
 8ACNM/lIeWZglccPbw/cpKFZKVN3apP3JJviwjGFWeeoAkVTjqZTzRZf6CJ8giL4
 L6nS9mjxyrEVwHnup+BumF4aFEQ2RN0iogJwBfIqyL6NYSSteijUygcFBgntr7VR
 RF2V6OJUMxFkvIHI1d+14uO24anIBmrmbNbgx+JoxfyK4DYcNT1nvcIg0GEHNHwg
 iaQHa3TJwIejaGcnzv34EBxDkgSpIIg3PngdB99MpkYWrFhs5M6yDTjEHV8/pda8
 V5zfvvb5RKWBUEuYtn6d8d8SQ7a8Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021118.outbound.protection.outlook.com
 [40.93.194.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4btejhj5xg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 03:01:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbTgQgFkWn3C2Kct2Mw6m5eLqurm1jCcXPaTi7Pz0hjCylsjHQ4WU6T+OzwgwqIN7PzEE+hubWBYVXG59eSe02kOHpLnNb3wAoWiw/c0NTsn2BcFzwuop4b5w0dXdrbsHqQZBd5Rrk6YG8y3sM3Gj59rr181U7PW4/Ou+Jt8Cy+wOUOVb1e4zDNxhzflBUEo6yauBIdyZIh4P3wGrMePhxgYaFh29zjo47s2NsquQbl8G6sa3Rw2ryAoDsRO0Z83ZLlRZrrlJHULjGuIifjrH3nWNFS17Wvhdv1yodfeNnZsXlTcgTSqn2I+JdlRDiJozjHEzS0f18Xaoen08eLKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28gt7SWA0600U0Mt3nwsP6s+B9D72gkcyq4ryHop3Z4=;
 b=c+lg5dIsOSMWnNgjhw4o8nSOmO8iGJObuYb6xeQmSVcEJcRSLvUQn9L+u7qzqDLIHQ5dEsGnigG1mLaviO7Oi3R5RzHqPm81vh+70Ce07vjb4YpX6Ql4KBtXAwJzOCk3FVKY9Eqt3xszpLZJ3eY4ZIbF33M/4WkgDWNlJPWN6UaKWzyneLnVQklFdBNZAInVhsji7fgHt/wI4o67Ey5k/Y8XgAIDEZMk5tFOBkmh2rMknPIrGysxHrP7HcAXyjTTFKesroOzf13pnuWuLGOBx6EsvbvjfjKrcH3gr/qP57aFu36ocXPgj5j8zoElIOPPoXQSP+poCUs9uHda0O8I4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28gt7SWA0600U0Mt3nwsP6s+B9D72gkcyq4ryHop3Z4=;
 b=w64An0mvDNcrc9nW7XlpEOPkUQAe84eq0JoGJu1dY/FHDAQH80lt37M3YhmytDC/XCm7KDt0u9Zrfrfj6iAw1hMZ2Y38fVTbxgSpFxEMKNb7uN4YoaIs5SfqwjodATkWGTgTnSa3kYb6UOyzQzhyzDz1Av5H+uo9FTZTOSW0jRoq3CfaYRpMCovqejmmJiJoF+QQ+kDmvZgoyI/oiSzjs7h4MsvZpLiyU5nDrOiOaal7pO+MuDasGkH4M/HfZowEtv8uAoV59CLQ/+0uBferhMiN3d8SD+AUGQu+dlzxlh/Q3lBMAiHbQr1qq370VZQH+agzlKdjOJcw6lR0gfnP+g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9939.namprd02.prod.outlook.com (2603:10b6:610:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:01:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:01:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: clg@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] vfio-user: update VFIOProxy flag constants to use the
 BIT() macro
Date: Wed, 21 Jan 2026 10:59:46 +0000
Message-ID: <20260121110055.2333711-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
References: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0140.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a4e3da-4353-44f5-b1f9-08de58dc5ffd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qujfyg+fu7g15WDCndIq14xyui1g3aiSnlVZb+1FnaDqiw+xwoNlWMEsSrJv?=
 =?us-ascii?Q?EchUwYkk5/5ThZJKUwM0dbEtMSfNUhYOFHBI3eFJFavHnmc8Ad5L4w1baRtQ?=
 =?us-ascii?Q?247u4yxLYVnv/LTZ+fAJRmydsrAqBUZJjyNE2nfTTRKAFkHGxqT+FzSbLUD3?=
 =?us-ascii?Q?8A3jvAI6qp8xX1nkJ5xdL4+QTQRJEQlAtjfyGUNlIdkeZeRwSjundAE34ego?=
 =?us-ascii?Q?8LKZEJGwzKQdGyIDvpCjkNNlCBOIXVfCZDM6r56rKTREPTU4rnhanjFXI6hT?=
 =?us-ascii?Q?ZdjDMoHY+DYtx/YgYRoRbVrS3P38xorYhnky2fENXS3TSZFciYQNlBKUl9Dz?=
 =?us-ascii?Q?/SVMZKo6Oaey6bq03PljbJj3OMyHMuCt4TwAEesciCa8J3Lr5/WnYT/ZsXvQ?=
 =?us-ascii?Q?3fQegfRs8gcAGljyCzw5Mw9+GsGkYNmFuokK1jILRCJAXiIHkJsf1tL9jsZM?=
 =?us-ascii?Q?H8zAQ+cvfEcFV/J73KF5JfO17UxOwBcthkN0u0jqW3yubMnVtmO8ZehR7+7m?=
 =?us-ascii?Q?pqBByAgqeIxeg+xQGs56XZmnttUnwgcGOGjzUF2qSDlx4dYQ4MVt9yNL6XG/?=
 =?us-ascii?Q?1++rfM9h/cq3B4rjPfPlUoYucCNVwJQaf9aEsa1RSRAKjXyIExBkzqWLrd0g?=
 =?us-ascii?Q?nxK244f5LG1xdK+rCk2O+WnSwuh3qLfDulfxnfXyMrdpJrGOmIHsJpJgFo1b?=
 =?us-ascii?Q?pbXbadIowGv4JKymCzgD3ewvVWVmEovZsOvysme/HW1AZEo1ONFLFT6sqxD+?=
 =?us-ascii?Q?MtOeq8YRW7wymvKqJxjA86+g6CXAkyxmMfenYGX2nM5tpsnGfgQz9dFbCuS8?=
 =?us-ascii?Q?D9bamSynf+maySnKPR7EgGcLDOFzgmNC8kZ4bq/oZ6lyxYhdbi7+nQYbfxHW?=
 =?us-ascii?Q?SwT84zWLyaVS5MevlMHqX0pLfRMGhYo00QS/sg3bsC5S8KN6Sw7PngxodSAj?=
 =?us-ascii?Q?uWnYnlJPc07hMLuoREMj9Z548Aq+LEmLDCOK2ewH5IOaKUQVkHGQEaYmNQpZ?=
 =?us-ascii?Q?xzIrKm+lWtZfQzf66UPUJvIGeG4ocbydZmRyT1hMMkNVgOmldzs7Smp5w3nr?=
 =?us-ascii?Q?7X9DOaNjpkm9b/luNtxW9gHP3leq4qx0f9yJJSvQJ47e36bYT/8VXlfg6Lul?=
 =?us-ascii?Q?XhbEYJmg58aXDsJb0o/zZtPMqPV2pIg3hcyUqBhKb9H5dbjPMKn6ztz1EQ6l?=
 =?us-ascii?Q?UfvxWhrMO3v7hS+JC4NNUdxg8gKu4LDGJCKlXeBeRU39GH3uYoQt/4hlS5SL?=
 =?us-ascii?Q?38+7uKrdoR2w1mjDG/rKJH6I1MhWOrYRbKxpf7N4v42IYIn/Hs8nE6bP3S/j?=
 =?us-ascii?Q?8ftwLJEfkpLi+hZo65vOuoiH07kMjG3TUZLOGp/pkthN7HwEysYX4JCom6Pk?=
 =?us-ascii?Q?/1FDy/wZRDGUdH83OZLU+aSLa8Qcz3ZzwFh0pRc8gxO8b2yyOZ+cRSBfZ/S4?=
 =?us-ascii?Q?tetv6GXT7mu/jzCXTAFD3QYPiUSfKsJc0HJzYFNtQfbL14ghSi+AenT85gEi?=
 =?us-ascii?Q?J2c1hRdCGmr6R19X2nu9X9upuWilIjDMfNjlPk2H5d7f5M8MN4t8MtZbngZu?=
 =?us-ascii?Q?dMmx9vjDNCfKD0fzHeE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P30r+XlyEf7gSE1FPAcMkegh4u1Y4U88W5+o2R73l71ApMhpW+RpwEMXmLTL?=
 =?us-ascii?Q?Afu3fmavC/cxwptBRDdn1hdt2+3Gb+xHsviSNN3j/1ed8/A7tymaui8A4Wip?=
 =?us-ascii?Q?LkCGfMk2rd2fYHF9d2VtOSwOUyWekv+FhW6Ni8Xr7XcP7IHVhy3rXGUn+ONG?=
 =?us-ascii?Q?voxldACQsbtRjXelyZqNjFBR3UbSBhYcqsvz72QWJ+Vjpwg1U80QJql7aZAd?=
 =?us-ascii?Q?xRGLgNg6eaB5zIDh+/czkQka1d6miS1cOHE0081RByUt8wvtYjSv6RR35bjF?=
 =?us-ascii?Q?R34H3nABBUthd14cM/BKGXXkqaTFBDsmGqsSGuteEt3oiVNfzmnvkQfnXdmC?=
 =?us-ascii?Q?v4q3GveL1SYTqVMrbar7/1lmGWtDWHRqi9chx7OsYvy26aTjs6wu9+KqY3at?=
 =?us-ascii?Q?AMtupemKB9uVWQY3ym4RX7hICTNy2SwoC7l5FSh4iwfLRc1YODSBLvgpwLCU?=
 =?us-ascii?Q?Mx90jBdsLH0UanBDQkLTxIV94LEvNeb+pvYhDvI/Xb3DVKRpRcwfHA1U76R7?=
 =?us-ascii?Q?zfu7Z8Rgkx9Txu6hQ0wU6W8Tdy6sdV0vhAtrLu1FcHA5poLdKFVvpATad3a7?=
 =?us-ascii?Q?g4nrqf768/3r1gWQR1mXpUI1GDWNdc/ieAshBKmPXlLkPBJNDT2m5mp0To8z?=
 =?us-ascii?Q?VF4HPn80heugZWB6pvyFYCQ8H+NHhdhri9jx+WyQPAxBN4LjINBreJFIWz0c?=
 =?us-ascii?Q?M+3mu6VIxNb+zWqXLObD++eckflWIdlgwXOtzc0FYKMPjQgjbCxhWT9AXSwY?=
 =?us-ascii?Q?zrv7/kmdnnViUiskBWEIAGYQ/Eegplu18ISKRmskcuH2vIUTQtdFoi8P/aAI?=
 =?us-ascii?Q?i37FxxPSfVjlOzxdvEGaWvU8U//gMOPQJYjmeMc8dN0TWkcQdiQfJqNN+xiF?=
 =?us-ascii?Q?IQAjFtFvc3d59grHf7wW4ipQdvS5By6uZKJgaP5/4Ujg6XcaHYvizQBjx+0U?=
 =?us-ascii?Q?SAPyNyqI1fj56l33SPPdJuW/dWGABaMXHSw9SfBHCihk7O1aFKHOTAbs5E1G?=
 =?us-ascii?Q?kJwhdPlsvNoCDAk1olbAJNdMz1SO9RpLzYtUnswptBeItGU9WZBuP2sI/8yi?=
 =?us-ascii?Q?/lADVIa5v/+VHTTqiz4r6g+s/bvKNfjGSWx0Kt9FQpTHMcg4TxSxk6xzs9fz?=
 =?us-ascii?Q?BrlwH2tzr/jh1FkcurXYPkJ5Zbsby4EVPO8c+nHsMDOh3+8do4r7i3xoQbMc?=
 =?us-ascii?Q?GfnRTwp/WJsgP8musvprWIPKT5WnS5XlDVMn8OHDqGVUCyqfwqGEfCdYjUL/?=
 =?us-ascii?Q?Z7bUSn8uhSW8PTCwQ0ZwYm7vwWl5CH9Dcag969ZrjE5SV/61v4qVpq5oyDTI?=
 =?us-ascii?Q?E2pl/34wRVOIj8nToMUIfCesoJvvUZO4s3xf+JBATBdQwbJ9G06yVHfoqzC3?=
 =?us-ascii?Q?2RwOOmb8EtEzqggCB6OIm7MmnI3rFnpIt5p/ZKNzt/leq4KZlMvdQ83FtxX6?=
 =?us-ascii?Q?LvkN7yfj4lz+WUdtKiPW04cutQplp4uh+LHltd128PRhDGQ3mjF5Z8p8YLfV?=
 =?us-ascii?Q?/BOzy2rR3bBgPH96ghjvd7I6CRzCm7vpyhNDttr/PaxrPTvj+LYnftp5eLFI?=
 =?us-ascii?Q?ng2vifSejHvftPph6VCaiffNu5c09IUWXGJh7D0v5LnOfZsNM+9Bm2pnuQ4Q?=
 =?us-ascii?Q?mA69G2LKnfWlGRLE6qzSdygMi0AuOJNuWfdMIa0U9jvCf5JJJmVflmTZtDLD?=
 =?us-ascii?Q?G0M/F30Au3QY2gIltc0L4m/zpn2gQXMFXbLkT4qsRHtncEKcrnS1dase1FVQ?=
 =?us-ascii?Q?IQp2rkK6BCuzoKX9YL+YKI/TaHsZ/LY=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a4e3da-4353-44f5-b1f9-08de58dc5ffd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:01:06.0883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDwEDsrl2erw8E2BQf4/lBLwKhBm6zrNNFYd7ix1ZU1OYii2DHFlGWM56SP4s6p4a24x07faE6KypCJm6DgpVK0JuGUqnq9MLCliMw+et/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9939
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=6970b1f3 cx=c_pps
 a=SIO/v8SSfaR8RXaXrLdUYg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=rR-mJbdV92U0O_bazWEA:9
X-Proofpoint-GUID: NEtftp00KrxnGZtPpb6-VtW0E-TSc7Av
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5MiBTYWx0ZWRfX2BM4hwzRIxqw
 y2vIJjqDQR1xhsWufkJwouIFGFdXX8Ifu9IuuKngKFe78VcAf1OF0GF+gQnryzoyzhRaP8Pbl86
 SiwQSmmbEksyu2hq+0WkcAMZlWFFwf53+3rpgtuJUajnFvjDwtvLthh8Z+xnzQnDfJ+g6XkBCX6
 3cYh8+9W+Cizsasu0YiIjTvU3oWgRG7Q6yy8qxR2zdh173YHDzUDMJt1G3YdhJqTruvuSHMFmdH
 HrXDhESrwi5QLNTgMgHYGAZ5OvmA3zyuYCVtXWiGR1ORewtxBuzN8xtvJWy9h61hBAQ+9DX32aA
 vSz/hBxJariFWWRebuJtyTNZYFwcrvgmMcs2kdQe+SjLEMJM981Gki2gtbXcnKbKADgv9R9nIjD
 JGIY8C4w35f96knA0gHrm/Dqq9MEXG65dXMVccDkYeUIWyw3Wdux5fRZWniMIZ89qmk2XNgLP6w
 pv8XUMr8Hhi68pwFOkg==
X-Proofpoint-ORIG-GUID: NEtftp00KrxnGZtPpb6-VtW0E-TSc7Av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This should help avoid incorrect constant values being used in future. At
the same time we can remove the gap left for BIT(1) which was originally
intended for the VFIO_PROXY_NO_MMAP feature which was removed from later
versions of the vfio-user series.

Suggested-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/proxy.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index b09fd886f1..7b97460cc5 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -91,10 +91,10 @@ typedef struct VFIOUserProxy {
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
-#define VFIO_PROXY_CLIENT        0x1
-#define VFIO_PROXY_FORCE_QUEUED  0x4
-#define VFIO_PROXY_NO_POST       0x8
-#define VFIO_PROXY_USE_MULTI     0x10
+#define VFIO_PROXY_CLIENT        BIT(0)
+#define VFIO_PROXY_FORCE_QUEUED  BIT(1)
+#define VFIO_PROXY_NO_POST       BIT(2)
+#define VFIO_PROXY_USE_MULTI     BIT(3)
 
 /* coalescing high and low water marks for VFIOProxy num_outgoing */
 #define VFIO_USER_OUT_HIGH       1024
-- 
2.43.0


