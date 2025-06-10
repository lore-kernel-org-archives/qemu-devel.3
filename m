Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FB4C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 18:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP3Vs-0000p9-D9; Tue, 10 Jun 2025 14:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP3Vo-0000ky-1y
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 14:15:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP3Vj-00043v-9s
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 14:15:49 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AD2IuY023964;
 Tue, 10 Jun 2025 11:15:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/HA7KK45Jf+hO29QAnfaH2oyRKMkX39L8HkMbyFMf
 us=; b=h8Z1/kQYOmXYFFoiOVuq1kEUm8ZArkGZLTBDB/RjP2gNvgUvFXiyZ+Fu3
 E9bCs+J+8xq9s0qci2g5r6lPLiOqL/dWh3zJXUPjBRotS7Yz3W1Eolgur2VqgwYc
 NUFgErgIsS3nyxyCVmbccyl0KrnMRmlrDuLSUDFgAKv16AelX3sO7Y3qKWj4zJkB
 6mWcOMsByAfMJbDAqdT9lUPKDdfgLhJbpse20DvaiqLbHdPi37wdNxKt/iqx236c
 mA95S5BEU1oP74v9DNXrczBr903ZsNoSfqKIU+ncC6wzqOIUKtXSj6Jz86tktOe7
 4IORwrbx3Th98IGWY7/hSldzN+GIg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 474myyxfsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 11:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD775fnaItLIVYq+BfumaNoVSaiCPiLdsV5qeBELrpKwRMD8Yqc2qAEwbHRoOXGw4HpZ2tMO6Pneu9E7txH9VH9W466MTgUWhXFdFtXmK6A/mlWABvlwPf3BDWm7EPo4PtNwJGPKMg/VchimawophqXJ4wichfRzPvR6TgpdkcN1iVkVtL7y4NnG46MQMPGrhP47SIwDWo7ymt601w4C/QenVQv93EdhZ0leFyCG1H/r5iJOQTEzE96IVMPKu/a7jOxH6pqxjmBNudoCulKhG/tqSyvV9e5QoCoFQ8dgMlYmd7YQBrJzUSe/CZsykk6jYcsGC9eBse3VHrVg31qBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqhO0Bfx2q9/qP582FYES1H61D8TKmMcNNpKeRu3qek=;
 b=s/vxvGWolie815pFavZD+ZwKm/k11LHm7EGQ9Z0B+TtkRBs0c4aMsPZkUoCQs2BciTxiCus5XWomh57zsHVmiKTt5j8xmNSDo3ncl7MkOZX3Wt/f/Q6MeFTfWnyuSxqHuoJf+uEzeZLAudWSwk0pv1S9vB0Yy/Z5swXdi414d2biqB3q8Y419FkwSWShEpvV16E5SR+0sotEEX6faAW12ilNjdgRjd7VeyIA7dWnHRWyLlg8XPpce1iLO6LP0ptyvgFR86CDasGtWw2aK7T9RwcJUpLaLyB/i4FXv6iCgx2NXa6YKQSI2uV2l9ckKdqbqm3B1xd3YGi6xV5S4jGFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqhO0Bfx2q9/qP582FYES1H61D8TKmMcNNpKeRu3qek=;
 b=DcLoTf3w6y8KK8OVIDTWBwJiT2D8r8gjkrGWQVAjXz8JgE8/eMawn4HLYQIP4EwaffbgVmYUT6WXQQG/HuJTSdQwP7MJxOwgTbO8R32whJ9OS3GqQx+oBuXL73yJTkVaZbIxA/FqCdI9SEawY/McwHs+kosJ+EX76cV30mAM9p0mSll+XWCQCg3wfybpAY2qyizRJ750abo2vCPDiChO5UUAVmEOarJYJqxCrNQ8/AwFr4tf7WUXUUkU6Im86A8e24cyuwxlLOnJjAjhM2xYS+PSrXjk7dcn8LzjnbdcksXwdAo34sPlOh2yb6MFhImEnWV+IUxgqYD+pnsiEC+OQQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MW4PR02MB7444.namprd02.prod.outlook.com (2603:10b6:303:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 18:15:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 18:15:36 +0000
Date: Tue, 10 Jun 2025 11:15:32 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
Message-ID: <aEh2RGeqBpD70Fu9@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
 <44882230-0e48-4232-9549-9c24c09d3749@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44882230-0e48-4232-9549-9c24c09d3749@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM9P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::8) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MW4PR02MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: fafb44b8-168f-4399-44bb-08dda84acc14
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?PtMrdSK5elbal5s1TVPeXM5siuyii+j2X53vPiOKr23MWQm24E7R3OSYi5?=
 =?iso-8859-1?Q?o0tMjXlCeWcCrGTeK6c2QU1322Y7Nl9RsoZY0JqAWnenWnMUihAIx+/k0T?=
 =?iso-8859-1?Q?FJiPu4l2lzEmeUDWL8mclg538O6uHaITrjjY0euRr/Sqq2vU7KhWePBPP+?=
 =?iso-8859-1?Q?Sl2DOPIQth6I735WS2vqA7Nx83Hblbn35IYr5PeKX6FKp2t8J91XePeq6K?=
 =?iso-8859-1?Q?i72DaFxGw1BoW15sKngxJhQZv2BmBrSAFbbw/lVkzcD0EfVz/VJ3mAMj9b?=
 =?iso-8859-1?Q?LuGmz/K/ejBY0EkTnklMx26CimiHQfk4DQZWZN+rFvlEIq0akOqM9L2mc1?=
 =?iso-8859-1?Q?riWYZxV+B73XGV1SkuRAPJwDxoeZhnGGuvchPn6K+pcVmp9krRBYRjaVSS?=
 =?iso-8859-1?Q?8RhOmDL2SUvThy6UeCG+c93392Qv9csX+ZDE2g9L0WVKD82/xA6emNysIK?=
 =?iso-8859-1?Q?U435exiGhbOZPdHg6jpg0QXHL9ZXogGeFSfM/MY2x9qnY9ufOsQ6/4TaEA?=
 =?iso-8859-1?Q?HoI5qDjcqswzgtCrfbpVECTW6Hogtw3UckPWiIdjO+T1wRHFLdVXLcHYk+?=
 =?iso-8859-1?Q?2kuVPG/cQSYftQaEHXthPKoHk8wO9Kg8/Jp6HDze9mN3pd9gMam0+MJRqe?=
 =?iso-8859-1?Q?qhz+kttHYGnbnUN1DF+L+gRWYTEIpZz7tb6M4b4YyeFeZN2BfF0kL4Q13O?=
 =?iso-8859-1?Q?911yv9/X2xJ675z/wYkRMbVsxOp/0imXim+TvV4sAYk+8dqJI7zq9UJaA5?=
 =?iso-8859-1?Q?YOpDvSNlxxFTjytCB2vPM+UlWvwKXqZlk31ETtRccaIA0Hv4wtNb0WzYic?=
 =?iso-8859-1?Q?m05YTAGhkoDpZ3/786h2+gJbm7NmfUj37eO1z2nZJsEOb4ZwFz57KOumNo?=
 =?iso-8859-1?Q?IS10CrLxCxfg+4qm85vzYd9qdYNeJWNf6AA0Howqa04x8593j11py9pcsT?=
 =?iso-8859-1?Q?AxeQYtd6u8uzuAZ23LnLPDm/YXOyYU64yYxFkEdJo74OxZ4+2LPy1Tn1R/?=
 =?iso-8859-1?Q?v9MzSy0UMAogIDi6+AVdtQGxQC7agUZEFp0ei1idSuYAGGZwVQPvy5o2B7?=
 =?iso-8859-1?Q?VOIuFKI2zj6PXmj0n3DRgD+UmZGOpCtOsxk7bgigS/YwZ2wBnTpJ4ZI+xz?=
 =?iso-8859-1?Q?sl3bNzp7ng9/c3C/y4zHfBjaFVV0/ynHS6w8Gnbvb+tLeSYzbc1O7FvjIK?=
 =?iso-8859-1?Q?SSSilaySoagF6Bl0QGojeGgFNDoRwgTC/feyJ1ihsadPI6eDT8CZpLvBhf?=
 =?iso-8859-1?Q?7rbBIA92kNZtmDe0BF4j3V9+P9g7cel5eKatE6T1F4KmCRK/U93kO2cSw2?=
 =?iso-8859-1?Q?X+8HZw5MahA3goFOZ+9zCAY/aKe4SRaVwJqS08n3UY/0AZ+vDeFtJQl9ln?=
 =?iso-8859-1?Q?rD+tUVUcN97K9gJZQ7Lv4lph5W58ref3k9BjzpGyhnstXKa+qlrj+DbMSy?=
 =?iso-8859-1?Q?0XW61Mb14+PxW3MACd8UA64IYkpIN141wJU46kw3c4n5LCYg3Reg74qmZm?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WvdtJFLhsdfqhcNeUAZQjDtwRBcL3qFxU3BMR20DvzRbCpIDyo1lODdYsY?=
 =?iso-8859-1?Q?tfVvRZBLLXSU5N4u4O3eYrEBUyN5LendAV2FjvaPHeBB4PQaP3q432rG5a?=
 =?iso-8859-1?Q?Zl8MwgA9N6EjGabDQ/LGQ1Hh0PkhD/TB0jYgOu+ujj9jmpvQdv3GZkjMXz?=
 =?iso-8859-1?Q?WgYbjMRPY1CiwcOvhRbd0WI36vPT49Tj4emKdX2cSyjAXGFTxnzERaTjOD?=
 =?iso-8859-1?Q?BF7MLW9T5oLBkTwEQOnHbdO9TV5DuKFueJGT+fdLVIUiCY29icJIkvAwz5?=
 =?iso-8859-1?Q?ft4IrtxluB4R/T1V1L/D4kvJXTdTsGSNQqOqc09KVQ1si38L+t3m3+CHuh?=
 =?iso-8859-1?Q?trg45FyKt2rSyKHwCpzHakSZ/+S0uFFc20kyL+mxH+WEUVliBbs//KLTH1?=
 =?iso-8859-1?Q?ILiaftMEcbHTj50cwH9lMuAXyn8QTiY/zHJg+loPlj8exSrqz+20cwT6YR?=
 =?iso-8859-1?Q?IQuyfKbfLhwzAiR2KhiqVkXyhoCWC7Gx/+Xuj0u9+Sl4R3/IKhMLN4UOpd?=
 =?iso-8859-1?Q?wsxL12rrUxDC1qgomq7efxRn4EKVhFRqzKoihHuesZQ949M4AnOzeFUWOP?=
 =?iso-8859-1?Q?hOiKZJp0DEpi9MDx3bwkRct/bHFiVJcpgrjF/w/Z0mDmJvihRSu8GWCW1w?=
 =?iso-8859-1?Q?lFBdX/+TJ/5i9TRWEmnGyjJXo0U0leuQ5gKm6y2dyEEQsHVzntbl5GeJEa?=
 =?iso-8859-1?Q?cs+rMMNpp3C+CgTGSKsD25/y0BS0XyW+dwITHl0DppswFVcC9nmW7c4TKR?=
 =?iso-8859-1?Q?pRmqLyUm7ThOJd9O2c6QJw95KG+ELEOO7d0D9b/wa0dkI8O7QETcK1ECrp?=
 =?iso-8859-1?Q?2SaovctQkTQiM3db4GTQXt/a0W8USnNzDbZpkk1Pd4basuxvlKOt5vqBFS?=
 =?iso-8859-1?Q?1wpFKLx2ZGfAw3Z2EMN/L5I0PpQd3rpT2nIDYUPt+b2UKFafEAq36h4UbC?=
 =?iso-8859-1?Q?MCdshUdo4MWZbGf+zLH3fUusT2uTToayWa5ejUhD/ewpsEL9vuD6hyfoxQ?=
 =?iso-8859-1?Q?DC1FYvEQRJWbVdY3yWtvBDKkMYaq+8eYC7jHn2owbnwIcjzcXU+dxJ2TRS?=
 =?iso-8859-1?Q?sgBAuAlbassoyS6Vj39qrTSK/dzTPN/IWZ6+We+FwGf2KySI2AvYQPAq1f?=
 =?iso-8859-1?Q?JD/UK04N1DmokkvVOD/UvE2HcKQsns6cnX1Wil2PrbPrymERVNbhUtx1fO?=
 =?iso-8859-1?Q?YkGcyAonFBvZq07Dxk+97tn74p71MOj9ZdNtK9Y/guEMR7CeUEEBtum+U6?=
 =?iso-8859-1?Q?TdcToc2/5yM0MFMb/CVZ7vLhUxXGNtPb+q5HUg4KxuwnWiaFjZ2hHtwuT/?=
 =?iso-8859-1?Q?06kLnnwnzn5oXLjxfrKixunXBOfaMGjyKu7vUsmoZhzkY10fxLE1pXdvTi?=
 =?iso-8859-1?Q?qhju3N4ZFVG/QBaSyPaC/Nzc9PJxCBNB0vxWYmNPSR1HPne3+rTo9r45/4?=
 =?iso-8859-1?Q?fP3z7cFGBzD5dKgvvcfcYxZjYmGbF3dLzBFN1UAj3UjntcpTG3kAi0sm0j?=
 =?iso-8859-1?Q?i8LOWFin//fkdxPLBW2khqrR/jQgNsMcvXPAVMy9a/2lRVV7I8mBLQCjPd?=
 =?iso-8859-1?Q?FgS58thcwU2Sk6zGHdx0acVxtHwetzK5ToX1JQkANp5Y7U+39zqmlTg5mh?=
 =?iso-8859-1?Q?P0Cjm6IuiJKluCKOoJ39Uo2hI0f+djv//i?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafb44b8-168f-4399-44bb-08dda84acc14
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:15:36.3709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUdVpGygvQFtFbWF5cJ1GY1KRuCmVok2QOr6AJ3p5N+Z66PqzUfGB0Jir318rviRlV44ic32t0XhOrXABlBxiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7444
X-Proofpoint-ORIG-GUID: r3aXNXHO4dQz8mJcueL5X7I1MAtdB0jI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE0OCBTYWx0ZWRfX9cQv0xnlKaXv
 c3OJMWbl8+GMRg58dbVEcMRIkGjyssWVO7eWTwUJv5rBeuRMQ12AYGD/YOEGDwFfln31FkbzZut
 0qALpYtVh+m3FgJiVueOR+0tHTsVqVR4f2JRjr715Ujez0R6CEOJ07A4/vUGCyDg4o/jn0sEcsC
 QLRtwIdZknM6L6RMa14jy5WaDGxvj2Hu4G43Ua8wzprIZBrERtkVG5AF+SjdDcZG7WCeBLtIEC6
 wAvzXb9nRdm/60DCviAZYXWf87cqnuHBTLxMRDxjlfXbgVWdgX8EXuDsTUGnmt8KbTi9BmD5zP3
 m2Tg+3l1jW7hG5TeRV+KkPjuBsW+IIntyi4odAfgAcEmsit05q2bqHSO0L5R03bqhigVf8PikDs
 T/l7D9NrblJyBd8aaPneHNhm0HyqEjY9vvQACJuawlzxoFT8tJLIUERwzaPS413+Alj2XCSn
X-Proofpoint-GUID: r3aXNXHO4dQz8mJcueL5X7I1MAtdB0jI
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=6848764b cx=c_pps
 a=E7ulYwME8P4B8GMmjAm55g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=UF_GpJYHLsthOnA7oYEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 10, 2025 at 09:42:41AM +0200, Cédric Le Goater wrote:

> > @@ -478,9 +491,14 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
> >       for (i = 0; i < vbasedev->num_regions; i++) {
> >           g_free(vbasedev->reginfo[i]);
> > +        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
> > +            close(vbasedev->region_fds[i]);
> > +        }
> 
> Adding a small helper to retrieve the region fd from the cache,
> would hide some of the implementation details here and below in
> vfio_region_mmap()

I've added vfio_device_get_region_fd() - used by vfio_region_mmap(); now the
existence of ->region_fds is private to device.c, so I think that's better.

regards
john

