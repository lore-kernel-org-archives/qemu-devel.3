Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F4EF94CBE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFZcD-0008TG-47; Wed, 22 Apr 2026 11:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wFZc5-0008SG-E9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:35:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wFZbz-0007UG-PE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:35:40 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M7Xn7T619507; Wed, 22 Apr 2026 08:35:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=lazX4n9CTW3q78d
 mTeeuTKFCX+EuUsjkZvsJGwIIdH4=; b=H2ahUEgA7yE/v2hRphMGW8xNw84yNjf
 bto6jHHlh2/StPTxgChO2TXeECgEsi3KpYNnhZipP8SRQQbYuWXuvMLfQe7wkxOV
 UMOvQjeXm1/dtcUGRvse4WBekfpOfalShJ2g5miHiJ0XtZoO4UpN8BR4zDCZIyq2
 mZ7RuPYhH8XnDUOsD0U5Be+gPgA/hh+8gKRdoQDGIiE/hVW9Khi8zmirF29YQDUg
 26FZAS5yatQDdXJbk1mhL3q7PP0K09XVX1tdDyUvUY7JKdgyssEtk5RNwgop0tfN
 mwo+8rDzBg1lxyeJYr0ELzpJx/bc8kX2JyifV2bpdf28BIs4CwcFi9g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023123.outbound.protection.outlook.com
 [40.107.201.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dpep8jcgt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 08:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBTiRqOeV/ZNEtwiqv3jC+MI6z4+tChiY64Bt7wzdyOeaJ0KkmcUvsMqn5A7VlR68l6NSQJOZLmWXmISwylbg+ohGWUBboVtOullUpPowSDvcGXsjtWuh2tTb7IugiDiDDcSaF266VHWp4lJtY2uvz3mX3BHnnyUgA7LfynVs2OFC1XFFZiVkVvy7lM8L4fHCBkoYLRwiazDFB48OUnGAuwPh83/vE/y4qPL/ax3cpf683f1pV/xofso/7lwqnDIwwyog70jRSGLFWvC9GdjidTr1yeThfawUzdA5F6ooTWBSLjqhWaseWBejhGiQJlp6IkITjaCKgpgld+1t1hWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lazX4n9CTW3q78dmTeeuTKFCX+EuUsjkZvsJGwIIdH4=;
 b=L/CU8Ca4yYm0i/ULoUq0mjpPEAnLvdLcYA/GyC7HjdI6KEU5teH6dccO0AyjwLONK2OrQss+gmT4v3nFdqsf4mosonybObeA5uSc2ZRGSQ3GmsCAQRJKsHOOZHw81MIE1W3lsiPyGPO2wb7bgISC6S7mfGZRZ7uGQ9ta1ITGPIbOI0SCVrAqbq5/Yjb2QvE0PAVCDBsPY3svPassT+871xfEjUXEAp5WD+KS4CfBg5Bfdk/rF8ODpBpHujd1xfAXDOxK3dQO8OMKD4Ky0nVjSzWTqBkbKCDxqlB8u7qxokT+9uRnGgYyoraQHfPhw0w+zph7ZFvc+8OpkTdAdPCbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lazX4n9CTW3q78dmTeeuTKFCX+EuUsjkZvsJGwIIdH4=;
 b=jzXcRSxcCzqPADo05jMVcRgr/S3jNpoalhdtnjFhmS4NpqJQnEEZeJ/0+3scNZCWNbtAWRGH6fILiWxEV+hn4c9ehYLWrst2uIJalrojXV9cakxg1sJ/8iSU9cWzczxaJH530QuUKv9n0bOocS+CWal2drFj1virZP3pRrcfwX9ktfbHUhIqwHjdHombPDGzBOHflgG8z1K0YUxVdVXIpgDxEq2J8DVdEKi/1Lxb9Y56UBa8RfgD9jsu7PVe3JQX3JIeDwi9Zd3eyUoMc97Drs2MxxTDhXa2HsMuUu81N6LufwEvIuc+xUx35z3Gw7blBxy5l1rTRDH9VPYWu2xLig==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by LV4PR02MB11027.namprd02.prod.outlook.com (2603:10b6:408:2da::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 15:35:29 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 15:35:29 +0000
Date: Wed, 22 Apr 2026 16:35:24 +0100
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH] hw/remote: update libvfio-user subproject
Message-ID: <aejqvPKCiCe8Cwax@lent>
References: <20260422140244.2147400-1-john.levon@nutanix.com>
 <21abf43c-1efb-41fe-8bb7-66b83fe15fae@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21abf43c-1efb-41fe-8bb7-66b83fe15fae@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0193.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::18) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|LV4PR02MB11027:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a599df0-feff-4ec0-1263-08dea084c836
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: t0pqS3yugAnJliyC3TKlVGuVRnOb9ubrAdYvHniP9xbLGAV+LTdMzCuRPLhoYwjFNJ1ku+Tz3iuezYtX/qwtMlv1Poe8aoiffXJQso4ZQHZO1dpXq+dbqzPwpqfjMN7xQNEsbue9IRjzMsFFekAOqoNCiL42Pa74NRyrqWyA6b13KtrJ9/5IQRLY5pb6eawczSvP5Ednbr3Ywh6z/pSUwSs4qDP0pKWEBuK5u3X3YQwrt5nxHsaKbStGpNVpyUl33O9vml1WGB7r90duboMAc+/IzGx09qyEo6OyKs7t3xX23bnqqmrQJUMIRMe0CoJ/sVTcIxK5TOuXvswSAZ1U9Xftet7LRBVIRJIhbcClTJ2kQT52kTamQMZS83OAz5u+9ZGmt21tWPGHYswDkTZ1i9QtxKJb7WfKVBXwahiKekAsAXuqMUOlyruF6GOAA8G2iI7cbHatKI6r7FTjuTkSVxCximNd8wbcfTesfYphBzzk5s1isYDy93Cq8niE24JEWBLS2AJuEbCT+XI8aHzbl+qB9r0YqbDU4FrZTX5KPZIupBi7hM0cJ924/Fo8x7qa5nGb4xWMPZ9EkVRUWppP0WugGczVMlRdqSq3PHEHMMjfQddaCN3yBjWhUhFWiZJXFKzVyLFNlL18b7OzLHXzQ2TWJx2qptSHAlS6aus0Wsy8I+WGXDuu4QGM1upqyxbXk4DhYRBn4iQv3RMQW3BkgDaZmuYfEQbdryzfloF/cOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUXs/oYcJpmBnY2Bb//9ANmA7cO4Cu3g3JNivYCZj0LJk5IXPddpswA1hMZw?=
 =?us-ascii?Q?dBuIHRrUAJ5P9P6qvZItwRreX3YRTvZxlFX+XXhB3gKuYtdKTfpSkM/T2iqp?=
 =?us-ascii?Q?kwb8mDLowe3pr7GWWNKcaUbSIQR+h7tCWDMRqCytM/hwJAKTGRe6Xb28wk/B?=
 =?us-ascii?Q?oYtMIrfNGEaMIS3BLVVrFj+73sw1FgCsgC63KERXYCDVHxsUui97jHopsNJW?=
 =?us-ascii?Q?/HTfiYuDshaayIetGBncOfQKbuPc3FYTqEYD0WWesRIVfRzjAUw6KHT4VszF?=
 =?us-ascii?Q?7RI/MZ0zhTGI9xpUbDNvKwg7RtDF6UO7jiGAM20P9UAebfcxwUgdRLAOAZbj?=
 =?us-ascii?Q?EfmJtZh7E0FDSh63NfVwmR5Ul76fUUJAJM8ZFlEr+vSrH0JKLoDzIExfDY/j?=
 =?us-ascii?Q?AMdfQ/nEU1EB8+IPYcbo+nr5v2+x+FRvTSyj2ak7tLgygrds/SlSePn/KKus?=
 =?us-ascii?Q?+LR/s0OysuL/GoABcK3PbDZhpYcdlgs+LIU/ShpcGw/vGOwhY7sFVHnxE3r0?=
 =?us-ascii?Q?r2GbGO6uGGr1KcVAlYDfG1zcu2wCmO3aSkUg5uw/7y7iZLo9DJ0udA/hyJjW?=
 =?us-ascii?Q?wUWXP0KG4tJqhJB2qgE+lZiX/WfZ4VlfaB5li+ajYVZ8EDP6kw5mS4PtoO60?=
 =?us-ascii?Q?NLaGPRGK5KopKoxd0jwn6YM/vH24VgKRoIF1mwDZpn2y7B3gVun/AU+dXEld?=
 =?us-ascii?Q?iV97D/6Vu+c4mXdYF8Sq7q++mgfsnsH0vrm7S3Fmt69igwVF3YFlcb85VPMX?=
 =?us-ascii?Q?y7zCnbaXM+l2T1ShL+WmIM24s//omUA/FRA0oZF5aSCyftPWZqmiXDQ2deGu?=
 =?us-ascii?Q?F7o5uXz0kC+vRnsA1o6gOHgWtrzNDiWJsj1d0+ElTxleh0pwtYUikaOuDkcH?=
 =?us-ascii?Q?jSNcpUS0L9mOCoWePVfnb90RYzNaxOZZOtXrL/kwKC9WOyyI884YoJ1c6ZKp?=
 =?us-ascii?Q?gZKdOv+dJpnvoz2UVX3inWdFjqS4Ynk1WRuP1kB7jhNe0/Z6RoR0UqDaxu3p?=
 =?us-ascii?Q?4b3/en53WCRFNgBLjPiqGWD+2Gq7qVhoduC2I5lgRb6SsfJfnXMQfYORGMN8?=
 =?us-ascii?Q?CXoKDe6duLEl2ZNKJVdW/olsvNkaQdCDBLfsuWgVXVINV1bE6IMHFv/eWDw9?=
 =?us-ascii?Q?zSXDulJ9V0Win6p7ANtIOsajuEeDjB5W3dLiOKe5ypdBlVggUwQKHcgjscR5?=
 =?us-ascii?Q?F3YFqJ/Sd2iu6vSpFm9TjfKN8jQrU85qPkcbmAWXn5PXzA7V+TE3mbRxb4F8?=
 =?us-ascii?Q?tUNq7pWCPrIwtNyhxmlSLxXHLtBAXeZa1kHcRcEmHk9WpbdTKRVmX1CycHK8?=
 =?us-ascii?Q?V7bsjfMuq8ah8BNcWlC0LQVoXFyNGRY/JzL3pwo2QG/uRhtkmdej+ewGS9y/?=
 =?us-ascii?Q?RaASx+iL2PE/1cxgQHFU6kvqWxl3heJLgl/6TKjuCjquWOD9ABrV4ux+9/Sw?=
 =?us-ascii?Q?PZCanT+scRRDjEWVs5NRT1n2I+z+1RJUXS/bB3e8AXeAqYcU3m7SPs1/sCQ8?=
 =?us-ascii?Q?RfRsAVVt8lanHs+U/X0d08u7yfgk7495g8p6XVmuXb26LdeFKGDDxy+KBpta?=
 =?us-ascii?Q?KlCo++WBkc1wUiDXiSjgB3kQFp8JNuaTZxySYP3lM5VHZwm3uj2Ga8hSha6E?=
 =?us-ascii?Q?NKKCCIz6YWlVRWSsw7q1mA7ZRKmJA5HCm7JrWoAtKrg4eqUJOeZx3smzcA0k?=
 =?us-ascii?Q?yRTmWoExDpLBK4NXZKMppAAZN74Qyxox/1VHDVcP44pG3F+FZlqt2UjFDZuP?=
 =?us-ascii?Q?k++GkAz9DQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: loV0zl4iawpGoL5DgvHwUt6PLaUWzbc5qYoPv5oGvndRibjbpM7/7ZkWJ1ecRCewQr1NMfxglN79XmooQG+a9gC+sTUDpxveP/TDtD5VQvuHD1+m15MNrUdgYvk4Wkp9jViYvYJT2bO7WXk3LGsgWUg4fdbIudOCHSi2plYa1psixu//G1O+gTE24yTD9/uRKL3YIDgva4BpOlNmH7ZWe9hd0omQMvIK+Vz7GbylzUkKexyJbZ+oOjF6myfi2dMo7bMu9mFVDiyDEoGi625dWMaYrhyTKyJbEiI/H+hAW9vKnaQY/Vy5FcyhFqDJA1oENNtpYkyo9vJ3YrgecAXq3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a599df0-feff-4ec0-1263-08dea084c836
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 15:35:28.9870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1biWw7Y8VFQabx6+du/OAnCgzTKSqpqII8zBlqVmk2DRjhzV+ITRVt7AiOLHBvYh203Lggj3LEGD1LSOLehgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11027
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1MSBTYWx0ZWRfX8Ivs5Xi3VD1h
 /8tvu+uWOa69rOJvP2XBOEs6gvyyd9DjRzivdgrcAAbR/tvNttBdeYF6JtwQbo6Jo96KemQ/f9b
 J1DQN9IpqTMf/gm6fy76QHqq8MyCKJRgghJwwx+vLF8OwH4V8BM86E+5CoGpK0tydpjFN+lhjFq
 bDP44G4m+E0U98SbbbJiyEDhuokeRdIcMml6Q1t3E8RFEUTzURBHBbJVI3oq/jtTvmKlx3gE/xJ
 3A+RoLQ0hBNwUSk55GcGpFerNqqhL4JVOU2HSA+fT/y76CtmIWq5j5na0yC5Cu78CFUicXeB/mU
 zfN8gGv79HItwkGVCqG2x6v11d/9NTXumGk7RBiSOqo94PhoovecOqzONiZ2HfkOnFifJ6AUedZ
 nJbn5nWD6LugLUieEfio9DdZnob84CGzQIrvzTZVY1MD2s2XK7QWq770THxG2iKQDjPu68+J7AD
 VTfphmo2HbSyHCNQrJw==
X-Authority-Analysis: v=2.4 cv=BpitB4X5 c=1 sm=1 tr=0 ts=69e8eac2 cx=c_pps
 a=MuaoZ+x0jvd2FUwkjOjmXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=lDiA_rBnGBvnFp1-3X0A:9 a=CjuIK1q_8ugA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-GUID: jloi5eCewe-wugr7WJvS1TZejGl5YjYJ
X-Proofpoint-ORIG-GUID: jloi5eCewe-wugr7WJvS1TZejGl5YjYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Wed, Apr 22, 2026 at 04:33:20PM +0100, Mark Cave-Ayland wrote:

> > The currently wrapped version of libvfio-user has compilation issues on
> > newer compilers; bump the library version.
> 
> I'd expect the subject to be "subprojects: update libvfio-user subproject"
> since that's really what the patch is doing. The hw/remote/vfio-user-obj.c

hw/remote is the only consumer of the subproject though...

regards
john

