Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFB1C282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to5Dg-0005Js-Rm; Fri, 28 Feb 2025 13:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1to5DX-0005JM-17
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:36:12 -0500
Received: from mail-am6eur05on20720.outbound.protection.outlook.com
 ([2a01:111:f403:2612::720]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1to5DQ-000793-7s
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4lIqzuw6IrcWhYtgAT53LH3CN4f5NTejcduSXkOjtiXM3u2FuQejTq/JgrAwFT/5jxKAyPaT3NFBHhMKMPxPD699zMxNF8F+jOxE/bDi81zuRBPqMKrlUYYCscgV4iWcjMg5biUNQDDdkyj/AwZbGZmSTwRY0dGEMnEpTP8LNIg6maHnFAb+KSedVLcXZOENhGlfa14DwZl32vRebPj/XJpKxN2aahuIfPZMg0U9E4XjxfRyHSLe7O+GfRGJ1b1L/TTdM0DNJaug+BJTgWV1Ngh3d7o4hoghtvTMw60x5AT/aWQSFBmO4xer9HdZKqja379+QZdD0yjSf1kRTkBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uyTottWW2edn0ZM2+dsYZ9wY/KgGKcxjLFy4+nOzV4=;
 b=vmWKyYDKa1oUUYEWys0CjMgaevlDlkDmizDu4uEa5s37SbQs7jIrS3M8yNR7ywtL+iN6PAVzUHjAD5BlHOHRreNaEsQIYT7SFt+2WBo5pHWSSinytMzOpljFruyEtnj7jYD7amDRiB4tDjQdSyw46S0dFaxhiBHbxQRpcZ43er9EACa4seq/tgX/tkepOs5ZOF/5U5D4daR0X5zRZXZzqrTdd4woRMYZAQiiGYqzVkOuLpKZG+9UIPMAROGLyRxP72z3AXLS0ppLn4kPyrxO+4jENOR+bO6a7laJn60E0PVVOgK+0jozZPzOa6wFJ8MZGxIK9urAwgAO8R2I3XC80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uyTottWW2edn0ZM2+dsYZ9wY/KgGKcxjLFy4+nOzV4=;
 b=REpgZCQwth5W/OnkFQzSkgX8wiK+XxG1EOfLHWMxp6GJKDnaQQXUPEZXOKYK0k9/sPH/NmcKIxBKlgl95vI1j3ODXVoWZIC/InB5HHivayC+GzJATQBZ4vpMKz/ulFKTraUbpo/5/m0eq/aTELHKUjhSmI9MqFJExBZ508JR91SdMT9QvLuHNT25cKqXSp8ncP8qmrQ1Olp/58qvWXaz0+hai8ece5l+kRQrPYFykXEhJH4mqJhKGQXt+elClVTteixomSkmnYgfDxPytSkoczS2GA8e6aft39v5GoE8vdmmwoC9EavlyE38657mpmh0ORjTebGGWdvY1SsRMYnQVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8253.eurprd08.prod.outlook.com
 (2603:10a6:10:413::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 18:35:57 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 18:35:57 +0000
Message-ID: <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
Date: Fri, 28 Feb 2025 20:35:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: d36e6670-5eb7-4625-7434-08dd5826bdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHRxeCtzNzkyTTJWWGFBZmJGS1BGV1ZXMlNOMjd4VGgvRjlVYVE0SFJmYkhH?=
 =?utf-8?B?ck5UMUc1Z3crVWZtZGlKcFhHOSs1MG5Ialhhbm8vQWlhYVVKbXZIWFVLKzBv?=
 =?utf-8?B?UExtb01EbThkOGlNekxkSlR4bWZwT1paS3JDT1NwNVZadmpmMUZQSUl3RnhV?=
 =?utf-8?B?RnZGazR0eVR3SmxyT3o3TGhvcW9TNHhaSzJZSnBCcTNTbkZQeGl3c2RMT2tn?=
 =?utf-8?B?U1hMaExlNFRyUmV5cjRSK3RERE5zc2g4ZWxCYTVxMGRJVE1uNHpmVFZRdzJr?=
 =?utf-8?B?SHVUL0x5QTZlem9IYXBmaTdkMmF4ZnRBV2dUR0twdUlleHdvajIxdHpSOWhk?=
 =?utf-8?B?RmZpZEs2Q2M5SlpCTzRFd1dYMUpoMmpqWTZsVTJBaFBvTnYzZlRRV0Q4S2di?=
 =?utf-8?B?Qkh6MHlldGtpWmJycTR1aENBUlZMODFiVFFpM2I4UWl0WlFLVllFbTJZKy9l?=
 =?utf-8?B?VmNsT3REajZWRktlWkpGcWduTEVBMEF1MS83TG5xV05PR2ZJR0N3QkJTbEpE?=
 =?utf-8?B?OW1sRldFWnNrZ3lqVUlKU3NiTkdSaW1PQ1N2L2ZQcUJTMVo4anF4ZFFCazNE?=
 =?utf-8?B?dEwzTkcvRExNbG51dEgreG9WOHZWQldyaktBb0JZaEFZaDQrdHNiN3NqT1do?=
 =?utf-8?B?WUl0MkFFTGEySEtNT21nazBOZzRTdDAzczVHNmI2N05lUUNNVTNRQmdCTGpB?=
 =?utf-8?B?V3dXV3lQSHQxZzMySlB2YUpjdkVCdElVSjgyUWVpWW91Z09OTnFwT1BEcEh1?=
 =?utf-8?B?LzZDaHpGVUFmcFFjaXZvS3lFQzZIcUlKaHRqbnY5ZWRYNnBRMWFZUXIxSTVm?=
 =?utf-8?B?UzRLZUMxWXNGQ2ZrWVc0ZExGdUxjL3NjVTBTY0VNY295SUFXLzdXNmc5Zm5G?=
 =?utf-8?B?cktCdTl3Q1JsMVlFTXJ1TWlSbWhyNG1pNGpWOHVhbHJ3Vy9zQzlIMWVocE5X?=
 =?utf-8?B?c1kra3c2VDdSa2ladjg1Nm1CRjZVMUpidlhuN0IxZU9VWTJneTZHdHROcUtz?=
 =?utf-8?B?SGVYTFBUQzBEVWpNWithVlp3MHNFcTYwemQzUmUwZnF2WnFaNjIzWm05Wi9v?=
 =?utf-8?B?NWcwdWsvWlBsTmZHdTJ0eVAwaEZLdThWb3dVY25qRk96bUpsTmFFQ0owWkhE?=
 =?utf-8?B?cHVBeS90L0laSWFnMWhRWEhYeGliTERYOTFmdGNUK1VJQnA4UHhLSUEzbXpI?=
 =?utf-8?B?blEzeGhycVJSR3crR0xhTnJ6UWw0Ym9sU09IWE02T2lIK0dnc1VJN0Q0K2RU?=
 =?utf-8?B?QitRUUNVOGttaTRjeDlEQXV3bmZ4dGVUdlFicTl2cWZudGFrT2Iyc01HdlVI?=
 =?utf-8?B?SUx1Sk5YaUpaRWx0M3lVRzlKUWNzZmZtMHZCOHl4Um5oV2pjUFI4WU8wYWZF?=
 =?utf-8?B?WE9hS3hlRjNjS1R0VC90eGRvZlNIZkYwZThvTmdSSjJaVGUybmhwK2ljYzFG?=
 =?utf-8?B?ZnpOWlN6ZnN1akcyNHNLLzhBZTljRHNvRnVnTFY1VFVUZk1zYk94WWh2UEtm?=
 =?utf-8?B?WDBxSjVrbndtenhJdEgweVlINWhmeUlKSmg0S0FXSlJoUzJndE9iVDZZNUpo?=
 =?utf-8?B?NCtKNTlQdWlKc295eEpLYjZYVWFxaGN2RENUM0R2TWp6NitGeDYzTHJaVC9n?=
 =?utf-8?B?M21YNkFQbzJDNHJMSEhPakplZnl4Zm1VeWtkUmV6ZzZNZHNHVUZaSVlPNlIz?=
 =?utf-8?B?SW5QZ2oxajdqM2ZWUWxuVFJzUWpCNzhjOU1LUHY1NStyVWJTMzFxS3hLd2ds?=
 =?utf-8?B?dW5HalA3UVlNRm9xdHUyMkxMNHozZGtlS2JYSms5NDBWaGtDcnJ3RTJ1Qmtj?=
 =?utf-8?B?aHAxckw3YmNXNEo0dll5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEYwQ2Z3bnhIL0FrSE9xd3Q3N2R6WXZ1WGhIN052Ni9XZy91djBObG1VL2lm?=
 =?utf-8?B?THZGbkpJR0ttWXh2MkhJSVRVS254NEs4K3lHKzlBM1FReEpLbTYvVkNIdGNz?=
 =?utf-8?B?QjJiZ1Z1NWxMSW9ObWIwQ00xay9TTHg4b2FpSEd0NmthSnQzTG9KQlVoeFdj?=
 =?utf-8?B?cHlJWVdPZkRKVW15NVI4S0IxVzBNaUQvZlM5NFFVd0RjcVBBQ3RuN3h1MTJr?=
 =?utf-8?B?NjBWb1p3M3VkNE9WM1VCd3FPVjdHeWRJRTQwcVdoWG5SL1NINHhQN25MR1Zh?=
 =?utf-8?B?YUFFenBVNld1MHZXZDRXeHIzVERnMitlSXFzSnZBcnBLcUJTS2xVeWJtVm9Y?=
 =?utf-8?B?Y2JzY0ZmcDJBbm52M2lyZ1o0b0YzSGxhUUZNMGl3RUkrd1VuV3p2a0ErMlVO?=
 =?utf-8?B?Q2dYa2toTmh0c3VUZVBVNjVjM05DazBQWVlra095NTRsRjBvajNzMUNSTUJz?=
 =?utf-8?B?UWY5OThiTmtsMllVejlMWmVVMXlHd0p0WG80ZlRLMWhmQmRsL2o1QXRxcTlt?=
 =?utf-8?B?blFwRWV5d3FaaStxWTJFTFBkVFNnQ3E4NWl6N3l3cVBreG5XN0hVTjdsTDNK?=
 =?utf-8?B?SHhHcGs1U3Zma2pMZW9MWi9rOTYyVlJhMFU1cFNFT3A0dWZ0Ly9tQW11MFhX?=
 =?utf-8?B?a3VjVUhIVTRJL2FseUtCOFcxWlJHYzU3TVpzWmhKcWtRc09zVlU4a3VBbGUx?=
 =?utf-8?B?TlJtM1RjUEN0WGNRelBsUEVJM1JkSDFxQTY5OW9NTnllZVpEUGRtYXg2Z052?=
 =?utf-8?B?QXdMQTFjUEtmc1ljdVJNLzFTZGQ1N3U3VXRmbkI4R2R1aERzbnphMGxSUFZK?=
 =?utf-8?B?d05ibVBZeC9NaUpZWmdaVUNaM3YydmVCZERuQ0NOZ2g4UGhzei9jd09MQU13?=
 =?utf-8?B?ZHFOL1NUUHZQSlozSjZ1eG1kZ1dBYU1mVlYySVVSeE5vdDRmbnN6OWFjUDMz?=
 =?utf-8?B?bm5VdG56bFB1ZXJGcUxiMGJqSmJQME5EOGsxNnJRcWFSeUpUVnZXK2I0c1k0?=
 =?utf-8?B?NXltTVFoVDd4cCtPZzNmOUFodWxEVU5tNXFVTXNuQWRPSVNzb0w5eWtIcFFY?=
 =?utf-8?B?V2JwS2NwVDJVZFZpNFNIU3ZMNWRKL0hTNi9XU3pjbkl1NkcxSWQ2ZUEwaUcv?=
 =?utf-8?B?a2NEb1YweW93UEhPcVAycWJyVE1IbEFLMkJkdFkwK2M3eWJPN0R5eUF4Qzhv?=
 =?utf-8?B?NUUzT3daeEVJYU44Y1dpb29DTUU2ZkY0WHUzSENGZ0swMkREM1M2NHdSaDg2?=
 =?utf-8?B?UkJnRVZuRFQ2U3Q5QjYxOGNqQWZPSjFJeTZTVms0bVdGUTV4b3RHZkJhUXVk?=
 =?utf-8?B?ZTNadEFxbmRUMTNZYUptc2VBTFoxN0p1UHZCMDZ1MHNMbkVxSmVIUHpiNVhX?=
 =?utf-8?B?aUVtRDFjeEpMU1FPdEkvZ0cyTFN0a2diYXBtcldLTDRoNVQ3Qy8vbDR2TUZw?=
 =?utf-8?B?NVFURWN5WlJJejAxV1pvWFI0b24yMnhOYklLM0tEMWN0U2huUVY4WUdZVTIy?=
 =?utf-8?B?VitLMStKY28zc0xNYkpUYngrNlpMVkd5QVo1MVhHQVRRaE5yemlNb1RiWmF2?=
 =?utf-8?B?anZmSWplUHU3TWFBTkc3ek9hbUY5SHFVekpsR29zY2YraGpJcm5iRVVwZ1JI?=
 =?utf-8?B?bGxFU2RWNENBRVdML1JDc0daYXMzY1VvZHB5NWErUmRUNmdZTmpzbWJmVStY?=
 =?utf-8?B?a2NzcmZ5aTFWdWV2elIvNU1ydUJpME1yWDl6SW4rWXhKUzU4bEFadUdIZU1G?=
 =?utf-8?B?c2FyTm1wK0ZER2EyT3dCcEUzMklLNGFFaVdLc1hTeUd6K01sVlRvazA3R2hj?=
 =?utf-8?B?MEdieHhzOGdjRUJ6MGg1dGNkZjBiNEFGVWFEM2liOUFRQ1V1LzBpR1gxcWFz?=
 =?utf-8?B?VmpqYlNpQzdYUEx6cFBqQW9jbE5jMXprQXN0bzR2ZldVclQrRHJkV3ZIcGJV?=
 =?utf-8?B?emFEd3ZkeFZ0Y2FoZWV1eWU0eVJTV3o4Z1JzdFlWSFlDSG9qQ21mMEQzWExY?=
 =?utf-8?B?a1RqRGdObGs3UUFhTVZGbXpJOTAzN0Zja2lNYUhHdDVUbytjNUJUSlU4bFdw?=
 =?utf-8?B?Z1luQUZsRUtDQkhmZmdHZllITU81QkxaWEd1aEVpd2tHLy9TZEwzckpxTDhG?=
 =?utf-8?B?SVo5M2pYcWFxMWlSeGVBQXYrL0I1OUJXcnNXWDhjb203UmNjdnJmZWJzNzZW?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36e6670-5eb7-4625-7434-08dd5826bdb5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:35:57.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYXAcPwx8K8BQ0nuCt0vOXAp0r6Q97SqBReETI94UHSR7mDb7gcXez44NFn9yFjZlqA8DfBErnqAEEw1cUFMGGuAh521Fd8KgF0emoOt3kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8253
Received-SPF: pass client-ip=2a01:111:f403:2612::720;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 2/28/25 8:20 PM, Steven Sistare wrote:
> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>> Hi all,
>>>
>>> We've been experimenting with cpr-transfer migration mode recently and
>>> have discovered the following issue with the guest QXL driver:
>>>
>>> Run migration source:
>>>> EMULATOR=/path/to/emulator
>>>> ROOTFS=/path/to/image
>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>
>>>> $EMULATOR -enable-kvm \
>>>>      -machine q35 \
>>>>      -cpu host -smp 2 -m 2G \
>>>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>> ram0,share=on\
>>>>      -machine memory-backend=ram0 \
>>>>      -machine aux-ram-share=on \
>>>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>      -nographic \
>>>>      -device qxl-vga
>>>
>>> Run migration target:
>>>> EMULATOR=/path/to/emulator
>>>> ROOTFS=/path/to/image
>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>> $EMULATOR -enable-kvm \
>>>>      -machine q35 \
>>>>      -cpu host -smp 2 -m 2G \
>>>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>> ram0,share=on\
>>>>      -machine memory-backend=ram0 \
>>>>      -machine aux-ram-share=on \
>>>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>      -nographic \
>>>>      -device qxl-vga \
>>>>      -incoming tcp:0:44444 \
>>>>      -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>
>>>
>>> Launch the migration:
>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>
>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>      migrate-set-parameters mode=cpr-transfer
>>>>      migrate channels=[{"channel-type":"main","addr":
>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>> {"channel-type":"cpr","addr":
>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>> dst.sock"}}]
>>>> EOF
>>>
>>> Then, after a while, QXL guest driver on target crashes spewing the
>>> following messages:
>>>> [   73.962002] [TTM] Buffer eviction failed
>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>> 0x00000001)
>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>> allocate VRAM BO
>>>
>>> That seems to be a known kernel QXL driver bug:
>>>
>>> https://lore.kernel.org/all/20220907094423.93581-1-min_halo@163.com/T/
>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>
>>> (the latter discussion contains that reproduce script which speeds up
>>> the crash in the guest):
>>>> #!/bin/bash
>>>>
>>>> chvt 3
>>>>
>>>> for j in $(seq 80); do
>>>>          echo "$(date) starting round $j"
>>>>          if [ "$(journalctl --boot | grep "failed to allocate VRAM
>>>> BO")" != "" ]; then
>>>>                  echo "bug was reproduced after $j tries"
>>>>                  exit 1
>>>>          fi
>>>>          for i in $(seq 100); do
>>>>                  dmesg > /dev/tty3
>>>>          done
>>>> done
>>>>
>>>> echo "bug could not be reproduced"
>>>> exit 0
>>>
>>> The bug itself seems to remain unfixed, as I was able to reproduce that
>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>> without the cpr-transfer migration the above reproduce doesn't lead to
>>> crash on the source VM.
>>>
>>> I suspect that, as cpr-transfer doesn't migrate the guest memory, but
>>> rather passes it through the memory backend object, our code might
>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>> corruption so far.
>>>
>>> Could somebody help the investigation and take a look into this?  Any
>>> suggestions would be appreciated.  Thanks!
>>
>> Possibly some memory region created by qxl is not being preserved.
>> Try adding these traces to see what is preserved:
>>
>> -trace enable='*cpr*'
>> -trace enable='*ram_alloc*'
> 
> Also try adding this patch to see if it flags any ram blocks as not
> compatible with cpr.  A message is printed at migration start time.
>   https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-email-
> steven.sistare@oracle.com/
> 
> - Steve
> 

With the traces enabled + the "migration: ram block cpr blockers" patch
applied:

Source:
> cpr_find_fd pc.bios, id 0 returns -1
> cpr_save_fd pc.bios, id 0, fd 22
> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host 0x7fec18e00000
> cpr_find_fd pc.rom, id 0 returns -1
> cpr_save_fd pc.rom, id 0, fd 23
> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host 0x7fec18c00000
> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size 262144 fd 24 host 0x7fec18a00000
> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size 67108864 fd 25 host 0x7feb77e00000
> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192 fd 27 host 0x7fec18800000
> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size 67108864 fd 28 host 0x7feb73c00000
> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536 fd 34 host 0x7fec18600000
> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size 2097152 fd 35 host 0x7fec18200000
> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536 fd 36 host 0x7feb8b600000
> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd 37 host 0x7feb8b400000
> 
> cpr_state_save cpr-transfer mode
> cpr_transfer_output /var/run/alma8cpr-dst.sock

Target:
> cpr_transfer_input /var/run/alma8cpr-dst.sock
> cpr_state_load cpr-transfer mode
> cpr_find_fd pc.bios, id 0 returns 20
> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host 0x7fcdc9800000
> cpr_find_fd pc.rom, id 0 returns 19
> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host 0x7fcdc9600000
> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size 262144 fd 18 host 0x7fcdc9400000
> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size 67108864 fd 17 host 0x7fcd27e00000
> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192 fd 16 host 0x7fcdc9200000
> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size 67108864 fd 15 host 0x7fcd23c00000
> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536 fd 14 host 0x7fcdc8800000
> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size 2097152 fd 13 host 0x7fcdc8400000
> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536 fd 11 host 0x7fcdc8200000
> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd 10 host 0x7fcd3be00000

Looks like both vga.vram and qxl.vram are being preserved (with the same
addresses), and no incompatible ram blocks are found during migration.

Andrey

