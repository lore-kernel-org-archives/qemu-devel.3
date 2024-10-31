Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7D5E6895F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Qmw-0005WT-PM; Thu, 31 Oct 2024 04:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1t6Qmv-0005W7-6e; Thu, 31 Oct 2024 04:44:17 -0400
Received: from mail-co1nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2416::621]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1t6Qms-0001gE-H3; Thu, 31 Oct 2024 04:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+kc3/F++T35gjTP990NP/tXu2TFBXLct2yLZStQbnejYUzFyxZbHQfMVsFndSqZ5ZS4Q19gWSbFBQMASVO31TOIhnK4QvvDfxJlGGxoBjFJrfMfM5kJP8+YMJkozQg0YNlrUmxcxEuvaU5qxkGS5B1owXDEUDYLW5o1QvnHcSJx4jDDDuv3d5fJvDLK1TGSiysTkH7K67dPBKOSDOdaYOMjIpt8i/gjZd1IR55GNyQ1xdmSg7hot6Wa4KOh4lKwpAWqxTorQUYy7zoW6xcwhhaWTcmLM+lBS3Oqv1NxhCzuBDj4LlwsZrkFHJ9uQc+s6eddvUhLh9aIBsqSdnoTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRF7E6uSOraU5QhF8Mu08PTLmPhviVyZ7Yt1r2Niz08=;
 b=TgXkw1uuAUmn/gxpNCqATSwCBAM7x4xVCCaVrVH3p+Y4N8LoN4dpwTX5piL1gYUB3eGbVWB7TlHAqAZTNRtzSyNabrA5rW3jKjNeyLQADUPjxp78stOqAMqJ1/AZbALZkO+1WVaRkegWdE6fU19gPnhLLc1Skqm5TBfWHgd+YxUIMhIXmkcP3mcLk3xvrKBnt3lEPl37EG1p9B3DeQm78VD3ogpitB8r2NGXoLPvL+qWNEMMFNn5XS5eFt9OwEIlMmH/kFu4LB1WzZRWKD0X88C5QLENZ+irtmj5RqA7IAav3cxbdgkOQGtxHJlOZA7z7OjSbY+uoucqSqIjMw7ufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRF7E6uSOraU5QhF8Mu08PTLmPhviVyZ7Yt1r2Niz08=;
 b=ihRyFrYT4VOsB9lr32ITQcgFsQ0/9m6l+x2SyuQ6VkwbMkXWQs8HUWJWIp6lV2gIKXN+LFxCh9qhAbvVWkJEBuHXRz1EE//ziAKJe04dw1f5c93j7B8h/9ECdXScLpodlbyIXpeW9sUYW1aa0b8jc51iiaUCf4pIO6S7mqU0Ev0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 08:44:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 08:44:07 +0000
Message-ID: <47b60bf0-e43e-43a6-b9d7-0d072cd8d4ad@amd.com>
Date: Thu, 31 Oct 2024 09:43:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
 <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
 <7dbcb2de-89f9-445b-a096-2a3d03a2dfe7@amd.com>
 <34d6acf1-2106-481e-a016-375e697f31cf@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <34d6acf1-2106-481e-a016-375e697f31cf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eec2318-4cb1-4bad-a965-08dcf9882e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXk5WTBjS25IbnBwQkZnOENwZzhTL1ZjakR3WnpnRmJocjJRVzhaN2tkYkRj?=
 =?utf-8?B?N2FxT2xVYVEvdTRSVWN0Q3g2VWNaUTRNZUhaR2hCMjQwVkFka1lZM2FpMldO?=
 =?utf-8?B?VC9xVHVCQ2xRbFU3K0NsUzhMOVhtUTVsRzRaZkFXS3Y1Q25zRitYRE40MzA1?=
 =?utf-8?B?K09KSkt5cnNUT1A0RUxObkk4UENUTnI0b1RzS0RycWRpVHgyRlhZSzBVNHBP?=
 =?utf-8?B?c0RJU1dIbjhUVnFYVTJlemdaNWh6eU9UWnB3QVFCT3RRbjZaWWhDbVdCV3Nl?=
 =?utf-8?B?UFJqdHNmMVJpcFh2SUc0eGVpNGtTdCtqRnBVUzN5SGJtSEJTeWRJYVhSYytV?=
 =?utf-8?B?OWVXb1pvTlJvbmNPdkU4OHE3QWlmYlhxL0Nvc2ZqditzYStGbm8vRzc5NjlN?=
 =?utf-8?B?eEtTekx3ZEVqY0NhN2dDRktOVlRsb1JKRnlJZnA0SEU5YU45OUJyZGg4MW1k?=
 =?utf-8?B?bjlpeitTREhsUjFvcnhTQS9yeURKV21qSUM2RWtrUFphNXlCOEhsR3o1VVdN?=
 =?utf-8?B?bTY0THUySnNCbkJvNkpUVFhxM3VqdTBTSUM0dWFVRzQxQUpMRXFqN1BwRnBP?=
 =?utf-8?B?K05oNVVCZDJqWTRiUktjQXRhNGNnTFFQQWk2TklKVDg0TmRZbEIzSDJ2MnhS?=
 =?utf-8?B?S08xUktTM1FVb3pSejhBYXV5YnN3d1pubTg1ZXF3SGFGWUlkK2dQRWVuNkVB?=
 =?utf-8?B?YVQwT2RscmV5NlU2NkxickN0Q0xiRTY2a3NWaDA1aGxQY2tOWVJRb3MrMGQ3?=
 =?utf-8?B?SXVicGl5aVZnVUNQbWhpQS8yUzBVZlMwT0Exd1FMQTY1WHovYm51UXpMbVZq?=
 =?utf-8?B?K1BKNWdWNXdLTzBOeVNIY1l1RFRMMXdSc2Q1ZWM0ejFtSlZQZnpPbU4vTmZj?=
 =?utf-8?B?RVNERmJOSVVjOUhUSDBjdXF0ZXdnUThKS2NuV2FuaGZ6NVRYNTJqeGxyU21Z?=
 =?utf-8?B?MHJRQnVKN0xvcC9kdGJLOUd3dDB1OHFCSWdpbEg0UzA0dG9iTlYvd1Jxd09w?=
 =?utf-8?B?OXQwOSsvUE1jYUJraHZBS045SEo3eU1LQ2VxVGJHTWFNVVF4MC9UOGxUQ1VI?=
 =?utf-8?B?NjhRRFFLMExSVFVBcnJ6QkxGN1VWbUxhNXB4QS9wNDRaaHVLV01Sd0dCa3pz?=
 =?utf-8?B?c0cwckJ6RS9FcXpOWjlzSVFPL280ZTNseUsrT1BIK3Vwc3QreVRTRnJLWVV2?=
 =?utf-8?B?VmtVZWlnR1lvc1lrOGVweWFwMU5La1FNeUtIL21ITXFtU0ZMOGtFRG1ZUnVq?=
 =?utf-8?B?Z3ZGKzRycGRsSEk3Z2YxSTlFTFNHTUc5YzArSGdzb2o4MlBRczFtYzFhd1ho?=
 =?utf-8?B?WTJJT1QrZlpyY08zbW04aWYyUU00QVpzcm1qUDZzYnBIZEFPYlVUOWgrL0xr?=
 =?utf-8?B?OVdhU1JzQkFtWG0xNFArYWZWVXlVNmlMZWpEMDBCQSswek1KcHVSL0JtbHI4?=
 =?utf-8?B?WEpYTUhiN2xyMEM1QVhhODhzMnYzMXNWbXVwdTNwRnpLUFZwd3NBYmN1U0Ju?=
 =?utf-8?B?QmdKd2RGNDJJWmZsdi84Nk1DSldUdkF1MjZmQ3k1dW9EWjFCTHhCKzluYWl5?=
 =?utf-8?B?ODZrT3hoSzYxWjBnVFNReXpJV1Bpb1NLQ0xwSlRaVmJQZ0hmREtYUms0b0Yx?=
 =?utf-8?B?VFBjZHRuR2ZqQ2ZQZjU2Zi9YRkt5QnYrdzdxU1UrRGdnSXc3a1RzRHVGOTN1?=
 =?utf-8?B?MWVvbWRhalJaS2pYMUJSeTg5Y2F3bElnVThPRmZMckVnb0l2OEFvaWlXQkx6?=
 =?utf-8?Q?0jsy1CpaYrWNc3EbG/5txeRekM5yJjqGAaE0Dge?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNnV25KNlZQZ0VWeWFkbWlkeE5lOE41blE2SGRsRHBYaWxyanFlL2tja1ZJ?=
 =?utf-8?B?Vm9yZ0J6RjR0WjFJYXBFQVZPcysrdFR3bExuamRsa3VmaFlGS1FXdXB5STJi?=
 =?utf-8?B?Wk1EWXY3TVd0bmZjbUNNcWJKbnAwVXhxV0d1MEwwbURaa0JmVmNCRC95dmpV?=
 =?utf-8?B?ckYzL0libjA5c0FGQ2lEOWN5ZFkxb3grNzV6Z240K0NxUGFybnBRKzhiUkNs?=
 =?utf-8?B?SFNic3J2YkM3NzAyRzVlTHVBTW1Hb2x4L3F3RDc4dzhYaUtzNWNOTWdVRjU1?=
 =?utf-8?B?QUlWQzV1dHhDUGUxK2tqNC8veDhoaVhYcDZpdjVkVGMxSVJERUlIN05hR2RD?=
 =?utf-8?B?ZVFyRllDUEl5RUQvaUNWY0t4WnhKRTB0UVo4cHRLMm4wQVNQWXArUXlSeEth?=
 =?utf-8?B?OFc1VVI0TjJMRjRJUUFRS3ZLRzZpZjJGNWlqanJPOWU2dzRCWmExa0VwVkJM?=
 =?utf-8?B?S0EyVmVORlJycWl2KytOckQyOE81VGhnL2FxdHJxcU1wL1hmQ0NyZlVRMXFa?=
 =?utf-8?B?Z0N3YmZLL2dtUmFkK09YaXU4KzZOeW05YkxiOE94SXExWUNRb1dNRGNwWUZQ?=
 =?utf-8?B?RzZzV1Vyd2NuVzF3ajZkMlZZQmswK3FrbVhzd1R5MHB0Zk9vTmFMU0habFR0?=
 =?utf-8?B?L1BuaDNVZTQxSndjaG1GUFBJdGwwRGJxQkZDZ3EwN2ttV1dmSk96UUNabjlj?=
 =?utf-8?B?L043NUMvTlA1OGNCcmRFS3ZUZFVZUWZvS1RKWWJxZXgwVWJuN01lYmtLMEFr?=
 =?utf-8?B?TUxMdjVSUVN2amJObWVPV1pZWGVCN3BsUHVzcmNlSGxKamlUV1pKMGJpZCsr?=
 =?utf-8?B?azB4QUJSS20rWGRzaklYd3E5R2J5RjJabkpnK1ZBck10ZmJ2MnQwRlZ3bkVQ?=
 =?utf-8?B?eWtWbWZLQU16WjZVb0d4VVRBWE5WNE5SWVFyZXBmamdWeXF4MllIdUh6cE9M?=
 =?utf-8?B?OGd6QkRyTEZhR3lrZE1OcC9sY1pBMHJZU1ZGaFlEMWNQd2FiYUUyU0xHZUFl?=
 =?utf-8?B?N3NZSmdzSW9tWE5iQzFhRVBOeldGRWptcjBQWVVHdnRPR2kvUHhpWXZFZkdw?=
 =?utf-8?B?cDhwU0plckZqVElMT0EyQWE3NzRYWk90bDY1Nkw4dk1mRURtMzk2VXJqMXBR?=
 =?utf-8?B?TFdSckFyOXJNT2xtQUJKSnppUVUwb0w5N2Q2RnhsMTJ3amU5VndqMU5oNnBC?=
 =?utf-8?B?eXljWE0wRk1PWTlCV2ZEYXlUNmwwV2RnU2NBeERMenFDcmQ2SVh5VytHSnNH?=
 =?utf-8?B?YXk5NXRBek5nb0RmRGNsYzczUU9nQVlWcGpNOTh2V2UyMW5LSkRROHBZNXE1?=
 =?utf-8?B?aGZHc1JnUXM2eEo5dytwVEhNZU50bTBDNjQvOEl2clUrVlF0VUhkSXZ2cmpq?=
 =?utf-8?B?STc1TGtDQzJMcGFHdk5wdnNzLzNPa21tOXZHM3EwN3k1dWxVTGdyR3p1b3Fa?=
 =?utf-8?B?ZlRqRTY5K05zQUxheURDNUNLMjhZdFkvRmNLVHBHSDhzNkdzS2YrR2FaU1Zq?=
 =?utf-8?B?ZmJndmNkR0dsUzBGSlFYQks1NjF3S2JML1BlVWNQMG1Sb0toWmhkTGF5YlJK?=
 =?utf-8?B?ay8ya3FLampTV05OdzVZVk5CTXlKSDF5WXBMeDJHU3ZvZUY0cjJCZXdIazFL?=
 =?utf-8?B?eU5aTjRYUGZQYkJYUlhaN0xwZGlldUlJcHRIRXBRVldVckxTSTNwbVByLyt0?=
 =?utf-8?B?UlpQYjlaamdIemREMGtQdi93U2gwUU50RWNONDVtOW9kMmU0RHlkOGFWWndi?=
 =?utf-8?B?akppSGF4UzhSR3pNMzlaY3d2WENaUVYzajBkV21ZVkM5VXk1WGl5RytwYUVq?=
 =?utf-8?B?aXlPZHpJdEhmSDJRQVFDOXdxaVlSL1JtcTM5MmNKVDRONmZmN3NMbkJwTytK?=
 =?utf-8?B?TUVpeFd3clBtMXloanJTUnUzRWVQdHNBSDhnYno3TmQvMjh5N1F2MzU1RHQ3?=
 =?utf-8?B?RlhWY2tCYllFeEpyQ1dQWlE4dnVLK3RVd0pxS2FYN0hHK3NRVCs5bjBvbzlN?=
 =?utf-8?B?eTNYMTY3ekh6aytRVWJ3SXFZNVlYZG5xeHkwNFp4TFhwenZVKzBsbnQwbEFp?=
 =?utf-8?B?bG5ieTZ4Zm5zbmN4TUF0cnlveEhvaTRJY1VMU3BiRmVrMjRRd2hMQWt6eDIw?=
 =?utf-8?Q?X78tf5pTGkblSao+Jyn1h8hr/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eec2318-4cb1-4bad-a965-08dcf9882e74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 08:44:07.2654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GARenO7Q/nLnW49g0zxYyS0YfBOu5sM4FQKnjS0eDidlkyq90WhAAP2bZ2vGQnND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
Received-SPF: permerror client-ip=2a01:111:f403:2416::621;
 envelope-from=michal.simek@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 10/31/24 05:06, Philippe Mathieu-Daudé wrote:
> Hi Michal,
> 
> On 30/10/24 02:53, Michal Simek wrote:
>> Hi Alistair,
>>
>> On 10/30/24 03:54, Alistair Francis wrote:
>>> On Thu, Oct 17, 2024 at 5:26 PM Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>>
>>>> diff --git a/hw/riscv/microblaze-v-virt.c b/hw/riscv/microblaze-v-virt.c
>>>> new file mode 100644
>>>> index 00000000000..6603e6d6b06
>>>> --- /dev/null
>>>> +++ b/hw/riscv/microblaze-v-virt.c
>>>> @@ -0,0 +1,181 @@
>>>> +/*
>>>> + * QEMU model of Microblaze V (32bit version)
> 
> Is there a 64-bit model planned?

This guide is talking about 64bit too
https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide

It means answer is yes. And pretty much this generic model with the same layout 
should be possible to use with generic 64bit version too.

I expect that means that default_cpu_type should be TYPE_RISCV_CPU_BASE.
and Kconfig should be extended
+    depends on RISCV32 || RISCV64

Also some small updates in documentation to cover it.

Is there something else what should be updated?

Thanks,
Michal


