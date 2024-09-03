Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABCFCD37AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slaCK-00050R-QW; Tue, 03 Sep 2024 16:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1slaCH-0004at-9l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1slaCC-0006K8-RQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725395530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfYRLqZOo/10v/hDkZlT07PBggLSyskmul9443lWRjk=;
 b=UVPh94Reiom9QcuieOiy4pgFq42upR5jnIITL0yVYuUlEFl+G1lbOiKVv247HYJF+kcDP9
 JcqM8SKsP0qWy/USOwRVIg1TRFw6e8DibZyd1xecG8/7TWKEHPzLxTOpk8OJ+f8mQ5ahCJ
 NHA8oN5Ze74rq8UiINU80mYBYvKq62s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-NjLI1eT7N_aqCjNsRfYW2Q-1; Tue, 03 Sep 2024 16:32:07 -0400
X-MC-Unique: NjLI1eT7N_aqCjNsRfYW2Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c25d413306so2280218a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725395526; x=1726000326;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MfYRLqZOo/10v/hDkZlT07PBggLSyskmul9443lWRjk=;
 b=DHfJXqZnbooGT+tI8d/wwGg5/XmLnrq5E74PPXWQY0ZSP/K+dm2MjFjJ1YzcBNYobH
 65pQYu1J+pXD2KO3K6kpdOYY3R3lof/FiECq+6uBWJnC8IXkHawf50rdziR+8/oMgUFY
 o0XFC3Gfbnz+0WRnExi/pJYwzajrOZkOLeZEhM1gd/h5uYXJg4ggYNaFF88ad5xeNgUP
 8oJjoo5VeZZW38BZKrtJxDIU0HZoqIX8bsHgbMnA3I7pMegwK/aFB9ViSzbKgw4NfxKY
 6yC43GNz7GINn5erxT9TEL0XnKloSp/5Wf6dbK66xIOOv5H9oaAa9J6LjNI86mQzyTUF
 AtOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcDLqF/JrwnNd9wZybmTidjvc3U54LQ4WPjhfxC7ZCjNcvoPeqnRWqnVew5APPXf7vACd15lJinAhu@nongnu.org
X-Gm-Message-State: AOJu0YxtXYnGU1Bl7qMXA6k0n8XMBsa/1Ql+XqS28be3fccdDDg4Njnk
 zt0+80oJAH+8eB7xze5tczd92IdaHp55VOCcGtEP8m6tIEjS4izD6/LqRJHOtlOoJR5uRMsZa+n
 oT++3wySQKGbkL/LdjHGp0yFz82tT3sgv2ZrS78Xc0Ca/gq7qtMXK
X-Received: by 2002:a17:907:3f9c:b0:a86:8b2f:49b3 with SMTP id
 a640c23a62f3a-a89d8848df0mr740255366b.46.1725395526042; 
 Tue, 03 Sep 2024 13:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPq5Nv58VEuChptsfZpJakRgLROqfdTwFRNPSi0AmCQsMSq5tCP+Aw/rGlwGKEHysicFyFrg==
X-Received: by 2002:a17:907:3f9c:b0:a86:8b2f:49b3 with SMTP id
 a640c23a62f3a-a89d8848df0mr740251566b.46.1725395525148; 
 Tue, 03 Sep 2024 13:32:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989230a9dsm713729566b.224.2024.09.03.13.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 13:32:04 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:32:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: graf@amazon.com, qemu-devel@nongnu.org, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, berrange@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v5 5/8] device/virtio-nsm: Support for Nitro Secure
 Module device
Message-ID: <20240903162013-mutt-send-email-mst@kernel.org>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
 <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
 <20240828151005-mutt-send-email-mst@kernel.org>
 <CAFfO_h66g138yVwufKY_C22Aiu8XctzyyjqsBYM4wdYN77JLuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h66g138yVwufKY_C22Aiu8XctzyyjqsBYM4wdYN77JLuQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 04, 2024 at 01:58:15AM +0600, Dorjoy Chowdhury wrote:
> On Thu, Aug 29, 2024 at 1:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote:
> > > On Thu, Aug 29, 2024 at 12:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury wrote:
> > > > > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]
> > > > > for stripped down TPM functionality like cryptographic attestation.
> > > > > The requests to and responses from NSM device are CBOR[3] encoded.
> > > > >
> > > > > This commit adds support for NSM device in QEMU. Although related to
> > > > > AWS Nitro Enclaves, the virito-nsm device is independent and can be
> > > > > used in other machine types as well. The libcbor[4] library has been
> > > > > used for the CBOR encoding and decoding functionalities.
> > > > >
> > > > > [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> > > > > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > > > > [3] http://cbor.io/
> > > > > [4] https://libcbor.readthedocs.io/en/latest/
> > > > >
> > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > ---
> > > > >  MAINTAINERS                      |   10 +
> > > > >  hw/virtio/Kconfig                |    5 +
> > > > >  hw/virtio/cbor-helpers.c         |  326 ++++++
> > > > >  hw/virtio/meson.build            |    6 +
> > > > >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> > > > >  hw/virtio/virtio-nsm.c           | 1638 ++++++++++++++++++++++++++++++
> > > > >  include/hw/virtio/cbor-helpers.h |   46 +
> > > > >  include/hw/virtio/virtio-nsm.h   |   59 ++
> > > > >  meson.build                      |    2 +
> > > > >  9 files changed, 2165 insertions(+)
> > >
> > > [...]
> > >
> > > > > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> > > > > +{
> > > > > +    g_autofree VirtQueueElement *out_elem = NULL;
> > > > > +    g_autofree VirtQueueElement *in_elem = NULL;
> > > > > +    VirtIONSM *vnsm = VIRTIO_NSM(vdev);
> > > > > +    Error *err = NULL;
> > > > > +
> > > > > +    out_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > > > +    if (!out_elem) {
> > > > > +        /* nothing in virtqueue */
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    if (out_elem->out_num != 1) {
> > > > > +        virtio_error(vdev, "Expected one request buffer first in virtqueue");
> > > > > +        goto cleanup;
> > > > > +    }
> > > >
> > > > Seems to assume request in a single s/g element?
> > > > We generally avoid this kind of thing.
> > > >
> > > > Applies equally elsewheree.
> > > >
> > >
> > > Thank you for reviewing. I think I did it this way (first virqueue_pop
> > > gives out_elem with out_num == 1 and the next virtqueue_pop gives
> > > in_elem with in_num == 1) after seeing what the virqueue contains
> > > (using printfs) when running in a VM and sending some NSM requests and
> > > I noticed the above. Can you give me a bit more details about what
> > > this should be like? Is there any existing virtio device code I can
> > > look at for example?
> > > Thanks!
> >
> >
> > Use iov_to_buf / iov_from_buf
> >
> > there are many examples in the tree, I'd look for some recent ones.
> >
> 
> I am a bit stuck at this and I would appreciate some help. I looked at
> other "iov_to_buf" and "iov_from_buf" examples in QEMU and in those I
> see there are known request and response "structs" associated with it.
> But in the case of NSM, the request and responses can be arbitrary
> CBOR objects i.e., no specific structs or lengths associated.


take whatever you want to access, move it to a buffer with iov_to_buf
then access the buffer.

reverse is even easier. put in a buffer, copy with iov_from_buf.

> So I am
> not sure using "iov_to_buf" / "iov_from_buf" makes sense here.
> And about the request response being in a single s/g element, I think
> it's because of how the NSM driver is in drivers/misc/nsm.c (see
> nsm_sendrecv_msg_locked function)in the linux kernel tree.

yes but driver is free to change this.
Isn't there a spec for this device to consult?
Sending that to virtio tc will be needed before we add this to qemu.

> I am not sure what changes are needed in the current code if any. Do
> you have any suggestions on this?
> 
> Regards,
> Dorjoy


