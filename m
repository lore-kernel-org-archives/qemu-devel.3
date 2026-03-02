Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D17AEA4E08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3tT-0005dT-D7; Mon, 02 Mar 2026 09:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sJ-00050J-R2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:11 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sG-0003rN-Ej
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:03:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX30/InfeISldsfDkuud4f5XnevqnSDk1MjZypiQuXG1ffSWYh2D4UKum/5Fr6bHws9q8FvSh2m0DIPcE7vwbVLcHgSjhU7x7m40rubdKa1hOEYD22uCpNIKou7NUmm1/5TuLIJg/xvSLzczJD7OdkDVJWAMy4cA8tAkidQMerc9ae+B3IWXPOZw8n3sZlh04dFVOYpmB91S6Tn/B7PhcVOmxzXhyfiPphpJa9bDJI+sSxZu/MWBoM/6NE22UmVuxuP3ZpAlcMHUOZGG/t9U3UXvLOnEmN/niliN1YVOMUJscMx6f/BNbf/4R2vA04C8WdzHCCsMBK4v6QyTC4mkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFvfVT3xRr3bLZR31fQDHBCYLuUxBi5onR+OrGwSbos=;
 b=r2O9a0yF2vU6KFNiiYJ/1GnDoKseWjiM9eBUITXiutcGSBTfgbiEkQ71XXWVTgDuz9np3RxRt3z/hdnBvfjSLeiHc1Y98VyPbvXJieVUHx0kL3Y7tYxIwPoID2P9ek5uOs7gIxDQs2ekIbGjgdwr3C6GDQsdZme52TaXkdrgVrfcuQ7QPyrM5eqwhWWn5hCWuyFLK1+Mmlxess+LytR8xNQKtpcJbofmFO4GtUMS1pSyl61qu6JjC7q7cgncXStV3Y8JG671Si2rGZQntDizBeJvMnJozqiSMKdcbeVAyr1YN9WrAl1etDz6sbZsf76ksL+xJkmsDbYwTOpg2Qc3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFvfVT3xRr3bLZR31fQDHBCYLuUxBi5onR+OrGwSbos=;
 b=NGqtryG2ZPO0v8yFiWPQpEISygz0uoZTiToNL7l2GJsTnr6W127fv7VzBH8MpZJccledYV8VUBDxAGdVNDqcoZji+THKlXzPeIRDtpegZAoA5N9w10jTYN9Vzeyp6cCSB/kjsJwpBa2YGyW8XLe+Z2YvGdhC3AYAioseeFz54V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR4P278MB1788.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:03:49 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:03:49 +0000
Message-ID: <a40cd32a-c8c1-49a8-b352-6467e55a3d51@epfl.ch>
Date: Mon, 2 Mar 2026 14:59:48 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 5/7] plugins: add read-only property for registers
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 xsFNBFw7TEkBEADaJzHcW02rDYHgS2X2kjyXLs99tnNpww/r3MlWEkrKxgfgIRbtVQTJ2vNw
 mxIhJnAo/Ltu2VoEXU1WGwoMGv8wxquIuE1RBnYghnYPFd4SOMX8fXz5JylHpl+vPCWiP8U0
 fFWfVL1vyldQG4aVtufaJ1VEOU8zsw6YeXzxWJJ7ppUag4teMKuFya69tEEN74KLkDMJRxGk
 pj7rHW8Y+xBdNW9hQ2vAXhWAtm64NtCtJcJYP8RNl/jqlqYTP1Voj7byXym9HUM7NGEbGtrw
 4KKi9ws1yZv9BkW3ECBg5Q1w3WYmHfwqSa+8vrD2ahNieDYNu7veYP0oMaohumRgVhiaMscD
 IY8wqyt6K93RiwXDQjDAqwE44xrZDr4jjCUAm1D/7WYZWtzhsiDq80JasMbXd8SLKGr96zX5
 6vJGxa6OvyavRO7Y7DGK/dNPWdZqAC4QlluibdRsbkFLtBg8d60sVxYW8A9o46rrQB8qzglc
 joPhDebr8/NsI0gnzjgpgmNbresqne4/JIylUuJEwYcOWZqKqDw9U03uTFk/Vp6AxmRquWpy
 XZJVBsMNbunclgSelZIt2nzCa2nXR5MYyV2Y8ays+gSAPeHFOc6a8JWNLhgVKUed12XVrMUQ
 bmMmTFWWqfrx89Up4a+jW7uGIzexOeXUXKeE1j0uGsRLk6CF7QARAQABzTRGbG9yaWFuIEhv
 ZmhhbW1lciAoRVBGTCkgPGZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2g+wsGUBBMBCAA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEqCB8P0q+u+2bTfhJlusnujFfx3wFAmfOq/AF
 CQ10kyEACgkQlusnujFfx3wl9Q//cNbHsBz6YvTzzi3fddVVYnEn7YBPMAw0r4vxtYpLCvpD
 sKOfMaGYYoV3AbVton2w53qTFcmTC/7J0/UxIi/cH1sWgVipZuVNrtESZFhkKAKpqJvHamPl
 uDD0kmINzztgNZOz44iUdGkSvqQW6ou5WpSEk9YEks4KPs/EH00l7hQ8YkfR/8oN63OxpYri
 W4+obeU45fBPPgOO1U1eMtWp/QBvo2qw+GiRQkq8kjKDTt9AYYPfcA+AdnhocgrQ2SdtcBuZ
 bb1BQnKEqWM2gVpvk/ujyZZktgBvqtoubAwaMpAGNgCoDju/zPf8wtbc/yo+AT+iiRQKuilm
 mQ7U0THfk3+DewN9CTZUiL1X6NdoUuLMqdSI4HCpo/d/N59wMkRKXHG2h/pKmTLbrHGFA4ZY
 a4zNN98yyPcq6OeAqurWbotXm7yxraXKkFD5dbBJcZYc5gJx+rZg2pIy+rYtQKqZWJTZhl2s
 ZrHNl1b8cEyS8vuiSZPjFnzgzVoBS1QE136ke/6P3rFPR4zPLyhZqKbCsGHR/BDfSCzeRwoE
 zJ3aV/8kmuyAfx1iTWVBLKJsPkiNS08jf+Nb+leo8Vab7AnolDTIr0o06bWas1AsIRG31/Zs
 wBRDlfjmKZ08f+B6a1SpkhdltGozljNt1PLEposY19aw5Ou3bqFQkYtooTfnZPnOwU0EXgiz
 6wEQAM8iX+Y1mi1l3h876YmnuP8JSO1s6k0lABDO42pZaSp6Q9mFOabB7To80q1qEXCznlcR
 nExrN29WwXkfL2tcV4t/JFb0o4+6J9MmMUR3kdvRu55b/AGncNj0oggZDP8e5cLikv8v1ReV
 c//RPKSHVKnlmC9gtM0UHWpwHyyoplHi4sMJ8WyzGKfnN1eg7HlSx0xJAE7wKQP59mIMMj7n
 IXnk7bnGO7oaqy+i2vAxcdJPN6jvFgFCsKECL4NJCw6ifrY05paYRXza8JVwAcCzw0Sx4gZi
 JXC+gE4p80qNRrwR5AQuyLQNO9EfKLdnKg/85ag7xjB3ZWYMZNbj7HwCB+T16jOS+6lgGONf
 vctIp+hTFxXoCEnMx96FydDkqaBBjAU0JkbxhpMWFhzKzEILa60fxDxOSYHSs6h3bLk3D+gO
 i8j1SUPC4Olj9od7VIZDKGLd/nLw5qSt2c0H69cW1M/KS5zVARZQPb8Cqa9SAWdjmGw6MHvc
 WoYK4mT1arhwUlmrqUMcNqA+foGjDGPsxCQxqqIU2rB590n2wafu65UuyPUmzxOGdcb31I4E
 kkoBnM6G5nN4uZUCQPXl/DFlq/cfFI7LmIL2aZt6idehfvd+iOND4HDjRzrYDhz1FQn2Ihoi
 qHNMO4zSpWv35fl5kHfo1iYojwcd/aiyu4V8wo7TABEBAAHCwXwEGAEIACYCGwwWIQSoIHw/
 Sr677ZtN+EmW6ye6MV/HfAUCZ86rzQUJC6crYgAKCRCW6ye6MV/HfK3jEACTixlDX+Xa53/f
 RS4AgdiLLcPnp63HYSe58cul/U8mGfcP8/wZXkPFzpsQZRONmj0vNHFAlTlQHpBnMmqxUvVx
 SosHPMrSwukjV/zDgTeYe8iZbqDjUEFIJvEU4mQd1O2/bfBCi0N0GuleN+oyu4cHhgJIN/Ym
 3yJks/Aeprt4k3YwTZsGRCQ4fVyfmnHyYGLNKjtR/ubibG1I4hDVhf1IwrvsAcpHw1UKf/5+
 ZA3O6ZANAwVG2iAidR2LhFPiBAFWtPmI0dX5i8+Hu5CmXlHkYK2TV8ys9zDuOEiWEcMR/9tA
 agcgw3orjj0lvFiSGYI9+w1NxO76T/by09nWsLXr8Mas+pFaKUP0Wk9vZjj+8TqPTkoKOMJS
 /+vsAGjFLM1ZfFyLRvVVJH4gaWs5zie533zYlArVA1db36+YGTBWzuHEawITPaLq/FngWb+e
 bxL9a5LkhEdTCnQVhBaC0yBbplRQcGwsc8IRK0sdWiRIGtlr6NMt1yw+3TwVsBPaYvLM/qfm
 pBZkz7hBNr2qTLcl1xeP4MMdMO2ubBUGTR5B+sOzaT1qIBe5XNFkhffLTR+YmkW1PXWz7tcO
 yQcudEYHvYhKegsw0Zjv8iQIQw3yeV0WbQAs+LGQAfwpVURhZgBk3DH9gQBFkZYi8YWX/zEc
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR4P278MB1788:EE_
X-MS-Office365-Filtering-Correlation-Id: bc69031f-e3ae-4d4e-3fcb-08de78648699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|786006|366016|376014; 
X-Microsoft-Antispam-Message-Info: 62Nhizk8XGVLMnx6EKC5gGTOWXeeofImHABo72WAot5qJH0LeDGtpxzrT5VS8a0iowRyFglrq1MZnYcc68hLjRpkUaehbTwfaIbQpaqYC9EVzf8ypj7yBwkaNa1eLU457ywSYuNggQHpl/qSUoFlZlKwDvBLQ6y5xuOjJAeHeStaQcANav8AMxcu4nSy1OZYlvPueam2gWjRXySRP5JErzQAS6BsV2/ESUZLW97cUeieVCjbAbXydADN/0/rPLlD5yID1cxnxr09TElC1/xlvr2gG1OopnF7WskSBFHwLY8FXCEb2TSh1mNujdmu6Cimbp1eLbKwp+XG37Ymoy/ne3QqeUNm6bmIqUjUs+fhrnMpX10uWnU9oN6/d6FlJHITSekqvAk05g7uqGFzM1ug65y9Z0F8DLLPg9/+FYe5sWMwKvoZaaIk/r+tNjgB+fMtrIHjWMSyDKSqAJl/9ZDhK5TFzRss9PVcN0Xka5/qaXDvRI+Vhr+IniOsWsARog2s5dc3j84xS8oUxrDQZYgMoJ8kJYoJR8gWVRzwfpwdloenXjN23NBYL2yb2nS/aowJx0fFdiT5gxO8gRu0jnTJQVf5C6qy8k9Vtl6//ouWTb3bIaEGpxUYbVO+oLbfNArGi5eZGs1P1WnXxjdcbUbc0DyAGOkTlinofeoDXdvgG2T32rJ8iWBEWigIOblZ/6FsLXVsT/AuBtGsrTMG1e2um7P+0YySN+9rg7yoC0Cu5uU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(786006)(366016)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmdIeS9qOHhKL0YrSUZkMkljWmlMYWVhK29aZjBjN0NNTk1MWWRDcUNyWGFG?=
 =?utf-8?B?Zzd4dTRvblQxUittS2wxR3Q2d0Q3ME1tbU1ZZVBYZkVkendBZGpXcEdWemZi?=
 =?utf-8?B?UXFQNzREWjZhY3RjTGw4Y00rcFM5ZUIvbmxkQ3ZxNEptM2gybi84K1JqQVY1?=
 =?utf-8?B?TkV0V0RuV1NnbzBGejFJM3FqemI1ZHJFTk5OZmpTQk9jR1gwczRtQ3pTY0hH?=
 =?utf-8?B?a3dUbnJKMTlVRHZGUXp1cS9ERDhDRGlvRHhMeGxlQmFOVCtlM0RqVFRTUVhI?=
 =?utf-8?B?RnRkamlPbDlzd0h6L1drOERJUHRwck0vQTNSM2x2RWhPaERWTjBsU01zbHl0?=
 =?utf-8?B?ZGVBMnRtSFRYc29oQVhQNkNpd3pkK1FUODZobmEwS2RUVzc4Y0hjTDVSQ2Nl?=
 =?utf-8?B?RnNydVczaEZ1UVliL0kyTkRNNWd3d21JcHF2SGoyYTArWmswWFZTZmV0cHdX?=
 =?utf-8?B?QjNFTzRYK3NnZGlqNkdHcFlDVnptZXJhelNZa0g4cmdHMzN2aDFBS2poeEJY?=
 =?utf-8?B?T2Q4YkE3czNyajBlaXpTSDI0R1VUdW5QM1phQ3RnTlludjNVNk1Sd280b2RW?=
 =?utf-8?B?aHZOamRHZHJRVHo5L1YreDF6WkNIZlBVQ2xmanBYajVyb0M5akU3N0RsY2lR?=
 =?utf-8?B?NWY5VW16cWVkT3MxT2dHRFI1K1FGbk4wcGNDUUw2ZGFuUWxTNURQT2VSN1pT?=
 =?utf-8?B?L3A4bGNNUzNMZDlGL2dwRUNaZTdaRHNzMW9pNTdnNTBLWXBLNk9nOVBCdFhK?=
 =?utf-8?B?Q2hyYkFkcjJXSndkQmNxN1o0N0lkWHVNQ2F2a0NFWnZhc0tJL0oxekxyZ2pI?=
 =?utf-8?B?RksvdXZOVVlsMVFrK0MzdnRrMHpmcDl0SStHR0NMYVVKOWZvZS9vbGFxV214?=
 =?utf-8?B?L21pWHF3RzBTb0tjZm4rc3dHN3V0YnVlck1mWXUvbkR3d2xlNmx3a0Q3UVY3?=
 =?utf-8?B?QWZmNE1rcHFzRWZlblU3c3NUbXpGa0xkMFIxeFNTTGpFazI3bCtMSlJFZFhn?=
 =?utf-8?B?eFZMVGE1bmdzSnE5RFZUOGxaZkdlRXBKbHFvc0pKbzNPeWhQdEE0OHQ2V3pS?=
 =?utf-8?B?Yi9zRlhMODl5MTNMTm0wRDhQMWhyL2JEMEhHb2xUY2dsQXMyZWZrdW94OTYr?=
 =?utf-8?B?TWdWbTY4UzlVaDVGWXhxdXlScEZaSmk5MVhYa1hkMHdKVkpXVFJ5SkU0Nm9V?=
 =?utf-8?B?c2xSUmNzRmp0djBuYm1GRzR4ZTFCNnkwazBSaFgrbWdNTlhXU2xsTE9pa1pB?=
 =?utf-8?B?NW1RVkg1ckNZUi9JZWJPOGk4TnY3ZkNQWUdhRVROZFJyczlDWno3UG1FUGxj?=
 =?utf-8?B?K1djdkEwRXhOQnNGbzFxZjdjYWMzUkRBZXprYnlSdDc3OGZlQWtqNDhXaitv?=
 =?utf-8?B?QmNYU3kxSWJMT1h2TVpTTFlqSUFYMWFsUWkrcWEvQWViVHJxcEFidmJ2TEN4?=
 =?utf-8?B?L2xMYUp0dmZEYkJDQ2V6bjdpUVQxZW5OOUdZcUxJWkpKQ2ZBM0NIQnIzOXIr?=
 =?utf-8?B?Q1g0NTZKYS9tNWpLNXFERS9jcWdMbEVlUTk2MlZrbWlkeXdDeFUzUGpIU2lT?=
 =?utf-8?B?UDg2UWRpeEJ3SVIxZ2IvcXgrQiszdFhaRHgwWmsyWmdYbGF5bGJpSFpmODd6?=
 =?utf-8?B?eTNJQ1hZOEwrNzNBalo3b0NtRVR5cVVITHRvOTE4RUZ0enZrNXRKbjVLM1JF?=
 =?utf-8?B?K1p0OXFnREtDRmxWUEZDcHN1Z0thOUgxMFJIWXBIeks5eTZ6akxQQU15L3Vw?=
 =?utf-8?B?VWlSK2cycWdtSENTV3lxb1FuWUdkYzZ3M0tka3NGZXlTbVdFNDdNbVVENUNi?=
 =?utf-8?B?UkEycmt0c1FuTjd4ZkV5VDBUNUNIOEdWMnZRbjBkd1IxY092eEpHWGwvdXpq?=
 =?utf-8?B?UzhsdnpPSVFYRzliUW0rdmw3aExsZzdYWXN6dDJmOHhqQzFrcDU4Y0t1aHVq?=
 =?utf-8?B?M1NYa3UyZjc5TDBGcHpSZ1F0YUl0aXhIcDU5UmFER3QvcFhBaWJUd3VSTzNC?=
 =?utf-8?B?SktPQTVSUTU4VmZQZWZnbjRFdXQyME5rbFZwU051UzVuV0s4ZXZreEJKWS9F?=
 =?utf-8?B?RFAyaGlPYjRCS3VMRzl6bjNzMEpqNXI1VXdYQlhjcFMzNWFRM0VaN29ZNWcy?=
 =?utf-8?B?UTRSUitlbG5kbStBc1V4UlZSM3RIQnl6eDNUZHZQVjVPS2E0NWlSQUF1K29t?=
 =?utf-8?B?d0lQa3FoeDBKOC9yZzV2OGtuUmNzZUF6ZzJ3T0JIelBYdkdGS3p5M1FId3hI?=
 =?utf-8?B?djdBUW16Y3MzRW9UMk1Pekdzc054ZWxic1d1YWlqTFo4VnpMZkN2WDJ2Wm5V?=
 =?utf-8?B?d2FvME5OUmJnK3FhWVNHQTBuKzliSnBTWUUwNXdHTUowdG55V3IvUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: bc69031f-e3ae-4d4e-3fcb-08de78648699
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:03:48.4780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVadU1R+EPlFP/vMnTbXPC/mIeaBWSHmL1M99Cc2xDS/mz2MP+94fc3dk6Uto2KYaWVjtPAdM4daf9GqVVPE5TqRD/y/03RqYuODiuytfzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1788
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Some registers should be marked as read-only from a plugin API
perspective, as writing to them via qemu_plugin_write_register has no
effect. This includes the program counter, and we expose this fact to
the plugins with this patch.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index f083c30fd3..791d223df4 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -979,11 +979,14 @@ struct qemu_plugin_register;
  *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
+ * @is_readonly: true if the register cannot be written via
+ *               qemu_plugin_write_register
  */
 typedef struct {
     struct qemu_plugin_register *handle;
     const char *name;
     const char *feature;
+    bool is_readonly;
 } qemu_plugin_reg_descriptor;
 
 /**
diff --git a/plugins/api.c b/plugins/api.c
index 23c291f644..85b34949cb 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -410,6 +410,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
  * ancillary data the plugin might find useful.
  */
 
+static const char pc_str[] = "pc"; /* generic name for program counter */
+static const char eip_str[] = "eip"; /* x86-specific name for PC */
+static const char rip_str[] = "rip"; /* x86_64-specific name for PC */
+static const char pswa_str[] = "pswa"; /* s390x-specific name for PC */
+static const char iaoq_str[] = "iaoq"; /* HP/PA-specific name for PC */
+static const char rpc_str[] = "rpc"; /* microblaze-specific name for PC */
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -427,6 +433,16 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         /* Create a record for the plugin */
         desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
+        desc.is_readonly = false;
+        if (g_strcmp0(desc.name, pc_str) == 0
+            || g_strcmp0(desc.name, eip_str) == 0
+            || g_strcmp0(desc.name, rip_str) == 0
+            || g_strcmp0(desc.name, pswa_str) == 0
+            || g_strcmp0(desc.name, iaoq_str) == 0
+            || g_strcmp0(desc.name, rpc_str) == 0
+           ) {
+            desc.is_readonly = true;
+        }
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
-- 
2.53.0

