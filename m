Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C563C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljUA-0002pF-EO; Mon, 20 Jul 2026 04:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wljU8-0002oo-As; Mon, 20 Jul 2026 04:36:24 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wljU5-0002tM-9j; Mon, 20 Jul 2026 04:36:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 822B7C01EF;
 Mon, 20 Jul 2026 11:36:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c56::1:1b] (unknown
 [2a02:6bf:8080:c56::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id FaQRMH0ZqSw0-Yxk8VT7G; Mon, 20 Jul 2026 11:36:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784536576;
 bh=KYsbHrDEYJLw3pAeyBWpmqHrZA2y5n+QV4TWUL+vIWs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jo7jGW0uWxCbk1G9d/GCjKBR9Bf4fm0pStDToCelvo1tkKrVvmDtT85upeMvYy54H
 XMVELGTWcL1kJqDYUoYuJoBKlES0kejvS0QMYtM4qyyiSfkNrXVX/6WdXquIdPadG+
 cbMtvKRHkC019jB+Yrr+VnHpew/nPoDWfWwiJggg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ae2d85f0-1a0c-4fa9-8213-e72c1c6a7a4d@yandex-team.ru>
Date: Mon, 20 Jul 2026 11:36:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] block/monitor: allow dropping a bitmap never
 stored on disk
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260716112242.3000035-1-den@openvz.org>
 <20260716112242.3000035-4-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260716112242.3000035-4-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
> block-dirty-bitmap-remove refuses any readonly bitmap outright, via
> the generic BDRV_BITMAP_RO check in bdrv_dirty_bitmap_check(). That
> check cannot tell whether the bitmap is actually on disk, so it also
> blocks dropping one that only ever existed in memory, which needs no
> write at all.
> 
> Drop the blanket check and let qcow2 decide: bdrv_remove_persistent_
> dirty_bitmap() already treats an absent on-disk entry as a no-op, so
> such a bitmap is now released with no write attempted. For one that
> is genuinely stored, qcow2_co_remove_persistent_dirty_bitmap_locked()
> now checks can_write() before it would update the on-disk directory,
> so removal still fails there, with a message naming the actual
> reason instead of just the bitmap's readonly flag.
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

