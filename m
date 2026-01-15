Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5A0D44C41
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgNAn-00035h-3n; Thu, 15 Jan 2026 08:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vgNAf-00034v-4i
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:13:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vgNAb-00028L-4J
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768482827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ypCZRnE50lNHt5/NKnYE9Go/Coead89MOtPSfbYGoQ=;
 b=IdEX0qXO4fdN0mIGdDxZcJuXYD3HAspeZ0ymdGVTAUSXvZRvAPrKhvnCqW0mxY5f+ZQLin
 yBbJayu1bnkXYGkJxBOCpdi+yY7Sm9eMl+7973uHM2nuyqXNV1aDZN8UxlQ86OxaKeMwDF
 tMJFooMF5wlTjTHX9bWzyAwnG3HGZgM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-fb_AnmGvPtqTohNPnPAmRQ-1; Thu, 15 Jan 2026 08:13:44 -0500
X-MC-Unique: fb_AnmGvPtqTohNPnPAmRQ-1
X-Mimecast-MFC-AGG-ID: fb_AnmGvPtqTohNPnPAmRQ_1768482824
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee33324e8so5510705e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 05:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768482824; x=1769087624; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5ypCZRnE50lNHt5/NKnYE9Go/Coead89MOtPSfbYGoQ=;
 b=D4k3tQrXEqhSTR1pOMyowvr6+rPLWtKYFgEruDIYxWuI6wHEVh3z2fZjq/l/oHSMJK
 FgJyFoGFcHHVsBRU6XJ07IBPKLaZ/splRHvezx0a82Opld9T3HQb4C8rn3jjtEpHEdCX
 PfJ/NrK8EETV1EgDcXdms3hFvhDEtQz9Os89NedGii9BfqPM7iU5wy9ewdL/5Cb81OiB
 c1PCcRtg+9lffSxagphK9D5lagr1o2hgV3ZYxlDxQhznhaQPR1jkDI8zPLgo4vuJe4s4
 cmNsbB+BiZwGYK1Y+uZIyRz7SRqfE6iY1ZOfWDRp9fhQ8C+vgyZ4MX4xWBSTBELujYqO
 SZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768482824; x=1769087624;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ypCZRnE50lNHt5/NKnYE9Go/Coead89MOtPSfbYGoQ=;
 b=F+Bv8gc152KE0R3rz9P5CNiT4mJ+6yclNbO00yS6UkGkwLP3w02LALsA1DfY7LVGzs
 rBKuTDq7HBB4bl6rEF9pyxjpEMP1ohVewtwrEkg7S1xS4v60v4d/hv/H6EzdXkuHO8Ql
 4m4DzORWyc5LNM48m9uk62sbmcF4N1EEVwD4P/OQK88wxa7RyHWs9Fc3rVZUrCdxAdlw
 f3rjLxHmXxYbzDk29d07g9Zk8BrNh53in4Ix5XrohX0k4hgn9OVgPz6Q+uqUkcaktzyD
 IqRacQ/+GXNFmoeQqqu/y3qMerqljVeke2x6rqQe7TJyWBayS0AqmKfiJrzvp1S9X9zF
 xTbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkyZxwMbjPDlsdi5eSjtMvmEB6LcbxCMMavDE0KuIaNeQmeVQlltf8McO3NA9cMARxDSr2A2gAegNv@nongnu.org
X-Gm-Message-State: AOJu0YzTs0bxTR8+Dk2XgDzU/V8ghKbbpm0cLmvx+L13qabLu9jGv7bT
 gHSf2DI0Z4Px51ZOzx9N5Q2aH9vC6C93syjfBoCncWMtY9vAscgSqwEwgOwdCmNPSlLz6BzlybD
 TNT8V8HV2s6cmPtmiF2KPwD49h6J+LpJczrgGZfKFXfw89RLBgFs9PYb7
X-Gm-Gg: AY/fxX7Uf1hXGO2ASeqcrI/hByqn49jefGcsJL+53HvXKIwKF3RCTv31jNI1hCMGo23
 FNxw55bT1ME/0pRYRrVl7Gh4CQ7UjMT9EMU3Wo/5MYXZpR5CHN70NG8dvvoEG954Xrd4N8+DV9B
 xWrCB1CWcZOAyrh20I3WHiPepwKzHSI3Ut2gWDRZ2knw6WLIAUg6BJrI2260oaBBgPFPYmJXYt6
 ddThm6N+kdRTA5WsEtdXhtS0SGibxVMloX1KdcfcWUlUZ31T0EnY2RstivpMbaKSSHh85I5QQww
 gCNsSl574iCc7vzel0aAsv+hGihVOhQfQU+QxBtk+12JkB6qfSrc1sPsPYG9ofh0GhFj+rgIscC
 MfFED7fUd+HIe+eAb6etdnhvBljT0Lw==
X-Received: by 2002:a05:600c:3f16:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-47ee32fd19emr72479765e9.10.1768482823616; 
 Thu, 15 Jan 2026 05:13:43 -0800 (PST)
X-Received: by 2002:a05:600c:3f16:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-47ee32fd19emr72479355e9.10.1768482823060; 
 Thu, 15 Jan 2026 05:13:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428f1ba7sm49750805e9.15.2026.01.15.05.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 05:13:42 -0800 (PST)
Date: Thu, 15 Jan 2026 08:13:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 dbassey@redhat.com, manos.pitsidianakis@linaro.org, slp@redhat.com,
 stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com,
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v11 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
Message-ID: <20260115081220-mutt-send-email-mst@kernel.org>
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-4-aesteve@redhat.com>
 <87cy3brs8r.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cy3brs8r.fsf@alyssa.is>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Jan 15, 2026 at 01:10:44PM +0100, Alyssa Ross wrote:
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
> > @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with the following struct:
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
> >    when the operation is successful, or non-zero otherwise. Note that if the
> >    operation fails, no fd is sent to the backend.
> >  
> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > +  :id: 9
> > +  :equivalent ioctl: N/A
> > +  :request payload: fd and ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backends to
> > +  advertise a new mapping to be made in a given VIRTIO Shared Memory Region.
> > +  Upon receiving the message, the front-end will mmap the given fd into the
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
> (crosvm is like this — its backends don't negotiate
> VHOST_USER_PROTOCOL_F_REPLY_ACK, and their non-standard map/unmap
> requests had mandatory replies.)

the use-case would be multiple MAP request and a single ack at the end
to confirm them all.

behaviour of sending ack without VHOST_USER_PROTOCOL_F_REPLY_ACK is
legacy. let's just stick to the simple rule - if you want
an ack set VHOST_USER_PROTOCOL_F_REPLY_ACK.

> > +  Mapping over an already existing map is not allowed and requests shall fail.
> > +  Therefore, the memory range in the request must correspond with a valid,
> > +  free region of the VIRTIO Shared Memory Region. Also, note that mappings
> > +  consume resources and that the request can fail when there are no resources
> > +  available. Lastly, mappings are automatically unmapped by the front-end
> > +  across device reset operation.
> > +
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backends so
> > +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that the
> > +  given range shall correspond to the entirety of a valid mapped region.
> > +  A reply is generated indicating whether unmapping succeeded.
> > +
> >  .. _reply_ack:
> >  
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > -- 
> > 2.49.0



