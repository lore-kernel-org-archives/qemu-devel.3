Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91093C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 01:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTWt9-0000MK-RQ; Mon, 15 Jul 2024 21:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stevensd@chromium.org>)
 id 1sTWt6-0000KU-MA
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:21:53 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stevensd@chromium.org>)
 id 1sTWt3-0006WR-Ah
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:21:50 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eedea0fd88so30114831fa.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721092906; x=1721697706; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7C3R3y8KGJV/wN/0Qbef83eSCdPG1rBmGA4RGs+1vN4=;
 b=jE+Caj6wItoc0gHXlyIe79Mx55qB8H5FwC3OzSvpta2FZRWxkevkd9mUt3YAq0o8NC
 bwXVBwx+bm7vS98twqkpViZK+zmNBwMkh+7hrlW0C6+9gpy/H6imEA4X+v5KZ0XZ1HB4
 cBTz98qZEM4OUd3QVsZRnHGUtuMzAlsDjIhkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721092906; x=1721697706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7C3R3y8KGJV/wN/0Qbef83eSCdPG1rBmGA4RGs+1vN4=;
 b=MLQ/TW5FEFaDvEmp9KoqA3pLqO0A0nOlYnE3U4YoJ5BU/kOjfXBX86NXXsPNfMT/Y8
 PyLf/ef1UUtrk19dlTXC4fvcD6pKnEU85q5sR9GmJBbBiCcCA/3hjO+24Nac6+oDJgTt
 yJ2GIXPepB8yvrfF2ZLnYHvKF7w3oVJUSFA1J5aN4GE40ZO1ZblfBKcrF+Gtcxr/gZeQ
 nOKor2pXKasmJkT6uXgXmrRh7Hvhs33MHOyKoSCogmk8gMRcpIB6mqIBqQ772GTDRQj2
 8WcYwGkKfDxxoBX92+TotiEK+PTjy2pmnP1w0/P4EPInO9G+SD8WztPIVASS04DZb12q
 A5oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLMDzgsdvhxIuoPX78z3oZUWQ1b1DsJPVVjWrcPGuLGPbrcHXd/GnklmeEgJkYxD8KhJ/RtcYOI1Xfk4s3TZak0BE/270=
X-Gm-Message-State: AOJu0YwRJCeHRoybSSObAMk0s1OmT8uV+LxtsCnIKDBzqpsFCnKjvT91
 WourP33OX7foRkIvYIAJMkJVm246piVN434J+fCC7lQ/VCHUtmiJSgTuRDT6VtX7F+BXmKsyQV+
 n+607eiiwdcakw4WvegnfmlStcYMs7qdDYIem
X-Google-Smtp-Source: AGHT+IGhuIJQbxqvC+Y/Sz2g/ASRH/vp11b1umlXS8v+bEXiXMIm4rJ/3qEgWYjm9z7Uf/H11ZCClaUM7GonuH7Gehw=
X-Received: by 2002:a2e:99c7:0:b0:2ee:8749:d49e with SMTP id
 38308e7fff4ca-2eef415ba02mr3385661fa.10.1721092906491; Mon, 15 Jul 2024
 18:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240712014407-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 16 Jul 2024 10:21:35 +0900
Message-ID: <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alyssa Ross <hi@alyssa.is>, Albert Esteve <aesteve@redhat.com>,
 qemu-devel@nongnu.org, 
 jasowang@redhat.com, david@redhat.com, slp@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=stevensd@chromium.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrot=
e:
> > >
> > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
> > > crosvm a couple of years ago.
> > >
> > > David, I'd be particularly interested for your thoughts on the MEM_RE=
AD
> > > and MEM_WRITE commands, since as far as I know crosvm doesn't impleme=
nt
> > > anything like that.  The discussion leading to those being added star=
ts
> > > here:
> > >
> > > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redh=
at.com/
> > >
> > > It would be great if this could be standardised between QEMU and cros=
vm
> > > (and therefore have a clearer path toward being implemented in other =
VMMs)!
> >
> > Setting aside vhost-user for a moment, the DAX example given by Stefan
> > won't work in crosvm today.
> >
> > Is universal access to virtio shared memory regions actually mandated
> > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > seems reasonable enough, but what about virtio-pmem to virtio-blk?
> > What about screenshotting a framebuffer in virtio-gpu shared memory to
> > virtio-scsi? I guess with some plumbing in the VMM, it's solvable in a
> > virtualized environment. But what about when you have real hardware
> > that speaks virtio involved? That's outside my wheelhouse, but it
> > doesn't seem like that would be easy to solve.
>
> Yes, it can work for physical devices if allowed by host configuration.
> E.g. VFIO supports that I think. Don't think VDPA does.

I'm sure it can work, but that sounds more like a SHOULD (MAY?),
rather than a MUST.

> > For what it's worth, my interpretation of the target scenario:
> >
> > > Other backends don't see these mappings. If the guest submits a vring
> > > descriptor referencing a mapping to another backend, then that backen=
d
> > > won't be able to access this memory
> >
> > is that it's omitting how the implementation is reconciled with
> > section 2.10.1 of v1.3 of the virtio spec, which states that:
> >
> > > References into shared memory regions are represented as offsets from
> > > the beginning of the region instead of absolute memory addresses. Off=
sets
> > > are used both for references between structures stored within shared
> > > memory and for requests placed in virtqueues that refer to shared mem=
ory.
> >
> > My interpretation of that statement is that putting raw guest physical
> > addresses corresponding to virtio shared memory regions into a vring
> > is a driver spec violation.
> >
> > -David
>
> This really applies within device I think. Should be clarified ...

You mean that a virtio device can use absolute memory addresses for
other devices' shared memory regions, but it can't use absolute memory
addresses for its own shared memory regions? That's a rather strange
requirement. Or is the statement simply giving an addressing strategy
that device type specifications are free to ignore?

-David

