Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1E9F01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVVW-0000LK-S5; Fri, 06 Mar 2026 08:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vyVVU-0000Ki-Eb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:46:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vyVVS-0006qw-O9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:46:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 916933E7B4;
 Fri,  6 Mar 2026 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772804776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCGIMwX0POlyXSSo0cPbr34QQ/IDgZQl4nDpVnfGka0=;
 b=WFGt3oUYt9bGnksQfYyYhtmR/XCno9rKgcn53xKrjailNDKRgu+3vM0F2kTWA04oWa39w8
 oeojs5eatp02+CSP58aZ+8kM+lby7L326+px+rKeSs5DULfDCmpAYWLXnUqA2jrnhtqayT
 gs5+ojIrYofBCel+aa8RBy+0GNvFFy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772804776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCGIMwX0POlyXSSo0cPbr34QQ/IDgZQl4nDpVnfGka0=;
 b=jTac2mcqX7G2nqYQESJVN9YBefAgOsByV9DeCjjjKChBlnWf8znVA/JBXho6iJdMpZVYVf
 zDqS39iGjU0cN2Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772804776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCGIMwX0POlyXSSo0cPbr34QQ/IDgZQl4nDpVnfGka0=;
 b=WFGt3oUYt9bGnksQfYyYhtmR/XCno9rKgcn53xKrjailNDKRgu+3vM0F2kTWA04oWa39w8
 oeojs5eatp02+CSP58aZ+8kM+lby7L326+px+rKeSs5DULfDCmpAYWLXnUqA2jrnhtqayT
 gs5+ojIrYofBCel+aa8RBy+0GNvFFy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772804776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCGIMwX0POlyXSSo0cPbr34QQ/IDgZQl4nDpVnfGka0=;
 b=jTac2mcqX7G2nqYQESJVN9YBefAgOsByV9DeCjjjKChBlnWf8znVA/JBXho6iJdMpZVYVf
 zDqS39iGjU0cN2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18B9A3EA75;
 Fri,  6 Mar 2026 13:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MF+fM6faqmlzDwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Mar 2026 13:46:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, Peter Xu
 <peterx@redhat.com>, Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
In-Reply-To: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
Date: Fri, 06 Mar 2026 10:46:13 -0300
Message-ID: <87y0k5136i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Alexandr Moshkov <dtalexundeer@yandex-team.ru> writes:

> When loading a subset, its name is checked for the parent prefix. The
> following bug may occur here:
>
> Let's say there is a vmstate named "virtio-blk", it has a subsection
> named "virtio-blk/subsection", and it also has another vmstate named
> "virtio" in the fields.
> Then, during the migration, when trying to load this subsection for
> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> then the migration will break, because this vmstate does not have such a
> subsection.
>
> In other words, if a field inside vmstate1 is set via vmstate2 with a
> name that is a prefix of the parent vmstate, then the field can "steal"
> a subsection belonging to the parent state.
>
> Looks like it happens because migration stream for "virtio-blk" looks
> like this:
>
>  [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
>
> "virtio-blk" contains "virtio" field, so migration stream is:
>
>  [virtio-blk header] [virtio header] [virtio fields] [virtio
> subsections] [virtio-blk subsections]
>
> And when we load the subsections of the "virtio" device,
> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
> this is his subsection. This is where we encounter an error.
>
> Thus, the error occurs due to the fact that vmsd does not know how many
> subsections it has when loading (this does not appear anywhere in the
> migration stream), so it tries to load all the appropriate ones by
> names.
>
> Fix it by checking `/` at the end of idstr.
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  migration/vmstate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7b..187f3861f2 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -613,7 +613,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
>          char idstr[256], *idstr_ret;
> -        int ret;
> +        int ret, vmsd_name_len;
>          uint8_t version_id, len, size;
>          const VMStateDescription *sub_vmsd;
>  
> @@ -631,7 +631,10 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>          memcpy(idstr, idstr_ret, size);
>          idstr[size] = 0;
>  
> -        if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
> +        vmsd_name_len = strlen(vmsd->name);
> +        if (strncmp(vmsd->name, idstr, vmsd_name_len) != 0 ||
> +            /* to avoid taking parent subsection here */
> +            idstr[vmsd_name_len] != '/') {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
>              /* it doesn't have a valid subsection name */
>              return 0;

Hi, this breaks migration for s390x and ppc64:

qemu-system-s390x: Missing section footer for qemu-s390-flic

qemu-system-ppc64: Missing section footer for spapr_iommu

