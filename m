Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306D3D41178
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMkz-0008Ct-8d; Thu, 15 Jan 2026 07:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vgMkl-00084i-U1
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vgMkj-0003Sm-SO
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768481224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqgnHMXGXghM2JvdM51gNPhwcKFK9Ojk5hTUXkj5TrI=;
 b=W0yAodmIEaDjFzgex2oQIlP0/CWO8aXg2mSGrHafaGgsrfSpegyJAo3UN2ncU5uLtP2Wwl
 76MJCQUEU8lONSy4V+6dIUSHpZPReOA506WHPpGqeo4xFntqPOmVaMCrBQ+aMlRs3RfZ0V
 oFjEs1D6J7ms7/mfxv0g+7iEun+VaKY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-kqVT8_yDNLmOWhM-OhgcUA-1; Thu, 15 Jan 2026 07:45:56 -0500
X-MC-Unique: kqVT8_yDNLmOWhM-OhgcUA-1
X-Mimecast-MFC-AGG-ID: kqVT8_yDNLmOWhM-OhgcUA_1768481156
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7903fc98229so7958307b3.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 04:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768481156; x=1769085956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqgnHMXGXghM2JvdM51gNPhwcKFK9Ojk5hTUXkj5TrI=;
 b=E/u/4HktbaxgCgFQowhLDYxWtx9sreXBZomPgp7aqMI5nPQRGL302trQudBfVuxPh5
 f6jdCTYvX+bQCEBIkklFZt6JIZXoD9g4j3C0XWqYPaL32olpW2oAeRLgBQUiXMD+2zDg
 iMZc9mVHEZnZY987vWvG7aRpdxDRjyrJ4c/epp5OJ7+6CLH0f8PFyjeOThV2LI62jBIY
 qEXqysWTk3ZfrILrmBin7+KY00yxloKQzgdVvroT9bwDJJiEtvRUtxn7b/H+qEJdgDOU
 zPSb+4A27814ecBcnC2lgN/qVo+PgIDVkgYbZlGaFYeGl21lU856t10cMZeljzqu7uZM
 zMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768481156; x=1769085956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yqgnHMXGXghM2JvdM51gNPhwcKFK9Ojk5hTUXkj5TrI=;
 b=UJrpHaEpUI/pR5r0CdX4iKkPel7dCfxL6LmmApu8I/o2LIsO7djycDHe01S8IGoNTM
 oJ2NN39FVjSH82nNqqSeotwNOGKJGZt1BTYypmtuoS4tWIW2xYg0VsMrWDRt9fpnj9js
 QIlEwlS160jFbiBX6exWN8HLWx7TxEqnjw3Qa7uWO9tFgGF7Gd2NEjhSvh01+J+1IBDz
 o/4sXlHjFTSfm+IH6/ErNXYWb/Rp3vSZkByJqG45H6cuhlcObZMEtPupxc4W9y9odqA6
 l+yKJLmuMNb6DPI+0XtRZLiPGToR2OTcJ92Rohgoaia+2RMhOCP0TvxCckwwcGmUSjdA
 xZSA==
X-Gm-Message-State: AOJu0YzX3sXPmyaBP+c7JvpQaAoSUCzRI32VxnJON4NtrzW5a1dwhJsY
 DnRiSPW4jFL1tqE+X/bUV8VfRxOIJt8GoZP6PY+AU4kvKhaUlEnfwfAFafdTaoSpGf2i5XOb/Uz
 HCccdsXboqo3eGmi/Tu5qaKeqPs2nRwuroWVgg4MxDJkfdn6U36y6oDGcDNRvmioQwZow2yNQ4K
 gyU3+RawgCRh/pcyTyg6T7N1SFDB+S1qE=
X-Gm-Gg: AY/fxX65wbWenEpnwBkD2f6OMpHOLLwLL2wptTVgp6wQfrUT4hE2X31Qp6rvLQC5lk1
 QdVadcoislSYA0k+0EvPv/IRJSSHmdhkI3mqDmGm4UMp6MzxYtIh9bWmiOs+6AQtzo8nFd0hKhV
 I81ptCSdG6FyBgBHJojHr+FaUV1rvcHsMCUkd0nejXDRqrzGh2PPQkfcIxzJb1hg==
X-Received: by 2002:a53:c486:0:b0:640:fabf:565d with SMTP id
 956f58d0204a3-64903b11b8bmr3139128d50.43.1768481156095; 
 Thu, 15 Jan 2026 04:45:56 -0800 (PST)
X-Received: by 2002:a53:c486:0:b0:640:fabf:565d with SMTP id
 956f58d0204a3-64903b11b8bmr3139114d50.43.1768481155749; Thu, 15 Jan 2026
 04:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-4-aesteve@redhat.com>
 <87cy3brs8r.fsf@alyssa.is>
In-Reply-To: <87cy3brs8r.fsf@alyssa.is>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 15 Jan 2026 13:45:44 +0100
X-Gm-Features: AZwV_Qhu516z3-nSOxDvxQBVvhUxZAbZdfm04Xl08TlYtI3hlUtGfkQJq0Xw5-U
Message-ID: <CADSE00+GE-uhyOx0fJ80KatDfXSdyQ4Etnh-WGO=GKzRwJq7vw@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, manos.pitsidianakis@linaro.org,
 slp@redhat.com, 
 stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, stevensd@chromium.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 15, 2026 at 1:10=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> Albert Esteve <aesteve@redhat.com> writes:
>
> > Add SHMEM_MAP/_UNMAP request to the vhost-user
> > spec documentation.
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 59 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 17a68a62eb..6c1d66d7d3 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -350,6 +350,27 @@ Device state transfer parameters
> >    In the future, additional phases might be added e.g. to allow
> >    iterative migration while the device is running.
> >
> > +MMAP request
> > +^^^^^^^^^^^^
> > +
> > ++-------+---------+-----------+------------+-----+-------+
> > +| shmid | padding | fd_offset | shm_offset | len | flags |
> > ++-------+---------+-----------+------------+-----+-------+
> > +
> > +:shmid: a 8-bit shared memory region identifier
> > +
> > +:fd_offset: a 64-bit offset of this area from the start
> > +            of the supplied file descriptor
> > +
> > +:shm_offset: a 64-bit offset from the start of the
> > +             pointed shared memory region
> > +
> > +:len: a 64-bit size of the memory to map
> > +
> > +:flags: a 64-bit value:
> > +  - 0: Pages are mapped read-only
> > +  - 1: Pages are mapped read-write
> > +
> >  C structure
> >  -----------
> >
> > @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with =
the following struct:
> >            VhostUserInflight inflight;
> >            VhostUserShared object;
> >            VhostUserTransferDeviceState transfer_state;
> > +          VhostUserMMap mmap;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1064,6 +1086,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
> >    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> > +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> >
> >  Front-end message types
> >  -----------------------
> > @@ -1872,6 +1895,42 @@ is sent by the front-end.
> >    when the operation is successful, or non-zero otherwise. Note that i=
f the
> >    operation fails, no fd is sent to the backend.
> >
> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > +  :id: 9
> > +  :equivalent ioctl: N/A
> > +  :request payload: fd and ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds to
> > +  advertise a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> > +  Upon receiving the message, the front-end will mmap the given fd int=
o the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``.
> > +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> > +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> > +  must respond with zero when operation is successfully completed,
> > +  or non-zero otherwise.
>
> Having now tried to implement this, I'm wondering whether replies should
> be mandatory, even without VHOST_USER_PROTOCOL_F_REPLY_ACK, like they
> are for some other messages.  Without waiting for a reply, a backend
> doesn't know when it can tell the driver to start using the mapped
> memory, so I'm not sure there's ever a case in which a backend would not
> want to wait for a reply after sending VHOST_USER_BACKEND_SHMEM_MAP,
> even if it doesn't wait habitually wait for replies for other messages.
> (crosvm is like this =E2=80=94 its backends don't negotiate
> VHOST_USER_PROTOCOL_F_REPLY_ACK, and their non-standard map/unmap
> requests had mandatory replies.)

What you say makes sense to me. Every test I run for this, I used the
flag, because it was required to work correctly. Nonetheless, I
assumed giving flexibility may be better in case there are backends
that will not be accessing the mapped memory right away and prefer to
save the response. Also, previous implementation in QEMU always
checked VHOST_USER_PROTOCOL_F_REPLY_ACK before sending a response.
Which made me think this was the norm.

I could relax that requirement in a v12, given this patch is still
pending to merge (and update the implementation accordingly).

>
> > +  Mapping over an already existing map is not allowed and requests sha=
ll fail.
> > +  Therefore, the memory range in the request must correspond with a va=
lid,
> > +  free region of the VIRTIO Shared Memory Region. Also, note that mapp=
ings
> > +  consume resources and that the request can fail when there are no re=
sources
> > +  available. Lastly, mappings are automatically unmapped by the front-=
end
> > +  across device reset operation.
> > +
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds so
> > +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) =
in the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that =
the
> > +  given range shall correspond to the entirety of a valid mapped regio=
n.
> > +  A reply is generated indicating whether unmapping succeeded.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > --
> > 2.49.0


