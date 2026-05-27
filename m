Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9A9CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHJB-0005va-27; Wed, 27 May 2026 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSHJ9-0005vK-Fn
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:40:40 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSHJ5-0004RA-Cn
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:40:39 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7bf0b47d2f1so104899867b3.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779900033; cv=none;
 d=google.com; s=arc-20240605;
 b=Osy16/hji1+b1H6RUAXEhiUft1ZC2thfSvku4aeEuYjvH9dUX31nfup6HVE+EBIFhD
 LfBr5ZchJ+zMlVdt4sIcj5/IYs52yrJt7bgs61iBpb2ZrvEuAd6AF+yqePbA0oe/DlSZ
 jQwXmHGVVua6bfFADWihTGMq4DRkwiiRh+VfCR0BPEKTFPfL1pcLGHTgUc6P6m7zTLsI
 aLuuhgsUgvQO25YGiAJLS/V6QT6A7Q/DO2zmqriMbNZy3J+cRFMaHGFXlifw5dJIqle0
 46ny4D4XrRG6DwQvRHP4YGw2OcW5rhjKYSpmG8sdMbybvC5j++iewS3pduwp3NQRCjQl
 dj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f9c/Zq3fLO9x6MWgCdxNj86ujVMp0EG6sR5yVe4FiVg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=WL0Oi/EAyPOf70WAmvJp0TTzdi4rn2Fb9kQ/wBbNVr7CesUaHW4gbDKEs5MZL7eeV0
 mxoyQbXDM5sgHPws5BZrMavnd+MWDy8x4O2OR2tcRCcPSEqo8GtXYGmiq5kiW2P6QQCH
 UY6LdmouGK112P1rPUwiyx/maZTxqrKyl6uQ1GPIf02yiTnft7mrhABN6nrWGJcojByz
 nLl4iInzyThM7NQKHFWR65xLPp+4XrFJlx5oMV+pOIJYJj6qnXcqhKgX68iQgcoYcAcQ
 AJ8abosU1cIRdG3nm7mTAfhWkrfmDNDP3Vu6EHId+Y0rGVJA/Pl3Yz1+PLxVrLoZ7hRD
 ATHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779900033; x=1780504833; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f9c/Zq3fLO9x6MWgCdxNj86ujVMp0EG6sR5yVe4FiVg=;
 b=FElnSIu7+vf91GENK+k8QlpnyxrHFclk7XRFfE8Jn3+TyuWXxocrCO6xMjKtemXPiL
 cy51xsuz32BzfqZi1rOyPkASO5OhZKavFVfOgI71dM3O2JP7EJgyAaYdQtZgcVxTLca0
 DjdEMtKLOW/LOHAK9RTiEKw1bhFQfumD6CNLCvQahlua0INcJgbGy5W1fbKjbPzEIErM
 xrcbiiFzujaYsWcIu17URwpxt65tFkzmw5MgA/XI22fyYLYEMtsQXA9EhkKIeWr5mVyB
 3nWObu+tupETpW08XYPcLclM20boG9Q0dl3m+PkiizJhzpV1Uwh1wHC7zSFQQrXN9IPe
 7VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779900033; x=1780504833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9c/Zq3fLO9x6MWgCdxNj86ujVMp0EG6sR5yVe4FiVg=;
 b=eKlv2+NBSG1vZpntrQaXPtXbBaeaQeCoraNNZPL9ZVVfxviqZE9fLdTEZFwQt6FM9u
 5aoNjgvmuxQ3NaJRQW0YRx3g8WT8EaghLC/7hDgkScV34mr7GWc9vgfhvZDBUX6l8OpW
 JhenGFO47s8ByZeWUiEG5y0oohiRpr24yhBL/ECP5jCGktrG2sBLUuga5fcNru5DEu4o
 tAUH+O9qsF8DwqKsDXUiuf2BAX1vtgDGGECvPm/1WBef+F2Fbb+NUJ+XYtHEpRRJa+Gi
 5sgI8nAstnjYOcvPsbjZrjcwfFa1/dEsEiuJ5GVafi/wcbgLvpaIRUTgxHXQL4tRPDs6
 osSg==
X-Gm-Message-State: AOJu0Yx/GWRKGQAegw6TzCZH8mVpnbeBKo9RO5Dkhi0gnVMRK1Oljw25
 HW/n8BvLDN0vTYg227ZQb4pwbpri9cqUvjHgNTKl60GOucyhh4SMdBW+GON+NGD++2PQVLCK/MR
 QBD7CQsUFdEKIyvuxic8E42emU5jaXXIiHetx8FE+vC4c89zLP3ph
X-Gm-Gg: Acq92OHeNWySDVAr80Xx491Xr0MQ/1CqyakALqw6BPGlEuu00aQSuNsY+JcEiOqWXk+
 esIAQ5i2UWLMiRKm626GWtrVAz0qHyKhB566diJAZlZhiARkaloQFL7vTuF0zSs1kT4RJks0XHW
 b8NGLppYmK5dWHftn0pm6F967XdqRGgMBnIgHBQpQFsOUR+HCGFSHMiY1OroWQvhM7XpsUyFRxG
 fPlsa3FWARUocpET22fPycIrJ6W0wspXopHi8HDVno1Ok+U3xoCvA9yFbaWcQGmow/GiOOCVJ27
 f6zuIj2Szbv5etCBlPj7zXnbEZrkUgKfPjijqehDZ/4RstMdwCypTMgjAAigNNbFGX87fbh1UN6
 z4w==
X-Received: by 2002:a05:690e:b4e:b0:650:327e:b398 with SMTP id
 956f58d0204a3-65ec95ef683mr22481855d50.10.1779900032825; Wed, 27 May 2026
 09:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260525230308.137009-1-deller@kernel.org>
 <00cbde94-39fa-44d3-9db0-1ddafd66656c@linaro.org>
In-Reply-To: <00cbde94-39fa-44d3-9db0-1ddafd66656c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2026 17:40:21 +0100
X-Gm-Features: AVHnY4IU5W5LYQICjjW1jPSCQVZI4eJMLAZh08EEbaelNo0h5PVZqBl-Oz9CmAY
Message-ID: <CAFEAcA-h20EQWNyWrQxX=WVMuT=kj-XzunuwE6bqyw_ivtw-AQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix loading static ARM cortex-m55 binaries
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 27 May 2026 at 16:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/25/26 16:03, Helge Deller wrote:
> > From: Helge Deller <deller@gmx.de>
> >
> > Static built ARM binaries for Cortex-m55 may have been linked to have
> > their load address at address 0.
>
> This is a problem.  We also use 0 for "unassigned" a-la ET_DYN.
>
> Perhaps ideally we'd pass around a separate flag for ET_EXEC vs ET_DYN, but ET_EXEC with 0
> is not a valid binary precisely because it attempts to map at the zero page.
>
> Honestly, I think this is user error.  While we support some m-profile binaries in
> linux-user mode which the Linux kernel does not, for the explicit benefit of the GCC
> testsuite, there are limits.

But if the user explicitly passes a guest-base address on their
QEMU command line, we run the binary happily. If we refused
to run the binary at all that would be one thing (and not
unreasonable, as you say). But it does seem to me like a
problem in our "pick a guest-base" logic that we fail to
identify one that would work fine for this particular binary.

thanks
-- PMM

