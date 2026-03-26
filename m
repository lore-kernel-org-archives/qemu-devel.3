Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B2710A62FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5m9k-0002cP-5G; Thu, 26 Mar 2026 10:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5m9h-0002c1-Ln
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:57:53 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5m9g-0006Dc-3K
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:57:53 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ef161129bso977204d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 07:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537071; cv=none;
 d=google.com; s=arc-20240605;
 b=kGTayyw2hhbG1tgqyQuntB8cWfrupEB1LB0/kn1ZzvrfDIBO3R8zwzAdkq38ltp3jv
 SSvyscs41JpuSZm6FNwqYk1NpKDLfbFyxF0bdknwElvZbPW9uOe+E9sCOVS75+1nbQnZ
 DDZq3cXb+IpmdITzzjA6nxQh6it4F7rcT/GQ67DQEBEjq9P3dxUJm4uVIL8xDJ1D3Fmk
 AVVgNGhZjtaMDexVMdvveCs1CRDWqLI3qVrejD/fJBS/odQLRIFB4q1sinwUIDmJf1we
 e/lsTV8dNJgOE3Zk0agiT1pEyTFmtPxqgL59tn6IhEJrIHoU7sWg3UClRUVK+8xXpUpL
 e9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U9lP9MZKcn5E1uRHCH2oogRQPzek67iKb1cwsF94szY=;
 fh=L7XiaM199YUAeJujWSjDkZHdtzvjC5QojsdLn/CKGC8=;
 b=i1aFgNy+b91xlSK6WG3MNN5dm8EkL1zw4b7QVViABS+g2k2SAEHYdfY/25Ao4fheof
 V0Wrl0wtW7JKCoiP5SaQzRQeHiTFwSuWkO9uuryzmhl+QOF5vl64hPgeNolsgd+yW03l
 EkftL7EBTE25iQX5pxMy2n7q9ruBmzvAqlRSBwjf6WqOtkdVGjqzc9cTGiTRt87zMvEs
 GFmFv4kMjqeqG2A7K1HTwuKxqO2qdRXUdGzYjxwv53Fz8whN7e8QZS8sbY2Hz8UQVJ7P
 JjCkFCw57oamOHBhj2/NP46ypr2iRH68rfOjrT2HLRiEYidonRD/dkyZ9z7xd0o8MRzO
 xuMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774537071; x=1775141871; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U9lP9MZKcn5E1uRHCH2oogRQPzek67iKb1cwsF94szY=;
 b=a0FCiNvZaOvCKqzecherK89dU334SpchsLR5F1IRWNlNtx5TTZj4jcRCo/PzfnTO05
 BeJ5MQp9hq++DPhREDn8Ad+OKy3nSMMA7KlZmcKN1fLL77jHC0AyfS/qt8Y6ZRtkvQYB
 noCkGS7LTftix9dhmaALOZgRLQpuyVXK5pGz5WP/x4P8S9EdtY8QevKiCDNeu8CvPFC8
 Fi48N4VZJvlmj/jOvohSKIomWTt6dxd4H7EmbPDMviJdkprWG+8h09aZ2fHlzthjJ0jj
 e/ftFR2KJP7ElG7wlES+cO9tpsZqSnzRBMRrqIVFVoBEmRkNdCOwz87JNLxqFAZdfzsk
 kSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774537071; x=1775141871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9lP9MZKcn5E1uRHCH2oogRQPzek67iKb1cwsF94szY=;
 b=kh7Vz27r7ScppwfK7HABtEqnruHsoaeP+ThdvlGtwoM8iLLmE4wY76/XnAkA/JFqtJ
 SfN3Kdlm/BoFACCAjGUhCMb+X1+ETbEkZt6VtHLlp5x1GoiNdyALRlo8eKBSrIlwf3gT
 QE0Y4X/OOotGYrsJopPsN/0di0No5bSwiKncMeehWoxtuDsqxw1PK9IFGlvghe29kkTP
 3ykpERBxh9RumbtVGSJggpM3dBYkqEstkq2COOq/PyMfSk+NcTnUkNakn2JvGWM1JbsM
 ysHE1U36Zx0Bw85psiywX0cEWiFh0BlEjX2hI2Jmu6uru9VhtIx+kT4uTTUodGlS9mD4
 pgiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFnuYjVgEEzJ7RcX6h4CLumZwZsOd5xN0KPjDXRX/Dgbt3g3ujL0XPkrHWUR7kKlqu/0/2jIyKuCbg@nongnu.org
X-Gm-Message-State: AOJu0YzO6v5UTrpP4Xzq1hpODglqib8DHd2l7J97ntI+sRnUDJhEedPN
 IeF9zHIi8dmMNR3wLLdvA+MaWX9LcdVy+pX4PrdPfBxou5Nit+L6YhFr8Sy8WI9gW+/+orRyNXz
 kI6ddZB1u2A70udOyTLXDRPiIQXTSOtolyd/wL5Ww8Q==
X-Gm-Gg: ATEYQzz6adgSdzJg+ZYylx0u0rYN9QTB0Gv4SbCFJ/AVfhjBXhO03+PSZEprfZuLfKg
 0Wilg8TWYrwkh4siens2X86xwNjPG9vfmQ2mOnbSQNhVk3rq4naKpCQMCp6Q43ECHGYNqbEDvty
 LwtaF8nLZbjJqxcDOa4wlrV3VIV3/3TUy0MdrMimt3js3U+lFjfFNWYF3hBAFY3adNlNO5bPZns
 rpMueCwhnqsMulXoCGSUmG2sTgzStFjrJFX4xYmEe0o2wbZ710NQhjTOHOxMRca7upKasQ/xP0h
 F7ZjepLbVmIIkyoRpb/yHBBrYpEYgo2dQrwdJ7gPteeAeQDWMHetlT2pRlvrUgoYdRw=
X-Received: by 2002:a05:690e:d42:b0:64e:c641:d06a with SMTP id
 956f58d0204a3-64ee606f504mr7312000d50.4.1774537070960; Thu, 26 Mar 2026
 07:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260326113457.159065-1-thuth@redhat.com>
 <CAFEAcA-xWtr=Xgst=MOVcm+TxegSvNVXmDP_RDVDOvJJW76Qeg@mail.gmail.com>
 <f6045fed-60fb-47b8-8241-a6fcb0af7292@redhat.com>
In-Reply-To: <f6045fed-60fb-47b8-8241-a6fcb0af7292@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 14:57:39 +0000
X-Gm-Features: AQROBzApTN2U5b7lhjnw5vPbsl2rCayBhqtA9AZOCLRZrRB0-QF7A4IovdYnLOU
Message-ID: <CAFEAcA_VoSX2JK-HRpAN0P0LT2dj_WvSRyP2dom3ZQK76mtyfA@mail.gmail.com>
Subject: Re: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga device
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 26 Mar 2026 at 12:04, Thomas Huth <thuth@redhat.com> wrote:
>
> On 26/03/2026 12.59, Peter Maydell wrote:
> > On Thu, 26 Mar 2026 at 11:35, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> QEMU currently crashes when migrating a guest that uses the
> >> isa-vga device as display. This happens because vga_isa_class_initfn()
> >> registers a vmsd for vmstate_vga_common that operates on VGACommonState.
> >> But the isa-vga device is derived from ISADevice, not from VGACommonState,
> >> so the migration code tries to fill in the data for VGACommonState to
> >> the memory that is a ISADevice instead, which is of cause causing trouble.
> >>
> >> We need an indirection here as it's also e.g. done in vga-pci.c, so
> >> that the migration data gets filled into the right location.
> >>
> >> While we're at it, also drop the "global_vmstate = true" here. Since
> >> migration was broken for this device during the last 15 years (!) anyway,
> >> we don't have to worry about maintaining backward compatibility with this
> >> switch for older versions of QEMU anymore.
> >
> > That means the only remaining users of global_vmstate = true are:
> >   * TYPE_VGA_MMIO : used only by the MIPS Jazz board, which is not
> >     versioned, so we are OK with migration compat breaks
> >   * TYPE_ISA_CIRRUS_VGA
> >
> > I don't suppose that migration is also currently broken for Cirrus ? :-)
>
> No, Cirrus seems to be fine. But I think we should likely do something like
> commit 1fcfdc435a3e25ab9037f6f7b8ab for the isa-cirrus-vga device, too, so
> we can at least get rid of this in a couple of years...

If we're going to do that it would be nice to get that in for 11.0.

I do notice that the Cirrus devices have their own vmstate handle
saving and restoring all the common VGA state, instead of using
vmstate_vga_common, and they miss out all the vbe entries at
the bottom...

-- PMM

