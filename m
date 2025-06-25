Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843F2C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpr-00088N-Gd; Wed, 25 Jun 2025 15:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpp-00086s-Gu
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpn-0004C2-8S
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:05 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PErIon010338;
 Wed, 25 Jun 2025 12:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OYnVMjMjqwV7IClbxFzR8NdWCf4SvGmTzKBwYz86X
 CQ=; b=avDLLxZAuUb71vbev9hd0qYEhI4VT4O5Hz2+q92RgOBW9JCvZChBqTZK7
 laZlXa9npEG/whprRAg9gJYryPSdfrCROOdnMNVK9rYcyg5plYdNelbdQSH+EkXa
 7EPchICTXP+lXyDLdS+ZMYr2/oACcyPqhRtusji7tdEemDoE8vbpmirlSo3Mn74O
 FoVB3M5M9j8DXHx78/VcggZQHyb2TOj7wtJJayJc+G1qqNqbqh9s+sPZBfjwIwF5
 SDaR0x1RskCdfDvAFgOxlhEK55HkVIJ8SMSMKAYRj19A0YmdvZ/rvu6rzfa4DtKN
 3WQ3rHm/lkrA/zpqXqeHS8+sqyqIg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2136.outbound.protection.outlook.com [40.107.100.136])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47duth1k8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaEshoSxUAbyofUEXi1JzNAeEL4vC3TDtMiNbzwtAuyv3InP23Sey9fA8+9qvtz/CrtUECArJ/ov6Yjv799YheNRd5anOHP+l6mWO/PObhsosULbyLfgkEu1xdELRUO+sURlcGAvTmL6Ax/ZIZXLLFaCxkyBEhR7JBY67S3/3OCC3awTcu57ylaS/U07CkdBQOVZjhJyNOy6mwGdYLNH7bWhyl9WChRKBWyMFE39Vb9ZtXbRwd0dNgcQfb3RHC+brNKyS+5Fa/7H+RWAVMXpZAaDWglAnYx4qXj/NbtGhcNH7yP3B04lIgIUoTELDdjjY9bMbd+vEBzRIS85U1EZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYnVMjMjqwV7IClbxFzR8NdWCf4SvGmTzKBwYz86XCQ=;
 b=T+b1ixLVJca9J/4KDxt7WGBCsRtyliDSljyKafeakVU2yJBbN4QIZ0y6csOEt74UK4HdJ1cK7EmuHGPGmo88EV3mPLcUlHrW1UcY2OM0d6uPEscJ3vu66NmU4gNm/+5MaY6yirDmcK4jSFVTTZENL9rTLtM8K9JY0qWSSAY2gwQPndCc5ZL1wliCQXG0omrVyHuUKjSmxrEVcBOrbz5hcWTxJOw5XBbTO43hpSC0xc/VtzJll8KNspFCfbIWcEO+RRXCJOu4oMdM0Edsrp4xHWfLun5IvMcEFjbijX5lazm+aFcIP9Mot68HBxbfzyuCOUDi2qR/Vg53Y01lCtVscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYnVMjMjqwV7IClbxFzR8NdWCf4SvGmTzKBwYz86XCQ=;
 b=nePc/zUw98dLIO3HG/iLqBnn8kQjAxpMR9F5BUjeNrWqSAvu9Fh1RCo4xywzUJRQ0EEZUouhMDsQPYJw3/j/Bs8apX1FZ7JuesLsRYrmtO4eK9kEghv/pvGw1LkUBu/1xcDno6tDVFC2Roc7vBnb7lXPM1+sGpXwQ2vZsa6K13vhN0u74AwBb/UCCy4oBv9S36bXxcI2VsJ4AbwtCe2BZVuMF6v3DCh3qoFHKWrBs8YOZCHordZlyPoxwSSrt7IP5YSTXQG5iZrbKVNrrEEs3hcPYL655yqQvi1nejFCa1wQAY+/PuYhSoiqbnprzzzjZ+NCH1/WvhuGVuZs4x1rAw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:58 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 15/19] vfio-user: add 'x-msg-timeout' option
Date: Wed, 25 Jun 2025 20:30:07 +0100
Message-ID: <20250625193012.2316242-16-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 111983de-855a-46e9-65a5-08ddb41ecfb7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aECueuyAC7EPI3RYbgjP27LqOQD48+kTAdm2jcNSNeNtvA79nesD8J9aU6xp?=
 =?us-ascii?Q?w4jT29OX2aB5aXrBqQhFwE2yhcxpBdP/2C6nIsnlVp7+nMUSZRfiEoIfaRTV?=
 =?us-ascii?Q?NYpe/UGduonsIUzGLBBJP+/NJmgEW5hYPxGnrewDZXnBf0MNhs2tNv6fAZSE?=
 =?us-ascii?Q?8VWnG61piFssH3X1N4nL9bNT+DT3EPnOxUdx8x+a3QVLyd8cudfvdI4rnZHn?=
 =?us-ascii?Q?EGIN19mV5+++9FIuCzgGgdYTIb6i378RUaYhXwLPkcCqHiqdBVGfotqLi8Gm?=
 =?us-ascii?Q?z7CDyfveLPhCpPr6CdIfw60vlUQr4SlB3nukFQUe0EIhZDeN38Lr5r9AP2qp?=
 =?us-ascii?Q?jGpvLbOQmVOZvUbYDbZigN/TF0RDii2Wb1tmBJqtgTH7DvWIP6GIshNwZP6g?=
 =?us-ascii?Q?Qx0F05ovwgwUs16Labd+WnvWgTb3UgqA2zJro4R3YYf9T5fFwTWRdGm4EzQ4?=
 =?us-ascii?Q?WE128dxjToXl3YPFHIUqd19D+cJTMQFTptpeCo/Nlrray/xW0WT4GMZsUBYG?=
 =?us-ascii?Q?RnFmcTZWOVqG03ZROx87e3y9iYFpNtfrsngL8nXgZmBWubSNbUoBdc0+yXbL?=
 =?us-ascii?Q?b+Ax1zF3URLPNFRh8hKEoOr1JsKigTV9bwyckYCZZdd4km2+bSW/3HcOsxIz?=
 =?us-ascii?Q?QlbkphJbkrFdwaoKtqEx+ESJ59ks0vVDSfyhTeV7uSsch5E7l8/N+tRqHY8m?=
 =?us-ascii?Q?/zL3iQzqeNxJRXTbuNC3Q5U+koSMzPKXWS9xyA/70V+LLaODnYNgIC1Ra0At?=
 =?us-ascii?Q?qFKMS7J2nhyRUjSYLcuis4vSyNGSdNz1xa6WVajppN9xmeJER5Clob8okZfr?=
 =?us-ascii?Q?OYQkCf2QVU+PflOCCKGMNsY3grGIzHvwUElP6VGKMBch1Sa5QE826qENNHVZ?=
 =?us-ascii?Q?eNhFkewym98AhyJjuutMAkKYTXzz1yHQehDKIbgXkySNE19ByhlQYysaeiu4?=
 =?us-ascii?Q?uKO09YO5xNauIsGsCxTv7qQnMHT0mLWy6koygJlXJHcG5K0MgadLe2xQe4zk?=
 =?us-ascii?Q?JIZfxW5NlDfvbezudNA8nc4LxNvZWpZ2iAUVTzoOVCbNIaKZjNwfluRmuhvr?=
 =?us-ascii?Q?4IojUxfPwN1/3W/Q6KpdO8HhHrorvfBbLrj1z4eCtoUFUqxOjBf/36eanHO6?=
 =?us-ascii?Q?eMWyixAIvX7zbRaz2FpTl36iJAewFJ2EflwWl9tFNU9/G+9C3DkdiV6qdXNh?=
 =?us-ascii?Q?cWrn0RXFylSKSNwFLUFjplx3T/6357+0yGT27ZANkTyNHqpBHAipTQlEJF9V?=
 =?us-ascii?Q?CAF4esWsmTIQcdI9zdk+PpuLXfvTiEZKjcaTcSF44xuhBMDTftlDVrcPURng?=
 =?us-ascii?Q?h5EbxrC/qVWigZsp8tZu3nysUhGDHq6uFvCjbbTxOigR7zEqvKPKJ5tcWOkU?=
 =?us-ascii?Q?Q71pn3mLuG7bU0xzbvllWTEf6SFoh96CWaCY4splzAuvPy+7CZ5+NYDOL6l6?=
 =?us-ascii?Q?NmTye0/mJ/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IqSC+y8S0Goev0kL63+2/WTUBSRgeEUa5Fe/jS7CCOuUS5R1c4WGY2JuRdx?=
 =?us-ascii?Q?OGEnKXXDeRwGrBd1wqXH1g8tzsoKIw6t2y4dKyamG+t0B77sV9GXem80756A?=
 =?us-ascii?Q?biynj5zFvU+eTebaqGD/CYTz+GiPA7DZaADxaYmBEwVaecQX49UjHIKgjmib?=
 =?us-ascii?Q?TEkrvH+apILtUuoTcdar8khyw6Se2L6rqLVdcLvGiR93j9K4aKh3+dW+iDM4?=
 =?us-ascii?Q?LnVElnKb3DJo5fq885EVoFAIcRSFtOBqt9dfRmifLFjVcPasgd3opEblzOpQ?=
 =?us-ascii?Q?obBMaCFHP5CmCXXzjdekcHLE7V3zVNpB8hy6xFnn+vEvBrtolgvrVZ1+U+q6?=
 =?us-ascii?Q?8Z0kw7b90yjJV04ERMJN0+AIo5dXOmRT1eSc93sHG+Sud6H2KycwToTIb0No?=
 =?us-ascii?Q?stHP14U2V0lwgzC4st6BNyIihphpYIqVTH9MDD3AoJjZk9XSEe/FceRlF/sn?=
 =?us-ascii?Q?lPNr5YOX9XflqaS4a+3AYul4LpNKvTPkDhsLzjxrlLmkRSj/BbNJ/F+onhv+?=
 =?us-ascii?Q?6WP3u2AXf02M25TguqURvVSKDmp2WFylNEPYIM6DS+eiKjyNk5S24P4y4PRx?=
 =?us-ascii?Q?Fue5mqFpkRae2Ccc9gplyKkzBfH3w7HdIoy8Q38Znx7yt8QjFCa0Pke4Wgp+?=
 =?us-ascii?Q?UGvDL+MG8n5cUQ1bQX3K4UO1eQDlY8C5HACE1MjPWPGfecHsrJCZSsPVTid1?=
 =?us-ascii?Q?ZDBvFM2mTWvxNS/yWelbZV92JuoM+lA06Gj/C4yqVCgzhiPyiPAv2b08PVzQ?=
 =?us-ascii?Q?7EbPEgFZgSggNm62nZkovfoUqq7Lb71Qo1/kwbOiHBHmYwCRRx8GxQbcNane?=
 =?us-ascii?Q?2F2vbT3MlGuere6BMFWcodMEi4KmxJ7UZVTIhgF3pxSKuuDThR5d+OmXg5eE?=
 =?us-ascii?Q?X3E9BrvD9LBXG2jp9hXDDUO18DFI3LFphIBpg1UPSRlul8tbBQrOxrqDa3Re?=
 =?us-ascii?Q?gqsWobT+aTwYT7mZO+hd8uzpRS27z21jc55EdCqsnYk8R5hAa674pbxcq1/G?=
 =?us-ascii?Q?dxw6mlVDyYBiq6pFau2qUR0X8Lzvkfxxq8I2nqW4W0+91zNH2zLvCTSHlF36?=
 =?us-ascii?Q?8jj0DaXN115LXRYZ2doV0GEiiOrtQDomgr22NWShpPddOUUqv5MXgQ8BDuLl?=
 =?us-ascii?Q?S91Wq69IUrPDGRCYYF1+sIyjr5hCcVyP6aLY1rE9B9UjzyV/OQtLcZ8m4SZO?=
 =?us-ascii?Q?N1kt1A+fkxeVkQTl3j/0E8qJ0OimjKHqKoVtHPUDtpJlzWSvnco9fkGttGHI?=
 =?us-ascii?Q?teIhrRLTTH5/MYQh9Ab52Tbm9gs3x4lhLS76+vuSp7toPmqNfNqXbjEDXIcw?=
 =?us-ascii?Q?I0HfCDkIANP1+q91aZhtvd1qP7MbzRuHDmNP1z2F8ilxELvyFtNTfaBCWcfP?=
 =?us-ascii?Q?Fj0MDdI1zMX9tbjqb9B+Q3DZcAci87nVD2dLtTzg10lGbmkwuJ7hqr9mzh25?=
 =?us-ascii?Q?NG7BNX89qG9Y/3gas5Xm+4uCTN/jMK7Qu0ljh5dWEpA8/Ck/YYiun7/y+tdh?=
 =?us-ascii?Q?aPUObANJrh5OR1o8PEqvPaIxMezBZ9KCPB9FoRePJR1WeHyohJfvZcN85/eJ?=
 =?us-ascii?Q?3X8vHWsSyk6Whj7JWgaOLtd/2hzakSXT/yRib8D2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111983de-855a-46e9-65a5-08ddb41ecfb7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:58.7067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oabltOSy8q9J10Qo0RnUnimcw6H2AuYAH+FUluhCnnGbjCAbI3bUKT1GnuK6I1neFAOO+UA6nAVdxMQVQQB+ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX5OkemK9WFpvY
 YyPDReeBL0XcD/fzKWBHgRrGWGIUDva42FWws50xh1pPi/BgozFaUzofh1lxRu2aUV0xRI7dVKA
 EmOLQgpo20bpR5ChxvjwRnpjqETR99ljMV7bsCJbMq0vRt4V0k1JyL8bv0h39I/5yEXpBklrJwY
 UCgrzp0iAa7K3pBM1EScJ/fXqT8G3G0g3x3L7OccQCVXeiBB64CJjaN5PypsjS0k9mLApQtY/v9
 g4rFhR4FlMUvIf6W77AI1WcoHF6xl38vKlPnymWfwGcgrlK4MSUqDUhwa/aAfFm+alq+t+SmzZA
 yMBS3cMGwIXg2TMEkVKfV341p48dlDg5m3+gjyJmnJN7Fu+6/8ziyySp0dJo/IYIVRYToA/gp+c
 ko8rQd76ud/TxwQxJiFTZOh/P6ZUQSKijbL/TSRw0j1FEhKmxDePaBAz0KpZ8apgcnqZ2yz9
X-Authority-Analysis: v=2.4 cv=WNp/XmsR c=1 sm=1 tr=0 ts=685c4e74 cx=c_pps
 a=D0xTqnO8G3g1I/JDCPG9pA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=Ql6ANm6PklPDYutWWPYA:9
X-Proofpoint-ORIG-GUID: 2A4XuhGc0RTpyyAxeYNGjJeDZEnrctPP
X-Proofpoint-GUID: 2A4XuhGc0RTpyyAxeYNGjJeDZEnrctPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
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

By default, the vfio-user subsystem will wait 5 seconds for a message
reply from the server. Add an option to allow this to be configurable.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h | 1 +
 hw/vfio-user/pci.c   | 5 +++++
 hw/vfio-user/proxy.c | 7 ++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 39092c08c8..6b29cd7cd3 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -67,6 +67,7 @@ typedef struct VFIOUserProxy {
     uint64_t max_bitmap;
     uint64_t migr_pgsize;
     int flags;
+    uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 040660d197..f260bea490 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -23,6 +23,7 @@ struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     SocketAddress *socket;
     bool send_queued;   /* all sends are queued */
+    uint32_t wait_time; /* timeout for message replies */
 };
 
 /*
@@ -267,6 +268,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    /* user specified or 5 sec default */
+    proxy->wait_time = udev->wait_time;
+
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
     }
@@ -398,6 +402,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
+    DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
 };
 
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index cb93d9a660..c3724ba212 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -21,7 +21,6 @@
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
-static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -686,7 +685,8 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     if (ok) {
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
@@ -758,7 +758,8 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
-- 
2.43.0


