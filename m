Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B29C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLHP-00024s-UX; Tue, 04 Feb 2025 10:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLHO-00024L-JC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:56:02 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLHN-00021s-0i
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:56:02 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e3983426f80so5058573276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684560; x=1739289360; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qNXD0c3Wqp6I9lOufInk0/9QAiEHHO39zdWRZ/smY8U=;
 b=bYhMm+k44wPiFJPo7MeMhhVz2RXlPEzZF+J7FEvCbFIO6IlHoqwSBP1S029SH1+JGS
 GeAP1z1rJxGsX191qfqD/wHTAaogW4ZH1e8Dzwyd3Kp9rLb6ytAnZ9KNU10nyCNezvxf
 gqsEQvqBrkSrvkJr8HzopFHZO8Fm6dWN2W1/eb4J5o2sxXJo90o+gyMZhNOQ1aPO5KMx
 5s+y1ipZUXInPPX8GptQKchD4QO4iIxqhCVIZ9CvbWw0l20JDu+V01kW3IjabJAcrNgi
 XMNFdhryvg0mEzS7Q8v6zxxafGILyzu8FoIoglczxE3yRt6CZJLXlpw40u/m6hGwHVuZ
 ypSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684560; x=1739289360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qNXD0c3Wqp6I9lOufInk0/9QAiEHHO39zdWRZ/smY8U=;
 b=UtpTR+O8LXINSxWUxyZlR3spgDH5Vtx4OkgL4I5BNih/zPLSdi+7/pq1bp5Cmz6lAd
 JHZT0Zw0vl5H6746gOwfcUxd9p/a+gT6WwBjZykJ2RfvQJ3Er7wS+29giPGTjYHDiJRo
 vVeBZWrJs3biSM4dLCNnFgv0q5Az9gdPDzbuHmNBZ1CycYs+KzH85a5RhCtLZERHtesR
 FaGN5At6F+mCytcB9ydf7rXL3m/JG+ib7/bTB09NmK9lxhDyBxXN/6ayXO8/b7gjCbs3
 00M4rEFKdXcoE9FOmNIScJaqMBqTNuAmRW2eIoR+nmc9PtBnFfW1pNoHVk+HQQgz0yLG
 JA3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcNAbw4mzK024SFmqoBmVZCTcwEzN7chkyZNa8CvO9P9Hu5dCYGEUYAhtfv1fzI/bPLIyXZEE9xw2F@nongnu.org
X-Gm-Message-State: AOJu0Yya8ubj6tGZ/NXBtp423HSU0hh81KDJEejblKyopziezY2s6Yd+
 cs2QntH+yMndHDnXyiEVKBrrzvgxH8/udrI6gsvirFYSpDGKVKIULiRCVDUCYfcX5Dd3+szBxCH
 8Z4BqN+km1v7DxXp8axXohF/B6e/owzeOBhIWMg==
X-Gm-Gg: ASbGncunmxKD4/o+GFqim1k/jrDqUHpb3ZreXC39+hFvBuEULbPTHprvxCM6EbnOC6t
 +9XwSZ+ukPEpDNLB2Xs8ktNqos/XC2RhhXl1ogrhftM8lH86Ui31wJu2+0lzeW/vi+AW1DaQdiw
 ==
X-Google-Smtp-Source: AGHT+IEHN8o5mvBpEU1QctjG+i+A7ytybDSq0ANw8CEWVG0X7ald/Op7V98W7NJPIdXlrMmUEe7AXpnSO80vK9kuAUc=
X-Received: by 2002:a05:6902:27c8:b0:e59:dbac:d993 with SMTP id
 3f1490d57ef6-e59dbacda16mr18973724276.17.1738684559653; Tue, 04 Feb 2025
 07:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-11-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-11-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:55:48 +0000
X-Gm-Features: AWEUYZlA-QXxPJOjNuZD_TaGnj1L_c1v0otiylryN3pjjptxsg-theZwC9-1jpg
Message-ID: <CAFEAcA99ZeiHKTLVWrTYCQm16O=cyNSaNm1cbTG1qybxiOcHqA@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] hw/misc: Support 8-bytes memop in NPCM GCR module
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> The NPCM8xx GCR device can be accessed with 64-bit memory operations.
> This patch supports that.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/misc/npcm_gcr.c   | 94 +++++++++++++++++++++++++++++++++-----------
>  hw/misc/trace-events |  4 +-
>  2 files changed, 74 insertions(+), 24 deletions(-)
>
> diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
> index a4c9643119..7dfdd3d74b 100644
> --- a/hw/misc/npcm_gcr.c
> +++ b/hw/misc/npcm_gcr.c
> @@ -201,6 +201,7 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
>      uint32_t reg = offset / sizeof(uint32_t);
>      NPCMGCRState *s = opaque;
>      NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
> +    uint64_t value;
>
>      if (reg >= c->nr_regs) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -209,9 +210,21 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
>          return 0;
>      }
>
> -    trace_npcm_gcr_read(offset, s->regs[reg]);
> +    switch (size) {
> +    case 4:
> +        value = s->regs[reg];
> +        break;
> +
> +    case 8:
> +        value = s->regs[reg] + (((uint64_t)s->regs[reg + 1]) << 32);

Maybe
  value = deposit64(s->regs[reg], 32, 32, s->regs[reg + 1]);
?

(Mostly it's just the cast that makes me suggest a rephrase.)

> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
>
> -    return s->regs[reg];
> +    trace_npcm_gcr_read(offset, value);
> +    return value;
>  }
>
>  static void npcm_gcr_write(void *opaque, hwaddr offset,
> @@ -231,29 +244,65 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
>          return;
>      }
>
> -    switch (reg) {
> -    case NPCM7XX_GCR_PDID:
> -    case NPCM7XX_GCR_PWRON:
> -    case NPCM7XX_GCR_INTSR:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
> -                      __func__, offset);
> -        return;
> -
> -    case NPCM7XX_GCR_RESSR:
> -    case NPCM7XX_GCR_CP2BST:
> -        /* Write 1 to clear */
> -        value = s->regs[reg] & ~value;
> +    switch (size) {
> +    case 4:
> +        switch (reg) {
> +        case NPCM7XX_GCR_PDID:
> +        case NPCM7XX_GCR_PWRON:
> +        case NPCM7XX_GCR_INTSR:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
> +                          __func__, offset);
> +            return;
> +
> +        case NPCM7XX_GCR_RESSR:
> +        case NPCM7XX_GCR_CP2BST:
> +            /* Write 1 to clear */
> +            value = s->regs[reg] & ~value;
> +            break;
> +
> +        case NPCM7XX_GCR_RLOCKR1:
> +        case NPCM7XX_GCR_MDLR:
> +            /* Write 1 to set */
> +            value |= s->regs[reg];
> +            break;
> +        };
> +        s->regs[reg] = value;
>          break;
>
> -    case NPCM7XX_GCR_RLOCKR1:
> -    case NPCM7XX_GCR_MDLR:
> -        /* Write 1 to set */
> -        value |= s->regs[reg];
> +    case 8:
> +        s->regs[reg] = value;
> +        s->regs[reg + 1] = v >> 32;

s->regs[reg + 1] = extract64(v, 32, 32);

>          break;
> -    };
>
> -    s->regs[reg] = value;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

