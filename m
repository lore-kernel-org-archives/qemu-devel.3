Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85321C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 20:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVG47-0007LL-UY; Fri, 27 Jun 2025 16:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uVG46-0007Ki-Hd
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:52:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uVG44-0005mG-RG
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:52:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 232EC21134;
 Fri, 27 Jun 2025 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751057571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhtVvdQ4xBMZ/b+A2+k9vl0MEDJyZSSSBXoytq758ck=;
 b=1EBTmjBDKAhrN3TMGl2Ychfu1kYaMg9THn+lZNjfr0oBLkBiNkcm884lrpSM5j/3GfQ1b1
 WY3VgVz0AfQxZyA1TDwy7q9gtbZ5eCln4/ZoCj1TJP/vqFdHEpQWCNZgUEjLm3HEqb/SYt
 nVSRN135xbFjh5cnoUYe8IQt4nWdT1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751057571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhtVvdQ4xBMZ/b+A2+k9vl0MEDJyZSSSBXoytq758ck=;
 b=n5QLt+Md9SBH/GW0wcFDnj5iDJguAvbWtb8N+F9+dlEZNgahZmWBA4cnZnEY2ibaazpknf
 epXDvyuTNFbzReBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751057571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhtVvdQ4xBMZ/b+A2+k9vl0MEDJyZSSSBXoytq758ck=;
 b=1EBTmjBDKAhrN3TMGl2Ychfu1kYaMg9THn+lZNjfr0oBLkBiNkcm884lrpSM5j/3GfQ1b1
 WY3VgVz0AfQxZyA1TDwy7q9gtbZ5eCln4/ZoCj1TJP/vqFdHEpQWCNZgUEjLm3HEqb/SYt
 nVSRN135xbFjh5cnoUYe8IQt4nWdT1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751057571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhtVvdQ4xBMZ/b+A2+k9vl0MEDJyZSSSBXoytq758ck=;
 b=n5QLt+Md9SBH/GW0wcFDnj5iDJguAvbWtb8N+F9+dlEZNgahZmWBA4cnZnEY2ibaazpknf
 epXDvyuTNFbzReBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9619F13786;
 Fri, 27 Jun 2025 20:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4iX/FaIEX2hhOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Jun 2025 20:52:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: xjdeng <micro6947@gmail.com>, qemu-devel@nongnu.org
Cc: xjdeng <micro6947@gmail.com>
Subject: Re: [PATCH] qtest/migration: Fix potential NPD through getenv
In-Reply-To: <20250627024226.1767-1-micro6947@gmail.com>
References: <20250627024226.1767-1-micro6947@gmail.com>
Date: Fri, 27 Jun 2025 17:52:47 -0300
Message-ID: <87qzz46h5s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

xjdeng <micro6947@gmail.com> writes:

Hi, thanks for the interest in fixing this. However, the analysis it not
quite right:

> In `find_common_machine_version`, the code previously assumed that
> `getenv(var1)` and `getenv(var2)` would always return non-NULL values.

That's not true. qtest_qemu_binary() has:

    if (var) {
        qemu_bin = getenv(var);
        if (qemu_bin) {        <--- HERE
            return qemu_bin;
        }
    }

> However, if either environment variable is not set, `getenv` returns
> NULL, which could lead to a null pointer dereference.
>
> Tracing upstream usage: `find_common_machine_version` is called by
> `resolve_machine_version` with `QEMU_ENV_SRC` and `QEMU_ENV_DST`.
> `resolve_machine_version` is used by `migrate_start`, which is called
> by `migrate_postcopy_prepare`, and ultimately by `test_postcopy_common`.
>
> In `test_postcopy_common`, after `migrate_postcopy_prepare`, the
> function `migrate_postcopy_complete` is called. Inside, 
> `migration_get_env` checks if `QEMU_ENV_SRC` and `QEMU_ENV_DST` are
> set before use. Thus, these variables can be NULL, leading to a
> potential null pointer dereference in `find_common_machine_version`.

There's no dereference happening anywhere, just a g_test_message(),
which would show "(null)".

>
> Signed-off-by: xjdeng <micro6947@gmail.com>
> ---
>  tests/qtest/migration/migration-util.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> index 642cf50c8d..45c9e164e2 100644
> --- a/tests/qtest/migration/migration-util.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -203,8 +203,25 @@ char *find_common_machine_version(const char *mtype, const char *var1,
>          return g_strdup(type2);
>      }
>  
> -    g_test_message("No common machine version for machine type '%s' between "
> -                   "binaries %s and %s", mtype, getenv(var1), getenv(var2));

I don't think we'll ever reach here in case one var is NULL. It would
have been replaced with QTEST_QEMU_BINARY and either asserted or exited
in the if below:

    g_autofree char *type1 = qtest_resolve_machine_alias(var1, mtype);
    g_autofree char *type2 = qtest_resolve_machine_alias(var2, mtype);

    g_assert(type1 && type2);

    if (g_str_equal(type1, type2)) {
        /* either can be used */
        return g_strdup(type1);
    }

Can you provide a test command line that exposes the issue? Something
like:

QTEST_QEMU_BINARY=./qemu-system-<arch> QTEST_QEMU_BINARY_DST=<some other
qemu version here> ../tests/qtest/migration-test --full

Thanks

> +    char *varstring1 = getenv(var1);
> +    char *varstring2 = getenv(var2);
> +    if (varstring1 && varstring2) {
> +        g_test_message("No common machine version for machine type '%s' "
> +                       "between binaries %s and %s",
> +                       mtype, varstring1, varstring2);
> +    } else if (varstring1) {
> +        g_test_message("No common machine version for machine type '%s' "
> +                       "between binary %s and environment variable %s",
> +                       mtype, varstring1, var2);
> +    } else if (varstring2) {
> +        g_test_message("No common machine version for machine type '%s' "
> +                       "between binary %s and environment variable %s",
> +                       mtype, varstring2, var1);
> +    } else {
> +        g_test_message("No common machine version for machine type '%s' "
> +                       "between environment variables %s and %s",
> +                       mtype, var1, var2);
> +    }
>      g_assert_not_reached();
>  }

