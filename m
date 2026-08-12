Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB5C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8OB-0006DX-RK; Wed, 12 Aug 2026 08:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wu8O9-0006D8-RJ; Wed, 12 Aug 2026 08:48:57 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wu8O7-0000AX-L3; Wed, 12 Aug 2026 08:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daQSyjLXT4a5zgesphv0y+XgblPVNCWjWcJlNAfxEBpw0/9SXZ32HutKiaNbdG2xfkfiWltOiOCHEjMsQqnMGYUR6Zbm2pdX6vCur/GP1uJMWEdnDYTJAF6gemnm/nlljzms589Nn4IKEZaDRqonNiE5tKjmdnzx3BczLWPAB8OuW2LlYgf3XjU2mqEIdzTPx54qLVGziO9Qm02vwtdwlTvcw4UqWx0jpRfnfCL6G4Qtc0N9c5MF0fPxGa2qcIsjROCwsQOM0MuB+9RoELGbWQyaKwWeelogqEc02UHyoqhJRfZi4Z91+Zx1nPWQBYDr1VKIo2FKee/t2EEgPes+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrQoqv/LUbEhI22TiWlEmOaiuy/kgyuJ8BGXkUTa9SU=;
 b=uHIlaJT7+9NXp59I5XVsPdz5R876UjcUjvcV1zFxukWUNJ8NutMn7A9Lx9ENlm3WnuCA37MkfDDeJVBGvnMOGtG0aafoau6jmDcP8d0RxfiMYKgSVSnc9VwPi27+RZxqBuoDQYUhEXrcoeqgnGN8aI3C1Wt331vyMOPA31CS8rA90T5YcOt9tVxxbCUyNWUb4+gLVd9XMERqhF15Asf1MW1JkF1tA3tTEHUVTq65MnQbfRwQf5woVLF8EFTCdkMmXE9NyQM9oZwavsMWHIoP1H8IMzCWmBvCHZnHJNMPmGSqpCoJqQ+NVeQ3VDZV1hcZIw6srNjAIsq6y6iKZV4HeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrQoqv/LUbEhI22TiWlEmOaiuy/kgyuJ8BGXkUTa9SU=;
 b=Y5KYSP2fki6lYuOTAa/spZi29a5S1MJK8t6gJfZUSr3lw3ZXSsEdyH2UFuyP2Th4EPikX8qenbUyV+NMT+Zz6gf/laMIamiLTi3/bNsvpD/E05oqLU5/xdV2RoC4r6I4p1tNfjE30QyYt3x82d+zNjoRXU/GmYhcnTRF/q90Yej/fWy7mF1ptbiNtjdTwkX6y2cHb6Ri7TZ4B8/uorvrCwVk/1q5aY+ZTMThQnh/7JRL2yjslq6TZHGYI8XIeoYIUsP4OUbzQUjMj6ZUYEcg/XPV0m4pZG9l8E9JmvLng/DzGChzWNZCeCLJh2o9wQ+8DtLL3h8U+YA4/bVjOg3fxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB8326.eurprd08.prod.outlook.com (2603:10a6:20b:56f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 12:48:47 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 12:48:46 +0000
Message-ID: <72361406-f846-42ac-a3bf-a09985794bf1@virtuozzo.com>
Date: Wed, 12 Aug 2026 14:48:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/7] IDE patches
To: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow
 <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20260804170015.3128363-1-den@openvz.org>
 <20260805005513.GA582272@fedora>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260805005513.GA582272@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::27) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a1929e-22a5-43bb-4e03-08def8700cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|376014|22082099003|56012099006|18002099003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 9U01qKpq08TmQuxM4t9Wh6WBD5kOuv7q3T5BiAPuc6uTbfmZjnHEgVDynxWNHm8iUHHghe0jwMbzHicTbsHnOUbO8rE0ekSD0I38Cw9hHIuKZXqE5Ap0RIqlWTY6/6njRtkKr9NMndck/MozEscFkniISzl/SjdA7TlJQkL+4PrJ8TVxyP0mT1oLG2Rryp4wgCWcLYfsRcYm/I89WlzHUM9rVSS3gL1ebdu7wqXn5tCIjifngqjTPqNdwFgBW8if0aQQB5CcF21a8usU27NYinVnLr8uuqxwv5nV5qZ1cNOKo+mfhOAuqAGx0JtZ0efWjHfTdeIMLDRusmQ1qMaDfYxicEglyu67TC4W916sz9FDD/d4vgtPYilXegUhKrGDyVBBxgka4zYORc4cHidn4EQ/W+EDWKxVnKre2SFGuzz41+jmWVy9O+qzawjklKfdFKYESZ6eRrdFAS0ZheQ81lHABdz3PdSXOKqFzTzNYebO3wLnk3LuumcWS9L3w24teYU6wssW69z3ULpYYSEU4hkAc+TB0VWn4ppP8Y+EnqX9CEJQoveUk0lq6rIPtiGZHC+8d3644n+JJdKT05noOB30DetAyvytkRYT5HsQQq0GkCjVA8ce2GzyPSDlsJS3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(56012099006)(18002099003)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UThQaEpNQzU1djhSdFVqeVFwQkF5Tk1WeUlIR3ZwRTZuTWg5M0l2WmVFbUcz?=
 =?utf-8?B?WEt3ZHE5UVdRWE5Lam9iOGJQaFdFdXNqeTRQUjJaNmI1MnpwR05NSUl4cG9E?=
 =?utf-8?B?VFI1NXlJRGFzMWJUUVdXR1dWOWNqdFF3bXpQR2RJUmd6eWpSRUpXS0E1citU?=
 =?utf-8?B?VEtmNnhpOVVMbkdpc0kvSzc4NUpZU3JpZ2JIN2h2aXFWODZXaGwzTHpVZE9D?=
 =?utf-8?B?MXovamhYRW9jZFR6N1JHMmhFVGczdE1kNVhhSWFKOTA1STBEdGYvVXk0Y0Js?=
 =?utf-8?B?cHRia3hPdUF2M2xHMDMySU92N1hWTHZmSFI2OFcwVFJvMzVLS0IyU2x1WEhP?=
 =?utf-8?B?UC9JMU1Za1V5WENqOWw5L0l3anJSa1B6ZFlNbE5FbmFEUlFwTmZidFA2UXZN?=
 =?utf-8?B?bFpNT3Vmd1I2MmxHcFBsUTRQeS9YZkVXcm8zS2FncGd5b211cG1OZVZSclVE?=
 =?utf-8?B?dWZGbDNSdFRoQWJDTU1KRk5PWTNZd2ZuenJxZU9uZ2l6aE9nVFhhaDhrbjE2?=
 =?utf-8?B?QTZnaTI5bjR6bm41a1JDMXhudFUybWJlMXlvbit0L0pGTURlak9UcWVTQVBi?=
 =?utf-8?B?OGNKbmRkL05KZlJ5NVFMOFd1TFNJZzZ3d2lNTGxqOW5jbmcxRC8vM2QwVU93?=
 =?utf-8?B?K0NtejYvaVRhUnJEYmJvaUxPR0NiMXNwendtSUUwd2NlRDFkNkhUQ2I5RXBJ?=
 =?utf-8?B?alVZQk1DU0xjSmtLamVQWVJaT3l1dFJCR2N5TXlVTUpnUmtyQTdJYXZjek5k?=
 =?utf-8?B?a1gxMVFVMitEV0ZicitWUkNnWERSb0lSSWdXbjhLSldRVGpjUDcvZnhidmNq?=
 =?utf-8?B?NGE5UklTZnBxWGNrcjJUMTB4TGl0Wlp1Ty9ZYTI0M1NOTUpwcGo2c1d2MVZQ?=
 =?utf-8?B?c3lYMDdkaUtnbldOU1JBYWhwMDB2MTVmbm9TY3ZmOThtejlGYXh3NEx3NjlQ?=
 =?utf-8?B?d3JpWDFETC9rSkdVUUJGc2wzNlNKZ2YzVTFFNVV3dHhJeVZ1ejMwc1VTVEw0?=
 =?utf-8?B?T0xvOVRkUXNiU3hWWjNDOHFaT1FFTVFSQ00xb3VidEkvdzA1RFJ4SmhISy9Z?=
 =?utf-8?B?RytIdkNlUlFtOHRnOHNldFZhd0VSK2JtdDlzTlFkMUlVK1FWQjNTdzQ1bXlj?=
 =?utf-8?B?TzVUWFZ6UmlLenR0K1R0QTBSemlxRjA3d2xlbVpRMC8zVEVTaVA4VHd0VW8w?=
 =?utf-8?B?MVROZTFqY0g4OW9UdXM0bG5nemlBY3pEdjRQT3dBbVpqZCtQcnBJS05lUWI5?=
 =?utf-8?B?cnBWR3NaNkdLcjhKejd5bFJUZVZrNWVoZHNpY3J5ZmRKTWQ1WWZ3THRqbnV5?=
 =?utf-8?B?RkRZNGd6WWU1KzZ4Y1ZXNTBkclNWSWFjeW1vQXVuYlhJNGtXeFdMMm1Icmto?=
 =?utf-8?B?RkNhQWtNUXdPWXVuNXlOd2d3MEtEZWloVzdabmVPMGZ0OGp6V2pQYTdFL2J1?=
 =?utf-8?B?MHp1WU4rRWhDY3VBRXpJZkZWRVE0Z282dDRVb2ZDZkYvZWZuL216SjVBY0pJ?=
 =?utf-8?B?VVVKdHR0R1ltUmlzTVhLWmYyWUJpL0M4MUFhZmlndjNwVDRvRnBtTElIM2lP?=
 =?utf-8?B?M1pDOTNIQW5MTHFzWnBJMWhLV2RjREZIOVdhZzhkaTFrMC9zdkJJRGtmL2lI?=
 =?utf-8?B?MTh0dXgyQ05PNjdqVU1PZnNkRm1CTU13cVhRTmRiWGF0THdVWkRZSi9SejZO?=
 =?utf-8?B?U3FsZkdrekkzTkVTR20vblN2YjAyVHVvejJFOGsrRzVNQVJQdzErRHp2a0Np?=
 =?utf-8?B?WERwcFczZUdsWFhzOHQrY1dtQTQwcVdJYzRsOU1GTUlwZ3RVbnozRHdpQ2Fv?=
 =?utf-8?B?TkFRNlVCRmF1R2taWnN6QzVEVHA4RGVYTjEyczFDaFM3MHNsM1BLU0J2VldS?=
 =?utf-8?B?cXVUTitRZGJ2d1gvTnkvZUg2YlR5WjRvMXcxZW1lNGw1MkhiVTR6L0VhR1NS?=
 =?utf-8?B?ODVKMU5KL1pyeU9XZGpqWXlXeHRSVjRreW1XREMzdDF5SzNWSzEwSkhjQXNa?=
 =?utf-8?B?Z2pCNldTSzIveTI2WVJlVFU4TVpFYWVPalJzVWMvMm03T0RDL2tWb1VYNVl4?=
 =?utf-8?B?QXl0SkFHRXhtQWY4dWRTQTFxa0NkWUNERVVmM3RvN3VoZDR4b1JRU3JoTVdT?=
 =?utf-8?B?T3lSY0UzUUxETFNYWDY4cXV3Q1RqZUgwMU5jenA5QVBvNWVzZEJjL2JOWUZr?=
 =?utf-8?B?MmpNaEZISlFiUW12alAzYUJFMHlJRXlyMVJ4NTdiejhuNEIrMUNISnBLTXRQ?=
 =?utf-8?B?aytiRGNOM0VUS2I3b2ZKRHpJUkVJLzFvR0JqcDE5VVRnU2ptb1k5TEpaTU5s?=
 =?utf-8?B?MFJtVGpoVEF2RWtPMWptUkJhUDB2cUdWdUFkckZkKytDbzJMaFNrK1FMWmJQ?=
 =?utf-8?Q?ANf1YUuAooycNHF+fHAK6o9LQcsrAImc4XCoD3aE5NMr3?=
X-MS-Exchange-AntiSpam-MessageData-1: YfRF0zuV9BOcNQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a1929e-22a5-43bb-4e03-08def8700cc9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:48:46.9024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3Ame2wwTS+lreDbu+8hlwHDKxUmL1MbcnAU6HF3SEfkT8qgzcIue83SOIjqXRjcGgtBFMmfC/w7al0y7S9YNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8326
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 8/5/26 02:55, Stefan Hajnoczi wrote:
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.
Hi, Stefan!

It is kinda strange but I do not see this series neither
in master, no in staging today.

The head for me is

commit e8d693e12af9cbb89d724baadfcc08559669e279 (upstream/staging,
upstream/master, upstream/HEAD)
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Tue Aug 11 14:31:44 2026 -0400

I see only this patch merged:

athena ~/src/qemu $ git log --author openvz.org hw/ide/
commit d9f78431d8ebdc2d03ad74461138c1c9eb076aa5
Author: Denis V. Lunev <den@openvz.org>
Date:   Fri Jun 19 13:21:49 2026 +0200

    hw/ide/ahci: cancel in-flight buffered reads on command engine restart

Does something missed/goes wrong?

Thank you in advance,
    Den

