Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69698D3A67C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 18:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5rIL-0006Up-Cs; Tue, 29 Oct 2024 14:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rIA-0006Tj-W2
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:50:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rI9-0000Fz-DQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:50:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04F5A21AC1;
 Tue, 29 Oct 2024 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730227808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUz94nPf7XKK2cg7GiJ52mXCtsNRiimrrMaGAMuHbc0=;
 b=SbUfShbOhUS/9fN1SjeuAkVLcddFT3YzjnaFKFdgR/xHHuC1yqODIWNZ4unqh30ky7zN2o
 /sGwGtPKD+A/sk05mkVpLhZmDZm/ik9vqKs6YxNHBeUg90Fru95m6Ier+ZSTTUAe84wkK3
 5vq3Cfz9C9XmxQqEYNWBPuqfwfCvlzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730227808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUz94nPf7XKK2cg7GiJ52mXCtsNRiimrrMaGAMuHbc0=;
 b=JZRIqQQvUPCFJkUDoFmgvNP09Z9nSIFCKqiO0/4MbWIu0f6MFTlktKfPODYnbP9htpGffm
 dfkTaXAPPTl1Z3DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SbUfShbO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JZRIqQQv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730227808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUz94nPf7XKK2cg7GiJ52mXCtsNRiimrrMaGAMuHbc0=;
 b=SbUfShbOhUS/9fN1SjeuAkVLcddFT3YzjnaFKFdgR/xHHuC1yqODIWNZ4unqh30ky7zN2o
 /sGwGtPKD+A/sk05mkVpLhZmDZm/ik9vqKs6YxNHBeUg90Fru95m6Ier+ZSTTUAe84wkK3
 5vq3Cfz9C9XmxQqEYNWBPuqfwfCvlzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730227808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUz94nPf7XKK2cg7GiJ52mXCtsNRiimrrMaGAMuHbc0=;
 b=JZRIqQQvUPCFJkUDoFmgvNP09Z9nSIFCKqiO0/4MbWIu0f6MFTlktKfPODYnbP9htpGffm
 dfkTaXAPPTl1Z3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DF16136A5;
 Tue, 29 Oct 2024 18:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sc3UEF8uIWfyTAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 29 Oct 2024 18:50:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 3/8] migration: Unexport ram_mig_init()
In-Reply-To: <20241024213056.1395400-4-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-4-peterx@redhat.com>
Date: Tue, 29 Oct 2024 15:49:33 -0300
Message-ID: <87zfmmbv7m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 04F5A21AC1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> It's only used within migration/.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h | 1 -
>  migration/ram.h          | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index df57be6b5e..e8490e3af5 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -39,7 +39,6 @@ void precopy_add_notifier(NotifierWithReturn *n);
>  void precopy_remove_notifier(NotifierWithReturn *n);
>  int precopy_notify(PrecopyNotifyReason reason, Error **errp);
>  
> -void ram_mig_init(void);
>  void qemu_guest_free_page_hint(void *addr, size_t len);
>  bool migrate_ram_is_ignored(RAMBlock *block);
>  
> diff --git a/migration/ram.h b/migration/ram.h
> index bc0318b834..0d1981f888 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -44,6 +44,7 @@ extern XBZRLECacheStats xbzrle_counters;
>      INTERNAL_RAMBLOCK_FOREACH(block)                   \
>          if (!qemu_ram_is_migratable(block)) {} else
>  
> +void ram_mig_init(void);
>  int xbzrle_cache_resize(uint64_t new_size, Error **errp);
>  uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_total(void);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

