Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17488C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 12:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkN4J-0000M1-OZ; Tue, 18 Feb 2025 07:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkN4H-0000La-UZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkN4D-0002Ke-TJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739883071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E966tUCzb93DdcPEPakY8jUq0GfbJmwSIRkuaR+TsOg=;
 b=B2Vagl2ps7DsCe717KusAXvyadwqjNaOSipZ1/7m3hJREsnGXfort1B9YoHLXvev+Ei/1G
 QR2DOZgNPmXucalQqNro6OCZRa5rGtbycyFTwC8OHlhlHn5/SwrKIt/yFk+SbsjOwt7Hzw
 mgkI02l3KcPA40NQeGC93uBsH+g9XCQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-SBxpG5Z4MkKHcKqnOpFNTQ-1; Tue, 18 Feb 2025 07:51:09 -0500
X-MC-Unique: SBxpG5Z4MkKHcKqnOpFNTQ-1
X-Mimecast-MFC-AGG-ID: SBxpG5Z4MkKHcKqnOpFNTQ_1739883068
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fbff6426f5so11057388a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 04:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739883068; x=1740487868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E966tUCzb93DdcPEPakY8jUq0GfbJmwSIRkuaR+TsOg=;
 b=MS7dCfwxmh586GgZa0BjePB2ZKcgnhmde+09gbIRhUM5pCQMyAXqgv64ZDT9Cuj/ip
 eTgrMZ7F/SRb9yOQBpLKsx5TCjtqUdECWLGbRrGu1I3l99XLARfyzQUPBLUUbkpgvZiD
 w8ubSFAM8kDv3LMGZQJWbVl2NIOWAieUjh+hzcVOckbo8YyFpbT9jvVh411UY+Mnh12z
 yC7gWb8w2XNQIs0RU+a3iEKUL/kh5ZdHIN4LmUWLo+zZwgHs4HZ8CdezaFUD8Qt/nWFZ
 5U52bAUBU/U1B2UJRig5aa7H06Bk8l958K3yjrgDZu3WzqfqvGMi9CvFAQMH2PjbtgAf
 nvGQ==
X-Gm-Message-State: AOJu0Yzzpw148Jx467TysMutElq+rHYoswq1o1TsMRbhNdZXT0qczKGL
 an4uiM8gxkPpJ7ZinyNOz4Yk7Cw5k1ruKvLjUIFMnzadN8qcQfYtWZfQXFSlKpojrtZ+hKQxY0u
 09ke5xmyhf/T6MWUyuM9aDupGEPv4QAIAKR6UcX/fBjSDKsEn3tAbg0UzoDqJGfOLLZwOQ4qzFV
 ihiqWlFYNqpghdgr3JqGQSKs4n1kI=
X-Gm-Gg: ASbGncsLgW/X0zIRDZzeSOIZzSybv1hnhFgg0sIWQm/rKHEjtoLkdpF6+lPZ8IlRj6g
 v0tLS3G2DBEOiE3BWYmgfNQAGyviyQJppWayA73dI65UnzwYnLQnVlHgguPXMRKwF
X-Received: by 2002:a17:90b:1e05:b0:2fa:1e3e:9be5 with SMTP id
 98e67ed59e1d1-2fc407915edmr25809399a91.0.1739883068194; 
 Tue, 18 Feb 2025 04:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6BP9I/JWOp93ZM6EXZbLVx7xFRe2L2x8tle/ypQn7aft8yzmFk0FuI8pEgkaQGk9UL7KNnkw5FMXnrCC5QGY=
X-Received: by 2002:a17:90b:1e05:b0:2fa:1e3e:9be5 with SMTP id
 98e67ed59e1d1-2fc407915edmr25809354a91.0.1739883067745; Tue, 18 Feb 2025
 04:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-10-aesteve@redhat.com>
 <20250218110017.GM10767@fedora>
In-Reply-To: <20250218110017.GM10767@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 18 Feb 2025 13:50:55 +0100
X-Gm-Features: AWEUYZkEKLLYUy2ki-twyEHWP-5_CNrrveISawGEPY7FgRdt24tvnqwQ_2C_cC4
Message-ID: <CADSE00JGA2cbBwLRbMMujv3m36Jop6u=tcSDHXm_PJoehM=BEQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] vhost_user.rst: Add MEM_READ/WRITE messages
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 18, 2025 at 12:00=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Feb 17, 2025 at 05:40:12PM +0100, Albert Esteve wrote:
> > Add MEM_READ/WRITE request to the vhost-user
> > spec documentation.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 96156f1900..9f7a2c4cf7 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -391,6 +391,7 @@ In QEMU the vhost-user message is implemented with =
the following struct:
> >            VhostUserTransferDeviceState transfer_state;
> >            VhostUserMMap mmap;
> >            VhostUserShMemConfig shmem;
> > +          VhostUserMemRWMsg mem_rw;
>
> Is this struct defined anywhere in the spec?

Ah, no, right. I did not see all the other structs defined, so I
assumed some were just to be found in the code. But then it wouldn't
serve as a specification... I realized I was not looking at the right
section.

VhostUserMMap is also missing, then. I will add them in the next
iteration in their respective commits.

>
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1938,6 +1939,38 @@ is sent by the front-end.
> >    given range shall correspond to the entirety of a valid mapped regio=
n.
> >    A reply is generated indicating whether unmapping succeeded.
> >
> > +``VHOST_USER_BACKEND_MEM_READ``
> > +  :id: 11
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMemRWMsg``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds to
> > +  read a memory region that has failed to resolve a translation due to=
 an
> > +  incomplete memory table, after another device called
> > +  ``VHOST_USER_BACKEND_SHMEM_MAP`` for the same region on a shared
> > +  descriptor file.
> > +
> > +  This mechanism works as a fallback for resolving those memory
> > +  accesses and ensure that DMA works with Shared Memory Regions.
> > +
> > +``VHOST_USER_BACKEND_MEM_WRITE``
> > +  :id: 12
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMemRWMsg``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds to
> > +  write a memory region that has failed due to resolve a translation a=
n
> > +  incomplete memory table  after another device called
> > +  ``VHOST_USER_BACKEND_SHMEM_MAP`` for the same region on a shared
> > +  descriptor file.
> > +
> > +  This mechanism works as a fallback for resolving those memory
> > +  accesses and ensure that DMA works with Shared Memory Regions.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > --
> > 2.48.1
> >


