Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12997C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDeH-0008Ga-Cw; Wed, 26 Aug 2026 09:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wzDeF-0008GE-Dg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:26:35 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wzDeD-00035G-LP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:26:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYrTXSOyfJ5usM8CoCCCP9TwfCvPZn1a2wvuXWjqYqT5at5xIyEOMOtv0HELyd4zKx3fF+YFvdPS8QJ5GIIM6DoFGdzBZqYv77FoBco0tKvSRubYpcJkC1xxbhQ4CnBwAGlYbC2xk0JJQjJzsi+A4fFAGp4OXiLHze1dq0+2pLX2cWmp/GhZ6zGOfJgIBOQs33a72DsHh6vV4/gpXNr0Hd5r52TGABLW1dOqi+OrhXMiLm5vHZNub9LRBbA0xY9UHxuxXk3uO2st+vlwKgyABYYP3FEq/kzC4BN8ujbgdyvvS9yNvoyZfXKbPQ4mH0JAy5IywWzDA7ASwQyg/MCorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckc+6EPJ/+lO9eAbr+7DZhIwfItUKsl6wQUCP8AM20o=;
 b=UtmqfTYZRvJBOA4yZD70+h4++rHHHUdqOIiSNGBXU5jPly+NQf0jK2DsOH5opbaPZ7y5BdwXb5FQ62kmB4HzIUKCobOPD1EpIZ0rtTOUt88HS74LJ04ulteg86Qall8ir2yQl+U2wq+821HEefV3HsAOdY6dhkv51fdcMXtM5OUrB+1W/JOhfo4UrYnbOtkE/MnkfNbWUl+Ow+GvGf+7A9V+9Q89RNhLDTZzCWqt1d8Nvrh0FI3oT7j2Iv70EsDeTrY6ipIVhrtFQQoPbWFwG1DdlRtmhJzkUPLGYEmYUY6dgC2KmQBBYN/3fW0hI5gEsjbtLqDhN0QH8h8JzAgSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckc+6EPJ/+lO9eAbr+7DZhIwfItUKsl6wQUCP8AM20o=;
 b=JZMPFp8eAeD0Zox1d9+vzYlxhn2EYPPBOxizAmsoBLQPeyGKl5NN0EaP8V5CdVbHEF/wZiZ6+ymvG/wKIefyg21PGBfS5Kr0Ptt/VqIDZTBkV0m5uY8khIRIpKTkZTx6P1RuleHHAnHHROmB39R/Ucztg2dlja1VUsQh8TvYe1g1w4K2YSV+U7L5C4ii9tEy/WzIdpa337khvndmrv16MYQcmj7kxGcRh+iFF+kWwxVm9oyyseEHsdIq3uVt7ert6/5XfPLzfU3hbZQJ9zzUvQDdBKGazbHVQpkcbynr5BiZgPWLb6B1n6wHq+vWOWwcx9lA2Fmfq9dynXS9n4K43A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB9659.eurprd08.prod.outlook.com (2603:10a6:10:45e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 13:26:29 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.004; Wed, 26 Aug 2026
 13:26:27 +0000
Message-ID: <adf69f78-6fbb-4b77-a1cf-e652e906cdc8@virtuozzo.com>
Date: Wed, 26 Aug 2026 15:26:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/display/qxl: Avoid crashing on stale guest
 addresses in qxl_post_load
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, den@openvz.org
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
 <CAJ+F1CKwNr=6wVaO+tXa876EzoPjYfQC3qx=em3C4BSW7wRC8Q@mail.gmail.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAJ+F1CKwNr=6wVaO+tXa876EzoPjYfQC3qx=em3C4BSW7wRC8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f0b326-65b0-4592-2a22-08df0375a18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|3023799007|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bWXm4XQb4eXT4JFJANrEphmNbYeLrA0Va/Wo1wZ0QJsTWEyYP12VPnTlRFyUvyAMecYNWhwBpYO+3/e2kL5F7LnhI29cfAvVoz3tlcOMyRoxSLfVcviBRaoUylYg8wDW8yZ+oISNxJYYc2xk1ziUcauVDxToGKANdqNOXhwBsXUhqy98C0SpV85+YaBpFbUtwNC/QNFbrsJcayITu8hik0z4DuflQiVAvdbhdZ1PqRDRvNzn/hW4VKD5WUsfeDx9CCN0EjlQovbHk2Tpwlq2Fea/PWGnh5Q59ZdkiqBtVv4URFDuToRTVSERSMdw7+tlzRoWTdDpcEIMlrV2CjcWY7lAB3GlLH7H+S7pN+d1oIjIbkaqMQEG3SWNVWCGVcVIDQ00ZdX0JFJBhd7BYLiT5LEInmlUueyHdzXD/CnU6SqUsuvApqMztXcIFWqQxM5iAYKXx9XT9xg3Rn3OsDQftiBWNt7JxGMUBBxuCCLpqaCUHcvKgrhAb747eX1GvlRfPZbGa/TCR9crn27NjUIfsV+QalmW3Cw2M/grAHn+pyUpuVq1eD/flH3JjCOz/Lv13J1sIrvIteO/xtCKLWFJ0pCV34hfwpoQ6WLpPkXyyhiPuWIh2GhoxYAgG4ZYwXpkbSNUMQlvgDHx6FJcLTBaixFjUKGIbZLsv/b4LaHOwY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxsUnFBTmJrRTJPL2l3cFdBdWUyS2JCL3dsRFhUc0QyUnVZNXN3TWFiVzd4?=
 =?utf-8?B?TysrUE43NVJ6OXMyV1hPNHIwdURaNzdRNHlNMkNzSmpOUmFFZmU3RDVTKzlM?=
 =?utf-8?B?RVJkRi9oSUs5VDU0YjBRMzZ6R0JJY1pVRjg4MHN3eDI3cStTN3hvOTV4RjRP?=
 =?utf-8?B?Y3hJeXJYRld0eU5DUnV4bEN0RE9XZGF0N3I3bHY0K0pScHhSL01rdHMyOFB3?=
 =?utf-8?B?TG1RanhweEl5SEpIVHp6Vzl4MEVFeE1UOUoyMDVZeC9FdUg5UVlPbFVrUXlR?=
 =?utf-8?B?WDUwY2VhdDV2ZFVRL1hUKzRQZEYrRmhyQ3ZXRk1KOXh0SURGQzkySG56MlVy?=
 =?utf-8?B?SnlEemM2N0JEWWRqRStZczhuNHJpRVVOaU9lSHNGWnUrdEZZVXR6M2ROaG04?=
 =?utf-8?B?VXdhUkxKL1l3ZC9DYys2d1lKWWhwOEVQc1NGL1lMRmdwOVNWSTlndjdHbEpU?=
 =?utf-8?B?RktQeElSM2doRmEwL1lqSk9UbVhoMnc3Zm93RGcvQTZDWFcycnVacWVKcFJz?=
 =?utf-8?B?bHp2TXdJS1o2NHgvU3dsSHYza2VGOURiRzY1VWpFRWlwMzF2dVNleXdxN2kv?=
 =?utf-8?B?NTBES1N1UER0SUVMaXMvb3Z2N00xWlkydlJmWnBMMEFyT2Nhbm1qcUJ2cEdp?=
 =?utf-8?B?U3FjUXA2Y04xdVZYWUFmcCtOcnIyVXZxcHRIZUZCTmZtb2tEa1NMR2NkNmkw?=
 =?utf-8?B?WlUvQW5JOE9ySVZXVXFyVGdXczI2eVVaTUNSZE8wWk1sZTdPMHM1Q3FQZjU0?=
 =?utf-8?B?NDRmQmhzU2xsaG5UMnF3UGlubmNoNmh5QXljbFIyZkVVcW5qVXBLaUJVOEQr?=
 =?utf-8?B?R2EydGNCUlc0RDVkVnFOZXYwZTFpT0pVZ1dHeDNmQ2pGUm1UbHVXOXV0U3BP?=
 =?utf-8?B?bHZ4MnZYWGpZUURyUk1qNTdHTGhiZEYxV2ZrdThZODYwQmYvL2F1M1dwWjlj?=
 =?utf-8?B?cUdYTExpR0FwM0VJbTd1eCtWc0RHaHlnMDRHVzRvYzdIajdxUWt5NmhQV0tl?=
 =?utf-8?B?L2ZVYUxiWmhXNHNCaCtDT1Q5NFRmS0dRZkNFU2owbDZhaWlpYmRaNnFUYkxm?=
 =?utf-8?B?OG8rYW5xcERKSVl0cFZiZnQ0bGp4cVQxRUdRZVdEeWhpSW5yTUNNbHRJZU1n?=
 =?utf-8?B?MU11ZmVBNUxFTHJDVGpjdlhRVHNjZVcyVkh5Zy9abDNZS0tJazQyQXpKdkVG?=
 =?utf-8?B?VUFEWVpLTFN1cmZTWlUyY1llQmt4VkIrK3ZmY2lZc3N5K2xROUZJMjB2TGl3?=
 =?utf-8?B?OFQ4VEJicTJBSGhMNk9aalkraDU4TDRXM0pBQk1kRklwV0t5UDN0R0hjQnJ4?=
 =?utf-8?B?NmkwWTlwcHNpQmdqZW9kdEVzZThGSkdKNGYrMVM3ZXhraWt3Z3JJdDBac3Rl?=
 =?utf-8?B?cFJxYlM0S0cwMzBIYTllTW83SXg1c3MybFkxcnNVNEtXa1RTcDJzSitHQ0hV?=
 =?utf-8?B?cUFnQllLSlpxQUwxQU56cVJ5T1FTT0lhZ29JSDUwR3JXL21JMW1waVN6Mnc5?=
 =?utf-8?B?S2R1a0VjRHE5RFdwajlMVXlYcnJHaUxYaExGQU0yQ1BmVm9sYjc2Tyt2OXdF?=
 =?utf-8?B?dUwrWERYNHZtNlh6VjR0cXF5VzJrNjkwYldzSnZWeGNPNG0yN1p4dlpKQTd5?=
 =?utf-8?B?WFpKalUzMGNKOVZFWXVTOHpLYTFwcXRDSE1YKzFrMFR6RzBROWJLdXppSm9U?=
 =?utf-8?B?R3Q2TnFKajdHSGU3bURpNmtkMnBPYzZtaVl6MzNTajZiZ21ucVJEejI1S2pS?=
 =?utf-8?B?WTdHMStuajZHdTB6R2lUK0h0ZU9rWHpsSUhvd0Q0enJZWjZvVERjKzlqenpt?=
 =?utf-8?B?WFgwYlk4ZmNKZVFZWHhhWlU0bjluaW4wSVNxMDB3bUhJWTBuSGltSWNObFJ0?=
 =?utf-8?B?QXpXZHJHMnJMbHNJeHZadGZKaFhSYnhRcXM2WXQwMzlOWHhSYlJaVThqL3hU?=
 =?utf-8?B?TUpJUmxyN0twa2ZPR1I3RG92TnFnMFROWlgzZGhQdHJQczdKcmg0WFY2eC9K?=
 =?utf-8?B?UXlKWWYybFFpNXI5Z0tpdTIwTDdseEVKOWtCRXJLYVA1NHQzOFYzRDBGZ2VX?=
 =?utf-8?B?ZWpLTW5MbzA4Nkc0U2VhUUplQWVNaDRFQ0xHM2pWZEI0dWFNRTNwQ1JqdFpk?=
 =?utf-8?B?bzN1T3VaMkhvczZUMjF6ekJxYlZQMSttMnFNdXA1L1c2VjZkaDJIelBwVlNL?=
 =?utf-8?B?THJKNGI3TDI2eWxLcnhHM1hxWU53NEM0WHFtTS9aZ0dNSzB5bGtMandBZE5t?=
 =?utf-8?B?WkNISmJRQ09kdzJ1eVJDYXZnQWtoTFVVcytXTGlvVUFFTm1vSExNanBtWC9F?=
 =?utf-8?B?ei9qNHRvSEJyNHNCSm9kdWV2NVp4T3BTY2hucjFKMEFkcXFDZjZsZzRIOXVX?=
 =?utf-8?Q?6vBwAqHmzEstlS74m44n8/IGoKK5T2/sqrMPr6bwiFpyY?=
X-MS-Exchange-AntiSpam-MessageData-1: QYHpyz19yz1MXg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f0b326-65b0-4592-2a22-08df0375a18a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:26:27.9105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRvm3uMeUtYLFAnSVD/KL/aHSzKMGTKlksyC8i1kmvS5c0FwDm28Yj6xS5WxiaF1dK82nlO+uwuBKD4+H1o2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9659
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 8/26/26 10:10, Marc-André Lureau wrote:
> Hi Andrey
>
> On Tue, Aug 25, 2026 at 9:26 PM Andrey Drobyshev
> <andrey.drobyshev@virtuozzo.com> wrote:
>> We've experienced crashes when spice-server aborts on migration target
>> when processing an invalid/stale guest address pointer.  While those are
>> hard to reproduce, it seems they can be fairly easily avoided by simply
>> skipping commands with invalid addresses in qxl_post_load.
> I would rather try to find the root cause, rather than applying a
> post-load workaround. It may be related to this issue
> https://gitlab.com/qemu-project/qemu/-/work_items/3766 (confidential):
> there is a lack of resource tracking, when a guest release
> slot/cursors etc, the track commands may not be correctly updated - or
> preventing resource release. Unfortunately, spice/qxl is no longer
> maintained - we should clearly mark this device as unsecure imho.

Unfortunately we do not have access to this item in gitlab.
Can you grant it at least to den@openvz.org?

Den

