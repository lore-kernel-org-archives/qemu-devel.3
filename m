Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3766CCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCl4-0002RK-4U; Mon, 28 Sep 2026 10:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xBCl2-0002Qj-89
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:55:08 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xBCl0-0008TP-79
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:55:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 376F71FB7A;
 Mon, 28 Sep 2026 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790607300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PN781POSRp1Q4sBKLdzpL8fvGK/mZ+KZnIJZiS9ob8M=;
 b=iNRWxgV2eqvCNH1bclc9u5pKTBntbP1+Jf5f5mexJSh/fjhwuqlk34z86wbBOcr1G016vp
 Swk7eyyOq8R9rx/Uv42aErZX+erJMAdje4UiygyBdX1YE24ZeyiOunYLSS/sq6a9CUFJjR
 r8VqZndn+4YlD2WNGflmrO/sKZ0x6PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790607300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PN781POSRp1Q4sBKLdzpL8fvGK/mZ+KZnIJZiS9ob8M=;
 b=qiDnUEnmQgGcsAG6CeFyCLNZxU6Ymj7OXKFk0rleim0XQyqU9T/KCBO0f2q9Di/SrqlXx4
 1KcllJfivfZ8UUBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790607296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PN781POSRp1Q4sBKLdzpL8fvGK/mZ+KZnIJZiS9ob8M=;
 b=vTe7zJ94lzwQoLt7kfLjxdb1dqLTdCKfRf8weNnCvVdLhcF4j9rLspOJIuBQK1VenYBtGi
 Wm25S4MY8fPPoTWKVOU3Qzg0uSBWKnIKgEz8k0oT5XHJfVS08TCUcazBbh03HHCVagZ0mv
 xeeM1sNgm45w4s47DiYvblP+VEh8bcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790607296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PN781POSRp1Q4sBKLdzpL8fvGK/mZ+KZnIJZiS9ob8M=;
 b=CsYJps0Alj3OF3lhXdgcS8xRUs5juZ4kdXBnMG/g0u5Xpj9f9oSKbQnibjYv5qU21bZ9rv
 aOOdb0HAjgtJhjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A40B0133F1;
 Mon, 28 Sep 2026 14:54:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tTUBEr9/umrQGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 28 Sep 2026 14:54:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, andrey.drobyshev@virtuozzo.com,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, peterx@redhat.com, den@openvz.org, sgarzare@redhat.com,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v7 03/16] migration: forbid snapshots in CPR migration
 modes
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-3-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-3-6ef9ef033c35@virtuozzo.com>
Date: Mon, 28 Sep 2026 11:54:45 -0300
Message-ID: <87fqyt8lze.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 virtuozzo.com:email, suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> writes:

> The savevm/loadvm operation doesn't make any sense in any of the CPR
> modes.  Saving VM state implies saving its RAM entirely, while the whole
> point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
> preserved in place and never put into the migration stream (see
> migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
> taken with such a mode set has no RAM in it, and loading a snapshot with
> such a mode set fails in the RAM loader.
>
> Currently nothing stops these operations from firing with a CPR mode
> still set, e.g. after an earlier CPR attempt.  Reject them early in
> migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
> well as 'snapshot-save'/'snapshot-load' QMP commands.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  migration/options.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/migration/options.c b/migration/options.c
> index 05b026f4bf2..f648be1302b 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -555,8 +555,15 @@ static bool migrate_incoming_started(void)
>  bool migrate_can_snapshot(Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
> +    MigMode mode = migrate_mode();
>      int i;
>  
> +    if (mode != MIG_MODE_NORMAL) {
> +        error_setg(errp, "Snapshots are not compatible with migration mode %s",
> +                   MigMode_str(mode));
> +        return false;
> +    }
> +
>      for (i = 0; i < check_caps_savevm.size; i++) {
>          int incomp_cap = check_caps_savevm.caps[i];

+CC Akihiko Odaki

Reviewed-by: Fabiano Rosas <farosas@suse.de>

