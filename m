Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8D5C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 15:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueawe-0002hG-Nt; Wed, 23 Jul 2025 10:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ueawL-0002LJ-Hf
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 10:59:32 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ueawJ-0007Lv-Ib
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 10:59:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0de1c378fso1000287066b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753282765; x=1753887565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dC4n8JrJKl8Wy6jxvz/Bik6DDlO+c3RQNwy5G9GFTqo=;
 b=ZJ4TSmg1Dy/7GJJk3ft7E4sVIB51hfxUIRh1Ed2VA40lPsV4c7Z4uQlQXeRs33GoU+
 IeBVB1vifqo9V+YH0ICxXuMxSzy80dp2IZIXCSoXZm8yGghn5ajc3ICbblSxLlLxlHy1
 C/TVoTxcW5s7VBQSHVieeBJM1oY68c+NsAsXUxmrCwqCqdsyFBTTX3B5IIvG+6oTWeEa
 dVFfmAUyyITRTXhUJofCl/jV4rzuncqXxScIRZEXxB1cbrcj5m2beT9c4ZVchMOS3nM2
 l1GGlsz9DURApyyLiMHu2cvvgBsRKwk37bIt3mRr3YfMAVEx0oE4642pXYew2lQ439Gq
 p8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753282765; x=1753887565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dC4n8JrJKl8Wy6jxvz/Bik6DDlO+c3RQNwy5G9GFTqo=;
 b=EkFre9STabzzcVzWjfrZq/OlnVAQHrJm7muPHjfqxYUUJK5oaOI8Xb2lDr1y5IA9vp
 l8e7JGlKsh5U8ag1VMV0o5J1yp8rva8bqnglG7QwgejvEfv31GTWgOjhF7kOMAyVk7aA
 fgNNgEQz3p/T74esG4JOQWx+DYBPzlR/5xQZKQwgadp9auudJkvlMcbSSlcOEwOufxYH
 abrZtBhUhlIKau6OGqwLFNVXZ8waANllP/DNsau/oI0tG8Xb5ACilx5N3yxTWNtk/eI1
 rsfzheturN7qZnZ9OHnKzp/5+gN34hgqsnCRJB6f9Dk6pYJRyny3SFP1cTn56I4JjUTf
 nVlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvadWGAud7v1j3NFbRqzZ6RN/DIUzyA6yiEGlpjT+h6q2qGVEmCEbybID/PGEqnI3OpOzZpoLJ5Gw3@nongnu.org
X-Gm-Message-State: AOJu0YxDpT7XuslXMnyzr9qqfuWz3X15F3qYrl9JVntLHbBUrxI3v7/S
 PiueFaoT+Yi5of6g5NouduY3ybbtVhcXPOZ50BVXUe9wCU1KexIh2d6X2Io7nYHSClQS0eVCqHe
 U6C5qj1lMSSQNrLfMgOk3y2CIFuYMadI=
X-Gm-Gg: ASbGnctH699SPcLj3U4N2CNSvsio/+Cu4lERH+wA93BnBKOS5i9E3uaWpxPbaoUEkCX
 sVYVYKtf/I7L/bjAN13VHBJIK+GTyi+3PjChbeRajgp7Lu/ym62Tqcs3ivUr2oWjJY6NzbKX4GD
 gcWQAK5XRbDwFjxZ2k+o2HGXVgJPQ66ClLCbMnRrQvuqwbBCu9Eg8IwuMBnrdPR/xv9Y+KBmA3S
 Uycuw==
X-Google-Smtp-Source: AGHT+IH0bOcxpwAlWaItInbnQ6JavgqAN6AjbZbw0dLTCj7tuERb6ZwEr33nUaZLukPRmFQb56XFxevmfNkq8fDVm3Y=
X-Received: by 2002:a17:907:2d12:b0:ae0:bee7:ad7c with SMTP id
 a640c23a62f3a-af2f8d4fb14mr334393366b.46.1753282765151; Wed, 23 Jul 2025
 07:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250723121920.1184928-1-aesteve@redhat.com>
 <f35f2cfc-2bc1-40b4-8dd2-f7ac34cbd317@linaro.org>
 <CADSE00Lp0W_nsUqqTz7=JmyzLuJjMdOq8WkFXeBAtOxe-yDCPg@mail.gmail.com>
In-Reply-To: <CADSE00Lp0W_nsUqqTz7=JmyzLuJjMdOq8WkFXeBAtOxe-yDCPg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 23 Jul 2025 10:59:12 -0400
X-Gm-Features: Ac12FXzfst3HL2xcyRkTcOQGGCVMpDDZiCXUz8DqwutOStJSUz8zziwkgSfpWms
Message-ID: <CAJSP0QWqRij-dfsBCv9YRCJ_toDG6446ciVxbFDEytbQ_6iFrw@mail.gmail.com>
Subject: Re: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
To: Albert Esteve <aesteve@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, stefanha@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62d.google.com
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

On Wed, Jul 23, 2025 at 8:44=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Wed, Jul 23, 2025 at 2:32=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > Hi,
> >
> > On 23/7/25 14:19, Albert Esteve wrote:
> > > In the last version of the SHMEM MAP/UNMAP [1] there was a
> > > comment [2] from Stefan about the lifecycle of the memory
> > > regions.
> > >
> > > After some discussion, David Hildenbrand proposed
> > > to detect RAM regions and handle refcounting differently
> > > to clear the initial concern. This RFC patch is
> > > meant for gathering feedback from others
> > > (i.e., Paolo Bonzini and Peter Xu).
> > >
> > > [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D46=
0121
> > > [2] https://patchwork.ozlabs.org/comment/3528600/
> > >
> > > ---
> > >
> > > This patch enhances memory_region_ref() and memory_region_unref()
> > > to handle RAM and MMIO memory regions differently, improving
> > > reference counting semantics.
> > >
> > > RAM regions now reference/unreference the memory region object
> > > itself, while MMIO continue to reference/unreference the owner
> > > device as before.
> > >
> > > An additional qtest has been added to stress the memory
> > > lifecycle. All tests pass as these changes keep backward
> > > compatibility (prior behaviour is kept for MMIO regions).
> > >
> > > Signed-off-by: David Hildenbrand <david@redhat.com >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >   system/memory.c            | 22 +++++++++++++----
> > >   tests/qtest/ivshmem-test.c | 50 +++++++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 67 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 5646547940..48ab6e5592 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -1826,6 +1826,14 @@ Object *memory_region_owner(MemoryRegion *mr)
> > >
> > >   void memory_region_ref(MemoryRegion *mr)
> > >   {
> > > +    /* Regions without an owner are considered static. */
> > > +    if (!mr || !mr->owner) {
> > > +        return;
> > > +    }
> > > +    if (mr->ram) {
> > > +        object_ref(OBJECT(mr));
> > > +        return;
> > > +    }
> > >       /* MMIO callbacks most likely will access data that belongs
> > >        * to the owner, hence the need to ref/unref the owner whenever
> > >        * the memory region is in use.
> > > @@ -1836,16 +1844,20 @@ void memory_region_ref(MemoryRegion *mr)
> > >        * Memory regions without an owner are supposed to never go awa=
y;
> >
> > What are the use cases for MRs without QOM owner?
>
> Not sure if you are asking about the logic or the actual usecases
> where these MRs would make sense.
>
> Regarding the logic, note the early return at the beginning of the
> function, so that this comment is kept valid. In short, nothing
> changes.
>
> Regarding the usecases for these type of memories, I can think of
> system memory or container regions as examples. But there are
> certainly more experienced people in this thread that can answer you
> better than me.

I had similar thoughts to Phil when reading the commit description. It
says what the patch is doing but does not really describe why.

Please update the commit description to state why RAM regions need
different refcount semantics.

Stefan

