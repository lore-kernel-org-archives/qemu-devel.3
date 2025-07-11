Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3DCC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCOt-0003Pa-2A; Fri, 11 Jul 2025 07:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCI6-0000u4-Uk
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:51:49 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCI1-0005wI-6b
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:51:46 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e81f311a86fso1762239276.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752234695; x=1752839495; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PkPXSjTK0rVjwGCTVZSTkbB1nNouLjZ8dAkLqd3fm+w=;
 b=tAnWTLhQdRDWeF53r7YhAR+V7YvZBiLeCR5+Xu+PmOSFLKiZNtPgVTRrHe15Faxm1n
 5xXdmr0A0vVQ57FLU/FTn07Iwhw1zJvV4SRrjMWMrSX4pnnuKKmHaXGn9B8nP4abhGzx
 UNJHuOSgGnFQjnqyj56b3v4q25w3Bp9WBjWPZcO7br8rYQd5Hui6seQ5pSNfqPHxSz8v
 yE5TKJ4jIh/egEs3gCLLcJg8swA4LWRtkHg9Z14s9hC/oAba2RA/PW5zZF1+fV017gkz
 zcbIUHO08TnMocx6HmXet8mfFyCssq4g2ZaOXXh//Pel3QN6FLDXQeneshejd+dGBWUc
 yGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752234695; x=1752839495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PkPXSjTK0rVjwGCTVZSTkbB1nNouLjZ8dAkLqd3fm+w=;
 b=FRN4XEVuXfDkpNZaPqMFfpJxVexJb4S64MGp4oe31ArrAFebjjitfHs8CgTGmwfVAM
 MfIe+3LyNBEuNfO2nniAQ89zJh+7VLI/jJKwEIJvU5F5NFVSIb3jA3lUA8z917RALAji
 WOevlNCs9TNDhyG3iHHbc18kGCHsAd9uZE2AuKq2cjOd96yX0wY1NbU/M+f0PiDnohol
 3lf4N81mBCIhIvTdHyo3m8Job83uzqAkLac4np3k59zxaFiACLLkWiMWzB8V2xyBAPoK
 I+A3g/9y/UDxcU/nEiB84aLgXGO3X6z85/5vPdR1SU6J6eNmsB8bsMMHW23b3Fj6SiZ3
 8A8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHggux+cudAqA82B1QWOn/6nLZrgLqSyo4LqKgQhauQTadhmRQh7ZyC/Gdo5COMH3HF0Ss97y99Whf@nongnu.org
X-Gm-Message-State: AOJu0Ywv1SRPPeuOW0S4p5PjCa2eS/U/NoXfG/dUk1JeznYIqzS8Eq1B
 d2K/FXZ1rsOKXAjixMZGw9nuDuMCR5pu9+CpM8qUI6KMZWJYK7BqvYAa5jFXGwm2lzy3hLvMLnF
 IeQmiQgVA2pfGSu+R6dmSBQWO90QXxfcFvDOeUJWpwg==
X-Gm-Gg: ASbGncs5lmIPkjFIO+xMloZlh/rCMBosOYaOFU/MyyrZ6X14qtiU+xnq7v9eRjoaBoF
 DgH0EgVJeJXCJ2EmhqmzGwluMm6IpXUA3YhxpJScgWj6SusdzUwIhlbVZfD/wqrh9hs3tu15+pR
 3cZfbfslu5kscwSVNDY0a4C6LEM2FkwPQxe7EH+GKoNvESW5MUZhlxo6aJoqD8r2LHE/mjg8utT
 CjuqagR
X-Google-Smtp-Source: AGHT+IFoiwOnUpLyR+KN+iyEROq/oXo7XB4Y00qbcU1sD3OMVYrcLEXsQcYofxIiO1h8pBqKO7hvps/4m9x1tzw+ZDE=
X-Received: by 2002:a05:690c:9c08:b0:70e:404:85e5 with SMTP id
 00721157ae682-717d5d7e0b7mr57539127b3.11.1752234694718; Fri, 11 Jul 2025
 04:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250710210941.1098088-1-gustavo.romero@linaro.org>
In-Reply-To: <20250710210941.1098088-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 12:51:23 +0100
X-Gm-Features: Ac12FXzA-cj63yHBZqlwutH3ipC8Ek2IE6TweFaRQ0DJASyVHRhZ3vO65k0MruU
Message-ID: <CAFEAcA-W4wHLxPw7QDauQitBPV+JryBb3A2uvKS6UrDgwL8ssQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v6 0/6] target/arm: Add FEAT_MEC to max cpu
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Thu, 10 Jul 2025 at 22:11, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Since v4:
>
> - Moved MECID_WIDTH from cpu.h to internal.h
> - Fixed stray ';'s in access and write functions
> - Use of GET_IDREG/FIELD_DP64/SET_IDREG for setting feature in ID regs
> - Sorted correctly isar_feature_aa64_* AA64MMFR3 tests
> - Simplified/unified accessfn for cache instructions
> - Fixed how cache instruction-related registers are registered in the cpu
>
> Since v5:
> - Fixed missing checks for ARM_FEATURE_EL3 in sctlr2_el2_access and
>   tcr2_el2_access functions
>
> v1: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg04598.html
> v2: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg01799.html
> v3: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02338.html
> v4: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02488.html
> v5: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02689.html
>
> This series adds support for all FEAT_MEC registers and cache instructions to
> the Arm64 max CPU.

This fails "make check":

 16/247 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp
     ERROR           40.82s   killed by signal 6 SIGABRT
 18/247 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test
     ERROR          181.28s   killed by signal 6 SIGABRT

This is because running sbsa-ref hits an assert:

$ ./build/x86/qemu-system-aarch64 -M sbsa-ref
**
ERROR:../../target/arm/helper.c:4588:define_arm_vh_e2h_redirects_aliases:
assertion failed: (src_reg != NULL)
Bail out! ERROR:../../target/arm/helper.c:4588:define_arm_vh_e2h_redirects_aliases:
assertion failed: (src_reg != NULL)
Aborted (core dumped)

which is because your entry in the E2HAlias list in
define_arm_vh_e2h_redirects_aliases() is missing an
isar_feature_* gate. Without that, the function will
try to define the alias register even when the CPU
doesn't have FEAT_SCTLR2, and asserts because it can't
find the register it's supposed to be aliasing.

I think also that arm_emulate_firmware_reset() should
be setting the new SCR_EL3 bits when the relevant
features are present. Otherwise when we direct boot
a Linux guest at EL1 or EL2 on a config where the CPU
has EL3 it will take an exception when it tries to access
the registers.

You'll also find the series needs rebasing as I've got
RTH's "move code out to cpregs-at.c and cpregs-pmu.c"
patches in target-arm.next.

thanks
-- PMM

