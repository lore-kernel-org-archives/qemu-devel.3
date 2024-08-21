Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A9C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgsSm-0000qH-N8; Wed, 21 Aug 2024 17:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgsSl-0000ki-Cc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:01:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgsSg-0001rh-Fz
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:01:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27E601FB65;
 Wed, 21 Aug 2024 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724274105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nbrVwELI4pnk0nyGkn1XgL6ZXwrViw45b5mthBpknXc=;
 b=MUDjLcJwYtm+7uGHuPnHN0M7Qi1Yb2rKc0KB3dKNPiwFcg1wsJpLCH3MWk0kPoq28tRh5H
 JGwPnwuupOuDEy+BOxxqmy1ZCNqRPddpi3PCOhlSWgm4TSIASkYok1sMbA4C/KFvLp/Dsc
 obxtsFZ59vC+Xkk79TGVDi5W7L10PRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724274105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nbrVwELI4pnk0nyGkn1XgL6ZXwrViw45b5mthBpknXc=;
 b=Tw9YlTMSAvuICnaE+29QtBKPyTVe/Q9hYt+tg9zql5WGmox6UBw3BnBxJyhMAmzexjBuQh
 TIR4r6YKGFI64nAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724274105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nbrVwELI4pnk0nyGkn1XgL6ZXwrViw45b5mthBpknXc=;
 b=MUDjLcJwYtm+7uGHuPnHN0M7Qi1Yb2rKc0KB3dKNPiwFcg1wsJpLCH3MWk0kPoq28tRh5H
 JGwPnwuupOuDEy+BOxxqmy1ZCNqRPddpi3PCOhlSWgm4TSIASkYok1sMbA4C/KFvLp/Dsc
 obxtsFZ59vC+Xkk79TGVDi5W7L10PRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724274105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nbrVwELI4pnk0nyGkn1XgL6ZXwrViw45b5mthBpknXc=;
 b=Tw9YlTMSAvuICnaE+29QtBKPyTVe/Q9hYt+tg9zql5WGmox6UBw3BnBxJyhMAmzexjBuQh
 TIR4r6YKGFI64nAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A714713770;
 Wed, 21 Aug 2024 21:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cOiAG7hVxmamKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Aug 2024 21:01:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 2/9] tests/qtest/migration-test: Don't leak resp
 in multifd_mapped_ram_fdset_end()
In-Reply-To: <20240820144912.320744-3-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-3-peter.maydell@linaro.org>
Date: Wed, 21 Aug 2024 18:01:42 -0300
Message-ID: <87wmk9zj2h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001,
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

> In multifd_mapped_ram_fdset_end() we call qtest_qmp() but forgot
> to unref the response QDict we get back, which means it is leaked:
>
> Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
>     #0 0x55c0c095d318 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f318) (BuildI
> d: 07f667506452d6c467dbc06fd95191966d3e91b4)
>     #1 0x7f186f939c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x55c0c0ae9b01 in qdict_new qobject/qdict.c:30:13
>     #3 0x55c0c0afc16c in parse_object qobject/json-parser.c:317:12
>     #4 0x55c0c0afb90f in parse_value qobject/json-parser.c:545:16
>     #5 0x55c0c0afb579 in json_parser_parse qobject/json-parser.c:579:14
>     #6 0x55c0c0afa21d in json_message_process_token qobject/json-streamer.c:92:12
>     #7 0x55c0c0bca2e5 in json_lexer_feed_char qobject/json-lexer.c:313:13
>     #8 0x55c0c0bc97ce in json_lexer_feed qobject/json-lexer.c:350:9
>     #9 0x55c0c0afabbc in json_message_parser_feed qobject/json-streamer.c:121:5
>     #10 0x55c0c09cbd52 in qmp_fd_receive tests/qtest/libqmp.c:86:9
>     #11 0x55c0c09be69b in qtest_qmp_receive_dict tests/qtest/libqtest.c:760:12
>     #12 0x55c0c09bca77 in qtest_qmp_receive tests/qtest/libqtest.c:741:27
>     #13 0x55c0c09bee9d in qtest_vqmp tests/qtest/libqtest.c:812:12
>     #14 0x55c0c09bd257 in qtest_qmp tests/qtest/libqtest.c:835:16
>     #15 0x55c0c0a87747 in multifd_mapped_ram_fdset_end tests/qtest/migration-test.c:2393:12
>     #16 0x55c0c0a85eb3 in test_file_common tests/qtest/migration-test.c:1978:9
>     #17 0x55c0c0a746a3 in test_multifd_file_mapped_ram_fdset tests/qtest/migration-test.c:2437:5
>     #18 0x55c0c0a93237 in migration_test_wrapper tests/qtest/migration-helpers.c:458:5
>     #19 0x7f186f958aed in test_case_run debian/build/deb/../../../glib/gtestutils.c:2930:15
>     #20 0x7f186f958aed in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3018:16
>     #21 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
>     #22 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
>     #23 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
>     #24 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
>     #25 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
>     #26 0x7f186f958faa in g_test_run_suite debian/build/deb/../../../glib/gtestutils.c:3109:18
>     #27 0x7f186f959055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2231:7
>     #28 0x7f186f959055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2218:1
>     #29 0x55c0c0a6e427 in main tests/qtest/migration-test.c:4033:11
>
> Unref the object after we've confirmed that it is what we expect.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/migration-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 5cf238a4f05..6aba527340b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2395,6 +2395,7 @@ static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
>      g_assert(qdict_haskey(resp, "return"));
>      fdsets = qdict_get_qlist(resp, "return");
>      g_assert(fdsets && qlist_empty(fdsets));
> +    qobject_unref(resp);
>  }
>  
>  static void *multifd_mapped_ram_fdset_dio(QTestState *from, QTestState *to)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

