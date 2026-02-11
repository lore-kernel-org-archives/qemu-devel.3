Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23983ECD6F8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 23:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqJVo-0000vP-7N; Wed, 11 Feb 2026 18:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqJVZ-0000uY-5a
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:20:34 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqJVW-0002bK-F2
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:20:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770852019; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GdRqMI1uTy9cksEGCHNQjABIshDgWDVE8MfuT9Pz146k0C9TogkTFow9xnon0wKJeCScwNGwcm1jQ53nGWYeGQE3lD/n8TXH1OjVD7mN0uTTUp4DY7sXI6EM9BhmVy5Q+4Ec/ZrYJIDbvWhMXZm/BMc8dLrNV3LVvwad/tlo1PU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770852019;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bCHmr7NIzO7kDFjl4IuroeqwYjF4yy9BY8coQf4Ugds=; 
 b=YHaKvarQc95H5nR6dv+HlztjfGWNxrRGnrhTEkEY9sriupsBmQA/Q3b1kAexBrgw8QQvGVtRg9IyyP+vu/3YJf+cMbHlJEz4Wl8NGpy4VlZANo5qTIZKz3NlA5Mzrz1iUrtTpRcK57gVttPwjI2zdxX/aRGZh01k6OQmaq7Sskg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770852019; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=bCHmr7NIzO7kDFjl4IuroeqwYjF4yy9BY8coQf4Ugds=;
 b=P+DrXBja5gT2xf9DqN46StKfiPPO9o8iwC1UTYbJIph2uKAW2dTsoMxtDyfCkkNj
 sBc2nYw5Vnxc3cs+U33xYzQBPsjKy1LVwCsNOCrwxZ+n6CZ52dm3gCcsUYsgtRltLKd
 BdDdjWOPJcLeY5IaCNmBXuYvgMn7kX5BMOVHoCP4=
Received: by mx.zohomail.com with SMTPS id 1770852018168829.7198198843029;
 Wed, 11 Feb 2026 15:20:18 -0800 (PST)
Message-ID: <63edf388-e076-43a3-8a3a-929063159ca0@collabora.com>
Date: Thu, 12 Feb 2026 02:20:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] virtio-gpu: Force RCU when unmapping blob
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
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

On 1/15/26 08:38, Akihiko Odaki wrote:
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
> Changes in v3:
> - Fix immediate timeout in qemu_futex_timedwait() for Windows.
> - Dropped patch "timer: Rename init_clocks() to qemu_clock_init()".
> - Link to v2: https://lore.kernel.org/qemu-devel/20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp
> 
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
> Akihiko Odaki (5):
>       futex: Add qemu_futex_timedwait()
>       qemu-thread: Add qemu_event_timedwait()
>       rcu: Use call_rcu() in synchronize_rcu()
>       rcu: Wake the RCU thread when draining
>       virtio-gpu: Force RCU when unmapping blob
> 
>  include/qemu/futex.h          | 36 +++++++++++++---
>  include/qemu/rcu.h            |  1 +
>  include/qemu/thread-posix.h   | 11 +++++
>  include/qemu/thread.h         |  8 +++-
>  hw/display/virtio-gpu-virgl.c |  1 +
>  util/event.c                  | 28 ++++++++++---
>  util/qemu-thread-posix.c      | 11 +----
>  util/rcu.c                    | 98 ++++++++++++++++++++++++-------------------
>  8 files changed, 131 insertions(+), 63 deletions(-)
> ---
> base-commit: fba5c49719875145f1dcb44fbe85f541a47805c6
> change-id: 20251027-force_rcu-616c743373f7
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

No problems spotted

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

