Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62666C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiEw-0004Sa-UP; Tue, 16 Apr 2024 08:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwiEv-0004Rz-1K
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwiEr-0004yK-A3
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713271720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWa+11aDS5+sC4igVjpxUSaARS6hQfyXQYY5jxAl8qU=;
 b=LzHGAJEjfOHqFVI0R6Jw6XEocgZNZGnWV12fMywVyvV1BiUmzwwKZTFfO93YWP5T/EYVQk
 DP6lgkEXKuqLHJkFYb9fPQZeQE21q5u9ZqvzCv+wOJe3XDXdc8BaPe819L88C+Aey+PVJr
 AdfYhTl/ohbd6siR/UTx0sx2R6dowHw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Vb2UQjzDOlS-x7h60MLTcw-1; Tue, 16 Apr 2024 08:48:37 -0400
X-MC-Unique: Vb2UQjzDOlS-x7h60MLTcw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4e9ac44d37so263827066b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 05:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713271716; x=1713876516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWa+11aDS5+sC4igVjpxUSaARS6hQfyXQYY5jxAl8qU=;
 b=BllJiYb2LBW1rhjWoi5TncYUxUhJ4Idlqj/QJ4guDublBfMd0Ybm8rihNu8nhCI9mI
 WxuHY1LBVmbD3uLDsjWQKYVlbegGxv3pzKxgQ+8X05h0S7r4pzEkLkRlwe7pRoPgJSzw
 88ms1NQE7fgSOHcH0hdfY0CSIhfgZ1Hq/fmtbkVxUkPwU2PKLTYPL0zYYu+hxtFIfsfn
 6v4RdWlU+xlwXSsbTNe3W/JAFJv+jcdHbxZmS3PNyedXGKxXvAO6vP9Xz91NixTLjdZu
 /81A+71CC6E4/U7fzS27M8GqWRuY2t2TThzqg59CPs/0PxD9c4aifh7eXtZJ3BuPle6V
 n/nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV226R+ZaSlsTaEqKKf+5bmPUpHZrboeM5OnUzCXstjXMVDSGYuu/r9W7w1HNFxln+AqOsJp1SWerbgBP5f4tB+/qqwwPY=
X-Gm-Message-State: AOJu0YxkJTUaz3DjPr97s2GCzqM/O5W6KiUW2YmQGEX0e0AQxo0Y9pZc
 Nj+wcxY6m+AvmMaXxtGpHChH6xEwPFDMgpqYyF/FTa7zzOTgMo0OYXejkDC2HxlhuoH+MXu5VGu
 DSmmK4n3VSWMQ6SMoWaosqaCGuEMsu+HdfXJA4teDBji9NzXDDMDTk1ZIiG3XjWScBpNCO/pZCe
 ZWloh740Rg9fGH8uBjRzuig3nk/3A=
X-Received: by 2002:a17:906:f745:b0:a52:6a7d:ebe2 with SMTP id
 jp5-20020a170906f74500b00a526a7debe2mr3158319ejb.14.1713271716707; 
 Tue, 16 Apr 2024 05:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJudLCRK7dq2ymZgWzJ/g+gb+HlYpoH/h9zckpz8aGuiKYCL/a23RDAasEwWk7g2l+w3Y1huMwwCujZEFlMWE=
X-Received: by 2002:a17:906:f745:b0:a52:6a7d:ebe2 with SMTP id
 jp5-20020a170906f74500b00a526a7debe2mr3158306ejb.14.1713271716323; Tue, 16
 Apr 2024 05:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
 <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
 <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
 <CACLfguX73rN77rK92xboF6hxERoO2F7kdqUgBohrURt7-38C2A@mail.gmail.com>
 <CAFEAcA_WxhOpjtZ5r-CfoOaf1aiKeaEV9eX=drb1JaBCiBoDKA@mail.gmail.com>
In-Reply-To: <CAFEAcA_WxhOpjtZ5r-CfoOaf1aiKeaEV9eX=drb1JaBCiBoDKA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Apr 2024 20:47:57 +0800
Message-ID: <CACLfguX=OXk9Q-ax87FOTADT+b5Yov1x14XBgxH5J2=SGy1O6w@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-pci: fix use of a released vector
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 16, 2024 at 7:50=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 16 Apr 2024 at 12:05, Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Tue, Apr 16, 2024 at 6:01=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > > Here we pass that through to kvm_virtio_pci_vector_use_one().
> > > In kvm_virtio_pci_vector_use_one()'s error-exit path ("undo")
> > > it does
> > >     vector =3D virtio_queue_vector(vdev, queue_no);
> > > and in virtio_queue_vector() it does:
> > >
> > >     return n < VIRTIO_QUEUE_MAX ? vdev->vq[n].vector :
> > >         VIRTIO_NO_VECTOR;
> > >
> > > where 'n' is an int, so if we can get here with queue_no being
> > > VIRTIO_CONFIG_IRQ_IDX then we'll index off the front of the
> > > vdev->vq[] array.
> > >
> > > Maybe this is a "can't happen" case, but it does seem odd that
> > > virtio_queue_vector() only bounds-checks the "too big" case
> > > for its argument and not the "too small" case and/or it
> > > doesn't have a special case for VIRTIO_CONFIG_IRQ_IDX.
> > >
> > > > +    }
> > > > +}
> > > > +
> > >
> > hi peter
> > I think we can simply remove the part
> >     vector =3D virtio_queue_vector(vdev, queue_no);
> > the vector is get from virtio_pci_get_notifier() and don't need to get =
it again
> > I will send the fix soon
>
> The error handling in kvm_virtio_pci_vector_use_one() looks
> a bit odd in other ways, too. The only bit of "undoing"
> it does as far as I can see is calling kvm_virtio_pci_irqfd_release(),
> but there is no code path that gets to there where the
> main codepath's call to kvm_virtio-pci_irqfd_use() succeeded
> and needs to be undone. So perhaps the entire "undo" code
> block should be deleted, and the "goto undo" lines
> replaced by simple "return ret;" ?  (The codepath
> for "kvm_virtio_pci_irqfd_use() failed" already does the
> "kvm_virtio_pci_vq_vector_release()" by hand there.)
>
> thanks
> -- PMM
>
Hi peter,
Really thanks for your help. I have rewrite this part, the error
handling part is incorrect
Thanks
Cindy


