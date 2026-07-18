Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A6FC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl5bw-0004iu-SU; Sat, 18 Jul 2026 10:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wl5bv-0004ii-Eo
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 10:01:47 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wl5bt-0003Nb-CV
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 10:01:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=FQynwOz
 ErkG2P4rHg1a0JUZAnfaxZ4wOjU/9DvjN7iKYtJcM6+INdxteOfslMskiw/OiCKrgHCqe6
 uwlGfhcavJmggtM0FvwSdqnYaR29ALklmAPrpVa/uj6yEBRc1FyeDlVxU7PNrZNkijE2it
 d2bt8KS7VDQTAFQvTcL0vWe/GGCbwVm9PY2GPrF4fn4EiWi4wgCB086leOJ4B+2t8UCLap
 mVUa0mMeKUIQgVFQ1f3NE7ZPobax5n8EuVT82Q5Nz7K6tf6/0WpIHT0kRfNGqTFEkf6HMF
 yMrpC1fw1EsLYtlZAoh8nN3S575KD95WJqLl+D/LrC5xxtpgVeJ3IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=k
 UOsdWEmkw1olfr/zkwZoYHF6YAZ9stuP2kAmGhWeWU=;
 h=references:in-reply-to:
 subject:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net; b=
 KCwKVl2Dx3FXkmmKT3CwM7Wj2disgx2aqLYscaG8W9F/mzEiHtmo+z6tm5jzWZK65f7dxU
 vJ37Uf8NuE79H259m9Tj23dgu4d9bBkniC64xlrds8c0i4WIAqTH3qZDtVfHv4J3+GGUDL
 lHvy8CGKQeSTDQYynGaEFaRVGbkD8NYoApE/N/mCuGQTMS4mW5PdY0uEKztVrSl3xtoq4j
 KhNBSWJ1C7bFgw5YGW6WvDxIiizfGRKd0W/X7NAHKkAiFdg3JKCUnygMmYJP5/0s+ZFqZ2
 EThMqrgMmWdrpCGy6Jiyk8XZccKENJ5EnGWQxQFF7HhiqQlz0Gt5gziQPDkXFw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=KfNyrED0; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=2wTrJVj6;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=kUOsdWEm
 kw1olfr/zkwZoYHF6YAZ9stuP2kAmGhWeWU=; h=references:in-reply-to:
 subject:to:from:date; d=korins.ky;
 b=KfNyrED0TtG72pSJHBaiNeWaXi+6/7Iot
 ikLXTHNuvmLCyq9IN85YGytfcOJcn1awCChGveEcCpkUH5sglosh40SOmQ9BFzUrw34MSg
 U9URGLtviVJzbQ/+IC0LhuJZuM+aJjFlGGiSQAafdpfFaLO8FIG2ahvnELAUh1jdP6H29E
 /uRznHjenpbi+K27QcOG/m1loR6jHjZKgDo20bSJzvhGIlQpIBQvU4gqb3b7U2F/UxwRxQ
 GXnaPkTFTPXkee4GcrGl1MZhTUcfpxXXpgRCu7vB81q49QBIVHSZE7H9PhdVLumhMnjJty
 42mH8qtmAogKc/fFYg/ahfnuIoQuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=kUOsdWEmkw1olfr/zkwZoYHF6YAZ9stuP2kAmGhWeWU=; h=references:
 in-reply-to:subject:to:from:date; d=korins.ky; b=2wTrJVj6rNTmR0+n2058s
 uxG8Evv4sCs0tm19lVolDHXzyAhPyAPukgXLSoO+MvsTMfqL2ykXPPHggFTLljnAw==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id f7f31078
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 18 Jul 2026 16:01:40 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id e682edfe;
 Sat, 18 Jul 2026 16:01:37 +0200 (CEST)
Date: Sat, 18 Jul 2026 16:01:37 +0200
Message-ID: <87v7ac8khq.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: philmd@oss.qualcomm.com, qemu-devel@nongnu.org,
 Kirill A. Korinsky <kirill@korins.ky>
Subject: Re: [PATCH 1/9] hw/usb/xhci: reassert pending busy interrupts
In-Reply-To: <87cxwpn1iw.wl-kirill@korins.ky>
References: <20260713112004.4956-1-kirill@korins.ky>
 <20260713112004.4956-2-kirill@korins.ky>
 <4d6a6a94-49d7-4a37-a590-bf2a3105b994@oss.qualcomm.com>
 <87cxwpn1iw.wl-kirill@korins.ky>
User-Agent: Wanderlust
Mail-Followup-To: philmd@oss.qualcomm.com, qemu-devel@nongnu.org,
 kirill@korins.ky
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On Tue, 14 Jul 2026 15:28:39 +0200,
Kirill A. Korinsky <kirill@korins.ky> wrote:
> 
> On Tue, 14 Jul 2026 12:01:36 +0200,
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> > 
> > Hi Kirill,
> > 
> > On 13/7/26 13:16, Kirill A. Korinsky wrote:
> > > xhci_intr_raise() returned early whenever ERDP.EHB was set; that also
> > > skipped IRQ assertion after the guest cleared IMAN.IP while leaving the
> > > event handler busy bit asserted.
> > > 
> > > Track the previous IMAN.IP state and suppress only duplicate raises;
> > > when ERDP.EHB remains set after IMAN.IP is cleared, assert the IRQ again
> > > so the guest can observe the pending event.
> > > 
> > > Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > > ---
> > >   hw/usb/hcd-xhci.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > > index 2cdab3ba0e..ce06d52c36 100644
> > > --- a/hw/usb/hcd-xhci.c
> > > +++ b/hw/usb/hcd-xhci.c
> > > @@ -577,12 +577,13 @@ static void xhci_intr_update(XHCIState *xhci, int v)
> > >   static void xhci_intr_raise(XHCIState *xhci, int v)
> > >   {
> > >       bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
> > > +    bool was_raised = (xhci->intr[v].iman & IMAN_IP);
> > 
> > Per your description we are missing to clear ERDP_EHB?
> > 
> > @@ -592,6 +592,7 @@ static void xhci_intr_raise(XHCIState *xhci, int v)
> >      }
> >      if (xhci->intr_raise) {
> >          if (xhci->intr_raise(xhci, v, true)) {
> > +            xhci->intr[v].erdp_low &= ~ERDP_EHB;
> >              xhci->intr[v].iman &= ~IMAN_IP;
> >          }
> >      }
> > 
> 
> What seems a real fix for that may be a real root cause.
> 
> My test is simple: I boot OpenBSD/octeon in my machine with USB disk, and
> inside machine, via SSH, run cvs checkout of ports with -Q option (no
> output). It produces ~200k files and works for about 30 minutes.
> 
> Without my or your diff the cvs process stuck in biowait, I can use any IO
> at all, ls is blocked.
> 
> But network and things like ps works well.
> 
> And enough input from serial console usually wake up machines.
> 
> So far I had reverted my hack and replaced by yours fix, and it survives two
> checkout without an issues.
> 
> I'll drop that patch from my series.
> 

I'd like to whitdraw my claim.

I can't reproduce issue on amd64 and riscv64, and I can reproduce issue with
~ERDP_EHB.

So, it indicates that issue is my octeon machine (quite likley) or something
is missed in mips implementation.

-- 
wbr, Kirill

