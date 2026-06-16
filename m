Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F7CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTJv-0002hJ-Be; Tue, 16 Jun 2026 08:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTJk-0002cA-NG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:55:05 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTJj-00059i-Bb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:55:00 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6606678420bso4704645d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614498; cv=none;
 d=google.com; s=arc-20240605;
 b=czvHe0X9qQyXBcU67CsiYsDeOgRbvd5djH/O/l6JufjQiy5hMY4BTL8RFnVHsSj7CQ
 ow7xVHx2mVmU1TiX7yA5pTiobbNcyJ0EV/JPBaXKwoSZgK5wZOwI8BNulpQSdBn3UFZg
 htZumTyBR/h9STcIAjoQibYu+GYP5SxDvD4L0GMiR5UOktEQgD48uSDSGwFzVapxgZt5
 uRbaKJBk+ZyXHgj55eMBcZ1ruFqfNoi70C+b5xdWvKY2g4xskiBumlXfDnqO6iGJjWtl
 6knAen7eGPL8Aq8WgrDEA0Bx25feM1Cac9oZ0tSJKFjSes7qz04HgmHJb19iqWW2vjmA
 T21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k/xvOiSlwvHRre4h1mmO8adGvzPHOl6OR0HPA96PChc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ccCph7QrXw/jkXllRmyn/jIbq0hItXJJw2Ajl4hdecsTNfa6ziB2LfgrqgITI02vPQ
 0+5fXRZMGJJVlOUYiHp9J8D8c/Egme8SeeL3zJ87UXjKWKcJdgSZgrimfCXjBEbmj7go
 J8Cgvg1ami4I0Ld8FnU3lrJ6mreTkNS7JJgwBiTmU9pIKfh2DKrnkTubSHGrdKvC8PT1
 CLFumijAv/VUTomcdLjJT+1rxGzB0TRshzNaRQMmmxU0V+9fEl68M/dD4Si1IiOF5xpN
 d6BxQ6XbXKpslnMJFIdndMQwfTTr2xYnfdO7cOmpa4qrRJ68FK4AFrXHIcLhhHch5enu
 8pAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781614498; x=1782219298; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/xvOiSlwvHRre4h1mmO8adGvzPHOl6OR0HPA96PChc=;
 b=yspSxe/FlQbSqZTZDTOsb7pX2BxM8CbRwh+qMw+phP2NrIK/kXVREOGw8jrPmOwLHy
 zPfbG7NB0eEa9Oni/hNXXW+fD3L5GfdRc0Dz39UiyrZR2EUVsOk17jB+bCNnKJYZZyyn
 xG2Xw4FGI/KXs02OFtL2meREWnlyiN8FmQAJ4UGaittgHVshqH+oYghisRK2kIYXNSI8
 3exBp9oJTUcC3ghP5hHbmMa+4jR2opYabDba8Vh6rCqR2f5ZTSPKLZmY6OCFs7UzApGU
 qHem6MZwjTq1gpIo+eh9V78dMVwN/MsONrI4rlT1axrDtsB1snshNSgsynZvlNduaiTT
 Gr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614498; x=1782219298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/xvOiSlwvHRre4h1mmO8adGvzPHOl6OR0HPA96PChc=;
 b=o+GPtdlA1Bz1yNRjrn+7bAfDuO9We6CMsQHs5GEVL0COpRi1BhJye9C0LWPcN/wPBH
 eG2BRH6e9AgulX+f4ga84NbBT3QEiRuOlq9CG7e1cdS+HBRYP9ByHldT/NBonJX5g68A
 dIDNHukThgbdF+vpDEhUwmIxca8TRvLlRBxF0KN8PTdjoq8+gfw25W09zfaa4fxWpG8a
 X9prSNCOJpgsLZG6oXq3KMQOuJ4l226Wzp9dA8S2Znpm2vNiOAjOvkQVJDz4kLFb7Ng5
 MlPH9N/bsIVtV66O2m/W1zyOJ07vaRTYtSc1yO+31vN7aVLejt/MQ/RWSk6A7IJy26lY
 YsKg==
X-Gm-Message-State: AOJu0Ywb7kH3KnJ9wpXm8NHjgp8VslvC0u4coLKotyJ9FqTilqTlS4Im
 1FNHxQ1rWIlks04GSZjepUSKrS2PvNFbJMUTCLlwHAYjdID8F43o2x5rmN5bd5J8FNKoUl9+b31
 P7PUaCDPKvZ/KavTZuI/pYh8ghAC+shXtf8v+yIciHg==
X-Gm-Gg: Acq92OFuaNMGMaECm/UBqGftdfEzkezeQ48b+gIbVKB28u0+4En6X4ydKfnRBuNK3yG
 9VEQpQ8atuZUE0YSTyE2SRCeaY3Y4X6MDDOD2umYlzasxX4pyzjIB4brqoOyyIvVYMTL2AHCIoR
 QSei23bdV9CrZngqlZAp3ATiW87tmdezlhEdOZtwLZVCWgZExxxG9XbZWz6ZODqfPyPMuhvRF1e
 hYUkXceAvrJ4bnOqdKQt7hjcrAUElMZyjNI9We1SGjHfl6GgcIAEqnQCjPjDTA/znDdS6UebKDh
 Bfc2d95WWihZq54gUvbZ9JvNcO1lDYI8XtdxeMxNxKq+Z74QIcUoWhh4/8PtIR2inhE=
X-Received: by 2002:a05:690e:128a:b0:65e:412c:c4c3 with SMTP id
 956f58d0204a3-662850fd127mr11948499d50.65.1781614498012; Tue, 16 Jun 2026
 05:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-17-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:54:45 +0100
X-Gm-Features: AVVi8Cc9NQbaQxz8iCFMON7Q0cFhzvXgxs4jOa7dFUB5HSSxX1sOe_tzZ9RTQXA
Message-ID: <CAFEAcA8h0kBujpwY85XwbWLXb_5+293uSjQHwVKNwPuoubM+xw@mail.gmail.com>
Subject: Re: [PATCH 16/25] target/arm: Enable zeroing in DO_FCVT{N, L}T macros
 in sve_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use the low bit of simd_data to hold a 'zeroing' bit.
> The simd_data field is currently unused and always 0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

