Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D30109C047
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5hzG-0003ee-CJ; Thu, 26 Mar 2026 06:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5hzC-0003eU-JK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5hzA-0005du-Dh
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774521042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUqCZYDTXOv/A+SZRc+FyKLv0qXAbdaUTx0UP8iHwbc=;
 b=PYgfwOL0dIYvBPYj45cZpzEzuLZW7Hax/L068aCtDAJUSRiTjEChoTxaXQuF5zfLbmpwnV
 Jo+GJ8y8pukqbomIJjun+eKnYV0x5uY0f6MqTCa+ALysw/bDJ6p35U3n3rQq6Kg4WcmBUB
 M2hfmLJrmaFPO7UPTT6RVYKno/7RY9M=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-RHMwq-lpOBSad2mBxMmSvA-1; Thu, 26 Mar 2026 06:30:41 -0400
X-MC-Unique: RHMwq-lpOBSad2mBxMmSvA-1
X-Mimecast-MFC-AGG-ID: RHMwq-lpOBSad2mBxMmSvA_1774521041
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79878791ec6so19515527b3.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 03:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774521041; cv=none;
 d=google.com; s=arc-20240605;
 b=EO2YKnjevXRJ7TqDVZkQj/JepUtmSybu6BiCfdwqrHwK/V/9uGYj/ln57oT7y6v4Ie
 aNKm1K6OmKMmaaQw6hkso97OgZEmAJR2EajczEhlSMiPbNdUsHZRl4NJLHNCPtfOwbuo
 maYhK96EsLnJgQHZNwceZ3YU8wQcfQ3mSK7ZU/RMZEFD/CdeVbHGXYckvl4GoQLxUfKl
 H/aJrDnwlgk3xgUoJgFD88UzD/tJRqQmiSgBTZhD1/dYXPTTAQL+7bQs9iJlP5aRkiaN
 ezSTL2J8YXJK6Xt6UY2fHy5ZL/q6bbumG6PIo/dfHTg6xJoaM+xhDUuiH0hDs2EmMPFk
 L7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gUqCZYDTXOv/A+SZRc+FyKLv0qXAbdaUTx0UP8iHwbc=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=g6gLO8y3rk1cEBBOkI2twCPVEiWjZkL8E74vNvsTlAWwpANPY1iOR60wOW7snqbLnl
 IM1Pso4sIShwkoJN3f8/7MbAoAGHsAR6qGB3HInXE31Vwi1iPIauicxRgapMqBBZk7hc
 r0XFZa4ypT7K05qbVkss1+exSoFFT0jrIV4EYkkyBzTcFkDpqc2Jczi2BxknO4aDOtsV
 A0OVujcr81XCFP+P1NA79G46fJM1zLd8GVXj9cX3fwL5bC9Z8rLvPqPdr7NziHrVbtvG
 WqQl8jq6kaPDZr+0xZEfcJGcVIlrKw7kSagwXLEjD7isleXiJrG9DEvikj7cznnyURKG
 bpxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774521041; x=1775125841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUqCZYDTXOv/A+SZRc+FyKLv0qXAbdaUTx0UP8iHwbc=;
 b=myF0rpbLFGhdRhw8H1BnIOBiwk6wqSnINSJldrOGnDlg8c2O7eErSHHYwpjmQrgQEZ
 Pr7+G88FMVbdHIEje94/hFIohts8Lcf834xyuk/rW/gr0u+kdCTfwyoHSxx4YKTblJ0b
 8PGbwzE2VZIL4yXBDu6vsiSsgrUlxAc+0dM+xoBZ2GXJzM4WoO4U/lCQkk2IyvggaS1C
 Lz82g1nzMmITgJlPFeHhogJ69nz+T2kHKnRR32mHtghJsNP7joZ1z4vciqEkx0QMUm5A
 En/KkfiVKIQUtYedmSW6f3o7YuWMoWsbtnFpOX9SnzRf78NY8mVXoSQ1m6wiHJWXbE2o
 6Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774521041; x=1775125841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gUqCZYDTXOv/A+SZRc+FyKLv0qXAbdaUTx0UP8iHwbc=;
 b=HqSDfOwTR28eH/iWUvfJoKXQj7WVz6fC6KbWNl7y3rJTbesYmM6Exua5C/X2oRQA0f
 eLfBDXvsmUGKy4lS34sWbA0JvjfXoxcrNUSL6T9aBJ4b8Xe1XkdwH/O7kTfM3gFxC8rW
 iUbZznYuCaa7pW2M37C/t2WcWkz8maIEvPbF1+Noi4vHI66MUVCka4ztEPo2OJxnnCeL
 SmHx7Cj0hJWi7JsoP8ndi2mLE7a10nYQ9D22SrqFO//ggEmewvwCG1HQ9rP176LTlASa
 iUJmp1XiGTL7eajiNTrPktfH3Oy7ldj/VDbvq7mDxbXMbytEQPrHUOPHmdHd1K18W3Gx
 9GdQ==
X-Gm-Message-State: AOJu0YwZ0gn5hE1qOYeoD4WiDlkk2H4wSuesD24xp86Rd3uIMm2/kuEw
 yVDutvouLXbO7jU0nSLWZFrV8XIQIDDI4M34Z4HPnoNpiQ4UWm3zkofwMcMQ7NBFwbMyUpQXUlU
 2l4URklC4QdoFFoVxdb2DMGDo0jZ/ldyVpvYDC3RCZx4lJtMPfQqneqHX+iQtHqzRSMlIDVYzd5
 b7oEHe1SjIXw57v/hUaRhUinmIkhwXkSQ=
X-Gm-Gg: ATEYQzxyRt8Dpj33YStNojIr8YPeSYNr9DVbRZC8cvtALDmlabfNCNPk0EsEvK71e88
 2LuY3g5dlCPlwvR37n9hOT6nJmjBMu4uQHDo0y/Kcmws6fpu4F8eYPet/KaoR8gJ49CL0my/Gvx
 nz8aVyhZUGIQ/r6o57ZUuzbD9VtLHB/O/D1XJuaaOUVxONA7Wnk+R9NMwynrJMnvgoMOKmUiOrc
 NddKg==
X-Received: by 2002:a05:690e:1283:b0:649:45c2:6d62 with SMTP id
 956f58d0204a3-64ee6083d18mr6503934d50.5.1774521040372; 
 Thu, 26 Mar 2026 03:30:40 -0700 (PDT)
X-Received: by 2002:a05:690e:1283:b0:649:45c2:6d62 with SMTP id
 956f58d0204a3-64ee6083d18mr6503881d50.5.1774521039623; Thu, 26 Mar 2026
 03:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-14-jonah.palmer@oracle.com>
 <CAJaqyWeSr42GwqG82hWcj5Etpde0Kz8no1TMwFbVeuCazQghJA@mail.gmail.com>
 <428614fa-3903-4d42-a0d7-cf8aa977679d@oracle.com>
In-Reply-To: <428614fa-3903-4d42-a0d7-cf8aa977679d@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Mar 2026 11:30:03 +0100
X-Gm-Features: AaiRm52xdMj0kE34s8I1-YyakotQUBdWY7SKwvuhmP-wGV_63XgZtFO-JaGn5ic
Message-ID: <CAJaqyWe9Y=vLaN7k0yhf-dOTH2davRW3eT5ZMBz-k4oSq5=3Lw@mail.gmail.com>
Subject: Re: [RFC v2 13/14] virtio-net: detect pending Tx work for VQs
 mid-migration changes
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Tue, Mar 24, 2026 at 5:48=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/24/26 7:35 AM, Eugenio Perez Martin wrote:
> > On Fri, Mar 20, 2026 at 3:21=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Track per-queue pending Tx work state during early migration time.
> >>
> >> This includes a snapshot of pending Tx state for active queue pairs,
> >> checking for deltas at the end of migration, and freeing the snapshot
> >> buffer during device unrealize.
> >>
> >> With this final delta signal in place, drop the temporary always-true
> >> fallback in virtio_net_has_delta and return false when no deltas are
> >> found.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/net/virtio-net.c            | 26 +++++++++++++++++++++-----
> >>   include/hw/virtio/virtio-net.h |  2 ++
> >>   2 files changed, 23 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 3ee49a043a..483a43be4f 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -3943,6 +3943,14 @@ static int virtio_net_early_pre_save(void *opaq=
ue)
> >>       vnet_mig->mq_early =3D n->multiqueue;
> >>       vnet_mig->queue_pairs_early =3D n->curr_queue_pairs;
> >>
> >> +    /* Tx waiting snapshot for active queue pairs */
> >> +    if (!vnet_mig->tx_waiting_early) {
> >> +        vnet_mig->tx_waiting_early =3D g_new0(uint32_t, n->max_queue_=
pairs);
> >> +    }
> >> +    for (int i =3D 0; i < n->curr_queue_pairs; i++) {
> >> +        vnet_mig->tx_waiting_early[i] =3D n->vqs[i].tx_waiting;
> >> +    }
> >> +
> >>       /* RSS state snapshot */
> >>       vnet_mig->rss_enabled_early =3D n->rss_data.enabled;
> >>       vnet_mig->rss_redirect_early =3D n->rss_data.redirect;
> >> @@ -4254,6 +4262,8 @@ static void virtio_net_device_unrealize(DeviceSt=
ate *dev)
> >>           n->migration->mtable_macs_early =3D NULL;
> >>           g_free(n->migration->vlans_early);
> >>           n->migration->vlans_early =3D NULL;
> >> +        g_free(n->migration->tx_waiting_early);
> >> +        n->migration->tx_waiting_early =3D NULL;
> >>           g_free(n->migration->rss_indirections_table_early);
> >>           n->migration->rss_indirections_table_early =3D NULL;
> >>           g_free(n->migration);
> >> @@ -4412,6 +4422,16 @@ static bool virtio_net_has_delta(VirtIONet *n, =
VirtIODevice *vdev)
> >>           return true;
> >>       }
> >>
> >> +    /* Has any active queue's tx_waiting changed? */
> >> +    if (!vnet_mig->tx_waiting_early) {
> >> +        return true;
> >> +    }
> >> +    for (int i =3D 0; i < n->curr_queue_pairs; i++) {
> >> +        if (n->vqs[i].tx_waiting !=3D vnet_mig->tx_waiting_early[i]) =
{
> >> +            return true;
> >> +        }
> >> +    }
> >> +
> >>       /* Has the VirtIONet's RSS state changed? */
> >>       if (n->rss_data.enabled !=3D vnet_mig->rss_enabled_early ||
> >>           n->rss_data.redirect !=3D vnet_mig->rss_redirect_early ||
> >> @@ -4439,11 +4459,7 @@ static bool virtio_net_has_delta(VirtIONet *n, =
VirtIODevice *vdev)
> >>           }
> >>       }
> >>
> >> -    /*
> >> -     * Always return true for now until we're able to detect all poss=
ible
> >> -     * changes to a VirtIONet device.
> >> -     */
> >> -    return true;
> >> +    return false;
> >
> > I'm failing to see one thing: If we add a new feature that the guest
> > can change during migration and it's only added in the
> > VMStateDescription vmstate_virtio_net_device, will this "return false"
> > prevent the state from being resent in the stop-and-copy phase?
> >
> > Mandating its addition here is ok somehow, but I'm not sure if I'm
> > missing something.
> >
>
> Correct. But this is also the same case today. That is, any new
> migratable device state would still need to be added to the appropriate
> VMSD/subsection. For example, if today we added a new member to
> VirtIONet that also should be migrated, it would also need to be added
> to vmstate_virtio_net_device (or the appropriate subsection).
>
> So it's not a new *kind* of maintenance burden, but it is an additional
> place that'd need to be updated.
>

Right, we're on the same page.

Half-baked idea: Is it possible to update it only in
vmstate_virtio_net_device? I'm thinking in a method to store only the
relevant fields by iterating vmstate_virtio_net_device, instead of
manually coding each if (n->field !=3D vnet_mig->field) return true.

> >>   }
> >>
> >>   static bool virtio_net_needed(void *opaque)
> >> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio=
-net.h
> >> index 88074a0976..dbbacc83bb 100644
> >> --- a/include/hw/virtio/virtio-net.h
> >> +++ b/include/hw/virtio/virtio-net.h
> >> @@ -180,6 +180,7 @@ typedef struct VirtIONetQueue {
> >>    * @guest_offloads_early: Guest offloads snapshot.
> >>    * @mq_early: Multiqueue state snapshot.
> >>    * @queue_pairs_early: Queue pairs snapshot.
> >> + * @tx_waiting_early: Per-queue pending-Tx snapshot.
> >>    * @rss_enabled_early: RSS enabled flag.
> >>    * @rss_redirect_early: RSS redirect flag.
> >>    * @rss_populate_hash_early: RSS populate hash flag.
> >> @@ -201,6 +202,7 @@ typedef struct VirtIONetMigration {
> >>       uint64_t guest_offloads_early;
> >>       int mq_early;
> >>       uint16_t queue_pairs_early;
> >> +    uint32_t *tx_waiting_early;
> >>       bool rss_enabled_early;
> >>       bool rss_redirect_early;
> >>       bool rss_populate_hash_early;
> >> --
> >> 2.51.0
> >>
> >
>


