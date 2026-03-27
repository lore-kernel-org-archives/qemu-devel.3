Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05EB10ED66B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66K6-00018x-Jd; Fri, 27 Mar 2026 08:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66K0-00015m-Pu
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:29:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66Jy-0004Ab-9E
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:29:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E3054D338;
 Fri, 27 Mar 2026 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9F4iTqMgZJE3t+mslUjrVcALtnY1QcwMA7aigmQ6HdI=;
 b=LVCvatWJQMsvnbfg2cCSBsKsEKJtklw//IcJ6Ir25uqtPE4HXcHQG8DKp+o2VTZjm5swzw
 aSpVMD2JEgkq+tfEm+7FTwXgOiK3Q2YW4sDhcbo7x+dV0zr5hlTDK/0kmqrPZ2E4Z+RbvC
 9xMMKo7ShEoA4f/jVfmOEN/DE1GvUtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9F4iTqMgZJE3t+mslUjrVcALtnY1QcwMA7aigmQ6HdI=;
 b=yaYzGgWWjnIkQp1Fu6VHaDtcaJTgyJEGIB4eLoEdWnm8eFEjffU68UvmprZ6RHKTC5J2uD
 OHt823Bx63x5k+Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9F4iTqMgZJE3t+mslUjrVcALtnY1QcwMA7aigmQ6HdI=;
 b=LVCvatWJQMsvnbfg2cCSBsKsEKJtklw//IcJ6Ir25uqtPE4HXcHQG8DKp+o2VTZjm5swzw
 aSpVMD2JEgkq+tfEm+7FTwXgOiK3Q2YW4sDhcbo7x+dV0zr5hlTDK/0kmqrPZ2E4Z+RbvC
 9xMMKo7ShEoA4f/jVfmOEN/DE1GvUtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9F4iTqMgZJE3t+mslUjrVcALtnY1QcwMA7aigmQ6HdI=;
 b=yaYzGgWWjnIkQp1Fu6VHaDtcaJTgyJEGIB4eLoEdWnm8eFEjffU68UvmprZ6RHKTC5J2uD
 OHt823Bx63x5k+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 919F24A0A2;
 Fri, 27 Mar 2026 12:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J3ChODd4xmmzVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 12:29:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 07/11] vmstate: Allow vmstate_info_nullptr to
 emit non-NULL markers
In-Reply-To: <20260326210532.379027-8-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-8-peterx@redhat.com>
Date: Fri, 27 Mar 2026 09:29:36 -0300
Message-ID: <87h5q1ihfz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> We used to have one vmstate called "nullptr" which is only used to generate
> one-byte hint to say one pointer is NULL.
>
> Let's extend its use so that it will generate another byte to say the
> pointer is non-NULL.
>
> With that, the name of the info struct (or functions) do not apply anymore.
> Update correspondingly.
>
> Update analyze-migration.py to work with the new layout.
>
> No functional change intended yet.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/vmstate.h  |  9 +++++++--
>  migration/vmstate-types.c    | 34 ++++++++++++++++------------------
>  migration/vmstate.c          | 25 +++++++++++++------------
>  scripts/analyze-migration.py | 22 ++++++++++++----------
>  4 files changed, 48 insertions(+), 42 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 092e8f7e9a..2e51b5ea04 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -282,9 +282,14 @@ extern const VMStateInfo vmstate_info_uint32;
>  extern const VMStateInfo vmstate_info_uint64;
>  extern const VMStateInfo vmstate_info_fd;
>  
> -/** Put this in the stream when migrating a null pointer.*/
> +/*
> + * Put this in the stream when migrating a pointer to reflect either a NULL
> + * or valid pointer.
> + */
>  #define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
> -extern const VMStateInfo vmstate_info_nullptr;
> +#define VMS_MARKER_PTR_VALID         (0x31U)   /* '1' */
> +
> +extern const VMStateInfo vmstate_info_ptr_marker;
>  
>  extern const VMStateInfo vmstate_info_cpudouble;
>  
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 7622cf8f01..b31689fc3c 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -359,36 +359,34 @@ const VMStateInfo vmstate_info_fd = {
>      .save = save_fd,
>  };
>  
> -static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
> -                         const VMStateField *field, Error **errp)
> +static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, Error **errp)
>  
>  {
> -    if (qemu_get_byte(f) == VMS_MARKER_PTR_NULL) {
> +    int byte = qemu_get_byte(f);
> +
> +    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
> +        /* TODO: process PTR_VALID case */
>          return true;
>      }
>  
> -    error_setg(errp, "vmstate: load_nullptr expected VMS_NULLPTR_MARKER");
> +    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
>      return false;
>  }
>  
> -static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
> -                         const VMStateField *field, JSONWriter *vmdesc,
> -                         Error **errp)
> +static bool save_ptr_marker(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, JSONWriter *vmdesc,
> +                            Error **errp)
>  
>  {
> -    if (pv == NULL) {
> -        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
> -        return true;
> -    }
> -
> -    error_setg(errp, "vmstate: save_nullptr must be called with pv == NULL");
> -    return false;
> +    qemu_put_byte(f, pv ? VMS_MARKER_PTR_VALID : VMS_MARKER_PTR_NULL);
> +    return true;
>  }
>  
> -const VMStateInfo vmstate_info_nullptr = {
> -    .name = "nullptr",
> -    .load = load_nullptr,
> -    .save = save_nullptr,
> +const VMStateInfo vmstate_info_ptr_marker = {
> +    .name = "ptr-marker",
> +    .load = load_ptr_marker,
> +    .save = save_ptr_marker,
>  };
>  
>  /* 64 bit unsigned int. See that the received value is the same than the one
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index b274204e66..b333aa1744 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -55,12 +55,12 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
>  }
>  
>  /*
> - * Create a fake nullptr field when there's a NULL pointer detected in the
> + * Create a ptr marker field when there's a NULL pointer detected in the
>   * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
>   * can't dereference the NULL pointer.
>   */
>  static const VMStateField *
> -vmsd_create_fake_nullptr_field(const VMStateField *field)
> +vmsd_create_ptr_marker_field(const VMStateField *field)
>  {
>      VMStateField *fake = g_new0(VMStateField, 1);
>  
> @@ -71,12 +71,12 @@ vmsd_create_fake_nullptr_field(const VMStateField *field)
>      fake->name = field->name;
>      fake->version_id = field->version_id;
>  
> -    /* Do not need "field_exists" check as it always exists (which is null) */
> +    /* Do not need "field_exists" check as it always exists */
>      fake->field_exists = NULL;
>  
> -    /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
> +    /* See vmstate_info_ptr_marker - use 1 byte to represent ptr status */
>      fake->size = 1;
> -    fake->info = &vmstate_info_nullptr;
> +    fake->info = &vmstate_info_ptr_marker;
>      fake->flags = VMS_SINGLE;
>  
>      /* All the rest fields shouldn't matter.. */
> @@ -278,7 +278,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>                       * an array of pointers), use null placeholder and do
>                       * not follow.
>                       */
> -                    inner_field = vmsd_create_fake_nullptr_field(field);
> +                    inner_field = vmsd_create_ptr_marker_field(field);
>                  } else {
>                      inner_field = field;
>                  }
> @@ -583,26 +583,27 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
>                  const VMStateField *inner_field;
> -                bool is_null;
>                  /* maximum number of elements to compress in the JSON blob */
>                  int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
> +                bool use_marker_field, is_null;
>  
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      assert(curr_elem);
>                      curr_elem = *(void **)curr_elem;
>                  }
>  
> -                if (!curr_elem && size) {
> +                is_null = !curr_elem && size;
> +                use_marker_field = is_null;
> +
> +                if (use_marker_field) {
>                      /*
>                       * If null pointer found (which should only happen in
>                       * an array of pointers), use null placeholder and do
>                       * not follow.
>                       */
> -                    inner_field = vmsd_create_fake_nullptr_field(field);
> -                    is_null = true;
> +                    inner_field = vmsd_create_ptr_marker_field(field);
>                  } else {
>                      inner_field = field;
> -                    is_null = false;
>                  }
>  
>                  /*
> @@ -638,7 +639,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                                                      i, max_elems, errp);
>  
>                  /* If we used a fake temp field.. free it now */
> -                if (is_null) {
> +                if (use_marker_field) {
>                      g_clear_pointer((gpointer *)&inner_field, g_free);
>                  }
>  
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index e81deab8f9..1771ff781b 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -469,26 +469,26 @@ def __init__(self, desc, file):
>          super(VMSDFieldIntLE, self).__init__(desc, file)
>          self.dtype = '<i%d' % self.size
>  
> -class VMSDFieldNull(VMSDFieldGeneric):
> +class VMSDFieldPtrMarker(VMSDFieldGeneric):
>      NULL_PTR_MARKER = b'0'
> +    VALID_PTR_MARKER = b'1'
>  
>      def __init__(self, desc, file):
> -        super(VMSDFieldNull, self).__init__(desc, file)
> +        super(VMSDFieldPtrMarker, self).__init__(desc, file)
>  
>      def __repr__(self):
> -        # A NULL pointer is encoded in the stream as a '0' to
> -        # disambiguate from a mere 0x0 value and avoid consumers
> -        # trying to follow the NULL pointer. Displaying '0', 0x30 or
> -        # 0x0 when analyzing the JSON debug stream could become
> +        # A NULL / non-NULL pointer may be encoded in the stream as a
> +        # '0'/'1' to represent the status of the pointer.  Displaying '0',
> +        # 0x30 or 0x0 when analyzing the JSON debug stream could become
>          # confusing, so use an explicit term instead.
> -        return "nullptr"
> +        return "null-ptr" if self.data == self.NULL_PTR_MARKER else "valid-ptr"
>  
>      def __str__(self):
>          return self.__repr__()
>  
>      def read(self):
> -        super(VMSDFieldNull, self).read()
> -        assert(self.data == self.NULL_PTR_MARKER)
> +        super(VMSDFieldPtrMarker, self).read()
> +        assert(self.data in [self.NULL_PTR_MARKER, self.VALID_PTR_MARKER])
>          return self.data
>  
>  class VMSDFieldBool(VMSDFieldGeneric):
> @@ -642,7 +642,9 @@ def getDict(self):
>      "bitmap" : VMSDFieldGeneric,
>      "struct" : VMSDFieldStruct,
>      "capability": VMSDFieldCap,
> -    "nullptr": VMSDFieldNull,
> +    # Keep the old nullptr for old binaries
> +    "nullptr": VMSDFieldPtrMarker,
> +    "ptr-marker": VMSDFieldPtrMarker,
>      "unknown" : VMSDFieldGeneric,
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

