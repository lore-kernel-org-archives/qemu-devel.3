Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85983C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgw2-0007fU-Jp; Sun, 16 Aug 2026 15:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wvgw0-0007fI-4U; Sun, 16 Aug 2026 15:54:20 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wvgvy-0001NH-Kf; Sun, 16 Aug 2026 15:54:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0qQgrh2bmk167E6CysRmQbwCap+CZU2pzE0oJHhPNZR71DSQ5cs8jxazPmhOpkPGu7LczV4kPkKC7zuMSidOj8HqwOajULRv+PdyP/9kkpwQ/OWMAcEfp8BWWU6nKbwJDmKdbKvdZtJbmUHsnwZohkQZebsHEExUSpti093A+Sj/aWJX4qqAVEM716EiJZbCUM6kKR+NJ7GvlryXq3tSIFbCIAniU2T1RZ6D/rcPFWjqaP9RzeiFdqoQ01gxt23ZeIOntPsBWqjM2P4U/RJ164QGYQMzOly4meLMTpkz1IX7e4ukCiPetNdTbDXNEMsqfFr7YgVDcP0ymGZ6saeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrfMC3i4iKYyECHZmBWjxqoircJekmRSec7E4i4O12c=;
 b=DGrOu2IZAYjJEWBsWhsSgxIvX6gS11hk8otYkX8+lgP2Vzkze7HWJeeCNqWa6LaYjA0f+o7KdCanYMjjT/oA9x7os/mrbTdLLIxG87d2gy7MG+ps7MLptuii6+HKXgIZr5BFy0xy6HiG6JLBmZtwqpyWr5X3jx13/VCOiCFLMEMmMvBvSk3T2CgHuvUUyFEkZASngRoU5selmhYY9ag9UHUGajHMV4/AH+aNPb5Ia0rPvLHAtmLB/szxUmxlT95rdZ0z2ewwAvSviv82Ylm6Ige8QJ6rW6vOKNELbG5q5Deb0+VYGfqF1cVjKTpJzQQ6+TuLpDdgl+lye3TRabrk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrfMC3i4iKYyECHZmBWjxqoircJekmRSec7E4i4O12c=;
 b=mwWZmIIUQBwSXrrpT50KzPt0vubCcvNHReVYiAQNIXCC2jueaoIyO0TVsX6x6XFbzc1TdpBvjkwEcshCCynYDNN6h63tR4tVksrQhpZH0BAQFbfQBrblJlltO3N2D/7B0BCZD4qWH+QMD3ZxBsGXysp60lMIAzntlJQtfbJiaQfO9KsQlyNMnJ/H1I2BERyba+hiCyenL/rydJF/8Zvtj9DRzg38+q7um+I27dCfZNUVavghOHQgBpZXOaqv1VknN1pgNbwcQfcBIY7EpLeWpLJQ3/oPUCPzzfocnqVfGaJWPcEONvkqSmwpqzlaXqHISP0h+KQ+80JphyxYc78lXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AMBPR08MB532816.eurprd08.prod.outlook.com (2603:10a6:20b:788::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 19:54:15 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 19:54:15 +0000
Message-ID: <6e9a480e-4926-4c11-9323-9104c4576d89@virtuozzo.com>
Date: Sun, 16 Aug 2026 21:54:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/49] qtest/ide-test: convert to use qtest qemu-io
 command
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-23-e53fc35bc550@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-23-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI4PEPF00000138.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::897) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AMBPR08MB532816:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d15ac51-7bac-49dc-372b-08defbd02667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TazQFdK5+bNxsqQv8S/T/oMcoMpCR2hWXYBXxwjXEtorFK2P279YbURwpI2yXEgoIfWRu1qb3B538wyedEKDG8R540tp5r49dePbiaKOGh55plw6891JIdOHXbq2khsGBt9/s5AvhggG25GNYgTHkrfyFe0m2tdsLLI5pr58iVs6897aWcr135iArZPEFk89nZch34N6Ij8yyswpcpH2WIZdeD6hPXn9mNH/dhP9CUfQZDUvLWTwjkqpFC25r3yywvyZ0xeI6OKgjV66pGc8THpYOiRYpwFWci17rVkS9vAT25lnlBNk8d9HqHBXQeZq/LqAg7Wuec5J6FtJx6kf/Cq9X02d+aTefFfMRhQEDK9I23q4fbbNIhyRH6BB7fPvOlMplqdq6RZLSRW0ux/4s+tTUge9mTMFVYA1z5tyEkVGtGhZ62oYMQmcWxK6vrTyNL3A+TZ6kbZNQRznZi/nvufe/nKvr/Dkn8VMuUsaOr7cO+yi79nUA0kYzVF3ceAN0tGgUEhVVOxe3+kNhYmBDA3XqI48Fnfim723JDO56EJa8ZuVDKp6MUPAKmTcQjePR0sLCE4cn3CiIWi2yq/iffiv/AnrrevGh/G63ZSDYYxW7b73Uwbbh1sK/BMFg833mBjSBZ6D/ce/YdqiCbuBRc59kXAe+zQHYoiSy6THuoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5MZ3B3K1IvOW56LzBaa1owSzExanV1b01DTitsMlQrTjFHOXl6SytrOG03?=
 =?utf-8?B?NEdTZEVIbkd4TWdQVkdiS0dPazNWcDYySUtWZ3I5anQ0NVZNZHlra0ZhZWF6?=
 =?utf-8?B?VmlRR0phU0d5RFp2bkxseXdvZkVUQTRjK0dHVnB2U0FRaXZwd0hodkJEZmho?=
 =?utf-8?B?TkZ5TXNZOTNlV2xTN3dsOEtOU3I3RGluU3pMVmFXZ1FoT0paUmF4RzFCRXU5?=
 =?utf-8?B?OUw0djJ6ZFhRNnpPVjhwK2krZ2NpMGRYUU5HQVJtamM1b2VGS2Q4d1kwckRx?=
 =?utf-8?B?anJLby8zdnZDYkRkU0d1eCtXQ1FMQ0VXQ3F5b0V2clp5amdYOUwxSzVEVG8z?=
 =?utf-8?B?dFE5OWU1N2hjTk5FRzRtTzZ0dXJ4OC83UGorc2VtQmJKSGRhVHJuL0g1eXhS?=
 =?utf-8?B?QXF2OVM1TGtaczd6SHR3Wk5aZjFiY2pnQnFKQVBwZXlhNjRLRWJsdFo1bEY5?=
 =?utf-8?B?Mk9zQXJnbzN1RkkwVVdLOVdpRFlUTXJ2U1hUNFVyOFJ1a2RqbGNESFZLekZo?=
 =?utf-8?B?SUFiUTh2Z2pvYkk5eG5xcEEzWThUdlJnMU0rNFVibWhqOG1EZDl2aERCL2ps?=
 =?utf-8?B?eFdySUp1NlVOK2RKQVBNU25sSDdRZlo4alBBMTMxVXc5d3NlZ09mdUEyTkFv?=
 =?utf-8?B?QWxDdm9FV3JmUWJqMHM3OFB0MjBlL1pKdFhUczRKZjNldkpmUGtKQVlHLzJR?=
 =?utf-8?B?N0NyQVZBOUxzMFFJRnpPb1lQMDR6Ly9yTzJPN0lDMXVCZkJSZ21EUXp2cHRI?=
 =?utf-8?B?L2doUmR1TG02TDI1RUhWbWM5bGszY3BmR1NWcktvWWpITzY4TzVNWTBENUFW?=
 =?utf-8?B?QW5pZkVYT2ZnQXVvcXpNMENGNE1UWXdSbVdGNml0TFI5SDMxekRmN1NYTGlO?=
 =?utf-8?B?OG02dVREVkFHRmFnbkR6N1BpK2FUd3ZTNlR2UnJIMTRMT0h0ZllaMjdOM011?=
 =?utf-8?B?MXRxTmlneTl3Y2cvM3ZnVXBDcjBlUmRPaFRTdjBOM25RZzI3Y1VkdjJuK3pX?=
 =?utf-8?B?ZkdXSldVMU44NHd6dHZNUjE5N1AwTTJSUXJWU1Q0TSt3bXRDc3lMazVaNzd4?=
 =?utf-8?B?UzBPcXNCa3RTY1VHTkRkZktNLytheUlDYmNQWGdXVjl3b3lVY2J6UjRNckdj?=
 =?utf-8?B?dWlDbUdySWRqZ1FwN28wT2wxalhkbllldWtZM0lDd3BaaldkWEtXVnVrZHRn?=
 =?utf-8?B?Vk9iRnVVNzBVMXZpNlUyVHFlWmVaKzRXR3N5UldGQWE3WDhnYWk3YnY3WU5V?=
 =?utf-8?B?WjJYbGJ1cFVlZEtrZFZndHc1NDROb3l5dUxjUGNOOGlibEx5MEViSnhtc3NK?=
 =?utf-8?B?VHc2Tys4cGZ6d2h1RnMvbHNma2pHNHpxUmR0R013TWc0NUNmR3FuLy9rMjVW?=
 =?utf-8?B?YUlmTEw3RVR5cnZEUW9RczBkSkZyUEJjcktTL01NaEJnbWs1T09ZdGRMclZJ?=
 =?utf-8?B?ZnZ2SFRzam9naHhBWE1qV1o1R2xUVkZCUEEyNmxrUWtyaFVVWGtZQjRNQ3lR?=
 =?utf-8?B?cGR5ZWRiVWozQVl4U253Mk5wdGJmc056N3R6MVVBY0gzNHB3R2psUC9lYlFa?=
 =?utf-8?B?V0hsM2N3bGkvRFlIOXBwNmJaMW05ZFlNSUN5VTNZSy9rRGViRjdyV1FsbjlM?=
 =?utf-8?B?NTBzbDJZd0hhL05Vclp4YXpSeGRmOUthUFN2anVBTnA4eXdzRVZWOXFHV2VQ?=
 =?utf-8?B?Rkk5Q0VGUnY2UTIyOEhRb1FJOWVCaWl5ZjNXdUNMbzlSdEhZSWZ6endCQnRG?=
 =?utf-8?B?KzZzd3B6MGRKMlNCUktCMFBCMEhienUrWnFHUXpkcG9TTU9KTjd1eU5QNjlS?=
 =?utf-8?B?YUx0RGxscHZBKytOZGV1aE9NSThUSVc1MkMrU2plZGYxdGlweW5hVU1EU3Z6?=
 =?utf-8?B?YlFEYzl1T0ZRa2lWWWJBMUFlTXFTQlhjTmdLVmt1a3BxNWUrOWpFMXR1aFZQ?=
 =?utf-8?B?c3h1MjlGY0lxTXEzcTV5akpDUU5OOHpzYkpHT1pHNlMwNzYxcTB4TWRUWGVa?=
 =?utf-8?B?dit4NU5xNWJCQjY5ZHdlNnUxUTFPcTBGaVlCb2h2N2srTXJpSkp3SVNNanpO?=
 =?utf-8?B?NEUwQ2tQbms2QnVqS2c0QVV6ZVJ5YjZyVWEvL0Mzd2paV0JoWTk3SlBMQ1g5?=
 =?utf-8?B?MllrYmVQN1N5aWF5LzJaN3pFU3JrOG5UQjNPNVowRmVPR1llQzBhRWJjNlR5?=
 =?utf-8?B?bzNQcm9NRC8yVCs2TUY3a2Y5YXF0dG1hcEszNGIzV1FZS0hnVnFuRlRvWnRS?=
 =?utf-8?B?Qm1XMzBTd2NsSDRCS2FOYjJGVEwxMUhQVnBSd0NNNUZVNkcxUUFrYzRZOE9q?=
 =?utf-8?B?VWVRY3IwY0IwbjJodHVTeHlpblhMbGZkeVVWejJuK3dnUzVQVTIwWU83a0N1?=
 =?utf-8?Q?gQeUR/+hC9q+yaG2Ov8ZO2vEZSA9qfU6CuTjn?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d15ac51-7bac-49dc-372b-08defbd02667
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 19:54:15.0049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkaP5s5sTuqGY7ldoVR7rU2lB9ry4SqrM5hz3O+Gv/qYUtiY4fWMz3Klapb/l7eH/80/+zEtISFSQYzbrCGvFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB532816
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 8/16/26 21:12, Marc-André Lureau wrote:
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/ahci-test.c | 5 ++---
>  tests/qtest/ide-test.c  | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index 71d23fe56af7..0528a422fafc 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1719,8 +1719,7 @@ static void test_atapi_engine_restart_in_flight(bool dma)
>      qtest_memset(ahci->parent->qts, buffer, 0x00, ATAPI_SECTOR_SIZE);
>  
>      /* Suspend the next backend read so the ATAPI read stays in flight. */
> -    g_free(qtest_hmp(ahci->parent->qts,
> -                     "qemu-io drive0 \"break read_aio rd\""));
> +    qtest_qemu_io(ahci->parent->qts, "drive0", "break read_aio rd");
>  
>      cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, ATAPI_SECTOR_SIZE,
>                                      dma);
> @@ -1732,7 +1731,7 @@ static void test_atapi_engine_restart_in_flight(bool dma)
>      ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
>      ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
>  
> -    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume rd\""));
> +    qtest_qemu_io(ahci->parent->qts, "drive0", "resume rd");
>  
>      /* Round-trip through the device to confirm qemu is still alive. */
>      ahci_px_rreg(ahci, port, AHCI_PX_TFD);
> diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
> index b36b0f8875b2..31692f6925ac 100644
> --- a/tests/qtest/ide-test.c
> +++ b/tests/qtest/ide-test.c
> @@ -836,7 +836,7 @@ static void test_flush(void)
>      make_dirty(qts, 0);
>  
>      /* Delay the completion of the flush request until we explicitly do it */
> -    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"break flush_to_os A\""));
> +    qtest_qemu_io(qts, "ide0-hd0", "break flush_to_os A");
>  
>      /* FLUSH CACHE command on device 0*/
>      qpci_io_writeb(dev, ide_bar, reg_device, 0);
> @@ -848,7 +848,7 @@ static void test_flush(void)
>      assert_bit_clear(data, DF | ERR | DRQ);
>  
>      /* Complete the command */
> -    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"resume A\""));
> +    qtest_qemu_io(qts, "ide0-hd0", "resume A");
>  
>      /* Check registers */
>      data = qpci_io_readb(dev, ide_bar, reg_device);
>
Reviewed-by: Denis V. Lunev <den@openvz.org>

