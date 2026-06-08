Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D399CCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZim-0004dT-Ou; Mon, 08 Jun 2026 09:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZij-0004cY-Dx
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:08:49 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZih-0007Rt-Us
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:08:49 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-660ea43107fso4148008d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780924126; cv=none;
 d=google.com; s=arc-20240605;
 b=Ch9S/T1xPr6rFmTwy1gmHotvhNxGSNucIBkzY4TS3APpzjiVKIPF9BF2QuQo5P2Yge
 kUDZajGqkJ4TWHB5xjm9zJjy4YS5t2kzS2viWTCo2eMMLFb55/OgksRYY0jLGiYJchWV
 qS+uMeQN/nyAx6Yb2KWHHoTpiqBoUDLEpT3gnI6rFCkwvtmPnU5k45KUmxIvxbME2GVm
 pPsaCX0pgHPHKdkpbz9RBQ+TDnHS4FEKL/W8LHDRAADdAKYvnt5APApMwR2cp1Q43u5V
 nmBJHm3OUKDHIPlE2m9Gs5L5dizgBZa0umuVB8osVhEUhhmLBBofnwl6hiy/bs14YEdO
 RXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x/oBKlX15FX/SgQITgQB/o2DRuL+/xg12kYzT10J5q4=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=AWMRzyffH+j2R0StNkDtBkjyolpds9/iHXyVQ3/F0Rkr5ejtPMZdnFZiRDEKsy0Xj1
 MREjAdJIzEQMA45dYnXzUL/22z5Hbi5+tfUU+OMvQulN/r1gDdO6dfFMEQo7Cd3NUfm3
 ZECDVIMnWHSz9QwpiOLfB69JJH1ZArRgWinIQ9si0O+68NUbihavqSkkRRy6pPeVuM7H
 UBJaxpz0muESijeAxUI637uqRphFZjWqS/greRjk13ush0w5SdHLNOB2tJRjlvf845//
 wcuXpIknSVKdJAWl8HigqSYXVovgggpCjoAx3Fr3RHf0+ajifigJR0aYmOoDTM0zTMDZ
 8gGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780924126; x=1781528926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x/oBKlX15FX/SgQITgQB/o2DRuL+/xg12kYzT10J5q4=;
 b=ranf24ikM0BAjnm3LFGLypwChUx0xGizORABx5YOh+cBJJlo04C3Xg4zTkW5CMJsQK
 PxB4pqMIbaKf4b4F/+tb+0dNDzMgwb4FSBinmCeUxGnPB6Jshn4oCWlzzx+PNp5dDz1z
 RzxtrDXScJoAH5lVLUcQbcyJ9heEoHfQDd0F7/4gOrsZLFXvNjGtUfxkLNVrucKQQKwe
 +cqY89lIpIiAyOQZyFZYJ0N6qD16HAhtn8IM+Q3kyeak3YP5mHOr2L2cXb17SyVWtUE3
 j7gFdKdrYNuhFSAUQW/0wpYJ6typ0GokG/pIxLsjb1FTxcTfCAb6PZKqVRKA3n7OL18Z
 0Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780924126; x=1781528926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/oBKlX15FX/SgQITgQB/o2DRuL+/xg12kYzT10J5q4=;
 b=OsEILYNlmkBTWzr7a4LsA3/S4wdIiRBurg7NLa1nQoenkQLcJ1KxjlO9R+kbrMVixf
 F2fVs4mS7KU7d/9vYDt5jUQOxtwaGnoWn8UYVIav80XO1MC0QiOzd4JInEwComBFY/LI
 CNDhfmZWMuD31obG8h0ZDeM6lNB9VrvktUQ6X4o6183RclviGfuZRfAkY3cYMaDn6XV0
 MrmrGd4CBeSKeo7E0aNGhPxTAzKSCGIBeGhp2AzWCJu3/z//CDB87VYMWJ/QsW1aWpCY
 WZ7UkjWn9VTXXBiRT+dOPK8JM+x80EqqiM1DWBQ/ViH8DZfZXFri4DEZVDcx8d7gS+z1
 gkdw==
X-Gm-Message-State: AOJu0YzyGIrn8qLl+Prj4bcEJMVa+4qvZfKN9grAUWByMmYV4+kfWlzA
 880rXYhMZYbPCfFw2d5hYvBFsIXpPAHMKgQpbMM47YUR/aE+qX7CCeqx9FsWqvUslkIjUGbR3jp
 z2i2ZddG3ErCSgYTg9FqXCI5Fmp7RIp5gfEidHkw7Gg==
X-Gm-Gg: Acq92OEp1JyhNSWg3nZbsIwJ/rsDe22DdC7nW7m1gE1gyxuOlSIXOgh/0kOuZTaKTrv
 no2z1gPg9n5ZublCpurm+69JczGg5TIwU9mHEAAUX10OHwXo8Z/4rjae1URoodcaNrX289wSyhe
 3c7QdGfj/RFrJGrRmqVId10mh5uzYtiatrIWs709dfJK/fUQmrkqJwHckJh8IBnDytPNH/zORh+
 UA/dQfpuWkSf+1ThrLMzfcWt+7NjFZpc0HA79OQP6ddGUP3n8I59+3nkPG2IkT/ivxQVvt6uO0Z
 Q/ClXQk0Do1D729tCHNGyVQaO7CZuXNRgyonFa7zoo67bHv8lH8muiZF1jE8dRdy0pBQKqJ9HUu
 lyw==
X-Received: by 2002:a05:690e:4403:b0:660:5694:9e5c with SMTP id
 956f58d0204a3-66106ff8070mr9173381d50.63.1780924126375; Mon, 08 Jun 2026
 06:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
 <aia8iXGozAclWQCb@sirius.home.kraxel.org>
In-Reply-To: <aia8iXGozAclWQCb@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:08:34 +0100
X-Gm-Features: AVVi8CeXy9uosj154vjgCmjpHJhyH-RK93mZXlvitdwuq5ib0V8AjiCggpUYcC8
Message-ID: <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 8 Jun 2026 at 14:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Jun 08, 2026 at 10:24:28AM +0100, Peter Maydell wrote:
> > On Thu, 4 Jun 2026 at 10:27, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > On Thu, May 28, 2026 at 03:28:05PM +0100, Peter Maydell wrote:
> > > > On Thu, 21 May 2026 at 12:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > >
> > > > > Also little refactoring in preparation
> > > > > to avoid code duplication.
> > > > >
> > > > > Gerd Hoffmann (3):
> > > > >   hw/nvram: add load_image_to_fw_cfg_file()
> > > > >   hw/i386: switch shim loading to load_image_to_fw_cfg_file
> > > > >   hw/arm: add support for shim loading
> > > >
> > > > Any chance of some information on what this is?
> > >
> > > It passes the shim binary to the efi firmware,
> > > in addition to the kernel binary.
> > >
> > > x86 has this for a while already, this brings arm on par.
> > >
> > > docs update with some background below.
> > >
> > > take care,
> > >   Gerd
> > >
> > > --- a/docs/system/linuxboot.rst
> > > +++ b/docs/system/linuxboot.rst
> > > @@ -17,6 +17,15 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
> > >  give the kernel command line arguments. The ``-initrd`` option can be
> > >  used to provide an INITRD image.
> > >
> > > +The ``-shim`` option specifies the shim.efi binary.  This is needed
> > > +when using direct kernel boot with UEFI secure boot enabled.  The
> > > +verification chain used by linux distros requires shim.efi.  Typically
> > > +shim.efi is signed by micsosoft and verified by the firmware.  The
> > > +linux kernel is signed by the distro and is verified by shim.efi.  So
> > > +without shim.efi in the loop secure boot verification will not work.
> > > +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
> > > +distro install media.
> >
> > Thanks. I'm not sure why you'd want to enable UEFI secure boot
> > when you're not booting via UEFI, though.
>
> When not booting via UEFI you can ignore that.

But if I'm doing direct kernel boot then by definition I'm
not booting via UEFI, I'm directly booting the kernel...

thanks
-- PMM

