Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63652C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiWZ-00023E-MB; Tue, 16 Apr 2024 09:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwiWR-00021C-N1
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwiWL-0000kN-Aa
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713272804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBAHRbjY5/4GH+fddWQD8Hgf1ZHzV7eEnrxuqjBCAnc=;
 b=M+IakIiXjcmILXgQqb1HGcobg+UAHgWW5+QxSNDPwK8pWgH5CUjqqD2o9VwznS2YezpvEf
 yNEtRjK+KKXC4W702MhUyW+qGe1av7wsPgfgJWPWslIfRkOKlsYcFsiplKWT5MCuguJVMh
 U7pHhhw154sYZqnTt0y653Y6mLpLlU8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-xP3MklqzNAOAaUBT3LaNdg-1; Tue, 16 Apr 2024 09:06:42 -0400
X-MC-Unique: xP3MklqzNAOAaUBT3LaNdg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d6ef704b35so38619911fa.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713272801; x=1713877601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBAHRbjY5/4GH+fddWQD8Hgf1ZHzV7eEnrxuqjBCAnc=;
 b=dmZsHiZwZCf55pROvaErrV8wL7PU7uxH4qkdlt7GrijWdNa2BhHL95tD5SvAkj+SQV
 1+6hUNgf1mWqQjv8pRIfPX3S3RbgWUST0pdaFNG7C4hWN3IAUCo/KP7vU/fVEl1eYqnV
 vktyhLdkJY8z7rIoFIqAfuYvly1qDrWnmOHO7DGkTS/5t8DtjGBD35RY53bSG8N+VsYO
 xsV4aTselvC6Gn2DBE6Dd4/Gp32UpEGuZDPbPSo/I9YZEqMbsGRX27+Jw1j2dU4EFeJL
 /S+t46/P0sGiNlkXMtt+Uj3tJ1lUUBxj9xENx2trKJBESo1wXwDX6eWfF7PYVjgPk43D
 vQ2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPOVnkB15nEiffI0So6cWKlpqs3+xkDQgtqjmxjgoI7cZj/AbqSuyhyrN+0gSIcXRW74T7D3KcxrFhKgpgXDaltiz+4o8=
X-Gm-Message-State: AOJu0YxSVlIxyaW0Og32ER1OPBIDcWYBpFfNC3D/h2XfFxcmhPW4T7pD
 0Qg6a5BmJd7P0FlvMry0ia2dIT6lXp2UZElt2Vt+yMXX7r08FyX8orb+3Q+7CDHT/evcwT/VUQr
 SfKX5Vdge/fdU5FNUg6mn0X6nH0cpTnz80x4gXNWlvaNfm7FbTdIXZbWWFXTl3UhuKJEyzTmG7Q
 Ew0kdTzOPprMWGQKRalQ0L6puuud8=
X-Received: by 2002:a05:6512:312a:b0:516:d448:b42a with SMTP id
 p10-20020a056512312a00b00516d448b42amr8384767lfd.26.1713272801029; 
 Tue, 16 Apr 2024 06:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUTEGhRCV32+/AI8T+LEtJqUkZJQwbTBxB/nMf/N8T0taCaRt7xtpUobkGZpHcHwgm63yW/Q/rqOsUVyG9tns=
X-Received: by 2002:a05:6512:312a:b0:516:d448:b42a with SMTP id
 p10-20020a056512312a00b00516d448b42amr8384753lfd.26.1713272800586; Tue, 16
 Apr 2024 06:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
 <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
 <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
 <CACLfguX73rN77rK92xboF6hxERoO2F7kdqUgBohrURt7-38C2A@mail.gmail.com>
 <CAFEAcA_WxhOpjtZ5r-CfoOaf1aiKeaEV9eX=drb1JaBCiBoDKA@mail.gmail.com>
 <CAFEAcA_AcKdOXO3+ez6J+hQ4NmGoUa+fBUNK3XL_YSvRk09Gcg@mail.gmail.com>
In-Reply-To: <CAFEAcA_AcKdOXO3+ez6J+hQ4NmGoUa+fBUNK3XL_YSvRk09Gcg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Apr 2024 21:06:02 +0800
Message-ID: <CACLfguWfxarkB2qtn4Dt5JS01t-tFUsOfbX486exvNo8vOM1AA@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-pci: fix use of a released vector
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
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

On Tue, Apr 16, 2024 at 8:22=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 16 Apr 2024 at 12:50, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Tue, 16 Apr 2024 at 12:05, Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 6:01=E2=80=AFPM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> > > > Hi; Coverity points out what it thinks is a problem in
> > > > this commit (CID 1543938):
>
> > > > Here we pass that through to kvm_virtio_pci_vector_use_one().
> > > > In kvm_virtio_pci_vector_use_one()'s error-exit path ("undo")
> > > > it does
> > > >     vector =3D virtio_queue_vector(vdev, queue_no);
> > > > and in virtio_queue_vector() it does:
> > > >
> > > >     return n < VIRTIO_QUEUE_MAX ? vdev->vq[n].vector :
> > > >         VIRTIO_NO_VECTOR;
> > > >
> > > > where 'n' is an int, so if we can get here with queue_no being
> > > > VIRTIO_CONFIG_IRQ_IDX then we'll index off the front of the
> > > > vdev->vq[] array.
> > > >
> > > > Maybe this is a "can't happen" case, but it does seem odd that
> > > > virtio_queue_vector() only bounds-checks the "too big" case
> > > > for its argument and not the "too small" case and/or it
> > > > doesn't have a special case for VIRTIO_CONFIG_IRQ_IDX.
> > > >
> > > > > +    }
> > > > > +}
> > > > > +
> > > >
> > > hi peter
> > > I think we can simply remove the part
> > >     vector =3D virtio_queue_vector(vdev, queue_no);
> > > the vector is get from virtio_pci_get_notifier() and don't need to ge=
t it again
> > > I will send the fix soon
> >
> > The error handling in kvm_virtio_pci_vector_use_one() looks
> > a bit odd in other ways, too. The only bit of "undoing"
> > it does as far as I can see is calling kvm_virtio_pci_irqfd_release(),
> > but there is no code path that gets to there where the
> > main codepath's call to kvm_virtio-pci_irqfd_use() succeeded
> > and needs to be undone. So perhaps the entire "undo" code
> > block should be deleted, and the "goto undo" lines
> > replaced by simple "return ret;" ?  (The codepath
> > for "kvm_virtio_pci_irqfd_use() failed" already does the
> > "kvm_virtio_pci_vq_vector_release()" by hand there.)
>
> In any case since the error handling in kvm_virtio_pci_vector_use_one()
> isn't new in this commit (you can get the same problem via
> kvm_virtio_pci_vector_config_use(), which is CID 1468940
> first detected in 2022), I think this is not something we need
> to rush to fix before we release 9.0. If anybody disagrees now
> would be a good time to say so :-)
>
> Paolo's comment on CID 1468940 was to suggest "virtio_queue_vector
> should check VIRTIO_CONFIG_IRQ_IDX just like virtio_pci_get_notifier",
> incidentally.
>
Hi peter=EF=BC=8C
Really sorry all these mess, but I still have a stuipid question,
where can I get
this CID result ?maybe there are a mailing list=EF=BC=9FI just wonder maybe=
 I can fix
these code earlier next time, Really thanks for your help

thanks
cindy
> thanks
> -- PMM
>


