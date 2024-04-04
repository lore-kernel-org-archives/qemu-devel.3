Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4EECD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNg1-00076G-8i; Thu, 04 Apr 2024 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1rsNfz-00075L-Dy; Thu, 04 Apr 2024 10:02:47 -0400
Received: from mail-dm6nam12on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2417::700]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1rsNfn-0008Vm-UW; Thu, 04 Apr 2024 10:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5K3krKrG81TGo2NlLfeEv8jiBTWmLC1TR4gq3/cuK60DrqJ+MEY61ySWhuM1Xz4vjsjaWyXcbUfLYmw3FKa91pD3I7bbce0ypKIs2EdoZp/hmKnlGJgV6ZD8Kq1EfZYgk4RU6pB/ZgjMgdfyGvvXHifcIaq+50F5kNpGlnFTWZmQWfLfeaveKGYgxWFDdaA0wAYoPLEdKqRy3aSTN4xlfp+T/SmxABeLPkTRP7bpSZUaHoLN4H3lECZA6o4iATyEocuoYAzyxHyy52OFx+mkCuAiCgWPlPyDfnRZP2ly/YOBgM/JBNOle0p2+XnDIuCfOvwl0zuDDvfj6n5CxNgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTOW4eL2J48x/anFI1wj+IwFebKlVPP2FM9QzD+so7k=;
 b=gJfmFLwmiffusNptXAQ1/VV9XQZYhzPtU0jRmZtu4xIMD0vvEAiN9JYXhhI9WJIG3MaXBL76O04czusMj6OpHKfl+rE6PvZKvTb0970mqXSHAUJxSLf0eC+P9tmqhx7Exy1hN2fLccziMTEzBOH+Gbp/5g+hstXOh0hxzVXKV7n+LZIzr9Q+YY34DpKQVvfmLrg4RdcqO1pSdOHMRL+bMmKcyFX+Pu2kxEsxdqruKuFUypL6LnYImuSMKHFjVLSbO2TvWobVA5sPLIvjHdCbt3NxDohDo4VQWrF7H0We7wllqSLjHKf99bY7oMRcgIEfdlXp72luAhECSXP0ugsAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTOW4eL2J48x/anFI1wj+IwFebKlVPP2FM9QzD+so7k=;
 b=J89j8rv3sbiVwjkAjWL6cr7MkZwXhqLBAXxj5UIs3IXzG60hAGEhvaNPxTTNyJ5jnkYebSdr8tZ9KdNkS8cnhhP0D+usQaWce8GLZ7VuVOtCQzVplD5U6yVogAXnex8rQFH+zJDJW4tL3Fs2MRyFVyvQcvcP71oZCniWEI2jodA=
Received: from DM8PR01MB7142.prod.exchangelabs.com (2603:10b6:8:1::11) by
 CH0PR01MB7106.prod.exchangelabs.com (2603:10b6:610:ff::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 14:02:27 +0000
Received: from DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1]) by DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 14:02:27 +0000
Content-Type: multipart/alternative;
 boundary="------------cF4OedXxvwA4KzUguFT5AQgH"
Message-ID: <884099cd-f57f-417e-aff9-52a7d77dab31@amperemail.onmicrosoft.com>
Date: Thu, 4 Apr 2024 19:32:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 7/8] gdbstub: Add helper function to unregister GDB
 register space
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com,
 gankulkarni@os.amperecomputing.com
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-8-salil.mehta@huawei.com>
Content-Language: en-US
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <20240312020000.12992-8-salil.mehta@huawei.com>
X-ClientProxiedBy: CY5PR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:930:69::14) To DM8PR01MB7142.prod.exchangelabs.com
 (2603:10b6:8:1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB7142:EE_|CH0PR01MB7106:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcBFvsrU9y4aJtcepmA9oprYocQOfpDTUMGAY4PaSDhgjPDiopcpqx/emxJ9aYPtnXEf8lnIbTOuGFD6hBXrNnZ/U2uf5RYso6dN0GLiWSBr51bdVJo7I5tfgAXPVCTcKgGGD245m4KIP90XYVnxuFHfkIR140CDvx+HUYFF0Zn0sg70MSeCe2FauIwfWEdZQ8OkwLJoR6T9ewd1qU7R4GdRzVbPH1O9Zlc+uHFgDIKtqtWKUn826sJ/4H3tkHFm0HWpMwgIWZ1mbjUaOEGtECBLNdOlDGAEHFG4jRz0FpMJqh9GzapCeLadh+4v2IFOhITmwSnykmcb4XV3hu1EltTUKtibBvkVG4ZUL69FQ7DBTjLJktzFv1la126QbZxvPe27sbMkRej5wXTWqfr4qjctlcpdpb0PUP3YLU1NW5cvpYfnOuJRiWIXiuar9LNf6wCYDQraYE1TiXEbHcF/AVbJuaHgI0xz7rFmNQRCJ0ULoaXM9JlTzy1aJ5Vzkrxzde5S39GAPV6jI2Ee6Rdz6MoMGYyX6M2IhvPRDEr6VP/wLA/ktqQ3ZcN40s4RaDnqq98QhvDDB/6I2TjRVPOGzEfiAnMq55M79065+Szf3QLg/FSjbNg5ieEOA8nwePPI7FUJFaEQS/9GKquNUM+SYbDRT1AVNLcsYtmy1llubPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB7142.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzdaajFTNDdlTk4zNmNSNm1rak5Oci9YT3o5Q3ByZjg4elliQTI5TVlHWDF6?=
 =?utf-8?B?R0g5OGVOMEg1WXV1dDZsbk5sUUQrQzdDM1pua2I1SlRIaE8zS3lyN3dkakJq?=
 =?utf-8?B?TkdJKzNhbEc3UUFxOE0rSktaS0djUmxlK25oRVZ1a2ZNQjZ0eEo4UWptOTBu?=
 =?utf-8?B?OU1YTFlQa3R4dGxmT0xVVm40TXlxRGdocUQ4M3cwd3dYbllBcnhKZmM4VlM2?=
 =?utf-8?B?bDJpYlNZZ3Zmd2d6b1ZpNVVIMU1ISkNKdk0wTldkU1lxSkt0RE9lMEYyMHFM?=
 =?utf-8?B?RmIrR2xwWE9kWHJJYVNxYnlRYW9YSGd6anhKM3RHdGpDUTR3c2lxcVNnUlE5?=
 =?utf-8?B?a3hwanl6UExVdmk2ZXlhcDhvNHl6Z1dZZzhSZEhxQlNHaGtQOFZteTQrWStw?=
 =?utf-8?B?MnBHWUdReUdyN2dxdnZoSVcydmZzbzcweGJyZUlXSWNSeEZVNXRpWUZTMHg0?=
 =?utf-8?B?NXVBQlJvMWYyZkx6RG5jRTJTNnZ4d3VPd3VIdGhFZzVGNThTeFMvY1FwRGRY?=
 =?utf-8?B?RkRnWHMyR2ZoRzRYcmphL25KcGlDS20renRsRU9VVGNjd0pubmcya29XZWpS?=
 =?utf-8?B?ZStxck1KNHVIOWV3c2gycnl1akhWUE1qTkVpSnlVZmFHSWRNc0V6Tll5bXB4?=
 =?utf-8?B?cmxFSkowcU8zc3BwUnRwQ1BNOXJsRmtxcUhobnFQZHAzSnNKN2hoUVFSd3ZO?=
 =?utf-8?B?WXJRRTY2bTNpT1A2WWcwQkpIRytsUm16WGlQRVZ0MXFlV0NvTHJqSUJvdDE2?=
 =?utf-8?B?SU8vTzZWVGFJNUVSK003ZFpPRk9BK1BjdytoeGpwRFNubHlqdjhpNVBHcGJk?=
 =?utf-8?B?K0t4ckNZQlduN0s5VGVLNmhJTVRNaEY1YzUzWk82dUlzcEZIbGtVb1ppbFZv?=
 =?utf-8?B?MkcxSnpZT0J2U3p2OGthZnFNQkg5R3F6b2pIMGlEcTRYSXZMejlUdUxXbnVu?=
 =?utf-8?B?eHlaSzQ2MjBZY1BNdk9SdmxBcWsyNTA4d2RFK3pDWUlRYlhPYW5wTEFxVHN5?=
 =?utf-8?B?WVJ1MGsvZmpHSnlndDFyQnNXRVZuNk9uWTRsU1dMR0d3bjBPSUpCQ1ZrSmww?=
 =?utf-8?B?Sy94bnNNU2x1R2RCQUtwS2xWQnowQ2c4UFB6bWhRaCtoaDFtNkd1SlJiMCs2?=
 =?utf-8?B?bkE3eWp5ZzJEUlNiR21mWnJhSlU0TjJSSjFyWFVqQ2ZmK05nVDRvbUorQlNK?=
 =?utf-8?B?QUZyd3lrYkxETU92NVY4RGh4UU1lY3VHejdzL1lHVHRnK1NXWklpSFNJM1pK?=
 =?utf-8?B?WFkwVlVtU1YzYXhrSE1qdURYQnlHaFcwR2hqVDhoSXNGQ0E2cDVDV1ZTSnBl?=
 =?utf-8?B?d3daRk0zUk9SQUJQRUVsVHpKRHFIb2dTSnlyaWt2a2ZhU2w3dEgvQ0YzNXZS?=
 =?utf-8?B?cG4wK3loQnRtZzJ4K1UyMXdlYnM0S0RlZ0ROZDJucldkZnJkd3ZCRDJ0WTc2?=
 =?utf-8?B?eC9CbU9mbWkvNUZPYmgvZE9QUFZMMFB2U2tSS0pLZUNoaXh2WlpBMGJPS281?=
 =?utf-8?B?UUF1Y0UvL1lqUlhpL2Z1cDJRSENNQzJHZGRLb1NQWmxyTVlUd0J1S1RjM1h0?=
 =?utf-8?B?U25TYkVXL3RoYkFxVUZESVNhNFNtWTZnMnp1ZU14VitrMEdFaUtVUUpCVjQx?=
 =?utf-8?B?QUUvd2c1UmY4WDZBU0wyeXJORmZpL09QQk5FM2ZYc3U0Sko3TmhlVm0yRHoy?=
 =?utf-8?B?K1YzVUtIaGQrNWZGZ1hGMGl1aEo2aFREZ3Y2MjN6V0pIc08vOE5wMkhrZXUv?=
 =?utf-8?B?NXVMelk3Y1BUTUszaVc1Zk9nTlNqL2tvS1BYS21vajhDUVNOYUNzZE5lenI5?=
 =?utf-8?B?YUc1cUhPajVHTElyTkVvMXFvRER0SXV2aDVEWmxUNmp1YlhXdzJ6aUJqQjFM?=
 =?utf-8?B?aWNrd0NucDlBcjBCcUdLM2lpMWpNVytWZmtlU0doSFN1TXVHNW11NGo0ZEJU?=
 =?utf-8?B?Vmo3dFNLYVlaMlpCYVBCRnlFSUdqVmNuSnZhY2JoUWdvVE9BN3F1b05TNFNl?=
 =?utf-8?B?Nndsb1ZqMG5BU0pMNXlwWmUvNzRHNW9KQ3JUMnAvQVlRVzNIR3JrVGQ4QVpI?=
 =?utf-8?B?bHN1bEttdXZTbWpRa0tuRnA3QXBRU2paWWlua05VbCtPYkVJTC9ULzUvc0My?=
 =?utf-8?B?b2IvTDlMM0NKZVhnYncvTjE1aDZQeFVGZ2JxOWtoVzVOMWxMbng2dDgyUllk?=
 =?utf-8?Q?XTkiwqZssbeuU1nnfynVhKI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145bfea8-c8e6-49cb-d990-08dc54afdc8f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB7142.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 14:02:27.7282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGnJF4DfJL7YAYmd+2eN6PalxL+Ya6vXLI+xIvrsSwx3oxGhCPW8dWCksO3s8280dXFiwU6QHnb5xI2Rym45+gMQzJPn06rH8FoDYh1gzcPUKR8kMzabMLY9HR1axK19
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7106
Received-SPF: pass client-ip=2a01:111:f403:2417::700;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--------------cF4OedXxvwA4KzUguFT5AQgH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Salil,

On 12-03-2024 07:29, Salil Mehta wrote:
> Add common function to help unregister the GDB register space. This shall be
> done in context to the CPU unrealization.
>
> Signed-off-by: Salil Mehta<salil.mehta@huawei.com>
> Tested-by: Vishnu Pajjuri<vishnu@os.amperecomputing.com>
> Reviewed-by: Gavin Shan<gshan@redhat.com>
> Tested-by: Xianglai Li<lixianglai@loongson.cn>
> Tested-by: Miguel Luis<miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang<shahuang@redhat.com>
> ---
>   gdbstub/gdbstub.c      | 12 ++++++++++++
>   include/exec/gdbstub.h |  6 ++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 17efcae0d0..a8449dc309 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -615,6 +615,18 @@ void gdb_register_coprocessor(CPUState *cpu,
>       }
>   }
>   
> +void gdb_unregister_coprocessor_all(CPUState *cpu)
> +{
> +    /*
> +     * Safe to nuke everything. GDBRegisterState::xml is static const char so
> +     * it won't be freed
> +     */
> +    g_array_free(cpu->gdb_regs, true);
> +
> +    cpu->gdb_regs = NULL;
> +    cpu->gdb_num_g_regs = 0;
Likewise, you may need to set gdb_num_regs to zero as well.
> +}
> +
>   static void gdb_process_breakpoint_remove_all(GDBProcess *p)
>   {
>       CPUState *cpu = gdb_get_first_cpu_in_process(p);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index eb14b91139..249d4d4bc8 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -49,6 +49,12 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
>                                 const GDBFeature *feature, int g_pos);
>   
> +/**
> + * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
> + * @cpu - the CPU associated with registers
> + */
> +void gdb_unregister_coprocessor_all(CPUState *cpu);
> +
>   /**
>    * gdbserver_start: start the gdb server
>    * @port_or_device: connection spec for gdb

Otherwise, Looks good to me.  Feel free to add
Reviewed-by: "Vishnu Pajjuri" <vishnu@os.amperecomputing.com>

_Regards_,

-Vishnu

--------------cF4OedXxvwA4KzUguFT5AQgH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Salil,<br>
    </p>
    <div class="moz-cite-prefix">On 12-03-2024 07:29, Salil Mehta wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240312020000.12992-8-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">Add common function to help unregister the GDB register space. This shall be
done in context to the CPU unrealization.

Signed-off-by: Salil Mehta <a class="moz-txt-link-rfc2396E" href="mailto:salil.mehta@huawei.com">&lt;salil.mehta@huawei.com&gt;</a>
Tested-by: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a>
Reviewed-by: Gavin Shan <a class="moz-txt-link-rfc2396E" href="mailto:gshan@redhat.com">&lt;gshan@redhat.com&gt;</a>
Tested-by: Xianglai Li <a class="moz-txt-link-rfc2396E" href="mailto:lixianglai@loongson.cn">&lt;lixianglai@loongson.cn&gt;</a>
Tested-by: Miguel Luis <a class="moz-txt-link-rfc2396E" href="mailto:miguel.luis@oracle.com">&lt;miguel.luis@oracle.com&gt;</a>
Reviewed-by: Shaoqin Huang <a class="moz-txt-link-rfc2396E" href="mailto:shahuang@redhat.com">&lt;shahuang@redhat.com&gt;</a>
---
 gdbstub/gdbstub.c      | 12 ++++++++++++
 include/exec/gdbstub.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 17efcae0d0..a8449dc309 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -615,6 +615,18 @@ void gdb_register_coprocessor(CPUState *cpu,
     }
 }
 
+void gdb_unregister_coprocessor_all(CPUState *cpu)
+{
+    /*
+     * Safe to nuke everything. GDBRegisterState::xml is static const char so
+     * it won't be freed
+     */
+    g_array_free(cpu-&gt;gdb_regs, true);
+
+    cpu-&gt;gdb_regs = NULL;
+    cpu-&gt;gdb_num_g_regs = 0;</pre>
    </blockquote>
    Likewise, you may need to set gdb_num_regs to zero as well.<br>
    <blockquote type="cite" cite="mid:20240312020000.12992-8-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
+}
+
 static void gdb_process_breakpoint_remove_all(GDBProcess *p)
 {
     CPUState *cpu = gdb_get_first_cpu_in_process(p);
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index eb14b91139..249d4d4bc8 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -49,6 +49,12 @@ void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               const GDBFeature *feature, int g_pos);
 
+/**
+ * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
+ * @cpu - the CPU associated with registers
+ */
+void gdb_unregister_coprocessor_all(CPUState *cpu);
+
 /**
  * gdbserver_start: start the gdb server
  * @port_or_device: connection spec for gdb</pre>
    </blockquote>
    <p>Otherwise, Looks good to me.&nbsp; Feel free to add<br>
      Reviewed-by: &quot;Vishnu Pajjuri&quot;
      <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a><br>
    </p>
    <p><u>Regards</u>,</p>
    <p>-Vishnu<br>
    </p>
    <blockquote type="cite" cite="mid:20240312020000.12992-8-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------cF4OedXxvwA4KzUguFT5AQgH--

