Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCF7C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctgN-0000iz-0C; Wed, 21 Feb 2024 15:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rctgL-0000ij-Kx
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:59:09 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rctgJ-0005lN-AW
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:59:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 646322228D;
 Wed, 21 Feb 2024 20:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708549144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psMlRJvTcZCItPYhGeR/AouJC4RavelIS4cBjT6oinU=;
 b=GTHah/CB3zTLIgxDwaVnjEM4CaKpGy4Jl9Od3xp+WUeignIaOoQSjLxFGzeO5bdLp8KaeN
 lrHxTtWGmJLfqzetUOVIA/vtGXM2YiZgIAMWSnl5BXnDvo7kRClCpKq5QF7oYFW7KhH5fS
 HmQ/fzm5YlxbmSMCAk3BrpfTBxIp6d8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708549144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psMlRJvTcZCItPYhGeR/AouJC4RavelIS4cBjT6oinU=;
 b=Xe9F0n+S4R96Cs2TrjD3deg8ez8MViUqS+h0f4djm+QnrS8BAv1cxYtVMYLk60CXwlgzgf
 3UeZsyZxAwnX/iAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708549144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psMlRJvTcZCItPYhGeR/AouJC4RavelIS4cBjT6oinU=;
 b=GTHah/CB3zTLIgxDwaVnjEM4CaKpGy4Jl9Od3xp+WUeignIaOoQSjLxFGzeO5bdLp8KaeN
 lrHxTtWGmJLfqzetUOVIA/vtGXM2YiZgIAMWSnl5BXnDvo7kRClCpKq5QF7oYFW7KhH5fS
 HmQ/fzm5YlxbmSMCAk3BrpfTBxIp6d8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708549144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psMlRJvTcZCItPYhGeR/AouJC4RavelIS4cBjT6oinU=;
 b=Xe9F0n+S4R96Cs2TrjD3deg8ez8MViUqS+h0f4djm+QnrS8BAv1cxYtVMYLk60CXwlgzgf
 3UeZsyZxAwnX/iAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E28DE139D0;
 Wed, 21 Feb 2024 20:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1MAJKhdk1mV9XAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 20:59:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 5/7] migration/multifd: Add new migration test cases
 for legacy zero page checking.
In-Reply-To: <20240216224002.1476890-6-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-6-hao.xiang@bytedance.com>
Date: Wed, 21 Feb 2024 17:59:01 -0300
Message-ID: <878r3dbkkq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="GTHah/CB";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xe9F0n+S
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.47 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.16)[-0.777];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 646322228D
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> Now that zero page checking is done on the multifd sender threads by
> default, we still provide an option for backward compatibility. This
> change adds a qtest migration test case to set the zero-page-detection
> option to "legacy" and run multifd migration with zero page checking on the
> migration main thread.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  tests/qtest/migration-test.c | 52 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8a5bb1752e..c27083110a 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2621,6 +2621,24 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
>      return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
>  }
>  
> +static void *
> +test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
> +                                                        QTestState *to)
> +{
> +    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
> +    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
> +    return NULL;
> +}
> +
> +static void *
> +test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
> +                                                      QTestState *to)
> +{
> +    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
> +    migrate_set_parameter_str(from, "zero-page-detection", "none");
> +    return NULL;
> +}
> +
>  static void *
>  test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
>                                              QTestState *to)
> @@ -2652,6 +2670,36 @@ static void test_multifd_tcp_none(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_multifd_tcp_zero_page_legacy(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start_hook = test_migrate_precopy_tcp_multifd_start_zero_page_legacy,
> +        /*
> +         * Multifd is more complicated than most of the features, it
> +         * directly takes guest page buffers when sending, make sure
> +         * everything will work alright even if guest page is changing.
> +         */
> +        .live = true,
> +    };
> +    test_precopy_common(&args);
> +}
> +
> +static void test_multifd_tcp_no_zero_page(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start_hook = test_migration_precopy_tcp_multifd_start_no_zero_page,
> +        /*
> +         * Multifd is more complicated than most of the features, it
> +         * directly takes guest page buffers when sending, make sure
> +         * everything will work alright even if guest page is changing.
> +         */
> +        .live = true,
> +    };
> +    test_precopy_common(&args);
> +}
> +
>  static void test_multifd_tcp_zlib(void)
>  {
>      MigrateCommon args = {
> @@ -3550,6 +3598,10 @@ int main(int argc, char **argv)
>      }
>      migration_test_add("/migration/multifd/tcp/plain/none",
>                         test_multifd_tcp_none);
> +    migration_test_add("/migration/multifd/tcp/plain/zero_page_legacy",
> +                       test_multifd_tcp_zero_page_legacy);
> +    migration_test_add("/migration/multifd/tcp/plain/no_zero_page",
> +                       test_multifd_tcp_no_zero_page);

Here it's better to separate the main feature from the states. That way
we can run only the zero-page tests with:

 migration-test -r /x86_64/migration/multifd/tcp/plain/zero-page

Like so: (also dashes instead of underscores)
/zero-page/legacy
/zero-page/none

>      migration_test_add("/migration/multifd/tcp/plain/cancel",
>                         test_multifd_tcp_cancel);
>      migration_test_add("/migration/multifd/tcp/plain/zlib",

