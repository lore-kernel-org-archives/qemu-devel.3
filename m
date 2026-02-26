Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32273FC592F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZyy-0002u9-T8; Thu, 26 Feb 2026 06:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvZyw-0002r5-4w
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:56:38 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvZyt-0004PT-VW
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:56:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJQBz46s8R5VPkLc85d8j5vTckSZywy2y5aHp45tsdu2mwkGGrVw63jZfqM7gnEuIQWkNJs1ioqRRNK2Qu/Yjofosbg7YS43ytql+wPeL9fH86KJiz2UTse+YU0Oxf+6+Zgp68ueB3bSa74CHYmsG1sKoR4K9niGqgbPLnQiBSwqGbCLNdH/obbmrZROiEEogXk22t9QDRLIYwKH1VwM6Q4X4DzrlWo8iFf6eZNFoldfYq1VqCLOvKZbSNwpWfp4s8BFgJlxwwj1NpSXPTJGVv9RyRBeUh3+jQExBw76sgLgnFOpcopcam24cokzeYeA0xVNFOkpHkpFbLi/pxobCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEhqyc78kecp2YKL1gfo3ZqTZGl+vG6e8aTsoXH6PKY=;
 b=EhzMnyeAmDmdsuXwGSTZzDxlzkZSCmn76vJYl9RWGxI7f26K5r9aw1e16paRGv75d/m0TOn5ZE61f/uZyfb2bTfOAnBaJ6SyLJuLysCEliCVMzSUVcmY1s+4WcUiaM6m3BuWNTcFDSsEnxnVgOxhKAVuLuDcTLXsCDW/aPuuW/3p7tpNSBxk9Y/m9QSw/Merr9SeJdszhvYcXwoBBO4W6Q5WLvDEu0G1H1xSvJPx5SsUmeK4NXdezZwZZxl7YL25AJw1IWarPFMUTydYxPRN6NFiM7+ZExKYRH88o52wjPCcbXwynu+oGVFwmYB+6ZUbHvEoNwm0VmmR20TjZlJfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEhqyc78kecp2YKL1gfo3ZqTZGl+vG6e8aTsoXH6PKY=;
 b=l2Bkl42EL9xWnkdBBGzgxy1RzK13jllhFSLWDE4mhjPGOKOGargRb+UEd1HSewdDrp5GL/VbgkT/hqJSgEheEE8Msqkh7oUIOLO+nMt26vs05zMGLFYrpx+EV9YebNKiE8nP2gOBOYtrn1JhHQ9ejlwnci2AcDwjHvU4OIcv1xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR4P278MB1970.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 11:56:29 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 11:56:29 +0000
Message-ID: <5e43b8f7-e8ee-4cd9-b8a7-f4b4761b6137@epfl.ch>
Date: Thu, 26 Feb 2026 12:55:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] plugins: add read-only property for registers
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: alex.bennee@linaro.org, pierrick.bouvier@linaro.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8716147d-d5b4-4d8b-859a-26a5310973bc@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <8716147d-d5b4-4d8b-859a-26a5310973bc@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::15) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR4P278MB1970:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0055f9-1e59-400f-ecea-08de752e1372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|366016|376014|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: HYwAZp6kbRMWqopH86b04CS4HdDxy+WhOEHkRq5m0gQqFzr8PBz9Tji+v3eMR0NQ4n/NxouNYXRVgkEZ8VMvYnO6LkcZ5DhbGEihpzfoOGNzsSRD1l58ahrHHfjo1JU08vUuG92tpJUXLNIP/s4EoNT6opATJIG1M9LOpmoQ+7MCn/EH0BqcNrBYcb+L5ck0Sw6joKumKYY1LCo3wkfYVhunSjrtexgm17E2L9ngycwZBmFH/pqEJnJLaHiiuTdfXPsYkpv9ONEL7s+gvX6LB3POBm6o1bOggEQRdf3hsUxKSwvV+8rpk9kMmsNDUKFN2FC5AhUtjNUYcBLY1X5aFyKHDvG1er20p5He/kpZcl6wIqDXN0a2XUZoO+Wg0x6TX6RPVLMlOOZ9dagwWru9seC/VTIUOYZzPmrk0DmqXApvpH6B/Z/Vh+BhE0Zpx/q2hL/6TM2vZhk7WV0Cu3vIlbMipgF4Sleu2/xcSyzI3MYFfFylpJ5i5Lf0pLePqK6lz5Vnj0fccTCq8Rhmb13p290jDeRiM73Xoriv45qzdgHsewftMpS4SDj7ScGKq5hhuDItjW1ACrfsfmUuVl8qtyCSqnmtnwX4D4ST5PQR9HErH/zZySzcGErfjMEsqp4gs8WUT+gDHd+kW62lAvPOuhN7NERuJtH5Y0QetCTz7A4FmtWc6DrjPOKTXQyMNyIvGH+R9CQbeX51yghliXkZnSjbFpteEpR6Kv746symQEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(366016)(376014)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9jNVg1alRUbDlSWmZsL2NHSnVCK0d6cUxPMlIvd3RnbHRScStacFkvaWgr?=
 =?utf-8?B?Z000R1lPODdvMEdIRDczaEI1bUl1RGtCSVlLYmU0dE9wekJMZE83VW90Um12?=
 =?utf-8?B?ZDdqN25uSVV6SDYvRS9VSU5WYTBBUjBDdUZUZ3h5NS9jRW9ZTFRiVmJNZGpW?=
 =?utf-8?B?TSt6dzVqanNubXd0TXJDTnRPY2dxaE5uaFYrMWxTOVVMYTJob1I4dmU1Wkxo?=
 =?utf-8?B?RUJnSll4N1p2YVNSS0hsWFdGWWRFYlBWZzhVN1NFK1FqWTFLRVJZWVc5ZTdB?=
 =?utf-8?B?VEx2dmVWVWt6Z2d5QWl0Ym1zZko4OHZvMUp4WUc0cFg5b3ZpUE8xQzRPbjNJ?=
 =?utf-8?B?Mmo2RUkzUEo0akRlL0RxMCtzbmJWenJWa2xRWlA5N1VISHFadk1kUE43R21K?=
 =?utf-8?B?MExyc3Jxa2pjZUJjd1pIWXlVV3MvV05YTWNEZTlXTFNkVDBYb3R6ZzBIeWZ6?=
 =?utf-8?B?dFl0dFB1ZHRRQlZ3eUhrUkkwVVZ5VEQ0NjA5aVplcUh3RkllRUoyWGFjUWxv?=
 =?utf-8?B?NCs2SXFFRndNeGF6VDBhSmVpRjFwNTF6eVhXMHllckU1ZFhsOUV3N2lpV2Vy?=
 =?utf-8?B?T0xacTRQVE9nY1VDSitoSGpLa0l2Vy9NYlhFNFBhUG5zQ2R4dXo0NzcySTRv?=
 =?utf-8?B?Q2poTkJWV2VJM3QvSW9WbnlIV3NzSDdLT0lMcStyZzgyWmIvVjNhWGlQUVZR?=
 =?utf-8?B?MllkQ2dyU25NdGpzaXlUZW9GUXhocjkzMDBVOWdWOHk3RWhDWWNOcklHMjdI?=
 =?utf-8?B?TEkyVGxEcVdxWU0zbzVkTmtYSm1QTlRPV3B0NjNRRzhLS1NJWnp0Q2QzcWsz?=
 =?utf-8?B?dmwzYmEzTDV3WkVNSUFKUmRiZmVZenZGd0EyRHBKdnVycERwOE15NW05SFRu?=
 =?utf-8?B?bHRRNlVxYnorUENwdkEraGZKQWZEN0JOLzBzaGMzTjBYS0VHU1Z0a0NJT3JY?=
 =?utf-8?B?czJ3dzJBQlJQZEZ3czFhQTVrQVN1d2o3ZHM4MGhTQkcxcEFUUVBuL3NLL1E2?=
 =?utf-8?B?MlhuRlo4U2tWTm1QS1lDZk1YeERLcHIvczhwdzIzdVZaMGtHVWhNZlQ5YmFV?=
 =?utf-8?B?a3IvSjVMUnVsZVB0Zk02UGxkVFB5ZFZGQlcxS2U3TWFwK1UwTERVNjQyOUtw?=
 =?utf-8?B?bDRDaS85U05QSXNRWXZvSFQ0N0RHdXAxZzNlSC84cDBUdERZeG1zVzd2MVI5?=
 =?utf-8?B?Wk51OEhLamlVSHlOYncwVnRYb3NjeSt0d2VzanhDS0srdlJuSnVwOUIxcFV3?=
 =?utf-8?B?QkNBYnE0ZSs5bGdZcWVmcWs1Q3JtamMybFUxZk9hd1FQSkgvVmZsbldEUEtB?=
 =?utf-8?B?N1A4bnVkOWhXbXNHeEZnTGVNVFE5SXIzVzJXcS91TWp2NlJ1aGFnWjdiWk1h?=
 =?utf-8?B?RU9MQklYZVdoLzUxOHM3KzZEL1FzT2lBWC9wWVd5WGlHVWxGc1JhaENLODZ0?=
 =?utf-8?B?R2JzOUFablM3c2cxWEJudTRQK3d5ZXQ4c3hhR1lhdjkzSFY2OXhzS3NNZFBy?=
 =?utf-8?B?eWxmTzQxR0tzK0pKVis5R2IvTVNpdkRpMytTbWREdjA5YWw4MHpGVU4zK0Vy?=
 =?utf-8?B?SzZGS3lIbENEWUdIbS9hUlgrSllsVkJCR0liMEQ5VVNoSUd2R0NRUlQrLzgv?=
 =?utf-8?B?VHE3QW5JRE1IZDNleEo1RTRDcXdjUnY4QUJJZjZpck4yaHc3TDBFb1grWFh6?=
 =?utf-8?B?Ym1pSDZjekdaTE4wSFJpRldEM2RqYUd2Uk1YSDh1L3p0UjVkUDYzMXFxb1Iz?=
 =?utf-8?B?UWZvVTF0OGtJWk13bUM3VFYycWVOeTZ1UzFmbC9pNWEwMEZRVUtBbzBJREQz?=
 =?utf-8?B?QWdtYndZbWMzRGZtV0tuMWpXdDczS0U1ZXpWYlJVMlR6bEJhZWtRVXlteVBO?=
 =?utf-8?B?V3d5YjNkQVBpaGJpZ2FlNG8yM0JNT0ZXWnpYQy83RE8rcjlMUithWWM1UGkw?=
 =?utf-8?B?WVI3NmRwVUhFNHM0YTNWUDVCb0V4eXNKRDF1U0ltemVaY0NMTXo5ZDNSYTJy?=
 =?utf-8?B?UXR6ZkZxc1BlWGJmSXNPS1V6bUhCT2JVR2V5REJibVFQL3NvWjM1MXBhMUNO?=
 =?utf-8?B?YXhDbTRrZzZQdWcwdmJjY29HZEdqOHh3RnYxSDVOZWpoUk14S2YvOGJ6YXpP?=
 =?utf-8?B?U28yZU81em8xS2RQcUhCWGpKZi9VYmM1Z0ZrT3YrOGlhQnlqY05VQk00VUEw?=
 =?utf-8?B?MGcxL1hLa1hhdGxPdWplcWlUK3dRZEd6ZkhscWVuM1BzeVgzSWRuVnNUQVB1?=
 =?utf-8?B?QVYzbXhoUlNoQytTenR6a2dtODJsQ0VKVktXeHFyR2pUOUgwQUtmV3IzK2dq?=
 =?utf-8?B?OHdScm5uMW1UTHN0WTNmN0VjQ2JhbEZIa2t6SldzRm1kbjFyKzJoUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0055f9-1e59-400f-ecea-08de752e1372
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:56:29.3031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xtCbcqy/USLPcviTfnx0gH/8uXGNJueVhwDJh/x6HpGxYzAOys6D2n27vvCg2tZNXlaim96kQcA8a3Ted2hPkbM3W9w1qnPcIfkhGJY83U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1970
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 24/02/2026 16:53, Florian Hofhammer wrote:
> Some registers should be marked as read-only from a plugin API
> perspective, as writing to them via qemu_plugin_write_register has no
> effect. This includes the program counter, and we expose this fact to
> the plugins with this patch.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  include/plugins/qemu-plugin.h |  2 ++
>  plugins/api.c                 | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
> index 04c884e82b..ae711758f1 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -979,11 +979,13 @@ struct qemu_plugin_register;
>   *          writing value with qemu_plugin_write_register
>   * @name: register name
>   * @feature: optional feature descriptor, can be NULL
> + * @is_readonly: true if the register cannot be written via qemu_plugin_write_register
>   */
>  typedef struct {
>      struct qemu_plugin_register *handle;
>      const char *name;
>      const char *feature;
> +    bool is_readonly;
>  } qemu_plugin_reg_descriptor;
>  
>  /**
> diff --git a/plugins/api.c b/plugins/api.c
> index ca3e93a194..b2c52d2a09 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -410,6 +410,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
>   * ancillary data the plugin might find useful.
>   */
>  
> +static const char pc_str[] = "pc"; // generic name for program counter
> +static const char eip_str[] = "eip"; // x86 specific name for program counter
> +static const char rip_str[] = "rip"; // x86_64 specific name for program counter
> +static const char pswa_str[] = "pswa"; // s390x specific name for program counter
> +static const char iaoq_str[] = "iaoq"; // HP/PA specific name for program counter
> +static const char rpc_str[] = "rpc"; // microblaze specific name for program counter
>  static GArray *create_register_handles(GArray *gdbstub_regs)
>  {
>      GArray *find_data = g_array_new(true, true,
> @@ -427,6 +433,16 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>          /* Create a record for the plugin */
>          desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
>          desc.name = g_intern_string(grd->name);
> +        desc.is_readonly = false;
> +        if (g_strcmp0(desc.name, pc_str) == 0
> +            || g_strcmp0(desc.name, eip_str) == 0
> +            || g_strcmp0(desc.name, rip_str) == 0
> +            || g_strcmp0(desc.name, pswa_str) == 0
> +            || g_strcmp0(desc.name, iaoq_str) == 0
> +            || g_strcmp0(desc.name, rpc_str) == 0
> +           ) {
> +            desc.is_readonly = true;
> +        }
>          desc.feature = g_intern_string(grd->feature_name);
>          g_array_append_val(find_data, desc);
>      }

While extending the tests for my patches, I noticed that there are other
registers that are effectively read-only as well, such as the vg (vector
granule) register on aarch64. I wonder whether there should be a more
generic support in QEMU for this or whether this is something that
should be handled by GDB instead.
The difference to the pc in that case is that the pc architecturally is
read-write and it was just QEMU who silently swallowed the writes to it.
For the vg register in the example, as far as I understand correctly,
this is not an actual architectural register, but something that GDB
exposes as a read-only register for easier debugging, and QEMU therefore
also exposes this register. However, writes to it with
gdb_write_register and by proxy qemu_plugin_write_register are silently
ignored.

I'm not sure this is something that should be handled in this patch
series but I'm wondering whether this is something you already had on
your radar or whether this should be taken care of in a follow-up patch
series. I'd be happy to get your thoughts on this!

Best regards,
Florian

