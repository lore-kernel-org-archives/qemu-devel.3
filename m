Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B94E65D29
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEO7Y-00065X-IC; Fri, 22 Nov 2024 02:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1tEO7V-00065D-RC; Fri, 22 Nov 2024 02:30:27 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com
 ([40.107.223.61] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1tEO7S-0008J2-MJ; Fri, 22 Nov 2024 02:30:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJK3tnSqbu/x1gH7Vp35wd7YfAPJiN6iy9zuVEDjXZEDlAWyYDqs9rCW8QSQrfTRLSuYu6TtCDqU1zRJQIoGhqvmkipc9VofqfZtTpAghcWGE6VwdnnCC83NQGezh0Gex7EAN1gfAOSSCtaOJj6bUaSEH89n7iiRYFVUl3DYr4nurqGsdTSypoQBIy1y/StEXeiBwf2fp4C1ftKlviecVV4yvgMYIxFWif/OsgrCktPhzb4Bx+Wxfc4Sm0ihym4/ZuyUKhfSs6zHIyDTbp801ZgumwWmM/YZUj7MlkNHt7a+gVzVyHdUCBRcZfNZ0sTm/TespSDaQFwtyhWWPzo+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGBd79nWRzyNkoF5g6OPFnRbN3W+WBVqKrVWDb60nIM=;
 b=XDnKS+b/PFHutzPY95ZWzjqJpl1t8AONJiAZitTKO9GIbZLJC5CfkVFWiypxX/LjtxP50EnByXs9XiO3OlTnRDeCojdjrTse6IaV3f12CtaULIjiRGBoI9xyzQXcSlPDv6b+owuESMYpPjkkoPmhppEGyoB53ZHN8+obVnBY551UIm4Mk9Q4HXI8Q1XziidSdsefSQ7Hpao05qzvNsSH7mdehq6TIPDMtfSF3MP5cShUFAjchUeIh+vDsyzTrEhnUR0F5c/LzHKqvVpdYs8x/WqarZjynC7aJKBmu1eaGc1fMG6FdLLuqGMXCqwrP7/lPCP4j+nHaWjYuay6TIBXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGBd79nWRzyNkoF5g6OPFnRbN3W+WBVqKrVWDb60nIM=;
 b=Y6b4D4UBHn4prgCP9R+D9wMeodse6mUjEDlXaQw31rpkZs711TqKDbfO/QEqVz7EphruEWJVACFlwoUXqwfdZKiFyIpf8vhSwY8GHbp4YPAQ8yXJFaBuksIa9qQ+F5etzNm9ljdyiW/i8WzpFeX6mQ8kBJxqqctJ4ivDP3TFf+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 07:25:17 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 07:25:17 +0000
Message-ID: <1ef763c2-29d4-42eb-a644-728be6242b34@amd.com>
Date: Fri, 22 Nov 2024 08:25:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/riscv: Add Microblaze V generic board
To: Alistair Francis <alistair23@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Iglesias Francisco <francisco.iglesias@amd.com>
References: <20241119144956.728384-1-sai.pavan.boddu@amd.com>
 <CAKmqyKMcW3p914U4oH6X0K6e2owOcWF2w6vNhPVVL1ViH4Q3Tg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAKmqyKMcW3p914U4oH6X0K6e2owOcWF2w6vNhPVVL1ViH4Q3Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::49) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 7412104b-8495-494f-29dd-08dd0ac6d03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnNPY2xPR05CQTRQRlp4ZG1wMVNxRi84bUhpb2FISzZnWE0vWEk3bU9sakx5?=
 =?utf-8?B?emw0V0N2ZHpONDFOa2s2YkZSWVpTczNZc2pvY3BKdWpTdmNIalNCSW8zT2Ur?=
 =?utf-8?B?Q0JCZHp2Z3loUFBFSWRvZUNvZmtLS2lIVlhNcW42OXFxQ3NuUUFXTzlyMHgy?=
 =?utf-8?B?cEh1YlNZUUdPSVlvNmlXWkNXYzFsUmFxMjUzTVluWExjMG4yQnRidHpKQ1gv?=
 =?utf-8?B?TW05MGMwMFJJY2w1VEdsTWxCWjFESDJUZ3F5OG14OFQxTjczS2pmZGNkWlhp?=
 =?utf-8?B?OGcwb0I0R2UrYWZVNm1yVy82Q0xtTVF4Z3ptaWErUjlrN3ZFMDRSdHprMHlC?=
 =?utf-8?B?QTg0dHlFL2VHNzdGWmNLV05xSUVybDB1bEJYK1EycHhjRE9yMGpNR3NrbFFx?=
 =?utf-8?B?eUlHOEJPREMwMWFKbG96U3QrbTIySWQvYlhxRlhvcG81cnJYZ2hvY2pzakJL?=
 =?utf-8?B?R0loS2lYUnFoMkdSOSs3d2xqbVVJRThkRzR6NnZPVGpLS3Rpd3FwbHk3ZG91?=
 =?utf-8?B?a2t1cUtYTzI2MlhDRzdyNlNybEtZcThsNU5nUXp0ZmM5UDZZa3FRMVYzMmh4?=
 =?utf-8?B?NEd2cUFXU1NjR0xDUzR4REtiUm5pVDJGQUQ0em1LMU1WZlBCaVJMSnJXWkpB?=
 =?utf-8?B?enFXZVhUREo4RkJLbktYaEJWOVMvNG9EMTdIYWxnRkxIM1czRE84emJxNjA3?=
 =?utf-8?B?L1RVNm9heEVjSWZKZXB1Zzd4ak9lbm00b1JEK005bzd6SkRVaFlPbkVub1Z4?=
 =?utf-8?B?SDQyMHpucHF2ejNXMjcrVDhLSWhVd2lqaDNXK2pMckVmblI4UlZEbndGTUN4?=
 =?utf-8?B?TWNzbHFOa3Z3VTFIRW5BMnlqYnVvdERZM21aZ1FTQlFPeGZWMFhJRTAwaHhT?=
 =?utf-8?B?YmQzV2h3LzBCMUV1ajJjSnh4ZWtScmZqRmxlVmhQbjc3QmI0VG4wNzZ6Sm5u?=
 =?utf-8?B?aXBVc21BLzJIQkZmLzRVeDZwSmxnOGZuOVpNQ1FWY1h4M2h0cXh4SzNUdzZi?=
 =?utf-8?B?cERZTTZ6ZzUzbVNYeU9reDVFZllKaWZMRDRub2EzTk1DaUV6UWU5OXVvQ3FT?=
 =?utf-8?B?UGlUZ1hZMXpEbnRpLy93bVlVN3pMK0ZoOGEvUDY2clRtTDc5bkFpeFlSWERu?=
 =?utf-8?B?TXE1WEZWdy9VNXI1OEFlYnhPbXNuVTl2VE1HNE01LzVZR2NYZFV0VUVEMzZZ?=
 =?utf-8?B?S2Y5QmZjVjhzZzZvdENxd1ZQcVJjMXlCWkxzdG5zZzJkN2RXQVhzSXc2bXNy?=
 =?utf-8?B?ZGlWcDVEYzhjMVVmTVRDd2NJTXFMY0FPT3EyUXR6cC9mcWdWR3lWWTFjMW4v?=
 =?utf-8?B?ZkRrMEM5N0dRRTQ3bGV0QXkxR2xmK2VFTlFadU1BNWUwZ2Y2UHRyaG82dmNx?=
 =?utf-8?B?UzJVZUxTaUp1S0FYd3dLaytNQnZ3TzV3VWVlY0praGYzeERaRDd3S0t1RkVs?=
 =?utf-8?B?NjQ2SXJwcHNCb0Y5YmtzM0NVVXVZZkNOYll5c3pweHk4cDJFcHA0Y0pnOGtr?=
 =?utf-8?B?L0RTVGJveU5STWQ3eDBsMjhCcFlhUWtZYkNzai82R1JSaUFON1RabGNyUm1P?=
 =?utf-8?B?V0ZhdVRjMi9hQzdOcy93QnYzSmVxN0VmYXdVRFZZWUwveGRIYjEzeVFxSFY5?=
 =?utf-8?B?OGppcDloQ3VLU0RyWFVqcDl3akEwSnZYR015cHBTa0o0dXBGMXIvbzFHeWJo?=
 =?utf-8?B?cFpYM2xmajVGSjZnY253ektQUkIrMlF1TkVLUUEwTG1tUzBpb0pmeUVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWF1clgvVm9CRmlYZTVkQjJNZXBVYjZNRTZOaXV2MmRNR213Wmw1ZXFUc2pV?=
 =?utf-8?B?d1pJRHlFV3duRzlPa3l6eW8xZDBWMk9ER3dUeHMzbnFLcUh6MzRseDVLd1NF?=
 =?utf-8?B?cDg5YnBQOUtiRi9oWEdPeTVzOWpUQ01nQStMRjY4SlBEeTdoL2tWYjVhc3JD?=
 =?utf-8?B?bi8xaHVyZnhWTkJKYS8waWNMVWtid2lmM0JJa29Nc2ZDM2VzMjlFUFVjSko2?=
 =?utf-8?B?SGNqYkRIWG81QkRNNWlOb1M5VFZoamJPa0xRUklsa0Z5NTVrZ1NTS082UllF?=
 =?utf-8?B?cFd2NnhrM0lPUnRydVNTdEUwUi96a05BRG8vNlZoSVpXMnV4MUh0aE1XZTRm?=
 =?utf-8?B?d1lhUzJnU256TFVBNHllbmdjTENkVUJDU3FnWVlWeXFTdW8zQ01uWUl5T3hD?=
 =?utf-8?B?M2xORGp3ZFVQUnBVcExKWW9jNFhVdHZhKzk5RFdydzErb0gzVjZwUm9TYm9m?=
 =?utf-8?B?VmxtOEJYbTZYSWFXeXJQSjNKdEJyeTFaeG4zSDNxY1Y5NVVWN1Y0TzZldGhZ?=
 =?utf-8?B?bm5PbWw5ZHBNcDdUYlhRRDlxMnJzbGlNSFdGeVJndFZtZU9kdXVBWU1XOWU4?=
 =?utf-8?B?dTR3aDRUYTVRTTQ2dGxJQlNReVV3WnhJUE9jUUQ4Nnk0eHd6NFRUdGo5THIv?=
 =?utf-8?B?SE55SVYxUDJzam1RTlhQMFN0eVEvQmdZaXA5VWpWVGdFNzBtMjY1TGt1b0FD?=
 =?utf-8?B?bVJmQ0JyMmJjWnZMZUlFdnRDbXhNREY3bzFJN3l0c3BaaDRJb0RHT3RlNEhn?=
 =?utf-8?B?OWFWVlJ3dStvSGdJWjdZWCthak4yWVNHTzljVUNwaFIwRTFOZjVQRmVCMHRL?=
 =?utf-8?B?Myt0VWFMMndoYUhzMllsMnkwLzdNV3ZhVVpCb3ZvcWdFMm1IbDM0V0RqdWt6?=
 =?utf-8?B?dGwxWXMxaHo4U2toT3BzaE85cHdCMlBCUFQ2OG1kUlhKdkh3b2EyL3FVZGFF?=
 =?utf-8?B?dUxDTEFoUTBZcWQ4WWx1YkRwTGd6b3g2RExTbzV5RkM5MlB4eHVQSDVzcmsw?=
 =?utf-8?B?Sjd3YlpiTEwweUpSUTJscVhXZERrbGE0NmwxTytaYW5RVlBwUEhQbkUyUm1L?=
 =?utf-8?B?Ukp5N0c0RzUzZ0loNGp2MmduQlJHSWRtcExPeWdXLzkxT3Y4ZzJqbVlaT1pF?=
 =?utf-8?B?amxzRTdkWEFjRHNycFh4emZLWWFvU1JoM2ZNNXF2OHk0ZnAvRFVvVFF3NDQ4?=
 =?utf-8?B?OHhmb1owOXdjN21LZGtVRC9PY0cycWdZcG5Xa0xHK1VqdERFR1F3eHlMTzMz?=
 =?utf-8?B?WEtlRlBtQkZqbkw4YlQ1RVkxcU5NT1FzZTlpYUxFVGcwTG9HQjNOM1NjMjR3?=
 =?utf-8?B?dzU3ZjBXWW01VFpiU1FXVXJJQVRlZTdTQ2NER3VZVkZORzA4UTc1TDVDMkpn?=
 =?utf-8?B?T0t3Y2ViQ21OeXBwR3NodjhhN04wZE8zcFVYeFpoNEdXQzZVY0FpbVYwMW9X?=
 =?utf-8?B?TGE3TzFwK3dnRG5iMFNOQjBRcThHck9zR0NTQ0V1ak94ZkRFM2hXN0VtWk81?=
 =?utf-8?B?TTFHZDZ0eUxhYld2S0orQ0M0L0loN3QvQnQvSWIxWUFuVnBWZVB6djhYZ256?=
 =?utf-8?B?cEJMM3NIenMwMG1vS3VFQ0NvYnk1c3pIOUpoWDJKYVpyNXhzbElvSG1USVFV?=
 =?utf-8?B?dWF4SzdlbHpyRkZoRDl4NXdPU2V1aUVPWGxlOXlZaVZidUVMek01ZUtHY1la?=
 =?utf-8?B?RUErQzh5dTdKV1hBdTFENVg3RXV5S1pKS0ttTkI5Sk04akNRcEwzcFdYNElO?=
 =?utf-8?B?SUxoTFZKMU9FOWFGQXFIdjNOSnNZN242dmg5TjBmUkRHQTJETnhqcTNPekp0?=
 =?utf-8?B?ZElnaExhWjloZmRSSHk5THNNR253RGcyN1ZLd0RJaXhKSy9PWVdoSEZDYXBR?=
 =?utf-8?B?cE1Ga2tkNkFSMHRtcU1hbHkxaTY0OFY2ckdjdHVBN3hDZVRINFVnN0RUeWk1?=
 =?utf-8?B?TGMybkZuaE5lVUVCT2ovcS9lVklyUnJ1OHNyL2IyU0ZGdWpjRlhXVUgvTG9o?=
 =?utf-8?B?NmRCeDVxSS9mZi82MkFhKzFLbllYQmlWNkFyZzVCeG9MUkdlNVlMZFIvanBz?=
 =?utf-8?B?VVZyU3VaNVV4TnV2alpTVWl4NFFaYy8xVnV1Z1k3c1RnZFI3NEVqMUF3bFF1?=
 =?utf-8?Q?I7oAG4Jym9NM9Sqs/kPT3gkfp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7412104b-8495-494f-29dd-08dd0ac6d03b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 07:25:17.2020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66f37Ytvfyrs2BXLx9xgkOR+tuMYvknHANTEU8OYJ3CvpGxO5iNx9w57sV73Ld/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
Received-SPF: permerror client-ip=40.107.223.61;
 envelope-from=michal.simek@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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



On 11/22/24 06:42, Alistair Francis wrote:
> On Wed, Nov 20, 2024 at 12:50 AM Sai Pavan Boddu
> <sai.pavan.boddu@amd.com> wrote:
>>
>> Add a basic board with interrupt controller (intc), timer, serial
>> (uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
>> (configured via command line eg. -m 2g).
>> This is basic configuration which matches HW generated out of AMD Vivado
>> (design tools). But initial configuration is going beyond what it is
>> configured by default because validation should be done on other
>> configurations too. That's why wire also additional uart16500, axi
>> ethernet(with axi dma).
>> GPIOs, i2c and qspi is also listed for completeness.
>>
>> IRQ map is: (addr)
>> 0 - timer (0x41c00000)
>> 1 - uartlite (0x40600000)
>> 2 - i2c (0x40800000)
>> 3 - qspi (0x44a00000)
>> 4 - uart16550 (0x44a10000)
>> 5 - emaclite (0x40e00000)
>> 6 - timer2 (0x41c10000)
>> 7 - axi emac (0x40c00000)
>> 8 - axi dma (0x41e00000)
>> 9 - axi dma
>> 10 - gpio (0x40000000)
>> 11 - gpio2 (0x40010000)
>> 12 - gpio3 (0x40020000)
>>
>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>> Changes for V2:
>>      Make changes to support -cpu switch
>>      Remove setting of default board
>>      Include doc to toctree
>>      Remove setting of 'imac' extensions as they are available by
>>      default.
>> Chages for V3:
>>      Replace virt with generic
>>      Update doc with supported riscv extensions
>>      Change base CPU to TYPE_RISCV_CPU_BASE
>> Changes for V4:
>>      Improved the doc based on comments
>>      Disabled support for Double-Precision and Hypervisor extensions
>>      Updated Maintainers file at riscv machine space.
>>
>>   MAINTAINERS                                |   6 +
>>   docs/system/riscv/microblaze-v-generic.rst |  42 +++++
>>   docs/system/target-riscv.rst               |   1 +
>>   hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
>>   hw/riscv/Kconfig                           |   8 +
>>   hw/riscv/meson.build                       |   1 +
>>   6 files changed, 242 insertions(+)
>>   create mode 100644 docs/system/riscv/microblaze-v-generic.rst
>>   create mode 100644 hw/riscv/microblaze-v-generic.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index acc7405aed2..100a138d8f2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1619,6 +1619,12 @@ F: docs/system/riscv/sifive_u.rst
>>   F: hw/*/*sifive*.c
>>   F: include/hw/*/*sifive*.h
>>
>> +AMD Microblaze-V Generic Board
>> +M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
>> +S: Maintained
>> +F: hw/riscv/microblaze-v-generic.c
>> +F: docs/system/riscv/microblaze-v-generic.rst
>> +
>>   RX Machines
>>   -----------
>>   rx-gdbsim
>> diff --git a/docs/system/riscv/microblaze-v-generic.rst b/docs/system/riscv/microblaze-v-generic.rst
>> new file mode 100644
>> index 00000000000..5606f88d570
>> --- /dev/null
>> +++ b/docs/system/riscv/microblaze-v-generic.rst
>> @@ -0,0 +1,42 @@
>> +Microblaze-V generic board (``amd-microblaze-v-generic``)
>> +=========================================================
>> +The AMD MicroBlaze™ V processor is a soft-core RISC-V processor IP for AMD
>> +adaptive SoCs and FPGAs. The MicroBlaze™ V processor is based on the 32-bit (or
>> +64-bit) RISC-V instruction set architecture (ISA) and contains interfaces
>> +compatible with the classic MicroBlaze™ V processor (i.e it is a drop in
>> +replacement for the classic MicroBlaze™ processor in existing RTL designs).
>> +More information can be found in below document.
>> +
>> +https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V-Architecture
>> +
>> +The MicroBlaze™ V generic board in QEMU has following supported devices:
>> +
>> +    - timer
>> +    - uartlite
>> +    - uart16550
>> +    - emaclite
>> +    - timer2
>> +    - axi emac
>> +    - axi dma
>> +
>> +The MicroBlaze™ V core in QEMU has the following configuration:
>> +
>> +    - RV32I base integer instruction set
>> +    - "Zicsr" Control and Status register instructions
>> +    - "Zifencei" instruction-fetch
>> +    - Extensions: m, a, f, c
>> +
>> +Running
>> +"""""""
>> +Below is an example command line for launching mainline U-boot
>> +(xilinx_mbv32_defconfig) on the Microblaze-V generic board.
>> +
>> +.. code-block:: bash
>> +
>> +   $ qemu-system-riscv32 -M amd-microblaze-v-generic \
>> +     -display none \
>> +     -device loader,addr=0x80000000,file=u-boot-spl.bin,cpu-num=0 \
>> +     -device loader,addr=0x80200000,file=u-boot.img \
>> +     -serial mon:stdio \
>> +     -device loader,addr=0x83000000,file=system.dtb \
>> +     -m 2g
>> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
>> index ba195f1518a..95457af130b 100644
>> --- a/docs/system/target-riscv.rst
>> +++ b/docs/system/target-riscv.rst
>> @@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
>>   .. toctree::
>>      :maxdepth: 1
>>
>> +   riscv/microblaze-v-generic
>>      riscv/microchip-icicle-kit
>>      riscv/shakti-c
>>      riscv/sifive_u
>> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
>> new file mode 100644
>> index 00000000000..427e3baca7b
>> --- /dev/null
>> +++ b/hw/riscv/microblaze-v-generic.c
>> @@ -0,0 +1,184 @@
>> +/*
>> + * QEMU model of Microblaze V generic board.
>> + *
>> + * based on hw/microblaze/petalogix_ml605_mmu.c
>> + *
>> + * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
>> + * Copyright (c) 2011 PetaLogix
>> + * Copyright (c) 2009 Edgar E. Iglesias.
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Written by Sai Pavan Boddu <sai.pavan.boddu@amd.com
>> + *     and by Michal Simek <michal.simek@amd.com>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> +#include "qapi/error.h"
>> +#include "cpu.h"
>> +#include "hw/sysbus.h"
>> +#include "sysemu/sysemu.h"
>> +#include "net/net.h"
>> +#include "hw/boards.h"
>> +#include "hw/char/serial-mm.h"
>> +#include "exec/address-spaces.h"
>> +#include "hw/char/xilinx_uartlite.h"
>> +#include "hw/misc/unimp.h"
>> +
>> +#define LMB_BRAM_SIZE (128 * KiB)
>> +#define MEMORY_BASEADDR 0x80000000
>> +#define INTC_BASEADDR 0x41200000
>> +#define TIMER_BASEADDR 0x41c00000
>> +#define TIMER_BASEADDR2 0x41c10000
>> +#define UARTLITE_BASEADDR 0x40600000
>> +#define ETHLITE_BASEADDR 0x40e00000
>> +#define UART16550_BASEADDR 0x44a10000
>> +#define AXIENET_BASEADDR 0x40c00000
>> +#define AXIDMA_BASEADDR 0x41e00000
>> +#define GPIO_BASEADDR 0x40000000
>> +#define GPIO_BASEADDR2 0x40010000
>> +#define GPIO_BASEADDR3 0x40020000
>> +#define I2C_BASEADDR 0x40800000
>> +#define QSPI_BASEADDR 0x44a00000
>> +
>> +#define TIMER_IRQ           0
>> +#define UARTLITE_IRQ        1
>> +#define UART16550_IRQ       4
>> +#define ETHLITE_IRQ         5
>> +#define TIMER_IRQ2          6
>> +#define AXIENET_IRQ         7
>> +#define AXIDMA_IRQ1         8
>> +#define AXIDMA_IRQ0         9
>> +
>> +static void mb_v_generic_init(MachineState *machine)
>> +{
>> +    ram_addr_t ram_size = machine->ram_size;
>> +    DeviceState *dev, *dma, *eth0;
>> +    Object *ds, *cs;
>> +    int i;
>> +    RISCVCPU *cpu;
>> +    hwaddr ddr_base = MEMORY_BASEADDR;
>> +    MemoryRegion *phys_lmb_bram = g_new(MemoryRegion, 1);
>> +    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
>> +    qemu_irq irq[32];
>> +    MemoryRegion *sysmem = get_system_memory();
>> +
>> +    cpu = RISCV_CPU(object_new(machine->cpu_type));
>> +    object_property_set_bool(OBJECT(cpu), "h", false, NULL);
>> +    object_property_set_bool(OBJECT(cpu), "d", false, NULL);
> 
> Note that there are a bunch of other extensions that are enabled in
> the base CPU that you aren't disabling.
> 
> See https://github.com/qemu/qemu/blob/master/target/riscv/cpu.c#L1472
> 
> I don't think it matters too much, but you might want a vendor CPU or
> use the bare CPU and enable the extensions if you want to customise
> the extensions. The base CPU is a bit odd because of the way it had
> grown organically.

I don't think this is the problem because every customer will tune their 
extensition based on their requirements in design tool. And this Qemu instance 
should be pretty much superset of extensions.
The expectation is that we are going to use it in U-Boot and Zephyr CIs where 
default configuration will be subset of qemu one.

> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks,
Michal

