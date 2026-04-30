Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F2CFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGX-00046A-Ol; Thu, 30 Apr 2026 10:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRUy-0004Xr-ES
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:32:12 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRUw-0002GW-S3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:32:12 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651c7ddf514so862541d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777555929; cv=none;
 d=google.com; s=arc-20240605;
 b=WI1oFy551WDRz2ZeCqbncAiaoeFffKN/5oRyjAjlF6mPfj5tT9B67V/Qwar/xmUJYF
 5KNisKrlea3Haol2dTcTqPot8QULkliO28xlc+OmA1gmVmS8BuuSE5uCFrcZUmgdv8PP
 fOLbsoOW6hHQ8Vqwrrd/y+p9MU+T93aaB7IX8YrBtgckGZ5eH3HGUlMOItmqTuCzvc++
 Yb8bFZd1J4a4M9Pww6xFylwQyyhm+OjunWq0CgFlFwTzmxbFeVW9vVY0AHC6LmGJHhlo
 QRgFgVo9q9XuGzPAV/znbn+ROf41BtUS/mnW74Dq7X3oh0Jek4gI4Ov6YPGSaOiupj+J
 Om7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SZsm9sv+cuNmJqNx0VZNyQGE5jjNo8t94F3ekG9P1x4=;
 fh=zxz4leYHlK8liCTg8IjU8MgvAL+aTbMLdpPccU2byLQ=;
 b=G9YhZs+zro056j8f66eb4A0UW//RIIcP5WwQyvWl6f4Qg2sLiPJ5uw9Bs0W6AmUfR6
 X7oZqdyGeFQDEQGfZ+MGRvQl3tw450tQBzLJYzEZ204MC8iKS9IdBtNm/3daYHsjHffN
 fc56rlk7n1K0TB2hXGHsI3hoep7MguHgtHkKfxUmw5WYn7wK8iWRBcN5MRzyUfzUHetU
 ov6IR++FiMy8ZrD31ydfLVAqM1YGYWw2EDLRvPjJmtZHBNlmYFPvUU6yiV6/IJkwuCM0
 iiyYDQq7qR5mPj91VclrAIuLPo2V9EydT2en5dX7c9r8h9s+LuMHaJW+stgTHzgJIbkY
 khUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777555929; x=1778160729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZsm9sv+cuNmJqNx0VZNyQGE5jjNo8t94F3ekG9P1x4=;
 b=AztCJw2VoMDCpvodYsYQlVDGQJvfrlehCR0XJki0JfmtlvlJjqYkl6/pmmD3FtNbBP
 wNEZ2KkkjFT0Ano088ZEaCyrhH9b9gh+U7XkF2OUgND4bbqTr6Z4dLQGSaHwY/Iaf9f1
 y1kysyBxrQt3Dj8eiNZTBmJuN0oYTqWzmy/E+2yP6gvdao+vP0ZZnJHd9bgelbL0Il2b
 YGVDxSsTLSj46k2mE/FQU9xQvVDggkTlwz15IhUGoBeG5TYcfLM3RvcBppKZdIlcXhnG
 XwbKOiEZdnokH85qcmDvwT2V/RzMreBEyOXRUjrhD4p1ievLvUzUjsqRnkqPbCcCLMsC
 A/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555929; x=1778160729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SZsm9sv+cuNmJqNx0VZNyQGE5jjNo8t94F3ekG9P1x4=;
 b=f0pWaKssnKAZjSC2st722OnVzPiPjsC6KryTyK5TAq5vqz/waFDzATsKHgirZaMZeb
 PPCMeFtBoPo8MJGvcolOTuAk6vJWhhphAw7iLU6SRCIbZTL0AqeFR6nkIpQtFNzCyJjG
 9C6FswWG5qmOqHTUYRFubSRxWcXzpoaiR1vMz34JpikevKkB3hb5uM180SwnGf6LjlJt
 wSmlokLDR3JzhJ2lkLg5lfdji3HODJal7rdmCrmpjKGzqO/gDFtkbeCPYHzq+1yrGS9K
 JFHztucWupKbY/dzA6bUU3m+3SonYAgQnW6zd88R43gB6Vdy9+z24LUGKPEtTR8H+rFl
 2f+A==
X-Gm-Message-State: AOJu0YxEKjUl/S0nGT1viTNuAeK2cMSXD1zNM9ABX+UJVVDVTIpw42tn
 mOFZFblgquFk4FN6lROFxrQXAz83TV1NxsHDoopLL1N3eJXw5lw14OXosobTEjOHozSLfwdej+g
 eOnq0Fe2aUrjax9MU6wSZaYffS04ycdnnMQqfmMpwNQ==
X-Gm-Gg: AeBDietq7mgZKjpE12bF/u1XWeL9zNjk/LNK5Dj0SbAv6XkO1t2T9O6N2XpMNGbfJa0
 xRgD9YspgkdkLQ72LUItbcbhlz8SFDFT5sh7l6vQgK3MpAW4arA5n3x4LX9HRFoDPgkB09K7ESl
 WcMxCvD7PpliR/LluUq4Vhxz07o9RZWU8xulzyzPg5s7MkTwwVn9+dSBYTM05t+1Yc4ndL5J1oJ
 PV1ehc9c8L9WlOgGp6LT3CckEfDdnSQ8YNiM+jzMYkdGfIevQ5U3ZjbqajdIcFI5xvC+rPJWSZb
 HFv9xirgRNFzEc7o9qQPn4nnN9QHRh1XGFF27Cv+IoQ0mZcfvIi3G2qPnjfYwnkhHAt/cL6tK2R
 n+w==
X-Received: by 2002:a05:690e:140d:b0:65c:2a49:883c with SMTP id
 956f58d0204a3-65c2a499a16mr170676d50.29.1777555928737; Thu, 30 Apr 2026
 06:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260309152617.1611566-1-peter.maydell@linaro.org>
 <87fr69ge53.fsf@draig.linaro.org>
 <CAFEAcA-JEtwT_AkKHQCOgvRjkAwcO3rAZjv7_4rdpkyQHEQGVw@mail.gmail.com>
 <87bjf0egr8.fsf@draig.linaro.org>
In-Reply-To: <87bjf0egr8.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 14:31:56 +0100
X-Gm-Features: AVHnY4K6Uu8L7RTbG4J4nMclQ457gfN7B-lKCoa2O24wiMeXTYd61JvBkS89tw0
Message-ID: <CAFEAcA_RGBNmOw_Xx-Z3_DVTG75wAc6diyWV0n__XxObEUXBEA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/decodetree: Fix formatting in "field examples"
 table
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
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

On Thu, 30 Apr 2026 at 14:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 9 Mar 2026 at 16:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>
> >> > The rST syntax for a table uses ASCII art to draw the cell
> >> > boundaries; then inside each cell the text is treated as a body
> >> > element, so it is rendered the same way as text at the top level of =
a
> >> > document.
> >> >
> >> > The "field examples" table was assuming a "literal document" format
> >> > for its cell bodies; this meant that the single line cells were bein=
g
> >> > rendered in plain text, not a fixed width font, and the multi line
> >> > cells were rendered as definition-lists because of their "second and
> >> > subsequent lines are indented" layout.
> >> >
> >> > Fix this by consistently using inline-code markup for the left colum=
n
> >> > and literal blocks for the right column.  (We want to be consistent
> >> > within each column because a literal block renders differently to
> >> > inline-code, with a green background.)

>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks; I'll take this patch via target-arm.next.

-- PMM

