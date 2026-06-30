Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682D8C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWFg-0005Vs-D1; Tue, 30 Jun 2026 07:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1weWFf-0005Vk-9w
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:03:39 -0400
Received: from mail-francecentralazon11023080.outbound.protection.outlook.com
 ([40.107.162.80] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1weWFd-0005aZ-Bv
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAlrdNIEoNqRow7b0I/YfzAm31gaOqWCXhP2WlMA04Jum3+/PY6w6hHwdz/Wv7Mgdt3/XqzkN02mOMANMEiirEIERNXmn/Jb0Ksy3IE3vGQUF9Fuy2+L5pyqcxWZ8OCy+yeVB8rnqMgzZpAqg7Y5/iXlFeAUhG2BYn2NRtw4zBcOCzWtCChkg/I3KiF4Qe8bnfev7A4TDGhO7c4zO+YGu5N+8Prk31y+f5Ya9SJbKO1dMdvMl2u9TH3tL0SvX7WPUHAT9u+b9ItmPIa+7nOyGqKi79d5YiI5p05J3VQO0HBphWCOCKEbuECYFjwvH5bLnp6ATKfPD4i1EAJuRy2U/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVDP8egmB/nI3mdnB74M2NhIDiAqJszaaDtJiuFT7pI=;
 b=NDm7lv/fqN1YnynfiFxEjjcWwsGf3TK//RQZF4Q8j9DctOXELpfaXsShnOAHd6NeCtwhp/RfvXDKjAvdMgo8E2sWyUvCvAvGXaoNbImcrqYmPSK6DLCy0qYTUG4f6QOwpVZ35ZkMq2Mh16HxmbXY843ORhMfigAaFB+M9ASUlscY+Jbh2fUBuTyFcWoOGhiLRgYU4utN7Wfb/x8UDYltnu4jpjFBc8FNrwypZ9+m3n00ouEXqx91+MfLc4257c4u8U14Ht2o6anEZLNjlIRI+bnBf9WyyzQ8F0jNPAL2QsQxdNIf7a+FzWH+U8TrYFYVNJgExoBnp92POxu+AsbD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVDP8egmB/nI3mdnB74M2NhIDiAqJszaaDtJiuFT7pI=;
 b=qFeu/U0UK/kq3cZkFoKR6HNdFuuhIHYs+05M/dZt5Dq3x15dJA47YzpdivozKOVvwUFim7hSyjn07p0/+ko41KeWscDfn4qQHl9azauJFzwG0EL7ngHB3k5q94UqrQBgRfIDjG/vJuQZ0ZWtZ3r0ki+s2yMACGZ/AlYTpvFYahBuqScluv44eTPf0sVzV914WEaKP7i5C3t7exUaJIziBNxhjdstCG2yDdvf1fhnpx8aldb1BOEkic6KG3/hvGuf6nr1xgqgCO2BAJWZ5RYJ3E124KX7nvJTf3FdfoBhsjsMIAEf8dURAd1ggxJTGGx8sOjON8VSR2VnKRQNfJYb5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS4PR08MB7711.eurprd08.prod.outlook.com (2603:10a6:20b:512::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 10:58:31 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:58:31 +0000
Message-ID: <9aeb2a71-49ef-477e-a67b-1c509bbf99eb@virtuozzo.com>
Date: Tue, 30 Jun 2026 12:58:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] dump: report win-dmp via vmcoreinfo, guard
 guest-RAM reads during migration
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de
References: <20260619101834.228432-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260619101834.228432-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0011.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::19) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS4PR08MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b63c33a-3334-4870-3a1c-08ded69685af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: okGF6GYUUwMa1l4nu98rNjywMzRkn85McsPOD/Xvc1kRiyUAljDEwQfHnii64nWUxeJOtB2/PbDXcsyzrPUxoxq+itcoZq/FwO2UnDhdCQzt8qSMONnclO3YnNgrdmP8Fvx5i7n7kIQZRLjjKxNn9IJt9hVS5nIlvw3IW9Ir9Cy19553vbTgO+60sMObWwmF488Cyfoto+4FE6JiR41S0i0UrsIlTdDKzMJIGW7QZIYQz7PhXI6YJZuQWPo6x3kfZMLv9Epl916C0pRS9DF26mo8dFxzfxUD4LX2VAAbxpNFKlaLFU71D15esbppMMv3TIwKEiX+wQC5KoVzz2o3VbOdvOrIPP6q8itwlmFgHp8xh6z6iPn5VQrvqMYT6s6viVEMDF32fkjjR0MNWKDnmN+ULRz7XOIgqBPTY26RLogvk+rvA47Hl1c3dkgocrw+sY9K7jjaHuR/AAw6+7rxdsi3KPl8N3NXrRr0fSS8bDTXeq4TjRTRlUDVodqCeUiaAm0vZPaxHFTVBGPZuprYI2Uta+WimRwMgn5YAnVwu/vMvMHLRw/6dCUcMrnlZun+Lo9vpnddyXK3zMxUsz+/Sj8Wz/wCXJZ9YAXmiL1NBNHzyGximxYdDRFAr7rRk9uUJHxmVzcZPUpYsT4kabbwn3T0FN5QSB+EFb1bcaPOS1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(3023799007)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdhNEZyM01QSUd1WmowMnI5ZUYzelpxdjRZNXp1aWRDYnJOVUJLeXkvRG5R?=
 =?utf-8?B?a1VkNWhqOXEzZUJXbnlRcFJEbzRST3dnRHVHaGM0S3pHSlJCektmZUYrVm1Q?=
 =?utf-8?B?Mk1RdzJ1UWppdnl3MzJEMllrTEIwRmFKd2R6TWF2YUd0NnBLSlNQRTk5MXU0?=
 =?utf-8?B?dnZBUDNqQm9rRS9WaEV1TEp4KzVHSTFkWFhFOTBQd1JHOTNYcU1tYmg4Z2sv?=
 =?utf-8?B?RGFKQWNxR3NIWGRwbUVrK2VNa1JSbWFQOVdsUWk2eFZZUUpSOUhPRDFEVGZo?=
 =?utf-8?B?SHNMZ042SmpmRVhVU2Y4RjM2TElhbnFsa3MyUHo1NGN0ZlFsaVlOMTlXS2dN?=
 =?utf-8?B?Y1I4N0h4cWZJY0UrNTNKN0tBUitUNjM3K3ZnNStyMGIvc0QweWplaklVVFYy?=
 =?utf-8?B?Q29HbENzZmtnN2dLVWtacE4well1Vk9JWDlUNmFhT0JqVzE2em9WN2Q4eEVU?=
 =?utf-8?B?ZnVLZmEvbTdtNTJCN3pqbzJuS3VRK1Z1RXRicXVoL1NWT0R4eWM4ZGdQcFRL?=
 =?utf-8?B?UFc5aWN6WTdDZFUvZDR2Nk9QMU9NbGxqWkFTZmtLVVdPeGdtSW1zUDlndnBR?=
 =?utf-8?B?Wmd2TEdQV2tWYVVXNDRHZTdTQTJqbXNmWUF3Vk12SDJteXljd1RWVHR6R2Ns?=
 =?utf-8?B?eURxQmtWZ2hWOTA3QkdXUXhlWHdvd00wdjZ1em5VSjZWSjE5VVpBYUIvVXow?=
 =?utf-8?B?eGVnbUtVaXRpSU5ud2t6clZyQUprR3pGQ0JxU1pYOG9CR01PMkt5SUF1RCtm?=
 =?utf-8?B?REt2blk1VmJSOFZjeHh0Nnpra3dvTlNtcTYvdkxrRGpOVGFWakZxeE1oaTYr?=
 =?utf-8?B?MFV1UGw1d0Z0QWRFVXlBTkpZMWQ5QitwUm1mL01oZVpROWdxQldwQTMzS2pD?=
 =?utf-8?B?dHkwUXJpV0ZjN3hWTXpGaUJJeHZZQnhsZGk5Qm9PM016dUVicGFLWEQ1MEhT?=
 =?utf-8?B?NUhzdjB6eEpoQlJoVFZaZlE0UUFGMVo3dFRuNzJjL1lRcTFSck5LbDQvUjFP?=
 =?utf-8?B?cU0xNXJpTC9adHNyeUZpOTZ5OFpJcWdiWFVHN2RkNjZFR0RWeU0zWVdjS2JI?=
 =?utf-8?B?K09EYk42c0hWY09ySi8xYkVGaGU1QWtoSWVZamxHRnVwR3BOTGhqOW56STJB?=
 =?utf-8?B?ZlQ1QnB5VEtvMG54MVN2Zk9IeVFUeEVwcGE4OWh2cWdnQy9BQ1pKZFlZZ1hZ?=
 =?utf-8?B?cjNhSjhRMjVKUEo2ZSsyQlE2bzhyRUJITXBpcXNNRDE2TGZDV2QwV3hOaUVM?=
 =?utf-8?B?V0Nic3ZBWW1zMWRkS1AvL3pjN0xEMlJHaDFWUStpZzNuVm9RbzdNUVhsY2Rj?=
 =?utf-8?B?c24xbmZIeVV2aHNKSkZydXpjK3RrQWt6NCttaXIrWDlud1A5NjhFK1haZVcv?=
 =?utf-8?B?LzFXcGI3OXRxRzByUU9vYTZieXM2OFVxdEJ3N3JpSHVLQXd4L2ZtL2p4R3Np?=
 =?utf-8?B?aTZ1U1hXRkVPZXhoYkZ6SnhOcHFVOUFHZVhWMUUrak5qQUQxMXM0RWVBcm1i?=
 =?utf-8?B?ZXVFNFJuZ3lMbzFkZ05KUnUxdC9VRXhMWUl5RitEL1pwZS9LV0V3TnFMNlB1?=
 =?utf-8?B?bTNZSTBYTGNTRG9sNkxqR3hHamlER2pGRkhZMzNQZTlSeXptVnM1cjdaa054?=
 =?utf-8?B?RjgydmZoamVzYjhLSGdCR29RTSt5Rkd5ZXhiS3lMMnZ0d1hOS1dUSkJWVlZN?=
 =?utf-8?B?QTc5L2JZUWlIRlJveXdMODFoMjlyaVdFYzQvVnR2N05FLytuOUVrUVNseU9X?=
 =?utf-8?B?MUZ6N0thRUlFZGZBeHVsTHRTcDJYTFFpOXowbzk3UEhiK2swSVlNcTc0T0dh?=
 =?utf-8?B?U3JlZ0xFSy9qRFJuOTFUT2h1NDR0UWN3ZCs5UE9JcFZmQ2dJWEJ1RS90SzUv?=
 =?utf-8?B?WExSeDhCbkFZbnRqY3A5SW84eEhhUTZFcEk5Zm1ReDhuYWdzd0VWd0h2NjJY?=
 =?utf-8?B?QUR4U3R5ZjA2RTBJa2RzOHpMRVdpRXVjWlZFWURmaFhBVjQwTEx2REZJaDRu?=
 =?utf-8?B?MXlmUEFWT0R2ZGY1UFF0bGUxc1Rwc0NPTnozNEt3clptejd2MThpNEU4cENa?=
 =?utf-8?B?M0UxNWZMZG92dGZBZ0pIRllLYUZwRURPSFU2ZFBMeGlXbmhURlZ2RllOdE5M?=
 =?utf-8?B?c3BiY2dTV2l5RW9qZm05dk91SjdVRnhwdmhPZU1tQllGb0hwakQyem5WWlBq?=
 =?utf-8?B?aks4ODE5N2NscG9CYXNiVi9SK0dERk9IUG1NK3VBYjBMT2dJM3hhTGRicTNi?=
 =?utf-8?B?dllKdFNiU3JkZGpjeEUrVkUzR2YwU1J6bWo5UUpwd2o3aFZvV2lTY1ZkdUZi?=
 =?utf-8?B?OHRGNUU2bmdIbGFtRHRMTUpudnBWeWc4eFVjV0ZHQWgreHhDdUxYVXFzZkhw?=
 =?utf-8?Q?Kqw8b42uxY0WJBPwyEm4ni9Y4vw+5Kn8qz9JDRVhtjNJB?=
X-MS-Exchange-AntiSpam-MessageData-1: gF4Fj4Y4Vq5eAg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b63c33a-3334-4870-3a1c-08ded69685af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:58:31.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld2TgbG+fTeGUBIhurxwIABsBxQ6C/cKWOZ1+gpE86AmldEUuJhNrMx01+TZ55atfbgx7MnJZPgdaML4P3dWSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7711
Received-SPF: pass client-ip=40.107.162.80; envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 6/19/26 12:18, Denis V. Lunev wrote:
> This series fixes Windows-dump (win-dmp) availability reporting and closes
> a related hole found while doing so: several commands read guest RAM and
> must not run while a migration destination is still receiving it.
>
> dump-guest-memory, memsave and pmemsave all read guest RAM on the main
> thread with the BQL held. On a migration destination that RAM is either
> still being loaded (precopy) or pulled from the source on demand
> (postcopy, where the guest already runs). During precopy the read returns
> incomplete data; during postcopy it deadlocks, as the read faults on a
> not-yet-received page while the postcopy incoming path needs the BQL the
> reader holds to install it. dump-guest-memory only guarded the precopy
> phase and memsave/pmemsave had no guard at all, so a new
> migration_guest_ram_loading() predicate captures both phases and all
> three commands now use it.
>
> query-dump-guest-memory-capability also advertised win-dmp for every x86
> VM, and dump-guest-memory accepted it unconditionally; win-dmp only works
> when the guest has published a Windows dump header through vmcoreinfo.
> win_dump_available() now reads that note back from the vmcoreinfo device
> and validates it, keeping its original signature, so the dump.c call sites
> are unchanged.
>
> The series also adds the first qtest coverage for dump-guest-memory:
> capability list, ELF and kdump output, protocol errors, and win-dmp
> reporting in both directions (the positive case forges a vmcoreinfo note,
> so no Windows guest is needed).
>
> Tested:
>  - Linux guest: win-dmp not advertised; an explicit win-dmp request is
>    rejected without stopping the guest; elf/kdump dumps work.
>  - Windows Server 2022 guest: win-dmp advertised once vmcoreinfo is
>    populated; dump-guest-memory format=win-dmp produces a valid (PAGEDU64)
>    crashdump.
>  - Live postcopy migration: on the destination, dump-guest-memory, memsave
>    and pmemsave are all refused immediately, without faulting a page.
>
> This supersedes the earlier "dump: enhance win_dump_available to report
> properly" series, which obtained the note by reusing the dump setup path
> (splitting dump_init() and stopping the vCPUs). Reading vmcoreinfo
> directly is much smaller.
>
> Changes since v4:
>  - Refuse guest-RAM reads (dump-guest-memory, memsave, pmemsave) while a
>    migration destination is still receiving RAM, via a shared
>    migration_guest_ram_loading() helper.
>  - Decide win-dmp availability by reading vmcoreinfo directly instead of
>    splitting dump_init()/dump_preinit() and stopping the vCPUs.
>  - Add dump-guest-memory qtests.
>
> Denis V. Lunev (7):
>   migration: add migration_guest_ram_loading() helper
>   dump: refuse dump-guest-memory while guest RAM is being migrated
>   system/cpus: refuse memsave/pmemsave while guest RAM is being migrated
>   dump: make win_dump_available() check vmcoreinfo for a Windows dump
>     header
>   tests/qtest: add dump-guest-memory test
>   tests/qtest/dump: reject win-dmp without vmcoreinfo
>   tests/qtest/dump: cover win-dmp availability via vmcoreinfo
>
>  MAINTAINERS              |   1 +
>  dump/dump.c              |   5 +-
>  dump/win_dump-x86.c      |  42 +++++
>  include/migration/misc.h |   3 +
>  migration/migration.c    |   6 +
>  system/cpus.c            |  11 ++
>  tests/qtest/dump-test.c  | 331 +++++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build  |   1 +
>  8 files changed, 398 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/dump-test.c
>
>
> base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
Hello, Marc-Andre!

Should I do something with this series or it is good to
go in. Its final destiny is unclear for me at the
moment.

Can you shed some light with it?

Thank you in advance,
    Den

