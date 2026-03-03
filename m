Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F7AEC142C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNnL-0003K8-2Z; Tue, 03 Mar 2026 06:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNn6-0003J8-Tu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:19:54 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNn4-0004NR-CM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:19:52 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-798374d0f44so86269817b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:19:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772536787; cv=none;
 d=google.com; s=arc-20240605;
 b=jXMpX0LoTsSI0joHswsRCYjv0GxkYUhXYH22srmG4ZIxP1Rb9ZpraYkzW83jqBDphh
 twO5/JXrefOsF8omDY39Jr/01wkpaZjueORlc7AuqkMXf34myQ5+nBG5CcuYmd628Q3J
 Gz5JRz3L0HpGOz3BhvJuAjLFF9bVwqkDtMIHZThNI1h+MnO639XsyukYE6g2JDpjimI8
 +Dd9wSuBxwwDPLXiPNtQT9Jrc8pHaVNC2eZZgdOC7IMk6hoqWEP/g36/IoyEkc/XDxjp
 jw7To7KBOwGTjsU2Ab+8c+tLa6SWlJTvmbUIbOFD6PN2jhmgz0kEZedDxo7nBCuIIebN
 RM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8EwTYz/QbmiyVUtkVoaDWdh0FQsh8+7atgJEqSg7D6o=;
 fh=EzCqtT5E+bTTLv4rNAwVJ+2ChJBsIX5zYHpMVTT1IcQ=;
 b=hHP6xdJ+GCnaN/FD0Blem+KaZzwE0IA4oMd6MeSIt/u3u5XYvVYeucwTry0h1Q2Byc
 xfv4aHAogms/aHL3Ax/AzHKxGoEYjgrPnChev4lne1UDpSs0viY+kWxaSRvpP7Ff43Uo
 4VBsRJHXo0FMTOu50wl4ZV+ydiWb0z328Cv1JlwhtJd+pDuxJwD9VT4H7uQLhCbXQRkK
 as8wEZpUG1dJ+5+sMBatb4Or7bH+Um2IwE/UzcBSYc7Nx97+2Ub9WBrBD37bn9mcGy8l
 x4ZcRa1L8gK6I1kFdPmwShG/+RaogsAC7cFVuH5vIdbnTZDEoSh/1dw+Qip4KyGxL2Ki
 R/AQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772536787; x=1773141587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EwTYz/QbmiyVUtkVoaDWdh0FQsh8+7atgJEqSg7D6o=;
 b=re5uKfZNK57/80BMvCJ5EGOebvSKbylq8Ar4Nl/T6Mkw6gqmuuJFprx2/yGCca/viG
 RACjmgaL1IAnGURoLx9WJhloNmJcM418kcQ/bGoCcNJcUm3XfuZW+YjzoH1XeLfGV11I
 yCmrdI31+0e9bOUSj/xfO2gdw6wbx+xQaG0VpeXJeqAmgS7acNEkLjWSPXQEbl2rGcQ5
 phIfjtfSvmn6cGDVox6+dgqsZzqK4p8trb7Wk3Rsu4po3etdDqCuZ10j3R2wTgxyHKKs
 C+iCgvqcBUIRqOK/XU4iEt15hDVeaeIaR1hbeooYoyljdGMukN0xkO+FsRX5jjW/iKga
 wLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772536787; x=1773141587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8EwTYz/QbmiyVUtkVoaDWdh0FQsh8+7atgJEqSg7D6o=;
 b=dW+u2UOd2YSVElNhFSdBVJrkKXiOPBHIEzyR32eB0Oyl0Fu5PH+MuY6zCsjfZQPDTp
 JuOWq470a9qzgVS5oskc6emNT8i1LEAQ6wt1OtRquHa9cb4UZfmLVPUlC6HfP+WBT2Bv
 6/rNFlcFrs08XqtYx2PBdf4qvovCClDK/nwgBLPQbWftR8fb/C8dbTMVB2mXikVM4LGb
 8lBh6N1e70E1od+RXUM/1oo1A7lr5c3pzOiJJrQ6wCaIK0SHivqhbuC8lERCo9lcAn7z
 k01AnOR6H3u/hHVZ/0cnkg8kj4a1DX2iFANPESvHPlHsUkpuQzWHeV84PLOC/WDEnBWW
 gMBg==
X-Gm-Message-State: AOJu0Yz0VtYsec1BzzKuRqLQLRli1crl8yRozeFFSMRhiYQV2hg6fMqj
 1aHv3f0mf5gkbgrHTjB/9XuyMrvjj2WpUC5tdnOAXxV4ILeuNv3+KvcZm0AijS063zZ/zt2B/lz
 2udW34M0EaHRlZi1OTo/AZgB57tuCMc5P1A6rB8oeXQ==
X-Gm-Gg: ATEYQzzXylNxxgdrUlbyRp8289CQsblUGECNYCKS6W47vto529FsW7jUDmlYy0BZ8tA
 f6xsxUxJdgEQGYadxCFSSKELVEw1RlP2aipVNEk6DSJuu4VqJiisqNWo5AYdGwP8bM1I6P+SPrl
 TMHDbaWprXmTyoFXyIhTvRI8yYyBUEHK3CGpJjQ4TKQJMSQBYpnON8YbCxhi6VWf/3JXOhqii8I
 obGzlbLzPnxg3gQJZknSkpglo2TQvBuPOFMnltiFxUDyEpzH9rw+UppAWJDdxC48z83pN6iMLEW
 mYBK0rExjLRBgzwE0jiI1EZwPfwRcxyGtxuB+mVZkpZy905RLWbiEzfjEfrvBD2H/0I=
X-Received: by 2002:a05:690e:120d:b0:64a:ce57:cac4 with SMTP id
 956f58d0204a3-64cedbecb46mr1229258d50.24.1772536786906; Tue, 03 Mar 2026
 03:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
 <20260227-semihosting-cpu-tswap-v2-2-cbdcdf39dd15@eonerc.rwth-aachen.de>
In-Reply-To: <20260227-semihosting-cpu-tswap-v2-2-cbdcdf39dd15@eonerc.rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:19:35 +0000
X-Gm-Features: AaiRm51l8rYXPrmo7Ptvfj5go7bxbNiyxMtoQxcCLAEgWCnst0stbRZ_GN185hg
Message-ID: <CAFEAcA9+A4Y52f+zZ=hcJZnsAfhLKQf0dnfoWj49W3p53PUFwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
> These functions are needed to support semihosting on CPUs that support
> runtime-configurable endianness. They should not be used in other context=
s.
>
> Signed-off-by: Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de=
>
> ---
>  include/exec/tswap.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> index 9e94fa0021..6d9301129d 100644
> --- a/include/exec/tswap.h
> +++ b/include/exec/tswap.h
> @@ -10,6 +10,7 @@
>
>  #include "qemu/bswap.h"
>  #include "qemu/target-info.h"
> +#include "hw/core/cpu.h"
>
>  /*
>   * If we're in target-specific code, we can hard-code the swapping
> @@ -72,4 +73,39 @@ static inline void tswap64s(uint64_t *s)
>  }
>  #endif
>
> +/*
> + * If we're in semihosting code, have to swap depending on the currently
> + * configured endianness of the CPU. These functions should not be used =
in
> + * other contexts.
> + */
> +#define cpu_internal_needs_bswap(cpu) \
> +    (HOST_BIG_ENDIAN !=3D cpu_internal_is_big_endian(cpu))
> +
> +static inline uint16_t cpu_internal_tswap16(CPUState *cpu, uint16_t s)
> +{
> +    if (target_needs_bswap() || cpu_internal_needs_bswap(cpu)) {

I don't think these should have the target_needs_bswap()
check in them. Otherwise for a normally big-endian CPU on
a little-endian host where the CPU is currently in
little-endian mode, target_needs_bswap() will return true
and we'll swap the data, even though we should not
(because cpu_internal_needs_bswap() returns false).

> +        return bswap16(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint32_t cpu_internal_tswap32(CPUState *cpu, uint32_t s)
> +{
> +    if (target_needs_bswap() || cpu_internal_needs_bswap(cpu)) {
> +        return bswap32(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint64_t cpu_internal_tswap64(CPUState *cpu, uint64_t s)
> +{
> +    if (target_needs_bswap() || cpu_internal_needs_bswap(cpu)) {
> +        return bswap64(s);
> +    } else {
> +        return s;
> +    }
> +}

thanks
-- PMM

