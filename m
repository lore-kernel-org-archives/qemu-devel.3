Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE48CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfOk-00060f-8w; Tue, 28 Oct 2025 04:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDfOf-0005yN-4F
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:49:41 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDfOb-0006ea-CW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:49:40 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-88f2b29b651so587727185a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761641373; x=1762246173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyfFK1dolq9K3/f3rVwkMSWSBsjfZj4+EzIkR6L0oKI=;
 b=LIjSSshWC2iw/Giwr1WSxROkmMcJEBdgHYYQsKQjUOodup8alGXJvEQIkggfaFhHuP
 /Um+EqTJ3Xl/xVkbwzRVQHFX+PO6b/JYB+vslOUtGp7mqtB/smW81fbisUqh47O1C7+G
 KAmyDTpiK0f7EFCHkIq8hNCiOHglg5ppbGqHXlsJeYbaB+iGYhoieyVI5b1BZf1oMC4w
 MixbSxOiAhZJzpyz/eathe+znvOzvV5Upo4ScNky21BFqYKPCYcB6pT6G2jYJN1Yat2x
 8WbKz/2xVCHwP5NaUOMVxjLsX6FUrLWvlUm70PJ0pZVy+FuSrk1ZH8QCQiPcABv3HVnk
 QuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761641373; x=1762246173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wyfFK1dolq9K3/f3rVwkMSWSBsjfZj4+EzIkR6L0oKI=;
 b=eMXeD2evyuYm1L86avszVBZapmumXWuZRfx3Kpd5wzfnqBpfoh0eN9rZmzbUn6f3cB
 Gpeq3T1qYHZ7VsjxvW2MYzOJlRCbnAQDMed8gjD+5ZD8ownILGZpO4KD8fu7yQRROEe1
 cRfd1Ss3L+bBHwvfKuglhvAlYa8KgxmJ2u8KHuetkl+jZ8YvqZoOSA1XmF5TfpVz2Svx
 TOlPLOV60lAQeyyVjCE1xFTVNvlw1jLZfb9YS2V8+3UHTvAwWxc9QAcUeiB9N2UjZWMg
 TaxmQjpP6j+s0OAkJGHah8SjY/rUm7BGdfcnzRGl+lf/0g+X5BwJoiQDPZdXfJf/WJVf
 0DHg==
X-Gm-Message-State: AOJu0Yzk9MFBuuNdOaPArlftcj8E93UAP/SmzJt7gVdLj0vj9jJXTBc3
 cDQ8bPCSqD7miqJzLkk3NNfyzXI+0cm4u2wMRfjGKY6lhRq/gMNlym3F8D9LiRKVW+Lv24Ts3nD
 epThDVoDbd8CAjMeJfnH9i4R1gNfhlgM=
X-Gm-Gg: ASbGnctCVjl+bS/eUH/PB9JHq4kLnBbWBTcQpmIu13aYpPloUeCQdafefPPmqxM4dkX
 qdOU+SDRu6piy0cdXbxzwGOtPn85D1SVFyv/fVDDU76S5i4B3n0gf/yrRrhiByPCly6hA5ZsljW
 LpLeAudDKK5kRddmBQFQ6uuJgKOwBT80LUi90hwBHBU6MZ5DkLJ6FnPs37XsryHThA5cFPZlsCn
 vbFb2l8Yp6M3vbV4XbrdrlNe6M8hc4TiIl75lZmyClF7WmbeQYLxYG9moLyK+c1sO+YqQi+3HU4
 3RYRA40vaRiQShgx
X-Google-Smtp-Source: AGHT+IHqwcwbFu4qFAG1jckH5bKOlUrnWZmnYhb6joA75sezyV1H8hvU1xMQvgqrwBFU+uhibyVugCTlsaHo5wPDXRg=
X-Received: by 2002:a05:620a:1996:b0:892:7394:e9f9 with SMTP id
 af79cd13be357-8a6f48c6ae3mr283596585a.23.1761641373349; Tue, 28 Oct 2025
 01:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251028080258.23309-1-philmd@linaro.org>
In-Reply-To: <20251028080258.23309-1-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 12:49:21 +0400
X-Gm-Features: AWmQ_bl3KK8iEk5vACj4o6D25dwdfuNaHYndBPYtzKcFCLuXFNTkbn6BRYGt1Pw
Message-ID: <CAJ+F1CJYxKD23TFCy1-rbZf0Y_mSMdyVH=nFDM6eomDhVpmHYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] hw/sysbus: Spring cleanups (part 1)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x731.google.com
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

Hi

On Tue, Oct 28, 2025 at 12:04=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> - Use proper SysBus accessors
>
> Since v1:
> - Reduce series
>
> Philippe Mathieu-Daud=C3=A9 (7):
>   hw/sysbus: Use memory_region_name()
>   hw/i386/microvm: Use proper SysBus accessors
>   hw/i386/ioapic: Use proper SysBus accessors
>   hw/timer/hpet: Use proper SysBus accessors
>   hw/acpi/cxl: Use proper SysBus accessors
>   hw/ppc/e500: Use proper SysBus accessors
>   hw/pci-bridge/pci_expander_bridge: Use proper SysBus accessors
>

There are a bunch of compilation issues that I will let you address for v3.

It looks like it should be possible to remove the "addr" field from
SysBusDevice.mmio. On the surface it looks redundante with
MemoryRegion.addr. I might be missing something.



>  hw/acpi/cxl.c                       | 2 +-
>  hw/core/sysbus.c                    | 2 +-
>  hw/i386/kvm/ioapic.c                | 3 ++-
>  hw/i386/microvm-dt.c                | 6 ++++--
>  hw/pci-bridge/pci_expander_bridge.c | 6 +++---
>  hw/ppc/e500.c                       | 2 +-
>  hw/timer/hpet.c                     | 3 ++-
>  7 files changed, 14 insertions(+), 10 deletions(-)
>
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

