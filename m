Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900D5CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxW2-0008Rg-5B; Fri, 29 May 2026 09:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSxVw-0008R3-Rt
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:44:41 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSxVu-0006h6-2T
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:44:39 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6877c719cb0so13682717a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 06:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780062276; cv=none;
 d=google.com; s=arc-20240605;
 b=a4q6f2TmwBmC1fgN39Mazrk7dSMZ9KQLy3XMixfWgYQ9uMf/4T71P+H3BwFgr+3vLK
 aOAPrf4x3r3VyLDhWWcENzCHAoW+DGMMQsBzN7WM8dWGvpiU6dBt6dLx8i4P5xsd+Yxa
 ZS9O8AaQPAivA2z3CzU7orvU+5ffqBNJ5l2PKUqsMGWVcp13DPy3p4PQXmnA2+jfL7CE
 UxMBXBqw5USXHUwqYDkCK8DCa89n2+6iYZTX6596ebH9xb8HmP9KQOls4Bw2W6i81zMA
 /zQ0HWvI7PKyIsqWRW2n4zi0r+2/SJW+rXF+D4ZStvv2okAqv2jfN1WgUp47JtxoyJxB
 /SwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Em993xzmhtB9OUlqVYjCFFJaamymCAV+rqqThpGElQQ=;
 fh=lefIUwWU0mp4q1TsQNBKRsXO6FE22wXIhjMZf7o9yig=;
 b=PleY9tV1IHbti+YWDkSegDOsW8PI0MMJv3odcKwwJMO2L7lFom5MZvwntyYKGDyJGv
 gIPnciK9qD76tSVYrLGIgr4cQIui9WnmAU8tqX8QFWUcdfIKBqJvjfopWwBECcbT16AG
 9Gq6Z0WNHBrxuKMrsCc9kyCkmQbl0QIVOsn4YKp1TI8dCCevT6qt6jr8jsZJSX76vXS/
 a3hgaREPmHiP2mkDLmrLOicm85k2WmP2IRmFMsueEm1d1oKheCMTlbjXVcBGEneuyz1T
 AJ2vxnecrQK4PM46c6BCWiKiaFeW2oyGr3Xu1tvgCBY0qlIiycqqwOcM5IruYmw4IuZy
 WLXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780062276; x=1780667076; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Em993xzmhtB9OUlqVYjCFFJaamymCAV+rqqThpGElQQ=;
 b=NSf6vTC6YyYbg/rJitWmSBOD1dZIJXgOJUjtjjrlv8NWCePtGps9ky5xtT8sa/bi1B
 H2ml11+zWe+GU+LUaXql1bNx7uF/M6RWCMzV2EQI++tdFAMYOd/3Y4zonRWpLt6/QUMH
 S3lhjUZhkeP5HdSz5a6PH1C3xZkl/Y+LJZ6RDIkFf/ShwtCW40JPJAvoOWNmLXTEMGHL
 VRuSMMiRO7WXaVQk4dyXd+gGe0EfV6Twxh6on1s8NoLeZx5Ddq+kLLyzjDiNdY4gHFz4
 hcKD63ATIKQUvjjlyT0d6VjhFCyGtmBAwtbyAx4uqDgq+14Nzqthy6WMoFKAYHSk3BNm
 6Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062276; x=1780667076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Em993xzmhtB9OUlqVYjCFFJaamymCAV+rqqThpGElQQ=;
 b=QTvl8ioa187B3Bt6TEZ5YRdNJmW4o1HYK3GNqkKCOZKBFAUKVRF13c1Po5QtEC9fnv
 /Mm+pw6oHnnc73V1vgag20hxTB8nUBH1kqIbZQJEgPs8kgnSKB0WQtzFjNcTcZ/lyYi4
 Ol4GLr5TITkkNPUmaXSS4zkwbVnO0UV8Vt+MWTLM/jIExyIjFmH0C7cqmvfVarCCXcNx
 w0cmbZcjz2HIrUOpxkyAclqbO+7OM95Q81Ov1myQs6YHiG5hcjF1ZDGNM0T5yLfJBMNJ
 3mLXwIvrPIc+rG2QarKVXBx/QEZtn+sUs3f0WylpH+fPQ1Sy6mblylTfz8c16UmuYmF9
 eX4g==
X-Gm-Message-State: AOJu0YxfHAIAyOaKBvPJg6zElYopRYLtnUYMvQOgDwLnjwmtSso2Y0n3
 ljMZmQRvcN9eW6rsCpT8OQwV/OiKj27wgonoRo8cH6KDk+aSuyFpatUkcMnPjGMOtOSe8nog8pd
 uEimIxnoUgXLz4mJtccy8W/JxKPBAQC2US0xo7cTEnQ==
X-Gm-Gg: Acq92OFU54ZRQERlw9a+GMvG+fbNX0Mlpr78OfBtr/yVHTrqntmIsLtj+KjhPBgmOOk
 oSfemuLHs5XzxXrijaHBkvKA2U3pCVXxRsIMvP1LK4cnHkljCa7bHL10W6643Oc6b4AvCRkQ+Ym
 hMBy3QHrK7QjiytgUAxHQqhfC1iyAApVjDZtpAcPXM1XHHUjbU5zVYnKZVGfQJSdezOHjcuuY0q
 o0uM4lEPHudSX0bGuNDoUQJgguawNZbN18RhHEdEqKzavN/v7PjwZKxSeNCuuRfM/8uws0PLBsV
 Xnx9B3Dk59Z7HWnXTytgN9U91dyYjWVS6CahM9QR2FAjHmqMpyEZ5H9sCTVmBuyzKNHuyKgIblV
 EVFoKsKnYTH82
X-Received: by 2002:a17:907:846:b0:bdb:4cf3:7035 with SMTP id
 a640c23a62f3a-be9cce776b3mr194598666b.4.1780062275972; Fri, 29 May 2026
 06:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
 <20260529-b4-ui-v1-3-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-3-8db3068421ef@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 14:44:22 +0100
X-Gm-Features: AVHnY4LxJrYa4BLIngFLZvrCrxhv5l9fJhcjjr1786wLwmJVfJXp1KvsXc9NiNE
Message-ID: <CAFEAcA_YPFVabhNxsp84BVKtwehg8-ke3Saes7Tx4eW1b+57xg@mail.gmail.com>
Subject: Re: [PATCH 03/32] irq: add per-IRQ observer to fix
 qemu_irq_intercept_in leak
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 29 May 2026 at 12:17, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> qemu_irq_intercept_in() saves original IRQ handlers by allocating
> new QOM objects, which are never freed. On a PC machine, this leaks
> IRQ objects (one per IOAPIC pin) on every qtest run.
>
> Rather than tracking allocations to free later, avoid them: add an
> "observer" field to IRQState, called by qemu_set_irq() after the
> real handler. Interception sets the observer instead of rewriting
> handlers, so there's nothing to save and nothing to leak.
>
> Fix qemu_notirq() to route through qemu_set_irq() so inverted IRQs
> trigger observers too. Drop the LSan suppression.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/core/irq.h         |  1 +
>  hw/core/irq.c                 | 10 +++++-----
>  system/qtest.c                |  3 ---
>  scripts/lsan_suppressions.txt |  8 --------
>  4 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
> index 291fdd67df4..93d5710a73e 100644
> --- a/include/hw/core/irq.h
> +++ b/include/hw/core/irq.h
> @@ -14,6 +14,7 @@ struct IRQState {
>      qemu_irq_handler handler;
>      void *opaque;
>      int n;
> +    qemu_irq_handler observer;
>  };
>
>  void qemu_set_irq(qemu_irq irq, int level);
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 106805e2417..fa11e9bc0aa 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -32,6 +32,9 @@ void qemu_set_irq(qemu_irq irq, int level)
>          return;
>
>      irq->handler(irq->opaque, irq->n, level);
> +    if (unlikely(irq->observer)) {
> +        irq->observer(irq->opaque, irq->n, level);
> +    }
>  }

Hmm. "observer" semantics are probably nicer than "steal
the irq from the thing that would otherwise be connected to it",
but on the other hand this means that this purely test-relevant
thing is now in the code path for the common "signal an IRQ"
that we use everywhere...

-- PMM

