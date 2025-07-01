Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D81C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXgE-0000W5-14; Tue, 01 Jul 2025 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXgC-0000VM-A4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:53:32 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXgA-0004mR-8s
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:53:32 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-710fd2d0372so49036837b3.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751363608; x=1751968408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wImLPadQucP6avEWGXXDkRvaaePghLhR5MvhokcUgVY=;
 b=CnFv9t01uVunrTQfw5kFzR7ByAXK+shoqAwgAKvTVYmWI3wfV6TA833M7PHSV3AjTr
 JleVgQLrCKq3gfMFY9MHIsoemEF6yKnI/si5EsashR3bhr2vsNbUWr3Rh3212ZaIUeOP
 swjC1Ewg41Fhtb6VtEF4nAN772lVeER5jw9t3x0NMwy03yjlFQZ5Y+uGC5TiivTrRINb
 aPFs9bzWXjAVYmcgZXVKSsLZbcb6ZW7e2UJ3kg1p/e6IzkHK2NJ+Sj6yh/4l9NK1HSSR
 XUbibWdvrxbteLZWFQzh9k0lJnK4XL78n4iqgMKZ9W6yGF8jdVGLcDEFOPbJRxOVx1AO
 Dj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751363608; x=1751968408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wImLPadQucP6avEWGXXDkRvaaePghLhR5MvhokcUgVY=;
 b=Bk+oVdtQiR1XWVYtYcKzh+y4K3yt4Rq8MIGmkJDIjAJpt8mZeaoc56I518l8Dk1q9h
 iqU9P1TX1QcykKnIesskJXxJGN/Y5veV3cARyfFFyFFL1deZp9FXY3fEBPoIHDDourtX
 zp5EKYOWwVOqAFXwWsfWgu+gVhfS/QpLXnyy0A/vfLLFr2dnzjxrr9WI706JQE0dvCvU
 cME8MEPWswe6x9PdnXvbDfZ1FX93F/ODZjQgescysU6wvRWpRUtWXWx9k4Ausl4BrZO4
 BZkYLc9n0XNCMpVpf06g06L+I6TojqwSLYW7GuSVti8oUEVV/YLFUeQjDGZLGdVVsE9k
 Kjrg==
X-Gm-Message-State: AOJu0Yz4lEAXZthbmm++R8FR6wuxYG4Xq4GPsGgZVt/7PImG86hBvlmy
 SqQDIQmIkIrMnWtJY0KmjsuupibTlZdkrjJNFfeuAlVfacty3Ru5UVjEvHM82mvkkf5eUtCQZB4
 Vm9GDeHtB0kKosNeJejNbYuuM5hNyXseGM4//L1VdvQ==
X-Gm-Gg: ASbGnct9sWZmCxAdjU8IdmaOBqe6r/vzHUSUqcuHP2xTFaMy5aFygNW8YXJfBTL5xVN
 oU8KNnI/zQa9gijVg+eXESXTx0GEdjs7z+CfhI51j9Af7c1+ZKSvuMCWLS96cCu6r+8w1Cr17At
 EzwiJ59Ri3KKmx0jIbITAJYTXM7TPm/xEOCk1hx+TiZKJh
X-Google-Smtp-Source: AGHT+IFJCoy+BaAXpqIPg7zTDLzhyK8miq/1Dpx45qGcw9+XUoph9itQWahKy4dHJ12+vXIQx6+RnOzACS932yqoIig=
X-Received: by 2002:a05:690c:6602:b0:712:c295:d012 with SMTP id
 00721157ae682-7163eeb32c8mr39248687b3.13.1751363608216; Tue, 01 Jul 2025
 02:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-12-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-12-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 10:53:17 +0100
X-Gm-Features: Ac12FXww9a1Do6eGY4OGmuJAIl3RWIp53XrSRbJt38wyQKMH3BAQVzfhsdW1Nmw
Message-ID: <CAFEAcA95pGrwhv7DwmjayhHoPvdmYbYBHnHUmCpHSMzLz_YE_A@mail.gmail.com>
Subject: Re: [PATCH v3 11/26] target/arm/hvf: Pass @target_el argument to
 hvf_raise_exception()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In preparation of raising exceptions at EL2, add the 'target_el'
> argument to hvf_raise_exception().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

I'm taking this patch, but note that caution is required here:
part of the analysis that says we're OK to call into the
TCG GICv3 implementation includes "we will only do this
for EL0 or EL1, not EL2 or EL3".

-- PMM

