Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6ACC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzagZ-0000FL-Bt; Thu, 27 Aug 2026 10:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzagR-0000El-Qa
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:02:26 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzagE-0003Fd-BP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:02:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso96046666b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787839328; cv=none;
 d=google.com; s=arc-20260327;
 b=sYVTHUu4JFIpUKkhjRVSHjlFX3vDqj13kNjrsqGbQCnbtErxvrW1ZeEQvILoU1WIQo
 hughVbVxNvIKWzT9EorK+idbeFZGYep11NysEbfk2DjV11be6Kt81uZ11zRc+bOJ31xJ
 SSC/Iu/iuWmmAt/wQRsh5ctW+SYlPjBNgMObF/H43a9vkCzTnej0Lxh5WiRawWx/s9nf
 eV6K/wgGdDKVXf43XrskTfcCF+svxSomvyHDipo88yAy1E2wNgcPSKvffJtjDQFyv0R6
 1ztKnx5iTL1BWBcNsL6eZqoQ56ldGbbW52wrrBN9ufvXwtQ4ZHDs37BeWYf0dLW/zSCz
 5dEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Iojp5tB3ksrfi9AJNVpd1yk7HAvIOlmcl4/gxxl4nWQ=;
 fh=8RwUO9CVuz7F5OZiQ7BcM0jsMrOxPqH6j7tdP8Tq9Hs=;
 b=bWUwH09CrqKq0zgMRXXB+UTK/MF0bvgdmqevsQO7GzKqsehU5uDHQemb7VESx3ZYBC
 J/aOanloeWiwL8FQlgmZgn2Yu5x13bg833N5UvNih2TT//525Ov2XjnjuVOEroXtK+Kx
 DU9qbA4jOn7NP899kP0xSqmoJnTxEepZk6GrEPI12H9R5BZ/Ktb55sKX1gxgiImIqFvM
 et4SobgcF1ARaOg1SETCQh3rdzXU/HkDowyq8+qKNPn3Kgavj3RfzieGLF/ogC/foong
 /SZGdniJEoTV0NXmx+NIKDWQjWrXzTykGVLEGLD3e46uQEtiq1pg2dWARxEeLv05Rypy
 vMEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787839328; x=1788444128; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Iojp5tB3ksrfi9AJNVpd1yk7HAvIOlmcl4/gxxl4nWQ=;
 b=CofGPgHhiTs45p9Qb709S7ciO1IIEZdgkuetPMDLSE8MtJJFjUHrTFI1dkrAuleaUG
 0HuDFHOXFSUvX/y7ZKLKqmA1rzl5XdZdOz1zJOfGYFfqH9rNzx+oVlTOAGACZ60vHJD6
 zRrWCV5bXxkljbaSb0k52s3TTZVcLXqD3Vf5d4vZxDiKiQ8IUfTz0xz4nIazEzHp1fvz
 HHbTPRrkuHdp2eXyVi1oAJ6MPXpsjvwEVm/xgPWndy2FPGLZXv9RWydMgs4+3bNtFAM3
 hcm2VBDiaBrp7WC+b2K8TwIFJIhya6d0JQgClhKI5tq2reDHDKvHrzJISXjROS05ePF3
 AkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787839328; x=1788444128;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Iojp5tB3ksrfi9AJNVpd1yk7HAvIOlmcl4/gxxl4nWQ=;
 b=ozNtwSw65K17n9NLXnItvQzm4JQr5D0lv2uSpECsSqiZXQM/1Phm/6cJ/opwcmOwj9
 +/l9UdAdFQ6hOI+HFj62+liJpv6KlxJpE6zafXAq8Xs0CZhVnG1I5wOMuG76UbOMx++T
 LEtSmcwDaAFgXwkoPtrRxaieI6Q8rhYsoyDwb+q6pgS+/NAhqubo85kJsIzodfSiukRb
 2hakzMweOGezLTILKq91EQLTDmnTlpHyM9roOVSmEsBTKeNC8hpG6bIOes0FwDLliZHC
 AddxwD9zqyi3RqKoVaDiDSR2ETs7TKbza1emDy4Hb1u+VIiIlYJe5Y/Hxqsx+N+vtX6A
 Yk5A==
X-Gm-Message-State: AFuF++k4jsXci2TMN5KMBc5UMgZXEwoC/wzuXdb4iS0rIe3YizHuL0Fo
 AoJeIdL7r6C5vBQdu6f+4mJjqSI09nviDAE+STehO19CJNDjds+QjpOCzkDInPeFult84KGpXAs
 Zbhn4/dyiKKmCGXTaw7qjIbIT8BfvwcLcBjSGP8DRaQ==
X-Gm-Gg: AR+sD10NfnDg7F6X0tWTus1bzb6fmmUabo8N4JLideOkNr4asQLDjK4LMJVevEBmxtz
 VkwV7w/9hfawpVDAt2EbhmX2+HNPYhy9iHGT3pBWbdw/UWpG0OwjpoVtj5wPbEjSqUaxOjUr/aT
 1EOGPqVlG+7UiItdT41M8flcNqnHHzF0nWmQEadO2E/mDO9EJWSiQyL663BXNb5qGlBlmf31R5e
 gLjkkIaB8zKY8K74Q20B4s6Hi3poHCA3lGWWmZna0zLpjsPnyOm26mfQYckEz1FWakAhvg7f6fU
 v19sydVDoSlNvigIgvpzMAbhCgSHKWF62+ik0xUmQFm9kr7P0ZRX3P+UA34lCB9KDURkvydC5uI
 LwFBz75E/oO798brB12o/yoEJ64uY
X-Received: by 2002:a17:907:1b0a:b0:c20:f529:2d6a with SMTP id
 a640c23a62f3a-c250c37f351mr1689563366b.22.1787839328462; Thu, 27 Aug 2026
 07:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
In-Reply-To: <20260818002629.172827-1-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 15:01:54 +0100
X-Gm-Features: AcwNN1W-CC1I_aDkgeevT4OtefwJK3DkmygajhZdL3CnGXiWnCdBmnAKqnR4lv4
Message-ID: <CAFEAcA-bqCPVV2a_g-nav=GYj20DCOTU8pts4BRct8_qvqwbzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] arm: add Cortex-M85, SSE-310, and mps3-an555
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 18 Aug 2026 at 01:26, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> This patch series aims to add the Arm Cortex-M85 CPU, SSE-310 Subsystem,
> and mps3-an555 FPGA board.
>
> v2 -> v3
>     Removed ppuintstat variable in iotkit-sysctl
>     Moved add GPIOALT2 register patch before add mps3-an555 patch
>     Add gpioalt2 state field to new vmstate subsection for migration
>     Rebased onto master which includes bug fixes to existing models
>         in armsse.c and mps2-tz.c
>     Patches 1, 3, 8 still needs review
>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

As I discovered today that the Cortex-M85 has PACBTI as a
configurable feature in hardware, I'm happier about taking
this series before we have proper PACBTI emulation. We've also
decided in Linaro that we will add the PACBTI emulation, so
hopefully the gap before it appears will not be too large.

So I'm going to take this patchseries into target-arm.next.
I made a few minor tweaks (improved comment in patch 1,
fixing a few checkpatch.pl nits, documented missing PACBTI
in the mps2 board docs page).

Thanks for your work on this!

-- PMM

