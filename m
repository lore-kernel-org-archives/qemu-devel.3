Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ED710A62DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5lY1-0000ey-Te; Thu, 26 Mar 2026 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5lXz-0000em-Gp
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5lXx-0005Dm-Ok
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774534732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4bk6t0SUecjr7baFP4UJcCSBeTGMo9yq6NxAlD5WMgE=;
 b=NxGo14US1Goh9Sb4dOUzyrnOpX4yditu0fcuRisnXd2pPG68gNPms3fpz4VyHBjwgpsgNP
 c/4yF171C/QsfNjyYLdI1/1qJOI2mk0RetP9Y2HdRSFv6AJGaBT+K6wUF9/JhNn+6NGSyb
 A1GYPRZngo8oC/CfzfJSxTHe9NZL3qo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-jEqqTRfnP3GAlMh--O1FsQ-1; Thu, 26 Mar 2026 10:18:50 -0400
X-MC-Unique: jEqqTRfnP3GAlMh--O1FsQ-1
X-Mimecast-MFC-AGG-ID: jEqqTRfnP3GAlMh--O1FsQ_1774534730
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c3e0be5ccso7093396d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774534730; x=1775139530; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4bk6t0SUecjr7baFP4UJcCSBeTGMo9yq6NxAlD5WMgE=;
 b=uOunKCThETYJ0S91d9rGPisDXpj1r5845HLKdmopEJ3rzJ520sa2YpztcR9s3GgUtM
 SDebR7f5eBF5brsxPnFML1nXWpgciUdjX6XGwTf7FtZ7Fpzch673jwFqMdC5j54BoYuc
 BvNP5jHDSLChgfz34Ba63kk67xsntY5rFSuw9oTa3Ef3HhdB64LdgU0owNSbdarVfx/U
 AhB361knNWCbvK1oUW2+5YFRvHvG+TjZpLDkXn+X5Roh6x5C+uxi/xSYAhUmSAMjKYoU
 0DX50ylQvlE+SijtEgI5blS6da8+40IktWAWguBQZhxHWAuwMpz9BE16Vmfrn0+W2WnE
 D76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774534730; x=1775139530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bk6t0SUecjr7baFP4UJcCSBeTGMo9yq6NxAlD5WMgE=;
 b=huX4gure6JAGE162mQkp3jet4blODb+DjxNG4lfYEZIFjbVEgqzsh8RTUyqVtCNbVB
 gY6oMYSFNv02DZRLWSL3yWp4GQ0T2rlXmnmWPQozf/WE/JaeVlBtvRYAhfPLSaFLiyH0
 TYlOglJfgzxhK/FcKlQM4KUdkE4BnULwWoy7620ad4mvqfzJeXQlXyQtbMqZsCiBpUXI
 FdTAQrf/X8C2+QbzT6ZiJpapUOioK3oqo1gtoR7pUcz88DBwlXUyQKdlFpAABQ2hho6B
 OA5C0u37KKI5doQ+SMNKGIaKNg1wecp/ksfNPVJbdN2PFNRdK1sUUxjKrvCUxHMhYSPb
 z3XQ==
X-Gm-Message-State: AOJu0Yyakx+eLwgDty33ToFxD7USE3HJ2XBNhV3w+rp7NyJwyFEpZZ0l
 QZoOcTj7EfXi8qcuX1jRk0ANKb5vux5KbDF9bf0huZKSseepqGuYpPAacIo3xbRKc5uIfRc2VnN
 M9GQHKn5B6DpcPsBDS5LfbdH5EWpOF6Jw5B0lfASPTYvdXwo7TI6BWAb/
X-Gm-Gg: ATEYQzx5W047gY4Tu7nj3xJLlVi0KVHs4KACzVOaPob/9aLf/rrikj0Zhcgh4IVJadu
 Zt4odZWlNDEmHO92mslwwT+Gk1coTVEmHW6VDrRVfS207ciWrCwEbiZPZ9MuPIzlptzBH2cYA5Y
 DWrOmn1RT+f1dyDPsACgFT5GKrKdUDUB8mHbwtY6aKGBd8cqT56MK8k7LTkRc0RTKk8PmWiaIU6
 u5eeXaNwzg8uds5GNP4NXlYH62nKoOZrckcK/FgMpNOcO0DYNnqGcr38AtfS9zI+7eb5UPsQLCw
 +/CHKdD35tmlI+jBLGtwfkdx44Aa7Cy6kZGL0bGidCbuqsf2HgWB5BxeFJWW1jLFvtgd7usFpQk
 cUAbWM/CzKpC2Bg==
X-Received: by 2002:a05:6214:2503:b0:899:f570:3167 with SMTP id
 6a1803df08f44-89cc4a9b8ffmr117094806d6.46.1774534729962; 
 Thu, 26 Mar 2026 07:18:49 -0700 (PDT)
X-Received: by 2002:a05:6214:2503:b0:899:f570:3167 with SMTP id
 6a1803df08f44-89cc4a9b8ffmr117094216d6.46.1774534729243; 
 Thu, 26 Mar 2026 07:18:49 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd5a22711sm29366716d6.27.2026.03.26.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 07:18:48 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:18:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 12/17] vmstate: Introduce vmstate_next
Message-ID: <acVARwOjj5gJlmhr@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324194333.30004-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Mar 24, 2026 at 04:43:27PM -0300, Fabiano Rosas wrote:
> Similarly to vmstate_first(), introduce a vmstate_next(), which does
> the necessary dereferencing of pointers to get to the leaf element. On
> the load side, allow the caller to pass a flag indicating whether
> allocation is expected and call the allocation function if so.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/vmstate.c | 84 +++++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 45 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index ab7c6fa4ab..c1ad0ef9a5 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -127,24 +127,51 @@ static void *vmstate_first(void *opaque, const VMStateField *field,
>      return first;
>  }
>  
> -static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
> -                                    Error **errp)
> +static void *vmstate_next(void **first, const VMStateField *field,
> +                          int size, int i, bool alloc)
>  {
> -    int byte = qemu_get_byte(f);
> +    void **array_elem;
> +    void *next;
> +
> +    if (!(field->flags & VMS_ARRAY_OF_POINTER)) {
> +        next = (void *)first + size * i;
> +        return next;
> +    }
> +
> +    array_elem = first + i;
> +    next = *array_elem;
> +
> +    if (alloc) {
> +        if (!next || field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +            /*
> +             * NOTE: do not use vmstate_size() here, because we
> +             * need the object size, not entry size of the
> +             * array.
> +             */
> +            next = vmstate_handle_alloc(array_elem, field->size, 1);
> +        }
> +    }
> +    return next;
> +}
> +
> +static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field)
> +{
> +    int byte = qemu_peek_byte(f, 0);

Here, peeking the marker for ...

>  
>      if (byte == VMS_MARKER_PTR_NULL) {
>          /* When it's a null ptr marker, do not continue the load */
>          *load_field = false;
> +        qemu_file_skip(f, 1);
>          return true;
>      }
>  
>      if (byte == VMS_MARKER_PTR_VALID) {
>          /* We need to load this field right after the marker */
>          *load_field = true;
> +        qemu_file_skip(f, 1);
>          return true;
>      }
>  
> -    error_setg(errp, "Unexpected ptr marker: %d", byte);
>      return false;
>  }
>  
> @@ -273,41 +300,13 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>                  void *curr_elem;
>  
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {

... every VMS_ARRAY_OF_POINTER case makes me feel uneasy.

Note that we only have two use cases that both of them are certain on the
upcoming byte to come:

(1) for the null-only pointer, which is before this series introduced, both
src/dst qemu knows 100% which ptr is NULL, so dest QEMU expects that 0x30
for each null pointer.

(2) for the new _AUTO_ALLOC introduced here, we also know exactly either
0x30 or 0x31 will come, and one of them must come before the real field
dump.

I think we may shoot us in the foot if we see 0x30 but in reality it's just
the 1st byte of some array field's binary stream.

> -                    void **array_elem = (void **)head + i;
> -                    bool use_dynamic_array =
> -                        field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
> -                    bool use_marker_field;
> -
> -                    curr_elem = *array_elem;
> -                    use_marker_field = use_dynamic_array || !curr_elem;
> -
> -                    if (use_marker_field) {
> -                        /* Read the marker instead of VMSD first */
> -                        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
> -                            trace_vmstate_load_field_error(field->name,
> -                                                           -EINVAL);
> -                            return false;
> -                        }
> -
> -                        if (load_field) {
> -                            /*
> -                             * When reaching here, it means we received a
> -                             * non-NULL ptr marker, so we need to populate the
> -                             * field before loading it.
> -                             *
> -                             * NOTE: do not use vmstate_size() here, because we
> -                             * need the object size, not entry size of the
> -                             * array.
> -                             */
> -                            assert(!curr_elem);
> -                            curr_elem = vmstate_handle_alloc(array_elem,
> -                                                             field->size, 1);
> -                        }
> -                    }
> -                } else {
> -                    curr_elem = head + size * i;
> +                    /* Peek a possible pointer marker instead of VMSD first */
> +                    ok = vmstate_ptr_marker_load(f, &load_field);
>                  }
>  
> +                curr_elem = vmstate_next(head, field, size, i,
> +                                         load_field && ok);
> +
>                  if (load_field) {
>                      ok = vmstate_load_field(f, curr_elem, size, field, errp);
>                  }
> @@ -647,15 +646,11 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>  
>              for (i = 0; i < n_elems; i++) {
>                  bool save_field = true;
> -                void *curr_elem;
> +                void *curr_elem = vmstate_next(head, field, size, i, false);
>                  int max_elems = n_elems - i;
>  
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      bool use_marker_field, is_null, use_dynamic_array;
> -                    void **array_elem = (void **)head + i;
> -
> -                    assert(array_elem);
> -                    curr_elem = *array_elem;
>  
>                      is_null = !curr_elem;
>  
> @@ -688,7 +683,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                              use_vmdesc = true;
>  
>                              for (int j = i + 1; j < n_elems; j++) {
> -                                void *elem = *(void **)(head + size * j);
> +                                void *elem = vmstate_next(head, field, size, j,
> +                                                          false);
>                                  bool elem_is_null = !elem;
>  
>                                  if (is_null != elem_is_null) {
> @@ -713,8 +709,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>  
>                          save_field = !!curr_elem;
>                      }
> -                } else {
> -                    curr_elem = head + size * i;
>                  }
>  
>                  if (save_field) {
> -- 
> 2.51.0
> 

-- 
Peter Xu


