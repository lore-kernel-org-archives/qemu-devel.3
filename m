Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1F4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh6yd-0002rE-Oq; Thu, 22 Aug 2024 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6yb-0002qk-M9
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:31:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6yZ-0006Ab-Mv
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:31:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDFFF201C8;
 Thu, 22 Aug 2024 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDHsvXDms2wctGB2h6V4k5uypGDiP3eboc/xhihtyuA=;
 b=OOSvFXkxj+yFWACXpQsR056VA6TVZLcw9l99WwPPd7BfqhRIhAL2BuDUoETQTl5rji/hNT
 6ba7MbGofjRnvTIllglBA6bGOkfggk3QPJixpf+9MPbZyRv6v0y33xq3K1ywUGYpTTq0RF
 MZxerZ7VXrs3/4uqvlnEcbE8+VYV5Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDHsvXDms2wctGB2h6V4k5uypGDiP3eboc/xhihtyuA=;
 b=3EMnENEUNBA6tQajaFHbtvruAzPW8B4VfoYmitaSRIgaigZhu2D8NWiZTo2nylkKxi12uu
 afmBJHDk+x2SD9BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDHsvXDms2wctGB2h6V4k5uypGDiP3eboc/xhihtyuA=;
 b=i+NAOW1Awj8cd0WFAQ+veqE8xdMo8JG/wiFiY1w90AjeWAkQkgIVcxieWu+6GrMKmHyS0a
 1bs/mT4wIf1RqNuJssBq4ZiVjpHcmBxfmNnIeFTnsUMQ5XHDplkgwX7wyGXUDWrl6b3tmM
 tIhtRZHeviFebsNPwTNnJwl2dYyWJ9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDHsvXDms2wctGB2h6V4k5uypGDiP3eboc/xhihtyuA=;
 b=RoYXerHvat2iL9YT6jX2u07xF/n6fakfnxA+oIUtR3hrWRBi9kbVq7nJuKJCUVjktWOByG
 2/m4fb/J0hlMpaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A2D9139D3;
 Thu, 22 Aug 2024 12:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AxZiCKkvx2YqOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 12:31:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 9/9] tests/qtest/migration-test: Don't leak
 QTestState in test_multifd_tcp_cancel()
In-Reply-To: <20240820144912.320744-10-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-10-peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 09:31:34 -0300
Message-ID: <87ikvszql5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email,
 suse.de:email, suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In test_multifd_tcp_cancel() we create three QEMU processes: 'from',
> 'to' and 'to2'.  We clean up (via qtest_quit()) 'from' and 'to2' when
> we call test_migrate_end(), but never clean up 'to', which results in
> this leak:
>
> Direct leak of 336 byte(s) in 1 object(s) allocated from:
>     #0 0x55e984fcd328 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f328) (BuildId: 710d409b68bb04427009e9ca6e1b63ff8af785d3)
>     #1 0x7f0878b39c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x55e98503a172 in qtest_spawn_qemu tests/qtest/libqtest.c:397:21
>     #3 0x55e98502bc4a in qtest_init_internal tests/qtest/libqtest.c:471:9
>     #4 0x55e98502c5b7 in qtest_init_with_env tests/qtest/libqtest.c:533:21
>     #5 0x55e9850eef0f in test_migrate_start tests/qtest/migration-test.c:857:11
>     #6 0x55e9850eb01d in test_multifd_tcp_cancel tests/qtest/migration-test.c:3297:9
>     #7 0x55e985103407 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5
>
> Call qtest_quit() on 'to' to clean it up once it has exited.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/migration-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 04122120987..169ef0209c7 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3322,6 +3322,7 @@ static void test_multifd_tcp_cancel(void)
>      /* Make sure QEMU process "to" exited */
>      qtest_set_expected_status(to, EXIT_FAILURE);
>      qtest_wait_qemu(to);
> +    qtest_quit(to);
>  
>      args = (MigrateStart){
>          .only_target = true,

Reviewed-by: Fabiano Rosas <farosas@suse.de>

