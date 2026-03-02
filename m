Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D736E9B37D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2zG-0000wd-IS; Mon, 02 Mar 2026 08:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx2z6-0000rC-2e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:06:54 -0500
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx2z3-00034p-Gx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:06:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzpyrDJAND4yFQBfiXTTCbciI3qlvbF5TicytaIfNTWTCsbfGBuxIQ+ye8e5m/kNzDhh9GLBZVDvRDzB9nIORejH8JABvFKFOohViY5rN72f7nmkbPDfq36d0aj4lXm8K91fn2bQQq6Ayh+b6YdrQxBRThUt4XcpjEwCha1pPq0TcfapTpK70aGxaSCEOkevQuLC2a0kewKVn/KgzOnFK494XyRerT3Tn8Y9dGNoMCtsa9ZgRr8/WzF4rCBLjo3AvBGen1de5Z7lqJwWVcaWlCbBCBDqOYDyjvhE1/f8P3rIbCuPEA8DMA0xc/3GZ7PkU4SH3YFrktjDvBJ/zoCzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMpa9UPKz0ZaKFddSv+TCUKdaH/LlDW6cSsQw5ea2iY=;
 b=ggaaq2WOl3CX/ALJM/wfOTg5Ci3lW5zQyfS/roBwGZfo1wufBdmT6P7D/fbxghM+sdAGydEPGWAasjShLXGdwpnrv3FdqoFBjNcJS76rYGpBA/F1e+HJ7lGy494fYtcP49pVU/O+bc7QzAzkIIGw5US13zkiYVeFYuNrCBOHzy7Zi6Nnc7V9IUQD5LtAE7vXJjGtfWeuwUo/x8rJNMeL+hzEXzGO/D9cvZEtw7Y/5maz/QcqNYFXFU518Np4KsCacL0L7texYwjkdVnwkhoJNCCxpn1zhF49RXXBYQKOVHMyPTU6w4qTGtc1L33yxHuWxVdjmD6zPOcQu+SSjieJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMpa9UPKz0ZaKFddSv+TCUKdaH/LlDW6cSsQw5ea2iY=;
 b=OAlTRxPJgMp9I8Oob+qWha05YWfKp2whHvqfkP2cyHHQkqbwSZNNs8jOq7hDtKCeij6xo1XaJXWov08YFy1jXCcrqG7im0MJ/k1aZ4lDwMcA0CM7DJOK3ax6GUMYzWYW++twlK7M4dm5rjyO/2YRQ1/HX1Qc9/gAecDpqyLCuAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GVAP278MB0053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:06:43 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 13:06:43 +0000
Message-ID: <f356bfaa-03a3-4623-b158-33d49878c8b7@epfl.ch>
Date: Mon, 2 Mar 2026 14:06:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] plugins: prohibit writing to read-only registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <cc5b7b1a-b562-4376-8e4c-f01607bbcf9b@epfl.ch>
 <87ldgi2fr7.fsf@draig.linaro.org>
 <519b075a-e216-458f-b258-4d255c8e5c8e@epfl.ch>
 <87ldgacrjs.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <87ldgacrjs.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GVAP278MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: e888be36-b3b6-4391-2491-08de785c8d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|786006|366016|376014; 
X-Microsoft-Antispam-Message-Info: ZbCFhtvCDb+qTFe5W3ItcewGWllQna1YPZRXDcka+HG9MDa1aqZBOKdMnVQYw7WvupxV8/Ol1gby/g+yLANt156AXJWWNvTu8guAy5Y7VoYhkUS3zdmsr0i9P7YtfEeVDqv/Ub2B4iOuTS1mLT3bFpX589B4o2WxkfLvg4gZ5dJosc5cU+hDu2MqDbCLT7W0hyWOYCZMdmD/n9zqoSG27aawDp+TFH4+mNfKwi2y8ubSSdhSzSUvp76052YqXR5e68GN6qMH3DXSas7Q4aqlMyPne79IYbZ7vpUaI6Wm2ET9YuDF9VptStvuyeIoUzw+XQCZSD0usVGcBrgLZGb+LxfKYnz7ndtsvaBMDP5TPgXpjrcXHVAEfDEZgniREbg3mYzwcj0cFmRS9ggMuyWyj+R2cp97CfSEP31cjNMS2kAw+OMYz7wImSvjswMzoymwnNE5YknyEGBwADL3mCIC7Hto8X9wKYJEmvsbKGAKY17nOhSJLvlWdasbcCF3qUeuzEKtpfMH1YgQVKQ/Y/ZCbD6afZqp3ckxZqkl2OMbh1u94oGgYGvNFoC8Skqli3d6qIaSBmUFyrV7g2z0dYpbIYMUV1oK1BK6Zed6PT1Ln1drli38UsZ5vm5PtmtxwMiidXMSMhsCR9e3earc/R2CgxMv0uQhlR42UbBj4pLttaDmWkwJs8c3SNEszNchHoRpPpQBIfGmq2C2kg1mlBrQ0ts+BFrOHxoIMPoC/x7OTAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(786006)(366016)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGM0NDJmcU5NYU1Kd0Q3Q0ZwazU0TXlTajV0a0c5QWhwN2ZUc01qSi9TdlVC?=
 =?utf-8?B?UFgyck0zbktzeHBTRWxid04weG9ISGFCYlB4TElwQnE0dDhMMEJldSs3WkJV?=
 =?utf-8?B?djBhVXc1am16cUlxRXlpRm1jT1ZvcjlxU1Q0Mk11dFZESmxoRjlHampSM3hI?=
 =?utf-8?B?bUozM3RTTkh0U1lTUEZQdVYxQUtRMkRjRGduekxnYWczMFJ0L2RWZmhPUzlI?=
 =?utf-8?B?OFA5RWd3MUR6OHRCV3VUV0xXOGFxNW5zbTJaUFQzRjlIbWppZkZ0RElqUHNO?=
 =?utf-8?B?Rjl2amVLWDNMM0d5dUFhWnBnVTErYWdJazNmT0dQelB5UHJMdi9JYlRpM0JM?=
 =?utf-8?B?NndEcWlqNnhFTEJBODV5NnhKWW5sbjIxU3BpL1FETVNWTTRTak1qeE5Jancy?=
 =?utf-8?B?UHRaV2RDajkwUldQTGFwYS91N2g0QmJBcVhKN0VMLzM0Z25CU2RWRC9RckN1?=
 =?utf-8?B?MktGMmE3ckYyN21vVitmNnFDSkMvL0dWWHVMcTQyTnNPbEZYaWlmcDgvUTRa?=
 =?utf-8?B?RzB6akFGb2E0SVVUREkzYlZZbmo2b2IrSzQ3S3BXTGNnQ3NvVHBvQVloUTlW?=
 =?utf-8?B?Y0w2dFlZa2h0bHVLYnJmV2dwb2JWME9mOW9icnJBbWJmRFkyMThRMlR5OWdt?=
 =?utf-8?B?QlZMZzFpcWl2S1E2QjBQRzZYbzJYZjJrN2krU2cxVk5VbUJkcFV2ZzlTWWZp?=
 =?utf-8?B?bm5EU2dOTnhvZnZsMGRCWGU4c2FONGYzOXFlb2xMQ1ZjVWZTZzNoTzR4SW1Y?=
 =?utf-8?B?RFMxMUdsZTdKK3BNR1RhaWhvVTFURDZXMmd2V05jSEw5V2JiZFFmaXhuOXkz?=
 =?utf-8?B?RC9ZZEF0MktFbzJxMThjUU5CLzkrV01GSktLKzFhQ0UrTHFQSVVkeTJSUHdN?=
 =?utf-8?B?ZFFtV0c1R3NlYk5XTGo3WEQrSXRuTWxUV0o0VUZYR0xEYk9ZeXdkM1RSb3NU?=
 =?utf-8?B?ekRLODFkdjhraWJIUnh3QVFza212bnF4RVBQQWJDbjVjbmtKY1lvNlZVRnZq?=
 =?utf-8?B?dktWWmdiUnJyODEzVDlPMVFUa05jeFJtMVZaY1lDd1dyeW9OK0k1RmcvcXNy?=
 =?utf-8?B?M1hTLzhhUjBXbmdSbjBIWGcyUlJvc0dHakVrZTVYais5cThXSkpEZzAwNlZG?=
 =?utf-8?B?aDNCQVkrL2lKUnJSUkE1eXBBeTJhS1IyWTd2V2tNZDk3dFRoUVU2c3JsMGFP?=
 =?utf-8?B?djFCYzJoL3ZiTXNZMFFya3FHbkF1M0JlVDJ3KzFYU2pGcVBVWm92eGE0Tlpn?=
 =?utf-8?B?U2ZhUkhFL2tTTWJFalVUeVY1VDNDSUF6dEZWK2pwRzZWNFBjVFFDaEJLbkpV?=
 =?utf-8?B?dTQzeFlvNGkwWWVHSmJHNFVHaksrdWc5RTgzeXFRdWN0T3pCbUI0N3AvSmhz?=
 =?utf-8?B?ck9ER3pxVERVK1FuYktxTW5ZazBTVm5HSDdPZVZsbWlPRUtXVEZ6S0cwZnls?=
 =?utf-8?B?WnBWdGNYQ2ZFSDd0R2tRSFRWSUY4Y2tLclN6ZXFqdzJONDF4cHpRWnFXWjlq?=
 =?utf-8?B?TFB3cnpvaXZtd2JwUGxjNmloK2dwcnpobWs4WVBSeTNVTkEyaUZXWDdJT0Y5?=
 =?utf-8?B?cTVvRTBiTWFFenZzaDRwOTRYSDhtd2RXVE4rcFF0QXVVL0dtZURyTWladVh0?=
 =?utf-8?B?WjlZQnBWN01iRlovcE5CeHpiaHMrWElSVmNoeDB1OVNvQStNbm9qVlFoTk8r?=
 =?utf-8?B?UUh3TTFEZTIxbEFvaVZvekpjZzl6R1B6U3R4b3lqMFg4L3lnYnZHT05SR3Fx?=
 =?utf-8?B?Q3NHeEI5eU0vZExTcUgrN1VCZVRsNlE5K1VxK0tybUNQOUN0UGpYUGRZN25M?=
 =?utf-8?B?aUdJN2JpUkl2K1c4OXREamNzbTB2c1NHNFhwVzJuSVVhRmZGOGNueGRFNG1U?=
 =?utf-8?B?ZGtoa3VCUUFwaklKbXhYWUVXN1pLajIxS1Q0aWhkNjlXN3lCVVVWUnA1elFI?=
 =?utf-8?B?N2RvZ3BoeTBrejR6aE1DMzRzcHR1ZWNhQk0xamVqMWZsdWQ4ckR1L2tEbWdw?=
 =?utf-8?B?dFl3RS9ITHBhUThBK3ZuYkZBRUhuNlRKZW8xUXhlVTlvdUxsaHF0azc1QWlI?=
 =?utf-8?B?ZkU0RzA0L1hIVGdtMEp6R21oSVFDc2xiV3JDOEFRcWx5UG4wSnVLMk85Q0l0?=
 =?utf-8?B?MWF4QnVHWmZMSU9YOFluKy9DYWtvRnA2c2xCcUdCSjh6MzNwMUROTHF2R08w?=
 =?utf-8?B?U3BsZ09ZY0pJRFpHTDhBTkVhb2RDWFJqNXBHeThBdVZ2SDl1QzkxazM1QTJi?=
 =?utf-8?B?Z2pDb3hkbWt5ay9CbGlZSEg3S2E1SXB0Zko4Rkliem00amRaeExzNVB3VVdr?=
 =?utf-8?B?RVlwa0xUaEd2ZHdJczNFWlR1c0xlWno4ZGN0QXQyZDVEWUQvMmpaUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e888be36-b3b6-4391-2491-08de785c8d29
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:06:43.5896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D9bNH8PYhijLIx4udhSvbqAy1961REh/cCT5JbACxPPygsSr3Y6ESLEVOj/F5hmwlV7Dv9LyA/cFwPAVYxvkTcfZXjbU4yO5rwY/4Hhlmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0053
Received-SPF: pass client-ip=2a01:111:f403:c213::2;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
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

On 02/03/2026 14:03, Alex Bennée wrote:
> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
> 
>> On 24/02/2026 18:49, Alex Bennée wrote:
>>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>>
>>>> The opaque register handle encodes whether a register is read-only in
>>>> the lowest bit and prevents writing to the register via the plugin API
>>>> in this case.
>>>>
>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>> ---
>>>>  plugins/api.c | 11 +++++++----
>>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/plugins/api.c b/plugins/api.c
>>>> index b2c52d2a09..3a8479ddce 100644
>>>> --- a/plugins/api.c
>>>> +++ b/plugins/api.c
>>>> @@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>      for (int i = 0; i < gdbstub_regs->len; i++) {
>>>>          GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
>>>>          qemu_plugin_reg_descriptor desc;
>>>> +        gint plugin_ro_bit = 0;
>>>>  
>>>>          /* skip "un-named" regs */
>>>>          if (!grd->name) {
>>>> @@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>          }
>>>>  
>>>>          /* Create a record for the plugin */
>>>> -        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
>>>>          desc.name = g_intern_string(grd->name);
>>>>          desc.is_readonly = false;
>>>>          if (g_strcmp0(desc.name, pc_str) == 0
>>>> @@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>              || g_strcmp0(desc.name, rpc_str) == 0
>>>>             ) {
>>>>              desc.is_readonly = true;
>>>> +            plugin_ro_bit = 1;
>>>>          }
>>>> +        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
>>>>          desc.feature = g_intern_string(grd->feature_name);
>>>>          g_array_append_val(find_data, desc);
>>>>      }
>>>> @@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
>>>>          return false;
>>>>      }
>>>>  
>>>> -    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
>>>> +    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
>>>>  }
>>>>  
>>>>  bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
>>>> @@ -476,11 +478,12 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
>>>>      g_assert(current_cpu);
>>>>  
>>>>      if (buf->len == 0 || (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
>>>> -                          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
>>>> +                          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)
>>>> +        || (GPOINTER_TO_INT(reg) & 1)) {
>>>
>>> Maybe this is better as:
>>>
>>>       g_assert(GPOINTER_TO_INT(reg) & 1 == 0);
>>>
>>>       if (buf->len == 0 || (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&...
>>>
>>> again the plugin is trying to do something it shouldn't.
>>
>> As far as I can tell, there's currently no mechanism in the test setup
>> to check that a certain assertion is triggered. In the previous test, I
>> just checked whether the API returns false when I try to write to a
>> read-only register, but now I'd need to check in my test whether the
>> assert triggers.
> 
> Ahh I see - I was going to say we don't really need to test for abuse of
> the API triggering asserts but you next test does indeed do that. I
> think we can live without explicitly adding a test case for attempts to
> write to read only registers.

Ack, thanks for the quick reply!

> 
>>
>> Should I check that in a wrapper script, test only the read path, or
>> follow a completely different approach for this?
>>
>>>
>>>>          return false;
>>>>      }
>>>>  
>>>> -    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
>>>> +    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
>>>>  }
>>>>  
>>>>  void qemu_plugin_set_pc(uint64_t vaddr)
>>>
>>
>> Best regards,
>> Florian
> 

