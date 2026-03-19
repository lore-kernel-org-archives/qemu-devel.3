Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BF81091918
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 20:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3K6k-0008HU-HD; Thu, 19 Mar 2026 16:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3K6j-0008HM-5f
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:36:41 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3K6h-0006OH-IW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:36:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0258A4D411;
 Thu, 19 Mar 2026 20:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773952596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLtrmJNh80pqhSkW0eZXP0Z7R9LEbUjcO/2DyntVUzQ=;
 b=zjmrBvXFlEGM1SVr+HBejubZ1Mj/AYrWndIqXCcuUzfVfyzdi7hCMBPdF+81PMT0Sil+3y
 vJWFaK/h2Z+mb9bBprTQ9rjCJehdTOZ4Y3OaKBgY6F+G1rVrcc5XiM9wrInM4tSTRzfmxy
 vbvKT28tasAegP/0pa+lsKrHCEHOXGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773952596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLtrmJNh80pqhSkW0eZXP0Z7R9LEbUjcO/2DyntVUzQ=;
 b=kU7zaCPjRTI8W+htTndnJvI9+zje2XXCYdJZ+ywV/Oi4OVykb+dwucPj+72pfdJqWItkcd
 w+w90a1Mpn54W0AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773952596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLtrmJNh80pqhSkW0eZXP0Z7R9LEbUjcO/2DyntVUzQ=;
 b=zjmrBvXFlEGM1SVr+HBejubZ1Mj/AYrWndIqXCcuUzfVfyzdi7hCMBPdF+81PMT0Sil+3y
 vJWFaK/h2Z+mb9bBprTQ9rjCJehdTOZ4Y3OaKBgY6F+G1rVrcc5XiM9wrInM4tSTRzfmxy
 vbvKT28tasAegP/0pa+lsKrHCEHOXGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773952596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLtrmJNh80pqhSkW0eZXP0Z7R9LEbUjcO/2DyntVUzQ=;
 b=kU7zaCPjRTI8W+htTndnJvI9+zje2XXCYdJZ+ywV/Oi4OVykb+dwucPj+72pfdJqWItkcd
 w+w90a1Mpn54W0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B6C04273B;
 Thu, 19 Mar 2026 20:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YZ2yFlNevGkjdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Mar 2026 20:36:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Juraj Marcin
 <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH RFC 06/10] vmstate: Introduce
 vmstate_save_field_with_vmdesc()
In-Reply-To: <20260317232332.15209-7-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-7-peterx@redhat.com>
Date: Thu, 19 Mar 2026 17:36:33 -0300
Message-ID: <87fr5v36b2.fsf@suse.de>
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

> Introduce a helper to do both the JSON blob dump and vmstate dump.  This
> further shrinks the function a bit.  More importantly, we'll need to dump
> two fields in one loop very soon in the future with the JSON blob.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/vmstate.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index caa7b50bce..5a6b352764 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -514,6 +514,30 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
>      return true;
>  }
>  
> +/*
> + * Dump a whole VMSD field, including its JSON blob separately when @vmdesc

Could do without the "dump" terminology all over the series. There's
already use for that term due to -dump-vmstate.

> + * is specified.
> + */
> +static inline bool
> +vmstate_save_field_with_vmdesc(QEMUFile *f, void *pv, size_t size,
> +                               const VMStateDescription *vmsd,
> +                               const VMStateField *field, JSONWriter *vmdesc,
> +                               int i, int max, Error **errp)
> +{
> +    uint64_t old_offset, written_bytes;
> +    bool ok;
> +
> +    vmsd_desc_field_start(vmsd, vmdesc, field, i, max);
> +
> +    old_offset = qemu_file_transferred(f);
> +    ok = vmstate_save_field(f, pv, size, field, vmdesc, errp);
> +    written_bytes = qemu_file_transferred(f) - old_offset;
> +
> +    vmsd_desc_field_end(vmsd, vmdesc, field, written_bytes);
> +
> +    return ok;
> +}
> +
>  static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                                  void *opaque, JSONWriter *vmdesc,
>                                  int version_id, Error **errp)
> @@ -542,7 +566,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>              void *first_elem = opaque + field->offset;
>              int i, n_elems = vmstate_n_elems(opaque, field);
>              int size = vmstate_size(opaque, field);
> -            uint64_t old_offset, written_bytes;
>              JSONWriter *vmdesc_loop = vmdesc;
>              bool is_prev_null = false;
>  
> @@ -558,7 +581,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  bool is_null;
>                  int max_elems = n_elems - i;
>  
> -                old_offset = qemu_file_transferred(f);
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      assert(curr_elem);
>                      curr_elem = *(void **)curr_elem;
> @@ -606,15 +628,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                      }
>                  }
>  
> -                vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
> -                                      i, max_elems);
> -
> -                ok = vmstate_save_field(f, curr_elem, size, inner_field,
> -                                        vmdesc_loop, errp);
> -
> -                written_bytes = qemu_file_transferred(f) - old_offset;
> -                vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
> -                                    written_bytes);
> +                ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
> +                                                    inner_field, vmdesc_loop,
> +                                                    i, max_elems, errp);
>  
>                  /* If we used a fake temp field.. free it now */
>                  if (is_null) {

