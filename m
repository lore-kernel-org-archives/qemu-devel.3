Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B73CFD31D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 10:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szDAV-0003Sd-7S; Fri, 11 Oct 2024 06:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szDAP-0003SJ-Tj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:46:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szDAO-0003sP-5b
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:46:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c920611a86so2482783a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728643597; x=1729248397; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MB4WWjKXf7OHaItJ+RwY9FuY6dMKutlj8rTTZyQ2p5M=;
 b=oypsLq7MIibYMqsW1IOBlMGP0PWN+fVp5iM303UhK2k02SBHJFHAwkkJubA6XkVLD8
 bPLWclDpE8/890/d+9OwDSrBsFmgYSOkI5QuJiGgHItYvsQ2rJnsGf1SRMgaouyU0Zxr
 DxVBUEDcNrbxUvrzuL/JG5J+RKgV+nicLH7JIwciZBJoMUCY0/9jNVCIPDNiestiLbaq
 A6dGadWL5siKnawiZAak9tJcE/G8Z0yp1gNGNAMMAq9J+2ubi2eyfNPckfGa6qauwqr3
 ag9DJDY/PdWs27SH9K8z4Sd+AuVyeIpypJnu5GJ3Bqr044JQ9pjNSbQS3oCUU5sokwyR
 NSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728643597; x=1729248397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MB4WWjKXf7OHaItJ+RwY9FuY6dMKutlj8rTTZyQ2p5M=;
 b=vRhGEZuVc3xYehherM4tIRwGXW4iPedIuXqNx6sh9AZw+IcUTM85WQjrsHV+NG+5HO
 +8MshJQumh+N+d33hhWXkiyQkMsYtBUGWKdW79Rg8pUxw4RI+GoLZMutddteqSE7iYR1
 2PEX4zzrz5dGRaBTxq7Sia7l7RnoQiNW70YFmx+FjG1tXJFNe5vC1zI2Y8UiZYaL2xKA
 APwVQDP/6SGmXK7CWQgyQSotYl/jAqacX/srfK74+bK5Lzbn5IRiGGxr5gEd0lrawg7U
 vwmu2zdjfYDOWmPqQUeQ15ST8nK/TUE9/IvK9MsHISKSF+SadPJ414LZM7bA1085cITZ
 hXIw==
X-Gm-Message-State: AOJu0YwMEhpPeUN7hhRgEL6Urv5E4LsMKp2XVdq06e3/l96Cc96H/cUG
 Dv6pzuhnXCYLSOnAJkMSVP/pj08gN2lqBrnlBhgYHkpkchTNRgGGfPD07RswQwuXE2iUJUDVto3
 DycQlZATbj8iLuyAapQblRTKAk0TSKmDGvF1XLw==
X-Google-Smtp-Source: AGHT+IH+i8OWl7iFsK/PnI0ZCWgcAP4C56B+Pfxe/35Px8gbX+NneU60M9KqM1H+8Ui8705K32c4CjkdZb93+00Jkpw=
X-Received: by 2002:a05:6402:13c3:b0:5c9:2a8c:8961 with SMTP id
 4fb4d7f45d1cf-5c948d48286mr1579964a12.22.1728643596769; Fri, 11 Oct 2024
 03:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241011094948.34550-1-pbonzini@redhat.com>
 <20241011094948.34550-4-pbonzini@redhat.com>
In-Reply-To: <20241011094948.34550-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 11:46:26 +0100
Message-ID: <CAFEAcA_-8aHsJ_7tO6bik0+qVcFGBv7cXmRCwFBS3927bUYxCw@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs: use consistent markup for footnotes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 11 Oct 2024 at 10:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Always use a named reference for clarity, and ensure the space is escaped if the
> footnote must attach to the preceding word.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/atomics.rst              | 6 +++---
>  docs/devel/build-system.rst         | 2 +-
>  docs/devel/loads-stores.rst         | 2 +-
>  docs/devel/maintainers.rst          | 4 ++--
>  docs/devel/migration/mapped-ram.rst | 4 ++--
>  docs/specs/fw_cfg.rst               | 4 ++--
>  docs/specs/rapl-msr.rst             | 4 ++--
>  7 files changed, 13 insertions(+), 13 deletions(-)
>

> diff --git a/docs/specs/fw_cfg.rst b/docs/specs/fw_cfg.rst
> index 5ad47a901c9..c353957e1d3 100644
> --- a/docs/specs/fw_cfg.rst
> +++ b/docs/specs/fw_cfg.rst
> @@ -54,11 +54,11 @@ Data Register
>  -------------
>
>  * Read/Write (writes ignored as of QEMU v2.4, but see the DMA interface)
> -* Location: platform dependent (IOport [#]_ or MMIO)
> +* Location: platform dependent (IOport [#placement]_ or MMIO)

Missing "\" ?

>  * Width: 8-bit (if IOport), 8/16/32/64-bit (if MMIO)
>  * Endianness: string-preserving
>
> -.. [#]
> +.. [#placement]
>      On platforms where the data register is exposed as an IOport, its
>      port number will always be one greater than the port number of the
>      selector register. In other words, the two ports overlap, and can not
> diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
> index 1202ee89bee..901ce83bfa8 100644
> --- a/docs/specs/rapl-msr.rst
> +++ b/docs/specs/rapl-msr.rst
> @@ -9,7 +9,7 @@ The consumption is reported via MSRs (model specific registers) like
>  MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are 64 bits
>  registers that represent the accumulated energy consumption in micro Joules.
>
> -Thanks to the MSR Filtering patch [#a]_ not all MSRs are handled by KVM. Some
> +Thanks to the MSR Filtering patch\ [#a]_ not all MSRs are handled by KVM. Some
>  of them can now be handled by the userspace (QEMU). It uses a mechanism called
>  "MSR filtering" where a list of MSRs is given at init time of a VM to KVM so
>  that a callback is put in place. The design of this patch uses only this
> @@ -92,7 +92,7 @@ found by the sysconf system call. A typical value of clock ticks per second is
>  package has 4 cores, 400 ticks maximum can be scheduled on all the cores
>  of the package for a period of 1 second.
>
> -The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed time of a
> +The /proc/[pid]/stat\ [#b]_ is a sysfs file that can give the executed time of a
>  process with the [pid] as the process ID. It gives the amount of ticks the
>  process has been scheduled in userspace (utime) and kernel space (stime).

(This is another file where the footnotes are just URLs and we
should turn them into direct links I think.)

With the missing "\" fixed,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

