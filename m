Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A177C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 12:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubeKv-0004qo-6S; Tue, 15 Jul 2025 08:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKX-0004ha-EC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKP-0005wp-UB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:15 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBbSh5025861;
 Tue, 15 Jul 2025 05:00:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=cFBdQGzG5+UgX/+4eB/bUo1a45HgxTcQPXxchzokI
 Es=; b=rZyXjJ62XbjvIIyqaJgHX6SUaq2Oszrrmot8iBRWpHpCjyK6yERkvkXqQ
 8nuQOHZHun0TmxT/PqilUwVE7R+1xXWfmvM/J7UsqKndbX1vYsuLMDCNrVim1Z/C
 0Xe2QdHbZtBEGFkF0X5qdZ+eemsHeEAA67gQ//IgUavwrW3+EJaDs+Gv6Rscn8aP
 zmu/ylajCH+/FHtHQvJhGD/r0KIaaIcXaXYC0ICJD4C58eKKyWPCcXl+m8GVsN1O
 tsAQ9CoH/+nJ/IiWEH/un/6LKg6dYcvNIh6oVHSbM9S0DYNmswo0/RM40q2l2UjG
 jU+fT5sGcNPxB1cuin9XApOCUMPZg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2108.outbound.protection.outlook.com [40.107.95.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47untj69m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 05:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlwHrk26hxO90u9Jnj1vcR7k2vhYkbcFzmSgSqD8ShvteCZsl9RWYTshKkXnSR+jPbgk0N20vzTrNWxBw60+Dg0Yyfcl5CEv8O04wwZaEVBcHfkU30guZC9ViNJwXY4vKX6Ljq6Cpj1P1JvGzXu60FYdvbqsbj+g2pIf8oS6/OuoviuWIPsrj80euHAC1fXNTmnmZloXsPnA1gUd3W0cvLkc94xGkUDA2YuPNVJIM76nDwM2GK3snnS6k7YY+Uo7NPcC5V9lCw/UMwo49gnAfKDvfZ9E2j1q1ojeOPMg+HxZzNjuVkHhuGY8D2ft+NdluiAoJPfq/EER0wLmQ7iIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFBdQGzG5+UgX/+4eB/bUo1a45HgxTcQPXxchzokIEs=;
 b=SoCicRWT6jGlsmxQl4AStQb/7ulPCElE5HyLwDHbEiHC3RBuZw4Vyqe0Lv59ZcGXq+cU1+QCByAwaj/DtLAfuxFgHbF++GOMvd7Mm1C3POF72IRUBWje7JnioLcCErfXvH+8HU/5DwGWY4AH/gReiAgMsIpBRVorofXcEdOI090ayb6cASmEBYmQ1C/oIVIXDlv+kR0+mfkYZRKFYcHrr/tPv6MtucePMZo0Q66Z22OCwWdVgNtPGbDBmbXuTg3/miFGZCOB3C6EnsVQYf12MBAwZ+RZvgZYMOP+xRHICrpPcPz1/Py0IqS5ZXEIalnPdXtIpNtFSsLk0iJjcKyK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFBdQGzG5+UgX/+4eB/bUo1a45HgxTcQPXxchzokIEs=;
 b=fQoLDRUjOdjjd5iX+ifF2+KOXZYw/7K/GGeoBrRkKSFegZkVvFGkNkgkCySGnyaBaVF0ysPnors1AGEDSOOCh/tVbnTk/Qm7uIdDhRlJmt5UT15XgRTkNo8vlXa3np+S47ylskMGGnjPqLL7kSs1+F544aX4xgHZeigXFT0YaiupLDv+lXAwNVhHsrR7wEmIumbFraDuGaF2LzM5+Morwmf4jUwVij141ttgmN6THheBwST3CCs/EaznjtQHyT96M+16VcVUpwW6l0JD0n4/4fxM25bD8xHobAp0BDmbZYgF1qhMqNifAuML8QmqSpxSKWTZLgF0cPBg3oGfrDZUNQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10710.namprd02.prod.outlook.com (2603:10b6:8:1fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 15 Jul
 2025 12:00:03 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 12:00:03 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <markcaveayland@nutanix.com>
Subject: [PATCH v3 3/4] hw/vfio-user: wait for proxy close correctly
Date: Tue, 15 Jul 2025 13:59:53 +0200
Message-ID: <20250715115954.515819-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715115954.515819-1-john.levon@nutanix.com>
References: <20250715115954.515819-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf18c0c-9588-4c96-0442-08ddc39721a6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZW1YZXM3QW9JR0JSLzl0ckp2SzNFZzFZNWxxSFp5VTcwK0VPVlRWNVNMalN1?=
 =?utf-8?B?VXcza2tUVjNqUERpVGV1TTdrWVVQeG96bEQvUnNyUjA2enprenVUV3lFSm55?=
 =?utf-8?B?dGpqZnBpZGlicW9udDlxOVJOL0VOK2tpT0VVUnRnb0dBcGxCV2szZmFsN2Zx?=
 =?utf-8?B?cEQvOEhCTS8rWjZqMmlOOEVhMDlrTE5yQ3NlWXdkSUFtTkJjY1luRWw0cW1u?=
 =?utf-8?B?c1NMVm8xdVVNSEhuQjlrYjcyK0hUTnhyTi9YeWdrSUVYSlhMK09JZlJ3Wjk2?=
 =?utf-8?B?Q0xQTlVsL0NWM1NqWEgyWUx6dUFhQjZ1cnZoeE5Jbk5POSs4ejFOL253Ly9P?=
 =?utf-8?B?b0M2MTMvWnNQU1haL1lZblhxbndHZU9zVVFmVjlZcDBOMVMyc1RPZVVNOTFH?=
 =?utf-8?B?SVlYMVlvTFEvOEJoZmk2ZGFnbDJHSUlHSEIxK05mZ05LbmpRUHZKdkxrak8y?=
 =?utf-8?B?d0I3UDNjNlRVbWFJcW9Bc0N6eElTTnhOUmI4NGhORWw3NmdQSnU0U3ljSjlJ?=
 =?utf-8?B?S0lrQ2pTanE1aUxJb3lnZ1JBb0k1Uk9JaGFHbXBFemlJQkJBcndHZ25BcE5N?=
 =?utf-8?B?WlgxN2FJUVZDL1hKbGFlcmg3SWNQNDE4eEFBalZlTDRER3BIaUE1M3M1K3pB?=
 =?utf-8?B?RmNNcWhWaFIwNWFmZVpRRU9ERVNORzNwQkpRc3RZc1NqTWlpUzhub0ZoTDE2?=
 =?utf-8?B?cUVtSmNVclpGdWp4eHZVQnZ2NGsrTkFYaHpLVXV1ZEdWd1IwV281eXhqRnFr?=
 =?utf-8?B?Z1kxRWw3Ymsxd1pxcVVLd3Z0cDM1UXdkUTNXK2VqbVEvanp0RlY2bURTOVow?=
 =?utf-8?B?djZxMzFnZGJXWFkyVEVhYmhER09SeVZDck1IVGhCY0JDcXcyNjRYdzhWUWFW?=
 =?utf-8?B?QXhNTkw5dW50WXBQTHNqZDI5LytIZXlib3dxa3FuNUNLVWRHVnFGejBZQjRW?=
 =?utf-8?B?WUlPdUxkWWtYdXRGRVpBV2RlKzcvMzU5VWkvTWJDRS9ZRnlRN1FtVVlMK3cx?=
 =?utf-8?B?RjB1amtTcEs5YW9nZDlhdG04Y2g1MmdobWR3MThxek1ta21tSFNRQUlnRlRh?=
 =?utf-8?B?azhLRElyU054TnI3Nnc1a1pNdTR3bzloNzRnTkRjODRhdktkUW1MYU5WTVh4?=
 =?utf-8?B?Ly9GTEtxNGRCWVJkcXl3QWIxNTE4UVN1eHhHRzJYSFcxblVZd3V2d3lqK0h4?=
 =?utf-8?B?ampML21PNUFhaWtnUUJTbGpieDdLMmtPVVVNZW9mK2M1NDQzWTg3YUpFUm1h?=
 =?utf-8?B?anJDdnFvWVNIU3FOUDZDTnZ6VzdYYms4b0M2MGliSXZGSkk2MmMwTCs3Qm9J?=
 =?utf-8?B?Vmx1MTB6Nk9ZQ0JmUDByU0tQMzkyQnA0SzJJQ29PbGlQRE9NcVdtZzV6T0Fp?=
 =?utf-8?B?R1pCVk1QbHFoQmVweW94bnN1NENiUkg2aEtDM1VBOHB1QkJZMThueUZiUFJ1?=
 =?utf-8?B?ZWl5c0l5ZVNqSUdiQ05FQW5wZVR3eWdvMGp5bmRwV2kyR3k1dWRuelQ3Y3Rr?=
 =?utf-8?B?ajFScy9kWFJWTm9yV2xCUkdZYWhnUHV2bnRNVlpFdCtIRFJlUTJrbFdsQlRn?=
 =?utf-8?B?VWFTRzdLUm1iNFVpQlZwcWphamF5T2RCMnV4SER4bFRWdWYra1d0RWMrUlU3?=
 =?utf-8?B?RjkxR1hSZzNQcEpiSGxJZ3RST05LRUp0T0hMY05ScHBqMDlNQzI4R3d6QkZX?=
 =?utf-8?B?UE0vL2V1NFdpeHlrRXJnWWNYZDJLUlhhbTNzbWpHcEpCcU1xdUp5a0VFL2xT?=
 =?utf-8?B?UE9rMFlMVEZYd24wM2Jic1RPZnNkOGhtWURQZDBCMzQrMEcyd2VXZ3hoUjNN?=
 =?utf-8?B?YXN4cXNXNDdxWGVDZ21pMTRrb2JmQ0RZQjFXa1NuUzBkTFhEaVNpOHlCQnE4?=
 =?utf-8?B?Y0VzTVUzRUU4Q2NiRFZucWdHcmp3cW5lbWlPZEhiazh2QmVEd1lBd0ptL0RI?=
 =?utf-8?Q?Bda2C+mwIOU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9EcytBb0YyOTJXQWlWNnZOYVU1N0FLbmlNZ0ozYklkL0ZTYk1nSFVvMDFC?=
 =?utf-8?B?ZDJHZEdpblNwSWhCc3NvV0IwcUZ5NEluNWlSbXY1aDlKeHdKTGdjb3RjSDZK?=
 =?utf-8?B?cXZlMjNrSlEveFlueWRGYTNPcTI3d09zMEJSc1lWZnNKQzlMWHk1YkRNNW00?=
 =?utf-8?B?K25oSEFxWG1QWXI5Mkg0TnRUMXpsVnk0TkpYZDRVY2tQaWVMd2tKbm1tUTdr?=
 =?utf-8?B?NmRUd3lrRmp2eFV6bWxUNHpETW9xODZ4QTl1YUY1cXI5eTcvamRVRlVKZkxK?=
 =?utf-8?B?Zmp3dFZBZldQaWpxN2kyWkxxVlBnNGRzVzhaTy9HNUxmZGNhbENpOWFSVGlL?=
 =?utf-8?B?cVRoa0h0TjRDbE5MVS9oOFJacElpOVl5c2FpblZ0NDJPRTE0U1l3TTRFQytC?=
 =?utf-8?B?eUxsQVFRVDRLSUp5WGloeVZheVpQdmpxQUFsTUs0L2R1OS9Oc05scjRNSU5Z?=
 =?utf-8?B?ejdoS0ZBSUh4Mm5LU0VZU2poWmFOMm4yQmVpSmlFSDRnZ0dRcUo5VklBNCt0?=
 =?utf-8?B?M01nODcwNkRhRnVTUVQxTG56UXhQZzBpY0t3ZTRFdUlSTkx2VFl6dFNXSDVs?=
 =?utf-8?B?OXpLUnVKZWNUZm1xblJBQWRWMWdsZTVVbjhVcllqcHdBdnZPSFIvT3FyK21O?=
 =?utf-8?B?QXBLVDJKeWw1U0NYaDRyaVFlVE4rWUswWmJsSkVRQTh2L3hObW5hVDEwMHE2?=
 =?utf-8?B?MHJIMFhaTXA0N0FoOUtjM3p3OUdHcnlDMk11N3oxcDdXYS96RGZ1VDJueVVP?=
 =?utf-8?B?Qi9qaHp2aDU1dWZvUmNabXhFRThNa2ZiNERFR2JOdDYxbUpERTY5UGFGRUNw?=
 =?utf-8?B?aU4yQkQydFRrUENRdzVsUThFZjFrcXZUQUtpZG1Mbkt4YTIrOGtqY1ZsRXNE?=
 =?utf-8?B?MHdSVWYwSFUvcVgwUDdrbFQxanRwN3dJanFCSGhkamxDb3lSVkJYU0wrMTlj?=
 =?utf-8?B?Sk9oV2tPMkpzdE1TL2loQXZqOU1BR0w2czJ5alJKNlNQVUFiOVZUVmx1ZW1O?=
 =?utf-8?B?ZS9OUUk3cXFCdzhpN2VUN0F3R2xkdkpFNVh2eHNiQXZ2OWxhY2QxeC9vUEZL?=
 =?utf-8?B?bXZMczA5UEQ1RlZmdFBPWWRpbHdLdlpvU0wzTG9zRXZiUFREcWJtaGM5M29w?=
 =?utf-8?B?bFpvNEpxWWhrVGZwcWFSWDJDU2hUd2h2cmd6UkNCQkF3YnBmVU9qbGFIVWsz?=
 =?utf-8?B?TXRIU3cyT3VGa2VEQVJlK3hac0hiSG8xdXFnRGd3Z1NqWmhCakVhNWpTUXlH?=
 =?utf-8?B?Wnk1UjZEZXdpV090ZDdqVDFpVXM5MWFiREtFR0RjcGxLTi93UUxOVDhXTWYr?=
 =?utf-8?B?RkZMbWhocnNCMUZ6U25QZDR3aXUzQ3A2a1d5aVUvUCtMMmU3Ym52MUV0akhZ?=
 =?utf-8?B?akQ2S3djNTBnZjQ3OTJUcFpHQWZ6cXVZSEpnSTFoVmVMNTZzYjlnWGM1TVMr?=
 =?utf-8?B?YmZXKzc0RjB0Nm04b3c2U0FKV0t0QjdJTnFuZWVQM0VlRGRidDRydkpQSG5K?=
 =?utf-8?B?ZDVnc05XT3ZGVUZPN21jOG5xS2FScGw0UjBlc3Q2c3FIUFk1blMrY1Y5amJr?=
 =?utf-8?B?RlVKcWNDSE5uem5WRlN3NkxwWHpzY2czTEpRSGJiQmJYNkd6aERWVVVoTnd5?=
 =?utf-8?B?cXgrek95RmxvZEgxVjYyQkVtTmh1bnVGYThPT1lKS1FlUkN1VHZKWmVRTDNQ?=
 =?utf-8?B?M3BIR0VjODlwWThKSitiek9TQStudG1pSDVHakQ2UHZZZU9IaU1nVys1Q2Y1?=
 =?utf-8?B?bFBsZ0tIZFBCMWFBNzVQSGlybFMvamduTk5GWUpGT3FJN1NYZENqU0FWRU9H?=
 =?utf-8?B?Y3BscDZCcTVqZEU3VFRlWC9kbFhhREFTdVNFZDZZNnpKNVJmT3EyS2dpZkdw?=
 =?utf-8?B?czdtSDlFQ1hZYlh4Yk9MK2k4cVgwS2Npa3o4UTVneHhMWTNFK01HUjVqc2Zu?=
 =?utf-8?B?Z3RRd29GMUp4MnU2aEpSNVBXcjlnVDFFekpVZ3cvbzUvRWJGNUFVaTQzUi8x?=
 =?utf-8?B?MHgwYnJwMHcwc21kSlZwQXdtYXlQcXNheXFPZmZPSGFHSzZZam9oK1BiQ2lG?=
 =?utf-8?B?Qk9tL3dRUE9WazFIMldhaUNUY01KeTB4eUJYQzFpNGZ2UDMvV3RhY2VFUm9Z?=
 =?utf-8?B?SlRmamQ2V2hyTzRjc3JqVTV4cHd6UVVGTWRiUWtVbCtUR0t1S3pkSENHd0xY?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf18c0c-9588-4c96-0442-08ddc39721a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:00:03.0551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+MvkmVmUbtmnkg7TWA0iynU/pe8+hpgZgctRP+O27zZufz+NTH1aUk1YypuzSixzP6Npug2woRAO67oGP4SaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10710
X-Proofpoint-GUID: -R8z_XqYGImq3MDcPk8zDXymrmyFf5Er
X-Proofpoint-ORIG-GUID: -R8z_XqYGImq3MDcPk8zDXymrmyFf5Er
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwOSBTYWx0ZWRfX9gKgNA4BHNUO
 Vh9xuh3uXglBYbAWbNV6ciyrbvcu2RCd7ByjDQAMBhwFFIGKjRmHSvjFFY87RWitlg74pxo2/QE
 7Yodq0QpvKo15ZwGnSxaIziVoZIHgnfslH2NpXPiwNE5ejZ1LWPTqzMiI5rm62MsRect1MjQP9g
 o7efLQP3BX0/jo9bAazKNUc/D9yuK8jizZQxjFVCoBMvZE3cRRbtjZ1Yrh88fosCk/NBdinxwKT
 +pRinHGBu8JN7n+qms7m+yDEwgYILpq/CQ9rMHGE2HqATLlFd49oRI+RH9vv0lr87Mg/fdhQG7t
 5dtyBc/CItU3P3xwFYkp2n6GLCqxFAuMCFZOItPE48OIA0AWjcuP+1v2u8+XgBU8gimiX7kIy2H
 AsXlDJU8/5019aOJGAFD7NBiVsPgmBNelTkxfOeJkCNoGRxxIWeZhh3lzpPep4dQy3Jw7qxa
X-Authority-Analysis: v=2.4 cv=PYb/hjhd c=1 sm=1 tr=0 ts=687642c4 cx=c_pps
 a=ekbpYupDM6YXBZ3+/kd91g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=6aF94XPOkflKZwprq4EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Coverity reported:

CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)

A wait is performed without a loop. If there is a spurious wakeup, the
condition may not be satisfied.

Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.

Also rename the callback for clarity.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <markcaveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c418954440..2275d3fe39 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static void vfio_user_send(void *opaque);
-static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 
@@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
     }
 }
 
-static void vfio_user_cb(void *opaque)
+static void vfio_user_close_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
 
@@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
      * handler to run after the proxy fd handlers were
      * deleted above.
      */
-    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
-    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
+
+    while (proxy->state != VFIO_PROXY_CLOSED) {
+        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    }
 
     /* we now hold the only ref to proxy */
     qemu_mutex_unlock(&proxy->lock);
-- 
2.43.0


