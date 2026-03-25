Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B94103A999
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Ds5-0006d5-3R; Tue, 24 Mar 2026 22:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Drx-0006bx-KB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:21:17 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Dru-0007Uo-CJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:21:16 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b979d16dd0cso897954166b.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405273; cv=none;
 d=google.com; s=arc-20240605;
 b=K7a5EoinI3sQW5ru7F2BToB6HZCST+qs1D1G8c1Qoi93aNIIUt9o1QQrtXylPqmaud
 JF1kZeKe5aWVoItMMTzZoblGMbEhih7+AvLkmaUbUt2x6RRkMw3UI6e+0JXW6RZjKQKY
 yZZ3WPxnOIQM73H1ppuOYyoJl145kMiSj9sglqX/L7QWrAQ1jhHedbULdz5WnjZ24wCr
 QBhPXkNU3wKz8k0XJ2eKGNEk+zNf4Yjp1blt+WyXW/YIMaYUiwll9N+ahwj2wzZreHzI
 w2/CPF3IGtsInwpYwK68T3LDBRNL8HdODAQ+EB8roMob0FlIKHO5bqTkJo15z+9FCTgS
 6U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R0KQhFx4IUtIoIWMtmfoysm490eA1E6cw8zO+88Btew=;
 fh=Zgl+7kiOUFXFIsHgLFVPxIe73w6S10Yy6NxNqk5hgw8=;
 b=B3d849MZ1vMta08vdYCMDNILDdNLFXk+9o78c0s1fU8WS5kGotLlc2UsSVv++ArK6g
 QWDdrTMiKSU8J9PkXfDE+UcZQTiMzkLQxjU3V1r4VqsoiIK5WogmoL6HEmtPTOjbpXZ9
 bNhu0W3cUBhmghlvAj/Adgh2hvxhH8VatkAQcOYvq8RniGtww5kncaw7Us7jHPvPYauH
 FZGvVpDOS1jaAZrG5+YzHT2WediOuUdZ1dSJoDFrnqUVotZaoYBnlnOdkL7mX55g6/Uh
 1zBXPQT5Y87OdXQlR1AfzjilD7igT7iUOLTX0pr4idwg4M3kXWJ21lSGSO6xV6ij6ze+
 E5hw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774405273; x=1775010073; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0KQhFx4IUtIoIWMtmfoysm490eA1E6cw8zO+88Btew=;
 b=VGbbkMxFD7kGfEzxlcMbM5Zr9hLJtQZkkqcufy+xHNI1iORi8tfeslmqYmxWT/VRgf
 AjVNw0cmBZ+vWRnSmIdony/LhbTnuRHHPrwC/OabW/OBjFnZu50fKzI+jAAmeYWOcB+K
 kZ90FHRj8/qm8etKSzwgxA/w/jwGwUwGUy2Nm8yY1mGEbiZ5Kc+yN28l57EBg3nVMwml
 ppGCjArMdNbN7xUBxeglyblCDRzWwszlzFFQ4LkuZimNWDdDdOSQ+U9wWsXo/8Goc5Qp
 UQbiAzuSI/001q9tZagSyVb9TEAqlKzeDiQ0klJ6Er44WWWFeJih83ki948keOo7+vMb
 RINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405273; x=1775010073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R0KQhFx4IUtIoIWMtmfoysm490eA1E6cw8zO+88Btew=;
 b=fZRr5Ga5/hq6in3qrY3dNQFu1ejxR0tqY4R5D+s2bPTwKqoIiZzDsQQtg28QS+MJ6g
 lx/b6oHYYD0xT6cIiS+I90sPRNgSRxk48wl0tm7aNe5HOp/H+iPCpKlczD88gcJXPy3A
 e9YadQ9+SlSz2orNPEt4hS/IMz+WgMkUA5Ma8PrNejWQ0LJY1tk333iXZOlZQoXhG8nR
 6JSEUPn2uXH8h/UG/OUd1PwS6xy1EZ26V4gimfocgaqunhOpbzXbCdkHqiWyfpVA+/X8
 czDMyw+sWe4na2zXwfFzMDfe/J81yc4KA9NiUFO/i2SqER+awleQZ2A7H23x2yYdve76
 es/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcoQGwYUtHDMfUQcxaIDSbb0HkKoM5CUUQjyz2BOpbkCNkt245fKnhHKUprnqfeq49jhY8Y0Iv1AfX@nongnu.org
X-Gm-Message-State: AOJu0YyGQY909ofmfez8vseCDzsZqbmal7YnuOm2APu3eHstxMwID6p0
 uuJp2YcP12o0HFQhmiXAMoAOStxU0dlhn21TZ5qNB0ndS7WoauNADlSrHRPQX572YwR5om2mnIa
 yHpcez87Hay/koYLas+8OvtRtgmCRfKY=
X-Gm-Gg: ATEYQzz02MxCGNpbcSsZogFv3YjmcmnPMXsR1JHmNhgmYrtM+oR9JCcJVY8xGSdYKom
 hKLdW+qUFZapk2cEycz+LXmcr6kDAKeOKdM92SZjR2/DOGCToiQLPb43mWuXqam/vU+YC35FvE3
 +vleUUAs+ONFbAeOVufxGSrQkKmvqPj0gqhxdHIwoqDB+si+uBNl9nQ/mwAi9nVmz5SDqKi9pYh
 nD4Bl8UkXyfRewLoyCO7I7CUPZmPRjGSTg53P7pA5J0NLcCSvVmeYHLqGbAIgRc9GfGtQqW/24M
 MH6A4HV+n5mLeBwUGL2TaGh+taw4iflnnntxfA==
X-Received: by 2002:a17:906:f597:b0:b97:cebd:8273 with SMTP id
 a640c23a62f3a-b9b0f0fa536mr61458266b.24.1774405272649; Tue, 24 Mar 2026
 19:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260321144554.606417-1-npiggin@gmail.com>
In-Reply-To: <20260321144554.606417-1-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 12:20:46 +1000
X-Gm-Features: AQROBzBEn4Crmvn43j_9IR6fZXWUvN_GG2TEs8scPR157S_PZTv5MrcJEJrk-zw
Message-ID: <CAKmqyKN_not2pD=BeFveOnej0WiuofgcncpZXy2D2PyJOvkmqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: corner case fixes
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Sun, Mar 22, 2026 at 12:47=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> Changes:
> v3:
> * Added vloxei8.v to overflow test.
> * Added store variants of interrupted vector ops tests.
>
> v2:
> * Added a tcg tests build-time check for vector intrinsics support
>   in target compiler before building new tests that require it.
>   ci images may not support these yet unfortunately, but upgrading
>   those will be a separate effort.
>
> Thanks,
> Nick
>
>
> Nicholas Piggin (3):
>   target/riscv: Fix IALIGN check in misa write
>   target/riscv: Fix vector whole ldst vstart check
>   tests/tcg: Add riscv test for interrupted vector ops

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/csr.c                        |  16 +-
>  target/riscv/vector_helper.c              |   2 +
>  tests/tcg/riscv64/Makefile.softmmu-target |   5 +
>  tests/tcg/riscv64/Makefile.target         |  16 ++
>  tests/tcg/riscv64/misa-ialign.S           |  88 ++++++
>  tests/tcg/riscv64/test-interrupted-v.c    | 329 ++++++++++++++++++++++
>  tests/tcg/riscv64/test-vstart-overflow.c  |  78 +++++
>  7 files changed, 531 insertions(+), 3 deletions(-)
>  create mode 100644 tests/tcg/riscv64/misa-ialign.S
>  create mode 100644 tests/tcg/riscv64/test-interrupted-v.c
>  create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c
>
> --
> 2.51.0
>
>

