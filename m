Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1202DC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxqX-0001ff-9D; Mon, 17 Aug 2026 09:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvxqT-0001bo-VR; Mon, 17 Aug 2026 09:57:46 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvxqR-0004fQ-PS; Mon, 17 Aug 2026 09:57:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:86a0:0:640:75de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 9FA4180D3E;
 Mon, 17 Aug 2026 16:57:38 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d2f::1:33] (unknown
 [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bvUDYv0WMCg0-XJEfkWEp; Mon, 17 Aug 2026 16:57:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786975058;
 bh=S7jTxQ8JQLpZ0vsJiXCdaFMNrwq1i09Zjb4XF0BR1OI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zb6o1ChDHWn/Sbvdsmx/x7qu7Z13ZA2sZUz9UxJNept5DTrBZWQfsy7SlCkFQBSTp
 ++AT0kSalw3qQW5aFJ0wWDnf7y+wnwqBsEsAoNj6U8pM5A/KfcF8819/JphzVNNvWO
 6NwMxiMdFZMQNDYVTJzgk2hyWQ5m287Tj7nUTubo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <60a6748b-1914-4c11-98db-22639028185c@yandex-team.ru>
Date: Mon, 17 Aug 2026 16:57:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: reject persistent bitmaps a node can never
 store
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260716112242.3000035-1-den@openvz.org>
 <cb21314c-f664-444e-a446-f613a40b3151@virtuozzo.com>
 <148de3a9-6d9c-4511-80a0-2367e3b6b48d@yandex-team.ru>
 <7477733d-f51f-4ccc-8732-b03a395b635c@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <7477733d-f51f-4ccc-8732-b03a395b635c@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 13.08.26 22:03, Denis V. Lunev wrote:
> On 7/29/26 21:17, Vladimir Sementsov-Ogievskiy wrote:
>> On 27.07.26 15:05, Denis V. Lunev wrote:
>>> On 7/16/26 13:22, Denis V. Lunev wrote:
>>>> This email originated from an IP that might not be authorized by the domain it was sent from.
>>>> Do not click links or open attachments unless it is an email you expected to receive.
>>>> qmp_block_dirty_bitmap_add() and the incoming-migration bitmap loader
>>>> both create a persistent bitmap with bdrv_create_dirty_bitmap(), which
>>>> always creates it writable, without checking whether the node can
>>>> actually be written to. A persistent bitmap added to an already
>>>> read-only or inactive node stays writable in memory on a node that
>>>> can never store it, and the next global inactivation (migration
>>>> completion, save, or any other bdrv_inactivate_all() caller) fails
>>>> trying to flush it back:
>>>>
>>>>     Lost persistent bitmaps during inactivation of node '<node>': No write access
>>>>     migration_block_inactivate: bdrv_inactivate_all() failed: -22
>>>>
>>>> Patch 1 rejects this at block-dirty-bitmap-add (and, wrapped in a
>>>> transaction, denies the whole transaction). Patch 2 closes the same
>>>> hole on the incoming-migration path. Patch 3 fixes a knock-on
>>>> regression from patch 1's approach: a bitmap that was rejected from
>>>> ever being written can still exist in memory read-only and must
>>>> remain removable without requiring write access.
>>>>
>>>> v1 -> v2
>>>> * approach changed to deny rather than adopt (Vladimir)
>>>> * added patch to add permission check on migration path
>>>> * added patch to change permissions check on bitmap drop to more natural
>>>>
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> CC: Eric Blake <eblake@redhat.com>
>>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> CC: John Snow <jsnow@redhat.com>
>>>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>
>>>> Denis V. Lunev (3):
>>>>     block/monitor: reject persistent bitmap add on a read-only node
>>>>     migration/block-dirty-bitmap: reject bitmap load onto ro node
>>>>     block/monitor: allow dropping a bitmap never stored on disk
>>>>
>>>>    block/monitor/bitmap-qmp-cmds.c               | 19 +++++++----
>>>>    block/qcow2-bitmap.c                          |  9 +++++
>>>>    migration/block-dirty-bitmap.c                | 22 +++++++++----
>>>>    qapi/block-core.json                          |  4 ++-
>>>>    tests/qemu-iotests/tests/migrate-bitmaps-test | 33 +++++++++++++++++++
>>>>    .../tests/migrate-bitmaps-test.out            |  4 +--
>>>>    .../tests/remove-bitmap-from-backing          | 29 +++++++++++++++-
>>>>    .../tests/remove-bitmap-from-backing.out      | 22 ++++++++++++-
>>>>    8 files changed, 124 insertions(+), 18 deletions(-)
>>>>
>>> Hi, Vladimir!
>>>
>>> Will this go through your tree? It is looking like nobody else cares.
>>>
>> Yes, seems so. Thanks, applied to my block branch.
>>
>> There's still a chance to stop me within 2-3 weeks before 11.2 cycle opens.
>>
> Hmmm :-)
> 
> 11.2 seems opened. Is it right time to push?
> 
Was on vacation :). Will do this week.

-- 
Best regards,
Vladimir

