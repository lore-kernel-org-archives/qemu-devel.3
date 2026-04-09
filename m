Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAAEF364B1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 18:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAuV1-0005IJ-Co; Thu, 09 Apr 2026 14:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wAuV0-0005I7-Ev
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 14:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wAuUy-00086P-IN
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 14:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775760783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DsfaXPU4JEt1er7Aw3z8+60MnkelSlIuFpqq8O/RGBc=;
 b=DHLoHm9im772+G0EGAQ+qCUdOcABP9LXQQLhhWavd6f5c1n722YxXEP1KQxY/Hoie/XAKt
 QcdPNkBJlGR3PhkyH+S78M78KLXmzuBbmHTVZghFJZ9Xp+8+uOmY+bWlrNAEW5HE9OWH/9
 EspOX8ygslqqczBj/vrOQaBMIt016Xg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-MmggZe9rNs6l-hMTpBQz0g-1; Thu, 09 Apr 2026 14:53:01 -0400
X-MC-Unique: MmggZe9rNs6l-hMTpBQz0g-1
X-Mimecast-MFC-AGG-ID: MmggZe9rNs6l-hMTpBQz0g_1775760780
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35da1c703d1so1618659a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 11:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775760780; cv=none;
 d=google.com; s=arc-20240605;
 b=Ce2I7ceNPx6boCMGHvgf4iBvy9M1kUM8qI8NkDxH0SlBaGIjg9RynT1q1O/fbK0Pzn
 UGiikcwGXzvuVmdbeTwsws6GOE4w7sTzG8/+NiCg9OgytJVVRex50FHa5LBZ4evIP+7t
 Va0Uxv+2pOPQZw1EQhRJKXU1yaZOJ4MMfOwEPUQUNYXSWnf8Tx2hObM22XyV+5iKMSPH
 KHiQw/WWKxS51pn1N4486yPkVRtC3gS+1pD0TqmtOx1jfkERBE7nR7NjrmQSuHkBTOlA
 RHJr5eSw0lybIkaxx+lms1bsP9umll5/Ia6ArRDjwY/52jTpxMhar9DJEkD6xk1Nv9BF
 sW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DsfaXPU4JEt1er7Aw3z8+60MnkelSlIuFpqq8O/RGBc=;
 fh=mw9gJ3NHaR+Vj/a4pckPdLnnz/hb8kTo9Ml/z+z9za4=;
 b=lotAILtSteX+WfvYgcmCAIx+s77RvvjluKgSJRnH2DsTg4+plsZcDgdjNw56mcqWv3
 0wnBsYFdee85CaboMpfL5p/2kMUYRJTEgVbcwhB91zH8kmPH2AyepvuWr7dI516lTdeV
 I9ZtMgj7kWuMOvh7Q5AT85X+avF7EcuKjuXpSJY3Y+oD+KnNX+i7a0oiD46Mx8Ip8BSN
 ZV3ubtVetCjngmpGEXjRLzsBI7P3GvWxexxT5LZ+Ht1WhcaJzSC/TZBq4C8cwxKlYNOS
 xXIxEhXVVtbSoEU9p2dD5uPQXZlopTM1UOfseC+j06tnNqpvhJz0NYLBdCl4E0eMtAv2
 Ppfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775760780; x=1776365580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsfaXPU4JEt1er7Aw3z8+60MnkelSlIuFpqq8O/RGBc=;
 b=dyvqIu+DJhPz+zQcLtxVrFbdYsDYZ7x1qZgGabiSB1nuyKKQ1DWRVNaTVUqC58Q+b4
 mXM2WgJTBbeQV6ZC9CTsI0kIjSBxyVBUNs3m+fd5neNtXu5N/zCtvxXlm1ojBe5zYMqe
 8HzPNhwiAJi0GV2XxfczLAr3Ny4Asbz6aYnUPILEFLCsOf5rY/UDTBpe96x+KoNWe/B4
 pOl5qqVaU+beN0Cw2RiCkRg5dCp7TMf59vHV3r5twQ5XguW4l4u7J7cDfNrtoMdfFzDP
 AumnUw9hjBW88xIRSud4Fw6imxSLrpoj53hhc69bvQstRnDZTD/+mJG9QkkhFVAZHD4C
 mqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775760780; x=1776365580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DsfaXPU4JEt1er7Aw3z8+60MnkelSlIuFpqq8O/RGBc=;
 b=AYSWzxrl5/Tf/5Uostar/DqwwhQgB0L9jchl50hU1Jn1LgHd9vV3pcaFjSxWHu+xVN
 BUk+Cb8qMMCJRj2pT0cBex3sZPVwwmK4CO6L51+jZGg47MewfWgUgQRg1ansasTQmvYo
 NW3oy/MHr6/KvMbsIzmlhtKO+Y/ZPQEE3xIBKIbgplj5gcscTk0YN/8oAx2acpKVbMKl
 R5biCVLYtfqaX0zaUXP+p7Y9jw/E2d/UjxQ5XcZJc7GqxFUYB8oc+xgoDkrMGDaBK6N9
 nFN7F32wud0BEuBwhYIK4PihAz3eoxWWrqQK+40cmtdDDodVjPAAgCdaiDWjMhK8j2KI
 3cDw==
X-Gm-Message-State: AOJu0YzIq1JOW/z3znPiFUY8FO433ZX9OPeESesuVeaN5O6pX7WMfC5Z
 NDP2lSk+qodXN1U1DUERArSZ0sotyu/vaqJ3Qkl0iEgL1sIniBMM72ekEqXPKYIXZrHfcHUEdTb
 ONmL/uuCe50K5iev/ZBncE0IzMmyPuHPKJ2vTvvzA3x48xGLzXNkRyHfN8vvhM+Nl4frR8kpg9e
 cxJ9RGInfIJ3X/l30A8OpEFG/sRMlYpak=
X-Gm-Gg: AeBDievonRLGFFbN9R96cesOpb7H16MEYXutAdltBcBzOm9xDaFeqlTU+b/uUBjFQbd
 1TyFy3Qf/AK8CQMjkCq80U5k9IOSN9khb5YGWe2UKTtNLr++/WpV/MhiVxUJc8kn25jMzkt3ziN
 I7x/3ITrQ6+Z0OvEnfemi1N0yF9IoaPp6hm7dz3v8NA5FDpJFRRXzx5loPdADu5dHz8rl6a2CaT
 JLXXF1sWuD2nX2xDXbm+C9pxe0cqXTAVJmb9DvGIA56lUzUkNb09wZs2IpAtIe2Brzcv5zCBWay
 xfNQWXXt03ykegT3enj/QFXl
X-Received: by 2002:a17:90b:1b4e:b0:35d:972c:b3d6 with SMTP id
 98e67ed59e1d1-35e42781510mr227659a91.9.1775760780222; 
 Thu, 09 Apr 2026 11:53:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1b4e:b0:35d:972c:b3d6 with SMTP id
 98e67ed59e1d1-35e42781510mr227632a91.9.1775760779777; Thu, 09 Apr 2026
 11:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260409175126.5921-1-armenon@redhat.com>
 <20260409175126.5921-2-armenon@redhat.com>
In-Reply-To: <20260409175126.5921-2-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 9 Apr 2026 22:52:48 +0400
X-Gm-Features: AQROBzCfxa_gGtOalkuohhAzaRzMEfOKP-GJ_MtLk8F2InvJfcwAqfQHzOPp_ys
Message-ID: <CAMxuvazwMYi=Y54qkP6fkwyrFxqK+m_u=eV2PzWG30yrvN9ySA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] migration/vmstate: Add VMState support for
 GByteArray
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 9, 2026 at 9:52=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> From: Arun Menon <armenon@redhat.com>
>
> In GLib, GByteArray is an object managed by the library. Currently,
> migrating a GByteArray requires treating it as a raw C struct and using
> VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
> ui/vdagent.c
>
> QEMU cannot pretend that GByteArray is a C struct and simply use
> VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
> overwrites the data pointer with a newly allocated buffer, thereby
> leaking the previous memory. Besides, GLib tracks the array's capacity
> in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
> sync with the newly allocated buffer, potentially leading to heap buffer
> overflows during subsequent g_byte_array_append() calls.
>
> This commit introduces VMSTATE_GBYTEARRAY which uses specific library
> API calls (g_byte_array_set_size()) to safely resize and populate the
> buffer.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Fix-Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>

you have 2 signed-off trailer tags

> ---
>  include/migration/vmstate.h | 10 ++++++++++
>  migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 62c2abd0c4..f503a40ec0 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
>  extern const VMStateInfo vmstate_info_qtailq;
>  extern const VMStateInfo vmstate_info_gtree;
>  extern const VMStateInfo vmstate_info_qlist;
> +extern const VMStateInfo vmstate_info_g_byte_array;
>
>  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
>  /*
> @@ -892,6 +893,15 @@ extern const VMStateInfo vmstate_info_qlist;
>      .start        =3D offsetof(_type, _next),                           =
   \
>  }
>
> +#define VMSTATE_GBYTEARRAY(_field, _state, _version) {                  =
 \
> +    .name         =3D (stringify(_field)),                              =
   \
> +    .version_id   =3D (_version),                                       =
   \
> +    .size         =3D sizeof(GByteArray),                               =
   \
> +    .info         =3D &vmstate_info_g_byte_array,                       =
   \
> +    .flags        =3D VMS_SINGLE,                                       =
   \
> +    .offset       =3D vmstate_offset_pointer(_state, _field, GByteArray)=
,  \
> +}
> +
>  /* _f : field name
>     _f_n : num of elements field_name
>     _n : num of elements
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 89cb211472..743c2092e9 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -942,3 +942,40 @@ const VMStateInfo vmstate_info_qlist =3D {
>      .get  =3D get_qlist,
>      .put  =3D put_qlist,
>  };
> +
> +static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field)
> +{
> +    GByteArray **byte_array =3D (GByteArray **)pv;
> +    uint32_t len =3D qemu_get_be32(f);
> +
> +    if (*byte_array =3D=3D NULL) {
> +        *byte_array =3D g_byte_array_new();
> +    }
> +
> +    g_byte_array_set_size(*byte_array, len);
> +    if (len > 0) {
> +        qemu_get_buffer(f, (*byte_array)->data, len);
> +    }
> +    return 0;
> +}
> +
> +static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, JSONWriter *vmdes=
c)
> +{
> +    GByteArray *byte_array =3D *(GByteArray **)pv;
> +    uint32_t len =3D byte_array ? byte_array->len : 0;
> +
> +    qemu_put_be32(f, len);
> +    if (len > 0) {
> +        qemu_put_buffer(f, byte_array->data, len);
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateInfo vmstate_info_g_byte_array =3D {
> +    .name =3D "GByteArray",
> +    .get  =3D get_g_byte_array,
> +    .put  =3D put_g_byte_array,
> +};
> --
> 2.53.0
>

the "if (len>0)" may be superflous, but ok

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


