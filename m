Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3BDC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNERr-00021L-Fc; Fri, 28 Jun 2024 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNERq-00020z-5P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:27:42 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNERo-00013F-2B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:27:41 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so194637a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719592054; x=1720196854; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yL8FuGKU73EXqaXpsQFCabNbWF8pEBccj11qb+fKFbA=;
 b=QOag0ezyvI4gq+NS/8CcWp3nLJYgOn1752ZY3v2G0bhUsxTzfGXGzRz55J1B9cz8qm
 +F8viHrUheIGlC0l6ZQ2bpJhMFhRrhDQytWjXufXTS02wrf0DfaMKlzBzysL1NkkFcOE
 io9qmpdyCukSlfQfLlmtd9YcyhkNo6Ak4KiXr/MDfl9L2f/hrshezspv5K6EsisoohaR
 rJr+i36lFvJlGRtHSAWYXn39G6uLQWjNqBj++fG7ohxK3W0RdD/7RHFluLPuPl9NK5vg
 fd6jP//fnqxahwEzMP2RuG1//30G8wrDjvhjy9J6s4TJflZDdodHaFZN7j1JJAbZGER1
 mDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719592054; x=1720196854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yL8FuGKU73EXqaXpsQFCabNbWF8pEBccj11qb+fKFbA=;
 b=q1jUHEWEGl1lfj3PcKoLgs3Y/OwNnTtPYLUmvHbMpo4R3gte2D+fi3MzQcfVj52tCJ
 AKlw3aLXSE0XBnjGW7aHxQmwrvfs8gi7FLk2jd9E1Ud+CK5oQxOapQlxZCgx9RXJJon6
 BGTbi+p5lzMO7rZZgK7ChSyCplx+BkNWRY/WNCPWoqL8En3NaFB1ou0GV2zit1saLVxm
 GS3KoTkSYiOSFyUIJth/9PhwBW9EJFCUeF0KQYzMeONOPU34IvNMRoEHE/VtEIA60bEj
 kXLztz95Tb9D9ASBQW2RnWFJrLb3f3FCvQUENOpKWjVzDG4fgqExPi92NvnGrcYnTXWr
 lUMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ4hXMOIeoFsSvRQdQXN/WkNZKwwA/Ex6xgXesmOLRwJ8d2iGOVPmPsUhLp9iSLoOFMUe7IvDf3R9u9v6tkVa13xlmAn0=
X-Gm-Message-State: AOJu0YyEMbYwnm9gIcNXp5I5h++7PhPhGQSuTryGniStIcyKGvhUfekA
 xCtXr5VNB2zA1OKN7nEg6gJRZO14nsZrk/8vXWz83r0bNN4S0abd5zy1HBnWXged14CIaiWl7U7
 TQRCIpptoTISJcPeXTaDkRIwTnS8kixy90Cv7ApYVXJrX0faA
X-Google-Smtp-Source: AGHT+IH/x76iSwBf1vFL8A1u2sQtkjPgMCou9l4xMjGE0/c6GCcB9JhHeZW88zKobxXHNPdINfOTZMMfC+exnUuXeO8=
X-Received: by 2002:a05:6402:3595:b0:57c:bec1:ff4b with SMTP id
 4fb4d7f45d1cf-5865c3f51bfmr1915608a12.10.1719592054546; Fri, 28 Jun 2024
 09:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-5-peter.maydell@linaro.org>
 <ea780763-ffb8-4a97-8a60-5128f1ed017e@linaro.org>
In-Reply-To: <ea780763-ffb8-4a97-8a60-5128f1ed017e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 17:27:23 +0100
Message-ID: <CAFEAcA8JR0FFfq_Meg2XV5BLmjXJBLcDJjw=7u7PkP4STmRTug@mail.gmail.com>
Subject: Re: [PATCH 4/9] target/arm: Support migration when FPSR/FPCR won't
 fit in the FPSCR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 28 Jun 2024 at 17:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/28/24 07:23, Peter Maydell wrote:
> > To support FPSR and FPCR bits that don't exist in the AArch32 FPSCR
> > view of floating point control and status (such as the FEAT_AFP ones),
> > we need to make sure those bits can be migrated. This commit allows
> > that, whilst maintaining backwards and forwards migration compatibility
> > for CPUs where there are no such bits:
> >
> > On sending:
> >   * If either the FPCR or the FPSR include set bits that are not
> >     visible in the AArch32 FPSCR view of floating point control/status
> >     then we send the FPCR and FPSR as two separate fields in a new
> >     cpu/vfp/fpcr_fpsr subsection, and we send a 0 for the old
> >     FPSCR field in cpu/vfp
> >   * Otherwise, we don't send the fpcr_fpsr subsection, and we send
> >     an FPSCR-format value in cpu/vfp as we did previously
> >
> > On receiving:
> >   * if we see a non-zero FPSCR field, that is the right information
> >   * if we see a fpcr_fpsr subsection then that has the information
> >   * if we see neither, then FPSCR/FPCR/FPSR are all zero on the source;
> >     cpu_pre_load() ensures the CPU state defaults to that
> >   * if we see both, then the migration source is buggy or malicious;
> >     either the fpcr_fpsr or the FPSCR will "win" depending which
> >     is first in the migration stream; we don't care which that is
> >
> > We make the new FPCR and FPSR on-the-wire data be 64 bits, because
> > architecturally these registers are that wide, and this avoids the
> > need to engage in further migration-compatibility contortions in
> > future if some new architecture revision defines bits in the high
> > half of either register.
> >
> > (We won't ever send the new migration subsection until we add support
> > for a CPU feature which enables setting overlapping FPCR bits, like
> > FEAT_AFP.)
> >
> > Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> > ---
> >   target/arm/machine.c | 134 ++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 132 insertions(+), 2 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Not ideal, as vfp_get_{fpcr,fpsr} are called 3 or 4 times during migration.  But unless we
> have separate 'fp*r_migrate' fields in cpu state, initialized in pre_save, there's no
> getting around it.  And I suppose migration isn't exactly performance critical.

Yeah, we could have done it that way, but I am assuming that
the time taken for this is pretty miniscule in the general
scheme of how long migration takes, so I preferred the
way that doesn't clutter up the CPU state struct with
migration-only fields.

If somebody cares about migration downtime performance (which
does actually matter for some workload/use cases AIUI) they
can do some benchmarking and tell us what the actually
slow parts are :-)

thanks
-- PMM

