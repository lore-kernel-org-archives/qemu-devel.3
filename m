Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F83EC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp4ph-0005Uo-K0; Wed, 29 Jul 2026 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp4pe-0005UZ-SK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp4pb-0007kc-Td
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785333621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e32g8xX9tcDIlAcR2bDdawCIfJ9uMQIzd88MCdytoII=;
 b=X+aVmj5Q5Y3jB/OE3BNZElWw9k/6C+tSQgxeei5nEJHRqfta9L3RUXBlIzxSTNnzpjP2Nu
 ojAvBA9oJZXDfXAsvkLCDrZdajXD+qU5e923KcuYAZx5dba6wemMLRo0ZK/x+ZSyA6PEMg
 y+EVWPQQFtUwWeQqafbgjlcCdHgNv/E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-TWc8j2HlPwmxl0TUnPBphA-1; Wed, 29 Jul 2026 10:00:20 -0400
X-MC-Unique: TWc8j2HlPwmxl0TUnPBphA-1
X-Mimecast-MFC-AGG-ID: TWc8j2HlPwmxl0TUnPBphA_1785333620
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eec6acbe21so23040176d6.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785333620; x=1785938420; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e32g8xX9tcDIlAcR2bDdawCIfJ9uMQIzd88MCdytoII=;
 b=DzCkrNFLqponGdt+A38xx4nYsMxtpfDd1I6WqDCg0BOrLw8T92vmXTViX6RLRzIvda
 UT7/50bq+Ol+uXnXQx2WCEoQJTWXacG+hzZp54qXsLyED8lMFDp2rf5zj/OddT3dUGR3
 U6F/OHtzkI2AlD3n97AmiBj7Zd6GzUtWWQep5CifF7roarshazuMHLQhE5YtVKrlzrCu
 aKxN+09W0a7qzD7ZuWSW1i4Byf0fE7SkpVNyI/Q6rMJgW2n5GqyktNAY/Vl722wXwFxt
 xof5mlmbwW9rOwRU+cHp6+I1OTpU9Fw8AHs3ot9NRtntwcfG8vUzehlmy+uKh8liapU/
 RFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333620; x=1785938420;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e32g8xX9tcDIlAcR2bDdawCIfJ9uMQIzd88MCdytoII=;
 b=qiZq2fcJ31JggcgBBaFT0qNXGvt+EmAvhOmavZGLhefxa0TXj6b033bWfDhSEq57k1
 1tlnoHqKA4mdpP38VFuuG+BJHSOkOjokI8u3H+BiwNMtTbaV7hhlr9MRcJVKScNMqvFR
 1sUcc9dfNNSXrOq9R5qubtRKubTMVNGU9z1HalGjVTwv5eKMtd9ntJZaDb2jE23S7Gbp
 Js5GX2dvf/ZVq28HFxYst9udXJs35YNyYKAm4YUfGLexI9/4IKMlSPy9+pbQVnfSVIWQ
 TIgU+J1IRKRaYPayn5hsl/PTdTBbZJ3l9A5sE9aijiL4AXlOrn+7yKC6237O+icI7tK1
 Kg1A==
X-Gm-Message-State: AOJu0YxxtfppiXT9Js+ieFdQYZlbFanlCp4dgxN1a/0VxENgo57N78Mv
 vGHO06QTb92rnrTrVt/uwWmEAbUooMM4JvzODVvmsEYjXy04KhDMbjf/9WmMAGcORcf83gBZf+t
 0NmIT8a675ltOQVwYddDQ602RrDhK1RqVAY9YEJ+gIULqN+0+C3+lw7PO
X-Gm-Gg: AR+sD10Xf1z52pWIWCDq36ddcO2ltztW0477uzVo5SCM8RjMaOfJ67cxgoOtZ/DxO+e
 tJJeZTfrb/X86dWTsMlamce21XsXoR8TC6ee4CE1uqobC6RtRJNerVBBZcrHQbcYaYvrC0v5Xo1
 g6H8sww2SmL8br4ecR5A4ADlkjW6N6l9AZrvOba3W1/hw9O5uSyIiumA3SWjJj39FWjwpDvwDDi
 gD2B334T+bKa1DgVVLj/Y5hbLd5E1oPgoX2Gzo7oPn/GZ9UzcoAatK3vhFY9UcYoODRSbO/XzJ2
 l9PsvAPuNNCLqYnkN8TlGhJ26LrXwquS4VUnOMJFsZX5Sm32lnl2ddysogX+tP5Yw0fYvMfftEq
 qm4GGoeVKD1HZ3jYvq1n+tHpVew4=
X-Received: by 2002:a05:6214:413:b0:8e9:f5de:d613 with SMTP id
 6a1803df08f44-9081734f655mr73698796d6.50.1785333618800; 
 Wed, 29 Jul 2026 07:00:18 -0700 (PDT)
X-Received: by 2002:a05:6214:413:b0:8e9:f5de:d613 with SMTP id
 6a1803df08f44-9081734f655mr73696186d6.50.1785333616767; 
 Wed, 29 Jul 2026 07:00:16 -0700 (PDT)
Received: from x1.local (67-208-31-164.ip.tor.radiant.net. [67.208.31.164])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dd905a0sm24886366d6.44.2026.07.29.07.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:00:16 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:00:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <amoHbVsgzkYclCt2@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyqeomqz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Tue, Jul 28, 2026 at 05:57:56PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It was overlooked that VMSTATE_VBUFFER_UINT64() won't really work with an
> > uint64_t, as vmstate core only treats the size as 32bits, and maximum
> > INT32_MAX (see vmstate_size()).
> >
> > Considering that we do not need real 64bits for the size, stick with the 2G
> > limit, converting the size field into 32bits.
> >
> > Since we can't touch the wire protocol on migration from an old QEMU, we
> > can't directly modify the type of size to uint32_t.  Instead, we need to
> > introduce a temporary variable for this extremely rare issue __size_32bits
> > to be used only for VMSTATE_VBUFFER_UINT32().  Document it and name it
> > weird enough so people won't get confused on having two size variables.
> >
> > Remove VMSTATE_VBUFFER_UINT64() altogether, because it was never going to
> > be used right.  It means QEMU will only support 2G max for VMS_VBUFFER.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> > Reported-by: 김승중 <seungjung0711@gmail.com>
> > Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Fixes: 3a80ff0721 ("vhost: add vmstate for inflight region with inner buffer")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >
> > PS1: I only did smoke test as I'm not fluent with vhost inflight feature.
> > Please kindly try it out if possible. In general, migrations from older
> > QEMU should work even after applied.  One can also treat this as partly-RFC
> > from that.
> >
> > PS2: Michael, we have just discussed what we should define as CVE for
> > migration, and this one shouldn't fall into CVE category, please refer to:
> >
> > https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de
> >
> > So I didn't yet attach CVE tag.  Please correct if I'm wrong, thanks.
> > ---
> >  include/hw/virtio/vhost.h   |  5 +++++
> >  include/migration/vmstate.h | 10 ----------
> >  hw/virtio/vhost.c           | 19 ++++++++++++++-----
> >  3 files changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 684bafcaad..1d1cc24c04 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -17,6 +17,11 @@ struct vhost_inflight {
> >      int fd;
> >      void *addr;
> >      uint64_t size;
> > +    /*
> > +     * This is a temporary variable only used during migration loading to
> > +     * satisfy VMSTATE_VBUFFER_UINT32() typing. Please use @size otherwise.
> > +     */
> > +    uint32_t __size_32bits;
> >      uint64_t offset;
> >      uint16_t queue_size;
> >  };
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 1b7f295417..a349b2d84a 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -782,16 +782,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >      .offset       = offsetof(_state, _field),                        \
> >  }
> >  
> > -#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
> > -    .name         = (stringify(_field)),                             \
> > -    .version_id   = (_version),                                      \
> > -    .field_exists = (_test),                                         \
> > -    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> > -    .info         = &vmstate_info_buffer,                            \
> > -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
> > -    .offset       = offsetof(_state, _field),                        \
> > -}
> 
> Why don't you just leave this macro around, put a "do not use" comment
> above it and remove the type check for this one instance? You're already
> checking against INT32_MAX during pre_load.

What's the benefit of keeping this global macro if we only allow one user
to use it?

Commenting to say "don't use" is not guaranteeing anything, at least we
should also rename the macro to some weird name to make people notice.
Keeping the macro name like this OTOH suggests abuse.  But if we think it
should only be used in 1 place, fixing the one place might be better?

> 
> We could even lift that check up into vmstate_pre_load and reject
> there globally, don't even touch the virtio code.

Personally, I don't like the idea leaking VBUFFER impl details into
vmstate_pre_load() which is so far only a wrapper, especially only for this
one instance.. which we do not suggest future users to use.

If we go this route, I'd rather merge Michael's version to support u64,
even if we don't need a u64 size.  But I really don't want to introduce yet
another VMS flag just for this... we'll have no real use if we have noticed
this problem when the vhost inflight patch was reviewed.  It will be a
uint32_t or int32_t already.  I just can't come up with some users need
size >2G.

The recent AI reports just make such feeling stronger: we just used the
reason "max 2G, should be fine" when AI reports that unlimited size
allocation problem, now we will need to wait for another AI report which
says "it's not 2G anymore, 1<<64-1 that is", if we don't come up with a
proper limit for VMSD field allocations.

> 
> 
> /rant
> ... what's even the point of having per-type variants of VMSTATE macros
> that exist just to type-check the extra offsets (.num_offset,
> .size_offset as opposed to .offset)?
> 
> For instance, look at vmstate_n_elems casting opaque data to 32 and
> sub-32bit size and assigning to an int! What do we gain from that? It's
> circular reasoning that does nothing aside from bothering the person
> writing the vmstate.
> 
> Right? Maybe I'm missing something, it's the end of the day already.

I can also only guess, which is.. I believe Michael was right, the initial
vmstate code was simply broken where it should have considered the type of
size fields of all kinds, but forgot, and it just worked because nobody
needed u64 for a size field.

Said that, I still want to see if we can avoid introducing that at all.  To
me, I still prefer this patch (after fixing pre_save()..).  But let me know
if I didn't convince any of you.. we can discuss.

Thanks,

> 
> > -
> >  #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
> >                                       _test, _field_size) {           \
> >      .name         = (stringify(_field)),                             \
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index af41841b52..e7c570d0f5 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -2022,15 +2022,24 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
> >  static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> >  {
> >      struct vhost_inflight *inflight = opaque;
> > -
> >      int fd = -1;
> > -    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > -                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > -                                  &fd, errp);
> > +    void *addr;
> > +
> > +    if (inflight->size > INT32_MAX) {
> > +        error_setg(errp, "inflight size '%"PRIu64"' exceeds "
> > +                   "migration limit '%"PRIu32"'", inflight->size, INT32_MAX);
> > +        return false;
> > +    }
> > +
> > +    addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > +                            &fd, errp);
> >      if (!addr) {
> >          return false;
> >      }
> >  
> > +    /* Only used in VMSTATE_VBUFFER_UINT32() */
> > +    inflight->__size_32bits = inflight->size;
> >      inflight->offset = 0;
> >      inflight->addr = addr;
> >      inflight->fd = fd;
> > @@ -2042,7 +2051,7 @@ const VMStateDescription vmstate_vhost_inflight_region_buffer = {
> >      .name = "vhost-inflight-region/buffer",
> >      .pre_load_errp = vhost_inflight_buffer_pre_load,
> >      .fields = (const VMStateField[]) {
> > -        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> > +        VMSTATE_VBUFFER_UINT32(addr, struct vhost_inflight, 0, NULL, __size_32bits),
> >          VMSTATE_END_OF_LIST()
> >      }
> >  };
> 

-- 
Peter Xu


