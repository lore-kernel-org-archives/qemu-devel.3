Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629A910A88E3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nRy-0006a6-Jv; Thu, 26 Mar 2026 12:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nRw-0006Zi-WD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:20:49 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nRv-0007aG-IQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:20:48 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ef161129bso1078990d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542046; cv=none;
 d=google.com; s=arc-20240605;
 b=eAm2/vUEs+riWjfspkGPrFzN3pvXsDyUVSu01/gD9kIyf25e16ekwiklrA4arWOTEZ
 UR4Ydtx9Of7qxpZxan7LTTPT21a5Qf9k2qYY2XRaA/pDUa6oFECfeKF2HbF+NHlvtEus
 8J0b23wj4K+iB3LlNzLjOhux7eJpP+sRPd3AJgudf99Q2I/Tv+TXNf5p4IaKdbmwQAAh
 e8u1eZEhvccORp0mjxi2HJe+wgNhPepeXcVgHpRhfdBwxSspOq1DL5HCqBhqchq1llD/
 ctR02pSBpnAo1z34uvIUTlwCjrKwh+8s1Jk+cGvyWZqohqBGxEYfXlYPBJppcYV+T+94
 jt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4LQBiGiwq9AkZI4ADTQ4rQM/2ruccGnulB3VvVvKPMc=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=jlfGyC5gqShLilMZdvhAq7Zra+h6/yq32aPV+G41D+2UXNW6tY8ZKseJizT2XSQi8H
 OWV2bM+aItXR+8oy7FczWjjdla64sbwNJDaC6lpHkiAd4+WSwe4CPT+rMPI9eES5UWUt
 k5igd4JMjwPNB3ULaVvFVYSFGRnQZRf61V4X5sQZY7sTZ2kuv5b/ZBmbtafyRg5zlBNZ
 53cSVUu6CH1khF+qeF40B5Pl+KV68qy2mW3JITktYyJj+2th4M19XHDGywwtEVMO8+E1
 DA3kUinMUbu/TCsWkrpO23K7m99Z4RRlV9BSyrHBk0ZfFiV67iC/lJGtOM8z/ialYkr/
 e65A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774542046; x=1775146846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4LQBiGiwq9AkZI4ADTQ4rQM/2ruccGnulB3VvVvKPMc=;
 b=NbQD7aSTUmi4ocJfjw/sejfs5ZZ0RLWp3+ZaOvMBITDDtMU9/z03TOfxS8OQRi2bII
 WvuJo8PIuc5iq2LZ0z+O+P6hAr/+xvnas6IpkZ+53l/UXvJ1ZGXJ+IyyqiCRG8agMY0C
 FmlS1/VAV/I51vbEn0vBZn6hP24B2EugHm3Pz8GFpRoJWyaHn+QrKmIjqMMZ1tWW2Q9I
 uAOXv1o+VRpy4ey/zAzMSzSO4sIeFzz2TYEa2NzEhTdvsWDbh2Szg5XXex3mBXwXUFK2
 rQKnjdT8uPcWgSyksZ789+PoewszNkR3zC3V+v7s/7SpuJoBt/z5s1S9d1jptl5r3V3F
 ZoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774542046; x=1775146846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LQBiGiwq9AkZI4ADTQ4rQM/2ruccGnulB3VvVvKPMc=;
 b=fZSzBrpqMzoHHwx2Ye0RuFOfbTy7ade8f83Wqb5IvwIJfq84PlU1BoaOiKWtHq/5Tj
 3PSLgIifLMpGSwCWTzkX16XJ07p1NyZqhWwrWLrc391gpVtcQ0H+EdqCNW6sM1s1vwtX
 uLk6Mn81mfSvBNUUAW+xPqR4hMGW1GDNz4eI3NYVwpn+QmpkiYV1tYKOVtAdEtY+7r1E
 hNFbTJMe6Pr4cfkpMevGuigFZ2CXfC1ThGYaQXOK9zEA2GqIcGBW3FCR2cs6N5+Geya+
 sMAgWhg8RZsoTCgc8O7XPAGFOdyAAeohHSUhP+0FBW6itw8zT9oZW6C29PrGa3yo5PbG
 0Cvg==
X-Gm-Message-State: AOJu0YwMizAMmM6HY9oxMcDRNvlb7cn4h3zQQQPH1gYwPpKiDCAndudM
 T6ZJ1S7a57XdifOhKh7uqbEXrZ1cwYJoFbFfRv+fswv4a6ls0GzIwjSPHk32T6/fEIZP3xJtaw0
 wvfSfgOqZzx9Sdvzo2NhFFKjLxmPfPM7DFfJ0XmTW8A==
X-Gm-Gg: ATEYQzzW81IrWrDr9HXuMHopbQzxju1sKq3Bls7v0Q2mm7JcMK80Go2mrY798FX+QuC
 0mj2NTByCLUgue6UUHXBXGpYJqAiL97UsAXwqYnM/D4QW0mRXgGicZWkfQ0wjdHJtRYREIFGg4O
 5aE6SrKg+wtHCxommJYiYwSIqVjUZksniUj3Xr7bWfuqFLjp9oygPF10h36vzTUey2Xr+iooH//
 ltyhSnXMbxq5SWL3K90R+nHODfBqMSo48JXJikUTJuTqslcSM5jCOMATMXHG9P3Gf25baZkwyfF
 Z1sJV5e7lBibMwPri6T6BWSD3PXe4Q0uLZV96JH/7fEMN9s9GsUbl8wHMA2swRZRvME=
X-Received: by 2002:a05:690e:1688:b0:64a:d62a:2048 with SMTP id
 956f58d0204a3-64ee606f437mr7415439d50.12.1774542046183; Thu, 26 Mar 2026
 09:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-4-kkostiuk@redhat.com>
In-Reply-To: <20260326160033.68318-4-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 16:20:34 +0000
X-Gm-Features: AQROBzD9yuvL-ZqkBZ0F5Zd7HMWwrpgUKN5zUdXsRL--S1LTbyz7mv6aE_3xNAU
Message-ID: <CAFEAcA9-j6qnKJEyk1F9Nkr0NNP9D9Oue=ptPb5py6ex=mdQnQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] osdep: Remove unused strings.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  include/qemu/osdep.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index f151578b5c..2f0e61ad6b 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);
>  #include <stdio.h>
>
>  #include <string.h>
> -#include <strings.h>
>  #include <inttypes.h>
>  #include <limits.h>
>  /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r

This needs more rationale about why we can drop the header.
POSIX says it brings in ffs(), strncasecmp_l() and strcasecmp_l(),
which we don't use, but also strcasecmp() and strncasecmp()
which we definitely do use.

Some libcs (notably glibc) may also define those in string.h,
but the manpage says that's a backward-compatibility thing,
so we shouldn't rely on it.

-- PMM

