Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A824CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Te-0006Qn-4M; Tue, 23 Sep 2025 09:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TP-0006KZ-Ce; Tue, 23 Sep 2025 09:54:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TM-0003xH-Lz; Tue, 23 Sep 2025 09:54:27 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N8XTRd2001831; Tue, 23 Sep 2025 06:54:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=B4a79EzbxVq3HWxioq+IdLoz+z6ztjgda2Tqyb/NF
 +E=; b=L95QhJ71WfYaLSmQsjbDUCNQxdYYLg0Tf+2tLDN4aG6R5leiCOVUhOfhV
 FnGOcxLLCtATh83Se6+VXm/w9BcJeJlz8/Nbq+W/GQ1u9mlrS8MJOrtEEhVMPDI7
 mqeIQONEqPmuJ1QdKpUZQOvgAnD7BXsaS9ru7kdvgMeDkLsmjlcu74T7a4uXUK4A
 Y6IUZwkgfpjYz8y+e++rtH03O8OI4dFuOYtQ551fgWnYLdvvyRU2KmgAxpnS7GFW
 +tWF3OMy+PrsisVID63nJ+s3uxomru3+PTHqzfUAQZEtvMa4qzp7xJz5v11THwxA
 WSJjxkWbuM3+RCDdJkFtdWfH9+88A==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021088.outbound.protection.outlook.com [40.107.208.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 499rkrp5va-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROPNtuA1RKLYzXHMGdu75BNQgC0OavdLx73PkzF1d5D/UEnHSyBzn+Unp0/gvKoQ+6opTmujrokFnt4BE5n5WGYPW+cMteoSWVM/q5KR4H1edKw5MqVPvAJ2eKMbwAYBkG0fxNe5WlrXVTUb1ULIjW8RVgyYVHmrE21uthczNK82Fp1H46Z+M8ZiFKZYQHPYzToH5H5pdVBeNM60NJnTB7qTlUCGXQNTqZS8eN4E+/NBvKpWiypzUh57RddKHKRIp1OtWV2/aTzquyywH5M4k3QoyQEFZYCtfxuSgUu9dHWgxwF1LDTbJeOBOlXU9uyiI/1ImHnm5qM1ZaDfZiUbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4a79EzbxVq3HWxioq+IdLoz+z6ztjgda2Tqyb/NF+E=;
 b=DM87lpl+HTwDLe7mO9L+TpJmmOcpYqA0IOd8DTON4MkItKAE1LYvNBvlPhmY75zwOWTnLH+99AfOSEepqim2OKfLwUs6/gxlGzSo5/lQ78SOeqRy4dUfc3nnJJ3ajQVO8wygqkPXoHU3o03HK2ZFcpzbzQ8usSVdigBWvWhn9e3lWuN342ucutVjexzCTk6p4eduvDE6XCSMzOW20DjiXMUefUe4DRvwIk9UWhARWikGFd2j6WGFAAfiFh4Vzs2Gc4KhsTZv/uiloBLyPO9ai1JsmXFzr84jf05wvsjcAIzIUqmsu5uOB6GUhMxYIWMwDp9aHSLy84hKXXFygzH7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4a79EzbxVq3HWxioq+IdLoz+z6ztjgda2Tqyb/NF+E=;
 b=pT+W62XqocclFQzpaguq3NpGJ6CFnyAu/ygPOjMx6n+rMoWGMaWITmz/u8eAdTerZ4R8BPQXqZ5vOJmE1JC2zI7haY8tI9fPNWxdzsfwc0DsqZv2o09RFz/IDwE73cshoBrH8xOD7bbSVFrxTzFSc+//f5oKmJLeLY4CGcrE7xDjTxV7isC66WdXCmcjGlN5znKpGJJqtLqj0p4e9r3VXqVyz2eh/rIWq97h5XS9uh5KrlVKdvUUPHIbBZvYriVTCn11MH0ylCB+zHO4B2lAugMyUs70VYtdjFtvW6Np+IoidYzcqcoLarXaQZlYoRkYJXmoWT0ijUWd/hK4Blpatw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:12 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 04/27] include/hw/vfio/vfio-container-base.h: rename file to
 vfio-container.h
Date: Tue, 23 Sep 2025 14:53:10 +0100
Message-ID: <20250923135352.1157250-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0058.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::38) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: b58cc790-f6be-4e3b-a379-08ddfaa8ad2b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IPxRkd7B7+VCRvuyAx6AE3g9/GDCH9tceOukZ5RJXKg28AVLCwYTX+FDFB4t?=
 =?us-ascii?Q?KwKiXc8AWRsvsN3OEb5hjY1CN4H8YgG0KX1CowiOEEut2KcTH/2POyGEKbZG?=
 =?us-ascii?Q?HbuSw7U3aW4KOmQPhiDCj6GZ+sNzpPALZUkpiHs3zHINJGt5WYnsuzMi13Ui?=
 =?us-ascii?Q?7rZGKHAYalIdviPLk23VbkKQMoOJmu2gEXLnlJZPkwEa02C2t8iWtMdfEkOk?=
 =?us-ascii?Q?IU56dTl1YGehjH4o+T7lGMHcVBg26wuYVx7JUdB5Icn2ddDtdz7QQzg8gKpA?=
 =?us-ascii?Q?7v2+493OaApjaJuJMPJ1ZOLWLJs7eBsZELmpurduywZnkuAGyjUQvI4h8dQg?=
 =?us-ascii?Q?08nP9gKBE+sBEDiqPT1/zAP0PvQssCJL8smZYk0HUuMoXN+wzdv1x3EWTq59?=
 =?us-ascii?Q?Oh3n68TzzTnT588MMdGlo2nXGCqK8Kurje/ajwDTC2Qbr4ZYv6wt7iGXSWwv?=
 =?us-ascii?Q?KCJqzOr6BB2dBj4U+cbFpF27q3jY9f9N5JI7+G+VH8R0CvAPnyD28BK2jwy6?=
 =?us-ascii?Q?Bij3p4qa+7P/9I8enxTbMEoHfVi0fmasX5Max2HzrL+py6DijcqOaI/r44Sz?=
 =?us-ascii?Q?FNvg+2XcZx91sDOy03yhCepOT7k2nWcAH+TU4uPoE8V0Ci4TJ/sImXZEftgT?=
 =?us-ascii?Q?pqUIq8PRN+1lqVQ4R0R/j+CGJgcB+nZSYl4HxstRRa2Lw8zP1A4GQJ/aLG0A?=
 =?us-ascii?Q?6FxpZPFlEZB0YbuvIGRa/539/4nWdhvCSiuMGbbNvPNG1CA0dZB+bWwkB5G6?=
 =?us-ascii?Q?X8lew20vGonY2MBGRFekJACl6PJTYaZ+i4/UFi2AEtwHofDU3kdGRZ4OTx23?=
 =?us-ascii?Q?nJsGrCGoMotlTHTJShlqeKGVvqA07AWElhkzHlSHhGJO/sHrvUBvhnlMSwD4?=
 =?us-ascii?Q?H55suyJbJnDu+wTTEVwU4O1puGvMwsmN9uekjc3R8TE+VJ20Ucxwdndi8EWR?=
 =?us-ascii?Q?QCBWNQrK643p+5DhxEA6tc9idcpbWM+YXOfp6SwyhWj22jwI3P2R5115cwbm?=
 =?us-ascii?Q?0A6dIjsVtjbxyZoUsXMdpmxVAPiwbJ9dojZuKo8VQlg8Y8E1d16xm5WlZ7Bi?=
 =?us-ascii?Q?XA2JjD4H0g5TPyS/N+beu2VGmhI3+9OseBuwbSPUJsEaIww2JB3mh16lDJ3b?=
 =?us-ascii?Q?yuCFfi4tx+3SBCze/cWnpKt7L+ceNS55lPuJ1XXyau8MqQZf54kTfSOuutJy?=
 =?us-ascii?Q?Rl0c0AhKSv7rd7kf1yB0nvxoqL1WB81hEwOzkqZQjATlIbCquOzBtFI9sFwi?=
 =?us-ascii?Q?ZBs+9U+lgBOW5yHkWuPpvpoQWIbyPu0m3+9Xpr0VzBlaa1J9+SSmR3kPPop5?=
 =?us-ascii?Q?NRYX7Qnccge0umA0ByegfPR1XLzoKriZQ6C2a0aUAd1Ffkx0VPefRd1ttUEO?=
 =?us-ascii?Q?pTqsMeYs9jdDb+h2x+vtV/B1LKYxKld7ynWN0P8e97TPGEtINplZwy70iLNK?=
 =?us-ascii?Q?NDLJomLqxDV25unqn/HQiziZ0YTlyn3PwQHCvJekQXVAg2YTABUzHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xptbOf22tt3mPeeqgJiQJvg4GKXO80DSa6Ll2VBmwbkVLTddC0osrC6MpmuT?=
 =?us-ascii?Q?tSr6j+WWp5QmCi1QywSEGaR0/KBW5IrTVt4NvsPvUNkLjxKW6A8dvRpgV3zi?=
 =?us-ascii?Q?XbAeAB0vmcSB0mi3iIDgZwlSa5u3DpwKpqM9Q1YeorCBEPaosoSOVbVOWPke?=
 =?us-ascii?Q?Eno0b2Rzuexeg8v4WcUXaz67OeO6eKTpD/gpIIXPi4nNR+kSL8YUFkMFqAIk?=
 =?us-ascii?Q?RIBlEaWACIl9stKn9Fv//1sNk8OIMXr8C/HABzAchyZDU+7e44Cmj79WAooq?=
 =?us-ascii?Q?sLbOoh3z3hSmXaZ1gYiY6nQbEuvqJpOCGLxKfML/g7ieJtPMLZUAL5I8jHx3?=
 =?us-ascii?Q?99ZBnoE9i7bHsBhVWgodbOHPetA86BuZv+q2YHgURh1ra8twhP7EK+RD5x88?=
 =?us-ascii?Q?eZOExIbYPVP0B1cUTSENvFL5qSFi0fbX3iVVfIdANmlq9msAfZqcqrOQZH5k?=
 =?us-ascii?Q?4NRYVf7xt/6MSQN/azvpyevx0Cc0VIKqFj9DkXGnM8qMwRcyX9dfcdUfvr8n?=
 =?us-ascii?Q?zCYzmGU1dbtjQosCCKxsjodYro44Gk8Vp0P6rtwu5dFbqqRfh2Xu3ZyyKwJp?=
 =?us-ascii?Q?9QmSNfOOht5gziboA88yPcZlYh9KvLxMkVc5Zh0nqt3S7qZHM0MSlOV3lffY?=
 =?us-ascii?Q?fnzDR3TZhI75DIf+YDnNThA0Q44OjFwNGP8R9GMhBVe6WZBDc6eJHVYWIdOt?=
 =?us-ascii?Q?+KfVO6Qa3ipzWmnekryZWPs4/34bkpKH6nZm33FJtZ3ImfBv6yS78m9MtEfP?=
 =?us-ascii?Q?kdY+HtMLpNdP9wSwrK9NDzQ6nbHSGabyqFpqZba7aEO77fzygBtWFhx6Yi9G?=
 =?us-ascii?Q?QPwvhOzKxzdQBERO+z7jK4+kQaKEIQp/+59t97olgBf7fP42CfP4REg9zgBb?=
 =?us-ascii?Q?pnq9QiK9DuuOVofn6+nXG6FhE+Do19mOJdu/OVOFrmGulAC7Knjssh+ffWGs?=
 =?us-ascii?Q?qkTRqIYQmQSkhv5CWtgijXTsd5aK2etQcZwaUGXVwdSWkWX2+K6L3CgwNNb2?=
 =?us-ascii?Q?N4OsRjCJD7fV2uzI5JPd6nT1thlBV743eyzPoo8ZrkQP89kiaFtzUwTdM/Wg?=
 =?us-ascii?Q?OGXynvLZv3u1JFnxUUVcxzuNxJiNe2F6w0v/SEkPK/YaJDrhmqxdlK5hL14K?=
 =?us-ascii?Q?khBFBaMYucMvCMiZh08vzlFQbuHfQNRiRezkrizv28FIyrSTRDalzuRx3vVS?=
 =?us-ascii?Q?7LCT/XIWsztPnh5k1lKhMUkwm52DRBo5wZSaNqWv3SPKk+2D7VhO8iRBmlp1?=
 =?us-ascii?Q?RzM69lXdNxgkBueCoP3khj13/kT0SiZo7VsOP4Dw/DskBEahaHCXUmzbY50L?=
 =?us-ascii?Q?a1CgMShF8z3vtBm5Jn0eXcfzoZ6HzkXQPvqMhjgzjfeDII4aDV7jCMIjh7Pt?=
 =?us-ascii?Q?7Pi7v7eLMV4yh7WycCsRSbQY05kiCQbZT7GqAA2ZcxRcsVbwY6Ni/mZy6cCQ?=
 =?us-ascii?Q?vQU15WzsdyXy9sD3K4esJYuPtiCgApfRynllVag+bvo9Li6KtIxLeFE4QaK4?=
 =?us-ascii?Q?orMa0gljztDQC+P7CalZuVRC3bIUtO0nz6lQ9pjew9pfWN/bUWLbhFZ9KTyK?=
 =?us-ascii?Q?4s8tOG0L7AG/5XhWq21xmNLC9T9T13fgNE6Eh+C5l2L95PJuLF5SyypBElBv?=
 =?us-ascii?Q?9LdgUKPc/oH5qTiFyKPtS8/gDd+SpVR60L24G/puMSExt/4aUeTWcx+CNtrl?=
 =?us-ascii?Q?zrC+ww=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58cc790-f6be-4e3b-a379-08ddfaa8ad2b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:12.5335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9GQbOBV4Cg8CIfJkoZT7N8J3hhntJNrWdjpJp64BmYvO9FVQsO6ByPSxqFZiIu0htpJmJRx5FTFpL3RdP5jIxgST+0hX9zuSZh3+DYP/JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX2kl6bboRd8mV
 2E91gmOl+ovl0WW+H6REEnbAhk/H2+s7lmaewBBKtYkKyMWK68+LBPbeBoOseXoXDiPlUclHs1/
 NR07YOLRlIchmtY9Mkt6dJkSHtud6RRukOcRlLh/OIf/6ERMOJ58dMTLDok5XpiShg1BbSVcLQe
 hNLC2HqKi4qDnCu0bw1Tu3sbVB+Jw3AznnTAFEuIxuQUWQA9EriCVTxNOePkzpaDZKdzNnhvO/j
 sXJxIPgLWHduXMEJiV/7CjHoKKq4AFHkT0nro5lPGbpVntOJW4pcVPwjIlYT6HMLrrdrW34snD1
 7uF+kqKyzjWIMrlkz9ejfOyxrVhZRa5xhXU7vBBeuKNb4pLOgvGy6znE6m8aMA=
X-Proofpoint-ORIG-GUID: rhi7YSMm0odnHdT3FNGgmmEeWM_yvwmi
X-Proofpoint-GUID: rhi7YSMm0odnHdT3FNGgmmEeWM_yvwmi
X-Authority-Analysis: v=2.4 cv=eaM9f6EH c=1 sm=1 tr=0 ts=68d2a686 cx=c_pps
 a=bSkFQXo9YJPfdG4GsN7qoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=-KjGwgwoGPQumVjQa40A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

With the rename of VFIOContainerBase to VFIOContainer, the vfio-container-base.h
header file containing the struct definition is misleading. Rename it from
vfio-container-base.h to vfio-container.h accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/container.h                                    | 2 +-
 hw/vfio/container-base.c                                    | 2 +-
 hw/vfio/vfio-iommufd.h                                      | 2 +-
 include/hw/vfio/vfio-container-legacy.h                     | 2 +-
 include/hw/vfio/{vfio-container-base.h => vfio-container.h} | 0
 include/hw/vfio/vfio-device.h                               | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename include/hw/vfio/{vfio-container-base.h => vfio-container.h} (100%)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 241863ef97..a2b42e3169 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 98c5198e50..250b20f424 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -18,7 +18,7 @@
 #include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-device.h" /* vfio_device_reset_handler */
 #include "system/reset.h"
 #include "vfio-helpers.h"
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 6c049d9257..13f412aad7 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_VFIO_IOMMUFD_H
 #define HW_VFIO_VFIO_IOMMUFD_H
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 
 typedef struct VFIODevice VFIODevice;
 
diff --git a/include/hw/vfio/vfio-container-legacy.h b/include/hw/vfio/vfio-container-legacy.h
index a84dfb0dee..7fb5395425 100644
--- a/include/hw/vfio/vfio-container-legacy.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_CONTAINER_H
 #define HW_VFIO_CONTAINER_H
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 
 typedef struct VFIOLegacyContainer VFIOLegacyContainer;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container.h
similarity index 100%
rename from include/hw/vfio/vfio-container-base.h
rename to include/hw/vfio/vfio-container.h
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 67b9fcdd2c..ed19e2e1e5 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -27,7 +27,7 @@
 #include <linux/vfio.h>
 #endif
 #include "system/system.h"
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "system/host_iommu_device.h"
 #include "system/iommufd.h"
-- 
2.43.0


