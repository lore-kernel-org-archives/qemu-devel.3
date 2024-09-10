Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A63EDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4gM-0000hZ-UC; Tue, 10 Sep 2024 13:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4gK-0000Zj-UN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4gI-0003jR-OQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725989374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOkD/4cU/18FNmY2iZjqBMs7JVp6sT4Od40g9H6uGmk=;
 b=ErDy5pfMjWJDa8m1/A3sqhXFISCejU11Uj+VhkL28iPrYHZWeu5ewMEE8NPIj7cJKYp936
 PPBjn/Wf6jp4A0zIGCmO3tivYn9HNLi2ZHSNteIGbFqaf0ixxSlkiLVCm5qkk/xn6O841C
 YHPSNNcKv+wwJiLEjoVvOd8yP9+CN1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-7x-aPIZLO9KwpCeh51-LPQ-1; Tue, 10 Sep 2024 13:29:32 -0400
X-MC-Unique: 7x-aPIZLO9KwpCeh51-LPQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374cd315c68so3453496f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989371; x=1726594171;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AOkD/4cU/18FNmY2iZjqBMs7JVp6sT4Od40g9H6uGmk=;
 b=K/CeIBRMyne1vh9X53SJJ07QXjL01q4P69uULh+t4hrdqYIn0tV26uqnmKw/ZDPWPy
 lIEy4SYG8YitcpemBQpOHqie6Tx4sX/cfEruzA3DcCG084wnz+jGNqjLJgoQet2tcETD
 xOjt16J6GNCoM/Bv7Wb8EdS0SitNtBOZGYZKJpsDBrvYeelgrjtUVSC8w38DOyu7FqyL
 TOe0YpDJ/f3wUUbcSux+NvXvMxDl8ZF5D+A4jug2/OBHHO5k4lpjCLS96ZfWjawXk1KM
 MCkB0sZlsxa7BXhNwEi3ZHO3LJZiuJQ1/lFVIYw3qIrWaARnsKNfTUAEwexPdP7hES/G
 ORXg==
X-Gm-Message-State: AOJu0YxMJ9wL14Fty6XfbvDPpt2Kx5+kY6vveU2kUSBz4J8VM7OJfuQy
 jHpJqr/J3Nb8odXEDTw0lw2lrkcWcXX/4rcarsM1OSCP8QVNT9ZFBUki9HAy/CFkyNb2qXhSvfK
 L6ZFHKhNcBwbIAhbIjqxDKlFS1l9qxt1C49Kko4SYFFDb2RRUzlZU
X-Received: by 2002:a05:6000:cc:b0:374:c269:df79 with SMTP id
 ffacd0b85a97d-378949f7e28mr7062861f8f.22.1725989371382; 
 Tue, 10 Sep 2024 10:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSsQ0e4FYzLMdc3bIA0VxSDOWH/I0KKLS+2/Jbu1jtEFyfYwXY6sOOOPw1oVOFzWmkpk2bDA==
X-Received: by 2002:a05:6000:cc:b0:374:c269:df79 with SMTP id
 ffacd0b85a97d-378949f7e28mr7062842f8f.22.1725989370848; 
 Tue, 10 Sep 2024 10:29:30 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895665632sm9396722f8f.37.2024.09.10.10.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:29:30 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:29:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: luzhixing12345 <luzhixing12345@gmail.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com
Subject: Re: [PATCH] docs: fix vhost-user protocol doc
Message-ID: <20240910132855-mutt-send-email-mst@kernel.org>
References: <20240906042749-mutt-send-email-mst@kernel.org>
 <20240908144954.20003-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240908144954.20003-1-luzhixing12345@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Sep 08, 2024 at 10:49:54PM +0800, luzhixing12345 wrote:
> >On Fri, Sep 06, 2024 at 10:10:45AM +0800, luzhixing12345 wrote:
> >> Hi, can someone help review this patch?
> >> 
> >> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
> >
> >You got comments Aug 5, pls address them.
> 
> ok, the comments are addressed.

Pls post v2, list the comments addressed in the changelog,
coming after ---

Thanks!


> >On Sun, Aug 04, 2024 at 01:04:20PM GMT, luzhixing12345 wrote:
> >>add a ref link to Memory region description
> >>
> >>add extra type(64 bits) to Log description structure fields
> >>
> >>fix 's to 's
> >>
> >>---
> >> docs/interop/vhost-user.rst | 22 +++++++++++++---------
> >> 1 file changed, 13 insertions(+), 9 deletions(-)
> >
> >Please run `scripts/checkpatch.pl` before sending.
> >
> >S-o-b missing here.
> >
> >>
> >>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >>index d8419fd2f1..e34b305bd9 100644
> >>--- a/docs/interop/vhost-user.rst
> >>+++ b/docs/interop/vhost-user.rst
> >>@@ -167,6 +167,8 @@ A vring address description
> >> Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
> >> been negotiated. Otherwise it is a user address.
> >>
> >>+.. _memory_region_description:
> >>+
> >> Memory region description
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >>@@ -180,7 +182,7 @@ Memory region description
> >>
> >> :user address: a 64-bit user address
> >>
> >>-:mmap offset: 64-bit offset where region starts in the mapped memory
> >>+:mmap offset: a 64-bit offset where region starts in the mapped memory
> >>
> >> When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
> >> successfully negotiated, the memory region description contains two extra
> >>@@ -190,7 +192,7 @@ fields at the end.
> >> | guest address | size | user address | mmap offset | xen mmap flags | domid |
> >> +---------------+------+--------------+-------------+----------------+-------+
> >>
> >>-:xen mmap flags: 32-bit bit field
> >>+:xen mmap flags: a 32-bit bit field
> >>
> >> - Bit 0 is set for Xen foreign memory mapping.
> >> - Bit 1 is set for Xen grant memory mapping.
> >>@@ -211,6 +213,8 @@ Single memory region description
> >>
> >> :padding: 64-bit
> >>
> >>+:region: :ref:`Memory region description <memory_region_description>`
> >>+
> >> A region is represented by Memory region description.
> >
> >Should we merge this line with the one added?
> 
> Desciptions about memory regions are merged into one line.
> 
> >>
> >> Multiple Memory regions description
> >
> >Should we extend also the Multiple Memory region description?
> 
> Yes, this patch adds a ref link to it.
> 
> >>@@ -233,9 +237,9 @@ Log description
> >> | log size | log offset |
> >> +----------+------------+
> >>
> >>-:log size: size of area used for logging
> >>+:log size: a 64-bit size of area used for logging
> >>
> >>-:log offset: offset from start of supplied file descriptor where
> >>+:log offset: a 64-bit offset from start of supplied file descriptor where
> >>              logging starts (i.e. where guest address 0 would be
> >>              logged)
> >>
> >>@@ -382,7 +386,7 @@ the kernel implementation.
> >>
> >> The communication consists of the *front-end* sending message requests and
> >> the *back-end* sending message replies. Most of the requests don't require
> >>-replies. Here is a list of the ones that do:
> >>+replies, except for the following requests:
> >>
> >> * ``VHOST_USER_GET_FEATURES``
> >> * ``VHOST_USER_GET_PROTOCOL_FEATURES``
> >>@@ -1239,11 +1243,11 @@ Front-end message types
> >>   (*a vring descriptor index for split virtqueues* vs. *vring descriptor
> >>   indices for packed virtqueues*).
> >>
> >>-  When and as long as all of a device's vrings are stopped, it is
> >>+  When and as long as all of a device's vrings are stopped, it is
> >>   *suspended*, see :ref:`Suspended device state
> >>   <suspended_device_state>`.
> >>
> >>-  The request payload's *num* field is currently reserved and must be
> >>+  The request payload's *num* field is currently reserved and must be
> >>   set to 0.
> >>
> >> ``VHOST_USER_SET_VRING_KICK``
> >>@@ -1662,7 +1666,7 @@ Front-end message types
> >>   :reply payload: ``u64``
> >>
> >>   Front-end and back-end negotiate a channel over which to transfer the
> >>-  back-end's internal state during migration.  Either side (front-end or
> >>+  back-end's internal state during migration.  Either side (front-end or
> >>   back-end) may create the channel.  The nature of this channel is not
> >>   restricted or defined in this document, but whichever side creates it
> >>   must create a file descriptor that is provided to the respectively
> >>@@ -1714,7 +1718,7 @@ Front-end message types
> >>   :request payload: N/A
> >>   :reply payload: ``u64``
> >>
> >>-  After transferring the back-end's internal state during migration (see
> >>+  After transferring the back-end's internal state during migration (see
> >>   the :ref:`Migrating back-end state <migrating_backend_state>`
> >>   section), check whether the back-end was able to successfully fully
> >>   process the state.
> >>-- 
> >>2.34.1
> >>
> 
> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
> ---
>  docs/interop/vhost-user.rst | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index d8419fd2f1..2e50f2ddfa 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -167,6 +167,8 @@ A vring address description
>  Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
>  been negotiated. Otherwise it is a user address.
>  
> +.. _memory_region_description:
> +
>  Memory region description
>  ^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> @@ -180,7 +182,7 @@ Memory region description
>  
>  :user address: a 64-bit user address
>  
> -:mmap offset: 64-bit offset where region starts in the mapped memory
> +:mmap offset: a 64-bit offset where region starts in the mapped memory
>  
>  When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
>  successfully negotiated, the memory region description contains two extra
> @@ -190,7 +192,7 @@ fields at the end.
>  | guest address | size | user address | mmap offset | xen mmap flags | domid |
>  +---------------+------+--------------+-------------+----------------+-------+
>  
> -:xen mmap flags: 32-bit bit field
> +:xen mmap flags: a 32-bit bit field
>  
>  - Bit 0 is set for Xen foreign memory mapping.
>  - Bit 1 is set for Xen grant memory mapping.
> @@ -211,7 +213,7 @@ Single memory region description
>  
>  :padding: 64-bit
>  
> -A region is represented by Memory region description.
> +:region: region is represented by :ref:`Memory region description <memory_region_description>`.
>  
>  Multiple Memory regions description
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> @@ -224,7 +226,7 @@ Multiple Memory regions description
>  
>  :padding: 32-bit
>  
> -A region is represented by Memory region description.
> +:regions: regions field contains 8 regions of type :ref:`Memory region description <memory_region_description>`.
>  
>  Log description
>  ^^^^^^^^^^^^^^^
> @@ -233,9 +235,9 @@ Log description
>  | log size | log offset |
>  +----------+------------+
>  
> -:log size: size of area used for logging
> +:log size: a 64-bit size of area used for logging
>  
> -:log offset: offset from start of supplied file descriptor where
> +:log offset: a 64-bit offset from start of supplied file descriptor where
>               logging starts (i.e. where guest address 0 would be
>               logged)
>  
> @@ -382,7 +384,7 @@ the kernel implementation.
>  
>  The communication consists of the *front-end* sending message requests and
>  the *back-end* sending message replies. Most of the requests don't require
> -replies. Here is a list of the ones that do:
> +replies, except for the following requests:
>  
>  * ``VHOST_USER_GET_FEATURES``
>  * ``VHOST_USER_GET_PROTOCOL_FEATURES``
> @@ -1239,11 +1241,11 @@ Front-end message types
>    (*a vring descriptor index for split virtqueues* vs. *vring descriptor
>    indices for packed virtqueues*).
>  
> -  When and as long as all of a device’s vrings are stopped, it is
> +  When and as long as all of a device's vrings are stopped, it is
>    *suspended*, see :ref:`Suspended device state
>    <suspended_device_state>`.
>  
> -  The request payload’s *num* field is currently reserved and must be
> +  The request payload's *num* field is currently reserved and must be
>    set to 0.
>  
>  ``VHOST_USER_SET_VRING_KICK``
> @@ -1662,7 +1664,7 @@ Front-end message types
>    :reply payload: ``u64``
>  
>    Front-end and back-end negotiate a channel over which to transfer the
> -  back-end’s internal state during migration.  Either side (front-end or
> +  back-end's internal state during migration.  Either side (front-end or
>    back-end) may create the channel.  The nature of this channel is not
>    restricted or defined in this document, but whichever side creates it
>    must create a file descriptor that is provided to the respectively
> @@ -1714,7 +1716,7 @@ Front-end message types
>    :request payload: N/A
>    :reply payload: ``u64``
>  
> -  After transferring the back-end’s internal state during migration (see
> +  After transferring the back-end's internal state during migration (see
>    the :ref:`Migrating back-end state <migrating_backend_state>`
>    section), check whether the back-end was able to successfully fully
>    process the state.
> -- 
> 2.34.1


