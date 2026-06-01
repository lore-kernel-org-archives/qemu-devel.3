Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5961ACD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1qJ-0004Wl-QM; Mon, 01 Jun 2026 08:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wU1qI-0004Vg-Rt
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wU1qH-00014c-42
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780317243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4S2OoOJdCGik4sB7UdU96sEr9aO97fQctanm7w64oQ=;
 b=iiX/u7ugnVb8cMeP9tGEwxvVcDi9LfjFOzdD0UhasNF4Qc881UTLaUKtftJABaICPYtEOf
 ldbrtvnIIYAPd+VDYxgahxls+USdXfQkjQAb34XytCseFQoDW9Q98g9ueFXtVnGMKOBBnZ
 LHLFjMRfN1VlrRyz6bjatuZXG1Vyfoc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-qJwoVotMOj2cfvHjcKzOhA-1; Mon, 01 Jun 2026 08:32:25 -0400
X-MC-Unique: qJwoVotMOj2cfvHjcKzOhA-1
X-Mimecast-MFC-AGG-ID: qJwoVotMOj2cfvHjcKzOhA_1780317144
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7e54081aa4eso12917807b3.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 05:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780317144; cv=none;
 d=google.com; s=arc-20240605;
 b=M3IBiVW+AMBwyrHgiK1209LYB7VbaCC9fL210ePtB6Z/0tyXGlEf2TPThez7u0nPwZ
 MJAvbGMkXD3fqIL/TeXWCYpzwxOXeTqBJxSvYGfNHSDZfDd86xN5M90PBl2AOdcpdzXH
 9/EIIwLCXsFNLDahB9xaKZz/aZ2N7xjBz0O7uwbrHggRTdJWk5c3S3WoDKKCdQrtbItk
 DXmVj3vcbAKuC01eL0jmC70O7VGNhVMFbgQ1txzwdGsALco4z2TLTKFNjGldy8e68Vxz
 FMB5NeIBhFpgMz37zbdtPLL4kb1zhGLrlZnWZSQyTuDjh9+cBFbesvChU3Xeqh22tie7
 IM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H4S2OoOJdCGik4sB7UdU96sEr9aO97fQctanm7w64oQ=;
 fh=xPEs7qtr/UIDQ69CvmfZS/LTZOEt8SNuw9OTczqFf6I=;
 b=CXjhqJIMF0LBAypGW7xyqAY3XV/WI9189xg97N6nELtKhg8kn1yO/eyS0Fiw7HvQiY
 JgdxpXr7XwkbeBmTwoEWKaIbkU3gzjN+ODuXYJAuxmY1KA0XljIEGGquNagfU37nsahu
 4sSRAOrhjzFMhez0fQkvVF7+jZLd6TFT4PlNqrF2hsa/vWSVyUZmTNcsZ3Bj7eAEZezQ
 9IDl3C7h+AzNtbMPftSgZSJONBacIvpaVrn66fC+z3KgsCwR3Fx0xj3KRHN9gckWje4g
 t7roDulHYD3uDAw9eEE9GZnBqMWUULpwX/gm2PyyAOigs2rrkPe2lc6DX9otyF1moNrt
 3CNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780317144; x=1780921944; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4S2OoOJdCGik4sB7UdU96sEr9aO97fQctanm7w64oQ=;
 b=PDWG+WtF/WwR+rUY1WFtTlZMFMw04svGTlgiCv6/SiZEex0k/eAyx7JSwa9etTVwVr
 bWdHY7KxbZdhXHuAZXxhX0ZAK1bz6dakRvwn3cXFWPs72WK43NdVLm+7DGAncbsgXQvn
 QxUDTpBVUsm4q8OpjGyp0tbSHd001Iaj8A/XUWH5JxvFlDtDpPCdmMmFt0ywsA0Se066
 7yxRjRHdi8DmHSiFrZRkdlb720hXmxg56Q7zTaUy+p+GWyH+U4cKS/n3lpXcyEx6RfqU
 z1nFxnCSi+8hXyfjhk+7YqRsOK0OEVW6kabaKWg2Xamloo9rJIQ3xijRFxqdZGBse70g
 y4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780317144; x=1780921944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H4S2OoOJdCGik4sB7UdU96sEr9aO97fQctanm7w64oQ=;
 b=OWJMXaUfOiiHU8pqp9waWN4s+o1IJ7jUwYdJq3Z4GZcMhTEaD+Hv1eg05VzT4Ity0i
 Lr2rJmCKVi8Vxfs9SF4yo7q7VYWbW1HKU45+cArIA1INzrWmYdaKDlKBShU8Jy0o4tsl
 /nJ8ksLABhGMumAK570XznBwMRGs0e1jsTOPbr76au5vS9tLspVTtjIcJIto7r+XCbsm
 Wlwzw3iDVD5ffzNNjIo12xGkpr2Lg2n2XJu364pEo2yH2IkmrnMUG4SnYqTk2KkBelSr
 MzxyykJ+5+LFz0W6NdjOKPg28Ph44xk5eTXhkru5dgtnBKtKEtSQhaCGzwWLTSrokWZa
 xeSA==
X-Gm-Message-State: AOJu0Yx6wl87Jc2ChrkfdpvRDBT87eoBIgzcKS53lM/WylXctLhxJMOc
 g2RPrNk70XVh2ZnhRzNkKl940n8HE/Q+hNU1zvh5lHodKuSUNCQIa/rQzXzhaj2RnG8/EVWwG8b
 HX7uaJhHvdPOeHXB/PdZilgcHL11jtC7ZG0zEojmme96AXi1QqbI2A0BWmIyrVT9Rnlq6lL6uHC
 X9EPAwWn7LqEwJxW2s61V2yr3h5VZ5l3M=
X-Gm-Gg: Acq92OE+deQLYcMe+pNTOwj1OhX5L4OCMgscBIH3lH4tsrkPxzR9B+COhxj8XJZtC8u
 NtapF0i02ItQcb2KDuQS6YQZxuKWvFHrrPLYqziqkcIVUwrsYyIdaaFkpYRu/rT5cqfjPSOVVKE
 AN+QFdVIVtTsyACC3C60rHpT/IFZElKqdH9PCmq2dIqJkny9cECsBpvJJ70B7F5fZxrOtyw7cej
 sgwvsqny8bs0b4E
X-Received: by 2002:a05:690c:6e06:b0:7bd:995a:a31e with SMTP id
 00721157ae682-7e058b3e948mr90313937b3.7.1780317144326; 
 Mon, 01 Jun 2026 05:32:24 -0700 (PDT)
X-Received: by 2002:a05:690c:6e06:b0:7bd:995a:a31e with SMTP id
 00721157ae682-7e058b3e948mr90313557b3.7.1780317143736; Mon, 01 Jun 2026
 05:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <874ijtz038.fsf@draig.linaro.org>
In-Reply-To: <874ijtz038.fsf@draig.linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 1 Jun 2026 14:32:11 +0200
X-Gm-Features: AVHnY4IHsKtXvcmMZwHKbZCsvKSO-CnD7seD8KmIQFUM33ZbnQqqBiQDVQmL5Ts
Message-ID: <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Alex,

On Wed, May 27, 2026 at 11:13=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
>
> Hi,
>
> Apologies for the wide cross-posting but I wanted to find as many
> interested parties as possible.
>
> The vhost-user specification currently lives in the main qemu
> repository (docs/interop/vhost-user.rst) mainly due to historical
> reasons. QEMU was one of the first VMMs to implement vhost-user and the
> spec needed to live somewhere.
>
> However there are now vhost-user implementations for QEMU, rust-vmm,
> cloud hypervisor and I think CrosVM. We get queries about changing or
> updating the spec on qemu-devel from time to time and I feel that given
> it is an interoperability specification we should think about hosting
> it and its discussions elsewhere.

We recently discussed this with Dorinda and Stefano. I do see value in
moving it elsewhere. Mainly to remove the friction of external
communities navigating QEMU-specific tooling and workflows just to
propose protocol updates. But also because, in my opinion, separating
the specification would improve development agility by decoupling
specification development from QEMU's review and release cycles.

At least it is worth the discussion. Thanks for raising.

>
> I think broadly there are 4 options:
>
>   *  Move into the OASIS VirtIO group as an appendix/addendum to the main
>      VirtIO spec.
>
>      This probably brings the widest visibility to changes to those that
>      might be affected. However it does come with a certain amount of
>      bureaucracy with the OASIS process where only members can vote on
>      changes. While intimately tied to VirtIO it's concerns are more
>      focused on practical implementation details of the IPC between VMMs
>      and device backends.

While it does make sense for VirtIO, I'm wary of the added bureaucracy
that OASIS would introduce for vhost-user. The scope for vhost-user is
also much smaller, focusing more on the transport protocol as you
pointed out, so I do not see the need to subject ourselves to that
process.

>
>   * Move to a separate project under the qemu-project space.
>
>     QEMU hosts a number of sub-projects and mirrors so it would be easy
>     enough to split the spec into its own repo. Changes to the
>     specification could then be divorced from QEMU's release cycle and
>     at the maintainers option issues and merging strategies could be
>     configured for just the specification.
>
>   * Create a new project just for vhost-user
>
>     The interested parties could decide where to host (github, gitlab,
>     forgejo, whatever..) and decide to move away from mailing lists
>     altogether or create a mailing list but manage changes via the forge
>     interface.
>
>   * Status quo
>
>     Just keep the spec where it is and muddle through as before. Maybe
>     we could improve the contribution documentation for how and when
>     changes are discussed.
>
> Any thoughts?

Another option could be rust-vmm. It is a project shared by multiple
stakeholders. And while it is Rust-focused, its community heavily
overlaps with the exact ecosystems driving modern vhost-user
development.

BR,
Albert

>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


