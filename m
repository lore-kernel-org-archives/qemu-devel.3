Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C670CA5FE3
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 08:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCum8-000116-Ar; Sat, 03 Oct 2026 04:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1xCum6-0000zi-Qj
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:07:18 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1xCum5-0002g5-5Y
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:07:18 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66c70f69d3fso142266d50.1
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 01:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791014835; cv=none;
 d=google.com; s=arc-20260327;
 b=qf2ntRrc5TqgXF3zZVYvGgEbJOCpHb2sB699CYMbhwcW86XkgPYlzmO+I/LnzRVtW1
 T6uFk1EkRzbdd93M0ZL7xLz+9WtD58/6lYVV4pPXPhONH3NaRViEEX3hkebrirVcl9ki
 mk8l1a8d+vA/qIeH2pNzcK5vbbYZzAS42H7YjFe8blyOdp+ljoWhdcW2I6Ke4D9N6bxL
 NwVWFh0KWQr4AFoagLPfrjgT6wl140ghmLc9kHF9r+8BacaULBsWAhm5S/l95zn0Mlfw
 OAdpcEmNnbkz3TjoeJj8/okIycKCFonnE+lU7oTHxj7+w1Ia2Okh4Qr7aI0y6ip4gjVi
 BLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fc3SMgBbEm0kBjJyVGQOFt9KGLga3SNasNv7IG5tTJA=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=jAywWcuMb4GGnOKse7wZEtVgh260D74l3YnLacvxq9aV7tqGGKpb7vke8NS01KI5p1
 6gg3NM1h6ze8SC8muqjkiToSE2gu5+rSc/TxuY4h5BFXNp2rDLew7xqMALkt5DnLeiZJ
 t/lWCGXLJnCT1vbwdzGoQqgI9AanilDd+M7rOz9dTMMc4mdN5mzbsG7uxA2KzdVkNg1Q
 qOmdRCmW/BdRxTa03Rddy/IFmuhxHp0Ls4HoS8CGhFYTI3tiBEjlVM8E0pi/DLl02lEq
 aGz99auKOoNGN8plo7ozYTQeikBwF3T4fR2JqceM+7Qo10nle5B3bEfsAJvbZtFOgPQG
 1Lqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791014835; x=1791619635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fc3SMgBbEm0kBjJyVGQOFt9KGLga3SNasNv7IG5tTJA=;
 b=ZsFUjBICaT3XNs2ZlHwVNpv0lxKSkdsdzKsmolCeiWel4O6vJvyG4tBaubTVthShAo
 PXnFltV/lJsuwjQhrqGKX78PR2f1sO09YVcSE1FVR+1mCDJNZtZjsb09IuiIaLnd4WzP
 LdIxHLilveOlbc1gBfUKu4rbeNCqCZi6HX/HuSDbtlaYAqVQ5TyEmH1PpPY/kOwBd+SG
 G7hEZiMbjv/vo1zzboOxEAF/zyqMBRxtmpCWC/3LjlaItLc40D+A8vds+E2IZRW3YqIh
 5yxMsDv5ub+nep9BXUjV4V+uoJ+N6gAtFezrGl/Avj1dsejYpOkPypj1BwnFq4KTt03S
 KtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791014835; x=1791619635;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fc3SMgBbEm0kBjJyVGQOFt9KGLga3SNasNv7IG5tTJA=;
 b=GcZA1kerB0SBu27qlr52mi7P42cmu9o4nXQesJV77wlouw8Eg/iM3eKp1OLTyKN55E
 3h1DHRoBszQnKUzc+asIwloli6R8sFl8M3vpH/VUOTlFVA0YD6fId9vmdVUUcGq6bplc
 d6++GnGirbEayF8yFZmsPRxlelXqUo6LBt+yVPs66GSkEb6oeCwJs0Op8cecoFcGneTZ
 2di+NHNye+iBWKni3Q5KRtvUUPXXEtM5b0IYzZZlFXa0EgQ/peubvjZ6sdBMQZv1mKxM
 mGHRnx2BCgdwlKPEYu3TiLKmux4uDHZ0HhXL7Fppr+ny8jSKBAJqHd0lrYdorZMr6LaQ
 G3YQ==
X-Gm-Message-State: AFq9FYJ900gytWInd3rSsAsYKPymCUn85Y9feH37j9LfDmcOrQQjaj9/
 ivPAS8jPUAXux8aRItrqTmJnQH9W0HOrg7jbT7KCX609OWvtiXHdiRmb98o35122lgcr0w0m+c7
 IVPzEzSzGxocKtmmX7FZulMkk/a9NW7BCYgF6ljo=
X-Gm-Gg: AYBFou3E3JBo41XWUbc7RHHkF293Uk77XywbIf2sG5vQeebBtxJJr8+Cw+co2M+9vLt
 WdLo4hGQHDA6Py2Nw4h1JmD1szW3TIJj7cop/Bbj38BEPLq5x/PYIS3NNcZNqcTmOHgsnqACxM0
 QUNSMyty3qcQdAFvplClHhY/5S7cLYDB68GXOvQe7nipzBFO5wBOF4GskTd16qcKttBsi0xETvp
 gw+ZckXy+s1QqfSd+DHCbg5QmKNHHnz62Ak21MBNh0k0/Q6axCFLQGTzKZDYse732fSUqqn59Co
 q4RgiUUUxy92StZrycyXc3cGtilZSgVRZHgnpM8aG9XauDBqPwnaQN+7hYTB6C1cmSDJjma5qHC
 CTpseoPDTKoOY+js0qdEvViTB5LyGi1gxQ9uxLsr0
X-Received: by 2002:a53:b4d2:0:b0:677:a8c5:6418 with SMTP id
 956f58d0204a3-677bd428931mr388696d50.102.1791014835551; Sat, 03 Oct 2026
 01:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260901063127.60866-1-scherer.simon89@gmail.com>
In-Reply-To: <20260901063127.60866-1-scherer.simon89@gmail.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Sat, 3 Oct 2026 10:07:04 +0200
X-Gm-Features: AclHuK_ul4u47JHIkuq3zqoH2L1d3WkhEzz2TrVsiwLA6QvTWRxPdZ8LqS1-DSk
Message-ID: <CAEQwQtLFgbqDsvDbP08jq2pDrsphby5AccDkSExgjQfrF2WPYQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Do not switch to MMX mode for
 CVTPI2PS/CVTPI2PD with memory operand
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yx1-xb12b.google.com
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

Ping. Just checking if this patch might have been missed.

On Tue, Sep 1, 2026 at 8:31=E2=80=AFAM Simon Scherer <scherer.simon89@gmail=
.com> wrote:
>
> Per the Intel SDM, the CVTPI2PS and CVTPI2PD instructions
> cause a transition from x87 FPU to MMX technology operation (the x87
> top-of-stack pointer is set to 0 and the tag word is set to all
> valid). CVTPI2PD's own description scopes this to the "xmm, mm"
> operand form only, explicitly excluding "xmm, m64". But CVTPI2PS's
> description states the transition unconditionally, without the same
> operand-form distinction.
>
> Testing on real hardware shows CVTPI2PS actually behaves identically
> to CVTPI2PD despite the SDM wording: neither instruction performs the
> state transition when the source is a memory operand, only when it is
> an actual MMX register. This matches a similar Valgrind bug report
> and fix, see https://bugs.kde.org/show_bug.cgi?id=3D357059.
>
> gen_CVTPI2Px() currently calls gen_helper_enter_mmx() unconditionally,
> regardless of the source operand's form. Only call it when the source
> operand does not have an effective address, i.e. is a real MMX
> register.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4394
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
>  target/i386/tcg/emit.c.inc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index c83ab80940..72c08beb2a 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -1919,7 +1919,15 @@ static void gen_CRC32(DisasContext *s, X86DecodedI=
nsn *decode)
>
>  static void gen_CVTPI2Px(DisasContext *s, X86DecodedInsn *decode)
>  {
> -    gen_helper_enter_mmx(tcg_env);
> +    /*
> +     * The x87->MMX transition only happens when the source is an MMX
> +     * register, not for the memory-operand form. Confirmed on real
> +     * hardware, contradicting the SDM's CVTPI2PS text. See
> +     * https://bugs.kde.org/show_bug.cgi?id=3D357059.
> +     */
> +    if (!decode->op[2].has_ea) {
> +        gen_helper_enter_mmx(tcg_env);
> +    }
>      if (s->prefix & PREFIX_DATA) {
>          gen_helper_cvtpi2pd(tcg_env, OP_PTR0, OP_PTR2);
>      } else {
> --
> 2.53.0
>

