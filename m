Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C19CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 09:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOupN-0000cb-N5; Fri, 28 Nov 2025 04:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOupL-0000aT-LO
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:31:43 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOupJ-0006uW-S5
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:31:43 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-640f2c9cc72so1484565d50.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764322300; x=1764927100; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VS+fFN04bnuMi6NAtG5NzMdq7p6a0VRK05Ap413lUYk=;
 b=N5N1pcT7I9jSO7fke36MBC5RlpLa04yrpFipa8s5Ya2kV4n1QI5qiTwc3bPd4SwSXq
 39I/xlBKFP5hZZXCLPjVnznMbNgyLzp5e3ze3c7tWHWVlBd0/72k3DkHQxnd3gqNx8jy
 ESEXGl4anYs2Jqhaaoc3A/4Tb00kJYnZQOp662ujOMbqCnnk6r7fzBMUtMjSzVTCma7X
 ccsK03qwI1ff8HI1eI7wFc95Wm/1nlw7wgIlKZTFZvRmx5TXTVkHkxz/b7n77SXTkyRh
 SBdtQL7RZjpx7KdCnSkQbt8HNEaCItpE5afUkGKKxx0KxxNVtWf6v21vm48x4zz5IN9E
 sD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764322300; x=1764927100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VS+fFN04bnuMi6NAtG5NzMdq7p6a0VRK05Ap413lUYk=;
 b=mU0PA8nExCJrFVa8IQQBuF29ObrnHcW5giqum3H+8lDU9GNAbE6k3op7jj50Pj2NBk
 YQzJhFlJfYQ5Tn+T5byKwv6k6NVtyl3wijuxecqDdUzGEmwrBtuVWlu9OlCcaeJHlIM/
 zTSkrJcffgJLlCLR62sE6Zw/pfPxWWSBtz+STLxOC6wOtmh2J4qSikt7P7oy1e8bM2WD
 WX0D+oINXlrKoeeYtu5v7SbxAvtqb+Ns/T/8cJ8e5julITVNOM0OACm00p6+J98116DR
 +b0WVSfq76Wxn3SNpGu7yfqLzo1b3h1vYl0iqtj3/q/KtnRsClVKt0HeUGNwLBnF26Gg
 q/9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCqNx5t1NsH47ZjePYgqlQRKG5Qlm7qMvoNvLgznbJKk+x37WNzESWb++EB6vJ2r5yTLi4v445kz1K@nongnu.org
X-Gm-Message-State: AOJu0YyZqiF0FIN5HXPqU0weFjWXm4W/69e5TKNo/GkauDwiJPWKrH2d
 lRtToAZtMXe6RzJ4cjWzVy08mNRe7vF/ugZzAlKBqjoNMMkyxdCBqQ7F3OaCWqOQo03fvd6nkIj
 5o9XwoCafs039X5nSq69sKqBzNfRprkmqUiOHTpeAuw==
X-Gm-Gg: ASbGncsfEqILetIk7pNwGLTYVq/I0tXlJ9ds3NAvEYUQxhC5JlWC+wnT+ZplOMeDyGR
 Njit8YWM8Y4fe4Yw84CkVW7+9S3Yix+KBKQov7TmjqQPbtm0eH7aMI4gLRrF0/Scps7KxGXt/8k
 izCeW6s4pUkjGeH6A/6hOmE/DcRWSOnwcQf7oADzI6n7JWfm1Oq9efOKqthjlGzdMZa1wMA6/gZ
 sQNMwJx3M6DStSjxnRImHvXNfZY014FRWOOW0AU6TXuMroZVJOzxXYV3UebYT8HbbzYcTGY
X-Google-Smtp-Source: AGHT+IHPv0+2uHHl9KK/iJgzTT3FCYtPlB2owDK800JQpL0UnCImrQETYZR5vz4E94Xh/o4yIic9ZXC+mQB/ACUDJck=
X-Received: by 2002:a05:690c:7484:b0:787:ca0f:2687 with SMTP id
 00721157ae682-78ab6efdda1mr218975937b3.34.1764322300309; Fri, 28 Nov 2025
 01:31:40 -0800 (PST)
MIME-Version: 1.0
References: <d2265ebb-84bc-41b7-a2d7-05dc9a5a2055@accesssoftek.com>
In-Reply-To: <d2265ebb-84bc-41b7-a2d7-05dc9a5a2055@accesssoftek.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Nov 2025 09:31:28 +0000
X-Gm-Features: AWmQ_bmndgwbsC0udVqpm2SRvQ52lFI4RE99hOhD-SXdMPDnkbqbc0PgeReRL8Q
Message-ID: <CAFEAcA8j6sAmm-uT9LdDt1VP2fWmui9ETXn90bDWbCh4aEMG4A@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix assert on BRA.
To: Harald van Dijk <hdijk@accesssoftek.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 28 Nov 2025 at 04:38, Harald van Dijk <hdijk@accesssoftek.com> wrote:
>
> trans_BRA does
>
>     gen_a64_set_pc(s, dst);
>     set_btype_for_br(s, a->rn);
>
> gen_a64_set_pc does
>
>     s->pc_save = -1;
>
> set_btype_for_br (if aa64_bti is enabled and the register is not x16 or
> x17) does
>
>     gen_pc_plus_diff(s, pc, 0);
>
> gen_pc_plus_diff does
>
>     assert(s->pc_save != -1);
>
> Hence, this assert is getting hit. We need to call set_btype_for_br
> before gen_a64_set_pc, and there is nothing in set_btype_for_br that
> depends on gen_a64_set_pc having already been called, so this commit
> simply swaps the calls.
>
> Signed-off-by: Harald van Dijk <hdijk@accesssoftek.com>
> ---
>  target/arm/tcg/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 08b21d7dbf..cde22a5cca 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1916,8 +1916,8 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
>          return false;
>      }
>      dst = auth_branch_target(s, cpu_reg(s,a->rn), cpu_reg_sp(s, a->rm), !a->m);
> -    gen_a64_set_pc(s, dst);
>      set_btype_for_br(s, a->rn);
> +    gen_a64_set_pc(s, dst);
>      s->base.is_jmp = DISAS_JUMP;
>      return true;
>  }

The commit message on commit 64678fc45d8f6 says
    The set_btype_for_br call must be moved after the gen_a64_set_pc
    call to ensure the current pc can still be computed.

but I think that is incorrect and it meant to say "moved before",
because the actual code changes it makes to trans_BR() and
trans_BRAZ() are

@@ -1521,8 +1528,8 @@ static void set_btype_for_blr(DisasContext *s)

 static bool trans_BR(DisasContext *s, arg_r *a)
 {
-    gen_a64_set_pc(s, cpu_reg(s, a->rn));
     set_btype_for_br(s, a->rn);
+    gen_a64_set_pc(s, cpu_reg(s, a->rn));
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -1581,8 +1588,8 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
     }

     dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
-    gen_a64_set_pc(s, dst);
     set_btype_for_br(s, a->rn);
+    gen_a64_set_pc(s, dst);
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }

which move the set_btype_for_br() call to before gen_a64_set_pc().

So I think that we just forgot to also include trans_BRA() in
that change, and your patch here fixes that.

Richard,  does that sound right?

If so, this should be:
Cc: qemu-stable@nongnu.org
Fixes: 64678fc45d8f6 ("target/arm: Fix BTI versus CF_PCREL")

and you can have
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

