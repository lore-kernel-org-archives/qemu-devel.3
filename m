Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D771091916
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 20:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KQS-0005KN-29; Thu, 19 Mar 2026 16:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3KQP-0005K7-BE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:57:01 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3KQM-0005dc-1m
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:56:59 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 579065BDB7;
 Thu, 19 Mar 2026 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773953815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4NQwcxtl5rgftfwgga7SocuNVQEOa3aLXcXqqA/To4=;
 b=Bu4F+QgXK9jP+Kb31Eg9DHXzTLAOKYIAcxxc7wNif/JWAp085nRQGx+ubvOncf5vhuUeXL
 Hhe7yM+bXjN/44VvxRB+9KqQsxNTaZmf/dsdWhi+BDDj5Zg4VbDEiT2owaQfCBqK9iKYnM
 V7EVsWvO8ZL8rjwdXfufVtDMlW1H24w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773953815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4NQwcxtl5rgftfwgga7SocuNVQEOa3aLXcXqqA/To4=;
 b=Sbc3W5HsoM3UB5NILKjyrsWJkyVG4k7XC9CA6mruXYl3tgSgLqcwuTTJV/CqGgtYRSItxB
 O2zIKdv1FfJtS8BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773953815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4NQwcxtl5rgftfwgga7SocuNVQEOa3aLXcXqqA/To4=;
 b=Bu4F+QgXK9jP+Kb31Eg9DHXzTLAOKYIAcxxc7wNif/JWAp085nRQGx+ubvOncf5vhuUeXL
 Hhe7yM+bXjN/44VvxRB+9KqQsxNTaZmf/dsdWhi+BDDj5Zg4VbDEiT2owaQfCBqK9iKYnM
 V7EVsWvO8ZL8rjwdXfufVtDMlW1H24w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773953815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4NQwcxtl5rgftfwgga7SocuNVQEOa3aLXcXqqA/To4=;
 b=Sbc3W5HsoM3UB5NILKjyrsWJkyVG4k7XC9CA6mruXYl3tgSgLqcwuTTJV/CqGgtYRSItxB
 O2zIKdv1FfJtS8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E70554273B;
 Thu, 19 Mar 2026 20:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NJkNLRZjvGkGDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Mar 2026 20:56:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Juraj Marcin
 <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH RFC 08/10] vmstate: Implement load of ptr marker in
 vmstate core
In-Reply-To: <20260317232332.15209-9-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-9-peterx@redhat.com>
Date: Thu, 19 Mar 2026 17:56:52 -0300
Message-ID: <87a4w335d7.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> The loader side of ptr marker is pretty straightforward, instead of playing
> the inner_field trick, just do the load manually assuming the marker layout
> is a stable ABI (which it is true already).
>
> This will remove some logic while loading VMSD, and hopefully it makes it
> slightly easier to read.  Unfortunately, we still need to keep the sender
> side because of the JSON blob we're maintaining..
>

/ramble
Is the JSON blob ABI? Can we kill it? AFAIR, it only serves to add
complexity and to break analyze-script from time to time. We'd be better
off parsing the actual stream from a file. Could maybe even use the same
loadvm code, but mock the .get functions to print instead of actually
loading.

Having separate code that parses a "thing" that's not the stream, but
that should reflect the stream, but it's not the stream, but pretty
close it's a bit weird to me. I recently had to simply open the raw
stream on emacs and navigate through it because the file: stream was
somehow different from the stream on the qcow2, for the same command
line.

(that's another point, parsing from the qcow2 would be cool, which the
JSON blob doesn't provide today I think)
ramble/

> This paves way for future processing of non-NULL markers as well.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/vmstate-types.c | 12 ++++--------
>  migration/vmstate.c       | 40 ++++++++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index b31689fc3c..ae465c5c2c 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
>                              const VMStateField *field, Error **errp)
>  
>  {
> -    int byte = qemu_get_byte(f);
> -
> -    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
> -        /* TODO: process PTR_VALID case */
> -        return true;
> -    }
> -
> -    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
> +    /*
> +     * Load is done in vmstate core, see vmstate_ptr_marker_load().
> +     */
> +    g_assert_not_reached();
>      return false;
>  }
>  
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index a3a5f25946..d65fc84dfa 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
>      }
>  }
>  
> +static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
> +                                    Error **errp)
> +{
> +    int byte = qemu_get_byte(f);
> +
> +    if (byte == VMS_MARKER_PTR_NULL) {
> +        /* When it's a null ptr marker, do not continue the load */
> +        *load_field = false;
> +        return true;
> +    }
> +
> +    error_setg(errp, "Unexpected ptr marker: %d", byte);
> +    return false;
> +}
> +
>  static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
>                               Error **errp)
>  {
> @@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>              }
>  
>              for (i = 0; i < n_elems; i++) {
> -                bool ok;
> +                /* If we will process the load of field? */
> +                bool load_field = true;

maybe valid_ptr would be more clear?

> +                bool ok = true;
>                  void *curr_elem = first_elem + size * i;
> -                const VMStateField *inner_field;
>  
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      curr_elem = *(void **)curr_elem;
>                  }
>  
>                  if (!curr_elem && size) {
> -                    /*
> -                     * If null pointer found (which should only happen in
> -                     * an array of pointers), use null placeholder and do
> -                     * not follow.
> -                     */
> -                    inner_field = vmsd_create_ptr_marker_field(field);
> -                } else {
> -                    inner_field = field;
> +                    /* Read the marker instead of VMSD itself */
> +                    if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
> +                        trace_vmstate_load_field_error(field->name, -EINVAL);
> +                        return false;
> +                    }
>                  }
>  
> -                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
> -
> -                /* If we used a fake temp field.. free it now */
> -                if (inner_field != field) {
> -                    g_clear_pointer((gpointer *)&inner_field, g_free);
> +                if (load_field) {
> +                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
>                  }
>  
>                  if (ok) {

