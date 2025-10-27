Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610FFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLCT-0002cZ-9y; Mon, 27 Oct 2025 07:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vDLCL-0002Xc-40; Mon, 27 Oct 2025 07:15:40 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vDLCB-0008Vc-Aq; Mon, 27 Oct 2025 07:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9NW+5XDCc4LRYvVjvJ7GSJquKQZXfE7dALR8A97LlVNXAfLWNE32KmiBM15IGeF1VSs7T0t2Ddya1ZCgTags9O7YsB/+vZuhrEOjJ3VLASgbCtDYdpHvA9ee2d+gfiglwpu5cTr6X8eWh/DT1yqe/TbqohkQnOT4oug8wGDhEBkP8UHRW5r7oEFwohPJy1z4hrwNDV8RdJP9fDpT9kCYCPa5vj/KUnmv7GH6haIlmcgBe/AVb+bGCjdZMdvmUL0z9i8HgPqQ/DjfMTBKNu8RoMJRKY1wHo6cQFTMIUKVDYVIJoMfEdU2FXVi16OkvZzYbioeL5vXLzj/M62OeDv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hz++b5B4vfg3+2/TYiKBGI9CI26RI5NiATWcBxSZKU=;
 b=YgR/JbrckNqqZppdHL31YA8sBrnUD8iL4Pr8ZKenYbbLjFDTcnVwrr5BWx0l+doyjmEVYcz5ZJeAJk223s2K2XwyVCvJ6uHtQvJ7w0/3YpDV9uVOSFrwvzD0aHIcnB+vgIr+VPfsSpYDhr/9TrJmC+Vxpg5Ws0FbUqQisvwxdhI8/yz6+YHjcNxAZ2o3br+IdKIz5doARelsYBwc0wWxEMwVHuwH0X3WZyH3GFpSaYj+2cPBttzJ/MVjDR3otzUdC75d4GH7tmHIzrF2sTf6bUTX4FQFVRxYnLDH7VuH4+QIG7+7k3l/jhBPg+55SqF7mnHFSV0as6/7ZjnMN9jjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hz++b5B4vfg3+2/TYiKBGI9CI26RI5NiATWcBxSZKU=;
 b=yyItY2+Blle9vO2Cw4D8noHG/PiLOTnEfDzGxgYbl2ycjjXVz9Y1oGj6GvaUi2QOGd0rq1DnH4WMzxFqM7e9Gm6P/+AL8o+YiJNspbl2aPLEHvaoMxoPQMhXMNW5flQw+jGDir5FpF7UczxqpHepEjHs6EmvticrSzb79/WZqLaDeK6Mdq39XN0l6UKP/MCzsklgJFdvaS4e98/I5pTV38FAhN2ysdrR04dmdOgh/lCB+h5oqfAjfk29fmglInhhEb5/vFr9y082R3lpDpB4kPHrblPQxaxlv4jG3hgy3yQt594iruXpxEkj5BATLnA1//LLQBgm0C+n5W4NKNfzvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:15:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:15:13 +0000
Message-ID: <dccad571-544c-49bd-b450-62da7bf77a1f@siemens.com>
Date: Mon, 27 Oct 2025 12:15:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] sd: Add RPMB emulation to eMMC model
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Alistair Francis
 <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Warner Losh <imp@bsdimp.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f0a7e5-e588-471d-315b-08de154a191f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2Y1LzVKR28wZ3dIMEZ3djBWMnJLR3E1aWtFc1haNTg2bDJYQ2FhbGlibzZk?=
 =?utf-8?B?M3NwZ3pLcEZyWEZCZGM5VVNtM08rK0Y1by9Wamx2cERiMjhtenR2YkNVYkNQ?=
 =?utf-8?B?bkdPbW51SXFQTGpvL2FMODBFb3pna2U4QTNwTUsxczUzeTVoWGlCcENIYjYr?=
 =?utf-8?B?VHd4d1ZEVUJUZnZMMit1dEd5RzdyTG1rbUpTSU43Z0tEYTZKT1dIWWtpWElZ?=
 =?utf-8?B?KzBIZE5ZWXNRdUw5OW9HUUZ1dUlRdzg0Y0hyRHdncDNVUXdWYk5hYXBOa1ZX?=
 =?utf-8?B?R0lubEw0YnNpcEgvZDdPOTJsclc3SE50RlExNTFlV2ZPTG1Ub0t6UlBjdEdT?=
 =?utf-8?B?Mnorb04rMGF3UTIwVGRZYmpzdlBEMDgxcXZMT0pnNVhQS3N3ckd0QXg1S2o5?=
 =?utf-8?B?d05Rd2thdFppMy9oVTg0Tk5RbFZ6MWlTRDBSdHZweHlPSXJ5dkJNSFpSZWEv?=
 =?utf-8?B?VnY4bENUd0orR3FmTDBvT1BCcDdyR3JJbUpuNXEyYXRHNTFxUmZ1OXVJWisz?=
 =?utf-8?B?R1hHR01vUGdWS2RmWHlIYkREQkRIWnJzd3doamFGckZ4V1pieDNqTkJHUEJO?=
 =?utf-8?B?WVlYdjBLWUtZUlJLZi9tNm5YeTZjd2c2UmMyMStaZ04xTHFZQnc5MDkxTERr?=
 =?utf-8?B?TGE3M0dyczJLNVp2Q1hVWlpCZmI3QisyNzMrdU1lV1ptVjhRNmhCVjI0L0sy?=
 =?utf-8?B?VWFqcVRZcTdUMzZGVy9nWi9tVFBVckgxNVdWM0V3NFcveTAyb2IrUW9QSmRW?=
 =?utf-8?B?NndacjlYb1p2Vzc2ZHN4eG5wSmlBU3JIbDlWRnVZZjRycXlZTTFYeGpMZHNj?=
 =?utf-8?B?SWx5YWVuMkkxVHltbFJEcDRZNmNRS2NNS2xQY1pXUVFoa0NaWnZHdnJoVW5j?=
 =?utf-8?B?SnVoUVBhZGo1Qmkya0lzSjlHR3U4dlA4RTRXMk9UcG1adzU1RnViQkZkejVm?=
 =?utf-8?B?RWE1MERFMFg3d1VCUTBoc1hnMXgzSHBmeUxuZTdva0dOenV1Z1B6d2dDQ3Y3?=
 =?utf-8?B?NkljemprRnVQTnJROTU2ZXlBLzBYUGRWTUxJaE1OL0lKeWZibTMzOElMYXNs?=
 =?utf-8?B?MnVXL0dZdnlFZjVNaTRuVlpLSUM4RE9zeVEwdFVuMXRLSHlpY1FkcUNhOXJQ?=
 =?utf-8?B?eFBNdWx3WEpPLzhQZ3BhOGNJeWx3b0lqVFVueWhkRTR3Z1VuT0lscUFBeVRB?=
 =?utf-8?B?SEJOc2JtRjJBMnJrYitFOENuemFRRXdmMlh1bWlZb3RqOTFpcTEwTXZ4Y1VZ?=
 =?utf-8?B?cGU4S1BVbmhYUVYxV24rcDV2RUlWK29sT21hK0RIYitpWVdXMlR1SDNOc3FL?=
 =?utf-8?B?QWtTcnhMYjFPK0lxVlN3TE91bjVSR05YS0Y3MFdoeXUwdWZvMWRITHFKUWVD?=
 =?utf-8?B?ME0ybTV3NHlTZXZtQmMwaVUzK0RYNktlRFZQNnMyQmw5dGJWR3VaenE2SWdh?=
 =?utf-8?B?MnpIZHc2ankrTDcrVFU1Q25qQ24rZHNKWWVsMTh0Rm9zRUcyTmRCbElBU2xo?=
 =?utf-8?B?aUdmbzJoV3NiUVQrUklscTRzMG5TTjZZSmRpSWE5MnFPMHhVOENZaUxxdkJu?=
 =?utf-8?B?MlVlell2d1c2U3JsV00yNTFGbVZNbVVnYXVrZWlUd3p3WXV6ZE5kcFhyNkhW?=
 =?utf-8?B?NWNBekpTdVgza2pqQmVyRHlMekF6Unlad1F4RDQySVhYM0dyZitHQkV5ZUZU?=
 =?utf-8?B?aDgxS3lickIwMEdibzdxSEZ0VkN1YnFnZlMxTFI3dkprTXA3Y2pRbW9PRDNR?=
 =?utf-8?B?RjBTd0ZVN2QrOUtxUURIV2lpK0dsUkt6bUNMY0kyb3BESVJVR1pITGtQWmhi?=
 =?utf-8?B?eGpmNE50c1B6aUtOcWtSWXJFamgyMmFhVzhjZXhGQkM3Yll6RkVLK0d3b2Q2?=
 =?utf-8?B?RThyN3ZpNnFtUVR4ZDJBcGRwUDRaaUk0QzdtNytmaFJSNVpCTGNiM1RNRkVP?=
 =?utf-8?B?SGJHYjloTmg0cUdBVitySXF3UGNIaFJFWW1QSngwaW5TSHYzVjdLcHNxaTl5?=
 =?utf-8?B?d056VFByVExBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEliVStuQ3lsY2pCZGZuU3lONC9ETjBsZkFCWjhSU2dJQ1VObkdTSUkycERJ?=
 =?utf-8?B?K1UzS1FSYlFXbjQrTWV5QkowckpjZldtdVg0OEFxUW9WckRtN0EzZmNMdmZX?=
 =?utf-8?B?U092Smc0MmlFOHRydkhTbWU5K3ZJY01aS3NUazF6N3krbDNEY1ZuaEJSbVJp?=
 =?utf-8?B?bUxHYWQvQThWK1ZoWTNHa0VXRVpuYmZzVmJFa28zVnBmOVkrS0FJRnRqRzBE?=
 =?utf-8?B?WW9tclo1Vng1bEhEazhud2NIRXlzOHNMZ2s4amtNNm1FNUk4N2JuN3J1d09y?=
 =?utf-8?B?Z0YzRG80YXBFVjQ5TXd3L0ZPNEJud1djUi9mY0R2SlhGa0JrbmNPcGRGdFJG?=
 =?utf-8?B?NWtiSXhMZWZIWkcrR3FBSFBPcWY0Vkt3allPcFRkRzNSZFRVOEQzeU5uU2VH?=
 =?utf-8?B?S0V6L2EvOGtUZzFxenU5bUM5NlIwdTRSYjZnbGwyeWtwTVJiNkNOQldKekZK?=
 =?utf-8?B?SnN0NHpPWitmeElicVZEZ0x4R0plQU1uVGpYOEl4WXJLZ3lIbjAwRHcrc0Jy?=
 =?utf-8?B?dlN2T1dBVWU5ay81SG9FYXpSYkFGNFRFZUQ4RlhNZWJlNEl0cExEd2xERmJq?=
 =?utf-8?B?eEZTYXhycExtYUVVOTU1eEx1elVBS2ZWYkVNYmVNbmYwN1k5RHVKSkpMZzFT?=
 =?utf-8?B?ZmFKUlluVWhNV2VKYzhFbEhUUnhNV1ZmRjNSdWlJaWpDU3ZrUFBZMS9scnhp?=
 =?utf-8?B?YUJURVI5UU1mODhOL3dPRVZzeGNEUmkyYkxrSE9tSjkrNFhCNm14NElDZUE0?=
 =?utf-8?B?SnpiSjJSenFIMGJadW50TGlOdWJhVndxT2w1dVRDTEpaQ2VsVk5oQ2phZ29I?=
 =?utf-8?B?Qmx3aENXSVpESkthdkEvaEs1RThWMldSKytUbnc2U1BPTkFaa05hMk51NjN0?=
 =?utf-8?B?UTVMN3FYZTM2czZDVVRISno0Z0ZhQXFxSmxvbGdYbU9YbFd6UXdpa2p1TXlO?=
 =?utf-8?B?cXlDNENPS3R5UFM0eVpsK0JHYUx3dVJjZmU4THk2SUxkUk8rL0FETEwxUUhN?=
 =?utf-8?B?Qk1weDY4LzdQL0Q1UEhpdlNudWNrKzBkQ011WW5qbElUSlpnbWpNeG05R3Fr?=
 =?utf-8?B?SzM2VnF6a2tXZFF1MHdLVUdkRml2Tm1tUmtrcTRMWDNjOWJSRlFGazl4RGoy?=
 =?utf-8?B?c3NTcWViRGt2OUlvQmw0WWZXQUtQUzVhQmtDbVlLYnY3bXFra3I1OWF5TGVR?=
 =?utf-8?B?eXpSallaOTB2TWsxTnIzTzhROVBwVER5blFhcjZNRTdVZGY4VzdITTZZNFY1?=
 =?utf-8?B?R0RyMmlaUzFKNGNaZFl4SnplK2grS0hoVWNtQkNaZEhocURSTHcrNnQwSWFi?=
 =?utf-8?B?MEFrU2sxZXZ6WVhEdGJBNUphN0RRSXhxb1RvU0xqWlZianF0RWQrcGE2SmpH?=
 =?utf-8?B?bDVpMUNrVjVDMm1hT2xZZDFsVVFaK2FpTTE2bU0xRnZqbW8zUkxpMFZkaHp2?=
 =?utf-8?B?WU5lM1l3dng2cXczM2ZKUStNaWkrclpEbWRrRnBzaGdRa25nSFJBMml0TjlL?=
 =?utf-8?B?NXlkc1NWS2pwVTVwR0pYUkw1WDdrRFR0b2srbzBOMWI0L09JM3hEdmlhOWV2?=
 =?utf-8?B?M0t6cEtJWGFLUkx3TThEc2NhTEY3dGpLdkxBUTh6WGNUbWI1UEdZbVI3ek9p?=
 =?utf-8?B?R2xkZWhLbndEem9mcG9sTkxCb1JnV0pCMlp4T2llWWwybkYySlVpdERrcEEw?=
 =?utf-8?B?Y1JndEcwQ212Z3hlOEltR0NmVHVTSFVZRkRIazgyaWgzVGxGNVpnNEp1dU1i?=
 =?utf-8?B?WTNuaTQ2SHl0RVV5dW9RYUNnejMvbDlQRVpCcUxvanhzRXo2eHg1ZHRyblc3?=
 =?utf-8?B?ZklzUzFLSjZsYno4N2dzcDVCazAwZXpGL0huOFJENVV2RnczV1BNbUhyM0FQ?=
 =?utf-8?B?Q1RZRGlnV3VrR2hQTEdiWG9QVFFZY2Z0VWJNU0I5VzdGYXplbG9TQkdVWkVr?=
 =?utf-8?B?MWxWYlhxZHM2T0ZlVFRzM3lLWXRrZE4xcnZLMDBYalRsL1AwZXF4Q1dLQUFE?=
 =?utf-8?B?N2h6R1pyUmFwd0g5cy9tblVPcFFCZnZiN3ZQNjh0ZUt6dFgrc1RYSjNYdUFj?=
 =?utf-8?B?WFVzNVBvSnFISkYwckg0bUlSWEJGSUR4bXMzcERvb2JrM1l3Q3o2b3dnQmRn?=
 =?utf-8?Q?cvHpmu9fHcrBI9k8TQQhPD7nI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f0a7e5-e588-471d-315b-08de154a191f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:15:13.0055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X9arbXD14OekOmh6IDFXbBwzkydVmF+gmhYwUmqucfO3tvUR5K3pWf4rVbDR/R3Tf86TVUlqrHuASUppv0RaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9187
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 17.10.25 14:03, Jan Kiszka wrote:
> Changes in v5 [1]:
>  - fix regression of patch 1 with unplugged SD cards
>  - address review comments on documentation
> 
> Changes in v4:
>  - add truncation warning to mkemmc.sh
>  - fix typos in doc and mkemmc.sh
> 
> Changes in v3:
>  - rebased, dropping merged patches
>  - rework image alignment rules to match hardware
>  - improve/fix mkemmc script
>  - add emmc documentation
> 
> Changes in v2:
>  - handle write counter expiry
>  - assert() availability of QCRYPTO_HASH_ALGO_SHA256
>  - add missing SPDX-License-Identifier
> 
> This closes an old gap in system integration testing for the very
> complex ARM firmware stacks by adding fairly advanced Replay Protected
> Memory Block (RPMB) emulation to the eMMC device model. Key programming
> and message authentication are working, so is the write counter. Known
> users are happy with the result. What is missing, but not only for RPMB-
> related registers, is state persistence across QEMU restarts. This is OK
> at this stage for most test scenarios, though, and could still be added
> later on.
> 
> What can already be done with it is demonstrated in the WIP branch of
> isar-cip-core at [2]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
> U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
> want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
> kernel, enable secure boot and disk encryption, then run
> 
> $ QEMU_PATH=/path/to/qemu-build/ ./start-qemu.sh
> 
> Deploy snakeoil keys into PK, KEK and db after first boot to enable
> secure booting:
> 
> root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
> root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snakeoil.pem PK PK.esl PK.auth
> root@demo:~# efi-updatevar -f PK.auth db
> root@demo:~# efi-updatevar -f PK.auth KEK
> root@demo:~# efi-updatevar -f PK.auth PK
> 
> Note that emulation is a bit slow in general, and specifically the
> partition encryption on first boot is taking 20 min. - we should
> probably reduce its size or understand if there is still something to
> optimize.
> 
> Jan
> 
> [1] https://github.com/siemens/qemu/commits/queues/emmc/
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/qemu-rpmb
> 
> CC: Alexander Bulekov <alxndr@bu.edu>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: Cédric Le Goater <clg@kaod.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Warner Losh <imp@bsdimp.com>
> 
> Jan Kiszka (6):
>   hw/sd/sdcard: Fix size check for backing block image
>   hw/sd/sdcard: Allow user-instantiated eMMC
>   hw/sd/sdcard: Add basic support for RPMB partition
>   hw/sd/sdcard: Handle RPMB MAC field
>   scripts: Add helper script to generate eMMC block device images
>   docs: Add eMMC device model description
> 
>  docs/system/device-emulation.rst |   1 +
>  docs/system/devices/emmc.rst     |  53 +++++
>  hw/sd/sd.c                       | 352 ++++++++++++++++++++++++++++---
>  hw/sd/sdmmc-internal.h           |  21 ++
>  hw/sd/trace-events               |   2 +
>  scripts/mkemmc.sh                | 218 +++++++++++++++++++
>  6 files changed, 618 insertions(+), 29 deletions(-)
>  create mode 100644 docs/system/devices/emmc.rst
>  create mode 100755 scripts/mkemmc.sh
> 

Gentle ping: Would be great to get it into the next QEMU release. Please
let me know if something is still missing for that.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

