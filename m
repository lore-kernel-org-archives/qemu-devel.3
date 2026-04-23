Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A16EF99340
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFoUb-0007De-Rs; Thu, 23 Apr 2026 03:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFoUZ-0007DC-5d
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFoUX-0006S2-2N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776929330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZyLQt71XhR2oyTI9rsJg1KTAjhdWpLuRcTwFkcCL80=;
 b=NvJsyTzpsMHjusKxT2Rg6bXzvD9J4wzDEtFOIkxB6RGX3/wAehs7hRaE0+1vh3aWF69DVC
 NUpvn1pmNZuo+Z9gjZFAW6dTXZmxg7mDc3zzQ3GpSUHhGv9lXJNM3a+4fqOcBNw5oCIPFA
 g/LYRux/kGc5SiSm+61VnGscJ49PjVI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646--pbbNJkvOgatni4LAm6tAw-1; Thu, 23 Apr 2026 03:28:47 -0400
X-MC-Unique: -pbbNJkvOgatni4LAm6tAw-1
X-Mimecast-MFC-AGG-ID: -pbbNJkvOgatni4LAm6tAw_1776929326
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so70967775ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 00:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776929326; x=1777534126; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GZyLQt71XhR2oyTI9rsJg1KTAjhdWpLuRcTwFkcCL80=;
 b=e7ihmsc4QAl5ZBOJkVZSmqHmryjC992TxatBoFCgkcxYtFAfV5OS/TsPyngBX4CAkT
 7rON2qyBhzobuHC+EhdEZ87yghmCkWcmcNVWS+HPuCRu1JBsad+Qix5ljY33K2qyQVZx
 jU5hc52N8WQhgJuufBby4WVhpMStctJEg0U6G/qflM40Bg1hZbuKhjSXk38k4B4nUbG2
 cLi2y4ct49JcpZIeOlPmlh+KsUzGyRDIFHPm+BHKxuumf9M9jRcAFtm6LrN5/kYmuuIj
 xrVerwdnS3Io8YSh2QVG8lLSBWpRZzHXJ5JJ5jKnyuL0JFb2cXpNrBYRY++Gtpv2FgCB
 rAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776929326; x=1777534126;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GZyLQt71XhR2oyTI9rsJg1KTAjhdWpLuRcTwFkcCL80=;
 b=VGx7YPm3JWsRLBPm3LZobOVn3fkAGt5QzaACdQN22CnydCVWuUXfvKNQZpAoC/zn0V
 kVTk6+ntdQRNBaNkqQ0t0PXjRe+ApQLRcvHS4vFAH7ilxrSNcf+DLTNXsebXyTQqQ2q3
 swbHRLToOc6yLQcJrqpYRwFgYDtMi/gj+NLtesJMHWe+d5kQwT5s13Qcg0hF9YE0XRPU
 t9llua4DttslujR8VnbdBye46zAwxYn4gz+l1nT+cX0MaKoredC9rWwHaTNUwInSdzl7
 RBYnbc+D31lfK5VEcuVchKWm+t6qk2AhHmRLD3gbWtu/31Fsmee/qEs6yRGdlhngRmKK
 aUQQ==
X-Gm-Message-State: AOJu0Yzb1VEEUzhGJMB2SVOQKvELCtcsn+B63uzEcHCKPszfgevxYFD9
 PIeal7Bi4pNftlW6lL9IUvqYXmWqq3hI6DWzjlxTKO8SqBZRuxmgeRVDAYFdF5gSAz3at9fKZC6
 2H5gl0V6ytcGOl2mFQmQk98ggfKvrPY7zQM9hXes2976VQQYhZiRT052Teh/U+j9m
X-Gm-Gg: AeBDievhjMwJqyozR3bodwvbFd1S8tvhkDBy9VWI9GPYUoa/9/7nDmOgmk2Ou0D3hrn
 PWEYmGnO9zyfsMZAbMUNwU+eDY+iIYu4y3/XUU6BmiGsWxO5htgweND4e6gjDxxsxWSpZ2DD3IF
 pRflKDHMquq/DV/T0+sAdTql+X0j+SnR9X7cT2XymhGCXns4QRRRvYDB72Z1KX7VOIIkH6e8u9L
 TuVOakQem9PVqmsYp8ZtrmxH4p/PK0WFS8o9k6gNHgFt3koVlGngVpOS0gaSgEk1tXDiQNiTA4Q
 rMtEYga6ZL/GwtNF5aJkurV6Ym1vWcYVYf0QZZZeE4ZihIxd18dh+HBVWfNVjOXwAOf0YwnL8LK
 ox+/OJufwIRGC06BziWTukHk=
X-Received: by 2002:a17:902:9002:b0:2b0:91e6:bc18 with SMTP id
 d9443c01a7336-2b5f9e7bb41mr150892915ad.14.1776929325712; 
 Thu, 23 Apr 2026 00:28:45 -0700 (PDT)
X-Received: by 2002:a17:902:9002:b0:2b0:91e6:bc18 with SMTP id
 d9443c01a7336-2b5f9e7bb41mr150892675ad.14.1776929325151; 
 Thu, 23 Apr 2026 00:28:45 -0700 (PDT)
Received: from fedora ([49.36.110.230]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa16e72sm185521865ad.19.2026.04.23.00.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 00:28:44 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:58:33 +0530
From: Arun Menon <armenon@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 1/2] migration/vmstate: Add VMState support for
 GByteArray
Message-ID: <aenKIbkSOjjGkg62@fedora>
References: <20260422082214.10390-1-armenon@redhat.com>
 <20260422082214.10390-2-armenon@redhat.com>
 <aekocd-UQ44uNCWI@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aekocd-UQ44uNCWI@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 22, 2026 at 03:58:41PM -0400, Peter Xu wrote:
> On Wed, Apr 22, 2026 at 01:52:13PM +0530, Arun Menon wrote:
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
> 
> I think the common one is Suggested-by for this tag.
> 
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Nitpicks only inline.
> 
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
> > index 89cb211472..e3a47e60b1 100644
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
> > +    assert(*byte_array != NULL);
> 
> We can make byte_array to be GByteArray* directly, it'll be the same as
> assertion when deref NULL.

Thanks for the feedback, Peter.
I will simplify the pointer handling in get_g_byte_array() and fix the
commit tag to Suggested-by.

Regarding the assert(), Would you like me to remove the
explicit assert() in put_g_byte_array() as well? Since it is immediately
followed by a dereference:

qemu_put_be32(f, byte_array->len);

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
> > +    uint32_t len;
> > +    assert(byte_array != NULL);
> > +
> > +    len = byte_array ? byte_array->len : 0;
> 
> This check is redundant.
> 
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
> -- 
> Peter Xu
> 

Regards,
Arun Menon


