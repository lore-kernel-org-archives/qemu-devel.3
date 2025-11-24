Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D1CCFD340
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 17:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNa1w-0008HA-KB; Mon, 24 Nov 2025 12:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNa12-0006OT-BT
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:06:17 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNa0z-00045K-KD
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:06:15 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-787ff3f462bso55890427b3.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 09:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764003958; x=1764608758; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMcfu2h4bevoj0RykyRrAeEPkRNFg8Ac4Sz94eecfzo=;
 b=SVrFK/Q++cUGqeMuGenQWmyLnfvYl/FcMMuPKcZWuJDm+mnFtprM6q9Fc5dj+G+Tey
 StaNvRWJZJw5eg7WBDkkiBGU5oYknwefJq5xDsLN4Co7NW1DUzcNRn+R1yXEeLGpvsM9
 Xm3TivUTjN9ixmFnSfZxZWPzIMiWG+5kYB8c41gSCWSEsSggmpXgY+qfPtWDCGnH9kiw
 idPM7Ew2JWtwmAo5Q9u9N4S3zgp0C29RAin5SJ8ZivJoe10k8Dm/92ZVIqsCpZsIg0qI
 OnIwTQrQKefffx/7P8XAbJHcJDeLP3xopyLMuUJXCH6rvmfOPOdcpqfQBAzrYEVILnXB
 lA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764003958; x=1764608758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMcfu2h4bevoj0RykyRrAeEPkRNFg8Ac4Sz94eecfzo=;
 b=VkHQ6Go766oCfDT7DbTarZrx7FsdZwE5CS1vb5SCdNRpVBy3AtsRs8zCxBZmqRNrnG
 6ZaXIRO4MfK3MxTnj+JGz+VztmeKSpinBT45HRuAObdFrt/tIHXJUl3AHFfBbKF4B3ET
 PGEt8Hkl796oK5O4VbHrBVb+v95zGaTpWMv2oj5h5jib7uZUGQuxvSR2SrmYudhgD56S
 S7veiWmdEZNHnEnpbSQAoxzeeJH2aHF6MyUqPAmfhCvW6lfmIY7Ow8gYCedgKwlfFIrv
 EWqXDxLR8ess4hM0n2/IgSJ9k9teKqKwYim/+61Jm5piQuWkoIYvsz2gUIvM6pjgScS8
 LfRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxjSgME2w1cWrdYMhAMl/t4furADW9TGcuTCdqoJqnpIToHzBiyp1JBXqigDOSeS+UwnuN0HHhxEeR@nongnu.org
X-Gm-Message-State: AOJu0YzUhs5a3Wss39qADPND1aR5o2X0L2M+cU0EmpoTukpsHMldhHyU
 2OMxBl/uz3vBc44h/ToSAMQSXjFWU1vh5ZGT5KlZpstkluqh40HQv+SQIeeq0QGWNrCtH09AA1J
 wPZs/bho209c8Wtx4dWtWKX7qG/unPLVm9Qn/lYQktw==
X-Gm-Gg: ASbGnctjzSOzlgKTSJelC98TUQmgV+FlfzRc79aG2wzvS+3Vg4Fz0pWXUotymV7ySDG
 yGB6z7UijJosirSs7wASCHCnflbkKcf4JLcuzwxzzXxIXLY/6gXgvGmBt8GxeegZeWjFJDNA6wF
 7+NdZPSW0ftftfikqcigWX9qv+yWzBCdavcf3aG3SrGB55qzhIOdbwOzbxOplndbhbb1QTIdSPF
 zXqaNkNIs/tGln07YfO+cCkacWe6DzidZ6SxIhtfigrV5zO1zUATUUgVEaU1adXWjwI3GIx
X-Google-Smtp-Source: AGHT+IGrNE0mNX8XVsAvxmQmsLaqA/mtdbfwCV2rh+VjNztxXWWD3xBgac4yGK2A7BNesdMUOKTfEJzYNSXnmeUPUuw=
X-Received: by 2002:a53:d005:0:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-642f8e430c1mr16487535d50.33.1764003958498; Mon, 24 Nov 2025
 09:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
 <20251111102836.212535-2-corvin.koehne@gmail.com>
 <9bc047f0-1122-4381-ab5a-01878a10297e@linaro.org>
In-Reply-To: <9bc047f0-1122-4381-ab5a-01878a10297e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 17:05:46 +0000
X-Gm-Features: AWmQ_bnx4AQTpBZhl2nOLh-u7rfw-4-PkC72NCq7FkZ1J5z1JYlvd3GM705Aya8
Message-ID: <CAFEAcA_UHmXA5HGmvYEucxXX8uiQbHK9-_t7R7EDrxvsxcMmyQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] hw/timer: Make frequency configurable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>, 
 qemu-devel@nongnu.org, =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 12 Nov 2025 at 11:24, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Yannick, Corvin.
>
> On 11/11/25 11:28, Corvin K=C3=B6hne wrote:
> > From: YannickV <Y.Vossen@beckhoff.com>
> >
> > The a9 global timer and arm mp timers rely on the PERIPHCLK as
> > their clock source. The current implementation does not take
> > that into account. That causes problems for applications assuming
> > other frequencies than 1 GHz.
>
> This change makes sense, but IMHO we should model the source as a
> Clock object (see docs/devel/clocks.rst).

I agree that would be the modern and cleaner way to do this,
but I said in review on an earlier version of this series
that I wasn't going to insist on that:

https://lore.kernel.org/qemu-devel/CAFEAcA8opzjChTA7UONEPtrUnQ-xayoMgxH5gK9=
Bi-_VnMXjUQ@mail.gmail.com/

thanks
-- PMM

