Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860A6C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvytn-00038K-MV; Mon, 17 Aug 2026 11:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvytm-00037R-5h
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:05:14 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvytk-0006e5-9I
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:05:13 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-836c8bdac50so45880787b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979111; cv=none;
 d=google.com; s=arc-20260327;
 b=kxZZBo+MUDtGv7c+igFybbBjrkL4cDi4pljH+8pzvogMY58T3argdtYBWIqkRKMZZl
 WBcq57gE1BPxngWD2p1RjHIZeK0TW2fUCxex7Nj+UvSJmQqCuaGqLY+QoJ7JjAbn0Byq
 /0Xgy8QN1iuYLNkyldGoJ39iXciEB5daGbibkEBOmK0rY08WunkAnaMyXD0+Lj6X8R5J
 +ZZZJwabwt+R3isbsYU1BrtpdTux7os73IxevAcWixjwUkJ7SBGUn4fHZrQnu9DNeZ4M
 pFGQrGtB9qEANwS5klc2hsnIQ3wW9DoCrN2+sHxHcWsMMT74ZplFjqV6jR7MaTtkO3Ll
 ZKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bTDSl3vbBIWXZ/neowUCuUM/B4vD+2Uiz6LJRcpxOjM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=F58V9PVeFQepA5V9ZwPD5oU3oHEjptBDwYUKBfGTAhNGCzVCBuaJirpJ1FIlqAU0CU
 NdaE5TGLpwz2ZkeCSN55VNtJ8aa9kKu+FeeGIkN1HGVVJrFHmCWRGLgTEMPC4ie6drKH
 ON/lcOsqFMaiH5bPIvh5cVCgNmsAaMO15EvRT7TH5BO0meM+X+qhNz4qxbc4Z/2F3xeR
 PN3x5gBcGEN8u2dhimWR/rDkhfpg3i7ClJpXtSU6zqCLMo/gxey7uICc4RKWmw6y7uYr
 hCqBGNJOhykKQ8+NzwkP8H2Rfjc2yjh5urUL6scwwD78e7HCWkHr324hAzyTfd561LDj
 6C4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786979111; x=1787583911; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bTDSl3vbBIWXZ/neowUCuUM/B4vD+2Uiz6LJRcpxOjM=;
 b=lzQrImwG3OhYTLDpuU3RguDBKH1AU6xDH5Y/nps/liPBl7W+sCSn0s7OadlN9ECw+n
 EbtzU5CUC+sRRoZU5/ChsPnEp6W1kQi9P2Zjj4br5uW8/gGMNYTdI+weFWo4QGPypmFA
 eKnXqfJCpTXIcItwLVqUCOfgPuSo4W1+CiO/WZOG1za9WvtN2XmX4PPYlsdtLZbQ+38+
 wtd6Zo2dxZzIOekcvlmBJPY++kdXauwNtM2H+Pk7vU21KhaXoQsQRA4Cc8Ey5HRKxpe+
 KucnPTMCG0jHhkCt5cRdad06YPYy1FK3Y25lmcjB95uXBic1AyBkSrnZBNxuY4lBzosQ
 0IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979111; x=1787583911;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bTDSl3vbBIWXZ/neowUCuUM/B4vD+2Uiz6LJRcpxOjM=;
 b=OtdBpOLewffj33C0hwE5FwxZ0fDOhrZSftbeb1Z+WZHUt8mnfvue3kDymeh90uMbSt
 Hko2Ub+02MtEsm2OIm7eZV+kuJyVmaYzVbUjaAybNiEekqSirhn2WnZuYHExtK2UY/ae
 xDnM2huRcjmgkcZODXzQteH1MoL6OeJ7DymEMtGCSuIRBe3zMtc2uMZy8qzYF8aL2k6r
 EaAaeHTcTPud7y9YV1FStHNOpoB+FAkrFqugnDQ/O1WtPYrH1qpVrsyC/29GcLA4EwM5
 UQXkz7CbdWMlKOq6z+j8lsV9TPXw6N71oB27+DKLfla8bcGpPLDVx4W0sZ5psWp6WIJb
 2LMw==
X-Gm-Message-State: AOJu0YzjrbMVqExbyRnTnqwhIkq5JCm4NhD8r2mkG0W3BvCDlF90SEC+
 LUbDK+PzDRrZfi9De6gzNGA2IcR3lY7/MvIxJUyer9zdUQV51xkpqwMfKwkwK2MWY1yGaEnf5uc
 QJ8E6H9jJm/6mEImq/GogeErzycpYAIZnK2rJl3n/VaDF52iJWlTatXs=
X-Gm-Gg: AR+sD13jGHgb3DeRMSmjw3zHU4ONkO84zkfnUb4W0999TDsmQbmzHUR4NBheuwGOMJm
 vljT9JfL1plvcIaSKCLLj9L6TcmlAFtTGiiMqoH0c+wcmK1ZmhktpEJPsexLDnSH0hNgI4I9v1/
 nrsEC4xbM3Yf11iWuRuID/hj6MfWD/gWZ8p6u+i0Jog0GVuRdO/AGXew5LbD4s1Jxwp2FyZcjin
 mr3yaXXInkKFugC8aeFz3h2/83wMDKE3mUqjR4kbVMSJyTPWQ7kc95S0oKB4qBSejCXDm8LUD13
 Lldd4paRHA7fGR5RNXaGA0Pu90X41tKMJaSLYcWmqlzxNKGUhL4qtDjSPwiRcjCxJPiwB2Ehnab
 2OsCAQz2/i/aq2GpRHfMkdTMtygZWG1wIkvhluTqa
X-Received: by 2002:a05:690c:311:b0:81f:e7c5:f420 with SMTP id
 00721157ae682-84131277225mr6317187b3.20.1786979110903; Mon, 17 Aug 2026
 08:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <CAFEAcA-xmbhZFG+zVcQDt02UJ5ELY2bOiCkVVW=60oZgzujiqA@mail.gmail.com>
In-Reply-To: <CAFEAcA-xmbhZFG+zVcQDt02UJ5ELY2bOiCkVVW=60oZgzujiqA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:04:58 +0100
X-Gm-Features: AcwNN1VKVMupBbeViC0ymV44SLc30POJjleH3mcKWR0BMQcDld_WjelXWQ_0XyE
Message-ID: <CAFEAcA8Yh7EcQ_Wi4PqRPZDR2L1-tuDpDPS1-TEGnidSUdaTCA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] target/arm: Introduce cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 17 Aug 2026 at 16:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 12 Aug 2026 at 21:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > This is something that we've talked about for quite some time,
> > having separate "max" cpu types for Armv{8,9}, because Armv9
> > prohibits some deprecated Armv8 features.  Retaining all features
> > simultaneously has the potential to cause confusion.
> >
> > Changes for v2:
> >   - Re-reorg cpu_max_initfn, avoiding the build failures without tcg.
> >   - Move aarch32 tcg parts of cpu_max_initfn to tcg/cpu32.c.
> >   - Separate patch updating feature comments in aarch64_max_tcg_initfn.
> >   - Do not avoid aa32_max_features for v9 -- the registers still exist
> >     and describe the features that might be present at EL0.
> >
> > r~
> >
> > Richard Henderson (10):
> >   target/arm: Tidy cpu_max_initfn
> >   target/arm: Pass ARMCPU to aarch64_aa32_a57_init
> >   target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
> >   target/arm: Sink aarch64_aa32_a57_init into aarch64_max_tcg_initfn
> >   target/arm: Split out aarch32_max_tcg_init
> >   target/arm: Move aa32_max_features to tcg/cpu32.c
>
> I've applied these (1..6)...
>
> >   target/arm: Annotate arch revisions in aarch64_max_tcg_initfn
>
> and this (9) with the minor comment fixups I noted (but not
> doing anything about AA64ISAR.API or re-sorting the out of
> order ID reg field setting) to target-arm.next.

Also, once we have a max-v9 we should fix up the slightly
bodged GICv5 property handling: currently we register
the has-gcie property for v8 + AARCH64, but we should update
that to only register it for a v9 CPU. (Q: how should we detect
that we have a v9 CPU ? Do we need an ARM_FEATURE_V9?)
Then we can remove the code that does 'Downgrade "AArch32 and AArch64"
to "AArch64"' when has_gcie is true. I can do that after this series
lands, if you prefer.

thanks
-- PMM

