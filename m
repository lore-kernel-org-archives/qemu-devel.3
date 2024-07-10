Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E583C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 09:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRTqj-0004VF-1Q; Wed, 10 Jul 2024 05:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sRTqf-0004U4-LZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:42:53 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sRTqe-00049e-2b
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:42:53 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so3502743a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1720604570; x=1721209370; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiHCuDEcC5erlinKmsB6HXr/H8TVG4Eo80SWHNyLSaI=;
 b=Uo46l4Ji36KkMa003BM8Yvu9fH57nqK5RJj1V1tfJUeRiGs0QTGsVJ1vQvPupTpdQP
 vupJ5kEkdYJmAAdsGVzil3W422+g7bLmyc6PsGTPk2dWK32eLmArfc4/8psI5ge+z7V7
 EhdfLSMVknxYIKSdRTY51N/n3IdljTuywRia3SH3pVnSAvfTgaoxE7FoNJKfBMOCRJmN
 bWe6ttWXG+lbA4zLLKRoTMlKpvSpZrFq7rk6Ci40rKSng8Ne64upfS2sNFAyKG2mj9YS
 +a/pdFuFwCMwM5WByqIlMszPKemnxNuI09W5xgRlSKgTaq4gmyQcetgUM4ezhmkYz5h0
 4w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720604570; x=1721209370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiHCuDEcC5erlinKmsB6HXr/H8TVG4Eo80SWHNyLSaI=;
 b=l35fxat9GNH3zJbu88D84lxbLVeTW09C0XizS/2LdQAwI8p4N0T0kA1O3Jo7hADU3/
 YSefQCX/L3XkYCxVExcqAK3xyVGp62xXxRSd5ESsOd3Uq59Dj/dxl0bCzJformgxseZ3
 S3reosCCAC3+eirzx5TtdagcXvlbw7yYUcNAMgver7IaVX9zqq/SJYIJ8Zb8xUoK0vL/
 2U3ofSDaWwEc7SJUZlTwB7Ie9nsgggfRN5Cwj2xoHf5jsFUmYoTkYw2UkGmnfXCExUZj
 nXfKAwN/vvALYN4LfD+qBBeZfOTzzLPIaoLCRrVasleR2UFbdpottiRFRuKUxVEF5tRd
 yC5Q==
X-Gm-Message-State: AOJu0YzTWvkaoqCBpU6jUbzFTg5CA+0lQU6M8TliziI5faMvoz56rVRz
 tUgqdF1t6FNy33jS4m1dp3OxeVJwkXIwCR2qg7Suka3NVwb4TCosiYB5RdIvTAwv5YgxKxRUe9g
 I3ZNlUEbq2ZFyZZHf5l+j8cnB/C7LTGhc0J0UcONQqakSW6fLTQ==
X-Google-Smtp-Source: AGHT+IH9m63fVcGyPjUsFpil3TWcQhXOQRKV7xd0WBnguj+H/nyg53bmkd+w/Ttfms0GxsGN5K5oqZf6S6RS9rTb3ng=
X-Received: by 2002:a05:6a20:1592:b0:1c2:8d33:af69 with SMTP id
 adf61e73a8af0-1c2983ba4damr6166007637.41.1720604570009; Wed, 10 Jul 2024
 02:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240608083415.2769160-1-pbonzini@redhat.com>
 <20240608083415.2769160-14-pbonzini@redhat.com>
In-Reply-To: <20240608083415.2769160-14-pbonzini@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 10 Jul 2024 11:42:38 +0200
Message-ID: <CAJ307EhO9MEk7=w62CGjYn9J3YGOPk0e7gRKMUGk57Wh0y75rg@mail.gmail.com>
Subject: Re: [PULL 13/42] target/i386: use gen_writeback() within gen_POP()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Mark,

This patch introduces regressions in our x86_64 VxWorks kernels
running over qemu. Some page faults are triggered randomly.

Earlier to this patch, the MemOp `ot` passed to `gen_op_st_v` was the
`gen_pop_T0` created a few lines above.
Now, this is `op->ot` which comes from elsewhere.

Adding `op->ot =3D ot` just before calling `gen_writeback` fixes my
regressions. But I'm wondering if there could be some unexpected
fallbacks, `op->ot` possibly being used afterwards.

Thanks,
Cl=C3=A9ment

On Sat, Jun 8, 2024 at 10:36=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> Instead of directly implementing the writeback using gen_op_st_v(), use t=
he
> existing gen_writeback() function.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Message-ID: <20240606095319.229650-3-mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/emit.c.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index ca78504b6e4..6123235c000 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -2580,9 +2580,9 @@ static void gen_POP(DisasContext *s, CPUX86State *e=
nv, X86DecodedInsn *decode)
>
>      if (op->has_ea) {
>          /* NOTE: order is important for MMU exceptions */
> -        gen_op_st_v(s, ot, s->T0, s->A0);
> -        op->unit =3D X86_OP_SKIP;
> +        gen_writeback(s, decode, 0, s->T0);
>      }
> +
>      /* NOTE: writing back registers after update is important for pop %s=
p */
>      gen_pop_update(s, ot);
>  }
> --
> 2.45.1
>
>

