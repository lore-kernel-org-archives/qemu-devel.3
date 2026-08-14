Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D49C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wunsG-000636-2D; Fri, 14 Aug 2026 05:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wunsC-00062g-5G
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:06:45 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wunsA-0007MS-I4
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:06:43 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-836cda225c1so11409687b3.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 02:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786698400; cv=none;
 d=google.com; s=arc-20260327;
 b=DlnxgdW0Fsd1wF7dHeot1avHZDWUTSIOBE400qXD/Xu7/v1uWP3Qy4auxOhYi9oTgT
 mj5PQF9151nsgbq/nURfbxaA2md5JoechxMXV9sBDMowoLRG3TsCBLpVFdmzysUMelBR
 faC3lgQZGf9ycf3vdXFX1A51V3UTBoBFT0hFoGGhjtZ5Sr8GCl7aNs7oJ3Nm3fRREQmW
 q5mPC+xC7Haumx+QcfsoNNV3GT+tR5kUOZpX7R/dUIn6XvA93xgkq0uN0/yOckzPW7TX
 Zb+bFAnBvagfBJ2HSjzurnjX/biXHKXUXOAbgK7VP98L0cRwGjuN6t+zQLqyGLD/zDgu
 nz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S2lA++c1Mq1GEEqmecKJ3jW0hiHKb00s2bJJTyPlGps=;
 fh=o8x3faI5RWdSQETmcl8E+2K0BDA+ie746BSWxHv4PC8=;
 b=lhF9xOJoRRb/QZk/9yatIQh80QH+W1WF+lwjSmQm01jl+KmeXqc7XXrYATAe0xhn0E
 b6IlmMoEr6/f1Mp0FSGVE/ziHt+6JX5ZjAYkmz4V3om3xlfKVMGkrlD0ok1NlAeCVEZ3
 XFFuw/GG/hz62S63xSI3+Tez2L6laDCzV+TQCtLnXaPHdGY4QPqbFVwXrO+Uujc4vpOM
 1v+/PDKs0MbEU4RZ9tEoycOnrBOPEYdD87vXRqcKV+1RhalX4bj0V4w2BvtQsDkiO4JM
 IpnYO5dzRCEOKehMRoZmv7iqrnBVvCxdPy2eFTL7n779wjqNhplZCURd34WfHNnND1ns
 z4qQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786698400; x=1787303200; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S2lA++c1Mq1GEEqmecKJ3jW0hiHKb00s2bJJTyPlGps=;
 b=QFuGbdi4le+6qNBIxgc7xT0+nJwpulmKUTZxAw3wAKa+kcJ4YlwYjQXWwjz/p1wy4v
 bhkeX4qSPmWxX7zIzbzkrmHzVxz5nwNC74wrr5GJOxy3CGIKJ0J652SfSkXKE1BYAghp
 8zjtV+bhHvs+n3ubnxzHgoF53JQeMcEYQoTPf3K/sxu6xds8ktu+/vwA9MvyTZL04fVU
 OBdGi7HoB2EoQSSi7a4HE/rAm9lCzR3AaX2aU6zX7yzMSFTW3+TJHFI2r/RQnXzHoSAz
 VA7Ewbj+NHcW5Wst2UEUHD3228M6AaxE53IyO9j/8YV45qSzbTIWgOl8lB3GGFGHJOKQ
 m/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786698400; x=1787303200;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S2lA++c1Mq1GEEqmecKJ3jW0hiHKb00s2bJJTyPlGps=;
 b=LIFGfEMSiYtyHQG00W8P2zYvBDmtEdJQQXB8lMNIPAIH4b1SHBzSvZV+1tTAUFfEyd
 rv1/4sL3qRMtD4gBIY82r7ICcej3fONZi8J/KNkkuUa606agAxMYTEchEnoNb7dWZxvV
 F/rhG5hdQl/F3T+mKMwfOOTIn217aaiQDp7Ng1CHG6wvCVNOAz4L2689xzu9CMM0i+/R
 vuIk42ZoWz37DDIgIYzdSLOvju8mr0oRti86Yk6vDPN7FCknRlyvEOroc8xfcex6YGGd
 bu7B8svZU6yHPSepyvO8LNycrWEqLwfVvIpnC6ST0C3LegbXS8MP9R6pSNLWX4cQ+gg7
 uiRg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpziH0G1m5bwsl6BSkqHr3TaIvWqiCQ1AUw25/djX6ueD4v10b9+V41vyjckejcSHNG4V4XlNikfx+6@nongnu.org
X-Gm-Message-State: AOJu0Yz/3m2HWxWqydpjup6N6rUpIj0RhQm8GF+vWr5Pdq9gk0ythYCp
 g95gUFT7QYtKEpo9CfYbmnxTu8HwP6cmQLIx92eoX5qrK6PSmkfgculsOknclbRHJtRhIMc2iVD
 x23trgg7jMIT4osZylJEaMjWfIOh9Ix44Ko4MdSQTKw==
X-Gm-Gg: AR+sD124McZf6UcQcwdX/LUfJjz92dMJy8Ijpb+u0W9XtUAs1Gb44O+dGD8H8M+pXMz
 G+hwqA3wWjNep5wUQRapzmUdMNhtJZ1QU7MWomzP6KgOAwm6v+r6qUuAM1/0+ZGCuhnAyiOk0h8
 3xBAIYhyhGiFVib9cAlPCXb0GOr5a4UySIuM7Epl4APKsXPLZus3n1aliydhOgKX/2izGCJ8IBO
 JYF3rdn27QLfuJRjlgiXpyFCzpnPqSWrXb0bxVlbbPMHWnYzHWkzuIj0MpUhm3pkv61WdhHme9M
 m/FljzgsGBIhJeh/Foua/Gs48i8VcDk1DGfOObTsWNy+oEgkO3V07hvywtqYmSE6qFTHL+HuejI
 KlTFz+iTi8HB9By+oqH61YnPLMQZd
X-Received: by 2002:a05:690c:23c3:b0:81e:6cd1:5322 with SMTP id
 00721157ae682-8371183100fmr20795357b3.20.1786698400605; Fri, 14 Aug 2026
 02:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Aug 2026 10:06:29 +0100
X-Gm-Features: AUfX_mwNvLUBJ7hNTJnvHNdqua4lcV1e2W0f6j8ynJ4Aj8f4XbQtuy-pX_BhY00
Message-ID: <CAFEAcA-kKC0WPU2Tqa8Oc9A-1H9LhVr5ibGrksBOc3ZNr54iMA@mail.gmail.com>
Subject: Re: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "clg@redhat.com" <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 13 Aug 2026 at 08:24, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>
> Coverity reports that ehci_writeback_async_complete_packet() ignores
> the return value of get_dwords() when reading the QH and qTD.
>
> Handle read failures in the same way as QH and qTD verification
> failures by freeing the packet and returning early.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/usb/hcd-ehci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 451a918e9f..d43951975a 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -533,11 +533,11 @@ static void ehci_writeback_async_complete_packet(EHCIPacket *p)
>      /* Verify the qh + qtd, like we do when going through fetchqh & fetchqtd */
>      memset(&qh, 0, sizeof(qh));
>      memset(&qtd, 0, sizeof(qtd));
> -    get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
> -               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));
> -    get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
> -               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));
> -    if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
> +    if (get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
> +                   (uint32_t *) &qh, ehci_qh_dwords(q->ehci)) < 0 ||
> +        get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
> +                   (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0 ||
> +        !ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
>          p->async = EHCI_ASYNC_INITIALIZED;
>          ehci_free_packet(p);
>          return;

Looking at the coverity report, my question is whether echi->as
can ever actually be NULL. This is the address space we use to
do DMA, so it feels like every EHCI device must set that up
somehow. ehci_sysbus_init() does. So does usb_ehci_pci_realize().
usb_ehci_pci_write_config() can change it, but never to NULL.

If echi->as is always non-NULL then we could change get_dwords()
and put_dwords() to return "void".

Alternatively, maybe get_dwords() and put_dwords() should be
checking the return value from dma_memory_write() and
dma_memory_read() so that they fail if the DMA fails...

-- PMM

