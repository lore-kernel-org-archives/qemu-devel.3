Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30882C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1km-0001Cw-PN; Thu, 08 May 2025 09:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uD1ki-0001BQ-7J
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:57:33 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uD1kf-00073Z-C5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:57:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C41C51F393;
 Thu,  8 May 2025 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746712643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIlC/dCkyfEPciaP6goXwgNI1ZiNZ4pD8KSyW6jOb6g=;
 b=MBgWiyo2tte4fSWhWSoTKSrsE2R0VTXSYTNc1rIhk9/qyFwsHYjadWPwGGoCypio7TIMBM
 OE1R872ulXmgnJZtneS06uNVpN80NckfcRBBrvQbYx8AICPoIzQEiRJdvcfeB14P0+AK2Z
 mdJUec36FVO6E33wyDx3M5FtC0kYOYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746712643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIlC/dCkyfEPciaP6goXwgNI1ZiNZ4pD8KSyW6jOb6g=;
 b=Yhr0Dl9hcZZn3a/VoWB5eRWZkK7mALikJ+4oWPX87qYhD/fJvBeiW1WMy9yXxlpY41EtMR
 +nwJv5YKtU6szxBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UwUMaGrQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KpVEXO1v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746712642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIlC/dCkyfEPciaP6goXwgNI1ZiNZ4pD8KSyW6jOb6g=;
 b=UwUMaGrQAytRY/0vhrymmyya/ITzOEFejhtJLpwrOXTDL4VWyjEZ/XCyx8KuNE87mR8Y2k
 /92h39PqQ69tT6NXVUwG7deX4iof/xw63DFnJB91uPtqUQvQQ4nYte5ehzQo/n5Ld+/9UH
 9GlXG7bTZXV8A7lXTL4PgOO9dpC3wtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746712642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIlC/dCkyfEPciaP6goXwgNI1ZiNZ4pD8KSyW6jOb6g=;
 b=KpVEXO1vO3AAbYcxH6R9xlNBfvP8obDHy6UV5Xk/kw/4Y4RPZIg5brAAPiGzVtWIJ7+fYQ
 Qm8crmCdr2eKpXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C7AF13712;
 Thu,  8 May 2025 13:57:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VjWlNkG4HGjlQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 May 2025 13:57:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v10 3/3] migration: write zero pages when postcopy enabled
In-Reply-To: <20250508122849.207213-4-ppandit@redhat.com>
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-4-ppandit@redhat.com>
Date: Thu, 08 May 2025 10:57:19 -0300
Message-ID: <87ecwzfbnk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C41C51F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns,
 fedoraproject.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> During multifd migration, zero pages are are written if
> they are migrated more than ones.

s/ones/once/

>
> This may result in a migration hang issue when Multifd
> and Postcopy are enabled together.
>
> When Postcopy is enabled, always write zero pages as and
> when they are migrated.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

This patch should come before 1/3, otherwise it'll break bisect.

> ---
>  migration/multifd-zero-page.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> v10: new patch, not present in v9 or earlier versions.
>
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index dbc1184921..9bfb3ef803 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -85,9 +85,27 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
>          void *page = p->host + p->zero[i];
> -        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> +
> +        /*
> +         * During multifd migration zero page is written to the memory
> +         * only if it is migrated more than ones.

s/ones/once/

> +         *
> +         * It becomes a problem when both Multifd & Postcopy options are
> +         * enabled. If the zero page which was skipped during multifd phase,
> +         * is accessed during the Postcopy phase of the migration, a page
> +         * fault occurs. But this page fault is not served because the
> +         * 'receivedmap' says the zero page is already received. Thus the
> +         * migration hangs.
> +         *
> +         * When Postcopy is enabled, always write the zero page as and when
> +         * it is migrated.
> +         *

extra blank line here^

> +         */

nit: Inconsistent use of capitalization for the feature names. I'd keep
it all lowercase.

> +        if (migrate_postcopy_ram() ||
> +            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              memset(page, 0, multifd_ram_page_size());
> -        } else {
> +        }
> +        if (!ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
>          }
>      }

