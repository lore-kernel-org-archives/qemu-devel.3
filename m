Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ED610ED664
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66Ky-0001ck-Q2; Fri, 27 Mar 2026 08:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66Kv-0001ah-IK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:30:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66Kt-0005fA-Rg
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:30:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B73F54D385;
 Fri, 27 Mar 2026 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdrUFYWYXuRcvRm8fMYb4N77A0pJh4m+sxA73GjnAJA=;
 b=0rcynqY4slCz+wgjfx4mM5SF4irtyqn7NS5ABGpz0ElhuUyFJ8Pwam8E/G8FbAXStGG9Ze
 Q4yDVS3qbNPM0IXZz4XnrHZcuPmZZTxLUjkx0tgRHvrjS0ouX9Zgeq1R7k+OO9HzrR/B1G
 BFAUNR+aURIdL26z0Ep6+xlJElaNLFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdrUFYWYXuRcvRm8fMYb4N77A0pJh4m+sxA73GjnAJA=;
 b=yKyFuuNq06VJGljrel8xTgCYRBJt/UVuBCdTu4snhbwsGf5Qgc3V5G4x4LgSPvowhKKPVZ
 kLJZMhe/nazp9jCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdrUFYWYXuRcvRm8fMYb4N77A0pJh4m+sxA73GjnAJA=;
 b=0rcynqY4slCz+wgjfx4mM5SF4irtyqn7NS5ABGpz0ElhuUyFJ8Pwam8E/G8FbAXStGG9Ze
 Q4yDVS3qbNPM0IXZz4XnrHZcuPmZZTxLUjkx0tgRHvrjS0ouX9Zgeq1R7k+OO9HzrR/B1G
 BFAUNR+aURIdL26z0Ep6+xlJElaNLFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdrUFYWYXuRcvRm8fMYb4N77A0pJh4m+sxA73GjnAJA=;
 b=yKyFuuNq06VJGljrel8xTgCYRBJt/UVuBCdTu4snhbwsGf5Qgc3V5G4x4LgSPvowhKKPVZ
 kLJZMhe/nazp9jCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 150E14A0A2;
 Fri, 27 Mar 2026 12:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 07ANNHV4xmkuWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 12:30:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 08/11] vmstate: Implement load of ptr marker in
 vmstate core
In-Reply-To: <20260326210532.379027-9-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-9-peterx@redhat.com>
Date: Fri, 27 Mar 2026 09:30:40 -0300
Message-ID: <87ecl5ihe7.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> The loader side of ptr marker is pretty straightforward, instead of playing
> the inner_field trick, just do the load manually assuming the marker layout
> is a stable ABI (which it is true already).
>
> This will remove some logic while loading VMSD, and hopefully it makes it
> slightly easier to read.  Unfortunately, we still need to keep the sender
> side because of the JSON blob we're maintaining..
>
> This paves way for future processing of non-NULL markers as well.
>
> When at it, not check "size" anymore for existing NULL markers, and move it
> under the same VMS_ARRAY_OF_POINTER section because that's the only place
> that NULL marker can happen (which guarantess size==host ptr size, which is
> non-zero).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/vmstate-types.c | 12 ++++------
>  migration/vmstate.c       | 46 ++++++++++++++++++++++++---------------
>  2 files changed, 32 insertions(+), 26 deletions(-)
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
> index b333aa1744..47812eb882 100644
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
> +                bool ok = true;
>                  void *curr_elem = first_elem + size * i;
> -                const VMStateField *inner_field;
>  
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      curr_elem = *(void **)curr_elem;
> +                    if (!curr_elem) {
> +                        /* Read the marker instead of VMSD itself */
> +                        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
> +                            trace_vmstate_load_field_error(field->name,
> +                                                           -EINVAL);
> +                            return false;
> +                        }
> +                    }
>                  }
>  
> -                if (!curr_elem && size) {
> -                    /*
> -                     * If null pointer found (which should only happen in
> -                     * an array of pointers), use null placeholder and do
> -                     * not follow.
> -                     */
> -                    inner_field = vmsd_create_ptr_marker_field(field);
> -                } else {
> -                    inner_field = field;
> -                }
> -
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>

