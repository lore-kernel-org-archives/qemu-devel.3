Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697BBCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLX5-0007Uk-V4; Wed, 10 Jun 2026 12:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLX3-0007Nu-2S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:11:57 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLX1-000599-6t
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:11:56 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bf84a2b2077so394532166b.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107913; cv=none;
 d=google.com; s=arc-20240605;
 b=WfIA42OU7Hqm5qSNa9K0b4UqRYaWM4YFSUpMjyX7rnvcA1ro40H/y5Q48f/QDP/8lj
 6mpsWVGfmzP5MYQErUoHZuTig13qvVcI4tQt7pVk0DsEmwCqHdamr0FMBBaetusYQ8ZZ
 IHzEfI0arY9b+P8herNFteoPg64uPZ00NZkqL5OOWd6mvd1MJ1EZdbKkO2JfHr5y+p2G
 IBeFn5HdPTYTHW1ZWDqDYBTQ/ePiGsjNQ5V9TF0M92JimWzP8kKVZPW/BG1BPgn9lULg
 fS0UQXjhZ1G+33YeREjJcXm/4ls81po8UZxq+6Qic9209/uaHV3UOPpeVffKwMKQRgrH
 mLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZZ8zjx9zZtk18xXgGEBK9YE+Y2wE7QAaghjDUbU5LFg=;
 fh=jw9DXqzxbFLNbotWYExY8Ojxy57L0QGPIvV2cD6hoFg=;
 b=Hq9+3Im6mkUt/P04LJUpeatjKh4IeYShamkzOKdpgKrSvKjc27Om3LNHg+gm/EcnwM
 Bm/dOGGMKT7g2ygYmi08kvktNVS70z5J40zXzONXsE5mPPh/FmfCTKZWudgHUrGtt7/n
 UO+Fa6O34I8fPNh3eGCBucghDMb81n3MkUzxS8Gt0P7NcMThH412ORhn/ZT78d46Nl/Y
 BZEsA7KiTAX3e0asfvE+RCgaEB3u9Q/Iyl+YqPUQDzabPKUEchztTUuW6vYr1YzblEWG
 mmbjKCr6C5tEPMiPGSuQiARdf7HqsYqNjCkDYMbd6fSjRmx0s6261flvcvfxWgJZL0oh
 Xdhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107913; x=1781712713; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZ8zjx9zZtk18xXgGEBK9YE+Y2wE7QAaghjDUbU5LFg=;
 b=xRdkxV3WTgT0nQ3BGChxF1a7ee6Ytt7QHCmK3AYzAYW5BemD8fCBoHF2qOHeb6hswz
 Ystl9pdSjPe5QZipytgKdz9kjqCz4lr2ANrj7Hx//yb3Cp0sNb42HxEoItlFVUoarNti
 tHo5TKLzRadnaPmzarth3jmIHEL+QWyXv+ZUaIdl8snwPAbj96mZm7yWUtSX9xXyds2R
 kE0IbL0izuG8t/D89dL+MIlpydFB4m4uIrIkxfXza1cC27SjGn+uxnacG5s9/bGZC56F
 rmV+ZOd3/7lwTGcU22/BFR3Eutpln2QwujRStENF5V97lRVtMTrCV8FMmvvdGvaolKQi
 vLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107913; x=1781712713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZ8zjx9zZtk18xXgGEBK9YE+Y2wE7QAaghjDUbU5LFg=;
 b=ETnYvQJN3iEcIbaV7QcZJfSa9E7sPDcnMy8wlaj+WMBJ4NE4Uxb+qw2fc5ort7dD8X
 xpgrX5/SEiNWIm7LUamxPCg9M/oIfiSbgc7IWM5bVTuV07Hnv8/iE5ied/bRx91wRDkS
 0ujrLlLFHXcifAZYS98PKcdTXXGm0dXyblHnYHpe4vCTO8RERPoam7BpS4SwbE4p434A
 IQTteKm0f+HVA34yGOzOzYCLwVbW+VJfEWNO9NcIsQg4suW13TzKHCSMWVrm96RjCL2L
 I/OiL9s7YcWhjUyHjFxCR5W0J3V+LNzk0HOM2CV+mMSK5Y2gjbizfCldDll/95C2OFUe
 A98g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7p3hxqerKjYEnK9me2DUtYQXZDkzJe0pF1vkddaJgJ1G1TekSDyKaRUPlgoj4WDPQaU+0pTzLzqZ+@nongnu.org
X-Gm-Message-State: AOJu0YxLJp5i7tpy4VHTkrTqOyOTXsY1pbico4oN0LMNaSiBSGMJaW9/
 0+ZskOXglqYOrrn8Ezsmgq8Dep9VyC5GNNrYY1HLUwqIU+7vouStL5ACxS9lIubKfmG4zuILtqg
 iQujXfi1tkFzTBawrRoSNIdeeMcrJ2cMGvRHNvlXEqA==
X-Gm-Gg: Acq92OExk3wPu3zZQDSxnM2CmhIeRlVt8GxTmcO9d5M4YNRTfCA3aVS4I1/+MSDG9lQ
 9m9DR/wftJrppUpVQzLcT2XhTr8l28y3eZkPoCF/6dTomHoBDCYPh/TGBB2UNKQ7SFx7iPDPBD5
 nOoBrlbuRUN4yaee/xmZNu6NXPxU4dCenbwG2vBmiXmBhoPWnHRVHUCn6iEB8FydgaUy8lq754v
 Lx4OU+K030qLdgy5NrdpBxyqz1XSPYJuFVnkZaXvZJc9RvvNxWVJWOAaRzTg5Vr+MWFMm5tN+b8
 DfOpmyL0ijd7bXLDV/1M9ZVOnQwD7OwWC2PIj38BOROCcM2cFzcLae8AmSy0rpOd6EOA9eMxAtl
 hYg==
X-Received: by 2002:a17:907:1c2a:b0:bed:38b8:9b55 with SMTP id
 a640c23a62f3a-bf370e62acfmr1341147466b.4.1781107913368; Wed, 10 Jun 2026
 09:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
In-Reply-To: <aimEl9QQ_LTRPLtd@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jun 2026 17:11:40 +0100
X-Gm-Features: AVVi8CeCs8w8cPJXBR9CpDH2uXDXW3VSGKThd8cy8WMP5mejkCvbFeeiPi4GKu4
Message-ID: <CAFEAcA8HhC-=KwdbNE5jgqdP+H1VF1aJXdGaME8KsaDHhnBG9Q@mail.gmail.com>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com, 
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Wed, 10 Jun 2026 at 16:37, Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > This is the change that broke it I think?
> >
> >
> > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > Author: Alex Williamson <alex@shazbot.org>
> > Date:   Mon Oct 31 09:53:03 2016 -0600
> >
> >     memory: Don't use memcpy for ram_device regions
> >
> >
> > Maybe Alex has an opinion on what to do.
>
> I can offer one idea here..
>
> IIUC the major issue was vector ops but the mr ops might be too heavy, then
> another way to fix it is in memory API instead of using memcpy()/memmove(),
> we always use a helper (say, memmove_no_vector()) to do the split and
> properly aligned IOs as what ram_device_mem_ops does right now, this should
> only applies to ram_device.

If the underlying memory needs to be accessed only with specific
alignment/size, as the 4a2e242bbb30 commit message suggests, then
we cannot expose it via address_space_map(), so we must have
a bounce-buffer. The address_space_map() function says
"here's a host pointer to  memory, do what you like to it", and
the caller is entitled to memcpy to/from it or otherwise
access it with any C operations, which are not guaranteed to
respect any kind of alignment or similar restrictions.

My guess from commit 4a2e242bbb30 is that that applied an
overly broad "don't do direct access" hammer to all
vfio assigned devices, and that there needs to be some
concept of "this vfio assigned device's region is OK for
direct access" vs "this other one is not", such that if
this GH100 card's BAR guarantees it can be treated entirely
as RAM then we can have memory_region_supports_direct_access()
return true for it.

thanks
-- PMM

