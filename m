Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45003EC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNoT-0003iW-PL; Tue, 03 Mar 2026 06:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNoH-0003aj-Ea
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:21:06 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNo8-0005bs-RR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:20:58 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so4480138d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:20:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772536855; cv=none;
 d=google.com; s=arc-20240605;
 b=MUFIx/Rc7mfq+9ygfrPAnVDvxYtXkkdc9pj+eLsmzJmkISjYm1jKLmYK5J1lKHQfHj
 p639ZyJ3q7b+8PIwn4VDoJsKvhUd3Af9H3onZ593eAcLsCJfD4YV42yUqHS+kFXPlnk0
 l2hZxJ9RBVuVgB2p0aNur8QsLoBITsMbgWbpBCnHmeR7PpAYkhM8gma/DVgMI7V3Zkpv
 Coj4t9GFfKH6pDf+WM1Wzlf9k//QDGDVNevPKsl3pJ1zhwAMRpyl2kHZYiPCEhwrnUov
 4sx4+H3Q83fBSPK1CgETzW7bR7D4OZafVrnPbulIV4mDjaz06qfwPGT6r6fJgDPg8zvk
 K5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4KZ6HOtu6ti8U9HXtG57M8M5XOpJaxPZn4q/DlOfbOA=;
 fh=EzCqtT5E+bTTLv4rNAwVJ+2ChJBsIX5zYHpMVTT1IcQ=;
 b=ZpptZ2/VfM7FPvcIoFO0Cg9w6ew8EhNEwH2CtHZ/FxlfseQu/pRil6XrMfS1O89fCb
 TbkqrkN4z6LvdbJWri7GAcn/fGIE6lPuRZ60+xsAoA/v1pF7K01QzPF6ihVsJMVgw3fQ
 mJY1TIpQYorl+xsKvpEoCsVEoPN2FtAh/NZezYZEeYGCYiRcJcqbT47NC3Sg/qrj0qj+
 eAIbka4dBlypApd435AQvMAmO5cWA0WYmPp5EKn7CkNAwrmJVgeWC2kcuo8ftxrj6gxh
 q74m9qjRHnQYlOiFqdTacy0DPmuNGQEgLOYuupCeTuIf3It1v0hTCHSV6sznDCi2YLxc
 ZTjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772536855; x=1773141655; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KZ6HOtu6ti8U9HXtG57M8M5XOpJaxPZn4q/DlOfbOA=;
 b=H14p7A7ja0poujU0ncfXy6K2gKsGnYskRY8DQJRICUYONnJaYvok26TRbDBRJid1pC
 RuvcqQFan3R/AmFM1SJSexipyQFYbb5NjYVtypiK2EZ28TeXIgiYt5lUTHGHEvlQpnvg
 YLZfHLeGmzmXNJSgsYWTLrrmEv0m/oHTxu0MXYUFvCMPRfbPMAlcENjueQG6TpsrSLwH
 MyZ034fZUiKTz2KpOOJ3y1gIyvCbHKiv6ijsabvd9I47Vxu6g69S+xNNfSfSUMaRNA5d
 Epg1EpmrxR1gSBokubtdUUfVpLajMO4lihe0oxkAkXV8okndtMDvl4s6G6vsY1w+wRFK
 39zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772536855; x=1773141655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4KZ6HOtu6ti8U9HXtG57M8M5XOpJaxPZn4q/DlOfbOA=;
 b=Pla00BJUoOjRFa3mZTM+MTCG678c3fD/rHtlFOEzMMTE1+7R2GeDy8ElcwjOph7vu5
 kjWgTpMePGYRwEaw0tnxrKirzssDltupup9+tzSYA9zOmFoZPHNzpn5rGsV1rgRXlZbQ
 s4XeS/wgqDyp6jF0+gh0/K6h6A+pALRxblHuHXP9Z5azARkYbGf5XH/DJhVIk8i7jQju
 z7uPXOhAuF6c1Dg/L6f11o66GpxfYWVoQeSLrXysyod9/Ldy90Zn8iQwSpkLjG4r0YFa
 B6tC2neYSqHZRknbM0o3BvefOtUEFnzRMoZ5aFlFSNiO9k6JNXfEtflW4gpDLQjo3b1M
 Gw+Q==
X-Gm-Message-State: AOJu0YxD9WDG4rH2AZSItkJmM72roD9XCXawGy0hZpnYJRzuC1ZfqMOt
 akFnZMCSYbdDnG/KyPpzJSbt2lMJ9MckBjD/tQ8nNPEAorzWXk5K3QDKtWmiHmCbet+yEutH36D
 Z1fm+eScubGxKN1a6qFGtqXjAz+xiD7DlMGZj/xmIqA==
X-Gm-Gg: ATEYQzwv82rlodkIl1api123EhXUXvKpri4WmdBpkFPurA7FtNl3FeR9ZTvBF+zxQA8
 SGq+1gefHIpRg9N94Lvaa4lGbvO9WxIFKkJnsa2iEOMx4eSPPz4fbqYCrXUUERyDhr5NqSRqSkl
 ctKsrMDxYpI+MyMNP9Pq6W3XBB155gwyFlTitlQhyWY8WfDw8UggcQlUaXF4jXkGJot5wiVNnN+
 y+KiQOY0Z1sCFL54ovytGNvy0Toa+WzdDYxoetcHgvwJPI823k/Vnp1AgK/mg2et7A8InZMm0iN
 f/4OxCylhbMn/gNFDeHIqynAuiVIp1pr7hbNBYMFtNws4jocc7NnKD0tsxe7qSEyyrkAg0Ulb8l
 scA==
X-Received: by 2002:a05:690e:15cb:b0:64c:ac70:9420 with SMTP id
 956f58d0204a3-64cc230a4dcmr9945976d50.76.1772536855438; Tue, 03 Mar 2026
 03:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
 <20260227-semihosting-cpu-tswap-v2-1-cbdcdf39dd15@eonerc.rwth-aachen.de>
In-Reply-To: <20260227-semihosting-cpu-tswap-v2-1-cbdcdf39dd15@eonerc.rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:20:43 +0000
X-Gm-Features: AaiRm51-qOF4mnv1ko5I9fKeZZBAh7qi9V-6c_VAP1yDh7LDolDM3TtNLJp6300
Message-ID: <CAFEAcA_eacmm9w1exKRrqcfVZRq9vELSuoUMbuQFessG0XvcpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] include/hw/core: Rename virtio_is_big_endian to
 internal_is_big_endian
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
> These functions are needed to do semihosting on CPUs that support
> runtime-configurable endiannes. This commit renames them and allows
> using them for semihosting, but makes sure to signal that these
> functions should not be used in other circumstances.
>
> Signed-off-by: Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de=
>
> ---
>  hw/core/cpu-system.c             | 6 +++---
>  hw/virtio/virtio.c               | 2 +-
>  include/hw/core/cpu.h            | 4 ++--
>  include/hw/core/sysemu-cpu-ops.h | 6 +++---
>  target/arm/cpu.c                 | 4 ++--
>  target/ppc/cpu_init.c            | 2 +-
>  6 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

