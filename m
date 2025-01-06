Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC7AE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlkL-0005OV-9z; Mon, 06 Jan 2025 06:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUlkJ-0005OA-Hp
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUlkH-0006ph-N1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736164688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttosU+WvT7l+NaLyFsBPGFTr4HvzPmFNRggoM0zY7ZA=;
 b=EFU1MAstIo52ATBdH96jvVg2ma4BLMnU//Pk7ylOZLgcIU7rjCELQwRJGZDjPuTYcl1RU3
 HwUrqJx5N5ANv/KAattMD5Gp1Lnna61xrLIGRrE/RyjzHxwxHx9MOK/TUtI+E3lQjDFCBh
 954HWh3iAyzTqxQwy+ptXeLY3B1euDs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-4zPk5eK7MRGw_n6_8fur1w-1; Mon,
 06 Jan 2025 06:58:05 -0500
X-MC-Unique: 4zPk5eK7MRGw_n6_8fur1w-1
X-Mimecast-MFC-AGG-ID: 4zPk5eK7MRGw_n6_8fur1w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F30D195608B; Mon,  6 Jan 2025 11:58:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 708B4195605F; Mon,  6 Jan 2025 11:58:01 +0000 (UTC)
Date: Mon, 6 Jan 2025 11:57:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>,
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 David Abdurachmanov <davidlt@rivosinc.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32, 64} part of the same
 family
Message-ID: <Z3vFRrkjIEa-LaqU@redhat.com>
References: <20241203094702.124748-1-abologna@redhat.com>
 <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
 <CAKmqyKMkN7z51MoAeOK-buDZjKeEV7AjzviyVcZ_AyMEJPgg0w@mail.gmail.com>
 <CAFEAcA97_XJNs=oZP2OUTsGdaEU0YD9_PFzucQO214+Vmo1mmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA97_XJNs=oZP2OUTsGdaEU0YD9_PFzucQO214+Vmo1mmQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 06, 2025 at 11:47:00AM +0000, Peter Maydell wrote:
> On Mon, 6 Jan 2025 at 01:29, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Fri, Jan 3, 2025 at 2:04 AM Andrea Bolognani <abologna@redhat.com> wrote:
> > >
> > > On Tue, Dec 03, 2024 at 10:47:02AM +0100, Andrea Bolognani wrote:
> > > > Currently the script won't generate a configuration file that
> > > > sets up qemu-user-riscv32 on riscv64, likely under the
> > > > assumption that 64-bit RISC-V machines can natively run 32-bit
> > > > RISC-V code.
> > > >
> > > > However this functionality, while theoretically possible, in
> > > > practice is missing from most commonly available RISC-V hardware
> > > > and not enabled at the distro level. So qemu-user-riscv32 really
> > > > is the only option to run riscv32 binaries on riscv64.
> > > >
> > > > Make riscv32 and riscv64 each its own family, so that the
> > > > configuration file we need to make 32-on-64 userspace emulation
> > > > work gets generated.
> > > >
> > > > Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> > > > Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> > > > Thanks: Daniel P. Berrangé <berrange@redhat.com>
> > > > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> > > > ---
> > > >  scripts/qemu-binfmt-conf.sh | 7 ++-----
> > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > ping
> > >
> > > There are already two ACKs so I think we just need a maintainer to
> > > pick this up.
> >
> > We didn't get an answer to the issue of a CPU supporting RV32 and yet
> > the kernel still calls QEMU.
> >
> > I understand this allows things to work out of the box, but seems like
> > a disservice to any hardware that does support RV32
> 
> There's the same thing on Arm too -- we don't set up qemu-user
> aarch32 binfmt-misc on an aarch64 system because the host might
> be able to natively execute the aarch32 binary. This is becoming
> less true, but we still don't want to silently downgrade
> native execution to emulation on the hosts where native execution
> used to work.

Arm is a bigger problem as historically there genuinely was a
non-trivial set of CPUs with 32-on-64 support in HW.

IIUC, the riscv situation is much less likely to be a real problem

> I'm not sure the best approach here -- ideally we would want to
> be able to register a binfmt-misc to the host kernel with "only use
> this if you could not already natively execute it", but AFAIK that's
> not possible.

The other thing is that qemu-binfmt-conf.sh is not really the right
place to decide this, as we can't assume it is being run on the machine
that QEMU will be deployed on. eg in distro case, qemu-binfmt-conf.sh
may be run in a build farm to statically generate files.

Any conditional loading of binfmt rules would required extra magic to be
implemented by systemd, or would have to be done by the user selectively
installing different packages to omit the binfmt rules they don't want.

As a immediate bandaid, I'd suggest that qemu-binfmt-conf.sh could keep
its current logic as the default, and have a switch "--32-on-64" [1] to
tell it to generate the binfmt for 32-bit arch, even if 64-bit arch
could have 32-bit support.

Distros/users could then choose whether to pass --32-on-64 when statically
generating the binfmt files.

With regards,
Daniel

[1] better names welcome
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


