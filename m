Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4153C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpe-00082U-5y; Wed, 25 Jun 2025 15:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpV-00081T-N9
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpT-0003fZ-Go
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:45 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PI2Men021450;
 Wed, 25 Jun 2025 12:30:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=W6lVipkzK8AxHpK+9s5/3JtXLdB+95iXdXcHsT/Nr
 e8=; b=OOFZhcNyJUpPyqD/n1AWMukLqJ18/nBkhRhGz/4jgi/IxRVdYUzsdioCu
 OqtSXM5K0ZmtRx0t4bnUqiASbtXSigJGQ6pQiPic9TVtlPic0sZs0KhmhQ7rMcgT
 qQfqscqBdVUny61EV5FLWJ39CQYk6WBn1G2FS1onbG/h4Q5GzjWLaM2n1fIiErW+
 bUErOH+hoGb/UcAg+NZN0dKMdriHczNV+h7lqffq3nnucMLC6YHojyG/tDd0ZRvI
 TIPVK5or0FGYWpqTB+6w61GZ2oOCbGIBXI2Li5p40zYzts5A+9n8J/sL2v1M9ZoB
 iOASdhYg4FP4sqd6d/FVaWLJe7Anw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2109.outbound.protection.outlook.com [40.107.102.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47geghhf8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQf+7Wed0UNtIHdmH/jOCZVYEWr4ubZfA45wuvG0OUWt/ZDP7C7WwCgXgHR93xExlR7ShjWnzhMq89V4vsUcN08CVF4tvCFRbGo4a4W3MY0unWiHn5COtT5eme/it6aV2AZ5zykpjY5RoDxG3roSUTbQKKcrs54QknUu/JMwng/zN0+92Gxw1dnc7p70fJs+N5QxTrJHlu79sR8qshvL6pKyM2jU5JoIhA+HKWBC2y/zMSZszBWEakb+lrFoKgNySDVtD3P0IcFhBRncnaZO9CuCoKSiNFU4nC876+pZGCgpd+h3WISVt83EkzgjndDptwAt71HXTXrbtfyfXG83MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6lVipkzK8AxHpK+9s5/3JtXLdB+95iXdXcHsT/Nre8=;
 b=uE6kSEWSdvPLOv/3yvJg+tlG9i2J43ntwDAn2yjFIw0oNi2RU22vfPblrh9l/i+kVfGumnQq4Mk+Fc5PJzoPZwTN/oobk3w417HaYNwl45Qn7Es/EACaCCYWPE2CFYI1T36A9XMPJd6QESxU56a2DpZ74FLjUQQ9HcMDdU9JRxWwpqX/SXTffKDTiLP225boFiNXjyQOTQAQsSIhc3/ixu14ZdnhbhWJTM4qyBfWOKNKL0+H5e/g9F7iazDNXtChpSmXHWD+67CaF0fM9bKOjkc4Vm5AV21vPRxRdG6dXSaF2Zk0EXiBXq6XyOUCtFc26OK0/hnVJfUuywTy8VLkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6lVipkzK8AxHpK+9s5/3JtXLdB+95iXdXcHsT/Nre8=;
 b=waPddUZ/LYwQ7gc/R6hxSvqbaFt3wN6Pjftv3ukCms7/gwJFYYcRc4DBuJ9ur8mIClMySCBAlVoq2EZc/GtAtfxuwduOLhyKG+4ABEHeibZg/dUzr4XGOhokjY/LndUdDY/z/tWsmj5x5YNog4e6QEhucCBNnRtU3EQ9WNkJq1AT8tnfEjON6Dz1rZSvvZZiM1AzuopF2+NLGheTMzID31qp3GNjlBGv9eKn+dG7ao7Hp3rgjNRdwZnVRoDw5Bjs3YLe3g3nmgji3Dd38TcHpFl4B1Kw/yIJCRj1zZtz8exmOt98Kn/+m5fEGIjm0VmTtGwxdtFdcT6RI2Y9opwrhg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:36 +0000
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
Subject: [PATCH v5 07/19] vfio-user: implement VFIO_USER_REGION_READ/WRITE
Date: Wed, 25 Jun 2025 20:29:59 +0100
Message-ID: <20250625193012.2316242-8-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55a39818-b561-416b-bdfd-08ddb41ec27e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MqLCQawTBys3QehlcVVt0lLMiC9NGWxzBwOH8CnhgpeLhWvZyEH150VGNy9r?=
 =?us-ascii?Q?Gzw/9LcL7INPMT+deCcRtmuMozDg6KTIZtm8i/cOmPPTRn+AGPXJeGkIiAsH?=
 =?us-ascii?Q?FiPV6jp/+/qcMbyGvmdNftYKiRxkI5oZ1nCkVitTnk01KOB7uqIUywbZUReT?=
 =?us-ascii?Q?I0q65LJv82qsxQ9MsFK3Mwgq+C7LzMgsJopV1FBdCJP/c2N1p2bUYxdDZJDZ?=
 =?us-ascii?Q?4MF0fPnbSLbmEjKLsNRQooiyFPnOmlCGH5pibIEkZ/GPXjTfP2q60aMrzFdF?=
 =?us-ascii?Q?Xewdzv4uchryjC9s9ZxAcL0HWOOkFUcj1YPvikFm7bP7HasCB+mEgeMydN6B?=
 =?us-ascii?Q?1gs7XkkvfFVxyIYKG0dCkhpeuJMqBISbUVbbKtNdzmKuij1+9Z4zsF44BQfw?=
 =?us-ascii?Q?cJncITTVe2KDcDHH3ac4DBPmmseNKjl9paPdVCSbjCWEFNLKLc7Klh1218CI?=
 =?us-ascii?Q?B83MwLxqCNznmWX5QsW8sLvkntgLkhTCz1Fo8rg311aCtGWvVnaVSSzIAIaf?=
 =?us-ascii?Q?vYyyayZ0KPrHCqI9ji+erbjrLSx59igESUNvPtXCzdqpLiEV05B63K3LEacL?=
 =?us-ascii?Q?tTTckZ6YlB4de1FTpt0yUUO4TdaObFHox+KXYG3HYRKMgGSnkzf3ftIyDE8A?=
 =?us-ascii?Q?8vXoJYEhBO8x0LF4gr9Ll+Cqc2jNv7iIcS4406bramrzFOT8IP9sEUlSfPjd?=
 =?us-ascii?Q?sxW4B254Emw49ha01gQGK7fkf0vWHTZYLSSFU+ayqCqd2VmMY1BvisrvKK+C?=
 =?us-ascii?Q?Mt5hLRn1PsvBqXBXHR3ZDPOYkk9RZAJ8QLtc92+YoT5xWHf9AwKbanD10U/L?=
 =?us-ascii?Q?S2HQmRDyJe55fuifL77bJMcgbUEWn7D9g14TiY1gE3GwLPaFHmnSWLJGWopj?=
 =?us-ascii?Q?YnpDzGqmzrumP9wzz4syJlMpQghIzhzcaJzutCv1FEWe4e79/bktDSdbXyKP?=
 =?us-ascii?Q?lw3eBKRdmXh5+0md+COApGMTwwZb9Ke32zPfopAWmfevN2QmIshskJRGJ8V7?=
 =?us-ascii?Q?Dj0t0hwRewAYI/BS54dsPGrmDGVyFHKDDaeNYhmkwiPUJ6tKMa4q94bX45Ai?=
 =?us-ascii?Q?2O3BbMPY5Wy02V9UdWjJ91pS7lwS+Q90prheOV5SydYQFb0yDYmlAWw8CeoU?=
 =?us-ascii?Q?voninbsg97v47STs84It3RB0e+Z9dVL7PjEe51KyL5i67N0KXbpGfZWm12G1?=
 =?us-ascii?Q?586EsCnUc+DVaCO9Oq2hTXhC1mHTyyYJs8L2cyhA96NkIPmdCFVsY86B4CQY?=
 =?us-ascii?Q?mfJbFpFTf9inqQ1PQmeS7o28l/UGbt0ylhCfrYhfI1UJtmsf1kJwuGChBBj3?=
 =?us-ascii?Q?SUTzfP911kNNDbezeFWs501cn1EHCTmF3cpObObmpGL2w5PGPF+5mECRM02R?=
 =?us-ascii?Q?2sWANwu8WybQoPcLP19801SzLuvoi1JaHSG+3EAoJNxIlUq+kvJFFZEjknSd?=
 =?us-ascii?Q?6zQr7dDivu0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2a5ozbPUFxp88eN2KqBThpZxvwzdMM7N2rRp9zHpWdaYuraQBmzdcKJnKyBE?=
 =?us-ascii?Q?OChecFlbIGhsV50ffRYVk5YZ+l4efvZc7VbhZdm/5p/yvv+NniqTzjXLt1Fv?=
 =?us-ascii?Q?Vs/hUHjxrMDVq5dYGgUkgZBoB6BHntKswiQ0krVgtBu18NIQs2SiCSclPhb4?=
 =?us-ascii?Q?f2DX5c1hzx92QXFFII8hI3aDCxQb1pscSGxQDVXjoB9UrRYLztBtVA6Q6kA4?=
 =?us-ascii?Q?D0mSgDX+lrMYpa0bul0XSMXs7GA06oi8PB1DscK/DAKBIUFjI28N8JRnScH+?=
 =?us-ascii?Q?Gd3FAQmtFynrPbE/meNjlZOKofHVBw7kIIsai6Ts9Oc+vLZfKQjEzj9WEYL0?=
 =?us-ascii?Q?jVp7baE3R0dPxZrX1tEHDrR+ACgFGArvzTdLdBrzSjSqbSUW0lS9Izj1hmaf?=
 =?us-ascii?Q?KLNVbz1TCPwLadnBEYSSGg32F1JsWHmQonsyUtQGp4475NbF/UyGAjudapp0?=
 =?us-ascii?Q?MRKNdsHLFfp/Zy4CgTdO7Z+4B4bOq46hgoxOYXHQfKeT1nVpAfl7fhjYGq83?=
 =?us-ascii?Q?Q0obLJ4rj+zTYlgt0INGZB3Opf0PNlNZXL/+Sa/2v7Lsx/MM7fFFOV5raiAD?=
 =?us-ascii?Q?IIwi+WLnqMQS6u84p7Oor+80xSQeVMK4G6f5ecR6AgvEagAI9fyTDbthnhTW?=
 =?us-ascii?Q?kHqnMTQLAl0j8vk74mczJhLQS7nJnxXZw9KIy89LayyueQPT6g/y1YfqHQ3j?=
 =?us-ascii?Q?CDIY/4hc06djq2YEG3IttJYUPt4JdXBjmoHlA+qB4sQVuPmXUE83L0b0sM/B?=
 =?us-ascii?Q?wzSlOGOXlMNb3eATHjmkzaGdmJSKilqBcH+bqgJRwATd0mzXg2vfKsDBzTz/?=
 =?us-ascii?Q?9vEekepG48g6hUEwSZod7c/yjCbk1bZTzUZXfds7IGoNs1lB9JsBvKXbiiCp?=
 =?us-ascii?Q?sexzjLOd/qASIMwrTYEX36KNZhTqEO0gRYpDng1ItJrNdb2X/SvQh6aN9zkN?=
 =?us-ascii?Q?88+zmcvzF4BA7ZyRlzeEMMw3UYcJp7FRwlGdh3xQRGyoyxVA7dSAXIV6ri1w?=
 =?us-ascii?Q?RtXCvN+0TM3wL/LKj43QUR7lewXYDUKtlMOIKG9xk7ApmovoaUGcGtCRAy5w?=
 =?us-ascii?Q?WR1GC5QAvT70UDRYItu8r7tDjU1gmc+oEW2Jb+2ArsClgj4rMEltY0oLM/Xv?=
 =?us-ascii?Q?6iE8gxbiiHQ0IFfjI2OIjI+cnbKsP8wS47GGulOKBjVqqXr+aMY2ihFzrUOL?=
 =?us-ascii?Q?eQMVXpmk6uS4n4MlPs1qaE6WASYFeFnqCD/2eOYOGIN2EUgU7DBU1ZqmjmfZ?=
 =?us-ascii?Q?tZOXG2vVn63FZHHISVti1fP5ySCiGo3X54SMmq+tWxMcL0UcM+dgUCE4vOwp?=
 =?us-ascii?Q?6uHWchmp9meaDKU/rGCN2s1Rxb3MdRgOJMXAQhiFLWyYdznF/fr/QVE0LcwI?=
 =?us-ascii?Q?KRMDlMYypfIe6sGH8KwwSBTnt0zpvno9LvvtlT+y4bsvxfENwiIbmxfChBu7?=
 =?us-ascii?Q?mku43SDhtRE5y7i5PSu3BQAdUCKLg+2EsjpD+xPSbGpgGrNw+KyZDgZiUAid?=
 =?us-ascii?Q?Ui3+dfeqp6co0UixvBnVsLiaOI1GzxoAD7oO6VyDTLln5wdilKhswZm8I9sI?=
 =?us-ascii?Q?/ul4eS0/r8n184JRHoIAIy2pxtgNAzpXTVH47uJC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a39818-b561-416b-bdfd-08ddb41ec27e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:36.6610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiLzG5RChjAFTND3MhJ+KTxzRgsn0JNr3deBfKck/HnvR5IJWj55MdYsQuhS6SVYyv6PSCZJ/EEsAS79wQ7g8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=fPo53Yae c=1 sm=1 tr=0 ts=685c4e5e cx=c_pps
 a=bisBo8TJYI3cbxihtjb+Jg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=8FWstLx5Ke4EXc4DKsQA:9
X-Proofpoint-ORIG-GUID: cIgbvXX7kWwxNl6iW3zkXJ7pvyxhgfii
X-Proofpoint-GUID: cIgbvXX7kWwxNl6iW3zkXJ7pvyxhgfii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX5tasLUH9S/iK
 7Ti1OwJAWzwII+EUXlqErBg0izn4UhAZ011VnHRNWjxeQcs2J9XAoImjQeMgKXn701wLPyXIXh+
 zVjpsUF4ZDeI3yZfOLdgYR4P5cq7JhDgTWZd0p06jhtCCNO9EbhlohgmRi2Vm1LL+xpWODVLg0Y
 qQ4pUhNYVSn5L+Gz0cx68tP6SYxNeEkZ4PN/ef6koPj0JeNv+kujcgin0Uik1pHllnPlZHbIr2k
 5nRD9gaylVv6KjaG8VFFGT1b0Vweny4Awpwcb4AmW8OCE+fRensSfY3kYMqrFjOm2tXAhhQ7gMr
 4GXyorqwtBRupoCKnDeJgD1rOX0uG6Y5JktolvvA5D+34NNixagOw5Hxc0OFc8OdZi7DKKen68i
 5UgQRu9YULDxgmb5CRQX36Q8A1+syC+CV8olFway54uf4bbLWo8JchFFGT25cZkjpW8nr94X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 12 ++++++
 hw/vfio-user/device.c     | 79 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 3 files changed, 92 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index db88f5fcb1..0cd32ad71a 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -138,4 +138,16 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_REGION_READ
+ * VFIO_USER_REGION_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[];
+} VFIOUserRegionRW;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index d90232a08f..4ef6a2d850 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -121,9 +121,88 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                           off_t off, uint32_t count,
+                                           void *data)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+    Error *local_err = NULL;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_READ, sizeof(*msgp), 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, size, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    } else if (msgp->count > count) {
+        return -E2BIG;
+    } else {
+        memcpy(data, &msgp->data, msgp->count);
+    }
+
+    return msgp->count;
+}
+
+static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                            off_t off, unsigned count,
+                                            void *data, bool post)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+    Error *local_err = NULL;
+    int ret;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    memcpy(&msgp->data, data, count);
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    /* Ignore post: all writes are synchronous/non-posted. */
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        ret = -msgp->hdr.error_reply;
+    } else {
+        ret = count;
+    }
+
+    return ret;
+}
+
 /*
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .region_read = vfio_user_device_io_region_read,
+    .region_write = vfio_user_device_io_region_write,
+
 };
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index ef3f14c74d..733313cd1f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -10,3 +10,4 @@ vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-- 
2.43.0


