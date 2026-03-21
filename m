Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1CB1099B4C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 00:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3kJ9-0003QZ-Mc; Fri, 20 Mar 2026 20:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w3jqC-0000g2-Km
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:05:22 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w3jqA-0000wn-Qj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:05:20 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8cd8576a512so396992585a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 17:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774051517; cv=none;
 d=google.com; s=arc-20240605;
 b=f4OLWND0n7P0I2j4KlnVHyvHpRtxA3EP+zbbHGJ4LyvN8H2RmNI8/IeFAA+lB3V44s
 RIAR7xvGZs3fNZFkVsEePT/aAfqSrqLR1yb+Q2FbGn340xJfOkeADv75M5QGVUGfxuNr
 961KXBsFzdeJf1v0twYBeqS9l+anzB+g6hqLUadHGshsYfWwFHZSljeAFnb1jCwW47is
 Ru/5JToSBPZ5H179PItdcO41k9GycnqV3iBE3uyj9cUBXPScbR/sb8XAyNrO++HuMed5
 yaOF7ktStx8TQvdbHf56RUNmD5Ym0xTEAt18DfMkwa1xBV77TeGUNxL5/TtmxSfaGKmD
 ZesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ERCb0Y8/px1upiAhwrl+R7gbGR6nGopZFCRUobbhDcM=;
 fh=ucZDN36yBpJn58JtaLk0s8jvtfTXFaz6Qj/yP7K9RF0=;
 b=hNk8mF2cCjjEcY89ixY3PK34AhzcwDeZP9JTVBvKgH94FKfBYDxpoe9TBFtSUtq38d
 XncAI5Ful8ltwHs5TwOyDDBO7Rzw2X0Aks7PF0wVvrNOASB8VCz1QjP1/8x2zB9BCeYZ
 2+tbaeTyr/v5RlGCLEImEpX8PgisnzC++oPfpE4jk4SmLPxB3jPB5pnwLldllna3W4Qj
 ePWD9z9Ueo9sZkm/5XYN+zY9eJg1DdiRLOVuADPZQ5EP3mC8XU1p4vTapIGKrh4snf2e
 3g3ILNUOh2mEKiVj3xhSieXXaQLHkVXbaozUyYIUDGMWUtOq3jm+kEYDrnd8keTydEqB
 E86A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774051517; x=1774656317; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERCb0Y8/px1upiAhwrl+R7gbGR6nGopZFCRUobbhDcM=;
 b=T84bWEUgJX8Uc4vLdjmnhhSneUhfX/2pFvm4xQqzeeHapfBCJ7ilb//qFfyFRMHGEs
 g8LD8UunPcgCdjfm+bopVh/zxipFxdSDPEts+uR9fgLfEB4DXcdpJg7YgSolQp8qwTap
 ZBu5qBdFlSTNgNwGPvwQB1MF60wL9hQHR0DmioBXlqepegzzv/3T31UMMXxqC5u5X5+X
 snkzGCzK77dtaG+B+EvPoRp9rywvboQstFKX8Ws8bsRosGBgC+YUDI05CZwenmNeRImr
 fRhRFzN/yuPnpW30pnyeLZ19H0CanL+yznHe0oAIowIDdgv6ZPoh0It+wkqOJDOhCvRw
 lA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774051517; x=1774656317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERCb0Y8/px1upiAhwrl+R7gbGR6nGopZFCRUobbhDcM=;
 b=f5HloR3UWB7xDZwbpcr4VLbd3CwUvfAHq2V6syMbByOZu61t5/NiXHh0InSqSJKV5G
 yGFPtsgpsogGijFsZvPGGSuPC4N4ffM+KyWeZE4b8BMhY+qKYG60qXvmYJzRR07WIPcP
 vhdOzrweUVCKK9Lx3XtBYFYPZcCUtoX8TaNtpp0fAStftTSBjsJID11xy1RYZcDoGq2q
 3YOz3mTKF0iqclO1dWIw9lFQvHY+28mE+ztiJomtROQaua1GNJOzhgPFtlFuTuOHS4wI
 ZL2/cadAAsNRS0nHIeNUvvc7PuvhNoABY7XPZTxUQm/3TXTGu606GATiQgAvMtanQIYB
 c4XQ==
X-Gm-Message-State: AOJu0YwGzLU5EcLaor3u2gsSiQqHxRzQ6HgGrOar2IfzGeuD9Jnxdx2U
 khmaNvWdIqRnMZ/aKsAyADqx7CJO5B2HKfd0sGCBtfKvjViUJzivFiS/ELYy8JJCalsjLJ/mMod
 RNiUSd3lHP0Cao7sFm39Uo1gaEnrrzY0=
X-Gm-Gg: ATEYQzxMx5ksm7RzFLv63QaQ5pAPEl5opmOtX16YLi7SC3HLisQN1aMEqyKHn4YpoUd
 JxhGLLHp6FDz3p9GJ60APYqntDyzZY0Y8g/yWzrvusaw+gmISG3br+AgELrm4lRhIhwtSTlq9JY
 Y7LC4EQuIlIJFGXv27G290xxL+upMtgqHmZqhsfOmybc3+2DevZLnVVWWlafyq7cCKqf/OGAjMe
 hWhkAxY0g5iG+9d3W9gEc6BZL4jSD3VsTZlH/sb2lpqGMe5TqZAnFhvmnw28I9zdajThDXbLl9T
 XfRfNdvB
X-Received: by 2002:a05:6214:300f:b0:89c:50fb:31c0 with SMTP id
 6a1803df08f44-89c85453c14mr76344296d6.10.1774051517081; Fri, 20 Mar 2026
 17:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260318193610.2043847-1-qguanni@gmail.com>
 <CAFEAcA_tiZT=vhEvtS3VAgjJLrYEZDBTQxm5xbbWmTBm8DLnng@mail.gmail.com>
In-Reply-To: <CAFEAcA_tiZT=vhEvtS3VAgjJLrYEZDBTQxm5xbbWmTBm8DLnng@mail.gmail.com>
From: Guanni Qu <qguanni@gmail.com>
Date: Sat, 21 Mar 2026 01:05:06 +0100
X-Gm-Features: AaiRm51UF9mdPY2RGhw3f76crzuOOmGD7nVuf5WrtieE34Y7J1Kj2H1XYhUKdTc
Message-ID: <CAFzOa14yAMB7V1vGME=wzjk-vXE+Xxff06Rp0FSeEXFC8vbkKw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mcascell@redhat.com, 
 qemu-security@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=qguanni@gmail.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 20:35:14 -0400
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

Thanks Peter. v2 sent with your suggested comment added.

On Thu, Mar 19, 2026 at 6:34=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 18 Mar 2026 at 19:36, Jenny Guanni Qu <qguanni@gmail.com> wrote:
> >
> > When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
> > ohci_service_td() transfers 0 bytes per iteration. The Transfer
> > Descriptor never completes because CBP never advances toward BE,
> > causing ohci_service_ed_list() to loop indefinitely and hang QEMU.
> >
> > Add a check for MPS=3D=3D0 after extracting the field from ED flags.
> > If MPS is zero, call ohci_die() to reset the controller and return
> > an error, preventing the infinite loop.
> >
> > Fixes: CVE-2026-3890
> > Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
> > Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> > ---
> >  hw/usb/hcd-ohci.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> > index 1aeed9286f..b93a99593e 100644
> > --- a/hw/usb/hcd-ohci.c
> > +++ b/hw/usb/hcd-ohci.c
> > @@ -956,6 +956,10 @@ static int ohci_service_td(OHCIState *ohci, struct=
 ohci_ed *ed)
> >          if (len && dir !=3D OHCI_TD_DIR_IN) {
> >              /* The endpoint may not allow us to transfer it all now */
> >              pktlen =3D (ed->flags & OHCI_ED_MPS_MASK) >> OHCI_ED_MPS_S=
HIFT;
> > +            if (pktlen =3D=3D 0) {
> > +                ohci_die(ohci);
> > +                return 1;
> > +            }
>
> The OHCI spec doesn't (as far as I can tell) say what the
> hardware should do for this situation, so I guess "flag it
> as an error" is a reasonable choice. I think it would be
> useful to note in a comment that this is our best-guess, though:
>
> /*
>  * The OHCI spec doesn't say what to do if the guest hands us
>  * an endpoint descriptor which specifies a MaximumPacketSize
>  * of zero, which would mean we can never actually make forward
>  * progress transferring data to it. We choose to treat it as
>  * an error.
>  */
>
> With something like that,
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> (Or if I've missed something in the spec, let me know...)
>
> thanks
> -- PMM

