Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC46C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 11:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwhKu-0006EP-41; Tue, 16 Apr 2024 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhKs-0006DW-2y
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:50:50 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhKp-0002gf-Np
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:50:49 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2da68af6c6fso28243011fa.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713268246; x=1713873046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiQEyFO+4ftP4OAfOPJXJoSKCu2llqwcfZclQYAnCoc=;
 b=NFH+n14NhHsoB7UoPdWA7tDMTcClYU43Qx5ZhiixYy73aYUnaJeK7dq4TcE6TzPzER
 qZt/V2qAoL/sfPcCuu9rvHjkt0LyLrYxlYK31gOtf3nepp+EEhk9cfup7lAW0fprycSL
 TWGOYdNnp5o1Q2N2ysAp07JynhGluVNnaU27R9t2ZTg5h2Qx8HSgabKkDYjzdwo3EwdV
 fuIveRKMZyw8Ob3jLvDjfntyXZpoMsZH2a1ehuJtGId/QuEOkZX3J31efCpAdP8xqBtT
 8aEvMWdQIKPB3wGqBgwf38l6IazpNSkHxovQOa8ARMbpfb3m84KmaJSt8JZiAxXEw41O
 vAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713268246; x=1713873046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiQEyFO+4ftP4OAfOPJXJoSKCu2llqwcfZclQYAnCoc=;
 b=qPRpryby1S+sfQTpy5thycCWKdAEX7LPJ5VrFSw8+TmokWHQVz5FI7JRUwo0vbhtjL
 oN5Ev1Sb7uxV4TwdcgaN03mOirW8+u6BLBLp8IlDgNmfdfr1dTBx2rbxVIqdQvokk0Zc
 np4z8XCW+hRaG5K5Q8/QmWJ2gsIwIuuKxstCxeEPknl4rGBuRccZ+0rjKvvy3Cm1+9hW
 J9JLJg27Cl/V311xAMeOTZpn9E6tV0OqUNlrzvMZd+fpaCo88jTawdsk5Spmd6JBYPfh
 dbzePSszuAnVkX7VkTH9GEjuqWAwiTx5VgT+WCf0T7ZBJoQIUD0uGBzCKNJLvA7YCkNo
 NUTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7DBOIS8d4klijZDCyrrpf1hvISW/rV53I5nzzo+UV4o79EEv2XNh0Q1S9GUJhFvLo6T25kLVOTY9qJoyVL23kCLx+Qbs=
X-Gm-Message-State: AOJu0YzZVgLx8kin/VOWPa7cIJYgPnXovWklL6SidZObwgol9xDPDboO
 mT0NXjbmlLMCiq1avsrK+wieTxnq/9T4i4qEb/sdcA6FXcDG3mycxrzIyqOSgkoRa13DEszSjsY
 nxfVcJRuUb38ODKkgpd/UAyrbav5dev2VuEOP2g==
X-Google-Smtp-Source: AGHT+IFtrtmqrwqpvDI2+B3vW6Qm6be1ykch5Ki8+YfeYMCtEfFxSb0RoohZolMFdBWjZTdACqGJJyxayx8f8KNxd98=
X-Received: by 2002:ac2:46c9:0:b0:516:fe8c:ef9b with SMTP id
 p9-20020ac246c9000000b00516fe8cef9bmr7279570lfo.57.1713268245610; Tue, 16 Apr
 2024 04:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
 <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
 <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
 <CACLfguX73rN77rK92xboF6hxERoO2F7kdqUgBohrURt7-38C2A@mail.gmail.com>
In-Reply-To: <CACLfguX73rN77rK92xboF6hxERoO2F7kdqUgBohrURt7-38C2A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 12:50:34 +0100
Message-ID: <CAFEAcA_WxhOpjtZ5r-CfoOaf1aiKeaEV9eX=drb1JaBCiBoDKA@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-pci: fix use of a released vector
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 16 Apr 2024 at 12:05, Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Apr 16, 2024 at 6:01=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > Here we pass that through to kvm_virtio_pci_vector_use_one().
> > In kvm_virtio_pci_vector_use_one()'s error-exit path ("undo")
> > it does
> >     vector =3D virtio_queue_vector(vdev, queue_no);
> > and in virtio_queue_vector() it does:
> >
> >     return n < VIRTIO_QUEUE_MAX ? vdev->vq[n].vector :
> >         VIRTIO_NO_VECTOR;
> >
> > where 'n' is an int, so if we can get here with queue_no being
> > VIRTIO_CONFIG_IRQ_IDX then we'll index off the front of the
> > vdev->vq[] array.
> >
> > Maybe this is a "can't happen" case, but it does seem odd that
> > virtio_queue_vector() only bounds-checks the "too big" case
> > for its argument and not the "too small" case and/or it
> > doesn't have a special case for VIRTIO_CONFIG_IRQ_IDX.
> >
> > > +    }
> > > +}
> > > +
> >
> hi peter
> I think we can simply remove the part
>     vector =3D virtio_queue_vector(vdev, queue_no);
> the vector is get from virtio_pci_get_notifier() and don't need to get it=
 again
> I will send the fix soon

The error handling in kvm_virtio_pci_vector_use_one() looks
a bit odd in other ways, too. The only bit of "undoing"
it does as far as I can see is calling kvm_virtio_pci_irqfd_release(),
but there is no code path that gets to there where the
main codepath's call to kvm_virtio-pci_irqfd_use() succeeded
and needs to be undone. So perhaps the entire "undo" code
block should be deleted, and the "goto undo" lines
replaced by simple "return ret;" ?  (The codepath
for "kvm_virtio_pci_irqfd_use() failed" already does the
"kvm_virtio_pci_vq_vector_release()" by hand there.)

thanks
-- PMM

