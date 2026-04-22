Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEBCFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjY-0005ZT-Em; Wed, 22 Apr 2026 15:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFdit-0005Hz-SF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFdii-0000KC-AT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776887926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnaTkqpKyS9g99VTikLWudPUoSm21BjpVlGj2gsd3j0=;
 b=bVWFmkDmCvDY+P7UO/lp8MX+YO3KT8yPZw/IoBUGa5nZbFunuVP0HOhGqM/xMQw365qjHe
 2HGj7R5mcqzko6hUKP64BC7PKAZcnnRxeIIRVCoh4gn2Tm4RcH40gvDc1BVvICmofm4NXo
 HICkwTbWx/C8re9j75YBc307aUNlQIQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-C9mrLnSuO-iSk222FqTQ2Q-1; Wed, 22 Apr 2026 15:58:44 -0400
X-MC-Unique: C9mrLnSuO-iSk222FqTQ2Q-1
X-Mimecast-MFC-AGG-ID: C9mrLnSuO-iSk222FqTQ2Q_1776887924
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a5f6110cadso139325726d6.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776887924; x=1777492724; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mnaTkqpKyS9g99VTikLWudPUoSm21BjpVlGj2gsd3j0=;
 b=dkZ2/UbyYMOn45lGSAnACQRW+reX8gIBSGHAVYST/7xDpSxc/EoSTUfbm37EeOK4Gv
 xm0/9EL0SHfdjGennjjfM9Cz/8f98b+0HCUE4GcoHOUuJE96eVBtF+I+PDGwVZhvWUuB
 GWLkEpc+4ybwlZ0fMnM4epQsOtyLnWnqfa/DSflEb+6CGplTHinyeH044kospKMK3WIK
 d+NUBwxUWUyx5XTJM0hx8tpMg5DVfu6tth0d3mHtC31TcFY2gaoKRh5XQfCxlgRqD+tQ
 /CAfaeFTvJJ9jxrEkUU7SKB18bZqnYLhctPs1YLj7+re2jzj/VLsGQRkgg0PtjQZLhGt
 0hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887924; x=1777492724;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnaTkqpKyS9g99VTikLWudPUoSm21BjpVlGj2gsd3j0=;
 b=FOjMuyK2PpfkDq4AGGjMX3PX8owLFKA1KvCesYB6TOUZssPA42bO68NfsUZfToe/K7
 M0+FlZmYCGceRnvefCFTNqje/lBwqXGPRLQGeru+KkSNTv9YCFoH0fJXEuPDwUirH1HW
 5btHcabkgBbxJcaIkPkzNElm0jiT7kskWgYN22F1ZNqhlIec7t/KFmpDgiHyWKhr4egV
 RI88m0kQGYUVtyCcDvWe5Ey7VhE3FC2s7ItZHS4F/ONKmVIJoj2kF3VxTg8HF3s/9Uwp
 sXhTZmloV3ugod0/Cavw8yWrvAvYVpA1gDlpapUMRduC9Z66ZbJztxz9JnJ7NSBWiLkp
 snBA==
X-Gm-Message-State: AOJu0YyDdmiwgvxX5qdZy0G7AjT7FrLgP2TPtkZYTFSwTn15nZRcPB7m
 RfCQuYZ2JShXz482HGuu9AeCm00EjETo625IGnXVFTV11bK8JCkQqZNUbCxUjDb5GhC9lI5D2br
 ogoYgIB0tuq1syeHPDI5tRDTcbpGamaZwzKHmxKb2oI1fP/ZEsTabgElQ
X-Gm-Gg: AeBDiev4DOYZDrKvM3CXkoW45H+mYo01VrJ6o7jtoT33sFjYdou4lAKB6SUsadf0EsA
 +jxaZTL2Pn6IIQfqwoRrmO3TVZKnX+ENMtJgPLL5O5lVcLFkW0FgjpvUoECTGNCWZobzccTLaDC
 +6j0SuXzlE2TEXI4wQraIab69yVTkCAcqFy1B8N49bHimcLskUdyHTtXVEpyR5ZYi+uJpRxx+8P
 CNmIA+AC1s16Mj1Tvu++Q+uEk7RhCFVEgE/v2Tn8yz5TLYnad6hxZGm8xN6Bpbkzd9vCJFnAQDO
 kaNze2PJ3/YpwuLaWdJabky1yM4XPz7bG6qGnM+qwnbt4+9TeFSjeCxj4Uqho+AQwXGy2PvJvUr
 Mdq9q7jxhYvpdrPZFc6jX2fW7Iq+BKj/sXmzJbIdXW+GerwJvg1orSgNlgA==
X-Received: by 2002:a05:6214:cc8:b0:8ac:a3fe:b94f with SMTP id
 6a1803df08f44-8b02815633dmr370475836d6.44.1776887923913; 
 Wed, 22 Apr 2026 12:58:43 -0700 (PDT)
X-Received: by 2002:a05:6214:cc8:b0:8ac:a3fe:b94f with SMTP id
 6a1803df08f44-8b02815633dmr370475456d6.44.1776887923347; 
 Wed, 22 Apr 2026 12:58:43 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae6133dsm134676106d6.25.2026.04.22.12.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:58:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:58:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 1/2] migration/vmstate: Add VMState support for
 GByteArray
Message-ID: <aekocd-UQ44uNCWI@x1.local>
References: <20260422082214.10390-1-armenon@redhat.com>
 <20260422082214.10390-2-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422082214.10390-2-armenon@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Wed, Apr 22, 2026 at 01:52:13PM +0530, Arun Menon wrote:
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
> Fix-Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>

I think the common one is Suggested-by for this tag.

> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Nitpicks only inline.

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
>      .start        = offsetof(_type, _next),                              \
>  }
>  
> +#define VMSTATE_GBYTEARRAY(_field, _state, _version) {                   \
> +    .name         = (stringify(_field)),                                 \
> +    .version_id   = (_version),                                          \
> +    .size         = sizeof(GByteArray),                                  \
> +    .info         = &vmstate_info_g_byte_array,                          \
> +    .flags        = VMS_SINGLE,                                          \
> +    .offset       = vmstate_offset_pointer(_state, _field, GByteArray),  \
> +}
> +
>  /* _f : field name
>     _f_n : num of elements field_name
>     _n : num of elements
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 89cb211472..e3a47e60b1 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -942,3 +942,40 @@ const VMStateInfo vmstate_info_qlist = {
>      .get  = get_qlist,
>      .put  = put_qlist,
>  };
> +
> +static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field)
> +{
> +    GByteArray **byte_array = (GByteArray **)pv;
> +    uint32_t len = qemu_get_be32(f);
> +
> +    assert(*byte_array != NULL);

We can make byte_array to be GByteArray* directly, it'll be the same as
assertion when deref NULL.

> +
> +    g_byte_array_set_size(*byte_array, len);
> +    if (len > 0) {
> +        qemu_get_buffer(f, (*byte_array)->data, len);
> +    }
> +    return 0;
> +}
> +
> +static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    GByteArray *byte_array = *(GByteArray **)pv;
> +    uint32_t len;
> +    assert(byte_array != NULL);
> +
> +    len = byte_array ? byte_array->len : 0;

This check is redundant.

> +    qemu_put_be32(f, len);
> +    if (len > 0) {
> +        qemu_put_buffer(f, byte_array->data, len);
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateInfo vmstate_info_g_byte_array = {
> +    .name = "GByteArray",
> +    .get  = get_g_byte_array,
> +    .put  = put_g_byte_array,
> +};
> -- 
> 2.53.0
> 

-- 
Peter Xu


