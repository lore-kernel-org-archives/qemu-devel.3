Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21897CD4F25
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slwbi-0006fw-6g; Wed, 04 Sep 2024 16:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1slwbf-0006f4-QX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1slwbd-0001MN-Kn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725481674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSa/PqJEOTruJ16ujatzuDY1L8Ey34ZJ4sEqg9KBxT0=;
 b=TuAbg92xcZAaL+7XJ32nu/mC/zcrUSWsKGr0sX655IPUg+2uPcTbU8KxfR4XeqRqDtHRGn
 UHkuHHzjmfNTKj6JDdgYmGsizmMG5jkVawhXqFeOgTwCDGOmjtf928EfDzahfQcVNrwVaC
 p826JzrWj8kYQrXZ0DXe2UBp5y2re2U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-x7cNq9kRPvmNbOP5sheGVw-1; Wed, 04 Sep 2024 16:27:53 -0400
X-MC-Unique: x7cNq9kRPvmNbOP5sheGVw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3771b6da3ceso939508f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 13:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725481672; x=1726086472;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSa/PqJEOTruJ16ujatzuDY1L8Ey34ZJ4sEqg9KBxT0=;
 b=UMEC26kVKtuMdhFxsGipZpa1fLPfc8IHi0uXb1i95C1epfQJTpqGNTB3gLwoZlIKSb
 t5eyu+4st4z4UElqDmOYw4XxU4CZpw3u7ALEYFD/u5JhVK7Qxo0VocHjQEC3JORg0EQu
 tnXqMXfh9klK0RE1MhK5Pz8ZGHBjyOiBsl+TfMOUWJFZ5y3iewOLGDlkxDFIEAvmHOJg
 /gvJJIYWhTFRI94NtP4nEyeiiI570Mh+TqgIG/3lCR2bJcDCcoVkcfxCOwURn/R7EQ9h
 HGXM6ktfMGwyVr+bVxjA8duXKUl93hVCvZPokQbWHw5f/YWNhNjYwb6zG/94YD1nac1L
 SrAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQxYCyIW6xQmQL+MU0SM4MjpKSvwn0uGO+BiJ7lscz/BD0ZQhbjZPYsE534g+MBDN9Bo2eX5VhMGRQ@nongnu.org
X-Gm-Message-State: AOJu0Yx9aFqIr63+pU78p7ql0+oymd7VNMb5dnlhP7aipz0zpT4PbY2b
 R3kuQ9dKs+w2upVit9h3hiJ9VEHYNwn08YcucafVBwPgGep/YFoJKH3GSWoDFsSYBUbkeNUS73N
 1b0nuAyGDKdM+XE+P62AtMuWATQ6eS714G6NMTilQ/GJxT4lS/kDO
X-Received: by 2002:a05:6000:cf:b0:374:c101:32 with SMTP id
 ffacd0b85a97d-374c10100c3mr8379288f8f.46.1725481672207; 
 Wed, 04 Sep 2024 13:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc7m2YS27JYQZ+gwLKplE08XGKIw7MDXaDKw9mQEhSFvFVBu3Z7bcdayHy32ot6Vm1HFHloQ==
X-Received: by 2002:a05:6000:cf:b0:374:c101:32 with SMTP id
 ffacd0b85a97d-374c10100c3mr8379264f8f.46.1725481671104; 
 Wed, 04 Sep 2024 13:27:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:25b:d02e:ab32:7c17:4d7a:fa4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb3efsm214915365e9.6.2024.09.04.13.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 13:27:49 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:27:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, slp@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 5/8] device/virtio-nsm: Support for Nitro Secure
 Module device
Message-ID: <20240904162456-mutt-send-email-mst@kernel.org>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
 <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
 <20240828151005-mutt-send-email-mst@kernel.org>
 <CAFfO_h66g138yVwufKY_C22Aiu8XctzyyjqsBYM4wdYN77JLuQ@mail.gmail.com>
 <20240903162013-mutt-send-email-mst@kernel.org>
 <CAFfO_h4B6jt7QvBBk-Axf9btCm6sg8hao_o+Q_4+X=+86H6Pcw@mail.gmail.com>
 <CAFfO_h4EnF5q0p2n4a4U2-gi+GxYfem0B6GKhOaJFOpDL48KFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h4EnF5q0p2n4a4U2-gi+GxYfem0B6GKhOaJFOpDL48KFw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 05, 2024 at 12:30:07AM +0600, Dorjoy Chowdhury wrote:
> On Wed, Sep 4, 2024 at 2:47 AM Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> >
> >
> >
> > On Wed, Sep 4, 2024, 2:32 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Wed, Sep 04, 2024 at 01:58:15AM +0600, Dorjoy Chowdhury wrote:
> >> > On Thu, Aug 29, 2024 at 1:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > >
> >> > > On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote:
> >> > > > On Thu, Aug 29, 2024 at 12:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > > > >
> >> > > > > On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury wrote:
> >> > > > > > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]
> >> > > > > > for stripped down TPM functionality like cryptographic attestation.
> >> > > > > > The requests to and responses from NSM device are CBOR[3] encoded.
> >> > > > > >
> >> > > > > > This commit adds support for NSM device in QEMU. Although related to
> >> > > > > > AWS Nitro Enclaves, the virito-nsm device is independent and can be
> >> > > > > > used in other machine types as well. The libcbor[4] library has been
> >> > > > > > used for the CBOR encoding and decoding functionalities.
> >> > > > > >
> >> > > > > > [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> >> > > > > > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> >> > > > > > [3] http://cbor.io/
> >> > > > > > [4] https://libcbor.readthedocs.io/en/latest/
> >> > > > > >
> >> > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >> > > > > > ---
> >> > > > > >  MAINTAINERS                      |   10 +
> >> > > > > >  hw/virtio/Kconfig                |    5 +
> >> > > > > >  hw/virtio/cbor-helpers.c         |  326 ++++++
> >> > > > > >  hw/virtio/meson.build            |    6 +
> >> > > > > >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> >> > > > > >  hw/virtio/virtio-nsm.c           | 1638 ++++++++++++++++++++++++++++++
> >> > > > > >  include/hw/virtio/cbor-helpers.h |   46 +
> >> > > > > >  include/hw/virtio/virtio-nsm.h   |   59 ++
> >> > > > > >  meson.build                      |    2 +
> >> > > > > >  9 files changed, 2165 insertions(+)
> >> > > >
> >> > > > [...]
> >> > > >
> >> > > > > > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> >> > > > > > +{
> >> > > > > > +    g_autofree VirtQueueElement *out_elem = NULL;
> >> > > > > > +    g_autofree VirtQueueElement *in_elem = NULL;
> >> > > > > > +    VirtIONSM *vnsm = VIRTIO_NSM(vdev);
> >> > > > > > +    Error *err = NULL;
> >> > > > > > +
> >> > > > > > +    out_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> >> > > > > > +    if (!out_elem) {
> >> > > > > > +        /* nothing in virtqueue */
> >> > > > > > +        return;
> >> > > > > > +    }
> >> > > > > > +
> >> > > > > > +    if (out_elem->out_num != 1) {
> >> > > > > > +        virtio_error(vdev, "Expected one request buffer first in virtqueue");
> >> > > > > > +        goto cleanup;
> >> > > > > > +    }
> >> > > > >
> >> > > > > Seems to assume request in a single s/g element?
> >> > > > > We generally avoid this kind of thing.
> >> > > > >
> >> > > > > Applies equally elsewheree.
> >> > > > >
> >> > > >
> >> > > > Thank you for reviewing. I think I did it this way (first virqueue_pop
> >> > > > gives out_elem with out_num == 1 and the next virtqueue_pop gives
> >> > > > in_elem with in_num == 1) after seeing what the virqueue contains
> >> > > > (using printfs) when running in a VM and sending some NSM requests and
> >> > > > I noticed the above. Can you give me a bit more details about what
> >> > > > this should be like? Is there any existing virtio device code I can
> >> > > > look at for example?
> >> > > > Thanks!
> >> > >
> >> > >
> >> > > Use iov_to_buf / iov_from_buf
> >> > >
> >> > > there are many examples in the tree, I'd look for some recent ones.
> >> > >
> >> >
> >> > I am a bit stuck at this and I would appreciate some help. I looked at
> >> > other "iov_to_buf" and "iov_from_buf" examples in QEMU and in those I
> >> > see there are known request and response "structs" associated with it.
> >> > But in the case of NSM, the request and responses can be arbitrary
> >> > CBOR objects i.e., no specific structs or lengths associated.
> >>
> >>
> >> take whatever you want to access, move it to a buffer with iov_to_buf
> >> then access the buffer.
> >>
> >> reverse is even easier. put in a buffer, copy with iov_from_buf.
> >
> >
> > I guess I will just need to copy the iov buffer (whatever the length was in the out_elem's out buf) to another buffer using iov_to_buf and then pass it to the processing function and then copy the response to the in_elem's buffer using iov_from_buf, right? Wouldn't the copying be redundant in this case as we could just instead pass the original buffers (like the iov-s are passed right now) to the processing function?
> >
> >>
> >> > So I am
> >> > not sure using "iov_to_buf" / "iov_from_buf" makes sense here.
> >> > And about the request response being in a single s/g element, I think
> >> > it's because of how the NSM driver is in drivers/misc/nsm.c (see
> >> > nsm_sendrecv_msg_locked function)in the linux kernel tree.
> >>
> >> yes but driver is free to change this.
> >> Isn't there a spec for this device to consult?
> >> Sending that to virtio tc will be needed before we add this to qemu.
> >
> >
> > I think this is the spec for this device (also mentioned in the commit message of this patch)
> > https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> >
> 
> Hi Michael. Did you get a chance to look at the NSM device spec above?
> I am not sure but from the description there I think the request
> response being in a single s/g element makes sense, right?
> So the
> current implementation of first checking out_elem with out_num == 1
> and then an in_elem with in_num == 1 should be correct. Please correct
> me if I am wrong here and if I should change the implementation to
> something else.

This is not what the spec says. The spec says it's a single
buffer, and in virtio longo buffer can include any number of
s/g elements. how many - up to driver. device does not get
to decide.

> 
> Also I had another look into using iov_to_buf and iov_from_buf. If I
> wanted to use iov_to_buf here, I would just be copying the
> out_elem->out_sg->iov_base to another buffer (by malloc-ing the same
> length) and then passing it to the processing function
> (get_nsm_request_response). And if I wanted to use the iov_from_buf
> then I would probably just make another buffer the same size of
> in_elem->in_sg->iov_base and then pass it to the processing function
> (get_nsm_request_response).


If you do not know the size, use iov_size.


> The function tries to put the response
> CBOR object in the response buffer but if it is too small, it then
> tries to put the error response BufferTooSmall if it fails then it
> returns error. I don't see how using iov_to_buf and iov_from_buf makes
> any difference here other than passing in the original iov structs to
> the processing function instead. Seems like doing so would just be
> doing some unnecessary copying.
> 
> Please let me know what you think so that I can better understand
> this. Sorry for the back and forth a bit on this one.
> 
> Thanks.
> 
> Regards,
> Dorjoy


These are easy ways to handle arbirary s/g, but if it does
not help, feel free to iterate over s/g youself.


