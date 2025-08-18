Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49354CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 11:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unxgh-0008QC-H9; Mon, 18 Aug 2025 07:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxgc-0008Pn-Qb
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:05:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxgZ-0001Pb-Rs
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:05:58 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57I7JKbZ3229541; Mon, 18 Aug 2025 04:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Pu5inL515YH74
 JDRT/AIfpB2hfBp+srZsVMFFygc6MA=; b=yx8tkfpk/bGCtpLqPeBwxM6ILEn/6
 lgMvtd5Nm7+BC60d8VElVnf/i7+o+UA6jJzeAbKjB2S87MKeVJX0lggsGOVZkevG
 lP/8lQtoh8OxWqP5rwKeJHkF78eriRmGP/VfIx8PJQcQ18x/6zwhHnQq1AMw+5WH
 SWFmCvwC9TwrJg9reohqhBNHcmwMtM1rQTlZJYW3Dv/8znn+qrwhKtcpkl4KY3tr
 KxNV69ZWEqMqXO83EEaKfhGabZ8tC8RRsllUTyl66H4cwQATLFP58dz2Pg6i4rRE
 4OWj/7eoU1aCz+k3hKjmMMYocWhGykCsUQqRV4ZenIF2jarAwkosVIE2A==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48ka87sxys-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 04:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLyCglDv7FftAueu3n6yOWgIvxqCsOqOyYs1L1AypntgzoMgajpa1I26m3Yb1Di6uKKxMSXj58SBymdiJhF+eH9/gZmFb2/IqNCQKj5lQcIt59CyFDx8y5vcd3OHXjCkPgo0/y6QszxEo+ewJsPzJ4kFH9VYi/OMKoFL5wriPzWsJ1cA51mSmN3dWyCKmo0hGQl7tihdmJX5lTA5+/EUmyUvZjdbKVsuzq8ArGaHtgNBt2ZZXd68fWGCIZGfVAHkrG5YHpPyJBu+C94WViwPt0COVJlIAE7FUYnCU4bv3Arfl28v4HcER81U4ocQyLYxEYyABmJqMk/m1juCESjhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu5inL515YH74JDRT/AIfpB2hfBp+srZsVMFFygc6MA=;
 b=sdpDi6BjL73Dh0RNMNAxEIFELPW6Y/aL+CVIWgO0xxGVkcaens2NbsMJVY/t1piijT2I0hYkAbf24ISLBfgwRmvEIqPCTL5exzp0IwOkXYwmvmTsUiLXdfEv7F4UCJ6qjwHU5vDR66bpq3amouwC+4G8CzyRmIflw2JLFBRg7GE2n8czzjP4oI6gG79nIP0m2SZLBcoZmKcqjwJo2Vp4TqwZ3iIKhb3gxvpfxRxClQlOwH2gtwWKtrHQpf27uLGoRci0kTDQFtxZbBFfzTPc1KvDsx/cCOQlivnBqmrxjn0o0hroZW7GVMT47FZRga/TH83Ux10Nkvg37K5Qk9wd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu5inL515YH74JDRT/AIfpB2hfBp+srZsVMFFygc6MA=;
 b=X6r4lewtxswHPIi9jDYT7jFYBYCbYEuPcaWXPAIuey+F2xk4cN0ElH8AKGdj4K1khg/KxnMyeV0t1NI+BQ9UNEQRp6yCVlMKPS9G6VJps/QqDBuPJmbgY0YtQwMeQELnL4515akLWp6825FjRfmrFQxXGt7M9/2qAVh7+JlLARE/9jmP+3j+x61TzoJGweoleSkZitaxqJlWBflE/qNqkSllaC5CCXdHyDrmDUVhiCCh9B2iSJUHHSVjX/hZHojTwJH8KA7s44SAFw/OY5x4GklRXU2EB994KkcHglFMU3KDbmet8k73rSYhTgCSjlmLMFwAXIkYAayVuJym/8v0KQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MN2PR02MB6814.namprd02.prod.outlook.com (2603:10b6:208:199::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:05:50 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:05:50 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] vfio-user client functional test
Date: Mon, 18 Aug 2025 12:05:43 +0100
Message-ID: <20250818110546.2159622-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MN2PR02MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 15816e2c-c0dd-4a89-61e0-08ddde4730a3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk1XVEdYSVFIMmsxdEpRVkNRdjJyWDZmUmFsckVjVzJjVHZvTm1FQnpheWpw?=
 =?utf-8?B?cmxiS0U5VlNBOGN6TUpleEJxbTZUVHpwK3o0ajR3enh4aVhaL2d0NWJyYmZq?=
 =?utf-8?B?UHpPb0dGVjllaFBtbjQwa1MzNjB5eTdUTUNmcDE2RDNUaFNPRy9XRU81UVVj?=
 =?utf-8?B?ZG5UTzRNUlp4YVJzQmZqd1NZYWJaVDV2QklrVUo5ckg5OXFZaFhiR1Jwckcw?=
 =?utf-8?B?dXZMUkNvdXhtb0lsdDByWkdvUllIZ3Y2QmFJM0d4SWJuNGxmNG4xYkpnSWZw?=
 =?utf-8?B?dFpDTmNON2I4TFBuMEMzY2lNZEJkZXpvS2wrWHd4V2daekpBZ3h6dWplb1JD?=
 =?utf-8?B?RFN4MnJCaEhMUUE1VUo3UzhpZ2ZPOU5nRGlZTXhOM25PQW1IQVR4Mk43Zlhy?=
 =?utf-8?B?WXFFTDV2OHVlSVB2bmFuVUFyNTRxS3JFaUh6L21Ia05SUEVOZnUyTVR4Q2gw?=
 =?utf-8?B?SVlsK3I4dWJlemljU2tPdjBXcTlIcXU0aWZseGJUenFJMmpsM1hhZHo3N0dO?=
 =?utf-8?B?MGYrOVhLVkdFTzU3SEpjOW5XTDRXV0U1UkdBbXN6M2Q0bERUbjB3RnJXaW1y?=
 =?utf-8?B?dDIwUjVqYkl2VTlNMk1zU2hOdWVjMjB0UCtvUXp4NTQ0NGFweTdIT0prejdI?=
 =?utf-8?B?OTYramVCK1VpNVB2a1l0c2p4SVFCbms0R3B3UWk3OUhzYlBVUGIzcTRldlZv?=
 =?utf-8?B?V1dDa0FKUW8zamQ3aEpPRVh2NWdpSzdpWmFBdUJjNDJDWXdDZFlTVk02QWxM?=
 =?utf-8?B?d1dnSGQrMmdkSWU0cnFYMlBHRGhtT2YyeDBMcDhYQ1RHZzd0eCt6ajdEYUFq?=
 =?utf-8?B?UThOTjNhNXJWYm10ekpuYjA5V3k0Mmk1T24xYWQ4UUUzV0pJU3hPeDNKTVU4?=
 =?utf-8?B?TTRKcnk0MjJnc3FJcEhEd1VWNzFrWm4wdDBUcVBMKy9pQ2N3aVVtWVY5bjZi?=
 =?utf-8?B?Q2t0WEsvSlROeWdOelFSWGtjMnJBTGNjUkRLWHExaFgvZllqTUJ2aWMwQkRX?=
 =?utf-8?B?clREUC9nSXJncUlrVTJDNjBndWJNckFKQnJSanVLek5nVEZxR0puanhuV253?=
 =?utf-8?B?ck9xaWlYTjh5cFZiNkppc0RkMXovTnVnV2FnYW5CUVhyQ1JFT2oyMTNGRDM4?=
 =?utf-8?B?c3czaHVlK1h6UCtHVDIyQXdMYTZBSzRUandEZUJ5ckFndXF2MGFNZG5JdDJG?=
 =?utf-8?B?NVRkQlVIZnAwOUN6QTExYjBsTERodkFmSmp5c0I1dkVKNnpBTnBFSWhUTkE3?=
 =?utf-8?B?WldYYmdiRXBFOG9kZTE5eWZrN3hDeTBQdmtCRmwzUHd6Sy9Cb1VzbFgzU3hD?=
 =?utf-8?B?Q2hja21MTFpoNFVLNVdUcGhCbnVtTHZaRndldGpHTFlKbDVhVDhNRHhHaWlZ?=
 =?utf-8?B?Lzd1bzcydDFIbE8weVJxZXMydEk1THVMbHZScDNXbXpISWp0OFhUU2Y1MjRa?=
 =?utf-8?B?bk1HNmR6Y1JkQ3YwcVNiZkNLcjdNVmlBUHJzZkZ5Q290ZmpPTnBKTnhmVS9k?=
 =?utf-8?B?eDdzWlM2SExyMmNkWFJkKzhQa0J2ZVZ5T3NwZWVwMTIvYUdJcllvYnMvUDhx?=
 =?utf-8?B?ZUJZdkNBTjNNY0tsdmxvWUtjejRXOU90ejdtR1JJaDRKUW9yQ1NTTW1FZlFN?=
 =?utf-8?B?OWY1YmtvVWJGL0JWa0ZiRHhnNG80dTlRVzhTNzQydTFZY2s0VVNGRzRkQTlt?=
 =?utf-8?B?ejFhSUhVcHJMbjIyUGpFejc1YTlMdnoyNEliSzA0TUNsbWNBVVYxbnp1Tzh4?=
 =?utf-8?B?WUNFdVNPa25VM2tiWk4rNDNIaWF5VmZjVGdxVFJyeW1hTE1aeTVPdUtqL1B6?=
 =?utf-8?B?b01iaDExTm9wL05acTQrdWpsVmwxQUhpT2orQmJyeVZmdEhrTGR3RGl4T01z?=
 =?utf-8?B?YWdvdmQ5VEdWdEYxbjU0ODk0dDh2cmRtWjZhaU5IcXE3V1JkSDF6SGVsNjlY?=
 =?utf-8?Q?8yUzFTSINK8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVVoRWZLMlIya1pxdjhhTERlcFJ4WVdhRTBPY0xuRzJTc1VrcE85TEZXUEJi?=
 =?utf-8?B?UmRNTHhXcllPejBucDhOclBhdVloR0dEdml4RHppa2JjcGs1NTZpeTk5amps?=
 =?utf-8?B?cW42UitpMzhyQ0lqT2ZLWFBIdUJ6UGJjMWRUaUFYbm0rR29iZ1JrVnFjb0F2?=
 =?utf-8?B?aC95MjBBdUpET0lVQWc0WDBXZnBPckZtT2k4ZGJySXM1LzBtODBHRVVRczlC?=
 =?utf-8?B?WHVvSnBsNG1WK0kyWEhKQlV2dGFVRmQ4bnRnV2NNb1ZMbXBLTTFqUGdkNnBG?=
 =?utf-8?B?a003V2lFbTdpbWxwY09kYnRjS0NjZk5GYkg3VEUrVDJXUFhzb3JKeEZWaGFY?=
 =?utf-8?B?WStPbU5Lcy9zdG5iWUVnLzlWQXdEbzBRNDlMZDB5Z05BRmhKR1paLzN2NTFU?=
 =?utf-8?B?OHFzZm90c2dabHV5eExoWVhsbUVEK2tkam1IN1d0dHZ2akUvTEdEYnZUcHUy?=
 =?utf-8?B?MFFHYzN0dHB2SUw4YVpOVTNMWnJYaEE3a0E0MkVFaVpJTk5oaEkydzM3TmFt?=
 =?utf-8?B?YnJML1N6QzArYXJoTVBqN25iRm1RWFpja3JHelNneG1hMFN2MGRmRWhvejhK?=
 =?utf-8?B?SkJoejdpZHdmL2g5RWdseVVRT0pWLzNRVlgrck45aHQxRWk3TnhzYW5PSkJq?=
 =?utf-8?B?NXhaZHVSY0hSeDFuT2VMQW5VQ3U0SlJyUGswOS8wcjhzRGtzM0xMejlLRkxU?=
 =?utf-8?B?REZRY2o3MHFLVkM5RFRlWnR0bnlYQnM3UTBIWUZad3Z2eU51dStZREw3WFBH?=
 =?utf-8?B?dE42S1NxUDVrb1BtMkZ4SzVqY3A4dWIxVTV6RGxnNDJVMnhjYW5xMkx0ckhS?=
 =?utf-8?B?Y01aTU1abnlHVFZqTGYwSFdFd1FMc05JV05jSjJPWlBRU1NYWHExT3NESElh?=
 =?utf-8?B?NTA2MURXZTZ1Yk96UzNsL0d2T1E2TXUzcmtIQU1XVVRzZXdLSDAyajJKTDlP?=
 =?utf-8?B?Q2JENjFZR2YyVFBXa2dpVEcvL2xIeDFqOWV3V3lTNG1MVXo5NFBGamJKUTFi?=
 =?utf-8?B?TkZKc0JOYTBkTG1uL1Vxd3JmeVhzWi9PQ05ydUJOTVdBNWJiVWpLRDVNMTRF?=
 =?utf-8?B?STV2QXZObHZTUjNtOHBrQ09ucEplYWJpMVdyZUM1ZUdpQTdHM3loK3hyQ3dB?=
 =?utf-8?B?SEtvYVFkVXFVaGprQ3h4a3puMkxDSkFXWmJ4YUVKaGNUODJPUlFwOGxoditz?=
 =?utf-8?B?TVNHK3JjS1hTTURqMzg2RmRuZnhqQmhIL3pZRXRVMW1XQ2ZVbHFpcy8zVHhK?=
 =?utf-8?B?TklORzRXd2dkUE54NEZsdXlJVk04ZThKQ3RPT0ZGeGQ5WXJqbngxTEtsaFRj?=
 =?utf-8?B?VnRKVDV3aXFMSFZGeEZwSHhiZlhrM1ZDaGZFUHlRYzhBS3g1K1YwdTZXeW9k?=
 =?utf-8?B?Y0VPVStDQ2hCRlhaZEdFQWdpNFk1d3JWYk9IN2NrcUNISnd3dkRvNzE3OTNT?=
 =?utf-8?B?RXdzS2EyK3Z2N1dpL3YyeXgybFhhYXlIc3VZMTZUSkxpVnFtY1RvRyttRDhs?=
 =?utf-8?B?V1ZJKzJSbHZ3TE94VmsrY2x2QS9vcjVac1VKeVlydWVrSmlNWHk2dk1xby9U?=
 =?utf-8?B?MmpmSVBGd3FQZDJ6Zjh2djV2bExOTFl6ZUx1MmJLSWwzQjhBUGQxd1NIZWp3?=
 =?utf-8?B?Y0wrQVFQaUIrR0lTcHZscjdESVk1dWZ6SG5abWZ2Z0sxenRlMUlmcUNpRnNt?=
 =?utf-8?B?WHNsR0dJOCt1YlhUYUNRelk5SXp0M0Z1Qzh4d2lZMTFLTGFuekZvVUZNbkpH?=
 =?utf-8?B?a3M4c1hvTEZTRnlXSXZmbVlyblV1L0tUTG1zTVpteU1US0pudVhmQjZsOFJo?=
 =?utf-8?B?VlRiUXcwYUo0bnZFUnd5M1hFOWtXWWpUbVRWbU00TEZjQ1U3TEI1UjN3Z21x?=
 =?utf-8?B?eWN5T3ZITW9GSDhqL3BpUWk0YUwrb1BZNHFKZXZTaUFFNDEwbGtUNkpLUlZP?=
 =?utf-8?B?aGo5dEtWVDhBSE9rK1FvaklJRUVwa3Z6SDZVb2JtQUdJME9GbnJXcTQrS2hx?=
 =?utf-8?B?bmJKQzFRc1VVNzN2TlZDK1phVmZ4cVZHU0tBSHRKNndBSzJmcGJqWmdMSjVN?=
 =?utf-8?B?U3R0clVCdURobnRLSE5BQVpQV1lXTXZ5aVhqclN5Yzd6T2RBUVJQcmY2ZE5p?=
 =?utf-8?Q?+7qVMPYRiKBkzbs7uh8xkE/is?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15816e2c-c0dd-4a89-61e0-08ddde4730a3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:05:49.9490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqiJiEc5etMZ3Rc4MZEa9mEOPaFq3DMDmGLV2IVdxh7Y8YiHdsHqbaSabuBOcX/NI8XPBqKyJoS9OZxCyaOAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6814
X-Proofpoint-ORIG-GUID: yCbRnIDeUKG-kdm4gONP-GN5W8dFfBWo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEwNiBTYWx0ZWRfX+lQf5SsgyPTv
 G2Ttbco3+Gv9uXFrmt/jthP5UYN3l+GBNvCpxXZzCf0Tugglur4EjxV7OgVMHLFTed6FFtmWoMO
 0DJMsPI6HvKJwuMHJS8Th3ksm7xAFCHrIKrAETfah4jv7v2lR2Dc0CteCOvGO2Fj6H7B5FbuO79
 a0xxTqJe0zY5g2nHnAyRG/mX4bV9gXRvbcCT2/REIEl1jDzFVizJ9qCtkVDU9jlVFIBwQBE5eQt
 tXDFMX9oqXzfY8cfbjqTgV/VRu/HiQo807V1+nSIn3DGv4ihkFOfNVOl31X3Xp8T6szACx1iQ4M
 wEJ8BKwDrcReekwQ1rFVcM6IYZsxM2+uHaik+q32iUjqXu4kFiH/9i+tj/FPb8=
X-Proofpoint-GUID: yCbRnIDeUKG-kdm4gONP-GN5W8dFfBWo
X-Authority-Analysis: v=2.4 cv=D6dHKuRj c=1 sm=1 tr=0 ts=68a3090f cx=c_pps
 a=m+x2I9q508XYD8KzOz5nbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=GkJwjvidrGdLuGONZSQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
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

Add a basic functional test for the vfio-user client, along with a couple of
test framework extensions to support it.

John Levon (2):
  tests/functional: return output from
    exec_command_and_wait_for_pattern()
  tests/functional: add vm param to console routines

Mark Cave-Ayland (1):
  tests/functional: add a vfio-user smoke test

 MAINTAINERS                               |   1 +
 tests/functional/meson.build              |   1 +
 tests/functional/qemu_test/cmd.py         |  54 ++-
 tests/functional/test_vfio_user_client.py | 407 ++++++++++++++++++++++
 4 files changed, 453 insertions(+), 10 deletions(-)
 create mode 100755 tests/functional/test_vfio_user_client.py

-- 
2.43.0


