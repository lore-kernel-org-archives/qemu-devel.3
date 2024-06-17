Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50364C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 20:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJIj0-0002TY-Ko; Mon, 17 Jun 2024 16:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJIiy-0002Sw-OL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 16:13:08 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJIiw-0001hb-V4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 16:13:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 056C51F37C;
 Mon, 17 Jun 2024 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718655183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=moN3foLxNDneuMcwABcVaJKsVlb0CkC9ub2WsAL8rd8=;
 b=dWXeE3FsVCczx6mEXMUKUufk00Hm+jac2Ts27RDD3c2XbGklBedjFUPvtusAHSrvD+plGY
 nSM/K0hfbEcAeP7dN+PiDeQUwfvo1eR/4tf8LairNtxXCqoMmPLaB+tp5FwFnppulaVXup
 Yji7lEyEClYKsXOi1Ko5AOdjTX8lQ6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718655183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=moN3foLxNDneuMcwABcVaJKsVlb0CkC9ub2WsAL8rd8=;
 b=yOFu/3Jo0kyGbq3Ezkqx8MoCA/mII0uscd5W5x4HWP30os8U2SobuxdvHeO3Xb2beX5P8U
 frjQ+nOz54g0aMBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718655183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=moN3foLxNDneuMcwABcVaJKsVlb0CkC9ub2WsAL8rd8=;
 b=dWXeE3FsVCczx6mEXMUKUufk00Hm+jac2Ts27RDD3c2XbGklBedjFUPvtusAHSrvD+plGY
 nSM/K0hfbEcAeP7dN+PiDeQUwfvo1eR/4tf8LairNtxXCqoMmPLaB+tp5FwFnppulaVXup
 Yji7lEyEClYKsXOi1Ko5AOdjTX8lQ6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718655183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=moN3foLxNDneuMcwABcVaJKsVlb0CkC9ub2WsAL8rd8=;
 b=yOFu/3Jo0kyGbq3Ezkqx8MoCA/mII0uscd5W5x4HWP30os8U2SobuxdvHeO3Xb2beX5P8U
 frjQ+nOz54g0aMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CCA6139AB;
 Mon, 17 Jun 2024 20:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MNmtEM6YcGbMPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 20:13:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 00/10] migration: New postcopy state, and some cleanups
In-Reply-To: <ZnCP1uVDNP2GQ4ZA@x1n>
References: <20240617181534.1425179-1-peterx@redhat.com> <ZnCP1uVDNP2GQ4ZA@x1n>
Date: Mon, 17 Jun 2024 17:12:59 -0300
Message-ID: <871q4vba5w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
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

Peter Xu <peterx@redhat.com> writes:

> Hello,
>
> On Mon, Jun 17, 2024 at 02:15:24PM -0400, Peter Xu wrote:
>> v2:
>> - Collect tags
>> - Patch 3
>>   - cover all states in migration_postcopy_is_alive()
>> - Patch 4 (old)
>>   - English changes [Fabiano]
>>   - Split the migration_incoming_state_setup() cleanup into a new patch
>>     [Fabiano]
>>   - Drop RECOVER_SETUP in fill_destination_migration_info() [Fabiano]
>>   - Keep using explicit state check in migrate_fd_connect() for resume
>>     [Fabiano]
>> - New patches
>>   - New doc update: "migration/docs: Update postcopy recover session for
>>     SETUP phase"
>>   - New test case: last four patches
>
> I just found that this won't apply on top of latest master, and also has a
> trivial conflict against the direct-io stuffs.  Fabiano, I'll wait for a
> few days on comments, and resend v3 on top of your direct-io stuff.
>
> Meanwhile I also plan to squash below fixup to the last test patch, just to
> fix up a spelling error I just found, and also renamed the test cases (as
> the new test is actually also a "double failure" test, just at different
> phase).  Comments welcomed for that fixup even before a repost.
>
> ===8<===
> From 5b8fbc3a9d9e87ebfef1a3e5592fd196eecd5923 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 17 Jun 2024 14:40:15 -0400
> Subject: [PATCH] fixup! tests/migration-tests: Cover postcopy failure on
>  reconnect
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration-test.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index a4fed4cc6b..fe33b86783 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1474,7 +1474,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to,
>  
>      /*
>       * Kick dest QEMU out too. This is normally not needed in reality
> -     * because when the channel is shutdown it should also happens on src.
> +     * because when the channel is shutdown it should also happen on src.
>       * However here we used separate socket pairs so we need to do that
>       * explicitly.
>       */
> @@ -1565,7 +1565,7 @@ static void test_postcopy_recovery(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> -static void test_postcopy_recovery_double_fail(void)
> +static void test_postcopy_recovery_fail_handshake(void)
>  {
>      MigrateCommon args = {
>          .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
> @@ -1574,7 +1574,7 @@ static void test_postcopy_recovery_double_fail(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> -static void test_postcopy_recovery_channel_reconnect(void)
> +static void test_postcopy_recovery_fail_reconnect(void)
>  {
>      MigrateCommon args = {
>          .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
> @@ -3759,10 +3759,10 @@ int main(int argc, char **argv)
>                             test_postcopy_preempt);
>          migration_test_add("/migration/postcopy/preempt/recovery/plain",
>                             test_postcopy_preempt_recovery);
> -        migration_test_add("/migration/postcopy/recovery/double-failures",
> -                           test_postcopy_recovery_double_fail);
> -        migration_test_add("/migration/postcopy/recovery/channel-reconnect",
> -                           test_postcopy_recovery_channel_reconnect);
> +        migration_test_add("/migration/postcopy/recovery/double-failures/handshake",
> +                           test_postcopy_recovery_fail_handshake);
> +        migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
> +                           test_postcopy_recovery_fail_reconnect);
>          if (is_x86) {
>              migration_test_add("/migration/postcopy/suspend",
>                                 test_postcopy_suspend);
> -- 
> 2.45.0

LGTM

