Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3C4CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVLf-0002i2-PD; Fri, 19 Jun 2026 05:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waVLd-0002hZ-K0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:17:14 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waVLc-00081F-3s
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:17:13 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6607048fa62so1963708d50.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 02:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781860631; cv=none;
 d=google.com; s=arc-20240605;
 b=SGndz8uzlpV8nWBmb4DhRcxzcukyITRObo+VTeP0SgU/jW2Z7UmSOoiTJFeDx7KuTU
 /vppZM08zU3EiZkGd0v3vhA4xs6/sDwqaAx3nBD10HtZPGWKVf2BzVnM4zbBmOahgxLH
 6RAOUtkYsY9WY5oRhYvzFPE7h1lFLOstMIoSrPsd+H853EeMXiFcu/GmqgRAlsGk/XeI
 pXOQYRzDvL2V39f2vl9WKxjgWHQvFYNjL4/uWLghdGPZHXAQYgQScYp2vxxAK8Qr+Kn8
 va3GVptbBUBp2ORoVZgc7rBceQMPGa7uaN+2Txvz8HzmzUx30Ci4I8Y6AupJTk6C+VO1
 duew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ir+X3o+p3SvMPw3fPkA7lK/W7Q0zUG060dT+0pu9phk=;
 fh=qzrdB5IQyowe7EbfRlEVs4SGpLZknxYW6q70E6ohjJs=;
 b=NELWTKc6v45WHX9wR9O7l9iwFu1lTHpDIr3ocT+f43JMhaPaKJ/5Y9DM/N5Vqhz0rA
 nb2WG8cpddC5V6o66qrfuUPug8FGYBkAUzJnIJnpE2iUSr0jJe7xERNoz0+g+cyQatfF
 HczAXtznmYU/sPvyGkeE6KJtJt9Gf01+eZTvUw75LJDoEmXqZLkga0IcdUjlo16n3QqI
 OLzEllJZjuWQjrOH5u5TffIyuCF/8gNNB5egK04LtPlAssJ8V1WGyPEGc06F3sXP0KcN
 OLmo7gW1hCNoY/j8aKsD0PRX/MNL1H/EAE9de2mvNCiwK1uAseZLrsXHDFZBu4uOajx/
 jcQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781860631; x=1782465431; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ir+X3o+p3SvMPw3fPkA7lK/W7Q0zUG060dT+0pu9phk=;
 b=N7yYnZuEKcvDyoZHyage/7rp351Hf3tGQTvEpLIO1FBoki5RDIFQUNzI9hlViSKlgN
 gjWDZ5BW81WntS5kdvJxbgH+8YavRn7xAb/pua/fLfsc7pv8nLQS9UkxcblzCUhTUOvP
 807a2NVkSXq5KImr1LAMMy+mL/Wp4sIE7j26W8Li8Tx38CWBapfR8Ybra3TTEoPAyOJg
 FF75M2VD5VbQ+/j3zAatekSmiXKQwoQ0JjN/5yGRfREMjPn+mVdtTUP79zOYzEBuklp0
 HFQBs8VDc+R2QUqWwBsHTamBF1unOlbAtBGvD5+AbVf/gTzC74SbtemXuIDcSUBHBGIQ
 29DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781860631; x=1782465431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ir+X3o+p3SvMPw3fPkA7lK/W7Q0zUG060dT+0pu9phk=;
 b=Ra8OGUqnG7FKRoEH3H85XpCpp+XT3U1VcC9NEP+GE2z0Nv8Mxc7bMN2MvjXVb6tdZh
 Jog4jqVAzhrSPyxWQ9bw8xSL9umP2tiGezHMLAItWpdxAWn9Urdcp6nYI7HkvKFF1p9t
 OAABAmu7NQPRgP0N2/HxDwXHP9qh4KU/ix7YoqNSx0H12U84CWrnTD0F4sJ1/yPetDSL
 ZZJxIfUuLnjxolZBP4QKRs7+iqoOS5G515f09A9eEoXtrbnuo7gpinjFn+r+/u1EsJnh
 1YJFVTIu699xhSUPESE12AcvDSk5cWZZFo0nFtinqByM/7BG+rDQXBtuumYyogUXfrMe
 050Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3gsU4UR3PtlmvW88zBmLt01z9Iy5mePCQjDApHAXQvOEhtScZt3WFE1k32hQM3llnycVZStcU5/Zy@nongnu.org
X-Gm-Message-State: AOJu0YyqydjE8HzCux01CmcjNc4u+3wlSHS+qVO9/J40KYaNrESuwVU2
 UHnpu0tmOeTT4koCAUwBFOow66HNlwl9cLdUxWx/5x8dmNszbMKMluDtBgnIvrrdFvqbiSikSvk
 GXoAGYfxMUcX7qU7sJQScrXi8n29vryN63UFYZf4aQg==
X-Gm-Gg: AfdE7cmWx2ZDSILDzClqbvGmYhRlMhDp0mGviqPUR3/dDiZa1wuudL4Wb9QlvSNM6XG
 dyEmTGnH5vIejL2Wnvq0ZAZPH9GA3XS0j2UYpfi3SoYJsdV9lIZBR3YeXEMlxag8Z5mD+HiVmA/
 MTnSNqA780AojJadifXAOfV4Ny1d26UlD+ouif69/8gxSl22jYTvcsc2HhRuRdT+P/v1vauC2dY
 gV7eatBIHbwWVQ+eryddwslMSD5hKpXSo1GF5iWj0zRLpIwyOndD5Tz6wys3Y6eCBEfmaLJPIkN
 akWOMl9Rns2/g3sVUrolhP7HOTMeJnO8r5IbGlvKeNZXeRVcvUj61ld3
X-Received: by 2002:a53:cb8f:0:b0:662:bb5d:35a5 with SMTP id
 956f58d0204a3-662fcba5aedmr2741396d50.31.1781860630802; Fri, 19 Jun 2026
 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260619053623.756021-1-mbawa@redhat.com>
 <20260619053623.756021-4-mbawa@redhat.com>
In-Reply-To: <20260619053623.756021-4-mbawa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 10:16:57 +0100
X-Gm-Features: AVVi8CfQtjwUQ6en2BB9rI88GsK_jF_ak8GCQBWmfZFNj5lPnBhTpbHJPs6VBgw
Message-ID: <CAFEAcA_5d+_miPKpUf7Zo=B=XwCF=vcNZMsv9jQa258pF26nRA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/core/platform-bus: guard
 platform_bus_get_mmio_addr() against NULL
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 19 Jun 2026 at 06:36, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>
> sysbus_mmio_get_region() returns NULL when a device has fewer MMIO
> regions than the requested slot index.  platform_bus_get_mmio_addr()
> passes the result directly to memory_region_is_mapped() without a
> NULL check, causing a SIGSEGV.
>
> Return -1 early when the region pointer is NULL, consistent with the
> existing "not mapped" path.
>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>  hw/core/platform-bus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> index a2217a2dee..16d0ecc0f3 100644
> --- a/hw/core/platform-bus.c
> +++ b/hw/core/platform-bus.c
> @@ -59,8 +59,7 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>      Object *pbus_mr_obj = OBJECT(pbus_mr);
>      Object *parent_mr;
>
> -    if (!memory_region_is_mapped(sbdev_mr)) {
> -        /* Region is not mapped? */
> +    if (!sbdev_mr || !memory_region_is_mapped(sbdev_mr)) {
>          return -1;
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but doesn't this need to come earlier in the series, so
that the code can handle the NULL pointer before we
change the device/machine to not expose the 2nd MR?


thanks
-- PMM

