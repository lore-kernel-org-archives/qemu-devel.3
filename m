Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E755AFF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7TNl-0006sv-8r; Tue, 31 Mar 2026 03:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7TNc-0006pS-Pt
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7TNa-00047R-98
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774941553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te5Obr/t6PzsDGu/QkLP3n2kaT54jNTZv5VGlu8NH80=;
 b=LkkGUtX+InzgLNDJX9q91jkk13zsZa51xcNdWxxUr2oZvaMtBwkq47oFVXoVJ/MNqaX0LB
 2O49Q+Iafx4CDcJTqJ+h6erDOnuPGCEZI6IWnKe9Z5i8q3yVXyWR+wyzuEHDgzLGsrGvlO
 wdONxQWDvtHhSnQuX8FfX7lKhwqzWtk=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-si6V_HasMu-vnd0BkT0NbA-1; Tue, 31 Mar 2026 03:19:11 -0400
X-MC-Unique: si6V_HasMu-vnd0BkT0NbA-1
X-Mimecast-MFC-AGG-ID: si6V_HasMu-vnd0BkT0NbA_1774941551
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6501528b1caso4420427d50.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 00:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774941551; cv=none;
 d=google.com; s=arc-20240605;
 b=EumG9Kt6JWDT6Qc+DmN/S9mBcn3vlIrzYJDgcRt4ZhuyDlK0lkm1STWi1hqseJYIxT
 Egfcmy/uSGuiwKc0IRtY55+dgigKkX66ag9qrmX/v1HeGBEAAk8tFXCtax8QJHFFbTI6
 O4MukBic8D+QXBmngKZiaZ20yW33m+vQ6GBpIuYnmYq7a8m4HvaRPwi7njgKqn6g8mW3
 ho87opCbzs7CJF/ga2B91oNUi29KLtQkiguzXtR6mATeWDYeJP2y71IYrSoZ8HFMgcrq
 NvcmwCjqkWJ8KYtN4QCUVEv8X9seWG/fYH+EJrh7TIMo/qmFLjqCvUK78vljSfKTSFs9
 OlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Te5Obr/t6PzsDGu/QkLP3n2kaT54jNTZv5VGlu8NH80=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=gWf7yOBOTyFrI3DN2dD6+NKE0GRsx7RHQfce2oL61NRx5NShALh0hwuWKywWbPrVTq
 p1dwmFSLljY/kioEc5XCMXiWeVidIiNJurnK3AZOikJ9dpoqCnLhSrhT+K2CStsnnKrh
 lGJUvNU1RmeJN56MOhg7xOzsZKCVAGcfP4vZG+Xc5ojqyI07C3Q2Vcq+yLyDpp4kGtkJ
 f91C1vTv+vNJ4gmFUBLrGTCQpF8lJAtSX5OkJG/+8BYHW+uR8TMVRSBYmvvKH6waNC8n
 RLh9O3IMzG4kYn2RiUqpPB2nqOQiK0k1dWlfH8oJFqG+divPMW6bj4r1wKxGkAf4VCBy
 aLKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774941551; x=1775546351; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te5Obr/t6PzsDGu/QkLP3n2kaT54jNTZv5VGlu8NH80=;
 b=nlbQRkua4ZsU5FsxGHL29GxsHSJVVo4Jl/k6kH6Gqkuif2RbptvTfyQ/9jp+r3T2/c
 xzCioJ4xthZbyRTWeiEZE1Z+aJXIrXYNd6biAujSRbEFMcZ8z2kH9HSO5jihGCCOPlSh
 7NhKGOJbQZ1YOI42ApbuNHfCWOMUJ77EK0d1DmqPekbruetfLyegJa1f1B31ny+pZK5A
 7qinLarFW1CfcXZq0gQFtsrG1Mgbvv4T9+G9M/2H6SE6MkbVVLF4RDTas8JTxzRlESLH
 Pb+4Sd6/eNEntdzjGmi2FBZQduasnwAjvxWXo6SsxpXm2mKjdImt5F9yyV7w67BYCL5V
 heBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774941551; x=1775546351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Te5Obr/t6PzsDGu/QkLP3n2kaT54jNTZv5VGlu8NH80=;
 b=TxeQ6fJX5uz+IzpqMS8R6MGamCZFtF8kpLDI6UPbmqQ08rmFjrSK+Gq19pR6mAUJG/
 t8q8H4W3StRyddHdnyxv1W18gCcRveijJ5F3apW5TQOyMB1TURlj9P8UJrFg7EKt1yYd
 Cm2x3qqk6i6or2fz4ZA2++5qX9ss/i+9NEA09rqdZ+Fxb2ePCRr675xG9QRIEjVQTLnX
 75DUNESgDa351ZCWHl/lzNwk4QluxBTgEdcaYj2pGImJUApHTB9gqNzuCH3n5XBTQrur
 MF44rMbxWfkQkZHdeDciBn5M5eGxW/I67WoSJ8KnpcNrr2YxN/w/XCAdLzrV1hxRpuQK
 R0Ig==
X-Gm-Message-State: AOJu0YyUkPc5sa5ydv0Qpv+93HWYjoaM73lBsBZ9yJRiJn6DhiEFKkZO
 XrFW9NHZFFH5QIDSg7tW9BoVxW4NmWWGIwmn5vh+twxzsSlH2brHZ4KHLXt3z7EJbPI6TAdPJaZ
 8bUkR+jEU4jDRhAEP0HmuwW9RYmg87shDaMkeqQXerk33DCEiTY+NM9OzkQCApFtCyzaRyJm3Ey
 EX1qWi/uYOz/EgAXrtr7gf9ELq+xY16dw=
X-Gm-Gg: ATEYQzyjIaS4gpmQKgHgmLuJL+kVPJH0EWTTa+qFmHk9eRVXakL31Yj2Upma2Dfq+gF
 fPrJYzCP1gDUH//sE+ewpwlRca49d9eews8djzg43F/Xsyz/1aXFDWD/FrP+AuWep/vpkoQsctN
 C1PZhf8suGh2WDTCKHnnVrFJfA4iALcbXYKIxFFWUty0wCk1rTS58L25XVzK1D2EKrfRlbahotr
 J+SkQ==
X-Received: by 2002:a05:690e:1242:b0:650:1ddf:32bc with SMTP id
 956f58d0204a3-6501ddf34e3mr5510236d50.33.1774941550725; 
 Tue, 31 Mar 2026 00:19:10 -0700 (PDT)
X-Received: by 2002:a05:690e:1242:b0:650:1ddf:32bc with SMTP id
 956f58d0204a3-6501ddf34e3mr5510213d50.33.1774941550259; Tue, 31 Mar 2026
 00:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-14-jonah.palmer@oracle.com>
 <CAJaqyWeSr42GwqG82hWcj5Etpde0Kz8no1TMwFbVeuCazQghJA@mail.gmail.com>
 <428614fa-3903-4d42-a0d7-cf8aa977679d@oracle.com>
 <CAJaqyWe9Y=vLaN7k0yhf-dOTH2davRW3eT5ZMBz-k4oSq5=3Lw@mail.gmail.com>
 <0f56e41a-8542-4ce9-8fa6-b868ed6f7c2e@oracle.com>
In-Reply-To: <0f56e41a-8542-4ce9-8fa6-b868ed6f7c2e@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 31 Mar 2026 09:18:34 +0200
X-Gm-Features: AQROBzDSk-g6Auli2JrJhcKyYnVA7C_Ia56MKjvYRvEYd9jqtO0Zt8AeZQJZhCA
Message-ID: <CAJaqyWer3LKrFtFZibAu78OkeSi0rJ5Tkh81JWm6hKa1sZ10Pw@mail.gmail.com>
Subject: Re: [RFC v2 13/14] virtio-net: detect pending Tx work for VQs
 mid-migration changes
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 30, 2026 at 4:06=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/26/26 6:30 AM, Eugenio Perez Martin wrote:
> > On Tue, Mar 24, 2026 at 5:48=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >>
> >> On 3/24/26 7:35 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Mar 20, 2026 at 3:21=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>> Track per-queue pending Tx work state during early migration time.
> >>>>
> >>>> This includes a snapshot of pending Tx state for active queue pairs,
> >>>> checking for deltas at the end of migration, and freeing the snapsho=
t
> >>>> buffer during device unrealize.
> >>>>
> >>>> With this final delta signal in place, drop the temporary always-tru=
e
> >>>> fallback in virtio_net_has_delta and return false when no deltas are
> >>>> found.
> >>>>
> >>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>> ---
> >>>>    hw/net/virtio-net.c            | 26 +++++++++++++++++++++-----
> >>>>    include/hw/virtio/virtio-net.h |  2 ++
> >>>>    2 files changed, 23 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>>> index 3ee49a043a..483a43be4f 100644
> >>>> --- a/hw/net/virtio-net.c
> >>>> +++ b/hw/net/virtio-net.c
> >>>> @@ -3943,6 +3943,14 @@ static int virtio_net_early_pre_save(void *op=
aque)
> >>>>        vnet_mig->mq_early =3D n->multiqueue;
> >>>>        vnet_mig->queue_pairs_early =3D n->curr_queue_pairs;
> >>>>
> >>>> +    /* Tx waiting snapshot for active queue pairs */
> >>>> +    if (!vnet_mig->tx_waiting_early) {
> >>>> +        vnet_mig->tx_waiting_early =3D g_new0(uint32_t, n->max_queu=
e_pairs);
> >>>> +    }
> >>>> +    for (int i =3D 0; i < n->curr_queue_pairs; i++) {
> >>>> +        vnet_mig->tx_waiting_early[i] =3D n->vqs[i].tx_waiting;
> >>>> +    }
> >>>> +
> >>>>        /* RSS state snapshot */
> >>>>        vnet_mig->rss_enabled_early =3D n->rss_data.enabled;
> >>>>        vnet_mig->rss_redirect_early =3D n->rss_data.redirect;
> >>>> @@ -4254,6 +4262,8 @@ static void virtio_net_device_unrealize(Device=
State *dev)
> >>>>            n->migration->mtable_macs_early =3D NULL;
> >>>>            g_free(n->migration->vlans_early);
> >>>>            n->migration->vlans_early =3D NULL;
> >>>> +        g_free(n->migration->tx_waiting_early);
> >>>> +        n->migration->tx_waiting_early =3D NULL;
> >>>>            g_free(n->migration->rss_indirections_table_early);
> >>>>            n->migration->rss_indirections_table_early =3D NULL;
> >>>>            g_free(n->migration);
> >>>> @@ -4412,6 +4422,16 @@ static bool virtio_net_has_delta(VirtIONet *n=
, VirtIODevice *vdev)
> >>>>            return true;
> >>>>        }
> >>>>
> >>>> +    /* Has any active queue's tx_waiting changed? */
> >>>> +    if (!vnet_mig->tx_waiting_early) {
> >>>> +        return true;
> >>>> +    }
> >>>> +    for (int i =3D 0; i < n->curr_queue_pairs; i++) {
> >>>> +        if (n->vqs[i].tx_waiting !=3D vnet_mig->tx_waiting_early[i]=
) {
> >>>> +            return true;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>>        /* Has the VirtIONet's RSS state changed? */
> >>>>        if (n->rss_data.enabled !=3D vnet_mig->rss_enabled_early ||
> >>>>            n->rss_data.redirect !=3D vnet_mig->rss_redirect_early ||
> >>>> @@ -4439,11 +4459,7 @@ static bool virtio_net_has_delta(VirtIONet *n=
, VirtIODevice *vdev)
> >>>>            }
> >>>>        }
> >>>>
> >>>> -    /*
> >>>> -     * Always return true for now until we're able to detect all po=
ssible
> >>>> -     * changes to a VirtIONet device.
> >>>> -     */
> >>>> -    return true;
> >>>> +    return false;
> >>>
> >>> I'm failing to see one thing: If we add a new feature that the guest
> >>> can change during migration and it's only added in the
> >>> VMStateDescription vmstate_virtio_net_device, will this "return false=
"
> >>> prevent the state from being resent in the stop-and-copy phase?
> >>>
> >>> Mandating its addition here is ok somehow, but I'm not sure if I'm
> >>> missing something.
> >>>
> >>
> >> Correct. But this is also the same case today. That is, any new
> >> migratable device state would still need to be added to the appropriat=
e
> >> VMSD/subsection. For example, if today we added a new member to
> >> VirtIONet that also should be migrated, it would also need to be added
> >> to vmstate_virtio_net_device (or the appropriate subsection).
> >>
> >> So it's not a new *kind* of maintenance burden, but it is an additiona=
l
> >> place that'd need to be updated.
> >>
> >
> > Right, we're on the same page.
> >
> > Half-baked idea: Is it possible to update it only in
> > vmstate_virtio_net_device? I'm thinking in a method to store only the
> > relevant fields by iterating vmstate_virtio_net_device, instead of
> > manually coding each if (n->field !=3D vnet_mig->field) return true.
> >
>
> In the next version of this series, the different delta states will be
> explicit sub-VMSDs so that the destination is updated only for the
> specific state that changed, e.g.:
>
> static const VMStateDescription vmstate_virtio_net_delta =3D {
>      .name =3D "virtio-net-delta",
>      .minimum_version_id =3D 1,
>      .version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_END_OF_LIST()
>      },
>      .subsections =3D (const VMStateDescription * const []) {
>          &vmstate_virtio_net_delta_status,
>          &vmstate_virtio_net_delta_mac,
>          &vmstate_virtio_net_delta_mac_table,
>          &vmstate_virtio_net_delta_rx_filter,
>          &vmstate_virtio_net_delta_vlan_filter,
>          &vmstate_virtio_net_delta_guest_offloads,
>          &vmstate_virtio_net_delta_mq,
>          &vmstate_virtio_net_delta_tx_waiting,
>          &vmstate_virtio_net_delta_rss,
>          NULL
>      },
> };
>
> static bool virtio_net_delta_status_needed(void *opaque)
> {
>      VirtIONet *n =3D opaque;
>      VirtIONetMigration *vnet_mig =3D n->migration;
>
>      assert(vnet_mig);
>
>      return n->status !=3D vnet_mig->status_early;
> }
>
> static const VMStateDescription vmstate_virtio_net_delta_status =3D {
>      .name =3D "virtio-net-delta/status",
>      .minimum_version_id =3D 1,
>      .version_id =3D 1,
>      .needed =3D virtio_net_delta_status_needed,
>      .post_load =3D virtio_net_delta_status_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT16(status, VirtIONet),
>          VMSTATE_END_OF_LIST()
>      },
> };
>
> ------
>
> While this approach wouldn't fully automate delta detection and fully
> eliminate maintenance requirements, it should help a bit. Maintenance
> then would look like "add base state + delta VMSD subsection (if mutable
> after early send)".
>
> With your idea though, we could automate that delta detection part, but
> I still think we'd need these delta sub-VMSDs to tell it how to properly
> update the destination.
>

Right. Maybe it is worth to add .needed on potentially big fields
(VLAN bits, mac filtering, etc)

> >>>>    }
> >>>>
> >>>>    static bool virtio_net_needed(void *opaque)
> >>>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virt=
io-net.h
> >>>> index 88074a0976..dbbacc83bb 100644
> >>>> --- a/include/hw/virtio/virtio-net.h
> >>>> +++ b/include/hw/virtio/virtio-net.h
> >>>> @@ -180,6 +180,7 @@ typedef struct VirtIONetQueue {
> >>>>     * @guest_offloads_early: Guest offloads snapshot.
> >>>>     * @mq_early: Multiqueue state snapshot.
> >>>>     * @queue_pairs_early: Queue pairs snapshot.
> >>>> + * @tx_waiting_early: Per-queue pending-Tx snapshot.
> >>>>     * @rss_enabled_early: RSS enabled flag.
> >>>>     * @rss_redirect_early: RSS redirect flag.
> >>>>     * @rss_populate_hash_early: RSS populate hash flag.
> >>>> @@ -201,6 +202,7 @@ typedef struct VirtIONetMigration {
> >>>>        uint64_t guest_offloads_early;
> >>>>        int mq_early;
> >>>>        uint16_t queue_pairs_early;
> >>>> +    uint32_t *tx_waiting_early;
> >>>>        bool rss_enabled_early;
> >>>>        bool rss_redirect_early;
> >>>>        bool rss_populate_hash_early;
> >>>> --
> >>>> 2.51.0
> >>>>
> >>>
> >>
> >
>


