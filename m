Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDAFC5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 01:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyJuN-0002ss-0o; Sun, 23 Aug 2026 21:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyJuL-0002sj-Us
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 21:55:29 -0400
Received: from mail-eastus2azon11020139.outbound.protection.outlook.com
 ([52.101.56.139] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyJuK-0005Jp-5M
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 21:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POGGtps1sG8s6SsvdcGw7oSZQWrYn267qsMy3RTRfldya3x3S9ZG9EUmKH/spZo7PW5OtG03mLxQx0DlQ0WzCZWTg9pvAInHPuf3tD/t+X6a55+MhYYS749HqtOuP2tCdpwkemYRzRQUhf3iO0VPbWFBz4KxZ0sspcVeCW9TolGcsjMBgaoN7qPbQCKWUVP5HrEZquUGYq9px8kBrnmnXD+5mkdgLrT7V4BkbkEHxz1DjtdNU9j7GKG2V26UyfnAKvTcG2eaFjroD8c0SGW8tzMFVJDoteWfDYYfyjY93lZir0UIBlC4wOjOS0j2Q7F1EzCmbgW6z01kbTq72LIacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiELZ9DHRGl3Zq4meI9LtziV9sSgM3qxtis109r5/Lw=;
 b=pVZwiEgUX5xVBYRo22CUTfeay+qMQgs4nC5Knp+V0dkBKJczSpM8lpha/yzq+baFtYtabDV4RtGaPS+rD+TCbWlss5shFsAOCGtMWpBrJWF+h3lQ9cou5epzt9vXhXpco2j3E3ZRyW2WfNFYzs5iYh/XeJH8f4T/kOk/zAp0IZeK7YA9pbroHxuq3oCwiHuSf65CwbkCcBS2IY2OGNW+CfQarI+P2+R800Hbc4cM3BAEZf3amfcuwj4h2lv0Tacf3A9dyPQUvyVARdu38hvqBcSVAIyqfLydjwZ2t/rJQb1jCRdGeBDtW18l7wxzLaCYlVH9+A2c+dXywMAOnxQ0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiELZ9DHRGl3Zq4meI9LtziV9sSgM3qxtis109r5/Lw=;
 b=pt6Hnp+54OqZToXpp/ARo8/8KMqtrU8IlFVWkebO13OWCcNDpuQ2Gvfrg/iYvil3rUV85hEW1QnCCG8UPMY1ee8oYXBsnrtOmUBlwv4NhVPFa/mSIp8kqdXxfshNYrWV4RJBEZ5QJdlijYSQzk+RZeyWcyz8nplFPgw6xBdHlD4tdEIOBsq+Xoq3zMF9SzJUid4mz0URxuneSx7BfKYGRVcw+1LFIyhQ1wTnlq5r+oRc0Dmch4fbGkSjYBNF+iPvCHS1sobhS3Y1j452JI8lLNmK7+gqyitTNPCN0b1YbE7msauKA6BYbJC88VS2weWJMqjwii9wKLweprFsH6FwUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by LV3PR18MB6351.namprd18.prod.outlook.com (2603:10b6:408:274::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 01:50:12 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 01:50:12 +0000
Message-ID: <64edab19-b14b-4b9b-902b-a72f742faeae@axiado.com>
Date: Mon, 24 Aug 2026 09:50:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] hw/arm: Add Axiado SoC AX3005
To: Jack Wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260820102132.361642-5-kchiu@axiado.com>
 <E7312F05-0DFD-4501-A59E-1DAD8C999785@gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <E7312F05-0DFD-4501-A59E-1DAD8C999785@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|LV3PR18MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: a8937920-ccb2-4ca7-7008-08df0182093b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: LKMzubA7Ps8gQ6Yq8DDFn8r6mIUl5pJZLIkESsd4nbdeEFrpgGLExtTX0o92dTffbXHAjO/Pk/fbvoGZIpPq/kLH3aKJAhVo8JbXkXsfMsYgZDMMn/6YAdyIEGfBm/3R3eSiz2mxahrU0EuYtprlULNiA2Eg2un5YcH/HczpV2U/AnmHUy/HJMIrmYCw7tEKClr0R/ojNSYfxXllE9oJupd0i77ocwVlSP19L6w32vjjB5cyxqQhtDbXQ6B/WagNwbdRcNHhZwIxRdaEFYtyk9MJUQJUyds81D/F8UFeFjlsfw1fXAFXJ2tI4W8dvKz+vkS8Ey+yBAPqYGgjWhnrFMlbsc5IC3YeO6sB2SuxSdTq5VlNNPFsgZQY20ddAFjYB7ytsyfhwSK7BzZk3v99s+LLzK9epCuo/Lrl4aL/+4kxAnM+AS/o1mJ5x2IgxorHa/yYJFNmEjrPj2eP8rvNOfeVf4B59mc4dLmD6QlW3qhBsPUurwj20kREMcomHhA4qdjtGjOwDD5wbqAHWN/pMV6UBBAL5Sp6DDaCTh8wo7gPpjZihhxIv4rDS2kkeMPr155ytcB/JdaVFI7ge3qCf1XWBM7p0yKN1+Escrz5ieraWbFoTWKfUTS/eUivYZBT3SuevccOnO0gN+XQ4baOFNlXa1mUrqNfx93C30ZKnso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZJVmJEMk5YbFVTSk4vWXVOaS81OUFzTlZubFQ3b1dudEJ1NFF1bXNwMG9o?=
 =?utf-8?B?ZWFrMTRzbDlpS1ZkUTd2cGVRUUdmWVYwRXJNK2F2U3FoeTJhcWhVK3ZjSVhW?=
 =?utf-8?B?TlFCODgvaW1CK3ljMW1Jc0RjdzlBdWRVR3g4eUhaVWl4Q1lwU1NZYXFEZ1dY?=
 =?utf-8?B?dVlLa2dsUThJUW5QZ2N1a2FtRFM0dUZHRGJlR3luWHdaYWcrVnVkaExOTEli?=
 =?utf-8?B?TmFuYkR1Z3UxaDN2TURPZ0dqRTlLSFlEaXNUMTJISlpsRlVjT2ZITHNib0xF?=
 =?utf-8?B?ZjhlQUgzYmxsa2xtRGNEZlJXWDc1WGZrYlhCSUdlVlBpZjRPR1hHYUlsV0Zx?=
 =?utf-8?B?Vlg1emkxMENXb3U4OStnSFd4OWk2aUVoekQrajlHM1dqRkJoL0VhQ3hHR094?=
 =?utf-8?B?emp5WmFpYXJsdFZZZmQ1dVZ5S1JGRklsSWttYkZtNGlQK0xnY2RmclFmR3FO?=
 =?utf-8?B?VWx5eXdMd1VadmJTVDBMZ3hRVEZ6TDBMWXIvK29ubGt1V290NkJlaUZQR0dU?=
 =?utf-8?B?R1VWTmxLWjd2ZVRJSDdFbkVrMGV3d3lwcHJzSVhvQ210aVdaVWx0SHdRZ2Ey?=
 =?utf-8?B?Mjh6R1NsaXZ1M25HU08zVDVkS1QzYVk4bUJ1WEQyTEFwQlhLYlM3WXU2K0F0?=
 =?utf-8?B?N1FtZFFQYUl4cDAzTlVNOVFIUTVyS0V0WWtYWDdVcGdDUm1vMjhIN0ZVYjc3?=
 =?utf-8?B?MEQrVkU3OEJNSlFTRWpiNUdTQW4vY1gzT3N1V2tuWnptbUpPU1AwM2U3bkpq?=
 =?utf-8?B?dWlzMy80N1FveUQvY1lIUGR3NGdldzIwMTdUL2pqTEwvdEJNL2JGN0pBOHVu?=
 =?utf-8?B?aDlPTVZNdXRLVWFDZWt3dEF6VUc5SlRuVVl1c0NaREhwWFJxaXZyS3VVS0xS?=
 =?utf-8?B?TVdXWnNETWRJejNsWWI0ZmRYYS9zcTQ3TjU3anpZTEs5aW5sQUhJeGp1bTh4?=
 =?utf-8?B?VndUQjgrTWZmdlcyWVdORlVGRDVMVjY3WHk0M1BLSEQ1MUkwNndITmxjSUpz?=
 =?utf-8?B?UTFFWVNhV0x4R2JRdjNGd0lMVjRxcjQrOThpZ0dyWDFHaVRnZkViUWlpaHdu?=
 =?utf-8?B?RkovdkNQcVBMTk51TWRib1hISkUwMFdCcllKQlhlYS9QUnlZdjU0TCtLWGs0?=
 =?utf-8?B?aEVDSmxidGdFdEJOWHpSazZySElrNUFXK1hPRlVKWVIxcDAzalNoalQvdmha?=
 =?utf-8?B?ZlRza2lLTmpBUW00ZDVWWTJMczEyTWF5dDhZdXZoYWFmUGN6YURrUVdMYUlM?=
 =?utf-8?B?K1p1Z0RqS3VENjJ0SEtpYUVyc0FjQWwwUU5rTW5IUC9LTGZqWFFwdXpSSFZj?=
 =?utf-8?B?dGNTcEVtOVZIbXBUVkxlY2ZzLzFKd1BndGh6V3Qxb3h5STlRTTVCUWR1dGxV?=
 =?utf-8?B?VkdGTW1ZUGo5UUlFN0k4aXc2aGxKWnNhMlN2WVhpS2tLMWd1M1FMWWhOTi9t?=
 =?utf-8?B?MGRpMzRzZ3hleG4rVllwQkN2czRva28zWnRRY214YUxEWnZZZllHV3hsRmlQ?=
 =?utf-8?B?R2pYL3I2OVNtK2wwcTVjbkFmNkRPYVVaeFVJNXYxbFZ4aCtMZnMwaE1vS04w?=
 =?utf-8?B?QmJDMlNTaHVyZUFSbEhrVjNkR3BXRlI4Wk5UVGkrMi9LeTNQeVlMcXJHVkI1?=
 =?utf-8?B?eDR6Y1FKOHEwdzBWbkRVQ0pRSmhLcHViTVBQdnFPSkJFazlmY2ljdlpkRmpQ?=
 =?utf-8?B?UDNKcTBvMi9sYUJVakc1ZFB6WDhyckVRemMva2I1OWFWU0NIMlUrSVJnNGhL?=
 =?utf-8?B?cWNpL1VwQlhTRmpRV3BmeDhGMjFsOWM4RmxCdkxyY2EvRnhYdkxibllrWlIr?=
 =?utf-8?B?Y3E4NStrR0lsRDN2WjlybWpYL2I1U1JjdFdNbU13TTJmRjN1bWNsQVBia3Q1?=
 =?utf-8?B?a2xScFJhbUU1NUZZellHOGRKTENDOGpSdWVrelExdzhic3Z1Z2xXLzQ5OWtC?=
 =?utf-8?B?ZlBMbW5PMWppdFlrQ0NxMWdiUUVvK2JSWEZIV2dLb3VkL01DMHN3RThLa1BK?=
 =?utf-8?B?bEJKRkFXUTU3WVBuUVVpYnpvUTM4cmFWODJNcU9IcStSZVJ4ZzdCcFJzWTRT?=
 =?utf-8?B?dmpGdzBGSllmM0lxREJEVVJXRVdPRjBaNDlnVjRYTVpRZGpjQ3ZYNGhJSlNl?=
 =?utf-8?B?UEJQWkVPaUEwNUxhcXV4TVBDM3NiamJpeHF3d0FMVEhFSHJ3TVdnbUV0cTBp?=
 =?utf-8?B?bityZW1BaFNaZm1vdk9MQktjdWZiRzVKRGpnUFR0NnE3dm9UVHh1Y0NjOU1V?=
 =?utf-8?B?MHNhbzRaNXUyODU2cGJSN1BQaUdJMDVub1hYRDlkdmloU0F5SzFXOHpKNW5H?=
 =?utf-8?B?VWhsTXF6LzNJN2xDSWdYbVJXTDNiOHZQSGJvNFFCOHBQdnE0STViZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8937920-ccb2-4ca7-7008-08df0182093b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 01:50:12.5505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52kYAl6vY8LW5/kqDUzP+1uy/OG+lfrYwOAH5XHoTaMiohO6tK5DE0d2YUL+a2gqzwe7t6KD+iErP4NVa4XCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6351
Received-SPF: pass client-ip=52.101.56.139; envelope-from=kchiu@axiado.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Hi Jack

Thanks for the test, could you share how you built and what the command 
was you used to test?

I did not see this issue on my side, maybe I missed something

B.R.
Howard

Jack Wang 於 2026/8/23 下午 06:33 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Hi Kuan-Jui
>
> I tested this series with ax3005-evb machine,the initialization did not complete.
> The process showed it repeatedly executing in 'ax3005_init'
>> +static const TypeInfo ax3005_soc_types[] = {
>> +    {
>> +        .name           = TYPE_AX3005_SOC,
>> +        .parent         = TYPE_SYS_BUS_DEVICE,
>> +        .instance_size  = sizeof(Ax3005SoCState),
>> +        .instance_init  = ax3005_init,
>> +        .class_init     = ax3005_class_init,
>> +    }
>> +};
> You add instance_size here but forget to add class_size. Then qemu defaultly use SysBusDeviceClass’s class_size cause of father-son relationship.
>
>> +typedef struct Ax3005SoCClass {
>> +    SysBusDeviceClass   parent;
>> +
>> +    uint32_t            num_cpus;
>> +} Ax3005SoCClass;
> Here your struct apparently extend SysBusDeviceClass field. I think it is the way why previous repeating behavior.After add class_size locally and rebuild the the machine completed initialization and responded to QMP commands successfully.
>
> Best regards :)
> Jack Wang

