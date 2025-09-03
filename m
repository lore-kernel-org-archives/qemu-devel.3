Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F12CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkM8-0005T3-ME; Wed, 03 Sep 2025 06:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utkM7-0005S2-Av
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:04:43 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utkM4-0006zv-CL
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:04:43 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d601859f5so51930547b3.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756893879; x=1757498679; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLnF/PWxjqDw98TzxezpnHrRLMFynJS1lwemkijNEo4=;
 b=UdxO5XMUAgygXTwaqjfZ7xM0x1Wmt+qUJBGiNCABr2i3+kFKEbuBV0gwl80vln98He
 +KUFGkjV0Gwhf7vj8KlFI1fjlM6f9lRCI8+FOBE+ANWw4qADwyqtb7dg2A8GuXXS/r5o
 chmJLznVj5pv1HQf6ukIge7cqbWz6WmMFDbZG217AS3o1SqNgQ2jbm2SFH7hDbHDPYVk
 qDR9P2I9sPV31DakS5nVuIaaMm9PxH9HzzQzFEzB4C03mSGHJXQ5Hp62cxqe/ssfQSMi
 w/HwgLdHkJEiW+e1IAJ8KNvMC8BEBEscaL9+tuyIq/k5hnA6ebAjgo8ixgrCvd3aBiaH
 IoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756893879; x=1757498679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLnF/PWxjqDw98TzxezpnHrRLMFynJS1lwemkijNEo4=;
 b=i4Y1aq6mjankCSTKg6nfeA8o/WJRVOYfILroFkpy8Yp04yfnvNzOlSNeHduaYk4WfY
 mW7LrHyUNSQQHFnCGMe0gf6LiJ3NYcTDH5pUt4aN5HFdCZcpQFJ/Cm5K8D+6VciLjRGG
 LllOHKWQOZ1OJ4XO0jy9ZiW+tEEronJioBp/PXwVeKQEh9jFcry4uX/sj3N4V88st+dg
 bKDIklw846x9dF0LrgtcQ7wUX5mWPRXjtehO/yOgdj0N6FzKWbN7CLsO4QsBmW8QcGTu
 wYWBAav3PUhumXdbKVDUueq6/lqDwU1MhnDutUNEgkVKC4jogKxE9DBmOyQBPUR4jN2G
 Elwg==
X-Gm-Message-State: AOJu0YybkIPfk9Lmma5D88W3JcHg5azeEPb54C+A7XoNRYOmWUYKXMLX
 0dUqR4GwSX5ZfkKXN0QhBYwPn3OdCc/4LQdmWCkJTf/vs1xYiDUTNGOgwbTTUg4YXhzp/NqtjJm
 ad1ugPJ7Uus11ZXtktkRc7DuGI888JpfHSd2OjTghjaA8kCs/ZEXo
X-Gm-Gg: ASbGncu+aTQDTPp6xI0oX1I11CZOGAheLV85XLXmlyyYn1PCJsFym382A9hMHMtnmpv
 MvWC6jcKc5s/paIRuP3jbvBOrvD0zqXQG/j/w0uEbcoHMxLygUvTJBu62o5gjO//j1x3DIDMcbk
 C1+bi71BEfnGZOK8T7K74EEg9BRM6PEZkU/vlTvsOhea+SpXQmQc/LT05bspZEbjPZrSpk4c48U
 Xx8vu6oj911DWTglXcuuz5N8ksUEQ==
X-Google-Smtp-Source: AGHT+IF2AYpyDc5IczJyO0kY7GHyQB4/UaCdZ2Hav+806iLDPzJ0BmtwR4idcAAgOEcaa6Ea7XRE9Knu6AHLSERpWII=
X-Received: by 2002:a05:690c:6f86:b0:724:2cad:8dfc with SMTP id
 00721157ae682-7242cad9357mr4614737b3.11.1756893878837; Wed, 03 Sep 2025
 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-3-alex.bennee@linaro.org>
 <CAFEAcA8WNFs5HGScaB1bs-u8bHT1MbS8BvWXefx-eSd7dCsz=Q@mail.gmail.com>
 <877bygymrc.fsf@draig.linaro.org>
In-Reply-To: <877bygymrc.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Sep 2025 11:04:27 +0100
X-Gm-Features: Ac12FXxVgySH3rRuawjYKAGvkvimvgiIek-goNCTDw8Vp_r8fAa9cxhrBgarzgc
Message-ID: <CAFEAcA-VZM-9P2t6v_JMEt3eF8dUKfH8i7CFZt8cL9XLSnPTMQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/arm: use g_autofree for fdt in arm_load_dtb
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 3 Sept 2025 at 09:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 1 Sept 2025 at 13:53, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> With the fdt being protected by g_autofree we can skip the goto fail
> >> and bail out straight away. The only thing we must take care of is
> >> stealing the pointer in the one case when we do need it to survive.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  hw/arm/boot.c | 29 ++++++++++++-----------------
> >>  1 file changed, 12 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> >> index 56fd13b9f7c..749f2d08341 100644
> >> --- a/hw/arm/boot.c
> >> +++ b/hw/arm/boot.c
> >> @@ -519,7 +519,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boo=
t_info *binfo,
> >>                   hwaddr addr_limit, AddressSpace *as, MachineState *m=
s,
> >>                   ARMCPU *cpu)
> >>  {
> >> -    void *fdt =3D NULL;
> >> +    g_autofree void *fdt =3D NULL;
> >>      int size, rc, n =3D 0;
> >>      uint32_t acells, scells;
> >>      unsigned int i;
> >
> >
> >> @@ -673,14 +672,10 @@ int arm_load_dtb(hwaddr addr, const struct arm_b=
oot_info *binfo,
> >>
> >>      if (fdt !=3D ms->fdt) {
> >>          g_free(ms->fdt);
> >> -        ms->fdt =3D fdt;
> >> +        ms->fdt =3D g_steal_pointer(&fdt);
> >>      }
> >>
> >>      return size;
> >> -> -fail:
> >> -    g_free(fdt);
> >> -    return -1;
> >>  }
> >
> > Previously, if we get to the end of the function and fdt =3D=3D ms->fdt
> > then we continue to use that DTB, and we don't free it.
> > After this change, if fdt =3D=3D ms->fdt then we will skip the
> > g_steal_pointer() and the g_autofree will free the memory,
> > but leave ms->fdt still pointing to it.
> >
> > Since arm_load_dtb() is only called once it's a bit unclear
> > to me whether this can happen -- I think you would need to have
> > a board-specific arm_boot_info::get_dtb function which returned
> > the MachineState::fdt pointer. But as this is supposed to
> > just be a refactoring patch and the previous code clearly was
> > written to account for the possibility of fdt =3D=3D ms->fdt,
> > I think we should continue to handle that case.
>
> Hmm I was thinking we could assert if ms->fdt is set because we clearly
> shouldn't be loading one. For arm the only thing that sets ms->fdt is
> create_fdt which also implies:
>
>   vms->bootinfo.skip_dtb_autoload =3D true;
>
> so on start-up we should either create or load - not both.
>
> but then I am confused about why we do another arm_load_dtb in the
> machine_done notifier.
>
> Either way I can't see how fdt =3D g_malloc0(dt_size) could ever match
> what might already be in ms->fdt.

Yeah, I don't think it's really going to happen (at least at the
moment: if somebody refactored hw/arm/sbsa-ref.c so that it used
MachineState::fdt rather than having a sort-of-duplicate
SBSAMachinestate::fdt then I think you can end up here).
But mostly my point is that I don't want to have to think about
this and audit all the arm boards with a get_dtb method when
I'm reviewing a patch which is supposed to just be switching this
function from explicit-free to g_autofree...

-- PMM

