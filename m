Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21F2C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 21:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpE1M-00065o-4n; Tue, 26 Mar 2024 17:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rpE1I-00065Q-TA
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 17:07:45 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rpE1E-0004Wx-7L
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 17:07:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 298F65F8C3;
 Tue, 26 Mar 2024 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711487255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpaUFyGUxXWyhUAffr06UFf0ZCIAiouoPA8yqEa4PY=;
 b=iH8IypYSapnPgWkrcUOvf/CPGL7Tja7AZ71bJ8q0TUc6sJxuNDniAmFnzydEVtLuXK0QAR
 mnqhk/+lWbiRwt0BAwUki3sLw/BqOHxzmz7JBN4oWKY0CVSXyclCw8fN0cTJBdZRADq0B9
 tSpPTAFoiNILpuujQhVzf9ua/mwoz4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711487255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpaUFyGUxXWyhUAffr06UFf0ZCIAiouoPA8yqEa4PY=;
 b=Qlz5nizEs0s5X6LTyYVRjRJwTk76CVT/bVLstVxCs8ahHdAfEPxHkjE4EHm180Z2cbu8df
 fzvgSgtsHSqbZFBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711487255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpaUFyGUxXWyhUAffr06UFf0ZCIAiouoPA8yqEa4PY=;
 b=iH8IypYSapnPgWkrcUOvf/CPGL7Tja7AZ71bJ8q0TUc6sJxuNDniAmFnzydEVtLuXK0QAR
 mnqhk/+lWbiRwt0BAwUki3sLw/BqOHxzmz7JBN4oWKY0CVSXyclCw8fN0cTJBdZRADq0B9
 tSpPTAFoiNILpuujQhVzf9ua/mwoz4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711487255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpaUFyGUxXWyhUAffr06UFf0ZCIAiouoPA8yqEa4PY=;
 b=Qlz5nizEs0s5X6LTyYVRjRJwTk76CVT/bVLstVxCs8ahHdAfEPxHkjE4EHm180Z2cbu8df
 fzvgSgtsHSqbZFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A134113688;
 Tue, 26 Mar 2024 21:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ENjmGRY5A2asCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 26 Mar 2024 21:07:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH] tests/qtest: Standardize qtest function caller strings.
In-Reply-To: <20240326193843.8444-1-het.gala@nutanix.com>
References: <20240326193843.8444-1-het.gala@nutanix.com>
Date: Tue, 26 Mar 2024 18:07:32 -0300
Message-ID: <87zfukvh0r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(5.10)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
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

Het Gala <het.gala@nutanix.com> writes:

Some comments, mostly just thinking out loud...

> For <test-type> --> migrate
> /<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
> <compression>/<encryption>/O:<others>/...
>
> For <test-type> --> validate
> /<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
> <validate-test-result>/O:<test-reason>/O:<others>/...

Do we need an optional 'capability' element? I'm not sure how practical
is to leave that as 'others', because that puts it at the end of the
string. We'd want the element that's more important/with more variants
to be towards the start of the string so we can run all tests of the
same kind with the -r option.

>
> test-type            :: migrate | validate

We could alternatively drop migration|migrate|validate. They are kind of
superfluous.

> migration-mode
>   a. migrate -->     :: precopy | postcopy | multifd
>   b. validate -->    :: (what to validate)
> methods              :: preempt | recovery | reboot | suspend | simple
> transport            :: tcp | fd | unix | file
> invocation           :: uri | channels | both
> CompressionType      :: zlib | zstd | none

s/none/nocomp/ ? We're already familiar with that.

> encryptionType       :: tls | plain

s/plain/notls/ ?

Or maybe we simply omit the noop options. It would make the string way
shorter in most cases.

> validate-test-result :: success | failure
> others               :: other comments/capability that needs to be
>                         addressed. Can be multiple
>
> (more than one applicable, separated by using '-' in between)
> O: optional
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
>  1 file changed, 72 insertions(+), 71 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index bd9f4b9dbb..bf4d000b76 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3620,62 +3620,63 @@ int main(int argc, char **argv)
>      module_call_init(MODULE_INIT_QOM);
>  
>      if (is_x86) {
> -        migration_test_add("/migration/precopy/unix/suspend/live",
> +        migration_test_add("/migrate/precopy/suspend/unix/uri/none/plain/live",
>                             test_precopy_unix_suspend_live);
> -        migration_test_add("/migration/precopy/unix/suspend/notlive",
> +        migration_test_add("/migrate/precopy/suspend/unix/uri/none/plain/notlive",
>                             test_precopy_unix_suspend_notlive);
>      }
>  
>      if (has_uffd) {
> -        migration_test_add("/migration/postcopy/plain", test_postcopy);
> -        migration_test_add("/migration/postcopy/recovery/plain",
> -                           test_postcopy_recovery);
> -        migration_test_add("/migration/postcopy/preempt/plain",
> +        migration_test_add("/migrate/postcopy/simple/tcp/uri/none/plain",
> +                           test_postcopy);
> +        migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/plain",
> +                           test_postcopy_recovery);                         
> +        migration_test_add("/migrate/postcopy/preempt/tcp/uri/none/plain",
>                             test_postcopy_preempt);
> -        migration_test_add("/migration/postcopy/preempt/recovery/plain",
> +        migration_test_add("/migrate/postcopy/preempt-recovery/tcp/uri/none/plain",
>                             test_postcopy_preempt_recovery);
>          if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> -            migration_test_add("/migration/postcopy/compress/plain",
> +            migration_test_add("/migrate/postcopy/simple/tcp/uri/none/plain/compress",
>                                 test_postcopy_compress);
> -            migration_test_add("/migration/postcopy/recovery/compress/plain",
> +            migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/plain/compress",
>                                 test_postcopy_recovery_compress);
>          }
>  #ifndef _WIN32
> -        migration_test_add("/migration/postcopy/recovery/double-failures",
> +        migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/none/plain/double-failures",
>                             test_postcopy_recovery_double_fail);
>  #endif /* _WIN32 */
>          if (is_x86) {
> -            migration_test_add("/migration/postcopy/suspend",
> +            migration_test_add("/migrate/postcopy/suspend/tcp/uri/none/plain",
>                                 test_postcopy_suspend);
>          }
>      }
>  
> -    migration_test_add("/migration/bad_dest", test_baddest);
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/plain/bad_dest", test_baddest);
>  #ifndef _WIN32
>      if (!g_str_equal(arch, "s390x")) {
> -        migration_test_add("/migration/analyze-script", test_analyze_script);
> +        migration_test_add("/migrate/precopy/simple/file/uri/none/plain/analyze-script", test_analyze_script);
>      }
>  #endif
> -    migration_test_add("/migration/precopy/unix/plain",
> +    migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/live",
>                         test_precopy_unix_plain);
> -    migration_test_add("/migration/precopy/unix/xbzrle",
> +    migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/xbzrle-live",
>                         test_precopy_unix_xbzrle);
>      /*
>       * Compression fails from time to time.
>       * Put test here but don't enable it until everything is fixed.
>       */
>      if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> -        migration_test_add("/migration/precopy/unix/compress/wait",
> +        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/compress-wait",
>                             test_precopy_unix_compress);
> -        migration_test_add("/migration/precopy/unix/compress/nowait",
> +        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/compress-nowait",
>                             test_precopy_unix_compress_nowait);
>      }
>  
> -    migration_test_add("/migration/precopy/file",
> +    migration_test_add("/migrate/precopy/simple/file/uri/none/plain",
>                         test_precopy_file);
> -    migration_test_add("/migration/precopy/file/offset",
> +    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/offset",
>                         test_precopy_file_offset);
> -    migration_test_add("/migration/precopy/file/offset/bad",
> +    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/bad-offset",
>                         test_precopy_file_offset_bad);
>  
>      /*
> @@ -3683,25 +3684,25 @@ int main(int argc, char **argv)
>       * Don't run this test until we find a workaround.
>       */
>      if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> -        migration_test_add("/migration/mode/reboot", test_mode_reboot);
> +        migration_test_add("/migrate/precopy/reboot/file/uri/none/plain", test_mode_reboot);
>      }
>  
> -    migration_test_add("/migration/precopy/file/mapped-ram",
> +    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/mapped-ram",
>                         test_precopy_file_mapped_ram);
> -    migration_test_add("/migration/precopy/file/mapped-ram/live",
> +    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/mapped-ram-live",
>                         test_precopy_file_mapped_ram_live);
>  
> -    migration_test_add("/migration/multifd/file/mapped-ram",
> +    migration_test_add("/migrate/multifd/simple/file/uri/none/plain/mapped-ram",
>                         test_multifd_file_mapped_ram);
> -    migration_test_add("/migration/multifd/file/mapped-ram/live",
> +    migration_test_add("/migrate/multifd/simple/file/uri/none/plain/mapped-ram-live",
>                         test_multifd_file_mapped_ram_live);
>  #ifndef _WIN32
> -    migration_test_add("/migration/multifd/fd/mapped-ram",
> +    migration_test_add("/migrate/multifd/simple/fd/uri/none/plain/mapped-ram",
>                         test_multifd_fd_mapped_ram);
>  #endif
>  
>  #ifdef CONFIG_GNUTLS
> -    migration_test_add("/migration/precopy/unix/tls/psk",
> +    migration_test_add("/migrate/precopy/simple/unix/uri/none/tls/psk",
>                         test_precopy_unix_tls_psk);
>  
>      if (has_uffd) {
> @@ -3710,122 +3711,122 @@ int main(int argc, char **argv)
>           * channels are tested under precopy.  Here what we want to test is the
>           * general postcopy path that has TLS channel enabled.
>           */
> -        migration_test_add("/migration/postcopy/tls/psk",
> +        migration_test_add("/migrate/postcopy/simple/tcp/uri/none/tls/psk",
>                             test_postcopy_tls_psk);
> -        migration_test_add("/migration/postcopy/recovery/tls/psk",
> +        migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/tls/psk",
>                             test_postcopy_recovery_tls_psk);
> -        migration_test_add("/migration/postcopy/preempt/tls/psk",
> +        migration_test_add("/migrate/postcopy/preempt/tcp/uri/none/tls/psk",
>                             test_postcopy_preempt_tls_psk);
> -        migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
> +        migration_test_add("/migrate/postcopy/preempt-recovery/tcp/uri/none/tls/psk",
>                             test_postcopy_preempt_all);
>      }
>  #ifdef CONFIG_TASN1
> -    migration_test_add("/migration/precopy/unix/tls/x509/default-host",
> +    migration_test_add("/migrate/precopy/simple/unix/uri/none/tls/x509/default-host",
>                         test_precopy_unix_tls_x509_default_host);
> -    migration_test_add("/migration/precopy/unix/tls/x509/override-host",
> +    migration_test_add("/migrate/precopy/simple/unix/uri/none/tls/x509/override-host",
>                         test_precopy_unix_tls_x509_override_host);
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -    migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/plain", test_precopy_tcp_plain);
>  
> -    migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/plain/switchover-ack",
>                         test_precopy_tcp_switchover_ack);
>  
>  #ifdef CONFIG_GNUTLS
> -    migration_test_add("/migration/precopy/tcp/tls/psk/match",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/psk/match",
>                         test_precopy_tcp_tls_psk_match);
> -    migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/psk/mismatch",
>                         test_precopy_tcp_tls_psk_mismatch);
>  #ifdef CONFIG_TASN1
> -    migration_test_add("/migration/precopy/tcp/tls/x509/default-host",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/default-host",
>                         test_precopy_tcp_tls_x509_default_host);
> -    migration_test_add("/migration/precopy/tcp/tls/x509/override-host",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/override-host",
>                         test_precopy_tcp_tls_x509_override_host);
> -    migration_test_add("/migration/precopy/tcp/tls/x509/mismatch-host",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/mismatch-host",
>                         test_precopy_tcp_tls_x509_mismatch_host);
> -    migration_test_add("/migration/precopy/tcp/tls/x509/friendly-client",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/friendly-client",
>                         test_precopy_tcp_tls_x509_friendly_client);
> -    migration_test_add("/migration/precopy/tcp/tls/x509/hostile-client",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/hostile-client",
>                         test_precopy_tcp_tls_x509_hostile_client);
> -    migration_test_add("/migration/precopy/tcp/tls/x509/allow-anon-client",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/allow-anon-client",
>                         test_precopy_tcp_tls_x509_allow_anon_client);
> -    migration_test_add("/migration/precopy/tcp/tls/x509/reject-anon-client",
> +    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/reject-anon-client",
>                         test_precopy_tcp_tls_x509_reject_anon_client);
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
>      /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
>  #ifndef _WIN32
> -    migration_test_add("/migration/precopy/fd/tcp",
> +    migration_test_add("/migrate/precopy/simple/fd-tcp/uri/none/plain",
>                         test_migrate_precopy_fd_socket);
> -    migration_test_add("/migration/precopy/fd/file",
> +    migration_test_add("/migrate/precopy/simple/fd-file/uri/none/plain",
>                         test_migrate_precopy_fd_file);
> -    migration_test_add("/migration/precopy/fd/file/mapped-ram",
> +    migration_test_add("/migrate/precopy/simple/fd-tcp/uri/none/plain/mapped-ram",
>                         test_migrate_precopy_fd_file_mapped_ram);
>  #endif
> -    migration_test_add("/migration/validate_uuid", test_validate_uuid);
> -    migration_test_add("/migration/validate_uuid_error",
> +    migration_test_add("/validate/uuid/unix/uri/success", test_validate_uuid);
> +    migration_test_add("/validate/uuid/unix/uri/failure/uuid-error",
>                         test_validate_uuid_error);
> -    migration_test_add("/migration/validate_uuid_src_not_set",
> +    migration_test_add("/validate/uuid/unix/uri/failure/src_not_set",
>                         test_validate_uuid_src_not_set);
> -    migration_test_add("/migration/validate_uuid_dst_not_set",
> +    migration_test_add("/validate/uuid/unix/uri/failure/dst_not_set",
>                         test_validate_uuid_dst_not_set);
> -    migration_test_add("/migration/validate_uri/channels/both_set",
> +    migration_test_add("/validate/connect_channels/tcp/both/failure/both_set",
>                         test_validate_uri_channels_both_set);
> -    migration_test_add("/migration/validate_uri/channels/none_set",
> +    migration_test_add("/validate/connect_channels/tcp/both/failure/none_set",
>                         test_validate_uri_channels_none_set);
>      /*
>       * See explanation why this test is slow on function definition
>       */
>      if (g_test_slow()) {
> -        migration_test_add("/migration/auto_converge",
> +        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/auto_converge",
>                             test_migrate_auto_converge);
>          if (g_str_equal(arch, "x86_64") &&
>              has_kvm && kvm_dirty_ring_supported()) {
> -            migration_test_add("/migration/dirty_limit",
> +            migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/dirty_limit",
>                                 test_migrate_dirty_limit);
>          }
>      }
> -    migration_test_add("/migration/multifd/tcp/uri/plain/none",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain",
>                         test_multifd_tcp_uri_none);
> -    migration_test_add("/migration/multifd/tcp/channels/plain/none",
> +    migration_test_add("/migrate/multifd/simple/tcp/channels/none/plain",
>                         test_multifd_tcp_channels_none);
> -    migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain/zero-page/legacy",
>                         test_multifd_tcp_zero_page_legacy);
> -    migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain/zero-page/none",
>                         test_multifd_tcp_no_zero_page);
> -    migration_test_add("/migration/multifd/tcp/plain/cancel",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain/cancel",
>                         test_multifd_tcp_cancel);
> -    migration_test_add("/migration/multifd/tcp/plain/zlib",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/zlib/plain",
>                         test_multifd_tcp_zlib);
>  #ifdef CONFIG_ZSTD
> -    migration_test_add("/migration/multifd/tcp/plain/zstd",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/zstd/plain",
>                         test_multifd_tcp_zstd);
>  #endif
>  #ifdef CONFIG_GNUTLS
> -    migration_test_add("/migration/multifd/tcp/tls/psk/match",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/psk/match",
>                         test_multifd_tcp_tls_psk_match);
> -    migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/psk/mismatch",
>                         test_multifd_tcp_tls_psk_mismatch);
>  #ifdef CONFIG_TASN1
> -    migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/default-host",
>                         test_multifd_tcp_tls_x509_default_host);
> -    migration_test_add("/migration/multifd/tcp/tls/x509/override-host",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/override-host",
>                         test_multifd_tcp_tls_x509_override_host);
> -    migration_test_add("/migration/multifd/tcp/tls/x509/mismatch-host",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/mismatch-host",
>                         test_multifd_tcp_tls_x509_mismatch_host);
> -    migration_test_add("/migration/multifd/tcp/tls/x509/allow-anon-client",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/allow-anon-client",
>                         test_multifd_tcp_tls_x509_allow_anon_client);
> -    migration_test_add("/migration/multifd/tcp/tls/x509/reject-anon-client",
> +    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/reject-anon-client",
>                         test_multifd_tcp_tls_x509_reject_anon_client);
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
>      if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
> -        migration_test_add("/migration/dirty_ring",
> +        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/dirty_ring",
>                             test_precopy_unix_dirty_ring);
> -        migration_test_add("/migration/vcpu_dirty_limit",
> +        migration_test_add("/validate/vcpu/dirty_limit",
>                             test_vcpu_dirty_limit);
>      }

