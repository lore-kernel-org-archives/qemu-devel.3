Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370F4CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZdW-0003Fw-6n; Mon, 08 Jun 2026 09:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWZdD-0003CU-4M
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWZdA-0004WO-4M
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780923782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+QEkUTlVzuP/zZtzIwgsMWmoabdKJGHw643t8oWVWk=;
 b=OQNurXaauTHuQGgabTkuDgGWT63Vs7r5CQS+O4tS7qZZe04X10r+EhNA43DArbz9MWNthK
 nhURLMB1GDb+i1I1tyvjGPbn+kbAtCHWzR3gMumNg6bm4JEALLxY59/mvgfo5EJHl0yPIH
 I/KuuP95O5WI8bakm765uEsOMzft7co=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-m5tZlRqGMxuyENMXSEshyA-1; Mon,
 08 Jun 2026 09:02:58 -0400
X-MC-Unique: m5tZlRqGMxuyENMXSEshyA-1
X-Mimecast-MFC-AGG-ID: m5tZlRqGMxuyENMXSEshyA_1780923777
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47DE21955DBB; Mon,  8 Jun 2026 13:02:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D85318004D4; Mon,  8 Jun 2026 13:02:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2270E180060A; Mon, 08 Jun 2026 15:02:55 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:02:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
Message-ID: <aia8iXGozAclWQCb@sirius.home.kraxel.org>
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jun 08, 2026 at 10:24:28AM +0100, Peter Maydell wrote:
> On Thu, 4 Jun 2026 at 10:27, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, May 28, 2026 at 03:28:05PM +0100, Peter Maydell wrote:
> > > On Thu, 21 May 2026 at 12:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >
> > > > Also little refactoring in preparation
> > > > to avoid code duplication.
> > > >
> > > > Gerd Hoffmann (3):
> > > >   hw/nvram: add load_image_to_fw_cfg_file()
> > > >   hw/i386: switch shim loading to load_image_to_fw_cfg_file
> > > >   hw/arm: add support for shim loading
> > >
> > > Any chance of some information on what this is?
> >
> > It passes the shim binary to the efi firmware,
> > in addition to the kernel binary.
> >
> > x86 has this for a while already, this brings arm on par.
> >
> > docs update with some background below.
> >
> > take care,
> >   Gerd
> >
> > --- a/docs/system/linuxboot.rst
> > +++ b/docs/system/linuxboot.rst
> > @@ -17,6 +17,15 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
> >  give the kernel command line arguments. The ``-initrd`` option can be
> >  used to provide an INITRD image.
> >
> > +The ``-shim`` option specifies the shim.efi binary.  This is needed
> > +when using direct kernel boot with UEFI secure boot enabled.  The
> > +verification chain used by linux distros requires shim.efi.  Typically
> > +shim.efi is signed by micsosoft and verified by the firmware.  The
> > +linux kernel is signed by the distro and is verified by shim.efi.  So
> > +without shim.efi in the loop secure boot verification will not work.
> > +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
> > +distro install media.
> 
> Thanks. I'm not sure why you'd want to enable UEFI secure boot
> when you're not booting via UEFI, though.

When not booting via UEFI you can ignore that.

> Do we actually run the shim.efi code, or is it just there to
> be "verified" ?

edk2 firmware will load + run it (if present).

take care,
  Gerd


