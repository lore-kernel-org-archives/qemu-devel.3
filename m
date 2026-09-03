Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10711C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x23jU-00009j-3s; Thu, 03 Sep 2026 05:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x23jS-00008z-4V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:27:42 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x23jQ-0001Ae-MF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:27:41 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-86fbd1a23ebso2044807b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 02:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788427659; cv=none;
 d=google.com; s=arc-20260327;
 b=itZ4sXORvNisu5HK/MNbWqhbBRKCmc8dgltvQn+gazNcoQGZwGh2dUF0saBdyPuAnD
 Eq1AvR1/KmK3KxdZr1BwpNduoG6t8jmv3TtHIMhSNVIJquQE4VJFOdYbZiVAkNASZjwN
 Te9ICYc06VbM78erBtfJCJpsiRX+a5RmwxDc1B3InV0gd1D4WF/S3C7Hb3dgIJDbAD35
 HEh7JXbAiPUSa/5T0Xn8kTWubqMkbghCIz7PGde3vCDLCz1OKSe0wxzru5M3eZUYiJpK
 ht0t1vnePBPlpWbFpIKgb57c0BWT5k0QaGB9COsWwn13cxBegFjd43NNdcPNut5Fsz5c
 BAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JcaScmb/P8WbCtfrZ0pKCVBMPLKQEALCkXxGpVZUQT0=;
 fh=oMcEUljzbUSrwylWbtqtj9AyXO1RpbsNRquDUpo8vB4=;
 b=XjUPuhB9a4RKjGKoYlHgTbuyGhl8YaPgBrRtn0JtlpZTsCMXmRia29/qnxm3GFFLgK
 VLZgXXdz591eZ92+EaKY9ibbg7Te/zRgCv2a5+gQE04TiNExkIdXreNk7ANEgxy8CoSH
 cgukwCILtg7izQWpmMdnu703NZRBm+qEi5sWGjjohlTNQG9O5MCzKQpIxNpQk4Lax4VZ
 no/73yKfaMEYPUXe1ONbIsPfryLNjlFMJxhPsczo2IAk+DXoh4eRKJUWorfZ75ku5Snk
 jyEN9zkFWGL3qPfe2z/G4F79o2lZCnNtD3bEcXcz7YbSfl/C611y0l0Yt6Utf9wW/5+d
 eg9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788427659; x=1789032459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JcaScmb/P8WbCtfrZ0pKCVBMPLKQEALCkXxGpVZUQT0=;
 b=cgQHYiSZfZDyqIzFNZ0oKWle/NZYfRkTjOCWCn0b9D0ThqpsNJExfBshRWdUJzZV+B
 xn9CE/FvpkQdpg23LpGogRBJfxXCeC825oWiqDDk3mWMcfGhmSLPlwrA/I5HRJLZDq7C
 ES3Vm2+m7JfKfuuXccXAzXNH7v5UyLwnW1h0KfPzUNSnE3kyELMwLt03/ocIM9Dk7t4P
 xRugaixRCTn562Dl0psNpqZ9x729AAnOjXSk8mE7JmyxvxbmVswcdQgWuyFnN9u5K1M3
 bo2iqy8V/fMV8p8qmA9qx3JccpzIrfU2dbPQKrK4ijONMcDGwTzfJahBT87ohj+yPhRO
 BWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788427659; x=1789032459;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JcaScmb/P8WbCtfrZ0pKCVBMPLKQEALCkXxGpVZUQT0=;
 b=BRuszq1ErW1fw0yUo+TYP95kAziytksggqJkYFzk/QonstPDbnOtporBvyQXGLW4uP
 +pjZLjjJpqRbffG33fJL5rswMwo0ajlbfmXXI4pyqEdTD1+gSgCMgfcsiDllQWZEI+XY
 WgCWwsUD7ReQqxa915LKo2uQSIEam2VzspaTnmZPRY0phoIh3GCrZToK1nMRAC7wNzdw
 ptapSJDeqmz2Qd30cfIg2h7xgOIfYXEyXcpkJkLVJ/0ICbE4JpHaGQQ2TcBLblDmyvMS
 mkW0fZ59YXS9Zd4Xei+1H0WJvhsiwvI0gYHYwzhbIIIkBGKUX5NEiWovHGSghb2RXKuc
 Uzow==
X-Forwarded-Encrypted: i=1;
 AKwUvByLP10APbKQW5ewDYDdDOFh18BIANHvOlZiJHzVhiumTZlFlUfd+OS5FCR9Mbecar2t2yXA+I+of2qj@nongnu.org
X-Gm-Message-State: AFuF++mC9r05L42DyXXLVjAlaPlBn5kEJwLPKuIxBwj3jZFvph8h7Wth
 wQE2bvCMw+88bplM2f7OgGcqn3VRGn1Dl9SQbNKib+Ov9hIR6eVTYAesgcU/926F61xdWDVLye9
 3a1oVG6VI0/id5Vm76YjAa8pQce9np1Q=
X-Gm-Gg: AYBFou2x5b66U+Mj6Kq/IZHgEu6Wv8CkzS/urwfW27RvgjhhBE4mMci/OUVb1zAPx1b
 FQILjelAe1HE595YFFpj37BEimzPZP5toA2fvIDNwES9HovxsP6fLt8VefNZsmtueKlF6GyiMrI
 tv/ylCPQBKto67PH5sPAoZEtMVyh/xWNanCVqcQQIRgw9qIgBp5cGbJaXEXgOj+pgH3eamk3dcD
 x/q7m9ufIydEX9WmPypjbMrvaUAUmX1RzhlLBgyiio05u/XjfirTST01Oz5Ya28vrjZ0YFGKJEh
 pYZHowII+IfVWwW2kwr0aAYaiWidNUHl6DurCkwqqxjw42YAXR3nx8s=
X-Received: by 2002:a05:690c:4441:b0:808:f9bb:3832 with SMTP id
 00721157ae682-86c52218af9mr52424507b3.22.1788427659363; Thu, 03 Sep 2026
 02:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
 <CA+AFTT-8odiRzg8mcnZiEQTyTiMeK5rHUFB6an+6wFgYLtyh1g@mail.gmail.com>
 <20260902115439.GA754231@fedora>
In-Reply-To: <20260902115439.GA754231@fedora>
From: Huiba Li <lihuiba@gmail.com>
Date: Thu, 3 Sep 2026 17:27:28 +0800
X-Gm-Features: AcwNN1VMXUYqkwZu0G0ViONAgo1BnNxMAq2LSeHVLeV0T3trHC2HynIQqT4Utig
Message-ID: <CA+AFTT8+vvXd5+UV9X1aS-4tDnMRynzDOcmLYE_HJUgSAvf6kQ@mail.gmail.com>
Subject: Re: [RFC] block: add an overlaybd image format driver
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=lihuiba@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> One thing I noticed is that the append-only format used for the upper
> write layer is not documented.

I have added the spec for writable layers:
https://github.com/containerd/overlaybd/pull/451/changes

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 19:54=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Huiba,
> One thing I noticed is that the append-only format used for the upper
> write layer is not documented. I guess it's different from the read-only
> LSTM format since the index won't be kept in sorted order when
> appending.
>
> Do you want to document the append-only format?
>
> Stefan

