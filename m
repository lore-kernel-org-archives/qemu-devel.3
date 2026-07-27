Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03883C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 22:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woTvt-0002C4-1g; Mon, 27 Jul 2026 18:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woTvr-0002Br-0Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 18:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woTvo-0000x1-9g
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 18:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785191778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AamPDT0RsMKL/XN/Ip5Kf7imyrIVA9PhTZ+jfhTlZkE=;
 b=ARqarTe4kmJboPR3O+6lP/5AVO236NY1/qo0Dtro+RiZniatsRrH735WAqISn4h1IrmIIL
 p4OoUxQzPt/qjorkGs7zvZIuRlrWLgi+jwUKU0RXxlIu03//pcTA44BB0yBLFX3/0+3tyD
 sQQ34fwNGldPOOlrmsNotjxnCUEyBeE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-6AoVUzgEOoqCTKHXKecTtA-1; Mon, 27 Jul 2026 18:36:17 -0400
X-MC-Unique: 6AoVUzgEOoqCTKHXKecTtA-1
X-Mimecast-MFC-AGG-ID: 6AoVUzgEOoqCTKHXKecTtA_1785191776
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso2092775f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785191776; x=1785796576; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AamPDT0RsMKL/XN/Ip5Kf7imyrIVA9PhTZ+jfhTlZkE=;
 b=KQgTDwid/gHPUNkoqfAtcXE8vvLtE2lxnMGQfyWond5tmPxfQifobx+lKm1XS5s3qS
 cenYBtZ5gUAqpmP+eqnHnBIBL9HiDk67UtdUivyT3ad6jzpbluMWKViyvydrTddHLu7X
 VMHL4vAKuROuPxHwZtOvNMsVyYKyYXwGAT4Dl06J8MQHGQCXX1UzsitqCSOyvxK7NjOp
 Koj9RR1EsXlW2hWhvmTJJ4f7rOV0Huo/q341hntaP46ACHW4eamVl5cbOYbPyz+or1k0
 bY1OG2tCFO0mcZxwkMMhtalEANUttkmGzPms8vBMJ3iKI9ihxbwZpfoLjpz2xa8NUm9I
 3H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785191776; x=1785796576;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AamPDT0RsMKL/XN/Ip5Kf7imyrIVA9PhTZ+jfhTlZkE=;
 b=JmfniTvDhE8ZonhWYVpDP0CPmQ8HPvjId87y+T1pbWbOBDJO4lxCVlSdbhBadU5QKK
 NT7o0lybfk3pxZyDqaXDp8xomsBuLtrWO0v1kZ1l+kNTLerVkQkp4ZNrhLzYi6LiB9zP
 4pAUF5eDLSbOGWTqVUkBfW6EwInDTxa6hXgB0tYn5tL6VmhVFhGALI35nq6RXzgaqu/D
 cXhUGPV5GkMDY5DcjM3WTTuV880pZ3qgGgLBeHZDsHI9UuRL145/mOo67KlH5SjMUsvx
 fornBtNuXM/5VJKXVhCWz8AR9V7dwv7WxpRKCN4LS2SEQ5uwfNaVkm+OBPCS9Wylefma
 ji+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrumCgZ4VU5N0E5VWksrz5Q0mnL3MeQnorCDz4JdGktlv8lfyf5OjMIKqGSdY9oyKjKzeYXvcXzY2YQ@nongnu.org
X-Gm-Message-State: AOJu0YyifM2Vatj9815MgxXGap+Cha9FuxAeUjPzt9XjJm21iCJ/kKZh
 jv4Td0Qt2z0F0Tvysf8NXk2nvzSRgxV/41RuoJTfvs48UW4rllZQa0T64npJhCKeJRWFIn9BJcP
 Kq+OxtOe/x9Vr3tTxAkitPNWIAazNbCazyX6oNn3xPNHIY4Xk/uReQQe6
X-Gm-Gg: AR+sD113dqMA5+QaaqvslyebEo6cKcmsetiQIqsQpjIzQdI0FMVdzkth7xB6BGRKoSL
 MCZEzrnCpKBaJUoTNnmXFgQ4TmnwCJmz42kb66ZmoSsDRemMVcKDFFV+iOayEdKDjqUUkR67m+S
 EI7HyTFTUm2GqkcJ5QUKTfFDUi7dcn60KJUsPFhTFx+bcqPg4JBSrFKv136rY0X6lO9GDFCu70F
 dNP4G3YTmF4Y6tjumUOWFcxzEVwN3gDC3klTOCqqgBNYj0IbCXOJoubTJci3zAV9DOAM+9Zf5V1
 UPGkmJcB8vTuBnUgcTHqsX3tkjEs4CQUrkkO8VOHo/WOitm9+0AMTLpcwnVa/eq7qKlQr0pkgG8
 MsH1NaZbjbELijuTMLZnZtQ==
X-Received: by 2002:a5d:59c4:0:b0:47f:9aef:5515 with SMTP id
 ffacd0b85a97d-47fafa65ecfmr969638f8f.13.1785191775510; 
 Mon, 27 Jul 2026 15:36:15 -0700 (PDT)
X-Received: by 2002:a5d:59c4:0:b0:47f:9aef:5515 with SMTP id
 ffacd0b85a97d-47fafa65ecfmr969624f8f.13.1785191774977; 
 Mon, 27 Jul 2026 15:36:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bc62basm55510078f8f.13.2026.07.27.15.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 15:36:14 -0700 (PDT)
Date: Mon, 27 Jul 2026 18:36:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PULL 17/30] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
Message-ID: <20260727183122-mutt-send-email-mst@kernel.org>
References: <cover.1785101237.git.mst@redhat.com>
 <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
 <CADLectmKQT+hU_3TG2Popan8f5QphEEpwsR+Ps=+WTZo-Z_M_Q@mail.gmail.com>
 <20260727045220-mutt-send-email-mst@kernel.org>
 <amdT6P4esRDwyRX4@x1.local>
 <20260727150152-mutt-send-email-mst@kernel.org>
 <ame_w-nz7mPbKfOV@x1.local>
 <20260727164036-mutt-send-email-mst@kernel.org>
 <874ihkoz28.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ihkoz28.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Jul 27, 2026 at 07:19:43PM -0300, Fabiano Rosas wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Jul 27, 2026 at 04:29:55PM -0400, Peter Xu wrote:
> >> On Mon, Jul 27, 2026 at 03:06:38PM -0400, Michael S. Tsirkin wrote:
> >> > On Mon, Jul 27, 2026 at 08:49:44AM -0400, Peter Xu wrote:
> >> > > On Mon, Jul 27, 2026 at 04:53:15AM -0400, Michael S. Tsirkin wrote:
> >> > > > On Sun, Jul 26, 2026 at 08:31:57PM -0400, Peter Xu wrote:
> >> > > > > This patch is migration only change and hasn't been reviewed.  Give us a few
> >> > > > > days to review it?
> >> > > > > Can't do it now because it is on cellphone and I just bathed my son.
> >> > > > > 
> >> > > > > Please hold off merging.
> >> > > > > 
> >> > > > > Thanks.
> >> > > > 
> >> > > > OK.  I'll drop this and you will merge it through the migration tree
> >> > > > as appropriate?
> >> > > 
> >> > > Let's drop it first so it won't block this pull.  I can definitely pick it
> >> > > up when ready, but I want to discuss on how to fix first.  Which tree to
> >> > > pick it up isn't a huge matter to me, but the review.
> >> > > 
> >> > > We found a bunch of randomly introduced VMSTATE flags in the past, I used
> >> > > to remove some, at least my plan is in the future each time we introduce a
> >> > > new one (by request from other modules) we better justify it before landing
> >> > > too easily, in case it needs a revert again.
> >> > > 
> >> > > This vhost regression started 11.0 so IIUC we don't need to rush in 11.1.
> >> > > I just noticed I read that patch and didn't notice this, my bad to not have
> >> > > noticed..
> >> > > 
> >> > > For this one specifically..
> >> > > 
> >> > > > 
> >> > > > > On Sun, Jul 26, 2026, 5:29 p.m. Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > > > > 
> >> > > > >     vhost user currently saves the inflight buffer to the migration stream
> >> > > > >     using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
> >> > > > >     backend.
> >> > > > > 
> >> > > > >     But the implementation of that is broken if size is >2G: it stores the
> >> > > > >     buffer size in a uint64_t field, but vmstate_size() always reads the
> >> > > > >     size field as int32_t regardless of the macro used. This, in turn,
> >> > > > >     causes negative or truncated lengths on load, leading to undersized
> >> > > > >     allocations and down the road out-of-bounds buffer access.
> >> > > > > 
> >> > > > >     There's no practical reason to support such large sizes, so it's enough
> >> > > 
> >> > > If there's no real demand to use 2G or more, I suggest we change size to
> >> > > int32_t instead on the user, and revert f6fdd8b2 VMSTATE_VBUFFER_UINT64().
> >> > 
> >> > We can't just change it we'll need some tricks to avoid breaking existing
> >> > migration format. I don't see how it will be much simpler if you take
> >> > that into account.
> >> 
> >> It's not part of the stream, right?
> >
> > I think it is?
> >
> > VMSTATE_UINT64(size, struct vhost_inflight) at hw/virtio/vhost.c
> > eventually leads to qemu_put_be64s / qemu_get_be64s in migration/vmstate-types.c
> >
> 
> The point is that this "size" is already included on the stream by
> itself, changing the VMSTATE_VBUFFER_UINT64 to int32 doesn't affect
> it.


I'd use uint32_t there is no reason to use signed.


> 
> There's a type_check that will complain during save that
> type(inflight->size) != INT32 (from the macro), but we can change that.
> 
> #define vmstate_offset_value(_state, _field, _type)                  \
>     (offsetof(_state, _field) +                                      \
>      type_check(_type, typeof_field(_state, _field)))
> 

All i am saying we need to keep some special macro we can not just
change virtio to replace VMSTATE_VBUFFER_UINT64 with
VMSTATE_VBUFFER_UINT32

whether it's a flag or whatever, I don't much care.

I assigned the bug in question to Peter and you guys decide
how to handle it.


> >> Here IIUC the VMSD field "size" only hard-coded the binary offset to fetch
> >> the int32_t from the object* pointer.  IIUC we can simply change it to
> >> int32_t and IIUC it will be able to recv stream from src with uint64_t.
> >> The stream shouldn't be affected when e.g. we migrate from an older QEMU.
> >
> >
> > I don't really know what you mean. Yes vmsd macros tie migration stream
> > and the storage format. it kinda makes it easy to add one but the
> > cost is issues like this.
> >
> >
> >
> >
> >> > 
> >> > > Fabiano and I were looking at rest 20+ possible security related bugs in
> >> > > the past 1-2 weeks, I've some patches to be posted for 11.2 too when we
> >> > > went through all of them. One relevant patch I haven't sent but will do
> >> > > soon:
> >> > > 
> >> > > https://gitlab.com/peterx/qemu/-/commit/afd2cb25defdf78a4ab5279cc16634884792c57a
> >> > > 
> >> > > We encountered quite a few of possible over-allocation on destionation side
> >> > > by manipulating on-wire length field like this one, I believe Fabiano is
> >> > > looking at how to further limit that from 2G if ever possible per-user.
> >> > > 
> >> > > I'm not sure if that idea will fly, but I think anything bigger than 2G
> >> > > definitely is not suggested for now when it's only for a type match not
> >> > > real demand..
> >> > 
> >> > Frankly 2G is crazy too. I see little reason to focus specifically on >2G.
> >> 
> >> Yeah..
> >> 
> >> > 
> >> > 
> >> > > I believe VMSTATE_VBUFFER_UINT32 is problematic on its own too, I'll see
> >> > > how to fix that.  That one is slightly easier, worst case is we bail out
> >> > > for 2G (hence ignore bit 31, which shouldn't be used in reality for legit
> >> > > users), but I'll think about it.
> >> > > 
> >> > > Thanks,
> >> > 
> >> > I just do not see (almost) any case where migration destination
> >> > does not know the actual size needed, or at least
> >> > an upper bound on such.
> >> 
> >> In many cases we transfer the length first then the array following that
> >> with the length.  That's a common trick we played like vhost here.
> >
> > we need to start specifying the cap for these.
> >
> 
> I agree. Most things will have a sane cap once you think hard enough. Of
> course, there's a risk of selecting a limit too low, but currently we
> can't even do that.
> 
> I think the first step is defining new macros so that every len/size/etc
> gets properly identified. The VMSTATE_VBUFFER_* are already a start, we
> can add an aditional member that doesn't go on the stream and check
> against it when loading.

right

> > The upper bound is indeed a challenge, I confess I don't know an answer,
> > and we will need to be careful on adding anything that might break a legit
> > user.  I believe Fabiano might have some better clue there, so I'd leave it
> > to him until I can read his patches.
> > 
> 
> I'm also trying to look ahead into how we'll apply whatever fix we come
> up with here to the pile of unstructured qemu_put|get_byte we have all
> over the place. I'm experimenting with how much code we can convert into
> VMStateDescription/VMStateField. The QEMU_VM_* flags themselves seem to
> be easy to do (then we version the vmstate, deprecate, etc). 

Frankly if you are bothering with tree wide changes, can we please
finally do something forward compatible that will allow us
to add extra information without breaking compat?
Or ideally just self delimiting format, one can dream...


> >> Thanks,
> >> 
> >> > 
> >> > 
> >> > > > >     to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
> >> > > > >     reject negative or oversized values, and propagate errors to
> >> > > > >     vmstate_load_vmsd().
> >> > > > > 
> >> > > > >     Note: the large value is coming from the backend, not guest, so this
> >> > > > >     shouldn't be considered a security issue. The CVE was assigned before
> >> > > > >     the qemu security policy was updated to exclude this class of bugs.
> >> > > > > 
> >> > > > >     Fixes: CVE-2026-6426
> >> > > > >     Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
> >> > > > >     Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> >> > > > >     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> >> > > > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> > > > >     Message-ID: <
> >> > > > >     801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
> >> > > > >     ---
> >> > > > >      include/migration/vmstate.h |  5 ++++-
> >> > > > >      migration/vmstate.c         | 31 ++++++++++++++++++++++++++++---
> >> > > > >      2 files changed, 32 insertions(+), 4 deletions(-)
> >> > > > > 
> >> > > > >     diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >> > > > >     index 1b7f295417..e7095cd977 100644
> >> > > > >     --- a/include/migration/vmstate.h
> >> > > > >     +++ b/include/migration/vmstate.h
> >> > > > >     @@ -168,6 +168,9 @@ enum VMStateFlags {
> >> > > > >           */
> >> > > > >          VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
> >> > > > > 
> >> > > > >     +    /* Use a uint64_t size field for VMS_VBUFFER instead of int32_t. */
> >> > > > >     +    VMS_VBUFFER_UINT64              = 0x40000,
> >> > > > >     +
> >> > > > >          /* Marker for end of list */
> >> > > > >          VMS_END                         = 0x20000,
> >> > > > >      };
> >> > > > >     @@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >> > > > >          .field_exists = (_test),                                         \
> >> > > > >          .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> >> > > > >          .info         = &vmstate_info_buffer,                            \
> >> > > > >     -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
> >> > > > >     +    .flags        = VMS_VBUFFER | VMS_VBUFFER_UINT64 | VMS_POINTER,  \
> >> > > > >          .offset       = offsetof(_state, _field),                        \
> >> > > > >      }
> >> > > > > 
> >> > > > >     diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> > > > >     index 50ebe37845..d7f03a9f5b 100644
> >> > > > >     --- a/migration/vmstate.c
> >> > > > >     +++ b/migration/vmstate.c
> >> > > > >     @@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const
> >> > > > >     VMStateField *field)
> >> > > > >          int size;
> >> > > > > 
> >> > > > >          if (field->flags & VMS_VBUFFER) {
> >> > > > >     -        size = *(int32_t *)(opaque + field->size_offset);
> >> > > > >     -        if (field->flags & VMS_MULTIPLY) {
> >> > > > >     -            size *= field->size;
> >> > > > >     +        uint64_t usize64;
> >> > > > >     +
> >> > > > >     +        if (field->flags & VMS_VBUFFER_UINT64) {
> >> > > > >     +            usize64 = *(uint64_t *)(opaque + field->size_offset);
> >> > > > >     +        } else {
> >> > > > >     +            int32_t ssize32 = *(int32_t *)(opaque + field->size_offset);
> >> > > > >     +            if (ssize32 < 0) {
> >> > > > >     +                return -1;
> >> > > > >     +            }
> >> > > > >     +            usize64 = ssize32;
> >> > > > >              }
> >> > > > >     +        if (field->flags & VMS_MULTIPLY) {
> >> > > > >     +            usize64 *= field->size;
> >> > > > >     +        }
> >> > > > >     +        if (usize64 > INT_MAX) {
> >> > > > >     +            return -1;
> >> > > > >     +        }
> >> > > > >     +        size = usize64;
> >> > > > >          } else if (field->flags & VMS_ARRAY_OF_POINTER) {
> >> > > > >              /*
> >> > > > >               * For an array of pointer, the each element is always size of a
> >> > > > >     @@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const
> >> > > > >     VMStateDescription *vmsd,
> >> > > > >                  void *first_elem = opaque + field->offset;
> >> > > > >                  int i, n_elems = vmstate_n_elems(opaque, field);
> >> > > > >                  int size = vmstate_size(opaque, field);
> >> > > > >     +            if (size < 0) {
> >> > > > >     +                error_setg(errp, "VMState field '%s': invalid size",
> >> > > > >     +                           field->name);
> >> > > > >     +                return false;
> >> > > > >     +            }
> >> > > > > 
> >> > > > >                  vmstate_handle_alloc(first_elem, field, opaque);
> >> > > > >                  if (field->flags & VMS_POINTER) {
> >> > > > >     @@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const
> >> > > > >     VMStateDescription *vmsd,
> >> > > > >                  bool use_dynamic_array =
> >> > > > >                      field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
> >> > > > > 
> >> > > > >     +            if (size < 0) {
> >> > > > >     +                error_setg(errp, "VMState field '%s': invalid size",
> >> > > > >     +                           field->name);
> >> > > > >     +                ok = false;
> >> > > > >     +                goto out;
> >> > > > >     +            }
> >> > > > >                  trace_vmstate_save_state_loop(vmsd->name, field->name,
> >> > > > >     n_elems);
> >> > > > >                  if (field->flags & VMS_POINTER) {
> >> > > > >                      first_elem = *(void **)first_elem;
> >> > > > >     --
> >> > > > >     MST
> >> > > > > 
> >> > > > > 
> >> > > > 
> >> > > 
> >> > > -- 
> >> > > Peter Xu
> >> > 
> >> 
> >> -- 
> >> Peter Xu


