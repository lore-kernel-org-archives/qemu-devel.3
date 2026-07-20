Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF2C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljLM-00077w-2V; Mon, 20 Jul 2026 04:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wljLJ-00077d-Ok; Mon, 20 Jul 2026 04:27:18 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wljLG-0001ka-VI; Mon, 20 Jul 2026 04:27:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 313378076B;
 Mon, 20 Jul 2026 11:27:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c56::1:1b] (unknown
 [2a02:6bf:8080:c56::1:1b])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 8RQECN0XKGk0-GRSujW03; Mon, 20 Jul 2026 11:27:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784536028;
 bh=5G+poiKlqQtGU40Q26Znl8zMkzL9D1bx+jI85HAcFZM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=AOyTfS1aAdNJwl8Rq28A2bxfskUUEoW5JuLgb4t1CLw7yqusWstQK2F09QN2RMEYI
 lkqc7u/UXW35fPutoBUeUM6sROPiRFUVs+0jhQEkkxYltYQfpzr4wBBz8NKqMFikjN
 xFhcD9RrJrBxBYBQYzIskMB4AHOGO0HkjJp1FUZk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0dd80eb6-7510-4453-afd4-b0fe5713b664@yandex-team.ru>
Date: Mon, 20 Jul 2026 11:27:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] migration/block-dirty-bitmap: reject bitmap load
 onto ro node
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260716112242.3000035-1-den@openvz.org>
 <20260716112242.3000035-3-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260716112242.3000035-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 16.07.26 14:22, Denis V. Lunev wrote:
> dirty_bitmap_load_start() creates an incoming migrated bitmap with
> bdrv_create_dirty_bitmap() and, if the source marked it persistent,
> calls bdrv_dirty_bitmap_set_persistence() without checking whether
> the destination node can be written to. Same gap as
> qmp_block_dirty_bitmap_add(), reached via incoming migration: a
> persistent bitmap for a read-only destination (e.g. a migrated
> CD-ROM-class attachment with dirty-bitmaps migration enabled) ends
> up writable in memory on a node that can never store it.
> 
> Reject it the same way, with one difference from the QMP path:
> every destination node is BDRV_O_INACTIVE until migration completes,
> so bdrv_is_writable() would reject every incoming persistent
> bitmap, not just read-only ones. Check bdrv_is_read_only() alone.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Eric Blake<eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> CC: John Snow<jsnow@redhat.com>
> CC: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

