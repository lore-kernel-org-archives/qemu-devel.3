Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD6ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ozu-0006tT-9m; Thu, 25 Sep 2025 12:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1ozd-0006q9-0W
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:38:55 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1ozY-0006BZ-Ag
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:38:52 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6089a139396so102920d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758818322; x=1759423122; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dIB4ikkGPpd/LQWWihg21QzJdZhbbIkOBvpKAKdXc98=;
 b=lWBXaPWgmk57nTLvlpVfwC9LvCSSAk1KzDMlbaflMgnJNFNE43b1SZ0/PgAytL9LLg
 Y8RBQVHI7aO6RYfjAFtfSWXzW7iJF0yVhaw+ankKMdzMKNl+KoOtnkofwgKGu2D5WWnj
 qWzenf47Qt/T0XJwxxnYl9TyyxEceEdAUIXeQDAfiu7YdxCqeMuZ2+lOdnMiaCccjnHo
 ukNQADaz5kljy/bPXk1RY5BKFUi/W1W5uxybN2O0ZJzku5D1Mphp/fXNACXw/y/bcXzi
 MmTwMxtvm1y7hv3E+FgfkcXLAYLeL/TKA036ZjYEYpQprpesAPeWFt1W3+mk9MdUqFMl
 vLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758818322; x=1759423122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIB4ikkGPpd/LQWWihg21QzJdZhbbIkOBvpKAKdXc98=;
 b=QjTS7M1h/6TFMNQ+mapLTc2cORMOjYV2AYdn/y5PX90SaJi7irTT4x76SUwkRr8Enq
 0Wd6z5REyUmIFwVJcYHx2GbH6xn0EANnPOFny0Qnd4nNb+9QxfgYNds35c4/C+uWZGVK
 hYv0nuVM7WA4jKPLCgm0mD2qMbVuS4RQ1LIS76jhZsHxsOXpKipupr8pV8aSpaO2fMBo
 VePtaSoOcoo8kr28yh5mkrYU1/AElqk98gKOyg6QxEEos1+cgv1GG+wmpOooA/mQQuZ7
 8wHrGWs0i3jarGq4u+ZncCCrHqlRo2GBr0c0klRbA3Q3hr0BjLkVSPM1S1vf4kCEx9cS
 g2rA==
X-Gm-Message-State: AOJu0Yw2vNYBbwce9zai2CJ+a9SxJeGErflGVCbOr2WzlMaatuJdD/oj
 VVg9ejGbGlESSmPtFo0RlU4iSl4LHMVTTusgxD8rSipQvYMEBXGLhB0BMBkjJbu8ARDypzaP2rZ
 d8HqsivTwwH3hTyR+iEtL8maTsv1umCaW9D6ZghHHwg==
X-Gm-Gg: ASbGncv8ptlXUVE2CY48qABm8HP1uIdLLFSOZJpIpLBw5QiZ88/5LziO/cNNoC43iPb
 V1QZDnOw/asXkirHvNnmJOZAg59H0u43R1kERfAAptyWBanXbIy5fo3eAHFeHkEP7GdLDFgD0gh
 hS7MQ9+4Z4fv9d2NYcjuqA0PYfi4PWHoa9KnP8Uq3nf3huS4dAQnCTdO2vWySOdaqcCi1NfAYDo
 zT2T0xg
X-Google-Smtp-Source: AGHT+IFvTkTQ7g2XXsPfqxMZh2BUR/Ijb0GBbNjExY374J5YpX9/KNJjxAdomatUm6sJnR82sDBkjjEx2oFY60eWpC0=
X-Received: by 2002:a05:690e:1699:b0:636:cc3:af35 with SMTP id
 956f58d0204a3-6361d696f45mr2309384d50.22.1758818321797; Thu, 25 Sep 2025
 09:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-2-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-2-d85883b2688d@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 17:38:30 +0100
X-Gm-Features: AS18NWBzDo_cx4HsJw0UkXHFUOYxAteuB0B_pGGIqMgdEUEUYVa6CJ-jLQzyZ4g
Message-ID: <CAFEAcA8QAj54xxTfk087=8dERGiM28Bz2mw9eVtMd6qNOd7aYw@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/pci-host: add basic Nuvoton PCIe window support
To: Yubin Zou <yubinz@google.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 9 Sept 2025 at 23:11, Yubin Zou <yubinz@google.com> wrote:
>
> From: Titus Rwantare <titusr@google.com>
>
> Adds the windowing registers without address translation
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  hw/pci-host/npcm_pcierc.c         | 223 +++++++++++++++++++++++++++++++++++++-
>  include/hw/pci-host/npcm_pcierc.h |  77 ++++++++++++-
>  2 files changed, 297 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci-host/npcm_pcierc.c b/hw/pci-host/npcm_pcierc.c
> index 3afe92e264f6ce4312e94f05b5e908840008df64..bffdec71acaba6562856b3bdd8aec07c3c153323 100644
> --- a/hw/pci-host/npcm_pcierc.c
> +++ b/hw/pci-host/npcm_pcierc.c
> @@ -16,6 +16,193 @@
>  #include "qom/object.h"
>  #include "trace.h"
>
> +/* Map enabled windows to a memory subregion */
> +static void npcm_pcierc_map_enabled(NPCMPCIERCState *s, NPCMPCIEWindow *w)
> +{
> +    MemoryRegion *system = get_system_memory();

> +    /* TODO: set subregion to target translation address */
> +    /* add subregion starting at the window source address */
> +    if (!memory_region_is_mapped(&w->mem)) {
> +        memory_region_init(&w->mem, OBJECT(s), name, size);
> +        memory_region_add_subregion(system, bar, &w->mem);
> +    }

This looks weird. Generally devices should not map themselves
into the system address space, although some of our older
pci-host devices do for historical reasons. Should we
be modelling this some other way?

thanks
-- PMM

