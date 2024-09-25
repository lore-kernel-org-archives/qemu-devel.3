Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCDCC369A3
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 07:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stMce-0008Bq-0M; Wed, 25 Sep 2024 03:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1stMcX-0008As-B5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:39:33 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1stMcV-00011y-Iy
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:39:33 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-277f35c01f5so3147873fac.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727249969; x=1727854769; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kc9k10rSZo9QKTYxcciOx1iH3io5xAgI5hPOVhjTmkE=;
 b=QayuTU/4ipDny9W98IufKY+l6P6eCCk27GrkENISzY8XwMfG0WX4xRGCxtKhbHx4RG
 umdUN7qSCBhmrX01iWJ4bXbhLwNUa6jcHyoaQaJ5UM8d0MC13Dc8Lv6Qjd/67JU9nwRI
 Bjlza+APObUk2f9FpfZQjzrDbrjpiFdJgERKmjnfyXsZQJU/EoQcXcHX4F2vYeg1KM+E
 Rv+Y2BtQm++eIsJ0A3+PXZ7BVhp+je61pyIqJETJoOTaoJxVnd9WjUzq7087HpyFNdH2
 9C1ReNMRp98UWqvgcl8SKJA/8hUw+d3uuLM8IKgteq8Sj4PMSSVaznHGMIoPXtQThRW3
 RLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727249969; x=1727854769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kc9k10rSZo9QKTYxcciOx1iH3io5xAgI5hPOVhjTmkE=;
 b=FkCM/pNJv0GkwkX3MKgzpJBb9UHZemvCttZGkvoJ88pOMXxcFrYtf/8x7U4cUzJ68G
 9zP4wE59I9esa9uHyZC8ZY5eIVfCi69uXw/MLkaDoUtjeT9sp8dfPUEm2tjND2t9yqfu
 p5cggnUFgm6yXjRrW0i4ok6iRzm3EdRbVnlytlIQjVW0Qb0hznchbVt61ZcqwF9J6/4W
 ny/XlVjVb6EngQQPgIP9YBpJkoVGUfNPPpWwWs+irTyPzIegsiEOiDyKlgNUGloMDwO9
 RC1lsVrDuxpHABtKQ82loh6tbi+f6mQQgUBxjVteIB5MfwZ5Es0gX+ZTcfki57G9sDsM
 Wr9Q==
X-Gm-Message-State: AOJu0YwC0pVFyM8+7DhC1NsBMW1UeQ/tMZw9fPgQyuNgNAIXxH7CDlK2
 T3w+/CYjRNJN77HXirZBY4W9/rlKDF4ijrY4kRAwAwk8ORmomI6mHlTU7O2OgIgRFPrTM1a/FRo
 KhlXa8YPoJo0RIS1y0wiD44RWQHs=
X-Google-Smtp-Source: AGHT+IFMu1GdFL5Jb2KHOhBJ/z3ssJQGW2NhTxg66+6Y0qjgxgqqvNiqc6Ncj7cE1L4a5t8wdt1eL4zRPk9YUUDyhrE=
X-Received: by 2002:a05:6871:28a8:b0:277:f16a:97e8 with SMTP id
 586e51a60fabf-286e1600470mr2038322fac.38.1727249969572; Wed, 25 Sep 2024
 00:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240906101658.514470-1-pbonzini@redhat.com>
In-Reply-To: <20240906101658.514470-1-pbonzini@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 25 Sep 2024 09:39:18 +0200
Message-ID: <CAM9Jb+gZ4+M1GOvRy6x8eg8OgOCyoEkBwKS6ZYQhGOOYndh6_g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: kconfig: memory devices are PCI only
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> Virtio memory devices rely on PCI BARs to expose the contents of memory.
> Because of this they cannot be used (yet) with virtio-mmio or virtio-ccw.
> In fact the code that is common to virtio-mem and virtio-pmem, which
> is in hw/virtio/virtio-md-pci.c, is only included if CONFIG_VIRTIO_PCI
> is set.  Reproduce the same condition in the Kconfig file, only allowing
> VIRTIO_MEM and VIRTIO_PMEM to be defined if the transport supports it.
>
> Without this patch it is possible to create a configuration with
> CONFIG_VIRTIO_PCI=n and CONFIG_VIRTIO_MEM=y, but that causes a
> linking failure.

Just curious what is required to make virtio-mem & virtio-pmem compatible with
virtio-mmio?

Maybe late but still:
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

Thanks,
Pankaj

>
> Cc: David Hildenbrand <david@redhat.com>
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index aa63ff7fd41..0afec2ae929 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -16,6 +16,7 @@ config VIRTIO_PCI
>      default y if PCI_DEVICES
>      depends on PCI
>      select VIRTIO
> +    select VIRTIO_MD_SUPPORTED
>
>  config VIRTIO_MMIO
>      bool
> @@ -35,10 +36,17 @@ config VIRTIO_CRYPTO
>      default y
>      depends on VIRTIO
>
> +# not all virtio transports support memory devices; if none does,
> +# no need to include the code
> +config VIRTIO_MD_SUPPORTED
> +    bool
> +
>  config VIRTIO_MD
>      bool
> +    depends on VIRTIO_MD_SUPPORTED
>      select MEM_DEVICE
>
> +# selected by the board if it has the required support code
>  config VIRTIO_PMEM_SUPPORTED
>      bool
>
> @@ -46,9 +54,11 @@ config VIRTIO_PMEM
>      bool
>      default y
>      depends on VIRTIO
> +    depends on VIRTIO_MD_SUPPORTED
>      depends on VIRTIO_PMEM_SUPPORTED
>      select VIRTIO_MD
>
> +# selected by the board if it has the required support code
>  config VIRTIO_MEM_SUPPORTED
>      bool
>
> @@ -57,6 +67,7 @@ config VIRTIO_MEM
>      default y
>      depends on VIRTIO
>      depends on LINUX
> +    depends on VIRTIO_MD_SUPPORTED
>      depends on VIRTIO_MEM_SUPPORTED
>      select VIRTIO_MD
>
> --
> 2.46.0
>
>

