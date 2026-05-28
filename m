Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D350CD6E49
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 10:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYK8-0002l9-OV; Thu, 28 May 2026 06:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSYK7-0002kt-Mb
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:50:47 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSYK6-0005wR-5B
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:50:47 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso7029314d50.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 03:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779965445; cv=none;
 d=google.com; s=arc-20240605;
 b=LzHkBkUzL2voQAI7hUjXIkugvu6fUVaGySM7sqntlUYIr2XcO5j8s5JrlNpV1uPBzu
 vNi6Hd1fNbGdzM6TGQIqgc2qNnvhUc2cMeD8GvHv9bhUKQ/YXlxC1O8dTvHMXiQdVGGI
 5HILNFPcg5DSG/1jxXKMZ6Z1mguLkaGGh5lnNj7+JGK4wHjf7NELDCVTSAMD/fGtHwEQ
 5zPPxPRF8foWuhuU6FNLlFXyJGQqM1NjseNfqsCNrkm5O+PMclzhmBZWi2J4soH+ODHl
 dqBgXIm3UUKnvDN7ArOq9On6PjRnYdPm2GzgcpPOUkwq5Q1rYMXO4Sk+hkNg8tTuJAb9
 BRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9rkKefH7qkaM7PYGtNz39Smfm7od6r4vxNbFh/5YrUA=;
 fh=FWtyXIX1K30Gh1JIPWWinn1E8IuOwxOeZI6Shz32Tr4=;
 b=Adap5bPjcCl58ScUglYUVJ1K3j1Ec1/7cw1+Em4KfHm8jZI60bchQYB2y98e9VYip9
 PAET46SNt+yzqVEZQRjZONqdd8HaH9hCVVL6HA3pJWsWm6EW/XqrMqYLPWrgZyS7UMoa
 TfjpZFaXIGLR5DFm64LIPeyCnaU8gONmoSKXAHIExqIdcDV2p351BL1zFtBNXOTUqAy/
 i5HdfPqsVuZgtWu5zXpUALzg6WnVFWiJTr+jvqDESIJfOrABnr438umY9iX/ebVUJiic
 Kwx673/eoODLjSzqk1RAeeicPxVWQgpo+WzA9JKxHAQGkEELgpptiDOyVLQDiC9PUAPx
 Enfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779965445; x=1780570245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rkKefH7qkaM7PYGtNz39Smfm7od6r4vxNbFh/5YrUA=;
 b=dWaoRJRJJTpcIaiH0UrdUT2Eexl77wkoHKNrcUEFj1jkm44xTH9NysSzYvi+hz4pHO
 l9QmhJrRWm81FLRhdsoCVn4fD2Cpms5yZ2c8Fo50wIsLQVBwhbTGyNEMqJU2Hy5sU5q1
 bKdbO0xLA1KEsRryWVNw9KXRRLhQETT1QCTB1jl6lB9ZHQ4Q1cRKsI65BWY3+v1g+ExX
 swDU8cS65RxepM+CdzU4Z+p4rIusvNWSxShOY9hZ5kClQxfPyN8fE/bWbOHXio8YMFbD
 gXr4HznJgerHvzuR3/GOk68E7CLjb9mDfo4nh7AGeFEuGi+PZKNqT5QI9VD44GxhVVZD
 gqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779965445; x=1780570245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9rkKefH7qkaM7PYGtNz39Smfm7od6r4vxNbFh/5YrUA=;
 b=FJETYC4NEfw5Uzr7Nu8kWzYQQEfn9KuECANUJjApY5cndZxwNvbm0ZcQnZlGTQBirS
 VI2UNPFuORMlyR8/yyBNGKWF2+fDJSQXFvZjCQvGm01e9DNHy1b9XELJc7GYAbN854jv
 RfPg382XFxg8KzHdy4BxSJplSmJVqQZGqPlbPmBU0AK+R0YKbzL8sA8G5qbs0nnXYdJf
 +fsQGbEAcyaeqfRzzgSRNAGl5y0Juss3vCJ6S20gOzXrup4G4bO9gD7B5mtmqM0mlZgs
 UqNbBceHEcHMNrjgWElHsonp78q1n+3FmtEDjl/99Gmfx5gdnfP8dnN5O52gSwKOJk4v
 jzyQ==
X-Gm-Message-State: AOJu0YxLHKDfivo8G0s5ozLnqLzRtRsKrFklNI8JwTIPLIqtBVQIUDzD
 RwqrYyh5AaXQRFqMYpViBWAu1VGOyWWH0/1+Cae2zkud2Sw5FnKzmK+/VtQZ6oed8YzRET78Veh
 quse9aM9A6k78ZUAGB7nts9gvnz9hAdM5mHaKYoPPBA==
X-Gm-Gg: Acq92OEMReifyWHB+u9jp9/I31Gsb2immLliUIwTKR9PFK8HJJCHyaPjX1jLfc1G54l
 NVuE3xaIsPH+sacv2C13UaD26KxrzSfiRAPsog1WYRKfd14lW6KQoyWFefyJnilDrQ3ebje7CI5
 bmajJF5U2e7/xMOKM8t8N4TNMUycYC83ZeJS32107lpFvfwsRT1WGXniWVuisKaIJjCdrHuPkCE
 B3Hpvu8Gh4GTx0dBCbRFu74iqebBikroXUBLrWg/H2DCJGhBQnFrqQ7xQ8K+9JzMDNf5XqX5Qic
 ssaASync4K+WFEk9PaHI/r/ulWNhhca6zGbmkM1EJEuTlHWUPIAIdWbv0PSUy9e6Sxc1LF69x0m
 2zA==
X-Received: by 2002:a53:acd3:0:20b0:65e:3bde:7c14 with SMTP id
 956f58d0204a3-65ec98abf9emr19937828d50.32.1779965444708; Thu, 28 May 2026
 03:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
In-Reply-To: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 11:50:33 +0100
X-Gm-Features: AVHnY4KJRmcjERNiffgoDdYHdUlGdwxutkidaNwXeY929YG_M0Vlg0VGmaz-2xs
Message-ID: <CAFEAcA-EVi2K2=LgZ4QZXoX7qQAg8j7mCphWostTmpVtBzTJvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: add support for Cortex-M pointer
 authentication code
To: =?UTF-8?Q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 18 May 2026 at 17:16, Torbj=C3=B6rn SVENSSON
<torbjorn.svensson@foss.st.com> wrote:
>
> Testing an arm-none-eabi GCC toolchain using QEMU gives unpredictable
> test results for some test cases. In the GCC testsuite function
> check_effective_target_arm_pacbti_hw, the testsuite tries to identify
> if the target supports PACBTI instructions. The test consists of:
>
>         __attribute__ ((naked)) int
>         main (void)
>         {
>           asm ("pac r12, lr, sp");
>           asm ("mov r0, #0");
>           asm ("autg r12, lr, sp");
>           asm ("bx lr");
>         }
>
> Running the above code in QEMU will cause LR to get corrupted.
> The reson for the corruption is that AUTG overlaps with the SMMLA
> instruction, and SMMLA will write the result to Rn, that for
> `AUTG R12, LR, SP` happens to match `LR`.

If the test case is expecting to be able to run on any M-profile
CPU, this is a bug in the test case. The AUTG instruction is
specified as being UNPREDICTABLE if the DSP extension is implemented
and the PACBTI extension is not (and to UNDEF if neither extension
is implemented).

(We could consider making the QEMU behaviour for these
UNPREDICTABLE cases in SMMLA etc be "UNDEF" rather than
"write to the PC/LR"; we choose to handle this kind of
UNPREDICTABLE decode that way for other insns already.)

> The solution to the above problem is to define the following new
> Cortex-M instructions in QEMU:
>
> * AUT
> * AUTG
> * BXAUT
> * PAC
> * PACBTI
> * PACG
>
> This patch series only implements the pointer authentication code part
> of PACBTI. The branch target identification part is not implemented.

I think that overall we need the full PACBTI implemented -- we
can't advertise it in the CPU ID registers but only implement
part of it, or only implement it for user-mode and not for
system mode.

thanks
-- PMM

