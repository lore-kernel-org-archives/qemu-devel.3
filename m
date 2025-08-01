Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72559C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvWn-0004h6-Hr; Fri, 01 Aug 2025 15:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtqw-0004Xo-Cq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:47:35 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtqt-00074f-Cv
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:47:34 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8fe5f3f340so662118276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070450; x=1754675250; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHjvHN1KoTwv3RCy1P0EZgYBRv6dk4Pow83QhM9+dRI=;
 b=sWFF3Pftyna8KK7E18H+5E4TIFi1Sb6XJNzeSV/ChTGRyLzE9icKH6qR4y1fltp80c
 qF5rk83VRqx6OIk0RVS2XkhirYOCgGiF0ilO37i5vb2Vw5UBsgaei0qzAHEirBALwCy/
 gLWzUl7vfhVdOBDj/n/V3esOGz1KcigVDfTUxeyIqpHt2rldHjThR6FnKtrVEet0gpl+
 W/jWPTbqOwzBVc7n6JJcsDh3pgzXiVy19pSxIsG90nenptZp+Gp7KwHwEk5xjUV003e6
 9+Q65NX6Mibh05VTr72bNK1qfx+GMrcaV0oBJCFsUf1Es9/A7cMQMXmb2hrDhZ6sa0f3
 5kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070450; x=1754675250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHjvHN1KoTwv3RCy1P0EZgYBRv6dk4Pow83QhM9+dRI=;
 b=nWyNUBgsIarFwTff0ChOyaIgAbv5SWByGfEI5IKGoK9dHMoCrdlOohFS7hilxmgHdu
 1IgDDThc8CziYXllDJwTYOUNJxJzJN0pe934e7zU5oy6PEdJvNcNxZAinD4MoUGE11q2
 a2OORIa+c4yWzKWouJWGNodCQ9tJtJfkchIOyXUVp6eLhQGp2pRpKm71+VHuOqNwTGFE
 T7mCkVjNq1ZZg4z1E0B7CyVb6xt39fnIBjZ4gatQgrZ9ZevhHoGXUBQoJBv1u2ZqSZ9/
 9JezkYyro4p8qTzDH2mBK0B3ZH9xQBnuX9yJ0ihDkvrbkfyX/8nsK4EzXIpMmpmGrye+
 crvw==
X-Gm-Message-State: AOJu0YxEBEQoI1ghEVpW2Smrngk9jG1p5F62RGRKu8rF8njjB5A5upph
 4qHM1AbJovglT60em+aFcZJ3IAjM/ofE36mCCwTWG7exv0qyErQe7BLQISMoflgP0RTVG5cro1L
 kRr+MG75/dvC/ApsxK6X7qT6ymQELlMBJ5tWauHC/tg==
X-Gm-Gg: ASbGnctw9/5Jkn7akzyWbxSIGPMTvpEnrI7FzzZgpvPhPgH7ChfYkunus/oKbxGHVnt
 OK12uhK8VX43LkxjtbEBwrvP1uTWx6VxsVpGR4rVlwwiQ+450jqu7utMmoIGmpRFJ1J7pdZIVhL
 6MD4hD+2qR3baMig9J1N2NsdZQi8kiWn9gwZF55vQJ77taOvaj6lEO9Yo9kPq6nFHngOcAt8VBd
 378/PR3G9mfinu/KGg=
X-Google-Smtp-Source: AGHT+IErBe4G0d5R8nXhHAl2n4M37Z2vG/k4ceQG9kKLgByUlhLWEN7RVaMbPM4B37hYlmeNlbCFbEVyRpW09j21weM=
X-Received: by 2002:a05:690c:660f:b0:71a:231b:d046 with SMTP id
 00721157ae682-71b5a6e54fbmr94047457b3.2.1754070450208; Fri, 01 Aug 2025
 10:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-47-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:47:18 +0100
X-Gm-Features: Ac12FXwkqoWDwwstt-_YOuwXUkFlqGwllvjtyxV1LhbVXWaMNYrnmt4kx8-Gg_8
Message-ID: <CAFEAcA8vvy=6zuz38MDBE2xynNd7kVhQwCWH4kgbgCWp1PwN7Q@mail.gmail.com>
Subject: Re: [PATCH 46/89] linux-user/loongarch64: Split out
 target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                         | 26 +-------------------
>  linux-user/loongarch64/target_coredump.c.inc | 24 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 25 deletions(-)
>  create mode 100644 linux-user/loongarch64/target_coredump.c.inc
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

