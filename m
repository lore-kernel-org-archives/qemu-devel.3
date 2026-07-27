Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88684C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woM48-0001re-33; Mon, 27 Jul 2026 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woM46-0001rQ-RQ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woM44-0008TS-DZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785161538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RH33h796mxIJA3x4/nKGVRTGKfY+qkjHWGBZCVUdpEw=;
 b=FCA508e+OQspPTG+wDObMeADkFZZtvHVBkpdmCsyWoAWAgax1uB2MivITVE69UpoPN+Dgb
 Zxd0C7d4hQsgVQUUqYCydy4xMRnYtRKmNHfLmkOc0zLCYJ3r15CSZzXlwtpN9vQG1HxQTs
 /xwVLmbFgf63upuLB76frzdPGJ45cAQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-qw5LR8PzNUKdlBCQLQeKLA-1; Mon, 27 Jul 2026 10:12:17 -0400
X-MC-Unique: qw5LR8PzNUKdlBCQLQeKLA-1
X-Mimecast-MFC-AGG-ID: qw5LR8PzNUKdlBCQLQeKLA_1785161536
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-737d34a0dc8so2793066137.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785161536; x=1785766336; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RH33h796mxIJA3x4/nKGVRTGKfY+qkjHWGBZCVUdpEw=;
 b=C3nD2+MbuEmUOzn7Yo5SE3NG0Y30+/HmuLMpQgAxKfru9RQYCHfMMz5n47BFlmUE+t
 xOUgoVotlBRv/qGkTGifNupILgmj7ZVE8/AdLSbNV9DaAutjAbxoxGxHGXuusjDLRD2J
 0KZhG6leEgu6fjLGyZ0pkLYW1X6KiAJ3XnHxn7F+ZIrUiyZgiENVUqyVb1Mh7uKy4Wvg
 74nBUuN5gjRgAmMbrSqbVj+hUZmvoNEjbBOszurHPQn/3ZeHRm5H1dcAoAuv94KlGEyg
 teaoBEB6TcGQf1gFfNxC3rFZN+HvrFtEj+yh9aG0fW+eyr9sauJTMXJcx6jYIEwH+mcm
 3R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785161536; x=1785766336;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RH33h796mxIJA3x4/nKGVRTGKfY+qkjHWGBZCVUdpEw=;
 b=h9RJUTJRfHSs5u3Cfutw6NKGgt84Z+kwdvyHFbadPdTM7WON1i35ZTzZhpJnR+6pJQ
 EjmV01YyWIln91ZsUX9tyRW4iJ6WBoucYHqkwdu54EgNwPJfSxroaVnVFMzB8B1BI1Mr
 JfAUPzeX841k6yY7Es279XK5Nca7mgdooKs7ci4ubXGchNj2/1jSIy2z76rlhlQFwecl
 JqJfjuum5frd/vaK0ObBBZeSHW8KYGDtzrEiAVG9OxtgEkiX+8jkdzXa153esgNFe1ER
 UmiuO1Cyc8+O6v12sVKpfmbzlcdWb9jMF0bMwD5yZJQwdVoONSrzatnfFGR409pu7JGp
 O26g==
X-Gm-Message-State: AOJu0YzKKy7f4zO1x6jsNDfh6ecjcCRCr3CC93pHD2CGUz8JacIglWiN
 TbOAAarbEonAyBZ528cWkAoQk2Gz5fSJWtaHY9n9OsKCOBv8VFNB5QCbhjyuRd+9Zm96OqEi/a8
 bpfDNYR0j74l4/KEPM+8eyrAOxI/O8b3P9o5drQKmcb+ZzlUroEfgPSxf
X-Gm-Gg: AR+sD11GQpsRfpW3Gqa0LDfSIX6gnut3Xlui7H4vPcnLbfUr75leGxeIsbm7r6IFhop
 dD47h58IBcGGNPNmUzpwkDwgt9KctKo4T+sSuNjb0NZtSQ5s/pJSbrIS9ZwYq3rhkvWQ34FKgiR
 +QH8DwrYNApwn7cuaGZLaeHuzw4Kj/J+UFukQ+uR4H01u9D1cIBnkVuC/dZNt+UgHMA6T+cib/i
 +diJHuZTjF/iCCS4Wj+qj2feQDaNwmWVB7sWwk5PNMxTETN49RKKqQukmdMzONAo54U/E7QW1LD
 KbL2r/rfUCixVVZzLL3YTrDlovKySKOuAf7B1IqZekb/TjgDqYVQXyF+ISbDYyvmub+ACX5T
X-Received: by 2002:a05:6102:3c9d:b0:744:cb59:d6e4 with SMTP id
 ada2fe7eead31-750407c3313mr4615889137.22.1785161536464; 
 Mon, 27 Jul 2026 07:12:16 -0700 (PDT)
X-Received: by 2002:a05:6102:3c9d:b0:744:cb59:d6e4 with SMTP id
 ada2fe7eead31-750407c3313mr4615862137.22.1785161535937; 
 Mon, 27 Jul 2026 07:12:15 -0700 (PDT)
Received: from x1.local ([2605:8d80:6c21:6818:c87e:c65f:8297:5636])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-750362ea9aesm5643671137.9.2026.07.27.07.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:12:15 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:12:13 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 17/30] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
Message-ID: <amdnPZodGpGeS0Si@x1.local>
References: <cover.1785101237.git.mst@redhat.com>
 <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
 <CADLectmKQT+hU_3TG2Popan8f5QphEEpwsR+Ps=+WTZo-Z_M_Q@mail.gmail.com>
 <20260727045220-mutt-send-email-mst@kernel.org>
 <amdT6P4esRDwyRX4@x1.local>
 <20260727091654-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727091654-mutt-send-email-mst@kernel.org>
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

On Mon, Jul 27, 2026 at 09:17:25AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 27, 2026 at 08:49:44AM -0400, Peter Xu wrote:
> > On Mon, Jul 27, 2026 at 04:53:15AM -0400, Michael S. Tsirkin wrote:
> > > On Sun, Jul 26, 2026 at 08:31:57PM -0400, Peter Xu wrote:
> > > > This patch is migration only change and hasn't been reviewed.  Give us a few
> > > > days to review it?
> > > > Can't do it now because it is on cellphone and I just bathed my son.
> > > > 
> > > > Please hold off merging.
> > > > 
> > > > Thanks.
> > > 
> > > OK.  I'll drop this and you will merge it through the migration tree
> > > as appropriate?
> > 
> > Let's drop it first so it won't block this pull.  I can definitely pick it
> > up when ready, but I want to discuss on how to fix first.  Which tree to
> > pick it up isn't a huge matter to me, but the review.
> 
> Done.
> Pls include:
> 
> Reported-by: Seungjung Kim <seungjung0711@gmail.com>
> 
> when you are merging this.

Michael,

Please continue read at least until [1] below.  I want to discuss if we
should fix it in another way..

Thanks,

> 
> > We found a bunch of randomly introduced VMSTATE flags in the past, I used
> > to remove some, at least my plan is in the future each time we introduce a
> > new one (by request from other modules) we better justify it before landing
> > too easily, in case it needs a revert again.
> > 
> > This vhost regression started 11.0 so IIUC we don't need to rush in 11.1.
> > I just noticed I read that patch and didn't notice this, my bad to not have
> > noticed..
> > 
> > For this one specifically..
> > 
> > > 
> > > > On Sun, Jul 26, 2026, 5:29 p.m. Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > 
> > > >     vhost user currently saves the inflight buffer to the migration stream
> > > >     using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
> > > >     backend.
> > > > 
> > > >     But the implementation of that is broken if size is >2G: it stores the
> > > >     buffer size in a uint64_t field, but vmstate_size() always reads the
> > > >     size field as int32_t regardless of the macro used. This, in turn,
> > > >     causes negative or truncated lengths on load, leading to undersized
> > > >     allocations and down the road out-of-bounds buffer access.
> > > > 
> > > >     There's no practical reason to support such large sizes, so it's enough
> > 
> > If there's no real demand to use 2G or more, I suggest we change size to
> > int32_t instead on the user, and revert f6fdd8b2 VMSTATE_VBUFFER_UINT64().

[1]

> > 
> > Fabiano and I were looking at rest 20+ possible security related bugs in
> > the past 1-2 weeks, I've some patches to be posted for 11.2 too when we
> > went through all of them. One relevant patch I haven't sent but will do
> > soon:
> > 
> > https://gitlab.com/peterx/qemu/-/commit/afd2cb25defdf78a4ab5279cc16634884792c57a
> > 
> > We encountered quite a few of possible over-allocation on destionation side
> > by manipulating on-wire length field like this one, I believe Fabiano is
> > looking at how to further limit that from 2G if ever possible per-user.
> > 
> > I'm not sure if that idea will fly, but I think anything bigger than 2G
> > definitely is not suggested for now when it's only for a type match not
> > real demand..
> > 
> > I believe VMSTATE_VBUFFER_UINT32 is problematic on its own too, I'll see
> > how to fix that.  That one is slightly easier, worst case is we bail out
> > for 2G (hence ignore bit 31, which shouldn't be used in reality for legit
> > users), but I'll think about it.
> > 
> > Thanks,
> > 
> > > >     to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
> > > >     reject negative or oversized values, and propagate errors to
> > > >     vmstate_load_vmsd().
> > > > 
> > > >     Note: the large value is coming from the backend, not guest, so this
> > > >     shouldn't be considered a security issue. The CVE was assigned before
> > > >     the qemu security policy was updated to exclude this class of bugs.
> > > > 
> > > >     Fixes: CVE-2026-6426
> > > >     Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
> > > >     Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > > >     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> > > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >     Message-ID: <
> > > >     801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
> > > >     ---
> > > >      include/migration/vmstate.h |  5 ++++-
> > > >      migration/vmstate.c         | 31 ++++++++++++++++++++++++++++---
> > > >      2 files changed, 32 insertions(+), 4 deletions(-)
> > > > 
> > > >     diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > >     index 1b7f295417..e7095cd977 100644
> > > >     --- a/include/migration/vmstate.h
> > > >     +++ b/include/migration/vmstate.h
> > > >     @@ -168,6 +168,9 @@ enum VMStateFlags {
> > > >           */
> > > >          VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
> > > > 
> > > >     +    /* Use a uint64_t size field for VMS_VBUFFER instead of int32_t. */
> > > >     +    VMS_VBUFFER_UINT64              = 0x40000,
> > > >     +
> > > >          /* Marker for end of list */
> > > >          VMS_END                         = 0x20000,
> > > >      };
> > > >     @@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> > > >          .field_exists = (_test),                                         \
> > > >          .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> > > >          .info         = &vmstate_info_buffer,                            \
> > > >     -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
> > > >     +    .flags        = VMS_VBUFFER | VMS_VBUFFER_UINT64 | VMS_POINTER,  \
> > > >          .offset       = offsetof(_state, _field),                        \
> > > >      }
> > > > 
> > > >     diff --git a/migration/vmstate.c b/migration/vmstate.c
> > > >     index 50ebe37845..d7f03a9f5b 100644
> > > >     --- a/migration/vmstate.c
> > > >     +++ b/migration/vmstate.c
> > > >     @@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const
> > > >     VMStateField *field)
> > > >          int size;
> > > > 
> > > >          if (field->flags & VMS_VBUFFER) {
> > > >     -        size = *(int32_t *)(opaque + field->size_offset);
> > > >     -        if (field->flags & VMS_MULTIPLY) {
> > > >     -            size *= field->size;
> > > >     +        uint64_t usize64;
> > > >     +
> > > >     +        if (field->flags & VMS_VBUFFER_UINT64) {
> > > >     +            usize64 = *(uint64_t *)(opaque + field->size_offset);
> > > >     +        } else {
> > > >     +            int32_t ssize32 = *(int32_t *)(opaque + field->size_offset);
> > > >     +            if (ssize32 < 0) {
> > > >     +                return -1;
> > > >     +            }
> > > >     +            usize64 = ssize32;
> > > >              }
> > > >     +        if (field->flags & VMS_MULTIPLY) {
> > > >     +            usize64 *= field->size;
> > > >     +        }
> > > >     +        if (usize64 > INT_MAX) {
> > > >     +            return -1;
> > > >     +        }
> > > >     +        size = usize64;
> > > >          } else if (field->flags & VMS_ARRAY_OF_POINTER) {
> > > >              /*
> > > >               * For an array of pointer, the each element is always size of a
> > > >     @@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const
> > > >     VMStateDescription *vmsd,
> > > >                  void *first_elem = opaque + field->offset;
> > > >                  int i, n_elems = vmstate_n_elems(opaque, field);
> > > >                  int size = vmstate_size(opaque, field);
> > > >     +            if (size < 0) {
> > > >     +                error_setg(errp, "VMState field '%s': invalid size",
> > > >     +                           field->name);
> > > >     +                return false;
> > > >     +            }
> > > > 
> > > >                  vmstate_handle_alloc(first_elem, field, opaque);
> > > >                  if (field->flags & VMS_POINTER) {
> > > >     @@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const
> > > >     VMStateDescription *vmsd,
> > > >                  bool use_dynamic_array =
> > > >                      field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
> > > > 
> > > >     +            if (size < 0) {
> > > >     +                error_setg(errp, "VMState field '%s': invalid size",
> > > >     +                           field->name);
> > > >     +                ok = false;
> > > >     +                goto out;
> > > >     +            }
> > > >                  trace_vmstate_save_state_loop(vmsd->name, field->name,
> > > >     n_elems);
> > > >                  if (field->flags & VMS_POINTER) {
> > > >                      first_elem = *(void **)first_elem;
> > > >     --
> > > >     MST
> > > > 
> > > > 
> > > 
> > 
> > -- 
> > Peter Xu
> 

-- 
Peter Xu


