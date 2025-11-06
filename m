Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E97DCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 18:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH4vc-0000PA-CM; Thu, 06 Nov 2025 13:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vH4vX-0000Ow-Uj
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 13:41:43 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vH4vV-0003Q5-Uk
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 13:41:43 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-640b4a52950so1966517a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 10:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762454499; x=1763059299; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNZifspKyNTtUk32EI+/S9xIdPILpe63RytC9kZ3Z+o=;
 b=Ulx6XRsodV0QwT2+RMIoA+X1n75IKYXZwjhc9W4holmsHA7481zgbfauYkCKR4jx4d
 aXsg8xJOKDCwz2TPL1XH/k1/j/VYai87SebwDXES/hw/Hu3X0HNTRh3Z7O1dWuzNqkN/
 w3iLe7QOdHsrucdpWGMhM9kc3UVOzReehD/QR9Xr2X9w5GHkYeoYOULrssROOvrxCZ67
 sTyD8aWA6/zFSa7B2hO4kV/nJzur4bB/4vljugm868IAk76KFHzubbXIdYP79SxmxarP
 VWcaxZOI2VpXPSFSQbKRKC+wbQ5Fk8pnJG9CEX9SeoVMaBgNPyScw/XND13A/JPNlWVV
 oIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454499; x=1763059299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HNZifspKyNTtUk32EI+/S9xIdPILpe63RytC9kZ3Z+o=;
 b=seji1ojWEviBqE0o7CcG89sWWCIozP0gfvPT5YTx/0W9/Lok7LDI5/FHXQzMjA1f68
 xyMfvAdb1hLAaQSblOHs4qzor4YZGyetNseGfetat/T7O8nDcH65T0vslK86Np3vdBhO
 PeM2lP/uc5Wc/Vt3drG2pdMQldeNp8nxrjd4HEXRtYx+f89Z3aLrK1b8WElWepxYy8do
 8eysw2h5GYqCsVF7Q49+G+vW+RNdsElUhuKBDMra2JWdDk22djpmbTIPZY2VsUZMhrbO
 qcP+RJicRGRH1Zr0skZddeULNGS3DbYt72bFYI5PaQ17TCMq+EEhh6LiJ7k2TTewrtgB
 6kIw==
X-Gm-Message-State: AOJu0Yxcw7ZXsg+lyyRoav6Uktop4WNN+x/CggSXdALaRuj8ZCpoHdYU
 H1pjBt7Jj2q8NLefFsahp2Q+WXCOLCeIIlb1qI2NXqQNtLNq44q8CDczlhDs9r0ljBsp7OExUsG
 pgBc9mUFxrKNH9+NDqws2AEgkQCWcskbB19jlGVz8
X-Gm-Gg: ASbGncv/Tlb8ihQ603McddTPxYMf47B0Zj8T4WjFG3Br4sXsXJLewM/V+lh7zw0Ke8/
 8UdqYwcOM2retVBcR3POwHPfVXzQoREnwrZPAqr/SsNsbVwDkTRgpzjA6hwOHBnSRNPgzl1UvTr
 5avh5hZW04yHTM1OttuhjyHSiBM0a5BDgsm02+vMZqosSC8cqP4DI08E08iSYvO5B+3sYhQGvRT
 unk7tqlmr4ancu8as3aIx79gluZTxUT5Uvn2yOXhrNupihyoC1YIhhqm4yNh20YyU8aX3q9+9HS
 ZcYfhQ+H0MKrtxI=
X-Google-Smtp-Source: AGHT+IEPogCfwTh60fi3isNVjx3pBfMnxApRrOPwcHZh++MQkMjCnTGi/9r1Ecfj4ZHTGj62Te1ZOexqFZyp5+cwgxM=
X-Received: by 2002:a05:6402:430a:b0:640:9cdc:abbc with SMTP id
 4fb4d7f45d1cf-6413eee1029mr418791a12.10.1762454498683; Thu, 06 Nov 2025
 10:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20251008191936.3069950-1-navidem@google.com>
 <CAHUE=o-X1sJXn6SWATUUjX2GHUsh8mufk3MZHVkKDzzFGtbSyA@mail.gmail.com>
 <CAGXevkjvVQE98WqE6-QcWc5jYvgycymhJYmVnEGUTdwNwNyH6w@mail.gmail.com>
In-Reply-To: <CAGXevkjvVQE98WqE6-QcWc5jYvgycymhJYmVnEGUTdwNwNyH6w@mail.gmail.com>
From: Navid Emamdoost <navidem@google.com>
Date: Thu, 6 Nov 2025 10:41:27 -0800
X-Gm-Features: AWmQ_bnMQHTAmuoldBKKIVKPP9sUHlMv7xLYea1AbC-KxbYn6fF-sB7SRX8Ld_M
Message-ID: <CAGXevki76WoXWV8P3HSo9vq09FXzKBi+xQoxCLKWAU4AjXF39w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libqos: pci: Avoid fatal assert on zero-sized BARs in
 fuzz builds
To: Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-devel@nongnu.org, zsm@google.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=navidem@google.com; helo=mail-ed1-x532.google.com
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

On Mon, Oct 13, 2025 at 6:14=E2=80=AFPM Navid Emamdoost <navidem@google.com=
> wrote:
>
> Hi Alexander,
>
> On Fri, Oct 10, 2025 at 8:59=E2=80=AFAM Alexander Bulekov <alxndr@bu.edu>=
 wrote:
> >
> > On 251008 1919, Navid Emamdoost wrote:
> > > The qpci_iomap() function fails with a fatal g_assert(addr) if it
> > > probes a PCI BAR that has a size of zero. This is expected behavior
> > > for certain devices, like the Q35 PCI Host Bridge, which have valid b=
ut
> > > unimplemented BARs.
> > > This assertion blocks the creation of fuzz targets for complex machin=
e
> > > types that include these devices.
> > > Make the check conditional on !CONFIG_FUZZ. In fuzzing builds, a
> > > zero-sized BAR is now handled gracefully by returning an empty BAR
> > > struct, allowing fuzzing to proceed. The original assertion is kept f=
or
> > > all other builds to maintain strict checking for qtest and production
> > > environments.
> >
> > Is there a way to determine whether a BAR is unimplememnted from the
> > PCIDev in generic_fuzz.c:pci_enum so that we can skip the call to iomap=
?
> >
>
> Fair point. I don't think we have a reliable way to determine if a BAR
> is truly unimplemented from the PCIDevice model without probing it. If
> we moved that hardware probe into pci_enum, it would become
> inefficient for all the BARs that are implemented, as they would be
> probed twice: once in pci_enum just to check, and then again inside
> qpci_iomap to do the actual mapping. That's why I think delegating
> this check to qpci_iomap is the cleaner approach.
>

Friendly ping.

> > >
> > > Signed-off-by: Navid Emamdoost <navidem@google.com>
> > > ---
> > >  tests/qtest/libqos/pci.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> > > index a59197b992..df9e2a3993 100644
> > > --- a/tests/qtest/libqos/pci.c
> > > +++ b/tests/qtest/libqos/pci.c
> > > @@ -541,6 +541,22 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, u=
int64_t *sizeptr)
> > >          addr &=3D PCI_BASE_ADDRESS_MEM_MASK;
> > >      }
> > >
> > > +#ifdef CONFIG_FUZZ
> > > +    /*
> > > +     * During fuzzing runs, an unimplemented BAR (addr=3D0) is not a=
 fatal
> > > +     * error. This occurs when probing devices like the Q35 host bri=
dge. We
> > > +     * return gracefully to allow fuzzing to continue. In non-fuzzin=
g builds,
> > > +     * we retain the original g_assert() to catch unexpected behavio=
r.
> > > +     */
> > > +    if (!addr) {
> > > +        if (sizeptr) {
> > > +            *sizeptr =3D 0;
> > > +        }
> > > +        memset(&bar, 0, sizeof(bar));
> > > +        return bar;
> > > +    }
> > > +#endif
> > > +
> > >      g_assert(addr); /* Must have *some* size bits */
> > >
> > >      size =3D 1U << ctz32(addr);
> > > --
> > > 2.51.0.710.ga91ca5db03-goog
> > >
> > >
>
>
>
> --
> Thank you,
> Navid.



--=20
Thank you,
Navid.

