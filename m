Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE961CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvFG-0004hs-6U; Thu, 23 Oct 2025 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBvFA-0004bp-KZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:20:40 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBvF6-0000JF-HZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:20:40 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-780fe73e337so9511777b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761225632; x=1761830432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A3FzDEyzs3oIzdo1sHZ1zaOOylyyN+QlFa5tJS2x7Po=;
 b=h/HrD7OCs4LcLRiQXNTubUo5HiHKie3uajUoCiq558KWLPRLLMwqJ6GvwRLd/+7sHf
 v9tqpCvSi3Ha90WBqjjNPnngjeOpd8ey4lPwrcmmonut5w4t04T7VZF5j/xkfPLth7v3
 zvnlQyhHIGm83SISNbja0fF4WlI3hnfgDbX9xSOvTWV/U2LxwOgTmu6gRZnzcrfaAOU+
 JqSLJe5sFFPkQ3m0ZIZkA4qv7S+Y1XcmEA6IGOfItI2tMr79j0cvQlEkl59OTISrwMDU
 xSyGvXl7+6Z0Ap74mRNVwz3wfmnmtW4tjpc7ImFFlTx6V6SknTwsXqwEecUuy4KQfx1j
 OOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761225632; x=1761830432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A3FzDEyzs3oIzdo1sHZ1zaOOylyyN+QlFa5tJS2x7Po=;
 b=HlGEd3TQExZD79Pya5O8xYp1y5XcldVevWxxVKQ6lsemDfuCKeURI2wnGxlHybmDfN
 xpps+y5R0K5XgfKA5KT4yGsgv/L7FFrrEeLYUox+VvHLIpVZPqRZbTwQAKwDw1VSBcmX
 L5sqN3zRWoFz1E8lCmAlMMi46z7Y0D/qNgYzjiytcyJU3eNcUQQC6RhkUwALNWgM2gS8
 eRK4nv8S5k7FvXLQI9POFVrb4LSQloDIgD67JB8Q6wSCnEnsQw/WibQ8mNE2rD+Wom+u
 79NhTvY99VWIEys9i7oKYLwCgeIDgTexesSug0cMcu4JKvLT8UAqXIw2WJ0cJLsZ9o6S
 wFTQ==
X-Gm-Message-State: AOJu0YxnL3gnZigLHeqAufhy8J4pWl95CciGzoZgFVwbNgNQ0j09rCTZ
 Q/LvV/x4KHGJ0KvFtUdmzq0HS4aDZ8q0MYROaYB1gcuuig3zYmkK8yi0RnaKHbTO2vd7PpIfJzu
 YUnP/xfK4fSIgWBLV5cAqR2AfZw2yeNVSkur6RJkGa3oJCBg4WYqe
X-Gm-Gg: ASbGncuDI75NtaI4K9p2OuE2YmIhB63HKhVFp4dDF3Lw7Wu2P+Z0JkRa9WGO80RdW+G
 Jb/Bqgmyyd2WStifkMXmTB0qLtZqsCar/u5t4zIV/uq8KWC+H0PUn/C+d48zbmkfOVvtE+Vgb67
 Ha1w/GkBUw8vJ0bhIjQEtwWBlvRNd/ILOLFVxDoCI1PtKcbuPKxrkW39pXNXIMY2o5wYPnGrlfq
 VUKD66e0oj9aRsB5J33joMXvT/bUcxwtjT/3mF98DThI1NOWZJYYFWzT582KO6KC/YLhqdA
X-Google-Smtp-Source: AGHT+IF5vIwPAF1qwxSbNGyrW9JtWEIByHrCOKOSX15++wk0eWEVe30Y7YGSyNMjqEpyfJOe7UoMeL9E8mGXgF+eQZY=
X-Received: by 2002:a53:ee05:0:b0:63e:30e1:4429 with SMTP id
 956f58d0204a3-63f378a4c93mr1455225d50.38.1761225632028; Thu, 23 Oct 2025
 06:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251002125446.2500179-1-peter.maydell@linaro.org>
In-Reply-To: <20251002125446.2500179-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 14:20:19 +0100
X-Gm-Features: AS18NWALtTPkMGP5RZJlKcEWIMOxnCiD1XrQ4GdAYyDu5f5xnG3pAof-CHa4zwc
Message-ID: <CAFEAcA_gQXgUJukHJt9RhOHK34SwtnoPf2PYgnMjrLWfFqhw0w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark VHDX block driver as "Odd Fixes"
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jeff Cody <codyprime@gmail.com>
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

Ping -- would a block layer maintainer like to pick this up?

thanks
-- PMM

On Thu, 2 Oct 2025 at 13:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In 2018 (in commit 5f5246b6b) Jeff Cody stepped down as block
> maintainer, but left himself as maintainer for VHDX and with a status
> of "Supported", with the rationale:
>
>     For VHDX, added my personal email address as a maintainer, as I can
>     answer questions or send the occassional bug fix.  Leaving it as
>     'Supported', instead of 'Odd Fixes', because I think the rest of the
>     block layer maintainers and developers will upkeep it as well, if
>     needed.
>
> However, today the way we treat subsystems which are only maintained
> under the general umbrella of a wider system is usually to mark them
> as "Odd Fixes".  The vhdx.c code has had no commits which aren't a
> part of more general refactoring changes since 2020, and Jeff himself
> hasn't been active on qemu-devel since 2018, so this seems also to be
> how we've handled the code in practice.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> (Jeff, I've left your email in under the M: line, but we could remove
> it if you'd prefer.)
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 406cef88f0c..a3a1ce5cc61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4043,7 +4043,7 @@ F: block/rbd.c
>  VHDX
>  M: Jeff Cody <codyprime@gmail.com>
>  L: qemu-block@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: block/vhdx*
>
>  VDI
> --
> 2.43.0

