Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0F3C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcE-0004jB-JI; Wed, 30 Apr 2025 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uAAcA-0004aW-Az
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:48:54 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uAAc7-0001sB-Vq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:48:54 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-47e9fea29easo23151cf.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746031729; x=1746636529; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLM5OacbmN5v4uRPljQ6XNHu4weMa0I9QGmzWBc4OJM=;
 b=k8eXlU3Shuu4NhWwEokOnY9sk67NBAjZVIeTftCvVlz+DRfr3kW7dGiIa2Rd02fdCa
 ygQvve+A1TSURA2fyjiMj+wgj7h2x1ITg67VstAxkYPm+qnm/m6KbMN2BR2eUv+Ew+EA
 cEUiPFOMW2Jp7NLM9mmeVFj7FbZAyCiBCTtf1kq45vNYr7i4/BEeu0xSECIIIsr3tSlC
 PODxXULqsb0K+OSnR1dSiW4bOm5ADiDOs051m6xOruCso/3TSgmEG6uwxj+YFX60NVtG
 HoTetraH8u606lv5mVL/aiO7Eah1P2CLPDnp+u2H0HQw/3JKOD6hljlWD9OD6Y38oJW8
 fS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031729; x=1746636529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLM5OacbmN5v4uRPljQ6XNHu4weMa0I9QGmzWBc4OJM=;
 b=ftTXGS+FV23g4NQaNUH0ldgn64pN0oatY1Cv/BNtyFEWJKe7j6uv3mXV/SVn6N1mSa
 Ycl2pD8TAsY/ThRl6lq0qd7wyy5Wclxkl+33mAJZqMNuDDrf+Vxp5Sb9CFwaeI/VrgJJ
 0K3r/TjIVAmUbiC1sGdsn1mOm/iSXPKmS1CQKMljaC1rWJ82aEEkOVgDhbG3J89dVheU
 kADu88a1XUY0I2i+DwrXPb83a1ZNH8t1jc4viUxRN8Ni6bMyhHrbj0KBsPkCiOOUqWHe
 wdnec7GmG3nkN595qTW+Iq2Zlh20hYI05kb2+F3anvqWxQ3BEWuexHqT8SuRAyU7f/bN
 c1kg==
X-Gm-Message-State: AOJu0YyeP7OfVcFlmbGGtalPITsITIeOGB6K6RUEcg/pJxcD2fz9Ngav
 bUZkb2vQdoLloLCZzV/EAZwROr86NrNUWRjEFWiOT+IAgiyXFor37I9i5SAYdWf73pJZ58+wxC/
 SJTnzNdxU45I3gpOph5j3XYxtep6Zw1OIzhSAOKK3gqkSu7eKHdpA
X-Gm-Gg: ASbGncv6xXf/h87G6+gdJCxgzLCl2d2tjxiBU20h+PinrvhV1xpsEz0pnCflzi7ztt7
 eMYa6kK+uMtvGby9raMhYgUch23leawubHqPjAVmapio5vktTYI9dWxCLrlU/ckEszW3W04pBOn
 mf53cCROH39a0A3GL1gpB6A5yH7pyMCxrnp4dAQoKa0rA3NMYLx5I=
X-Google-Smtp-Source: AGHT+IG5ggoqHsVaVDwvHPW7BARgsb5bo6/ilALpFNJrWt5GVY1OYdFtQjAq0zWvoUTX+yTe57k1uoBr5rbnco+1324=
X-Received: by 2002:a05:622a:1996:b0:486:8711:19af with SMTP id
 d75a77b69052e-489b6d76a00mr5458671cf.0.1746031728916; Wed, 30 Apr 2025
 09:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250429155621.2028198-1-nabihestefan@google.com>
 <CAFEAcA-K0B0gfpmG5x92o43aCNp-q3ocrgfvRG+7gN-NfgybJw@mail.gmail.com>
In-Reply-To: <CAFEAcA-K0B0gfpmG5x92o43aCNp-q3ocrgfvRG+7gN-NfgybJw@mail.gmail.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 30 Apr 2025 09:48:36 -0700
X-Gm-Features: ATxdqUEzSPfEO8CuYHN3y8XdOB3_mI2tSN7yi47zaz7cl4sfrywr46jmwzeU80Y
Message-ID: <CA+QoejXO3dJu-ifwaN1t9rK=M5RRBs9xaptE=ik6naz-3oMncQ@mail.gmail.com>
Subject: Re: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com, 
 farosas@suse.de, sriram.yagnaraman@ericsson.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Apr 30, 2025 at 5:03=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 29 Apr 2025 at 16:56, Nabih Estefan <nabihestefan@google.com> wro=
te:
> >
> > v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
> > suggestion.
> >
> > ```
> > ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned ad=
dress 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> > ```
> > Instead of straight casting the uint8_t array, we use memcpy to assure
> > alignment is correct against uint32_t and uint16_t.
> >
> > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > ---
> >  tests/qtest/libqos/igb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> > index f40c4ec4cd..2e0bb58617 100644
> > --- a/tests/qtest/libqos/igb.c
> > +++ b/tests/qtest/libqos/igb.c
> > @@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
> >      e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
> >      e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
> >      e1000e_macreg_write(&d->e1000e, E1000_RA,
> > -                        le32_to_cpu(*(uint32_t *)address));
> > +                        ldl_le_p((uint32_t *)address));
> >      e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
> >                          E1000_RAH_AV | E1000_RAH_POOL_1 |
> > -                        le16_to_cpu(*(uint16_t *)(address + 4)));
> > +                        lduw_le_p((uint16_t *)(address + 4)));
>
> ldl_le_p() etc take a 'void *' -- the casts here should not be
> necessary.

Should I send a new patch to fix this if it's already been queued to
testing/next?
Or can it be fixed directly in that branch?

Thanks,
Nabih

>
> thanks
> -- PMM

