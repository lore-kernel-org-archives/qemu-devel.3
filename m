Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C898E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4l9-0007eO-DT; Tue, 10 Dec 2024 13:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL4l4-0007WP-7A
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:14:54 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL4l1-0002of-OK
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:14:53 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef66a7ac14so61566347b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854490; x=1734459290; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hFPlVsLKIwsd78NBZXnTlXAizTqn1aFdRF+H5hipd3w=;
 b=y4ZAKT+H3Jt6JELvc+8NQ1QTdOFFMBkjks8y2j9qpMeE9P3yaP2/3ZsOwwCWn7oC9x
 IXWnMA/IYzo+OBlHVHotkUTeJvhER0x2T5QFyYzex0M/eN9n9UECUlVyLMp3dJCwES3j
 pS6eLlA+ZYolwD64Qn3NYK8i8cC2fp0miJv1VRrTRsng60CW7jhq2/T+x+cz4CghHPPg
 zpJ7/oNAH4I+Wf01JzQ/hp1wLHRiEUnTaCuYNSXmroQONHW4iUGeYG5/psiJpZ6wDZ+h
 o6SVSPy1Uz74Y5YXt9aDq1eJHsuGRiZRiDBgAkojvVatgG4FTQ3rT3iWE4mzUqB6Xoqn
 3J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854490; x=1734459290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hFPlVsLKIwsd78NBZXnTlXAizTqn1aFdRF+H5hipd3w=;
 b=kLrRdPW9hXbEi0HH096J1zrfFjlES6kvJSW59P/jKetmYB29JgElHZpImDnWZ1Xi3Q
 lBqz+QJVWfTNS+i9x7HvFmLsZnsbbuby7YQkmZbrgvRonfXAzP6Ssnd7BJTLsjTND0LJ
 0Q5dY4mPC9wohbB1jp8fTn3MrG1yj038hamfsKZpgw365LIA9Q3bdFnxxu1ml2ENyxXJ
 URjVMthHqv44gv6UC9UsBcJV3RFsIZz+DNDIJjQmt94wCBZBDUMI0OWk10xERd1vzoag
 i9UeTr5D6mVRMoCSKUnaBs7aSa2C2wImItuDo0xjHiUumg20LUM3UqcjaKvkAfJajUfO
 Sg2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI2mQQ+oWW7gMHhitg8D69O1/Yovm+YlfQDt3My4UqOTpdW/7TJIhnAfqbfmMG2wNSGgmuu6qHCy4Q@nongnu.org
X-Gm-Message-State: AOJu0YyWm7NYgI2+sZmWfW7Nkr9BPb5RJnvweW7LSRd7QWnbF6hKNa8l
 nYRiBCTx8aWjmhq2G8c08TZSWl6c6FZBQm+r0foaDhUs6j0nmr3gzxCP2CfJ8AuZD+gw8qcTSOP
 kqlwPPDuyNhYSBbSd5fIAXI2rN8rfMIY6VVLJwQ==
X-Gm-Gg: ASbGncuejS0EOARjfWp9hTGJhEwvH3u258jTr2pzaCGlhmRUt00iKBadTusJSatTDkc
 JkQrYxPKVEFX0KaF+9JlDhShK1z7zbDOitFnA
X-Google-Smtp-Source: AGHT+IG9iIyD8bW3tGHQrhNTMeOX7HibDNQoVVeD1iZvXh6XfSlZqdeKI7K9r4dVRbhpRyEV9WwI4DR1c7lnwsX9Plw=
X-Received: by 2002:a05:690c:67c7:b0:6ef:f020:601e with SMTP id
 00721157ae682-6f02588d7b2mr44114347b3.19.1733854490541; Tue, 10 Dec 2024
 10:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-3-peter.maydell@linaro.org>
 <bdbf12a9-0e34-4924-88a5-80b2f7eb1961@linaro.org>
In-Reply-To: <bdbf12a9-0e34-4924-88a5-80b2f7eb1961@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 18:14:39 +0000
Message-ID: <CAFEAcA_tanX5Z7dms154Ruf1CMCkmTG_w4OSKRiaG0MuSPaVSg@mail.gmail.com>
Subject: Re: [PATCH 02/10] target/arm: Move TLBI insns for AArch32 EL2 to
 tlbi_insn_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 10 Dec 2024 at 18:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/10/24 10:04, Peter Maydell wrote:
> > Move the AArch32 TLBI insns for AArch32 EL2 to tlbi_insn_helper.c.
> > To keep this as an obviously pure code-movement, we retain the
> > same condition for registering tlbi_el2_cp_reginfo that we use for
> > el2_cp_reginfo. We'll be able to simplify this condition later,
> > since the need to define the reginfo for EL3-without-EL2 doesn't
> > apply for the TLBI ops specifically.
> >
> > This move brings all the uses of tlbimva_hyp_write() and
> > tlbimva_hyp_is_write() back into a single file, so we can move those
> > also, and make them file-local again.
> >
> > The helper alle1_tlbmask() is an exception to the pattern that we
> > only need to make these functions global temporarily, because once
> > this refactoring is complete it will be called by both code in
> > helper.c (vttbr_write()) and by code in tlb-insns.c.  We therefore
> > put its prototype in a permanent home in internals.h.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/cpregs.h        |  4 --
> >   target/arm/internals.h     |  6 +++
> >   target/arm/helper.c        | 74 +--------------------------------
> >   target/arm/tcg/tlb-insns.c | 85 ++++++++++++++++++++++++++++++++++++++
>
> Subject has an out-of-date filename.

Yep; as you've probably guessed I changed my mind part way
through about the best name for it ;-)

-- PMM

