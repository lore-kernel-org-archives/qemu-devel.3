Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA444C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlitq-0007AM-1w; Mon, 20 Jul 2026 03:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wlitm-00074H-2n; Mon, 20 Jul 2026 03:58:50 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wlitj-0006zM-LC; Mon, 20 Jul 2026 03:58:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS5EgZwS3aV/yc570paeOT9FesUbUBGbbrsoUXi57goN+2UGPBa03wgU8sysxBsxa7p2cc2qDH/JepZ7AkqDCwgriQN/JuaUnUVP6KF0guweqAXZyGVxOObXN+07GlLKqsEls6gRZoOI4mHniRJjCi3WBNUSu9KH8CdBaxcHcyTO7H9PpPkNidoht4tIWRHkdctHlpKzMk4+y3zRCY61JxNCROvAzxfuVLEJL14jYsWMGH3/tDNsT6KLHDXR+MVvB5Pj2g9eBaXEKosLypSOi4lY5+Pv3LxaZDVPpbCIQK4Dg5mie4vbbZFuOcfcnh8uJKuRHS4Si5UiMkJZGUgHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC/1OVDbSH273ZaU8S9cgro/DcPTOPixSrx8Gitpsg8=;
 b=ODz0wFuSJzvZiPJ9E0CfnoaAxhiGjxYsQ4U/AHketsZOQkhFMd31EVzr/qvIjRkzwhjeJZigdRDb7+IYjmt/wfnAbspdb97X2CQWzFJJlAHZWxDx9j8VDV0PXYNWtbDhqrhGoM6hVedKPBcvnVDsjytHs0sS7foBP6QL42Hvk0ObyYX+17OySHLL+oWuAaUh+O6/B8UR2nUGPg/7BlIU5Utj1XAdqQfbahZyvtGe21MUZHBfiTnyyPZiE+10TY1GQJhVihWZnjaybM6IwD/AmEtEws5IPc6SuIKJJ/39cFHxZgTnHrkzLSaHZr58YJmKbjHdkqRghqFCM31N+ReHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC/1OVDbSH273ZaU8S9cgro/DcPTOPixSrx8Gitpsg8=;
 b=QcH7byKB4bmsxmSr0BGij8jD6ttGWuwNyYTrka1h8OScFCO8IrO/IdOnOLvINNTVoHSuVkb+yet18jrhWIAurmH3LCAyXpgPN7fDwGX1GvJKT7MH7+iaTi1TJ5y53mV3xlCrPyeHIb8nda+6Jer3TerK3aHOoYaIESOZ8Nhv/ob5+lkVWINlyf5A3pU+BBsLST4jZdi4es/1YkB3bxqsdWt0PMN23JQjCPS/iGgr1QIvNZU9UCKanEg7ojcZuWTXXZLJm4teR7/l0Sr1i5bQ10XrMlNjEHbB4PyJ8CxaRXykWgbSbfzPNgYYTL7l2bx2LnDzT4oCyNFQPuskMswMMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAVPR08MB9531.eurprd08.prod.outlook.com (2603:10a6:102:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:58:41 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 07:58:41 +0000
Message-ID: <280a9e72-2c3e-4064-8666-6f2603e32d8c@virtuozzo.com>
Date: Mon, 20 Jul 2026 09:58:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/ide: fix ATAPI CD reads racing port reset and drain
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260619112158.304782-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260619112158.304782-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0060.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::49) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAVPR08MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: e06b3b2f-eb42-450a-eae0-08dee634b685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|6133799003|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Pr4R351mVdBFQQQVTa1xEPHlsf86GcHAYGxf2c1d0soSzHPS27YTasJWAPO8AfFNn+0ACELGB6jH+YJATU5y9zNhgseytO11DSlkkH/T4BNaUjb9RvbNJP+9SAYEhCAOMLFpfXutkIJyZENP4cpuoCxeTxQ1FdEOI+G+ZP+Qt3nRibTyAoB07RXMx5N/csjtGUuin/lTnM+8hlehmW0JdG6ZIEUprzxJ+DqCbq+APs1ilxlCNuKWz/4UyXaizRgLdDhnokBZUApNnplqmUpRqw8Qcbvs6pv6KMpizOPKAstE7Q/vcta8mi0tt8rrhQiQtgKNdAHRX5hSClDLbdItmhpFH2znEHqjbdAtf6jPyWFyTcNpAeSA0tVQX3gRrMb1xqmv2d0+2QWTJvvt5dXrjGsbEaAY/Pt3JPOZKPhbW0mIT03W+1Cb78e2y3TtR8GwnhrxT6ZbSNuoneDwqGYhx1ccSYvvP7zDX/i4jAZAlzn5UeubEJg3TffQ+aT11zswXh53QbaECVg7ofN0YrLupXolGRAbIhwd1H3Mly6T3+lpRYW11JZXlfbtA4VIqKVPpN8Ck7+504EnjhJJR9YKoA4Utp6E5rJDkRwNuqaLE0L+epIk64cKXgKBxm39kJKY8IVXOWPUkK/2+nS7RiQw2ECk29sJXCRvasU8VSZpKWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9USWxjN1BzQ0tFNkt0RS9EbDZmQkpGTDZXMVE2SlNHNkl1ZS9OanpNeVpo?=
 =?utf-8?B?cjZYZjhVYVhDOUdnbmpCYlZmaG10dGVpMitqNFlZTGtnVDF2SW5hWnI2a1Zk?=
 =?utf-8?B?c1d2ckZHdWpxbzl4SytiUEE5TFJKRExvSFFHYnlvUXR0R0FhVHR1NlBxamdO?=
 =?utf-8?B?THo3RnNoMktta2s3YTZOTTRQZ1dZM0N2NG5Na3hCU3d1VEl1TFFHNUhadDVj?=
 =?utf-8?B?R3ZPOUdlcGMxSVdpZ0dGY2tlSFIzdkJNUm9GMjVJeU9YenQ5QVNtR1ZCaFh4?=
 =?utf-8?B?TEhaTTBiWk93Q3pIVk9zQWlPamZTUktGRzVaeEJQSEVuc091TDlpam9LUGZi?=
 =?utf-8?B?TDNGeFVveHNPV3FxQjJQMVJhcXJVc3JlSnJzYTBwbG4wZXl6eHBxRlEvdFpx?=
 =?utf-8?B?dnNidURvNnNOOFJONDVGNnVuM1FmOG03YUxyZlY1S0txeUhvQVJyaDFuYTRF?=
 =?utf-8?B?N3lWNXdXUUd2RUMxZnM2bHVpSlJ6WFBlVkxGWlVPTzdlUGxid0ZlTEs4Sm9s?=
 =?utf-8?B?M2MreE5GOUdZYk8zZG5PMG5WcjNlS0Y2cjJ0cTYrZ1R6eEcvc2RMRHQrOGhG?=
 =?utf-8?B?TFVHSC8zQnAvOWhyTncxYXV1TG4weUFQM1FETzVYOW5ROXV4M2ZvRlJjWTl0?=
 =?utf-8?B?SkVic3FJU3BENEZ3UXZlWWJwRmNub3RwczA0bnkrd003SC96R0l1NVJnNitC?=
 =?utf-8?B?NDJjMWdiUlJlZTc3MHlUKzBud3Z0Y1J6bW1TWHJWRGk5NE5LczBZcXNvM2NY?=
 =?utf-8?B?UGkwL0ZvNDlXMjhiVnEra0c5eFNJWmp6YmtFT1pnWHJ1Ny82YTJLQ1l2SVRX?=
 =?utf-8?B?ZjdNTGRtc1loRHV1RUZTMk9wZmFha2lNK0Uxa1JTZmoreU1ncklNUW40QnhO?=
 =?utf-8?B?WlNQdWJGSUppZ0kxaU9XcUFqZnlwdjlncXYrS1NPb1hkUTlmSGZpczNlY1M1?=
 =?utf-8?B?RVA5ejBseUVJTGJjVDNaR0w0ZGZnVnlqeS9ERTJoYzJVV2hWcmk1OHhtUWsy?=
 =?utf-8?B?RXFJNFNQVG04VnV2dlV3MDJFbE5PVG9vUmIyS2FJdFBiR2ZsL1ZlNVJZRXQv?=
 =?utf-8?B?bVBQVGptUGRwaitJcFF2dUgxNE9MblZNMzRCV0pVN2RVZ0xOQXJlTVRGYTcy?=
 =?utf-8?B?YnpUMy9kQkcwUVF2MmxaWW1YTHRWMUs3SGl1TzlvUUJ5N3NMNXpZUUF1OVNX?=
 =?utf-8?B?a2ttL1JVZkVmOFVKc3ZuVXg5WUxmenkvRCtKMkVGYVNFRTRzU3I3Vmlyc3B4?=
 =?utf-8?B?RXZSZFdWRTFZbVVVTWhuTmpFZWV3N3ZOemNRMld0bEpUMHRTQSswVGFaL0hV?=
 =?utf-8?B?YzFSYW43djdqMmk4bElTQ01QbFNrNnFWTFpKRHFFb0d3RHIycXZxRWI3WUt2?=
 =?utf-8?B?a0p3M0FGOFFXeFB3b1JkeHIrT1RlZHI0V2VkNUdZV3c0UkZBVFg1ZlRWWVpM?=
 =?utf-8?B?ZlBzYTZWeUcvVGpJWGV1Z3RWNkcyajY4WE5zNnJUSGlaMTR6aGozR1l3cjFP?=
 =?utf-8?B?UGgyUGg2bFRyRklTMEx4eURpVXkwZThxTjkxR1Fud0ZwM241aEt5UXV2bW9Z?=
 =?utf-8?B?NjZJVElIaUVaSHA0Zk5lZS9DTHBBRVVpVnJseXV6K0xWcHgxSjJWREc1RDNs?=
 =?utf-8?B?S0hjMlFGUjNSU3AxWHF2M256UVhTdFQ1WTVNOUtDeWJnT2N2V3ZSelhWZXNF?=
 =?utf-8?B?ZVRBd01nMktxem1mamdGR3R1bmxKR1dUMCtKcStUZWpFV2Exd1FwL1ZpMVdu?=
 =?utf-8?B?Mkxud1FsaE1wMG52TEp4cXdTMGpQMGtwNnpxK0NramoxNnRBK2lJWUJMdW9z?=
 =?utf-8?B?OW5UNXY0Y3RqbjZib1RXRm5pY1g1dUZMd1BhdEczek9vQmcvRGF6bDdqWDFX?=
 =?utf-8?B?Y3ZTdHl4NlE2THpab1NOTEtPbUYrOUZHQ0N3RytoV3IyTWdNK0FVb2Nvam1R?=
 =?utf-8?B?TzRSQnFUVUR5N3cvR09Xejg4eHk5RnphR0hEeHQ5TFBzTkdjelZET3llTkRR?=
 =?utf-8?B?bHJNUEMzMVZibXRwTW05OXZXUVV1aXR0emE1VmxMRE1qSk1wQ3FKa0xNenBY?=
 =?utf-8?B?SHdvZ0syc3JYU04zMXloNHVwTS9WUEY3eDh6UWZlK2NnWWFyQ2F1ZDFiSm1w?=
 =?utf-8?B?dlhEbUxwelZCVitjbGZ1Q0hWanNMd0ZmT1UvcnMzZ2ZXM0ZtR3M5bUtXZHVE?=
 =?utf-8?B?QndTNy9BUW1VSG5vS0R6cStCc3dmcWoxdmFPamdzVW4yRmppdnpZVjNvRDNm?=
 =?utf-8?B?c0c5OXRHUWlNZ2pFTURMSnFKRGIxT2Y5Zmd4UGRXWnB1R2FqNWIwOGVxWlV3?=
 =?utf-8?B?dGlqdzc1MWNSZFg4L2cyZm1FcENWeWo0RGJaVjR4M1lSbVlDc2V1dWhMNkZ5?=
 =?utf-8?Q?cephrJBZhfLKj6YsDcmycsdFlgDgaXZY0G93VT6vVpIJh?=
X-MS-Exchange-AntiSpam-MessageData-1: rLRbriUZYGqyVQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06b3b2f-eb42-450a-eae0-08dee634b685
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:58:40.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCzdyUkC7v14XBn2xJHpQY0a3Z2PeDRc5Ju4ZcwHOxUFqvt/sj+A7rkmfHo+4WFox5puhHPsEf4p3xRG64E+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9531
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 6/19/26 13:21, Denis V. Lunev wrote:
> An in-flight ATAPI buffered CD read (ide_buffered_readv(), used by both
> the PIO and DMA reply paths in hw/ide/atapi.c) can collide with a
> concurrent port operation, and it breaks in two distinct ways. Both are
> guest-triggerable and reproduce on current master.
>
> Neither was found by inspection: both are real issues reported against
> the qemu-kvm 10.0 downstream -- the crash from production, and the
> deadlock from the downstream live-migration validation suite -- on
> CD-ROMs backed by high-latency network storage, where a backend read
> outlives the guest's SATA command timeout.
>
> 1. Command engine restart -> NULL-deref crash (patches 1-2)
>
>    A guest can stop and restart a port's command engine
>    (PxCMD.ST 1 -> 0 -> 1) while a read is in flight. The restart re-maps
>    the command list and clears AHCIDevice.cur_cmd, but nothing tears
>    down the outstanding read; its completion then dereferences the
>    cleared cur_cmd in ahci_pio_transfer() / ahci_dma_rw_buf(). This is
>    not the COMRESET path -- an engine restart does not run ide_reset(),
>    so the drive's transfer state is preserved and the read still runs.
>
>    Patch 1 cancels the outstanding I/O when the command list is
>    unmapped, reusing ide_cancel_dma_sync() exactly as ATAPI DEVICE
>    RESET already does from the same MMIO context. Patch 2 is a qtest
>    covering the PIO and DMA reply paths.
>
> 2. Concurrent drain -> main-loop deadlock (patch 8, repro in patch 9)
>
>    A multi-sector PIO read whose byte-count limit spans more than one
>    sector must fetch the later sectors of a DRQ burst from inside the
>    completion of the first, asynchronous read. cd_read_sector_sync()
>    did that with a synchronous blk_pread(), which queues behind any
>    drain in progress. When a guest reset reaches
>    virtio_blk_stop_ioeventfd() -> bdrv_drain_all_begin() while such a
>    read is in flight, the nested read is queued while the outer
>    completion still holds blk->in_flight, so the drain never finishes:
>    the main loop wedges in the drain with the BQL held and every
>    QMP/monitor operation blocks behind it.
>
>    Patch 8 reads the whole elementary transfer in a single asynchronous
>    request, so no read is ever issued mid-burst; cd_read_sector_sync()
>    is removed and the DMA path is unchanged. Patch 9 reproduces the
>    hang via x-blockdev-set-iothread, which takes the same
>    bdrv_drain_all_begin() path a guest reset does.
>
> Patches 3-7 are the test groundwork the deadlock fix needs: they fold
> the IDE CD-ROM read tests into one parametrized helper and add the
> previously missing coverage -- multi-sector DMA, and raw 2352-byte
> READ CD on both IDE and AHCI -- so the rewritten ATAPI read path
> (including its in-place 2352 unpack) is exercised on both consumers.
> The test patches pass with or without patch 8, keeping the series
> bisectable.
>
> Patches 1-2 stand alone as the engine-restart crash fix; they are
> included here because the deadlock work shares and extends the same
> ATAPI read path and its test scaffolding.
>
> checkpatch is clean on all nine patches; the new and existing IDE and
> AHCI qtests pass.
>
> Denis V. Lunev (9):
>   hw/ide/ahci: cancel in-flight buffered reads on command engine restart
>   tests/qtest/ahci: test ATAPI read completing after engine restart
>   tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
>   tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
>   tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
>   tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
>   tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
>   hw/ide/atapi: read the whole elementary transfer asynchronously
>   tests/qtest/ahci: regression test for ATAPI read vs. drain
>
>  hw/ide/ahci.c             |   3 +
>  hw/ide/atapi.c            | 180 +++++++++++++++-----------------
>  tests/qtest/ahci-test.c   | 201 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/ide-test.c    | 211 ++++++++++++++++++++++++--------------
>  tests/qtest/libqos/ahci.c |   8 ++
>  tests/qtest/libqos/ahci.h |   2 +
>  6 files changed, 433 insertions(+), 172 deletions(-)
>
Hi!

if nobody is able to take a look, will it be fine if I'll
send pull request from my name for this?

Den

