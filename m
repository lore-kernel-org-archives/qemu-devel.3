Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C4FCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8K-0000gi-L3; Mon, 19 Oct 2026 08:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm88-0000OI-A8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm86-00046s-F9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:16 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QSxm3508824; Mon, 19 Oct 2026 05:06:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=q+TiuT29Lft1Lhctk/2jJK60T8JNvSJE91lHid7oU
 0g=; b=ar0/SEzDl89z7nuCsFBUJyacAApX7qxBfzgVF/lNeSSfX62xGbXrNx8JS
 dD1DHeAyNY1OcL2ro/wBWdKH1FpOu1+45q+8EBViNRfP0g1phDBpjEZSG1zBSAWB
 BwuBkKGMN1JIuaSM+PTOGFD4v/LNsbKA5rSzCDGYBmBwi6yyK/88+0jmI+QJlriq
 5zjO0tB14NwwftXJZz/eYvMOtW9LMUwN+Mk62Rzg+OJ7HOs0Iwn05zgOe32tBcUi
 ckxrnsKsq2a04HccG1gxwsdiXDWyCcRhZO3GJy5ZiOinOkM0CjMYlhEze7VMCNGD
 fxXWTRItEzpJKLBu6kbrKXy7ygEAA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021083.outbound.protection.outlook.com
 [40.93.194.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc4x43qng-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H51gqg3MY8tCh0KWgEmoi51cAeZ0Tuk1nsJ29EgqoE54RpPuWUdIpStbrMkZDmBoWSHPyLYGp4ng+U6oBIUGDFKTp7a7cQFsXB8Izz9eV02ofL4sCK8IiITEyVMKdkOZYqiS2iNruBWz2pOv+V4XkrM/AhwBBROKNwmM1RNUBETAyQqIvjtBRDzWcomQ2TbbyKVdWe2SRgg9X1mjFvgw/Y7HAOQVgKxwoxU4whzJqxKGuGZbIsLlU7b6I+Yc2A14MPtrNl/ZUZ8K4WatE3Y65SiT2piytQlxCLkhaE160vCQQszf9rx/Id/dMNXST2Euj3W1EysyCSV1crEc+MpIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+TiuT29Lft1Lhctk/2jJK60T8JNvSJE91lHid7oU0g=;
 b=JimvXdgU+vYXgutnUmkMgHbI2kSMs2m0uYc9reIGQGfdyr8beGREqnlF/Uxn46Ne4N1T5cLXKhGLUYNdHzHFwjiY+7v4camL1cPoBThwGshilKPyN8iQgxapwYpz2P/nXyeTqujKs3wwQmJRPdSNmvvRoD/0bKscPSkoRGjvIZdJLAsZdI3pEe0WXagRtzTMHODc0ujA9bqKgeILH36TqUmg/Bb2JRqvbEXblTRg5/fVaeUaqyuWkdecz4JP17H2BljHh2u+DTGvRenU6Omk3VI//dorwSzoU4A6DT0O727nU09ihoq/z2oKcSTNla4Xdg55tmvJpsRetTEicO+skA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+TiuT29Lft1Lhctk/2jJK60T8JNvSJE91lHid7oU0g=;
 b=CQK/I7ar51r5GaY5aeHA5PtriSBv7yGZNVPPhtxKrP6dyAmL0ht4Z/2cCq3bQ9hh+FzTog4BULtB4GskOMNguI4/WjRU87lLLusrDcwLBCq1krJaewZYJl+Ajmkq52ziWj0T++PhGe47hpsiMFVFqOZa0kFTOo+TTYq1XU2hjNp/Rj592AiJVJFB89YmqoR5bZ3o6hnY81rOxvay/6TU7s60/Qy5RfOA+59HwudKXAQoGTzNVaHrBgxvdwG8SYfcGHsxF5JRhBc7H0VrrdH2p+klEGL4udWGaxLzMMdt8+XbYi8xT60urn8i1zDL5yWmoDKIcZ+9Zu+tlLq15PYFfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 14/28] kvm/i8259.c: use kvm_i8259 prefix for functions
Date: Mon, 19 Oct 2026 13:04:46 +0100
Message-ID: <20261019120517.1448687-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a892209-3942-4aa5-b696-08df2dd95ab2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: EwMW6GjyLXaYxr0Aeugg21leQ+4eMTEffSJuShcLRp/iB/yTiIvkYI6nwuIeqamcU+hDhsuT2hh3DB8bINauj+kk9ORTLHpRbRyMXKSxrmBOE+UgNrP2lnq6V0SlKdYu47rYr6/ul5pabP5ALLlgwBl3Cf6ejSD+e+AhEGqdSPGDOCrDLMtTRY3tC7B8U74lBhtqPzpPlfHW+iL7gmlmBiosz1PUadWn/EkTHKwUDlrNTg2GYCxYpCjyVknaNkFRP83Lv3zJ/84w7COmH7t6L/1QLN50yQBZe5u04uv47zhGdERpY8/sW0aOv2UqpcBlnCuDFWeh7jksRvxGujEGgo05m5TY7q5XffZOE0VR+NMe9kFiK9ZF7XHnuk1mjvfZ6I3QWICIIIFB2TVLAWop6tfccu9LDFy+7IjoE5HfVmni8xLFOPVntEyso6jiLBLK+m1qKpQIzxWzvvkGdcG6q1z1h/1HIISxAoH1MF6lwbHXfGRBnxSuZ8TFZ57kEyKoI1ML4uhPiK6lZxEZD/vou9Eutr8xx67e/wSDF8RAe3niuUbtY9Xb0N/p3hdvYUwibxprzL5JH2y7hzQgsuXCHhFLxTBkMHSq//sM3bYBtjcWOY5wBMQCkpluVWZhHcm8oLXEz1R2Bq4rUKjDVB7Hu4wG3aLd6+h8Vixed2sBaVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q54s9NKHwxN+7zw2S1VzxRpm3c+W5J/E6GvwD3xIKLA3FmWkIgEwjrWfyUfG?=
 =?us-ascii?Q?KAMtPEyHZtA8i1vQHNRJFD1qQhRhJ0v7trEFOEMeuUBkvNSDZ7f1K5YRmc+g?=
 =?us-ascii?Q?uIiEDwQ2vJTmg2y2iw0XP26A0cBquI7/j7QRWUDkVBxInMbgE1kiX1Jvekd3?=
 =?us-ascii?Q?+qr5nGFJrwFKP+VmaZF1BHQEOzsmVJfIc1O48fyWpAGvIw86Vl+6vOA0ZBON?=
 =?us-ascii?Q?YCjQNNkrx+gTVmP3G1YVi9PPRRKQKhbGU7rR/+bRH0oY1yXNmumUthRvG2Ed?=
 =?us-ascii?Q?C7Yd7pov0AiCP8PrsZTjElNIZzjkCo7ZuMfDR81KKIHxtqmD8SadIM87fxLG?=
 =?us-ascii?Q?WZM5WKiij2aiwvadZRrjWEUwhkgzj1By+kvj13y1Q66TeAzk+o8TKO3C3T4U?=
 =?us-ascii?Q?CKzuT1BLCvuTSaO5mKBBp0NABbludWVcS1jsEa4V7YS685V5hZ0cSE17hTiO?=
 =?us-ascii?Q?Ei0FhudqYFyCh4k+LnljhGN4TIFdQP4imwm0hbCC2007y3dOoJQOEWP7iMR3?=
 =?us-ascii?Q?cK/bsWi8no4z4QNJRMc+mU22HzIk6to4veRkLnVNcgqypCkWYS32iaWpWfrG?=
 =?us-ascii?Q?i7j0zxUCqZrLEnTYqTrK3v4bZ3hokxXm7T5VsU9soZR9mfPI2IZeaRaZxfy3?=
 =?us-ascii?Q?HgiQk2YDMV6gx7E308uN2lpG07t1dVLd3Dw/6kDUwiK9oaWUtm986IMsnPI6?=
 =?us-ascii?Q?I3FXIpS5R3ojyGstxgg/EROIFKYDAptwq0BB2EdHsqYmTIddMi+oA1LD3pgQ?=
 =?us-ascii?Q?Z1bpqdm0upgz6nDUfsC66nU5bmiQ0o4mhqbEeSZwAmCGP/y8CDcB5X7mv4fr?=
 =?us-ascii?Q?uXNVkdM98gPdSBYSEuQH7oGVtvjXmiZptcxiciHxeqYkx24eGOTiTls3q5KP?=
 =?us-ascii?Q?kPQ0kNumikXFjGTcZnTgBhY3hLR9cA3RP8LM9APn/uyDDwItdYMoG0wF8veC?=
 =?us-ascii?Q?TYwFA/oR63/c2TBYpi8jgpx0LoArzv8HvPOs15eVWQ85Rf6A6UvELTYcAuJT?=
 =?us-ascii?Q?dwlbHO8Oqs9HkZxKz6FbK+Ymmtv2RiFuoQakM11gTTcKUDVCsym79RBn3785?=
 =?us-ascii?Q?lm6fNC+FS7FA6Art+klwhRfhvS1qKLXHM4rwF7kMZnpoHBOAz78Z8xj3s0am?=
 =?us-ascii?Q?jxs3mN8XQmCZa+HqA5C+y3x+Z4rFW8TGr6MvUX9sQaoIl+fnIpWlZi0ScpMz?=
 =?us-ascii?Q?+lrAP79xdDVUgRG3mVtInaqvb94WxU8FpizwzYnICxvpYUIDydTbsL3sjU87?=
 =?us-ascii?Q?gGkgTChY3KMgdxz9MZrotu7h98U8G/XmVzQlBkiu+RBcxfTCARbbF67Yn8p+?=
 =?us-ascii?Q?JrQ+bufPKOk/PdywYX56PfkJjqZF/6CNNffJsQcLTbY8vlg8aOSrx0WO4Mwu?=
 =?us-ascii?Q?+lAcLnrYVdySQm2/1UO1x4mDr3HYQcPWRAZYkb1n/yKUvPXdXBNh7G8tqkDV?=
 =?us-ascii?Q?uRmvb/0Skm61+8PO3QhbUrfWBCDWLMzqNhB5v3vAx5bSgFvZOSbmZE5evGRv?=
 =?us-ascii?Q?ivgqbrJbJu/kennY1ZL/M6RaekdHxX5wqEsZ+Cs14zX15o01IEIQZ1WJgPA+?=
 =?us-ascii?Q?q3xiMxfvkI9k3JajOYqMaL1LhTZdcA2HJEL8XAw8M8Dx82mq9qFc8iYKgZpL?=
 =?us-ascii?Q?PgYPHF4eLpvHlhNaXN2Ti6MwoolvO7PwwOe5YbC+kiCCR6aE/YhFP/RuYE9N?=
 =?us-ascii?Q?EkcamR1t2Q5xLQ2mTxQ7PwP8beJ1iP/D6Kb/tjWc0VpCNKfOd/Uft84VSp52?=
 =?us-ascii?Q?D6P5ncegcpwKhXZicwgs3BlEgabT2ng=3D?=
X-Exchange-RoutingPolicyChecked: 4O99g9hfNJhaj38d9KGvif6GPUY9AhQj7INl3Xz5NGE/MVB9APTkL8rpJo4Vh2Skp5Noev4CvNgIHjGGhdF17c6jjeGn69R4FAG9iSI0qBYwOOlP8o2707I63x1erJ9tCu8R1tHwXce6Biv7s6BFfrjmcsD0sJFQc+mq1rGcKLqyETab11ansQQ+odbAeoYC6n3haQxJJHx3+8evLOm0+KduDDCf6fcNUXu82sNNvhDbSKPx9WsPU7jYVRDtw1v2HIWCVbQBSQg5s/9k2oEALRTcHTYIp+GnEwYp3Puenq175OlkGGmE9C+FUxKu82nZ6OWwvVR/5taehh2mumNnHg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a892209-3942-4aa5-b696-08df2dd95ab2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:06.4714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k20q7/0utuKVLQCRfOf9DwGbxpWsy22QHxxWdiVou9yObHnFpQXcT/g9CD/FmWhVFAVFhyeq0dVuXIu8RwKagWHuYZxO7fPMNKng1SaXVAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-ORIG-GUID: NGM8duR-YZmZmuJUu3vDkFvxi3fw4PAR
X-Proofpoint-GUID: NGM8duR-YZmZmuJUu3vDkFvxi3fw4PAR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXxePepuclIsdq
 FhSg2VFgBdOhnxohbZkxWEfKr/Dn+Gxhbdj/IU0cIRdQ7Dy/jAT7zBP272VbJx1K+q77wm6hClt
 AlIQoR1TOwcVZsuiB6gIA9hjDOehuxg=
X-Authority-Analysis: v=2.4 cv=DqHDa2/+ c=1 sm=1 tr=0 ts=6ad607af cx=c_pps
 a=IDYaL8Jh3K30OkZprGHyjg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=b1AWVSNg6wsnrng390EA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX3rQ6KCpx8IWE
 fmsMfup7Qs0LGwzfZ11VebZ5AoeRZINv8txHYAGkAk7C1X8VXIxEhfROSAULTpOE58zARmzh6vb
 3t9O/PPjIOMPv4rpno18clI6FcKA6Auxg3NYYnmqADCpNHIVH9hiQ8AHmSRwEFOWt8OY2Ndac0C
 pb1oVc5g0JAbaNWKscK1xSjOkfiBpbuXGG+KmnKUZ5EbOzwTUMoWMvYPM/PStIy80ShQEKNMdK5
 oYQ3SguoEXl0YhxfuXqS2M7szAht+xeBrM/oJckGAyVtLneLkvvkMhDqnx7+D5Pc7SkSu6gWN8R
 ylZ5D3JDb2a3GxON3MGcMN2RLG2levoFP9/CvSNnKc3sCkiX1E9cia1BthtNC7kqoynDYmNURp6
 +SHG1wCyvzShyMEmakH2bcEwPU+TQZ7lxok3rTqyUMiZNIayefYQrbS+VDDBhOw8GsGSWohy7fa
 wXABkneFK0TcYYcp7Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/kvm/i8259.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 3a960e48e6..952f58be11 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -36,7 +36,7 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(I8259CommonState *cs)
+static void kvm_i8259_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -69,7 +69,7 @@ static void kvm_pic_get(I8259CommonState *cs)
     cs->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(I8259CommonState *cs)
+static void kvm_i8259_put(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -103,14 +103,14 @@ static void kvm_pic_put(I8259CommonState *cs)
     }
 }
 
-static void kvm_pic_reset(DeviceState *dev)
+static void kvm_i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
     i8259_common_reset(cs);
 
-    kvm_pic_put(cs);
+    kvm_i8259_put(cs);
 }
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
     kvm_report_irq_delivered(delivered);
 }
 
-static void kvm_pic_realize(DeviceState *dev, Error **errp)
+static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
@@ -147,10 +147,11 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_legacy_reset(dc, kvm_pic_reset);
-    device_class_set_parent_realize(dc, kvm_pic_realize, &kpc->parent_realize);
-    k->pre_save   = kvm_pic_get;
-    k->post_load  = kvm_pic_put;
+    device_class_set_legacy_reset(dc, kvm_i8259_reset);
+    device_class_set_parent_realize(dc, kvm_i8259_realize,
+                                    &kpc->parent_realize);
+    k->pre_save   = kvm_i8259_get;
+    k->post_load  = kvm_i8259_put;
 }
 
 static const TypeInfo kvm_i8259_info = {
@@ -161,9 +162,9 @@ static const TypeInfo kvm_i8259_info = {
     .class_size = sizeof(KVMI8259Class),
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


