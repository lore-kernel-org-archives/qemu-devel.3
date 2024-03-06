Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68450C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsRG-0006UP-KT; Wed, 06 Mar 2024 09:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhsRE-0006U5-Jp
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:09 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhsRB-000190-VT
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A680376DDF;
 Wed,  6 Mar 2024 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709736004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiWkhtCuxGbVFIPddj3khfr4+s8obheTPIArBE/DeP0=;
 b=sywZYfwIsbjOW5pzIsYj+klyNTFL/GRO+oaX6+ZZyVJETU9RYi4kuh1FfoxPCB3089ypsM
 M5Qr2LjsUHTVeLEAOL/p3JjAQMboclrRBjGgFWrV/VakTswFBSvivJh0uy/+NvR5DARPgR
 UYH1d64TUR41aulDwUPlG2M1mJc3HtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709736004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiWkhtCuxGbVFIPddj3khfr4+s8obheTPIArBE/DeP0=;
 b=F/OpZVnf1ttmwXWp8EHlCNGnMVyPGCJQLj0S7XbadGz2QqfPfR1JbIQXN8zqkzjZquTXNp
 j8NaYtnY+FntV6Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709736004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiWkhtCuxGbVFIPddj3khfr4+s8obheTPIArBE/DeP0=;
 b=sywZYfwIsbjOW5pzIsYj+klyNTFL/GRO+oaX6+ZZyVJETU9RYi4kuh1FfoxPCB3089ypsM
 M5Qr2LjsUHTVeLEAOL/p3JjAQMboclrRBjGgFWrV/VakTswFBSvivJh0uy/+NvR5DARPgR
 UYH1d64TUR41aulDwUPlG2M1mJc3HtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709736004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiWkhtCuxGbVFIPddj3khfr4+s8obheTPIArBE/DeP0=;
 b=F/OpZVnf1ttmwXWp8EHlCNGnMVyPGCJQLj0S7XbadGz2QqfPfR1JbIQXN8zqkzjZquTXNp
 j8NaYtnY+FntV6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D78713A67;
 Wed,  6 Mar 2024 14:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zwYeOUOA6GWXSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Mar 2024 14:40:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v3 3/7] Add channels parameter in migrate_qmp_fail
In-Reply-To: <20240306104958.39857-4-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-4-het.gala@nutanix.com>
Date: Wed, 06 Mar 2024 11:40:01 -0300
Message-ID: <87jzmfs9tq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,nutanix.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> Alter migrate_qmp_fail() to allow both uri and channels
> independently. For channels, convert string to a Dict.
> No dealing with migrate_get_socket_address() here because
> we will fail before starting the migration anyway.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 15 +++++++++++++--
>  tests/qtest/migration-helpers.h |  5 +++--
>  tests/qtest/migration-test.c    |  4 ++--
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 9af3c7d4d5..478c1f259b 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -92,17 +92,28 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>      return false;
>  }
>  
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      const char *channels, const char *fmt, ...)
>  {
>      va_list ap;
>      QDict *args, *err;
> +    Error *error_abort = NULL;

The error_abort needs to be the one defined in error.c. Just remove this
line.

> +    QObject *channels_obj = NULL;
>  
>      va_start(ap, fmt);
>      args = qdict_from_vjsonf_nofail(fmt, ap);
>      va_end(ap);
>  
>      g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    if (uri) {
> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    g_assert(!qdict_haskey(args, "channels"));
> +    if (channels) {
> +        channels_obj = qobject_from_json(channels, &error_abort);
> +        qdict_put_obj(args, "channels", channels_obj);
> +    }
>  
>      err = qtest_qmp_assert_failure_ref(
>          who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index e16a34c796..4e664148a5 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -33,8 +33,9 @@ G_GNUC_PRINTF(3, 4)
>  void migrate_incoming_qmp(QTestState *who, const char *uri,
>                            const char *fmt, ...);
>  
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      const char *channels, const char *fmt, ...);
>  
>  void migrate_set_capability(QTestState *who, const char *capability,
>                              bool value);
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 20b1dd031a..19bb93cb7d 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1721,7 +1721,7 @@ static void test_precopy_common(MigrateCommon *args)
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, args->connect_uri, "{}");
> +        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
>          goto finish;
>      }
>  
> @@ -1816,7 +1816,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, args->connect_uri, "{}");
> +        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
>          goto finish;
>      }

