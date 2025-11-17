Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC82CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL0oX-0008Fu-5n; Mon, 17 Nov 2025 10:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vL0oH-0008Aj-9L
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vL0oE-0007zO-UQ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763391984;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcHHiAIlek2OQ7wCAHq6FwESlWvQEuYq9D//bdLJmZ0=;
 b=HgyTy1elK5vY9tod38byfc+LaJ9hZ8F0OhRs/vpBNXzUrYD7pybXaT4YOtC6LnoYhI6fIo
 vHaf1lX54+AtXjfI3DcsbdxYQ6KEeaVGDig2ePsZ4WQigzdHAeRECpCOySXqynku0Kg09V
 r/WgP9u7Ezy49dtZUQlEQrSZ+4KnxXM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-vkOkfeglPBOWPKuzGfrsCQ-1; Mon,
 17 Nov 2025 10:06:21 -0500
X-MC-Unique: vkOkfeglPBOWPKuzGfrsCQ-1
X-Mimecast-MFC-AGG-ID: vkOkfeglPBOWPKuzGfrsCQ_1763391980
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 587F21955D59; Mon, 17 Nov 2025 15:06:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67416180049F; Mon, 17 Nov 2025 15:06:16 +0000 (UTC)
Date: Mon, 17 Nov 2025 15:06:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: ebpf functions can fail without setting an error
Message-ID: <aRs55PV-R4m8KDCu@redhat.com>
References: <87ectns27j.fsf@pond.sub.org> <aKRWZwvbWzA0QbA_@redhat.com>
 <87sehfsife.fsf@pond.sub.org> <871plwpxpu.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871plwpxpu.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 17, 2025 at 02:58:37PM +0100, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> >
> >> On Thu, Aug 07, 2025 at 03:14:56PM +0200, Markus Armbruster wrote:
> >>> Three functions in ebpf_rss.h take an Error ** argument and return bool.
> >>> Good.
> >>> 
> >>> They can all fail without setting an error.  Not good.
> >>> 
> >>> The failures without error are:
> >>> 
> >>> * All three stubs in ebpf_rss-stub.c always.  Oversight?
> >>
> >> Opps, yes, we really should have added error_setg() calls for diagnosis
> >> if someone tries to use eBPF when QEMU build has it disabled.
> 
> Easy enough, but...
> 
> > Some stubs exist only to mollify the linker.  They are not meant to be
> > called.  They should abort(), optionally with lipstick.
> >
> > Other stubs are called and should fail nicely.
> >
> > Can you tell me offhand which kind these are?
> 
> If calling these stubs is possible, I'd like to know how I can get them
> called, so I can test the errors I add.
> 
> If calling is not possible, I'd rather add abort()s.
> 
> I tried to figure out whether calling is possible, but it ended in
> confusion.  Can you help?

* ebpf_rss_set_all

  Is called from virtio_net_attach_ebpf_rss
  The call is unreachable if ebpf_rss_is_loaded returns  false
  Stub for ebpf_rss_is_loaded always returns false

    => ebpf_rss_set_all stub is unreachable


* ebpf_rss_load_fds, ebpf_rss_load

  Is called from virtio_net_load_ebpf_fds, which is called from
  virtio_net_load_ebpf

  The call  to virtio_net_load_ebpf_fds is unreachable if
  virtio_net_attach_ebpf_to_backend fails

  virtio_net_attach_ebpf_to_backend fails if set_steering_ebpf
  fails

  set_steering_ebpf fails if ioctl(fd, TUNSETSTEERINGEBPF...)
  fails on Linux; all non-Linux impls of ebpf_rss_load_fds
  return -1

  It is theoretically p9ossible to build QEMU without EBPF
  while both glibc & the kernel support TUNSETSTEERINGEBPF ioctl

   => ebpf_rss_load_fds, ebpf_rss_load are reachable in stubs


> >>> * Non-stub ebpf_rss_load() when ebpf_rss_is_loaded().  Are these
> >>>   reachable?
> >>
> >> This scenario should never happen, and we should add a call like
> >>
> >>   error_setg(errp, "eBPF program is already loaded");
> >>
> >> to report it correctly.
> >
> > Is it a programming error when it happens?
> 
> This question is still open as well.

I'd consider it a programming error. I don't think we have a code
path that could trigger it currently.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


