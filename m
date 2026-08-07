Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A8C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsN5Q-0003o5-T9; Fri, 07 Aug 2026 12:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsN5O-0003nN-HA
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:06:19 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsN5M-0005ss-Un
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:06:18 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66896892b6cso5363072d50.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786118775; cv=none;
 d=google.com; s=arc-20260327;
 b=NdAA9/Pe3CjnqMH8cAvPyS4+eegk3q90Heko3iTzYR3NGqzchBRe3XjT7luNocr6SZ
 6TnqTUkUB7Z1c06wO+zkkXRLNvLd29fsADn9d5GQFM2wpdtX+JKw2xmFpyzs9jwnfVMh
 HUkmn+L2tlNQGAkXfqN7hSzNFwyZcP3/5b9aLl1igOu0AY2NoIvluPB0Pjfz+Dtv6JqK
 kJcl4pLada8if5WZn2EMx6cgEnqwadF18wSAyGGemI7SgF90usCWUiHNJr/1/HQdjCsY
 6n0Bb9Nw0iAPFpz05ys+7z4h6aA0h1mw3h0KBabg05WbvMgJECXGV8WJg62M9K7LPBXj
 PZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xh1HAoq4+6sKE1yNOEGB8P8r6pKsYMc9b+MwMvMoBfI=;
 fh=Tqtvlpj58+qWxSqDn5jUnJ8T0zpB0Lrv054ZgI3JNJc=;
 b=ZTMxb0Ru5QX5QOo5EtP5HoWQxjIQylQAXpMLUa1gIY9ZTPV+UGHHnPzlilD0Vp5KX3
 mag+9Yyh45DE05vJYZvS9nhc1F5ktvjr4UHDBYhTH+h6K16v6cENpjxJRIdUnh964ecO
 ZXu57fD9ccnoSdIakqRKYwlbzu+p1x+gYPtoTyrRKHdaloG+7ldq8KL/QqaSt9sb5DGx
 uVwooM4WQ+uEtwrz+NO40A5xNubxi2N0XFMRKYG4WtVY9q4vbNeniPWlM4QzAR+r63pS
 Rtoupq9eih/SZzDj5UqunOyW35SLAF+YO/4K/tIq1upARHRd2tmhSl7oBhKvAiRQiDnw
 rSgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786118775; x=1786723575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xh1HAoq4+6sKE1yNOEGB8P8r6pKsYMc9b+MwMvMoBfI=;
 b=i3A0zVvbDVr7OrDdXZjs6HLtjNAHD+wOrTYLO88cTI2HjevaGS5CIExL+0L56AorSh
 G1cKdixmj2ru2n4c5Sjbojs0Yg8U2VpYOqPqLkCsMUQ+G11OxLNHNyg9zacxZdeQdmSz
 ytEhr41OO0Sxzc2DF1cGET1fDweUvcI2U8IHzLenn/FMhZ2/stvCIcCmg7661YYgtfRy
 4W01FDWHZqUA7YqrvVwlxFAx9/esJ7sBnUiToOoZJe6At6tiOUlrq+4uF5x65n7lLpXg
 BBWJBGWnCxJ0BoVTE2p8k9mqyLq79JIl6/ylXQRCIq461oZeuzmbuPBeJ8UwRpD/QctT
 4fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118775; x=1786723575;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xh1HAoq4+6sKE1yNOEGB8P8r6pKsYMc9b+MwMvMoBfI=;
 b=hrRBjZ0qU7gKdcDk/hIBCZ5PzrO9m+/jHxqje8cY1KpQDkAM+797wtDVGFnczbxpSM
 tW/TMyJ6IQUUSmg6DjK8IK+GvWrvUYI6z006RIWCozcxNF+tIQBifUQfhLT4GFgep0mu
 zW7JkI+waITGJuZgcq1nl6gyVWdK/3T106NVqEFdkENEW372/StCrGlGNVLrnBQOGGly
 zAjGvdWjV9bBeyM1sP8RMk3lIicTsmxmhMwxkHUFP2qo7732Gdw0VAVd6YY+hwTkPhqT
 osRMsK10Vor0l0q5ZEQB9kAu1H3inEiHPsFXFSbzNwcFjisZID8QNTHLOb9AJr/tH3u/
 LIZA==
X-Gm-Message-State: AOJu0Yyyw3++5O6Yd/JXULIaE3c25PFISuWMsPGfSmIxNw9/0IbVV8Dq
 V14IRZpyTEO2Ucljt0eKcjTtnejTgaVbZNZaX0wiVQ4uIA9gZQyu1MUAkNPkyDls6VHqbX33ipn
 6t+nSgWqPd1vHStDZzy3+FnkXxCdnARU=
X-Gm-Gg: AR+sD138miHrTnWKU3jNt7ZFBTytI9gAjfHYeFb6MUvaWEGWQeUvMS2QHPfJH2vichd
 lIK8ctguni1vydgJHwVLRXrHGKtYwJs0DeHiAzYG8sPFVMoR1zb80F1uul8L/aBjtLHQF3jH8md
 uMg6P/zjEmyiM5mTMfDnCpKU84ERQ4gHKW0F4vTCFY3ujgvbbX5q+joqxDwxAU1PVigY++lxhUU
 VPfUEF1KHc4zqjsPzJuYUG23x2lxCGCPoJUXoXnYpguundgQOvSeqqJoI4a8yEAIllvWOqGGuAd
 rCIJQAeoO9GQKCXIix5q9ES9OQMGm2VFwh5SqMeAnyykzDgxvD8U7zALomB5uX9AINm3jpgtG4M
 SNZaDMRF900RKrxBgqL0iZKpxJdLLHgqbkicQSmtX+Ma7moMTd6wJUd+5/B4pNlPt
X-Received: by 2002:a05:690e:4410:b0:664:e4b2:4e66 with SMTP id
 956f58d0204a3-6699a9198e4mr11602345d50.7.1786118775266; Fri, 07 Aug 2026
 09:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260805151810.369643-1-scherer.simon89@gmail.com>
 <5dd7fe61-c9c9-47fd-b20e-d76059271863@redhat.com>
In-Reply-To: <5dd7fe61-c9c9-47fd-b20e-d76059271863@redhat.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Fri, 7 Aug 2026 18:06:03 +0200
X-Gm-Features: AUfX_mys-73nC37LTLkaogI7cVJOsjuwFHZ5mVmMNldvEfXNznv6AcXAuX1l1xk
Message-ID: <CAEQwQtJyUg1xasBOLYamKeSJ2pckts3NbT80npoVD3Ej3ok_3g@mail.gmail.com>
Subject: Re: [PATCH] target/i386: do not zero-extend BSR/BSF dest when source
 is zero
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yx1-xb135.google.com
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

You are right, but E needs to stay v, not d64. Otherwise the source
read also widens to 64 bits. Counterexample: bsr edx, ecx with
rcx=3D0x180000000 gives 31 with E,v (correct) but 32 with E,d64 (wrong),
since it scans all of rcx instead of just ecx. Otherwise, it looks
good. Will send a v2 with just the decode-table change.

On Fri, Aug 7, 2026 at 3:17=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 8/5/26 17:18, Simon Scherer wrote:
> > For the bsr and bsf instructions per the Intel SDM: "If the content
> > of the source operand is 0, the content of the destination operand
> > is undefined." The AMD64 Architecture Programmer's Manual is more
> > specific: it states the destination operand remains unchanged when
> > the source is zero. Testing on real hardware (multiple Intel and
> > AMD systems) confirms that when the source operand is zero, the CPU
> > leaves the entire 64-bit destination register untouched, including
> > the upper 32 bits, even when executing the 32-bit form of the
> > instruction (e.g. "bsr edx, ecx") in 64-bit mode.
> >
> > gen_BSF()/gen_BSR() already encode this intent (see the existing
> > comment) by arranging for T0 to hold the correct full-width
> > passthrough value when the source is zero. However, that correct
> > value was then handed to the generic register writeback path
> > (gen_writeback), which for a 32-bit destination unconditionally
> > applies tcg_gen_ext32u_tl() and clears the upper 32 bits regardless
> > of what gen_BSF()/gen_BSR() had just computed.
> >
> > This patch bypasses the generic writeback for this specific case
> > (64-bit mode, 32-bit operand size) and writes the already-correct
> > value directly to the register instead.
>
> I think this is the same as using d64 instead of v?
>
>      case X86_SIZE_v:  /* 16/32/64-bit, based on operand size */
>          *ot =3D s->dflag;
>          return true;
> ...
>      case X86_SIZE_d64:  /* Default to 64-bit in 64-bit mode */
>          *ot =3D CODE64(s) && s->dflag =3D=3D MO_32 ? MO_64 : s->dflag;
>          return true;
>
> That is, something like:
>
>      /* For BSF, pass 2op as the third operand so that we can use zextT0.
>       * Use d64 because ctz already zero-extends the full 64-bit result,
>       * and v would zero-extend the output register if the input is zero.
>       */
>      static const X86OpEntry opcodes_0FBC[4] =3D {
>          X86_OP_ENTRY3(BSF,    G,d64, E,d64, 2op,d64, zextT0),
>          X86_OP_ENTRY3(BSF,    G,d64, E,d64, 2op,d64, zextT0), /* 0x66 */
>          X86_OP_ENTRYwr(TZCNT, G,v,   E,v,            zextT0), /* 0xf3 */
>          X86_OP_ENTRY3(BSF,    G,d64, E,d64, 2op,d64, zextT0), /* 0xf2 */
>      };
>
> Thanks,
>
> Paolo
>

