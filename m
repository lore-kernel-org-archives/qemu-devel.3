Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC72CC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hPl-00060i-0C; Wed, 08 May 2024 09:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4hPk-0005wt-5y
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4hPi-0007xJ-5D
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715175172;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPFctnLNIPL7JA1tsvkRpxlNaUXaOD07ZEYHnhJUPso=;
 b=Ozq3cu6Gr8EVy1T5EIsUdC3eyE96EoaogTuK6xhqVtdh+8jd/WkD+A/izUDPbKwNebrucR
 T/Uvhlm353o8LJiJ+DZ4nwmwjH4DPs00UTzeQafKCJ6ECtbv4heOnpMItRXU5vD6g37Liy
 YjIAOc0vO2+IApiq4Ecnwv2vcrwG2KI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-FOYpgx_WMlu38QrkOalRJQ-1; Wed, 08 May 2024 09:32:49 -0400
X-MC-Unique: FOYpgx_WMlu38QrkOalRJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2B21802BF6;
 Wed,  8 May 2024 13:32:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 773F93C30;
 Wed,  8 May 2024 13:32:47 +0000 (UTC)
Date: Wed, 8 May 2024 14:32:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Roman Kiryanov <rkir@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>,
 Mehdi Alizadeh <mett@google.com>
Subject: Re: Hermetic virtio-vsock in QEMU
Message-ID: <Zjt-_VI79QwR2UEF@redhat.com>
References: <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
 <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
 <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
 <CAJ+F1CKvBW_khQ+zwKiunWGUQYtC_RKnVvUWbZpZALHv07efBw@mail.gmail.com>
 <5o3xyylget6hqhdaya5cj5tnbmmpzxk6u53cp6jhpviev6ez4m@ri6ady5zc6n3>
 <30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com>
 <Zjt1VdKQ3KIZChg9@redhat.com>
 <CABgObfb8o3L_FawdwFX7Ow-+LN7wyGbvSLWubJrpyTgH3uo-uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb8o3L_FawdwFX7Ow-+LN7wyGbvSLWubJrpyTgH3uo-uQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 08, 2024 at 03:00:30PM +0200, Paolo Bonzini wrote:
> On Wed, May 8, 2024 at 2:51 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > Designwise, a native VSOCK backend in QEMU really should implement the
> > same approach defined by firecracker, so that we have interoperability
> > with systemd, firecracker and cloud-hypervisor. See
> >
> >   https://gitlab.com/qemu-project/qemu/-/issues/2095
> >   https://github.com/firecracker-microvm/firecracker/blob/main/docs/vsock.md#firecracker-virtio-vsock-design
> >
> > This involves multiple UNIX sockets on the host
> >
> >   1 * /some/path   - QEMU listens on this, and accepts connections
> >                      from other host processes. The client sends
> >                      "PORT <num>" to indicate that guest port it
> >                      is connecting to
> >
> >   n * /some/path_$PORT - QEMU connect to this for outgoing connections
> >                          from the guest. Other host processes need
> >                          to listen on whatever path_$PORT need to be
> >                          serviced
> 
> The former is quite horrible, but okay. Out of curiosity, which
> clients are using that convention?

I've no idea. The RFE above came out of a discussion with systemd
upstream when they were implementing their SSH-over-vsock host SSH
plugin

https://github.com/systemd/systemd/pull/30777

where it was noted that their code for using AF_VSOCK natively
wouldn't work with firecracker or cloud-hypervisor. Although
they've got native AF_VSOCK support there merged, conceptually
it looks desirable to have a common way of exposing AF_VSOCK
on the host.

Also, aside from cross-OS portability, this has the other benefit
that arbitarary users on the same host can make use of AF_VSOCK,
without worrying about CID clashes in the host kernel between
guests they're not aware of. All guests can just use the same
fixed CID and the UNIX socket exposure on the host namespaces
them.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


