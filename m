Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452ADFE51F3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDFE-0003vC-7A; Fri, 24 Apr 2026 05:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wGDFC-0003uq-Qa
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:54:42 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wGDF9-0001xJ-M3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:54:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIo8CmPPHWPmgvENPUJdGcGGLRkHG9zsdTBQs/qX9KMKOkO5vmMQZ5W0q5XfvFYJhP0Y0M6yQtela5iWAz5RtslDm9TrdA54XJX6pPVZzJHQ3/9fpFfmHMy21EPYyp9yNSOrmKk/pFrjAGglRN66Nf62wSvxqFtINty8P6kPx6j7rccytRBr6VBnM/bmHqKUOQYDBoxCqS3ndr+8JHxxaPbWLxelpug8v0vwqODVlyOfkaRzQCH2FuUZ9G86rw97mMUaFqifn4N++bf51nvppLlzhhfynz3XS4XOOv4tZHUNtB6Bhx3mN5d/1ZUJ/KNT8VakL/NB16MJ5apP1J1wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+OBd8tI10yRoppSdvaXwZkHdHbBKVeCLzfN4huZLDM=;
 b=LLvC5E8plBzA+qbk+b8KdhWK6RKDNo+USR3IHOkrGCynf0Kj6D4KVdOJZPihiweYlreUhHeX/G7gWirZqtYBmPfRP/nOxeYjbHfghC+gXQbkI1xOEC54yCG66b7xqUSm/PcsVwMcpCWz+pWb6ufsnN2xA9FmSMLsB+WP0PDULxORoL2kcr1csNb4qfLaGtZfCQefQy/SOC0btWJb0TJ0vdNQYyoqfzuaETruDjk5bpp5KhAswdG7JsTp2WXkirq/9m8GCJ0cjA41Ma4dkkcSsUeiS3viSGUnldWdx8kGT0BEVFd3sfRoyX0xmd3o3qLCDexYrb3S9Rf04vklFNro0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+OBd8tI10yRoppSdvaXwZkHdHbBKVeCLzfN4huZLDM=;
 b=sNzerq46a8Kw90lHOGnx/DAV8ZC4/NR5hn1PM8iuJdCTj3cu4GmgXzRkgpfe+h6e1hkVYoGZMwR48el1evK/lhuJRQCP+q/28AnMjTaTfb8+6CjanMryR7Wk/wW3INnR8UUJwLezWRebb4kLJD9Nb2PQIGIGU4az+WCaTUYhioVNqNjP0uJuOAp1uSflJKRr0neVAWYIZYEDNsOG0QDICoS4REs5iM72AdtGnwmbY74DIF9QgyeO2jvxmvX2BgWZ32N988QzE7GWWfEDtNzGfLedjXYcCupaYyJHN9IL20y3znuOJFgfDl4jmAU9HRkg/Ol5M805TZM2dORHWYpGBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by PH0PR18MB4039.namprd18.prod.outlook.com (2603:10b6:510:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:54:36 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:54:36 +0000
Message-ID: <3f6ec23f-47ab-439a-9a32-d8b15d1afe58@axiado.com>
Date: Fri, 24 Apr 2026 17:54:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] hw/arm: Add Axiado SoC AX3000
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260306121511.1781020-1-kchiu@axiado.com>
 <20260306121511.1781020-2-kchiu@axiado.com>
 <CAFEAcA_LCnsubbLH6mQDXHJF4e+ejVzFpy55=7W1jAh_gEXL2g@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA_LCnsubbLH6mQDXHJF4e+ejVzFpy55=7W1jAh_gEXL2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::13) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|PH0PR18MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: b0230c37-4bd8-416b-8d5a-08dea1e77e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: nMzis19YHFIO73hIeuIpEf4tm0XbOR8ftDavIxpxl8056h2TWtMRlbYv5en9DyThVU1IqR0J4HmQT/N8E8f+IsN4w356X6B1fsFHtWFtpUEPETIDuP+qg9i1f/27ou0O17W5pDKqu6sP7qh7f1FQfQvrTEXaxZw2T9QLpVMMvb5RwkAhvikunSWtCBZNKXwrPRray3Opwng/hll2bDtsmnFTDn4xUcOiPju7x2SEERFpIJ2mJZKKpUWKqWBJfepr43NbAFZohqA9wdUt9knVaHkz4PRIpjh0L3UrEU4kzNSUCYIRObvT+xNzMU22woDRi7xilD0c384X26M3jSghAGRKKoobqLeh/O4ZLnv9nThlfQzO+Em87gLmEgwoI3oqEwx/bolDoBc9MezLIuvOqEIKhfpa4cxhgHXUSEjpJ4V4GDh3MJWz4sN8qPQQcp/1TxwKPwanzCA17EIgLr0W6oMC/0LuimBcv22OYgipN6GJUBsPZgRX4xqL8/cIdqYKNkqZeztZL6HnxXeLl9pS1Xnveu3IsYTDMXFkEYVrdAKqPfIqo/zU173DrYyOJgS0nPUddvlQCQH9sh9NMlcccZ05TZxBMUvMa4llRfbRWr7EPYX9+WxpxYvUOXB+h44WChiSCqBmVoRnEalnjnQtECofIofCTYyO4f/NMrurv3sRHvE66jQ7EXd59NOIkAYmfzvSzlWkWBmJ4UD6ti1RzWXpD0eTkB0Ah+9DBQIKv7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUVxQ0QxLzB6RW52SXc0WkRKc1h6dGRQSHhNSDl6cDZiMFdkbDkwY2FsQXdE?=
 =?utf-8?B?Yyt4VWtaeVhrbFpTc1JqWWRzT1NEbDcvZ0tUek1TZ0d6WS9pUzBaY2JCZmVl?=
 =?utf-8?B?QWxONFpYZ2xFWFhaNU5SWStXZC84QXFOREZGbjF2MmtKMGI1eUdyQmk2eHZo?=
 =?utf-8?B?MGlKT2o3UDIwNVY2NkZoZGU4RTBGR005bXZPNDhSNWc1Ky8vSDlxc2wxUWds?=
 =?utf-8?B?dUJqNGRrNmRteU1VeEcrdG1aV00wTFhJSWlaaklwbzNXMWpuMzFKRlg4QWEv?=
 =?utf-8?B?YXJYUkVDZFhZMjU2dWhOZHd6WnB4QkFKeHJVWHlHK1Y0TnRGZGNqYmErL3Ey?=
 =?utf-8?B?UWJjOGdnamlQNmpGN0FZYTNlT0hOSXJXWldldEd4K0pKK3R4VTM5TGM0ZStF?=
 =?utf-8?B?T2pRSjdwbXV4bzgxaGV0OFErZnhSTEM0QTlCT3MvQ2xCT2dkd1dnU3RDT09V?=
 =?utf-8?B?SldlRk82MHVxVGFQUGRlaUxQK0NPbWNsWjZDNlBRcnBVeUZxRmZvOGo3bGNG?=
 =?utf-8?B?S21RQzR4ZEsyKzV2dU1qdG5KMk9GaHZHZytwTmp3c2tKTWdRZXZRcWJmbWls?=
 =?utf-8?B?bXdOczRKdHdvZXlRa1ZXQnl1NUptcytwY1k2Wk1JWmRIdHFhMUtFOFlUeHBY?=
 =?utf-8?B?ZEVwbzVvZHlZRHdVU3RnYkhZZWhRSkFsU2xXK0J0TENQb1FxQ3VNaVcyVDRn?=
 =?utf-8?B?aVEzd05kZVBHTFJUcXBtYVhSWEZWTDYwbDY5Y0JjN3NGNGU1UEFYaVZDNEZZ?=
 =?utf-8?B?bzBVVG5MaU5aelgrN2tEOE1lZkUwVzJGZCtWbTFlV3RjNzhwOVVSQmZVWEh3?=
 =?utf-8?B?dGdwSkhQZitkSGhRRUZIVUQxaEtDSm40V3Uzd0hvclBKV3plSHo1cGsvN0xG?=
 =?utf-8?B?TGRoazlFR1pIbThqUTFxQ3I2OXJ1Y1hvVnU2cFlOdHoyUVN4ZlZyRkJXbVdj?=
 =?utf-8?B?NE9pK201RHpWSUdsSlU3dm13UDE0RXJGbU1pRzFWRW5sbkxNaTVqUmVFQ1Nx?=
 =?utf-8?B?U3drN3lZTXNISlkrUytldjJXaTM5cGxwaDFlWjFGNEpEckFhS1UvTURRc3Vn?=
 =?utf-8?B?WE9OZ2pJdmRxYkNaaFRSVlB5VlB4M0R4REJqNEdUa0w5Q2hlZFR2TGtsT2gz?=
 =?utf-8?B?WWdseG9CaFlnYUN2cVViTWVjWVR1aUJOUUZrbWhvN2hSOE9GN3owM2YyR2Zl?=
 =?utf-8?B?b2VBZ2E4WVU5S2s3czNRVWczaUROYkpDaXJGdVZVSllWcWwram1mY3F1SUJB?=
 =?utf-8?B?bm9IZ0wyYXY2bksreUtCYWJXZDI0emM2aWcrMFp4TlZIOHFrY3FWOUx6MkZI?=
 =?utf-8?B?WmRPSTJhMW1PWnE2OElmaFlTd0xNc0EvbkEvN0owNEswczBrRjluL3NXdEYx?=
 =?utf-8?B?TTBsUUFCNWFJSDVMZWRaSjIzSWxuMVdPVktyM0ovbXQ3elNOTWJwK3VTSUov?=
 =?utf-8?B?ZTBva1NvMXNiTzl1eHRhRkNXNllLNDU4ekVUR0NyeFBuTGxBMWFpSkt3TFRQ?=
 =?utf-8?B?YWtTWlV5RGh0Y1BBVlJFSjRLcDI5RkdtZER4MEZaRElvVXpXQXdOUERCL3hx?=
 =?utf-8?B?RmhhUUF2QkFncndRTkhzVkVsZmNZQmpCT29GNk1lSGdDS2Yxb0xMaXVtdzlw?=
 =?utf-8?B?ekFnaTRseDA5TThPWUZQSEpwdGZaTEozT3JEekZzMldXU29KSGJCL1lJVDVj?=
 =?utf-8?B?bG5rTVl3RmpoaUhUZitNYk5scmo4bXJIZjNQRmw1dnBvaklpMVlNSkFWaWVs?=
 =?utf-8?B?Znh4UWh0Mjd6RkpwOTY5ZjdSM3dpZ3pXeTJLb05XcXhpR1JWK0thNmFNNGhx?=
 =?utf-8?B?K3BqRkxKbUpicjJXYlhlWGxYblVibXQrd29kS0FuUzBpOE5pUDhWZFNTaTFY?=
 =?utf-8?B?dTlQUnZsZ29ERmQxQmtzdnBtR3dBU0N3eS9McHFhMHFyeDI5U2J6QUZISWZm?=
 =?utf-8?B?eHpFQnZvT1lyZVBTcUFnODBhVXgyV1R5Ukx0MEIzS01CSjVuWXhZOXlPdnlQ?=
 =?utf-8?B?ODd3eTRNb0MrcWhNMGlLYlVTWlZQZHhCYnd1ejZTZlkweTZzN2dyM1ZKYSs3?=
 =?utf-8?B?bkVYVVFFc0hUd0dpano0T0d3V3BCQTl2endHLzdhZGR4dEdvdnZIMEx0RjFk?=
 =?utf-8?B?ay8vTWYvNFFraXBJYnBNREpweFlDd0Z0ZU9IR09RQ1daSkZqc1JTRUJHL1hM?=
 =?utf-8?B?NjBQQkhZalk4QWswNmUwZElFbUI5V1VDVllJODdVVDJzS2pGQ1prM0dxWEZs?=
 =?utf-8?B?bWtjeUNpQjc2RThEQUNHNjk0aE9IaktpYVdML3B4cjBCbldTMjVja0ttUGxO?=
 =?utf-8?B?NUtXS2E1MHRNdlo0SlA3NFJOTERmc3YvdU5oNGc5Nk9ZQkJnSW5OQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0230c37-4bd8-416b-8d5a-08dea1e77e1f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:54:35.9787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kCCXxOIM8HPURvSsPTguN/1Q+gbN8h6arkCvDrNioH3B+yje3ejQko24irsQ+zrcDul1NtqAj0brkqavuf0KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4039
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=kchiu@axiado.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Hi Peter

Please check the my replies below

I will send v2 patchset soon

If you still have concerns, please let me know

B.R.
Howard

Peter Maydell 於 2026/4/9 下午 11:17 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Fri, 6 Mar 2026 at 12:21, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> This patch adds new model for Axiado SoC AX3000 which supports
>>      4 Cortex-A53 ARM64 CPUs
>>      Arm Generic Interrupt Controller v3
>>      4 Cadence UARTs
>>      1 SDHCI controller with PHY
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> Hi; thanks for this patch; my review comments are below. I have
> some comments about structure but nothing too major I think.
>
>> ---
>>   hw/arm/Kconfig              |   8 +
>>   hw/arm/axiado-soc.c         | 287 ++++++++++++++++++++++++++++++++++++
>>   hw/arm/meson.build          |   2 +
>>   include/hw/arm/axiado-soc.h | 152 +++++++++++++++++++
>>   4 files changed, 449 insertions(+)
>>   create mode 100644 hw/arm/axiado-soc.c
>>   create mode 100644 include/hw/arm/axiado-soc.h
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index c66c452737..a91b81b298 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -699,3 +699,11 @@ config ARMSSE
>>       select UNIMP
>>       select SSE_COUNTER
>>       select SSE_TIMER
>> +
>> +config AXIADO_SOC
>> +    bool
>> +    default y
>> +    depends on ARM
>> +    select ARM_GIC
>> +    select CADENCE # UART
>> +    select SDHCI
>> diff --git a/hw/arm/axiado-soc.c b/hw/arm/axiado-soc.c
>> new file mode 100644
>> index 0000000000..e23410c147
>> --- /dev/null
>> +++ b/hw/arm/axiado-soc.c
>> @@ -0,0 +1,287 @@
>> +/*
>> + * Axiado SoC AX3000
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 or
>> + * (at your option) version 3 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> If you run scripts/checkpatch.pl on your patches, it should
> warn you that we prefer to use SPDX identifiers rather than
> the traditional GPL license boilerplate.
No problem I will fix them.
>
>> + */
> Is there a data sheet for this SoC? The top level comment is
> a good place to put the URL for it.
>
> Without a datasheet, it's trickier to review.

I will attach a URL to our website for reference
If you still need more information about our SoC please let me know.

>
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/address-spaces.h"
>> +#include "hw/arm/bsa.h"
>> +#include "hw/arm/axiado-soc.h"
>> +#include "system/system.h"
>> +#include "qobject/qlist.h"
>> +#include "qom/object.h"
>> +
>> +static uint64_t sdhci_phy_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    uint32_t val = 0x00;
>> +
>> +    switch (offset) {
>> +    case REG_ID:
>> +        val = 0x3dff6870;
>> +        break;
>> +    case REG_STATUS:
>> +        // Make DLL_RDY | CAL_DONE
>> +        val =  (1u << 0) | (1u << 6);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void sdhci_phy_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>> +{
>> +    /* TBD */
>> +}
>> +
>> +static const MemoryRegionOps sdhci_phy_ops = {
>> +    .read = sdhci_phy_read,
>> +    .write = sdhci_phy_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +};
> Please put models of sub-devices of the SoC into their own
> source files in the appropriate subdirectory of the hw/ directory.
No problem, I will create a axiado_sdhci device in hw/sd , which 
includes this PHY device for our eMMC
>> +
>> +static uint64_t timer_ctrl_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    return 0x0;
>> +}
>> +
>> +static void timer_ctrl_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>> +{
>> +    /* TBD */
>> +}
>> +
>> +static const MemoryRegionOps timer_ctrl_ops = {
>> +    .read = timer_ctrl_read,
>> +    .write = timer_ctrl_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +};
> If you can get by with absolutely no implementation of a device,
> consider using TYPE_UNIMPLEMENTED_DEVICE (from hw/misc/unimp.c),
> which will give you a "reads as zero, writes ignored" block which
> also logs when the guest touches it. (You can either create the
> device directly, or use the create_unimplemented_device() helper
> function.)
No problem, I will use create_unimplemented_device() for this dummy device
>> +
>> +static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    switch (offset) {
>> +    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
>> +        return 0x20891b;
>> +    case CLKRST_CPU_PLL_STS_OFFSET:
>> +        return 0x01;
>> +    default:
>> +        return 0x00;
>> +    }
>> +}
>> +
>> +static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>> +{
>> +    /* TBD */
>> +}
>> +
>> +static const MemoryRegionOps pll_ops = {
>> +    .read = pll_read,
>> +    .write = pll_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +};
>> +
>> +static void ax3000_init(Object *obj)
>> +{
>> +    AxiadoSoCState *s = AXIADO_SOC(obj);
>> +    AxiadoSoCClass *sc = AXIADO_SOC_GET_CLASS(s);
>> +    int i;
>> +
>> +    for (i = 0; i < sc->num_cpus; i++) {
>> +        g_autofree char *name = g_strdup_printf("cpu%d", i);
>> +        object_initialize_child(obj, name, &s->cpu[i], ARM_CPU_TYPE_NAME("cortex-a53"));
>> +    }
>> +
>> +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>> +
>> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
>> +        g_autofree char *name = g_strdup_printf("uart%d", i);
>> +        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
>> +    }
>> +
>> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_SYSBUS_SDHCI);
>> +}
>> +
>> +static void ax3000_realize(DeviceState *dev, Error **errp)
>> +{
>> +    AxiadoSoCState *s = AXIADO_SOC(dev);
>> +    AxiadoSoCClass *sc = AXIADO_SOC_GET_CLASS(s);
>> +    SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
>> +    DeviceState *gicdev = DEVICE(&s->gic);
>> +    QList *redist_region_count;
>> +    int i;
>> +
>> +    /* CPUs */
>> +    for (i = 0; i < sc->num_cpus; i++) {
>> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>> +                                &error_abort);
>> +
>> +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
>> +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
>> +                                     false, &error_abort);
> Does your SoC really not implement EL3 ?

I was facing a problem that QEMU crashed in our u-boot because it will 
execute a assembly code while running in EL3

So I disabled the EL3 in QEMU to avoid this problem

I would re-enable it once we remove this assembly code from our u-boot

>> +        }
>> +
>> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>> +    /* GIC */
>> +    qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
>> +    qdev_prop_set_uint32(gicdev, "num-irq",
>> +                         AX3000_NUM_IRQS + GIC_INTERNAL);
>> +
>> +    redist_region_count = qlist_new();
>> +    qlist_append_int(redist_region_count, sc->num_cpus);
>> +    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
>> +
>> +    if (!sysbus_realize(gicsbd, errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_mmio_map(gicsbd, 0, AX3000_GIC_DIST_BASE);
>> +    sysbus_mmio_map(gicsbd, 1, AX3000_GIC_REDIST_BASE);
>> +
>> +    /*
>> +     * Wire the outputs from each CPU's generic timer and the GICv3
>> +     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
>> +     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
>> +     */
>> +    for (i = 0; i < sc->num_cpus; i++) {
>> +        DeviceState *cpudev = DEVICE(&s->cpu[i]);
>> +        int intidbase = AX3000_NUM_IRQS + i * GIC_INTERNAL;
>> +        qemu_irq irq;
>> +
>> +        /*
>> +         * Mapping from the output timer irq lines from the CPU to the
>> +         * GIC PPI inputs.
>> +         */
>> +        static const int timer_irqs[] = {
>> +            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
>> +            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
>> +            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
>> +            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
>> +        };
>> +
>> +        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
>> +            irq = qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]);
>> +            qdev_connect_gpio_out(cpudev, j, irq);
>> +        }
>> +
>> +        irq = qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_IRQ);
>> +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
>> +                                        0, irq);
>> +
>> +        sysbus_connect_irq(gicsbd, i,
>> +                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>> +        sysbus_connect_irq(gicsbd, i + sc->num_cpus,
>> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>> +        sysbus_connect_irq(gicsbd, i + 2 * sc->num_cpus,
>> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>> +        sysbus_connect_irq(gicsbd, i + 3 * sc->num_cpus,
>> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>> +    }
>> +
>> +    /* DRAM */
>> +    for (i = 0; i < AX3000_NUM_BANKS; i++) {
>> +        struct {
>> +            hwaddr addr;
>> +            size_t size;
>> +            const char *name;
>> +        } dram_table[] = {
>> +            { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE, "dram0" },
>> +            { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE, "dram1" }
>> +        };
>> +
>> +        memory_region_init_ram(&s->dram[i], OBJECT(s), dram_table[i].name,
>> +                               dram_table[i].size, &error_fatal);
>> +        memory_region_add_subregion(get_system_memory(), dram_table[i].addr,
>> +                                    &s->dram[i]);
>> +    }
>> +
>> +    /* UARTs */
>> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
>> +        struct {
>> +            hwaddr addr;
>> +            unsigned int irq;
>> +        } serial_table[] = {
>> +            { AX3000_UART0_BASE, AX3000_UART0_IRQ },
>> +            { AX3000_UART1_BASE, AX3000_UART1_IRQ },
>> +            { AX3000_UART2_BASE, AX3000_UART2_IRQ },
>> +            { AX3000_UART3_BASE, AX3000_UART3_IRQ }
>> +        };
>> +
>> +        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>> +            return;
>> +        }
>> +
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
>> +                           qdev_get_gpio_in(gicdev, serial_table[i].irq));
>> +    }
>> +
>> +    /* Timer control*/
>> +    memory_region_init_io(&s->timer_ctrl, OBJECT(s), &timer_ctrl_ops, s,
>> +                          "timer_ctrl", 32);
>> +    memory_region_add_subregion(get_system_memory(), AX3000_TIMER_CTRL,
>> +                                &s->timer_ctrl);
>> +
>> +    /* PLL control */
>> +    memory_region_init_io(&s->pll_ctrl, OBJECT(s), &pll_ops, s, "pll_ctrl",
>> +                          32);
>> +    memory_region_add_subregion(get_system_memory(), AX3000_PLL_BASE,
>> +                                &s->pll_ctrl);
>> +
>> +    /* SDHCI */
>> +    qdev_prop_set_uint64(DEVICE(&s->sdhci0), "capareg", 0x216737eed0b0);
>> +    qdev_prop_set_uint64(DEVICE(&s->sdhci0), "sd-spec-version", 3);
>> +
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci0), errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci0), 0, AX3000_SDHCI0_BASE);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci0), 0,
>> +                       qdev_get_gpio_in(gicdev, AX3000_SDHCI0_IRQ));
>> +
>> +    memory_region_init_io(&s->sdhci_phy, OBJECT(s), &sdhci_phy_ops, s,
>> +                           "sdhci_phy", AX3000_SDHCI0_PHY_SIZE);
>> +    memory_region_add_subregion(get_system_memory(), AX3000_SDHCI0_PHY_BASE,
>> +                                &s->sdhci_phy);
>> +}
>> +
>> +static void ax3000_class_init(ObjectClass *oc, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +    AxiadoSoCClass *sc = AXIADO_SOC_CLASS(oc);
>> +
>> +    dc->desc = "Axiado SoC AX3000";
>> +    dc->realize = ax3000_realize;
>> +    sc->num_cpus = AX3000_NUM_CPUS;
>> +}
>> +
>> +static const TypeInfo axiado_soc_types[] = {
>> +    {
>> +        .name           = TYPE_AXIADO_SOC,
>> +        .parent         = TYPE_SYS_BUS_DEVICE,
>> +        .instance_size  = sizeof(AxiadoSoCState),
>> +        .instance_init  = ax3000_init,
>> +        .class_init     = ax3000_class_init,
>> +    }
>> +};
>> +
>> +DEFINE_TYPES(axiado_soc_types)
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index 47cdc51d13..c3c96c0a70 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -105,6 +105,8 @@ arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
>>   arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>>   arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>>   arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>> +arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
>> +  'axiado-soc.c'))
>>
>>   arm_common_ss.add(files('boot.c'))
>>
>> diff --git a/include/hw/arm/axiado-soc.h b/include/hw/arm/axiado-soc.h
>> new file mode 100644
>> index 0000000000..2483bdd8c2
>> --- /dev/null
>> +++ b/include/hw/arm/axiado-soc.h
>> @@ -0,0 +1,152 @@
>> +/*
>> + * Axiado SoC AX3000
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 or
>> + * (at your option) version 3 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef AXIADO_AX3000_H
>> +#define AXIADO_AX3000_H
>> +
>> +#include "cpu.h"
>> +#include "hw/intc/arm_gicv3_common.h"
>> +#include "hw/char/cadence_uart.h"
>> +#include "hw/sd/sdhci.h"
>> +#include "hw/core/sysbus.h"
>> +#include "qemu/units.h"
>> +
>> +#define TYPE_AXIADO_SOC "ax3000"
>> +OBJECT_DECLARE_TYPE(AxiadoSoCState, AxiadoSoCClass, AXIADO_SOC)
>> +
>> +#define AX3000_RAM_START        0x3C000000
>> +#define AX3000_RAM_SIZE_MAX     (16 * GiB)
>> +
>> +#define AX3000_DRAM0_BASE       AX3000_RAM_START
>> +#define AX3000_DRAM0_SIZE       (1088 * MiB)
>> +#define AX3000_DRAM1_BASE       0x400000000
>> +#define AX3000_DRAM1_SIZE       (2 * GiB)
>> +
>> +#define AX3000_GIC_DIST_BASE    0x80300000
>> +#define AX3000_GIC_DIST_SIZE    (64 * KiB)
>> +#define AX3000_GIC_REDIST_BASE  0x80380000
>> +#define AX3000_GIC_REDIST_SIZE  (512 * KiB)
>> +
>> +#define AX3000_UART0_BASE       0x80520000
>> +#define AX3000_UART0_SIZE       (256)
>> +#define AX3000_UART1_BASE       0x805a0000
>> +#define AX3000_UART1_SIZE       (256)
>> +#define AX3000_UART2_BASE       0x80620000
>> +#define AX3000_UART2_SIZE       (256)
>> +#define AX3000_UART3_BASE       0x80520800
>> +#define AX3000_UART3_SIZE       (256)
>> +
>> +#define AX3000_SDHCI0_BASE      0x86000000
>> +#define AX3000_SDHCI0_PHY_BASE  0x80801C00
>> +#define AX3000_SDHCI0_PHY_SIZE  (256)
>> +
>> +#define AX3000_GPIO0_BASE       0x80500000
>> +#define AX3000_GPIO0_SIZE       (1024)
>> +#define AX3000_GPIO1_BASE       0x80580000
>> +#define AX3000_GPIO1_SIZE       (1024)
>> +#define AX3000_GPIO2_BASE       0x80600000
>> +#define AX3000_GPIO2_SIZE       (1024)
>> +#define AX3000_GPIO3_BASE       0x80680000
>> +#define AX3000_GPIO3_SIZE       (1024)
>> +#define AX3000_GPIO4_BASE       0x80700000
>> +#define AX3000_GPIO4_SIZE       (1024)
>> +#define AX3000_GPIO5_BASE       0x80780000
>> +#define AX3000_GPIO5_SIZE       (1024)
>> +#define AX3000_GPIO6_BASE       0x80800000
>> +#define AX3000_GPIO6_SIZE       (1024)
>> +#define AX3000_GPIO7_BASE       0x80880000
>> +#define AX3000_GPIO7_SIZE       (1024)
>> +
>> +#define AX3000_TIMER_CTRL        0x8A020000
>> +#define AX3000_PLL_BASE          0x80000000
>> +#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
>> +#define CLKRST_CPU_PLL_STS_OFFSET       0x14
>> +
>> +
>> +enum Ax3000Configuration {
>> +    AX3000_NUM_CPUS     = 4,
>> +    AX3000_NUM_IRQS     = 224,
>> +    AX3000_NUM_BANKS    = 2,
>> +    AX3000_NUM_UARTS    = 4,
>> +    AX3000_NUM_GPIOS    = 8,
>> +};
>> +
>> +typedef struct AxiadoSoCState {
>> +    SysBusDevice        parent;
>> +
>> +    ARMCPU              cpu[AX3000_NUM_CPUS];
>> +    GICv3State          gic;
>> +    MemoryRegion        dram[AX3000_NUM_BANKS];
>> +    MemoryRegion        timer_ctrl;
>> +    MemoryRegion        pll_ctrl;
>> +    CadenceUARTState    uart[AX3000_NUM_UARTS];
>> +    SDHCIState          sdhci0;
>> +    MemoryRegion        sdhci_phy;
>> +} AxiadoSoCState;
>> +
>> +typedef struct AxiadoSoCClass {
>> +    SysBusDeviceClass   parent;
>> +
>> +    uint32_t            num_cpus;
>> +} AxiadoSoCClass;
>> +
>> +enum Ax3000MemoryRegions {
>> +    AX3000_GIC_DIST,
>> +    AX3000_GIC_REDIST,
>> +    AX3000_DRAM0,
>> +    AX3000_DRAM1,
>> +    AX3000_UART0,
>> +    AX3000_UART1,
>> +    AX3000_UART2,
>> +    AX3000_UART3,
>> +    AX3000_SDHCI0,
>> +    AX3000_GPIO0,
>> +    AX3000_GPIO1,
>> +    AX3000_GPIO2,
>> +    AX3000_GPIO3,
>> +    AX3000_GPIO4,
>> +    AX3000_GPIO5,
>> +    AX3000_GPIO6,
>> +    AX3000_GPIO7,
>> +};
>> +
>> +enum Ax3000Irqs {
>> +    AX3000_UART0_IRQ    = 112,
>> +    AX3000_UART1_IRQ    = 113,
>> +    AX3000_UART2_IRQ    = 114,
>> +    AX3000_UART3_IRQ    = 170,
>> +
>> +    AX3000_SDHCI0_IRQ    = 123,
>> +
>> +    AX3000_GPIO0_IRQ    = 183,
>> +    AX3000_GPIO1_IRQ    = 184,
>> +    AX3000_GPIO2_IRQ    = 185,
>> +    AX3000_GPIO3_IRQ    = 186,
>> +    AX3000_GPIO4_IRQ    = 187,
>> +    AX3000_GPIO5_IRQ    = 188,
>> +    AX3000_GPIO6_IRQ    = 189,
>> +    AX3000_GPIO7_IRQ    = 190,
>> +};
>> +
>> +enum SDHCI_PHY_REG {
>> +    REG_ID        = 0x00,   // ID
>> +    REG_STATUS    = 0x50,   // READY/LOCK/CAL_DONE bits
> Don't use C++ style // comments, please. checkpatch will warn
> about that too, I think.
No problem, I will fix them.
>> +};
>> +
>> +#endif /* AXIADO_AX3000_H */
>> --
>> 2.34.1
> thanks
> -- PMM

