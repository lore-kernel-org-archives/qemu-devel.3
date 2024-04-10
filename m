Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC0BCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 13:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruXnu-0001Qy-36; Wed, 10 Apr 2024 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruXnr-0001M6-QF
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:15:51 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruXnn-0006Bx-1z
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:15:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B26B13521B;
 Wed, 10 Apr 2024 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712754945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aVLeYP3Hc9J6gMfG7bBLePKrFJPAVi4lcsCaFcCPgs=;
 b=hKHaHsbh3Ql3fNLSB2NTcEj0ujeUchLOt9KLuRWyQErnseI/v/nj0yi2DWEqZP3TVT+iTv
 HpfWw9yFeVxZHBNTbhYUsir4gdw/sJ5TZgLn90R2yzgAegCVIF01OttS43P9COpReO8iT7
 WgjGmmwcb/i47uFVooNwBRqqM1Z3iTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712754945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aVLeYP3Hc9J6gMfG7bBLePKrFJPAVi4lcsCaFcCPgs=;
 b=W64g08b6ExepQeVRCy3VLvAI53DhDPd5iDkye5yOeF0s4FkFidptf+uBMJ9wWT5K6Swl4w
 BTWstbYmYmUFlEBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712754945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aVLeYP3Hc9J6gMfG7bBLePKrFJPAVi4lcsCaFcCPgs=;
 b=hKHaHsbh3Ql3fNLSB2NTcEj0ujeUchLOt9KLuRWyQErnseI/v/nj0yi2DWEqZP3TVT+iTv
 HpfWw9yFeVxZHBNTbhYUsir4gdw/sJ5TZgLn90R2yzgAegCVIF01OttS43P9COpReO8iT7
 WgjGmmwcb/i47uFVooNwBRqqM1Z3iTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712754945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aVLeYP3Hc9J6gMfG7bBLePKrFJPAVi4lcsCaFcCPgs=;
 b=W64g08b6ExepQeVRCy3VLvAI53DhDPd5iDkye5yOeF0s4FkFidptf+uBMJ9wWT5K6Swl4w
 BTWstbYmYmUFlEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D02613691;
 Wed, 10 Apr 2024 13:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W3N1AQGRFma2DAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Apr 2024 13:15:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, prerna.saxena@nutanix.com, Het Gala
 <het.gala@nutanix.com>
Subject: Re: [PATCH 4/4] tests/qtest/migration: Add postcopy migration
 qtests to use 'channels' argument instead of uri
In-Reply-To: <20240410111541.188504-5-het.gala@nutanix.com>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-5-het.gala@nutanix.com>
Date: Wed, 10 Apr 2024 10:15:42 -0300
Message-ID: <87v84ptl35.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> Add qtests to perform postcopy live migration by having list of
> 'channels' argument as the starting point instead of uri string.
> (Note: length of the list is restricted to 1 for now)
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-test.c | 38 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index fa8a860811..599018baa0 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1296,13 +1296,17 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      migrate_ensure_non_converge(from);
>  
>      migrate_prepare_for_dirty_mem(from);
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
> +    if (args->connect_channels) {
> +        migrate_incoming_qmp(to, NULL, args->connect_channels, "{}");
> +    } else {
> +        migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
> +    }

From an interface perspective it's a bit unexpected to need this
conditional when the migrate_qmp below doesn't need it.

>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>      wait_for_suspend(from, &src_state);
>  
> -    migrate_qmp(from, to, NULL, NULL, "{}");
> +    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
>  
>      migrate_wait_for_dirty_mem(from, to);
>  
> @@ -1355,6 +1359,20 @@ static void test_postcopy(void)
>      test_postcopy_common(&args);
>  }
>  
> +static void test_postcopy_channels(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .connect_channels = "[ { 'channel-type': 'main',"
> +                            "    'addr': { 'transport': 'socket',"
> +                            "              'type': 'inet',"
> +                            "              'host': '127.0.0.1',"
> +                            "              'port': '0' } } ]",
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  static void test_postcopy_suspend(void)
>  {
>      MigrateCommon args = {
> @@ -1555,6 +1573,18 @@ static void test_postcopy_recovery(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_postcopy_recovery_channels(void)
> +{
> +    MigrateCommon args = {
> +        .connect_channels = "[ { 'channel-type': 'main',"
> +                            "    'addr': { 'transport': 'socket',"
> +                            "              'type': 'inet',"
> +                            "              'host': '127.0.0.1',"
> +                            "              'port': '0' } } ]",
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
>  static void test_postcopy_recovery_compress(void)
>  {
>      MigrateCommon args = {
> @@ -3585,8 +3615,12 @@ int main(int argc, char **argv)
>  
>      if (has_uffd) {
>          migration_test_add("/migration/postcopy/plain", test_postcopy);
> +        migration_test_add("/migration/postcopy/channels/plain",
> +                           test_postcopy_channels);
>          migration_test_add("/migration/postcopy/recovery/plain",
>                             test_postcopy_recovery);
> +        migration_test_add("/migration/postcopy/recovery/channels/plain",
> +                           test_postcopy_recovery_channels);
>          migration_test_add("/migration/postcopy/preempt/plain",
>                             test_postcopy_preempt);
>          migration_test_add("/migration/postcopy/preempt/recovery/plain",

