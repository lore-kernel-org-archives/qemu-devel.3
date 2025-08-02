Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9AC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ1j-0004fQ-6R; Sat, 02 Aug 2025 16:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ1J-0004Uu-Uw
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:39:59 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ1G-0005ky-Uq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:39:56 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8e2a260926so2853263276.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167194; x=1754771994; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JYr8ifIbi4F0jACg+eOZ8i6XPPFMh87MEC+BeF+Adtk=;
 b=FEEbTuw6kwQXNz149wPOcd8FrakVl95xjQ25rfOhe+g1GV/EngH3vUuxIpL3O5R+MK
 hcS054Y5CxsfyvN0Hl7ssqfKqpRWcLEqg0/EPrUE5uaeZZYAln/1TUpMKaRIc0b/Xbkw
 Gw9YEKK254fuau4zhAisWDTXAv+ffYNBTvqu3a31RqnA4QUCf/NbghHHY21+3lUJTolX
 3C2hFkq5c24NMEAdbOhHcgDTb9Cqex9Ihr7LFr7U6hRI26aEurQiqWZIr0pQ5sTLoP1I
 EPlnQXYMDOjwUfDa+kgK8tbRpvx8j8mbA7CSEFoHXmGL3gHwgZ52ph2p0uNQO2oefD+d
 POdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167194; x=1754771994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JYr8ifIbi4F0jACg+eOZ8i6XPPFMh87MEC+BeF+Adtk=;
 b=KUBqppNacalTlpc0473LG8YgNkh2VY6n13rAI2RjTtiSXLzHGkaj4R0Wme2r39SJXP
 WqQ+abFHwhRoZGA+4eD6KaguDbU/qq/a+ie+Nov6zJ46qEXax4PM7MHj6MvG7dhRrKTe
 he6BLBhayqrQiC4Bd+VRMTuS/EK3cuv8D+lvwoDQEfKrbf6V+LIs9+qfe5d8Beu3TVrZ
 7CTKbOKci1Gx5pQQpRI8aRRwDdqEf62XAMJe700Jv1kF22bIPPYJYnQV3bRduNfMUr7l
 LVDoaPQor9OtOfgKqhlfw1M9Mlee7ygtoGiWHDR+S/lVab37y8rroXu1L2ieXiDawxf1
 +YNA==
X-Gm-Message-State: AOJu0Yy542ug4NfGrphwRXOjqkRQQSXakxBKKIfOGp4QLM1DB92aem3b
 UBjk1bs5Ib5546K+y9tWxcrB883Cbdh+iCOmjiYBWZG3z8Ked6FB1B6jBYBrVsMrgb6r8QzIz7r
 RISbjnfGDqVdQ4vup+B8LrP+4JG4FvFZ7fHpdSJyreylWyvaF/tMu
X-Gm-Gg: ASbGncuJzE3YPbIenayZGnwqjpjjx6miyzHcoIY9ze5tYMecv9kjP6yaS5DGGDCacxU
 oVX5vhXm5URwrKrgeTMnJu+G9aEaMIgUWyMJ79HyHWzUIHTAg4jmNyWal2djBmhFBPjLcqhYF4s
 /TE5PoiZ+JRIzmTmN3SPJd4UXkApMnkF4zX0XQm2IDJFciRjUSwn9B2q55R/twKPxUMUO2ZWEJv
 Es1Lxwc
X-Google-Smtp-Source: AGHT+IGUcGYhtKHKqUlLqLNCGHqOIFK0sLOD+AfwAFosXiI/NAU68Wbk7MFkHCtUeVEjOB8Wg+hKAREXLQMBimkqkhQ=
X-Received: by 2002:a05:690c:6e07:b0:711:16d4:60dd with SMTP id
 00721157ae682-71b7f5955c3mr50256397b3.19.1754167193969; Sat, 02 Aug 2025
 13:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-84-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-84-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:39:42 +0100
X-Gm-Features: Ac12FXw4SNEXiIHGhFvkuE85XTKnUBQjRCXJtHEzgvwdueatGbnCJ_3wpqfn05A
Message-ID: <CAFEAcA_1MrYoT5HitKb2Rf7FUu-sW+LDie7KVHr0so1Q8sPFpA@mail.gmail.com>
Subject: Re: [PATCH 83/89] linux-user: Move arch_parse_elf_property to
 aarch64/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 30 Jul 2025 at 01:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_elf.h |  1 +
>  linux-user/loader.h             |  5 +++++
>  linux-user/aarch64/elfload.c    | 18 +++++++++++++++++
>  linux-user/elfload.c            | 35 ++++++---------------------------
>  4 files changed, 30 insertions(+), 29 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

