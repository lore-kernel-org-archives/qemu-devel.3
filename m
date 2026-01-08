Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C2DD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdib2-0004vr-7Y; Thu, 08 Jan 2026 00:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vdib0-0004ub-AV
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:06 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vdiay-000509-5t
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:06 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767850191; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cT1llrEVd/ZK5r3RjQpe5z5UhR9fxG7HFefWTX2eVxwEjLJRjMhONThwICUyjfCZw34OXz0Tvn+dDBWPYqaN64XPhCBqNbNlL8COK6mroj7FxyMN19jfKSlO7RdlgwvrCOk0eeoR7SJ7Pg5EClDkbMGvuWYkfP37j7or6uUl4l8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767850191;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uB6QviAEXcUQ6Gb0tWYD7KtTpwkUuA6zfvGZ/lDG/xA=; 
 b=dUAQ9UxjMzAbbqk8MouCYAVcFO721iJcn4/0EzFaLEdA9BKFu7VJ1bC+rYUSNF3tWlU8WzF3aRFw3LQ3/xvQB5bEg4rGQr2nXFMoyJzZ75Y6WySveHH2pR9h7a9ACAyim6ituEd4jy9TMz/6luwQ0hW9n3iFeBU0QVbNtQZu86M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767850191; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uB6QviAEXcUQ6Gb0tWYD7KtTpwkUuA6zfvGZ/lDG/xA=;
 b=fya3lEyxpUDGYJzzH0nXYZHsBz+qKmxcfMeK3erVvteDMgOQKaf7UdbDkf5YbkQO
 Wdo2jrHwamKODHr+8XOJAub9q0pr1poV/0c5SrS2yNJr7q7r3YOAhJXJGXvSeBXerEl
 /OzMrhYXlPigtZCVFUqcozj5ijG+NBnnfG/1EiMo=
Received: by mx.zohomail.com with SMTPS id 1767850190559822.0523300479281;
 Wed, 7 Jan 2026 21:29:50 -0800 (PST)
Message-ID: <b7a10a62-f664-4690-8d3a-1219182cb1fe@collabora.com>
Date: Thu, 8 Jan 2026 08:29:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] virtio-gpu: Force RCU when unmapping blob
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/13/25 08:41, Akihiko Odaki wrote:
> Unmapping a blob changes the memory map, which is protected with RCU.
> RCU is designed to minimize the read-side overhead at the cost of
> reclamation delay. While this design usually makes sense, it is
> problematic when unmapping a blob because the operation blocks all
> virtio-gpu commands and causes perceivable disruption.
> 
> Minimize such the disruption with force_rcu(), which minimizes the
> reclamation delay at the cost of a read-side overhead.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Stopped overloading the call_rcu1() and force_rcu() notifications onto
>   one event. This fixes a deadlock after try_dequeue() caused by
>   incorrect masking of call_rcu1() notifications, and eliminates
>   spurious force quiescent states caused by being confused with a
>   call_rcu1() notification.
>   Tested-by: from the previous version was not collected because this
>   changes the logic significantly.
> - Merged the rcu_call_count and forced variables into one to avoid
>   the race between them that used to require a loop to resolve.
> - Aligned the type of the duration variable in qemu_futex_timedwait()
>   for Windows.
> - Fixed timespec of qemu_futex_timedwait() for 32-bit Linux.
> - Link to v1: https://lore.kernel.org/qemu-devel/20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp
> 
> ---
> Akihiko Odaki (6):
>       timer: Rename init_clocks() to qemu_clock_init()
>       futex: Add qemu_futex_timedwait()
>       qemu-thread: Add qemu_event_timedwait()
>       rcu: Use call_rcu() in synchronize_rcu()
>       rcu: Wake the RCU thread when draining
>       virtio-gpu: Force RCU when unmapping blob
> 
>  include/qemu/futex.h              | 34 ++++++++++++--
>  include/qemu/rcu.h                |  1 +
>  include/qemu/thread-posix.h       | 11 +++++
>  include/qemu/thread.h             |  8 +++-
>  include/qemu/timer.h              |  4 +-
>  hw/display/virtio-gpu-virgl.c     |  1 +
>  tests/unit/test-aio-multithread.c |  2 +-
>  util/event.c                      | 28 +++++++++--
>  util/main-loop.c                  |  2 +-
>  util/qemu-thread-posix.c          | 11 +----
>  util/qemu-timer.c                 |  7 +--
>  util/rcu.c                        | 98 ++++++++++++++++++++++-----------------
>  12 files changed, 137 insertions(+), 70 deletions(-)
> ---
> base-commit: 466e779e05b5087bffe39ecc51ec97fdf9121e8b
> change-id: 20251027-force_rcu-616c743373f7
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

The first patch renaming init_clocks() doesn't apply to latest staging
branch because there is a similar change there, so I skipped it. Tested
with venus and drm-native contexts, no problems found.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

