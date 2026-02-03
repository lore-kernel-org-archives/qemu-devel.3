Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC2CE87830
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGtu-0001mS-1D; Tue, 03 Feb 2026 08:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vnGtq-0001ls-Cf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:57:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vnGto-0001cL-Ib
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770127018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WY6s6SRHH4n78mPC5DGSKCTd1v7uxd4u3TJb4Lcbdp0=;
 b=h4ZTpuXYKzgas8/ZviXtXk1+bn1kcLMRTBnRN3eNnBBd+ExQNElvTaZYX9wfyt/nskh2BY
 zkFGxx/D2uaC8Jf1Ol/gMmiYq+xoyWr5wvgfY6XRQ32/v6HKiLtUpWGY+0qlmuegoGqw3W
 fmMUCjxBQqNVbTdDsjJ0MaJ3ePuKVlo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-d-qKZ8kfOFqaNEz3lSUFSw-1; Tue, 03 Feb 2026 08:56:57 -0500
X-MC-Unique: d-qKZ8kfOFqaNEz3lSUFSw-1
X-Mimecast-MFC-AGG-ID: d-qKZ8kfOFqaNEz3lSUFSw_1770127016
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79431a41d9bso88812387b3.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 05:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770127016; cv=none;
 d=google.com; s=arc-20240605;
 b=WEixMZqVksu2iV5av1XsH8hdFjb7FVA/lrfmhah8cF7aHIGZZWlEyGtEM7Pn1EVgeH
 Y2nvYNz8j34S3VAzyptW+HHHzeh6PSo7qJIUTywF+rabXELi1wLfkUhoVKghe7atMFBn
 xxEjZyZG5eA8NNoY6X1ng5q0cuOzcNC/K0d51mh7bMOZQOrQi6Jqh+SA1o/4F5SWR5CV
 /C/Uczb+zJalFQC0ymMeNi/yiU3nicDKvudX+FjjJfpVvITIbQZZi9AdQFRlpGseisXO
 gXMoGiZKuUSH/0ic96c3puQ2dhSuC9nU9sxDYcXo2lZ2lzvIpxWgjxVwqbaAMoiqe4Hh
 17qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WY6s6SRHH4n78mPC5DGSKCTd1v7uxd4u3TJb4Lcbdp0=;
 fh=uCfPG9NEhozFQyHQoth2oLWY2ZGCsi2VHXgxB3wrspQ=;
 b=NX46ABZrXes3ubrknTWTL9d7705dizjuI49H2jFYOYJOlw3cBBsILVfNyABh3nygBF
 c0dnHjNVx2OZu9PgkIDcCKOnJCovrGuokLt41nZ4Jh9BvRNjgGiCYvlS+1RZI1BhQtYz
 t40NaEcf6U1q4f2ZNt94Q2dRMecBiFEvuO+TLpY4qk1paL6By901CMJ8rEJlDiRuONPg
 UYoMg7f3u+RswrVc8KvzZRH2emERzbV38ZnxHibfbY3ZfcocHZKOAYya4cv1853v1yGb
 6F8IZJWWnsmOySa7w8IY7OZv/JpCc3ZdFvlOECi0/brDNdWvRyK3mM1mYiNtJdh1lMXW
 N+VA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770127016; x=1770731816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WY6s6SRHH4n78mPC5DGSKCTd1v7uxd4u3TJb4Lcbdp0=;
 b=eC1fVbIUO6i98vabvvwdiQ5+AWNBvi2jry6HhEmbROxuPqopINE2s68ntbv2gnbuXR
 24skNWSQEAEYQqvMhS+xhToAjFGu0yO0DvRMtZK4/bVkAihOsOMQ+DQGWnY9AfvvXLGQ
 yxZVVHFIq25hiJ/T2Te3OQE9Bp0W1wT0QgW2a6kv/g4DrnoNorbVZFxo67lcjCpV1S/A
 8j2V/QQoC5CloNLIACtj48Et/gCdxvtBwQa/xwu89WERyPVqYbTc5bhSUb6eBeMmgkki
 199R5oc+UY2jyK20i7vZuJQxXtmIvXVgqQp4GQ8Sd+q8ugs/qS5HTB/p4RKCChz33jpn
 O4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770127016; x=1770731816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WY6s6SRHH4n78mPC5DGSKCTd1v7uxd4u3TJb4Lcbdp0=;
 b=GH5S4ocHAbo768sAixRDQ3IE3sURTX4WfL1v7KTYv/Up/fi1haRqcP/WUr4UtNndIL
 ByzYE4zSbeQTuRafOLdwTVbnxZybzUPWfBlEaQvVIlKnHo742DjHRu4jpnaFdAHT5ile
 Up+UdLy53BSaj6RupMMPRbP6B4w5N3QEq9lRBgdP/uHHF4um0f4gjoOgO5yyo3SBPQBj
 bNJlsTXGVci5CPhA6PqkctJ9+ZJdjvbBwO9R5Cl9K5qpkvBoDv72ER1WWTcEodxCVhqU
 3RNUmbTG9P9JgregA2nkYBbm+habET1VB2y2YbjwgiQTJOLFcK6kJCUQeNwtYhf9sPdU
 EzVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU20YNEYtb/JT5lFFm1jY72ViqgN2VSS6ON9mGCwY3OGr7O+4Yu6x4HJNtpV+TWB1vhEnoGKSQ7NGGB@nongnu.org
X-Gm-Message-State: AOJu0YyNgaiufHAD6speTKRzLrWesxR0NQwqZNKXBfsYAExgPQGpkRRx
 FNRyo11ekkXP1II1igl2lTrlmzRPoJJWmlVR9ocoI/Dki1PX9SzHdDvFl7bbsbiXeNEId77PPdj
 8J+NkyRM9AHneYfR4sI7HLs72DwPSNBQe460n05bC62lhKtYunBbR/EUPn5qLppyuItCyc6H1vq
 7H80blCBSYjGSZzIsQNwf+TO+UijK8EBM=
X-Gm-Gg: AZuq6aKDTMoHqWO2dCm3bYXNtAtM3JTKJd17tbwYl8OIaXcRZrTkl1YK04Ht98MGXYu
 6dbs8DTXkJoW88CCh7SQNPDnr+wO+G6diq3fIpX3gwYQlSusZMFnqIDu3MXS9ANacKeumuR+b2Q
 55HrmFHnAk9P3ejfazcYQMMYELecz/Lep0VnYMdCYOmSUVfipqbhjfk3sdUFkRiKMNxw==
X-Received: by 2002:a05:690e:4191:b0:646:e643:d14e with SMTP id
 956f58d0204a3-649a84b9277mr12178137d50.53.1770127016399; 
 Tue, 03 Feb 2026 05:56:56 -0800 (PST)
X-Received: by 2002:a05:690e:4191:b0:646:e643:d14e with SMTP id
 956f58d0204a3-649a84b9277mr12178126d50.53.1770127015949; Tue, 03 Feb 2026
 05:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20251029125001.15086-1-wafer@jaguarmicro.com>
 <CAJaqyWf+YxQAxM3e0H2Er=dYSbGHhadJQ5n=Lj_b4Ufa4z=HYg@mail.gmail.com>
 <20260203084017-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260203084017-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Feb 2026 14:56:19 +0100
X-Gm-Features: AZwV_Qj1bTCJr4kdAT6mU3onEQEr0VIZHi24TJarCdv9MLjZ74NuKpy3rZaXVqI
Message-ID: <CAJaqyWees4dzY1pm5KfLiJ0j5zZnW38YhCXk3f4Yj5ff2Xb8Xg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix cannot get vring base when stopping a
 vhost-vdpa device with multiple queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wafer Xie <wafer@jaguarmicro.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Tue, Feb 3, 2026 at 2:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Nov 06, 2025 at 09:04:46AM +0100, Eugenio Perez Martin wrote:
> > On Wed, Oct 29, 2025 at 1:50=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.co=
m> wrote:
> > >
> > > When stopping a vhost-vdpa device, only the first queue pair is marke=
d as suspended,
> > > while the remaining queues are not updated to the suspended state.
> > > As a result, when stopping a multi-queue vhost-vdpa device,
> > > the following error message will be printed.
> > >
> > > qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not =
permitted (1)
> > >
> > > qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not =
permitted (1)
> > >
> > > Fixes: b6662cb7 ("vdpa: add vhost_vdpa->suspended parameter")
> > >
> > > Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> > > ---
> > >  hw/virtio/vhost-vdpa.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > index 7061b6e1a3..2d5e6aca74 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vho=
st_dev *dev,
> > >          return 0;
> > >      }
> > >
> > > -    if (!v->suspended) {
> > > +    if (!v->suspended && vhost_vdpa_first_dev(dev)) {
> >
> > I'm sorry I missed this fix!
> >
> > Good catch, thank you very much! But the right fix is to move
> > v->suspended to v->shared, and then all the vhost_vdpa devices cannot
> > have different suspended states.
> >
> > Apart from that, please include the tag
> >
> > Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")
> >
> > In the patch description.
> >
> > Thanks!
>
>
> Eugenio do you want to post the fix?
>

Wafer posted it some time ago, but I realize now it was posted with a
different subject:

https://mail.gnu.org/archive/html/qemu-devel/2025-11/msg02947.html


