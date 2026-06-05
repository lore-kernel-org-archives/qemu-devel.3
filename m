Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A1ECD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWNK-0006CT-5J; Fri, 05 Jun 2026 11:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0616459cdd=quan.sun@windriver.com>)
 id 1wVWNI-0006C2-AB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:22:20 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0616459cdd=quan.sun@windriver.com>)
 id 1wVWNF-0006sn-MB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:22:20 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655DmdwT1006823; Fri, 5 Jun 2026 15:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 PPS06212021; bh=uxUX7bsytJsYYDz/QA6RCzupyPvhyYQJeZxskEcVg5A=; b=
 ozE60z63gXm3XqM2HWP3FFZ+DDhEKkVkbiJFM27ogn6NAP2HTAqmwMQDJX3K0bzm
 vq462Z3/TUZWLBH1gF+4G+GbQUGcfEdd7Q4Ie7HGY5bp1xwtSIsWWvphUY6/qrHg
 2P9Bi+tkSsiRcM8echcHTece2sCJ1I0SCt4+YhFhsvi2wwOvZkFPciXAZ/iGcjCn
 BNzQ4aHOamSA85u4W0o8sm84jDzvb/ogVtwO8OxJc1+LsoHWGEgVWC7HgQ5lm8UA
 5JzaCLptvZ/ptO6HoPtIwRIzmOr4mqKWapYHrRn8Fn0OJqlKI6tPrgqjaOvfhZmA
 AG+6SGZ1TlgpQ/CIzDiQkA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eksb38kc3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 15:21:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkRAIqKHlqYrPQNldd/nypUpPAZ8Dihkh8eRzIbh1BXjyF7DxhLvfqmNvl4BNcfRsrXhmACufdzMpuJA2gCyoPo4lB4cxMv9oWoSUObvpQNuSM9rEmjUor3ImSAX7GfLSjqJxRn+zwmymAkYzO5PIzOoZVDh++uY5mXtYkLIgXXKP3TUVwtaCYKxrtlV9lB5xM+dNLm+ZtLQUvI9FtPmipzGNdr+fUf1cgtb3KEIAKntj+9lZPaqcXHCIu3nZAkj48eckI5Yx62KdfGMfkCFHt27kbqC56+lL/MU/vebNyOaR6H51J34vvCNwncG3sOZNVPuiYRRlyi/x8G3fudZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxUX7bsytJsYYDz/QA6RCzupyPvhyYQJeZxskEcVg5A=;
 b=UzhxVpOA9KBM8+8Gjnxq1xzWz68QMxJSj82B1YyZFUOJNy7nn6vD8OUNG1mcFCqrFUkR1A1iXEbOznAsF5C/HBI6ik5dLqNjg9Ym6c02KRQW1/kbDocl4LOseRzoVkPlsPdchTl18FSnsfWd+ZO/kXakDW9Ukd9tIs7ubyAlVCW3A7AUcdDBaepzArAkAuC3Ygfm187hau5HO7m8l3jlWbktyJ3dm8YHwx69phJnkLFD54VUeODC8jb3Rwk9nmy7NWidebWKCuLe/S8wnTNUa8mbtY+MgHptEfJSk62e8AYfAUhA76BZNYUC8lH0tRYTnfM0BVLi/M44ydxrCt6bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10)
 by DS0PR11MB8070.namprd11.prod.outlook.com (2603:10b6:8:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 15:21:35 +0000
Received: from IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8]) by IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 15:21:35 +0000
Message-ID: <c091222b-6df5-4a88-92e1-15ec986046df@windriver.com>
Date: Fri, 5 Jun 2026 11:21:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: ui: Regression calling eglInitialize() since v11.0.0
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Kanavin <alex.kanavin@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 openembedded-core@lists.openembedded.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com>
 <aiKEeH2UZgdePzjX@redhat.com>
 <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
 <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Quan Sun <Quan.Sun@windriver.com>
In-Reply-To: <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To IA0PR11MB7283.namprd11.prod.outlook.com
 (2603:10b6:208:439::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7283:EE_|DS0PR11MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fc457c-34c4-4935-8032-08dec3162137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|4143699003|5023799004|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4GDqyAhrUR9EYUZyW3H1vj31lJ/Zr6x0eSy0icyaKvZWMwHOBW7a6bOoW5kVpb34DiOjuifRIr/FVXb3cBhFv40f20a01FZ2KFC+GTqKoF94iYZRf6i9JITZEBKNBY66isiH6ocpoP8kyxNznhGZ8AWAvcxDD8r/FA/oc2392QwAs5Moj/M/jzm9nlfqZpQ7Uc6utagNEofRfmqijQ4/n78ZsI2H6xbxLMZ6/4WY/Rly23Ic1Jcet8ZhgUVKv7iKkfjkfR2BcNXxEDlv9VU/1aLAjvTL+wvv+uUBws7gkCOFiCz8RinY33WeI6phfm+9zTHPcQgaBDblAovwUnkbtWVG6Dn37o42kpygpoovPDzDOErTrrLDL9URskyov7P7BQU2toslC1RgCl3f6BnSvMWtKRUgn+2nliO0MrMM7Q0r2fteCfjlGVGkjpZgkUFYslI/c2oa7cGQq1OQPH3vXm+KQg7u+O3zetVWDyCwZ8JBPWsYH46OtqIH7dNgeQlDdh7OPBZUQKvsKzulJKHQSYbNOGvZb+Qy0rcriocX8sum42RPc8i3oW7Q/anfGlbD8uVjgapTjCHbz6S3wLjrhS5fQW9LPekcYhBfG/PGh12cVTYjZ1w4GPQEYEi/rLPwJfH8BOzS7qFts+aJm9OeWHA5T7KNJNzTNwtlAFJZeW1FIAxvusqGQHlQEGKOrMxVz2RZ8LbtTTgztHqQEMjmSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7283.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(4143699003)(5023799004)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5jZm1kYnpTTFVkZWNpcnRDejEzMGRCWW1iTm9YYVNoN2xNeUVLRkxLdmdH?=
 =?utf-8?B?Z0E0cjNpSzNWZWN0QWg3MGpwRXl0UUU3RVNRSmdWZEhnUmJnMFJLY2craldy?=
 =?utf-8?B?dUZCelBSS2ZPYnVmcHNBMWROaFJZT2JGcHZERERicnVCeWJBTDU5UVhyaitt?=
 =?utf-8?B?UHo4YWVvSGZYWUdrbWZOeHY4Rk16QVMyTitPZ3MwMm94dldaZEVYZGhJODI0?=
 =?utf-8?B?UVZsSngram44T25BYWJ5Sk9GcGlGRHVGZlo5ZGlUZ0RpZ2YyL0xqbWdzSVV5?=
 =?utf-8?B?N2w4dXJVbU1kZDVpZlpPZHhUWTJkc2dQOGlTdWxBbjNPQ2FqMWRNTFBFTFVR?=
 =?utf-8?B?cjFKL2lqanVpQU8xdkpCRUZGaS8ySE5BNWlNZXpDU0w1NHVzU2x5TTNYc3hp?=
 =?utf-8?B?MUhudnZIblZZN0VQMFZWMllXMmUyVmRQMTNyT1duWTl3UlRwdzczTTFNT0I0?=
 =?utf-8?B?dlY2RXA0MUFNNUZTN01JbzhYOGVlTGpNcE0xMmRPSmRNZVA3bWFJZTVDYnBO?=
 =?utf-8?B?cjdZYWQ4emhIWkJ4dER2d2lxczlLblJ2WXROYld2QzJYdTViTysvb1JneGtE?=
 =?utf-8?B?NlFNbnhERHc0NnVSamJVS0dWYnUxdnhmQ1d0aE41YkFmQ0xxN1ZTRXhuZ3lh?=
 =?utf-8?B?eXljSTkxRkt1bVVndkJoYVl6NTFLSHk4b0JtOExjVGdqUlZ4c21jNHdzTlFl?=
 =?utf-8?B?TG8vSEw3N2dIT1BUU1JMK0ZINlRpa2tiN0JtT3YzZXU2SjVETmc5d1RqYmtz?=
 =?utf-8?B?cHNOT0Q1d2VIVCsrdE5STkN5MTB5NC9ZUkxSbDdrODZ6Y3NTdm5Ld2hJUk1x?=
 =?utf-8?B?Z0x6dy80dnJWL0pLT21RTTBPK052UHJTNzIwLzNUQlhncG13Q0U1N2NzejFo?=
 =?utf-8?B?WWhzWlhrTlZDemQwZzhzVjlqVHRxcTAyQXQ5NC9KMElBbWoxdWpjK1gvTTNQ?=
 =?utf-8?B?M0V4czZPL1BMOU5Fc01UTzFKQWw2ZWFYenlFOGV4bTZUQWhzcUZ0QXpzZnE1?=
 =?utf-8?B?NFk5dlovQVZ6eXBxNDRkc08rUER6YWdUNWFaMUgzVldKSEc0Y1RkdWpJcUVw?=
 =?utf-8?B?QSt5YUR5U3Y3a1J6YWpwSVVKU1BaQmNsUzdscXNkTWhWRWNVeC9CY0dURlUx?=
 =?utf-8?B?dUNDMXBZeWVTQXNMRXd2OGwzWk5CVjNPbDgzRlpKUDJwdGZGaGp3QlF4Tlpn?=
 =?utf-8?B?REtjQ3Q1MGpKeEU0b3puVCttK0YxbVpTdlhyWHlucTZ2dC90N1pTU0Uyc0FB?=
 =?utf-8?B?L3B0VVVHQUxDdWJhNzFVRG93d3d2OGdDb1dsN1ZJVDladWNxcEZXUDYvbHU2?=
 =?utf-8?B?RUgzUCtFTWtLQWpCdUtJSThoYTZ4MlFaMWdKUDltNjZJNTA1WklvMEZoQWFw?=
 =?utf-8?B?aEQxZDdjQlp4S0Z4R1hyU0NDQTlYdU9GYlUwOXdzc0VIRGtDSjh1blpoNjRL?=
 =?utf-8?B?VEtxdjJsNFpUNHUra0dQQWZBZTE1eDd1Tm41VWQydlNZdzQyYmowUG5QYnlw?=
 =?utf-8?B?VWJlMGJSQzByc2x3YUtkNWFRVGpxOEtmeTBEU1d4MWdTYjh2SGtucU9kM3Ir?=
 =?utf-8?B?QndtL0dEbThhRStnY0J2dUI4K1g4K1NPVFl6YkJIdzRKeGNna2hzcitxNlpI?=
 =?utf-8?B?cUtTb01NRlVqRTNqbzg5VExDSHFZeG1za240UEJJM2xYTFFGWU8yZXdicnQ4?=
 =?utf-8?B?T1Nvd0l3ZmMrODYraHVYL0RmNDR5eVVIUFUwTkF4SjNURHJiTzBnNjVNcG1R?=
 =?utf-8?B?MTM1aDlpNXZqZU1OcTNIeWhBWjBJV0JQYXJxS0UxUEswT1A0UnFUUHRnWjhY?=
 =?utf-8?B?cnNFS0pmK1NmUlZwZDJybHBMakZ1RWNRUDh4UHErdVVHSUZxMjgzd2J4czRL?=
 =?utf-8?B?TnYvU3NqREUzb2VTYkl5bGRyZG5Qb2EvSnRqZDdZemt0K3pHam5lYVFUK3Nl?=
 =?utf-8?B?SlFrN0ZML09IRXc3YXUxd0hQWHc5ZmhNWUlMUWNnRS8vYUttYmljM2ZxM0ZM?=
 =?utf-8?B?NmhGRXZ3cVVNSng1Vyt2Qlh3bVhRb2FVTEVXZW05aXUwZXpWSUZjUU9Sa2o5?=
 =?utf-8?B?d0FpcG1lMCt4eXVLcVhIOE9FUWZoU3JMKzFsNUV6SmN4djVLWjV3N1ZKNit6?=
 =?utf-8?B?cVliKzNScXdDMEVzRi9pNlQ4K0NEMjg3SUFUbU1qbEpCVTRvbS9pL2lNZmw4?=
 =?utf-8?B?M1FsdEZUQkR6VEIyWm43N216blBmR2puczBWOWhhVDNhUUhQNTRocmRreXdP?=
 =?utf-8?B?cS95ZzhXZzJHUzR6MDg1MnZLVVNQNWVuVFJBL2JLVkhLcUFjd3I1OWlyODQy?=
 =?utf-8?B?T0RPckFoZ0pDZzVhYlFNUzI5NzNpMldFc05OcFFBVWl6dDBoMVRCUT09?=
X-Exchange-RoutingPolicyChecked: cGoczHjICAzaCNb4A2ot0Qx8/u74TecRfH2X8le1DnuHuV+DT2XjImDgbzItKJ3Gl+y8aX0NdIlO7c8PMZwpTboaZbbmvyceewfAxFB3hM0CZrsFv64n8tbCY0JhYu+pwU+uJUx2tUJDAI5qrJc/917OxyfojLzcbFnWoB3V2VkPKEPIW1svsYF7y0kL9WD7hXANjpsK2azksB/4PDqZ4aDEu2UEYP0Wpifec4hDv9x7ISlu7t8mVoUc0NURslnxyyvPv6aV7VD0a2KuuGoJfU6dYgugPlLMTDHhVmHuOewFYiDwH2XsZxxqrxHuuTe7tuwacZRrw7UoOvE2CAxS0A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fc457c-34c4-4935-8032-08dec3162137
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 15:21:34.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBLWVWjDOUhXPrihuGbzRGZfMUKZw5U5f8hg3ZQRTsAIrtM2NgZNysmyyFVOGXUPeLRPiP8eG2N0i2vFCD7YHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8070
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE1MSBTYWx0ZWRfX0HSWcgO8GwOS
 on84/u4h0aFmUVJm70oWaMQ6LBggD0YKw89TZsaTZB0lN3k/jbI9PedDAPPjcuQ8GdzD+pXIzEa
 vFqww6T1TV71xwJ0EKVX2ikjHQDb5FYiNvlxiJukikOsYdLJGwqOvToGSIxbK/pL9sS7/3BSoGD
 lSmKDgmabN5zN7RZ5a/dUWv/mglGJeJWL1NDt2cB20n9vSwx6/ncuVaEOR2dwu7ynUCZlOfjXYM
 A8Tdh8Mi7Yg6nRlDbgbf+NhEB92XM8xfGOnxk96tQiqA77QzAvqR7gMSZznxux/uKS2mGvv23Hn
 Uf3U5FHHhRK0RH4Z+fCvOuE0O2oY7+RR8s5bNEGx0322iS8lOdSj1VU5IE3BLv3ITBvxkmsSkvJ
 s02ziViZYNu/E3hwav9A0RSg0lmZ6dH9yHwjZgE1K3GD0dR6ZffTpkh4ogkPB/2JxuBPzI1nhY2
 t9mioMbUCpIFgcNi8pQ==
X-Proofpoint-ORIG-GUID: 8YsdN3lSP9WilqtURKZVNeNsVSCj0Iqv
X-Proofpoint-GUID: 1tkUg9XaKLV2-FC_lUT4wDXvz-Kofpk8
X-Authority-Analysis: v=2.4 cv=YfyNIQRf c=1 sm=1 tr=0 ts=6a22e982 cx=c_pps
 a=R4qMYQySjg0trGpnu7oNJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8 a=zd2uoN0lAAAA:8
 a=f3ri2X0IOMBzLgyNorwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050151
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=0616459cdd=quan.sun@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 6/5/26 9:07 AM, Akihiko Odaki wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> On 2026/06/05 21:52, Alexander Kanavin wrote:
>> On Fri, 5 Jun 2026 at 10:10, Daniel P. Berrangé <berrange@redhat.com> 
>> wrote:
>>>>> It's the same issue, I assure you. Qemu 10.x prints nothing and 
>>>>> simply
>>>>> starts, while qemu 11.x first tries glx/dri3 , then wayland/egl/vgem
>>>>> (even though there's no wayland running on the build hosts), and then
>>>>> finally crashes, with the traceback that RP provided.
>>>>>
>>>>> I don't think it's a race condition, as the failure is deterministic,
>>>>> but I agree that something has changed in qemu's GL initialization
>>>>> sequence.
>>>>
>>>> Cc'ing Marc-André & Akihiko
>>>>
>>>> Context:
>>>>
>>>> https://lore.kernel.org/openembedded-core/7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org/ 
>>>>
>>>
>>> If it is an suspected regression between 10.2 and 11.0, then
>>> I'd suggest someone who is able to reproduce the issue reliably
>>> should do a 'git bisect' to narrow it down precisely.
>>
>> I've done additional testing, and I can confirm:
>>
>> 1. Reverting the following commit fixes the issue:
>>
>> commit 52053b7e0a0e285ce3448b830053b05fb0a9b1a8
>> Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Date:   Wed Mar 4 16:50:30 2026 +0000
>>
>>      ui/sdl2: Implement dpy dmabuf functions
>>
>> 2. Updating to 11.0.1 does not fix the issue. It includes a fix for a
>> different, but related problem:
>>
>> 674221887f ui/sdl2: Fix assumption of EGL presence at runtime
>>
>> Note that the environment we run in is X11 without wayland, e.g. a
>> XTigervnc server that provides a X11 display.
>
> Cc'ing Pierre-Eric Pelloux-Prayer
>
> My best bet is that SDL_HINT_VIDEO_X11_FORCE_EGL triggered the host
> issue, but the stack trace cited above contradicts with that. I don't
> exclude the possibility of a QEMU bug either.
>
> Can you confirm the stack trace is from a run with X11? If so, the next
> step would be to symbolize the stack trace. Otherwise, re-generating the
> stack trace with X11 may help.
>
> Regards,
> Akihiko Odaki

Hi Odaki,

I think I mentioned also in another email that this commit 52053b7e0a 
("ui/sdl2: Implement dpy dmabuf functions") may have caused the issue, 
which added the sdl2_set_hint_x11_force_egl() function:

static void sdl2_set_hint_x11_force_egl(void)
{
     Display *x_disp = XOpenDisplay(NULL);
     EGLDisplay egl_display;

     if (!x_disp) {
         return;
     }

     egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);

     if (egl_display != EGL_NO_DISPLAY) {
         SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
         eglTerminate(egl_display);
     }

     XCloseDisplay(x_disp);
}

The above function probes whether EGL is available on the X display. If
eglGetDisplay() returns EGL_NO_DISPLAY (which can happen with llvmpipe on
certain VNC configurations, for example), the hint is never set, and SDL 
falls back to GLX.
GLX then tries DRI3, finds only the vgem driver (no real GPU), and crashes.

In QEMU 10.2.0, this function didn't exist — SDL would use whatever GL 
backend
was available (GLX with software rendering via llvmpipe worked fine because
it didn't attempt DRI3).

Possible Fixes could be: Setting the EGL hint unconditionally when on 
X11 (remove the probe):

static void sdl2_set_hint_x11_force_egl(void)
{
#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && 
defined(CONFIG_X11)
     SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
#endif

}

Thanks,

Quan



