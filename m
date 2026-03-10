Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9B7F3C27D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztx5-0007g3-TV; Tue, 10 Mar 2026 06:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztwy-0007es-SI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:04:30 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztwx-0005J7-67
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:04:28 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-662b933f8d1so1699645a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773137064; cv=none;
 d=google.com; s=arc-20240605;
 b=jzEj2nVFwGhYfuBxqS3ISjFo8V0UhBKGSczucbyUl3zLphxkqPV/XUyovqF+BhHv0Q
 Vg5H0goRE/2LWFOg/az1ASwLhCcDNn381gEWqZsmlOHuxY5KxZe1Uuu/wZembQwB3Jq2
 fMYcU0aKqZ4/ZGoZFb/gQ8O+4Eay+PBbeJZCRlmCv6/ryb/sG7WrGCS0VFSCvWOgNtN+
 Ep6Bsgc+gz7OxxFHiseKkQvmLnM7tGaItX9zAd6mSok8Nm1q5xLhVFwFkpjd5w9af3Ue
 HLUOvAljJkqedKXRafZmR8+5EB7gp0pLAgq0yZL4auRuISEflInpqyObOmB+Tv0nm6xK
 WUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lTf/Ik2aPExtUzHXgqX12YaK68lKaGDqxFNC4PoiN64=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=QMsW3CDOUWN5VJevhPyYKvg9QT8NKWPdQPlZrEr2Sxj4lga6/tn3wrIY7GaEUfBTyA
 sPyBLQqlivMSgeME32xt/bm9xxc3IV0ll07yqOISHRAKUo2hksK/NKFDCJnD4LMulCan
 t7SdbgLrTArCikq7h8/ayrdN5Y1MV4s54pKWp5L82m+j/+mmnPVZY5G9ilwEvrSMhmkc
 gg2lcTH4mIH1Z54qmsksJDd8OGsdUuhEDe2ntZgZwehPaS/tywKYpZLwX4qZ5pNvuETj
 9mf5B5m2j+J24l+tjJXJwU+5L8PjgsLzIIixLZUIjuIBOby+mLmJzq6+E/3Wp7Za1MxQ
 W7RQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773137064; x=1773741864; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTf/Ik2aPExtUzHXgqX12YaK68lKaGDqxFNC4PoiN64=;
 b=EUAfflZ5jcOTf2WHhTRVuE+gb/t+IhhILHsz5wGjt9naIDytkkTS4mgSjtYKVh7cuD
 Z2x8seIITu63BTnUP6MvR1qXkgf2WmSs003GDeMCrsfx3GLWvKJ1OivAyEyI7OzyCNcE
 e/tVe/TQQrcXd8p4Vz7eprcn8SqRSt+q84H7hXHSmmwYVPwtBIUn+vzIq9nXq0HFHtZV
 PiPCgMs/FPXCK8AFlJvLJBBnfP4y8JBEnkNUVqKFFrn2Lho2BZ8jgQJghjDn3KaUhIrp
 8JdaAajHrZ8IFI6AkQLSZjxGnBN44ogsw4tLXXMfs8DltyO4cqONjoFCGvP9A+QkEl13
 0IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773137064; x=1773741864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lTf/Ik2aPExtUzHXgqX12YaK68lKaGDqxFNC4PoiN64=;
 b=k/7cT9kbeHXrn7VHg2ayfXh2eQooLa52A2lgEZlQnYNMZHOe3S30KrClOTZLKJoYmi
 T8da9t7ZLlSel14qLIJOBpq6QtEbI+on4BZxcd1hWWjFLzjV5goyrQSQoA0mDxsPQjzQ
 gMNnu4V/tXW/FXRLhUa7Mhlt0nt1NdivVObdCJm0DhLREdWRLhvl/b6nTfXr5lmh3wWy
 E4IaxJpjGCiz0A3eNuvWJRThB4WzNDzAWCGThkiCQkPTasv70LqWNoheUckrgiWyvEfK
 MO1sq0m/e3daKNFXeLYD+b1l30WNL5fwtHoNyT6Hng0ViDE5nEObWDEyTruhuMU08zLN
 ca4g==
X-Gm-Message-State: AOJu0YwimePs3UlMgybNxVJAjvqa/3I4+hLThxEtahwXWFwhaAmUnJ+r
 I4QsuPakdnxn4R2ANc9oWHXSGZtLSjU8O7c5FdFujIXy0kpiMlwkJWltXncYPVC0u9qI7AJOszM
 +tHRm2WY6/J0FFJk6zd78/Yb9akhu1Gw=
X-Gm-Gg: ATEYQzxjJG5Efg5W13Lfk1wQwxWK1hhsatuaQNj+ul2VbI5rqFaOZXC2Nogqh+1n96F
 jc5mhkKMAeA1Q63CXaXRp+fD8UADjxN7KSQq4czm19+T9UNqOZSTXhI4aXH0lSFZHyXUpU4yQ7/
 MZoICfIlnCetn+qXn1IrQfLomqlr91wf4abF3YcykZdZfPKdxpxfTYsNfGzeKQxiDwAvJhEBprB
 gAn2i5I10DWWnpkqGCHwzre76pOy/MU2wXtQZ6RH/HhS4OGkhBBVs9boN9WNJbBvpoFubRr249W
 ofdHgSg=
X-Received: by 2002:a05:6402:f12:b0:658:d1b0:9970 with SMTP id
 4fb4d7f45d1cf-6619d45a0edmr5212034a12.5.1773137064371; Tue, 10 Mar 2026
 03:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-6-zhangckid@gmail.com>
 <20260309082139.GD39949@fedora>
In-Reply-To: <20260309082139.GD39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 18:03:48 +0800
X-Gm-Features: AaiRm52vsSZAgnknTYKLY1ig-6Eni7PoRINe6TO_Yj-f-zZ55K3A1uH0lUgBDsw
Message-ID: <CAK3tnvL+yefhVo5thBw7Nq4xrR=LqrQ1xhtXTa=QEBz7OJk4-Q@mail.gmail.com>
Subject: Re: [PATCH V5 05/13] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52d.google.com
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

On Mon, Mar 9, 2026 at 4:21=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:51PM +0800, Zhang Chen wrote:
> > Replace raw object_ref/unref calls with iothread_get/put_aio_context
> > in iothread-vq-mapping. This allows tracking IOThread users via
> > the device's canonical QOM path, improving lifecycle traceability
> > for virtio-blk and virtio-scsi devices.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  hw/block/virtio-blk.c                   | 10 +++++++++-
> >  hw/scsi/virtio-scsi-dataplane.c         | 11 +++++++++--
> >  hw/virtio/iothread-vq-mapping.c         | 11 +++++------
> >  include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
> >  4 files changed, 28 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index ddf0e9ee53..b6f74df68f 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1453,14 +1453,19 @@ static bool virtio_blk_vq_aio_context_init(Virt=
IOBlock *s, Error **errp)
> >      s->vq_aio_context =3D g_new(AioContext *, conf->num_queues);
> >
> >      if (conf->iothread_vq_mapping_list) {
> > +        char *path =3D object_get_canonical_path(OBJECT(vdev));
>
> The g_free() calls can be avoided with:
>
>   g_autofree char *path =3D ...;
>
> The same applies throughout the rest of this patch series.

Make sense~ I will fix it in next version.

Thanks
Chen

