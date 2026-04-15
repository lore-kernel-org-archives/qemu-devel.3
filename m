Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37FFF419BA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0gh-00087M-60; Wed, 15 Apr 2026 09:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0gd-00086y-CU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0ga-0002oV-Vp
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776261223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAc8IogviWHvsejeJuPDoVk9pLAzqQNb4IHGHFbyPhM=;
 b=KxPcfneGr76tJ9Si7BK2wWOWACwF8vI5VWM5uGcUzZ/QoaH0+WgeBAzry4uwnusZCcb/Ko
 Y8wCUIla/FSqPquiqtQmlleLXMgBv/fN/pew1WmF3ze3hRT+IaORfOf46rwajjmgHfccNm
 S/dfdmmGXQCSbZIzEjRcq/BJjNWm91I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-HSc9vso_OtuK4k_hz6sj9Q-1; Wed, 15 Apr 2026 09:53:41 -0400
X-MC-Unique: HSc9vso_OtuK4k_hz6sj9Q-1
X-Mimecast-MFC-AGG-ID: HSc9vso_OtuK4k_hz6sj9Q_1776261221
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f74bcfb86so62075b3a.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776261220; x=1776866020; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AAc8IogviWHvsejeJuPDoVk9pLAzqQNb4IHGHFbyPhM=;
 b=HubLwc5lM0zKwFUfHrT2m7xtdwzQ1YAkAYOXt9LttydOZ4DFJzWr3+VyFlqjJpstbL
 2LGgYsz5pHsJuEbpeW7hzgYpZsqw3j8y2xdhj2QBRTsvhMkEMfmPqnx22oQ+a9MWzk6l
 jLMORokx6FzKQn8rXbDfByQt0Y1CtQzfdmts5mjC2l7FfcMwTjH6ZSaZIvqaAq59AR1j
 kAwvv8wVhn4VUC2WjvSjFDEbCSobdUXc2N9n4+vRz1h26tNntANeENEoSFuYjpZs7Jdz
 j8ibBzbk+envWRCsFoRc8l7FBLmHSRgX/bgFw6veguP9cFhi1yyrEPZpLXwAymxwF6y+
 qTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776261220; x=1776866020;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AAc8IogviWHvsejeJuPDoVk9pLAzqQNb4IHGHFbyPhM=;
 b=WCvl00dMQb3dWM9K/N+qTJqNZDr9IQ9wVYePNAQBqSqK2qpJ83VgtL+6sH3aPprrBt
 7TkxmGbOKDypkwhBO58k2ud7pbsCZV1ssfvcSQZ79Cz2s2yDeh8C4iecjFX90ncW2IL0
 0dxS32PKRx3xILcZro+1H+TFs5YMoxTIpHHh4Me2fq2Z7jJvnuI5TLwTneqqRfqrJq87
 uX8LV1AJPGcMBj2bLnLvrMsst/+cxGD2ptlB5OeiIncyu3kMSUJ8IAdoZv8dAsJdQZ+T
 TbwWy70//+odMrxR5VMnZOdXUiGBRMNM9Pvc6Ekg/Q+qxy7yxdJLyTl4HXw+OIeWRju4
 k6kw==
X-Gm-Message-State: AOJu0YxcjwqKy4T/sjjzmPwKYNkERS1RtsquYRrYuGx84OL2Y4uiXo5c
 nnTODg+yqTTRP99c4/8jQDwUmW/YWfu+qQ6xCt5h+dAXPkPDQL4qNvt+CEf/axiVWZW/y/kGfIr
 nys3bsnS81VwNieVof5yoZmLPgqeQFw98k7gzXx8fF2sx7cRU5zuBHsYm
X-Gm-Gg: AeBDieuLyEr41lA5Hhq7v17Aj/PY0UznG9VTSX+D4lSwsgqf8jNmS0LaPpOTu34/cNo
 vJEMUaySamPC2wIMTYBgMnLeXov3o+pTSyBh+IvARW4boQCXh3EM8/9PvGm5VOASr168lt+3ZTe
 U77a/Kb8Ndp1A7ykFFip64yw4D9qgZXm/82dLFEM5QSI5LfeG62rYgNxYTvW3L6npMrc5805OTS
 0aESHuOihX6BOAYpk5JY25S37Lh+afCgjebMdfLs/qR7y0/Yl8oSHs0V+Z1tmKcCwoM3th+lrDY
 TPzu6G22PnRv4NWn/i5HTOYxywgjfUWd3SfoFiPsZuVNz1KM3WBIE8k0/GCqPXSXhH10lK9RsiO
 6oONv4VfOnuN+GuURHFx+l8o=
X-Received: by 2002:a05:6a00:3907:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82f0c29fed7mr22327434b3a.25.1776261220516; 
 Wed, 15 Apr 2026 06:53:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3907:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82f0c29fed7mr22327400b3a.25.1776261219938; 
 Wed, 15 Apr 2026 06:53:39 -0700 (PDT)
Received: from fedora ([49.36.110.202]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f67478fd9sm2291576b3a.61.2026.04.15.06.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 06:53:38 -0700 (PDT)
Date: Wed, 15 Apr 2026 19:23:30 +0530
From: Arun Menon <armenon@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 1/2] migration/vmstate: Add VMState support for
 GByteArray
Message-ID: <ad-YWnIduI0lLp4f@fedora>
References: <20260409175126.5921-1-armenon@redhat.com>
 <20260409175126.5921-2-armenon@redhat.com>
 <ad6_pO1r8olukkzO@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad6_pO1r8olukkzO@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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

Hi Peter,

On Tue, Apr 14, 2026 at 06:28:52PM -0400, Peter Xu wrote:
> On Thu, Apr 09, 2026 at 11:21:24PM +0530, Arun Menon wrote:
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
> > index 62c2abd0c4..f503a40ec0 100644
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
> > +    .flags        = VMS_SINGLE,                                          \
> > +    .offset       = vmstate_offset_pointer(_state, _field, GByteArray),  \
> > +}
> > +
> >  /* _f : field name
> >     _f_n : num of elements field_name
> >     _n : num of elements
> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > index 89cb211472..743c2092e9 100644
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
> > +    GByteArray **byte_array = (GByteArray **)pv;
> > +    uint32_t len = qemu_get_be32(f);
> > +
> > +    if (*byte_array == NULL) {
> > +        *byte_array = g_byte_array_new();
> > +    }
> 
> Not an immediate problem when GByteArray* will always be pre-allocated
> (even if with len=0) in the vdagent use case, but just to mention..
> 
> This is kind of over-taking the VMS_ALLOC semantics, and it will be error
> prone too as vmstate core has special handling of NULL pointers, you can
> see e.g. vmstate_save_state_v() has this piece of code:
> 
>                 if (!curr_elem && size) {
>                     /*
>                      * If null pointer found (which should only happen in
>                      * an array of pointers), use null placeholder and do
>                      * not follow.
>                      */
>                     inner_field = vmsd_create_fake_nullptr_field(field);
>                     is_null = true;
>                 } else {
>                     inner_field = field;
>                     is_null = false;
>                 }
> 
> IIUC it'll start to generate nullptr markers if someone by accident removes
> the initialization of VDAgentChardev.outbuf someday, expecting it to work
> reading this code.
> 
> Maybe it's easier we stick with non-NULL for most of vmstates, assert that
> the GByteArray* pointer to be valid while get() it.  Same to put().
> 
> > +
> > +    g_byte_array_set_size(*byte_array, len);
> > +    if (len > 0) {
> > +        qemu_get_buffer(f, (*byte_array)->data, len);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
> > +                            const VMStateField *field, JSONWriter *vmdesc)
> > +{
> > +    GByteArray *byte_array = *(GByteArray **)pv;
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
> 
> The other thing to mention is, if it's only about one
> g_byte_array_set_size() call after getting LEN and before getting the byte
> array, we could also use tricks like pre_load(), e.g., instead of the
> current VMSD defined as this:
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
> We could change VMSTATE_VBUFFER_ALLOC_UINT32() to be a
> VMSTATE_STRUCT_POINTER, then within that the internal vmsd can provide a
> pre_load() hook doing g_byte_array_set_size(): since all fields will be
> loaded in order, when reaching there it's guaranteed LEN is loaded.
> 
> It'll avoid introducing get()/put() completely, IIUC.  But no strong
> feelings on either approach.

Thank you for the detailed explanation! I completely see the design flaw
now regarding the nullptr marker.

I am more inclined to make the one liner change of adding asserts,
because I am not sure where VMStateDescription of GByteArray should
live. Since it is an external GLib type, it does not have a dedicated
QEMU wrapper file in util/ directory. Placing it inside
migration/vmstate-types.c feels a bit out of place as that file is,
AFAICT, reserved for low-level VMStateInfo primitives.

I want to use the same GByteArray VMStateInfo to migrate TPM CRBState
struct in another change.

> 
> Thanks,
> 
> -- 
> Peter Xu
> 

Regards,
Arun Menon


