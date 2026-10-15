Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAEDCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHNE3-0007J9-BM; Thu, 15 Oct 2026 11:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHNDy-0007IL-Bn; Thu, 15 Oct 2026 11:18:31 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHNDu-0002iX-EB; Thu, 15 Oct 2026 11:18:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 1BC388105C;
 Thu, 15 Oct 2026 18:18:22 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id LIX3vE5vTW20-QTDG3xg3; Thu, 15 Oct 2026 18:18:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792077501;
 bh=JNsZ4vjFInQvzwDz8YWQGnaLxzxLiMHWVY7iOCkpSOA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=YQhcAlQMJl9RjikoZtdWIoKb9n0XPZVTil6mdwcG02D8Tfx1fBlQWkX4byd5W6utN
 YuIsdzP9m9joYnaywDNwf/QGwH1ICkA4Ap82HWJKvzEisu32o1NGz33wZIvqtZDjAN
 N193Rp+/3pfdQL5CL5sWC/2NfMwZch5Dh8ieGF6Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3a6daa53-7621-4e62-a05e-3f2f940540d4@yandex-team.ru>
Date: Thu, 15 Oct 2026 18:18:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] block/block-copy: coalesce write-zeroes tasks
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-10-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-10-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
> +static int coroutine_fn GRAPH_RDLOCK
> +block_copy_write_zeroes(BlockCopyState *s, int64_t offset, int64_t bytes,
> +                        bool *error_is_read)
> +{
> +    BdrvRequestFlags flags = s->write_flags & ~BDRV_REQ_WRITE_COMPRESSED;
> +    int64_t chunk;
> +    int ret = 0;
> +
> +    if (qatomic_read(&s->zero_widen)) {
> +        ret = bdrv_co_pwrite_zeroes(s->target, offset, bytes,
> +                                    flags | BDRV_REQ_NO_FALLBACK);
> +        if (ret != -ENOTSUP) {
> +            goto out;
> +        }
> +
> +        /* Redoing the range is safe: zeroes over zeroes change nothing. */
> +        qatomic_set(&s->zero_widen, false);
> +    }
> +
> +    WITH_QEMU_LOCK_GUARD(&s->lock) {
> +        chunk = block_copy_chunk_size(s);
> +    }
> +
> +    while (bytes) {
> +        int64_t n = MIN(bytes, chunk);
> +
> +        ret = bdrv_co_pwrite_zeroes(s->target, offset, n, flags);

also, here we ignore s->mem: we've allocated 0, but now use buffer of n bytes.

-- 
Best regards,
Vladimir

