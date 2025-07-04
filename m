Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8851C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXe4M-0004Hw-KQ; Fri, 04 Jul 2025 06:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXe3k-00046D-7C
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:54:25 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXe3g-00015O-Ro
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:54:22 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4f133d4c615so220238137.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751626460; x=1752231260; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEkxHlSIsQcKS2l/yfgXo+4iGAdTyzvljQea8tudB20=;
 b=I5YTJo2nmt3Ljnv6R//Ew20Uhil4UtpqB7UBPrz1vmdGbWLHLh/QbFQbczCrHXcP8t
 mRBNUrK2NMAWp0ICvW0wQmupcLaMLtMgvLO/9OrAP/8gFKQruSyS4lfH2JMIM0Ba1ixD
 ppPGchfy73oTV0GJYKjx4iZ2WOSPHiQawMT+BWeLj2JKlRR5MumeanW8KY19/Phww2ab
 ObiohuIr5aaA3zE1tlrtcoe9ZNDy2QMnAVJjh6Af3yinoP3RHFnBseGiy0kBfkwwVGdh
 7b3sHAGxxDjWNQU3GWhwlaJU3av84aKM0+kAQ7FpQtO2ovtEC/D/yDlv3uQIMRX0k0sb
 C6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751626460; x=1752231260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEkxHlSIsQcKS2l/yfgXo+4iGAdTyzvljQea8tudB20=;
 b=O0vQRvVz/IUXRJGELzti3lTmX+XLf4ccTbTLqrqzl62vH6Jb3I795CJLucnOkboW8F
 ClF4ZrA40yS84zx9hEyb9CSo2ZTNpqMn/4KC+jZdcSydaMaQS2sNJCmstt9q1eiqiGK1
 u5xT6rGIrq1s4mj0jwXfb22MsNI6uWT+6OWWf4vZ+L/NcjZC2yH/Q83WAVFT/v/HU6ed
 kkd5yg+1zzMRWUBfBAsUF13dL3cWCfkbRBYrlkI63kWI6F17F2/3SJcdyAEdbM3bhvYC
 DhF09rOKC+pXGCK/qhCKcyJaXxCw6tirquLoNknD2sLq2wUgfbIBQ2hNeUCUfwpR2ne+
 ZqkA==
X-Gm-Message-State: AOJu0Yzq//C5zPAjdwFjQ5kkC6UdP/epJ635HFREB4DRVmIvgPiVYBdM
 XRry+XrbvOKGaJnkrHSTvdfV/dgLKtjpYLmAsJfiAG9Uu7F1SoThJQwhW/nToNbIKFdax5wCk44
 FDsZ9sHWJtE1bJO++yqVEeHyvP4Pei2UoAGUU
X-Gm-Gg: ASbGncupvchjnaEi4s6z3G4KtRg8vjYuLkhbYp5aatzIClckccAzoQIypbDrJOvajkA
 /QBi0fIAeJULCZQfsHiL2aXzSJfythS8CRTw71oM10cJjvUn2ZmgGt3ytAKK38m75ilkjQ2XRFR
 RgA5d7s92j0lD8GYejj4nQ2C/PwNlMMvIss4q/jNst3+OU48p9dv24ohfoGEQhJqTcMr5Lfpm5A
 A==
X-Google-Smtp-Source: AGHT+IHElLHGE3uvdr5dS2VQzJ1bl23fbMdvVc3axAkIesRgX5ETsXkHwWbI7PmBkhy1//UbS3+NQCmjPZzy6jlSrNM=
X-Received: by 2002:a05:6102:160c:b0:4eb:53ca:3d0c with SMTP id
 ada2fe7eead31-4f2ee263920mr1245329137.25.1751626459627; Fri, 04 Jul 2025
 03:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <175014178352.19565.9471325854234944512-0@git.sr.ht>
In-Reply-To: <175014178352.19565.9471325854234944512-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 20:53:53 +1000
X-Gm-Features: Ac12FXzJWCxXzqeMTV4BCBgb2bhh03Z3mlrgjKFxW3atrvfRoOOTlgV4SFUhGWc
Message-ID: <CAKmqyKPWDwi9XnzmdpKe5PN9uu+FFTTcuVNYgiz-GWV75MCWeg@mail.gmail.com>
Subject: Re: [PATCH qemu v9 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: "~liuxu" <liuxu@nucleisys.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Tue, Jun 17, 2025 at 4:29=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
>
> Thanks for Alistair's correction on the V8 version.
>
> Now Zclsd has been disabled for the "max" CPU as C and F are already
> enabled.

This is still broken with userspace mode:

```
qemu-riscv64: Zclsd cannot be supported together with C and F extension
```

Alistair


>
> lxx (1):
>   target/riscv: Add Zilsd and Zclsd extension support
>
>  target/riscv/cpu.c                        |   4 +
>  target/riscv/cpu_cfg_fields.h.inc         |   2 +
>  target/riscv/insn16.decode                |   8 ++
>  target/riscv/insn32.decode                |  12 ++-
>  target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                |  32 +++++++
>  target/riscv/translate.c                  |   1 +
>  7 files changed, 169 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
>
> --
> 2.45.3

