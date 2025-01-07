Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A97E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 23:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVIwt-0006lI-BB; Tue, 07 Jan 2025 18:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVIwr-0006jh-G3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 18:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVIwp-0004uo-JV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 18:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736292317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jk5llIMPGH13C1mE7NpYOAIHY5SKHrdVlTfqe5jJARw=;
 b=IYgQ/tXjN765+pn9MTyS/Px/XLf6nb9FwNvEXRkW4BU0w/somsbE5XnjQsD+EnR+7CzN5M
 KIrwznM0yMohzCcExCIz9d73kq8DYsyXcFlQB4D4pHZwV8Cn5uXAdVTycmeNI54t/pfXlw
 /pAksYWm+y45Jc89b9Lo0kPfpY5V+6Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-PIAB2FbUPzmiVqvQdDHogw-1; Tue, 07 Jan 2025 18:25:12 -0500
X-MC-Unique: PIAB2FbUPzmiVqvQdDHogw-1
X-Mimecast-MFC-AGG-ID: PIAB2FbUPzmiVqvQdDHogw
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467975eabdaso4823811cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 15:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736292312; x=1736897112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jk5llIMPGH13C1mE7NpYOAIHY5SKHrdVlTfqe5jJARw=;
 b=QECZOp6RnPShFY9X93yOzO4jgtKcA0M9lmssK590ho3w2YnydwrhWV2hFqyH4e2O/4
 y0cR2z1hfdji48WGYl6moeYRylO3fxALfTcXalmSdr98L3aw6KT+TKWT+egtDZTlEolU
 E9yQ5Rcyeg4GIsSktWYbWL/DHkZyTqd9isfQ1FUWnsl8SY0X1zUqwGK3QeGIWaMm/Ufb
 AZ/Vas1lxbfzeSLEVaK2hJcO3TzERmlo0DvFmGEvfyFCX6aL5KNPLgRlK+F7RpN8iY0m
 p7hH9MlghHks3WpViAh4xuIxg8XgUegpP1K+LH6VhDq0UtG6Ea7R76sCXf6rb+9rftZc
 BWJQ==
X-Gm-Message-State: AOJu0Yyg2B2nVbeWjqw0svF/F9nNcAGR6DF5a0hri4HJrVjJmMC8IAus
 tQsMgI3Y2+2pTIndL6ku8TfZHw1wkCN2c2JWRheR0PP8FqP/ejpRQErbucHlcXXyTyijmftjIik
 j70ruY0l3AM7PpWEWc/o96S3UMaZd7pj+maSPKh3UQYaNdDZ1PU9p
X-Gm-Gg: ASbGncsWnVCzH2vZ7idbYvRvpb0MUbx50AzgcTfuQ5YoSw3THFDKb2UoOJyFXHYtzTc
 5OQyRO1N3C0vNt6XhMOmRCbGv/nRxN2CAaepV+tLp2IVxfwuuk3FE2ZdgZvSXM74KJ5jeoSSqA6
 UnxiE5lvBahGH189SKALe1x4n2ZFIyoWydPTQzlrJg6WR2r+zkWGuTfo1X4GdToZH5hdp75AwnX
 CF8j/omOB7Tlb8+V71yidnuiB8yVZCGJQ95jCPgWI34Xm1NZvv0iznGrWkUP/jZi3Niwq6Wz6nd
 14IfyTC8Qm7Fl4WnIA==
X-Received: by 2002:ac8:7e84:0:b0:467:5cd2:4001 with SMTP id
 d75a77b69052e-46b3ac393aemr77115761cf.3.1736292312294; 
 Tue, 07 Jan 2025 15:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFc+kqqMjs2ci8NgrY1IitoI953bRWZjlzdmjAjeoOd+AvUvThVNJtXnM0q+BPKqJMj5BNsw==
X-Received: by 2002:ac8:7e84:0:b0:467:5cd2:4001 with SMTP id
 d75a77b69052e-46b3ac393aemr77115571cf.3.1736292311937; 
 Tue, 07 Jan 2025 15:25:11 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e677a55sm190102561cf.27.2025.01.07.15.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 15:25:10 -0800 (PST)
Date: Tue, 7 Jan 2025 18:25:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix arrays of pointers in JSON writer
Message-ID: <Z3231YxnKrjtwX6h@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107195025.9951-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jan 07, 2025 at 04:50:24PM -0300, Fabiano Rosas wrote:
> Currently, if an array of pointers contains a NULL pointer, that
> pointer will be encoded as '0' in the stream. Since the JSON writer
> doesn't define a "pointer" type, that '0' will now be an uint64, which
> is different from the original type being pointed to, e.g. struct.
> 
> That mixed-type array shouldn't be compressed, otherwise data is lost
> as the code currently makes the whole array have the type of the first
> element.
> 
> While we could disable the array compression when a NULL pointer is
> found, the JSON part of the stream still makes part of downtime, so we
> should avoid writing unecessary bytes to it.
> 
> Keep the array compression in place, but break the array into several
> type-contiguous pieces if NULL and non-NULL pointers are mixed.

Could I request for a sample JSON dump for an example array in the commit
log?  This whole solution looks working but is tricky.  A sample could help
people understand (e.g. showing the same "name" being dumped multiple
times..).

Side note: I tried to dump a very basic VM's JSON out to disk, it scares me
on the size:

$ ls -lhS JSON.out 
-rw-r--r--. 1 peterx peterx 106K Jan  7 17:18 JSON.out

That's a simplest VM with all default stuff, mostly nothing complex.. I may
really need to measure how the JSON debug strings affect migration function
or perf at some point..

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/vmstate.c          | 33 ++++++++++++++++++++++++++++++++-
>  scripts/analyze-migration.py |  9 ++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
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
>  
>                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
> -                                      i, n_elems);
> +                                      i, max_elems);
>  
>                  if (inner_field->flags & VMS_STRUCT) {
>                      ret = vmstate_save_state(f, inner_field->vmsd,
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 4836920ddc..9138e91a11 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -497,7 +497,14 @@ def read(self):
>                      raise Exception("internal index of data field unmatched (%d/%d)" % (len(a), int(field['index'])))
>                  a.append(field['data'])
>              else:
> -                self.data[field['name']] = field['data']
> +                # There could be multiple entries for the same field
> +                # name, e.g. when a compressed array was broken in
> +                # more than one piece.
> +                if (field['name'] in self.data and
> +                    type(self.data[field['name']]) == list):
> +                    self.data[field['name']].append(field['data'])
> +                else:
> +                    self.data[field['name']] = field['data']

Do we realy need these script changes?  I thought VMSDFieldStruct always
breaks array_len field into "index" based anyway?

        new_fields = []
        for field in self.desc['struct']['fields']:
            if not 'array_len' in field:
                new_fields.append(field)
                continue
            array_len = field.pop('array_len')
            field['index'] = 0
            new_fields.append(field)
            for i in range(1, array_len):
                c = field.copy()
                c['index'] = i
                new_fields.append(c)

        self.desc['struct']['fields'] = new_fields

-- 
Peter Xu


