Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC50CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd35w-00066C-68; Fri, 26 Jun 2026 05:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd35k-0005ui-UE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd35i-0005ir-Fr
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782466996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGUREzcjpt+z21OcPFaGtXNQd47IjgDOvD8qgdQ2G6U=;
 b=Smmz53uXYS2WKCyToJhfHyG7ykSu+PStmDDye6DXv6u+kdDtz3S1YziojULtXQWXNrKQUg
 qtvUYRQa8QzuCG4TYLiEG9py2Otj02A/MFtg/fwkuKtxmD30SozYABqb3mxN/gv4wEuyqh
 mmkY0N7CPP8Y6G1T4v8y+pzgpK9TfJU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-cW90HGM0PGGIK_cHK5BX3A-1; Fri,
 26 Jun 2026 05:43:14 -0400
X-MC-Unique: cW90HGM0PGGIK_cHK5BX3A-1
X-Mimecast-MFC-AGG-ID: cW90HGM0PGGIK_cHK5BX3A_1782466993
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D090419560B1; Fri, 26 Jun 2026 09:43:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C9A61800661; Fri, 26 Jun 2026 09:43:09 +0000 (UTC)
Date: Fri, 26 Jun 2026 10:43:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
Message-ID: <aj5JqY7bKkqViaZL@redhat.com>
References: <20260622161144.2883799-1-lvivier@redhat.com>
 <ajljKftAKpkoiN7w@redhat.com>
 <CAA8xKjXARvc3m7F30Us-57BMqaCo1qqZMp8c_wBzMAs_cvFj=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8xKjXARvc3m7F30Us-57BMqaCo1qqZMp8c_wBzMAs_cvFj=Q@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 25, 2026 at 06:56:05PM +0200, Mauro Matteo Cascella wrote:
> On Mon, Jun 22, 2026 at 6:30 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Jun 22, 2026 at 06:11:44PM +0200, Laurent Vivier wrote:
> > > A malicious guest can craft virtqueue descriptors with arbitrary lengths.
> > > control_out() calls iov_size() on the guest-supplied scatter-gather list
> > > and passes the result directly to g_malloc(), allowing a guest to force
> > > QEMU to attempt multi-gigabyte allocations and crash the host process.
> > >
> > > Fix this by copying at most sizeof(struct virtio_console_control) into a
> > > stack-local variable instead of allocating a buffer sized by the guest.
> > > handle_control_message() only accesses the fixed-size id, event, and
> > > value fields, so no data beyond the struct was ever needed.
> >
> > Does anyone have thoughts on whether we should treat guest initiated
> > unbounded allocs as a security issue ?
> >
> > IIUC, this flaw would require root in the guest OS in order to craft
> > the malicious virtqueue descriptors.
> >
> > A self-initiated crash triggered by root would not historically
> > be enough justification for CVE. We would require it to be triggered
> > by unprivileged user.
> >
> > Nested virt with device assignment could change that equation though
> > as the L2 guest could be considered an unpriv user from the L1 POV.
> >
> > Also in theory the large alloc might be large enough to consume all
> > host RAM but not large enough to trigger OOM kill of QEMU. This might
> > impact operation of other co-located VMs on the same host.
> >
> > Anyone think this is bad enough to justify a CVE ? Or should we treat
> > these OOM scenarios maerely as "hardening" bugs, where they require
> > 'root' in the L1 guest ?
> 
> I'd lean toward classifying these as hardening bugs. I don't see the
> point in assigning Low CVEs to these kinds of issues nowadays. Under
> current vulnerability management standards, they would definitely be
> pushed down the priority list and likely skipped or deferred.

Ok, so lets apply as a general rule that all OOM bugs which require
privileged access in the guest are not assigned CVEs.

An unprivileged guest exploit would be more significant so still
potentially in scope.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


