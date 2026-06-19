Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE9CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZLj-00088P-0w; Fri, 19 Jun 2026 09:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZLg-00083t-L5
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:33:32 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZLe-0004Jr-32
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:33:32 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-662fa4a4470so1450515d50.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781876008; cv=none;
 d=google.com; s=arc-20240605;
 b=KaO8JnDKZDq/VPiu8cDyduaoQKtPjvJHMtK2gqkAsv1a5XcGHLxIPv3Sin0ybV909L
 REVN/nAEU3hqRX7NFUsNN4l4ZDZrobyYmdqkgANLCVjb+1ZFMuk7URWekyAxgXzOrr7f
 UoqFxRJn+npYWPIsH88mL7cwHTQPC+sl6WVjuqQkP+O1Fe1P3ygxrOM6oJQ5+yppYx6i
 PS/+3iw7kFUIzZXaOIEFOXqtiaWpmYu6qy+l3k7hh+kcaTtt3agk3/UAIgXgN0AJDezJ
 r0Q+jzZSmOlukYjnqeeRm562Tc/DL70DJVZaL4xq6LJnCkoLFTSKKgdmVxsl3iXEk38x
 mzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nn+EQsgoSzTw5w+961jb6+lbuHvg7FauP87mFpheBP4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=UnkEdWstqc2vmsFB0dZ5Q5Kdb15FPcS4gTQgWT4C4cawBn/URwvytrltO/UKqEDgcF
 0YrV3fjjIbe+70DW/Bd/YsVKiR9gi+Tf7NuJZEaQAdtm83+XmiVxI20MoJDqSm0FYCzy
 GtWhgovpnbsBk/0zoqu3sfV3KDXtnf1M6iTuqg174bsFp8zaZ5OLhCuZT9Igl+BSOHbm
 UIQZXgD+3xGIT10/cjWE8BGRekw6SkzIy0aQitKOg9EzVcF1dkxr9hxA7TZzcZsuDAS6
 Pg0qjkbqiDutTrIXBYfdMZtIoDn+aWYxgClBHw+23ROYDjmZT+Cs/8Re2sq27l3zkZln
 sAnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781876008; x=1782480808; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nn+EQsgoSzTw5w+961jb6+lbuHvg7FauP87mFpheBP4=;
 b=zOWukc361y/ZjslURwC0gDVuQ/VUQ8oXEEkUGusrhwhxkO80JN3WsWvbhEYxMZO3ew
 xreKCzcmdXttwGiqpRUeuzZ248eTtELSRFqJf3QpSP4sizZJ5DSfF2MVzFDA7oLxzCwN
 RIbm7rBeNSamYYCMY5h+DK8Rcf/mvVyTi02x1KvkadtIvUC0PDIHIB3bNOL9g0Ygu7ln
 3VKw/qL6zt7A32P9X1rrfQUm0djEWekkaeQetYWFHCeA6ceKLfXD1nBzYTHIU9yrj6bb
 FyQvbkOFYc60giq/VvorD3Py9sevBSR4P3Ic5sIYX0fs0gvmh5fG7Kv0HVoX7vq+A1oQ
 nXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781876008; x=1782480808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nn+EQsgoSzTw5w+961jb6+lbuHvg7FauP87mFpheBP4=;
 b=OG5hgFZ/GSRMKTebTQ66KSChyqBuEIJ2rpefr74QerBPMitJu4yKQYbvui6BaBHC6G
 CuC0gI8qY4sCy5YAko+AN0cBckJ+1PG7wxA+AoXFhCfk2IJ5oTfg2sn5cbk8+9NQXdVT
 aK8S+H9MaTkBtKFgGYKoMl/Z2kn6Y6uWimuMSfK9DDtc01QtZOIs5W+3esX7s/QdNt7e
 DcfDG/B6hPY7raidAg4dCM5VHf5t5dX3N/ZmUeLhgJi0rkhcblgX/ZWR+DBnsRxMQTEG
 hWQKNfIX90fLQgInJebubSGuW7lhEeFyW2btSTAFnp6YUb3vlgNG7aBPwK3pCjiul5hL
 jjqg==
X-Gm-Message-State: AOJu0Yx4BZ90itHmf8XoI+Y79Qr5cEgBVlZFl+XhAYr7vAE7/0AJEss2
 ZdTdsabHliLbKcxvGAsOW7VD4gkmdG1NkUs91PeIjf6teh/VsOt3796LfKY82s+1WQS5rSYEK1P
 w4XG08RFFsm6Py70hCTSv+3TcxVGhCSWeHv+L6DibnubFI7yAsAc9
X-Gm-Gg: AfdE7clJJk+UCUJfEF5HvSWjk/EbWClZEILo69UuE5I02QGv7K6ethcLbNb2U0nVJJm
 uAFaRL7Df2rUPv0TDIIDHYAuM+gpIy85uaOkd5BfjFCMWEeiweCgg1Hv8aGJ9CZhsHWf4BETTpS
 pDeHFVeaZNcRZlqZ667p6NJlt7s6DmEeKlO7Pf6lMq0wO0SkZT4el/kjqIFswSoYvTpWodm9Ry9
 ApV3lk0rJOrkPWAQIXIKFMxiUyu060PqAjSMvrqqxX/gO29QxltcwEzf87TAxOt3dA+KI91QjOZ
 iZBUrNbjNQlImTLUR7ebJObbXW5Bp+FUiHMc3bzQ5elQm/u/IdtRg/36
X-Received: by 2002:a05:690e:e83:b0:660:62e5:92c9 with SMTP id
 956f58d0204a3-662fccd3261mr4313947d50.63.1781876007233; Fri, 19 Jun 2026
 06:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-6-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:33:15 +0100
X-Gm-Features: AVVi8CdaW9p9A0UWgM2lxZHQN18suuRaBg__cTEiT6qcpfUunOCj-Jemb6i28P4
Message-ID: <CAFEAcA_wh1mC_bFU15m4B_aJriBqKbrCfpXxOXYj74Oy=53NCQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] target/arm: Implement FMLALL (multiple and indexed
 vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 18 Jun 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 4 ++++
>  target/arm/tcg/sme.decode      | 4 ++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

