Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD51FF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DTR-0004yc-Sa; Mon, 30 Mar 2026 10:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7DTQ-0004uP-2A
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:20:12 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7DTO-0001J6-4x
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:20:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3EB35BCD0;
 Mon, 30 Mar 2026 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774880405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glnreZ/s/aweLmjh0T9wlRV4Lgn4u9N6pyoesQ+ZZxQ=;
 b=WR0xBlkzCOcg7XIC5JWfPXVoEFVODpM6z995VfMeeDEksYGpov5M/Q4fOYu/wmPlUgmppN
 RRXOJZpv8iiHMUYAScLditx36vUY3VszHDLE7Hz0qARX4QTWv1jBOM8Y9d2ZM32qnuLFpm
 QNUgJd2tJ9h4UWA7B8K+mW8iYAIRZ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774880405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glnreZ/s/aweLmjh0T9wlRV4Lgn4u9N6pyoesQ+ZZxQ=;
 b=yf+VuLJSdYTEkkF1zgVYnepj3fP3volkPoPPT2Q4z7a69sntpucUBnjoxaQjiD2OiYYzC3
 Yi4RKYGvo+zXh0Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774880405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glnreZ/s/aweLmjh0T9wlRV4Lgn4u9N6pyoesQ+ZZxQ=;
 b=WR0xBlkzCOcg7XIC5JWfPXVoEFVODpM6z995VfMeeDEksYGpov5M/Q4fOYu/wmPlUgmppN
 RRXOJZpv8iiHMUYAScLditx36vUY3VszHDLE7Hz0qARX4QTWv1jBOM8Y9d2ZM32qnuLFpm
 QNUgJd2tJ9h4UWA7B8K+mW8iYAIRZ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774880405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glnreZ/s/aweLmjh0T9wlRV4Lgn4u9N6pyoesQ+ZZxQ=;
 b=yf+VuLJSdYTEkkF1zgVYnepj3fP3volkPoPPT2Q4z7a69sntpucUBnjoxaQjiD2OiYYzC3
 Yi4RKYGvo+zXh0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912604A0A2;
 Mon, 30 Mar 2026 14:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P1g6GJSGymlhUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Mar 2026 14:20:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Takeru Hayasaka <hayatake396@gmail.com>, qemu-devel@nongnu.org
Cc: hayatake396@gmail.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com
Subject: Re: [PATCH v2] tests/qtest/migration: Add mapped-ram/postcopy
 validation test
In-Reply-To: <20260327164705.1990226-1-hayatake396@gmail.com>
References: <CADFiAc+uCn1diKbpHGJ9yBUJbzaCEwSdmd3mF-42_SeZngqRVQ@mail.gmail.com>
 <20260327164705.1990226-1-hayatake396@gmail.com>
Date: Mon, 30 Mar 2026 11:20:02 -0300
Message-ID: <87se9hh019.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com,redhat.com];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Takeru Hayasaka <hayatake396@gmail.com> writes:

> The migration capability checks reject enabling postcopy-ram together
> with mapped-ram, but there is no qtest covering this incompatibility.
>
> Add a validation test that verifies QMP rejects the combination in
> both capability ordering cases and returns the expected error.
>
> This keeps the existing capability boundary covered without changing
> migration behavior.
>
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
> Built with:
>   ./configure --target-list=x86_64-softmmu --disable-werror
>   ninja -C build tests/qtest/migration-test qemu-system-x86_64
>
> Tested with:
>   QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
>   ./build/tests/qtest/migration-test --full \
>   -p /x86_64/migration/validate_caps/mapped_ram_postcopy
>
>  v2:
>    - Rename do_test_validate_capability_pair to validate_caps_pair
>    - Move migrate_start/migrate_end to caller for VM reuse
>    - Set only_source to skip target VM
>    - Generalize test using migration_test_add_suffix pattern

Hi, thank you for the patch. It looks good aside from a small functional
issue I'll mention below.

Let me just point out that is customary to not send patches in reply to
the previous thread. So this v2 should have been its own thread
completely independent of the first version. This helps the community
keep track of the various series on the list without patches getting
lost deep inside mail threads.

> ---
>  tests/qtest/migration/misc-tests.c | 50 ++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 196f1ca84287..4131e7b0614d 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -215,6 +215,53 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
>      migrate_end(from, to, false);
>  }
>  
> +static void validate_caps_pair(QTestState *from,
> +                               const char *first_capability,
> +                               const char *second_capability,
> +                               const char *expected_error)
> +{
> +    QDict *rsp;
> +    const char *error_desc;
> +
> +    migrate_set_capability(from, first_capability, true);
> +
> +    rsp = qtest_qmp_assert_failure_ref(
> +        from,
> +        "{ 'execute': 'migrate-set-capabilities',"
> +        "  'arguments': { 'capabilities': [ { "
> +        "      'capability': %s, 'state': true } ] } }",
> +        second_capability);
> +
> +    error_desc = qdict_get_str(rsp, "desc");
> +    g_assert_cmpstr(error_desc, ==, expected_error);
> +    qobject_unref(rsp);
> +
> +    migrate_set_capability(from, first_capability, false);
> +}
> +
> +static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
> +{
> +    g_autofree char *cap_pair = g_path_get_basename(test_path);
> +    QTestState *from, *to;
> +
> +    args->start.hide_stderr = true;
> +    args->start.only_source = true;
> +
> +    if (migrate_start(&from, &to, "defer", &args->start)) {
> +        return;
> +    }
> +
> +    if (g_str_equal(cap_pair, "mapped_ram_postcopy")) {
> +        const char *error =
> +            "Mapped-ram migration is incompatible with postcopy";
> +
> +        validate_caps_pair(from, "mapped-ram", "postcopy-ram", error);
> +        validate_caps_pair(from, "postcopy-ram", "mapped-ram", error);
> +    }
> +
> +    qtest_quit(from);

This will leave the "src_serial" file behind in the test directory and
will cause cleanup of the tests to fail. However, I see that using
migrate_end() here would cause an access to the not-initialized "to"
pointer. I actually misremembered the code we have in master when I
suggested to use only_source for this, I have a patch making
migrate_end() accept NULL that has not been merged yet.

As a temporary solution, we could just unlink() the src_serial file here
directly. I'll do that myself when applying the patch, you don't need to
send a new version.

> +}
> +
>  static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
>  {
>      args->listen_uri = "defer",
> @@ -276,4 +323,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
>                         test_validate_uri_channels_both_set);
>      migration_test_add("/migration/validate_uri/channels/none_set",
>                         test_validate_uri_channels_none_set);
> +    migration_test_add_suffix("/migration/validate_caps/",
> +                              "mapped_ram_postcopy",
> +                              test_validate_caps_pair);
>  }

