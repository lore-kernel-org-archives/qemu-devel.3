Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A607CC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhssG-0000xy-EI; Wed, 06 Mar 2024 10:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhssA-0000vq-Si
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:08:00 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhss9-0004SW-3J
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:07:58 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5D2740C5;
 Wed,  6 Mar 2024 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709737674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCV3WMBx5jMOWO76/n+oxKES+XRmndN1HmTmMvsnm1Y=;
 b=OHPJ9VSpRbyLMXzLPc9Rf23XDinRfMsYmVWBNkic7k19AA6fKMp1DBBBHB+N5MDjgR5Lou
 3+YKDDRmvLUFfd8fY1LLUxQVhbYGG8BnSlnuNS6w36xwB6F/+eXyemG72aiYotDp4NTno4
 x+KmiS4Ych8XmpYUkAe/8F6K1KHO8B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709737674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCV3WMBx5jMOWO76/n+oxKES+XRmndN1HmTmMvsnm1Y=;
 b=ZWeKUVXvHDbqC1yMi6HByd/b2ltrtqqMvqf2zzivDaltZWLm1Oik0ElHZ/cs0IP9tRgjRi
 w3hZZ6ML3eF68uDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709737674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCV3WMBx5jMOWO76/n+oxKES+XRmndN1HmTmMvsnm1Y=;
 b=OHPJ9VSpRbyLMXzLPc9Rf23XDinRfMsYmVWBNkic7k19AA6fKMp1DBBBHB+N5MDjgR5Lou
 3+YKDDRmvLUFfd8fY1LLUxQVhbYGG8BnSlnuNS6w36xwB6F/+eXyemG72aiYotDp4NTno4
 x+KmiS4Ych8XmpYUkAe/8F6K1KHO8B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709737674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xCV3WMBx5jMOWO76/n+oxKES+XRmndN1HmTmMvsnm1Y=;
 b=ZWeKUVXvHDbqC1yMi6HByd/b2ltrtqqMvqf2zzivDaltZWLm1Oik0ElHZ/cs0IP9tRgjRi
 w3hZZ6ML3eF68uDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50E0E13A67;
 Wed,  6 Mar 2024 15:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2pN4BsqG6GXwUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Mar 2024 15:07:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v3 6/7] Add multifd_tcp_plain test using list of
 channels instead of uri
In-Reply-To: <20240306104958.39857-7-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-7-het.gala@nutanix.com>
Date: Wed, 06 Mar 2024 12:07:51 -0300
Message-ID: <87edcns8jc.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Add a positive test to check multifd live migration but this time
> using list of channels (restricted to 1) as the starting point
> instead of simple uri string.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index f94fe713b2..05e5f3ebe5 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -659,6 +659,12 @@ typedef struct {
>       */
>      const char *connect_uri;
>  
> +    /*
> +     * Optional: the JSON formatted list of URIs for the src
> +     * QEMU to connect to
> +     */

You could add some words here mentioning that a port of '0' will be
automatically converted to the correct port that the destination is
using.

> +    const char *connect_channels;
> +
>      /* Optional: callback to run at start to set migration parameters */
>      TestMigrateStartHook start_hook;
>      /* Optional: callback to run at finish to cleanup */
> @@ -2623,7 +2629,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
>  }
>  #endif /* CONFIG_ZSTD */
>  
> -static void test_multifd_tcp_none(void)
> +static void test_multifd_tcp_uri_none(void)
>  {
>      MigrateCommon args = {
>          .listen_uri = "defer",
> @@ -2638,6 +2644,21 @@ static void test_multifd_tcp_none(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_multifd_tcp_channels_none(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start_hook = test_migrate_precopy_tcp_multifd_start,
> +        .live = true,
> +        .connect_channels = "[ { 'channel-type': 'main',"
> +                            "    'addr': { 'transport': 'socket',"
> +                            "              'type': 'inet',"
> +                            "              'host': '127.0.0.1',"
> +                            "              'port': '0' } } ]",
> +    };
> +    test_precopy_common(&args);
> +}
> +
>  static void test_multifd_tcp_zlib(void)
>  {
>      MigrateCommon args = {
> @@ -3531,8 +3552,10 @@ int main(int argc, char **argv)
>                                 test_migrate_dirty_limit);
>          }
>      }
> -    migration_test_add("/migration/multifd/tcp/plain/none",
> -                       test_multifd_tcp_none);
> +    migration_test_add("/migration/multifd/tcp/uri/plain/none",
> +                       test_multifd_tcp_uri_none);
> +    migration_test_add("/migration/multifd/tcp/channels/plain/none",
> +                       test_multifd_tcp_channels_none);

We should eventually make a pass to standardize/simplify these
strings. We could have a little "grammar" defined on how to construct
them.

/<test-type>/<migration-mode>/<transport>/<invocation>/<compression>/<encryption>

test-type      :: migrate | validate
migration-mode :: multifd | precopy | postcopy
transport      :: tcp | fd | unix | file
invocation     :: uri | channels
compression    :: zlib | zstd | none
encryption     :: tls | plain

Anyway, work for the future.

