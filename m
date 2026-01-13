Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D97CD2F35C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 19:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfkS3-000091-Ni; Tue, 13 Jan 2026 14:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vfkS2-00008n-3A
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vfkS0-0006Us-1x
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768333989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UE/hHvW8ULqyYx4f0hDbS6RkLM1EPuUMxsiLVij5OWE=;
 b=NLYt/M8G7V4D11eELluYHccIdhk/HfXtlxgxDSDrlzRzRqVCZRo2KwNI81Q8QMJmq+mv5x
 c3cVQLyZHrHtvjQGS6DJzpKd02r66XXMFhqjKdeJXm1+u4CtMkbF40p3yluGWiNf3AmJNm
 o9GCUv2rWx4pgMsI4YZwkhqPIWGTyQA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-75kPSaKcNrydz9HXZGkcmw-1; Tue, 13 Jan 2026 14:53:08 -0500
X-MC-Unique: 75kPSaKcNrydz9HXZGkcmw-1
X-Mimecast-MFC-AGG-ID: 75kPSaKcNrydz9HXZGkcmw_1768333987
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79012391ce2so116869497b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768333987; x=1768938787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UE/hHvW8ULqyYx4f0hDbS6RkLM1EPuUMxsiLVij5OWE=;
 b=haKc4b7Lga2ZI3RkWoqYNOjxi4OOmiuZvUAIfTyFVCw23jjCkqNZLWiq4yOwpF6hMZ
 s3lQQwb8Mg5P0y6WvvuYiUwTFVLDQVP0NdyVQExpw6PfWExOLsQ1Jprkkb52DfDsXMo2
 ODC2MTG91c3fMezaU2wYMJVur5K4/2puMVHzD8haLjFAGBe3tBSGkM3XhWZ4IRz6eOCl
 P7T4fjKuDM4VP3BHMo+zvWypAde/ix1oMqv1770cYPO4bk/pOqG0E4yvpAD10luTIQcK
 C0sbKGrISAeljdpPD7Vhn8vuTBD64ltw/eDe+XoSXS5jemvEI7cil6fu4I6vOpo20CVJ
 lAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768333987; x=1768938787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UE/hHvW8ULqyYx4f0hDbS6RkLM1EPuUMxsiLVij5OWE=;
 b=vnSiFULbbsWv0FJ0SmliKYUZNGv2dssoFIdImQDFzg8fmqJHn72ZeAwOv0dqbzZtq1
 hW+g2HOy568MLh8a9H4qY39A/BfN7NLzcOohglbuvHSXm9UOMJ/P/KDpzaR2OKKpBxO9
 ZugeL2A7FdZ5Epn2zKWx6gTW3Zpsslyw1EUfNQhhAtJuZ687C3iTanhdlsKElCwTKdjf
 eQG0aQ44MQ0v8sDz2OUksYjAhgeuMLKPW9ojq7fS01+mktVCqb2xJ8+PqCLFZPvVSQxB
 c8XboJgsMU1sWDI95TCWFJ/jW2epMruD0/FIe9UJBe3mr/z2m7q4jsvg+9aNE7fJJFgg
 Srrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlMGoTjry7LxCVYgLFDpx6iLwiJg7KLj/gkCsIiN1pwLJb9cXZ33AxRaEaljAtTCO1sRUXjPCCJP8j@nongnu.org
X-Gm-Message-State: AOJu0YwOdUBshEOGqEAL8FXao/rvoS1ArDYRlHlXnosw1KZE20LSnBow
 STqYA0ISEpNQGHDXspNEwvsSKvYlJhAHRTB6+KBOF8N8FH1BhR19+fjAtAy/yrotIQ7yVqkhd6L
 nZrTjKYvoP5bPxD35FBixTrdeaG0xInAqTC1sWehnn5oRWlddcDDXUMRYrTyyBV4UigCZbddkxG
 rC/IsaS9DQ6Mhi3EwJCKLdKZ8O7aah+fo=
X-Gm-Gg: AY/fxX4Hx2Ykv+KDWsu4t1oQc5ZGw1z9li5hOP77e8eXsWHFl4gOjuS3gturWafaRNk
 Hg6AQ1acVJ7zlotxrxDx+ZK4fItMX4LU+O2zg8gp1OvxL4Ou7ErxEKl8hs1BHQfVOcfzBeN8M1r
 C0JkELPXgqOORYCOCVLtSA4YyNN9DqEXzbCiWdYa6POWBeqR3B1KIRsqopZTCAKyVlcEYugGjOv
 8Y28PYy5nu/TXk4fUOuMF6DuQ==
X-Received: by 2002:a05:690e:408e:b0:644:7398:6676 with SMTP id
 956f58d0204a3-64901ac0644mr373120d50.32.1768333987558; 
 Tue, 13 Jan 2026 11:53:07 -0800 (PST)
X-Received: by 2002:a05:690e:408e:b0:644:7398:6676 with SMTP id
 956f58d0204a3-64901ac0644mr373102d50.32.1768333987164; Tue, 13 Jan 2026
 11:53:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1767716928.git.mchehab+huawei@kernel.org>
 <CAFEAcA_TMuZG8VJMs2JZ49Xq+wVxcq_7UGOMF+2FUe0k7AUgwA@mail.gmail.com>
 <aWY10BYoJjck3xX8@redhat.com>
In-Reply-To: <aWY10BYoJjck3xX8@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Jan 2026 14:52:56 -0500
X-Gm-Features: AZwV_Qg3rc0n3MUq0eNw5dVDZR-BANYePulTIyE9nvJGYn2SeBbl7mY6TUQ1D6k
Message-ID: <CAFn=p-YzSP_v0TAzGOGH+mGMczqQLpN5OTda3c1MdbNGETcd4A@mail.gmail.com>
Subject: Re: [PATCH 0/1] Sync kernel-doc.py with Linux upstream
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 13, 2026 at 7:09=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Jan 13, 2026 at 11:44:51AM +0000, Peter Maydell wrote:
> > On Tue, 6 Jan 2026 at 16:38, Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Hi Peter/John,
> > >
> > > There were several updates at kernel-doc upstream fixing bugs,
> > > doing cleanups and a couple of improvements.
> > >
> > > Better to keep QEMU in sync with such changes.
> > >
> > > Worth mentioning that we did some changes on Linux at the
> > > kernel-doc.py script itself, to avoid Kernel build to crash
> > > with too old Python versions, as there docs build is a
> > > separate target, and python >=3D 3.6 is a new requirement
> > > there.
> > >
> > > On kernel, if python < 3.6, it will simply ignore docs
> > > build (emitting a warning).
> > >
> > > I opted to not backport such changes, but if you prefer
> > > doing that, I can do that on a v2.
> > > ---
> > >
> > > For now, I opted to keep kernel-doc libraries at the same
> > > directory as before - e.g. at scripts/lib/kdoc. On Linux,
> > > we ended moving it to tools/lib/python/kdoc. It could make
> > > sense to move it on QEMU too, as it makes a little bit
> > > easier to keep things in sync.
> > >
> > > What do you think?
> >
> > Hi; thanks for doing this backport. I checked that the output
> > with this patch applied is still the same as with the old
> > kernel-doc, and eyeballed the diffs between our kernel-doc
> > and the Linux version, to confirm that we have kept our two
> > minor QEMU-specific modifications and haven't missed anything
> > from Linux's version that we ought to have. So:
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > On your two questions:
> >
> > (1) As Dan says, QEMU already enforces a new enough
> > Python version, so we don't need to handle 3.6. I think
> > the main thing driving a choice to backport or not those
> > changes would be simply keeping in sync with Linux's
> > version of the script so we don't diverge. We want to
> > make future re-syncing of the script as easy as possible.
> >
> > (2) Regarding the location of the kernel-doc libraries:
> > we seem to have two things here, possibly in tension:
> >  - we don't want to gratuitously diverge from Linux
> >  - QEMU's directory hierarchy is not the kernel's
> >
> > In particular, I'm not sure tools/ is where we would
> > naturally put python libraries used during the build
> > process. Maybe that would be python/ for us, but I defer
> > to John or another Python expert on that.
>
> I tend to see the 'python' directory as being for stuff we formally
> maintain as a python API for use by multiple internal consumers.

I more or less agree with Dan - that is how it is currently arranged.

In the past, however, I have suggested moving certain other modules
that are bigger than a single file into python/ for the sake of being
able to maintain them more aggressively: i.e. I do not regularly check
for Python regression and compatibility issues for things under
scripts/, except for qapi, which is also something I proposed moving
to python/ before.

The current state of things is that I aggressively check and test these thi=
ngs:

- python/*
- scripts/qapi/
- docs/sphinx/qapi_domain.py
- docs/sphinx/qapidoc.py

Everything else is just "best effort" which generally means "I fix it
when I notice that it is broken". If it is not a multi-file module and
not necessary for configure+build to run, I think for now it is best
kept outside of python/.

>
> This is just a bunch of helper files exclusively for use by the kernel-do=
c
> tool, and so the scripts/ directory is a decent fit for it, given that th=
is
> dir is for a collection of arbitary supporting tools & scripts.
>
> As precedent, see the tracetool, which keeps all its helpers under
> scripts/tracetool too.
>
> TL;DR: I would not want to see a new top level tools/ directory
> created, and don't think it fits in python/ either; scripts/ is
> a fine home.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


