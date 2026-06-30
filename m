Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE62EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wehDO-0004Q6-4a; Tue, 30 Jun 2026 18:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wehDL-0004Pv-U2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:46:00 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wehDK-0004Rj-9J
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:45:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A62E1408C8;
 Tue, 30 Jun 2026 22:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2CF1F000E9;
 Tue, 30 Jun 2026 22:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782859554;
 bh=rPQp72eYTd+6lIWcs7l+NA5gnGr+DWbIHlo5XcWuHPk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=dh37MX3aQd5SUgwlZof8jYSn41gWSKFxWfefyZ6nxbPJ7jGcdPMsYzCaPgHizfWBr
 bbGBKF+KnqSCgb5mUzMb6htL275jlgCm5cJOl82tCpNZ33HGh7kIQpJgqOhwq4ompm
 gfPZU9XFs73czJkrhp2d+mzXvis5MDnhTYkbT3GCFVSurbCBhFjk1rsw2j1y8qpWxu
 RVaEvQ0rkTcJsVYtNhOOsDc3A44M0Kv7eCIfqXatXY7Lng6v4AB0PdXquEfzcTTQWa
 uhxqO1eQEKOiZv0GcgJAmKkDIwVgioyHObspvJVaboKooF17mwuy2iaXcN9Uuyd0+x
 9ZTS217UV7dig==
Date: Tue, 30 Jun 2026 15:45:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Dusan Stojkovic <stojkovicdusan555@gmail.com>
cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>, 
 Nikola Jelic <Nikola.Jelic@rt-rk.com>
Subject: Re: [PATCH RFC v2 1/2] vhost: accept Xen guest RAM sections for
 vhost-user
In-Reply-To: <20260629-vhost-xen-foreign-mapping-v2-1-19e4685e7575@rt-rk.com>
Message-ID: <alpine.DEB.2.22.394.2606301538270.992629@ubuntu-linux-20-04-desktop>
References: <20260629-vhost-xen-foreign-mapping-v2-0-19e4685e7575@rt-rk.com>
 <20260629-vhost-xen-foreign-mapping-v2-1-19e4685e7575@rt-rk.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 29 Jun 2026, Dusan Stojkovic wrote:
> From: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>
> 
> When QEMU runs as a Xen device model, the guest's RAM is not allocated
> by QEMU and is not backed by a file descriptor that could be shared
> with a vhost-user backend: accesses from QEMU go through the Xen
> mapcache and memory_region_get_fd() returns -1. vhost_section()
> therefore filters out every RAM section, the vhost memory listener
> registers no regions, and starting any vhost-user device fails with
> "Failed initializing vhost-user memory map".
> 
> With VHOST_USER_PROTOCOL_F_XEN_MMAP the backend does not need an fd or
> a process-local mapping it maps guest memory itself through the Xen
> foreign mapping interface, using the guest physical address and domain
> id. Accept the Xen RAM region in vhost_section() so that it reaches
> the backend's memory table.
> 
> The Xen grant region (xen.grants) must never be accepted: grant
> references can only be mapped individually on demand via
> address_space_map(), and deriving a host pointer for the whole region,
> as vhost_region_add_section() does, aborts in the Xen mapcache. Note
> that xen_mr_is_memory() returns true for both the RAM and the grants
> region, so the grants region is excluded explicitly.
> 
> Because of the necessity to exlude xen.grants, the missing stub for
> xen_mr_is_grants is added so that it can be called from common code.
> 
> Signed-off-by: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>
> Signed-off-by: Nikola Jelic <Nikola.Jelic@rt-rk.com>
> ---
>  hw/virtio/vhost.c  | 18 ++++++++++++++++++
>  hw/xen/xen_stubs.c |  5 +++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..26770d06d5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -29,6 +29,7 @@
>  #include "system/dma.h"
>  #include "system/memory.h"
>  #include "system/ramblock.h"
> +#include "system/xen.h"
>  #include "trace.h"
>  
>  /* enabled until disconnected backend stabilizes */
> @@ -657,6 +658,23 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
>              return false;
>          }
>  
> +        /*
> +         * Under Xen, the guest's RAM is not backed by an fd that
> +         * be passed to a vhost-user backend.  The backend instead

can be passed


> +         * guest memory through the Xen foreign mapping interface,

maps guest memory

Other than that it looks OK to me but someone more familier with
vhost-user should review the second patch

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> +         * by guest physical address and domain id (see
> +         * VHOST_USER_PROTOCOL_F_XEN_MMAP), so accept the Xen RAM
> +         * region even though it has no fd.
> +         */
> +        if (xen_enabled()) {
> +            if (xen_mr_is_memory(mr) && !xen_mr_is_grants(mr)) {
> +                trace_vhost_section(mr->name);
> +                return true;
> +            }
> +            trace_vhost_reject_section(mr->name, 4);
> +            return false;
> +        }
> +
>          /*
>           * Some backends (like vhost-user) can only handle memory regions
>           * that have an fd (can be mapped into a different process). Filter
> diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
> index f830768d99..7af39bceb0 100644
> --- a/hw/xen/xen_stubs.c
> +++ b/hw/xen/xen_stubs.c
> @@ -29,6 +29,11 @@ bool xen_mr_is_memory(const MemoryRegion *mr)
>      g_assert_not_reached();
>  }
>  
> +bool xen_mr_is_grants(const MemoryRegion *mr)
> +{
> +    g_assert_not_reached();
> +}
> +
>  bool xen_map_cache_enabled(void)
>  {
>      return false;
> 
> -- 
> 2.43.0
> 

