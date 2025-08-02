Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93601C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIp0-0000bv-A5; Sat, 02 Aug 2025 16:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIml-0007Bc-En
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:24:58 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiImi-0003HI-QP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:24:53 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70a57a8ffc3so28724367b3.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166291; x=1754771091; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oCMEFD1ZYV+ifWGWmltaqsayNDdbSgNQaqpCz2PREAI=;
 b=xratXCJBic0Kib6yLTRxVdIvWaIgyvfna+TrTkJ/YV2k9aAd4nsajfBzgV2Lrn/uPZ
 Rq1ctKMPFaXKNyPsB3rJ2CmQ04hkFQAfDs3sZlL2YgZGOwFvR/ELZfKQvUtYKEgXGUA3
 jg9zPxoGLulakooOVvXFbVlxoKeV/3WH4vC3MuP/nEkOSi2EDYyPtAR0nE2ZddcGrG5C
 vnfY3eV6yIHOcpyjR4s5N5wA06B+/FwpywFHxRetdA8Zet1CtMCWD22eonBsHey1pXDa
 rGi7e1twTskjJ0AFP1s+0yKJiZ1T1bmz3G/oKfFKwkQX2A7X4CuTQmuDiRzMrKtrHo+3
 efVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166291; x=1754771091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCMEFD1ZYV+ifWGWmltaqsayNDdbSgNQaqpCz2PREAI=;
 b=MpSa9XjSGIeLCm9jr04GXD44JAa7ojzH6JQbGR0n0VDFMXPQ7V88pekjy2gKaPPM9m
 4K4u8S9Gl3v4vgLJZxREnVUD/If7BJ5LDgMOHTf9rss6jrlNiC7iCVGT/vRRNblzgciq
 LJGas8bfv4wYNrhGOLLPDgJtOvdSlTLCLMZbbjOXz9ulJTFOd8w3hU+eGs1HA0F9KQjh
 b0ciaOI0eQs0koNunKMtbf5ti3iiZlK/8Km06dS+OB+isWtoEhpYxW4xk+m4MrLYfpjo
 fO3KSMaGVOZNbYJv6GvwaHldElwUhodBOU2F1QSIoQmgsNmUeXut+OoqMx+L/DFBTTnB
 rtlQ==
X-Gm-Message-State: AOJu0Yxe/ELEKOHI6aauRxlRBsSo64jeqOJfqHRx+L2VU7camKVdmQBu
 WzpAdV3moODH5QOeV0hV6PZ8zHLdVUkoC5NsDJeTzW7Ub27K3KvQoAquZbY4qXVCtVyYWCzE8o1
 fkmVzdYFVN3EdkkKkkaplCTzqhM6yUBh/2bhQGNmGxspXDTskEYNX
X-Gm-Gg: ASbGncu1t+zDbCyOOjvB2zIbz3GpWf79Pp4LHWf6expHEK4gWfZ8u4ug1oYSRU1UiKD
 x2RKicZVDnEHJG6y0DLz5u5pElzE4opJqPxt6C0b7sP3Vj5m0Zzzh/2LI1r2QGWzewofxDWmV/E
 Bwn6jWtQ5QU7KXqR3LJ1D2TjCcFMkbmsFspVcPjB4G5hdr+jlGCE/PQ4AQ8bzoPIkRQ2gwKPgNy
 Bc7LfWP5/1fOLiKQvM=
X-Google-Smtp-Source: AGHT+IHB2cKVSed189pSQWRruKiSQ5clU8aN/ImxoFs+OZ+LEk8GJVWUZpmtFiU4J4VEgttRhSbYIyovhBTTVTRxuVw=
X-Received: by 2002:a05:690c:6d82:b0:70f:83af:7db1 with SMTP id
 00721157ae682-71b7f7f5e59mr46919447b3.19.1754166291526; Sat, 02 Aug 2025
 13:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-65-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-65-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:24:39 +0100
X-Gm-Features: Ac12FXyT-d0T69FKnkWfu91dplTHSYBmc6y5gMKHFFQVGCdZsM_o_jnm0dlv5Sk
Message-ID: <CAFEAcA-dRpHy2FQRq4ZvR7rh4RF94BOLVU_qN8z5O58sefoLcQ@mail.gmail.com>
Subject: Re: [PATCH 64/89] linux-user: Move elf parameters to {arm,
 aarch64}/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_elf.h | 10 ++++++++++
>  linux-user/arm/target_elf.h     |  5 +++++
>  linux-user/elfload.c            | 29 -----------------------------
>  3 files changed, 15 insertions(+), 29 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

