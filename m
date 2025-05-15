Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345C4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTzh-0006TT-Ax; Thu, 15 May 2025 04:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uFTzf-0006RO-9A
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uFTzc-0003wI-RP
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747297862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZLgyKHZw0iMM6E4FRjx4C6j3vpnVXNVUXE3eQqndgs=;
 b=eH5yAiWZTvJLu1Q2/r/BtbEyHJmtBPJJtZuPXxduqZBVaRj1R9SeosR6/L1bPPKUrn1Vr5
 tCR+Ogog3g8cRczzzxVGTbB12ltXvOYfj/w0plmk3q/eksgcmv8sjNo0cDmVAZ2qGXdz21
 RGE0w/qia/i1OtDPRMZE2qtqCIKjqfY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-9BEAip1PM2-K1nq48A8lzA-1; Thu, 15 May 2025 04:31:00 -0400
X-MC-Unique: 9BEAip1PM2-K1nq48A8lzA-1
X-Mimecast-MFC-AGG-ID: 9BEAip1PM2-K1nq48A8lzA_1747297860
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30c14d46b55so1205890a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 01:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747297860; x=1747902660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZLgyKHZw0iMM6E4FRjx4C6j3vpnVXNVUXE3eQqndgs=;
 b=p+NgmhqE+c/GvVARahGrNHKkiFnV/rjKUE9X2AYA2O6/kjMZT8hJFGPK7bD5Sdb5uv
 JvXPHs1fwEQHUsmurzbHCe7NVJdldm6WfR1wAEpCOCXpjhehm7pyz5HUQ3Kj8tq2jNEK
 Mfe32yjI043SCbjt4g0RRt5Sqd4sKVbBZl6bpNufolmBEMby+X4xnkkCZ/369mZf9gs0
 evLQZhP+7LEXiKUHyG7UKLisoJjL5kvKRRW21F6Z3yxg6Dfylwwl86RAFjMV1OJcOUSU
 /8DccohmuZThPK7YvJzMD+Osw5AfpUWhhgaqeN3Fx/AIKoIXrIACfdL7km3TE2KwD5JJ
 Tgsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWprOdEiECctuXuaoMyyNKKU6XWu9+vbbafQ9Ux9wOeBLv09qtlKsYREO7kSsfmzfAYCvy0mEpIkgMT@nongnu.org
X-Gm-Message-State: AOJu0YwKLwXIY0cfchFRtGUxGAcAAV5lKxNHTsg66d56yDmsmR+TyEvp
 W5c0thMHWEWLRM/DWDcMLb6P9Bcz2SVRSCDXlwpalMmAQuHLQNfMz+GgQPqh2K8kb0CcS3QBYHS
 WfmO5bPmQ7R8jSDhMlMtrsso5VzRLsazKPZQZrNyvXyNrrY2XbZXRKF63w776sfpO0Rtn1kd8PS
 hZjPHhPISnI+mgXZNEvr3Ovx5+ufc=
X-Gm-Gg: ASbGncuZdXkFLkH16IdjheRQSjV8eF5gi9oKsWkv9gYQt3d+W4kpbrSfgLAARi4tyPM
 wJJZlFKPNAG3OiZekhypu5ZzVK2hBENUJ38WC6Ak78+m05KfLfTVvVVvmArGZcNPJFBB9
X-Received: by 2002:a17:90a:e704:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-30e2e62fd2bmr9133444a91.32.1747297859754; 
 Thu, 15 May 2025 01:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcFrf+dFU+1BuBohqknfUtGERXxroSTfJtljMPBiatWE6XS+ZIlm5FYSFB4oYrwzPgnMyPqbH3ZGtngnnm4UY=
X-Received: by 2002:a17:90a:e704:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-30e2e62fd2bmr9133413a91.32.1747297859320; Thu, 15 May 2025
 01:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
 <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
In-Reply-To: <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 May 2025 10:30:22 +0200
X-Gm-Features: AX0GCFv0oOU13UYATxyXTm0O5e-eByfYvM4sGr8h23gkyupZU_XLDevCz7L7P2k
Message-ID: <CAJaqyWdc23b54RFzswcSr0p9TOh36jAVpbFev3-payJ6_rCB2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, 
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Thu, May 15, 2025 at 2:17=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Hi Eugenio,
>
> On 5/14/2025 8:49 AM, Eugenio Perez Martin wrote:
> > On Wed, May 7, 2025 at 8:47=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >> Current memory operations like pinning may take a lot of time at the
> >> destination.  Currently they are done after the source of the migratio=
n is
> >> stopped, and before the workload is resumed at the destination.  This =
is a
> >> period where neigher traffic can flow, nor the VM workload can continu=
e
> >> (downtime).
> >>
> >> We can do better as we know the memory layout of the guest RAM at the
> >> destination from the moment that all devices are initializaed.  So
> >> moving that operation allows QEMU to communicate the kernel the maps
> >> while the workload is still running in the source, so Linux can start
> >> mapping them.
> >>
> >> As a small drawback, there is a time in the initialization where QEMU
> >> cannot respond to QMP etc.  By some testing, this time is about
> >> 0.2seconds.  This may be further reduced (or increased) depending on t=
he
> >> vdpa driver and the platform hardware, and it is dominated by the cost
> >> of memory pinning.
> >>
> >> This matches the time that we move out of the called downtime window.
> >> The downtime is measured as checking the trace timestamp from the mome=
nt
> >> the source suspend the device to the moment the destination starts the
> >> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> >> secs to 2.0949.
> >>
> > Hi Jonah,
> >
> > Could you update this benchmark? I don't think it changed a lot but
> > just to be as updated as possible.
> Jonah is off this week and will be back until next Tuesday, but I recall
> he indeed did some downtime test with VM with 128GB memory before taking
> off, which shows obvious improvement from around 10 seconds to 5.8
> seconds after applying this series. Since this is related to update on
> the cover letter, would it be okay for you and Jason to ack now and then
> proceed to Michael for upcoming merge?
>

Oh yes that's what I meant, I should have been more explicit about that :).


> >
> > I think I cannot ack the series as I sent the first revision. Jason or
> > Si-Wei, could you ack it?
> Sure, I just give my R-b, this series look good to me. Hopefully Jason
> can ack on his own.
>
> Thanks!
> -Siwei
>
> >
> > Thanks!
> >
> >> Future directions on top of this series may include to move more thing=
s ahead
> >> of the migration time, like set DRIVER_OK or perform actual iterative =
migration
> >> of virtio-net devices.
> >>
> >> Comments are welcome.
> >>
> >> This series is a different approach of series [1]. As the title does n=
ot
> >> reflect the changes anymore, please refer to the previous one to know =
the
> >> series history.
> >>
> >> This series is based on [2], it must be applied after it.
> >>
> >> [Jonah Palmer]
> >> This series was rebased after [3] was pulled in, as [3] was a prerequi=
site
> >> fix for this series.
> >>
> >> v4:
> >> ---
> >> * Add memory listener unregistration to vhost_vdpa_reset_device.
> >> * Remove memory listener unregistration from vhost_vdpa_reset_status.
> >>
> >> v3:
> >> ---
> >> * Rebase
> >>
> >> v2:
> >> ---
> >> * Move the memory listener registration to vhost_vdpa_set_owner functi=
on.
> >> * Move the iova_tree allocation to net_vhost_vdpa_init.
> >>
> >> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.h=
tml.
> >>
> >> [1] https://patchwork.kernel.org/project/qemu-devel/cover/202312151728=
30.2540987-1-eperezma@redhat.com/
> >> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.htm=
l
> >> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.=
palmer@oracle.com/
> >>
> >> Jonah - note: I'll be on vacation from May 10-19. Will respond to
> >>                comments when I return.
> >>
> >> Eugenio P=C3=A9rez (7):
> >>    vdpa: check for iova tree initialized at net_client_start
> >>    vdpa: reorder vhost_vdpa_set_backend_cap
> >>    vdpa: set backend capabilities at vhost_vdpa_init
> >>    vdpa: add listener_registered
> >>    vdpa: reorder listener assignment
> >>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
> >>    vdpa: move memory listener register to vhost_vdpa_init
> >>
> >>   hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++----------=
--
> >>   include/hw/virtio/vhost-vdpa.h |  22 ++++++-
> >>   net/vhost-vdpa.c               |  34 +----------
> >>   3 files changed, 93 insertions(+), 70 deletions(-)
> >>
> >> --
> >> 2.43.5
> >>
>


