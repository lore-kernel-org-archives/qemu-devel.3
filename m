Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7839CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7sr-0005t7-IH; Mon, 15 Jun 2026 10:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ7sn-0005rr-FG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ7si-0003G7-3I
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781532099;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCYvyD6JCgalr+O+68KnyshiG9KqipO3rBtqI6S4UPQ=;
 b=divfe4Tonnluji0EdgSyHdZN4ZTA9OiovNUjpkea4gvFuzPKIkStBJ+QdPLcZk3kXV8fBP
 OqYbrh3MHs0glPmyA3FXD9Ps7hdD5VIfiwSADvIeKw1BorAABDBP0QOmy9PfUpZr3ZsIBc
 U+s0UNmMuhz8OkkWbe8pWXSF8dVRuo8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-3ilvKkUSOUCzUpaIP1Umug-1; Mon,
 15 Jun 2026 10:01:25 -0400
X-MC-Unique: 3ilvKkUSOUCzUpaIP1Umug-1
X-Mimecast-MFC-AGG-ID: 3ilvKkUSOUCzUpaIP1Umug_1781532081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E58211955E9E; Mon, 15 Jun 2026 14:01:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.222])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47A4C18005AE; Mon, 15 Jun 2026 14:01:15 +0000 (UTC)
Date: Mon, 15 Jun 2026 15:01:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
Message-ID: <ajAFp14L-VeCQsym@redhat.com>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
 <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
 <ai-5M6FF7CoJc_re@redhat.com>
 <CAFEAcA_52oFGv7cC11jbpj9pwBq-x2O-R_aOGkYzaRWW7t-K2g@mail.gmail.com>
 <acb64b89-2a5f-4f7c-b5c8-8c31667908c2@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acb64b89-2a5f-4f7c-b5c8-8c31667908c2@nutanix.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 15, 2026 at 02:42:10PM +0100, Mark Cave-Ayland wrote:
> On 15/06/2026 10:28, Peter Maydell wrote:
> 
> > On Mon, 15 Jun 2026 at 09:35, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > On Mon, Jun 15, 2026 at 09:31:36AM +0100, Peter Maydell wrote:
> > > > On Mon, 15 Jun 2026 at 09:13, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > Do we know how many examples we have of embedding objects inside
> > > > > another ?
> > > > 
> > > > It is an extremely common pattern for device and SoC model
> > > > implementations; we've been recommending it for years.
> > > > 
> > > > > I would much prefer if we forbid the embedding of objects. It is
> > > > > horrible design practice to have some QOM objects which can be
> > > > > freed via reference count and some which cannot.
> > > > 
> > > > That would be a very large amount of code to rewrite to the
> > > > new paradigm. I don't object inherently ("you have pointers to
> > > > your child objects" works better when they might be implemented
> > > > in Rust and might play better with being able to create
> > > > machines and wire them up on the command line); I'm just
> > > > noting how much work it would be if you wanted to make
> > > > embedding forbidden.
> > > 
> > > Would it be a more tractable problem to "fix" object structure only
> > > incrementally as they gain a need to be managed/reference from
> > > Rust code, or does the Rust usage already implicitly extend too
> > > broadly
> > 
> > At the moment we have exactly 2 Rust devices. You can see the
> > workaround we ended up with for the PL011 in commits 5b87a07e768
> > and cc3d262aa93a4, where we pad out the C device struct and
> > assert on the Rust side that its version isn't any bigger.
> > 
> > For that particular problem we could say "you need to refactor
> > all users of device X to not embed it before creating the Rust
> > version". There is I think only one embedded use of the PL011
> > (I was actually expecting more). This does have the awkward
> > effect that anybody wanting to do a "rewrite device in rust"
> > is now forced into "do a big refactor of some old C code they
> > don't care about". We would also need to actually document and
> > provide some good examples of "this is how we think we should
> > be writing device models that have child objects now".
> 
> I think given the legacy of the QEMU codebase then this will always be an
> issue, but we've solved this in the past with the introduction of
> MemoryRegions so there's no reason we couldn't do it again.
> 
> This is a similar problem to the use of non-class object properties I was
> discussing in the thread with Daniel: it seems the general consensus is that
> they shouldn't exist, but this hasn't been formalised anywhere. If we can
> formalise the decision not to use embedded QOM objects, then we can start by
> ensuring that new submissions don't use them and go from there.
> 
> Question: who currently should make these decisions? Is it restricted to the
> QOM maintainers?

Ultimately it would need a docs update on object.h to declare the
object_initialize_child related methods to be deprecated which the
QOM maintainers would have to queue.

Since this impacts device maintainers in general though, IMHO we need
broad consensus that it is a better approach & we're willing to convert
existing code incrementally.

We have ~150 devices using this for 824 children

$ git grep -l  object_initialize_child  | wc -l
150

$ git grep object_initialize_child | wc -l
824


Where updates are desired, we'd be looking at tedious changes like
thsi:

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 31fa53e6a4..86757c56e5 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -355,16 +355,23 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
 
     /* USB */
     if (d->has_usb) {
-        object_initialize_child(OBJECT(dev), "uhci", &d->uhci, uhci_type);
-        qdev_prop_set_int32(DEVICE(&d->uhci), "addr", dev->devfn + 2);
-        if (!qdev_realize(DEVICE(&d->uhci), BUS(pci_bus), errp)) {
+        d->uhci = UHCI(object_new_with_props(
+                           uhci_type, OBJECT(d), "uhci", errp, NULL));
+        if (!d->uhci) {
+            return;
+        }
+        qdev_prop_set_int32(DEVICE(d->uhci), "addr", dev->devfn + 2);
+        if (!qdev_realize(DEVICE(d->uhci), BUS(pci_bus), errp)) {
             return;
         }
     }
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 31fa53e6a4..86757c56e5 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -355,16 +355,23 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
 
     /* USB */
     if (d->has_usb) {
-        object_initialize_child(OBJECT(dev), "uhci", &d->uhci, uhci_type);
-        qdev_prop_set_int32(DEVICE(&d->uhci), "addr", dev->devfn + 2);
-        if (!qdev_realize(DEVICE(&d->uhci), BUS(pci_bus), errp)) {
+        d->uhci = UHCI(object_new_with_props(
+                           uhci_type, OBJECT(d), "uhci", errp, NULL));
+        if (!d->uhci) {
+            return;
+        }
+        qdev_prop_set_int32(DEVICE(d->uhci), "addr", dev->devfn + 2);
+        if (!qdev_realize(DEVICE(d->uhci), BUS(pci_bus), errp)) {
             return;
         }
     }


Noting that the compiler won't complain if we forget to update any
lines like

-        qdev_prop_set_int32(DEVICE(&d->uhci), "addr", dev->devfn + 2);
+        qdev_prop_set_int32(DEVICE(d->uhci), "addr", dev->devfn + 2);

because the explicit DEVICE(..) cast is hiding the type error we would
otherwise get from using "Device **" instead of "Device *".


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


