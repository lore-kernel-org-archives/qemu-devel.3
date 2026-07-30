Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B85BC5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpXKr-0002h3-UT; Thu, 30 Jul 2026 16:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpXKp-0002gq-Vc
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:26:32 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpXKo-0005xY-75
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:26:31 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664b05d408bso126584d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 13:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785443189; cv=none;
 d=google.com; s=arc-20260327;
 b=rVbeeK2m4LgA9ORCQ4k5mvrY0Csxurqpmhx/WOFKUqIMSRo2eGD5QK8zkq0CsoZ6Yk
 kfXVy7c5wTgbQlJQGa9HxQJqBCT6Uwyg/GHfYvz3ODdXoO71BJs47fZLTZdD2jUSQsR+
 bkLgqyuxatFsd9SBJ2KGt5W8fPYxce+mdmk4bhjmU30241tHjdkM6WprWVKgpLMHY6X/
 gv2jPXP+zyMdBSqilOVUT43mZKWw/JfiE/EZJcTPQZjvAEoWQmamxffBxDceDErxnhj+
 r1byargL393nXULZuvupa54I4Rr5SReTByXyzeeJ1IXg3DtHLX83xWiipODTUt6j2IF2
 afkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7GdvycCNaIvEdBUSG05rClIhRTbx4L+HpG9U0AVT4q0=;
 fh=Mwuq573iCp9M7/4LHhrrdtS1U7mxXVvI4mYPg/mZOH8=;
 b=AHaOmKMej+D8cR/FxF6xvr5jpvAOJpZTF8nk4yapE/bkmBGT/rKFG4ne6P6eVshM/R
 C5/TidSjHllvTQelQ1vkdurSboKa+rQW3OV9TkF4d9AC2oBpbb4rA6is9cM8wmpILJAA
 lg6bbJPFPEKzcDnknQq5ofawYu7DGmrt1RQkMIYAhyxzwn5sVGVHxhS6rov5d5qWldwL
 QeQjQKqzqRipabsaOKnFvJExngJdbwc1rQptRoo/QKqGivOI9qh8mSAPS/hRiOg1841i
 54ryezbQUrCecuce/N/jNANIMJb4pp6rFJFD09wD2JnNOeD0xUsrfIQ4qSdjpqm4YtkR
 DN7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785443189; x=1786047989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7GdvycCNaIvEdBUSG05rClIhRTbx4L+HpG9U0AVT4q0=;
 b=jKmMjpIzYpToqI1n1OS6nnNFkYmOjR5yZUVYQ44MDy/wl/q83a4OblkGLuksrK2Xqp
 335kGL0d8LlE53RgmWhIV+7XNEMQLWUGE7c1qXWRso0okdvOmsrjw0kQ3wrbpqLWgMhP
 3ve6JSQUXUz6dDlzPBs86xzs1ThhOYarwn7aG3xHbH2lUj34E44HaN1gPBYwbaJu20c4
 N0axIVdjVthqLCYoB9Cz2TEy4OocqoaTUBLK0ZIdFJcyuCg1VZEAcrtRI+jBx0iuD8qG
 TaxPxqPLGPIWalrSeJx6N3ngDXPtcE+bVteu4+DtGpIUHWmy+XLJWZGj2C4Gtnj4LXZi
 yHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785443189; x=1786047989;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7GdvycCNaIvEdBUSG05rClIhRTbx4L+HpG9U0AVT4q0=;
 b=Jde+3hyFVs2teMuh8HTA63LH8Iyq7woxd0IthG0mbDxnWOuK3acRjyCBYPjJ/5Af/1
 fLZs1wI4yR+GIXkJNSq3vw1LmngK7SsPXOUGKEqzQzb/3Wd0Dj39Llt3AVVvxnUy8EOU
 OJNdKUzkAgg/HA8JUmdlnV4xG4IbUbIjt/kTjBsUBjOfXurDbzITu7wzHBRkmoZeNECb
 WeLE1lkFFpSp3GJEKnkTUkDwARSoZdRgsyrrCu7yUGr7XjUggwUH5LWWySIQj80SuCcP
 n7q6D8zWf873K7jKmX6iCBgLS5x+xOYelZtqob028NoCCdQ5AZ/SyAIP3wWMmxD0z/QS
 PTNA==
X-Gm-Message-State: AOJu0YyILciL1lk92MT64AHXggwp10gD3avsSE1S6IO+YO+bH1BIJ76k
 e9NJncId722970o9DQGRKVe5OvKmyzVQw2+4bS9sdjEN/48tH56rtTSg4uRbSaNwHztWXOAb+S1
 g7jjwpCOTe571D745s8p966bPpUsbQcD9koxJOclGLg==
X-Gm-Gg: AR+sD10Hn+/l32PLz3VlKQlOBfcnyXJM2d/7pGle0q1SDfcs9+4ivrd6ObwpFQ/C0V3
 DAYbIskXYgkuRn8/JY4H55NOgD15k4f3Lv6j6OiTix1lxvFhDyOdYPGaJsECBO7MfcfTeTMr5n/
 YSViWvS9cxeTWN2/zAHzRT1aQfOBYLY6jfGhNX1I2rEuLj3BGO9FyzPCCmEAR/XcI8teyGs4IEJ
 k13hPCDeAYZpXR5OjMXPRSNBGPqCWVU1lDyUTZUeQtxdgJSRfwqP15NaK/2HaZPqDye/uDrBoG8
 6uWhAbDEvKqPOrOIz7fRCbtj/JnAAyrXx8e5YDXJrIC6MkP5sthTzfZfs7dc7LDvGt8hXSm7QKf
 uo4ZMBuIyfmftTaZriW3/d+PI/c9F
X-Received: by 2002:a05:690e:43d7:b0:667:af05:2e89 with SMTP id
 956f58d0204a3-6692f7d345fmr2023070d50.74.1785443188710; Thu, 30 Jul 2026
 13:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
 <CAEUhbmW=02DNwVH7pLtuWBzEnEVJiJNrZVcys-pLY_cS0uro1Q@mail.gmail.com>
 <CAFEAcA9DB+j3KJCM9yxVoSzQaXgx4uC_Bb7qm_p+OwS6EKn1fQ@mail.gmail.com>
 <CAFEAcA9t7TjhCSZ1EyBOPStu6vadq3UA9FMgbWOqkqfM0aMDoA@mail.gmail.com>
 <CAFEAcA9O4naO3WJXYL_qCZAvoGRchEryFnBHMJm-MT0+CjH=aw@mail.gmail.com>
 <CAEUhbmU18Z7zvkErg_CMvgnhkJuY69oON6SjoiqvCbrrG8g7gA@mail.gmail.com>
In-Reply-To: <CAEUhbmU18Z7zvkErg_CMvgnhkJuY69oON6SjoiqvCbrrG8g7gA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 21:26:17 +0100
X-Gm-Features: AUfX_myBlavwPdBD4vDXdih44wTmiIFa96taWyvn79ADh0evYRkbkTHHUU5TjhY
Message-ID: <CAFEAcA_NPkHt+b1vQwqhw3k++psxrqd+oUA6Q=hAebU0jHMXJw@mail.gmail.com>
Subject: Re: QEMU net code and padding of short packets
To: Bin Meng <bmeng.cn@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 21 Jul 2026 at 12:34, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Peter,
>
> On Tue, Jul 21, 2026 at 12:22=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > On Mon, 29 Jun 2026 at 17:31, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > > I'm also looking at a variant of this involving vlan headers:
> > > https://gitlab.com/qemu-project/qemu/-/work_items/3518
> > >
> > > In commit 63b901bfd30 you removed the code from rtl8139.c
> > > which handled padding out short frames in the device's
> > > receive path, because we now do the padding at the other end.
> > > However, in this case the padding code in the device was
> > > also handling a case where there's an 802.1Q vlan tag: it makes
> > > the buffer at least MIN_BUF_SIZE + VLAN_HLEN =3D=3D 64 bytes, with
> > > the comment "Include some tailroom in case a vlan tag is
> > > later removed". Then later we use this to avoid the copy
> > > from the buffer reading off the end, but now the copy can
> > > read 4 bytes of data off the end of the packet into guest
> > > memory.
> > >
> > > How should we handle this? We could:
> > >  - reinstate the rtl8139 padding code
> > >  - make the generic padding code allow enough extra space
> > >    for the 802.1Q vlan tag (so devices can assume that the
> > >    frame is at least its minimum size even if there's a
> > >    vlan tag)
> > >  - have rtl8139 special case this
> >
> > Ping? How do you think we should handle the "short packet
> > with a vlan header" case? I think I lean towards making
> > the generic code deal with it.

> For the VLAN case, after looking at it more closely, I
> agree that the generic padding code should handle it. A single-tagged
> Ethernet frame has a minimum length of ETH_ZLEN + VLAN_HLEN =3D=3D 64
> bytes without FCS, so padding it to 64 is not merely providing private
> tailroom for rtl8139. Ideally the helper could derive the minimum from
> the L2 header length, which would also cover double-tagged frames.

Having looked at the 802.1Q spec, I found that it actually says
that a single-tagged ethernet frame's minimum length is still
60 bytes without FCS. So I now think the problem is that the rtl8139
code is unnecessarily trying to pad out the input tagged frame's
payload more than it needs to, and the fix is just to stop doing that.

-- PMM

