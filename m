Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76F3D12691
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjht-0004Ww-Fl; Wed, 03 Dec 2025 05:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhs-0004Uv-8r
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjho-0002yV-Vb
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37xXUW834742; Wed, 3 Dec 2025 02:03:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE
 /c=; b=1SjG4wEQ/RFupYrPiKya263qJJJPVEDH+l1IH+MGRQ/tfU0WlB/9igkeB
 wANO9FJZXM7enjIKWqueZ0/o22pd83Rj7eu1YPlRjHGU0FpmRULL+w8QaFZeXUTz
 q4HoGbW2bdE9pUOKef0oFdqTpd7prUCdmOyyQ2Trc3IRdBauW/9IeusLXeI54YJL
 GC7kYwX+shgha0bBT7XiaM0qUh/iX8e27bj9rUhtIU615nlTdKXCvhnpOAOBgnNt
 F5R8u6Lw7IirbBdZc9mLrlUeZ2rfswD9CZocvLMsS19a7dSvXnSrl2O19AFkVdNt
 rTnQlRfuMoQ/UP0REDtrLWFBtAatw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4at4909wwb-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 02:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6MZ0rMxkXx3Pk7I2cBrxsW6c4DiBIX9VM6aoeygTsfHQFpN7EZpb1TH2e5o6xx+D7ngE3KIlXKke8XNWHwCNMZ2x+NqQpq2OXqIKEy013JduI3TN2vSiASNYmqKJyOor6/VMNi5EnRZLNwe7Yg/LIxnUlyZraGTNwqGGNDX7Ndrhj8byMUS8M4pO00OH0R5aRaAhu9+LO293N3Sj3cwwYWOsXtympNk59gGGBzyEP0EMOzUH2ZJCL6p8ZTfUi+1OX4dYfdrgm6RpUqdARu+4QbkkY/9ABRAgPEFFX28s74fQFQJsPSmudJdHmyuhJiIJcrwp/S+45KxyfEY59+83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE/c=;
 b=H+qffcJhi5aMlFkFCIRBLkcdy3egpPp/L+1Z9MU/9x8Z6cN+86iEnBaD+9MiSg449XTq4zT6s729TRMalFqz+wUplwdhtdiXhBT/2uxf1GyuKAp9Sm0P4Mvu57ZknbDTz0sPTTtg59H0+xLO3l2myk8BCVfY5ycwFvU7X0Rk2DRyCNXmswo3Q8wdlOobOT1NNWCmA8xlBejwS3/fXYHQaqfrC8B/nvaKkkyOhiKZ0izbZFGhOtBoODtrPYBskRVH9eDuZge+yZ/5O4fCVYYPCX9+Kz8lQuXqdPieUnhy5k9AuaJpls9Zw/JtvdZY1YeqB4wKK0sbNYHr8K+RxzNXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE/c=;
 b=cBmepbVEuGC4dlg1+KCfANiJIGBVtsvBtcKcWhsXJPh1TNXiu+My7Y/bl/wumw40ul6R+VbIRBvsW56Y7KEwKDpFIQQKRhvfV7FIK+fOsgudMwjzBKcBKwdSqkcvc8PlOvkDJFaE2C6f1hIK8/8tTure5eyb3phey5b9Jlmhg3EyoW1WcZyiNQzB8tTv2NKdcuTnA6m51nAaq07377NfUukjmoVKs3C+vAK2S7mMSlry15N7QYGxza+pk56v9k4bImlzdE1DvbsveN3z6deTxMhzJscrw9f1SVL9tvgNnfVSVmHmF5cj1a6aIgu2DuBe4puXjrIdPtuLZNmPixvHDw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB8927.namprd02.prod.outlook.com (2603:10b6:8:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 10:03:21 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 10:03:21 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 2/5] vfio-user: clarify partial message handling
Date: Wed,  3 Dec 2025 15:33:12 +0530
Message-ID: <20251203100316.3604456-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203100316.3604456-1-john.levon@nutanix.com>
References: <20251203100316.3604456-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc049ed-8add-4d34-bed8-08de325330ca
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dAuompRWi83nBp8IhdO+SW3AeivTdRiofdx0k8zSaIXcZXZ+CGCejScgrAFH?=
 =?us-ascii?Q?V84TVQ2QlDV0o4DBkd22138P7UVZ/+BPPaaGSeMxF/jeLN3sL9tFBdz9MmQI?=
 =?us-ascii?Q?I0zeE8pB/wEdYHC+j4h7g4Du/FJoghtfEWFLCmbdhJCwH4moqplGuLPqazdh?=
 =?us-ascii?Q?s9WN//ZqPA0Y3ZzLIhos8RUbKrTI2ItE+sFI2SQU8kvf4zMVnFN+on5R8Fvr?=
 =?us-ascii?Q?8kEaQUbSYo+UIvYF9nh7JN22w63TBoxsxCm0FcLiRSRmXKGWpZZ1z41tlMTi?=
 =?us-ascii?Q?xKZxnIF/cBBxVUifAIp4T3AxOcmnFTQCN1+aDP+R4URQUGQ5/jcoYqQ6M9mn?=
 =?us-ascii?Q?nSZSNTTSf3ITw+eHeg0h0XSk1Ktei6jdusH56Ri4fsvvOFMxBEcKDEjUnC1k?=
 =?us-ascii?Q?cWxa1nWXqoc6lTRQbe2viDctVPO2W7BCFWzpMJED4oAkCdE9mtczEvUSquQf?=
 =?us-ascii?Q?fS4S9uwG+FDINS0EEa+mvP7DUwufveR7Y2mzSvHZjWawWs+5Eep8HRgTKtTV?=
 =?us-ascii?Q?nkJYAYi0vgglRHYyKOUDdnw6H06kMV5iXFFK88vscinitxrv5JpM/AykIGjB?=
 =?us-ascii?Q?AV08QJthGaPOUWkB2RidUN9PmilwSrUvzSVye2uqLf5hGeppFRyeoKSYErbl?=
 =?us-ascii?Q?YSUVob7bC+4PkzaSVexYSVnPuxigf5DCgst5CrXh1AlcP9LTRlt30ErMgvKE?=
 =?us-ascii?Q?9UKB5NW1LI41MqJ4vwzDNr17yvg4ZuUMZnA9PXf2FCAkFz1Ubd6s/x1OjIDS?=
 =?us-ascii?Q?Db+VUiPB1a2xcQSeDYofNrtav79y4pT0CHQLBrkTVtnHJSAUFQpw+9i4mpus?=
 =?us-ascii?Q?JBhVS22Zpkg4VeAXUQaVtnLgWgjnPrlKygDDlFaQ3UUuxwAi/3hbAWortaPu?=
 =?us-ascii?Q?037ya9iqmEJwBcSaXJ8s3jh4X+h/dlOD8JmnFz/98XqHDqFySSlCQzmAri7V?=
 =?us-ascii?Q?sRInTjro+lYL4jxaG2MQP39z6Bep1ZC52xmLD5hYTXJwCL+KvF7s5NsHtSna?=
 =?us-ascii?Q?vbwOiGczi0e9colCx3XOBJZQkFEn1G1M7XFy2N+xytUa1jfO7pVbbxwSFhDB?=
 =?us-ascii?Q?SZ7lbLsqyABQBT6jVUzEabUSJYhBenxMeFMNGtdSaVaU3K4rhh+7KzscKbkz?=
 =?us-ascii?Q?2/brsrUurC9B4x6anjsNK62SF097GpVLJ3KRft3MtYCUPUr4vBjPgYLDOz5G?=
 =?us-ascii?Q?QAFxxHRFzQy9l6jBNpOkQSbgGcT8TfRSBzQSF0SCj63lm5fUB+v0bHktnk4b?=
 =?us-ascii?Q?QMzd/AafwI186pV6W0cZia4faEzCuyTavOtGHNhpyeK2zv9KmUL3gmjLSUW4?=
 =?us-ascii?Q?X4m7w63kXpL4TjyiwwdFNnXZpzTbtdeLdvgAzkAjqUT6G060lQHauRzj3K8X?=
 =?us-ascii?Q?MwHI7MkZz2jQzSZUsZevw1PqE+VmeBVqFRp5jYFPNneFlMKYjD2PtMkqp2Kh?=
 =?us-ascii?Q?RpJRUPVsQkzhSLb+pllH/zwEIW3RTS4n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yNFVnNJ/gS+0bRVFDclTTQ0/L8j1enxFQ6MrrVFNOoFlKkX8SHnNY4Sr/Dk5?=
 =?us-ascii?Q?zWBxmIj+SPOErc+FMLPlUVjN1QmyW0FF/yuhOQK+sRydIK7m3xaTz0ZsV3Og?=
 =?us-ascii?Q?PX8LKnrAHCBn37Y0pOwZEOoOBIW/f9rpI4cEG8kl9+LoE6D20IYGWv6B2XTv?=
 =?us-ascii?Q?pT1MXSJ6ADyl0ilSv/COohna7MnHrPhBQHE271NkaPqtS0xHPzhZFQjJNYZT?=
 =?us-ascii?Q?t6ZIztft9zAJhDiFfdEMzSu7G2jWwaYK65If7ES3niL8aquGqUH7TyCuHAGo?=
 =?us-ascii?Q?e8qXwE3ZaEEnmUcllCzFQdrUT7+gtbDwY0PcxoanFRlBqE76/GAYKdkY1vjG?=
 =?us-ascii?Q?RmPe+E+kSw0PTmZx1LRCdrZ8kfLEjn3dbFylNYxoWx3hxHMvJ29JS8roh94H?=
 =?us-ascii?Q?WKNpQqQ05qewr7q5WxwNH4B8ibrR3ZQyVpDygJKJS5NjOnybi+Rwq/1p+PWe?=
 =?us-ascii?Q?OA2F9CpJ7slOrBDhP+CylTKcJAAFcXA3RlyEjQzwNjFskiHRv6m80c9sHwM9?=
 =?us-ascii?Q?hhiAIhnCYbql8o4psOMQR8UY4aTOfpVP5I6KfQslrThika7CQxk7nQtMhFCw?=
 =?us-ascii?Q?2+k+ygq8T/EZWriDq6oyNRIZHHINgi4SXWXfs6tHD9MMJUsGzNN25CtfAT+4?=
 =?us-ascii?Q?rIpwBtX/Isno2U+hKVpSr5e6u2XTZTP9izAEZfztzIAXakzLo//LIKRqx0Ji?=
 =?us-ascii?Q?bxE7i3tCpmWbL0ff+nYaHaV6dLKVp6Aboi9wmXsN47N0BS1nuiJcvNpwuLmu?=
 =?us-ascii?Q?7i/Q3nQ12sicuIuaKMfJJH6DeBzuikbt58NcQvaqee0mPkba/jHhj/GJn7/U?=
 =?us-ascii?Q?VhRabhAXHYTvVrRn/LxduuYe9ON8d9R/5nUfwcgBBDzvfLInJpejuAWJ6nIw?=
 =?us-ascii?Q?uU1Ul9uJAQLni3RGaoHo08utjkWi9RaNi93yLsM+FZmFltg2VOMcc3XVA4zR?=
 =?us-ascii?Q?PjNfk4wNLzkAd4jD7+sQYGNwizXfS7R5E4AlzIGJrQtq6UNbWVzFOBnkmbZo?=
 =?us-ascii?Q?t21ojHBNC7CgzXMz1QvtH/V6yltcya/y/9Zf2tUf8q7LdzQ/RU2R76qOnByx?=
 =?us-ascii?Q?hZ6/2uQsyAQ736y988G/IwPZ7Tb8TRPASvuk+3HGYEkhvBU++gSf+SSjWpiV?=
 =?us-ascii?Q?RH9qspbOFDIfUgArzykRskqvkvpGILE9U9Jed/VbKl3mGx0TA3PV6PXu6UBN?=
 =?us-ascii?Q?GSHdY1+uBDh0lNOsz9c4Wm0irjHeKYZOlYfJid32604JaYNqGUJfDvvGCbqs?=
 =?us-ascii?Q?CKzG4XdbQfmbH0/n/LuYHs/Y1Y58pSftcjh86NuKUk9pVuF7I63rAj1xziGR?=
 =?us-ascii?Q?Dr0hiuPzLlyX0uTfv9GqLh37fO87s77mGEFbIexQWMzIgPNRDWUlourfOxV1?=
 =?us-ascii?Q?St/oKC4fgZyy9rcdcMQUs4kBFvnRBpWhjP7uoDa/2h+d2Yqu0nJGQ95hZpY4?=
 =?us-ascii?Q?Jv+eGawevl9780oHd422T44Km+gwQynME/nkcqUjJLpyRmUKl5kk2AlFec/G?=
 =?us-ascii?Q?rtnO4YIb/Ces9I1cI9+XIKTMek7tTUnO8Zsq658gQlNISsYY6yybiu01P8Fj?=
 =?us-ascii?Q?uxDJPJHaT9kBV2efyg/o87yrBq3F+dS6E/TwPsGx?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc049ed-8add-4d34-bed8-08de325330ca
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:03:21.8054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHk45gV2vp/9swHxuk3OnA5PsiTz0/Z5HrWcFixp9885Rra8lwB3uOGM5NaTbak/xXAev2FQKW1DYLKLVNQQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8927
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA3OSBTYWx0ZWRfX8FpuF7LbOCc0
 YxZSCbA6BUTNpYIKrWVK/Twiwovvtvsi9FKWb+mNe9ps7a6PmXPyTnFzAHJgBJn06SqUZaXleQe
 TOvWUHx0WIYxuoNqHSxEGtWTQZFWMCkDCraH2qU81nXuffgbhMOxVwFiVFOWTclaPyXR2Ex7DZ8
 SBpuKOeP8e1CF3x4m6CI2D+TyiXIJWKxFYbQKcgX3jdwQynD8cBtE06SYIwq4fzmrsmR3LetyR8
 y3787AV+9lHNVVN4+s5rR6jgH6FCLCGHGOoydx00EAKBV9aAyxxztsUvKOt3VoZrtgVLtHphqPw
 03PWRtrx7UGpDdPthMXYDque+Ut9YQLWRG85L+Y3e0qpExRqtnBacJ+Xkx4oqs5dGS/QSaH34G9
 5ujaXIvwR112Ng1ZbCKe2TFggIYFNw==
X-Proofpoint-GUID: d76MLmhzveZ8hcRPQKypOP5QBPFeWdZF
X-Authority-Analysis: v=2.4 cv=Gu1PO01C c=1 sm=1 tr=0 ts=69300aeb cx=c_pps
 a=1sVWB/l5Kn3omZIicXSEwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=UsTzQZW-myzRIYlug1wA:9
X-Proofpoint-ORIG-GUID: d76MLmhzveZ8hcRPQKypOP5QBPFeWdZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Improve a comment for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 75845d7c89..82c76c6665 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -362,7 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     while (msgleft > 0) {
         ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
 
-        /* prepare to complete read on next iternation */
+        /*
+         * We'll complete this read on the next go around; keep track of the
+         * partial message until then.
+         */
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             proxy->part_recv = msg;
             proxy->recv_left = msgleft;
-- 
2.43.0


