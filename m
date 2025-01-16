Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB5FC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNiT-0000TT-4j; Thu, 16 Jan 2025 06:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYNiR-0000Sm-Oj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:07:11 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYNiQ-0000yT-16
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:07:11 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso1491742276.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737025627; x=1737630427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b52tSWm+Of95KCaaDHkgkYJ6h0GzbjBzeCCqwOowkCQ=;
 b=n1oDi624/eUu2bY05NV6SGEptI2M7P8CwHjPHrc93mdbz8yxlQaR4U3AaoPvlb9G9X
 DgBgZs/kiwP4AS80LxrVw0VxqpQG8l+hyygJF/YLXb7tgJ74xLdVHutChrooOXNNQA4T
 lT/fs2N1Gqd/eW95egjjRrmzUFpN1RtwQEHE5B5ykfQGh5LLSpqMHcAe8EZ3gfDFJoOg
 r+QP3b4KPS1qFmlRtcVKP9xHZ06f8xTwcmF5WIx0Mt3tqIoNC85HYlfSmeVHaz1Q7fbC
 yPQJ2CF1kQEYbMbyCPJWHzoPkiXxLookZNYuZZVCxeO6SogpZNQB7Tr9xgqnFm4bFNS6
 IEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737025627; x=1737630427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b52tSWm+Of95KCaaDHkgkYJ6h0GzbjBzeCCqwOowkCQ=;
 b=icnYICIIGNtkJ8npeY1O7lKHD4+rmHv/lsKJ10Ek2fxfZPo9MBnZoJi9YJltTAFql4
 lkJoCdIZ2PRLYpJp4v06rkxqURbey6AKq2nuP3Aw/nNkPyBg6PYa3GDDt5lAZBtYD95i
 pasqXuALhjrHiIk5P24gtnvALWOEU6nvhfNJjQTdbTlqEpNhdeTqzn3iLskzC8K91BrU
 T6E2l9jnRmYd8GOZJtcN3RWWgtvF1/HrT/UXKEY/E/CyRlwQZZqe0fOH2a12uLLNdJV8
 tr/niBWH40tnKr4i2Hh6wqqU7CDWPkne339tsVROqJDEDHSmyxqu5966S6ACcoR6EwaR
 wTlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKe7UJ9JFlonNUcuiF2AHyripwT9jOT4EJjmN2ak5KT4LU5PCo8zO2EmrEqXu9kNrTNa8xEmzm3qP+@nongnu.org
X-Gm-Message-State: AOJu0Yy9+XK2hu/RfccToui2IGbBuQVJGKB4TM+B1RnCuTJ8/UfdihMY
 iSJCxbZiMG52m2F+ugj89JtqD183MRmKAL4g0lgr9xmYKYxpN2hSe9av6xrtRGX4j2hEUw2B/6C
 bYBDE/tLFYi8+Y8k55gxJ5G6B2wevRKYYBjO9Hg==
X-Gm-Gg: ASbGncu3s+J2e01X8I5wQsIqB/w0ZcxbeTf4HNtYFjD1ggTAPRJD9Y84tufYQYrGu4a
 OGIYgJUzdNiXoD5qAtJsO0klw54cLKxXGUSFJKT0=
X-Google-Smtp-Source: AGHT+IGjWptSH5jfWBJfBpU2wNd5xHe290BfZiayOvkXPjb9vzH2PaVOYlvm23vmWvb6Sw/b/5u8vas/ho78ZDWVSu4=
X-Received: by 2002:a05:690c:6a03:b0:6ef:c24e:5f5 with SMTP id
 00721157ae682-6f531224f1cmr304321057b3.2.1737025627693; Thu, 16 Jan 2025
 03:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
 <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
 <87frljhvzk.fsf@draig.linaro.org>
In-Reply-To: <87frljhvzk.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2025 11:06:55 +0000
X-Gm-Features: AbW1kvZiFC_--v1xNm3xy9a53mkoFEyaKas272wMlETe6RQq8geSnnZDx6-T3mk
Message-ID: <CAFEAcA-4M5W4=JH3s45+9JZnKrVVAgKcRcH+gVqMJqGxRfjrpw@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Thu, 16 Jan 2025 at 10:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>
> > On Wed, 2025-01-15 at 16:08 -0800, Richard Henderson wrote:
> >> On 1/15/25 15:20, Ilya Leoshkevich wrote:
> >> > Currently single-insn TBs created from I/O memory are not added to
> >> > region_trees. Therefore, when they generate exceptions, they are
> >> > not
> >> > handled by cpu_restore_state_from_tb(). For x86 this is not a
> >> > problem,
> >> > because x86_restore_state_to_opc() only restores pc and cc, which
> >> > are
> >> > already correct. However, on several other architectures,
> >> > restore_state_to_opc() restores more registers, and guests can
> >> > notice
> >> > incorrect values.
> >> >
> >> > Fix by always calling tcg_tb_insert(). This may increase the size
> >> > of
> >> > region_trees, but tcg_region_reset_all() clears it once
> >> > code_gen_buffer
> >> > fills up, so it will not grow uncontrollably.
> >> >
> >> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> >> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >> > ---
> >>
> >> This needs something else.  The reason why they're not insertted is
> >> that they're not valid
> >> for a second execution.  We need to not find them in the search tree.
> >
> > I have the impression that code_gen_buffer is append-only, so after we
> > create a new TB for the second execution, the first TB should not
> > be deleted - is this correct? At least I haven't found code_gen_ptr
> > decrements, besides the rollback at the end of tb_gen_code(). Then,
> > since region_trees are indexed by code_gen_buffer pointers, and not
> > guest pointers, this should not introduce any stale entries.
>
> We used to generate a temporary TB, execute it and then wind codeptr
> back. We simplified the code to generate the TB but then not add it to
> QHT - I think the original reasoning was saving on scarce CF_ flags and
> not over complicating the tb_gen_code function. See around 873d64ac30
> (accel/tcg: re-factor non-RAM execution code).
>
> This does have the effect of potentially regenerating the same TB
> over and over again but usually there only a few insns executed out of
> IO space.

You can't avoid regenerating the TB unless you somehow put the
entire bytes of the instruction into the hash you look up,
because you must re-read the MMIO region, and when you do the
second read you might read a different value than the first
time you read and created the TB.

The original reported problem here seems to me like it's a
problem with whatever target's frontend code this is.
This is a single instruction TB, so either:
 * the generated code for it completes the insn without
   raising an exception (no problem)
 * the generated code for it should raise an exception
   without having modified the CPU state (so there would
   be nothing to do for restore_state_to_opc)

It sounds like the target is generating code which does
something like:
 * do part of the instruction, including updating some of
   the CPU state
 * then decide it needs to raise an exception, and rely on
   the restore_state_to_opc handling to undo the state updates
   it did previously

The assumption of the "throwaway single insn TB" is that
you don't do that (i.e. that restore_state_to_opc is only
there for the benefit of multi-insn TBs).

thanks
-- PMM

