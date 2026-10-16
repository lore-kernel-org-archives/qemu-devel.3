Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87277CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHix4-0004pB-42; Fri, 16 Oct 2026 10:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHix1-0004oz-Rr
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:27 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHix0-0007fg-7m
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:27 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8871ada1a26so27419787b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161025; cv=none;
 d=google.com; s=arc-20260327;
 b=XMV3y64Vc9z1D07rWQtnZtH9wnUG4rujODiAJ3OILkh/ZqUJLPK+bT9DG7W3Sdv0Rh
 6OXNboCwf0EtpD+AcH70I4ISJP8HTFN2dO9a4uRFP1I23QEUkuaj1JSMt5AYuXnKKWhM
 o5tpK41x4QugPzG1pD8XLayEqdHf4o8Pr2uf0tge/muQgY2dq7i0NPFTq+8nFLAOyUbK
 TLxoutakfqWUUUIw4djhXCmGLWF6jMJYuq1xo8DMV8gZv+rnv3HPGQNZ7AAr9r89AdGh
 OOl7Ed5OFUTTcwh57UxcE3e7bYElxRM9QhFcRAU34J3mGJ7DUj73dBu4uuU/S/G1rxxX
 cNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bxV2AHunrPB3h3rrR3nedzMyBALWuyk/iThusr9Tmxc=;
 fh=W/JhvAlf9kvTQdSfT2vqiKAkNO4YiRVg8H2M8w9SXbQ=;
 b=Thsxnc4CcUUtGgDVSPDQ5dkH2MGviDp8CKRzCv556elZ+aHeOWivLMlGrC017ferFs
 mwHP3F/fM+Ti8nZh6pUoiZVWq+oa/JqwRo0iawS3yDAF88qRePjiA7eyBsbcnZtYdLyz
 ukoSbygNzg4dlPyY6iVcyAZxrXLfQpZ2KOTXXoaPRWmjnsjkZdD+oGMapEzFI4bojeBs
 EJLNPdFMNGwKx0KLOatjC8QbXGpBKXDxB48BHXDTXY8C2Cr6UDnWzjRMtevpA69AYAG6
 cfjEkLyeUzvNELP+pzTG2GUmzudTjZ0115cyxdMx1fTIwKwkCQZvWf0qo/k1CYui4Wov
 0Aeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792161025; x=1792765825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bxV2AHunrPB3h3rrR3nedzMyBALWuyk/iThusr9Tmxc=;
 b=tdztjnASdguJB279a3B0NJOyxpGzXwO1bdwfBvNG7bPacVVA/IDQJqChJEQGbuaXNY
 d5v9oysSWhmQQVA0Tl9OlB68Lw3RW6MkwcGLKBsZ2rZJyZVRYVcrCU4e5DJEVzGl+YAz
 GNcaM81H27K0ylCXugc7njMRzW4GcmkTu7bZOm1dhSp+4PhnV2+G2Pv3+5kF6+GrkJ5M
 e3GBRMk/a70dNJ0Xa4AjbrLUZtUb+UsKW7Lsd47LL+7ndzIY8bCCkTFxUqAQx9tVhlFP
 rBsYe+TaUURg4mxfKkNxij9mXuIDPKl/nxZCGZMVRnTwZOUe/mkww7BPOJnRKe4UshDz
 YJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161025; x=1792765825;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bxV2AHunrPB3h3rrR3nedzMyBALWuyk/iThusr9Tmxc=;
 b=YiSah/TuWe5cWnmso5seWggjLuKZ6fXeO0csTnflXOD9mLBLyiW1y/XEdSmyuNLwNX
 TYxYGJRJ766V4stnRachW/9kO37XREQxMHAcjpwTvfQyjmbYNASn7aVwGnKva8FPAdEm
 sz9OKhY84s+2bY2aggIscQHN3cH1zrfVhteQRBQYMHDUGNVe5Frl8cFkwI4mHswuoypw
 gpS6foB37Rro3q/5dDe0spKByuQVZ0hkNPlOIkTfZDODaasMK8vOkxBWBYMe3xyaz5dy
 hM0z5toXgI85IrvVA03BJGedrlWXdFICixSLa5qUyWtaniOhASxLD6j2blWC7ccbujoE
 NPRg==
X-Gm-Message-State: AFq9FYJCWAN43fO0+sYFm37Ywa+WjsSZBrpgnluNZ0RUg2bMcNHbUeap
 HcfoXi7aPe87c0yyZtGh59dW2yi5jYjIP9jTlWuyzmnp6MHBwxNrNn/mPQhkcHlvHLrhgREetpj
 2mMy4euBBd4Nj7DS64UQDnW2lSzfQpQ5FBz39ibBJLg==
X-Gm-Gg: AYBFou06MLmQkFRgAsLx+WUAUdwl83nJD1YPUgPP95KRKLo8j2koKifejOKHrP7Tx7c
 aM1yG+YVE+bejVuCaGYxoik+di1L9OmUpTHuXeRx66FCYZoBA7S5h10m3meDRJLV4ZMyQVmfhBi
 X5tg6wBgqRa2dcFENp1tihmniZHcRVM0pFoC3h3Fg6LqQDx3Zo0zrGrbWcJMoYV1ffrBTRXxHGR
 73OEe3Q6ZDAUu51IxHfYBbGZYaGWMyk8D7OlvJC0ffVAIT06M2oS/x3XJDufMnNAWHZ8WIeCCHG
 fv8IpwByUmP8Kvz81JATpEzgixmCMvROjwZwL2IorRvIJlBj7VRmp/2qLlDPFD3MyXgteJLEZss
 cQGJf/SNZMyUUnXbO47uwhisiUNjGylfT4u/xa9s=
X-Received: by 2002:a05:690c:7107:b0:8b0:e1c8:a47b with SMTP id
 00721157ae682-8b0f1f1b000mr781547b3.0.1792161024563; Fri, 16 Oct 2026
 07:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
 <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
 <atHrFXxyIl3Nbvht@redhat.com> <atHu0kCSQTD9E34p@redhat.com>
 <CAFEAcA9PTB=1V_hV1P0xpEW4aY+4LajYyzKzyTOJj=bb9=oPvA@mail.gmail.com>
 <atICMoFG2gkoHWJ-@redhat.com>
 <CAFEAcA8hJ_WK+4itRtQiJBtDnd5TfA5jrtrcF2qPAj0cnJ+U9Q@mail.gmail.com>
 <atI0CCfUsBR2kqkB@redhat.com>
In-Reply-To: <atI0CCfUsBR2kqkB@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 15:30:13 +0100
X-Gm-Features: AclHuK-8nV9zmT3vbQlczFxx81gGhQ7RS1_MEtqwBOxk0CZJDPMNmFBFJPCB9lI
Message-ID: <CAFEAcA_nspUoMrvWp_TW4smh7AfwWWjg_+5Qrh7aKiZ1mbvj_w@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 16 Oct 2026 at 15:26, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Oct 16, 2026 at 03:09:55PM +0100, Peter Maydell wrote:
> > On Fri, 16 Oct 2026 at 11:53, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > but many (most) of qdev impls don't use the relatively new
> > > OBJECT_DEFINE_TYPE macros. They would have to instead explicitly
> > > reference the parent type name:
> > >
> > >     DeviceClass *dc =3D DEVICE_CLASS(object_class_by_name(TYPE_PL050)=
);
> > >     dc->realize(dev, errp);
> >
> > I still don't understand why we need to get the parent's
> > object class by name here, rather than saying "give me
> > the parent class of this object's class".
>
> No matter which realize() method we are executing in, the "dev"
> object parameter will always be an instance of the leaf class "C"
> and thus the result of object_class_get_parent(objct_get_class(dev))
> will always be B. That is only correct if executgnig "C"s realize
> method, so breaks if we need to chain up realize many times.

Ah, thanks -- I finally get it.

-- PMM

