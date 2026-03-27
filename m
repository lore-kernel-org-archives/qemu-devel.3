Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1713410ED665
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66HQ-0007wh-MV; Fri, 27 Mar 2026 08:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66HP-0007wL-AP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:27:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66HN-0002lf-Ob
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:27:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0634E4D1D0;
 Fri, 27 Mar 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIEv9zA6DdhrUpXUMpSjeAfDgZlq+0aTDx6MRKsWu28=;
 b=zVmOL4g6tWerj4nXs7us+LTe0ejhV40CY4YYFWdPmzYfNSAswAjxYfYsr8hzsI4Z6S1O76
 OZHjMx9iPqvQaJmlx16oSawxgl21s2/uBueI4TycBrOVRTUjgVrvcygO/rAE8aa4JZVIbV
 GbUSwEbfyY4P+h1QIOwQjjvyvCxn/gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIEv9zA6DdhrUpXUMpSjeAfDgZlq+0aTDx6MRKsWu28=;
 b=Dp/okIWvrdU2yxWMUahwRFqirjxXPikrEJm5RY56Iv16MEv7+JzWETDX1K2bWbIaqKA/Q5
 /uueMRi8SQ7WpnDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIEv9zA6DdhrUpXUMpSjeAfDgZlq+0aTDx6MRKsWu28=;
 b=zVmOL4g6tWerj4nXs7us+LTe0ejhV40CY4YYFWdPmzYfNSAswAjxYfYsr8hzsI4Z6S1O76
 OZHjMx9iPqvQaJmlx16oSawxgl21s2/uBueI4TycBrOVRTUjgVrvcygO/rAE8aa4JZVIbV
 GbUSwEbfyY4P+h1QIOwQjjvyvCxn/gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIEv9zA6DdhrUpXUMpSjeAfDgZlq+0aTDx6MRKsWu28=;
 b=Dp/okIWvrdU2yxWMUahwRFqirjxXPikrEJm5RY56Iv16MEv7+JzWETDX1K2bWbIaqKA/Q5
 /uueMRi8SQ7WpnDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ACA34A0A2;
 Fri, 27 Mar 2026 12:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x2VUEpp3xmn6UwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 12:27:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH RFC v2 05/11] vmstate: Rename VMS_NULLPTR_MARKER to
 VMS_MARKER_PTR_NULL
In-Reply-To: <20260326210532.379027-6-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-6-peterx@redhat.com>
Date: Fri, 27 Mar 2026 09:27:04 -0300
Message-ID: <87mrztihk7.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 futurfusion.io:email, suse.de:mid, suse.de:email]
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

> Prepare for a new MARKER for non-NULL pointer.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
>  include/migration/vmstate.h | 2 +-
>  migration/vmstate-types.c   | 4 ++--
>  tests/unit/test-vmstate.c   | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index b4bc69486d..092e8f7e9a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -283,7 +283,7 @@ extern const VMStateInfo vmstate_info_uint64;
>  extern const VMStateInfo vmstate_info_fd;
>  
>  /** Put this in the stream when migrating a null pointer.*/
> -#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
> +#define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
>  extern const VMStateInfo vmstate_info_nullptr;
>  
>  extern const VMStateInfo vmstate_info_cpudouble;
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 23f3433696..7622cf8f01 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -363,7 +363,7 @@ static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
>                           const VMStateField *field, Error **errp)
>  
>  {
> -    if (qemu_get_byte(f) == VMS_NULLPTR_MARKER) {
> +    if (qemu_get_byte(f) == VMS_MARKER_PTR_NULL) {
>          return true;
>      }
>  
> @@ -377,7 +377,7 @@ static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
>  
>  {
>      if (pv == NULL) {
> -        qemu_put_byte(f, VMS_NULLPTR_MARKER);
> +        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
>          return true;
>      }
>  
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index 6a42cc1a4e..dae15786aa 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -620,7 +620,7 @@ static void test_arr_ptr_str_no0_load(void)
>  
>  static uint8_t wire_arr_ptr_0[] = {
>      0x00, 0x00, 0x00, 0x00,
> -    VMS_NULLPTR_MARKER,
> +    VMS_MARKER_PTR_NULL,
>      0x00, 0x00, 0x00, 0x02,
>      0x00, 0x00, 0x00, 0x03,
>      QEMU_VM_EOF

Reviewed-by: Fabiano Rosas <farosas@suse.de>

