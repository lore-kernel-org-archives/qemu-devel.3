Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B40CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkcw-0005ju-37; Fri, 16 Oct 2026 12:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkcd-0005iw-Tu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:17:33 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkcc-0001qp-Co
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:17:31 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8ac9d666d4eso978377b3.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792167449; cv=none;
 d=google.com; s=arc-20260327;
 b=FKIHOWq4TWQXTH1U/sQ35HiLhp9pNSRn8+fePpyJjPMXjbh0o5bFtEzjlsfAMMwWes
 fJhp4nFNQYOobWO9SGZMu+596bk5ipEytrDEGfxq9iGhFpiZqXObX6qU5LtmECvJmKhK
 K/KkOFl26O/3L86hHzGHJo10+qac8dTgPnNn6CZ9WlyA7vQcXCMjOFnZ6koz5U6ppGAM
 7JUW5k5XgdGjX+ucI5JUJ/0GHyY1h1KpkHX0yKiQLd/JykOmDf8V/6SWp0IR1BKXk3Qw
 8+rdcdWgMu4eYEjOE/wpcvO9loHOMKzt8f/ktKKhClYBZyG5IOdUSeyC2j85sROcTNo4
 jQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=luEslXfElde2BGY9lnddmW44YWpRHQM8vQe1gybMur8=;
 fh=0BU7/y5efJOKARTWH9czb58nvb6ng5fTURYkJ6Sv9SM=;
 b=WGBXbEpI6kgav7M/Ey9HQO8uAu63EBmdt0kFusfqv+cm3oHGi804zBEAyIjE0GBWzc
 Eizo7M4yP6cJYfLPNvfwpV6JxGQuPNCvsAdk/utRZtQdscPcqvENIoXDp3thVwwDIJ2d
 1hQirKsvVtoeKSC7LYqhVqwWl9Q+2XD3X5SQUyKIgL+bYWBldbHa55gpwWm0ZB4IOjsD
 Xv+INjqOsf6NGcCGZsfYwgDp5lKg6cL8/ohJQZqRnct2n0AfoCQ16OEVsai4g2ZfGA4H
 276om4MHw2+PAWOkWF6nQv09fT+DdHzW59XfwwqRbaMmwZhCiisQdYEf39gra4zCn9sR
 3V5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792167449; x=1792772249; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=luEslXfElde2BGY9lnddmW44YWpRHQM8vQe1gybMur8=;
 b=tpx1KrMpzq2myWJt4+ipUOnrD8w6Dn7S/KigYxZMW61V2N7xHpmGv3ZaTFi6wVmx2n
 gUkyn1dbN15fn4WNW40lZeKsjrDHmndJFtaRnnAakpCMJiFxOEGJ3c5L74VlIde7uur9
 tdIYB8yI5g3rzZoIj350AeNeycmgKHDQMUJinOI0dxudnJJs62lmsXfHJRUpOwVpUFv2
 LEjWqBw1fwJ+WZqCZLNDS1X3KomsTdVWqdseAx6I0VTcY2Al8EsrHbKSfEPVuejr2y+F
 +jvBreY3wK6M38l5KxFym/ezeddw9LPV0tzbA8BI3dxVFY8XJyxqMFqKN39IRzauUTxD
 QD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167449; x=1792772249;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=luEslXfElde2BGY9lnddmW44YWpRHQM8vQe1gybMur8=;
 b=1W0lon7FlibH7jublLy8nF6jLXJ8N7QID9cZ2pAm3N2nIe9LV3HgKh2Ufp67ye1xCF
 ppavqgVvkTvlRvhc2sGcGPjQJcYcKpPGgWvlOx34r2BDy25ZI1yV7YyClg5mLuIXdUV0
 0BTLY1acsqw4FP2zBdd5BVpFr2eBoK9ZKaaCtYTDUCFW1j8j4S6biD/EzrPBHsLPKUYx
 rKMNf93j6icdOyTbx6veEW14yIieZl6CNG3NtJ6uuuG7yyKTpqnRduNoP6pNWURbG4NM
 kZ6UjOnpx3PDJ/XVfaCrbvCOoLIoqyYnBDSOTEZe7GjRf4D7iDwHYggv7RETr2Dr8JYo
 MOQw==
X-Forwarded-Encrypted: i=1;
 AKwUvByjDqYB08xiI2TPyk6wIPhQLwbZxzh4YmyHNrjk0wtDGmkSaVzNIxUd5MRanGA5JWvwwZIcJWPmb39f@nongnu.org
X-Gm-Message-State: AFq9FYIMNXpKK6Bz5jOGy4M6twAOKqjhKlpFgwYI9vP/VhZkZJgA2gi3
 RERACBz1d1rlaPzBUoMbqkcbI/+DalU7FaYZKpAN1ZjePjJF0UAcf0T5PWUGzKW3vOaQnA3el0b
 2e0DNmL4zHIqL8T8tK5aja0JpjY6+orubgqnGdves7g==
X-Gm-Gg: AYBFou2zjl/L5ycm032enaVcavf6MvUE1cHlEOCJ9roQQWnQgdX1wcoxpy75FibXo8o
 Hml1zx99E94iFIB1tdiLvTFjg56FMCLHXYroksy+2aGFMycjALHkwV9a1lsFwwPx05UhPBVIbdZ
 dvLjqk7KhpEHiBOTV37+XIQmnYJGK/gCxzguefFsv+XA5zCjAhi+SbWe9FnjkxNImCnAgg76skG
 BLClmf75OSztlCT/ecmSioIEHYishLLMzLR+P9kj8NhbXhyyVdYO6kUBe+ceRP385o9IfpKIuoK
 Rbikv7wqKdOUxhgedMWhgZg2Mq0eaNVy4MT1GR+NywvGJKYSE/gVJpJudxMRf6qtlcmekU7+00A
 IFmwWsafySxmQyRMylCd1yRldT6eQS/wFPpCgPoY8
X-Received: by 2002:a05:690c:7107:b0:8b0:e1c8:a47b with SMTP id
 00721157ae682-8b0f1f1b000mr1901217b3.0.1792167448757; Fri, 16 Oct 2026
 09:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-19-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-19-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 17:17:15 +0100
X-Gm-Features: AclHuK_dauIe-u55ng8KEFu7scxmNaDRrnhTUewCfR-gyxlxpOSMZ0p1OkE_lQU
Message-ID: <CAFEAcA-bEvYdgzoqAsop7XU+aii+78R3WpwqmU_M_2dZXqA0kA@mail.gmail.com>
Subject: Re: [PATCH v2 18/27] i8259.c: introduce TYPE_I8259_PIC device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 16 Oct 2026 at 15:23, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
> devices wired accordingly.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

> +static void i8259_pic_init(Object *obj)
> +{
> +    I8259PICState *s = I8259_PIC(obj);
> +
> +    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
> +    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
> +
> +    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
> +
> +    qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
> +    qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
> +}
> +
> +static void i8259_pic_realize(DeviceState *dev, Error **errp)
> +{
> +    I8259PICState *s = I8259_PIC(dev);
> +    DeviceState *pri_dev, *sec_dev;
> +    int i;
> +
> +    /* Primary */
> +    pri_dev = DEVICE(&s->i8259[0]);
> +    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
> +    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
> +    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
> +    qdev_prop_set_bit(pri_dev, "master", 1);
> +    if (!isa_realize_and_unref(ISA_DEVICE(pri_dev), s->isabus, errp)) {
> +        return;
> +    }

I'm not sure the _and_unref version is what we want here. The
documentation for qdev_realize_and_unref says:

 * If you are embedding the device into some other QOM device and
 * initialized it via some variant on object_initialize_child() then
 * do not use this function, because that family of functions arrange
 * for the only reference to the child device to be held by the parent
 * via the child<> property, and so the reference-count-drop done here
 * would be incorrect. For that use case you want qdev_realize().

thanks
-- PMM

