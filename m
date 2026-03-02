Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0016E9B36D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1u7-0004P9-GU; Mon, 02 Mar 2026 06:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx1ts-0004MR-1q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:57:28 -0500
Received: from
 mail-switzerlandnorthazon11021082.outbound.protection.outlook.com
 ([40.107.167.82] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx1ti-0008TY-Jn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:57:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbN6VnsSyOv7m7gdQP+8gFFZqPgFcknnR5dsIrBpYd87x2UeFclGhe0YSY5Fu6E4tYzocgfN+U+75mReK14balzCGrHMDq3mbn8NzsDYeP8xq/yx5STRTTNzzKAd/uUzRQWRQ3JREnSHcDlf4lmS2PxRNRfuim6GP78hYlt7EHr/cYNpUPVbgCtQBhVDozDvEvlCVxSO+JfHBVCanFqQ67LdsS4NOEs3Oalj355LM3zK0QbbeZbCTvlELa+Rv8hO0FQR8uAME84/P78i3ykLA+gwT+EpuuuQkCnoz+xpJnVHhLNsCDLQPNazau+7upv8ZthJbmM+m8kaNeVoG/UAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clnDMmgXWNp1ykNHtnKmst4dk+P2Dpizv8M7o5238bo=;
 b=Pfy2rpWdJWhJREMfz/N4YZB0NL61AkV1RmurVgvK3P0PNlJSoebExWNmNPRzgy7PxP9pH+XwRdUv2dmEugOvUNPHXD6FmBSxNo833MoPPILfzvQ9A5Pz00Ct0J7gySkY4aB8JDCD0F2lW//Mr5crQvjAGI/6xj6WNoOQ1vSaVkCXLqoYCJjxJa71K5VECgAk/hJiIsdKDemQQ7El+8iZVLDje+3t/csZsg/+xyUOyQq9L6tg7+ZfS87h49isCgDu5zqbO3b9j/hf4yb7RDDsTgAzPRGZlSYoYDKNg0EPHZip1K3bvK6okXs/M0KYofoM4GwlWQmGPYG1mgehCbQLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clnDMmgXWNp1ykNHtnKmst4dk+P2Dpizv8M7o5238bo=;
 b=c8JpGdiyLKyqANmfcQ+e6TsNSjKw6DoGzdsYnUi88M0hJ29h2lziVRJIvTakJip1A7Sc+WHZKAB4wyWObwusZpK0IFqeAj890UocHSMEZh9YCVj5+Nl9hXl/6CxsGY8VPHyKFOUw2aHcbGPetrdy60IDZTIp0vIodiVdq/6kky4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB0146.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 11:52:06 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 11:52:06 +0000
Message-ID: <519b075a-e216-458f-b258-4d255c8e5c8e@epfl.ch>
Date: Mon, 2 Mar 2026 12:52:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] plugins: prohibit writing to read-only registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <cc5b7b1a-b562-4376-8e4c-f01607bbcf9b@epfl.ch>
 <87ldgi2fr7.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <87ldgi2fr7.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::18) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB0146:EE_
X-MS-Office365-Filtering-Correlation-Id: dda0798c-1cb1-470f-3400-08de78522042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|786006|376014|366016; 
X-Microsoft-Antispam-Message-Info: Gla7fUfPgzwDXAYKuHwOFS94p2mUGY0rPR+lJlmoy0nt0dxFAMTT74G7By8psOibM4O2lygEgGXB+mnp3jn6cJn6u1AGKaTiPOnkLGGfq8wH2748PHKzl5DzMva3n+hloRjsAGGce7Y35ZK9mavGGOzq1qaF+IWy9hD0400UfK6OmldAUbJ3xUCL2gl4Wag0I4eLKUDxdbWeC7Lbiv4B+3YHwjHB5oqNszypWQdcremOJWORLiFFoYAHPaw+/8VB9Uj4WaPaHF1M79dHlGnUCriExO6AaA6lzRwF68nmjObbQBYIN/TbAfrw3kUKUD9RQfWGFbjs2AuOtqbf29Lsg7TBt6JgUJsCOmb4dNL7f0nqqGhHtC7MV1KELP23xtugJyUVWrE3iBPZePvf9m2aH93Qz4oZHtnAM3bmLVOHM5plqoUGjrFqW7Yth4i/jSAYncMHUDGY7WVvVLbkFVfAbE0wkRH0XyE+YLqQCa3tpwmJL3e7K4aGY+OSWLCtDGbaTHEQ7b4TSjOEtzhBhA0kGSmYYYKaoZvVOAoFZgTsH9V08dqUTUHssq37NCrIhdV5CYDIcXnMgLC8X4r48IzQb+DMDphbdKbXgZInE0OJ/My0NgDvkCRj4AJll5JkUvWW1NF3WiktbhjVTSu2b0zi2rhC+Jcpx59lETkkIyoqlYfLBXUhQoUiQVtXRElIaqUsu4m3e/ofXJ27zOKH2SqNlKb5TkUsN6swwgo0nGCdLGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(786006)(376014)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alEya0tQWkp1Ny9YTkpKUk9LY1ZSU3NEYTNNeGtycE81UXplWEt3c05jN082?=
 =?utf-8?B?MFBCSTNoc0d4WEsyWDJLd0ltaHBCZjJCRkJyN1FDSEQwT1FTQlMwd3U4UUI5?=
 =?utf-8?B?RWpIbEhFTzdOQnYyRmI1ejl2bFU3SzZKYm0yVmkvQndVMVBlY2d1QVM3UFBw?=
 =?utf-8?B?VU92UXFwK3NJTHRnc05BajhFQXBlNE0zSXVHbFlZQ0FLRW83WW9KYnBWeGEv?=
 =?utf-8?B?ZUg2dGNCZm43ZWNnc21WNjhyYytXWHo1NlFlSldTdGVmbHduMmVZcUp2UmxL?=
 =?utf-8?B?c0VrMTZGdjEyZCtFRURDdHQ3bXhESGZ5MVNKYmFCaGR6OVNKUEtIY1BJejdx?=
 =?utf-8?B?VzZnQTJrT1JieDV1NjBIRUFrSmM2NnZkR3QwUVFWQVlMamtYYXBhY0Y4ZmhL?=
 =?utf-8?B?VVlNOWdKVXN0K3JiQzJrbExqQjJOakYwMVhTdmpHbXJubSt3NEhlQkhGNmoy?=
 =?utf-8?B?d3JrZ2lNUitnK1kydTNEQTVlaWdZVWNUZithK3ZOQ3FuTStXeFpTZlB5N3ZF?=
 =?utf-8?B?Vm9JQjdraU1KN1puTUp1YkNNMlB5QTJoMHdQNlZJeU9JdWZuOEJjWFZIMEF4?=
 =?utf-8?B?Wnl5ZjZOM0RkZ0N5dzQwZ0xkK1pkWXdzUFRCMWlQK1oxaVhsck11UlY0emRU?=
 =?utf-8?B?THFIV1VqbmlpSWR3QzlhMXNSY0pRdmhtYUNianpuVmE1VWxYUEN6WTFhdU45?=
 =?utf-8?B?T3phZ01ub21aa2RLNlpBSExUY2QxNGd0NkRlc3J0QlBwa2hLWjFDOFJ1c3dJ?=
 =?utf-8?B?b0dRUk1ZM1lNTnBtWHJ2UUdLaWw4c1F1WVowQUJUREZ4dEpzTUQzZEQ4VDI2?=
 =?utf-8?B?Vi83UEpmSGEyMkVhZEsxcTI2R2pKRFdBdE40dUJxcEV2Qk1RbEgxdncyUXB3?=
 =?utf-8?B?QlFmQ3lHSUxGa21yOGI1MkdmTkQ3SDVDeFE4eTJNSnVHU05HcFBlWHJmcTBm?=
 =?utf-8?B?ZHpCU1M1bDRsQ2FLNjJqaHNiQ0FadmQxWG1JazBvTStzQ3llM1dIekpobmdD?=
 =?utf-8?B?d0hJeXBQNFk0emtMelFnTjVBTFJLU0tYTzdhK0lnbU4xenJPemhvRGhOanRJ?=
 =?utf-8?B?WVpDa2NsWXZxOElkK1hzdWNseEljMnRLbk5qd1U1c3FCL1BvODVSOEhualdJ?=
 =?utf-8?B?SnZzcXljSFZONlBNRHZTV01mSkdhRVVhSEQ2eUV0SEk3ejdMSEZldGFUZlpi?=
 =?utf-8?B?MFByUHlRSVFML0tOZGJjRG5vSXJ1bzFMbjRiRnRaUE1nZzZUazJzT08zTm9k?=
 =?utf-8?B?WkFkL1YvQjU0ajdoK2l5Y1lhL0VnUG0vMkV1bFhXQ3JySXI0a0l1Znp3dzVN?=
 =?utf-8?B?Z0lMYWJaMmpnN1EyTW5WVXkzbE4rdlVySmFjMmNSa2ZIUk1RVCtpeUlVR3l0?=
 =?utf-8?B?RHZDb2dvN0kxK25ZdFBEWHAyeDZYZU80WjVNSkp0UHBSVk1oeUl0WnVDWWlY?=
 =?utf-8?B?OUEvWlpVdDhiRjNhcWt6eFhSc0dEMWtlYkJ6T3lra0RPSExjcG54WFNsQkRh?=
 =?utf-8?B?SHNoZ01pQlA0R0Vpd2huNFo3TW10T3prQlZwUmY2UjNzSS9yNE13Skc2UDhK?=
 =?utf-8?B?RmpOVFo4SEpSdXJPTVFLWnJubkVoOXZWcXhISTVESGZlRjhRS1lKS09hNmxK?=
 =?utf-8?B?cHcraW5BdHMwWVExUGdSREF2amZmOEZEd1YwQmQzSDc0MU1seUQ2N2FhRGtm?=
 =?utf-8?B?Vy8vR1U1N1JyTzFtNFNxK3Mrc0kxTUNIcjRsN3VuTFYwYktLajRWRVRpeHY1?=
 =?utf-8?B?MjlvcWkwWEZuNUxOeTQyY0VrcEtOQ1RtQkk3bEVaQTJTK1o0TkdNSEsrYm5n?=
 =?utf-8?B?OUQxZGNpZ2ZESlFqK3B2Z2J3anQvQnB3ZkdvVXc0cGdaaWR6MmdyeCtEK1Jk?=
 =?utf-8?B?ZWd5TDdqNkQ2WWFIU0JOUXZ3amlBcjVhcXlhamk2dHRyenluQTRCSzJMSVZl?=
 =?utf-8?B?YXdadE1hb25YYXBHRzRkdDUzRnpuNVVQZVJ4UWRIUEIxMXlIZEZvc2dMbFZn?=
 =?utf-8?B?by82MnNBQStncHlXMk9ERy9RaWtpRlVISnNLSU44SytPNVR1S3NvWDFlWnRQ?=
 =?utf-8?B?alBWRy9DTDk2OWMxUjlnWkQvdW85Wkg0OVVBQm5rUlJkenZJZlZPQWwvazZq?=
 =?utf-8?B?cmxLejI4T0lsWmxGL0MrNGhCNkVheUIxemhmeTVtYzZGZmlHOFFoY2RyUkpC?=
 =?utf-8?B?a0NRSm1rNUJsaFpsekFjV1NQRXdzOU8rcHhkMWh1YWVydWh5MXBSVEJFR0pT?=
 =?utf-8?B?d3pDT0lGOWpGR2RMWkIzUE9SeXBxMG12OGRLOTl5YzdMYm1qZTlnZWhCVDdz?=
 =?utf-8?B?N29iTmpqbnVoMFpyMUdkOGV5RDNmTm9VUHVQZkI4eG02cmNpVXlZdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: dda0798c-1cb1-470f-3400-08de78522042
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:52:05.9647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc0V80+KkOy3shQQenemwnG4zyEXz313U3n3XGudDfmiYOyT3T3b06lO1QVRPIcQ0t1imlwkQLVPR3gUm2F/nVlIz0GRafPr8W3r1ch07rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0146
Received-SPF: pass client-ip=40.107.167.82;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 24/02/2026 18:49, Alex Bennée wrote:
> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
> 
>> The opaque register handle encodes whether a register is read-only in
>> the lowest bit and prevents writing to the register via the plugin API
>> in this case.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>  plugins/api.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/plugins/api.c b/plugins/api.c
>> index b2c52d2a09..3a8479ddce 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>      for (int i = 0; i < gdbstub_regs->len; i++) {
>>          GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
>>          qemu_plugin_reg_descriptor desc;
>> +        gint plugin_ro_bit = 0;
>>  
>>          /* skip "un-named" regs */
>>          if (!grd->name) {
>> @@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>          }
>>  
>>          /* Create a record for the plugin */
>> -        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
>>          desc.name = g_intern_string(grd->name);
>>          desc.is_readonly = false;
>>          if (g_strcmp0(desc.name, pc_str) == 0
>> @@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>              || g_strcmp0(desc.name, rpc_str) == 0
>>             ) {
>>              desc.is_readonly = true;
>> +            plugin_ro_bit = 1;
>>          }
>> +        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
>>          desc.feature = g_intern_string(grd->feature_name);
>>          g_array_append_val(find_data, desc);
>>      }
>> @@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
>>          return false;
>>      }
>>  
>> -    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
>> +    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
>>  }
>>  
>>  bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
>> @@ -476,11 +478,12 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
>>      g_assert(current_cpu);
>>  
>>      if (buf->len == 0 || (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
>> -                          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
>> +                          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)
>> +        || (GPOINTER_TO_INT(reg) & 1)) {
> 
> Maybe this is better as:
> 
>       g_assert(GPOINTER_TO_INT(reg) & 1 == 0);
> 
>       if (buf->len == 0 || (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&...
> 
> again the plugin is trying to do something it shouldn't.

As far as I can tell, there's currently no mechanism in the test setup
to check that a certain assertion is triggered. In the previous test, I
just checked whether the API returns false when I try to write to a
read-only register, but now I'd need to check in my test whether the
assert triggers.

Should I check that in a wrapper script, test only the read path, or
follow a completely different approach for this?

> 
>>          return false;
>>      }
>>  
>> -    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
>> +    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
>>  }
>>  
>>  void qemu_plugin_set_pc(uint64_t vaddr)
> 

Best regards,
Florian

