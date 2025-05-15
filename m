Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FCBC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFamO-0008BM-4U; Thu, 15 May 2025 11:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalX-0006H4-Bv
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalT-0006Dl-0X
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:58 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7ma9r006289;
 Thu, 15 May 2025 08:44:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bt368S//TFpiN6sebSh8SFSdPdLJh8K8ut+DZyEUS
 ZE=; b=rU9oBryzwZ2MuWNWqudiWhmizsuGJc5VvvBOM6qrto3Z0xWBvx1cDs0y2
 klQBCBGt83VOSiNcdiRaOpnx5NpsXUgd6Vtpi8JgTUO5ZHhd7DbaExt+pEoClvFw
 kdjsfQqCbdJC2K9xnqhCVNiGISYfWozaWV04nmnXjUnL2nBr7uTiHVJ62w0FwVFp
 UYnCd/NtAhVgbJ5RVW75pzDaN8HjEtagkYwxBsPu/0y6lEh87TULAVFrv1yBidwL
 T0KSKeVUeSbWBEcC9hKCa+lMR60tqxZQfzTOZlTbWDIddLwZwOgQXyWvtNBk33WR
 JfygtnBd6sfp5lZoQGIdpFo0tRzHA==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mxh0k19x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FH+Z6pmW1/p36uR9OVw8z5cOH386MTnZhQwXK/0xr8it8pidlmEi0FAdLdf23cvKaHeqg4l29xVURHunHNHRllBEawmPUoT/h1sRYCtGdNmm+Eoia72j+Zt1+y/BR+wre3S+FmWyNd4KZVb8Yl16U/VapJ2RdsOyNnQjZbfqF6r90w/wx97KqqZUFEOUJQEisDYwoNpw6+WP+jKy7dghKkZFqk8T9eMrrUpFLBpVIGL/+rjeE0kt5xfDeNnTYI0kXWrrvNl9hb5ZBcFa2s+6UT+1Nru8gr/uiXw5KMRLDby5Rq1DMRZBMmO8+8GU9U87bg1FX1pbvW6+T8V++/JiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt368S//TFpiN6sebSh8SFSdPdLJh8K8ut+DZyEUSZE=;
 b=V9S1jfmW5ds2FIF2zEUGvZNNnxN04CCwQGQzXictLPRtEsz47alukfi/CGtbK28DtfdsTlZJ0ErneE98a7iYydNC0+Jcctx6xXWyLHImsQknSJvoVykATX801A351RtE7oh+SUq4raWfOLT8epKxaGdEwM/n7X9dM/Ov+l4axEgzK4o4OsEoNSw/j1prfAXduO4Yd5WyUwF0JiTrFBgqQpjqMouujTlkfS5qCuA6x6aX0HkIuJAZmOC9xTrT+loOtpMwNQjt1xuKOKncGJw+n839/xCh2LYoi5WEag5lEX3mE3xMMD+pUTy6a3vJYwm05rE+wW2Zkl6HYSIg19peqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt368S//TFpiN6sebSh8SFSdPdLJh8K8ut+DZyEUSZE=;
 b=qkaIFMm3CObovIHrTK93yK1J6W2rzMFZqVEaURue+fUmJ6CJXyMfO8shcVBFMIyc/BpetfieSzDOMccl5Q0u5eXGWA971/zfj84qJGy8uqm20k4Q7HBJ0PAB61Ho8TOk4E5+0EEW/xpb0lFXrra5YSINN9auX9FwgufHAU2i2HWZol5aWJRFXfI7enSQRLbRNn1QzwHelfN3KDxEIifzaHdHAsfuqfQsg6w3aZy0jqXIMT5ch/j5yDHtjz0qI++vEoyBuuRAqb21RSWko5jAUkibUJWu/jJOx25sDu3FILi5t7+EYVQW84o8AYmbBYxhBg5grIGf3GdaZXkKo+cOYg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:43 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 10/27] vfio-user: add vfio-user class and container
Date: Thu, 15 May 2025 16:43:55 +0100
Message-ID: <20250515154413.210315-11-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d0254e-9bba-46ef-1dfd-08dd93c76978
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVNrenFtSnROd0tXL2pjRGJheW1mZ0VtekpTTGdFRXcwRG1XNXpqQUxVMkw2?=
 =?utf-8?B?Y2VTV0ZrK0JHdkdHM3hJMFdib2dLZkIrQS9OKzlyaFhLdmlhbTZiZFBWUkl3?=
 =?utf-8?B?ZUYwWEN0NlRMbEdrQmtNUk5odTBvbHdCejkwTDFsRk1TRDZyTkRsUGNlY0FE?=
 =?utf-8?B?aFIyNWtzeFowbVRHdkVGK2FOa3Fta0czdDVLWDlyeDl3T2hyZXZkTmh5TlF2?=
 =?utf-8?B?ZWY0YVp1SlV2MG1vdmphdFdtbHp1SnpybFN4RW5yRWZLbWxTWnlBZUhZNkRO?=
 =?utf-8?B?dmtaQy9wRzhrSzVqTkFnSlpOZ1JybUZmL0FPWGUrdDliUzdSWjRoZ1ZXbnRD?=
 =?utf-8?B?WjZUTVlCZTVTSDVkb09wbmtZRTlUT2c3MFJPNjl2cUtTa3dXSW5sUklOblla?=
 =?utf-8?B?U3hPWkM5VEp0V3lRU2xBWlRkNlE2cG8vUFFvdUJKQXZvazlIcyt1UktNKzlx?=
 =?utf-8?B?cXRzR1VGTE5nZk5BdXFnUVVKWDN1MjBPQ1NPR0VjUkZGZ0ZPL293OXlldGxP?=
 =?utf-8?B?Vmx6YU1aMFFteDluMzJRQzhYcndlN2lKdDI1S0RUYU1lclFrYXZwYTRBSFVo?=
 =?utf-8?B?YWtOV1kzMTQyRURyeGdIdUtNZmRNQURlMVlEOXZOcGpwTmV0QXdqYjYwNXpj?=
 =?utf-8?B?SmFXcjdaL0o0M3dZTG15VWNRRU9ockE1NHZDclNRbzJaQSsxUlVjc2tqWlgv?=
 =?utf-8?B?MTB1dkJsQy9nUzU0U203NzN6MHQvdEpXc3lUTGVFeUJYTVJKV0M5R0FNYW9K?=
 =?utf-8?B?QkNURmU3VEk3QSs2em1DVW1IWStlVElyWlZkR3pWZnF2OW5lZUMwMEFDWUlW?=
 =?utf-8?B?WmVCdFU4VDVKRE9yVFBRYlQrNG1GTUpuYy9rSFhRZnFZSThmOFVlWDQzWDJB?=
 =?utf-8?B?ajJmYW12MWxCK1JKN1ZmS0xWS2U1cHV1aEV3ZWZkczlJZ1JkMEl0R3FMNHl1?=
 =?utf-8?B?Yzd2Y3ZJci8vRDJveE1PeEQzenBoYVdCMkwzTnhWeEtWZ3h2Zjh4b2xMSGlv?=
 =?utf-8?B?OUg0V2c0M2ZnQzdtYVdiZXVpbXZvakdESzdLRXNpME1xV01od09BN3B1WmZI?=
 =?utf-8?B?ZDRjM2FFZjNOUzQ1dTVvc0RDRWxzV0JUSE9YN25BMXRSbVlyODBoMEVlemZ2?=
 =?utf-8?B?S2NZL1JYZjBWb2p6WXpndFlJTitBamZ6UHhZbENSQmV4Um0xNnkyWXBycG5t?=
 =?utf-8?B?cFREejZYMGJpdHkwcEdON29uUEVrbTgyandKWDdlaHhFSnFkM1hSR0hGcXFX?=
 =?utf-8?B?Q054WldSUjZkdHF6dVRnZEdGL3owWm11UStRWSs4dTlwRzRhcXlRKzdQWWNy?=
 =?utf-8?B?OGRTeGtlejF1Wk9ZZ05ieWNFWXRYQzltbi96OHd0K3ExNWZJQU54QTBDYk5G?=
 =?utf-8?B?QjVMNG13YVZ4TmsvOWNQeSs5QTBRK1EvWU5pS2swalNLTzlhZ2dFZkNya1U0?=
 =?utf-8?B?OW9pTkRCNkh0MURUNnhmTFBhdVZqNWhJNVNwaG05RmR2djYyMzVvVFp0ZjBI?=
 =?utf-8?B?ZHpoZ1cxNk90c1EybEw1SEVwT2I4eGFHWWhiOTRUVm5udG1SWjJ0ZjlBTWln?=
 =?utf-8?B?WUo0UGxzZDJJZXB6NEhDVlhwY3oxUWkxMVBqLzYzeUZKME90OUo2QkFWby9E?=
 =?utf-8?B?cWdpU0RmUFBaTVV6ZGd3OElkRWJGT2xKNHpUOTR5ckR4SDUzaHN4aGs4bkxJ?=
 =?utf-8?B?Q1ZqMjYreFZhanc1M3FaMzFLL0FOTlNEVEtXTjNIRU12NWU1VnpyU3c2dDRF?=
 =?utf-8?B?WTZ1c3FGSWRwdGE4NVIwUnk0azZybWs4L1dYT1JWUWo0RThaL0JUR2g0TjU5?=
 =?utf-8?B?U2p6WnBmT2RTNFpzRG95c0JZNGJzeU9pbzd4c2ZEN2xUcDk0azZLS2FjNWRD?=
 =?utf-8?B?RldhdGxrVitvRWw2MVZzYmcxWE8zK29WQUs1VHJsdXB4WlRXRXQ1MUExWjlU?=
 =?utf-8?Q?jquQGd6l0Vw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpoZnlaWU5YUkRTcWQrOExzSVdZQTN3ZnU3RTlQdjdiSFloTGFNVHdScktB?=
 =?utf-8?B?dzJTUjFzMjBpb0grNUtvMVBEQWhsdG9BblVmc2VrWjdCRnc5c0Vxb1Bwc1lM?=
 =?utf-8?B?NkFnanFwZkI5ODhza0U3bGVFLzJqV0VDVXdJMEZqYWZKcHY3S0hhcFM2NEls?=
 =?utf-8?B?QUhzYVl5SU5rMEE1dEdrcTlaVUJNNy9QMmtFTStOWUo0RXdtdlN0UHlLWlBs?=
 =?utf-8?B?YkZxTUNRaHhUakUxaFJhQStEckU4SXo4YkVuNEh2ZVpTYktyQ1VaNUdTeHRY?=
 =?utf-8?B?NTBBenhYWUZOZm01RStTUnYrdnBnekFyUHBPNDVhbWw1aTU1aHd4eGN6Ulph?=
 =?utf-8?B?Z3cxVjNETm4zVGpkdTQ3WEVtWHoxT2U1OW9EMmorVW1aZmorbERjbkJuMFRm?=
 =?utf-8?B?aUVuMm5HQ1RHQlM4VlBvUTZmV0ZCYmVzQkZGeW5kQUR0R3QzVmJHemR3RVhO?=
 =?utf-8?B?T2kxY2F1dm5hZllDbVZ2cE85Z3hwTVRWOEJFZk1BaEI0dU9QRmN4MkpZeTYw?=
 =?utf-8?B?Q1YvUGtOdGJEblhkdFdRTHdPOUZEa2V6UkV2N2NWTFNrSmswekFVNUE3Rk5l?=
 =?utf-8?B?NnFjY0dKSkc3L3p6bG9FQVN4Wkl2TkU5U2F0UVdQamZZZVE5QVNTSG5MUjRa?=
 =?utf-8?B?TG9pOVVxekV3bHppY0MxRHFvbm1lazlBTEhWaGZ0WTNMalpySi9ZbVhBaFZX?=
 =?utf-8?B?SHgrcWpoclNDNzRlb251Z0RFVER4Wi80a25ZK2toT2dLTllLU3BnQ0RQZjRM?=
 =?utf-8?B?OHhLWmFOVEVJZG96R0tKMVFrcjV0YytubG9OMFhVdDlrMCtsYW80RVlwVzFU?=
 =?utf-8?B?MkRZdWprSndqZHlmSklmVjI3QmxCMFFDRndnMnh5S1RCSkNKeU9ERi9XL2s4?=
 =?utf-8?B?MjRxS2tqZzdTM2RKUWgzayszdnliclZzTEdwK2E5TldnSWNCemVoU3BCRUxp?=
 =?utf-8?B?S2ZsMUVzMTNiNlBDdzY0R3FacVNvQUY1RGNZWE51b3FtbVJ4VE5rcFVVS1Ev?=
 =?utf-8?B?NkR4NW5GdFR0Q3FJWWsxUksyaUxhUXdQc2ROUVZwbVRYOGorVThPd2VTWDhC?=
 =?utf-8?B?UzN2T0YyY2RSL1JGWWV2WnFlMGtqUlRnVW9nMGI0L3I4aWR1UDZyM2tnNFBt?=
 =?utf-8?B?Q0NacFJyUjJ6UXVLTU93WVZ5OGpUamlObUoyMWtHRFBxZFpFK1ptRG84T0RJ?=
 =?utf-8?B?VW9GV0Y2WEZkbXovVitlaGdvUkwxK3ZMa3hHdU9RU0FuS1ZKZFJhbk84U2xI?=
 =?utf-8?B?dnlhdU0vTm9kTnVLT3Q2U3VlMGpTalRDanNKYUg1cE90NXFUaWNoZFJkTDlK?=
 =?utf-8?B?YklwYXZJbUg0QXhQRG1IQ1ZpeGZuY1kzZlR6VngydmxucGo1ZVJNM2g0QkRn?=
 =?utf-8?B?RUltYU41ZDJ6UDlCUnRwMTVkbGtTWGUzSVFtaWJIWWZQWmk3aXJCM2xhUXNX?=
 =?utf-8?B?bHFrREtaT25IOFhlVjRPdldJRGN0NEJ2V2hFQ1NCT2l6SU5yQnh2c0NMcytx?=
 =?utf-8?B?cTcrZHFCVGdEcDVxdVgwTFJtdFBPV3ZSMXFkTXpUcjA1RGFJdm1CTjh2U0dz?=
 =?utf-8?B?MzRDNlpBOUtaYXN4blZKc2xDRUt0Unh3aVBRa3F6ZlU3VU9MdVVNVUJERG9n?=
 =?utf-8?B?QStWeWtJRHoyY1lrbzJHRVZvNCtRZ3JDZzBQMEZLb0p6elJ0eTB0YTlXSjJX?=
 =?utf-8?B?Vmo0NmZnRVRETUJhZEhCMTV4UXBLOTFISnZNSUhmd1pkdEhHUDA5eGYzUDBB?=
 =?utf-8?B?MmlOWXVBL1Q1dTFreFoxdkFHek5uVHNoL3V0RVl4cktMcU5MMEI5MG5MWVEy?=
 =?utf-8?B?L2lHYWgrY0xBbHRlY1JwNzdsTGVqMXBWZ2piYXBPdHRhQi93bnY3YzIvNzdr?=
 =?utf-8?B?Q29FeE9OZmYzSHJaTThLUzRQR2N2WVlQeDgwM1JudWpTN3dQK3lqa3FrNmZ6?=
 =?utf-8?B?REg1Wk9qT0FxRXFIWEpPaCtYUmdBdDZLb3UyRDE1REg4NnNlcldNU2xUWnYy?=
 =?utf-8?B?dlJIdzBTTXRNZlArYjRGWGNoU0NtNS9iazVjR2VlcEErei80bHJjZVlHNlZv?=
 =?utf-8?B?RU1rR01uZ3AyTzFNVG9aN25nWEQ3TCtBQ3FEWEs4eE9tak1paGNqa0dkZmg1?=
 =?utf-8?Q?L/GlYzzdPOcouVKKritYd0EX7?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d0254e-9bba-46ef-1dfd-08dd93c76978
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:43.6030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9gFaQ3N69vWbk9WZ76dFUxOgoMP607AvI+t96YNuFlDdB07EHy9l8dKwMxK1CrxBDQbqIJtTfGHNRdHTVmBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-GUID: 2uj7OV1uuqq7eeILh-QogCdZPPaWtTM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX1r6g5N3rAFV0
 F1z7R5E7bfOcW8V0od/i57eqd/PyhGJbi+3iz1LwwLkZfAAOODO+lYAnLBzE5hBF1wmSLnIbDdT
 khPlrf4GT0IQgzt9XhHhqLwf5iS3fM9jFAHbOxj5TZA5lWMTIuj5b7sJyB1Zj2J8o7HMPYUk5GQ
 W+PAFumXJkEzihd8U+zWlBAQbR85+KrRyONA6Rvl1kblMA2d1RmeouhDx95tA/WavtLHUgvwcr2
 yEuFSTPwSq5xwHSLWCgz+FyCfr4ep+RC7A1qaDxwj17m1BUdDrxcBarIwEuZWrjSaGTuOslg29t
 qpvqg51oVz6F1ZDEoOodsC+cUpDBnyldU4r7ED1xQ8THM+Gznkp4zzFhrCLjIW1OT2ICAZxe8sQ
 tNOHi59/GaYhsybsa+kUTvnXvYqxV8bIY/Zxgvf0UAw5GVhebh2p4+nkXTNPYJHjHQb1Ih5F
X-Authority-Analysis: v=2.4 cv=cNrgskeN c=1 sm=1 tr=0 ts=68260bf3 cx=c_pps
 a=OYTBATO8h6EMnG+Ds1NGug==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=BurPQXY8rhTUgOTzSGEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2uj7OV1uuqq7eeILh-QogCdZPPaWtTM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Introduce basic plumbing for vfio-user behind a new
--enable-vfio-user-client option.

We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
container type for the "IOMMU" type "vfio-iommu-user", and share some
common container code from hw/vfio/container.c.

Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
sharing some common code from hw/vfio/pci.c.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   2 +
 hw/vfio-user/container.h              |  25 +++
 hw/vfio/pci.h                         |   6 +
 include/hw/vfio/vfio-container-base.h |   1 +
 hw/vfio-user/container.c              | 212 ++++++++++++++++++++++++++
 hw/vfio-user/pci.c                    | 146 ++++++++++++++++++
 hw/vfio/pci.c                         |  10 +-
 hw/meson.build                        |   1 +
 hw/vfio-user/meson.build              |   9 ++
 meson_options.txt                     |   2 +
 scripts/meson-buildoptions.sh         |   4 +
 11 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 71a7819448..c3d224e54c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4229,6 +4229,8 @@ M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
 S: Supported
 F: docs/devel/vfio-user.rst
+F: hw/vfio-user/*
+F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
 
 EBPF:
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
new file mode 100644
index 0000000000..3cd3303e68
--- /dev/null
+++ b/hw/vfio-user/container.h
@@ -0,0 +1,25 @@
+/*
+ * vfio-user specific definitions.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_USER_CONTAINER_H
+#define HW_VFIO_USER_CONTAINER_H
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include "hw/vfio/vfio-container-base.h"
+
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
+#endif /* HW_VFIO_USER_CONTAINER_H */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7a03d24805..c5fc4aa500 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -215,6 +215,12 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
 
+void vfio_intx_eoi(VFIODevice *vbasedev);
+Object *vfio_pci_get_object(VFIODevice *vbasedev);
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 359b483963..0d3f6a70be 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
new file mode 100644
index 0000000000..2892845b4f
--- /dev/null
+++ b/hw/vfio-user/container.c
@@ -0,0 +1,212 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/container.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_user_create_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_container_connect() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_user_container_connect(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
+    container = vfio_user_create_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    if (!vfio_listener_register(bcontainer, errp)) {
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_address_space_put(space);
+
+    return NULL;
+}
+
+static void vfio_user_container_disconnect(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_address_space_put(space);
+}
+
+static bool vfio_user_device_get(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_device_attach: attach a device to a new container.
+ */
+static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_user_container_connect(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_device_get(container, vbasedev, errp);
+}
+
+static void vfio_user_device_detach(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    vfio_device_unprepare(vbasedev);
+
+    vfio_user_container_disconnect(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_device_attach;
+    vioc->detach_device = vfio_user_device_detach;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
new file mode 100644
index 0000000000..0525becb33
--- /dev/null
+++ b/hw/vfio-user/pci.c
@@ -0,0 +1,146 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/vfio/pci.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    char *sock_name;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_intx_eoi,
+    .vfio_get_object = vfio_pci_get_object,
+    .vfio_save_config = vfio_pci_save_config,
+    .vfio_load_config = vfio_pci_load_config,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    AddressSpace *as;
+
+    /*
+     * TODO: make option parser understand SocketAddress
+     * and use that instead of having scalar options
+     * for each socket type.
+     */
+    if (!udev->sock_name) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
+        return;
+    }
+
+    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
+                       vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
+                       device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
+                       sub_vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
+                       sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+};
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+ type_init(register_vfio_user_dev_type)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 84daac5f2b..ef4095b3ad 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -103,7 +103,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2629,7 +2629,7 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
     }
 }
 
-static Object *vfio_pci_get_object(VFIODevice *vbasedev)
+Object *vfio_pci_get_object(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2685,7 +2685,7 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     }
 };
 
-static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2693,7 +2693,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
                                        errp);
 }
 
-static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = &vdev->pdev;
@@ -2895,7 +2895,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
diff --git a/hw/meson.build b/hw/meson.build
index b91f761fe0..791ce21ab4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('uefi')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
+subdir('vfio-user')
 subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
new file mode 100644
index 0000000000..f1fee70c85
--- /dev/null
+++ b/hw/vfio-user/meson.build
@@ -0,0 +1,9 @@
+vfio_user_ss = ss.source_set()
+vfio_user_ss.add(files(
+  'container.c',
+  'pci.c',
+))
+
+if get_option('vfio_user_client').enabled()
+  specific_ss.add_all(vfio_user_ss)
+endif
diff --git a/meson_options.txt b/meson_options.txt
index a442be2995..97d3db44cd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -109,6 +109,8 @@ option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
 option('relocatable', type : 'boolean', value : true,
        description: 'toggle relocatable install')
+option('vfio_user_client', type: 'feature', value: 'disabled',
+       description: 'vfio-user client support')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index f09ef9604f..2c5673769a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -201,6 +201,8 @@ meson_options_help() {
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
   printf "%s\n" '                  VDUSE block export support'
+  printf "%s\n" '  vfio-user-client'
+  printf "%s\n" '                  vfio-user client support'
   printf "%s\n" '  vfio-user-server'
   printf "%s\n" '                  vfio-user server support'
   printf "%s\n" '  vhdx            vhdx image format support'
@@ -529,6 +531,8 @@ _meson_option_parse() {
     --disable-vdi) printf "%s" -Dvdi=disabled ;;
     --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
     --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
+    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
+    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
     --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
     --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
     --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
-- 
2.43.0


