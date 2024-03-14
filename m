Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D822C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjyX-00070u-VE; Thu, 14 Mar 2024 08:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkjyU-0006zg-8D
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:14:18 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkjyS-0007LS-KY
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:14:17 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso1131316a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710418455; x=1711023255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wb7r6wXWTS7RyS9+BQDEBfMOErDR6CZ/DZcU/ghg5mw=;
 b=hnl5tPUHAapWqeD20y8AEpibk60fcPj0of54WYhVLPZRdpBs4NGq5JsfWBKPDMpmn6
 z6HApES1bc7267yyeWWEGP4xCtSv1udkM/kniqN1lgvA8zE8JL7KfEGhmW+1/P+J3c3T
 gkxxnuw41ChL6DiN/D3c3A5LiHNJwFQAWMztcOVC4LGQIo7L43wOjJJft0YrstzVh5VF
 FTmmwp2nuEHXDYgeYusGyE3UdMCyUvzmh3lx9Z+eUN7212SQjITpVe8bt+Hxm0+UdWyO
 JB56Bz0ipTdh6nluI+6/EKaHgHZoSlgzubsraaQ22rbwqnt7oct+LSaz/JnooeuzzkZH
 uTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710418455; x=1711023255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wb7r6wXWTS7RyS9+BQDEBfMOErDR6CZ/DZcU/ghg5mw=;
 b=v1NIIJVQ3HEaFTQhYTmAAqSXg+owje/DWkgqPjOocHie16+QeMtXSQ+ZpovHPNMZCS
 e3IFAQvA0HoaBU8coCj6+ho7jd/dSUUpOB9UsdFzDEbfvJYK7VkIqiu3duVEuIU4mSZE
 V/bB7I6EqS5mY6LLv0chxppCM6XWsBZEgrqUJJJjPo+BUNNUmwhApXCKrANxhC9gfyqH
 7KPvEmKnziIvQ27XN5JrXdpBmlwZDYPrIDXfr9m03RXYVLDgrvxjNqLpz9kf2tvt6NpW
 rhlpL9UCDKZX25CpCwbFhqjIP6b7XqJejosKv71GpXW1ERlHWeEGPJj9uGMky+noJlxW
 d2pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsMujJHhq4Tf8KIKPcHiFtYVzpHtKOlxgi9T2pd/anbVAMUP72aYh72ZqP6QIHZjr5KrDGjJeO33VAUa6rbDxQtg68OcQ=
X-Gm-Message-State: AOJu0Yy2qowvO9I+43mnp59fTnKkTQKgdqBB5uCdQveDjD4M/sEDTCyf
 fhftUZLdHEDV1YYYM+tPBktZ7svvTsPAbsCoTc4yeLgJyxpx2Q98Yrx1lY1LbzVS888TjwEF5Nv
 q0IZuHHV3G7LfwUjE8AFPXAnUZsZhf6dY+dnCxDqxlG1+ppFF
X-Google-Smtp-Source: AGHT+IHkBhjMMmCXEbzLQ1J7re5yL2jTyJ3P/i9Ko5pmypFlXtkVBiKtwQyUx5XewnCXV3dxUgY3EtRkCKrDPSgL2FA=
X-Received: by 2002:a05:6402:1f8c:b0:566:1794:7b2 with SMTP id
 c12-20020a0564021f8c00b00566179407b2mr1144005edc.13.1710418455004; Thu, 14
 Mar 2024 05:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-2-b557c56559cd@linaro.org>
 <87h6h9gghs.fsf@draig.linaro.org>
In-Reply-To: <87h6h9gghs.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Mar 2024 12:14:03 +0000
Message-ID: <CAFEAcA8GhAMtvsRE71fybuY90hXBavbXwCrb=-fWGqg8JebTEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tests/avocado: drop virtio-rng from sbsa-ref tests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 14 Mar 2024 at 12:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:
>
> > sbsa-ref is supposed to emulate real hardware so virtio-rng-pci
> > does not fit here
>
> What is real anyway ;-)
>
> VirtIO devices exist in real life and I would argue for PCI the device
> appears very much like a normal PCI device. I could see the argument for
> avoiding virtio-mmio devices which are a lot more VM-only in flavour.

But our platform for testing virtio-rng-pci should be the 'virt'
board (and our avocado test for virt does indeed have that device).
What exactly are we adding by testing it also in sbsa-ref,
where the typical user will *not* be using it (if they wanted
a virtio setup they would be using 'virt')?

thanks
-- PMM

