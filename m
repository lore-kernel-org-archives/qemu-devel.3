Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22307C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh6uS-00022i-ST; Thu, 22 Aug 2024 08:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6uQ-00021k-Hc
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:27:22 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6uK-0005TV-M2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:27:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 08A6F201C3;
 Thu, 22 Aug 2024 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLZeJhYM6VwYhPGAJ7xa0heW4lOkGjwEa7GHjjzWNHI=;
 b=O/WcjB7q9fCPGDuulFq6/IABxiDPu0KlYUKPAyOya7epjApXhfnOGjiKtnQXMuWGofSVxv
 U06Ynnb27In+m1HXC+0qcUXbcB+g+nx8s6C9ValEGtGDiMVGH2Bgej8rvCCNobH+M6Ofu0
 yHqS12SHBhVqBpFYeh08UIH+pZ0gv9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLZeJhYM6VwYhPGAJ7xa0heW4lOkGjwEa7GHjjzWNHI=;
 b=m/BYXz/IqusX64D4VdzUbt3dpu+PflCnwp1pIJxgIIv6VrT9GQeU2aZDdtrchdPpXLGkIx
 p+btBz4a7kufrDBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLZeJhYM6VwYhPGAJ7xa0heW4lOkGjwEa7GHjjzWNHI=;
 b=O/WcjB7q9fCPGDuulFq6/IABxiDPu0KlYUKPAyOya7epjApXhfnOGjiKtnQXMuWGofSVxv
 U06Ynnb27In+m1HXC+0qcUXbcB+g+nx8s6C9ValEGtGDiMVGH2Bgej8rvCCNobH+M6Ofu0
 yHqS12SHBhVqBpFYeh08UIH+pZ0gv9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLZeJhYM6VwYhPGAJ7xa0heW4lOkGjwEa7GHjjzWNHI=;
 b=m/BYXz/IqusX64D4VdzUbt3dpu+PflCnwp1pIJxgIIv6VrT9GQeU2aZDdtrchdPpXLGkIx
 p+btBz4a7kufrDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83B9B139D3;
 Thu, 22 Aug 2024 12:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EScJEpMux2ZyOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 12:26:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 7/9] tests/qtest/migration-helpers: Don't dup
 argument to qdict_put_str()
In-Reply-To: <20240820144912.320744-8-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-8-peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 09:26:56 -0300
Message-ID: <87o75kzqsv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In migrate_set_ports() we call qdict_put_str() with a value string
> which we g_strdup(). However qdict_put_str() takes a copy of the
> value string, it doesn't take ownership of it, so the g_strdup()
> only results in a leak:
>
> Direct leak of 6 byte(s) in 1 object(s) allocated from:
>     #0 0x56298023713e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: b2b9174a5a54707a7f76bca51cdc95d2aa08bac1)
>     #1 0x7fba0ad39738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
>     #2 0x7fba0ad4e583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
>     #3 0x56298036b16e in migrate_set_ports tests/qtest/migration-helpers.c:145:49
>     #4 0x56298036ad1c in migrate_qmp tests/qtest/migration-helpers.c:228:9
>     #5 0x56298035b3dd in test_precopy_common tests/qtest/migration-test.c:1820:5
>     #6 0x5629803549dc in test_multifd_tcp_channels_none tests/qtest/migration-test.c:3077:5
>     #7 0x56298036d427 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5
>
> Drop the unnecessary g_strdup() call.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/migration-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 7cbb9831e76..a43d180c807 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -142,7 +142,7 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
>              qdict_haskey(addr, "port") &&
>              (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
>                  addr_port = qdict_get_str(addr, "port");
> -                qdict_put_str(addrdict, "port", g_strdup(addr_port));
> +                qdict_put_str(addrdict, "port", addr_port);
>          }
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

