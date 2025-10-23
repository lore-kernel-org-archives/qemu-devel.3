Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C5DCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuWr-0000AB-AE; Thu, 23 Oct 2025 08:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBuSu-0002wp-R5
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:30:50 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBuOt-0007kd-Oj
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:26:41 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-781014f4e12so8853617b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761222397; x=1761827197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lln/eupkPghiN4WMdu5B7GSpVCzOPMvVzfobpx6m6ms=;
 b=SnQFH+KBPYNSFaOJ8/Ae3B/DStEfoyBYW3g9TT6YBwjgLSKpXOgvJfC1j57l9zberl
 SK2tOnZ5UwndLde2AH7FwUwAfOtist91yGfaZpQLe5BSZz+SiVRuDE+mNa/EZ+hW/zUK
 /84IUk0Ri+2ck21ErhQEVG+B/YMqbN3yH2qNBnyUp5hz1gdwVjGCuJVVFOmfUffODhOa
 APoeR/syy6SXjFpIX15dGwiRDVSGgLs+KIemAjBuggxdS3aiR1TMKirylXjLC/KyjbRg
 DBfocxvn+LtWpEUK051F1eHY85MOhq//bMUKLzmcSmVSysWQ2kBq8RjUmx/fanTUQuG3
 CwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222397; x=1761827197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lln/eupkPghiN4WMdu5B7GSpVCzOPMvVzfobpx6m6ms=;
 b=WYKx64iDUeRezUnvU1XVGFTJPUfBss7YuTUmuu8LLv/8IdM4j+54DkDaxNI7H5sZLX
 6eDlbspDdP6LXOZtjEomc2ys8UKHGiEygaJKDHsd0BbNdw3gXR/7q7jDxQQTbw2MWJ3k
 ZhHtN+Vj1QlK+s+a9rIAdF+aYmxnV1LyDxKZxwPQG2TXhacugGguPSJsslQa4o2EeuRK
 kSyr5QdW/BakbjElomQCislnHnZOxxuCxd+1TKN87Xz2lReGdZoSXsszITmQRcK27M4f
 vP4CPgTd4fNC3iwwGINoujXgUv1NNSm7HFlV4ri5l6FzjbIFIhgBg0BFhUqaaoiK3sbK
 GzIw==
X-Gm-Message-State: AOJu0YwuIkSDgDt3FXOTrAwhqtzMrK2BN4kAPyhhtjdXvvWe3Mzjw+NU
 y9s8qOzy+21ItEHoABZikqR/kf6jHK6TcLZIdb61Q6XIVXlvYUIUtytknmzmRkuHffCse7wqHvj
 ZCxrKBZUDYs6sPpojpdWYM81h/TiIxlc0RU80Lx4eDw==
X-Gm-Gg: ASbGncvzxptmw3t7C5857fy7mMnOyoK6VJVcywNX69MPPkTM8Fd7tlKKWVst2Pj8ZS1
 H+xT7Ra1kQG1ZEx5I2MapFl0K9HWRdu4CfR5DMjtjZEt3nQpTmD9J1FaAdTqhG7tgId7BaTiffO
 PanFyts8ByU+m3g54UalwtrEspLuJsO37C5BI0G4+X/+9Y6MWXT2Q94uDO3fFxO/UfT3gxkLVEE
 fZzONMGZCzgfFBUk0QN05qtQVhWFsFpWAgBqeM/+eegvVpCT1KcYoFBixWkmA==
X-Google-Smtp-Source: AGHT+IHyz8nwl79aDkaY6MfGb1SlWgdpWUyEblw8X6InkI6RTeeC1YnXsWgOalcPRtFcQT/yGEu8v+rjYSYBGELMWuI=
X-Received: by 2002:a05:690c:e05:b0:781:64f:3139 with SMTP id
 00721157ae682-7836d376dc7mr225073807b3.55.1761222397485; Thu, 23 Oct 2025
 05:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
 <CAFEAcA9+oSu+z_Jgm6dK6hVdTYf=NyGrD_cOF--+j=uOZJD8rg@mail.gmail.com>
In-Reply-To: <CAFEAcA9+oSu+z_Jgm6dK6hVdTYf=NyGrD_cOF--+j=uOZJD8rg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 13:26:25 +0100
X-Gm-Features: AS18NWDkEHHtnNfKKd282nDK8KSI7Z0dGu-BotSmcBjuH1lgg-FoCwbo6B-w1rQ
Message-ID: <CAFEAcA9AyisijV=a4w8yD=dnYM-iW4e=Huqx-X9J16--ULBdJA@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] hw/arm: add Beckhoff CX7200 board
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 23 Oct 2025 at 13:25, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 15 Oct 2025 at 10:17, Corvin K=C3=B6hne <corvin.koehne@gmail.com>=
 wrote:
> >
> > From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> >
> > Hi,
> >
> > Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> > platform. This commit series adds the Beckhoff CX7200 as new board vari=
ant to
> > QEMU.
>
> Did you base this on current master? beckhoff_ccat.c tries
> to include "exec/address-spaces.h", which hasn't existed since
> commit dfc56946a7005 renamed it to system/address-spaces.h
> back in March, so it doesn't compile...

Similarly for references to exec/memory.h.

Please rebase this on current head-of-git, make sure it
compiles and passes 'make check' and 'make check-functional',
and then resend it.

thanks
-- PMM

