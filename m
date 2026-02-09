Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57376E7E0AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 10:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpO5x-0008GG-EF; Mon, 09 Feb 2026 05:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vpO5f-0008Eb-EN; Mon, 09 Feb 2026 05:02:01 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vpO5c-0006Vx-HJ; Mon, 09 Feb 2026 05:01:59 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 618M6o9w2694890; Mon, 9 Feb 2026 02:01:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eGzG3px0/1nt+EJinCZoPxjpQPG59e6ipUmCwyx/2
 LQ=; b=e58A06lJ+d/Sl4/HlkPtXtSqjzSfLKYymMASxSuhBbF6HttP6LS97kFFb
 sFLYLzjle/D8PlDj0fYA9e6ocrYeL0nPagGIuqh1bKGDxXkDLF6uFeIZrb7UyAyT
 viIvdjJf/ai722+rNlJutuAt+bG4Ap/2/5orKbMBAM2Nwr59pDgGdR3e1NHN9t0e
 90jiGgWKJVmnu6nRcnY3nGuaYqqUCKSwEUOe7ORC+wOEyIKzy0usq7/lw2bawoch
 xSZRJLCQjlW2OOUl8LKHIVO2t/bCFZNOEhPdLakhEN+oKkbDsgbbo4pORco701fA
 5XUJ028jEnmstFN4F+a47w5vnIfUQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022141.outbound.protection.outlook.com
 [40.107.200.141])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c6268b1bp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 02:01:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRD+V0cYTlnmrab8I7Co6HAGOFGz08gFtqra3ca7Gvmf8X4Ofd+r3E2pEFbBaY3N2y61DZeYcZ6U81xScs4w44EhTvy9zA3h5DzmgkLFJCzSh6E21TPI/zqaQAL7EOYQcEvBf4LAqYgAvgqrj+n9PjXwvU8MtZDyU2kL9YLlFW4H/5QsO4fKYkEVH3pjzpaiGap5oEfuSO/rogXbgQhWaU0g/2BA52YsWMCsg4PsZkJIz7lsMfjnFRfWymgMFHBYcaRDKx7zdTQt5NqTTmUkUFOS+d0fxUa5qKYjDtGa1hyi+5gfgbYUEFw9jFBi6WALQDM03qXLhmdMD6GQ3zCzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGzG3px0/1nt+EJinCZoPxjpQPG59e6ipUmCwyx/2LQ=;
 b=mjAoMYmyJUr09tN98lxgFnJCYnCd5SvkSfSptx3pF3tK3QhMGhCBcv9ZOYAP9HVhnKuLcwL94aqn/C0OMzB5Wa5shL5I4drkHdW9PMEV53DntCM5O3TUa2YhytDFudd8DNBjS4TeAIRcu9ZXPcM8nsssBli2A7O6lGZmpRNT7qq/+DfOYKcH5prPydY42ZtFFKtRIujagg5LmILQQ07pcoFpq0+92PLgl2u97s2C3yLlvrtGDfsZBOyaqNfub1s+2+JtvWAKw+p03N36MF25T/emVdHUb3THj3+7fN2HY+BVDLYHV8/LHbWYpQLx/0xA83nIBXRsQhEJdRcXz1g1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGzG3px0/1nt+EJinCZoPxjpQPG59e6ipUmCwyx/2LQ=;
 b=MHTbRSSjapNl+lWGyQFIJ8C7B4e78XJMlFRgi2hkXOxNMX/ctg/TPMtu9SnNQT3q/wVAeM/CHrbYKWpR8mfuOXMFQVGvLa6O8mGXzbvKjqat/xc4HBk7pRKXdv+YK/uuODxh/bD4rk1gw3fX1wxz7z2iB+Gda9tPZapRHMliNnnQw/uHhz5KyiQx/xGgxLA/DWDgyqrd//q90uYlrpaGSiItATlMI7RwyL0tF6Z48NQjD8P/I1IAJRym3NCz4ODg+B8p4XSUIWi38zGJpvAfL0mFUIjewkAgtiUUqeXnNlbYWbk+mqOSxr3IyS42+F4dg6M7uSwUh6kcYUVzPuCgPw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB8436.namprd02.prod.outlook.com (2603:10b6:a03:3f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 10:01:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:01:18 +0000
Message-ID: <a9ff59ec-38c6-41ad-a308-d3433ae10fd5@nutanix.com>
Date: Mon, 9 Feb 2026 10:01:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/20] hw/i3c: Add Mock target
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 Joe Komlodi <komlodi@google.com>, Titus Rwantare <titusr@google.com>,
 Patrick Venture <venture@google.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
 <20260209091629.823457-18-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260209091629.823457-18-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a42253-1ce7-43d4-87ca-08de67c22b81
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDNYVDdLazZmVk1ieU5GZ203Y1dpR3lpRVk1ZVhZQjRnaE5vVXlmNEtxY1Ez?=
 =?utf-8?B?TkQ4UWtxQzkrOGVTWG96NVh2SVVzellMQ2ljcUVNZW5JWWp4K0oyUDFXcCtj?=
 =?utf-8?B?bVFnLzkxY3Rhb21rOFRQcWZjZTFSdGFLV3d3ZnViM2g2aUR0TmJRNzdkekxl?=
 =?utf-8?B?SHg0dDhVMEZtcHp2N0c4djBjY3VWaTA4NUxPVWY3eWVtQjdzTXJINjdwcENH?=
 =?utf-8?B?TDhDdmRDdk90a0ZsR2lCVFZ4UUZhSU5YbHRGYWhsSzZYTEt4ZCtqWGlLRlBU?=
 =?utf-8?B?cjRiUTFYT3Z6U2pMdUdIdDUvUW1WclJhVXI1K3pYd1oxRVlUS1J1b09hdDlU?=
 =?utf-8?B?UytsdnRCUk9wK2ovamtuRzJmQzhtNTA5WWdSY3MvbHpacVljOEZsTDdDWWh0?=
 =?utf-8?B?Vkk1NjBqdjBYSXlNT1gzNEUxd0Y0dkZ2akRvZDE4NnU4RzVMSWJpVWJDM2dU?=
 =?utf-8?B?RlppY24zdUxHYUhYNzM3VklkcW9VTFpXYWUxem42MEg0cXhDc0tSYnZTM25w?=
 =?utf-8?B?ektlNnpRQlVxZU92bTRaVlNIL3V1Ti9lRXV1V2NZNkpsanV0bzY1aklSajln?=
 =?utf-8?B?YmJVVlJrNzFkcW9wZXFYcUwva0luMEl2QWl5ei9yQTRMN2cwVmV6NEVzVGRw?=
 =?utf-8?B?cW0vNEdoNnI3TTNheFVhVFdEQkY1am9yYWtQUXJmM3l2aThJSVptdXdrRDl0?=
 =?utf-8?B?TW5PZEZaVTVkejhOS1BxbWJpVFdSaXlIeGEyeGk5QXZSa2VSMjBNNjNyQ3RF?=
 =?utf-8?B?T2JJekMvNHBRNjNBc1NRMGFSeEJQaEtnRTVCNlhNWm84SlR6OTczWXdmVSt4?=
 =?utf-8?B?QmFGWkMyUGlaSFhzeWI1V0FWM1RrOUdLbFRrU0JWb3M4SE1NVG5IV2grbmZP?=
 =?utf-8?B?MGZ6VkhBcGlOTnNIRkFZM2VDSlVQVGpacVc0alJXVXB4VXgvaVVqOUJPQ0Zk?=
 =?utf-8?B?RWJibHVoYXdDU0NZckY0SlNPVUEveTJMYll3dTJNTkpDbXQ3OGdsbE1IYmlG?=
 =?utf-8?B?UE5hN2ZJd21KS2lGZmpxeUpyUWx4L2E5UTM3cU1SQTdWVDlRYWpUcHl5OERJ?=
 =?utf-8?B?NkJ6c1JQUG9NQmVQMWpKYXluWFJOUEJKUmhpQ1krWWtzVFU2NjlPQ2FhMUxP?=
 =?utf-8?B?RjNMbktaam5JUGU5ck15WjAxenZBYUFYR0pwcW5aU0daZkZBL21oSUNoR05n?=
 =?utf-8?B?Y2p2VkppS0QxcFhSNldKdFYrUUFtbXZ0YWFXYmVlTURmb01IQ21uR3lSemhk?=
 =?utf-8?B?bjR6dy9xN3YzNFppWklVdXVESW0wZEFKWm9OZXlIcmZJSnptbktJTWhUZ1J1?=
 =?utf-8?B?SWVtRlhnM2lUVjBOTzFLUDJCRW43MVlIQXFRKzc1V09KcEJ5clc3c0tjUHR4?=
 =?utf-8?B?UUE4UGVQKy9lcURpK01kdG4wOE9CR2c0Q1FEVnlzTTFQVmxVcURTMkRkcU1K?=
 =?utf-8?B?ZzFrc2VvRW5DZi9lbWNKNXFiSUljQkhtZlc4MGJZLzdqQ3g3MU85RnIyY3VV?=
 =?utf-8?B?YnRoczFuS2diQzB5akNVSE5keWtpRzdCamRuSEMwd2dHZXRvc1NTejd5RXZy?=
 =?utf-8?B?SHdMVUpML2ZLTWY3Z3JuOE0xeXV5eXBZaDlXQVI0VFY1aHozdENXdkQrQTYr?=
 =?utf-8?B?T0djMkpvUWJEUVpjenlWYXpLVTVRaVNSTVpnUm1nOXJSL3JJNGZlQ1pTTU83?=
 =?utf-8?B?STlNVk5oYWpPSWpNK21OTjNqTWZ1OU9nYXNZQnJpeWZJR1Q2VXUrSEtxeWF1?=
 =?utf-8?B?Y0swNmZUajdqOEtobitGSGN0ZEc3K2xSbDJoLzQwekpzUWkwd0NaZjZQbXQ5?=
 =?utf-8?B?Q2RNYWpldVpzMnhzR2kwVXNvV2picU5PZ0NwZEdZQlZzVDB2R0loWFpjOEIy?=
 =?utf-8?B?YW1KaDAxSVF2Mjhlbk9keTRVQ2FuR3BiMWgxRXFselJTd2FpNFJPanh6Rm5P?=
 =?utf-8?B?ZHNHS2NWeDBZWjhiSHlxNVNCSjAyQmtwZHBjNWJmZUpsREZta2xqTUg3YUs1?=
 =?utf-8?B?d0oyTXh6T0FkQ0t3Mk5tZi92WmduckEvNkttaDUyQm56QlJHUzlOMWdnV3Fi?=
 =?utf-8?B?V0NiSi9wRFVKS0poVmQrUDBrRE0yNEtBUGRrTzI0V2xZKzFoWllFdzNaLytj?=
 =?utf-8?B?Wk5VczVZR0ZsaUZxUmtRbzMwK3RFc2Y5Z3FSNE82M0tMOExqa1lFV2JBdEFB?=
 =?utf-8?B?aFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZlYVd3V3NFeGZPa3lxckpyelRDQTVGR2hmN1U2RzE1RkhFYk1yNHl2bS9k?=
 =?utf-8?B?SVRGQWtjWmU0dFAwM3l6WWNJS203STlqb3Bta2R4MGY2QmtNODg2ZjhBamVU?=
 =?utf-8?B?ZzlwRTRIeEpIZVhzekgrVjMxM0N3UEM4M0xDYzc0MndHaU85VUZHU01ZUTFR?=
 =?utf-8?B?REJnbi9YdTRTMFN6Z2pjODQ1TVBaVGRuSW9RZm1TaTFiTENiK0UzS0txaGV1?=
 =?utf-8?B?UThxTlJ1Sm5zRVQwbTlvWW5aeUJHQWFUTWI4VDNoZEVFMnlhYnQ4ZW41SUFO?=
 =?utf-8?B?NG5Xc3BKK1piL3hkNFEzNFJVcG8rdkJucThkQTlSMkRvTUdZSkh0VlZJRDdH?=
 =?utf-8?B?cDFVUmJMTFAxMEd2ZjVSbW1Cdm52SkVMeWhqb2tCaGg1b1FNOTh0Mnc4UFc2?=
 =?utf-8?B?UEVxRTZQcFdRMXdHcVVkYVJ4b0xvUkYvY05weXpyU2JQUURZcGtkU0dyOGEy?=
 =?utf-8?B?cXplQXg5SCtOL3dsc0QveU1nMTRNQy81bkt5alpvVzdTdTFoa1JoMWhZZkRB?=
 =?utf-8?B?UnZYWVNFWnd4Rk4xbExxRFJlYTIxUXFrWlljWGoyY0hvVVBSVnREbXlTZDlw?=
 =?utf-8?B?NXlCZkw5LzFUaDJyRlVna2pRMDNlYUtJT0JjYjQwWkhuNis1QWlISk40Yzdl?=
 =?utf-8?B?Y2FMblJ3OVlsbUZ1aE5WTGNxdjdvVGx2SStlNmNXSlpyRTkvc0hGTXVTaHhV?=
 =?utf-8?B?UmtDbkZOMmR2ZFg3ajc4OGJCMHhRZTVHWVUyTzVMNndNbEpZZW9ZV0ZrR1hz?=
 =?utf-8?B?UzdPcGxMZWNDMDFMSEdRVUlUT2xRNEhaWVcxMTk4REhLbWNNRG90T0FsWWwz?=
 =?utf-8?B?NnBrL0JZbG9hdlhnWEJ2WTM3SFdJRGhuMHVpMEttN1B0cXdBZWk4ck0xSlo2?=
 =?utf-8?B?RVJ5S1ZYWVdyQi9RaFdMQ09KRXVGSlJ4QTlnZ2dyeTNURkNHK2IvQllJZE84?=
 =?utf-8?B?ZFpNT2hJUjdKeFRvYU1JZ1FWek9qeHhROU5ONjFVYzg2a202TDUvd1Zna3Zv?=
 =?utf-8?B?MlJrb0N2ZVF4NnplZHJnb3RKNkpzMHJqU0dmT0lQK3drenFzYk9Va2YzVWl3?=
 =?utf-8?B?QUwrYUJ5eTFndEhaR3l2blBKcFUrVm5qaWtnYzk1V1VwT1ZEdWgwZVdEUlJi?=
 =?utf-8?B?RnIwR0N0WjdDc2RRcWVMRmlVdEZnQ2xYNzkwVFFlTENWVkNIbE9BQXpzQnlk?=
 =?utf-8?B?U1BDQmxsWmlxSzUwenlGMFhEL1VEKzkxNXRrelRuYjhpa3hCNUNTeEpBcERj?=
 =?utf-8?B?aTc4NUxVdGdMT0EvbXFULzRyR25CTTRxWlZQc0ZGUmtrMnp2VUsrY3NFbEto?=
 =?utf-8?B?TXJNaTc5SVdSUWNUWjhRMGViLy9XZ0F0aFhtd3psdDhpYTVTL3ZwRTFkdUV1?=
 =?utf-8?B?bUd6RFZRbTRSRldYTTIyVWsxWFViS3VhRTJkek96dDNTb3p6dTduZGVnSmV4?=
 =?utf-8?B?RGxFYnE0QjRMY0dVbWRNSEFBWGNERVBldVJHNStwcHB1MGk4VTU3WVlRaVR0?=
 =?utf-8?B?eUpsZHE0VXUvNktpbW83MStHNFF3cDhuZzZqNXZmRGN1d1M2Vk5WVFliRnMw?=
 =?utf-8?B?d3RLRERmV3VLT3liclQ0WDlTU1dvc2xmUXk4QllhSWhnaHo2bXd5dllQa1I0?=
 =?utf-8?B?YWtPZzFvQWt6SUcyZ3JuWWJRbWJWQlVEOHpzTmtsYmNTcXVobzBKZC81K3V6?=
 =?utf-8?B?V3hNa3NaMjlTOG9Iamdwci9hL3kvUzJCQTZzc1FNd3hpeGphVjQxbmlzL3hU?=
 =?utf-8?B?VHVUK0kybGMvbVhmbUFIdWxxeWo0bm1CR2pWVkFOYmp0T2R0NjRyRjlSNDdQ?=
 =?utf-8?B?WDREdmpaTXBva0hURDNSRGJVQjZqSlNLYjB0YmQvNjhha0h0YlRuUCtFNjJI?=
 =?utf-8?B?TnJQTW84SlFQcW4vVHdJWDlJbHB4ZFo1cnJxNUhoM1J0c2gwVjVJUmhjTSs1?=
 =?utf-8?B?YlgrL0FSUExQZ2FWL0lqY2psMytEN00vdFJZMlhTOEJuTUtudGlLRnhxSzdH?=
 =?utf-8?B?clVoMDlLbXJLbVhmRUZ5T2tYd3drUStLdld5a1NMYk50MHRFR2pnOCtlWkJQ?=
 =?utf-8?B?MXJZdk5jeTNkTXlWVDNxRU90NElsMDJpNjBzNWdhaFlTbm1OTGZnR05WcVJ0?=
 =?utf-8?B?Qjd6dzlsUzU5U2NxeDgzc2RsMWZvVFRhTHhITHYvRFNEVkFKMjNDeHpXWC9j?=
 =?utf-8?B?WjNPTklkdXVWK1VEYTNnQ1l1UWNTbEV6OVBjWW95NTdTUVIxbVVhODNnL2c5?=
 =?utf-8?B?UkJFYjBxdENPd0dPSDhMTGZFODlqbFJFNEdtUGI0eStMK0hLNmNyZ2tLTlNP?=
 =?utf-8?B?ejNiK3NMZGh4bk1SYUVqUmdRbzRBQ2VHN20rSjEyNUVNbS9UaWpNbFNHa0E0?=
 =?utf-8?Q?IRL5WB2Y3/cbNvyw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a42253-1ce7-43d4-87ca-08de67c22b81
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:01:18.6609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqLEZQq2tvSMgP+7YLDbOCbXlQAsYCWkbzCkEEFTP71Rcn2dZK6Hj7488bbJKql81B454etQAK667ZN8/5Ju1YKDuwf936wNyz/pDXqUFO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8436
X-Proofpoint-GUID: TtqRFrLcfW7KyYchbL-Jv7PGQUGuR5mj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA4MyBTYWx0ZWRfX8QyQ1UBkU29L
 g+Vqtks/1kXTbLQ1RSm4sCklkqgFkX4M+XxiAZHXbMz8ZPe+xfCZYQzig85x5MYR40+2NffkuQC
 7By/q0FM604WMzZSvOJpLoLOlkXcYdJ9RbyiexeLmIu40l9oKCGq7HdFRBhchrDovg9rvOnopia
 OVK5c5+IpZ9IcuXlD8B348p1XBtjvEW/wP2HXsi+SHfjVBBfu2gnigh4S/cETnnqmeFEdgU86Dy
 w9bm9Pn68/jcQ0dw5Gnfy7cX6W4c4IWTKxkSK/OVtjp4/aZTq4GKlLjm742zgSJQXkEa1fmJa99
 b+lF+4L10ZpoYX+uuci9ZCV7PrdF2+9Hf80olSmfnosckNT2KRhcYOw+rOAnyJzhRAAHf+C4uSr
 r4/V4DrLo0bF70Pwc2CEtogI+h1Js47ZJ/HhFOgzU44r1IrKWXoiXDUxOSGfZ8zQsb+2Br4t4CR
 8Zhigm+NPvJgHvHTqkw==
X-Proofpoint-ORIG-GUID: TtqRFrLcfW7KyYchbL-Jv7PGQUGuR5mj
X-Authority-Analysis: v=2.4 cv=GNkF0+NK c=1 sm=1 tr=0 ts=6989b071 cx=c_pps
 a=vBdzEPurzP6004a/ctmFDg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=1XWaLZrsAAAA:8 a=V2NxCb60AAAA:8 a=-SUXa_jBdiUswk93hxQA:9 a=QEXdDO2ut3YA:10
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 09/02/2026 09:16, Jamin Lin wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> Adds a simple i3c device to be used for testing in lieu of a real
> device.
> 
> The mock target supports the following features:
> - A buffer that users can read and write to.
> - CCC support for commonly used CCCs when probing devices on an I3C bus.
> - IBI sending upon receiving a user-defined byte.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> Reviewed-by: Titus Rwantare <titusr@google.com>
> Reviewed-by: Patrick Venture <venture@google.com>
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/i3c/mock-i3c-target.h |  52 ++++++
>   hw/i3c/mock-i3c-target.c         | 311 +++++++++++++++++++++++++++++++
>   hw/i3c/Kconfig                   |  10 +
>   hw/i3c/meson.build               |   1 +
>   hw/i3c/trace-events              |   9 +
>   5 files changed, 383 insertions(+)
>   create mode 100644 include/hw/i3c/mock-i3c-target.h
>   create mode 100644 hw/i3c/mock-i3c-target.c
> 
> diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-target.h
> new file mode 100644
> index 0000000000..7ac55a3179
> --- /dev/null
> +++ b/include/hw/i3c/mock-i3c-target.h
> @@ -0,0 +1,52 @@
> +#ifndef MOCK_I3C_TARGET_H_
> +#define MOCK_I3C_TARGET_H_
> +
> +/*
> + * Mock I3C Device
> + *
> + * Copyright (c) 2025 Google LLC
> + *
> + * The mock I3C device can be thought of as a simple EEPROM. It has a buffer,
> + * and the pointer in the buffer is reset to 0 on an I3C STOP.
> + * To write to the buffer, issue a private write and send data.
> + * To read from the buffer, issue a private read.
> + *
> + * The mock target also supports sending target interrupt IBIs.
> + * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number, and
> + * send that number in a private transaction. The mock target will issue an IBI
> + * after 1 second.
> + *
> + * It also supports a handful of CCCs that are typically used when probing I3C
> + * devices.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "hw/i3c/i3c.h"
> +
> +#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"
> +OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)
> +
> +struct MockI3cTargetState {
> +    I3CTarget i3c;

This should be parent_obj.

> +    /* General device state */
> +    bool can_ibi;
> +    QEMUTimer qtimer;
> +    size_t p_buf;
> +    uint8_t *buf;
> +
> +    /* For Handing CCCs. */
> +    bool in_ccc;
> +    I3CCCC curr_ccc;
> +    uint8_t ccc_byte_offset;
> +
> +    struct {
> +        uint32_t buf_size;
> +        uint8_t ibi_magic;
> +    } cfg;
> +};
> +
> +#endif
> diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c
> new file mode 100644
> index 0000000000..e540a6c2f7
> --- /dev/null
> +++ b/hw/i3c/mock-i3c-target.c
> @@ -0,0 +1,311 @@
> +/*
> + * Mock I3C Device
> + *
> + * Copyright (c) 2025 Google LLC
> + *
> + * The mock I3C device can be thought of as a simple EEPROM. It has a buffer,
> + * and the pointer in the buffer is reset to 0 on an I3C STOP.
> + * To write to the buffer, issue a private write and send data.
> + * To read from the buffer, issue a private read.
> + *
> + * The mock target also supports sending target interrupt IBIs.
> + * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number, and
> + * send that number in a private transaction. The mock target will issue an IBI
> + * after 1 second.
> + *
> + * It also supports a handful of CCCs that are typically used when probing I3C
> + * devices.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/i3c/i3c.h"
> +#include "hw/i3c/mock-i3c-target.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +
> +#ifndef MOCK_I3C_TARGET_DEBUG
> +#define MOCK_I3C_TARGET_DEBUG 0
> +#endif
> +
> +#define DB_PRINTF(...) do { \
> +        if (MOCK_I3C_TARGET_DEBUG) { \
> +            qemu_log("%s: ", __func__); \
> +            qemu_log(__VA_ARGS__); \
> +        } \
> +    } while (0)

Is there any reason why these shouldn't be done by trace events instead?

> +#define IBI_DELAY_NS (1 * 1000 * 1000)
> +
> +static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,
> +                                   uint32_t num_to_read)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +    uint32_t i;
> +
> +    /* Bounds check. */
> +    if (s->p_buf == s->cfg.buf_size) {
> +        return 0;
> +    }
> +
> +    for (i = 0; i < num_to_read; i++) {
> +        data[i] = s->buf[s->p_buf];
> +        trace_mock_i3c_target_rx(data[i]);
> +        s->p_buf++;
> +        if (s->p_buf == s->cfg.buf_size) {
> +            break;
> +        }
> +    }
> +
> +    /* Return the number of bytes we're sending to the controller. */
> +    return i;
> +}
> +
> +static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)
> +{
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    timer_mod(&s->qtimer, now + IBI_DELAY_NS);
> +}
> +
> +static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
> +                              uint32_t num_to_send, uint32_t *num_sent)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +    int ret;
> +    uint32_t to_write;
> +
> +    if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
> +        mock_i3c_target_ibi_timer_start(s);
> +        return 0;
> +    }
> +
> +    /* Bounds check. */
> +    if (num_to_send + s->p_buf > s->cfg.buf_size) {
> +        to_write = s->cfg.buf_size - s->p_buf;
> +        ret = -1;
> +    } else {
> +        to_write = num_to_send;
> +        ret = 0;
> +    }
> +    for (uint32_t i = 0; i < to_write; i++) {
> +        trace_mock_i3c_target_tx(data[i]);
> +        s->buf[s->p_buf] = data[i];
> +        s->p_buf++;
> +    }
> +    return ret;
> +}
> +
> +static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +
> +    trace_mock_i3c_target_event(event);
> +    if (event == I3C_STOP) {
> +        s->in_ccc = false;
> +        s->curr_ccc = 0;
> +        s->ccc_byte_offset = 0;
> +        s->p_buf = 0;
> +    }
> +
> +    return 0;
> +}
> +
> +static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,
> +                                           uint32_t num_to_read,
> +                                           uint32_t *num_read)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +
> +    switch (s->curr_ccc) {
> +    case I3C_CCCD_GETMXDS:
> +        /* Default data rate for I3C. */
> +        while (s->ccc_byte_offset < num_to_read) {
> +            if (s->ccc_byte_offset >= 2) {
> +                break;
> +            }
> +            data[s->ccc_byte_offset] = 0;
> +            *num_read = s->ccc_byte_offset;
> +            s->ccc_byte_offset++;
> +        }
> +        break;
> +    case I3C_CCCD_GETCAPS:
> +        /* Support I3C version 1.1.x, no other features. */
> +        while (s->ccc_byte_offset < num_to_read) {
> +            if (s->ccc_byte_offset >= 2) {
> +                break;
> +            }
> +            if (s->ccc_byte_offset == 0) {
> +                data[s->ccc_byte_offset] = 0;
> +            } else {
> +                data[s->ccc_byte_offset] = 0x01;
> +            }
> +            *num_read = s->ccc_byte_offset;
> +            s->ccc_byte_offset++;
> +        }
> +        break;
> +    case I3C_CCCD_GETMWL:
> +    case I3C_CCCD_GETMRL:
> +        /* MWL/MRL is MSB first. */
> +        while (s->ccc_byte_offset < num_to_read) {
> +            if (s->ccc_byte_offset >= 2) {
> +                break;
> +            }
> +            data[s->ccc_byte_offset] = (s->cfg.buf_size &
> +                                        (0xff00 >> (s->ccc_byte_offset * 8))) >>
> +                                        (8 - (s->ccc_byte_offset * 8));
> +            s->ccc_byte_offset++;
> +            *num_read = num_to_read;
> +        }
> +        break;
> +    case I3C_CCC_ENTDAA:
> +    case I3C_CCCD_GETPID:
> +    case I3C_CCCD_GETBCR:
> +    case I3C_CCCD_GETDCR:
> +        /* Nothing to do. */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_ccc);
> +        return -1;
> +    }
> +
> +    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);
> +    return 0;
> +}
> +
> +static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t *data,
> +                                            uint32_t num_to_send,
> +                                            uint32_t *num_sent)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +
> +    if (!s->curr_ccc) {
> +        s->in_ccc = true;
> +        s->curr_ccc = *data;
> +        trace_mock_i3c_target_new_ccc(s->curr_ccc);
> +    }
> +
> +    *num_sent = 1;
> +    switch (s->curr_ccc) {
> +    case I3C_CCC_ENEC:
> +    case I3C_CCCD_ENEC:
> +        s->can_ibi = true;
> +        break;
> +    case I3C_CCC_DISEC:
> +    case I3C_CCCD_DISEC:
> +        s->can_ibi = false;
> +        break;
> +    case I3C_CCC_ENTDAA:
> +    case I3C_CCC_SETAASA:
> +    case I3C_CCC_RSTDAA:
> +    case I3C_CCCD_SETDASA:
> +    case I3C_CCCD_GETPID:
> +    case I3C_CCCD_GETBCR:
> +    case I3C_CCCD_GETDCR:
> +    case I3C_CCCD_GETMWL:
> +    case I3C_CCCD_GETMRL:
> +    case I3C_CCCD_GETMXDS:
> +    case I3C_CCCD_GETCAPS:
> +        /* Nothing to do. */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_ccc);
> +        return -1;
> +    }
> +
> +    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);
> +    return 0;
> +}
> +
> +static void mock_i3c_target_do_ibi(MockI3cTargetState *s)
> +{
> +    if (!s->can_ibi) {
> +        DB_PRINTF("IBIs disabled by controller");
> +        return;
> +    }
> +
> +    trace_mock_i3c_target_do_ibi(s->i3c.address, true);
> +    int nack = i3c_target_send_ibi(&s->i3c, s->i3c.address, /*is_recv=*/true);
> +    /* Getting NACKed isn't necessarily an error, just print it out. */
> +    if (nack) {
> +        DB_PRINTF("NACKed from controller when sending target interrupt.\n");
> +    }
> +    nack = i3c_target_ibi_finish(&s->i3c, 0x00);
> +    if (nack) {
> +        DB_PRINTF("NACKed from controller when finishing target interrupt.\n");
> +    }
> +}
> +
> +static void mock_i3c_target_timer_elapsed(void *opaque)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(opaque);
> +    timer_del(&s->qtimer);
> +    mock_i3c_target_do_ibi(s);
> +}
> +
> +static void mock_i3c_target_reset(I3CTarget *i3c)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
> +    s->can_ibi = false;
> +}
> +
> +static void mock_i3c_target_realize(DeviceState *dev, Error **errp)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(dev);
> +    s->buf = g_new0(uint8_t, s->cfg.buf_size);
> +    mock_i3c_target_reset(&s->i3c);
> +}
> +
> +static void mock_i3c_target_init(Object *obj)
> +{
> +    MockI3cTargetState *s = MOCK_I3C_TARGET(obj);
> +    s->can_ibi = false;
> +
> +    /* For IBIs. */
> +    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_elapsed,
> +                  s);
> +}
> +
> +static const Property remote_i3c_props[] = {
> +    /* The size of the internal buffer. */
> +    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100),
> +    /*
> +     * If the mock target receives this number, it will issue an IBI after
> +     * 1 second. Disabled if the IBI magic number is 0.
> +     */
> +    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, 0x00),
> +};
> +
> +static void mock_i3c_target_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I3CTargetClass *k = I3C_TARGET_CLASS(klass);
> +
> +    dc->realize = mock_i3c_target_realize;
> +    k->event = mock_i3c_target_event;
> +    k->recv = mock_i3c_target_rx;
> +    k->send = mock_i3c_target_tx;
> +    k->handle_ccc_read = mock_i3c_target_handle_ccc_read;
> +    k->handle_ccc_write = mock_i3c_target_handle_ccc_write;
> +
> +    device_class_set_props(dc, remote_i3c_props);
> +}
> +
> +static const TypeInfo mock_i3c_target_info = {
> +    .name          = TYPE_MOCK_I3C_TARGET,
> +    .parent        = TYPE_I3C_TARGET,
> +    .instance_size = sizeof(MockI3cTargetState),
> +    .instance_init = mock_i3c_target_init,
> +    .class_init    = mock_i3c_target_class_init,
> +};
> +
> +static void mock_i3c_target_register_types(void)
> +{
> +    type_register_static(&mock_i3c_target_info);
> +}
> +
> +type_init(mock_i3c_target_register_types)

The DECLARE_TYPES() macro should be used here.

> diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
> index ecec77d6fc..d5c6d4049b 100644
> --- a/hw/i3c/Kconfig
> +++ b/hw/i3c/Kconfig
> @@ -3,3 +3,13 @@ config I3C
>   
>   config DW_I3C
>       bool
> +
> +config I3C_DEVICES
> +    # Device group for i3c devices which can reasonably be user-plugged to any
> +    # board's i3c bus.
> +    bool
> +
> +config MOCK_I3C_TARGET
> +    bool
> +    select I3C
> +    default y if I3C_DEVICES
> diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
> index 83d75e7d5c..e614b18712 100644
> --- a/hw/i3c/meson.build
> +++ b/hw/i3c/meson.build
> @@ -2,4 +2,5 @@ i3c_ss = ss.source_set()
>   i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
>   i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
>   i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))
> +i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target.c'))
>   system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
> diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
> index 39f33d9a50..3d6dd4f7dd 100644
> --- a/hw/i3c/trace-events
> +++ b/hw/i3c/trace-events
> @@ -36,3 +36,12 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx8
>   legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8
>   legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START with address 0x%" PRIx8 " is_recv=%d"
>   legacy_i2c_end_transfer(void) "Legacy I2C STOP"
> +
> +# mock-target.c
> +mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8
> +mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8
> +mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8
> +mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "I3C mock target read %" PRId32 "/%" PRId32 " bytes"
> +mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx8
> +mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) "I3C mock target send %" PRId32 "/%" PRId32 " bytes"
> +mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI with address 0x%" PRIx8 " RnW=%d"


ATB,

Mark.


