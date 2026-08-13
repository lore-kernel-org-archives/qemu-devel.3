Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EABEC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYld-0004nK-AE; Thu, 13 Aug 2026 12:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wuYlc-0004n2-64
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:58:56 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wuYla-0007Xw-Lf
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:58:55 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836d2861a39so1115207b3.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 09:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786640332; cv=none;
 d=google.com; s=arc-20260327;
 b=G3dzBzcDGSCS0XKJ+oTwUcytpTB3ENJRQjZ/0qxzSN6/DQ8COh2rov7erN2QBIXR5E
 0qsgizMbWReH35HdFDZfEo+w1bpvVKCr2OzmsznxPnqhQFkkhITCH1cjcK3+Pd7BfcJE
 UYPko9BZvRWo0IJ9MAE9uCMA+aDv0Ln8zbt5qn4fMxCduolM+zUnLZPKfwvUTM81xfNO
 QqBD6V2+REBznfjjpxpvPLVPyaEeMeeIyAvwS7qPU4g1ZdAHPzX0gxpt/Ygvcipov1DF
 pv5Dzb0nAzpoMPfli3tfTnzep3LQR9TcNTrOksVv0i3PqQ4y7nNm8vgRQkmzIyrkeQhz
 +M5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MP18d/TC71YUOxdO0/YRDfuHPRMgw0QU6l5dRxileKk=;
 fh=ETXTBPOzNiWPh6W4ECmIvO7kfsb53R8ucT1RDsY0Uog=;
 b=f2VSqIfUIecJrN80jdJVb5HYyeWeMWsB17VrfmVH8op6lMxtnqbhQ2uYppjRmBb08B
 Ba2bbVt7HieALelSbwEozECqP9pUPPATzqYWY1c/AuyK452mHbjajw1y8RBq822FwBP/
 3Gv8+Btqd10TFr4H2acF/HC/wEyyXaIXhqCL5WULf03FlfEJa9ajwfhhbMpFNenqvdN/
 c0eSaqAYeqw24A4aYvQNFdGScmo5brW9ZxT6/sM8A0/ybKtu+8zA4eR38S9wZ7nnQVAP
 LfpSVDuVeGydVMkGT/Vw8w4FXMIu14YIpTmYtBWoGustS/+8xlVLj/M0yf/jkBdcFF+r
 zI3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786640332; x=1787245132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MP18d/TC71YUOxdO0/YRDfuHPRMgw0QU6l5dRxileKk=;
 b=LgJKqU50G3C9Cgr354hgoJ1HavMMz3+UPekm+VFRKlBl216kQCxH8QbR/QDEbmNKp8
 irsO7UBbS6mEDerg30zvTTNi9/fyDSwlIbDrsvcAvThEFM1mdHZ/8+qzOZtrKN6vsksO
 sHQLCfbM9XtZDgX0ySJEAGoMbpr0kkCYvTc79GWzZIDa4ZuqippHCqjxkylRAtEiZut+
 Z1O1H1s+QDYGKoZlv4uk2u0Vf7vfw4JALQZocSV17lSY7Tf6FBYMIj7IqxfWghYGFqfa
 Yifl1fVWS31+e5YGM326UDS+QN0VnFqoUsLP4OmAB6ejGAcShUl0XoBRx+nDnT5iaBaz
 QJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640332; x=1787245132;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MP18d/TC71YUOxdO0/YRDfuHPRMgw0QU6l5dRxileKk=;
 b=B5zyEabcDObkuNFJusEiTBvZx8YWT7fI0mj3LrbpA7V6blAQosXrx2n9jvYp0rKiOl
 0rfKJ5pRRgYkhESt7L3lOLt+m/LR9z3nNPRxLvLUyhwZIZZ8Yjca2E1hU6MdL/29h460
 hdd7eHAI8fMfQVlNVoc4frFq6xAMzef0AdBT43TL14pTyXb+oJG00JI1pi+rcvg0Y4Zv
 z6aU9og8RnwFZaUmvqH01FSqC/DEUAKnHIZ0TY6cOJkjVDb2B8QjNrydU4VnJlXom0NW
 AKhbEjRCqIOO35rrFijXAFqiKH1e5OQ5uV9JYxrh9syUue4SGvJgzJyxevPw5Y6fQ+bP
 J6Mw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpelCTQSdw0sF1eBpI9RBhSz0m8nrojXUvGX+IKxSlx0ChsOQiaHBxoZ6xKiNE9PrT9wUEzY95cx/AC@nongnu.org
X-Gm-Message-State: AOJu0Yz+4lQNMwePyiGFSKUAs1IwuESWQMZswY9GuWtoz2iBax331VeQ
 xDjNtcEpfX2rrbKImoUBpkRqTifOmUZYPpVHnkp+JNEMvK1fYZfbpOWoswVwWBvzwkS71jULnjp
 ypElQ5UjOymJ4gqm6a5YoL2Vnswhu/YP26IqwCz5+qg==
X-Gm-Gg: AR+sD13BUieXX43/ScUm+XwNj7DKmFTdO2bSoK0iaeOaZAFJ9Khgc4Mj27rAWZlb7wL
 Roz14psU/wRaKA4UVtzK/L3S2Xp9I2hk/QoIsIZLVCV0yD6sujph0AGzoI/imVUW/USbfhW4Hkw
 0Ctl5faOMf8/hQ0tJYWfLQjqfEDDw/7obD+K73TRZSlqbyNo6RXkiHmnOUgrCykqNE8ixbYmsaj
 +NCF5YnIsz2jzed4r0kpTPtUk+mciDDvnJAXRzDVb2kFVfaojXYuPSkuuL2kcsbyICUYDQ5T7MM
 LmfjUPL0sG4rb6dptZEPGFe+we4YYp+BGxB4SML4dt8U39Ofkv78ZG/7Wi5BAh80skfGlWfr88F
 hU3V6yPoUMfa8N3NC62hYbuD872S4
X-Received: by 2002:a05:690c:19:b0:81f:e85b:f9f4 with SMTP id
 00721157ae682-8347623df87mr34724367b3.27.1786640331935; Thu, 13 Aug 2026
 09:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
 <an2epcdoZPrz1T9Y@redhat.com>
 <1e3fe188-2406-4ab4-9555-bf04b6d1498e@nutanix.com>
In-Reply-To: <1e3fe188-2406-4ab4-9555-bf04b6d1498e@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Aug 2026 17:58:39 +0100
X-Gm-Features: AUfX_mx0B9boXQiDDXpcsVHdH4AGA06dYluUNfZqmKV6mlSTfSOcAqoZXM2wsvQ
Message-ID: <CAFEAcA_u4zec+O1q9ZQHpih7EoH6nf4swbHDxhY6QEXGugE_nQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] qom: tidy-ups and preparation for class property
 conversion
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 pbonzini@redhat.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 13 Aug 2026 at 17:42, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 13/08/2026 11:38, Daniel P. Berrang=C3=A9 wrote:
>
> > On Fri, Jul 17, 2026 at 02:51:40PM +0100, Mark Cave-Ayland wrote:
> >> Based upon feedback from my existing efforts to start converting from =
object
> >> properties to class properties, here is an initial preparation series =
which
> >> I hope can be applied soon after 11.1 is released.
> >
> > IMHO this version is suitable for merge and could be include as part of=
 a
> > general tree-wide PULL that does a broader set of class property conver=
sions,
> > unless Paolo really wants to queue it in a dedicated QOM series.
> Thanks Daniel. In theory I could send a PR for this, however I'm unsure
> as to how to handle that my current signed GPG key is for a different
> email address from my work email address which is where the series
> originated.
>
> Does anyone in a similar situation have an idea as to how best to handle
> this?

What we care about for signed pull requests is that the identity who
signed the pull request has a GPG key that the person processing
pullrequests knows about. The email address used as the author
address on the patches/commits doesn't matter.

You can either:

(1) send a pullreq where the tag is signed by your personal address's
GPG key, as you have been doing up til now. (I mention this mostly for
completeness: if you expect to be doing QEMU work including compiling
and sending pull requests on work time you probably want to do that
labelled up under your work address.)

(2) update your existing GPG key to add your work address to it,
upload that key to the keyservers, and tell us that we should update;
then send a pullreq signed by the key from your work address.

(3) create a brand new separate GPG key with your work address,
sign your new work key with your personal GPG key, upload the signed
key to the keyservers, and tell us that we should update; then send a
pullreq signed by your work key from your work address.

In any of these cases, if you're sending the pullreq as an
identity that isn't the same as the one that authored the patches,
you should add a signed-off-by line for you-as-pullreq-submitter
to each commit, just as you would for any other contributor's patch
that you're putting into a pullreq. Nothing checks this or fails if
you don't do it, it's just a bit of bookkeeping that tracks "this
thing from me with one hat on went through a pullreq handled by me
with my other hat on".

I have no opinion about whether (2) or (3) is preferable here.
I think (looking at 'gpg --list-keys' output) that generally
people add both work and personal IDs to a single GPG key, but
I don't know GPG well enough to know if this has downsides.

thanks
-- PMM

