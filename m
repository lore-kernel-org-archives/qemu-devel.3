Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2389C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohf7-0000xD-Rc; Tue, 28 Jul 2026 09:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohf6-0000wj-Cj
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:16:00 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohf4-0002rD-Ub
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:16:00 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6689f36ae56so5235049d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244558; cv=none;
 d=google.com; s=arc-20260327;
 b=CbW1eR/QgGrGixn5/FXvwWRGC5OwZmhKntusqk21IsfM+vZcDpoj/o7IAaeeFFeFJe
 gP3bC+SZBTyisl9VEc/lHZ5DsfEhEK9cdw031DJQDmxKMUcatV4exkCohrSWwH1HwBca
 ZB6fpwlS4CwKGn6kUwSActsZC9jsyojSKPqk4ye0CfzSyJPyHp0l/dFOnK1lnEvwGVEm
 04QsIbQfX/PeDMcgSdETnt0XxVF+IQf5tSWpJszomXBgEPiyx2leBKVEKbmjmRYjoEYA
 YJdan3rommCWpS2DSLi87WY9fmcLIM73oYT3u9gF7gTcrQWQxLZSqgI3iv1eVuQMvZKM
 aaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xa0DYdYtToAFFDn/isRQI4wrwxWtYIxmjrregOyaBAg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=AhI/x4nFdy4WdS1Dy2ms127sCVYGJNmko8Q5dg1hrHUOD3P35ZFDEevDM6BjiSVBEp
 ++fDlrVjFbV1Uoi9ExgVTIJgKq9mwzMCajzcuCKplUfDwF/84ufB3kFj5lfvQ4jrCkJh
 i5VBlCXjTzsBsZptAtk0yB3PNYcfOr0QCkE5DpN11wTUTq1/vtKpFOrH10D0NdSZHJJu
 y6NCTzhWyPBbiSvSTVhhJMi2VW/hQdOr71E6O+CifK20i5AqGQCDxPLgjntBnAlkj8eW
 sb0uKTDT2FTEzIG+nJ7ycnb58BAhv1esPu3jnRVRmBJDV+N53h4zDq631LM/3FZ8/Ns2
 bzag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785244558; x=1785849358; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xa0DYdYtToAFFDn/isRQI4wrwxWtYIxmjrregOyaBAg=;
 b=h8EUq0gGL58C3OOcXhZ9c00gnGUWFKNfNbZO8p0XrTm77DotdRtFpvzSLxrGVhRSri
 mFiFw6bV9xDSFf240E4wUdS1YMrBXgk6SLLbRK6tSxWDoi5ReSQGUAKnK/V/HPFvuP5w
 zkAVm7vflEa7NTzlT8Bp769y2Urs1AW6Pw6TtdBprdID+QLH4nCFIYERE7GNt7OGdSGL
 ajyGHyFNZdtDxVhix11PtG2nC/wdmuGf/oKJiMndU58nADcpfUibTzKXrlnk7Ck7ip+L
 ppghIpkOXKr4LdSh4/37oO64NotAe2CmDbcYpgUKsBp4zrTUT8H+Ho9DJktAUFu3Z4YG
 Zi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244558; x=1785849358;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xa0DYdYtToAFFDn/isRQI4wrwxWtYIxmjrregOyaBAg=;
 b=YIKXD8FA2MiGcwjCA9wXNhF35PHm5ygVm+XHEnggNqBxTUz3RfmQanavNgOC5tGbNg
 JhaieFVBGyPIlbbetEH6hw9bUccKq5UsMke5OCM8SEkVhctyBpxnYdO2CZg9hV6dFfWx
 SEkN8SMMeW9u7pBc2j0Qih5/WBKDXAjiFwz5zJCZKOFrT9ue8KpvTXE8w9GM9m5jt4jf
 X1En8I4wD+1z8h2KmHhGxfj8/Nzm2WaZ9SuooEB3Gdlw0jphYF2wpHqzahvfH28o3lq/
 /i8fEihJ0g6Fo97TlWnvFEPeAYrmU53mI31TNzBaC4e9bM7Whb3eYCyRHCSpqQ8PK8tm
 1GTg==
X-Gm-Message-State: AOJu0YyQcDlp9CAdKODJblcOnW6wCXBc+BB/xGLDN+2QN9icIjhgGlMh
 p+g9OrzB4sv3GZ+ozwt12eXoP6dKXBuH3yKpD99CGvz2UWM8TIOWFEOdfkXVC1tW57e5Laq99Mn
 DommUPfb6l3TNEcmn6b27yJHQ47r95M6vTiGwTVsJg0rxBA9x0iNW
X-Gm-Gg: AR+sD113yWJCOW7qZUCWuqZ8bF+YuRASWjDQmhG49C/iQTV2ALUGCtpFuwWLKYylIs7
 APwYp/XU5ELq5WLeYFPKb6zIM/N/ivTruVqqGs2lfok7ru6SISjCrTNatfRrnlMLh1cjCb0EP1W
 UG9aSlSlo914OQrC/3dx0r4FWXS5xtQahsph80537H9IDWspwoH5xDcpahjA5Eb9N1H2mboAKz9
 jp6gI3qFOKKMt02b3wov1jskzYWaboM81eAPEINf++EzGF5Nzx4Nmgv6YJteuI5ODEs9Z6EViGB
 qStmnVUs2Si/Lv9vT9Ba5cblPPq9yWfVyYay1DSONvOuFQ==
X-Received: by 2002:a05:690e:4851:b0:668:2c6d:92d0 with SMTP id
 956f58d0204a3-669057dce38mr540563d50.66.1785244557613; Tue, 28 Jul 2026
 06:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-8-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:15:46 +0100
X-Gm-Features: AUfX_myWn4zQYVwmJgMt7vTu_ft70sbE-A60C_eJBM19HFxo5Vq2yNIQsBnBWG8
Message-ID: <CAFEAcA-kMFKoK1vJMVsTHqONdh2AKEGWzv-KPpe40RQfvWZikA@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/arm: Implement FTMOPA (widening, 4-way, FP8
 to FP32)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 14 Jul 2026 at 00:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 ++++
>  target/arm/tcg/helper-fp8-defs.h |  1 +
>  target/arm/tcg/vec_internal.h    |  7 +++++
>  target/arm/tcg/fp8_helper.c      |  7 +++++
>  target/arm/tcg/sme_helper.c      | 44 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c   |  2 ++
>  target/arm/tcg/sme.decode        |  1 +
>  7 files changed, 67 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

