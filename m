Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998BDEC142E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNph-0004W3-60; Tue, 03 Mar 2026 06:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNpa-0004UW-Ul
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:22:27 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNpZ-0005iS-F2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:22:26 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad8435f46so5146348d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:22:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772536943; cv=none;
 d=google.com; s=arc-20240605;
 b=VE08gr6L3bx2baL545J4i1EKM1dt6ZiLuWGmbuC8qpyqxpf/6uN53TwkS3gURmEso9
 9nRvawHBEH+zBbER0FnCEKs0Ma3xPOx5L/PqqrOS/1XYyjnH0s4u1/wYmSh6ASOsJGjA
 xA+LHC+K7AssX8GTsIeZP+zBO2RqDdfYuOBOsuDdeGAHV1uG9g1Hwzg6NpOq1Uybxm6s
 6Y0AHDL+HdU69KLJF/pC0vI6UuVXgTuLHAFB50JG6h2R2DDSx9IT1WhdLbu/QHdz3O0t
 zEHrjtTpTZSJhVqLHtetnsaL6OaNnchTskgMCngg+4+KdEsHp9eVXBNxmHnI+Z3mJTyk
 fzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m+6IG2CRLKKPRPJdAjPOtx72DUjJTLsUjz5R/WUmzNg=;
 fh=EzCqtT5E+bTTLv4rNAwVJ+2ChJBsIX5zYHpMVTT1IcQ=;
 b=ZlP4zNsTWe6vlbOFHteYPjD64MPrR+RVTKyFzIvj41sXLoQZx8yp+HyT65bA6z6pwS
 POCE1SrKPHy6ZxsY1effOUWqXPgiV7S5bgyMRfNJ6xJHWBcnBI1heTOXBPNz6q9Wt3Yb
 ionnodwZEGSRqTVBa/rz0F7L0zt+FYIh10GErsyzBhComSa9Bpf19tHPXMjTavJCO4xk
 0Sh6LzhRdzEwoQruj/55p8sOXzCiM1/lpM46qvClKiIjfVDDEp5KZUiic7zjwrhYAm8v
 CLX8QJRH/e8WZmj/NpH2sQFvkbKTbJwNkpftZCLLDcWH/Ibet1Cew0T7ZDEEuZazNfu5
 80Ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772536943; x=1773141743; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+6IG2CRLKKPRPJdAjPOtx72DUjJTLsUjz5R/WUmzNg=;
 b=A7z0T8yrgLLuK7tD+qP8RbClZmNCWeRuWi0cqb8mKlnbfeEVl6Wgh33j1a8tLvh6bI
 se9YLp6hHzy0fx/PaeLacEhnZBUj4bH8zOdnAnzp1712yS9UKvQn+YjzWwCoYhEuU4Ei
 R2DHdGgm6D2irJfS6fvaBC3A9Pm3gT/CMli62H8CdgUy5UIfcso/YEj/EoazTOl/Ewxm
 ZTjcmlI5JWXfVEluKo5KIJKGRcehG9/M1KHqW1EgfFfVt0igB79+YRsgqi9sJ2Q5FLrI
 P5xxJGw4FbTbsqShr+yLbpAFZjkqwrRf8/hW7F+OOGkOGFxKOe760Cg8PUBaFqcVx/uf
 faLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772536943; x=1773141743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+6IG2CRLKKPRPJdAjPOtx72DUjJTLsUjz5R/WUmzNg=;
 b=JfgrrZDiM06svaQ5fxK2mJvmAc35bs5qWvLzmoM6q2pB/uond5zmZ+GUDirchIYs0a
 pO8jX2UcOpA8xyRTihnKwjdLfuEMuZ/htzoOb2uvqPrsv1RQhYPuDUdtEXlkcBUO9QSN
 3JNeS6D/ehRY2ZAYP+9OI3aKxdcYOFlUhj480JiNHx5kmqBVebtxlfaMF84vwYQxszMJ
 Rg+L9Sk1xmSwZpq1d1AbVl2C0YvD1TNKFGlvBg0q2CX9rzJXmNAMz18Uv59ZIPGrcigi
 m3lti7RnZp+1ObOMJLTtJmwGlkfc00qIIxfmg3wzPPcqeejrSILBzioPQhbKnsmsJEje
 xpWw==
X-Gm-Message-State: AOJu0Yxxx/1ci0Wpi6FWWcZfylxV6zQl/uSVnhiOejAjARTiqzRmVkj9
 2W/vHcMLhoqdWn+l/u4CraKeNrl8bLIN2UrpIbfFOPPuBK9B83wlFiOjAJcs+sLIw5Up4oYj6qM
 v5SgQOurau1UMjmSN8tey3DujMqvMiycniOEySYr0Og==
X-Gm-Gg: ATEYQzwvCg1laeY+Jvp6bC8twW4UToPljLJzg0HGCSzJXoUQTA34QqDzhnSxB1lmAMj
 NAIP8EZXjeOmhG2EZwXLDan/pLzUEorXEwA4VQeDu7nCKBc2UzEVNKvMl07J+E8Pb4U1BOiLdk5
 1mZ3ixJQM7Anb8PiRqIQcitmgJ0bytlYYfyD464tekINmfuuFz8o1k70jGZkz75mRT3ZOWgZsaw
 f7f/YA00R5wYFWew11crDmeKLxblYt8NhBdR0zTqzPaLWJG+5qE5VBuLffnp6iHy5HMLeMC9jw4
 6xDM3JY06X8sFRJ2dRikZZy9dPXy/1QMkZ9SWlxgV3sy9jI5pSmG6V5m157H1i4m8aY=
X-Received: by 2002:a05:690e:4241:b0:64c:a0c6:da92 with SMTP id
 956f58d0204a3-64cc2119f61mr9387579d50.30.1772536943476; Tue, 03 Mar 2026
 03:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
 <20260227-semihosting-cpu-tswap-v2-3-cbdcdf39dd15@eonerc.rwth-aachen.de>
In-Reply-To: <20260227-semihosting-cpu-tswap-v2-3-cbdcdf39dd15@eonerc.rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:22:11 +0000
X-Gm-Features: AaiRm511stA6iolaP1wxhNxm1VinpDhe9nEO33PkwmcNGaX2wRsDRzYo-smPGaw
Message-ID: <CAFEAcA_oC0Z-o5p4bvRLaViSJQ8YDQyrVLaEw+=fJ4Ud_25r0Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] semihosting/uaccess: Use the cpu_internal_tswap()
 functions
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Fri, 27 Feb 2026 at 12:55, Martin Kr=C3=B6ning
<martin.kroening@eonerc.rwth-aachen.de> wrote:
>
> The semihosting ABI [1] states:
> > Multi-byte values in memory must be formatted as pure little-endian or =
pure
> > big-endian to match the endianness mapping configuration of the process=
or.
>
> This commits ensures that semihosting data is properly byte-swapped if
> the guest's CPU is currently in a different runtime-configurable
> endianness than the host's CPU.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
> Buglink: https://github.com/taiki-e/semihosting/issues/18
>
> [1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semih=
osting.rst#the-semihosting-interface
>
> Signed-off-by: Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de=
>
> ---
>  include/semihosting/uaccess.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

