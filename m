Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A9FCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc1gw-0004B2-6S; Tue, 23 Jun 2026 10:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wc1gu-0004AF-1h
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:01:28 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wc1gs-0002Tt-BC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:01:27 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660323f7b27so6300367d50.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 07:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782223285; cv=none;
 d=google.com; s=arc-20240605;
 b=kHxVot61YrwcXsmG8RQFXyfFeba5YgvBwiP3oDb3jISzWSOqS/mu7MgxY4fjWY1eUw
 92inXPFI2DSxA5zuOts2s5E2WYRveK31RGyxxQIA+KSAnKxoFDVe3zsGYM5IVvywnDfj
 MRcdk94OPND6FP0qcJUOw7Kl+Gu3jbOwL30a0WiNXEbNobVgWXDt3hY2TaldiqUH0sL3
 n8WG5vgszCo/b4UlOFaUHh5zvbPZHi6sqe4F0di0Oqk/GpRhP8nXMM0tXnCVn04qCcJV
 nO2TF7l4oHoWr4CdP+YyCrcU1lHcrapZ2xV9FlLTIfmrNQcdyW6nngMrJtR7FbB7iOqF
 Z0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bd13+7L1/+KoxKQPaJC9Q/ePsanNjYEnGQIyJoXRPZo=;
 fh=5/XC+u/wDnZad7EtfyZNSfo2SlMGn8GtcshR7jCNvcw=;
 b=WoKrqXF4xJeakQMN+TRII1BRnssvVi0ONtFTxkngrDdNfTH/tKx+QUF+RwS20zRHce
 3yfFnZpn1jio8fKB1KncK7tHcC+ReVb5/ItQOXiJUc2Bs9c2s0JNr6gYALAJJxfCX3Mq
 Wm0uDiY7eLPrT+rF1O/9NeM+kC6oxTmXfQ3apKJz5ZkMKAT2ByfpVurQeLeLZG2coWyU
 jMe954jtcdOdgtlBujg/qphqirrKW9PuwQlJJgQrWa3zDN61BNiNUVg3z8N5zUW6vYB1
 MIKL1QBYjP0dan9cm92NWyFoomB2Am0H7C//9nUEsLsQP0z6DbOT41rG6M/Eah3gfvLt
 tveg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782223285; x=1782828085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bd13+7L1/+KoxKQPaJC9Q/ePsanNjYEnGQIyJoXRPZo=;
 b=y9t3jQgVXXTw6yvtelkcX2Cd+xL2ZGnkcKIwv6JPZFxXwF1mQsDTd6dJNB1DZQNNac
 T5I0U5/r0pRpJGGAPlon8vIr3zZ5BDbcXFkO/1/kDv7s7LMLF3maCJpYYagnX8ZAGMPI
 fw23wRK6IH90uCx31azxp1C7n8V1/5H/rxTgIPHZ3jpbpN57quam9A1mxlnEMlppJVNq
 Ci6skbEoy1Y5AxMJ5bmFMjCOB5XOXgB+r2kcTya5GYsK2N9tY+fS9xRwzpTKGkk2sUz2
 CcpjIa+Hj9HNkb3WtdeOpdyKc+h9r6vQOY5APhjbKXdhXCxZg/YoIB7EbadffhNvaMDK
 LIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782223285; x=1782828085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bd13+7L1/+KoxKQPaJC9Q/ePsanNjYEnGQIyJoXRPZo=;
 b=ZNIAmhcQu8I0m0jmSay1svRcy55VGuNvVXMk1gIVuAXZBnhDY6ddk3hPjakxO8/t76
 G7JU8EFPvecoFF1d1Dgv8PGIMjIRBKI8rObeWfGIahyyEA8ZZ7fN4tI7avcxRwyaTPRb
 75q8BqASCPXbglIznTjPEDk0aTBV70F+5GCKv9NSeZcJIpmAay1vqYeiXTQk7BR7kRGs
 pAcnuYIoaWuf6QqqR6yy9ZX2wGwWppZqni6U59QhiQboUxIdyKLVJ5QtQfNf8p1wJ6F4
 zbtGYuDc48mpdCuMwvTCRJq2Y+IlLl6Z2mCRs7gbROSrNITfrTWAME/63VkJm3GDQaCv
 Tekw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGD9lGx7rluNGv/t7j5XXT5gkCETK6JROZCYU8iHr0bc61LLAg0i/AyhllP20C/XwUCzZtVX6/kLSO@nongnu.org
X-Gm-Message-State: AOJu0YxWz8npbNFZNNgamzAUhGKlayKY1swxP8oONuVueMde31g2iV0Y
 jfQCqPSNQ/yBBxmSGJ4oQ//uA6P7KV6uqY8NjYPfnbVefWY7Jq4+u6WNFcgDV4xG5Z+gun/ZfL2
 kz9aHt6RNqK61Rg6Zwb9Hba49rwaWwkweJtm4G9Mtig==
X-Gm-Gg: AfdE7ckHz87+Ds4aprxJwQPLLJ9X0Whc3qHA/l3HSo45QFeNFAlk4Z2M6bmPsTch4AR
 guOx6KL5jkJ/rKYzcwEq/1GtPZQwSFjVsfqmpeEGdSlkKJSoUQ7KryZ3WJfH5DNz9MSWjsK4E/h
 uDAheiwJm/6yNS2FhQ35hAKarsTArKwLaRL3H/kYrd+6ebzoY/JchETe5VX4tk/muTw+nPGfk0k
 ASKalJ2upjSkjfNTKiVg5uTlW4x66GuQEfKKozq0nhOl8A4LRukrbIh9YYmypQRip2iz8L5Wy0Y
 0FLBVu+XT11NPJrw6k6e+DQ7P0sDVLUYy0JVxZxOJWuZ2WNd5V8AEq6p
X-Received: by 2002:a05:690e:4501:10b0:662:d319:5394 with SMTP id
 956f58d0204a3-6635d90f651mr1455095d50.62.1782223284480; Tue, 23 Jun 2026
 07:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260623131946.46879-1-utsingh@redhat.com>
In-Reply-To: <20260623131946.46879-1-utsingh@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 15:01:12 +0100
X-Gm-Features: AVVi8CdU70m2G-0UyTiIiv396Ck_GZvthon4qvQ-tKYt9zSr_CYYXkIMN87-XHw
Message-ID: <CAFEAcA-nrh63fWvnVSSJExspOw28WkZyn69=YMdb5=ZA8m95uA@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: add user controlled 'vid' property
To: Utkarsh Singh <utsingh@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Maurizio Lombardi <mlombard@redhat.com>, John Meneghini <jmeneghi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 23 Jun 2026 at 14:52, Utkarsh Singh <utsingh@redhat.com> wrote:
>
> Add a user-configurable 'vid' parameter to allow overriding the default
> PCI vendor ID. This enables testing of vendor-specific quirks in guest
> operating systems.
>
> The parameter accepts a 16-bit hexadecimal value and defaults to Red Hat
> vendor ID (0x1b36). It is mutually exclusive with the 'use-intel-id' flag
> to prevent conflicting configurations.
>
> Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
> Suggested-by: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Utkarsh Singh <utsingh@redhat.com>
> ---



> @@ -9401,6 +9406,7 @@ static const Property nvme_props[] = {
>      DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
>      DEFINE_PROP_STRING("model", NvmeCtrl, params.model),
>      DEFINE_PROP_STRING("firmware-version", NvmeCtrl, params.firmware_version),
> +    DEFINE_PROP_UINT16("vid", NvmeCtrl, params.vid, PCI_VENDOR_ID_REDHAT),

Unless there's something NVME specific that makes "vid" the right
choice here, I think that "pci-vendor-id" or "vendor-id" would be the
more usual way to name this for QEMU (compare vfio "x-pci-vendor-id",
riscv iommu "vendor-id", the "vendor-id" field in the QGA
GuestDeviceIdPCI packet, "vendor-id" in xen_pvdevice).

Should we also have a "device-id" property here? Being able
to set the vendor-ID only seems unnecessarily limited, since
PCI IDs are a (vendor,device) tuple.

thanks
-- PMM

