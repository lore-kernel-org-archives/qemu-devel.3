Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F17FC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeEQ-0000bV-9l; Tue, 28 Jul 2026 05:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woeEM-0000ab-PX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:36:11 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woeEL-0006cE-CC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:36:10 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66843536f94so3693030d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785231368; cv=none;
 d=google.com; s=arc-20260327;
 b=NbmposC2zCVrIuTCvQJ2siZI6ovO04HtMbz/pKilVFx0EAeK0cmJvTW/XlImcX8fmQ
 Jgt0d8wz1k0tnDWVhCFBvJkj4zGqWqDY+8k0Do7+hbgcZyZEjbBO29HddrX+k6OHmkxn
 KIY7L1OfSwkRq/lkMVkIBuMjv8jaXD1D2AE+UkgvqUlk1H50l8URKOwSU52wJR/w89G3
 ui1tF9xagRDPZYhjx7m2AcGarP2FdGywAI0MhLAEnJgmLxbEdP/u3nGUkxNEE6XyUV6g
 ccllf36uGSimY/he5mrwxI/Q82EoCzn48PckAL1BQClBLh+A93KHY8Dc5TQikWFvoPDW
 qlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bQ8g7wh/VQmeuL3pf7641R7XPUOWCoD/LSEhd20H3PI=;
 fh=bNSRRZzP95yNPSGnIOXEYnS+DORMT7Z9hNb6PXNQ0mE=;
 b=VO5lWhaXDxQSiQ9Mci31T5PewxXmAqx08Lq3qZ3IWtAG/eyKz6ix7ls9Pxvv7zfg+K
 WaLLaCRU7HXafwzWkdHKi7aJZJPlmQzSr9r8GIi0zpDK4qz/eOpZe4OrvbyNusY+GI/K
 haIEahTMsOtbHza0dyYMAt/OG8X4H6E1EOfdmIoR9W+RQat/w3ArQkE/1eH2m5ywbFID
 qPPIdM5m8Yuz/yG5nF/5hbAIR3ruaJ+mxRrY+dlXoNOPXq34k+2KxJ6uVgano+aSRDVL
 Qs00tzpaxRfyYN551mO7x/n43r4VTSmBzkpGKKS5r4tFB4Ij5OVhBOcuC3YTPhUgW8SA
 EwnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785231368; x=1785836168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bQ8g7wh/VQmeuL3pf7641R7XPUOWCoD/LSEhd20H3PI=;
 b=V2T/7LwLJC5hmBfKBTOnBast5vdk92h5CuPYpeCxlHOO/Lv5vfATEKkLf4ghVcpZKG
 cFAgDMg6kUrrY0DG8EiT7vMX26F7hgoIAf0KvK06VJbMXDbRYp0uklSmTNfkh5zT5fXM
 9avPzhYO6BM4f2m6xadC0dS5z3nwfBQtzhA33qXVeuxG1nZ86PewIVWn30eZBcmTck3n
 6hRDkizFCCPoTh1nBjmhBuWfXaXfHfRDYmNdogmnHViLkI/OxZGObRvZL9gumJCflPvH
 w6NHsRwLSpLn0pTdDjmmtUFhfKN7O2GxYPYmnqqpl9Jyt69xJ1pI+aVRftO5zql6oR+E
 tOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231368; x=1785836168;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bQ8g7wh/VQmeuL3pf7641R7XPUOWCoD/LSEhd20H3PI=;
 b=KctWO0oPHK/ADxWjm76uAtWtVkKzyyelCPeNwvx8HqqKlJhhXF4Ru4Y1VJaldZYT+P
 sAoGJtJhmbgx2mVlLWcNnd2YnzOTbVFEWzP0JRCRwVLXg+oVOvI8JEP+ja6J5JTL22gF
 3cPJdIq1/9XbTHmNFGAMzD5TCjdeAmSufyVMRa/eS1jqa7qwOUXhro/P+u9GPpOPPZeM
 +MIuvZ+El4JAXcllq5oVq5QrtAfwNETAe8eU1pTcjBXocST8aV5RV4n9LQg5bFYRtnLu
 lOHL1k9oOLs6qjsYDz0bKqVqr6Wx9mEkHnE1HJqjTlt0HZua4Ydy7jMgZmMYOG2J7DLa
 fv+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro87p1xify3rAMM6VIUVmipj5go6dASlOoqFjXMlmQBtX/98YJxo/r02UnZGPJB+ttODf4A3RIccKOt@nongnu.org
X-Gm-Message-State: AOJu0Ywad4B7XYu40CW00pnJIVQ9kFmWjBpmYCYD5e+J4v/tzy6LKdw5
 ApM3cuxTtbfAwA179kaTDzSktPrUHn90X5RapoI0V3ZHsWzfJuir3nMJ5I+lBffvxu5Nij1ivPw
 A0gXWBQ4L3sxw9zVXl2cnvt9T7A8wS3XN6A+0QPy5KA==
X-Gm-Gg: AR+sD107qRPkSp12wKEZtVQT6RggBsCVQSjOtY6r8yhTp78ycDH6wCx/hkmvaIFXB9e
 EpbE0YM7B4Wf43wnWhSERUJD0mCn5MX0lNHGTFUQznCMIymPz5n+9rmOz5UqWAUqO8pa9VGFwDk
 WTELOxH8AZRJALrn4GfRehxlOKN2uos2cmkt9Gf3SkxeQI2YUxprtMRJa79m026FKf+cVPRN2E0
 uEAxI2UT4XGgfu0C0T9wds/S4TgmD4np+UYGlrXbk4w7W4BcB94+y2ZFYO8R9YJuuj6p/RiVBbK
 IDDILZPJVL5sUvSX1MLYCJzlW4UkXEQ7yZyvZFZx2/+61w==
X-Received: by 2002:a05:690e:438c:b0:668:8bca:3c44 with SMTP id
 956f58d0204a3-669054c30d6mr414180d50.7.1785231367803; Tue, 28 Jul 2026
 02:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
 <CAFEAcA9HbTSj9cJfv8o=jYSuPhScr-RVKWCos4kpUJ+T1S6g5Q@mail.gmail.com>
 <13333e56-3725-4550-849c-9035f6925213@oss.qualcomm.com>
In-Reply-To: <13333e56-3725-4550-849c-9035f6925213@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 10:35:56 +0100
X-Gm-Features: AUfX_mxoPQ0uNECS8VRE3JYfpevUh2jVyh0wg_6Tx3dOKzoqW1yLGkxMX_uuWPw
Message-ID: <CAFEAcA9X7SNUvQpwXA2_xReUERB-eBETty3g32-PD=MVk536sg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, mst@redhat.com, richard.henderson@linaro.org, 
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com, david@kernel.org, 
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com, 
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 28 Jul 2026 at 10:22, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 28/7/26 11:01, Peter Maydell wrote:
> > On Tue, 28 Jul 2026 at 04:01, Gavin Shan <gshan@redhat.com> wrote:
> >>
> >> On 7/27/26 10:51 PM, Peter Maydell wrote:


> >>>> +    test =3D (uintptr_t)src | (uintptr_t)dst | n;
> >>>> +    len =3D test & -test;
> >>>
> >>> What is this doing? I am not a fan of clever bit twiddling
> >>> that isn't commented to explain itself. Readers of the code
> >>> shouldn't have to go off and search for an explanation of what
> >>> is going on.
> >>>
> >>
> >> The following comments will be added for (v5).
> >>
> >>       /*
> >>        * Maximal length of aligned access that are determined by @src,
> >>        * @dst and @n
> >>        */
> >
> > What I mean is more that it ought to say why "x & -x"
> > achieves that goal.
>
> Hmm isn't "x & -x" restricted to power of 2? Here we have no garanty
> @test is, because we have no garanty @n is. Ah, this is catched by
> the 'len !=3D n' check and returns after calling memmove(). Indeed not
> very clear notation. Again:
>
>    ...
>
>    /* Overlapping buffers, unaligned or oversized access */
>    if (!QEMU_IS_ALIGNED((uintptr_t)src | (uintptr_t)dst, n)) {
>        memmove(dst, src, n);
>        return;
>    }
>
>    switch (n) {
>    ...

I'm not inherently against the bit twiddling (QEMU_IS_ALIGNED
on a variable length will do a division, maybe we care?);
I just want that if we do use a bit-twiddling trick that we
explain why it does the thing we want it to do.

-- PMM

