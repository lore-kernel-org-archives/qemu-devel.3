Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96148CC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXhl-0007hQ-Vt; Tue, 13 Oct 2026 04:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXhk-0007h6-42
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXhg-0004iR-3L
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791879462;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VwLnhXK9Er9pfVvg1KT7GLC2lWRFxb5Il40TarVGddM=;
 b=TMWi7JwGRWod1zqqQ3ToYtQIm3/T1ulLaE9vA51GFQFxGNtCUaQFslYTmktG/IZ+CnpDNI
 01cLFYbxMsWlXitjvcrV1ENoq90kLP3VeKBU8hPfH9hCzjV9tnboQqgHHUyBJWEaK/Y408
 8RDDcCIs+xJR9hTjOvb12bJHPNEg3DQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-_3DI2cY6M_O4YLXznbk8yA-1; Tue,
 13 Oct 2026 08:17:38 +0000
X-MC-Unique: _3DI2cY6M_O4YLXznbk8yA-1
X-Mimecast-MFC-AGG-ID: _3DI2cY6M_O4YLXznbk8yA_1791879458
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA89018088B9; Tue, 13 Oct 2026 08:17:37 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 713CE1800586; Tue, 13 Oct 2026 08:17:36 +0000 (UTC)
Date: Tue, 13 Oct 2026 09:17:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
Message-ID: <as3pHedoXkQDYdNm@redhat.com>
References: <20261001194756.3003085-1-peter.maydell@linaro.org>
 <a3dd935a-0e15-411f-837b-3cfdc1c5bf63@redhat.com>
 <CAFEAcA_Wjx8CpkWkgM=FjaFZ7buQ9AygnCzGTmV9mJAvLrmRJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Wjx8CpkWkgM=FjaFZ7buQ9AygnCzGTmV9mJAvLrmRJw@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 02, 2026 at 11:33:10AM +0100, Peter Maydell wrote:
> On Fri, 2 Oct 2026 at 11:22, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 01/10/2026 21.47, Peter Maydell wrote:
> > > The OHCI USB controller requires software to set up an Endpoint
> > > Descriptor data structure.  This specifies (among other things) both
> > > an EndpointNumber telling the controller which USB endpoint to talk
> > > to, and a Format (F) bit which is 1 for Isochronous transfers and 0
> > > for General transfers.
> > >
> > > The specification requires that software matches the F bit with the
> > > endpoint it's setting up the descriptor for, so that Control, Bulk
> > > and Interrupt endpoints use F=0, and Isochronous endpoints use F=1.
> > > It doesn't require the controller to check whether software gets this
> > > right.
> > >
> > > The spec isn't totally clear about what happens if software creates
> > > an ED with a mismatch, but I believe that the controller just trusts
> > > the F bit, and tries to talk to the endpoint with the wrong sequence
> > > of USB tokens (notably, isochronous transactions have no handshaking
> > > and the others do). This probably results in the transfer failing.
> > >
> > > In hcd-ehci.c we check for the "iso transfer to non-iso endpoint" and
> > > make it fail, but we don't do this in hcd-ohci.c.  The result is that
> > > a guest that deliberately sets up this situation can cause us to hit
> > > the assertion added in commit 7b1eba96aeca, where the endpoint is not
> > > isochronous and returns USB_RET_ASYNC to an iso TD handling function
> > > that isn't prepared to deal with that.
> > >
> > > Add checks for both "iso transfer to non-iso endpoint" and "non-iso
> > > transfer to iso endpoint" and make those TDs fail rather than blindly
> > > sending them to the endpoint.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729

Change that to 'Related', since the assert fix you mention below is
what actually Resolves that issue initially

> > Looks like this issue got assigned with a CVE number, so please add:
> >
> > CVE: CVE-2026-7180
> 
> I guess we might as well, but honestly I don't think this is CVE worthy,
> and I can't find any record of what that CVE number is supposed to cover
> from a websearch.

This issue originated on the qemu-security list, and we declared it
a CVE because it was a guest triggerable use-after-free originally.

> This is in OHCI, which I thought was agreed to be outside
> the security envelope, and in any case it's only an assertion failure.
> 
> The use-after-free that was the original subject of the bug report
> has already been fixed by 7b1eba96aeca (which downgraded it to
> "fails assertion").

Ok, that commit is the one that should have been tagged with the CVE.

This commit is just a nice followup.

> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


