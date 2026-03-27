Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298A310ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w681I-0005cD-SY; Fri, 27 Mar 2026 10:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w681H-0005aq-J9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:18:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w681E-0007L8-Gp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:18:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40C435BDE4;
 Fri, 27 Mar 2026 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774621111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW8Q1f5H65L9Y3YkVNaZSMgiEkVWyLyv1Vs2duoLapk=;
 b=dLCQUa2uqkQKv7O6HBVYBH8WFVFYdI9HIX6Untnpv7XIHq5Ov7zGxdvFGePfk8UuAHhNSi
 /kIWanXdLnQLNj1AIdPqr0iPYaFctKejucjkLWtF+gxxVya9CSHZ+zw0Pbc3ocsdNoZSxj
 tfF8AdXlJUDGR+QUy8w8U6oog+jdeE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774621111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW8Q1f5H65L9Y3YkVNaZSMgiEkVWyLyv1Vs2duoLapk=;
 b=I1dgM+XBjzwDWl4QHL22/p8qdl6eZxGrLk9czCoxRtFeNeVb2LpqNz4EMWVrl0TTL5pVqO
 eJDf1Zf1iicbf+Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dLCQUa2u;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I1dgM+XB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774621111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW8Q1f5H65L9Y3YkVNaZSMgiEkVWyLyv1Vs2duoLapk=;
 b=dLCQUa2uqkQKv7O6HBVYBH8WFVFYdI9HIX6Untnpv7XIHq5Ov7zGxdvFGePfk8UuAHhNSi
 /kIWanXdLnQLNj1AIdPqr0iPYaFctKejucjkLWtF+gxxVya9CSHZ+zw0Pbc3ocsdNoZSxj
 tfF8AdXlJUDGR+QUy8w8U6oog+jdeE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774621111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KW8Q1f5H65L9Y3YkVNaZSMgiEkVWyLyv1Vs2duoLapk=;
 b=I1dgM+XBjzwDWl4QHL22/p8qdl6eZxGrLk9czCoxRtFeNeVb2LpqNz4EMWVrl0TTL5pVqO
 eJDf1Zf1iicbf+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0E814A0B1;
 Fri, 27 Mar 2026 14:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rC6eJ7aRxmkHRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 14:18:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 09/11] vmstate: Implement
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
In-Reply-To: <acaQ5UkqbnwP4XgF@x1.local>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-10-peterx@redhat.com> <87bjg9ifha.fsf@suse.de>
 <acaQ5UkqbnwP4XgF@x1.local>
Date: Fri, 27 Mar 2026 11:18:28 -0300
Message-ID: <878qbdicej.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 40C435BDE4
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Mar 27, 2026 at 10:12:01AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Introduce a new flag, VMS_ARRAY_OF_POINTER_AUTO_ALLOC, for VMSD field.  It
>> > must be used together with VMS_ARRAY_OF_POINTER.
>> >
>> > It can be used to allow migration of an array of pointers where the
>> > pointers may point to NULLs.
>> >
>> > Note that we used to allow migration of a NULL pointer within an array that
>> > is being migrated. That corresponds to the code around vmstate_info_nullptr
>> > where we may get/put one byte showing that the element of an array is NULL.
>> >
>> > That usage is fine but very limited, it's because even if it will migrate a
>> > NULL pointer with a marker, it still works in a way that both src and dest
>> > QEMUs must know exactly which elements of the array are non-NULL, so
>> > instead of dynamically loading an array (which can have NULL pointers), it
>> > actually only verifies the known NULL pointers are still NULL pointers
>> > after migration.
>> >
>> > Also, in that case since dest QEMU knows exactly which element is NULL,
>> > which is not NULL, dest QEMU's device code will manage all allocations for
>> > the elements before invoking vmstate_load_vmsd().
>> >
>> > That's not enough per evolving needs of new device states that may want to
>> > provide real dynamic array of pointers, like what Alexander proposed here
>> > with the NVMe device migration:
>> >
>> > https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com
>> >
>> > This patch is an alternative approach to address the problem.
>> >
>> > Along with the flag, introduce two new macros:
>> >
>> >   VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8|32}_ALLOC()
>> >
>> > Which will be used very soon in the NVMe series.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  include/migration/vmstate.h |  51 +++++++++++++-
>> >  migration/savevm.c          |  27 ++++++-
>> >  migration/vmstate.c         | 136 ++++++++++++++++++++++++++++++------
>> >  3 files changed, 190 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> > index 2e51b5ea04..d844b46e63 100644
>> > --- a/include/migration/vmstate.h
>> > +++ b/include/migration/vmstate.h
>> > @@ -161,8 +161,21 @@ enum VMStateFlags {
>> >       * structure we are referencing to use. */
>> >      VMS_VSTRUCT           = 0x8000,
>> >  
>> > +    /*
>> > +     * This is a sub-flag for VMS_ARRAY_OF_POINTER.  When this flag is set,
>> > +     * VMS_ARRAY_OF_POINTER must also be set.  When set, it means array
>> > +     * elements can contain either valid or NULL pointers, vmstate core
>> > +     * will be responsible for synchronizing the pointer status, providing
>> > +     * proper memory allocations on the pointer when it is populated on the
>> > +     * source QEMU.  It also means the user of the field must make sure all
>> > +     * the elements in the array are NULL pointers before loading.  This
>> > +     * should also work with VMS_ALLOC when the array itself also needs to
>> > +     * be allocated.
>> > +     */
>> > +    VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
>> > +
>> >      /* Marker for end of list */
>> > -    VMS_END = 0x10000
>> > +    VMS_END                         = 0x20000,
>> >  };
>> >  
>> >  typedef enum {
>> > @@ -580,6 +593,42 @@ extern const VMStateInfo vmstate_info_qlist;
>> >      .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
>> >  }
>> >  
>> > +/*
>> > + * For migrating a dynamically allocated uint{8,32}-indexed array of
>> > + * pointers to structures (with NULL entries and with auto memory
>> > + * allocation).
>> > + *
>> > + * _type: type of structure pointed to
>> > + * _vmsd: VMSD for structure _type (when VMS_STRUCT is set)
>> > + * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
>> > + * start: size of (_type) pointed to (for auto memory allocation)
>> > + */
>> > +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(\
>> > +    _field, _state, _field_num, _version, _vmsd, _type) {            \
>> > +    .name       = (stringify(_field)),                               \
>> > +    .version_id = (_version),                                        \
>> > +    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
>> > +    .vmsd       = &(_vmsd),                                          \
>> > +    .size       = sizeof(_type),                                     \
>> > +    .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
>> > +                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                \
>> > +                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                   \
>> > +    .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
>> > +}
>> > +
>> > +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(\
>> > +    _field, _state, _field_num, _version, _vmsd, _type) {             \
>> > +    .name       = (stringify(_field)),                                \
>> > +    .version_id = (_version),                                         \
>> > +    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
>> > +    .vmsd       = &(_vmsd),                                           \
>> > +    .size       = sizeof(_type),                                      \
>> > +    .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
>> > +                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
>> > +                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
>> > +    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
>> > +}
>> > +
>> >  #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
>> >      .name       = (stringify(_field)),                                    \
>> >      .version_id = (_version),                                             \
>> > diff --git a/migration/savevm.c b/migration/savevm.c
>> > index f5a6fd0c66..765df8ce2d 100644
>> > --- a/migration/savevm.c
>> > +++ b/migration/savevm.c
>> > @@ -869,8 +869,33 @@ static void vmstate_check(const VMStateDescription *vmsd)
>> >      if (field) {
>> >          while (field->name) {
>> >              if (field->flags & VMS_ARRAY_OF_POINTER) {
>> > -                assert(field->size == 0);
>> > +                if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
>> > +                    /*
>> > +                     * Size must be provided because dest QEMU needs that
>> > +                     * info to know what to allocate
>> > +                     */
>> > +                    assert(field->size || field->size_offset);
>> > +                } else {
>> > +                    /*
>> > +                     * Otherwise size info isn't useful (because it's
>> > +                     * always the size of host pointer), detect accidental
>> > +                     * setup of sizes in this case.
>> > +                     */
>> > +                    assert(field->size == 0 && field->size_offset == 0);
>> > +                }
>> > +                /*
>> > +                 * VMS_ARRAY_OF_POINTER must be used only together with one
>> > +                 * of VMS_(V)ARRAY* flags.
>> > +                 */
>> > +                assert(field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
>> > +                                       VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8 |
>> > +                                       VMS_VARRAY_UINT32));
>> >              }
>> > +
>> > +            if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
>> > +                assert(field->flags & VMS_ARRAY_OF_POINTER);
>> > +            }
>> > +
>> >              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
>> >                  /* Recurse to sub structures */
>> >                  vmstate_check(field->vmsd);
>> > diff --git a/migration/vmstate.c b/migration/vmstate.c
>> > index 47812eb882..9cd0a88ce9 100644
>> > --- a/migration/vmstate.c
>> > +++ b/migration/vmstate.c
>> > @@ -153,6 +153,12 @@ static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
>> >          return true;
>> >      }
>> >  
>> > +    if (byte == VMS_MARKER_PTR_VALID) {
>> > +        /* We need to load the field right after the marker */
>> > +        *load_field = true;
>> > +        return true;
>> > +    }
>> > +
>> >      error_setg(errp, "Unexpected ptr marker: %d", byte);
>> 
>> just checking: is this error always the right thing to do? IOW, an array
>> of pointers member should never be NULL unless wrapped by PTR_NULL or
>> PTR_VALID.
>
> One thing to note is, we invoke vmstate_ptr_marker_load() only if we are
> 100% sure a marker is expected in the current stream we're loading.
>
> We used to only allow that to happen if there're NULL ptrs within
> VMS_ARRAY_OF_POINTER, now we extended that with _AUTO_ALLOC.
>
> So I think this error is always the right thing to do, because it means we
> expect a marker to present but when it's neither 0x30 nor 0x31 it means the
> marker is definitely missing.
>
>> 
>> >      return false;
>> >  }
>> > @@ -234,6 +240,67 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
>> >      return true;
>> >  }
>> >  
>> > +/*
>> > + * Try to prepare loading the next element, the object pointer to be put
>> > + * into @next_elem.  When @next_elem is NULL, it means we should skip
>> > + * loading this element.
>> > + *
>> > + * Returns false for errors, in which case *errp will be set, migration
>> > + * must be aborted.
>> > + */
>> > +static bool vmstate_load_next(QEMUFile *f, const VMStateField *field,
>> > +                              void *first_elem, void **next_elem,
>> > +                              int size, int i, Error **errp)
>> > +{
>> > +    bool auto_alloc = field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
>> > +    void *ptr = first_elem + size * i, **pptr;
>> > +    bool load_field;
>> > +
>> > +    if (!(field->flags & VMS_ARRAY_OF_POINTER)) {
>> > +        /* Simplest case, no pointer involved */
>> > +        *next_elem = ptr;
>> > +        return true;
>> > +    }
>> > +
>> > +    /*
>> > +     * We're loading an array of pointers, switch to use pptr to make it
>> > +     * easier to read later
>> > +     */
>> > +    pptr = (void **)ptr;
>> > +
>> > +    /*
>> > +     * Some special cases use pointer markers: (1) _AUTO_ALLOC implies a
>> > +     * ptr marker will always exist, or (2) the element on destination is
>> > +     * NULL, which expects the src to send a NULL-only marker.
>> > +     */
>> > +    if (auto_alloc || !*pptr) {
>> 
>> If auto_alloc && load_field, then !*pptr must be NULL. And if            [1]
>> !load_field, then *pptr must also be NULL. So this auto_alloc check is
>> not needed.
>
> Good point, I can simply this check and perhaps add a prior assertion
> instead:
>
>     /*
>      * If auto_alloc is on, making sure the user provided an array of NULL
>      * pointers to start with
>      */
>     assert(!auto_alloc || *pptr == NULL);
>
> I used to have similar assertion in the old version, but I lost that when
> addressing the rfcv1 comments.
>
>> 
>> > +        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
>> 
>> If !*pptr && !auto_alloc, we'll load the marker, which must be           [2]
>> VMS_MARKER_PTR_NULL, but the vmstate_ptr_marker_load function will also
>> happilly accept VMS_MARKER_PTR_VALID. I guess that's what the assert
>> down below is for.
>
> Yes.
>
>> 
>> > +            trace_vmstate_load_field_error(field->name, -EINVAL);
>> > +            return false;
>> > +        }
>> > +
>> > +        if (load_field) {
>> > +            /*
>> > +             * When reaching here, it means we received a non-NULL ptr
>> > +             * marker, so we need to populate the field before loading it.
>> > +             *
>> > +             * NOTE: do not use vmstate_size() here, because we need the
>> > +             * object size, not entry size of the array.
>> > +             */
>> > +            assert(auto_alloc);
>> > +            *pptr = g_malloc0(field->size);
>> > +        } else {
>> > +            /* Clear the pointer to imply a skip */
>> > +            *next_elem = NULL;
>> 
>> nit: if !*pptr then there's no need to set *next_elem to NULL.    [3]
>
> Indeed; maybe this will make the code slightly harder to follow who will
> read it the first time..  but it's no problem, I can add a comment while
> removing this branch.
>
>> 
>> > +            return true;
>> > +        }
>> > +    }
>> 
>> What about this version:
>> 
>> [1] if (!*pptr) {         
>
> This one I agree.
>
>>         int byte = qemu_get_byte(f);
>> 
>>         if (byte == VMS_MARKER_PTR_NULL) {
>>             /* When it's a null ptr marker, do not continue the load */
>> [3]         goto out;
>>         }
>> 
>> [2]     if (auto_alloc && byte == VMS_MARKER_PTR_VALID) {
>>             /*
>>              * When reaching here, it means we received a non-NULL ptr
>>              * marker, so we need to populate the field before loading it.
>>              *
>>              * NOTE: do not use vmstate_size() here, because we need the
>>              * object size, not entry size of the array.
>>              */
>>             *pptr = g_malloc0(field->size);
>>         } else {
>>             error_setg(errp, "Unexpected ptr marker: %d", byte);
>
> We'll need to attach the trace_*() to not lose capturing all errors in
> tracepoints.
>
>>             return false;
>>         }
>>     }
>
> Let's do apples-to-apples compare, removing comments.
>
> This is the current version after I address 1+3:
>
> if (!*pptr) {
>     if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
>         trace_vmstate_load_field_error(field->name, -EINVAL);
>         return false;
>     }
>     if (load_field) {
>         assert(auto_alloc);
>         *pptr = g_malloc0(field->size);
>     }
> }
>

Yep, could be.

