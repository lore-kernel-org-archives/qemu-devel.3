Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FAAC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9XFi-0006O7-Lz; Mon, 28 Apr 2025 18:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9XFV-0006NN-Eb; Mon, 28 Apr 2025 18:46:56 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9XFJ-0002sD-Nw; Mon, 28 Apr 2025 18:46:52 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-525da75d902so2085364e0c.3; 
 Mon, 28 Apr 2025 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745880394; x=1746485194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIVm3iAq+Dg6srXQN3632I3HvEPBq1ySo56wYh4HuGk=;
 b=hqWrdhXwqAbBFlpHCsciZXpZOHffDgVioqYv5Zq0FIMvP7hDFfkHSsNLdkWrhMpbcE
 rQHBNLuIPkNNSL//xLNrm7DZkNleiT1DLKr8yYOmGcf2yCv0ajbVi1sTGZaf1AUD9zHI
 I0nJb7Bc1QyeQ+ADnO1GwlzFeUDPFToVrLNs/s9i47k2Fn3Ywla0V7RHpKChovUkHu7s
 sYgkGX3zHn+SimgDD+aUcHIQSNSGerCzuwAN74j2hBCnW1mgwrm2lqzBtpn6CXcy4IZd
 j7LF2MCx8PCFcfOCtnZ0zAMAaQ3qTCWlRTzwPbSOVC1t91YmsHiE+YxUO4hx8TbrjSZi
 BZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745880394; x=1746485194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIVm3iAq+Dg6srXQN3632I3HvEPBq1ySo56wYh4HuGk=;
 b=weSgOcaDMAvIouWJoPN6pOCZSepKAN5TitgyxHWPpcr2J1HNa3CZv3de4bU83IKaCK
 73kUrHx5eX/39o632D4PsiyBxL75d79bpYsVrn1QwcpgcFkKZZzMX2OntA7YBLNj9pHN
 i5dX7LCif2vmlw/Qbyw4L4L97bZUO7rtWkgxRl4l63fEr2AkXtczbRh2U90qf9uW4b/3
 PZAtP2HBpQPhOF8WHkL+hdhb7O+70ozsXYEzwbrjGRJpzwfMdMbNBjBP2qUVH+4QPBKE
 v9NeHRLUAjX2Cx5P4zaZqbT4I6Bm2CCA0dbK5Kys6mGj3+lz9Zug2XsWfqAogQGzoMpo
 rqXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+l+HVqkXfYYMHk1KNJ5nkyLk+dA1vxdSbIypMN6W48Z/VxRkAJoL9Go12lm6g3C6nP6r0FZzFGeaJ@nongnu.org
X-Gm-Message-State: AOJu0Yw2jSzDI9dY279MnRp0Y0oHHccokR5SgYlF5OSBcFqiI5KVvJ04
 Jk8EfgguNQygls2U4NuRXdd9jsz8zMeBeEkAldI1GsT9INwhup8SvRXK8sKPmwvjRultHhK1Fsk
 y6rwW0aIae9WORQweKMN131tcXis=
X-Gm-Gg: ASbGncurmSOXxQrR/5s4ycrysvYAqDjQso/Yssd1Mzi0u/Xs0X1tasXiD/5UebAn+Y6
 TdsKx0FcudawXRUsVSCPV2kzhDAUOkvtD42UGnsq0Z7trFxE+CgV6SOB+YKNgsIuDJPnw2QspNt
 gr3SCDpy9erqPzDwELV736t/7oUM/sJL2N21I/bgK6Cp43BsPGRJli
X-Google-Smtp-Source: AGHT+IHXNSMxeA6TEer7r7srJdR/TAfkHYOpVRCIi1UTU5wS8oQvda7taOPM0isApkfBwM72EZ58J+67CYdVmw+8qBI=
X-Received: by 2002:a05:6122:2207:b0:51f:fc9d:875d with SMTP id
 71dfb90a1353d-52ac0aeb2c9mr357429e0c.8.1745880393756; Mon, 28 Apr 2025
 15:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:46:07 +1000
X-Gm-Features: ATxdqUES0us4iyOs_fRq7XxWfeTjvH4MGt0Y6hyvGbz2LxzV_xfErajDjWyEa8U
Message-ID: <CAKmqyKM5KDw9U8gY2VkNq6vSQapN+1g=i-A_=gaqY-XVLVpS4g@mail.gmail.com>
Subject: Re: [PATCH 0/7] target/riscv: Fix write_misa vs aligned next_pc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Sat, Apr 26, 2025 at 1:25=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> As discussed, the use of GETPC() within write_misa is wrong.
> I've done just enough plumbing to get the helper return address
> piped down to write_misa, so that we can make use of unwind data.

Thanks Richard!

>
> AFAIK, nothing in check-tcg or check-functional would test this.
> It shouldn't be too hard to write a test akin to issue1060.S,
> but I'm going to leave that to someone else.
>
>
> r~
>
>
> Richard Henderson (7):
>   target/riscv: Pass ra to riscv_csr_write_fn
>   target/riscv: Pass ra to riscv_csrrw_do64
>   target/riscv: Pass ra to riscv_csrrw_do128
>   target/riscv: Pass ra to riscv_csrrw
>   target/riscv: Pass ra to riscv_csrrw_i128
>   target/riscv: Move insn_len to internals.h
>   target/riscv: Fix write_misa vs aligned next_pc

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h       |  15 ++-
>  target/riscv/internals.h |   5 +
>  hw/riscv/riscv_hart.c    |   2 +-
>  target/riscv/csr.c       | 278 +++++++++++++++++++++------------------
>  target/riscv/op_helper.c |  13 +-
>  target/riscv/translate.c |   5 -
>  6 files changed, 169 insertions(+), 149 deletions(-)
>
> --
> 2.43.0
>
>

