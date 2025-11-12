Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E6ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 04:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ22a-0006eu-Kv; Tue, 11 Nov 2025 23:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ22Y-0006dz-K7
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:01:02 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ22X-0006ye-6J
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:01:02 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b728a43e410so79054666b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 20:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762920059; x=1763524859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2Zjx932DeAY5fmtbYkHiKNzl90m0sgfpN1m9WHc2sk=;
 b=Fhi+5Yzc75VKzv8edaAYn598CRnNL+mMCTet/fcKqAFXDVwdycKP4NZ/GiRvhgKvEZ
 27yg4dbHeKzyorxzR+Mui0ISuIWASMU1QNFyT1YTH6qkOv8CG/mUrpqX87tZSKm4gj2M
 f2uw3rLdLW9cr/ytXjgOoogphvMZzwlLYnuoFoHn5NfFQ6+Rj5rqn1AV3ADuu2KriX+t
 7dNOW3Yh8SE9eltwj+HSn91iciFycIDO756T/kDudOUnBPXx6wrz8HV2Vf+tFcV91RS4
 n3H2ur0Gc2+5DX2oDhut1SmvLQfF0u3vYkIPSvcWRzTXQxKdJ5h0Sbn2Z1s45Hzy0xJ1
 3svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762920059; x=1763524859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q2Zjx932DeAY5fmtbYkHiKNzl90m0sgfpN1m9WHc2sk=;
 b=MW8eYEa1/PBRoDVGZEENVVxDJfDQCNtGNVt5wodhe8BZ5N3yCCXB/plLRQes88P5uO
 MbyZaz+MChqEjSFNT5whu5zPUWxOw12JZbSXkkAFcmCnGLd5hZWf9b7s2d7idy9fdfC5
 4HPXvFF53r2zJI1whVDpUJkANPpxJ6C4+1xdHTfHE0OkIMxqMNhTGjHf6cTs2us+LiF5
 6QwkQEiLDZnyO66jEC4+0Y/VQSwRQvUxcYGGCtPSvEg7I8HjMt5yowai2Af3qxPuP6Gi
 3502l/zHcpJsJqht03SZ1WP329gG0zxi85An71wbZ1fvMGvFjxceoVVvSTdd84rJmkVh
 BjJw==
X-Gm-Message-State: AOJu0YxcCT0k9lQukvviWZchIMLHxT5A2hQg7/4DSSPEI/s+DwIYzs4D
 e0VXZ53ODnUmhzat3q+At0At9m0HeYErJzT8NdpK6B15+frDbx7d2DglawikWXRCeTSYX49rexO
 HQ5xufAs6mwfIkaiXRY5Ymdxjsr5ut2cpsg==
X-Gm-Gg: ASbGncsTYmaWf6GobQ/2ZUVhdvdsZASopLHObXhWNdG9p/fmp5QM332b4iWi4k974+q
 QuHrM0fGeg1ZtacMOi6svsUSZtiKRxTqzyG7ctVb7r8wYlIQDwDrQRnYboCGVUDDPvoO2+0zV4Y
 0XBNTsYWxx5JrGGrWbsAth6nkfcQzJYXTBcT4wWYAvXXsgczF6EKzh6GT/78lYsBlbsl+Jtx2CA
 tcF4zwTE4g5T8Qhr79JYCM+PP1X3j8SHZgGdt3MT/wSCmWZFYV1BOXSJGFsbLMJCrrRLlbhwR5Y
 VkYHYy168jJTgkk=
X-Google-Smtp-Source: AGHT+IEScJWgg44K6KkVkKLlXAZDpQoU9H6Kt1q6NfrDpWu4RKso31mB+8ApdoKl05XSAF/Xcq5efbFXyZWkz4uzPJc=
X-Received: by 2002:a17:907:97cc:b0:b71:df18:9fc7 with SMTP id
 a640c23a62f3a-b73319c0acdmr132603766b.29.1762920059576; Tue, 11 Nov 2025
 20:00:59 -0800 (PST)
MIME-Version: 1.0
References: <176154834968.21563.217396575391240410-0@git.sr.ht>
In-Reply-To: <176154834968.21563.217396575391240410-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 14:00:33 +1000
X-Gm-Features: AWmQ_bm3qw5M0xwyl_0QbGQTeoliXcBI-E4SRgs3xjp0zypDzVE9OjK94ScW83g
Message-ID: <CAKmqyKN2LA5927RhEQ5dDMA5xHYwOPS2oPLVNxYepgo7nBTA-Q@mail.gmail.com>
Subject: Re: [PATCH qemu v11 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: "~liuxu" <liuxu@nucleisys.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Mon, Oct 27, 2025 at 4:59=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
>
> This version has added a SPDX-License-Identifier.
>
> lxx (1):
>   target/riscv: Add Zilsd and Zclsd extension support

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c                        |   4 +
>  target/riscv/cpu_cfg_fields.h.inc         |   2 +
>  target/riscv/insn16.decode                |   8 ++
>  target/riscv/insn32.decode                |  12 ++-
>  target/riscv/insn_trans/trans_zilsd.c.inc | 105 ++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                |  33 +++++++
>  target/riscv/translate.c                  |   1 +
>  7 files changed, 163 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
>
> --
> 2.49.1

