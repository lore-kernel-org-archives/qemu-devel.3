Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E98CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5yR-00021J-3o; Fri, 12 Jun 2026 13:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wY5yA-0001yV-GO
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:47:03 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wY5y8-000741-Vu
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:47:02 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6611669cd16so1429944d50.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 10:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781286419; cv=none;
 d=google.com; s=arc-20240605;
 b=G64P7PRfi3JwXBp/QYekq75WTbWfOLk2S9b9eX5GtNNAQwalyP56AqSY2EpqtzxaHK
 Ruy/F19pdPbV4CY04VTJzOMCRhhUlFF43XKAVGQ5Z0Cibobfk6a4wh7vFmLGpVNAfWZp
 OpJOLvwplQVGOOjHaOPGKgSDkpK18zrr/HTIxwCfJGCBtzGYjGzJxWCuYQQRAl4L1C2/
 EiHJzoyXMwLv1ytk6rnWirhw7eIl/3ZRPVthN9UHUQY3vDeWpcDEqAdC17sgwVMEADxH
 ta22ZZhZS9Uplob78rZgQeiWjsAMyT09Qir9S2prXi/Zoig8Q+CTbG1ho+QyyCvbszfJ
 JpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6NYLGsou+SrQn1Uo3K1b+FXzLLeRzUniiiOLWmx22qQ=;
 fh=27JGi1vXTNl9hrhX20mPbsADtWPes3gHon/d+U8mG1k=;
 b=McLqx4wdJEhFa0easBDk1+jNpha8Qn0GG8oyYUSYdJArDNqt+SYvfLpbvkaN8rZg/8
 STRpnvCQlO7X82XqJT2jQuUyRtFE7zfhYglH2zaKa10YO8nGvWPm/TJJle6Dx7lpTfNn
 Kyn71G6z/LaIvSpZIlVaDrK35IlUw4KOxwWaRbdf5yy8YQ/vmDDX08S5C93+0uJYJooE
 nc+QQMhf8RTDJt62GX6mjvEbS9NmqlAVxozah9MmEBMoWqvWZhyJ+XWULzndN4Vv5n2z
 jAleWaJaNGqv7haWbTvAL7EUe6RaYcCprFHD9XZdsnY57w99eBYp0JACcvR2c6I4YlkE
 tAhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781286419; x=1781891219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NYLGsou+SrQn1Uo3K1b+FXzLLeRzUniiiOLWmx22qQ=;
 b=TnAiUDYVIT7N8eZEQbjzC6GRnJU8UoMs4h4UioG3w00x0ikvJ8pne3sNnb7YSsdcFM
 RmoL3iZwB+VUQq8vbNj/Kr8i3OehPEBBkHJtQO00KvcGjhx2eaFsb/3W8+SI2gyw4taB
 L7gJOrePFthuqAwKC8lutKrMEEBYpZ6FYWu8yTBpgxVsW1Fhykk6rXYKDwd2ZFJkr40E
 GCdKDQenfNyjnUr1Tu4EUiwuSWYEDYCcXnDTrUd5HjBATXlRDu7Mej1qKBilb+1oJccl
 O9idX1cho0ZjaPsog884JuEqVxLu5FYIkbRzX32BMBRJamoFeuVpLmjntM7VRl+JMp8Q
 edjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781286419; x=1781891219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6NYLGsou+SrQn1Uo3K1b+FXzLLeRzUniiiOLWmx22qQ=;
 b=hXrSIXLd1WIVRxZbXlUISRzAaC0aHeVmQAQi2A/5qPIxuQ7bc77aoRff+RwMkm8RWf
 ZLj/FRliJGyxJiywem1fANUJLOMkgQCNAW7oGY8JBvrqswm57LAhlzVy6kt7zbqyH7nY
 /YquKlNYgjyQwY9592tAMavJBhtUUPT+ZfJ2Lqo7bAzv91M/Ob24i1RS/MpfSbgNUfOA
 1ssjQNOqoHC4KeWYa8kY1htZa/TV/jqr/hO5vMc7+eP5je4BEpFF871It4vd7DM5K/Vf
 8oHxkgX+BUrkcqcMpLVeZtfTlfRdmQTepWyJXUJjeqR5ZSuW78JnNmHdfGW4piGTLn2p
 GP7Q==
X-Gm-Message-State: AOJu0YzQf6gYqhhGW4ZXndnbL/ibk0+9wHTbnTqoT7sfvHn8tuvIWivx
 9+qQ41huBXPSBOouY67MygjO8c5f6xmCIOMqxnHxtaRI2daRN0HOLynv9CIloq23xOcQv9KnYOj
 R0Aw4l13ISpbTmoeh5u2hM+ZHSvqS4ewwnNoY6DDyCw==
X-Gm-Gg: Acq92OENVlvHx3AsM0KOoe0PQeOozu/nIFwwfQXkURhNbkMAcCkZNjKw8hYgdT4bdCo
 kbeN2U8ZJnI1LEbhZpdGwauxcB5dCpu+A7tJABLT4QRSmMS/aaafdhSKD4z2/EqueFyfZVk350F
 v/wu+0sFQvbc5051xWSSBJRtlQdSQmGQdAKOdmUUhY7noj5oiZn0ohowMQr3qGfkMheUbIuhMPM
 JnfpMEHG5A11/qzhVplRgZgdPq0sm4cuVmCqlpZN5loCaJbpEE3CKNTXKhB9Bw8DKvxEHImLKHY
 1QDa6JgG7MV0G3sRIPNkUMRNFl6O2ys31OyruiCPG5+KTZyACHP9YZZ9oRlkDnurRnk=
X-Received: by 2002:a05:690e:b82:b0:660:1a82:223b with SMTP id
 956f58d0204a3-662780081f5mr3382004d50.29.1781286419274; Fri, 12 Jun 2026
 10:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
 <87h5n7ekxw.fsf@draig.linaro.org>
In-Reply-To: <87h5n7ekxw.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jun 2026 18:46:48 +0100
X-Gm-Features: AVVi8Cfx4_sZkUhwcX_oNU5Emb8YeLHTOGRvGVAOZ3vEMDeOVNiiOkvDqj4FcZg
Message-ID: <CAFEAcA8yNGiKeMpN_wgWtc5EnfjsnxSvG6an4-UjBf6XG+4Yvw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 12 Jun 2026 at 18:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> This series fully models the behaviour of WFxT instructions. We
> >> already had support for WFE for M-profile but we left off A-profile as
> >> it has more potential sources of wake-ups. The main one is the event
> >> stream which includes events from significant bits of the timer
> >> ticking over.
> >>
> >> The refactoring from the previous iterations of the patch have now
> >> been merged.
> >>
> >> I've dropped trying to fully model the global monitor in favour of
> >> taking advantage of the architectural flexibility to have an IMPDEF
> >> event wake up for any reason. We treat the setting of exclusive_addr
> >> as such a reason because it indicates the current vCPU is in a ldstx
> >> exclusive region and we don't want the guest to deadlock. This does me=
an
> >> the system won't sleep on WFE enabled locks but people shouldn't be
> >> relying on QEMU to model real world sleep patterns anyway given the
> >> efficiency of emulation compared to real HW.
> >>
> >> I've written a test case using kvm-unit-tests:
> >>
> >>   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
> >>   Date: Wed, 27 May 2026 12:18:21 +0100
> >>   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
> >>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.o=
rg>
> >>
> >> All patches are now reviewed.
> >
> >
> >
> > Applied to target-arm.next, thanks.
>
> Is it too late to drop them? I've a fix for 2/8:

That change is already in upstream git, so you'll need to
send the fix as a standalone patch, I'm afraid.

-- PMM

