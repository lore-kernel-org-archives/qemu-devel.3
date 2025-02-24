Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08ECC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPEw-0000JV-UW; Sun, 23 Feb 2025 22:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPEu-0000GA-6X; Sun, 23 Feb 2025 22:34:40 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPEs-00058S-Nu; Sun, 23 Feb 2025 22:34:39 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4bfb4853a5dso1016734137.2; 
 Sun, 23 Feb 2025 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740368077; x=1740972877; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAdSQYhB5xvRIYyAlbietjKpk+ucgBqiwVL9hoD54yA=;
 b=hNnF9lctXoIyQhNvvM+OQyRhX8EmQ7ui5cGvGhU853CEFwyMXr/UJOqZyGJEiB/o/A
 7qelDsFkuRBuD4wUUFeq5ThaU08S5tJ0/i+9Ahd3v2p1AbAFUkaBeF8r5MrTOBEAKkpA
 LrusGe/q1VHEZIlBPcXxhUhehBFy6Hgt0goUJK5nF7My0+id3NM3XxMHaAJm1Uh9bqB9
 epdQFbLKpSOYlmdMmic+6g2rw74n6ys4+QYiiZGwYYLRPUm9Axn1lAMklnrk2OHj0yrV
 mPXldPtXRIFoV/Az3243jX2ThF9+GJ1ncxtRvqkO+Bqz979pmkKmL4Mr9aR4n0i2InJR
 qJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740368077; x=1740972877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAdSQYhB5xvRIYyAlbietjKpk+ucgBqiwVL9hoD54yA=;
 b=j5xiHXHK8mAnyunsYH+fJ5DRUBte9kaDssKRblwPftiTHklgTKXUsktWSige9hcvy3
 vg//kcPf/YylwsXkKBYbdFo7l/QZnMUaB67BDXqyqwnA384PWIYK4501ESgXE+7HwBvU
 /b6QvB7fMkzm1Sp+MCM9F/ceZ/6iw+qiDtMAyqCGCZp6d6NtMYs+3MtS15NemNozt4Oo
 RaCyO2XXhNnWkBnIABwN2gfaPMge80tjM/lo4aCsdK8HSqmxSCPxQyLdFw4Hag/yn31r
 DloPcOnNecLxeMqkiQoAQv8SdlwsLWxbwO2tFmHQD0eA0jDPR1Vzs83TeNtzvcMdIHrR
 bwMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV89p6hhBy9YarPDJSMHzMZEUL/e1Ym2xq9fIlup/H64nfjCc2mmAVR/8LUEiD2x7OujFT6N1Wxnlz+@nongnu.org
X-Gm-Message-State: AOJu0Yx71w97p+lTiz4tbmyDh22Z9L77tcfcEVUUHnoA+pfWpxTIvX3Q
 lCIQz4BZ74gjuJZXnMsZ+a7ffN3eVmbkhg4jZGz5Fb/IDU2zkIU3CF6+gyJLyfzaK9HsbXaCv6g
 iKx13dOPSS7Iaq8A36u5Yt2fn1UA=
X-Gm-Gg: ASbGnctYcDeTnmJL6b8C+IOmslfWOeIW+7drCPNlw8LoG9XljODjaovBy3co2bgFe1A
 BaWOVXdiDEvayKAo8R6dZ6dpjhXGtoHeo2PuWgCqZ/uhY0/9oxKF/MbFTptWb9FnvIFv9x+/cwj
 qMG7hhESi9T960zXXZA8OD7yGr5qE9Jp7GZjEQ
X-Google-Smtp-Source: AGHT+IHnwxOJZ27TbNllczfgpIyJX6O1oeHvZmSX7qtNsZo2prOkX2b2TJqP6qjmunjzJ4ztNpv7WsudJoyjgrmcR2E=
X-Received: by 2002:a05:6102:32d3:b0:4bb:d7f0:6e7d with SMTP id
 ada2fe7eead31-4bfc01c63c8mr4548794137.25.1740368077191; Sun, 23 Feb 2025
 19:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-12-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-12-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:34:11 +1000
X-Gm-Features: AWEUYZnbKpSXoOwqXUQzE0xA84TXVAkj4YstMBu78zJqf-DrayCWFJCl5GmCcCw
Message-ID: <CAKmqyKOasf_R4jTiupDLgNu6+M6uKWnQ+h2R=8FmN_nd1X=SRw@mail.gmail.com>
Subject: Re: [PATCH for-10.0 11/11] docs/specs/riscv-iommu.rst: add HPM
 support info
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Dec 5, 2024 at 11:33=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/specs/riscv-iommu.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> index b1538c9ead..000c7e1f57 100644
> --- a/docs/specs/riscv-iommu.rst
> +++ b/docs/specs/riscv-iommu.rst
> @@ -82,6 +82,8 @@ Several options are available to control the capabiliti=
es of the device, namely:
>  - "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for=
 'BARE' (passthrough))
>  - "s-stage": enable s-stage support
>  - "g-stage": enable g-stage support
> +- "hpm-counters": number of hardware performance counters available. Max=
imum value is 31.
> +  Default value is 31. Use 0 (zero) to disable HPM support
>
>  riscv-iommu-sys device
>  ----------------------
> --
> 2.47.1
>
>

