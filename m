Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6A8F8809D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDHVC-0001qx-VD; Thu, 16 Apr 2026 03:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1wDHV9-0001qK-Ra; Thu, 16 Apr 2026 03:51:05 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1wDHV8-0001oY-1M; Thu, 16 Apr 2026 03:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO/YPzxyTaZ16l6j8Q/YEwaIEXzZYWLnygX+TIqE7gaKlLP3Yc14Noce/O2hlxJW9Dy8zNQTOQyoAuuyroU38A4hgbj88YfyQt1ruzhgyxJ68rQxwMcCBS2syLtPqNecCk2XlLupb/6wqszE65O5R7+Dn5NeWusP48BGtl/UH+auEX2RBZAEXHNUa9KrbkGR187nVoIi9zowNCUJQDG6qi1VSmAM8uaCQ2ORyeSGAMumIEEB2m7VPf3JHVFnHJRJ2wzzcD3dBubyjNurGkrK3eSmNQWMit6OInwp+/bQrcwvw8eCwy8rbOcdeVJ5SHUoU+E7i8gpeUTREcfdnHwRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9wcQhMAuKu1TgaPR7td064UoKb6vv8x1x//KXsTfbM=;
 b=UZhrEsuMx0aC0+O3OrgpWlgf5sAJFn8U6dCwpBpasDdzX4C/wTOt3AooyBGQYfqcx37lNKjoT0zwL1wnaSuSse7gryNtd1wLHKuniQpDC6AEmTO0LdUiy+DVfoO2Y/VB4CUSmvVB5+ddre0YAlYV+5hhYVQheDTfFyXKZwRXGhHs1BX//MxvL4OipryVxKhIaOWiOmGCmmAPtwVFD5u21K3KDW7L4LOwo5SE5WuyFuBrBXO/1WEG79OkNN0SDBczlIKBmWe8UdiKcS+YiY5tYv3QPWBi5pOWynlSIX2jpH8TbwcZRcesmdTYVjcHOdmmrqH9dQkwTWutYttcl5HlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9wcQhMAuKu1TgaPR7td064UoKb6vv8x1x//KXsTfbM=;
 b=q6z/8E55GZrh0GkWIhKzK+r6SbjGRxecanegznDFZ69GHIY1u+Bv/ni6blokmfcYh1upRV4f7CzuVoC5UOBK54viAffQ3qXXNY9fFsJ4jo24oIvjMZVsnnUSi4QypqNDs9cKsPi3bSRscju7S+yxbqI0yhzzuU3uVg6l/UL3wxDGIkRgHwOI+q9NiMqwXP0JKZCoqnrjQ+Cm+gdAqvNR7jYXEDs61WtjqXOU92B6coZY+CfU53Lx519fCAB7w1POBA5dWF8BMSFOSrzHPWeIzFG9yJlxtEWaqHv6foPXQaTuwDMQSqlfxJXslnFb96gPJpCz/thfdDjOtIFLDMCohA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:50:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 07:50:52 +0000
Message-ID: <60d47301-08f4-44e9-9cd6-2a12bb9e56de@siemens.com>
Date: Thu, 16 Apr 2026 09:50:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Add support for pre-setting the
 authentication key
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
 <d68f975d-0450-4928-b758-bea1e657eae7@linaro.org>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d68f975d-0450-4928-b758-bea1e657eae7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 12354120-a040-4616-78fc-08de9b8ce1f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: jrk3fGvXsVFSEJNlCnS4hWqh0Sk9eWTVXYsbpbPsC+NKPRd97r6XlxX2qPdGgEf9c+a31cDfIH07YYZ0r8syxakX7QLUHzEm9/eH2lPoGW0v7V2MceIiHqM+WD4/RAauqyiTRhP23EVOnADSyzwI7j6efeW+ZH0iNlONycz+kOesAkYjjasrZSl3+ErpWVMGymFRJpEhopeRVCb8tPNj1sk++t22nPM15Qx4oQ+DKzSWVz7exP0y1iHvIE63A7zA+JVaRgv0tTrHX/WZKweB6LQEnO1izBxw8GB3JGS9yt6qM+JSMRlCmr9jZUhwPP9gv2QTnV+jl/hMGdNdpseD124kEahEfQpHbql1gITNhqXz71eFHMplWCfyv75z967aclCn3smAW65mVgGWSLd2UWBS8S3cdOnUn0ZaK2o17uYN3D6rjGDFG8EvilPkju1KNBIvdj7tvKycJqTkjGlZ5mL28NV/TpaUsbxBtgHDy5i5n/NyelOCWUK4ju0q0rtHmz+rt1mXUaG/QDPGJNGWfSM/0qYtfFhoVbIloLVshkkMM24Q1d1yWPPz93iJY6crbXdP7vBQh4SbxtRXtP19wY2ZebO2NT+E5iiSWEVjL8utXyFnViUFu/C5Hj8WWFCFadIwJliHc+3qD5cCNMzYXfpM4/9RUSt2bq+mvwIUU7rNi0Qq8LsOCUZk1vkf4gjmbgQLM8bVEfAqF9gwE4xTCvb6GhQbMKTm8QYikYjL+h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVYOCtxdU5ZZG5yK3NUK2FDSlRpRmFVVTFSdlRUc21SZXBsdXd4bmdYWUJv?=
 =?utf-8?B?ZG50U0pIWTdFYUg1WVJkVEFndlI1alpJM1NtUG5aVmlSVTFWT0FPaGxIbHQ3?=
 =?utf-8?B?OXl5YloyR2dyVWtXbUs5enVZNTBRVi9OUmh3WkVjWDNmczJRRm44aCtiUjVG?=
 =?utf-8?B?Wmhma0hsNExsVTlCYk1QOVBsK2dPYTQ4MHZzT3ZQY2xTdWNhYmZtUUYzeVkz?=
 =?utf-8?B?Rkxpdkl6WHhubFFjS3VncUNaRXYvMHhmdmUwclZ3bGxiSmxtbHExOHgvckpn?=
 =?utf-8?B?S3J3NW1XNDRhYTUvbFNVeER1QXlmaDNISkZhR1BQS2NjQ0x0aEY2V3I2Y1Iy?=
 =?utf-8?B?cnBSZVFDWlM0N2ZROU9oSW5vNG1RbS9LeC9EUHdkOFpuSTBmMGdvNjkxdkQ2?=
 =?utf-8?B?c3VxTzJyU0F6NndSekMwWjNERm83Y3E2eVJvU25ybmFvZzNqZHprdUhnMFBK?=
 =?utf-8?B?aHZMQmtWWDg3aTBNc2R5WkpqSmJTczhadWFBSTJ2YW5ZUTBSRllvbm9mb1lh?=
 =?utf-8?B?aUdrRUc5ZFE5RjB4cDFmWk9DQ2U4dmRxREtmMGVpdVMzQzVTQklzczdCS1Fo?=
 =?utf-8?B?YU1vU0hnRXhkcHhkN2JTWXlzY3JQd1JYQkpqT1BUQWlCWTB2dHB2aXRUMW1O?=
 =?utf-8?B?QlhkNEVXQzNaTVhod1psY2VhSktzV2N4eVpEVUJsbVJZQmRnVldOdTdkVFBu?=
 =?utf-8?B?d3pyR3ppa2VNZWJJWDhPZTBoTklhL2Z5ZWhITHhoWVFRTVMvZzBZMDV2bWZR?=
 =?utf-8?B?dEdMdDFBQkJDZ3JLK0t2Ym0zdTBGd29TaHI4SVpwZFRLZzRlYmdSY0hCWmFB?=
 =?utf-8?B?K2pYV01tQVJIMENUbTZZcUVleVVwKzBBOWdrUzFSNlVOZFhKTEkzSWNBOUs4?=
 =?utf-8?B?K3lDRTdTR09JWHd0QW55K2h4MHk2ZTh6c3VHQWt0OEU0ZnkxdjJhM25SbDZh?=
 =?utf-8?B?QkVBOVRiMTJLejNrZ1dNdThKVlNnZjdCNkJrdnlXQituY3NGb0ZBTTBmK0Fl?=
 =?utf-8?B?OCt5ZU1uUENjQXlKTDh3eWxzR0dWeGgyTURIYVFJeGFjZXdkcDBEbTZ0RUlI?=
 =?utf-8?B?OERzRHpNbWtwS2VQVlV3RlAveWpBY3RSY1YrTGZaTERMN2k4WkJzVC96bU1B?=
 =?utf-8?B?RElWQms2OGNoei9zZDVWbEJDc1I5R2RMQ0ZkcGQyZnhVdXlVOVROS3NlY2VL?=
 =?utf-8?B?eWZ2Mk1RdU1rRHNERjRYaTc1RjNiazV4L2FyK1VrYmluSGRJQWpMWll6UWVQ?=
 =?utf-8?B?bjZtMThlajhFT1N3Qktuc0ZvNGk0OFJKMjIrbW1JRjYxci8yMDFzOTAvK1Na?=
 =?utf-8?B?VHlFYW96a0VWckhDTmJqcGdtUGJ0bkQxeDFMdFIyZE9IelVRLzVBTWFOSmJI?=
 =?utf-8?B?eWZFcGFRWnVVMUpjM24xVjZxWG0rSTVHSFZCZFdVd0FzRWFKK2VyTVYwWTk4?=
 =?utf-8?B?Z3RHSnAvSzZMUkdXcit2ZzdXSEpLN25VNCtWMXJpWFRmNVRod3o4N0t2S2FY?=
 =?utf-8?B?S2xFUlJQMXZFb2xvZE1LN21UVEJnK2pqc1pMdGZsYlA3dFZWT05GOFA5RlZM?=
 =?utf-8?B?b2czU3YwSEtacDd3ZWZ3VTZJYWpvZHI4eWRRdFJxeXBQblBDNnVjcmlMQWsw?=
 =?utf-8?B?T1g2QlRDbllrZTlxelJXNU9DeEtscjRBdkIwaGhJR2ZLQ1JkZ2dWNkNTSU9x?=
 =?utf-8?B?SjBtZDVxdEU4RFNtMm5NVFNiTmRsRnNYTUhDeDFhK3BpT2lCcmNReFhWUjIz?=
 =?utf-8?B?ZTFmbzJ0dXh1dUtoQXVEYmI4eFVEZUcrWmp2dzJOSS9GRTRXdkc2aUNDcTlk?=
 =?utf-8?B?UkJtTlBRYVlaUitVUHNEOTRmOHNCanNOSFZYZHR3OGRFZmVJSGNpa1Y5K1Rt?=
 =?utf-8?B?OGJBRFZqN29Qd00xUldzalVQSkVvTkRYa2xWeXFnU3hJS2JvRWpLVFFaZjFp?=
 =?utf-8?B?N2J6QWovNms0NzNBcTJuUkNoYnNhazYwSG1vRFNBcFI4SGJpUDN6QVpIV2ZF?=
 =?utf-8?B?cENzYmdwb0pyU0UxNlhHcVYzQ3RscXFJT2RmY0dESnNrNXV2bkFVYWhTMGox?=
 =?utf-8?B?WEFQN200cUI3bUdLd3dqRldzaXAzMFJjWXFjd1kzTXN4MlBpRjN4andhS2F1?=
 =?utf-8?B?TXhzVEkvd3pXODlFR3VibFB2b1ZFcDRlZTdWaFRwSnRIMTRCOGtvRU9iNWxH?=
 =?utf-8?B?MlVkQ1psL3BwRHN2VTdjdlVHbmVCc0U3QnMwZ25DS0RZZXBuSnVNazdwYU1W?=
 =?utf-8?B?NmpMYVBmNEVPT01HeW5CNmVyMFlLTkVFbklMS29ibkF6VGplRzQrdmt3dTk1?=
 =?utf-8?B?R09EZ1drcEhqSjQzMHFJUlI3QWVIaHBQaEVxdThTYm1kTkRtUjZRQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12354120-a040-4616-78fc-08de9b8ce1f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:50:52.3189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrdeYucBYq/ZWDLP8MD1Azqom1ptCsnfKd1GC1yU8jPTh0yHysuSUH//nHN7R9YhJlrk4e2b8aSe5JJe5osmEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7801
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 15.04.26 22:28, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 15/4/26 07:46, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> In contrast to real eMMCs, we are not (yet) persisting the full state
>> of the device. This particularly includes the authentication key used
>> for RPMB access, complicating testing of firmware images which do not
>> support initial provisioning of the key.
>>
>> One way to address this would be, e.g., extending the eMMC disk image
>> with a special sector to store further state. A simpler approach is used
>> here: Add another device property that allows to specify the
>> authentication key, bringing up the eMMC as if the key has already been
>> provisioned before.
>>
>> This is how to tell qemu to use the OP-TEE test key:
>>
>> -device emmc,[...],auth-
>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>
>> Or use this for machine-configured eMMCs:
>>
>> -global emmc.auth-
>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   hw/sd/sd.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
> 
> Do you mind mentioning it in docs/system/devices/emmc.rst?

Right, there was something... v2 our patch on top, what do you prefer?

Jan

> 
> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

