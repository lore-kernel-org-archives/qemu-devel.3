Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E823CF9D0DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCmFk-00012e-OO; Tue, 14 Apr 2026 18:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCmFj-000129-31
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCmFg-0005bS-AX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776205738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zewDre8tVzBiQqxXIbPZP8lZjMKB2dFlmxkMOoQQwl4=;
 b=PNZ0rlTKl6PahoiKfn45gsfLcQ3s/FazT38DdjSyPB7hwYFYy2aHFMGxj36W0bFiuaLtss
 b7T3SYvKB6zA5dQ2n/fcL8K0TldIR8n4kbfyXv/uL1CDdqN+xZuGJWJn2yUye5B9DoLTKE
 Si2H6bBro9decTQNYeHYSnI9hVe18Mo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-R9iL85ttPym5r_g-D9P2Tw-1; Tue, 14 Apr 2026 18:28:56 -0400
X-MC-Unique: R9iL85ttPym5r_g-D9P2Tw-1
X-Mimecast-MFC-AGG-ID: R9iL85ttPym5r_g-D9P2Tw_1776205736
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d5107ec672so1670017185a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776205736; x=1776810536; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zewDre8tVzBiQqxXIbPZP8lZjMKB2dFlmxkMOoQQwl4=;
 b=jGwzQRIa44YOHAyo4HaufBCrh2NCkD49uOVYqHkCDGCD28a0fnxvOGDxXxdMjJAO+s
 AOjbqrv69L3Hgms2IZI1+qt9DpHxHmLHiPAHwz1XGDLRr5zspLaRdUinLHMA52xOq/HW
 DRYlVvkZvc2sz84p8oapYyJi7N8Dgn8RSFShSovLillbnQIOjx/JBPkEtvYLKsl4OaRQ
 H/sXCXhJlQQ3c0J6ZMXVlxA+r1ihQznE4Zq/ju6YYPOAlgEcxknPcymN9vQVpwz48VB2
 dC7pPrL5LmBpehslxaPtJIEK6rZtl3qlCZ9sGn5DzbSEoeQiNLTZh8ydh0/3S9vC92vd
 syHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776205736; x=1776810536;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zewDre8tVzBiQqxXIbPZP8lZjMKB2dFlmxkMOoQQwl4=;
 b=ECd0CDZ8kbgRQDCyO+G9Hj5wTwnklGDdHWAUCHWWoSCqYdUwLeRkui7h0BMCmztMwb
 lWzD33fFHiPoHU/3l41iPHmMS/5ZWsxa6gDVO/Z7y0yYG+DOG2RJprXuTSbYVlba7rEN
 aA1sNv/KVF27J/TCnqcJyq60tsyMmv/dnPpEpehkosKpqIRN7FBtarhYxrGecxkafqpr
 EgtSgm48kXoHfsKxHITFvr0eSjTNE88wAYKGgre4EtB1tZAJhf3OkDtg7mexrKp0DEO5
 DfHcRLFx+326XwUbr8wd1arFMwCT1TzGS/VK9U9yOg4YlWhyG7Du2vTux6jRHB/x4i1m
 rBxQ==
X-Gm-Message-State: AOJu0Yzuz47zyDZRWN08GqaLfW5ENRdcj1W1HOcvEzCb+lrDWmuMHtQH
 4z3gnOtmTfXVV9ltRzHfQwpdG9kw/v0/bgU1IqsHNmrALlckQj3r3ZzfzgezDmzIGju6o5i4WM+
 nF+ZcNMOHnAzVT8XmOK6cxzzi1WLPF0Njd9fh0xn5/kKYo64QrDQtm6W8
X-Gm-Gg: AeBDieukSvKbMaUo0uZc3gadEiQELajanpnNnJQt3AOouQMPTkSbEVRbIBeaSAbQ70U
 y1x9wMNR8LpyTmZP5kti98rHpYliwShwnrQF6drahIm9GtR5nI+3xA9xjgYaPkwIuWY5SzbEtnc
 aOjgAqOLk6DrayEC3U8baxOmVqdphmhepYkyxmNewuUbfQzkhq1M6mX1odIKlp81e8lt3EWAyJj
 F6UQKLPUrUJRNocCajylSe0ySQz6+og7TlduX2B9PoQ6e0VJS7Ez9P8qRatMWM1KkI0i6bKHgZe
 B1LldvUeF+G6ziMi5TVIcNewF90Z0XgO5skkQvNKrjBQno7BwQThfp7u1vSGnUOzvLEL4MQPPp2
 oHphGZc7FDgQTjjvCej7VquEIdGaBfQJZ3WWq3HqqGiateSTySJ/ztMQsyA==
X-Received: by 2002:a05:620a:f03:b0:8cd:c011:fcc3 with SMTP id
 af79cd13be357-8ddcd502f3fmr2800108285a.24.1776205735779; 
 Tue, 14 Apr 2026 15:28:55 -0700 (PDT)
X-Received: by 2002:a05:620a:f03:b0:8cd:c011:fcc3 with SMTP id
 af79cd13be357-8ddcd502f3fmr2800102285a.24.1776205735101; 
 Tue, 14 Apr 2026 15:28:55 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb6373926sm1244790185a.13.2026.04.14.15.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 15:28:54 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:28:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 1/2] migration/vmstate: Add VMState support for
 GByteArray
Message-ID: <ad6_pO1r8olukkzO@x1.local>
References: <20260409175126.5921-1-armenon@redhat.com>
 <20260409175126.5921-2-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409175126.5921-2-armenon@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Apr 09, 2026 at 11:21:24PM +0530, Arun Menon wrote:
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
> Signed-off-by: Arun Menon <armenon@redhat.com>
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
> index 89cb211472..743c2092e9 100644
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
> +    if (*byte_array == NULL) {
> +        *byte_array = g_byte_array_new();
> +    }

Not an immediate problem when GByteArray* will always be pre-allocated
(even if with len=0) in the vdagent use case, but just to mention..

This is kind of over-taking the VMS_ALLOC semantics, and it will be error
prone too as vmstate core has special handling of NULL pointers, you can
see e.g. vmstate_save_state_v() has this piece of code:

                if (!curr_elem && size) {
                    /*
                     * If null pointer found (which should only happen in
                     * an array of pointers), use null placeholder and do
                     * not follow.
                     */
                    inner_field = vmsd_create_fake_nullptr_field(field);
                    is_null = true;
                } else {
                    inner_field = field;
                    is_null = false;
                }

IIUC it'll start to generate nullptr markers if someone by accident removes
the initialization of VDAgentChardev.outbuf someday, expecting it to work
reading this code.

Maybe it's easier we stick with non-NULL for most of vmstates, assert that
the GByteArray* pointer to be valid while get() it.  Same to put().

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
> +    uint32_t len = byte_array ? byte_array->len : 0;
> +
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

The other thing to mention is, if it's only about one
g_byte_array_set_size() call after getting LEN and before getting the byte
array, we could also use tricks like pre_load(), e.g., instead of the
current VMSD defined as this:

static const VMStateDescription vmstate_vdba = {
    .name = "vdagent/bytearray",
    .version_id = 0,
    .minimum_version_id = 0,
    .fields = (const VMStateField[]) {
        VMSTATE_UINT32(len, GByteArray),
        VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
        VMSTATE_END_OF_LIST()
    }
};

We could change VMSTATE_VBUFFER_ALLOC_UINT32() to be a
VMSTATE_STRUCT_POINTER, then within that the internal vmsd can provide a
pre_load() hook doing g_byte_array_set_size(): since all fields will be
loaded in order, when reaching there it's guaranteed LEN is loaded.

It'll avoid introducing get()/put() completely, IIUC.  But no strong
feelings on either approach.

Thanks,

-- 
Peter Xu


