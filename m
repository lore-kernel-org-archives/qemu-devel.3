Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2798AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4glw-0005PO-Io; Wed, 08 May 2024 08:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4glt-0005Oj-M5
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4glq-00021T-TH
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715172701;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3W/ScREmjvqUXIhjdT57Hp+BVufKIZBlTgrfJcfKQhM=;
 b=FKwsdUFoATQhTC9knudbf8x5MVAQQ20UN9IB3lq2Dlue9LidMfxyDxrTGHN7Qg1hAt1Zfb
 j0lYE0reZ2PFda63Legu5CmDNUnGVNQm4x/kPStSeXsQKhPJBYsVOom0rAzvR4Xab4w3cC
 KzPjj9oe8kgixBXoFD+Z3Jb0sEmGFIA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-Wjl6glZ-NdS_KtiO_r3oMQ-1; Wed,
 08 May 2024 08:51:38 -0400
X-MC-Unique: Wjl6glZ-NdS_KtiO_r3oMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2B3F1C4C39B;
 Wed,  8 May 2024 12:51:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5B18C0157C;
 Wed,  8 May 2024 12:51:35 +0000 (UTC)
Date: Wed, 8 May 2024 13:51:33 +0100
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
Message-ID: <Zjt1VdKQ3KIZChg9@redhat.com>
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
 <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
 <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
 <CAJ+F1CKvBW_khQ+zwKiunWGUQYtC_RKnVvUWbZpZALHv07efBw@mail.gmail.com>
 <5o3xyylget6hqhdaya5cj5tnbmmpzxk6u53cp6jhpviev6ez4m@ri6ady5zc6n3>
 <30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, May 08, 2024 at 02:37:52PM +0200, Paolo Bonzini wrote:
> On 5/8/24 11:38, Stefano Garzarella wrote:
> > On Wed, May 08, 2024 at 01:13:09PM GMT, Marc-André Lureau wrote:
> > > Hi
> > > 
> > > On Wed, May 8, 2024 at 11:50 AM Stefano Garzarella
> > > <sgarzare@redhat.com> wrote:
> > > > 
> > > > Hi Roman,
> > > > 
> > > > On Tue, May 07, 2024 at 11:20:50PM GMT, Roman Kiryanov wrote:
> > > > >Hi Stefano,
> > > > >
> > > > >On Tue, May 7, 2024 at 1:10 AM Stefano Garzarella
> > > > <sgarzare@redhat.com> wrote:
> > > > >> I have no experience with Windows, but what we need for
> > > > vhost-user is:
> > > > >>
> > > > >> - AF_UNIX and be able to send file descriptors using ancillary data
> > > > >>    (i.e. SCM_RIGHTS)
> > > > >
> > > > >As far as I understand, Windows does NOT support SCM_RIGHTS
> > > > over AF_UNIX.
> > > > 
> > > > Thank you for the information. This is unfortunate and does not allow
> > > > us to use vhost-user as it is on Windows.
> > > > 
> > > 
> > > fwiw, Windows has other mechanisms to share resources between processes.
> > > 
> > > To share/pass sockets, you can use WSADuplicateSocket. For shared
> > > memory and other resources, DuplicateHandle API.
> > 
> > Cool, thanks for sharing that. So it could be done, but I think we need
> > to extend the vhost-user protocol to work with Windows.
> 
> It would be possible to implement the memfd backend for Windows, using the
> CreateFileMapping() API.
> 
> However, the vhost-user protocol's VHOST_USER_SET_MEM_TABLE requests do not
> have any padding that can be used to pass the handle to the target. An
> extended version would be necessary.
> 
> One difference between Unix and Windows is that, if the vhost-server messes
> up the handling of messages from the socket, and therefore it does not close
> the handle, it is leaked forever.  This is not a huge deal per se, but I
> think it means that QEMU is not allowed to "open" a privileged vhost-user
> server process with PROCESS_DUP_HANDLE rights (translation: QEMU cannot
> provide duplicate handles to a privileged vhost-user server process).
> 
> Also I'm not sure what the cost of DuplicateHandle() is, and whether it's a
> good idea to do it for every region on every VHOST_USER_SET_MEM_TABLE
> request.  But VHOST_USER_SET_MEM_TABLE is not a fast path, so perhaps it's
> okay.
> 
> I think a virtio-vsock implementation in QEMU would be easier, lacking
> another usecase for vhost-user on Windows.
> 
> The main design question is whether multiple virtio-vsock devices for the
> same guest should share the CID space or not (I think it should, but I'm not
> 100% sure).  To connect host<->guest you could have a QOM object, here I am
> naming it vsock-forward as an example:

Designwise, a native VSOCK backend in QEMU really should implement the
same approach defined by firecracker, so that we have interoperability
with systemd, firecracker and cloud-hypervisor. See

  https://gitlab.com/qemu-project/qemu/-/issues/2095
  https://github.com/firecracker-microvm/firecracker/blob/main/docs/vsock.md#firecracker-virtio-vsock-design

This involves multiple UNIX sockets on the host

  1 * /some/path   - QEMU listens on this, and accepts connections
                     from other host processes. The client sends
                     "PORT <num>" to indicate that guest port it
                     is connecting to

  n * /some/path_$PORT - QEMU connect to this for outgoing connections
                         from the guest. Other host processes need
                         to listen on whatever path_$PORT need to be
                         serviced

IOW, from a CLI pov, QEMU should need nothing more than

    -object vsock-forward,prefix=/some/path


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


