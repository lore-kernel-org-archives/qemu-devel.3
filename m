Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC04CCA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQer-0001Z7-BP; Fri, 22 Aug 2025 08:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQel-0001Xa-8t
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQee-0000eT-2K
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:03 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M8V9UG656748; Fri, 22 Aug 2025 05:13:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=p833WsOxjGEEWpUKPWpxdnHFs0t8JtXrvnTNCtTlb
 Rg=; b=G/vFzqPdcN98RTyBb4vEINg2ilQbFCTyZK+m8NXnMQOWyHvCBLd7+NDer
 7hRyNKnkvr5qxF5RcgMpseAgiq8hnnqWkSxObUXqWMGX6BGAXkuKCcT+3RCBdUAN
 LHk2PNKMyY4Vp9rpZfTYobrFWyXIPhIE9DZKLCXyl4J6Due6b1bdKzbYCqX7G490
 FpKaR7Zf4wpAOCURufSrpTMcZ+mA4G0IS42Ggtek6Jp0Qqr63XYnmNuGBQgCFos0
 HANvUf4J+S7wHmKa5J3fwE8JJdCaRH1lamea11sK6mljikv+ovsu+GXQZMhDxUMR
 AMLrvWOjFNfY7OA+WX+eRSPe7LNnQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2093.outbound.protection.outlook.com [40.107.100.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye7yjek-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKXs0r8NZR7SDUajifNRdU0HAdHROb0vuI6NY27cdTr8X5MP3vmYORf78HMskBY5JqFVKy+WYi1IxNN++fTAVszfSJqmM/R5X1SSGqpkQBl4P6eflMTdud8+g/V5lXoqpNTH9+mJoyY5plyr0xdT0uac88WspFpWgWMVsw9TvdhJp0blVtsiXvgvSvVu2uGgEih0/JtJR0fGTkxte2qoT5tFw5gD/vZ8Q25hB9P9/AACx5qEc83ov7mTtnG5GG3hoB0282qp6R28Qh47GZlHZ9/YoRMzwXAiBV7uLE96OFm1oW2pux9IUalH/Wm9KCkR/39lUdVTZYV9KwMJJhHyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p833WsOxjGEEWpUKPWpxdnHFs0t8JtXrvnTNCtTlbRg=;
 b=JY7MC/vmQz9O9L0T77Lat3iy35f0Iotu9MP/pu931eOfl907N5lMAGAYfMwkUG0MY70KCZNFYM3BJ9F2tZoL56u1W02Ff8yOjIFA5Bd20Y7p6VTk7spEwjjixL+mL/LqPMEouquTtworlD+Eb5hP2DzTMC7cgaQr7ktN0zAHeJ5IFUBQQkzKRlu0l31L/n92C5/mEEwTNELMzAMibFJKI0LIAym+xQrsy9LktabTyC/9deGgvoT55LwMKRVnfgIwK0adNEMpj6/RKIL2SOakOuujsPvduSpNnsuW3oao97jAJqZ/vrXqntK7UE8q6mg9xovBr4iOhs5glXkDRCZhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p833WsOxjGEEWpUKPWpxdnHFs0t8JtXrvnTNCtTlbRg=;
 b=wgFiV6zlDjsvP0jVrp0nTcn21N2QwZz4JWxwrTYUEagEMth+CFTxlSNDwlRjNfsBGUhxuGXkq2DPAxz0Lw2xEvBDRUgNZhd6/jFJSod/o04qCGEhNJMmMd6K1yFs7nCy5G0j94fotDgY6T0/xx+He8jeofjgQrG1FxR97fssA10vpbpyIsO6NHKzM1eaF8WN9kPmjewf1L0KLZQLKC7VBJrHr5N0p8XamGBcYAVbYPcbWsxz87sTiagJFpLicxqLG9y81ifxMifg1apVg+s3FH+/0gPVo04Mp/2HD3zBDs4OYcoXTddIoEktpHEG0VvQhlm+JUVsXs1jz4f6kTPdjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6505.namprd02.prod.outlook.com (2603:10b6:610:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Fri, 22 Aug
 2025 12:13:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:13:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 03/19] hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into
 pc_xen_hvm_init()
Date: Fri, 22 Aug 2025 13:11:49 +0100
Message-ID: <20250822121342.894223-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0043.eurprd04.prod.outlook.com
 (2603:10a6:208:1::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbb56af-adf9-4675-5c79-08dde1755e6b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDlZRGdjUmREbjRNSk1GNDJyNklOclBlSW5obnB5SE5QMnRTSnM3WkFOdi9u?=
 =?utf-8?B?aFd3S1R4b3Mra3VNR2MxMW1CVlc4Q0NwOHFaNnRHQWlveW5IalJkWHlzMENr?=
 =?utf-8?B?dGN6WnA3RFB2eE1xQk5YRVZSaVdheEFKMjNQcnU0ZjBlRUJ3VUptV0d5MGg3?=
 =?utf-8?B?Q2JrTHNkMzU1T21EOExJY2hVOXIwVDN2ZzltQ0U4VzhoUnBCc0U0ajh4ejF6?=
 =?utf-8?B?SG45cDJ2L0dVVUdQR1ZvWFlQWWtyMnR4NDdkeVF3V2FSM2hLR0Q4OTgwSk9j?=
 =?utf-8?B?YWVEVHp6NGhmRG9wVEJ2YnhIWTFiNTNQV0tXWHpMSitkcmkwZHNISmtqZkhW?=
 =?utf-8?B?VXRRRDEvZ2VNZ0kvWStLZzNtdC8rN0kzempUeUVnSmxsYlhqVmpQUk0wOXcw?=
 =?utf-8?B?dnc5Y2hUT0dDeFd5RGJ5Tk1yejd3QUQ2bkpuZFY3OTUzbDBwZTIwSXJKZDVu?=
 =?utf-8?B?cTJhc21CeC94cThhakg4NFZIV1huaWtTaU00K09nZnFIcVFvcVJoYitpVzAz?=
 =?utf-8?B?eXF1UHNsK2JTQThESlMxVlhMTTkwNUVLQ1owWjRPNEtOaW1aa0k5UTVsSGZt?=
 =?utf-8?B?NkNwa0ZOLzVpd2diemNPd0xIRllCRUlna2hwMDhBeE1zNE05Uk1yK2hJU0dv?=
 =?utf-8?B?enBjTUtOWk1qb1RFQ1pSSXhCTmNPSzlEQ2h3V3N5eWYxSmphVTJHcDJYc3lT?=
 =?utf-8?B?QXV5WDJQVlZlZE1ybVdoZHdTZ3ZZNmd4ajdHWlpUYlU2b2ZCNE1HYW5RUzZt?=
 =?utf-8?B?bm13akp1S2h2TXlkM0l4eitFKzZtOTBDVTNVOVVIUUFmUGkzdXNqWGpQMlRx?=
 =?utf-8?B?S0k5bHg2cjFzVTZUSTBWLzhBWEhEb0VMV0R6SmtVbk9UMUo5UEFMa0gzdFA1?=
 =?utf-8?B?aE9LbEJBSzdxWEExN0ZONmcwUzJpZTQ1RXZ0K2lCVVdGMk8zWkJmZnhpaSs5?=
 =?utf-8?B?eU85bTl1dnNVSzQ1UFY1Q1JnUTJxTCtEWWhBaDZFQ3hzakYrK1Y1MHBLUmQ4?=
 =?utf-8?B?d3k4N3k5N3g2QjRrMklmSys5WUxRWVl3Qng4akY0eDRtckszZU55eUxoQW1F?=
 =?utf-8?B?MTFlckw1aXJIcjBWcktGVzBNejJ6WkxxaE9lbStYUHpXVlZKbGwyUmpjZGRI?=
 =?utf-8?B?THRrSi85S2pkTVVJZ281TXhja3l2WEQrdVpNVms1V2IyOVVUOVNjVmM5QVBZ?=
 =?utf-8?B?bkZ3WWtOa3d1YUxXakdxeGtkeVJ3Vzd5VE5UR0RoUE4wUFZSMW52UCt5a1ZM?=
 =?utf-8?B?WVFDcUdmY2h4cHVFUFl3Sys3a0NpMEpsY0lIbzhHUHhnVi9WWTRiK0xzNW0y?=
 =?utf-8?B?ZFhoYU9PRjY5QWVqS3Nsd1piOGloSjB5UmJFQTI2cXdkUWFKQS9NSVpGQ09U?=
 =?utf-8?B?NHpaRjRNd3QwZDd5dDlYOUZTbFBodXVZbUtSUUkyVUNseS9XQ0UyQ3MraHky?=
 =?utf-8?B?cDhkRG9xOGRaZVM4a3I0dmxuN3p6TnlmMHpXL2ZaM1RuaXRzUXdhVHB5Ullr?=
 =?utf-8?B?UnBGSXo0T0tBdjNTSVU1MXN1SXBkUHpkc3BPMjQ5WkQ4SjMxS294STAwS2FT?=
 =?utf-8?B?Tkx0WjY5ZGZYb1BOemt0WHZUYktRYktMazQ1UWh2Q0VIREN0TGZXczdUNURU?=
 =?utf-8?B?THdKVlVCYURlVTgvZC9sL1c3ancwQTRrdEVaMDQ3L3dyaXNpelRpeWJ0QmNt?=
 =?utf-8?B?TnJ2YkYycjBJQ1Jub0s1aUZ5L1I4bHg2Q3lUK2dWWTF1UXpUbTluNmhXS1Rk?=
 =?utf-8?B?UVFzQllMcTVkMXFnZVNnOXVrQTNwVTY1OVM4SG5uYUZxU0JLbTRYZVNKNGY3?=
 =?utf-8?B?bWFTaVUySC9ueTdOcTlFdkJzSHFsYU1WbGcwakc0dE1xYTh2Yk40aFVsWkxn?=
 =?utf-8?B?NUMvb3B5ZGR1THJRcnQ0UkJBc2xRcS85MHhXTm8vdFVKL1E4bEZ2aXplWGIx?=
 =?utf-8?Q?k8S7ec7Wki4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lqUEFTeXo5UW1icVVXUDc2eUZCeUxpVzgySVhPdm9nNkRsU01Ebmd6SlpB?=
 =?utf-8?B?Nkh0R0gvOW4vV1RzczhFbm81ckQvdkQxK3VvVnFQQUszQnN6OXFQZDlDRy9u?=
 =?utf-8?B?djJuN2g2SjRvbzQzSXlHdWszaFdlall2WkRNMERUdVRuKzJlNTcyWVhsRk5F?=
 =?utf-8?B?RFBXSGlmZEhja05oTzBiUGROZHUvQy9oUk1PU1V1Zm5hcXRIMDZxckZrZ1Nn?=
 =?utf-8?B?S2pPVkdkbWNIMytLaEtDSnJEUy9UTlgzT2t5bWlpbm1SNnh4TC80R052VWxu?=
 =?utf-8?B?WHZZK1I1VDBkckcvdG1lQkJEOTRyQm4ybUwxcUdqdXloRUd1VjExNzJsNFhX?=
 =?utf-8?B?b2xYSXphZld4d1cvbE4wUk0vbElYNTRSVzh5bGE0djh3L0pQZTJ3b1A2a3V5?=
 =?utf-8?B?KzVFeXowajdnV0l1SXZNSkVPY0hPc1NSM3BuVFpaa0pKTHBQZ0xHcFVaeS9h?=
 =?utf-8?B?L2dVWkJ4UnN5WVBEOHBRU255NHdKQ29UUjFIc0dHdlRGNmxkd3owb0srRW5v?=
 =?utf-8?B?QlRMR1NXMkJkR2pSclhUTWZ2NnZOTHl1RjBnTERiQnI0N2pYa3hkaGpReFVj?=
 =?utf-8?B?dUlVSzVSYThmcmNIRVVkbnl6VzlERmNjRmw5eXAvbHl1dnRBcGJxeG91OEhr?=
 =?utf-8?B?T1c2d2ZsQ2RSTTFqKzVwbmtxdm5IN2NQYkw5Q1lycnlqMXJJZEZ6Mkpka1Z3?=
 =?utf-8?B?andzby9Db1BlRVpGTG9Cb2VvRkc5ZGcwejIxTXVnbWUvaGQ4SC9Jd25meUlY?=
 =?utf-8?B?UkNNT3FXMnAyT0Y2aXRCZWo0UzNtd256a2FjN0gxWlRtdldzdkNQdW5BTGYw?=
 =?utf-8?B?RTFIKzlDQWtyV1ZjR01wNStWaGJGeTFzNVZ6eWdtU0tDdmt0algyaCtRaDV3?=
 =?utf-8?B?VFJGTll5bXJTT1A1N1JiVlZRYWVYaEo4WWxzY2xNcDVlNmxweEVJeC93REt6?=
 =?utf-8?B?M3FHeE1iSks2QW5EUDJBTnBPa2VYWlovTVlWS1pYRjE3SlpOaS8yMGFudSto?=
 =?utf-8?B?QUMxOTBOZUNaWStta1VhMGJTeGFnYkUyZFN6U25aRWZIS1Q4VzlPZmdyNWdp?=
 =?utf-8?B?Q290SlE5bzk2UW53YzhyQnhIL3hTSFF2TEpYaHIrckMwT0RtMUg1UWlZOHNK?=
 =?utf-8?B?RVZ0N1ZYb0NlRGp1OHE1UFRIYVU4bEx6ZFJEM1ViZDlmL3VuOEtzN2ZaaXRk?=
 =?utf-8?B?ZlBIM2sxYnBzOFh5WGkxbXVyazhHRzZZSlhESSt1RjJuRWFtdGsvSzRwVUhy?=
 =?utf-8?B?L2Fqdi9MQmYrV3FlcDVJZ0t3WGQ3OERWNEZHS3dPcFBrMklMUTNFekw2WlJL?=
 =?utf-8?B?dGJlM01kdmZWMzh1dER4ek1CRGtoOHpOVjZsMklVeC9reTZQTEs1RGQ2U2hR?=
 =?utf-8?B?TjloNHc5WjFSTGVTNm1UWVNMM1JkMFpweUtnU2tTS2JGZUs3OGNKWUdIbTd6?=
 =?utf-8?B?bEQ3WmpEMTgvQXpVK2FkdjE5eGdvcTA5QTZKNDU4cm1pS1czcmNUY3pHOUtU?=
 =?utf-8?B?TDJCRm1mR0RqdDhjV08wd3lCb0J0RjFkM1hZdkRYd0tqTytnMWx4WnA3MERW?=
 =?utf-8?B?THlqaE9zUTRlMENaUFEwVkl5b3BodndqRW9OQ25Cd0VRbEE1Z0JTLzR6U0dn?=
 =?utf-8?B?eFNMcUp3T0tFdktWaFloaEg4UmlYVzFxZ3JSREtCWFlnQnZ3dmlmMG1Mc0Vt?=
 =?utf-8?B?aFdMcVRVUCsyYnNPa0lsNnFkZjNTRWNaaW9FRzg4Q3ZJTmlWNWtraVVIeVN0?=
 =?utf-8?B?QzFFTjdQcVBJZmVXaElncmdCbE5oWkJJd2dodmdjdmQ2SzduUEZST1R5Q0dz?=
 =?utf-8?B?YkNFSmpVdWVmdlBvQ0UyaTFQbFdwdEJsV0hhTE9iZWx4RHl1aTk0VG9FaXZx?=
 =?utf-8?B?ek13anNMdU5OVm9VdGhjUU1lUmhJOHM0eldGc0lDcWFkR2xKR3NjNnJjbkE5?=
 =?utf-8?B?cXREQ1ZqN0lYbzNBdCtJODRpSDUwdzIrRy8xZkQwd2xRSEdnYmc5a2dtUzJj?=
 =?utf-8?B?ZWhOU2hEV2xnd3dqYkxzZDNPb3VGanEzKzhmZTA5MGp2d1gxLzR0dVl5OXpW?=
 =?utf-8?B?VkI4eW5SRXQ3U0xpZmtSeEorRVVIM2JCUEFOYnJrQWk3dEkrdFR4bTJhZTJi?=
 =?utf-8?B?SEpRZUwzT3FLQ0h5WWFkaFgwTnIybGtPTGE0eVhIOFJkUGU3YnZUSUlMZHdG?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbb56af-adf9-4675-5c79-08dde1755e6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:13:57.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikGb1JTM3Xpif7O4k3aYTIzyL7n2kNyuDYz/cFUyEU5A8E2arz2LoCeCHnL/nG44gA8PRFVwzbEz9uHeiRqTsbs8OCQ/rosu8xcmF85Vy3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6505
X-Proofpoint-GUID: VRG6Wx73kdJshPDzIPbeu8hxAOPnR7F0
X-Authority-Analysis: v=2.4 cv=CoXmsn4D c=1 sm=1 tr=0 ts=68a85f06 cx=c_pps
 a=mCqc6FuyCKsbe1oGyU/0mQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=Nl9WzMjVwZFxynAfEmwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX6cdVl2f+cl0b
 yNVlVoDgGYu4sMPi+xFOCzh2mFK7RQz2h6kRhtZvbkzo06u1uvj5zTybPI8MbKzID8BGLjkGL1f
 WnTzRBqsc56iAc5O9nNDw4ieAtgOt9WHa7VT/v8iXCFYollPUPQwpTuS3BI5d1xVf9KPrQ5SZ/y
 hFjXsO1tInj0efQXtq0Dv4/oPympddxD6RY8QhncYNgB6dFNnJIjtT9VjSKVNsC8O/Sm7cB9JKc
 agnYLNWPkaVFmd4MmcknQW/C7Xtx6sSg/mREliTzvzNcJ/3Qf+XKa1gHo0ZRQ7bh3C7mGKMmqjY
 BxLUldm1ItrUuh0xGLV8H+miiIX+sB6TrdnCxG7SQ2jkd1XIXy5w9wvGThUMio5L+15qu/+Ifpb
 Z4/YdBnVchX8gC6P1Y6HIQeeNNq8/g==
X-Proofpoint-ORIG-GUID: VRG6Wx73kdJshPDzIPbeu8hxAOPnR7F0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This helps to simplify the initialisation of the Xen hvm machine.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index bc8fbe46a1..071bf7412e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -453,14 +453,6 @@ static void pc_init_isa(MachineState *machine)
 #endif
 
 #ifdef CONFIG_XEN
-static void pc_xen_hvm_init_pci(MachineState *machine)
-{
-    const char *pci_type = xen_igd_gfx_pt_enabled() ?
-                TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
-
-    pc_init1(machine, pci_type);
-}
-
 static void pc_xen_hvm_init(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
@@ -470,7 +462,10 @@ static void pc_xen_hvm_init(MachineState *machine)
         exit(1);
     }
 
-    pc_xen_hvm_init_pci(machine);
+    pc_init1(machine, xen_igd_gfx_pt_enabled()
+                      ? TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
+                      : TYPE_I440FX_PCI_DEVICE);
+
     xen_igd_reserve_slot(pcms->pcibus);
     pci_create_simple(pcms->pcibus, -1, "xen-platform");
 }
-- 
2.43.0


