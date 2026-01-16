Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C83C982E3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 17:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgnrG-0008PM-29; Fri, 16 Jan 2026 12:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vgnqu-0008Ik-Jf
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 12:43:17 -0500
Received: from mail-switzerlandwestazon11020079.outbound.protection.outlook.com
 ([52.101.188.79] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vgnqs-0003fB-8F
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 12:43:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4qguVTArRW2MtsgVHwWGBC8w2HRdKpdH8LKPubPBCDX+Wkenj0mp6ii4zYNd73BRIQjzs65EUu2TURaZNBfQ2Jy00l4g11wLcP+Dn+YtcBmojIIcSOawpSvK0P+Qsp3wv6Zfk1YNcpJCk2XwMt3wnDU7eIa7mperB48R/h2gjGaXrZkfLG79wUc51vTvnCf+Qu2eE8yxOWOReVydciaNqf1BOHjK8iZMcy9zY82jU/Sh6+t77O0xAeYBzm/ORAcV6viwbgHdlF5F6NTMWnUm2gdUz4//Vy+8GjPrvtQ7A+ANdCJRKqBhd0C8NEqhAjgwIESP3CJOoX6imYEk+aYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F4kDiG0ejN4ZAsVFlB1ceBS07EUFJ2LBJAcumnjFkU=;
 b=XGoK+8eCtWNsR/fMBhZwB81JQ9lZErL9rmZzo248e+2rrxmOFSLTEPqFx5cN821F+h09g2k2OCs8i0nCf8sLY+bxoTnqnJ+Mw0sgSLiFSZ63oDdu/dY4Rzmk/1IXowu2b2xWShNA7/4uiEtrYAaKAtdq28S5iD33uTUF8+iC8RBlBmHMgOwuRUH7QFE1+SvTP3rnBDgTzuhq21aCKsqmR+o42+0dsFBsDR17wWJGhu7Dv8M7Y5YOJeB77MoBQdsOUhOPAWC06cXuJ0Ps4rJ7l0HiLxCHMbEldPk+Dbo7g3n+l2lQBMx7fsgVCRl/C2M1OABpYhoV1sDZdWfP+wytLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F4kDiG0ejN4ZAsVFlB1ceBS07EUFJ2LBJAcumnjFkU=;
 b=SCurAaFoZDclG0DlIn/1v6J/AvkUy/SPWFGqjwcyzNkT41wWr22ToTBNLlG884z9bJrSg8z84kPYUBMw61y4WIZAd1eyZnoPC3zLmurthrINVav75Klh6iSm9a2PYx1refMlr5ZSW6yNxlyIC+dYebZGqwP/hrSsCe7hjn0nO7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZRZP278MB2099.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 17:38:09 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9499.005; Fri, 16 Jan 2026
 17:38:09 +0000
Message-ID: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
Date: Fri, 16 Jan 2026 18:38:03 +0100
User-Agent: Mozilla Thunderbird
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: [PATCH trivial] plugins: correct docstring for write_register API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::7) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZRZP278MB2099:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae2657e-53bf-420d-1004-08de5526035f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|786006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1ptVDNwdXRhYmYzM0hmU0tTZVV6VlFyamszbVRhckNaZHFaK2xxRWdYQnVG?=
 =?utf-8?B?VnF3NUtaRWFGRGJwSktHeVVrRVlNd0V0aEd3WCtqSmp3WHQvZ1JMMlA2Y0tx?=
 =?utf-8?B?V0xKOVlmSVNXVzRHSW1zS2VIektPWXE3emlnL09JdUR4QVdTRTkvMG5oWTlt?=
 =?utf-8?B?UENzVjJacHV6N3FacjBkaEFFcUVvOFpxRjE4UUdyYkpDNzRlbldGU092QXkx?=
 =?utf-8?B?RCt0Q0ZNTjNUclRYVCs0TDNyNm8rR3lVK01EaXhua2xyN1pYd3d1eGhVUnlB?=
 =?utf-8?B?bDZrNkZvc3NLTll6bkM3NW1TNDZJKzVmYndiL2h5ak4zYThFSS9ub0FIVkxO?=
 =?utf-8?B?b1RSKzdTOTFWQytzWVhRVW1MSEIyQXRpckd0a2FtRHBPd2NFekRqNWRmTEdX?=
 =?utf-8?B?akR4V2NXM3NqZkh0UDdaZHlrNkx6YUgwZHdZS2ZaUDRMWTV6bWNjMXYvS1N0?=
 =?utf-8?B?MnJLdElIckIvMGVTMEZTYmZiWk1uYVNZSWp0ZEQ3d1psYysvZ0hDWG9uU3ph?=
 =?utf-8?B?KzJ3QzlnbnI4SHM0SlJQeGtaTnFRTHdUQnNGYjhuQzdjMEsyK0ZZWDBaaGVW?=
 =?utf-8?B?VVVJZm1JTk9TTDhMU1E3RE5xd1pUdU5kRkxHZ3ZpRXQvU1VGQi9OVHdnSkF2?=
 =?utf-8?B?RUo1bUZSSktvSHk5QzFIYm1yK1NwdFZMWkZxRjd2UDFST2lFL29xOXV3Yld1?=
 =?utf-8?B?VHIvd3J3ZkR6blVOaGFqMTVTZGpJV01jVXdobWQ2WTRhNGNHZStoU1NURkl2?=
 =?utf-8?B?UzAxUTRIaUFrQUpzdzhkZ1ZRZVdmMVltMWRIdkNEdE5ZWDJFdlF1RXNVeGpU?=
 =?utf-8?B?bi9CamRaVkZTdStDQ05TV2hBNEh6ZEdHT0FIUTV3NDRXTFN6SndhVWdyS2U1?=
 =?utf-8?B?bUFtMUdHWmtNSEN6NXBhc0JxeVk0THZRRDFCVElBdWp6OGNhdXA0UldKeE0w?=
 =?utf-8?B?MjBoMytJUTZON1J1eENZZlc3Uzh1WjZxZDZJNmlya3VhbmZWbkkvaWhPNkRQ?=
 =?utf-8?B?MWI5L3pMWE9RTHJKUnNlTXdkbzRkTkNIbjZwcEdMU0ViVXhVRzY4bWhzNllT?=
 =?utf-8?B?ZE9IcDQ5clVQSTQvRDNKUkhPaEw0RDErWEE1MVUxK2J0aE5nZDBWbk5LWGh4?=
 =?utf-8?B?Qmxmb2VLRlhXRHpManNNS1lHc2NRL0svUkVSemVQMU5RQXZrUERHTVlyaU41?=
 =?utf-8?B?MWs2UFprZVdqNnR6a0NiekVIM0N0TG9OMDZrT3N0cnpBM1U5N0w4aFBKZGgr?=
 =?utf-8?B?VjI4SkhkM2sxN2w2NHh0UkkvK0NwOGZqYnA5MXRLdmRxZUp2SEQrMGhiYlRU?=
 =?utf-8?B?M2xUSDNVUDZRN1NKVnJIN09GRzRWK2F0eWtOc0hWTXpQYy9PbC9LS3hhRGxa?=
 =?utf-8?B?R05OYWx4cERtWE1KaUc5SHhVQzVxUHN6MWFMUUJUM0RwcmtFSkErUzFoR04r?=
 =?utf-8?B?RHFNdUNvR1ZFRTJWRXlOV3QwUmcwbThKUHYvZjNMVnNLMmpMK1p2SGlVQUh5?=
 =?utf-8?B?a1FQVmM4MzRKVktiNVZ0UVpCeHJBcm5nMFFOQmNGcFp3UXVCQ3dHWlZWSGE1?=
 =?utf-8?B?Z1Y0Z0c2U3ZyYjN3Qm9qSWhxQzhMdWVTRHh0bmZBK2V3bGxia1NBeWVQblRo?=
 =?utf-8?B?ZmIrVTBCNHlRNDQ2d3VGTjgySXNUcmFvd2RzME1rT01VTzkrQTc3Z3RLanBy?=
 =?utf-8?B?cnlkd0E0M0pRbWYvdXZheVNwRlIzSFlqMU1Nckl1YUU3YWsza285b0ZaVjRr?=
 =?utf-8?B?Q2JLMUdERTZzYWlLenNwMnJTeVpnVk1peFFCc3pGNWFRdnpQUDZRWDJRMGF0?=
 =?utf-8?B?cldYWTNrTHhDdW5BbVl1WUhhZUJ5dHdWYUo4ay91QzhOZCsrbFdFMWI2dlJ0?=
 =?utf-8?B?Q3Z0M0NvOFNyZ0tnMUZkTEVPWEZUTVdsZ3ZXZ2tOdWpwck13dWl0U3pucWVK?=
 =?utf-8?B?Qk01ZHZaMkU3cGQ5T2NJN2NYMnk3dG9ZOVFCaFAzU3FZZ2ROdzFBR1E3UWhH?=
 =?utf-8?B?ZFZDMGd5SGI0QWlkbzNROVVJL29GT2VTeERZMkZZS2hVLzR1ckp3WEptdjdM?=
 =?utf-8?B?d2VQTUJpOEUwYUpTNGtkUmkxL2hVYjV5R3FVWC9tMlo0czkzWmxwOVBicDNO?=
 =?utf-8?Q?t1x8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjhhK0sybTA1S3orTmxJSnFieGVYTFAxMUVBSGdQWXIzZ0ViZVZQblpzcGtW?=
 =?utf-8?B?M3c0MVkvVjU4T0VpekhUTGowNUNvK0Ivc1VwM1ZSSDFnOU43TkZMTytPOE9v?=
 =?utf-8?B?V0VXRTRVNjFvUDR5UE13QzJkQWcvaENIU3lyVHd4YlNVcjlrajNCQXdkVm10?=
 =?utf-8?B?OEtuWFJjemc4RHRQOFBCemtub3RJTWtPRnBxdWZuYW1nSnBBUTdzZVFEYkVW?=
 =?utf-8?B?MlJtdGljdmZ6UEdQMkh6TkVHOVdLQ1NVOWNURW5Rby9QcEpHUGw4Y2ZJS2lz?=
 =?utf-8?B?UUhlZ3JtV2xjQnlYY0dPb29ieS8vaFUxamVmbnlNRkswSC96NWFOM3RtMW9y?=
 =?utf-8?B?MDNWdlVOS0xYVkFHZUJ1Qmt5dXIySzlYcVhJZmp4ZFZseXVvcUtCYWhFZ2xD?=
 =?utf-8?B?R2ZHMkRxR1k3UVk4azlaOU1CelpHdFR3bEI3VXlXaEJ0YmZvVGNQalNiMFBj?=
 =?utf-8?B?cEF1WUk2WHlFeFgvcCtiK2JMNVFINENTSytvSDNGeVY0Q1BvWUI2dy8rWE1x?=
 =?utf-8?B?RW0xdlFVb0E0TEZMQjBIYklnNlNpdDVLMjhUdmVOMzE3VlQ5TitCNlc2dG04?=
 =?utf-8?B?N1QwaTkyM3hLTXZockRBWWthaEtoZU96eW5KL0lwZTFPSTRlUnhFVHZDTG1K?=
 =?utf-8?B?Tzh3cThqQ1AxY3IrN2hmTnh3bWVHV2x3czJJYjd4OG9KZ2FpclVmTHQ0TFdl?=
 =?utf-8?B?S3YrcFFPcDJTVnl0dzNKVStWWU9SL3E4bHJIVkdSRFB5UnpjM3BlTzVsYjRp?=
 =?utf-8?B?NGl2U0dsYmdpRTNXRXp5czlIeWdCeXlIWnRUYWlPNzNIU1haODh4RG9jOUVo?=
 =?utf-8?B?RkhLWlRkRWtCMU81RG4ycXdQMlR5ZEsxU2s0ZmZlRjh4c2t6eTNMaEFzdU5N?=
 =?utf-8?B?V21iVGVwWVdVS1pvUXp4Q1VRRkgyQ2NXTWtIb1doMERUakJycC82SFlTcUhK?=
 =?utf-8?B?RlFTMXVaQXY0WUVObTJ2b3NGQU9MWlJZOHN2UXVrOC8rRnY3NnpGSDdINmUy?=
 =?utf-8?B?OHZFTkwzK05XNkcxcnRORFplNFJ0SW15dmFDd1E0eWtmclRMQkRMMnJIR2w2?=
 =?utf-8?B?MkxVc2V2WkZSYXFpMG1TMm1vVzRRNTR5SVMyWlFtc3Iwa2Y1NWE1MXVVU1Zz?=
 =?utf-8?B?NVkyZCtvblRaUGt6bVpJdlhWVk45bWppQ3RadzJiRngvMVcxZmdjNit0anJy?=
 =?utf-8?B?b2MrYW5PeDdaZUF4emYvWDI1V0NrY092SVBDRkRpZmZ2YlBqOHRSZTJ2OUZn?=
 =?utf-8?B?bHVzaDFybkVwTzAxNWplUzFrRXBuYU1mZGhoVW15cytDQmRCODlkbTRpRFZ0?=
 =?utf-8?B?cWpjdGhUME1SL3pCb2NCK2EzQzNkU0Radm4rKy83TEhiMWhQU0RsVUNxcFV3?=
 =?utf-8?B?RDROWkpOUXdTTTBscEFucjJZYmpmRUtKZUpRWi9aeFpDaVJwUFIwejhIeHpi?=
 =?utf-8?B?Tm9aSUFmOHlYZTkxWWVzbTR2OFRORWNvSG9Qc0M2R3UwQWF0UGlaY1FLQ2sv?=
 =?utf-8?B?aUZtY3cxaW5ISDMwcDE1dVhqUzQwSm1oNTc1KzlBbHU1cU14WVJQanNtcHlz?=
 =?utf-8?B?RW4rNk5jOFhzdy9lWnBkVEloUmFtOHVoOFloU3dFYXc4cXRqUWJZUHNPWDNm?=
 =?utf-8?B?ZTA5YVIza2paMjZkNFFBMUdvMmpwNDJkemJWam43Q1ZUMExuU05rQmEycm1y?=
 =?utf-8?B?akJDcjFsN1ozMXpZVm03cEVpalpIR3Rob2Irdkk0aEhhSUFuclpxd3I2di9C?=
 =?utf-8?B?ZkFQY0tPWUpYcmZtMWRMU3NPSW8rT1FhVi82TG13YzU4WmtENFVyRTZkQW12?=
 =?utf-8?B?VDk4S3BCQWdmQU5GdHBrUUZCVmIyNW80dVpWMC9uQzE1N01KQnRHTXZaZ0Nh?=
 =?utf-8?B?eUFjQkJIcjN1ZnArOHR2ajFneVVyZ2ZWTjZ3V29NN2dsTng3UWZsWWpRVjg1?=
 =?utf-8?B?L01VRFBCWnY0elE1c1A5bThURFhxOFlnLzB4Q1luOXF6S0VURXR3NGpiOWx0?=
 =?utf-8?B?YVlvYVZwQ0pYOURKM2tYS2xXZTBhQ1B1b1ZNYVhZTkN1N2dCL2tFL2xaRFhl?=
 =?utf-8?B?S0lLNEdWbDJvSXFKSnZEVVJoS3ZudnB1cEdkZVNoNWllZEd4UkRLREZQZnBw?=
 =?utf-8?B?VFFQMWQzdjBMdFpxeXFWNEdzMWdNYkRzWjloMXZTMnNuQXNhQ1Y1YjF6UzY3?=
 =?utf-8?B?Y1BvMjduRlZsSG85ZTU4V1F2YW03anVwOE1RSW53a0RXVlFXaDF6UDJhK3JD?=
 =?utf-8?B?NEJKSm5WZkZaS3Rza1V5dW1uaHovOEY1eDAwaFEwZnVueXBiV09XUUZJeDJS?=
 =?utf-8?B?TEh6QVdKK0s0dlBSR25Nc2ltNk0zUWh2YzJ3RFJRbkhZejBLY3VmVk9ybVZ6?=
 =?utf-8?Q?avXoHvTLnm2/MpK8=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae2657e-53bf-420d-1004-08de5526035f
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 17:38:08.9746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIe7agOp/9mBaDLEcbtt93v4gE5y2wnuaMUaRiTk8OLUrzAORJt9vYkeOiOyam4M1I6MflXM/h3mzFB1Rrt1Fqk09epBkzds95sZ70fFmLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRZP278MB2099
Received-SPF: pass client-ip=52.101.188.79;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The return value in the docstring did not match the return value in the
code (see plugins/api.c).

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/qemu/qemu-plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 1f25fb2b40..def6693a17 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -1002,7 +1002,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *handle,
  * Attempting to write a register with @buf smaller than the register size
  * will result in a crash or other undesired behavior.
  *
- * Returns the number of bytes written. On failure returns 0.
+ * Returns the number of bytes written. On failure returns -1.
  */
 QEMU_PLUGIN_API
 int qemu_plugin_write_register(struct qemu_plugin_register *handle,
-- 
2.51.0


