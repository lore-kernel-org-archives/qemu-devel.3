Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856C4CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHILe-0003Wg-1G; Thu, 15 Oct 2026 06:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHILS-0003Vr-5n; Thu, 15 Oct 2026 06:05:54 -0400
Received: from forwardcorp2d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df02])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHILP-00015I-Hu; Thu, 15 Oct 2026 06:05:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.yp-c.yandex.net)
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id DE41B8031E;
 Thu, 15 Oct 2026 13:05:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id j5SuZ739QSw0-mi203dLv; Thu, 15 Oct 2026 13:05:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792058745;
 bh=EEMC0BB9XWzpaX8TFjDEf7t3do8jIsny9Olf/SX1nlw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1cP/CKLnk51raE8MntfyfxKHboTRbTowxz8BWV8DgtkT7fsuyFdY1cTCDTRWohO2A
 2wbz/ez4+JZbWWNA5QMEHdDqTpkKBj0oo8Y5yYb0+PxPNZqECOKhAM+0LuXW5oFvdR
 oYFgqsD2oXMzfanu/HNkcBXYARp05/Xh7kPEuYpE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5540b855-67bf-466f-903d-ea9539a2173c@yandex-team.ru>
Date: Thu, 15 Oct 2026 13:05:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] block/backup: pre-fill zero_bitmap for full/bitmap
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-9-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-9-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df02;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On 29.09.26 18:51, Denis V. Lunev wrote:
> +/*
> + * One scan step, like block_copy_reset_unallocated();

Is there a reason to have same function? It plays very similar role,
seems it could be one function (block_copy_prescan() ?), which queries
block-status and does corresponding changes in the bitmaps.

@cached_end
> + * tracks progress across calls, @count how far @offset should move.
> + */
> +void coroutine_fn GRAPH_RDLOCK
> +block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
> +                                 int64_t *cached_end, int64_t *count)


-- 
Best regards,
Vladimir

