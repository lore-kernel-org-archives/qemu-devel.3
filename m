Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA943106FD60
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0qre-000394-Cx; Thu, 12 Mar 2026 20:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0qrd-00038h-EV
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:58:53 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0qrb-0008AG-Uw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:58:53 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-662dc987dfdso2545448a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 17:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773363530; cv=none;
 d=google.com; s=arc-20240605;
 b=AsO3w3iW8YqZ5StcnqostzTgEDJC+p0rNJ5e5RQSYccA+iOLHQRT4Sz5CXbHFVqup+
 mk6wI72lwn2RRoTbNG6A2Lg1bMlguSoSRFE9u7d0VgC4LIdazBzzF0Pziyp/xo90VsCw
 503IcKUGH9Iq/SkTM/o1cE5yeBL5doCwHsOw29F46VvF5emWaVdkPxlQNxhrTPZU1ohK
 a53XJHHdqSIBRxL6v3Wssm8VGosSk1WKmoGKFugAEf7vSMkmOWcaH3nCF+9IxVvFJTGQ
 lMCVq08QIG8mAb5q9ZrTrI67xcJ/q7lr05kkEQQgC3Nli9H6fPJEG1r4/kSDVDJ/6uky
 hWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/g4pajeCzlHjQqlg/fCbwj5HeWgld8QQUGVjkzVuvUM=;
 fh=/gTf2YcF5eQ7UndRzpboPIWZmJCIUbaHpaDcxwxf9bk=;
 b=dvkjuHsUGVII4jrKwk0Xo3cISbHh59j+lu3rkbKoO350VCjcnPNn+3yGfwdpqC0cN5
 ccsZ0HTFJStJ9hnOe2LeErhRV0BbPa9oAXFcIrV59kynnuH9Tdo/ho2h8qKrBRX3b8zG
 v77gkoeKBl2/wZRLTUy3OvfWWQE5VgvVuMSKa6Qh13sDuRdL/XM/vzS3US1LEaHr/mm8
 b8zOMT5Ri/4TWYKMoMqvdVjmVt7Bu01HmglQhCK8y+VJK04YVhEeZwGLE+H+pGRv1Fck
 4+KlCwIlyAIbCgEdq8b9kolLc+fb/GWprbdk+XDShKWUa/rZiwtYeeZ1xCucAg8gB/Ok
 evBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773363530; x=1773968330; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/g4pajeCzlHjQqlg/fCbwj5HeWgld8QQUGVjkzVuvUM=;
 b=kzAuwhIvGcI29AF+wCiyuKD2ZBNNxct2ZoYpDB0hBqjFjTyj+LFJawyQ4cEhEieqWy
 fRIESN6fOGXn87NpSxoVzQgzjIaRhe211TfSKwJmWmL4X/Ge6q6YXxvUmTKFKHrEyx22
 GIEwiGACNoBPTV+PSrfej1tq2coROH4mveP5EduMQlZNKOli0mUpmNCoPiQZekxwSafj
 QaYvC8+wm0GiA2LfkC9gKLWaMtb70TuaIOMMJpaL9/9vwmpKrlSn8rtbtgNrRzaFLQn7
 08D62SXgbLQCSLBShBkwpaeCZa6/wEXy5Xtl+0LgYH3q8H13XZQ+6yI/+Rg24Uxux4f5
 GkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773363530; x=1773968330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/g4pajeCzlHjQqlg/fCbwj5HeWgld8QQUGVjkzVuvUM=;
 b=syNvRcwLS59aq5Dqp//X3oyhmG/mh7/KpWkxja6S6dx4aX+Kru5nakhu/s2oc0CIoL
 6RRcBu6VkSqUu8MaPoeRRwSa2opkZPzQUYC+w/SDf9/CfO76erQZiv5GNmOPAEEKr6RG
 h1ZuoEaowYX2EJ+jyfJjrQfP33q7ikvT3wrXPO/e+2NMAMEZhhr1pyn2hpdgnIQQASRl
 kgw2IB6Bw5Gq1qbOchTjqSur+sthJoeTQ3Gv5C87cUzl9FYrQXaXXSSnTz1C5bEb7/G0
 2vm74D8bRUr1mf4CRcODMhuKoBaQf70aelgnyW+tWJfE99kC3D7ClE9/ouuTqQY9cdjw
 o5LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK4iW3TVZ22jxNE+R5r7jtSQ/cjCpKE8q/sZHMC9A9KdYorDrD8E4JZ0L94WFWvcAlW4PjeEB0+2m6@nongnu.org
X-Gm-Message-State: AOJu0Yz9CMmklnvgbWZXN++ztxcE4x0cuA3khfbM4Rz+sCD0q6zzA0pc
 eIeEzRxygF0f5Iz/MFSaEBYkYX+fTGA0l1p2ZEtoCfndUv0RMPslQj9+/s5IHxCKtfRtgfpGXAe
 TATE0NSZ04GP4v2/9gmgVF7so5CqSMzw=
X-Gm-Gg: ATEYQzwYx9W3QRhvG2b0w65BPRCFdEqyz/T3f+TT7gzatA2/ds/H/yE3/4sUncc/8T1
 li6T2ndgQRVJ0yGlGno2Wq20bB4TmZVaxDvX/gxg+W5CoB96IHiC666m3Ch5y5usnM5ERUUllZz
 8hrdAHn2D0zYS9+zHBMMMyjRRGaDm+BN4GWNXJK7q/rVcsP3CphkJEj0+deZeCadlvm/EQaIuh3
 /L+gOL9y15TDshFNaEb+j+rqvm45Y28QHstdeR+ARTYIPXTC4RuK0JgI9uKhlebXunLI99S0MoP
 Vx52K9gDTUsLKx5OVg5CW7m0XhbiGaoudxaoQw==
X-Received: by 2002:a05:6402:f0b:b0:65f:b7c4:d4ae with SMTP id
 4fb4d7f45d1cf-663babae253mr533798a12.2.1773363530191; Thu, 12 Mar 2026
 17:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260312134210.5823-1-james.wainwright@lowrisc.org>
In-Reply-To: <20260312134210.5823-1-james.wainwright@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 10:58:23 +1000
X-Gm-Features: AaiRm52oEjIfNcwSGfSGm0YfBHb4PG0qp3qf4kxoABuuMlK2IrEwUMVwwHpiC7E
Message-ID: <CAKmqyKOJSsvGRZY=_-MWh3yuUS2Ur2Gb+Ng8+eY9q-8o2QsNdA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] target/riscv: add unratified RISC-V Zbr0p93 ext
To: James Wainwright <james.wainwright@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Thu, Mar 12, 2026 at 11:43=E2=80=AFPM James Wainwright
<james.wainwright@lowrisc.org> wrote:
>
> > Looks good but you didn't change the names in the commit titles,
> probably worth updating those as well
>
> Good catch, I missed those messages. Updated.
>
> Thanks for the reviews!
>
> James Wainwright (3):
>   util: export CRC32[C] lookup tables
>   target/riscv: add draft RISC-V Zbr ext as xbr0p93
>   disas: diassemble RISC-V xlrbr (crc32) instructions

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  MAINTAINERS                               |  5 +-
>  disas/meson.build                         |  3 +-
>  disas/riscv-xlrbr.c                       | 79 +++++++++++++++++++++
>  disas/riscv-xlrbr.h                       | 19 +++++
>  disas/riscv.c                             |  2 +
>  include/qemu/crc32.h                      | 18 +++++
>  include/qemu/crc32c.h                     |  1 +
>  target/riscv/bitmanip_helper.c            | 20 ++++++
>  target/riscv/cpu.c                        |  4 +-
>  target/riscv/cpu_cfg.h                    |  1 +
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/helper.h                     |  2 +
>  target/riscv/insn_trans/trans_xlrbr.c.inc | 45 ++++++++++++
>  target/riscv/meson.build                  |  1 +
>  target/riscv/translate.c                  |  3 +
>  target/riscv/xlrbr.decode                 | 30 ++++++++
>  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
>  tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++
>  util/crc32.c                              | 85 +++++++++++++++++++++++
>  util/crc32c.c                             |  4 +-
>  util/meson.build                          |  1 +
>  21 files changed, 388 insertions(+), 5 deletions(-)
>  create mode 100644 disas/riscv-xlrbr.c
>  create mode 100644 disas/riscv-xlrbr.h
>  create mode 100644 include/qemu/crc32.h
>  create mode 100644 target/riscv/insn_trans/trans_xlrbr.c.inc
>  create mode 100644 target/riscv/xlrbr.decode
>  create mode 100644 tests/tcg/riscv64/test-crc32.S
>  create mode 100644 util/crc32.c
>
> --
> 2.48.1
>
>

