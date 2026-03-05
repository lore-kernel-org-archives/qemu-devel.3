Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEC5F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 11:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6mZ-0000oP-QR; Thu, 05 Mar 2026 06:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vy6mX-0000nc-Tz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:22:17 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vy6mW-0001E4-DA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:22:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMMKfws0Pz3CGRSEaimw26xjPWjHZLXf0+s9m5S3ObVKeX5Ub5d0O7nTG8fiAyV1hHY0/im5VHe0V7cmnJqQjGQNUVI1jjLxTfGSSPZFPNZdJPp/tAZermGrCdminhRtPlKWArdhw8DxvBA1tw7aRFjnu7mtmIBJY3c2hxSONBzepJZL5RnqhGRRVCn+pgPqUJZuvY4E8icdaE/AVshNj/clK5iSF0NJSINCnd7WQX+VgiL3jULlXLCCeHpu3I9KeqTMAKZLKiYLFMZGaLBERHmkN+lOUcGoyEP0LiiNQdgkKbQ6MlxBN3iqkMB7L3G7XQdWi80rVmFpVSAdaG+UpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sa55lh4XV16qwwdvulpAw4SauRpGRzhtRFZK/6XB4j0=;
 b=fU0VCZOnXFkeoHvO1PDRHm3bO2f5GpFBnpt5FjvQp7sNn6zcgGWtIQ6qelJ5+yuZWo8aKuFX7pSFUlCCDUfVOM7yBcxRomLx29NUdVEbjE0SNcgViOYTr16XdcM9bBMJXsLY95cmMvFMRNAlXZ9x1jsf38qBBf7ef0UNGYxO9k0xDKlmmOLPVKs1344CKDLeCMysoKw6Nbsgkj1dZwm+byz8ohxjHR+cePbAplR5ywTH8ld1Cni96zPsBFhe97TFhLuZJQGPU5vTwcwhIWFfrcS3fddcwIrEA8wbRQhFICWlaFMR/9Qe9UgDd2uLWBLDI79cbfkylc66Q7GPKn7D1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa55lh4XV16qwwdvulpAw4SauRpGRzhtRFZK/6XB4j0=;
 b=YAQz4HPIYcLWAv+N+b3pa4ukgH/TwzCR0S4wv4v7vupPyEX2uULxx08+JprgorgCtm7+iDwFsBdzFvaXB7yqZ3Z4xFaL9QHY6evhlaLMw4dlzOa2cW9qzn6dpMaBmZ2L4Q2t/gza/sWuGXOjRXIcFm8OMMoCZDVwdkrChnUX1RVELr9VRG6uN4HWlip7UjRQiDql8qfgaOvlTIAn5lth1ccz+Ae1D+kDOcTnR8ZbBaPjCBs2idoCp/QXv+5IFCFHXKXVpyDut7VqnY27DGd4FMNw2cuWtQl5tkqL1ijBFCs5AdRhZuZ1sOUj+Any7/+eX/7ReVmG3Nn/QNcT/BZ2Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by BY1PR18MB5972.namprd18.prod.outlook.com (2603:10b6:a03:4ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 11:22:13 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 11:22:13 +0000
Message-ID: <460c0ea9-005c-4970-9cee-bffb7e9c0c11@axiado.com>
Date: Thu, 5 Mar 2026 19:22:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] Add new model for Cadence GPIO controller
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260305103400.1574217-1-kchiu@axiado.com>
 <CAFEAcA9hcr7sDHvv-o_YRkaBJLTt99Uh=DgLtTHw_=jA6A4j5w@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA9hcr7sDHvv-o_YRkaBJLTt99Uh=DgLtTHw_=jA6A4j5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|BY1PR18MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: afa9b1f7-cfff-4ed1-7da9-08de7aa972fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: rhbkQj8FK862zne2yCRPx2mmJZ8rG48gFOB+1QwzGSV6913IUxCf7wwAl+cLLVBHxvUZBoygLCbM5MlM36GR9ie03AlcVCExDmaUevXxX5WTHwjh7l41A9Rt767zD3Bzt1c7a28HI9xDP5JsqXRRlAxvfGAPjXbgXF5sz28x3OS+xI3abBEQ/0rhdFTz1iqeQEXbk6r/MFXRfTT9GUK+DjF0U1mPnFWToLeSW1L10iA29f+A+L1RHE4kBARtjbOeDslVXkDJRbnZH9wrjNWBkPpz85c/NBoIiZYIYsY6yDjmJqg2KfrpdZywfZtwNDoJOzacukx1vuqpTWDKIWOwLVRBQQ6MqhDFqrklyHwrYrINVJ20CxzJC5aZDCLSD4QszbeDqSqggn8u0+Lgg46Ggguw8M/ZFiT54gQ2nGaK6Mn+ncAJv9fS26jy58EA1k/plZaqXsXI6eHe4oS+GfXcXC245yVndyBWilVQzy85n45P9zIAtT0iEvnBD34V8l97TYTCRK2uNvZo/o9620cC2092IyCP29OQCDYpTl7XzDWrsGJP5UpM9f1FSR9mKY+MozvCn0TchEIjLPbI7q/zk5MhjsOOeSliy2FGSZJFBkcFzY7JtRDdAqZHHBK/pgKhLGIDwCvU9TQ74ay/KNlMpnL2Id31B7ArQ5ox235wgbY9Svs1pbvtd2mCFvppWeL9rBzmeRZl6rNbHgwmjxv5nfTw3qSGREl4mucoJeWlkJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVVMXBMSmNpRSs2RXNVYzJxbVpFcGI5QkpFSjBjeHpGNWFTUzVNbzYrK3BN?=
 =?utf-8?B?anpSQUg0Zm1pb0NmcktmeURuS1pFU0luNm5IdGJrY3M0emxDQm1MQlh4R09T?=
 =?utf-8?B?bWRDeTB0REh3NGNRWGdqODVoa0lOZlZ0QUp6RzJFQ1JnSENPUzhIbmZHc0h0?=
 =?utf-8?B?NGFzaEVkdnU3QVQzZk5RYnJhQVF5dWJ4ajZOQjNVVDlBZTg2N0JweHdmMWdK?=
 =?utf-8?B?a3VXejRFQ2xWQ1hxc0JNT0FFRWx3Y3VuK2tOL1pyNzkxY3ZCNkJKYWZWZXhn?=
 =?utf-8?B?VmQxbWVsRjFVOU5sZDNTN0x0eGM1eVpwVDNCYnYvRkNmRTdZOW1xWjQvMmlJ?=
 =?utf-8?B?Z3VKREpZNFhuMU94dkNlYW9tTWZQanpVYUk4KzFnVC95ZlpZcGVlZC9RamxE?=
 =?utf-8?B?bys4U3lUREdRSkl2UFg0Rk50eHc3dXY0K3ByM3BIeU0zK1d1ODJPU2ZFcDNs?=
 =?utf-8?B?d3o3QmdCOEkyQTVudEk3SG1lZkMwTGJFNi9nOVR6bWsrbWkrZDVIMDJ4aldo?=
 =?utf-8?B?ZGpkb2gvaGNmaWZ5NUpqZGtBZ1kzUHREMUJmdVpOMUZaT2JqSWxWeU5Sd21s?=
 =?utf-8?B?YXcycWtRWHIxQUpGM25mdkQ2d1k0TXhEbEloK3liWklYYlJEWEFFakNQS3VI?=
 =?utf-8?B?bC95WEw4MEEySnF4SGc5MkdZS2djMDNvRFJ2S0NiRlc4Yy9KbUY3Q3R1OC93?=
 =?utf-8?B?V3lTdExwYkpYbHVQTFdEOTZsbFgreHkyMTRlVExxbXE4SmFzbXFZRVhIckVs?=
 =?utf-8?B?TENpUUxMSXJndHVWdmk1Ymh0YTFtZmNTcnIzMFBReFp4bWZxT2JORTR6NVVx?=
 =?utf-8?B?MU53OTZvMGRQUUUvUmtVamNTUUF5aS9XcEtlQUIrMHl6SVk1Y1REM3R4c2dV?=
 =?utf-8?B?dmdtZk4waVluZ0dJS29hcEhuSklKMVNBUXd1VmVPelM4Q3dZTmFwQldKZVB0?=
 =?utf-8?B?eTYxS1ZpQ0RSVzM3WGlPTTd6NkpaV0tIWGR5Ujl3NkpGNWo4bUtUdWUwVFFY?=
 =?utf-8?B?bnJUZHV4dmJZcTZEQ2hkeVcwUVdMUUVmbmZKU3NUNnUzTG5mQkFXQ3ROcTFK?=
 =?utf-8?B?cVdKL2NOL3p4TlpBdHM2ZktBRklpZUdiYXB5ZVZuaVFRTWZyUlhzKzczWmpa?=
 =?utf-8?B?cjJYQmkvaHNJemFueUVWUStsRGwzZ0pEVXN6TCttUlU5VnVncFNVa2xuOVEr?=
 =?utf-8?B?YzBUYXFZSGZsV1JTWVRUQkFpLzNjUHlPbVVKOUFqWUo2SmhiRWprckpMcU5n?=
 =?utf-8?B?UzhrTkdwbGxwSGFvVzZCTFN3cW1DR3RvRWFaTERpMXJQanRyNnBsWnZnTVMr?=
 =?utf-8?B?VVNtRTg5VmdtQ08va1llYUZEYUxZT2dBRi9PaE9ZYlM4cHhDbGl2RzJ1dXgz?=
 =?utf-8?B?MFAyR0RlWDZ6U2N6ZkFFTThkTm9VQW9DdDhLaXdkSFJaMkx1NzlwV1JMS2VQ?=
 =?utf-8?B?SXhRRGNvSTB6dTRmYkRIY08rWWZBVUhtbmsvOFUycVI2TkVLVG04TFNwQWxq?=
 =?utf-8?B?NU1UV0VPS3hQcWxKWDdqOHY2ZXhlbWJYNVFmTzlPSkUrVzF4dkUrSHAyRFpZ?=
 =?utf-8?B?VXNtZGIwcEc1OGVZTnV1L0Nldk9zTGx0eHBuQ0lNTjlHLzdlOVpNT2hvNGNG?=
 =?utf-8?B?blZqSStLQVVOWTllNk05SGRZZzc5Z3BBY2VEZ0pmalBKcTU1OW9TVmpSei9B?=
 =?utf-8?B?UTdFV2M4UGRpZ3hDUTFiS01GaDhmZkQ2N2ZSeEdTUFF1S0dYMzhFM0E2aldz?=
 =?utf-8?B?RmZwQ0Q1K0t3ZWxYS3RVd0pSWFZmcGl0QkxBVUxPWWtCMnRRQm9mUThsbEpr?=
 =?utf-8?B?M3I0Q2J1aUZjYytZNUhPMTFzLys4Z01UY2JoVEx6eEhQejl2VTBseFowMVYz?=
 =?utf-8?B?Ni82M3ZtM3FYcm8wci92UmUxanhpRDloSEFDeTd6dzEvVWFVNTJ6SkNYRm9y?=
 =?utf-8?B?djVoMlNQVWFMSnJDTmJtQWcrVUhJalppU1RHYXQ3bjUramwvWU5MK0Z2Y2tU?=
 =?utf-8?B?OEZUMTRmZHVOVjZCdmVVSk5DMlVaZzF5a2xObzQ0TTZyalZ3ZnhWQ2Y1SkV3?=
 =?utf-8?B?enoxUlZaVS9NZXFmSHJTTmQ5QlZnQWg4UGRKNGR0ZzNiN3ZjOXMwSm1lMWJS?=
 =?utf-8?B?dWV2UTFiQVVMcE9hUEtQZ1RrODRpanp2UjJqR2hPUTdKcUtCbHBnY0NoS3dY?=
 =?utf-8?B?dm95dnRlYVRQN09ESTh5N1pMMG93RTBNV0x2MWdjV0s3U2tzb3ZqV0tVUCtl?=
 =?utf-8?B?M1paOUpPWC84MC9BUFY1MFd2cXVZUGdsU0JDQ3ZySHBvMmFrQ201Zm1IalBx?=
 =?utf-8?B?a0NSOEVSM3d1QmRwZGpZdk9kY2dCaHpFUVByN0lQeHp0eENuT3dDdz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa9b1f7-cfff-4ed1-7da9-08de7aa972fa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 11:22:13.2512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN/+6ZcKA2yoqDMEjcJnRqJYjtDt71Iwa0QdIs1kSb9kxvGHeQMfkWx7qRA2TXmhHqsF9OKCigHOhCsy2F9H4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5972
Received-SPF: pass client-ip=2a01:111:f403:c110::1;
 envelope-from=kchiu@axiado.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Hi

Understood.
I verified this device model with our Axiado EVK machine which is still 
under development
Does that mean I have to submit patch to add our EVK machine into QEMU 
first then add this device to it?

B.R.
Howard Chiu
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Thu, 5 Mar 2026 at 10:39, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> This patch seriers add a new model for Cadence GPIO controller which
>> supports 32 pins and interrupts for level-triggered/edge-triggered type on
>> input pins.
>>
>> Also define new trace functions for analysis purpose and new configuration to
>> enable this model.
>>
>> Kuan-Jui Chiu (1):
>>    hw/gpio: Add Cadence GPIO model
>>
>>   hw/gpio/Kconfig                |   3 +
>>   hw/gpio/cadence_gpio.c         | 312 +++++++++++++++++++++++++++++++++
>>   hw/gpio/meson.build            |   1 +
>>   hw/gpio/trace-events           |   5 +
>>   include/hw/gpio/cadence_gpio.h |  66 +++++++
>>   5 files changed, 387 insertions(+)
> Hi; this patch adds a new TYPE_SYSBUS (memory-mapped) device,
> but it doesn't add that new device to any board models, so
> this is dead code, as it stands.
>
> What's the intended user? Generally we recommend adding
> new devices to QEMU along with the machine/SoC/whatever
> that uses them.
>
> thanks
> -- PMM

