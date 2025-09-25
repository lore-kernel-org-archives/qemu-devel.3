Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ECCCAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1nd0-0000kp-Fm; Thu, 25 Sep 2025 11:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1ncx-0000kL-2X
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:11:23 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1ncq-0007Eb-Ty
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:11:22 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-62fb48315ddso2001002a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758813072; x=1759417872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=045KJQYjq50AYx9Yrp9chejGioJucBwRLdCITMUH/qc=;
 b=bb8K/z95JPTzV+dpRYC2hgqS7prOr4EvKU93urzVJpMKw+yRVhyfym5aOmCqtd0IV7
 IFwuS09YrmKxwuURBYakCQH/3KgAFMfSigjvWWC4NGQzrN/LmPwPOyGgkQlwt/qP8uvs
 9FCKuJbBxpXp9+lgkzTFcovb87MG1oo4rJWJt37moU0M5BAdmCMktYp1/mNnmCJJNz7Q
 IN8bZ35iiTLTDljOeQvy6RM3QtnbJxoUw4TYljP75PX0x9N5o6JjTsBwKkhjAqrPpw5D
 ooU/gyu+4fO8An1MiyQxk0pIZmgA/7QsilpoEpTgCtXMoELN3kd2HYYzMkF4wgl+E6Hp
 V3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758813072; x=1759417872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=045KJQYjq50AYx9Yrp9chejGioJucBwRLdCITMUH/qc=;
 b=bpKTZ4vpTKTPYHqgiygOOOZ7FuaaUooXewBukbWQVmzD3H1jdQ9x3lNT43qf/bJ626
 2gOejWEETGGitIM4XfsYouve/d7f9xzUn9ffzCWTAsVTEhScvZlMILxNasUQO+wHAe1e
 D08ywcH58C6pgsdc6oUrqUXCEN4nOaJEHnrj2B/F6N9nX6ydlJhkqfv5uqbpJ1xSWhiH
 bZxqX0+ZETxjrtz2BeC4psZ72OCOVt4f/ClWPv+aeyPZA/hMAvb6jVBhlp9875r/xx9k
 7AfT6wB+Jo7FxXQIeh7Ijdcbq0xzInYbW0s5uNVStn575iT/EgQK6aniNs38+7nt4UcP
 ScfQ==
X-Gm-Message-State: AOJu0YwMdlYB+pqMm1wRzYR7ImuPVBt26RqxhC6/Pci19gAZzAWFnrVd
 mfuLKEggOKrTr0ZFMogGk4rJgwaXI5xwJ2gh0AwHew7uFt9Y4WuaRqDAuAhmJNAihj0ObOjPfJQ
 ulUngBKz+fsdGVzoGCKwaf6M+yrexEzhAxRkZfx/z1A==
X-Gm-Gg: ASbGncslqaesIeDpyYkIAbe7WoEGpnDbfYWb/XosugAImW/2Sv4nfHapUwG/UkO2+jf
 nzjnsTW7qT0kwtaUFTWxWs/RLR5dbFzXSrNvgsQEMTm46St495x3TeZgPD4i1AjraXpxUbiDwWr
 PBNIv80dIMnWLrY1NxwxWJ23BVkVPp8JawbUEzJUrc0GaiJuPhC1H+hLw7aDrVAkto/PrXgrHEB
 RsGNSwG
X-Google-Smtp-Source: AGHT+IE/ki19rsgHzUhzupvRYmR0VqzPEjIXE/PwSJbkgsK5lFn4njM7wrt8rZFhOAzx/6PWDX4r2HtOgSjnpU+IMkg=
X-Received: by 2002:a05:6402:4543:b0:632:df3d:7b04 with SMTP id
 4fb4d7f45d1cf-6349f9ef66dmr3046852a12.14.1758813072340; Thu, 25 Sep 2025
 08:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 16:10:59 +0100
X-Gm-Features: AS18NWArSzPSl3izKBw1crn-WPaSvtrvmWQdV4mutpyNLFJ62dkZ6hOg-KgU1C0
Message-ID: <CAFEAcA8zeYKGj2eRZNOAUSbErVQ_aVFCcVsMg18+Guh5oUrp1g@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] target/arm: Reorg VHE redirection
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 16 Sept 2025 at 15:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prerequisite for FEAT_SYSREG128, split out of
>
>   20250827010453.4059782-1-richard.henderson@linaro.org
>   [RFC PATCH 00/61] target/arm: Implement FEAT_SYSREG128
>
> which also reorganizes how ARMCPRegInfo are allocated during registration.
>

Applied to target-arm.next (with a few minor tweaks as
noted in my replies). Thanks to Manos and Philippe
for doing the review here.

-- PMM

