Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BDA1091917
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 20:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KGY-0002p5-MR; Thu, 19 Mar 2026 16:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3KGQ-0002gs-JX
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:46:44 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3KGO-0002cH-Co
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:46:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5E944D411;
 Thu, 19 Mar 2026 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773953198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMQp7z1bMTsi0qI4JJEMFnm8FxBOOkkqszj1Ahhj4m4=;
 b=XHVZh3BaXvvO7xemJrdLhC6WxODpC7dtFd5sfGkDezncW/ikBOYMcHtfkbbaTFjX6BGWqf
 01zQDrTPkSw5Ov7/o7T2I86UX4n9ZfiCyZIUqwMi4h4RnLyuSSRblbDLQb7yWSBapGQ//k
 Il67rxHZVyA6OCyLGEL+Mccgfv6m1BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773953198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMQp7z1bMTsi0qI4JJEMFnm8FxBOOkkqszj1Ahhj4m4=;
 b=45rX3PqnkLiqc7MIeSSSoP6WIQw3rljZdx4OWpNpsD+d/qaxua4xwPqfvcQCuWye8Qeyqv
 PfYp0zl1kN/1XvBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773953198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMQp7z1bMTsi0qI4JJEMFnm8FxBOOkkqszj1Ahhj4m4=;
 b=XHVZh3BaXvvO7xemJrdLhC6WxODpC7dtFd5sfGkDezncW/ikBOYMcHtfkbbaTFjX6BGWqf
 01zQDrTPkSw5Ov7/o7T2I86UX4n9ZfiCyZIUqwMi4h4RnLyuSSRblbDLQb7yWSBapGQ//k
 Il67rxHZVyA6OCyLGEL+Mccgfv6m1BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773953198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMQp7z1bMTsi0qI4JJEMFnm8FxBOOkkqszj1Ahhj4m4=;
 b=45rX3PqnkLiqc7MIeSSSoP6WIQw3rljZdx4OWpNpsD+d/qaxua4xwPqfvcQCuWye8Qeyqv
 PfYp0zl1kN/1XvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 738894273B;
 Thu, 19 Mar 2026 20:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NPH1EK5gvGmKAQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Mar 2026 20:46:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Juraj Marcin
 <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH RFC 07/10] vmstate: Allow vmstate_info_nullptr to emit
 non-NULL markers
In-Reply-To: <20260317232332.15209-8-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-8-peterx@redhat.com>
Date: Thu, 19 Mar 2026 17:46:36 -0300
Message-ID: <87cy0z35ub.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
> No functional change intended yet.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/vmstate.h |  9 +++++++--
>  migration/vmstate-types.c   | 34 ++++++++++++++++------------------
>  migration/vmstate.c         | 29 ++++++++++++++---------------
>  3 files changed, 37 insertions(+), 35 deletions(-)
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
> index 5a6b352764..a3a5f25946 100644
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
> @@ -76,7 +76,7 @@ vmsd_create_fake_nullptr_field(const VMStateField *field)
>  
>      /* See vmstate_info_nullptr - use 1 byte to represent nullptr */

This comment needs updating.

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
> @@ -567,7 +567,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>              int i, n_elems = vmstate_n_elems(opaque, field);
>              int size = vmstate_size(opaque, field);
>              JSONWriter *vmdesc_loop = vmdesc;
> -            bool is_prev_null = false;
> +            bool use_marker_field_prev = false;

The logic below won't handle valid pointer as well, will it? We could
leave the is_null/is_prev_null terminology because it's way more
descriptive. Right? We're adding the marker here because we're
compressing and know the field is null.

>  
>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
>              if (field->flags & VMS_POINTER) {
> @@ -578,7 +578,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>              for (i = 0; i < n_elems; i++) {
>                  void *curr_elem = first_elem + size * i;
>                  const VMStateField *inner_field;
> -                bool is_null;
> +                bool use_marker_field;
>                  int max_elems = n_elems - i;
>  
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> @@ -586,17 +586,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                      curr_elem = *(void **)curr_elem;
>                  }
>  
> -                if (!curr_elem && size) {
> +                use_marker_field = !curr_elem && size;
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
> @@ -612,16 +611,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                   */
>                  if (vmdesc && vmsd_can_compress(field) &&
>                      (field->flags & VMS_ARRAY_OF_POINTER) &&
> -                    is_null != is_prev_null) {
> +                    use_marker_field != use_marker_field_prev) {
>  
> -                    is_prev_null = is_null;
> +                    use_marker_field_prev = use_marker_field;
>                      vmdesc_loop = vmdesc;
>  
>                      for (int j = i + 1; j < n_elems; j++) {
>                          void *elem = *(void **)(first_elem + size * j);
> -                        bool elem_is_null = !elem && size;
> +                        bool elem_use_marker_field = !elem && size;

See?

>  
> -                        if (is_null != elem_is_null) {
> +                        if (use_marker_field != elem_use_marker_field) {
>                              max_elems = j - i;
>                              break;
>                          }
> @@ -633,7 +632,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                                                      i, max_elems, errp);
>  
>                  /* If we used a fake temp field.. free it now */
> -                if (is_null) {
> +                if (use_marker_field) {
>                      g_clear_pointer((gpointer *)&inner_field, g_free);
>                  }

