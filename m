Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A7CC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 21:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnjXE-0007ES-7a; Sat, 25 Jul 2026 17:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wnjX9-0007Dv-Cs
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 17:03:49 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wnjX6-0000su-Ug
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 17:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=itAxkon9PfxLo88l12vGQtk5dAiJWPC8MrbGcMfD36g=; b=fI7mvBZ0feoCtZ+n
 V+kK/oo0OVaVCgUYuRflnDQeDsuQARgf5793AT6qQi57Q3/CNkoB+SC0/o+sRpl962oAY4s7qx8Di
 Lt4r5GbleXqmS3tFtbv1dcpme9TgZjKz+wUJrI0EhOAkbG7GYcNdMe5hvmLUFiGO93uiKj+/hph79
 hCoV2IP/8maMo0qLLvwq5riQBEhgfFjKtDZUrMafAcGD/FuqAXAsOAAshm5ONrUH++o9LwHuMxhB0
 9ap17Zqs+CHClyv5aZpxuYLEo074RmpFva6vebqzOeEUJxR9/FMl+C4oSji4UGuiu4Gncbyu+8f7t
 4ZWApY9EessFyU9aUg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wnjX5-00000005UtS-0Lsy;
 Sat, 25 Jul 2026 21:03:43 +0000
Date: Sat, 25 Jul 2026 21:03:43 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost: do not crash on ring map failure
Message-ID: <amUkr5wi1inale8r@gallifrey>
References: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 21:03:37 up 19 days, 20:44,  2 users,  load average: 0.04, 0.01, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Michael S. Tsirkin (mst@redhat.com) wrote:
> When vhost_commit() rebuilds the memory region table after a flatview
> change, it revalidates cached host virtual addresses for active vring
> parts. If a mapping is stale, QEMU abort().
> 
> This is not a security problem - only the priviledged guest
> can control make it invalid - but not nice e.g. for driver debugging.
> 
> Let's call virtio_error() instead, marking the device as broken.
> 
> Fixes: 0ca1fd2d68 ("vhost: Simplify ring verification checks")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3783
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hw/virtio/vhost.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..371dca17dd 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -755,8 +755,9 @@ static void vhost_commit(MemoryListener *listener)
>                         (void *)(uintptr_t)dev->mem->regions[i].userspace_addr,
>                         dev->mem->regions[i].guest_phys_addr,
>                         dev->mem->regions[i].memory_size)) {
> -            error_report("Verify ring failure on region %d", i);
> -            abort();
> +            virtio_error(dev->vdev,
> +                         "Verify ring failure on region %d", i);
> +            goto out;
>          }
>      }
>  
> -- 
> MST
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

