Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F269BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLDE-0008Gy-37; Mon, 27 Jul 2026 09:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woLD5-0008Dk-4b
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woLD2-0000E9-Se
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785158252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BP8K9A4D7Da6Nstu8SYp65SJz5Pg0+EhutFCD+oLsww=;
 b=LxyvshZkusPCVqlndQwk6eyz6DBCEKYaBOWWAp3py4EMt7E4au5UPOW1dhImSLbrPD9557
 KHhcZSVi9Nc60eXE8r7qyrmm6ds7CctQH0zMRBpljeTyf5NshBaZNMD9lHVZqAGX2/1W96
 ZegX88X+bCcIPlmrmOpux2ddFjJoH6E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-hcg50SawMEKDHrY9jJJHAA-1; Mon, 27 Jul 2026 09:17:30 -0400
X-MC-Unique: hcg50SawMEKDHrY9jJJHAA-1
X-Mimecast-MFC-AGG-ID: hcg50SawMEKDHrY9jJJHAA_1785158250
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f7700ffdeso1079492f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785158249; x=1785763049; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BP8K9A4D7Da6Nstu8SYp65SJz5Pg0+EhutFCD+oLsww=;
 b=ECoHzmODDyS4h/MhY4Nox+IDFAeeGHfk7NI3Pa61jrIi8KT8DIA2/Zt51sXZ33EwaO
 UtILh/ut//b01LkMobM93EjzkXgd4WROyZdq2mS9b2WNMX3EBg4cXx8BaL1/DN3DuHLA
 Jyuf37OPT+BAQ7HY0ZRrfUWInLNT7eQYn8wp4hJLuozMnL7LzeOpC2moP1vCTAhvALQi
 HeyMRq1DxbXO164UX7JQRsyXmjFZZtNNFXe9S24D6SIh4X7ociB0CGvVCDfbz5XKCVN8
 kYgOvF8cwBegofb1VXzPAZu8G17Kcmb9R/GkfUXnEDtGWznXYb5gwLwOFtS8z1J3zlGU
 mTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785158249; x=1785763049;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BP8K9A4D7Da6Nstu8SYp65SJz5Pg0+EhutFCD+oLsww=;
 b=qhDk05ycyu2xKzAUjy5jFYa75ii88FxhBsU90Whzsc/WyOnoHsFiNn7CdArrLgMp4J
 B12LDjUU0TnHMvdvI3iMzzFV4eqITpFHyV653IVK90vkC4DsOerWdP3PbggaM8OR5aP3
 eFcorZ342zDvKOvGJEiVBvyDWiOxFXpHUqZBu4tFLmvG7+3qQFLLti/myZppOQ+xSy+F
 6HgKlR90KlDSnETiyt3dLrzc8wmbE+qUJKm0AoLwLmXFLSkb0EfTki/GEn0+s64nQJON
 uWAH2WrZLTC6yfUd1ubW/JOX6oONz3OSmH1he+49mUvrEfkekvukSgK1HzFUFhL0QrGU
 3aEw==
X-Gm-Message-State: AOJu0YwIGFiIDoropUiiMseN5jZI0ctYA94piFozLt+phpy1a8N5Yvva
 wDRk/pMGZShA1B4W7ou6O7Z8Lwt0hxzd3LMYJmXUnmAI7uTqzyB4KM8rBRf+StR83Savj2Qr/He
 xIDlg1cddUXw15dYAlUSNcZEtnyY01E7u9T6jD8Nc13klRM2urZbQMEeI
X-Gm-Gg: AR+sD11W2ndZJK6W2O/JTVMTMuhNfbsHS6qgcYV155OIeYkSF2UGwrHsMNtsHkBWEFX
 DULcB7Gd4zjIlsPSNay969eIEVuXNgKbunLrU0tpQxPcZKxYROKSXrSn1Pn2+kfhITV+T1hiMPL
 sOleaFRei3qqvyemVrHR7gRhJKSQdz/tcFV5ma9vTanEKMpsZGmz4KeMhKEKlltOy75QMq4prvt
 S/FPozakR2sluwTU9TnNet70CszHwlhFXhEEew6WDKJS6Yma5JEWZ60Ma5GSk3MvCDs9rUWJbh9
 nDkkfJ/OBlebEGQutcnTJCVvkD7nnby7mhCzWsNlZVzGFvfPsjWtBr0lHOyH7jmKcMlkLkdovUy
 FN6sC2JROlGFFOs7KBGhtMQ==
X-Received: by 2002:a05:6000:4305:b0:47e:8e7a:90a0 with SMTP id
 ffacd0b85a97d-47f9feaf7d5mr11094200f8f.52.1785158249389; 
 Mon, 27 Jul 2026 06:17:29 -0700 (PDT)
X-Received: by 2002:a05:6000:4305:b0:47e:8e7a:90a0 with SMTP id
 ffacd0b85a97d-47f9feaf7d5mr11094121f8f.52.1785158248629; 
 Mon, 27 Jul 2026 06:17:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c53052sm48387264f8f.18.2026.07.27.06.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:17:27 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:17:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 17/30] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
Message-ID: <20260727091654-mutt-send-email-mst@kernel.org>
References: <cover.1785101237.git.mst@redhat.com>
 <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
 <CADLectmKQT+hU_3TG2Popan8f5QphEEpwsR+Ps=+WTZo-Z_M_Q@mail.gmail.com>
 <20260727045220-mutt-send-email-mst@kernel.org>
 <amdT6P4esRDwyRX4@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amdT6P4esRDwyRX4@x1.local>
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

On Mon, Jul 27, 2026 at 08:49:44AM -0400, Peter Xu wrote:
> On Mon, Jul 27, 2026 at 04:53:15AM -0400, Michael S. Tsirkin wrote:
> > On Sun, Jul 26, 2026 at 08:31:57PM -0400, Peter Xu wrote:
> > > This patch is migration only change and hasn't been reviewed.  Give us a few
> > > days to review it?
> > > Can't do it now because it is on cellphone and I just bathed my son.
> > > 
> > > Please hold off merging.
> > > 
> > > Thanks.
> > 
> > OK.  I'll drop this and you will merge it through the migration tree
> > as appropriate?
> 
> Let's drop it first so it won't block this pull.  I can definitely pick it
> up when ready, but I want to discuss on how to fix first.  Which tree to
> pick it up isn't a huge matter to me, but the review.

Done.
Pls include:

Reported-by: Seungjung Kim <seungjung0711@gmail.com>

when you are merging this.

> We found a bunch of randomly introduced VMSTATE flags in the past, I used
> to remove some, at least my plan is in the future each time we introduce a
> new one (by request from other modules) we better justify it before landing
> too easily, in case it needs a revert again.
> 
> This vhost regression started 11.0 so IIUC we don't need to rush in 11.1.
> I just noticed I read that patch and didn't notice this, my bad to not have
> noticed..
> 
> For this one specifically..
> 
> > 
> > > On Sun, Jul 26, 2026, 5:29 p.m. Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > >     vhost user currently saves the inflight buffer to the migration stream
> > >     using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
> > >     backend.
> > > 
> > >     But the implementation of that is broken if size is >2G: it stores the
> > >     buffer size in a uint64_t field, but vmstate_size() always reads the
> > >     size field as int32_t regardless of the macro used. This, in turn,
> > >     causes negative or truncated lengths on load, leading to undersized
> > >     allocations and down the road out-of-bounds buffer access.
> > > 
> > >     There's no practical reason to support such large sizes, so it's enough
> 
> If there's no real demand to use 2G or more, I suggest we change size to
> int32_t instead on the user, and revert f6fdd8b2 VMSTATE_VBUFFER_UINT64().
> 
> Fabiano and I were looking at rest 20+ possible security related bugs in
> the past 1-2 weeks, I've some patches to be posted for 11.2 too when we
> went through all of them. One relevant patch I haven't sent but will do
> soon:
> 
> https://gitlab.com/peterx/qemu/-/commit/afd2cb25defdf78a4ab5279cc16634884792c57a
> 
> We encountered quite a few of possible over-allocation on destionation side
> by manipulating on-wire length field like this one, I believe Fabiano is
> looking at how to further limit that from 2G if ever possible per-user.
> 
> I'm not sure if that idea will fly, but I think anything bigger than 2G
> definitely is not suggested for now when it's only for a type match not
> real demand..
> 
> I believe VMSTATE_VBUFFER_UINT32 is problematic on its own too, I'll see
> how to fix that.  That one is slightly easier, worst case is we bail out
> for 2G (hence ignore bit 31, which shouldn't be used in reality for legit
> users), but I'll think about it.
> 
> Thanks,
> 
> > >     to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
> > >     reject negative or oversized values, and propagate errors to
> > >     vmstate_load_vmsd().
> > > 
> > >     Note: the large value is coming from the backend, not guest, so this
> > >     shouldn't be considered a security issue. The CVE was assigned before
> > >     the qemu security policy was updated to exclude this class of bugs.
> > > 
> > >     Fixes: CVE-2026-6426
> > >     Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
> > >     Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > >     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >     Message-ID: <
> > >     801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
> > >     ---
> > >      include/migration/vmstate.h |  5 ++++-
> > >      migration/vmstate.c         | 31 ++++++++++++++++++++++++++++---
> > >      2 files changed, 32 insertions(+), 4 deletions(-)
> > > 
> > >     diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > >     index 1b7f295417..e7095cd977 100644
> > >     --- a/include/migration/vmstate.h
> > >     +++ b/include/migration/vmstate.h
> > >     @@ -168,6 +168,9 @@ enum VMStateFlags {
> > >           */
> > >          VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
> > > 
> > >     +    /* Use a uint64_t size field for VMS_VBUFFER instead of int32_t. */
> > >     +    VMS_VBUFFER_UINT64              = 0x40000,
> > >     +
> > >          /* Marker for end of list */
> > >          VMS_END                         = 0x20000,
> > >      };
> > >     @@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> > >          .field_exists = (_test),                                         \
> > >          .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> > >          .info         = &vmstate_info_buffer,                            \
> > >     -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
> > >     +    .flags        = VMS_VBUFFER | VMS_VBUFFER_UINT64 | VMS_POINTER,  \
> > >          .offset       = offsetof(_state, _field),                        \
> > >      }
> > > 
> > >     diff --git a/migration/vmstate.c b/migration/vmstate.c
> > >     index 50ebe37845..d7f03a9f5b 100644
> > >     --- a/migration/vmstate.c
> > >     +++ b/migration/vmstate.c
> > >     @@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const
> > >     VMStateField *field)
> > >          int size;
> > > 
> > >          if (field->flags & VMS_VBUFFER) {
> > >     -        size = *(int32_t *)(opaque + field->size_offset);
> > >     -        if (field->flags & VMS_MULTIPLY) {
> > >     -            size *= field->size;
> > >     +        uint64_t usize64;
> > >     +
> > >     +        if (field->flags & VMS_VBUFFER_UINT64) {
> > >     +            usize64 = *(uint64_t *)(opaque + field->size_offset);
> > >     +        } else {
> > >     +            int32_t ssize32 = *(int32_t *)(opaque + field->size_offset);
> > >     +            if (ssize32 < 0) {
> > >     +                return -1;
> > >     +            }
> > >     +            usize64 = ssize32;
> > >              }
> > >     +        if (field->flags & VMS_MULTIPLY) {
> > >     +            usize64 *= field->size;
> > >     +        }
> > >     +        if (usize64 > INT_MAX) {
> > >     +            return -1;
> > >     +        }
> > >     +        size = usize64;
> > >          } else if (field->flags & VMS_ARRAY_OF_POINTER) {
> > >              /*
> > >               * For an array of pointer, the each element is always size of a
> > >     @@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const
> > >     VMStateDescription *vmsd,
> > >                  void *first_elem = opaque + field->offset;
> > >                  int i, n_elems = vmstate_n_elems(opaque, field);
> > >                  int size = vmstate_size(opaque, field);
> > >     +            if (size < 0) {
> > >     +                error_setg(errp, "VMState field '%s': invalid size",
> > >     +                           field->name);
> > >     +                return false;
> > >     +            }
> > > 
> > >                  vmstate_handle_alloc(first_elem, field, opaque);
> > >                  if (field->flags & VMS_POINTER) {
> > >     @@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const
> > >     VMStateDescription *vmsd,
> > >                  bool use_dynamic_array =
> > >                      field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
> > > 
> > >     +            if (size < 0) {
> > >     +                error_setg(errp, "VMState field '%s': invalid size",
> > >     +                           field->name);
> > >     +                ok = false;
> > >     +                goto out;
> > >     +            }
> > >                  trace_vmstate_save_state_loop(vmsd->name, field->name,
> > >     n_elems);
> > >                  if (field->flags & VMS_POINTER) {
> > >                      first_elem = *(void **)first_elem;
> > >     --
> > >     MST
> > > 
> > > 
> > 
> 
> -- 
> Peter Xu


