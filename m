Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A67D18123
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mlu-0008Gc-Me; Mon, 14 Oct 2024 11:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Mlt-0008GE-5U
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:14:09 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Mlr-0007qn-KO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:14:08 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb561f273eso7181991fa.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728918845; x=1729523645; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=syXDj9Xd9V5V1bqgnpVKqcIM58BhW90ufXNk1ne2oOY=;
 b=eNzvxFVq1kuzitfvrqEVRsV3neTppraBRd7zb8qmYk33a8UmFLeZSWAqoAdNXfTPlM
 A+7I+5gzwYpcCbbyd6bVQ+IXaYJosAfASPjPKy4h8SSJzqdvjumGBO3QsKDEDO+rkG8a
 ft/d4R7+ywIlwO5xNHb41X+aKLd9l+XqEroUXtJivvHy5IlYIXieThl4nj+0vhhECFtg
 H6qnR6mEAcLdOuU+y93GoZmpwuDnWxvzOIelDNeNyJt7wvVpYQW0Wz3iPtwkm/09sSA8
 XJM6DdZUfm6NjLKo6/1sksQuOlBTeIlzqr5hDYQ8ARR6kklc0gg511BKffvsk1a2lgXm
 FsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728918845; x=1729523645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=syXDj9Xd9V5V1bqgnpVKqcIM58BhW90ufXNk1ne2oOY=;
 b=qjVNJb7bY7y5RIvnbEvfzB+Kn0jai+WwTuASbFspKLQ/P7jyXc0/TTRE5Z4eCC9Sqd
 agkCrrwZ84fQnMo0kg6Uy2RmC8ZNRCqzkeqmjG/eU9CWzcmtNIIKNH+fj8VVx6OdLDyJ
 p22e5Kt3oTjCm4siP9J8ETGpopXA0uQKOkES3ae7rH5sGeSlH+eM4srALFxaotRwMwCc
 QK8CZGwa5nL8weh/PeXfSGzGm0aCJetdxQjp5ZK4tZVmNMwR79Uhy27N8J3ePhOkMR6j
 wp0ilxdZddBhD9023pYfLv2amcO7aW7KJs4OK0Pku8j55LUBK+Jk0Ce/ZU+DdGBSN1Oq
 MFfg==
X-Gm-Message-State: AOJu0YxwKG1RFk6YOO9sEWyx0cveQlCKkgP/Y379r9hNcCuvXO1Vaqy5
 xzKOKsR6x3E6TNKrJd8oV/iSs6ZVw4WYF8QSxlHhXxwi9b5uzwNq/58uIs0zlTZCCYDrsvJ3aQ3
 6LvFh++zV7Chapdn0ZEPu1i/rKwX3CIOuuTbb0g==
X-Google-Smtp-Source: AGHT+IHHRdri82JPGjuQBWyplv4rJt3P5C2rHAdACrqsCnaalv6ocfUJKXqyN7FlV/WI98XlHy6tSzeXIWFYKQw6c6s=
X-Received: by 2002:a05:651c:19a3:b0:2f7:6e3a:7c1d with SMTP id
 38308e7fff4ca-2fb327138f5mr51588561fa.15.1728918845398; Mon, 14 Oct 2024
 08:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728299530.git.chao.liu@yeah.net>
 <fbaff99d74262f52fe62696fe08d617296f6ea1a.1728299530.git.chao.liu@yeah.net>
In-Reply-To: <fbaff99d74262f52fe62696fe08d617296f6ea1a.1728299530.git.chao.liu@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 16:13:54 +0100
Message-ID: <CAFEAcA9cuSHGGehAVUq15LzVL_gLAZbJKy0uxYA0VxgqtHH24w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] xilink-zynq-devcfg: Fix up for memory address
 range size not set correctly
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Mon, 7 Oct 2024 at 12:25, Chao Liu <chao.liu@yeah.net> wrote:
>
> Signed-off-by: Chao Liu <chao.liu@yeah.net>
> ---
>  hw/dma/xlnx-zynq-devcfg.c         | 2 +-
>  include/hw/dma/xlnx-zynq-devcfg.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index b8544d0731..e5eff9abc0 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -365,7 +365,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
>
>      sysbus_init_irq(sbd, &s->irq);
>
> -    memory_region_init(&s->iomem, obj, "devcfg", XLNX_ZYNQ_DEVCFG_R_MAX * 4);
> +    memory_region_init(&s->iomem, obj, "devcfg", XLNX_ZYNQ_DEVCFG_R_MAX);
>      reg_array =
>          register_init_block32(DEVICE(obj), xlnx_zynq_devcfg_regs_info,
>                                ARRAY_SIZE(xlnx_zynq_devcfg_regs_info),
> diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq-devcfg.h
> index e4cf085d70..fc26132069 100644
> --- a/include/hw/dma/xlnx-zynq-devcfg.h
> +++ b/include/hw/dma/xlnx-zynq-devcfg.h
> @@ -35,7 +35,7 @@
>
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqDevcfg, XLNX_ZYNQ_DEVCFG)
>
> -#define XLNX_ZYNQ_DEVCFG_R_MAX (0x100 / 4)
> +#define XLNX_ZYNQ_DEVCFG_R_MAX 0x100

This doesn't look right. The device tree in Linux says this
device is 0x100 bytes long. In QEMU the _R_MAX type constant
generally is the number of (32-bit) registers, hence the
division by 4 here to go from bytes to words, and the multiply
by 4 to get the memory_region_init() argument which is bytes
again.

What is this patch trying to fix?

("What is this change fixing" is the kind of thing you
should explain in the commit message.)

thanks
-- PMM

