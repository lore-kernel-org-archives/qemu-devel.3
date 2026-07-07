Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0C1C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3DY-0003rw-Jo; Tue, 07 Jul 2026 06:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh3DW-0003rV-Nt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh3DU-00036g-UW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783420791;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2I+1hbhhd5TK48aNKFqoQHkqDYL1fsxhzXNrGZdpnA=;
 b=VW2UO/yfPPGDFNRTgvLVpBB0NboaIuj9pVtb99uf87X2PVK3CLSN/F1R603m/3K7qY6OCc
 bDr2d088QBCPokQp9OApslDPIT4h/SquB5FljVohqNXcWtNb9d25Zpg/wH0312UBGnVJQJ
 C5dfrhdFDz+rPrIWFOybbDeC3PdCPNs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-WOZ9SY6jOWC7Vq3qeT7mLA-1; Tue,
 07 Jul 2026 06:39:48 -0400
X-MC-Unique: WOZ9SY6jOWC7Vq3qeT7mLA-1
X-Mimecast-MFC-AGG-ID: WOZ9SY6jOWC7Vq3qeT7mLA_1783420787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FFB81955DB7; Tue,  7 Jul 2026 10:39:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3557619560A3; Tue,  7 Jul 2026 10:39:45 +0000 (UTC)
Date: Tue, 7 Jul 2026 11:39:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
Message-ID: <akzXblNvD5s4QGgB@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <aktl-ojkXVZ4Jira@redhat.com>
 <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Mon, Jul 06, 2026 at 09:22:12PM +0200, Anatol Belski wrote:
> Hi Daniel,
> 
> On Mon, 2026-07-06 at 09:29 +0100, Daniel P. Berrangé wrote:
> > On Sat, Jul 04, 2026 at 03:37:21PM +0200, Anatol Belski wrote:
> > 
> > 
> > The README only lists  cloud hypervisor bugs.  Did you file any for
> > QEMU yet ?

snip

> I have been reaching out to a few QEMU maintainers individually first,
> to confirm these are ordinary robustness bugs and not security
> sensitive before anything goes public. I am being careful because
> automated and AI generated reports are flooding projects right now,
> and I did not want to add noise or mishandle something sensitive.

We appreciate the intent not to flood projects ! Feel free to
drip-feed issues to us, a handful at a time though over days
or weeks if there will be alot to process.

We recently switched our security disclosure process over to using
our regular GitLab issue tracker, so would prefer any bugs to be
filed there, rather than emailing people directly:

  https://www.qemu.org/contribute/security-process/

This gives us resilience if individual manitainers are offline or
over-burdened by other work.

If it has security implications just select the "confidential"
tick box when filing. We can easily make it public if we decide
it is not a security issue during triage.

> > If this is finding bugs in QEMU this test harness sounds like the
> > kind
> > of thing we ought to have integrated in QEMU's meson test suite such
> > that it runs in CI to prevent regressions.
> > 
> 
> Makes sense. I have been exercising QEMU regularly anyway, since it is
> the de facto standard to compare against, so wiring the harness into
> the QEMU test setup to catch regressions is a natural fit. One note on
> shape. qtest drives a device from outside the guest, poking its
> registers over a socket with no guest code running. virtio-villain
> works the other way around, it boots a tiny init into an initramfs,
> with no full OS, and that guest drives the device as real guest code.
> So it stays lightweight, just a booted guest rather than an external
> driver. I think that is worth exploring. The harness is public, so it
> is there to build on, and I am glad to help work out how it could fit.

We also have tests/functional/ in QEMU where we boot real guest OS
disk images and/or kernel/initrd pairs. The minimal initramfs
approach would probably fit in nicely with that, and indeed I have
long wanted us to replace some of our full-fat disk images with
minimal self contained initramfs images to speed up smoke testing.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


