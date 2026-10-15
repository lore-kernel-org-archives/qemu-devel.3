Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17199CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHI5e-0000v0-Io; Thu, 15 Oct 2026 05:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHI5Y-0000rd-Qx; Thu, 15 Oct 2026 05:49:29 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHI5W-0007i1-Ns; Thu, 15 Oct 2026 05:49:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 851488102C;
 Thu, 15 Oct 2026 12:49:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id KnRw6M2ZOKo0-9nmH0HRi; Thu, 15 Oct 2026 12:49:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792057760;
 bh=C7+fwRMIxsO902iFunvX1plN7GmnwEaMXOu+ove2GaY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SjBYtBcv2Zf/MgngFnYQ/jPNgVt5wsMcTKHODIst9ob1/InD926FsqMZgycRnZPYQ
 rEaqbrHs2RcKOTuKlwZUpDL67Kva4fifvFzbnLqBtqjgDwofacysC/v+yVnZaa00Jq
 rUz2E4nS+dg3b0T1IOG8fWbPyBHn+R9YEAhMLoc8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7e0fc64f-b734-46e8-a0db-7eae69b76196@yandex-team.ru>
Date: Thu, 15 Oct 2026 12:49:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] block/block-copy: track known-zero source clusters
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-8-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-8-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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
> From: Denis V. Lunev<den@openvz.org>
> 
> block_copy_reset_unallocated()'s up-front scan already queries the
> source, and the same query reports zero-ness. The copy loop re-queries
> per task and, having no answer up front, can only size a task by the
> copy buffer, so a mostly-zero image is cut into thousands of pieces
> that each turn out to read as zero.
> 
> Cache the answer in zero_bitmap, published by zero_bitmap_valid once
> the scan is done. block_copy_task_create() then picks the method from
> the bitmap and ends the task where the answer changes, so a zero task
> never reaches into data and a copy task never swallows a zero run. The
> per-task query stays as the fallback until the flag is set, since CBW
> intercepts guest writes while the scan is still running.
> 
> The scan and the query it replaces must resolve BDRV_BLOCK_ZERO against
> the same part of the chain, so the scan moves from bdrv_co_is_allocated()
> to bdrv_co_block_status_above() and the base selection is factored out
> into block_copy_status_base().
> 
> zero_bitmap is a plain HBitmap, not a BdrvDirtyBitmap: an internal cache
> has no business in query-named-block-nodes. One writer and readers gated
> by the flag need no mutex, but the publish needs ordering, hence
> store-release and load-acquire. It is allocated on demand, so sync=none
> and a standalone copy-before-write filter do not pay for it.
> 
> Reviewed-by: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> CC: John Snow<jsnow@redhat.com>
> CC: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>

Not a show stopper (I'm not against Eric queueing/already queued this). still,
some things I don't like here:

- block_copy_is_cluster_allocated() not only check for allocated, but also cache information about zeroes
- zero_bitmap_valid - is not only about zero_bitmap, but also say that initial scan was finished, and
we don't need to recheck allocation status of clusters to copy (we use this bit of information in
block_copy_set_task_method())
- .zero_bitmap_valid and .skip_unallocated partly share same function, saying that initial scan was finished,
which is obvious by calling both setters at the end of scan.

This worth small follow-up refactoring.

-- 
Best regards,
Vladimir

