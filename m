Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CC1FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHgAG-0007xB-QQ; Tue, 28 Apr 2026 06:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wHgAE-0007vz-13; Tue, 28 Apr 2026 06:59:38 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wHgAC-0004b0-1y; Tue, 28 Apr 2026 06:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZMAMf6E+8NlZyGPXsJOGQVuGGS4fCD048xmK8Hu37Nl4HNKp7JxKRUDWrb8Vz9tiYBRK/AhrGbcb+6f0ifUcvpxI4Q6irRfItFXd9fn3FGGQn3hUVlF4xrqBlRptPfcGoCZGoIeHuR3ZAh+GFn0zU4qMkSXWUM9HQULu5dBMkxtj58oUxAK/zNHAvd4HhMEBAdIENUlZr+nwn/UOEijqHeKZl7mfVQnIxUZbK3kgLh/evvvoCf/sfFWYtMNo1jMaUhxw1J3PeNbJ8xXtEmeXISAXetXM59pvvDH7XHHrbyKguRbtL/qWaTI8fYUKaVHfMi2m9AuO+jvTb+UO6A7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CvsNPdw/OXLxW95lGTJGXUcF78HtvwH9b1gLVBRjL8=;
 b=pCuBBpBWfLU2FZ+6dCq0SDXCzDcpNLCnhWXyHcAoF99kJz9I4W1KKMib/Cm/qaT/qDsoDAzxvTIxAbkznCubvi9bN2gCX/cEtzO0fMeH2KYWAEtrQwSDJinX889Gu3pP3Be5n4kwdqKbZpVQI6fOetLIphwGn+AAsiLT1UJiYvYl60a1Al/EWkhhMEMofqDR+7JpHofMcsb+FtKgOV1citFi4aILQglOkC4kcQIqukl33Dvpd6p2RB+n4sZbmLa51nHS/kcz9f9JV/M7+NjbLEo/uxt2KREtgJ8Jns6p5kkJgdJL2C00rCiDbDMJbSdmBzLb0C65ooE1IH73jQV19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CvsNPdw/OXLxW95lGTJGXUcF78HtvwH9b1gLVBRjL8=;
 b=wMX+bn6kgsLwB8O5aqJm1drT1sg7j319i6I962qduV2h+WVU1D1EfOsDksJHkmJgX1xIvclBBshds7kj/UfeqsvKvoBtpsE7n20qtQGIhiKzwSln93PBrzobp2iXL3HUIYemEZ/r06UtnkCTcMYXX2Ofdu+w7j70TLKK4a5ubWCekx32K+2U5UahQ1lHSg5wJgeN6xb3wTHmlAeIHlVhnnHZgkjxIWQvmr1RkHGj25Xs5kDfZTBAQZ+4Pj162LeafO7qMck7CZmi9bPW8qee9GrOIhUA+4zhQRQFFppi4iZKL/ggHGCndCCs2EUptL3dMUvspfu/zO1eYOBp5UYJFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVUPR08MB11930.eurprd08.prod.outlook.com (2603:10a6:150:347::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 10:59:27 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 10:59:27 +0000
Message-ID: <2b383d39-4107-49d7-a106-e442a822d8a3@virtuozzo.com>
Date: Tue, 28 Apr 2026 12:59:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] qemu-io: Add 'aio_discard' command
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-3-kwolf@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260427170520.101242-3-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0251.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::18) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVUPR08MB11930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0d68a6-97ef-41bf-0fbf-08dea5153737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nrHVFRVvpD/CRh/R7BBCrwmkuMszqXhuhz1SLKKfGT4RwBSjGsc/Nj1KgXD2YEGzXCefTkjRTebxSdyMRiTDj621a7CdUdRXuH6v8ayVZLUsb+N3Z8mwClHgxREniOVJmHp6YnJ6x4j3gm9nT5dN6LrOCwc+d3A9Z2QGyorH4rCt/2DWNB2WEYoNu0cotfaDjqm6WZsz/jykOnQK9HLDtcYAk/OhrC5ICcX7AiMluy5NDJ+sfRtfkpk6ueNz7+KB6gbcn1kDAr6V0yKon6wRWejlU/olouYjeAZTOxbh0EZlK7Psi25jUX74nK+Afx19PQqBuINvzjXYeuZxPehpYldjs2aviX7LIgwNVOVfPPSY0Mnt5yBi/co5YWzZE+BZQ/ZTdgX4XT2xz4RnyFWpkssKclr0FMan+dIEQkTZOHaIiTdUDBXHQ2gil+tsuZQIPw5OwWx08YZFdlFqSiGnHZ0tKxymJuzZ6sk++vMIKUO1tnf0VrljPV3uObHED3/9THXBoOtlwW0vNhwYHWRTzQMh7/Ba/nc2Iy+zphRS9CCQrh6V3n1lGLpDBllpLizAmKnUP2+ggo/GMg8H/CzLBCqXxysARsJDtFxowCNqw97mOX9YROCi9kCKyohRx+CF3y+agTwJv7rhCONfC4o3numQQXiFjwA2sRIqdddOZuY05lYLkWkLAVEzSG5GmUcXhK5TZvxuAKrsr3/3YLM4iXTN0EwfbRUNyM2fSJbciVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym9zRnZkQUw1UncrZkJhOGxoT0FMQ1R2QWZOZU5neGk5Z3dKSnJyQUJCMUw3?=
 =?utf-8?B?blhNVHIxakRURUNSSkIxVWZlb25PaDU3L2RXN0c1cTFXSmsvNnM5ZXQ0dUI0?=
 =?utf-8?B?aFNHdzllalZvZzJiQXRlYnNxWWFvTlBObEFDU0YyRVNRSWhLcW50cEE5alRl?=
 =?utf-8?B?QlpCM0NXSStlNm9Td0hhSXRscCtVRTZZRVhIQ2ZtNFdYdVhyVG1Ebkt0NFNM?=
 =?utf-8?B?Q1F0cXphVTNzQ05XMDRWMW1iWWVYMDVqMWJwLzBqbDI4TnBhTkxZdHNWOEFh?=
 =?utf-8?B?eXVDd2xsSWVwMVpIN2h1ZHlDc0YwcjloakR4ZnZBcFBjWERUMlpPY2ZNNE40?=
 =?utf-8?B?NjVzRGZ5R2g0WDcraDV5UXZDYWJNYnRTNUVZa3B4N3Q3ZG9DdzhOeTBrV1d5?=
 =?utf-8?B?RmpENEo0L3BSMEkyK0VkbzFxa3N3dzEybUZYRE4xWTRhQ3J1eEh6eUxiTU15?=
 =?utf-8?B?QlNzQlVTaHZQbmtDNDlJR3NGZ3E5UDhBNlFneXF4c2NPSFFJSzd4TFNreG5D?=
 =?utf-8?B?eEdQZGJJZ0hVR05pbVloQTY4djVHMHFsUE1FMVppKysrVEtGN05EbjBVOGpu?=
 =?utf-8?B?RUdZNmxRS3pJeTJLWG9LSkFuRUpBZUx1OTF2VjJqWUowQWo3d21nRzIyUmxQ?=
 =?utf-8?B?L0tJWlQwbk9ITjdhWGxubjhsQW9uRVVFSGtpeWx0RU9IUFdMUDhRTzhVbVBK?=
 =?utf-8?B?TWU3cjNacm5waDdpYlprWjdqMXVqN1B4aVVudjZhbmltcXVkb0N1Y0pnV1Z5?=
 =?utf-8?B?Qm5VcW16ckowWHRlV3VBVTM1ZVk1c2ZDRXhXdDR3dWdXa2RNbzBHa1hkME4x?=
 =?utf-8?B?WnJ1NnlIZEQxWDB6M3pKMVN1dlE1bnpRY3ZCM0Npa1hqWWhmaS9IVE5TcVVy?=
 =?utf-8?B?Y0FiRHZtYzBiWVNPR2dMQ08yOGh5aGVCSjdxbng0TXNBWFgxdnRWaVNDZERr?=
 =?utf-8?B?MWw3bCtlOERxRU5ULzlid1B1WjVKVlhpd2t2UTduRUo3UHQ3NVVTYU85L0M5?=
 =?utf-8?B?ZVZOR2lNQVBkdlRYN3J3UHR2VVNHckVUbUg4V29leldwTG5tVHd4dWR2bkRT?=
 =?utf-8?B?V3hmVkJVZHhaWXZRaU8zaVA3M3RobEphaDBtTis5RzdOTFVpdWN6V0tJWFRi?=
 =?utf-8?B?MVR3QmVCK29kWFNlU29PajY0NUhqUWVWVU5aWFpDK3phVTM5a0JpQVgyR3px?=
 =?utf-8?B?SmhVY3Iza1E4WVpnZVN2WXAwaEt0bmE0blFPUmZRWU1wVUtCNWNZR29jZnds?=
 =?utf-8?B?UmtLZHd3elZRZnFBK1hMTE9vTWx5UU5aSGRVRWJZU3pnSUJ2SjVldGFlNGh1?=
 =?utf-8?B?RzFueE9aVUcvbWpuVTFpbVFWcWN0YlRteDZBOGtuU0VQazNpNmZ4U0c0NWp3?=
 =?utf-8?B?clR5ODZQR2crcmJZd3dNVDd1UCtqNUUzWTNxVzdCdGVYZ2F0Q2tHbTg1RUc5?=
 =?utf-8?B?WG1jaXBWSG9YY0t2dGNORlpGYlBwUWhEYmp4SXJjZ3NjUWFkUlY5dGN5MWFX?=
 =?utf-8?B?ZGhCeVZibnJtUFVKUkJyVE45QmZkRHBUYnJlbWxrc2lDYnRDQ1VsaVRzSG5Q?=
 =?utf-8?B?VDNYSEhGdHlLdWxjZDcyQjNETDhxbFc2UFMrZDBPa0tRcG9VL1ArSXBiaytw?=
 =?utf-8?B?MVNQRHp1Q012OHMxa3NTN3Y0NXQ4RlV2UDRvSTZRRGlRYSs1U0ROT1RRS0gy?=
 =?utf-8?B?N1FNUEE3bUtxZ3JNSFhOOUJqZmxYcVFIemVMd2pYUnVQN3BCYnUxM2JmT1FD?=
 =?utf-8?B?LzZGdVp4SitUYTVsT1doaU5tS2orY2Vhd2FCdmZhRDc1QlQ5UlVjRzVYUHVZ?=
 =?utf-8?B?Zk5BenJrYW1DTmFGYjh0YjNVbjkrNlZMVmtQcFVtM3FKQVVYWktoTTdSUVlR?=
 =?utf-8?B?U0ZyZjFHOTh5alIzcE1rblk2NE9Ya3Z3cXJKMWFmcVgzQ1VYMUF1aGtQaDZ0?=
 =?utf-8?B?VkE4MWM3Y0RvNkVBZ1ZxcVRoZUNNb0E2TUVCQ2JsRDJyWkxQNWV1M3pBN2Zt?=
 =?utf-8?B?SDhMK2wvMXpRVlU2WFVnNVl2Ym9US3daVTcxclZrbUp2a3JSSS9Nc1k3YnZL?=
 =?utf-8?B?YXdLSXNxUTRGeFIvdjV1UkdTK3lQNE93ck9uRWlKMlFLSEt2RVNFdzZVRjM1?=
 =?utf-8?B?VkVRVG0xRXRVNmVlNVJLaGtNZHNOTVMzalZoemRMbW9GbDE3cFo0WWViV3Fl?=
 =?utf-8?B?d2NIZ2FWYWFuQzdKMS9mWk5uY2JJZSsvb2prSUJpYWxkaFphbmdkUzhZNTBo?=
 =?utf-8?B?T1VhallmODBEWThkYk00VnA5ZVE1dTRGY3FMUHlOWlg0dGQ2c3ZmdGxSck1N?=
 =?utf-8?B?eUhHcWtQVTdJVitITURWSnhKSFVabkcxZkJOaW1nd0VsM0VTZDBQa1UzUy9l?=
 =?utf-8?Q?UBveU/b1jNdwhIM/f0iqHYnByoEn4xDqf9eo4LXx46smd?=
X-MS-Exchange-AntiSpam-MessageData-1: WBsfq4E68vZPhw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0d68a6-97ef-41bf-0fbf-08dea5153737
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:59:27.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u06BX/f0mbYn5esGjXy0at4hZ8Wwa4Qx+5uXyvpcd2kIH57U07PJb64r3m46faP5QyLk6zEzd0IUnfRKhwRbXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR08MB11930
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 4/27/26 19:05, Kevin Wolf wrote:
> Testing interactions between multiple requests that include discard
> requests require that qemu-io can do the discard asynchronously, like it
> already does for reads and writes. To this effect, add an 'aio_discard'
> command.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-io-cmds.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 13e03301624..0f5baa70f94 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -2218,6 +2218,118 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
>      return 0;
>  }
>  
> +static void aio_discard_help(void)
> +{
> +    printf(
> +"\n"
> +" asynchronously discards a range of bytes from the given offset\n"
> +"\n"
> +" Example:\n"
> +" 'aio_discard 512 1k' - discards 1 kilobyte from 512 bytes into the file\n"
> +"\n"
> +" Discards a segment of the currently open file.\n"
> +" -C, -- report statistics in a machine parsable format\n"
> +" -q, -- quiet mode, do not show I/O statistics\n"
> +" The discard is performed asynchronously and the aio_flush command must be\n"
> +" used to ensure all outstanding aio requests have been completed.\n"
> +" Note that due to its asynchronous nature, this command will be\n"
> +" considered successful once the request is submitted, independently\n"
> +" of potential I/O errors.\n"
> +"\n");
> +}
> +
> +static int aio_discard_f(BlockBackend *blk, int argc, char **argv);
> +
> +static const cmdinfo_t aio_discard_cmd = {
> +    .name       = "aio_discard",
> +    .cfunc      = aio_discard_f,
> +    .perm       = BLK_PERM_WRITE,
> +    .argmin     = 2,
> +    .argmax     = -1,
> +    .args       = "[-Cq] off len",
> +    .oneline    = "asynchronously discards a number of bytes",
> +    .help       = aio_discard_help,
> +};
> +
> +static void aio_discard_done(void *opaque, int ret)
> +{
> +    struct aio_ctx *ctx = opaque;
> +    struct timespec t2;
> +
> +    clock_gettime(CLOCK_MONOTONIC, &t2);
> +
> +    if (ret < 0) {
> +        printf("aio_discard failed: %s\n", strerror(-ret));
> +        block_acct_failed(blk_get_stats(ctx->blk), &ctx->acct);
> +        goto out;
> +    }
> +
> +    block_acct_done(blk_get_stats(ctx->blk), &ctx->acct);
> +
> +    if (ctx->qflag) {
> +        goto out;
> +    }
> +
> +    /* Finally, report back -- -C gives a parsable format */
> +    t2 = tsub(t2, ctx->t1);
> +    print_report("discarded ", &t2, ctx->offset, ctx->qiov.size,
> +                 ctx->qiov.size, 1, ctx->Cflag);
> +out:
> +    g_free(ctx);
> +}
> +
> +static int aio_discard_f(BlockBackend *blk, int argc, char **argv)
> +{
> +    int c, ret;
> +    int64_t count;
> +    struct aio_ctx *ctx = g_new0(struct aio_ctx, 1);
> +
> +    ctx->blk = blk;
> +
> +    while ((c = getopt(argc, argv, "Cq")) != -1) {
> +        switch (c) {
> +        case 'C':
> +            ctx->Cflag = true;
> +            break;
> +        case 'q':
> +            ctx->qflag = true;
> +            break;
> +        default:
> +            qemuio_command_usage(&aio_discard_cmd);
leaked ctx

> +            return -EINVAL;
> +        }
> +    }
> +
> +    if (optind != argc - 2) {
> +        qemuio_command_usage(&aio_discard_cmd);
leaked ctx

> +        return -EINVAL;
> +    }
> +
> +    ctx->offset = cvtnum(argv[optind]);
> +    if (ctx->offset < 0) {
> +        ret = ctx->offset;
> +        print_cvtnum_err(ret, argv[optind]);
> +        g_free(ctx);
> +        return ret;
> +    }
> +    optind++;
> +
> +    count = cvtnum(argv[optind]);
> +    if (count < 0) {
> +        print_cvtnum_err(count, argv[optind]);
> +        g_free(ctx);
> +        return count;
> +    }
> +
> +    clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
> +    ctx->qiov.size = count;
> +    block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
> +                     BLOCK_ACCT_UNMAP);
> +    blk_aio_pdiscard(blk, ctx->offset, count, aio_discard_done, ctx);
> +
> +    return 0;
> +}
> +
>  static int alloc_f(BlockBackend *blk, int argc, char **argv)
>  {
>      BlockDriverState *bs = blk_bs(blk);
> @@ -2800,6 +2912,7 @@ static void __attribute((constructor)) init_qemuio_commands(void)
>      qemuio_add_command(&length_cmd);
>      qemuio_add_command(&info_cmd);
>      qemuio_add_command(&discard_cmd);
> +    qemuio_add_command(&aio_discard_cmd);
>      qemuio_add_command(&alloc_cmd);
>      qemuio_add_command(&map_cmd);
>      qemuio_add_command(&reopen_cmd);


