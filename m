Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69B0C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8eD-0003D0-RZ; Mon, 28 Sep 2026 06:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xB8e4-0003CL-RR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:31:41 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xB8e3-0003mH-Ef
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:31:40 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66fb93aee5eso2926536d50.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790591498; cv=none;
 d=google.com; s=arc-20260327;
 b=kF4CWs9/9GfENcE5M/GIpYulMbvIpfvaSRSxl8dwMvymgJt385eQWes/6UHi0ijyG8
 d4COaixfMaK9xXNGAZS9CYH26Mj/SBdsA0Nkqi8/GuQwzANVnCRbLcpFZZw8xNLIf/u4
 PQJB2mFJQBaK35qajP7NqdNUK7FQIPig/r/ZQuGkfU/JRun8SREuo63WblWCQxWD2AIX
 g7dmIP+1abl1JZYZTw6yz7U6DhZAy1veZxTs90q2ox/22q/ktUoV5gTDemGoR/IE118g
 LG6NyAtbpptOrL1Tta5hPw5FNZw5UsmELOXOixBItxPDigkwBXTehWzlY40HPRK5kiXl
 dEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gnuREIVueZm1km43ArMVBgd0Gydm3JAV+Uovq0UdlpE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=LCVHigAzpfony1o4oEighSVdsVb6M0b/0Lvy/lyXi2WO/Hjz9ThXx34JxgO6rR9/5b
 wi/Qo52QQkx1iZ+G0jLBdhWuicINEl56i3EjtD7m5kqMVJXpJUkfJ5qhGydfgz44huz7
 5wMrVvh08b/u4148+ABEYJUTIF9YRwkEAZvw16ZTLhAoZM+DxdvEfw8YGFjUZpKWRilb
 6Z6DxrGDtHe5ACTIt7B2CUgsOrEd43SBfNfS6QWc5JyYmboqCBmg8Bd27PomlJKfWk+b
 nUf+scJevAZp1oW7jgZt4VI+FsEhIZUnAaAr4JsoD23bJ6CntZf/ul0BdlHroE29Xasa
 Mfgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790591498; x=1791196298; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gnuREIVueZm1km43ArMVBgd0Gydm3JAV+Uovq0UdlpE=;
 b=VrKbBKipVOnOOkDoEfvuQjBOcVqXUM+NauI2IukEO4uXk8CHNH7V81KMYyysryUXEk
 KBjW+yqjypuRYoe0Itdw71ubDzUMu+yRIKdhRlLgJht9lazC3XDf7UllybgzBIPdUEUa
 oCbAqJpQGv1tHpMIJKlAZumFEqOINyBQkgNK5SzQpnHyKa+0y5DH1OPQ90Cm/ZSn4IH7
 9S8JmAoz8bpGaUBtm+WXlEirCko6TgcrASNpVQ3EWmhQUhQflKtKt6fzd6mc7XvriJFY
 /2SWwLLhwhXk8SgXC2ZwNqnaookmuDlT2kBTRrWSqq2ejhMqbRqlJFtLZl1gKKge20PL
 im9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790591498; x=1791196298;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gnuREIVueZm1km43ArMVBgd0Gydm3JAV+Uovq0UdlpE=;
 b=hMWAVrSBQko0MxoEd4csJgu8e/LXJwYgfxDRz7PNa5ywYNV5krCX59uiU9w6MWW8Sl
 lYBG4BH0fE4rfhw/j0H+Ndy2v7nl7p47mllxUWT8vwQ+UXxv3elvbvJezo2ufNlbO5//
 VikUWHRf2jtfzJ+zSWS68KomzALxSGK1teti8JjQz3L8XdkfGb8KbsgTeT1iB7JjX9j9
 JpJlJIDqbiAoS/vtzXUX9osfGivBjKXuhaNcGnIRPU6YSks/CVshU9eOryG/Cs/yRxCf
 eIfaHmoRHGb+kMuQ//AOscG1MJnOUmxkE/1AxP1T3nHZPrvD3fhj7UxmnUbsPBw1yvoi
 oaeA==
X-Gm-Message-State: AFq9FYKzkagxHdou1BuCYsh2UY6cPmNksVx41Snf/PVAYHBd/zv1K3Bj
 aIytTkW63kKf1U5nTQ+xmY9BAlTVIcIOoDQSzOK8UwMjBbpj+wzfTHlPWQu+PaOvc7jwwAzy3KS
 g70kXuJZC/yjNrqDlELNvrMrnYlTRFiJx8XEAjVQsUQ==
X-Gm-Gg: AYBFou3COQ9UZxKYX2Rl7apUzEFUvHBqu7DazNfY22jf6oO6/9d9PBQ5Oqz5WvmJBqR
 lZyimYdCvsOy6rGk8JBqu94nz7Euy77AqW4AiEriWiUpqc9TIBmpfp8yeC2CVCCXOiQwA9NqzOb
 8M3vii47LKkryKjRxzVNUIaT3GyNADCIm7VpyhkQQOlAIr6B0HXZb9S1v7GKfGKEm1e+vN2Hi1f
 bPLQGkDCBAGyqw/PKF9eFK49qSW1KjQLqJx1vsQdjOR0aWx83glDPj3xd+Hapr4N048wz6Mq/zz
 pZaexv/byqEhP6UfjGQ70yiawNtReNPl1yx/6KxM5ee4QUB+CrYOYrj/07rsY3Mwc79L2gEZzX0
 7oQ+YecXLOewg7D6txjciRyvKKFRYYq0LBgSJg9PpxpczcJTPZA==
X-Received: by 2002:a05:690e:1442:b0:674:13ed:9c3c with SMTP id
 956f58d0204a3-67413ed9fb9mr2656554d50.95.1790591498069; Mon, 28 Sep 2026
 03:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-12-richard.henderson@linaro.org>
 <CAFEAcA-9BWhLf2AagEcnacxMYKPYGKC=iKKoGRvPg4BW0PtbaA@mail.gmail.com>
 <ebd4f4af-b958-4d76-a671-6927fbea1d70@linaro.org>
In-Reply-To: <ebd4f4af-b958-4d76-a671-6927fbea1d70@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 11:31:26 +0100
X-Gm-Features: AclHuK_QAFRqtR_5gjUQlzL8gNAoGs758FWsgf7ccPyY_A733fSDi9UFXpy3w3g
Message-ID: <CAFEAcA-D=7CzzF4RQgYgJwF04rrYTYHiLfcnORuMnUT6AQkVxg@mail.gmail.com>
Subject: Re: [PATCH 11/13] target/arm: Add PSTATE.UINJ to tbflags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Fri, 25 Sept 2026 at 17:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/8/26 04:08, Peter Maydell wrote:
> > On Fri, 28 Aug 2026 at 23:27, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> >> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> >> index 296ec8101ab..174f4aa746f 100644
> >> --- a/target/arm/tcg/hflags.c
> >> +++ b/target/arm/tcg/hflags.c
> >> @@ -292,6 +292,9 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
> >>       if (env->uncached_cpsr & CPSR_IL) {
> >>           DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
> >>       }
> >> +    if (env->pstate & PSTATE_UINJ) {
> >> +        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
> >> +    }
> >>
> >>       /*
> >>        * The SME exception we are testing for is raised via
> >> @@ -513,6 +516,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
> >>       if (env->pstate & PSTATE_IL) {
> >>           DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
> >>       }
> >> +    if (env->pstate & PSTATE_UINJ) {
> >> +        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
> >> +    }
> >>
> >>       if (arm_fgt_active(env, el)) {
> >>           DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
> >
> > Could we do this just once in rebuild_hflags_common() rather than
> > duplicating it in _a32 and _a64 ?
> _common is also used with _m32.

env->pstate & PSTATE_UINJ should never be set on an M-profile CPU,
so it should also be OK to do the check in _common if we want, right?

-- PMM

