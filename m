Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABDCF532CD
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 04:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5G7v-00031G-9V; Wed, 25 Mar 2026 00:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5G7u-000311-LP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 00:45:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5G7s-0005Mq-UX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 00:45:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6694d00e01bso3816765a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 21:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774413951; cv=none;
 d=google.com; s=arc-20240605;
 b=f5SVq9RN64gYLoDJ/jzGvwoSBCg1L6BC9YCdXJg3IwC7KE/vK/nbqqzZb6tiYP2Gd3
 yIbiIsSt6C5/xGGg8FLOgstGjS9ZOgDZLa45WoR8w1DagTVUCB9x9innP5I5AWxwXfNv
 MebtH6gN+9SHmfyg4QFewhaJjr9XSAIDq5W4nEib36GXuxoTZL0f5joAHI++rpSptf7P
 6NfFKWtJ6aoT8vK3hjuOM2dYCraYBvA0tfMN9P/gTjV33QV1aDsAqyw9pjOVPVFwQp5d
 NsJMigQF4EgT0mjQGomHGriJcRTThg03utPm1OkjuJoVj9z2EqfKDRpH7smMB7l5M6FT
 2n/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kHBZgLm2nO3pYgmaNgbU6zBMMZU6HIFx1PQHBArt1GI=;
 fh=NgGa+SbmIDxP90MN50ZytsCb+pJUApNodX7mi4TKv/Q=;
 b=Ktu/QkaSM3LfP3sky0p5CacW4JkNme4xm9CFew5MtBDh/Dx5NAc8okaUtZoQYvIpUR
 mwD1o19f3VCyCeu0CAzDgswKWPdtPn2KqYmWFFwI6MK62SlOtM1gyJVPjFd48fH3uGtr
 4OfOR18JfEgNNnqLgLTzsrAMyQDHEpaUINTVIDDzhsHSV3yDKqzD+KcgY7F/MdzVY5TR
 2hRhL+4RkCNb09QWs+6Ip/jT8zgHtWJADhhB2wdaMgBKKSWSOQYP1KlTMwtDvd5gOHhT
 9kbW9rUq4XeDXa3PeLAG1Rq/mt7p3OnI2LjPcN9TjiI1eRV5y80GgApnDdh/BRpqsyeh
 ixxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774413951; x=1775018751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHBZgLm2nO3pYgmaNgbU6zBMMZU6HIFx1PQHBArt1GI=;
 b=AKdBrGz8Szje5O43J8lrEPZ8ZztaOo6pnspyV7tCy32j8Mpvrm5skaAJ4zKqSVSzgL
 O7hqNz66gfOze4t5OGiMRvkMZVjSi3EdzeekisiFd9B2ftmINnaUeg4hKiK4Lpqei7Ze
 pQfRdhuFQkME8PkMbc+93b6mejWMwby9LvME8T6CdaKsSFxo1ucHGIxbYMyLUt1adTff
 qpz/P9WCItLRD8L+6VtmHaHFS/j4J9l98YMLElA5Yi8Zj+dwQESs2suPNpnKLPOcWsoq
 PpCN4ijMGm99CFGsYGy+TH/rwhBgaLoldpLRbW2jV+5b7UMGUJtIX/49KSgJRVyH3eLY
 qLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774413951; x=1775018751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kHBZgLm2nO3pYgmaNgbU6zBMMZU6HIFx1PQHBArt1GI=;
 b=nCqk5SoLsScgNgnujGRhNgJ5iqU+Q1p2U6HwTr3mGSNNeaF+Tfr2tRJ4tWwwCO1HRu
 8tx7Gh9k0aaeeACLEXyhuwqh5H05YVyS1Z8uYKD6B6z9stTd3tHVGkpF4d7Qe+H88kme
 WsYH6CC2m0VaWoSdQvOso9naPjOJmoVIUxG/lvWmW5LcTs0GaH9hsyhWFeTh3lCHObPa
 UdMUsmsPCcKJQz+yjqKcQmcPg/YhA38vqOP3E/7N3iRt0g6enj6qsXIp5DXPU3polbXK
 z+ASOUEFakPniIi2VPPj8p213xnc1ZNnNRoVdsu7cGjowXdx8A6+13viADi94ioUkECh
 tucQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTi22p+vHLk874EQl2GLz5nq4rmDVvfyFQzAhysoMmYB/kXaxk/7lgSd1gDz6X562qLgyyrdLdHuwD@nongnu.org
X-Gm-Message-State: AOJu0YzfIiih5wRG/83Z+TQ2NiNmH9bIUh2PCeekCC5naIEkEBKxAR2f
 LZYUnAKnih/vozk9oHz0XH0kjedIbPh5IJyD7tYKS/W+zEo7VG1p6uvIeoolQbHingLZqS0FGqV
 IrVpNoejGvcYYIrjb1Nj0gXQBOVu7wE4=
X-Gm-Gg: ATEYQzwm8FUm+tUsryvFD8Ige6LcIShuNmi5TsOXkzn/8wwZzSsmIVP9p2fKRqTx+Hj
 aqjVpLcLkkh11vmU1DKzmjnNLOppQn5AEB1TOFfdbqjaNtWbYZAorl21NWOXh5uD9j6t4ccGT1+
 8iZUCGLKNyG0QHj+BtIOyPxf85JGpWRNy5vxyTFXL68T3sNMdumGvVxlEjWPWKwJ5qXEwcgTBxy
 ypoMS9xLJIIAy9U7++865EggDDGXoHBML3cCwxDAJJUGsfli5MCuWXUjYWg6MxQ52UGC6VwK1V3
 PkJJq+afQjPxDUECow9ZqvuqC69zCpMDo7ZGjg==
X-Received: by 2002:a17:907:8690:b0:b87:2f29:2060 with SMTP id
 a640c23a62f3a-b9a5420d3camr160235566b.26.1774413950650; Tue, 24 Mar 2026
 21:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
In-Reply-To: <20260321141345.599105-1-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 14:45:24 +1000
X-Gm-Features: AQROBzALBLBFfVlyrj8e9-GUYZI1o35U9N5z1JEboLlM__mEXvNv3JwK8Niufs8
Message-ID: <CAKmqyKNmYtA7vnp-VLBWQeRFFi0GW-9eV+Mt3wNAPdEYe+UEzw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] linux-user/riscv: add vector state to signal
 context
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Mar 22, 2026 at 12:16=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> Changes in v3:
> - Fixed up a bunch of good review comments that Richard made against
>   the v1 series here https://lore.kernel.org/all/06afcbdc-28e2-4d13-81d4-=
26fd257ed8a3@linaro.org/#r
>   in particular:
>   - Restoring vl/vtype state using CPU accessors rather than stuffing the
>     values into the registers directly.
>   - Fix ABI types.
>   - Fix some confusion with host/guest pointer mapping.
>   - Fix error handling to SIGSEGV.
>   - Style fixes.
> - Fixed build issue without riscv intrinsics header.
> - Add some more test cases.
>
> Changes in v2:
> - Fix 32-bit compile
> - Moved sizeof_rt_sigframe change to its correct patch (patch 2 is the
>   one that extends the size of rt_sigframe, patch 3 is adding new
>   extended state to the frame which is added dynamically).
>
> This series adds vector state to the linux-user signal handler,
> and adds a basic signal handling test case. As a sanity check, I
> also verified the signal handling test works in the same way when
> run under a real Linux kernel.
>
> Thanks,
> Nick
>
> Nicholas Piggin (5):
>   tests/tcg/riscv64: Add a user signal handling test
>   linux-user/riscv: Allow restore_sigcontext to return error
>   linux-user/riscv: Add extended state to sigcontext
>   linux-user/riscv: Add vector state to signal context
>   tests/tcg/riscv64: Add vector state to signal test

Can you rebase this on the latest master branch?

Alistair

>
>  linux-user/riscv/signal.c                | 281 +++++++++++-
>  linux-user/riscv/vdso-asmoffset.h        |   4 +-
>  target/riscv/cpu.h                       |   4 +
>  target/riscv/csr.c                       |   7 +-
>  target/riscv/vector_helper.c             |  19 +-
>  tests/tcg/riscv64/Makefile.target        |   5 +
>  tests/tcg/riscv64/test-signal-handling.c | 517 +++++++++++++++++++++++
>  7 files changed, 807 insertions(+), 30 deletions(-)
>  create mode 100644 tests/tcg/riscv64/test-signal-handling.c
>
> --
> 2.51.0
>
>

