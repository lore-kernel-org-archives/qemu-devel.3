Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2046ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 16:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7kP-0007yA-SX; Thu, 21 Aug 2025 12:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1up7kH-0007tC-BV
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:02:33 -0400
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1up7kF-0000y9-AW
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:02:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWb9B33kZLSbWGs9hwpL5eA8fB9+MnRKAiY7BATbZOymvZ998sY91Z6dUNq7QfeARxYgPA7fT2edaJvDbdJGwChno1bAAe2irRolU88oHFhEIoNVJRhowwod49jAFNc3AymGxYHufbBqlWX1hS0TQiLae8qQhWvQMEz8RSvxtoyDSVdXl0jdHAuR2AL2P2EhU1lowFHmyJ4VMvWLjfPVnyTOoWKpnezgJp+DyIVvnP9lSmtCki/rEqz3+WmwqyGO62jh7ATtvnN93Mo4wvKD32CJoMEB+mkqDMWOPVjVFuMn6E8bOokw1bE3NV4uKJ3/keYZfVoizmPJqwnkqVKnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZrtVOehJy5jaoqWm1dYWXR0rv6ywtfpByWzoud4v0s=;
 b=P1jJkrlrKxQjFssqs6sOP6eHn50vQv4x+GpvkAiLfawnYz3aeS/MF04x1qvpKT/ZvfOE4CFxXDmQOt4YMI9IOyfPX0NSAcf4ps8ADu0a8NvQHCmmnzR7HElmxeSwKPjrYZGaAd92A9u9CuQ+djEphEfwWp7mLz74snWKC5e5Muh42I4p9A5I0kN+6jbxn0Z0qJOAkbrMEjckmHNlckYm42sW8xaKuCqpYvmK+twsT8KhXP3LtY5GOZy+fb1B0WLg6cWWao4o23+RgjOfouuOSQsshkZQ8PhF6vejNylUn28khRS/1k5iKYqcDfDMjupbrdt3Px1pwX/1yPl2veqqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZrtVOehJy5jaoqWm1dYWXR0rv6ywtfpByWzoud4v0s=;
 b=HrUEmr7bHAAsBNJlUHDk0mjDO3T5f4p6JOFnM1n/pDfxyIl0K9nDsDn9hI8BNjk4zPw42ueMXhl2l2HTDAFLDaOtTNWyPQ9pvT4u4dV3ljnlmliTt3ONwksbwjV0wIEueiW98lXM7fS8ECyE8xWZ6qw01JKdYqKYIEsF2h98hT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZRAP278MB0786.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 16:02:27 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d%4]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 16:02:27 +0000
Message-ID: <7e0bd15e-d022-4de1-814b-9d9bb6513934@epfl.ch>
Date: Thu, 21 Aug 2025 18:02:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: New capabilities for plugins
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: pierrick.bouvier@linaro.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
 <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch>
 <874iul26rp.fsf@draig.linaro.org>
 <73d56742-5e6e-4e1f-8d8c-2b9783d0ddea@epfl.ch>
 <87y0rxzsz4.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
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
In-Reply-To: <87y0rxzsz4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::11) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZRAP278MB0786:EE_
X-MS-Office365-Filtering-Correlation-Id: b443f002-705e-400b-323a-08dde0cc1fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE9ZcnpDZGsxdXo4WGN4eTdRZzltdFdrYzZnNWVGaGppaVFPajlxSitnRU5H?=
 =?utf-8?B?VW5pZ216Q3czT3UyTWIrcEIxempaYmNCMmU0dXhsL1RPclBOVmp3ci9sVU05?=
 =?utf-8?B?dS9wOVUwNkt6R2p2UFVjNlUzTWxZeHZJVFYwdXBGSU95VXhTSmRySk9qS2hV?=
 =?utf-8?B?TGQwNkdqYTJ6NDN6ZlZsanNTcWE0eEtxbFpSK1YyVVA1OE9qMTlnUnAzZmky?=
 =?utf-8?B?Q0JUZUZERVYrTTZyMFJqdGcxVWpEcHlXZWpURmVpUERWcVdHU0pJT3B0OXc2?=
 =?utf-8?B?Q0kwd2tEam0vNC9Ga3lSdStMRDNuQXBqaXZXZ3FiOFhZWlJieXZxNVZSLy9H?=
 =?utf-8?B?UzNjbG5hUW5EUFgwZ2FGMGNJaS9OM1BZTnBDOVY1U1lxb3VkZUdwVjVrM2c2?=
 =?utf-8?B?VUNnSzJscG5FbG04L3FPT21uVDVjL2JhcjRtYU96cURVMktyT0gyOFJHcGhq?=
 =?utf-8?B?WUdkd1o2MzA5MHJOUWJmWHJVRUx6WGFHUEw2RHRGMzFFTlF0M1ByN3h2NC9a?=
 =?utf-8?B?djNBQkpTY3lLNzNoZmJmaHUwRkxoaDVNei9tdDhXWTNnSS9jWVNDb0dEWXZF?=
 =?utf-8?B?VVVDKzhDZjlZcklnUHFFejlTVFVuOWdzaWVEazNHZXE1SU11dDB5L3YySGdv?=
 =?utf-8?B?NzNuZDZHZHk0WFFKYW9yZkM5VnF0MlhHSm81cjhNRUpqSnRReHI1VXdRTSsr?=
 =?utf-8?B?Mms1VVNFM0xUZzl4cU1hQmVYNWc5M3RMR1hDT2hScFJZdTBXeW9SakNpOGpw?=
 =?utf-8?B?Zk94YWN5aFc3L2xPNmlDQjA2MVd1TzUydFc4dXVrSUJaLzJvUTlkTG5pV0Nl?=
 =?utf-8?B?M0dIdUxGcUYrN2FnZzIwN2o4M3JTdWlsZGd0ZFYvS0x4M25QdW12Rk9FV2FJ?=
 =?utf-8?B?TjBDZTZleFF3VUpqelFibWlWWE1DTENDM1NWVDNvWGdMSnp1eHJMeEYvM2JC?=
 =?utf-8?B?eDFMem90b01FeGRPeDlqRmcvdVZTcjlTa3JTV1JjaUtFSWgveExTb051S29F?=
 =?utf-8?B?WkZSNmVQOVpRS2Q5WEd3VzJOOXg3VnlhK3VXaS83T1BCQWVjRUFJUno2REQy?=
 =?utf-8?B?WXBORDZ1Q2xHVHllZHB4M0pRc0RycmR5RGh5Y2E5NndiT2Racm1HWGhYb3Y0?=
 =?utf-8?B?Mi9GVG9aeEpSS1NJU1ZLaTIzMTlMaEwwTVNuWUY3blRXM0hVZlF1KzlLN2N4?=
 =?utf-8?B?ZlRpWm5hYTIyUXRGQXE0UlpJMXFoOXlpNmN6ek50TDVmVTBidUZ5Nkh6LzQ0?=
 =?utf-8?B?V1FxSEhWTHd3eVFCczhORGJETUs0V3ZWNENnQnhvdEoyb2dYVEo5MmJ5Z3dn?=
 =?utf-8?B?cllKaDJzMHpxaTRMelhEclNNT0JrQXl6dk4zQ0tUc1ZTeHoydEszZ2d6cHpr?=
 =?utf-8?B?MjNFb1ROOHVGL2EzQ1BRSWJKNXo5QjNWbk91TjFJNklqOFNPZnREREV1R0tQ?=
 =?utf-8?B?M2hJTlJFYjFkWHpJSzlxbFRZbFZpSWtQN1FuL0djcEtKOUlhN3h2QmU3Umto?=
 =?utf-8?B?azZuT3pLTTd4ZFNUbmgwQm9pZTVKMnllT211UWwxaEcrbGJSQUxJQ2xQVVdZ?=
 =?utf-8?B?OTVoZ21sdW9BSm1kY2JFY0pnT0JCOXd2aE92N0tERDNzNGxIaDRyMERHeWNj?=
 =?utf-8?B?dmNVSCtiQlprRUl1VzVkT210YWpuWWJscUZzcW9lZ29KY1hlczkxUHZvOVBQ?=
 =?utf-8?B?U3p6WVVTV0QwM3A2Y1YxaE9jRitETEJ0cTF4eW9FazJ3YS83dGpYYzdZYzZR?=
 =?utf-8?B?Sk45RS9wN0gxdGxxLyt1eGx6UmVQcHFpYjVjMHRUQ0J5MUp4V3NTUUloTWRy?=
 =?utf-8?B?NGtIVEREOUFuNjllYTliOUFPVnkwSkVPeDltTlJMbVBsYVhzcXU1WUJGMEp0?=
 =?utf-8?B?RFJOUkpOR29WdXR2clQweUtoR3VkNHN2Y2hBd2hHNURKc2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFrZ0U1RVVkaTRQS3RVbmxsL1JGSWV4OUt1Qm5IYkIySU9xbkdoTWdxQUxl?=
 =?utf-8?B?ODJVVFdjb1Y1bmo0bGNNa3MvNmNJTlViTUNTdzVOVUJhS3MxNFZKM1lEdlRl?=
 =?utf-8?B?N2lwZjFxbVhlM3JJcS9DQTgxRXRDVURxMm13RzBxODBUdE1yZnlzelBSSnYz?=
 =?utf-8?B?enAyVS9US3p1YWhmT21XRFJ1TWFjUWhEK3E5YWlZWUM5SmVzbGU4SFlaV1hW?=
 =?utf-8?B?T29ocUpoTkk0Tjg0bWNETlcxSDlvNTJYVy9FNnpvVFRyb21tWEJPekoxS2ZR?=
 =?utf-8?B?RThpZTl2WG4yaWRnVytiSnFGcTF2ZVdXazZBYnVvVnZrU2E3Q0hteHQ5cUw5?=
 =?utf-8?B?UlFreWNqRGY2K3FIMU9abzVwRXF0L3VwV0U0QndPd0tIOGJhaUYyeVQ2RHI1?=
 =?utf-8?B?NVF4Y3hPZ1dPMDBUZlk3VkRQNk00NldVL0xlR2pUMC9qMmVlT0R6a2VCMWYr?=
 =?utf-8?B?MGYrT3pPcXFXT1N4VWsvSGFkZlNPSStpaXZGdDZxR2w2WHlGVldYVTVZeTNp?=
 =?utf-8?B?cFRucWdLcjdRQ3VZbmY3SDhMaHhIYVBNQmRzaFd5TFpiSi9GVW94TVFvUEpH?=
 =?utf-8?B?ejZoYWxja1pUMEFkSlFKKzdHUmpPY2VVcmUyT3ZBV1R5ajl4cWV2dmxTVGhw?=
 =?utf-8?B?K2t0dFF4WEs5SmFHSEFmbGRDKzdWUDBYUGFiUEtXckpTQzg5M2NkcmtUZnRF?=
 =?utf-8?B?L0Z1anp3bDZVOG5pUHNSQ0s2Z2NZQlI0M1o3NVNpa0hwbENKRVIrTkRncU9I?=
 =?utf-8?B?SGM2aUdkOHZPQ3dKekJBY0Q4eHBhN0ErZVdWNzJYZlUrUjJDVFdBQ0p1V3Bi?=
 =?utf-8?B?VWFueDY1MjEvdjR2OGJ6aFhCcmkxbTlqRElwRzNkTEluVS93K2ZCa2M4cVFx?=
 =?utf-8?B?bWg2R2t1RWplWVIzb1lVS3k4ZnBlWUFsL2w3TkNXTEMrQWs5cDlwS2pVNlhR?=
 =?utf-8?B?V2FDY1k2eERxRVppYkdLYjZFNEVEUkxzOHJiMldjRW5FSnlEeUhvMDk2UkVT?=
 =?utf-8?B?aHhudjdKNlEwa2tYK1B1eVFpTTdRS3djMHJtQlZqLzVOYldJZmVhMEFCcGY3?=
 =?utf-8?B?MWlSWVlKakVwYW9jbU9ycHp1c3Y5Z2dIQ3NHRkJVQm9BdmVXR09MT0ZNSHBs?=
 =?utf-8?B?dlRrcFJRQThLdGpnVWdyWUQzSjd5Qllid3FmNzRLN1dMSWNrc0VsM21QenF0?=
 =?utf-8?B?VmhMUStYeml5MS83TG5kZ3pMZHBwczlKVEJRTEpBdy9LVlNJaTN4RGNqcVpK?=
 =?utf-8?B?UVc0bkl6Zi9Hay9TaW1tZThrVTVXOW9lUTMyTGRGbkVDcThDanNBeXhKa08z?=
 =?utf-8?B?ODVDeUNlbmVBVHFUdG9nU3dPZjlmTDNxK0JML0VEN3hQQmhkUlV2a1d0K1VM?=
 =?utf-8?B?U1FOSHN1ZFRvSUVSbUZwT1lEbDZkRXhCQ1NhYmR5Tnd3RDlNSW5FeEk3dWlS?=
 =?utf-8?B?K1pkcllkRlpWNXJmSEJKUkc5cEIrbW9YRnhESnhvQ1NNanM3bm9zTzVEU1Y4?=
 =?utf-8?B?d3pKcFh1VEVLSDZBNkJoR0drUlExYXdLcEd5QkpIUVRjVEJreFE3Tlp0OEZi?=
 =?utf-8?B?ajVaUTRtN2RIdEtPV1pGUDRXQ3d5cmlHTit3VkhpMmFFcUJNWTVUc0cyRlJp?=
 =?utf-8?B?NkZTOC9oYnFJVkVRK2Z4K010b2xOMnkzZ3l5MnRqaDEvMnNtYktiK0xNRkdL?=
 =?utf-8?B?Sm5kclU3ZjlyZUJ1THEzUFhiQ1BCSDREdkg0QlJ0aWtiZkJrY2ZiNmJIL3cy?=
 =?utf-8?B?dW9LTWtzM2cwbGt4S2NZdWZkSmNocVRUQWw2VE1oZjZYS0dUZzVOdDVkaEhj?=
 =?utf-8?B?cFNlRW5oczV2OVZFRXZUTmJkSm1qLzUzaXF2WVc5TmdWWkZWMklVbXora0w2?=
 =?utf-8?B?TkRxT0FLTHQxVW9VTHg3L3N2c3RUandvYTY0Tzh1TVh4OG1qNGhEbXBOY3B2?=
 =?utf-8?B?SGkrOCt1YUpWZFIydjB0eGxncHJqbHJDdHNhaVI0T2RSNjlIQkhreWFPRmJG?=
 =?utf-8?B?M3BhRUt3Ym5JTDZkWW1yQWNyZW15ZXB4V2ExbVFDdEs2VUVhQkxtRkNUOVk1?=
 =?utf-8?B?Z1RxQTgvNklUTEpCazRaWUw4a1NDUEdLK04vWFpaL0h2d1R3Nml1TjNkM1RB?=
 =?utf-8?B?NHc2cDdBMy82a2JYZXJJR1I4Z21SeVkwckZLc05haFc3MVhETnlua3kyNU5N?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: b443f002-705e-400b-323a-08dde0cc1fcd
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:02:26.9419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50itxoQgBb4lplGblA/Eq3rJz7TW5mv9bJa5GGWjOM0/iUAm5d/+8GncGxy2ewQXlRAI1H8whjRnHFgEWgiiV0BYoZlfgymCVtMsiZMEaf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0786
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Alex,

Sorry for the late reply, I've been out of office and did not check my
mail.

On 05/08/2025 17:30, Alex Bennée wrote:
> I think to read the PC we would just need to make sure we properly
> resolve it - internally QEMU does this for faults with:
> 
>      tb = tcg_tb_lookup(retaddr);
>      cpu_restore_state_from_tb(cpu, tb, retaddr);
> 
> where retaddr is the address of the translated code. We just need to
> special case PC handling in the read path.
> *snip* 
> No need - we just need to exit the loop via cpu_loop_exit_restore() and
> the code will do the right thing. However we probably don't want to
> trigger that via register write as we would surprise the plugin -
> especially if there are other hooks still to run. So we would want an
> explicit helper to do it.

Is this something the QEMU maintainers would be interested in? If yes,
I'm happy to dig into the codebase and submit some patches for review.
But this of course depends on whether such a feature is even desirable
in QEMU (cf. the parallel discussion thread).

Best regards,
Florian

