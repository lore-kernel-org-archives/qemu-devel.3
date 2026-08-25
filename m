Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619F6C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyT2-0000jo-95; Tue, 25 Aug 2026 17:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyySz-0000jY-1k
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:13:57 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyySx-0000ae-EC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:13:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso260297b3a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787692433; x=1788297233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jc2y7OVVyMb5aAYVOmJj5Nt78V7OMToArcvk4Xxvn/k=;
 b=d3i86Y/wPvIVUfCg4IXJ8GH5hfZAukua0y5aNNzRhq3FQEoLMXWAZTcO4D2u8kixIs
 iSdkWAHjoyJv7hgTZRpr7DDIwaNdqvU9xhnULy8wzlSeeavn9PCvSWxpra91dTPjue5L
 7cc2rHnYC1rWOvpXp6Bk1R/PY3MPA78oYr97lRCOn3+xrJq/333FQB8k5LMXqEYfSW9+
 ZeXuyRnHlYx3yvuL+FpLUTTGcjK19d+nrWHVzO0johhIMeI8NvBuS4mhFKlBJqljaTEn
 4dj9SIjXHGv/kv8bt2UA9Cysy3DHXt0jM14AMkTLf0HxCbcLPu6jb8xM2uccCpaVxbjh
 Q9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787692433; x=1788297233;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jc2y7OVVyMb5aAYVOmJj5Nt78V7OMToArcvk4Xxvn/k=;
 b=ia9klSiwTSHbwQqX11ZOcJ7z3FQVXvz6u+cRhnrjn1Gq5XgpglR4XrNLaSv4IlZt/y
 zx8invuLKQEq4B+WVvofcom7/9F/xBdO+G4dXg5BeqqW78YfFomex1KXKVDsTvH2WKzZ
 7EoruEzoJMRqhvJdcClYD+9030XTJ8fwinGnnbt84KEWAz8XlC63jdHfA+DgijGo628g
 8+pX9AqNlE/wrueYgosW6BlmEFluY0r/igxi08dfrTaW70UJN2S9iZc2z0G5WtxcoLep
 ovlRn0njlG+z6rAM47swHfXDz3gD88y4XI6mXJ59mCdbNpgcFQqFtybG14dYRH0AKfmv
 s/jQ==
X-Gm-Message-State: AFuF++kYPNZ4tLiKlQG1zwc58hi7hOAxZg7G/KAhamh6wFRJ7uHyUcwz
 RpX3SDpRKCdGbo0eMVoNmiZA7iZLTGNo4rjD9ySjAOxheAGCXb+aQ3U+lOnN61MDoz9M6vo2Rur
 h/D+/+V8=
X-Gm-Gg: AR+sD11NYuEpszIMy2CWfQPHA21n56j/wIP99P7Ipd7shyWu7yti7lRuPwljxvelonD
 UYt7MQ0Na1nw2L5KN05oGpLnTryowomHqAPEeZe5BX46VtCmg6ABtTD7zKDZc9cBJ8AAwglK92R
 6YS8OsEIY+f9ak7Y6msg6shq97FwWIms/KfxR4DY1al7EXd8ANEMOgG0Bb2AEIT1r1EMA03Ecso
 2Kq+uzp3dDyctSoQa2vJPozZJPBfWALA0Njg3sD2GT1FsLFZAT5Q/nVZbQ38qsCCb726JSqzS+R
 pxDGl3bNMOf4K1U8CE+B46UF5VH+YLp7475nYwXp78mhffmzJst6VlIc/GtvjvC3axny17wpMVf
 GeaE8a7yR72+6ZgkW4aT70Vf+kev8tyaRe5XIViiXwmdQzNJFULV1wBuLXpXVyEOqRUjBov46ex
 DGpha9ev6rwi7krwO0K2nitbbm/n7dZSBYiQHTLTS3s0Gjfq7/HTbohmTht9Zy8feYPj6baU0nV
 Zd+73BZaRh2872mk7aZ81qhx7vL
X-Received: by 2002:a05:6a00:12ce:b0:848:48d0:934 with SMTP id
 d2e1a72fcca58-8523bc595a2mr10533458b3a.18.1787692433435; 
 Tue, 25 Aug 2026 14:13:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cdc038dsm241126b3a.38.2026.08.25.14.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:13:52 -0700 (PDT)
Message-ID: <bd82544b-d4e6-41ac-b472-de8ee9364b50@linaro.org>
Date: Tue, 25 Aug 2026 14:13:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/aarch64: Use tgen_brcondi in tcg_out_qemu_ldst_i128
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yujun <yujun@kylinos.cn>
References: <20260724200156.88695-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260724200156.88695-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Ping.

On 7/24/26 13:01, Richard Henderson wrote:
> Allow tgen_brcondi to choose between TBNZ and TST+B.cond for
> implementing a particular mask.
>
> Suggested-by: yujun <yujun@kylinos.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Supercedes: 20260629111602.282742-1-yujun@kylinos.cn
> ("[PATCH] tcg/aarch64: Use TBNZ for 16-byte alignment check on i128 ld/st")
>
> Let tgen_brcondi do the heavy lifting, rather than open-coding it all.
>
> r~
> ---
>   tcg/aarch64/tcg-target.c.inc | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index cc9c2a5158..1f9678438d 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1889,23 +1889,18 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
>       use_pair = h.aa.atom < MO_128 || have_lse2;
>   
>       if (!use_pair) {
> -        tcg_insn_unit *branch = NULL;
> +        TCGLabel *label = NULL;
>           TCGReg ll, lh, sl, sh;
> -
>           /*
> -         * If we have already checked for 16-byte alignment, that's all
> -         * we need. Otherwise we have determined that misaligned atomicity
> -         * may be handled with two 8-byte loads.
> +         * Check for 16-byte alignment, taking into consideration the
> +         * alignment that has already been checked.
>            */
> -        if (h.aa.align < MO_128) {
> -            /*
> -             * TODO: align should be MO_64, so we only need test bit 3,
> -             * which means we could use TBNZ instead of ANDS+B_C.
> -             */
> -            tcg_out_logicali(s, Ilogic_imm_ANDSI, 0, TCG_REG_XZR, addr_reg,
> -                             15);
> -            branch = s->code_ptr;
> -            tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
> +        int a_mask = 16 - (1 << h.aa.align);
> +
> +        if (a_mask > 0) {
> +            label = gen_new_label();
> +            tgen_brcondi(s, TCG_TYPE_I32, TCG_COND_TSTNE,
> +                         addr_reg, a_mask, label);
>               use_pair = true;
>           }
>   
> @@ -1944,7 +1939,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
>           if (use_pair) {
>               /* "b .+8", branching across the one insn of use_pair. */
>               tcg_out_insn(s, branch, B, 2);
> -            reloc_pc19(branch, tcg_splitwx_to_rx(s->code_ptr));
> +            tcg_out_label(s, label);
>           }
>       }
>   

