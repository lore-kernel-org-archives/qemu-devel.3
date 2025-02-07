Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60371C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOeB-0002q6-2W; Fri, 07 Feb 2025 08:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgOe7-0002pl-Du
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:43:51 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgOe4-0006qg-9k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:43:50 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so1555632276.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 05:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738935826; x=1739540626; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VNdKWa3Ia2gl38bw4A+FJWTdodXrTZ1/0JopTaLaTpg=;
 b=b/dL4cChAlTg1Uv56xvDhjoLD0t4ezMVgjNhyTMtD5APPN3G/zobGH6kX2Fwq2MerN
 ymeczD/8F6ee3GGL8fvVXuv7qnu74G6EcsJ3onBfkpbZI6w/RaelqjQDtwkNdBGlyYWB
 2QrupRTU8deX4o4YFDStNcZLiRxB6APvVsxaerGpeR73lpJbaHL2gI4ycDUsyqHJv76/
 fWMsX+nXvaUqpS98SO/PezpSi0d/H5F+t6ealFR0gfmDCFQnA0g0VX7LbhlWdqXZdR/w
 Yjpod0wz6/HmApDbFSPNOFlCKbGnAQLxly0yjVfICVu2YD7i94Vf+H/3wWWZLFei2mVz
 AV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738935826; x=1739540626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNdKWa3Ia2gl38bw4A+FJWTdodXrTZ1/0JopTaLaTpg=;
 b=oKqjfa3/sTBhvlUlf5h/yuSj4DuIRP7W1vGiZuUIx7XrEpFeSLd0IDdNDlYrnAp7XF
 3ptbj4UpS4yks8pHmAo8tvJjkUJMr4tReHQSMEMaz5t0430M1RomENkTIayKf0sZ2Yrr
 TZT6YS9D3ACaitcUL5gXnT/OzK3FTHjLTtbF4AUwqee29+priQ8EWCBtpx2zCASgVIJh
 eb7kQqj0GzR6+RTm6qDDUCnCWDBey0pcC22JXMGA7FOnTErGhRrj7VJgUpuGaiFezVQc
 CaFsQ7odEDDxw2dOA1Z341OaWPNSBPI1FPYAl0Q0WF9lebOY3keUZQ+NBUvGowaioGqE
 XwMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7r5A4ZxRY8Im5jNhGNrtXc+WNBCoHv+DtjxBu5Kjl6ckpAhiAKANvmV2n/lg1eO5jWqNrznUpFOQA@nongnu.org
X-Gm-Message-State: AOJu0YzZ98WbDthe+JkIl0wyY6qw0DH/arYk/uhF7rDsPSkDRa8+Db3P
 kZJx9vUQsRIkho+pg5srV04kZXbf7rq38nUoj+nwbaVsNDyIGa+SliCvj8wU7QVBeEE+UWeDrEo
 qkMO70XtROeRtRtSi80uysWjoa4JZ3tToxfGEVA==
X-Gm-Gg: ASbGncvZH72W8AisFKJ+nEgIil5cvt76pF5j4Pscu5ZSlnvaz4q+/X+GShIwt2u/tR6
 jTLhpte7+poYBzlaspNpK6Q3Oej/kGbrfWMKMpbjOWzLi9NOtGH+2HYA5cuR+RnMxVtJkoBPhjw
 ==
X-Google-Smtp-Source: AGHT+IF2dnstfiiIAr+B4cd8MZq02hSL1afwvdNeIF0CTYEFIIHVNc6kLymu1Bde/Zh8UG0f82k6Qdssz6hVwzpFiu0=
X-Received: by 2002:a05:6902:1b06:b0:e5b:ef8:845 with SMTP id
 3f1490d57ef6-e5b46286c0emr2395285276.44.1738935826652; Fri, 07 Feb 2025
 05:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20250207102802.2445596-1-pbonzini@redhat.com>
 <20250207102802.2445596-6-pbonzini@redhat.com>
 <fcd2ffe7-a400-44e0-8dba-258583c2940b@tls.msk.ru>
In-Reply-To: <fcd2ffe7-a400-44e0-8dba-258583c2940b@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2025 13:43:35 +0000
X-Gm-Features: AWEUYZnDXTY29vTTyrNBpSeENPRdIJozjlcpsLvBqXcjqHQyAiZMTeswqITwY1c
Message-ID: <CAFEAcA-JJkk7wQh+bFbhAoR3tcSHThRMBd4XqZcmNOTL7UWmrA@mail.gmail.com>
Subject: Re: [PULL 5/7] target/i386: Do not raise Invalid for 0 * Inf + QNaN
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Fri, 7 Feb 2025 at 11:53, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 07.02.2025 13:27, Paolo Bonzini wrote:
> > From: Peter Maydell <peter.maydell@linaro.org>
> >
> > In commit 8adcff4ae7 ("fpu: handle raising Invalid for infzero in
> > pick_nan_muladd") we changed the handling of 0 * Inf + QNaN to always
> > raise the Invalid exception regardless of target architecture.  (This
> > was a change affecting hppa, i386, sh4 and tricore.) However, this
> > was incorrect for i386, which documents in the SDM section 14.5.2
> > that for the 0 * Inf + NaN case that it will only raise the Invalid
> > exception when the input is an SNaN.  (This is permitted by the IEEE
> > 754-2008 specification, which documents that whether we raise Invalid
> > for 0 * Inf + QNaN is implementation defined.)
> >
> > Adjust the softfloat pick_nan_muladd code to allow the target to
> > suppress the raising of Invalid for the inf * zero + NaN case (as an
> > extra flag orthogonal to its choice for when to use the default NaN),
> > and enable that for x86.
> >
> > We do not revert here the behaviour change for hppa, sh4 or tricore:
> >   * The sh4 manual is clear that it should signal Invalid
> >   * The tricore manual is a bit vague but doesn't say it shouldn't
> >   * The hppa manual doesn't talk about fused multiply-add corner
> >     cases at all
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 8adcff4ae7 (""fpu: handle raising Invalid for infzero in pick_nan_muladd")
>
> A nitpick: double double-quote.
>
> 8adcff4ae7 is v9.2.0-7-g8adcff4ae7 - which is 7 commits *after* the latest
> released version, -- hopefully this fix should not go to any stable series,
> unless 8adcff4ae7 itself has to be picked up for 9.2 too.

Ah, yes, I think I assumed based on date that 8adcff4ae7 had
made it into a release already. That commit was a refactoring
so it doesn't need to be backported anywhere.

-- PMM

