Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0FCC36010
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 02:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tznxd-0002NM-HF; Tue, 01 Apr 2025 22:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tznxZ-0002MY-Ul
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 22:36:10 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tznxU-0000vL-SR
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 22:36:07 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so9363751a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 19:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743561361; x=1744166161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ivy+YC4PAzTAq3kl4QDwYbnNbh+afhw6SNYjk7KL4UU=;
 b=CeoI/1VmHFdxY1vFpcAH+3ZUCMZ6CFY+7j1jqA+jJkYlIUWDq8xxoauSFZvc4sQN+g
 6WfP8AS9hKgerQqLkLf97BOEobJm0iF3Qq4elOo7o06bH+/hQFpfTT0PjVwrcDxIRlA5
 2uK1odTdmDZX/EBrRFLwNGnG5/4wnpwAXHKD2RZwmx0l9BfU5vnQzvUlxaGKgGUttjWC
 +CK6MOlWv6HNCuOcgd8CWlEbMqB3bQ5M4hxNNOK2K5NJv6O6WDjezdiyLeMfpa0IwM9M
 kRmFIBwnXvYfGWWuaOUD1axoEyPhyifUg86co9Y7rowgmoxmksx3acPK+UjvmrV7Wx8u
 1eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743561361; x=1744166161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ivy+YC4PAzTAq3kl4QDwYbnNbh+afhw6SNYjk7KL4UU=;
 b=Ej/NzpU2vRcrH8/riVUSCpaUzGN5navb3K7mn9H5uovavM6/Ps3lrEpo6FyfyRT5W3
 8kqJwZtCojM51TpsJTPLkZ5EozsIKVRxz3cGBPh91HA+B3XkILKo2rRskG4hWx8Qrmw2
 kkBgHXTr5Goo4Q1H4zwCmj4kD4I+tpflQlee/Og0ke+M0K6pXAvfnq/AvIH6wVY00EBs
 a8n/+62BcJOcKxs/Rbe9A6XusTjpguTE5DD5jeslCzF1/rRElpXFXgONTvywydJYU+Li
 pNfyD/dCtrzF1PGuRTJkZuv/Q0AfRuE/arNluxdXCQ7dPN+DqFrAoRrghmN9LPeNrnRJ
 c6Wg==
X-Gm-Message-State: AOJu0YyKEg17yf8BLNTVZkMwfzzR/xBcXRW7mOpbLy4GjGyNe/qlDTIi
 +OC6zaKteE+k+O95dyEoAXSwTUuQKYHWf78nKy/JH4Jbnu+RZpeHxuk9BQ3RFUZesOmS2Tw0B2d
 nImcrkPG9XHEoVFhthRD/hK/EqREmczVA8FpEWhocLpTDrMcV
X-Gm-Gg: ASbGncsjfI5XO4iOMDQttxzvNhEzo6/G6gtWVZuYnf0QGBMAUJisqwly3I5YacEP/ne
 SVrwvk8SqUlT1ckpL05NX8x5Y3GnQ9GKwvb+FUbUnlSYhCYLdrAW376PjvcI9dzJj+UAgfZ6D1d
 8Y1vSeSU9SFzApfyBev6U85UnEiTq4kv/ADanTGBs=
X-Google-Smtp-Source: AGHT+IGnbfgZSjgX8wRzm9k4u7+NJJX8uLjHm8IRSQbG9iTfeIjbaOysqqJI20o28hULXhKntmv/Tah9v8JAPwPIy6s=
X-Received: by 2002:a05:6402:320c:b0:5ee:497:67d7 with SMTP id
 4fb4d7f45d1cf-5ee049769bcmr12288513a12.34.1743561361244; Tue, 01 Apr 2025
 19:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192153.28549-1-jim.shu@sifive.com>
In-Reply-To: <20250319192153.28549-1-jim.shu@sifive.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 2 Apr 2025 10:35:50 +0800
X-Gm-Features: AQ5f1JoZcq-5vva2KltPETGXFgTaDGCynQaT3xQNXCHuIJNfrBOh1GkbzcMOsPU
Message-ID: <CALw707pgVMkLtUv=oJoFPDxW1=qDE-2U35v5Wto7BfC+YaRbtQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Several sstc extension fixes
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

Gentle ping on this patch.

Thanks,
Jim Shu


On Thu, Mar 20, 2025 at 3:22=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> This patch series contains several sstc fixes:
>
> (1) Writing to ACLINT mtime should also update the period of S/VS-mode
>     timer, just like M-mode timer.
> (2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
> (3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
>     which should update the timer and IRQ pending bits.
>
> Jim Shu (4):
>   target/riscv: Add the checking into stimecmp write function.
>   hw/intc: riscv_aclint: Fix mtime write for sstc extension
>   target/riscv: Fix VSTIP bit in sstc extension.
>   target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed
>
>  hw/intc/riscv_aclint.c     |  5 +++
>  target/riscv/csr.c         | 53 ++++++++++++++++++++++++++++-
>  target/riscv/time_helper.c | 70 ++++++++++++++++++++++++++++++++++++--
>  target/riscv/time_helper.h |  1 +
>  4 files changed, 126 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>

