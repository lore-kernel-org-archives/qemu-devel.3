Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABA7FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXL-00009j-GT; Tue, 07 Apr 2026 14:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTx-0003Pl-9o
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA0vR-0007b4-Dy
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775547158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYjlT008cqSVRyOQUcptvJx0SlO7vUM6MOm6i7R1EUQ=;
 b=bOQ54qx4QfyaqXl4QCiXsgtxnzS66c6M3J7bKFv4y22br3OR/gR5DcErdUFrtgeZaH+J7Y
 Vr9Ux6TonkP31crI6O4ZyD5K5Fu6wHrPu6JGeV8z6dLzcsAz2ZvLciQ/ZMWLOeCKY+vAp9
 Dd5UpfvHSf+0pV5GowdS40lHL2SvURc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-TkA-4xXuMx2o9ZGi2oUQrQ-1; Tue, 07 Apr 2026 03:32:37 -0400
X-MC-Unique: TkA-4xXuMx2o9ZGi2oUQrQ-1
X-Mimecast-MFC-AGG-ID: TkA-4xXuMx2o9ZGi2oUQrQ_1775547157
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c7691378914so2104628a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 00:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775547156; cv=none;
 d=google.com; s=arc-20240605;
 b=I7MJRJ2esEsoB012GL1djAbvdf+epmw0VSNeff6UUdBrGpATj22MJjK8lkgWeJHI9J
 7gpXeElI88ZzYro67uY1LiKynshfF2z0TwnbFCrzFE0SLgPlV9KxFGUg/6bCUS4Eiwid
 EHjb1HU9ajvgDz59V35c5A7emTBX06wD/QWh+UeIXD8QhfJ9p1jmtuzxfFmk9Oh/ZgSr
 64tXiLK8UGXlatQL4zhuQwKjM3g/7D/3iST4tjqaUQTKOBPw1zFlpJwR+O/EcTRhQV/m
 U238ZkFUkckaArOsUW2yr+Z/gltYxNSbEl7SgobZXBmHCzfz23ewAZ6+E2rorxqcAW4C
 5WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gYjlT008cqSVRyOQUcptvJx0SlO7vUM6MOm6i7R1EUQ=;
 fh=jujcIkqyn3FRnCbt7C3PuJY7od+eC76KIHLHCfXRwXs=;
 b=GxuBliVFxvBTR66IgmRf1St9iSmH+ZTWVRbZTCDMEJm0ggCcQRd+5ITx4y5WPrMWar
 uCspgSfNn+Z8yhtS2B/uym1BU5/jGColFQ0AYM2+o9eZ/vDm1u5OplU6bcE2E5fEVQld
 IG4sTlQinA1UpW2WRcyqUxXXTJfksauYHaE1QXHhatqjwMS9PV62iEICar+H+cIUEqID
 6VchL8hnTLRR9Z/0jekYtGbtqws5BULZqZYVWpkS6CdjHY3E5XMJJh/4vb5rva9gGxUx
 lqyLl4WHG8ebUIybwrhAGh2DzstpyLVRhEoFW7JSoXfqLXVUvYnTutyyKBeWc1iEaoMA
 HeRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775547156; x=1776151956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYjlT008cqSVRyOQUcptvJx0SlO7vUM6MOm6i7R1EUQ=;
 b=abftMKVaeMb6NuHhruNg2DryBQuZwJGyN5jj3JP/P9VtWS9DqeErxbjE7VDL/lWj9e
 G5t9l12AruJ3EENkEw8DC0KBgeS5Iuu4VFUoaslTDHMNpmT/EWP7VQRr0Mfn1DeiroI6
 sKggdheKZw4Lis1QF+u68qF/eFESVy4JB2IY5jFlZ1CCurwFm3q6/grXhKq4YFUQ6TJI
 7Xy8wvnaLqnr5rkF1qgnlGBUZxICcrl6XNhJGRTkvXGI1i3sdDbrVl73MotwSM7KsrGh
 D/AeTcBOyGFV8jKAt++bWfnHd8Qr6LP23Ew8LajKiyVM0pbQvuwmb5pKeVG+vMHWbPn/
 PT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775547156; x=1776151956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gYjlT008cqSVRyOQUcptvJx0SlO7vUM6MOm6i7R1EUQ=;
 b=E1bpSFhzjFfvnYiwPIuz9vhC5vGIiUpSzRWqogsJmEVz51hCXxBMEvIt5T5SZlK7FG
 TI51nifKWnBTzl7TtUTo5Z7TLPtSozS95VhPJcuMb6ARfuUtPMmucunE+21g22GQFqCd
 EkW/OoxrjJz1BIM3XZxk81f/lBSdEM1bp0xe+M5MarJJvvIUdraeBw6lbgqPenOPIvnf
 r9VSaRDGZRVPceiZDyd5FFDdIC/KwJQaqISiQXdVvcdvxQxmbBth96ihtTzROCCsgKsP
 YqQ4RpKj8cXmWNr6zMWVQG9Da+b5WaBe42toUTPnOUw9IwAqQMsB2jdVdXVkcT6MPdei
 UUwQ==
X-Gm-Message-State: AOJu0Yw9yLneVvhrmKc8EQ1UQKrLDodrVCBlV1b6Vhy8nIbJnFWIXbDe
 l1jeximmXPBonsA1Qv67AsW+WpLiGMlaaJBEC0A/HXQbmcDNXntMf3dL9mVrX/jw1sb4mUKhBKN
 IjTj3ykSZZUu4gCkn+u5stenD6p5c/97GSEqmJIfszqoqkRAjGZKjo+28s8MdQvhAOfz5HWoaI9
 hwdIldStwVnAU69pHvx0NF7dorC/CPkKg=
X-Gm-Gg: AeBDieup7s2UtFDkdoWBiOZfV2TYJRzr9huSxrVoswwH9tCu2qx47Ytu7FxIXsIcQVp
 qENMFL9nx9VDw335O4C+D7VHGr9V8iXIMMXEyGY2kYZPZ0Kl2FlSDzFcQM8KB6H7Ux142ypITQV
 wCaZb/gByY/nB5uB/keGgaDB4PzEoPE+etU951xYASSm0iU2Ix84yzn4XywCalkAG6Rr9fSlde9
 hyKtH6IQf15Mic3clxJ5hpA5KKm+kFAFCtO+i8Gd7ZSeKgqaiys0f3S+8GjWS5OeDbFBO5hpPwp
 9GTi76OAmDAFwvgGibsDhtg=
X-Received: by 2002:a05:6a20:db91:b0:39f:3559:7525 with SMTP id
 adf61e73a8af0-39f35597805mr16151300637.31.1775547156435; 
 Tue, 07 Apr 2026 00:32:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:db91:b0:39f:3559:7525 with SMTP id
 adf61e73a8af0-39f35597805mr16151267637.31.1775547155924; Tue, 07 Apr 2026
 00:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260406115247.4879-1-armenon@redhat.com>
 <20260406115247.4879-2-armenon@redhat.com>
In-Reply-To: <20260406115247.4879-2-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 11:32:24 +0400
X-Gm-Features: AQROBzA9uQq9jrVjmFMzDNDqwrCbJ3VUSuUdlm-GM0yr70-AJegJTS8Fqd4xtn4
Message-ID: <CAMxuvay-aNCowYdtK_zoxj1JYoj8a3nxHXR+Q8DM=6gm+vurOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration/vmstate: Add VMState support for GByteArray
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
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

Hi

On Mon, Apr 6, 2026 at 3:53=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
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

Looks ok to me, although it's easy to miss something here given all
the casting, compatibility, etc.

My understanding is that this VMState code should safely replace the
existing vdagent bytearray struct (done in the next patch):

static const VMStateDescription vmstate_vdba =3D {
    .name =3D "vdagent/bytearray",
    .version_id =3D 0,
    .minimum_version_id =3D 0,
    .fields =3D (const VMStateField[]) {
        VMSTATE_UINT32(len, GByteArray),
        VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
        VMSTATE_END_OF_LIST()
    }
};

some testing before<->after seems to work,

>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Fix-Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  include/migration/vmstate.h | 10 ++++++++++
>  migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 62c2abd0c4..ab20445c4c 100644
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
> +    .flags        =3D VMS_SINGLE | VMS_POINTER,                         =
   \
> +    .offset       =3D vmstate_offset_pointer(_state, _field, GByteArray)=
,  \
> +}
> +
>  /* _f : field name
>     _f_n : num of elements field_name
>     _n : num of elements
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 89cb211472..ccac731388 100644
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
> +    GByteArray *byte_array =3D pv;
> +    uint32_t len =3D qemu_get_be32(f);
> +
> +    if (!byte_array) {
> +        byte_array =3D g_byte_array_new();

You'd need to update *pv too (*(void **)pv =3D  .. or something)

> +    }
> +
> +    g_byte_array_set_size(byte_array, len);
> +    if (len > 0) {
> +        qemu_get_buffer(f, byte_array->data, len);
> +    }
> +    return 0;
> +}
> +
> +static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, JSONWriter *vmdes=
c)
> +{
> +    GByteArray *byte_array =3D pv;
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


