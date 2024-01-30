Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F953C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlZ2-0007mQ-6X; Tue, 30 Jan 2024 05:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlXB-0006dX-B9
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:40:05 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlX7-0001eK-TV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:40:04 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5111c7d40deso626364e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706611198; x=1707215998; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N6xPtdhYES2zrVNypPVXd7V6IeHTx/+UEgN/593+D84=;
 b=q1WsVgUgNPglIWwy6j9qs9Ytb5gT0gufW4/rPZrN64+ZV12fSVdI7+i/5LGr2xGuPi
 HTlN1XrTDtlhK37ixwYPgKL5BCl7eB5mudrnshUNCPLRPVVImzCvp9m6WPNeY+NEWQe9
 c5IgpSrgyhCA6oGUlgaZeyWK1bJ+18zFcmvYXgPFCl+dy6cYcOlYzmzEvgdrNvkc+GP5
 5xaBAwAv5CeWKxUZ/oFWbSJYVAXk1vH563/lMhS+mOgkoQO6yhHAI2wKXLpd+FUdQwpe
 Tksz5HZbSv0pe8ZKP0No5jsTA6hzGU+MO6OGWkSvkGpDtvATYyecPDWfgtxiXfLwyAvU
 rCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706611198; x=1707215998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6xPtdhYES2zrVNypPVXd7V6IeHTx/+UEgN/593+D84=;
 b=MHPeiTjuonRblLkUmierUut8VLs4O+pdyRcLscTthl5iiGM0r8g+PxKEA1EssfJPXj
 d9k4c0WW0GrTvOKenpK/fDUqEHVArXTufXLqWyzw1RuVnlfGmCKM1u55XlbRyYtLvhm6
 dXWWeIxEEjtAu1w9zqyX0Mkmqpp8nQjdU5Fp6MAUGWkFJjsCfY2jlVNqUrvVxWbOyaZp
 9uFrclL6EwV4KnT9KB1DdR2Z2d+8XE5Lz9ZxGU8PKACYxF1TXE8rc9m1gO/NcOIc6UWM
 ZtDS2SS7t24lcDy5Gfw7/9tbZn5+nITQT4RVDPiHHfl616SXlAqzkzq63OPEIJIbmoh9
 matg==
X-Gm-Message-State: AOJu0YyLPngTHMvHgF0i4+71DAwd7PX1/DhaFcxjqzqV4f4N/Q4HCQXL
 +VV3TOpPGbxCJvT+FXZ7He1griXVoaHirDN1/FcfONVSPSr8aRQZ1UdQ6zr9FcP8dCXnGkMNUkX
 HSk0Dy8ngPvIMGxcoxCFyCVQyUzHUGFdahh1kbg==
X-Google-Smtp-Source: AGHT+IGTQBvjVzyskbESaWwiqHTbAM6NkbmIyK1YW6z2T5970V8EYDtUwi0et8fey4aHUa0r2qCnzVIw2lhdvbraANE=
X-Received: by 2002:a19:6558:0:b0:50e:4e6b:9cd7 with SMTP id
 c24-20020a196558000000b0050e4e6b9cd7mr5282225lfj.12.1706611198073; Tue, 30
 Jan 2024 02:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
In-Reply-To: <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Jan 2024 12:39:42 +0200
Message-ID: <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > Check if a file argument is a cover letter patch produced by
> > git-format-patch --cover-letter; It is initialized with subject suffix "
> > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> > exist, warn the user.
>
> FWIW, as far as I can see from my email archive, this particular
> mistake has been made by contributors to qemu-devel perhaps
> half a dozen times at most in the last decade...
>
> thanks
> -- PMM

Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields about
170 results including these patches.

https://lore.kernel.org/qemu-devel/?q=b%3A%22BLURB+HERE%22

