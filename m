Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1280410AB830
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68Qr-00050L-72; Fri, 27 Mar 2026 10:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w68Qn-0004w4-As
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:45:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w68Qh-0003vj-Bl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:45:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 447BD5BECC;
 Fri, 27 Mar 2026 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774622692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XC/Gd+aMYIXN1pjOowzT1P6Yo4g/JCanpZIQDZBVAnI=;
 b=KLatCHM99/vETnk32WcWnJkDhFzYhuGPi9UDMptl0+zPufNvsWp/HTi949FJGh03wDKAGf
 XnUd+EOndWM1gUihYqvBdd/cw8d09QmlHF8Zg96dEheQlT73Ir0DuOUiapxJWh6TsxemQm
 xREaRknVFNdm5vc4vnYZW4tT4bmHSGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774622692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XC/Gd+aMYIXN1pjOowzT1P6Yo4g/JCanpZIQDZBVAnI=;
 b=qp9EGBX2DvHVNTfIr3W1WRNc37c7slp1KYsGE54Hm6AGUoMBqeu/r6chq+6obx15lkMJrc
 zq18ZEntz9kKCVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774622692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XC/Gd+aMYIXN1pjOowzT1P6Yo4g/JCanpZIQDZBVAnI=;
 b=KLatCHM99/vETnk32WcWnJkDhFzYhuGPi9UDMptl0+zPufNvsWp/HTi949FJGh03wDKAGf
 XnUd+EOndWM1gUihYqvBdd/cw8d09QmlHF8Zg96dEheQlT73Ir0DuOUiapxJWh6TsxemQm
 xREaRknVFNdm5vc4vnYZW4tT4bmHSGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774622692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XC/Gd+aMYIXN1pjOowzT1P6Yo4g/JCanpZIQDZBVAnI=;
 b=qp9EGBX2DvHVNTfIr3W1WRNc37c7slp1KYsGE54Hm6AGUoMBqeu/r6chq+6obx15lkMJrc
 zq18ZEntz9kKCVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08BD84A0A2;
 Fri, 27 Mar 2026 14:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qqcrL+KXxmlcYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 14:44:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Takeru Hayasaka <hayatake396@gmail.com>, qemu-devel@nongnu.org
Cc: Takeru Hayasaka <hayatake396@gmail.com>, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migration: Add mapped-ram/postcopy
 validation test
In-Reply-To: <20260327030404.1840571-1-hayatake396@gmail.com>
References: <20260327030404.1840571-1-hayatake396@gmail.com>
Date: Fri, 27 Mar 2026 11:44:47 -0300
Message-ID: <874im1ib6o.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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
> ---
>  tests/qtest/migration/misc-tests.c | 45 ++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 196f1ca84287..ae247250713b 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -215,6 +215,49 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
>      migrate_end(from, to, false);
>  }
>  
> +static void do_test_validate_capability_pair(MigrateCommon *args,

You could choose a shorter name here to make it easier on the eyes when
calling this multiple times. "do_test" is certainly superfluous.

> +                                             const char *first_capability,
> +                                             const char *second_capability,
> +                                             const char *expected_error)
> +{
> +    QTestState *from, *to;
> +    QDict *rsp;
> +    const char *error_desc;
> +
> +    args->start.hide_stderr = true;

Could set args->start.only_source here to save a bit of time.

> +
> +    if (migrate_start(&from, &to, "defer", &args->start)) {
> +        return;
> +    }

If you move the start and end into the caller, we could use this
function to test several pairs of capabilities without having to start a
new QEMU instance every time.

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
> +    migrate_end(from, to, false);
> +}
> +
> +static void test_validate_caps_mapped_ram_postcopy(char *name,
> +                                                   MigrateCommon *args)
> +{

I think this would be more useful if it were not restricted to just
mapped-ram and postcopy. Take a look at migration_test_add_suffix() and
test_cancel_src_after_status() on how to define a test that can be
applied to multiple strings. Something roughly like this:


  g_autofree char *cap_pair = g_path_get_basename(test_path);
  
  if (g_str_equal(cap_pair, "mapped_ram_postcopy")) {
      const char *error =
          "Mapped-ram migration is incompatible with postcopy";
  
      validate_caps_pair(args, "mapped-ram", "postcopy-ram", error);
      validate_caps_pair(args, "postcopy-ram", "mapped-ram", error);
  }

> +    const char *error =
> +        "Mapped-ram migration is incompatible with postcopy";
> +
> +    do_test_validate_capability_pair(args, "mapped-ram", "postcopy-ram",
> +                                     error);
> +    do_test_validate_capability_pair(args, "postcopy-ram", "mapped-ram",
> +                                     error);
> +}
> +
>  static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
>  {
>      args->listen_uri = "defer",
> @@ -276,4 +319,6 @@ void migration_test_add_misc(MigrationTestEnv *env)
>                         test_validate_uri_channels_both_set);
>      migration_test_add("/migration/validate_uri/channels/none_set",
>                         test_validate_uri_channels_none_set);
> +    migration_test_add("/migration/validate_caps/mapped_ram_postcopy",
> +                       test_validate_caps_mapped_ram_postcopy);
>  }

