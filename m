Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161DDC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nB3-0002XE-EE; Wed, 16 Sep 2026 06:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8i-00012s-Ox
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8g-00031Q-5m
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:19 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8eiYw769720; Wed, 16 Sep 2026 03:45:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YYDEHb0n4ZArJUHD5DiG9aC24YVKRRvasL5SP6kR9
 mY=; b=FPcZtlSoxuaRcpjIOgs0TtP0y00gkKRhOvQ1/1ufsnUSB/TvZFsUNquci
 A2iZ7qpwcC+NFFSnWiocotTXXBTGFuNnMCtcHTmjhvhYUiBBmsiiDWe4hDAWz9SF
 DEpb45BCxb0GUUh8NrsReZOn6Iodzz0rN86G+70/54qWNojvvmuxat1FP/c9W8hS
 lyyZ5nHDYOHRNyiZFliGiDxu7RKsxFhCYgpl72BEdAeDfwmB4O3rkjD0QwB27lg4
 rUxqcXqt7kln/rIEKAS9+XCvAlOTKIrQrFXucqigso32ucFm8FmwYEeN3I0VwN+z
 hzm6I2i+ztVZf86jJWuOJd0IK4OsA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022142.outbound.protection.outlook.com [40.107.209.142])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqatdt57e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O02g03XyahCaMLq2dW3ZvNDims63MSR9gkV5ZgbyhxIEdDazxFjffqCRRbLxwZKOHF+IOpJ9crrz4Y+8yTU620OSok04M5pIbX27FRYkxma5bgrsN1j81U2k5CMq/3vEHEKLBBmNyW0Aydnl40wtpHl54irNfFukMlYXuxYrPNvTjw/P+Yl593SvpBsOBPeXr+wuupdxDHinjHQ/pV8TXDy0EOoI67S8c18uXyjKGhaJhLyYyJW02/qxf+yY0G/3EoDAHKEuT+kfH9nOx5fkKrT8K2gZcYln3gZGNt76RpnnB9Q/KuokJAio1ki7lTA2biBZid86+k5Vka64LxjTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYDEHb0n4ZArJUHD5DiG9aC24YVKRRvasL5SP6kR9mY=;
 b=eefDZys6pr3HUbkI1LGQF2eTiuut8iAiVEb5e4whgdD0cApZ1AJRtjmM43FLvH6PItQ++fNcB4LsCpoyRzIXkX0nhpT6tiUhA2UEELlZPZrLCFEKd47gXS/PNyYkiF9qwdRihovN/70fG5ChtxlLGcmh3+rQAJrSTzSY5CKO61knXmU8NyX3KV9krOrmyabemfJObyLJEiugwc7eakctNPsBoLeR3OqjyqpeI1UQeLS9qpBp2/l4zd/kagB2rg4zeSA29fd2ubRG+sFPpftzejgGrGxUVR2dLuiR4Sqd2WijoMRHy+BYDHVr4TrEXMZtkNHA47vgzpUnqDTGvCSjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYDEHb0n4ZArJUHD5DiG9aC24YVKRRvasL5SP6kR9mY=;
 b=QkUunYrYv8rw/uM/p2z/z1xwQL6i6tSEAct0NKMFoLcaJwmusPZD/FWg+eRG1iMHxWVSb6nOEdxXJCx54FmkwoGXN096tVDS9FJsYRVV6mwXGurULXCf1JiExs4OEa40RjfynrVDizXQ8rMAn4uTMUTPmenyxwO+tsM4N1SpT2Crp+Of8jiHb+BHwhzsHf3/mfO/0IY1bj4UrPMKFYrE4BgcHNrLKE6kSPYPW0wR0A9Tu9DkByktzexmdLbGCuzHSMF0S59ChBLN8QRUa+tnDhyJIEaMaU8PwefK5vuRc8huN2i9htbaEq74Otd+/GVYy7oKucw2xjgGFavtUWtc+A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 09/22] kvm/i8259.c: use kvm_i8259 prefix for functions
Date: Wed, 16 Sep 2026 11:43:37 +0100
Message-ID: <20260916104435.600211-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: e53f911c-66cc-477b-ffb5-08df13df9485
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: uspjZd+TqpZfrDi+P88YVTHmXXBueMk92Zgkkm8Jun3CVOrez0PfNu6ARjlsej6zMd02GaQ/WnJJJvQegfgwr1Gj3Hs0F36h6maCe8O9nHtDlnQMjWWbhaVdBcgrEm6kVvd/M04IgcrP9ED9XyI+8GOYsGbqN7qV/afCqk5izDTePvJTNML6tqeewZdgcVu98y7xz7Skd8y1ZTiyUYPiQw5epnHInnrLuY1Bhf37fQ+10e910ODqX8ODWz0M6YQyJZd+LOwgoT8mArU/ZVL6saNU0B+FqeuTMDv0XwGcbQj6nI0ISIef5w57oiHeR/MMvkUDoSjTf+0Wkg9lvbeecO3OhOQdszxlhANH3wuHI9tbyh91CJhPO+4aheqYocRfWDl0rM9c3Qb8oX4HYJm2deV2n0edalvv8PwszMcNQz2QV3eNRVfc1sE4pP8y1olJ6atMrQagwLmJLuj+oaUTi3sCMZ1ceJePGUY8foYG7HGPmPtQNDxsJ2Zv9K5EOULVNDdNQGoWEcpDZkWi5UPXVTBTSRpBGIH2KhVzTkCc9PhJZpodoa9iPNDJGpJcP/uOCvlup8pVH0ubpK1r7/Elz4NeeevWymMyzCeWYdmiB6qyIM+HOx0E14OnCu7dTT4glJpG6gZBRxAjev/NNAM4UP5J7XTUbdqQWtQ3hkYTKyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrViESBIOGc2G1j+3aaeHXamvjOHeysESpFHO30/xdSux06npIwfeVLpZIOm?=
 =?us-ascii?Q?vRcE8/oilNU4EeObRSIea11e+P+V5L37dc9N5IJF54yE2+9PnNxsR+Yo7OR/?=
 =?us-ascii?Q?XA8IAkgst8hIwGPhbNFAvGED55iYz5Yyqj2Y6cFm3aM+m5EOxIJN4/+akZwX?=
 =?us-ascii?Q?lQp4DYGl2FD8Vc7930U34nd/i9vr7WmwfJt8gEqooA35D3K8WK72cKz2KD3G?=
 =?us-ascii?Q?d/24Bd98qKMpu040laErd9Kcy7zjOqJ7q5cWlBd10ZJIgC+xaUWewIAC74dt?=
 =?us-ascii?Q?Ct9HL5YeLCfnXPMIYjibkoEzo5cVVO5r14pB7qQkM445nCwznnAZi9sxkxZK?=
 =?us-ascii?Q?fMr/1byJbz44G5ljbxxJRVqDRH34PJQWLG4L7axYNwDHS2WgTW+jzjTcT2hS?=
 =?us-ascii?Q?BGLitEsxV9pbMoXxe7JejMLhYpBNwa00ktG3OogfX9EfPfj20g+v/1y0rIQE?=
 =?us-ascii?Q?ntPNyxwckkglTzZ4bJ6YntTL/KIslz3Ev27NSzc38aI2inP1C1RYYJe55n2H?=
 =?us-ascii?Q?cVblgfyOmsN+TtKhn28Q0PfP25T8qoVmBncnxhuxC8ucUfuLdxOSKB48nU8Y?=
 =?us-ascii?Q?0Akn+ljHgFIKs4M1BDmimT8fFSi9t7NtYoFNGOh1PTktXsL9Kut3PT70HFO+?=
 =?us-ascii?Q?ielSvmqGNswmdHpeYOGsXxpfWv22sAWQrjA22+s5Pe3U3j496oeVImWMkwOj?=
 =?us-ascii?Q?jseOIS7hK+IHhe8FFljmSeKDyw0OlKfGODyEAVtLKVIKnYU8kPYPNk/2v91p?=
 =?us-ascii?Q?HtZuykix0tiR2RiqesC9mlyddsAJGqfE6jozoaHLqpllOAXygecP0+eVPUxi?=
 =?us-ascii?Q?kei9eIC8gjuUfwkOEDONzNpKLmwhWD6C2ydWzUXj/fUw/Kx35F1KuU6zkRJJ?=
 =?us-ascii?Q?hcT8lOW64ipmhuDKu45UYahAqMl5xdl2fAApgKTIdPceOCQLeTlZ6q52JBdS?=
 =?us-ascii?Q?Tpl+dTXE1FE84/hSKvt82EWTXjMDU5oLa77ND/qtAjl96iXQawAGhddmIG6A?=
 =?us-ascii?Q?PVUxy6wWt74TUKiiZ2NXiuTdqIhrBC/q0kfdNKg+wUiXhxE6dKRV8m7e//81?=
 =?us-ascii?Q?Apa2dD+/EczGVbZ+KeCwHsr2tJCp5jXJZgQIIWrzL0H6UK+FNys5QbAruibz?=
 =?us-ascii?Q?KsSHQZtF6P4Grwh76U3MxdIm6ULl5axsNa71hPOrLDQksEqC55U+C0DQEvOw?=
 =?us-ascii?Q?qJ2Hz3TjJz4XdD10zjl4yr6yVFNr9j5CL5huCKJo8t1b+WszcUxLDwqVNoLF?=
 =?us-ascii?Q?Gir+34VF8n3ovACmSu0dLyIwzzg6lJicKDg/uFqPbHW+FEglt3tMiCK22FCK?=
 =?us-ascii?Q?RuXNx3Mb6zl5I7Epe5R5wQWIQklvBhh0CGUeRV3uB5gEV2IbRp+Hvq7eer7D?=
 =?us-ascii?Q?MoqqL3E1XmS2rZKjHA/TFYP4/f08SfTjGHfDNCt3S33d1iqUnwbBqZQQ3IX1?=
 =?us-ascii?Q?L4ll2mK+3tHjsoqHH3/JX0nfGKN3ma+VW/CdBtbPUaKm5yM99M+tS7+Xu1re?=
 =?us-ascii?Q?c1ti9GduiRKdh30RpEBnxzMdkYsh3lRrlpZVKKFcTtKCwzBNkX2BdKn+j5VE?=
 =?us-ascii?Q?x1ikWEvYeCmlPioOqvCaOzFIZ/buXZPMsr0WN6Jsh5FD7yOjugrs5yWzumgM?=
 =?us-ascii?Q?fDgUY/6HG2AZQ0gWLNRgysHmANP1CKUsSz2q2ZhmrjUZEuXF9DhMrXJXYO+x?=
 =?us-ascii?Q?AeyFztOdw+SUkduK81EwPtTaxnywfApmEkakF2qaES0SmaUWLbmIra4q9vgz?=
 =?us-ascii?Q?GukDXRxo6kzb2O6V172QROWoaCWcBm0=3D?=
X-Exchange-RoutingPolicyChecked: AHH32F8l9b+IL9t4X6TLHplogOJ6ijoggsP3OxrnBDE6W1ouVjao80PAMJMnwrbHID37RHDSMbPC0noaGRd3LuPnN+ojyZ7ofjDr8lWtoYHOou4Ww6/lzHkObiEP75PqVieBJo7Xd54LWBBgQIXbxaaJ4/ZRz2czVzxiddSeEdlFzw1mAApLQds8/e99izpXIDWao7Uc7vchfDztgbUtctXacRbT4Hah8R+m8SNvGZPvESuIl+SHMeenCD2bxsmseHh9gdg4ofITfH5iuRaynN/tjZVJFj+6dpp/PG5p33eEsGygrqhlGjHaUrnQoI61E8G2aipCHrkCTM7RvNWyYQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53f911c-66cc-477b-ffb5-08df13df9485
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:10.3027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWlReVDpbF8MdOEIdhtaAufd8OAF/sWE0lgm85XeirSXeh26v8VPcdLQh+ALT2T1+CLunOIfifrSocwrlnCRBxVMsk+0LF7dqoaJt8A4Ouk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-ORIG-GUID: -LgbwupfRSQeycAqC9PLXcpxPNnu8If0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX9aXO6XXv4Imv
 b4QNFMNJKrlWbzqzstjQY+t4MfxlPH45J8bv5JronZq1dS/17nbm0pBYlCb/sjTFFqRx4LzW9mp
 Nyj/bW5/3BukxZadbeujW/TDPk78BFo=
X-Authority-Analysis: v=2.4 cv=IbsSymqa c=1 sm=1 tr=0 ts=6aaa7337 cx=c_pps
 a=0JIDn+9SpPUHitkVorI07Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=TUTnhI6DmTZhWknvEmIA:9
X-Proofpoint-GUID: -LgbwupfRSQeycAqC9PLXcpxPNnu8If0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX9XNRIZAHGYDE
 KTFrRneWP5UdBzO8NG4kx5o2H3UTVZcOQfNPnisraPmj4QsexqyH1BBIegRQ7dFpEVwOeabVX1j
 /1WIvjW8UBoYXvzHqY/MR1FlRXkbCgWOeLiArNirl1jE3WrbnwRiKB9vJOLhzinktwuRlxtGp7z
 bMUagofS5uWQulwlug9yxUdxQw48IQvemA68ImasFWVGTqodZ1IWejyffTwDjWsWSsOo9BwfQU+
 FboHAdJ4V9kR7BrK81Hzr+8xz35vGoqz1ETy9NPVEW8S4Luks1clH163PSMxwX4aZo3d3iN836C
 USdQDOK4LDH0FE5AqJs9C0E6xvr0hKImV10T2DkaY25TtaZJziwQNfSBuTcUUjCp0dSdy3bEPYK
 jv+X8HKIYJ8Gxb9M9zxXHakGI/sHsIStljPlBnLqX06FBEW0JH+Gp+gpNC9xtjAR9dX0749/0pe
 8zagrjj2ksE9tuozy3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 6c79907aaa..28e6e40bd2 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -21,7 +21,7 @@
 
 #define TYPE_KVM_I8259 "kvm-i8259"
 
-static void kvm_pic_get(I8259CommonState *s)
+static void kvm_i8259_get(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -54,7 +54,7 @@ static void kvm_pic_get(I8259CommonState *s)
     s->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(I8259CommonState *s)
+static void kvm_i8259_put(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -88,14 +88,14 @@ static void kvm_pic_put(I8259CommonState *s)
     }
 }
 
-static void kvm_pic_reset(DeviceState *dev)
+static void kvm_i8259_reset(DeviceState *dev)
 {
     I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     i8259_common_reset(s);
 
-    kvm_pic_put(s);
+    kvm_i8259_put(s);
 }
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
@@ -107,7 +107,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
     kvm_report_irq_delivered(delivered);
 }
 
-static void kvm_pic_realize(DeviceState *dev, Error **errp)
+static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
     I8259CommonClass *k = I8259_COMMON_GET_CLASS(dev);
@@ -131,10 +131,10 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_legacy_reset(dc, kvm_pic_reset);
-    device_class_set_parent_realize(dc, kvm_pic_realize, &k->parent_realize);
-    k->pre_save   = kvm_pic_get;
-    k->post_load  = kvm_pic_put;
+    device_class_set_legacy_reset(dc, kvm_i8259_reset);
+    device_class_set_parent_realize(dc, kvm_i8259_realize, &k->parent_realize);
+    k->pre_save   = kvm_i8259_get;
+    k->post_load  = kvm_i8259_put;
 }
 
 static const TypeInfo kvm_i8259_info = {
@@ -143,9 +143,9 @@ static const TypeInfo kvm_i8259_info = {
     .class_init = kvm_i8259_class_init,
 };
 
-static void kvm_pic_register_types(void)
+static void kvm_i8259_register_types(void)
 {
     type_register_static(&kvm_i8259_info);
 }
 
-type_init(kvm_pic_register_types)
+type_init(kvm_i8259_register_types)
-- 
2.43.0


