Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC66C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEoN-0005Sr-EF; Fri, 25 Jul 2025 05:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufEoL-0005QS-CJ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufEoH-00041S-Rv
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753436027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rL0Matmprxl01fcbgOhcHoFBx3mgBsBOELf5LsdOdA=;
 b=IjCe2xLHwZV03lE4y6R9pp3fsNWylVdNwUlqzsEZ0009MKhm2AzRTXtbCZft8OlJHBMXo1
 Iw6rj9obfhcqSvGz2U/g/xzfbgHH3K4hYGLJUE+i302odjiUYuWSv6ivy2lGSwVvZvsQr8
 EILXp+HACFefld1L231kGRDWZ4QkINc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-OtZiUfpIOvekzjrGX4To3g-1; Fri, 25 Jul 2025 05:33:45 -0400
X-MC-Unique: OtZiUfpIOvekzjrGX4To3g-1
X-Mimecast-MFC-AGG-ID: OtZiUfpIOvekzjrGX4To3g_1753436024
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so1089455f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436024; x=1754040824;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7rL0Matmprxl01fcbgOhcHoFBx3mgBsBOELf5LsdOdA=;
 b=MEcMcbbKK5Uv+Dt5uMnz6vrQ/YOsvrX+LATTaZFfbTCSWqBOsJoxvXgnz/ZpM1/+X6
 bYxYUMh1L5AiVS6yw6FwhCgu8CAEvjnL685GyeAdhheU2wiyRPRDQ512iAG0C09iUHaF
 b6mXFroScIycWPhHd95Hiw954/Su7JO4Uwk04AFu+1KOYvCGyDTkgZcCzCeKm5o/uyKz
 E5EtuGbISTW/4EF7g7DvkB07JYrslHWyhhzRoz+U5Pjqpn2DLBLGMHP0MmW8Ub+NPOJK
 xGLw5ZKEj89Bopi0nQ8hdTtiI5QaNuJF8Ojx50+dfVL7NpMfrH8Dz2hn7F1P0/ngKAJG
 N4Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHoF81yVjq2W43SOPdlTk6B9rB+cGI+XgC5zuc6mh+kRW2S+PfXFgXVIP4Wy5VVXVi14W70iwlJO+J@nongnu.org
X-Gm-Message-State: AOJu0YyqB8uEYivWuPIjcPvM2boB8Be0TWSsHCysno+Cr0/z6QIgX0hd
 AMQ2FbJ86YkNQfrSiSXgsiBZKir/QAeAstrDHNUulq7aLZKkkN2UoxdjiDgymuB7Qjhdtu0+jxC
 4spnST1zSpHBGATnL181ooIA0AVxSFgvF6re88+mTo4MwTzS50t/XD/F9
X-Gm-Gg: ASbGncv1mkDtZomXIxLdFpexGfke0AXjUgEUeO/fjsYtLYrsrjw4dMluKvL+sfqvIqe
 oy0JicphWgdY9bl4PWyFSJ9ADfTByglPPlzaGllpR58SwIYaPCBzR/Af8CVHlEyRN6BICODfTxh
 A/FLK9v7BE4YzHFa3Pt/cCDIzoTTGXIhZmy3IWiLK5hCNY7uKhin3A3ilhF1sm52+y4Cz3QCdFW
 uz75EbMdlijGtaNiACSTsVfrP1BrWG8U3K5C6hrkklPk3bcG5/OI+sMhRSSH2BIj0Gai2QifPnc
 UJOGO0mrtLlntvGD27LV+YQUp2OaTj6G2g==
X-Received: by 2002:a5d:5c84:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3b776673c95mr1070308f8f.47.1753436023625; 
 Fri, 25 Jul 2025 02:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8M66MGNGKwJtkbqQqhhcfivz2zXSXf0Iv2ZMe8NubhKPP/TfZqJpPVNsA9RZIG2gCIgaIDg==
X-Received: by 2002:a5d:5c84:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3b776673c95mr1070284f8f.47.1753436023068; 
 Fri, 25 Jul 2025 02:33:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586e7cccdfsm42489005e9.0.2025.07.25.02.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 02:33:42 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:33:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, si-wei.liu@oracle.com, eperezma@redhat.com,
 boris.ostrovsky@oracle.com
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
Message-ID: <20250725053122-mutt-send-email-mst@kernel.org>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
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

On Thu, Jul 24, 2025 at 05:59:20PM -0400, Jonah Palmer wrote:
> 
> 
> On 7/23/25 1:51 AM, Jason Wang wrote:
> > On Tue, Jul 22, 2025 at 8:41 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
> > > 
> > > This series is an RFC initial implementation of iterative live
> > > migration for virtio-net devices.
> > > 
> > > The main motivation behind implementing iterative migration for
> > > virtio-net devices is to start on heavy, time-consuming operations
> > > for the destination while the source is still active (i.e. before
> > > the stop-and-copy phase).
> > 
> > It would be better to explain which kind of operations were heavy and
> > time-consuming and how iterative migration help.
> > 
> 
> You're right. Apologies for being vague here.
> 
> I did do some profiling of the virtio_load call for virtio-net to try and
> narrow down where exactly most of the downtime is coming from during the
> stop-and-copy phase.
> 
> Pretty much the entirety of the downtime comes from the vmstate_load_state
> call for the vmstate_virtio's subsections:
> 
> /* Subsections */
> ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> if (ret) {
>     return ret;
> }
> 
> More specifically, the vmstate_virtio_virtqueues and
> vmstate_virtio_extra_state subsections.
> 
> For example, currently (with no iterative migration), for a virtio-net
> device, the virtio_load call took 13.29ms to finish. 13.20ms of that time
> was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
> 
> Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtqueues and
> ~6.33ms was spent migrating the vmstate_virtio_extra_state subsections. And
> I believe this is from walking VIRTIO_QUEUE_MAX virtqueues, twice.

Can we optimize it simply by sending a bitmap of used vqs?

> vmstate_load_state virtio-net v11
> vmstate_load_state PCIDevice v2
> vmstate_load_state_end PCIDevice end/0
> vmstate_load_state virtio-net-device v11
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state virtio-net-vnet v0
> vmstate_load_state_end virtio-net-vnet end/0
> vmstate_load_state virtio-net-ufo v0
> vmstate_load_state_end virtio-net-ufo end/0
> vmstate_load_state virtio-net-tx_waiting v0
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state_end virtio-net-tx_waiting end/0
> vmstate_load_state_end virtio-net-device end/0
> vmstate_load_state virtio v1
> vmstate_load_state virtio/64bit_features v1
> vmstate_load_state_end virtio/64bit_features end/0
> vmstate_load_state virtio/virtqueues v1
> vmstate_load_state virtqueue_state v1  <--- Queue idx 0
> ...
> vmstate_load_state_end virtqueue_state end/0
> vmstate_load_state virtqueue_state v1  <--- Queue idx 1023
> vmstate_load_state_end virtqueue_state end/0
> vmstate_load_state_end virtio/virtqueues end/0
> vmstate_load_state virtio/extra_state v1
> vmstate_load_state virtio_pci v1
> vmstate_load_state virtio_pci/modern_state v1
> vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 0
> vmstate_load_state_end virtio_pci/modern_queue_state end/0
> ...
> vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 1023
> vmstate_load_state_end virtio_pci/modern_queue_state end/0
> vmstate_load_state_end virtio_pci/modern_state end/0
> vmstate_load_state_end virtio_pci end/0
> vmstate_load_state_end virtio/extra_state end/0
> vmstate_load_state virtio/started v1
> vmstate_load_state_end virtio/started end/0
> vmstate_load_state_end virtio end/0
> vmstate_load_state_end virtio-net end/0
> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
> instance_id=0 downtime=13260
> 
> With iterative migration for virtio-net (maybe all virtio devices?), we can
> send this early while the source is still running and then only send the
> deltas during the stop-and-copy phase. It's likely that the source wont be
> using all VIRTIO_QUEUE_MAX virtqueues during the migration period, so this
> could really minimize a large majority of the downtime contributed by
> virtio-net.
> 
> This could be one example.
> 
> > > 
> > > The motivation behind this RFC series specifically is to provide an
> > > initial framework for such an implementation and get feedback on the
> > > design and direction.
> > > -------
> > > 
> > > This implementation of iterative live migration for a virtio-net device
> > > is enabled via setting the migration capability 'virtio-iterative' to
> > > on for both the source & destination, e.g. (HMP):
> > > 
> > > (qemu) migrate_set_capability virtio-iterative on
> > > 
> > > The virtio-net device's SaveVMHandlers hooks are registered/unregistered
> > > during the device's realize/unrealize phase.
> > 
> > I wonder about the plan for libvirt support.
> > 
> 
> Could you elaborate on this a bit?
> 
> > > 
> > > Currently, this series only sends and loads the vmstate at the start of
> > > migration. The vmstate is still sent (again) during the stop-and-copy
> > > phase, as it is today, to handle any deltas in the state since it was
> > > initially sent. A future patch in this series could avoid having to
> > > re-send and re-load the entire state again and instead focus only on the
> > > deltas.
> > > 
> > > There is a slight, modest improvement in guest-visible downtime from
> > > this series. More specifically, when using iterative live migration with
> > > a virtio-net device, the downtime contributed by migrating a virtio-net
> > > device decreased from ~3.2ms to ~1.4ms on average:
> > 
> > Are you testing this via a software virtio device or hardware one?
> > 
> 
> Just software (virtio-device, vhost-net) with these numbers. I can run some
> tests with vDPA hardware though.
> 
> Those numbers were from a simple, 1 queue-pair virtio-net device.
> 
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
> > > This slight improvement is likely due to the initial vmstate_load_state
> > > call "warming up" pages in memory such that, when it's called a second
> > > time during the stop-and-copy phase, allocation and page-fault latencies
> > > are reduced.
> > > -------
> > > 
> > > Comments, suggestions, etc. are welcome here.
> > > 
> > > Jonah Palmer (6):
> > >    migration: Add virtio-iterative capability
> > >    virtio-net: Reorder vmstate_virtio_net and helpers
> > >    virtio-net: Add SaveVMHandlers for iterative migration
> > >    virtio-net: iter live migration - migrate vmstate
> > >    virtio,virtio-net: skip consistency check in virtio_load for iterative
> > >      migration
> > >    virtio-net: skip vhost_started assertion during iterative migration
> > > 
> > >   hw/net/virtio-net.c            | 246 +++++++++++++++++++++++++++------
> > >   hw/virtio/virtio.c             |  32 +++--
> > >   include/hw/virtio/virtio-net.h |   8 ++
> > >   include/hw/virtio/virtio.h     |   7 +
> > >   migration/savevm.c             |   1 +
> > >   qapi/migration.json            |   7 +-
> > >   6 files changed, 247 insertions(+), 54 deletions(-)
> > > 
> > > --
> > > 2.47.1
> > 
> > Thanks
> > 
> > > 
> > 


