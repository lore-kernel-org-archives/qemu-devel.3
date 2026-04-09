Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB97F31E50
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wArja-0000oO-L5; Thu, 09 Apr 2026 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wArjZ-0000oD-Oj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wArjW-000256-Pw
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775750149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eeOSkEWAacOJdug4XGf69hO4//eff5woT9XlrmTMb8A=;
 b=L9HGd7XeUui5GbxVzXBUn31V3Gvx7iu8V/TvBteRgeVMHc+/YB4YwYT5aJ1jtBlDVkKqIi
 GlFWMmjXy6PZo4Q3Q7xTAsMu1lY7hfrttLSqsysR8tQvC25s9YlmiYfgmjiKqoXkVn9uqA
 4OSv9uRKoXKNYVEGN8ROIVNE4jb5Tfg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-uMMHlypaNpuvV3vZ-GxDHg-1; Thu, 09 Apr 2026 11:55:47 -0400
X-MC-Unique: uMMHlypaNpuvV3vZ-GxDHg-1
X-Mimecast-MFC-AGG-ID: uMMHlypaNpuvV3vZ-GxDHg_1775750147
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b249975139so24901175ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775750146; x=1776354946; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eeOSkEWAacOJdug4XGf69hO4//eff5woT9XlrmTMb8A=;
 b=CIGDad0B0YOM1mA12c9OElkoDySRoBG6QOYxT2UlaS20ekpgJYI+oo9y43n9n9zt/B
 IGGOmWjDORTGMIug/oSsmIPrN2sPFS6r+jbN6d2paFvnri2y9EypyoKtLcwnwKiuM8Y3
 lxDDZLbCPCAsNEvZivl6dStwMI/8t8viEW9C/97WRqDrjLtZK6755KUbRLADTPaCkqgc
 04VeFVRCh2eQCuDdjDWZamZMWXuhlYudl9Zg+Yl5ufgHccorEbii6aj0qqN9ZM2mqo5X
 jYBbubh0NEV1BT3hiRQAwl9VtYG4G8BAo3SpLWIYzSA4aYAvek2fStJ73OHwFKjybk6z
 8Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775750146; x=1776354946;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eeOSkEWAacOJdug4XGf69hO4//eff5woT9XlrmTMb8A=;
 b=Gbgba6BL7VhkDfzbsNzmvAYFcwmLxD0i/RH0piaT/d1cGJn4lIeUo8qDEOgMa4tkik
 i1m35NUVh+dKsWAiQSElqg8WujBpCefiWZLOmzBzXX0Tq951o03RysFTu6HTyzvRRdTO
 wIwNLtzKrOqd7ppycakq5y+k6V2j4ID0g0oMJapwDK6RB6EdsWKXXnsBJMvl7LbKOYt5
 g4rv6yVHA+DnjGWIlTpQD+7pbiW/riVGJvYTXDVksUEb77SByDnopdW5J3GKlXxbzf52
 2SlYhyDm8AiVu++RT5nwGGYaiMeTdz2P8HnFZ/DEoBCXh2yBSI4rcTdzSj9saHE5TnPe
 upKg==
X-Gm-Message-State: AOJu0YyqvaonLxKdppDM792VMlwRX1w2iAmzwZKOKIAWLgyXGit5jzUa
 T9oq4Hlki8r4JKM1tdR0oTlcE+wmNGjmsJE+72CyDxSAbYUbI4MOUJVTO/BE9jtU1QP+52BTEGV
 /RGsBourZYRlR9RPyO9ClepWHs/ZJkO6p/lRQEb86q8qbYzv/hIvieHMx
X-Gm-Gg: AeBDievD5WYPC+eKX3/fRHk/bCfB/WxwP+TJKkgy2Hh4+CrEyJ9GF9la16UUJJcWrk6
 TYXCupmEwANLTJCcc08L0et4orzwxXXTsjTRSfQoso4aNuct+2fEAqZ/EYIpiYoy7dSaCYFZXLY
 kUq0oxgux2YlSN/NS+SJLavcA78ZpozLKvJl+fq+tilfa4OnCXbxkpCmRZfc205A8KK00UlHOa3
 dxOVt/5sPREjXlaxs9ogUnzWShMhlqw5wD4DG/ORdi3lJc1AXRcYHHh1y2cq91WQKPsf0G6saJy
 rwh2KyK0MpyNgXFwtM4RFiwyb+rwfu9GOZpUEK/EgLk0V7dShYBAjEvx40Sl2kK1CIZhviHnfX6
 SOLtsRKxiJNuK
X-Received: by 2002:a17:903:17cb:b0:2b2:58c7:2cd6 with SMTP id
 d9443c01a7336-2b28167569cmr305250845ad.5.1775750146536; 
 Thu, 09 Apr 2026 08:55:46 -0700 (PDT)
X-Received: by 2002:a17:903:17cb:b0:2b2:58c7:2cd6 with SMTP id
 d9443c01a7336-2b28167569cmr305250575ad.5.1775750146056; 
 Thu, 09 Apr 2026 08:55:46 -0700 (PDT)
Received: from fedora ([49.36.110.202]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749ce29esm258783435ad.81.2026.04.09.08.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:55:45 -0700 (PDT)
Date: Thu, 9 Apr 2026 21:25:39 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/2] migration/vmstate: Add VMState support for GByteArray
Message-ID: <adfL-_ELA6xAiEEm@fedora>
References: <20260406115247.4879-1-armenon@redhat.com>
 <20260406115247.4879-2-armenon@redhat.com>
 <CAMxuvay-aNCowYdtK_zoxj1JYoj8a3nxHXR+Q8DM=6gm+vurOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvay-aNCowYdtK_zoxj1JYoj8a3nxHXR+Q8DM=6gm+vurOg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Marc-André, 
Thanks for the review.

On Tue, Apr 07, 2026 at 11:32:24AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Apr 6, 2026 at 3:53 PM Arun Menon <armenon@redhat.com> wrote:
> >
> > From: Arun Menon <armenon@redhat.com>
> >
> > In GLib, GByteArray is an object managed by the library. Currently,
> > migrating a GByteArray requires treating it as a raw C struct and using
> > VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
> > ui/vdagent.c
> >
> > QEMU cannot pretend that GByteArray is a C struct and simply use
> > VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
> > overwrites the data pointer with a newly allocated buffer, thereby
> > leaking the previous memory. Besides, GLib tracks the array's capacity
> > in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
> > sync with the newly allocated buffer, potentially leading to heap buffer
> > overflows during subsequent g_byte_array_append() calls.
> >
> > This commit introduces VMSTATE_GBYTEARRAY which uses specific library
> > API calls (g_byte_array_set_size()) to safely resize and populate the
> > buffer.
> 
> Looks ok to me, although it's easy to miss something here given all
> the casting, compatibility, etc.

Yes, looks like I missed it. In order to update the device state
itself, I will have to pass a pointer to GByteArray pointer.
struct CRBState
{
    GByteArray *command_buffer;
};

Currently VMS_POINTER flag does the job of dereferencing and then it
passes the value in pv. My bad, I misunderstood it. I am removing it,
and I shall change the get and put functions.

> 
> My understanding is that this VMState code should safely replace the
> existing vdagent bytearray struct (done in the next patch):
> 
> static const VMStateDescription vmstate_vdba = {
>     .name = "vdagent/bytearray",
>     .version_id = 0,
>     .minimum_version_id = 0,
>     .fields = (const VMStateField[]) {
>         VMSTATE_UINT32(len, GByteArray),
>         VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
>         VMSTATE_END_OF_LIST()
>     }
> };
> 
> some testing before<->after seems to work,
> 
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > Fix-Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  include/migration/vmstate.h | 10 ++++++++++
> >  migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 62c2abd0c4..ab20445c4c 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
> >  extern const VMStateInfo vmstate_info_qtailq;
> >  extern const VMStateInfo vmstate_info_gtree;
> >  extern const VMStateInfo vmstate_info_qlist;
> > +extern const VMStateInfo vmstate_info_g_byte_array;
> >
> >  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
> >  /*
> > @@ -892,6 +893,15 @@ extern const VMStateInfo vmstate_info_qlist;
> >      .start        = offsetof(_type, _next),                              \
> >  }
> >
> > +#define VMSTATE_GBYTEARRAY(_field, _state, _version) {                   \
> > +    .name         = (stringify(_field)),                                 \
> > +    .version_id   = (_version),                                          \
> > +    .size         = sizeof(GByteArray),                                  \
> > +    .info         = &vmstate_info_g_byte_array,                          \
> > +    .flags        = VMS_SINGLE | VMS_POINTER,                            \
> > +    .offset       = vmstate_offset_pointer(_state, _field, GByteArray),  \
> > +}
> > +
> >  /* _f : field name
> >     _f_n : num of elements field_name
> >     _n : num of elements
> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > index 89cb211472..ccac731388 100644
> > --- a/migration/vmstate-types.c
> > +++ b/migration/vmstate-types.c
> > @@ -942,3 +942,40 @@ const VMStateInfo vmstate_info_qlist = {
> >      .get  = get_qlist,
> >      .put  = put_qlist,
> >  };
> > +
> > +static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
> > +                            const VMStateField *field)
> > +{
> > +    GByteArray *byte_array = pv;
> > +    uint32_t len = qemu_get_be32(f);
> > +
> > +    if (!byte_array) {
> > +        byte_array = g_byte_array_new();
> 
> You'd need to update *pv too (*(void **)pv =  .. or something)

Yes, changed in v2.

> 
> > +    }
> > +
> > +    g_byte_array_set_size(byte_array, len);
> > +    if (len > 0) {
> > +        qemu_get_buffer(f, byte_array->data, len);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
> > +                            const VMStateField *field, JSONWriter *vmdesc)
> > +{
> > +    GByteArray *byte_array = pv;
> > +    uint32_t len = byte_array ? byte_array->len : 0;
> > +
> > +    qemu_put_be32(f, len);
> > +    if (len > 0) {
> > +        qemu_put_buffer(f, byte_array->data, len);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +const VMStateInfo vmstate_info_g_byte_array = {
> > +    .name = "GByteArray",
> > +    .get  = get_g_byte_array,
> > +    .put  = put_g_byte_array,
> > +};
> > --
> > 2.53.0
> >
> 

Regards,
Arun Menon


