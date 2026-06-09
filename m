Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31A2CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwjH-0002aZ-ME; Tue, 09 Jun 2026 09:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWwjB-0002aK-Kz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWwj8-0004eM-EC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781012565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YC6m27dopR/SCj4M4b6UwzScY/thjJ7Wj2Z3x2ERl5o=;
 b=QJx1Vqo+QnW6oCwc4TuKn/2I3NpDSEZscLXBK7W02XTTdgTK/joXHPE7g30iSpy7M44G2K
 eVrzKHUzMXlgMX2nTaW83LdhYc0A1lsI3QTFSLn48Cdv8IQbieMFSIx5m1YI0LT04PdZLj
 wj20fKxyrx5u3Lyu56A9ykTn5PZ8iWM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-uyBtlCFsNMifGQ2WVH496w-1; Tue,
 09 Jun 2026 09:42:42 -0400
X-MC-Unique: uyBtlCFsNMifGQ2WVH496w-1
X-Mimecast-MFC-AGG-ID: uyBtlCFsNMifGQ2WVH496w_1781012561
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8489D185CEB0; Tue,  9 Jun 2026 13:42:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 988541800480; Tue,  9 Jun 2026 13:42:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 850751800391; Tue, 09 Jun 2026 15:42:39 +0200 (CEST)
Date: Tue, 9 Jun 2026 15:42:39 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
Message-ID: <aigTPdBzp0q4sbKc@sirius.home.kraxel.org>
References: <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
 <aia8iXGozAclWQCb@sirius.home.kraxel.org>
 <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
 <aibALjyPTXVUDpDv@sirius.home.kraxel.org>
 <CAFEAcA-VQWKzJ-aNnzYHZ7a+sVP1y6tkUnE3YCPydsqP0uVXvg@mail.gmail.com>
 <aiflCrf0iDwcpj27@sirius.home.kraxel.org>
 <CAFEAcA_+fZnFG_2xH2gXF7ZtGo-WVwAhwkz9ucuS5kXZOYShnw@mail.gmail.com>
 <aif6QGPxr4oMhb94@sirius.home.kraxel.org>
 <CAFEAcA_qjzLjdqi3NWfY3cTDfkE0HmuvxSV3yVuBb+O95zvV9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_qjzLjdqi3NWfY3cTDfkE0HmuvxSV3yVuBb+O95zvV9w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 09, 2026 at 01:44:25PM +0100, Peter Maydell wrote:
> On Tue, 9 Jun 2026 at 13:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > > > #  - specify a firmware and pass a hint to the kernel to boot
> > > > > #  - direct kernel image boot
> > > >
> > > > That is a technical detail which doesn't make much of a difference
> > > > from the end user perspective.  And often people talk about "direct
> > > > kernel boot" without drawing a line between these two cases, because the
> > > > user-visible behavior is pretty much identical:  You pass a kernel to
> > > > qemu via '-kernel', and it gets booted ...
> > >
> > > As an end user I find them majorly different -- I usually
> > > don't want the firmware, because it takes forever to boot
> > > if you do that.
> >
> > Not sure what exactly you are doing, but for me edk2 is done in less
> > than a second (unless I turn on firmware debug logging), and that on
> > a rpi4 host which isn't exactly fast hardware.  I wouldn't call that
> > "forever".
> 
> If you're running TCG emulation then booting EDK2 is definitely not
> that fast, and I think a lot of use of QEMU for aarch64 targets is TCG,
> not KVM.

On my x86 workstation edk2 boot time on tcg is not very different from
the rpi4 with kvm, also less than one second (until it complains that
the kernel isn't arm ;).

The rpi4 with tcg takes quite some time indeed, but edk2 isn't
exceptionally slow.  Booting until the kernel panics because there is no
root filesystem takes ~30 seconds, and those are roughly 50% / 50%
splitted between firmware and kernel.  A good chunk of the firmware time
is probably the zboot efi stub for kernel self-decompression (would have
to instrument the firmware for more details on that).

Comparing that to direct boot without firmware does not work for me:

  unable to handle EFI zboot image with "zstd" compression
  qemu-system-aarch64: could not load kernel '/boot/vmlinuz-7.0.11-200.fc44.aarch64'

Anyway, I'll go over the comments and try to make the docs patch more
clear for people with less UEFI background.  Update should come later
this week.

take care,
  Gerd


