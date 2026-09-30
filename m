Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62876CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC0J4-00082P-Ly; Wed, 30 Sep 2026 15:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xC0J0-00082C-7T
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 15:49:30 -0400
Received: from mail-dy2-x18.google.com ([2607:f8b0:4864:36::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xC0Iy-0006YZ-Me
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 15:49:29 -0400
Received: by mail-dy2-x18.google.com with SMTP id
 5a478bee46e88-344447f9c3dso3132216eec.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790797766; cv=none;
 d=google.com; s=arc-20260327;
 b=SPD3CQEsAjtflYBzNL9VAPxosyfba8m5ZbM/84JaI/52BcDNJrDbyzZbCf3CJAURE0
 tiKjnQthv9QIzNxYj65/xbAKZCSnhNO8RSJu9ZBZoKP7Ai7ifh+DiG1YgLeFrFbOqP2C
 h9hQfy3dTZ4iVstBca/BfWo5lPrQUm+19eUYGSwYgCbBLmIPmex+mUHH7j/zsjteOtye
 mNqBVZhpNAGvRL2siKI7bT/clra7JEgwm3bBxaqnCNaS2qFlOjbPwhmM55p5TgC1XABT
 L5xa0hPK+VMJC/N1mofOkjEEkhamgPcXCsgrQ/2Dtlf+uLTdwLSsi3VlElSHiGZvWkXW
 tV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y5SpG3LmfETySUERijbwxzymYeKYAO1bx2xMZHPhhwA=;
 fh=7XXLGJOzwHpZZdzEaikw/wvX7SYCRQc2UzkYYGSlZpM=;
 b=bQisDB9PJ3KMwtYoYlZTh49vKdHOZX8SBwgTAcarwZwbSdjBdInT4rM9lO585jEqSD
 DbJeu5lSseYa9Pco+MAJHYn4YGva1OaKM8wJkwVTjquKrzn0N7NKB3ev19wWriDXNbvI
 856fgnrFus4PaEUHl1tPQ+FBsuI18NfWZMDtFJI65jcJaS4klTUM7rloQHyYQG+MKxt2
 LnWsAhU1kSeWB1deBPzwh/xep1jI2wwQ3FJ4FLHrmdefuNSpS5ylrQbrOEoi4tx8mGTX
 3S8lmJMoVoRAj6THxUjFJjb/mFyLkBDiE4T9o06SWZgsNOMUNR8VCgrn6wCMJvzglX66
 itvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790797766; x=1791402566; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y5SpG3LmfETySUERijbwxzymYeKYAO1bx2xMZHPhhwA=;
 b=fI0vyQfkDee2NGVsq0MGBkpQTjC9xbwV8Wx/9ZBbv0uojyjiOADHw5GYT9tyojndFU
 unsQv5RXRgU41nyWSGZOwE8zZEy5tKbSpzWDII90fcG8QlWzyZnaODPLKR3qE4bAMgVS
 kJ2JH5gmZyrN8enur4GJeRsQ0mcg1nO9RwckIUbcEBK+xGE1tYU6JGC340kcUcmIOdkP
 wlEWwNxBDL62qT0WrHdCyFliec6n9l/0NQdLgOlQlMOlDcrke3idA02vMkr4QfIvkJwK
 WKY0fgzAokj4ifgtpdbRV2aKF6oFKYHvMkRPt4nkRaZBV7NS0B55LiQn+8/PQfLLWdsF
 0W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790797766; x=1791402566;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y5SpG3LmfETySUERijbwxzymYeKYAO1bx2xMZHPhhwA=;
 b=w+cnrNX6yqJOwnEuTw1k6/wbXxUW860HbsJSNS2muHyGDsSrudrTt3e3EG62+vBgvg
 oj8NKVe776fZElfdxLpGnBg+UxBDhaQqIBsm2DAjya5QRVoA3g8uRXQsyWeweSrm6c/K
 zwiEpl+RXQC8z91SMD5dWhFvZFH74w5BtzWTQm7hYx3boUCKlHAupMhyWl4B7W8ssE+7
 CdG4GtC+tdgVlWJUy5StqyYrBSG+JFitj36ZnCqRm7Arzat2AOhsxJeATmXKqQTpm6K8
 mAQ5AcJKDdLHY4eU4Qg4p3qH1Mm93ghO9CObc1XiX/Q1FyvIrG8zXOQ6MEGkCsMDxudZ
 eObQ==
X-Gm-Message-State: AFq9FYIEQO12ufLBDrsDqNEGbaJgP8ogMKunh3a8o2/c3rIYFtLuenlO
 owSdhUekVpLpYetz5J5ERwq/0yrCLbsZhhVItC48KUi8Rcu6U7JsyVwb/kipeLc9+OwTY6hesAg
 +V+SsMJOPiLK7VVJlTVn1KEy7y2R3Hng=
X-Gm-Gg: AYBFou1lWnGtuRK8vumoCTpGY25laX86vHg7dnrQNHTKuMJnhbysXoIruGKuYAsK0sg
 HsUpo197qd61JRwTkYKOaZJwMbf2pzq8JbPBMVS+WGGre2k4qZW40zvPLNdf9t8DbDxESdXIgCR
 mlSZ3WVezN5JG2O8vQuPIFhsi8c/Dnjp0are8sJqaFTprPEEs07b9LFWm7E9RKd5WvGSx4XKWGZ
 ExIocIfvk26qg6vpCiAlpdxHVzyRDPi/eiyCvV4k7yLlVa8moNGB3WyRsS3mdrEIu+QfDZ+gBi+
 CJD2IR2MWcp++3tXQrLmC0aNHKyxxlAKxRIGca7kExMRup7s2gWgYqo35TEFV0GmBfYjQpLHzvl
 HOI1vrGLq7/JIFxLc/ahODQ==
X-Received: by 2002:a05:7300:b282:b0:34d:756:9b2a with SMTP id
 5a478bee46e88-34d0765e6b7mr2112902eec.23.1790797766151; Wed, 30 Sep 2026
 12:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260930065406.738374-1-pbonzini@redhat.com>
 <20260930065406.738374-4-pbonzini@redhat.com>
In-Reply-To: <20260930065406.738374-4-pbonzini@redhat.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Thu, 1 Oct 2026 05:49:12 +1000
X-Gm-Features: AclHuK8wP90ypMvmQsrpKZaZCrNgFq_6NSqXAHtKYHo9G0wXgqxddwFUKKcA1DY
Message-ID: <CAGscdFt9uL1CJ6B1-oXw6hri5g8206pS03CW5whQbA2vaBm1XQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/i386/tcg: clarify return value of decode_insn
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:36::18;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy2-x18.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

> It is clearer if decode_insn() returns whether a generator exists;
> if it does not, the entry is empty and all other checks such as
> validate_sse_prefix() or has_cpuid_feature() are moot.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/decode-new.c.inc | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 5212a24e470..4e1cf0a8297 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -2478,7 +2478,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
>          e->decode(s, env, e, &decode->b);
>      }
>
> -    return validate_sse_prefix(s, e);
> +    return !!decode.e.gen;
>  }
>
Hi Paolo,

This patch currently fails to compile with the error below:
In file included from ../target/i386/tcg/translate.c:3334:
../target/i386/tcg/decode-new.c.inc:2481:20: error: member reference
type 'X86DecodedInsn *' (aka 'struct X86DecodedInsn *') is a pointer;
did you mean to use '->'?
 2481 |     return !!decode.e.gen;
      |              ~~~~~~^
      |                    ->

Should be:
    return !!decode->e.gen;

Thanks,
Andrey

