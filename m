Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF78FF55139
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 13:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzE6q-00046h-Hf; Sun, 08 Mar 2026 09:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzE6o-000469-DO
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 09:23:50 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzE6m-0006TT-Tz
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 09:23:50 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca09f2170so11065069d50.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 06:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772976228; cv=none;
 d=google.com; s=arc-20240605;
 b=BMotiyqyBYsOlI72p506E5e8W/w4nVFYwXPvfQMYn4txbsHBlmG2CZNLHW81m+qACe
 FDMrZG9rY9PX5+HJdfAuUe3J48YkkFrqqXN0NVe7xghr+4ABQKv5R1PGPdEGQloMtXir
 Fi8ZGuh6fTUlxt7Ke7PkTvY6OWSIPYUXMg5Jxr6IYx+n/vwTWkCg5Sthz9ckSxi9+Ohn
 Ky/6hXgKmIBufALMC5VIFBKuYs+s67o2NySYCI6jSRHZFFVOHWECvPG7nbbEtZGOpp/3
 s+64NoCd5PrWjgZXIOQl4WITlY2nhewdAKjPT51GrKP3zIUwTdL8Uh00RwigY9sVxl7U
 urRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7Ue3LsFQh17Kvq877swpldBZjGKRzS/K2OgAAzBlKpw=;
 fh=bOjPkmr4ek6Om+3EEoGyd2p+LFwujOt9ZQcr6jTi7HM=;
 b=VLLgA49jzXf57eSjqC8ui5L5tnLk4cBI9DIQGKKsZO1+5TeDRVRtrFkLOmVx2+JrlX
 OdijsGGpWqSAhRg5ifG6menhapEvFo61VXEyNzapTJyonY0XCdD51q9ldVhkPd1UAUyV
 ILjCmKwU4cW5vOQDy5MgyhDIJ9WGrc6pA8Tb9+TSWnGdzXJDvJnR1rsGBDHbJH0R7B83
 SkBeTm7htGmQZ7V5DTrdjq6w8yFAH8VImY+gasCZvUVEFakguXt36gSxiiTCxiyFa64u
 IlwoI6egGrROg0rXXwajQSz4Ety+XeM61XGWyNdzIcEPuTLk32M5c+pPbKutk19kFtNB
 QzBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772976228; x=1773581028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ue3LsFQh17Kvq877swpldBZjGKRzS/K2OgAAzBlKpw=;
 b=XUqFh9gu0TU9DfSTDzKRa0vEWMm9d5ZnYqQ0gFu7YEqoj8luk9MeLTOoDBYgZUsFDT
 Vy9aKY5LmVYM04EZ/Tp8x2oZxCLoCm5OhxD0rdPoTIiVT4GWzmZ49OvzIIwXtjeOH7el
 523xNbOgVYndVPCAjgXAMHNejF65iIRs5GGdFZYOx6euxRwe39qT6ohlS5HGlnb9zoc+
 RYatWKLbp1tdqqVJ9YAQxuN/LVSQ4tFWR3qQTl9BeCa6nwTC7NLKpaCGwKZnUWXrEUte
 gll8yvbrhuTqVB7zusD903+jYKVRVEtZrs+g8PMHGE/+sxUPPF0LayjJaX++QswMKvux
 1MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772976228; x=1773581028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Ue3LsFQh17Kvq877swpldBZjGKRzS/K2OgAAzBlKpw=;
 b=d8PlmHalHxXsQUe4H2IB2V5B8vdiUXyYHBG6sgKPhdRlt2sFQ9UdnTiUBsIfILCO56
 VLPCm2DMNw+L8LAXANGHEqSMqM6eADKkkPnPuax7e2gdsJ2G5rZmXYVqLMURHNxu9DrR
 GIx39k99bChfXJepk7MffzELAJMpRwMCe+kzBp2oWgdXGzF/0lV/WnnZN1553/rl0j5N
 jroFP7gAhj0AxNwO2KnJO9RImR4OJAEQJZdPpHgfxKmyaqylIhkXND4dpIk8mR0+qZJy
 F1zI9VvMgo+WKCB/BszYIReoM90Cj9IT+HJJOdsflUNflEovI5m9xuPtCjoZyThrtUww
 CfyA==
X-Gm-Message-State: AOJu0Yx7T9Lmif6btEtqTfhStixjI2dC97FBMLJfb1lWJBJhD60KSlj8
 EYZXpZqvsljUDaYRSDJPhuCPq8tTbCFikxhw1O4Wzv+Kh3K0x75iNOKl5CnsuKYJfd5PA7D29qB
 i9yZTabh4/Tau7t8R6YTH5zcQP8ENfMAhPxCPfX9+Bg==
X-Gm-Gg: ATEYQzwYMdGLz/up+shT/enP+1b3u6ghMWVKBCfn02SEE07A1G/Bzep+eLHpilqDIeF
 YV6skXNxdYQIUX+pySuyfjO2y2yRBSLYe5zkVaKBR+81vcBB7SYHdUxZf1EH52L/Bg2rvVkrUG9
 gWo94Uu8IjB2Qn6B/rtlp79u6WRflNDPY0DAQafrvjL07e9G6XKFx6T9IRi3jQjz0WwRsLH2M+k
 +6GN4DjmWTJ53J8ALhCO6mBBHq3sbikjbNOmrpPf7o+JkpZDfvXFafcHnwYfDvviL1q+EjI/VXC
 p0iHUD76lG0tQHsAVf9wxdo2TmU8BlvprhDet/pGuMrUERrwxq4XEu1p7IkL/Qb0e/tsu+pIgW1
 AOA==
X-Received: by 2002:a05:690e:134c:b0:64c:a4ab:e4dd with SMTP id
 956f58d0204a3-64d1408d7d9mr7489796d50.1.1772976227733; Sun, 08 Mar 2026
 06:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
 <20260122113144.2046899-5-marcandre.lureau@redhat.com>
In-Reply-To: <20260122113144.2046899-5-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Mar 2026 13:23:35 +0000
X-Gm-Features: AaiRm51_fefHFr6teS-6cRDUV5klCGZ35QqgikHLp2_SBAkND21d3iAM7t74enQ
Message-ID: <CAFEAcA_XEfvH1nBU0Qrv=oUC9eZpxY1XzqkFECujz4Ur-sBRbg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ui/dbus: fix pixman cleanup
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 22 Jan 2026 at 11:33, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Moved pixman_region32_fini() outside the WIN32 block so it's called on
> all platforms.
>
> Fixes: commit 7007e98c ("ui/dbus: implement damage regions for GL")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/dbus-listener.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

