Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A9EC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woH5T-0006k7-R8; Mon, 27 Jul 2026 04:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH5Q-0006jr-O9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH5O-0006x6-Kv
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785142401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1WEkqg5egxDJ9Hhler2x297dJFyG/VESplriVmoqqE=;
 b=XOQA1DFezkql+Y6szKu2F+zXMNbgZmchV7D+w0tJB7dFUXe2/ktJf14EchnFtD6AoI+8iU
 8zoRyhjM3tgJHVHSx4OFqbz/e3XeITI8ckMJ2i6+T9n1QW3YEPkF7sjQYhY6sifFYQ0Yjy
 8O+eTfik4FlYJzFxVnvz7hH27d5yvR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-bL2QspB0OvGeHy3brfrWUw-1; Mon, 27 Jul 2026 04:53:19 -0400
X-MC-Unique: bL2QspB0OvGeHy3brfrWUw-1
X-Mimecast-MFC-AGG-ID: bL2QspB0OvGeHy3brfrWUw_1785142399
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955d314945so17402595e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785142399; x=1785747199; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q1WEkqg5egxDJ9Hhler2x297dJFyG/VESplriVmoqqE=;
 b=JL+4YKI+Caidacml4nNQO3MNoLAPzPJ9z/0r63tQTLBEkN/5jEd46daW8oCfVvTmA+
 Ds/NqriIIFR0qeopCWKZgQBhd9oi9CLo0nwHlBEzQN0snV8YvDlLMLq8rK6KitjOQAt7
 NKTKfcXMtpGP7OWu5sXrlQKRsBBY+Slnhr+uF+ZRdeiQQsy/BvWSYgOfvFySbugDUAbv
 4oODg1oKIoVUYPLEneqjrY/ys/+jdV+73aQSs4YE6TIJAszecnImvnGDAcoJ1haOMQF2
 1jh2ab/nv12IQQ1DCIFiOW4KaTnp6ddhzAy+YxqH3zn2Rjw2TmBF5g55omCx+k9NoPl3
 MxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785142399; x=1785747199;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q1WEkqg5egxDJ9Hhler2x297dJFyG/VESplriVmoqqE=;
 b=mkvlbFq3vZXems9F/jd7BQ+3DJOxytQ1F1/FvpLZgiandGpjoQ35Buqd54xUKuViB3
 Juo8gS+azkZMaIdbcVIaY/rCF7EGa1lSfCfo3091+jGnUQfqT/MTz1vlzk9F5qNIAiYC
 4fbQ7CcmOvISPKRH42C1huPB+LWQ6ky2zAUylTiKtyejwfAOo9dLxpIOh3yir0MiKUZJ
 B9An7BwKzld30P98ICe+WN/ZzKiLX34yaYHBkwBuUJ9I1+ejavbMud0/Sp1hVN6eaNHh
 Ydbv/To/gHnYqKArr6hWnG6n8OYoj8zDec78lzw5LLpurxM4Dblg0DysCWXL1yHYPkRe
 g9oQ==
X-Gm-Message-State: AOJu0YwrNEfIe9AAm6/ePSyftSWgpXKzk3EXhMKZx2lzynN0uxlkQhCl
 6llHnuPdMKph8Zz2MTIZk1XnU5sB54UCVBrSBAqNExdGy/9z1gTsxjN2icAS4EW1mQTkjdK4Qeq
 yEBwtPp/3jby5VkUo6/sG0adcFDfHS02qfQIMKQ5LE6SNyb0Z1crpvN46
X-Gm-Gg: AR+sD10mcZGyNMqGbiaROI2kerIFBqmljcY7sk/wd3Q/b3BcNCAy5zC5DQtvfSrguoq
 PlTV3QP+Pi8RCGJLbLuOBJY95jlbxeJWUv/0N053tZXWLlVQT3jt8TVurq4z+jPwb+odECCD7iH
 RMcLZzsWXOQgIMsYolvKxtDKY9FllIQ3U85gHYDmWzsjSs31Fhamnb6LhE9gKzbWn5q6yaKHgfH
 /lPFdVrCEOL/YYG0d0QF0uzVRfOX15Lw9hbqxefkSmPIxJTaII6so4exb2VLmEqqz4uv1uiK9F+
 zmJhVA/n2UXrLwWch71sTlTT5v3b0garcEGYB58nN3k6SubT9oaj3ozhw0gLja36IjjC1QISayF
 YHjJvTaADl0owd0escSpPDg==
X-Received: by 2002:a05:600c:45d5:b0:495:4cb6:71cc with SMTP id
 5b1f17b1804b1-496b570fc0cmr87243045e9.5.1785142398539; 
 Mon, 27 Jul 2026 01:53:18 -0700 (PDT)
X-Received: by 2002:a05:600c:45d5:b0:495:4cb6:71cc with SMTP id
 5b1f17b1804b1-496b570fc0cmr87242785e9.5.1785142398057; 
 Mon, 27 Jul 2026 01:53:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9ae5c3sm302357375e9.3.2026.07.27.01.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:53:17 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:53:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 17/30] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
Message-ID: <20260727045220-mutt-send-email-mst@kernel.org>
References: <cover.1785101237.git.mst@redhat.com>
 <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
 <CADLectmKQT+hU_3TG2Popan8f5QphEEpwsR+Ps=+WTZo-Z_M_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADLectmKQT+hU_3TG2Popan8f5QphEEpwsR+Ps=+WTZo-Z_M_Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Sun, Jul 26, 2026 at 08:31:57PM -0400, Peter Xu wrote:
> This patch is migration only change and hasn't been reviewed.  Give us a few
> days to review it?
> Can't do it now because it is on cellphone and I just bathed my son.
> 
> Please hold off merging.
> 
> Thanks.

OK.  I'll drop this and you will merge it through the migration tree
as appropriate?

> On Sun, Jul 26, 2026, 5:29 p.m. Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     vhost user currently saves the inflight buffer to the migration stream
>     using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
>     backend.
> 
>     But the implementation of that is broken if size is >2G: it stores the
>     buffer size in a uint64_t field, but vmstate_size() always reads the
>     size field as int32_t regardless of the macro used. This, in turn,
>     causes negative or truncated lengths on load, leading to undersized
>     allocations and down the road out-of-bounds buffer access.
> 
>     There's no practical reason to support such large sizes, so it's enough
>     to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
>     reject negative or oversized values, and propagate errors to
>     vmstate_load_vmsd().
> 
>     Note: the large value is coming from the backend, not guest, so this
>     shouldn't be considered a security issue. The CVE was assigned before
>     the qemu security policy was updated to exclude this class of bugs.
> 
>     Fixes: CVE-2026-6426
>     Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
>     Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>     Message-ID: <
>     801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
>     ---
>      include/migration/vmstate.h |  5 ++++-
>      migration/vmstate.c         | 31 ++++++++++++++++++++++++++++---
>      2 files changed, 32 insertions(+), 4 deletions(-)
> 
>     diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>     index 1b7f295417..e7095cd977 100644
>     --- a/include/migration/vmstate.h
>     +++ b/include/migration/vmstate.h
>     @@ -168,6 +168,9 @@ enum VMStateFlags {
>           */
>          VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
> 
>     +    /* Use a uint64_t size field for VMS_VBUFFER instead of int32_t. */
>     +    VMS_VBUFFER_UINT64              = 0x40000,
>     +
>          /* Marker for end of list */
>          VMS_END                         = 0x20000,
>      };
>     @@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>          .field_exists = (_test),                                         \
>          .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
>          .info         = &vmstate_info_buffer,                            \
>     -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
>     +    .flags        = VMS_VBUFFER | VMS_VBUFFER_UINT64 | VMS_POINTER,  \
>          .offset       = offsetof(_state, _field),                        \
>      }
> 
>     diff --git a/migration/vmstate.c b/migration/vmstate.c
>     index 50ebe37845..d7f03a9f5b 100644
>     --- a/migration/vmstate.c
>     +++ b/migration/vmstate.c
>     @@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const
>     VMStateField *field)
>          int size;
> 
>          if (field->flags & VMS_VBUFFER) {
>     -        size = *(int32_t *)(opaque + field->size_offset);
>     -        if (field->flags & VMS_MULTIPLY) {
>     -            size *= field->size;
>     +        uint64_t usize64;
>     +
>     +        if (field->flags & VMS_VBUFFER_UINT64) {
>     +            usize64 = *(uint64_t *)(opaque + field->size_offset);
>     +        } else {
>     +            int32_t ssize32 = *(int32_t *)(opaque + field->size_offset);
>     +            if (ssize32 < 0) {
>     +                return -1;
>     +            }
>     +            usize64 = ssize32;
>              }
>     +        if (field->flags & VMS_MULTIPLY) {
>     +            usize64 *= field->size;
>     +        }
>     +        if (usize64 > INT_MAX) {
>     +            return -1;
>     +        }
>     +        size = usize64;
>          } else if (field->flags & VMS_ARRAY_OF_POINTER) {
>              /*
>               * For an array of pointer, the each element is always size of a
>     @@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const
>     VMStateDescription *vmsd,
>                  void *first_elem = opaque + field->offset;
>                  int i, n_elems = vmstate_n_elems(opaque, field);
>                  int size = vmstate_size(opaque, field);
>     +            if (size < 0) {
>     +                error_setg(errp, "VMState field '%s': invalid size",
>     +                           field->name);
>     +                return false;
>     +            }
> 
>                  vmstate_handle_alloc(first_elem, field, opaque);
>                  if (field->flags & VMS_POINTER) {
>     @@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const
>     VMStateDescription *vmsd,
>                  bool use_dynamic_array =
>                      field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
> 
>     +            if (size < 0) {
>     +                error_setg(errp, "VMState field '%s': invalid size",
>     +                           field->name);
>     +                ok = false;
>     +                goto out;
>     +            }
>                  trace_vmstate_save_state_loop(vmsd->name, field->name,
>     n_elems);
>                  if (field->flags & VMS_POINTER) {
>                      first_elem = *(void **)first_elem;
>     --
>     MST
> 
> 


