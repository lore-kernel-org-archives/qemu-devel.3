Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81724F01814
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRLL-0007JN-4o; Fri, 06 Mar 2026 04:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRLH-0007FZ-DM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:19:32 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRLD-0000iJ-Oy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:19:29 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-793fdbb8d3aso112052617b3.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772788766; cv=none;
 d=google.com; s=arc-20240605;
 b=HspMHhj1q1MwGNm3MRuq8TMxgBIbQjQ16dyJre9au0Ot/xAjxj3HuPj72TMvI7ce9K
 MqJAo1M0ZzlrOW5mBVPKe+dIHg7qbWLFRLL9s4fTM3XnEfUeePYfPUVpM8bIz6UctP6Z
 C90JzZ/8zmU6gxncy+YipJDYTnt58qoeAaYhL4ymz+BQfZogVO4wV8AAenmd1b1sCtOs
 FtuFAiNK8VXzEQmV5Yr1mSILHcbyfhxa6t9Jslfxhyh/CUWtdjFx7Ecr2xKFnYeb+/or
 hzjvplLtAwmYcTbAf3AUD6EjNxowJ153YSswwYErw/de3ebSNU06KtMwEB117X04Oh3o
 thUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0/6zAoZ/NERSIqrcdz6q0tgy2YPJ35UoP2Tv4Gcm+RY=;
 fh=BAyh76Dt9lJjY3uGbG9gye4E4bNa4dvV51FFfKIqCkc=;
 b=Y6i/HQAr0u1nw/bfx/1UX/g5GXwb4rDr6DaWdVDbwl4B3Tof5SnuTIHY8+LIsD4Syr
 7BX6JyA4lpXr4f2ziUSATPyYI37Oru8VMr6XWMNwMN7H5kYzVfM0WBi3Fej3uGbNqd73
 b4eSyqF2xTWUmmM1tPFC4bntMlDWDYClkQglN6CjjtoVp5XRthYgVmwneb+FaTWouL0F
 6BlefzqnRbfv3RNNqShpuBfcXezIDlcaRF74fUA0IXk/rQcv0CdiLdubwUJkA6NmFio4
 Ad5wM2ol2RYu1GPr8jmep8gnFMgxuc/625aT5bMEUAv36SrR5Ct1SU8OUM8A2TvRhbsp
 tzCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772788766; x=1773393566; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0/6zAoZ/NERSIqrcdz6q0tgy2YPJ35UoP2Tv4Gcm+RY=;
 b=ase6/rxM65pS26h+W3jkeKZNfxHVFqL6/sZCjlr/SgOTYMf1gKRkRXLH9jOOxIoiaD
 HJ31mtCfHEd1XvyuLqMI1Dj3+x779ww4QCXGuAIpaIzBUz9CaR/FwuBsKL92ZfofXv6C
 oG5nFwdSdHH3EejvbPF6/t3dEGY+A0iM3FMmb5loiMHc5p9ubvUT73wdoxBS7tHn055T
 lq+8vPq3DnhZGPxmpKoii5FfXPaTTPoiplQ6vcTGLsrLmEnOJgcmVqieZKBYmJITqNg4
 ecaSYpAmnekYaMXP4sZLfQj/pqftP/KmG0gmXfgZV2IfUPxnex83XhMukxPAkHfFcRqp
 KRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772788766; x=1773393566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/6zAoZ/NERSIqrcdz6q0tgy2YPJ35UoP2Tv4Gcm+RY=;
 b=Q3qpIq8PErHssE9y50RLM42a9U47RUiv0z2sA2H8Fv4prcT0BjmaGNHmdRj55wJxRs
 XyVRGA+HD317+04Fn7HMONo2nbs11uBdWPmtVATHlVidGOt83SvEtjfp0alTjDYkYjft
 vnXdH9/DwHUHe3tUJcbgBaoV2+zN1iQA3iS22xi3RDW/KUNa+ZjsoFawrz7ivnQwcBpt
 740D8LtRoWG5nvjQUk+URG6qU10soQCJ1sTrrrEFdrjuiVyidwM6hAC0+AHkjzvyCC5Y
 RpAyU5sagj7RaUWItOTUDuqtKj7GBJnf+hQqKR2FtItyW4Nm3y1+g5FNzHsaeN3/Q3/D
 P5sg==
X-Gm-Message-State: AOJu0YwrAJjh8Jsh9fLb/VMhaqW0TezCHOZWUjSBkb7fuLkOwD3OwhhM
 fP5XiExlvhVems2hGLgi2aEWckrdy/n7xaRZegAixDS/wD0UTORHIG3WUHake6zC0TPT7g5tYHj
 NAYUAKnF1J5I0e8jAwlXKbfSLi1cyg9DCsT+wUEvmvA==
X-Gm-Gg: ATEYQzzjvsBd3i59Jh3egC8KE1IiF3SrRcEsTfnv4AUxOo7CzZINLO+h4+PoR4EzGWR
 zleuBLsWYEu9Nrh6YiwdxMoCCX1K0kjm6FUNvslgyfZvnI3hgRlFNhIJq4823qShKAiJZZR1lNR
 Ymz+RotWrKvViCHb1aSqU93aChbaOtWQo+sdyyd/dKiOyjwGB1q26zqQ61aPVRGiZ0nHqmESq6B
 WV17Mpd8rDCr44EwpYTF1qmzY0nRTioAnO04PiTjpIKCjxoiRYq5daI+cArAPBjKK5+zuXYTE7d
 NZZLWIrJ+xa6I6fvnBvUSIToBPw8FZTkPUazaphbkZDZn8GiS7xDkLdWmHBl9gMePAY=
X-Received: by 2002:a05:690e:1516:b0:64c:ba9a:f1da with SMTP id
 956f58d0204a3-64d143757f4mr1022633d50.87.1772788766241; Fri, 06 Mar 2026
 01:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
In-Reply-To: <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 09:19:15 +0000
X-Gm-Features: AaiRm52yZxeAMvaUZ1XA7Duqx1hN1BfK7WKnC0qBF5S-Bx3DlbyHktkeKt2Ee_s
Message-ID: <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 3 Mar 2026 at 07:42, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> SME2 support adds the following state for HVF guests:
>
> - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
>   not support it)
> - Predicate registers P0, .., P15 (also FEAT_SVE)
> - ZA register
> - ZT0 register
> - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> - SMPRI_EL1 which handles the PE's priority in the SMCU
> - TPIDR2_EL0 the thread local ID register for SME

Mohamed points out that this breaks the build when compiling
with GCC (which I hadn't noticed because I happen to do my testing
of target-arm with clang on Linux these days):

> --- /dev/null
> +++ b/target/arm/hvf/hvf_sme_stubs.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +typedef int32_t hv_return_t;
> +typedef uint64_t hv_vcpu_t;


> +typedef __attribute__((ext_vector_type(64))) uint8_t hv_sme_zt0_uchar64_t;

The "ext_vector_type()" attribute is clang specific and gcc
doesn't recognize it.

Since we're defining all these types specifically because the system
headers are not providing them and only for the prototypes, my
preference would be to simply drop the attribute from this
declaration:

typedef uint8_t hv_sme_zt0_uchar64_t;

Could somebody confirm that that works OK on the relevant macos
configurations ?

thanks
-- PMM

