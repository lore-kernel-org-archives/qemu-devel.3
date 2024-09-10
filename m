Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C61DECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwzq-0002gw-Bt; Tue, 10 Sep 2024 05:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1snwzi-0002gK-T3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:17:08 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1snwze-0005Ja-Pf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:17:05 -0400
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-9p: remove virtfs-proxy-helper
Date: Tue, 10 Sep 2024 11:16:55 +0200
Message-ID: <2706721.SWi19Zl3hS@silver>
In-Reply-To: <20240905082259.360983-1-pbonzini@redhat.com>
References: <20240905082259.360983-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Christian Schoenebeck <qemu_oss@crudebyte.com>
From:  Christian Schoenebeck via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thursday, September 5, 2024 10:22:59 AM CEST Paolo Bonzini wrote:
> It has been deprecated since 8.1; remove it and suggest using permission mapping
> or virtiofsd.

virtfs-proxy-helper is just one component and (implementation detail) being
removed. So I would change the commit log to:

  9p: remove 'proxy' filesystem backend driver

  It has been deprecated since 8.1; remove it and suggest using 'local' file 
  system backend driver instead or virtiofsd.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                        |    8 -
>  docs/about/deprecated.rst          |   23 -
>  docs/about/removed-features.rst    |   14 +
>  docs/conf.py                       |    3 -
>  docs/meson.build                   |    1 -
>  docs/tools/index.rst               |    1 -
>  docs/tools/virtfs-proxy-helper.rst |   75 --
>  meson.build                        |    8 -
>  fsdev/qemu-fsdev.h                 |    1 -
>  fsdev/qemu-fsdev.c                 |   19 -
>  fsdev/virtfs-proxy-helper.c        | 1193 --------------------------
>  hw/9pfs/9p-proxy.c                 | 1279 ----------------------------
>  fsdev/meson.build                  |    8 -
>  hw/9pfs/meson.build                |    1 -
>  meson_options.txt                  |    2 -
>  qemu-options.hx                    |   46 -
>  scripts/meson-buildoptions.        |    0
>  scripts/meson-buildoptions.sh      |    4 -
>  18 files changed, 14 insertions(+), 2672 deletions(-)
>  delete mode 100644 docs/tools/virtfs-proxy-helper.rst
>  delete mode 100644 fsdev/virtfs-proxy-helper.c
>  delete mode 100644 hw/9pfs/9p-proxy.c
>  create mode 100644 scripts/meson-buildoptions.
[...]
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 5ae730d02ae..41d3affabfc 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -517,6 +517,20 @@ The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
>  and later do not support it because the virtio-scsi device was introduced for
>  full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
>  
> +``-fsdev proxy`` and ``-virtfs proxy`` (since 9.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The 9p ``proxy`` filesystem backend driver was originally developed to
> +enhance security by dispatching low level filesystem operations from 9p
> +server (QEMU process) over to a separate process (the virtfs-proxy-helper
> +binary). However the proxy backend was much slower than the local backend,
> +didn't see any development in years, and showed to be less secure,
> +especially due to the fact that its helper daemon must be run as root.
> +
> +Use ``local``, possibly mapping permissions et al by using its 'mapped'
> +security model option, or switch to ``virtiofs``.   The virtiofs daemon
> +``virtiofsd`` uses vhost to eliminate the high latency costs of the 9p
> +``proxy`` backend.

Probably helpful for users to be more explicit like:

  use ``-fsdev local`` or ``-virtfs local``

But in general LGTM, thanks!

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Best regards,
Christian Schoenebeck



