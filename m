Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CC4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 23:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxawG-00006K-Qb; Thu, 18 Apr 2024 19:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rxawF-000068-Hl
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:13:07 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rxawD-0003Hm-Kz
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:13:07 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7da4373f850so22254139f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713481983; x=1714086783; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0echXWymO1qCOzsNTL55kwNLt6HeSSpMUSWl9KxIRrg=;
 b=GYakNZMduIHfrBZyocDw2Cnxn22KWXNTxEi0aFDYPfQhYl/jRALU5x6CFNI9/5k0VP
 p0ht8JoKNYsKGCp70WWAf3SxWKq3gfZG/0RLAFNed6fPVQwgtSc5eBl2zpxiv584tnq3
 9MyKABYz5o8ltpMTzEBV169bpLqnYRVHVMehqr0OYHcVxXLObLdwslJ1UrnrggUZkZ3h
 Oi2qygQUH7DbzK8QMSq8PuimIZk9j2hSslcShS2vP7/0O18vjUBKobjBxoDb1MmdM7gw
 s/vFFUeK8WtNWquakkjI5zQ7jaaTsEN2T6pmfO0I+EYmmOvFLJXhYzD4bXDE37HRiRT5
 AEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713481983; x=1714086783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0echXWymO1qCOzsNTL55kwNLt6HeSSpMUSWl9KxIRrg=;
 b=P748JjgQS3cmyGTnmiGwaZuFC1XsVidfIlXGHEkpBT9HBRnAoLGSeqGyvnpX3nzyYk
 F7c2ty0SejHMitGNDwXd3VCNSFvaxskWMcgk/1VfpZUNMOUJXj7Mr5BI5VvqjFgTbbsN
 8yKchmckZK0SB7WnDaJocUjpjs8hXsVTcnARNXiuzWZD4PnKB7jTj+X1tpHVZG3as5bm
 eRmzZxAs5jza+pPb+DIR6Yc6+2yXODIV91e0tANCHFgaMfH4TZBj3baiEkdyvy03ePul
 wzT0e65GWW6XX36atjzwPS7s0rCHKg2Fxoj9fi8kGrorhFPxcQPLNbfQoPaqJGrWcVsg
 KJAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo2QYZUZQIi/8Zz9lJncrApMyePTbdIeOEdZxPTquh6DujDmPzTnZg+0gi617uN9rjeSzegmKhmjxouFw5ZjbM7dDl7hE=
X-Gm-Message-State: AOJu0Yy8jx4Cf340gzeSMUzJKGyPYyuyGxUXewF4VVfWoSpUap19VkwN
 m+5Q5BAx3o9PpuenVYAhrFxFpR+b8lqOL6WsHPGCaLqejI+lhasI6eY4uk7l0YmwEfQ0xFbp3fq
 XgXyGGiTzSAZ5oNSRc4wRwp4I+dA=
X-Google-Smtp-Source: AGHT+IETR25e2pOFZAh9x9cZdSfQF5OGCrVzkSUHVT893A0LznTLu4RdCRnb6qJby4Zp04bKKS2Vb/iStvdKFlSOL94=
X-Received: by 2002:a6b:e016:0:b0:7da:1a9f:cabc with SMTP id
 z22-20020a6be016000000b007da1a9fcabcmr793762iog.3.1713481983431; Thu, 18 Apr
 2024 16:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240113012741.54664-1-masscry@gmail.com>
 <20240113012741.54664-2-masscry@gmail.com>
 <ZiEmbvuzbpy-ERDh@redhat.com>
In-Reply-To: <ZiEmbvuzbpy-ERDh@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 18 Apr 2024 16:12:52 -0700
Message-ID: <CAFubqFtpTsivh08V0MkHGJO11g62dUU7kq01yBB=aJ6VVEC-9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] libvhost-user: Fix pointer arithmetic in indirect read
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Temir Zharaspayev <masscry@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The change looks right to me. As is, it looks like the code is
skipping over descriptors when the intent should be to bounce data
into a single descriptor.

I agree the variable rename should go in as a separate change.

On Thu, Apr 18, 2024 at 6:56=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sat, Jan 13, 2024 at 04:27:40AM +0300, Temir Zharaspayev wrote:
> > When zero-copy usage of indirect descriptors buffer table isn't
> > possible, library gather scattered memory chunks in a local copy.
> > This commit fixes the issue with pointer arithmetic for the local copy
> > buffer.
> >
> > Signed-off-by: Temir Zharaspayev <masscry@gmail.com>
> > ---
> >  subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/li=
bvhost-user/libvhost-user.c
> > index 6684057370..e952c098a3 100644
> > --- a/subprojects/libvhost-user/libvhost-user.c
> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > @@ -2307,7 +2307,7 @@ static int
> >  virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
> >                               uint64_t addr, size_t len)
> >  {
> > -    struct vring_desc *ori_desc;
> > +    uint8_t *src_cursor, *dst_cursor;
> >      uint64_t read_len;
> >
> >      if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
> > @@ -2318,17 +2318,18 @@ virtqueue_read_indirect_desc(VuDev *dev, struct=
 vring_desc *desc,
> >          return -1;
> >      }
> >
> > +    dst_cursor =3D (uint8_t *) desc;

Nit - no space on cast

> >      while (len) {
> >          read_len =3D len;
> > -        ori_desc =3D vu_gpa_to_va(dev, &read_len, addr);
> > -        if (!ori_desc) {
> > +        src_cursor =3D vu_gpa_to_va(dev, &read_len, addr);
> > +        if (!src_cursor) {
> >              return -1;
> >          }
> >
> > -        memcpy(desc, ori_desc, read_len);
> > +        memcpy(dst_cursor, src_cursor, read_len);
> >          len -=3D read_len;
> >          addr +=3D read_len;
> > -        desc +=3D read_len;
> > +        dst_cursor +=3D read_len;
>
> The ori_desc -> src_cursor changes don't look to have any functional
> effect. Having that change present obscures the functional part of
> the patch, which is this line. FWIW, it is generally preferrable to
> not mix functional and non-functional changes in the same patch
>
> It now interprets 'read_len' as the number of bytes to increment the
> address by, rather than incrementing by the number of elements of
> size 'sizeof(struct vring_desc)'.
>
> I don't know enough about this area of QEMU code to say which
> semantics were desired, so I'll defer to the Michael as maintainer
> to give a formal review.
>
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
>

