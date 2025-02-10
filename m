Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DB2C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 11:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thSKa-0001lJ-SA; Mon, 10 Feb 2025 06:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1thSKU-0001kR-RY; Mon, 10 Feb 2025 06:52:00 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1thSKS-00089e-CP; Mon, 10 Feb 2025 06:51:58 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fa1fb3c445so4867621a91.2; 
 Mon, 10 Feb 2025 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739188314; x=1739793114; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9tAvp6r8kOY87WceoaBiekGM0rVtgkrdKYF78gCjTo=;
 b=KLZecJ/ZqKLpj8Jbh8gKw418ELLUysl68cHEW9RMeBSPKhbz6ToRt1p9Xf1BjiD7WO
 +s90u3u+MKZxNptr2ZTs3yz7nKixKaLlGx8/hAVK2go7cul/NBOib0ZCqEvu/TwSND5H
 dOL+5x7r97z8WLW5ECpPHABOZI29Lmu+OZ4IOkAT9jDc8rEAbU/bZGk82xZQijGzF31j
 Z2ggnsWfpXsL45DTWS/zJfZPnAKWNhqPIQNXdo+SrhPsoDKgnY8U0GEbu6nGF9wtDXTz
 njUKk6PAoTTpq2uCgTXrvoqEmn4P1Al4Xo5qp+uB1pz1tChj6C0ZaQbkgqBxfzbqNv58
 sayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739188314; x=1739793114;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P9tAvp6r8kOY87WceoaBiekGM0rVtgkrdKYF78gCjTo=;
 b=Sx5y5XCINc+Z06JzLPi8GjtVsIBSvGD0boJ+8gDdI8PRwc52eUMLyc7km1B+Lq2G9w
 zH/d02W3K+o28UxKPvzDDxQTJOJ/Zoai/q/P/Vs1ncWJEWgzifGSe1lxBJvyuSd4KfXv
 aEw3osTjvy27tPMsEUUF1aIZyIV+MI38+I56RWeTwdSeLHpxkGfhiFZT/cSKrP1qswp8
 jeaYQ5C14HaXpzoOlC0m3cq/WPkXwnv7iSseg+lWCGryw5dTjhSJCCiKayuyFyl/J70V
 IilPBjkwY6izOTaKgvPmVnvqNpgy4peZ8QEwGL/VGGmZY3zfP3u4TGvLAaSNLGZUaR3Y
 sNHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0s9A6x6YkS18tiYxkXQhAQTBn97D7GKy2ydgPaJC7B99oVXqyIg5FykkeSVDSq9xjvL0gjw+c7Gbg@nongnu.org
X-Gm-Message-State: AOJu0YzkgcZOXHHPQPCHCvwuDUdCxktQO9rayt09Y091pJlK/JDW2ups
 2XrYXnF7GRn3hzKPSCb6jEocyK8IIgmngbUkH0sRkfPZYIRdTJYl
X-Gm-Gg: ASbGnctS1g6DYg5DCoeFgyyDQJzPL06AGRW3bJeAJyLMkTKKfqesIFa+zuAAkVY5pKr
 YX3mBue84PTjUZ0rMnbHK64msAp0eTNsd34vuas7LVPK6TWzv+pdSkNTZkjvGeqWebp8f+tkRN0
 MqbFEyPRBFFhswveX2Qo/kIANEFoJwp9PMbjV+u+Q81BF5moU1gEvf3TmfbtO37hsxWKzDVJjmT
 1DSwL1n330V+mRdRXJNQN6chRTLA5FFyTHMPUdTJeSM/u8B7HbWPJIypHqQtOc9EQ6OvyNu0MeP
 zLHJ5KqVxQE=
X-Google-Smtp-Source: AGHT+IE121SwXBgi5jzD6zcqeOEQ/S3DOfxbNjl0696niG6xDlbjd1x3J2K5y54IfRGO/yf6bv/p+w==
X-Received: by 2002:a17:90b:184d:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2fa243f058cmr20492432a91.28.1739188314154; 
 Mon, 10 Feb 2025 03:51:54 -0800 (PST)
Received: from localhost ([118.209.251.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368bb4bdsm75518615ad.235.2025.02.10.03.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 03:51:53 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 21:51:48 +1000
Message-Id: <D7OQSUZR3065.2W7CYPR1UJMWT@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 0/3] ppc: Remove ref405ep
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250204080649.836155-1-clg@redhat.com>
In-Reply-To: <20250204080649.836155-1-clg@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

On Tue Feb 4, 2025 at 6:06 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello,
>
> The PPC 405 CPU and ref405ep machine was deprecated in QEMU 9.1
> because there are no known users, firmware images are not available,
> OpenWRT dropped support in 2019, U-Boot in 2017, and Linux in 2024.
>
> Continue the phase-out process and remove tests, plus boards. The 405
> CPU implementation is kept for a while because it is possible to model
> the power management (OCC) co-processor found on the IBM POWER [8-11]
> processors.
>
> Thanks,

Thanks Cedric, this looks fine. Daniel mentioned updating the MAINTAINER
file, but I think since you've removed the board then the entry can just
be removed as you have since there is no separate MAINTAINER entry for
the 405 CPU emulation. I think the note in the deprecated doc should be
sufficient for that.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> C.
>
> Changes in v2:
>
>  - keep CPU implementation (for OCC possible models)
>
> C=C3=A9dric Le Goater (3):
>   ppc/ppc405: Remove tests
>   ppc/ppc405: Remove boards
>   hw/ppc: Deprecate 405 CPUs
>
>  MAINTAINERS                      |    6 -
>  docs/about/deprecated.rst        |   17 +-
>  docs/about/removed-features.rst  |    7 +
>  docs/system/ppc/embedded.rst     |    1 -
>  hw/ppc/ppc405.h                  |  186 -----
>  hw/ppc/ppc405_boards.c           |  520 -------------
>  hw/ppc/ppc405_uc.c               | 1216 ------------------------------
>  tests/qtest/m48t59-test.c        |    5 -
>  hw/ppc/Kconfig                   |    9 -
>  hw/ppc/meson.build               |    3 -
>  tests/functional/meson.build     |    1 -
>  tests/functional/test_ppc_405.py |   37 -
>  tests/qtest/meson.build          |    1 -
>  13 files changed, 16 insertions(+), 1993 deletions(-)
>  delete mode 100644 hw/ppc/ppc405.h
>  delete mode 100644 hw/ppc/ppc405_boards.c
>  delete mode 100644 hw/ppc/ppc405_uc.c
>  delete mode 100755 tests/functional/test_ppc_405.py


