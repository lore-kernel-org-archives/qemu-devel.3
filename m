Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC7AC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh6us-0002WJ-Nf; Thu, 22 Aug 2024 08:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6ug-0002LD-Vo
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:27:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh6ue-0005Yw-TL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:27:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 797F0201C3;
 Thu, 22 Aug 2024 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aI3uhV02stPZw1TVHSJO5G0pLLFsNilI/WeErVW4Jv4=;
 b=zQ/IkRSvh10xPwi66t/hcvh0oRfSgwlqL2vOBbR6eDwYk+Tk62fy03lBgUpu15Jrje5vpc
 7bRRTQwZ1vB8dmjyfL/F3KL8ihBshYESwEZI9m782TB0rG09eE4XFYq2c33D8jLodrMKdG
 mkB7/4cwYHVHNsLdSMBi3X5tUlM2FrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aI3uhV02stPZw1TVHSJO5G0pLLFsNilI/WeErVW4Jv4=;
 b=B7yIRGcRyT5aOSUqThqqW+9l9xkjqvx6HI1bgId1Xbdk3mBGMeIORzlOHOf1xVVmhpS6JL
 WAFMqXqQ7P2wT6AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zQ/IkRSv";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B7yIRGcR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724329653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aI3uhV02stPZw1TVHSJO5G0pLLFsNilI/WeErVW4Jv4=;
 b=zQ/IkRSvh10xPwi66t/hcvh0oRfSgwlqL2vOBbR6eDwYk+Tk62fy03lBgUpu15Jrje5vpc
 7bRRTQwZ1vB8dmjyfL/F3KL8ihBshYESwEZI9m782TB0rG09eE4XFYq2c33D8jLodrMKdG
 mkB7/4cwYHVHNsLdSMBi3X5tUlM2FrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724329653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aI3uhV02stPZw1TVHSJO5G0pLLFsNilI/WeErVW4Jv4=;
 b=B7yIRGcRyT5aOSUqThqqW+9l9xkjqvx6HI1bgId1Xbdk3mBGMeIORzlOHOf1xVVmhpS6JL
 WAFMqXqQ7P2wT6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDD36139D3;
 Thu, 22 Aug 2024 12:27:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id anGHLLQux2alOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 12:27:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 8/9] tests/qtest/migration-test: Don't strdup in
 get_dirty_rate()
In-Reply-To: <20240820144912.320744-9-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-9-peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 09:27:30 -0300
Message-ID: <87le0ozqrx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 797F0201C3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> We g_strdup() the "status" string we get out of the qdict in
> get_dirty_rate(), but we never free it.  Since we only use this
> string while the dictionary is still valid, we don't need to strdup
> at all; drop the unnecessary call to avoid this leak:
>
> Direct leak of 18 byte(s) in 2 object(s) allocated from:
>     #0 0x564b3e01913e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: d6403a811332fcc846f93c45e23abfd06d1e67c4)
>     #1 0x7f2f278ff738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
>     #2 0x7f2f27914583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
>     #3 0x564b3e14bb5b in get_dirty_rate tests/qtest/migration-test.c:3447:14
>     #4 0x564b3e138e00 in test_vcpu_dirty_limit tests/qtest/migration-test.c:3565:16
>     #5 0x564b3e14f417 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/migration-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index a659609ccb0..04122120987 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3435,7 +3435,7 @@ static void wait_for_calc_dirtyrate_complete(QTestState *who,
>  static int64_t get_dirty_rate(QTestState *who)
>  {
>      QDict *rsp_return;
> -    gchar *status;
> +    const char *status;
>      QList *rates;
>      const QListEntry *entry;
>      QDict *rate;
> @@ -3444,7 +3444,7 @@ static int64_t get_dirty_rate(QTestState *who)
>      rsp_return = query_dirty_rate(who);
>      g_assert(rsp_return);
>  
> -    status = g_strdup(qdict_get_str(rsp_return, "status"));
> +    status = qdict_get_str(rsp_return, "status");
>      g_assert(status);
>      g_assert_cmpstr(status, ==, "measured");

Reviewed-by: Fabiano Rosas <farosas@suse.de>

