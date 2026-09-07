Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681CFC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3hLo-0006qM-W5; Mon, 07 Sep 2026 17:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3hLm-0006oH-KE; Mon, 07 Sep 2026 17:58:02 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3hLl-0004Hr-4f; Mon, 07 Sep 2026 17:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kqs42PbqFQzKDYtQykIFSsUdqb+ER9seSGVpZKiLDrP9S3U2RFpzngzOgb9gQYxNnS9d5+rJUgTJItWrKCfeFyEuLtlB9vXAHaYH/enhcMr6WWHkNwsv6vuxRhOzFwB15kY6QIlRqTNhSZk8h+KGcWGI32CZrbw7MFU13vLfb4LMD4LtqF0QWjGBXxTDIC98x8J1wKSR+PwtlS7EYG6sKJ8TTSIT8X3qt5NIby2LkHcIIL6ig1CMOWRDDeomG3seGr2XQjT/NOAsuxLK6elapRWP41JeRqJMMHM19zgk6jEfRhQZjjj5vkPO/42Y+hoklmxXigR1uicEEgN9yWB6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELHRXs+ol3SZpgXvTuHI4mEXcq/ObOJKzTz/FpqR6XY=;
 b=LUZR9JGcbtlFy5xMg0Ji2wMQNHG6Pv7XVuyHszkAEIrsH6pf0XQJS3DYZGdQhDfrOhP+O5Hx3tJdIzu492KqFJQgJ6uy4MoIhlnRNDiugCkBxzdKnogs0cmoeEMk2qbF/0q5YfRl3k+seoBwgM5B5P/Xc9qTWWayQYp5b5rZ4lRQLkDily44VVI6G45j2Z11Z4KwiTkx0iOs4eBYKHXwp3uZYBFGrpv5uy/V799O/0GGUsACqNeCfoBTV7UnrBOHOgytJCmf3h+sZcpYJYrafNk6XsN3R+7QNrVt4qwGKFjlOkUurOi0YDcVu3fT1P810qwhZF2MYdFSddVFnJSUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELHRXs+ol3SZpgXvTuHI4mEXcq/ObOJKzTz/FpqR6XY=;
 b=PWyI17pr9XdX4mgsutCHv7uCKV/BQLW9pvuvglPfg3xeaC/Ae7oMEuSpAVR3mhrhucHzFi9GR8D3FKbxldhbNtGRo0jTMfFSeyY0sQ96BQ8Tpuv1Qi1E0cXuEvcu05M0zFpmWnwuPwTuRm6MO9ykdPG/TCwBS6oBVDMPLwjlkEz3B+PnFLVqKIFSs1Aqgf2SCvSupNaZbONmg6NnxiQQSNb6zy1Lsz/7w7X3L8gtfUmLSHEqOiQaJDI9B/889NJu8DYffKOi+Beae8pH9cWAqO8LHj4Aaa1HM0iTdnvSVWTjVQl5hS5tPKqefOEhI2NyerdKhaEUIam2AXw91fYdGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DBAPR08MB5733.eurprd08.prod.outlook.com (2603:10a6:10:1b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 21:57:57 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 21:57:56 +0000
Message-ID: <41755b26-21af-4369-b016-1de00a314814@virtuozzo.com>
Date: Mon, 7 Sep 2026 23:57:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] tests/ahci-test: replace HMP usage with QMP
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
 <20260907-nohmp-v3-5-c11e7d0d3d7d@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260907-nohmp-v3-5-c11e7d0d3d7d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000221.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f7) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DBAPR08MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: d90fc362-749d-4a1a-12d6-08df0d2b134a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|7136999003|10067099003|4143699003|56012099006|18002099003|11062099010|22082099003;
X-Microsoft-Antispam-Message-Info: DSHOYY6D7Snns3R/jqHn2sB9nyzF2arZTrGmYF0OrBoamRsxVlNWhMboueP4zHoHgaOBFzTr+8GRigGHdKoZ4FcNBrX482WBEXL/P3z5toOTH6hV08kVhoA2krPpcOFch0z6OyUxP7WukKznn8a9D6GUhx2tiS4bIPepMIm3/t7Hmjz/1/eKcfX/ZxM+Zt2sPx+rxBbYzaP7onFGIJwYKjtaAmmh4Jn2Q+MMVGQ7fjj355J93tESeiW9NPYmG56gv5oPeGd7wIWLSNgmc8hoLJV7vqIwJ46zQPwOD4HwIQ4SnuSZQB63Jn6jzKOOO8gLMAJEFTcEmNzGtJHQ+Uq+x5aS+1YY9k0ZcUz1fb6eYS64oYBFY3SavsKeMWGb4PwjEbtPr38u4vMmLIVpGqCn/nD4J9zoLnd+WhgdWmuifNRhvJk5p+aO1KPhU6X7bWGhfX/4TJ/9/MyamQpEhfqoc9xdplWddAnaWwFRvNKuBaKNpWWT+Ej98p4pCt53h9xYP4oqhtY4Gw5/K3XB2ZxkuqQ7Bs8oe+mRsaBVYwfkVR32IPS/KQhB2fnssY+bgXr2b4skyFh3RQbZwKVTGTuAivTxC5v69cV4TLCbNh3YeytcD0A9Tey686Am6lbhKEO/nTiOgxLlmYlnL/ObKXHTbpjf+aXF+L+ROGuNERW9ZNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(7136999003)(10067099003)(4143699003)(56012099006)(18002099003)(11062099010)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRkRVhOSTBmaisvUDdNS1p6OWx2OStraS8ycEdmZ09LcWhpbXNOdkVkU0Ri?=
 =?utf-8?B?SnQ2b0o1dVNMTHd5MS9ZWng0Z1dLQUdYeDA4MDlmUElJdm5pMTlMY3hpZmFt?=
 =?utf-8?B?WTRKVE5qaXpta05lbFlTNTBEZmFqaVJoSkNIMzdkKzBCUEhmZ0VvcjE1UjN6?=
 =?utf-8?B?S0tCNkVYc3hJQmtiUFNJdFBlVGlIQ24xRWJYSFUyWlhCZUh1Zml5RnhWZk5L?=
 =?utf-8?B?QzlHT3Y4TWpDUDhrYlBhcHZYdGRjYnlRNndQM2tJUFVpVnhVVWQwYlE3TU1H?=
 =?utf-8?B?SllOZjNucTBSajRhVnFsV0RXbldRMEY4SkhaY0J2dXNEK0NzcUJ5MnJhSGpO?=
 =?utf-8?B?cTBBQS9BRisrYVlmdGVvZ1ZNTk83Vmx2cGlUbFlZeC9yT3FYd2lGNUNEU1Fw?=
 =?utf-8?B?cnRZR05QZG9BdGpCdmR5dlIva3hYbVpyNjFGZHNnN3Vtc1hLUXhHVWs5OHVW?=
 =?utf-8?B?VHFuOXl0b3JIV2lPS2I5VVVkV0FjWklZay85dHQwaXdiallrSm05c2NIYzJk?=
 =?utf-8?B?QVBaa2FTOWRBS1NkZFkvTFk1N1lEekwwOTZsakh6dStRbldXNlkvVHF4REJP?=
 =?utf-8?B?eHhrMTVzeWptdDFXeWtrZWZwaFB6UFoxZnRocHJPQllmcngzSEMwNTJEVHJq?=
 =?utf-8?B?K3ZMR2xTU0xXdFMyRVlxdmhXbjFPVkJwY0U4UitpSUtnQTA4MFl6cXVtYXM1?=
 =?utf-8?B?elpZMW5UWDV3cC9ZRUtCZ3BZRGFzZnJwNUdma3dJZ2ZyWmYxaVJvVFBRWkE5?=
 =?utf-8?B?c2tyQnk1b25ucmhHaTFHamdQTVV0QVdWSkdWSzRCOXU0OEpoekFibzJHMjNS?=
 =?utf-8?B?bXh6V21sd2Z2RTMyS0lZM3F3SW5mc3BsUXYrOCtCOEhpeUF2VUdXVVNWNWtp?=
 =?utf-8?B?NlViV0drUllQY2tBWTZNUFJxNDFuY1RLOVJ1bGhhU3RJUHVEdU5IdG5RaC9v?=
 =?utf-8?B?UktLVkN2RXhhTXlMY0thVTNCMzBzRFBCQnRtei9Sa0MvckxEWkZaZTZKbWRR?=
 =?utf-8?B?Q0lLUStPODdMempDSTVmQS9IQjVEUk8yZ2tMNVFtZUFwQVNDb1hRWmJqVEVL?=
 =?utf-8?B?SERDcGFTMWF0QlNaWnVnRUY2ZlhubGRzZWc2ZUs5M3lzaFpBOFdWRmxXUzlw?=
 =?utf-8?B?SUNYM0NlUHltU1FDOHFvdlVyZ3JDMGdjbERkMjZUVDhBMGx0TWJpSGtSZ0hj?=
 =?utf-8?B?WFQ3eEVJZnViQlhFRXBFZkpOaVgvYVhqRHZqMWdwM21vanVmNTY3djhnbWc3?=
 =?utf-8?B?bFUveVpjY1A5QW5CSXdaOEdjdElHaEJmeENNVThrKzZHOXNkSzVGM3VMYWcv?=
 =?utf-8?B?K01JZzIvYWZPVXlERGZ5ZFVLcitRVitoMEVlc3FPR05rZXZKK0YwdXBOTTJS?=
 =?utf-8?B?YTFPNWVxYks4Z2hhVStyZmFaYXBRdjI3dU5Vak1URzQyRUF6ZjF1NlF0ZUNa?=
 =?utf-8?B?VFNoWGJ3SDc4ZE9iK2ZIdXlBajlEYlpsV3QrZ0t2bzd2MnhKUDJTUWxMRzhI?=
 =?utf-8?B?ZnpQZWZKeHhKZTE3NHpSUU5kN1VRWFByNXpqVm1WaE1HTVF3TlJZcXFvbUgr?=
 =?utf-8?B?TmZ4MnRjMWNlWThqUGQyMnNPbjMvZ3NQWForSTZ5UnlQWE5MdlZVZ01SNlpl?=
 =?utf-8?B?cXFYUEZibXEwSjNUWXBOeWlVTEhRMW15Vld1eDB2bGJVNFlsNkRaMlJ6czVm?=
 =?utf-8?B?WXVaS002RzJQVUEvbk5KeXlEWHNwQ2g2dG40NWIzNWxpelZlVnZ3aFVqWUVw?=
 =?utf-8?B?QVB3eTlSYm5hUjg5SW5PS0FSSXdkZTZXSDE4eEpvUWVhUkp1U2ZjMEdkSHJ6?=
 =?utf-8?B?OE8xKzd5OW9Hbm5HZGc3NjlYUjA3SWFnWjljWnZMZzFtbjN0TTUvYUxrR1E3?=
 =?utf-8?B?elFaMlBUR2FRd3daWDFEN0FoWWZXVkU2SG1uU2sxSUxiYmlpT2hRWkYycUhs?=
 =?utf-8?B?NUV3TkpxZit1QTNNaTcrL2NlZjhxanVTdERtWGhiSjJoTTdDNncvK2JqTkkv?=
 =?utf-8?B?aHpPc0wxaS9HaFg1eUYvQ2d2R294USs4ZjE1TXRoUE1vSzY0c1EwQUFPUWVw?=
 =?utf-8?B?T09PcWdteUJKbzNNY1Y5WmwxQmpwTTg0eEpCNzlSSVpGbzh2WW9EeWZxWElM?=
 =?utf-8?B?a05FSVpXMU85cVFkR3B0WEg4UXhXRzJ1akNxVDI0bU9BR0JubG9UYWREMCt6?=
 =?utf-8?B?RndiZW5KWWI1Nlo4emdyNVVqK1p0UnZyTnVWTVMvb1JmUUN1cGpzMExqY09q?=
 =?utf-8?B?Z0lXaEhkSHlXTE4vaTI1VHFQMEkrdUhtWm9iWEszbW5MUVVXVXgvaGYyWEl5?=
 =?utf-8?B?WFZlcWRFTjlJNTJCVWw4V1dyTHZJMkhBZG4vUTJpQS9lUlVNcUppNStibHhM?=
 =?utf-8?Q?Hnd8EytgwNtwfnyZWmrpfvqdr8ZtDyXVIet5krz8kUYm+?=
X-MS-Exchange-AntiSpam-MessageData-1: NHDjPFhi89YidQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90fc362-749d-4a1a-12d6-08df0d2b134a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 21:57:56.9279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+5GlKNBjbPYDBDO/Ig6jxMmJ8+E3gLDeKG25KKkaSKHHOEWgkPni+AVMzu/rScht3kQYoZWM6W64sgt1gRhWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5733
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 9/7/26 15:13, Marc-André Lureau wrote:
> Use qemu-io command instead.
>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/ahci-test.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index 3406ca884fb4..eb8d23999738 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1900,8 +1900,7 @@ static void test_write_engine_stop_in_flight(void)
>      ahci_io(ahci, port, CMD_WRITE_DMA, rx, AHCI_SECTOR_SIZE, 1);
>  
>      /* Suspend the backend write so the first sector stays in flight. */
> -    g_free(qtest_hmp(ahci->parent->qts,
> -                     "qemu-io drive0 \"break write_aio wr\""));
> +    qtest_qemu_io(ahci->parent->qts, "drive0", "break write_aio wr");
>  
>      cmd = ahci_command_create(CMD_WRITE_PIO);
>      ahci_command_adjust(cmd, 0, ptr, bufsize, 0);
> @@ -1911,7 +1910,7 @@ static void test_write_engine_stop_in_flight(void)
>      /* Drop the command list while the write is still outstanding. */
>      ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
>  
> -    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""));
> +    qtest_qemu_io(ahci->parent->qts, "drive0", "resume wr");
>  
>      /* Round-trip through the device to confirm qemu is still alive. */
>      ahci_px_rreg(ahci, port, AHCI_PX_TFD);
>
Reviewed-by: Denis V. Lunev <den@openvz.org>

