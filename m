Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60123E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtc6-0007YO-Tp; Thu, 09 Jan 2025 09:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVtc5-0007YF-LO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVtc3-00069j-L2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736433256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kYG5T02+AgxUnE75lwHKl4YaBgSQaTeIwaxa0bO5k14=;
 b=iX3KE8dwXQLOI+NtguzqEcK2Z9d/3HOa+h6PHfPm+i6dyXefRp8U1LnUVRWeNFEqKQy5FQ
 91bfDnkuAsBO0WIN80QRHG/k006X1Bn1PkMSE7i/5QL51SGjFS5ie42UMpGqJoHO+30NBi
 09CkRt7o07J7fSlPWbHK7qE3W3/EQ5Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-E0M4pc5pPfS-8luNdqJ9Hg-1; Thu, 09 Jan 2025 09:34:15 -0500
X-MC-Unique: E0M4pc5pPfS-8luNdqJ9Hg-1
X-Mimecast-MFC-AGG-ID: E0M4pc5pPfS-8luNdqJ9Hg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46790c5b1a5so22691121cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736433255; x=1737038055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYG5T02+AgxUnE75lwHKl4YaBgSQaTeIwaxa0bO5k14=;
 b=jNOHaUM+OaKVpAgrj2hy81Vm6gHzryRMui/W1vHpoB0pbkexseTgyB1c1sdxEntSsa
 NERN6P2mqeeRioEuf9ACaA4wTWO5WEvRrf4mtKD5i1RLPFoJ5AXmylc9wdze1zwZ2EZt
 BkVqFiHO37HkhX/s/Zo+8SG9GAhG0pcw2CrvHb29lwVQqN8cfhSf8CJrbJoryKmgNxP+
 T8lgTC2MOoGUoCkGK5BGJTzsPHZTOdcyktKmJPbOArrY92rYGToZGXNAAbk1ZpuP4Wip
 auWqAa0t+t0eoyacQg5X2OtyKGREisKjAUN1QcQgUX+EGi7CJ6pZYQPQvqoBbJwtEf2Y
 LNgw==
X-Gm-Message-State: AOJu0YywN8RjzMfGzOzd0YHwFC3w7WFsmHrbJwLZgj/MwSDMbjQC26gT
 muWfHTt23ZihO5/cmiyacTlYbMsgElF5OwVXkQxDXUsBwsED/+9oKu1Itb6+FoP76ZK+H0rMo1m
 geRMiw39Z4ARL77WW1mMtM26it7/kCYeMh7JwENakRNpNt/ETUVU6
X-Gm-Gg: ASbGncs7ft6nCixbSQpn9Lz0sMOorphvuL3Nd9clo+iuj1jmi3B5JDBnDDIBahjHzjU
 2H2yPIPwI5MCdIxoneh68gAHvyZD7+Elj7874phYWe8UwzJIoYaSQmMvR1AVZD1RMdERrMIz5pg
 7CUKHaa0vZnBh+UJa0ZGI968YRpoxEI3G83lNvsR+IDBflsLuXvDE9wOYZp1Iof/enBZ5jfTTZq
 YgTD6IkYtUwSFKrxOjxFguJn6ufxId+c/LFnlIM65EY47/oVW92Bk8wZSooJqEcSnC2+957OxbB
 ZlPKyt8x94Q/ZFqZLw==
X-Received: by 2002:a05:622a:40b:b0:46c:7737:c4ef with SMTP id
 d75a77b69052e-46c7737ca9dmr70670281cf.22.1736433254826; 
 Thu, 09 Jan 2025 06:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEERh25K5f5kJofn6hws8ktVYY+Eh3wfPAUDsvSz6BYOfkgEQinokCjxpbfDMdrN3iBpbI7dQ==
X-Received: by 2002:a05:622a:40b:b0:46c:7737:c4ef with SMTP id
 d75a77b69052e-46c7737ca9dmr70669981cf.22.1736433254453; 
 Thu, 09 Jan 2025 06:34:14 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64cf7fsm206869431cf.5.2025.01.09.06.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 06:34:13 -0800 (PST)
Date: Thu, 9 Jan 2025 09:34:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 6/7] migration: Fix arrays of pointers in JSON writer
Message-ID: <Z3_eZId2Ylj3bCU2@x1n>
References: <20250109140959.19464-1-farosas@suse.de>
 <20250109140959.19464-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109140959.19464-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 09, 2025 at 11:09:58AM -0300, Fabiano Rosas wrote:
> Currently, if an array of pointers contains a NULL pointer, that
> pointer will be encoded as '0' in the stream. Since the JSON writer
> doesn't define a "pointer" type, that '0' will now be an uint8, which
> is different from the original type being pointed to, e.g. struct.
> 
> (we're further calling uint8 "nullptr", but that's irrelevant to the
> issue)
> 
> That mixed-type array shouldn't be compressed, otherwise data is lost
> as the code currently makes the whole array have the type of the first
> element:
> 
> css = {NULL, NULL, ..., 0x5555568a7940, NULL};
> 
> {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
>  "version": 1, "fields": [
>     ...,
>     {"name": "css", "array_len": 256, "type": "nullptr", "size": 1},
>     ...,
> ]}
> 
> In the above, the valid pointer at position 254 got lost among the
> compressed array of nullptr.
> 
> While we could disable the array compression when a NULL pointer is
> found, the JSON part of the stream still makes part of downtime, so we
> should avoid writing unecessary bytes to it.
> 
> Keep the array compression in place, but if NULL and non-NULL pointers
> are mixed break the array into several type-contiguous pieces :
> 
> css = {NULL, NULL, ..., 0x5555568a7940, NULL};
> 
> {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
>  "version": 1, "fields": [
>      ...,
>      {"name": "css", "array_len": 254, "type": "nullptr", "size": 1},
>      {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
>      {"name": "css", "type": "nullptr", "size": 1},
>      ...,
> ]}
> 
> Now each type-discontiguous region will become a new JSON entry. The
> reader should interpret this as a concatenation of values, all part of
> the same field.
> 
> Parsing the JSON with analyze-script.py now shows the proper data
> being pointed to at the places where the pointer is valid and
> "nullptr" where there's NULL:
> 
> "s390_css (14)": {
>     ...
>     "css": [
>         "nullptr",
>         "nullptr",
>         ...
>         "nullptr",
>         {
>             "chpids": [
>             {
>                 "in_use": "0x00",
>                 "type": "0x00",
>                 "is_virtual": "0x00"
>             },
>             ...
>             ]
>         },
>         "nullptr",
>     }
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/vmstate.c          | 33 ++++++++++++++++++++++++++++++++-
>  scripts/analyze-migration.py | 29 +++++++++++++++++++++--------
>  2 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 52704c822c..a79ccf3875 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -425,15 +425,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>              int size = vmstate_size(opaque, field);
>              uint64_t old_offset, written_bytes;
>              JSONWriter *vmdesc_loop = vmdesc;
> +            bool is_prev_null = false;
>  
>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
>              if (field->flags & VMS_POINTER) {
>                  first_elem = *(void **)first_elem;
>                  assert(first_elem || !n_elems || !size);
>              }
> +
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
>                  const VMStateField *inner_field;
> +                bool is_null;
> +                int max_elems = n_elems - i;
>  
>                  old_offset = qemu_file_transferred(f);
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> @@ -448,12 +452,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                       * not follow.
>                       */
>                      inner_field = vmsd_create_fake_nullptr_field(field);
> +                    is_null = true;
>                  } else {
>                      inner_field = field;
> +                    is_null = false;
> +                }
> +
> +                /*
> +                 * Due to the fake nullptr handling above, if there's mixed
> +                 * null/non-null data, it doesn't make sense to emit a
> +                 * compressed array representation spanning the entire array
> +                 * because the field types will be different (e.g. struct
> +                 * vs. uint64_t). Search ahead for the next null/non-null

s/uint64_t/nullptr/

> +                 * element and start a new compressed array if found.
> +                 */
> +                if (field->flags & VMS_ARRAY_OF_POINTER &&
> +                    is_null != is_prev_null) {
> +
> +                    is_prev_null = is_null;
> +                    vmdesc_loop = vmdesc;
> +
> +                    for (int j = i + 1; j < n_elems; j++) {
> +                        void *elem = *(void **)(first_elem + size * j);
> +                        bool elem_is_null = !elem && size;
> +
> +                        if (is_null != elem_is_null) {
> +                            max_elems = j - i;
> +                            break;
> +                        }
> +                    }
>                  }

This definitely adds some slight more difficulty on reading this
code.. Let's have this first.

If it's proved that the JSON is a measurable overhead, I think we may
consider turn that off by default even for precopy (postcopy never used
vmdesc), then maybe we can simplify this chunk (and probably the whole
compression idea, because when turned on it is for debugging).

>  
>                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
> -                                      i, n_elems);
> +                                      i, max_elems);
>  
>                  if (inner_field->flags & VMS_STRUCT) {
>                      ret = vmstate_save_state(f, inner_field->vmsd,
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 134c25f20a..7f0797308d 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -501,15 +501,28 @@ def read(self):
>              field['data'] = reader(field, self.file)
>              field['data'].read()
>  
> -            if 'index' in field:
> -                if field['name'] not in self.data:
> -                    self.data[field['name']] = []
> -                a = self.data[field['name']]
> -                if len(a) != int(field['index']):
> -                    raise Exception("internal index of data field unmatched (%d/%d)" % (len(a), int(field['index'])))
> -                a.append(field['data'])
> +            fname = field['name']
> +            fdata = field['data']
> +
> +            # The field could be:
> +            # i) a single data entry, e.g. uint64
> +            # ii) an array, indicated by it containing the 'index' key
> +            #
> +            # However, the overall data after parsing the whole
> +            # stream, could be a mix of arrays and single data fields,
> +            # all sharing the same field name due to how QEMU breaks
> +            # up arrays with NULL pointers into multiple compressed
> +            # array segments.
> +            if fname not in self.data:
> +                if 'index' in field:
> +                    self.data[fname] = []

This needs to be:

     self.data[fname] = [fdata]

?

Btw, since the new code will process it correctly with non-array below,
IIUC here we can make it simple:

  if 'index' in field:
      self.data[fname] = fdata

> +                else:
> +                    self.data[fname] = fdata
> +            elif type(self.data[fname]) == list:
> +                self.data[fname].append(fdata)
>              else:
> -                self.data[field['name']] = field['data']
> +                tmp = self.data[fname]
> +                self.data[fname] = [tmp, fdata]
>  
>          if 'subsections' in self.desc['struct']:
>              for subsection in self.desc['struct']['subsections']:
> -- 
> 2.35.3
> 

-- 
Peter Xu


