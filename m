Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D23CD3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2h2I-0004Xo-FM; Sun, 20 Oct 2024 21:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h2H-0004XU-LY; Sun, 20 Oct 2024 21:16:41 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h2G-00050C-4o; Sun, 20 Oct 2024 21:16:41 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-50d479aef64so1137267e0c.0; 
 Sun, 20 Oct 2024 18:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729473398; x=1730078198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPUXo26fAxeAF+yc+Y1wdYpMWacKjp8hqrAnA4Br5FU=;
 b=FhuXmkEJaNaL9kcVMgBpigsK+0B6oyYE4Q1zh5l9LmTECSpiBz0CkaYMViTqVQ/7hh
 l4TYZZE4UAwls4AU7N9Iu4S0PKcafnepQCHva0HHV9lJ57JXvnNv79N3EW8Ski14YH1l
 JgHsEuut8QVA6NQuD23vG+KjKJkN9i6lCZm1nraqgvVvDIIeinHJiXBSN5QgYZpU6MGe
 yz8wZIfmxyFyUCCYFtX5ZU3ej8BP8KDTeaInEMtSX+qbyuoFWfvmkq4FrDqkIGvSAlQz
 gWkeQf+tf++94u4o97mnR+y8IkNz9iUviyTTot7+qL6ptRXaoqMpLiacqf5Soqk6mmVV
 xGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729473398; x=1730078198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPUXo26fAxeAF+yc+Y1wdYpMWacKjp8hqrAnA4Br5FU=;
 b=NFr741hIJVLJ6fB22QUeBV67UFxDwMud0pXwx4beaTuWmwmSROg4xCi+wdWtgrU2eR
 nq06/qjQWuZTpPHpVbSCgQHZ2pNFoND/XKlJvouCRW4/B/V14dIkVmZEZm6A6QsJfFGL
 lTbuPiJK93FRkTp7he+LlUQEOdwdd9V3ZOfufSi1Os7JzFv522RceNSYAeRNZdKk7w2J
 0uhGo+2vwV8inY0LYrigCAm4oGm4BDpSQ7zSSxyiTHpS0t/uzGf+9KvhFxnb7GZG6Kmd
 sJQiFO2tmdytAUS1ZsT7N6HZf8zKx5/4qj3qP1BnqT90XLduKxZ0mfHqbGOksrDcqMou
 Qeqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQX3zENhxgRk02AISCWIFT7HDPULK+MwuH8ap6X+ixcLFHDZuNIczqdQl3PfCAyWP06u+x9fXZXqGR@nongnu.org,
 AJvYcCXQqmYy43l7CHpVdbZxwpn8GwyPgeBXC51vls/dSJ244T+VG7fDKSFfgTF00MzDp5hY86ZG30ybdFgCWZw=@nongnu.org
X-Gm-Message-State: AOJu0YznNIRc+TF1df7mThmK92fj4i3+GpUyFKQn7bROQEV9d+XrbrsJ
 paAGLZMU76298UOZbAVBy7cAUE/RCDIfwhq33DPji1mX6wP8BLsoAGXxb70xpSL4pYsasgPkQjz
 8JhgrTf8NBpdyGVsYMyyySrcxkFk=
X-Google-Smtp-Source: AGHT+IHreIxUiXrC3/Y9hBC5qPulpPe7FAloNTdQP5ZS04HhVjzCUm08B0Mzw++8dw1hUqeGrYfpUi4BHoYd7D8JhlI=
X-Received: by 2002:a05:6102:6cd:b0:49d:4812:913f with SMTP id
 ada2fe7eead31-4a5d6ba42e3mr6445852137.23.1729473398363; Sun, 20 Oct 2024
 18:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-2-richard.henderson@linaro.org>
In-Reply-To: <20241016193140.2206352-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:16:12 +1000
Message-ID: <CAKmqyKN2ykc=M4YsjqHKALLfPo05C0MwpmMtPXctAckfU8cmfQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/14] tcg: Reset data_gen_ptr correctly
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Thu, Oct 17, 2024 at 5:35=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This pointer needs to be reset after overflow just like
> code_buf and code_ptr.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 57a269469db ("tcg: Infrastructure for managing constant pools")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/tcg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 5decd83cf4..0babae1b88 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1399,7 +1399,6 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
>          goto retry;
>      }
>      qatomic_set(&s->code_gen_ptr, next);
> -    s->data_gen_ptr =3D NULL;
>      return tb;
>  }
>
> @@ -6172,6 +6171,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b, uint64_t pc_start)
>       */
>      s->code_buf =3D tcg_splitwx_to_rw(tb->tc.ptr);
>      s->code_ptr =3D s->code_buf;
> +    s->data_gen_ptr =3D NULL;
>
>  #ifdef TCG_TARGET_NEED_LDST_LABELS
>      QSIMPLEQ_INIT(&s->ldst_labels);
> --
> 2.43.0
>
>

