Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88625FF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SoU-0003Jt-0B; Tue, 31 Mar 2026 02:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7SoR-0003Hk-N0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7SoP-0007Ch-Mq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774939372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7GKaQ+BmdJBqZzJtYoeMsx+AwcU6n06TFl5Qjg+seA=;
 b=Q1HK4FnuzPd7BKGcq/kCBBDjU4ZPsN/lRzv6d5kFEQfamKot/QjLiLJ9PoUXNQlM4m5nfN
 YgkgipINhIxuMw6f3Rd9pJWb32eu9rsYweErOVEcv6ZUF9cm8fXjQkfP2FXTUoXWH+ILW6
 Padsu1ZdrsuamFrM3E2F/qN5TTts9DU=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-mtnEofDFOWmEJ4zGBtHJ5g-1; Tue, 31 Mar 2026 02:42:49 -0400
X-MC-Unique: mtnEofDFOWmEJ4zGBtHJ5g-1
X-Mimecast-MFC-AGG-ID: mtnEofDFOWmEJ4zGBtHJ5g_1774939369
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6501d242e5cso4130188d50.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 23:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774939368; cv=none;
 d=google.com; s=arc-20240605;
 b=TvptLGYIDNx920AMkVj/dbdUL4GXUkkgWbhRP1M7tpB+YwJa4ZYXEP7d7vMfTHTd0G
 CNoh/cC8yjE/kEi32/vieQcjfTQibuWp58TYhuolmpeTAo8Xf3JwlmEo15HRvpKfeFqD
 P7DuT/kQvWw1IKg71ZLpNjgB2YpIeVcCoVMvZB9GVYBZXeoTiZErDjZ2p21TKFXkPxlr
 HTxvJ+xPvmF1zfGZkgWX1MBIKw3MHPGAryoDkviXq3vNNFjr+XZ0zpqW0pJlDt7QKXzc
 BJGI8K8h4qnkEB/ZmFDoNSr+lgVC8uU5zs3EBWjCn9/lKlUg3kzSvmvyUJTi2yH7B8YR
 gGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G7GKaQ+BmdJBqZzJtYoeMsx+AwcU6n06TFl5Qjg+seA=;
 fh=YABNQfmvUMl7qMn0Pg+rjVUhb9BD90dDpz1/2AdAcYo=;
 b=YjpK43P3tcxsCb1VdGydsjuAQRFijYC3YObHOYIFwgsV2NW3OrBmxKZFQfiFvAT48z
 2vANpT6jId8BDgimEziCS3hwZ98Cbb0/FlVl6KEaXZ3srR5qveJ5eVde94kUDjVVsM/W
 jFkN5A1kk+93xOSCSdponSH7wAUyk6ai0w5b75wzG7k9sMBmEbUe/60DWtar2Reoplcg
 IZoGLUnd5xLegy96zpf9Y1IDGcU++cAj3LTM76sKsR3/0IA3YlnXVryf3xrgK49hn3KE
 KRfV6IFhjv2m4MjkdQttgME3ej4zPJ0JmZMWmo42/PYCGIYKb3YvJfJ9+iZUFu4Fakjs
 dthw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774939368; x=1775544168; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7GKaQ+BmdJBqZzJtYoeMsx+AwcU6n06TFl5Qjg+seA=;
 b=J4aJ6hgnISr+Js4SWsEwQImdhyqopRyoWtjrsKaKZO2EAEjDhzv6WywvFdzzVeUhgN
 4JKZcaiKxRs5+HNNkVmnU2H+hhEo4Cnv892igvI0mHRud7Mf8VomU98V9ChGwSglKEM+
 lQDbCXfJUim4WtCutNHJ4VmLk8Jn0gb3UXKA/AKXH/iGRAb2XKWmk1PP67y8oGIzNNSD
 I0uQWCib/a30SoyjiQjDs9ghSpqyu7n5SSu+vwy2arr6l65ZBpZCxWbJHVTyCRkp8xDs
 RVReJeYeQ5zD+ZmuJKaQBtoSDuc5RbZDBSp0f8jVjJga0hLMAuCOoNnLUM3TGXOtlY5w
 2f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774939368; x=1775544168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G7GKaQ+BmdJBqZzJtYoeMsx+AwcU6n06TFl5Qjg+seA=;
 b=eECuwuxHQxIwFHn0gBBk/+odDlSC4tfpaYfnTH/5LeMrNSGR6AMDAFb4mvIAaLu3s8
 GwYQnJhSpmXQD5oOUwWuo9vPz+ZltmbA19DoeuXhTfjGrlys6Egu1Neg/1M1jUlkEGeW
 P46dP3V0swa6ObluMBVripCFxkrKY1dyiBUQAq3WgnB8tRhuweBby4oq5LeldB+WJ6ng
 mzvqcgOQh25102ufGDA5XkCuDsgWJ/+RfJpbiEHcrkSfOzlOIafcgIWn+XkpRJa7XqP8
 Ce4pfJKliCNwn4YJU/llZPmpgWRyc84x8+KNjj8fjLOlesNJrWOgigCPjy8ng+kSGNdv
 m7NA==
X-Gm-Message-State: AOJu0Yy9mtEwfwdaC8KtLWoaXLGX2UYILGhoxCeAjUZbtwBxXCjKCJcm
 888tLQdALBqFu24YXDAm7NfP1XynBth1FLxZFrR3CUK+8waC4+OZ7sFamhO9wbSrPEEHgZvH+Qi
 L+RWdi8waQEOVUoqDuOnB604jL5Wr2d/yBdz9ddP+7OP/P4JduJXN4AeHLAWMWqwuIBraLmaNJ7
 mMo1uCjQNj58bIxPtWkcJOvx7Q+9DVolI=
X-Gm-Gg: ATEYQzy7YlkXxG6tD7ymPxoyQrJi2A5dHRPqGhNFf90e+tiB8lBYBAihwm67KY2g9Xc
 GxaxuwNL1eECo7pH+p1Hltv+NWzkLuuWa4L6jiDNcNfbhQlXjPZDk/HLAoCDESzubjYUCvAL6j0
 9RSCGUGr06TtJ2APT51zYebNO/A+/pdUUGogvm9P8zEvqVTUc65BJgFIP5XyZfImNqxOj3VVsi7
 Gpyfg==
X-Received: by 2002:a05:690e:14ca:b0:64e:e6d1:329c with SMTP id
 956f58d0204a3-64ff7219814mr14767626d50.33.1774939368579; 
 Mon, 30 Mar 2026 23:42:48 -0700 (PDT)
X-Received: by 2002:a05:690e:14ca:b0:64e:e6d1:329c with SMTP id
 956f58d0204a3-64ff7219814mr14767604d50.33.1774939368182; Mon, 30 Mar 2026
 23:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-5-jonah.palmer@oracle.com>
 <CAJaqyWfkLCu2RRGaJZdcqG0c3uZH0jWmmTmN23F=Bz-Hfm4KOg@mail.gmail.com>
 <654f2356-9c78-45df-95ff-de103557948b@oracle.com>
 <CAJaqyWdN7AYQnugLjwRr4sWDj_dGNg8JpmgBXprgLej_UD8ZUg@mail.gmail.com>
 <96ea2b5b-9449-43d8-a6e5-1e6819d717ed@oracle.com>
In-Reply-To: <96ea2b5b-9449-43d8-a6e5-1e6819d717ed@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 31 Mar 2026 08:42:11 +0200
X-Gm-Features: AQROBzCje9LcmkGg4OKsJy4P9olLvOmAJ1PqSxdDK7a40dtMFbxA682stYR-akA
Message-ID: <CAJaqyWfb3isauOmdU0RH0SspBGC+u6uYTw0QH-2Dm635F=oicg@mail.gmail.com>
Subject: Re: [RFC v2 04/14] virtio-net: detect VirtIODevice status
 mid-migration change
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 30, 2026 at 3:42=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/26/26 6:08 AM, Eugenio Perez Martin wrote:
> > On Tue, Mar 24, 2026 at 4:02=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >>
> >> On 3/24/26 6:45 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Mar 20, 2026 at 3:20=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>> This patch introduces the mechanism in which this series will use to
> >>>> detect VirtIODevice & VirtIONet state deltas, starting with the
> >>>> VirtIODevice's 'status' member of a virtio-net device.
> >>>>
> >>>> Before we send the device's state early, we save each piece of its s=
tate
> >>>> in a temporary structure via virtio_net_early_pre_save. Later, once =
the
> >>>> source VM has been paused,
> >>>
> >>> While I ack this approach should cover 99% of cases=E2=80=94as I thin=
k it is
> >>> unlikely the guest changes device properties during a live migration=
=E2=80=94I
> >>> still believe these changes should be sent when the guest modifies th=
e
> >>> property, before it is paused. That way we shrink the downtime even
> >>> more. This comparison fits naturally: Instead of sending one state an=
d
> >>> then the deltas at the switchover, we send the state and then the
> >>> delta for every change.
> >>>
> >>> However, I'm happy enough with this approach because it is more
> >>> self-contained within the migration code. It also reduces the state
> >>> sent over the migration channel if the guest changes its device statu=
s
> >>> many times.
> >>>
> >>> CCing Juraj as we discussed this at the virtio-net upstream meeting.
> >>>
> >>
> >> Right. I agree it would be optimal that, for every change made during
> >> live migration, the destination is updated with this change and it's n=
ot
> >> left to be handled once the source has been paused, which would impact
> >> guest-visible downtime (especially if it's an expensive change).
> >>
> >> However, the only way to handle mid-migration changes like this is via
> >> the SaveVMHandlers framework. I did give a stab at this approach in my
> >> v1 RFC series:
> >> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/2025072=
2124127.2497406-1-jonah.palmer@oracle.com/__;!!ACWV5N9M2RV99hQ!PyNRmf036KN_=
mQbYDRqZ3R20poPNdyxA80Jf3K4CHxcB8GmtxokyYDr4FYWWZ-N1m1CbGYjcQjF6-XzoXW0$
> >>
> >> However, Peter believed that this early-migration work would be better
> >> suited using the VMStateDescription framework instead. And the VMSD
> >> framework does not support handling these mid-migration changes before
> >> the stop-and-copy phase.
> >>
> >
> > Right. But we can extend the VMStateDescription framework to support
> > asynchronous state sending as well. At first glance, it should just
> > add a new VMStateDescription to the struct SaveStateEntry, let's call
> > it live_vmsd, and call it at the same function that calls
> > SaveVMHandlers->save_live_iterate, which is
> > migration/savevm.c:qemu_savevm_state_iterate. The load version also
> > needs to be called when .load_state is called.
> >
> > While this extends the series, I think little code is needed and I
> > believe it's the right long-term decision to avoid adding multiple
> > ways to solve the same problem. Again, is this ".early" version is the
> > best we can do, I'm pretty sure it solves most of the cases so, sure,
> > I'm all in :).
> >
>
> Oh, that is an interesting idea! Like a hybrid SaveStateEntry with
> SaveVMHandlers for lifecycle/iteration and VMSD for the actual payload.
> This is something that definitely could be explored.
>
> However, I'm not sure if this kind of enhancement would be appropriate
> in this series specifically. It's a legitimate follow-up idea for sure,
> but probably not something that should be tied in to this series, right?
>
> That said, if such an implementation were to be upstreamed, enabling it
> for virtio-net/vhost-net/vhost-vdpa should be relatively straightforward
> on top of this series.
>

The problem is that we'd need to maintain the two approaches, isn't
it? It's not easy to "deprecate" early migration while keeping the
iterative VMSD, or the reverse.


