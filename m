Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A25C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSXE-0007qp-W4; Wed, 08 Jul 2026 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1whSX0-0007pQ-H6; Wed, 08 Jul 2026 09:41:42 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1whSWy-0005qk-BE; Wed, 08 Jul 2026 09:41:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRL0sDk9x+9aA0Cwffsqvb4EIi12y4sdcYsMl2jdAFdeAFihQOZulr36dXkxh/JrNL0V6cYAKLOnkBY4QDs08rv5perJLVyWUv7/IramaGnVZJbRfnK+ZNR23RsON6Feok/uatYzfyNRtHwuBy0Ivt8a2yVQMSNFEJMNUa5OWCjwrLM2gxmGRlaV7Wwn8grD8XyTIcC5lOLCMLHmAUo7jQTnRP9hiOl+mpQf/pHo1BaTenpPACJqgniEX7ZK2S/leaG4upeova5rQxwUAimVW5JpIOhD5XMwTuskoSX7E08KYVcCjj+l6XLqR7HSpZ6BhQfZ87JZp91QlyAYmi399g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fqh1YAaqhL6IN9NLdzLm/kkoI0Wc5fUKbyT1VyNfCc=;
 b=bDtHW2ulVoLc0BmpNKzJJqLWeFb4Zi8NuA7tY2eufxASUFsEK8GmNMjjSoywZqjq1jdnifw4/eXl3l6bJAPTQAXmSEAoXp4dkx0nTnaMjZuaPqBolV9Qxd6gBYgg50ksmrXuTVaG7xv0oQKbUwlRUylfTfiDr2jncaEW0CLCVvgGm+bFfbSOMBBFT8O+OrarfVo8XH8RnWgM9cS1N2fdM8MHTj4utxUjzABRAVn7ZDLFiqj+ikV1jRg3gKL8toywT7aq+V5qQlP5r+4WUxasPvLqI2OhvhHRNt1/czbWzPz1lbXAEGgOIk6NfDV6A1fANc09zy+OJ06vWAjThH2SCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fqh1YAaqhL6IN9NLdzLm/kkoI0Wc5fUKbyT1VyNfCc=;
 b=phFi7eINcbrD9OachqGr6ymeURGF4cNmyCr9NeEcMd7CsV34Rp/CUMW6DhedGj/ra1iQ5TSHF+6Pfgrrhy+t8PLZcoEv9Cs+yJJ4s8NcWXZv9IIn2qMkrys7axAH0clpqUkRTZ1MVXbHOkzifxHl8h/9KwQ4oRt7pl6JxHf78sagwR62YowIvHEiDA9HyEHRZx8jG8dY1nCcA6KpGzfuIttgajVIU7j/iqEgse82Fm12J/zc01+tMi3mNwxAHMyPjQNwWpkFc/mRmboSAS4lBBo0gDiqL9g25dhhdmts48oSMsa6L1Cs2/QJA+p3H3RnDHuH0Apj/HHwCIGMXFRIgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRZPR08MB11099.eurprd08.prod.outlook.com
 (2603:10a6:d10:138::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 13:41:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 13:41:28 +0000
Message-ID: <282e537c-7ae7-43f4-8b7c-7f210949a30c@virtuozzo.com>
Date: Wed, 8 Jul 2026 15:41:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block/monitor: force read-only on live-added
 persistent bitmap
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <20260706161645.515304-1-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260706161645.515304-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0217.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRZPR08MB11099:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fe3258-0c7b-4f04-fb1e-08dedcf69ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 6gWdduFnARSLf/Ezv6v10ZzymnkjRP9vVxIYKK4GVByHSAX9aWt7GjTw6gxCXp6ddUj+Cu0brDwpjeWMwhMmh3Rh2nv3NVZfsa7mJi/LAuJuwBVPL+wOOzcXgxqL4/rrtLNQTCjoWAyoraf0MzgRSWAZv4pwbfp8kUXrxffo4VYAhq/nI+c/fhWgdicv6tF4j2AUbp8BAuZCheFSft6buASH/DtCTfvzR3/uAtBKrCVB3a1LarpXtYAk7FzRESZZh8iqtpQnOg0toMnQum+1pi+x8JzKHUae3B+whKepvBc70lwS9S8qdTY/9IqKjOv+voLIKp2F5TONdqOTD+oEhxwFo62kAk573cFpKyHSoKS/qx9RIcyMUQ9QOAzXkgK3xIfF7V7yHjhTCG8W/dpLOzj8HlJ5TjR4iVAdYWAAF7gCeSgcGhdFMiro2FYpKCDxNPqNExi62uUVfLcVNiRCdrViLH400dXn1H2+sE0camJOlhgmULy34rWwKVGJrTyWjG8gNb4m2bQLJYw+pJeBRW3PJYqRvcBFc0jrn4QqxUIl+wfu68LuQGXfv/lJ375eqFYvZCIPkqr64tIEwOwxgTYT0vYaQDahMFncUDd3FSQWdYugMMM7EWEhwlnor0D5K63c85OX5kJVYm3JYuPU8t8vffTO+N6w55gIu7pkOCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2FzS2UwdnlYYkJMRmM4WU9NaEtFbjUzOVFhNngyaHBlQ25USGJMS0draHQr?=
 =?utf-8?B?M1dCYmkwMUo0QS9xTVE0RjJOcWd0OVd0VzdYQndyNXBhT0t0YW9BTmliZE5O?=
 =?utf-8?B?N0lsdGtXcTg2OWNaWkdwbCtJNkY0ejNTYjRRQkVlMm5EK0pCbE0wMWlNUVlJ?=
 =?utf-8?B?aEkxWGJpVWhhbjExOCtlUk9tZGN6OEYzOVFsY0ZkRTZteFlQcW1STzcrd1Jr?=
 =?utf-8?B?VnZhV3M3M1hFTDltQXd3UStCUGVYME1wNUt4cnRSZHBoOUV3clBpQlY1MWdW?=
 =?utf-8?B?RlhzdGlrOXlCdFI5dFlTRXlZc3J0REtnUGFYTjI2KzB5OE9TUnJyclBEekZI?=
 =?utf-8?B?dE9vOCtUeVNiRGlzOHNqUy9DZlVmRG1NUEZRR0MwTWlLWWltMEkyR0NES05Z?=
 =?utf-8?B?YU12NlJKUm4rOGdNd2xFUHBmQURZTGtzL1ZSbFJ1VzV6VzBRb1REd01OUXly?=
 =?utf-8?B?eVBTYmcwWEUyb1pDVXdqWnV3L1gvbk1ReUppWWJZRzJKQzRQUG94cFZtWFNE?=
 =?utf-8?B?eGo4U3c3ZjM1cjM1N3psZlc0NHpLaWdjVzZCeWkrd0VxWXFzNC82MkMrTlp4?=
 =?utf-8?B?bkoyblluWXcvZjVkMlhqWURTd0JiNk8yaVFkR0x3T3E1eXhjWWN2bDBzRGFM?=
 =?utf-8?B?cFR2YU5LZEV0Ty9WOTUya1h0WjRZY1lBeTRaL3NDVUIya1A0MlZUVTNqd2Yz?=
 =?utf-8?B?YlJsV2FWZUFpYkJXeXhDaTdaY2E3dFNPWFVPbm1Ybmt6TDhVVGZvU0tyM3Vw?=
 =?utf-8?B?OGhwWlFLMDFwK3N5SE9TWTlsRWFnT29KNFZjenRWcUlvbmkzdG5SaUZVc2xW?=
 =?utf-8?B?RDNUelcwUG1mQUhHT0FJaU02YVI3R2lpRkVDcUVVR2dFNUFvMmhtd2NjeDhk?=
 =?utf-8?B?VTN0SzQ0LzZxSnJzdGtzZFl2aFF0RnAxQ1dnQkEvVVFzUkVFcmcxNTI5SHRu?=
 =?utf-8?B?QmJnSTRoVTAwaFUraDlPK1c2MEdSWVYvZVhsVHVxMlhxRmhPNlJEQXZCYXlZ?=
 =?utf-8?B?d1VIWVN1c0l5c0hzMmJqZTUvckpRWmpHeWdSRm51Q3JVRmtTSGVBTnZsMEZK?=
 =?utf-8?B?bmxSMi9MTmZkYkFGUmZnekVQVnhEVUUrZW5zb05zR1VvL3pPTUkyV1JFekt5?=
 =?utf-8?B?WkJ2c1ZzY2ZBNWV4ZU5mL05tREZlMzc1WTRqL2EvUXdudW14N04zRmFoWDFK?=
 =?utf-8?B?TGhtSHNsZitlR3NkMjZycWI0ams4ZGFmYXZ5eWthV2xTU0N6VUlJOUg1Wnpy?=
 =?utf-8?B?WlBNdTlSd21UQlRsMHB4TVJkcWZwK1J4Y3R4eWtiV2dTMnlxY3lkQzBpRFpS?=
 =?utf-8?B?Q005L2FaNGd5K0RvekFqd0RxOEpvRTB5STJKSGpxUFdib2pPb3pJdjNSVkR2?=
 =?utf-8?B?MlRGMHNjVWhhaEJHbnRBNEZNWnJCM3hBQlcyTGRXdzM3K1ZvTTVhWTArVzc3?=
 =?utf-8?B?WFhySmJGRWdFRnRib291Rkd4MjdJRFFaME5NcTBNSkhjRFh0bGFDY3JhUEFX?=
 =?utf-8?B?OVU4aTlQcGV5cnpGUVRWb1ZERXJleFdoYkdmK0NUS09LRlhsM2pTU09XM3Zk?=
 =?utf-8?B?czFNa2ZXUVhMSWRoOExkT1cyQkJJQ011SFNZMHM0aUsyYWM0bHc0a2xiVVJa?=
 =?utf-8?B?QWhteTlzbThPbWhDVldmblIwZzJvL292VEhkdDVpVC91YmowOVkxZ3lLUEkw?=
 =?utf-8?B?QlNLOGRrNkxrVGZSSE9zY3lOSVNya3pxVHdwQ3VKMmlpa29ldDFyUFpjcExt?=
 =?utf-8?B?OXVQMlRRTHFuWjIyQ0RYdXRWNU54ekNtaWtwUU9JTXhMbjNFcWlRand2YnpO?=
 =?utf-8?B?ZDdXU2ZnY21ObGJLd29YRjluT1I5VHhrdXVQeXpzRFJMbVR1aFBWNEp6UVJj?=
 =?utf-8?B?aFNQVkMyeTFRYnprNHlJbS9EaHZ2cVRpU0UvVFpkb2FOQk15NVB5SWpRVStP?=
 =?utf-8?B?aG9LbVhhbWNSU0dMTlNPM09UUHRmQUZEZkE4SWRvVENibHVpOEJQTGpSTnUw?=
 =?utf-8?B?blI3eFpuZlJRWHlSb2E4VGZ2aUw5NG55dFRWRWNuL0xnRjY0dnpkUGk2ZEJU?=
 =?utf-8?B?WFJFYkdBUkFGb0ExUnM1b1RveURIbUFUeWsxVGEyZlR4VDBjemZQOXdyUlJ2?=
 =?utf-8?B?VUVKLzI3WW9UcURpMUxoWW9rdG8zWllGQjdZNEFmUnByY3dqMHRlMVE3aW9t?=
 =?utf-8?B?eXgveVllMXduQ0p0MmRpYjk1WHl5elNRMUxKbDBSUTlFeEY2YmxQTkc2K2ZE?=
 =?utf-8?B?allJQ1ZKbEFIay9PVUhnY3k1WFl1L3FMQTNsbTRWTVNKbE1JcWJTanBkZFVT?=
 =?utf-8?B?bUFwSVNSQ3p1Y3BTN0c1UUM5NE03cGV0ZDQrNFk2bkRScUZMak4xSFJNYVV5?=
 =?utf-8?Q?h3jYjwQUJ5PrEEwY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fe3258-0c7b-4f04-fb1e-08dedcf69ced
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:41:28.7518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHeeoSvBVMvL2enUKivV3q02sIjlSz13l4tA8Os6ZxRPgbXzy4iDB3s7ADIekqrjGA7QMNS1zJ8g4nm8B5IwC9amUvy0+o1rBZ4LpbzrZKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11099
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 7/6/26 7:16 PM, Denis V. Lunev wrote:
> qmp_block_dirty_bitmap_add() marks a new bitmap persistent without
> checking write access to its node. bdrv_create_dirty_bitmap() always
> creates bitmaps writable, so a persistent bitmap added live to an
> already read-only node stays writable in memory on a node that can
> never store it. The next global inactivation (migration completion,
> save, or any other bdrv_inactivate_all() caller) then fails trying to
> flush it back:
> 
>   Lost persistent bitmaps during inactivation of node '<node>': No write access
>   migration_block_inactivate: bdrv_inactivate_all() failed: -22
> 
> qcow2_load_dirty_bitmaps() and qcow2_reopen_bitmaps_ro() already force
> a persistent bitmap read-only when its node is read-only; do the same
> right after the bitmap is marked persistent, whether it arrived
> through a plain block-dirty-bitmap-add or the transaction action that
> calls the same function. qcow2_reopen_bitmaps_rw() already promotes
> any persistent, read-only bitmap back to writable once its node is
> reopened read-write, so the reverse direction needs no changes.
>

As Vladimir noticed, we don't really get our non-persistent bitmap
automatically converted to RW on reopen, as qcow2_reopen_bitmaps_rw() ->
bitmap_list_load() only loads bitmaps actually stored in the image.
Before that patch, after RW reopen we have both the node and the bitmap
in RW.  But with this patch the bitmap stays RO, and we can trigger an
assert crash by issuing a backup.  Here's a script which reproduces it:

> #!/bin/bash
> set -u
> 
> SRCDIR=$(dirname "$(readlink -f "$0")")
> BUILD=$SRCDIR/build
> QSD=$BUILD/storage-daemon/qemu-storage-daemon
> TEST=$(mktemp -d)
> QMPSHELL="$BUILD/run qmp-shell"
> QMPSOCK=$TEST/qmp.sock
> QSD_PID=
> 
> cleanup() {
>     [ -n "$QSD_PID" ] && kill "$QSD_PID" 2>/dev/null
>     rm -rf "$TEST"
> }
> trap cleanup EXIT
> 
> qemu-img create -f qcow2 "$TEST/tgt.qcow2" 1M >/dev/null
> qemu-img create -f qcow2 "$TEST/src.qcow2" 1M >/dev/null
> qemu-io -f qcow2 -c 'write 0 1M' "$TEST/src.qcow2" >/dev/null
> 
> "$QSD" \
>     --blockdev file,node-name=tgtfile,filename="$TEST/tgt.qcow2" \
>     --blockdev qcow2,node-name=tgt,file=tgtfile,read-only=on \
>     --blockdev file,node-name=srcfile,filename="$TEST/src.qcow2" \
>     --blockdev qcow2,node-name=src,file=srcfile \
>     --chardev socket,id=qmp0,path=$QMPSOCK,server=on,wait=off \
>     --monitor chardev=qmp0 &
> QSD_PID=$!
> 
> $QMPSHELL -p $QMPSOCK <<EOF
>     block-dirty-bitmap-add node=tgt name=bmp0 persistent=true
>     blockdev-reopen options=[{"driver":"qcow2","node-name":"tgt","file":"tgtfile","read-only":false}]
>     blockdev-backup job-id=job0 device=src target=tgt sync=full x-perf={"use-copy-range":true}
> EOF


qemu-storage-daemon: ../block/dirty-bitmap.c:670: void
bdrv_set_dirty(BlockDriverState *, int64_t, int64_t): Assertion
`!bdrv_dirty_bitmap_readonly(bitmap)' failed.


> Also check BDRV_O_INACTIVE, matching qcow2's private can_write()
> helper, to cover adding a bitmap to a node that is already inactive.
> Document the new behavior on BlockDirtyBitmapAdd.persistent.
> 
> Extend remove-bitmap-from-backing to cover this: add a persistent
> bitmap live to the already read-only "base" node, then inactivate all
> nodes the way migration completion, virsh save and qemu-update do, and
> check the bitmap ends up as protected as one already on disk.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> ---
>  [...]

