Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C3FCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24Qx-0003O0-58; Fri, 26 Sep 2025 05:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v24Qv-0003Nr-L3
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:08:05 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v24Qq-0003o7-FH
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:08:05 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-76c144b06fdso9260317b3.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758877674; x=1759482474; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jeWlD2+XvDuF9fZefYX7rm/bH2gHCJ471Q4sat+U148=;
 b=ZT75daTiTvIpfw2cWlDdhKfQF4p2I3+cMY+IPrZRX/+lHZZM2e7pQe3x+nbkGYVsfF
 0WZFQr+e+y4m0jJx6a5Ceo2UeeNSqoAd52CYbmb2kayQHeZKHtDTQvA7ZqDOuWWEU7UA
 2tpGUYz/1h9MjZRojbjV6IhgPmtjF81E/uk/xDZJ19svTYt1ggkuuxLg0q9+dztJj6wf
 P+mV6fZrat4pkkkV05F0iSVHDOeJeTeMct5ddQOLxLkXBYtkyvsqSpUB088+lo7mYVnY
 Eg1d06xKR7Z4eYs4VA105Bo8OSkIj8TcPSwNqnTStSTh608ax8OWzEfhMswM8yPlOStI
 Ii8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758877674; x=1759482474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeWlD2+XvDuF9fZefYX7rm/bH2gHCJ471Q4sat+U148=;
 b=rnrY0BMusvDfZoduRqpdrmqjXVXG5gC3GYhH0MenVMfBiEgvwIbJBA4Rq2kOYPyZGw
 8d7NwsIHV9uU9mLw8UnKnTlK0Yqwsk1JDsM3vFLM+v5Qjw6/tBroZO6NcO2Ky6DqyxSv
 q6WuVWszulwXeT7smPzdXL+ILKhJOncahP44DRxmJS+SSrhDMWevukQxc0mzBvydZQmN
 xDbubKVjBvrYQz9XZ41I/Lm/lg7ut0w0+Aw0+5t/5ZjhWvd8e9V4pwtMzEHwq1mxI58c
 qYemQhuhAAS/OQlSdGiUXjV1W0lHQzNA5LjJE+rtwoHc4wL/WwuZWVP8tg3zF/vmLcIM
 LhHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzoiv3ED0BQ/KRm90n6B/Um6qrHwOJ17syRsW7WY/2pETFLMwRbC0r047AysYHk9WtMnrYXphQ1Rvo@nongnu.org
X-Gm-Message-State: AOJu0YyaPDHNaOSO5cibrR42P6JZ0z5KvGi45Xt5oGh+ebbsqbqxReaJ
 xa7mS9d4VgT00RufgYdub/oa/PhHbFt6dKjlZJZ1lMdAf3DAt5leNtHYG5uo4ywNE1/85bQmhSW
 c5tJxTZyLYjBfCTjnncdwzkHE2f1TndX8pel9th1y4A==
X-Gm-Gg: ASbGncsWQJR6I0QFT7reEDT2AyTZDRkpO0jYgmkaHT1wpngx7Rp1fqIQqs1PaEHOhGa
 AwTPQwEO3ioyNTQkPcBaX05q6Yhj0wjhHgl0Ffi2XN1G2VhD/NMGhyMnc15qRQ/UeSPq7PzDvUM
 ZAKhv7xdA19atKiQzGFaecplZTGJ2nih1R5ejiXObHk2XyplqEnX2ulLxsvNmxioXDivzdqWgUZ
 FNpt3kJ
X-Google-Smtp-Source: AGHT+IFOMGBVv5oQXI7QdzmGXwDMo3l8U1B535wsVZBkCeT7lfzZ/P4Rfi+eSrSh2RJhMINsvNns8svqneGQF1F7hJ4=
X-Received: by 2002:a05:690e:4303:b0:633:a260:14a1 with SMTP id
 956f58d0204a3-6361a735958mr4326863d50.18.1758877673594; Fri, 26 Sep 2025
 02:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-2-d85883b2688d@google.com>
 <CAFEAcA8QAj54xxTfk087=8dERGiM28Bz2mw9eVtMd6qNOd7aYw@mail.gmail.com>
 <CAMvPwGo-PpapVgYG9RRdtzEOzFzgn1++f-uTHyyDHzfjyNTPfg@mail.gmail.com>
In-Reply-To: <CAMvPwGo-PpapVgYG9RRdtzEOzFzgn1++f-uTHyyDHzfjyNTPfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 10:07:42 +0100
X-Gm-Features: AS18NWAJ5f40w1WFD01kVlZJ6hQSLN_rnlyBQjCdwJpH9-ZGGQSP7Z0u1dh3jR0
Message-ID: <CAFEAcA_-3GeW5Y0WNXXqDJn394vyp9FfHPLZSx6J3VRZBW_kjQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/pci-host: add basic Nuvoton PCIe window support
To: Titus Rwantare <titusr@google.com>
Cc: Yubin Zou <yubinz@google.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org
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

On Thu, 25 Sept 2025 at 20:40, Titus Rwantare <titusr@google.com> wrote:
>
> On Thu, 25 Sept 2025 at 09:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 9 Sept 2025 at 23:11, Yubin Zou <yubinz@google.com> wrote:
> > >
> > > From: Titus Rwantare <titusr@google.com>
> > >
> > > Adds the windowing registers without address translation
> > >
> > > Signed-off-by: Titus Rwantare <titusr@google.com>
> > > ---
> > >  hw/pci-host/npcm_pcierc.c         | 223 +++++++++++++++++++++++++++++++++++++-
> > >  include/hw/pci-host/npcm_pcierc.h |  77 ++++++++++++-
> > >  2 files changed, 297 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/pci-host/npcm_pcierc.c b/hw/pci-host/npcm_pcierc.c
> > > index 3afe92e264f6ce4312e94f05b5e908840008df64..bffdec71acaba6562856b3bdd8aec07c3c153323 100644
> > > --- a/hw/pci-host/npcm_pcierc.c
> > > +++ b/hw/pci-host/npcm_pcierc.c
> > > @@ -16,6 +16,193 @@
> > >  #include "qom/object.h"
> > >  #include "trace.h"
> > >
> > > +/* Map enabled windows to a memory subregion */
> > > +static void npcm_pcierc_map_enabled(NPCMPCIERCState *s, NPCMPCIEWindow *w)
> > > +{
> > > +    MemoryRegion *system = get_system_memory();
> >
> > > +    /* TODO: set subregion to target translation address */
> > > +    /* add subregion starting at the window source address */
> > > +    if (!memory_region_is_mapped(&w->mem)) {
> > > +        memory_region_init(&w->mem, OBJECT(s), name, size);
> > > +        memory_region_add_subregion(system, bar, &w->mem);
> > > +    }
> >
> > This looks weird. Generally devices should not map themselves
> > into the system address space, although some of our older
> > pci-host devices do for historical reasons. Should we
> > be modelling this some other way?

> I can update this. What devices are doing it the new way?

I'm not sure exactly what your device is doing here in
general, but typically the device exposes sysbus MRs
to the SoC and the SoC maps those where they ought to go.

Is there documentation on what the hardware behaviour is?

thanks
-- PMM

