Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC61CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lEh-0002o4-WA; Mon, 06 Oct 2025 09:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v5lEe-0002k2-KH
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:26:41 -0400
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v5lEQ-0004fB-6c
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVpWlBgRJpRr7l5MGv+ELa3b3gEEzj7/hJEArCuslRU0RMNDMql5h1X2IS4YJUVf3gjY3mlRnE+IgVv6GO2oyVQpA0XUnA88IPlIz1d81cs7mtPY8L/9YLkAn6vtm1ApaG8YemIoWB0OrFdEsWeMa2EeKvOXGwUHt+HsJSQonoDbsd6KVHmjySR8xlgf0xr2Dwg3DhmSxarkWAn3BkVizWCmiwJEdmf6knd4FJvHYebw7oBj5TK5GDM0vHlhw7YiHpjR5PodvKhAPkaPUwNqQqwJ9y9uU3qldK40wGWN4LbSB8vLlsfWu96Mxv8d5qkLxtqkUOUylOKFk7OVlAFyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYONIQ0pas/YZ8d7HidqhjtFyYuZqFj9tzJ5UXpJfgY=;
 b=XItbjtwYvlZz3pwsmq47z9ZE1JxkmF8/SfxrhtwgdQ1EHhyQw6pV8/OMxFtgU6K9unvixmRZrLUuAdCvi957Cjd+ACYErlONWTxXZirI36vbBlA2V8nXP7VOfTrOJNGL5qDwlNH/M5hrIFjKtt4Y+mviufjizdtvin/9Rj/6ESxKuJMpTcg8PsqfdInKQYG6n7XAQxMS5yPu7HBPuISiDwTG157/aRycFFelbt9NESKrOFunGuSCeg+Kr73TpJUufKjzFv4O9TnNqy63lQGGmjfsAqxwLKm7sEu/KMYhBNvX4aVuG0LNgxhaRS/EjA7wXl5fJfOX0hqeZb+nL1PsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYONIQ0pas/YZ8d7HidqhjtFyYuZqFj9tzJ5UXpJfgY=;
 b=jGiOUGOPpLT5FQpPnWY2jklDSrh7lP7ahAM9G/2ugD+b4M3dy/+ixBGvjGKxNO7WKAmB96ssX5g7pBMVf3xk0jj74XJVekHBkgV4LaFumwyjINkan3NZ1dZGS/ZhmzBGce4Xe/eYs605FFBU284QIPVDT4u8ED+d8hdyTz7hudw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1185.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 13:25:44 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69%7]) with mapi id 15.20.9137.012; Mon, 6 Oct 2025
 13:25:44 +0000
Message-ID: <b461feb8-4ad5-481d-a497-dcb10b12ee79@epfl.ch>
Date: Mon, 6 Oct 2025 15:22:27 +0200
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH v2 1/2] plugins: Add PC diversion API function
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
Content-Language: en-US
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7228ffd4-4c18-46ba-371d-08de04dbdab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRqWkhRZm9ySlVRKzRQYWVKWExNcCt5S3RqUEZRS0MzQWFIdjY0eU1mN1Az?=
 =?utf-8?B?aDJGQnlFTkpHN3BxbmNhQ0ZMNU1nb2NMbFdWWlBLeG5WWStVU1JCYVkxZHdi?=
 =?utf-8?B?U0pkN0RPZWxleElZNjJJbG1mNlBaYld1Sk13ZGhkam5EWnZTNCtadzV1THBz?=
 =?utf-8?B?QjFzdmlQck1iNVlZUXFWdUtFRDVtVzBuRFRueDZWVzJHMXZIUGx4U25YY1Fy?=
 =?utf-8?B?UDFXbklucUlQaWZiRXIxUXhzNzFOZVpCRE9FQWlNK0p1Q2l5RVpGcmRoMXpY?=
 =?utf-8?B?dGpFRzc3empGQk1ENlJLdkQzMkdFRm1zejhrckxYNVg0UGNMQ3dBaDV2VUhW?=
 =?utf-8?B?WmVzU2JkQjdVakRsdXVKY2RLMGF3TW5ibEhPbHZxdHdhQ2ROM3RiZXNTWmZl?=
 =?utf-8?B?WlZtOGtqditPMTJYb2dML0xiSjF3Z01TbDJCaFkrbnFXZmhOaGc5N1ltNVU2?=
 =?utf-8?B?bjlxcnU0SXBQcDdNUDNEUDhNSHdRSjBiSzN5aVdpNDRZZGZKSFRnS01LWDlM?=
 =?utf-8?B?RXBDVGd6UngrQ1czQTlMTk9ZS0dablhXaitIVHJNL1VMYlFQSEp1QUM0c0Nx?=
 =?utf-8?B?N2tySnpJUmFZWXpuZXpMMlY1RlB3akoyS1Z5VXd3a3NOM00xTXl6aTUwWFhr?=
 =?utf-8?B?bTJuT0c2NG1sMWVSSzdacDF3dVFSUTdEd25FNmREM0NtaXlybkxRS29wR0Ny?=
 =?utf-8?B?d1V4Vk0yK1NXSER5dlZiRTJZZTI4ejZyUlBlN05PSGcvYk5sd0JTSklKck10?=
 =?utf-8?B?NTlyKzJSaHhEanFsSU1GeU5pRUFzdTd1RnozU1hzOHIzSjVpdUxYeFhkV0Yr?=
 =?utf-8?B?QkZ3RE8xQzFpN3VhRnlzSC9xekNPc2dWVXBQaEF5Y29ScXFDOGluaEI4dEo2?=
 =?utf-8?B?NlFHQjJOR05mSjNjQ3dSYlpmSW9NT3FNSlBGWERTdmtIVG44ZE1MWk9zdmdQ?=
 =?utf-8?B?dm1SY3l5a1BEWm02dCtRYTEwN2hORDRhYzJYN3dUaHIva2V2eGkwMFFPNkUw?=
 =?utf-8?B?ZFJ0VEw3RFIzZk9qMlJBNTA0Q2Y2bWpDaDdXdHVLaXJpWDBkQUtFdExUTFVn?=
 =?utf-8?B?bFVvOTUwcG5Hend3QWpzTXlLeDNvbVZhc1E3VkFGUW4waGdWSnZmeXk2R2sw?=
 =?utf-8?B?WFQ5cHk4eWI2RHhMZUgzdngrMzNYNE95V3NHbTNuTFhhMnRRMlJYV1B4dzVY?=
 =?utf-8?B?b1pJQXhCSktpdCtuQllPOE5wTHI4VWFnblpqSVVDTFVVeElNQUNsVzVLUi83?=
 =?utf-8?B?cTZ1SnoxNVIyWXhjeDFGcGZBV2V6ZXlEekJzNFcrTlRlbjhwL2dhTmp1OHM2?=
 =?utf-8?B?dGNiRnZnRFc1QmJNaVFoYmNEQjdlRUhTck5iNnVCTlVxbHJqWkFhL2cyOGNW?=
 =?utf-8?B?QjArKzk3dGdJQ1BtSHhWSnVPRzVJSzlZYUhCblR1ZmxlZzRGUWQ4a3crWUxS?=
 =?utf-8?B?MjZMc1NTczlQMTR5Y0RUTDdRY3JFV3BNVlhxaDlza1dsSENMT3BXM0xzNjkv?=
 =?utf-8?B?cWVUWlpzcXVZVWpOMk9ucVlpT05pZkEzZzRaaWJHUVFWUFlUdGVuZHd1M1l5?=
 =?utf-8?B?UVYzbmVUS0ErK3JpbVh2TDZpci8zMjFDd085SFUySE9zYWUvRHU1SE81RmVP?=
 =?utf-8?B?QnJOYWJpZGE0dDgxbGNxVHZlM1FvVG1rbEkzWVVqWUhCVWNTNEVLVlNCV3c4?=
 =?utf-8?B?Wklud3lFeDVjajFwd2c2T2tHbUZVQmRqVzlTN21UOE40N0FEa0NDYk1rd2Qw?=
 =?utf-8?B?ZFFULzJOS0JUOHA4UnI0ZWtEc3ZMMUlRc0c2alBSREFxWk9RSFZTUmdkSUFw?=
 =?utf-8?B?aHlWTVVkOGdydUdDeGxpUFhvV0phZEdpNW1KYlZuRU9sdXZMMCtlQlM2d1BD?=
 =?utf-8?B?b2YreUFnYWZucC9JTzduWUJPN2ppVDV2MGRpc21YSktaa3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(13003099007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekpYUWt0b21vazZwcFA1TEk1ekpaTDc0QkRvQ2c2Rkw0STBvd09IUnczQ0Fk?=
 =?utf-8?B?V0pUVzh4Tld1MkxoM002Lzg5RDNCZ2Z6T2dMNUVYN1drSy9NV1dQWHczdWZr?=
 =?utf-8?B?bnNZY2lwZ1R0UDBxN01PYlh2a0psTUVUQWlGUFMrVC94NWJPZUoybFJTbkE0?=
 =?utf-8?B?RHFVdC9TQVZiVXFQOWZkenlwU00vS2s4OE91U1BzR3k2QU1Fa3BmWm1aNXQ5?=
 =?utf-8?B?ZWpNSXJOeitYbVJKQjd0Nkl2NC9KL29iTndLZWl0NGc4NXFzWjZtQ2UzeVM2?=
 =?utf-8?B?UmgyK2ZxTHNCUkxldGxNb09lUWdBcFd2U05nL1BWZzF2ZHY0eGE4ZzladCtO?=
 =?utf-8?B?VlIxZVJneHdyQzhVL2RuaVlqTEZ2YkxHWS81L2o5QUllTU9uc0h3K0NzVGR3?=
 =?utf-8?B?My9rTU5IQmJGbk5zNkMvQkh6cmlHNi9JZmpsZ0pxdGNuZE5rTzFFOGE1NEdv?=
 =?utf-8?B?RU40TUNnS0ZJNHZtVWR0SFB3QmlFVTAzNlBRRExPdWU1NGxmYklOLzc4cEVm?=
 =?utf-8?B?dGdKN21KUlVnczRhODh2UkhibkFQRDFldE9KOWlIS2NNclV3KzVtTUNWZGhD?=
 =?utf-8?B?T1Zualdwd3Bza09XMWpiaDQ1WEk5VFd0Y2NMdEdOSE1jRlJsRFYwdCs0Qk4x?=
 =?utf-8?B?M0hZSXZPUXUrc2pRMUdHaTJ2UWNtOEZId3VwWXp1bkVCbFNpNFVvNk02cDlG?=
 =?utf-8?B?YmZqbzFHMU9xT0prUEUzZjNoeG1lNlY3dW8zR1FHSGNDYmhaVklQbDlpck1n?=
 =?utf-8?B?ZXlEWE9BZXF1N3VrMXNkVzFReXhvSVBUZUVpcnkxcTNZa2tiY1QxT1lrWmJp?=
 =?utf-8?B?S1dENXZjVStTcktBb3ZpTmROS0VrQUtGUnZFMnY3emRYZUdiOWJlVzBFWFRr?=
 =?utf-8?B?OUI2b2QvbmVxQ0g5akliVEFVTHRaMngvNndBNTZ1K3JmSE4wQmhqY3lSTmhB?=
 =?utf-8?B?RjlmaDBZZjd2R1BYN2pSOXE0Y0hTUU9kM3h0TDJWOEJ2aUJ4TVFiMFVwejBy?=
 =?utf-8?B?NHk1Q3R0OHZqL1Q4NTJUWjVjbUhyaWMrSy9BYmhzTnRQZTR2akppa3NHRTF4?=
 =?utf-8?B?aWpUYTFlUzFyRHVhOHEzMHNGQ2NVdXhzWEk3MnV4TXZ2RW1RcnJqVHcvVi9L?=
 =?utf-8?B?NDBPZElBRXFNZU9sVEZwdHV2ODNYSW5ZZzJlZjAwcW80Vis2N2tnZmxZWGZa?=
 =?utf-8?B?OVp1ckRrSkVuV2orMUFvUUpxQlRKS0VkeXU1cEI4c3lVcXhFM0xzNThPWERW?=
 =?utf-8?B?aXlzQzhGUG1jdnp2S3krdHFUdGNkazNKSFJwY1ZvVC80UnYrSFB4enRLKzZI?=
 =?utf-8?B?RGkwcEFSRjlpTFk2QUduMy95R0lYTXIvZnRTWnJlK2drRSttR29GbVJacVRh?=
 =?utf-8?B?QW9ubkhTaVZWZTAyRVpyUEJvdjhOb2FZUDREL296KzhpU0REQW91aUtXQW5p?=
 =?utf-8?B?L1N6MDRFTzZ0ZDY4eGIvOTcyL0JrL1N2OExTZ1hVRmNXNGNrMnp3cmdJeU1a?=
 =?utf-8?B?S2hld3BCNDQ4WWJJSzB1SEVPSWFFa0hGSFRpWFlvcFFLSDlPaG5UbFdpM1ZO?=
 =?utf-8?B?TGQrYXR6bVU3MjY4cjZlc1BUa0lmaWZDZHBkQVlqdGxyOC9VNVdYVG4rN0lk?=
 =?utf-8?B?Qjh0NXB2QStrREhONkY2b2dEaUxzdGxqUHNUNWtUZHlHRHBXV3JzWHQ0NzV4?=
 =?utf-8?B?Q0M1VWluQTQvVE1hT1JNbnNMOHJwQ1ZFQmI1d1laWkd1bFhneDBhNENXejZY?=
 =?utf-8?B?N0ZrVm0xOEx5elpJNXFTcy9palIyNkVQVnQ2NXpCK2FNTDlmbWQ2b05HcnBN?=
 =?utf-8?B?Z3dxQWpsRkxTZ2J6RE5lVEJiWEppVU9qeHl6MjVtUHpyeGUvNGlGdlBsWG1y?=
 =?utf-8?B?Vy84eFRwMWtEOUozMlRaUFBoY2VBeG55bWpWd294d0gxeWl3MERMSXJUTjhI?=
 =?utf-8?B?a3pZb1YrUGJjMW53blJyYUpNTWxWSVRXVzNvaytudmN4UG1PQ296TThGQTlY?=
 =?utf-8?B?OUd2YWhOd2tkakp0bURkcFhUbGh2YTZ2NVptcDM2dWVVNmZTeXVQL3Bvd0ZE?=
 =?utf-8?B?empybmZhQnR2aXpNL2FmcFdjTk1mY0QyOWxjL0o5UStJbzNMRm44bkcrS2VR?=
 =?utf-8?B?bFZJaCtGOWY1eFVlaVJGL1pjT01sMEV0ZXdyRDd4bnNIQ3hNZGQ5bEZKWGYv?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 7228ffd4-4c18-46ba-371d-08de04dbdab0
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 13:25:44.8045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2LxKCjuz8K1Nn8ORO7P+joRRISTarYcD4q4hVQu7o7AX1ApSuiykka8t0TApReYAntQBj5L4mI+Lfc4lIReYNxgouR3PYkNKR5WclWfLn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1185
Received-SPF: pass client-ip=2a01:111:f403:c213::2;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This patch adds a plugin API function that allows diverting the program
counter during execution. A potential use case for this functionality is
to skip over parts of the code, e.g., by hooking into a specific
instruction and setting the PC to the next instruction in the callback.

Redirecting control flow via cpu_loop_exit() works fine in callbacks
that are triggered during code execution due to cpu_exec_setjmp() still
being part of the call stack. If we want to use the new API in syscall
callbacks, cpu_exec_setjmp() already returned and the longjmp()
triggered by cpu_loop_exit() is undefined behavior. For this reason, we
introduce a new return constant QEMU_ESETPC and do another setjmp()
before executing syscall plugin callbacks and potentially the syscall
itself.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/qemu/qemu-plugin.h         | 15 +++++++++++++++
 linux-user/aarch64/cpu_loop.c      |  2 +-
 linux-user/alpha/cpu_loop.c        |  2 +-
 linux-user/arm/cpu_loop.c          |  2 +-
 linux-user/hexagon/cpu_loop.c      |  2 +-
 linux-user/hppa/cpu_loop.c         |  4 ++++
 linux-user/i386/cpu_loop.c         |  8 +++++---
 linux-user/include/special-errno.h |  8 ++++++++
 linux-user/loongarch64/cpu_loop.c  |  5 +++--
 linux-user/m68k/cpu_loop.c         |  2 +-
 linux-user/microblaze/cpu_loop.c   |  2 +-
 linux-user/mips/cpu_loop.c         |  5 +++--
 linux-user/openrisc/cpu_loop.c     |  2 +-
 linux-user/ppc/cpu_loop.c          |  6 ++++--
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 linux-user/sh4/cpu_loop.c          |  2 +-
 linux-user/sparc/cpu_loop.c        |  4 +++-
 linux-user/syscall.c               |  8 ++++++++
 linux-user/xtensa/cpu_loop.c       |  3 +++
 plugins/api.c                      | 17 ++++++++++++++++-
 plugins/core.c                     | 25 ++++++++++++++-----------
 22 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c450106af1..be72ef9d70 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -261,11 +261,14 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
+ * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
+ *                             regs and updates the PC
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
     QEMU_PLUGIN_CB_R_REGS,
     QEMU_PLUGIN_CB_RW_REGS,
+    QEMU_PLUGIN_CB_RW_REGS_PC,
 };
 
 enum qemu_plugin_mem_rw {
@@ -943,6 +946,18 @@ QEMU_PLUGIN_API
 int qemu_plugin_write_register(struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function only returns in case of
+ * errors.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 50a4c99535..d220d18696 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -176,7 +176,7 @@ void cpu_loop(CPUARMState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->xregs[0] = ret;
             }
             break;
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index f93597c400..bef196b1f5 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
                     env->pc -= 4;
                     break;
                 }
-                if (sysret == -QEMU_ESIGRETURN) {
+                if (sysret == -QEMU_ESIGRETURN || sysret == -QEMU_ESETPC) {
                     break;
                 }
                 /* Syscall writes 0 to V0 to bypass error check, similar
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index cd89b7d6f5..ef77b56785 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -416,7 +416,7 @@ void cpu_loop(CPUARMState *env)
                                      0, 0);
                     if (ret == -QEMU_ERESTARTSYS) {
                         env->regs[15] -= env->thumb ? 2 : 4;
-                    } else if (ret != -QEMU_ESIGRETURN) {
+                    } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                         env->regs[0] = ret;
                     }
                 }
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 1941f4c9c1..9adb3ec4c6 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->gpr[HEX_REG_PC] -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[0] = ret;
             }
             break;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 356cb48acc..5c8d2577ef 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/compiler.h"
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
@@ -135,7 +136,10 @@ void cpu_loop(CPUHPPAState *env)
                 env->iaoq_b = env->iaoq_f + 4;
                 break;
             case -QEMU_ERESTARTSYS:
+                QEMU_FALLTHROUGH;
             case -QEMU_ESIGRETURN:
+                QEMU_FALLTHROUGH;
+            case -QEMU_ESETPC:
                 break;
             }
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index f3f58576af..fe922fceb5 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
     if (ret == -TARGET_EFAULT) {
         goto sigsegv;
     }
-    env->regs[R_EAX] = ret;
+    if (ret != -QEMU_ESETPC) {
+        env->regs[R_EAX] = ret;
+    }
 
     /* Emulate a ret instruction to leave the vsyscall page.  */
     env->eip = caller;
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
diff --git a/linux-user/include/special-errno.h b/linux-user/include/special-errno.h
index 4120455baa..1db757241a 100644
--- a/linux-user/include/special-errno.h
+++ b/linux-user/include/special-errno.h
@@ -29,4 +29,12 @@
  */
 #define QEMU_ESIGRETURN   513
 
+/*
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to
+ * indicate that the plugin deliberately changed the PC and potentially
+ * modified the register values. The main loop should not touch the guest
+ * registers for this reason.
+ */
+#define QEMU_ESETPC       514
+
 #endif /* SPECIAL_ERRNO_H */
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 26a5ce3a93..603fcc39c7 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
                 env->pc -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
                 /*
-                 * Returning from a successful sigreturn syscall.
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
                  * Avoid clobbering register state.
                  */
                 break;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 2c9f628241..b98ca8ff7b 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
                                  0, 0);
                 if (ret == -QEMU_ERESTARTSYS) {
                     env->pc -= 2;
-                } else if (ret != -QEMU_ESIGRETURN) {
+                } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                     env->dregs[0] = ret;
                 }
             }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 78506ab23d..06d92c0b90 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
             if (ret == -QEMU_ERESTARTSYS) {
                 /* Wind back to before the syscall. */
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[3] = ret;
             }
             /* All syscall exits result in guest r14 being equal to the
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 2365de1de1..af98138eb2 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -140,8 +140,9 @@ done_syscall:
                 env->active_tc.PC -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
-                /* Returning from a successful sigreturn syscall.
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.
                    Avoid clobbering register state.  */
                 break;
             }
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 2167d880d5..e7e9929e6f 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
                              cpu_get_gpr(env, 8), 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 cpu_set_gpr(env, 11, ret);
             }
             break;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index b0b0cb14b4..1f8aae14bb 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -340,8 +340,10 @@ void cpu_loop(CPUPPCState *env)
                 env->nip -= 4;
                 break;
             }
-            if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
-                /* Returning from a successful sigreturn syscall.
+            if (ret == (target_ulong)(-QEMU_ESIGRETURN)
+                    || ret == (target_ulong)(-QEMU_ESETPC)) {
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.
                    Avoid corrupting register state.  */
                 break;
             }
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index ce542540c2..eecc8d1517 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
             }
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
             if (cs->singlestep_enabled) {
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 4929b32e1f..67d2a803fb 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
                              env->regs[6], env->regs[7], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->psw.addr -= env->int_svc_ilen;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[2] = ret;
             }
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 0c9d7e9c46..ee2958d0d9 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gregs[0] = ret;
             }
             break;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7391e2add8..f054316dce 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
                               env->regwptr[2], env->regwptr[3],
                               env->regwptr[4], env->regwptr[5],
                               0, 0);
-            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ERESTARTSYS
+                    || ret == -QEMU_ESIGRETURN
+                    || ret == -QEMU_ESETPC) {
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d78b2029fa..f74b8ac596 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -43,6 +43,7 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
+#include <setjmp.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <sys/un.h>
@@ -584,6 +585,9 @@ const char *target_strerror(int err)
     if (err == QEMU_ESIGRETURN) {
         return "Successful exit from sigreturn";
     }
+    if (err == QEMU_ESETPC) {
+        return "Successfully redirected control flow via qemu_plugin_set_pc";
+    }
 
     return strerror(target_to_host_errno(err));
 }
@@ -14077,6 +14081,10 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         return -QEMU_ESIGRETURN;
     }
 
+    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+        return -QEMU_ESETPC;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index a0ff10eff8..7680e243bb 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/compiler.h"
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
@@ -185,6 +186,8 @@ void cpu_loop(CPUXtensaState *env)
                     env->pc -= 3;
                     break;
 
+                case -QEMU_ESETPC:
+                    QEMU_FALLTHROUGH;
                 case -QEMU_ESIGRETURN:
                     break;
                 }
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6..fc19bdb40b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "system/memory.h"
 #include "tcg/tcg.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -450,13 +451,27 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
-    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+    if (buf->len == 0 || (
+                qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS
+                && qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return -1;
     }
 
     return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    if (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC) {
+        return;
+    }
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
diff --git a/plugins/core.c b/plugins/core.c
index ead09fd2f1..b514293117 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -369,15 +369,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -399,15 +400,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -438,15 +440,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =
+        [0 ... 3].typemask =
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
@@ -508,7 +511,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -532,7 +535,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -542,7 +545,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -551,7 +554,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -788,6 +791,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
     } else if (flags & TCG_CALL_NO_WG) {
         return QEMU_PLUGIN_CB_R_REGS;
     } else {
-        return QEMU_PLUGIN_CB_RW_REGS;
+        return QEMU_PLUGIN_CB_RW_REGS_PC;
     }
 }
-- 
2.51.0


