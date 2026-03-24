Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0D5FEC0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56bk-0007Jn-Nj; Tue, 24 Mar 2026 14:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56bd-0007Hq-21
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:36:00 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56bb-00034K-B2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:35:56 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7927261a3acso25772037b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377354; cv=none;
 d=google.com; s=arc-20240605;
 b=gPdRMVRAgjOoDPNxEWaScMGrDDw99s7W3zr0VW97z55qLMBeUnp/dkmoTXVh8emmTV
 ODRjSwl94ezlfV2qKPj/n041fLaTq8Yqp3ks26wBUWLvxfpFpiqPyHeScbZL7jtrhu9Z
 H3qTY6ruYoZAU344+5zwj8eKsaUzCOxIChjOomODYvmvSYMJYL4l3h3mJIKh7KiXLtre
 6RU66du/cahGnQBUZnJNhZri1yTJ64XBUyrhQtOqXaau9u8OBH4JObj2ar0eb09E8qpj
 0JIKi9BditU43v+jN65NOAioYFaWBlE9NoGRUBzkewW4C/bIsI32IqdG8NNdQ3wmrwT4
 mQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=gqaVCIHfBSuRumylg8OhQ2BZ16NV+yl0Df89L8kdu6U=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=B2BumCmY340dlque79Xwk4x1KH3zMfhNU9fXvkWqlMgY98FZ7dqrJlkIHbbFMOjxWg
 REL5bKOQAHazRed+mUn+PB9UDClK8bzMBT3zlPwa3j9LNZpt8EyXvPGnnS/zW/UVmDEK
 W31tMhq4UYzEHN4ykztq6y9C2uYSEijTioty1YfHRYxRYF7EIcw66P7dUYoysMlmLZGt
 bQ3EVe8Q9PqS8MIigVBpU/Xw+9/uxdax8PxRBKRPgWhu1qmD+N9fkGFpWbdXp6wFDDDz
 EmRuA0gHPWv0V+IjA8KMOP6HjvvlPzj8uLziAyCXf4RsUxJ46jwrHGhlWSnQdqThMm5N
 xe9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774377354; x=1774982154; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gqaVCIHfBSuRumylg8OhQ2BZ16NV+yl0Df89L8kdu6U=;
 b=E4Ncj52GEeYSoAVhWJp6h9cfba7QGy0uCOogur+pOc+J1ZU07i3ejVtwz+QXVAFq66
 QBjl1RIunVqAYYBgbIQDGBfLJTaqbUXUUPVrKwOb+tMJ40KrR0LYtskiyQHnekJkKOvV
 cgNSfRZhBA4z5xEtgDTmk9l2d93I+J0UUpCJ78NM8OTaTBbkpwyjXhSU2JBF3PsuF1xM
 Tt60gDllRg3ti8UnhNvB5OUNAfOt0MM0Rr6dogdDboCHlXwQQk4n+PbNVg/dzRN9BtHl
 cOOywcjtOubfhqyfgE5D8k6c8Z/xM69eLnlUbM/CA1FEzekma4TvhKmSDdGsWYM+ZSU6
 P8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377354; x=1774982154;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gqaVCIHfBSuRumylg8OhQ2BZ16NV+yl0Df89L8kdu6U=;
 b=D5tNikmWBmF/ypwUcUf/2FViBNpxwOWoNS2t7iQSxpC8zLPjL0xP3Gly7Xb9jgTCLj
 W2rPar0VgeFXjczgfU9wt63NfAh/15B7ih/8hN2CikdLnQ8d9vT53nRMkVi/1HmAyzzH
 S5mjIVZDk0xUAFIe/3RBUpK7gQoapKTiq3oeH5Y96dMB0ShHFdeOZf8N302MqE5vw/PP
 ZeK/fXBSu+4mrdrlnRkCWqxE31/UwgJVxUQQvRlvx3DBPmD1eyiv3uFbU7WsdntXo4ZD
 o6DlLMVPK0WHloXWAc6Zfqerul4+jFj/9IcMOtlDjJlVAui2odatpQbJSobW9Fc0M6+q
 Aviw==
X-Gm-Message-State: AOJu0Yxit7iQ4F6pkrkDSIr7hel/mdkIUQrwsoeE8liSf5bAl+e/+kXm
 916FRi0DOBAvXwEH4W45/EGw9QuUfoyLn8yqJcp9X8Jwbz1zaq0R3h2nel6f3sIIl/TYQG0u9Q4
 b+JpYpW8i/Tj41BtzJ/hpNDm5zohBSg8YcT0yJowACZQvm34Ne49o/eg=
X-Gm-Gg: ATEYQzwXVYqJZTy4wOQBQ65qCfc+x6iHFV9DdWySGk0n+bEnejbH/adRN0C4O1bGeqg
 zM+C9VKDLXIVMi4voDBUBEBMjF3n12QYfUQYCdTIM86X7Hjf2YtvZdF6wzJ3UAQGLIm30EfhaY2
 tQfzpuo2qTeMn5kIjdU56CmFzahvxQGcxdnYOcR+YMwejlAbvA+rkcRLyu9s9uqtAixI5Gla/XX
 ef8TwwXMt2VZOPXQeAnXHICRcJ6D54PHOm8Cw1N6I7BR0D4zPy1luPQqf5vtNxJnthBaGc2vJDe
 DwgkW588mxB2qc1fIHHTzfRDpg/FP/C68cQOne2OIq9Q/viNpB84jkG0IsQPPBik6hI=
X-Received: by 2002:a05:690c:d89:b0:79a:4fe4:ff92 with SMTP id
 00721157ae682-79acf3b561emr9080907b3.19.1774377354336; Tue, 24 Mar 2026
 11:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260324151111.237411-1-peter.maydell@linaro.org>
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 18:35:42 +0000
X-Gm-Features: AaiRm50Y3jdQld8UEcMF4y-HtmxsJ8sy0QgzNH8K6uAiiFMEzkWxziweE29QDK4
Message-ID: <CAFEAcA_YwhSc0j3ZOu+pQwhSFs1fWQ1ODmafFfnmvk11N9=Tqw@mail.gmail.com>
Subject: Re: [PULL 00/11] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 24 Mar 2026 at 15:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-24 10:41:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260324
>
> for you to fetch changes up to af35bc0c146ced44f6bfe98587495ae193adcec4:
>
>   qemu-options.hx: Document arm-smmuv3 device's accel properties (2026-03-24 14:02:30 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * linux-user/i386/signal.c: Correct definition of target_fpstate_32
>  * hw/dma/pl080: Fix transfer logic in PL080
>  * hw/arm/smmuv3-accel: Switch to OnOffAuto properties
>  * qemu-options.hx: Document arm-smmuv3 device's accel properties
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

