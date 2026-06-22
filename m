Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E680CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVRA-0003Io-U0; Sun, 21 Jun 2026 23:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVR9-0003Ie-43
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:35:03 -0400
Received: from mail-eastus2azon11020087.outbound.protection.outlook.com
 ([52.101.56.87] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVR7-0001Rw-4w
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:35:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMBNRhFYjMaiFHNDs5QY8VGo6jUkKlsX84uUNjA4YwsFhxQmo6GhBKTXlljLJMjVW+Je1toXy8NhnsOeY9opl0ovlwh0ihkwosw7nzahhbfjB22zOuuLnRkcycUW7698ixqBA/poQrpiGhhCChXJdcFtRHFO0/rSmMj6jCuGWjmf5KgA5WFp0Z8i0Lpl2AJOPtz4G7NnDxIMb27BwU2hvChUWPw9Mq8fpasq6GsjP02QP5YDHWIfBoQUlqNWqJPzPcDBD3Gnt4p0IGKMpfx/2YGYy4Psw2NF6Di4myi49Kbif9Q4dK38nTcBfBxJmoBAP2GsveK+rpdCvucVX2MmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyiiodQekrFjqJ4sFJfLGZRXkmX2QyTE6Ao2oNGh7Wo=;
 b=iPKb1/WZ68Nm8IMuB4KLtepGunKdwka2bnETNnvr3XMt46r2ai2tq+u5y58SRxS4mdB5p1QEk51tEbWjzQsZ9tKV8yzvPjlDnmG0KjIsNvDudSOyNavYkmYbMNzHYdI0/bIzTyJCJiR4JFi/ksXk3lORTJXCgZrnlyy6ZAPZKQBCn58RcW34LF/hNTppfCoM22A50BNtVzQbQ+8ZsMINb90++0W5wDtGq7zp7VgugASeVN/O4iiOhYHMaHTGquT/h5GncgNktqE0p5GtuR1jQi/w11usBEBy9teF7zP8xlNpdNVSpvT64wem1CjijofuL0/pYETvqHv0MgkGjj9PuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyiiodQekrFjqJ4sFJfLGZRXkmX2QyTE6Ao2oNGh7Wo=;
 b=kSr1VQpmdxk5fSHT1jL1Ao3lIjESBrI4+Qo/ybeAY3FANHM4RNzbtd6TzpRv9Pms09oqGkC6O8Bflp3b7S3StZmYc8sZIxx53HbvcwUgGe25zQwAfWK9YFVOqvMQ7sumUTDtiQNtuJ0EgYv6v83LUEWM2VscAmpi8/vtAWy8IDZj3reCUGI7Mk26F9NqEIaNnH9xyChC8whDWZ8sKKsmrEbZuHpaoZZMUkGVdfjIqZKojlYtmOOwiRxIBc/MUzWKW4xHsHY64xoSfJbz4BJFimQQtQutfJJnirktUBuyyJad2DnL9MRmtFWQBPFpU7UNzDZc5Nlrp3a+UAVr/Cy7eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by BY3PR18MB4674.namprd18.prod.outlook.com (2603:10b6:a03:3c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 03:29:51 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 03:29:51 +0000
Message-ID: <2c2e561c-388f-4a57-9186-514f88a75303@axiado.com>
Date: Mon, 22 Jun 2026 11:29:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] hw/sd: Add Axiado SD host controller with eMMC PHY
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-5-kchiu@axiado.com>
 <90cf5582-4792-444c-be21-34b22675078d@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <90cf5582-4792-444c-be21-34b22675078d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0046.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::17) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|BY3PR18MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 034b1ba0-7b2f-4dbc-46e8-08ded00e84cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PiT9O7+q4EHBUY3WPvCeXYctuEvUBhwnu5X205969VNG9OXmBLX+5Eg+uadwBXUg0EAMYRWIoj/jqDUtrNwmmlUdyvltTlr8MnTg7kqlxkOqsZ970lHG0FAiFrnqJiLWz9pjGJnfDkg40yGIU8WsoaJLgI7Ac2Bcw/FMzTNMYlD2A1NZqAbiPzkt4l9pSBadMqSJedddjGgtDqVtI6gty68Q2sOzHrJlvMkCKEomKWMejl7DIyiVFhrJ+v1fzgppRpkQ7qa8c3xXqIJYBUnKGyXaWlJo3nCyqEMY9/wGwA6V5OzXIlNHa0DOFJvKLgcprqx7dexvXqHjQfDN9qQR9zSc8T6umgwrXjaatrJr4zZTiCzWcAHlyGBAZtnFK5rJSB16+hcBGXnqFaWloU1tY72+cxCjruvnqIP40mJvSKRyMBuqr42bz3jYo+wrs67FQAAr0ndybNzQDInwZlFS5UgjVRQbcGsq5GM80BbNTK7hIQ2zr1bZMGs3AS5m14knSc8OPIJHkJoLhlIRhqOjxF07NvQskcAMWY1rbw33mExTNkBYamhc42MSi95YcJ1zAn2AvSH3Cn9vHbqGotkw5sjMdKFjZqD1JCMemHxOPFPjvQ0QW9ctgkWFAFKm0JUPuUYjcst24ZmHWmXPqZUS7sQy8ZJC9pCPV+ZQi5Ewr+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZBMGVub2daWHp2cCtmdE05SVZmc3VmQTBwT21TMzZUMTNJT1pBYTJKcUFP?=
 =?utf-8?B?WG9ST09NSHBRY25lMEFPNjNLWHdMbkpSSXV5Y3JYYUQ2UlpoeHFNNktjbG40?=
 =?utf-8?B?QTVGRjZUcm9neXBaRnVLMmtwVWcyRURIVVJuS1RUWXZYYXNhV0dteE9wcVRr?=
 =?utf-8?B?Skw4V29mVS9Qd3hTUndtanVMUGpFZUh0TDhkc0x3WWlFMGFIM3Z4TlBXVjdM?=
 =?utf-8?B?cTZ4Q1RBcDVGTUdtS21NNnRleEdqOFhtcERuOG5PQWVLYjBkTXMzKzdlcVNi?=
 =?utf-8?B?U3hOT1pQbi9yUFpwVTN3MnRMQWJuN21PcEFLRzg5S1RSazJYRTV0ZDBXbVQ1?=
 =?utf-8?B?NWxMTTljcTdwNTA2U3Z0SDVBTTZKeXRlS28zdVZEN1RBaThIV0t1b05Ca2FE?=
 =?utf-8?B?TXkvSWpIaTlVa0ViVUkvZjN0WitTcUQ3SVl2WkRVZlNTcGJJUHM1TGhqYWVl?=
 =?utf-8?B?dUZmRXdZMnBsQXBDUVZTL281blhZeVNkcXMxdWptcHRLVTJRbVlReGErb0tC?=
 =?utf-8?B?K0M2NVA4QkttMGNWQ2ZobUN5b0RRaUNQTnVMRGlGcjB2MXVaSW5aTm11RFlo?=
 =?utf-8?B?d2loZmV5cExlYmFsVXhUL1E2NWdLc2FNWUJsYmNwRnVhZERCb2Q4Qm8waVlk?=
 =?utf-8?B?akxZSGZpV0FJM29YSHFCazFEV1Q1R3BUa0trNk5JYks4djBpblBocDVoUExx?=
 =?utf-8?B?VERRa1dtUHlzM3JWL3JMem1DMmQ3VDAzTk00ZUNIcTY2ZnlkS0xnS2FKOHZk?=
 =?utf-8?B?RUt0TTk4VCtVUGpqdnlWUEJrem4xQlBSeW4yaUlIV05WdFhMNUNsemZ4MlRO?=
 =?utf-8?B?OTVKZCswM1ZvL2FvTHcvOU5jdnV0bzlkVC9jRm01SWozNUt5RHBZSUMvTXM0?=
 =?utf-8?B?NDllRzdaMW1HY2R2cndCaDJZVG5sSUhOb1M0RFFVVXpEK25KVHcxa1grWkxo?=
 =?utf-8?B?cGwvanlPUTN5OGxreWMxRHhhTWFyYmVBT3BqbzR6VVVYd1VoaGlzcUUvU0VM?=
 =?utf-8?B?VWJrOVljRG9uUE5NSVVaRkcxcnFEQjJRZS9rTWJiVzZ1MzJZMVlsb1EyWTdX?=
 =?utf-8?B?UFhVUGZUcWd0c2JMU2xTcFhicnhEblRSZFIwako5TVBERDQ0Y3B2STd3OEFs?=
 =?utf-8?B?Qlh5UEQwbkNpRytqcThaQXJCbitWcmllOUVZMUpIdUxrLzRnZGhqWFptUktw?=
 =?utf-8?B?L2grc1lLSGd5RGpwQ3VxUFM3d3VISi9RS0NneW4yUXJGOVlOSi9JSUtMN3ZX?=
 =?utf-8?B?VmlYNm5oRmhaVk54VDkrK1VkZ2pmSHhvd0xyU3U3UVRKQWpNNDdIYzVYeEJT?=
 =?utf-8?B?c0NWM0V2YzBpWGZ6YU1JQUVDVDhtUk9QbXdadHBJR3pLa2pMSm9aNHJNNXp4?=
 =?utf-8?B?SXVlMDF2dDVWZWVvRGRGYnJERW92QnZ1TklUR1pwakEwN01vZ2haeXZ4UGpw?=
 =?utf-8?B?S05rU3NVcmdjd3d1OXFEdG04dVJCbVhTRUs4WStEdXloaUFsdEdkNENpbjlF?=
 =?utf-8?B?RDVrdUVqMmRQanR6UXpxYWdWNXczZWFNdklram96NGc5UVdPT3Mxb2E2Skpp?=
 =?utf-8?B?QStMeFMzZFB5cEtDK1luRWtwOVB4YUE1UllhR0E2Q1FaQ1JGV05PQkc0SENI?=
 =?utf-8?B?TDZoaEVMR3JvZDNHV0Z0VVNjL2tBS1lTaHloQ0tBTWc2UTlHNmpCaFIvcVRM?=
 =?utf-8?B?VXhCSmFyK3BuTklFTkFBSktmd3JCTzg5QXcvckdQa09XVE83QTJROVJ6NXYx?=
 =?utf-8?B?aWlKak1PSmJ6WHp5SG4vZ0Rad2h4dzdtdGlBRDU5RDY2VWwrdHh4NFlZLzJj?=
 =?utf-8?B?cThsbmdxeUxSc1BMeEpQN2V1OVk1a2l1WjhKSFhJNVpGRitPakJIL2EvR1o0?=
 =?utf-8?B?a2txVTArVTdBWlQ2cmdNQS92TTNnUnRxQ2tsdnNsV3BjdnJIbGVRaGZEMURJ?=
 =?utf-8?B?OGpUeWVFdUE3bUVYRnFtSDV2Rk9MemVMNUZFdHkzbnBzM1hZNWZEM0tvaVI5?=
 =?utf-8?B?WnIrRzlOVTBoWjBoSnVDZWdVSWlWMlVwS0NzaXMxRjcyWlptVGNHNndybUpH?=
 =?utf-8?B?eVNiWlRDL3NCdUJPbmdYN2tkRVFCV3NWTHpNSlNEMTVUOVBOK2FEK2V3NlpQ?=
 =?utf-8?B?NE45R0FHVHMvZU5TRDdjOUVJZnlNbkIrOHdEZnBVZ3BMS1RaTlhqeUp1d1c0?=
 =?utf-8?B?bjI1bURac3R3dVpsZXZ4MWMwcVgwTktpbk4vNTA4VmxSbWRrUWsxa3FoTGVw?=
 =?utf-8?B?ejhQQlNVY2lUS0VtM29SZGNKTlpoU1VPRVNPWGFHMzRmVStVN2FLTExzcnV5?=
 =?utf-8?B?UE0xQUo2NWhRbTVqWG9NRzFGZE80UEJ0VHZNaUczajVRYWU3OGgxUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034b1ba0-7b2f-4dbc-46e8-08ded00e84cb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 03:29:51.1894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tn7EMFE5cB1EbnzIsUihdpwzO6ct6UMcwBbupriuFLqfz0BdXn3S9tN0zUmSJ/9rmeoIu0ZvhKFSop/A6FyFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4674
Received-SPF: pass client-ip=52.101.56.87; envelope-from=kchiu@axiado.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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


Philippe Mathieu-Daudé 於 2026/6/18 下午 10:55 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> Hi Kuan-Jui,
>
> On 18/6/26 12:12, Kuan-Jui Chiu wrote:
>> This patch add a new model for Axiado SD host controller which is 
>> compatible
>> with SDHCI 3.0 spec
>>
>> This device model also includes a eMMC PHY which helps to control 
>> SD/eMMC
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   MAINTAINERS                  |   2 +
>>   hw/sd/Kconfig                |   4 ++
>>   hw/sd/axiado_sdhci.c         | 114 +++++++++++++++++++++++++++++++++++
>>   hw/sd/meson.build            |   1 +
>>   include/hw/sd/axiado_sdhci.h |  21 +++++++
>>   5 files changed, 142 insertions(+)
>>   create mode 100644 hw/sd/axiado_sdhci.c
>>   create mode 100644 include/hw/sd/axiado_sdhci.h
>
>
>> diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
>> new file mode 100644
>> index 00000000000..e1a76b80a67
>> --- /dev/null
>> +++ b/hw/sd/axiado_sdhci.c
>> @@ -0,0 +1,114 @@
>> +/*
>> + * Axiado SD Host Controller
>
> "Axiado SD Host Controller with embedded PHY"
>
Sure

>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sd/axiado_sdhci.h"
>> +#include "sdhci-internal.h"
>> +#include "qapi/error.h"
>> +#include "hw/core/qdev-properties.h"
>> +
>> +#define EMMC_PHY_ID     0x00
>> +#define EMMC_PHY_STATUS 0x50
>> +
>> +#define DLL_RDY  (1u << 0)
>> +#define CAL_DONE (1u << 6)
>> +
>> +static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned 
>> size)
>> +{
>> +    uint32_t val = 0x00;
>> +
>> +    switch (offset) {
>> +    case EMMC_PHY_ID:
>> +        val = 0x3dff6870;
>> +        break;
>> +    case EMMC_PHY_STATUS:
>> +        val = DLL_RDY | CAL_DONE;
>
> Out of curiosity, how long a PHY generally takes to be ready?
> (We had issues with firmware when not modelling a micro delay
> to allow PLLs to stabilize).
>
I did not have experience on how long it should be ready

The driver in u-boot/kernel would check the value of these registers in 
probe function
This device model just simply returns the value for verification.

>> +        break;
>> +    default:
>
> I suppose there are other registers, could we qemu_log_mask(LOG_UNIMP)?

Sure

>
>> +        break;
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
>> +                           unsigned size)
>> +{
>
> Is it legal to write? Can we log LOG_UNIMP / LOG_GUEST_ERROR?
The memory region should be able to write but I did not implement it
We can log LOG_UNIMP here
>
>> +}
>> +
>> +static const MemoryRegionOps emmc_phy_ops = {
>> +    .read = emmc_phy_read,
>> +    .write = emmc_phy_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 2,
>
> Your current implementation is min_access_size = 4 (you are not
> handling EMMC_PHY_ID+2). Using min_access_size = 4 is simpler,
> the core memory layer will deal with the 16-bit access for you.
Sure
>
>> +        .max_access_size = 4,
>> +    },
>> +    .valid = {
>> +        .min_access_size = 2,
>> +        .max_access_size = 4,
>> +    }
>> +};
>> +
>> +static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
>> +{
>> +    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    SysBusDevice *sdhci_sbd;
>> +
>> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
>> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
>> +
>> +    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
>> +    if (!sysbus_realize(sdhci_sbd, errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
>> +
>> +    /* Propagate IRQ from SDHCI and SD bus  */
>> +    sysbus_pass_irq(sbd, sdhci_sbd);
>> +    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
>
> @sd_bus is not used AFAICT.
This sd_bus is used in of ax3000-soc
>
>> +
>> +    /* Initialize eMMC PHY MMIO */
>> +    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
>> +                          "axiado.emmc-phy", 0x1000);
>> +
>> +    sysbus_init_mmio(sbd, &s->emmc_phy);
>> +}
>> +
>> +static void axiado_sdhci_instance_init(Object *obj)
>> +{
>> +    AxiadoSDHCIState *s = AXIADO_SDHCI(obj);
>> +
>> +    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
>> +                            TYPE_SYSBUS_SDHCI);
>> +}
>> +
>> +static void axiado_sdhci_class_init(ObjectClass *klass, const void 
>> *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = axiado_sdhci_realize;
>> +    dc->desc = "Axiado SD Host Controller with eMMC PHY";
>
> Shouldn't we have a reset handler to propagate to the SDHC block?

This device model is using the default functions that general SDHC 
provided then add an eMMC PHY only

I did not implement any specific function for now.

>
>> +}
>> +
>> +static const TypeInfo axiado_sdhci_info = {
>> +    .name          = TYPE_AXIADO_SDHCI,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(AxiadoSDHCIState),
>> +    .instance_init = axiado_sdhci_instance_init,
>> +    .class_init    = axiado_sdhci_class_init,
>> +};
>> +
>> +static void axiado_sdhci_register_types(void)
>> +{
>> +    type_register_static(&axiado_sdhci_info);
>
> DEFINE_TYPES() is preferred for style but not required.
Sure
>
>> +}
>> +
>> +type_init(axiado_sdhci_register_types);
>
> Regards,
>
> Phil.

