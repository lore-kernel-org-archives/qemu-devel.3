Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62115C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW22j-0002pT-A8; Mon, 22 Jul 2024 19:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW22h-0002ic-BQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW22e-0002Iq-04
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721689322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7kCNxQHBimJ1b2pQoeHqAdulJTeGmjT77OuswTwrk1E=;
 b=CkhitQ+HyFa+Z68AFoM2aiGfyqRUWrY81sSEOTkZhddHQ188xDAsFj8CXD47QYDu3qNyWd
 32hUsiafmNf5vIb9xnTiYlSOwRxJpQKwaaRP69s2Q02aM2MHawADaCUnDlF0ayY8li46jP
 MQoUzWdrNzaJajwIK7C64fOs39+cKLg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-MypGVh5sN-uK49_PDPuIuQ-1; Mon, 22 Jul 2024 19:02:00 -0400
X-MC-Unique: MypGVh5sN-uK49_PDPuIuQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b792d6fe5bso16120066d6.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721689320; x=1722294120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kCNxQHBimJ1b2pQoeHqAdulJTeGmjT77OuswTwrk1E=;
 b=OHyl5j6o2nOW7dO58qmXn4oVpbGwC5RqViUOU96bUN1tfgEWSkU63V1eYXwzX2/dsq
 lVj3RNko50WLcTqAQMBYBukl35/W1e6ilX6N/fwLILHgzm2ShxQA3t3qsbYMXslu/P4Y
 PPqMSJ8opb0DGj9kdSNr/vPWYJ2+wYqCs0H38zGqiXXmOC1/D6l9qFN6MN+vliwxLNpN
 YWQphIoVTf/XINVN1VZtv43AvMFRfMq8FbDtRQQuJ5cW3JGb0knP/Sr7fjSLHQJJjErq
 njTIM58SO5hQERFsO8dOLbHxodF1dIbuGbf2vuQ/WnhKG7RQktq/AGvPE4BPuE/YQ6pY
 YOrw==
X-Gm-Message-State: AOJu0YzvKiCmuVIfmvNGnyEVBYf/OFBsLtARNMXJv7FyqVitEkHg4va3
 2NUnk7/nrshbX1J43qtMTSKSRGpp1pbl4IghgbGiXOwd4d2m9F1B9mI3+Vwnslm8zO46EuUcBs5
 nf/H5OUvk81sDl38E0Ucn2mRJi/pWq0o8wcFgIvogpPQzWlmtsp4q
X-Received: by 2002:a05:6214:3da1:b0:6b5:de38:d6ee with SMTP id
 6a1803df08f44-6b9587d9a91mr63760216d6.3.1721689319949; 
 Mon, 22 Jul 2024 16:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyMDUrso0GVYyel0s2KL9tqxssKLjtcLoZRl5yk4HFJz5pTtQbnYBabkoepqKmnJ0+HeyF4Q==
X-Received: by 2002:a05:6214:3da1:b0:6b5:de38:d6ee with SMTP id
 6a1803df08f44-6b9587d9a91mr63760036d6.3.1721689319470; 
 Mon, 22 Jul 2024 16:01:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b970cc21c4sm17646516d6.122.2024.07.22.16.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 16:01:58 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:01:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 0/9] migration/multifd: Remove
 multifd_send_state->pages
Message-ID: <Zp7k4wF1W6Fzp7YW@x1n>
References: <20240722175914.24022-1-farosas@suse.de> <Zp65zvb9oy9my-qY@x1n>
 <87msm9yy77.fsf@suse.de> <Zp7HH6-WeYKXQ-fy@x1n>
 <87a5i9yvhf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5i9yvhf.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 22, 2024 at 06:20:28PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jul 22, 2024 at 05:21:48PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Jul 22, 2024 at 02:59:05PM -0300, Fabiano Rosas wrote:
> >> >> Hi,
> >> >> 
> >> >> In this v2 I took Peter's suggestion of keeping the channels' pointers
> >> >> and moving only the extra slot. The major changes are in patches 5 and
> >> >> 9. Patch 3 introduces the structure:
> >> >> 
> >> >> typedef enum {
> >> >>     MULTIFD_PAYLOAD_NONE,
> >> >>     MULTIFD_PAYLOAD_RAM,
> >> >> } MultiFDPayloadType;
> >> >> 
> >> >> struct MultiFDSendData {
> >> >>     MultiFDPayloadType type;
> >> >>     union {
> >> >>         MultiFDPages_t ram;
> >> >>     } u;
> >> >> };
> >> >> 
> >> >> I added a NONE type so we can use it to tell when the channel has
> >> >> finished sending a packet, since we'll need to switch types between
> >> >> clients anyway. This avoids having to introduce a 'size', or 'free'
> >> >> variable.
> >> >
> >> > This at least looks better to me, thanks.
> >> >
> >> >> 
> >> >> WHAT'S MISSING:
> >> >> 
> >> >> - The support for calling multifd_send() concurrently. Maciej has this
> >> >>   in his series so I didn't touch it.
> >> >> 
> >> >> - A way of adding methods for the new payload type. Currently, the
> >> >>   compression methods are somewhat coupled with ram migration, so I'm
> >> >>   not sure how to proceed.
> >> >
> >> > What is this one?  Why compression methods need new payload?  Aren't they
> >> > ram-typed?
> >> 
> >> The data we transport is MultiFDPages_t, yes, but the MultiFDMethods are
> >> either nocomp, or the compression-specific methods
> >> (e.g. zlib_send_prepare).
> >> 
> >> How do we add methods for the upcoming new payload types? I don't expect
> >> us to continue using nocomp and then do "if (ram)... else if
> >> (device_state) ..." inside of them. I would expect us to rename
> >> s/nocomp/ram/ and add a new set of MultiFDMethods for the new data type
> >> (e.g. vfio_send_prepare, vmstate_send_prepare, etc).
> >> 
> >> multifd_nocomp_ops -> multifd_ram_ops // rename
> >> multifd_zlib_ops   // existing
> >> multifd_device_ops // new
> >> 
> >> The challenge here is that the current framework is nocomp
> >> vs. compression. It needs to become ram + compression vs. other types.
> >
> > IMHO we can keep multifd_ops[] only for RAM.  There's only send_prepare()
> > that device state will need, and so far it's only (referring Maciej's
> > code):
> >
> > static int nocomp_send_prepare_device_state(MultiFDSendParams *p,
> >                                             Error **errp)
> > {
> >     multifd_send_prepare_header_device_state(p);
> >
> >     assert(!(p->flags & MULTIFD_FLAG_SYNC));
> >
> >     p->next_packet_size = p->device_state->buf_len;
> >     if (p->next_packet_size > 0) {
> >         p->iov[p->iovs_num].iov_base = p->device_state->buf;
> >         p->iov[p->iovs_num].iov_len = p->next_packet_size;
> >         p->iovs_num++;
> >     }
> >
> >     p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;
> >
> >     multifd_send_fill_packet_device_state(p);
> >
> >     return 0;
> > }
> >
> > None of other multifd_ops are used.
> 
> There's also a conditional around device_state when calling
> ->recv(). That could seems like it could go to a hook.
> 
> https://lore.kernel.org/r/41dedaf2c9abebb5e45f88c052daa26320715a92.1718717584.git.maciej.szmigiero@oracle.com

Actually that's exactly what I think is right.. it looks to me now that we
could bypass anything in MultifdOps (including recv()) but let device state
be a parallel layer of MultifdOps itself, leaving MultifdOps only for
compressors.

And yeah, I still remember you just renamed it from recv_pages() to
recv()..  it's just that now when think it again it looks like cleaner to
make it only about pages..

> 
> >
> > I think we can directly invoke this part of device state code in
> > multifd_send_thread() for now.  So far I think it should be ok.
> 
> It's not just that. There's also a check for "if (ram)" at every call to
> multifd_ops to avoid calling the ram code when doing the device
> migration. It would be way easier to just set noop functions for those.
> 
> static MultiFDMethods multifd_devstate_ops = {
>     .send_setup = noop_send_setup,
>     .send_cleanup = noop_send_cleanup,
>     .send_prepare = devstate_send_prepare,
>     .recv_setup = noop_recv_setup,
>     .recv_cleanup = noop_recv_cleanup,
>     .recv = devstate_recv
> };
> 
> I'm not saying this needs to be done in this series though. But I do
> think that's the correct design choice for the long term.

Yes it should be separate.

And what I meant is we don't need all these noops, but recv() keeps being
ignored just like above, then for sender side, right now it's:

            ret = multifd_send_state->ops->send_prepare(p, &local_err);
            if (migrate_mapped_ram()) {
                file_write_ramblock_iov();
            } else {
                ret = qio_channel_writev_full_all();
            }

VFIO can process device state in parallel, so:

    if (ram) {
        ret = multifd_send_state->ops->send_prepare(p, &local_err);
        if (migrate_mapped_ram()) {
                file_write_ramblock_iov();
        } else {
                qio_channel_writev_full_all();
        }
    } else {
        // device state handling
        multifd_send_device_prepare(...);
        ...
        qio_channel_writev_full_all();
    }

Then MultifdOps doesn't apply to device states.

-- 
Peter Xu


