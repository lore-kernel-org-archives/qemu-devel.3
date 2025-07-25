Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8018BC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEmB-0002aX-TE; Fri, 25 Jul 2025 05:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufElv-0002X3-QC
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufEls-0003Xx-Cy
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753435876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRJhqh7LI3ZiGSIo3rgH+PGi4v/pg8XWekfAXScvweg=;
 b=X06U/LM9N+VKuvYIV90YSzOAwIDF4kTNzu6UHBjIDuGwdEuF/zL1scNCqOmxGARUq9Z07e
 ECl2lb7DbJsndZia9V7RnWsUUSqoU74uAxIN2TsMcSzsT/n3n++loCq7ll9aImgqyqKjCf
 o2CADUachRA+ZrSD/NYzhIwGQU8jCYc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-JjG-FldIMQewAnvmhIEovQ-1; Fri, 25 Jul 2025 05:31:14 -0400
X-MC-Unique: JjG-FldIMQewAnvmhIEovQ-1
X-Mimecast-MFC-AGG-ID: JjG-FldIMQewAnvmhIEovQ_1753435873
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b604541741so1390566f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753435873; x=1754040673;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lRJhqh7LI3ZiGSIo3rgH+PGi4v/pg8XWekfAXScvweg=;
 b=iJiOBsZwCytIpycEs2H8b5Nq7X/OPr++/1/kox0uPfsZS7oAjgkLbI17dr8vvGVITa
 2s/LQjDOdfq6rPZ7EK8/HjVxFJ8Z8RL8jm62ykzO00jIkq3CCWa9MhExqlfS6VbbgiMa
 vEVOUIaIoSiO42fPm3j/5Dn1RDNpPyu9Mlm8e4/3FfbnnUuWYR1a1Pdhmt7u0GJi2i4F
 ToGNb0vc2Ad4sb34DlajLPtVplyyC9jnFKLZgIbfUPPxdI5GTV1eID9LxEcmgTmEOmxh
 Zitfa4leQv9X0Q5UlTQQHaj6IbuKxdtnr8TnEysNve9RHCZFxSvy039POy7+nz/VHKlJ
 UXhQ==
X-Gm-Message-State: AOJu0YwJUMvd/TbKQ/6NYihSFLcWGfgHNVMQfTqRVk5G+XWVGvh1+11v
 C+syNN3D1LuM3OkZ8anTOYbWuNYfsW2VMHJoxpWQgSK33Ki8P4veWjshU7SYRAE5rc0adKcKD4W
 TbXOdHnZZPyZHDvzV9jxaaqPljWNVa9bvL9fe3DyN9Qt5fyVBPmWw/zMv
X-Gm-Gg: ASbGncvNvvhGeinIZKrN2CSgv2qDz63XaKx2av9xp7VtJYzX6AAquy9Gn8H9dBhsBdZ
 sSuBoOx0rtpXrAVR8/I8GZeEgYCHn5NhfRBVxbzxGoJFUhfwciVRlC8Uat4SCzW0Tkzu8kTSMRF
 h1QfGZ4Rbg1biecqfM78iJH5QDwdPFXl50Yau9E8mzAicR3iJyIYCRx0eee95JtkZCrfe6/Ng90
 tsMP9657I7kjuzSRRriPRThZOrrkJt/W8M//+qaF6S1XCc+T5c+DrwZwBBOslzKEiaoaC+HWXBk
 LpQ63dFfI4IaZpikJhyGDWpbEOCJqhnHiA==
X-Received: by 2002:a05:6000:40db:b0:3b5:f8d5:5dba with SMTP id
 ffacd0b85a97d-3b776666f76mr1348074f8f.30.1753435873123; 
 Fri, 25 Jul 2025 02:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5KeITPEv4nABSBz6l3k8HGPnae2Ft7VdfdC+NJdKgMspGWWDJK2mNNFZwPAs0Utra/i+bIg==
X-Received: by 2002:a05:6000:40db:b0:3b5:f8d5:5dba with SMTP id
 ffacd0b85a97d-3b776666f76mr1348035f8f.30.1753435872502; 
 Fri, 25 Jul 2025 02:31:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705bccc5sm47254695e9.22.2025.07.25.02.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 02:31:11 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:31:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 4/6] virtio-net: iter live migration - migrate vmstate
Message-ID: <20250725052825-mutt-send-email-mst@kernel.org>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-5-jonah.palmer@oracle.com>
 <20250723024406-mutt-send-email-mst@kernel.org>
 <e6ab2cdc-5f5f-454b-9795-e8016ce16248@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6ab2cdc-5f5f-454b-9795-e8016ce16248@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 24, 2025 at 10:45:34AM -0400, Jonah Palmer wrote:
> 
> 
> On 7/23/25 2:51 AM, Michael S. Tsirkin wrote:
> > On Tue, Jul 22, 2025 at 12:41:25PM +0000, Jonah Palmer wrote:
> > > Lays out the initial groundwork for iteratively migrating the state of a
> > > virtio-net device, starting with its vmstate (via vmstate_save_state &
> > > vmstate_load_state).
> > > 
> > > The original non-iterative vmstate framework still runs during the
> > > stop-and-copy phase when the guest is paused, which is still necessary
> > > to migrate over the final state of the virtqueues once the sourced has
> > > been paused.
> > > 
> > > Although the vmstate framework is used twice (once during the iterative
> > > portion and once during the stop-and-copy phase), it appears that
> > > there's some modest improvement in guest-visible downtime when using a
> > > virtio-net device.
> > > 
> > > When tracing the vmstate_downtime_save and vmstate_downtime_load
> > > tracepoints, for a virtio-net device using iterative live migration, the
> > > non-iterative downtime portion improved modestly, going from ~3.2ms to
> > > ~1.4ms:
> > > 
> > > Before:
> > > -------
> > > vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
> > >    instance_id=0 downtime=3594
> > > 
> > > After:
> > > ------
> > > vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
> > >    instance_id=0 downtime=1607
> > > 
> > > This improvement is likely due to the initial vmstate_load_state call
> > > (while the guest is still running) "warming up" all related pages and
> > > structures on the destination. In other words, by the time the final
> > > stop-and-copy phase starts, the heavy allocations and page-fault
> > > latencies are reduced, making the device re-loads slightly faster and
> > > the guest-visible downtime window slightly smaller.
> > 
> > did I get it right it's just the vmstate load for this single device?
> > If the theory is right, is it not possible that while the
> > tracepoints are now closer together, you have pushed something
> > else out of the cache, making the effect on guest visible downtime
> > unpredictable? how about the total vmstate load time?
> > 
> 
> Correct, the data above is just from the virtio-net device's downtime
> contribution (specifically during the stop-and-copy phase).
> 
> Theoretically, yes I believe so. To try and get a feel on this, I ran some
> slightly heavier testing for the virtio-net device: vhost-net + 4 queue
> pairs (the one above was just a virtio-net device with 1 queue pair).
> 
> I traced the reported downtimes of the devices that come right before and
> after virtio-net's vmstate_load_state call with and without iterative
> migration on the virtio-net device.
> 
> The downtimes below are all from the vmstate_load_state calls that happen
> while the source has been stopped:
> 
> With iterative migration for virtio-net:
> ----------------------------------------
> vga:             1.50ms |  1.39ms |  1.37ms |  1.50ms |  1.63ms |
> virtio-console: 13.78ms | 14.24ms | 13.74ms | 13.89ms | 13.60ms |
> virtio-net:	13.91ms | 13.52ms | 13.09ms | 13.59ms | 13.37ms |
> virtio-scsi:	18.71ms | 13.96ms | 14.05ms | 16.55ms | 14.30ms |
> 
> vga:		Avg.  1.47ms | Var: 0.0109ms² | Std. Dev (σ): 0.104ms
> virtio-console: Avg. 13.85ms | Var: 0.0583ms² | Std. Dev (σ): 0.241ms
> virtio-net:	Avg. 13.49ms | Var: 0.0904ms² | Std. Dev (σ): 0.301ms
> virtio-scsi:	Avg. 15.51ms | Var: 4.3299ms² | Std. Dev (σ): 2.081ms
> 
> Without iterative migration for virtio-net:
> -------------------------------------------
> vga:		 1.47ms |  1.28ms |  1.55ms |  1.36ms |  1.22ms |
> virtio-console: 13.39ms | 13.40ms | 14.37ms | 13.93ms | 13.36ms |
> virtio-net:	18.52ms | 17.77ms | 17.52ms | 15.52ms | 17.32ms |
> virtio-scsi:	13.35ms | 13.94ms | 15.17ms | 16.01ms | 14.08ms |
> 
> vga:		Avg.  1.37ms | Var: 0.0182ms² | Std. Dev (σ): 0.135ms
> virtio-console: Avg. 13.69ms | Var: 0.2007ms² | Std. Dev (σ): 0.448ms
> virtio-net:	Avg. 17.33ms | Var: 1.2305ms² | Std. Dev (σ): 1.109ms
> virtio-scsi:	Avg. 14.51ms | Var: 1.1352ms² | Std. Dev (σ): 1.065ms
> 
> The most notable difference here is the standard deviation of virtio-scsi's
> migration downtime, which comes after virtio-net's migration: virtio-scsi's
> σ rises from ~1.07ms to ~2.08ms when virtio-net is iteratively migrated.
> 
> However, since I only got 5 samples per device, the trend is indicative but
> not definitive.
> 
> Total vmstate load time per device ≈ downtimes reported above, unless you're
> referring to overall downtime across all devices?

Indeed.

I also wonder, if preheating cache is a big gain, why don't we just
do it for all devices? there is nothing special in virtio: just
call save for all devices, send the state, call load on destination
then call reset to discard the state.



> ----------
> 
> Having said all this, this RFC is just an initial, first-step for iterative
> migration of a virtio-net device. This second vmstate_load_state call during
> the stop-and-copy phase isn't optimal. A future version of this series could
> do away with this second call and only send the deltas instead of the entire
> state again.

I see how this could be a win, in theory, if the state is big.


> > > Future patches could improve upon this by skipping the second
> > > vmstate_save/load_state calls (during the stop-and-copy phase) and
> > > instead only send deltas right before/after the source is stopped.
> > > 
> > > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > > ---
> > >   hw/net/virtio-net.c            | 37 ++++++++++++++++++++++++++++++++++
> > >   include/hw/virtio/virtio-net.h |  8 ++++++++
> > >   2 files changed, 45 insertions(+)
> > > 
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 19aa5b5936..86a6fe5b91 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -3808,16 +3808,31 @@ static bool virtio_net_is_active(void *opaque)
> > >   static int virtio_net_save_setup(QEMUFile *f, void *opaque, Error **errp)
> > >   {
> > > +    VirtIONet *n = opaque;
> > > +
> > > +    qemu_put_be64(f, VNET_MIG_F_INIT_STATE);
> > > +    vmstate_save_state(f, &vmstate_virtio_net, n, NULL);
> > > +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
> > > +
> > >       return 0;
> > >   }
> > >   static int virtio_net_save_live_iterate(QEMUFile *f, void *opaque)
> > >   {
> > > +    bool new_data = false;
> > > +
> > > +    if (!new_data) {
> > > +        qemu_put_be64(f, VNET_MIG_F_NO_DATA);
> > > +        return 1;
> > > +    }
> > > +
> > > +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
> > >       return 1;
> > >   }
> > >   static int virtio_net_save_live_complete_precopy(QEMUFile *f, void *opaque)
> > >   {
> > > +    qemu_put_be64(f, VNET_MIG_F_NO_DATA);
> > >       return 0;
> > >   }
> > > @@ -3833,6 +3848,28 @@ static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
> > >   static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
> > >   {
> > > +    VirtIONet *n = opaque;
> > > +    uint64_t flag;
> > > +
> > > +    flag = qemu_get_be64(f);
> > > +    if (flag == VNET_MIG_F_NO_DATA) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    while (flag != VNET_MIG_F_END_DATA) {
> > > +        switch (flag) {
> > > +        case VNET_MIG_F_INIT_STATE:
> > > +        {
> > > +            vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_VERSION);
> > > +            break;
> > > +        }
> > > +        default:
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Uknown flag 0x%"PRIx64, __func__, flag);
> > > +            return -EINVAL;
> > > +        }
> > > +
> > > +        flag = qemu_get_be64(f);
> > > +    }
> > >       return 0;
> > >   }
> > > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> > > index b9ea9e824e..d6c7619053 100644
> > > --- a/include/hw/virtio/virtio-net.h
> > > +++ b/include/hw/virtio/virtio-net.h
> > > @@ -163,6 +163,14 @@ typedef struct VirtIONetQueue {
> > >       struct VirtIONet *n;
> > >   } VirtIONetQueue;
> > > +/*
> > > + * Flags to be used as unique delimiters for virtio-net devices in the
> > > + * migration stream.
> > > + */
> > > +#define VNET_MIG_F_INIT_STATE          (0xffffffffef200000ULL)
> > > +#define VNET_MIG_F_END_DATA            (0xffffffffef200001ULL)
> > > +#define VNET_MIG_F_NO_DATA             (0xffffffffef200002ULL)
> > > +
> > >   struct VirtIONet {
> > >       VirtIODevice parent_obj;
> > >       uint8_t mac[ETH_ALEN];
> > > -- 
> > > 2.47.1
> > 


