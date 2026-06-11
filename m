Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAC9CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmHR-00019p-ME; Thu, 11 Jun 2026 16:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXmHC-00018G-7j
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXmH9-0006tw-1U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781210718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SEAS8aZnkjaNWH/Rng+G2KXsPMcTSf+NyRSf60JiCM=;
 b=FHi7bklL90YXyYHOCfc01s0L0Vdh8Thwyyf1UIPFgS499iNTBQOO9/UGhWPus+yw5wdoQP
 nQrRMTumye++gpbFNKw7jNCBICtQgH5FsvJGvc+fIe9WdXcwfi8tp5H2wAim3cLUbFy/n2
 gjsUMCj9nQOe91YsuiRffvPVjm4VCQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-U1yCXXH5N7G8X3f-Yru9Ug-1; Thu, 11 Jun 2026 16:45:16 -0400
X-MC-Unique: U1yCXXH5N7G8X3f-Yru9Ug-1
X-Mimecast-MFC-AGG-ID: U1yCXXH5N7G8X3f-Yru9Ug_1781210715
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef3aeeb41so134902f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781210715; x=1781815515; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4SEAS8aZnkjaNWH/Rng+G2KXsPMcTSf+NyRSf60JiCM=;
 b=pzRtO8ZvN21HZDdVIfeKT7nj6488c/GMlRKY9XEtkeAQMExd1wOhlXfAr0z1TpJuGS
 7RdyWZhtiqwu8oV4I9/mtBeUs+IF9c0S2YCGs44e5uW9qWHUKE9w/gkSWAsOoKIlZcwM
 SxuPmyMa0n0dqRhl/u1kobU028Uxnkzt5lScydqtQHnzetOwkltzVTg3N4BEEk0E4cEl
 1ujMaC7NzegBatHwsyytOCBk3IqHOPDEo0SmGivoG2oTKRFvU4Ypj7wRy4XFt3toC/2h
 iOIskO/yl/nZR3wtf+7opEZPk7E2OS5z82fqNNod4q3i9HHgOMrlg3xUZ4PcqCUtM9nx
 HJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781210715; x=1781815515;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4SEAS8aZnkjaNWH/Rng+G2KXsPMcTSf+NyRSf60JiCM=;
 b=Nc47hPRxCPRzRma2twrKa/2bnml23Pq68pC6rCH/lJnteicapX/TrT2dLZXXJpeMrg
 dqqs6Gdk7zF64KWZRMhR7aVSOciUFZjm98W1oLQRj+IdebbXSpxOGgKetO4D0zRilE1c
 60q7oszs7BACxmnz8AyN43VJZe83OPE+zjPO495yB/877yPa2J59P9IgScJX8g34+B0E
 EvqJZd4mEEfw2AYdy6A+yUklFSWO9biz7PcPh71kHFa22V5u1wKSLx4oGICz7fRNbcXj
 39MRNPUYPLbzQJE/d+drwUTD2ZcJmy2tWQjwN85yeq3DXBeDhPsNzpa3WrJWfPh6PFO9
 UmJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b+mXJrC9Do4bsmImY5ccX2+oUL2wwFj56gnkiSVPqGYWh3ADSo8Eac/+PAn9O7ed8deLz+dOT5UeJ@nongnu.org
X-Gm-Message-State: AOJu0YzPbdkgbFVI2XBgKyg3YrhR8ZPqf37n3uX4xhLLXC3GlTueKwnu
 s0IsFfyC1eIgvdxNHlltwGQhW1qNbMiq5wSCa0TV1Yknj1OCL1iSP7w4S71mDbWvP3CXEGk8+ED
 33h159SgFLECtwbNRCNMGTqMhWTpigRJqmG7t53/DTgdblf29Qi0yxtTb
X-Gm-Gg: Acq92OGDip8fhvjzq3QnqgEEkB4eATJlRyrC7E7F80JOpY3+MPoZoTbfdt7XzH7/sNu
 Ros/vHqA/m3kkujglta17RXA9QtQ9ccbx28aMxX/WWKgrUSDY6XpF9mSd1vB5igYY4ttKQjEKFF
 ZEPBdlKeAxunqdCS6XeH7yCfiCH4gos/BxOMmZKxQ+2/kBf8uT82OSgcLAa/KJkU70VAzgoEz+C
 wtHxhuzL9ixZ0iCyvfH5qT0cSH9EqDIUQpoexVmfiuH1W8p5ii1zGKsvqQQSQEFAc+GbGTIPSWl
 mrzHGUCfcUZs6STI1+itIBMZ6iezeTsxvIWXKarXaCv826qUur5l9GcJ6uJYhORw8lZTcyufwVM
 +mLYfug8UoJ+xvO8V1Tzb2AjXLmmGPN3Ce5pvdmURJdk=
X-Received: by 2002:a05:6000:4284:b0:460:e00:121c with SMTP id
 ffacd0b85a97d-4606dbc6792mr15317f8f.28.1781210715314; 
 Thu, 11 Jun 2026 13:45:15 -0700 (PDT)
X-Received: by 2002:a05:6000:4284:b0:460:e00:121c with SMTP id
 ffacd0b85a97d-4606dbc6792mr15278f8f.28.1781210714728; 
 Thu, 11 Jun 2026 13:45:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0c2059sm1493714f8f.6.2026.06.11.13.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:45:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:45:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260611164404-mutt-send-email-mst@kernel.org>
References: <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
 <aikiB90tij642pEZ@redhat.com> <20260611203915.GB237427@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611203915.GB237427@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 11, 2026 at 04:39:15PM -0400, Stefan Hajnoczi wrote:
> On Wed, Jun 10, 2026 at 09:37:10AM +0100, Daniel P. Berrangé wrote:
> > On Tue, Jun 09, 2026 at 08:51:15PM +0100, Peter Maydell wrote:
> > > On Tue, 9 Jun 2026 at 20:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > >
> > > > On Tue, Jun 9, 2026 at 2:51 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > >
> > > > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > > > > I'm not sure if anyone brought up this topic on qemu-devel and with
> > > > > > Michael before. As I mentioned in my reply, there are ways to avoid
> > > > > > blocking vhost-user spec changes when qemu.git is frozen:
> > > > > >
> > > > > > The simplest approach is to keep merging vhost-user.rst changes during
> > > > > > freeze since it does not jeopardize the release or introduce
> > > > > > instability.
> > 
> > snip
> > 
> > > I tend to view the specs subsection of the docs as being
> > > for things where either QEMU really is the authoritative
> > > source (eg fw_cfg), or where the spec is for something that's
> > > basically moribund and has no better home. If vhost-user is
> > > a cross-project specification that it so active that it
> > > cannot live within QEMU's release process, then I think
> > > it deserves to have its own independent home.
> > 
> > Yes, the main impression I get having read through this whole thread
> > is that vhost-user spec should have its own home outside QEMU.
> > 
> > We can come up with all sorts of rationalizations for how to make
> > things work in the context of QEMU, but they all just come across
> > as excuses to avoid changing the fairly arbitrary historical use
> > of qemu.git. Even if as QEMU maintainers we consider that we're a
> > "neutral" home, I can understand why it might not be perceived that
> > way from the outside.
> > 
> > If people want agility such that we need to make exceptions for
> > our rules during freeze that is one flag that it doesn't belong
> > with the main qemu.git, but there are broader points that are
> > pushing my view in that direction too.
> > 
> > 
> > Not mentioned is that engaging with the QEMU mailing list as a
> > non-regular QEMU contributor is not a very attractive task.
> > While QEMU may be satisfied with email, QEMU are in a tiny
> > minority these days. The rest of the OSS community has
> > decided that git forges are the better way to collaborate.
> > 
> > Our dev list is very high volume, with changes very easily (and
> > often) lost in the noise, even from regular contributors, such
> > that we have to teach people to (repeatedly) "ping" to attract
> > attention.
> 
> A separate repo in a git forge definitely has the advantage of making
> communication easier to follow for anyone interested only in the
> vhost-user protocol.
> 
> > If we want agility though, IMHO it is best to stay away from the
> > bureucracy of the OASIS virtio spec / committee, which is a big
> > turn off IME.
> 
> Yes, OASIS adds overhead.
> 
> The downside is that vhost-user suffers from being outside the VIRTIO
> spec umbrella. It's really a VIRTIO Transport and would benefit from the
> discipline of actually being part of the spec as such. At the moment
> vhost-user is not really bound to VIRTIO through any interface (i.e.
> VIRTIO Transport) or device lifecycle that is guaranteed to align with
> the VIRTIO spec. This has led to both design problems and bugs that
> would be prevented by making it a VIRTIO Transport.
> 
> In addition to the OASIS overhead you mentioned, the other issue is that
> moving vhost-user into the VIRTIO spec would require reconciling the
> the vhost-user protocol with the VIRITO Transport's interface and also
> rewriting parts of the vhost-user spec that are not up to the level
> (e.g. adding conformance clauses, eliminating some informal language,
> etc).

And possibly getting an agreement to OASIS IPR from major past contributors.

> In other words, it's a bunch of work. Although from a purist perspective
> I think it's the right place for vhost-user, I think it would be an
> unpopular solution.
> 
> > If we're considering a move of the spec, we should probably consider
> > the best home for some of the related code parts too:
> > 
> >   subprojects/libvhost-user/
> >   contrib/vhost-user-blk/
> >   contrib/vhost-user-bridge/
> >   contrib/vhost-user-gpu/
> >   contrib/vhost-user-input/
> >   contrib/vhost-user-scsi/
> > 
> > IIUC, the subprojects is fully standalone code with no dependency
> > on QEMU. It remained within QEMU for "convenience" allowing us to
> > consume them from the impls under contrib/. While the contrib code
> > has some depedencies on QEMU, overall they appear pretty light and
> > so likely easily detached
> > 
> >   $ git grep '#include "' vhost-user-* | awk '{print $2}' | sort | uniq
> >   "hw/virtio/virtio-gpu-bswap.h"
> >   "hw/virtio/virtio-gpu-pixman.h"
> >   "libvhost-user-glib.h"
> >   "libvhost-user.h"
> >   "qapi/error.h"
> >   "qemu/atomic.h"
> >   "qemu/bswap.h"
> >   "qemu/ctype.h"
> >   "qemu/drm.h"
> >   "qemu/iov.h"
> >   "qemu/osdep.h"
> >   "qemu/queue.h"
> >   "qemu/sockets.h"
> >   "standard-headers/linux/input.h"
> >   "standard-headers/linux/virtio_blk.h"
> >   "standard-headers/linux/virtio_gpu.h"
> >   "standard-headers/linux/virtio_input.h"
> >   "standard-headers/linux/virtio_net.h"
> >   "standard-headers/linux/virtio_scsi.h"
> >   "virgl.h"
> >   "vugbm.h"
> >   "vugpu.h"
> > 
> > 
> > We have a often repeated desire to eliminate the "contrib" tree
> > as a concept, since it is currently effectively a "dumping ground"
> > for things which are either unmaintained or didn't have a better
> > home yet. This might be a chance to provide a better home for a
> > big part of it.
> > 
> > IMHO this suggests it is worth creating a new top level gitlab project
> > for it all to live in and form a dedicated team around it, rather than
> > trying to pick any existing location.
> 
> Some vhost-user back-ends in the contrib/ directory are used by QEMU's
> test suite. An alternative way of integrating them into the tests could
> be found, but I wanted to mention that dependency.
> 
> Stefan



