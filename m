Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CD4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4ZD-0000gB-2f; Thu, 21 May 2026 10:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Yk-0000Wf-TR
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:39:42 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Yj-0000uo-7L
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:39:38 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65eb1b25c77so734666d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374376; cv=none;
 d=google.com; s=arc-20240605;
 b=BNeiiAvmhlKfmcYC79yp/bz5pBudXhBqVjYgR6Iz2mjbPpiXZt+pZ4BX+3Cc9P/zAd
 Lm9WcpjijfdKD/g6YFVDDaRS8r2zrsDrd5VX+BecR1TUg7gHlrnrQBsQcdTChJoCfmT6
 I4pYXq/QUSBxQLG8CudDlBE1HnvJBHdnsI6ivW7yP1AsmDLxYZR2KE8r8ovKTADjMEgu
 rkaqePhw4x9CScea9hHKMq7sqvK6gTI9HoQ/4J31oaZEXDAcB4fCdAZy89vBigFYw9B3
 U/qA6EyNA0c3y6dxJXAV/zV6mdylUuEkfEF2r3q8kwTn7YY37o103uA2WELNz0kFdZqx
 g8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jhXwLY9+4lchqLsKMPkgNdoqmwJvKilxrM/k+zb6b0M=;
 fh=XpR1p5CW/K0boqeZ2ecFvjSCxwW6tsvBACzWkwI4qAs=;
 b=QtGdv4yw71C61mnc/oruz4g6OI/Bs+gXa7ftgOHiueArpzq5BMSlzJUmY4XoPvj6K5
 KR2fAp4qv1bHOpFTbYSILUpKxfp/9YZh6+WtKtUVyfbhqbfnylJUf9HD7lI2UPVYvRpy
 KP/MYYtD9RvrFr1GS8wgGXze1gTzEH7rNYedyl/4ghC/hDcQGPQKf7/pOi2FqS6TfprX
 ZjdiddQZhnqLoNpMD3dZM/w57y1eYORBulIL2MpvIT+vra7nwCEECcXOLwi9rT1AnDgf
 CYNZsaA4NfdmjIj2A7UoRHo0t0tTopTtDU2bGTNIQuz6ICSkqv25E5A5Y2rTF1ESAFX+
 RGwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374376; x=1779979176; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jhXwLY9+4lchqLsKMPkgNdoqmwJvKilxrM/k+zb6b0M=;
 b=lul5OqGmYGe4XKfvcMPIxxydnpHoKsu4RgzziEhYnyZlnzAjKUAsG9b0VE2fzHAYNT
 s3cS3+YbHXZrF1BkCJGgaaDHEvUktB5T07bmXYnBF72eNDCJ4PLLbfdUARRZq8zPIcIJ
 cvsSYru0DMgmnE5Q+JxJkWg2pKIK9NJbYhBV5e5ZRKOlvf+lfo9XqqsNVvGMRnUKhVGk
 NogOlGZKlmVX62o8Md4BU4KO9F/2eCF0ZW5zBcowvMmKsUvtOU3tFhJS223+yadpagXI
 IB3yRl61DnuC06pWoo18wukGDIBO6W19TGcSCvd+BEz56/UDUaL8iBu9bN6EGkZJjo4C
 h3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374376; x=1779979176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhXwLY9+4lchqLsKMPkgNdoqmwJvKilxrM/k+zb6b0M=;
 b=brNkeSznIuClnAAn9uSoeIQB6Kjdl05chccmMzwPwf1Ny9ENCJx1oBVtxjw5EeKgYI
 NPUE70nsQ5I1kQYlQ+b11DffXQ1Nosz1AxshPmgg+EnRtBQiYe40TxakmODWjndJe6zh
 0hJLsZBUdl6QwN7OIgTVG+1Y21c6VRwfvW2NUtO8xBvJYIVWrJ4DFiQ3aVLzcXBqvWsG
 UOb+XUWCW6rMpo5X7lY0sIo5v2boNJRC925l6gczNWpQ1h2SXf3MnhN4QKNtDIU7fYHI
 k2WD+DtPWDmRcFKzPIK2BlmruvYbx6MiRDXh2w8MDRRHsKcZ7BsWAAIwTdJCA+OMz7ny
 BwjA==
X-Gm-Message-State: AOJu0YxNcZEow1HyBZ/VwJjxXf34doBRkb5R/AbugOpoMFAUpBnzddcG
 98feCD5tuVYM7ra1YVrBenhSDf2sNin50eXrFK87mC6Q+RNovEwvlKREFaUh4HeYxBrC6U5EKpX
 SW1G8Syuk/NgQMpMEnP41f8GMgOlXGoPN32UXjCdt6A==
X-Gm-Gg: Acq92OFqwUezfF1j+M2l0JeYVFlhtiX6mIeVvTklL9gJOmCDZQr+gqtzNIvx8peD+lg
 i96H2nUek935urIAABl6oZjruoRq45O1Erlpr52W8jsyho2Lh3T9vNcv4LP4cRtKwTzzW2fZRyn
 b+4Bh/xnH+yAnpNRCWoqh9ykEw7wyVaNXYnidh7+8HmFWDB5sOCxNW1EVjPOPMrMvEg9/PnjsE1
 sz71jQrgwKAEXzn6Rvm9XX8jlDPKVqGq2NhjTXNSzcgqm0RkOENZuzEIREDwyf7Z5tTRGFVoJqC
 XRe+8VP86qHwzGC4C7Pu0dBx49YKoF0nNZqglsSKWgCEL/ou8N/vdgD+tDzm1XWtO/w=
X-Received: by 2002:a05:690e:1282:b0:65c:ed33:bda5 with SMTP id
 956f58d0204a3-65eadc277camr2650502d50.0.1779374375691; Thu, 21 May 2026
 07:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-15-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:39:24 +0100
X-Gm-Features: AVHnY4KZy8gwudKMPQNttwKlW59NIU8dyA1ugTwGRQoiXc4AmuR3ohSaKMmPoyc
Message-ID: <CAFEAcA9RE0ryq9Gq4Yxag2Mp0=H6VKZj4V9yPJh7ZuOb37w2rg@mail.gmail.com>
Subject: Re: [PATCH v6 14/64] tests/functional/aarch64/rme: update images to
 support FEAT_FP8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 20 May 2026 at 19:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> As well, use -smp 1 since there is no visible speedup running with -smp 2.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

