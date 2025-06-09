Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594DDC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 08:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOYBZ-0002f4-7k; Mon, 09 Jun 2025 04:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOYBX-0002eS-F0
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 04:48:51 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOYBV-0005ty-RZ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 04:48:51 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e4043c5b7so32890457b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749458928; x=1750063728; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbwXZu7dCaQwi0jnqyIdBXAsk/U+tvhL7FIzvPqBYGI=;
 b=ko7XjX9aZaFH7j9j/e7MTCkKuJxdE1tgkA/eZe4wcvBqWMsCxtYDWwKb2G20suEaFa
 9J4RcNg16tiqE6woR1Xt8r0Qo0vRbMpgTwgjpmoUmlyn2ASBLQEw4Fbt6BYQd6BMd1EM
 nnU+jYsoVLuYtStYmiz9CmDJ2Om5ffTUYVZw8JyIZ8SI4nvvph8DUnYv5edPkGMrH9b4
 v+gocvwPDNOHQciCL8FiUr62ZkOHmlYGc3L+9yUlXASMaGkTLrMyIU0RkMWmTKRjgdLT
 rZ/WCE9bXZpQi2NlT8TZqvIi0Dc0wx2X076zGBdwN3WdWPBZPPkDFGhmk9V298FPxAdA
 hNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749458928; x=1750063728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbwXZu7dCaQwi0jnqyIdBXAsk/U+tvhL7FIzvPqBYGI=;
 b=l6Lqk1TKd40O9E5QPcEgkV3Ng20ufdtEVV4Tgj38ahQXg7dVKLaPUGjIPYgfa62h1m
 ZcxwAdCPP4UrYjyDDio4tHYsEWTVIXzKJZaHsfgyMI0jZihKhbbNAI7jcOL88q/5hNSy
 3tJphVUmiOLOzHOq8ayh4weiYprOcFM8JpG0Bj+4UMwoD/XBz0bSbmIW6ktNuD1sF8PQ
 E+BZdHo5LZZl6RrTiLYDAqw5UTF8MAoV1bzxcpIm6rAs0R2JcEsv/oZbwj4i2AYcVafl
 UG+SD2jjCLzsFIsySQxnRRIlYYMlikpin09mQzvM5arxR6JobTXJYog1b59ad3HbB3cO
 tUEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLPzTK4ozl0YqH5ZP7lzc04fnVVjWBbV0SJBHTpe0F5RLIAVBFqhA5SYU14YPMoDBkfa9eWh9vvOY5@nongnu.org
X-Gm-Message-State: AOJu0Yyip2PtSjIHET18nIayLbL3aZUDkil9b2LQgmVAkyvnVbRs9eL/
 OlY2m7rzvdr8y2TvrS5B4UGnXyXKx5F6VUZ5qjnoKuHshoRGKiyljwt5nZlSdLF5P0h/xeivQNH
 0XnxD4GcaBkbzbdY5v0HHrh1H5O7BpZja03UniGOcXA==
X-Gm-Gg: ASbGncth1Koe0PBkxI/7e0bgIjugVOzAUcjBLX1ZnpdTUlsILIJ2VVNAIKxeMhhbfTc
 UdQyLP/jiKVZj1lSpBD3GsWl9d+wReIv9RwcQBlsVScUbUkXnDOH6jy80xC2tXUbVVUjNPKt9/x
 TDvE0En7gDu/lC3O6H+l9ZivvpQzyAo46BN+TeBlTyp1Ty
X-Google-Smtp-Source: AGHT+IFYD/vM7wYCEjhK1XU1rkygFLgWYQLQbGhNUNn7orzdw0frQERDYCyBNS8y+09TRpnBbB63IC3Jzozk0uwGcA0=
X-Received: by 2002:a05:690c:6203:b0:70f:83ef:de07 with SMTP id
 00721157ae682-710f773609cmr166789277b3.33.1749458927819; Mon, 09 Jun 2025
 01:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250609073408.2083831-1-shahuang@redhat.com>
 <20250609073408.2083831-3-shahuang@redhat.com>
In-Reply-To: <20250609073408.2083831-3-shahuang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jun 2025 09:48:36 +0100
X-Gm-Features: AX0GCFunjYxq39f4fJ_ibRVrdhrcQ5C0AytFQLXHhrRaKMKNB6e56Maos0OVy2I
Message-ID: <CAFEAcA8eA2wX1oQeNJfNBYq1NhHgoemYJ-ybOYAgBq2-t9ZPzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] hw/arm: Add the romfile compatatibility
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 9 Jun 2025 at 08:34, Shaoqin Huang <shahuang@redhat.com> wrote:
>
> On arm64, it doesn't use the vgabios-ramfb.bin, so set the property
> "use-legacy-x86-rom" to false, thus the ramfb won't load the
> vgabios-ramfb.bin.
>
> This can mitigate the problem that on release version the qemu can't
> find the vgabios-ramfb.bin if it use the ramfb.
>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/arm/virt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a96452f17a..5f94f7a2ca 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -38,6 +38,7 @@
>  #include "hw/arm/primecell.h"
>  #include "hw/arm/virt.h"
>  #include "hw/block/flash.h"
> +#include "hw/vfio/pci.h"
>  #include "hw/vfio/vfio-calxeda-xgmac.h"
>  #include "hw/vfio/vfio-amd-xgbe.h"
>  #include "hw/display/ramfb.h"
> @@ -90,6 +91,8 @@
>
>  static GlobalProperty arm_virt_compat[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "false" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "false" },

I think we should find a way to make this default to "false"
and only be set "true" for x86. Otherwise every single non-x86
board that ever adds support for ramfb and virtio will have
to add these two lines, which is a source of future bugs.
(Whereas if you forget to mark a new x86 board as needing
the legacy rom you'll find out about it pretty quickly.)

thanks
-- PMM

