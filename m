Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE6FED2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0c6j-0006CR-HH; Thu, 12 Mar 2026 05:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0c6R-0006BX-0Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:13:11 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0c6O-0003FZ-9P
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:13:09 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-649278a69c5so763726d50.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773306787; cv=none;
 d=google.com; s=arc-20240605;
 b=QgN0nepjgMkKRu3LSjc298rlbAH/XyCu1StIDIzsjvkyoxGr6b1wAILEGGmTp9R462
 diMAS7v2voZ4ruvnls2IsBSPlTEYKpHB2PMKCmNWyz+vjtYNZXM6dXif32rUZ4qIWcun
 1oYio3+AYl5hVISbmbPROc+EDawoLH5tmWMnLMVY8TsaGN9oa5ZVIXOOW4M2WuXdzJWU
 y6BYlS3Nl80Rr5eir8I1qAmkOYP00aE+wE+//v7k7MXU7wZvkT0CHe692rFPpUa157rT
 0pP0gACtNexb4kwxaoEcYvMCwh6zEJmFUyMlpB8A6REerWg91DZ8P89ayisPCerEKqjd
 dhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gCe4XlwRhzcIv6mM5XeuDVH3HXdR7LmPtkbb/B2PBBg=;
 fh=Req3COAPjP2YtEnamEOk+zxHiedNtWDnwOyOqw7ZC1o=;
 b=Z3ywk9c0z/ShWeoY7GjjrQlXjIgkcZfQTawI5SSR3QnPt/s/lmgLoN/iRrOVNjtWEp
 09rGIFG67x4gGTtJhBDAZv/wQCy8G5yd6WoDp0x91xaetNykvEvLD5IrVfT0+NKnoGlD
 ShU9FbtMkxr9o5cVHCqSFlXtAt2jJwBwoSP6M3Qjmvx2sJZwhUyRqOe6kQ9tYQNZ5ojf
 Xh90wARZq5Y+GekswMJXUHjMGLr18Q8h49v1RbjUlLsGgJceTQ9TIMGUAU62cBHSnfD0
 b61JPHYNKPC/DIs/7Y2IPemd/PhdKK+nYFNrh6Qki4drNq8KpsCAZyk5Xj7ajvoUWRYr
 /T9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773306787; x=1773911587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCe4XlwRhzcIv6mM5XeuDVH3HXdR7LmPtkbb/B2PBBg=;
 b=bKjzJX+oQgXFJI4UPQJkLcxd1LEcsXvXYk9cNrWx/11MjOAtbowTMFVlnKSTEfo8Cj
 ReS5hbSi9BXF7cB+3ulMmtWpF3QeOv298ASRXI9LcMTrh1RYY5Djf12IeR3wET/LgFWi
 PaIM5WRwi4V29NaVd6RCjyTBZgDGpim1vx8n21cTW0FMD3RXoFxkd0VMQu9jy8xhFZVy
 iSTNgd/w16yBkIVxXGr2aRltwMhVDw+LS2OBH3ogIL6Qg8jHKg3gJfzJBRyb9bQ8Zf81
 6W+JGMOxTBp8Y/svGMz1oAB0QeiEa8ph9JyFXEvq0f2d2tmAa94bH6CYdnSAUyijbTA+
 6qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773306787; x=1773911587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gCe4XlwRhzcIv6mM5XeuDVH3HXdR7LmPtkbb/B2PBBg=;
 b=EITyH9Qk/gwDQVKvzNUUJ53aO/ksSvOkRdShL9+dqc6rZ+WEFfqR35Z1RuJ0XP6OyF
 rgE8hMnEEAbgM+n3HfTlrXHNyYUarG3qqU6Tenxhtqz/uvHO64shB3fADNUZ8p+/0y0l
 hs9mOR2x0nOaclt+QQO5RJ/ciwETfltD4irBWgU7/OaZFdDGLn1OS5RFlu2k5v9raycD
 ao5C3YnXktqneXfpungYa41yQLdMXfF1QGdX7+fEq8em9eEFfmFwX3iVj4FQ5/4UvPGv
 PEhpPJRqNMdRnGMBhAxMd0uUmM6WpFYXWXaAlTPl0iFePo8GghqK+sT66fcIHXZ4KrVg
 we0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa0ZxQ6wV9IxHYrV6tbrnaIXfY/KflnVPmu+UVjfEUy4hsXoJa8HDNXwnALwO8SL0g+mwDApbLMXC3@nongnu.org
X-Gm-Message-State: AOJu0Yy1+l4M8Q9O914NDi8DH503V09S/ilNGNOpIUR8msCMmDcEG7Ka
 W1fog2oxhdDPc/7qZwaNclaF7FKGjwNK/o9rfNiM10NpnFc0PwF+yy6ii5e6hTsO7faKze1AmgW
 NLGe7qYhJCFn1QYlV0NhIwL2XAr1VLXC+sc+JUGkPeQ==
X-Gm-Gg: ATEYQzym2p2icvekEpCjhU58DcSRA5WvrMWGELyS5+ymVUoH7pYIt3gAKmE0vTILAkl
 43hNGi8pQ4MuDpf1jY7yNSPEivSkXMpnIq7h3UIzBcqSqW31AbUdAJKChuF5vKqIRhcJmIW8FcE
 vlYnrDOJYFa9RVAhtsdysbsJ8JRA0yPmluy5A45AK9ctVLvdTfJS1t8sEKAzlXZiNd9HbSlRwee
 euHPVTvFMlSo33dZWZ67ljPgRkTbwSkJh9008f9caQS/YxF9l5c26vX382mevQI1mk9fCVT7Gap
 bi+eDZH3WsEcD0wXE+uwaIz+MlyMOMguYof20Nve//Bbk1tIJya1oEdYamZYDnKUo+k=
X-Received: by 2002:a05:690e:1643:b0:64c:f871:6524 with SMTP id
 956f58d0204a3-64d657ec44cmr3746843d50.81.1773306781921; Thu, 12 Mar 2026
 02:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-56-peter.maydell@linaro.org>
 <20260311175456.00007788@huawei.com>
In-Reply-To: <20260311175456.00007788@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 09:12:50 +0000
X-Gm-Features: AaiRm53LXM9KGJ6oRdIwk4XjtNEptJj1W4c8gWw6P6EEoFF4hxT-XAWtnXCi5V8
Message-ID: <CAFEAcA8S3JyKRBkvNBex20M2QQn04CbXMTr-1GriqQzXcQSP2g@mail.gmail.com>
Subject: Re: [PATCH 55/65] hw/arm/virt: Update error message for bad
 gic-version option
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 11 Mar 2026 at 17:55, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 23 Feb 2026 17:02:02 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > As we added different valid gic-version option settings,
> > we forgot to update the hint in the error message produced
> > when the user specifies an invalid value:
> >
> > $ qemu-system-aarch64 -M virt,help | grep gic-version
> >   gic-version=3D<string>   - Set GIC version. Valid values are 2, 3, 4,=
 host and max
> > $ qemu-system-aarch64 -M virt,gic-version=3Dbang
> > qemu-system-aarch64: Invalid gic-version value
> > Valid values are 3, 2, host, max.
> >
> > Update the error string to match the one we use in the help text
> > for the option.
> >
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Ah. I was going to say what is is this doing in here? But I see
> you already sent a pull request with this in it.
>
> All good but for anyone else reading you can skip this one :)

Yeah, it's only in here to avoid a conflict with the next patches
that also adjust this string.

-- PMM

