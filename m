Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1D3C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 00:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo9Ha-00017t-NL; Sun, 26 Jul 2026 20:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1wo9HZ-00017j-4r
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 20:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1wo9HW-0007r2-R2
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 20:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785112401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VlSW/l0L8IyRJXWgZ1dSaun0HoKqpKtG88rEP/K8iK8=;
 b=IsHg3hhpv7mbGJHynTT9MOfQJzmxCg+MGXm3OtANtDm+C8BB5iIkYFLqadwGExpoYGTHcg
 EoBzipa+/4+/89yALg6PXiKubOgfY52CiK31qlX/FnmoJ4vBlqP2jfAYTvIGlWn8CPSUzI
 f28flhaGrHmyJmFvPmXZ/6V3OFtM54I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-_0rewYMBOj2ZuDAIOo9OTw-1; Sun, 26 Jul 2026 20:32:09 -0400
X-MC-Unique: _0rewYMBOj2ZuDAIOo9OTw-1
X-Mimecast-MFC-AGG-ID: _0rewYMBOj2ZuDAIOo9OTw_1785112329
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e5a616d07so407225a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 17:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785112329; cv=none;
 d=google.com; s=arc-20260327;
 b=IPLL1HJwJLlPSpAjQchIz7Q5BoCvmz4C8Tqld5SrXI9rHYNLdCbrPfC5Qa5ZsZDcOo
 a29cI+dET2CPZrtQEqrqKXWMWJf7w6iI26JaQ5E9YbneWSxcLOrNiltoD7UcBc58BXKs
 i0xxNWQSEEy+qtuI6yWbLD/5m0wnb5akKUkSMxNuaSS2HcyBCfyV3Zzyh1E4OR0cjynT
 q6xxQF5M8DdlCoUHgIbert+DOL413okZjMfNyjem2lzRlrHGd7geOjR1pOZrqeX8t1cz
 bfe9jvTuHpH9XvmFFowjxvBrXCUhvuGfwvXpTliC1YLeQvKlN7XlbQof6O/h+RnVGO+6
 /cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VlSW/l0L8IyRJXWgZ1dSaun0HoKqpKtG88rEP/K8iK8=;
 fh=MAFOEUaS0cy2if468zrCSIS2lBAm0LnpQxbwKvW/Va8=;
 b=Vu2R2QoS5Yp2KNtr219o3bHskq1G46EQSxajhnj6lpaOZTlz9dfSaOnIsE3DKYrXm2
 RkQK//H9ljPMUBbyXf4cxhdesLwHLjwoJBM0UJsw9CL68dP2VdZrsS186CHnYKulG6KE
 QrFAxXtwtFuSvumiTDcW6P1CHqarSKVsvzTNvjj22aUOFVc6yQqkEb4abcV08xrJ+PEO
 ZQyAH6vRsjBBEpyMqx8euYnT4iKXckGBysx6Gqh5ZIko8Hz6RUSo6y1x64a14BmnwUic
 lCZRnQ8VjM88OoPRA4CmIZ3YHSLxUgMq2JT4nQCIo/BFJSgcj/0j3w96hYnPnkAkpUDq
 dWAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785112329; x=1785717129; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VlSW/l0L8IyRJXWgZ1dSaun0HoKqpKtG88rEP/K8iK8=;
 b=sY07a3tGtA4dQvJ7doiAMcz8QI+Ajz2Q8hWDPfJ9NSQjjZSJFqJQh9880sgvPWnljp
 RBDB+jQdt9BXN4yFKnU1zfVJZcQJuwPddCzOVi5lNJ2wkSSgbq+Z+/+rfvWbZd2uFhI0
 kOFaO6TDIluItuv8T/9g+cqDFpziLD+fkElAegRucmFx5trH35IxQ07ZHVa3IqoViAja
 zBr9wO4rh0O77ap8XEp1mBz53c1urqbc/KU9PBsGoQm4q9cdJYgoq9dHcAIKTlAYOaeG
 Oyjn8ZeiOSmr1SNeo2vGF87BnzYNUYhFgq72dmqMqaz0btMce5bA1/Bkm3XaFlaDjA7U
 byzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785112329; x=1785717129;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VlSW/l0L8IyRJXWgZ1dSaun0HoKqpKtG88rEP/K8iK8=;
 b=jE5RCU6xHLx3Skgzcwdu+IiirN0wvhDyBemM5XwaUGLkGNg3nCdDnGTXi78GliHTdd
 XwLvHEbBezTG21JJ2qX8Ij2S5dh6yXanufaEjaFbhpWqsPLIG4M+Cc0o0yrfeTKJalef
 Tnc1UfOIPiZHQeRQCOhxmYEAi6GHt3Ca7t99wahx6SBZI21RIseP4B30HrbKvUSwil+8
 M6+t1nS9x2m1/eM8kofEkI+tUTX+yfklW8dZq1c9u2R3RqJtp7xSHD6XAAn7rUOwUv08
 GkEwTYeI2x3Z+a1lTLrY1+/THpeDISm8giIMKAfKQeckOtFTFM322uOXARGUKKeGrnus
 gsWQ==
X-Gm-Message-State: AOJu0YwwqUt/1McGffBtwSF9CfPSii9yMKkSbiSjvpmcO/EfkpXoji/z
 iaGpRUXHPezUnmNecBrXS4/JfjP6vTanBTR9pSI12NgAu/XKQzmFC0BPb3MSLFT2c/KjdWKk9ip
 efzZALsofX96ps+0nUx/7BVM3jjoXj6R06IALQ6L1JbR0QGRrDrCxKNOjXVdDuZ0tmOb6+sLpzr
 a76xawAOFZcPzqFUh3gKP5USNNbVlAh8U=
X-Gm-Gg: AR+sD11F1kupF5tTRb/m4zOlzb9iW1H3fxqMX6cwe6ZtVmjU9qv9uTKMhOVjAE2Ol0f
 cFgzVMwY+0HDM4QReXroiKoBHqXjq1ldW8YixBNHt/qSt3FYKjFpMnNsZSyMmVKpctItMSDohyr
 9W7R0kgojHdTX9tqmGgBdpDJzR7FHaiePuBZYnaa64/A1XWm0uuUFD6cqj
X-Received: by 2002:a05:6a21:a05:b0:3c3:7c0d:fc85 with SMTP id
 adf61e73a8af0-3c67e0f1c33mr6722489637.76.1785112328610; 
 Sun, 26 Jul 2026 17:32:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:a05:b0:3c3:7c0d:fc85 with SMTP id
 adf61e73a8af0-3c67e0f1c33mr6722466637.76.1785112327998; Sun, 26 Jul 2026
 17:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785101237.git.mst@redhat.com>
 <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
In-Reply-To: <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
From: Peter Xu <peterx@redhat.com>
Date: Sun, 26 Jul 2026 20:31:57 -0400
X-Gm-Features: AUfX_mz7mYecCpqp9O6CVs1G3Y9NrMdAPf6klTqtTijWmBM2sMcmYc4Sc4Rsvzk
Message-ID: <CADLectmKQT+hU_3TG2Popan8f5QphEEpwsR+Ps=+WTZo-Z_M_Q@mail.gmail.com>
Subject: Re: [PULL 17/30] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="00000000000031f37106578cda5e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--00000000000031f37106578cda5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is migration only change and hasn't been reviewed.  Give us a
few days to review it?
Can't do it now because it is on cellphone and I just bathed my son.

Please hold off merging.

Thanks.

On Sun, Jul 26, 2026, 5:29=E2=80=AFp.m. Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> vhost user currently saves the inflight buffer to the migration stream
> using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
> backend.
>
> But the implementation of that is broken if size is >2G: it stores the
> buffer size in a uint64_t field, but vmstate_size() always reads the
> size field as int32_t regardless of the macro used. This, in turn,
> causes negative or truncated lengths on load, leading to undersized
> allocations and down the road out-of-bounds buffer access.
>
> There's no practical reason to support such large sizes, so it's enough
> to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
> reject negative or oversized values, and propagate errors to
> vmstate_load_vmsd().
>
> Note: the large value is coming from the backend, not guest, so this
> shouldn't be considered a security issue. The CVE was assigned before
> the qemu security policy was updated to exclude this class of bugs.
>
> Fixes: CVE-2026-6426
> Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
> Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <
> 801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
> ---
>  include/migration/vmstate.h |  5 ++++-
>  migration/vmstate.c         | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1b7f295417..e7095cd977 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -168,6 +168,9 @@ enum VMStateFlags {
>       */
>      VMS_ARRAY_OF_POINTER_AUTO_ALLOC =3D 0x10000,
>
> +    /* Use a uint64_t size field for VMS_VBUFFER instead of int32_t. */
> +    VMS_VBUFFER_UINT64              =3D 0x40000,
> +
>      /* Marker for end of list */
>      VMS_END                         =3D 0x20000,
>  };
> @@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .field_exists =3D (_test),                                         \
>      .size_offset  =3D vmstate_offset_value(_state, _field_size, uint64_t=
),\
>      .info         =3D &vmstate_info_buffer,                            \
> -    .flags        =3D VMS_VBUFFER | VMS_POINTER,                       \
> +    .flags        =3D VMS_VBUFFER | VMS_VBUFFER_UINT64 | VMS_POINTER,  \
>      .offset       =3D offsetof(_state, _field),                        \
>  }
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 50ebe37845..d7f03a9f5b 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const
> VMStateField *field)
>      int size;
>
>      if (field->flags & VMS_VBUFFER) {
> -        size =3D *(int32_t *)(opaque + field->size_offset);
> -        if (field->flags & VMS_MULTIPLY) {
> -            size *=3D field->size;
> +        uint64_t usize64;
> +
> +        if (field->flags & VMS_VBUFFER_UINT64) {
> +            usize64 =3D *(uint64_t *)(opaque + field->size_offset);
> +        } else {
> +            int32_t ssize32 =3D *(int32_t *)(opaque + field->size_offset=
);
> +            if (ssize32 < 0) {
> +                return -1;
> +            }
> +            usize64 =3D ssize32;
>          }
> +        if (field->flags & VMS_MULTIPLY) {
> +            usize64 *=3D field->size;
> +        }
> +        if (usize64 > INT_MAX) {
> +            return -1;
> +        }
> +        size =3D usize64;
>      } else if (field->flags & VMS_ARRAY_OF_POINTER) {
>          /*
>           * For an array of pointer, the each element is always size of a
> @@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const
> VMStateDescription *vmsd,
>              void *first_elem =3D opaque + field->offset;
>              int i, n_elems =3D vmstate_n_elems(opaque, field);
>              int size =3D vmstate_size(opaque, field);
> +            if (size < 0) {
> +                error_setg(errp, "VMState field '%s': invalid size",
> +                           field->name);
> +                return false;
> +            }
>
>              vmstate_handle_alloc(first_elem, field, opaque);
>              if (field->flags & VMS_POINTER) {
> @@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const
> VMStateDescription *vmsd,
>              bool use_dynamic_array =3D
>                  field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
>
> +            if (size < 0) {
> +                error_setg(errp, "VMState field '%s': invalid size",
> +                           field->name);
> +                ok =3D false;
> +                goto out;
> +            }
>              trace_vmstate_save_state_loop(vmsd->name, field->name,
> n_elems);
>              if (field->flags & VMS_POINTER) {
>                  first_elem =3D *(void **)first_elem;
> --
> MST
>
>

--00000000000031f37106578cda5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">This patch is migration only change and hasn&#39;t been r=
eviewed.=C2=A0 Give us a few days to review it?<div dir=3D"auto">Can&#39;t =
do it now because it is on cellphone and I just bathed my son.</div><div di=
r=3D"auto"><br><div dir=3D"auto">Please hold off merging.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Thanks.</div></div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Sun, Jul 26, 2026, 5:29=E2=80=AFp.m. Michael S. Tsirkin &lt;<a href=3D=
"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">vhost user currently saves the inflight buffer to the mi=
gration stream<br>
using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user<br>
backend.<br>
<br>
But the implementation of that is broken if size is &gt;2G: it stores the<b=
r>
buffer size in a uint64_t field, but vmstate_size() always reads the<br>
size field as int32_t regardless of the macro used. This, in turn,<br>
causes negative or truncated lengths on load, leading to undersized<br>
allocations and down the road out-of-bounds buffer access.<br>
<br>
There&#39;s no practical reason to support such large sizes, so it&#39;s en=
ough<br>
to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,<br>
reject negative or oversized values, and propagate errors to<br>
vmstate_load_vmsd().<br>
<br>
Note: the large value is coming from the backend, not guest, so this<br>
shouldn&#39;t be considered a security issue. The CVE was assigned before<b=
r>
the qemu security policy was updated to exclude this class of bugs.<br>
<br>
Fixes: CVE-2026-6426<br>
Fixes: f6fdd8b2bd (&quot;vmstate: introduce VMSTATE_VBUFFER_UINT64&quot;)<b=
r>
Cc: Alexandr Moshkov &lt;<a href=3D"mailto:dtalexundeer@yandex-team.ru" tar=
get=3D"_blank" rel=3D"noreferrer">dtalexundeer@yandex-team.ru</a>&gt;<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/3675=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-p=
roject/qemu/-/work_items/3675</a><br>
Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:801b1501ee10241f7ac49a10570d548352b36347.=
1784890517.git.mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">801b150=
1ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/migration/vmstate.h |=C2=A0 5 ++++-<br>
=C2=A0migration/vmstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 31 +++++++++++=
+++++++++++++++++---<br>
=C2=A02 files changed, 32 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h<br>
index 1b7f295417..e7095cd977 100644<br>
--- a/include/migration/vmstate.h<br>
+++ b/include/migration/vmstate.h<br>
@@ -168,6 +168,9 @@ enum VMStateFlags {<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0VMS_ARRAY_OF_POINTER_AUTO_ALLOC =3D 0x10000,<br>
<br>
+=C2=A0 =C2=A0 /* Use a uint64_t size field for VMS_VBUFFER instead of int3=
2_t. */<br>
+=C2=A0 =C2=A0 VMS_VBUFFER_UINT64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 0x40000,<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Marker for end of list */<br>
=C2=A0 =C2=A0 =C2=A0VMS_END=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x20000,<br>
=C2=A0};<br>
@@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;<br>
=C2=A0 =C2=A0 =C2=A0.field_exists =3D (_test),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0.size_offset=C2=A0 =3D vmstate_offset_value(_state, _fi=
eld_size, uint64_t),\<br>
=C2=A0 =C2=A0 =C2=A0.info=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &amp;vmstate=
_info_buffer,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D VMS_VBUFFER | VMS_POIN=
TER,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D VMS_VBUFFER | VMS_VBUF=
FER_UINT64 | VMS_POINTER,=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0.offset=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D offsetof(_state, =
_field),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
=C2=A0}<br>
<br>
diff --git a/migration/vmstate.c b/migration/vmstate.c<br>
index 50ebe37845..d7f03a9f5b 100644<br>
--- a/migration/vmstate.c<br>
+++ b/migration/vmstate.c<br>
@@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const VMStateFi=
eld *field)<br>
=C2=A0 =C2=A0 =C2=A0int size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (field-&gt;flags &amp; VMS_VBUFFER) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D *(int32_t *)(opaque + field-&gt;size_=
offset);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (field-&gt;flags &amp; VMS_MULTIPLY) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size *=3D field-&gt;size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t usize64;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (field-&gt;flags &amp; VMS_VBUFFER_UINT64) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usize64 =3D *(uint64_t *)(opaque=
 + field-&gt;size_offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t ssize32 =3D *(int32_t *)=
(opaque + field-&gt;size_offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ssize32 &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usize64 =3D ssize32;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (field-&gt;flags &amp; VMS_MULTIPLY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usize64 *=3D field-&gt;size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usize64 &gt; INT_MAX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D usize64;<br>
=C2=A0 =C2=A0 =C2=A0} else if (field-&gt;flags &amp; VMS_ARRAY_OF_POINTER) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * For an array of pointer, the each elem=
ent is always size of a<br>
@@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescr=
iption *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *first_elem =3D opaque=
 + field-&gt;offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, n_elems =3D vmstate_=
n_elems(opaque, field);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size =3D vmstate_size(o=
paque, field);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &=
quot;VMState field &#39;%s&#39;: invalid size&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0field-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_handle_alloc(first_=
elem, field, opaque);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (field-&gt;flags &amp; V=
MS_POINTER) {<br>
@@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMS=
tateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool use_dynamic_array =3D<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field-&gt;fla=
gs &amp; VMS_ARRAY_OF_POINTER_AUTO_ALLOC;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &=
quot;VMState field &#39;%s&#39;: invalid size&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0field-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_save_state_lo=
op(vmsd-&gt;name, field-&gt;name, n_elems);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (field-&gt;flags &amp; V=
MS_POINTER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0first_elem =
=3D *(void **)first_elem;<br>
-- <br>
MST<br>
<br>
</blockquote></div>

--00000000000031f37106578cda5e--


