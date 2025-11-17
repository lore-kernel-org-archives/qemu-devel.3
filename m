Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA95ACE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1bN-0005Q9-GP; Mon, 17 Nov 2025 10:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bL-0005Oq-Uq
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:11 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bH-0000ee-PF
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:11 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHBk4MQ2840968; Mon, 17 Nov 2025 07:57:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FOxmqaJ9QFRmowdY+6I/yY63ZXTlRikY67ho7qaTu
 S8=; b=FMKBFJsC8VTvybGs4dy7Ufhx/9uXFBwU4p/gKocV9DjNIzMEYUDg2N/Jq
 MaQDB4Qs5Dl3cCQIM7yN06lcpFmoCdhBcATVAY+BqPPfdFGOX5QBLxA6OnQE6FpR
 BabzZO/h50VLQ+6wILjK0okYHYYDnG8BfXsoi0MxBzwS4I6adTaChTX/kFmmV2qV
 9GyIYTFMfwwya5XB3VFg7kRUWw1pU4Zaw75K+i6on+7i5CR7DUmZ0/N18qEhwWMG
 iG2nNqo9ZuB+gisWf3aivfePvi63KUrO9wbGUss7pnx2nCco09gLM8BQbcS8LY0S
 la86Sh+udaBDIIDVesyvdxXA6mGTA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022108.outbound.protection.outlook.com
 [40.93.195.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ag34crg7u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:57:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzJ7M3D4NvA0BCFpFLL+urtxJDQVb1ULXru4HACoMhA0KooHXQrWjvTbMvWmZ+XJPRqS95o1QT4BZoz8lAAFmN5Gtxs4AD2h8PS6Dx3+9MEuJ2PeOYJyFk3SJCo5YkgiB3e35gQaEbEsSx5DGsHlZGp4yI4R+xT9dwYxP+vRWBEAXvelMWSKF9FboFDL/cFjNOEjOqx7XS34jBEKlJNr3B7CbDN0bM4+jLdqKGWZIx+im9k6ZQ9r8orG8m6nqksvjmKci+oXwboUj5HZ5uQkHiYVSwexBP39QvLo7pBfLwvXDkxD7TEemWvFNeO5ExW7SZhvgSgM99VbT4At6Z7ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOxmqaJ9QFRmowdY+6I/yY63ZXTlRikY67ho7qaTuS8=;
 b=dhPsPL3AZFX8mdH+Wi3CGhR1AQwSnAUXoX6bn/vapSdEwqKFrQUC7RBbjCZhJHd3riD3vp1Ge2PJZ6GlmMc75bUclKlBhbGZn0QqLG6JhilI9eZL6EQOvjnWM5aeEr++hznO8I56qr8CQo6LzYhONGOO2dpIPc1EiyxRjRINiNxnSsq2mn777CMhZbdjiEGKp/WtpWGVYAy3fYKA4kuR/hDSYkIMKL/FW/VO/Tiq1BmDUJ7AMB/B/k3STq7ijAGfmqrzu8IdTmu2SblV7qnJC4WALKQMGb7aZELFvXkxNW0l8ppf5rO95B0KTXp6lCYSyBnZ2BVwvdJkk8uOA/mi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOxmqaJ9QFRmowdY+6I/yY63ZXTlRikY67ho7qaTuS8=;
 b=yOLzIOGpUePhIP0zeg0lILdnB6QSuBchUYYtDzfJKgqbF5hx0ypc7Gvo/C1mhLMM9ysaVQV53v13fVXOS7K/wzL1pAAszhsZ0FXpxXndlR6+foM7eZ3hdPjxTPD9SNlpmPUk8pLkxsHGjxMUsY/SIicxdMesnERHOvftJQ9/sgrZLVznmfVRykEdq09b38G8vvqA1jxv7PRHqVYT8xeB4hq7ufRJw3IQ3gVQdT0LJKVbqf8mTEWc5JHvIXYK8KGZeFDkqgArI56Gw90guRzz6oSKfCezxPvfnpSXqL2yL+1a7LMMoZVWxQplWuF2/NKK4qgg7xk7IVVXwy6mWud9Xw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB10025.namprd02.prod.outlook.com (2603:10b6:510:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 15:57:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:57:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
Date: Mon, 17 Nov 2025 21:26:55 +0530
Message-ID: <20251117155656.2060336-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117155656.2060336-1-john.levon@nutanix.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e0a998-d010-4ca9-3e4f-08de25f1f40a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S+XsiDN0jlb9x9TTqzSPhgDn+u4DcMIAm4egbpSsUXEAgDhgXGFFe70nNYTM?=
 =?us-ascii?Q?TZ01DNOiLtLks8ReZs6bqFmEz0F0Tccy0mVezmr7yhKrlfe+A4Sz29YtX0Ws?=
 =?us-ascii?Q?6s4xkzLAScgwz+40Pjm92y+HonjnF4L7KKdho6g/YTltKTiCG8GYuYxvEAPd?=
 =?us-ascii?Q?U68iushjg6zFCjaJ154EIUsQnrJU6z1fBG+0Zb7qU2FZglYVQzpSo+vjihdO?=
 =?us-ascii?Q?oQvOc8PkZRvnRAHRQJWQSDNdUQqKINleim8w14UWqJD6DIGIag/FQQH9DnXZ?=
 =?us-ascii?Q?AieJteGu3VBUJpO8zRIZqs5Ou9XSGCQ/P1VHITmWoQ5nSihogBlyKqb2A5UM?=
 =?us-ascii?Q?3rpOamQ2Q5bd8eobfICQ/MOCisYQUEci3johCwh7JdF4rtwiPGdeVH3yIPdC?=
 =?us-ascii?Q?nxkV6sdTK/HFIAtvOyCDwRQSai26MRyeJbC7BA8ceCw7pNhtoIpP33fmyYiD?=
 =?us-ascii?Q?CeZmOiDKd+R7sCAEIqudGdLmsSF2koNZYJrbSeuO5eDi4b4tueam+CoqxRxy?=
 =?us-ascii?Q?KXdbKnsw5w6Vvp8lJzr7ho8sOv8lokqIJQDSJBR3Uiqm0ysUNOE1hVxyyXAU?=
 =?us-ascii?Q?k4sT0K7aJE4UarO1hZGixukCWfCOj8EIETkGCMRWnocne1uFTzNzo5wzGcIz?=
 =?us-ascii?Q?DtNOlkOpcQ0CcLOrGF8KkrOray3PaAqpCvELtzeBk6a1i0NgAYoKQSpODl++?=
 =?us-ascii?Q?8Ub5CmHETy96QSkM/ksIN6WUeD4TZt+9uEwxv8zCwbduq9BaFaJyUEvjBjz9?=
 =?us-ascii?Q?q89WVvAWC4S99rtxb56v7zmBJiTv7f5irUmiiGGmFHAibUYXFcw1be2lz8wl?=
 =?us-ascii?Q?Pw/5R7jGDZoeO3qUIWB9Ec9Zd1DDbSs+x7xrtXdIq1wI/2Y6hgUBiqmUkQ6S?=
 =?us-ascii?Q?JmGmzP0kQFbn25Ys2uFQkR/95AcST4Wok1UjuPOFt4I0al2eAnWndZy5MdS1?=
 =?us-ascii?Q?92VzqphaVN5DCCT37ZWWlFohNUPT8IUIX4q/Id13u079ZINSBda4JFqCmMux?=
 =?us-ascii?Q?rZk8qZx+n6IFmEmdnYbOsvCVPx718AafDUQD2lao4jq8GLK0TmOFMJW+C7yu?=
 =?us-ascii?Q?V3r+1scyc6MAZ1XVah/jAgWA0PUhVrq4R64tGrxXAE4zP+62IM/DvbWQVw68?=
 =?us-ascii?Q?bBGPAADv0dAY/WbXafU2O1BoQwzSqWl0RNDo030SiPC3DVhHMhmUMhClE/ef?=
 =?us-ascii?Q?+UB68UGo5Ubgh4zMjKKVOUua+QuNTZbLuXFwYGhl1Hq4RnL2tbbAI18zOP+2?=
 =?us-ascii?Q?sebmR74AjYZDoADV1gg0746vtPvYmoL5Z1rnQT0mE+RA9lLrOOOR5H1jpHmm?=
 =?us-ascii?Q?j/aexnzsQxOc9bUC4RVlD9GXlb1N919YdHyN3P0VO8KueORkvz6vQ9NKrsXS?=
 =?us-ascii?Q?Zu3zdIT68zreIuJ6PfM8UVBep7J+uzQYF+X6HQZ4zLeJIiRZpHvKEynhjCsg?=
 =?us-ascii?Q?w5xgiYqU23smz5jj1ipc7rxvJIkyxfJE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T5e97ba2npDOpCZoAbbMqSX5COff0QG62x+XOGo+PwtZXP2jF9WGXIo/4ZRw?=
 =?us-ascii?Q?JyrogJSML5YoVAls0D/t566YEtKMLHdTZS6FMiRKuBNYu65iqEJD+E4YjvyR?=
 =?us-ascii?Q?TK0lSEfMf0I4iA3cPF6IMt8oeO5cGHDqVLiGJqfOIsanUGnO9919vsv1yeR2?=
 =?us-ascii?Q?tL5zDXEB4CDXl9U5ca1KJ6IVAOwN9g+IlOJG6E/8MvAXAWU2YjuA9N/B1fIt?=
 =?us-ascii?Q?yQkP6oxN2fABAv/UvzyFxBpbQpknul4N/h1fTjloeIopAagDLhWVsBSjl/gy?=
 =?us-ascii?Q?BIfYxcaKFd8+35w+MK8Ut+6mpNIE66iZBBsSjvvJqWOARrAGyg2DQWAA+z+y?=
 =?us-ascii?Q?VfAVFTi5/U+D9XvpzaPV0sIuTcJeeeC1L9J30M+yOLXfz31h0+oZau5UBIv1?=
 =?us-ascii?Q?sQs7Kta6mA0ybHRdI8caMe3XDU2uKtdV7HYqo8kVWhnvD9jvD2HYwqgaY85/?=
 =?us-ascii?Q?Ci+tYQruY8391Sizb5e0wLjPW40hKqACc28j1bRZSHRmQTQBZgF1SEjOqpUS?=
 =?us-ascii?Q?udp4FdD1W4nimKXZQ2zCAyIhOzE39OyQfOQt+ATqaV2ziZdixuocysaYAvS+?=
 =?us-ascii?Q?lPllBIx/HGpmoAoQa7UN00Za9UeDi1m+umUtOGtCfAvVFdAz/0Mv2956lGfc?=
 =?us-ascii?Q?I0fstCh5nxNvz3CEzTsccOTBHhVCaOJEMipnlKjzFsOPLRl65QoNZkY4iNnP?=
 =?us-ascii?Q?o+hNE/jFKdEf2HDgrdaDp2GgwplVbuu7oCGnBUkuaeKP4p/Gq3I5EyJjq1qU?=
 =?us-ascii?Q?ZtJ0RVY9yDMX6zgSEfpoa9f3eDCBrVNPCArdjPFCLDP/5PwIpQx+Utik+2Tv?=
 =?us-ascii?Q?8bJYhPLiqMBrPHxZYm3cr5OtP0zbKPTDRii2lRHItk3fO+Db+CJ+4OgV5GoV?=
 =?us-ascii?Q?dv3ekvX4ttGVDxiNbHJLT7m7IUzEvNlv/AL5xHi9SN4YWQzAl9wk2sQXuSoZ?=
 =?us-ascii?Q?Vez1fjTWoh3ogYKNg1iHHgLO29A1mBp9aza8sbD9vQKhpcJur7aP7H0MYJVn?=
 =?us-ascii?Q?jf+h4EloHtYYPgjI2q0X1FlZp50Ch1OwimejvuDCyxqx1LwoTuYp/3s5A2ZQ?=
 =?us-ascii?Q?mE7QSf2rDNgXHraRVfroP/o2k+pt9+2j3qsokleu5gMsuAqfmem938KjW578?=
 =?us-ascii?Q?+XdmCrzXC+9zmVH6VlNAKOvCtFAljEX9lFbm6x2QQ+XZH8Yb24VmBwCk3bz/?=
 =?us-ascii?Q?Cyl57Z7i79Sdq05Hp7oy8fz6IjzOFoR0F54G/q28mfHmqOHulczsEt2IRBkC?=
 =?us-ascii?Q?HqYvgc6Cd1q0KF/2b5Ne8Y81HmiodCpHPmcuCnVvoBZxr9JnKh7gmNxzkZka?=
 =?us-ascii?Q?OW28nlxYBQVFqcVfdOyZYEoq6aO3u7168s3kzKCyzefAx65TrQDkTJ4QxU4V?=
 =?us-ascii?Q?AhCZhAlNtPSLHMFsHGKzTEzWaKnSHDdd/7MJZUxWA9NMQTLLbXrL0nptPDHi?=
 =?us-ascii?Q?pLwg8bOLWg3PC2THtbIOJIlgd0qrCN/qYVJtNGlAprhXP+NcYK8T0ZmH4wrN?=
 =?us-ascii?Q?dQUyRbWjAKeurmAmjUrasiJPzTbXhoTKpCshn1SNZEXbkcGr3Zu/wQ8wRKXg?=
 =?us-ascii?Q?ucBBbBLPMggp2n39fe2UvVKNMHCxnffeYRVkwbN9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e0a998-d010-4ca9-3e4f-08de25f1f40a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:57:04.6236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdE6Kb4+de6f/f0XQUlLL/CfC3TO7rz5NjaPHKXgdjlmHMUJddbr2HYB6nd+IihsM65qz760iAekTXqNg/TEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025
X-Proofpoint-ORIG-GUID: KA935uCckvqXUxYjrCcrPGlBccD2jymQ
X-Proofpoint-GUID: KA935uCckvqXUxYjrCcrPGlBccD2jymQ
X-Authority-Analysis: v=2.4 cv=Jp38bc4C c=1 sm=1 tr=0 ts=691b45d2 cx=c_pps
 a=F8yC87VG0lzwhDI2wa7IUg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=jnA1zMGvAcXXG4Qj4jYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEzNSBTYWx0ZWRfX/7DGDMAl61MR
 vc8pJ5hWf1KYI5euqF/LWPcuFYZ6eFaTOD04qdL6BJY6gRxhZQV5lI5tNqca/hGDj56JkfcPoAV
 ZwXArHRseVkbmDs9chhfkiBfempHwpvUV1agsQIwZ2TdasO7azNpeeMTh+96hTJXI4xAAs+URTp
 N5vX0PJ2bWPwNv8v9g7Ys1hRBHxO5xFuqj30cfwiUJYM4TTUsxpPJeEKpPX5Dk2cYr6czRthy3b
 YDIQZaxQx+DI1eRFDZIFr9Lh7GlT/HCCgJ2KSF/+XV72u/nePbEVdtjaP5cyNJMhBjf7FpBOu0Q
 W5JYev4MMmf8wjSfzk4SW91dcWMuZGGXk1Y//VrCWQWu3BmqP8uLMlU1+jjc6LLzE+o/sFLuR30
 pcgNlqdzLO1aDbToAtybwdpQjl9IHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This function was unnecessarily difficult to understand due to the
separate handling of request and reply messages. Use common code for
both where we can.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 68 +++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 87e50501af..aa5b971fb6 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -281,15 +281,14 @@ static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
  */
 static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
 {
-    VFIOUserMsg *msg = NULL;
     g_autofree int *fdp = NULL;
-    VFIOUserFDs *reqfds;
-    VFIOUserHdr hdr;
+    VFIOUserMsg *msg = NULL;
     bool isreply = false;
-    int i, ret;
-    size_t msgleft, numfds = 0;
+    size_t msgleft = 0;
+    size_t numfds = 0;
     char *data = NULL;
-    char *buf = NULL;
+    VFIOUserHdr hdr;
+    int i, ret;
 
     /*
      * Complete any partial reads
@@ -317,8 +316,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     }
 
     /*
-     * For replies, find the matching pending request.
-     * For requests, reap incoming FDs.
+     * Find the matching request if this is a reply, or initialize a new
+     * server->client request.
      */
     if (isreply) {
         QTAILQ_FOREACH(msg, &proxy->pending, next) {
@@ -332,51 +331,44 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         }
         QTAILQ_REMOVE(&proxy->pending, msg, next);
 
-        /*
-         * Process any received FDs
-         */
-        if (numfds != 0) {
-            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
-                error_setg(errp, "unexpected FDs");
-                goto err;
-            }
-            msg->fds->recv_fds = numfds;
-            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
-        }
-    } else {
-        if (numfds != 0) {
-            reqfds = vfio_user_getfds(numfds);
-            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
-        } else {
-            reqfds = NULL;
-        }
-    }
-
-    /*
-     * Put the whole message into a single buffer.
-     */
-    if (isreply) {
         if (hdr.size > msg->rsize) {
             error_setg(errp, "reply larger than recv buffer");
             goto err;
         }
-        *msg->hdr = hdr;
-        data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        void *buf;
+
         if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
             error_setg(errp, "vfio_user_recv request larger than max");
             goto err;
         }
+
         buf = g_malloc0(hdr.size);
-        memcpy(buf, &hdr, sizeof(hdr));
-        data = buf + sizeof(hdr);
-        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg = vfio_user_getmsg(proxy, buf, NULL);
         msg->type = VFIO_MSG_REQ;
     }
 
+    *msg->hdr = hdr;
+    data = (char *)msg->hdr + sizeof(hdr);
+
+    if (numfds != 0) {
+        if (msg->type == VFIO_MSG_REQ) {
+            msg->fds = vfio_user_getfds(numfds);
+        } else {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(errp, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+        }
+
+        memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+    }
+
     /*
-     * Read rest of message.
+     * Read rest of message into the data buffer.
      */
+
     msgleft = hdr.size - sizeof(hdr);
     while (msgleft > 0) {
         ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
-- 
2.43.0


