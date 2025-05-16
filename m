Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5479C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkBD-0005Xb-PI; Thu, 15 May 2025 21:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkBB-0005Pn-FO
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkB9-0003wi-K7
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=maGencK9p/bE/xlNWR56lEVlldVg/2y+eLAHcmQrJTs=;
 b=ghmk/Pz0Wq+GV9m9fZBmAL5DSB5cr44Wz8Gzwga497P5d/Bhx5TpzGvd20WiT6bhkzfTiv
 irkTL2VfjM33ZO0tYLh6bvkK3KgK+F/o+BrLmbApY2c14IQKdy0Tw8Dk/UolU0CcSpR1se
 UKe4902FzEmmik4tJs0UIxJQaT6My4Y=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-m9GNG523NV6geoyIxDjabQ-1; Thu, 15 May 2025 21:48:00 -0400
X-MC-Unique: m9GNG523NV6geoyIxDjabQ-1
X-Mimecast-MFC-AGG-ID: m9GNG523NV6geoyIxDjabQ_1747360080
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-52dbdd316f8so21320e0c.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360080; x=1747964880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maGencK9p/bE/xlNWR56lEVlldVg/2y+eLAHcmQrJTs=;
 b=HC1EIdfsKMgY/ATHNwulDVOg1/wacCEbzv62wioykSdWkpn2nSlXvqluiEUdw2HJt5
 5DoaYi2J67ra3oYe14N11vsFnEZMqILoPPuFmDWHCCXubKfGsAXf6iCo7oO3e+6QgMqZ
 vv+JSL1Qe17jslP2nVK7Is34w6AJfREQKuEZqE/Yd9m9nbFmlhV7AWK6pWI3s6rO2KJA
 s7p7rFB4peq9dUBK2mDb+QiAuXdfHt3OsISqFq9JN0RDoC+uwvpsNAr2uR0KZqtYzFfv
 RI4WXkMP+Wlukf6NLdL/d4hSYsaLnJ6iE7VfJO+3dnG+u1Z/8a4ogUDzomspdrUs7PCf
 6v5g==
X-Gm-Message-State: AOJu0Yzed0JMuyFjqAJdC5tfrpc4PNkJyr+7SGv2EJp5Vp2DhpMr8JgZ
 hfHuUwYQCAjkXxDPguf6muauelk74W+B8QA/l54i7BAd0+xS9fCZ2aTh26iwHnHuhcyAUWZFfpT
 UVhg25q08DMv2sbJT1FJaWI1XDsl4OAdSxo7oTSSCQyrSL1w0mnnvCQOld2KMU8ygdeMDmQPJcW
 yzbxEU0Hd32Lc5ZffaKRnhP1jXcSyYhlE=
X-Gm-Gg: ASbGncvBa0+gTNYnEQiWtI7+mplUEGD0lKVwuyM5ueDWdBMRn9u7kgS/VPmC/O+q45R
 0i1Jd4M+H1puFBxPUvvTZ2VRvASa1K0wcwI3LZRsi1UECjrDP24qYTR1wpR9Hg5lecPs1RA==
X-Received: by 2002:a05:6102:14a5:b0:4c1:86bc:f959 with SMTP id
 ada2fe7eead31-4e049d56f96mr1635127137.8.1747360080235; 
 Thu, 15 May 2025 18:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG3QjZcdKE09yMblmLyilKFUIaKhnDel7wnoxaGd7fFyebO6J0zzogOauVCQY0jRs16QZ5IwtPut5jStmybeU=
X-Received: by 2002:a05:6102:14a5:b0:4c1:86bc:f959 with SMTP id
 ada2fe7eead31-4e049d56f96mr1635115137.8.1747360079857; Thu, 15 May 2025
 18:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:47:47 +0800
X-Gm-Features: AX0GCFuTzU_mqztvcVL7PYRVdw_fHAtUbHwOwRYO2c2nPUHk2yZKJgKJ5BKc7vM
Message-ID: <CACGkMEt7XAJLteC4KEu4GY6Gc+T6SNRJHU4ocVfzaM9xSnt_Zg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Current memory operations like pinning may take a lot of time at the
> destination.  Currently they are done after the source of the migration i=
s
> stopped, and before the workload is resumed at the destination.  This is =
a
> period where neigher traffic can flow, nor the VM workload can continue
> (downtime).
>
> We can do better as we know the memory layout of the guest RAM at the
> destination from the moment that all devices are initializaed.  So
> moving that operation allows QEMU to communicate the kernel the maps
> while the workload is still running in the source, so Linux can start
> mapping them.
>
> As a small drawback, there is a time in the initialization where QEMU
> cannot respond to QMP etc.  By some testing, this time is about
> 0.2seconds.  This may be further reduced (or increased) depending on the
> vdpa driver and the platform hardware, and it is dominated by the cost
> of memory pinning.
>
> This matches the time that we move out of the called downtime window.
> The downtime is measured as checking the trace timestamp from the moment
> the source suspend the device to the moment the destination starts the
> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> secs to 2.0949.
>
> Future directions on top of this series may include to move more things a=
head
> of the migration time, like set DRIVER_OK or perform actual iterative mig=
ration
> of virtio-net devices.
>
> Comments are welcome.
>
> This series is a different approach of series [1]. As the title does not
> reflect the changes anymore, please refer to the previous one to know the
> series history.
>
> This series is based on [2], it must be applied after it.

Not that this has been merged.

Thanks

>
> [Jonah Palmer]
> This series was rebased after [3] was pulled in, as [3] was a prerequisit=
e
> fix for this series.
>
> v4:
> ---
> * Add memory listener unregistration to vhost_vdpa_reset_device.
> * Remove memory listener unregistration from vhost_vdpa_reset_status.
>
> v3:
> ---
> * Rebase
>
> v2:
> ---
> * Move the memory listener registration to vhost_vdpa_set_owner function.
> * Move the iova_tree allocation to net_vhost_vdpa_init.
>
> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html=
.
>
> [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.=
2540987-1-eperezma@redhat.com/
> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.pal=
mer@oracle.com/
>
> Jonah - note: I'll be on vacation from May 10-19. Will respond to
>               comments when I return.
>
> Eugenio P=C3=A9rez (7):
>   vdpa: check for iova tree initialized at net_client_start
>   vdpa: reorder vhost_vdpa_set_backend_cap
>   vdpa: set backend capabilities at vhost_vdpa_init
>   vdpa: add listener_registered
>   vdpa: reorder listener assignment
>   vdpa: move iova_tree allocation to net_vhost_vdpa_init
>   vdpa: move memory listener register to vhost_vdpa_init
>
>  hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
>  include/hw/virtio/vhost-vdpa.h |  22 ++++++-
>  net/vhost-vdpa.c               |  34 +----------
>  3 files changed, 93 insertions(+), 70 deletions(-)
>
> --
> 2.43.5
>


