Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A9FEA3C4A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmvw-0006K9-M0; Thu, 09 Apr 2026 06:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvh-00061d-TY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvg-0006Rw-DC
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:09 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6397tK4t2041684; Thu, 9 Apr 2026 03:48:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gQOXKIzzMxP1bXybqF8ZZWY5+IuNxA80ImuiDGXUU
 /Q=; b=doUVUSj5p+PorQEWRfu3nM0dGBSRu/p5CPqn0wI44R/w9tgGnbYD8645M
 14ItCBfD8mvITnciXzqizcNFP2l1PCnTekGufbcYHxDm3ivVL4cPUL65ABC9QG6o
 NPH/oaGIVYBLQ0RvsjJobH1UJRCPtFt7kZcZhP8+mMZFPD3yvLPOszKMJHw0GkiC
 dn7wDPmffOqxm1cFCn4/+Wdtyw3znjoAiTm1FUPk4SdX5wn6X4rhorrS4wqjhk8i
 7nmJkRgE6yBGzfgxzK6ZEcK8HyjBE2gzboOdHJxehgh895uCm383+K8yHInu3hd7
 WJthWo8k9vFVgYaSpXOVfo/k4xBYg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021126.outbound.protection.outlook.com [40.107.208.126])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms675rf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 03:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yetymJikEQCno/1U24r6Sjn3IyEzCWaG7X3ijs0gw4IqmP5sEIVaRt1QR+EH7x75zbxj94ZTTfUxGzNwENaX82fURJtdb8Rd+10kKoNu80/TqKb5I5R/JAyXZoWuh/rSrE672CagW1vLkkK1XVPuE7mZKgUIShmJV6E14mXdz6rhv2d4QjjTj/TgWIVjUXKNH6RduZAUPT9fXqkhzJN1xH+ISF9gRNvGh6QvxCX/Mq69Oo5VXILROnohYHhBqALu/jrQs3PF3BAtRePAlqqGMXuNkG3XpUlNw74WsSTCBkD6eUDpPz+5ZRprnD9jJ+Yc7SMinWTyP7L+8UD3TTeWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQOXKIzzMxP1bXybqF8ZZWY5+IuNxA80ImuiDGXUU/Q=;
 b=iTXg/hdEylLuIwmSB0zx+5LRtlovfioTS8OT0pGi7T0eF7ir1DCHOrlK7llHz/vXrDMeKnwwK70LCrA5rrEePTOy6hJ/JjhQSwz5dq77MoD3KcrYoe21bif9t3vPJlj2GzhXCt8Y4AHZpTFmx9TlLb99D5iqPYh68OUXxMF3oxITR4f/mkvDYmqW67XWQMgtR73LjIpVv4U0BtVSsoEZTOU/stXe5jctStzobJW+9uBkrBHLb6CmQkr32yW5AaVxkL25xM2GcpFgyJ7yjhf0+OT6VxWV8L9Bz6kBO6L4OcFTZddsP6GKLfBBLyOJT+EMDQzYToEVpXpTNgto+Ppi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQOXKIzzMxP1bXybqF8ZZWY5+IuNxA80ImuiDGXUU/Q=;
 b=dD3Yx4hKcQ+t6KxeFK+Kpt533UuggpUjISsOhLB2BwlXMZs+dzP78P2Zl2jABeooFc8HY6llgtnRtcKWvJ9QlsUS7ss/dob27/7ODwsdjWrZ5548bDhzqQjSxFFIsJEKGDofFQnVjrwXmJrdHNdP/8Xe12y6dzK+5PklgsqqSsMl6OcwmjXFrNQjsQecN/SujVDvMkWVqmFYdBaEAi9el+QYUT7HjrRaWsMnCoRrpC751/S9JdP+UJsegxbtQhGbqwlPYxfDqiP/cSrGdktAy+OXqLDPhMx9C/OtD+Xlr1gS9yQSvGzK93I8AKtcolrGsD19tmvZ3SNAvwdm32q5Dg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7597.namprd02.prod.outlook.com (2603:10b6:a03:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:48:03 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 10:48:03 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, Patrick Mooney <patrick@matx.com>
Subject: [PATCH 2/3] vfio-user: correct protocol for DMA reads/writes
Date: Thu,  9 Apr 2026 11:47:55 +0100
Message-ID: <20260409104756.465294-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409104756.465294-1-john.levon@nutanix.com>
References: <20260409104756.465294-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f4afb3-ba96-407f-5a74-08de9625799b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: zp5nAEp3F+M48LYK/9yYJhygnPTtZi9h7fPCvECPglgowJyHcs1wALmZtf8ZXmIPZ+o4Cz2CZubeFefDY9oZCLhXQVTaDt96R3miUvWuSvk57R8GosCHqfEIZFnbhWHeCIVJwScFhT8tYgO6MfahD8puIV5mWcNZplH1k7i2NrLg/FMwFqJj8tmjqRzNjY2MHinbp7fFfFTJ5iWyDhzoF5o09a/bDasJ1AQw10ELJ5tbR+GMlVsoI9loc5cB1bIBxwHx/hKYLSM1JHpZ6oUGeyQ69vaj7mVtl2MDJ8y5zRZzen47dmDdNofsVS/gJ/6yyCzNG6bi9N5D+IyjyD5EnpE+gy9WhcjTAdeGhZHFNZxQRhymopzW6FH15szde/l4QyJJMEdiOs1rf4qnrs79qZ46ZxLopAnAbJ9v2M0p1m21mjH95AYQJUifmoU4scJDqDBEXOPOBJymtE0oi5J3M4pBRMiGqtWI2f3X4cDIiUUMq0KtLP0FEOQW4VN1uX7xnKweY3Zgcq9ot1cmGB5naDL3Ona2GdEsfHqd8nUNz0/ysFW5XOTNvQc5encqYOY0f2nG9F6txOW1hH5rpXC0RNVpMmongvOYideRhTq05TbvZAwIxes8md+W+NJGUyv9DPIqadz0voGPaiAaExYGrPquHCKOC8Z6Odpo/53K+dmTQzUX/i8yEUnf3GHB9AHrNrilfkXR/9o/FDg5D4JdM5+5vUtq0Ywn0OHG6rr2I4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RNBiu0/Nf5LsOEHYN8Vfw8RTeIEQj+nd8vm8FyanHNUvLwU+WVC9AhlLf8QW?=
 =?us-ascii?Q?l2dIZeXIFaRagPKWCbzSjToUjShBpszwRqEE7jDXtT3klE2HIE9hwb5PE7oH?=
 =?us-ascii?Q?qhsF/m10sQ8VdVsX1qno+2t+pjzxXo78I0hJrS+1BbUWKB74tp5PDzvhF4tm?=
 =?us-ascii?Q?9mJD1V0TSUmA/nxcwpgj1bcH9chx6e0NGSPst12jw297IfmxpAABAiaTNcN6?=
 =?us-ascii?Q?bzCwbsp+HgaTiWe3wres6P2Sr5N+abyfjCDEztXx3M5l9enq9OXXFW0bPphG?=
 =?us-ascii?Q?r2ghGL/D0/aQvfd+Lry8u04ZRBywGdxGrqdZuNadevAV/QgZJ8A0Hsstx7PV?=
 =?us-ascii?Q?Qvbm87zYiFI8QZqILZqcCfITEzm1+OXI5FQ2V6LtahbBP6Sjmixt9+2ZmaZD?=
 =?us-ascii?Q?NC6IMp3DRuliD9vnyi6USCC4wkanh5Z9154NQqwAklD0sNmt9nFoDa5T3Yyq?=
 =?us-ascii?Q?iCteZlHh1FvJarRf5mJjdQxz1UoC2mVuvJMfP3vbh2hT5TKyLi3+L6Pfj5Bh?=
 =?us-ascii?Q?A0bZaSSd+12zDGG9KKfXZON+rYuSgDckn0Ny9nwVDcv3qkRT9BMqrPpFrO/0?=
 =?us-ascii?Q?zFAjDKpC4TcDwKzNA/5IWRdbnd/VSyfp3Pk/LSrpQxv3g8y2SqUGAQxA2gso?=
 =?us-ascii?Q?ZjT/209ch/j8z/XJ1VtR8lk+B0VmRKJsPRgldIrzefYJqcIIchhv+xTLy9x/?=
 =?us-ascii?Q?ZiU9fFo10GpCEKBJZkXsAw1f8pQXUzvyjZZVIsM8B+k37jj3tKrAyW/Ckmbo?=
 =?us-ascii?Q?ci8ZmT99deH8BEz4hmI5wcaSQ0wVDZ3Aj/Z+diA9+K1JaAdmWKJodAjs58hS?=
 =?us-ascii?Q?HRCUs6SxUQitPszVNmyw7PH1egRjPE8pBqwwMWTewKqA9cdknot2IhCt6qjG?=
 =?us-ascii?Q?4EfyNh7Yl76PdvdD4Kj3rSLelOQW5z+SfK/91S6KMhZipwjhjkacp2vNFs1A?=
 =?us-ascii?Q?liE0bHSxEixsS+yfZ6kYY1t83fBrj0gUXdWUQWB8Hjhj0I/Yvj7XpIIGfh1m?=
 =?us-ascii?Q?LTof6ed6o6r5/Dj70FYdzIfGVpW+3h/OWue396v8iWyoPUcBhcWCDszChecG?=
 =?us-ascii?Q?wjvQ+mmTs09BLfgM7wbJIplgWYy0wUJlUHVnWOALmK4bR01mg06mI2wpXijF?=
 =?us-ascii?Q?VgcNSuEpMflj0yXgldFG6Wf+FNNi2wu9e6mJn6glAB2EK7/Udi4+oB/yNRgU?=
 =?us-ascii?Q?JjCoq2qcIU2Asw9piaRL40/NMUzceT7W1GO4nKV6syA/HoepZVv+S6LkCo+c?=
 =?us-ascii?Q?4I7cdh0anoVjjpWq6+y/nAW1ezhobVz+GP02CGPj6wYGotolT/BtrOIOD/A8?=
 =?us-ascii?Q?pWRs7Nphc76Hx/fNZ7XTmIHqybj7ynJ3FK2TOA0VJY7gxvFDMAL4zVkSQ79c?=
 =?us-ascii?Q?5mwk0hku0AbJtcV1Y3d6C/V82OGk0jG7Y54Ht1qnImvb7xRA7WupaqhIA4F8?=
 =?us-ascii?Q?r8KwqLZphAacwbqzgyUFKuUkUrWq2FrmMFrDw0EX2/LBGGhQoc/DErM2HkFG?=
 =?us-ascii?Q?2RZITlEf7ninDOrGmubNE6KkX1tfycvygptuMsoWadkowoCutHyPudSPe1e7?=
 =?us-ascii?Q?/j70Z0EWoQrDnwKD6kMZORc9YdjBDOuFl3ss3dkVxdEnYfpbIGAbgWjlxPDo?=
 =?us-ascii?Q?dwB8TaaTIM0Jma+2mUG8t8yZaNBz+3JBVIrd9XGdpq/YjNZU7Bb70OBRQutH?=
 =?us-ascii?Q?bF4ZjIdwWsBK2J1ysdCwhftdnYar0EAfBFDT5i+AwcZ+NOhjSxL9xLtP3nx+?=
 =?us-ascii?Q?9rUd/qFO8g=3D=3D?=
X-Exchange-RoutingPolicyChecked: YDyOa51O0Ul8p07MctJ7qca115SE+GWaQK6I6F8nU/TTKR8D9haACNpq7OxVsNH5DSYA6rVWhLlgeyMAnKoKkSfrfKH3PIrKRyFvCTbN1KC7+wAS56U/hDEE9CtHGnCIWVmbyxaJWE0QINkq3qluM+RpZ/dHeaN7Rm+leBhz8MeMowP3ogFP2mJO/abDOPOOXziiFEzR/s5QyeCYpr06gbBl3S5cqj4SMigkBnUXhbxX/kX/yfch4l0uXuapVeT8ke23rgfbpfVe7rej5zKRDD88r1EUpljb7dXQUbJMGbv3UYn+dTv1QxqqyG870NQK2ElhH5OjHfU+faYwI7DE4w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f4afb3-ba96-407f-5a74-08de9625799b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:48:03.6525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fae4Vptsbyu5fW7AJ+hQjOakijqutlM00/tJaStwUzmrpGy295+GoIDwU9GsL38i+aIo+khmEhXJCWTuVUVfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7597
X-Authority-Analysis: v=2.4 cv=Su2gLvO0 c=1 sm=1 tr=0 ts=69d783e5 cx=c_pps
 a=cnhvvNhNoe9VuZBm3HgdeA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=puMWUmrUAAAA:8 a=64Cc0HZtAAAA:8 a=grO-18Nwhb_pULRB4IoA:9
 a=oJ1xzHRvupUJs7EIRaQM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NyBTYWx0ZWRfXyOR1TV68DHwm
 1s0EaMoOKB54sgG2px+1dflwUW5Egp8p+ajhhsMLO5c7ugEMEGVR1lUeEKBWfh71vAbST8LOacc
 AL8uOVCQXZkWyTTqzM+4ZmhoZMvVwtYF6Mxj/mRWhOdcC4mrgUmYiSA07+YSrKXaq+UGrGdTNXh
 QmRlvrNkToi9AyZb/JqZ1Xv22f6nqvDWkxC0b+dNfOI9FbNwqMNDYIOBbf8Cag3EdtRkBQj+Yvh
 uuEKqpdftVFjskJY+lENf57HNnKULl+siM2qTuFreynBKtFLil1zTcig9b3xRHwpiwQW/JuQ9Xk
 GLimmjWVavd6VRZnXcFJDGEUJhSt1bxrOD3ib8XwpnewhdBN0waiTwe8Tc3aNwrKmGrqRxzddYZ
 d2x6THkEt87w5WfqLU97E3BEUok3F97Bb0iiX/0Dlkm1IELKFVznCc+COCVYrDF6qWso/SmwUxm
 KO3YryoFzVWiGCp9gQQ==
X-Proofpoint-GUID: JfKlMxNORjJxJauG7h4S5SCAHe-U56Fk
X-Proofpoint-ORIG-GUID: JfKlMxNORjJxJauG7h4S5SCAHe-U56Fk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The "count" parameter in the DMA write reply should be 8 bytes in size.

Reported-by: Patrick Mooney <patrick@matx.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/interop/vfio-user.rst | 2 +-
 hw/vfio-user/protocol.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 303fc13d6e..d4766487ea 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -1463,7 +1463,7 @@ Reply
 +=========+========+==========+
 | address | 0      | 8        |
 +---------+--------+----------+
-| count   | 8      | 4        |
+| count   | 8      | 8        |
 +---------+--------+----------+
 
 * *address* is the client DMA memory address being accessed.
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 2a0c31e7c5..c478d1353f 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -210,7 +210,7 @@ typedef struct {
 typedef struct {
     VFIOUserHdr hdr;
     uint64_t offset;
-    uint32_t count;
+    uint64_t count;
     char data[];
 } VFIOUserDMARW;
 
-- 
2.43.0


