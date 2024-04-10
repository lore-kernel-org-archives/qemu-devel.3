Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85732CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVx3-0000vV-0i; Wed, 10 Apr 2024 07:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVwn-0000jp-8B
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:57 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVwk-0001DU-IV
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:56 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e2b3e114fso6765892a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712747813; x=1713352613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XXuEyWGKyd6shOUPsOvMnxOTSgyVEg2dFYS/NWsx1Hk=;
 b=fh292kfRT3vFIbcR+zjm53gDEXxqFdeMrCYM9rSDRFPpK0B/dTYBUfhWQwSFiVrDW9
 dP9PJj06kcAHC7NFUlVteKuZ5P73tDZHU794CAwl7KyCZZUdw62qVRO4K558LYESlM5t
 k71cElgdSRmO+it/6PPA4pNnWydZCIhj0k8aKYTQ6TI0aL4K6bVfohwYLZKfRZj4hLV1
 XPsqs4ExlafhbU7JBSyG/BcSWjsJEhtOz5LjWyQadsD7ARgbkZn+wvUXQeMlnRsOZUEk
 8Lwj2GgQhXJrd7RdXn+rbZdM5e9n/YEy7bVARt3N71neoK4FD32i4ZDxvnE3bxZpC9f3
 o3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747813; x=1713352613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXuEyWGKyd6shOUPsOvMnxOTSgyVEg2dFYS/NWsx1Hk=;
 b=trxLCBYHP4EqgYdeVcOhbCaNKihb+rlhH/piMJ146r6HiS5LQf/JYJOPyQ0H6jvBU+
 1RiDUHzAbJ3kL2k5m6SkMv7g+U/6wmwufbxXH/xEcpTM41/LpNPDp10eVCR86/HkP3LO
 CKcK1OrW98jTBmVtm4S2dwC5hg6QADVsC7lAPiGtALHXpxBJiCtOnGF4iiU1Q4B1aE81
 9W3D4I6oD4eXWBg1QSwnsItgiTxvstPlpJlYJ5CKqizoEycuw6yRnlfa/zHa15Yfkzd2
 VORDzvFWsDEKNvBGGM6keyJRJ1S7E2lc+atW3nHpJekgp+XFIFdxHpQXOIKBdWuqdsVO
 XDxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdhqRMyNcpMTvHbIsMsnby9UBUJKEyvrwXNSE25sEZ+06BjZRNPigIU5cGwfIAg9mUXCnEZINvPWl9Ty9CCykx+ri56vs=
X-Gm-Message-State: AOJu0YzY13kZutJ7CJ1CpW/gtbIfQdVzl04QMYIeHUFfBMN5HrEab5IQ
 2faVJE1xzr8s/xfdye4Kii1rZAqcikO8S651LP02jA3kuVd69DccS0fVzVnIdX7Pe6HHcOBY3St
 lC2fvHVhT2KJRe6MJqu33e811keY=
X-Google-Smtp-Source: AGHT+IH6SmNE7KfCLbME02RaYkGbD4/bVZiSVYSE2JOJaBgkqvkWNzuTqa1BZxvwbZsVpWLZsW5Qb109+McIEGvC6DU=
X-Received: by 2002:a50:f61d:0:b0:566:777:af4f with SMTP id
 c29-20020a50f61d000000b005660777af4fmr1423220edn.1.1712747812674; Wed, 10 Apr
 2024 04:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
 <alpine.DEB.2.22.394.2402291510270.853156@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2402291510270.853156@ubuntu-linux-20-04-desktop>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 13:16:41 +0200
Message-ID: <CAJy5ezo=wyZnbCa5xBKNx59qVTZtrReLkgWf=_s8+db+tijOYg@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org,
 jgross@suse.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f6e3f50615bc2cf9"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f6e3f50615bc2cf9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:11=E2=80=AFAM Stefano Stabellini <sstabellini@ker=
nel.org>
wrote:

> On Tue, 27 Feb 2024, Vikram Garhwal wrote:
> > From: Juergen Gross <jgross@suse.com>
> >
> > In order to support mapping and unmapping guest memory dynamically to
> > and from qemu during address_space_[un]map() operations add the map()
> > and unmap() callbacks to MemoryRegionOps.
> >
> > Those will be used e.g. for Xen grant mappings when performing guest
> > I/Os.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
> >  include/exec/memory.h | 21 ++++++++++++++++++
> >  system/physmem.c      | 50 +++++++++++++++++++++++++++++++++----------
> >  2 files changed, 60 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 8626a355b3..9f7dfe59c7 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -282,6 +282,27 @@ struct MemoryRegionOps {
> >                                      unsigned size,
> >                                      MemTxAttrs attrs);
> >
> > +    /*
> > +     * Dynamically create mapping. @addr is the guest address to map;
> @plen
> > +     * is the pointer to the usable length of the buffer.
> > +     * @mr contents can be changed in case a new memory region is
> created for
> > +     * the mapping.
> > +     * Returns the buffer address for accessing the data.
> > +     */
> > +    void *(*map)(MemoryRegion **mr,
> > +                 hwaddr addr,
> > +                 hwaddr *plen,
> > +                 bool is_write,
> > +                 MemTxAttrs attrs);
> > +
> > +    /* Unmap an area obtained via map() before. */
> > +    void (*unmap)(MemoryRegion *mr,
> > +                  void *buffer,
> > +                  ram_addr_t addr,
> > +                  hwaddr len,
> > +                  bool is_write,
> > +                  hwaddr access_len);
> > +
> >      enum device_endian endianness;
> >      /* Guest-visible constraints: */
> >      struct {
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 949dcb20ba..d989e9fc1f 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3141,6 +3141,7 @@ void *address_space_map(AddressSpace *as,
> >      hwaddr len =3D *plen;
> >      hwaddr l, xlat;
> >      MemoryRegion *mr;
> > +    void *ptr =3D NULL;
> >      FlatView *fv;
> >
> >      if (len =3D=3D 0) {
> > @@ -3174,12 +3175,20 @@ void *address_space_map(AddressSpace *as,
> >          return bounce.buffer;
> >      }
> >
> > -
> >      memory_region_ref(mr);
> > +
> > +    if (mr->ops && mr->ops->map) {
> > +        ptr =3D mr->ops->map(&mr, addr, plen, is_write, attrs);
> > +    }
> > +
> >      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
> >                                          l, is_write, attrs);
> >      fuzz_dma_read_cb(addr, *plen, mr);
> > -    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> > +    if (ptr =3D=3D NULL) {
> > +        ptr =3D qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> > +    }
> > +
> > +    return ptr;
> >  }
> >
> >  /* Unmaps a memory region previously mapped by address_space_map().
> > @@ -3195,11 +3204,16 @@ void address_space_unmap(AddressSpace *as, void
> *buffer, hwaddr len,
> >
> >          mr =3D memory_region_from_host(buffer, &addr1);
> >          assert(mr !=3D NULL);
> > -        if (is_write) {
> > -            invalidate_and_set_dirty(mr, addr1, access_len);
> > -        }
> > -        if (xen_enabled()) {
> > -            xen_invalidate_map_cache_entry(buffer);
> > +
> > +        if (mr->ops && mr->ops->unmap) {
> > +            mr->ops->unmap(mr, buffer, addr1, len, is_write,
> access_len);
> > +        } else {
> > +            if (is_write) {
> > +                invalidate_and_set_dirty(mr, addr1, access_len);
> > +            }
> > +            if (xen_enabled()) {
> > +                xen_invalidate_map_cache_entry(buffer);
> > +            }
> >          }
> >          memory_region_unref(mr);
> >          return;
> > @@ -3272,10 +3286,18 @@ int64_t
> address_space_cache_init(MemoryRegionCache *cache,
> >           * doing this if we found actual RAM, which behaves the same
> >           * regardless of attributes; so UNSPECIFIED is fine.
> >           */
> > +        if (mr->ops && mr->ops->map) {
> > +            cache->ptr =3D mr->ops->map(&mr, addr, &l, is_write,
> > +                                      MEMTXATTRS_UNSPECIFIED);
> > +        }
> > +
> >          l =3D flatview_extend_translation(cache->fv, addr, len, mr,
> >                                          cache->xlat, l, is_write,
> >                                          MEMTXATTRS_UNSPECIFIED);
> > -        cache->ptr =3D qemu_ram_ptr_length(mr->ram_block, cache->xlat,
> &l, true);
> > +        if (!cache->ptr) {
> > +            cache->ptr =3D qemu_ram_ptr_length(mr->ram_block,
> cache->xlat, &l,
> > +                                             true);
> > +        }
> >      } else {
> >          cache->ptr =3D NULL;
> >      }
> > @@ -3297,14 +3319,20 @@ void
> address_space_cache_invalidate(MemoryRegionCache *cache,
> >
> >  void address_space_cache_destroy(MemoryRegionCache *cache)
> >  {
> > -    if (!cache->mrs.mr) {
> > +    MemoryRegion *mr =3D cache->mrs.mr;
> > +
> > +    if (!mr) {
> >          return;
> >      }
> >
> > -    if (xen_enabled()) {
> > +    if (mr->ops && mr->ops->unmap) {
> > +            mr->ops->unmap(mr, cache->ptr, cache->xlat, cache->len,
> > +                           cache->is_write, cache->len);
> > +    } else if (xen_enabled()) {
> >          xen_invalidate_map_cache_entry(cache->ptr);
> >      }
> > -    memory_region_unref(cache->mrs.mr);
> > +
> > +    memory_region_unref(mr);
> >      flatview_unref(cache->fv);
> >      cache->mrs.mr =3D NULL;
> >      cache->fv =3D NULL;
> > --
> > 2.17.1
> >
>
>

--000000000000f6e3f50615bc2cf9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 1, 2024 at 12:11=E2=80=AF=
AM Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.org">sstabel=
lini@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Tue, 27 Feb 2024, Vikram Garhwal wrote:<br>
&gt; From: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" target=3D"_=
blank">jgross@suse.com</a>&gt;<br>
&gt; <br>
&gt; In order to support mapping and unmapping guest memory dynamically to<=
br>
&gt; and from qemu during address_space_[un]map() operations add the map()<=
br>
&gt; and unmap() callbacks to MemoryRegionOps.<br>
&gt; <br>
&gt; Those will be used e.g. for Xen grant mappings when performing guest<b=
r>
&gt; I/Os.<br>
&gt; <br>
&gt; Signed-off-by: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" ta=
rget=3D"_blank">jgross@suse.com</a>&gt;<br>
&gt; Signed-off-by: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd=
.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br>
<br>
Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.or=
g" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br></blockquote><div><b=
r></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.igl=
esias@amd.com">edgar.iglesias@amd.com</a>&gt;=C2=A0</div><div><br></div><di=
v><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; ---<br>
&gt;=C2=A0 include/exec/memory.h | 21 ++++++++++++++++++<br>
&gt;=C2=A0 system/physmem.c=C2=A0 =C2=A0 =C2=A0 | 50 ++++++++++++++++++++++=
+++++++++++----------<br>
&gt;=C2=A0 2 files changed, 60 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/exec/memory.h b/include/exec/memory.h<br>
&gt; index 8626a355b3..9f7dfe59c7 100644<br>
&gt; --- a/include/exec/memory.h<br>
&gt; +++ b/include/exec/memory.h<br>
&gt; @@ -282,6 +282,27 @@ struct MemoryRegionOps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned siz=
e,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAttrs a=
ttrs);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Dynamically create mapping. @addr is the guest =
address to map; @plen<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* is the pointer to the usable length of the buff=
er.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* @mr contents can be changed in case a new memor=
y region is created for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* the mapping.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Returns the buffer address for accessing the da=
ta.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 void *(*map)(MemoryRegion **mr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr =
addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr =
*plen,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool is=
_write,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAt=
trs attrs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Unmap an area obtained via map() before. */<br>
&gt; +=C2=A0 =C2=A0 void (*unmap)(MemoryRegion *mr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *=
buffer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_ad=
dr_t addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr=
 len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool i=
s_write,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr=
 access_len);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 enum device_endian endianness;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Guest-visible constraints: */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct {<br>
&gt; diff --git a/system/physmem.c b/system/physmem.c<br>
&gt; index 949dcb20ba..d989e9fc1f 100644<br>
&gt; --- a/system/physmem.c<br>
&gt; +++ b/system/physmem.c<br>
&gt; @@ -3141,6 +3141,7 @@ void *address_space_map(AddressSpace *as,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr len =3D *plen;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr l, xlat;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr;<br>
&gt; +=C2=A0 =C2=A0 void *ptr =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 FlatView *fv;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (len =3D=3D 0) {<br>
&gt; @@ -3174,12 +3175,20 @@ void *address_space_map(AddressSpace *as,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return bounce.buffer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_ref(mr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;map) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mr-&gt;ops-&gt;map(&amp;mr, addr,=
 plen, is_write, attrs);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *plen =3D flatview_extend_translation(fv, addr, le=
n, mr, xlat,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 l, is_write, attrs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fuzz_dma_read_cb(addr, *plen, mr);<br>
&gt; -=C2=A0 =C2=A0 return qemu_ram_ptr_length(mr-&gt;ram_block, xlat, plen=
, true);<br>
&gt; +=C2=A0 =C2=A0 if (ptr =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D qemu_ram_ptr_length(mr-&gt;ram_bl=
ock, xlat, plen, true);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ptr;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Unmaps a memory region previously mapped by address_space_map=
().<br>
&gt; @@ -3195,11 +3204,16 @@ void address_space_unmap(AddressSpace *as, voi=
d *buffer, hwaddr len,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D memory_region_from_host(buffe=
r, &amp;addr1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(mr !=3D NULL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_write) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 invalidate_and_set_dirty(mr=
, addr1, access_len);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xen_enabled()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_invalidate_map_cache_en=
try(buffer);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;=
unmap) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mr-&gt;ops-&gt;unmap(mr, bu=
ffer, addr1, len, is_write, access_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_write) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 invalidate_an=
d_set_dirty(mr, addr1, access_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xen_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_invalidat=
e_map_cache_entry(buffer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_unref(mr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; @@ -3272,10 +3286,18 @@ int64_t address_space_cache_init(MemoryRegionC=
ache *cache,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* doing this if we found actua=
l RAM, which behaves the same<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* regardless of attributes; so=
 UNSPECIFIED is fine.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;=
map) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cache-&gt;ptr =3D mr-&gt;op=
s-&gt;map(&amp;mr, addr, &amp;l, is_write,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMTXATTRS_=
UNSPECIFIED);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l =3D flatview_extend_translation(ca=
che-&gt;fv, addr, len, mr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cache-&gt;xlat, l, is_write,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MEMTXATTRS_UNSPECIFIED);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cache-&gt;ptr =3D qemu_ram_ptr_length(mr-=
&gt;ram_block, cache-&gt;xlat, &amp;l, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cache-&gt;ptr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cache-&gt;ptr =3D qemu_ram_=
ptr_length(mr-&gt;ram_block, cache-&gt;xlat, &amp;l,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cache-&gt;ptr =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -3297,14 +3319,20 @@ void address_space_cache_invalidate(MemoryRegi=
onCache *cache,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void address_space_cache_destroy(MemoryRegionCache *cache)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 if (!cache-&gt;<a href=3D"http://mrs.mr" rel=3D"norefer=
rer" target=3D"_blank">mrs.mr</a>) {<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D cache-&gt;<a href=3D"http://mrs.mr=
" rel=3D"noreferrer" target=3D"_blank">mrs.mr</a>;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (xen_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;unmap) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mr-&gt;ops-&gt;unmap(mr, ca=
che-&gt;ptr, cache-&gt;xlat, cache-&gt;len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0cache-&gt;is_write, cache-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 } else if (xen_enabled()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_invalidate_map_cache_entry(cache=
-&gt;ptr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 memory_region_unref(cache-&gt;<a href=3D"http://mrs.mr"=
 rel=3D"noreferrer" target=3D"_blank">mrs.mr</a>);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_unref(mr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 flatview_unref(cache-&gt;fv);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cache-&gt;<a href=3D"http://mrs.mr" rel=3D"norefer=
rer" target=3D"_blank">mrs.mr</a> =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cache-&gt;fv =3D NULL;<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000f6e3f50615bc2cf9--

