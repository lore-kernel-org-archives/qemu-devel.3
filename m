Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0548CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 21:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShxh-0007N8-W2; Thu, 28 May 2026 17:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wShxg-0007Me-Tt
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:08:17 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wShxf-0003ls-Ct
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:08:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D8AD6AE18;
 Thu, 28 May 2026 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780002493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jpCZna+46TT+ORiZ1jt0dKpaZuc1rpPRbhraz1+pEs=;
 b=QHR5Q0lXFU4KAR6JhgpPrj4FlcOr9jCXEwBBpofje7JPmxFNQBki4sgVaJh2PyDkVbBKu0
 repQdv7WqGXU99Ral5iPTuD+Bg5rDTtoYF2hRudhjNVBshPPiJIeI3lkiX8rZAHMIzBh8y
 Hp+E1581kTkVYfO2n9AQ7qDUfxg99v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780002493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jpCZna+46TT+ORiZ1jt0dKpaZuc1rpPRbhraz1+pEs=;
 b=5RcLn7wvw+VuTOjV0PJ9eaSHcZkZBdwCRRpcBZq1c89GyvGqWqP9ipGjfQkxJGgNZXmXBC
 i23Rw1sNTfjFNHBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QHR5Q0lX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5RcLn7wv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780002493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jpCZna+46TT+ORiZ1jt0dKpaZuc1rpPRbhraz1+pEs=;
 b=QHR5Q0lXFU4KAR6JhgpPrj4FlcOr9jCXEwBBpofje7JPmxFNQBki4sgVaJh2PyDkVbBKu0
 repQdv7WqGXU99Ral5iPTuD+Bg5rDTtoYF2hRudhjNVBshPPiJIeI3lkiX8rZAHMIzBh8y
 Hp+E1581kTkVYfO2n9AQ7qDUfxg99v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780002493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jpCZna+46TT+ORiZ1jt0dKpaZuc1rpPRbhraz1+pEs=;
 b=5RcLn7wvw+VuTOjV0PJ9eaSHcZkZBdwCRRpcBZq1c89GyvGqWqP9ipGjfQkxJGgNZXmXBC
 i23Rw1sNTfjFNHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29BDE5AFB3;
 Thu, 28 May 2026 21:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NZhKOLyuGGpVCgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 28 May 2026 21:08:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH] qapi/migration: Remove @cpr-exec-command doc in
 MigrationParameter
In-Reply-To: <20260528201236.359452-1-peterx@redhat.com>
References: <20260528201236.359452-1-peterx@redhat.com>
Date: Thu, 28 May 2026 18:08:10 -0300
Message-ID: <87v7c7tf7p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9D8AD6AE18
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> This parameter was developed during similar window when the deduplication
> work was done, hence overlooked.  MigrationParameter is already in
> exception list of doc sanity checker.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 27a7970556..e8756308cf 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -804,10 +804,6 @@
>  # Migration parameters enumeration.  The enumeration values mirror the
>  # members of @MigrationParameters.
>  #
> -# @cpr-exec-command: Command to start the new QEMU process when @mode
> -#     is @cpr-exec.  The first list element is the program's filename,
> -#     the remainder its arguments.  (Since 10.2)
> -#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and

Reviewed-by: Fabiano Rosas <farosas@suse.de>

