Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42381CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0FU-00070m-Qy; Tue, 23 Jun 2026 08:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit@kernel.org>)
 id 1wc0FR-00070R-Hc; Tue, 23 Jun 2026 08:29:02 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit@kernel.org>)
 id 1wc0FP-0002rq-GL; Tue, 23 Jun 2026 08:29:01 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9253060052;
 Tue, 23 Jun 2026 12:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB61F00A3A;
 Tue, 23 Jun 2026 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782217731;
 bh=IJ6Axz0eVXdM4N2zxXdUABV+j4GrWlobah6JTruDwdc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=R04vDP4MYKlx72aSjyFYoz4Lzvhf7spBx/LpF4/tcHUJPiW9KzgU5YSSFIGTHALYV
 uy9e2cHWTW8Fegkb2kzTikWMgs0maWt28NXu+luS1VsK/SRNeLV8eihor47rBvIWMj
 vrMasYIwzUK/qRQAmSchjvLhyp+28N9POqxlNPCyNsYhxnB3T3RpRn6fBIDhCySA2g
 teFOHs1FmhPhyZNCm069PsiEHtp9jp+Jwy7Yu5oxOkL6a7lYgCec4esPrHL1FZAx9T
 HW//PtgwKv1IRuAw7OMh/fgDdx/+Sj3IuDwrRwftKNYVeQ5a1aMP5K07VSpt4t7V7k
 /Ohugzo0URScw==
Message-ID: <f8a5a7921f1402c2708e406b3faaa14cbcee829c.camel@kernel.org>
Subject: Re: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
From: Amit Shah <amit@kernel.org>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mauro
 Matteo Cascella <mcascell@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	 <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Date: Tue, 23 Jun 2026 14:28:48 +0200
In-Reply-To: <ajljKftAKpkoiN7w@redhat.com>
References: <20260622161144.2883799-1-lvivier@redhat.com>
 <ajljKftAKpkoiN7w@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=amit@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2026-06-22 at 17:30 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jun 22, 2026 at 06:11:44PM +0200, Laurent Vivier wrote:
> > A malicious guest can craft virtqueue descriptors with arbitrary
> > lengths.
> > control_out() calls iov_size() on the guest-supplied scatter-gather
> > list
> > and passes the result directly to g_malloc(), allowing a guest to
> > force
> > QEMU to attempt multi-gigabyte allocations and crash the host
> > process.
> >=20
> > Fix this by copying at most sizeof(struct virtio_console_control)
> > into a
> > stack-local variable instead of allocating a buffer sized by the
> > guest.
> > handle_control_message() only accesses the fixed-size id, event,
> > and
> > value fields, so no data beyond the struct was ever needed.
>=20
> Does anyone have thoughts on whether we should treat guest initiated
> unbounded allocs as a security issue ?
>=20
> IIUC, this flaw would require root in the guest OS in order to craft
> the malicious virtqueue descriptors.

We've always treated guests to be malicious and design host interfaces
with that in mind (i.e. even w/o the qualifier that root access is
needed in guests -- it's assumed guests are always malicious).

> A self-initiated crash triggered by root would not historically
> be enough justification for CVE. We would require it to be triggered
> by unprivileged user.
>=20
> Nested virt with device assignment could change that equation though
> as the L2 guest could be considered an unpriv user from the L1 POV.
>=20
> Also in theory the large alloc might be large enough to consume all
> host RAM but not large enough to trigger OOM kill of QEMU. This might
> impact operation of other co-located VMs on the same host.
>=20
> Anyone think this is bad enough to justify a CVE ? Or should we treat
> these OOM scenarios maerely as "hardening" bugs, where they require
> 'root' in the L1 guest ?
>=20
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Typically the size would be bounded by the cgroups surrounding the qemu
process; but in any case I would assume the guest would only end up
killing the qemu process, rather than starve the whole host of RAM.  I
wouldn't qualify this a CVE.

		Amit

