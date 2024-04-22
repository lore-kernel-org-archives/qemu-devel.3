Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56B2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 08:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryocf-0003hu-Ej; Mon, 22 Apr 2024 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ryocZ-0003hg-TX
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ryocV-0002XS-6T
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713772905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tO36o8QwXnl+cDvn/M4XF5ENyyOb8jjCbE7JS/ClbP8=;
 b=iZhWLTBv/xzfiv35VNlHMZSXV7scbom7nlvhczpx8fQLc1fl2LJjvI2c8C/oKPzeN3sD7G
 CzyN2EFAay7xdIo+N2oR55PU7sNJrObNuaOSHIk3kwKADKdMpoNaIC+JrJ+EWKojgIT5B3
 JWG7niBEZxAVXVqJWVwR1rGswyytI5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-iHyt3Y8mNwqsIow81pa1Aw-1; Mon, 22 Apr 2024 04:01:41 -0400
X-MC-Unique: iHyt3Y8mNwqsIow81pa1Aw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3536F834FB4;
 Mon, 22 Apr 2024 08:01:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BA5A581DC;
 Mon, 22 Apr 2024 08:01:40 +0000 (UTC)
Date: Mon, 22 Apr 2024 09:01:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v8 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
Message-ID: <ZiYZUZq7VzSM7BYP@redhat.com>
References: <20240419185952.991930-1-dongwon.kim@intel.com>
 <20240419185952.991930-3-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419185952.991930-3-dongwon.kim@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.42,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 19, 2024 at 11:59:48AM -0700, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> New header and source files are added for containing QemuDmaBuf struct
> definition and newly introduced helpers for creating/freeing the struct
> and accessing its data.
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/console.h |  20 +----
>  include/ui/dmabuf.h  |  81 +++++++++++++++++
>  ui/dmabuf.c          | 206 +++++++++++++++++++++++++++++++++++++++++++
>  ui/meson.build       |   1 +
>  4 files changed, 289 insertions(+), 19 deletions(-)
>  create mode 100644 include/ui/dmabuf.h
>  create mode 100644 ui/dmabuf.c
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 0bc7a00ac0..a208a68b88 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -7,6 +7,7 @@
>  #include "qapi/qapi-types-ui.h"
>  #include "ui/input.h"
>  #include "ui/surface.h"
> +#include "ui/dmabuf.h"
>  
>  #define TYPE_QEMU_CONSOLE "qemu-console"
>  OBJECT_DECLARE_TYPE(QemuConsole, QemuConsoleClass, QEMU_CONSOLE)
> @@ -185,25 +186,6 @@ struct QEMUGLParams {
>      int minor_ver;
>  };
>  
> -typedef struct QemuDmaBuf {
> -    int       fd;
> -    uint32_t  width;
> -    uint32_t  height;
> -    uint32_t  stride;
> -    uint32_t  fourcc;
> -    uint64_t  modifier;
> -    uint32_t  texture;
> -    uint32_t  x;
> -    uint32_t  y;
> -    uint32_t  backing_width;
> -    uint32_t  backing_height;
> -    bool      y0_top;
> -    void      *sync;
> -    int       fence_fd;
> -    bool      allow_fences;
> -    bool      draw_submitted;
> -} QemuDmaBuf;
> -
>  enum display_scanout {
>      SCANOUT_NONE,
>      SCANOUT_SURFACE,
> diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> new file mode 100644
> index 0000000000..e332958c39
> --- /dev/null
> +++ b/include/ui/dmabuf.h
> @@ -0,0 +1,81 @@
> +/*
> + * SPDX-License-Identifier: MIT

QEMU's expected license for new contributions is generally GPL-2.0-or-later.
If you need to diverge from that please explain why.

> + *
> + * QemuDmaBuf struct and helpers used for accessing its data
> + *
> + * Copyright (c) 2024 Dongwon Kim <dongwon.kim@intel.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */

> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> new file mode 100644
> index 0000000000..ef3b07956e
> --- /dev/null
> +++ b/ui/dmabuf.c
> @@ -0,0 +1,206 @@
> +/*
> + * SPDX-License-Identifier: MIT

> + *
> + * QemuDmaBuf struct and helpers used for accessing its data
> + *
> + * Copyright (c) 2024 Dongwon Kim <dongwon.kim@intel.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


