Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ADDC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 04:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOTjq-0001rS-TJ; Mon, 09 Jun 2025 00:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTje-0001qk-CO; Mon, 09 Jun 2025 00:03:48 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTjb-0007lw-TP; Mon, 09 Jun 2025 00:03:45 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-530f9edd032so810837e0c.0; 
 Sun, 08 Jun 2025 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749441822; x=1750046622; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlrUkjAp/tFxlo5BE0oDwFUKPVrIEu4NSaBeyNriy2s=;
 b=fBfNLfwrPjtZof3mmsog5/xq0SZGrEsEx6ihVG1vYpcasF76Zu36vT7473wPYbk7GW
 dhwzZqGfUQQ+2Ga30hwAoeXNCX6FwdYmvCWniMt2+EUKkIFLxzy6LsGckVk3byRqklFP
 TXjnX2itHOrnXsFySMlpCJdMTwrGngLYbM5DVv0q57T0C0lBKQCwv9IuM9X9YyOtM3gE
 luYcyUX5rPrXGQLy8yvHXk+pV/BB33zYZ3/qS8wkqrXLumrHPOIAQ8RM4lyulGUsbzKt
 2WfVJ9NDFfq1C30+qsiFDu4qJ5O/HNgqMswBNt803z2WK1OHTStFBjju61XyiLy3zDDm
 MI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749441822; x=1750046622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlrUkjAp/tFxlo5BE0oDwFUKPVrIEu4NSaBeyNriy2s=;
 b=TSqSLKcGijv5eXxrtv7SpCgn/5PXkN/CNI1DXFsAUcEfK11RUhQpvjODABullTxS8P
 T+1P+ZTfyO7bplfFhQELKxRpwCI/H+LvBaGCGuBJeMhr1sMhFzTRVhIYXSi+acFKBxJX
 DEqOCbWMNNQ0gu4WgKtWk+envA5C18llI31ZD+htx9DSVn8KMXZ2MrvCQsH0RXhVYJRX
 CLwS2utOuFuDuh3pHlN9urfjk9HE/aDl2DpYh1wXST1i7jYJGsBRgbllVpsHx4BzHvh7
 Rg8TAnbM+fxdq4ivVjADVBml5SIkiuq9calhrBd2KRiAaou9yDLHbS7HKQdVy+w4RUFp
 Zg/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCJAo0cEZfecwY0WoRcGV/++3E+7fuSTTz6QhukkG6YZtCYlFewDHWad2U/saoaQeebNw/3/4KuiIR@nongnu.org
X-Gm-Message-State: AOJu0Yywp4sK50GuWMzQ8kX1hlilVkhE5lMFhcQCx5JrjcAtBXb/3dTu
 hzvOWAOBndqftTcls9BIhqXmmIj6U6NIKBYlpXzq0VvfP2sM3jzEv9oiVpsyaiKXmvmJ8xaRoPe
 4bUEVT1buKKGYc5lzqeeqDUlW9hDWPLY=
X-Gm-Gg: ASbGncsFmW1EO/RDYy1IB1qsgMzrZ35t/osDAuUKOgdO/TLoRre/0kiDiGbdOxF2hTH
 2UJ34QVTwtzQIJ8niTuAQa4fHEkiDrcUxA7k3VHvwwcRmXTSQD5ihM+wGwW58eRp0QI5429eNSs
 7kUvOQ508lbFm+QqpbSNQvawJpKzKSgbqpSBdgwC6bMCKKB7BKFONGCg9s2nTgC/Y=
X-Google-Smtp-Source: AGHT+IEUrH1vV2ycR8vropwv7t3pmSz+RNBkiXJbEoMpPqAzc10Jf95FrHQ+co6Ua2rMreOa3KIHRSdruNfxAmymGqE=
X-Received: by 2002:a05:6122:3d12:b0:527:b7a3:dda8 with SMTP id
 71dfb90a1353d-530e5278a6emr9249963e0c.7.1749441821991; Sun, 08 Jun 2025
 21:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250605094456.1385105-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250605094456.1385105-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 14:03:15 +1000
X-Gm-Features: AX0GCFvK3bQunVphgRq9qu8MvQybAeKNrtH6eWNe-oVT9RQoHbTNfMWWt6Swruk
Message-ID: <CAKmqyKN8UGgHhQNSKvBSGjeXNz2t5ho1avzE=MZe_BCGrHOp_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] riscv: qemu_chr_fe_write_all() in
 CONSOLE_WRITE_BYTE
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Jun 5, 2025 at 7:45=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this version I removed the reference of SBI_EXT_DBCN_CONSOLE_WRITE in
> the commit message. That API is *non-blocking*, and citing it to justify
> a change in a blocking API sounds weird. It's also uneeded since we have
> a good case without it regardless.
>
> No other changes made.
>
> Changes from v1:
> - removed the "SBI_EXT_DBCN_CONSOLE_WRITE" bit from the commit msg
> - v1 link: https://lore.kernel.org/qemu-riscv/20250605090012.1268809-1-db=
arboza@ventanamicro.com/
>
> Daniel Henrique Barboza (1):
>   target/riscv: use qemu_chr_fe_write_all() in DBCN_CONSOLE_WRITE_BYTE

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/kvm/kvm-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.49.0
>
>

