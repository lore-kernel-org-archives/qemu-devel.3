Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C73C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsTI-0003Un-5U; Wed, 06 Mar 2024 09:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhsTF-00039D-6S
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:42:13 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhsTD-0001kS-MB
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:42:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 141E63F7F0;
 Wed,  6 Mar 2024 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709736130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xkh9yr1+p8PueX3L53cHv2AUpgHL/z+cV/m9Loe2anw=;
 b=asgSIyLF8pfvyKO5w8Plc0QBZCSpZ8XVbifs4PNwRJdVB49x7nKnisSFyeoARUdy20bR++
 iYzeTMl+x6R+ork8rHzAM7SYSfIu0E0dJkU+IsH10gP11g3LWmkhzviSQzzgI6bAsj3GhO
 suk86uzJ0tdh8gCuUhJNaMckfmWTef0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709736130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xkh9yr1+p8PueX3L53cHv2AUpgHL/z+cV/m9Loe2anw=;
 b=xIjHcXm8POcWvgvDB6AlvKNOBVTlDGVJpUB/g+GD4deLbNFCbFWUpiJ/hcH3vhbQATEVKQ
 lld2fMpABpngUUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709736128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xkh9yr1+p8PueX3L53cHv2AUpgHL/z+cV/m9Loe2anw=;
 b=qMJ1+8ZEdNfVwan7kfEaMC0hdzgK4OiNinPBxXhHfCHHoixho4wCBhLSMMr4jjytYkQ3aY
 iEHYCbjfSVTW4vFJiLkZKcAKyIX5axwsIPug5wdG4uvpUu7AMwkaeKDEvk1mXVCQZPq2ZO
 0eefSiExIy2fzpv8ilW3cFbA5znZAPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709736128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xkh9yr1+p8PueX3L53cHv2AUpgHL/z+cV/m9Loe2anw=;
 b=2sO/rdkdyhSH5D7n75wSShbfvgnVj/totpOP4N/Jvmj8Oyr1+0qtBzWHgIm8aJRcZmp6ip
 821GoxEgguOWmjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94B1513A67;
 Wed,  6 Mar 2024 14:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ItdGF7+A6GVASQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Mar 2024 14:42:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v3 5/7] Add channels parameter in migrate_qmp
In-Reply-To: <20240306104958.39857-6-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-6-het.gala@nutanix.com>
Date: Wed, 06 Mar 2024 11:42:05 -0300
Message-ID: <87h6hjs9qa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[99.99%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Het Gala <het.gala@nutanix.com> writes:

> Alter migrate_qmp() to allow use of channels parameter, but only
> fill the uri with correct port number if there are no channels.
> Here we don't want to allow the wrong cases of having both or
> none (ex: migrate_qmp_fail).
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 20 +++++++++++++++-----
>  tests/qtest/migration-helpers.h |  4 ++--
>  tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
>  3 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index df4978bf17..0b891351a5 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -19,7 +19,6 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qlist.h"
>  
> -
>  #include "migration-helpers.h"
>  
>  /*
> @@ -154,10 +153,12 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
>   * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
>   */
>  void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
> -                 const char *fmt, ...)
> +                 const char *channels, const char *fmt, ...)
>  {
>      va_list ap;
>      QDict *args;
> +    Error *error_abort = NULL;

Remove this.

> +    QObject *channels_obj = NULL;
>      g_autofree char *connect_uri = NULL;
>  
>      va_start(ap, fmt);

