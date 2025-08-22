Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C48CCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQeu-0001ap-Oc; Fri, 22 Aug 2025 08:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQer-0001ZC-8o
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQen-0000fL-EJ
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57MA88oH2824615; Fri, 22 Aug 2025 05:14:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9LtUU0ByhpZOBLQZ6b7tWiLIVdVkbKIs7W3LY3iap
 CA=; b=2NPy7+XjNUYMKlXjJX8PXCuEC2SQFd+LZ7h/angtzf5cwcEKw3riI1l5L
 SXT8D/2axGXOvD9vwnGi7xHCy/YDXCHR9y02SYZhD5Z9xoNhRVPdOPCTzuSV7uMY
 Vybnzyy2gNaVIxa2FbjNajG9f3WPFaqYFfqf8P9Chckaan1zvo4To1ZdgyRvqGvV
 LwNE66UN4flxHIH/Ya7OB26MzqdsOqFBqZWxdP7s7e3wzP0raFw34vu5S0Upc8pL
 Uy1r/dswcpEKgA6TybhFImauG6ISvsvLC9VLEmcxFfxXfrd440Wy16G5Josu20ke
 5hMXgNMvnljLT1QOSodvHON+HprDQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2097.outbound.protection.outlook.com [40.107.237.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48pphe07ya-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alrkJe9qaL1H//YYWkUJ1tAsPQC/Dx6iDxqanFqZaoRP61IOz1g6E2NIgR3913dQb/efa6cqaJOPz7pw/dGs3NjYWUZOcLg0/XO6Sh1KMPqRht1nJpfPcK8GfIRXQkscVgyGyhYNGV0UdTk/RPoh4WwWJBGBCPzbdpdPSNY6pcNrY4SFlVGmc/4WMbGLvbFfC9yQCS7iohC899sY8wBf2yBvIZ9D46roHHHojyN6/1irqNtIoXiqGTuxBsvM3lG9ZIKi17zjO+yU3eGOLb61p3DuyywPsLV1hW+SC9u7aJYBvd721cpfCpEMmt9g23dp6WAZoObNKBicH79REr3d2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LtUU0ByhpZOBLQZ6b7tWiLIVdVkbKIs7W3LY3iapCA=;
 b=kgSNzi4G6Znt7eoZqkui9XxPKjuEAy9uHO9kefnELXUB+Lh2PHADHeO+hQ/yxkPOLFFLAuPkOZHTTC3PNbGtcHqTD+QcSLG+pKwQrLPIO0/oDnFHteqqHvsL5Myu7Fk1ud+QRnMPr2Jzew2kochYScWPuaMtRLFW+i5DaO+ZUBvNpKXc14NBM0AV3xgXZBIn4R/y69vm/OKPFtMX2RULf1HFqdL+vR2EbDwsBy6fAa7nT1xdGtbWYFzVkAIu4kGCE2L0pZvixH5eBL+P8ZZR9zNu1l/RAnfAvkCKY+BX04NHSrbRvV4aX7rg4qLdf/dYW4Iyq7gPn2xGrBt6JuUpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LtUU0ByhpZOBLQZ6b7tWiLIVdVkbKIs7W3LY3iapCA=;
 b=kYchPiZ/P3sjqeYg6KIzDX/RTjf9vjUIRgB/ZiWy9Ld8orfCoN7nfeD0mndindHBx+wYRXWyfMOCNMQFlbjO/mZJYaaPTLNAMCzipHuW3wnF0ALm/2Uot7Sc9CJpoETI3uM4MXrbKfzRp9SpHAc5WbpgQmMqtcNfZhJEQfR41SHEczxCyFtSW4Pcf+IeLAq/pkwFIGg7XrbK8FmCToksp0vWwkykYNoQPIqhvpul8/81n8xc3nOMNuiz41EgHpyItyj3c6CCPEs6yQuitg5TqHjLsn6xV15vHDrBChesq7F19Ey1eE/hF5hJFbeAW+R33oUTA4QL9bG24xpqFfFEeg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 05/19] hw/i386/pc_piix.c: remove pcmc->pci_enabled
 dependent initialisation from pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:51 +0100
Message-ID: <20250822121342.894223-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3faa6c8a-09ae-4c14-5261-08dde17562c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3hVYTVNSGkzclJzNloyU0Jjb0cvRkU4cXhVTmo2OFRnelpQUWFXeldKU2Rt?=
 =?utf-8?B?ZVYvWXJtdTh1YU12TmJWL2pUVmRRcXlCS2ZtNHRYYU1jL2IzK3Y0d0Nzb3ln?=
 =?utf-8?B?ZEFNclNOOE0zNUFaSC9UT2s2NmphMWxjQkhobUxpZExzajFOWXJxdU0vNWRq?=
 =?utf-8?B?ODNGRU9XVGUvak5aSkQ5WlpNRGFOTUVGckFpdG5HK3E4Rm1LOGdwcGM0MTdi?=
 =?utf-8?B?L2V3eUFNd1F2ZnRWMlBRbmVZUWxoUVZjaUJjUVcrU3RQcVhzR2FqWFpqRDdG?=
 =?utf-8?B?YWxWM0g0TjJRTWgzNGszbnJxaWF2Vnk2c3d6b1JQOVRDMG1Ib0dpc3hvZnA4?=
 =?utf-8?B?ZFlSVytmTlE0b0JXVDd3Z0oxMHBIL2tyOTk1UHJndVhPUTRidlZpRnNFaFNi?=
 =?utf-8?B?TjQrTFRFS2tTTm1xSFprQlY5T2NSdkRENjMvYi9mY0pqV3lZd2ZQL2wvUGcz?=
 =?utf-8?B?WnBsRW5rbDFDcjhaR2Rra3dUYVdabVRrYXk1d3dtTENnc2o2NU1CWTc3K0l3?=
 =?utf-8?B?OG5FejdCa0IyU0lmNk43TjFTL2JXdzVkK2hNTFpyMkt1VXAzSzVZaFR3elNS?=
 =?utf-8?B?aklSVzlUMWNuN0V6aVg2UUNzT0NqVlord2UwMkxWR3Z3S0tBZkg5YUhmV3BK?=
 =?utf-8?B?R083MW1ONStLZDBaWDkyV1J1cGlqZm9ucTRSN1VKZjdPL1RDK1R3Rm1Xa1lu?=
 =?utf-8?B?RldzSWlwTDIwdEtOR291N1UzelZuZ3ZuN2dVbGpqSnJnak56elkyeWNYa1ZH?=
 =?utf-8?B?WlVRMFQ4K2RXdDFTalpUMi82VDJURjhJanA0dXUvVW94cXRSbDZidm1uVnBt?=
 =?utf-8?B?WEhjMVZrZHFQcEdOM2lUS25XazNHTlpqVU93ZGpRRVdxUWViZW9vUExQWHFY?=
 =?utf-8?B?OTlPTzlWZmRwVWdTb00vb2lLOUVHU3FVaVhPTWlUeVNrZHlKZ21jOGMvUkZW?=
 =?utf-8?B?eHZ5d1FZcXRBN2RqZ2IvZWp2WnFDakh3dEpBOGtaTXFwTVM3WHpocTZLQXJT?=
 =?utf-8?B?Y0ZMZGtxZkhWa2xXRzBOakFQTkJTa09kQWtsSlJsRmNhUXRXcTY5cFUyUitN?=
 =?utf-8?B?YUR2VCs2ZWFJZ2s2Uy92eGVuNlhKOU5jclNyYmt6ZjJlRkQ4VVkzcVdsZWdB?=
 =?utf-8?B?NzVySEtuUU51eGtRdjUwSWpXRkNuWVV5TjVqUGpuSjRuckFUWmt2TmVjUXdP?=
 =?utf-8?B?bjBKL21IYVBJeGRFaXhFcU9VSXlpWm9ZbzUxMFZKdVl3eVQzMU11WUg2NzBN?=
 =?utf-8?B?MGFwSjVCQUNGcEYzZk94SUs5QUhNaWVrbjVjSFhQd0NCMXZXcVorOEsxL2pG?=
 =?utf-8?B?cUxWQ3p4eGhrMFlzeXArV1ZETUYxaXBGVlVvcUVvWVU3WVdabndwcUpOaW9I?=
 =?utf-8?B?TFJjNDBiS3Z4VXJwdktvQ0FKaEIxS05EaUdqb1hOWXZZcWZwdDd1WUROSERx?=
 =?utf-8?B?b0hnM09FbEl1b3MwQkVBcnlQT0lGZzdqRGdDVEFTYURZMGRpQzQ3SUlvcnFv?=
 =?utf-8?B?TWllMURzSnZjb214MTVXaWs0U0Q5andCTzRpaHFkaTVCYXQ5Uld2cWIyVkR3?=
 =?utf-8?B?ZGhEZTQvT3FtTm9jMW9tQTRQOG5GVUNNUFM1MWQrMnkzSHpodXNBUkZrREla?=
 =?utf-8?B?WVBxMkJKbTRVYkRPMkVOQWFFSlFCbElscWJLMlB6eUh6Q0h5NTdlY09hdFpI?=
 =?utf-8?B?eXA0RURzd0I5WVB5Y3JLTWx3cXh3R3VGTm1rcVVZTE9NYkt6MHUwM1dvRWxV?=
 =?utf-8?B?QTdRTXM5TUl2VHRQcjkxUlQzRURkTnMxbkVBVGJkYXJqenFibGsyZEpzcmNB?=
 =?utf-8?B?NzZGSTc4T1RtbVA0Nm9VdVJlMWNiVWcrTnJsemVONDJ1aHJ1SThGS0JlZ3Nr?=
 =?utf-8?B?b2E5bW1hdWZ0UkdRQ0h5VnF6SUVlM1B5N3hRNmdNZGZlUWVhcURMSTlHdkcw?=
 =?utf-8?Q?7xDPcGGyNh4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXgvSzZudU9hRU10aVFnWjNsZnZIQVY4SCszL2swRWFXWXpLUU1hekhJdjYr?=
 =?utf-8?B?UGZGdFdGOHFudTdLL0FKWTNaODhTRFBicHIwT0J3UWhrd2NoUENSeXZ3d3J1?=
 =?utf-8?B?ckMvZDB5SW1jeVVwa2F0dUl1Mjlmb0VhaTFhL1o1d3lZSC82RDY5K3kzTEhK?=
 =?utf-8?B?RUV5OS9KVU5XakFlSUhUM01RZ2JlQXpnRVZjNm5RRHYwci8wNTRJcCswNVNi?=
 =?utf-8?B?dnZCVUlldVJneXJqdi8zMzV5M1NkR0s2U2NpbHBtVlpCM0ZQdEdWelZnd0VR?=
 =?utf-8?B?Y3o0Y3haRkQxTXpjb0QybmV2a3hQNERYQy9pQUI2eE8rSWt1bFI1cnovMFJo?=
 =?utf-8?B?NGhiMXgwaFEzV3YrRm1wZjNrUjdLQzkrc0R1UDR4eWo4dlVjdFRDMWFraVdy?=
 =?utf-8?B?bEJUR2VsNkVWWE1IZ3B5ZW1tTUZaQTg0VldQTjZQeUhLWVdDWnB0NXFvRmpu?=
 =?utf-8?B?aFBlbHhXZGMvWCt3RlYvdDA3S25EaGlaaDBnK1AwY3pZdHZGa3hsN1Aza2Fr?=
 =?utf-8?B?VFFISEZpV2g3Q09NMmJpZktNMDJkbXNucGxSNytmbnF2SkVVTjUxZnhINmlv?=
 =?utf-8?B?dHlVT0VnOGpKNndyamp2cjVQbzlGZ3UxdjhQVytHNW9LSTlhS2h4dWVlZkNs?=
 =?utf-8?B?aVhVUG51SXM2cDhiem5QZG44azBuU0lEekxvbWdOSDlacnpzL0xFV3E0MjdB?=
 =?utf-8?B?amRaOG1CM04vR0xwR2gxYWVCZ1B6MUw0ODRQZU1TZ0tEZmVKcG5BM0xCSWxy?=
 =?utf-8?B?WEgzKzRJN2xWNFkvNXg1VXNoVFQ2VWRaNWl6TjF5WlRMd1V1R2VmaXZPUnZ2?=
 =?utf-8?B?cW9Ub21uUTBTMisvR2R3WWxIK0xYRjg3Tzh2dkV2eHBqcDNPLys1Sk0raTJq?=
 =?utf-8?B?S3FoWnRxa0l2YXFvTTFpMmtxbkhwcEEyVmx6cVpqNS9Wd0Q4WFl2N25OY2xN?=
 =?utf-8?B?MURwMmVqOXk5MVhLSzVtOWdjZ1dGOTZQb2N1SkV5YTFYSTJwUGdUY2VqY3E1?=
 =?utf-8?B?bXBWUGVBUElYdUV4bll4N1RDTVkxQnZ6WkthNExuUmJzcHJTNVc1NkRlRnJ2?=
 =?utf-8?B?VnZGMHFObHJKRlBUS1BFZWZ5MEZ3MzVVVGF1a2Fpc3VnckVzekFMSEtEZ3Rv?=
 =?utf-8?B?OTBtWGxyUFE1TlY1UkdoZTF5N0UzdkFuUnQvelRVVXFnRE5GZElpTk1uK0NU?=
 =?utf-8?B?akNVSXVtU2xTVGpUTXJNRys3UTR4b0s0elM2VHErWGhacTFIZytSZ09iUFF4?=
 =?utf-8?B?TjFEdXM5Wkl5YVZ3cmNjejRmTFR0WHVCWnNOTUV3N3NmZ0Vmck1DREIzSXQr?=
 =?utf-8?B?eXQ3bzhJbGpSZ2puZ2FRbVU0cXZEeFNIaXBqRlR3MjRVbDZLS3hFc00wVVU0?=
 =?utf-8?B?a254SWN2NG5ZS3FMak1SZFZiajFjT1NhZHZMa0M3ZThmR2ltZGtkWG5OcDU1?=
 =?utf-8?B?dGVieTdzem5JMVFOSWxocm1oajd6UE8yNUdWUk5PV3VZSUd3bEN5bWN1VVI2?=
 =?utf-8?B?ODdxR0svMkRzWHhCMWlBS2tiNXpYNW82eGNNR21DOGgvb0JBTlRwdEh2M3N3?=
 =?utf-8?B?WmphcnJtRlFzZWEzaHViKzR4aytzeCt0UW5FckMwUm1RQ0ZzSXBrVC9OQkI0?=
 =?utf-8?B?Z2liWU9xVWlmQmFTZjFpajBhYXJReW5sNng4dlk2a044QlB6cmVySmhMd0pP?=
 =?utf-8?B?STM0b1UwOXI5aEZpdEFOb0VId2NpT0U5dVlmRm00d3o0NTFDUnBnNUN1L2FU?=
 =?utf-8?B?UWhkYkh5SEpvRWp5TWZXdW1ES0FPN3l1QStjL3hNRkxhOHU2NEU2SHJQWnRN?=
 =?utf-8?B?VHR5alFFYVZtNTNqeE9UYTM5b1ZacWN3b2ZKV0swVGJhZ0VPc2dFZUU5VlR2?=
 =?utf-8?B?RGhsQjlreWNxNjNmQjd4MmoreGFvbDdYbW1iSHFXWUVoT2tsWWs4NGUyT3hz?=
 =?utf-8?B?Q3dVaFdpQ0VCWjRDbUFVVHhVQXlud1RQekVWM0JBRmNTWFU3SUJYSmNVR0JI?=
 =?utf-8?B?QXFuWjNXUmZtdFVNMS9JN2Z2dkszbTJSVE9RR1crbFdGcFhjV3RScExpSmxR?=
 =?utf-8?B?OXZhUGJ3bXJ5R1ZtaU1FSzJnMjV3enVON0JoL1Z1Z0tWT05sTkh3MUx2MHRJ?=
 =?utf-8?B?OGVRZEcrcHhxZFhBVHJRaWJML0QyOU50c09uY2wzRkpZb2FCNWJMQlRZNTBa?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faa6c8a-09ae-4c14-5261-08dde17562c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:04.3034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMwCt/7xC/UCTgITboreyb1bLOlYuUWUkCzKxtnLAjtHBBllTYfe42thJU9h4aWD9IXuIKt+c74Zthv41qfvqPhS6SnFucBRO3t7CVRTlP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Authority-Analysis: v=2.4 cv=PvLKrwM3 c=1 sm=1 tr=0 ts=68a85f0e cx=c_pps
 a=0X7mRi3vmuUbB4YAiuF6EA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=pDVciPHeplB8fhom_mUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: QbaA8wi5e7omjihpuYQYt0P97HAm5NJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX11eEY1Nb7scb
 yDZ8jgCF5dElVTVhltUKCss2AFhDymXlDU2at2v9yaHfhqmHf6jwgeDak9ijULzwwHMYMrZ+1Ln
 GNF7L2nn2e3+mRtuFvqr/237TMemMY8k6dctmpj9YHZWLoZqkotVkZO1j5EmUSsNDTFJl39+LIB
 9eupmvtufJLloOE9z9FXwagdyx4BWRj9nhPHgYKvP2qHMZRFlIYHGBf8HchxVSLIUZztq/ig2/q
 K1DGed3pLrOM9+6BBNYqcm4SCy2XXbcn6wcS1NQtrOX/R3ylcu/tYxJyV3ulUyocjAnic1fubgb
 aI/8Jw7PQOR/6hePjXcqwlyj2ei22PH3qposM8MOeJKW4qzRvK8TaN7P37mXVbCEc4PmaLx2i5p
 tb/3VhK2DV+HDYeDf6fQAvpn6yQApg==
X-Proofpoint-ORIG-GUID: QbaA8wi5e7omjihpuYQYt0P97HAm5NJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

PCI code will never be used for an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 105 ++++------------------------------------------
 1 file changed, 8 insertions(+), 97 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5b97ad2cea..da2de88383 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,19 +435,16 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    const char *pci_type = NULL;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
@@ -535,39 +532,6 @@ static void pc_init_isa(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
@@ -584,74 +548,21 @@ static void pc_init_isa(MachineState *machine)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
-
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
-- 
2.43.0


